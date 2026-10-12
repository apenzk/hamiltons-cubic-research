import HamiltonsCubic.Base.Padding
import HamiltonsCubic.Base.Curvature

/-!
# L34, second half, the padded summands are Weyl

[L34](L34.lean) proved the construction's load-bearing step: `𝒲ₙ` is closed
under addition, so the sum of two padded copies is Weyl **whatever the planes
do**. What that left owed is that each *summand* is Weyl after padding.

**The structural content is that padding kills the mixed directions.** A bivector
with one index in each summand has zero `(1,1)`-block, so the padded operator
sends it to `R 0`; and the padded operator's output lives in the `(1,1)` block,
so it pairs to zero against any mixed bivector. Those two facts are what make
the Ricci contraction and first Bianchi transfer.
-/

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

/-- **A mixed bivector has no `(1,1)`-block**, so the padded operator does not
see it. -/
theorem toBlocks_phi_mixed (a : m) (c : k) :
    (phi (Sum.inl a) (Sum.inr c) : Matrix (m ⊕ k) (m ⊕ k) ℚ).toBlocks₁₁ = 0 := by
  unfold phi Matrix.toBlocks₁₁
  ext i j
  simp [Matrix.single_apply]

/-- Hence the padded operator sends every mixed bivector to `R 0`, which is `0`
for a linear `R`. -/
theorem padOp_phi_mixed (R : Matrix m m ℚ → Matrix m m ℚ) (a : m) (c : k) :
    padOp (k := k) R (phi (Sum.inl a) (Sum.inr c)) = pad (R 0) := by
  unfold padOp
  rw [toBlocks_phi_mixed]

/-- **And the padded operator's output pairs to zero against a mixed
bivector**, its support being the `(1,1)` block. -/
theorem inner2_pad_phi_mixed (X : Matrix m m ℚ) (b : m) (c : k) :
    inner2 (pad (k := k) X) (phi (Sum.inl b) (Sum.inr c)) = 0 := by
  simp [inner2, pad, phi, Matrix.trace, Matrix.diag, Matrix.mul_apply,
    Matrix.single_apply, Matrix.fromBlocks, Fintype.sum_sum_type,
    Matrix.transpose_apply]

/-- Pairing two padded bivectors is the pairing downstairs, `pairing_pad` in
the form the `Λ²` contractions use. -/
theorem inner2_pad_pad (X Y : Matrix m m ℚ) :
    inner2 (pad (k := k) X) (pad (k := k) Y) = inner2 X Y := by
  unfold inner2
  rw [pad_transpose, pad_mul, trace_pad]

end HamiltonsCubic.Base
