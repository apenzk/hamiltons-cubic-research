"""
P3b, two tests the plan calls for.

TEST 1 -- the exact second-order branching obstruction.
At a critical point W_0, a branch of critical points leaving in a kernel
direction v must satisfy, to second order,

        Pi_ker Q(v) = 0,

where Pi_ker projects onto ker(Hess P) and Q is the quadratic map.  This is
ONE-SIDED and that is exactly what makes it useful: when it FAILS the direction
v carries no branch, which is a proof; when it vanishes it merely permits one.
So it can certify isolation direction by direction without any continuation.

TEST 2 -- do S^3 x S^3 and CP^3 share a connected component at n = 6?
Reviewer 16 flagged that both are graded, both sit at theta = sqrt(10/9), and a
slice corrector reached criticality residual 1.9e-13 at transverse distance 0.2
with theta unchanged to nine digits -- the wrong direction for an isolated
orbit.  If a path of genuine critical points joins them, the graded set is not a
union of connected components and the whole separation idea fails outright,
value-localised or not.

Here a predictor-corrector walks from each point along its transverse kernel
directions: predict along v, then project back onto Crit(P) by Levenberg-Marquardt
on the criticality residual, and report whether theta and the slack S stay put.
A corrected path that keeps residual at machine zero over a finite distance IS a
branch of critical points.

WITHDRAWN AFTER REVIEW -- read before reusing either test.

TEST 1's certificate is invalid.  Phi(v) = Pi_K pi Q(v) is QUADRATIC in v, so
evaluating it on a basis of the transverse kernel proves nothing about the rest
of the space.  At S^3 x S^3 its zero set is a 5-dimensional cone inside the
9-dimensional transverse kernel (found from 400/400 random starts), and an
explicit unit combination of the very basis vectors used below returns 1.4e-15.
A global argument on P(T) is required.  The formula itself is correct.

TEST 2's distance measure is wrong.  The orbit is 9- (11-) dimensional and the
corrector is ungauged, so ||W' - W_0|| grows by sliding ALONG the orbit.  Gauge-
fixed as min_g ||g W' g^T - W_0||, every point below is within 3.8e-3 of the
orbit.  The spectrum is contaminated the same way -- spectral differences track
orbit distance at ~0.58 (Weyl, saturated).  Any continuation test here must
measure min_g ||g W' g^T - W_0||.
"""
import numpy as np
from scipy.optimize import least_squares

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl


def slack(L2, W, c, alt):
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rm = ricci_from_mop(L2, Wm)
    return th, float(np.sum(rm * rm)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))


def setup(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    return c, L2, alt, Eflat, D


def kernel_and_orbit(W, n, c, Eflat, D):
    Nl = W.shape[0]
    th = float(np.sum(W * Q_full(W, c)))
    M = np.zeros((D, D))
    for b in range(D):
        Hb = Eflat[b].reshape(Nl, Nl)
        M[:, b] = Eflat @ ((Q_full(W + Hb, c) - Q_full(W - Hb, c)) / 4.0).reshape(-1)
    M = 0.5 * (M + M.T)
    w = Eflat @ W.reshape(-1)
    B = np.linalg.svd(np.outer(w, w))[0][:, 1:]
    H = B.T @ (6 * M - 3 * th * np.eye(D)) @ B
    ev, V = np.linalg.eigh(H)
    ker = V[:, np.abs(ev) < 1e-7]
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: t for t, p in enumerate(pairs)}
    vecs = []
    for a in range(n):
        for b2 in range(a + 1, n):
            A = np.zeros((n, n)); A[a, b2] = 1.0; A[b2, a] = -1.0
            rho = np.zeros((len(pairs), len(pairs)))
            for (i, j), col in pidx.items():
                for m2 in range(n):
                    if A[i, m2] != 0.0 and m2 != j:
                        p = (min(m2, j), max(m2, j))
                        rho[pidx[p], col] += A[i, m2] * (1 if m2 < j else -1)
                    if A[j, m2] != 0.0 and i != m2:
                        p = (min(i, m2), max(i, m2))
                        rho[pidx[p], col] += A[j, m2] * (1 if i < m2 else -1)
            vecs.append(Eflat @ (rho @ W - W @ rho).reshape(-1))
    sv = np.linalg.svd(np.array(vecs) @ B, full_matrices=False)
    rk = int(np.sum(sv[1] > 1e-8 * max(sv[1][0], 1e-300)))
    Ob = sv[2][:rk].T
    Ok = ker.T @ Ob
    if Ok.size:
        s_ = np.linalg.svd(Ok, compute_uv=False)
        comp = np.linalg.svd(Ok)[0][:, int(np.sum(s_ > 1e-6)):]
    else:
        comp = np.eye(ker.shape[1])
    return th, B, ker, ker @ comp, rk


