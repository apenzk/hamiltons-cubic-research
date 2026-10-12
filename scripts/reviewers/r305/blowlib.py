import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from scipy.optimize import least_squares

def blowup(graph_edges, sizes):
    """block-constant vertex matrix on blocks of given sizes; graph_edges = adjacency of blocks.
    Three orbit types -> solve criticality within the ansatz."""
    k=len(sizes); n=sum(sizes)
    off=np.cumsum([0]+list(sizes))
    types=np.zeros((n,n),int)   # 0 inside, 1 across-edge, 2 across-nonedge
    for b1 in range(k):
        for b2 in range(k):
            for i in range(off[b1],off[b1+1]):
                for j in range(off[b2],off[b2+1]):
                    if i==j: continue
                    if b1==b2: types[i,j]=0
                    elif (min(b1,b2),max(b1,b2)) in graph_edges: types[i,j]=1
                    else: types[i,j]=2
    def build(p):
        M=np.zeros((n,n))
        for t in range(3): M[types==t]=p[t]
        np.fill_diagonal(M,0)
        return M
    def res(p):
        M=build(p)
        Phi=M*M+M@M; Phi=Phi-np.diag(np.diag(Phi))
        th=np.sum(M*Phi)/np.sum(M*M) if np.sum(M*M)>1e-12 else 0
        r=(Phi-th*M)
        r=r-np.diag(np.diag(r))
        return np.array([r[types==t].sum() if (types==t).any() else 0.0 for t in range(3)]
                        +[np.abs(M.sum(1)).max()*10, np.sum(M*M)-2.0])
    best=None
    for s in range(80):
        rng=np.random.default_rng(s)
        sol=least_squares(res,rng.normal(size=3),xtol=1e-15,ftol=1e-15,gtol=1e-15)
        M=build(sol.x)
        if np.sum(M*M)<1e-6: continue
        M=M/np.linalg.norm(M)*np.sqrt(2)
        rr,th=crit_res(M)
        if rr<1e-12 and np.abs(M.sum(1)).max()<1e-12 and th>1e-6:
            if best is None or th>best[1]: best=(M,th)
    return best

