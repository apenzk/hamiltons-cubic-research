"""The lambda-weighted contraction of Prop 1.7, and the first bound decreasing in Delta.

FOUND AT GATE 2 by Reviewers 69 and 70 independently; reproduced here because a number
the tree cannot regenerate is not a result.

THE IDENTITY.  With g_gamma := ||[ad(v_gamma), W]||^2 (Petersen-Wink Prop 1.7),

    sum_gamma lam_gamma g_gamma  =  -4 theta(W) .                              (1)

Proof, two lines.  For skew A and symmetric W, [A,W] is symmetric, so
||[A,W]||^2 = tr([A,W]^2) = 2 tr(AWAW) - 2 tr(W^2 A^2).  Summing against lam_gamma with
A = ad(v_gamma) gives 2[ -2<W,W#> - 2 tr W^3 ] = -4 theta, using A(W) = 2W (recorded in
[b0_psd_identity.py]) and the definition of #.

Fence post 18 says a GENERATOR-INDEPENDENT weight recovers only A(W) = 2W.  (1) is the
very next weight and it returns theta itself, so the fence post's scope is exactly right
and no wider.

THE BOUND.  Split (1) over m (lam < 0), p (lam > 0) and ker.  The kernel contributes
nothing; sum_{p} lam g >= 0 since both factors are nonnegative; and on m,
lam_gamma g_gamma >= lam_min g_gamma.  Hence -4 theta >= lam_min * sum_{m} g_gamma, i.e.

    theta  <=  |lam_min| * ( 4(n-1) - Delta - G_0 ) / 4 ,                       (2)

    Delta := sum_{gamma in p} g_gamma ,   G_0 := sum_{gamma in ker W} g_gamma ,

the bracket being sum_{gamma in m} g_gamma by the Casimir total of fence post 18.

WHY IT MATTERS.  (2) is an upper bound on theta DECREASING in Delta -- the shape
[plan.md]'s B-band target has been asking for.  EQUALITY holds iff both slack terms
vanish: g = 0 on p (i.e. Delta = 0) AND g supported on the lam_min eigenspace -- every
eigenvector above the bottom is an infinitesimal symmetry.

THE WEAKNESS, stated up front: |lam_min| is uncontrolled, so (2) turns a one-variable
question into a two-variable one in (Delta, lam_min).

FALSIFIER: (1) failing at any Weyl tensor, or (2) violated anywhere.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W
from b_symmetry_defect import phis, cpm_W, pad
from b_c5_blowup import c5_operator
from weyl_screen import theta_screened

TOL = 1e-9


def profile(n, W, tol=TOL):
    """(theta, lam, g, m, p, z) with g_gamma = ||[ad(v_gamma), W]||^2 in W's eigenbasis."""
    W = W / np.sqrt(np.sum(W * W))
    th, info = theta_screened(n, W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    return th, info['is_weyl'], lam, g, lam < -tol, lam > tol, np.abs(lam) <= tol


def main():
    pts = []
    for b in ([6, 6], [5, 7], [4, 8], [3, 3]):
        pts.append((sum(b), sphere_product_W(b)[0], f"S^{b[0]} x S^{b[1]}"))
    for m in (2, 3, 4):
        pts.append((2 * m, cpm_W(m), f"CP^{m}"))
    pts.append((8, pad(cpm_W(2), 4, 8), "CP^2 padded n=8"))
    pts.append((8, pad(sphere_product_W([3, 3])[0], 6, 8), "S^3xS^3 padded n=8"))
    pts.append((10, c5_operator([2] * 5)[0], "C_5 blow-up n=10"))
    rng = np.random.default_rng(4242)
    for n in (6, 8):
        B = weyl_basis(n)
        for t in range(2):
            co = rng.normal(size=B.shape[0])
            pts.append((n, np.tensordot(co, B, axes=([0], [0])), f"random n={n} #{t}"))

    print("=== (1) the identity  sum_gamma lam_gamma g_gamma = -4 theta ===")
    print(f"  {'point':22s}{'n':>3s}{'theta':>11s}{'sum lam*g':>12s}{'-4 theta':>11s}{'resid':>10s}")
    rows = []
    for n, W, lbl in pts:
        th, ok, lam, g, m, p, z = profile(n, W)
        lhs = float(np.dot(lam, g))
        rows.append((lbl, n, th, lam, g, m, p, z))
        print(f"  {lbl:22s}{n:>3d}{th:>11.6f}{lhs:>12.6f}{-4*th:>11.6f}"
              f"{abs(lhs + 4*th):>10.1e}")

    print("\n=== (2) the bound  theta <= |lam_min| (4(n-1) - Delta - G_0) / 4 ===")
    print(f"  {'point':22s}{'n':>3s}{'theta':>11s}{'Delta':>9s}{'G_0':>8s}"
          f"{'|lam_min|':>10s}{'bound':>11s}{'slack':>11s}  eq?")
    worst = -np.inf
    for lbl, n, th, lam, g, m, p, z in rows:
        Delta = float(g[p].sum()); G0 = float(g[z].sum())
        lmin = abs(float(lam.min()))
        bound = lmin * (4 * (n - 1) - Delta - G0) / 4.0
        slack = bound - th
        worst = max(worst, -slack)
        print(f"  {lbl:22s}{n:>3d}{th:>11.6f}{Delta:>9.4f}{G0:>8.3f}{lmin:>10.6f}"
              f"{bound:>11.6f}{slack:>11.2e}  {'YES' if abs(slack) < 1e-9 else ''}")
    print(f"\n  worst violation of the bound over {len(rows)} points: {worst:.2e}"
          f"   (negative means never violated)")
    print("  Equality is exactly Delta = 0 AND g supported on the lam_min eigenspace,")
    print("  i.e. every eigenvector above the bottom is an infinitesimal symmetry.")
    print("  The bound's weakness: |lam_min| is uncontrolled, so the open question")
    print("  becomes two-variable in (Delta, lam_min).")


if __name__ == '__main__':
    main()
