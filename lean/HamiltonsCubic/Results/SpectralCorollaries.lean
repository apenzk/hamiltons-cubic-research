import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

/-!
# Two owed corollaries, and what they actually need

[L97](L97.lean) and [L122](L122.lean) each record a corollary as owed *"which needs the spectral
theorem"*, the layer working over `ℚ` where no such theorem is available. **Both corollaries are
elementary once the eigenvalue list is granted**, and neither uses the spectral theorem itself.

**`λ_max > 0` from `tr K = 0`.** Granted a finite list of eigenvalues summing to the trace, a
zero trace with some nonzero eigenvalue forces a strictly positive one, otherwise every term is
`≤ 0` and a vanishing sum makes them all `0`. No diagonalisation enters; only the sum.

**`r ≤ 2/λ²` from a norm budget.** Granted `r` eigenvalues each of modulus at least `λ` and a
squared-norm budget of `2`, the count is at most `2/λ²`, since `r` terms each at least `λ²`
cannot sum past the budget.

**So the debt is narrower than recorded.** What is owed is not the spectral theorem but only that
the eigenvalue list exists and sums to the trace, and the corollaries drawn from it are
arithmetic, proved here over `ℝ` for an arbitrary finite family.
-/

namespace HamiltonsCubic.SpectralCorollaries

open Finset

variable {ι : Type*}

/-! ## A zero sum with a nonzero term has a positive term -/

/-- **`tr K = 0` and `K ≠ 0` give `λ_max > 0`**, granted the eigenvalue list. -/
theorem pos_of_sum_zero (s : Finset ι) (f : ι → ℝ)
    (hsum : ∑ i ∈ s, f i = 0) (i₀ : ι) (hi₀ : i₀ ∈ s) (hne : f i₀ ≠ 0) :
    ∃ j ∈ s, 0 < f j := by
  by_contra hcon
  push_neg at hcon
  exact hne ((Finset.sum_eq_zero_iff_of_nonpos hcon).1 hsum i₀ hi₀)

/-! ## A budget bounds a count -/

/-- **`r` values each at least `λ²`, summing to at most `2`, force `r ≤ 2/λ²`.** -/
theorem card_le_budget (s : Finset ι) (f : ι → ℝ) {lam : ℝ} (hlam : 0 < lam)
    (hlow : ∀ i ∈ s, lam ^ 2 ≤ f i) (hbud : ∑ i ∈ s, f i ≤ 2) :
    (s.card : ℝ) * lam ^ 2 ≤ 2 := by
  calc (s.card : ℝ) * lam ^ 2 = ∑ _i ∈ s, lam ^ 2 := by
        rw [Finset.sum_const, nsmul_eq_mul]
    _ ≤ ∑ i ∈ s, f i := Finset.sum_le_sum hlow
    _ ≤ 2 := hbud

/-- **Equivalently `r ≤ 2/λ²`.** -/
theorem card_le_two_div (s : Finset ι) (f : ι → ℝ) {lam : ℝ} (hlam : 0 < lam)
    (hlow : ∀ i ∈ s, lam ^ 2 ≤ f i) (hbud : ∑ i ∈ s, f i ≤ 2) :
    (s.card : ℝ) ≤ 2 / lam ^ 2 := by
  have h := card_le_budget s f hlam hlow hbud
  have hpos : (0:ℝ) < lam ^ 2 := by positivity
  rw [le_div_iff₀ hpos]
  linarith

/-! ## What remains owed -/

/-- The hypothesis both corollaries consume is the eigenvalue list itself: a finite family whose
sum is the trace. **That is what the spectral theorem supplies, and it is all it supplies here**,
everything after is the arithmetic above. -/
theorem budget_is_the_only_input (s : Finset ι) (f : ι → ℝ) {lam : ℝ} (hlam : 0 < lam)
    (hlow : ∀ i ∈ s, lam ^ 2 ≤ f i) (hbud : ∑ i ∈ s, f i ≤ 2) (hne : s.Nonempty) :
    lam ^ 2 ≤ 2 := by
  obtain ⟨i, hi⟩ := hne
  have h1 : lam ^ 2 ≤ f i := hlow i hi
  have h2 : ∑ j ∈ s, f j ≤ 2 := hbud
  have hrest : ∀ j ∈ s, (0:ℝ) ≤ f j := fun j hj => le_trans (by positivity) (hlow j hj)
  have : f i ≤ ∑ j ∈ s, f j := Finset.single_le_sum hrest hi
  linarith

end HamiltonsCubic.SpectralCorollaries
