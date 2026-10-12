import HamiltonsCubic.Results.L17Deriv
import HamiltonsCubic.Results.L17Statement
import HamiltonsCubic.Base.Compression

set_option linter.style.longLine false

/-!
# L17 at the padded `ℂP²` competitor, with no hypothesis beyond the lemma's own

[route-a.md](../../../findings/route-a.md), Lemma L17, the `δ²` half: *at the padded `ℂP²` competitor `u`, for `H`
satisfying the first Bianchi identity and tangent to `u`, `d⁺δ²(u; H) = −2a F(H) ≤ 0`.*

**`L17_at_u`** proves it for every symmetric `H` on `Λ²ℝⁿ`, `n ≥ 4`, with Bianchi read as `Alt(H) = 0` and tangency as
`tr(H u) = 0`. It feeds [L17Deriv.lean](L17Deriv.lean)'s derivative identity into
[L17Statement.lean](L17Statement.lean)'s chain `F ≥ (2/3) tr(B₊) + (1/3) tr(B₋) ≥ 0` and discharges that chain's
three inputs:

- the compression `tr(B₋) ≤ tr(Π_ASD (P₀HP₀)₋)`, by [Compression.lean](../Base/Compression.lean)'s
  `trace_negPart_compress` with `piASD_P0_eq` (`Π_ASD P₀HP₀ Π_ASD = Π_ASD H Π_ASD`, the anti-self-dual bivectors
  lying in `ker u`);
- Bianchi, `H₁₁ + H₂₂ + H₃₃ = tr(B)`, by `pairing` at `X = H`: `Alt(H) = 0` makes `tr(⋆H) = 0`;
- tangency, `2H₁₁ = H₂₂ + H₃₃`, by `trace_comp_rankSum`: `tr(H u) = (2H₁₁ − H₂₂ − H₃₃)/√6`.

*The `Φ` half, `d⁺Φ = 2aκF`, adds `d⁺P(u; H) = 0` from criticality, and [L17Phi.lean](L17Phi.lean)'s `L17` proves
it.*
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel

variable {n : ℕ}

/-! ## Traces against rank sums -/

section Trace
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-- **`tr(X ∘ ∑ μ_γ w_γ w_γᵀ) = ∑ μ_γ ⟪w_γ, X w_γ⟫`.** -/
theorem trace_comp_rankSum {r : ℕ} (X : E →ₗ[ℝ] E) (μ : Fin r → ℝ) (w : Fin r → E) :
    LinearMap.trace ℝ E (X ∘ₗ rankSum μ w) = ∑ γ, μ γ * inner ℝ (w γ) (X (w γ)) := by
  have h : X ∘ₗ rankSum μ w = ∑ γ, μ γ • (innerₛₗ ℝ (w γ)).smulRight (X (w γ)) := by
    refine LinearMap.ext fun x => ?_
    rw [LinearMap.comp_apply, rankSum_apply, map_sum, LinearMap.sum_apply]
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [map_smul, LinearMap.smul_apply, LinearMap.smulRight_apply, innerₛₗ_apply_apply, smul_smul]
  rw [h, map_sum]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [map_smul, LinearMap.trace_smulRight, innerₛₗ_apply_apply, smul_eq_mul]

/-- **The trace of a spectral function**, `tr g(T) = ∑ g(λᵢ)`. -/
theorem trace_specFn {N : ℕ} (hN : finrank ℝ E = N) (g : ℝ → ℝ) {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) :
    LinearMap.trace ℝ E (specFn hN g hT) = ∑ i, g (hT.eigenvalues hN i) := by
  rw [LinearMap.trace_eq_sum_inner _ (hT.eigenvectorBasis hN)]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [specFn_apply_of_eigen hN g hT (apply_eigvec hN hT i), real_inner_smul_right, real_inner_self_eq_norm_sq,
    (hT.eigenvectorBasis hN).orthonormal.1 i, one_pow, mul_one]

end Trace

/-! ## The anti-self-dual projection and `B = Π_ASD H Π_ASD` -/

/-- The unit anti-self-dual bivectors, `vec 3, vec 4, vec 5`. -/
noncomputable def asd (γ : Fin 3) : Biv n := vec ⟨γ.val + 3, by omega⟩

