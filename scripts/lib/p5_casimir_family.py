"""
P5: the two-eigenvalue (Casimir) family, where gradedness varies with no block
count in sight -- and where Conjecture A is provable outright.

THE FAMILY.  Let h be a subalgebra of so(n) = Lambda^2 R^n, m = h^perp, and let
K be the (possibly disconnected) subgroup with Lie algebra h.  Suppose

    (F1)  h and m are both K-irreducible,
    (F2)  (Sym^2 R^n)^K = R.Id      (so Ric of any K-invariant operator is scalar),
    (F3)  (Lambda^4 R^n)^K = 0      (so every K-invariant operator is Bianchi-free).

Then  W_h = c ( Pi_h - (r/N) Id ),  r = dim h,  N = n(n-1)/2,  c = sqrt(N/(r(N-r))),
is a unit Weyl operator, and it is a critical point of P.

THE CLAIM PROVED IN THE DOCSTRING BELOW AND CHECKED HERE.  Write

    S_hhh = sum_{a,b,c in h} <[phi_a,phi_b],phi_c>^2,  and likewise S_hmm, S_mmm,

over an orthonormal basis.  Then, at any such critical point,

    (i)   theta = (2/n) sqrt( r N / (N - r) ),          increasing in r alone;
    (ii)  S_mmm = (N - r) [ 2(n-2) - 4(n-1) r / N ];
    (iii) S_mmm >= 0  forces  r <= n(n-2)/4,  hence  theta <= theta_0(n);
    (iv)  equality in either place holds iff S_mmm = 0, i.e. iff [m,m] subset h,
          i.e. iff W_h is Z_2-graded, i.e. iff (so(n), h) is a symmetric pair.

The proof is three identities and one non-negativity:

    (1)  sum_{b,c} c_{abc}^2 = kappa = 2(n-2) for every a          (Killing form of so(n))
    (2)  S_hhh + S_hmm = kappa r                                   ([h,h] subset h)
    (3)  2 S_hmm + S_mmm = kappa (N-r)                             (same, by symmetry of c^2)

Criticality reads, with u = c(1-r/N) > 0 on h and v = -c r/N < 0 on m,

        u^2 + (1/2r)( S_hhh u^2 + S_hmm v^2 )       = theta u,
        v^2 + (1/2(N-r))( 2 S_hmm u v + S_mmm v^2 ) = theta v.

Eliminating S_hhh and S_mmm through (2) and (3) leaves two equations in
(S_hmm, theta); solving gives (i) and S_hmm = 2 sigma r (N-r)/N with
sigma = 1 + kappa/2 = n-1, whence (ii).  Since S_mmm is a sum of squares it is
non-negative, which is (iii); and S_mmm = 0 says exactly that [m,m] is
orthogonal to m, the definition of gradedness for an operator whose negative
eigenspace is m.  At r = n(n-2)/4 the value (i) is exactly
theta_0(n) = sqrt(2(n-1)(n-2))/n, and the only symmetric pair of so(n) of that
dimension is so(n/2) + so(n/2), i.e. the balanced sphere product.

WHY THIS MATTERS FOR P5.  On the multi-block sphere products gradedness is
perfectly confounded with the block count k, so the evidence there cannot
separate "ungraded => low theta" from "many blocks => low theta".  This family
has no block count: its members are indexed by a subalgebra, gradedness is the
symmetric-pair condition on that subalgebra, and theta is a function of dim h
alone.  The separation is proved, sharp, and attained exactly at the conjectured
maximizer.

WHAT IS CHECKED HERE.  For each member: unit norm, Ricci-flatness, the Bianchi
projection Alt(W), the criticality residual ||Q(W) - theta W||, theta against
(i), S_mmm measured from the structure constants against (ii), the graded-
compression slack S, and r against the cap n(n-2)/4.  Two controls are included
that must FAIL a hypothesis and do: G_2 in so(7), where (F3) fails and with it
criticality -- its r = 14 would otherwise break the cap -- and u(m) in so(2m),
where h is K-reducible so the two-eigenvalue operator is not the critical point.
"""
import itertools

import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import alt_mop, delta2_and_grad


# ----------------------------------------------------------------- utilities

def pair_list(n):
    return list(itertools.combinations(range(n), 2))


