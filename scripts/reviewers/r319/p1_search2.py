"""Faster: is every two-eigenvalue critical Weyl operator a subalgebra Casimir? n=6."""
import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core
from scipy.optimize import least_squares
n=6; A=build.Arena(n); N=A.N
Bs=core.weyl_basis(n); d=Bs.shape[0]; G=Bs.reshape(d,N*N)
Pw = G.T@G                      # projector onto Weyl inside all N x N matrices
def make(x,r):
    M=x.reshape(N,r); Qm,_=np.linalg.qr(M); Pi=Qm@Qm.T
    Wr=Pi-(r/N)*np.eye(N); return Wr/np.sqrt(np.sum(Wr*Wr)), Qm
def resid(x,r):
    W,_=make(x,r); v=W.reshape(-1)
    th=A.P3(W); R=A.Q(W)-th*W
    return np.concatenate([v-Pw@v, R[np.triu_indices(N)]])
def defect(Qm):
    P=Qm@Qm.T; ev,evec=np.linalg.eigh(np.eye(N)-P); mb=evec[:,ev>0.5].T
    T=np.einsum('abc,ia,jb,kc->ijk',A.c,Qm.T,Qm.T,mb,optimize=True); return float(np.sum(T**2))
rng=np.random.default_rng(319)
for r in range(1,N):
    sols=[]
    for t in range(30):
        sol=least_squares(resid,rng.normal(size=N*r),args=(r,),xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=1500)
        if np.linalg.norm(sol.fun)<1e-9:
            W,Qm=make(sol.x,r); sols.append((A.P3(W),defect(Qm)))
    if sols:
        print(f"r={r:2d} sols={len(sols):2d} theta range=[{min(s[0] for s in sols):.6f},{max(s[0] for s in sols):.6f}]"
              f" max subalgebra-defect={max(s[1] for s in sols):.3e}",flush=True)
    else:
        print(f"r={r:2d} none",flush=True)
print("DONE")
