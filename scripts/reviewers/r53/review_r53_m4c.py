"""Reviewer 53, M4 part 3.

(a) Identify the genuine 4-block S = 0 point at n = 12 found in part 1.
(b) Compare the two slack functions on the subalgebra family (the population where
    the record says "they agree") and on the sphere products.
(c) State and test the exact criterion S = 0 <=> negative graph triangle-free.
(d) Isolation test at (S^3)^3: is its orbit isolated in Crit(P)?  That, and not the
    magnitude of S, is what decides whether it can bear on openness of {S = 0}.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import time

import numpy as np
from scipy.optimize import least_squares

sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r53_core import (Le_matrix, Npairs, Pval, Qop, alt, leaks, onb_rows,
                             orbit_tangent, pairs_of, ricci, slack_struct,
                             slack_theta, theta0, weyl_basis)
from review_r53_m2m3 import embed, solve_vertex
from review_r53_m4 import genuine, neg_graph_slack

LOG = _os.path.join(_ROOT, 'agent_logs/review_r53_multiblock.log')


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, 'a') as f:
        f.write(line + '\n')


def show_point(bl, w):
    n = sum(bl)
    W = embed(bl, w)
    W = W / np.linalg.norm(W)
    th = Pval(n, W)
    log(f"    blocks={bl} n={n} theta={th:.9f} ({th/theta0(n):.6f} theta_0) "
        f"resid={np.linalg.norm(Qop(n,W)-th*W):.2e} |Ric|={np.linalg.norm(ricci(n,W)):.2e}")
    log(f"    w =\n{np.array2string(w, precision=9)}")
    lk = leaks(n, W)
    tri, ne = neg_graph_slack(n, W)
    log(f"    S_struct={slack_struct(n,W):.9f}  S_theta={slack_theta(n,W,th):.9f}  "
        f"leaks(mm->m, hm->h, hh->m)=({lk[0]:.4f},{lk[1]:.4f},{lk[2]:.4f})  "
        f"neg-graph edges={ne} triangles={tri}")
    ev = np.linalg.eigvalsh(W)
    log(f"    dim m (negative eigenspace) = {int((ev < -1e-9).sum())} of N={Npairs(n)}, "
        f"n^2/4 = {n*n/4}")
    return W, th


def main():
    log("M4 part 3: the 4-block S=0 point, slack-vs-slack, and isolation at (S^3)^3")

    log("  (a) genuine k>=3 points with S = 0 found at n=12, blocks (3,3,3,3):")
    sols = solve_vertex((3, 3, 3, 3), nstart=600, seed=91)
    for w, th in sorted(sols, key=lambda t: -t[1]):
        W = embed((3, 3, 3, 3), w)
        Wn = W / np.linalg.norm(W)
        if slack_struct(12, Wn) < 1e-9 and genuine((3, 3, 3, 3), w)[0]:
            show_point((3, 3, 3, 3), w)

    log("  (b) the two slacks on the subalgebra family:")
    from p5_casimir_family import (projector, casimir_operator, h_adjoint,
                                   h_so3_in_so5, su3_structure_constants,
                                   so_k_structure_constants, h_so_p_so_q)
    cases = [("su(3) bi-invariant", 8, h_adjoint(su3_structure_constants())),
             ("so(5) adjoint", 10, h_adjoint(so_k_structure_constants(5))),
             ("so(3) irred in so(5)", 5, h_so3_in_so5()),
             ("so(4)+so(4)", 8, h_so_p_so_q(8, 4)),
             ("so(5)+so(5)", 10, h_so_p_so_q(10, 5)),
             ("so(3)+so(5)", 8, h_so_p_so_q(8, 3)),
             ("so(4)+so(6)", 10, h_so_p_so_q(10, 4))]
    log(f"  {'point':>22} {'n':>3} {'theta':>10} {'S_struct':>12} {'sqrt':>9} "
        f"{'S_theta':>12} {'ratio':>10}")
    for nm, n, gens in cases:
        Pi, r = projector(gens, n)
        W = casimir_operator(Pi, r, Npairs(n))
        W = W / np.linalg.norm(W)
        th = Pval(n, W)
        res = float(np.linalg.norm(Qop(n, W) - th * W))
        if res > 1e-8:
            log(f"  {nm:>22} {n:3d}  not critical (res {res:.1e})")
            continue
        sn = slack_struct(n, W)
        st = slack_theta(n, W, th)
        ratio = (sn / st) if abs(st) > 1e-12 else float('nan')
        log(f"  {nm:>22} {n:3d} {th:10.6f} {sn:12.6f} {np.sqrt(sn):9.4f} "
            f"{st:12.6f} {ratio:10.4f}")

    log("  (c) exact criterion test: S_struct = 0 iff the negative graph is triangle-free")
    rng = np.random.default_rng(4)
    bad = 0
    tested = 0
    for n in (6, 7, 8, 9):
        prs, _ = pairs_of(n)
        for _ in range(300):
            d = rng.standard_normal(len(prs))
            W = np.diag(d)
            sn = slack_struct(n, W)
            tri, ne = neg_graph_slack(n, W)
            tested += 1
            if (sn < 1e-9) != (tri == 0):
                bad += 1
    log(f"    {tested} random coordinate-diagonal operators, mismatches: {bad}")

    log("  (d) isolation of the (S^3)^3 orbit in Crit(P) at n=9")
    n = 9
    w = np.full((3, 3), -0.0962250448649377)
    np.fill_diagonal(w, 0.2886751345948129)
    W0 = embed((3, 3, 3), w)
    W0 = W0 / np.linalg.norm(W0)
    th0v = Pval(n, W0)
    B = weyl_basis(n)
    d = B.shape[0]
    coord = np.einsum('kij,ij->k', B, W0)

    def Fvec(x):
        Wx = np.einsum('k,kij->ij', x, B)
        QW = Qop(n, Wx)
        thx = float(np.sum(Wx * QW))
        return np.einsum('kij,ij->k', B, QW - thx * Wx)

    # tangent frame: orbit directions and the E(1/2)-excess directions
    M = Le_matrix(n, W0 / th0v, B)
    ev, evec = np.linalg.eigh(M)
    Ehalf = evec[:, np.abs(ev - 0.5) < 1e-8]          # (d, 81)
    Emat = np.einsum('kd,dij->kij', Ehalf.T, B)
    Erow = onb_rows(Emat)                              # 81 x d*d rows in matrix coords
    Urow = onb_rows(orbit_tangent(n, W0))              # 27
    # excess directions: E(1/2) minus the orbit, in Weyl coordinates
    Ecoef = Ehalf.T                                    # 81 x d
    Ucoef = np.array([np.einsum('kij,ij->k', B, np.einsum('r,rij->ij', u.reshape(-1),
                                                          B) if False else
                                np.zeros((Npairs(n), Npairs(n))))
                      for u in range(0)])               # placeholder
    Ucoef = np.array([np.einsum('kij,ij->k', B, u.reshape(Npairs(n), Npairs(n)))
                      for u in Urow])
    # project orbit out of E(1/2)
    Q_, _ = np.linalg.qr(Ucoef.T)
    Exc = Ecoef - (Ecoef @ Q_) @ Q_.T
    u_, s_, vt_ = np.linalg.svd(Exc, full_matrices=False)
    exc = vt_[s_ > 1e-8]
    log(f"    dim E(1/2)={Ecoef.shape[0]}, orbit={Ucoef.shape[0]}, "
        f"excess directions={exc.shape[0]}")
    rng2 = np.random.default_rng(53)
    returned = 0
    new = 0
    newpts = []
    NT = 120
    for t in range(NT):
        dirn = rng2.standard_normal(exc.shape[0]) @ exc
        dirn -= (dirn @ coord) * coord / (coord @ coord)
        dirn /= np.linalg.norm(dirn)
        for eps in (1e-2, 3e-2, 1e-1):
            x0 = coord + eps * dirn
            x0 /= np.linalg.norm(x0)
            sol = least_squares(lambda x: np.concatenate([Fvec(x), [x @ x - 1.0]]),
                                x0, method='lm', xtol=1e-15, ftol=1e-15)
            if np.linalg.norm(Fvec(sol.x)) > 1e-11:
                continue
            Wx = np.einsum('k,kij->ij', sol.x, B)
            Wx /= np.linalg.norm(Wx)
            thx = Pval(n, Wx)
            # distance to the starting orbit
            dist = np.linalg.norm(Wx - W0)
            gaugeless = np.linalg.norm(Wx - W0 - (Urow.T @ (Urow @ (Wx - W0).ravel())
                                                  ).reshape(Wx.shape))
            if gaugeless < 1e-6 and abs(thx - th0v) < 1e-9:
                returned += 1
            else:
                new += 1
                newpts.append((thx, slack_struct(n, Wx), dist, gaugeless))
    log(f"    {NT*3} transverse Newton corrections: {returned} returned to the orbit, "
        f"{new} landed elsewhere")
    if newpts:
        thetas = sorted(set(round(p[0], 9) for p in newpts))
        log(f"    distinct thetas found off-orbit: {thetas[:20]}")
        smin = min(p[1] for p in newpts)
        log(f"    smallest S_struct among off-orbit critical points: {smin:.4e}")
        for p in sorted(newpts, key=lambda q: q[1])[:8]:
            log(f"      theta={p[0]:.9f} S={p[1]:.4e} |W-W0|={p[2]:.4f} gauge-free={p[3]:.4f}")
    log("M4 part 3 done")


if __name__ == '__main__':
    main()
