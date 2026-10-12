"""Claim 4, the premise: hunt for graded critical points inside a fixed
grading, started INSIDE the graded cone (W|_h >= 0, W|_m < 0), to test whether
the graded critical set is exhausted by the record's projector ansatz
  W = a_1 Pi_{h_1} + ... + a_r Pi_{h_r} + g Pi_m .
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K
from r112_claim4 import sigma_basis, cubic_tensor, newton

rng = np.random.default_rng(7112)
LOG = _os.path.join(_ROOT, 'agent_logs/reviewer112.log')
def log(m):
    print(m, flush=True)
    open(LOG, 'a').write(f"[{time.strftime('%H:%M:%S')}] {m}\n")


def run(n, eps, tag, starts=400):
    L = K.lam2(eps)
    w = np.linalg.eigvalsh(L)
    Ph = np.linalg.eigh(L)[1][:, np.linalg.eigh(L)[0] > 0]   # h = +1 eigenspace
    Pm = np.linalg.eigh(L)[1][:, np.linalg.eigh(L)[0] < 0]
    Prh, Prm = Ph @ Ph.T, Pm @ Pm.T
    B = sigma_basis(n, eps)
    Phi = cubic_tensor(n, B)
    Bc = B.reshape(B.shape[0], -1)
    log(f"== {tag} n={n}: dim W^sigma={B.shape[0]}, dim h={Ph.shape[1]}, dim m={Pm.shape[1]}")
    res_rows = []
    for _ in range(starts):
        A = rng.standard_normal((Ph.shape[1], Ph.shape[1])); A = A @ A.T
        Bm = rng.standard_normal((Pm.shape[1], Pm.shape[1])); Bm = -(Bm @ Bm.T)
        M0 = Ph @ A @ Ph.T + Pm @ Bm @ Pm.T
        M0 = K.proj_weyl(n, M0)
        nrm = np.linalg.norm(M0)
        if nrm < 1e-9:
            continue
        x = Bc @ (M0 / nrm).ravel()
        x /= np.linalg.norm(x)
        x, r = newton(Phi, x)
        if r > 1e-11:
            continue
        M = np.einsum('d,dij->ij', x, B)
        if K.crit_residual(n, M) > 1e-9:
            continue
        th = K.theta(n, M)
        if th < 0:
            M, th = -M, -th
        if abs(th) < 1e-7:
            continue
        smm, shm = K.slack_mmm(n, M), K.slack_hhm(n, M)
        ev = np.linalg.eigvalsh(M)
        # scalar-on-blocks test:  is W = a Pi_h + g Pi_m  (or block-scalar)?
        blk = float(np.linalg.norm(M - (np.trace(Prh @ M) / Ph.shape[1]) * Prh
                                     - (np.trace(Prm @ M) / Pm.shape[1]) * Prm))
        res_rows.append((th, smm, shm, int((ev < -1e-9).sum()), blk, len(np.unique(np.round(ev, 8)))))
    clusters = []
    for th, smm, shm, dm, blk, nev in sorted(res_rows):
        hit = [o for o in clusters if abs(o[0] - th) < 1e-7 and o[3] == dm]
        if hit:
            hit[0][6] += 1
        else:
            clusters.append([th, smm, shm, dm, blk, nev, 1])
    ng = [o for o in clusters if o[1] < 1e-8 and o[2] < 1e-8]
    log(f"   {len(res_rows)}/{starts} converged, {len(clusters)} distinct, {len(ng)} FULLY GRADED")
    for th, smm, shm, dm, blk, nev, cnt in clusters:
        if smm < 1e-8 and shm < 1e-8:
            log(f"   GRADED theta={th:.9f} th/th0={th/K.theta0(n):.4f} dim_m={dm} "
                f"|W - (a.Pi_h + g.Pi_m)|={blk:.3e} #distinct eigenvalues={nev} n={cnt}")
    if not ng:
        log(f"   (no fully graded point reached; nearest S_mmm={min(o[1] for o in clusters):.3e})"
            if clusters else "   (nothing converged)")
    return clusters


if __name__ == '__main__':
    for n, ks in ((6, (1, 2, 3)), (8, (2, 3, 4))):
        for k in ks:
            run(n, np.diag([1.0] * k + [-1.0] * (n - k)), f'so({k})+so({n-k})',
                400 if n == 6 else 150)
        J = np.zeros((n, n))
        for i in range(n // 2):
            J[2 * i, 2 * i + 1] = 1; J[2 * i + 1, 2 * i] = -1
        run(n, J, f'u({n//2})', 400 if n == 6 else 150)
