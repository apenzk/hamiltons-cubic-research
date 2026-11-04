"""Fetch each arXiv paper's source and flatten it to one file.

    python3 scripts/rag/fetch_sources.py .rag/head/manifest.tsv .rag/papers

For every arXiv id in the manifest, downloads https://arxiv.org/e-print/<id> once, three
seconds apart as arXiv's robots policy asks, into <out>/<slug>/eprint, and writes
<out>/<slug>/source.tex: the main file (the one with \\documentclass) with every \\input and
\\include inlined, comments dropped. A paper whose e-print is a PDF, the authors having
withheld source, gets status `pdf-only` and keeps its committed pdftotext text. Resumable:
a slug with an eprint on disk is not fetched again. Prints one line per paper and writes
<out>/sources.tsv (slug, arxiv, status, bytes).
"""
import gzip, io, re, sys, tarfile, time, urllib.request
from pathlib import Path

AGENT = 'hamiltons-cubic-rag/0.1 (mailto:aaa@aaa.com)'
PAUSE = 3.0
INPUT = re.compile(r'\\(?:input|include)\s*\{([^}]+)\}')
COMMENT = re.compile(r'(?<!\\)%.*')


def fetch(arxiv):
    req = urllib.request.Request(f'https://arxiv.org/e-print/{arxiv}', headers={'User-Agent': AGENT})
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.read()


def unpack(data):
    """name -> text of every .tex and .bbl file in the e-print, or None for a PDF e-print."""
    if data[:4] == b'%PDF':
        return None
    if data[:2] == b'\x1f\x8b':
        data = gzip.decompress(data)
    if data[:4] == b'%PDF':
        return None
    try:
        with tarfile.open(fileobj=io.BytesIO(data)) as tar:
            return {m.name.lstrip('./'): tar.extractfile(m).read().decode('utf-8', 'replace')
                    for m in tar.getmembers() if m.isfile() and m.name.endswith(('.tex', '.bbl'))}
    except tarfile.ReadError:
        return {'main.tex': data.decode('utf-8', 'replace')}


def flatten(files):
    main = next((n for n in sorted(files) if r'\documentclass' in COMMENT.sub('', files[n])), None)
    if main is None:
        return None
    base = Path(main).parent

    def inline(text, depth):
        text = '\n'.join(COMMENT.sub('', l) for l in text.splitlines())
        if depth > 8:
            return text

        def sub(m):
            name = (base / m.group(1).strip()).as_posix().lstrip('./')
            for cand in (name, name + '.tex'):
                if cand in files:
                    return inline(files[cand], depth + 1)
            return m.group(0)
        return INPUT.sub(sub, text)
    return inline(files[main], 0)


def main():
    manifest, out = Path(sys.argv[1]), Path(sys.argv[2])
    rows = [l.split('\t') for l in manifest.read_text().splitlines()[1:]]
    papers = {}
    for slug, _, _, _, arxiv in rows:
        if arxiv.strip():
            papers.setdefault(slug, arxiv.strip())
    table = []
    for slug, arxiv in sorted(papers.items()):
        d = out / slug
        d.mkdir(parents=True, exist_ok=True)
        eprint = d / 'eprint'
        if not eprint.exists():
            try:
                eprint.write_bytes(fetch(arxiv))
            except Exception as e:
                table.append((slug, arxiv, f'error: {e}', 0))
                print(slug, arxiv, 'error', e, flush=True)
                time.sleep(PAUSE)
                continue
            time.sleep(PAUSE)
        files = unpack(eprint.read_bytes())
        if files is None:
            status, size = 'pdf-only', 0
        else:
            tex = flatten(files)
            if tex is None:
                status, size = 'no-main', 0
            else:
                (d / 'source.tex').write_text(tex)
                status, size = 'tex', len(tex)
        table.append((slug, arxiv, status, size))
        print(slug, arxiv, status, size, flush=True)
    (out / 'sources.tsv').write_text('slug\tarxiv\tstatus\tbytes\n' + ''.join('\t'.join(map(str, r)) + '\n' for r in table))


if __name__ == '__main__':
    main()
