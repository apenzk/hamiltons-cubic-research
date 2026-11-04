"""The registries of the RAG tool: results, values and papers, built from one tree of the record.

    python3 scripts/rag/registries.py <root> <out>

<root> is a checkout or a `git archive` snapshot, <out> a folder under .rag/. Reads files
only, so it runs on a snapshot with no .git. Writes:
- manifest.tsv, the paper manifest: columns slug, pdf, txt and source URL
  over every references/ folder, plus the arXiv id the source URL or the PDF name carries;
- results.jsonl, one object per numbered result, keys as in README.md;
- values.jsonl, one object per row of findings/INDEX-values.md, keys as in README.md.

A result is a heading `Lemma N`, `Lemma LN`, `Observation …`, `Conjecture …` or `Corollary …`
in a record file. The record's result headings took three forms over its history
(`##### Lemma N:` in response.md, `#### Lemma N` and then `#### Lemma LN` in findings/), and
all three are read. The primary location is the first heading under findings/, else the
first anywhere. Status is derived: `withdrawn` when the index row's kind is WITHDRAWN or
its text says WITHDRAWN or RETIRED, `superseded` when a sentence of the row or the heading
opens by naming a superseding id, else `live`.
"""
import json, re, sys
from pathlib import Path

URL = re.compile(r'https?://[^\s)\]>|]+')


def source_urls(root):
    """references/<slug> -> the public URL its README names as the source."""
    out = {}
    for readme in sorted((root / 'references').glob('*/README.md')):
        text = readme.read_text(encoding='utf-8')
        url = None
        for line in text.splitlines():
            if '**Source' in line:
                m = URL.search(line)
                if m:
                    url = m.group(0).rstrip('.,;')
                    break
        if url is None:
            m = URL.search(text)
            url = m.group(0).rstrip('.,;') if m else None
        out[readme.parent.name] = url
    return out

RECORD = ['findings', 'results.md', 'response.md', 'FINDINGS.md']
HISTORY = ('reviews/', 'verification/', 'ATTEMPTS.md', 'REVIEW.md', 'agent_logs/')
HEAD = re.compile(r'^(#{2,6}) +\**(Lemma|Observation|Conjecture|Corollary) +L?(\d+[a-z]?)\b\**[.:]? *(.*)')
ROW = re.compile(r'^\| \*\*(\d+[a-z]?)\*\* \| (\w+) \| (.*) \| (.*) \|\s*$')
LINK = re.compile(r'\]\(([^)\s]+)\)')
LID = re.compile(r'\bL(\d{1,3}[a-z]?)\b')
# Sentence-initial only: "its pair-block use is superseded by L224" leaves the result live.
SUPERSEDED = re.compile(r'(?:^|[.*]\s+|\*\*)Superseded (?:by|in) \[?(?:Lemma )?L(\d+[a-z]?)', re.I)
ARXIV = re.compile(r'arxiv\.org/(?:abs|pdf)/([\w./-]+?\d)(?:v\d+)?(?:\.pdf)?(?:[)\s]|$)|paper-(\d{4}\.\d{4,5})')
DECIMAL = re.compile(r'\d+\.\d{4,}')


def status_of_file(rel):
    """The default status of a chunk from its path: history for the review and attempt trail."""
    return 'history' if rel.startswith(HISTORY) else 'live'


def record_files(root):
    for top in RECORD:
        p = root / top
        if p.is_file():
            yield p
        elif p.is_dir():
            yield from sorted(p.rglob('*.md'))


def manifest(root):
    if not (root / 'references').is_dir():
        return []
    urls = source_urls(root)
    rows = []
    for d in sorted((root / 'references').iterdir()):
        if not d.is_dir():
            continue
        for pdf in sorted(d.glob('*.pdf')):
            url = urls.get(d.name) or ''
            m = ARXIV.search(url + ' ') or ARXIV.search(pdf.name)
            arxiv = (m.group(1) or m.group(2)) if m else ''
            rows.append([d.name, pdf.name, pdf.with_suffix('.txt').name, url, arxiv])
    return rows


def index_rows(root):
    p = root / 'findings' / 'INDEX-results.md'
    rows = {}
    if p.is_file():
        for line in p.read_text(errors='ignore').splitlines():
            m = ROW.match(line)
            if m:
                rows[m.group(1)] = {'kind': m.group(2), 'text': m.group(3), 'in': m.group(4)}
    return rows


