import HamiltonsCubic.Base.WeylModule
import HamiltonsCubic.Base.FoxBilinear

/-!
# The two trace identities, stated, and the closure they rest on

[findings/bounds.md](../../../bounds.md)'s Lemma L206 takes two facts as hypotheses:
`tr (L e) = 0` and `tr (L e * L f) = κ ⟨e, f⟩`. [WeylModule.lean](WeylModule.lean) built the
trace those are statements about. This file writes the statements, and names the step nobody
had written down.

**CLOSURE IS A LITERATURE RESULT, ON THE RECORD, AND THIS FILE TAKES IT AS A HYPOTHESIS ONLY
BECAUSE LEAN CANNOT CITE A PAPER.** [Fox's Lemma 5.7](../../../references/fox-2019-nonassociative-curvature-algebra/notes.md),
transcribed verbatim in this repository, states that `ker ρ` is a **subalgebra** of the curvature
algebra, which at `X = Y` is exactly `Q(𝒲ₙ) ⊆ 𝒲ₙ`. First Bianchi comes for free because the
product is defined on algebraic curvature tensors, Ricci-flatness from the lemma's first identity,
and the scalar component from its second.

*An earlier version of this file called closure unknown and the trace identities not well-posed.
That was refuted by [r897](../../../reviews/REVIEW_r897.md) and, decisively, by the transcription
above: the mechanism was right, since neither `Ric(X²)` nor `Ric(X#)` vanishes on its own, and the
inference was wrong, because they are exact negatives of each other on `𝒲ₙ`.* **The failure was
not opening the references folder, where the answer had been sitting for two days.**

**`FoxClosed` is PROVED**, as `foxClosed` in
[FoxClosedProof.lean](../Results/FoxClosedProof.lean) from L209's `foxProd_isWeylOp`, so the hypothesis
the three statements below take is discharged at every `ι`. *It stays a binder here because this
base file cannot import the result that proves it.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Closure, stated so that it is not vacuous.** That the Fox product of two members of `𝒲ₙ`
is again a member.

**THE QUANTIFIER ORDER IS THE WHOLE CONTENT.** An earlier version put the existential UNDER the
`∀ Z`, so the witness was allowed to depend on `Z`, and evaluation at a single `Z` is far from
injective: a member agreeing with the product at one point always exists, so the proposition was
TRUE AND EMPTY, and the three theorems below took a hypothesis that said nothing
([r897](../../../reviews/REVIEW_r897.md)). One witness for all `Z` is closure. -/
def FoxClosed (ι : Type*) [Fintype ι] [DecidableEq ι] : Prop :=
  ∀ X Y : CurvLin ι, X ∈ weylModule ι → Y ∈ weylModule ι →
    ∃ W : CurvLin ι, W ∈ weylModule ι ∧
      ∀ Z : Matrix ι ι ℝ, foxProd (fun A => X A) (fun A => Y A) Z = W Z

/-- **`L e` as an operator on `𝒲ₙ`, given closure.** The multiplication operator the two trace
identities are about. *The witness `FoxClosed` supplies is chosen for each `Y`, and the assignment
is linear because `∘` is linear in its second slot.* -/
theorem leftMul_exists (hclosed : FoxClosed ι) (e : CurvLin ι) (he : e ∈ weylModule ι) :
    ∃ L : weylModule ι →ₗ[ℝ] weylModule ι,
      ∀ Y : weylModule ι, ∀ Z : Matrix ι ι ℝ,
        (L Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z := by
  have hel : IsLinOp (fun A => e A) := ⟨fun X Y => e.map_add X Y, fun c X => e.map_smul c X⟩
  have hl : ∀ Y : weylModule ι, IsLinOp (fun A => (Y : CurvLin ι) A) :=
    fun Y => ⟨fun X W => (Y : CurvLin ι).map_add X W, fun c X => (Y : CurvLin ι).map_smul c X⟩
  choose W hW hWeq using fun Y : weylModule ι => hclosed e Y he Y.2
  refine ⟨{ toFun := fun Y => ⟨W Y, hW Y⟩, map_add' := ?_, map_smul' := ?_ }, fun Y Z => (hWeq Y Z).symm⟩
  · intro Y1 Y2
    apply Subtype.ext; apply LinearMap.ext; intro Z
    show W (Y1 + Y2) Z = W Y1 Z + W Y2 Z
    rw [← hWeq, ← hWeq, ← hWeq]
    exact foxProd_add_right _ _ _ hel (hl Y1) (hl Y2) Z
  · intro c Y
    apply Subtype.ext; apply LinearMap.ext; intro Z
    show W (c • Y) Z = c • W Y Z
    rw [← hWeq, ← hWeq]
    exact foxProd_smul_right c _ _ hel (hl Y) Z

/-! **The two trace identities are stated in [WeylTraceStrict.lean](../Results/WeylTraceStrict.lean)**, on
`weylModuleS`, the Weyl operators that also kill symmetric matrices. They were stated here over
`weylModule`, which [WeylRadical.lean](../Results/WeylRadical.lean) shows carries a radical
`Hom(Sym, M)` that reaches `L e` through `sharpQF`, so a trace over it is a trace of a different
operator. -/

/-!
## What this file establishes and what it does not

**Established**: the two identities are now Lean PROPOSITIONS rather than prose, each carrying
its hypotheses as binders, and the trace in them is the one [WeylModule.lean](WeylModule.lean)
built.

**`leftMul_exists` is PROVED**, the operator chosen from `FoxClosed`'s witness and made linear by
[FoxBilinear.lean](FoxBilinear.lean)'s `foxProd_add_right` and `foxProd_smul_right`. **The two
identities moved** to [WeylTraceStrict.lean](../Results/WeylTraceStrict.lean), restated on the record's
`𝒲ₙ`, where they are the two named `sorry`.

**And what an earlier version of this file got wrong, kept here because the next reader is owed
it**: it recorded that `L e` might not be an operator on `𝒲ₙ` at all, on the ground that neither
`Ric(X²)` nor `Ric(X#)` vanishes on its own. *Both halves of that are true and the conclusion is
false: on `𝒲ₙ` the two are exact negatives, so the sum vanishes, which is
[Fox's Lemma 5.7](../../../references/fox-2019-nonassociative-curvature-algebra/notes.md) and had
been transcribed into this repository two days earlier.* **The check that would have caught it is
reading the references folder before recording a gap in the literature's own result.**

-/

end HamiltonsCubic.RealLayer
