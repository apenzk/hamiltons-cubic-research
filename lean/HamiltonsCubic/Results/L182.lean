import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L182, `λ F` is uniformly bounded below

[second-order.md](../../../findings/second-order.md)'s Lemma L182, closing [I2](../../../plan.md)'s
stated gap: the radius bound weakens with `n`, but its constant does not, so large `n` needs no
separate argument.

**What is checked here.** The monotonicity that drives it, `θ₀² = 2(1 - 3/n + 2/n²)` is increasing
in `n`, so `λ` decreases and stays above its limit, and the crude product bound, which needs no
monotonicity of `λF` itself.

**What is not.** `F`'s closed form, its value at `n = 12` and its monotonicity, all quoted from
[L162](L162.lean) and carrying that lemma's own Gate 2 debt.
-/

namespace HamiltonsCubic.UniformConstant

/-! ## `θ₀` increases, so `λ` decreases -/

/-- **`θ₀(n)² = 2(1 - 3/n + 2/n²)`**, the form in which the monotonicity is visible. -/
theorem theta0_sq_form (n : ℚ) (hn : n ≠ 0) :
    2 * (n - 1) * (n - 2) / n ^ 2 = 2 * (1 - 3 / n + 2 / n ^ 2) := by
  field_simp; ring

/-- **As a function of `u = 1/n` its derivative is `2(-3 + 4u)`, negative for `u < 3/4`.** So
`θ₀²` increases in `n` beyond `n = 4/3`, hence at every `n ≥ 12`. -/
theorem derivative_negative (u : ℚ) (h : u < 3 / 4) : 2 * (-3 + 4 * u) < 0 := by linarith

/-- **`λ` is decreasing**: `θ₀ - √(3/2)` increases, and `λ = 2/√(9·)` inverts it. Here as the
order fact the inversion needs, a larger positive denominator gives a smaller quotient. -/
theorem lambda_decreasing (a b : ℝ) (ha : 0 < a) (hab : a < b) : 2 / b < 2 / a := by
  exact div_lt_div_of_pos_left (by norm_num) ha hab

/-! ## The crude product bound -/

/-- **The whole argument.** `λ > λ∞` and `F ≥ F(12)` give `λF > λ∞ F(12)`, **no monotonicity of
the product is used**, which matters because a decreasing function times an increasing one need
not be monotone. -/
theorem product_bound (lam lamInf F F12 : ℝ)
    (hl : lamInf < lam) (hF : F12 ≤ F) (hlp : 0 < lamInf) (hFp : 0 < F12) :
    lamInf * F12 < lam * F := by nlinarith [hl, hF, hlp, hFp]

/-- The numbers: `λ∞ = 1.53157`, `F(12) = 0.38673`, product `0.59230` to five places. -/
theorem the_constant :
    (1531581 : ℚ) / 1000000 * (38673 / 100000) > 5923 / 10000 := by norm_num

/-- And the two ends of the range, `λF` falling from `2.4267` at `n = 12` towards `1.3831`, are
both above it, so `n = 12` is the chain's best case and the limit its worst. -/
theorem ends_of_range :
    (24267 : ℚ) / 10000 > 59230 / 100000 ∧ (13831 : ℚ) / 10000 > 59230 / 100000 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.UniformConstant
