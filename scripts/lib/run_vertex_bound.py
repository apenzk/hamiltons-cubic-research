"""
Vertex-matrix reformulation and sharp bound for <W^#, W>, the "eigenspace
alignment" term identified in findings/INDEX.md's "Tachibana-trick estimate
extension" section as the entire bottleneck to a general (non-diagonal)
proof of Conjecture A. That section shows, for W diagonal in coordinate
2-planes with eigenvalues lambda_ij (i<j):

    <W^#,W> = sum_{i<j} lambda_ij * sum_{k!=i,j} lambda_ik*lambda_jk

and observes that tr(W^3) already has a sharp Tachibana/Huisken-type bound
(findings/INDEX.md Lemma 2.10, applied with m=N=binom(n,2)) but <W^#,W> did not.

NEW STEP TAKEN HERE (see findings/INDEX.md's dated section below for the
write-up): the double sum above is EXACTLY a triangle sum over the
complete graph K_n whose edges carry the weights lambda_ij, and is exactly
(1/2)*tr(Lambda^3) where Lambda is the ordinary n x n symmetric "vertex
matrix" (zero diagonal, Lambda_ij = lambda_ij). This re-expresses the hard
term as the SAME kind of cubic-trace quantity that Lemma 2.10 already
bounds sharply -- just applied to a different (n x n, not N x N) matrix
built from the same eigenvalues. Because every genuine Weyl (Ricci-flat)
coordinate-diagonal W forces Lambda to have the all-ones vector in its
kernel (row sums of Lambda are the diagonal Ricci entries), the SHARP
bound to use is Lemma 2.10 applied to Lambda's restriction to 1^perp,
i.e. with m=n-1, not m=n. This script:

  1. Verifies the identity <W^#,W> = (1/2) tr(Lambda^3) three independent
     ways (direct triangle sum, matrix cube of Lambda, and the repo's
     trusted Q_op/Rsharp machinery) for many diagonal W (sphere products
     and random diagonal Weyl tensors).
  2. Verifies Lambda 1 = 0 (Ricci-flatness <=> zero row sums) and derives/
     verifies the resulting SHARP bound
         <W^#,W> <= sqrt(2)*(n-3)/sqrt((n-1)(n-2)) * ||W||^3
     which is strictly tighter than the naive (unconstrained, m=n) version
     and still -> sqrt(2)*||W||^3 as n -> infinity, matching the
     sphere-product's own asymptotic ceiling (findings/INDEX.md: (P/||W||^3)^2
     -> 2) exactly.
  3. Measures how close the balanced sphere product's Lambda spectrum gets
     to Huisken's extremal eigenvalue profile on 1^perp (the
     "why does the maximizer nearly saturate this" question).
  4. STRESS-TESTS whether any of this survives off the coordinate-diagonal
     locus: (a) a random O(n) rotation of the sphere-product tensor's
     frame, (b) the CP^2-type competitor (already non-diagonal in the
     standard frame), (c) the QK/HP^m-type competitor (also non-diagonal),
     (d) fully random genuine (Bianchi + Ricci-flat) Weyl tensors at
     n=6. Reports the residual <W^#,W> - (1/2)tr(Lambda^3) in each case --
     this residual is exactly the piece of the eigenspace-alignment term
     that a purely-diagonal-frame vertex matrix cannot see.

Built entirely on the repo's already-validated Pipeline C primitives
(curvature_operator.py, weyl_decomposition.py, cp2_tensor.py,
run_hpm_qk.py) -- no new curvature machinery is introduced, only a new
way of slicing the already-trusted <W^#,W> value.
"""
import numpy as np
import itertools

from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, norm, frob, P_value
from cp2_tensor import cp2_tensor
from run_hpm_qk import qk_tensor
from weyl import build_structure_constants, bianchi_constraint_matrix, vec_to_mat


# ---------------------------------------------------------------
# Core: vertex matrix, <W^#,W>, and the two Huisken-type bounds.
# ---------------------------------------------------------------

def wsharp_pairing(L2, Mop):
    """<W^#,W> via the repo's trusted Q_op = W^2 + W^# machinery."""
    Q = Q_op(L2, Mop)
    Wsharp = Q - Mop @ Mop
    return frob(Mop, Wsharp)


def vertex_matrix_from_diagonal(L2, Mop):
    """Lambda_ij = Mop's diagonal entry for the coordinate plane (i,j),
    i<j; zero diagonal. Only meaningful when Mop is (at least
    approximately) diagonal in the coordinate-plane basis -- off-diagonal
    entries of Mop are simply ignored, which is exactly the point of the
    stress test in part 4."""
    n = L2.n
    Lam = np.zeros((n, n))
    diag = np.diag(Mop)
    for a, (i, j) in enumerate(L2.pairs):
        Lam[i, j] = diag[a]
        Lam[j, i] = diag[a]
    return Lam


