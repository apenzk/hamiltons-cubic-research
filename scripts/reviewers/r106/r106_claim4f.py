"""Direct check: maximise theta at fixed off-diagonal mass, compare with the second-order prediction."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
from scipy.optimize import minimize
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_hess import *
from r106_claim4c import orbit_basis
from scipy.sparse.linalg import eigsh, LinearOperator

n=int(sys.argv[1]) if len(sys.argv)>1 else 8
W=sphere_product(n//2,n//2); Ms=to_M(W); Ms/=np.linalg.norm(Ms)
D=len(pairs(n)); N=D*(D-1)//2; th0=theta0(n); iu=np.triu_indices(D,1)
L,_=offdiag_basis_op(Ms,n); U,_=orbit_basis(Ms,n)
def mv(v):
    v=v-U@(U.T@v); w=L.matvec(v); return w-U@(U.T@w)
Lr=LinearOperator((N,N),matvec=mv,dtype=float)
val,vec=eigsh(Lr,k=1,which='LA',tol=1e-11); lam=val[0]/6.0; v=vec[:,0]
def tomat(x):
    d=np.zeros((D,D)); d[iu]=x; return d+d.T
Dl=tomat(v); Dl=Pi_W(Dl,n); Dl=Dl-np.diag(np.diag(Dl)); Dl/=np.linalg.norm(Dl)
print(f"n={n}: lam'={lam:.8f}  C'=1.5lam'-0.75th0={1.5*lam-0.75*th0:+.8f}")
print(f"  direction checks: |diag|={np.abs(np.diag(Dl)).max():.1e} "
      f"weyl-resid={np.abs(Pi_W(Dl,n)-Dl).max():.1e} orbit-overlap={np.abs(U.T@Dl[iu]).max():.1e}")
print(f"{'u=|delta|^2':>12} {'2-t':>10} {'theta':>12} {'pred th0+C*eps':>16} {'2-kappa^2':>11}")
def kappa2(Mm,n,tries=25,iters=200):
    """max over frames of |K(F)|^2, by gradient ascent on SO(n)"""
    rng=np.random.default_rng(5); best=0
    Wt=from_M_fast(Mm,n)
    for _ in range(tries):
        A=rng.standard_normal((n,n))*0.05; Xg=np.linalg.qr(np.eye(n)+A-A.T)[0]
        for it in range(iters):
            Wr=np.einsum('ai,bj,ck,dl,ijkl->abcd',Xg,Xg,Xg,Xg,Wt,optimize=True)
            K=vertex_matrix(Wr); f=np.linalg.norm(K)**2
            # gradient of f wrt rotation, finite difference on so(n) generators
            G=np.zeros((n,n)); h=1e-4
            for i in range(n):
                for j in range(i+1,n):
                    E=np.zeros((n,n)); E[i,j]=h; E[j,i]=-h
                    Y=Xg@(np.eye(n)+E)
                    Wr2=np.einsum('ai,bj,ck,dl,ijkl->abcd',Y,Y,Y,Y,Wt,optimize=True)
                    G[i,j]=(np.linalg.norm(vertex_matrix(Wr2))**2-f)/h; G[j,i]=-G[i,j]
            if np.abs(G).max()<1e-9: break
            Xg=np.linalg.qr(Xg@(np.eye(n)+0.05*G))[0]
        best=max(best,f)
    return best
for u in [0.0,0.002,0.005,0.01,0.02,0.05]:
    Mm=np.sqrt(1-u)*Ms+np.sqrt(u)*Dl
    th=Theta(Mm,n); t=np.linalg.norm(vertex_matrix(from_M_fast(Mm,n)))**2
    eps=2-t
    k2=kappa2(Mm,n,3,60) if u>0 else 2.0
    print(f"{u:>12.4f} {eps:>10.6f} {th:>12.8f} {th0+ (1.5*lam-0.75*th0)*eps:>16.8f} {2-k2:>11.6f}")
