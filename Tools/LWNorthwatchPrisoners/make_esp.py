"""Builds LWNorthwatchPrisoners.esp: the three Northwatch Keep prisoners stop respawning, and the Breton woman
is named Elyse Marrow.

Usage:  python -I make_esp.py "<Data folder>" "<output .esp>"

Why: the prisoners (dunNorthwatchPrisoner01/02/03, bases 0xC1A9E, 0xC1A9F, 0xC1AA3; placed refs 0xC1A9C,
0xC1AA0, 0xC1AA4 in NorthwatchKeep01) are persistent refs, but their base records carry the Respawn flag.
When the keep's cell resets, a respawning actor is put back the way the editor placed her: in her cell,
asleep, however far she followed you. Clearing that one flag stops it. Nothing else changes: same name,
face, factions and packages, no quest touched, and Mantella's Follow works on them as on anyone.

The records are copied byte for byte from Skyrim.esm (decompressed) with only ACBS flag 0x08 cleared.
Skyrim.esm is localized; this plugin is not, so the name strings are written out as text.
Reads Skyrim.esm and Strings/Skyrim_English.STRINGS, writes only the output file.
"""
import struct, sys, zlib
from pathlib import Path

BASES = (0x000C1A9E, 0x000C1A9F, 0x000C1AA3)
RESPAWN = 0x08
# The Breton woman gets a name of her own (the user let us pick, 2026-11-12); the two men stay 'Northwatch Prisoner'.
NAMES = {0x000C1AA3: b'Elyse Marrow'}
LSTRINGS = {b'FULL', b'SHRT'}


def load_strings(path):
    d = Path(path).read_bytes()
    n, _ = struct.unpack_from('<II', d, 0)
    base, out = 8 + n * 8, {}
    for i in range(n):
        sid, off = struct.unpack_from('<II', d, 8 + i * 8)
        s = base + off
        out[sid] = d[s:d.index(b'\0', s)]
    return out


def find_records(d, want):
    found, i, end = {}, 0, len(d)
    stack = [(0, end)]
    while stack:
        i, end = stack.pop()
        while i < end:
            t = d[i:i+4]
            if t == b'GRUP':
                size = struct.unpack_from('<I', d, i+4)[0]
                label = d[i+8:i+12]
                gtype = struct.unpack_from('<i', d, i+12)[0]
                if gtype == 0 and label != b'NPC_':
                    i += size
                    continue
                stack.append((i + size, end))
                i, end = i + 24, i + size
                continue
            dsize, flags, fid = struct.unpack_from('<III', d, i+4)
            if t == b'NPC_' and fid in want:
                found[fid] = d[i:i+24+dsize]
            i += 24 + dsize
    return found


def subrecords(data):
    i, out = 0, []
    while i + 6 <= len(data):
        t = data[i:i+4]; size = struct.unpack_from('<H', data, i+4)[0]; i += 6
        if t == b'XXXX':
            raise ValueError('XXXX subrecord in an NPC record: not expected')
        out.append((t, data[i:i+size])); i += size
    return out


def pack_sub(t, v):
    if len(v) > 0xFFFF:
        raise ValueError('subrecord too large')
    return t + struct.pack('<H', len(v)) + v


def patch(fid, rec, strings, localized):
    hdr = bytearray(rec[:24])
    flags = struct.unpack_from('<I', hdr, 8)[0]
    body = rec[24:]
    if flags & 0x40000:
        body = zlib.decompress(body[4:])
        flags &= ~0x40000
    out, seen_acbs = [], False
    for t, v in subrecords(body):
        if t == b'ACBS':
            f = struct.unpack_from('<I', v)[0]
            v = struct.pack('<I', f & ~RESPAWN) + v[4:]
            print(f'  ACBS flags 0x{f:08X} -> 0x{f & ~RESPAWN:08X}')
            seen_acbs = True
        elif t == b'FULL' and fid in NAMES:
            v = NAMES[fid] + b'\0'
            print(f'  FULL = {NAMES[fid].decode()!r} (renamed)')
        elif localized and t in LSTRINGS and len(v) == 4:
            sid = struct.unpack('<I', v)[0]
            v = strings.get(sid, b'') + b'\0'
            print(f'  {t.decode()} = {v[:-1].decode("cp1252", "replace")!r}')
        out.append(pack_sub(t, v))
    if not seen_acbs:
        raise ValueError('no ACBS')
    body = b''.join(out)
    struct.pack_into('<II', hdr, 4, len(body), flags)
    return bytes(hdr) + body


def main(data_dir, out_path):
    data_dir = Path(data_dir)
    esm = (data_dir / 'Skyrim.esm').read_bytes()
    localized = bool(struct.unpack_from('<I', esm, 8)[0] & 0x80)
    strings = load_strings(data_dir / 'Strings' / 'Skyrim_English.STRINGS') if localized else {}
    recs = find_records(esm, set(BASES))
    missing = [f'0x{b:08X}' for b in BASES if b not in recs]
    if missing:
        raise SystemExit(f'not found in Skyrim.esm: {missing}')
    body = b''
    for fid in BASES:
        print(f'NPC_ 0x{fid:08X}')
        body += patch(fid, recs[fid], strings, localized)
    grup = b'GRUP' + struct.pack('<I', 24 + len(body)) + b'NPC_' + struct.pack('<iHHHH', 0, 0, 0, 0, 0) + body
    hedr = struct.pack('<fII', 1.7, len(BASES), 0x800)
    head = (pack_sub(b'HEDR', hedr)
            + pack_sub(b'CNAM', b'Living World\0')
            + pack_sub(b'SNAM', b'Northwatch Keep prisoners no longer respawn, so they can follow you out for good.\0')
            + pack_sub(b'MAST', b'Skyrim.esm\0') + pack_sub(b'DATA', b'\0' * 8)
            + pack_sub(b'INTV', struct.pack('<I', 1)))
    tes4 = b'TES4' + struct.pack('<IIIIHH', len(head), 0, 0, 0, 44, 0) + head
    Path(out_path).write_bytes(tes4 + grup)
    print('wrote', out_path, len(tes4) + len(grup), 'bytes')


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
