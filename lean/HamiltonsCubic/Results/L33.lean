import HamiltonsCubic.Base.CP2

/-!
# L33, the witness that fixes the reading

L33 says a **one-dimensional** eigenspace on one side forces `W = 0`, and its
reviewers record that the phrase *"exactly one eigenvalue of one sign"* is
ambiguous and **the lemma is false under the other reading**:

> Counted as *one distinct value at any multiplicity*, a witness sits already in
> `𝒲₄`: `W⁺ = W⁻ = diag(2,-1,-1)` has spectrum `(2,2,-1,-1,-1,-1)`, its `+2`
> eigenspace contains a rank-`2` element that is no complex structure, and
> `W ≠ 0`.

**That witness is the structural half**, and the file's convention, counting
with multiplicity, is what keeps the statement true in place. The block notes
the convention *does not travel* to [results.md](../../../results.md) or the
report, so the witness is worth having as a theorem rather than as prose.

Taking `W⁺` and `W⁻` both `diag(2,-1,-1)` gives, in the `pair4` basis,
`diag(2,-1,-1,-1,-1,2)`, the self-dual and anti-self-dual off-diagonals
cancelling.
-/

namespace HamiltonsCubic.Base

open Matrix

/-- `W⁺ = W⁻ = diag(2,-1,-1)`, in the `pair4` basis. -/
def W33 : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.diagonal ![2, -1, -1, -1, -1, 2]

/-- **Symmetry is the diagonal's own theorem**, no computation at all. -/
theorem W33_isSymm : W33.IsSymm := Matrix.diagonal_transpose _

/-- **First Bianchi reads three OFF-DIAGONAL entries**, `R 0 5 - R 1 4 + R 2 3`, and a diagonal
matrix has none of them. -/
theorem W33_bianchi : IsBianchi W33 := by
  unfold IsBianchi W33
  rw [Matrix.diagonal_apply_ne _ (by decide : (0 : Fin 6) ≠ 5),
    Matrix.diagonal_apply_ne _ (by decide : (1 : Fin 6) ≠ 4),
    Matrix.diagonal_apply_ne _ (by decide : (2 : Fin 6) ≠ 3)]
  ring

set_option maxHeartbeats 4000000 in
/-- Ricci-flatness is the one condition that needs the `Λ²` contraction, by
[CP2.lean](../Base/CP2.lean)'s recipe with the diagonal projections in place of the literal's. -/
theorem W33_ricciFlat : IsRicciFlat W33 := by
  unfold IsRicciFlat Ric
  intro a b
  fin_cases a <;> fin_cases b <;>
    simp (config := { maxSteps := 4000000 }) only [W33, inner2, toMat4, coord4, basis4, pair4,
      phi, Matrix.mul_apply, Matrix.single, Matrix.mulVec, dotProduct, Matrix.trace, Matrix.diag,
      Fin.sum_univ_six, Fin.sum_univ_four, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply,
      Fin.isValue, Matrix.of_apply, Matrix.transpose, Matrix.diagonal_apply,
      Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
      Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
      Matrix.empty_val', Matrix.head_fin_const, Fin.ext_iff, Fin.mk.injEq, Pi.single_apply] <;>
    norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
      Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
      Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
      Pi.single_apply, Fin.ext_iff]

/-- **It is a Weyl operator.** -/
theorem W33_isWeyl : IsWeyl W33 := ⟨W33_isSymm, W33_bianchi, W33_ricciFlat⟩

/-- **And it is nonzero**, so the lemma fails under the distinct-value reading:
one distinct eigenvalue on the positive side, at multiplicity two, and `W ≠ 0`. -/
theorem W33_ne_zero : W33 ≠ 0 := by
  intro h
  have : W33 0 0 = (0 : Matrix (Fin 6) (Fin 6) ℚ) 0 0 := by rw [h]
  simp [W33, Matrix.diagonal] at this

/-- Its trace vanishes, as every Weyl operator's does, and it is the entry list's own sum. -/
theorem W33_trace : W33.trace = 0 := by
  simp [W33, Matrix.trace, Matrix.diag, Matrix.diagonal_apply_eq, Fin.sum_univ_six,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three,
    Matrix.cons_val_four, cons_val_five, Matrix.vecHead, Matrix.vecTail]
  norm_num

/-- The `+2` eigenspace is two-dimensional, spanned by the first and last basis
bivectors, which is the multiplicity the counting convention turns on. -/
theorem W33_eigen_two_first : W33 *ᵥ Pi.single 0 1 = (2 : ℚ) • Pi.single 0 1 := by
  rw [W33, Matrix.diagonal_mulVec_single]
  ext i
  simp [Pi.single_apply, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.vecHead, Matrix.vecTail]

theorem W33_eigen_two_last : W33 *ᵥ Pi.single 5 1 = (2 : ℚ) • Pi.single 5 1 := by
  rw [W33, Matrix.diagonal_mulVec_single]
  ext i
  simp [Pi.single_apply, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.vecHead, Matrix.vecTail]

end HamiltonsCubic.Base
