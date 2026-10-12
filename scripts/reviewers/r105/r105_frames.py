"""Claim 3: the frame orbit of a single W already populates every t.

theta is a frame invariant; t = ||K(F)||^2 is not.  If the frame orbit of the
sphere product realises a range of t, then any bound R(t) valid for all W and
all frames satisfies R(t) >= theta_0(n) on that whole range -- with no
monotonicity hypothesis anywhere.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r105'))
from r105_core import (sphere_product, normalise, vertex_matrix, theta, theta0)
from scipy.optimize import minimize


def rotate(W, Q):
    T = np.tensordot(Q, W, axes=([1], [0]))
    T = np.tensordot(Q, T, axes=([1], [1])).transpose(1, 0, 2, 3)
    T = np.tensordot(Q, T, axes=([1], [2])).transpose(1, 2, 0, 3)
    T = np.tensordot(Q, T, axes=([1], [3])).transpose(1, 2, 3, 0)
    return T


def expm_skew(A):
    from scipy.linalg import expm
    return expm(A - A.T)


def t_of(W, x, n):
    A = np.zeros((n, n))
    iu = np.triu_indices(n, 1)
    A[iu] = x
    return float(np.sum(vertex_matrix(rotate(W, expm_skew(A))) ** 2))


if __name__ == '__main__':
    rng = np.random.default_rng(3)
    for n in (6, 8, 12):
        W = normalise(sphere_product(n // 2, n // 2))
        th = theta(W)
        m = n * (n - 1) // 2
        ts = []
        for _ in range(60):
            x = rng.standard_normal(m) * 1.2
            ts.append(t_of(W, x, n))
        # push t down and up by direct search
        lo = min(minimize(lambda x: t_of(W, x, n), rng.standard_normal(m),
                          method='Nelder-Mead',
                          options={'maxiter': 4000, 'fatol': 1e-10}).fun
                 for _ in range(3))
        ts = np.array(ts)
        # theta invariance control
        Q = expm_skew(rng.standard_normal((n, n)))
        dth = abs(theta(rotate(W, Q)) - th)
        print(f"n={n}: theta={th:.8f}=theta0 ({theta0(n):.8f}), invariance residual {dth:.1e}")
        print(f"   t over 60 random frames: [{ts.min():.4f}, {ts.max():.4f}];"
              f"  frame minimum of t by direct search: {lo:.4f}")
