"""Reviewer 55, K4b: unbalanced blow-ups -- can a NON-BIPARTITE triangle-free
blow-up approach theta_0?  And check the derived limit law 1/sqrt(r)."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r55_k4 import *
from review_r55_core import theta0

def limit_rank(C, sizes):
    f=np.array(sizes,dtype=float); f/=f.sum()
    K=np.sqrt(np.outer(f,f))*C
    mu=np.linalg.eigvalsh(K)
    nz=mu[np.abs(mu)>1e-9*max(1.0,np.abs(mu).max())]
    r=len(nz)
    pred=(nz**3).sum()/((nz**2).sum())**1.5
    return r, pred, np.round(mu,6)

def run(tag,G,sizes,seeds=100,seed=5):
    sols=solve_blowup(G,sizes,seeds=seeds,seed=seed)
    if not sols: print(f"{tag:>22} {str(sizes):>26} : none"); return None
    best=max((stats(C,sizes),C) for C in sols) if False else None
    bd=None
    for C in sols:
        d=stats(C,sizes)
        if bd is None or d['ratio']>bd[0]['ratio']: bd=(d,C)
    d,C=bd; r,pred,mu = limit_rank(C,sizes)
    print(f"{tag:>22} {str(sizes):>26} n={d['n']:4d} th/th0={d['ratio']:.6f} tri={d['tri']:5d} "
          f"bip={str(d['bip']):5s} r={r} 1/sqrt(r)={1/np.sqrt(r):.4f} pred={pred:.4f}")
    return d

print("=== C_5 blow-up, two large blocks + three singletons (p,q,1,1,1) ===")
for p in [1,2,3,5,8,12,20,40,80,160]:
    run("C5(p,p,1,1,1)",cycle(5),[p,p,1,1,1],seeds=80)
print()
print("=== C_5 blow-up, adjacent large pair (blocks 1,2 adjacent) unbalanced ===")
for p in [2,4,8,16,32,64]:
    run("C5(p,p,2,2,2)",cycle(5),[p,p,2,2,2],seeds=80)
print()
print("=== other triangle-free non-bipartite graphs, equal blocks ===")
for tag,G in [("C7",cycle(7)),("C9",cycle(9)),("C11",cycle(11)),("Petersen",petersen())]:
    k=len(G)
    for m in [2,4,8,16]:
        run(tag,G,[m]*k,seeds=60)
