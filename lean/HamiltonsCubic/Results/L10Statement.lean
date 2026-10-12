import Mathlib

/-!
# L10, the `ℂPᵐ` family's value

From [graded-half.md](../../../findings/graded-half.md), the block headed
*"Lemma L10, the one-parameter-per-factor families, two critical points each, and the `ℂPᵐ`
value"*, quoted so the Lean below can be read against it:

> **The $\mathbb{CP}^m$ family, $m\ge2$.** Its value is exact in closed form,
> $$\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)},$$
> **derived from Fox's norm identity** … It is strictly decreasing in `m`, the derivative's
> numerator is $-3(3m^2-2m+1)$, negative throughout, and falls to $2/3$, which it does not attain.
> **At $m=2$ it equals $\tfrac32$ exactly, so the family ATTAINS the threshold $\sqrt{3/2}$ rather
> than sitting below it**, and $W_{\mathbb{CP}^2}$ is that member. Every $m\ge3$ member is strictly
> below. **$m=1$ is inadmissible** (the denominator vanishes …) and $m\ge2$ is part of the
> statement.

**What is typed here is the closed form and the four claims made about it**, over `ℝ` with `m` real
and `2 ≤ m`, which is wider than the integers the family is indexed by and so is the safe direction.
*Fox's norm identity, which is where the closed form comes from, is upstream of this file and is
not restated in it.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L10

/-- `θ²` on the `ℂPᵐ` family. -/
noncomputable def thetaSq (m : ℝ) : ℝ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-- The denominator is positive from `m > 1`, which is what makes `m = 1` inadmissible. -/
theorem den_pos {m : ℝ} (hm : 2 ≤ m) : 0 < 3 * m * (m - 1) := by nlinarith

/-- **At `m = 2` the family ATTAINS the threshold**: `θ² = 3/2` exactly. -/
theorem thetaSq_two : thetaSq 2 = 3 / 2 := by norm_num [thetaSq]

/-- **Every `m > 2` member is strictly below the threshold.** *The gap is `5m² - 11m + 2`, whose
roots are `2` and `1/5`, so `m = 2` is exactly where it changes sign.* -/
theorem thetaSq_lt_three_halves {m : ℝ} (hm : 2 < m) : thetaSq m < 3 / 2 := by
  have hd : 0 < 3 * m * (m - 1) := by nlinarith
  rw [thetaSq, div_lt_iff₀ hd]
  nlinarith

/-- **`θ² > 2/3` at every admissible `m`**, so `2/3` is a lower bound the family never reaches. -/
theorem two_thirds_lt_thetaSq {m : ℝ} (hm : 2 ≤ m) : 2 / 3 < thetaSq m := by
  have hd : 0 < 3 * m * (m - 1) := den_pos hm
  rw [thetaSq, lt_div_iff₀ hd]
  nlinarith

/-- **Strictly decreasing in `m`.** -/
theorem thetaSq_strict_anti {a b : ℝ} (ha : 2 ≤ a) (hab : a < b) : thetaSq b < thetaSq a := by
  have hda : 0 < 3 * a * (a - 1) := den_pos ha
  have hdb : 0 < 3 * b * (b - 1) := den_pos (le_of_lt (lt_of_le_of_lt ha hab))
  have hb2 : (2:ℝ) ≤ b := le_of_lt (lt_of_le_of_lt ha hab)
  have key : (0:ℝ) < (b - a) * (3 * a * b - a - b + 1) :=
    mul_pos (sub_pos.mpr hab) (by nlinarith)
  rw [thetaSq, thetaSq, div_lt_div_iff₀ hdb hda]
  nlinarith [key]

/-- **The excess over `2/3` is exactly `(3m-1)/(3m(m-1))`**, which is the closed form of "falls to
`2/3`". -/
theorem thetaSq_sub {m : ℝ} (hm : 2 ≤ m) :
    thetaSq m - 2 / 3 = (3 * m - 1) / (3 * m * (m - 1)) := by
  have hm0 : m ≠ 0 := by intro h; rw [h] at hm; linarith
  have hm1 : m - 1 ≠ 0 := by intro h; nlinarith
  rw [thetaSq]
  field_simp
  ring

/-- **`θ²` falls to `2/3` at rate `1/(m-1)`**, so together with `two_thirds_lt_thetaSq` the value
approaches `2/3` from above without attaining it. -/
theorem thetaSq_le {m : ℝ} (hm : 2 ≤ m) : thetaSq m ≤ 2 / 3 + 1 / (m - 1) := by
  have h1 : (0:ℝ) < m - 1 := by linarith
  have hd : 0 < 3 * m * (m - 1) := den_pos hm
  rw [← sub_le_iff_le_add', thetaSq_sub hm, div_le_div_iff₀ hd h1]
  nlinarith

end HamiltonsCubic.L10
