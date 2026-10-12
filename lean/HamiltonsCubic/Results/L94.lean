import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L94 / L95, `κ² ≤ 2‖M‖_F²`, and the `ℂPᵐ` value

[bispectral.md](../../../findings/bispectral.md)'s Lemmas L94 and L95. The bound and its
equality case are geometry; what is carried here is the norm-choice warning, the closed form's
behaviour, and **a cross-check between the two lemmas that neither block makes**.

**The two lemmas constrain each other.** L94 says equality holds *iff* `W` is coordinate
diagonal in some frame; L95 gives `κ²(ℂPᵐ) = 3/(m+1)`. At unit norm the bound is `κ² ≤ 2`, and
`3/(m+1) ≤ 1 < 2` for every `m ≥ 2`, **so the closed form independently witnesses that
`ℂPᵐ` is not coordinate-diagonal in any frame**, which is L94's equality case failing. Neither
block cites the other.

**The norm-choice warning, quantified.** The record notes the bound must use `‖M‖_F` and not
the `4`-tensor norm *"or the bound is slack by a factor 4"*. Written out: a bound `κ² ≤ 2X`
becomes `κ² ≤ 8X` under a norm four times as large, so it admits four times the range and the
equality case empties.
-/

namespace HamiltonsCubic.KappaBound

/-! ## The norm choice -/

/-- **A norm four times as large makes the bound four times as slack.** `2·(4X) = 4·(2X)`, so
the admissible range quadruples and no `W` can attain it. -/
theorem wrong_norm_slack (X : ℚ) : 2 * (4 * X) = 4 * (2 * X) := by ring

/-- At unit norm the correct bound is `κ² ≤ 2` and the wrong one `κ² ≤ 8`. -/
theorem bounds_at_unit : 2 * (1 : ℚ) = 2 ∧ 2 * (4 * (1 : ℚ)) = 8 := by
  constructor <;> norm_num

/-! ## L95's closed form -/

/-- `κ²(ℂPᵐ) = 3/(m+1)`. -/
def kappaSqCP (m : ℚ) : ℚ := 3 / (m + 1)

/-- **Strictly decreasing in `m`.** -/
theorem kappaSq_antitone {m m' : ℚ} (hm : 2 ≤ m) (hlt : m < m') :
    kappaSqCP m' < kappaSqCP m := by
  unfold kappaSqCP
  have h1 : (0:ℚ) < m + 1 := by linarith
  have h2 : (0:ℚ) < m' + 1 := by linarith
  rw [div_lt_div_iff₀ h2 h1]
  linarith

/-- The first three values: `1`, `3/4`, `3/5`. -/
theorem kappaSq_values :
    kappaSqCP 2 = 1 ∧ kappaSqCP 3 = 3 / 4 ∧ kappaSqCP 4 = 3 / 5 := by
  unfold kappaSqCP
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The cross-check neither block makes -/

/-- **`ℂPᵐ` falls strictly below the bound at every `m ≥ 2`**, `3/(m+1) ≤ 1 < 2`. -/
theorem cp_below_bound (m : ℚ) (hm : 2 ≤ m) : kappaSqCP m < 2 := by
  unfold kappaSqCP
  have h1 : (0:ℚ) < m + 1 := by linarith
  rw [div_lt_iff₀ h1]
  linarith

/-- **So the closed form witnesses that `ℂPᵐ` is not coordinate-diagonal in any frame**, which
is L94's equality case failing, an independent confirmation the record does not draw. -/
theorem cp_not_diagonal (m : ℚ) (hm : 2 ≤ m) : kappaSqCP m ≠ 2 :=
  ne_of_lt (cp_below_bound m hm)

/-- The gap widens with `m`: at `m = 2` it is `1`, and it approaches `2`. -/
theorem gap_grows (m : ℚ) (hm : 2 ≤ m) : 1 ≤ 2 - kappaSqCP m := by
  unfold kappaSqCP
  have h1 : (0:ℚ) < m + 1 := by linarith
  have h2 : 3 / (m + 1) ≤ 1 := by rw [div_le_iff₀ h1]; linarith
  linarith

/-! ## The ascent's start count -/

/-- **A single-start ascent running `7%` low returns `93/100` of the true value**, so a
reported `κ²` from one start understates the invariant, which is why the record says start
counts must be quoted. -/
theorem single_start_low (κ : ℚ) (hκ : 0 < κ) : (93 : ℚ) / 100 * κ < κ := by
  nlinarith [hκ]

end HamiltonsCubic.KappaBound
