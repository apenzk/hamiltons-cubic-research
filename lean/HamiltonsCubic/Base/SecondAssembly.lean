import HamiltonsCubic.Base.Exp2

set_option linter.style.longLine false

/-!
# The negative part to second order: assembly

Milestone 4 of [the second-order plan](../../../reviews/2026-09-26-lean-second-order-plan.md). **`exp2_negPart_path`**:
along any path of symmetric operators `W(t) = u + tH + t²G + o(t²)` with `H`, `G` symmetric, the negative part has a
one-sided second-order expansion, `g(W(t)) = g(u) + t A₁ + t² A₂ + o(t²)` as `t → 0⁺`. The record takes this expansion
from Rellich's theorem, which gives analytic branches and an `O(t³)` remainder. L134(b) uses only the `o(t²)` form,
which this proves without Rellich.

The route:
- rotate by `R(t) = exp(tK) exp(t²K₂)`. `K` is the generator of [Schur.lean](Schur.lean) for `H`, and `K₂` is the
  one for the self-adjoint `t²` coefficient `M₂` (`star_M2`). The rotated path is then
  `u + t H_blk + t² (M₂)_blk + o(t²)` (`exp2_conj`, `commutator_toCLM`);
- compare with the exact block path `u + t (H + tM₂)_blk`, whose negative part expands by `exp2_negPart_blk`. That
  expansion rests on [SecondOrder.lean](SecondOrder.lean)'s uniform block value and on the first-order theorem of
  [NegPartDeriv.lean](NegPartDeriv.lean) applied at the kernel block;
- carry the `o(t²)` difference through the `√n`-Lipschitz bound (`norm_specFn_sub_le`), and conjugate back
  (`specFn_eq_conj_gen`, `prodRot_unitary`).
-/

namespace HamiltonsCubic.SpectralFn

open Module Asymptotics Filter Topology

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-! ## Helpers -/

/-- **`M₂` is self-adjoint** when `K` is skew and `u`, `H`, `G` are self-adjoint. -/
theorem star_M2 {K u H G : E →L[ℝ] E} (hK : star K = -K) (hu : star u = u) (hH : star H = H) (hG : star G = G) :
    star (M2 K u H G) = M2 K u H G := by
  unfold M2
  simp only [star_sub, star_add, star_smul, star_mul, hK, hu, hH, hG, star_trivial, neg_mul, mul_neg, neg_neg]
  simp only [mul_assoc]
  abel

/-- **The product rotation is orthogonal**: `R(t)* R(t) = 1 = R(t) R(t)*` for `R(t) = exp(tK) exp(t²K₂)`. -/
theorem prodRot_unitary (K K₂ : E →L[ℝ] E) (t : ℝ) :
    (rot (-K₂) (t ^ 2) * rot (-K) t) * (rot K t * rot K₂ (t ^ 2)) = 1 ∧
      (rot K t * rot K₂ (t ^ 2)) * (rot (-K₂) (t ^ 2) * rot (-K) t) = 1 := by
  have a1 : rot (-K) t * rot K t = 1 := by rw [← rot_neg, rot_neg_mul_rot]
  have a2 : rot (-K₂) (t ^ 2) * rot K₂ (t ^ 2) = 1 := by rw [← rot_neg, rot_neg_mul_rot]
  have b1 : rot K t * rot (-K) t = 1 := by rw [← rot_neg, rot_mul_rot_neg]
  have b2 : rot K₂ (t ^ 2) * rot (-K₂) (t ^ 2) = 1 := by rw [← rot_neg, rot_mul_rot_neg]
  constructor
  · calc _ = rot (-K₂) (t ^ 2) * (rot (-K) t * rot K t) * rot K₂ (t ^ 2) := by noncomm_ring
      _ = 1 := by rw [a1, mul_one, a2]
  · calc _ = rot K t * (rot K₂ (t ^ 2) * rot (-K₂) (t ^ 2)) * rot (-K) t := by noncomm_ring
      _ = 1 := by rw [b2, mul_one, b1]

