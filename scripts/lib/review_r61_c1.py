"""Reviewer 61 / C1: is sum_a lam_a ad(v_a)^2 = 2W on Weyl_m, and what is it
without Ricci-flatness or without Bianchi?"""
import numpy as np, itertools
from review_r61_core import (pairs, pair_index, ad_matrix, ad_basis, vec_to_skew,
                             skew_to_vec, weyl_constraints, sym_basis, comp,
                             weyl_basis, ricci_defect)


def constrained_basis(m, use_ricci=True, use_bianchi=True):
    D = m * (m - 1) // 2
    S = sym_basis(D)
    nric = sum(1 for i in range(m) for k in range(i, m))
    A = weyl_constraints(m)
    if use_ricci and use_bianchi:
        Asub = A
    elif use_ricci:
        Asub = A[:nric]
    elif use_bianchi:
        Asub = A[nric:]
    else:
        Asub = np.zeros((1, D * D))
    M = Asub @ S.T
    _, s, Vt = np.linalg.svd(M)
    rank = int((s > 1e-9 * max(1.0, s[0])).sum())
    return (Vt[rank:] @ S).reshape(-1, D, D)


def A_of(W, m):
    """sum_a lam_a ad(v_a)^2 = sum_{g,h} W_{gh} C_g C_h (basis independent)."""
    lam, V = np.linalg.eigh(W)
    D = W.shape[0]
    out = np.zeros((D, D))
    for a in range(D):
        if abs(lam[a]) < 1e-15:
            continue
        C = ad_matrix(V[:, a], m)
        out += lam[a] * (C @ C)
    return out


def A_of_gh(W, m):
    Cs = ad_basis(m)
    D = W.shape[0]
    out = np.zeros((D, D))
    for g in range(D):
        for h in range(D):
            if W[g, h] != 0.0:
                out += W[g, h] * (Cs[g] @ Cs[h])
    return out


def ric_operator(W, m):
    """omega -> Ric.omega + omega.Ric, as a D x D matrix."""
    idx = pair_index(m)
    R = np.zeros((m, m))
    for i in range(m):
        for k in range(m):
            R[i, k] = sum(comp(W, m, i, j, k, j, idx) for j in range(m))
    D = m * (m - 1) // 2
    L = np.zeros((D, D))
    for k, (i, j) in enumerate(pairs(m)):
        E = np.zeros((m, m)); E[i, j] = 1.0; E[j, i] = -1.0
        L[:, k] = skew_to_vec(R @ E + E @ R, m)
    return L, R


def report(m, label, B, rng, ntest=3):
    D = m * (m - 1) // 2
    for t in range(ntest):
        W = np.einsum('k,kij->ij', rng.normal(size=B.shape[0]), B)
        W = 0.5 * (W + W.T)
        W /= np.linalg.norm(W)
        A = A_of(W, m)
        L, Ric = ric_operator(W, m)
        rows = [("A - 2W", A - 2 * W), ("A + 2W", A + 2 * W),
                ("A - (L - 2W)", A - (L - 2 * W)), ("A - (L + 2W)", A - (L + 2 * W))]
        best = min(rows, key=lambda r: np.linalg.norm(r[1]))
        print(f"  m={m} {label} #{t}: |A|={np.linalg.norm(A):.4f} "
              + "  ".join(f"|{n}|={np.linalg.norm(v):.2e}" for n, v in rows)
              + f"   |Ric|={np.linalg.norm(Ric):.2e}")


if __name__ == '__main__':
    rng = np.random.default_rng(7)
    print("=== C1 on Weyl_m (both conditions) ===")
    for m in (4, 5, 6, 7, 8):
        report(m, "Weyl", weyl_basis(m), rng, 2)
    print("\n=== Ricci-flat only (no Bianchi) ===")
    for m in (5, 6):
        report(m, "Ric0", constrained_basis(m, True, False), rng, 2)
    print("\n=== Bianchi only (no Ricci-flatness) ===")
    for m in (5, 6):
        report(m, "Bian", constrained_basis(m, False, True), rng, 2)
    print("\n=== no condition (generic symmetric operator on so(m)) ===")
    for m in (5, 6):
        report(m, "gen ", constrained_basis(m, False, False), rng, 2)
    print("\n=== cross-check A via structure-constant form sum_gh W_gh C_g C_h ===")
    for m in (4, 6):
        B = weyl_basis(m)
        W = np.einsum('k,kij->ij', rng.normal(size=B.shape[0]), B)
        W = 0.5 * (W + W.T); W /= np.linalg.norm(W)
        print(f"  m={m}: |A_eig - A_gh| = {np.linalg.norm(A_of(W,m)-A_of_gh(W,m)):.2e}")
