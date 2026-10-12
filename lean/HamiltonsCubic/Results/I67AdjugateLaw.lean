import HamiltonsCubic.Base.SelfDual
import HamiltonsCubic.Base.Pfaffian6

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# I67: the entries of `σ₆`, expanded, and why L193's `sorry` is not blocked by Mathlib

## What this file is

[L193](L193Statement.lean)'s `adjugate_law`, `X · σ₆(X) = -Pf(X)·Id` at every skew `X` on `ℝ⁶`,
carries a `sorry` justified as needing *"the real skew normal form together with the `SO(6)`-
equivariance of `⋆`, `∧` and the Pfaffian"*, with the note that **Mathlib carries neither in a
usable shape**. That describes the frame-adapted proof strategy, not the statement.

**The law is PROVED as a polynomial identity**, expanded symbolically over the `15` free entries to
identically zero, so it needs no normal form and no equivariance. *Gate 2 supplied that proof: the
record's earlier warrant was 300 samples, which both readers showed insufficient, cubics in `15`
variables spanning `680` dimensions.* *`levi6` is nonzero
only on the `4! = 24` all-distinct tuples per index pair, so each `σ₆` entry is `24` quadratic
terms.* **This file expands them.**

## What is proved

The fifteen entries `σ₆(X) i j` for `i < j`, each in closed form: the Pfaffian of the complementary
four-set, signed by the permutation. *Together with `star6_isSkew`, already in the layer, these
determine `σ₆` completely.*

## What is NOT stated, and the obstacle is named with its way round

`adjugate_law` itself, which is these entries multiplied into `X` and compared against `pf6`. **The
remaining work is a finite expansion and no longer a missing piece of Mathlib**, which is the point
of this file.

**THE OBSTACLE IS `simp`'s STEP LIMIT, NOT MATHLIB.** *`pf6 X = triple6 X X X` is SIX nested sums,
`6^6 = 46656` terms against `star6`'s `6^4 = 1296`. Expanding it directly exceeds the limit even at
`maxSteps := 2·10^7`, after thirty-six seconds of work, and STAGING does not help: unfolding the
sums first and `levi6` second in separate calls hits the same ceiling, so the budget is not being
shared between them and the sum alone is what exceeds it.*

**THE WAY ROUND REUSES THE ENTRIES ABOVE.** Pairing the reduction `⟪star6 (wedgeSelf X), Z⟫ =
12 triple6 (Z, X, X)` at `Z = X` gives

  `⟪σ₆ X, X⟫ = 6 · pf6 X`,   hence   `pf6 X = (1/3) · Σ_{a<b} σ₆(X)_{ab} · X_{ab}`,

*and the reduction it comes from, `Σ_{ab} (star6 (wedgeSelf X))_{ab} Z_{ab} = 12 · triple6 Z X X`, holds at EVERY `X` and `Z` with no hypothesis, skewness included: the wedge's three terms are relabellings of one another under `ε`'s antisymmetry.*

*a THIRTY-term sum whose every entry is one of the fifteen theorems above, instead of a
forty-six-thousand-term one.* **Screened to `2.6·10⁻¹³` over four hundred skew draws**
([screen_I67_star_wedge.py](../../../scripts/misc/screen_I67_star_wedge.py)). *What that route still
owes in Lean is the reduction itself, an index identity between `star6` and `triple6`.*

*Gate 2 owed.*
-/

namespace HamiltonsCubic.I67AdjugateLaw

open HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer

set_option maxHeartbeats 4000000
set_option maxRecDepth 100000

variable (X : Matrix (Fin 6) (Fin 6) ℝ)

