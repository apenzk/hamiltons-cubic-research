"""The retrieval tool: chunking, the SQLite index with keywords and vectors, and the query.

    .venv/bin/python scripts/rag/rag.py index [<root>] [--keyword]          # build .rag/index.sqlite
    .venv/bin/python scripts/rag/rag.py query "<text>" [-k 20] [--no-rerank] [--keyword]  # ranked hits, live first

`index` writes the chunks, the two FTS5 tables and, unless `--keyword`, a sqlite-vec table
of Qwen3-Embedding-0.6B vectors into one file. Vectors come from the cache in .rag/vec/qwen/,
keyed by chunk hash, and only chunks missing from it are embedded, so a rerun after an edit
embeds what changed. `query` fuses the keyword and vector rankings, each to depth 200, by
reciprocal rank at k = 60, has Qwen3-Reranker-0.6B rescore the fused top 200 against the
query, then moves live hits first. `--no-rerank` skips the rescoring. `--keyword`, or an index built
without vectors, runs keyword search alone, which needs the standard library only.

Two corpora, one ranking. `raw` is arm B: every text file as filed, cut into 40-line windows
30 lines apart. `structured` is arm C, the inputs of the plan: markdown cut at headings with
the heading trail prepended, paragraphs merged to about 1200 characters and table rows
chunked under their header; scripts cut per top-level function or class, keeping the module
docstring; Lean cut per declaration with its docstring; arXiv papers read from the
flattened `source.tex` and cut per theorem environment; other papers read from pdftotext
with paragraphs rejoined; plus one chunk per row of results.jsonl and values.jsonl,
located at the result's or value's own line. Both corpora rank the same way: BM25 over a
`unicode61` and a `trigram` FTS5 index, fused by reciprocal rank at k = 60.

Status per chunk: `history` for the review and attempt trail, `withdrawn` or `superseded`
for a chunk under a result heading of that status in results.jsonl, `live` otherwise.
"""
import hashlib, json, re, sqlite3, sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import registries

EXT = ('.md', '.py', '.lean', '.tex', '.sage', '.txt', '.sh')
SKIP = ('.claude/', '.git/', '.rag/', '.venv/', 'agent_logs/', 'lean/.lake/', 'scripts/export-public/')
SIZE = 1200
MIN = 300
K_RRF = 60
TOKEN = re.compile(r'[A-Za-z0-9_\\]{2,}')
MD_HEAD = re.compile(r'^(#{1,6}) +(.*)')
PY_TOP = re.compile(r'^(def|class|async def) +(\w+)')
LEAN_DECL = re.compile(r'^(?:@\[[^\]]*\]\s*)?(?:private |protected |noncomputable )*'
                       r'(theorem|lemma|def|abbrev|structure|instance|inductive|class) +([\w.\']+)')
TEX_ENV = re.compile(r'\\begin\{(theorem|lemma|proposition|corollary|definition|conjecture|remark|example)\*?\}')
TEX_SEC = re.compile(r'\\(?:sub)*section\*?\{([^}]*)\}')


def chunk(file, start, end, heading, kind, body, status='live', result_ids=()):
    return {'file': file, 'line_start': start, 'line_end': end, 'heading': heading, 'kind': kind,
            'status': status, 'result_ids': ' '.join(result_ids),
            'hash': hashlib.sha256(f'{file}\0{heading}\0{body}'.encode()).hexdigest(), 'body': body}


def text_files(root):
    for p in sorted(root.rglob('*')):
        rel = p.relative_to(root).as_posix()
        if p.is_file() and p.suffix in EXT and not rel.startswith(SKIP):
            yield rel, p


def windows(rel, lines, kind, status, size=40, step=30):
    for s in range(0, max(len(lines), 1), step):
        body = '\n'.join(lines[s:s + size]).strip()
        if body:
            yield chunk(rel, s + 1, min(s + size, len(lines)), '', kind, body, status)
        if s + size >= len(lines):
            break


def raw_corpus(root):
    for rel, p in text_files(root):
        yield from windows(rel, p.read_text(errors='ignore').splitlines(), 'raw', registries.status_of_file(rel))


def merge(rel, pieces, heading, kind, status, ids):
    """pieces: (line_start, line_end, text). Merged in order until a chunk passes SIZE, and a
    piece shorter than MIN always takes the next one with it. The heading is stored once, in
    the chunk's heading field, and every reader prepends it."""
    buf, s0, e0 = [], None, None
    for s, e, t in pieces:
        n = sum(map(len, buf))
        if buf and n >= MIN and n + len(t) > SIZE:
            yield chunk(rel, s0, e0, heading, kind, '\n\n'.join(buf), status, ids)
            buf, s0 = [], None
        buf.append(t)
        s0 = s if s0 is None else s0
        e0 = e
    if buf:
        yield chunk(rel, s0, e0, heading, kind, '\n\n'.join(buf), status, ids)


