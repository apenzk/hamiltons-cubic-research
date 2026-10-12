import Mathlib
import HamiltonsCubic.Results.L3Quad

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L149's margin input: `c(H) ≥ c_p + 3θ (m − 4)/(2(m − 1)) w²` at the balanced sphere product

[findings/second-order.md](../../../findings/second-order.md), Lemma L149, the second of its two inputs: *$c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}\,w^2$,
the margin being $3\theta_0(\tfrac12-\lambda)$ on each summand of [Lemma L27] and the form quadratic, so on $\lVert H\rVert_F=1$ it is a
**convex combination** of the summand margins. The smallest off-summand margin is $3\theta_0\tfrac{m-3}{2(m-1)}$ and the coefficient here
is that **minus $c_p$**.* Here `H = H_s + H_r`, `H_s` in the joint `λ_m`-eigenspace and `w = ‖H_r‖` the weight outside it and outside
the orbit tangent, and the margin is `c(H) = −hessQ(H)/2 = 3θ(½‖H‖² − ⟨L_e H, H⟩)`.

* `dn_val`, `pair_val`, `gap_val`: the sector values of [L3Gap.lean](L3Gap.lean) kept as values rather than a maximum, so every
  `L_e`-eigenvalue on a nonzero Weyl `H ⊥ M` at `p, q ≥ 3` is `½`, `λ_p`, `λ_q`, or at most `μ = (p + q − 2)/(2(p − 1)(q − 1))`;
* **`gap_two`**: at `p = q = m ≥ 4`, an eigenvalue other than `½` and `λ_m` is at most `μ = 1/(m − 1)`;
* **`quad_le_of_gap₂`**: [L3Quad.lean](L3Quad.lean)'s `quad_le_of_gap` with two excluded eigenvalues;
* **`L149_margin`**: `c_p ‖H‖² + 3θ (m − 4)/(2(m − 1)) ‖H_r‖² ≤ −hessQ(H)/2`, with `c_p = 3θ/(2(m − 1))` the margin on the
  `λ_m`-eigenspace, for `H_s` a `λ_m`-eigenvector in `W^⊥ ∩ 𝒲ₙ` and `H_r` in `W^⊥ ∩ 𝒲ₙ` orthogonal to every `½`- and
  `λ_m`-eigenvector there.
-/

namespace HamiltonsCubic.L149Margin

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer HamiltonsCubic.L126Assembly
  HamiltonsCubic.PairSquare HamiltonsCubic.L120Decomp HamiltonsCubic.L222Op HamiltonsCubic.L27Sector
  HamiltonsCubic.L27Pair HamiltonsCubic.L27Dn HamiltonsCubic.L3Gap HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen

/-- **The quadratic form under a gap with two excluded eigenvalues.** -/
theorem quad_le_of_gap₂ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
    {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) (c₁ c₂ lstar : ℝ)
    (hgap : ∀ v : E, v ≠ 0 → ∀ μ : ℝ, T v = μ • v → μ ≠ c₁ → μ ≠ c₂ → μ ≤ lstar)
    (v : E) (hv : ∀ w : E, (T w = c₁ • w ∨ T w = c₂ • w) → inner ℝ w v = 0) :
    inner ℝ (T v) v ≤ lstar * ‖v‖ ^ 2 := by
  set b := hT.eigenvectorBasis rfl
  set e := hT.eigenvalues rfl
  have hTb : ∀ i, T (b i) = e i • b i := fun i => hT.apply_eigenvectorBasis rfl i
  have hexp : inner ℝ (T v) v = ∑ i, e i * inner ℝ (b i) v ^ 2 := by
    rw [← b.sum_inner_mul_inner (T v) v]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [hT v (b i), hTb, real_inner_smul_right, real_inner_comm v (b i)]
    ring
  have hnorm : ‖v‖ ^ 2 = ∑ i, inner ℝ (b i) v ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, ← b.sum_inner_mul_inner v v]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [real_inner_comm v (b i)]; ring
  rw [hexp, hnorm, Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  by_cases h1 : e i = c₁
  · rw [hv (b i) (Or.inl (by rw [hTb, h1]))]; simp
  by_cases h2 : e i = c₂
  · rw [hv (b i) (Or.inr (by rw [hTb, h2]))]; simp
  have hb0 : b i ≠ 0 := by
    intro h
    have := b.orthonormal.1 i
    rw [h, norm_zero] at this
    exact zero_ne_one this
  exact mul_le_mul_of_nonneg_right (hgap (b i) hb0 (e i) (hTb i) h1 h2) (sq_nonneg _)

variable {n : ℕ} {j k : Fin n}

theorem dn_val (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {D : CurvOp2 (Fin n)} (hDW : IsWeyl2 D)
    (hD1 : SignChar (fun _ => 1) D) (hD0 : D ≠ 0)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = 0)
    {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) D = lam • D) :
    lam = ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) ∨ lam = ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) ∨ lam ≤ ((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) := by
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
  · have e := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); exact Or.inl e
  · have e := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); exact Or.inr (Or.inl e)
  · have e := mul_right_cancel₀ hθ.ne' (h.trans (mul_comm _ _)); right; right; rw [e]; linarith
  · have : lam = 0 := by
      rcases mul_eq_zero.mp h with h' | h'
      · exact h'
      · exact absurd h' hθ.ne'
    right; right; rw [this]; linarith

