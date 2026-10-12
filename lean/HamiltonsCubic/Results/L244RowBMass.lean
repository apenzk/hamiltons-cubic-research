import Mathlib
import HamiltonsCubic.Results.L244RowBClasses
import HamiltonsCubic.Results.L244RowA
import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Results.L209WeylClosure

/-!
# L244, row (B) in the record's class masses

[findings/second-order.md](../../../findings/second-order.md), Lemma L244 (i), row (B).

For a skew family `ψ` labelled by classes, `Pc ψ cls a X = ∑_{γ ∈ E_a} ⟨ψ_γ, X⟩ ψ_γ`. Then
`mixQF (Pc a) (Pc b) η = bAB ψ cls a b η` (`mixQF_Pc`), the record's
`b_ab(η) = ½ ∑_{γ∈E_a, δ∈E_b} ⟨[ψ_γ, ψ_δ], η⟩²`, so `mixSym (Pc a) (Pc b) η = 2 b_ab(η)`. No
orthonormality of `ψ` is used here: `Pc a` is self-adjoint by its form, and the `φ`-basis Parseval
`∑_ij ⟨X, φ_ij⟩⟨Y, φ_ij⟩ = 2⟨X, Y⟩` needs only `Y` skew (`parseval_phi`).
-/

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results
  HamiltonsCubic.L244RowA

namespace HamiltonsCubic.L244RowBMass

variable {n K : ℕ}

/-- The class projection written through the family. -/
noncomputable def Pc {r : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a : Fin K) :
    Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ :=
  fun X => ∑ γ ∈ Finset.univ.filter (fun γ => cls γ = a), inner2 (ψ γ) X • ψ γ

theorem parseval_phi (X Y : Matrix (Fin n) (Fin n) ℝ) (hY : IsSkew Y) :
    ∑ i, ∑ j, inner2 X (phi i j) * inner2 Y (phi i j) = 2 * inner2 X Y := by
  have e := RealLayer.skew_expand Y hY
  conv_rhs => rw [← e]
  rw [FamilyLayer.inner2_smul_right, inner2_sum_right]
  simp only [inner2_sum_right, FamilyLayer.inner2_smul_right, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  ring

theorem mixQF_Pc {r : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (cls : Fin r → Fin K) (a b : Fin K) (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    mixQF (Pc ψ cls a) (Pc ψ cls b) η = bAB ψ cls a b η := by
  set Ea := Finset.univ.filter (fun γ => cls γ = a)
  set Eb := Finset.univ.filter (fun δ => cls δ = b)
  -- x_γδ = ⟨ψ_γ, [η, ψ_δ]⟩
  have hbrsum : ∀ i j, br η (Pc ψ cls b (phi i j))
      = ∑ δ ∈ Eb, inner2 (ψ δ) (phi i j) • br η (ψ δ) := by
    intro i j
    unfold Pc
    rw [linOp_sum (fun X => br η X) (L244RowB.ad_isLinOp η)]
    refine Finset.sum_congr rfl fun δ _ => ?_
    exact (L244RowB.ad_isLinOp η).2 _ _
  have hterm : ∀ i j, inner2 (br η (Pc ψ cls a (br η (Pc ψ cls b (phi i j))))) (phi i j)
      = -∑ γ ∈ Ea, ∑ δ ∈ Eb, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (ψ δ))
          * inner2 (ψ γ) (br η (phi i j)) := by
    intro i j
    rw [inner2_br_skew _ _ _ hη]
    congr 1
    rw [hbrsum i j]
    unfold Pc
    rw [inner2_sum_left']
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [FamilyLayer.inner2_smul_left, inner2_sum_right, Finset.sum_mul]
    refine Finset.sum_congr rfl fun δ _ => ?_
    rw [FamilyLayer.inner2_smul_right]
  have hpars : ∀ γ δ, ∑ i, ∑ j, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (phi i j))
      = 2 * inner2 (ψ γ) (br η (ψ δ)) := by
    intro γ δ
    have hs : ∀ i j, inner2 (ψ γ) (br η (phi i j)) = -inner2 (br η (ψ γ)) (phi i j) := by
      intro i j; rw [inner2_br_skew _ _ _ hη, neg_neg]
    simp only [hs, mul_neg, Finset.sum_neg_distrib]
    rw [parseval_phi _ _ (br_isSkew hη (hψS γ))]
    have h := inner2_br_skew η (ψ δ) (ψ γ) hη
    rw [inner2_comm (br η (ψ δ))] at h
    linarith
  unfold mixQF bAB
  simp only [hterm, Finset.sum_neg_distrib]
  -- move the γ, δ sums outside the i, j sums
  have hswap : ∑ i, ∑ j, ∑ γ ∈ Ea, ∑ δ ∈ Eb, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (ψ δ))
        * inner2 (ψ γ) (br η (phi i j))
      = ∑ γ ∈ Ea, ∑ δ ∈ Eb, inner2 (ψ γ) (br η (ψ δ))
        * ∑ i, ∑ j, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (phi i j)) := by
    simp only [Finset.mul_sum]
    calc _ = ∑ i, ∑ γ ∈ Ea, ∑ j, ∑ δ ∈ Eb, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (ψ δ))
            * inner2 (ψ γ) (br η (phi i j)) :=
          Finset.sum_congr rfl fun i _ => Finset.sum_comm
      _ = ∑ i, ∑ γ ∈ Ea, ∑ δ ∈ Eb, ∑ j, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (ψ δ))
            * inner2 (ψ γ) (br η (phi i j)) :=
          Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun γ _ => Finset.sum_comm
      _ = ∑ γ ∈ Ea, ∑ i, ∑ δ ∈ Eb, ∑ j, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (ψ δ))
            * inner2 (ψ γ) (br η (phi i j)) := Finset.sum_comm
      _ = ∑ γ ∈ Ea, ∑ δ ∈ Eb, ∑ i, ∑ j, inner2 (ψ δ) (phi i j) * inner2 (ψ γ) (br η (ψ δ))
            * inner2 (ψ γ) (br η (phi i j)) :=
          Finset.sum_congr rfl fun γ _ => Finset.sum_comm
      _ = _ := by
          refine Finset.sum_congr rfl fun γ _ => Finset.sum_congr rfl fun δ _ =>
            Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
          ring
  rw [hswap]
  simp only [hpars, Finset.mul_sum]
  have hx : ∀ γ δ, inner2 (br (ψ γ) (ψ δ)) η ^ 2 = inner2 (ψ γ) (br η (ψ δ)) ^ 2 := by
    intro γ δ
    have h1 := inner2_br_skew (ψ γ) (ψ δ) η (hψS γ)
    have h2 : br (ψ γ) η = -br η (ψ γ) := by unfold br; abel
    rw [h2, inner2_neg_right'', neg_neg] at h1
    have h3 := inner2_br_skew η (ψ γ) (ψ δ) hη
    rw [h1, inner2_comm (ψ δ), h3]; ring
  simp only [hx]
  try simp only [Finset.mul_sum, Finset.sum_mul, Finset.sum_neg_distrib, mul_neg, neg_mul, neg_neg]
  refine Finset.sum_congr rfl fun γ _ => Finset.sum_congr rfl fun δ _ => ?_
  ring

