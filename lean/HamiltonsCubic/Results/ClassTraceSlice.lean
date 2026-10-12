import HamiltonsCubic.Results.ClassTraceGeneral

/-!
# L247's general certificate on the slice `λ₁ = 0`

[findings/second-order.md](../../../findings/second-order.md), Lemma L247, extension.
[the per-vector note](../../../reviews/2026-09-25-I73c-per-vector-rows.md), the paragraph on the firing
region at `λ₁ = 0`.

With `l0 < 0 = l1 < l2`, `a = -l0`, `b = l2`, the constant of `general_identity` is
`-θ a b (n - 1) p0 Q` with `Q = a⁴ + 2a³b + a³θ - (n-2)a²b² + 2a²bθ - 2b³θ`, and the three trace
coefficients are nonpositive. So `Q > 0` and nonnegative `t₀₀₀, t₀₁₁, t₁₂₂` force the bracket
certificate `θ · 4T > θ p0`, i.e. `-2 ∑_c l_c t_(0,2,c) > θ p0` (`fires_l1_zero`). In `l0, l2` the
condition reads `Q = l0⁴ - 2 l0³ l2 - l0³ θ - (n-2) l0² l2² + 2 l0² l2 θ - 2 l2³ θ`.
-/

namespace HamiltonsCubic.ClassTraceSlice

open HamiltonsCubic.ClassTraceGeneral

theorem fires_l1_zero (t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 l0 l1 l2 θ n p0 m p2 : ℝ)
    (hl1 : l1 = 0) (hl0 : l0 < 0) (hl2 : 0 < l2) (hθ : 0 < θ) (hn : 1 < n) (hp0 : 0 < p0)
    (h000 : 0 ≤ t000) (h011 : 0 ≤ t011) (h122 : 0 ≤ t122)
    (hQ : 0 < l0^4 - 2*l0^3*l2 - l0^3*θ - (n-2)*l0^2*l2^2 + 2*l0^2*l2*θ - 2*l2^3*θ)
    (h0 : -p0*(n - 2) + t000 + 2*t001 + 2*t002 + t011 + 2*t012 + t022 = 0)
    (h1 : l0*p0 + l0*t000 + l0*t001 + l0*t002 + l1*t001 + l1*t011 + l1*t012 + l2*t002 + l2*t012 + l2*t022 = 0)
    (h2 : l0^2*t000 + 2*l0*l1*t001 + 2*l0*l2*t002 - l0*p0*(-l0 + θ) + l1^2*t011 + 2*l1*l2*t012 + l2^2*t022 = 0)
    (h3 : -m*(n - 2) + t001 + 2*t011 + 2*t012 + t111 + 2*t112 + t122 = 0)
    (h4 : l0*t001 + l0*t011 + l0*t012 + l1*m + l1*t011 + l1*t111 + l1*t112 + l2*t012 + l2*t112 + l2*t122 = 0)
    (h5 : l0^2*t001 + 2*l0*l1*t011 + 2*l0*l2*t012 + l1^2*t111 + 2*l1*l2*t112 - l1*m*(-l1 + θ) + l2^2*t122 = 0)
    (h6 : -p2*(n - 2) + t002 + 2*t012 + 2*t022 + t112 + 2*t122 + t222 = 0)
    (h7 : l0*t002 + l0*t012 + l0*t022 + l1*t012 + l1*t112 + l1*t122 + l2*p2 + l2*t022 + l2*t122 + l2*t222 = 0)
    (h8 : l0^2*t002 + 2*l0*l1*t012 + 2*l0*l2*t022 + l1^2*t112 + 2*l1*l2*t122 + l2^2*t222 - l2*p2*(-l2 + θ) = 0)
    (h9 : l0*p0 + l1*m + l2*p2 = 0) :
    θ * p0 < -2 * (l0 * t002 + l1 * t012 + l2 * t022) := by
  subst hl1
  have h := general_identity t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 l0 0 l2 θ n p0 m p2
    h0 h1 h2 h3 h4 h5 h6 h7 h8 h9
  have hu : 0 < -l0 := by linarith
  have hn1 : 0 < n - 1 := by linarith
  have hd : 0 < (l2 - l0)^2 := pow_pos (by linarith) 2
  have hll : 0 < l0 * (l0 - l2) := mul_pos_of_neg_of_neg hl0 (by linarith)
  have key : (2*θ*(-l0)*l2^2*(l2 - l0)^2*(n - 1)) * (-2 * (l0 * t002 + 0 * t012 + l2 * t022) - θ * p0)
      = θ*(-l0)*l2*(n - 1)*p0*(l0^4 - 2*l0^3*l2 - l0^3*θ - (n-2)*l0^2*l2^2 + 2*l0^2*l2*θ - 2*l2^3*θ)
        + θ*l0^2*(l2 - l0)^2*(n - 1)*(-l0)*l2 * t000
        + θ*l0^2*l2^2*(n - 1)*(-l0)*l2 * t011
        + 2*θ*(l0*(l0 - l2))*l2^4*(n - 1) * t122 := by
    linear_combination (-1 : ℝ) * h
  have hK := mul_pos (mul_pos (mul_pos (mul_pos (mul_pos hθ hu) hl2) hn1) hp0) hQ
  have hA := mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg hθ.le
    (sq_nonneg l0)) hd.le) hn1.le) hu.le) hl2.le) h000
  have hB := mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg hθ.le
    (sq_nonneg l0)) (sq_nonneg l2)) hn1.le) hu.le) hl2.le) h011
  have hC := mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg (mul_nonneg (by norm_num : (0:ℝ) ≤ 2)
    hθ.le) hll.le) (pow_nonneg hl2.le 4)) hn1.le) h122
  have hM : 0 < 2*θ*(-l0)*l2^2*(l2 - l0)^2*(n - 1) := by
    have := mul_pos (mul_pos (mul_pos (mul_pos (mul_pos (by norm_num : (0:ℝ) < 2) hθ) hu)
      (pow_pos hl2 2)) hd) hn1
    exact this
  have hMX : 0 < (2*θ*(-l0)*l2^2*(l2 - l0)^2*(n - 1)) *
      (-2 * (l0 * t002 + 0 * t012 + l2 * t022) - θ * p0) := by
    rw [key]; linarith
  have hX := pos_of_mul_pos_right hMX hM.le
  linarith

