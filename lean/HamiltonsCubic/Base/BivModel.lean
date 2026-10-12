import HamiltonsCubic.Base.NegPartDeriv
import HamiltonsCubic.Base.AltPart

set_option linter.style.longLine false

/-!
# The bivector model, and the defect without a presentation

Milestones 5a and 5b of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md).

- `rankSum λ w = ∑ λ_γ w_γ ⟪w_γ, ·⟫` and **`specFn_rankSum`**: at an orthonormal family, `g(∑ λ w wᵀ) = ∑ g(λ) w wᵀ`
  whenever `g(0) = 0`, on any finite-dimensional real inner product space;
- `Biv n`, the Euclidean space on the pairs `i < j`, with `coords X = (⟨X, φᵢⱼ⟩)_{i<j}` and `sum_pairs`, the layer's
  doubled sums as sums over pairs;
- **`inner_coords`**, Parseval: `⟪coords X, coords Y⟫ = ⟨X, Y⟩` on skew matrices, and `orthonormal_coords`;
- `compOf` and `altNormSqOf`, the four-index array and `‖Alt(·)‖²` of an operator on `Biv n`, with `comp_specOp_eq`
  identifying the layer's `comp` of a spectral operator;
- **`defectSq_eq`**: at every orthonormal skew presentation, the layer's `defectSq λ ω` is `‖Alt(g(W))‖²` for the
  operator `W = ∑ λ_γ ω_γ ω_γᵀ` and `g` the negative part, so the defect is presentation-free;
- `hasDerivWithinAt_altNormSqOf`, the chain rule for `‖Alt(·)‖²`, and **`hasDerivWithinAt_defect`**:
  `d⁺δ²(u; H) = 2 ⟨Alt(u₋), Alt(D)⟩` for symmetric `u`, `H` on `Biv n`, with `D` the one-sided derivative of the
  negative part from [NegPartDeriv.lean](NegPartDeriv.lean).
-/

namespace HamiltonsCubic.SpectralFn

open Module

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-! ## Operators in rank-one form -/

/-- **`∑_γ λ_γ w_γ ⟪w_γ, ·⟫`.** -/
noncomputable def rankSum {r : ℕ} (lam : Fin r → ℝ) (w : Fin r → E) : E →ₗ[ℝ] E :=
  ∑ γ, lam γ • (innerₛₗ ℝ (w γ)).smulRight (w γ)

omit [FiniteDimensional ℝ E] in
theorem rankSum_apply {r : ℕ} (lam : Fin r → ℝ) (w : Fin r → E) (x : E) :
    rankSum lam w x = ∑ γ, (lam γ * inner ℝ (w γ) x) • w γ := by
  simp [rankSum, LinearMap.sum_apply, smul_smul]

omit [FiniteDimensional ℝ E] in
theorem rankSum_isSymmetric {r : ℕ} (lam : Fin r → ℝ) (w : Fin r → E) : (rankSum lam w).IsSymmetric := fun x y => by
  rw [rankSum_apply, rankSum_apply, sum_inner, inner_sum]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [real_inner_smul_left, real_inner_smul_right, real_inner_comm (w γ) x]
  ring

