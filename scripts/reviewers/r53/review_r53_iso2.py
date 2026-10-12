"""Reviewer 53: cheap isolation test at (S^3)^3, n=9, with my own damped Gauss-Newton.

scipy's MINPACK 'lm' stalls on this problem because the Jacobian is rank-deficient by
27 (the orbit gauge) plus the 54 excess directions.  A damped Gauss-Newton with a
truncated pseudo-inverse handles that directly and costs one L_e build per step.

Question: is the (S^3)^3 orbit isolated in Crit(P)?  That is what decides whether a
point with S > 0 bears on the openness of { S = 0 }; the magnitude of S does not.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import time

import numpy as np

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Le_matrix, Npairs, Pval, Qop, onb_rows, orbit_tangent,
                             slack_struct, weyl_basis)
from review_r53_m2m3 import embed

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def main():
    n = 9
    w = np.full((3, 3), -0.0962250448649377)
    np.fill_diagonal(w, 0.2886751345948129)
    W0 = embed((3, 3, 3), w)
    W0 = W0 / np.linalg.norm(W0)
    th0v = Pval(n, W0)
    B = weyl_basis(n)
    d = B.shape[0]
    Bf = B.reshape(d, -1)
    x0 = Bf @ W0.ravel()
    log(f"ISOLATION (Gauss-Newton) at (S^3)^3, n=9, dim Weyl={d}, theta={th0v:.9f}")

    def toW(x):
        return (x @ Bf).reshape(Npairs(n), Npairs(n))

    def F(x):
        Wx = toW(x)
        QW = Qop(n, Wx)
        thx = float(np.sum(Wx * QW))
        return np.concatenate([Bf @ (QW - thx * Wx).ravel(), [float(x @ x) - 1.0]])

    def J(x):
        Wx = toW(x)
        QW = Qop(n, Wx)
        thx = float(np.sum(Wx * QW))
        L = Le_matrix(n, Wx, B)
        q = Bf @ QW.ravel()
        return np.vstack([2.0 * L - 3.0 * np.outer(x, q) - thx * np.eye(d),
                          2.0 * x[None, :]])

    def newton(xs, iters=60, rcond=1e-8):
        x = xs.copy()
        for _ in range(iters):
            r = F(x)
            nr = np.linalg.norm(r)
            if nr < 1e-13:
                break
            step = np.linalg.lstsq(J(x), -r, rcond=rcond)[0]
            t = 1.0
            for _ in range(12):
                if np.linalg.norm(F(x + t * step)) < nr:
                    break
                t *= 0.5
            x = x + t * step
        return x, np.linalg.norm(F(x))

    Urow = onb_rows(orbit_tangent(n, W0))
    M = Le_matrix(n, W0 / th0v, B)
    ev, evec = np.linalg.eigh(M)
    Ecoef = evec[:, np.abs(ev - 0.5) < 1e-8].T
    Ucoef = np.array([Bf @ u for u in Urow])
    Qo, _ = np.linalg.qr(Ucoef.T)
    Exc = Ecoef - (Ecoef @ Qo) @ Qo.T
    _, s_, vt_ = np.linalg.svd(Exc, full_matrices=False)
    exc = vt_[s_ > 1e-8]
    log(f"  orbit={Ucoef.shape[0]}, E(1/2)={Ecoef.shape[0]}, excess={exc.shape[0]}")

    rng = np.random.default_rng(53)
    for name, dirs, ndir in [("excess E(1/2) directions", exc, 24),
                             ("random Weyl directions (control)", np.eye(d), 12)]:
        t0 = time.time()
        ret = 0
        conv = 0
        new = []
        for t in range(ndir):
            v = rng.standard_normal(dirs.shape[0]) @ dirs
            v -= (v @ x0) * x0
            v /= np.linalg.norm(v)
            for eps in (3e-3, 3e-2):
                xs = x0 + eps * v
                xs /= np.linalg.norm(xs)
                xf, res = newton(xs)
                if res > 1e-10:
                    continue
                conv += 1
                Wx = toW(xf)
                Wx = Wx / np.linalg.norm(Wx)
                thx = Pval(n, Wx)
                D = Wx - W0
                gauge = np.linalg.norm(D - (Urow.T @ (Urow @ D.ravel())).reshape(D.shape))
                if gauge < 1e-5 and abs(thx - th0v) < 1e-9:
                    ret += 1
                else:
                    new.append((thx, slack_struct(n, Wx), gauge))
            if (t + 1) % 6 == 0:
                log(f"    ... {t+1}/{ndir} directions, {conv} converged, {ret} returned, "
                    f"{len(new)} elsewhere [{time.time()-t0:.0f}s]")
        log(f"  {name}: {conv} converged, {ret} returned to the starting orbit, "
            f"{len(new)} landed elsewhere [{time.time()-t0:.0f}s]")
        if new:
            log(f"    thetas off-orbit: {sorted(set(round(p[0],7) for p in new))[:20]}")
            log(f"    min S_struct off-orbit: {min(p[1] for p in new):.3e}; "
                f"min gauge-free distance: {min(p[2] for p in new):.4f}")
            close = sorted(new, key=lambda q: q[2])[:6]
            log(f"    closest: {[(round(p[0],6), round(p[1],3), round(p[2],4)) for p in close]}")
    log("ISOLATION (Gauss-Newton) done")


if __name__ == '__main__':
    main()
