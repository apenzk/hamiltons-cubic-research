import Mathlib
import HamiltonsCubic.Results.L149Margin
import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Results.L127DnUnits

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L3's bound is attained: a `λ_p`-eigenvector of `L_e` off the orbit tangent carrying `hessQ = 6θ(λ_p − ½)‖H‖²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L3: on the complement `N` of the orbit tangent,
`Hess P ≤ 6θ(λ_m − ½) = −6θ/(n − 2)`, the value carried by `S²₀(ℝ^m)`. [L3Quad.lean](L3Quad.lean)'s `L3_hessian` is the
bound. This file exhibits a direction reaching it, so the constant is sharp:

* **`LeLin_diag_of_phi`**: for Weyl diagonal `M = diagOp w`, `D = diagOp u`, the relation `M ∘ D = (λ P(M)) D` on every `φ_ab`
  gives `L_e D = λ D` on the operators, through `phi_expand`;
* **`lam_witness`**: at a sphere product with `p ≥ 3`, `q ≥ 1`, the `λ_p` weight `u = lamW T κ h` of `h = e_a − e_b` for
  `a ≠ b` in `T` is a weight whose operator is nonzero;
* **`L3_attained`**: at a unit sphere product with `p ≥ 3`, `q ≥ 2`, a nonzero Weyl `D ⊥ M` with `L_e D = λ_p D`, orthogonal to
  every `½`-eigenvector (the orbit tangent at `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, by `L27_half_span`), and
  `hessQ M D = 6θ(λ_p − ½) ‖D‖²`;
* **`L3_sharp`**: at `p = q = m ≥ 4` that is `hessQ M D = −(6θ/(n − 2)) ‖D‖²`, equality in `L3_hessian`;
* **`orbit_bilinear_zero`**: the Hessian's bilinear form vanishes on a `½`-eigenvector against every direction in `W^⊥ ∩ 𝒲ₙ`,
  so the orbit tangent is in its kernel.
-/

namespace HamiltonsCubic.L3Attain

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen

variable {n : ℕ}

/-- **`L_e` on a diagonal operator, from the bivector relation.** -/
theorem LeLin_diag_of_phi {w u : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) (hu : IsWeight u)
    (hP : Pcubic (diagOp w) ≠ 0) (lam : ℝ)
    (h : ∀ a b, foxProd (diagOp w) (diagOp u) (phi a b) = (lam * Pcubic (diagOp w)) • diagOp u (phi a b)) :
    LeLin (restrict (diagOp_isWeyl hwt)) (restrict (diagOp_isWeyl hu)) = lam • restrict (diagOp_isWeyl hu) := by
  have hW := diagOp_isWeyl hwt
  have hU := diagOp_isWeyl hu
  have hPM : Pcubic2 (restrict hW) = Pcubic (diagOp w) := Pcubic2_restrict (isLinOp_diagOp w) hW
  have hF : IsLinOp (foxProd (diagOp w) (diagOp u)) := isLinOp_foxProd (isLinOp_diagOp w) (isLinOp_diagOp u)
  have hD : IsLinOp (diagOp u) := isLinOp_diagOp u
  have hall : ∀ X : Matrix (Fin n) (Fin n) ℝ, IsSkew X →
      foxProd (diagOp w) (diagOp u) X = (lam * Pcubic (diagOp w)) • diagOp u X := by
    intro X hX
    rw [HamiltonsCubic.L41Statement.Frame.phi_expand X hX]
    rw [HamiltonsCubic.L121Block.lin_sum _ hF, HamiltonsCubic.L121Block.lin_sum _ hD, Finset.smul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [HamiltonsCubic.L121Block.lin_sum _ hF, HamiltonsCubic.L121Block.lin_sum _ hD, Finset.smul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [hF.2, hD.2, h a b, smul_comm]
  have key : ∀ X : skewSub (Fin n), ((LeLin (restrict hW) (restrict hU) X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = (Pcubic (diagOp w))⁻¹ • foxProd (diagOp w) (diagOp u) X := by
    intro X
    change ((foxProd2 ((Pcubic2 (restrict hW))⁻¹ • restrict hW) (restrict hU) X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
    rw [foxProd2_smul_left, _root_.smul_apply, Submodule.coe_smul, restrict_eq_restrictLin' (isLinOp_diagOp u) hU,
      bridge_apply hW, hPM]
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [key, _root_.smul_apply, Submodule.coe_smul, hall X X.2, smul_smul]
  change _ = lam • diagOp u X
  congr 1
  field_simp

/-- **The `λ_p` witness**: `h = e_a − e_b` with `a ≠ b` in `T` sums to zero on `T`, and its weight `lamW T κ h`, `κ = −(p − 2)/q`,
is a weight with a nonzero operator. -/
theorem lam_witness (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 1 ≤ Tᶜ.card) :
    ∃ h : Fin n → ℝ, ∑ b ∈ T, h b = 0 ∧
      ∃ hu : IsWeight (lamW T (-((T.card : ℝ) - 2) / Tᶜ.card) h), restrict (diagOp_isWeyl hu) ≠ 0 := by
  obtain ⟨a, ha, b, hb, hab⟩ : ∃ a ∈ T, ∃ b ∈ T, a ≠ b := by
    obtain ⟨a, ha⟩ := Finset.card_pos.mp (by omega : 0 < T.card)
    obtain ⟨b, hb, hba⟩ := Finset.exists_mem_ne (by omega : 1 < T.card) a
    exact ⟨a, ha, b, hb, Ne.symm hba⟩
  obtain ⟨c, hc⟩ := Finset.card_pos.mp (by omega : 0 < Tᶜ.card)
  have hcT : c ∉ T := Finset.mem_compl.mp hc
  set h : Fin n → ℝ := Pi.single a 1 - Pi.single b 1 with hdef
  have hh : ∑ i ∈ T, h i = 0 := by
    simp only [hdef, Pi.sub_apply, Finset.sum_sub_distrib, Finset.sum_pi_single', ha, hb, if_true, sub_self]
  have hqR : (1 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  set κ : ℝ := -((T.card : ℝ) - 2) / Tᶜ.card with hκdef
  have hκ : κ * (Tᶜ.card : ℝ) = -((T.card : ℝ) - 2) := by
    rw [hκdef]; field_simp
  have hκ0 : κ ≠ 0 := by
    rw [hκdef]; exact div_ne_zero (by linarith) (by linarith)
  have hu := lamW_isWeight T κ h hh hκ
  refine ⟨h, hh, hu, fun h0 => ?_⟩
  have hac : a ≠ c := fun e => hcT (e ▸ ha)
  have e := congrArg (fun F : CurvOp2 (Fin n) =>
    ((F ⟨phi a c, phi_mem_skewSub a c⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) a c) h0
  simp only [restrict_apply] at e
  change diagOp (lamW T κ h) (phi a c) a c = 0 at e
  rw [diagOp_phi _ (lamW_symm T κ h)] at e
  have hua : lamW T κ h a c = κ := by
    simp [lamW, hac, ha, hcT, hdef, Pi.single_apply, hab]
  simp [hua, phi, Matrix.single_apply, hac, Ne.symm hac, hκ0] at e

/-- **The `λ_p` direction at a sphere product**: at a unit sphere product with `p ≥ 3`, `q ≥ 2`, there is a nonzero Weyl `D ⊥ M`
with `L_e D = λ_p D`, orthogonal to every `½`-eigenvector of `L_e` in `W^⊥ ∩ 𝒲ₙ`, and `hessQ M D = 6θ(λ_p − ½) ‖D‖²`. At
`p, q ≥ 3`, `(p, q) ≠ (3, 3)` that eigenspace is the orbit tangent by `L27_half_span`. -/
theorem L3_attained (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    ∃ D : CurvOp2 (Fin n), IsWeyl2 D ∧ D ≠ 0 ∧
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = 0 ∧
      LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D
        = (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) • D ∧
      (∀ K : CurvOp2 (Fin n), IsWeyl2 K →
        innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
        LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
        innerOp2 K D = 0) ∧
      hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D
        = 6 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) - 1 / 2) * normSq2 D := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  set θ := t * ((T.card : ℝ) + Tᶜ.card - 1) with hθdef
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : 0 < θ := mul_pos ht (by linarith)
  have ha : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = θ • M := sphere_isCritical2 T hp2 hq2 t
  have hP0 : Pcubic2 M ≠ 0 := by rw [hPM]; exact hθ.ne'
  set LP := ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) with hLP
  have hLPh : LP < 1 / 2 := by rw [hLP, div_lt_iff₀ (by linarith)]; linarith
  obtain ⟨h, hh, hu, hD0⟩ := lam_witness T hp (by omega)
  set D := restrict (diagOp_isWeyl hu) with hDdef
  have hDW : IsWeyl2 D := isWeyl2_restrict _
  have hDeig : LeLin M D = LP • D :=
    LeLin_diag_of_phi hwt hu (by rw [hPθ]; exact hθ.ne') LP fun a b => by
      rw [sphere_lam T hp2 hq2 t h hh a b, hPθ, mul_comm]
  have hLM : LeLin M M = M := by
    show foxProd2 ((Pcubic2 M)⁻¹ • M) M = M
    rw [foxProd2_smul_left, foxProd2_self, hcrit, smul_smul, hPM, inv_mul_cancel₀ hθ.ne', one_smul]
  have hperp : innerOp2 M D = 0 := by
    have e := LeLin_selfAdj hMW hDW hMW
    rw [hDeig, hLM, innerOp2_smul_left] at e
    have e2 : (LP - 1) * innerOp2 D M = 0 := by linarith
    rw [innerOp2_comm]
    rcases mul_eq_zero.mp e2 with h1 | h1
    · linarith
    · exact h1
  refine ⟨D, hDW, hD0, hperp, hDeig, fun K hKW _ hK => ?_, ?_⟩
  · have e := LeLin_selfAdj hMW hKW hDW
    rw [hK, hDeig, innerOp2_smul_left, innerOp2_smul_right] at e
    have e2 : (1 / 2 - LP) * innerOp2 K D = 0 := by linarith
    rcases mul_eq_zero.mp e2 with h1 | h1
    · linarith
    · exact h1
  · have hQ := hessQ_eq_Le ha hMW hcrit hP0 (⟨(RecCurv.equiv D : RecCurv (Fin n)), hDW, hperp⟩ : weylPerpR M)
    change hessQ M D = 6 * Pcubic2 M * (innerOp2 (LeLin M D) D - (1 / 2) * normSq2 D) at hQ
    rw [hQ, hDeig, innerOp2_smul_left, hPM]
    unfold normSq2; ring

/-- **L3's bound is attained**: at a unit sphere product with `p = q = m ≥ 4`, a nonzero Weyl `D ⊥ M` orthogonal to the orbit
tangent has `hessQ M D = −(6θ/(n − 2)) ‖D‖²`, so `L3_hessian`'s constant is sharp. -/
theorem L3_sharp (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    ∃ D : CurvOp2 (Fin n), IsWeyl2 D ∧ D ≠ 0 ∧
      innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = 0 ∧
      (∀ K : CurvOp2 (Fin n), IsWeyl2 K →
        innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
        LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K →
        innerOp2 K D = 0) ∧
      hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D
        = -(6 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) / ((T.card : ℝ) + Tᶜ.card - 2)) * normSq2 D := by
  obtain ⟨D, hDW, hD0, hperp, _, horb, hQ⟩ := L3_attained T (by omega) (by omega) t ht hn
  refine ⟨D, hDW, hD0, hperp, horb, ?_⟩
  rw [hQ]
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  rw [hqR]
  have hm1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  rw [show (T.card : ℝ) + T.card - 2 = 2 * ((T.card : ℝ) - 1) by ring]
  field_simp
  ring

/-- **The Hessian's bilinear form vanishes on the orbit tangent**: at a unit critical Weyl `a` with `P(a) ≠ 0`, a `½`-eigenvector
`v` of `L_e` in `W^⊥ ∩ 𝒲ₙ` has `Hess(v, w) = 0` for every `w` there, the polarisation of `hessQ`. -/
theorem orbit_bilinear_zero {a : CurvOp2 (Fin n)} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (v w : weylPerpR a)
    (hv : LeLin a (tanV v) = (1 / 2 : ℝ) • tanV v) :
    (hessQ a (tanV (v + w)) - hessQ a (tanV v) - hessQ a (tanV w)) / 2 = 0 := by
  rw [hessB_op ha hWa hcrit hθ, hessOp_apply, hv, innerOp2_smul_left, innerOp2_sub_left', sub_self, mul_zero]

end HamiltonsCubic.L3Attain
