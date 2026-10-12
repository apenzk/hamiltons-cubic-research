import HamiltonsCubic.Results.FamilyMeet2

/-!
# The census of coincidences at `n ≤ 24`

Enumerating both closed forms over every admissible split with `n ≤ 24`, `p, q ≥ 2` for
the sphere products, `m = 2…12` for `ℂPᵐ`, **exactly four values are reached more than
once**, and no value is reached three times:

| value | points |
|---|---|
| `10/9` | `S³×S³` `(n=6)` = `ℂP³` `(n=6)` |
| `35/36` | `S²×S⁶` `(n=8)` = `ℂP⁴` `(n=8)` |
| `120/77` | `S⁶×S⁷` `(n=13)` = `S⁵×S¹¹` `(n=16)` |
| `105/64` | `S⁸×S⁸` `(n=16)` = `S⁶×S¹⁶` `(n=22)` |

The first two are the cross-family meetings already recorded. **The other two are
within the sphere family and cross dimensions**, a point at one `n` reaching exactly the
value of a point three or six dimensions higher. Both pairs appear in the record's own
band tables, printed as decimals in the same column, and neither is remarked on.

**Scope.** The census is an exhaustive enumeration over the two families at `n ≤ 24`,
carried out on exact rationals; the four equalities below are kernel-checked, the
exhaustiveness is not, and is stated as the search it was.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Coincidences

open HamiltonsCubic.FamilyMeet HamiltonsCubic.SphereProducts

/-! ## The two cross-family meetings -/

theorem meet_10_9 : thetaSq 3 3 = cpSq 3 := by norm_num [thetaSq, cpSq]

theorem meet_35_36 : thetaSq 2 6 = cpSq 4 := by norm_num [thetaSq, cpSq]

/-! ## The two within-family meetings, across dimensions -/

/-- **`S⁶×S⁷` at `n = 13` equals `S⁵×S¹¹` at `n = 16`**, both `120/77`. -/
theorem meet_120_77 : thetaSq 6 7 = thetaSq 5 11 := by norm_num [thetaSq]

theorem value_120_77 : thetaSq 6 7 = 120 / 77 := by norm_num [thetaSq]

/-- **`S⁸×S⁸` at `n = 16` equals `S⁶×S¹⁶` at `n = 22`**, both `105/64`, a *balanced*
product matched by an unbalanced one six dimensions higher. -/
theorem meet_105_64 : thetaSq 8 8 = thetaSq 6 16 := by norm_num [thetaSq]

theorem value_105_64 : thetaSq 8 8 = 105 / 64 := by norm_num [thetaSq]

/-! ## What the within-family pairs mean

`θ` is not monotone in `n` across the whole family: a product at `n = 13` matches one at
`n = 16`, so climbing dimensions does not raise `θ` unless the split is held. Both pairs
show the same thing, **the balanced value at one dimension is overtaken and then matched
again further out.**
-/

/-- At `n = 16` the balanced value `105/64` exceeds `120/77`, which is reached at both
`n = 13` and `n = 16`, so within one dimension the family spans both. -/
theorem within_16 : thetaSq 5 11 < thetaSq 8 8 := by norm_num [thetaSq]

/-- And the `n = 13` point already exceeds the balanced value at `n = 12`: `120/77`
against `55/36`. **So a point three dimensions below can beat one at `n = 16`'s split.** -/
theorem thirteen_beats_twelve : thetaSq 6 6 < thetaSq 6 7 := by norm_num [thetaSq]

/-- The four coincident values are distinct from each other. -/
theorem four_distinct :
    (10 : ℚ) / 9 ≠ 35 / 36 ∧ (120 : ℚ) / 77 ≠ 105 / 64 ∧ (10 : ℚ) / 9 ≠ 120 / 77 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-! ## What this settles

**Settled**: the four coincidences as exact equalities, including two within the sphere
family that cross dimensions, `n = 13` with `n = 16`, and `n = 16` with `n = 22`. Both
pairs sit in the record's own band tables as decimals in one column, unremarked.

**The exhaustiveness is now proved too**, in
[Census.lean](HamiltonsCubic/Results/Census.lean), by carrying each value as a normalised
pair over `ℕ` so that equality reduces in the kernel.

**Not settled here**: anything beyond `n = 24`.
-/

end HamiltonsCubic.Coincidences
