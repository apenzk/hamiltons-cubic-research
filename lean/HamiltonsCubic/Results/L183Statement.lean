import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.SelfDual

/-!
# L183, stated over the real Weyl layer

**The record's statement**, from [diagonal-half.md](../../../findings/diagonal-half.md)'s
*Lemma L183, a rank-three Weyl tensor is an orthonormal triple whose images are collinear*:

> **Statement.** Define `Φ : Λ²ℝⁿ → S²(ℝⁿ) ⊕ Λ⁴ℝⁿ` by `Φ(ω) = (ω², ω ∧ ω)`. Then
> `W = Σ_{i=1}^{3} λᵢ ωᵢ ⊗ ωᵢ` with the `ωᵢ` orthonormal and every `λᵢ ≠ 0` lies in `𝒲ₙ`
> **if and only if the three points `Φ(ω₁), Φ(ω₂), Φ(ω₃)` either all coincide or are distinct and
> collinear**, collinear **jointly** in the direct sum, which is strictly stronger than collinear
> in each factor. **On the distinct branch the weights are determined up to scale by the
> collinearity ratio; on the coincident branch they are not.**

## The `iff` is split, and this is a faithfulness note rather than a weakening

**The record's "if and only if" cannot hold with the weights held fixed, and the record's own proof
of the converse does not claim it does**, it reads *"all three coinciding lets any weight vector
summing to zero serve"*, which produces weights rather than using the given ones. Concretely, three
coincident images with `λ = (1,1,1)` give `Σ λᵢ Φᵢ = 3 Φ₁ ≠ 0`, so that `W` is not Weyl while the
configuration is coincident.

So the two directions are typed separately, with the exact scope each one has:

* `collinear_of_weyl`, **forward, at the given weights**: `W ∈ 𝒲ₙ` implies the trichotomy.
* `exists_weights_of_coincident` and `exists_weights_of_collinear`, **converse, as existence**:
  a coincident or a distinct-collinear configuration carries *some* triple of nonzero weights
  summing to zero that makes it Weyl.
* `weyl_iff_phi_sum`, the bridge both rest on: `W ∈ 𝒲ₙ` is exactly `Σᵢ λᵢ Φ(ωᵢ) = 0`.

`Φ` is [SelfDual.lean](../Base/SelfDual.lean)'s, so `Λ⁴` is realised by components as in
[L179](L179Statement.lean); `S²(ℝⁿ) ⊕ Λ⁴ℝⁿ` is the product
`Matrix ι ι ℝ × (ι → ι → ι → ι → ℝ)`, a real vector space, so "collinear jointly in the direct sum"
is collinearity there and not in each factor, which is the strengthening the record insists on.

## The `n = 4` coincidence is typed

*The record's box* **"AND IT EXPLAINS WHY `n = 4` IS EASY: THERE THE THREE IMAGES COINCIDE"** *is
the `Dim4` section*: `Phi_unitSD_eq` is `Φ₁ = Φ₂ = Φ₃` on the unit self-dual forms of `ℝ⁴`, in both
components, the squares by [SelfDual.lean](../Base/SelfDual.lean)'s `unitSD_sq`, the self-wedges
by `wedgeSelf_sdForm_eq`, which is the `Λ⁴ℝ⁴` one-dimensionality that base layer leaves open,
proved here at `Fin 4` on the `256` index tuples. `weyl_of_sum_zero` is the record's *"every weight
vector summing to zero gives a Weyl tensor"*, and with `inner2_unitSD` it makes the coincident
branch of `collinear_of_weyl` inhabited.

## What is NOT typed here

**Orthonormality of the `ωᵢ` is a hypothesis of the theorems that need it and of no others.** The
bridge `weyl_iff_phi_sum` holds for any skew triple; only `sum_lam_eq_zero` consumes the unit
norms, exactly as the record's box *"mutual orthogonality is unused; unit norm is not"* says. The
claim that orthonormality makes the `λᵢ` the eigenvalues and the rank three is proved as
`rankSumOp_eigen` for the eigen-equation and is **not** proved for the rank: `rankSumOp` is a
function on `Λ²` rather than a `LinearMap`, so it carries no `finrank` of its range.

