#!/usr/bin/env python3
"""
Convert Day List HTML explanation files to structured JSON.

Usage:
    python tool/convert_html_to_json.py

Reads from: D:/PMP_Projects/data/Day List/
Outputs to: assets/day_list/day_XX/lesson_XX.json
"""

import json
import os
import re
import sys
from html.parser import HTMLParser
from pathlib import Path

DATA_DIR = Path("D:/PMP_Projects/data/Day List")
OUTPUT_DIR = Path("d:/PMP_Projects/pmp-english-mobile/assets/day_list")


class TextExtractor(HTMLParser):
    """Extract plain text from HTML, collapsing whitespace."""

    def __init__(self):
        super().__init__()
        self._parts = []
        self._skip = False

    def handle_starttag(self, tag, attrs):
        if tag in ("del", "s", "strike"):
            self._parts.append("~~")
        if tag == "br":
            self._parts.append("\n")

    def handle_endtag(self, tag):
        if tag in ("del", "s", "strike"):
            self._parts.append("~~")

    def handle_data(self, data):
        self._parts.append(data)

    def get_text(self):
        raw = "".join(self._parts)
        # Collapse runs of whitespace (but keep explicit newlines)
        lines = raw.split("\n")
        lines = [re.sub(r"[ \t]+", " ", line).strip() for line in lines]
        return "\n".join(line for line in lines if line).strip()


def html_to_text(html_str: str) -> str:
    ext = TextExtractor()
    ext.feed(html_str)
    return ext.get_text()


def parse_html_file(filepath: Path) -> dict:
    """Parse a single explanation HTML file into a structured dict."""
    content = filepath.read_text(encoding="utf-8")
    sections = []

    # --- Pattern (the h2 inside the first styled div) ---
    pattern_match = re.search(r"<h2[^>]*>(.*?)</h2>", content, re.DOTALL)
    pattern = html_to_text(pattern_match.group(1)) if pattern_match else filepath.stem

    # Split by h3 headers to find sections
    # First, extract the intro (text before first h3)
    first_h3 = re.search(r"<h3", content)
    if first_h3:
        pre_h3 = content[: first_h3.start()]
    else:
        pre_h3 = content

    # Intro: paragraphs after the h2 card but before first h3
    # Find paragraphs outside the pattern card
    intro_divs = re.findall(
        r"</div>\s*<div[^>]*>\s*<p[^>]*>(.*?)</p>\s*</div>",
        pre_h3,
        re.DOTALL,
    )
    if intro_divs:
        intro_text = html_to_text(intro_divs[0])
        if intro_text and "margin-bottom" not in intro_text:
            sections.append({"type": "intro", "text": intro_text})

    # --- Split content by h3 sections ---
    h3_pattern = re.compile(
        r"<h3[^>]*>(.*?)</h3>(.*?)(?=<h3|<div[^>]*border:\s*2px|$)",
        re.DOTALL,
    )
    for h3_match in h3_pattern.finditer(content):
        title = html_to_text(h3_match.group(1))
        body = h3_match.group(2)

        # Detect section type by content
        if _is_agreement_section(body):
            sections.append(_parse_agreement(title, body))
        elif _is_table_section(body):
            sections.append(_parse_table(title, body))
        elif _is_examples_section(title, body):
            sections.append(_parse_examples(title, body))
        elif _has_term_definitions(body):
            sections.append(_parse_explanation(title, body))
        else:
            # Generic note section
            text = html_to_text(body)
            if text:
                sections.append({"type": "note", "title": title, "text": text})

    # --- Practice section (bordered div with word list) ---
    practice = _parse_practice(content)
    if practice:
        sections.append(practice)

    # --- Tip / footer ---
    tip = _parse_tip(content)
    if tip:
        sections.append(tip)

    return {"pattern": pattern, "sections": sections}


def _is_agreement_section(body: str) -> bool:
    # Agreement sections have multiple flex divs with subject/verb pairs
    return (
        "flex:" in body
        and ("am</span>" in body or "want to" in body.lower() or "is</span>" in body)
        and body.count("<div") >= 2
    )


def _is_table_section(body: str) -> bool:
    return "<table" in body


def _is_examples_section(title: str, body: str) -> bool:
    keywords = ["နမူနာ", "example", "ဥပမာ"]
    return any(k in title.lower() or k in title for k in keywords)


