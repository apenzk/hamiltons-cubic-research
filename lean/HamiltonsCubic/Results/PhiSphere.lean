import HamiltonsCubic.Base.WeylReal

/-!
# The two components of `Φ` are not independent: `Φ` sends the unit sphere to a sphere

**Why this matters to the census.** [L183](../../../findings/diagonal-half.md)'s map is
`Φ(ω) = (ω², ω∧ω)`, and every estimate the two-negative chain has tried reads its two components
separately. *They are linked by an exact identity rather than by an inequality.*

At singular values `σᵢ` a unit bivector has `Σσᵢ² = 1`, and then `tr(ω⁴) = 2Σσᵢ⁴` while
`‖ω∧ω‖² = 2(1 - Σσᵢ⁴)`. **So the sum is constant**, and in the homogeneous form that holds at every
skew matrix rather than only at unit norm:

`tr(ω⁴) + ‖ω∧ω‖² = 2⟨ω,ω⟩²`.

**The consequence for the census**: the four points `Φ(v_α)` lie on a sphere of radius `√2`, while
the target `B = (-(2/n)·Id, 0)` has `‖B‖² = 4/n`, strictly inside it at every `n > 2`. *So the
census is four points on a sphere with one named interior point in their affine hull.*

**This file proves the identity at `dim = 4`**, where `Λ⁴` is a line and `ω∧ω` is `2·Pf(ω)` times
the volume form, so `‖ω∧ω‖² = 4Pf(ω)²`. *The general-dimension statement needs a `Λ⁴` the base layer
does not carry, and is owed.*
-/

set_option linter.style.longLine false
set_option maxHeartbeats 1000000

namespace HamiltonsCubic.RealLayer

open Matrix

/-- The Pfaffian of a `4 × 4` skew matrix, `ω₀₁ω₂₃ - ω₀₂ω₁₃ + ω₀₃ω₁₂`. -/
def pf4 (w : Matrix (Fin 4) (Fin 4) ℝ) : ℝ :=
  w 0 1 * w 2 3 - w 0 2 * w 1 3 + w 0 3 * w 1 2

/-- **`tr(ω⁴) + 4·Pf(ω)² = 2⟨ω,ω⟩²` at every skew `4 × 4` matrix.**

*`4·Pf(ω)²` is `‖ω∧ω‖²`, `Λ⁴ℝ⁴` being a line spanned by the volume form and `ω∧ω` being `2Pf(ω)`
times it.* **So the two components of `Φ` trade off exactly**, and a configuration cannot make the
`S²` part and the `Λ⁴` part both large. -/
theorem trace_pow_four_add_pf_sq (w : Matrix (Fin 4) (Fin 4) ℝ) (hw : IsSkew w) :
    (w ^ 4).trace + 4 * pf4 w ^ 2 = 2 * (inner2 w w) ^ 2 := by
  have hs : ∀ a b : Fin 4, w b a = - w a b := by
    intro a b
    have := congrFun (congrFun hw a) b
    simpa [Matrix.transpose_apply] using this
  have hd : ∀ a : Fin 4, w a a = 0 := by intro a; have := hs a a; linarith
  simp only [pf4, inner2, Matrix.trace, Matrix.diag_apply, pow_succ, pow_zero, one_mul,
    Matrix.mul_apply, Matrix.transpose_apply, Fin.sum_univ_four]
  simp only [hd, hs 0 1, hs 0 2, hs 0 3, hs 1 2, hs 1 3, hs 2 3]
  ring

/-- **The `4 × 4` Pfaffian on the principal submatrix at `i < j < k < l`**, which is
`(ω ∧ ω)_{ijkl} / 2`. *At `dim = 4` there is one such index set and `w4` is `pf4`.* -/
def w4 (w : Matrix (Fin 6) (Fin 6) ℝ) (i j k l : Fin 6) : ℝ :=
  w i j * w k l - w i k * w j l + w i l * w j k

-- `ring` closes a degree-four identity in fifteen variables with the trace expanded over 6^4 terms
set_option maxHeartbeats 4000000 in
/-- **The same identity at `dim = 6`, over all fifteen index sets.** *`ring` closes it after the
skew substitutions, so the constant `4` is checked by the kernel at two dimensions rather than read
off one.* **This is the shape the general statement takes**: `tr(ω⁴) + 4∑_{i<j<k<l} w4² = 2⟨ω,ω⟩²`,
with `w4` carrying the `Λ⁴` component at each index set. -/
theorem phi_sphere6 (w : Matrix (Fin 6) (Fin 6) ℝ) (hw : IsSkew w) :
    (w ^ 4).trace
      + 4 * (w4 w 0 1 2 3 ^ 2 + w4 w 0 1 2 4 ^ 2 + w4 w 0 1 2 5 ^ 2 + w4 w 0 1 3 4 ^ 2
        + w4 w 0 1 3 5 ^ 2 + w4 w 0 1 4 5 ^ 2 + w4 w 0 2 3 4 ^ 2 + w4 w 0 2 3 5 ^ 2
        + w4 w 0 2 4 5 ^ 2 + w4 w 0 3 4 5 ^ 2 + w4 w 1 2 3 4 ^ 2 + w4 w 1 2 3 5 ^ 2
        + w4 w 1 2 4 5 ^ 2 + w4 w 1 3 4 5 ^ 2 + w4 w 2 3 4 5 ^ 2)
      = 2 * (inner2 w w) ^ 2 := by
  have hs : ∀ a b : Fin 6, w b a = - w a b := by
    intro a b
    have := congrFun (congrFun hw a) b
    simpa [Matrix.transpose_apply] using this
  have hd : ∀ a : Fin 6, w a a = 0 := by intro a; have := hs a a; linarith
  simp only [w4, inner2, Matrix.trace, Matrix.diag_apply, pow_succ, pow_zero, one_mul,
    Matrix.mul_apply, Matrix.transpose_apply, Fin.sum_univ_six]
  simp only [hd, hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5,
    hs 2 3, hs 2 4, hs 2 5, hs 3 4, hs 3 5, hs 4 5]
  ring


/-- **The bilinear wedge component**, polarising `w4`: `wbil a a = w4 a`. -/
noncomputable def wbil (a b : Matrix (Fin 6) (Fin 6) ℝ) (i j k l : Fin 6) : ℝ :=
  (a i j * b k l + b i j * a k l - a i k * b j l - b i k * a j l
    + a i l * b j k + b i l * a j k) / 2

/-- `wbil` polarises `w4`. -/
theorem wbil_self (a : Matrix (Fin 6) (Fin 6) ℝ) (i j k l : Fin 6) :
    wbil a a i j k l = w4 a i j k l := by
  simp only [wbil, w4]; ring

/-- **Equal self-wedges is a difference of squares.** *`(a - b) ∧ (a + b) = a∧a - b∧b`, because the
wedge of two `2`-forms is symmetric at even degree.* **This is the identity the Lefschetz route to
the surviving rank-three question turns on**: it converts `ω₁∧ω₁ = ω₂∧ω₂` into `α ∧ β = 0` at
`α = ω₁ - ω₂` and `β = ω₁ + ω₂`, where a nondegenerate factor makes `L` injective at `m ≥ 3`. -/
theorem wbil_sub_add (a b : Matrix (Fin 6) (Fin 6) ℝ) (i j k l : Fin 6) :
    wbil (a - b) (a + b) i j k l = w4 a i j k l - w4 b i j k l := by
  simp only [wbil, w4, Matrix.sub_apply, Matrix.add_apply]; ring

end HamiltonsCubic.RealLayer
