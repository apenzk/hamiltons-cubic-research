import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np
from scipy.optimize import least_squares
def make(n):
    idx=[(i,j) for i in range(n) for j in range(i+1,n)]
    def unvec(z):
        X=np.zeros((n,n))
        for k,(i,j) in enumerate(idx): X[i,j]=X[j,i]=z[k]
        return X
    def vec(X): return np.array([X[i,j] for (i,j) in idx])
    def proj(M):
        M=0.5*(M+M.T); np.fill_diagonal(M,0)
        r=M.sum(1); s=r.sum()/(2*n-2); a=(r-s)/(n-2)
        M=M-np.add.outer(a,a); np.fill_diagonal(M,0); return M
    def norm(M):
        nn=np.linalg.norm(M); return M/nn if nn>1e-14 else M
    def Qd(M):
        A=M*M+M@M; np.fill_diagonal(A,0); return A
    def Mof(z): return norm(proj(unvec(z)))
    def resid(z):
        M=Mof(z); Q=Qd(M); th=float(np.sum(Q*M))
        return vec(Q-th*M)
    return idx,unvec,vec,proj,norm,Qd,Mof,resid
def solve(n,z0):
    idx,unvec,vec,proj,norm,Qd,Mof,resid=make(n)
    r=least_squares(resid,z0,method='lm',xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=20000)
    M=Mof(r.x); return M,float(np.sum(Qd(M)*M)),np.linalg.norm(resid(r.x))
