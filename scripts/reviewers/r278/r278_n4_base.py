"""r278 -- claim 2: the n=4 base case.  P = 9(det W^+ + det W^-) and max P = sqrt(3/2)."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q, P, weyl_basis, normalize

n = 4
pairs, idx = pair_index(n)
B = weyl_basis(n)
print("dim Weyl_4 =", len(B), " (formula (n+2)(n+1)n(n-3)/12 =", (n+2)*(n+1)*n*(n-3)//12, ")")
print("dim Weyl_3 =", (5*4*3*0)//12)

# Hodge star on Lambda^2 R^4 in the basis e_i ^ e_j, (i<j)
star = np.zeros((6, 6))
for a, (i, j) in enumerate(pairs):
    k, l = [t for t in range(4) if t not in (i, j)]
    sgn = np.sign(np.linalg.det(np.eye(4)[[i, j, k, l]]))
    star[idx[(k, l)], a] = sgn
Pp = 0.5 * (np.eye(6) + star); Pm = 0.5 * (np.eye(6) - star)

def halves(W):
    """W^+ and W^- as 3x3 matrices in orthonormal bases of Lambda^+/Lambda^-."""
    out = []
    for Pr in (Pp, Pm):
        ev, V = np.linalg.eigh(Pr)
        U = V[:, ev > 0.5]                      # 3 columns, orthonormal
        out.append(U.T @ W @ U)
    return out

rng = np.random.default_rng(0)
print("\nP(W) against 9(det W^+ + det W^-) at 6 random Weyl_4 points:")
for s in range(6):
    W = sum(rng.normal() * b for b in B)
    Wp, Wm = halves(W)
    print("   P = %+.12f   9(det+ + det-) = %+.12f   |diff| = %.2e"
          % (P(n, W), 9*(np.linalg.det(Wp)+np.linalg.det(Wm)),
             abs(P(n, W) - 9*(np.linalg.det(Wp)+np.linalg.det(Wm)))))

# direct maximisation of P on the unit sphere of Weyl_4
from scipy.optimize import minimize
D = len(B); Bs = np.array(B)
def negP(c):
    W = np.tensordot(c, Bs, axes=1); nrm = np.sqrt(np.tensordot(W, W))
    return -P(n, W / nrm)
best = 0.0
for s in range(40):
    r = minimize(negP, rng.normal(size=D), method='Nelder-Mead',
                 options=dict(maxiter=20000, xatol=1e-10, fatol=1e-12))
    best = max(best, -r.fun)
print("\nmax P over unit Weyl_4, 40 starts : %.12f" % best)
print("sqrt(3/2)                          : %.12f" % np.sqrt(1.5))
print("theta_0(4) = sqrt(2*3*2)/4         : %.12f" % (np.sqrt(2*3*2)/4))
for m in (4, 6, 8, 10, 11, 12, 13, 14, 16, 100):
    print("   theta_0(%3d) = %.9f" % (m, np.sqrt(2*(m-1)*(m-2))/m))
