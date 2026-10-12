"""r230: the sign that actually matters is NOT the einsum index order.

sphere_product(p,q) in run_bispectral_catalogue.py builds Lam with
  intra-block  -q/(p-1)  and  cross-block  +1.
The GENUINE Weyl tensor of the Riemannian product S^p(1) x S^q(1) has
  intra-block Weyl sectional curvature POSITIVE and cross-block NEGATIVE.
So the catalogue's tensor is MINUS the real one, and theta on it is -theta_0
rather than +theta_0 -- i.e. it is not the conjectured maximiser, its negative is.

Built here from the actual metric: R of the product, subtract the Ricci/scalar
parts by Kulkarni-Nomizu, and compare.
"""
import numpy as np, itertools, importlib.util, os, io, contextlib
sp = importlib.util.spec_from_file_location("c1", os.path.join(os.path.dirname(__file__), "c1_li_external.py"))
c1 = importlib.util.module_from_spec(sp)
with contextlib.redirect_stdout(io.StringIO()): sp.loader.exec_module(c1)
ring_li, diag_curv = c1.ring_li, c1.diag_curv

def weyl_of_product(p, q):
    """Weyl tensor of S^p(1) x S^q(1), from the true curvature tensor."""
    n = p + q
    Lam = np.zeros((n, n))                      # true sectional curvatures
    Lam[:p, :p] = 1 - np.eye(p)
    Lam[p:, p:] = 1 - np.eye(q)
    R = diag_curv(Lam)
    g = np.eye(n); Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric); E = Ric - s / n * g
    KN = lambda A, B: (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                       - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    return R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)

def catalogue_sphere_product(p, q):
    n = p + q; Lam = np.zeros((n, n)); a1, a2 = -q / (p - 1), -p / (q - 1)
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
    B = [E(i, j) for (i, j) in pairs]; c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for gg, (k, l) in enumerate(pairs): c[a, b, gg] = C[k, l]
    return 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, M, M, optimize=True)

print("=== the two tensors are negatives of each other (up to positive scale) ===")
for (p, q) in [(3, 3), (6, 6), (4, 8)]:
    Wt = weyl_of_product(p, q); Wc = catalogue_sphere_product(p, q)
    Wt = Wt / np.linalg.norm(lam2(Wt)[0]); Wc = Wc / np.linalg.norm(lam2(Wc)[0])
    print(f"  S^{p}xS^{q}: |W_true - W_cat| = {np.abs(Wt-Wc).max():.2e}   "
          f"|W_true + W_cat| = {np.abs(Wt+Wc).max():.2e}")

print("\n=== at S^6 x S^6, both signs, everything in Li's iklj order ===")
p = q = 6; n = 12
th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
A = 1 / (p * np.sqrt((p - 1) * (2 * p - 1)))
record = {round(p * A, 6): (p - 1) * (p + 2), round(-(p - 1) * A, 6): p * p, round(-2 * p * (p - 1) * A, 6): 1}
import collections
for label, W in [("W_true  (real metric)", weyl_of_product(p, q)),
                 ("W_cat   (catalogue)  ", catalogue_sphere_product(p, q))]:
    W = W / np.linalg.norm(lam2(W)[0])            # |M|_F = 1
    M, pairs = lam2(W)
    theta = np.trace(M @ M @ M) + np.sum(sharp(M, pairs, n) * M)
    p3nu = np.trace(M @ M @ M)
    ev = np.linalg.eigvalsh(ring_li(W)); p3om = (ev ** 3).sum()
    cnt = dict(collections.Counter(np.round(ev, 6)))
    print(f"  {label}: theta={theta:+.6f} (theta_0={th0:.6f})  p3(nu)={p3nu:+.6f}  "
          f"p3(omega)={p3om:+.6f}  min omega={ev.min():+.6f}")
    print(f"      omega spectrum {sorted(cnt.items())}")
    print(f"      identity (3/2)p3nu-(1/2)p3om = {1.5*p3nu-0.5*p3om:+.6f}   "
          f"with the OTHER sign of p3om: {1.5*p3nu+0.5*p3om:+.6f}")
    print(f"      matches findings/bispectral.md table {{mA:{(p-1)*(p+2)}, -(m-1)A:{p*p}, -2m(m-1)A:1}} = "
          f"{sorted(record.items())}?  {sorted(cnt.items())==sorted(record.items())}")
    # |W|_4 = 1 normalisation, the one run_second_kind_moment.py uses
    W1 = W / np.sqrt(np.einsum('ijkl,ijkl->', W, W))
    e1 = np.linalg.eigvalsh(ring_li(W1))
    print(f"      at |W|_4=1:  p_2={(e1**2).sum():.6f}  p_3={(e1**3).sum():+.6f}  min={e1.min():+.6f}\n")
