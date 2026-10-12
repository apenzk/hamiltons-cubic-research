"""
P3b, local test: is the graded set locally isolated inside Crit(P)?

The crux reduces to whether {S = 0} is a union of connected components of
Crit(P).  Globally that is a separation statement; locally it is checkable.

At a graded critical point W_0 we have S(W_0) = 0 and S >= 0, so dS = 0 there
automatically -- W_0 is a minimum of S.  The question is second order.  Let

    T = ker( Hess_S2 P )   at W_0, on the unit sphere,

which contains the tangent space to Crit(P) (Crit is cut out by grad P = theta W,
so its tangent lies in the Hessian's kernel).  If Hess S is positive definite on
T modulo the directions along which S vanishes identically -- the orbit
directions and the graded family itself -- then S grows quadratically in every
direction inside Crit that leaves the graded set, so no continuous path of
critical points can reach an ungraded point with S -> 0.  That is exactly the
local form of "the graded set is a union of components".

A ZERO eigenvalue of Hess S on T that is NOT an orbit direction would be the
opposite: a candidate direction along which gradedness degenerates smoothly, and
the first evidence against the reformulation.

Caveat recorded rather than hidden: S involves the negative part W_-, which is
smooth only while no eigenvalue of W crosses zero.  Each base point is screened
for a spectral gap at 0 before its Hessian is taken.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import weyl_sphere_product_mop


def slack(L2, W, c, alt):
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rm = ricci_from_mop(L2, Wm)
    return (float(np.sum(rm * rm)) + 6 * d2
            - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm)))


def orbit_span(u, n, Eflat):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: k for k, p in enumerate(pairs)}
    vecs = []
    for a in range(n):
        for b in range(a + 1, n):
            A = np.zeros((n, n)); A[a, b] = 1.0; A[b, a] = -1.0
            rho = np.zeros((len(pairs), len(pairs)))
            for (i, j), col in pidx.items():
                for k in range(n):
                    if A[i, k] != 0.0 and k != j:
                        p = (min(k, j), max(k, j))
                        rho[pidx[p], col] += A[i, k] * (1 if k < j else -1)
                    if A[j, k] != 0.0 and i != k:
                        p = (min(i, k), max(i, k))
                        rho[pidx[p], col] += A[j, k] * (1 if i < k else -1)
            vecs.append(Eflat @ (rho @ u - u @ rho).reshape(-1))
    return np.array(vecs)


def analyse(n, W0, label, h=1e-4):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    Nl = W0.shape[0]
    W0 = W0 / np.linalg.norm(W0)
    QW = Q_full(W0, c)
    th = float(np.sum(W0 * QW))
    if th < 0:
        W0, th = -W0, -th
        QW = Q_full(W0, c)
    res = np.linalg.norm(QW - th * W0) / np.linalg.norm(QW)
    ev0 = np.linalg.eigvalsh(W0)
    gap = float(np.min(np.abs(ev0[np.abs(ev0) > 1e-9]))) if np.any(np.abs(ev0) > 1e-9) else 0.0
    S0 = slack(L2, W0, c, alt)
    print(f"{label}  n={n}  theta={th:.9f}  res={res:.1e}  S={S0:+.2e}  spectral gap at 0 = {gap:.4f}")
    if res > 1e-8 or abs(S0) > 1e-7:
        print("     not a graded critical point -- skipped\n")
        return

    w = Eflat @ W0.reshape(-1)
    B = np.linalg.svd(np.outer(w, w))[0][:, 1:]           # tangent to the sphere
    k = B.shape[1]

    def P_of(y):
        W = (Eflat.T @ (w + B @ y)).reshape(Nl, Nl)
        W = 0.5 * (W + W.T)
        W /= np.linalg.norm(W)
        return float(np.sum(W * Q_full(W, c))), slack(L2, W, c, alt)

    # Hessian of P on the sphere, analytically: 6 F - 3 theta on W0^perp
    M = np.zeros((D, D))
    for b in range(D):
        Hb = Eflat[b].reshape(Nl, Nl)
        Fh = (Q_full(W0 + Hb, c) - Q_full(W0 - Hb, c)) / 4.0
        M[:, b] = Eflat @ Fh.reshape(-1)
    M = 0.5 * (M + M.T)
    HP = B.T @ (6 * M - 3 * th * np.eye(D)) @ B
    evP, VP = np.linalg.eigh(HP)
    ker = VP[:, np.abs(evP) < 1e-7]
    kd = ker.shape[1]

    orb = orbit_span(W0, n, Eflat)
    orbT = np.linalg.svd(orb @ B, full_matrices=False)
    rk = int(np.sum(orbT[1] > 1e-8 * max(orbT[1][0], 1e-300)))
    Ob = orbT[2][:rk].T                                    # orbit dirs in sphere coords
    print(f"     ker(Hess P) dim = {kd},  orbit dim = {rk}")

    if kd == 0:
        print("     Hessian nondegenerate: W_0 is an isolated critical point mod the orbit\n")
        return
    # Hessian of S restricted to ker(Hess P), by central differences
    HS = np.zeros((kd, kd))
    for a in range(kd):
        for b in range(a, kd):
            va, vb = ker[:, a], ker[:, b]
            fpp = P_of(h * (va + vb))[1]; fmm = P_of(-h * (va + vb))[1]
            fpm = P_of(h * (va - vb))[1]; fmp = P_of(h * (vb - va))[1]
            HS[a, b] = HS[b, a] = (fpp + fmm - fpm - fmp) / (4 * h * h)
    # project out the orbit directions that lie inside the kernel
    Ok = ker.T @ Ob
    if Ok.size:
        u_, s_, _ = np.linalg.svd(Ok, full_matrices=False)
        keep = u_[:, s_ < 1e-6] if np.any(s_ < 1e-6) else np.zeros((kd, 0))
        comp = np.linalg.svd(Ok)[0][:, int(np.sum(s_ > 1e-6)):]
    else:
        comp = np.eye(kd)
    if comp.shape[1] == 0:
        print("     ker(Hess P) is exactly the orbit -- graded point locally isolated in Crit\n")
        return
    HSc = comp.T @ HS @ comp
    e = np.linalg.eigvalsh(HSc)
    print(f"     transverse kernel dim = {comp.shape[1]};  Hess S eigenvalues there:")
    print(f"       min={e[0]:+.6e}   max={e[-1]:+.6e}")
    verdict = ("S grows quadratically in every transverse kernel direction -- "
               "graded set LOCALLY ISOLATED in Crit"
               if e[0] > 1e-6 else
               "FLAT direction found: S degenerates to second order -- candidate path out of the graded set")
    print(f"     ==> {verdict}\n")


n = 6
print("Local separation test at graded critical points.\n")
L2_6 = Lambda2(6)
analyse(6, weyl_sphere_product_mop(L2_6, 3, 3), "S^3 x S^3 (balanced)")
L2_8 = Lambda2(8)
analyse(8, weyl_sphere_product_mop(L2_8, 4, 4), "S^4 x S^4 (balanced)")
analyse(8, weyl_sphere_product_mop(L2_8, 3, 5), "S^3 x S^5 (unbalanced)")