/-- **At an orthonormal family, `g(∑ λ_γ w_γ w_γᵀ) = ∑ g(λ_γ) w_γ w_γᵀ`** whenever `g(0) = 0`. -/
theorem specFn_rankSum {n r : ℕ} (hn : finrank ℝ E = n) (g : ℝ → ℝ) (g0 : g 0 = 0) (lam : Fin r → ℝ)
    {w : Fin r → E} (hw : Orthonormal ℝ w) :
    specFn hn g (rankSum_isSymmetric lam w) = rankSum (fun γ => g (lam γ)) w := by
  refine (specFn_unique hn g _ _ fun μ v hv => ?_).symm
  have hcoef : ∀ γ, lam γ * inner ℝ (w γ) v = μ * inner ℝ (w γ) v := fun γ => by
    have := congrArg (inner ℝ (w γ)) hv
    rw [rankSum_apply, hw.inner_right_fintype (fun δ => lam δ * inner ℝ (w δ) v), real_inner_smul_right] at this
    exact this
  have hg : ∀ γ, g (lam γ) * inner ℝ (w γ) v = g μ * inner ℝ (w γ) v := fun γ => by
    by_cases h0 : inner ℝ (w γ) v = 0
    · rw [h0, mul_zero, mul_zero]
    · rw [mul_right_cancel₀ h0 (hcoef γ)]
  rw [rankSum_apply]
  simp_rw [hg]
  -- `v` minus its projection onto the span of `w` lies in the `0`-eigenspace, where `g` vanishes
  set p := ∑ γ, inner ℝ (w γ) v • w γ with hp
  have hTp : rankSum lam w v = μ • p := by
    rw [rankSum_apply, hp, Finset.smul_sum]
    exact Finset.sum_congr rfl fun γ _ => by rw [hcoef γ, smul_smul]
  have hperp : μ • (v - p) = 0 := by rw [smul_sub, ← hv, hTp, sub_self]
  have hsum : ∑ γ, (g μ * inner ℝ (w γ) v) • w γ = g μ • p := by
    rw [hp, Finset.smul_sum]
    exact Finset.sum_congr rfl fun γ _ => by rw [smul_smul]
  rw [hsum]
  rcases smul_eq_zero.mp hperp with hμ | hvp
  · rw [hμ, g0, zero_smul, zero_smul]
  · rw [sub_eq_zero.mp hvp]

end HamiltonsCubic.SpectralFn

/-! ## The bivector model `Λ²ℝⁿ = ℝ^{pairs}` -/

namespace HamiltonsCubic.BivModel

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn

variable {n : ℕ}

