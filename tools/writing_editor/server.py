#!/usr/bin/env python3
"""Local content editor for the Writing module (Levels 1-3).

A tiny stdlib-only web server that serves a single-page editor (index.html) and
reads/writes the real unit JSON under ``assets/writing/units/``. It is a DEV
TOOL only — it never ships in the app and touches nothing but the writing
content files.

Run from anywhere:

    python tools/writing_editor/server.py

then open http://127.0.0.1:8765 in your browser.

Endpoints
---------
GET  /                -> the editor page
GET  /api/data        -> { index, units: {id: unit}, lexicon }
POST /api/save        -> { id, data } writes data back to that unit's file
"""

from __future__ import annotations

import json
import os
import sys
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
UNITS_DIR = os.path.join(ROOT, "assets", "writing", "units")
LEXICON_DIR = os.path.join(ROOT, "assets", "writing", "lexicon")
INDEX_PATH = os.path.join(UNITS_DIR, "index.json")

HOST = "127.0.0.1"
PORT = 8765


def _load_json(path: str):
    with open(path, encoding="utf-8") as fh:
        return json.load(fh)


def _id_to_asset() -> dict:
    """Map unit id -> absolute file path, from index.json (the allow-list)."""
    index = _load_json(INDEX_PATH)
    out = {}
    for entry in index:
        asset = entry.get("asset", "")
        # asset is repo-relative, e.g. assets/writing/units/l3_wish.json
        abspath = os.path.abspath(os.path.join(ROOT, asset))
        out[entry["id"]] = abspath
    return out


def build_data() -> dict:
    index = _load_json(INDEX_PATH)
    units = {}
    for entry in index:
        abspath = os.path.abspath(os.path.join(ROOT, entry["asset"]))
        try:
            units[entry["id"]] = _load_json(abspath)
        except FileNotFoundError:
            units[entry["id"]] = {"id": entry["id"], "_missing": True}
    lexicon = {}
    for name in ("verbs", "time_words", "adjectives", "nouns"):
        p = os.path.join(LEXICON_DIR, f"{name}.json")
        lexicon[name] = _load_json(p) if os.path.exists(p) else []
    return {"index": index, "units": units, "lexicon": lexicon}


class Handler(BaseHTTPRequestHandler):
    def _send(self, code: int, body: bytes, ctype: str):
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def _send_json(self, code: int, obj):
        self._send(code, json.dumps(obj, ensure_ascii=False).encode("utf-8"),
                   "application/json; charset=utf-8")

    def do_GET(self):  # noqa: N802
        if self.path in ("/", "/index.html"):
            with open(os.path.join(HERE, "index.html"), "rb") as fh:
                self._send(200, fh.read(), "text/html; charset=utf-8")
            return
        if self.path == "/api/data":
            try:
                self._send_json(200, build_data())
            except Exception as exc:  # noqa: BLE001
                self._send_json(500, {"error": str(exc)})
            return
        self._send(404, b"not found", "text/plain")

    def do_POST(self):  # noqa: N802
        if self.path == "/api/save":
            return self._save_unit()
        if self.path == "/api/save_index":
            return self._save_index()
        self._send(404, b"not found", "text/plain")

    def _body(self):
        length = int(self.headers.get("Content-Length", 0))
        return json.loads(self.rfile.read(length))

    def _write_json_file(self, path: str, obj):
        text = json.dumps(obj, ensure_ascii=False, indent=2) + "\n"
        with open(path, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(text)

    def _save_unit(self):
        try:
            payload = self._body()
            uid = payload["id"]
            data = payload["data"]
        except Exception as exc:  # noqa: BLE001
            self._send_json(400, {"error": f"bad payload: {exc}"})
            return

        allow = _id_to_asset()
        if uid not in allow:
            self._send_json(403, {"error": f"unknown unit id: {uid}"})
            return
        target = allow[uid]
        # Safety: the resolved path must live inside the units dir.
        if os.path.commonpath([target, UNITS_DIR]) != UNITS_DIR:
            self._send_json(403, {"error": "path outside units dir"})
            return
        if data.get("id") != uid:
            self._send_json(400, {"error": "data.id does not match unit id"})
            return
        try:
            self._write_json_file(target, data)
        except Exception as exc:  # noqa: BLE001
            self._send_json(500, {"error": str(exc)})
            return

        # Best-effort: keep index.json's mirrored title/subtitle in sync so the
        # path screen never drifts from the teach page. Only rewrites if changed;
        # order / section / published stay owned by the index editor.
        index_synced = False
        try:
            index = _load_json(INDEX_PATH)
            changed = False
            for entry in index:
                if entry.get("id") == uid:
                    for k in ("title", "subtitle_mm"):
                        if k in data and entry.get(k) != data[k]:
                            entry[k] = data[k]
                            changed = True
                    break
            if changed:
                self._write_json_file(INDEX_PATH, index)
                index_synced = True
        except Exception:  # noqa: BLE001
            pass

        self._send_json(200, {"ok": True, "path": os.path.relpath(target, ROOT),
                              "indexSynced": index_synced})

    def _save_index(self):
        try:
            payload = self._body()
            index = payload["index"]
        except Exception as exc:  # noqa: BLE001
            self._send_json(400, {"error": f"bad payload: {exc}"})
            return
        if not isinstance(index, list) or not index:
            self._send_json(400, {"error": "index must be a non-empty list"})
            return
        required = {"id", "level", "section_id", "section", "order", "asset"}
        for i, e in enumerate(index):
            if not isinstance(e, dict) or not required.issubset(e):
                self._send_json(400, {"error": f"entry {i} missing required keys"})
                return
        try:
            self._write_json_file(INDEX_PATH, index)
        except Exception as exc:  # noqa: BLE001
            self._send_json(500, {"error": str(exc)})
            return
        self._send_json(200, {"ok": True, "path": os.path.relpath(INDEX_PATH, ROOT),
                              "count": len(index)})

    def log_message(self, fmt, *args):  # quieter console
        sys.stderr.write("  %s\n" % (fmt % args))


def main():
    if not os.path.exists(INDEX_PATH):
        sys.exit(f"Could not find {INDEX_PATH}. Run from the project, please.")
    srv = ThreadingHTTPServer((HOST, PORT), Handler)
    print(f"Writing editor running at  http://{HOST}:{PORT}")
    print(f"Editing units under        {os.path.relpath(UNITS_DIR, ROOT)}")
    print("Press Ctrl+C to stop.")
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        print("\nStopped.")


if __name__ == "__main__":
    main()
