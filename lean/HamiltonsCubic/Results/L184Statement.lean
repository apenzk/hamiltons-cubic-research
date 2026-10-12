import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.SelfDual

/-!
# L184, stated over the real Weyl layer

**The record's statement**, from [diagonal-half.md](../../../findings/diagonal-half.md)'s
*Lemma L184, the coincident case at `dim V = 6` is empty*:

> **Statement, in the form both audits established rather than the one first written.** *No
> orthonormal triple `ω₁, ω₂, ω₃` of `2`-forms with a common six-dimensional support has both its
> squares and its self-wedges coincident.* **No Weyl hypothesis is used anywhere**, in particular
> there is no rank-three `W ∈ 𝒲ₙ` with `dim V = 6` whose three images under `Φ` coincide, which is
> the corollary the programme wanted.

`coincident_six_empty` below is that statement: the five hypotheses are orthonormality, a common
support, that support being six-dimensional, coincident squares and coincident self-wedges, and
the conclusion is `False`. **The record's `Φ(ω) = (ω², ω ∧ ω)` is
[SelfDual.lean](../Base/SelfDual.lean)'s `Phi`**, and it is carried here as the pair of hypotheses
`hsq` and `hwedge`, which is the bridge the record's own block names, *"the images coincide" IS
"the squares and the self-wedges coincide"*, while `coincident_six_empty_Phi` states it in the
`Φ` form instead, from the same proof.

`no_rank_three_coincident` is the corollary, and it is **proved from the theorem above with the
`IsWeyl` hypothesis unused**, which is how the record's *"no Weyl hypothesis is used anywhere"*
is visible in the Lean rather than only asserted in prose.

**The wedge and `Φ` are [SelfDual.lean](../Base/SelfDual.lean)'s**, so the two conventions this
statement rests on are pinned there: the `Λ²` unit norm at
`inner2_areaForm_self_of_orthonormal`, and the wedge at `wedgeSelf_areaForm`, the Plücker
cancellation, which makes a decomposable form's self-wedge vanish and so fixes the alternating
pattern of signs.

## Case 2 is typed, conditionally on the identity the record owes

**`scalar_case_empty` is the record's case 2**, *`A = cI₆`, so each `ωᵢ/√c` is a complex
structure; equal self-wedges force `Jᵢ = ±K` for one `K`; and the three forms then span a line, so
the rank cannot be three.* It is stated at `Fin 6`, where the identity holds, and it takes
`StarWedgeIdentity`, [SelfDual.lean](../Base/SelfDual.lean)'s predicate for
`⋆_V(J ∧ J) = 2 ε_J J`, as an **explicit hypothesis**, which
[I67PfSign.lean](I67PfSign.lean)'s `starWedgeIdentity_holds` discharges:
`scalar_case_empty_orthonormal_uncond` there is case 2 with no hypothesis. **The main theorem below
takes none either.**

*`scalar_square_coeff` is the record's "unit norm forces `c = ⅓`, so `ωᵢ² = -⅓Id₆` and `c` is not
a free parameter", and it is proved.* *The contradiction in `scalar_case_empty` is linear
independence, which is the record's own reading of case 2; `scalar_case_empty_orthonormal`
supplies that independence from orthonormality, so the case reaches the main theorem's
hypotheses.*

## Where the lemma is proved

**`coincident_six_empty` is proved in [L184Proof.lean](L184Proof.lean)**, and the proof there needs
none of the record's three cases. *The frame of `ω₀`'s normal form carries both forms to `ℝ⁶`, and
the adjugate law `X σ(X) = -Pf(X) Id` of [L193](L193Statement.lean) turns equal squares and equal
wedges into `Pf(X₀) X₀ = Pf(X₁) X₁`, which orthogonality contradicts since `Pf(X₀) ≠ 0`.* **It uses
two of the three forms**, as `coincident_six_pair`, the orthonormal corollary of L191, whose rigidity
form is `L191` in [L191Proof.lean](L191Proof.lean). Case 2 above stays as the record's own route.

## What is NOT typed here

* **The reduction of a six-dimensional `V ⊆ ℝⁿ` to `ℝ⁶` for case 2.** `scalar_case_empty` is
  stated at `Fin 6`, where `⋆_V` lives; the main theorem's proof builds its own frame from the
  normal form in [L184Proof.lean](L184Proof.lean).
* **A triple satisfying the first four hypotheses is not constructed.** `unit_scalar_witness`
  exhibits one form that is skew, of unit `Λ²` norm and of scalar square on `ℝ⁶`, so those
  clauses are inhabited; **an orthonormal triple with a common six-dimensional support is not
  built**, so the reader takes the six-dimensionality on the definition rather than on an example.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L184Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {r : ℕ}

noncomputable section

/-! ## The support -/

