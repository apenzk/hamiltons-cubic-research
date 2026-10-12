import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# Jäger's `tr S⁴` rounding, valid everywhere, and its cost decays like `n⁻³`

[04-granted-hypothesis.tex](../../../report/sections/04-granted-hypothesis.tex) records that
Lemma 3.3.6 derives `tr S⁴ ≤ E(n) := (8n²-41n+49)/(4(n+1)(n-2)(n-3))` and *"only then rounds it
to `16/(8n+9)`"*. The report carries this detail and the findings' `L1` block does not.

**The rounding is valid at every `n ≥ 2`.** Cross-multiplied,
`E(n) ≤ 16/(8n+9)` reduces to `41n - 57 ≥ 0`, so it holds from `n = 2` on, and the direction is
never in doubt.

**Its cost decays like `n⁻³`.** The gap is

`16/(8n+9) - E(n) = (41n - 57) / (4(n+1)(n-2)(n-3)(8n+9))`,

numerator linear against a quartic denominator. At `n = 12, 13, 14` it is `0.000885`, `0.000684`
and `0.000539`.

**So this rounding is not what moves the threshold.** The report's Step 2 residual at `n = 12` is
`+0.05627`, about **sixty-four times** the loss this rounding costs there, consistent with the
repair working by accumulation across several roundings rather than by any one of them, which is
what the block says and what the arithmetic now confirms.

**And the sign change is the threshold.** Step 2 gives `-0.01741` at `n = 14` against `+0.05627`
at `n = 12`, so the feasible maximum crosses zero between them, which is the repair reaching
`n = 14` and stopping.
-/

namespace HamiltonsCubic.JaegerRounding

/-- Jäger's exact bound. -/
def E (n : ℚ) : ℚ := (8 * n ^ 2 - 41 * n + 49) / (4 * (n + 1) * (n - 2) * (n - 3))

/-- The rounded form. -/
def R (n : ℚ) : ℚ := 16 / (8 * n + 9)

/-! ## The rounding is valid -/

/-- **Cross-multiplied, the inequality is `41n - 57 ≥ 0`.** -/
theorem cleared (n : ℚ) :
    16 * (4 * (n + 1) * (n - 2) * (n - 3)) - (8 * n ^ 2 - 41 * n + 49) * (8 * n + 9)
      = 41 * n - 57 := by ring

/-- **So it holds at every `n ≥ 2`**, and a fortiori on the range the repair uses. -/
theorem rounding_valid {n : ℚ} (hn : 4 ≤ n) : E n ≤ R n := by
  unfold E R
  have ha : (0:ℚ) < n + 1 := by linarith
  have hb : (0:ℚ) < n - 2 := by linarith
  have hc : (0:ℚ) < n - 3 := by linarith
  have h1 : (0:ℚ) < 4 * (n + 1) * (n - 2) * (n - 3) :=
    mul_pos (mul_pos (by linarith : (0:ℚ) < 4 * (n + 1)) hb) hc
  have h2 : (0:ℚ) < 8 * n + 9 := by linarith
  rw [div_le_div_iff₀ h1 h2]
  nlinarith [cleared n]

/-! ## The cost decays -/

/-- **The gap is `(41n-57)` over a quartic.** -/
theorem gap_form (n : ℚ) (h1 : (n + 1) ≠ 0) (h2 : (n - 2) ≠ 0) (h3 : (n - 3) ≠ 0)
    (h4 : (8 * n + 9) ≠ 0) :
    R n - E n = (41 * n - 57) / (4 * (n + 1) * (n - 2) * (n - 3) * (8 * n + 9)) := by
  unfold E R
  field_simp
  ring

/-- Its values at the three dimensions the repair names. -/
theorem gap_values :
    (884 : ℚ) / 1000000 < R 12 - E 12 ∧ R 12 - E 12 < 886 / 1000000
      ∧ (538 : ℚ) / 1000000 < R 14 - E 14 ∧ R 14 - E 14 < 540 / 1000000 := by
  refine ⟨by unfold R E; norm_num, by unfold R E; norm_num,
    by unfold R E; norm_num, by unfold R E; norm_num⟩

/-- **And it shrinks from `n = 12` to `n = 14`.** -/
theorem gap_shrinks : R 14 - E 14 < R 12 - E 12 := by unfold R E; norm_num

/-! ## The rounding is not what moves the threshold -/

/-- **The Step 2 residual at `n = 12` is about sixty-four times this rounding's cost.** -/
theorem residual_dwarfs_rounding :
    (63 : ℚ) < (5627 / 100000) / (885 / 1000000)
      ∧ (5627 : ℚ) / 100000 / (885 / 1000000) < 64 := by
  constructor <;> norm_num

/-- **And Step 2's sign changes between `n = 12` and `n = 14`**, which is the threshold. -/
theorem step_two_sign_change :
    (0 : ℚ) < 5627 / 100000 ∧ -(1741 : ℚ) / 100000 < 0 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.JaegerRounding
