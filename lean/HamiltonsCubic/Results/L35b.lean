import HamiltonsCubic.Results.L71b
import HamiltonsCubic.Results.L30c
import HamiltonsCubic.Results.F53

/-!
# L35's coefficient check, and the bracket cap attained

L35 confirms its coefficient `3` at `(2,-1,-1)/√6`, *"where `Σλ³ = 1/√6` and
`3Tλ₁λ₂λ₃ = 2/√6` with `T = 2` sum to exactly `√(3/2)`"*.

**Unnormalised, those are `6` and `12`** (the `√6` divides out of both) and
they are exactly [F53](F53.lean)'s split: `tr(W³) = 6` and `⟨W,W#⟩ = 12`, summing
to `P = 18`. So L35's coefficient check and F53's sharp-term split are the same
two numbers reached from different directions.

**And `T = 2` is [L31](../../../findings/stratum-two-negative.md)'s bracket cap
attained.** `T_{αβγ} = ⟨[v_α,v_β],v_γ⟩²` on *unit* eigenvectors; the self-dual
forms have `‖a‖² = 2` each, so `T = ⟨[a,b],c⟩² / 8`, and the numerator is `16`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- **The bracket structure constant at the competitor**, squared so the sign
convention does not enter. -/
theorem sd_bracket_sq : (inner2 (br sdA sdB) sdC) ^ 2 = 16 := by
  simp only [inner2, br, sdA, sdB, sdC, basis4, phi, Matrix.mul_apply, Matrix.trace,
    Matrix.diag_apply, Fin.sum_univ_four, Matrix.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.transpose_apply, Matrix.of_apply, Matrix.smul_apply,
    Fin.ext_iff, Fin.isValue]
  norm_num [Fin.ext_iff]

/-- Each self-dual form has `‖·‖² = 2`, so the unit normalisation divides by
`8`. -/
theorem sdA_norm_sq : inner2 sdA sdA = 2 := by
  unfold inner2
  rw [_root_.mul_eq_one_comm.mp sdA_sq, Matrix.trace_one]
  norm_num

theorem sdB_norm_sq : inner2 sdB sdB = 2 := by
  unfold inner2
  rw [_root_.mul_eq_one_comm.mp sdB_sq, Matrix.trace_one]
  norm_num

theorem sdC_norm_sq : inner2 sdC sdC = 2 := by
  unfold inner2
  rw [_root_.mul_eq_one_comm.mp sdC_sq, Matrix.trace_one]
  norm_num

/-- **So `T = 2`**, which is the pair cap of L31 attained, the value L35's
coefficient check uses. -/
theorem T_eq_two : (16 : ℚ) / (2 * 2 * 2) = 2 := by norm_num

/-- And the coefficient check is [F53](F53.lean)'s split: `6 + 12 = 18`. -/
theorem coefficient_check :
    (WCP2 * WCP2 * WCP2).trace + (WCP2ᵀ * sharpMat WCP2).trace = 18 := by
  rw [WCP2_trace_cube, WCP2_sharp_pairing]
  norm_num

end HamiltonsCubic.Base
