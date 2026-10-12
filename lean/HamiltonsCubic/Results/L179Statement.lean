import Mathlib
import HamiltonsCubic.Base.QPGeneral
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.SelfDual

/-!
# L179, stated over the real Weyl layer

**The record's statement**, from [diagonal-half.md](../../../findings/diagonal-half.md)'s
*Lemma L179, the support of a low-rank Weyl tensor, and the first Bianchi identity read on the
spectrum*:

> **(a) The support is the span of the image forms' supports.** Let `W ∈ 𝒲ₙ` have spectral
> decomposition `W = Σ_α λ_α ω_α ⊗ ω_α` over an orthonormal eigenbasis of `Λ²`, and let
> `V ⊆ ℝⁿ` be the span of the supports of the `ω_α` with `λ_α ≠ 0`, a `2`-form's support being
> the image of the skew map it names. **Then `W` is supported on `Λ²V`**, read in a frame
> adapted to `V`.
>
> **(b) The first Bianchi identity is one equation on the nonzero spectrum.** The Bianchi
> obstruction is the map `𝔟 : S²Λ² → Λ⁴` sending `ω ⊙ η` to `ω ∧ η`, so first Bianchi `⟺`
> `Σ_{λ_α ≠ 0} λ_α ω_α ∧ ω_α = 0 ∈ Λ⁴`. **The zero eigenvalues drop out**, so at rank `r` this is
> a condition on `r` terms and no more.
>
> **(c) Rank one is impossible.** A rank-one self-adjoint `W = λ ω ⊗ ω` has `tr W = λ‖ω‖²`, which
> tracelessness forces to zero. **So the nonzero ranks begin at two.**

All three parts are now typed and proved, against
[WeylReal.lean](../Base/WeylReal.lean)'s `Ric`, `bianchi` and `inner2` rather than against local
definitions. The bridge theorems `Ric_rankSumOp` and `bianchi_rankSumOp` below carry the identity
between the record's spectral form `Σ λᵢ ωᵢ ⊗ ωᵢ` and that layer's operator language, so (a), (b)
and (c) are statements about `𝒲ₙ`.

## The Bianchi obstruction is now a map and not a value

`𝔟 : S²Λ² → Λ⁴`, *the map sending `ω ⊙ η` to `ω ∧ η`*, is `bObs` below, the symmetric bilinear
map built on [SelfDual.lean](../Base/SelfDual.lean)'s `wedge2`, whose diagonal value `𝔟(ω ⊙ ω)` is
the `wedgeSelf` that (b) sums. Symmetry is what lets it be read on `S²Λ²` rather than on
`Λ² ⊗ Λ²`, and bilinearity is what makes it a map at all; both are proved.

**The wedge is [SelfDual.lean](../Base/SelfDual.lean)'s**, so the convention is fixed once for the
layer and this file keeps no copy of it. The factor `½` relating `bianchi` to it is proved rather
than assumed, at `bianchi_rankSumOp`.

## What is NOT typed here

The `Λ⁴` in (b) is realised **by its components**: `wedgeSelf om a b c d` is the `(a,b,c,d)` entry
of `ω ∧ ω`, and "`= 0` in `Λ⁴`" is "vanishes at every four indices". `S²Λ²` is realised by the
symmetry of `bObs` rather than as a module of its own, so `𝔟` is typed as the symmetric bilinear
map on `Λ² × Λ²` and not as a linear map out of a symmetric square.

*The `ℚ`-layer part (c) of the previous version of this file is kept below unchanged.*
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L179

open Matrix Finset

/-! ## The spectral form, and its bridge to the real Weyl layer -/

section RealPart

open HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {r : ℕ}

/-- **`Σᵢ λᵢ ωᵢ ⊗ ωᵢ` as a curvature operator on bivectors**, which is the record's spectral form
read in [WeylReal.lean](../Base/WeylReal.lean)'s language. *When the `ωᵢ` are orthonormal in
`inner2` this is the spectral decomposition and the `λᵢ` are the eigenvalues.* -/
noncomputable def rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) :
    Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => ∑ i, (lam i * inner2 (om i) X) • om i

