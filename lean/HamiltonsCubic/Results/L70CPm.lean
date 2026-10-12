import HamiltonsCubic.Results.L70Compose

set_option linter.style.longLine false

/-!
# L70, `W_{ℂPᵐ}` cannot saturate at `m ≥ 3`

[findings/bounds.md](../../../findings/bounds.md), Lemma L70: saturation forces `dim E_max ≥ (n − 2)/2`, *"and
`W_{ℂPᵐ}` cannot saturate at `m ≥ 3`, since `dim E_max = 1` there against a required `m − 1`"*. The dimension theorem
is [L70Compose.lean](L70Compose.lean)'s `L70_saturation_dims`. This file builds `W_{ℂPᵐ}` at every `m` and proves
its top eigenvalue simple.

- `Jm`: the complex structure on `ℝ²ᵐ`, with `J² = −1`, `JJᵀ = 1`, `Jᵀ = −J` and `⟨J, J⟩ = m`;
- `WCPm`: `X ↦ −3/(2m−1) X + J X Jᵀ + (∑ J_{ij} X_{ij}) J`, the Weyl part of the Fubini–Study curvature, whose
  tensor is `−3/(2m−1)(δδ − δδ) + J_{ik}J_{jl} − J_{il}J_{jk} + 2J_{ij}J_{kl}`; `WCPm_isWeylOp`, linear, skew,
  self-adjoint, first Bianchi and Ricci-flat at every `m ≥ 1`;
- `WCPm_J`: `ω = J` has eigenvalue `−3/(2m−1) + 1 + 2m`, and `eigen_mul_J`: every eigenvector at an eigenvalue
  other than `−3/(2m−1) ± 1` is a multiple of `J`, conjugation by `J` separating the other two eigenspaces;
- `top_card_le_one`: in any eigenframe at most one vector carries the top eigenvalue;
- **`WCPm_not_saturated`**: at `m ≥ 3` and every critical value `θ`, `θ ≠ λ_min + (n − 2)λ_max`.

At `m = 2` the spectrum is `(4, −2, −2, 0, 0, 0)`, twice [Families.lean](../Base/Families.lean)'s `W_{ℂP²}`.
**The criticality of `W_{ℂPᵐ}` enters as the hypothesis `IsCritical`**, discharged in
[L70CPmCrit.lean](L70CPmCrit.lean)'s `WCPm_critical`.
-/

namespace HamiltonsCubic.L70CPm

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind

variable {m : ℕ}

/-- The partner of an index in the complex pairing `(0,1), (2,3), …`. -/
def partner (a : Fin (2 * m)) : Fin (2 * m) :=
  if h : a.val % 2 = 0 then ⟨a.val + 1, by omega⟩ else ⟨a.val - 1, by omega⟩

theorem partner_partner (a : Fin (2 * m)) : partner (partner a) = a := by
  unfold partner
  apply Fin.ext
  by_cases h : a.val % 2 = 0
  · rw [dif_pos h]; rw [dif_neg (by simp; omega)]; simp
  · rw [dif_neg h]; rw [dif_pos (by simp; omega)]; simp; omega

theorem partner_eq_iff (a b : Fin (2 * m)) : b = partner a ↔ a = partner b := by
  constructor
  · rintro rfl; exact (partner_partner a).symm
  · rintro rfl; exact (partner_partner b).symm

/-- The sign of `J` on the row of `a`. -/
def sg (a : Fin (2 * m)) : ℝ := if a.val % 2 = 0 then 1 else -1

theorem sg_partner (a : Fin (2 * m)) : sg (partner a) = -sg a := by
  unfold sg partner
  by_cases h : a.val % 2 = 0
  · rw [dif_pos h, if_pos h, if_neg (by simp; omega)]
  · rw [dif_neg h, if_neg h, if_pos (by simp; omega), neg_neg]

theorem sg_sq (a : Fin (2 * m)) : sg a * sg a = 1 := by unfold sg; split_ifs <;> norm_num

/-- **The complex structure** `J e_{2k} = …`, one `±1` per row, at the partner column. -/
def Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ := Matrix.of fun a b => if b = partner a then sg a else 0

