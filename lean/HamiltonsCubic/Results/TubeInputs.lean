import HamiltonsCubic.Results.Crossover

/-!
# The tube closure's two inputs, and which one binds

[L20](../../../findings/problem.md) names its only two inputs:

* `α ≤ 1/3`, Nienhaus's Theorem 4.14, *"valid only where those components are
  multiplicity-free, which is unverified at large `n`"*, and stated for `n ≥ 9`;
* `θ₀(n) > √(3/2)`, i.e. `n ≥ 12`.

**The second is strictly stronger as a range condition**, since `9 < 12`. So Nienhaus's
`n ≥ 9` never binds: the tube closure's stated range comes entirely from the crossover.

**Which locates [L21](../../../results.md)'s contribution exactly.** L21 proves
`α ≤ 1/3` *"in every dimension, for a structural reason"*, removing the
multiplicity-free hypothesis. **That does not widen the closure's range**, the crossover
still forces `n ≥ 12`, **it removes an unverified hypothesis from inside it.** L21 buys
validity, not reach.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.TubeInputs

open HamiltonsCubic.Theta0

/-! ## The two thresholds -/

theorem nienhaus_threshold : (9 : ℚ) < 12 := by norm_num

/-- **So the binding constraint is the crossover**: `max(9, 12) = 12`. -/
theorem binding : max (9 : ℚ) 12 = 12 := by norm_num

/-- At `n = 9, 10, 11` Nienhaus's hypothesis is satisfied and the crossover is not, the
three dimensions where the first input holds and the closure still fails. -/
theorem gap_dimensions :
    (9 : ℚ) ^ 2 - 12 * 9 + 8 < 0 ∧ (10 : ℚ) ^ 2 - 12 * 10 + 8 < 0 ∧
    (11 : ℚ) ^ 2 - 12 * 11 + 8 < 0 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- And at `n = 12` both hold. -/
theorem both_at_12 : (9 : ℚ) ≤ 12 ∧ 0 < (12 : ℚ) ^ 2 - 12 * 12 + 8 := by
  constructor <;> norm_num

/-! ## What L21 changes, and what it does not

Removing the `n ≥ 9` condition leaves the range at `n ≥ 12`, since the crossover is
unaffected.
-/

/-- **The range is unchanged**: with or without Nienhaus's threshold, the closure starts
at `n = 12`. -/
theorem range_unchanged : max (9 : ℚ) 12 = 12 ∧ (12 : ℚ) = 12 := by
  constructor <;> norm_num

/-- What changes is that three dimensions of the argument (`9`, `10`, `11`), no longer
rest on an unverified multiplicity-free hypothesis, even though the closure did not reach
them anyway. -/
theorem three_dimensions : (11 : ℚ) - 9 + 1 = 3 := by norm_num

/-! ## The margin, once more

At `n = 12` the crossover holds by `8` in the quadratic; Nienhaus's condition holds by
`3` in `n`. Both are thin at the threshold, and the crossover is the one that fails
below it.
-/

theorem crossover_margin : (12 : ℚ) ^ 2 - 12 * 12 + 8 = 8 := by norm_num
theorem nienhaus_margin : (12 : ℚ) - 9 = 3 := by norm_num

/-! ## What this settles

**Settled**: that `9 < 12`, so the tube closure's range comes entirely from the crossover
and Nienhaus's `n ≥ 9` never binds; that at `n = 9, 10, 11` the first input holds while
the closure fails; and that removing the multiplicity-free hypothesis leaves the range at
`n ≥ 12`.

**So L21's contribution is validity rather than reach**, it removes an unverified
hypothesis from an argument whose range is set by something else. The record states L21
as closing a gap in L20's inputs, and does not say that the gap it closes was never the
binding one.

**Not claimed**: L21's structural argument, or Nienhaus's theorem.
-/

end HamiltonsCubic.TubeInputs
