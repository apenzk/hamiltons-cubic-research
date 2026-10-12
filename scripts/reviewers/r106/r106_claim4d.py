"""Dense spectrum of the second-order form on Weyl_off, exact multiplicities."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, time
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_hess import *
from r106_claim4c import orbit_basis

for n in [int(x) for x in (sys.argv[1:] or ['6','8'])]:
    t0=time.time()
    W=sphere_product(n//2,n//2); M=to_M(W); M/=np.linalg.norm(M)
    D=len(pairs(n)); N=D*(D-1)//2; th0=theta0(n)
    L,_=offdiag_basis_op(M,n)
    A=np.zeros((N,N))
    E=np.eye(N)
    for k in range(N): A[:,k]=L.matvec(E[:,k])
    A=(A+A.T)/2
    w,V=np.linalg.eigh(A/6.0)
    nz=w[np.abs(w)>1e-9]
    U,_=orbit_basis(M,n)
    # dimension of Weyl_off
    P=np.zeros((N,N))
    for k in range(N):
        d=np.zeros((D,D)); iu=np.triu_indices(D,1); d[iu]=E[:,k]; d=d+d.T
        B=Pi_W(d,n); B=B-np.diag(np.diag(B)); P[:,k]=B[iu]
    dim_off=int(round(np.trace(P)))
    vals,counts=np.unique(np.round(w,9),return_counts=True)
    top=[(v,c) for v,c in zip(vals,counts) if v>1e-9]
    print(f"n={n}: dim(Weyl_off)={dim_off}  dim(W_n)={n*(n+1)*(n+2)*(n-3)//12}  orbit dim={U.shape[1]} (pq={(n//2)**2})")
    print(f"   theta0/2={th0/2:.8f}; positive eigenvalues of q (value, multiplicity):")
    for v,c in sorted(top,reverse=True)[:8]:
        print(f"      {v:+.8f}  x{c}   (= {v/th0:.6f} * theta0)")
    lam=w.max()
    # projection of the top eigenspace onto the orbit
    tol=1e-7; idx=np.where(np.abs(w-lam)<tol)[0]
    Vt=V[:,idx]
    ov=np.linalg.svd(U.T@Vt,compute_uv=False)
    print(f"   top eigenspace dim={len(idx)}; principal angles cos = {np.round(ov,6)}")
    # orbit-perp max
    Q=np.eye(N)-U@U.T
    wr=np.linalg.eigvalsh(Q@(A/6.0)@Q)
    print(f"   orbit-perp lam' = {wr.max():.8f} = {wr.max()/th0:.6f}*theta0 ; slope C' = {1.5*wr.max()-0.75*th0:+.8f}  ({time.time()-t0:.1f}s)")
