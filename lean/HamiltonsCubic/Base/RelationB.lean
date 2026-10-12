import HamiltonsCubic.Base.CP2

/-!
# Relation (B), the per-row identity, and the sign that was wrong

`𝒜(W) = Σ_{g,h} W_{gh} ad(φ_g) ad(φ_h)` satisfies `𝒜 = -2(· # I)`, so
`𝒜(W) = 2W` on `𝒲ₙ` is exactly

`W # I = -W`.

**The sign has a history.** [isotropy-cap.md](../../../findings/isotropy-cap.md)
records that the file once read *"`𝒲ₙ` is `𝒜`'s `-2` eigenspace"*, contradicting
its own next sentence and a table elsewhere; [r464](../../../reviews/REVIEW_r464.md)
flagged it **and it was not applied** until a later audit. A claim that has been
written both ways is worth checking rather than quoting.

`#` is recovered bilinearly from the quadratic form by polarisation, and
`I# = (n-2)I` is [B1](Curvature.lean)'s anchor, so both inputs are already here.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- The bilinear `#`, by polarisation of the quadratic one. -/
def sharpBilin (X Y : Matrix (Fin 6) (Fin 6) ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  (1/2 : ℚ) • (sharpMat (X + Y) - sharpMat X - sharpMat Y)

set_option maxHeartbeats 40000000 in
set_option maxRecDepth 10000 in
-- Thirty-six entries, each a polarised `sharpQF` over the `Λ²` basis in literal rationals.
/-- **`I # I = (n-2) I`**, which at `n = 4` is `2 I`, B1's anchor in bilinear
form, and the input the polarisation needs. -/
theorem sharpBilin_one_one : sharpBilin 1 1 = (2 : ℚ) • (1 : Matrix (Fin 6) (Fin 6) ℚ) := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp (config := { maxSteps := 4000000 }) only [sharpBilin, sharpMat, sharpQF, toMat4, coord4,
      basis4, pair4, br, phi, WCP2, Matrix.mul_apply, Matrix.single, Matrix.one_apply,
      Matrix.mulVec, dotProduct, Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply,
      Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply,
      Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three,
      Matrix.cons_val_four, cons_val_five, Matrix.vecHead, Matrix.vecTail,
      Matrix.cons_val_fin_one, Matrix.empty_val', Matrix.head_fin_const, Fin.ext_iff] <;>
    norm_num [Fin.ext_iff, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
      Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.vecHead,
      Matrix.vecTail, Matrix.cons_val_fin_one, Pi.single_apply]

/- **Relation (B) at the competitor, `W # I = -W`, is `WCP2_sharp_one` in
[WCP2Sharp1.lean](WCP2Sharp1.lean)**, kernel-checked entry by entry from the seventy-two entry
lemmas of [RelationBSharp.lean](RelationBSharp.lean), which this file cannot import. -/

/- The same check at [L33](../Results/L33.lean)'s witness is **not** made here.
`sharpBilin` polarises three quadratic `#` evaluations, each itself a
polarisation over the thirty-six basis pairs, and one such check costs minutes
of compilation. Two would double the build for a second instance of a relation
the record states in general. -/

end HamiltonsCubic.Base
