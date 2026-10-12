import Mathlib.Data.Rat.Defs
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L21's remaining obligation, two reviewers, two different blocks

[INDEX-results.md](../../../findings/INDEX-results.md) row 21 records *"the remaining obligation
is one rational block"*, and row 20 that L21 is *"now narrowed to a single rational block"*. The
block itself names **two different reductions**, from the two reviewers, and they are not the
same object.

* [r486](../../../reviews/REVIEW_r486.md) reduces to **one `20×20` block**, the one carrying the
  `1`, both `½`'s and three `⅓`'s, on the ground that `m` enters only through `g_m`
  normalisations and the trace-free projection, which reach the trivial block alone.
* [r487](../../../reviews/REVIEW_r487.md) reduces to **one fixed rational `6×6`**, the `Λ²` block,
  which it finds structurally `m`-independent with `⅓` attained there.

**These are different claims about different matrices.** `6 = C(4,2) = dim Λ²ℝ⁴`, so r487's block
is the `Λ²` summand; r486's is the trivial one. One reduction can hold while the other fails, and
the obligation they leave differs by a factor of `400/36` in entries, r487's is over eleven times
smaller.

**And the record's own rule says this matters.** [nondegeneracy.md](../../../findings/nondegeneracy.md)
records that *"recording two reviewers as agreeing when they differ removes exactly the signal
Gate 2 exists to produce"*, written about a different pair, and applying here: the index rows
report a single reduction where the block carries two.

**A count the reduction leaves open.** r486's `20×20` has six eigenvalues named, one `1`, two
`½`'s, three `⅓`'s, so `14` of its `20` dimensions are unaccounted by the description.
-/

namespace HamiltonsCubic.RationalBlock

/-! ## The two blocks are different objects -/

/-- **`6 = C(4,2) = dim Λ²ℝ⁴`**, so r487's block is the `Λ²` summand. -/
theorem lambda2_four_is_six : Nat.choose 4 2 = 6 := by decide

/-- **The two reductions differ by over elevenfold in entries.** -/
theorem sizes_differ :
    20 * 20 = 400 ∧ 6 * 6 = 36 ∧ (11 : ℚ) < 400 / 36 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The named eigenvalues do not fill r486's block -/

/-- **Six eigenvalues are named in a `20×20`**, one `1`, two `½`'s, three `⅓`'s. -/
theorem named_eigenvalue_count : 1 + 2 + 3 = 6 := by norm_num

/-- **So `14` of the `20` dimensions are unaccounted** by the description given. -/
theorem unaccounted_dimensions : 20 - 6 = 14 ∧ (6 : ℚ) / 20 < 1 / 2 := by
  refine ⟨by norm_num, by norm_num⟩

/-- The named values sum to `1 + 2·½ + 3·⅓ = 3`, so they carry `3` of the block's trace. -/
theorem named_trace_contribution : (1 : ℚ) + 2 * (1 / 2) + 3 * (1 / 3) = 3 := by norm_num

/-! ## The multiplicities the branching reproduces -/

/-- The four named blocks carry multiplicities `20, 20, 6, 10`, summing to `56`. -/
theorem multiplicities_sum : 20 + 20 + 6 + 10 = 56 := by norm_num

/-- **`20` occurs twice among the four multiplicities**, so naming a block by its size alone does
not determine it, r486's *"the one carrying the `1`"* is what picks it out, and the size is not
enough. -/
theorem size_alone_is_ambiguous :
    (([20, 20, 6, 10] : List ℕ).count 20 = 2) ∧ ([20, 20, 6, 10] : List ℕ).count 6 = 1 := by
  refine ⟨by decide, by decide⟩

end HamiltonsCubic.RationalBlock
