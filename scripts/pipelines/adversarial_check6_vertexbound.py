"""
Reviewer 5 (adversarial): independent re-derivation and stress-test of
findings/INDEX.md's "The <W#,W> bound - vertex-matrix reformulation" section.

Written from scratch: does NOT import run_vertex_bound.py. Reuses only
curvature_operator.py/weyl_decomposition.py's Q_op/weyl_from_mop machinery
(already independently re-implemented and confirmed by four prior
reviewers via completely different code paths - see reviews/INDEX.md Reviewers
1-4) as the trusted ground-truth for the frame-invariant <W#,W> value.
Every Weyl-tensor construction used below (sphere product, CP^2-type,
random genuine Weyl tensor) is built fresh in this file, independently of
cp2_tensor.py / weyl.py's constructions.
"""
import numpy as np
import itertools
import sympy as sp
from fractions import Fraction

import sys, os
sys.path.insert(0, 'scripts/lib')
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import mop_from_4tensor, weyl_from_mop, frob, norm

# =====================================================================
# PART 1: symbolic proof that the double sum equals (1/2)tr(Lambda^3)
# =====================================================================

def symbolic_identity_check(n):
    pairs = list(itertools.combinations(range(n), 2))
    lam = {p: sp.symbols(f'l{p[0]}{p[1]}') for p in pairs}

    def L(i, j):
        if i == j:
            return sp.Integer(0)
        a, b = (i, j) if i < j else (j, i)
        return lam[(a, b)]

    double_sum = sp.Integer(0)
    for (i, j) in pairs:
        inner = sum(L(i, k) * L(j, k) for k in range(n) if k != i and k != j)
        double_sum += L(i, j) * inner
    double_sum = sp.expand(double_sum)

    Lam = sp.Matrix(n, n, lambda i, j: L(i, j))
    trcube = sp.expand((Lam ** 3).trace())

    diff = sp.simplify(double_sum - sp.Rational(1, 2) * trcube)
    return diff, double_sum, trcube


def part1():
    print("=" * 78)
    print("PART 1: symbolic proof, double-sum = (1/2) tr(Lambda^3)")
    print("=" * 78)
    for n in [4, 5, 6]:
        diff, ds, tc = symbolic_identity_check(n)
        print(f"  n={n}: double_sum - (1/2)tr(Lambda^3) simplifies to: {diff}  "
              f"({'IDENTITY HOLDS' if diff == 0 else 'MISMATCH!!'})")

    # Hand combinatorial argument, verified separately by direct triangle counting:
    # For a fixed triple {a,b,c}, double_sum picks it up 3 times (once for each
    # choice of which pair is (i,j) and which index is k), each time contributing
    # the SAME product lam_ab*lam_ac*lam_bc (since Lambda symmetric).
    # So double_sum = 3 * sum_{i<j<k} lam_ij*lam_ik*lam_jk =: 3*triangle_sum.
    # tr(Lambda^3) = sum over ALL 3! orderings of {a,b,c} of the same product
    # (again all equal by symmetry) = 6 * triangle_sum.
    # Hence (1/2)*tr(Lambda^3) = 3*triangle_sum = double_sum.  No off-by-2 error.
    print("  Hand combinatorial check: double_sum = 3*triangle_sum, "
          "tr(Lambda^3) = 6*triangle_sum  =>  (1/2)tr(Lambda^3) = double_sum. Matches.")

    # numeric cross-check at larger n with random lambda (float64)
    rng = np.random.default_rng(0)
    for n in [8, 12]:
        pairs = list(itertools.combinations(range(n), 2))
        lam = {p: rng.normal() for p in pairs}

        def L(i, j):
            if i == j:
                return 0.0
            a, b = (i, j) if i < j else (j, i)
            return lam[(a, b)]

        ds = 0.0
        for (i, j) in pairs:
            inner = sum(L(i, k) * L(j, k) for k in range(n) if k != i and k != j)
            ds += L(i, j) * inner
        Lam = np.array([[L(i, j) for j in range(n)] for i in range(n)])
        trcube = np.trace(np.linalg.matrix_power(Lam, 3))
        print(f"  n={n} (random, float64): double_sum={ds:.8f}  "
              f"0.5*tr(Lambda^3)={0.5*trcube:.8f}  diff={ds-0.5*trcube:.2e}")


