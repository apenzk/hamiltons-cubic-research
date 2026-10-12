"""Reviewer 61 / C6: the one-parameter test behind the screen's verdict.  The
screen says feasibility of a full-support two-negative Weyl_m tensor needs both
negative eigenvectors to be rank-4 complex structures -- whose images span at
most 8 dimensions.  Here z is deformed away from rank 4 by a single singular
value eps and the exact SDP margin is read off as eps -> 0."""
import numpy as np, sys
from review_r61_core import skew_to_vec, vec_to_skew
from review_r61_c6_sdp import margin


def blockmat(m, sv, frame):
    X = np.zeros((m, m))
    for i, a in enumerate(sv):
        u = frame[:, 2*i]; v = frame[:, 2*i+1]
        X += a*(np.outer(u, v) - np.outer(v, u))
    x = skew_to_vec(X, m)
    return x/np.linalg.norm(x)


def spanrank(y, z, m):
    return np.linalg.matrix_rank(np.hstack([vec_to_skew(y, m), vec_to_skew(z, m)]), tol=1e-7)


if __name__ == '__main__':
    rng = np.random.default_rng(9)
    for m in (8, 10):
        print(f"=== m={m}: y = rank-4 complex structure on e1..e4,"
              f" z = (1,1,eps) on a shifted frame ===")
        F = np.eye(m)
        y = blockmat(m, [1, 1], F)
        # z supported on e3..e8 (m=8) / e5..e10 (m=10) so that supports span R^m as eps>0
        idx = list(range(m))[-6:]
        Fz = np.eye(m)[:, idx]
        for eps in (0.0, 1e-6, 1e-4, 1e-2, 0.1, 0.3, 0.7, 1.0):
            sv = [1.0, 1.0, eps]
            z = blockmat(m, sv, np.hstack([Fz, np.zeros((m, 0))]))
            z = z - (z @ y)*y
            n = np.linalg.norm(z)
            if n < 1e-9:
                continue
            z /= n
            t, _, _ = margin(m, y, z)
            print(f"   eps={eps:<8g} span(im y + im z)={spanrank(y,z,m)}"
                  f"  SDP margin t={t:+.4e}")
            sys.stdout.flush()
