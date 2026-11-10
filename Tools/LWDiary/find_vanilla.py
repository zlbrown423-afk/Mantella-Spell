"""Read-only: find, in Skyrim.esm, a journal book model for the diary and the table objects it can lie on.

Usage:  python find_vanilla.py "<Data folder>" "<output.json>"
Writes {"book_model": "Clutter\\Books\\....nif", "tables": [{"form_key": "01ABCD:Skyrim.esm", "edid": ...}]}.
build_yaml.ps1 runs it once and keeps the result in vanilla.json.
"""
import json
import re
import struct
import sys
import zlib
from pathlib import Path

TABLE = re.compile(r'table', re.I)
NOT_TABLE = re.compile(r'tablet|alchemy|enchant|smith|workbench|tanning|cook|sign|chair|bench|stool|grind|altar|'
                       r'map|cloth|marker|fx|rug|cart|collision|shelf|counter', re.I)
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
            books.append((edid, model))
        elif rtype == 'STAT' and TABLE.search(edid) and not NOT_TABLE.search(edid):
            tables.append({'form_key': f'{fid & 0xFFFFFF:06X}:Skyrim.esm', 'edid': edid, 'model': model})

    walk(d, 0, len(d), cb)
    journal = [m for e, m in books if JOURNAL.search(m)] or [m for e, m in books if JOURNAL.search(e)]
    counts = {}
    for m in journal:
        counts[m] = counts.get(m, 0) + 1
    book_model = max(counts, key=counts.get) if counts else (books[0][1] if books else '')
    result = {'book_model': book_model, 'tables': tables[:250]}
    Path(out_path).write_text(json.dumps(result, indent=1), encoding='utf-8')
    print('book model:', book_model, '| tables:', len(tables))
    for t in tables[:250]:
        print('  ', t['form_key'], t['edid'])


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