/-- **Nonvacuity**: every hypothesis holds at `n = 12`, `λ = (-1, 0, 1)`, `θ = 8`, `p0 = p2 = 4`,
`m = 24`, where `Q = 1`, with `t₀₀₀ = 20`, `t₀₁₁ = 108`, `t₁₂₂ = 0`. -/
theorem slice_witness : (8:ℝ) * 4 < -2 * ((-1) * 28 + 0 * (-24) + 1 * 0) :=
  fires_l1_zero 20 (-48) 28 108 (-24) 0 0 60 0 0 (-1) 0 1 8 12 4 24 4 rfl
    (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by norm_num)

/-- **The general ceiling at `λ₁ = 0`**, traced over `E₀`: rows (A), (B), (C) of `E₀` give
`(l2 − l0)² t₀₀₀ + 2 l2 (l2 − l0) t₀₀₁ + l2² t₀₁₁ = p0 (l2² (n − 2) + 2 l0 l2 − l0² + l0 θ)`.
With `a = −l0`, `b = l2` and nonnegative traces this is `a θ ≤ b² (n − 2) − 2ab − a²`, L244's
`x`-free ceiling at `a = b`. -/
theorem slice_ceiling (t000 t001 t002 t011 t012 t022 l0 l2 θ n p0 : ℝ)
    (h0 : -p0*(n - 2) + t000 + 2*t001 + 2*t002 + t011 + 2*t012 + t022 = 0)
    (h1 : l0*p0 + l0*t000 + l0*t001 + l0*t002 + l2*t002 + l2*t012 + l2*t022 = 0)
    (h2 : l0^2*t000 + 2*l0*l2*t002 - l0*p0*(-l0 + θ) + l2^2*t022 = 0) :
    (l2 - l0)^2 * t000 + 2*l2*(l2 - l0) * t001 + l2^2 * t011
      = p0 * (l2^2*(n - 2) + 2*l0*l2 - l0^2 + l0*θ) := by
  linear_combination l2^2 * h0 - 2*l2 * h1 + h2

