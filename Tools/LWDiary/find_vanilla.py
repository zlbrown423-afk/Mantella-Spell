"""Read-only: find, in Skyrim.esm, a journal book model for the diary and the table objects it can lie on.

Usage:  python find_vanilla.py "<Data folder>" "<output.json>"
Writes {"book_model": "Clutter\\Books\\....nif", "book": {...}, "tables": [{"form_key": "01ABCD:Skyrim.esm", ...}]}.
"book" is copied from one vanilla journal BOOK record so the diary looks like it in game: its world model, its
inventory art (the STAT shown when you inspect it in the inventory or read it), its keywords (SkyUI picks the
inventory icon from them) and its pick-up / put-down sounds.
build_yaml.ps1 runs it once and keeps the result in vanilla.json.
"""
import json
import re
import struct
import sys
import zlib
from pathlib import Path

TABLE = re.compile(r'(?<!s)table', re.I)   # not 'stable'
NOT_TABLE = re.compile(r'tablet|alchemy|enchant|smith|workbench|tanning|cook|sign|chair|bench|stool|grind|altar|'
                       r'map|cloth|marker|fx|rug|cart|collision|shelf|counter|candle', re.I)
JOURNAL = re.compile(r'journal', re.I)


def subs(data):
    i, big, out = 0, None, []
    while i + 6 <= len(data):
        t = data[i:i + 4].decode('ascii', 'replace')
        size = struct.unpack_from('<H', data, i + 4)[0]
        i += 6
        if t == 'XXXX':
            big = struct.unpack_from('<I', data, i)[0]
            i += size
            continue
        if big is not None:
            size, big = big, None
        out.append((t, data[i:i + size]))
        i += size
    return out


def fkey(raw):
    fid = struct.unpack_from('<I', raw, 0)[0] if len(raw) >= 4 else 0
    if not fid or fid >> 24 != 0:   # 0 = none; another master index cannot be named from Skyrim.esm alone
        return None
    return f'{fid & 0xFFFFFF:06X}:Skyrim.esm'


def book_info(edid, g):
    kwda = g.get('KWDA', b'')
    keywords = [k for k in (fkey(kwda[i:i + 4]) for i in range(0, len(kwda) - 3, 4)) if k]
    return {'edid': edid,
            'model': g.get('MODL', b'').rstrip(b'\0').decode('cp1252', 'replace'),
            'inventory_art': fkey(g.get('INAM', b'')),
            'keywords': keywords,
            'pickup_sound': fkey(g.get('YNAM', b'')),
            'putdown_sound': fkey(g.get('ZNAM', b''))}


def pick_journal(books):
    """The most used journal model among journal BOOKs that have inventory art, and one record that uses it."""
    journal = [b for b in books if JOURNAL.search(b['model'])] or [b for b in books if JOURNAL.search(b['edid'])]
    if not journal:
        return None
    with_art = [b for b in journal if b['inventory_art']] or journal
    counts = {}
    for b in with_art:
        counts[b['model']] = counts.get(b['model'], 0) + 1
    model = max(counts, key=counts.get)
    same = [b for b in with_art if b['model'] == model]
    return max(same, key=lambda b: (bool(b['pickup_sound']), len(b['keywords'])))


def walk(d, start, end, cb):
    i = start
    while i < end:
        if d[i:i + 4] == b'GRUP':
            size = struct.unpack_from('<I', d, i + 4)[0]
            walk(d, i + 24, i + size, cb)
            i += size
            continue
        rtype = d[i:i + 4].decode('ascii', 'replace')
        dsize, flags, fid = struct.unpack_from('<III', d, i + 4)
        cb(rtype, fid, flags, d, i + 24, dsize)
        i += 24 + dsize


def main(data_dir, out_path):
    d = (Path(data_dir) / 'Skyrim.esm').read_bytes()
    books, tables = [], []

    def cb(rtype, fid, flags, d, off, size):
        if rtype not in ('BOOK', 'STAT') or fid >> 24 != 0:
            return
        raw = d[off:off + size]
        if flags & 0x40000:
            raw = zlib.decompress(raw[4:])
        g = {}
        for t, v in subs(raw):
            g.setdefault(t, v)
        edid = g.get('EDID', b'').rstrip(b'\0').decode('cp1252', 'replace')
        model = g.get('MODL', b'').rstrip(b'\0').decode('cp1252', 'replace')
        if rtype == 'BOOK' and model:
            books.append(book_info(edid, g))
        elif rtype == 'STAT' and TABLE.search(edid) and not NOT_TABLE.search(edid):
            tables.append({'form_key': f'{fid & 0xFFFFFF:06X}:Skyrim.esm', 'edid': edid, 'model': model})

    walk(d, 0, len(d), cb)
    book = pick_journal(books) or (books[0] if books else None)
    book_model = book['model'] if book else ''
    result = {'book_model': book_model, 'book': book, 'tables': tables[:250]}
    Path(out_path).write_text(json.dumps(result, indent=1), encoding='utf-8')
    print('book:', json.dumps(book), '| tables:', len(tables))
    for t in tables[:250]:
        print('  ', t['form_key'], t['edid'])


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
