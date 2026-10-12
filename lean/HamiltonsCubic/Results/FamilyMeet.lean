import HamiltonsCubic.Results.SphereProducts

/-!
# Where the two named families meet, exactly

The record carries two closed forms for `θ²`:

* `ℂPᵐ`, from [L28](../../../results.md): `(m+1)(2m-1) / (3m(m-1))`;
* `Sᵖ×S^q`, from [target.md](../../../findings/target.md):
  `2(p-1)(q-1)(n-1) / (pq(n-2))`.

They are stated in different files, for different purposes. Two coincidences follow from
evaluating one against the other, **and the first is already on the record**:
[INDEX-values.md](../../../findings/INDEX-values.md) lists `1.054093` as
*"`S³×S³` **and** `ℂP³`, `θ² = 10/9` for both, **exactly** (Reviewer 93)"*. What is
checked here is that value and the second coincidence:

* at `m = 2` the `ℂPᵐ` family is at `3/2`, the competitor's value, which is where the
  whole `√(3/2)` thread starts;
* at `m = 3` it is at `10/9`, **exactly** the balanced sphere product's value at `n = 6`.
  [nondegeneracy.md](../../../findings/nondegeneracy.md) says *"`ℂP³` sits exactly at
  `Θ₆`"*, and [INDEX-values.md](../../../findings/INDEX-values.md) records the shared
  `10/9` outright. **This file re-derives it from the two closed forms rather than
  discovering it.**

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.FamilyMeet

open HamiltonsCubic.SphereProducts

/-- `θ²` on the `ℂPᵐ` family. -/
def cpSq (m : ℚ) : ℚ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-! ## The competitor, at `m = 2` -/

/-- **`ℂP² ` is at `3/2`**, the value everything in this record is measured against. -/
theorem cp2 : cpSq 2 = 3 / 2 := by norm_num [cpSq]

/-! ## The coincidence at `n = 6`

`ℂP³` and `S³×S³` are different manifolds of the same dimension, and their `θ` agree.
-/

/-- `ℂP³` is at `10/9`. -/
theorem cp3 : cpSq 3 = 10 / 9 := by norm_num [cpSq]

/-- `S³×S³` is at `10/9`. -/
theorem s3_s3 : thetaSq 3 3 = 10 / 9 := by norm_num [thetaSq]

/-- **They are equal, the two closed forms meet exactly at `n = 6`.** -/
theorem meet_at_six : cpSq 3 = thetaSq 3 3 := by norm_num [cpSq, thetaSq]

/-! ## And they part immediately

At `n = 8` the two families differ: `ℂP⁴` is at `35/36` and `S⁴×S⁴` at `21/16`. So the
agreement at `n = 6` is a coincidence of values, not a relation between the families.
-/

theorem cp4 : cpSq 4 = 35 / 36 := by norm_num [cpSq]

theorem s4_s4 : thetaSq 4 4 = 21 / 16 := by norm_num [thetaSq]

/-- At `n = 8` the sphere product is strictly higher, and by a wide margin. -/
theorem part_at_eight : cpSq 4 < thetaSq 4 4 := by norm_num [cpSq, thetaSq]

/-- The gap at `n = 8` is exactly `49/144`, against a gap of `0` at `n = 6`. -/
theorem gap_at_eight : thetaSq 4 4 - cpSq 4 = 49 / 144 := by norm_num [cpSq, thetaSq]

/-! ## The `ℂPᵐ` family falls, the sphere products rise

Which is why they cross once. `ℂPᵐ` is decreasing from `m = 2`, sphere products
increasing in `n`, so the two orderings reverse at `n = 6` and never return.
-/

theorem cp_decreasing : cpSq 3 < cpSq 2 ∧ cpSq 4 < cpSq 3 ∧ cpSq 5 < cpSq 4 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [cpSq]

theorem sphere_increasing :
    thetaSq 3 3 < thetaSq 4 4 ∧ thetaSq 4 4 < thetaSq 5 5 := by
  constructor <;> norm_num [thetaSq]

/-- **`ℂP²` is above every balanced sphere product below the crossover**, which is the
`ℂP²` exception Conjecture A carries at `8 ≤ n ≤ 11`: at `n = 8` and `n = 10`, `3/2`
exceeds `21/16` and `36/25`. -/
theorem cp2_above_below_crossover :
    thetaSq 4 4 < cpSq 2 ∧ thetaSq 5 5 < cpSq 2 := by
  constructor <;> norm_num [thetaSq, cpSq]

/-- **And it is below at `n = 12`**, which is where the exception is dropped: `55/36`
exceeds `3/2`. -/
theorem cp2_below_at_twelve : cpSq 2 < thetaSq 6 6 := by norm_num [thetaSq, cpSq]

/-! ## What this settles

**Settled**: that the two closed forms agree exactly at `n = 6` and part immediately,
with the gap at `n = 8` exactly `49/144`; that `ℂPᵐ` falls while the sphere products
rise, so they cross once; and **that `ℂP²` is above the balanced product at `n = 8` and
`n = 10` and below it at `n = 12`**, which is the `ℂP²` exception Conjecture A carries
at `8 ≤ n ≤ 11` and drops at `n ≥ 12`, here as three exact comparisons rather than a
crossover argument.

**Not settled here**: either closed form, both the record's.
-/

end HamiltonsCubic.FamilyMeet
