"""Claim 4: is the graded critical set a FINITE union of O(n)-orbits?

For each involution class sigma of so(n) the sigma-fixed subspace W_n^sigma is
built; by the principle of symmetric criticality (Palais) a critical point of
P restricted to it is a critical point of P on the whole sphere.  Multistart
Newton then enumerates the critical points there, and each is filtered for FULL
gradedness (S_mmm = S_hhm = 0) and for having the sigma-grading as its own
eigenvalue splitting.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K

rng = np.random.default_rng(9112)
LOG = _os.path.join(_ROOT, 'agent_logs/reviewer112.log')
def log(m):
    print(m, flush=True)
    open(LOG, 'a').write(f"[{time.strftime('%H:%M:%S')}] {m}\n")


def sigma_basis(n, eps):
    L = K.lam2(eps)
    Bs = K.weyl_basis(n)
    D = Bs.shape[0]
    A = np.einsum('eij,dij->ed', Bs, np.einsum('ik,dkl,jl->dij', L, Bs, L))
    A = 0.5 * (A + A.T)
    w, V = np.linalg.eigh(A)
    return np.einsum('dk,dij->kij', V[:, w > 0.5], Bs)


def cubic_tensor(n, B):
    """Phi_def = <B_d . B_e, B_f> for the product A.B = 1/2(AB+BA) + sh(A,B)."""
    c = K.struct(n)
    prod = np.einsum('dij,ejk->deik', B, B, optimize=True)
    T1 = 0.5 * (np.einsum('deik,fki->def', prod, B, optimize=True)
                + np.einsum('edik,fki->def', prod, B, optimize=True))
    Y = np.einsum('apq,dpr->daqr', c, B, optimize=True)
    U = np.einsum('eqs,brs->eqrb', B, c, optimize=True)
    Z = np.einsum('daqr,eqrb->deab', Y, U, optimize=True)
    T2 = 0.5 * np.einsum('deab,fab->def', Z, B, optimize=True)
    Phi = T1 + T2
    return (Phi + Phi.transpose(1, 2, 0) + Phi.transpose(2, 0, 1)
            + Phi.transpose(0, 2, 1) + Phi.transpose(1, 0, 2)
            + Phi.transpose(2, 1, 0)) / 6.0


def newton(Phi, x, iters=120, tol=1e-14):
    D = len(x)
    I = np.eye(D)
    for _ in range(iters):
        Gx = np.einsum('def,e,f->d', Phi, x, x)         # = grad P /3
        th = float(Gx @ x)
        F = Gx - th * x
        if np.linalg.norm(F) < tol:
            break
        H = 2 * np.einsum('def,f->de', Phi, x)
        J = H - th * I - 3.0 * np.outer(x, Gx)
        Pp = I - np.outer(x, x)
        try:
            step = np.linalg.lstsq(J @ Pp, -F, rcond=None)[0]
        except np.linalg.LinAlgError:
            return x, np.inf
        x = x + Pp @ step
        nx = np.linalg.norm(x)
        if not np.isfinite(nx) or nx == 0:
            return x, np.inf
        x /= nx
    Gx = np.einsum('def,e,f->d', Phi, x, x)
    return x, float(np.linalg.norm(Gx - (Gx @ x) * x))


def census(n, B, tag, starts):
    Phi = cubic_tensor(n, B)
    rows = []
    for _ in range(starts):
        x = rng.standard_normal(B.shape[0]); x /= np.linalg.norm(x)
        x, res = newton(Phi, x)
        if res > 1e-11:
            continue
        M = np.einsum('d,dij->ij', x, B)
        full = K.crit_residual(n, M)
        th = K.theta(n, M)
        if th < 0:
            M, th = -M, -th
        if abs(th) < 1e-7 or full > 1e-9:
            continue
        ev = np.linalg.eigvalsh(M)
        rows.append((th, K.slack_mmm(n, M), K.slack_hhm(n, M),
                     int((ev < -1e-9).sum()), full))
    clusters = []
    for th, smm, shm, dm, full in sorted(rows):
        hit = [o for o in clusters if abs(o[0] - th) < 1e-7 and o[3] == dm]
        if hit:
            hit[0][5] += 1
        else:
            clusters.append([th, smm, shm, dm, full, 1])
    ng = sum(1 for o in clusters if o[1] < 1e-8 and o[2] < 1e-8)
    log(f"== {tag} n={n} dim={B.shape[0]}: {len(rows)}/{starts} converged, "
        f"{len(clusters)} distinct, {ng} graded")
    for th, smm, shm, dm, full, cnt in clusters:
        mark = '  <== FULLY GRADED' if (smm < 1e-8 and shm < 1e-8) else ''
        log(f"     theta={th:.9f} th/th0={th/K.theta0(n):7.4f} S_mmm={smm:10.3e} "
            f"S_hhm={shm:10.3e} dim_m={dm:3d} res={full:.1e} n={cnt}{mark}")
    return clusters


if __name__ == '__main__':
    n = int(sys.argv[1]); starts = int(sys.argv[2])
    for k in range(1, n // 2 + 1):
        eps = np.diag([1.0] * k + [-1.0] * (n - k))
        census(n, sigma_basis(n, eps), f'sigma=so({k})+so({n-k})', starts)
    if n % 2 == 0:
        J = np.zeros((n, n))
        for i in range(n // 2):
            J[2 * i, 2 * i + 1] = 1; J[2 * i + 1, 2 * i] = -1
        census(n, sigma_basis(n, J), f'sigma=u({n//2})', starts)
    if n <= 6:
        census(n, K.weyl_basis(n), 'UNBIASED full Weyl_n', starts)
