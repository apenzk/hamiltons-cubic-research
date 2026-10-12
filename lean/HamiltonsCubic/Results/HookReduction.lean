import Mathlib

/-!
# The product step's hook direction, the monotonicity core

[reviews/2026-09-28-LIT-step8-sweep.md](../../../reviews/2026-09-28-LIT-step8-sweep.md), route R54
step 1.

**The source's statement.** At a diagonal part proportional to the balanced product `e`, on
`u = x e + y ν̂₀ + z Ẑ` with `x² + y² + z² = 1`,
`P(u) = d x³ + 3 c x z² + p z³ + 3 β y² z`, and when `β² ≤ d c` the maximum over the sphere is taken
at `y = 0`, on the circle through `e` and `Ẑ`.

**What is typed.** With `y²` eliminated, `G x z = d x³ + 3 c x z² + p z³ + 3 β z (1 - x² - z²)`
is nondecreasing in `x` when `β² ≤ d c` and `d > 0`, so on each chord of fixed `z` the largest
value is at the chord's right end, where `y = 0`.

**Not typed**: the reduced cubic itself, which rests on the parity `(-I_P, I_Q')` and on `L_e`
vanishing on the hooks.
-/

namespace HamiltonsCubic.HookReduction

/-- The cubic on the unit sphere with `y²` eliminated. -/
def G (d c p β x z : ℝ) : ℝ := d * x ^ 3 + 3 * c * x * z ^ 2 + p * z ^ 3 + 3 * β * z * (1 - x ^ 2 - z ^ 2)

/-- **THE HOOK MONOTONICITY.** When `β² ≤ d c` and `d > 0`, `G` is nondecreasing in `x`. -/
theorem G_mono (d c p β x x' z : ℝ) (hd : 0 < d) (hβ : β ^ 2 ≤ d * c) (hxx : x ≤ x') :
    G d c p β x z ≤ G d c p β x' z := by
  unfold G
  have key : 0 ≤ d * (x' ^ 2 + x' * x + x ^ 2) + 3 * c * z ^ 2 - 3 * β * z * (x + x') := by
    -- with s = x + x', the bracket is at least 3 ((d/4) s² - β z s + c z²) ≥ 0
    have h1 : d * (x' ^ 2 + x' * x + x ^ 2) ≥ 3 / 4 * d * (x + x') ^ 2 := by
      nlinarith [mul_nonneg hd.le (sq_nonneg (x' - x))]
    have h2 : 0 ≤ d / 4 * (x + x') ^ 2 - β * z * (x + x') + c * z ^ 2 := by
      have hdq : 0 ≤ (d * (x + x') - 2 * β * z) ^ 2 := sq_nonneg _
      have : 4 * d * (d / 4 * (x + x') ^ 2 - β * z * (x + x') + c * z ^ 2)
          = (d * (x + x') - 2 * β * z) ^ 2 + 4 * (d * c - β ^ 2) * z ^ 2 := by ring
      have h4 : 0 ≤ 4 * d * (d / 4 * (x + x') ^ 2 - β * z * (x + x') + c * z ^ 2) := by
        rw [this]; nlinarith [sq_nonneg z]
      exact (mul_nonneg_iff_of_pos_left (by linarith : (0:ℝ) < 4 * d)).mp h4
    nlinarith [h1, h2]
  have diff : d * x' ^ 3 + 3 * c * x' * z ^ 2 + p * z ^ 3 + 3 * β * z * (1 - x' ^ 2 - z ^ 2)
      - (d * x ^ 3 + 3 * c * x * z ^ 2 + p * z ^ 3 + 3 * β * z * (1 - x ^ 2 - z ^ 2))
      = (x' - x) * (d * (x' ^ 2 + x' * x + x ^ 2) + 3 * c * z ^ 2 - 3 * β * z * (x + x')) := by ring
  nlinarith [mul_nonneg (sub_nonneg.mpr hxx) key]

/-- Non-vacuity: the screened values at `S⁴ × S⁴` (`d ≈ 1.1456`, `c = d/3`, `β² = 3/8`) satisfy
`β² ≤ d c`, stated with the rational lower bound `d ≥ 1.145`. -/
example : (3 / 8 : ℝ) ≤ 1.145 * (1.145 / 3) := by norm_num

end HamiltonsCubic.HookReduction
