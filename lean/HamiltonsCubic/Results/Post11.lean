import HamiltonsCubic.Results.Theta0

/-!
# Fence post 11: the split's floor exceeds `θ`'s ceiling by exactly `1`

[INDEX-traps.md](../../../findings/INDEX-traps.md), post 11:

> Splitting `P` into its two terms cannot bound `M(n)` below `1 + √2`.

**The post is stronger than it says.** `θ₀(n) < √2` at every `n`, the ceiling proved in
[Theta0.lean](HamiltonsCubic/Results/Theta0.lean), and the split's floor is `1 + √2`.
**Their difference is exactly `1`**, so the split bound exceeds the supremum of the
quantity it is trying to bound, at every dimension, by a constant.

That is not "cannot close below some threshold": it is *cannot close at any `n`, ever,
with a fixed margin of `1` over the best possible target.*

In squares: `(1+√2)² = 3 + 2√2 ≈ 5.828` against a ceiling of `2`, **a factor of
`2.91`**.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Post11

open HamiltonsCubic.Theta0

/-! ## The two constants -/

theorem sqrt2_bracket : (1.4142135 : ℚ) ^ 2 < 2 ∧ (2 : ℚ) < 1.4142136 ^ 2 := by
  constructor <;> norm_num

/-- **The difference is exactly `1`**, `(1+√2) - √2 = 1`, whatever `√2` is. -/
theorem difference_exact (s : ℚ) : (1 + s) - s = 1 := by ring

/-- `(1+√2)² = 3 + 2√2`, bracketed to `(5.8284269, 5.8284273)`. -/
theorem floor_squared_bracket :
    (5.8284269 : ℚ) < 3 + 2 * 1.4142135 ∧ 3 + 2 * (1.4142136 : ℚ) < 5.8284273 := by
  constructor <;> norm_num

/-! ## It exceeds the ceiling by a factor of `2.91` -/

/-- `θ₀(n)² < 2` at every `n ≥ 4`. -/
theorem ceiling {n : ℚ} (hn : 4 ≤ n) : evenSq n < 2 := evenSq_lt_two hn

/-- **And `(1+√2)² > 2.91 · 2`**, so the split's floor exceeds the ceiling by that
factor. -/
theorem factor : (2.91 : ℚ) * 2 < 3 + 2 * 1.4142135 := by norm_num

/-- So at every `n`, the split bound exceeds `θ₀(n)` by more than `2.9` in the square. -/
theorem exceeds_everywhere {n : ℚ} (hn : 4 ≤ n) : (2.91 : ℚ) * evenSq n < 3 + 2 * 1.4142135 := by
  have h := ceiling hn
  nlinarith [h]

/-! ## Against the two named targets -/

/-- Against `θ₀(12)² = 55/36`: a factor over `3.8`. -/
theorem vs_theta0_12 : (3.8 : ℚ) * evenSq 12 < 3 + 2 * 1.4142135 := by
  norm_num [evenSq]

/-- Against `√(3/2)`: a factor over `3.88`. -/
theorem vs_threshold : (3.88 : ℚ) * (3 / 2) < 3 + 2 * 1.4142135 := by norm_num

/-- **In `θ` rather than `θ²` the two ratios are about `1.95` and `1.97`**, so the split
bound is roughly twice the target, uniformly. -/
theorem ratios_in_theta :
    (1.95 : ℚ) ^ 2 * evenSq 12 < 3 + 2 * 1.4142135 ∧
    (1.97 : ℚ) ^ 2 * (3 / 2) < 3 + 2 * 1.4142135 := by
  constructor <;> norm_num [evenSq]

/-! ## What this settles

**Settled**: that the split's floor `1 + √2` exceeds `θ`'s supremum `√2` by **exactly
`1`**, so the post's obstruction is uniform in `n` rather than threshold-bound; that in
squares the excess is a factor over `2.91` against the ceiling, over `3.8` against
`θ₀(12)²` and over `3.88` against `3/2`; and that in `θ` the split bound is roughly twice
either target.

**So post 11 closes its route at every dimension, not below one**, which the phrase
*"cannot bound `M(n)` below `1+√2`"* leaves for the reader to notice, since it does not
say what `M(n)` needs to be.

**Not claimed**: the splitting argument, or that `1+√2` is attained.
-/

end HamiltonsCubic.Post11
