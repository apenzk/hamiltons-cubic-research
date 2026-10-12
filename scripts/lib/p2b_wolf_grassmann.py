"""
P2b, part 2: the Wolf spaces and the complex Grassmannians.

Petersen-Stanfield (arXiv:2508.11236) Thm A singles out the complex
Grassmannians as the only symmetric spaces whose curvature operator carries
THREE distinct nonzero eigenvalues, and their Prop 2.2 pins the eigenspaces to
the simple factors of the isotropy algebra.  Both classes below have reducible
isotropy, so the two-eigenvalue ansatz of the graded enumeration cannot
represent their critical points:

  * Wolf:              k = sp(1) + sp(m)        inside so(4m)
  * complex Grassmann: k = u(1) + su(a) + su(b) inside so(2ab)   [a+b=m]

Each gives an (r+1)-parameter family; criticality Q(W) = theta W is solved on it
subject to Ricci-flatness and unit norm.  Any solution with unequal isotropy
block values is a graded critical point the enumeration structurally could not
have found.

Projectors are built as commutants and then TRACE-CHECKED against the known
dimensions before use -- a rank-deficient generator set silently yields the
identity under QR, which is what produced a false "no critical point" earlier.
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


def so_basis(n):
    B = []
    for a in range(n):
        for b in range(a + 1, n):
            E = np.zeros((n, n)); E[a, b] = 1.0; E[b, a] = -1.0
            B.append(E)
    return B


def proj_from_basis(n, gens):
    """Orthogonal projection of Lambda^2(R^n) onto span{gens}.  SVD, not QR."""
    P = [(i, j) for i in range(n) for j in range(i + 1, n)]
    if not gens:
        return np.zeros((len(P), len(P)))
    V = np.array([[A[i, j] * np.sqrt(2.0) for (i, j) in P] for A in gens]).T
    U, sv, _ = np.linalg.svd(V, full_matrices=False)
    r = int(np.sum(sv > 1e-9 * max(sv[0], 1e-300)))
    Qm = U[:, :r]
    return Qm @ Qm.T


def commutant(n, ops):
    """Basis of { E in so(n) : [E, X] = 0 for all X in ops }."""
    B = so_basis(n)
    M = np.array([np.concatenate([(X @ E - E @ X).reshape(-1) for X in ops]) for E in B]).T
    sv = np.linalg.svd(M, compute_uv=False)
    r = int(np.sum(sv > 1e-9 * max(sv[0], 1e-300)))
    null = np.linalg.svd(M)[2][r:]
    return [sum(cc * E for cc, E in zip(v, B)) for v in null]


def quat_mults(m, side):
    n = 4 * m
    out = []
    for q in 'ijk':
        M = np.zeros((n, n))
        tab = {'i': [(1, 0, 1), (0, 1, -1), (3, 2, 1), (2, 3, -1)],
               'j': [(2, 0, 1), (0, 2, -1), (1, 3, 1), (3, 1, -1)],
               'k': [(3, 0, 1), (0, 3, -1), (2, 1, 1), (1, 2, -1)]}[q]
        for a in range(m):
            for (r_, c_, s) in tab:
                if side == 'L':
                    M[4 * a + r_, 4 * a + c_] = s
                else:
                    M[4 * a + c_, 4 * a + r_] = s
        out.append(0.5 * (M - M.T))
    return out


def wolf_blocks(m):
    """k = sp(1) + sp(m) in so(4m).  sp(m) = commutant of the LEFT mults,
    sp(1) = span of the LEFT mults themselves."""
    n = 4 * m
    Ls = quat_mults(m, 'L')
    Psp1 = proj_from_basis(n, Ls)
    Pspm = proj_from_basis(n, commutant(n, Ls))
    return n, [Psp1, Pspm], [3, m * (2 * m + 1)]


def grassmann_blocks(a, b):
    """k = u(1) + su(a) + su(b) in so(2ab), from U(a) x U(b) acting on C^a (x) C^b."""
    m = a * b
    n = 2 * m
    J = np.zeros((n, n))
    for t in range(m):
        J[2 * t, 2 * t + 1] = 1.0
        J[2 * t + 1, 2 * t] = -1.0

    def embed(H, which):
        """H a real 2x2-block-complex matrix on C^a (or C^b); embed acting on
        C^a (x) C^b = C^m, then realify."""
        Z = np.zeros((m, m), dtype=complex)
        for i in range(a):
            for j in range(a) if which == 'a' else range(a):
                pass
        return Z

    # build complex generators of u(a) and u(b) acting on C^a (x) C^b directly
    def cmat_to_real(Z):
        R = np.zeros((n, n))
        for p in range(m):
            for q in range(m):
                x, y = Z[p, q].real, Z[p, q].imag
                R[2 * p, 2 * q] = x;     R[2 * p, 2 * q + 1] = -y
                R[2 * p + 1, 2 * q] = y; R[2 * p + 1, 2 * q + 1] = x
        return 0.5 * (R - R.T)

    def idx(i, j):
        return i * b + j

    gens_a, gens_b = [], []
    for i in range(a):
        for k in range(a):
            for (co, lab) in ((1.0, 'H'), (1j, 'A')):
                Z = np.zeros((m, m), dtype=complex)
                for j in range(b):
                    Z[idx(i, j), idx(k, j)] += co
                    Z[idx(k, j), idx(i, j)] -= np.conj(co)
                if np.linalg.norm(Z) > 1e-12:
                    gens_a.append(cmat_to_real(Z))
    for i in range(b):
        for k in range(b):
            for (co, lab) in ((1.0, 'H'), (1j, 'A')):
                Z = np.zeros((m, m), dtype=complex)
                for j in range(a):
                    Z[idx(j, i), idx(j, k)] += co
                    Z[idx(j, k), idx(j, i)] -= np.conj(co)
                if np.linalg.norm(Z) > 1e-12:
                    gens_b.append(cmat_to_real(Z))
    Pu1 = proj_from_basis(n, [J])
    Pa = proj_from_basis(n, gens_a)
    Pb = proj_from_basis(n, gens_b)
    # split off the shared centre
    Pa_s = Pa - Pu1 if np.linalg.norm(Pa @ Pu1 - Pu1) < 1e-8 else Pa
    Pb_s = Pb - Pu1 if np.linalg.norm(Pb @ Pu1 - Pu1) < 1e-8 else Pb
    return n, [Pu1, Pa_s, Pb_s], [1, a * a - 1, b * b - 1]


def solve(n, blocks, c, L2, label, want, seeds=60):
    tr = [float(np.trace(B)) for B in blocks]
    ok = all(abs(t - w) < 1e-6 for t, w in zip(tr, want))
    print(f"   {label}  n={n}  theta_0={theta0(n):.6f}")
    print(f"      projector traces {['%.1f' % t for t in tr]} vs expected {want}"
          f"   {'OK' if ok else '*** MISMATCH -- results unreliable ***'}")
    if not ok:
        return []
    Pm = np.eye(blocks[0].shape[0]) - sum(blocks)
    basis = blocks + [Pm]
    r = len(basis)

    def build(x):
        return sum(xi * B for xi, B in zip(x, basis))

    def resid(x):
        W = build(x); nr = np.linalg.norm(W)
        if nr < 1e-12:
            return [1e3] * r
        Wn = W / nr
        QW = Q_full(Wn, c); th = float(np.sum(Wn * QW))
        g = QW - th * Wn
        o = [float(np.sum(B * g)) / max(np.linalg.norm(B), 1e-30) for B in basis]
        return [o[i] - o[-1] for i in range(r - 1)] + [float(np.max(np.abs(ricci_from_mop(L2, Wn))))]

    found, rng = [], np.random.default_rng(7)
    for _ in range(seeds):
        x, _i, ier, _msg = fsolve(resid, rng.normal(size=r), full_output=True)
        if ier != 1:
            continue
        W = build(x)
        if np.linalg.norm(W) < 1e-8:
            continue
        Wn = W / np.linalg.norm(W)
        if np.max(np.abs(ricci_from_mop(L2, Wn))) > 1e-8:
            continue
        QW = Q_full(Wn, c); th = float(np.sum(Wn * QW))
        if th < 0:
            Wn, th = -Wn, -th; QW = Q_full(Wn, c)
        if np.linalg.norm(QW - th * Wn) / max(np.linalg.norm(QW), 1e-30) > 1e-8:
            continue
        v = tuple(round(float(np.sum(Wn * B) / max(np.trace(B), 1e-30)), 9) for B in basis)
        if not any(abs(th - t) < 1e-7 and np.allclose(v, vv, atol=1e-7) for t, vv in found):
            found.append((th, v))
    found.sort(key=lambda t: -t[0])
    if not found:
        print("      no critical point in the family")
    for th, v in found:
        iso = v[:-1]
        off = "OFF-SLICE" if max(iso) - min(iso) > 1e-8 else "on the two-eigenvalue slice"
        flag = "  *** ABOVE sqrt(3/2) ***" if th > SQ32 + 1e-9 else ""
        print(f"      theta={th:.9f}  blocks={tuple('%+.5f' % x for x in v)}  {off}{flag}")
    return found


print("Wolf spaces:  k = sp(1) + sp(m)  inside so(4m)")
for m in (2, 3):
    n = 4 * m
    idx, pos, N, c = build_structure_constants(n)
    solve(n, *(lambda t: (t[1], c, Lambda2(n), f"HP^{m} type, sp(1)+sp({m})", t[2]))(wolf_blocks(m)))

print("\nComplex Grassmannians:  k = u(1) + su(a) + su(b)  inside so(2ab)")
for (a, b) in ((2, 2), (2, 3)):
    n = 2 * a * b
    idx, pos, N, c = build_structure_constants(n)
    solve(n, *(lambda t: (t[1], c, Lambda2(n), f"Gr_C({a},{b})", t[2]))(grassmann_blocks(a, b)))
