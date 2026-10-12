"""The 4-space U, its self-duality, and the instrument's control table."""
import sys, itertools
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/lib')
import numpy as np
from r295_core import *
from review_r56_core import plucker_min as repo_plucker_min

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
lam, V = np.linalg.eigh(W)
E = V[:, np.abs(lam - lam[0]) < 1e-8]
u, v = E[:, 0], E[:, 1]
Au, Av = skew(n, u), skew(n, v)

print('=== the common 4-space U ===')
Uo, s, _ = np.linalg.svd(np.hstack([Au, Av]))
U4 = Uo[:, :4]
print(' sing values [A_u|A_v]:', np.round(s, 12))
print(' im A_u  inside U:  %.3e' % np.abs(Au - U4 @ U4.T @ Au).max())
print(' im A_v  inside U:  %.3e' % np.abs(Av - U4 @ U4.T @ Av).max())
print(' U basis (columns), rounded:'); print(np.round(U4, 6))
print(' is U a COORDINATE 4-space?  per-coordinate mass in U:',
      np.round((U4 ** 2).sum(1), 6))

print('\n=== self-duality of the plane on U ===')
au = U4.T @ Au @ U4; av = U4.T @ Av @ U4
def pf(A): return A[0,1]*A[2,3] - A[0,2]*A[1,3] + A[0,3]*A[1,2]
print(' A_u|_U pf = %.12f   ||A_u|_U||_F^2/2 = %.12f' % (pf(au), np.sum(au*au)/2))
print(' A_v|_U pf = %.12f   ||A_v|_U||_F^2/2 = %.12f' % (pf(av), np.sum(av*av)/2))
print(' (self-dual on U <=> 2*pf = ||.||^2/2 ; anti-self-dual <=> 2*pf = -||.||^2/2)')
print(' J_u := sqrt2 A_u|_U:  J^2 + I = %.3e' % np.abs(2*au@au + np.eye(4)).max())
print(' J_v := sqrt2 A_v|_U:  J^2 + I = %.3e' % np.abs(2*av@av + np.eye(4)).max())
print(' J_u J_v + J_v J_u  = %.3e (quaternionic)' % np.abs(2*(au@av+av@au)).max())
print(' omega(t)^omega(t) is the SAME 4-form for all t:')
P0 = plucker_vec(n, u)
for t in (0.0, 0.7, 1.9, 2.9):
    Pt = plucker_vec(n, np.cos(t)*u + np.sin(t)*v)
    print('   t=%.1f  ||pl(t) - pl(0)|| = %.3e' % (t, np.linalg.norm(Pt - P0)))
print(' the constant 4-form is the volume form of U: ||pl|| = %.12f' % np.linalg.norm(P0))

print('\n=== instrument control table (repo plucker_min) ===')
idx = {p: a for a, p in enumerate(pairs_of(n))}
def vec(terms):
    w = np.zeros(28)
    for (i, j), c in terms: w[idx[(i, j)]] = c
    return w
r2 = 1/np.sqrt(2)
dec1 = vec([((0,1), 1.0)]); dec2 = vec([((2,3), 1.0)])
r4a = vec([((0,1), r2), ((2,3), r2)])          # self-dual on span(e0..e3)
r4b = vec([((0,2), r2), ((1,3), -r2)])          # self-dual, orthogonal to r4a
pairsl = pairs_of(n)
def pm(cols, seed=0):
    Emat = np.array(cols).T
    Emat, _ = np.linalg.qr(Emat)
    return repo_plucker_min(Emat, pairsl, n, tries=40, seed=seed)
print(' two decomposables            : %.6f' % pm([dec1, dec2]))
print(' decomposable + rank 4        : %.6f' % pm([dec1, r4a]))
print(' two orthogonal rank-4 (SD,SD): %.6f' % pm([r4a, r4b]))
rng = np.random.default_rng(5)
for t in range(3):
    cols = []
    for _ in range(2):
        w = np.zeros(28)
        for a, (i, j) in enumerate(pairsl):
            if i < 4 and j < 4: w[a] = rng.normal()
        cols.append(w/np.linalg.norm(w))
    print(' generic plane in coord R^4 #%d: %.6f' % (t, pm(cols, seed=t)))
print(' the witness eigenplane        : %.6f' % repo_plucker_min(E, pairsl, n, tries=40, seed=0))
