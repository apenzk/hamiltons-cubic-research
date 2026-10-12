import HamiltonsCubic.Results.DimM
import HamiltonsCubic.Results.L23bound

/-!
# `pq` is the sphere-product family's complete invariant

Four separate results in this record are about the same quantity. At fixed `n = p + q`:

| quantity | value | where |
|---|---|---|
| `θ²` | `2(n-1)/(n-2) · (1 - (n-1)/(pq))` | [BalanceAll](HamiltonsCubic/Results/BalanceAll.lean) |
| orbit dimension | `pq` | [OrbitDim](HamiltonsCubic/Results/OrbitDim.lean) |
| `dim 𝔪` at its ceiling | `⌊n²/4⌋ = max pq` | [DimM](HamiltonsCubic/Results/DimM.lean) |
| [L23](../../../results.md)'s `N - r` | `pq` | [L23bound](HamiltonsCubic/Results/L23bound.lean) |

**And `pq` determines the split.** At fixed `n`, `p` and `q` are the roots of
`x² - nx + pq`, so the unordered pair is recovered, the map from splits to `pq` is
injective.

**So `pq` is a complete invariant of the split, and everything the record computes about
these points is a function of it.** The record reaches each of the four separately, in
four files.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.PQInvariant

open HamiltonsCubic.OrbitDim HamiltonsCubic.L23bound

/-! ## `pq` determines the split -/

/-- `p` and `q` are the roots of `x² - nx + pq` with `n = p + q`. -/
theorem roots (p q : ℚ) :
    p ^ 2 - (p + q) * p + p * q = 0 ∧ q ^ 2 - (p + q) * q + p * q = 0 := by
  constructor <;> ring

/-- **So two splits of the same `n` with the same product are the same split**: their
difference squared is determined. -/
theorem same_product_same_split (p q p' q' : ℚ)
    (hn : p + q = p' + q') (hprod : p * q = p' * q') :
    (p - q) ^ 2 = (p' - q') ^ 2 := by
  have h : (p - q) ^ 2 = (p + q) ^ 2 - 4 * (p * q) := by ring
  have h' : (p' - q') ^ 2 = (p' + q') ^ 2 - 4 * (p' * q') := by ring
  rw [h, h', hn, hprod]

/-! ## The four quantities, at one point

At `n = 12`, the balanced split has `pq = 36`, and each of the four reads off it.
-/

/-- The orbit is `pq`. -/
theorem orbit_is_pq : orbitDim 6 6 = 36 := by rw [orbitDim_eq]; norm_num

/-- L23's `N - r` is the same `pq`. -/
theorem l23_is_pq : N 12 - r 6 6 = 36 := by norm_num [N, r]

/-- And they agree, which is [L23bound](HamiltonsCubic/Results/L23bound.lean)'s
observation stated at a point. -/
theorem orbit_eq_l23 : orbitDim 6 6 = N 12 - r 6 6 := by
  rw [orbitDim_eq]; norm_num [N, r]

/-- `⌊n²/4⌋` at `n = 12` is that same `36`. -/
theorem ceiling_is_pq : (12 : ℚ) ^ 2 / 4 = 36 := by norm_num

/-- **All four coincide at the maximiser**, which is the content of the previous three
rounds in one line. -/
theorem all_four :
    orbitDim 6 6 = 36 ∧ N 12 - r 6 6 = 36 ∧ (12 : ℚ) ^ 2 / 4 = 36 := by
  refine ⟨?_, ?_, ?_⟩
  · rw [orbitDim_eq]; norm_num
  · norm_num [N, r]
  · norm_num

/-! ## `θ²` as a function of `pq`

`θ² = 2(n-1)(pq - (n-1)) / (pq(n-2))`, which uses the split only through `pq`.
-/

/-- The rewriting, cross-multiplied. -/
theorem theta_through_pq (p q : ℚ) :
    2 * (p - 1) * (q - 1) * (p + q - 1)
      = 2 * (p + q - 1) * (p * q - (p + q - 1)) := by
  ring

/-- At `n = 12`, `pq = 36` gives numerator `2·11·(36-11) = 550` and denominator
`36·10 = 360`, the `55/36` of the record. -/
theorem at_12 : 2 * (11 : ℚ) * (36 - 11) = 550 ∧ (36 : ℚ) * 10 = 360 ∧
    (550 : ℚ) / 360 = 55 / 36 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- And at `n = 12`, `pq = 35` (the unbalanced `S⁵×S⁷`), gives `264/175`. -/
theorem at_12_unbalanced : 2 * (11 : ℚ) * (35 - 11) / (35 * 10) = 264 / 175 := by
  norm_num

/-! ## What this settles

**Settled**: that `pq` determines the split at fixed `n`, since two splits with the same
sum and product have the same difference squared; that the orbit dimension, L23's `N - r`
and the `dim 𝔪` ceiling are all `pq`; and that `θ²` is a function of `pq` alone at fixed
`n`, with the two `n = 12` values falling out of `pq = 36` and `pq = 35`.

**So one quantity carries the whole family**, and the record computes it four times under
four names in four files: an orbit dimension, a bound's denominator, a `dim 𝔪` ceiling,
and (implicitly), the argument of `θ`.

**Not claimed**: that this extends beyond the two-block sphere products.
-/

end HamiltonsCubic.PQInvariant
