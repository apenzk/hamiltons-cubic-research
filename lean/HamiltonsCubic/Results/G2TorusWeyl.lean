import Mathlib

/-!
# The Weyl-invariant positive-definite idempotents on `𝔤₂`'s torus family

[The working note](../../../reviews/2026-09-28l-I117-g2-torus.md) on I117's R48, "The family's
algebra, exactly": on Weyl-invariant weights (long `x`, short `y`) the idempotent system is
`x (1 − 6x² − 2y²) = x² + y²` and `1 − 2x² − ⅔y² = 2x + (4/3)y`, whose positive solutions are
exactly `(¼, ¼)`, which is `I/4`, and `(9/28, 3/28)`, which is L263's.

**What is typed.** `weyl_invariant_solutions`: for `x, y > 0` the two equations force one of the two
points. The certificates are a lexicographic Gröbner basis's lifts: `x` is a cubic in `y`, `y` solves
`(4y − 1)(28y − 3)(4y² + 8y − 9) = 0`, and the quadratic factor forces `x = −½`.

**Not typed**: the reduction of `C # C = C` on the torus family to these two equations (the product
table, Gate 2 [r1884], [r1885]), and the reflection-type solve.
-/

namespace HamiltonsCubic.G2TorusWeyl

/-- **The Weyl-invariant idempotents on `𝔤₂`'s torus family are `I/4` and L263's.** -/
theorem weyl_invariant_solutions (x y : ℝ) (hx : 0 < x) (hy : 0 < y)
    (h1 : x * (1 - 6 * x ^ 2 - 2 * y ^ 2) = x ^ 2 + y ^ 2)
    (h2 : 1 - 2 * x ^ 2 - 2 / 3 * y ^ 2 = 2 * x + 4 / 3 * y) :
    (x = 1 / 4 ∧ y = 1 / 4) ∨ (x = 9 / 28 ∧ y = 3 / 28) := by
  have g1 : x + 56 / 207 * y ^ 3 + 190 / 207 * y ^ 2 + 10 / 69 * y - 8 / 23 = 0 := by
    linear_combination (-2 / 23 * x - 4 / 69 * y - 6 / 23) * h1
      + (6 / 23 * x ^ 2 + 4 / 23 * x * y + 13 / 23 * x - 22 / 69 * y - 8 / 23) * h2
  have g2 : (4 * y - 1) * (28 * y - 3) * (4 * y ^ 2 + 8 * y - 9) = 0 := by
    linear_combination 448 * ((-9 / 28 * x * y + 9 / 16 * x - 3 / 14 * y ^ 2 - 33 / 56 * y
        + 171 / 224) * h1
      + (27 / 28 * x ^ 2 * y - 27 / 16 * x ^ 2 + 9 / 14 * x * y ^ 2 + 27 / 28 * x * y
        - 99 / 112 * x - 33 / 28 * y ^ 2 + 87 / 112 * y - 27 / 448) * h2)
  rcases mul_eq_zero.mp g2 with h | h
  · rcases mul_eq_zero.mp h with h | h
    · have hy' : y = 1 / 4 := by linarith
      subst hy'
      left
      refine ⟨?_, rfl⟩
      norm_num at g1
      linarith
    · have hy' : y = 3 / 28 := by linarith
      subst hy'
      right
      refine ⟨?_, rfl⟩
      norm_num at g1
      linarith
  · exfalso
    have hx' : x = -1 / 2 := by
      linear_combination g1 - (14 / 207 * y + 13 / 138) * h
    linarith

/-- Non-vacuity: both points solve both equations, so the two alternatives are exactly the
positive solutions. -/
example : (1 / 4 : ℝ) * (1 - 6 * (1 / 4) ^ 2 - 2 * (1 / 4) ^ 2) = (1 / 4) ^ 2 + (1 / 4) ^ 2 ∧
    1 - 2 * (1 / 4 : ℝ) ^ 2 - 2 / 3 * (1 / 4) ^ 2 = 2 * (1 / 4) + 4 / 3 * (1 / 4) ∧
    (9 / 28 : ℝ) * (1 - 6 * (9 / 28) ^ 2 - 2 * (3 / 28) ^ 2) = (9 / 28) ^ 2 + (3 / 28) ^ 2 ∧
    1 - 2 * (9 / 28 : ℝ) ^ 2 - 2 / 3 * (3 / 28) ^ 2 = 2 * (9 / 28) + 4 / 3 * (3 / 28) := by
  norm_num

end HamiltonsCubic.G2TorusWeyl
