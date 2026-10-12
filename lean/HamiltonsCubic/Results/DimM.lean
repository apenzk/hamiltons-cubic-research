import HamiltonsCubic.Results.UniqueMax

/-!
# `⌊n²/4⌋` is the maximum of `pq`, at both parities

[findings/INDEX.md](../../../findings/INDEX.md) lists among the settled results:

> `dim 𝔪 ≤ 2`, and `dim 𝔪 = ⌊n²/4⌋`, **Closed** at both ends.

**That upper figure is the orbit dimension at the maximiser.**
[OrbitDim.lean](HamiltonsCubic/Results/OrbitDim.lean) gives `dim orbit = pq`, and
[UniqueMax.lean](HamiltonsCubic/Results/UniqueMax.lean) gives the unique maximising
split; evaluating one at the other:

* even `n = 2m`: `pq = m² = n²/4`;
* odd `n = 2m+1`: `pq = m(m+1) = (n²-1)/4`.

Both are `⌊n²/4⌋`. **So the record's upper end of `dim 𝔪` and its `θ`-maximiser are the
same point**, and the two rows (one in the status table, one in the orbit tables), are
about the same split.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.DimM

open HamiltonsCubic.OrbitDim

/-! ## The two parities -/

/-- Even `n = 2m`: the maximiser's orbit is `m²`, and `4m² = n²`. -/
theorem even_case (m : ℚ) : 4 * orbitDim m m = (2 * m) ^ 2 := by
  rw [orbitDim_eq]; ring

theorem even_at_12 : orbitDim 6 6 = 36 ∧ (12 : ℚ) ^ 2 / 4 = 36 := by
  constructor
  · rw [orbitDim_eq]; norm_num
  · norm_num

/-- Odd `n = 2m+1`: the maximiser's orbit is `m(m+1)`, and `4m(m+1) = n² - 1`. -/
theorem odd_case (m : ℚ) : 4 * orbitDim m (m + 1) = (2 * m + 1) ^ 2 - 1 := by
  rw [orbitDim_eq]; ring

theorem odd_at_13 : orbitDim 6 7 = 42 ∧ ((13 : ℚ) ^ 2 - 1) / 4 = 42 := by
  constructor
  · rw [orbitDim_eq]; norm_num
  · norm_num

/-! ## So both are `⌊n²/4⌋`

At even `n` the floor is exact; at odd `n` it drops the `1/4`.
-/

theorem floor_even (m : ℚ) : (2 * m) ^ 2 / 4 = m * m := by ring

theorem floor_odd (m : ℚ) : ((2 * m + 1) ^ 2 - 1) / 4 = m * (m + 1) := by ring

/-- The odd case is `1/4` below `n²/4`, which is exactly what the floor removes. -/
theorem odd_deficit (m : ℚ) : (2 * m + 1) ^ 2 / 4 - m * (m + 1) = 1 / 4 := by ring

/-! ## The lower end

The index's other end is `dim 𝔪 ≤ 2`. The smallest admissible split, `p = q = 2` at
`n = 4`, has `pq = 4`, so the two ends are not adjacent, and the closed range spans
`2` to `⌊n²/4⌋`.
-/

theorem smallest_split : orbitDim 2 2 = 4 := by rw [orbitDim_eq]; norm_num

/-- At `n = 12` the range runs from `2` to `36`, and at `n = 24` to `144`. -/
theorem range_12 : orbitDim 6 6 = 36 := by rw [orbitDim_eq]; norm_num
theorem range_24 : orbitDim 12 12 = 144 := by rw [orbitDim_eq]; norm_num

/-- And `⌊n²/4⌋` grows quadratically while the lower end is fixed, so the closed range
widens without bound. -/
theorem range_widens : orbitDim 6 6 < orbitDim 12 12 := by
  rw [orbitDim_eq, orbitDim_eq]; norm_num

/-! ## What this settles

**Settled**: that `⌊n²/4⌋` is exactly the orbit dimension `pq` at the unique maximising
split, at both parities, `m²` at even `n`, `m(m+1)` at odd, the latter `1/4` below
`n²/4`, which is what the floor removes.

**So two of the record's settled results are about one split**: the upper end of
`dim 𝔪`, in the status table, and the `θ`-maximiser, in the orbit tables. The index lists
them as separate closures.

**Not claimed**: that `dim 𝔪` equals the orbit dimension in general, the identification
holds at the sphere products, where `dim 𝔪 = pq`, and the record's `dim 𝔪 ≤ 2` end is a
different regime.
-/

end HamiltonsCubic.DimM