/-- **The support of a `2`-form**: the image of the skew map it names. -/
def support (X : Matrix ι ι ℝ) : Submodule ℝ (ι → ℝ) :=
  LinearMap.range (Matrix.mulVecLin X)

/-! ## Orthonormality supplies linear independence -/

theorem inner2_sum_smul {κ : Type*} [Fintype κ] (c : κ → ℝ) (M : κ → Matrix ι ι ℝ)
    (Y : Matrix ι ι ℝ) : inner2 (∑ i, c i • M i) Y = ∑ i, c i * inner2 (M i) Y := by
  simp [inner2, Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]
  ring_nf

/-- **An orthonormal family of `2`-forms is linearly independent.** *This is what carries case 2's
contradiction, the record's "`Jᵢ = ±K` leaves the three forms spanning a line, so the rank cannot
be three", back to the orthonormality the lemma hypothesises.* -/
theorem linearIndependent_of_orthonormal {κ : Type*} [Fintype κ] [DecidableEq κ]
    (om : κ → Matrix ι ι ℝ)
    (hon : ∀ i j, inner2 (om i) (om j) = if i = j then 1 else 0) :
    LinearIndependent ℝ om := by
  rw [Fintype.linearIndependent_iff]
  intro g hg j
  have h := congrArg (fun X : Matrix ι ι ℝ => inner2 X (om j)) hg
  simp only [inner2_sum_smul] at h
  rw [Finset.sum_congr rfl (fun i _ => by rw [hon i j])] at h
  simp only [mul_ite, mul_one, mul_zero] at h
  simpa [inner2] using h

/-! ## The scalar case, which is the record's case 2 -/

/-- **Unit norm forces the scalar to be `-⅓` on `ℝ⁶`**, the record's *"`ωᵢ² = -⅓Id₆`, and `c` is
not a free parameter"*. -/
theorem scalar_square_coeff (X : Matrix (Fin 6) (Fin 6) ℝ) (c : ℝ)
    (hskew : IsSkew X) (hnorm : inner2 X X = 1) (hsq : X * X = c • (1 : Matrix (Fin 6) (Fin 6) ℝ)) :
    c = -(1 / 3) := by
  unfold IsSkew at hskew
  unfold inner2 at hnorm
  rw [hskew, Matrix.neg_mul, hsq] at hnorm
  simp only [Matrix.trace_neg, Matrix.trace_smul, Matrix.trace_one, smul_eq_mul] at hnorm
  norm_num at hnorm
  linarith

/-- **`√3 ω` is a complex structure** when `ω` is skew with `ω² = -⅓Id₆`, which is the record's
*"`ωᵢ/√c` is orthogonal and skew"* with the value of `c` filled in. -/
theorem isComplexStructure_smul {X : Matrix (Fin 6) (Fin 6) ℝ} (hskew : IsSkew X)
    (hsq : X * X = (-(1 / 3) : ℝ) • (1 : Matrix (Fin 6) (Fin 6) ℝ)) :
    IsComplexStructure ((Real.sqrt 3) • X) := by
  have h3 : (Real.sqrt 3) * (Real.sqrt 3) = 3 := Real.mul_self_sqrt (by norm_num)
  refine ⟨?_, ?_⟩
  · unfold IsSkew at hskew ⊢
    rw [Matrix.transpose_smul, hskew, smul_neg]
  · rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, h3, hsq, smul_smul]
    norm_num

/-- **L184, case 2, the scalar sub-case at `dim V = 6` is empty**, conditionally on the identity
the record owes.

*Each `ωᵢ` is skew of unit `Λ²` norm with `ωᵢ² = cᵢ Id₆`; `scalar_square_coeff` makes every `cᵢ`
equal to `-⅓`, so each `√3 ωᵢ` is a complex structure, and `⋆_V(J ∧ J) = 2 ε_J J` turns equal
self-wedges into `ωᵢ = ±ω₁`. Three forms so related span a line, against linear independence.*

