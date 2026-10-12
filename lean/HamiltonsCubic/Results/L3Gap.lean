import Mathlib
import HamiltonsCubic.Results.L27Close

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# The spectral gap at a sphere product: every `L_e`-eigenvalue on `W^⊥` off `1/2` is at most `max(λ_p, λ_q, μ)`

[findings/second-order.md](../../../findings/second-order.md), Lemma L3: *[Lemma L27](nondegeneracy.md) at $p=q=m$ gives the values of $L_e$
on $W^{*\perp}$: $\tfrac12$ on the orbit tangent … $\lambda_m=\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ for each factor, $\mu$ on
$\Lambda^2\otimes\Lambda^2$ and $-\mu$ on $S^2_0\otimes S^2_0$ … Off the orbit tangent the largest value is $\lambda_m$, since
$\lambda_m-\mu=\frac{m-4}{2(m-1)}\ge0$ … So … $\mathrm{Hess}\,P\le6\theta(\lambda_m-\tfrac12)=-\frac{6\theta}{n-2}$.*

The sector lemmas of L27 carry the values, not only the bound `1/2`:

* `dn_le`: on the diagonal sector off `M`, `λ ≤ max(λ_p, λ_q)`;
* `pair_le`: on a pair sector, `λ = 1/2` or `λ ≤ max(λ_p, λ_q)`;
* `four_le`: on a four-set sector, `λ ≤ μ`, `μ = (p + q − 2)/(2(p − 1)(q − 1))`;
* **`L3_gap`**: every `L_e`-eigenvalue `λ ≠ 1/2` on a nonzero Weyl `H ⊥ M` has `λ ≤ max(max(λ_p, λ_q), μ)`;
* **`L3_gap_balanced`**: at `p = q = m ≥ 4`, `λ ≤ λ_m = (m − 2)/(2(m − 1))`, so every eigenvalue of the Hessian
  `6θ(L_e − 1/2)` on an eigenvector off the orbit tangent is at most `6θ(λ_m − 1/2) = −6θ/(n − 2)`. The quadratic-form bound
  is [L3Quad.lean](L3Quad.lean)'s `L3_hessian`.
-/

namespace HamiltonsCubic.L3Gap

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.PairSquare HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.L27Sector
  HamiltonsCubic.L27Pair HamiltonsCubic.L27Dn

variable {n : ℕ} {j k : Fin n}