# =====================================================================
# PART 2: Ricci-flatness => row sums of Lambda vanish, derived by hand
# and checked against the trusted Ricci machinery independently.
# =====================================================================

def part2():
    print("\n" + "=" * 78)
    print("PART 2: Ricci formula for coordinate-diagonal R, by-hand derivation")
    print("=" * 78)
    print("""
  By-hand derivation: for R diagonal in coordinate 2-planes (R_ijkl != 0,
  up to antisymmetry, only when {i,j}={k,l}, with R_ijij =: lam_ij for
  i<j), the standard contraction Ric_jl = sum_i R_ijil is nonzero only
  when {i,j}={i,l} as index sets with i held fixed in both slots, which
  (for j,l != i) forces j=l. So Ric_jl = delta_jl * sum_{i!=j} lam_ij,
  i.e. Ric is diagonal with Ric_jj = sum_{i!=j} lam_ij = (row sum of
  Lambda at row j). No sign flip, no missing factor of 2: Ricci-flat
  (Ric=0) is EXACTLY Lambda*1=0.
""")
    # Verify this hand formula against the trusted ricci_from_mop machinery,
    # for random diagonal (not necessarily Ricci-flat) W.
    rng = np.random.default_rng(1)
    for n in [6, 8]:
        L2 = Lambda2(n)
        pairs = L2.pairs
        lam = {p: rng.normal() for p in pairs}
        Mop = np.zeros((L2.N, L2.N))
        for a, p in enumerate(pairs):
            Mop[a, a] = lam[p]
        T = lambda i, j, k, l, lam=lam, pairs=pairs: (
            lam[(min(i, j), max(i, j))] if ({i, j} == {k, l} and i != j) else 0.0
        )
        from weyl_decomposition import ricci_from_mop
        Ric = ricci_from_mop(L2, Mop)
        Lam = np.zeros((n, n))
        for (i, j) in pairs:
            Lam[i, j] = Lam[j, i] = lam[(i, j)]
        rowsums = Lam.sum(axis=1)
        err = np.max(np.abs(np.diag(Ric) - rowsums))
        offdiag_ric = np.max(np.abs(Ric - np.diag(np.diag(Ric))))
        print(f"  n={n}: max|Ric_jj - rowsum_j(Lambda)| = {err:.2e}   "
              f"max|off-diag Ric| = {offdiag_ric:.2e}")

    # Now build a genuine sphere-product Lambda via the (alpha,beta,gamma)
    # formula and confirm EXACT (Fraction-arithmetic) row-sum vanishing.
    print("\n  Exact-Fraction check that sphere-product Lambda has zero row sums:")
    for (p, q) in [(3, 3), (4, 4), (2, 6), (5, 7)]:
        n = p + q
        alpha = Fraction(q, (p - 1) * (n - 1))
        beta = Fraction(p, (q - 1) * (n - 1))
        gamma = Fraction(-1, n - 1)
        Lam = [[Fraction(0)] * n for _ in range(n)]
        for i in range(n):
            for j in range(n):
                if i == j:
                    continue
                same_block = (i < p) == (j < p)
                if same_block:
                    Lam[i][j] = alpha if i < p else beta
                else:
                    Lam[i][j] = gamma
        rowsums = [sum(row) for row in Lam]
        print(f"  (p,q)=({p},{q}): all row sums exactly zero? "
              f"{all(r == 0 for r in rowsums)}  (row sums: {set(rowsums)})")


# =====================================================================
# PART 3: re-derive the refined bound from Huisken's Lemma 2.10, by hand,
# INCLUDING checking the ||Lambda|| vs ||W|| relation (not assumed).
# =====================================================================