def mat_to_vec(A, prs):
    """Antisymmetric n x n matrix -> coordinates in the orthonormal basis
    phi_{ij} = E_ij - E_ji (norm 1 under <X,Y> = (1/2) tr(X^T Y))."""
    return np.array([A[i, j] for (i, j) in prs])


def projector(gens, n):
    """Orthogonal projector onto span of the given so(n) generators, in the
    pair basis, with the numerical rank returned."""
    prs = pair_list(n)
    M = np.array([mat_to_vec(A, prs) for A in gens]).T
    U, s, _ = np.linalg.svd(M, full_matrices=False)
    r = int(np.sum(s > 1e-9 * max(s[0], 1e-30)))
    return U[:, :r] @ U[:, :r].T, r


def casimir_operator(Pi, r, N):
    """W_h = (Pi_h - (r/N) Id) normalized to unit Frobenius norm."""
    W = Pi - (r / N) * np.eye(N)
    return W / np.linalg.norm(W)


# ------------------------------------------------------- subalgebra builders

def so_basis(n):
    """phi_{ij} = E_ij - E_ji for i<j."""
    out = {}
    for (i, j) in pair_list(n):
        A = np.zeros((n, n))
        A[i, j] = 1.0
        A[j, i] = -1.0
        out[(i, j)] = A
    return out


def h_so_p_so_q(n, p):
    """so(p) + so(q) in so(n), p + q = n."""
    B = so_basis(n)
    return [B[(i, j)] for (i, j) in pair_list(n)
            if (i < p and j < p) or (i >= p and j >= p)]


def h_u_m(n):
    """u(m) in so(2m): the matrices commuting with the standard J."""
    m = n // 2
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a, 2 * a + 1] = 1.0
        J[2 * a + 1, 2 * a] = -1.0
    B = so_basis(n)
    gens = []
    for (i, j) in pair_list(n):
        A = B[(i, j)]
        gens.append(A @ J - J @ A)          # image of ad_J; kernel is u(m)
    # kernel of ad_J, obtained as the orthogonal complement of the image
    prs = pair_list(n)
    M = np.array([mat_to_vec(g, prs) for g in gens]).T
    U, s, _ = np.linalg.svd(M, full_matrices=False)
    rk = int(np.sum(s > 1e-9 * s[0]))
    Pi_img = U[:, :rk] @ U[:, :rk].T
    Pi_ker = np.eye(len(prs)) - Pi_img
    # turn the kernel projector back into generators
    w, V = np.linalg.eigh(Pi_ker)
    cols = V[:, w > 0.5]
    out = []
    for k in range(cols.shape[1]):
        A = np.zeros((n, n))
        for a, (i, j) in enumerate(prs):
            A[i, j] += cols[a, k]
            A[j, i] -= cols[a, k]
        out.append(A)
    return out


def adjoint_rep_generators(struct):
    """Given structure constants f[a,b,c] of a compact simple algebra in an
    orthonormal basis, return ad_a as antisymmetric matrices: (ad_a)_{bc} =
    f[a,b,c] with the sign convention [x_a, x_b] = sum_c f[a,b,c] x_c."""
    d = struct.shape[0]
    return [struct[a] for a in range(d)]


def su3_structure_constants():
    """f_abc for su(3) in the Gell-Mann basis, normalized so that the
    generators are orthonormal under -1/2 tr(XY) with X = i lambda_a / sqrt2."""
    f = np.zeros((8, 8, 8))

    def setf(a, b, c, v):
        for perm, sgn in [((a, b, c), 1), ((b, c, a), 1), ((c, a, b), 1),
                          ((b, a, c), -1), ((a, c, b), -1), ((c, b, a), -1)]:
            f[perm[0] - 1, perm[1] - 1, perm[2] - 1] = sgn * v

    setf(1, 2, 3, 1.0)
    setf(1, 4, 7, 0.5)
    setf(1, 5, 6, -0.5)
    setf(2, 4, 6, 0.5)
    setf(2, 5, 7, 0.5)
    setf(3, 4, 5, 0.5)
    setf(3, 6, 7, -0.5)
    setf(4, 5, 8, np.sqrt(3) / 2)
    setf(6, 7, 8, np.sqrt(3) / 2)
    return f


