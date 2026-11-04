"""Eval set of the RAG experiment: draw the negatives.

A negative is a numbered result that was filed as new and never caught as already held:
- its row in findings/INDEX-results.md is a Lemma CONFIRMED at Gate 2 (a repair before
  confirmation is allowed) and carries none of the withdrawal or rediscovery words;
- its filing commit is the earliest commit adding an `L<n>` heading under findings/, and is
  the commit that states the result, so a commit that only places headings over older
  prose drops out. Results numbered before the L-prefix rename of 2026-09-02 have no such
  heading and drop out too. Trailers are not required: most filing commits carry none;
- no line of reviews/, verification/, findings/ or results.md naming `L<n>` matches CAUGHT,
  a wider phrase list than the incident pool's, so a catch worded differently still counts;
- its filing commit is absent from EXCLUDE.
Result ids are shuffled with the pool's seed and taken in order until COUNT qualify.
Prints the rows for add_row.py. Run from the repository root.
"""
import json, random, re, subprocess, sys

sys.path.insert(0, 'scripts/rag/experiment')
from pool import SEED, DIRS

COUNT = 10
BAD = re.compile(r'WITHDRAWN|RETIRED|already|duplicate|restates|re-deriv', re.I)
CAUGHT = (r'already (filed|in the record|on file|on the record|stated|proved|recorded|known|held)'
          r'|RETIRED into|was already|duplicate of|restates|re-deriv|rediscover|not new')
# Commits a catch names without the result id, found while reading, with the reason.
EXCLUDE = {'ae772901': 'r699 records the scalar-h equality lemma of DERIVE-j5 batch 2 as already on the record',
           '85c97374': 'L213: r921 had shown the compactness it closes, rated "already on the record" by r925 (audit)',
           'ee5b14ed': 'L278: lean/INDEX.md named it proved before the filing commit (second audit)',
           'fb324ed0': 'L284: an outside identity, already stated in outside material (unpublished, held in the private record) and proved in Lean before filing (second audit)'}
HEADINGS_ONLY = re.compile(r'place headings', re.I)


def git(*a):
    return subprocess.run(['git', *a], capture_output=True, text=True, check=True).stdout


def index_rows():
    rows = {}
    for line in open('findings/INDEX-results.md', errors='ignore'):
        m = re.match(r'\| \*\*(\d+)\*\* \| (\w+) \| (.*)', line)
        if m:
            rows[m.group(1)] = (m.group(2), m.group(3))
    return rows


def caught_ids():
    hits = git('grep', '-hIiE', CAUGHT, '--', *DIRS)
    return set(re.findall(r'\bL(\d{1,3})\b', hits))


def filing_commit(rid):
    out = git('log', '--reverse', '--format=%H', '-G', rf'^#+ .*L{rid}([^0-9]|$)', '--', 'findings').split()
    return out[0] if out else None


def main():
    taken = {json.loads(l)['target']['result_id'] for l in open('.rag/eval/eval.jsonl')
             if json.loads(l)['kind'] == 'incident'} - {None}
    rows, caught = index_rows(), caught_ids()
    ids = sorted(rid for rid, (kind, text) in rows.items()
                 if kind == 'Lemma' and 'CONFIRMED' in text and not BAD.search(text)
                 and rid not in caught and f'L{rid}' not in taken)
    random.Random(SEED).shuffle(ids)
    out = []
    for rid in ids:
        sha = filing_commit(rid)
        if not sha or sha[:8] in EXCLUDE:
            continue
        body = git('show', '-s', '--format=%B', sha).strip()
        if HEADINGS_ONLY.search(body.splitlines()[0]):
            continue
        subject = body.splitlines()[0].split(': ', 1)[-1]
        d = re.search(r'^Deliverable:.*$', body, re.M)
        out.append({'id': f'N{len(out) + 1:02d}', 'kind': 'negative', 'catch': None,
                    'precatch_commit': git('rev-parse', '--short=8', f'{sha}^').strip(),
                    'precatch_source': {'type': 'commit', 'ref': sha[:8]},
                    'precatch_text': body, 'query': subject + ('. ' + d.group(0) if d else ''),
                    'target': None, 'note': f'L{rid}, filed as new, confirmed at Gate 2, never caught as already held'})
        if len(out) == COUNT:
            break
    print(json.dumps(out, ensure_ascii=False))


if __name__ == '__main__':
    main()
