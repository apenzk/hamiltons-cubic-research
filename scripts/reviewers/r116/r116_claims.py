"""Reviewer 116: the four claims, from the definitions alone.

core.py / weyl.py build so(n) with <A,B> = tr(A^T B)/2, the structure constants from
matrix commutators, W# = 1/2 C_{agd} C_{bez} W_{ge} W_{dz}, and Weyl_n as the nullspace
of (first Bianchi, Ricci) inside Sym^2(Lambda^2).  Convention checks: Id# = (n-2) Id,
dim Weyl_n = n(n+1)(n+2)(n-3)/12.

Run: python3 r116_claims.py
"""
import numpy as np, collections
from core import *
from weyl import *
from tools import *
from sub import *
from solve import *

n = 6
pairs, B, bas = weyl_basis(n)
C = structure(B)
N = len(pairs)
idx = {p: k for k, p in enumerate(pairs)}
F84 = bas.reshape(len(bas), -1)
rng = np.random.default_rng(20260826)


def S3xS3():
    R = np.zeros((N, N))
    for p in [(0, 1), (0, 2), (1, 2), (3, 4), (3, 5), (4, 5)]:
        R[idx[p], idx[p]] = 1.0
    W = R - 0.4 * np.eye(N)          # Einstein, so the Weyl part is R - scal/(n(n-1)) Id
    return W / np.sqrt(ip(W, W))


def cp2_padded():
    def E(i, j):
        v = np.zeros(N)
        v[idx[(min(i, j), max(i, j))]] = 1.0 if i < j else -1.0
        return v
    Lp = np.array([(E(0, 1) + E(2, 3)) / np.sqrt(2),
                   (E(0, 2) + E(3, 1)) / np.sqrt(2),
                   (E(0, 3) + E(1, 2)) / np.sqrt(2)]).T
    W = Lp @ np.diag([2.0, -1.0, -1.0]) @ Lp.T
    return W / np.sqrt(ip(W, W))


print("== conventions ==")
print("Id# = %.1f Id (expect n-2 = %d);  dim Weyl_6 = %d" %
      (sharp2(np.eye(N), C)[0, 0], n - 2, len(bas)))
print("C totally antisymmetric, residual %.1e" % np.abs(C + C.transpose(0, 2, 1)).max())
print("Q maps Weyl_6 into Weyl_6: residual %.1e on a random element" %
      (lambda q: np.linalg.norm(q - F84.T @ (F84 @ q)))(Q(np.einsum('i,ijk->jk', rng.normal(size=84), bas), C).ravel()))

print("\n== CLAIM 1: the test is S_mmm = 0 and S_hhm = 0, and S_hhm == S_hmh ==")
worst = 0.0
for t in range(200):
    k = rng.integers(1, N)
    Qm, _ = np.linalg.qr(rng.normal(size=(N, N)))
    worst = max(worst, abs(Sabc(C, Qm[:, k:], Qm[:, k:], Qm[:, :k])
                           - Sabc(C, Qm[:, k:], Qm[:, :k], Qm[:, k:])))
print("max |S_hhm - S_hmh| over 200 arbitrary orthogonal splittings: %.1e" % worst)

print("\n== CLAIM 2: the sign of W ==")
W = S3xS3()
for s in (1, -1):
    r = grading_report(s * W, C)
    print(" sign %+d: theta = %+.6f  dim m = %d  S_mmm = %8.4f  S_hhm = %8.4f  S_hmh = %8.4f  graded = %s"
          % (s, theta(s * W, C), r['dim_m'], r['S_mmm'], r['S_hhm'], r['S_hmh'], r['graded']))

print("\n== CLAIM 3: the sigma(3,3) point at theta = 0.418198 ==")
sub = invariant_subspace(bas, pairs, make_sigma(6, 3))
P = Prob(sub, C)
print("dim of the sigma(3,3)-invariant subspace of Weyl_6: %d" % P.d)
hit = None
for t in range(400):
    x, res, ok = P.solve(rng.normal(size=P.d) * 0.5)
    if res > 1e-10:
        continue
    Wn, th = P.normalise(x)
    if Wn is not None and abs(th - 0.418198) < 1e-5:
        hit = (Wn, th)
        break
if hit:
    Wn, th = hit
    for s in (1, -1):
        r = grading_report(s * Wn, C)
        print(" sign %+d: theta = %+.9f  gap = %.7f  dim m = %2d  S_mmm = %8.4f  S_hhm = %8.4f  graded = %s"
              % (s, s * th, r['min_nonzero_abs_lam'], r['dim_m'], r['S_mmm'], r['S_hhm'], r['graded']))
    print(" criticality residual max|Q(W) - theta W| = %.1e" % np.abs(Q(Wn, C) - th * Wn).max())
    print(" the h/m split of this point is tolerance-free:",
          {t: grading_report(Wn, C, tol=t)['dim_m'] for t in (0.0, 1e-10, 1e-6, 1e-3)})

print("\n== CLAIM 4: the kernel tolerance ==")
Wc = cp2_padded()
print(" theta = %.9f (sqrt(3/2) = %.9f), criticality residual %.1e"
      % (theta(Wc, C), np.sqrt(1.5), np.abs(Q(Wc, C) - theta(Wc, C) * Wc).max()))
for tol in (1e-8, 0.0):
    r = grading_report(Wc, C, tol=tol)
    print("  tol = %-6s dim m = %d  S_mmm = %.4f  S_hhm = %.4f" % (tol, r['dim_m'], r['S_mmm'], r['S_hhm']))
out = []
for t in range(40):
    Qm, _ = np.linalg.qr(rng.normal(size=(84, 84)))
    Fb = Qm.T @ F84
    M = (Fb.T @ (Fb @ Wc.ravel())).reshape(N, N)
    r = grading_report((M + M.T) / 2, C, tol=0.0)
    out.append((r['dim_m'], r['S_mmm'], r['S_hhm']))
print("  the SAME operator re-expressed through 40 random orthonormal Weyl_6 bases, no tolerance:")
print("   dim m: %s   S_mmm in [%.4f, %.4f]   S_hhm in [%.4f, %.4f]"
      % (dict(collections.Counter(o[0] for o in out)),
         min(o[1] for o in out), max(o[1] for o in out),
         min(o[2] for o in out), max(o[2] for o in out)))