/-- **The certificate's region at `λ₁ = 0` is empty unless `|λ₀| > λ₂`**: nonnegative traces and
`Q > 0` force `l2² < l0²`. With the ceiling, `Q ≤ 2 l2 θ (l0² − l2²)`. -/
theorem slice_needs_rho_gt_one (t000 t001 t002 t011 t012 t022 l0 l2 θ n p0 : ℝ)
    (hl2 : 0 < l2) (hθ : 0 < θ) (hp0 : 0 < p0)
    (h000 : 0 ≤ t000) (h001 : 0 ≤ t001) (h011 : 0 ≤ t011) (hl0 : l0 < 0)
    (h0 : -p0*(n - 2) + t000 + 2*t001 + 2*t002 + t011 + 2*t012 + t022 = 0)
    (h1 : l0*p0 + l0*t000 + l0*t001 + l0*t002 + l2*t002 + l2*t012 + l2*t022 = 0)
    (h2 : l0^2*t000 + 2*l0*l2*t002 - l0*p0*(-l0 + θ) + l2^2*t022 = 0)
    (hQ : 0 < l0^4 - 2*l0^3*l2 - l0^3*θ - (n-2)*l0^2*l2^2 + 2*l0^2*l2*θ - 2*l2^3*θ) :
    l2^2 < l0^2 := by
  have hid := slice_ceiling t000 t001 t002 t011 t012 t022 l0 l2 θ n p0 h0 h1 h2
  have hL : 0 ≤ (l2 - l0)^2 * t000 + 2*l2*(l2 - l0) * t001 + l2^2 * t011 := by
    have : 0 ≤ l2 - l0 := by linarith
    positivity
  have hS : 0 ≤ l2^2*(n - 2) + 2*l0*l2 - l0^2 + l0*θ := by
    by_contra hc; push_neg at hc; nlinarith [mul_pos hp0 (neg_pos.mpr hc)]
  by_contra hc; push_neg at hc
  nlinarith [mul_nonneg (sq_nonneg l0) hS, mul_nonneg (mul_nonneg hl2.le hθ.le) (sub_nonneg.mpr hc)]

/-- **The firing window at `λ₁ = 0` is nonempty exactly past `ρ = 1`**: with `D = ρ³ + 2ρ² − 2 > 0`,
the certificate's threshold `ρ² R / D` on `θ/λ₂` lies below the rows' ceiling `R / ρ` iff `ρ > 1`
(`R > 0`). In `p₂` at fixed `θ`, via `λ₂ = 1/√(p₂(1+ρ))`, the firing band's lower end is the
fraction `ρ⁶ / D²` of its upper end. -/
theorem window_nonempty (ρ R : ℝ) (hρ : 0 < ρ) (hR : 0 < R) (hD : 0 < ρ^3 + 2*ρ^2 - 2) :
    ρ^2 * R / (ρ^3 + 2*ρ^2 - 2) < R / ρ ↔ 1 < ρ := by
  rw [div_lt_div_iff₀ hD hρ]
  constructor
  · intro h; nlinarith [mul_pos hR hρ, sq_nonneg (ρ - 1)]
  · intro h; nlinarith [mul_pos hR (mul_pos hρ hρ), mul_pos hR (sub_pos.mpr h)]

end HamiltonsCubic.ClassTraceSlice
