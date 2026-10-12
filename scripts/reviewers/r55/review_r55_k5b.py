"""Reviewer 55, K5b/K4e: for each block-size vector, the top solution in four
nested classes -- overall, genuinely k-block, k-block with S=0, and k-block with
S=0 AND a connected non-bipartite negative graph (the 'C_5 class')."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r55_blocks import solve_all, expand, block_pairs
from review_r55_core import theta0, diag_operator, slack_struct
from review_r55_k4 import stats
from review_r55_k5 import coarse_partition

def analyse(sizes, ntry=1500, seed=1):
    k=len(sizes); n=sum(sizes)
    sols=solve_all(sizes, ntry=ntry, seed=seed)
    recs=[]
    for c in sols:
        lam,C=expand(sizes,c)
        d=stats(C,sizes)
        grp=coarse_partition(C,sizes)
        eff=len(grp)
        recs.append((d['ratio'], eff, d['tri'], d['bip'], d['comps'], d['isolated'], C, grp))
    def top(pred):
        f=[r for r in recs if pred(r)]
        return max(f, key=lambda r:r[0]) if f else None
    classes = [
        ("overall",            lambda r: True),
        (f"genuinely {k}-block", lambda r: r[1]==k),
        (f"{k}-block, S=0",      lambda r: r[1]==k and r[2]==0),
        (f"{k}-block, S=0, conn. non-bip.",
                               lambda r: r[1]==k and r[2]==0 and (not r[3]) and r[4]==1 and r[5]==0),
    ]
    print(f"\n=== sizes {tuple(sizes)}  n={n}  theta_0={theta0(n):.6f}   ({len(recs)} solutions)")
    for name,pred in classes:
        t=top(pred)
        if t is None: print(f"   {name:>34}: none"); continue
        print(f"   {name:>34}: th/th0={t[0]:.6f}  eff={t[1]} tri={t[2]} bip={t[3]} comps={t[4]} isolated={t[5]}")
    return recs

if __name__=="__main__":
    for sizes in ([2]*5,[2,2,2,2,3],[2,2,2,3,3],[2,2,2,2,4],[3]*5,[2]*4,[2,2,3,3],[3]*4,[2,2,2],[3,3,3],[2]*6):
        analyse(list(sizes), ntry=int(sys.argv[1]) if len(sys.argv)>1 else 1200)