def so_k_structure_constants(k):
    """f_abc for so(k) in the orthonormal basis phi_{ij}, as an
    (d x d x d) array with d = k(k-1)/2."""
    idx, pos, N, c = build_structure_constants(k)
    return c


def h_adjoint(struct, scale=True):
    """The image of the adjoint representation: a subalgebra of so(d), d = dim.
    Generators are the matrices (ad_a), normalized to the phi-basis scale."""
    d = struct.shape[0]
    gens = []
    for a in range(d):
        A = struct[a].copy()
        A = 0.5 * (A - A.T)
        gens.append(A)
    if scale:
        gens = [g / np.linalg.norm(g) * np.sqrt(2.0) for g in gens]
    return gens


def h_so3_in_so5():
    """so(3) acting irreducibly on the 5-dimensional space of harmonic
    quadratics, built as the derivative of the SO(3) action on traceless
    symmetric 3x3 matrices."""
    basis = []
    E = np.zeros((3, 3))
    ms = [np.diag([1.0, -1.0, 0.0]) / np.sqrt(2),
          np.diag([1.0, 1.0, -2.0]) / np.sqrt(6)]
    for (i, j) in [(0, 1), (0, 2), (1, 2)]:
        S = np.zeros((3, 3))
        S[i, j] = S[j, i] = 1.0 / np.sqrt(2)
        ms.append(S)
    gens = []
    for (i, j) in [(0, 1), (0, 2), (1, 2)]:
        L = np.zeros((3, 3))
        L[i, j] = 1.0
        L[j, i] = -1.0
        A = np.zeros((5, 5))
        for a, Ma in enumerate(ms):
            D = L @ Ma - Ma @ L
            for b, Mb in enumerate(ms):
                A[b, a] = np.sum(D * Mb)
        gens.append(0.5 * (A - A.T))
    return gens


def h_g2_in_so7():
    """g_2 = {A in so(7) : A.phi = 0} for the standard associative 3-form."""
    triples = [(0, 1, 2), (0, 3, 4), (0, 5, 6), (1, 3, 5),
               (1, 4, 6), (2, 3, 6), (2, 4, 5)]
    signs = [1, 1, 1, 1, -1, -1, -1]
    phi = np.zeros((7, 7, 7))
    for (t, s) in zip(triples, signs):
        i, j, k = t
        for perm, sg in [((i, j, k), 1), ((j, k, i), 1), ((k, i, j), 1),
                         ((j, i, k), -1), ((i, k, j), -1), ((k, j, i), -1)]:
            phi[perm] = sg * s
    prs = pair_list(7)
    rows = []
    for (i, j) in prs:
        A = np.zeros((7, 7))
        A[i, j] = 1.0
        A[j, i] = -1.0
        D = (np.einsum('ia,ajk->ijk', A, phi)
             + np.einsum('ja,iak->ijk', A, phi)
             + np.einsum('ka,ija->ijk', A, phi))
        rows.append(D.reshape(-1))
    M = np.array(rows).T
    U, s, Vt = np.linalg.svd(M, full_matrices=True)
    ker = Vt[np.sum(s > 1e-9 * s[0]):]
    gens = []
    for v in ker:
        A = np.zeros((7, 7))
        for a, (i, j) in enumerate(prs):
            A[i, j] += v[a]
            A[j, i] -= v[a]
        gens.append(A)
    return gens


# ------------------------------------------------------------- measurements

def struct_sums(c, Pi_h, Pi_m):
    """S_hhh, S_hmm, S_mmm from the structure constants, by projecting each
    index of c_{abc} = <[phi_a,phi_b],phi_c>."""
    def proj3(P1, P2, P3):
        t = np.einsum('abg,ax->xbg', c, P1, optimize=True)
        t = np.einsum('xbg,by->xyg', t, P2, optimize=True)
        t = np.einsum('xyg,gz->xyz', t, P3, optimize=True)
        return float(np.sum(t * t))
    return proj3(Pi_h, Pi_h, Pi_h), proj3(Pi_h, Pi_m, Pi_m), proj3(Pi_m, Pi_m, Pi_m)


