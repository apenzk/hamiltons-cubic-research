import Mathlib.Tactic

/-!
# [I77](../../../plan.md), the dual bound's exact check at `n = 4`

[findings/diagonal-half.md](../../../findings/diagonal-half.md), the I77 dual block. LP duality
turns the triangle-type programme into a minimax. **The uniform `y, z` family below is a
strict SUB-family of the LP dual and NOT the dual itself**: at the padded competitor's
spectrum at `n = 12` it returns `221/√6 = 90.2229` where the LP optimum is `11/√6 = 4.4907`,
so nothing here is a one-dimensional reduction of the programme. Any `y, z` with
`λ_α λ_β λ_γ ≤ y + (z/3)(λ_α + λ_β + λ_γ)` at every triple of distinct indices gives
`θ ≤ ∑ λ³ + (n-2) N y`, the `z` term vanishing by trace-freeness.

At `n = 4` the balanced product `S² × S²` has normalised Weyl spectrum `1/√3` twice and
`-1/(2√3)` four times, and the dual witness is `z = 1/4`, `y = 1/(12√3)`. This file checks,
in exact arithmetic, that the spectrum is a trace-free unit vector, that the dual bound
evaluates to `θ₀(4) = √3/2`, and that two of the dual functions sit AT `y` there.

**The all-within class is EMPTY at `p = 2`**: its level set has multiplicity `2`, so a
triple of distinct within-factor indices does not exist and the constraint at it is vacuous.
The theorem about it below is a true arithmetic identity at a class that carries no `T`, and
the class that actually binds is the one-within-two-cross one. Dropping the empty class
leaves `y` and the optimum unchanged and costs `z = 1/4` its uniqueness, the minimax being
attained on all of `[-1/2, 1/4]`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

/-- `√3` is positive and squares to `3`, used throughout. -/
private theorem sqrt3_sq : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)

private theorem sqrt3_pos : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)

/-- **The spectrum is a unit vector**: `2 (1/√3)² + 4 (1/(2√3))² = 1`. -/
theorem dual_n4_unit_norm :
    2 * (1 / Real.sqrt 3) ^ 2 + 4 * (-(1 / (2 * Real.sqrt 3))) ^ 2 = 1 := by
  have h := sqrt3_sq; have hp := sqrt3_pos
  field_simp
  nlinarith [h, hp]

/-- **And it is trace-free**, which is what kills the `z` term in the dual pairing. -/
theorem dual_n4_trace_free :
    2 * (1 / Real.sqrt 3) + 4 * (-(1 / (2 * Real.sqrt 3))) = 0 := by
  have hp := sqrt3_pos
  have hne : Real.sqrt 3 ≠ 0 := ne_of_gt hp
  field_simp
  ring

/-- **The dual bound evaluates to `θ₀(4)` exactly.** `∑ λ³ = 1/(2√3)`, and adding
`(n-2) N y = 12 · 1/(12√3)` gives `√3/2`. -/
theorem dual_n4_bound_eq_theta0 :
    2 * (1 / Real.sqrt 3) ^ 3 + 4 * (-(1 / (2 * Real.sqrt 3))) ^ 3
        + 12 * (1 / (12 * Real.sqrt 3))
      = Real.sqrt 3 / 2 := by
  have h := sqrt3_sq; have hp := sqrt3_pos
  field_simp
  nlinarith [h, hp]

/-- **The all-within dual function sits at `y`**, at `z = 1/4`. *Its class is EMPTY at `p = 2`,
the level set having multiplicity two, so this is a true identity at a vacuous constraint
rather than an active one.* -/
theorem dual_n4_within_active :
    (1 / Real.sqrt 3) ^ 3 - (1 / 4 : ℝ) / 3 * (3 * (1 / Real.sqrt 3))
      = 1 / (12 * Real.sqrt 3) := by
  have h := sqrt3_sq; have hp := sqrt3_pos
  field_simp
  nlinarith [h, hp]

/-- **The all-cross triple IS active**, and it is one of the two that bind at `p = 2`:
`(-λ₋)³ - (z/3)(-3λ₋)` returns the same `y`. -/
theorem dual_n4_cross_active :
    (-(1 / (2 * Real.sqrt 3))) ^ 3 - (1 / 4 : ℝ) / 3 * (3 * (-(1 / (2 * Real.sqrt 3))))
      = 1 / (12 * Real.sqrt 3) := by
  have h := sqrt3_sq; have hp := sqrt3_pos
  field_simp
  nlinarith [h, hp]

/-- **The one-within-two-cross triple is the other binding class at `p = 2`**, and it is
constant in `z` there because `λ₊ - 2(-λ₋) = 0`: its dual function is `λ₊ λ₋²`, which is `y`.
*This is the class the empty all-within one was standing in for.* -/
theorem dual_n4_mixed_active :
    (1 / Real.sqrt 3) * (-(1 / (2 * Real.sqrt 3))) ^ 2 = 1 / (12 * Real.sqrt 3) := by
  have h := sqrt3_sq; have hp := sqrt3_pos
  field_simp
  nlinarith [h, hp]

/-! ## The identity at general `p`, which is what makes the agreement exact

With `D² = (p-1)(2p-1)` the balanced product's data are `P = 1/D`, `Q = (p-1)/(pD)`,
`∑ λ³ = 1/(pD)`, the dual witness is `y = (2p-3)/(2pD³)`, and `(n-2)N = 2p(p-1)(2p-1)`.
The bound is then `1/(pD) + (2p-3)/D`, and this is `D/p`, which is `θ₀(2p)`.
-/

/-- **The dual bound at the balanced product collapses to `D/p`**, where `D² = (p-1)(2p-1)`.
This is the algebraic heart of the exactness: the second term is `(2p-3)/D` and the two
together give `(2p-1)(p-1)/(pD) = D/p`. -/
theorem dual_balanced_collapses (p D : ℝ) (hp : p ≠ 0) (hD : D ≠ 0)
    (hD2 : D ^ 2 = (p - 1) * (2 * p - 1)) :
    1 / (p * D) + (2 * p - 3) / D = D / p := by
  field_simp
  nlinarith [hD2]

/-- **And `θ₀(2p) = D/p`**, so the bound is exactly the conjectured value at every `p`. -/
theorem theta0_eq_D_div_p (p D : ℝ) (hp : 0 < p) (hD : 0 ≤ D)
    (hD2 : D ^ 2 = (p - 1) * (2 * p - 1)) :
    Real.sqrt (2 * (2 * p - 1) * (2 * p - 2)) / (2 * p) = D / p := by
  have h4 : 2 * (2 * p - 1) * (2 * p - 2) = (2 * D) ^ 2 := by nlinarith [hD2]
  rw [h4, Real.sqrt_sq (by positivity)]
  field_simp

end HamiltonsCubic.Results
