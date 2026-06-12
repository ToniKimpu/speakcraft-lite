#!/usr/bin/env python3
"""Upload local files back to a Bunny.net Storage Zone (overwrites in place).

The upload twin of bunny_pull.py. Bunny Storage is keyed by full path, so a PUT
to an existing path REPLACES that file (no duplicates, no need to delete first).
Use it to push repaired JSON back to the same location it came from.

Needs a READ-WRITE storage password (the read-only key used for pulling cannot
upload). Config via environment variables (keep the key OUT of the repo):
    BUNNY_STORAGE_ZONE   storage zone NAME (e.g. "pmpenglishapp")
    BUNNY_ACCESS_KEY     read-WRITE storage zone password (secret)
    BUNNY_STORAGE_HOST   storage endpoint hostname (e.g. sg.storage.bunnycdn.com)

Usage:
    # one file -> exact remote path
    python bunny_push.py <local-file> <remote-file-path>

    # a folder -> mirror every file under it to <remote-path>/<relpath>
    python bunny_push.py <local-dir> <remote-dir-path>

Examples:
    python bunny_push.py \
      bunny_download/listenings/paul_rudd_interview/sentence_explanation_data \
      listenings/paul_rudd_interview/sentence_explanation_data

After uploading, PURGE the pull-zone CDN cache for these files (or wait out the
TTL) so the app stops serving the old cached copies.
"""

import mimetypes
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path

ZONE = os.environ.get("BUNNY_STORAGE_ZONE", "").strip()
ACCESS_KEY = os.environ.get("BUNNY_ACCESS_KEY", "").strip()
HOST = os.environ.get("BUNNY_STORAGE_HOST", "storage.bunnycdn.com").strip()


def put_file(local: Path, remote_path: str) -> int:
    data = local.read_bytes()
    url = f"https://{HOST}/{ZONE}/{remote_path.strip('/')}"
    content_type = (
        mimetypes.guess_type(local.name)[0] or "application/octet-stream"
    )
    req = urllib.request.Request(
        url,
        data=data,
        method="PUT",
        headers={"AccessKey": ACCESS_KEY, "Content-Type": content_type},
    )
    with urllib.request.urlopen(req, timeout=60) as resp:
        resp.read()
    return len(data)


def main() -> None:
    if not ZONE or not ACCESS_KEY:
        sys.exit("error: set BUNNY_STORAGE_ZONE and BUNNY_ACCESS_KEY env vars.")
    if len(sys.argv) != 3:
        sys.exit("usage: python bunny_push.py <local-path> <remote-path>")

    local = Path(sys.argv[1])
    remote = sys.argv[2].strip("/")
    if not local.exists():
        sys.exit(f"error: {local} not found")

    # Build the (local_file, remote_path) work list.
    jobs = []
    if local.is_file():
        jobs.append((local, remote))
    else:
        for f in sorted(local.rglob("*")):
            if f.is_file():
                rel = f.relative_to(local).as_posix()
                jobs.append((f, f"{remote}/{rel}"))

    if not jobs:
        sys.exit(f"error: nothing to upload under {local}")

    print(f"Uploading {len(jobs)} file(s) to {ZONE} (host {HOST})")
    total = 0
    for f, rpath in jobs:
        try:
            size = put_file(f, rpath)
        except urllib.error.HTTPError as e:
            body = e.read().decode("utf-8", "replace")[:300]
            sys.exit(f"HTTP {e.code} for {e.url}\n{body}")
        except urllib.error.URLError as e:
            sys.exit(f"network error: {e.reason} (check host/region)")
        total += size
        print(f"  put  {rpath}  ({size:,} B)")

    print(f"\nDone. {len(jobs)} files, {total:,} bytes uploaded.")
    print("Remember to PURGE the pull-zone CDN cache for these paths.")


if __name__ == "__main__":
    main()
