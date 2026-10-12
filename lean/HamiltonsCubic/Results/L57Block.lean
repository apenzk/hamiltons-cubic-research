import Mathlib
import HamiltonsCubic.Results.L226Statement
import HamiltonsCubic.Results.L57Diagonal
import HamiltonsCubic.Results.L234Split
import HamiltonsCubic.Results.L24Eigen
import HamiltonsCubic.Results.L57Odd

set_option linter.style.longLine false

/-!
# L57 on the block family: a coordinate-diagonal block operator obeys `P ≤ Θₙ ‖W‖³`

[L226Statement.lean](L226Statement.lean)'s `blockOp S M K` is the block operator on `𝒮_J`, `J = Fin 3`, outer set
`Fin m`. L227 and L228 owe *"the rotation to a coordinate-diagonal tensor, and L57"*: once `S` and every `M_a`
are diagonal, the operator is the diagonal tensor of a weight, and [L57Diagonal.lean](L57Diagonal.lean)'s
`L57_diagonal` bounds it. This file:

* `wOf`: the weight, `S_cc` on the pair `{p, q}` of `J` with complement `c`, `(M_a)_pp` on `{p, a}` and `K_ab` on
  `{a, b}`;
* `eps_diag`, `blockCoeff_diag`: at diagonal `S`, `M_a` and hollow `K`, `W_{ij,kl} = w_ij (δ_ik δ_jl - δ_il δ_jk)`;
* `sum_kl`, `weight_phi_entry`, `blockOp_diag_eq`: so `blockOp S M K = diagOp w` on `Λ²`;
* `wOf_isWeight`: Ricci-flatness (`Ric_blockOp_J`, `Ric_blockOp_outer`) makes `w` a weight, the `J`-row through
  `eps_sq_row`;
* `Pcubic_eq_restrictLin`, `normSq_eq_restrictLin`: `P` and `‖·‖²` of a linear bivector-preserving operator are those
  of its restriction to `Λ²`, so operators agreeing on `Λ²` share them;
* `L57_block_of`: any bound `c` on the diagonal tensors of weights on `Fin 3 ⊕ Fin m` holds on every Ricci-flat
  block operator with diagonal `S` and `M_a`;
