import Mathlib

set_option linter.style.longLine false

/-!
# L220, the four-set subalgebra closes at padded `CP²`: the scalar chain

## The claim

[I100 derivation](../../../reviews/2026-09-14-I100-derivation.md), fifth attempt at I101: *a unit critical point
`W = q + r + ν` of `P` in `𝒟ₙ ⊕ V_Q` with `ν ≠ 0` and `θ > 0` has `θ ≤ √(3/2)`.*

## What is typed

**Steps 3 to 6, over the scalars.** With `a = ‖q‖²`, `R = ‖r‖²`, `N = ‖ν‖²`, `p = P(q)` and `κ = ⟨L_q r, r⟩`:

* `hunit`: `a + R + N = 1`;
* `ha`: `3 a = θ²`, the `θ/2`-eigenvalue of `L_q` on `V_Q` (step 3);
* `hpair`: `p + κ + θ N / 2 = θ a`, the `𝒟ₙ` equation paired with `q` (step 4);
* `hp`: `6 p ≤ θ³`, from `P(q) ≤ (√3/2)‖q‖³` at `‖q‖² = θ²/3` (step 5);
* `hκ`: `3 κ ≤ θ R`, from `κ ≤ ‖q‖‖r‖²/√3` (step 5).

**Not typed**: `𝒲ₙ`, the block structure, and the derivation of the five hypotheses, which is the prose.
-/

namespace HamiltonsCubic.L220Statement

/-- **The scalar chain: `θ² ≤ 3/2`.** -/
theorem theta_sq_le (θ a R N p κ : ℝ) (hθ : 0 < θ) (hR : 0 ≤ R) (hN : 0 ≤ N)
    (hunit : a + R + N = 1) (ha : 3 * a = θ ^ 2) (hpair : p + κ + θ * N / 2 = θ * a)
    (hp : 6 * p ≤ θ ^ 3) (hκ : 3 * κ ≤ θ * R) :
    θ ^ 2 ≤ 3 / 2 := by
  -- θ³/6 - θN/2 ≤ κ ≤ θR/3, then divide by θ
  have h1 : θ ^ 3 / 6 - θ * N / 2 ≤ θ * R / 3 := by nlinarith
  have h2 : θ ^ 2 / 6 - N / 2 ≤ R / 3 := by
    have := h1
    have hθ' : θ * (θ ^ 2 / 6 - N / 2) ≤ θ * (R / 3) := by nlinarith
    exact le_of_mul_le_mul_left hθ' hθ
  nlinarith

/-- **And `θ < √(3/2)` fails only at the equality case**: `θ² = 3/2` forces `R = 0` and `N = 1/2`. -/
theorem equality_case (θ a R N p κ : ℝ) (hθ : 0 < θ) (hR : 0 ≤ R) (hN : 0 ≤ N)
    (hunit : a + R + N = 1) (ha : 3 * a = θ ^ 2) (hpair : p + κ + θ * N / 2 = θ * a)
    (hp : 6 * p ≤ θ ^ 3) (hκ : 3 * κ ≤ θ * R) (heq : θ ^ 2 = 3 / 2) :
    R = 0 ∧ N = 1 / 2 := by
  have h1 : θ ^ 3 / 6 - θ * N / 2 ≤ θ * R / 3 := by nlinarith
  have h2 : θ ^ 2 / 6 - N / 2 ≤ R / 3 := by
    have hθ' : θ * (θ ^ 2 / 6 - N / 2) ≤ θ * (R / 3) := by nlinarith
    exact le_of_mul_le_mul_left hθ' hθ
  have hR0 : R = 0 := by nlinarith
  refine ⟨hR0, ?_⟩
  nlinarith