/-- The ordered pairs `i < j`, indexing the orthonormal basis `φᵢⱼ` of `Λ²ℝⁿ`. -/
abbrev Pairs (n : ℕ) := {p : Fin n × Fin n // p.1 < p.2}

/-- **`Λ²ℝⁿ` as a Euclidean space** on the pairs `i < j`. -/
abbrev Biv (n : ℕ) := EuclideanSpace ℝ (Pairs n)

/-- **The coordinates of a matrix**, `⟨X, φᵢⱼ⟩` for `i < j`. -/
noncomputable def coords (X : Matrix (Fin n) (Fin n) ℝ) : Biv n :=
  WithLp.toLp 2 fun p => inner2 X (phi p.1.1 p.1.2)

theorem coords_apply (X : Matrix (Fin n) (Fin n) ℝ) (p : Pairs n) : coords X p = inner2 X (phi p.1.1 p.1.2) := rfl

/-- **An ordered double sum of a symmetric array with zero diagonal is twice its sum over pairs.** -/
theorem sum_pairs {f : Fin n → Fin n → ℝ} (hdiag : ∀ i, f i i = 0) (hsym : ∀ i j, f j i = f i j) :
    ∑ i, ∑ j, f i j = 2 * ∑ p : Pairs n, f p.1.1 p.1.2 := by
  have h1 : ∑ p : Pairs n, f p.1.1 p.1.2 = ∑ i, ∑ j, if i < j then f i j else 0 := by
    rw [← Finset.sum_subtype (Finset.univ.filter fun q : Fin n × Fin n => q.1 < q.2) (by simp)
      (fun q : Fin n × Fin n => f q.1 q.2), Finset.sum_filter, ← Fintype.sum_prod_type']
  have h2 : ∑ i, ∑ j, (if i < j then f i j else 0) = ∑ i, ∑ j, if j < i then f i j else 0 := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      split_ifs <;> simp [hsym]
  rw [h1, two_mul]
  nth_rewrite 2 [h2]
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rcases lt_trichotomy i j with h | h | h
  · simp [h, not_lt.mpr h.le]
  · subst h; simp [hdiag]
  · simp [h, not_lt.mpr h.le]

theorem skew_entry {X : Matrix (Fin n) (Fin n) ℝ} (hX : IsSkew X) (a b : Fin n) : X b a = -X a b := by
  have := congrFun (congrFun hX a) b
  simpa [Matrix.transpose_apply] using this

/-- **Parseval**: the coordinates are an isometry on skew matrices, `⟪coords X, coords Y⟫ = ⟨X, Y⟩`. -/
theorem inner_coords {X Y : Matrix (Fin n) (Fin n) ℝ} (hX : IsSkew X) (hY : IsSkew Y) :
    inner ℝ (coords X) (coords Y) = inner2 X Y := by
  rw [inner2_eq_sum, sum_pairs (f := fun a b => X a b * Y a b)
    (fun i => by
      have := skew_entry hX i i
      rw [show X i i = 0 by linarith, zero_mul])
    (fun i j => by rw [skew_entry hX, skew_entry hY]; ring)]
  simp only [PiLp.inner_apply, coords_apply, inner2_phi _ hX, inner2_phi _ hY, RCLike.inner_apply, conj_trivial]
  rw [← mul_assoc, one_div, inv_mul_cancel₀ two_ne_zero, one_mul]
  exact Finset.sum_congr rfl fun p _ => by ring

/-- **An orthonormal skew family has orthonormal coordinates.** -/
theorem orthonormal_coords {r : ℕ} {om : Fin r → Matrix (Fin n) (Fin n) ℝ} (hom : ∀ γ, IsSkew (om γ))
    (horth : ∀ γ δ, inner2 (om γ) (om δ) = if γ = δ then 1 else 0) : Orthonormal ℝ (fun γ => coords (om γ)) := by
  rw [orthonormal_iff_ite]
  intro γ δ
  rw [inner_coords (hom γ) (hom δ), horth]

/-! ## The defect without a presentation -/

/-- **The four-index array of an operator on `Λ²ℝⁿ`**, `⟪φ_kl, X φ_ij⟫`, which is the layer's `comp`. -/
noncomputable def compOf (X : Biv n →ₗ[ℝ] Biv n) (i j k l : Fin n) : ℝ :=
  inner ℝ (coords (phi k l)) (X (coords (phi i j)))

/-- **`‖Alt(X)‖²`** of an operator on `Biv n`, with the layer's `alt4` and `fourNormSq`, so that `δ²(W)` is
`altNormSqOf (g(W))` for `g` the negative part. -/
noncomputable def altNormSqOf (X : Biv n →ₗ[ℝ] Biv n) : ℝ := fourNormSq (alt4 (compOf X))

/-- **The layer's `comp` of a spectral operator is `compOf` of the rank sum.** -/
theorem comp_specOp_eq {r : ℕ} (lam : Fin r → ℝ) {om : Fin r → Matrix (Fin n) (Fin n) ℝ} (hom : ∀ γ, IsSkew (om γ))
    (i j k l : Fin n) :
    comp (specOp lam om) i j k l = compOf (rankSum lam fun γ => coords (om γ)) i j k l := by
  unfold comp compOf
  rw [inner2_specOp, rankSum_apply, inner_sum]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [real_inner_smul_right, inner_coords (hom γ) (phi_isSkew i j), real_inner_comm,
    inner_coords (hom γ) (phi_isSkew k l)]
  ring

/-- **The layer's defect is the presentation-free one**: at an orthonormal skew presentation,
`defectSq λ ω = ‖Alt(g(W))‖²` with `W = ∑ λ_γ ω_γ ω_γᵀ` on `Λ²ℝⁿ` and `g` the negative part. -/
theorem defectSq_eq {N : ℕ} (hN : finrank ℝ (Biv n) = N) {r : ℕ} (lam : Fin r → ℝ)
    {om : Fin r → Matrix (Fin n) (Fin n) ℝ} (hom : ∀ γ, IsSkew (om γ))
    (horth : ∀ γ δ, inner2 (om γ) (om δ) = if γ = δ then 1 else 0) :
    defectSq (ι := Fin n) lam om =
      altNormSqOf (specFn hN negPartScalar (rankSum_isSymmetric lam fun γ => coords (om γ))) := by
  rw [specFn_rankSum hN negPartScalar (by simp [negPartScalar]) lam (orthonormal_coords hom horth)]
  unfold defectSq altNormSq altCoeff altNormSqOf negPartOp
  congr 2
  funext i j k l
  exact comp_specOp_eq _ hom i j k l

/-! ## The chain rule -/

/-- `X ↦ ⟪φ_kl, X φ_ij⟫` as a continuous linear functional. -/
noncomputable def compCLM (i j k l : Fin n) : (Biv n →L[ℝ] Biv n) →L[ℝ] ℝ :=
  (innerSL ℝ (coords (phi k l))).comp (ContinuousLinearMap.apply ℝ (Biv n) (coords (phi i j)))

theorem compCLM_apply (X : Biv n →L[ℝ] Biv n) (i j k l : Fin n) :
    compCLM i j k l X = compOf (X : Biv n →ₗ[ℝ] Biv n) i j k l := rfl

/-- **The chain rule for `‖Alt(·)‖²`**: along a path with one-sided derivative `D`, the defect has one-sided
derivative `2 ⟨Alt(F x), Alt(D)⟩`. -/
theorem hasDerivWithinAt_altNormSqOf {F : ℝ → Biv n →L[ℝ] Biv n} {D : Biv n →L[ℝ] Biv n} {s : Set ℝ} {x : ℝ}
    (hF : HasDerivWithinAt F D s x) :
    HasDerivWithinAt (fun t => altNormSqOf (F t : Biv n →ₗ[ℝ] Biv n))
      (2 * fourInner (alt4 (compOf (F x : Biv n →ₗ[ℝ] Biv n))) (alt4 (compOf (D : Biv n →ₗ[ℝ] Biv n)))) s x := by
  have hc : ∀ i j k l, HasDerivWithinAt (fun t => compOf (F t : Biv n →ₗ[ℝ] Biv n) i j k l)
      (compOf (D : Biv n →ₗ[ℝ] Biv n) i j k l) s x := fun i j k l =>
    (compCLM i j k l).hasFDerivAt.comp_hasDerivWithinAt x hF
  have ha : ∀ i j k l, HasDerivWithinAt (fun t => alt4 (compOf (F t : Biv n →ₗ[ℝ] Biv n)) i j k l)
      (alt4 (compOf (D : Biv n →ₗ[ℝ] Biv n)) i j k l) s x := fun i j k l => by
    unfold alt4
    exact (((hc i j k l).add (hc i k l j)).add (hc i l j k)).const_mul (1 / 3)
  have hsum : HasDerivWithinAt (fun t => (1 / 4 : ℝ) * ∑ i, ∑ j, ∑ k, ∑ l,
        alt4 (compOf (F t : Biv n →ₗ[ℝ] Biv n)) i j k l * alt4 (compOf (F t : Biv n →ₗ[ℝ] Biv n)) i j k l)
      ((1 / 4 : ℝ) * ∑ i, ∑ j, ∑ k, ∑ l,
        (alt4 (compOf (D : Biv n →ₗ[ℝ] Biv n)) i j k l * alt4 (compOf (F x : Biv n →ₗ[ℝ] Biv n)) i j k l +
          alt4 (compOf (F x : Biv n →ₗ[ℝ] Biv n)) i j k l * alt4 (compOf (D : Biv n →ₗ[ℝ] Biv n)) i j k l)) s x := by
    apply HasDerivWithinAt.const_mul
    apply HasDerivWithinAt.fun_sum; intro i _
    apply HasDerivWithinAt.fun_sum; intro j _
    apply HasDerivWithinAt.fun_sum; intro k _
    apply HasDerivWithinAt.fun_sum; intro l _
    exact (ha i j k l).mul (ha i j k l)
  unfold altNormSqOf fourNormSq fourInner
  convert hsum using 1
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by ring

/-! ## The one-sided derivative of the defect -/

/-- **`d⁺δ²(u; H) = 2 ⟨Alt(u₋), Alt(D)⟩`** for symmetric `u`, `H` on `Λ²ℝⁿ`, with
`D = [K, u₋] − ∑_{λ<0} P_λ H P_λ + (P₀ H P₀)₋` the one-sided derivative of the negative part
([NegPartDeriv.lean](NegPartDeriv.lean)). -/
theorem hasDerivWithinAt_defect {N : ℕ} (hN : finrank ℝ (Biv n) = N) {u H : Biv n →ₗ[ℝ] Biv n}
    (hu : u.IsSymmetric) (hH : H.IsSymmetric) (hW : ∀ t : ℝ, (u + t • H).IsSymmetric) :
    HasDerivWithinAt (fun t => altNormSqOf (specFn hN negPartScalar (hW t)))
      (2 * fourInner (alt4 (compOf (specFn hN negPartScalar hu)))
        (alt4 (compOf (rotGen hN hu H ∘ₗ specFn hN negPartScalar hu - specFn hN negPartScalar hu ∘ₗ rotGen hN hu H +
          (-schur hN hu negBlkφ H + specFn hN negPartScalar (schur_isSymmetric hN hu zeroφ_symm hH))))))
      (Set.Ici 0) 0 := by
  have h := hasDerivWithinAt_specFn_negPart hN hu negPartScalar (fun _ hx => negPartScalar_of_nonneg hx.le)
    (fun _ hx => negPartScalar_of_nonpos hx.le) (fun _ x hc => negPartScalar_smul hc x) hH hW
  have h2 := hasDerivWithinAt_altNormSqOf h
  simp only [LinearMap.coe_toContinuousLinearMap] at h2
  have h0 : specFn hN negPartScalar (hW 0) = specFn hN negPartScalar hu := by
    have key : ∀ (T : Biv n →ₗ[ℝ] Biv n) (hT : T.IsSymmetric), T = u →
        specFn hN negPartScalar hT = specFn hN negPartScalar hu := by
      rintro T hT rfl; rfl
    exact key _ _ (by simp)
  rw [h0] at h2
  exact h2

/-- **The same identity at an orthogonal presentation of any common norm**: if `⟨ω_γ, ω_δ⟩ = c [γ = δ]` with
`c > 0`, then `defectSq λ ω = ‖Alt(g(W))‖²` for `W = ∑ (c λ_γ) ŵ_γ ŵ_γᵀ` with `ŵ_γ = ω_γ/√c` orthonormal. *The layer's
own presentations `omCP2` and `omU` have `c = 2`.* -/
theorem defectSq_eq_of_orthogonal {N : ℕ} (hN : finrank ℝ (Biv n) = N) {r : ℕ} (lam : Fin r → ℝ)
    {om : Fin r → Matrix (Fin n) (Fin n) ℝ} (hom : ∀ γ, IsSkew (om γ)) {c : ℝ} (hc : 0 < c)
    (horth : ∀ γ δ, inner2 (om γ) (om δ) = if γ = δ then c else 0) :
    defectSq (ι := Fin n) lam om =
      altNormSqOf (specFn hN negPartScalar
        (rankSum_isSymmetric (fun γ => c * lam γ) fun γ => (Real.sqrt c)⁻¹ • coords (om γ))) := by
  have hsc : Real.sqrt c ^ 2 = c := Real.sq_sqrt hc.le
  have hs0 : Real.sqrt c ≠ 0 := (Real.sqrt_pos.mpr hc).ne'
  have hON : Orthonormal ℝ (fun γ => (Real.sqrt c)⁻¹ • coords (om γ)) := by
    rw [orthonormal_iff_ite]
    intro γ δ
    rw [real_inner_smul_left, real_inner_smul_right, inner_coords (hom γ) (hom δ), horth]
    split_ifs
    · field_simp; rw [hsc]
    · simp
  rw [specFn_rankSum hN negPartScalar (by simp [negPartScalar]) _ hON]
  have hop : rankSum (fun γ => negPartScalar (c * lam γ)) (fun γ => (Real.sqrt c)⁻¹ • coords (om γ)) =
      rankSum (fun γ => negPartScalar (lam γ)) (fun γ => coords (om γ)) := by
    refine LinearMap.ext fun x => ?_
    rw [rankSum_apply, rankSum_apply]
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [negPartScalar_smul hc.le, real_inner_smul_left, smul_smul]
    congr 1
    field_simp
    rw [hsc]
    ring
  rw [hop]
  unfold defectSq altNormSq altCoeff altNormSqOf negPartOp
  congr 2
  funext i j k l
  exact comp_specOp_eq _ hom i j k l

end HamiltonsCubic.BivModel
