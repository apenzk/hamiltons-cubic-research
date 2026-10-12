"""The padded CP^2 Weyl operator: criticality, theta, and its L_e spectrum full vs slice."""
import sys; sys.path.insert(0,'scripts/reviewers/r316')
import numpy as np, core
from scipy.sparse.linalg import LinearOperator, eigsh

def cp2(alg):
    n=alg.N; idx=alg.idx
    def biv(p):
        v=np.zeros(n)
        for (i,j),c in p:
            s=1.0
            if i>j: i,j,s=j,i,-1.0
            v[idx[(i,j)]]+=c*s
        return v/np.linalg.norm(v)
    w1=biv([((0,1),1),((2,3),1)]); w2=biv([((0,2),1),((3,1),1)]); w3=biv([((0,3),1),((1,2),1)])
    W=(2*np.outer(w1,w1)-np.outer(w2,w2)-np.outer(w3,w3))/np.sqrt(6)
    return W

for n in [8,12]:
    alg=core.Alg(n); pr=core.ProjFast(alg)
    W=cp2(alg)
    PQ=pr.apply(alg.Q(W)); th=float(np.sum(PQ*W))
    print(f"n={n}: |W|={np.linalg.norm(W):.9f} in Weyl resid={np.linalg.norm(pr.apply(W)-W):.1e} "
          f"theta={th:.12f} (sqrt(3/2)={np.sqrt(1.5):.12f}) crit resid={np.linalg.norm(PQ-th*W):.2e}")
    sh=core.Sharp(alg,W); D=alg.N*alg.N
    def mk(sg=None):
        def op(v):
            H=v.reshape(alg.N,alg.N); H=0.5*(H+H.T); H=pr.apply(H)
            if sg is not None: H=0.5*(H+sg*H)
            H=H-np.sum(H*W)*W
            Y=pr.apply(sh.L(H))
            if sg is not None: Y=0.5*(Y+sg*Y)
            Y=Y-np.sum(Y*W)*W
            return Y.reshape(-1)
        return op
    for a in ([3,4] if n==8 else [3,6]):
        sg=core.grading_involution(alg,a)
        graded = np.abs(W-sg*W).max()
        wsl=eigsh(LinearOperator((D,D),matvec=mk(sg),dtype=float),k=12,which='LA',
                  return_eigenvectors=False,tol=1e-11,maxiter=40000)
        print(f"   slice ({a},{n-a}): W graded? dev={graded:.1e}  lam_max(slice)={np.sort(wsl)[-1]/th:.9f} "
              f"top4={np.round(np.sort(wsl)[::-1][:4]/th,9)}")
    wf=eigsh(LinearOperator((D,D),matvec=mk(None),dtype=float),k=20,which='LA',
             return_eigenvectors=False,tol=1e-11,maxiter=40000)
    wf=np.sort(wf)[::-1]/th
    print(f"   FULL lam_max={wf[0]:.9f}  #>1/2+1e-8 = {int(np.sum(wf>0.5+1e-8))}  top6={np.round(wf[:6],9)}")