def blocks(lines, first=1):
    """Paragraphs and tables of a markdown section: (line_start, line_end, text), a table row
    carrying its header line."""
    i, n = 0, len(lines)
    while i < n:
        if not lines[i].strip():
            i += 1
            continue
        j = i
        if lines[i].startswith('|'):
            header = lines[i]
            j = i + 1
            while j < n and lines[j].startswith('|'):
                if not re.match(r'^\|[\s:|-]+\|\s*$', lines[j]):
                    yield (first + j, first + j, header + '\n' + lines[j])
                j += 1
            i = j
            continue
        while j < n and lines[j].strip() and not lines[j].startswith('|'):
            j += 1
        yield (first + i, first + j - 1, '\n'.join(lines[i:j]))
        i = j


def markdown(rel, lines, status, result_status):
    trail, start = [], 0
    sections = []
    for i, l in enumerate(lines + ['# END']):
        m = MD_HEAD.match(l)
        if m or i == len(lines):
            sections.append((start, i, ' > '.join(t for _, t in trail)))
            if m:
                level = len(m.group(1))
                trail = [(lv, t) for lv, t in trail if lv < level] + [(level, m.group(2).strip())]
                start = i
    for s, e, heading in sections:
        last = heading.rsplit(' > ', 1)[-1]
        h = registries.HEAD.match('#### ' + last) if last else None
        ids = (f'L{h.group(3)}',) if h else ()
        st = result_status.get(ids[0], status) if ids and status == 'live' else status
        body_start = s + 1 if heading and MD_HEAD.match(lines[s] if s < len(lines) else '') else s
        yield from merge(rel, blocks(lines[body_start:e], body_start + 1), heading, 'md', st, ids)


def script(rel, lines, status, decl):
    marks = [i for i, l in enumerate(lines) if decl.match(l)]
    bounds = [0] + marks + [len(lines)]
    for a, b in zip(bounds, bounds[1:]):
        if a == b:
            continue
        m = decl.match(lines[a]) if a in marks else None
        s = a
        if m and rel.endswith('.lean'):
            while s > 0 and (lines[s - 1].strip().endswith('-/') or lines[s - 1].lstrip().startswith(('/--', '--'))):
                s -= 1
        name = m.group(2) if m else 'module'
        body = '\n'.join(lines[s:b]).strip()
        if body:
            for k, piece in enumerate(range(0, len(body), 4 * SIZE)):
                yield chunk(rel, s + 1, b, name, 'code', body[piece:piece + 4 * SIZE], status)


def tex(rel, text):
    lines = text.splitlines()
    marks = [i for i, l in enumerate(lines) if TEX_ENV.search(l) or TEX_SEC.search(l)]
    bounds = [0] + marks + [len(lines)]
    section = ''
    for a, b in zip(bounds, bounds[1:]):
        sec = TEX_SEC.search(lines[a]) if a < len(lines) else None
        if sec:
            section = sec.group(1)
        env = TEX_ENV.search(lines[a]) if a < len(lines) else None
        heading = section + (f' > {env.group(1)}' if env else '')
        yield from merge(rel, [(s, e, t) for s, e, t in blocks(lines[a:b], a + 1)], heading, 'paper', 'live', ())


def rejoin(lines):
    """pdftotext paragraphs rejoined: a line break inside a paragraph becomes a space."""
    out, buf, s0 = [], [], 1
    for i, l in enumerate(lines + ['']):
        if l.strip():
            if not buf:
                s0 = i + 1
            buf.append(l.strip())
        elif buf:
            out.append((s0, i, re.sub(r'-\s+(?=[a-z])', '', ' '.join(buf))))
            buf = []
    return out


