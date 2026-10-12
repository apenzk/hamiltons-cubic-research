import HamiltonsCubic.Base.BlockRotation
import HamiltonsCubic.Base.BlockValue

set_option linter.style.longLine false

/-!
# The one-sided derivative of the negative part

The assembly of milestones 2 to 4 of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md).
For `g` the negative part and symmetric `u`, `H` on a finite-dimensional real inner product space,
**`hasDerivWithinAt_specFn_negPart`** proves that `t ↦ g(u + tH)` has right derivative at `t = 0`, in the operator norm,

`d⁺ g(u + tH)|₀ = [K, g(u)] − ∑_{λ<0} P_λ H P_λ + g(P₀ H P₀)`,

with `K` the generator of [Schur.lean](Schur.lean), so that `[K, g(u)]` is the Daleckii–Krein off-diagonal part and
`g(P₀HP₀)` the kink branch on `ker u`. The route: `g(u + tH) = U(t) g(M(t)) U(t)*` (`specFn_eq_conj`), with
`M(t) = u + t H_blk + o(t)` ([BlockRotation.lean](BlockRotation.lean)). The function `g` is `√n`-Lipschitz in the
operator norm (`norm_specFn_sub_le`) and `‖U(t)‖ ≤ 1` (`norm_rot_le`), so `g(M(t)) = g(u + t H_blk) + o(t)`. That last
value is exact for small `t ≥ 0` ([BlockValue.lean](BlockValue.lean)), and `t ↦ U(t)(g(u) + t G₁)U(t)*` is differentiable with derivative the claimed
value.
-/

namespace HamiltonsCubic.SpectralFn

open Module Filter Asymptotics Topology

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-! ## Norms -/

