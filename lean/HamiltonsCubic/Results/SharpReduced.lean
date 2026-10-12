import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L33Statement
import HamiltonsCubic.Results.L76Statement

set_option linter.style.longLine false

/-!
# `sharpQF` in its symmetric shape, the first step of the owed symmetry of `T`

**[FoxProduct.lean](../Base/FoxProduct.lean) records FULL SYMMETRY OF `T` as owed**, and with it the
self-adjointness of `L_e` that [L98](L98Statement.lean),
[L99](L99Statement.lean) and [L127](L127Statement.lean) each name as the
absence keeping their subject unstatable. *`foxTri_comm` gives the first two slots, which is `∘`'s
commutativity; the third is where the `#` half has to be read.*

**The engine was already on the record under another name.** `ad_skewAdjoint` in
[L33Statement.lean](L33Statement.lean), *proved for the splitting of a different
lemma*, says `⟨[v,u],w⟩ = -⟨u,[v,w]⟩` on bivectors, which is exactly the invariance the double
bracket in `sharpQF` has to be moved by.

**WHAT THIS FILE DOES IS ONE REWRITE OF THE DEFINITION**, and it is worth having because the
definition hides its own symmetry: `sharpQF R η = -¼∑⟨[η,R[η,Rφ]],φ⟩` has `R` applied twice on one
side of the pairing and not at all on the other, so nothing about it looks symmetric in the two
copies of `R`. **Moving one bracket across and then one `R` across gives**

  `sharpQF R η = ¼ ∑ ⟨[η, Rφ], R[η, φ]⟩`,

*where the two copies of `R` sit in the two slots of the pairing*, and the polarisation in `R` is
then visibly symmetric. **THE FULL SYMMETRY OF `T` IS STILL OWED**: this is its first step and not
the theorem, since `T`'s third slot needs the `φ`-expansion of `sharpOp` as well.
-/

namespace HamiltonsCubic.RealLayer

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`sharpQF`'s double bracket, moved into the symmetric shape.** *One application of
`ad_skewAdjoint` carries the outer bracket across the pairing and flips the sign against the `-¼`,
and one application of self-adjointness carries one `R` across.* -/
theorem sharpQF_reduced {R : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsa : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    sharpQF R η
      = (1/4) * ∑ i : ι, ∑ j : ι,
          inner2 (br η (R (phi i j))) (R (br η (phi i j))) := by
  unfold sharpQF
  have key : ∀ i j : ι,
      inner2 (br η (R (br η (R (phi i j))))) (phi i j)
        = - inner2 (br η (R (phi i j))) (R (br η (phi i j))) := by
    intro i j
    have hp : IsSkew (phi i j) := phi_isSkew i j
    have hRp : IsSkew (R (phi i j)) := hskew _ hp
    have hA : IsSkew (br η (R (phi i j))) :=
      HamiltonsCubic.L76Statement.br_isSkew hη hRp
    have hB : IsSkew (br η (phi i j)) :=
      HamiltonsCubic.L76Statement.br_isSkew hη hp
    have hRA : IsSkew (R (br η (R (phi i j)))) := hskew _ hA
    rw [HamiltonsCubic.L33Statement.ad_skewAdjoint hRA hη hp]
    rw [hsa _ _ hA hB]
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => key i j]
  simp only [Finset.sum_neg_distrib]
  ring

end HamiltonsCubic.RealLayer