def structured_corpus(root, papers):
    results = registries.results(root)
    rstatus = {r['id']: r['status'] for r in results}
    manifest = {r[0]: r for r in registries.manifest(root)}
    for rel, p in text_files(root):
        status = registries.status_of_file(rel)
        if rel.startswith('references/') and rel.endswith('.txt'):
            slug = rel.split('/')[1]
            src = papers / slug / 'source.tex'
            if manifest.get(slug, [''] * 5)[4] and src.exists():
                continue
            yield from merge(rel, rejoin(p.read_text(errors='ignore').splitlines()), slug, 'paper', 'live', ())
            continue
        lines = p.read_text(errors='ignore').splitlines()
        if rel.endswith('.md'):
            yield from markdown(rel, lines, status, rstatus)
        elif rel.endswith(('.py', '.sage')):
            yield from script(rel, lines, status, PY_TOP)
        elif rel.endswith('.lean'):
            yield from script(rel, lines, status, LEAN_DECL)
        else:
            yield from windows(rel, lines, 'raw', status)
    for slug, row in manifest.items():
        src = papers / slug / 'source.tex'
        if row[4] and src.exists():
            yield from tex(f'references/{slug}/{row[1].removesuffix(".pdf")}.txt', src.read_text(errors='ignore'))
    for r in results:
        if r['file']:
            yield chunk(r['file'], r['line'], r['line'], f"{r['id']} {r['kind']}", 'result',
                        f"{r['id']} {r['kind']} ({r['status']}): {r['statement']}", r['status'], (r['id'],))
    for v in registries.values(root):
        yield chunk('findings/INDEX-values.md', v['line'], v['line'], f"value {v['value']}", 'value',
                    f"{v['value']} {v['name']} n={v['n']} {v['file'] or ''}", 'live')


SCHEMA = """
create table chunks(id integer primary key, file, line_start, line_end, heading, kind, status, result_ids, hash, body);
create virtual table chunks_text using fts5(text, content='', tokenize='unicode61');
create virtual table chunks_tri using fts5(text, content='', tokenize='trigram');
"""


def build(conn, chunks):
    conn.executescript(SCHEMA)
    rows = [(i, c['file'], c['line_start'], c['line_end'], c['heading'], c['kind'], c['status'],
             c['result_ids'], c['hash'], c['body']) for i, c in enumerate(chunks, 1)]
    conn.executemany('insert into chunks values (?,?,?,?,?,?,?,?,?,?)', rows)
    docs = [(r[0], r[4] + '\n' + r[9]) for r in rows]
    conn.executemany('insert into chunks_text(rowid, text) values (?,?)', docs)
    conn.executemany('insert into chunks_tri(rowid, text) values (?,?)', docs)
    conn.commit()
    return len(rows)


def terms(q):
    return sorted({t for t in TOKEN.findall(q) if not t.isdigit() or len(t) > 1}, key=q.find)


def ranked(conn, table, q, depth=200):
    toks = terms(q) if table == 'chunks_text' else [t for t in terms(q) if len(t) >= 3]
    if not toks:
        return []
    match = ' OR '.join('"' + t.replace('"', '""') + '"' for t in toks)
    return [r[0] for r in conn.execute(
        f'select rowid from {table} where {table} match ? order by bm25({table}) limit ?', (match, depth))]


def query(conn, q, k=20, live_first=True):
    score = {}
    for table in ('chunks_text', 'chunks_tri'):
        for rank, rid in enumerate(ranked(conn, table, q)):
            score[rid] = score.get(rid, 0) + 1 / (K_RRF + rank + 1)
    order = sorted(score, key=lambda r: -score[r])
    rows = {r[0]: r for r in conn.execute(
        f'select * from chunks where id in ({",".join(map(str, order)) or "0"})')}
    hits = [rows[r] for r in order]
    if live_first:
        hits.sort(key=lambda r: r[6] != 'live')
    return hits[:k]


MODEL = 'Qwen/Qwen3-Embedding-0.6B'
VEC_CACHE = Path('.rag/vec/qwen')
CUT = 1000
TOKENS = 256
DEPTH = 200


def device():
    """The fastest torch device available: a CUDA GPU, then an Apple GPU, then the CPU."""
    import torch
    if torch.cuda.is_available():
        return 'cuda'
    return 'mps' if torch.backends.mps.is_available() else 'cpu'


def load_model():
    """The embedding model at fp16 on the local GPU, read offline once its weights are cached."""
    import os
    if (Path.home() / '.cache/huggingface/hub' / ('models--' + MODEL.replace('/', '--'))).is_dir():
        os.environ['HF_HUB_OFFLINE'] = '1'
    import torch
    from sentence_transformers import SentenceTransformer
    model = SentenceTransformer(MODEL, device=device(), model_kwargs={'torch_dtype': torch.float16})
    model.max_seq_length = TOKENS
    return model


def connect(db):
    conn = sqlite3.connect(db)
    if conn.execute("select 1 from sqlite_master where name = 'chunks_vec'").fetchone():
        import sqlite_vec
        conn.enable_load_extension(True)
        sqlite_vec.load(conn)
        conn.enable_load_extension(False)
    return conn


