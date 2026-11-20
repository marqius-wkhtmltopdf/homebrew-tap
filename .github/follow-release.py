#!/usr/bin/env python3
"""Brings Formula/marqius-wkhtmltopdf.rb up to the latest release of marqius-wkhtmltopdf.

    python3 .github/follow-release.py [--base URL]

Reads the latest version from marqius.com. When it is newer than the formula's, downloads each
platform's build, checks it against the checksum published beside it, and writes the new version,
addresses and checksums into the formula (nothing else in it changes). It never goes back to an
older version. In GitHub Actions it sets the step outputs `changed` (true or false) and `version`.
Only the standard library is used.
"""
import argparse
import hashlib
import os
import re
import sys
import urllib.request
from pathlib import Path

BASE = "https://marqius.com/download/marqius-wkhtmltopdf"
FORMULA = Path(__file__).resolve().parents[1] / "Formula" / "marqius-wkhtmltopdf.rb"
PLATFORMS = ["macos-arm64", "linux-x86_64", "linux-arm64"]
AGENT = "marqiushq-homebrew-tap (+https://github.com/marqiushq/homebrew-tap)"


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": AGENT})
    with urllib.request.urlopen(req, timeout=120) as r:
        return r.read()


def key(v):
    return tuple(int(x) for x in v.split("."))


def output(**kw):
    out = os.environ.get("GITHUB_OUTPUT")
    if out:
        with open(out, "a", encoding="utf-8") as f:
            for k, v in kw.items():
                f.write(f"{k}={v}\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", default=BASE)
    a = ap.parse_args()
    text = FORMULA.read_text(encoding="utf-8")
    have = re.search(r'^  version "([0-9.]+)"$', text, re.M).group(1)
    latest = fetch(f"{a.base}/latest").decode("utf-8").strip()
    if not re.fullmatch(r"\d+(\.\d+)+", latest):
        sys.exit(f"{a.base}/latest does not hold a version: {latest[:40]!r}")
    if key(latest) <= key(have):
        print(f"marqius-wkhtmltopdf {have} is the latest release; nothing to do")
        output(changed="false", version=have)
        return
    for p in PLATFORMS:
        name = f"marqius-wkhtmltopdf-{p}"
        url = f"{a.base}/{latest}/{name}"
        published = fetch(f"{url}.sha256").decode("utf-8").strip()[:64].lower()
        if not re.fullmatch(r"[0-9a-f]{64}", published):
            sys.exit(f"{url}.sha256 does not hold a checksum")
        got = hashlib.sha256(fetch(url)).hexdigest()
        if got != published:
            sys.exit(f"{url} does not match its published checksum; the formula is left at {have}")
        # a url line, then (for the default build) the version line, then its sha256 line
        new, n = re.subn(rf'url "[^"]*/{re.escape(name)}"\n((?:\s*version "[0-9.]+"\n)?)(\s*)sha256 "[0-9a-f]{{64}}"',
                         lambda m: f'url "{url}"\n{m.group(1)}{m.group(2)}sha256 "{published}"', text)
        if n != 1:
            sys.exit(f"the formula has no single url and sha256 for {name}")
        text = new
        print(f"{name} {latest}: {published}")
    text = re.sub(r'^  version "[0-9.]+"$', f'  version "{latest}"', text, count=1, flags=re.M)
    FORMULA.write_text(text, encoding="utf-8")
    print(f"formula moved from {have} to {latest}")
    output(changed="true", version=latest)


if __name__ == "__main__":
    main()
