"""
Exact-arithmetic PROOF of the 3/2-Gram identity (FINDINGS "Lifting Jaeger's
§3.3 in trace form", Result 2 -- previously "machine-exact in floats, symbolic
write-up outstanding").

THE IDENTITY.  For every symmetric operator R on Lambda^2 R^n, with T_R its
4-tensor (repo dictionary: T_R(i,j,k,l) = R_{(ij),(kl)} in the pair basis,
extended by the standard antisymmetries), Ric the usual single-trace
contraction, # Hamilton's sharp, and Alt the orthogonal projection of T_R
onto Lambda^4 (the 1/3-weighted cyclic sum),

  (GRAM)   D(R)_ij := Ric(R^2 + R^#)_ij - sum_{k,l} Ric(R)_kl T_R(k,i,l,j)
                    = (3/2) sum_{k,l,m} Alt(R)_iklm Alt(R)_jklm.

WHAT THIS SCRIPT PROVES.  Both sides are quadratic maps S^2(Lambda^2 R^n) ->
S^2(R^n) over Q, so (GRAM) holds identically over Q at a given n iff the two
quadratics agree at every element E_u of the standard basis of symmetric
N x N matrices (N = n(n-1)/2) and at every pairwise sum E_u + E_v -- that
pins down the polarized symmetric bilinear forms B(E_u, E_v) =
(1/2)[D(E_u+E_v) - D(E_u) - D(E_v)] on a complete basis-pair set.  The
script verifies exactly this, in EXACT INTEGER ARITHMETIC after clearing the
only denominators in sight (2 from Hamilton's sharp, 3 from Alt): with
K := 2 R^# (integer for integer R, since the so(n) structure constants are
integer-valued -- asserted below) and A3 := 3 Alt(T_R) (the plain cyclic
sum, integer),

  (GRAM)  <=>  6 D(R) = Gram6,   6 D(R) = Ric(6 R^2 + 3 K) - 6 (R . Ric(R)),
               Gram6_ij := sum_{klm} A3_iklm A3_jklm,

and every quantity is an int64 numpy array (all intermediates provably
< 2^24, asserted at runtime, so int64 einsum arithmetic is exact).  A zero
integer difference at all 1540 evaluation points at n=5 (55 basis elements
+ 1485 unordered pairs) is a PROOF of (GRAM) over Q, hence over R, for
every symmetric R at n=5; the same is run at n=4, 6, 7 (231, 7260, and
26796 evaluation points; total runtime under 10 seconds).

EXTENSION TO ALL n (the stability / first-fundamental-theorem argument).
Polarize (GRAM) and pair the output with a test h in S^2(R^n): each side
becomes an O(n)-invariant trilinear functional of (T_A, T_B, h), i.e. an
invariant linear functional on (R^n)^{tensor 10}.  Every term in the
defining formulas is a complete contraction of T_A tensor T_B tensor h
against a fixed pattern of Kronecker deltas with coefficients INDEPENDENT
of n: the pair-basis <-> 4-tensor dictionary is factor-free; sums over pair
indices are (1/2) x full-range vector-index sums; the structure constants
c[(ij),(kl),(pq)] expand into +/-1 delta patterns via the commutator
formula; Ric is a single trace; Alt carries 1/3; sharp carries -1/2; and
the constant 3/2 is n-free.  By Weyl's first fundamental theorem for O(n),
invariant functionals on (R^n)^{tensor 10} are spanned by the 9!! = 945
complete pairings (perfect matchings of the 10 slots); so LHS - RHS is
represented by a single n-INDEPENDENT rational coefficient vector on formal
pairings.  The evaluation map from formal pairings on (R^n)^{tensor 2k} to
actual functionals is injective iff n >= k (second fundamental theorem in
Brauer-algebra form: ker(B_k(n) -> End((R^n)^{tensor k})) = 0 iff n >= k;
Brauer 1937, Brown 1955, Lehrer-Zhang Ann. of Math. 176 (2012)).  Here
2k = 10, k = 5, so the EXACT verification at n = 5 forces the coefficient
vector itself to vanish -- and a vanishing formal element evaluates to zero
at EVERY n, including n < 5.  Hence (GRAM) holds for all n >= 2.

HONEST GAPS in the extension argument, stated precisely: (i) the reduction
of both sides to pairing-combinations with n-independent coefficients is by
inspection of the defining formulas (itemized above), not machine-checked;
(ii) the SFT threshold n >= k is quoted from the literature, not re-proven
here.  The independent exact runs at n = 4, 6, 7 corroborate (i): a
hypothetical hidden n-dependent coefficient would generically break at
least one of the four dimensions.  Within gaps (i)-(ii) the result is:
(GRAM) is PROVEN exactly at n = 4, 5, 6, 7, and proven for all n
conditional only on (i)-(ii), both standard.

PART 0 validates the integer pipeline against the repo's float machinery
(Rsharp_full, ricci_from_mop, alt_mop, mop_to_tensor4) on random small-
integer symmetric operators, guarding against convention drift.
PART 1 runs the complete exact basis-pair verification at n = 4, 5, 6, 7.
PART 2 prints the verdict.
"""
import sys
import time
from itertools import combinations