theorem dn_le (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {D : CurvOp2 (Fin n)} (hDW : IsWeyl2 D)
    (hD1 : SignChar (fun _ => 1) D) (hD0 : D ≠ 0)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = 0)
    {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = lam • D) :
    lam ≤ max (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  set w := t • sphereWeight T with hwdef
  have hwt : IsWeight w := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hPθ : Pcubic (diagOp w) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp w) (diagOp_isWeyl hwt), hPθ]
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (3 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hθ : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  -- `D` is diagonal
  obtain ⟨u, hu, rfl⟩ := (HamiltonsCubic.L120Ident.trivial_block_iff D hDW).mp hD1
  have hu0 : u ≠ 0 := by
    rintro rfl
    apply hD0
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    rw [restrict_apply]
    show diagOp 0 (X : Matrix (Fin n) (Fin n) ℝ) = 0
    ext a b
    simp [diagOp]
  -- the eigen-relation as `M ∘ D = (λθ) D`
  have hfox : foxProd2 M (restrict (diagOp_isWeyl hu))
      = (lam * (t * ((T.card : ℝ) + Tᶜ.card - 1))) • restrict (diagOp_isWeyl hu) := by
    have h1 : LeLin M (restrict (diagOp_isWeyl hu)) = (Pcubic2 M)⁻¹ • foxProd2 M (restrict (diagOp_isWeyl hu)) :=
      foxProd2_smul_left _ _ _
    rw [h1, hPM] at heig
    have h2 := congrArg (fun F => (t * ((T.card : ℝ) + Tᶜ.card - 1)) • F) heig
    simp only [smul_smul, mul_inv_cancel₀ hθ.ne', one_smul] at h2
    rw [h2, mul_comm]
  have hf := fox_bridge hwt hu hfox
  have hmem := dn_excl_fox T hp2 hq2 t hu hu0 hf
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hmem
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  simp only [dnLp, dnLq, dnMu] at u1 u2 u3 u4 u5
  have hlp : ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  have hlq : ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  rcases hmem with h | h | h | h | h
  · -- the value `1`: `u` is on the sphere-weight line, against `D ⊥ M`
    exfalso
    have hl : lam = 1 := by
      have := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _))
      linarith
    have hKL := KL_of_fox w u hwt.symm hwt.hollow hu.symm hu.hollow _ hf
    have hmem' : u ∈ dnWeights (Fin n) ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1) := by
      refine ⟨hu, Module.End.mem_eigenspace_iff.mpr ?_⟩
      rw [← hwdef, hKL, h]
      unfold dnθ; ring_nf
    rw [dn_eig_line T hp hq t ht.ne'] at hmem'
    obtain ⟨s, hs⟩ := Submodule.mem_span_singleton.mp hmem'
    have hD : restrict (diagOp_isWeyl hu) = (s / t) • M := by
      rw [← coordOp_eq_restrict hu, hMdef, ← coordOp_eq_restrict hwt, ← coordOp_smul', ← hs, hwdef, smul_smul,
        div_mul_cancel₀ s ht.ne']
    have hN : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp w) (diagOp_isWeyl hwt), hn]
    rw [hD, innerOp2_smul_right] at hperp
    unfold normSq2 at hN
    rw [hN, mul_one] at hperp
    have hs0 : s = 0 := by
      rcases div_eq_zero_iff.mp hperp with h' | h'
      · exact h'
      · exact absurd h' ht.ne'
    apply hu0
    rw [← hs, hs0, zero_smul]
  · have e := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); rw [e]; exact le_max_left _ _
  · have e := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); rw [e]; exact le_max_right _ _
  · have e := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); rw [e]
    exact le_trans (by linarith) (le_max_left _ _)
  · have : lam = 0 := by
      rcases mul_eq_zero.mp h with h' | h'
      · exact h'
      · exact absurd h' hθ.ne'
    rw [this]; exact le_trans u1.le (le_max_left _ _)


theorem pair_le (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V)
    (hV : SignChar (setChar {j, k}) V) (hV0 : V ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t))) V = lam • V) :
    lam = 1 / 2 ∨ lam ≤ max (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))) := by
  obtain ⟨c, hsum, rfl⟩ := pair_eq_pairVec hjk hVW hV
  have hne := pairVec_ne hV0
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hmu : 0 ≤ ((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) := by
    apply div_nonneg <;> nlinarith
  have hlp : ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  have hlq : ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) < 1 / 2 := by
    rw [div_lt_iff₀ (by linarith)]; linarith
  have hl0p : 0 ≤ ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) := by apply div_nonneg <;> linarith
  have hl0q : 0 ≤ ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) := by apply div_nonneg <;> linarith
  by_cases hj : j ∈ T <;> by_cases hk : k ∈ T
  · -- within `T`
    rcases within_LeLin_spectrum T hp hq t ht hn hj hk hjk c hsum hne lam heig with h | h | h
    · right; rw [h]; exact le_trans hl0p (le_max_left _ _)
    · right; rw [h]; exact le_max_left _ _
    · right; rw [h]; exact le_trans (by linarith) (le_max_left _ _)
  · -- cross, `j ∈ T`
    rcases cross_LeLin_spectrum T hp hq t ht hn hj hk c hsum hne lam heig with h | h
    · right; rw [h]; exact le_trans hl0p (le_max_left _ _)
    · left; exact h
  · -- cross, `k ∈ T`
    have e : pairVec j k c = pairVec k j c := pairVec_comm c
    have hf : univ.filter (fun i => j ≠ i ∧ k ≠ i) = univ.filter (fun i => k ≠ i ∧ j ≠ i) := by
      ext i; simp [and_comm]
    rw [hf] at hsum hne
    have heig' : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)))
        (restrictLin (pairVec_lin k j c) (fun X _ => pairVec_skew k j c X))
        = lam • restrictLin (pairVec_lin k j c) (fun X _ => pairVec_skew k j c X) := by
      have hv : restrictLin (pairVec_lin j k c) (fun X _ => pairVec_skew j k c X)
          = restrictLin (pairVec_lin k j c) (fun X _ => pairVec_skew k j c X) :=
        ContinuousLinearMap.ext fun X => Subtype.ext (by
          show pairVec j k c (X : Matrix (Fin n) (Fin n) ℝ) = pairVec k j c (X : Matrix (Fin n) (Fin n) ℝ)
          rw [e])
      rw [← hv]; exact heig
    rcases cross_LeLin_spectrum T hp hq t ht hn hk hj c hsum hne lam heig' with h | h
    · right; rw [h]; exact le_trans hl0p (le_max_left _ _)
    · left; exact h
  · -- within `Tᶜ`
    rcases within_LeLin_spectrum_out T hp hq t ht hn hj hk hjk c hsum hne lam heig with h | h | h
    · right; rw [h]; exact le_trans hl0q (le_max_right _ _)
    · right; rw [h]; exact le_max_right _ _
    · right; rw [h]; exact le_trans (by linarith) (le_max_right _ _)


