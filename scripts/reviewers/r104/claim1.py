import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r104'))
import numpy as np, weyl104 as w

rng = np.random.default_rng(2026)
print("=== Claim 1: the two diagonals ===")
for n in (5,6,7,8):
    for trial in range(3):
        W = w.random_weyl(n, rng)
        M = w.tensor_to_M(W, n)
        K = w.vertex_matrix(W, n)
        P = w.pair_index(n)
        # (a) diag M in phi-basis of Lambda^2 equals K
        dM = np.array([M[a,a] for a in range(len(P))])
        dK = np.array([K[i,j] for (i,j) in P])
        r_a = np.abs(dM-dK).max()
        # (b) psi block of ringW = -K|_{1perp}
        vecs, kw = w.K_eigvecs_on_1perp(K, n)
        R = w.ring_W_operator(W, n, list(vecs))
        Np = len(P)
        psiblk = R[Np:, Np:]
        r_b = np.abs(psiblk + np.diag(kw)).max()
        # (c) sum d^2 = 1.5 |K|^2
        d = np.diag(R)
        t = np.sum(K**2)
        r_c = abs(np.sum(d**2) - 1.5*t)
        r_c2 = abs(np.sum(d[:Np]**2) - 0.5*t)
        # (d) K 1 = 0
        r_d = np.abs(K.sum(axis=1)).max()
        # (e) omega >- d  (majorization), and sum omega^2 = 3
        om = np.linalg.eigvalsh(R)
        s_om = np.sort(om)[::-1]; s_d = np.sort(d)[::-1]
        maj = min(np.cumsum(s_om)-np.cumsum(s_d))
        mu = np.linalg.eigvalsh(M)
        s_mu = np.sort(mu)[::-1]; s_dp = np.sort(dK)[::-1]
        majmu = min(np.cumsum(s_mu)-np.cumsum(s_dp))
        # theta identity
        th = w.theta_from_M(M, n)
        th2 = 1.5*w.p3(mu) - 0.5*w.p3(om)
        if trial==0:
            print(f"n={n}: diagM-K {r_a:.2e} | psi+K {r_b:.2e} | sum d^2-1.5t {r_c:.2e} "
                  f"| sum dphi^2-t/2 {r_c2:.2e} | K1 {r_d:.2e} | sum om^2 {np.sum(om**2):.12f} "
                  f"| tr ringW {np.trace(R):.2e} | maj_om {maj:.2e} maj_mu {majmu:.2e} "
                  f"| theta {th:.10f} vs 1.5p3(mu)-.5p3(om) {th2:.10f} | t={t:.4f}")
