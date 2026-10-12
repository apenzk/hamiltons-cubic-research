"""r221, claim 4.  Re-run the ONE number the dead-end rests on, three times."""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c4_bench import matrix, sparse_rank, sparse_markowitz
import pickle
d = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(d, "..", "..", "runs")
BL = pickle.load(open(os.path.join(RUNS, "n12_sym3_blocks.pkl"), "rb"))
S3 = pickle.load(open(os.path.join(RUNS, "n12_sym3_char.pkl"), "rb"))
by = {S3[l]: l for l in BL}
for k in [int(x) for x in (sys.argv[1:] or ["6137"])]:
    lam = by[k]
    nc, rows = matrix(lam)
    print(f"{lam}  cols {nc:,}  rows {len(rows):,}  "
          f"nnz {sum(len(r) for r in rows):,}", flush=True)
    for trial in range(3):
        t = time.time(); rk = sparse_rank([dict(r) for r in rows], nc)
        print(f"   author sparse_rank trial {trial+1}: {time.time()-t:7.1f}s "
              f"nullity {nc-rk} (m {BL[lam]})", flush=True)
    t = time.time(); rk = sparse_markowitz([dict(r) for r in rows], nc)
    print(f"   markowitz sparse         : {time.time()-t:7.1f}s "
          f"nullity {nc-rk}", flush=True)
