import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
rng = np.random.default_rng(9909)
for n in range(5, 10):
    # dim check by sampling
    d = dim_W(n)
    S = np.array([pr(rng.standard_normal((n,)*4)).reshape(-1) for _ in range(d + 25)])
    r = np.linalg.matrix_rank(S, tol=1e-8)
    W = rand_weyl(n, rng)
    # trace-free check
    tr1 = np.abs(np.einsum('ijil->jl', W)).max()
    bia = np.abs(W + W.transpose(0,2,3,1) + W.transpose(0,3,1,2)).max()
    M = M_of(W); M = M / np.linalg.norm(M)
    Wn = W / np.linalg.norm(M_of(W))
    rw = ringW(Wn)
    sym = np.abs(rw - rw.T).max()
    Ms = sharp(M, n)
    th = np.trace(M@M@M) + np.sum(Ms*M)
    rhs = 1.5*p3(M) - 0.5*p3(rw)
    print(f"n={n} dimW={d} sampled_rank={r} maxRicci={tr1:.2e} bianchi={bia:.2e} "
          f"dimS20={rw.shape[0]} (expect {(n-1)*(n+2)//2}) ringW_sym={sym:.2e}")
    print(f"    theta={th:.10f}  3/2p3(mu)-1/2p3(om)={rhs:.10f}  diff={th-rhs:.3e} "
          f"  sum om^2={np.sum(np.linalg.eigvalsh(rw)**2):.6f} 3*sum mu^2={3*np.sum(M*M):.6f}")
