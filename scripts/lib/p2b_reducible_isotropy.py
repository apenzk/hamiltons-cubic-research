"""
P2b: re-run the graded enumeration on the FULL (r+1)-parameter family, for the
symmetric pairs whose isotropy is reducible.

P2 established that the enumeration's ansatz W = (q Pi_k - p Pi_m)/sqrt(pq(p+q))
is scalar on the whole isotropy algebra, i.e. the case k simple, and that the
unbalanced sphere products -- genuine THREE-eigenvalue critical points -- live
outside it, some above sqrt(3/2).  Petersen-Stanfield (arXiv:2508.11236, Prop
2.2) say exactly which pairs are affected: h = h_0 + sum_i h_i decomposes into
centre plus simple factors, and THAT is the eigenspace decomposition, with the
centre carrying the Einstein constant.

So the pairs still unsearched are those with reducible isotropy:
  * Hermitian, k = u(m) = R (centre) + su(m) inside so(2m)  -- 3 blocks + m
  * Wolf,      k = sp(1) + sp(m)          inside so(4m)     -- 3 blocks + m
Both give a 3-parameter family (two isotropy blocks plus m), which is exactly
the shape p2_multifactor_graded.py solved for so(k)+so(l).

For each, this solves Q(W) = theta W on the full family, subject to Ricci-flat
and unit norm, and reports whether any solution has a_1 != a_2 -- a graded
critical point the enumeration could not have found.
"""
import numpy as np
from scipy.optimize import fsolve

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop

SQ32 = np.sqrt(1.5)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def proj_from_basis(n, gens):
    """Orthogonal projection of Lambda^2(R^n) onto span{gens}, gens antisymmetric."""
    P = pairs_of(n)
    V = []
    for A in gens:
        V.append(np.array([A[i, j] * np.sqrt(2.0) for (i, j) in P]))
    V = np.array(V).T
    if V.shape[1] == 0:
        return np.zeros((len(P), len(P)))
    # SVD, not QR: QR returns a full orthonormal basis even when V is
    # rank-deficient, which silently yields the identity instead of a projector.
    U, sv, _ = np.linalg.svd(V, full_matrices=False)
    r = int(np.sum(sv > 1e-9 * max(sv[0], 1e-300)))
    Qm = U[:, :r]
    return Qm @ Qm.T


def u_m_blocks(m):
    """k = u(m) inside so(2m): centre (J) and su(m).  Complex structure J on R^{2m}
    with J e_{2a} = e_{2a+1}."""
    n = 2 * m
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a, 2 * a + 1] = 1.0
        J[2 * a + 1, 2 * a] = -1.0
    # u(m) = { A in so(2m) : AJ = JA };  su(m) = traceless part (perp to J)
    gens = []
    for a in range(n):
        for b in range(a + 1, n):
            E = np.zeros((n, n)); E[a, b] = 1.0; E[b, a] = -1.0
            C = 0.5 * (E + J @ E @ J.T)          # project onto the J-commuting part
            C = 0.5 * (C - C.T)
            if np.linalg.norm(C) > 1e-10:
                gens.append(C)
    Pu = proj_from_basis(n, gens)
    Pc = proj_from_basis(n, [J])                  # the 1-dim centre
    return n, [Pc, Pu - Pc]                       # [centre, su(m)]


