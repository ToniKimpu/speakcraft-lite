# Writing Units — local editor (Levels 1–3)

A small **dev-only** web tool to browse, preview, and edit the Writing module
content under `assets/writing/units/`. It is never bundled into the app.

## Run

From the project root:

```bash
python tools/writing_editor/server.py
```

Then open **http://127.0.0.1:8765** in your browser.

Stop it with `Ctrl+C` in the terminal.

> Needs Python 3 (standard library only — no pip installs). On Windows use
> `python`, on macOS/Linux you may need `python3`.

## What it does

- **Browse** — left sidebar, grouped by Level → Section → Unit. A green dot
  means `published: true`, grey means draft.
- **Preview** (right pane) — renders the unit the way the app teach page does:
  situation, use, form table, trap, examples, the resolved verb bank (verb ids
  looked up in the lexicon — unknown ids show in red), model paragraph, and the
  full exercise ladder. `{v}…{/v}` / `{t}…{/t}` highlight markup is rendered.
- **Edit (form)** — form fields for the commonly edited content: title,
  subtitle, situation/use/trap/model (EN + MM), the form-table rows, form note,
  examples, the verb bank + `verb_form`, and every exercise (prompt, options,
  answers, explanation, model answer, and the AI grading rubric). The preview
  updates live as you type.
- **Raw JSON** — full-document editor for anything the form doesn't cover
  (e.g. `blocks`). Click **Apply JSON** to validate and load it.
- **Save to file** — writes straight back to that unit's `.json` under
  `assets/writing/units/`. Only files listed in `index.json` can be written.

## Notes

- Saving **reformats** the file with standard 2-space JSON indentation
  (`ensure_ascii=False`, so Burmese stays readable). Content is unchanged —
  only whitespace/formatting is normalized.
- This tool does **not** edit `index.json` (unit order / sections / publish
  flags) or the lexicon. Edit those by hand for now.
- After editing, it's still worth running the project's JSON validation before
  committing.
