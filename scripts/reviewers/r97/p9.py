import sys,itertools; sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
def collapse_dim(N, blocks):
    """blocks: list of index-lists, each constrained to sum to zero."""
    tri=list(itertools.combinations(range(N),3))
    # basis of the constrained lambda-space
    C=np.zeros((len(blocks),N))
    for r,b in enumerate(blocks):
        for i in b: C[r,i]=1.0
    U,S,Vt=np.linalg.svd(C); rk=int((S>1e-10).sum()); P=Vt[rk:].T   # N x (N-rk)
    k=P.shape[1]
    R=3*(len(tri)+1)+50
    rng=np.random.default_rng(3)
    rows=[]
    for _ in range(R):
        mu=rng.normal(size=k); lam=P@mu
        row=[lam[a]*lam[b]*lam[g] for a,b,g in tri]
        row.append(-sum(lam[a]*lam[b]*lam[g] for a,b,g in tri))  # -e3
        rows.append(row)
    A=np.array(rows)
    s=np.linalg.svd(A,compute_uv=False)
    nul=int((s<1e-8*s[0]).sum())+max(0,A.shape[1]-len(s))
    return len(tri), nul
print("verifying post 2g's collapse-space table (dim of {(T,kappa)} with sum T lam^3 = kappa e_3 on the constrained space):")
for label,N,blocks in [("N=6 one global",6,[list(range(6))]),
                       ("N=6 two (3+3)",6,[[0,1,2],[3,4,5]]),
                       ("N=6 three (2+2+2)",6,[[0,1],[2,3],[4,5]]),
                       ("N=7 one global",7,[list(range(7))]),
                       ("N=7 two (3+4)",7,[[0,1,2],[3,4,5,6]]),
                       ("N=9 three (3+3+3)",9,[[0,1,2],[3,4,5],[6,7,8]]),
                       ("N=10 one global (n=5!)",10,[list(range(10))]),
                       ("N=15 one global (n=6)",15,[list(range(15))])]:
    t,d=collapse_dim(N,blocks); print(f"  {label:26s} collapse dim {d} of {t}")