def add_vectors(conn):
    """Fill chunks_vec from the cache, embedding and caching the chunks it lacks."""
    import time
    import numpy as np
    import sqlite_vec
    vecs = {}
    for f in sorted(VEC_CACHE.glob('*.json')):
        vecs.update(zip(json.load(open(f)), np.load(f.with_suffix('.npy'))))
    rows = conn.execute('select id, hash, heading, body from chunks').fetchall()
    new = {h: (head + '\n' + body)[:CUT] for _, h, head, body in rows if h not in vecs}
    if new:
        keys = sorted(new, key=lambda h: len(new[h]))
        arr = load_model().encode([new[h] for h in keys], batch_size=32, normalize_embeddings=True,
                                  convert_to_numpy=True).astype(np.float16)
        VEC_CACHE.mkdir(parents=True, exist_ok=True)
        stem = VEC_CACHE / f'index-{int(time.time())}'
        np.save(stem.with_suffix('.npy'), arr)
        json.dump(keys, open(stem.with_suffix('.json'), 'w'))
        vecs.update(zip(keys, arr))
    conn.enable_load_extension(True)
    sqlite_vec.load(conn)
    conn.enable_load_extension(False)
    dim = len(next(iter(vecs.values())))
    conn.execute(f'create virtual table chunks_vec using vec0(embedding float[{dim}] distance_metric=cosine)')
    conn.executemany('insert into chunks_vec(rowid, embedding) values (?, ?)',
                     [(i, vecs[h].astype(np.float32).tobytes()) for i, h, _, _ in rows])
    conn.commit()
    return len(new)


RERANKER = 'Qwen/Qwen3-Reranker-0.6B'
RERANK_TASK = 'Given a mathematical claim, retrieve passages of a research record that state, prove or bound it'
_reranker = None


def load_reranker():
    """Qwen3-Reranker-0.6B at fp16 on the local GPU, with its tokenizer and the ids of its yes and no answers."""
    global _reranker
    if _reranker is None:
        import os
        if (Path.home() / '.cache/huggingface/hub' / ('models--' + RERANKER.replace('/', '--'))).is_dir():
            os.environ['HF_HUB_OFFLINE'] = '1'
        import torch
        from transformers import AutoModelForCausalLM, AutoTokenizer
        tok = AutoTokenizer.from_pretrained(RERANKER, padding_side='left')
        model = AutoModelForCausalLM.from_pretrained(RERANKER, torch_dtype=torch.float16).to(device()).eval()
        _reranker = (tok, model, tok.convert_tokens_to_ids('yes'), tok.convert_tokens_to_ids('no'))
    return _reranker


def rerank(q, rows, batch=4):
    """Each row's probability, read off the reranker's yes and no logits, that its chunk answers q."""
    import torch
    tok, model, yes, no = load_reranker()
    head = ('<|im_start|>system\nJudge whether the Document meets the requirements based on the Query and the '
            'Instruct provided. Note that the answer can only be "yes" or "no".<|im_end|>\n<|im_start|>user\n')
    tail = '<|im_end|>\n<|im_start|>assistant\n<think>\n\n</think>\n\n'
    texts = [f'{head}<Instruct>: {RERANK_TASK}\n<Query>: {q}\n<Document>: {(r[4] + chr(10) + r[9])[:CUT]}{tail}'
             for r in rows]
    scores = []
    with torch.no_grad():
        for i in range(0, len(texts), batch):
            enc = tok(texts[i:i + batch], padding=True, truncation=True, max_length=1024, return_tensors='pt').to(device())
            last = model(**enc, logits_to_keep=1).logits[:, -1, :]
            scores += torch.softmax(torch.stack([last[:, no], last[:, yes]], 1).float(), 1)[:, 1].tolist()
    return scores


def fused(conn, q, k=20, rerank_top=False):
    """Keyword and vector rankings fused by reciprocal rank, then live hits first. With rerank_top,
    the reranker reorders the fused top DEPTH before the live-first sort."""
    import numpy as np
    score = {}
    for table in ('chunks_text', 'chunks_tri'):
        for rank, rid in enumerate(ranked(conn, table, q, DEPTH)):
            score[rid] = score.get(rid, 0) + 1 / (K_RRF + rank + 1)
    keyword = sorted(score, key=lambda r: -score[r])[:DEPTH]
    v = load_model().encode([q], normalize_embeddings=True, convert_to_numpy=True, prompt_name='query')[0]
    vector = [r[0] for r in conn.execute(
        'select rowid from chunks_vec where embedding match ? and k = ? order by distance',
        (v.astype(np.float32).tobytes(), DEPTH))]
    fuse = {}
    for lst in (keyword, vector):
        for rank, rid in enumerate(lst):
            fuse[rid] = fuse.get(rid, 0) + 1 / (K_RRF + rank + 1)
    order = sorted(fuse, key=lambda r: -fuse[r])
    rows = {r[0]: r for r in conn.execute(
        f'select * from chunks where id in ({",".join(map(str, order)) or "0"})')}
    ranked_rows = [rows[r] for r in order]
    if rerank_top:
        top = ranked_rows[:DEPTH]
        s = rerank(q, top)
        ranked_rows = [r for _, r in sorted(zip(s, top), key=lambda x: -x[0])] + ranked_rows[DEPTH:]
    hits = sorted(ranked_rows, key=lambda r: r[6] != 'live')
    return hits[:k]


