"""Reviewer 17: characterise the zero set of the second-order obstruction at
S^3 x S^3, and try to continue an actual branch of critical points out of it.

Method:
  * Phi(v) = Pi_ker Pi_Weyl Q(v), quadratic on the transverse kernel T.
  * find zeros of Phi on the unit sphere of T (global optimisation);
  * measure dim of the zero variety by the rank of dPhi at a zero;
  * for a zero direction v, build the exact second-order predictor
        W(t) = W_0 + t v + t^2 u,  L u = -Pi_{W^perp} G(v),  <W_0,u> = -|v|^2/2,
    and correct with a SLICE-CONSTRAINED solve (orthogonal to the 9 orbit
    directions, so the corrector cannot slide along the orbit) on the CORRECT
    projected criticality residual.
"""
import sys
import numpy as np
from scipy.optimize import minimize, least_squares

from curvature_operator import Lambda2
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl
from rsharp_basis_free import Q_full
from review_r17_obstruction import Ctx, analyse, Qbil


def tensor(st, basis):
    ctx, B, ker = st["ctx"], st["B"], st["ker"]
    m = basis.shape[1]
    mats = [ctx.mat(B @ basis[:, a]) for a in range(m)]
    C = np.zeros((ker.shape[1], m, m))
    for i in range(m):
        for j in range(i, m):
            y = ker.T @ (B.T @ ctx.coord(Qbil(mats[i], mats[j], ctx.c)))
            C[:, i, j] = C[:, j, i] = y
    return C


def find_zeros(C, m, nstart=400, seed=1):
    rng = np.random.default_rng(seed)
    def f(x):
        nx = np.linalg.norm(x); v = x / nx
        p = np.einsum('kij,i,j->k', C, v, v)
        gv = 4.0 * np.einsum('k,kij,j->i', p, C, v)
        return float(p @ p), (gv - (gv @ v) * v) / nx
    zs = []
    for _ in range(nstart):
        r = minimize(f, rng.standard_normal(m), jac=True, method="L-BFGS-B",
                     options=dict(maxiter=2000, ftol=1e-20, gtol=1e-16))
        v = r.x / np.linalg.norm(r.x)
        val = np.linalg.norm(np.einsum('kij,i,j->k', C, v, v))
        if val < 1e-10:
            zs.append(v)
    return np.array(zs)


