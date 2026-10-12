import Mathlib

/-!
# L178, stated without square roots

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L178 says a Weyl tensor of
`Λ²`-rank at most three, supported on a four-dimensional subspace, has `θ ≤ √(3/2)`, sharp at
`W_{ℂP²}`.

**The conclusion needs no square root.** At unit norm `θ = P`, the chain gives `P = 9e₃`, and
`θ ≤ √(3/2)` is `P² ≤ 3/2`, which is `81 e₃² ≤ 3/2`, i.e. `e₃² ≤ 1/54`. So the ARITHMETIC of the
statement is a polynomial inequality in the three eigenvalues, and this file states and proves it
as one.

## What is NOT typed here

**The geometric hypothesis.** `P_sq_le` assumes `a + b + c = 0` and `a² + b² + c² = 1`; the record
assumes `rank(W : Λ² → Λ²) ≤ 3` **and** support on a four-dimensional `V`. Everything between is
absent, that rank `≤ 3` forces (anti-)self-duality so there are exactly three eigenvalues, that
`γ² = 2` hence `⟨W, W#⟩ = 6e₃`, and the padding. Those are what make `θ = 9e₃`, and without them
this file bounds a polynomial rather than a Weyl tensor.

**The equality clause, which is a RIGIDITY statement.** The record says equality holds *exactly
when* `W` is `W_{ℂP²}` up to positive scale and an `O(n)` frame change.
[Families.lean](../Base/Families.lean)'s `cp2_attains_L178` gives attainment at ONE POINT, the
trivial half. The uniqueness half, with the scale-and-frame quotient, is
[L178Rigid.lean](L178Rigid.lean)'s `L178_frame_eq_iff`.

*One of the five results an earlier census marked unstatable for want of a curvature base layer.
That was true of the route through `Λ²`; it is not true of the conclusion.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L178

/-- **The bound on the third elementary symmetric function.** Three reals summing to zero with
unit square sum have `(abc)² ≤ 1/54`, the discriminant condition of `x³ - x/2 - e₃`, written
without mentioning the cubic. -/
theorem e3_sq_le (a b c : ℝ) (h1 : a + b + c = 0) (h2 : a ^ 2 + b ^ 2 + c ^ 2 = 1) :
    (a * b * c) ^ 2 ≤ 1 / 54 := by
  have hc : c = -(a + b) := by linarith
  subst hc
  -- `(a+b)² ≤ 2/3`, since `a² + b² ≥ (a+b)²/2`.
  have hs : (a + b) ^ 2 ≤ 2 / 3 := by nlinarith [sq_nonneg (a - b)]
  -- `h2` forces `ab = (a+b)² - 1/2`.
  have hp : a * b = (a + b) ^ 2 - 1 / 2 := by nlinarith [h2]
  -- and `1/54 - u(u - 1/2)² = (u - 1/6)²(2/3 - u)` at `u = (a+b)²`.
  have key : ((a + b) ^ 2 - 1 / 6) ^ 2 * (2 / 3 - (a + b) ^ 2) ≥ 0 :=
    mul_nonneg (sq_nonneg _) (by linarith)
  have expand : (a * b * -(a + b)) ^ 2 = (a * b) ^ 2 * (a + b) ^ 2 := by ring
  rw [expand, hp]
  -- Now a cubic in `u = (a+b)²` alone, and `key` is its exact certificate.
  generalize hU : (a + b) ^ 2 = u at key hs ⊢
  nlinarith [key, hs]

/-- **Newton at `e₁ = 0`**: `p₃ = 3e₃`, which is `tr W³ = 3e₃`. -/
theorem p3_eq (a b c : ℝ) (h1 : a + b + c = 0) :
    a ^ 3 + b ^ 3 + c ^ 3 = 3 * (a * b * c) := by
  have hc : c = -(a + b) := by linarith
  subst hc; ring

/-- **`e₂ = -1/2`** from `e₁ = 0` and `p₂ = 1`, the step the discriminant reading uses. -/
theorem e2_eq (a b c : ℝ) (h1 : a + b + c = 0) (h2 : a ^ 2 + b ^ 2 + c ^ 2 = 1) :
    a * b + b * c + a * c = -(1 / 2) := by
  have hc : c = -(a + b) := by linarith
  subst hc; nlinarith [h2]

/-! ## The statement itself -/

/-- **L178, as a polynomial inequality.** With `P = tr W³ + ⟨W, W#⟩ = 3e₃ + 6e₃ = 9e₃` at unit
norm, the bound `θ ≤ √(3/2)` is `P² ≤ 3/2`.

**The inequality is proved**, from `e3_sq_le`, and `81 · (1/54) = 3/2` exactly.

**The equality clause is NOT proved and is not typed.** *That equality holds precisely at the
repeated-root case `(2,-1,-1)/√6`, which is `ℂP²`, is half of the record's statement and appears
here only in prose, with no `sorry` to signal it, which reads as verified.* -/
theorem P_sq_le (a b c : ℝ) (h1 : a + b + c = 0) (h2 : a ^ 2 + b ^ 2 + c ^ 2 = 1) :
    (9 * (a * b * c)) ^ 2 ≤ 3 / 2 := by
  have h := e3_sq_le a b c h1 h2
  nlinarith [h]

/-- And the constant is exact: `81/54 = 3/2`, so the inequality is sharp rather than slack. -/
theorem constant_exact : (81 : ℝ) * (1 / 54) = 3 / 2 := by norm_num

end HamiltonsCubic.L178
