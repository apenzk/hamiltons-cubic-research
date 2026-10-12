"""r230 claim 2: use the bi-spectral identity theta = (3/2)p_3(nu) - (1/2)p_3(omega)
as an INDEPENDENT arbiter of the sign of p_3(omega) at the balanced sphere product.

Everything here is built fresh: Lambda^2 matrix, the # operator, theta, and Li's
Rring (imported from c1_li_external, which was validated against four published
spectra).  No repo module is imported.
"""
import numpy as np, itertools, importlib.util, os, sys
sp = importlib.util.spec_from_file_location("c1", os.path.join(os.path.dirname(__file__), "c1_li_external.py"))
c1 = importlib.util.module_from_spec(sp)
import io, contextlib
with contextlib.redirect_stdout(io.StringIO()): sp.loader.exec_module(c1)
ring_li, diag_curv = c1.ring_li, c1.diag_curv

def sphere_product_weyl(p, q):
    """Weyl tensor of S^p x S^q, balanced-normalised as in the record:
       sectional curvatures Lam_ij = -q/(p-1) inside block 1, -p/(q-1) inside block 2, +1 across."""
    n = p + q; Lam = np.zeros((n, n))
    a1, a2 = -q / (p - 1), -p / (q - 1)
    for i in range(n):
        for j in range(n):
            if i == j: continue
            Lam[i, j] = a1 if (i < p and j < p) else a2 if (i >= p and j >= p) else 1.0
    return diag_curv(Lam)

def lam2(W):
    n = W.shape[0]; pairs = list(itertools.combinations(range(n), 2))
    return np.array([[W[i, j, k, l] for (k, l) in pairs] for (i, j) in pairs]), pairs

def sharp(M, pairs, n):
    N = len(pairs)
    def E(i, j):
        A = np.zeros((n, n)); A[i, j] = 1; A[j, i] = -1; return A
    B = [E(i, j) for (i, j) in pairs]
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for g, (k, l) in enumerate(pairs): c[a, b, g] = C[k, l]
    return 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, M, M, optimize=True)

def theta0(n):
    return np.sqrt(2 * (n - 1) * (n - 2)) / n

print(f"{'n':>4} {'|W|^2/|M|^2':>12} {'theta':>11} {'theta_0(n)':>11} {'p3(nu)':>11} "
      f"{'p3(om) Li':>11} {'(3/2)p3nu-(1/2)p3om':>21} {'... with -p3om':>15}")
for n in (6, 8, 10, 12, 14, 16, 24):
    W = sphere_product_weyl(n // 2, n // 2)
    ric = np.abs(np.einsum('ikjk->ij', W)).max()
    bia = np.abs(W + W.transpose(1, 2, 0, 3) + W.transpose(2, 0, 1, 3)).max()
    M0, pairs = lam2(W)
    W = W / np.linalg.norm(M0)                 # normalisation of the identity: |M|_F = 1
    M, pairs = lam2(W)
    ratio = np.einsum('ijkl,ijkl->', W, W) / np.linalg.norm(M) ** 2
    theta = np.trace(M @ M @ M) + np.sum(sharp(M, pairs, n) * M)
    p3nu = np.trace(M @ M @ M)
    om = np.linalg.eigvalsh(ring_li(W))
    p3om = (om ** 3).sum()
    lhs_plus = 1.5 * p3nu - 0.5 * p3om
    lhs_minus = 1.5 * p3nu + 0.5 * p3om
    print(f"{n:>4} {ratio:>12.4f} {theta:>11.6f} {theta0(n):>11.6f} {p3nu:>11.6f} "
          f"{p3om:>11.6f} {lhs_plus:>21.6f} {lhs_minus:>15.6f}   ric={ric:.0e} bia={bia:.0e}")

print("\n--- at n=12, both normalisations of omega ---")
n = 12
W = sphere_product_weyl(6, 6)
M0, _ = lam2(W)
for label, Wn in [("|M|_F = 1  (identity's)", W / np.linalg.norm(M0)),
                  ("|W|_4 = 1  (moment file's)", W / np.sqrt(np.einsum('ijkl,ijkl->', W, W)))]:
    om = np.sort(np.linalg.eigvalsh(ring_li(Wn)))
    print(f"  {label:28s}  p_1={om.sum():+.2e}  p_2={(om**2).sum():.6f}  "
          f"p_3={(om**3).sum():+.6f}  min={om.min():+.6f}  max={om.max():+.6f}")
    print(f"  {'':28s}  distinct: {sorted(set(np.round(om,6)))}")
print(f"\n  projection-estimate cap  (n/(n-1))*theta_0(n) = {(n/(n-1))*theta0(n):.6f}")
