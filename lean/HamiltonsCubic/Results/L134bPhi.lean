import HamiltonsCubic.Results.L134b
import HamiltonsCubic.Results.L17Converse
import HamiltonsCubic.Results.L24Hess

set_option linter.style.longLine false

/-!
# L134(b)'s display: `Φ` to second order along the great circle

[route-a.md](../../../findings/route-a.md), Lemma L134(b): on the great circle `cos t · u + sin t · H` through the padded
`ℂP²` competitor, `Φ = P − κ δ²` expands as `θ₀ + d₁ t + [½ Hess(P|_S)[H, H] − κ c₂] t² + o(t²)` for `t → 0⁺`, and on
`{F = 0}` the first coefficient vanishes.

- `coeff_eq_zero_of_isLittleO`, `Exp2.first`, `Exp2.at_zero`, **`Exp2.first_eq_deriv`**: a one-sided expansion's first
  coefficient is the one-sided derivative;
- `c1Of`, `exp2_altNormSqOf'`: `δ²`'s expansion with its first coefficient named;
- **`Exp2.first_unique`**, `Exp2.sub_isBigO`: two operator paths that differ by `O(t²)` share their first coefficient;
- **`L134b_first`**: `δ²` along the great circle has first coefficient `dLine`, `δ²`'s one-sided derivative along the line
  `u + tH` from [L17Deriv.lean](L17Deriv.lean). The circle and the line agree to first order, and the negative part is
  `√N`-Lipschitz (`norm_specFn_sub_le`), so their negative parts differ by `O(t²)`;
- `exp2_P_circle`: `P` along the circle is exact, from [L24Hess.lean](L24Hess.lean)'s `Pcubic2_circle`;
- `opB_smul_add`, `opB_circle`: the circle in `CurvOp2` is the circle `cos t · uOp + sin t · opB H` in the bivector model;
- **`L134b_Phi`**: the display. Its first coefficient `−κ · dLine(opB H)` is `2aκF(H)`, [L17Phi.lean](L17Phi.lean)'s
  derivative, and its `t²` coefficient is `3⟨u, Q(H)⟩ − (3/2) P(u) − κ c₂`, where `3⟨u, Q(H)⟩ − (3/2) P(u)` is
  `½ Hess(P|_S)_u[H, H]` for unit tangent `H` (`L24Hess.lean`'s `L24_hessian_Le`). At other norms the Hessian term
  is `3⟨u, Q(H)⟩ − (3/2) P(u) ‖H‖²`.

(b)'s inequality additionally needs (a)'s bound `½ Hess ≤ −θ*/2` on the orthogonal complement of the orbit's tangent space,
which this file does not prove.
-/

namespace HamiltonsCubic.L17Deriv

open Module Asymptotics Filter Topology HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel HamiltonsCubic.AltLayer
  HamiltonsCubic.RealLayer

variable {n : ℕ}

/-- **A first-order coefficient is unique**: `c t = o(t)` as `t → 0⁺` forces `c = 0`. -/
theorem coeff_eq_zero_of_isLittleO {c : ℝ} (h : (fun t : ℝ => c * t) =o[𝓝[Set.Ici 0] 0] fun t => t) : c = 0 := by
  by_contra hc
  have hc' : 0 < |c| := abs_pos.mpr hc
  have h1 := h.def (c := |c| / 2) (half_pos hc')
  have hne : (𝓝[Set.Ioi (0 : ℝ)] 0).NeBot := inferInstance
  obtain ⟨t, ht, ht0⟩ := ((h1.filter_mono (nhdsWithin_mono _ Set.Ioi_subset_Ici_self)).and
    self_mem_nhdsWithin).exists
  rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_mul, abs_of_pos ht0] at ht
  have : |c| * t ≤ |c| / 2 * t := ht
  nlinarith

/-- An `Exp2` expansion's first coefficient is the one-sided derivative's first-order term. -/
theorem Exp2.first {f : ℝ → ℝ} {a b c : ℝ} (hf : Exp2 f a b c) :
    (fun t => f t - (a + t * b)) =o[𝓝[Set.Ici 0] 0] fun t => t := by
  unfold Exp2 at hf
  have hp : (fun t : ℝ => t ^ 2) =o[𝓝[Set.Ici 0] 0] fun t => t :=
    ((isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 1 < 2)).mono nhdsWithin_le_nhds).congr_right fun t => pow_one t
  have h2 : (fun t : ℝ => t ^ 2 * c) =o[𝓝[Set.Ici 0] 0] fun t => t * 1 :=
    hp.mul_isBigO (isBigO_const_const c (one_ne_zero : (1:ℝ) ≠ 0) _)
  refine ((hf.trans hp).add (h2.congr_right fun t => mul_one t)).congr_left fun t => ?_
  simp only [smul_eq_mul]; ring

