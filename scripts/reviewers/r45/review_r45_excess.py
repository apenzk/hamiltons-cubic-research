"""Reviewer 45, phase 8.4: what IS the excess 9-dimensional space?

FINDINGS says it is Lambda^2(R^3) (x) Lambda^2(R^3) = R^3 (x) R^3, a second copy
of the orbit's own irrep.  Test it: build the nine symmetrized products
u_a v_b^T + v_b u_a^T with u_a running over the three coordinate 2-planes of the
first R^3 factor and v_b over those of the second, project them onto Weyl_n and
compare with the measured excess space by principal angles.
"""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r45_core import (struct, weyl_basis, sphere_product, pad,
                             theta_and_residual, Le_matrix, pairs_of)

LOG = 'agent_logs/review_r45_padded.log'


def log(msg):
    with open(LOG, 'a') as f:
        f.write(f"{time.strftime('%H:%M:%S')} {msg}\n")
    print(msg, flush=True)


if __name__ == "__main__":
    log("PHASE 8.4: identifying the excess space")
    for n in (6, 8, 10, 12):
        A = struct(n); B = weyl_basis(n); Bf = B.reshape(B.shape[0], -1)
        N = A.shape[0]
        ps, idx = pairs_of(n)
        W = pad(sphere_product(3, 3, 6), 6, n) if n != 6 else sphere_product(3, 3, 6)
        W = W / np.linalg.norm(W)
        th, _ = theta_and_residual(W, A)
        M = Le_matrix(Bf, W / th, A)
        w, V = np.linalg.eigh(M)
        sel = np.where(np.abs(w - 0.5) < 1e-8)[0]
        T = (np.einsum('amn,np->amp', A, W)
             - np.einsum('mn,anp->amp', W, A)).reshape(N, N * N)
        Oc = T @ Bf.T
        u0, s0, _ = np.linalg.svd(Oc, full_matrices=False)
        rk = int((s0 > max(Oc.shape) * np.finfo(float).eps * s0[0]).sum())
        Qo = ((u0[:, :rk].T @ Oc) / s0[:rk, None]).T
        E = V[:, sel]
        Perp = E - Qo @ (Qo.T @ E)
        uu, ss, _ = np.linalg.svd(Perp, full_matrices=False)
        exc = int((ss > 1e-8).sum())
        U = uu[:, :exc]

        # candidate: Lambda^2(R^3_1) (x) Lambda^2(R^3_2), symmetrized
        aidx = [idx[p] for p in [(0, 1), (0, 2), (1, 2)]]
        bidx = [idx[p] for p in [(3, 4), (3, 5), (4, 5)]]
        cand = []
        for a in aidx:
            for b in bidx:
                X = np.zeros((N, N))
                X[a, b] = X[b, a] = 1.0
                cand.append(Bf @ X.reshape(-1))       # project onto Weyl_n
        C = np.array(cand)
        q, _ = np.linalg.qr(C.T)
        rkC = int(np.linalg.matrix_rank(C, tol=1e-9))
        q = q[:, :rkC]
        sv = np.linalg.svd(U.T @ q, compute_uv=False)
        log(f"  n={n:2d}: excess dim {exc}, candidate dim {rkC}, "
            f"principal cosines min={sv.min():.12f} max={sv.max():.12f}")