def triangle_sum_direct(n, lam_dict):
    """Brute-force triangle sum sum_{i<j<k} lambda_ij*lambda_jk*lambda_ik,
    independent of any matrix-power code path -- used only as a from-
    scratch cross-check of tr(Lambda^3)/6."""
    total = 0.0
    for i, j, k in itertools.combinations(range(n), 3):
        def L(a, b):
            return lam_dict[(min(a, b), max(a, b))]
        total += L(i, j) * L(j, k) * L(i, k)
    return total


def double_sum_direct(n, lam_dict):
    """Brute-force double sum exactly as written in findings/INDEX.md:
    sum_{i<j} lambda_ij * sum_{k!=i,j} lambda_ik*lambda_jk."""
    total = 0.0
    for i, j in itertools.combinations(range(n), 2):
        inner = 0.0
        for k in range(n):
            if k == i or k == j:
                continue
            def L(a, b):
                return lam_dict[(min(a, b), max(a, b))]
            inner += L(i, k) * L(j, k)
        total += lam_dict[(i, j)] * inner
    return total


def huisken_bound(m, normT):
    """Sharp bound |tr(T^3)| <= (m-2)/sqrt(m(m-1)) * ||T||^3 for trace-free
    symmetric m x m T (findings/INDEX.md Lemma 2.10 / Huisken)."""
    if m < 2:
        return 0.0
    return (m - 2) / np.sqrt(m * (m - 1)) * normT ** 3


def naive_vertex_bound(n, normW):
    """Unconstrained (m=n) version, ignoring Ricci-flatness."""
    return np.sqrt(2.0) * huisken_bound(n, normW)


def refined_vertex_bound(n, normW):
    """Ricci-flatness-aware (m=n-1, Lambda restricted to 1^perp) version."""
    return np.sqrt(2.0) * huisken_bound(n - 1, normW)


# ---------------------------------------------------------------
# 1-2-3: diagonal case -- identity, Ricci-flatness constraint, bound,
# and saturation profile, at the balanced sphere product.
# ---------------------------------------------------------------

def sphere_product_weyl(L2, p):
    n = L2.n
    q = n - p
    N = L2.N
    Mop0 = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        same_block = (i < p and j < p) or (i >= p and j >= p)
        Mop0[a, a] = 1.0 if same_block else -1.0  # arbitrary seed, Weyl-projected below
    Weyl, Ric, S = weyl_from_mop(L2, Mop0)
    return Weyl


def run_diagonal_checks():
    print("=" * 78)
    print("PART 1-3: diagonal case -- identity, bound, saturation")
    print("=" * 78)
    header = f"{'n':>4} {'true <W#,W>/|W|^3':>20} {'naive bound':>14} {'refined bound':>15} {'ratio(true/refined)':>20}"
    print(header)
    for n in range(6, 21):
        p = n // 2
        L2 = Lambda2(n)
        W = sphere_product_weyl(L2, p)
        nv = norm(W)
        Wn = W / nv  # unit-norm

        # three-way identity check (only done at a couple of n to keep it fast)
        if n in (6, 8, 10):
            lam_dict = {}
            for a, (i, j) in enumerate(L2.pairs):
                lam_dict[(i, j)] = Wn[a, a]
            ds = double_sum_direct(n, lam_dict)
            ts = triangle_sum_direct(n, lam_dict)
            Lam = vertex_matrix_from_diagonal(L2, Wn)
            trcube = np.trace(np.linalg.matrix_power(Lam, 3))
            true_val = wsharp_pairing(L2, Wn)
            print(f"  [n={n} identity check] double_sum_direct={ds:.10f}  "
                  f"3*triangle_sum={3*ts:.10f}  0.5*tr(Lambda^3)={0.5*trcube:.10f}  "
                  f"Q_op-based <W#,W>={true_val:.10f}")
            row_sums = Lam.sum(axis=1)
            print(f"  [n={n} Ricci-flatness check] max|row sum of Lambda| = {np.max(np.abs(row_sums)):.2e}")

        true_val = wsharp_pairing(L2, Wn)  # ||Wn||=1 so this is already /|W|^3
        naive = naive_vertex_bound(n, 1.0)
        refined = refined_vertex_bound(n, 1.0)
        print(f"{n:4d} {true_val:20.6f} {naive:14.6f} {refined:15.6f} {true_val/refined:20.6f}")

    # saturation profile at a specific n
    n = 100
    p = n // 2
    L2 = Lambda2(n)
    W = sphere_product_weyl(L2, p)
    Wn = W / norm(W)
    Lam = vertex_matrix_from_diagonal(L2, Wn)
    evals = np.linalg.eigvalsh(Lam)
    normLam = np.linalg.norm(Lam)
    mu_extremal = np.sqrt((n - 2) / (n - 1)) * normLam
    nu_extremal = -1.0 / np.sqrt((n - 1) * (n - 2)) * normLam
    print(f"\n  [n={n} saturation profile] Lambda eigenvalues (sorted): "
          f"{np.round(np.sort(evals), 6)}")
    print(f"  Huisken-extremal-on-1^perp profile: one eigenvalue {mu_extremal:.6f}, "
          f"{n-2} eigenvalues {nu_extremal:.6f}, plus 0 (on the 1-direction)")


