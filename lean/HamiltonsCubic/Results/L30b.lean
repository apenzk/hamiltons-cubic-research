import HamiltonsCubic.Base.Padding

/-!
# L30, `θ` survives padding, which is the rest of the clause

The reviewers record that *"with the same norm and the same `θ`" was asserted
and never proved, and it is the clause the lemma exists for*. Their two lines
are the norm from orthonormality, [B2](../Base/Padding.lean)'s
`inner2_pad_pad`, and `θ` because `Λ²U = 𝔰𝔬(U)` is a subalgebra, which keeps
`W#` inside.

**This file closes the second line.** The `#` quadratic form is unchanged by
padding: the terms with both indices in the summand reproduce it, and every
other term dies because the padded operator sends its basis bivector to `R 0`.

So a bound proved at `dim U` really does govern every `n`, which is what the
lemma is for.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

/-- The bracket of two padded bivectors is the padding of their bracket. -/
theorem br_pad (X Y : Matrix m m ℚ) :
    br (pad (k := k) X) (pad (k := k) Y) = pad (br X Y) := by
  unfold br
  rw [pad_mul, pad_mul]
  unfold pad
  ext i j
  cases i <;> cases j <;> simp [Matrix.fromBlocks]

/-- A padded operator kills every bivector that is not padded from the summand. -/
theorem padOp_of_toBlocks_zero (R : Matrix m m ℚ → Matrix m m ℚ) (hR0 : R 0 = 0)
    {X : Matrix (m ⊕ k) (m ⊕ k) ℚ} (hX : X.toBlocks₁₁ = 0) :
    padOp (k := k) R X = 0 := by
  unfold padOp
  rw [hX, hR0]
  unfold pad
  ext i j
  cases i <;> cases j <;> simp [Matrix.fromBlocks]

/-- **The `#` quadratic form is unchanged by padding.** The terms with both
indices in the summand reproduce it; every other term dies, the padded operator
sending its basis bivector to `R 0`. -/
theorem sharpQF'_padOp (R : Matrix m m ℚ → Matrix m m ℚ) (hR0 : R 0 = 0)
    (η : Matrix m m ℚ) :
    sharpQF' (padOp (k := k) R) (pad η) = sharpQF' R η := by
  unfold sharpQF'
  have kill : ∀ (u v : m ⊕ k),
      (phi u v : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₁₁ = 0 →
      inner2 (br (pad (k := k) η) (padOp (k := k) R
        (br (pad (k := k) η) (padOp (k := k) R (phi u v))))) (phi u v) = 0 := by
    intro u v h
    have h1 : padOp (k := k) R (phi u v) = 0 := padOp_of_toBlocks_zero R hR0 h
    have h2 : br (pad (k := k) η) (0 : Matrix (m ⊕ k) (m ⊕ k) ℚ) = 0 := by simp [br]
    have h3 : padOp (k := k) R (0 : Matrix (m ⊕ k) (m ⊕ k) ℚ) = 0 :=
      padOp_of_toBlocks_zero R hR0 (by ext i j; simp [Matrix.toBlocks₁₁])
    rw [h1, h2, h3, h2]
    simp [inner2]
  have main : ∀ i j : m,
      inner2 (br (pad (k := k) η) (padOp (k := k) R
        (br (pad (k := k) η) (padOp (k := k) R (phi (Sum.inl i) (Sum.inl j))))))
        (phi (Sum.inl i) (Sum.inl j))
      = inner2 (br η (R (br η (R (phi i j))))) (phi i j) := by
    intro i j
    simp only [← pad_phi, padOp_pad, br_pad, pairing_pad]
  simp only [Fintype.sum_sum_type, main, kill _ _ (toBlocks_phi_inl_inr _ _),
    kill _ _ (toBlocks_phi_inr _ _), kill _ _ (toBlocks_phi_inr_inr _ _),
    Finset.sum_const_zero, add_zero, zero_add]

end HamiltonsCubic.Base
