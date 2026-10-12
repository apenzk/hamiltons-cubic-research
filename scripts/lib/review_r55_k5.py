"""Reviewer 55, K5: the coarse-partition trap in the k-block vertex system, and
whether 'all rows of w distinct' is the right genuineness filter."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r55_blocks import solve_all, expand, block_pairs, info
from review_r55_core import theta0, diag_operator, slack_struct, Q

def merge_test(C, sizes, tol=1e-7):
    """Which pairs of blocks can be MERGED into one block of the coarser partition?
    Blocks a,b merge iff c_ax = c_bx for all x not in {a,b}, and the three
    within/between values c_aa, c_ab, c_bb agree on the ones that exist."""
    k=len(sizes); out=[]
    for a in range(k):
        for b in range(a+1,k):
            ok=all(abs(C[a,x]-C[b,x])<tol for x in range(k) if x not in (a,b))
            vals=[]
            if sizes[a]>=2: vals.append(C[a,a])
            if sizes[b]>=2: vals.append(C[b,b])
            vals.append(C[a,b])
            ok = ok and (max(vals)-min(vals) < tol)
            if ok: out.append((a,b))
    return out

def coarse_partition(C,sizes,tol=1e-7):
    k=len(sizes); par=list(range(k))
    def find(x):
        while par[x]!=x: par[x]=par[par[x]]; x=par[x]
        return x
    for (a,b) in merge_test(C,sizes,tol):
        ra,rb=find(a),find(b)
        if ra!=rb: par[ra]=rb
    groups={}
    for a in range(k): groups.setdefault(find(a),[]).append(a)
    return list(groups.values())

def report(sizes, ntry=1500, seed=1, top=8):
    n=sum(sizes)
    sols=solve_all(sizes, ntry=ntry, seed=seed)
    rows=[]
    for c in sols:
        lam,C = expand(sizes,c)
        d=info(sizes,c)
        grp=coarse_partition(C,sizes)
        distinct_rows = len(set(tuple(np.round(C[a],7)) for a in range(len(sizes))))
        W=diag_operator(lam); nrm=np.linalg.norm(W)
        S = slack_struct(n, W/nrm) if nrm>0 else 0.0
        rows.append((d['ratio'], d['tri'], S, len(grp), grp, distinct_rows,
                     [sum(sizes[a] for a in g) for g in grp]))
    rows.sort(key=lambda r:-r[0])
    print(f"\n--- {tuple(sizes)}, n={n}, theta_0={theta0(n):.6f} : {len(rows)} distinct solutions")
    print(f"{'th/th0':>9} {'tri':>5} {'S_struct':>10} {'eff.blocks':>10} {'distinct rows':>13}  grouping (sizes)")
    for r in rows[:top]:
        print(f"{r[0]:9.6f} {r[1]:5d} {r[2]:10.4f} {r[3]:>10d} {r[5]:>13d}  {r[4]} {r[6]}")
    return rows

if __name__=="__main__":
    for sizes in ([2]*5, [2,2,2,2,3], [2,2,2,2,4], [2,2,2,3,3], [1,1,2,2,2]):
        report(sizes)
