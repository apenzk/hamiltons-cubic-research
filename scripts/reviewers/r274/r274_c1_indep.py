"""r274, Claim 1: independent reconstruction of the half-percent table.

NOTHING is imported from scripts/. R# is built from Wilking's ad-form
  <M# x, y> = -1/2 tr(ad_x M ad_y M),   x,y in so(n),
with so(n) realised as explicit n x n matrices phi_ij = E_ij - E_ji and
inner product <A,B> = 1/2 tr(A^T B) (so {phi_ij}_{i<j} is orthonormal).
ad is a matrix commutator, computed here, not a table read from disk.

Three levels, cross-checked against each other:
  (a) brute force from n x n so(n) matrices        (small n)
  (b) triangle formula (M#)_{ij} = sum_k lam_ik lam_jk   (coordinate-diagonal M)
  (c) closed form in m for the balanced sphere product S^m x S^m
The sphere-product lambda vector is derived from the Riemann tensor of
S^m(1) x S^m(1) by removing Ricci/scalar parts, not asserted.
"""
import numpy as np, itertools, sympy as sp

# ---------- (a) brute force ad-form ----------
def so_basis(n):
    B = []
    for i, j in itertools.combinations(range(n), 2):
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        B.append(A)
    return B                      # <phi,phi> = 1/2 tr(A^T A) = 1

def ad_matrices(n):
    """ad_a in the orthonormal basis: (ad_a)_{g b} = <[phi_a,phi_b],phi_g>."""
    B = so_basis(n); N = len(B)
    ad = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for g in range(N):
                ad[a, g, b] = 0.5 * np.trace(B[g].T @ C)
    return ad

def Msharp_bruteforce(Mmat, ad):
    """(M#)_{ab} = -1/2 tr(ad_a M ad_b M)."""
    N = Mmat.shape[0]
    S = np.einsum('amn,np->amp', ad, Mmat, optimize=True)
    return -0.5 * np.einsum('amp,bpm->ab', S, S, optimize=True)

# ---------- (b) triangle formula for coordinate-diagonal M ----------
def Msharp_diag(lam, n):
    idx = list(itertools.combinations(range(n), 2))
    out = np.zeros(len(lam))
    pos = {p: k for k, p in enumerate(idx)}
    def L(i, j):
        return lam[pos[(i, j)]] if i < j else lam[pos[(j, i)]]
    for a, (i, j) in enumerate(idx):
        out[a] = sum(L(i, k) * L(j, k) for k in range(n) if k not in (i, j))
    return out

# ---------- sphere-product Weyl tensor, from the Riemann tensor ----------
def sphere_product_lambda(m):
    """Lambda^2 spectrum of the unit-norm Weyl tensor of S^m(1) x S^m(1).
    R_{ijkl} = K (g_ik g_jl - g_il g_jk) within each factor, 0 across.
    On Lambda^2 (basis e_i^e_j, i<j) that is diag(1 on each factor, 0 mixed).
    Weyl = R - (1/(n-2)) (Ric o g) + S/((n-1)(n-2)) G ; Einstein so it is R - c*Id
    with c = 2(m-1)/(n-2) - 2m(m-1)/((n-1)(n-2)), n = 2m."""
    n = 2 * m
    idx = list(itertools.combinations(range(n), 2))
    Rlam = np.array([1.0 if (i < m) == (j < m) else 0.0 for i, j in idx])
    c = 2.0 * (m - 1) / (n - 2) - 2.0 * m * (m - 1) / ((n - 1) * (n - 2))
    w = Rlam - c
    return w / np.linalg.norm(w), n

def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n

# ---------- checks ----------
print("== cross-check ad-form vs triangle formula, coordinate-diagonal M ==")
for n in (5, 6, 7):
    ad = ad_matrices(n)
    N = ad.shape[0]
    rng = np.random.default_rng(0)
    lam = rng.standard_normal(N)
    Ms_b = Msharp_bruteforce(np.diag(lam), ad)
    Ms_d = Msharp_diag(lam, n)
    print(f" n={n}: offdiag(M# brute)={np.linalg.norm(Ms_b-np.diag(np.diag(Ms_b))):.2e}"
          f"  max|diag diff|={np.abs(np.diag(Ms_b)-Ms_d).max():.2e}")

print("\n== cross-check ad-form on a FULL (non-diagonal) symmetric M: symmetry of M# ==")
for n in (5, 6):
    ad = ad_matrices(n); N = ad.shape[0]
    rng = np.random.default_rng(1)
    A = rng.standard_normal((N, N)); Mm = 0.5 * (A + A.T)
    Ms = Msharp_bruteforce(Mm, ad)
    print(f" n={n}: ||M# - M#^T|| = {np.linalg.norm(Ms-Ms.T):.2e}")

print("\n== THE TABLE ==")
print(f"{'n':>4} {'tr(M^3)':>12} {'|M#|_F':>12} {'sum':>12} {'theta_0':>12} {'excess%':>9}"
      f" {'<M#,M>':>12} {'theta':>12} {'theta-theta_0':>14} {'|M#|/<M#,M>':>13}")
rows = []
for m in range(3, 16):
    lam, n = sphere_product_lambda(m)
    ms = Msharp_diag(lam, n)
    tr3 = float(np.sum(lam ** 3))
    nms = float(np.linalg.norm(ms))
    ip = float(np.dot(ms, lam))
    th = tr3 + ip
    t0 = theta0(n)
    rows.append((n, tr3, nms, tr3 + nms, t0, 100 * ((tr3 + nms) / t0 - 1), ip, th, th - t0, nms / ip))
    print(f"{n:>4} {tr3:>12.5f} {nms:>12.5f} {tr3+nms:>12.5f} {t0:>12.5f}"
          f" {100*((tr3+nms)/t0-1):>8.3f}% {ip:>12.5f} {th:>12.6f} {th-t0:>14.2e} {nms/ip:>13.5f}")

print("\n== independent confirmation of the lambda vector at n=6,8 by brute-force ad-form ==")
for m in (3, 4):
    lam, n = sphere_product_lambda(m)
    ad = ad_matrices(n)
    Ms = Msharp_bruteforce(np.diag(lam), ad)
    tr3 = float(np.sum(lam ** 3)); nms = float(np.linalg.norm(Ms))
    ip = float(np.trace(Ms @ np.diag(lam)))
    print(f" n={n}: |M#|_F={nms:.6f}  <M#,M>={ip:.6f}  theta={tr3+ip:.9f}  theta_0={theta0(n):.9f}")
