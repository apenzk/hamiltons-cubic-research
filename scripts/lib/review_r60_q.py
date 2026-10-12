"""Reviewer 60: independent build of Hamilton's Q(W)=W^2+W^# and theta=<W,Q(W)>/|W|^3."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from review_r60_core import *
from functools import lru_cache


@lru_cache(maxsize=None)
def struct(m):
    """c[a,c,d] = <[phi_c, phi_d], phi_a>"""
    C = ad_matrices(m)          # C[g][h,k] = <[phi_g,phi_k],phi_h>
    D = m * (m - 1) // 2
    c = np.zeros((D, D, D))
    for g in range(D):
        for k in range(D):
            for h in range(D):
                c[h, g, k] = C[g][h, k]
    return c


def sharp(m, W):
    c = struct(m)
    # (W#)_{ab} = 1/2 sum c_{acd} c_{bef} W_{ce} W_{df}
    T = np.einsum('acd,ce->ade', c, W, optimize=True)      # a,d,e
    S = np.einsum('ade,df->aef', T, W, optimize=True)      # a,e,f
    return 0.5 * np.einsum('aef,bef->ab', S, c, optimize=True)


def Q(m, W):
    return W @ W + sharp(m, W)


def theta(m, W):
    n = np.linalg.norm(W)
    return float(np.sum(W * Q(m, W)) / n**3)


if __name__ == "__main__":
    # calibration 1: the diagonal formula  theta = 1/2 (sum M_ab^3 + tr M^3), tr M^2 = 2
    rng = np.random.default_rng(7)
    for m in [5, 6, 7]:
        A = rng.standard_normal((m, m)); M = A + A.T
        np.fill_diagonal(M, 0.0)
        # project to zero row sums with zero diagonal
        for _ in range(400):
            r = M.sum(1) / (m - 1)
            M = M - (r[:, None] + r[None, :]) / 2
            np.fill_diagonal(M, 0.0)
        M *= np.sqrt(2.0 / np.trace(M @ M))
        W = np.zeros((m*(m-1)//2, m*(m-1)//2))
        for a, (i, j) in enumerate(pairs(m)):
            W[a, a] = M[i, j]
        ric, bia, sy = is_weyl(m, W)
        pred = 0.5 * (np.sum(M**3) + np.trace(np.linalg.matrix_power(M, 3)))
        print(f"m={m} |W|={np.linalg.norm(W):.6f} ric={ric:.1e} bia={bia:.1e}  "
              f"theta={theta(m, W):.9f}  diagonal formula={pred:.9f}")
    # calibration 2: theta_0(n) at the balanced sphere product
    for m in [6, 8, 10, 12]:
        h = m // 2
        M = np.zeros((m, m))
        M[:h, h:] = 1.0; M[h:, :h] = 1.0
        # same-half entries d, cross entries c, zero row sums: (h-1)d + h*c = 0
        cc, dd = 1.0, -1.0 * m / (2 * (h - 1)) * 0 + 0.0
        dd = -h * cc / (h - 1)
        M = np.full((m, m), 0.0)
        M[:h, :h] = dd; M[h:, h:] = dd; M[:h, h:] = cc; M[h:, :h] = cc
        np.fill_diagonal(M, 0.0)
        M *= np.sqrt(2.0 / np.trace(M @ M))
        W = np.zeros((m*(m-1)//2, m*(m-1)//2))
        for a, (i, j) in enumerate(pairs(m)):
            W[a, a] = M[i, j]
        t0 = (m - 1) / m * np.sqrt(2 * (m - 2) / (m - 1))
        print(f"m={m} balanced product: theta={theta(m, W):.9f}   theta_0(m)={t0:.9f}"
              f"  ric={is_weyl(m,W)[0]:.1e}")
