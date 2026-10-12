import HamiltonsCubic.Base.NegPartDeriv

set_option linter.style.longLine false

/-!
# The negative part to second order

The build of [the second-order plan](../../../reviews/2026-09-26-lean-second-order-plan.md), in progress.

- `schur_add_op`, `schur_smul_op`: a Schur multiplier is linear in the operator, and `hsSq_add_le`,
  `hsSq (X + Y) ≤ 2 hsSq X + 2 hsSq Y`, and `hsSq_smul`, `hsSq (c X) = c² hsSq X`;
- **`specFn_blk_family`** (milestone 1): one threshold `t₀` for the whole family `H + tH₂`, so
  `g(u + t (H + tH₂)_blk) = g(u) + t (−∑_{λ<0} P_λ (H + tH₂) P_λ + g(P₀ (H + tH₂) P₀))` for `0 ≤ t ≤ t₀`, from
  [BlockValue.lean](BlockValue.lean)'s `specFn_blk_bound`;
- **`exp_sub_quadratic_isBigO`** (milestone 3's first step): `exp y = 1 + y + y²/2 + O(‖y‖³)` in `E →L[ℝ] E`, from
  the exponential's power series.
-/

namespace HamiltonsCubic.SpectralFn

open Module

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {n : ℕ} (hn : finrank ℝ E = n) {u : E →ₗ[ℝ] E} (hu : u.IsSymmetric)

/-! ## Linearity of Schur multipliers in the operator -/

theorem schur_add_op (φ : ℝ → ℝ → ℝ) (H H' : E →ₗ[ℝ] E) :
    schur hn hu φ (H + H') = schur hn hu φ H + schur hn hu φ H' :=
  ext_entries hn hu fun k l => by
    rw [LinearMap.add_apply, inner_add_right, entry_schur, entry_schur, entry_schur, LinearMap.add_apply,
      inner_add_right]; ring

theorem schur_smul_op (φ : ℝ → ℝ → ℝ) (c : ℝ) (H : E →ₗ[ℝ] E) :
    schur hn hu φ (c • H) = c • schur hn hu φ H :=
  ext_entries hn hu fun k l => by
    rw [LinearMap.smul_apply, real_inner_smul_right, entry_schur, entry_schur, LinearMap.smul_apply,
      real_inner_smul_right]; ring

/-! ## A Hilbert–Schmidt bound on sums -/

theorem hsSq_add_le (X Y : E →ₗ[ℝ] E) : hsSq (X + Y) ≤ 2 * hsSq X + 2 * hsSq Y := by
  unfold hsSq
  rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_le_sum fun i _ => ?_
  rw [LinearMap.add_apply]
  have h := norm_add_le (X (stdOrthonormalBasis ℝ E i)) (Y (stdOrthonormalBasis ℝ E i))
  have h0 := norm_nonneg (X (stdOrthonormalBasis ℝ E i) + Y (stdOrthonormalBasis ℝ E i))
  nlinarith [sq_nonneg (‖X (stdOrthonormalBasis ℝ E i)‖ - ‖Y (stdOrthonormalBasis ℝ E i)‖),
    norm_nonneg (X (stdOrthonormalBasis ℝ E i)), norm_nonneg (Y (stdOrthonormalBasis ℝ E i))]

theorem hsSq_smul (c : ℝ) (X : E →ₗ[ℝ] E) : hsSq (c • X) = c ^ 2 * hsSq X := by
  unfold hsSq
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [LinearMap.smul_apply, norm_smul, Real.norm_eq_abs, mul_pow, sq_abs]

/-! ## Milestone 1: the exact block value along a family -/

/-- **One threshold for the family `H + tH₂`**: for small `t ≥ 0`,
`g(u + t (H + tH₂)_blk) = g(u) + t (−∑_{λ<0} P_λ (H + tH₂) P_λ + g(P₀ (H + tH₂) P₀))`. -/
theorem specFn_blk_family (g : ℝ → ℝ) (hpos : ∀ x, 0 < x → g x = 0) (hneg : ∀ x, x < 0 → g x = -x)
    (hhom : ∀ c x, 0 ≤ c → g (c * x) = c * g x) (H H₂ : E →ₗ[ℝ] E) :
    ∃ t₀ > 0, ∀ t : ℝ, 0 ≤ t → t ≤ t₀ → ∀ (hHt : (H + t • H₂).IsSymmetric)
      (hW : (u + t • blkPart hn hu (H + t • H₂)).IsSymmetric),
      specFn hn g hW = specFn hn g hu +
        t • (-schur hn hu negBlkφ (H + t • H₂) + specFn hn g (schur_isSymmetric hn hu zeroφ_symm hHt)) := by
  obtain ⟨γ, hγ, hgap⟩ := exists_gap hn hu
  set C := 2 * hsSq (blkPart hn hu H) + 2 * hsSq (blkPart hn hu H₂) with hCdef
  have hC0 : 0 ≤ C := by have := hsSq_nonneg (blkPart hn hu H); have := hsSq_nonneg (blkPart hn hu H₂); linarith
  refine ⟨min 1 (γ / (2 * (C + 1))), lt_min one_pos (by positivity), fun t ht0 ht hHt hW => ?_⟩
  have ht1 : t ≤ 1 := ht.trans (min_le_left _ _)
  have htC : t * (C + 1) ≤ γ / 2 := by
    have := ht.trans (min_le_right _ _)
    rw [le_div_iff₀ (by positivity)] at this; linarith
  have hC : hsSq (blkPart hn hu (H + t • H₂)) ≤ C := by
    unfold blkPart
    rw [schur_add_op, schur_smul_op]
    refine (hsSq_add_le _ _).trans ?_
    rw [hsSq_smul]
    have h1 := hsSq_nonneg (schur hn hu blkφ H₂)
    have ht2 : t ^ 2 ≤ 1 := by nlinarith
    unfold blkPart at hCdef
    nlinarith
  exact specFn_blk_bound hn hu g hpos hneg hhom hHt hγ hgap hC ht0 htC hW

/-! ## Milestone 3: the exponential to second order -/

section Exp
open Asymptotics Filter Topology

/-- **`exp y = 1 + y + y²/2 + O(‖y‖³)`** in `E →L[ℝ] E`. -/
theorem exp_sub_quadratic_isBigO :
    (fun y : E →L[ℝ] E => NormedSpace.exp y - (1 + y + (1 / 2 : ℝ) • (y * y))) =O[𝓝 0] fun y => ‖y‖ ^ 3 := by
  have h := (NormedSpace.hasFPowerSeriesAt_exp_zero_of_radius_pos (𝕂 := ℝ) (𝔸 := E →L[ℝ] E)
    (by rw [NormedSpace.expSeries_radius_eq_top]; exact WithTop.top_pos)).isBigO_sub_partialSum_pow 3
  simp only [zero_add] at h
  refine h.congr_left fun y => ?_
  congr 1
  simp [FormalMultilinearSeries.partialSum, Finset.sum_range_succ, NormedSpace.expSeries_apply_eq, pow_two]

end Exp

end HamiltonsCubic.SpectralFn
