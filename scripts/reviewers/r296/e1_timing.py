import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c
n, p = 8, 3
basis, Pi, Mi = c.block_basis(n, p); d = basis.shape[0]
def W_of(x): return np.einsum('a,aij->ij', x, basis)
def resid(x):
    W = W_of(x); QW = c.Q(n, W); th = float(np.tensordot(QW, W))
    return np.append(np.einsum('aij,ij->a', basis, QW - th*W), float(x@x)-1.0)
def jac(x):
    W = W_of(x); QW = c.Q(n, W); th = float(np.tensordot(QW, W))
    DQ = np.array([W@B + B@W + 2.0*c.sharp_bil(n, W, B) for B in basis])
    M = np.einsum('aij,bij->ab', basis, DQ)
    gq = np.einsum('ij,bij->b', QW, basis); Bw = np.einsum('aij,ij->a', basis, W)
    return np.vstack([M - 3.0*np.outer(Bw, gq) - th*np.eye(d), 2.0*x])
rng = np.random.default_rng(0)
x = rng.normal(size=d); x /= np.linalg.norm(x)
t0=time.time(); resid(x); t1=time.time(); jac(x); t2=time.time()
print(f"resid {t1-t0:.3f}s   jac {t2-t1:.3f}s", flush=True)
t0=time.time()
s = least_squares(resid, x, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=300)
print(f"one least_squares: {time.time()-t0:.1f}s  nfev={s.nfev} njev={s.njev} "
      f"max|F|={np.abs(s.fun).max():.2e}", flush=True)