/-- **The four-set sector**: `λ ≤ μ`. -/
theorem four_le {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {lam : ℝ}
    (heig : foxProd2 (I117S.coordOp (t • sphereWeight T)) ν
      = (lam * (t * ((T.card : ℝ) + Tᶜ.card - 1))) • ν) :
    lam ≤ ((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) := by
  have h := HamiltonsCubic.L27Four.four_sphere hij hik hil hjk hjl hkl T hp hq t ht hn hνW hν hν0 heig
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp hq t) hn
  rw [theta_of_unit _ hn, hPθ] at h
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  set θ := t * ((T.card : ℝ) + Tᶜ.card - 1)
  set K := ((T.card : ℝ) + Tᶜ.card - 2) / (((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))
  have hθ : 0 < θ := mul_pos ht (by linarith)
  have hK0 : 0 ≤ K := by apply div_nonneg <;> nlinarith
  have hμ : ((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) = K / 2 := by
    simp only [K]; field_simp
  rw [hμ]
  have h2 : (2 * lam) ^ 2 ≤ K ^ 2 := by
    have h' : θ ^ 2 * (2 * lam) ^ 2 ≤ θ ^ 2 * K ^ 2 := by nlinarith [h]
    exact le_of_mul_le_mul_left h' (by positivity)
  nlinarith [sq_nonneg (2 * lam - K), sq_nonneg (2 * lam + K)]

/-- **The spectral gap**: at a unit sphere product with `p, q ≥ 3`, every `L_e`-eigenvalue `λ ≠ 1/2` on a nonzero Weyl `H ⊥ M`
has `λ ≤ max(max(λ_p, λ_q), μ)`. -/
theorem L3_gap (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (hH0 : H ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = lam • H)
    (hhalf : lam ≠ 1 / 2) :
    lam ≤ max (max (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))))
      (((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hwt := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hM1 : SignChar (fun _ => 1) M := (HamiltonsCubic.L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hwt, rfl⟩
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (3 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  set θ := t * ((T.card : ℝ) + Tᶜ.card - 1) with hθdef
  have hθ : 0 < θ := mul_pos ht (by linarith)
  have hLe : ∀ V : CurvOp2 (Fin n), LeLin M V = θ⁻¹ • foxProd2 M V := fun V => by
    rw [← hPM]; exact foxProd2_smul_left _ _ _
  have hfox : foxProd2 M H = (lam * θ) • H := by
    have h2 := congrArg (fun F => θ • F) (heig.symm.trans (hLe H))
    simp only [smul_smul, mul_inv_cancel₀ hθ.ne', one_smul] at h2
    rw [← h2, mul_comm]
  have hex : ∃ s, comp s H hHW ≠ 0 := by
    by_contra hc
    push Not at hc
    apply hH0
    rw [← sum_comp H hHW]
    exact Finset.sum_eq_zero fun s _ => hc s
  obtain ⟨s, hs0⟩ := hex
  have hce := comp_eigen hM1 hHW hfox s
  have hcLe : LeLin M (comp s H hHW) = lam • comp s H hHW := by
    rw [hLe, hce, smul_smul]; congr 1; field_simp
  have hcW := comp_isWeyl2 s H hHW
  have hcc := comp_char s H hHW
  have hcard : s.card = 0 ∨ s.card = 2 ∨ s.card = 4 := by
    by_contra hc
    exact hs0 (HamiltonsCubic.L120Support.comp_zero s H hHW hc)
  rcases hcard with h0 | h2 | h4
  · have hs : s = ∅ := Finset.card_eq_zero.mp h0
    subst hs
    have hc1 : SignChar (fun _ => 1) (comp ∅ H hHW) := signChar_congr hcc fun ε _ => by simp [setChar]
    have hcp : innerOp2 M (comp ∅ H hHW) = 0 := (comp_perp hM1 ∅ hHW hperp).2
    exact le_trans (dn_le T hp hq t ht hn hcW hc1 hs0 hcp hcLe) (le_max_left _ _)
  · obtain ⟨j, k, hjk, rfl⟩ := Finset.card_eq_two.mp h2
    rcases pair_le T hp2 hq2 t ht hn hjk hcW hcc hs0 hcLe with h | h
    · exact absurd h hhalf
    · exact le_trans h (le_max_left _ _)
  · obtain ⟨i, j, k, l, hij, hik, hil, hjk, hjl, hkl, rfl⟩ := HamiltonsCubic.L27Main.card_four h4
    have hce' : foxProd2 (I117S.coordOp (t • sphereWeight T)) (comp {i, j, k, l} H hHW)
        = (lam * (t * ((T.card : ℝ) + Tᶜ.card - 1))) • comp {i, j, k, l} H hHW := by
      rw [coordOp_eq_restrict hwt]; exact hce
    exact le_trans (four_le hij hik hil hjk hjl hkl T hp2 hq2 t ht hn hcW hcc hs0 hce') (le_max_right _ _)

/-- **The balanced product**: at `p = q = m ≥ 4`, every `L_e`-eigenvalue `λ ≠ 1/2` on `W^⊥` has `λ ≤ λ_m = (m − 2)/(2(m − 1))`,
so every eigenvalue of the Hessian `6θ(L_e − 1/2)` on such an eigenvector is at most `6θ(λ_m − 1/2) = −6θ/(n − 2)`. -/
theorem L3_gap_balanced (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (hH0 : H ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = lam • H)
    (hhalf : lam ≠ 1 / 2) :
    lam ≤ ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) := by
  have h := L3_gap T (by omega) (by omega) t ht hn hHW hperp hH0 heig hhalf
  have hq : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  rw [hq, max_self] at h
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hμ : ((T.card : ℝ) + T.card - 2) / (2 * ((T.card : ℝ) - 1) * ((T.card : ℝ) - 1))
      ≤ ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) := by
    rw [div_le_div_iff₀ (by nlinarith) (by linarith)]
    have h1 : 0 ≤ ((T.card : ℝ) - 1) * ((T.card : ℝ) - 1) * ((T.card : ℝ) - 4) :=
      mul_nonneg (mul_nonneg (by linarith) (by linarith)) (by linarith)
    nlinarith [h1]
  exact le_trans h (max_le le_rfl hμ)

end HamiltonsCubic.L3Gap