* `diag_bound`, `diag_bound_odd`, `L57_block`, `L57_block_odd`: so `P(W) ≤ θ₀(n) ‖W‖³`, `n = m + 3 ≥ 4`,
  through `L57_diagonal` (the record's `Θₙ` at even `n`), and `P(W) ≤ Θₙ ‖W‖³` with the odd constant
  `Θₙ² = 2(n-1)(n-3)/((n+1)(n-2))` at odd `n ≥ 5` through `L57_diagonal_odd`.

The rotation of a simultaneously diagonalisable block operator to this form is a separate step.
-/

namespace HamiltonsCubic.L57Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement

variable {m : ℕ}

/-- The weight of a block operator with diagonal blocks. -/
noncomputable def wOf (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ) :
    Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ
  | .inl p, .inl q => ∑ x, eps p q x ^ 2 * S x x
  | .inl p, .inr a => M a p p
  | .inr a, .inl p => M a p p
  | .inr a, .inr b => K a b

/-- The contraction of `ε` weighted by a diagonal. -/
theorem eps_diag (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : ∀ x y, x ≠ y → S x y = 0) (p q r s : Fin 3) :
    ∑ x, ∑ y, eps p q x * eps r s y * S x y
      = (∑ x, eps p q x ^ 2 * S x x) * ((if p = r ∧ q = s then 1 else 0) - (if p = s ∧ q = r then 1 else 0)) := by
  have h01 := hS 0 1 (by decide)
  have h02 := hS 0 2 (by decide)
  have h10 := hS 1 0 (by decide)
  have h12 := hS 1 2 (by decide)
  have h20 := hS 2 0 (by decide)
  have h21 := hS 2 1 (by decide)
  fin_cases p <;> fin_cases q <;> fin_cases r <;> fin_cases s <;>
    simp [eps, Matrix.det_fin_three, Pi.single_apply, h01, h02, h10, h12, h20, h21]

/-- **The coefficients of a diagonal block operator**: `W_{ij,kl} = w_ij (δ_ik δ_jl - δ_il δ_jk)`. -/
theorem blockCoeff_diag (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : ∀ x y, x ≠ y → S x y = 0)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a x y, x ≠ y → M a x y = 0)
    (K : Fin m → Fin m → ℝ) (hK0 : ∀ a, K a a = 0) (i j k l : Fin 3 ⊕ Fin m) :
    blockCoeff S M K i j k l
      = wOf S M K i j * ((if i = k ∧ j = l then 1 else 0) - (if i = l ∧ j = k then 1 else 0)) := by
  rcases i with p | a <;> rcases j with q | b <;> rcases k with r | c <;> rcases l with s | d <;>
    simp only [blockCoeff, wOf, Sum.inl.injEq, Sum.inr.injEq, reduceCtorEq, false_and, and_false, if_false,
      sub_zero, zero_sub, mul_zero]
  · exact eps_diag S hS p q r s
  · by_cases hbd : b = d
    · subst hbd
      by_cases hpr : p = r
      · subst hpr; simp
      · simp [hpr, hM b p r hpr]
    · simp [hbd]
  · by_cases hbc : b = c
    · subst hbc
      by_cases hps : p = s
      · subst hps; simp
      · simp [hps, hM b p s hps]
    · simp [hbc]
  · by_cases had : a = d
    · subst had
      by_cases hqr : q = r
      · subst hqr; simp
      · simp [hqr, hM a q r hqr]
    · simp [had]
  · by_cases hac : a = c
    · subst hac
      by_cases hqs : q = s
      · subst hqs; simp
      · simp [hqs, hM a q s hqs]
    · simp [hac]
  · clear hS hM
    by_cases hab : a = b
    · subst hab; simp [hK0]
    · by_cases hac : a = c <;> by_cases hbd : b = d <;> by_cases had : a = d <;> by_cases hbc : b = c <;>
        simp_all

section Collapse
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The `(k, l)` sum collapses to the pair itself**, `φ_ji = -φ_ij`. -/
theorem sum_kl (i j : ι) (c : ℝ) :
    ∑ k, ∑ l, (c * ((if i = k ∧ j = l then (1 : ℝ) else 0) - (if i = l ∧ j = k then 1 else 0))) • phi k l
      = (2 * c) • phi i j := by
  have hterm : ∀ k l, (c * ((if i = k ∧ j = l then (1 : ℝ) else 0) - (if i = l ∧ j = k then 1 else 0))) • phi k l
      = (if i = k ∧ j = l then c else 0) • phi k l - (if i = l ∧ j = k then c else 0) • phi k l := by
    intro k l; split_ifs <;> simp
  have h1 : ∑ k, ∑ l, (if i = k ∧ j = l then c else 0) • phi k l = c • phi i j := by
    rw [Finset.sum_eq_single i (fun k _ hk => Finset.sum_eq_zero fun l _ => by simp [Ne.symm hk]) (by simp)]
    rw [Finset.sum_eq_single j (fun l _ hl => by simp [Ne.symm hl]) (by simp)]
    simp
  have h2 : ∑ k, ∑ l, (if i = l ∧ j = k then c else 0) • phi k l = c • phi j i := by
    rw [Finset.sum_eq_single j (fun k _ hk => Finset.sum_eq_zero fun l _ => by simp [Ne.symm hk]) (by simp)]
    rw [Finset.sum_eq_single i (fun l _ hl => by simp [Ne.symm hl]) (by simp)]
    simp
  simp only [hterm, Finset.sum_sub_distrib, h1, h2]
  rw [phi_swap]
  module

end Collapse

theorem wOf_symm (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ)
    (hK : ∀ a b, K a b = K b a) (i j : Fin 3 ⊕ Fin m) : wOf S M K i j = wOf S M K j i := by
  rcases i with p | a <;> rcases j with q | b <;> simp only [wOf]
  · refine Finset.sum_congr rfl fun x _ => ?_
    rw [eps_swap12 q p x]; ring
  · exact hK a b

