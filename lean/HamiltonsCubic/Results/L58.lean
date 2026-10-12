import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L58, the graded set is strictly wider than the subalgebra family

[ungraded-slack.md](../../../findings/ungraded-slack.md)'s Lemma L58. The mechanism and both
surviving witnesses are arithmetic and are checked here; gradedness itself is a property the
base layer has no types for and stays imported.

**The mechanism is stronger than the block used, and here it is as one statement.** A Casimir
`W_𝔥 = c(Π_𝔥 - (r/N)Id)` has **exactly two** eigenvalues for `0 < r < N` and `c ≠ 0`. So any
point with three distinct eigenvalues is excluded from the family, not from one subalgebra,
but from **every** subalgebra at once, since the count does not mention `𝔥`.

**This file checks arithmetic only**, the operators, their criticality and their gradedness being
argued in the record's block; the numbers it checks are:

* `ℂP³` at `n = 6`: multiplicities `6, 8, 1` summing to `C(6,2) = 15`, at `θ₀(6)² = 10/9`.
* `S⁵ × S⁷` at `n = 12`: eigenvalues `-7/4, -5/6, 1` at multiplicities `10, 21, 35`, summing
  to `C(12,2) = 66` **and splitting as `C(5,2) + C(7,2) + 5·7`**, the two within-factor
  blocks and the cross block. Trace zero, and `θ² = 264/175`.
-/

namespace HamiltonsCubic.GradedWider

/-! ## The mechanism: a Casimir has exactly two eigenvalues -/

/-- The two Casimir eigenvalues, `c(1 - r/N)` on `𝔥` and `-c r/N` on its complement. -/
def hiEigen (c r N : ℚ) : ℚ := c * (1 - r / N)

def loEigen (c r N : ℚ) : ℚ := -(c * r / N)

/-- **They are distinct** exactly when `c ≠ 0`, the difference is `c`, independently of
`r` and `N`. -/
theorem eigen_gap (c r N : ℚ) (hN : N ≠ 0) : hiEigen c r N - loEigen c r N = c := by
  unfold hiEigen loEigen; field_simp; ring

/-- **And the Casimir is traceless**: `r` copies of the first plus `N - r` of the second. -/
theorem casimir_traceless (c r N : ℚ) (hN : N ≠ 0) :
    r * hiEigen c r N + (N - r) * loEigen c r N = 0 := by
  unfold hiEigen loEigen; field_simp; ring

/-- **So three distinct values cannot be a Casimir spectrum.** The exclusion never mentions
`𝔥`, which is why it rules out every subalgebra at once rather than one at a time. -/
theorem three_excludes {a b d c r N : ℚ} (hab : a ≠ b) (hbd : b ≠ d) (had : a ≠ d)
    (ha : a = hiEigen c r N ∨ a = loEigen c r N)
    (hb : b = hiEigen c r N ∨ b = loEigen c r N)
    (hd : d = hiEigen c r N ∨ d = loEigen c r N) : False := by
  rcases ha with ha | ha <;> rcases hb with hb | hb <;> rcases hd with hd | hd <;>
    simp_all

/-! ## Witness 1, `ℂP³` at `n = 6` -/

/-- The three multiplicities sum to `dim Λ²ℝ⁶ = 15`. -/
theorem cp3_multiplicities : 6 + 8 + 1 = 15 := by decide

theorem lambda2_six : 6 * 5 / 2 = 15 := by norm_num

/-- `θ₀(6)² = 10/9`, and the block's `1.054092553` brackets it. -/
theorem theta0_six_sq : 2 * (6 - 1 : ℚ) * (6 - 2) / 6 ^ 2 = 10 / 9 := by norm_num