# ---------------------------------------------------------------
# 4: off-diagonal stress tests.
# ---------------------------------------------------------------

def mop_to_tensor4(L2, Mop):
    n = L2.n
    T = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(L2.pairs):
        for b, (k, l) in enumerate(L2.pairs):
            val = Mop[a, b]
            T[i, j, k, l] = val
            T[j, i, k, l] = -val
            T[i, j, l, k] = -val
            T[j, i, l, k] = val
            T[k, l, i, j] = val
            T[l, k, i, j] = -val
            T[k, l, j, i] = -val
            T[l, k, j, i] = val
    return T


def rotate_tensor4(T, O):
    return np.einsum('ia,jb,kc,ld,abcd->ijkl', O, O, O, O, T, optimize=True)


def random_orthogonal(n, rng):
    Q, R = np.linalg.qr(rng.normal(size=(n, n)))
    Q *= np.sign(np.diag(R))
    return Q


def stress_test_rotation():
    print("\n" + "=" * 78)
    print("PART 4a: random O(n) rotation of the sphere-product tensor's frame")
    print("=" * 78)
    n = 8
    p = 4
    rng = np.random.default_rng(42)
    L2 = Lambda2(n)
    W = sphere_product_weyl(L2, p)
    Wn = W / norm(W)
    true_val = wsharp_pairing(L2, Wn)  # frame-invariant, exact reference value

    T = mop_to_tensor4(L2, Wn)
    for trial in range(3):
        O = random_orthogonal(n, rng)
        Trot = rotate_tensor4(T, O)
        Mop_rot = mop_from_4tensor(L2, lambda i, j, k, l, Trot=Trot: Trot[i, j, k, l])
        true_val_rot = wsharp_pairing(L2, Mop_rot)
        offdiag_norm = np.linalg.norm(Mop_rot - np.diag(np.diag(Mop_rot)))
        Lam_rot = vertex_matrix_from_diagonal(L2, Mop_rot)
        vertex_only = 0.5 * np.trace(np.linalg.matrix_power(Lam_rot, 3))
        print(f"  trial {trial}: true <W#,W> (frame-invariant) = {true_val_rot:.8f} "
              f"(reference {true_val:.8f}); off-diagonal-plane-entries norm of rotated "
              f"Mop = {offdiag_norm:.4f}; (1/2)tr(Lambda_rot^3) computed from ONLY the "
              f"rotated frame's diagonal entries = {vertex_only:.8f}  "
              f"[residual = {true_val_rot - vertex_only:.8f}]")


def stress_test_named_competitors():
    print("\n" + "=" * 78)
    print("PART 4b/4c: named off-diagonal competitors (CP^2-type, QK/HP^m-type)")
    print("=" * 78)
    n = 8
    L2 = Lambda2(n)

    T_cp2, _ = cp2_tensor(n)
    Mop_cp2 = mop_from_4tensor(L2, T_cp2)
    Weyl_cp2, Ric_cp2, _ = weyl_from_mop(L2, Mop_cp2)
    nv = norm(Weyl_cp2)
    Wn = Weyl_cp2 / nv
    true_val = wsharp_pairing(L2, Wn)
    offdiag_norm = np.linalg.norm(Wn - np.diag(np.diag(Wn)))
    Lam = vertex_matrix_from_diagonal(L2, Wn)
    vertex_only = 0.5 * np.trace(np.linalg.matrix_power(Lam, 3))
    naive = naive_vertex_bound(n, 1.0)
    refined = refined_vertex_bound(n, 1.0)
    print(f"  CP^2-type (n=8, natural frame): true <W#,W>={true_val:.6f}  "
          f"off-diag-entries-norm={offdiag_norm:.4f}  "
          f"vertex-matrix-only estimate={vertex_only:.6f}  "
          f"[residual={true_val - vertex_only:.6f}]  "
          f"naive bound={naive:.6f}  refined bound={refined:.6f}  "
          f"true<=refined? {true_val <= refined + 1e-9}")

    m = 2
    T_qk = qk_tensor(n, m, c1=1.0, c2=1.0)
    Mop_qk = mop_from_4tensor(L2, T_qk)
    Weyl_qk, Ric_qk, _ = weyl_from_mop(L2, Mop_qk)
    nv = norm(Weyl_qk)
    Wn = Weyl_qk / nv
    true_val = wsharp_pairing(L2, Wn)
    offdiag_norm = np.linalg.norm(Wn - np.diag(np.diag(Wn)))
    Lam = vertex_matrix_from_diagonal(L2, Wn)
    vertex_only = 0.5 * np.trace(np.linalg.matrix_power(Lam, 3))
    print(f"  QK/HP^2-type (n=8, natural frame): true <W#,W>={true_val:.6f}  "
          f"off-diag-entries-norm={offdiag_norm:.4f}  "
          f"vertex-matrix-only estimate={vertex_only:.6f}  "
          f"[residual={true_val - vertex_only:.6f}]  "
          f"naive bound={naive:.6f}  refined bound={refined:.6f}  "
          f"true<=refined? {true_val <= refined + 1e-9}")


