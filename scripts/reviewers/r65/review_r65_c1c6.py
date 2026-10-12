"""Reviewer 65 / Lemma B block identity, C1 and C6.

Lemma B identity:   2*mu(m) + gamma = 2(n-2) d   for ISOTROPIC m, where
    gamma = sum_{a in onb(m)} || P_h ad(e_a) P_h ||_F^2 .
C6(b) identity:     6 S_mmm + 4 S_mmh + 2 S_mhh = 2 d (n-2)   -- checked against the
    same block decomposition with S_mmm = alpha/6, S_mmh = beta/2, S_mhh = gamma/2
    (unordered-triple counts), for ARBITRARY subspaces, not only isotropic ones.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r65_lib import structure_tensor, ad_matrices, orth, sympair_subspace, mu


def blocks(V, C):
    """alpha,beta,gamma,delta for the subspace spanned by orthonormal columns of V."""
    N = C.shape[0]
    W = orth(np.eye(N) - V @ V.T @ np.eye(N))  # not reliable; build complement by SVD
    U, s, _ = np.linalg.svd(np.eye(N) - V @ V.T)
    d = V.shape[1]
    W = U[:, :N - d]
    Cm = np.einsum('ijk,ia,jb,kc->abc', C, V, V, V, optimize=True)
    Cmmh = np.einsum('ijk,ia,jb,kp->abp', C, V, V, W, optimize=True)
    Cmhh = np.einsum('ijk,ia,jp,kq->apq', C, V, W, W, optimize=True)
    Chhh = np.einsum('ijk,ip,jq,kr->pqr', C, W, W, W, optimize=True)
    return (Cm ** 2).sum(), (Cmmh ** 2).sum(), (Cmhh ** 2).sum(), (Chhh ** 2).sum()


if __name__ == "__main__":
    rng = np.random.default_rng(650)
    print("block identities: alpha+2beta+gamma = 2(n-2)d  and  beta+2gamma+delta = 2(n-2)(N-d)")
    print("(these hold for EVERY subspace; isotropy is alpha=0)\n")
    for n in range(4, 8):
        C = structure_tensor(n); N = C.shape[0]
        for d in [1, 2, N // 3, N // 2, N - 2]:
            if not (1 <= d <= N - 1):
                continue
            V = orth(rng.standard_normal((N, d)))
            a, b, g, dl = blocks(V, C)
            e1 = a + 2 * b + g - 2 * (n - 2) * d
            e2 = b + 2 * g + dl - 2 * (n - 2) * (N - d)
            e3 = a + 3 * b + 3 * g + dl - 2 * (n - 2) * N
            print(f"  n={n} d={d:>3} random:   res1={e1:+.2e} res2={e2:+.2e} res3={e3:+.2e}")
        for p in range(1, n // 2 + 1):
            V = sympair_subspace(n, p); d = V.shape[1]
            a, b, g, dl = blocks(V, C)
            print(f"  n={n} d={d:>3} sympair p={p}: alpha={a:.2e} beta={b:.3f} gamma={g:.2e} "
                  f"delta={dl:.3f}  mu={mu(V,C):.3f} (n-2)d={(n-2)*d}")
        print()
