"""r295: rebuild the n=8 non-diagonal witness from the construction, independently.

Basis and Newton solve follow run_f4b_newton.py.  Everything downstream (Weyl checks,
theta, Delta, S_mmm, the wedge certificate) is re-derived in r295_core.py from the
definitions, so agreement is evidence and disagreement is the finding.
"""
import sys, numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib'); sys.path.insert(0, 'scripts/runs')
from review_r30_core import sphere_product_W, Q, sharp_bilin
from run_f4b_graded_multi import block_diagonal_weyl_basis
from weyl_screen import theta_screened

n, p = 8, 3
basis, Pi, Mi = block_diagonal_weyl_basis(n, p)

def unpack(c): return np.einsum('a,aij->ij', c, basis)
def resid(c):
    W = unpack(c); QW = Q(n, W); th = float(np.tensordot(QW, W))
    return np.append(np.einsum('aij,ij->a', basis, QW - th * W), float(c @ c) - 1.0)
def jac(c):
    W = unpack(c); QW = Q(n, W); th = float(np.tensordot(QW, W))
    DQ = np.array([W @ B + B @ W + 2.0 * sharp_bilin(n, W, B) for B in basis])
    M = np.einsum('aij,bij->ab', basis, DQ)
    gq = np.einsum('ij,bij->b', QW, basis)
    Bw = np.einsum('aij,ij->a', basis, W)
    return np.vstack([M - 3.0 * np.outer(Bw, gq) - th * np.eye(len(c)), 2.0 * c])

W0, _ = sphere_product_W([p, n - p]); W0 = W0 / np.linalg.norm(W0)
c0 = np.einsum('aij,ij->a', basis, W0)
print('control |resid(c0)| = %.2e' % np.abs(resid(c0)).max(), flush=True)

seed = int(sys.argv[1]) if len(sys.argv) > 1 else 2
nstarts = int(sys.argv[2]) if len(sys.argv) > 2 else 30
kick = float(sys.argv[3]) if len(sys.argv) > 3 else 0.5
rng = np.random.default_rng(seed)
sols = {}
for t in range(nstarts):
    c = c0.copy() if t == 0 else c0 + kick * rng.normal(size=len(c0))
    s = least_squares(resid, c, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
    if np.abs(s.fun).max() > 1e-10: continue
    W = unpack(s.x); W = W / np.linalg.norm(W)
    th, info = theta_screened(n, W)
    if th < 0: W, th = -W, -th
    key = round(th, 6)
    if key not in sols: sols[key] = W
    if t % 5 == 0: print('  start %d/%d distinct %d' % (t, nstarts, len(sols)), flush=True)
np.savez('scripts/reviewers/r295/rebuilt.npz', **{('W%.6f' % k): v for k, v in sols.items()})
for k in sorted(sols, reverse=True)[:12]:
    print('  theta = %.9f' % k, flush=True)
print('saved %d solutions' % len(sols))