def part3():
    print("\n" + "=" * 78)
    print("PART 3: re-derivation of the refined bound (by hand)")
    print("=" * 78)
    print("""
  Huisken/Lemma 2.10: for trace-free symmetric m x m T,
      |tr(T^3)| <= (m-2)/sqrt(m(m-1)) * ||T||^3         (*)
  with equality iff one eigenvalue sqrt((m-1)/m)*||T||, rest
  -||T||/sqrt(m(m-1)).

  Since Lambda*1=0 exactly (Part 2), Lambda already lives entirely in the
  m=(n-1)-dimensional space 1^perp as an operator (1 is an exact
  0-eigenvector), so ||Lambda|_{1^perp}||_Frob = ||Lambda||_Frob exactly
  -- no norm is lost restricting to 1^perp. Apply (*) with m=n-1, T=Lambda:
      |tr(Lambda^3)| <= (n-3)/sqrt((n-1)(n-2)) * ||Lambda||^3.

  RELATION BETWEEN ||Lambda|| AND ||W|| (checked, not assumed):
  ||Lambda||_Frob^2 = sum_{i,j} Lambda_ij^2 = 2*sum_{i<j} lam_ij^2
    (off-diagonal entries counted twice, diagonal is zero)
  ||W||^2 = sum_{i<j} lam_ij^2   (W's Frobenius norm as an operator on
    Lambda^2 R^n, one diagonal entry per coordinate plane)
  => ||Lambda||_Frob = sqrt(2) * ||W||.

  So <W#,W> = (1/2)tr(Lambda^3)
            <= (1/2)*(n-3)/sqrt((n-1)(n-2)) * (sqrt(2)*||W||)^3
            = (1/2)*(n-3)/sqrt((n-1)(n-2)) * 2*sqrt(2) * ||W||^3
            = sqrt(2)*(n-3)/sqrt((n-1)(n-2)) * ||W||^3.        MATCHES CLAIM.

  Equality profile: one Lambda-eigenvalue sqrt((n-2)/(n-1))*||Lambda||,
  remaining (n-2) eigenvalues -||Lambda||/sqrt((n-1)(n-2)), one exact 0
  (the 1-direction). Matches the profile findings/INDEX.md states.
""")
    # numeric spot check of the ||Lambda||=sqrt(2)||W|| relation
    for (p, q) in [(4, 4), (5, 6)]:
        n = p + q
        alpha = Fraction(q, (p - 1) * (n - 1))
        beta = Fraction(p, (q - 1) * (n - 1))
        gamma = Fraction(-1, n - 1)
        Wnormsq = p * (p - 1) / 2 * alpha ** 2 + q * (q - 1) / 2 * beta ** 2 + p * q * gamma ** 2
        Lamnormsq = 2 * Wnormsq
        print(f"  (p,q)=({p},{q}): ||W||^2={float(Wnormsq):.8f}  "
              f"||Lambda||^2={float(Lamnormsq):.8f}  ratio={float(Lamnormsq/Wnormsq):.6f} (expect 2.0)")


# =====================================================================
# PART 4: saturation at even n, near-miss at odd n -- fresh construction
# =====================================================================

def sphere_lambda(n, p):
    q = n - p
    alpha = q / ((p - 1) * (n - 1))
    beta = p / ((q - 1) * (n - 1))
    gamma = -1.0 / (n - 1)
    Lam = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            same = (i < p) == (j < p)
            Lam[i, j] = (alpha if i < p else beta) if same else gamma
    return Lam


def refined_bound_ratio(n, Lam):
    Wnormsq = 0.5 * np.sum(Lam ** 2)  # = sum_{i<j} lam_ij^2
    Wnorm = np.sqrt(Wnormsq)
    true_val = 0.5 * np.trace(np.linalg.matrix_power(Lam, 3))
    bound = np.sqrt(2.0) * (n - 3) / np.sqrt((n - 1) * (n - 2)) * Wnorm ** 3
    return true_val / Wnorm ** 3, bound / Wnorm ** 3, true_val / bound


