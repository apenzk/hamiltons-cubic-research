import HamiltonsCubic.Results.SphereProducts

/-!
# Every `θ(Sᵖ×S^q)` the record prints, checked against the closed form

A scan over [findings/](../../../findings/) and [results.md](../../../results.md) for
decimals printed near a sphere-product name surfaced `48` candidates. Most are other
quantities that happen to sit near the name, eigenvalues, residuals, gaps, `S` values,
because proximity is all a scan can see.

**Ten of them are `θ` values, and all ten reproduce exactly** from
`θ² = 2(p-1)(q-1)(n-1)/(pq(n-2))`. Four were already checked elsewhere; this file adds
the six that were not, including two the record prints only once.

**This is a negative result and worth recording as one**: the record's sphere-product
values are internally consistent wherever they appear, across nine files.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.SphereSweep

open HamiltonsCubic.SphereProducts

/-! ## The six not previously checked -/

/-- `S²×S⁴`, printed `0.968246`: exactly `15/16`. -/
theorem s2_s4 : thetaSq 2 4 = 15 / 16 := by norm_num [thetaSq]

/-- `S³×S⁹`, printed `1.14179`: exactly `176/135`. -/
theorem s3_s9 : thetaSq 3 9 = 176 / 135 := by norm_num [thetaSq]

/-- `S⁴×S⁸`, printed `1.20156`: exactly `231/160`. -/
theorem s4_s8 : thetaSq 4 8 = 231 / 160 := by norm_num [thetaSq]

/-- **`S⁵×S⁴³`, at `n = 48`**, the largest dimension the record evaluates the family at,
and it appears once. Exactly `7896/4945`. -/
theorem s5_s43 : thetaSq 5 43 = 7896 / 4945 := by norm_num [thetaSq]

/-- `S¹²×S¹²`, printed `1.325498`: exactly `253/144`. -/
theorem s12_s12 : thetaSq 12 12 = 253 / 144 := by norm_num [thetaSq]

/-- `S³×S⁷`, printed `1.133893`: exactly `9/7`. -/
theorem s3_s7 : thetaSq 3 7 = 9 / 7 := by norm_num [thetaSq]

/-! ## What the far point shows

`S⁵×S⁴³` sits at `n = 48`, far beyond the `n ≤ 24` the band tables cover, and is the one
place the record tests the family at scale. It is below `2`, as every member is, and
**below** the `n = 24` maximum, at twice the dimension, because it is extremely
unbalanced.
-/

theorem s5_s43_below_two : thetaSq 5 43 < 2 := by norm_num [thetaSq]

/-- **And below the `n = 24` maximum `253/144`, despite sitting at twice the dimension**
imbalance costs more than dimension gains. -/
theorem s5_s43_below_24 : thetaSq 5 43 < thetaSq 12 12 := by norm_num [thetaSq]

/-- Though it is **not** the balanced value at its own dimension: `S²⁴×S²⁴` is
`1081/576`, higher. The record's single far point is an unbalanced one. -/
theorem s24_s24 : thetaSq 24 24 = 1081 / 576 := by norm_num [thetaSq]

theorem s5_s43_below_balanced : thetaSq 5 43 < thetaSq 24 24 := by norm_num [thetaSq]

/-! ## The `2` ceiling, uniformly

Every value above is below `2`, and the closed form makes that general: `θ² < 2` reduces
to `(p-1)(q-1)(n-1) < pq(n-2)` with `n = p+q`, which expands to `n > 1` after
cancellation.
-/

theorem below_two_reduction (p q : ℚ) :
    p * q * (p + q - 2) - (p - 1) * (q - 1) * (p + q - 1)
      = p ^ 2 + q ^ 2 + p * q - 2 * p - 2 * q + 1 := by
  ring

/-- **And that is positive at every `p, q ≥ 2`**, so `θ² < 2` holds for the whole
family, the `√2` ceiling, uniformly, from one identity. -/
theorem below_two {p q : ℚ} (hp : 2 ≤ p) (hq : 2 ≤ q) :
    (p - 1) * (q - 1) * (p + q - 1) < p * q * (p + q - 2) := by
  nlinarith [mul_nonneg (sub_nonneg.mpr hp) (sub_nonneg.mpr hq)]

/-! ## What this settles

**Settled**: six more printed values as exact rationals, including the record's single
far point at `n = 48`; that the far point is below `2`, **below** the `n ≤ 24` maximum despite
sitting at twice the dimension, and below the balanced value at its own dimension,
*imbalance costs more than dimension gains.*

**The negative result**: of the ten `θ(Sᵖ×S^q)` values the scan surfaced across nine
files, **all ten reproduce exactly**. The record's sphere-product arithmetic is
internally consistent wherever it appears.

**Not claimed**: that the scan found every such value, proximity is all it can match, so
its recall is unknown. What is claimed is that everything it did surface checks.
-/

end HamiltonsCubic.SphereSweep
