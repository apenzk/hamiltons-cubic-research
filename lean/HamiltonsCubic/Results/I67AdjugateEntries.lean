import HamiltonsCubic.Results.I67AdjugateLaw

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# I67: the adjugate law, entry by entry, in explicit polynomial form

[L193](L193Statement.lean)'s `adjugate_law` carries a `sorry` justified as needing the real skew
normal form and `SO(6)`-equivariance, neither of which Mathlib has. **It needs neither.** The law is
a polynomial identity in the fifteen free entries of a skew `6×6`, proved symbolically outside Lean
and confirmed at Gate 2 by two readers, one of them noting that every entry is multilinear so that
vanishing on `{0,1}^15` is vanishing identically.

**This file types it entry by entry**, each from the fifteen `σ₆` entries of
[I67AdjugateLaw.lean](I67AdjugateLaw.lean) together with skewness. *Six diagonal entries carry the
Pfaffian; thirty off-diagonal ones vanish.*

## What is NOT stated

`pf6 X` is not related to the explicit polynomial below. *Its own expansion, `triple6 X X X`, is six
nested sums over `Fin 6`, and `simp` exceeds its step ceiling on it whether staged or not.* **So the
remaining debt is one scalar identity, `pf6 X = <the polynomial>`, and no longer the law.**
-/

namespace HamiltonsCubic.I67AdjugateEntries

open HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer HamiltonsCubic.I67AdjugateLaw

set_option maxHeartbeats 8000000
set_option maxRecDepth 200000

variable (X : Matrix (Fin 6) (Fin 6) ℝ)