omit [FiniteDimensional ℝ E] in
/-- **A one-sided derivative gives a second-order expansion of `t f(t)`**: `t f(t) = t f(0) + t² f′ + o(t²)`. -/
theorem exp2_of_hasDerivWithinAt {f : ℝ → E →L[ℝ] E} {f' : E →L[ℝ] E} (hf : HasDerivWithinAt f f' (Set.Ici 0) 0) :
    Exp2 (fun t => t • f t) 0 (f 0) f' := by
  have h := hf.isLittleO
  unfold Exp2
  have h2 := (isBigO_refl (fun t : ℝ => t) (𝓝[Set.Ici 0] 0)).smul_isLittleO h
  refine (h2.congr_right fun t => by simp [pow_two]).congr_left fun t => ?_
  simp only [sub_zero, zero_add, smul_sub, smul_smul, pow_two]
  abel

/-- `g(T)` depends only on `T`. -/
theorem specFn_congr_op {N : ℕ} (hN : finrank ℝ E = N) (g : ℝ → ℝ) {T T' : E →ₗ[ℝ] E} (hT : T.IsSymmetric)
    (hT' : T'.IsSymmetric) (h : T = T') : specFn hN g hT = specFn hN g hT' := by
  subst h; rfl

/-- **Conjugation by an orthogonal `R`**: if `S R = 1 = R S` and `S T R` is symmetric, then `g(T) = R g(S T R) S`. -/
theorem specFn_eq_conj_gen {N : ℕ} (hN : finrank ℝ E = N) (g : ℝ → ℝ) {R S : E →L[ℝ] E} (hSR : S * R = 1)
    (hRS : R * S = 1) {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric)
    (hM : ((S : E →ₗ[ℝ] E) ∘ₗ T ∘ₗ (R : E →ₗ[ℝ] E)).IsSymmetric) :
    specFn hN g hT = (R : E →ₗ[ℝ] E) ∘ₗ specFn hN g hM ∘ₗ (S : E →ₗ[ℝ] E) := by
  have h1 : (R : E →ₗ[ℝ] E) ∘ₗ (S : E →ₗ[ℝ] E) = LinearMap.id := by
    ext x; simp [← mul_apply_eq_comp, hRS]
  have h2 : (S : E →ₗ[ℝ] E) ∘ₗ (R : E →ₗ[ℝ] E) = LinearMap.id := by
    ext x; simp [← mul_apply_eq_comp, hSR]
  let U : E ≃ₗ[ℝ] E := LinearEquiv.ofLinearMap (R : E →ₗ[ℝ] E) (S : E →ₗ[ℝ] E) h1 h2
  have hc : specFn hN g hM = (S : E →ₗ[ℝ] E) ∘ₗ specFn hN g hT ∘ₗ (R : E →ₗ[ℝ] E) :=
    specFn_conj hN g hT U hM
  rw [hc]
  ext x
  have e1 : ∀ y, R (S y) = y := fun y => LinearMap.congr_fun h1 y
  simp only [LinearMap.comp_apply, ContinuousLinearMap.coe_coe]
  rw [e1, e1]

/-! ## Expansion helpers -/

theorem Exp2.congr_ev {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] {f g : ℝ → 𝔸} {a b c : 𝔸} (hf : Exp2 f a b c)
    (h : ∀ᶠ t in 𝓝[Set.Ici 0] 0, f t = g t) : Exp2 g a b c := by
  unfold Exp2 at *
  exact hf.congr' (h.mono fun t ht => by change f t - _ = g t - _; rw [ht]) EventuallyEq.rfl

/-- **An `o(t²)` perturbation keeps the expansion.** -/
theorem Exp2.of_sub {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] {f g : ℝ → 𝔸} {a b c : 𝔸} (hg : Exp2 g a b c)
    (h : (fun t => f t - g t) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2) : Exp2 f a b c := by
  unfold Exp2 at *
  exact (h.add hg).congr_left fun t => by abel

theorem Exp2.poly {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] (a b c : 𝔸) :
    Exp2 (fun t => a + t • b + t ^ 2 • c) a b c := by
  unfold Exp2; simp only [sub_self]; exact isLittleO_zero _ _

/-! ## Step 1: `g` along `u + t (H + tH₂)_blk` -/

section Step1
variable {N : ℕ} (hN : finrank ℝ E = N) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

theorem exp2_negPart_blk (g : ℝ → ℝ) (hpos : ∀ x, 0 < x → g x = 0) (hneg : ∀ x, x < 0 → g x = -x)
    (hhom : ∀ c x, 0 ≤ c → g (c * x) = c * g x) {H H₂ : E →ₗ[ℝ] E} (hH : H.IsSymmetric) (hH₂ : H₂.IsSymmetric)
    (hP : ∀ t : ℝ, (u + t • blkPart hN hu (H + t • H₂)).IsSymmetric) :
    ∃ b c : E →L[ℝ] E, Exp2 (fun t => LinearMap.toContinuousLinearMap (specFn hN g (hP t)))
      (LinearMap.toContinuousLinearMap (specFn hN g hu)) b c := by
  obtain ⟨t₀, ht₀, hblk⟩ := specFn_blk_family hN hu g hpos hneg hhom H H₂
  have hHt : ∀ t : ℝ, (H + t • H₂).IsSymmetric := fun t x y => by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
      real_inner_smul_right, hH x y, hH₂ x y]
  have hD := schur_isSymmetric hN hu zeroφ_symm hH
  have hD₂ := schur_isSymmetric hN hu zeroφ_symm hH₂
  have hDt : ∀ t : ℝ, (schur hN hu zeroφ H + t • schur hN hu zeroφ H₂).IsSymmetric := fun t x y => by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
      real_inner_smul_right, hD x y, hD₂ x y]
  obtain ⟨Dd, hder⟩ : ∃ Dd : E →L[ℝ] E, HasDerivWithinAt
      (fun t => LinearMap.toContinuousLinearMap (specFn hN g (hDt t))) Dd (Set.Ici 0) 0 :=
    ⟨_, hasDerivWithinAt_specFn_negPart hN hD g hpos hneg hhom hD₂ hDt⟩
  have hE := exp2_of_hasDerivWithinAt hder
  have hsum := (Exp2.poly (LinearMap.toContinuousLinearMap (specFn hN g hu))
    (-LinearMap.toContinuousLinearMap (schur hN hu negBlkφ H))
    (-LinearMap.toContinuousLinearMap (schur hN hu negBlkφ H₂))).add hE
  simp only [add_zero] at hsum
  refine ⟨_, _, hsum.congr_ev ?_⟩
  have hev : ∀ᶠ t in 𝓝[Set.Ici 0] (0 : ℝ), 0 ≤ t ∧ t ≤ t₀ := by
    filter_upwards [self_mem_nhdsWithin, nhdsWithin_le_nhds (Iic_mem_nhds ht₀)] with t h1 h2
    exact ⟨h1, h2⟩
  filter_upwards [hev] with t ht
  rw [hblk t ht.1 ht.2 (hHt t) (hP t)]
  have hsame : specFn hN g (schur_isSymmetric hN hu zeroφ_symm (hHt t)) = specFn hN g (hDt t) :=
    specFn_congr_op hN g _ _ (by rw [schur_add_op, schur_smul_op])
  rw [hsame, schur_add_op, schur_smul_op]
  simp only [map_add, map_smul, map_neg, smul_add, smul_neg, smul_smul, pow_two]
  abel

