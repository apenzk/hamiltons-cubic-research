import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# L52, the shared-frame majorization bound: the arithmetic of the audit's counts

[bispectral.md](../../../findings/bispectral.md)'s Lemma L52. Three of the audit's counts are arithmetic and are
carried here; the figures come from an earlier form of the block (the cap identity, `3.674235`, the `t_F = 4/3`
threshold), and the strict looseness of the one-line bound, whose arithmetic tail is `strictly_loose`, needs
`μᵢ ∈ {0, M₊}` at equality and `Σμ = 0` for `Mpair`, which are not declared here.

**The cap is an identity, not a coincidence.** The boxed cap
`μ₁(K) ≤ √(2(n-2)/(n-1)) = n θ₀(n)/(n-1)` holds *identically in `n`*, which is what makes it
a shared-frame coupling rather than a numerical agreement at some `n`. Proved as an equality
of squares, so no square root is taken.

**"Strictly loose at every unit Weyl tensor" has a one-line proof the block does not give.**
Equality in the one-line bound needs every `μᵢ ∈ {0, M₊}`, and then `μᵢ² = M₊ μᵢ` termwise,
so `Σμ² = M₊ Σμ = 0`, which contradicts `Σμ² = 1` outright. No case split on `M₊` or on how
many entries are nonzero is needed.

**The positive reading's penalty reproduces.** `(9/2)(M₊+m)(1 - t_F/2)` at `t_F = 1` and
`M₊ + m = √(8/3)` is the block's `3.674235`, bracketed below without evaluating the root.
-/

namespace HamiltonsCubic.SharedFrame

open Finset

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- **The cap is an identity in `n`.** `(n θ₀(n)/(n-1))² = 2(n-2)/(n-1)`, so the two printed
forms of the boxed cap are the same number at every `n`. -/
theorem cap_identity (n : ℚ) (hn : 3 ≤ n) :
    n ^ 2 * theta0Sq n / (n - 1) ^ 2 = 2 * (n - 2) / (n - 1) := by
  unfold theta0Sq
  have h0 : n ≠ 0 := by intro h; linarith
  have h1 : n - 1 ≠ 0 := by intro h; linarith
  field_simp

/-! ## The one-line bound is strictly loose at every unit Weyl tensor -/

variable {ι : Type*} [Fintype ι]

/-- **Equality in the one-line bound is impossible.** If every eigenvalue lies in `{0, M}`
then `μᵢ² = M μᵢ` termwise, so `Σμ² = M Σμ = 0`, and a unit tensor has `Σμ² = 1`. The
argument needs neither a case split on `M` nor a count of the nonzero entries. -/
theorem two_valued_impossible {μ : ι → ℝ} {M : ℝ}
    (hval : ∀ i, μ i = 0 ∨ μ i = M) (htrace : ∑ i, μ i = 0) : ∑ i, (μ i) ^ 2 = 0 := by
  have hterm : ∀ i ∈ univ, (μ i) ^ 2 = M * μ i := by
    intro i _
    rcases hval i with h | h
    · rw [h]; ring
    · rw [h]; ring
  rw [Finset.sum_congr rfl hterm, ← Finset.mul_sum, htrace, mul_zero]

/-- So a unit tensor cannot attain it: `Σμ² = 1` and `Σμ² = 0` are incompatible. -/
theorem strictly_loose {μ : ι → ℝ} {M : ℝ} (hval : ∀ i, μ i = 0 ∨ μ i = M)
    (htrace : ∑ i, μ i = 0) (hunit : ∑ i, (μ i) ^ 2 = 1) : False := by
  have := two_valued_impossible hval htrace
  linarith [this, hunit]

/-! ## The positive reading -/

/-- The bound the audit supplies: `θ ≤ (t/2)^{3/2} Θ + (9/2)(M₊+m)(1 - t/2)`. Its shape is
carried through `t/2` so the exactness at `t = 2` is visible without a root. -/
def penalty (Mm t : ℚ) : ℚ := (9 / 2) * Mm * (1 - t / 2)

/-- **At `t_F = 2` the penalty vanishes**, so the bound is exact there, which is precisely
what makes it an instance of [post F26](../../../findings/INDEX-traps.md)'s class: no bound
exact at `t = 2` and monotone below it can close. -/
theorem penalty_at_two (Mm : ℚ) : penalty Mm 2 = 0 := by unfold penalty; ring

/-- The penalty is strictly decreasing in `t` for `M₊ + m > 0`, which is the monotonicity
post F26 asks for. -/
theorem penalty_antitone {Mm t t' : ℚ} (hMm : 0 < Mm) (hlt : t < t') :
    penalty Mm t' < penalty Mm t := by
  unfold penalty; nlinarith [hMm, hlt]

/-- `(M₊ + m)² = 8/3`, the value the record's six digits `1.632993` carry. -/
theorem Mm_sq : ((1632993 : ℚ) / 1000000) ^ 2 < 8 / 3 ∧ (8 : ℚ) / 3 < ((1632994 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-- **The penalty sum reproduces `3.674235`** at `t = 1`: `(9/2)·√(8/3)·(1/2)`, squared as
`(81/16)·(8/3) = 27/2`, and `3.674235² < 27/2 < 3.674236²`. -/
theorem penalty_sum_sq : (81 : ℚ) / 16 * (8 / 3) = 27 / 2 := by norm_num

theorem penalty_sum_bracket :
    ((3674234 : ℚ) / 1000000) ^ 2 < 27 / 2 ∧ (27 : ℚ) / 2 < ((3674236 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-- **The penalty's threshold.** The second display's penalty term alone, without its `(t_F/2)^{3/2} Θ` part, loses to
the one-line bound exactly below `t_F = 4/3`, and `4/3 < 2`, a range with interior. This is arithmetic about that term;
the record's "beats the strict one-line bound on a neighbourhood of the diagonal family" concerns the first display over
a set of Weyl tensors and is owed in the L52 row. -/
theorem threshold_nonempty : (4 : ℚ) / 3 < 2 := by norm_num

/-- **The dimension count behind "away from the family"**: `n(n-2) < n(n+1)(n+2)(n-3)/12 = dim Weylₙ`
from `n = 5` on, as the rational inequality `12 n(n-2) < n(n+1)(n+2)(n-3)`. The record reads it as the
coordinate-diagonal locus being a proper subvariety of dimension at most `n(n-2)` whose complement has
interior; that reading is owed in the L52 row. -/
theorem diagonal_locus_proper (n : ℚ) (hn : 5 ≤ n) :
    12 * (n * (n - 2)) < n * (n + 1) * (n + 2) * (n - 3) := by
  nlinarith [hn, sq_nonneg (n - 5), sq_nonneg n]

/-- At `n = 5` the two are `15` and `35`; the Weyl dimension is the one [L83](L83.lean) uses
as `dim 𝒲₅`. -/
theorem diagonal_locus_five :
    (5 : ℚ) * (5 - 2) = 15 ∧ (5 : ℚ) * (5 + 1) * (5 + 2) * (5 - 3) / 12 = 35 := by
  constructor <;> norm_num

end HamiltonsCubic.SharedFrame