theorem pair_val (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V)
    (hV : SignChar (setChar {j, k}) V) (hV0 : V ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t))) V = lam • V) :
    lam = 1 / 2 ∨ lam = ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) ∨ lam = ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) ∨ lam ≤ ((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) := by
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
    · right; right; right; rw [h]; exact hmu
    · right; left; exact h
    · right; right; right; rw [h]; linarith
  · -- cross, `j ∈ T`
    rcases cross_LeLin_spectrum T hp hq t ht hn hj hk c hsum hne lam heig with h | h
    · right; right; right; rw [h]; exact hmu
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
    · right; right; right; rw [h]; exact hmu
    · left; exact h
  · -- within `Tᶜ`
    rcases within_LeLin_spectrum_out T hp hq t ht hn hj hk hjk c hsum hne lam heig with h | h | h
    · right; right; right; rw [h]; exact hmu
    · right; right; left; exact h
    · right; right; right; rw [h]; linarith

theorem gap_val (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0)
    (hH0 : H ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = lam • H)
    :
    lam = 1 / 2 ∨ lam = ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)) ∨ lam = ((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1)) ∨ lam ≤ ((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)) := by
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
    exact Or.inr (dn_val T hp hq t ht hn hcW hc1 hs0 hcp hcLe)
  · obtain ⟨j, k, hjk, rfl⟩ := Finset.card_eq_two.mp h2
    exact pair_val T hp2 hq2 t ht hn hjk hcW hcc hs0 hcLe
  · obtain ⟨i, j, k, l, hij, hik, hil, hjk, hjl, hkl, rfl⟩ := HamiltonsCubic.L27Main.card_four h4
    have hce' : foxProd2 (I117S.coordOp (t • sphereWeight T)) (comp {i, j, k, l} H hHW)
        = (lam * (t * ((T.card : ℝ) + Tᶜ.card - 1))) • comp {i, j, k, l} H hHW := by
      rw [coordOp_eq_restrict hwt]; exact hce
    exact Or.inr (Or.inr (Or.inr (four_le hij hik hil hjk hjl hkl T hp2 hq2 t ht hn hcW hcc hs0 hce')))

/-- **The second gap at the balanced product**: at `p = q = m ≥ 4`, an `L_e`-eigenvalue on a nonzero Weyl `H ⊥ M` other than `½`
and `λ_m` is at most `μ = 1/(m − 1)`. -/
theorem gap_two (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {H : CurvOp2 (Fin n)} (hHW : IsWeyl2 H)
    (hperp : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = 0) (hH0 : H ≠ 0) {lam : ℝ}
    (heig : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) H = lam • H) (h1 : lam ≠ 1 / 2) (h2 : lam ≠ ((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) :
    lam ≤ 1 / ((T.card : ℝ) - 1) := by
  have hq : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  rcases gap_val T (by omega) (by omega) t ht hn hHW hperp hH0 heig with h | h | h | h
  · exact absurd h h1
  · exact absurd h h2
  · rw [hq] at h; exact absurd h h2
  · rw [hq] at h
    have e : ((T.card : ℝ) + T.card - 2) / (2 * ((T.card : ℝ) - 1) * ((T.card : ℝ) - 1)) = 1 / ((T.card : ℝ) - 1) := by
      have : (T.card : ℝ) - 1 ≠ 0 := by linarith
      field_simp; ring
    rwa [e] at h

/-- **L149's margin input**: at a unit sphere product with `p = q = m ≥ 4`, `H = H_s + H_r` with `H_s` a `λ_m`-eigenvector of
`L_e` in `W^⊥ ∩ 𝒲ₙ` and `H_r ∈ W^⊥ ∩ 𝒲ₙ` orthogonal to every `½`- and `λ_m`-eigenvector there, the margin `−hessQ(H)/2` is at
least `c_p ‖H‖² + 3θ (m − 4)/(2(m − 1)) ‖H_r‖²`, `c_p = 3θ/(2(m − 1))`, `θ = P(M)`. -/
theorem L149_margin (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {Hs Hr : CurvOp2 (Fin n)}
    (hsW : IsWeyl2 Hs) (hsP : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) Hs = 0) (hsE : LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) Hs = (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) • Hs)
    (hrW : IsWeyl2 Hr) (hrP : innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) Hr = 0)
    (hrO : ∀ K : CurvOp2 (Fin n), IsWeyl2 K → innerOp2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = 0 →
      (LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (1 / 2 : ℝ) • K ∨ LeLin (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) K = (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) • K) → innerOp2 K Hr = 0) :
    3 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) / (2 * ((T.card : ℝ) - 1)) * normSq2 (Hs + Hr)
      + 3 * (t * ((T.card : ℝ) + Tᶜ.card - 1)) * ((T.card : ℝ) - 4) / (2 * ((T.card : ℝ) - 1)) * normSq2 Hr
      ≤ -hessQ (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) (Hs + Hr) / 2 := by
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
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hθ : 0 < θ := mul_pos ht (by rw [hqR]; linarith)
  have ha : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = θ • M := sphere_isCritical2 T hp2 hq2 t
  have hP0 : Pcubic2 M ≠ 0 := by rw [hPM]; exact hθ.ne'
  -- the two pieces are orthogonal, `H_s` being a `λ_m`-eigenvector
  have horth : innerOp2 Hs Hr = 0 := hrO Hs hsW hsP (Or.inr hsE)
  -- the quadratic form on `H_r`
  set v : weylPerpR M := ⟨(RecCurv.equiv Hr : RecCurv (Fin n)), hrW, hrP⟩
  have key := quad_le_of_gap₂ (LeRestr_isSymmetric ha hMW hcrit hP0) (1 / 2) (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1)))
    (1 / ((T.card : ℝ) - 1))
    (fun w hw μ hμ h1 h2 => by
      have hw0 : tanV w ≠ 0 := by
        intro h; apply hw; exact Subtype.ext h
      have he : LeLin M (tanV w) = μ • tanV w := congrArg Subtype.val hμ
      exact gap_two T hp hpq t ht hn w.2.1 w.2.2 hw0 he h1 h2)
    v (fun w hw => hrO (tanV w) w.2.1 w.2.2 (hw.imp (congrArg Subtype.val) (congrArg Subtype.val)))
  have hnorm : ‖v‖ ^ 2 = normSq2 Hr := RecCurv.norm_sq_eq (v : RecCurv (Fin n))
  have hin : inner ℝ (LeRestr ha hMW hcrit hP0 v) v = innerOp2 (LeLin M Hr) Hr := rfl
  rw [hnorm, hin] at key
  -- the Hessian at `H`
  have hHW : IsWeyl2 (Hs + Hr) := isWeyl2_add hsW hrW
  have hHP : innerOp2 M (Hs + Hr) = 0 := by rw [innerOp2_add_right, hsP, hrP, add_zero]
  set vH : weylPerpR M := ⟨(RecCurv.equiv (Hs + Hr) : RecCurv (Fin n)), hHW, hHP⟩
  have hQ := hessQ_eq_Le ha hMW hcrit hP0 vH
  change hessQ M (Hs + Hr) = 6 * Pcubic2 M * (innerOp2 (LeLin M (Hs + Hr)) (Hs + Hr) - (1 / 2) * normSq2 (Hs + Hr)) at hQ
  have hcross : innerOp2 (LeLin M Hr) Hs = 0 := by
    rw [LeLin_selfAdj hMW hrW hsW, hsE, innerOp2_smul_right, innerOp2_comm, horth, mul_zero]
  have hexp : innerOp2 (LeLin M (Hs + Hr)) (Hs + Hr) = (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) * normSq2 Hs + innerOp2 (LeLin M Hr) Hr := by
    rw [map_add, hsE, innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      hcross, horth]
    unfold normSq2; ring
  have hN : normSq2 (Hs + Hr) = normSq2 Hs + normSq2 Hr := by
    unfold normSq2
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, horth, innerOp2_comm Hr Hs, horth]; ring
  rw [hQ, hPM, hexp, hN]
  have hm1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have hid : 3 * θ * ((1 / 2) * (normSq2 Hs + normSq2 Hr) - (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) * normSq2 Hs - 1 / ((T.card : ℝ) - 1) * normSq2 Hr)
      = 3 * θ / (2 * ((T.card : ℝ) - 1)) * (normSq2 Hs + normSq2 Hr)
        + 3 * θ * ((T.card : ℝ) - 4) / (2 * ((T.card : ℝ) - 1)) * normSq2 Hr := by
    field_simp; ring
  have hR : -(6 * θ * ((((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) * normSq2 Hs + innerOp2 (LeLin M Hr) Hr - (1 / 2) * (normSq2 Hs + normSq2 Hr))) / 2
      = 3 * θ * ((1 / 2) * (normSq2 Hs + normSq2 Hr) - (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))) * normSq2 Hs - 1 / ((T.card : ℝ) - 1) * normSq2 Hr)
        + 3 * θ * (1 / ((T.card : ℝ) - 1) * normSq2 Hr - innerOp2 (LeLin M Hr) Hr) := by ring
  rw [hR, ← hid]
  have h3 : 0 ≤ 3 * θ := by positivity
  have hle : 0 ≤ 3 * θ * (1 / ((T.card : ℝ) - 1) * normSq2 Hr - innerOp2 (LeLin M Hr) Hr) :=
    mul_nonneg h3 (by linarith)
  linarith

end HamiltonsCubic.L149Margin
