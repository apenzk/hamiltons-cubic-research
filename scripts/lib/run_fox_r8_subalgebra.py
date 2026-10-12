"""
Fox Lemma 10.7(4b) check: the r>=8 hyperkahler subalgebra B_r.

For r=4 (run_cp2_quaternion.py), Fox's Lemma 10.7(4a) shows
S^4(alpha)+S^4(beta)+S^4(gamma) = 0, collapsing the naive 6-dimensional
span {S(alpha),S(beta),S(gamma),alpha.beta,beta.gamma,gamma.alpha} down to
a genuine 5-dimensional subalgebra B. Lemma 10.7(4b) claims this collapse
is special to r=4: for r divisible by 4 with r>=8, the SAME six tensors
(built from a hyperkahler structure alpha,beta,gamma on an r-dimensional
subspace, S^r(.) via the same Fox formula) are honestly independent,
giving a strictly LARGER, 6-dimensional subalgebra B_r. This has never
been numerically checked. This script builds it explicitly at r=8 (in
ambient n=8, i.e. r fills the whole space) and searches for idempotents.

All tensor machinery (star_product, dot_product_2forms, S^r(alpha) formula,
Q_op/Lambda2 pipeline) is reused unmodified from run_fox_S4_check.py /
run_cp2_quaternion.py / curvature_operator.py / weyl_decomposition.py --
only the value of r and the hypercomplex structure (now on 8, not 4,
dimensions) change.

Hypercomplex structure on R^8: two copies of the standard 4x4 quaternion
generators (i,j,k), placed block-diagonally on {0,1,2,3} and {4,5,6,7}.
Because the SAME 4x4 matrices are repeated on each block, the quaternion
relations I^2=J^2=K^2=-Id, IJ=K, JK=I, KI=J, and pairwise anticommutation
hold exactly on all of R^8 (this is just the flat hyperkahler structure on
R^8 = H^2, i.e. two copies of H acted on by the same unit quaternions).
"""
import numpy as np
import itertools

from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, ricci_from_mop, mop_from_4tensor, norm, frob
from run_fox_S4_check import star_product, dot_product_2forms


# ----------------------------------------------------------------------
# 1. hypercomplex structure on R^n (n=r=8): two 4x4 quaternion blocks
# ----------------------------------------------------------------------
def quaternion_generators_multiblock(n, blocks):
    """Left-multiplication-by-i,j,k endomorphism matrices on R^n, built by
    repeating the SAME standard 4x4 quaternion generators on each 4-block
    in `blocks` (a tuple of 4-tuples of distinct indices partitioning the
    r-dimensional subspace). Convention: M[b,a] = <M e_a, e_b>, matching
    cp2_tensor.py's build_J and run_cp2_quaternion.py's quaternion_generators."""
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    for (b0, b1, b2, b3) in blocks:
        I[b1, b0] = 1.0; I[b0, b1] = -1.0
        I[b3, b2] = 1.0; I[b2, b3] = -1.0
        J[b2, b0] = 1.0; J[b0, b2] = -1.0
        J[b3, b1] = -1.0; J[b1, b3] = 1.0
        K[b3, b0] = 1.0; K[b0, b3] = -1.0
        K[b2, b1] = 1.0; K[b1, b2] = -1.0
    return I, J, K


def verify_quaternion_relations(I, J, K, label=""):
    print(f"=== hypercomplex relations on R^n {label}(should all be ~0) ===")
    n = I.shape[0]
    Id = np.eye(n)
    checks = {
        "I@I+Id": I @ I + Id,
        "J@J+Id": J @ J + Id,
        "K@K+Id": K @ K + Id,
        "I@J-K": I @ J - K,
        "J@K-I": J @ K - I,
        "K@I-J": K @ I - J,
        "I@J+J@I": I @ J + J @ I,
        "J@K+K@J": J @ K + K @ J,
        "K@I+I@K": K @ I + I @ K,
    }
    worst = 0.0
    for name, M in checks.items():
        e = np.max(np.abs(M))
        worst = max(worst, e)
        print(f"  max|{name}| = {e:.3e}")
    print(f"  -> worst residual = {worst:.3e}\n")
    return worst


