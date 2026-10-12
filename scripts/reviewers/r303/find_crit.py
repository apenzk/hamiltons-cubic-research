"""Solve the diagonal criticality equation from random starts and catalogue
theta, Delta, ker M, and lambda_max(L)/theta on V ^ M-perp."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from scipy.optimize import least_squares
from diagcore import (V_basis, Phi, theta_of, proj_V, crit_residual,
                      crit_residual_strong, Lop, L_matrix, defect)


def solve(n, seed, B=None):
    B = V_basis(n) if B is None else B
    rng = np.random.default_rng(seed)
    x0 = rng.normal(size=len(B))

    def M_of(x):
        M = np.einsum('k,kij->ij', x, B)
        nr = np.sqrt(np.sum(M * M))
        return M * (np.sqrt(2.0) / nr)

    def res(x):
        M = M_of(x)
        R = crit_residual(M, B)
        return np.einsum('kij,ij->k', B, R)

    sol = least_squares(res, x0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
    M = M_of(sol.x)
    return M, float(np.abs(crit_residual(M, B)).max())


def analyse(M, B):
    n = len(M)
    th = theta_of(M)
    Lm = L_matrix(M, B)
    w, v = np.linalg.eigh(Lm)
    # M direction inside V
    mv = np.einsum('kij,ij->k', B, M); mv /= np.linalg.norm(mv)
    Pperp = np.eye(len(B)) - np.outer(mv, mv)
    Lp = Pperp @ Lm @ Pperp
    wp = np.linalg.eigvalsh(Lp)
    # top eigenvalue on the orthogonal complement: drop the radial eigenpair
    ev = np.linalg.eigvalsh(Pperp @ Lm @ Pperp + 1e9 * np.outer(mv, mv) * 0)
    # honest restriction: build an orthonormal basis of M-perp inside V
    Qb, _ = np.linalg.qr(np.hstack([mv[:, None], np.eye(len(B))]))
    U = Qb[:, 1:len(B)]
    Lr = U.T @ Lm @ U
    lam = np.linalg.eigvalsh(Lr)
    s = np.linalg.svd(M, compute_uv=False)
    return dict(theta=th, Delta=defect(M), lam_max=lam.max(), lam_min=lam.min(),
                ratio=lam.max() / th if th != 0 else np.nan,
                kerdim=int(np.sum(s < 1e-8)), radial=float(mv @ Lm @ mv))


if __name__ == '__main__':
    n = int(sys.argv[1]); ns = int(sys.argv[2]) if len(sys.argv) > 2 else 30
    B = V_basis(n)
    seen = []
    for seed in range(ns):
        M, r = solve(n, seed, B)
        if r > 1e-10:
            continue
        a = analyse(M, B)
        strong = float(np.abs(crit_residual_strong(M)).max())
        key = tuple(np.round(sorted(np.linalg.eigvalsh(M)), 6))
        a['strong'] = strong
        a['seed'] = seed
        print(f"seed{seed:3d} th={a['theta']:+.6f} D={a['Delta']:+.6f} "
              f"lmax/th={a['ratio']:+.6f} radial={a['radial']/max(a['theta'],1e-12):+.4f} "
              f"ker={a['kerdim']} strongres={strong:.1e}")
        seen.append((key, M, a))
    print("distinct:", len(set(k for k, _, _ in seen)))
