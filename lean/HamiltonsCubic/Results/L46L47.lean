import HamiltonsCubic.Results.L47

/-!
# L46 and L47 compose to `√(3/2)` exactly

[L46](../../../results.md) gives, for a compact locally symmetric Einstein space,

  `θ² = 1 / (4(‖R‖² - (tr R)²/N))`,  `N = C(n,2)`,

and [L47](../../../results.md) concludes from its dimension bound that `‖W‖² ≥ 1/6`,
*"i.e. `θ ≤ √(3/2)`"*.

**The "i.e." is a substitution, and it is exact.** With `θ² = 1/(4X)` decreasing in `X`,
`X ≥ 1/6` gives `θ² ≤ 1/(4/6) = 3/2`, **with equality precisely when `X = 1/6`**, which
is why the record can say equality holds only where `‖W‖² = 1/6` and identify that point
as `ℂP²`.

The two lemmas sit two files apart and neither performs the substitution.

Everything is `norm_num` or `nlinarith`, kernel-checked.
-/

namespace HamiltonsCubic.L46L47

/-- `θ²` as a function of `X = ‖W‖²` under L46's normalisation. -/
def thetaSqOf (X : ℚ) : ℚ := 1 / (4 * X)

/-! ## The substitution -/

/-- **`X = 1/6` gives exactly `3/2`.** -/
theorem at_sixth : thetaSqOf (1 / 6) = 3 / 2 := by norm_num [thetaSqOf]

/-- **And `θ²` is decreasing in `X`**, so `X ≥ 1/6` gives `θ² ≤ 3/2`. -/
theorem decreasing {X Y : ℚ} (hX : 0 < X) (hXY : X < Y) : thetaSqOf Y < thetaSqOf X := by
  unfold thetaSqOf
  have hY : 0 < Y := lt_trans hX hXY
  rw [div_lt_div_iff₀ (by linarith) (by linarith)]
  linarith

/-- **So the bound follows, with equality exactly at `X = 1/6`.** -/
theorem bound {X : ℚ} (hX : 1 / 6 ≤ X) (hpos : 0 < X) : thetaSqOf X ≤ 3 / 2 := by
  rcases eq_or_lt_of_le hX with h | h
  · rw [← h, at_sixth]
  · exact le_of_lt (by rw [← at_sixth]; exact decreasing (by norm_num) h)

/-- Conversely, `θ² = 3/2` forces `X = 1/6`, the equality case the record attributes to
`ℂP²`. -/
theorem equality_forces {X : ℚ} (hX : 0 < X) (h : thetaSqOf X = 3 / 2) : X = 1 / 6 := by
  unfold thetaSqOf at h
  field_simp at h
  linarith

/-! ## Values along the way

`X = 1/4` gives `1`, `X = 1/3` gives `3/4`, and `X = 1/2` gives `1/2`, so the bound is
attained only at the smallest admissible `‖W‖²`.
-/

theorem at_quarter : thetaSqOf (1 / 4) = 1 := by norm_num [thetaSqOf]
theorem at_third : thetaSqOf (1 / 3) = 3 / 4 := by norm_num [thetaSqOf]
theorem at_half : thetaSqOf (1 / 2) = 1 / 2 := by norm_num [thetaSqOf]

/-- **The competitor sits at the extreme of the admissible range**, not in its interior:
`ℂP²`'s `‖W‖² = 1/6` is the smallest value L47 permits. -/
theorem competitor_at_extreme : thetaSqOf (1 / 6) = 3 / 2 ∧ thetaSqOf (1 / 4) < 3 / 2 := by
  constructor <;> norm_num [thetaSqOf]

/-! ## The `N` in L46

`N = C(n,2) = n(n-1)/2`, so the subtracted term `(tr R)²/N` carries the same `n(n-1)/2`
that [OrbitDim](HamiltonsCubic/Results/OrbitDim.lean) and
[L23bound](HamiltonsCubic/Results/L23bound.lean) use.
-/

theorem N_at_12 : (12 : ℚ) * 11 / 2 = 66 := by norm_num
theorem N_at_16 : (16 : ℚ) * 15 / 2 = 120 := by norm_num

/-! ## What this settles

**Settled**: that L47's *"i.e."* is an exact substitution into L46's formula, `θ²` is
decreasing in `‖W‖²`, `1/6` gives exactly `3/2`, and equality forces `‖W‖² = 1/6`, which
is the equality case the record attributes to `ℂP²`; and that **the competitor sits at
the extreme of the admissible range rather than in its interior**, since `1/6` is the
smallest `‖W‖²` L47 permits.

**Not claimed**: L46's formula, L47's dimension bound, or the implication from the bound
to `‖W‖² ≥ 1/6`, all the record's, and the last is the step this file's chain rests on.
-/

end HamiltonsCubic.L46L47
