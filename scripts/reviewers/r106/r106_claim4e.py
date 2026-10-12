"""n=14,16: orbit-deflated top of the second-order form, testing lam' = theta0(n-4)/(2(n-2))."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, time
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_hess import *
from r106_claim4c import orbit_basis
from scipy.sparse.linalg import eigsh, LinearOperator
for n in [int(x) for x in sys.argv[1:]]:
    t0=time.time()
    W=sphere_product(n//2,n//2); M=to_M(W); M/=np.linalg.norm(M)
    th0=theta0(n); D=len(pairs(n)); N=D*(D-1)//2
    L,_=offdiag_basis_op(M,n)
    U,s=orbit_basis(M,n)
    # Rayleigh quotient of orbit directions
    rq=[]
    for k in range(min(4,U.shape[1])):
        v=U[:,k]; rq.append(v@L.matvec(v)/6.0/(v@v))
    print(f"n={n}: orbit dim={U.shape[1]} (pq={(n//2)**2}); orbit Rayleigh={np.round(rq,8)} vs theta0/2={th0/2:.8f}",flush=True)
    def mv(v):
        v=v-U@(U.T@v); w=L.matvec(v); return w-U@(U.T@w)
    Lr=LinearOperator((N,N),matvec=mv,dtype=float)
    vals,vecs=eigsh(Lr,k=6,which='LA',tol=1e-9,maxiter=10000)
    vals=vals/6.0
    lam=vals.max(); v=vecs[:,np.argmax(vals)]
    res=np.linalg.norm(Lr.matvec(v)/6.0-lam*v)
    pred=th0*(n-4)/(2*(n-2))
    print(f"   top orbit-perp eigenvalues: {np.round(np.sort(vals)[::-1],8)}")
    print(f"   lam'={lam:.8f}  predicted theta0(n-4)/(2(n-2))={pred:.8f}  resid={res:.1e}")
    print(f"   slope C' = 1.5 lam' - 0.75 theta0 = {1.5*lam-0.75*th0:+.8f}  "
          f"predicted -1.5 theta0/(n-2) = {-1.5*th0/(n-2):+.8f}   ({time.time()-t0:.0f}s)",flush=True)
