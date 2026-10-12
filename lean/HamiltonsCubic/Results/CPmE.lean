import Mathlib

/-!
# `E = P - (3/2) tr W³` at `ℂℙᵐ`, in closed form

[The working note](../../../reviews/2026-09-28d-I121-smallmass-direct.md) on I121's small-mass
node, "Calibration on `ℂℙᵐ`".

**The source's statement.** "`E(ℂℙᵐ) = 9 / (2 √(3m(m²-1)(2m-1)))`", from the Weyl spectrum
proportional to `2(m²-1)`, `m-2`, `-(m+1)` with multiplicities `1`, `m²-1`, `m²-m`, and
`θ² = (m+1)(2m-1)/(3m(m-1))`.

**What is typed.** With `N = 3m(m²-1)(2m-1)` the squared norm of the scaled spectrum and `K` its
cube sum: `cp_norm` and `cp_cube` evaluate them; `cp_E_poly`, the polynomial identity
`(m+1)(2m-1) N - (3/2) K = (9/2) N`; `cp_E`, with `θ = (m+1)(2m-1)/√N` and `tr = K/(N√N)`,
`θ - (3/2) tr = 9/(2√N)`; `cp_theta`, the two forms of `θ` agree at `m ≥ 2`.

**Not typed**: the spectrum of `ℂℙᵐ`'s Weyl tensor and its value `θ`, which are the record's, and
`P(W) = θ` at a unit critical point, which puts `θ` where `E = P - (3/2) tr W³` has `P` (r1853).
-/

/-- The squared norm of the scaled spectrum. -/
theorem cp_norm (m : ℝ) :
    (2 * (m ^ 2 - 1)) ^ 2 + (m ^ 2 - 1) * (m - 2) ^ 2 + (m ^ 2 - m) * (m + 1) ^ 2
      = 3 * m * (m ^ 2 - 1) * (2 * m - 1) := by
  ring

/-- The cube sum of the scaled spectrum. -/
theorem cp_cube (m : ℝ) :
    (2 * (m ^ 2 - 1)) ^ 3 + (m ^ 2 - 1) * (m - 2) ^ 3 + (m ^ 2 - m) * (-(m + 1)) ^ 3
      = (m ^ 2 - 1) * (8 * (m ^ 2 - 1) ^ 2 + (m - 2) ^ 3 - m * (m + 1) ^ 2) := by
  ring

/-- **THE POLYNOMIAL IDENTITY.** `(m+1)(2m-1) N - (3/2) K = (9/2) N`. -/
theorem cp_E_poly (m : ℝ) :
    (m + 1) * (2 * m - 1) * (3 * m * (m ^ 2 - 1) * (2 * m - 1))
      - 3 / 2 * ((m ^ 2 - 1) * (8 * (m ^ 2 - 1) ^ 2 + (m - 2) ^ 3 - m * (m + 1) ^ 2))
      = 9 / 2 * (3 * m * (m ^ 2 - 1) * (2 * m - 1)) := by
  ring

/-- **`E(ℂℙᵐ)` IN CLOSED FORM.** With `N > 0`, `θ = (m+1)(2m-1)/√N` and `tr = K/(N√N)`,
`θ - (3/2) tr = 9/(2√N)`. -/
theorem cp_E (m : ℝ) (hN : 0 < 3 * m * (m ^ 2 - 1) * (2 * m - 1)) :
    (m + 1) * (2 * m - 1) / Real.sqrt (3 * m * (m ^ 2 - 1) * (2 * m - 1))
      - 3 / 2 * ((m ^ 2 - 1) * (8 * (m ^ 2 - 1) ^ 2 + (m - 2) ^ 3 - m * (m + 1) ^ 2)
          / ((3 * m * (m ^ 2 - 1) * (2 * m - 1)) * Real.sqrt (3 * m * (m ^ 2 - 1) * (2 * m - 1))))
      = 9 / (2 * Real.sqrt (3 * m * (m ^ 2 - 1) * (2 * m - 1))) := by
  set N := 3 * m * (m ^ 2 - 1) * (2 * m - 1) with hNdef
  have hs : 0 < Real.sqrt N := Real.sqrt_pos.2 hN
  have hpoly := cp_E_poly m
  rw [← hNdef] at hpoly
  field_simp
  linear_combination (2 : ℝ) * hpoly

/-- **THE TWO FORMS OF `θ`.** At `m ≥ 2`, `(m+1)(2m-1)/√N = √((m+1)(2m-1)/(3m(m-1)))` (r1853). -/
theorem cp_theta (m : ℝ) (hm : 2 ≤ m) :
    (m + 1) * (2 * m - 1) / Real.sqrt (3 * m * (m ^ 2 - 1) * (2 * m - 1))
      = Real.sqrt ((m + 1) * (2 * m - 1) / (3 * m * (m - 1))) := by
  have hN : 0 < 3 * m * (m ^ 2 - 1) * (2 * m - 1) := by
    have : 0 < m ^ 2 - 1 := by nlinarith
    have : 0 < 2 * m - 1 := by linarith
    positivity
  have ha : 0 < (m + 1) * (2 * m - 1) := by nlinarith
  rw [eq_comm, Real.sqrt_eq_iff_mul_self_eq_of_pos (div_pos ha (Real.sqrt_pos.2 hN))]
  rw [div_mul_div_comm, Real.mul_self_sqrt hN.le]
  have h1 : m - 1 ≠ 0 := by linarith
  have h2 : m ≠ 0 := by linarith
  have h3 : m + 1 ≠ 0 := by linarith
  have h4 : 2 * m - 1 ≠ 0 := by linarith
  have h5 : m ^ 2 - 1 ≠ 0 := by nlinarith
  field_simp
  ring

