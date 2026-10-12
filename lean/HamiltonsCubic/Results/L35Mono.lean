import HamiltonsCubic.Results.L35Reduce

set_option linter.style.longLine false

/-!
# L35's monotonicity step: `R(A, s, u) ≤ R₂(A, u) ≤ √(3/2)`

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L35, the middle of the proof:
`R(A, s, u) = A³ + min(A, √d)d + min(A, K₀√d)(s² − u) − s³ + 3bc(s + 2A)`, `bc = (s² − 1 + u)/2`, increases in
`s` up to the constraint `s² ≤ 2 − 2u`, where `b = c` and `R` is `R₂`:

- `R3_le_R2`: `R(A, s, u) − R(A, S, u) = −(S − s)·[m₂(S + s) + ½(S² + Ss + s²) + 3A(S + s) + (3/2)(u − 1)]` with the
  bracket nonnegative exactly because `bc ≥ 0`;
- `R3_le`: with [L35Reduce.lean](L35Reduce.lean)'s `R2_le`, `R(A, s, u) ≤ √(3/2)` on the chain's domain.
-/

namespace HamiltonsCubic.L35Residual

/-- `R(A, s, u)`, REVIEW_r63's three-parameter relaxation, `u = A² + d`, `bc = (s² − 1 + u)/2`. -/
noncomputable def R3 (A s d : ℝ) : ℝ :=
  A ^ 3 + min A (Real.sqrt d) * d + min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) * (s ^ 2 - (A ^ 2 + d))
    - s ^ 3 + 3 * ((s ^ 2 - 1 + (A ^ 2 + d)) / 2) * (s + 2 * A)

/-- **`R` increases in `s` up to the constraint `s² ≤ 2 − 2u`**, and at `s = √(2 − 2u)` it is `R₂`: so
`R(A, s, u) ≤ R₂(A, u)` whenever `bc ≥ 0` and `(b − c)² ≥ 0`. -/
theorem R3_le_R2 (A s d : ℝ) (hA : 0 ≤ A) (hs : 0 ≤ s)
    (hbc : 1 - (A ^ 2 + d) ≤ s ^ 2) (hbmc : s ^ 2 ≤ 2 - 2 * (A ^ 2 + d)) :
    R3 A s d ≤ R2 A d := by
  set S := Real.sqrt (2 - 2 * (A ^ 2 + d)) with hSdef
  have hu : A ^ 2 + d ≤ 1 := by nlinarith
  have hS2 : S ^ 2 = 2 - 2 * (A ^ 2 + d) := Real.sq_sqrt (by linarith)
  have hS0 : 0 ≤ S := Real.sqrt_nonneg _
  have hsS : s ≤ S := by
    rw [hSdef]; exact Real.le_sqrt_of_sq_le hbmc
  have hm2 : 0 ≤ min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) := le_min hA (by positivity)
  -- `R2` is `R` at `s = S`
  have hR2 : R2 A d = A ^ 3 + min A (Real.sqrt d) * d + min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) * (S ^ 2 - (A ^ 2 + d))
      - S ^ 3 + 3 * ((S ^ 2 - 1 + (A ^ 2 + d)) / 2) * (S + 2 * A) := by
    unfold R2
    rw [← hSdef]
    linear_combination (-(min A (3 / (2 * Real.sqrt 2) * Real.sqrt d)) - S / 2 - 3 * A) * hS2
  rw [hR2]
  unfold R3
  have hfac : (A ^ 3 + min A (Real.sqrt d) * d + min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) * (S ^ 2 - (A ^ 2 + d))
      - S ^ 3 + 3 * ((S ^ 2 - 1 + (A ^ 2 + d)) / 2) * (S + 2 * A))
      - (A ^ 3 + min A (Real.sqrt d) * d + min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) * (s ^ 2 - (A ^ 2 + d))
      - s ^ 3 + 3 * ((s ^ 2 - 1 + (A ^ 2 + d)) / 2) * (s + 2 * A))
      = (S - s) * (min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) * (S + s) + 1 / 2 * (S ^ 2 + S * s + s ^ 2) + 3 * A * (S + s)
          + 3 / 2 * ((A ^ 2 + d) - 1)) := by ring
  have hbr : 0 ≤ min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) * (S + s) + 1 / 2 * (S ^ 2 + S * s + s ^ 2) + 3 * A * (S + s)
      + 3 / 2 * ((A ^ 2 + d) - 1) := by
    nlinarith [mul_nonneg hm2 (add_nonneg hS0 hs), mul_nonneg hA (add_nonneg hS0 hs), mul_nonneg hS0 hs,
      mul_le_mul hsS hsS hs hS0]
  nlinarith [mul_nonneg (sub_nonneg.mpr hsS) hbr]

/-- **`R(A, s, u) ≤ √(3/2)`** on the chain's domain: `A > 0`, `d ≥ 0`, `s ≥ 0`, `bc ≥ 0`, `(b − c)² ≥ 0`. -/
theorem R3_le (A s d : ℝ) (hA : 0 < A) (hd : 0 ≤ d) (hs : 0 ≤ s)
    (hbc : 1 - (A ^ 2 + d) ≤ s ^ 2) (hbmc : s ^ 2 ≤ 2 - 2 * (A ^ 2 + d)) :
    R3 A s d ≤ Real.sqrt (3 / 2) :=
  le_trans (R3_le_R2 A s d hA.le hs hbc hbmc) (R2_le A d hA hd (by nlinarith))

end HamiltonsCubic.L35Residual