def random_weyl_basis(n):
    """Genuine (Bianchi-closed, Ricci-flat) random Weyl operators at small n,
    built via the Bianchi-nullspace + Ricci-trace-free projection already
    used in weyl.py's __main__ (factored out here as a reusable function
    instead of re-running that script as __main__)."""
    idx, pos, N, c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    U, S, Vt = np.linalg.svd(Bmat)
    tol = 1e-9 * S[0] if len(S) > 0 else 1e-9
    rank = np.sum(S > tol)
    null_basis = Vt[rank:, :].T

    def R_val(Rmat, i, j, k, l):
        if i == j or k == l:
            return 0.0
        si = 1.0
        a, b = i, j
        if a > b:
            a, b = b, a
            si = -si
        sk = 1.0
        p, q = k, l
        if p > q:
            p, q = q, p
            sk = -sk
        return si * sk * Rmat[pos[(a, b)], pos[(p, q)]]

    D = null_basis.shape[1]
    Rmat_ds = [vec_to_mat(null_basis[:, d], triu_idx, N) for d in range(D)]
    ric_rows = []
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D)
            for j in range(n):
                if j == i or j == k:
                    continue
                for d in range(D):
                    row[d] += R_val(Rmat_ds[d], i, j, k, j)
            ric_rows.append(row)
    RicMat = np.array(ric_rows)
    Ur, Sr, Vtr = np.linalg.svd(RicMat)
    tolr = 1e-9 * Sr[0] if len(Sr) > 0 else 1e-9
    rankr = np.sum(Sr > tolr)
    weyl_coeffs = Vtr[rankr:, :].T
    weyl_basis = null_basis @ weyl_coeffs  # M x D_weyl
    return weyl_basis, triu_idx, N


def stress_test_random_generic():
    print("\n" + "=" * 78)
    print("PART 4d: fully random genuine (Bianchi + Ricci-flat) Weyl tensors, n=6")
    print("=" * 78)
    n = 6
    L2 = Lambda2(n)
    weyl_basis, triu_idx, N = random_weyl_basis(n)
    D = weyl_basis.shape[1]
    print(f"  dim(Weyl space) at n=6 = {D} (formula (n+2)(n+1)n(n-3)/12 = "
          f"{(n+2)*(n+1)*n*(n-3)/12:.0f})")
    rng = np.random.default_rng(7)
    naive = naive_vertex_bound(n, 1.0)
    refined = refined_vertex_bound(n, 1.0)
    for trial in range(5):
        coeffs = rng.normal(size=D)
        vec = weyl_basis @ coeffs
        Mop = vec_to_mat(vec, triu_idx, N)
        Weyl, Ric, S = weyl_from_mop(L2, Mop)
        assert np.max(np.abs(Ric)) < 1e-8, "generated tensor is not Ricci-flat"
        nv = norm(Weyl)
        Wn = Weyl / nv
        true_val = wsharp_pairing(L2, Wn)
        offdiag_norm = np.linalg.norm(Wn - np.diag(np.diag(Wn)))
        Lam = vertex_matrix_from_diagonal(L2, Wn)
        vertex_only = 0.5 * np.trace(np.linalg.matrix_power(Lam, 3))
        print(f"  trial {trial}: true <W#,W>={true_val:+.6f}  "
              f"off-diag-entries-norm={offdiag_norm:.4f}  "
              f"vertex-matrix-only estimate={vertex_only:+.6f}  "
              f"[residual={true_val - vertex_only:+.6f}]  "
              f"|true|<=refined bound {refined:.6f}? {abs(true_val) <= refined + 1e-9}")


if __name__ == "__main__":
    run_diagonal_checks()
    stress_test_rotation()
    stress_test_named_competitors()
    stress_test_random_generic()
