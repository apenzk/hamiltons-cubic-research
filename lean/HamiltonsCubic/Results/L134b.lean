import HamiltonsCubic.Base.SecondAssembly
import HamiltonsCubic.Results.L17Deriv

set_option linter.style.longLine false

/-!
# L134(b): the defect has a one-sided second-order expansion along the great circle

[route-a.md](../../../findings/route-a.md), Lemma L134(b): *"`c₂` is a genuine one-sided second derivative rather than a
formal coefficient"*, which the record takes from Rellich's theorem. **`L134b`**: at the padded `ℂP²` competitor `u` on
`Λ²ℝⁿ`, `n ≥ 4`, and for every symmetric `H`,

`δ²(cos t · u + sin t · H) = 1/9 + c₁ t + c₂ t² + o(t²)` as `t → 0⁺`.

The record defines `c₂` as this `t²` coefficient and uses only the `o(t²)` remainder. Rellich's theorem, which the record
also cites, gives an `O(t³)` remainder, and that stronger form is not proved here.

It is milestone 5 of [the second-order plan](../../../reviews/2026-09-26-lean-second-order-plan.md):
- `exp2_cos`, `exp2_sin` expand the great circle, through `Exp2.smul_vec`;
- [SecondAssembly.lean](../Base/SecondAssembly.lean)'s `exp2_negPart_path` expands its negative part;
- `exp2_altNormSqOf` carries the expansion through `δ² = ‖Alt(·)‖²`, a sum of squares of the continuous linear
  functionals `altCLM` (`Exp2.map`, `Exp2.mul`, `Exp2.sum`);
- `altNormSq_uNeg` gives the constant term `1/9`.

*[L134bPhi.lean](L134bPhi.lean)'s `L134b_first` pins the first coefficient: it is `δ²`'s one-sided derivative along the
line `u + tH`, which [L17Deriv.lean](L17Deriv.lean) computes as `−2aF(H)`, so on `{F = 0}` the expansion is the record's
`1/9 + c₂ t² + o(t²)`. The statement gives the existence of `c₂` and not its value, and the bound `c₂ ≤ 0.3591` that I3
needs is L134(d) and L140.*
-/

namespace HamiltonsCubic.SpectralFn

open Module Asymptotics Filter Topology

/-! ## Expansion tools -/

theorem Exp2.map {𝔸 𝔹 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] [NormedRing 𝔹] [NormedAlgebra ℝ 𝔹]
    (L : 𝔸 →L[ℝ] 𝔹) {f : ℝ → 𝔸} {a b c : 𝔸} (hf : Exp2 f a b c) : Exp2 (fun t => L (f t)) (L a) (L b) (L c) := by
  unfold Exp2 at *
  refine (L.isBigO_comp _ _ |>.trans_isLittleO hf).congr_left fun t => ?_
  simp [map_sub, map_add, map_smul]

theorem Exp2.sum {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] {ι : Type*} (s : Finset ι) {f : ι → ℝ → 𝔸}
    {a b c : ι → 𝔸} (h : ∀ i ∈ s, Exp2 (f i) (a i) (b i) (c i)) :
    Exp2 (fun t => ∑ i ∈ s, f i t) (∑ i ∈ s, a i) (∑ i ∈ s, b i) (∑ i ∈ s, c i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using Exp2.const (0 : 𝔸)
  | insert j s hj ih =>
    simp only [Finset.sum_insert hj]
    exact (h j (Finset.mem_insert_self j s)).add (ih fun i hi => h i (Finset.mem_insert_of_mem hi))

theorem Exp2.smul_vec {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] {f : ℝ → ℝ} {a b c : ℝ} (hf : Exp2 f a b c)
    (v : 𝔸) : Exp2 (fun t => f t • v) (a • v) (b • v) (c • v) := by
  unfold Exp2 at *
  have := hf.smul_isBigO (isBigO_const_const v (one_ne_zero : (1 : ℝ) ≠ 0) (𝓝[Set.Ici 0] (0 : ℝ)))
  refine (this.congr_right fun t => by rw [smul_eq_mul, mul_one]).congr_left fun t => ?_
  simp only [sub_smul, add_smul, smul_smul, smul_eq_mul]

theorem exp2_cos : Exp2 Real.cos 1 0 (-(1 / 2)) := by
  unfold Exp2
  have h4 : (fun t : ℝ => |t| ^ 4 * (5 / 96)) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 := by
    have := ((isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 2 < 4)).mono (nhdsWithin_le_nhds (s := Set.Ici 0))).norm_left
    exact (this.const_mul_left (5 / 96)).congr_left fun t => by rw [norm_pow, Real.norm_eq_abs]; ring
  refine IsBigO.trans_isLittleO (IsBigO.of_bound 1 ?_) h4
  have hev : ∀ᶠ t in 𝓝[Set.Ici 0] (0 : ℝ), |t| ≤ 1 := by
    filter_upwards [nhdsWithin_le_nhds (Metric.closedBall_mem_nhds (0 : ℝ) one_pos)] with t ht
    simpa [Real.dist_eq] using ht
  filter_upwards [hev] with t ht
  have := Real.cos_bound ht
  rw [one_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg (by positivity : 0 ≤ |t| ^ 4 * (5 / 96))]
  convert this using 2; simp; ring