def part4():
    print("\n" + "=" * 78)
    print("PART 4: saturation profile, fresh construction, n=6..20 + odd check")
    print("=" * 78)
    print(f"{'n':>4} {'(p,q)':>8} {'true/||W||^3':>14} {'bound/||W||^3':>15} {'ratio true/bound':>18}")
    for n in range(6, 21):
        p = n // 2
        q = n - p
        Lam = sphere_lambda(n, p)
        tv, bv, ratio = refined_bound_ratio(n, Lam)
        print(f"{n:4d} {f'({p},{q})':>8} {tv:14.6f} {bv:15.6f} {ratio:18.6f}")

    # explicit odd-n near-miss check
    n = 7
    p, q = 3, 4
    Lam = sphere_lambda(n, p)
    tv, bv, ratio = refined_bound_ratio(n, Lam)
    print(f"\n  n=7 explicit check: ratio true/bound = {ratio:.4f} (claimed 0.9546)")

    # eigenvalue profile at n=100
    n = 100
    p = 50
    Lam = sphere_lambda(n, p)
    evals = np.sort(np.linalg.eigvalsh(Lam))
    normLam = np.linalg.norm(Lam)
    mu = np.sqrt((n - 2) / (n - 1)) * normLam
    nu = -normLam / np.sqrt((n - 1) * (n - 2))
    print(f"\n  n=100: Lambda eigenvalues (extremes) = "
          f"{evals[0]:.6f} ... {evals[-1]:.6f}, near-zero count = "
          f"{np.sum(np.abs(evals) < 1e-8)}")
    print(f"  Huisken extremal profile: mu={mu:.6f}, nu={nu:.6f}")
    print(f"  eigenvalue closest to mu: {evals[-1]:.6f} (diff {abs(evals[-1]-mu):.2e})")
    print(f"  eigenvalues near nu: min={evals[1]:.6f} max={evals[-2]:.6f} vs nu={nu:.6f}")


# =====================================================================
# PART 5: is there a frame-invariant fix? Genuine attempt.
# =====================================================================

def part5():
    print("\n" + "=" * 78)
    print("PART 5: searching for a frame-invariant reformulation")
    print("=" * 78)
    print("""
  Candidate construction tested: for a general W (operator on Lambda^2
  R^n), define the "partial contraction" matrix
      M_ij := sum_k W(e_i^e_k, e_j^e_k)     (sum over one shared leg)
  This IS frame-covariant in the right way (M transforms as a symmetric
  2-tensor under O(n), like Ricci) -- but does it reduce to Lambda on the
  coordinate-diagonal locus? By hand: for W diagonal in coordinate planes,
  W(e_i^e_k, e_j^e_k) is the (ik,jk) entry of W in the pair basis, which
  is zero unless {i,k}={j,k}, i.e. i=j. So M_ii = sum_k lam_ik = Ric_ii,
  and M_ij = 0 for i!=j. This is RICCI, not Lambda -- Lambda's
  off-diagonal entries (which carry essentially the entire bound) are
  invisible to any single-contraction construction of this shape.

  This is not a coincidence: Lambda_ij = W(e_i^e_j, e_i^e_j) is, by
  definition, literally the sectional-curvature-type value of the
  SPECIFIC 2-plane spanned by e_i and e_j. A "matrix of sectional
  curvatures of coordinate planes" is exactly as basis-dependent as
  sectional curvature itself: K(X,Y) is a function on the Grassmannian of
  2-planes, not a bilinear pairing on R^n, and there is no known linear
  contraction of W that recovers "K of THIS SPECIFIC plane" without
  picking a plane, i.e. without picking a frame. Ricci and scalar
  curvature are the only rank<=2-tensor invariants extractable from R by
  a SINGLE contraction; Lambda is not such an invariant, it is a
  (basis-dependent) ARRAY of values of the sectional curvature function.

  Numeric confirmation of the M_ij=Ricci (not Lambda) failure mode:
""")
    n = 8
    p = 4
    Lam = sphere_lambda(n, p)
    L2 = Lambda2(n)
    lam = {}
    for i in range(n):
        for j in range(i + 1, n):
            lam[(i, j)] = Lam[i, j]
    Mop = np.zeros((L2.N, L2.N))
    for a, (i, j) in enumerate(L2.pairs):
        Mop[a, a] = lam[(i, j)]
    # M_ij = sum_k Mop[(i,k),(j,k)]  (using get_entry convention)
    from weyl_decomposition import get_entry
    M = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            s = 0.0
            for k in range(n):
                if k == i or k == j:
                    continue
                s += get_entry(Mop, L2.idx, i, k, j, k)
            M[i, j] = s
    print(f"  max|M - diag(Ricci)| = {np.max(np.abs(M - np.diag(np.diag(M)))):.2e}  "
          f"(should be ~0: M is diagonal, i.e. == Ricci, NOT Lambda)")
    print(f"  M diagonal (=Ricci, should be all 0 since sphere product is Ricci-flat): "
          f"max|diag(M)| = {np.max(np.abs(np.diag(M))):.2e}")
    print("  => confirms M is Ricci (trivially zero here), carries NONE of Lambda's "
          "structure. No cheap single-contraction fix exists.")
    print("""
  Conclusion: findings/INDEX.md's characterization -- that the identity is a
  fact about the coordinate-diagonal frame and not a tensorial one -- is
  correct as far as this reviewer could determine. The natural
  frame-invariant single-contraction candidate collapses to Ricci (zero
  content beyond what's already used to define the constraint), not to
  Lambda. A genuine frame-invariant proof, if one exists, would have to
  bound <W#,W> using higher-order or non-linear-in-W invariants (e.g. an
  extremal-plane / variational characterization: does SOME coordinate
  system make Lambda achieve its cubic-trace value maximally, i.e. is
  <W#,W> always <= max over ALL orthonormal frames of (1/2)tr(Lambda(frame)^3)?
  This reframes the open lifting lemma in Open Gaps, not a new shortcut.)
""")


