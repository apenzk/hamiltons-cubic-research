import HamiltonsCubic.Results.I67AdjugateEntries
import HamiltonsCubic.Results.I67Relabel

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# I67: `pf6`'s closed form, and the scalar identity the adjugate law was waiting on

[I67AdjugateEntries.lean](I67AdjugateEntries.lean) types all thirty-six entries of
`X σ₆(X) = -Pf(X) Id` against an explicit cubic, and records that the cubic is NOT related to
`pf6 X`. **That is what this file supplies.**

## How it gets past the ceiling that closed three routes

*`pf6 X` is `triple6 X X X`, six nested sums over `Fin 6`, and `simp` exceeds its step ceiling on
that expansion whether staged or not, and even at a concrete basis triple.* **The route here
expands nothing.** [star_wedge_pairing](I67Relabel.lean) is proved by reindexing, so at `Z = X` it
gives `⟪star6 (wedgeSelf X), X⟫ = 12 · pf6 X` without touching the `6⁶` terms, and the left side is
a thirty-six-term double sum whose six diagonal terms vanish and whose thirty others reduce by
skewness to the FIFTEEN `sigma_i_j` theorems.

**GATE 2 PASSED**, r993, sole reviewer by design, all ten rows CONFIRMED, *which recomputed the
fifteen signed matchings independently and pinned the OVERALL sign: the cubic is `+Pf` in the
layer's own normalisation.*

**So the Pfaffian is read off the adjugate rather than expanded**, which is the transferable half:
a route blocked by a step limit is unblocked by reindexing rather than by a larger limit.
-/

namespace HamiltonsCubic.I67Pf6

open HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer HamiltonsCubic.I67AdjugateLaw
  HamiltonsCubic.I67Relabel

set_option maxHeartbeats 4000000
set_option maxRecDepth 200000

variable (X : Matrix (Fin 6) (Fin 6) ℝ)

/-- **`pf6 X` in the fifteen free entries of a skew `6×6`.** *The scalar identity
[I67AdjugateEntries.lean](I67AdjugateEntries.lean) named as its whole remaining debt.* -/
theorem pf6_eq (hX : IsSkew X) :
    pf6 X = (X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3) := by
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
  have hhalf : ∀ a b : Fin 6, star6 (wedgeSelf X) a b
      = 2 * (((1/2 : ℝ) • star6 (wedgeSelf X)) a b) := by
    intro a b; simp only [Matrix.smul_apply, smul_eq_mul]; ring
  have hp := star_wedge_pairing X X
  have hval : (∑ a : Fin 6, ∑ b : Fin 6, star6 (wedgeSelf X) a b * X a b)
      = 12 * ((X 0 1)*(X 2 3)*(X 4 5) - (X 0 1)*(X 2 4)*(X 3 5) + (X 0 1)*(X 2 5)*(X 3 4) - (X 0 2)*(X 1 3)*(X 4 5) + (X 0 2)*(X 1 4)*(X 3 5) - (X 0 2)*(X 1 5)*(X 3 4) + (X 0 3)*(X 1 2)*(X 4 5) - (X 0 3)*(X 1 4)*(X 2 5) + (X 0 3)*(X 1 5)*(X 2 4) - (X 0 4)*(X 1 2)*(X 3 5) + (X 0 4)*(X 1 3)*(X 2 5) - (X 0 4)*(X 1 5)*(X 2 3) + (X 0 5)*(X 1 2)*(X 3 4) - (X 0 5)*(X 1 3)*(X 2 4) + (X 0 5)*(X 1 4)*(X 2 3)) := by
    simp only [Fin.sum_univ_six, hhalf]
    rw [hd 0, hd 1, hd 2, hd 3, hd 4, hd 5]
    rw [hsk 0 1, hsk 0 2, hsk 0 3, hsk 0 4, hsk 0 5, hsk 1 2, hsk 1 3, hsk 1 4, hsk 1 5, hsk 2 3, hsk 2 4, hsk 2 5, hsk 3 4, hsk 3 5, hsk 4 5]
    rw [sigma_0_1 X hX, sigma_0_2 X hX, sigma_0_3 X hX, sigma_0_4 X hX, sigma_0_5 X hX, sigma_1_2 X hX, sigma_1_3 X hX, sigma_1_4 X hX, sigma_1_5 X hX, sigma_2_3 X hX, sigma_2_4 X hX, sigma_2_5 X hX, sigma_3_4 X hX, sigma_3_5 X hX, sigma_4_5 X hX]
    simp only [e10, e20, e30, e40, e50, e21, e31, e41, e51, e32, e42, e52, e43, e53, e54, xd0, xd1, xd2, xd3, xd4, xd5]
    ring
  rw [hval] at hp
  unfold pf6
  linarith [hp]

end HamiltonsCubic.I67Pf6
