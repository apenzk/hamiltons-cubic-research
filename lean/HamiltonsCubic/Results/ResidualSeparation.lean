import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L102's four numbers, what they establish jointly, and which way they trend

[route-a.md](../../../findings/route-a.md)'s Observation L102 prints residuals
`2.2`, `7.5`, `8.5 × 10⁻¹⁵` at `n = 12, 14, 16` *"against a control of `0.33`"*. The
annihilation-versus-orthogonality distinction and the sampling limitation are settled in
[L102](L102.lean); what the four numbers say together is not.

**The control is what makes the residuals evidence.** A residual near zero means nothing without
a scale for a non-vanishing quantity, and `0.33` supplies it. Jointly the four give a separation
of **more than thirteen orders of magnitude** at every dimension measured, at `n = 12` more than
fourteen. That is what the measurement establishes, and the block states the numbers without
stating it.

**But the separation narrows as `n` grows.** The residuals increase, `2.2 → 7.5 → 8.5`, so the
margin falls from over fourteen orders at `n = 12` to under fourteen at `n = 16`. Still enormous;
**the direction is the point**, since the claim is wanted at every `n ≥ 12` and the evidence for
it weakens with each dimension tested. Three points do not establish a trend, and none is
asserted here beyond the ordering of the three recorded values.

*Whether the growth is accumulating floating-point error or a real effect is not decidable from
three figures, and the block offers no error model.*
-/

namespace HamiltonsCubic.ResidualSeparation

/-! ## The separation -/

/-- **At every dimension measured the separation exceeds thirteen orders**: `10¹³` times the
largest residual is still below the control. -/
theorem separation_exceeds_thirteen_orders :
    (10 : ℚ) ^ 13 * (85 / 10 ^ 16) < 33 / 100 := by norm_num

/-- **At `n = 12` it exceeds fourteen**, the residual being `2.2`. -/
theorem separation_at_twelve : (10 : ℚ) ^ 14 * (22 / 10 ^ 16) < 33 / 100 := by norm_num

/-- **And at `n = 16` it does not**, so the margin has crossed an order between the two. -/
theorem separation_at_sixteen : (33 : ℚ) / 100 < (10 : ℚ) ^ 14 * (85 / 10 ^ 16) := by norm_num

/-! ## The trend -/

/-- **The residuals increase across the three dimensions.** -/
theorem residuals_increase :
    (22 : ℚ) / 10 < 75 / 10 ∧ (75 : ℚ) / 10 < 85 / 10 := by
  constructor <;> norm_num

/-- So the separation narrows: the ratio to the control falls from `n = 12` to `n = 16` by a
factor of nearly four. -/
theorem separation_narrows :
    (3 : ℚ) < (85 : ℚ) / 22 ∧ (85 : ℚ) / 22 < 4 := by
  constructor <;> norm_num

/-- The control itself is far from zero, which is what makes it a control: it exceeds every
residual by the separation above, and exceeds `1/4`. -/
theorem control_is_substantial : (1 : ℚ) / 4 < 33 / 100 := by norm_num

/-! ## What the separation does not reach -/

/-- **A separation at three points bounds nothing at a fourth.** The residuals certify
`n = 12, 14, 16`; the claim is wanted at every `n ≥ 12`, and no margin however large at three
dimensions constrains the rest. -/
theorem three_points_bound_nothing_further :
    ∃ f : ℕ → ℚ, f 12 = 0 ∧ f 14 = 0 ∧ f 16 = 0 ∧ f 18 = 1 := by
  refine ⟨fun n => if n = 18 then 1 else 0, ?_, ?_, ?_, ?_⟩ <;> norm_num

end HamiltonsCubic.ResidualSeparation