def log_size(conn, embedded):
    """Append this build's size to RAG-SIZE.json at the root and rewrite RAG-SIZE.md from it."""
    import datetime, subprocess
    mb = lambda p: round(sum(f.stat().st_size for f in ([p] if p.is_file() else p.rglob('*'))) / 2**20, 1)
    rows = json.loads(Path('RAG-SIZE.json').read_text()) if Path('RAG-SIZE.json').exists() else []
    head = subprocess.run(['git', 'rev-parse', '--short', 'HEAD'], capture_output=True, text=True).stdout.strip()
    has_vec = conn.execute("select 1 from sqlite_master where name = 'chunks_vec'").fetchone()
    rows.append({'time': datetime.datetime.now().isoformat(timespec='seconds'), 'commit': head,
                 'chunks': conn.execute('select count(*) from chunks').fetchone()[0],
                 'embedded': embedded, 'vectors': bool(has_vec), 'index_mb': mb(Path('.rag/index.sqlite')),
                 'cache_mb': mb(VEC_CACHE) if VEC_CACHE.exists() else 0.0})
    Path('RAG-SIZE.json').write_text(json.dumps(rows, indent=1) + '\n')
    chart = subprocess.run([sys.executable, str(Path(__file__).parent / 'figures/size.py')]).returncode == 0
    last = rows[-1]
    lines = ['# Retrieval index size', '',
             f"**{last['index_mb']} MB index and {last['cache_mb']} MB vector cache, {last['chunks']} chunks, "
             f"built {last['time'].replace('T', ' ')} at {last['commit']}.** Written by `rag.py index` after "
             'every build, from RAG-SIZE.json beside it.', '']
    if chart:
        lines += ['![Index and vector cache size in MB after each build](RAG-SIZE.png)', '',
                  '***Fig. Retrieval index size.*** *Size of index.sqlite, rebuilt in full at each build, and of the '
                  'vector cache, which keeps every embedded version of every chunk. Drawn by '
                  '[size.py](scripts/rag/figures/size.py).*', '']
    lines += ['| built | commit | chunks | newly embedded | index MB | cache MB |', '|---|---|---|---|---|---|']
    lines += [f"| {r['time'].replace('T', ' ')} | {r['commit']} | {r['chunks']} | "
              f"{r['embedded'] if r['vectors'] else 'keywords only'} | {r['index_mb']} | {r['cache_mb']} |"
              for r in reversed(rows)]
    Path('RAG-SIZE.md').write_text('\n'.join(lines) + '\n')


def main():
    cmd = sys.argv[1]
    keyword_only = '--keyword' in sys.argv
    args = [a for a in sys.argv[2:] if not a.startswith('--')]
    db = Path('.rag/index.sqlite')
    if cmd == 'index':
        root = Path(args[0] if args else '.')
        db.unlink(missing_ok=True)
        conn = sqlite3.connect(db)
        conn.execute('pragma journal_mode=wal')
        print(build(conn, structured_corpus(root, Path('.rag/papers'))), 'chunks')
        embedded = 0
        if not keyword_only:
            embedded = add_vectors(conn)
            print(embedded, 'chunks embedded, the rest from the cache')
        log_size(conn, embedded)
    elif cmd == 'query':
        k = int(sys.argv[sys.argv.index('-k') + 1]) if '-k' in sys.argv else 20
        conn = connect(db)
        has_vec = conn.execute("select 1 from sqlite_master where name = 'chunks_vec'").fetchone()
        hits = (query(conn, args[0], k) if keyword_only or not has_vec
                else fused(conn, args[0], k, rerank_top='--no-rerank' not in sys.argv))
        for i, r in enumerate(hits, 1):
            print(f'{i}  {r[6]}  {r[1]}:{r[2]}-{r[3]}  {r[4]}')
            print('    ' + ' '.join(r[9].split())[:200])


if __name__ == '__main__':
    main()
