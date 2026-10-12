"""Is the saved witness a solution of the stated restricted system, and does the stated
solver return to it from a perturbed start?  (A cheap stand-in for the full 30-start
rebuild while the machine is loaded.)"""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/runs'); sys.path.insert(0, 'scripts/lib')
from scipy.optimize import least_squares
from r295_core import *
from review_r30_core import Q, sharp_bilin
from run_f4b_graded_multi import block_diagonal_weyl_basis, graded_split

n, p = 8, 3
basis, Pi, Mi = block_diagonal_weyl_basis(n, p)
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
print('dim V = %d, dim p = %d, dim m = %d' % (basis.shape[0], len(Pi), len(Mi)))
print('W is block-diagonal for so(3)+so(5): off-block mass = %.3e'
      % np.linalg.norm(W[np.ix_(Pi, Mi)]))
flat = basis.reshape(155, -1)
c = flat @ W.reshape(-1)
print('W in V: reconstruction error = %.3e, ||c|| - 1 = %.3e'
      % (np.linalg.norm(flat.T @ c - W.reshape(-1)), np.linalg.norm(c) - 1))

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

print('residual of the stated restricted system at the saved W: %.3e' % np.abs(resid(c)).max())
rng = np.random.default_rng(7)
for k, eps in enumerate((0.02, 0.05, 0.10)):
    x0 = c + eps * rng.normal(size=155); x0 /= np.linalg.norm(x0)
    s = least_squares(resid, x0, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
    Wn = unpack(s.x); Wn /= np.linalg.norm(Wn)
    th = theta(n, Wn)
    if th < 0: Wn, th = -Wn, -th
    print('  kick %.2f -> |resid| %.2e  theta %.12f  ||W_new - W|| %.3e'
          % (eps, np.abs(s.fun).max(), th, min(np.linalg.norm(Wn - W), np.linalg.norm(Wn + W))))

# --- screen the extra solution found from the local kick ---
print('\nscreening the solutions reached from local kicks around the witness:')
for eps, seed in ((0.05, 7), (0.05, 21), (0.03, 33), (0.04, 44), (0.06, 55)):
    rg = np.random.default_rng(seed)
    x0 = c + eps * rg.normal(size=155); x0 /= np.linalg.norm(x0)
    s = least_squares(resid, x0, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=400)
    if np.abs(s.fun).max() > 1e-10:
        print('  eps %.2f seed %d: no convergence' % (eps, seed)); continue
    Wn = unpack(s.x); Wn /= np.linalg.norm(Wn); th = theta(n, Wn)
    if th < 0: Wn, th = -Wn, -th
    D, S, dm, nz, lam, V, tot = defect_quantities(n, Wn)
    r = weyl_residuals(n, Wn)
    npos = len(set(np.round(lam[lam > 1e-9], 7)))
    print('  eps %.2f seed %2d: theta %.9f  Delta %.6f  S %.1e  dimm %2d  nz %d  #pos %d'
          '  full %.1e  weyl %.1e'
          % (eps, seed, th, D, S, dm, nz, npos, float(np.abs(Qmap(n, Wn) - th*Wn).max()),
             max(r['ricci'], r['bianchi'], r['trace'])))