def sp_blocks(m):
    """k = sp(1) + sp(m) inside so(4m), via RIGHT and LEFT quaternion multiplications."""
    n = 4 * m
    def quat_mult(side, q):
        M = np.zeros((n, n))
        B = {'i': [(1, 0, 1), (0, 1, -1), (3, 2, 1), (2, 3, -1)],
             'j': [(2, 0, 1), (0, 2, -1), (1, 3, 1), (3, 1, -1)],
             'k': [(3, 0, 1), (0, 3, -1), (2, 1, 1), (1, 2, -1)]}[q]
        for a in range(m):
            for (r, c, s) in B:
                if side == 'L':
                    M[4 * a + r, 4 * a + c] = s
                else:
                    M[4 * a + c, 4 * a + r] = s
        return 0.5 * (M - M.T)
    Ls = [quat_mult('L', q) for q in 'ijk']
    Rs = [quat_mult('R', q) for q in 'ijk']
    # sp(m) = centraliser of the RIGHT multiplications; sp(1) = the LEFT ones
    gens = []
    for a in range(n):
        for b in range(a + 1, n):
            E = np.zeros((n, n)); E[a, b] = 1.0; E[b, a] = -1.0
            C = E.copy()
            for R in Rs:
                C = C - 0.25 * (R @ E @ R.T * 0 + (R @ E - E @ R) @ np.zeros((n, n)))
            gens.append(E)
    # build sp(m) as the commutant of Rs inside so(n), numerically
    P = pairs_of(n)
    rows = []
    for R in Rs:
        for (i, j) in P:
            pass
    basis = []
    for a in range(n):
        for b in range(a + 1, n):
            E = np.zeros((n, n)); E[a, b] = 1.0; E[b, a] = -1.0
            basis.append(E)
    M = []
    for E in basis:
        col = []
        for R in Rs:
            col.append((R @ E - E @ R).reshape(-1))
        M.append(np.concatenate(col))
    M = np.array(M).T
    ns = np.linalg.svd(M)[2]
    rank = int(np.sum(np.linalg.svd(M, compute_uv=False) > 1e-9))
    null = ns[rank:]
    spm = [sum(c * B for c, B in zip(v, basis)) for v in null]
    Psp = proj_from_basis(n, spm)
    Psp1 = proj_from_basis(n, Ls)
    return n, [Psp1, Psp - Psp1 if np.linalg.norm(Psp @ Psp1 - Psp1) < 1e-8 else Psp]


def solve(n, blocks, c, L2, label, seeds=40):
    Pm = np.eye(blocks[0].shape[0]) - sum(blocks)
    basis = blocks + [Pm]
    r = len(basis)

    def build(x):
        return sum(xi * B for xi, B in zip(x, basis))

    def resid(x):
        W = build(x)
        nr = np.linalg.norm(W)
        if nr < 1e-12:
            return [1e3] * r
        Wn = W / nr
        QW = Q_full(Wn, c)
        th = float(np.sum(Wn * QW))
        g = QW - th * Wn
        out = [float(np.sum(B * g)) / max(np.linalg.norm(B), 1e-30) for B in basis]
        ric = ricci_from_mop(L2, Wn)
        return [out[i] - out[-1] for i in range(r - 1)] + [float(np.max(np.abs(ric)))]

    found = []
    rng = np.random.default_rng(1)
    for s in range(seeds):
        x, info, ier, _ = fsolve(resid, rng.normal(size=r), full_output=True)
        if ier != 1:
            continue
        W = build(x)
        if np.linalg.norm(W) < 1e-8:
            continue
        Wn = W / np.linalg.norm(W)
        if np.max(np.abs(ricci_from_mop(L2, Wn))) > 1e-8:
            continue
        QW = Q_full(Wn, c)
        th = float(np.sum(Wn * QW))
        if th < 0:
            Wn, th = -Wn, -th
            QW = Q_full(Wn, c)
        if np.linalg.norm(QW - th * Wn) / max(np.linalg.norm(QW), 1e-30) > 1e-8:
            continue
        vals = tuple(round(float(np.sum(Wn * B) / max(np.trace(B), 1e-30)), 9) for B in basis)
        if not any(abs(th - t) < 1e-7 and np.allclose(vals, v, atol=1e-7) for t, v in found):
            found.append((th, vals))
    found.sort(key=lambda t: -t[0])
    print(f"   {label}  n={n}  theta_0={theta0(n):.6f}")
    if not found:
        print("      no critical point in the family")
    for th, v in found:
        off = "OFF-SLICE (a1 != a2)" if abs(v[0] - v[1]) > 1e-8 else "on the two-eigenvalue slice"
        flag = "  *** ABOVE sqrt(3/2) ***" if th > SQ32 + 1e-9 else ""
        print(f"      theta={th:.9f}  blocks={tuple(f'{x:+.5f}' for x in v)}  {off}{flag}")
    return found


print("Hermitian pairs: k = u(m) = centre + su(m)  inside so(2m)")
for m in (4, 5, 6, 7):
    n = 2 * m
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    nn, blocks = u_m_blocks(m)
    solve(n, blocks, c, L2, f"SO({n})/U({m})")