/-- `w_ij φ_ij(a, b) = w_ab φ_ij(a, b)` at a symmetric weight: `φ_ij` lives on the pair `{i, j}`. -/
theorem weight_phi_entry {ι : Type*} [Fintype ι] [DecidableEq ι] (w : Matrix ι ι ℝ) (hw : ∀ i j, w i j = w j i)
    (i j a b : ι) : w i j * phi i j a b = w a b * phi i j a b := by
  simp only [phi, Matrix.sub_apply, Matrix.single_apply]
  by_cases h1 : j = a ∧ i = b
  · obtain ⟨rfl, rfl⟩ := h1; rw [hw]
  · by_cases h2 : i = a ∧ j = b
    · obtain ⟨rfl, rfl⟩ := h2; rfl
    · simp [h1, h2]

/-- **A diagonal block operator is the diagonal tensor of `wOf` on `Λ²`.** -/
theorem blockOp_diag_eq (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : ∀ x y, x ≠ y → S x y = 0)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a x y, x ≠ y → M a x y = 0)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (X : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) (hX : IsSkew X) :
    blockOp S M K X = HamiltonsCubic.FamilyLayer.diagOp (wOf S M K) X := by
  have hw := wOf_symm S M K hK
  have hL : blockOp S M K X = (1 / 2 : ℝ) • ∑ i, ∑ j, (inner2 X (phi i j) * wOf S M K i j) • phi i j := by
    rw [blockOp_eq_opOf]
    unfold opOf
    simp only [blockCoeff_diag S hS M hM K hK0, ← mul_assoc, sum_kl, Finset.smul_sum, smul_smul]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    congr 1; ring
  rw [hL]
  ext a b
  have hXab := congrFun (congrFun (skew_expand X hX) a) b
  simp only [Matrix.smul_apply, Matrix.sum_apply, smul_eq_mul] at hXab ⊢
  simp only [HamiltonsCubic.FamilyLayer.diagOp, Matrix.of_apply]
  have hterm : ∀ x y, inner2 X (phi x y) * wOf S M K x y * phi x y a b
      = wOf S M K a b * (inner2 X (phi x y) * phi x y a b) := fun x y => by
    linear_combination inner2 X (phi x y) * weight_phi_entry (wOf S M K) hw x y a b
  rw [← hXab]
  simp only [hterm, ← Finset.mul_sum]
  ring

section Bridge
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
open HamiltonsCubic.TensorBridge

/-- `P` of a linear bivector-preserving operator is `P` of its restriction to `Λ²`. -/
theorem Pcubic_eq_restrictLin {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hl : IsLinOp R) (hs : ∀ X, IsSkew X → IsSkew (R X)) :
    Pcubic R = Pcubic2 (restrictLin hl hs) := by
  rw [Pcubic2_eq_innerOp2, innerOp2_comm, ← foxProd2_self]
  have h := foxTri_eq_foxTri2_restrictLin hl hs hl hs hl hs
  rw [foxTri_self _ hl] at h
  rw [h]; rfl

/-- And its squared norm. -/
theorem normSq_eq_restrictLin {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hl : IsLinOp R) (hs : ∀ X, IsSkew X → IsSkew (R X)) :
    normSq R = normSq2 (restrictLin hl hs) := by
  rw [← normSq_extend]
  unfold normSq innerOp
  refine congrArg (fun x => (1 / 2 : ℝ) * x) ?_
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [extend_restrictLin_on_skew _ _ _ (phi_isSkew i j)]

end Bridge

theorem blockOp_isLinOp (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ) :
    IsLinOp (blockOp S M K) :=
  ⟨fun X Y => opOf_add _ X Y, fun c X => opOf_smul _ c X⟩

/-- The `J`-row of the weight: `∑_q ∑_x ε_pqx² S_xx = tr S - S_pp`. -/
theorem eps_sq_row (S : Matrix (Fin 3) (Fin 3) ℝ) (p : Fin 3) :
    ∑ q, ∑ x, eps p q x ^ 2 * S x x = S.trace - S p p := by
  fin_cases p <;> simp [Fin.sum_univ_three, eps, Matrix.det_fin_three, Pi.single_apply, Matrix.trace_fin_three] <;> ring