theorem Jm_apply (a b : Fin (2 * m)) : Jm a b = if b = partner a then sg a else 0 := rfl

theorem Jm_skew : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ)ᵀ = -Jm := by
  ext a b
  rw [transpose_apply, Matrix.neg_apply, Jm_apply, Jm_apply]
  by_cases h : b = partner a
  · have h' : a = partner b := (partner_eq_iff a b).mp h
    rw [if_pos h', if_pos h, h', sg_partner, neg_neg]
  · have h' : ¬ a = partner b := fun h' => h ((partner_eq_iff a b).mpr h')
    rw [if_neg h', if_neg h, neg_zero]

theorem Jm_mul_self : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) * Jm = -1 := by
  ext a b
  simp only [mul_apply, Jm_apply, ite_mul, zero_mul, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  rw [partner_partner]
  by_cases h : b = a
  · subst h; rw [if_pos rfl, Matrix.neg_apply, Matrix.one_apply_eq, sg_partner, mul_neg, sg_sq]
  · rw [if_neg h, Matrix.neg_apply, Matrix.one_apply_ne (Ne.symm h), mul_zero, neg_zero]

theorem Jm_mul_transpose : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) * Jmᵀ = 1 := by
  rw [Jm_skew, Matrix.mul_neg, Jm_mul_self, neg_neg]

theorem Jm_transpose_mul : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ)ᵀ * Jm = 1 := by
  rw [Jm_skew, Matrix.neg_mul, Jm_mul_self, neg_neg]

/-- The Frobenius pairing `∑ A_{ij} B_{ij}`. -/
def frob {ι : Type*} [Fintype ι] (A B : Matrix ι ι ℝ) : ℝ := ∑ i, ∑ j, A i j * B i j

theorem frob_J_J : frob (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) Jm = 2 * m := by
  unfold frob
  simp only [Jm_apply, ite_mul, zero_mul, mul_ite, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true, sg_sq]
  simp

theorem Jm_skew_apply (a b : Fin (2 * m)) : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) b a = -Jm a b := by
  have h := congrFun (congrFun (Jm_skew (m := m)) a) b
  simpa [transpose_apply] using h

theorem Jm_diag (a : Fin (2 * m)) : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) a a = 0 := by
  have h := Jm_skew_apply a a; linarith

/-- The identity coefficient `−3/(2m − 1)`. -/
noncomputable def cA (m : ℕ) : ℝ := -3 / (2 * (m : ℝ) - 1)

