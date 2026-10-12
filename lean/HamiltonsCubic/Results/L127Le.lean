import HamiltonsCubic.Results.L127WMult
import HamiltonsCubic.Results.L126GenBridge
import HamiltonsCubic.Results.L74Statement

set_option linter.style.longLine false

/-!
# L127 in `L_e` units: the cross-factor eigenvalues of `LeLin` are `0` and `½`

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, read in `L_e` units, `e = M/θ`.
[L127Spec.lean](L127Spec.lean) states the cross-factor spectrum for the bare Fox product in `L_M` units. On `Fin n`:

* **`pairVec`**, **`pairVec_lin`**, **`pairVec_skew`**: the pair-span vector `∑ c_i f_i` as a linear, bivector-preserving
  operator;
* **`LeLin_pairVec_iff`**: at a Weyl diagonal `M` with `P(M) ≠ 0`, `LeLin M v = λ v` exactly when `M ∘ v = (λ P(M)) v`
  on every bivector, through [L126GenBridge.lean](L126GenBridge.lean)'s `bridge_apply`;
* **`cross_LeLin_spectrum`**: at a unit sphere product, `P(M) = θ = t(n − 1)` (`theta_of_unit`,
  `theta_of_critical_unit`, `sphere_isCritical`), so every eigenvalue of `L_e` on a nonzero Ricci-cut vector of a
  cross pair block is `0` or `½`, the record's cross-factor row in its own units;
* **`within_LeLin_spectrum`**: at `j, k ∈ T` every `L_e`-eigenvalue on a nonzero Ricci-cut vector is `0`,
  `(p − 2)/(2(p − 1))` (the record's top) or `−μ_{p,q}`, the record's within-factor row in its own units, and
  **`within_LeLin_spectrum_out`** gives the second family, `0`, `(q − 2)/(2(q − 1))` or `−μ_{p,q}`.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge

variable {n : ℕ}

/-- The pair-span vector `∑_{i∈s} c_i f_i` as a bare operator. -/
noncomputable def pairVec (j k : Fin n) (c : Fin n → ℝ) : CurvOp (Fin n) := fun Y =>
  ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) Y

theorem pairVec_lin (j k : Fin n) (c : Fin n → ℝ) : IsLinOp (pairVec j k c) :=
  ⟨fun X Y => by simp only [pairVec, (isLinOp_rk2 _ _).1, smul_add, Finset.sum_add_distrib],
   fun d X => by simp only [pairVec, (isLinOp_rk2 _ _).2, Finset.smul_sum, smul_comm d]⟩

