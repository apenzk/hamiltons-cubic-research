import HamiltonsCubic.Results.L17Close

set_option linter.style.longLine false

/-!
# L17's equality cone `{F = 0}` is a linear subspace

[route-a.md](../../../findings/route-a.md), Lemma L17: *"`{F = 0}` is a linear subspace"*. **`F_eq_zero_iff`**: for `H`
symmetric on `Λ²ℝⁿ`, `n ≥ 4`, with `Alt(H) = 0` and tangent to the padded `ℂP²` competitor `u`,

`F(H) = 0` **iff** `P₀HP₀` vanishes on the anti-self-dual bivectors,

a condition linear in `H`, so **`F_zero_add`** and **`F_zero_smul`** close `{F = 0}` under sums and scalings.

*Why.* `F ≥ (2/3) tr(B₊) + (1/3) tr(B₋)` with both traces nonnegative, so `F = 0` forces `B = Π_ASD H Π_ASD = 0`, then
`H₂₂ + H₃₃ = (2/3) tr B = 0` and the sliver `∑ ⟪t, (P₀HP₀)₋ t⟫` vanishes. A zero diagonal entry of both
`(P₀HP₀)₊` and `(P₀HP₀)₋`, which are positive, kills the vector.
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel

variable {n : ℕ}

section Psd
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {N : ℕ} (hN : finrank ℝ E = N)

/-- **A positive spectral function with a zero diagonal entry kills the vector.** -/
theorem specFn_apply_eq_zero_of_inner (g : ℝ → ℝ) (hg : ∀ x, 0 ≤ g x) {Y : E →ₗ[ℝ] E} (hY : Y.IsSymmetric)
    {w : E} (hw : inner ℝ w (specFn hN g hY w) = 0) : specFn hN g hY w = 0 := by
  rw [inner_specFn_self] at hw
  have hterm := (Finset.sum_eq_zero_iff_of_nonneg fun i _ => mul_nonneg (hg _) (sq_nonneg _)).mp hw
  rw [specFn_apply]
  refine Finset.sum_eq_zero fun i hi => ?_
  have h := hterm i hi
  rcases mul_eq_zero.mp h with h1 | h1
  · rw [h1, zero_mul, zero_smul]
  · rw [pow_eq_zero_iff two_ne_zero |>.mp h1, mul_zero, zero_smul]

/-- **A symmetric operator whose positive and negative parts both have trace `0` is `0`.** -/
theorem eq_zero_of_traces {Z : E →ₗ[ℝ] E} (hZ : Z.IsSymmetric)
    (hp : LinearMap.trace ℝ E (specFn hN posPartScalar hZ) = 0)
    (hm : LinearMap.trace ℝ E (specFn hN negPartScalar hZ) = 0) : Z = 0 := by
  rw [L17Deriv.trace_specFn] at hp hm
  have hp' := (Finset.sum_eq_zero_iff_of_nonneg fun i _ => by
    unfold posPartScalar; have := neg_abs_le (hZ.eigenvalues hN i); linarith).mp hp
  have hm' := (Finset.sum_eq_zero_iff_of_nonneg fun i _ => negPartScalar_nonneg _).mp hm
  rw [← specFn_id hN hZ, specFn_congr hN id hZ (fun _ => 0) fun i => by
    have := sub_partScalar (hZ.eigenvalues hN i)
    rw [hp' i (Finset.mem_univ _), hm' i (Finset.mem_univ _)] at this
    simpa using this.symm, specFn_const, zero_smul]

end Psd

section Cone
variable {N : ℕ} (hN : finrank ℝ (Biv n) = N)

/-- **`F`**, the first-order coefficient of L17, read in the bivector model. -/
noncomputable def Fval {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) : ℝ :=
  inner ℝ (vec (n := n) 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
    ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
      inner ℝ (vec δ) (specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH) (vec δ))

theorem Fval_sliver (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) :
    Fval hN hH = inner ℝ (vec (n := n) 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
      ∑ γ, inner ℝ (asd γ) (specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH) (asd γ)) := by
  rw [Fval, Fin.sum_univ_three, Finset.sum_insert (by decide), Finset.sum_insert (by decide), Finset.sum_singleton]
  simp only [add_assoc]
  rfl

