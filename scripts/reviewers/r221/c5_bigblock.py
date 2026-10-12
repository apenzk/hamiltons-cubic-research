"""r221, bonus.  Run ONE of the 16 blocks the commit calls out of reach.

The commit says the remaining 16 blocks (21,664 to 635,220 columns) need
Wiedemann or block Lanczos because "dense is cubic and out of reach; plain sparse
is worse".  Claim 4 above shows sparse is in fact the FASTEST of the three at
6,137 columns.  If it also clears 21,664, the tail is not out of reach and no new
method is needed to make the next step.
"""
import sys, os, time, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c4_bench import matrix, sparse_markowitz
d = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(d, "..", "..", "runs")
BL = pickle.load(open(os.path.join(RUNS, "n12_sym3_blocks.pkl"), "rb"))
S3 = pickle.load(open(os.path.join(RUNS, "n12_sym3_char.pkl"), "rb"))
by = {S3[l]: l for l in BL}
k = int(sys.argv[1]) if len(sys.argv) > 1 else 21664
lam = by[k]
t0 = time.time()
nc, rows = matrix(lam)
print(f"{lam}  cols {nc:,}  rows {len(rows):,}  nnz {sum(len(r) for r in rows):,}"
      f"  [build {time.time()-t0:.1f}s]", flush=True)
t = time.time()
rk = sparse_markowitz([dict(r) for r in rows], nc)
print(f"  markowitz sparse: rank {rk:,} nullity {nc-rk}  m_lambda {BL[lam]}  "
      f"[{time.time()-t:.1f}s]  {'MATCH' if nc-rk == BL[lam] else 'MISMATCH'}",
      flush=True)
