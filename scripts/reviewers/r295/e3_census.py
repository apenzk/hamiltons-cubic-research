"""The sibling census: rerun the construction's own multistart and screen every solution."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/runs'); sys.path.insert(0, 'scripts/lib')
from scipy.optimize import least_squares
from r295_core import *
from review_r30_core import Q, sharp_bilin, sphere_product_W
from run_f4b_graded_multi import block_diagonal_weyl_basis

n, p = 8, 3
basis, _, _ = block_diagonal_weyl_basis(n, p)
def unpack(x): return np.einsum('a,aij->ij', x, basis)
def resid(x):
    Ww = unpack(x); QW = Q(n, Ww); th = float(np.tensordot(QW, Ww))
    return np.append(np.einsum('aij,ij->a', basis, QW - th * Ww), float(x @ x) - 1.0)
def jac(x):
    Ww = unpack(x); QW = Q(n, Ww); th = float(np.tensordot(QW, Ww))
    DQ = np.array([Ww @ B + B @ Ww + 2.0 * sharp_bilin(n, Ww, B) for B in basis])
    M = np.einsum('aij,bij->ab', basis, DQ)
    gq = np.einsum('ij,bij->b', QW, basis); Bw = np.einsum('aij,ij->a', basis, Ww)
    return np.vstack([M - 3.0 * np.outer(Bw, gq) - th * np.eye(len(x)), 2.0 * x])

W0, _ = sphere_product_W([p, n - p]); W0 /= np.linalg.norm(W0)
c0 = basis.reshape(155, -1) @ W0.reshape(-1)
rng = np.random.default_rng(2)
seen = {}
NS = int(sys.argv[1]) if len(sys.argv) > 1 else 30
for t in range(NS):
    x0 = c0.copy() if t == 0 else c0 + 0.5 * rng.normal(size=155)
    s = least_squares(resid, x0, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=300)
    if np.abs(s.fun).max() > 1e-10:
        print('  start %2d: no convergence (%.1e)' % (t, np.abs(s.fun).max()), flush=True); continue
    Ww = unpack(s.x); Ww /= np.linalg.norm(Ww)
    th = theta(n, Ww)
    if th < 0: Ww, th = -Ww, -th
    D, S, dm, nz, lam, V, tot = defect_quantities(n, Ww)
    r = weyl_residuals(n, Ww)
    full = float(np.abs(Qmap(n, Ww) - th * Ww).max())
    npos = len(set(np.round(lam[lam > 1e-9], 7)))
    key = round(th, 7)
    if key not in seen:
        seen[key] = (th, D, S, dm, nz, npos, full, max(r['ricci'], r['bianchi'], r['trace']), tot)
        np.save('scripts/reviewers/r295/sol_%.7f.npy' % th, Ww)
    print('  start %2d: theta %.9f  Delta %.6f  S %.1e  dimm %2d  nz %d  #pos %d  full %.1e'
          % (t, th, D, S, dm, nz, npos, full), flush=True)
print('\n%10s %10s %9s %5s %3s %4s %9s %9s %8s' % ('theta','Delta','S_mmm','dim m','#0','#pos','fullres','weylres','Casimir'))
for k in sorted(seen, reverse=True):
    th, D, S, dm, nz, npos, full, wr, tot = seen[k]
    print('%10.6f %10.6f %9.1e %5d %3d %4d %9.1e %9.1e %8.4f' % (th, D, S, dm, nz, npos, full, wr, tot))
good = [v for v in seen.values() if v[2] < 1e-8 and v[1] > 1e-6 and v[6] < 1e-10]
print('\ncritical, S = 0, Delta > 0: %d;  highest theta among them: %.9f'
      % (len(good), max(v[0] for v in good) if good else float('nan')))
