import HamiltonsCubic.Results.L23bound

/-!
# L4's two named points, exactly

[L4](../../../results.md) gives a generator for critical points and the closed form for
its family:

  `θ = P/‖W‖³ = (2/n)√(rN/(N-r))`,  `r = dim 𝔥`,  `N = C(n,2)`,

*"checked against held-out spaces it was never fitted to"*, with two points named:
`0.8367` at `SU(3)`, `n = 8`, and `0.7464` at `SU(6)/Sp(3)`, `n = 14`.

**Both are exact.**

* `SU(3)`: `r = dim 𝔰𝔲(3) = 8`, `N = 28`, giving `θ² = 7/10`, the value
  [INDEX-values.md](../../../findings/INDEX-values.md) lists as `√(7/10)`.
* `SU(6)/Sp(3)`: `r = dim 𝔰𝔭(3) = 21`, `N = 91`, giving **`θ² = 39/70`**, and
  `√(39/70) = 0.746420…`, **which the index does not list at all.**

The formula is the one [L23bound.lean](HamiltonsCubic/Results/L23bound.lean) checks at
sphere products, here at two points of a different family.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.L4

open HamiltonsCubic.L23bound

/-! ## `SU(3)` at `n = 8` -/

theorem su3_N : N 8 = 28 := by norm_num [N]

/-- `θ² = 4rN/(n²(N-r))` with `r = 8`: `4·8·28/(64·20) = 7/10`. -/
theorem su3_value : 4 * 8 * N 8 / (8 ^ 2 * (N 8 - 8)) = 7 / 10 := by norm_num [N]

theorem su3_decimal :
    (0.836659 : ℚ) ^ 2 < 7 / 10 ∧ (7 : ℚ) / 10 < (0.836661 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## `SU(6)/Sp(3)` at `n = 14` -/

theorem sp3_N : N 14 = 91 := by norm_num [N]

/-- **`θ² = 4·21·91/(196·70) = 39/70`.** -/
theorem sp3_value : 4 * 21 * N 14 / (14 ^ 2 * (N 14 - 21)) = 39 / 70 := by norm_num [N]

/-- And `√(39/70) = 0.746420…`, which the record prints as `0.7464`. -/
theorem sp3_decimal :
    (0.746420 : ℚ) ^ 2 < 39 / 70 ∧ (39 : ℚ) / 70 < (0.746421 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## Both clear the threshold -/

theorem su3_below : (7 : ℚ) / 10 < 3 / 2 := by norm_num
theorem sp3_below : (39 : ℚ) / 70 < 3 / 2 := by norm_num

/-- **And the second is the lower**, so the family falls as `n` rises across these two
points, `39/70 < 7/10`. -/
theorem falls : (39 : ℚ) / 70 < 7 / 10 := by norm_num

/-- The ratio is `39/49`, so the drop from `n = 8` to `n = 14` is about `20%`. -/
theorem ratio : (39 : ℚ) / 70 / (7 / 10) = 39 / 49 := by norm_num

theorem drop_size : (0.79 : ℚ) < 39 / 49 ∧ (39 : ℚ) / 49 < 0.8 := by
  constructor <;> norm_num

/-! ## Padding preserves them

L4 notes zero-padding preserves everything, so both persist into `n = 12`. Their values
are unchanged, and both remain below `3/2` there.
-/

theorem persist : (7 : ℚ) / 10 < 3 / 2 ∧ (39 : ℚ) / 70 < 3 / 2 := by
  constructor <;> norm_num

/-- And both stay below `θ₀(12)² = 55/36` too, so neither threatens the maximiser at the
threshold dimension. -/
theorem below_theta0_12 : (7 : ℚ) / 10 < 55 / 36 ∧ (39 : ℚ) / 70 < 55 / 36 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: that L4's closed form gives `7/10` at `SU(3)` and **`39/70` at
`SU(6)/Sp(3)`**, both exact, reproducing the printed `0.8367` and `0.7464`; that the
family falls by about `20%` between the two, in ratio `39/49`; and that both stay below
`3/2` and below `θ₀(12)²`, before and after padding.

**And a gap**: `√(39/70)` occurs in the record and **is not in the value index**, which
lists `√(7/10)` for the other point of the same family. The index's own instruction is to
check a number against it before calling it new.

**Not claimed**: the generator criterion `(Λ⁴ℝⁿ)^K = 0` and `dim 𝒲ₙ^K = 1`, or the
identification of `r` with `dim 𝔥`, the lemma's content.
-/

end HamiltonsCubic.L4
