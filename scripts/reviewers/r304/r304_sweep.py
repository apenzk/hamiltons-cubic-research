"""Broad sweep of diagonal critical points: kernel structure, Delta, and lam_diag vs theta/2."""
import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from r304_solve import find, signature
from r304_prize import lam_diag

def components(M, tol=1e-9):
    n=M.shape[0]; seen=[-1]*n; comp=0
    for i in range(n):
        if seen[i]>=0: continue
        stack=[i]; seen[i]=comp
        while stack:
            u=stack.pop()
            for v in range(n):
                if abs(M[u,v])>tol and seen[v]<0: seen[v]=comp; stack.append(v)
        comp+=1
    return comp, seen

def ker_is_components(M, tol=1e-9):
    ev,V=np.linalg.eigh(M); ker=V[:,np.abs(ev)<tol]
    k,lab=components(M,tol)
    ind=np.zeros((M.shape[0],k))
    for i,l in enumerate(lab): ind[i,l]=1.0
    # span(ker) vs span(indicators): compare projectors
    def proj(A):
        if A.shape[1]==0: return np.zeros((A.shape[0],A.shape[0]))
        q,_=np.linalg.qr(A); return q@q.T
    return ker.shape[1], k, float(np.abs(proj(ker)-proj(ind)).max())

n=int(sys.argv[1]); tries=int(sys.argv[2]); seed=int(sys.argv[3])
sols=find(n,tries,seed=seed); seen={}
for M,r in sols:
    th=C.theta_of(M); key=(round(th,6),signature(M,4))
    seen.setdefault(key,M)
print(f"n={n}: {len(sols)}/{tries} converged, {len(seen)} distinct spectra")
viol=[]
for (th,_),M in sorted(seen.items(), key=lambda kv:-kv[0][0]):
    d,_=C.defect_delta(M); lm=lam_diag(M); kd,nc,diff=ker_is_components(M)
    flag=''
    if th>1e-8 and d>1e-7 and lm<=th/2+1e-9: flag=' *** PRIZE ***'; viol.append(M)
    print(f"  theta={th:+.6f} Delta={d:9.4f} lam={lm:+.6f} gap={lm-th/2:+.6f} "
          f"dimker={kd} ncomp={nc} kerNEcomp={diff:.1e}{flag}")
