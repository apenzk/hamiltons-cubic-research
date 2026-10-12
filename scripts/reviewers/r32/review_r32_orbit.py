"""Reviewer 32: N11 -- the orbit tangent space, dim E(1/2), and the direction
of the inequality the argument actually needs."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r32_core import (planes, plane_index, phi_matrices,
                             struct_sparse_lists, W_pq, L_operator_sparse,
                             weyl_basis)


def orbit_tangent(n, W):
    """span{ [rho(A), W] : A in so(n) }, rho(A)X = [A,X] on Lambda^2."""
    P = phi_matrices(n)
    N = P.shape[0]
    cols = []
    for a in range(N):
        rho = np.zeros((N, N))
        for m in range(N):
            C = P[a] @ P[m] - P[m] @ P[a]
            for r in range(N):
                rho[r, m] = 0.5 * np.trace(P[r].T @ C)
        V = rho @ W - W @ rho
        cols.append(V.ravel())
    Mt = np.array(cols).T
    u, s, vt = np.linalg.svd(Mt, full_matrices=False)
    rank = int((s > 1e-9 * max(1.0, s[0])).sum())
    return u[:, :rank], rank


print(f"{'p,q':>7} {'n':>3} {'dim orbit':>10} {'pq':>5} "
      f"{'|L_e V - V/2| on orbit':>24}")
for n in range(4, 12):
    for p in range(2, n // 2 + 1):
        q = n - p
        N = n * (n - 1) // 2
        W = W_pq(n, p, q)
        e = W / ((n - 1) / (p * q))
        U, rank = orbit_tangent(n, W)
        lists = struct_sparse_lists(n)
        Lop = L_operator_sparse(n, e, lists)
        LU = Lop @ U
        resid = np.abs(LU - 0.5 * U).max()
        print(f"{p:3d},{q:3d} {n:3d} {rank:10d} {p*q:5d} {resid:24.3e}"
              f"{'' if rank == p*q else '   *** dim orbit != pq ***'}")