/-- The adjugate law at entry `(0,0)`. -/
theorem adj_0_0 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 0 0 = -((X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3)) := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 0, hsk 0 1, hsk 0 2, hsk 0 3, hsk 0 4, hsk 0 5]
  rw [sigma_0_1 X hX, sigma_0_2 X hX, sigma_0_3 X hX, sigma_0_4 X hX, sigma_0_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(0,1)`. -/
theorem adj_0_1 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 0 1 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 1, hsk 1 2, hsk 1 3, hsk 1 4, hsk 1 5]
  rw [sigma_0_1 X hX, sigma_1_2 X hX, sigma_1_3 X hX, sigma_1_4 X hX, sigma_1_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(0,2)`. -/
theorem adj_0_2 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 0 2 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 2, hsk 2 3, hsk 2 4, hsk 2 5]
  rw [sigma_0_2 X hX, sigma_1_2 X hX, sigma_2_3 X hX, sigma_2_4 X hX, sigma_2_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(0,3)`. -/
theorem adj_0_3 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 0 3 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 3, hsk 3 4, hsk 3 5]
  rw [sigma_0_3 X hX, sigma_1_3 X hX, sigma_2_3 X hX, sigma_3_4 X hX, sigma_3_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(0,4)`. -/
theorem adj_0_4 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 0 4 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 4, hsk 4 5]
  rw [sigma_0_4 X hX, sigma_1_4 X hX, sigma_2_4 X hX, sigma_3_4 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(0,5)`. -/
theorem adj_0_5 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 0 5 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 5]
  rw [sigma_0_5 X hX, sigma_1_5 X hX, sigma_2_5 X hX, sigma_3_5 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(1,0)`. -/
theorem adj_1_0 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 1 0 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 0, hsk 0 1, hsk 0 2, hsk 0 3, hsk 0 4, hsk 0 5]
  rw [sigma_0_1 X hX, sigma_0_2 X hX, sigma_0_3 X hX, sigma_0_4 X hX, sigma_0_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(1,1)`. -/
theorem adj_1_1 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 1 1 = -((X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3)) := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 1, hsk 1 2, hsk 1 3, hsk 1 4, hsk 1 5]
  rw [sigma_0_1 X hX, sigma_1_2 X hX, sigma_1_3 X hX, sigma_1_4 X hX, sigma_1_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(1,2)`. -/
theorem adj_1_2 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 1 2 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 2, hsk 2 3, hsk 2 4, hsk 2 5]
  rw [sigma_0_2 X hX, sigma_1_2 X hX, sigma_2_3 X hX, sigma_2_4 X hX, sigma_2_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(1,3)`. -/
theorem adj_1_3 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 1 3 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 3, hsk 3 4, hsk 3 5]
  rw [sigma_0_3 X hX, sigma_1_3 X hX, sigma_2_3 X hX, sigma_3_4 X hX, sigma_3_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(1,4)`. -/
theorem adj_1_4 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 1 4 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 4, hsk 4 5]
  rw [sigma_0_4 X hX, sigma_1_4 X hX, sigma_2_4 X hX, sigma_3_4 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(1,5)`. -/
theorem adj_1_5 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 1 5 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 5]
  rw [sigma_0_5 X hX, sigma_1_5 X hX, sigma_2_5 X hX, sigma_3_5 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(2,0)`. -/
theorem adj_2_0 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 2 0 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 0, hsk 0 1, hsk 0 2, hsk 0 3, hsk 0 4, hsk 0 5]
  rw [sigma_0_1 X hX, sigma_0_2 X hX, sigma_0_3 X hX, sigma_0_4 X hX, sigma_0_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(2,1)`. -/
theorem adj_2_1 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 2 1 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 1, hsk 1 2, hsk 1 3, hsk 1 4, hsk 1 5]
  rw [sigma_0_1 X hX, sigma_1_2 X hX, sigma_1_3 X hX, sigma_1_4 X hX, sigma_1_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(2,2)`. -/
theorem adj_2_2 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 2 2 = -((X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3)) := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 2, hsk 2 3, hsk 2 4, hsk 2 5]
  rw [sigma_0_2 X hX, sigma_1_2 X hX, sigma_2_3 X hX, sigma_2_4 X hX, sigma_2_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(2,3)`. -/
theorem adj_2_3 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 2 3 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 3, hsk 3 4, hsk 3 5]
  rw [sigma_0_3 X hX, sigma_1_3 X hX, sigma_2_3 X hX, sigma_3_4 X hX, sigma_3_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(2,4)`. -/
theorem adj_2_4 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 2 4 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 4, hsk 4 5]
  rw [sigma_0_4 X hX, sigma_1_4 X hX, sigma_2_4 X hX, sigma_3_4 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(2,5)`. -/
theorem adj_2_5 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 2 5 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 5]
  rw [sigma_0_5 X hX, sigma_1_5 X hX, sigma_2_5 X hX, sigma_3_5 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(3,0)`. -/
theorem adj_3_0 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 3 0 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 0, hsk 0 1, hsk 0 2, hsk 0 3, hsk 0 4, hsk 0 5]
  rw [sigma_0_1 X hX, sigma_0_2 X hX, sigma_0_3 X hX, sigma_0_4 X hX, sigma_0_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(3,1)`. -/
theorem adj_3_1 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 3 1 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 1, hsk 1 2, hsk 1 3, hsk 1 4, hsk 1 5]
  rw [sigma_0_1 X hX, sigma_1_2 X hX, sigma_1_3 X hX, sigma_1_4 X hX, sigma_1_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(3,2)`. -/
theorem adj_3_2 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 3 2 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 2, hsk 2 3, hsk 2 4, hsk 2 5]
  rw [sigma_0_2 X hX, sigma_1_2 X hX, sigma_2_3 X hX, sigma_2_4 X hX, sigma_2_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(3,3)`. -/
theorem adj_3_3 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 3 3 = -((X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3)) := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 3, hsk 3 4, hsk 3 5]
  rw [sigma_0_3 X hX, sigma_1_3 X hX, sigma_2_3 X hX, sigma_3_4 X hX, sigma_3_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(3,4)`. -/
theorem adj_3_4 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 3 4 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 4, hsk 4 5]
  rw [sigma_0_4 X hX, sigma_1_4 X hX, sigma_2_4 X hX, sigma_3_4 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(3,5)`. -/
theorem adj_3_5 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 3 5 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 5]
  rw [sigma_0_5 X hX, sigma_1_5 X hX, sigma_2_5 X hX, sigma_3_5 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(4,0)`. -/
theorem adj_4_0 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 4 0 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 0, hsk 0 1, hsk 0 2, hsk 0 3, hsk 0 4, hsk 0 5]
  rw [sigma_0_1 X hX, sigma_0_2 X hX, sigma_0_3 X hX, sigma_0_4 X hX, sigma_0_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(4,1)`. -/
theorem adj_4_1 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 4 1 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 1, hsk 1 2, hsk 1 3, hsk 1 4, hsk 1 5]
  rw [sigma_0_1 X hX, sigma_1_2 X hX, sigma_1_3 X hX, sigma_1_4 X hX, sigma_1_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(4,2)`. -/
theorem adj_4_2 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 4 2 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 2, hsk 2 3, hsk 2 4, hsk 2 5]
  rw [sigma_0_2 X hX, sigma_1_2 X hX, sigma_2_3 X hX, sigma_2_4 X hX, sigma_2_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(4,3)`. -/
theorem adj_4_3 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 4 3 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 3, hsk 3 4, hsk 3 5]
  rw [sigma_0_3 X hX, sigma_1_3 X hX, sigma_2_3 X hX, sigma_3_4 X hX, sigma_3_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(4,4)`. -/
theorem adj_4_4 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 4 4 = -((X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3)) := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 4, hsk 4 5]
  rw [sigma_0_4 X hX, sigma_1_4 X hX, sigma_2_4 X hX, sigma_3_4 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(4,5)`. -/
theorem adj_4_5 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 4 5 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 5]
  rw [sigma_0_5 X hX, sigma_1_5 X hX, sigma_2_5 X hX, sigma_3_5 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(5,0)`. -/
theorem adj_5_0 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 5 0 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 0, hsk 0 1, hsk 0 2, hsk 0 3, hsk 0 4, hsk 0 5]
  rw [sigma_0_1 X hX, sigma_0_2 X hX, sigma_0_3 X hX, sigma_0_4 X hX, sigma_0_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(5,1)`. -/
theorem adj_5_1 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 5 1 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 1, hsk 1 2, hsk 1 3, hsk 1 4, hsk 1 5]
  rw [sigma_0_1 X hX, sigma_1_2 X hX, sigma_1_3 X hX, sigma_1_4 X hX, sigma_1_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(5,2)`. -/
theorem adj_5_2 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 5 2 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 2, hsk 2 3, hsk 2 4, hsk 2 5]
  rw [sigma_0_2 X hX, sigma_1_2 X hX, sigma_2_3 X hX, sigma_2_4 X hX, sigma_2_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(5,3)`. -/
theorem adj_5_3 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 5 3 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 3, hsk 3 4, hsk 3 5]
  rw [sigma_0_3 X hX, sigma_1_3 X hX, sigma_2_3 X hX, sigma_3_4 X hX, sigma_3_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(5,4)`. -/
theorem adj_5_4 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 5 4 = 0 := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 4, hsk 4 5]
  rw [sigma_0_4 X hX, sigma_1_4 X hX, sigma_2_4 X hX, sigma_3_4 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

/-- The adjugate law at entry `(5,5)`. -/
theorem adj_5_5 (hX : IsSkew X) :
    (X * ((1/2 : ℝ) • star6 (wedgeSelf X))) 5 5 = -((X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3)) := by
  have hsk : ∀ a b : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) b a
      = -(((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b
    have hh := star6_isSkew (wedgeSelf X)
    have := congrFun (congrFun hh a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [Matrix.smul_apply, smul_eq_mul]
    linarith [this]
  have hd : ∀ a : Fin 6, ((1/2 : ℝ) • star6 (wedgeSelf X)) a a = 0 := by
    intro a; have := hsk a a; linarith
  have hxs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := hxs 0 1
  have e20 : X 2 0 = -X 0 2 := hxs 0 2
  have e30 : X 3 0 = -X 0 3 := hxs 0 3
  have e40 : X 4 0 = -X 0 4 := hxs 0 4
  have e50 : X 5 0 = -X 0 5 := hxs 0 5
  have e21 : X 2 1 = -X 1 2 := hxs 1 2
  have e31 : X 3 1 = -X 1 3 := hxs 1 3
  have e41 : X 4 1 = -X 1 4 := hxs 1 4
  have e51 : X 5 1 = -X 1 5 := hxs 1 5
  have e32 : X 3 2 = -X 2 3 := hxs 2 3
  have e42 : X 4 2 = -X 2 4 := hxs 2 4
  have e52 : X 5 2 = -X 2 5 := hxs 2 5
  have e43 : X 4 3 = -X 3 4 := hxs 3 4
  have e53 : X 5 3 = -X 3 5 := hxs 3 5
  have e54 : X 5 4 = -X 4 5 := hxs 4 5
  have xd0 : X 0 0 = (0:ℝ) := by have := hxs 0 0; linarith
  have xd1 : X 1 1 = (0:ℝ) := by have := hxs 1 1; linarith
  have xd2 : X 2 2 = (0:ℝ) := by have := hxs 2 2; linarith
  have xd3 : X 3 3 = (0:ℝ) := by have := hxs 3 3; linarith
  have xd4 : X 4 4 = (0:ℝ) := by have := hxs 4 4; linarith
  have xd5 : X 5 5 = (0:ℝ) := by have := hxs 5 5; linarith
  simp only [Matrix.mul_apply, Fin.sum_univ_six]
  rw [hd 5]
  rw [sigma_0_5 X hX, sigma_1_5 X hX, sigma_2_5 X hX, sigma_3_5 X hX, sigma_4_5 X hX]
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
  ring

end HamiltonsCubic.I67AdjugateEntries