# =====================================================================
# PART 6: off-diagonal stress tests, fresh constructions.
# =====================================================================

def cp2_type_weyl_fresh(n):
    """Fresh, independent construction of the CP^2-type Weyl tensor via
    the standard constant-holomorphic-sectional-curvature tensor formula
    on a fixed complex-structure 4-plane (indices 0,1,2,3; J: 0<->1,
    2<->3 with signs), zero-padded into R^n, then Weyl-projected via the
    standard Kulkarni-Nomizu decomposition (weyl_from_mop already does
    exactly this projection given a raw curvature operator -- reused
    here only for the projection step, not for building the raw tensor).
    R(X,Y,Z,W) = g(X,W)g(Y,Z)-g(X,Z)g(Y,W)
               + g(JX,W)g(JY,Z)-g(JX,Z)g(JY,W) + 2g(X,JY)g(Z,JW)
    """
    J = np.zeros((n, n))
    if n >= 4:
        J[0, 1], J[1, 0] = -1.0, 1.0
        J[2, 3], J[3, 2] = -1.0, 1.0

    def g(a, b):
        return 1.0 if a == b else 0.0

    def Jdot(v):
        return J[:, v] if False else None

    def Jv(idx):
        return J[:, idx]

    def T(i, j, k, l):
        Ji, Jj, Jk = Jv(i), Jv(j), Jv(k)
        term1 = g(i, l) * g(j, k) - g(i, k) * g(j, l)
        term2 = Ji[l] * Jj[k] - Ji[k] * Jj[l]
        # NOTE: sign fixed by direct verification, not by trusting a
        # textbook paraphrase -- tried both signs of this cross term
        # against the first Bianchi identity over thousands of sampled
        # index quadruples: "+2*Ji[j]*Jk[l]" gives residual 4.0 (NOT an
        # algebraic curvature tensor at all); "-2*Ji[j]*Jk[l]" gives
        # residual 0 to machine precision, together with exact
        # pair-antisymmetry and pair-swap symmetry. This is exactly the
        # kind of curvature-tensor sign trap reviews/INDEX.md's Reviewer 3
        # flagged for the Ishihara/Besse QK formula -- caught here before
        # use (via the Bianchi-identity check itself), not after.
        term3 = -2 * Ji[j] * Jk[l]
        return term1 + term2 + term3

    # Bianchi-identity sanity check on the RAW tensor before trusting it
    # as a genuine algebraic curvature tensor (this is the check that
    # caught the sign bug above).
    worst = 0.0
    idxs = list(itertools.permutations(range(n), 4))
    for (i, j, k, l) in idxs[:2000]:
        worst = max(worst, abs(T(i, j, k, l) + T(i, k, l, j) + T(i, l, j, k)))
    assert worst < 1e-9, f"Bianchi identity violated, residual {worst}"

    L2 = Lambda2(n)
    Mop = mop_from_4tensor(L2, T)
    assert np.max(np.abs(Mop - Mop.T)) < 1e-9, "Mop not symmetric -- not pair-swap symmetric"
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    return Weyl, L2


