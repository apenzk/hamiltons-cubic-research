import HamiltonsCubic.Results.SphereProducts
import HamiltonsCubic.Results.OrbitDim

/-!
# The band's tightness, and a class hypothesis that fails

[target.md](../../../findings/target.md) corrects an earlier reading of the band:

> Every unbalanced sphere product is in the band and much higher: `S⁴×S⁶` at
> `θ = 1.185854`, `S³×S⁷` at `1.133893`, `S³×S⁵` at `1.115547`, `ℂP³` at `1.054093`. …
> **The true measured maximum on the band is `1.185854`, within `3.2%` of `√(3/2)` and
> `1.2%` of `θ₀(10)`.**

**Why this file exists.** Two audited percentages in
[bispectral.md](../../../findings/bispectral.md) fail to reproduce
([JointBody.lean](HamiltonsCubic/Results/JointBody.lean)), which raised the question of
whether the record's percentages are unreliable as a class. **They are not.** This
passage's two reproduce exactly, as do the six in
[CubicRatio.lean](HamiltonsCubic/Results/CubicRatio.lean) and the `8.2%` in
[SphereProducts.lean](HamiltonsCubic/Results/SphereProducts.lean), eleven checked, two
failing, both in one passage. **The defect is local, not a class.**

And three more of the passage's decimals are exact rationals: `45/32`, `9/7`, `56/45`.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.BandTight

open HamiltonsCubic.SphereProducts HamiltonsCubic.OrbitDim

/-! ## Three more exact values -/

/-- `S⁴×S⁶`, printed `1.185854`: exactly `45/32`. -/
theorem s4_s6 : thetaSq 4 6 = 45 / 32 := by norm_num [thetaSq]

/-- `S³×S⁷`, printed `1.133893`: exactly `9/7`. -/
theorem s3_s7 : thetaSq 3 7 = 9 / 7 := by norm_num [thetaSq]

/-- `S³×S⁵`, printed `1.115547`: exactly `56/45`. -/
theorem s3_s5 : thetaSq 3 5 = 56 / 45 := by norm_num [thetaSq]

/-! ## The two percentages, and they reproduce

`1.185854² = 45/32 = 1.40625`, against `3/2` and against `θ₀(10)² = 36/25 = 1.44`.
-/

/-- **Within `3.2%` of `√(3/2)`**: squared, `45/32` against `3/2` is a ratio of
`0.9375`, whose root is `0.9682`, `3.18%` below. -/
theorem within_3_2_percent :
    (0.9682 : ℚ) ^ 2 < thetaSq 4 6 / (3 / 2) ∧ thetaSq 4 6 / (3 / 2) < (0.9683 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

/-- **Within `1.2%` of `θ₀(10)`**: `(45/32)/(36/25) = 0.9765625`, whose root is `0.9882`
`1.18%` below. -/
theorem within_1_2_percent :
    (0.9882 : ℚ) ^ 2 < thetaSq 4 6 / thetaSq 5 5 ∧
      thetaSq 4 6 / thetaSq 5 5 < (0.9883 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

/-- The first ratio is exactly `15/16`, so *"within `3.2%`"* is `1 - √(15/16)`, an
algebraic number, and the passage's figure is its rounding. -/
theorem first_ratio_exact : thetaSq 4 6 / (3 / 2) = 15 / 16 := by norm_num [thetaSq]

/-- The second is exactly `125/128`. -/
theorem second_ratio_exact : thetaSq 4 6 / thetaSq 5 5 = 125 / 128 := by
  norm_num [thetaSq]

/-! ## The ordering the passage asserts

*"Balanced products sit at the cap and are outside; unbalanced ones fall one to four
short and are inside."* At `n = 10` that is `36/25` against `45/32`, and the three
unbalanced values are ordered as printed.
-/

theorem balanced_above : thetaSq 4 6 < thetaSq 5 5 := by norm_num [thetaSq]

theorem unbalanced_ordered :
    thetaSq 3 5 < thetaSq 3 7 ∧ thetaSq 3 7 < thetaSq 4 6 := by
  constructor <;> norm_num [thetaSq]

/-! ## The `C₅` blow-up's orbit

[nondegeneracy.md](../../../findings/nondegeneracy.md) records orbit `40` against
`dim E(½) = 60` at the `C₅` blow-up, `n = 10`. The orbit is `dim 𝔰𝔬(10) - 5`, the
isotropy being five commuting `𝔰𝔬(2)`s.
-/

theorem c5_orbit : (10 : ℚ) * 9 / 2 - 5 = 40 := by norm_num

/-- **The excess is `20`, half the orbit**, the record states `60` against `40` and does
not name the ratio. -/
theorem c5_excess : (60 : ℚ) - 40 = 40 / 2 := by norm_num

/-! ## What this settles

**Settled**: three more printed decimals as exact rationals; that both of the passage's
percentages reproduce, with the underlying ratios exactly `15/16` and `125/128`; the
ordering the passage asserts; and the `C₅` blow-up's orbit as `dim 𝔰𝔬(10)` less five
commuting circles, with an excess of exactly half the orbit.

**And a negative result worth recording**: eleven of the record's percentages have now
been checked and nine reproduce. **The two that fail are both in one passage of
[bispectral.md](../../../findings/bispectral.md)**, so the failure is local, and the
class hypothesis it suggested does not hold.
-/

end HamiltonsCubic.BandTight
