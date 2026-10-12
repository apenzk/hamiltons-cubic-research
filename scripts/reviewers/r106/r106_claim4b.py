"""Claim 4: the exact slope of the degradation off the coordinate-diagonal locus."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, time
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r106'))
from r106_core import *
from r106_hess import *
from scipy.sparse.linalg import eigsh

ns=[int(x) for x in sys.argv[1:]] or [6,8,10,12]
print(f"{'n':>3} {'theta0':>10} {'lam_max(q)':>12} {'theta0/2':>10} {'slope C':>10} {'time':>7}")
for n in ns:
    t0=time.time()
    W=sphere_product(n//2,n//2); M=to_M(W); M/=np.linalg.norm(M)
    D=len(pairs(n))
    L,N=offdiag_basis_op(M,n)
    vals=eigsh(L,k=3,which='LA',tol=1e-9,maxiter=5000)[0]
    lam=vals.max()/6.0
    th0=theta0(n); C=1.5*lam-0.75*th0
    print(f"{n:>3} {th0:>10.6f} {lam:>12.8f} {th0/2:>10.6f} {C:>10.6f} {time.time()-t0:>6.1f}s")
    np.save(f'/tmp/r106_lam_{n}.npy',vals)