def main():
    ctx = Ctx(6)
    L2 = Lambda2(6)
    st = analyse("S^3 x S^3", ctx, weyl_sphere_product_mop(L2, 3, 3))
    W, th, w, B, Lmat, ker, T, Ob = (st[k] for k in ("W", "th", "w", "B", "Lmat", "ker", "T", "Ob"))
    m = T.shape[1]
    C = tensor(st, T)

    print("\n########## zero set of the second-order obstruction on T ##########")
    zs = find_zeros(C, m, nstart=400, seed=1)
    print(f"  zeros found: {len(zs)} / 400 starts reached |Phi(v)| < 1e-10")
    # dimension of the zero variety at a zero: 9 - rank(dPhi)
    ranks = []
    for v in zs[:40]:
        J = 2.0 * np.einsum('kij,j->ki', C, v)          # dPhi_v : R^m -> R^{dim ker}
        s = np.linalg.svd(J, compute_uv=False)
        ranks.append(int(np.sum(s > 1e-8 * max(s[0], 1e-300))))
    print(f"  rank(dPhi) at zeros: {sorted(set(ranks))}  -> local dim of the cone Z = {m - min(ranks)}"
          f" (projective dim {m - min(ranks) - 1})")
    # how big is the zero set: fraction of random 2-planes meeting it, and the
    # span of the found zeros
    if len(zs):
        sv = np.linalg.svd(zs, compute_uv=False)
        print(f"  singular values of the stacked zeros: {np.array2string(sv, precision=3)}")
        print(f"  -> the zeros span a {int(np.sum(sv > 1e-8*sv[0]))}-dim subspace of T ({m}-dim)")

    print("\n########## p3b's own basis vs a rotated basis ##########")
    rng = np.random.default_rng(3)
    Rn = np.linalg.qr(rng.standard_normal((m, m)))[0]
    Trot = T @ Rn
    Crot = tensor(st, Trot)
    d0 = np.array([np.linalg.norm(C[:, a, a]) for a in range(m)])
    d1 = np.array([np.linalg.norm(Crot[:, a, a]) for a in range(m)])
    print(f"  |Phi| on p3b's SVD basis vectors : {np.array2string(d0, precision=3)}")
    print(f"  |Phi| on a random rotated basis  : {np.array2string(d1, precision=3)}")

    print("\n########## continuation along a zero direction ##########")
    # pseudo-inverse of L on the non-kernel part of W^perp
    Hs = 3.0 * (B.T @ Lmat @ B)
    ev, V = np.linalg.eigh(Hs)
    keep = np.abs(ev) >= 1e-7
    Linv = (V[:, keep] * (3.0 / ev[keep])) @ V[:, keep].T      # inverse of L|_R in B-coords

    orb_full = B @ Ob                                          # orbit directions in D-coords
    def slice_resid(x, t_target=None):
        xx = x / np.linalg.norm(x)
        Wl = ctx.mat(xx)
        Wl = Wl / np.linalg.norm(Wl)
        Ql = Q_full(Wl, ctx.c)
        q = ctx.coord(Ql)
        thl = float(q @ ctx.coord(Wl))
        r = q - thl * ctx.coord(Wl)                            # projected criticality residual
        return r

    def full_resid(x, gauge):
        r = slice_resid(x)
        xx = x / np.linalg.norm(x)
        g = orb_full.T @ (xx - w)                              # slice (gauge) constraints
        return np.concatenate([r, gauge * g])

    hdr = f"  {'t':>6} {'|Phi(v)|':>10} {'resid_pred':>11} {'resid_corr':>11} {'|W-W0|':>9} {'|slice|':>9} {'dtheta':>10} {'spec_diff':>10}"
    for label, vlist in [("ZERO dir", zs[:3] if len(zs) else []),
                         ("p3b basis dir (nonzero obstruction)", [np.eye(m)[0], np.eye(m)[3]])]:
        for vi, v in enumerate(vlist):
            phi = np.einsum('kij,i,j->k', C, v, v)
            vB = T @ v                                          # B-coords
            vD = B @ vB
            Vm = ctx.mat(vD)
            Gv = ctx.coord(Qbil(Vm, Vm, ctx.c))
            uB = -Linv @ (B.T @ Gv)                             # solves L u = -Pi_{Wperp} G(v) on R
            uD = B @ uB - 0.5 * w                               # + normalisation piece along W_0
            print(f"\n  --- {label} #{vi}: |Phi(v)| = {np.linalg.norm(phi):.3e} ---")
            print(hdr)
            for t in (0.30, 0.20, 0.10, 0.05, 0.02):
                x0 = w + t * vD + t * t * uD
                x0 /= np.linalg.norm(x0)
                rp = np.linalg.norm(slice_resid(x0))
                sol = least_squares(full_resid, x0, args=(10.0,), method="lm",
                                    xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=200000)
                x = sol.x / np.linalg.norm(sol.x)
                Wl = ctx.mat(x); Wl /= np.linalg.norm(Wl)
                Ql = Q_full(Wl, ctx.c); thl = float(np.sum(Wl * Ql))
                rc = np.linalg.norm(ctx.coord(Ql) - thl * ctx.coord(Wl))
                dist = np.linalg.norm(Wl - W)
                sl = np.linalg.norm(orb_full.T @ (ctx.coord(Wl) - w))
                sd = np.max(np.abs(np.sort(np.linalg.eigvalsh(Wl)) - np.sort(np.linalg.eigvalsh(W))))
                print(f"  {t:6.2f} {np.linalg.norm(phi):10.2e} {rp:11.2e} {rc:11.2e} {dist:9.4f}"
                      f" {sl:9.2e} {thl-th:10.2e} {sd:10.2e}")


if __name__ == "__main__":
    main()