/-- The first coefficient of `‖Alt(a + tb + …)‖²`. -/
noncomputable def c1Of (a b : Biv n →L[ℝ] Biv n) : ℝ :=
  (1 / 4 : ℝ) * ∑ i, ∑ j, ∑ k, ∑ l, (altCLM i j k l a * altCLM i j k l b + altCLM i j k l b * altCLM i j k l a)

/-- **`‖Alt(·)‖²` with its first coefficient named.** -/
theorem exp2_altNormSqOf' {F : ℝ → Biv n →L[ℝ] Biv n} {a b c : Biv n →L[ℝ] Biv n} (hF : Exp2 F a b c) :
    ∃ c₂ : ℝ, Exp2 (fun t => altNormSqOf (F t : Biv n →ₗ[ℝ] Biv n)) (altNormSqOf (a : Biv n →ₗ[ℝ] Biv n))
      (c1Of a b) c₂ := by
  have he : ∀ i j k l : Fin n, Exp2 (fun t => altCLM i j k l (F t) * altCLM i j k l (F t))
      (altCLM i j k l a * altCLM i j k l a) _ _ := fun i j k l =>
    (hF.map (altCLM i j k l)).mul (hF.map (altCLM i j k l))
  have hs := (Exp2.sum Finset.univ fun i _ => Exp2.sum Finset.univ fun j _ => Exp2.sum Finset.univ fun k _ =>
    Exp2.sum Finset.univ fun l _ => he i j k l).smul (1 / 4 : ℝ)
  refine ⟨_, Exp2.coeff (Exp2.congr_ev hs (Eventually.of_forall fun t => ?_)) ?_ ?_ rfl⟩
  · simp only [altNormSqOf_eq, smul_eq_mul]
  · simp only [altNormSqOf_eq, smul_eq_mul]
  · simp only [c1Of, smul_eq_mul]

