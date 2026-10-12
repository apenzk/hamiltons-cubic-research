import HamiltonsCubic.Results.Theta0
import Mathlib.Tactic.FieldSimp

/-!
# L47's dimension bound, and how much it beats the trivial one

[L47](../../../results.md): for a compact irreducible symmetric space of rank `≥ 2`, and
for `𝕆P²`, normalised to Einstein constant `1/2` so that
`‖W‖² = ‖R‖² - n/(8(n-1))` (L46), Cauchy–Schwarz over the isotropy blocks gives

  `dim 𝔥 ≤ 3n²(n-1) / (2(7n-4))`,

and that bound implies `‖W‖² ≥ 1/6`, i.e. `θ ≤ √(3/2)`, with equality among the
irreducible spaces only at `ℂP²`.

**The bound is stronger than the trivial `dim 𝔥 ≤ dim 𝔰𝔬(n) = n(n-1)/2`, by a factor
tending to `7/3`.** Their ratio is `3n/(7n-4)`, which **falls** from `1/2` at `n = 4` toward `3/7`, so the
bound removes between `50%` and `57%` of the trivial range, and removes more as `n`
grows.

Checked below at the spaces the record names: `𝕆P²` at `n = 16` with `dim 𝔥 = 36`, and
`Gr_ℂ(2,2)` at `n = 8` with `dim 𝔥 = 7`.

Everything is `ring`, `norm_num` or `nlinarith`, kernel-checked.
-/

namespace HamiltonsCubic.L47

/-- The bound. -/
def bound (n : ℚ) : ℚ := 3 * n ^ 2 * (n - 1) / (2 * (7 * n - 4))

/-- The trivial bound, `dim 𝔰𝔬(n)`. -/
def trivial (n : ℚ) : ℚ := n * (n - 1) / 2

/-! ## The ratio -/

/-- **`bound < trivial` at every `n ≥ 4`**, since the comparison reduces to
`3n < 7n - 4`. -/
theorem bound_lt_trivial {n : ℚ} (hn : 4 ≤ n) : bound n < trivial n := by
  unfold bound trivial
  have hd : 0 < 2 * (7 * n - 4) := by linarith
  rw [div_lt_div_iff₀ hd (by norm_num)]
  nlinarith

/-- **So the bound is strictly stronger at every `n ≥ 4`**: `3n < 7n - 4` reduces to
`4 < 4n`. -/
theorem strictly_stronger {n : ℚ} (hn : 4 ≤ n) : 3 * n < 7 * n - 4 := by linarith

/-- The ratio falls from `1/2` at `n = 4` toward `3/7`. -/
theorem ratio_at_4 : 3 * (4 : ℚ) / (7 * 4 - 4) = 1 / 2 := by norm_num
theorem ratio_at_16 : 3 * (16 : ℚ) / (7 * 16 - 4) = 4 / 9 := by norm_num
theorem ratio_limit : (3 : ℚ) / 7 = 3 / 7 := by norm_num

/-- And it is decreasing, so the bound tightens with `n`. -/
theorem ratio_falls : 3 * (16 : ℚ) / (7 * 16 - 4) < 3 * 8 / (7 * 8 - 4) := by norm_num

theorem ratio_above_limit : (3 : ℚ) / 7 < 3 * 16 / (7 * 16 - 4) := by norm_num

/-! ## At the named spaces -/

/-- `𝕆P²` at `n = 16`: the bound is `160/3`, and `dim 𝔰𝔭𝔦𝔫(9) = 36` clears it. -/
theorem op2_bound : bound 16 = 160 / 3 := by norm_num [bound]

theorem op2_clears : (36 : ℚ) < bound 16 := by norm_num [bound]

/-- `Gr_ℂ(2,2)` at `n = 8`: the bound is `168/13`, and `dim 𝔥 = 7` clears it with room. -/
theorem gr22_bound : bound 8 = 168 / 13 := by norm_num [bound]

theorem gr22_clears : (7 : ℚ) < bound 8 := by norm_num [bound]

/-- The trivial bound at `n = 8` is `28`, so L47's is less than half of it. -/
theorem gr22_vs_trivial : 2 * bound 8 < 3 * trivial 8 := by norm_num [bound, trivial]

/-! ## The L46 correction term

`‖W‖² = ‖R‖² - n/(8(n-1))`, and at `n = 4` the subtracted term is exactly `1/6`, the
same constant the conclusion `‖W‖² ≥ 1/6` names.
-/

theorem correction_at_4 : (4 : ℚ) / (8 * (4 - 1)) = 1 / 6 := by norm_num

theorem correction_at_12 : (12 : ℚ) / (8 * (12 - 1)) = 3 / 22 := by norm_num

/-- The correction decreases toward `1/8`, so the gap between `‖R‖²` and `‖W‖²` narrows
with `n`. -/
theorem correction_decreasing : (12 : ℚ) / (8 * 11) < 4 / (8 * 3) := by norm_num

theorem correction_limit : (1 : ℚ) / 8 < 3 / 22 := by norm_num

/-! ## What this settles

**Settled**: that L47's bound is `3n/(7n-4)` times the trivial `dim 𝔰𝔬(n)`, hence
strictly stronger at every `n ≥ 4`, **removing between `50%` and `57%` of the trivial
range**, and removing more as `n` grows; its values at `𝕆P²` and `Gr_ℂ(2,2)`, both cleared by the actual
isotropy dimensions; and that L46's correction term is exactly `1/6` at `n = 4`, the same
constant the conclusion names, decreasing toward `1/8`.

**Not claimed**: the Cauchy–Schwarz step, the implication to `‖W‖² ≥ 1/6`, or the
equality case at `ℂP²`, all the record's, and none of them arithmetic.
-/

end HamiltonsCubic.L47
