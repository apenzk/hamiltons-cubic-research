import HamiltonsCubic.Results.FamilyMeet

/-!
# Fox's constants, and the identity behind the `ℂPᵐ` family

[algebra.md](../../../findings/algebra.md) identifies `P` with the cubic form of Fox's
commutative nonassociative algebra and supplies two things Fox leaves open:

* **the Killing constant in closed form**, `κ_F(n) = (2n-1)(n-1)/4` in this project's
  Frobenius normalisation, or `(2n-1)(n-1)/16` in Fox's, *"whose metric is complete
  contraction, exactly `4×` Frobenius"*;
* the `ℂPᵐ` family as Fox's idempotents `Sʳ(α)`, with `|Sʳ|² = 6r(r-2)/((r+2)(r-1))` from
  his `(10.4)`, and `θ(Sʳ)² = 2(r+2)(r-1)/(3r(r-2))`.

**Those two expressions are reciprocal up to a factor of `4`.** Their product is exactly
`4` at every `r`, so `θ = 2/|Sʳ|`, which is why the record can say the family's values
*"follow from his norm identity with no numerics"*.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.FoxAlgebra

open HamiltonsCubic.FamilyMeet

/-- The Killing constant in Frobenius normalisation. -/
def kappaF (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 4

/-- **The two normalisations are consistent**: Fox's metric being `4×` Frobenius sends
`κ` to `κ/4`. -/
theorem normalisation (n : ℚ) : kappaF n / 4 = (2 * n - 1) * (n - 1) / 16 := by
  unfold kappaF; ring

/-- At `n = 4`, the one dimension Fox computes, `κ_F = 21/4`, or `21/16` in his. -/
theorem at_4 : kappaF 4 = 21 / 4 ∧ kappaF 4 / 4 = 21 / 16 := by
  constructor <;> norm_num [kappaF]

/-- It is quadratic and increasing: `κ_F(n+1) - κ_F(n) = n - 1/4`. -/
theorem step (n : ℚ) : kappaF (n + 1) - kappaF n = n - 1 / 4 := by
  unfold kappaF; ring

theorem values : kappaF 6 = 55 / 4 ∧ kappaF 12 = 253 / 4 := by
  constructor <;> norm_num [kappaF]

/-! ## The norm identity

`|Sʳ|² = 6r(r-2)/((r+2)(r-1))` and `θ(Sʳ)² = 2(r+2)(r-1)/(3r(r-2))`.
-/

def normSq (r : ℚ) : ℚ := 6 * r * (r - 2) / ((r + 2) * (r - 1))

def thetaSqR (r : ℚ) : ℚ := 2 * (r + 2) * (r - 1) / (3 * r * (r - 2))

/-- **The product is exactly `4`**, at every admissible `r`, stated cross-multiplied so
no side condition enters. -/
theorem product_identity (r : ℚ) :
    (6 * r * (r - 2)) * (2 * (r + 2) * (r - 1))
      = 4 * (((r + 2) * (r - 1)) * (3 * r * (r - 2))) := by
  ring

/-- The same at each tabulated `r`, in quotient form, `θ = 2/|Sʳ|`, which is the
record's *"with no numerics"*. -/
theorem product_at_4 : normSq 4 * thetaSqR 4 = 4 := by norm_num [normSq, thetaSqR]
theorem product_at_6 : normSq 6 * thetaSqR 6 = 4 := by norm_num [normSq, thetaSqR]
theorem product_at_8 : normSq 8 * thetaSqR 8 = 4 := by norm_num [normSq, thetaSqR]

/-! ## The family's values, from the identity

At `r = 2m` the `r`-form is the `m`-form, and the values follow.
-/

theorem r_equals_m (m : ℚ) :
    (2 * (2 * m + 2) * (2 * m - 1)) * (3 * m * (m - 1))
      = ((m + 1) * (2 * m - 1)) * (3 * (2 * m) * (2 * m - 2)) := by
  ring

theorem at_r4 : thetaSqR 4 = 3 / 2 := by norm_num [thetaSqR]
theorem at_r6 : thetaSqR 6 = 10 / 9 := by norm_num [thetaSqR]
theorem at_r8 : thetaSqR 8 = 35 / 36 := by norm_num [thetaSqR]
theorem at_r14 : thetaSqR 14 = 52 / 63 := by norm_num [thetaSqR]

/-- And the norms at those points: `|S⁴|² = 8/3`, so `θ² = 4/(8/3) = 3/2` at the
competitor. -/
theorem norm_at_4 : normSq 4 = 8 / 3 := by norm_num [normSq]

theorem competitor_from_norm : (4 : ℚ) / normSq 4 = 3 / 2 := by norm_num [normSq]

/-- The norm rises as `θ` falls, they are reciprocal, so the largest `θ` is the smallest
idempotent. -/
theorem norm_rises : normSq 4 < normSq 6 ∧ normSq 6 < normSq 8 := by
  constructor <;> norm_num [normSq]

/-! ## What this settles

**Settled**: that the two normalisations of `κ_F` are consistent under the stated `4×`
factor; its value at Fox's own `n = 4`; that it is quadratic with step `n - 1/4`; and
**that `|Sʳ|² · θ(Sʳ)² = 4` identically**, so `θ = 2/|Sʳ|` and the family's values follow
from the norm identity, the record's claim, here as one polynomial identity.

*A consequence worth naming*: since the two are reciprocal, **the largest `θ` is the
smallest idempotent**, so `ℂP²` maximises the family by having the least norm.

**Not claimed**: Fox's `(10.4)`, the identification of `P` with his cubic form, or the
closed form for `κ_F`, all the record's.
-/

end HamiltonsCubic.FoxAlgebra
