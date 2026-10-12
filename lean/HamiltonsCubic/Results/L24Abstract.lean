import Mathlib

/-!
# L24, the second-order condition in the abstract

[findings/second-order.md](../../../findings/second-order.md), Lemma L24 (Krasnov–Tkachev,
*Variety of idempotents in nonassociative algebras*, Proposition 6.6).

For a symmetric trilinear form `T` on a real inner-product space, a unit `W` critical for
`x ↦ T x x x` on the unit sphere (`T W W v = θ ⟨W, v⟩`, `θ > 0`) that is a local maximiser there has
`T W v v ≤ (θ/2) ‖v‖²` for every `v ⊥ W` (`second_order`): with `L_e = T(e, ·, ·)`, `e = W/θ`, this is
`λ_max(L_e|W⊥) ≤ ½`. The proof follows the curve `(W + s v)/√(1 + s²)` and compares the `s²`
coefficients.

**Not typed here**: the instantiation to `𝒲ₙ` with `T(X,Y,Z) = ⟨X ∘ Y, Z⟩`, which needs `T`'s full
symmetry on self-adjoint operators ([r285](../../../reviews/REVIEW_r285.md) Claim 1).
-/

namespace HamiltonsCubic.L24Abstract

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- The cubic along `W + s v` when `v ⊥ W` and `T W W v = 0`. -/
theorem cubic_line (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hs12 : ∀ x y z, T x y z = T y x z) (hs23 : ∀ x y z, T x y z = T x z y)
    (W v : E) (hWWv : T W W v = 0) (s : ℝ) :
    T (W + s • v) (W + s • v) (W + s • v)
      = T W W W + 3 * s ^ 2 * T W v v + s ^ 3 * T v v v := by
  simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, smul_eq_mul]
  have e1 : T W v W = 0 := by rw [hs23]; exact hWWv
  have e2 : T v W W = 0 := by rw [hs12, e1]
  have e3 : T v W v = T W v v := by rw [hs12]
  have e4 : T v v W = T W v v := by rw [hs23, hs12]
  rw [hWWv, e1, e2, e3, e4]; ring

/-- A small `s` with the three properties the argument needs. -/
theorem exists_small (ε g K : ℝ) (hε : 0 < ε) (hg : 0 < g) (hK : 0 < K) :
    ∃ s : ℝ, 0 < s ∧ s ≤ 1 ∧ s < ε ∧ s * K ≤ g := by
  refine ⟨min (ε / 2) (min 1 (g / K)), ?_, ?_, ?_, ?_⟩
  · exact lt_min (by linarith) (lt_min one_pos (div_pos hg hK))
  · exact (min_le_right _ _).trans (min_le_left _ _)
  · exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
  · have h : min (ε / 2) (min 1 (g / K)) ≤ g / K := (min_le_right _ _).trans (min_le_right _ _)
    calc min (ε / 2) (min 1 (g / K)) * K ≤ g / K * K := mul_le_mul_of_nonneg_right h hK.le
      _ = g := div_mul_cancel₀ g hK.ne'

/-- The real inequality that closes the argument. -/
theorem real_close (θ b c s r : ℝ) (hθ : 0 < θ) (hs0 : 0 < s) (hs1 : s ≤ 1)
    (hrsq : r ^ 2 = 1 + s ^ 2) (hrpos : 0 < r) (hrle : r ≤ 1 + s ^ 2 / 2)
    (key : θ + 3 * s ^ 2 * b + s ^ 3 * c ≤ θ * r ^ 3)
    (hsmall : s * (2 * (|c| + θ + 1)) ≤ 3 * b - 3 * θ / 2) (hg : 0 < 3 * b - 3 * θ / 2) :
    False := by
  have hr3le : r ^ 3 ≤ (1 + s ^ 2 / 2) * (1 + s ^ 2) := by
    rw [show r ^ 3 = r * r ^ 2 by ring, hrsq]
    exact mul_le_mul_of_nonneg_right hrle (by positivity)
  have h1 : θ * r ^ 3 ≤ θ + 3 / 2 * θ * s ^ 2 + θ / 2 * s ^ 4 := by
    nlinarith [mul_le_mul_of_nonneg_left hr3le hθ.le]
  have hcs : -(|c|) * s ^ 3 ≤ s ^ 3 * c := by
    have := neg_abs_le c; nlinarith [pow_pos hs0 3]
  have hs4 : s ^ 4 ≤ s ^ 3 := by
    have := pow_pos hs0 3; nlinarith
  have h2a : (3 * b - 3 * θ / 2) * s ^ 2 ≤ θ / 2 * s ^ 4 - s ^ 3 * c := by linarith
  have h2b : θ / 2 * s ^ 4 ≤ θ / 2 * s ^ 3 := by nlinarith
  have h2c : θ / 2 * s ^ 3 ≤ θ * s ^ 3 := by nlinarith [pow_pos hs0 3]
  have h2 : (3 * b - 3 * θ / 2) * s ^ 2 ≤ (s * (|c| + θ)) * s ^ 2 := by
    have : (s * (|c| + θ)) * s ^ 2 = |c| * s ^ 3 + θ * s ^ 3 := by ring
    rw [this]; linarith
  have h3 : 3 * b - 3 * θ / 2 ≤ s * (|c| + θ) := le_of_mul_le_mul_right h2 (by positivity)
  have h4 : s * (|c| + θ) < s * (2 * (|c| + θ + 1)) := by
    apply mul_lt_mul_of_pos_left _ hs0; nlinarith [abs_nonneg c]
  linarith

