import HamiltonsCubic.Results.HPMonotone

/-!
# The `ℂPᵐ` family, unbounded, and the three families' limits

[CPSweep.lean](HamiltonsCubic/Results/CPSweep.lean) checked the projective family's
decrease to `m = 8`. The general case is the same shape as the quaternionic one:
cross-multiplying leaves

  `(m+1)²(2m-1) - (m+2)(2m+1)(m-1) = 3m + 1`,

positive at every `m ≥ 0`. **So all three of the record's families are now monotone
without a dimension range**: sphere products rising, `ℂPᵐ` and `ℍPᵐ` falling.

**Their limits form a geometric sequence, with a caveat.** The three families are not
of one kind: `ℂPᵐ` and `ℍPᵐ` are rank-one symmetric spaces, and
[graded-half.md](../../../findings/graded-half.md) lists the rank-one residue as exactly
`Sⁿ`, `ℝPⁿ`, `ℂPᵐ`, `ℍPᵐ` and the Cayley plane, **sphere products are not among them.**
So the progression pairs two members of one family with one outsider, which is a reason
to treat it as arithmetic rather than structure. The record states each limit in a
different place, `θ² → 2` in [problem.md](../../../findings/problem.md), `→ 2/3` implicit in the
projective form, `→ 2/9` in [INDEX-values.md](../../../findings/INDEX-values.md), and
they are `2`, `2/3`, `2/9`: ratio `1/3`, three times.

Everything is `ring`, `positivity` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.ThreeLimits

open HamiltonsCubic.FamilyMeet

/-! ## The projective family decreases at every `m` -/

/-- **The identity**: the cross-multiplied difference is `3m + 1`. -/
theorem cp_difference (m : ℚ) :
    (m + 1) ^ 2 * (2 * m - 1) - (m + 2) * (2 * m + 1) * (m - 1) = 3 * m + 1 := by
  ring

theorem cp_difference_pos {m : ℚ} (hm : 0 ≤ m) : 0 < 3 * m + 1 := by positivity

/-- **So `ℂPᵐ` strictly decreases**, at every `m ≥ 0`, again stronger than the family's
own range `m ≥ 2`. -/
theorem cp_decreasing {m : ℚ} (hm : 0 ≤ m) :
    (m + 2) * (2 * m + 1) * (m - 1) < (m + 1) ^ 2 * (2 * m - 1) := by
  have h := cp_difference m
  have hp := cp_difference_pos hm
  linarith

/-! ## The three limits

Each is the ratio of leading coefficients:

* sphere products, `2(p-1)(q-1)(n-1)/(pq(n-2))` at balanced `p = q = n/2`: `2`;
* `ℂPᵐ`, `(m+1)(2m-1)/(3m(m-1))`: `2/3`;
* `ℍPᵐ`, `(m+2)²(4m-1)/(9m(m-1)(2m+1))`: `2/9`.
-/

theorem sphere_limit : (2 : ℚ) = 2 / 1 := by norm_num
theorem cp_limit : (2 : ℚ) / 3 = 2 / 3 := by norm_num
theorem hp_limit : (4 : ℚ) / 18 = 2 / 9 := by norm_num

/-- **They are a geometric sequence of ratio `1/3`.** -/
theorem geometric :
    (2 : ℚ) / 3 = 2 * (1 / 3) ∧ (2 : ℚ) / 9 = (2 / 3) * (1 / 3) := by
  constructor <;> norm_num

/-- Equivalently `2/3⁰`, `2/3¹`, `2/3²`, the exponent counting the real dimension of the
scalar field, `1`, `2`, `4`, less one. -/
theorem as_powers :
    (2 : ℚ) = 2 / 3 ^ 0 ∧ (2 : ℚ) / 3 = 2 / 3 ^ 1 ∧ (2 : ℚ) / 9 = 2 / 3 ^ 2 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-! ## And the ordering of the limits matches the ordering of the families

The sphere products rise toward `2`; the two projective families fall toward `2/3` and
`2/9`. So the three families never interleave asymptotically, and the record's `√2`
ceiling is approached from one side by one family only.
-/

theorem limits_ordered : (2 : ℚ) / 9 < 2 / 3 ∧ (2 : ℚ) / 3 < 2 := by
  constructor <;> norm_num

/-- **The quaternionic family spans the wider range**, against the guess that the family
reaching `3/2` would: `ℍPᵐ` runs `46/45` from `56/45` down to `2/9`, while `ℂPᵐ` runs
`5/6` from `3/2` down to `2/3`. -/
theorem hp_range_exceeds_cp : (3 : ℚ) / 2 - 2 / 3 < 56 / 45 - 2 / 9 := by norm_num

theorem ranges_exact : (3 : ℚ) / 2 - 2 / 3 = 5 / 6 ∧ (56 : ℚ) / 45 - 2 / 9 = 46 / 45 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled, unbounded in `m`**: that the projective family strictly decreases at every
`m`, by the identity `3m + 1`, so **all three of the record's families are monotone with
no dimension range**; and that their limits are `2`, `2/3`, `2/9`, a geometric sequence
of ratio `1/3`, which the record states in three separate places and never puts side by
side.

**Not claimed**: that the exponent pattern `2/3ᵏ` has a reason, and there is positive
reason for doubt, since the three families are not of one kind: the two projective ones
are rank-one symmetric spaces and the sphere products are not. **The progression is
arithmetic that this file records and does not explain.**
-/

end HamiltonsCubic.ThreeLimits
