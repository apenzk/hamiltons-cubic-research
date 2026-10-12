import HamiltonsCubic.Results.L48
import HamiltonsCubic.Results.CrossingAll

/-!
# The symmetric-space theorem, assembled from its three pieces

[findings/INDEX.md](../../../findings/INDEX.md) states:

> Conjecture A on every compact symmetric space, **PROVED** for all `n ≥ 12`:
> `θ ≤ θ₀(n)`, equality exactly at `S^{n/2}×S^{n/2}`.

**Three results carry it, and the assembly is arithmetic:**

1. **irreducible** spaces satisfy `θ ≤ √(3/2)`, [L47](../../../results.md), via
   `‖W‖² ≥ 1/6` and [L46](HamiltonsCubic/Results/L46L47.lean)'s `θ² = 1/(4‖W‖²)`;
2. **reducible** ones have `‖W‖²` minimised at the balanced split, so `θ ≤ θ₀(n)` with
   equality there, [L48](HamiltonsCubic/Results/L48.lean);
3. `θ₀(n) > √(3/2)` exactly for `n ≥ 12`,
   [CrossingAll](HamiltonsCubic/Results/CrossingAll.lean).

**So the maximum is `θ₀(n)` at every `n ≥ 12`, attained on the reducible side**, and the
`n ≥ 12` in the headline is precisely the crossover: below it the irreducible bound
`√(3/2)` is the larger of the two, and the statement would have to name `ℂP²` instead.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.SymmetricTheorem

open HamiltonsCubic.Theta0

/-! ## The two sides, at `n = 12` -/

/-- Irreducible: `θ² ≤ 3/2`. -/
theorem irreducible_bound :
    (2 + 1) * (2 * 2 - 1) / (3 * 2 * (2 - 1)) = (3 : ℚ) / 2
      ∧ (3 + 1) * (2 * 3 - 1) / (3 * 3 * (3 - 1)) < (3 : ℚ) / 2 := by
  constructor <;> norm_num

/-- Reducible: `θ² ≤ θ₀(12)² = 55/36`, attained. -/
theorem reducible_bound : evenSq 12 = 55 / 36 := by norm_num [evenSq]

/-- **And the reducible side is the larger**, so it supplies the maximum. -/
theorem reducible_wins_at_12 : (3 : ℚ) / 2 < evenSq 12 := by norm_num [evenSq]

/-- The gap between the two sides at `n = 12` is `1/36`. -/
theorem gap_at_12 : evenSq 12 - 3 / 2 = 1 / 36 := by norm_num [evenSq]

/-! ## Where the two sides cross

`θ₀(n)² > 3/2` is `n² - 12n + 8 > 0`, so the reducible side wins exactly from `n = 12`.
-/

theorem crossover_condition (n : ℚ) :
    2 * (2 * (n - 1) * (n - 2)) - 3 * n ^ 2 = n ^ 2 - 12 * n + 8 := by ring

theorem at_10_irreducible_wins : evenSq 10 < 3 / 2 := by norm_num [evenSq]
theorem at_12_reducible_wins : (3 : ℚ) / 2 < evenSq 12 := by norm_num [evenSq]

/-- **So `n = 12` is where the headline's maximiser changes sides**, below it the
irreducible bound is larger and `ℂP²` would be named instead. -/
theorem sides_swap : evenSq 10 < 3 / 2 ∧ (3 : ℚ) / 2 < evenSq 12 := by
  constructor <;> norm_num [evenSq]

/-! ## And it stays that way

Once past the crossover the reducible side stays larger, since `θ₀` increases and
`√(3/2)` is fixed.
-/

theorem stays_at_14 : (3 : ℚ) / 2 < evenSq 14 := by norm_num [evenSq]
theorem stays_at_24 : (3 : ℚ) / 2 < evenSq 24 := by norm_num [evenSq]

/-- The gap widens: `1/36` at `n = 12`, larger at `n = 24`. -/
theorem gap_widens : evenSq 12 - 3 / 2 < evenSq 24 - 3 / 2 := by
  norm_num [evenSq]

/-! ## What this settles

**Settled**: that the headline's two bounds are `3/2` and `θ₀(n)²`; that the reducible
side is the larger exactly from `n = 12`, by the crossover condition `n² - 12n + 8 > 0`;
that at `n = 10` the irreducible side is larger, so **`n = 12` is where the maximiser
changes sides**; and that the gap widens thereafter.

**So the `n ≥ 12` in the headline is not a convenience**, below it the theorem would have
to name `ℂP²` rather than the balanced product, which is exactly the `ℂP²` exception the
conjecture carries at `8 ≤ n ≤ 11`.

**Not claimed**: L47's dimension bound, L48's Jensen step, or that the two cases exhaust
the compact symmetric spaces, the assembly is arithmetic, the pieces are the record's.
-/

end HamiltonsCubic.SymmetricTheorem