**The counts around the `n = 4` family**, the record's *"the weight plane at a fixed frame is
`2`-dimensional, the tensor set `5`-dimensional, and the scale-free moduli `1`-dimensional"*, are
dimensions of parameter sets and are not typed; `weyl_of_sum_zero` supplies the family and not its
dimension. **`θ` on that family is not typed either.**
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L183

open HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {r : ℕ}

noncomputable section

/-! ## The wedge on components, and `Φ`

*`wedgeSelf` and `Phi` are [SelfDual.lean](../Base/SelfDual.lean)'s, so `Φ : Λ²ℝⁿ → S²(ℝⁿ) ⊕ Λ⁴ℝⁿ`
is the layer's map and this file keeps no copy of it.* -/

/-! ## The spectral operator and the bridge to `IsWeyl` -/

def rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) :
    Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => ∑ i, (lam i * inner2 (om i) X) • om i

theorem inner2_phi (X : Matrix ι ι ℝ) (a c : ι) :
    inner2 X (phi a c) = (1 / 2) * (X c a - X a c) := by
  unfold inner2 phi
  simp [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
        Matrix.sub_apply, Matrix.single_apply, mul_sub, Finset.sum_sub_distrib,
        ite_and, mul_ite, Finset.sum_ite_eq]

theorem inner2_phi_skew {X : Matrix ι ι ℝ} (h : Xᵀ = -X) (a c : ι) :
    inner2 X (phi a c) = -X a c := by
  have hx : X c a = -X a c := by
    have := congrFun (congrFun h a) c
    simpa [Matrix.transpose_apply] using this
  rw [inner2_phi, hx]; ring

theorem inner2_comm (X Y : Matrix ι ι ℝ) : inner2 X Y = inner2 Y X := by
  unfold inner2
  rw [show (Xᵀ * Y).trace = ((Xᵀ * Y)ᵀ).trace from (Matrix.trace_transpose _).symm]
  simp [Matrix.transpose_mul]

theorem inner2_sum_smul (c : Fin r → ℝ) (M : Fin r → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) :
    inner2 (∑ i, c i • M i) Y = ∑ i, c i * inner2 (M i) Y := by
  simp [inner2, Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]
  ring_nf

