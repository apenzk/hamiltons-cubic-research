"""Screen 2: is S22 free over the formal polytope {(A),(B),(C) all rows, T sym hollow >= 0}?

At a fixed (lambda, theta): LP max/min of S22 over symmetric hollow T >= 0 subject to
  (A) sum_bc T_kbc = 2(n-2), (B) sum lam_b T_kbc = -2 lam_k, (C) sum lam_b lam_c T_kbc = 2 lam_k (theta-lam_k).
Variables: unordered triples {a<b<c}; ordered row sums expressed through them:
  sum_{bc} T_kbc = 2 * sum_{triples containing k} T,  with weight per triple {k,b,c}: 2*w(b,c) symmetrized.
Control: padded CP2 spectrum (expect degenerate interval = 1). Test: S3xS5 spectrum (expect fat interval).
"""
import numpy as np
from itertools import combinations
from scipy.optimize import linprog
from core import (basis_so, ad_matrices, op_from_R4, R4_sphere_product, weyl_project_R4,
                  theta_crit, eig_and_T, rows_ABC, S22_of, padded_cp2)


def polytope_S22_range(lam, theta, n, cap=None):
    N = len(lam)
    trips = list(combinations(range(N), 3))
    M = len(trips)
    tindex = {t: i for i, t in enumerate(trips)}
    # rows: for each k, three eqs. Coefficient of triple {k,b,c} (k in triple):
    #  (A): 2 ; (B): lam_b + lam_c ; (C): 2 lam_b lam_c
    Aeq = np.zeros((3 * N, M))
    beq = np.zeros(3 * N)
    for k in range(N):
        for i, t in enumerate(trips):
            if k in t:
                b, c = [x for x in t if x != k]
                Aeq[3 * k, i] = 2.0
                Aeq[3 * k + 1, i] = lam[b] + lam[c]
                Aeq[3 * k + 2, i] = 2.0 * lam[b] * lam[c]
        beq[3 * k] = 2.0 * (n - 2)
        beq[3 * k + 1] = -2.0 * lam[k]
        beq[3 * k + 2] = 2.0 * lam[k] * (theta - lam[k])
    # objective: S22 ordered sum = sum over triples of T * sum_perms lam1^2 lam2^2
    # per unordered {a,b,c}: 2*(la^2 lb^2 + la^2 lc^2 + lb^2 lc^2)
    obj = np.zeros(M)
    for i, (a, b, c) in enumerate(trips):
        la, lb, lc = lam[a], lam[b], lam[c]
        obj[i] = 2.0 * (la * la * lb * lb + la * la * lc * lc + lb * lb * lc * lc)
    A_ub = b_ub = None
    if cap is not None:
        # row cap: ordered row mass sum_bc T_kbc <= cap per k is (A) already eq; skip
        pass
    kw = dict(A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
    lo = linprog(c=obj, **kw)
    hi = linprog(c=-obj, **kw)
    return lo, hi, obj, trips


def report(tag, lam, theta, n, true_s22=None):
    lo, hi, obj, trips = polytope_S22_range(lam, theta, n)
    print(f"{tag}: n={n} theta={theta:.9f}")
    if not lo.success or not hi.success:
        print(f"   LP status: lo={lo.status}/{lo.message} hi={hi.status}/{hi.message}")
        return
    print(f"   S22 range over formal polytope: [{lo.fun:.9f}, {-hi.fun:.9f}]  width={-hi.fun-lo.fun:.9f}")
    if true_s22 is not None:
        print(f"   true S22 at the critical point: {true_s22:.9f}")


# --- control: padded CP2 spectrum at n=5 ---
n = 5
idx, mats = basis_so(n)
ads = ad_matrices(mats)
W = padded_cp2(n, idx)
th, res = theta_crit(W, ads)
lam, U, T = eig_and_T(W, ads, mats)
report("padded CP2 (control, expect width 0, value 1)", lam, th, n, S22_of(lam, T))

# --- test: S3xS5 at n=8 ---
p, q = 3, 5
n = p + q
idx, mats = basis_so(n)
ads = ad_matrices(mats)
kap2 = (p - 1) / (q - 1)
W4 = weyl_project_R4(R4_sphere_product(p, q, 1.0, kap2))
W = op_from_R4(W4, idx)
W /= np.sqrt(np.sum(W * W))
th, res = theta_crit(W, ads)
if th < 0:
    W = -W
    th, res = theta_crit(W, ads)
lam, U, T = eig_and_T(W, ads, mats)
A, B, C = rows_ABC(lam, T)
print(f"\nS3xS5 build: theta={th:.9f} (sqrt(56/45)={np.sqrt(56/45):.9f}) res={res:.2e} "
      f"rowdev={max(np.max(np.abs(A-2*(n-2))), np.max(np.abs(B+2*lam)), np.max(np.abs(C-2*lam*(th-lam)))):.2e}")
print(f"   distinct eigenvalues (rounded): {sorted(set(np.round(lam,8)))}")
report("S3xS5 spectrum", lam, th, n, S22_of(lam, T))
