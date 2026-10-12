"""Reviewer 61 / C6 attack: do classical Weyl tensors already give
dim m_neg <= 2 with full support at m >= 10?  Screen the Fubini-Study family
CP^k (m=2k) and a few relatives, built from the curvature formula and projected
onto Weyl_m with an independently-built projector."""
import numpy as np
from review_r61_core import (pairs, pair_index, project_weyl, ricci_defect,
                             bianchi_defect, theta, vec_to_skew)
from review_r61_c5 import dimU


def fs_curvature(m):
    """Fubini-Study curvature operator on Lambda^2 R^m (m=2k), holomorphic
    sectional curvature 1:  R_ijkl = 1/4[d_ik d_jl - d_il d_jk
    + J_ik J_jl - J_il J_jk + 2 J_ij J_kl]."""
    J = np.zeros((m, m))
    for i in range(0, m, 2):
        J[i, i+1] = 1.0; J[i+1, i] = -1.0
    d = np.eye(m)
    P = pairs(m); D = len(P)
    R = np.zeros((D, D))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            R[a, b] = 0.25*(d[i, k]*d[j, l] - d[i, l]*d[j, k]
                            + J[i, k]*J[j, l] - J[i, l]*J[j, k]
                            + 2*J[i, j]*J[k, l])
    return R, J


def report(W, m, name):
    W = W / np.linalg.norm(W)
    lam = np.linalg.eigvalsh(W)
    nneg = int((lam < -1e-9).sum())
    du, _ = dimU(W)
    # rank of the most negative eigenvector
    _, V = np.linalg.eigh(W)
    X = vec_to_skew(V[:, 0], m)
    r = np.linalg.matrix_rank(X, tol=1e-8)
    print(f"  {name}: m={m} ricci={ricci_defect(W,m):.1e} bianchi={bianchi_defect(W,m):.1e}"
          f" #neg={nneg} rank(v_N)={r} dimU={du} theta={theta(W,m):+.6f}")
    u, c = np.unique(np.round(lam, 6), return_counts=True)
    print("     spectrum:", ", ".join(f"{a:+.6f}x{b}" for a, b in zip(u, c) if abs(a) > 1e-9))
    return nneg, du


if __name__ == '__main__':
    print("=== Fubini-Study CP^k, Weyl part ===")
    for m in (4, 6, 8, 10, 12):
        R, J = fs_curvature(m)
        print(f"  [m={m}] bianchi(R)={bianchi_defect(R,m):.1e}")
        W = project_weyl(R, m)
        report(W, m, f"W_CP^{m//2}")
    print("\n=== is the Kaehler form an eigenvector, and is it the most negative? ===")
    for m in (4, 6, 8, 10, 12):
        R, J = fs_curvature(m)
        W = project_weyl(R, m); W /= np.linalg.norm(W)
        from review_r61_core import skew_to_vec
        w = skew_to_vec(J, m); w /= np.linalg.norm(w)
        lam = float(w @ W @ w)
        resid = np.linalg.norm(W @ w - lam*w)
        print(f"  m={m}: <w,Ww>={lam:+.6f} eigen-residual={resid:.1e}"
              f"  lambda_min(W)={np.linalg.eigvalsh(W)[0]:+.6f}")
