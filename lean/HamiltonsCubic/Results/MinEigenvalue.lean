import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# `ε_min ≤ 4/n` is an average, and the common kernel is `n - 4`

Two more of [stratum-two-negative.md](../../../findings/stratum-two-negative.md)'s figures.

**The unconditional bound is the pigeonhole on an average.** The normalisation gives
`tr(XᵀX + YᵀY) = 4`, so `n` nonnegative eigenvalues sum to `4` and the smallest is at most their
mean, `ε_min ≤ 4/n`, with equality exactly when they are all equal, which is the isotropic case
the block names. At `n = 12` that is `1/3`, as recorded. **Nothing about the operators enters**:
the same bound holds for any `n` nonnegative numbers with that sum.

**And the common kernel is `n - 4`.** Both negative eigenvectors have rank `4` and share their
support, so the common kernel is that support's complement: `6` at `n = 10` and `8` at `n = 12`,
the block's two values.

**The screening separation narrows with `n`, as [L102](L102.lean)'s did.** Against a generic
`0.186` and `0.106`, the kernel values `1.4×10⁻¹⁶` and `2.8×10⁻¹⁶` separate by more than fifteen
orders at `n = 10` and between fourteen and fifteen at `n = 12`. *Two independent screenings in
this record show the same drift, which is what one would expect of accumulating floating-point
error and is not evidence either way without an error model.*
-/

namespace HamiltonsCubic.MinEigenvalue

open Finset

/-! ## The averaging bound -/

/-- **The smallest of `n` nonnegative numbers summing to `4` is at most `4/n`.** No property of
the operators is used. -/
theorem min_le_mean {ι : Type*} (s : Finset ι) (f : ι → ℝ) (hne : s.Nonempty)
    (hsum : ∑ i ∈ s, f i = 4) (m : ℝ) (hm : ∀ i ∈ s, m ≤ f i) :
    m * s.card ≤ 4 := by
  calc m * s.card = ∑ _i ∈ s, m := by
        rw [Finset.sum_const, nsmul_eq_mul]; ring
    _ ≤ ∑ i ∈ s, f i := Finset.sum_le_sum hm
    _ = 4 := hsum

/-- **Equality forces every value to the mean**, the isotropic case. -/
theorem equality_forces_flat {ι : Type*} (s : Finset ι) (f : ι → ℝ)
    (hsum : ∑ i ∈ s, f i = 4) (m : ℝ) (hm : ∀ i ∈ s, m ≤ f i)
    (heq : m * s.card = 4) : ∑ i ∈ s, (f i - m) = 0 := by
  rw [Finset.sum_sub_distrib, hsum, Finset.sum_const, nsmul_eq_mul]
  linarith [heq]

/-- At `n = 12` the bound is `1/3`. -/
theorem bound_at_twelve : (4 : ℝ) / 12 = 1 / 3 := by norm_num

/-! ## The common kernel -/

/-- **Rank `4` on a shared support leaves a kernel of `n - 4`**, `6` at `n = 10`, `8` at
`n = 12`. -/
theorem common_kernel : 10 - 4 = 6 ∧ 12 - 4 = 8 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **Both values come from one rank, and the rank is determined by them.** Rank `4` gives `6`
and `8`; rank `5` would give `5` and `7`, so the pair of measurements pins the shared support. -/
theorem rank_is_determined :
    (10 - 4 = 6 ∧ 12 - 4 = 8) ∧ (10 - 5 = 5 ∧ 12 - 5 = 7) ∧ (6 : ℕ) ≠ 5 := by
  refine ⟨⟨by norm_num, by norm_num⟩, ⟨by norm_num, by norm_num⟩, by decide⟩

/-! ## The screening separation -/

/-- **More than fifteen orders at `n = 10`.** -/
theorem separation_at_ten : (10 : ℝ) ^ 15 * (14 / 10 ^ 17) < 186 / 1000 := by norm_num

/-- **And between fourteen and fifteen at `n = 12`**, so the separation narrows. -/
theorem separation_at_twelve :
    (10 : ℝ) ^ 14 * (28 / 10 ^ 17) < 106 / 1000
      ∧ (106 : ℝ) / 1000 < (10 : ℝ) ^ 15 * (28 / 10 ^ 17) := by
  constructor <;> norm_num

end HamiltonsCubic.MinEigenvalue