**`StarWedgeIdentity` is a binder here and a theorem in [I67PfSign.lean](I67PfSign.lean)**, which
states the unconditional form. -/
theorem scalar_case_empty (hSW : StarWedgeIdentity) (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (hskew : ∀ i, IsSkew (om i))
    (hnorm : ∀ i, inner2 (om i) (om i) = 1)
    (hscal : ∀ i, ∃ c : ℝ, om i * om i = c • (1 : Matrix (Fin 6) (Fin 6) ℝ))
    (hindep : LinearIndependent ℝ om)
    (hwedge : ∀ i j, wedgeSelf (om i) = wedgeSelf (om j)) :
    False := by
  have hs3 : Real.sqrt 3 ≠ 0 := by
    have : (0 : ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
    exact ne_of_gt this
  have hsq : ∀ i, om i * om i = (-(1 / 3) : ℝ) • (1 : Matrix (Fin 6) (Fin 6) ℝ) := by
    intro i
    obtain ⟨c, hc⟩ := hscal i
    rw [hc, scalar_square_coeff (om i) c (hskew i) (hnorm i) hc]
  have hJ : ∀ i, IsComplexStructure ((Real.sqrt 3) • om i) := fun i =>
    isComplexStructure_smul (hskew i) (hsq i)
  have hJw : wedgeSelf ((Real.sqrt 3) • om 1) = wedgeSelf ((Real.sqrt 3) • om 0) := by
    rw [wedgeSelf_smul, wedgeSelf_smul, hwedge 1 0]
  have hpm := pm_of_eq_wedgeSelf hSW (hJ 1) (hJ 0) hJw
  have hcancel : ∀ A B : Matrix (Fin 6) (Fin 6) ℝ,
      (Real.sqrt 3) • A = (Real.sqrt 3) • B → A = B := by
    intro A B hAB
    have := congrArg (fun M : Matrix (Fin 6) (Fin 6) ℝ => (Real.sqrt 3)⁻¹ • M) hAB
    simpa [smul_smul, inv_mul_cancel₀ hs3] using this
  rw [Fintype.linearIndependent_iff] at hindep
  rcases hpm with h | h
  · have hom : om 1 = om 0 := hcancel _ _ h
    have hzero : ∑ i, (![1, -1, 0] : Fin 3 → ℝ) i • om i = 0 := by
      simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one,
        Matrix.cons_val_two, Matrix.tail_cons, Matrix.head_cons]
      rw [hom]
      module
    have := hindep _ hzero 0
    norm_num at this
  · have hom : om 1 = -om 0 := by
      refine hcancel _ _ ?_
      rw [h]
      module
    have hzero : ∑ i, (![1, 1, 0] : Fin 3 → ℝ) i • om i = 0 := by
      simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one,
        Matrix.cons_val_two, Matrix.tail_cons, Matrix.head_cons]
      rw [hom]
      module
    have := hindep _ hzero 0
    norm_num at this

/-- **Case 2 with the record's own hypotheses**, orthonormality supplying the linear independence
the contradiction runs on. -/
theorem scalar_case_empty_orthonormal (hSW : StarWedgeIdentity)
    (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (hskew : ∀ i, IsSkew (om i))
    (hon : ∀ i j, inner2 (om i) (om j) = if i = j then 1 else 0)
    (hscal : ∀ i, ∃ c : ℝ, om i * om i = c • (1 : Matrix (Fin 6) (Fin 6) ℝ))
    (hwedge : ∀ i j, wedgeSelf (om i) = wedgeSelf (om j)) :
    False :=
  scalar_case_empty hSW om hskew (fun i => by simpa using hon i i) hscal
    (linearIndependent_of_orthonormal om hon) hwedge

/-- **The per-form hypotheses of case 2 are inhabited**: `stdJ6/√3` is skew, of unit `Λ²` norm and
of scalar square on `ℝ⁶`. *What is not built is a triple of them that is orthonormal with a common
six-dimensional support.* -/
theorem unit_scalar_witness :
    IsSkew ((Real.sqrt 3)⁻¹ • stdJ6) ∧
      inner2 ((Real.sqrt 3)⁻¹ • stdJ6) ((Real.sqrt 3)⁻¹ • stdJ6) = 1 ∧
      (∃ c : ℝ, ((Real.sqrt 3)⁻¹ • stdJ6) * ((Real.sqrt 3)⁻¹ • stdJ6)
        = c • (1 : Matrix (Fin 6) (Fin 6) ℝ)) := by
  obtain ⟨hskew, hsq⟩ := stdJ6_isComplexStructure
  have h3 : ((Real.sqrt 3)⁻¹ : ℝ) ^ 2 = 1 / 3 := by
    rw [inv_pow, Real.sq_sqrt (by norm_num : (3 : ℝ) ≥ 0)]
    norm_num
  refine ⟨?_, ?_, ⟨-(1 / 3), ?_⟩⟩
  · unfold IsSkew at hskew ⊢
    rw [Matrix.transpose_smul, hskew, smul_neg]
  · rw [inner2_smul_smul, h3, inner2_complexStructure stdJ6_isComplexStructure]
    norm_num
  · rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, ← sq, h3, hsq]
    module

/-! **The lemma, its `Φ` form and the Weyl corollary are PROVED** in [L184Proof.lean](L184Proof.lean),
in this namespace, because the proof imports the adjugate law and the skew normal form. -/

/-- `Σᵢ λᵢ ωᵢ ⊗ ωᵢ` as a curvature operator, [L183](L183Statement.lean)'s `rankSumOp`. -/
def rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) :
    Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => ∑ i, (lam i * inner2 (om i) X) • om i

end

end HamiltonsCubic.L184Statement
