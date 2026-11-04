"""Vector arms of the RAG experiment: arms D (vectors) and E (C + D fused) on every incident.

    .venv/bin/python scripts/rag/experiment/eval_vectors.py <model> [<scratch>]

<model> is `qwen` (Qwen/Qwen3-Embedding-0.6B) or `bge` (BAAI/bge-m3). For each incident of
.rag/eval/eval.jsonl, rebuilds its snapshot and arm C's structured corpus exactly as
eval_keyword.py does, embeds every chunk whose hash is not yet cached, and ranks the snapshot's
chunks by cosine similarity to the frozen query. Vectors are cached per snapshot under
.rag/vec/<model>/, keyed by chunk hash, so a rerun resumes. Chunks are embedded as heading
and body, cut at 1000 characters and 256 tokens, at fp16, the setting model-choice.md chose.

Arm D ranks live chunks first, as C does. Arm E fuses C's and D's rankings, each to depth
200, by reciprocal rank at k = 60, then live first. Writes .rag/eval-vectors/<model>.jsonl and
prints recall@10 and the McNemar comparisons of the plan: D against C, and E against the
better of C and D. Once a model's weights are in the Hugging Face cache, the run sets
HF_HUB_OFFLINE=1 before loading it, so it makes no outbound calls.
"""
import json, os, sqlite3, sys, time
from pathlib import Path

MODELS = {'qwen': ('Qwen/Qwen3-Embedding-0.6B', {'prompt_name': 'query'}),
          'bge': ('BAAI/bge-m3', {})}
# huggingface_hub reads HF_HUB_OFFLINE when it is imported, so this precedes the imports below.
if len(sys.argv) > 1 and sys.argv[1] in MODELS and (
        Path.home() / '.cache' / 'huggingface' / 'hub' / ('models--' + MODELS[sys.argv[1]][0].replace('/', '--'))).is_dir():
    os.environ['HF_HUB_OFFLINE'] = '1'

import numpy as np
import torch
from sentence_transformers import SentenceTransformer

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import eval_keyword, rag

CUT = 1000
TOKENS = 256
DEPTH = 200


def load_cache(d):
    vecs = {}
    for f in sorted(d.glob('*.json')):
        arr = np.load(f.with_suffix('.npy'))
        vecs.update(zip(json.load(open(f)), arr))
    return vecs


def live_first(ids, status, k=10):
    return sorted(ids, key=lambda i: status[i] != 'live')[:k]


def main():
    name = sys.argv[1]
    scratch = Path(sys.argv[2] if len(sys.argv) > 2 else '/tmp/rag-eval-vectors') / 'snap'
    model_id, qkw = MODELS[name]
    model = SentenceTransformer(model_id, device=rag.device(), model_kwargs={'torch_dtype': torch.float16})
    model.max_seq_length = TOKENS
    cache_dir = Path('.rag/vec') / name
    cache_dir.mkdir(parents=True, exist_ok=True)
    vecs = load_cache(cache_dir)
    out = Path('.rag/eval-vectors')
    out.mkdir(parents=True, exist_ok=True)
    rows = [json.loads(l) for l in open('.rag/eval/eval.jsonl')]
    runs = []
    for r in (x for x in rows if x['kind'] == 'incident'):
        t0 = time.time()
        eval_keyword.snapshot(r['precatch_commit'], scratch)
        chunks = list(rag.structured_corpus(scratch, eval_keyword.PAPERS))
        new = {c['hash']: (c['heading'] + '\n' + c['body'])[:CUT] for c in chunks if c['hash'] not in vecs}
        if new:
            keys = sorted(new, key=lambda h: len(new[h]))
            arr = model.encode([new[h] for h in keys], batch_size=32, normalize_embeddings=True,
                               convert_to_numpy=True).astype(np.float16)
            np.save(cache_dir / f'{r["id"]}.npy', arr)
            json.dump(keys, open(cache_dir / f'{r["id"]}.json', 'w'))
            vecs.update(zip(keys, arr))
        conn = sqlite3.connect(':memory:')
        rag.build(conn, chunks)
        meta = {row[0]: row for row in conn.execute('select * from chunks')}
        status = {i: m[6] for i, m in meta.items()}
        ids = list(meta)
        mat = np.stack([vecs[meta[i][8]] for i in ids]).astype(np.float32)
        q = model.encode([r['query']], normalize_embeddings=True, convert_to_numpy=True, **qkw)[0]
        sims = mat @ q
        d_rank = [ids[j] for j in np.argsort(-sims)[:DEPTH]]
        score = {}
        for table in ('chunks_text', 'chunks_tri'):
            for rank, rid in enumerate(rag.ranked(conn, table, r['query'], DEPTH)):
                score[rid] = score.get(rid, 0) + 1 / (rag.K_RRF + rank + 1)
        c_rank = sorted(score, key=lambda i: -score[i])[:DEPTH]
        fused = {}
        for lst in (c_rank, d_rank):
            for rank, rid in enumerate(lst):
                fused[rid] = fused.get(rid, 0) + 1 / (rag.K_RRF + rank + 1)
        e_rank = sorted(fused, key=lambda i: -fused[i])
        run = {'id': r['id'], 'chunks': len(ids), 'embedded': len(new)}
        for arm, lst in (('C', c_rank), ('D', d_rank), ('E', e_rank)):
            top = live_first(lst, status)
            run[arm] = [f'{meta[i][1]}:{meta[i][2]}-{meta[i][3]}' for i in top]
            run[arm + '_hit'] = any(eval_keyword.hit(meta[i], r['target']) for i in top)
        run['D_nolive_hit'] = any(eval_keyword.hit(meta[i], r['target']) for i in d_rank[:10])
        target_ranks = [n + 1 for n, i in enumerate(d_rank) if eval_keyword.hit(meta[i], r['target'])]
        run['D_target_rank'] = target_ranks[0] if target_ranks else None
        conn.close()
        eval_keyword.shutil.rmtree(scratch, ignore_errors=True)
        run['seconds'] = round(time.time() - t0, 1)
        runs.append(run)
        print(r['id'], run['C_hit'], run['D_hit'], run['E_hit'], run['D_target_rank'], run['embedded'], run['seconds'], flush=True)
    (out / f'{name}.jsonl').write_text(''.join(json.dumps(x) + '\n' for x in runs))
    summary = {'model': model_id, 'incidents': len(runs)}
    for arm in ('C', 'D', 'E', 'D_nolive'):
        summary[f'recall10_{arm}'] = sum(x[arm + '_hit'] for x in runs)
    best = 'C' if summary['recall10_C'] >= summary['recall10_D'] else 'D'
    for a, b in (('D', 'C'), ('E', best)):
        w = sum(x[a + '_hit'] and not x[b + '_hit'] for x in runs)
        l = sum(x[b + '_hit'] and not x[a + '_hit'] for x in runs)
        summary[f'{a}_vs_{b}'] = {'wins': w, 'losses': l, 'p': round(eval_keyword.mcnemar(w, l), 4)}
    (out / f'{name}-summary.json').write_text(json.dumps(summary, indent=1) + '\n')
    print(json.dumps(summary, indent=1))


if __name__ == '__main__':
    main()