def _has_term_definitions(body: str) -> bool:
    # Look for colored bold terms followed by definitions
    return body.count("<span") >= 2 and body.count("font-weight: bold") >= 2


def _parse_agreement(title: str, body: str) -> dict:
    groups = []
    # Find flex divs with subject/verb pairs
    div_pattern = re.compile(
        r"<div[^>]*flex[^>]*>(.*?)</div>", re.DOTALL
    )
    for div_match in div_pattern.finditer(body):
        inner = div_match.group(1)
        # Extract subject (in <b>) and verb (in <span>)
        subj_match = re.search(r"<b[^>]*>(.*?)</b>", inner, re.DOTALL)
        verb_match = re.search(r"<span[^>]*>(.*?)</span>", inner, re.DOTALL)
        if subj_match and verb_match:
            groups.append(
                {
                    "subjects": html_to_text(subj_match.group(1)),
                    "verb": html_to_text(verb_match.group(1)),
                }
            )

    footnote_match = re.search(r"<p[^>]*>\s*\*(.*?)</p>", body, re.DOTALL)
    footnote = html_to_text("*" + footnote_match.group(1)) if footnote_match else None

    # Note text before the flex divs
    note_match = re.search(r"<p[^>]*>((?!.*\*).*?)</p>", body, re.DOTALL)
    note = html_to_text(note_match.group(1)) if note_match else None

    result = {"type": "agreement", "groups": groups}
    if note:
        result["note"] = note
    if footnote:
        result["footnote"] = footnote
    return result


def _parse_table(title: str, body: str) -> dict:
    headers = []
    rows = []

    # Extract header cells
    header_row = re.search(r"<tr[^>]*>(.*?)</tr>", body, re.DOTALL)
    if header_row:
        for th in re.finditer(r"<th[^>]*>(.*?)</th>", header_row.group(1), re.DOTALL):
            headers.append(html_to_text(th.group(1)))

    # Extract data rows
    for tr in re.finditer(r"<tr[^>]*>(.*?)</tr>", body, re.DOTALL):
        cells = re.findall(r"<td[^>]*>(.*?)</td>", tr.group(1), re.DOTALL)
        if cells:
            rows.append([html_to_text(c) for c in cells])

    # Footnote below table
    footnote_match = re.search(r"</table>\s*<p[^>]*>(.*?)</p>", body, re.DOTALL)
    footnote = html_to_text(footnote_match.group(1)) if footnote_match else None

    result = {"type": "table", "title": title, "headers": headers, "rows": rows}
    if footnote:
        result["footnote"] = footnote
    return result


def _parse_examples(title: str, body: str) -> dict:
    items = []
    # Pattern: bold English sentence, then Burmese in span
    # Note: some HTML files have whitespace inside closing tags like </span\n  >
    example_pattern = re.compile(
        r"<b[^>]*>(.*?)</b\s*>\s*<br\s*/?>\s*<span[^>]*>(.*?)</span\s*>",
        re.DOTALL,
    )
    for m in example_pattern.finditer(body):
        eng = html_to_text(m.group(1))
        bur = html_to_text(m.group(2))
        # Strip leading number + dot
        eng = re.sub(r"^\d+\.\s*", "", eng)
        bur = bur.strip("()")
        items.append({"english": eng, "burmese": bur})

    return {"type": "examples", "title": title, "items": items}


def _parse_explanation(title: str, body: str) -> dict:
    items = []
    # Find spans with bold + definition text
    term_pattern = re.compile(
        r"<span[^>]*font-weight:\s*bold[^>]*>(.*?)</span\s*>\s*(.*?)(?=<span[^>]*font-weight|</div\s*>|</p\s*>|$)",
        re.DOTALL,
    )
    for m in term_pattern.finditer(body):
        term = html_to_text(m.group(1)).rstrip(":")
        defn = html_to_text(m.group(2))
        if term and defn:
            items.append({"term": term, "definition": defn})

    if not items:
        # Fallback: treat as note
        return {"type": "note", "title": title, "text": html_to_text(body)}
    return {"type": "explanation", "title": title, "items": items}


