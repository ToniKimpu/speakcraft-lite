#!/usr/bin/env python3
"""Repair malformed sentence-explanation JSON: escape raw double-quotes that
appear inside string values (the author quoted English terms with " inside a
JSON string, which breaks parsing). One field per line; array/number/object
values are left untouched, and already-escaped \\" is protected.

Usage:
    python fix_explanation_json.py <root>   # default: bunny_download/listenings
"""

import glob
import json
import os
import re
import sys

# Scalar STRING value lines only: <indent>"key": "....."<optional comma> at EOL.
# After ': ' an object/array/number value starts with { [ or a digit, so those
# (e.g. "highlights": [...]) never match and stay untouched.
LINE = re.compile(r'^(\s*"[^"]*"\s*:\s*")(.*)("\s*,?)\s*$')


def repair_line(line: str) -> str:
    m = LINE.match(line)
    if not m:
        return line
    pre, body, post = m.group(1), m.group(2), m.group(3)
    fixed = re.sub(r'(?<!\\)"', r'\\"', body)  # escape raw inner quotes
    return pre + fixed + post


def repair_text(txt: str) -> str:
    nl = "\r\n" if "\r\n" in txt else "\n"
    return nl.join(repair_line(l) for l in txt.split(nl))


def main() -> None:
    root = sys.argv[1] if len(sys.argv) > 1 else "bunny_download/listenings"
    fixed, still_bad, scanned = [], [], 0

    for f in glob.glob(os.path.join(root, "**", "*.json"), recursive=True):
        scanned += 1
        txt = open(f, encoding="utf-8").read()
        try:
            json.loads(txt)
            continue  # already valid — leave it
        except json.JSONDecodeError:
            pass
        new = repair_text(txt)
        try:
            json.loads(new)
        except json.JSONDecodeError as e:
            still_bad.append((f, str(e)))
            continue
        with open(f, "w", encoding="utf-8", newline="") as out:
            out.write(new)
        fixed.append(f)

    norm = lambda p: os.path.relpath(p).replace(os.sep, "/")
    print(f"scanned {scanned} files")
    print(f"fixed   {len(fixed)}")
    for f in fixed:
        print("  +", norm(f))
    print(f"still broken {len(still_bad)}")
    for f, e in still_bad:
        print("  !", norm(f), "->", e)


if __name__ == "__main__":
    main()
