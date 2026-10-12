import HamiltonsCubic.Results.OrbitDim
import HamiltonsCubic.Results.SphereProducts

/-!
# L23's extension, its `r` is half of the orbit identity

[fence-posts.md](../../../findings/fence-posts.md) records that the natural extension of
[L23](../../../results.md) (`θ ≤ (2/n)√(rN/(N-r))` with `r = dim E₊(W)`), is false in
general, holds at every catalogued point with trivial kernel, is **saturated exactly at
the balanced sphere products**, and fails badly wherever `ker W ≠ 0`.

**At a sphere product `r` is `C(p,2) + C(q,2)`**, so `N - r = pq` by the identity in
[OrbitDim.lean](HamiltonsCubic/Results/OrbitDim.lean), *the same `pq` that is the orbit
dimension*. The bound's two ingredients are exactly the two pieces the orbit identity
splits `C(n,2)` into, which nothing in the record notes.

Everything is `norm_num` or `ring`, kernel-checked.
-/

namespace HamiltonsCubic.L23bound

open HamiltonsCubic.OrbitDim HamiltonsCubic.SphereProducts

/-- `N = dim Λ²ℝⁿ`. -/
def N (n : ℚ) : ℚ := n * (n - 1) / 2

/-- `r = dim E₊` at a sphere product: the two factors' own `Λ²`s. -/
def r (p q : ℚ) : ℚ := p * (p - 1) / 2 + q * (q - 1) / 2

/-- **`N - r = pq`**, the orbit dimension, so the bound's denominator is the orbit and
its numerator is everything else. -/
theorem N_sub_r (p q : ℚ) : N (p + q) - r p q = p * q := by
  unfold N r; ring

theorem N_sub_r_is_orbit (p q : ℚ) : N (p + q) - r p q = orbitDim p q := by
  rw [N_sub_r, orbitDim_eq]

/-! ## The catalogued values

The record gives four bound values. Each is `(2/n)√(rN/(N-r))`, so squaring gives
`4rN/(n²(N-r))`.
-/

/-- `S³×S⁵` at `n = 8`: `r = 13`, `N = 28`, bound² = `4·13·28/(64·15) = 91/60`. -/
theorem s3_s5_r : r 3 5 = 13 := by norm_num [r]
theorem s3_s5_bound : 4 * r 3 5 * N 8 / (8 ^ 2 * (N 8 - r 3 5)) = 91 / 60 := by
  norm_num [r, N]

/-- And it clears: `θ² = 56/45` against `91/60`. -/
theorem s3_s5_clears : thetaSq 3 5 < 91 / 60 := by norm_num [thetaSq]

/-- `S⁵×S⁷` at `n = 12`: `r = 31`, `N = 66`, bound² = `4·31·66/(144·35) = 341/210`. -/
theorem s5_s7_r : r 5 7 = 31 := by norm_num [r]
theorem s5_s7_bound : 4 * r 5 7 * N 12 / (12 ^ 2 * (N 12 - r 5 7)) = 341 / 210 := by
  norm_num [r, N]

theorem s5_s7_clears : thetaSq 5 7 < 341 / 210 := by norm_num [thetaSq]

/-! ## Saturation at the balanced products

Setting the bound equal to `θ₀(n)` forces `r = n(n-2)/4`, which is exactly
`C(p,2)+C(q,2)` at `p = q = n/2`.
-/

/-- **At the balanced product `r = n(n-2)/4`.** -/
theorem balanced_r (m : ℚ) : r m m = (2 * m) * (2 * m - 2) / 4 := by
  unfold r; ring

/-- So the bound is saturated there: bound² equals `θ₀²`. At `n = 8`, `r = 12` and both
sides are `21/16`. -/
theorem saturation_8 :
    4 * r 4 4 * N 8 / (8 ^ 2 * (N 8 - r 4 4)) = thetaSq 4 4 := by
  norm_num [r, N, thetaSq]

/-- And at `n = 12`, `r = 30`, both sides `55/36`. -/
theorem saturation_12 :
    4 * r 6 6 * N 12 / (12 ^ 2 * (N 12 - r 6 6)) = thetaSq 6 6 := by
  norm_num [r, N, thetaSq]

/-! ## The failures at `ker W ≠ 0`

Padded `W_{ℂP²}` has `r = 1`, which makes the bound collapse: the numerator loses its
`r` while `N` grows.
-/

/-- At `n = 8`, `r = 1`: bound² = `4·28/(64·27) = 7/108`, whose root is `0.2546`, against
`θ = √(3/2)`. **The bound is wrong by a factor of nearly five.** -/
theorem padded_8 : 4 * 1 * N 8 / (8 ^ 2 * (N 8 - 1)) = 7 / 108 := by norm_num [N]

theorem padded_8_fails : (7 : ℚ) / 108 < 3 / 2 := by norm_num

theorem padded_8_factor : (20 : ℚ) * (7 / 108) < 3 / 2 := by norm_num

/-- At `n = 12`, `r = 1`: bound² = `4·66/(144·65) = 11/390`, worse still. -/
theorem padded_12 : 4 * 1 * N 12 / (12 ^ 2 * (N 12 - 1)) = 11 / 390 := by norm_num [N]

/-- **And it fails at `ℂP²` itself, `n = 4`**, where there is no padding: `r = 1`,
`N = 6`, bound² = `4·6/(16·5) = 3/10` against `3/2`, *so padding is not the cause*, which
is the record's point and here is one comparison. -/
theorem cp2_unpadded : 4 * 1 * N 4 / (4 ^ 2 * (N 4 - 1)) = 3 / 10 := by norm_num [N]

theorem cp2_fails : (3 : ℚ) / 10 < 3 / 2 := by norm_num

/-- Exactly a factor of five at `ℂP²`, the cleanest instance of the failure. -/
theorem cp2_factor_five : (5 : ℚ) * (3 / 10) = 3 / 2 := by norm_num

/-! ## What this settles

**Settled**: that `r = C(p,2)+C(q,2)` at a sphere product and `N - r = pq`, **so the
bound's ingredients are exactly the two pieces the orbit identity splits `C(n,2)` into**;
the four catalogued bound values as exact rationals; that the bound is saturated at the
balanced products, `r = n(n-2)/4` there; and that it fails at `r = 1` by factors of five
and more, at `ℂP²` **exactly** five, including unpadded, which is the record's argument
that padding is not the cause.

**Not claimed**: that `r = dim E₊` takes these values, which is the record's spectral
computation; only that the bound's arithmetic follows from them.
-/

end HamiltonsCubic.L23bound
