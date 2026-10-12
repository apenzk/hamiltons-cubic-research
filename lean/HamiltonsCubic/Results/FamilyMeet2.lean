import HamiltonsCubic.Results.FamilyMeet

/-!
# The second family coincidence, and why there is no third

[FamilyMeet.lean](HamiltonsCubic/Results/FamilyMeet.lean) found `ℂP³ = S³×S³` at `10/9`,
`n = 6`. There is a second: **`ℂP⁴ = S²×S⁶` at `35/36`, `n = 8`.**

The record prints both as `0.986013`, once for `ℂP⁴` in
[curvature-invariants.md](../../../findings/curvature-invariants.md) and
[target.md](../../../findings/target.md), once for `S²×S⁶` in
[nondegeneracy.md](../../../findings/nondegeneracy.md), where the sentence compares the
two-eigenvalue points against the three-eigenvalue ones. **Neither mention notes that the
other family reaches the same value at the same dimension.**

**And there is no third.** At `n = 10`, matching `ℂP⁵`'s `9/10` needs `p² - 10p + 15 = 0`,
whose roots are `5 ± √10`, irrational, so no sphere product meets it. At `n = 12` none
of the five products equals `ℂP⁶`'s `77/90`.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.FamilyMeet2

open HamiltonsCubic.FamilyMeet HamiltonsCubic.SphereProducts

/-! ## The coincidence at `n = 8` -/

theorem cp4_value : cpSq 4 = 35 / 36 := by norm_num [cpSq]

theorem s2_s6_value : thetaSq 2 6 = 35 / 36 := by norm_num [thetaSq]

/-- **They are equal.** -/
theorem meet_at_eight : cpSq 4 = thetaSq 2 6 := by norm_num [cpSq, thetaSq]

/-- And the other two products at `n = 8` do not meet it. -/
theorem others_at_eight :
    cpSq 4 ≠ thetaSq 3 5 ∧ cpSq 4 ≠ thetaSq 4 4 := by
  constructor <;> norm_num [cpSq, thetaSq]

/-! ## No third coincidence

At `n = 10` the matching condition is `5(p-1)(q-1) = 2pq` with `q = 10 - p`, which
reduces to `p² - 10p + 15 = 0`.
-/

/-- The reduction is an identity. -/
theorem n10_reduction (p : ℚ) :
    5 * (p - 1) * ((10 - p) - 1) - 2 * p * (10 - p) = -3 * (p ^ 2 - 10 * p + 15) := by
  ring

/-- **Its roots are `5 ± √10`, irrational**, so no integer `p` works: the discriminant
`40` is not a square. -/
theorem discriminant : (10 : ℚ) ^ 2 - 4 * 15 = 40 := by norm_num

theorem forty_not_square : (6 : ℚ) ^ 2 < 40 ∧ (40 : ℚ) < 7 ^ 2 := by
  constructor <;> norm_num

/-- Checked directly at the three admissible splits of `n = 10`: none gives `9/10`. -/
theorem no_meet_at_ten :
    cpSq 5 ≠ thetaSq 2 8 ∧ cpSq 5 ≠ thetaSq 3 7 ∧ cpSq 5 ≠ thetaSq 4 6 ∧
    cpSq 5 ≠ thetaSq 5 5 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [cpSq, thetaSq]

/-- And at `n = 12`, none of the five products equals `ℂP⁶`'s `77/90`. -/
theorem no_meet_at_twelve :
    cpSq 6 ≠ thetaSq 2 10 ∧ cpSq 6 ≠ thetaSq 3 9 ∧ cpSq 6 ≠ thetaSq 4 8 ∧
    cpSq 6 ≠ thetaSq 5 7 ∧ cpSq 6 ≠ thetaSq 6 6 := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;> norm_num [cpSq, thetaSq]

/-! ## The two coincidences are of different kinds

At `n = 6` the match is with the **balanced** product; at `n = 8` with the most
**unbalanced** one available. So they are not two instances of one mechanism.
-/

theorem six_is_balanced : cpSq 3 = thetaSq 3 3 := by norm_num [cpSq, thetaSq]

theorem eight_is_extreme : cpSq 4 = thetaSq 2 6 ∧ thetaSq 2 6 < thetaSq 3 5 := by
  constructor <;> norm_num [cpSq, thetaSq]

/-- At `n = 8`, `S²×S⁶` is the lowest of the three products, so `ℂP⁴` matches the
bottom of the range there, where at `n = 6` `ℂP³` matched the top. -/
theorem eight_is_lowest :
    thetaSq 2 6 < thetaSq 3 5 ∧ thetaSq 3 5 < thetaSq 4 4 := by
  constructor <;> norm_num [thetaSq]

/-! ## What this settles

**Settled**: a second exact coincidence between the two families, `ℂP⁴ = S²×S⁶` at
`35/36`, which the record prints twice as the same decimal in different files without
connecting them; that there is no third at `n = 10`, the matching condition's
discriminant is `40`, not a square, nor at `n = 12`; and that the two coincidences are
of different kinds, `ℂP³` matching the **top** of the range at `n = 6` and `ℂP⁴` the
**bottom** at `n = 8`, so they are not one mechanism seen twice.

**Not claimed**: either closed form, both the record's.
-/

end HamiltonsCubic.FamilyMeet2