/-- **`W_{ℂPᵐ}` on `Λ²ℝ²ᵐ`**: `X ↦ −3/(2m−1) X + J X Jᵀ + (∑ J_{ij} X_{ij}) J`, the Weyl part of the Fubini–Study curvature. -/
noncomputable def WCPm (X : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ :=
  cA m • X + Jm * X * Jmᵀ + frob Jm X • Jm

/-- Conjugation by `J`. -/
def conj (X : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ := Jm * X * Jmᵀ

theorem conj_conj (X : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) : conj (conj X) = X := by
  unfold conj
  have h : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ)ᵀ * Jmᵀ = -1 := by
    rw [← Matrix.transpose_mul, Jm_mul_self, Matrix.transpose_neg, Matrix.transpose_one]
  calc Jm * (Jm * X * Jmᵀ) * Jmᵀ = (Jm * Jm) * X * (Jmᵀ * Jmᵀ) := by simp only [Matrix.mul_assoc]
    _ = X := by rw [Jm_mul_self, h]; simp

theorem conj_J : conj (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) = Jm := by
  unfold conj; rw [Matrix.mul_assoc, Jm_mul_transpose, Matrix.mul_one]

/-- **`ω = J` is an eigenvector**, with eigenvalue `cA + 1 + 2m`. -/
theorem WCPm_J : WCPm (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) = (cA m + 1 + 2 * m) • Jm := by
  unfold WCPm
  have h := conj_J (m := m); unfold conj at h
  rw [h, frob_J_J, add_smul, add_smul, one_smul]

/-- **Every eigenvector at an eigenvalue other than `cA ± 1` is a multiple of `J`.** -/
theorem eigen_mul_J (X : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) (lam : ℝ) (hX : WCPm X = lam • X)
    (h1 : lam ≠ cA m + 1) (h2 : lam ≠ cA m - 1) : ∃ c : ℝ, X = c • Jm := by
  have E2 := congrArg conj hX
  have hc : ∀ (s : ℝ) (Y : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ), conj (s • Y) = s • conj Y := by
    intro s Y; unfold conj; simp [Matrix.smul_mul, Matrix.mul_smul]
  have ha : ∀ (Y Z : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ), conj (Y + Z) = conj Y + conj Z := by
    intro Y Z; unfold conj; simp [Matrix.mul_add, Matrix.add_mul]
  unfold WCPm at hX E2
  have hX' : cA m • X + conj X + frob Jm X • Jm = lam • X := hX
  rw [show Jm * X * Jmᵀ = conj X from rfl, ha, ha, hc, hc, hc, conj_conj, conj_J] at E2
  have hne1 : lam - cA m + 1 ≠ 0 := fun h => h2 (by linarith)
  have hne2 : lam - cA m - 1 ≠ 0 := fun h => h1 (by linarith)
  refine ⟨frob Jm X / (lam - cA m - 1), ?_⟩
  ext i j
  have e1 := congrFun (congrFun hX' i) j
  have e2 := congrFun (congrFun E2 i) j
  simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] at e1 e2 ⊢
  have hxx : X i j = conj X i j := by
    have : (lam - cA m + 1) * (X i j - conj X i j) = 0 := by linear_combination e2 - e1
    rcases mul_eq_zero.mp this with h | h
    · exact absurd h hne1
    · linarith
  rw [div_mul_eq_mul_div, eq_div_iff hne2]
  linear_combination (-1 : ℝ) * e1 - hxx

/-! ## `W_{ℂPᵐ}` is a linear Weyl operator -/

theorem phi_apply (i j k l : Fin (2 * m)) :
    phi i j k l = (if j = k ∧ i = l then (1 : ℝ) else 0) - (if i = k ∧ j = l then 1 else 0) := by
  simp [phi, Matrix.sub_apply, Matrix.single_apply]

theorem conj_phi_apply (i j k l : Fin (2 * m)) :
    conj (phi i j) k l = Jm k j * Jm l i - Jm k i * Jm l j := by
  unfold conj
  simp only [Matrix.mul_apply, transpose_apply, phi_apply, mul_sub, sub_mul, mul_ite, mul_one, mul_zero,
    ite_mul, zero_mul, Finset.sum_sub_distrib, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.sum_ite_irrel]

theorem frob_phi (i j : Fin (2 * m)) : frob Jm (phi i j) = -2 * Jm i j := by
  unfold frob
  simp only [phi_apply, mul_sub, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.sum_ite_irrel, Jm_skew_apply i j]
  ring

theorem WCPm_phi_apply (i j k l : Fin (2 * m)) :
    WCPm (phi i j) k l = cA m * phi i j k l + (Jm k j * Jm l i - Jm k i * Jm l j) - 2 * Jm i j * Jm k l := by
  have h := conj_phi_apply i j k l
  unfold conj at h
  simp only [WCPm, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, h, frob_phi]
  ring

theorem frob_add (A B C : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) : frob A (B + C) = frob A B + frob A C := by
  simp [frob, mul_add, Finset.sum_add_distrib]

theorem frob_smul (A B : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) (c : ℝ) : frob A (c • B) = c * frob A B := by
  simp only [frob, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring

theorem WCPm_isLinOp : IsLinOp (WCPm (m := m)) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · unfold WCPm; rw [frob_add, add_smul, smul_add, Matrix.mul_add, Matrix.add_mul]; abel
  · unfold WCPm; rw [frob_smul, mul_smul, smul_add, smul_add, Matrix.mul_smul, Matrix.smul_mul, smul_comm (cA m) c X]

theorem WCPm_skew (X : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) (hX : IsSkew X) : IsSkew (WCPm X) := by
  unfold IsSkew at hX ⊢
  unfold WCPm
  have h1 : (Jm * X * Jmᵀ)ᵀ = -(Jm * X * Jmᵀ) := by
    rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hX]
    simp [Matrix.mul_assoc]
  have h2 : (frob Jm X • Jm)ᵀ = -(frob Jm X • (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ)) := by
    rw [Matrix.transpose_smul, Jm_skew, smul_neg]
  rw [Matrix.transpose_add, Matrix.transpose_add, h1, h2, Matrix.transpose_smul, hX, smul_neg]
  abel

theorem frob_eq_trace (A B : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) : frob A B = (Aᵀ * B).trace := by
  simp only [frob, Matrix.trace, Matrix.diag, Matrix.mul_apply, transpose_apply]
  exact Finset.sum_comm

theorem frob_conj (X Y : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) : frob (conj X) Y = frob X (conj Y) := by
  rw [frob_eq_trace, frob_eq_trace]
  unfold conj
  have hJ : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ)ᵀ * Y * Jm = Jm * Y * Jmᵀ := by
    rw [Jm_skew]; simp [Matrix.neg_mul, Matrix.mul_neg]
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose]
  calc (Jm * (Xᵀ * Jmᵀ) * Y).trace = (Xᵀ * (Jmᵀ * Y * Jm)).trace := by
        rw [Matrix.mul_assoc, Matrix.trace_mul_comm, Matrix.mul_assoc, Matrix.mul_assoc, Matrix.mul_assoc]
    _ = (Xᵀ * (Jm * Y * Jmᵀ)).trace := by rw [hJ]

