"""The degeneracy: is the top eigenspace exactly the O(n)-orbit of the maximiser?"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, time
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_hess import *
from scipy.sparse.linalg import eigsh, LinearOperator

def lambda2_rep(X,n):
    """induced action of X in so(n) on Lambda^2 in the basis e_a ^ e_b, a<b"""
    P,pi=pair_index(n); D=len(P); Xh=np.zeros((D,D))
    for b,(a,bb) in enumerate(P):
        for p in range(n):
            if p!=bb:
                i,j=(p,bb) if p<bb else (bb,p); s=1.0 if p<bb else -1.0
                Xh[pi[(i,j)],b]+=s*X[p,a]
            if p!=a:
                i,j=(a,p) if a<p else (p,a); s=1.0 if a<p else -1.0
                Xh[pi[(i,j)],b]+=s*X[p,bb]
    return Xh

def orbit_basis(M,n):
    P,_=pair_index(n); D=len(P); cols=[]
    for i in range(n):
        for j in range(i+1,n):
            X=np.zeros((n,n)); X[i,j]=1.0; X[j,i]=-1.0
            Xh=lambda2_rep(X,n); d=Xh@M-M@Xh
            cols.append(d[np.triu_indices(D,1)])
    A=np.array(cols).T
    U,s,_=np.linalg.svd(A,full_matrices=False)
    r=int((s>1e-9*s[0]).sum())
    return U[:,:r],s

if __name__=='__main__':
    ns=[int(x) for x in sys.argv[1:]] or [6,8,10,12]
    for n in ns:
        t0=time.time()
        W=sphere_product(n//2,n//2); M=to_M(W); M/=np.linalg.norm(M)
        D=len(pairs(n)); p=q=n//2
        U,s=orbit_basis(M,n)
        L,N=offdiag_basis_op(M,n)
        # full off-diagonal spectrum top
        vals=eigsh(L,k=min(2*p*q+4,N-2),which='LA',tol=1e-10)[0]/6.0
        th0=theta0(n)
        top=vals[np.abs(vals-th0/2)<1e-7]
        # restricted to the orthogonal complement of the orbit
        def mv(v):
            v=v-U@(U.T@v); w=L.matvec(v); return w-U@(U.T@w)
        Lr=LinearOperator((N,N),matvec=mv,dtype=float)
        vr=eigsh(Lr,k=6,which='LA',tol=1e-10)[0]/6.0
        print(f"n={n}: orbit rank={U.shape[1]} (pq={p*q})  lam_max={vals.max():.8f} = theta0/2={th0/2:.8f}? "
              f"mult@theta0/2={len(top)}")
        print(f"      spectrum top (off-diag)  : {np.sort(vals)[::-1][:6].round(6)}")
        print(f"      spectrum top (orbit-perp): {np.sort(vr)[::-1][:6].round(6)}")
        lam2=np.sort(vr)[::-1][0]
        print(f"      lam' = {lam2:.8f}   slope C' = 1.5*lam' - 0.75*theta0 = {1.5*lam2-0.75*th0:+.8f}"
              f"   ({time.time()-t0:.1f}s)")
    