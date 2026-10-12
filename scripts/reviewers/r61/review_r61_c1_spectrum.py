"""Reviewer 61 / C1 (structure): A(W) = sum_{g,h} W_gh C_g C_h is LINEAR and
SO(m)-equivariant on Sym^2(Lambda^2 R^m), so by Schur it is a scalar on each
irreducible summand.  Compute its full spectrum and identify the eigenspaces."""
import numpy as np
import math
from review_r61_core import (ad_basis, sym_basis, weyl_basis, weyl_dim_formula,
                             pairs, pair_index, comp, ricci_defect)
from review_r61_c1 import A_of_gh, constrained_basis


def A_matrix(m):
    D = m * (m - 1) // 2
    S = sym_basis(D)                      # orthonormal basis of Sym(D), flattened
    Cs = ad_basis(m)
    cols = []
    for row in S:
        W = row.reshape(D, D)
        out = np.zeros((D, D))
        nz = np.argwhere(np.abs(W) > 0)
        for g, h in nz:
            out += W[g, h] * (Cs[g] @ Cs[h])
        cols.append(S @ out.ravel())
    return np.array(cols).T


def identify(m, vecs, S):
    """vecs: (k, Ns) coefficient rows -> report Weyl-ness / Ricci / Bianchi defects."""
    D = m * (m - 1) // 2
    Wb = weyl_basis(m)
    Wflat = Wb.reshape(Wb.shape[0], -1) @ S.T          # Weyl basis in sym coords
    Pw = Wflat.T @ np.linalg.solve(Wflat @ Wflat.T, Wflat)
    frac = np.mean([np.linalg.norm(Pw @ v) / np.linalg.norm(v) for v in vecs])
    return frac


if __name__ == '__main__':
    for m in (4, 5, 6, 7):
        D = m * (m - 1) // 2
        S = sym_basis(D)
        A = A_matrix(m)
        asym = np.linalg.norm(A - A.T)
        ev, U = np.linalg.eigh(0.5 * (A + A.T))
        # group eigenvalues
        groups = []
        for e in ev:
            for g in groups:
                if abs(g[0] - e) < 1e-8:
                    g[1] += 1
                    break
            else:
                groups.append([e, 1])
        print(f"m={m}: dim Sym^2(Lambda^2) = {A.shape[0]}, |A-A^T| = {asym:.2e}")
        for val, mult in sorted(groups):
            sel = U[:, np.abs(ev - val) < 1e-8].T
            f = identify(m, sel, S)
            print(f"   eigenvalue {val:+.6f}  multiplicity {mult:4d}   "
                  f"mean fraction inside Weyl_m = {f:.6f}")
        print(f"   dim Weyl_{m} = {weyl_dim_formula(m)},  "
              f"dim S^2_0(R^m) = {m*(m+1)//2-1},  dim Lambda^4 = "
              f"{math.comb(m,4)}\n")
