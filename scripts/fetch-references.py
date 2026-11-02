#!/usr/bin/env python3
"""Restore the papers the reading notes quote, from their public sources.

    python3 scripts/fetch-references.py --dry-run      # what would be fetched
    python3 scripts/fetch-references.py                # fetch what is missing
    python3 scripts/fetch-references.py --slug fox-2019-nonassociative-curvature-algebra

Reads references/FETCH.tsv (slug, pdf name, txt name, source URL). Each PDF lands at
references/<slug>/<pdf name> and its text at <txt name>, made with `pdftotext -layout`,
so the line and page numbers in the notes point at the same text again. Git ignores
both, since the papers stay under their authors' terms. A source that is not an arXiv
page or a direct PDF link is listed for a manual download.
"""
import argparse
import re
import shutil
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
UA = 'hamiltons-cubic-fetch (mailto:aaa@aaa.com)'
ARXIV = re.compile(r'arxiv\.org/(?:abs|pdf)/([\w.\-/]+?)(?:v\d+)?(?:\.pdf)?$')
ARXIV_ID = re.compile(r'(\d{4}\.\d{4,5}|[a-z\-]+/\d{7})')


def pdf_url(pdf_name, source):
    """Direct PDF URL for one row, or None when it needs a manual download."""
    m = ARXIV_ID.search(pdf_name)          # per-file id first: a slug can hold two papers
    if m and ('arxiv.org' in source or re.fullmatch(r'\d{4}\.\d{4,5}', m.group(1))):
        return f'https://arxiv.org/pdf/{m.group(1)}'
    m = ARXIV.search(source.split('#')[0].rstrip('/'))
    if m:
        return f'https://arxiv.org/pdf/{m.group(1)}'
    if source.lower().split('?')[0].endswith('.pdf'):
        return source
    return None


def fetch(url, dest):
    req = urllib.request.Request(url, headers={'User-Agent': UA})
    with urllib.request.urlopen(req, timeout=60) as r:
        data = r.read()
    if not data.startswith(b'%PDF'):
        raise ValueError('response is not a PDF')
    dest.write_bytes(data)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--dry-run', action='store_true')
    ap.add_argument('--slug', action='append', help='only this reference folder (repeatable)')
    ap.add_argument('--delay', type=float, default=3.0, help='seconds between downloads')
    a = ap.parse_args()
    table = (ROOT / 'references' / 'FETCH.tsv').read_text(encoding='utf-8').splitlines()[1:]
    rows = [l.split('\t') for l in table if l]
    todo, manual, have = [], [], 0
    for slug, pdf, txt, source in rows:
        if a.slug and slug not in a.slug:
            continue
        d = ROOT / 'references' / slug
        if (d / pdf).exists() and (d / txt).exists():
            have += 1
            continue
        url = pdf_url(pdf, source)
        (todo if url else manual).append((slug, pdf, txt, url or source))
    print(f'{have} present, {len(todo)} to fetch, {len(manual)} need a manual download')
    for slug, pdf, _, url in todo:
        print(f'  fetch  references/{slug}/{pdf}  <-  {url}')
    for slug, pdf, _, src in manual:
        print(f'  manual references/{slug}/{pdf}  <-  {src or "(no source URL in the README)"}')
    if a.dry_run:
        return
    if todo and not shutil.which('pdftotext'):
        sys.exit('pdftotext is missing (poppler), needed for the .txt files')
    failed = 0
    for slug, pdf, txt, url in todo:
        d = ROOT / 'references' / slug
        try:
            if not (d / pdf).exists():
                fetch(url, d / pdf)
                time.sleep(a.delay)
            subprocess.run(['pdftotext', '-layout', str(d / pdf), str(d / txt)], check=True)
            print(f'ok     {slug}/{pdf}')
        except Exception as e:
            failed += 1
            print(f'FAILED {slug}/{pdf}: {e}')
    sys.exit(1 if failed else 0)


if __name__ == '__main__':
    main()
