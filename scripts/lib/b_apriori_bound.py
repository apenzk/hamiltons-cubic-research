"""An a priori bound on M(n) = max P, in the eigenvalues of W alone.

WHY.  Every circ-decomposable critical point obeys |theta| <= M(n)/sqrt(2), so an
a priori M(n) <= sqrt(3) caps the whole decomposable class at sqrt(3/2) and clears
route B's residual of it.  sqrt(3) is far weaker than Conjecture A, whose own
value theta_0(n) < sqrt(2) at every n.  Fence post 11 rules out getting there by
bounding tr W^3 and <W,W#> separately, so the two terms need a shared handle.

THE IDENTITY.  In an eigenbasis of W with eigenvalues lambda and structure
constants c transported to that basis,

    <W, W#> = 1/2 sum_{a,b,g} lambda_a lambda_b lambda_g c_{abg}^2,

from (W#)_{ab} = -1/2 tr(A_a W A_b W) and total antisymmetry of c.  c is a tensor,
so its entries in the eigenbasis are NOT 0/+-1 -- only ||c||^2 = 2(n-2)N and the
contraction sum_{a,g} c_{abg} c_{ab'g} = 2(n-2) delta_{bb'} survive the rotation,
and both are what the bounds below use.

TWO INEQUALITIES.  Writing mu = |lambda|, M_{bg} = sum_a c_{abg}^2 >= 0 with row
sums 2(n-2), Cauchy-Schwarz in two arrangements gives

    <W, W#> <= (n-2) ||lambda||_4^2        and        tr W^3 <= ||lambda||_infty,

so  theta <= ||lambda||_infty + (n-2) ||lambda||_4^2.  The floor ||lambda||_4^2 >=
1/sqrt(N) makes the second term at least sqrt(2)(n-2)/sqrt(n(n-1)) -> sqrt(2), so
the bound is asymptotically sharp and cannot be improved by a constant.

WHAT IT COSTS.  With y = ||lambda||_4^2 the bound reads theta <= sqrt(y) + (n-2)y,
since ||lambda||_infty <= sqrt(y).  Reaching sqrt(3) at n = 12 needs y <= 0.1478
against a floor of 0.1231: about 20% of room.  The balanced sphere product sits at
y = 0.1251 and clears it, but S^4 x S^8 is at 0.2195 and padded W_CP2 at 0.7071 --
so FLATNESS ALONE CANNOT CARRY THE BOUND, and the flat and low-rank regimes need
separate arguments.  The bound's own ratio shows why: 0.97 of the truth at the
balanced product, 0.12 at padded W_CP2.  This script measures the split on numbers
rather than on hope.

FALSIFIER.  The identity failing at any point, or either inequality being violated.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (pair_index, adj, sharp, Q, normalize, weyl_basis,
                             sphere_product_W)
from b_cpm_closed_form import W_cpm
from b_cp2_nondegenerate import padded_cp2
from b_c5_blowup import c5_operator
from b_circ_indecomposable import multiblock_W, theta


def eig_identity(n, W):
    """<W,W#> recomputed from eigenvalues and the transported structure constants."""
    lam, V = np.linalg.eigh(W)
    c = adj(n)
    cp = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True)
    return 0.5 * float(np.einsum('pqr,p,q,r->', cp**2, lam, lam, lam, optimize=True)), lam


def rows():
    out = [("S^3xS^3", 6, sphere_product_W([3, 3])[0]),
           ("S^6xS^6 balanced", 12, sphere_product_W([6, 6])[0]),
           ("S^4xS^8", 12, sphere_product_W([4, 8])[0]),
           ("CP^3", 6, W_cpm(3)[0]), ("CP^4", 8, W_cpm(4)[0]),
           ("padded W_CP2 n=12", 12, padded_cp2(12)[0]),
           ("C_5 blow-up", 10, c5_operator([2] * 5)[0]),
           ("(S^4)^3", 12, multiblock_W([4, 4, 4])[0])]
    return [(nm, n, normalize(W)) for nm, n, W in out]