/-- **Step 7, `P` on the pattern plane**: with `x + y + z = 0`, `(18xyz)² ≤ (3/4)(2(x²+y²+z²))³`,
which is `P(q) ≤ (√3/2)‖q‖³` squared. -/
theorem pattern_cubic_sq_le (x y z : ℝ) (h : x + y + z = 0) :
    (18 * x * y * z) ^ 2 ≤ 3 / 4 * (2 * (x ^ 2 + y ^ 2 + z ^ 2)) ^ 3 := by
  have hz : z = -x - y := by linarith
  subst hz
  nlinarith [sq_nonneg ((x - y) * (2 * x + y) * (x + 2 * y)), sq_nonneg (x * y), sq_nonneg (x + y),
    sq_nonneg (x - y), mul_self_nonneg (x ^ 2 + x * y + y ^ 2)]

/-- **Step 8, the internal cross term vanishes** under orthogonality to the patterns. -/
theorem internal_cross_zero (x y z p p' a b c d s : ℝ) (h : x + y + z = 0)
    (h1 : p + p' = s) (h2 : a + b = s) (h3 : c + d = s) :
    z * (p + p') * (a + b) + y * (p + p') * (c + d) + x * (a + b) * (c + d) = 0 := by
  rw [h1, h2, h3]
  linear_combination s ^ 2 * h

/-- **Step 8, the largest pattern entry is at most `1/√3`**: `3 max(x,y,z)² ≤ 2(x²+y²+z²)` with `x + y + z = 0`,
shown for `x`, the other two by symmetry. -/
theorem pattern_entry_sq_le (x y z : ℝ) (h : x + y + z = 0) : 3 * x ^ 2 ≤ 2 * (x ^ 2 + y ^ 2 + z ^ 2) := by
  have hz : z = -x - y := by linarith
  subst hz
  nlinarith [sq_nonneg (x + 2 * y)]

/-- **Corollary (J), its witness.** If `e > Θ/2` and `P(d) ≥ 3e - 4e³/Θ²`, then at `c = Θ/(2e) < 1` the point
`c d + s ν` (unit, `ν` the top eigenvector of `L_d` on `V_Q`) has `P = (p - 3e)c³ + 3ec ≥ Θ`, a non-diagonal
point of `𝒟ₙ ⊕ V_Q` at or above `Θ`, which L220 excludes. -/
theorem J_witness (Θ e p : ℝ) (hΘ : 0 < Θ) (he : Θ / 2 < e) (hp : 3 * e - 4 * e ^ 3 / Θ ^ 2 ≤ p) :
    Θ / (2 * e) < 1 ∧ Θ ≤ (p - 3 * e) * (Θ / (2 * e)) ^ 3 + 3 * e * (Θ / (2 * e)) := by
  have he0 : 0 < e := by linarith
  refine ⟨by rw [div_lt_one (by positivity)]; linarith, ?_⟩
  have hc : (p - 3 * e) * (Θ / (2 * e)) ^ 3 ≥ (-(4 * e ^ 3 / Θ ^ 2)) * (Θ / (2 * e)) ^ 3 := by
    apply mul_le_mul_of_nonneg_right (by linarith) (by positivity)
  have h1 : (-(4 * e ^ 3 / Θ ^ 2)) * (Θ / (2 * e)) ^ 3 = -(Θ / 2) := by
    field_simp <;> ring
  have h2 : 3 * e * (Θ / (2 * e)) = 3 * Θ / 2 := by
    field_simp <;> ring
  rw [h2]
  linarith

/-- The hypotheses are met at padded `CP²`: `θ² = 3/2`, `a = N = 1/2`, `R = 0`, `κ = 0`, `p = θ³/6`. -/
example : (Real.sqrt (3 / 2)) ^ 2 ≤ 3 / 2 := by
  have hs : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have hpos : 0 < Real.sqrt (3 / 2) := Real.sqrt_pos.mpr (by norm_num)
  exact theta_sq_le (Real.sqrt (3 / 2)) (1 / 2) 0 (1 / 2) (Real.sqrt (3 / 2) ^ 3 / 6) 0 hpos le_rfl (by norm_num)
    (by norm_num) (by rw [hs]; norm_num) (by nlinarith [hs]) (by nlinarith) (by simp)

end HamiltonsCubic.L220Statement
