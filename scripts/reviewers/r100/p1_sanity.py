import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *

rng = np.random.default_rng(100)
for n in [4,5,6,7,8]:
    B = weyl_basis(n)
    print(f"n={n}: basis dim {B.shape[1]}  expected {dim_weyl(n)}  match={B.shape[1]==dim_weyl(n)}")
    M, v = random_weyl(n, B, rng)
    print("   ||M||_F =", np.linalg.norm(M))
    W = full_tensor(M, n)
    # check symmetries
    print("   pair-antisym err:", np.abs(W + np.transpose(W,(1,0,2,3))).max(),
          " pair-swap err:", np.abs(W - np.transpose(W,(2,3,0,1))).max())
    print("   Bianchi err:", np.abs(W + np.transpose(W,(0,2,3,1)) + np.transpose(W,(0,3,1,2))).max())
    print("   Ricci err:", np.abs(np.einsum('ijil->jl', W)).max())
    A = Wring(W, n)
    print("   Wring dim", A.shape, "expected", (n-1)*(n+2)//2, " sym err", np.abs(A-A.T).max())
    mu = np.linalg.eigvalsh(M); om = np.linalg.eigvalsh(A)
    print("   sum mu^2 =", np.sum(mu**2), " sum om^2 =", np.sum(om**2), " ratio", np.sum(om**2)/np.sum(mu**2))
    th = theta_from_M(M, n)
    rhs = 1.5*p3(mu) - 0.5*p3(om)
    print(f"   theta={th:.12f}  3/2p3(mu)-1/2p3(om)={rhs:.12f}  diff={th-rhs:.3e}")
