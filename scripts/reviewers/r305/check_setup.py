import numpy as np, sys
sys.path.insert(0, 'scripts/reviewers/r305')
from lib305 import *

def sphere_M(p, q):
    n = p + q
    M = np.zeros((n, n))
    g = -1.0 / (p * q)
    a = 1.0 / (p * (p - 1)) if p > 1 else 0.0
    b = 1.0 / (q * (q - 1)) if q > 1 else 0.0
    M[:p, :p] = a; M[p:, p:] = b; M[:p, p:] = g; M[p:, :p] = g
    np.fill_diagonal(M, 0.0)
    return M / np.linalg.norm(M) * np.sqrt(2.0)   # sum_{a<b} M^2 = 1

for (p, q) in [(3, 5), (3, 3), (4, 4)]:
    M = sphere_M(p, q)
    res, th = crit_res(M)
    print(f"S^{p}xS^{q}: rowsum={np.abs(M.sum(1)).max():.2e} norm={0.5*np.sum(M*M):.12f} crit_res={res:.2e} theta={th:.9f}")

n = 8
idx, pos, N, c, B = weyl_basis(n)
print("n=8 weyl dim", len(B))
M = sphere_M(3, 5)
W = diag_to_operator(M, pos)
# W must lie in the Weyl space
coef = np.array([inner(b, W) for b in B])
rec = np.tensordot(coef, B, axes=(0, 0))
print("W in Weyl space, err", np.abs(rec - W).max(), " |W|^2 =", inner(W, W))
QW = Qmap(c, W)
th = P(c, W)
print("P(W) =", th, " theta_diag =", theta_diag(M))
print("Q(W)-theta W max", np.abs(QW - th * W).max())
Lm = L_operator(c, B, W) / th
lmax, ev = lam_max_perp(Lm, coef)
print("lambda_max(L_e|perp) at S^3xS^5 =", lmax)
print("top eigs:", np.sort(ev)[-6:])