import numpy as np

from weyl import build_structure_constants
from curvature_operator import Lambda2
from weyl_decomposition import frob, norm
from rsharp_basis_free import Rsharp_full
from run_bianchi_defect import build_alt_indices, alt_mop
from run_vertex_bound import mop_to_tensor4

INT_BOUND = 2 ** 24  # every intermediate is asserted below this; int64 exact


def int_structure_constants(n):
    idx, pos, N, c = build_structure_constants(n)
    ci = np.rint(c).astype(np.int64)
    assert np.array_equal(ci.astype(float), c), "structure constants not integer"
    return idx, N, ci


class IntCtx:
    """Precomputed integer machinery for one n."""

    def __init__(self, n):
        self.n = n
        self.idx, self.N, self.c = int_structure_constants(n)
        I = np.array([p[0] for p in self.idx])
        J = np.array([p[1] for p in self.idx])
        # advanced-indexing targets for the 4 sign placements of Mop -> T4
        self.Ir, self.Jr = I[:, None], J[:, None]
        self.Ic, self.Jc = I[None, :], J[None, :]

    def t4(self, M):
        """Integer 4-tensor of the pair-basis operator matrix M (int64)."""
        n = self.n
        T = np.zeros((n, n, n, n), dtype=np.int64)
        T[self.Ir, self.Jr, self.Ic, self.Jc] = M
        T[self.Jr, self.Ir, self.Ic, self.Jc] = -M
        T[self.Ir, self.Jr, self.Jc, self.Ic] = -M
        T[self.Jr, self.Ir, self.Jc, self.Ic] = M
        return T

    def ric(self, T):
        return np.einsum('ijkj->ik', T)

    def sharp2(self, R):
        """K = 2 R^# (integer).  (R#)_{ab} = -1/2 tr(A_a R A_b R)."""
        S = np.einsum('amn,np->amp', self.c, R)
        return -np.einsum('amp,bpm->ab', S, S)

    def six_D(self, R, T):
        """6 D(R) as an exact integer n x n matrix."""
        K = self.sharp2(R)                      # 2 R^#
        M6 = 6 * (R @ R) + 3 * K                # 6 (R^2 + R^#)
        ric6 = self.ric(self.t4(M6))            # 6 Ric(R^2 + R^#)
        h = self.ric(T)                         # Ric(R), integer
        dot6 = 6 * np.einsum('kl,kilj->ij', h, T)
        out = ric6 - dot6
        assert max(np.abs(M6).max(), np.abs(out).max()) < INT_BOUND
        return out

    def gram6(self, T):
        """6 x RHS = sum_{klm} A3_iklm A3_jklm with A3 = 3 Alt(T_R)."""
        A3 = T + np.einsum('iklj->ijkl', T) + np.einsum('iljk->ijkl', T)
        out = np.einsum('iklm,jklm->ij', A3, A3)
        assert np.abs(out).max() < INT_BOUND
        return out

    def check(self, R):
        """Exact check of (GRAM) at one integer symmetric R; True iff equal."""
        T = self.t4(R)
        return np.array_equal(self.six_D(R, T), self.gram6(T))


