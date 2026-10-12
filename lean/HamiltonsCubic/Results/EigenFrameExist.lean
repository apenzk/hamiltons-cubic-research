import HamiltonsCubic.Results.XinvFrame
import HamiltonsCubic.Results.L54Schur
import HamiltonsCubic.Results.L240SlotBasis
import HamiltonsCubic.Results.L70Weyl

set_option linter.style.longLine false

/-!
# An orthonormal eigenframe of `W` on `Λ²` exists

Several lemmas of the layer take an orthonormal eigenframe of `W` as a hypothesis
([L41Statement.lean](L41Statement.lean)'s `EigenFrame`, used by
[XinvFrame.lean](XinvFrame.lean)'s `L155_record` and `L154_record`). **This file builds one** from
Mathlib's spectral theorem at `Mpair R`, `M` in the pair basis
([L54Schur.lean](L54Schur.lean)):

- `frameVec`: `v_k = ∑_{a<b} U_k(a,b) φ_ab`, `U` Mathlib's orthonormal eigenbasis of `Mpair R`;
- `eigenFrame_exists`: `EigenFrame R v λ`, `λ` the eigenvalues of `Mpair R`, for `R` linear,
  preserving bivectors and self-adjoint on them;
- `absOp`: `|W| = ∑ |λ_k| ⟨·, v_k⟩ v_k` on the same frame, with `absOp_eigenFrame`;
- `L155_exists`, `L154_exists`: L155 and L154 (i) for the record's `X_inv` with no frame hypothesis;
- `L155_proper`: L155's clause *proper in `𝔰𝔬(n)` whenever `𝔨 ≠ 0`*, a zero eigenvalue's frame vector
  being a nonzero skew element of `ker W` outside `span{v_α : λ_α ≠ 0}`;
- `L70_bound_exists`: L70's bound at every spectrum with the eigenbasis supplied.
-/

namespace HamiltonsCubic.EigenFrameExist

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SecondKind HamiltonsCubic.L41Statement

variable {n : ℕ}

/-- `φ_ab` over ordered pairs is orthonormal. -/
theorem inner2_phi_pairs (p q : Pairs n) :
    inner2 (phi p.1.1 p.1.2) (phi q.1.1 q.1.2) = if p = q then 1 else 0 := by
  rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  have h2 : ¬(p.1.2 = q.1.1 ∧ p.1.1 = q.1.2) := fun h => by
    have hp := p.2; have hq := q.2
    rw [h.1, h.2] at hp; exact absurd (lt_trans hp hq) (lt_irrefl _)
  rw [if_neg h2, sub_zero]
  by_cases hpq : p = q
  · subst hpq; simp
  · have : ¬(p.1.1 = q.1.1 ∧ p.1.2 = q.1.2) := fun h => hpq (Subtype.ext (Prod.ext h.1 h.2))
    rw [if_neg this, if_neg hpq]

section frame

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- The coordinates of Mathlib's orthonormal eigenbasis of `Mpair R`. -/
noncomputable def U (k p : Pairs n) : ℝ :=
  ((Mpair_isHermitian R hR hskew hsym).eigenvectorBasis k) p

/-- **The eigenframe**: `v_k = ∑_{a<b} U_k(a,b) φ_ab`. -/
noncomputable def frameVec (k : Pairs n) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ p : Pairs n, U R hR hskew hsym k p • phi p.1.1 p.1.2

theorem U_cols (k l : Pairs n) : ∑ p, U R hR hskew hsym k p * U R hR hskew hsym l p = if k = l then 1 else 0 := by
  have hU := Matrix.mem_unitaryGroup_iff'.mp (Mpair_isHermitian R hR hskew hsym).eigenvectorUnitary.2
  have h := congrFun (congrFun hU k) l
  simp only [Matrix.mul_apply, Matrix.star_apply, star_trivial, Matrix.one_apply] at h
  exact h

theorem U_rows (p q : Pairs n) : ∑ k, U R hR hskew hsym k p * U R hR hskew hsym k q = if p = q then 1 else 0 := by
  have hU := Matrix.mem_unitaryGroup_iff.mp (Mpair_isHermitian R hR hskew hsym).eigenvectorUnitary.2
  have h := congrFun (congrFun hU p) q
  simp only [Matrix.mul_apply, Matrix.star_apply, star_trivial, Matrix.one_apply] at h
  exact h

theorem U_eigen (k q : Pairs n) :
    ∑ p, Mpair R q p * U R hR hskew hsym k p
      = (Mpair_isHermitian R hR hskew hsym).eigenvalues k * U R hR hskew hsym k q := by
  have h := congrFun ((Mpair_isHermitian R hR hskew hsym).mulVec_eigenvectorBasis k) q
  simpa [Matrix.mulVec, dotProduct, U] using h

include hR hskew hsym in
theorem frameVec_skew (k : Pairs n) : IsSkew (frameVec R hR hskew hsym k) :=
  HamiltonsCubic.Results.isSkew_sum' _ _ fun p _ =>
    HamiltonsCubic.FamilyLayer.isSkew_smul _ (phi_isSkew _ _)

/-- Pairing against a frame vector reads the coordinates. -/
theorem inner2_frameVec (X : Matrix (Fin n) (Fin n) ℝ) (k : Pairs n) :
    inner2 X (frameVec R hR hskew hsym k) = ∑ p, U R hR hskew hsym k p * inner2 X (phi p.1.1 p.1.2) := by
  unfold frameVec
  rw [inner2_sum_right]
  exact Finset.sum_congr rfl fun p _ => HamiltonsCubic.FamilyLayer.inner2_smul_right _ _ _

theorem frameVec_orth (k l : Pairs n) :
    inner2 (frameVec R hR hskew hsym k) (frameVec R hR hskew hsym l) = if k = l then 1 else 0 := by
  rw [inner2_frameVec]
  have e : ∀ p : Pairs n, inner2 (frameVec R hR hskew hsym k) (phi p.1.1 p.1.2) = U R hR hskew hsym k p := by
    intro p
    rw [inner2_comm, inner2_frameVec]
    simp only [inner2_phi_pairs, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ,
      if_true]
    rw [Finset.sum_ite_eq]; simp
  simp only [e]
  rw [← U_cols R hR hskew hsym k l]
  exact Finset.sum_congr rfl fun p _ => mul_comm _ _

include hskew hsym in
/-- `R φ_p = ∑_q M_{qp} φ_q`. -/
theorem R_phi_pairs (p : Pairs n) :
    R (phi p.1.1 p.1.2) = ∑ q : Pairs n, Mpair R q p • phi q.1.1 q.1.2 := by
  conv_lhs => rw [HamiltonsCubic.L240SlotBasis.phi_expand_ordered _ (hskew _ (phi_isSkew _ _))]
  refine Finset.sum_congr rfl fun q _ => ?_
  congr 1
  unfold Mpair HamiltonsCubic.Results.R4
  rw [hsym _ _ (phi_isSkew _ _) (phi_isSkew _ _)]

theorem frameVec_eigen (k : Pairs n) :
    R (frameVec R hR hskew hsym k)
      = (Mpair_isHermitian R hR hskew hsym).eigenvalues k • frameVec R hR hskew hsym k := by
  unfold frameVec
  rw [HamiltonsCubic.Results.linOp_sum R hR]
  simp only [hR.2, R_phi_pairs R hskew hsym, Finset.smul_sum, smul_smul]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [← Finset.sum_smul, ← U_eigen R hR hskew hsym k q]
  congr 1
  exact Finset.sum_congr rfl fun p _ => mul_comm _ _

theorem frameVec_complete (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    X = ∑ k, inner2 X (frameVec R hR hskew hsym k) • frameVec R hR hskew hsym k := by
  conv_lhs => rw [HamiltonsCubic.L240SlotBasis.phi_expand_ordered X hX]
  simp only [inner2_frameVec]
  simp only [frameVec, Finset.smul_sum, smul_smul]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [← Finset.sum_smul]
  congr 1
  simp only [Finset.sum_mul]
  rw [Finset.sum_comm]
  have : ∀ p : Pairs n, ∑ k, U R hR hskew hsym k p * inner2 X (phi p.1.1 p.1.2) * U R hR hskew hsym k q
      = inner2 X (phi p.1.1 p.1.2) * (if p = q then 1 else 0) := by
    intro p
    rw [← U_rows R hR hskew hsym p q, Finset.mul_sum]
    exact Finset.sum_congr rfl fun k _ => by ring
  simp only [this, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  exact inner2_comm _ _

/-- **AN ORTHONORMAL EIGENFRAME EXISTS** for every `R` linear, preserving bivectors and self-adjoint
on them, with eigenvalues the spectrum of `M` in the pair basis. -/
theorem eigenFrame_exists :
    EigenFrame R (frameVec R hR hskew hsym) (Mpair_isHermitian R hR hskew hsym).eigenvalues where
  skew := frameVec_skew R hR hskew hsym
  orthonormal := frameVec_orth R hR hskew hsym
  eigen := frameVec_eigen R hR hskew hsym
  complete := frameVec_complete R hR hskew hsym

/-- **`|W|`**, the operator with the same frame and eigenvalues `|λ|`. -/
noncomputable def absOp (X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ k, (|(Mpair_isHermitian R hR hskew hsym).eigenvalues k| * inner2 X (frameVec R hR hskew hsym k)) •
    frameVec R hR hskew hsym k

theorem absOp_eigenFrame :
    EigenFrame (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
      (fun k => |(Mpair_isHermitian R hR hskew hsym).eigenvalues k|) where
  skew := frameVec_skew R hR hskew hsym
  orthonormal := frameVec_orth R hR hskew hsym
  eigen := fun j => by
    unfold absOp
    simp only [frameVec_orth R hR hskew hsym, mul_ite,
      mul_one, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  complete := frameVec_complete R hR hskew hsym

include hR in
theorem R_lin {κ : Type} (s' : Finset κ) (c : κ → ℝ) (x : κ → Matrix (Fin n) (Fin n) ℝ)
    (_ : ∀ k, IsSkew (x k)) : R (∑ k ∈ s', c k • x k) = ∑ k ∈ s', c k • R (x k) := by
  rw [HamiltonsCubic.Results.linOp_sum R hR]
  exact Finset.sum_congr rfl fun k _ => hR.2 _ _

theorem absOp_lin {κ : Type} (s' : Finset κ) (c : κ → ℝ) (x : κ → Matrix (Fin n) (Fin n) ℝ)
    (_ : ∀ k, IsSkew (x k)) :
    absOp R hR hskew hsym (∑ k ∈ s', c k • x k) = ∑ k ∈ s', c k • absOp R hR hskew hsym (x k) := by
  unfold absOp
  simp only [Frame.inner2_sum_l, Frame.inner2_smul_l, Finset.mul_sum, Finset.sum_smul, Finset.smul_sum,
    smul_smul]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => by ring_nf

theorem absOp_skew (X : Matrix (Fin n) (Fin n) ℝ) : IsSkew (absOp R hR hskew hsym X) :=
  HamiltonsCubic.Results.isSkew_sum' _ _ fun k _ =>
    HamiltonsCubic.FamilyLayer.isSkew_smul _ (frameVec_skew R hR hskew hsym k)

/-- **L155 WITH NO FRAME HYPOTHESIS**: for `W` linear, preserving bivectors and self-adjoint on
them, the record's `X_inv` vanishes iff its eigenspaces are graded. -/
theorem L155_exists :
    (∀ γ δ, XinvRec R (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
        (Mpair_isHermitian R hR hskew hsym).eigenvalues γ δ = 0)
      ↔ HamiltonsCubic.L155Frame.Graded (Mpair_isHermitian R hR hskew hsym).eigenvalues
          (omegaF (frameVec R hR hskew hsym)) :=
  L155_record (fun s' c x hx => R_lin R hR s' c x hx) hskew
    (fun s' c x hx => absOp_lin R hR hskew hsym s' c x hx) (fun X _ => absOp_skew R hR hskew hsym X)
    (eigenFrame_exists R hR hskew hsym) (absOp_eigenFrame R hR hskew hsym)

/-- **L154 (i) WITH NO FRAME HYPOTHESIS.** -/
theorem L154_exists :
    ∑ γ, XinvRec R (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
        (Mpair_isHermitian R hR hskew hsym).eigenvalues γ γ = 0
      ↔ ∀ γ δ, XinvRec R (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
        (Mpair_isHermitian R hR hskew hsym).eigenvalues γ δ = 0 :=
  L154_record (fun s' c x hx => R_lin R hR s' c x hx) hskew
    (fun s' c x hx => absOp_lin R hR hskew hsym s' c x hx) (fun X _ => absOp_skew R hR hskew hsym X)
    (eigenFrame_exists R hR hskew hsym) (absOp_eigenFrame R hR hskew hsym)

/-- **L155's corollary, `J₅ = 0` on the graded class**: `J₅ = ⟨X_inv, H⟩` is linear in `X_inv`
(the record's `H = Ric^*(Ric |W|)`, [ATTEMPTS.md](../../../ATTEMPTS.md) Result 5(b)), so on the
graded class it vanishes **for every `H`, with no hypothesis on `h`**, read on the frame as
`∑_{γ,δ} X_{γδ} H_{γδ}`. -/
theorem J5_zero_of_graded
    (hg : HamiltonsCubic.L155Frame.Graded (Mpair_isHermitian R hR hskew hsym).eigenvalues
      (omegaF (frameVec R hR hskew hsym))) (H : Pairs n → Pairs n → ℝ) :
    ∑ γ, ∑ δ, XinvRec R (absOp R hR hskew hsym) (frameVec R hR hskew hsym)
      (Mpair_isHermitian R hR hskew hsym).eigenvalues γ δ * H γ δ = 0 := by
  have h0 := (L155_exists R hR hskew hsym).mpr hg
  simp [h0]

/-- **L155's properness clause**: at an eigenvalue `λ_γ = 0` the frame vector `v_γ` is a nonzero skew
matrix in `ker W` lying outside `𝔭 ⊕ 𝔪 = span{v_α : λ_α ≠ 0}`, so the graded pair is proper in
`𝔰𝔬(n)` whenever `𝔨 = ker W ≠ 0`. -/
theorem L155_proper (γ : Pairs n) (h0 : (Mpair_isHermitian R hR hskew hsym).eigenvalues γ = 0) :
    IsSkew (frameVec R hR hskew hsym γ) ∧ R (frameVec R hR hskew hsym γ) = 0 ∧
      frameVec R hR hskew hsym γ ≠ 0 ∧
      frameVec R hR hskew hsym γ ∉ Submodule.span ℝ
        (frameVec R hR hskew hsym '' {α | (Mpair_isHermitian R hR hskew hsym).eigenvalues α ≠ 0}) := by
  have hγγ := frameVec_orth R hR hskew hsym γ γ
  simp only [if_true] at hγγ
  refine ⟨frameVec_skew R hR hskew hsym γ, by rw [frameVec_eigen R hR hskew hsym γ, h0, zero_smul], ?_, ?_⟩
  · intro h; rw [h] at hγγ; simp [inner2] at hγγ
  · intro hmem
    have key : ∀ X ∈ Submodule.span ℝ
        (frameVec R hR hskew hsym '' {α | (Mpair_isHermitian R hR hskew hsym).eigenvalues α ≠ 0}),
        inner2 X (frameVec R hR hskew hsym γ) = 0 := by
      intro X hX
      induction hX using Submodule.span_induction with
      | mem x hx =>
        obtain ⟨α, hα, rfl⟩ := hx
        rw [frameVec_orth]
        have : α ≠ γ := fun e => hα (e ▸ h0)
        simp [this]
      | zero => simp [inner2]
      | add x y _ _ hx hy =>
        simp only [inner2, Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add] at hx hy ⊢
        linarith
      | smul a x _ hx =>
        simp only [inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul] at hx ⊢
        rw [mul_left_comm, hx, mul_zero]
    have := key _ hmem
    rw [hγγ] at this
    exact one_ne_zero this

/-- **L155's properness from `ker W ≠ 0` itself**: a nonzero skew `x` with `W x = 0` forces a zero
eigenvalue in the frame, so `L155_proper` applies there. -/
theorem L155_proper_of_ker (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hx0 : x ≠ 0)
    (hRx : R x = 0) :
    ∃ γ, (Mpair_isHermitian R hR hskew hsym).eigenvalues γ = 0 ∧
      IsSkew (frameVec R hR hskew hsym γ) ∧ R (frameVec R hR hskew hsym γ) = 0 ∧
      frameVec R hR hskew hsym γ ≠ 0 ∧
      frameVec R hR hskew hsym γ ∉ Submodule.span ℝ
        (frameVec R hR hskew hsym '' {α | (Mpair_isHermitian R hR hskew hsym).eigenvalues α ≠ 0}) := by
  set v := frameVec R hR hskew hsym with hv
  set lam := (Mpair_isHermitian R hR hskew hsym).eigenvalues with hlam
  set c : Pairs n → ℝ := fun k => inner2 x (v k) with hc
  have hexp : x = ∑ k, c k • v k := frameVec_complete R hR hskew hsym x hx
  have hRexp : R x = ∑ k, (c k * lam k) • v k := by
    conv_lhs => rw [hexp]
    rw [R_lin R hR Finset.univ c v (fun k => frameVec_skew R hR hskew hsym k)]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [frameVec_eigen R hR hskew hsym k, smul_smul]
  have hcoef : ∀ γ, c γ * lam γ = 0 := by
    intro γ
    have h0 : inner2 (v γ) (R x) = 0 := by rw [hRx]; simp [inner2]
    rw [hRexp, inner2_sum_right] at h0
    have ho : ∀ k l, inner2 (v k) (v l) = if k = l then 1 else 0 := frameVec_orth R hR hskew hsym
    simp only [HamiltonsCubic.FamilyLayer.inner2_smul_right, ho, mul_ite, mul_one,
      mul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true] at h0
    exact h0
  have hex : ∃ γ, c γ ≠ 0 := by
    by_contra h
    push Not at h
    apply hx0
    rw [hexp]
    exact Finset.sum_eq_zero fun k _ => by rw [h k, zero_smul]
  obtain ⟨γ, hγ⟩ := hex
  have hl : lam γ = 0 := (mul_eq_zero.mp (hcoef γ)).resolve_left hγ
  exact ⟨γ, hl, L155_proper R hR hskew hsym γ hl⟩

end frame

/-- **L70's bound at every spectrum, with the eigenbasis supplied**: for a critical linear Weyl `W`,
a unit skew eigenvector `x` of `λ_min < 0`, and `λ_min ≤ μ ≤ λ_max`, `0 ≤ λ_max`, on the spectrum
`μ` of `M`, `θ ≤ λ_min + (n − 2) λ_max`. -/
theorem L70_bound_exists (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x)
    (hunit : inner2 x x = 1) (lmin lmax : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0)
    (hmax : 0 ≤ lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax) :
    θ ≤ lmin + ((n : ℝ) - 2) * lmax := by
  set e := Fintype.equivFin (Pairs n)
  set ψ : Fin (Fintype.card (Pairs n)) → Matrix (Fin n) (Fin n) ℝ :=
    fun k => frameVec W hW.1 hW.2.1 hW.2.2.1 (e.symm k)
  set μ : Fin (Fintype.card (Pairs n)) → ℝ :=
    fun k => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues (e.symm k)
  refine HamiltonsCubic.L70Weyl.L70_bound_eigenbasis W hW θ hc ψ
    (fun k => frameVec_skew W hW.1 hW.2.1 hW.2.2.1 _) (fun Y hY => ?_) μ
    (fun k => frameVec_eigen W hW.1 hW.2.1 hW.2.2.1 _) x hx hunit lmin lmax hxe hneg hmax
    (fun i => hlo _) (fun i => hhi _)
  conv_lhs => rw [frameVec_complete W hW.1 hW.2.1 hW.2.2.1 Y hY]
  rw [← e.symm.sum_comp]
  exact Finset.sum_congr rfl fun k _ => by rw [inner2_comm]

end HamiltonsCubic.EigenFrameExist
