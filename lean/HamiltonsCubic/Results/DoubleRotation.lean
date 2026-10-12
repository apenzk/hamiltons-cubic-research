import Mathlib

/-!
# The double-rotation exchange, the arithmetic core

[reviews/2026-09-28-I121-MG-audit.md](../../../reviews/2026-09-28-I121-MG-audit.md), the
double-rotation inequality for route R52.

**What is typed.** Rotating by `π/4` in the planes `(1,2)` and `(3,4)` sends the bivectors
`e₁₃, e₁₄, e₂₃, e₂₄` to vectors whose coordinates are `±½`:
`e₁₃ ↦ (½,-½,-½,½)`, `e₁₄ ↦ (½,½,-½,-½)`, `e₂₃ ↦ (½,-½,½,-½)`, `e₂₄ ↦ (½,½,½,½)`, so the new
diagonal entries of the `4 × 4` block `M` are the quadratic forms of `M` at these vectors.
`block_exchange` is the change of the block's diagonal mass, exactly: the four-set combination
`M₀₃ + M₁₂` trades with the rectangle difference `M₀₀ - M₁₁ - M₂₂ + M₃₃`, and the two pair
combinations with the two remaining diagonal differences. `pair_exchange` is the same for a
rotation by `π/4` in one plane, acting on a `2 × 2` block `[[u, x], [x, v]]`.

**Not typed**: which entries of an operator on `Λ²ℝⁿ` form these blocks under the two rotations,
and that no other diagonal entry moves. That is the structural half, argued in the note.
-/

namespace HamiltonsCubic.DoubleRotation

/-- The quadratic form of a symmetric `4 × 4` matrix, entries `m i j` with `i ≤ j`, at `x`. -/
def qf4 (m00 m01 m02 m03 m11 m12 m13 m22 m23 m33 : ℝ) (x0 x1 x2 x3 : ℝ) : ℝ :=
  m00 * x0 ^ 2 + m11 * x1 ^ 2 + m22 * x2 ^ 2 + m33 * x3 ^ 2
    + 2 * (m01 * x0 * x1 + m02 * x0 * x2 + m03 * x0 * x3 + m12 * x1 * x2 + m13 * x1 * x3
      + m23 * x2 * x3)

/-- **THE BLOCK EXCHANGE.** The diagonal mass of the block after the double rotation by `π/4`,
minus the diagonal mass before, is the four-set term minus a quarter of the squared rectangle
difference, plus the two pair terms minus their diagonal differences. -/
theorem block_exchange (m00 m01 m02 m03 m11 m12 m13 m22 m23 m33 : ℝ) :
    let q := qf4 m00 m01 m02 m03 m11 m12 m13 m22 m23 m33
    q (1/2) (-1/2) (-1/2) (1/2) ^ 2 + q (1/2) (1/2) (-1/2) (-1/2) ^ 2
      + q (1/2) (-1/2) (1/2) (-1/2) ^ 2 + q (1/2) (1/2) (1/2) (1/2) ^ 2
      - (m00 ^ 2 + m11 ^ 2 + m22 ^ 2 + m33 ^ 2)
    = (m03 + m12) ^ 2 - (m00 - m11 - m22 + m33) ^ 2 / 4
      + (m01 + m23) ^ 2 - (m00 - m11 + m22 - m33) ^ 2 / 4
      + (m02 + m13) ^ 2 - (m00 + m11 - m22 - m33) ^ 2 / 4 := by
  simp only [qf4]
  ring

/-- **THE PAIR EXCHANGE.** A rotation by `π/4` in one plane sends a `2 × 2` block
`[[u, x], [x, v]]` to diagonal entries `(u+v)/2 ∓ x`, changing its diagonal mass by
`2 x² - (u - v)² / 2`. -/
theorem pair_exchange (u v x : ℝ) :
    ((u + v) / 2 - x) ^ 2 + ((u + v) / 2 + x) ^ 2 - (u ^ 2 + v ^ 2)
      = 2 * x ^ 2 - (u - v) ^ 2 / 2 := by
  ring

/-- The one-plane condition at every angle: `(cos ψ δ - sin ψ x)² ≤ δ²` for every `ψ`, summed
over a profile, forces `⟪δ, x⟫ = 0` and `‖x‖² ≤ ‖δ‖²`; stated here for the Gram data
`dd = ‖δ‖²`, `dx = ⟪δ, x⟫`, `xx = ‖x‖²`. -/
theorem one_plane (dd dx xx : ℝ)
    (h : ∀ c s : ℝ, c ^ 2 + s ^ 2 = 1 → c ^ 2 * dd - 2 * c * s * dx + s ^ 2 * xx ≤ dd) :
    xx ≤ dd ∧ dx = 0 := by
  -- the unit-circle condition, made homogeneous by scaling
  have hom : ∀ c s : ℝ, c ^ 2 * dd - 2 * c * s * dx + s ^ 2 * xx ≤ (c ^ 2 + s ^ 2) * dd := by
    intro c s
    by_cases h0 : c ^ 2 + s ^ 2 = 0
    · have hc : c = 0 := by nlinarith [sq_nonneg c, sq_nonneg s]
      have hs : s = 0 := by nlinarith [sq_nonneg c, sq_nonneg s]
      subst hc; subst hs; simp
    · have hpos : 0 < c ^ 2 + s ^ 2 := lt_of_le_of_ne (by positivity) (Ne.symm h0)
      set r := Real.sqrt (c ^ 2 + s ^ 2) with hr
      have hr2 : r ^ 2 = c ^ 2 + s ^ 2 := Real.sq_sqrt hpos.le
      have hrpos : 0 < r := Real.sqrt_pos.mpr hpos
      have hu := h (c / r) (s / r) (by rw [div_pow, div_pow, ← add_div, ← hr2]; field_simp)
      have key : c ^ 2 * dd - 2 * c * s * dx + s ^ 2 * xx
          = r ^ 2 * ((c / r) ^ 2 * dd - 2 * (c / r) * (s / r) * dx + (s / r) ^ 2 * xx) := by
        field_simp
      rw [key, ← hr2]
      exact mul_le_mul_of_nonneg_left hu (by positivity)
  refine ⟨by have := hom 0 1; nlinarith, ?_⟩
  -- a small rotation against the sign of the cross term
  set k := |xx - dd| + 1 with hk
  have hkpos : 0 < k := by positivity
  have h2 := hom 1 (-(dx / k))
  have h2' : (dx / k) ^ 2 * (xx - dd) + 2 * (dx / k) * dx ≤ 0 := by nlinarith [h2]
  have e : dx ^ 2 * (xx - dd + 2 * k) = k ^ 2 * ((dx / k) ^ 2 * (xx - dd) + 2 * (dx / k) * dx) := by
    field_simp
  have h3 : dx ^ 2 * (xx - dd + 2 * k) ≤ 0 := by rw [e]; nlinarith [sq_nonneg k, h2']
  have hpos : 0 < xx - dd + 2 * k := by
    have := neg_abs_le (xx - dd)
    rw [hk]; linarith [abs_nonneg (xx - dd)]
  have hdx : dx ^ 2 ≤ 0 := by nlinarith [sq_nonneg dx]
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp (le_antisymm hdx (sq_nonneg dx))

end HamiltonsCubic.DoubleRotation