set_option maxHeartbeats 1000000 in
/-- **L24, abstractly.** -/
theorem second_order (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hs12 : ∀ x y z, T x y z = T y x z) (hs23 : ∀ x y z, T x y z = T x z y)
    (W : E) (hW : ‖W‖ = 1) (θ : ℝ) (hθ : 0 < θ)
    (hcrit : ∀ v, T W W v = θ * inner ℝ W v)
    (hmax : ∃ ε > 0, ∀ x : E, ‖x‖ = 1 → ‖x - W‖ < ε → T x x x ≤ T W W W)
    (v : E) (hv : inner ℝ W v = 0) (hv1 : ‖v‖ = 1) :
    T W v v ≤ θ / 2 := by
  obtain ⟨ε, hε, hloc⟩ := hmax
  have hWWW : T W W W = θ := by
    rw [hcrit W, real_inner_self_eq_norm_sq, hW]; ring
  have hWWv : T W W v = 0 := by rw [hcrit v, hv, mul_zero]
  by_contra hcon
  push Not at hcon
  have hg : 0 < 3 * T W v v - 3 * θ / 2 := by linarith
  obtain ⟨s, hs0, hs1, hsε, hsg⟩ :=
    exists_small ε (3 * T W v v - 3 * θ / 2) (2 * (|T v v v| + θ + 1)) hε hg (by positivity)
  have hr1sq : (0 : ℝ) ≤ 1 + s ^ 2 := by positivity
  obtain ⟨r, hrdef⟩ : ∃ r, r = Real.sqrt (1 + s ^ 2) := ⟨_, rfl⟩
  have hrsq : r ^ 2 = 1 + s ^ 2 := by rw [hrdef]; exact Real.sq_sqrt hr1sq
  have hr1 : 1 ≤ r := by rw [hrdef, Real.one_le_sqrt]; nlinarith
  have hrpos : 0 < r := by linarith
  have hrle : r ≤ 1 + s ^ 2 / 2 := by nlinarith [sq_nonneg (r - 1), sq_nonneg s]
  have hy2 : ‖W + s • v‖ ^ 2 = 1 + s ^ 2 := by
    rw [norm_add_sq_real, norm_smul, real_inner_smul_right, hv, hW, hv1, Real.norm_eq_abs, mul_one,
      sq_abs]
    ring
  have hyn : ‖W + s • v‖ = r := by
    rw [hrdef, ← hy2, Real.sqrt_sq (norm_nonneg _)]
  have hx1 : ‖r⁻¹ • (W + s • v)‖ = 1 := by
    rw [norm_smul, hyn, norm_inv, Real.norm_eq_abs, abs_of_pos hrpos, inv_mul_cancel₀ hrpos.ne']
  have hin : inner ℝ (r⁻¹ • (W + s • v)) W = r⁻¹ := by
    rw [real_inner_smul_left, inner_add_left, real_inner_smul_left, real_inner_self_eq_norm_sq, hW,
      real_inner_comm, hv]
    ring
  have hxW : ‖r⁻¹ • (W + s • v) - W‖ < ε := by
    have hmul : (1 - s ^ 2 / 2) * r ≤ 1 := by nlinarith [pow_pos hs0 4]
    have hri : 1 - s ^ 2 / 2 ≤ r⁻¹ := by
      rw [← one_div, le_div_iff₀ hrpos]; exact hmul
    have hsq : ‖r⁻¹ • (W + s • v) - W‖ ^ 2 ≤ s ^ 2 := by
      rw [norm_sub_sq_real, hx1, hW, hin]; nlinarith
    have : ‖r⁻¹ • (W + s • v) - W‖ ≤ s := by
      nlinarith [norm_nonneg (r⁻¹ • (W + s • v) - W), sq_nonneg (‖r⁻¹ • (W + s • v) - W‖ - s)]
    linarith
  have hloc' := hloc _ hx1 hxW
  have hTx : T (r⁻¹ • (W + s • v)) (r⁻¹ • (W + s • v)) (r⁻¹ • (W + s • v))
      = r⁻¹ ^ 3 * (θ + 3 * s ^ 2 * T W v v + s ^ 3 * T v v v) := by
    simp only [map_smul, LinearMap.smul_apply, smul_eq_mul]
    rw [cubic_line T hs12 hs23 W v hWWv s, hWWW]; ring
  rw [hTx, hWWW] at hloc'
  have hr3 : 0 < r ^ 3 := by positivity
  have key : θ + 3 * s ^ 2 * T W v v + s ^ 3 * T v v v ≤ θ * r ^ 3 := by
    have h := mul_le_mul_of_nonneg_left hloc' hr3.le
    rw [← mul_assoc, show r ^ 3 * r⁻¹ ^ 3 = 1 by rw [← mul_pow, mul_inv_cancel₀ hrpos.ne', one_pow],
      one_mul] at h
    linarith
  exact real_close θ (T W v v) (T v v v) s r hθ hs0 hs1 hrsq hrpos hrle key hsg hg

end HamiltonsCubic.L24Abstract
