"""Convert Zendaya sentence_explanation HTML files to the app's JSON schema.

Source:  D:/PMP_Projects/data/Listening/73_questions_with_zendaya/finalize/sentence_explanation/final/*.html
Target:  D:/PMP_Projects/data/Listening/73_questions_with_zendaya/finalize/sentence_explanation_data/*.json

Target JSON shape (matches grit_the_power_of_passion/.../__template.json consumed by
lib/screens/listening_and_shadowing/widgets/sentence_explanation/*):

{
  "title": "...",
  "main": {"english": "...", "burmese": "", "highlights": ["..."]},
  "terms": [
    {"number": N, "kind": "...", "term": "...", "translation_my": "",
     "definition_my": "...", "examples": [{"english": "...", "burmese": "..."}]}
  ],
  "note": {"title_my": "...", "body_my": "..."}    # optional
}

Limitations (source HTML does not carry these fields):
  * main.burmese is left empty — the source has no Myanmar translation of the full sentence.
  * translation_my on each term is left empty — the source explains, not translates, terms.
  * Author should spot-check and fill those in manually.

Usage:
  python tool/convert_sentence_explanation_html_to_json.py
"""

from __future__ import annotations

import json
import re
import sys
from html.parser import HTMLParser
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

INPUT_DIR = Path(
    r"D:/PMP_Projects/data/Listening/73_questions_with_zendaya/finalize/sentence_explanation/final"
)
OUTPUT_DIR = Path(
    r"D:/PMP_Projects/data/Listening/73_questions_with_zendaya/finalize/sentence_explanation_data"
)


# --------------------------------------------------------------------------- #
# Tiny DOM                                                                    #
# --------------------------------------------------------------------------- #
VOID_TAGS = {"br", "hr", "img", "meta", "link", "input"}


class Node:
    __slots__ = ("tag", "attrs", "children", "parent")

    def __init__(self, tag: str, attrs=None):
        self.tag = tag
        self.attrs = dict(attrs or [])
        self.children: list = []
        self.parent: Node | None = None

    @property
    def style(self) -> str:
        return self.attrs.get("style", "").replace("\n", " ").replace("  ", " ")

    @property
    def cls(self) -> str:
        return self.attrs.get("class", "")

    def text(self) -> str:
        out = []
        for c in self.children:
            if isinstance(c, str):
                out.append(c)
            else:
                out.append(c.text())
        return _clean("".join(out))

    def iter_elements(self):
        for c in self.children:
            if isinstance(c, Node):
                yield c

    def descendants(self):
        for c in self.children:
            if isinstance(c, Node):
                yield c
                yield from c.descendants()