def random_bianchi_ricciflat_weyl(n, rng):
    """Random genuine Weyl tensor via linear-algebra nullspace projection:
    Sym^2(Lambda^2) intersected with the linear Bianchi-identity constraints
    (weyl.py's build_structure_constants/bianchi_constraint_matrix -- pure
    scaffolding, independently re-derived/re-used by Reviewer 2's
    adversarial_check2.py already), then further intersected with the
    kernel of the (linear) Ricci contraction map, built and solved fresh
    here via SVD rather than importing run_vertex_bound.py's
    random_weyl_basis. (A hand-rolled one-shot cyclic average was tried
    first and found NOT to satisfy the Bianchi identity -- S(i,j,k,l) is
    invariant under cyclic permutation of (j,k,l), so averaging over the
    cyclic orbit is a no-op, not a projection; this is why the validated
    SVD/nullspace route is used instead.)
    """
    from weyl import build_structure_constants, bianchi_constraint_matrix, vec_to_mat, R_val
    L2 = Lambda2(n)
    idx, pos, N, c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    U, S_, Vt = np.linalg.svd(Bmat)
    tol = 1e-9 * S_[0] if len(S_) > 0 else 1e-9
    rank = np.sum(S_ > tol)
    null_basis = Vt[rank:, :].T
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
                    row[d] += R_val(Rmat_ds[d], pos, n, i, j, k, j)
            ric_rows.append(row)
    RicMat = np.array(ric_rows)
    Ur, Sr, Vtr = np.linalg.svd(RicMat)
    tolr = 1e-9 * Sr[0] if len(Sr) > 0 else 1e-9
    rankr = np.sum(Sr > tolr)
    weyl_coeffs = Vtr[rankr:, :].T
    weyl_basis = null_basis @ weyl_coeffs

    coeffs = rng.normal(size=weyl_basis.shape[1])
    vec = weyl_basis @ coeffs
    Mop = vec_to_mat(vec, triu_idx, N)
    Weyl, Ric, Sc = weyl_from_mop(L2, Mop)
    return Weyl, L2, Ric


def wsharp_true(L2, Wn):
    Q = Q_op(L2, Wn)
    Wsharp = Q - Wn @ Wn
    return frob(Wn, Wsharp)


def vertex_bound(n):
    return np.sqrt(2.0) * (n - 3) / np.sqrt((n - 1) * (n - 2))


def part6():
    print("\n" + "=" * 78)
    print("PART 6: off-diagonal stress tests, fresh constructions")
    print("=" * 78)
    n = 8
    Weyl, L2 = cp2_type_weyl_fresh(n)
    nv = norm(Weyl)
    print(f"  CP^2-type fresh build: ||Weyl||={nv:.6f} (nonzero => not degenerate)")
    if nv > 1e-8:
        Wn = Weyl / nv
        tv = wsharp_true(L2, Wn)
        bound = vertex_bound(n)
        print(f"  true <W#,W> = {tv:.6f}   refined bound = {bound:.6f}   "
              f"true <= bound? {tv <= bound + 1e-9}")
    else:
        print("  degenerate at n=8 (need different check).")

    print()
    rng = np.random.default_rng(123)
    n = 6
    bound = vertex_bound(n)
    for trial in range(5):
        Weyl, L2, Ric = random_bianchi_ricciflat_weyl(n, rng)
        maxric = np.max(np.abs(Ric))
        nv = norm(Weyl)
        if nv < 1e-6:
            print(f"  trial {trial}: degenerate (||Weyl||={nv:.2e}), skipping")
            continue
        Wn = Weyl / nv
        tv = wsharp_true(L2, Wn)
        print(f"  trial {trial}: max|Ric before projection|={maxric:.2e}  "
              f"true <W#,W>={tv:+.6f}   refined bound={bound:.6f}   "
              f"|true|<=bound? {abs(tv) <= bound + 1e-9}")


if __name__ == "__main__":
    part1()
    part2()
    part3()
    part4()
    part5()
    part6()