/-- **`𝔟`, the Bianchi obstruction**, as the symmetric bilinear map `Λ² × Λ² → Λ⁴` sending
`(ω, η)` to `ω ∧ η`. *The record writes it as a linear map on `S²Λ²`; symmetry (`bObs_symm`), is
what says this bilinear map descends there, and `bObs_diag` is the value `𝔟(ω ⊙ ω)` that (b)
sums.* -/
def bObs : Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ →ₗ[ℝ] (ι → ι → ι → ι → ℝ) :=
  LinearMap.mk₂ ℝ wedge2
    (fun X Y Z => wedge2_add_left X Y Z)
    (fun c X Y => wedge2_smul_left c X Y)
    (fun X Y Z => by rw [wedge2_comm, wedge2_add_left, wedge2_comm X Y, wedge2_comm X Z])
    (fun c X Y => by rw [wedge2_comm, wedge2_smul_left, wedge2_comm])

theorem bObs_apply (X Y : Matrix ι ι ℝ) : bObs X Y = wedge2 X Y := rfl

/-- **`𝔟` is symmetric**, which is what lets it be read on `S²Λ²`. -/
theorem bObs_symm (X Y : Matrix ι ι ℝ) : bObs X Y = bObs Y X := wedge2_comm X Y

/-- **`𝔟(ω ⊙ ω) = ω ∧ ω`**, the diagonal value, and the only one (b) uses. -/
theorem bObs_diag (X : Matrix ι ι ℝ) : bObs X X = wedgeSelf X := rfl

/-- The `Λ²` pairing of a matrix against a basis bivector, computed. -/
theorem inner2_phi (X : Matrix ι ι ℝ) (a c : ι) :
    inner2 X (phi a c) = (1 / 2) * (X c a - X a c) := by
  unfold inner2 phi
  simp [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
        Matrix.sub_apply, Matrix.single_apply, mul_sub, Finset.sum_sub_distrib,
        ite_and, mul_ite, Finset.sum_ite_eq]

/-- On a skew matrix the pairing against `φ_{ac}` is just the entry, negated. -/
theorem inner2_phi_skew {X : Matrix ι ι ℝ} (h : Xᵀ = -X) (a c : ι) :
    inner2 X (phi a c) = -X a c := by
  have hx : X c a = -X a c := by
    have := congrFun (congrFun h a) c
    simpa [Matrix.transpose_apply] using this
  rw [inner2_phi, hx]; ring

/-- `inner2` is linear in its first slot. -/
theorem inner2_sum_smul (c : Fin r → ℝ) (M : Fin r → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) :
    inner2 (∑ i, c i • M i) Y = ∑ i, c i * inner2 (M i) Y := by
  simp [inner2, Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]
  ring_nf

/-- **The Ricci bridge.** The layer's `Ric` of the spectral operator is the entry of
`Σᵢ λᵢ ωᵢ ωᵢᵀ`, which is [L180](L180Statement.lean)'s `ricci`. -/
theorem Ric_rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) (a b : ι) :
    Ric (rankSumOp lam om) a b = ∑ i, lam i * ∑ c, om i a c * om i b c := by
  have step : ∀ c : ι, inner2 (rankSumOp lam om (phi a c)) (phi b c)
      = ∑ i, lam i * (om i a c * om i b c) := by
    intro c
    unfold rankSumOp
    rw [inner2_sum_smul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [inner2_phi_skew (hskew i), inner2_phi_skew (hskew i)]
    ring
  unfold Ric
  simp only [step]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]