theorem exp2_sin : Exp2 Real.sin 0 1 0 := by
  unfold Exp2
  have h3 : (fun t : ℝ => |t| ^ 5 / 100 + |t| ^ 3 / 6) =o[𝓝[Set.Ici 0] 0] fun t => t ^ 2 := by
    have a5 := ((isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 2 < 5)).mono (nhdsWithin_le_nhds (s := Set.Ici 0))).norm_left
    have a3 := ((isLittleO_pow_pow (𝕜 := ℝ) (by norm_num : 2 < 3)).mono (nhdsWithin_le_nhds (s := Set.Ici 0))).norm_left
    exact ((a5.const_mul_left (1 / 100)).add (a3.const_mul_left (1 / 6))).congr_left fun t => by
      rw [norm_pow, norm_pow, Real.norm_eq_abs]; ring
  refine IsBigO.trans_isLittleO (IsBigO.of_bound 1 ?_) h3
  have hev : ∀ᶠ t in 𝓝[Set.Ici 0] (0 : ℝ), |t| ≤ 1 := by
    filter_upwards [nhdsWithin_le_nhds (Metric.closedBall_mem_nhds (0 : ℝ) one_pos)] with t ht
    simpa [Real.dist_eq] using ht
  filter_upwards [hev] with t ht
  have hb := Real.sin_bound ht
  rw [one_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg (by positivity : 0 ≤ |t| ^ 5 / 100 + |t| ^ 3 / 6)]
  have e : Real.sin t - (0 + t • (1 : ℝ) + t ^ 2 • (0 : ℝ)) = (Real.sin t - (t - t ^ 3 / 6)) - t ^ 3 / 6 := by
    simp; ring
  rw [e]
  calc |Real.sin t - (t - t ^ 3 / 6) - t ^ 3 / 6| ≤ |Real.sin t - (t - t ^ 3 / 6)| + |t ^ 3 / 6| := abs_sub _ _
    _ ≤ |t| ^ 5 / 100 + |t| ^ 3 / 6 := by
        gcongr
        rw [abs_div, abs_pow]; norm_num

end HamiltonsCubic.SpectralFn

namespace HamiltonsCubic.L17Deriv

open Module Asymptotics Filter Topology HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel HamiltonsCubic.AltLayer

variable {n : ℕ}