# ----------------------------------------------------------------------
# 2. Fox's S^r(alpha) at general r (same formula as r=4, just plug in r)
#    S^r(alpha) = 1/(r+2) * ( 3/(r-1) g?g - alpha.alpha )
# ----------------------------------------------------------------------
def build_Sr(n, r, Jendo, block):
    Jmat = Jendo.T.copy()
    g = np.zeros((n, n))
    for b in block:
        g[b, b] = 1.0
    c1 = 3.0 / (r - 1)
    pref = 1.0 / (r + 2)

    def T(i, j, k, l):
        gg = star_product(g, g, i, j, k, l)
        aa = dot_product_2forms(Jmat, Jmat, i, j, k, l)
        return pref * (c1 * gg - aa)
    return T, Jmat, g


def build_dot(n, JendoA, JendoB):
    Amat = JendoA.T.copy()
    Bmat = JendoB.T.copy()

    def T(i, j, k, l):
        return dot_product_2forms(Amat, Bmat, i, j, k, l)
    return T


# ----------------------------------------------------------------------
# 3. structure constants of the 6-dim span under Bil (polarization of Q),
#    and a fast idempotent search using them (power iteration)
# ----------------------------------------------------------------------
def bil(L2, X, Y):
    return 0.5 * (Q_op(L2, X + Y) - Q_op(L2, X) - Q_op(L2, Y))


def build_structure_tensor(L2, basis):
    """basis: list of m Mop matrices (assumed linearly independent).
    Returns Gram matrix G (m x m) and structure tensor C (m x m x m) with
    Bil(basis[i],basis[j]) ~= sum_k C[i,j,k] * basis[k], plus the max
    relative closure residual over all i<=j pairs."""
    m = len(basis)
    G = np.array([[frob(basis[i], basis[j]) for j in range(m)] for i in range(m)])
    Ginv = np.linalg.inv(G)
    C = np.zeros((m, m, m))
    worst_resid = 0.0
    for i in range(m):
        for j in range(i, m):
            Bij = bil(L2, basis[i], basis[j])
            v = np.array([frob(Bij, basis[k]) for k in range(m)])
            c = Ginv @ v
            recon = sum(c[k] * basis[k] for k in range(m))
            resid = norm(Bij - recon) / (norm(Bij) + 1e-300)
            worst_resid = max(worst_resid, resid)
            C[i, j, :] = c
            C[j, i, :] = c
    return G, C, worst_resid


def Q_reduced(C, x):
    """Q(x) in the 6-dim coordinate representation: Q(x)_k = sum_ij x_i x_j C[i,j,k]."""
    return np.einsum('i,j,ijk->k', x, x, C)


def newton_search(C, m, n_trials=3000, seed=1, extra_seeds=None):
    """Find ALL critical points of phi(x)=<x,Q(x)>/|x|^3 on the unit sphere
    in R^6 via multi-start Newton/root-finding on
        F(x) = Q(x) - (x . Q(x)) * x = 0,
    which vanishes at every critical point (any sign/type), not just the
    single attracting fixed point that power iteration converges to.
    Combines many random unit-vector starts with structured symmetry-motivated
    guesses (extra_seeds) reflecting the S_3 symmetry permuting (a,b,c) and
    the corresponding cross terms."""
    from scipy.optimize import root
    rng = np.random.default_rng(seed)

    def F(x):
        qx = Q_reduced(C, x)
        lam = float(np.dot(x, qx))
        return qx - lam * x

    starts = []
    for _ in range(n_trials):
        x = rng.normal(size=m)
        x /= np.linalg.norm(x)
        starts.append(x)
    if extra_seeds:
        for x in extra_seeds:
            x = np.array(x, dtype=float)
            n_ = np.linalg.norm(x)
            if n_ > 1e-12:
                starts.append(x / n_)

    results = []
    for x0 in starts:
        sol = root(F, x0, method='hybr', tol=1e-13)
        if not sol.success:
            continue
        x = sol.x
        nx = np.linalg.norm(x)
        if nx < 1e-8:
            continue
        x = x / nx
        qx = Q_reduced(C, x)
        lam = float(np.dot(x, qx))
        resid = np.linalg.norm(qx - lam * x)
        results.append((x, lam, resid))
    return results


