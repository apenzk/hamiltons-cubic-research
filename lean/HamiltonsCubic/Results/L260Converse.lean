import Mathlib
import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# L260 (4), the converse: `I/(n - 2)` meets the trace bound with equality

[findings/second-order.md](../../../findings/second-order.md), Lemma L260 (4): *"Every positive-definite idempotent
satisfies $\operatorname{tr}(CK)\le d$, $K=\bigoplus_ic_i\Pi_i$, with equality exactly at $\bigoplus_i\Pi_i/c_i$."*
At $\mathfrak h=\mathfrak{so}(n)$, $K=(n-2)I$ and $d=N$, and [I117Statements.lean](I117Statements.lean)'s
`L260_trace_bound` proves the bound and that equality forces `C = I/(n - 2)`. The L260 row owes the converse,
that equality holds at `I/(n - 2)`. This file:

* `idem_Ic`: `I/(n - 2)` is idempotent, from `I # I = (n - 2) I` (`sharpMapCL_id`) and `sharpMapCL_smul`;
* `pd_Ic`: it is self-adjoint and positive definite on `Λ²` for `n ≥ 3`;
* `L260_trace_eq_iff`: among self-adjoint positive definite idempotents of `𝔰𝔬(n)`, `n ≥ 3`,
  `(n - 2) tr C = N` holds exactly at `C = I/(n - 2)`, which is one of them.
-/

namespace HamiltonsCubic.L260Converse

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`I/(n - 2)` is idempotent.** -/
theorem idem_Ic (hn : 3 ≤ Fintype.card ι) :
    IsIdem ((1 / ((Fintype.card ι : ℝ) - 2)) • (idOp : CurvOp2 ι)) := by
  have hn2 : (Fintype.card ι : ℝ) - 2 ≠ 0 := by
    have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    linarith
  unfold IsIdem
  rw [sharpMapCL_smul, sharpMapCL_id, smul_smul]
  congr 1
  field_simp

/-- **`I/(n - 2)` is self-adjoint and positive definite.** -/
theorem pd_Ic (hn : 3 ≤ Fintype.card ι) :
    IsSelfAdjoint2 ((1 / ((Fintype.card ι : ℝ) - 2)) • (idOp : CurvOp2 ι)) ∧
      IsPD2 ((1 / ((Fintype.card ι : ℝ) - 2)) • (idOp : CurvOp2 ι)) := by
  have hc : 0 < 1 / ((Fintype.card ι : ℝ) - 2) := by
    have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    exact one_div_pos.mpr (by linarith)
  refine ⟨isSelfAdjoint2_smul idOp_isSelfAdjoint2 _, fun X hX => ?_⟩
  show 0 < inner2 ((1 / ((Fintype.card ι : ℝ) - 2)) • (X : Matrix ι ι ℝ)) (X : Matrix ι ι ℝ)
  have hX' : (X : Matrix ι ι ℝ) ≠ 0 := fun h => hX (Subtype.ext h)
  have hpos : 0 < inner2 (X : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :=
    lt_of_le_of_ne (FrameExtension.inner2_self_nonneg _)
      (fun h => hX' (FrameExtension.inner2_self_eq_zero h.symm))
  have e : inner2 ((1 / ((Fintype.card ι : ℝ) - 2)) • (X : Matrix ι ι ℝ)) (X : Matrix ι ι ℝ)
      = (1 / ((Fintype.card ι : ℝ) - 2)) * inner2 (X : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) := by
    unfold inner2
    rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]
    ring
  rw [e]
  exact mul_pos hc hpos

/-- **L260 (4) with its converse, at `𝔰𝔬(n)`**: a self-adjoint positive definite idempotent has
`(n - 2) tr C = N` exactly when it is `I/(n - 2)`, and `I/(n - 2)` is one. -/
theorem L260_trace_eq_iff (hn : 3 ≤ Fintype.card ι) (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hpd : IsPD2 C)
    (hidem : IsIdem C) :
    ((Fintype.card ι : ℝ) - 2) * innerOp2 C idOp = normSq2 (idOp : CurvOp2 ι) ↔
      C = (1 / ((Fintype.card ι : ℝ) - 2)) • idOp := by
  have hn2 : (Fintype.card ι : ℝ) - 2 ≠ 0 := by
    have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    linarith
  refine ⟨(L260_trace_bound hn C hC hpd hidem).2, fun h => ?_⟩
  rw [h, innerOp2_smul_left, ← mul_assoc, mul_one_div_cancel hn2, one_mul]
  rfl

end HamiltonsCubic.L260Converse
