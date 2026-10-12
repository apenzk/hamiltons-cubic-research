import HamiltonsCubic.Results.EigenFrameExist
import HamiltonsCubic.Results.L30Statement

set_option linter.style.longLine false

/-!
# L30 and L164 at every linear Weyl operator

[L30Statement.lean](L30Statement.lean)'s `L30_padding` takes an orthonormal eigenframe of `W` as the
hypothesis `hframe`, in its own `Eigenframe` form (completeness as
span membership). **This file supplies it**:

- `eigenframe30_exists`: [EigenFrameExist.lean](EigenFrameExist.lean)'s frame is an `Eigenframe`;
- `L30_padding_exists`: **for every nonzero linear Weyl `W` whose negative support has dimension
  below `n`, the padding of L30 and L164 holds**, the frame being built rather than assumed;
- `L30_support_exists`: L30's support clause at the same frame.

The negative support is `ran W₋`, a function of `W` alone, so the choice of Mathlib's frame among
the eigenframes changes nothing. The existential exports `IsWeyl W'`; `W'` is linear on bivectors by
`conj_eq`, and re-entering these theorems at `W'` takes that step.
-/

namespace HamiltonsCubic.L30Exists

open HamiltonsCubic.RealLayer HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind
  HamiltonsCubic.L30Statement Matrix

variable {n : ℕ}

theorem eigenframe30_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) :
    Eigenframe W (frameVec W hW.1 hW.2.1 hW.2.2.1)
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues where
  skew := frameVec_skew W hW.1 hW.2.1 hW.2.2.1
  orthonormal := frameVec_orth W hW.1 hW.2.1 hW.2.2.1
  eigen := frameVec_eigen W hW.1 hW.2.1 hW.2.2.1
  complete X hX := by
    rw [frameVec_complete W hW.1 hW.2.1 hW.2.2.1 X hX]
    exact Submodule.sum_mem _ fun k _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨k, rfl⟩)

/-- The dimension of the negative support of the built frame. -/
noncomputable abbrev dNeg (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W) : ℕ :=
  Module.finrank ℝ (negSupport (frameVec W hW.1 hW.2.1 hW.2.2.1)
    (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues)

/-- **L30's padding, and L164's clause, at every nonzero linear Weyl `W`.** -/
theorem L30_padding_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (hW0 : W ≠ fun _ => 0) (hdim : dNeg W hW < n) :
    ∃ (E : Matrix (Fin n) (Fin (dNeg W hW)) ℝ)
      (W' : Matrix (Fin (dNeg W hW)) (Fin (dNeg W hW)) ℝ → Matrix (Fin (dNeg W hW)) (Fin (dNeg W hW)) ℝ),
      Eᵀ * E = 1 ∧
      LinearMap.range (Matrix.mulVecLin E) = negSupport (frameVec W hW.1 hW.2.1 hW.2.2.1)
          (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues ∧
      IsWeyl W' ∧
      (∀ X, IsSkew X → W (E * X * Eᵀ) = E * W' X * Eᵀ) ∧
      RealLayer.norm W' = RealLayer.norm W ∧ theta W' = theta W :=
  L30_padding W hW.2 hW0 _ _ (eigenframe30_exists W hW) (by simpa using hdim)

/-- **L30's support clause at every linear Weyl `W`**: `W` kills `u ∧ w` for every `u` orthogonal
to the negative support. -/
theorem L30_support_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (hdim : dNeg W hW < n) (u : Fin n → ℝ)
    (hu : ∀ x ∈ negSupport (frameVec W hW.1 hW.2.1 hW.2.2.1)
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues, dotProduct u x = 0) (w : Fin n → ℝ) :
    W (wedgeVec u w) = 0 :=
  L30_support W hW.2 _ _ (eigenframe30_exists W hW) (by simpa using hdim) u hu w

end HamiltonsCubic.L30Exists
