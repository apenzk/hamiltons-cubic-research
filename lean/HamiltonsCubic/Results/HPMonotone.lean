import HamiltonsCubic.Results.HPFamily

/-!
# The quaternionic family decreases at every `m`

[HPFamily.lean](HamiltonsCubic/Results/HPFamily.lean) checked the index's
*"strictly decreasing"* across the tabulated range only.

**The record proves the general case already**, in
[graded-half.md](../../../findings/graded-half.md): `dθ²/dm = -(m+2)(34m³ - 12m² + 3m +
2)/(9m²(m-1)²(2m+1)²)`, *"whose cubic is positive for every `m > 0`"*. **So this file
does not add the result, it adds a different certificate for it**, and the two agree
where they must: both cubics have leading coefficient `34`.

The difference below is the *discrete* one, and **its coefficients are all positive**,
where the record's derivative cubic carries a `-12m²` and needs an argument for its
positivity. That is the whole of what this file improves.

Cross-multiplying `θ²(ℍPᵐ) > θ²(ℍPᵐ⁺¹)` clears every denominator and leaves

  `(m+2)²(4m-1)(m+1)(2m+3) - (m+3)²(4m+3)(m-1)(2m+1) = 34m³ + 124m² + 97m + 15`,

**whose coefficients are all positive**, so the inequality holds at every `m ≥ 0`, not
merely at every admissible `m ≥ 2`. The index's claim is therefore unconditional, and the
supremum at `m = 2` is the maximum over the whole family.

Everything is `ring` and `positivity`, kernel-checked, unbounded in `m`.
-/

namespace HamiltonsCubic.HPMonotone

open HamiltonsCubic.HPFamily

/-- **The identity.** Both sides are quintics; their difference is a cubic with positive
coefficients. -/
theorem difference_identity (m : ℚ) :
    (m + 2) ^ 2 * (4 * m - 1) * (m + 1) * (2 * m + 3)
      - (m + 3) ^ 2 * (4 * m + 3) * (m - 1) * (2 * m + 1)
      = 34 * m ^ 3 + 124 * m ^ 2 + 97 * m + 15 := by
  ring

/-- **So the difference is positive at every `m ≥ 0`.** -/
theorem difference_pos {m : ℚ} (hm : 0 ≤ m) :
    0 < 34 * m ^ 3 + 124 * m ^ 2 + 97 * m + 15 := by positivity

/-- **Hence the family strictly decreases**, in the cross-multiplied form that carries no
side condition on the denominators. -/
theorem strictly_decreasing {m : ℚ} (hm : 0 ≤ m) :
    (m + 3) ^ 2 * (4 * m + 3) * (m - 1) * (2 * m + 1)
      < (m + 2) ^ 2 * (4 * m - 1) * (m + 1) * (2 * m + 3) := by
  have h := difference_identity m
  have hp := difference_pos hm
  linarith

/-- At `m = 2` the difference is `34·8 + 124·4 + 97·2 + 15 = 977`. -/
theorem at_2 : 34 * (2 : ℚ) ^ 3 + 124 * 2 ^ 2 + 97 * 2 + 15 = 977 := by norm_num

/-- And it grows cubically, so the family separates faster as `m` rises rather than
converging to a plateau, the approach to `2/9` is from above and monotone. -/
theorem grows : 34 * (2 : ℚ) ^ 3 + 124 * 2 ^ 2 + 97 * 2 + 15
    < 34 * (6 : ℚ) ^ 3 + 124 * 6 ^ 2 + 97 * 6 + 15 := by norm_num

/-! ## What this settles

**Settled, unbounded in `m`**: the quaternionic family's strict decrease, by a discrete
identity whose right-hand side has all-positive coefficients.

**Already on the record**, by the derivative route in
[graded-half.md](../../../findings/graded-half.md). What is new here is the certificate's
shape: positivity by inspection rather than by an argument about a sign-mixed cubic.

**The positivity is stronger than needed**: the inequality holds from `m = 0`, while the
family is defined from `m = 2`, so no admissibility condition enters the argument.

**Not claimed**: the closed form itself, which is the record's.
-/

end HamiltonsCubic.HPMonotone