if __name__ == "__main__":
    print("=== the eigenvalue identity for <W,W#>, and the two bounds ===")
    print(f"{'point':20s} {'n':>3s} {'<W,W#>':>10s} {'from lam':>10s} {'err':>9s} "
          f"{'||l||_4^2':>10s} {'floor':>8s} {'theta':>9s} {'bound':>9s}")
    for nm, n, W in rows():
        N = n * (n - 1) // 2
        sh = float(np.tensordot(W, sharp(n, W)))
        alt, lam = eig_identity(n, W)
        l4 = float(np.sqrt((lam**4).sum()))
        li = float(np.abs(lam).max())
        th = theta(n, W)
        bound = li + (n - 2) * l4
        print(f"{nm:20s} {n:3d} {sh:10.6f} {alt:10.6f} {abs(sh-alt):9.1e} "
              f"{l4:10.6f} {1/np.sqrt(N):8.6f} {th:9.6f} {bound:9.4f}")
    print("\n=== is the sharp bound <W,W#> <= (n-2)||lambda||_4^2 respected? ===")
    for nm, n, W in rows():
        sh = float(np.tensordot(W, sharp(n, W)))
        lam = np.linalg.eigvalsh(W)
        l4 = float(np.sqrt((lam**4).sum()))
        print(f"  {nm:20s} <W,W#> = {sh:9.6f} <= (n-2)||l||_4^2 = "
              f"{(n-2)*l4:9.6f}   ratio {sh/((n-2)*l4):6.4f}")
    print("\n=== the flatness threshold y* solving sqrt(y) + (n-2)y = sqrt(3) ===")
    for nm, n, W in rows():
        N = n * (n - 1) // 2
        lam = np.linalg.eigvalsh(W); y = float(np.sqrt((lam**4).sum()))
        ys = np.roots([(n - 2)**2, -(2 * (n - 2) * np.sqrt(3) + 1), 3])
        ystar = float(min(r for r in ys if r > 0))
        print(f"  {nm:20s} n={n:2d}  y = {y:.6f}   y* = {ystar:.6f}   "
              f"floor = {1/np.sqrt(N):.6f}   {'clears' if y <= ystar else 'exceeds'}")
    print("\n=== random Weyl tensors: does anything approach theta = sqrt(3)? ===")
    rng = np.random.default_rng(11)
    for n in (6, 8, 10, 12):
        B = weyl_basis(n); D = len(B)
        best = -np.inf
        for _ in range(60):
            x = rng.normal(size=D)
            W = normalize(np.einsum('d,dij->ij', x, B))
            for _ in range(400):                       # projected gradient ascent
                G = 3 * Q(n, W)
                G = sum(float(np.tensordot(b, G)) * b for b in B)
                W = normalize(W + 0.05 * (G - float(np.tensordot(G, W)) * W))
            best = max(best, theta(n, W))
        print(f"  n={n:2d}  best theta from 60 ascents = {best:.6f}   "
              f"theta_0 = {np.sqrt(2*(n-1)*(n-2))/n:.6f}   sqrt(3/2) = 1.224745")


def restricted_structure(n, W, tol=1e-9):
    """The structure mass the SUPPORT of W actually carries.

    The flatness bound spends 2(n-2) on every index, which is what makes it run at
    ratio 0.12 in the low-rank regime.  Restricting c to the eigenvectors with
    lambda != 0 and taking M_{bg} = sum_a c_{abg}^2 there gives the sharper

        <W, W#> <= 1/2 ||lambda||_inf * lambda_max(M_supp),

    since sum c^2 mu mu mu <= ||mu||_inf <M mu, mu>.  M_supp's top eigenvalue is
    at most 2(n-2) and is the quantity low rank is supposed to make small."""
    lam, V = np.linalg.eigh(W)
    keep = np.abs(lam) > tol
    lam, V = lam[keep], V[:, keep]
    c = adj(n)
    cp = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True)
    M = np.einsum('pqr->qr', cp**2)
    return lam, float(np.linalg.eigvalsh(M).max()), float((cp**2).sum())


if __name__ == "__main__":
    print("\n=== the low-rank regime: structure mass on the support of W ===")
    print(f"{'point':20s} {'n':>3s} {'rank':>5s} {'<W,W#>':>10s} {'flat bd':>9s} "
          f"{'supp bd':>9s} {'lmax(M)':>9s} {'2(n-2)':>7s}")
    for nm, n, W in rows():
        sh = float(np.tensordot(W, sharp(n, W)))
        lam, lmax, mass = restricted_structure(n, W)
        li = float(np.abs(lam).max()); y = float(np.sqrt((lam**4).sum()))
        print(f"{nm:20s} {n:3d} {len(lam):5d} {sh:10.6f} {(n-2)*y:9.4f} "
              f"{0.5*li*lmax:9.4f} {lmax:9.4f} {2*(n-2):7d}")