theorem asd_orthonormal (hn : 4 ≤ n) : Orthonormal ℝ (asd (n := n)) :=
  (vec_orthonormal hn).comp _ fun a b h => by
    simp only [Fin.mk.injEq] at h; exact Fin.ext (by omega)

/-- **`Π_ASD`**, the orthogonal projection onto the anti-self-dual `Λ²₋ℝ⁴ ⊂ Λ²ℝⁿ`. -/
noncomputable def piASD : Biv n →ₗ[ℝ] Biv n := rankSum (fun _ => 1) (asd (n := n))

theorem piASD_isSymmetric : (piASD (n := n)).IsSymmetric := rankSum_isSymmetric _ _

/-- A rank sum with unit coefficients over an orthonormal family is idempotent. -/
theorem rankSum_one_idem {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] {r : ℕ} {w : Fin r → E}
    (hw : Orthonormal ℝ w) : rankSum (fun _ => (1 : ℝ)) w ∘ₗ rankSum (fun _ => 1) w = rankSum (fun _ => 1) w := by
  refine LinearMap.ext fun x => ?_
  rw [LinearMap.comp_apply]
  conv_lhs => rw [rankSum_apply]
  rw [rankSum_apply]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [hw.inner_right_fintype (fun δ => 1 * inner ℝ (w δ) x), one_mul]

theorem piASD_idem (hn : 4 ≤ n) : piASD (n := n) ∘ₗ piASD = piASD := rankSum_one_idem (asd_orthonormal hn)