def slack(L2, W, c, alt_idx):
    """S = ||Ric(W-)||^2 + 6 delta^2 - theta tr(W-) - tr(W-^2); zero iff graded."""
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = delta2_and_grad(W, alt_idx)[0]
    ric = ricci_from_mop(L2, Wm)
    S = (float(np.sum(ric * ric)) + 6 * d2
         - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm)))
    return th, d2, S


def report(name, n, gens, cache):
    if n not in cache:
        idx, pos, N, c = build_structure_constants(n)
        L2 = Lambda2(n)
        alt_idx = build_alt_indices(L2)
        cache[n] = (N, c, L2, alt_idx)
    N, c, L2, alt_idx = cache[n]

    Pi, r = projector(gens, n)
    W = casimir_operator(Pi, r, N)
    Pi_m = np.eye(N) - Pi

    QW = Q_full(W, c)
    theta = float(np.sum(W * QW))
    crit = float(np.linalg.norm(QW - theta * W))
    ric = ricci_from_mop(L2, W)
    alt = float(np.linalg.norm(alt_mop(W, alt_idx)))

    theta_formula = (2.0 / n) * np.sqrt(r * N / (N - r))
    theta0 = np.sqrt(2.0 * (n - 1) * (n - 2)) / n
    cap = n * (n - 2) / 4.0

    x, y, z = struct_sums(c, Pi, Pi_m)
    z_formula = (N - r) * (2 * (n - 2) - 4 * (n - 1) * r / N)
    y_formula = 2 * (n - 1) * r * (N - r) / N
    kappa = float(np.sum(c[0] * c[0]))

    th_s, d2, S = slack(L2, W, c, alt_idx)

    print(f"{name:34s} n={n:3d}  r={r:4d}  cap={cap:7.2f}"
          f"  theta={theta:.9f}  formula={theta_formula:.9f}"
          f"  theta_0={theta0:.9f}")
    print(f"{'':34s} crit_res={crit:.2e}  |Ric|={np.linalg.norm(ric):.2e}"
          f"  |Alt(W)|={alt:.2e}  |W|={np.linalg.norm(W):.6f}  kappa={kappa:.4f}")
    print(f"{'':34s} S_hhh={x:12.4f}  S_hmm={y:12.4f} (pred {y_formula:12.4f})"
          f"  S_mmm={z:12.4f} (pred {z_formula:12.4f})")
    print(f"{'':34s} slack S={S:.6e}  delta^2={d2:.3e}"
          f"  graded={'YES' if abs(S) < 1e-8 else 'no'}"
          f"  r<=cap: {'YES' if r <= cap + 1e-9 else 'NO'}"
          f"  theta<=theta_0: {'YES' if theta <= theta0 + 1e-12 else 'NO'}")
    print()
    return dict(name=name, n=n, r=r, theta=theta, theta_formula=theta_formula,
                theta0=theta0, crit=crit, S=S, z=z, z_formula=z_formula)


def main():
    cache = {}
    rows = []

    print("=== members of the family (both blocks K-irreducible) ===\n")
    for (n, p) in [(6, 3), (8, 4), (10, 5), (12, 6), (14, 7)]:
        rows.append(report(f"so({p})+so({p}) balanced", n,
                           h_so_p_so_q(n, p), cache))

    rows.append(report("su(3) adjoint in so(8)", 8,
                       h_adjoint(su3_structure_constants()), cache))
    rows.append(report("so(5) adjoint in so(10)", 10,
                       h_adjoint(so_k_structure_constants(5)), cache))
    rows.append(report("so(3) irreducible in so(5)", 5, h_so3_in_so5(), cache))

    print("=== controls: a hypothesis fails, and criticality fails with it ===\n")
    rows.append(report("g_2 in so(7)  [(F3) fails]", 7, h_g2_in_so7(), cache))
    rows.append(report("u(4) in so(8)  [(F1) fails]", 8, h_u_m(8), cache))

    print("=== summary ===")
    print(f"{'member':34s} {'r':>4s} {'cap':>8s} {'theta':>12s} "
          f"{'theta_0':>12s} {'crit':>9s} {'slack':>12s}")
    for d in rows:
        print(f"{d['name']:34s} {d['r']:4d} {d['n']*(d['n']-2)/4:8.2f} "
              f"{d['theta']:12.9f} {d['theta0']:12.9f} {d['crit']:9.1e} "
              f"{d['S']:12.4e}")


if __name__ == "__main__":
    main()