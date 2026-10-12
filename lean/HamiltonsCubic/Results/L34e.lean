import HamiltonsCubic.Results.L34d

/-!
# L34, the witness the block actually names

`W₄(q,r) = -(q+r) w₁⊗w₁ + q w₂⊗w₂ + r w₃⊗w₃` on the unit self-dual forms, of
signature `(2,1)`: **one** negative eigenvalue, which is how two padded copies
reach *exactly two* at `m = 8`.

The record also says its **negative** is the base-case family at `θ = +√(3/2)`,
and that is `W_{ℂP²}`. So at `q = r = 1`:

`W₄(1,1) = -W_{ℂP²}`,

with spectrum `(-2,1,1,0,0,0)` against `W_{ℂP²}`'s `(2,-1,-1,0,0,0)`. The
witness was one sign away from the tensor already in the layer, and the
assembly on it is the block's construction rather than a variant of it.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- `W₄(q,r)` in the `pair4` basis, on the unit self-dual forms. -/
def W4 (q r : ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  !![ -(q+r)/2,     0,     0,     0,     0, -(q+r)/2;
             0,   q/2,     0,     0,  -q/2,        0;
             0,     0,   r/2,   r/2,     0,        0;
             0,     0,   r/2,   r/2,     0,        0;
             0,  -q/2,     0,     0,   q/2,        0;
      -(q+r)/2,     0,     0,     0,     0, -(q+r)/2]

/-- **At `q = r = 1` it is `-W_{ℂP²}`.** -/
theorem W4_one_one : W4 1 1 = -WCP2 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [W4, WCP2, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
      Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.vecHead,
      Matrix.vecTail, Matrix.cons_val_fin_one, Matrix.empty_val', Matrix.head_fin_const,
      Matrix.neg_apply, Matrix.of_apply]

/-- Negation preserves the Weyl conditions, all three being linear. -/
theorem IsWeylOf.neg {ι : Type*} [Fintype ι] [DecidableEq ι]
    {R : Matrix ι ι ℚ → Matrix ι ι ℚ} (hR : IsWeylOf R) :
    IsWeylOf (fun X => -R X) := by
  obtain ⟨hs, hb, hr⟩ := hR
  refine ⟨?_, ?_, ?_⟩
  · intro X Y hX hY
    have h1 : inner2 (-R X) Y = -inner2 (R X) Y := by simp [inner2]
    have h2 : inner2 X (-R Y) = -inner2 X (R Y) := by simp [inner2]
    rw [h1, h2, hs X Y hX hY]
  · intro i j k l
    have := hb i j k l
    unfold bianchiOf at *
    simp only [inner2] at *
    simp only [Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]
    linarith
  · intro a b
    have := hr a b
    unfold RicOf at *
    simp only [inner2] at *
    simp only [Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]
    simp only [mul_neg, Finset.sum_neg_distrib]
    linarith

/-- `W₄(1,1)` is a Weyl operator in the map encoding. -/
theorem W4_isWeylOf : IsWeylOf (fun X => -(ofMatrix WCP2) X) :=
  WCP2_isWeylOf.neg

/-- **L34's construction, on the witness it names.** Two copies of `W₄(1,1)`
padded onto the orthogonal 4-planes of `ℝ⁴ ⊕ ℝ⁴` and summed. Each summand
carries one negative eigenvalue, so the sum carries two, the count the block
states. -/
theorem L34_witness_isWeylOf :
    IsWeylOf (fun X : Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℚ =>
      padOp (k := Fin 4) (fun Y => -(ofMatrix WCP2) Y) X
        + padOp₂ (m := Fin 4) (fun Y => -(ofMatrix WCP2) Y) X) := by
  have h0 : (fun Y => -(ofMatrix WCP2) Y) 0 = 0 := by
    simp [ofMatrix_zero]
  exact (IsWeylOf_padOp _ h0 W4_isWeylOf).add (IsWeylOf_padOp₂ _ h0 W4_isWeylOf)

end HamiltonsCubic.Base