theorem inner2_eq_frob (A B : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) : inner2 A B = (1 / 2) * frob A B := by
  rw [inner2, frob_eq_trace]

theorem WCPm_selfAdjoint (X Y : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) :
    inner2 (WCPm X) Y = inner2 X (WCPm Y) := by
  simp only [inner2_eq_frob]
  unfold WCPm
  rw [show frob X (cA m • Y + Jm * Y * Jmᵀ + frob Jm Y • Jm)
      = cA m * frob X Y + frob X (conj Y) + frob Jm Y * frob X Jm by
    rw [frob_add, frob_add, frob_smul, frob_smul]; rfl]
  have hc : ∀ (A B : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ), frob A B = frob B A := fun A B => by
    unfold frob; exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => mul_comm _ _
  rw [hc (cA m • X + Jm * X * Jmᵀ + frob Jm X • Jm) Y, frob_add, frob_add, frob_smul, frob_smul]
  rw [show frob Y (Jm * X * Jmᵀ) = frob Y (conj X) from rfl, ← frob_conj, hc (conj Y) X, hc Y Jm, hc Y X, hc X Jm]
  ring

theorem WCPm_R4 (i j k l : Fin (2 * m)) :
    inner2 (WCPm (phi i j)) (phi k l) = -WCPm (phi i j) k l :=
  inner2_phi _ (WCPm_skew _ (phi_isSkew i j)) k l

theorem WCPm_bianchi (i j k l : Fin (2 * m)) : bianchi (WCPm (m := m)) i j k l = 0 := by
  unfold bianchi
  rw [WCPm_R4, WCPm_R4, WCPm_R4, WCPm_phi_apply, WCPm_phi_apply, WCPm_phi_apply, phi_apply, phi_apply, phi_apply]
  rw [Jm_skew_apply j k, Jm_skew_apply i l, Jm_skew_apply i k, Jm_skew_apply j l, Jm_skew_apply k l,
    Jm_skew_apply i j]
  have hd : ((if j = k ∧ i = l then (1 : ℝ) else 0) - (if i = k ∧ j = l then 1 else 0))
      + ((if k = l ∧ i = j then (1 : ℝ) else 0) - (if i = l ∧ k = j then 1 else 0))
      + ((if l = j ∧ i = k then (1 : ℝ) else 0) - (if i = j ∧ l = k then 1 else 0)) = 0 := by
    by_cases h1 : j = k <;> by_cases h2 : i = l <;> by_cases h3 : i = k <;> by_cases h4 : j = l <;>
      by_cases h5 : k = l <;> by_cases h6 : i = j <;> simp_all [eq_comm]
  linear_combination (-cA m) * hd

