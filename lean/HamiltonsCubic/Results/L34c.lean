import HamiltonsCubic.Base.Bridge
import HamiltonsCubic.Base.RoundTrip
import HamiltonsCubic.Base.BianchiSym
import HamiltonsCubic.Base.CP2
import HamiltonsCubic.Results.L33

/-!
# L34, third half, the witness in the map encoding

With [B4](../Base/Bridge.lean) in place, `W_{ℂP²}` can be read as a map on
bivectors and fed to the structural theorems. Its two computable Weyl conditions
transfer here.

**A defect this round found in `IsWeylOf`.** Its symmetry clause reads
`∀ X Y, inner2 (R X) Y = inner2 X (R Y)`, over *all* matrices. A curvature
operator acts on `Λ²`, so the quantifier belongs over **skew** matrices: the
pair-basis coordinates only represent a matrix faithfully when it is skew, and
`inner2 X Y = coord X ⬝ᵥ coord Y` fails otherwise. The clause as written is
stronger than the object supports, and transferring it from `R.IsSymm` needs the
restriction. Recorded rather than patched, since narrowing it touches
[L34](L34.lean)'s closure proof.
-/

namespace HamiltonsCubic.Base

open Matrix

/-- **`ofMatrix R` IS ODD**, which is the first of the two hypotheses
[BianchiSym.lean](../Base/BianchiSym.lean)'s first-pair antisymmetry needs.

*Every stage of `ofMatrix` is linear*: `coord4` reads two entries, `mulVec` is linear, and
`toMat4` is a weighted sum of the basis. -/
theorem ofMatrix_neg (R : Matrix (Fin 6) (Fin 6) ℚ) (X : Matrix (Fin 4) (Fin 4) ℚ) :
    ofMatrix R (-X) = -ofMatrix R X := by
  have hc : coord4 (-X) = -coord4 X := by
    funext a; simp [coord4]
  unfold ofMatrix
  rw [hc, Matrix.mulVec_neg]
  unfold toMat4
  rw [← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun a _ => by simp [neg_smul]

/-! **BOTH `bianchiOf` CLAIMS NOW LEAVE THE COMPILER, THROUGH ONE TUPLE.**

*[Bridge.lean](../Base/Bridge.lean)'s `bianchiOf_ofMatrix` evaluates the `Λ²` form at the SINGLE
tuple `(0,1,2,3)`, where it is the pair-index equation `R 5 0 - R 4 1 + R 3 2`*, and both witnesses
satisfy it. **The theorems here quantify over all two hundred and fifty-six tuples**, and what
carries one to all of them is [bianchiOf_eq_zero_of_base](../Base/BianchiSym.lean): the three
adjacent transpositions generate `S₄`, so the 24 all-distinct tuples are the base value up to sign,
and the other 232 repeat an index and vanish.

**The two hypotheses that step needs are both already facts about the matrix.** Oddness is
`ofMatrix_neg` above, true for every `R` because each stage of the bridge is linear. Moving across
the pairing is [ofMatrix_symm](../Base/RoundTrip.lean), which holds exactly when `R` is symmetric,
and both witnesses are. *So the case split that reached 5.5 GB in
[I36DiagTest.lean](I36DiagTest.lean) is replaced by a named lemma applied 256 times.* -/

/-- The competitor's first Bianchi, in the `Λ²` reading, at every index tuple. -/
theorem WCP2_bianchiOf : ∀ i j k l, bianchiOf (ofMatrix WCP2) i j k l = 0 :=
  bianchiOf_eq_zero_of_base _ (ofMatrix_neg WCP2)
    (fun _ _ hX hY => ofMatrix_symm WCP2_isSymm hX hY)
    (by
      rw [bianchiOf_ofMatrix]
      norm_num [WCP2, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
        Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.vecHead,
        Matrix.vecTail, Matrix.cons_val_fin_one, Matrix.empty_val', Matrix.head_fin_const])

theorem WCP2_RicOf : ∀ a b, RicOf (ofMatrix WCP2) a b = 0 :=
  WCP2_ricciFlat

/-- Likewise for [L33](../Results/L33.lean)'s witness, so both named tensors are
available to the structural theorems. -/
theorem W33_bianchiOf : ∀ i j k l, bianchiOf (ofMatrix W33) i j k l = 0 :=
  bianchiOf_eq_zero_of_base _ (ofMatrix_neg W33)
    (fun _ _ hX hY => ofMatrix_symm W33_isSymm hX hY)
    (by
      rw [bianchiOf_ofMatrix]
      norm_num [W33, Matrix.diagonal_apply_ne, Fin.ext_iff])

theorem W33_RicOf : ∀ a b, RicOf (ofMatrix W33) a b = 0 :=
  W33_ricciFlat

end HamiltonsCubic.Base