def analyse(name, n, W):
    c, L2, alt, Eflat, D = setup(n)
    W = W / np.linalg.norm(W)
    th0 = float(np.sum(W * Q_full(W, c)))
    if th0 < 0:
        W, th0 = -W, -th0
    Nl = W.shape[0]
    th, B, ker, T, orb = kernel_and_orbit(W, n, c, Eflat, D)
    _t, S0 = slack(L2, W, c, alt)
    print(f"{name}  n={n}  theta={th:.9f}  S={S0:+.1e}  ker={ker.shape[1]}  orbit={orb}"
          f"  transverse={T.shape[1]}")
    if T.shape[1] == 0:
        print("     no transverse kernel direction -- orbit isolated to second order\n")
        return

    # TEST 1: exact second-order obstruction, direction by direction
    Pk = ker @ ker.T
    obs = []
    for a in range(T.shape[1]):
        v = T[:, a]
        Vm = (Eflat.T @ (B @ v)).reshape(Nl, Nl)
        Vm = 0.5 * (Vm + Vm.T)
        qv = Q_full(Vm, c)                       # quadratic part at v
        y = B.T @ (Eflat @ qv.reshape(-1))
        obs.append(np.linalg.norm(Pk @ y) / max(np.linalg.norm(y), 1e-300))
    obs = np.array(obs)
    nz = int(np.sum(obs > 1e-8))
    print(f"     obstruction |Pi_ker Q(v)|/|Q(v)|: min={obs.min():.2e} max={obs.max():.2e}"
          f"   nonzero in {nz}/{len(obs)} directions"
          f"   {'-> those carry NO branch (proof)' if nz else '-> obstruction vanishes everywhere'}")

    # TEST 2: predictor-corrector along the transverse directions
    w = Eflat @ W.reshape(-1)

    def corrector(y0):
        def F(x):
            xx = x / np.linalg.norm(x)
            Wl = (Eflat.T @ xx).reshape(Nl, Nl)
            Wl = 0.5 * (Wl + Wl.T)
            Ql = Q_full(Wl, c)
            return (Ql - float(np.sum(Wl * Ql)) * Wl).reshape(-1)
        r = least_squares(F, y0, method="lm", xtol=1e-15, ftol=1e-15, max_nfev=2000)
        x = r.x / np.linalg.norm(r.x)
        Wl = (Eflat.T @ x).reshape(Nl, Nl)
        Wl = 0.5 * (Wl + Wl.T); Wl /= np.linalg.norm(Wl)
        Ql = Q_full(Wl, c); thl = float(np.sum(Wl * Ql))
        if thl < 0:
            Wl, thl = -Wl, -thl; Ql = Q_full(Wl, c)
        return Wl, thl, np.linalg.norm(Ql - thl * Wl) / max(np.linalg.norm(Ql), 1e-300)

    print(f"     predictor-corrector along transverse directions (t = 0.2):")
    kept = 0
    for a in range(min(T.shape[1], 6)):
        v = B @ T[:, a]
        Wl, thl, resl = corrector(w + 0.2 * v)
        _t2, Sl = slack(L2, Wl, c, alt)
        dist = np.linalg.norm(Wl - W)
        moved = "MOVED OFF the orbit" if dist > 0.05 else "returned to the orbit"
        ok = resl < 1e-9
        print(f"       dir {a}: resid={resl:.1e}  theta={thl:.9f} (d={thl-th0:+.2e})"
              f"  S={Sl:+.2e}  |W'-W|={dist:.3f}  {moved}"
              f"{'  *** genuine critical branch ***' if ok and dist > 0.05 else ''}")
        if ok and dist > 0.05:
            kept += 1
    print(f"     => {kept} of {min(T.shape[1],6)} directions gave a corrected critical point away from W\n",
          flush=True)


if __name__ == "__main__":
    L2_6 = Lambda2(6)
    analyse("S^3 x S^3  ", 6, weyl_sphere_product_mop(L2_6, 3, 3))
    analyse("su(3) Kahler", 6, su_m_kahler_weyl(L2_6, 3))