def true_P_clusters(results, G, lam_tol=1e-4, resid_tol=1e-7):
    """Cluster converged (x,lam,resid) results from newton_search by the
    CORRECTLY tensor-normalized critical value, not by the raw coordinate
    eigenvalue `lam`.

    IMPORTANT SUBTLETY (found and fixed during development of this script):
    the coordinate equation Q_reduced(x) = lam*x is basis-independent and
    correct regardless of whether {basis_i} is orthonormal. But `lam` itself
    is only the true P-value of the corresponding UNIT-NORM tensor if x is
    normalized so that the ACTUAL tensor X=sum x_i basis_i has |X|=1, i.e.
    x^T G x = 1 (G = the basis's non-orthonormal Gram matrix) -- NOT if x is
    normalized to Euclidean unit norm in coordinate space (which is what the
    root-finder's internal fixed-point condition actually pins down). Using
    raw `lam` directly caused MANY spurious near-duplicate "clusters" in an
    earlier version of this script (~150, one per random-restart, since raw
    lam varies quasi-continuously along each continuous symmetry orbit),
    which was also the reason that version took >600s (one expensive full
    Q_op verification per spurious cluster). The fix: convert to the true,
    scale-invariant value once, in closed form, from (x,lam) and G alone:
        P_true = lam / |X| = lam / sqrt(x^T G x)
    This was cross-validated against explicit re-normalization + a full
    Q_op(L2, .) recomputation on cluster representatives (see main()) and
    matches to floating-point precision."""
    recs = []
    for x, lam, r in results:
        if r > resid_tol:
            continue
        nrm2 = x @ G @ x
        if nrm2 < 1e-12:
            continue
        Pt = lam / np.sqrt(nrm2)
        xu = x / np.sqrt(nrm2)  # tensor-unit-normalized coordinates
        recs.append((Pt, xu))
    recs.sort(key=lambda t: t[0])
    clusters = []  # list of [P_true, count, list of xu]
    for Pt, xu in recs:
        if clusters and abs(Pt - clusters[-1][0]) < lam_tol:
            clusters[-1][1] += 1
            clusters[-1][2].append(xu)
        else:
            clusters.append([Pt, 1, [xu]])
    clusters.sort(key=lambda c: -c[0])
    return clusters


