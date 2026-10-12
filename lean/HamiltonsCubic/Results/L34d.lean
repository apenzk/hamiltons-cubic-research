import HamiltonsCubic.Base.Padding
import HamiltonsCubic.Base.Transfer
import HamiltonsCubic.Results.L34

/-!
# L34, the construction, assembled

> Pad two copies of a `𝒲₄` element onto 4-planes of `ℝᵐ` and add. Both defining
> conditions are linear, so the sum is a `𝒲ₘ` element **whatever the planes do**.

At `m = 8` the two planes are orthogonal, so they are the two summands of
`ℝ⁴ ⊕ ℝ⁴`. Everything the sentence claims is now assembled from proved parts:
the tensor verified by computation, the padding and the closure proved in the
kernel at every dimension.

**What stays owed** is what the block foregrounds, exactly two negative
eigenvalues, `dim U = m`, and the `θ` values. Those need spectral extraction on
a 28-dimensional `Λ²`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

theorem inner2_pad₂_right (X : Matrix (m ⊕ k) (m ⊕ k) ℚ) (B : Matrix k k ℚ) :
    inner2 X (pad₂ (m := m) B) = inner2 X.toBlocks₂₂ B := by
  unfold inner2 pad₂
  rw [← Matrix.fromBlocks_toBlocks X, Matrix.fromBlocks_transpose]
  simp only [Matrix.fromBlocks_multiply, Matrix.mul_zero, Matrix.zero_mul,
    add_zero, zero_add, Matrix.toBlocks_fromBlocks₂₂]
  rw [Matrix.trace, Fintype.sum_sum_type]
  simp [Matrix.fromBlocks, Matrix.trace, Matrix.diag]

theorem toBlocks₂₂_isSkew {X : Matrix (m ⊕ k) (m ⊕ k) ℚ} (hX : IsSkew X) :
    IsSkew X.toBlocks₂₂ := by
  unfold IsSkew Matrix.toBlocks₂₂ at *
  ext i j
  have := congrFun (congrFun hX (Sum.inr i)) (Sum.inr j)
  simpa using this

theorem padOp₂_symm (S : Matrix k k ℚ → Matrix k k ℚ)
    (hS : ∀ A B, IsSkew A → IsSkew B → inner2 (S A) B = inner2 A (S B))
    {X Y : Matrix (m ⊕ k) (m ⊕ k) ℚ} (hX : IsSkew X) (hY : IsSkew Y) :
    inner2 (padOp₂ (m := m) S X) Y = inner2 X (padOp₂ (m := m) S Y) := by
  unfold padOp₂
  rw [inner2_pad₂_left, inner2_pad₂_right,
    hS _ _ (toBlocks₂₂_isSkew hX) (toBlocks₂₂_isSkew hY)]

theorem IsWeylOf_padOp₂ (S : Matrix k k ℚ → Matrix k k ℚ) (hS0 : S 0 = 0)
    (hS : IsWeylOf S) : IsWeylOf (padOp₂ (m := m) S) := by
  obtain ⟨hs, hb, hr⟩ := hS
  exact ⟨fun X Y hX hY => padOp₂_symm S hs hX hY,
    bianchiOf_padOp₂ S hS0 hb, RicOf_padOp₂ S hS0 hr⟩

/-- A pair-basis operator read as a map kills `0`. -/
theorem ofMatrix_zero (R : Matrix (Fin 6) (Fin 6) ℚ) : ofMatrix R 0 = 0 := by
  have hc : coord4 (0 : Matrix (Fin 4) (Fin 4) ℚ) = 0 := by
    funext a; simp [coord4]
  unfold ofMatrix
  rw [hc, Matrix.mulVec_zero]
  unfold toMat4
  simp

/-- **L34's construction at `m = 8`, assembled.** Two copies of `W_{ℂP²}` padded
onto the orthogonal 4-planes of `ℝ⁴ ⊕ ℝ⁴`, summed, and the result is a Weyl
operator, by the padding transfer and L34's closure. -/
theorem L34_construction_isWeylOf :
    IsWeylOf (fun X : Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℚ =>
      padOp (k := Fin 4) (ofMatrix WCP2) X + padOp₂ (m := Fin 4) (ofMatrix WCP2) X) :=
  (IsWeylOf_padOp _ (ofMatrix_zero WCP2) WCP2_isWeylOf).add
    (IsWeylOf_padOp₂ _ (ofMatrix_zero WCP2) WCP2_isWeylOf)

/-! ## The blockwise action, which is what the eigenvalue count rests on

The block says *"each summand contributes exactly one negative eigenvalue, and
the support is the union of the planes"*. Both read off the fact that the padded
sum is **block diagonal**: it acts as `R` on the first `Λ²`, as `S` on the
second, and as **zero on the mixed part**. That is structural and is proved
here; the eigenvalue count itself still needs spectra.
-/

/-- On a bivector of the first summand, the sum acts as `R` alone. -/
theorem sum_on_pad (R : Matrix m m ℚ → Matrix m m ℚ) (S : Matrix k k ℚ → Matrix k k ℚ)
    (hS0 : S 0 = 0) (X : Matrix m m ℚ) :
    padOp (k := k) R (pad X) + padOp₂ (m := m) S (pad X) = pad (R X) := by
  unfold padOp padOp₂ pad pad₂
  rw [Matrix.toBlocks_fromBlocks₁₁, Matrix.toBlocks_fromBlocks₂₂, hS0]
  ext a b
  cases a <;> cases b <;> simp [Matrix.fromBlocks]

/-- On a bivector of the second summand, it acts as `S` alone. -/
theorem sum_on_pad₂ (R : Matrix m m ℚ → Matrix m m ℚ) (S : Matrix k k ℚ → Matrix k k ℚ)
    (hR0 : R 0 = 0) (Y : Matrix k k ℚ) :
    padOp (k := k) R (pad₂ Y) + padOp₂ (m := m) S (pad₂ Y) = pad₂ (S Y) := by
  unfold padOp padOp₂ pad pad₂
  rw [Matrix.toBlocks_fromBlocks₁₁, Matrix.toBlocks_fromBlocks₂₂, hR0]
  ext a b
  cases a <;> cases b <;> simp [Matrix.fromBlocks]

/-- **And it kills the mixed part**, the bivectors with one index in each
summand. This is what makes the two spectra add rather than interact, and it is
where the `dim U` claim comes from. -/
theorem sum_on_mixed (R : Matrix m m ℚ → Matrix m m ℚ) (S : Matrix k k ℚ → Matrix k k ℚ)
    (hR0 : R 0 = 0) (hS0 : S 0 = 0) (a : m) (c : k) :
    padOp (k := k) R (phi (Sum.inl a) (Sum.inr c))
      + padOp₂ (m := m) S (phi (Sum.inl a) (Sum.inr c)) = 0 := by
  unfold padOp padOp₂
  rw [toBlocks_phi_inl_inr, toBlocks₂₂_phi_inl_inr, hR0, hS0]
  unfold pad pad₂
  ext i j
  cases i <;> cases j <;> simp [Matrix.fromBlocks]

end HamiltonsCubic.Base