theorem theta0_six_bracket :
    ((1054092 : ℚ) / 1000000) ^ 2 < 10 / 9 ∧ (10 : ℚ) / 9 < ((1054093 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-! ## Witness 2, `S⁵ × S⁷` at `n = 12` -/

/-- **Trace zero**, on the block's own eigenvalues and multiplicities. -/
theorem s5s7_traceless :
    10 * (-(7 : ℚ) / 4) + 21 * (-(5 : ℚ) / 6) + 35 * 1 = 0 := by norm_num

/-- The multiplicities sum to `dim Λ²ℝ¹² = 66`. -/
theorem s5s7_multiplicities : 10 + 21 + 35 = 66 := by decide

theorem lambda2_twelve : 12 * 11 / 2 = 66 := by norm_num

/-- **And they are the three blocks named**: `C(5,2)` within the first factor, `C(7,2)`
within the second, `5·7` across, a decomposition the block prints as three numbers without
saying where they come from. -/
theorem s5s7_block_split : 5 * 4 / 2 = 10 ∧ 7 * 6 / 2 = 21 ∧ 5 * 7 = 35 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- `θ(S⁵ × S⁷)² = 264/175`, from the family's closed form
`2(n-1)(p-1)(q-1)/((n-2)pq)`. -/
theorem s5s7_theta_sq :
    2 * (12 - 1 : ℚ) * (5 - 1) * (7 - 1) / ((12 - 2) * 5 * 7) = 264 / 175 := by norm_num

/-- And the block's `1.2282390` brackets it. -/
theorem s5s7_theta_bracket :
    ((1228238 : ℚ) / 1000000) ^ 2 < 264 / 175
      ∧ (264 : ℚ) / 175 < ((1228240 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-- **Three distinct eigenvalues**, which is what the mechanism needs. -/
theorem s5s7_three_distinct :
    (-(7 : ℚ) / 4) ≠ (-(5 : ℚ) / 6) ∧ (-(5 : ℚ) / 6) ≠ 1 ∧ (-(7 : ℚ) / 4) ≠ 1 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The withdrawn witness, and the anchor -/

/-- The withdrawn `(𝔰𝔲(3), 𝔰𝔬(3))` witness sat at `θ² = 6/5`; it is withdrawn on gradedness,
not on this value. -/
theorem withdrawn_theta_sq_bracket :
    ((1095445 : ℚ) / 1000000) ^ 2 < 6 / 5
      ∧ (6 : ℚ) / 5 < ((1095446 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-- The three surviving witnesses carry **three different** `θ²`, so none is a restatement of
another: `10/9`, `264/175` and `3/2`. -/
theorem witnesses_distinct :
    (10 : ℚ) / 9 ≠ 264 / 175 ∧ (264 : ℚ) / 175 ≠ 3 / 2 ∧ (10 : ℚ) / 9 ≠ 3 / 2 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## `S⁵ × S⁷` from its curvatures

*At `λ = 1` the Einstein product has sectional curvature `1/4` and `1/6` on its factors and
`c = 1/11`; the Weyl eigenvalues are the differences, and `θ² = 1/‖W‖²`.* -/

/-- **The three Weyl eigenvalues from the curvatures**: `1/4 - 1/11`, `1/6 - 1/11`, `0 - 1/11`. -/
theorem s5s7_eigen_from_curvature :
    (1 / 4 - 1 / 11 : ℚ) = 7 / 44 ∧ (1 / 6 - 1 / 11 : ℚ) = 5 / 66 ∧ (0 - 1 / 11 : ℚ) = -(1 / 11) := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **Trace zero** at multiplicities `10, 21, 35`. -/
theorem s5s7_curvature_traceless : 10 * (7 / 44 : ℚ) + 21 * (5 / 66) + 35 * (-(1 / 11)) = 0 := by norm_num

/-- **`‖W‖² = 175/264`**, so `θ² = 264/175`, above `3/2`. -/
theorem s5s7_normsq : 10 * (7 / 44 : ℚ) ^ 2 + 21 * (5 / 66) ^ 2 + 35 * (1 / 11) ^ 2 = 175 / 264 ∧
    (1 : ℚ) / (175 / 264) = 264 / 175 ∧ (3 : ℚ) / 2 < 264 / 175 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **The printed spectrum is this one, rescaled by `-11`.** -/
theorem s5s7_printed_rescaled :
    (-11 : ℚ) * (7 / 44) = -(7 / 4) ∧ (-11 : ℚ) * (5 / 66) = -(5 / 6) ∧ (-11 : ℚ) * (-(1 / 11)) = 1 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.GradedWider
