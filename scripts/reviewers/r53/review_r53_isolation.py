"""Reviewer 53: is the (S^3)^3 orbit isolated in Crit(P) at n=9?

That -- and not the magnitude of S -- is what decides whether a point with S > 0 can
bear on whether { S = 0 } is open.  Openness of { S = 0 } is broken only by a
SEQUENCE of S > 0 critical points converging to an S = 0 critical point, so a single
point with large S is relevant exactly when it is an accumulation point of that kind.

Method: Newton (Levenberg-Marquardt) with an ANALYTIC Jacobian on
   F(x) = coords( Q(W_x) - theta(x) W_x ),  theta(x) = <W_x, Q(W_x)>,  |x| = 1,
started at W_0 + eps * v with v ranging over the 54 excess directions of E(1/2)
(the directions where the degeneracy could hide a nearby critical point) and over
random Weyl directions as a control.

DF[H] = 2 W o H - 3 <H, Q(W)> W - theta H.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import time

import numpy as np
from scipy.optimize import least_squares

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Le_matrix, Npairs, Pval, Qop, circ, onb_rows,
                             orbit_tangent, slack_struct, slack_theta, theta0,
                             weyl_basis)
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
    x0 = np.einsum('kij,ij->k', B, W0)
    log(f"ISOLATION test at (S^3)^3, n=9, dim Weyl = {d}, theta = {th0v:.9f}")

    def toW(x):
        return np.einsum('k,kij->ij', x, B)

    def F(x):
        Wx = toW(x)
        QW = Qop(n, Wx)
        thx = float(np.sum(Wx * QW))
        r = np.einsum('kij,ij->k', B, QW - thx * Wx)
        return np.concatenate([r, [float(x @ x) - 1.0]])

    def J(x):
        Wx = toW(x)
        QW = Qop(n, Wx)
        thx = float(np.sum(Wx * QW))
        L = Le_matrix(n, Wx, B)                       # <B_k, Wx o B_l>
        q = np.einsum('kij,ij->k', B, QW)
        Jm = 2.0 * L - 3.0 * np.outer(x, q) - thx * np.eye(d)
        return np.vstack([Jm, 2.0 * x[None, :]])

    # sanity: analytic Jacobian against finite differences
    rng = np.random.default_rng(5)
    xt = x0 + 0.05 * rng.standard_normal(d)
    Ja = J(xt)
    h = 1e-6
    err = 0.0
    for _ in range(5):
        v = rng.standard_normal(d)
        v /= np.linalg.norm(v)
        fd = (F(xt + h * v) - F(xt - h * v)) / (2 * h)
        err = max(err, float(np.max(np.abs(Ja @ v - fd))))
    log(f"  analytic Jacobian vs central differences: max err {err:.2e}")

    Urow = onb_rows(orbit_tangent(n, W0))
    Ucoef = np.array([np.einsum('kij,ij->k', B, u.reshape(Npairs(n), Npairs(n)))
                      for u in Urow])
    M = Le_matrix(n, W0 / th0v, B)
    ev, evec = np.linalg.eigh(M)
    Ecoef = evec[:, np.abs(ev - 0.5) < 1e-8].T
    Qo, _ = np.linalg.qr(Ucoef.T)
    Exc = Ecoef - (Ecoef @ Qo) @ Qo.T
    _, s_, vt_ = np.linalg.svd(Exc, full_matrices=False)
    exc = vt_[s_ > 1e-8]
    log(f"  orbit {Ucoef.shape[0]}, E(1/2) {Ecoef.shape[0]}, excess {exc.shape[0]}")

    def run(name, dirs, eps_list, ndir):
        rng2 = np.random.default_rng(53)
        ret = 0
        new = []
        for t in range(ndir):
            v = rng2.standard_normal(dirs.shape[0]) @ dirs
            v -= (v @ x0) * x0
            v /= np.linalg.norm(v)
            for eps in eps_list:
                xs = x0 + eps * v
                xs /= np.linalg.norm(xs)
                sol = least_squares(F, xs, jac=J, method='lm',
                                    xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=4000)
                if np.linalg.norm(F(sol.x)) > 1e-11:
                    continue
                Wx = toW(sol.x)
                Wx /= np.linalg.norm(Wx)
                thx = Pval(n, Wx)
                D = Wx - W0
                gauge = np.linalg.norm(D - (Urow.T @ (Urow @ D.ravel())).reshape(D.shape))
                if gauge < 1e-6 and abs(thx - th0v) < 1e-9:
                    ret += 1
                else:
                    new.append((thx, slack_struct(n, Wx), gauge))
        log(f"  {name}: {ret} returned to the starting orbit, {len(new)} landed elsewhere")
        if new:
            ths = sorted(set(round(p[0], 8) for p in new))
            log(f"    thetas found off-orbit: {ths[:25]}")
            log(f"    smallest S_struct off-orbit: {min(p[1] for p in new):.3e}")
            near = [p for p in new if p[2] < 0.35]
            log(f"    of those, {len(near)} within gauge-free distance 0.35; "
                f"their (theta, S): "
                f"{[(round(p[0],6), round(p[1],4)) for p in sorted(near, key=lambda q: q[2])[:10]]}")

    t0 = time.time()
    run("54 excess E(1/2) directions", exc, (1e-3, 1e-2, 5e-2), 54)
    log(f"  [{time.time()-t0:.0f}s]")
    run("random Weyl directions (control)", np.eye(d), (1e-2, 5e-2), 30)
    log(f"  [{time.time()-t0:.0f}s total]")
    log("ISOLATION test done")


if __name__ == '__main__':
    main()
