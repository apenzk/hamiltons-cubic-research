"""Budget version of experiment 2: scripted grep (arm G) against the tool (arm E) on every incident.

    .venv/bin/python scripts/rag/experiment/eval_grep.py [<scratch>]

For each incident of .rag/eval/eval.jsonl, extracts its snapshot as eval_keyword.py does.
G greps the query's words of three or more letters, minus STOP, case-insensitive over the
snapshot's text files, and ranks matching lines by the number of distinct words they hold,
then by file and line. E runs `rag query`'s fused search on an in-memory index of the
snapshot, with vectors from the cache. Both are scored on their top ten by experiment 1's
rule, and each search's output is measured in characters: every matching line for G, as
`grep -rn` prints it, and the twenty printed hits for E. Writes .rag/eval-grep/runs.jsonl
and summary.json, and prints recall@10, McNemar on hits and a sign test on output size.
"""
import json, math, re, sqlite3, sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import eval_keyword, rag

STOP = set('the and for with that this from are was were has have had not but its into onto than then '
           'there their they them which what when where who whom will would can could should all any '
           'each every one two also only same such very more most other some our out over under about '
           'after before between both does did done being been is at as by'.split())


def words(q):
    return sorted({t.lower() for t in rag.TOKEN.findall(q) if len(t) >= 3 and t.lower() not in STOP})


def grep(root, ws):
    hits = []
    for rel, p in rag.text_files(root):
        for n, line in enumerate(p.read_text(errors='ignore').splitlines(), 1):
            low = line.lower()
            k = sum(w in low for w in ws)
            if k:
                hits.append((-k, rel, n, line))
    hits.sort()
    return hits


def g_hit(rel, n, line, t):
    if t['result_id'] and line.lstrip().startswith('#') and re.search(rf"\b{re.escape(t['result_id'])}\b", line):
        return True
    if rel != t['file']:
        return False
    if t['unit'] == 'declaration':
        return re.search(rf"\b(theorem|lemma|def) +{re.escape(t['loc'])}\b", line) is not None
    return abs(n - t['loc']) <= 2


def printed(hits):
    return sum(len(f'{i}  {r[6]}  {r[1]}:{r[2]}-{r[3]}  {r[4]}\n    ' + ' '.join(r[9].split())[:200] + '\n')
               for i, r in enumerate(hits, 1))


def sign_p(w, l):
    n = w + l
    return 1.0 if n == 0 else min(1.0, 2 * sum(math.comb(n, i) for i in range(min(w, l) + 1)) / 2 ** n)


def main():
    scratch = Path(sys.argv[1] if len(sys.argv) > 1 else '/tmp/rag-eval-grep') / 'snap'
    out = Path('.rag/eval-grep')
    out.mkdir(parents=True, exist_ok=True)
    rows = [json.loads(l) for l in open('.rag/eval/eval.jsonl')]
    runs = []
    for r in (x for x in rows if x['kind'] == 'incident'):
        eval_keyword.snapshot(r['precatch_commit'], scratch)
        ws = words(r['query'])
        g = grep(scratch, ws)
        g_chars = sum(len(f'{rel}:{n}:{line}\n') for _, rel, n, line in g)
        conn = sqlite3.connect(':memory:')
        rag.build(conn, list(rag.structured_corpus(scratch, eval_keyword.PAPERS)))
        rag.add_vectors(conn)
        e20 = rag.fused(conn, r['query'], 20)
        run = {'id': r['id'], 'words': ws, 'G_lines': len(g), 'G_chars': g_chars, 'E_chars': printed(e20),
               'G_hit': any(g_hit(rel, n, line, r['target']) for _, rel, n, line in g[:10]),
               'E_hit': any(eval_keyword.hit(x, r['target']) for x in e20[:10])}
        conn.close()
        eval_keyword.shutil.rmtree(scratch, ignore_errors=True)
        runs.append(run)
        print(r['id'], run['G_hit'], run['E_hit'], run['G_lines'], run['G_chars'], run['E_chars'], flush=True)
    (out / 'runs.jsonl').write_text(''.join(json.dumps(x) + '\n' for x in runs))
    w = sum(x['E_hit'] and not x['G_hit'] for x in runs)
    l = sum(x['G_hit'] and not x['E_hit'] for x in runs)
    smaller = sum(x['E_chars'] < x['G_chars'] for x in runs)
    larger = sum(x['E_chars'] > x['G_chars'] for x in runs)
    med = lambda v: sorted(v)[len(v) // 2]
    summary = {'incidents': len(runs), 'recall10_G': sum(x['G_hit'] for x in runs),
               'recall10_E': sum(x['E_hit'] for x in runs),
               'E_vs_G_hits': {'wins': w, 'losses': l, 'p': round(eval_keyword.mcnemar(w, l), 4)},
               'E_smaller_output': {'smaller': smaller, 'larger': larger, 'p': round(sign_p(smaller, larger), 6)},
               'median_tokens_G': med([x['G_chars'] for x in runs]) // 4,
               'median_tokens_E': med([x['E_chars'] for x in runs]) // 4}
    (out / 'summary.json').write_text(json.dumps(summary, indent=1) + '\n')
    print(json.dumps(summary, indent=1))


if __name__ == '__main__':
    main()
