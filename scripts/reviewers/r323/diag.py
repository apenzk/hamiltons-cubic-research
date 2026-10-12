import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np
def proj(M):
    M=0.5*(M+M.T); np.fill_diagonal(M,0); n=M.shape[0]
    r=M.sum(1); s=r.sum()/(2*n-2); a=(r-s)/(n-2)
    M=M-np.add.outer(a,a); np.fill_diagonal(M,0)
    return M
def Qd(M): 
    A=M*M+M@M; np.fill_diagonal(A,0); return A
def theta_of(M):
    return float(np.sum(Qd(M)*M)/np.sum(M*M))
def newton(M,iters=200):
    n=M.shape[0]
    idx=[(i,j) for i in range(n) for j in range(i+1,n)]
    def vec(X): return np.array([X[i,j] for (i,j) in idx])
    def unvec(z):
        X=np.zeros((n,n))
        for k,(i,j) in enumerate(idx): X[i,j]=X[j,i]=z[k]
        return X
    M=proj(M); M/=np.linalg.norm(M)
    for it in range(iters):
        th=theta_of(M)
        R=proj(Qd(M)-th*M)          # residual projected to the tangent space of the diagonal Weyl locus
        if np.linalg.norm(R)<1e-14: break
        # numeric Jacobian on the (small) parameter space
        z=vec(M); d=len(z); J=np.zeros((d,d)); eps=1e-6
        for k in range(d):
            zz=z.copy(); zz[k]+=eps
            Mk=proj(unvec(zz)); Mk/=np.linalg.norm(Mk)
            J[:,k]=(vec(proj(Qd(Mk)-theta_of(Mk)*Mk))-vec(R))/eps
        try: dz=np.linalg.lstsq(J,-vec(R),rcond=None)[0]
        except np.linalg.LinAlgError: break
        best=np.linalg.norm(R); s=1.0; new=None
        for _ in range(25):
            Mt=proj(unvec(z+s*dz)); 
            if np.linalg.norm(Mt)<1e-12: break
            Mt/=np.linalg.norm(Mt)
            rr=np.linalg.norm(proj(Qd(Mt)-theta_of(Mt)*Mt))
            if rr<best: new=Mt; break
            s*=0.5
        if new is None: break
        M=new
    return M