/-- **`‖X‖ ≤ ‖X‖_HS`.** -/
theorem norm_toCLM_le_sqrt_hs (X : E →ₗ[ℝ] E) :
    ‖LinearMap.toContinuousLinearMap X‖ ≤ Real.sqrt (hsSq X) := by
  refine ContinuousLinearMap.opNorm_le_bound _ (Real.sqrt_nonneg _) fun v => ?_
  rw [LinearMap.coe_toContinuousLinearMap']
  have h := norm_apply_sq_le X v
  rw [← Real.sqrt_sq (norm_nonneg (X v)), ← Real.sqrt_sq (norm_nonneg v), ← Real.sqrt_mul (hsSq_nonneg X)]
  exact Real.sqrt_le_sqrt h

/-- **`‖X‖_HS ≤ √n ‖X‖`.** -/
theorem sqrt_hs_le (X : E →ₗ[ℝ] E) :
    Real.sqrt (hsSq X) ≤ Real.sqrt (finrank ℝ E) * ‖LinearMap.toContinuousLinearMap X‖ := by
  have h := hsSq_le_opNorm (LinearMap.toContinuousLinearMap X)
  rw [LinearMap.coe_toContinuousLinearMap] at h
  rw [← Real.sqrt_sq (norm_nonneg (LinearMap.toContinuousLinearMap X)), ← Real.sqrt_mul (Nat.cast_nonneg _)]
  exact Real.sqrt_le_sqrt h

/-- **A `1`-Lipschitz spectral function is `√n`-Lipschitz in the operator norm.** -/
theorem norm_specFn_sub_le {n : ℕ} (hn : finrank ℝ E = n) (g : ℝ → ℝ) (hg : ∀ x y, |g x - g y| ≤ 1 * |x - y|)
    {A B : E →ₗ[ℝ] E} (hA : A.IsSymmetric) (hB : B.IsSymmetric) :
    ‖LinearMap.toContinuousLinearMap (specFn hn g hB - specFn hn g hA)‖ ≤
      Real.sqrt (finrank ℝ E) * ‖LinearMap.toContinuousLinearMap (B - A)‖ := by
  refine (norm_toCLM_le_sqrt_hs _).trans ((Real.sqrt_le_sqrt ?_).trans (sqrt_hs_le _))
  simpa using hsSq_specFn_sub_le hn g hg hA hB

/-! ## The rotation is an isometry -/

/-- **`‖U(t)‖ ≤ 1`** for skew `K`. -/
theorem norm_rot_le {K : E →L[ℝ] E} (hK : star K = -K) (t : ℝ) : ‖rot K t‖ ≤ 1 := by
  refine ContinuousLinearMap.opNorm_le_bound _ zero_le_one fun x => ?_
  have h : inner ℝ (rot K t x) (rot K t x) = inner ℝ x x := by
    rw [← ContinuousLinearMap.adjoint_inner_left, ← ContinuousLinearMap.star_eq_adjoint, star_rot hK,
      ← mul_apply_eq_comp, rot_neg_mul_rot, one_apply_eq_self]
  rw [real_inner_self_eq_norm_sq, real_inner_self_eq_norm_sq] at h
  rw [one_mul]
  exact le_of_eq (by nlinarith [norm_nonneg (rot K t x), norm_nonneg x, sq_nonneg (‖rot K t x‖ - ‖x‖)] : ‖rot K t x‖ = ‖x‖)

/-- **`U(t)* T U(t)` is symmetric for symmetric `T` and skew `K`.** -/
theorem conj_isSymmetric {K : E →L[ℝ] E} (hK : star K = -K) (t : ℝ) {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) :
    ((rot K (-t) : E →ₗ[ℝ] E) ∘ₗ T ∘ₗ (rot K t : E →ₗ[ℝ] E)).IsSymmetric := fun x y => by
  have hadj : ∀ a b : E, inner ℝ (rot K (-t) a) b = inner ℝ a (rot K t b) := fun a b => by
    rw [← star_rot hK, ContinuousLinearMap.star_eq_adjoint, ContinuousLinearMap.adjoint_inner_left]
  have hadj2 : ∀ a b : E, inner ℝ a (rot K (-t) b) = inner ℝ (rot K t a) b := fun a b => by
    rw [real_inner_comm, hadj, real_inner_comm]
  simp only [LinearMap.comp_apply, ContinuousLinearMap.coe_coe]
  rw [hadj, hT, hadj2]

/-- **`g(T) = U(t) g(U(t)* T U(t)) U(t)*`** for skew `K`. -/
theorem specFn_eq_conj {n : ℕ} (hn : finrank ℝ E = n) (g : ℝ → ℝ) {K : E →L[ℝ] E} (hK : star K = -K) (t : ℝ)
    {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) :
    specFn hn g hT = (rot K t : E →ₗ[ℝ] E) ∘ₗ specFn hn g (conj_isSymmetric hK t hT) ∘ₗ (rot K (-t) : E →ₗ[ℝ] E) := by
  have h1 : (rot K t : E →ₗ[ℝ] E) ∘ₗ (rot K (-t) : E →ₗ[ℝ] E) = LinearMap.id := by
    ext x; simp [← mul_apply_eq_comp, rot_mul_rot_neg]
  have h2 : (rot K (-t) : E →ₗ[ℝ] E) ∘ₗ (rot K t : E →ₗ[ℝ] E) = LinearMap.id := by
    ext x; simp [← mul_apply_eq_comp, rot_neg_mul_rot]
  let U : E ≃ₗ[ℝ] E := LinearEquiv.ofLinearMap (rot K t : E →ₗ[ℝ] E) (rot K (-t) : E →ₗ[ℝ] E) h1 h2
  have hc : specFn hn g (conj_isSymmetric hK t hT) =
      (rot K (-t) : E →ₗ[ℝ] E) ∘ₗ specFn hn g hT ∘ₗ (rot K t : E →ₗ[ℝ] E) :=
    specFn_conj hn g hT U (conj_isSymmetric hK t hT)
  rw [hc]
  ext x
  have e1 : ∀ y, rot K t (rot K (-t) y) = y := fun y => LinearMap.congr_fun h1 y
  simp only [LinearMap.comp_apply, ContinuousLinearMap.coe_coe]
  change _ = rot K t (rot K (-t) (specFn hn g hT (rot K t (rot K (-t) x))))
  rw [e1, e1]

/-! ## The one-sided derivative -/

section Main
variable {n : ℕ} (hn : finrank ℝ E = n) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

/-- **The negative part is `1`-Lipschitz.** -/
theorem negPart_lipschitz (g : ℝ → ℝ) (hpos : ∀ x, 0 < x → g x = 0) (hneg : ∀ x, x < 0 → g x = -x)
    (hhom : ∀ c x, 0 ≤ c → g (c * x) = c * g x) : ∀ x y, |g x - g y| ≤ 1 * |x - y| := by
  have hg : ∀ x, g x = max (-x) 0 := fun x => by
    rcases lt_trichotomy x 0 with h | h | h
    · rw [hneg x h, max_eq_left (by linarith)]
    · subst h; simpa using hhom 0 0 le_rfl
    · rw [hpos x h, max_eq_right (by linarith)]
  intro x y
  rw [hg, hg, one_mul]
  calc |max (-x) 0 - max (-y) 0| ≤ |(-x) - (-y)| := abs_max_sub_max_le_abs _ _ _
    _ = |x - y| := by rw [neg_sub_neg, abs_sub_comm]

/-- **The one-sided derivative of the negative part**: for `g` the negative part and symmetric `u`, `H`,
`t ↦ g(u + tH)` has right derivative `[K, g(u)] − ∑_{λ<0} P_λ H P_λ + g(P₀ H P₀)` at `t = 0`, with `K` the generator of
[Schur.lean](Schur.lean) and `[K, g(u)]` the Daleckii–Krein off-diagonal part. -/
theorem hasDerivWithinAt_specFn_negPart (g : ℝ → ℝ) (hpos : ∀ x, 0 < x → g x = 0) (hneg : ∀ x, x < 0 → g x = -x)
    (hhom : ∀ c x, 0 ≤ c → g (c * x) = c * g x) {H : E →ₗ[ℝ] E} (hH : H.IsSymmetric)
    (hW : ∀ t : ℝ, (u + t • H).IsSymmetric) :
    HasDerivWithinAt (fun t => LinearMap.toContinuousLinearMap (specFn hn g (hW t)))
      (LinearMap.toContinuousLinearMap (rotGen hn hu H ∘ₗ specFn hn g hu - specFn hn g hu ∘ₗ rotGen hn hu H +
        (-schur hn hu negBlkφ H + specFn hn g (schur_isSymmetric hn hu zeroφ_symm hH))))
      (Set.Ici 0) 0 := by
  have hK : star (LinearMap.toContinuousLinearMap (rotGen hn hu H)) = -LinearMap.toContinuousLinearMap (rotGen hn hu H) :=
    star_rotGen hn hu hH
  set K' := LinearMap.toContinuousLinearMap (rotGen hn hu H) with hK'
  set G1 := -schur hn hu negBlkφ H + specFn hn g (schur_isSymmetric hn hu zeroφ_symm hH) with hG1
  set gu := specFn hn g hu with hgu
  obtain ⟨t₀, ht₀, hblk⟩ := specFn_blk hn hu g hpos hneg hhom hH
  have hWb : ∀ t : ℝ, (u + t • blkPart hn hu H).IsSymmetric := fun t x y => by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
      real_inner_smul_right, hu x y, blkPart_isSymmetric hn hu hH x y]
  -- the target derivative, in `E →L[ℝ] E`
  set D : E →L[ℝ] E := K' * LinearMap.toContinuousLinearMap gu - LinearMap.toContinuousLinearMap gu * K' +
    LinearMap.toContinuousLinearMap G1 with hD
  have hDeq : LinearMap.toContinuousLinearMap (rotGen hn hu H ∘ₗ gu - gu ∘ₗ rotGen hn hu H + G1) = D := by
    ext x; simp [hD, hK', mul_apply_eq_comp]
  rw [hDeq]
  -- the comparison path `φ(t) = U(t) (g(u) + t G₁) U(t)*`
  set φ : ℝ → E →L[ℝ] E := fun t => rot K' t * (LinearMap.toContinuousLinearMap gu + t • LinearMap.toContinuousLinearMap G1) * rot K' (-t) with hφdef
  have hφ : HasDerivAt φ D 0 := by
    have h1 := hasDerivAt_rot K'
    have h2 : HasDerivAt (fun t : ℝ => LinearMap.toContinuousLinearMap gu + t • LinearMap.toContinuousLinearMap G1)
        (LinearMap.toContinuousLinearMap G1) 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).smul_const (LinearMap.toContinuousLinearMap G1)).const_add
        (LinearMap.toContinuousLinearMap gu)
    have h3 : HasDerivAt (fun t => rot K' (-t)) (-K') 0 := by
      simp_rw [rot_neg]; exact hasDerivAt_rot (-K')
    have := (h1.mul h2).mul h3
    have hval : (K' * (LinearMap.toContinuousLinearMap gu + (0 : ℝ) • LinearMap.toContinuousLinearMap G1) +
        rot K' 0 * LinearMap.toContinuousLinearMap G1) * rot K' (-0) +
        (rot K' * fun t : ℝ => LinearMap.toContinuousLinearMap gu + t • LinearMap.toContinuousLinearMap G1) 0 * -K' = D := by
      simp only [Pi.mul_apply, neg_zero, rot_zero, zero_smul, add_zero, one_mul, mul_one, hD]
      noncomm_ring
    rw [hval] at this
    exact this
  have hφ0 : φ 0 = LinearMap.toContinuousLinearMap gu := by simp [hφdef, rot_zero]
  -- the value at `0`
  have hF0 : LinearMap.toContinuousLinearMap (specFn hn g (hW 0)) = LinearMap.toContinuousLinearMap gu := by
    have : u + (0 : ℝ) • H = u := by simp
    have key : ∀ (T : E →ₗ[ℝ] E) (hT : T.IsSymmetric), T = u → specFn hn g hT = gu := by
      rintro T hT rfl; rfl
    rw [key _ (hW 0) this]
  -- the conjugated path, and its first-order behaviour
  have hMpath : ∀ t : ℝ, LinearMap.toContinuousLinearMap ((rot K' (-t) : E →ₗ[ℝ] E) ∘ₗ (u + t • H) ∘ₗ (rot K' t : E →ₗ[ℝ] E)) =
      conjPath K' (LinearMap.toContinuousLinearMap u) (LinearMap.toContinuousLinearMap H) t := fun t => by
    ext x; simp [conjPath, mul_apply_eq_comp]
  have hM := (hasDerivAt_conjPath_blk hn hu H).isLittleO
  have hM0 : conjPath K' (LinearMap.toContinuousLinearMap u) (LinearMap.toContinuousLinearMap H) 0 = LinearMap.toContinuousLinearMap u := by
    simp [conjPath, rot_zero]
  rw [hM0] at hM
  -- the first term is `O` of the conjugated path's remainder
  set R : ℝ → E →L[ℝ] E := fun t => rot K' t * LinearMap.toContinuousLinearMap
      (specFn hn g (conj_isSymmetric hK t (hW t)) - specFn hn g (hWb t)) * rot K' (-t) with hR
  have hRbound : ∀ t : ℝ, ‖R t‖ ≤ Real.sqrt (finrank ℝ E) *
      ‖conjPath K' (LinearMap.toContinuousLinearMap u) (LinearMap.toContinuousLinearMap H) t -
        LinearMap.toContinuousLinearMap u - (t - 0) • LinearMap.toContinuousLinearMap (blkPart hn hu H)‖ := fun t => by
    have hL := norm_specFn_sub_le hn g (negPart_lipschitz g hpos hneg hhom) (hWb t) (conj_isSymmetric hK t (hW t))
    have hdiff : LinearMap.toContinuousLinearMap ((rot K' (-t) : E →ₗ[ℝ] E) ∘ₗ (u + t • H) ∘ₗ (rot K' t : E →ₗ[ℝ] E) -
        (u + t • blkPart hn hu H)) = conjPath K' (LinearMap.toContinuousLinearMap u) (LinearMap.toContinuousLinearMap H) t -
        LinearMap.toContinuousLinearMap u - (t - 0) • LinearMap.toContinuousLinearMap (blkPart hn hu H) := by
      rw [map_sub, hMpath, map_add, map_smul, sub_zero]; abel
    rw [hdiff] at hL
    calc ‖R t‖ ≤ ‖rot K' t‖ * ‖LinearMap.toContinuousLinearMap
          (specFn hn g (conj_isSymmetric hK t (hW t)) - specFn hn g (hWb t))‖ * ‖rot K' (-t)‖ := by
          rw [hR]; exact (norm_mul_le _ _).trans (mul_le_mul_of_nonneg_right (norm_mul_le _ _) (norm_nonneg _))
      _ ≤ 1 * ‖LinearMap.toContinuousLinearMap
          (specFn hn g (conj_isSymmetric hK t (hW t)) - specFn hn g (hWb t))‖ * 1 := by
          gcongr
          · exact norm_rot_le hK t
          · exact norm_rot_le hK (-t)
      _ ≤ _ := by rw [one_mul, mul_one]; exact hL
  have hRo : R =o[𝓝 0] fun t => t - 0 :=
    (IsBigO.of_bound (Real.sqrt (finrank ℝ E)) (Eventually.of_forall hRbound)).trans_isLittleO hM
  -- the decomposition on `[0, t₀]`
  have hdec : ∀ t : ℝ, 0 ≤ t → t ≤ t₀ →
      LinearMap.toContinuousLinearMap (specFn hn g (hW t)) - LinearMap.toContinuousLinearMap (specFn hn g (hW 0)) - (t - 0) • D =
        R t + (φ t - φ 0 - (t - 0) • D) := fun t ht0 ht => by
    have hb := hblk t ht0 ht (hWb t)
    rw [specFn_eq_conj hn g hK t (hW t), hF0, hφ0, hR, hφdef]
    simp only
    rw [map_sub, hb, map_add, map_smul]
    have hc : LinearMap.toContinuousLinearMap ((rot K' t : E →ₗ[ℝ] E) ∘ₗ specFn hn g (conj_isSymmetric hK t (hW t)) ∘ₗ
        (rot K' (-t) : E →ₗ[ℝ] E)) = rot K' t * LinearMap.toContinuousLinearMap (specFn hn g (conj_isSymmetric hK t (hW t))) * rot K' (-t) := by
      ext x; simp [mul_apply_eq_comp]
    rw [hc]
    noncomm_ring
  rw [hasDerivWithinAt_iff_isLittleO]
  have hev : ∀ᶠ t in 𝓝[Set.Ici 0] (0 : ℝ), 0 ≤ t ∧ t ≤ t₀ := by
    filter_upwards [self_mem_nhdsWithin, nhdsWithin_le_nhds (Iic_mem_nhds ht₀)] with t h1 h2
    exact ⟨h1, h2⟩
  refine IsLittleO.congr' ((hRo.add hφ.isLittleO).mono nhdsWithin_le_nhds) ?_ EventuallyEq.rfl
  filter_upwards [hev] with t ht
  exact (hdec t ht.1 ht.2).symm

end Main

end HamiltonsCubic.SpectralFn
