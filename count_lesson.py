#!/usr/bin/env python3
"""Count a Listening & Shadowing lesson's content for the mobile "what you'll
get" banner.

The mobile app reads three precomputed numbers off the `listenings` row
(sentence_count / vocab_count / pattern_count) instead of fetching and parsing
~50 JSON files at runtime. This script computes them locally from the lesson's
finalize_jsons folder (where every file already lives) so you can paste the
numbers into the admin's create/edit-listening dialog.

Usage:
    python count_lesson.py <path-to-finalize_jsons-folder>

Example:
    python count_lesson.py grit_the_power_of_passion/finalize_jsons

Definitions:
    sentence_count = entries in main_subtitle.json
    vocab_count    = total `terms` across sentence_explanation_jsons/*.json
    pattern_count  = explanation files carrying a non-empty `note`
"""

import json
import sys
from pathlib import Path


def load_json(path: Path):
    with path.open(encoding="utf-8") as f:
        return json.load(f)


def count_lesson(folder: Path) -> dict:
    main_subtitle = folder / "main_subtitle.json"
    if not main_subtitle.exists():
        sys.exit(f"error: {main_subtitle} not found")

    sentences = load_json(main_subtitle)
    sentence_count = len(sentences)

    expl_dir = folder / "sentence_explanation_jsons"
    vocab_count = 0
    pattern_count = 0
    if expl_dir.is_dir():
        for path in sorted(expl_dir.glob("*.json")):
            if path.name.startswith("__"):  # skip __template.json
                continue
            data = load_json(path)
            vocab_count += len(data.get("terms", []))
            if data.get("note"):
                pattern_count += 1

    return {
        "sentence_count": sentence_count,
        "vocab_count": vocab_count,
        "pattern_count": pattern_count,
    }


def main() -> None:
    if len(sys.argv) != 2:
        sys.exit("usage: python count_lesson.py <path-to-finalize_jsons-folder>")

    folder = Path(sys.argv[1])
    if not folder.is_dir():
        sys.exit(f"error: {folder} is not a directory")

    counts = count_lesson(folder)
    print(f"sentence_count = {counts['sentence_count']}")
    print(f"vocab_count    = {counts['vocab_count']}")
    print(f"pattern_count  = {counts['pattern_count']}")


if __name__ == "__main__":
    main()