theorem isSymm_of_diag (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : ∀ x y, x ≠ y → S x y = 0) : S.IsSymm := by
  ext x y
  by_cases h : x = y
  · subst h; rfl
  · rw [Matrix.transpose_apply, hS y x (Ne.symm h), hS x y h]

/-- **Ricci-flatness makes `wOf` a weight.** -/
theorem wOf_isWeight (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : ∀ x y, x ≠ y → S x y = 0)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a x y, x ≠ y → M a x y = 0)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    HamiltonsCubic.FamilyLayer.IsWeight (wOf S M K) where
  symm := wOf_symm S M K hK
  hollow := by
    intro i
    rcases i with p | a
    · simp only [wOf]
      refine Finset.sum_eq_zero fun x _ => ?_
      have h := eps_swap12 p p x
      have : eps p p x = 0 := by linarith
      rw [this]; ring
    · exact hK0 a
  rowSum := by
    intro i
    rcases i with p | a
    · have h := hRic (.inl p) (.inl p)
      rw [Ric_blockOp_J S (isSymm_of_diag S hS) M (fun a => isSymm_of_diag (M a) (hM a)) K p p] at h
      rw [Fintype.sum_sum_type]
      simp only [wOf]
      rw [eps_sq_row]
      simp only [Matrix.sub_apply, Matrix.smul_apply, Matrix.one_apply_eq, smul_eq_mul, mul_one] at h
      linarith
    · have h := hRic (.inr a) (.inr a)
      rw [Ric_blockOp_outer S M K hK hK0 a] at h
      rw [Fintype.sum_sum_type]
      simp only [wOf]
      rw [Matrix.trace] at h
      simpa [Matrix.diag] using h

/-- **Any bound on the diagonal tensors transfers to the block family**: if every weight on `Fin 3 ⊕ Fin m` has
`P(diag w) ≤ c ‖diag w‖³`, so does every Ricci-flat block operator with diagonal `S` and `M_a`. -/
theorem L57_block_of (c : ℝ)
    (hc : ∀ w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ, HamiltonsCubic.FamilyLayer.IsWeight w →
      Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ≤ c * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3)
    (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : ∀ x y, x ≠ y → S x y = 0)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a x y, x ≠ y → M a x y = 0)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    Pcubic (blockOp S M K) ≤ c * HamiltonsCubic.RealLayer.norm (blockOp S M K) ^ 3 := by
  have hw := wOf_isWeight S hS M hM K hK hK0 hRic
  have hlB := blockOp_isLinOp S M K
  have hsB : ∀ X, IsSkew X → IsSkew (blockOp S M K X) := fun X _ => opOf_isSkew _ X
  have hlD := HamiltonsCubic.RealLayer.isLinOp_diagOp (wOf S M K)
  have hsD : ∀ X, IsSkew X → IsSkew (HamiltonsCubic.FamilyLayer.diagOp (wOf S M K) X) :=
    fun X hX => HamiltonsCubic.FamilyLayer.diagOp_skew _ hw.symm X hX
  have hEq : HamiltonsCubic.TensorBridge.restrictLin hlB hsB = HamiltonsCubic.TensorBridge.restrictLin hlD hsD :=
    ContinuousLinearMap.ext fun X => Subtype.ext (blockOp_diag_eq S hS M hM K hK hK0 X X.2)
  have hP : Pcubic (blockOp S M K) = Pcubic (HamiltonsCubic.FamilyLayer.diagOp (wOf S M K)) := by
    rw [Pcubic_eq_restrictLin hlB hsB, Pcubic_eq_restrictLin hlD hsD, hEq]
  have hN : HamiltonsCubic.RealLayer.norm (blockOp S M K)
      = HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp (wOf S M K)) := by
    unfold HamiltonsCubic.RealLayer.norm
    rw [normSq_eq_restrictLin hlB hsB, normSq_eq_restrictLin hlD hsD, hEq]
  rw [hP, hN]
  exact hc _ hw

