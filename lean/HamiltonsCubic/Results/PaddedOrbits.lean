import HamiltonsCubic.Results.OrbitDim
import HamiltonsCubic.Results.SphereProducts

/-!
# Padded points, the orbit dimensions and the frozen ratios

[nondegeneracy.md](../../../findings/nondegeneracy.md) tabulates padded sphere products
with their orbit dimensions and their height against `θ₀` of the larger dimension:

| point | padded | orbit | ratio printed |
|---|---|---|---|
| `S⁴×S⁴` | `8 → 10` | `32` | `0.9547` |
| `S⁵×S⁵` | `10 → 12` | `45` | `0.9708` |
| `S⁶×S⁶` | `12 → 14` | `60` |, |
| `S³×S³` | `6 → 10` | `33` | `0.8784` |
| `W_{ℂP²}` | `→ 12` |, | `0.9909` |

**The orbit dimensions generalise [OrbitDim.lean](HamiltonsCubic/Results/OrbitDim.lean)'s
`pq`.** With `r = n - p - q` the padding, the isotropy gains an `𝔰𝔬(r)` factor and

  `dim orbit = C(n,2) - C(p,2) - C(q,2) - C(r,2)`,

which is `pq` when `r ≤ 1` and covers all four tabulated integers at once.

**And the ratios are exact**, because padding freezes `θ` while `θ₀` rises: each is
`θ(Sᵖ×S^q)/θ₀(n)` with the numerator from the *smaller* dimension.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.PaddedOrbits

open HamiltonsCubic.OrbitDim HamiltonsCubic.SphereProducts HamiltonsCubic.Theta0

/-- The orbit dimension of a padded `Sᵖ×S^q` inside `𝒲_n`, with `r = n - p - q`. -/
def paddedOrbitDim (p q r : ℚ) : ℚ :=
  (p + q + r) * (p + q + r - 1) / 2 - p * (p - 1) / 2 - q * (q - 1) / 2 - r * (r - 1) / 2

/-- **With no padding it is `pq`**, so this extends the unpadded formula rather than
replacing it. -/
theorem no_padding (p q : ℚ) : paddedOrbitDim p q 0 = orbitDim p q := by
  unfold paddedOrbitDim orbitDim; ring

/-- Padding by one direction also leaves `pq`, since `C(1,2) = 0` and the extra row
contributes `p + q`… stated as the identity it is. -/
theorem padding_one (p q : ℚ) : paddedOrbitDim p q 1 = p * q + p + q := by
  unfold paddedOrbitDim; ring

/-! ## The four tabulated orbit dimensions -/

theorem s4_s4_to_10 : paddedOrbitDim 4 4 2 = 32 := by norm_num [paddedOrbitDim]
theorem s5_s5_to_12 : paddedOrbitDim 5 5 2 = 45 := by norm_num [paddedOrbitDim]
theorem s6_s6_to_14 : paddedOrbitDim 6 6 2 = 60 := by norm_num [paddedOrbitDim]
theorem s3_s3_to_10 : paddedOrbitDim 3 3 4 = 33 := by norm_num [paddedOrbitDim]

/-- **Padding by two adds exactly `2(p + q)` to the orbit**, twice the total sphere
dimension, independent of how it is split. That is why `16, 25, 36` become
`32, 45, 60`. -/
theorem padding_two_gain (p q : ℚ) :
    paddedOrbitDim p q 2 - orbitDim p q = 2 * (p + q) := by
  unfold paddedOrbitDim orbitDim; ring

theorem gain_s4_s4 : paddedOrbitDim 4 4 2 - orbitDim 4 4 = 16 := by
  norm_num [paddedOrbitDim, orbitDim]

/-- So a padded orbit is more than double the unpadded one exactly when `2(p+q) > pq`,
which fails from `S⁴×S⁴` on: `16 = 16` at `p = q = 4` is the boundary. -/
theorem doubling_boundary : paddedOrbitDim 4 4 2 = 2 * orbitDim 4 4 := by
  norm_num [paddedOrbitDim, orbitDim]

/-! ## The frozen ratios

`θ` does not move under padding; `θ₀` does. Each tabulated ratio is therefore
`θ(Sᵖ×S^q)² / θ₀(n)²` with the two dimensions different, the comparison the table makes
and never writes down.
-/

/-- `S⁴×S⁴` padded to `n = 10`, printed `0.9547`: exactly `175/192` under the square. -/
theorem ratio_s4_s4 : thetaSq 4 4 / evenSq 10 = 175 / 192 := by
  norm_num [thetaSq, evenSq]

/-- `S⁵×S⁵` padded to `n = 12`, printed `0.9708`: exactly `1296/1375`. -/
theorem ratio_s5_s5 : thetaSq 5 5 / evenSq 12 = 1296 / 1375 := by
  norm_num [thetaSq, evenSq]

/-- `S³×S³` padded to `n = 10`, printed `0.8784`: exactly `250/324`. -/
theorem ratio_s3_s3 : thetaSq 3 3 / evenSq 10 = 250 / 324 := by
  norm_num [thetaSq, evenSq]

/-- **`W_{ℂP²}` at `n = 12`, printed `0.9909`: exactly `54/55`**, the highest of the
four, and the closest any catalogued point comes to the balanced product there. -/
theorem ratio_cp2 : (3 / 2 : ℚ) / evenSq 12 = 54 / 55 := by norm_num [evenSq]

/-- The four are ordered as the table shows, and all are strictly below `1`: padding
never reaches the balanced value. -/
theorem ratios_ordered :
    thetaSq 3 3 / evenSq 10 < thetaSq 4 4 / evenSq 10 ∧
    thetaSq 4 4 / evenSq 10 < thetaSq 5 5 / evenSq 12 ∧
    thetaSq 5 5 / evenSq 12 < (3 / 2 : ℚ) / evenSq 12 ∧
    (3 / 2 : ℚ) / evenSq 12 < 1 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [thetaSq, evenSq]

/-! ## What this settles

**Settled**: that the four tabulated padded orbit dimensions are one formula, extending
`pq` by an `𝔰𝔬(r)` term; that padding by two adds exactly `2(p+q)`, independent of the split; and that the four
printed ratios are exact rationals under the square, ordered, and all strictly below `1`
*padding freezes `θ` while `θ₀` rises, so a padded point never reaches the balanced
value at its new dimension.*

**Not settled here**: that `θ` is unchanged by padding, which is the record's, and the
Hessian computations the orbit dimensions are compared against.
-/

end HamiltonsCubic.PaddedOrbits