/-- **A spectral sum maps bivectors to bivectors** (`IsWeyl`'s first clause) since it lands in
the span of the `ωᵢ`. *This needs skewness of the `ωᵢ` and nothing else.* -/
theorem rankSumOp_isSkew (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) (X : Matrix ι ι ℝ) : IsSkew (rankSumOp lam om X) := by
  unfold IsSkew rankSumOp
  rw [Matrix.transpose_sum, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun i _ => by rw [Matrix.transpose_smul, hskew i, smul_neg]

/-- **The self-adjointness clause of `IsWeyl` is automatic** for a spectral sum, and needs neither
orthonormality nor skewness. -/
theorem rankSumOp_selfAdjoint (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (X Y : Matrix ι ι ℝ) : inner2 (rankSumOp lam om X) Y = inner2 X (rankSumOp lam om Y) := by
  unfold rankSumOp
  rw [inner2_sum_smul, inner2_comm, inner2_sum_smul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [inner2_comm (om i) X]
  ring

/-- **The `ωᵢ` are eigenforms with eigenvalues `λᵢ` when they are orthonormal**, which is the
spectral reading orthonormality supplies. -/
theorem rankSumOp_eigen (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hon : ∀ i i', inner2 (om i) (om i') = if i = i' then 1 else 0) (i' : Fin r) :
    rankSumOp lam om (om i') = lam i' • om i' := by
  unfold rankSumOp
  rw [Finset.sum_congr rfl (fun i _ => by rw [hon i i'])]
  simp only [mul_ite, mul_one, mul_zero, ite_smul, zero_smul]
  rw [Finset.sum_ite_eq' _ i' _]
  simp

theorem Ric_rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) (a b : ι) :
    Ric (rankSumOp lam om) a b = -(∑ i, lam i • (om i * om i)) a b := by
  have step : ∀ c : ι, inner2 (rankSumOp lam om (phi a c)) (phi b c)
      = ∑ i, lam i * (om i a c * om i b c) := by
    intro c
    unfold rankSumOp
    rw [inner2_sum_smul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [inner2_phi_skew (hskew i), inner2_phi_skew (hskew i)]
    ring
  have hswap : ∀ (i : Fin r) (p q : ι), om i q p = -om i p q := by
    intro i p q
    have := congrFun (congrFun (hskew i) p) q
    simpa [Matrix.transpose_apply] using this
  unfold Ric
  simp only [step]
  rw [Finset.sum_comm]
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, Matrix.mul_apply]
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [hswap i c b]
  ring

theorem bianchi_rankSumOp (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) (a b c d : ι) :
    bianchi (rankSumOp lam om) a b c d
      = (1 / 2) * (∑ i, lam i • wedgeSelf (om i)) a b c d := by
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
  rw [key, key, key, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  simp only [Finset.sum_apply, Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [wedgeSelf_apply, hswap i b d]
  ring

/-- **THE BRIDGE.** `W = Σᵢ λᵢ ωᵢ ⊗ ωᵢ` lies in `𝒲ₙ` exactly when `Σᵢ λᵢ Φ(ωᵢ) = 0` in
`S²(ℝⁿ) ⊕ Λ⁴ℝⁿ`. *Ricci-flatness is the first component, first Bianchi the second, and
self-adjointness is free; tracelessness is Ricci's trace and adds nothing, which is the record's
own remark.* **Proved**, and it uses skewness only, no orthonormality. -/
theorem weyl_iff_phi_sum (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i) :
    IsWeyl (rankSumOp lam om) ↔ (∑ i, lam i • Phi (om i)) = 0 := by
  constructor
  · intro hW
    have h1 : (∑ i, lam i • (om i * om i)) = 0 := by
      ext a b
      have := hW.2.2.2 a b
      rw [Ric_rankSumOp lam om hskew a b] at this
      simpa using congrArg Neg.neg this
    have h2 : (∑ i, lam i • wedgeSelf (om i)) = 0 := by
      funext a b c d
      have := bianchi_rankSumOp lam om hskew a b c d
      rw [hW.2.2.1 a b c d] at this
      simp only [Pi.zero_apply]
      linarith
    have : (∑ i, lam i • Phi (om i)) = ((∑ i, lam i • (om i * om i)),
        (∑ i, lam i • wedgeSelf (om i))) := by
      unfold Phi
      rw [Prod.ext_iff]
      exact ⟨Prod.fst_sum, Prod.snd_sum⟩
    rw [this, h1, h2]; rfl
  · intro h
    have hcomp : (∑ i, lam i • Phi (om i)) = ((∑ i, lam i • (om i * om i)),
        (∑ i, lam i • wedgeSelf (om i))) := by
      unfold Phi
      rw [Prod.ext_iff]
      exact ⟨Prod.fst_sum, Prod.snd_sum⟩
    rw [hcomp] at h
    have h1 : (∑ i, lam i • (om i * om i)) = 0 := congrArg Prod.fst h
    have h2 : (∑ i, lam i • wedgeSelf (om i)) = 0 := congrArg Prod.snd h
    refine ⟨fun X _ => rankSumOp_isSkew lam om hskew X,
      fun X Y _ _ => rankSumOp_selfAdjoint lam om X Y, ?_, ?_⟩
    · intro a b c d
      rw [bianchi_rankSumOp lam om hskew a b c d, h2]
      simp
    · intro a b
      rw [Ric_rankSumOp lam om hskew a b, h1]
      simp

/-- **Tracelessness is Ricci's trace**: with the `ωᵢ` of unit `Λ²` norm, `Σᵢ λᵢ ωᵢ² = 0` forces
`Σᵢ λᵢ = 0`. *This is the one place the unit norms are consumed, and orthogonality is not.* -/
theorem sum_lam_eq_zero (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (hnorm : ∀ i, inner2 (om i) (om i) = 1) (hskew : ∀ i, (om i)ᵀ = -om i)
    (h1 : (∑ i, lam i • (om i * om i)) = 0) : ∑ i, lam i = 0 := by
  have htr : ∀ i, (om i * om i).trace = -2 := by
    intro i
    have := hnorm i
    unfold inner2 at this
    rw [hskew i] at this
    simp only [Matrix.neg_mul, Matrix.trace_neg] at this
    linarith
  have : (∑ i, lam i • (om i * om i)).trace = 0 := by rw [h1]; simp
  rw [Matrix.trace_sum] at this
  simp only [Matrix.trace_smul, htr, smul_eq_mul] at this
  rw [← Finset.sum_mul] at this
  linarith

/-! ## The affine trichotomy, in an abstract real vector space

*This is where "collinear jointly in the direct sum" lives: `E` is the direct sum itself, so
collinearity is collinearity there.* -/

variable {E : Type*} [AddCommGroup E] [Module ℝ E]

/-- **Two coincident images force the third.** *`Φ₁ = Φ₂` gives `λ₃(Φ₃ - Φ₁) = 0` and `λ₃ ≠ 0`, so
exactly-two-coincident never occurs*, which is the configuration the criterion must exclude. -/
theorem two_coincide_forces_three (lam : Fin 3 → ℝ) (P : Fin 3 → E)
    (hlam : ∀ i, lam i ≠ 0) (hsum : ∑ i, lam i = 0) (h : ∑ i, lam i • P i = 0)
    (h01 : P 0 = P 1) : P 2 = P 0 := by
  simp only [Fin.sum_univ_three] at hsum h
  rw [← h01] at h
  have hs : lam 0 + lam 1 = -lam 2 := by linarith
  have key : lam 2 • (P 2 - P 0) = 0 := by
    have e : (lam 0 + lam 1) • P 0 + lam 2 • P 2 = 0 := by
      rw [add_smul]; linear_combination (norm := module) h
    rw [hs] at e
    linear_combination (norm := module) e
  rcases smul_eq_zero.mp key with hc | hc
  · exact absurd hc (hlam 2)
  · exact sub_eq_zero.mp hc

/-- **L183, forward direction.** Three points carrying nonzero weights that sum to zero and
annihilate them either all coincide or are pairwise distinct and collinear. **Proved.** -/
theorem affine_trichotomy (lam : Fin 3 → ℝ) (P : Fin 3 → E)
    (hlam : ∀ i, lam i ≠ 0) (hsum : ∑ i, lam i = 0) (h : ∑ i, lam i • P i = 0) :
    (P 0 = P 1 ∧ P 1 = P 2) ∨
      (P 0 ≠ P 1 ∧ P 1 ≠ P 2 ∧ P 0 ≠ P 2 ∧ ∃ t : ℝ, P 0 - P 2 = t • (P 1 - P 2)) := by
  by_cases h01 : P 0 = P 1
  · left
    refine ⟨h01, ?_⟩
    have := two_coincide_forces_three lam P hlam hsum h h01
    rw [← h01, this]
  · -- the key identity `λ₀ (P₀ - P₂) = -λ₁ (P₁ - P₂)`
    simp only [Fin.sum_univ_three] at hsum h
    have hs : lam 2 = -(lam 0 + lam 1) := by linarith
    have hkey : lam 0 • (P 0 - P 2) = -(lam 1 • (P 1 - P 2)) := by
      rw [hs] at h
      linear_combination (norm := module) h
    have h12 : P 1 ≠ P 2 := by
      intro hc
      apply h01
      rw [hc] at hkey
      simp only [sub_self, smul_zero, neg_zero] at hkey
      rcases smul_eq_zero.mp hkey with hz | hz
      · exact absurd hz (hlam 0)
      · rw [sub_eq_zero] at hz; rw [hz, hc]
    have h02 : P 0 ≠ P 2 := by
      intro hc
      apply h12
      rw [hc] at hkey
      simp only [sub_self, smul_zero] at hkey
      have hz0 : lam 1 • (P 1 - P 2) = 0 := neg_eq_zero.mp hkey.symm
      rcases smul_eq_zero.mp hz0 with hz | hz
      · exact absurd hz (hlam 1)
      · rw [sub_eq_zero] at hz; exact hz
    right
    refine ⟨h01, h12, h02, -(lam 1) / lam 0, ?_⟩
    have hl0 : lam 0 ≠ 0 := hlam 0
    have e : P 0 - P 2 = (lam 0)⁻¹ • (lam 0 • (P 0 - P 2)) := by
      rw [smul_smul, inv_mul_cancel₀ hl0, one_smul]
    rw [e, hkey, smul_neg, smul_smul, ← neg_smul]
    congr 1
    field_simp

/-- **L183, converse on the coincident branch.** Three coincident points carry weights `(1,1,-2)`,
nonzero and summing to zero, that annihilate them. **Proved.** -/
theorem exists_weights_of_coincident (P : Fin 3 → E) (h01 : P 0 = P 1) (h12 : P 1 = P 2) :
    ∃ lam : Fin 3 → ℝ, (∀ i, lam i ≠ 0) ∧ (∑ i, lam i = 0) ∧ (∑ i, lam i • P i = 0) := by
  refine ⟨![1, 1, -2], ?_, ?_, ?_⟩
  · intro i; fin_cases i <;> norm_num
  · simp [Fin.sum_univ_three]; norm_num
  · simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
        Matrix.tail_cons, Matrix.head_cons]
    rw [h01, h12]
    module

/-- **L183, converse on the distinct branch.** Three pairwise-distinct collinear points carry the
weights `(1, -t, t-1)`, nonzero and summing to zero, that annihilate them. **Proved.** -/
theorem exists_weights_of_collinear (P : Fin 3 → E) (t : ℝ)
    (h01 : P 0 ≠ P 1) (h02 : P 0 ≠ P 2) (hcol : P 0 - P 2 = t • (P 1 - P 2)) :
    ∃ lam : Fin 3 → ℝ, (∀ i, lam i ≠ 0) ∧ (∑ i, lam i = 0) ∧ (∑ i, lam i • P i = 0) := by
  have ht0 : t ≠ 0 := by
    intro hc
    rw [hc, zero_smul, sub_eq_zero] at hcol
    exact h02 hcol
  have ht1 : t ≠ 1 := by
    intro hc
    rw [hc, one_smul] at hcol
    exact h01 (sub_left_inj.mp hcol)
  refine ⟨![1, -t, t - 1], ?_, ?_, ?_⟩
  · intro i; fin_cases i
    · norm_num
    · simpa using ht0
    · simpa [sub_eq_zero] using ht1
  · simp [Fin.sum_univ_three]; ring
  · simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
        Matrix.tail_cons, Matrix.head_cons]
    linear_combination (norm := module) hcol

/-- **The weights are determined up to scale on the distinct branch.** *`λ₀(P₀-P₂) = -λ₁(P₁-P₂)`
with `P₀-P₂ = t(P₁-P₂)` and `P₁ ≠ P₂` gives `λ₁ = -t λ₀` and `λ₂ = (t-1)λ₀`, so `λ` is
`λ₀ · (1,-t,t-1)`.* **Proved**, and the record records this clause as asserted rather than argued.
-/
theorem weights_unique_up_to_scale (lam : Fin 3 → ℝ) (P : Fin 3 → E) (t : ℝ)
    (hsum : ∑ i, lam i = 0) (h : ∑ i, lam i • P i = 0)
    (h12 : P 1 ≠ P 2) (hcol : P 0 - P 2 = t • (P 1 - P 2)) :
    lam 1 = -(t * lam 0) ∧ lam 2 = (t - 1) * lam 0 := by
  simp only [Fin.sum_univ_three] at hsum h
  have hs : lam 2 = -(lam 0 + lam 1) := by linarith
  have hkey : (lam 0 * t + lam 1) • (P 1 - P 2) = 0 := by
    rw [hs] at h
    rw [add_smul, mul_smul, ← hcol]
    linear_combination (norm := module) h
  have h1 : lam 0 * t + lam 1 = 0 := by
    rcases smul_eq_zero.mp hkey with hc | hc
    · exact hc
    · exact absurd (sub_eq_zero.mp hc) h12
  constructor
  · linarith [h1]
  · rw [hs]; linarith [h1]

/-- **On the coincident branch the weights are NOT determined**: `(1,1,-2)` and `(1,-2,1)` both
serve and are not proportional. **Proved**, and it is what makes the clause branch-specific. -/
theorem weights_not_unique_of_coincident (P : Fin 3 → E) (h01 : P 0 = P 1) (h12 : P 1 = P 2) :
    (∑ i, (![1, 1, -2] : Fin 3 → ℝ) i • P i = 0) ∧
      (∑ i, (![1, -2, 1] : Fin 3 → ℝ) i • P i = 0) := by
  constructor <;>
    · simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
        Matrix.tail_cons, Matrix.head_cons]
      rw [h01, h12]
      module

/-! ## `n = 4`: the three images coincide

*The record's box:* **"AND IT EXPLAINS WHY `n = 4` IS EASY: THERE THE THREE IMAGES COINCIDE. On
the self-dual forms of `ℝ⁴` every `ωᵢ² = -½Id₄` and every `ωᵢ ∧ ωᵢ = f₁₂₃₄`, so `Φ₁ = Φ₂ = Φ₃` and
every weight vector summing to zero gives a Weyl tensor."** *All of that is typed here, on
[SelfDual.lean](../Base/SelfDual.lean)'s `unitSD`, the unit self-dual forms of the standard frame
of `ℝ⁴`.* -/

section Dim4

set_option maxHeartbeats 1000000 in
/-- **The self-wedges of the three self-dual forms agree at every four indices.** *Each has
`(0,1,2,3)` component `2`, [SelfDual.lean](../Base/SelfDual.lean)'s `wedgeSelf_sdForm_apply`,
and `Λ⁴ℝ⁴` is one-dimensional, which at `Fin 4` is the sign bookkeeping this proof carries out on
the `256` index tuples.* -/
theorem wedgeSelf_sdForm_eq (k : Fin 3) : wedgeSelf (sdForm k) = wedgeSelf (sdForm 0) := by
  funext a b c d
  fin_cases k
  · rfl
  · show wedgeSelf (phi 0 2 - phi 1 3) a b c d = wedgeSelf (phi 0 1 + phi 2 3) a b c d
    fin_cases a <;> fin_cases b <;> fin_cases c <;> fin_cases d <;>
      simp [wedgeSelf_apply, phi]
  · show wedgeSelf (phi 0 3 + phi 1 2) a b c d = wedgeSelf (phi 0 1 + phi 2 3) a b c d
    fin_cases a <;> fin_cases b <;> fin_cases c <;> fin_cases d <;>
      simp [wedgeSelf_apply, phi]

/-- **The unit self-dual forms are skew**, so the theorems above apply to them. -/
theorem unitSD_isSkew (k : Fin 3) : (unitSD k)ᵀ = -unitSD k := by
  have h := sdForm_isSkew k
  unfold IsSkew at h
  unfold unitSD
  rw [Matrix.transpose_smul, h, smul_neg]

/-- **`ω ∧ ω` is the same `4`-form for all three unit self-dual forms.** -/
theorem wedgeSelf_unitSD_eq (i j : Fin 3) : wedgeSelf (unitSD i) = wedgeSelf (unitSD j) := by
  unfold unitSD
  rw [wedgeSelf_smul, wedgeSelf_smul, wedgeSelf_sdForm_eq i, wedgeSelf_sdForm_eq j]

/-- **`Φ₁ = Φ₂ = Φ₃` on `ℝ⁴`**, the record's coincidence, in both components at once: the squares
are `-½Id₄` by [SelfDual.lean](../Base/SelfDual.lean)'s `unitSD_sq` and the self-wedges agree by
`wedgeSelf_unitSD_eq`. **So the coincident branch of `collinear_of_weyl` is inhabited.** -/
theorem Phi_unitSD_eq (i j : Fin 3) : Phi (unitSD i) = Phi (unitSD j) := by
  unfold Phi
  rw [Prod.ext_iff]
  exact ⟨by rw [unitSD_sq, unitSD_sq], wedgeSelf_unitSD_eq i j⟩

/-- **Every weight vector summing to zero gives a Weyl tensor on `ℝ⁴`**, which is the record's
*"every weight vector summing to zero gives a Weyl tensor"* and the reason `n = 4` carries a
family rather than a point. *The weights are unconstrained beyond their sum, so this is also the
witness that the coincident branch does not determine them,* `weights_not_unique_of_coincident`
*read on an actual tensor.* -/
theorem weyl_of_sum_zero (lam : Fin 3 → ℝ) (hsum : ∑ i, lam i = 0) :
    IsWeyl (rankSumOp lam unitSD) := by
  refine (weyl_iff_phi_sum lam unitSD (fun i => unitSD_isSkew i)).mpr ?_
  rw [Finset.sum_congr rfl (fun i _ => by rw [Phi_unitSD_eq i 0]), ← Finset.sum_smul, hsum,
    zero_smul]

/-- **The three unit self-dual forms are orthonormal**, so `collinear_of_weyl`'s hypotheses hold
of them at any nonzero weight vector summing to zero. -/
theorem inner2_unitSD' (i j : Fin 3) : inner2 (unitSD i) (unitSD j) = if i = j then 1 else 0 :=
  inner2_unitSD i j

end Dim4

/-! ## The lemma, assembled -/

/-- **L183, forward, on the Weyl side.** A rank-three `W = Σᵢ λᵢ ωᵢ ⊗ ωᵢ` in `𝒲ₙ` with the `ωᵢ`
orthonormal and every `λᵢ ≠ 0` has its three images `Φ(ωᵢ)` either all coincident or pairwise
distinct and collinear in `S²(ℝⁿ) ⊕ Λ⁴ℝⁿ`. **Proved.** -/
theorem collinear_of_weyl (lam : Fin 3 → ℝ) (om : Fin 3 → Matrix ι ι ℝ)
    (hskew : ∀ i, (om i)ᵀ = -om i)
    (hon : ∀ i i', inner2 (om i) (om i') = if i = i' then 1 else 0)
    (hlam : ∀ i, lam i ≠ 0) (hW : IsWeyl (rankSumOp lam om)) :
    (Phi (om 0) = Phi (om 1) ∧ Phi (om 1) = Phi (om 2)) ∨
      (Phi (om 0) ≠ Phi (om 1) ∧ Phi (om 1) ≠ Phi (om 2) ∧ Phi (om 0) ≠ Phi (om 2) ∧
        ∃ t : ℝ, Phi (om 0) - Phi (om 2) = t • (Phi (om 1) - Phi (om 2))) := by
  have hsumPhi := (weyl_iff_phi_sum lam om hskew).mp hW
  have hcomp : (∑ i, lam i • Phi (om i)) = ((∑ i, lam i • (om i * om i)),
      (∑ i, lam i • wedgeSelf (om i))) := by
    unfold Phi
    rw [Prod.ext_iff]
    exact ⟨Prod.fst_sum, Prod.snd_sum⟩
  have h1 : (∑ i, lam i • (om i * om i)) = 0 := by
    rw [hcomp] at hsumPhi; exact congrArg Prod.fst hsumPhi
  have hnorm : ∀ i, inner2 (om i) (om i) = 1 := by intro i; simpa using hon i i
  have hsum : ∑ i, lam i = 0 := sum_lam_eq_zero lam om hnorm hskew h1
  exact affine_trichotomy lam (fun i => Phi (om i)) hlam hsum hsumPhi

/-- **L183, converse, on the Weyl side.** A coincident or a distinct-collinear triple of images
carries nonzero weights summing to zero for which `Σᵢ λᵢ ωᵢ ⊗ ωᵢ` is Weyl. *The weights are
produced, not given, see the module docstring on the scope of the record's `iff`.* **Proved.** -/
theorem weyl_of_collinear (om : Fin 3 → Matrix ι ι ℝ) (hskew : ∀ i, (om i)ᵀ = -om i)
    (hcfg : (Phi (om 0) = Phi (om 1) ∧ Phi (om 1) = Phi (om 2)) ∨
      (Phi (om 0) ≠ Phi (om 1) ∧ Phi (om 0) ≠ Phi (om 2) ∧
        ∃ t : ℝ, Phi (om 0) - Phi (om 2) = t • (Phi (om 1) - Phi (om 2)))) :
    ∃ lam : Fin 3 → ℝ, (∀ i, lam i ≠ 0) ∧ (∑ i, lam i = 0) ∧ IsWeyl (rankSumOp lam om) := by
  have hbuild : ∀ lam : Fin 3 → ℝ, (∑ i, lam i • Phi (om i)) = 0 → IsWeyl (rankSumOp lam om) :=
    fun lam h => (weyl_iff_phi_sum lam om hskew).mpr h
  rcases hcfg with ⟨h01, h12⟩ | ⟨h01, h02, t, hcol⟩
  · obtain ⟨lam, hne, hs, hz⟩ := exists_weights_of_coincident (fun i => Phi (om i)) h01 h12
    exact ⟨lam, hne, hs, hbuild lam hz⟩
  · obtain ⟨lam, hne, hs, hz⟩ := exists_weights_of_collinear (fun i => Phi (om i)) t h01 h02 hcol
    exact ⟨lam, hne, hs, hbuild lam hz⟩

end

end HamiltonsCubic.L183