class DOMBuilder(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.root = Node("root")
        self.stack: list[Node] = [self.root]

    def handle_starttag(self, tag, attrs):
        if tag in VOID_TAGS:
            node = Node(tag, attrs)
            node.parent = self.stack[-1]
            self.stack[-1].children.append(node)
            return
        node = Node(tag, attrs)
        node.parent = self.stack[-1]
        self.stack[-1].children.append(node)
        self.stack.append(node)

    def handle_startendtag(self, tag, attrs):
        node = Node(tag, attrs)
        node.parent = self.stack[-1]
        self.stack[-1].children.append(node)

    def handle_endtag(self, tag):
        for i in range(len(self.stack) - 1, 0, -1):
            if self.stack[i].tag == tag:
                self.stack = self.stack[: i]
                return

    def handle_data(self, data):
        self.stack[-1].children.append(data)


# --------------------------------------------------------------------------- #
# Helpers                                                                     #
# --------------------------------------------------------------------------- #
_WS_RE = re.compile(r"\s+")
_SPACE_BEFORE_PUNCT_RE = re.compile(r"\s+([,.!?;:])")
_SPACE_INSIDE_PARENS_RE = re.compile(r"\(\s+|\s+\)")


def _clean(s: str) -> str:
    return _WS_RE.sub(" ", s).strip()


def _polish(s: str) -> str:
    """Final whitespace + punctuation polish on a user-visible string."""
    s = _clean(s)
    s = _SPACE_BEFORE_PUNCT_RE.sub(r"\1", s)
    s = _SPACE_INSIDE_PARENS_RE.sub(
        lambda m: "(" if m.group(0).startswith("(") else ")", s
    )
    # Collapse accidental doubled quotes at boundaries: ""x -> "x, x"" -> x"
    s = re.sub(r'""+', '"', s)
    return s


def _strip_quotes(s: str) -> str:
    """Strip a matched outer quote pair only when the string is *fully* wrapped.

    We refuse to strip when the interior contains unbalanced quotes of the same
    kind (prevents 'Plus" & "As well"' from becoming 'Plus" & "As well').
    """
    s = s.strip()
    pairs = [('"', '"'), ("'", "'"), ("“", "”"), ("‘", "’")]
    for left, right in pairs:
        if not (s.startswith(left) and s.endswith(right) and len(s) >= len(left) + len(right)):
            continue
        inner = s[len(left) : -len(right)]
        if left == right:
            # Must not contain the same quote internally.
            if left in inner:
                continue
        return inner.strip()
    return s


def _has_style(node: Node, needle: str) -> bool:
    return needle.replace(" ", "") in node.style.replace(" ", "")


# Classification helpers -----------------------------------------------------
GRAMMAR_POINT_MARK = "border-left:4pxsolid#ffcc00"
EXAMPLE_BG_MARKS = ("background-color:#1b4353", "background:#1b4353")
TIP_BG_MARK = "background:rgba(0,212,255,0.1)"
EXPLANATION_CLASS = "explanation"
FORMULA_CLASS = "formula-card"
MAIN_QUOTE_MARK = "font-style:italic;color:#ffd700"
HIGHLIGHT_MARK = "color:#ffcc00"
EN_COLOR_MARK = "color:#00d4ff"
MY_COLOR_MARKS = ("color:#e0e0e0", "color:#ffffff", "color:#fff")


def is_grammar_point(node: Node) -> bool:
    if node.tag != "div":
        return False
    return "grammar-point" in node.cls or _has_style(node, GRAMMAR_POINT_MARK)


def is_example(node: Node) -> bool:
    if node.tag != "div":
        return False
    if "example-item" in node.cls:
        return True
    return any(_has_style(node, m) for m in EXAMPLE_BG_MARKS)


def is_tip(node: Node) -> bool:
    if node.tag != "div":
        return False
    if "tip-box" in node.cls:
        return True
    return _has_style(node, TIP_BG_MARK)


def is_formula(node: Node) -> bool:
    return node.tag == "div" and FORMULA_CLASS in node.cls


def is_explanation_block(node: Node) -> bool:
    return node.tag == "div" and EXPLANATION_CLASS in node.cls


# --------------------------------------------------------------------------- #
# Extraction                                                                  #
# --------------------------------------------------------------------------- #
KIND_MAP = {
    "grammar": "Grammar Pattern",
    "phrase": "Phrase",
    "phrasal verb": "Phrasal Verb",
    "idiom": "Idiom",
    "noun": "Noun",
    "verb": "Verb",
    "adjective": "Adjective",
    "adjectives": "Adjective",
    "adverb": "Adverb",
    "adverbs": "Adverb",
    "pronoun": "Pronoun",
    "preposition": "Preposition",
    "conjunction": "Conjunction",
    "key adjectives": "Adjective",
    "intensity": "Adverb",
    "adding information": "Phrase",
    "comparison": "Comparison",
    "transition": "Transition",
    "context": "Context",
    "concept": "Concept",
    "structure": "Structure",
    "question structure": "Question Structure",
    "emphatic structure": "Emphatic Structure",
    "rhetorical style": "Rhetorical Style",
    "logical connection": "Logical Connection",
    "proper noun": "Proper Noun",
    "noun phrase": "Noun Phrase",
    "verb phrase": "Verb Phrase",
    "adverbial phrase": "Adverbial Phrase",
}


def parse_grammar_heading(text: str) -> tuple[int | None, str, str]:
    """From '1. Adverb: "Probably" (…)'  ->  (1, 'Adverb', '"Probably" (…)').

    Falls back to (None, '', text) if no recognised shape.
    """
    t = _clean(text)
    num = None
    m = re.match(r"^(\d+)[.)]\s*(.+)$", t)
    if m:
        num = int(m.group(1))
        t = m.group(2).strip()
    # Now t looks like "Kind: term" or just "Kind" or "Kind (term)".
    if ":" in t:
        kind_raw, term = t.split(":", 1)
        return num, kind_raw.strip(), term.strip()
    return num, "", t


def normalise_kind(raw: str) -> str:
    key = raw.lower().strip()
    if key in KIND_MAP:
        return KIND_MAP[key]
    # Try first-word fallback: "Grammar Pattern" -> "grammar"
    first = key.split()[0] if key.split() else ""
    if first in KIND_MAP:
        return KIND_MAP[first]
    # Title-case whatever we got; blank goes to generic Term.
    return raw.strip().title() if raw.strip() else "Term"


def extract_example_rows(example_div: Node) -> list[dict[str, str]]:
    """An example-item div may carry multiple en/my pairs.

    Strategy: walk top-level spans.
      * spans that look English (color:#00d4ff OR class='en') become the 'english' line
      * spans that look Myanmar (colour in MY_COLOR_MARKS OR class='my') become the 'burmese' line
      * pair each English with the following Myanmar (if any); otherwise leave burmese empty.
    """
    spans = [c for c in example_div.iter_elements() if c.tag == "span"]
    rows: list[dict[str, str]] = []
    current_en: str | None = None
    for span in spans:
        if "en" in span.cls.split() or _has_style(span, EN_COLOR_MARK):
            if current_en is not None:
                rows.append({"english": _strip_quotes(current_en), "burmese": ""})
            current_en = span.text()
        elif "my" in span.cls.split() or any(_has_style(span, m) for m in MY_COLOR_MARKS):
            my = span.text()
            if current_en is not None:
                rows.append({"english": _strip_quotes(current_en), "burmese": my})
                current_en = None
            else:
                # Orphaned Myanmar line — append as a note row.
                rows.append({"english": "", "burmese": my})
    if current_en is not None:
        rows.append({"english": _strip_quotes(current_en), "burmese": ""})
    # Drop fully empty rows.
    rows = [r for r in rows if r["english"] or r["burmese"]]
    return rows


def extract_highlights(example_div: Node) -> list[str]:
    """Inner spans styled with the gold highlight colour."""
    out: list[str] = []
    for d in example_div.descendants():
        if d.tag == "span" and (
            "highlight" in d.cls.split() or _has_style(d, HIGHLIGHT_MARK)
        ):
            txt = _clean(d.text()).strip(":")
            if txt:
                out.append(_strip_quotes(txt))
    return out


def body_container(root: Node) -> Node:
    """Return the outer 'container' div (or body if none)."""
    body = None
    for d in root.descendants():
        if d.tag == "body":
            body = d
            break
    if body is None:
        body = root
    # Prefer a child div with class 'container', otherwise the body itself.
    for c in body.iter_elements():
        if c.tag == "div" and "container" in c.cls:
            return c
    return body


def blocks_of(container: Node) -> list[Node]:
    """Top-level children that carry meaning (divs + p + h2)."""
    return [
        c
        for c in container.iter_elements()
        if c.tag in {"div", "p", "h2", "h3"} and _clean(c.text()) != ""
    ]


# --------------------------------------------------------------------------- #
# Per-file conversion                                                         #
# --------------------------------------------------------------------------- #
def convert(html: str, filename: str) -> dict:
    builder = DOMBuilder()
    builder.feed(html)
    container = body_container(builder.root)

    title = ""
    main_english = ""
    main_highlights: list[str] = []
    note: dict[str, str] | None = None

    # Phase 1 — grab title (h2), the italic quote, formula, explanation, tip.
    formula_text = ""
    explanation_text = ""
    for blk in blocks_of(container):
        if blk.tag == "h2" and not title:
            t = _clean(blk.text())
            # Strip leading "Grammar Focus: " if present.
            t = re.sub(r"^(?i:grammar focus)\s*:\s*", "", t).strip()
            title = _strip_quotes(t)
        elif blk.tag == "p" and not main_english and _has_style(blk, MAIN_QUOTE_MARK):
            main_english = _strip_quotes(blk.text())
        elif is_formula(blk):
            formula_text = _clean(blk.text())
            if not main_english:
                main_english = _strip_quotes(formula_text)
        elif is_explanation_block(blk):
            explanation_text = blk.text()
        elif is_tip(blk):
            body = blk.text()
            body = re.sub(r"^\s*(?:💡\s*)?", "", body)
            # Drop leading "… Insight:" / "… Tip:" labels.
            body = re.sub(r"^[^:]{0,40}:\s*", "", body, count=1)
            note = {
                "title_my": "စကားပြောမှတ်ချက်",
                "body_my": _clean(body),
            }

    # Fallback main.english — derive from filename if nothing else.
    if not main_english:
        stem = Path(filename).stem.replace("_", " ").strip()
        main_english = stem[:1].upper() + stem[1:]

    # Phase 2 — build terms.
    terms: list[dict] = []
    current: dict | None = None
    current_number = 0

    # Type-1 (Grammar Focus) handling: if there was a formula card but NO grammar-point
    # headings anywhere in the body, synthesise a single term from formula + explanation.
    has_grammar_point = any(is_grammar_point(b) for b in blocks_of(container))

    if not has_grammar_point and formula_text:
        current_number += 1
        current = {
            "number": current_number,
            "kind": "Grammar Pattern",
            "term": formula_text,
            "translation_my": "",
            "definition_my": _clean(explanation_text),
            "examples": [],
        }
        terms.append(current)

    # Walk blocks in order, attach example-items to the current term.
    for blk in blocks_of(container):
        if is_grammar_point(blk):
            num, kind_raw, term_text = parse_grammar_heading(blk.text())
            current_number = num if num is not None else current_number + 1
            current = {
                "number": current_number,
                "kind": normalise_kind(kind_raw),
                "term": _strip_quotes(term_text),
                "translation_my": "",
                "definition_my": "",
                "examples": [],
            }
            terms.append(current)
        elif blk.tag == "p" and current is not None and not current["definition_my"]:
            # First paragraph after a grammar-point is the Myanmar definition.
            txt = _clean(blk.text())
            if txt:
                current["definition_my"] = txt
        elif is_example(blk):
            rows = extract_example_rows(blk)
            if current is None:
                # Examples before any grammar-point and no formula: create a generic term.
                current_number += 1
                current = {
                    "number": current_number,
                    "kind": "Phrase",
                    "term": _strip_quotes(title) if title else "Key expressions",
                    "translation_my": "",
                    "definition_my": _clean(explanation_text),
                    "examples": [],
                }
                terms.append(current)
            current["examples"].extend(rows)
            # Highlights — collect from examples into main.highlights (dedup, in order).
            for h in extract_highlights(blk):
                if h and h not in main_highlights and len(main_highlights) < 4:
                    main_highlights.append(h)

    # Final polish pass on every string.
    for t in terms:
        t["term"] = _polish(t["term"])
        t["definition_my"] = _polish(t["definition_my"])
        for ex in t["examples"]:
            ex["english"] = _polish(ex["english"])
            ex["burmese"] = _polish(ex["burmese"])

    main_highlights = [_polish(h) for h in main_highlights]

    doc = {
        "title": _polish(title or "Explanation"),
        "main": {
            "english": _polish(main_english),
            "burmese": "",
            "highlights": main_highlights,
        },
        "terms": terms,
    }
    if note and note["body_my"]:
        note["body_my"] = _polish(note["body_my"])
        doc["note"] = note
    return doc


# --------------------------------------------------------------------------- #
# Driver                                                                      #
# --------------------------------------------------------------------------- #
def main() -> int:
    if not INPUT_DIR.is_dir():
        print(f"Input dir not found: {INPUT_DIR}")
        return 1
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    html_files = sorted(INPUT_DIR.glob("*.html"))
    if not html_files:
        print("No .html files to convert.")
        return 0

    ok = 0
    skipped: list[tuple[str, str]] = []
    for src in html_files:
        try:
            html = src.read_text(encoding="utf-8")
            doc = convert(html, src.name)
            dst = OUTPUT_DIR / (src.stem + ".json")
            dst.write_text(
                json.dumps(doc, ensure_ascii=False, indent=2) + "\n",
                encoding="utf-8",
            )
            ok += 1
        except Exception as exc:  # noqa: BLE001 — keep the batch going.
            skipped.append((src.name, f"{type(exc).__name__}: {exc}"))

    print(f"Converted {ok}/{len(html_files)} → {OUTPUT_DIR}")
    if skipped:
        print(f"Skipped {len(skipped)}:")
        for name, reason in skipped:
            print(f"  - {name}: {reason}")
    return 0 if not skipped else 2


if __name__ == "__main__":
    raise SystemExit(main())