theorem WCPm_ric (hm : 1 ≤ m) (a b : Fin (2 * m)) : Ric (WCPm (m := m)) a b = 0 := by
  unfold Ric
  simp only [WCPm_R4, WCPm_phi_apply, phi_apply, Jm_diag, mul_zero, sub_zero]
  have hJJ : ∑ c : Fin (2 * m), Jm a c * Jm b c = if a = b then 1 else 0 := by
    have h := congrFun (congrFun (Jm_mul_transpose (m := m)) a) b
    simpa [Matrix.mul_apply, transpose_apply, Matrix.one_apply] using h
  have hsk : ∀ c : Fin (2 * m), Jm b c * Jm c a = -(Jm a c * Jm b c) := fun c => by
    rw [Jm_skew_apply a c]; ring
  simp only [hsk]
  have e : ∀ x : Fin (2 * m), -(cA m * ((if x = b ∧ a = x then (1 : ℝ) else 0) - if a = b ∧ True then 1 else 0)
      + -(Jm a x * Jm b x) - 2 * Jm a x * Jm b x)
      = -cA m * (if x = b ∧ a = x then 1 else 0) + cA m * (if a = b then 1 else 0) + 3 * (Jm a x * Jm b x) := by
    intro x; simp only [and_true]; ring
  rw [Finset.sum_congr rfl fun x _ => e x, Finset.sum_add_distrib, Finset.sum_add_distrib, ← Finset.mul_sum,
    ← Finset.mul_sum, ← Finset.mul_sum, hJJ]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  have hs : ∑ x : Fin (2 * m), (if x = b ∧ a = x then (1 : ℝ) else 0) = if a = b then 1 else 0 := by
    by_cases h : a = b
    · subst h
      rw [if_pos rfl, Finset.sum_eq_single a (fun x _ hx => if_neg fun h' => hx h'.1) (by simp)]
      simp
    · rw [if_neg h]
      exact Finset.sum_eq_zero fun x _ => if_neg fun hx => h (hx.2.trans hx.1)
  rw [hs]
  have h2m : (2 * (m : ℝ) - 1) ≠ 0 := by
    have : (1 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  split_ifs
  · simp only [cA]; push_cast; field_simp; ring
  · ring

/-- **`W_{ℂPᵐ}` is a linear Weyl operator** at every `m ≥ 1`. -/
theorem WCPm_isWeylOp (hm : 1 ≤ m) : IsWeylOp (WCPm (m := m)) :=
  ⟨WCPm_isLinOp, WCPm_skew, fun X Y _ _ => WCPm_selfAdjoint X Y, WCPm_bianchi, WCPm_ric hm⟩

/-! ## The top eigenvalue is simple -/

theorem inner2_J_J : inner2 (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) Jm = m := by
  rw [inner2_eq_frob, frob_J_J]; ring

/-- **In any eigenframe of `W_{ℂPᵐ}`, at most one frame vector carries the top eigenvalue**: every frame vector at
an upper bound `lmax` of the spectrum is a multiple of `J`, and two orthonormal multiples of `J` do not exist. -/
theorem top_card_le_one (hm : 1 ≤ m) {Γ : Type*} [Fintype Γ] [DecidableEq Γ]
    {v : Γ → Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ} {lam : Γ → ℝ} (hf : EigenFrame (WCPm (m := m)) v lam)
    (lmax : ℝ) (hhi : ∀ γ, lam γ ≤ lmax) : (univ.filter fun γ => lam γ = lmax).card ≤ 1 := by
  have hmR : (1 : ℝ) ≤ m := by exact_mod_cast hm
  have hJskew : IsSkew (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) := Jm_skew
  -- the eigenvalue of `J` sits at or below `lmax`
  have hω : cA m + 1 + 2 * m ≤ lmax := by
    have hcoef : ∀ γ, (cA m + 1 + 2 * m - lam γ) * inner2 Jm (v γ) = 0 := by
      intro γ
      have h1 : inner2 (WCPm Jm) (v γ) = inner2 Jm (WCPm (v γ)) := WCPm_selfAdjoint _ _
      rw [WCPm_J, hf.eigen γ, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right] at h1
      linarith
    by_contra hlt
    push Not at hlt
    have hzero : ∀ γ, inner2 Jm (v γ) = 0 := fun γ => by
      rcases mul_eq_zero.mp (hcoef γ) with h | h
      · have := hhi γ; linarith
      · exact h
    have hJ0 : (Jm : Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ) = 0 := by
      rw [hf.complete Jm hJskew]; simp [hzero]
    have := inner2_J_J (m := m)
    rw [hJ0] at this
    simp [inner2] at this
    linarith
  -- a frame vector at `lmax` is a multiple of `J`
  have hmul : ∀ γ, lam γ = lmax → ∃ c : ℝ, v γ = c • Jm := fun γ hγ =>
    eigen_mul_J (v γ) (lam γ) (hf.eigen γ) (by linarith) (by linarith)
  rw [Finset.card_le_one]
  intro γ hγ δ hδ
  simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hγ hδ
  by_contra hne
  obtain ⟨c, hc⟩ := hmul γ hγ
  obtain ⟨d, hd⟩ := hmul δ hδ
  have h1 := hf.orthonormal γ γ
  have h2 := hf.orthonormal δ δ
  have h3 := hf.orthonormal γ δ
  rw [if_pos rfl, hc, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right, inner2_J_J] at h1
  rw [if_pos rfl, hd, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right, inner2_J_J] at h2
  rw [if_neg hne, hc, hd, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right, inner2_J_J] at h3
  have : c * c * (d * d) * (m * m) = 1 := by rw [show c * c * (d * d) * (m * m) = (c * (c * m)) * (d * (d * m)) by ring, h1, h2]; ring
  have h0 : c * c * (d * d) * (m * m) = 0 := by
    rw [show c * c * (d * d) * (m * m) = (c * (d * m)) * (c * (d * m)) by ring, h3]; ring
  linarith

/-- **`W_{ℂPᵐ}` DOES NOT SATURATE L70 AT `m ≥ 3`**: at any critical value `θ`, with `lmin < 0 < lmax` bracketing
the `Λ²` spectrum and `lmin` attained, `θ ≠ lmin + (n − 2) lmax`. Saturation would force at least `m − 1` top
eigenvalues (`L70_saturation_dims`) where `W_{ℂPᵐ}` has one. -/
theorem WCPm_not_saturated (hm : 3 ≤ m) (θ : ℝ) (hc : IsCritical (WCPm (m := m)) θ)
    (γ₀ : Pairs (2 * m)) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian (WCPm (m := m)) (WCPm_isWeylOp (by omega)).1 (WCPm_isWeylOp (by omega)).2.1
      (WCPm_isWeylOp (by omega)).2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian (WCPm (m := m)) (WCPm_isWeylOp (by omega)).1 (WCPm_isWeylOp (by omega)).2.1
      (WCPm_isWeylOp (by omega)).2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian (WCPm (m := m)) (WCPm_isWeylOp (by omega)).1 (WCPm_isWeylOp (by omega)).2.1
      (WCPm_isWeylOp (by omega)).2.2.1).eigenvalues j ≤ lmax) :
    θ ≠ lmin + (((2 * m : ℕ) : ℝ) - 2) * lmax := by
  intro hsat
  have hW := WCPm_isWeylOp (m := m) (by omega)
  have hd := (L70_saturation_dims (WCPm (m := m)) hW θ hc γ₀ lmin lmax hγ hneg hpos hlo hhi hsat).1
  have hcard := top_card_le_one (m := m) (by omega) (eigenFrame_exists (WCPm (m := m)) hW.1 hW.2.1 hW.2.2.1) lmax hhi
  have hcR : ((univ.filter fun a => (Mpair_isHermitian (WCPm (m := m)) hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmax).card : ℝ) ≤ 1 := by
    exact_mod_cast hcard
  have hmR : (3 : ℝ) ≤ m := by exact_mod_cast hm
  push_cast at hd
  linarith

end HamiltonsCubic.L70CPm