def _parse_practice(content: str) -> dict | None:
    # Practice sections are in bordered divs with word lists
    practice_match = re.search(
        r"<div[^>]*border:\s*2px[^>]*>(.*?)</div>\s*</div>",
        content,
        re.DOTALL,
    )
    if not practice_match:
        return None

    block = practice_match.group(1)
    title_match = re.search(r"<h3[^>]*>(.*?)</h3>", block, re.DOTALL)
    title = html_to_text(title_match.group(1)) if title_match else ""

    instr_match = re.search(r"<p[^>]*>(.*?)</p>", block, re.DOTALL)
    instruction = html_to_text(instr_match.group(1)) if instr_match else ""

    words = []
    word_divs = re.finditer(
        r"<span[^>]*font-weight:\s*bold[^>]*>(.*?)</span>\s*<span[^>]*>(.*?)</span>",
        block,
        re.DOTALL,
    )
    for w in word_divs:
        word = html_to_text(w.group(1))
        word = re.sub(r"^\d+\.\s*", "", word)
        translation = html_to_text(w.group(2)).strip("()")
        words.append({"word": word, "translation": translation})

    if not words:
        return None

    result = {"type": "practice", "title": title, "instruction": instruction, "words": words}

    # Example after the practice div
    example_match = re.search(
        r"</div>\s*</div>\s*<p[^>]*>.*?ဥပမာ[^<]*<br\s*/?>\s*(.*?)</p>",
        content,
        re.DOTALL,
    )
    if example_match:
        result["example"] = html_to_text(example_match.group(1))

    return result


def _parse_tip(content: str) -> dict | None:
    # Tip: last div with centered text, or last p with italic text
    # Look for "အလွယ်မှတ်" or dashed-border div at the end
    tip_patterns = [
        # Dashed border tip box
        r"<div[^>]*border:\s*1px\s*dashed[^>]*>(.*?)</div>",
        # Simple centered tip at bottom
        r"<div[^>]*border-top[^>]*>\s*<p[^>]*>(.*?)</p>\s*</div>\s*</body>",
    ]
    for pat in tip_patterns:
        m = re.search(pat, content, re.DOTALL)
        if m:
            text = html_to_text(m.group(1))
            if text and len(text) > 5:
                return {"type": "tip", "text": text}
    return None


def normalize_day_num(folder_name: str) -> str:
    """Day-1 -> day_01, Day-10 -> day_10"""
    num = re.search(r"\d+", folder_name)
    if num:
        return f"day_{int(num.group()):02d}"
    return folder_name


def normalize_lesson_num(folder_name: str) -> str:
    """lesson_01, lesson-01, lessoon-02 -> lesson_01"""
    num = re.search(r"\d+", folder_name)
    if num:
        return f"lesson_{int(num.group()):02d}"
    return folder_name


def main():
    if not DATA_DIR.exists():
        print(f"Data directory not found: {DATA_DIR}")
        sys.exit(1)

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    total_files = 0
    total_lessons = 0

    for day_folder in sorted(DATA_DIR.iterdir()):
        if not day_folder.is_dir() or not day_folder.name.startswith("Day-"):
            continue

        day_key = normalize_day_num(day_folder.name)
        day_out = OUTPUT_DIR / day_key
        day_out.mkdir(exist_ok=True)

        # Find explanations folder (inconsistent naming)
        exp_dir = None
        for name in ("explanations", "explanation"):
            candidate = day_folder / name
            if candidate.is_dir():
                exp_dir = candidate
                break
        if not exp_dir:
            print(f"  SKIP {day_folder.name}: no explanations folder")
            continue

        for lesson_folder in sorted(exp_dir.iterdir()):
            if not lesson_folder.is_dir():
                continue

            lesson_key = normalize_lesson_num(lesson_folder.name)
            html_files = sorted(lesson_folder.glob("*.html"))

            if not html_files:
                continue

            patterns = []
            for html_file in html_files:
                try:
                    parsed = parse_html_file(html_file)
                    patterns.append(parsed)
                    total_files += 1
                except Exception as e:
                    print(f"  ERROR parsing {html_file}: {e}")

            out_path = day_out / f"{lesson_key}.json"
            out_path.write_text(
                json.dumps(patterns, ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
            total_lessons += 1
            print(f"  {day_key}/{lesson_key}.json ({len(patterns)} patterns)")

    print(f"\nDone: {total_files} HTML files -> {total_lessons} JSON files")


if __name__ == "__main__":
    main()
