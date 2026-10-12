"""Screen 1: validate the build; Phi scalars; padded CP2 pinned values; balanced G2."""
import numpy as np
from core import (basis_so, ad_matrices, op_from_R4, R4_sphere_product, weyl_project_R4,
                  theta_crit, eig_and_T, rows_ABC, g_dist, S22_of, padded_cp2)

np.set_printoptions(precision=9, suppress=False)

# --- build validation: balanced products ---
for (p, q) in [(3, 3), (4, 4)]:
    n = p + q
    idx, mats = basis_so(n)
    ads = ad_matrices(mats)
    kap1 = 1.0
    kap2 = (p - 1) / (q - 1)  # Einstein
    W4 = weyl_project_R4(R4_sphere_product(p, q, kap1, kap2))
    W = op_from_R4(W4, idx)
    W = W / np.sqrt(np.sum(W * W))
    th, res = theta_crit(W, ads)
    th = abs(th)
    W = W * np.sign(np.sum(W * (W @ W)) if th else 1)  # ensure theta>0 convention
    th, res = theta_crit(W, ads)
    if th < 0:
        W = -W
        th, res = theta_crit(W, ads)
    lam, U, T = eig_and_T(W, ads, mats)
    A, B, C = rows_ABC(lam, T)
    g = g_dist(lam, T)
    G2 = np.dot(lam ** 2, g)
    print(f"S{p}xS{q} n={n}: theta={th:.9f} res={res:.2e} "
          f"Arow_dev={np.max(np.abs(A-2*(n-2))):.2e} Brow_dev={np.max(np.abs(B+2*lam)):.2e} "
          f"Crow_dev={np.max(np.abs(C-2*lam*(th-lam))):.2e}")
    print(f"   distinct eigenvalues: {sorted(set(np.round(lam,8)))}")
    print(f"   G2={G2:.9f}  4th^2/(n-1)={4*th**2/(n-1):.9f}  S22={S22_of(lam,T):.9f}")
    Emax = np.abs(lam - lam.max()) < 1e-8
    print(f"   g on E_max: max={g[Emax].max():.2e} (expect 0)")

# --- Phi scalars at n=6 ---
n = 6
idx, mats = basis_so(n)
ads = ad_matrices(mats)
N = len(idx)


def phi(X):
    return sum(a @ X @ a for a in ads)


rng = np.random.default_rng(7)
# Weyl element: project a random R4 with curvature symmetries onto Weyl
R4 = rng.standard_normal((n, n, n, n))
R4 = R4 - R4.transpose(1, 0, 2, 3)
R4 = R4 + R4.transpose(2, 3, 0, 1)
# impose first Bianchi by symmetrizing: B(R)_ijkl = (R_ijkl + R_iklj + R_iljk)/3 removal
Bi = (R4 + np.transpose(R4, (0, 2, 3, 1)) + np.transpose(R4, (0, 3, 1, 2))) / 3.0
R4 = R4 - Bi  # now Bianchi holds
Wx = op_from_R4(weyl_project_R4(R4), idx)
r = phi(Wx) - 2.0 * Wx
print(f"\nPhi on Weyl (n=6): |Phi(X)-2X|/|X| = {np.linalg.norm(r)/np.linalg.norm(Wx):.2e} (expect 0)")
# Sym0 (Ricci-type): KN of traceless symmetric h with g
from core import kn
h = rng.standard_normal((n, n)); h = h + h.T; h -= np.trace(h)/n*np.eye(n)
Xs = op_from_R4(kn(h, np.eye(n)), idx)
r = phi(Xs) - (4.0 - n) * Xs
print(f"Phi on Sym0:      |Phi(X)-(4-n)X|/|X| = {np.linalg.norm(r)/np.linalg.norm(Xs):.2e}")
# Lambda^4: fully antisymmetric t
t = rng.standard_normal((n, n, n, n))
from itertools import permutations
ta = np.zeros_like(t)
sgn = {p: s for p, s in zip(permutations(range(4)), [1,-1,-1,1,1,-1,-1,1,1,-1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,-1,1])}
# build antisymmetrizer properly
import itertools
ta = np.zeros_like(t)
for p in itertools.permutations(range(4)):
    s = 1
    pl = list(p)
    for i in range(4):
        for j in range(i+1, 4):
            if pl[i] > pl[j]:
                s = -s
    ta += s * np.transpose(t, p)
ta /= 24.0
Xl = op_from_R4(ta, idx)
r = phi(Xl) - (-4.0) * Xl
print(f"Phi on Lambda^4:  |Phi(X)+4X|/|X| = {np.linalg.norm(r)/np.linalg.norm(Xl):.2e}")
Xi = np.eye(N)
r = phi(Xi) - (-2.0 * (n - 2)) * Xi
print(f"Phi on I:         |Phi(I)+2(n-2)I|/|I| = {np.linalg.norm(r)/np.linalg.norm(Xi):.2e}")

# --- padded CP2 at n=4,5,6 ---
for n in [4, 5, 6]:
    idx, mats = basis_so(n)
    ads = ad_matrices(mats)
    W = padded_cp2(n, idx)
    th, res = theta_crit(W, ads)
    lam, U, T = eig_and_T(W, ads, mats)
    A, B, C = rows_ABC(lam, T)
    g = g_dist(lam, T)
    G2 = np.dot(lam ** 2, g)
    s22 = S22_of(lam, T)
    Emax = np.abs(lam - lam.max()) < 1e-8
    print(f"\npadded CP2 n={n}: theta={th:.9f} (sqrt(3/2)={np.sqrt(1.5):.9f}) res={res:.2e}")
    print(f"   S22={s22:.9f} (predicted pinned value 1)   G2={G2:.9f} (predicted 2)")
    print(f"   g on E_max: {g[Emax].max():.2e};  row devs A/B/C: "
          f"{np.max(np.abs(A-2*(n-2))):.2e} {np.max(np.abs(B+2*lam)):.2e} {np.max(np.abs(C-2*lam*(th-lam))):.2e}")