/-- A symmetric operator's continuous version is self-adjoint. -/
theorem star_toCLM {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) :
    star (LinearMap.toContinuousLinearMap T) = LinearMap.toContinuousLinearMap T := by
  rw [ContinuousLinearMap.star_eq_adjoint, eq_comm, ContinuousLinearMap.eq_adjoint_iff]
  intro x y; simp only [LinearMap.coe_toContinuousLinearMap']; exact hT x y

/-- A self-adjoint continuous operator is symmetric as a linear map. -/
theorem isSymmetric_of_star {T : E →L[ℝ] E} (hT : star T = T) : (T : E →ₗ[ℝ] E).IsSymmetric := fun x y => by
  simp only [ContinuousLinearMap.coe_coe]
  rw [← ContinuousLinearMap.adjoint_inner_right, ← ContinuousLinearMap.star_eq_adjoint, hT]

/-- `[K, u] = H − H_blk` in `E →L[ℝ] E`, for `K` the generator of [Schur.lean](Schur.lean). -/
theorem commutator_toCLM (H : E →ₗ[ℝ] E) :
    LinearMap.toContinuousLinearMap H - (LinearMap.toContinuousLinearMap (rotGen hN hu H) *
      LinearMap.toContinuousLinearMap u - LinearMap.toContinuousLinearMap u * LinearMap.toContinuousLinearMap (rotGen hN hu H)) =
    LinearMap.toContinuousLinearMap (blkPart hN hu H) := by
  ext x
  have := LinearMap.congr_fun (rotGen_commutator hN hu H) x
  simp only [LinearMap.sub_apply, LinearMap.comp_apply] at this
  simp only [sub_apply, mul_apply_eq_comp, LinearMap.coe_toContinuousLinearMap']
  rw [this]; abel

end Step1

/-! ## Milestone 4: the negative part along a path, to second order -/

section Assembly
variable {N : ℕ} (hN : finrank ℝ E = N) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

/-- **The negative part to second order.** Along any path of symmetric operators with
`W(t) = u + tH + t²G + o(t²)` and `H`, `G` symmetric, `g(W(t)) = g(u) + t A₁ + t² A₂ + o(t²)` as `t → 0⁺`. -/
theorem exp2_negPart_path (g : ℝ → ℝ) (hpos : ∀ x, 0 < x → g x = 0) (hneg : ∀ x, x < 0 → g x = -x)
    (hhom : ∀ c x, 0 ≤ c → g (c * x) = c * g x) {H G : E →ₗ[ℝ] E} (hH : H.IsSymmetric) (hG : G.IsSymmetric)
    {W : ℝ → E →ₗ[ℝ] E} (hWs : ∀ t, (W t).IsSymmetric)
    (hW : Exp2 (fun t => LinearMap.toContinuousLinearMap (W t)) (LinearMap.toContinuousLinearMap u)
      (LinearMap.toContinuousLinearMap H) (LinearMap.toContinuousLinearMap G)) :
    ∃ A₁ A₂ : E →L[ℝ] E, Exp2 (fun t => LinearMap.toContinuousLinearMap (specFn hN g (hWs t)))
      (LinearMap.toContinuousLinearMap (specFn hN g hu)) A₁ A₂ := by
  set u' := LinearMap.toContinuousLinearMap u
  -- the first rotation
  set K := LinearMap.toContinuousLinearMap (rotGen hN hu H) with hKdef
  have hK : star K = -K := star_rotGen hN hu hH
  -- the second-order coefficient, and the second rotation
  set M₂ := M2 K u' (LinearMap.toContinuousLinearMap H) (LinearMap.toContinuousLinearMap G) with hM₂def
  have hM₂s : star M₂ = M₂ := star_M2 hK (star_toCLM hu) (star_toCLM hH) (star_toCLM hG)
  have hM₂ : (M₂ : E →ₗ[ℝ] E).IsSymmetric := isSymmetric_of_star hM₂s
  set K₂ := LinearMap.toContinuousLinearMap (rotGen hN hu (M₂ : E →ₗ[ℝ] E)) with hK₂def
  have hK₂ : star K₂ = -K₂ := star_rotGen hN hu hM₂
  -- the rotation R(t) and its inverse S(t)
  set R : ℝ → E →L[ℝ] E := fun t => rot K t * rot K₂ (t ^ 2) with hRdef
  set Sr : ℝ → E →L[ℝ] E := fun t => rot (-K₂) (t ^ 2) * rot (-K) t with hSdef
  have hSR : ∀ t, Sr t * R t = 1 := fun t => (prodRot_unitary K K₂ t).1
  have hRS : ∀ t, R t * Sr t = 1 := fun t => (prodRot_unitary K K₂ t).2
  have hstar : ∀ t, star (R t) = Sr t := fun t => by
    have hK' : star (-K) = -(-K) := by rw [star_neg, hK]
    have hK₂' : star (-K₂) = -(-K₂) := by rw [star_neg, hK₂]
    simp only [hRdef, hSdef, star_mul, star_rot hK, star_rot hK₂, rot_neg]
  -- the rotated path is symmetric
  have hNs : ∀ t, ((Sr t : E →ₗ[ℝ] E) ∘ₗ W t ∘ₗ (R t : E →ₗ[ℝ] E)).IsSymmetric := fun t x y => by
    have hadj : ∀ a b : E, inner ℝ (Sr t a) b = inner ℝ a (R t b) := fun a b => by
      rw [← hstar, ContinuousLinearMap.star_eq_adjoint, ContinuousLinearMap.adjoint_inner_left]
    have hadj2 : ∀ a b : E, inner ℝ a (Sr t b) = inner ℝ (R t a) b := fun a b => by
      rw [real_inner_comm, hadj, real_inner_comm]
    simp only [LinearMap.comp_apply, ContinuousLinearMap.coe_coe]
    rw [hadj, hWs, hadj2]
  -- g(W) = R g(N) S
  have hconj : ∀ t, specFn hN g (hWs t) = (R t : E →ₗ[ℝ] E) ∘ₗ specFn hN g (hNs t) ∘ₗ (Sr t : E →ₗ[ℝ] E) :=
    fun t => specFn_eq_conj_gen hN g (hSR t) (hRS t) (hWs t) (hNs t)
  -- the rotated path to second order, with block-diagonal coefficients
  have hN2 := exp2_conj K K₂ hW
  rw [commutator_toCLM hN hu H] at hN2
  have hc2 : M₂ - (K₂ * u' - u' * K₂) = LinearMap.toContinuousLinearMap (blkPart hN hu (M₂ : E →ₗ[ℝ] E)) := by
    have := commutator_toCLM hN hu (M₂ : E →ₗ[ℝ] E)
    rwa [show LinearMap.toContinuousLinearMap (M₂ : E →ₗ[ℝ] E) = M₂ from rfl] at this
  rw [hc2] at hN2
  -- the exact block path P(t) = u + t (H + tM₂)_blk
  have hPs : ∀ t : ℝ, (u + t • blkPart hN hu (H + t • (M₂ : E →ₗ[ℝ] E))).IsSymmetric := fun t x y => by
    have hb := blkPart_isSymmetric hN hu (H := H + t • (M₂ : E →ₗ[ℝ] E)) (fun a b => by
      simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
        real_inner_smul_right, hH a b, hM₂ a b])
    simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
      real_inner_smul_right, hu x y, hb x y]
  obtain ⟨b, c, hgP⟩ := exp2_negPart_blk hN hu g hpos hneg hhom hH hM₂ hPs
  -- the rotated path differs from it by o(t²)
  have hdiff : (fun t => LinearMap.toContinuousLinearMap ((Sr t : E →ₗ[ℝ] E) ∘ₗ W t ∘ₗ (R t : E →ₗ[ℝ] E)) -
      LinearMap.toContinuousLinearMap (u + t • blkPart hN hu (H + t • (M₂ : E →ₗ[ℝ] E)))) =o[𝓝[Set.Ici 0] 0]
      fun t => t ^ 2 := by
    refine hN2.congr_left fun t => ?_
    have e1 : LinearMap.toContinuousLinearMap ((Sr t : E →ₗ[ℝ] E) ∘ₗ W t ∘ₗ (R t : E →ₗ[ℝ] E)) =
        Sr t * LinearMap.toContinuousLinearMap (W t) * R t := by ext x; simp [mul_apply_eq_comp]
    have e2 : LinearMap.toContinuousLinearMap (u + t • blkPart hN hu (H + t • (M₂ : E →ₗ[ℝ] E))) =
        u' + t • LinearMap.toContinuousLinearMap (blkPart hN hu H) +
          t ^ 2 • LinearMap.toContinuousLinearMap (blkPart hN hu (M₂ : E →ₗ[ℝ] E)) := by
      unfold blkPart
      rw [schur_add_op, schur_smul_op, map_add, map_smul, map_add, map_smul, smul_add, smul_smul, pow_two]
      abel
    rw [e1, e2]
  -- so g of the rotated path has the same expansion
  have hlip := negPart_lipschitz g hpos hneg hhom
  have hgN : Exp2 (fun t => LinearMap.toContinuousLinearMap (specFn hN g (hNs t)))
      (LinearMap.toContinuousLinearMap (specFn hN g hu)) b c := by
    refine hgP.of_sub ((IsBigO.of_bound (Real.sqrt (finrank ℝ E)) (Eventually.of_forall fun t => ?_)).trans_isLittleO hdiff)
    rw [← map_sub, ← map_sub]
    exact norm_specFn_sub_le hN g hlip (hPs t) (hNs t)
  -- conjugate back
  have hRe := (exp2_rot K).mul (exp2_rot_sq K₂)
  have hSe := (exp2_rot_sq (-K₂)).mul (exp2_rot (-K))
  have hfin := (hRe.mul hgN).mul hSe
  simp only [one_mul, mul_one] at hfin
  refine ⟨_, _, hfin.congr_ev (Eventually.of_forall fun t => ?_)⟩
  rw [hconj t]
  ext x; simp [mul_apply_eq_comp, hRdef, hSdef]

end Assembly


end HamiltonsCubic.SpectralFn