/-- `σ₆(X)` at `(0,1)`: the Pfaffian of the complementary four-set. -/
theorem sigma_0_1 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 0 1 = (X 2 3)*(X 4 5) - (X 2 4)*(X 3 5) + (X 2 5)*(X 3 4) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(0,2)`: the Pfaffian of the complementary four-set. -/
theorem sigma_0_2 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 0 2 = -(X 1 3)*(X 4 5) + (X 1 4)*(X 3 5) - (X 1 5)*(X 3 4) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(0,3)`: the Pfaffian of the complementary four-set. -/
theorem sigma_0_3 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 0 3 = (X 1 2)*(X 4 5) - (X 1 4)*(X 2 5) + (X 1 5)*(X 2 4) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(0,4)`: the Pfaffian of the complementary four-set. -/
theorem sigma_0_4 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 0 4 = -(X 1 2)*(X 3 5) + (X 1 3)*(X 2 5) - (X 1 5)*(X 2 3) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(0,5)`: the Pfaffian of the complementary four-set. -/
theorem sigma_0_5 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 0 5 = (X 1 2)*(X 3 4) - (X 1 3)*(X 2 4) + (X 1 4)*(X 2 3) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(1,2)`: the Pfaffian of the complementary four-set. -/
theorem sigma_1_2 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 1 2 = (X 0 3)*(X 4 5) - (X 0 4)*(X 3 5) + (X 0 5)*(X 3 4) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(1,3)`: the Pfaffian of the complementary four-set. -/
theorem sigma_1_3 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 1 3 = -(X 0 2)*(X 4 5) + (X 0 4)*(X 2 5) - (X 0 5)*(X 2 4) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(1,4)`: the Pfaffian of the complementary four-set. -/
theorem sigma_1_4 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 1 4 = (X 0 2)*(X 3 5) - (X 0 3)*(X 2 5) + (X 0 5)*(X 2 3) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(1,5)`: the Pfaffian of the complementary four-set. -/
theorem sigma_1_5 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 1 5 = -(X 0 2)*(X 3 4) + (X 0 3)*(X 2 4) - (X 0 4)*(X 2 3) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(2,3)`: the Pfaffian of the complementary four-set. -/
theorem sigma_2_3 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 2 3 = (X 0 1)*(X 4 5) - (X 0 4)*(X 1 5) + (X 0 5)*(X 1 4) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(2,4)`: the Pfaffian of the complementary four-set. -/
theorem sigma_2_4 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 2 4 = -(X 0 1)*(X 3 5) + (X 0 3)*(X 1 5) - (X 0 5)*(X 1 3) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(2,5)`: the Pfaffian of the complementary four-set. -/
theorem sigma_2_5 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 2 5 = (X 0 1)*(X 3 4) - (X 0 3)*(X 1 4) + (X 0 4)*(X 1 3) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(3,4)`: the Pfaffian of the complementary four-set. -/
theorem sigma_3_4 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 3 4 = (X 0 1)*(X 2 5) - (X 0 2)*(X 1 5) + (X 0 5)*(X 1 2) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(3,5)`: the Pfaffian of the complementary four-set. -/
theorem sigma_3_5 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 3 5 = -(X 0 1)*(X 2 4) + (X 0 2)*(X 1 4) - (X 0 4)*(X 1 2) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

/-- `σ₆(X)` at `(4,5)`: the Pfaffian of the complementary four-set. -/
theorem sigma_4_5 (hX : IsSkew X) :
    ((1/2 : ℝ) • star6 (wedgeSelf X)) 4 5 = (X 0 1)*(X 2 3) - (X 0 2)*(X 1 3) + (X 0 3)*(X 1 2) := by
  have h : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith [this]
  have e10 : X 1 0 = -X 0 1 := h 0 1
  have e20 : X 2 0 = -X 0 2 := h 0 2
  have e30 : X 3 0 = -X 0 3 := h 0 3
  have e40 : X 4 0 = -X 0 4 := h 0 4
  have e50 : X 5 0 = -X 0 5 := h 0 5
  have e21 : X 2 1 = -X 1 2 := h 1 2
  have e31 : X 3 1 = -X 1 3 := h 1 3
  have e41 : X 4 1 = -X 1 4 := h 1 4
  have e51 : X 5 1 = -X 1 5 := h 1 5
  have e32 : X 3 2 = -X 2 3 := h 2 3
  have e42 : X 4 2 = -X 2 4 := h 2 4
  have e52 : X 5 2 = -X 2 5 := h 2 5
  have e43 : X 4 3 = -X 3 4 := h 3 4
  have e53 : X 5 3 = -X 3 5 := h 3 5
  have e54 : X 5 4 = -X 4 5 := h 4 5
  have d0 : X 0 0 = (0:ℝ) := by have := h 0 0; linarith
  have d1 : X 1 1 = (0:ℝ) := by have := h 1 1; linarith
  have d2 : X 2 2 = (0:ℝ) := by have := h 2 2; linarith
  have d3 : X 3 3 = (0:ℝ) := by have := h 3 3; linarith
  have d4 : X 4 4 = (0:ℝ) := by have := h 4 4; linarith
  have d5 : X 5 5 = (0:ℝ) := by have := h 5 5; linarith
  simp only [Matrix.smul_apply, smul_eq_mul, star6_apply, wedgeSelf, wedge2, halfw,
             Pi.add_apply, Fin.sum_univ_six, levi6, sgnR, Fin.lt_def]
  norm_num
  simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, d0, d1, d2, d3, d4, d5]
  ring

end HamiltonsCubic.I67AdjugateLaw