/-- **The smooth branch**: Bianchi and tangency give `H₂₂ + H₃₃ = (2/3) ∑_ASD ⟪t, H t⟫`. -/
theorem smooth_eq (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hB : alt4 (compOf H) = 0)
    (hT : LinearMap.trace ℝ (Biv n) (H ∘ₗ uOp) = 0) :
    inner ℝ (vec (n := n) 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) =
      2 / 3 * ∑ γ, inner ℝ (asd (n := n) γ) (H (asd γ)) := by
  have hsum : ∑ δ, s6 δ * inner ℝ (vec (n := n) δ) (H (vec δ)) = 0 := by
    have hp := pairing H
    rw [hB] at hp
    have h0 : fourInner (alt4 (compOf (rankSum lamNeg (vec (n := n))))) (fun _ _ _ _ => 0) = 0 := by
      simp [fourInner]
    have h6 : 1 / (3 * Real.sqrt 6) ≠ 0 := by positivity
    exact (mul_eq_zero.mp (hp.symm.trans h0)).resolve_left h6
  unfold uOp at hT
  rw [trace_comp_rankSum, Fin.sum_univ_six] at hT
  simp only [lam6, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val, zero_mul, add_zero] at hT
  have h6 : 0 < Real.sqrt 6 := by positivity
  field_simp at hT
  simp only [Fin.sum_univ_six, s6, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val] at hsum
  rw [Fin.sum_univ_three]
  change _ = 2 / 3 * (inner ℝ (vec 3) (H (vec 3)) + inner ℝ (vec 4) (H (vec 4)) + inner ℝ (vec 5) (H (vec 5)))
  linarith