theorem Exp2.coeff {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] {f : ℝ → 𝔸} {a b c a' b' c' : 𝔸}
    (h : Exp2 f a b c) (ha : a = a') (hb : b = b') (hc : c = c') : Exp2 f a' b' c' := by
  subst ha hb hc; exact h

/-- The `Alt` component `(i, j, k, l)` as a continuous linear functional of the operator. -/
noncomputable def altCLM (i j k l : Fin n) : (Biv n →L[ℝ] Biv n) →L[ℝ] ℝ :=
  (1 / 3 : ℝ) • (compCLM i j k l + compCLM i k l j + compCLM i l j k)

theorem altCLM_apply (X : Biv n →L[ℝ] Biv n) (i j k l : Fin n) :
    altCLM i j k l X = alt4 (compOf (X : Biv n →ₗ[ℝ] Biv n)) i j k l := by
  simp [altCLM, alt4, compCLM_apply]
  ring

theorem altNormSqOf_eq (X : Biv n →L[ℝ] Biv n) :
    altNormSqOf (X : Biv n →ₗ[ℝ] Biv n) =
      (1 / 4 : ℝ) * ∑ i, ∑ j, ∑ k, ∑ l, altCLM i j k l X * altCLM i j k l X := by
  simp only [altNormSqOf, fourNormSq, fourInner, altCLM_apply]

/-- **`‖Alt(·)‖²` keeps a second-order expansion.** -/
theorem exp2_altNormSqOf {F : ℝ → Biv n →L[ℝ] Biv n} {a b c : Biv n →L[ℝ] Biv n} (hF : Exp2 F a b c) :
    ∃ c₁ c₂ : ℝ, Exp2 (fun t => altNormSqOf (F t : Biv n →ₗ[ℝ] Biv n)) (altNormSqOf (a : Biv n →ₗ[ℝ] Biv n)) c₁ c₂ := by
  have he : ∀ i j k l : Fin n, Exp2 (fun t => altCLM i j k l (F t) * altCLM i j k l (F t))
      (altCLM i j k l a * altCLM i j k l a) _ _ := fun i j k l =>
    (hF.map (altCLM i j k l)).mul (hF.map (altCLM i j k l))
  have hs := (Exp2.sum Finset.univ fun i _ => Exp2.sum Finset.univ fun j _ => Exp2.sum Finset.univ fun k _ =>
    Exp2.sum Finset.univ fun l _ => he i j k l).smul (1 / 4 : ℝ)
  refine ⟨_, _, Exp2.coeff (Exp2.congr_ev hs (Eventually.of_forall fun t => ?_)) ?_ rfl rfl⟩
  · simp only [altNormSqOf_eq, smul_eq_mul]
  · simp only [altNormSqOf_eq, smul_eq_mul]

/-- **L134(b)**: along the great circle `cos t · u + sin t · H` at the padded `ℂP²` competitor, for every symmetric `H`
on `Λ²ℝⁿ`, `n ≥ 4`, the defect has a one-sided second-order expansion
`δ²(cos t u + sin t H) = 1/9 + c₁ t + c₂ t² + o(t²)` as `t → 0⁺`. So `c₂ = c₂(H)` is a genuine one-sided second-order
coefficient, which the record takes from Rellich's theorem. -/
theorem L134b (hn : 4 ≤ n) {N : ℕ} (hN : finrank ℝ (Biv n) = N) {H : Biv n →ₗ[ℝ] Biv n} (hH : H.IsSymmetric)
    (hW : ∀ t : ℝ, (Real.cos t • uOp + Real.sin t • H).IsSymmetric) :
    ∃ c₁ c₂ : ℝ, Exp2 (fun t => altNormSqOf (specFn hN negPartScalar (hW t))) (1 / 9) c₁ c₂ := by
  have hu := uOp_isSymmetric (n := n)
  have hG : ((-(1 / 2) : ℝ) • (uOp : Biv n →ₗ[ℝ] Biv n)).IsSymmetric := fun x y => by
    simp only [LinearMap.smul_apply, real_inner_smul_left, real_inner_smul_right, hu x y]
  have hpath := ((exp2_cos.smul_vec (LinearMap.toContinuousLinearMap (uOp : Biv n →ₗ[ℝ] Biv n))).add
    (exp2_sin.smul_vec (LinearMap.toContinuousLinearMap H)))
  have hpath' : Exp2 (fun t => LinearMap.toContinuousLinearMap (Real.cos t • uOp + Real.sin t • H))
      (LinearMap.toContinuousLinearMap uOp) (LinearMap.toContinuousLinearMap H)
      (LinearMap.toContinuousLinearMap ((-(1 / 2) : ℝ) • (uOp : Biv n →ₗ[ℝ] Biv n))) := by
    refine Exp2.coeff (Exp2.congr_ev hpath (Eventually.of_forall fun t => by simp [map_add, map_smul])) ?_ ?_ ?_ <;>
      simp [map_smul]
  obtain ⟨A₁, A₂, hg⟩ := exp2_negPart_path hN hu negPartScalar (fun _ hx => negPartScalar_of_nonneg hx.le)
    (fun _ hx => negPartScalar_of_nonpos hx.le) (fun _ x hc => negPartScalar_smul hc x) hH hG hW hpath'
  obtain ⟨c₁, c₂, hd⟩ := exp2_altNormSqOf hg
  refine ⟨c₁, c₂, Exp2.coeff hd ?_ rfl rfl⟩
  rw [LinearMap.coe_toContinuousLinearMap, altNormSq_uNeg hN hn]

end HamiltonsCubic.L17Deriv
