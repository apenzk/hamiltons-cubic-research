import Mathlib.Tactic.NormNum

/-!
# The bi-spectral joint body's accounting, checked

[bispectral.md](../../../findings/bispectral.md) gives the honest accounting for why a
moments-only bound fails:

> Bounding `p₃(μ)` and `p₃(ω)` separately by Okumura gives `4.013` at `n = 12` against
> `θ₀(12) = 1.236`, but that figure is a product of two marginal caps, and the marginals
> fall well short of them (`max(-p₃(ω)) = 2.405` against a cap of `5.094`). The
> relaxation over the true joint moment body is `2.291`, and the two marginal maxima are
> **not simultaneously attainable**, the joint maximum being `54%` of the marginal sum.

Three of the four quantitative claims check. **The fourth, the `54%`, does not reproduce
from the numbers in its own sentence** under any reading of *"marginal sum"* that this
file could form, the closest is `57%`. That is recorded as a question, not a verdict:
the reading may be one the sentence does not spell out.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.JointBody

/-! ## The separated bound is useless, by a factor of three -/

/-- `4.013` against `θ₀(12) = 1.236`: the separated bound exceeds the target it is meant
to beat by more than a factor of three. -/
theorem separated_useless : (3 : ℚ) * 1.236 < 4.013 := by norm_num

/-- And `θ₀(12)² = 55/36`, so `1.236` is that root to four places, the comparison is
against an exact number. -/
theorem theta0_12_bracket : (1.236 : ℚ) ^ 2 < 55 / 36 ∧ (55 : ℚ) / 36 < (1.2361 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## The `ω` marginal falls well short of its cap -/

/-- `2.405` against `5.094`: the attained marginal is under half its cap. -/
theorem omega_short : (2 : ℚ) * 2.405 < 5.094 := by norm_num

/-- Precisely, it is `47.2%` of the cap. -/
theorem omega_fraction : (0.472 : ℚ) * 5.094 < 2.405 ∧ (2.405 : ℚ) < 0.473 * 5.094 := by
  constructor <;> norm_num

/-! ## The joint relaxation against the separated figure -/

/-- `2.291` against `4.013`: the joint body's relaxation is `57%` of the separated
figure, and the gap between them is what obstructs a moments-only bound. -/
theorem joint_fraction :
    (0.570 : ℚ) * 4.013 < 2.291 ∧ (2.291 : ℚ) < 0.572 * 4.013 := by
  constructor <;> norm_num

/-- **Even the joint relaxation exceeds the target**, so tightening to the true body does
not close the route either: `2.291` against `1.236`. -/
theorem joint_still_useless : (1.236 : ℚ) < 2.291 := by norm_num

/-! ## The `54%` does not reproduce

Three readings of *"marginal sum"* were formed from the sentence's own numbers. None
gives `54%`.
-/

/-- Reading 1, the two caps as they enter `θ`, which is the `4.013` figure: `57.1%`. -/
theorem reading_one : (0.57 : ℚ) * 4.013 < 2.291 := by norm_num

/-- Reading 2, the two *attained* marginals, `1.4657 + 2.405/2 = 2.668`: `85.9%`. -/
theorem reading_two : (0.85 : ℚ) * 2.668 < 2.291 := by norm_num

/-- Reading 3, the caps unweighted, `0.977 + 5.094`: `37.7%`. -/
theorem reading_three : (2.291 : ℚ) < 0.38 * (0.977 + 5.094) := by norm_num

/-- **`54%` of the `4.013` figure would be `2.167`, not `2.291`**, a `5.7%` difference,
too large to be a rounding of either number as printed. -/
theorem fifty_four_would_give : (0.54 : ℚ) * 4.013 < 2.17 := by norm_num

theorem gap_too_large : (0.05 : ℚ) * 2.291 < 2.291 - 0.54 * 4.013 := by norm_num

/-! ## The majorization step, and a second percentage

The passage continues:

> Imposing the majorization constraint `ω ≻ d` cuts the relaxation to `2.947`,
> recovering some `58%` of the gap: the first coupling between the two spectra that
> demonstrably tightens the bound, and still a factor `2.4` short.

**The factor `2.4` checks.** `2.947 / 1.236 = 2.384`, which rounds to `2.4`.

**The `58%` does not**, by the same kind of failure as the `54%`: the gap from the
separated `4.013` down to the joint body's `2.291` is `1.722`, and `4.013 - 2.947 =
1.066` is `62%` of it, not `58%`. Measured against the gap to the target instead it is
`38%`.
-/

/-- **The factor `2.4` holds**: `2.947` against `θ₀(12) = 1.236`. -/
theorem factor_short : (2.38 : ℚ) * 1.236 < 2.947 ∧ (2.947 : ℚ) < 2.39 * 1.236 := by
  constructor <;> norm_num

/-- The recovered fraction of the separated-to-joint gap is `62%`, not `58%`. -/
theorem recovery_is_62 :
    (0.61 : ℚ) * (4.013 - 2.291) < 4.013 - 2.947 ∧
    (4.013 : ℚ) - 2.947 < 0.62 * (4.013 - 2.291) := by
  constructor <;> norm_num

/-- Measured against the gap to the target it is `38%`. -/
theorem recovery_vs_target :
    (0.38 : ℚ) * (4.013 - 1.236) < 4.013 - 2.947 ∧
    (4.013 : ℚ) - 2.947 < 0.39 * (4.013 - 1.236) := by
  constructor <;> norm_num

/-- Neither reading gives `58%`, and the miss is not a rounding: `58%` of the
separated-to-joint gap is `0.999`, against the actual `1.066`. -/
theorem fifty_eight_misses : (0.58 : ℚ) * (4.013 - 2.291) < 1.00 := by norm_num

/-- **And the majorization step leaves the bound above the joint-body relaxation**, so it
tightens the *separated* figure without reaching what the true body already gives:
`2.291 < 2.947`. -/
theorem majorization_above_joint : (2.291 : ℚ) < 2.947 := by norm_num

/-! ## What this settles

**Settled**: that the separated bound exceeds its target by over three; that the `ω`
marginal is under half its cap; that the joint relaxation is `57%` of the separated
figure and **still exceeds the target**, so tightening to the true body does not close
the route either, which is the passage's real point and is stronger than it says.

**Also settled**: the factor `2.4` after majorization, and that the majorization step
leaves the bound **above** the joint-body relaxation, it tightens the separated figure
without reaching what the true body already gives.

**Recorded as a question, not a verdict**: *two* percentages in this passage do not
reproduce from the numbers around them. The `54%` is nearest `57%`; the `58%` is `62%`
against the separated-to-joint gap and `38%` against the gap to the target. **Both are
audited figures** (the passage names the reviewers) so a reading neither sentence
spells out may resolve them, which is why this is queued for the verification loop rather
than filed as a defect here.
-/

end HamiltonsCubic.JointBody
