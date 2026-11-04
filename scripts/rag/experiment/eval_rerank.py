"""Experiment 1's incidents rerun with the reranker: does reordering the fused top 200 lift the target?

    cd <private checkout with the eval set> && <public checkout>/.venv/bin/python <public checkout>/scripts/rag/experiment/eval_rerank.py [<scratch>]

For each incident of .rag/eval/eval.jsonl, extracts its snapshot as eval_keyword.py does, builds the
index with vectors from the cache, and ranks the frozen query by the fused search (arm E) and by the
fused search with the reranker (arm R). Scores both on their top ten by experiment 1's rule, records
the target's rank in each, and writes .rag/eval-rerank/runs.jsonl and summary.json.
"""
import json, sqlite3, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import eval_keyword, rag


def rank_of(hits, t):
    return next((n for n, x in enumerate(hits, 1) if eval_keyword.hit(x, t)), None)


def main():
    scratch = Path(sys.argv[1] if len(sys.argv) > 1 else '/tmp/rag-eval-rerank') / 'snap'
    out = Path('.rag/eval-rerank')
    out.mkdir(parents=True, exist_ok=True)
    rows = [json.loads(l) for l in open('.rag/eval/eval.jsonl')]
    runs = []
    for r in (x for x in rows if x['kind'] == 'incident'):
        t0 = time.time()
        eval_keyword.snapshot(r['precatch_commit'], scratch)
        conn = sqlite3.connect(':memory:')
        rag.build(conn, list(rag.structured_corpus(scratch, eval_keyword.PAPERS)))
        rag.add_vectors(conn)
        e = rag.fused(conn, r['query'], rag.DEPTH)
        rr = rag.fused(conn, r['query'], rag.DEPTH, rerank_top=True)
        run = {'id': r['id'], 'E_rank': rank_of(e, r['target']), 'R_rank': rank_of(rr, r['target'])}
        run['E_hit'] = run['E_rank'] is not None and run['E_rank'] <= 10
        run['R_hit'] = run['R_rank'] is not None and run['R_rank'] <= 10
        run['seconds'] = round(time.time() - t0, 1)
        conn.close()
        eval_keyword.shutil.rmtree(scratch, ignore_errors=True)
        runs.append(run)
        print(run, flush=True)
    (out / 'runs.jsonl').write_text(''.join(json.dumps(x) + '\n' for x in runs))
    w = sum(x['R_hit'] and not x['E_hit'] for x in runs)
    l = sum(x['E_hit'] and not x['R_hit'] for x in runs)
    summary = {'incidents': len(runs), 'recall10_E': sum(x['E_hit'] for x in runs),
               'recall10_R': sum(x['R_hit'] for x in runs),
               'R_vs_E': {'wins': w, 'losses': l, 'p': round(eval_keyword.mcnemar(w, l), 4)},
               'target_in_top200': sum(x['E_rank'] is not None for x in runs),
               'rank_up': sum(bool(x['E_rank'] and x['R_rank'] and x['R_rank'] < x['E_rank']) for x in runs),
               'rank_down': sum(bool(x['E_rank'] and x['R_rank'] and x['R_rank'] > x['E_rank']) for x in runs)}
    (out / 'summary.json').write_text(json.dumps(summary, indent=1) + '\n')
    print(json.dumps(summary, indent=1))


if __name__ == '__main__':
    main()