theorem card_block : (Fintype.card (Fin 3 ⊕ Fin m) : ℝ) = (m : ℝ) + 3 := by
  rw [Fintype.card_sum, Fintype.card_fin, Fintype.card_fin]; push_cast; ring

/-- L57's bound `θ₀(n) = √(2(n-1)(n-2))/n` on the diagonal tensors of `Fin 3 ⊕ Fin m`, `n = m + 3 ≥ 4`; it is the
record's `Θₙ` at even `n`. -/
theorem diag_bound (hm : 1 ≤ m) (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ)
    (hw : HamiltonsCubic.FamilyLayer.IsWeight w) :
    Pcubic (HamiltonsCubic.FamilyLayer.diagOp w)
      ≤ Real.sqrt (2 * (((m : ℝ) + 3) - 1) * (((m : ℝ) + 3) - 2)) / ((m : ℝ) + 3)
        * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3 := by
  have h4 : 4 ≤ Fintype.card (Fin 3 ⊕ Fin m) := by
    rw [Fintype.card_sum, Fintype.card_fin, Fintype.card_fin]; omega
  have hL := HamiltonsCubic.L57Critical.L57_diagonal h4 w hw
  rw [card_block] at hL
  exact hL

/-- L57's odd constant `Θₙ = √(2(n-1)(n-3)/((n+1)(n-2)))` on the diagonal tensors, at odd `n = m + 3 ≥ 5`. -/
theorem diag_bound_odd (hm : 2 ≤ m) (hodd : ¬ Even (m + 3)) (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ)
    (hw : HamiltonsCubic.FamilyLayer.IsWeight w) :
    Pcubic (HamiltonsCubic.FamilyLayer.diagOp w)
      ≤ Real.sqrt (HamiltonsCubic.L57Critical.thetaOddSq ((m : ℝ) + 3))
        * HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) ^ 3 := by
  have hcard : Fintype.card (Fin 3 ⊕ Fin m) = m + 3 := by
    rw [Fintype.card_sum, Fintype.card_fin, Fintype.card_fin]; ring
  have h5 : 5 ≤ Fintype.card (Fin 3 ⊕ Fin m) := by rw [hcard]; omega
  have hL := HamiltonsCubic.L57Critical.L57_diagonal_odd h5 (by rw [hcard]; exact hodd) w hw
  rw [card_block] at hL
  exact hL

/-- **L57 on the block family**: a Ricci-flat block operator with diagonal `S` and `M_a` satisfies
`P(W) ≤ θ₀(n) ‖W‖³`, `n = m + 3 ≥ 4`, `θ₀(n) = √(2(n-1)(n-2))/n`, the record's `Θₙ` at even `n`. -/
theorem L57_block (hm : 1 ≤ m) (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : ∀ x y, x ≠ y → S x y = 0)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a x y, x ≠ y → M a x y = 0)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    Pcubic (blockOp S M K)
      ≤ Real.sqrt (2 * (((m : ℝ) + 3) - 1) * (((m : ℝ) + 3) - 2)) / ((m : ℝ) + 3) * norm (blockOp S M K) ^ 3 :=
  L57_block_of _ (diag_bound hm) S hS M hM K hK hK0 hRic

/-- **At odd `n`**, the record's odd constant `Θₙ² = 2(n-1)(n-3)/((n+1)(n-2))`. -/
theorem L57_block_odd (hm : 2 ≤ m) (hodd : ¬ Even (m + 3)) (S : Matrix (Fin 3) (Fin 3) ℝ)
    (hS : ∀ x y, x ≠ y → S x y = 0)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a x y, x ≠ y → M a x y = 0)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0)
    (hRic : ∀ i j, Ric (blockOp S M K) i j = 0) :
    Pcubic (blockOp S M K)
      ≤ Real.sqrt (HamiltonsCubic.L57Critical.thetaOddSq ((m : ℝ) + 3)) * norm (blockOp S M K) ^ 3 :=
  L57_block_of _ (diag_bound_odd hm hodd) S hS M hM K hK hK0 hRic

end HamiltonsCubic.L57Block