/-- **A Schur multiplier between two eigenvectors**: `⟪w, schur φ H w'⟫ = φ(μ, μ') ⟪w, H w'⟫`. -/
theorem inner_schur_eigen₂ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
    {N : ℕ} (hN : finrank ℝ E = N) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric) (φ : ℝ → ℝ → ℝ) (H : E →ₗ[ℝ] E)
    {w w' : E} {μ μ' : ℝ} (hw : u w = μ • w) (hw' : u w' = μ' • w') :
    inner ℝ w (schur hN hu φ H w') = φ μ μ' * inner ℝ w (H w') := by
  have hexp : ∀ X : E →ₗ[ℝ] E, inner ℝ w (X w') = ∑ i, ∑ j, inner ℝ (hu.eigenvectorBasis hN i) w *
      inner ℝ (hu.eigenvectorBasis hN j) w' * inner ℝ (hu.eigenvectorBasis hN i) (X (hu.eigenvectorBasis hN j)) := fun X => by
    conv_lhs => rw [← (hu.eigenvectorBasis hN).sum_repr' w, ← (hu.eigenvectorBasis hN).sum_repr' w']
    simp only [map_sum, map_smul, inner_sum, sum_inner, real_inner_smul_left, real_inner_smul_right]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  rw [hexp, hexp H, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [entry_schur]
  rcases coord_eigen hN hu hw i with hi | hi
  · rw [hi]; ring
  rcases coord_eigen hN hu hw' j with hj | hj
  · rw [hj]; ring
  · rw [hi, hj]; ring

/-- **`tr(Π_ASD X Π_ASD) = ∑_γ ⟪t_γ, X t_γ⟫`** over the unit anti-self-dual bivectors. -/
theorem trace_piASD_sandwich (hn : 4 ≤ n) (X : Biv n →ₗ[ℝ] Biv n) :
    LinearMap.trace ℝ (Biv n) (piASD ∘ₗ X ∘ₗ piASD) = ∑ γ, inner ℝ (asd γ) (X (asd γ)) := by
  rw [LinearMap.trace_comp_comm' (X ∘ₗ piASD) piASD, LinearMap.comp_assoc, piASD_idem hn, piASD,
    trace_comp_rankSum]
  simp only [one_mul]

/-! ## L17 closed -/

section Close
variable {N : ℕ} (hN : finrank ℝ (Biv n) = N)

theorem uOp_asd (hn : 4 ≤ n) (γ : Fin 3) : uOp (asd (n := n) γ) = (0 : ℝ) • asd γ := by
  unfold asd uOp
  rw [rankSum_vec hn]
  congr 1
  fin_cases γ <;> rfl

/-- **`Π_ASD (P₀HP₀) Π_ASD = Π_ASD H Π_ASD`**: the anti-self-dual bivectors lie in `ker u`. -/
theorem piASD_P0_eq (hn : 4 ≤ n) (H : Biv n →ₗ[ℝ] Biv n) :
    piASD ∘ₗ schur hN uOp_isSymmetric zeroφ H ∘ₗ piASD = piASD ∘ₗ H ∘ₗ piASD := by
  have key : ∀ γ δ : Fin 3, inner ℝ (asd (n := n) γ) (schur hN uOp_isSymmetric zeroφ H (asd δ)) =
      inner ℝ (asd γ) (H (asd δ)) := fun γ δ => by
    rw [inner_schur_eigen₂ hN uOp_isSymmetric zeroφ H (uOp_asd hn γ) (uOp_asd hn δ)]
    simp [zeroφ]
  refine LinearMap.ext fun x => ?_
  simp only [LinearMap.comp_apply, piASD, rankSum_apply, map_sum, map_smul, key]

/-- `B = Π_ASD H Π_ASD` is symmetric. -/
theorem piASD_sandwich_isSymmetric {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) :
    (piASD ∘ₗ H ∘ₗ piASD).IsSymmetric := fun x y => by
  simp only [LinearMap.comp_apply]
  rw [piASD_isSymmetric, hH, piASD_isSymmetric]

/-- **L17 at the padded `ℂP²` competitor.** For every symmetric `H` on `Λ²ℝⁿ`, `n ≥ 4`, satisfying the first Bianchi
identity (`Alt(H) = 0`) and tangent to `u` (`tr(H u) = 0`), with
`F = H₂₂ + H₃₃ + tr(Π_ASD (P₀HP₀)₋)`:

* `d⁺δ²(u; H) = −2a F` with `a = 1/(3√6)`;
* `F ≥ (2/3) tr(B₊) + (1/3) tr(B₋) ≥ 0` for `B = Π_ASD H Π_ASD`;
* so `d⁺δ²(u; H) ≤ 0`.

*The first is [L17Deriv.lean](L17Deriv.lean)'s `hasDerivWithinAt_defect_u`. The second is
[L17Statement.lean](L17Statement.lean)'s chain, with its three inputs discharged: the compression by
`trace_negPart_compress`, Bianchi by `pairing` at `X = H`, tangency by `trace_comp_rankSum`.* -/
theorem L17_at_u (hn : 4 ≤ n) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) (hB : alt4 (compOf H) = 0)
    (hT : LinearMap.trace ℝ (Biv n) (H ∘ₗ uOp) = 0) (hW : ∀ t : ℝ, (uOp + t • H).IsSymmetric) :
    HasDerivWithinAt (fun t => altNormSqOf (specFn hN negPartScalar (hW t)))
      (-2 * (1 / (3 * Real.sqrt 6)) *
        (inner ℝ (vec 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
          ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
            inner ℝ (vec δ) (specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH) (vec δ))))
      (Set.Ici 0) 0 ∧
    2 / 3 * LinearMap.trace ℝ (Biv n) (specFn hN posPartScalar (piASD_sandwich_isSymmetric hH)) +
        1 / 3 * LinearMap.trace ℝ (Biv n) (specFn hN negPartScalar (piASD_sandwich_isSymmetric hH)) ≤
      inner ℝ (vec 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
        ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
          inner ℝ (vec δ) (specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH) (vec δ)) ∧
    -2 * (1 / (3 * Real.sqrt 6)) *
        (inner ℝ (vec 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
          ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
            inner ℝ (vec δ) (specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH) (vec δ))) ≤ 0 := by
  have hZ := piASD_sandwich_isSymmetric (n := n) hH
  set Y := schur hN uOp_isSymmetric zeroφ H
  have hY : Y.IsSymmetric := schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH
  set sliver := ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)), inner ℝ (vec (n := n) δ) (specFn hN negPartScalar hY (vec δ))
    with hsdef
  -- the sliver is `tr(Π_ASD Y₋ Π_ASD)`
  have hsliver : sliver = LinearMap.trace ℝ (Biv n) (piASD ∘ₗ specFn hN negPartScalar hY ∘ₗ piASD) := by
    rw [trace_piASD_sandwich hn, Fin.sum_univ_three, hsdef, Finset.sum_insert (by decide),
      Finset.sum_insert (by decide), Finset.sum_singleton, add_assoc]
    rfl
  -- the compression
  have hZY : (piASD ∘ₗ Y ∘ₗ piASD).IsSymmetric := by rw [piASD_P0_eq hN hn]; exact hZ
  have hcomp := trace_negPart_compress hN hY piASD_isSymmetric (piASD_idem hn) hZY
  have hZeq : ∀ g : ℝ → ℝ, specFn hN g hZY = specFn hN g hZ := fun g => by
    have key : ∀ (T : Biv n →ₗ[ℝ] Biv n) (hT : T.IsSymmetric), T = piASD ∘ₗ H ∘ₗ piASD →
        specFn hN g hT = specFn hN g hZ := by
      rintro T hT rfl; rfl
    exact key _ _ (piASD_P0_eq hN hn H)
  rw [hZeq] at hcomp
  have hcompress : LinearMap.trace ℝ (Biv n) (specFn hN negPartScalar hZ) ≤ sliver := hsliver ▸ hcomp
  -- `tr(B) = tr(B₊) − tr(B₋)`, and both are nonnegative
  have htrB : LinearMap.trace ℝ (Biv n) (piASD ∘ₗ H ∘ₗ piASD) =
      LinearMap.trace ℝ (Biv n) (specFn hN posPartScalar hZ) - LinearMap.trace ℝ (Biv n) (specFn hN negPartScalar hZ) := by
    rw [trace_specFn, trace_specFn, ← Finset.sum_sub_distrib]
    conv_lhs => rw [← specFn_id hN hZ]
    rw [trace_specFn]
    exact Finset.sum_congr rfl fun i _ => (sub_partScalar _).symm
  have hpos : 0 ≤ LinearMap.trace ℝ (Biv n) (specFn hN posPartScalar hZ) := by
    rw [trace_specFn]
    refine Finset.sum_nonneg fun i _ => ?_
    unfold posPartScalar; have := neg_abs_le (hZ.eigenvalues hN i); linarith
  have hneg : 0 ≤ LinearMap.trace ℝ (Biv n) (specFn hN negPartScalar hZ) := by
    rw [trace_specFn]; exact Finset.sum_nonneg fun i _ => negPartScalar_nonneg _
  -- Bianchi: `H₁₁ + H₂₂ + H₃₃ = tr(B)`
  have hsum : ∑ δ, s6 δ * inner ℝ (vec (n := n) δ) (H (vec δ)) = 0 := by
    have hp := pairing H
    rw [hB] at hp
    have h0 : fourInner (alt4 (compOf (rankSum lamNeg (vec (n := n))))) (fun _ _ _ _ => 0) = 0 := by
      simp [fourInner]
    have h6 : 1 / (3 * Real.sqrt 6) ≠ 0 := by positivity
    have := hp.symm.trans h0
    exact (mul_eq_zero.mp this).resolve_left h6
  have hbianchi : inner ℝ (vec (n := n) 0) (H (vec 0)) + inner ℝ (vec 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) =
      LinearMap.trace ℝ (Biv n) (specFn hN posPartScalar hZ) - LinearMap.trace ℝ (Biv n) (specFn hN negPartScalar hZ) := by
    rw [← htrB, trace_piASD_sandwich hn, Fin.sum_univ_three]
    simp only [Fin.sum_univ_six, s6, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val] at hsum
    change _ = inner ℝ (vec 3) (H (vec 3)) + inner ℝ (vec 4) (H (vec 4)) + inner ℝ (vec 5) (H (vec 5))
    linarith
  -- tangency: `2 H₁₁ = H₂₂ + H₃₃`
  have htangent : 2 * inner ℝ (vec (n := n) 0) (H (vec 0)) = inner ℝ (vec 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) := by
    unfold uOp at hT
    rw [trace_comp_rankSum, Fin.sum_univ_six] at hT
    simp only [lam6, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val, zero_mul, add_zero] at hT
    have h6 : 0 < Real.sqrt 6 := by positivity
    field_simp at hT
    linarith
  have hge := L17.F_ge hcompress hbianchi htangent
  have hnn := L17.F_nonneg hcompress hbianchi htangent hpos hneg
  refine ⟨hasDerivWithinAt_defect_u hN hn hH hW, hge, ?_⟩
  exact L17.dDelta_nonpos rfl (by positivity) hnn

end Close

end HamiltonsCubic.L17Deriv
