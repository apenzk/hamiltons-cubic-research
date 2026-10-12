"""
P0 step (2): close the tubular neighbourhood around SO(n).W_CP2 for n >= 12.

P is a cubic form, so its expansion at the Fox point u (unit, Q(u)=th*u,
th*=sqrt(3/2)) is EXACT with three terms.  Writing W = u+h on the unit sphere,
so that <u,h> = -||h||^2/2 and t := ||h||:

    P(W) = th* - (3/2) th* t^2 + 3<F_u(h),h> + P(h),      F_u(h) = 1/2(uh+hu)+u#h.

Nienhaus Thm 4.14 gives spec(F_u); the spherical Hessian is 6F_u - 3 th*.
The neighbourhood closes by a strict second-order drop iff

    ker(6F_u - 3 th*)|_{u^perp}  ==  T_u(SO(n).u),

i.e. the ONLY flat directions are the orbit directions, along which P is
constant.  Anything larger is an extra degeneracy and must be pushed to third
order.  This script measures both sides at several n.

F_u is obtained by exact polarization, F_u(h) = (Q(u+h) - Q(u-h))/4, and
restricted to the Weyl subspace (the constraint set Nienhaus works on).
Orbit directions are d/ds|_0 exp(sA).u = [A,u] for A in so(n), projected to Weyl.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, ricci_from_mop
from run_cp2_ricci_flat import cp2_block_st_tensor
from run_unconstrained_search import build_weyl_basis

SQ32 = np.sqrt(1.5)


def fox_point(n, L2, Eflat, c):
    """Nienhaus's W_CP2 (arXiv:2311.02404, p.~33): the Weyl operator of CP^2 in
    DIMENSION 4 -- diag(0,0,0,-1,-1,2)/sqrt(6) on Lambda^2(R^4) -- zero-padded
    into Lambda^2(R^n).  Being Ricci-flat in dim 4 it is Ricci-flat in dim n, so
    the padding lands inside Weyl_n untouched and P(W_CP2) = sqrt(3/2) for every n.
    (Weyl-projecting the CP^2 curvature operator in dimension n instead gives a
    DIFFERENT critical point -- the Weyl part of the product CP^2 x R^{n-4} --
    with an n-dependent, strictly smaller potential.)"""
    L4 = Lambda2(4)
    W4 = None
    for (s, t) in ((1.0, 1.0), (1.0, 0.0), (0.0, 1.0)):
        M = mop_from_4tensor(L4, cp2_block_st_tensor(4, s, t))
        W = weyl_from_mop(L4, M)[0]
        if np.linalg.norm(W) > 1e-9:
            W4 = W / np.linalg.norm(W)
            break
    p4 = [(i, j) for i in range(4) for j in range(i + 1, 4)]
    pn = [(i, j) for i in range(n) for j in range(i + 1, n)]
    loc = {p: k for k, p in enumerate(pn)}
    u = np.zeros((len(pn), len(pn)))
    for a, pa in enumerate(p4):
        for b, pb in enumerate(p4):
            u[loc[pa], loc[pb]] = W4[a, b]
    th = float(np.sum(u * Q_full(u, c)))
    if th < 0:
        u, th = -u, -th
    QW = Q_full(u, c)
    return u, th, np.linalg.norm(QW - th * u) / np.linalg.norm(QW)


def F_matrix(u, c, Eflat):
    """Matrix of the Weyl-restricted F_u in the orthonormal Weyl basis Eflat."""
    Nl = int(round(np.sqrt(Eflat.shape[1])))
    D = Eflat.shape[0]
    M = np.zeros((D, D))
    for b in range(D):
        h = Eflat[b].reshape(Nl, Nl)
        Fh = (Q_full(u + h, c) - Q_full(u - h, c)) / 4.0
        M[:, b] = Eflat @ Fh.reshape(-1)
    return 0.5 * (M + M.T)


def orbit_dim(u, n, L2, Eflat):
    """dim of T_u(SO(n).u) inside the Weyl space.  so(n) acts on operators on
    Lambda^2 by A -> [rho(A), .]; rho(A) is the induced action on Lambda^2."""
    Nl = Eflat.shape[1]
    Nl = int(round(np.sqrt(Nl)))
    # induced so(n) action on Lambda^2: (A.omega)_{ij} = sum_k A_ik w_kj + A_jk w_ik
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: k for k, p in enumerate(pairs)}
    vecs = []
    for a in range(n):
        for b in range(a + 1, n):
            A = np.zeros((n, n)); A[a, b] = 1.0; A[b, a] = -1.0
            rho = np.zeros((len(pairs), len(pairs)))
            for (i, j), col in pidx.items():
                for k in range(n):
                    if A[i, k] != 0.0:
                        p = (min(k, j), max(k, j))
                        if k != j:
                            rho[pidx[p], col] += A[i, k] * (1 if k < j else -1)
                    if A[j, k] != 0.0:
                        p = (min(i, k), max(i, k))
                        if i != k:
                            rho[pidx[p], col] += A[j, k] * (1 if i < k else -1)
            dW = rho @ u - u @ rho
            v = Eflat @ dW.reshape(-1)          # project onto Weyl basis
            vecs.append(v)
    Vt = np.array(vecs)
    sv = np.linalg.svd(Vt, compute_uv=False)
    return int(np.sum(sv > 1e-8 * max(sv[0], 1e-300))), Vt


def run(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, res = fox_point(n, L2, Eflat, c)
    ric = np.max(np.abs(ricci_from_mop(L2, u)))
    print(f"n={n:3d}  dim Weyl={D:5d}  theta={th:.9f} (sqrt(3/2)={SQ32:.9f})"
          f"  crit-res={res:.1e}  |Ric|={ric:.1e}")

    M = F_matrix(u, c, Eflat)
    ev = np.linalg.eigvalsh(M)
    # eigenvalues in units of sqrt(3/2)
    units = ev / SQ32
    print("     spec(F_u)/sqrt(3/2), grouped:")
    lo = 0
    while lo < len(units):
        hi = lo
        while hi + 1 < len(units) and abs(units[hi + 1] - units[lo]) < 1e-7:
            hi += 1
        print(f"       {units[lo]:+.6f}   mult {hi-lo+1:5d}"
              f"   {'  <-- Hessian kernel (=1/2)' if abs(units[lo]-0.5)<1e-7 else ''}")
        lo = hi + 1

    # spherical Hessian on u^perp: 6 F_u - 3 th*
    w = Eflat @ u.reshape(-1)
    Bc = np.linalg.svd(np.outer(w, w))[0][:, 1:]
    H = Bc.T @ (6 * M - 3 * th * np.eye(D)) @ Bc
    hev = np.linalg.eigvalsh(H)
    kerdim = int(np.sum(np.abs(hev) < 1e-7))
    print(f"     Hessian on u^perp: max={hev[-1]:+.3e}  ker dim={kerdim}"
          f"  next-largest={hev[len(hev)-kerdim-1]:+.6f}")

    od, _ = orbit_dim(u, n, L2, Eflat)
    stab = n * (n - 1) // 2 - od
    print(f"     orbit T_u(SO(n).u) dim={od}   (dim so(n)={n*(n-1)//2}, stab={stab})")
    verdict = "EXACT, closes at 2nd order" if kerdim == od else f"EXTRA {kerdim-od} flat direction(s)"
    print(f"     ==> ker vs orbit: {kerdim} vs {od}   {verdict}\n")
    return n, kerdim, od, hev, th


if __name__ == "__main__":
    for n in (10, 12, 14):
        run(n)
