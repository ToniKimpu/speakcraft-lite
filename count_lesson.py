#!/usr/bin/env python3
"""Count Listening & Shadowing lesson content for the mobile "what you'll get"
banner.

The mobile app reads three precomputed numbers off the `listenings` row
(sentence_count / vocab_count / pattern_count) instead of fetching and parsing
~50 JSON files at runtime. This script computes them locally from a lesson's
folder so you can paste the numbers into the admin's create/edit dialog.

Two modes (auto-detected):
  * single  — folder has main_subtitle.json  -> prints the 3 numbers
  * batch   — folder holds many lesson subfolders -> prints a table

Usage:
    python count_lesson.py <lesson-folder>            # single
    python count_lesson.py <folder-of-lessons>        # batch (e.g. bunny_download/listenings)

Definitions:
    sentence_count = entries in main_subtitle.json
    vocab_count    = total `terms` across the explanation JSON files
    pattern_count  = explanation files carrying a non-empty `note`

The explanation files live in a subfolder whose name varies by pipeline
(Bunny uses `sentence_explanation_data`, the local export used
`sentence_explanation_jsons`) — both are detected.
"""

import json
import sys
from pathlib import Path

# Known names for the per-sentence explanation subfolder.
EXPLANATION_DIRS = ("sentence_explanation_data", "sentence_explanation_jsons")


def load_json(path: Path):
    with path.open(encoding="utf-8") as f:
        return json.load(f)


def find_explanation_dir(folder: Path) -> Path | None:
    for name in EXPLANATION_DIRS:
        candidate = folder / name
        if candidate.is_dir():
            return candidate
    return None


def count_lesson(folder: Path) -> dict:
    sentences = load_json(folder / "main_subtitle.json")
    sentence_count = len(sentences)

    vocab_count = 0
    pattern_count = 0
    bad_files = []
    expl_dir = find_explanation_dir(folder)
    if expl_dir is not None:
        for path in sorted(expl_dir.glob("*.json")):
            if path.name.startswith("__"):  # skip __template.json
                continue
            try:
                data = load_json(path)
            except json.JSONDecodeError:
                bad_files.append(path.name)  # malformed JSON — skip, report
                continue
            vocab_count += len(data.get("terms", []))
            if data.get("note"):
                pattern_count += 1

    return {
        "sentence_count": sentence_count,
        "vocab_count": vocab_count,
        "pattern_count": pattern_count,
        "bad_files": bad_files,
    }


def is_lesson(folder: Path) -> bool:
    return (folder / "main_subtitle.json").is_file()


def main() -> None:
    if len(sys.argv) != 2:
        sys.exit("usage: python count_lesson.py <lesson-folder | folder-of-lessons>")

    root = Path(sys.argv[1])
    if not root.is_dir():
        sys.exit(f"error: {root} is not a directory")

    # Single-lesson mode.
    if is_lesson(root):
        counts = count_lesson(root)
        print(f"sentence_count = {counts['sentence_count']}")
        print(f"vocab_count    = {counts['vocab_count']}")
        print(f"pattern_count  = {counts['pattern_count']}")
        if counts["bad_files"]:
            print(f"\n! {len(counts['bad_files'])} malformed JSON (skipped):")
            for name in counts["bad_files"]:
                print(f"    {name}")
        return

    # Batch mode: every immediate child that looks like a lesson.
    lessons = sorted(p for p in root.iterdir() if p.is_dir() and is_lesson(p))
    if not lessons:
        sys.exit(
            f"error: {root} has no main_subtitle.json and no lesson subfolders."
        )

    name_w = max(len(p.name) for p in lessons)
    header = f"{'lesson'.ljust(name_w)}  sentences  vocab  patterns  bad"
    print(header)
    print("-" * len(header))
    flagged = {}
    for lesson in lessons:
        try:
            c = count_lesson(lesson)
        except Exception as e:  # keep going; report the bad folder
            print(f"{lesson.name.ljust(name_w)}  ERROR: {e}")
            continue
        bad = c["bad_files"]
        if bad:
            flagged[lesson.name] = bad
        print(
            f"{lesson.name.ljust(name_w)}  "
            f"{str(c['sentence_count']).rjust(9)}  "
            f"{str(c['vocab_count']).rjust(5)}  "
            f"{str(c['pattern_count']).rjust(8)}  "
            f"{str(len(bad)).rjust(3)}"
        )

    if flagged:
        print("\nMalformed JSON (broken in the app too - fix & re-upload):")
        for name, bad in flagged.items():
            print(f"  {name}:")
            for b in bad:
                print(f"    {b}")


if __name__ == "__main__":
    main()