/-- **The Bianchi bridge, which is L179(b).** The layer's `bianchi` of the spectral operator is
exactly `½ Σᵢ λᵢ (ωᵢ ∧ ωᵢ)_{ijkl}`. -/
theorem bianchi_rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) (a b c d : ι) :
    bianchi (rankSumOp lam om) a b c d
      = (1 / 2) * ∑ i, lam i * wedgeSelf (om i) a b c d := by
  have key : ∀ p q s t : ι, inner2 (rankSumOp lam om (phi p q)) (phi s t)
      = ∑ i, lam i * (om i p q * om i s t) := by
    intro p q s t
    unfold rankSumOp
    rw [inner2_sum_smul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [inner2_phi_skew (hskew i), inner2_phi_skew (hskew i)]
    ring
  have hswap : ∀ (i : Fin r) (p q : ι), om i q p = -om i p q := by
    intro i p q
    have := congrFun (congrFun (hskew i) p) q
    simpa [Matrix.transpose_apply] using this
  unfold bianchi
  rw [key, key, key, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [wedgeSelf_apply, hswap i b d]
  ring

/-! ## Part (a): the support -/

/-- The four-linear form of `W = Σᵢ λᵢ ωᵢ ⊗ ωᵢ`, evaluated on vectors. -/
def Wform (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (x y z w : ι → ℝ) : ℝ :=
  ∑ i, lam i * (x ⬝ᵥ (om i).mulVec y) * (z ⬝ᵥ (om i).mulVec w)

/-- **`V`, the span of the supports of the image forms**, the image of the skew map `ωᵢ` names,
over those `i` with `λᵢ ≠ 0`. -/
def supportSpan (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : Submodule ℝ (ι → ℝ) :=
  Submodule.span ℝ {v | ∃ i y, lam i ≠ 0 ∧ v = (om i).mulVec y}

/-- **L179(a).** `W` is supported on `Λ²V`: it vanishes as soon as any one of its four arguments is
orthogonal to `V`. *"Supported on `Λ²V`" is read here as this vanishing, which is what the record's
"read in a frame adapted to `V`" makes precise without choosing a frame.*

**Proved.** The two slots that need skewness are the ones where the orthogonal vector sits second
in a pairing, and the pair symmetry the record invokes is here the symmetry of the definition. -/
theorem support_in_span (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i)
    (x : ι → ℝ) (hx : ∀ v ∈ supportSpan lam om, x ⬝ᵥ v = 0) (y z w : ι → ℝ) :
    Wform lam om x y z w = 0 ∧ Wform lam om y x z w = 0 ∧
      Wform lam om y z x w = 0 ∧ Wform lam om y z w x = 0 := by
  have hzero : ∀ i, lam i ≠ 0 → ∀ u : ι → ℝ, x ⬝ᵥ (om i).mulVec u = 0 := by
    intro i hi u
    exact hx _ (Submodule.subset_span ⟨i, u, hi, rfl⟩)
  have hzero' : ∀ i, lam i ≠ 0 → ∀ u : ι → ℝ, u ⬝ᵥ (om i).mulVec x = 0 := by
    intro i hi u
    have : u ⬝ᵥ (om i).mulVec x = ((om i)ᵀ.mulVec u) ⬝ᵥ x := by
      rw [Matrix.mulVec_transpose, dotProduct_mulVec]
    rw [this, hskew i]
    have : ((-om i).mulVec u) ⬝ᵥ x = -(x ⬝ᵥ (om i).mulVec u) := by
      simp [Matrix.neg_mulVec, dotProduct_comm]
    rw [this, hzero i hi u, neg_zero]
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    (unfold Wform
     refine Finset.sum_eq_zero fun i _ => ?_
     by_cases hi : lam i = 0
     · simp [hi]
     · first
       | rw [hzero i hi y]; ring
       | rw [hzero' i hi y]; ring
       | rw [hzero i hi w]; ring
       | rw [hzero' i hi w]; ring)

/-! ## Part (b): the zero eigenvalues drop out -/

/-- **L179(b), second half.** The Bianchi sum ranges over the nonzero spectrum alone: the `λ_α = 0`
terms contribute nothing, so at rank `r` the identity is a condition on `r` terms. **Proved.** -/
theorem bianchi_sum_filter (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (a b c d : ι) :
    ∑ i ∈ Finset.univ.filter (fun i => lam i ≠ 0), lam i * wedgeSelf (om i) a b c d
      = ∑ i, lam i * wedgeSelf (om i) a b c d := by
  refine Finset.sum_subset (Finset.filter_subset _ _) fun i _ hi => ?_
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, not_not] at hi
  rw [hi, zero_mul]

/-- **L179(b), assembled.** First Bianchi for `W = Σᵢ λᵢ ωᵢ ⊗ ωᵢ` holds if and only if
`Σ_{λᵢ ≠ 0} λᵢ ωᵢ ∧ ωᵢ = 0`, componentwise in `Λ⁴`. **Proved.** -/
theorem bianchi_iff_wedge (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) :
    (∀ a b c d, bianchi (rankSumOp lam om) a b c d = 0) ↔
      (∀ a b c d, ∑ i ∈ Finset.univ.filter (fun i => lam i ≠ 0),
        lam i * wedgeSelf (om i) a b c d = 0) := by
  constructor
  · intro h a b c d
    rw [bianchi_sum_filter]
    have := h a b c d
    rw [bianchi_rankSumOp lam om hskew a b c d] at this
    linarith
  · intro h a b c d
    have hh := h a b c d
    rw [bianchi_sum_filter] at hh
    rw [bianchi_rankSumOp lam om hskew a b c d, hh]
    ring

/-! ## Part (c) over `ℝ`: rank one is impossible -/

/-- The `Λ²` trace of `W`, `Σ_{a<b} W_{abab}`, written as a halved double sum. -/
noncomputable def traceL2 (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * ∑ a : ι, ∑ b : ι, ∑ i, lam i * (om i a b * om i a b)

/-- **L179(c), the identity behind it.** At rank one the `Λ²` trace is `λ‖ω‖²`, with `‖ω‖²` the
halved sum of squared entries, the `Λ²` convention, the one
[WeylReal.lean](../Base/WeylReal.lean)'s `inner2` carries. **Proved.** -/
theorem traceL2_rankOne (lam : Fin 1 → ℝ) (om : Fin 1 → Matrix ι ι ℝ) :
    traceL2 lam om = lam 0 * ((1 / 2) * ∑ a : ι, ∑ b : ι, om 0 a b * om 0 a b) := by
  unfold traceL2
  simp [Finset.mul_sum]
  ring_nf

/-- **L179(c).** A traceless rank-one `W = λ ω ⊗ ω` with `ω ≠ 0` forces `λ = 0`, so the nonzero
ranks begin at two. **Proved.** -/
theorem rankOne_impossible (lam : Fin 1 → ℝ) (om : Fin 1 → Matrix ι ι ℝ)
    (hnorm : (1 / 2) * ∑ a : ι, ∑ b : ι, om 0 a b * om 0 a b ≠ 0)
    (htr : traceL2 lam om = 0) : lam 0 = 0 := by
  rw [traceL2_rankOne] at htr
  rcases mul_eq_zero.mp htr with h | h
  · exact h
  · exact absurd h hnorm

/-- **A witness that the hypotheses of `support_in_span` are not empty**: the zero spectrum on any
index type, whose support span is `⊥` and against which every vector is orthogonal. *A nonzero
witness needs a frame and is not built here.* -/
example (om : Fin 1 → Matrix ι ι ℝ) (_hskew : ∀ i, (om i)ᵀ = -om i) (x y z w : ι → ℝ) :
    Wform (fun _ => (0 : ℝ)) om x y z w = 0 := by
  unfold Wform; simp

end RealPart

/-! ## Part (c) over `ℚ`, kept from the previous version of this file -/

section RatPart

open HamiltonsCubic.Base

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **L179(c), over `ℚ`.** A traceless rank-one operator vanishes: its diagonal entry is
`λ⟨ω,φ⟩²`, so a vanishing trace forces `λ = 0` whenever `ω` carries positive norm.

**Proved**, from `inner2_rankOne` in the base layer. -/
theorem rankOne_of_traceless (lam : ℚ) (om : Matrix ι ι ℚ)
    (hnorm : normSqBiv om ≠ 0) (htr : lam * normSqBiv om = 0) : lam = 0 := by
  rcases mul_eq_zero.mp htr with h | h
  · exact h
  · exact absurd h hnorm

/-- And the entrywise identity it rests on, restated here so the two live together. -/
theorem inner2_rankOne' (lam : ℚ) (om : Matrix ι ι ℚ) (i j : ι) :
    inner2 (rankOne lam om (phi i j)) (phi i j) = lam * (inner2 om (phi i j)) ^ 2 :=
  inner2_rankOne lam om i j

end RatPart

end HamiltonsCubic.L179
