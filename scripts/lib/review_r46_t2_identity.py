"""Reviewer 46: is the 'exact theta formula' for the slack the same object as
the structural slack S_mmm = sum_{a,b,c in m} c_{abc}^2 ?

The project defines
    S = ||Ric(W_-)||^2 + 6 delta^2 - theta tr(W_-) - tr(W_-^2)
with delta^2 the first-Bianchi defect.  Tested here against
    S_w = <(W_-)^#, W_-> = (1/2) sum_{abc in m} c^2 nu_a nu_b nu_c,
the eigenvalue-weighted structural slack, over a spread of exact critical
points, with delta^2 taken at W and at W_- separately.
"""
import numpy as np
from review_r46_core import (structure_constants, ricci, bianchi_vec, sharp,
                             Q_of, P_of, negative_part, slack_structural, slack_hhm)
from review_r46_t1_cp2 import u_m_generators, invariant_weyl_line, pad
from review_r46_t3_hunt import (complete_bipartite, petersen, clebsch,
                                perfect_matching, srg_point, diag_operator,
                                triangle_free, is_cut)


def two_block(n, p):
    """The genuine Weyl operator of S^p x S^q: diagonal, three block values
    a (pp), b (qq), x (mixed), with zero row sums and criticality."""
    q = n - p
    # row sums: (p-1)a + q x = 0 ; (q-1) b + p x = 0
    x = -1.0
    a = q / (p - 1)
    b = p / (q - 1)
    lam = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            if i < p and j < p:
                lam[i, j] = a
            elif i >= p and j >= p:
                lam[i, j] = b
            else:
                lam[i, j] = x
    return lam


def pieces(n, W):
    c = structure_constants(n)
    th = P_of(c, W)
    res = np.abs(Q_of(c, W) - th * W).max()
    Wm, _, ev, _ = negative_part(W)
    rm = ricci(n, Wm)
    d2W = float(np.sum(bianchi_vec(n, W) ** 2))
    d2M = float(np.sum(bianchi_vec(n, Wm) ** 2))
    base = float(np.sum(rm * rm)) - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    Sw = float(np.sum(sharp(c, Wm) * Wm))
    return dict(theta=th, res=res, base=base, d2W=d2W, d2M=d2M, Sw=Sw,
                Smmm=slack_structural(c, W), Shhm=slack_hhm(c, W))


def show(name, n, W):
    W = W / np.linalg.norm(W)
    c = structure_constants(n)
    if P_of(c, W) < 0:
        W = -W
    p = pieces(n, W)
    fit = None
    if p['d2M'] > 1e-14:
        fit = (p['Sw'] - p['base']) / p['d2M']
    print(f"{name:24s} n={n:3d} theta={p['theta']:+.9f} res={p['res']:.1e}  "
          f"S_mmm={p['Smmm']:.3e} S_w={p['Sw']:+.9f}")
    print(f"{'':24s} base=||Ric(W-)||^2-th*tr(W-)-tr(W-^2) = {p['base']:+.9f}   "
          f"d2(W)={p['d2W']:.3e}  d2(W-)={p['d2M']:.9f}")
    print(f"{'':24s} project form (6*d2(W)):  {p['base'] + 6*p['d2W']:+.9f}   "
          f"with 6*d2(W-): {p['base'] + 6*p['d2M']:+.9f}   "
          f"with 4*d2(W-): {p['base'] + 4*p['d2M']:+.9f}")
    if fit is not None:
        print(f"{'':24s} coefficient k solving base + k*d2(W-) = S_w :  k = {fit:.9f}")
    print()
    return p


if __name__ == "__main__":
    print("=== does the theta-formula slack equal the structural slack? ===\n")
    # CP^m
    for m in (2, 3):
        n = 2 * m
        g, _ = u_m_generators(m)
        L = invariant_weyl_line(n, g)
        show(f"W_CP^{m} (native)", n, L[0])
    g, _ = u_m_generators(2)
    W4 = invariant_weyl_line(4, g)[0]
    W4 /= np.linalg.norm(W4)
    if P_of(structure_constants(4), W4) < 0:
        W4 = -W4
    for n in (8, 10):
        show("W_CP2 padded", n, pad(W4, 4, n))
    # sphere products, balanced and unbalanced
    for (n, p) in ((8, 4), (8, 3), (10, 4), (10, 5)):
        lam = two_block(n, p)
        W = diag_operator(n, {(i, j): lam[i, j] for i in range(n) for j in range(i + 1, n)})
        show(f"S^{p} x S^{n-p}", n, W)
    # ungraded graph points
    for name, A in (("perfect matching n=8", perfect_matching(8)),
                    ("Petersen n=10", petersen()),
                    ("K_4 complement? n=6", complete_bipartite(3, 3))):
        n = A.shape[0]
        lam, _, _ = srg_point(A)
        W = diag_operator(n, {(i, j): lam[i, j] for i in range(n) for j in range(i + 1, n)})
        show(name, n, W)