theorem pairVec_skew (j k : Fin n) (c : Fin n → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : IsSkew (pairVec j k c X) := by
  unfold pairVec IsSkew
  rw [Matrix.transpose_sum]
  simp only [Matrix.transpose_smul]
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  have h := rk2_skew (phi_isSkew j i) (phi_isSkew k i) X
  unfold IsSkew at h; rw [h, smul_neg]

/-- **`L_e` on the pair span, as the bare Fox product**: `LeLin M v = λ v` exactly when `M ∘ v = (λ P(M)) v` on every
bivector, at a Weyl diagonal `M`. -/
theorem LeLin_pairVec_iff {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) (hP : Pcubic (diagOp w) ≠ 0)
    (j k : Fin n) (c : Fin n → ℝ) (lam : ℝ) :
    LeLin (restrict (diagOp_isWeyl hwt)) (restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X))
        = lam • restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)
      ↔ ∀ X : Matrix (Fin n) (Fin n) ℝ, IsSkew X →
          foxProd (diagOp w) (pairVec j k c) X = (lam * Pcubic (diagOp w)) • pairVec j k c X := by
  have hW := diagOp_isWeyl hwt
  have hPM : Pcubic2 (restrict hW) = Pcubic (diagOp w) := Pcubic2_restrict (isLinOp_diagOp w) hW
  set v := restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)
  have key : ∀ X : skewSub (Fin n), ((LeLin (restrict hW) v X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = (Pcubic (diagOp w))⁻¹ • foxProd (diagOp w) (pairVec j k c) X := by
    intro X
    change ((foxProd2 ((Pcubic2 (restrict hW))⁻¹ • restrict hW) v X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
    rw [foxProd2_smul_left, _root_.smul_apply, Submodule.coe_smul, bridge_apply hW, hPM]
  constructor
  · intro h X hX
    have e := congrArg (fun F : CurvOp2 (Fin n) => ((F ⟨X, hX⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) h
    rw [key, _root_.smul_apply, Submodule.coe_smul] at e
    change (Pcubic (diagOp w))⁻¹ • foxProd (diagOp w) (pairVec j k c) X = lam • pairVec j k c X at e
    have e2 := congrArg (fun A => Pcubic (diagOp w) • A) e
    simp only [smul_smul, mul_inv_cancel₀ hP, one_smul] at e2
    rw [e2, mul_comm]
  · intro h
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    rw [key, _root_.smul_apply, Submodule.coe_smul, h X X.2, smul_smul]
    change _ = lam • pairVec j k c X
    congr 1
    field_simp

/-- **THE CROSS-FACTOR ROW IN `L_e` UNITS**: at a unit sphere product on `Fin n`, `j ∈ T`, `k ∉ T`, every eigenvalue
of `L_e = LeLin M` on a nonzero Ricci-cut vector of the cross pair span is `0` or `½`. -/
theorem cross_LeLin_spectrum (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {j k : Fin n} (hj : j ∈ T) (hk : k ∉ T) (c : Fin n → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
    (hne : ∃ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q ≠ 0) (lam : ℝ)
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)))
        (restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X))
      = lam • restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)) :
    lam = 0 ∨ lam = 1 / 2 := by
  have hwt := (sphereWeight_isWeight T hp hq).smul t
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp hq t) hn
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : t * ((T.card : ℝ) + Tᶜ.card - 1) ≠ 0 := mul_ne_zero ht.ne' (by linarith)
  rw [LeLin_pairVec_iff hwt (hPθ ▸ hθ)] at heig
  rw [hPθ] at heig
  rcases cross_spectrum T hp hq t hj hk c hsum hne _ heig with h | h
  · left; exact (mul_eq_zero.mp h).resolve_right hθ
  · right
    have : lam * (t * ((T.card : ℝ) + Tᶜ.card - 1)) = (1 / 2) * (t * ((T.card : ℝ) + Tᶜ.card - 1)) := by rw [h]; ring
    exact mul_right_cancel₀ hθ this

/-- **THE WITHIN-FACTOR ROW IN `L_e` UNITS**: at a unit sphere product on `Fin n`, `j, k ∈ T`, every eigenvalue of
`L_e` on a nonzero Ricci-cut vector of a within pair block is `0`, `(p − 2)/(2(p − 1))` (the record's top) or
`−μ_{p,q} = −(n − 2)/(2(p − 1)(q − 1))`. -/
theorem within_LeLin_spectrum (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {j k : Fin n} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k)
    (c : Fin n → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
    (hne : ∃ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q ≠ 0) (lam : ℝ)
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)))
        (restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X))
      = lam • restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)) :
    lam = 0 ∨ lam = ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))
      ∨ lam = -(((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))) := by
  have hwt := (sphereWeight_isWeight T hp hq).smul t
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp hq t) hn
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  have hθ : t * ((T.card : ℝ) + Tᶜ.card - 1) ≠ 0 := mul_ne_zero ht.ne' (by linarith)
  have htne : t ≠ 0 := ht.ne'
  rw [LeLin_pairVec_iff hwt (hPθ ▸ hθ), hPθ] at heig
  rcases within_spectrum T hp t hj hk hjk c hsum hne _ heig with h | h | h
  · left; exact (mul_eq_zero.mp h).resolve_right hθ
  · right; left
    have e : lam * (t * ((T.card : ℝ) + Tᶜ.card - 1))
        = ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) * (t * ((T.card : ℝ) + Tᶜ.card - 1)) := by
      rw [h]; field_simp; ring
    exact mul_right_cancel₀ hθ e
  · right; right
    have e : lam * (t * ((T.card : ℝ) + Tᶜ.card - 1))
        = -(((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)))
          * (t * ((T.card : ℝ) + Tᶜ.card - 1)) := by
      rw [h]; field_simp; ring
    exact mul_right_cancel₀ hθ e

/-- **The second within-factor family in `L_e` units**: at `j, k ∉ T` every `L_e`-eigenvalue on a nonzero Ricci-cut
vector is `0`, `(q − 2)/(2(q − 1))` or `−μ_{p,q}`, `within_LeLin_spectrum` at `Tᶜ` through `sphereWeight_compl`. -/
theorem within_LeLin_spectrum_out (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {j k : Fin n} (hj : j ∉ T) (hk : k ∉ T) (hjk : j ≠ k)
    (c : Fin n → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
    (hne : ∃ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q ≠ 0) (lam : ℝ)
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)))
        (restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X))
      = lam • restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)) :
    lam = 0 ∨ lam = ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))
      ∨ lam = -(((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))) := by
  have hp' : 2 ≤ Tᶜᶜ.card := by simpa only [compl_compl] using hp
  have h := within_LeLin_spectrum Tᶜ hq hp' t ht (by rw [sphereWeight_compl]; exact hn)
    (Finset.mem_compl.mpr hj) (Finset.mem_compl.mpr hk) hjk c hsum hne lam
    (by convert heig using 4 <;> rw [sphereWeight_compl])
  simp only [compl_compl] at h
  rcases h with h | h | h
  · exact Or.inl h
  · exact Or.inr (Or.inl h)
  · right; right; rw [h]; ring_nf

end HamiltonsCubic.L126Assembly