/-- **`L17`'s equality cone**: `F(H) = 0` exactly when `P₀HP₀` vanishes on the anti-self-dual bivectors. -/
theorem F_eq_zero_iff (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) (hB : alt4 (compOf H) = 0)
    (hT : LinearMap.trace ℝ (Biv n) (H ∘ₗ uOp) = 0) :
    Fval hN hH = 0 ↔ ∀ γ : Fin 3, schur hN uOp_isSymmetric zeroφ H (asd (n := n) γ) = 0 := by
  have hY := schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH
  set Y := schur hN uOp_isSymmetric zeroφ H
  have hdiag : ∀ γ δ : Fin 3, inner ℝ (asd (n := n) γ) (Y (asd δ)) = inner ℝ (asd γ) (H (asd δ)) := fun γ δ => by
    rw [inner_schur_eigen₂ hN uOp_isSymmetric zeroφ H (uOp_asd hn γ) (uOp_asd hn δ)]; simp [zeroφ]
  have hsm := smooth_eq hn hB hT
  rw [Fval_sliver hN hn]
  constructor
  · intro hF
    -- `F ≥ (2/3) tr B₊ + (1/3) tr B₋ ≥ 0` forces `B = 0`
    have hW : ∀ t : ℝ, (uOp + t • H).IsSymmetric := fun t x y => by
      simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
        real_inner_smul_right, uOp_isSymmetric x y, hH x y]
    obtain ⟨-, hge, -⟩ := L17_at_u hN hn hH hB hT hW
    have hZ := piASD_sandwich_isSymmetric (n := n) hH
    have hp : 0 ≤ LinearMap.trace ℝ (Biv n) (specFn hN posPartScalar hZ) := by
      rw [trace_specFn]; refine Finset.sum_nonneg fun i _ => ?_
      unfold posPartScalar; have := neg_abs_le (hZ.eigenvalues hN i); linarith
    have hm : 0 ≤ LinearMap.trace ℝ (Biv n) (specFn hN negPartScalar hZ) := by
      rw [trace_specFn]; exact Finset.sum_nonneg fun i _ => negPartScalar_nonneg _
    have hF' : Fval hN hH = 0 := by rw [Fval_sliver hN hn]; exact hF
    have hge' := hge
    rw [show inner ℝ (vec (n := n) 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
        ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)), inner ℝ (vec δ) (specFn hN negPartScalar hY (vec δ)) = Fval hN hH from rfl,
      hF'] at hge'
    have hZ0 : piASD ∘ₗ H ∘ₗ piASD = 0 := eq_zero_of_traces hN hZ (by linarith) (by linarith)
    -- so every `⟪t, H t⟫` vanishes
    have hpa : ∀ δ : Fin 3, piASD (asd (n := n) δ) = asd δ := fun δ => by
      rw [piASD, rankSum_apply]
      simp only [one_mul, orthonormal_iff_ite.mp (asd_orthonormal hn), ite_smul, one_smul, zero_smul,
        Finset.sum_ite_eq', Finset.mem_univ, if_true]
    have hHt : ∀ γ : Fin 3, inner ℝ (asd (n := n) γ) (H (asd γ)) = 0 := fun γ => by
      have h := congrArg (fun X : Biv n →ₗ[ℝ] Biv n => inner ℝ (asd (n := n) γ) (X (asd γ))) hZ0
      simp only [LinearMap.comp_apply, LinearMap.zero_apply, inner_zero_right, hpa] at h
      rw [← piASD_isSymmetric, hpa] at h
      exact h
    have hsl : ∑ γ, inner ℝ (asd (n := n) γ) (specFn hN negPartScalar hY (asd γ)) = 0 := by
      simp only [hHt, Finset.sum_const_zero, mul_zero] at hsm
      linarith
    have hterm := (Finset.sum_eq_zero_iff_of_nonneg fun γ _ =>
      inner_specFn_nonneg hN negPartScalar negPartScalar_nonneg hY (asd (n := n) γ)).mp hsl
    intro γ
    have hneg := specFn_apply_eq_zero_of_inner hN negPartScalar negPartScalar_nonneg hY (hterm γ (Finset.mem_univ _))
    have hYt : inner ℝ (asd (n := n) γ) (Y (asd γ)) = 0 := by rw [hdiag, hHt]
    have hsplit : ∀ w, specFn hN posPartScalar hY w = Y w + specFn hN negPartScalar hY w := fun w => by
      have h := specFn_add hN hY id negPartScalar
      rw [specFn_id] at h
      rw [← LinearMap.add_apply, h]
      exact LinearMap.congr_fun (specFn_congr hN _ hY _ fun i => by
        have := sub_partScalar (hY.eigenvalues hN i); simp only [id]; linarith) w
    have hpos := specFn_apply_eq_zero_of_inner hN posPartScalar
      (fun x => by unfold posPartScalar; have := neg_abs_le x; linarith) hY
      (w := asd γ) (by rw [hsplit, inner_add_right, hYt, hneg, inner_zero_right, add_zero])
    have := hsplit (asd γ)
    rw [hpos, hneg, add_zero] at this
    exact this.symm
  · intro h0
    have hHt : ∀ γ : Fin 3, inner ℝ (asd (n := n) γ) (H (asd γ)) = 0 := fun γ => by
      rw [← hdiag, h0, inner_zero_right]
    have hneg : ∀ γ : Fin 3, specFn hN negPartScalar hY (asd (n := n) γ) = 0 := fun γ => by
      rw [specFn_apply_of_eigen hN negPartScalar hY (μ := 0) (by rw [h0, zero_smul])]
      simp [negPartScalar]
    simp only [hHt, Finset.sum_const_zero, mul_zero] at hsm
    simp only [hneg, inner_zero_right, Finset.sum_const_zero, add_zero]
    exact hsm

theorem schur_add_right (φ : ℝ → ℝ → ℝ) (H H' : Biv n →ₗ[ℝ] Biv n) :
    schur hN uOp_isSymmetric φ (H + H') = schur hN uOp_isSymmetric φ H + schur hN uOp_isSymmetric φ H' :=
  ext_entries hN uOp_isSymmetric fun k l => by
    rw [LinearMap.add_apply, inner_add_right, entry_schur, entry_schur, entry_schur, LinearMap.add_apply,
      inner_add_right]; ring

theorem schur_smul_right (φ : ℝ → ℝ → ℝ) (c : ℝ) (H : Biv n →ₗ[ℝ] Biv n) :
    schur hN uOp_isSymmetric φ (c • H) = c • schur hN uOp_isSymmetric φ H :=
  ext_entries hN uOp_isSymmetric fun k l => by
    rw [LinearMap.smul_apply, real_inner_smul_right, entry_schur, entry_schur, LinearMap.smul_apply,
      real_inner_smul_right]; ring

/-- **The linear hypotheses the proof uses**: symmetric, `Alt = 0` and tangent. `𝒲ₙ ∩ T_uS` adds Ricci-flatness and lies
inside this class ([L17Converse.lean](L17Converse.lean)'s `admissible_opB`), so every statement here covers it. -/
structure Admissible (H : Biv n →ₗ[ℝ] Biv n) : Prop where
  symm : H.IsSymmetric
  bianchi : alt4 (compOf H) = 0
  tangent : LinearMap.trace ℝ (Biv n) (H ∘ₗ uOp) = 0

theorem Admissible.add {H H' : Biv n →ₗ[ℝ] Biv n} (h : Admissible H) (h' : Admissible H') : Admissible (H + H') where
  symm x y := by simp only [LinearMap.add_apply, inner_add_left, inner_add_right, h.symm x y, h'.symm x y]
  bianchi := by
    have : compOf (H + H') = compOf H + compOf H' := by
      funext i j k l; simp [compOf, inner_add_right]
    funext i j k l
    have h1 := congrFun (congrFun (congrFun (congrFun h.bianchi i) j) k) l
    have h2 := congrFun (congrFun (congrFun (congrFun h'.bianchi i) j) k) l
    simp only [alt4, this, Pi.add_apply, Pi.zero_apply] at h1 h2 ⊢
    linarith
  tangent := by rw [LinearMap.add_comp, map_add, h.tangent, h'.tangent, add_zero]

theorem Admissible.smul {H : Biv n →ₗ[ℝ] Biv n} (h : Admissible H) (c : ℝ) : Admissible (c • H) where
  symm x y := by simp only [LinearMap.smul_apply, real_inner_smul_left, real_inner_smul_right, h.symm x y]
  bianchi := by
    funext i j k l
    have h1 := congrFun (congrFun (congrFun (congrFun h.bianchi i) j) k) l
    simp only [alt4, compOf, LinearMap.smul_apply, real_inner_smul_right, Pi.zero_apply] at h1 ⊢
    rw [show (1 : ℝ) / 3 * (c * inner ℝ (coords (phi k l)) (H (coords (phi i j))) +
        c * inner ℝ (coords (phi l j)) (H (coords (phi i k))) + c * inner ℝ (coords (phi j k)) (H (coords (phi i l)))) =
      c * ((1 : ℝ) / 3 * (inner ℝ (coords (phi k l)) (H (coords (phi i j))) +
        inner ℝ (coords (phi l j)) (H (coords (phi i k))) + inner ℝ (coords (phi j k)) (H (coords (phi i l))))) by ring,
      h1, mul_zero]
  tangent := by rw [LinearMap.smul_comp, map_smul, h.tangent, smul_zero]

/-- **`{F = 0}` is closed under sums.** -/
theorem F_zero_add (hn : 4 ≤ n) {H H' : Biv n →ₗ[ℝ] Biv n} (h : Admissible H) (h' : Admissible H')
    (hF : Fval hN h.symm = 0) (hF' : Fval hN h'.symm = 0) : Fval hN (h.add h').symm = 0 := by
  rw [F_eq_zero_iff hN hn h.symm h.bianchi h.tangent] at hF
  rw [F_eq_zero_iff hN hn h'.symm h'.bianchi h'.tangent] at hF'
  rw [F_eq_zero_iff hN hn (h.add h').symm (h.add h').bianchi (h.add h').tangent]
  intro γ
  rw [schur_add_right, LinearMap.add_apply, hF γ, hF' γ, add_zero]

/-- **`{F = 0}` is closed under scalings.** -/
theorem F_zero_smul (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (h : Admissible H) (c : ℝ)
    (hF : Fval hN h.symm = 0) : Fval hN (h.smul c).symm = 0 := by
  rw [F_eq_zero_iff hN hn h.symm h.bianchi h.tangent] at hF
  rw [F_eq_zero_iff hN hn (h.smul c).symm (h.smul c).bianchi (h.smul c).tangent]
  intro γ
  rw [schur_smul_right, LinearMap.smul_apply, hF γ, smul_zero]

end Cone

end HamiltonsCubic.L17Deriv
