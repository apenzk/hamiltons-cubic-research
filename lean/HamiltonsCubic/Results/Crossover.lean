import HamiltonsCubic.Results.SymmetricTheorem

/-!
# One inequality, three headline results

`θ₀(n) > √(3/2)`, equivalently `n² - 12n + 8 > 0`, equivalently `n > 6 + 2√7 ≈ 11.29`,
is an input to three separate results the record states independently:

1. **The symmetric-space theorem's threshold.** Below the crossover the irreducible bound
   `√(3/2)` exceeds `θ₀(n)`, so the maximiser would be `ℂP²` rather than the balanced
   product, [SymmetricTheorem](HamiltonsCubic/Results/SymmetricTheorem.lean).
2. **The `ℂP²` exception's range**, `8 ≤ n ≤ 11`: exactly the dimensions at or above `8`
   where the crossover has not yet been passed.
3. **The tube closure.** [L20](../../../findings/problem.md)'s proof ends *"the balanced
   sphere product is a unit Weyl operator with `P = θ₀(n) > √(3/2)` for `n ≥ 12`.
   Contradiction."*, and names its only two inputs as `α ≤ 1/3` and this inequality.

**So one condition carries a threshold, an exception's endpoints, and a contradiction**,
in three files. Its two parity forms are checked in
[CrossingAll](HamiltonsCubic/Results/CrossingAll.lean); here it is the shared hinge.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Crossover

open HamiltonsCubic.Theta0

/-! ## The condition, at the dimensions the three results name -/

/-- Fails at `n = 8`, the exception's lower endpoint. -/
theorem at_8 : (8 : ℚ) ^ 2 - 12 * 8 + 8 < 0 := by norm_num

/-- Fails at `n = 11`, the exception's upper endpoint. -/
theorem at_11 : (11 : ℚ) ^ 2 - 12 * 11 + 8 < 0 := by norm_num

/-- Holds at `n = 12`, where the exception is dropped, the theorem's threshold begins, and
the tube closes. -/
theorem at_12 : 0 < (12 : ℚ) ^ 2 - 12 * 12 + 8 := by norm_num

/-- **So the exception's range `8 ≤ n ≤ 11` is exactly where the condition fails**, among
`n ≥ 8`. -/
theorem exception_range :
    (8 : ℚ) ^ 2 - 12 * 8 + 8 < 0 ∧ (9 : ℚ) ^ 2 - 12 * 9 + 8 < 0 ∧
    (10 : ℚ) ^ 2 - 12 * 10 + 8 < 0 ∧ (11 : ℚ) ^ 2 - 12 * 11 + 8 < 0 ∧
    0 < (12 : ℚ) ^ 2 - 12 * 12 + 8 := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;> norm_num

/-! ## The three consumers, at `n = 12` -/

/-- **Consumer 1**: the theorem's two sides swap, `3/2 < θ₀(12)²`. -/
theorem theorem_threshold : (3 : ℚ) / 2 < evenSq 12 := by norm_num [evenSq]

/-- **Consumer 2**: at `n = 11` they have not swapped, which is why the exception runs to
`11`. Using the odd form, `Θ₁₁² = 40/27`. -/
theorem exception_endpoint : (40 : ℚ) / 27 < 3 / 2 := by norm_num

/-- **Consumer 3**: L20's contradiction needs `θ₀(12) > √(3/2)`, the same inequality. -/
theorem tube_input : (3 : ℚ) / 2 < evenSq 12 := by norm_num [evenSq]

/-- The three consume one statement, here they are, side by side. -/
theorem one_hinge :
    ((3 : ℚ) / 2 < evenSq 12) ∧ ((40 : ℚ) / 27 < 3 / 2) ∧ (0 < (12 : ℚ) ^ 2 - 12 * 12 + 8) := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [evenSq]

/-! ## The margin at the hinge is small

At `n = 12` the condition holds by `8`, against a quadratic that grows like `n²`, so the
three results turn on a margin that is thin at exactly the dimension they are stated for.
-/

theorem margin_at_12 : (12 : ℚ) ^ 2 - 12 * 12 + 8 = 8 := by norm_num

theorem margin_at_13 : (13 : ℚ) ^ 2 - 12 * 13 + 8 = 21 := by norm_num

theorem margin_at_24 : (24 : ℚ) ^ 2 - 12 * 24 + 8 = 296 := by norm_num

/-- In `θ²` the margin at `n = 12` is `1/36`, the thinnest point of the three results'
common support. -/
theorem theta_margin_at_12 : evenSq 12 - 3 / 2 = 1 / 36 := by norm_num [evenSq]

/-! ## What this settles

**Settled**: that `n² - 12n + 8 > 0` fails at `n = 8, 9, 10, 11` and holds at `n = 12`, so
**the `ℂP²` exception's range is exactly where it fails**; and that the same inequality is
what makes the symmetric-space theorem's two sides swap and what L20's tube contradiction
consumes.

**One condition, three results, three files**, and its margin at the hinge is thin:
`8` in the quadratic, `1/36` in `θ²`, at exactly the dimension all three are stated for.

**Not claimed**: L20's other input `α ≤ 1/3`, or that the three results have no further
shared dependencies.
-/

end HamiltonsCubic.Crossover