theorem mixSym_Pc {r : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (cls : Fin r → Fin K) (a b : Fin K) (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    mixSym (Pc ψ cls a) (Pc ψ cls b) η = 2 * bAB ψ cls a b η := by
  unfold mixSym
  rw [mixQF_Pc ψ hψS cls a b η hη, mixQF_Pc ψ hψS cls b a η hη, bAB_symm ψ cls b a η]; ring

theorem Pc_isLinOp {r : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a : Fin K) :
    IsLinOp (Pc ψ cls a) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · unfold Pc; rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [inner2_add_right, add_smul]
  · unfold Pc; rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [FamilyLayer.inner2_smul_right, smul_smul]

/-- **Row (B) in the record's class masses**: with `ψ` resolving the identity through the classes
and `W = ∑_b λ_b P_b`, `∑_a ∑_b λ_b b_ab(η) = −⟨W η, η⟩` at every skew `η`. At a unit `x ∈ E_c`
this is L244 (i)'s row (B), `∑_{a,b} λ_b b_ab(x) = −λ_c`. -/
theorem rowB_mass {r : ℕ} (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hId : ∀ X, IsSkew X → X = ∑ a, Pc ψ cls a X)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • Pc ψ cls b X)
    (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    ∑ a, ∑ b, lam b * bAB ψ cls a b η = -inner2 (W η) η := by
  have hPs : ∀ a X, IsSkew X → IsSkew (Pc ψ cls a X) := fun a X _ => by
    unfold Pc
    refine isSkew_sum' _ _ fun γ _ => ?_
    unfold IsSkew
    rw [Matrix.transpose_smul, hψS γ, smul_neg]
  have h := L244RowBClasses.rowB_classes W hW (Pc ψ cls) (Pc_isLinOp ψ cls) hPs lam hId hWP η hη
  simp only [mixSym_Pc ψ hψS cls _ _ η hη] at h
  have e : ∑ a, ∑ b, lam b * (2 * bAB ψ cls a b η) = 2 * ∑ a, ∑ b, lam b * bAB ψ cls a b η := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    ring
  rw [e] at h
  linarith

theorem mixQF_sum_left {κ : Type*} (s : Finset κ) (f : κ → Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (B : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (η : Matrix (Fin n) (Fin n) ℝ) :
    mixQF (fun X => ∑ k ∈ s, f k X) B η = ∑ k ∈ s, mixQF (f k) B η := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    have h := mixQF_smul_left 0 (fun _ => (0 : Matrix (Fin n) (Fin n) ℝ)) B η
    simpa using h
  | insert a s ha ih =>
    have hf : (fun X => ∑ k ∈ insert a s, f k X) = fun X => f a X + ∑ k ∈ s, f k X := by
      funext X; rw [Finset.sum_insert ha]
    rw [hf, mixQF_add_left, ih, Finset.sum_insert ha]

theorem mixQF_sum_right {κ : Type*} (A : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hA : IsLinOp A) (s : Finset κ) (g : κ → Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (η : Matrix (Fin n) (Fin n) ℝ) :
    mixQF A (fun X => ∑ k ∈ s, g k X) η = ∑ k ∈ s, mixQF A (g k) η := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    have h := mixQF_smul_right 0 A (fun _ => (0 : Matrix (Fin n) (Fin n) ℝ)) hA η
    simpa using h
  | insert a s ha ih =>
    have hf : (fun X => ∑ k ∈ insert a s, g k X) = fun X => g a X + ∑ k ∈ s, g k X := by
      funext X; rw [Finset.sum_insert ha]
    rw [hf, mixQF_add_right _ _ _ hA, ih, Finset.sum_insert ha]

/-- **Row (C) in the record's class masses**: `∑_a ∑_b λ_a λ_b b_ab(η) = ⟨W# η, η⟩`
(`sharpQF W η`), for a linear Weyl `W = ∑_b λ_b P_b` on bivectors. At a critical point
`W# = θW − W²`, which at a unit `x ∈ E_c` gives L244 (i)'s row (C), `λ_c (θ − λ_c)` (`rowC_critical`). -/
theorem rowC_mass {r : ℕ} (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • Pc ψ cls b X)
    (η : Matrix (Fin n) (Fin n) ℝ) (hη : IsSkew η) :
    ∑ a, ∑ b, lam a * lam b * bAB ψ cls a b η = sharpQF W η := by
  have hPs : ∀ a X, IsSkew (Pc ψ cls a X) := fun a X => by
    unfold Pc
    refine isSkew_sum' _ _ fun γ _ => ?_
    unfold IsSkew
    rw [Matrix.transpose_smul, hψS γ, smul_neg]
  have hLs : ∀ X, IsSkew (∑ b, lam b • Pc ψ cls b X) := fun X =>
    isSkew_sum' _ _ fun b _ => by unfold IsSkew; rw [Matrix.transpose_smul, hPs b X, smul_neg]
  have hlin : ∀ b, IsLinOp (fun X => lam b • Pc ψ cls b X) := fun b =>
    ⟨fun X Y => by simp only [(Pc_isLinOp ψ cls b).1, smul_add],
     fun c X => by simp only [(Pc_isLinOp ψ cls b).2, smul_comm c (lam b)]⟩
  have hLlin : IsLinOp (fun X => ∑ b, lam b • Pc ψ cls b X) :=
    ⟨fun X Y => by simp only [(Pc_isLinOp ψ cls _).1, smul_add, Finset.sum_add_distrib],
     fun c X => by simp only [(Pc_isLinOp ψ cls _).2, Finset.smul_sum, smul_comm c]⟩
  rw [sharpQF_eq_mixQF, L244RowBClasses.mixQF_congr W (fun X => ∑ b, lam b • Pc ψ cls b X)
    W (fun X => ∑ b, lam b • Pc ψ cls b X) hWP hWP hW.2.1 η hη]
  rw [mixQF_sum_left]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [mixQF_sum_right _ (hlin a)]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [mixQF_smul_left, mixQF_smul_right _ _ _ (Pc_isLinOp ψ cls a), mixQF_Pc ψ hψS cls a b η hη]
  ring

/-- **Row (C) at a critical point**: for a unit skew eigenvector `x` of a critical linear Weyl `W`,
`W x = λ_c x`, `⟨W# x, x⟩ = λ_c (θ − λ_c)`. With `rowC_mass` this is L244 (i)'s row (C). -/
theorem rowC_critical (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (lc : ℝ)
    (hxe : W x = lc • x) (hunit : inner2 x x = 1) :
    sharpQF W x = lc * (θ - lc) := by
  have hSlin := sharpOp_isLinOp W hW.1
  -- `IsCritical` holds on the `φ` basis; linearity carries it to every bivector
  have hQ : ∀ X, IsSkew X → W (W X) + sharpOp W X = θ • W X := by
    intro X hX
    have e := RealLayer.skew_expand X hX
    set E := ∑ i, ∑ j, inner2 X (phi i j) • phi i j with hE
    have hX' : X = (1/2 : ℝ) • E := e.symm
    rw [hX', hW.1.2, hW.1.2, hSlin.2, smul_comm θ, ← smul_add]
    congr 1
    rw [hE]
    simp only [linOp_sum W hW.1, linOp_sum (sharpOp W) hSlin]
    rw [Finset.smul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.smul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    have h := hc i j
    unfold Qop compOp at h
    rw [hW.1.2, hW.1.2, hSlin.2, ← smul_add, h, smul_comm]
  have hS : sharpOp W x = (θ * lc - lc ^ 2) • x := by
    have h := hQ x hx
    rw [hxe, hW.1.2, hxe] at h
    rw [show sharpOp W x = θ • (lc • x) - lc • lc • x from eq_sub_of_add_eq' h]
    rw [smul_smul, smul_smul, ← sub_smul]; ring_nf
  rw [← HamiltonsCubic.L41Statement.Frame.inner_sharpOp hW.2 x hx, hS, FamilyLayer.inner2_smul_right, hunit]
  ring

end HamiltonsCubic.L244RowBMass
