"""Reviewer 27: unbiased critical-point sweep at n=6, then lambda_max at each point."""
import sys
import numpy as np
from scipy.optimize import least_squares
import review_r27_core as C, review_r27_measure as M

n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
NSTART = int(sys.argv[2]) if len(sys.argv) > 2 else 200
B = C.weyl_basis(n)
D = B.shape[0]
print('n=%d dim Weyl = %d' % (n, D)); sys.stdout.flush()


def W_of(co):
    return np.einsum('k,kab->ab', co, B)


def resid(co):
    W = W_of(co)
    QW = C.Q(n, W)
    th = float(np.trace(W @ QW))
    r = np.einsum('kab,ab->k', B, QW - th * W)
    return np.concatenate([r, [10.0 * (co @ co - 1.0)]])


rng = np.random.default_rng(2027)
found = []
for t in range(NSTART):
    c0 = rng.normal(size=D); c0 /= np.linalg.norm(c0)
    sol = least_squares(resid, c0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=6000)
    if np.linalg.norm(sol.fun) > 1e-10:
        continue
    co = sol.x / np.linalg.norm(sol.x)
    W = W_of(co)
    th = float(np.trace(W @ C.Q(n, W)))
    if th < 1e-6:
        W = -W; th = -th
    if th < 1e-6:
        continue
    o = M.analyse(n, W, 'r%d' % t)
    S, neg, U, ev = M.gradedness(n, W)
    found.append((th, S, o['lam_max'], o['res'], neg.shape[1]))
    print('%3d  theta=%.9f  S_mmm=%12.6f  lam_max=%.12f  res=%.1e  dim m=%d  %s'
          % (t, th, S, o['lam_max'], o['res'], neg.shape[1],
             'GRADED' if S < 1e-8 else ('*** UNGRADED, lam<=1/2 ***' if o['lam_max'] < 0.5 + 1e-7 else 'ungraded')))
    sys.stdout.flush()

print('\n--- summary: %d critical points' % len(found))
if found:
    ar = np.array([(f[0], f[1], f[2]) for f in found])
    g = ar[ar[:, 1] < 1e-8]; u = ar[ar[:, 1] >= 1e-8]
    print('graded   : %d   theta in [%.6f, %.6f]  lam_max in [%.9f, %.9f]'
          % (len(g), g[:, 0].min() if len(g) else 0, g[:, 0].max() if len(g) else 0,
             g[:, 2].min() if len(g) else 0, g[:, 2].max() if len(g) else 0))
    print('ungraded : %d   theta in [%.6f, %.6f]  lam_max in [%.9f, %.9f]'
          % (len(u), u[:, 0].min() if len(u) else 0, u[:, 0].max() if len(u) else 0,
             u[:, 2].min() if len(u) else 0, u[:, 2].max() if len(u) else 0))
    bad = u[u[:, 2] < 0.5 + 1e-7]
    print('UNGRADED WITH lam_max <= 1/2 : %d' % len(bad))
    for b in bad:
        print('    theta=%.9f S=%.6f lam=%.12f' % tuple(b))
