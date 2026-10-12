"""Reviewer 57: the full catalogue, with theta, criticality, and BOTH slacks.

Columns:
  S_struct  the structural leakage  ||Pi_m [m,m]||^2 ,  m = negative eigenspace.
            This IS the Z_2-grading condition the route calls S = 0.
  S_frac    the same, as a fraction of ||[m,m]||^2 (the '[m,m] in m' column of
            review_r11_grading_slack.py).
  S_theta   the theta-identity quantity of review_r11_grading_slack.py:
            ||Ric(W_-)||^2 + 6 delta^2 - theta tr(W_-) - tr(W_-^2), with
            delta^2 = ||Alt(W_-)||^2.
"""
import sys
import numpy as np

from review_r57_core import Alg, Weyl
from review_r57_points import (sphere_product, w_cp2, c5_blowup, su_m_kahler, pad,
                               block_sum, describe, commutant_on_weyl,
                               crit_points_in_subspace, u_m_gens, su_m_gens,
                               sp_m_gens, so_pq_gens, unit, orient)

CAT = {}


def add(label, n, W, extra=""):
    r = describe(label, n, W, extra)
    CAT[label] = r
    return r


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"

    if which in ("all", "basic"):
        print("== sphere products, blow-ups, Fox ==")
        add("S^3xS^3 (n=6)", 6, sphere_product(6, [[0, 1, 2], [3, 4, 5]]))
        add("S^5xS^5 (n=10)", 10, sphere_product(10, [list(range(5)), list(range(5, 10))]))
        add("S^6xS^6 (n=12)", 12, sphere_product(12, [list(range(6)), list(range(6, 12))]))
        add("padded S^3xS^3 -> 12", 12, pad(12, sphere_product(6, [[0, 1, 2], [3, 4, 5]]), list(range(6))))
        add("C_5 blow-up (2^5) n=10", 10, c5_blowup(10, [2, 2, 2, 2, 2]))
        add("W_CP2 (n=4)", 4, w_cp2(4))
        add("padded W_CP2 -> 12", 12, w_cp2(12))
        for n in (6, 8, 12):
            add(f"su({n//2}) Kaehler", n, su_m_kahler(n))

    if which in ("all", "cpm"):
        print("\n== CP^m, from the u(m)-invariant Weyl line ==")
        for n in (6, 8, 10, 12):
            gens, J = u_m_gens(n)
            V, ev = commutant_on_weyl(n, gens)
            w = Weyl.get(n)
            print(f"   dim Weyl_{n}^{{u({n//2})}} = {V.shape[1]}")
            for k in range(V.shape[1]):
                W = orient(w.alg, unit(w.from_coords(V[:, k])))
                add(f"CP^{n//2} (n={n})", n, W)

    if which in ("all", "qk"):
        print("\n== HP^m from sp(m)+sp(1), and the sp(m) hyperkahler family ==")
        for n in (8, 12):
            gens, _ = sp_m_gens(n, with_sp1=True)
            V, ev = commutant_on_weyl(n, gens)
            w = Weyl.get(n)
            print(f"   dim Weyl_{n}^{{sp({n//4})+sp(1)}} = {V.shape[1]}")
            for k in range(V.shape[1]):
                W = orient(w.alg, unit(w.from_coords(V[:, k])))
                add(f"HP^{n//4} (n={n})", n, W)
        for n in (8, 12):
            gens, _ = sp_m_gens(n, with_sp1=False)
            V, ev = commutant_on_weyl(n, gens)
            print(f"   dim Weyl_{n}^{{sp({n//4})}} = {V.shape[1]}  -- hyperkahler family")
            pts = crit_points_in_subspace(n, V, tries=250, seed=11)
            print(f"   critical points found inside it: {len(pts)}")
            for k, W in enumerate(pts):
                add(f"hyperkahler sp({n//4}) #{k} (n={n})", n, W)

    if which in ("all", "sums"):
        print("\n== orthogonal block sums (harmonic-square law) ==")
        a4 = Alg.get(4)
        W1 = w_cp2(4)
        add("W_CP2 + W_CP2 (n=8)", 8,
            block_sum(8, W1, [0, 1, 2, 3], W1, [4, 5, 6, 7]))
        W2 = sphere_product(6, [[0, 1, 2], [3, 4, 5]])
        add("W_CP2 + S^3xS^3 (n=10)", 10,
            block_sum(10, W1, [0, 1, 2, 3], W2, [4, 5, 6, 7, 8, 9]))
        add("padded W_CP2+S^3xS^3 ->12", 12,
            pad(12, block_sum(10, W1, [0, 1, 2, 3], W2, [4, 5, 6, 7, 8, 9]), list(range(10))))
        W3 = sphere_product(8, [list(range(4)), list(range(4, 8))])
        add("W_CP2 + S^4xS^4 (n=12)", 12,
            block_sum(12, W1, [0, 1, 2, 3], W3, [4, 5, 6, 7, 8, 9, 10, 11]))
        W4 = sphere_product(8, [[0, 1, 2], [3, 4, 5, 6, 7]])
        add("W_CP2 + S^3xS^5 (n=12)", 12,
            block_sum(12, W1, [0, 1, 2, 3], W4, [4, 5, 6, 7, 8, 9, 10, 11]))

    np.save('scratchpad/r57_cat.npy',
            {k: {kk: vv for kk, vv in v.items()} for k, v in CAT.items()}, allow_pickle=True)