/-- **Two expansions whose functions differ by `O(t²)` share their first coefficient.** -/
theorem Exp2.first_unique {f g : ℝ → Biv n →L[ℝ] Biv n} {a b c b' c' : Biv n →L[ℝ] Biv n}
    (hf : Exp2 f a b c) (hg : Exp2 g a b' c')
    (hfg : (fun t => f t - g t) =O[𝓝[Set.Ici 0] 0] fun t => t ^ 2) : b = b' := by
  unfold Exp2 at hf hg
  have hp : (fun t : ℝ => t ^ 2) =o[𝓝[Set.Ici 0] 0] fun t => t :=
    ((isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 1 < 2)).mono nhdsWithin_le_nhds).congr_right fun t => pow_one t
  have t3 : (fun t : ℝ => t ^ 2 • (c - c')) =o[𝓝[Set.Ici 0] 0] fun t => t :=
    (IsLittleO.smul_isBigO hp (isBigO_const_const (c - c') (one_ne_zero : (1:ℝ) ≠ 0) _)).congr_right
      fun t => by rw [smul_eq_mul, mul_one]
  have hd : (fun t : ℝ => t • (b - b')) =o[𝓝[Set.Ici 0] 0] fun t => t := by
    refine (((hfg.trans_isLittleO hp).sub ((hf.sub hg).trans hp)).sub t3).congr_left fun t => ?_
    simp only [smul_sub]; abel
  have hn := hd.norm_left
  have hs : (fun t : ℝ => ‖b - b'‖ * t) =o[𝓝[Set.Ici 0] 0] fun t => t := by
    refine (hn.congr' ?_ EventuallyEq.rfl)
    filter_upwards [self_mem_nhdsWithin] with t ht
    rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg ht, mul_comm]
  exact sub_eq_zero.mp (norm_eq_zero.mp (coeff_eq_zero_of_isLittleO hs))

theorem opB_smul_add (c s : ℝ) (R S : CurvOp2 (Fin n)) : opB (c • R + s • S) = c • opB R + s • opB S := by
  refine LinearMap.ext fun x => ?_
  simp only [opB_apply, LinearMap.add_apply, LinearMap.smul_apply, add_apply, smul_apply, Submodule.coe_add,
    Submodule.coe_smul, ← coordsL_apply, map_add, map_smul]

/-- **Two expansions with the same `a`, `b` differ by `O(t²)`.** -/
theorem Exp2.sub_isBigO {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] {f g : ℝ → 𝔸} {a b c c' : 𝔸}
    (hf : Exp2 f a b c) (hg : Exp2 g a b c') : (fun t => f t - g t) =O[𝓝[Set.Ici 0] 0] fun t => t ^ 2 := by
  unfold Exp2 at hf hg
  have h3 : (fun t : ℝ => t ^ 2 • (c - c')) =O[𝓝[Set.Ici 0] 0] fun t => t ^ 2 :=
    (isBigO_refl (fun t : ℝ => t ^ 2) _).smul (isBigO_const_const (c - c') (one_ne_zero : (1:ℝ) ≠ 0) _)
      |>.congr_right fun t => by rw [smul_eq_mul, mul_one]
  refine ((hf.sub hg).isBigO.add h3).congr_left fun t => ?_
  simp only [smul_sub]; abel

/-- **`P` along the great circle**: `P(cos t · u + sin t · H) = θ + t²(3B − (3/2)θ) + o(t²)` for tangent Weyl `H`,
`B = ⟨u, Q(H)⟩`. -/
theorem exp2_P_circle (hn : 4 ≤ n) {H : CurvOp2 (Fin n)} (hH : IsWeyl2 H) (hT : innerOp2 H (u2 hn) = 0) :
    Exp2 (fun t => Pcubic2 (Real.cos t • u2 hn + Real.sin t • H)) (Pcubic2 (u2 hn)) 0
      (3 * innerOp2 (u2 hn) (Qop2 H) - (3 / 2) * Pcubic2 (u2 hn)) := by
  have hQ : innerOp2 H (Qop2 (u2 hn)) = 0 := by rw [innerOp2_Qop2_u2, hT, mul_zero]
  have hc3 := (exp2_cos.mul exp2_cos).mul exp2_cos
  have hs2 := exp2_sin.mul exp2_sin
  have hcs2 := exp2_cos.mul hs2
  have hs3 := exp2_sin.mul hs2
  have hsum := ((hc3.mul (Exp2.const (Pcubic2 (u2 hn)))).add
    ((hcs2.mul (Exp2.const (3 * innerOp2 (u2 hn) (Qop2 H)))))).add (hs3.mul (Exp2.const (Pcubic2 H)))
  refine Exp2.coeff (Exp2.congr_ev hsum (Eventually.of_forall fun t => ?_)) ?_ ?_ ?_
  · rw [Pcubic2_circle (a := u2 hn) (TensorBridge.isSelfAdjoint2_restrict (CP2Real.Wc_weyl hn)) hH.isSelfAdjoint2 hQ]
    ring
  · ring
  · ring
  · ring

/-- An expansion's constant is the value at `0`. -/
theorem Exp2.at_zero {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] {f : ℝ → 𝔸} {a b c : 𝔸}
    (hf : Exp2 f a b c) : f 0 = a := by
  unfold Exp2 at hf
  have h := (hf.bound one_pos).self_of_nhdsWithin (Set.mem_Ici.mpr le_rfl)
  simp only [zero_smul, add_zero, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, norm_zero,
    mul_zero] at h
  exact sub_eq_zero.mp (norm_le_zero_iff.mp h)

/-- **An expansion's first coefficient is the one-sided derivative.** -/
theorem Exp2.first_eq_deriv {f : ℝ → ℝ} {a b c D : ℝ} (hf : Exp2 f a b c) (hD : HasDerivWithinAt f D (Set.Ici 0) 0) :
    b = D := by
  have h0 := Exp2.at_zero hf
  have hder := hasDerivWithinAt_iff_isLittleO.mp hD
  have h2 := Exp2.first hf
  have : (fun t : ℝ => (b - D) * t) =o[𝓝[Set.Ici 0] 0] fun t => t := by
    refine ((hder.congr_right fun t => sub_zero t).sub h2).congr_left fun t => ?_
    simp only [sub_zero, smul_eq_mul]
    rw [h0]; ring
  exact sub_eq_zero.mp (coeff_eq_zero_of_isLittleO this)

/-- The one-sided derivative of `δ²` along the line `u + tH` at the padded competitor, as in `hasDerivWithinAt_defect_u`. -/
noncomputable def dLine (hN : finrank ℝ (Biv n) = N) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric) : ℝ :=
  -2 * (1 / (3 * Real.sqrt 6)) *
    (inner ℝ (vec 1) (H (vec 1)) + inner ℝ (vec 2) (H (vec 2)) +
      ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
        inner ℝ (vec δ) (specFn hN negPartScalar (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hH) (vec δ)))

/-- **`δ²` along the great circle, with its first coefficient pinned**: `δ²(cos t · u + sin t · H) = 1/9 + t d + c₂ t² + o(t²)`
where `d` is the one-sided derivative of `δ²` along the line `u + tH`. The two paths agree to first order, the negative part
is Lipschitz, and first coefficients are unique. -/
theorem L134b_first (hn : 4 ≤ n) {N : ℕ} (hN : finrank ℝ (Biv n) = N) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric)
    (hW : ∀ t : ℝ, (Real.cos t • uOp + Real.sin t • H).IsSymmetric) :
    ∃ c₂ : ℝ, Exp2 (fun t => altNormSqOf (specFn hN negPartScalar (hW t))) (1 / 9) (dLine hN hH) c₂ := by
  have hu := uOp_isSymmetric (n := n)
  have hL : ∀ t : ℝ, (uOp + t • H).IsSymmetric := fun t x y => by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
      real_inner_smul_right, hu x y, hH x y]
  have hG : ((-(1 / 2) : ℝ) • (uOp : Biv n →ₗ[ℝ] Biv n)).IsSymmetric := fun x y => by
    simp only [LinearMap.smul_apply, real_inner_smul_left, real_inner_smul_right, hu x y]
  have h0 : (0 : Biv n →ₗ[ℝ] Biv n).IsSymmetric := fun x y => by simp
  have hpath := ((exp2_cos.smul_vec (LinearMap.toContinuousLinearMap (uOp : Biv n →ₗ[ℝ] Biv n))).add
    (exp2_sin.smul_vec (LinearMap.toContinuousLinearMap H)))
  have hpath' : Exp2 (fun t => LinearMap.toContinuousLinearMap (Real.cos t • uOp + Real.sin t • H))
      (LinearMap.toContinuousLinearMap uOp) (LinearMap.toContinuousLinearMap H)
      (LinearMap.toContinuousLinearMap ((-(1 / 2) : ℝ) • (uOp : Biv n →ₗ[ℝ] Biv n))) := by
    refine Exp2.coeff (Exp2.congr_ev hpath (Eventually.of_forall fun t => by simp [map_add, map_smul])) ?_ ?_ ?_ <;>
      simp [map_smul]
  have hline : Exp2 (fun t => LinearMap.toContinuousLinearMap (uOp + t • H))
      (LinearMap.toContinuousLinearMap uOp) (LinearMap.toContinuousLinearMap H)
      (LinearMap.toContinuousLinearMap (0 : Biv n →ₗ[ℝ] Biv n)) :=
    Exp2.coeff (Exp2.congr (Exp2.poly (LinearMap.toContinuousLinearMap uOp) (LinearMap.toContinuousLinearMap H) 0)
      fun t => by simp [map_add, map_smul]) rfl rfl (by simp)
  have hpos : ∀ x, 0 < x → negPartScalar x = 0 := fun _ hx => negPartScalar_of_nonneg hx.le
  have hneg : ∀ x, x < 0 → negPartScalar x = -x := fun _ hx => negPartScalar_of_nonpos hx.le
  have hhom : ∀ c x, 0 ≤ c → negPartScalar (c * x) = c * negPartScalar x := fun _ x hc => negPartScalar_smul hc x
  obtain ⟨A₁, A₂, hg⟩ := exp2_negPart_path hN hu negPartScalar hpos hneg hhom hH hG hW hpath'
  obtain ⟨B₁, B₂, hgL⟩ := exp2_negPart_path hN hu negPartScalar hpos hneg hhom hH h0 hL hline
  -- the two paths, and so their negative parts, differ by `O(t²)`
  have hdiff := Exp2.sub_isBigO hpath' hline
  have hgdiff : (fun t => LinearMap.toContinuousLinearMap (specFn hN negPartScalar (hW t)) -
      LinearMap.toContinuousLinearMap (specFn hN negPartScalar (hL t))) =O[𝓝[Set.Ici 0] 0] fun t => t ^ 2 := by
    refine IsBigO.trans ?_ hdiff
    refine IsBigO.of_bound (Real.sqrt (finrank ℝ (Biv n))) (Eventually.of_forall fun t => ?_)
    rw [← map_sub, ← map_sub]
    exact norm_specFn_sub_le hN negPartScalar (negPart_lipschitz _ hpos hneg hhom) (hL t) (hW t)
  have hAB : A₁ = B₁ := Exp2.first_unique hg hgL hgdiff
  obtain ⟨c₂, hd⟩ := exp2_altNormSqOf' hg
  obtain ⟨c₂', hdL⟩ := exp2_altNormSqOf' hgL
  -- the line's first coefficient is the derivative
  have hc := Exp2.first_eq_deriv hdL (hasDerivWithinAt_defect_u hN hn hH hL)
  refine ⟨c₂, Exp2.coeff hd ?_ (by rw [hAB, hc]; rfl) rfl⟩
  rw [LinearMap.coe_toContinuousLinearMap, altNormSq_uNeg hN hn]

/-- The great circle through the padded competitor in `CurvOp2`, read in the bivector model. -/
theorem opB_circle (hn : 4 ≤ n) (H : CurvOp2 (Fin n)) (t : ℝ) :
    opB (Real.cos t • u2 hn + Real.sin t • H) = Real.cos t • uOp + Real.sin t • opB H := by
  rw [opB_smul_add, opB_u2]

/-- **L134(b)'s display**: along the great circle through the padded `ℂP²` competitor, in a tangent Weyl direction `H`,
`Φ = P − κ δ²` expands one-sidedly as
`Φ(t) = (P(u) − κ/9) + t (−κ d) + t² (3⟨u, Q(H)⟩ − (3/2) P(u) − κ c₂) + o(t²)`,
where `d` is `δ²`'s one-sided derivative along the line `u + tH` (so `−κ d = 2aκF(H)`, `L17`'s derivative, which vanishes on
`{F = 0}`), `3⟨u, Q(H)⟩ − (3/2) P(u)` is `½ Hess(P|_S)_u[H, H]` at unit `H`, and `c₂` is the `t²` coefficient of `δ²` along the same circle. -/
theorem L134b_Phi (hn : 4 ≤ n) {N : ℕ} (hN : finrank ℝ (Biv n) = N) {H : CurvOp2 (Fin n)} (hH : IsWeyl2 H)
    (hT : innerOp2 H (u2 hn) = 0) (κ : ℝ)
    (hW : ∀ t : ℝ, (Real.cos t • uOp + Real.sin t • opB H).IsSymmetric) :
    ∃ c₂ : ℝ, Exp2 (fun t => altNormSqOf (specFn hN negPartScalar (hW t))) (1 / 9)
        (dLine hN (opB_isSymmetric hH.selfAdjoint)) c₂ ∧
      Exp2 (fun t => Pcubic2 (Real.cos t • u2 hn + Real.sin t • H) - κ * altNormSqOf (specFn hN negPartScalar (hW t)))
        (Pcubic2 (u2 hn) - κ * (1 / 9)) (-κ * dLine hN (opB_isSymmetric hH.selfAdjoint))
        (3 * innerOp2 (u2 hn) (Qop2 H) - (3 / 2) * Pcubic2 (u2 hn) - κ * c₂) := by
  obtain ⟨c₂, hd⟩ := L134b_first hn hN (opB_isSymmetric hH.selfAdjoint) hW
  refine ⟨c₂, hd, Exp2.coeff ((exp2_P_circle hn hH hT).sub ((Exp2.const κ).mul hd)) rfl ?_ ?_⟩ <;> ring

end HamiltonsCubic.L17Deriv