def part0_float_crosscheck(n=5, seed=0, trials=3):
    print("=" * 78)
    print("PART 0: integer pipeline vs repo float machinery (convention guard)")
    print("=" * 78)
    rng = np.random.default_rng(seed)
    ictx = IntCtx(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    idx, pos, N, c = build_structure_constants(n)
    worst_lhs = worst_rhs = worst_id = 0.0
    for _ in range(trials):
        Ri = rng.integers(-2, 3, size=(N, N))
        Ri = Ri + Ri.T  # integer symmetric
        Rf = Ri.astype(float)
        # float LHS via repo machinery
        from weyl_decomposition import ricci_from_mop
        Q = Rf @ Rf + Rsharp_full(Rf, c)
        Tf = mop_to_tensor4(L2, Rf)
        Df = ricci_from_mop(L2, Q) - np.einsum(
            'kl,kilj->ij', ricci_from_mop(L2, Rf), Tf)
        # float RHS via repo alt_mop re-embedded and re-expanded to a 4-tensor
        Ta = mop_to_tensor4(L2, alt_mop(Rf, alt_idx))
        Gf = 1.5 * np.einsum('iklm,jklm->ij', Ta, Ta)
        # exact integers
        Ti = ictx.t4(Ri.astype(np.int64))
        sixD = ictx.six_D(Ri.astype(np.int64), Ti)
        G6 = ictx.gram6(Ti)
        worst_lhs = max(worst_lhs, np.abs(6 * Df - sixD).max())
        worst_rhs = max(worst_rhs, np.abs(6 * Gf - G6).max())
        worst_id = max(worst_id, np.abs(Df - Gf).max())
    print(f"  n={n}, {trials} random integer symmetric R:")
    print(f"    max |6*D_float - sixD_int|    = {worst_lhs:.2e}  (expect ~1e-10)")
    print(f"    max |6*Gram_float - Gram6_int| = {worst_rhs:.2e}  (expect ~1e-10)")
    print(f"    float identity residual        = {worst_id:.2e}  (expect ~1e-12)")
    ok = worst_lhs < 1e-6 and worst_rhs < 1e-6
    print(f"    conventions match: {'ok' if ok else 'MISMATCH'}")
    return ok


def part1_exact(ns=(4, 5, 6)):
    print()
    print("=" * 78)
    print("PART 1: exact integer verification on the complete basis-pair set")
    print("=" * 78)
    all_ok = True
    for n in ns:
        t0 = time.time()
        ictx = IntCtx(n)
        N = ictx.N
        basis = [(a, b) for a in range(N) for b in range(a, N)]
        M = len(basis)

        def E(u):
            R = np.zeros((N, N), dtype=np.int64)
            a, b = basis[u]
            R[a, b] += 1
            R[b, a] += 1
            return R

        n_evals, n_fail = 0, 0
        # singles: pins the diagonal of the polarized bilinear form
        for u in range(M):
            n_evals += 1
            if not ictx.check(E(u)):
                n_fail += 1
        # unordered pairs: pins every off-diagonal entry via E_u + E_v
        for u in range(M):
            Eu = E(u)
            for v in range(u + 1, M):
                n_evals += 1
                if not ictx.check(Eu + E(v)):
                    n_fail += 1
        dt = time.time() - t0
        verdict = "PROVEN (exact, all zero)" if n_fail == 0 else \
            f"FAILED at {n_fail} points"
        print(f"  n={n}: N={N}, dim Sym = {M}, evaluations = {n_evals} "
              f"({M} singles + {n_evals - M} pairs)  [{dt:.1f}s]  -> {verdict}")
        all_ok = all_ok and (n_fail == 0)
    return all_ok


def main():
    ns = tuple(int(a) for a in sys.argv[1:]) or (4, 5, 6, 7)
    ok0 = part0_float_crosscheck()
    ok1 = part1_exact(ns)
    print()
    print("=" * 78)
    print("PART 2: verdict")
    print("=" * 78)
    if ok0 and ok1:
        print(f"  The 3/2-Gram identity (GRAM) is PROVEN in exact rational")
        print(f"  arithmetic for every symmetric R on Lambda^2 R^n at n = "
              f"{', '.join(str(n) for n in ns)}:")
        print("  both quadratic sides agree exactly (integer equality, all")
        print("  denominators cleared) on a complete polarization basis-pair set.")
        print("  Extension to all n: both sides are universal O(n)-contraction")
        print("  expressions with n-independent coefficients; by Weyl's FFT the")
        print("  difference is an n-independent combination of the 945 pairings")
        print("  of 10 tensor slots, and by the SFT (Brauer-algebra kernel:")
        print("  ker(B_5(n) -> End(V^x5)) = 0 iff n >= 5) those pairings are")
        print("  linearly independent at n = 5 -- so the exact n = 5 result")
        print("  forces the formal difference to vanish, giving (GRAM) for")
        print("  every n.  Gaps (stated in the docstring): the n-independent-")
        print("  coefficient reduction is by inspection, and the SFT threshold")
        print("  is quoted, not re-proven; both are standard.")
        print("  In particular D(R) is a Gram matrix, so D(R) >= 0 is now a")
        print("  THEOREM, and tr D(R) = 6 ||Alt R||^2 follows by tracing.")
    else:
        print("  FAILURE -- see above; the identity did NOT verify.")


if __name__ == "__main__":
    main()
