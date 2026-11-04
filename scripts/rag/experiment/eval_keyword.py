"""Keyword arms of the RAG experiment: arms B and C on every incident, at its own snapshot.

    python3 scripts/rag/experiment/eval_keyword.py [<scratch>]

For each row of .rag/eval/eval.jsonl, extracts `git archive <precatch_commit>` into
<scratch>/snap (no .git), builds the raw corpus (arm B) and the structured corpus (arm C)
into in-memory indexes, runs the frozen query and deletes the snapshot. Writes
.rag/eval-keyword/runs.jsonl, one object per row with the top ten of each arm, and prints
recall@10, the discordant pairs of C against B with the exact two-sided McNemar p, and the
counts that size the sidecar and embedding runs: distinct structured-chunk hashes across all snapshots, and
distinct script and Lean file hashes.

A hit is a chunk of the target's file that covers the target line within two lines, that
is the target declaration (unit `declaration`), or that carries the target result id.
Arm C ranks live chunks first, as the tool does. C without that reordering is printed
beside it as a diagnostic.
"""
import hashlib, io, json, math, re, shutil, sqlite3, subprocess, sys, tarfile, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import rag

PAPERS = Path('.rag/papers').resolve()


def snapshot(sha, dest):
    shutil.rmtree(dest, ignore_errors=True)
    dest.mkdir(parents=True)
    data = subprocess.run(['git', 'archive', '--format=tar', sha], check=True, capture_output=True).stdout
    with tarfile.open(fileobj=io.BytesIO(data)) as tar:
        tar.extractall(dest, filter='data')


def hit(row, t):
    _, file, s, e, heading, kind, status, ids, _, body = row
    if t['result_id'] and t['result_id'] in ids.split():
        return True
    if file != t['file']:
        return False
    if t['unit'] == 'declaration':
        return heading == t['loc'] or re.search(rf'\b(theorem|lemma|def) +{re.escape(t["loc"])}\b', body) is not None
    return s - 2 <= t['loc'] <= e + 2


def mcnemar(wins, losses):
    n = wins + losses
    if n == 0:
        return 1.0
    tail = sum(math.comb(n, i) for i in range(min(wins, losses) + 1)) / 2 ** n
    return min(1.0, 2 * tail)


def main():
    scratch = Path(sys.argv[1] if len(sys.argv) > 1 else '/tmp/rag-eval-keyword') / 'snap'
    out = Path('.rag/eval-keyword')
    out.mkdir(parents=True, exist_ok=True)
    rows = [json.loads(l) for l in open('.rag/eval/eval.jsonl')]
    chunk_hashes, file_hashes, runs = set(), set(), []
    for r in rows:
        t0 = time.time()
        snapshot(r['precatch_commit'], scratch)
        for rel, p in rag.text_files(scratch):
            if rel.endswith(('.py', '.lean', '.sage')):
                file_hashes.add(hashlib.sha256(p.read_bytes()).hexdigest())
        run = {'id': r['id'], 'kind': r['kind']}
        for arm, corpus, live in (('B', rag.raw_corpus(scratch), False),
                                  ('C', list(rag.structured_corpus(scratch, PAPERS)), True)):
            if arm == 'C':
                chunk_hashes.update(c['hash'] for c in corpus)
            conn = sqlite3.connect(':memory:')
            run[f'{arm}_chunks'] = rag.build(conn, corpus)
            variants = [(arm, live)] + ([('C_nolive', False)] if arm == 'C' else [])
            for name, lf in variants:
                top = rag.query(conn, r['query'], 10, live_first=lf)
                run[name] = [f'{x[1]}:{x[2]}-{x[3]}' for x in top]
                run[name + '_hit'] = r['kind'] == 'incident' and any(hit(x, r['target']) for x in top)
            conn.close()
        shutil.rmtree(scratch, ignore_errors=True)
        run['seconds'] = round(time.time() - t0, 1)
        runs.append(run)
        print(r['id'], run['B_hit'], run['C_hit'], run['C_nolive_hit'], run['C_chunks'], run['seconds'], flush=True)
    (out / 'runs.jsonl').write_text(''.join(json.dumps(x) + '\n' for x in runs))
    inc = [x for x in runs if x['kind'] == 'incident']
    summary = {'incidents': len(inc)}
    for name in ('B', 'C', 'C_nolive'):
        summary[f'recall10_{name}'] = sum(x[name + '_hit'] for x in inc)
    for a, b in (('C', 'B'), ('C_nolive', 'B'), ('C', 'C_nolive')):
        w = sum(x[a + '_hit'] and not x[b + '_hit'] for x in inc)
        l = sum(x[b + '_hit'] and not x[a + '_hit'] for x in inc)
        summary[f'{a}_vs_{b}'] = {'wins': w, 'losses': l, 'p': round(mcnemar(w, l), 4)}
    summary['union_structured_chunks'] = len(chunk_hashes)
    summary['distinct_script_lean_files'] = len(file_hashes)
    (out / 'summary.json').write_text(json.dumps(summary, indent=1) + '\n')
    print(json.dumps(summary, indent=1))


if __name__ == '__main__':
    main()
