"""E2': is ||omega ^ omega|| constant on the lambda = -0.302413 eigenplane, and why?"""
import sys, itertools
sys.path.insert(0, 'scripts/reviewers/r295')
import numpy as np
from r295_core import *

n = 8
W = np.load(sys.argv[1] if len(sys.argv) > 1 else 'scripts/data/w_n8_nondiagonal_witness.npy')
lam, V = np.linalg.eigh(W)
print('spectrum gaps around the target eigenvalue:')
for i in range(len(lam)):
    print('  %2d  %.12f' % (i, lam[i]))
    if i > 4: break

sel = np.abs(lam - lam[0]) < 1e-8
k = int(sel.sum())
print('multiplicity at %.12f : %d   gap to next %.3e' % (lam[0], k, lam[k] - lam[0]))
E = V[:, sel]                      # (28, 2)
u, v = E[:, 0], E[:, 1]

# --- the instrument, pinned by hand on known examples -------------------------
idx = {p: a for a, p in enumerate(pairs_of(n))}
def vec(terms):
    w = np.zeros(28)
    for (i, j), c in terms: w[idx[(i, j)]] = c
    return w
r2 = 1 / np.sqrt(2)
known = {
 'e12 (decomposable)':            vec([((0,1), 1.0)]),
 '(e12+e34)/r2 (self-dual R^4)':  vec([((0,1), r2), ((2,3), r2)]),
 '(e12+e34+e56+e78)/2':           vec([((0,1),.5),((2,3),.5),((4,5),.5),((6,7),.5)]),
 '(e12+e34+e56)/r3':              vec([((0,1),1/np.sqrt(3)),((2,3),1/np.sqrt(3)),((4,5),1/np.sqrt(3))]),
}
print('\nA. instrument on hand-computable unit bivectors '
      '(||w^w||^2 = 2(1 - sum a_k^4) for normal form a):')
for nm, w in known.items():
    pl = plucker_vec(n, w)
    print('   %-32s  ||pluecker|| = %.6f   ||w^w|| = 2*that = %.6f'
          % (nm, np.linalg.norm(pl), 2 * np.linalg.norm(pl)))

# --- constancy on the plane, exactly ------------------------------------------
U = plucker_vec(n, u); Vv = plucker_vec(n, v); M = plucker_bilin(n, u, v)
C = 0.5 * (U + Vv); a = 0.5 * (U - Vv); b = M
print('\nB. q(t) = C + cos(2t) a + sin(2t) b   (Pluecker coords of omega(t)^omega(t)/2)')
print('   ||C|| = %.3e   ||a|| = %.12f   ||b|| = %.12f' % (np.linalg.norm(C), np.linalg.norm(a), np.linalg.norm(b)))
print('   <C,a> = %.3e   <C,b> = %.3e   <a,b> = %.3e   ||a||^2-||b||^2 = %.3e'
      % (C @ a, C @ b, a @ b, a @ a - b @ b))
print('   => ||pluecker(omega(t))|| constant = sqrt(||C||^2+||a||^2) = %.12f'
      % np.sqrt(C @ C + a @ a))

ts = np.linspace(0, 2 * np.pi, 61)
vals = [np.linalg.norm(plucker_vec(n, np.cos(t) * u + np.sin(t) * v)) for t in ts]
print('   sampled over 61 angles: min %.12f  max %.12f  spread %.2e'
      % (min(vals), max(vals), max(vals) - min(vals)))
print('   ||omega^omega|| = 2x that: %.12f' % (2 * min(vals)))

# --- invariance under a rotation inside the degenerate eigenspace -------------
rng = np.random.default_rng(11)
worst = 0.0
for _ in range(200):
    A = rng.normal(size=(2, 2)); Qr, _ = np.linalg.qr(A)
    uu, vv = E @ Qr[:, 0], E @ Qr[:, 1]
    vs = [np.linalg.norm(plucker_vec(n, np.cos(t) * uu + np.sin(t) * vv)) for t in ts]
    worst = max(worst, max(vs) - min(vs), abs(min(vs) - min(vals)))
print('\nC. over 200 random orthonormal frames of the eigenplane: worst deviation %.2e' % worst)

# --- mechanism ----------------------------------------------------------------
Au, Av = skew(n, u), skew(n, v)
sup = np.linalg.svd(np.hstack([Au, Av]), compute_uv=False)
print('\nD. mechanism')
print('   singular values of A_u : %s' % np.round(np.linalg.svd(Au, compute_uv=False), 9))
print('   singular values of A_v : %s' % np.round(np.linalg.svd(Av, compute_uv=False), 9))
print('   dim(im A_u + im A_v)   : sing. values of [A_u | A_v] = %s'
      % np.round(sup, 9))
print('   <u,v> = %.2e   ||u||=%.12f ||v||=%.12f' % (u @ v, np.linalg.norm(u), np.linalg.norm(v)))
print('   A_u A_v + A_v A_u  max |.| = %.3e' % np.abs(Au @ Av + Av @ Au).max())
print('   A_u^3 + (1/2) A_u  max |.| = %.3e' % np.abs(Au @ Au @ Au + 0.5 * Au).max())
for t in (0.3, 1.1, 2.0):
    Aw = np.cos(t) * Au + np.sin(t) * Av
    s = np.linalg.svd(Aw, compute_uv=False)
    print('   t=%.1f  singular values of A_omega(t) = %s' % (t, np.round(s, 9)))