def main():
    n = 8
    r = 8
    block = tuple(range(8))
    blocks4 = ((0, 1, 2, 3), (4, 5, 6, 7))

    L2 = Lambda2(n)
    I, J, K = quaternion_generators_multiblock(n, blocks4)
    verify_quaternion_relations(I, J, K, label="(n=r=8, two 4x4 blocks) ")

    Ta, Amat, g = build_Sr(n, r, I, block)
    Tb, Bmat, _ = build_Sr(n, r, J, block)
    Tc, Cmat, _ = build_Sr(n, r, K, block)
    Sa = mop_from_4tensor(L2, Ta)
    Sb = mop_from_4tensor(L2, Tb)
    Sc = mop_from_4tensor(L2, Tc)

    print("=== Ricci-flatness of S^8(alpha),S^8(beta),S^8(gamma) ===")
    for name, M in [("S^8(alpha)", Sa), ("S^8(beta)", Sb), ("S^8(gamma)", Sc)]:
        Ric = ricci_from_mop(L2, M)
        Weyl, _, _ = weyl_from_mop(L2, M)
        print(f"{name}: max|Ricci| = {np.max(np.abs(Ric)):.3e}, "
              f"max|Mop-Weyl(Mop)| = {np.max(np.abs(M - Weyl)):.3e}, |.|^2 = {frob(M, M):.8f}")

    fox_norm2_formula = 6.0 * r * (r - 2) / ((r + 2) * (r - 1))
    print(f"\nFox's formula |S^r(alpha)|^2 = 6r(r-2)/((r+2)(r-1)) at r={r}: {fox_norm2_formula:.8f}")
    print(f"pipeline |S^8(alpha)|^2 = {frob(Sa, Sa):.8f}  (ratio to Fox = {frob(Sa,Sa)/fox_norm2_formula:.6f})")

    print("\n=== Lemma 10.7(4b): is S^8(alpha)+S^8(beta)+S^8(gamma) = 0 (as at r=4) or NONZERO (r>=8 claim)? ===")
    Ssum = Sa + Sb + Sc
    print(f"|S(alpha)+S(beta)+S(gamma)| = {norm(Ssum):.6f}   vs |S(alpha)| = {norm(Sa):.6f}"
          f"   ratio = {norm(Ssum)/norm(Sa):.6f}")
    print("(nonzero ratio confirms Fox's claim that the r=4 collapse does NOT happen at r=8)\n")

    Tab = build_dot(n, I, J)
    Tbc = build_dot(n, J, K)
    Tca = build_dot(n, K, I)
    Mab = mop_from_4tensor(L2, Tab)
    Mbc = mop_from_4tensor(L2, Tbc)
    Mca = mop_from_4tensor(L2, Tca)

    print("=== cross terms alpha.beta etc: Ricci-flat? pairwise orthogonal? equal norm? ===")
    fox_cross_norm2 = 3.0 * r * (r + 2)
    for name, M in [("alpha.beta", Mab), ("beta.gamma", Mbc), ("gamma.alpha", Mca)]:
        Ric = ricci_from_mop(L2, M)
        print(f"{name}: max|Ricci|={np.max(np.abs(Ric)):.3e}  |.|^2={frob(M,M):.6f}  (Fox: 3r(r+2)={fox_cross_norm2})")
    print("<ab,bc>=", frob(Mab, Mbc), " <bc,ca>=", frob(Mbc, Mca), " <ca,ab>=", frob(Mca, Mab))
    print("<ab,Sa>=", frob(Mab, Sa), " <ab,Sb>=", frob(Mab, Sb), " <ab,Sc>=", frob(Mab, Sc))

    # ----------------------------------------------------------------
    # 4. linear independence: Gram matrix rank of all 6 tensors
    # ----------------------------------------------------------------
    basis = [Sa, Sb, Sc, Mab, Mbc, Mca]
    names = ["S(a)", "S(b)", "S(c)", "M(ab)", "M(bc)", "M(ca)"]
    m = len(basis)
    G = np.array([[frob(basis[i], basis[j]) for j in range(m)] for i in range(m)])
    print("\n=== Gram matrix of the 6 candidate basis tensors ===")
    with np.printoptions(precision=4, suppress=True):
        print(G)
    eigvals = np.linalg.eigvalsh(G)
    rank = np.sum(eigvals > 1e-8 * eigvals[-1])
    print(f"Gram eigenvalues: {eigvals}")
    print(f"=> rank = {rank} (expect 6 for genuine 6-dimensionality; r=4 case gave rank 5)\n")

    # ----------------------------------------------------------------
    # 5. structure constants + idempotent search
    # ----------------------------------------------------------------
    print("=== building structure tensor C[i,j,k]: Bil(basis_i,basis_j) = sum_k C[i,j,k] basis_k ===")
    Gm, C, worst_resid = build_structure_tensor(L2, basis)
    print(f"worst closure residual over all pairs = {worst_resid:.3e} (should be tiny => genuine closed subalgebra)\n")

    print("=== idempotent search: multi-start Newton root-finding for Q(x)=lam*x on all of R^6 "
          "(structured seeds + large random-restart sweep) ===")
    structured_seeds = [
        [1, 0, 0, 0, 0, 0], [-1, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0], [0, 0, 0, -1, 0, 0],
        [1, 1, 1, 0, 0, 0], [-1, -1, -1, 0, 0, 0],
        [1, -1, 0, 0, 0, 0], [1, 0, -1, 0, 0, 0],
        [0, 0, 0, 1, 1, 1], [0, 0, 0, -1, -1, -1],
        [0, 0, 0, 1, -1, 0], [0, 0, 0, 1, 1, -1],
        [1, 1, 1, 1, 1, 1], [-1, -1, -1, 1, 1, 1],
        [1, 1, 1, -1, -1, -1], [1, -1, -1, 1, -1, -1],
        [1, 0, 0, 1, 0, 0], [1, 0, 0, -1, 0, 0],
        [1, 0, 0, 0, 1, 0], [2, -1, -1, 0, 0, 0],
        [2, -1, -1, 1, 1, 1], [2, -1, -1, -1, -1, -1],
    ]
    n_trials = 20000
    results_nt = newton_search(C, m, n_trials=n_trials, seed=7, extra_seeds=structured_seeds)
    print(f"{len(results_nt)} / {n_trials + len(structured_seeds)} Newton trials converged")

    clusters = true_P_clusters(results_nt, G, lam_tol=1e-4, resid_tol=1e-7)
    print(f"{len(clusters)} distinct TRUE-P clusters found (correctly tensor-normalized, "
          f"idempotency residual < 1e-7):\n")

    sqrt32 = np.sqrt(1.5)
    sphere_n8 = np.sqrt(2.0 * (n - 1) * (n - 2) / n**2)
    Sr_alone = np.sqrt(2.0 * (r + 2) * (r - 1) / (3.0 * r * (r - 2)))

    print(f"reference values: sqrt(3/2) = {sqrt32:.6f}  (r=4 CP^2-type competitor)")
    print(f"                  balanced sphere-product at n=8 = {sphere_n8:.6f}")
    print(f"                  S^8(alpha) alone (this repo convention) = {Sr_alone:.6f}\n")

    for Pt, cnt, xus in clusters:
        x0 = xus[0]
        coeffs = "  ".join(f"{names[i]}={x0[i]:+.4f}" for i in range(m))
        beats32 = " <-- BEATS sqrt(3/2)!" if abs(Pt) > sqrt32 + 1e-9 else ""
        beatssphere = " <-- BEATS balanced sphere n=8!" if abs(Pt) > sphere_n8 + 1e-9 else ""
        print(f"P = {Pt:+.8f}   count={cnt:5d}{beats32}{beatssphere}   coords (tensor-unit-norm): {coeffs}")

    print("\n=== cross-checking each cluster representative directly in the full tensor pipeline "
          "(independent confirmation of the closed-form P_true = lam/sqrt(x^T G x) formula) ===")
    for Pt, cnt, xus in clusters:
        x0 = xus[0]
        X = sum(x0[i] * basis[i] for i in range(m))
        nX = norm(X)
        if nX < 1e-10:
            print(f"P~{Pt:.6f}: |X|~0, trivial/degenerate, skipping")
            continue
        Xu = X / nX
        QXu = Q_op(L2, Xu)
        lam_full = frob(Xu, QXu)
        resid_full = norm(QXu - lam_full * Xu) / norm(QXu)
        print(f"closed-form P={Pt:+.8f}  full-pipeline P={lam_full:+.8f}  "
              f"idempotency residual (full Q_op) = {resid_full:.3e}")

    print("\n=== done ===")


if __name__ == "__main__":
    main()
