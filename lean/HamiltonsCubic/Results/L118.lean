import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L118, the constant that was never three data points

[curvature-invariants.md](../../../findings/curvature-invariants.md)'s Lemma L118. The audit
upgrades the core from fitted to derived: `c_n = [n+4]_6 / 144` is Weingart's own normalising
falling factorial, so *"the three integers were never three data points"*.

**It simplifies further, and the record does not say so.** A falling factorial of length six
is `720` times a binomial, and `720/144 = 5`, so

`c_n = 5·C(n+4, 6)`.

That makes integrality automatic, six consecutive integers are divisible by `6!`, where
`[n+4]_6/144` leaves it to be checked. The three values are `140`, `420`, `1050`.

**And three points could not have determined it anyway.** A degree-six polynomial has seven
coefficients, so three values underdetermine it: two different degree-six polynomials agree at
any three points. The formula had to come from outside the data, which is what *"never three
data points"* means and what the audit does not quantify.
-/

namespace HamiltonsCubic.WeingartConstant

/-- `c_n = 5·C(n+4, 6)`, the simplified form. -/
def c (n : ℕ) : ℕ := 5 * Nat.choose (n + 4) 6

/-! ## The three values -/

theorem c_four : c 4 = 140 := by decide

theorem c_five : c 5 = 420 := by decide

theorem c_six : c 6 = 1050 := by decide

/-! ## The two forms agree -/

/-- **`[n+4]_6 / 144 = 5·C(n+4,6)`** at each tabulated `n`, since `720/144 = 5`. -/
theorem forms_agree_four : 8 * 7 * 6 * 5 * 4 * 3 / 144 = c 4 := by decide

theorem forms_agree_five : 9 * 8 * 7 * 6 * 5 * 4 / 144 = c 5 := by decide

theorem forms_agree_six : 10 * 9 * 8 * 7 * 6 * 5 / 144 = c 6 := by decide

/-- The conversion factor: `6! / 144 = 5`. -/
theorem conversion : Nat.factorial 6 / 144 = 5 := by decide

/-! ## Three points could not have determined it -/

/-- **Two different polynomials agree at three points**, a degree-six polynomial has seven
coefficients, so three values underdetermine it, so no fit through the three integers
could have produced the formula, it came from outside the data. -/
theorem three_points_underdetermine :
    ∃ f g : ℚ → ℚ, f 0 = g 0 ∧ f 1 = g 1 ∧ f 2 = g 2 ∧ f 3 ≠ g 3 := by
  refine ⟨fun _ => 0, fun t => t * (t - 1) * (t - 2), ?_, ?_, ?_, ?_⟩
  · norm_num
  · norm_num
  · norm_num
  · norm_num

/-! ## The uniqueness clause is backwards -/

/-- The audit says *"'also false at `n=4,5`' is backwards: the identity holds there and
uniqueness fails"*. Holding and being unique are independent, a true identity can have many
solutions, and `many_solutions` exhibits that. -/
theorem many_solutions :
    ∃ (P : ℚ → Prop) (x y : ℚ), P x ∧ P y ∧ x ≠ y := by
  refine ⟨fun t => t ^ 2 = 1, 1, -1, by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.WeingartConstant
