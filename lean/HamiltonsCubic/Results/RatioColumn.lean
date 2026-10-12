import HamiltonsCubic.Results.SphereProducts
import HamiltonsCubic.Results.C5Blowup

/-!
# The `θ/√(3/2)` column, exactly, and a cross-check between three tables

The same table in [target.md](../../../findings/target.md) carries a column of ratios
against the competitor's value: `1.0000, 0.8607, 0.9354, 0.9108, 0.9798, 0.8607,
0.8051, 0.5477`. Each is `θ/√(3/2)`, and squaring gives `2θ²/3`, rational wherever
`θ²` is.

Two of them are unexpectedly clean: `S⁴×S⁴` is exactly `√(7/8)` and `S⁵×S⁵` is exactly
`2√6/5`.

**And the last entry closes a loop.** The `C₅` blow-up's `θ = 0.670820` at `n = 10`
should be its ratio from [C5Blowup.lean](HamiltonsCubic/Results/C5Blowup.lean) times
`θ₀(10)` from [Theta0.lean](HamiltonsCubic/Results/Theta0.lean), two tables written for
different purposes, in different files, never checked against each other. They agree
exactly.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.RatioColumn

open HamiltonsCubic.SphereProducts HamiltonsCubic.C5Blowup HamiltonsCubic.Theta0

/-- The column's square: `(θ/√(3/2))² = 2θ²/3`. -/
def ratioSqOf (thetaSq : ℚ) : ℚ := 2 * thetaSq / 3

/-! ## The sphere-product rows -/

/-- `S³×S³`, printed `0.8607`: exactly `20/27` under the square. -/
theorem s3_s3 : ratioSqOf (thetaSq 3 3) = 20 / 27 := by norm_num [ratioSqOf, thetaSq]

/-- **`S⁴×S⁴`, printed `0.9354`: exactly `7/8`.** -/
theorem s4_s4 : ratioSqOf (thetaSq 4 4) = 7 / 8 := by norm_num [ratioSqOf, thetaSq]

/-- `S³×S⁵`, printed `0.9108`: exactly `112/135`. -/
theorem s3_s5 : ratioSqOf (thetaSq 3 5) = 112 / 135 := by norm_num [ratioSqOf, thetaSq]

/-- **`S⁵×S⁵`, printed `0.9798`: exactly `24/25`**, so the ratio is `2√6/5`. -/
theorem s5_s5 : ratioSqOf (thetaSq 5 5) = 24 / 25 := by norm_num [ratioSqOf, thetaSq]

/-- The competitor itself, printed `1.0000`: exactly `1`. -/
theorem competitor : ratioSqOf (3 / 2) = 1 := by norm_num [ratioSqOf]

/-! ## The `C₅` blow-up row, and the cross-check

[C5Blowup.lean](HamiltonsCubic/Results/C5Blowup.lean) gives `(θ/θ₀)² = 5/16` at `m = 2`,
that is `n = 10`; [Theta0.lean](HamiltonsCubic/Results/Theta0.lean) gives
`θ₀(10)² = 36/25`. Their product is the tabulated `θ² = 9/20`, whose root is `0.670820…`
the table's last entry.
-/

/-- **The two tables agree.** -/
theorem c5_crosscheck : ratioSq 2 * evenSq 10 = 9 / 20 := by
  norm_num [ratioSq, evenSq]

/-- And the column entry follows: `2/3 · 9/20 = 3/10`, so the printed `0.5477` is
`√(3/10)`. -/
theorem c5_column : ratioSqOf (9 / 20) = 3 / 10 := by norm_num [ratioSqOf]

/-- The blow-up's `θ²` is below the competitor's by a factor of more than three, the
column's `0.5477` against `1.0000`. -/
theorem c5_far_below : (3 : ℚ) * (9 / 20) < 3 / 2 := by norm_num

/-! ## The ordering the column records

Every sphere-product entry sits strictly below the competitor and strictly above the
blow-up, and the balanced products rise with `n`, so the column is a genuine ordering
rather than six separate measurements.
-/

theorem column_ordered :
    ratioSqOf (9 / 20) < ratioSqOf (thetaSq 3 3) ∧
    ratioSqOf (thetaSq 3 3) < ratioSqOf (thetaSq 4 4) ∧
    ratioSqOf (thetaSq 4 4) < ratioSqOf (thetaSq 5 5) ∧
    ratioSqOf (thetaSq 5 5) < ratioSqOf (3 / 2) := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [ratioSqOf, thetaSq]

/-- `S³×S⁵`, the one unbalanced row, sits between `S³×S³` and `S⁴×S⁴`, so the column
does not order by dimension. -/
theorem unbalanced_interleaves :
    ratioSqOf (thetaSq 3 3) < ratioSqOf (thetaSq 3 5) ∧
    ratioSqOf (thetaSq 3 5) < ratioSqOf (thetaSq 4 4) := by
  constructor <;> norm_num [ratioSqOf, thetaSq]

/-! ## What this settles

**Settled**: the whole ratio column as exact rationals under the square, including the
two clean ones, `7/8` at `S⁴×S⁴` and `24/25` at `S⁵×S⁵`; that the column is a strict
ordering; that the one unbalanced row interleaves, so the order is not by dimension; and
**that two tables written in different files for different purposes agree exactly** at
the `C₅` blow-up, which nothing in the record checks.

**Not settled here**: the `ℂP³` and `ℂP⁴` entries, whose `θ` values come from the
`ℂPᵐ` family and belong with [L38](HamiltonsCubic/Results/L38.lean).
-/

end HamiltonsCubic.RatioColumn