def headings(root):
    """result id -> list of (file, line, level, kind, title, body), in file order."""
    out = {}
    for path in record_files(root):
        rel = path.relative_to(root).as_posix()
        lines = path.read_text(errors='ignore').splitlines()
        for i, line in enumerate(lines):
            m = HEAD.match(line)
            if not m:
                continue
            level = len(m.group(1))
            body = []
            for nxt in lines[i + 1:]:
                h = re.match(r'^(#+) ', nxt)
                if h and len(h.group(1)) <= level:
                    break
                body.append(nxt)
            out.setdefault(m.group(3), []).append(
                (rel, i + 1, level, m.group(2), m.group(4).strip(' *,.:'), '\n'.join(body)))
    return out


def results(root):
    rows, heads = index_rows(root), headings(root)
    out = []
    for rid in sorted(set(rows) | set(heads), key=lambda r: (int(re.match(r'\d+', r).group()), r)):
        hs = heads.get(rid, [])
        primary = next((h for h in hs if h[0].startswith('findings/')), hs[0] if hs else None)
        row = rows.get(rid, {})
        text = row.get('text', '')
        kind = row.get('kind') or (primary[3] if primary else '')
        sup = SUPERSEDED.search(text + ' ' + (primary[4] if primary else ''))
        if kind == 'WITHDRAWN' or re.search(r'WITHDRAWN|RETIRED', text + (primary[4] if primary else '')):
            status = 'withdrawn'
        elif sup:
            status = 'superseded'
        else:
            status = 'live'
        body = primary[5] if primary else ''
        para = next((p.strip() for p in body.split('\n\n') if p.strip()), '')
        statement = ((primary[4] + '. ') if primary and primary[4] else '') + para
        out.append({'id': f'L{rid}', 'kind': kind, 'status': status,
                    'statement': statement or text,
                    'file': primary[0] if primary else None, 'line': primary[1] if primary else None,
                    'deps': sorted({f'L{d}' for d in LID.findall(body)} - {f'L{rid}'}),
                    'lean': [t for t in LINK.findall(row.get('in', '') + text) if t.endswith('.lean')],
                    'superseded_by': f'L{sup.group(1)}' if sup else None})
    return out


def values(root):
    p = root / 'findings' / 'INDEX-values.md'
    if not p.is_file():
        return []
    record = [(f.relative_to(root).as_posix(), i + 1, l) for f in record_files(root)
              for i, l in enumerate(f.read_text(errors='ignore').splitlines())]
    out = []
    for i, line in enumerate(p.read_text(errors='ignore').splitlines()):
        cells = [c.strip() for c in line.strip().strip('|').split('|')]
        if len(cells) < 4 or not line.startswith('| $') or cells[0].startswith('---'):
            continue
        nums = DECIMAL.findall(cells[0])
        if not nums:
            continue
        where = [str((p.parent / t.split('#')[0]).resolve().relative_to(root.resolve()))
                 for t in LINK.findall(cells[3]) if not re.match(r'[a-z]+:', t)]
        for v in nums:
            printings = sorted({f'{f}:{n}' for f, n, l in record if v in l} - {f'findings/INDEX-values.md:{i + 1}'})
            out.append({'value': v, 'name': cells[1], 'n': cells[2], 'file': where[0] if where else None,
                        'line': i + 1, 'printings': printings})
    return out


def main():
    root, out = Path(sys.argv[1]), Path(sys.argv[2])
    out.mkdir(parents=True, exist_ok=True)
    m = manifest(root)
    (out / 'manifest.tsv').write_text('slug\tpdf\ttxt\tsource\tarxiv\n' + ''.join('\t'.join(r) + '\n' for r in m))
    for name, rows in (('results.jsonl', results(root)), ('values.jsonl', values(root))):
        (out / name).write_text(''.join(json.dumps(r, ensure_ascii=False) + '\n' for r in rows))
        print(name, len(rows))
    print('manifest.tsv', len(m), 'rows,', sum(1 for r in m if r[4]), 'with an arXiv id')


if __name__ == '__main__':
    main()
