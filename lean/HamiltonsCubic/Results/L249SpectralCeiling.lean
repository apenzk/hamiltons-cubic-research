import Mathlib

/-!
# L249: the per-vector ceiling with the smallest eigenvalues of `−ad_x²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L249.

On the symmetric family, at a unit `x ∈ E₀`, L244's rows give `4 b00 + 4 b01 + b11 = n − 5 − κ`.
Eckart–Young on `ad_x` restricted to `E₀ ⊕ E₁` and interlacing give
`μ_m(x) ≤ 2 (b00 + 2 b01 + b11)`, `μ_m` the sum of the `m = dim E₁` smallest eigenvalues of `−ad_x²`
(hypothesis `hμ`: the layer defines no singular values of `ad_x`). Then
`κ ≤ n − 5 − μ_m/2` (`spectral_ceiling`), and with `μ_m = 2(n − 2) − κ_{2p}` (row (A) as a trace),
`κ ≤ κ_{2p}/2 − 3` (`spectral_ceiling_top`).
-/

namespace HamiltonsCubic.L249SpectralCeiling

theorem spectral_ceiling (n κ b00 b01 b11 μ : ℝ)
    (h00 : 0 ≤ b00) (h01 : 0 ≤ b01)
    (hrows : 4 * b00 + 4 * b01 + b11 = n - 5 - κ)
    (hμ : μ ≤ 2 * (b00 + 2 * b01 + b11)) :
    κ ≤ n - 5 - μ / 2 := by linarith

theorem spectral_ceiling_top (n κ b00 b01 b11 μ k2p : ℝ)
    (h00 : 0 ≤ b00) (h01 : 0 ≤ b01)
    (hrows : 4 * b00 + 4 * b01 + b11 = n - 5 - κ)
    (hμ : μ ≤ 2 * (b00 + 2 * b01 + b11)) (htr : μ = 2 * (n - 2) - k2p) :
    κ ≤ k2p / 2 - 3 := by
  have := spectral_ceiling n κ b00 b01 b11 μ h00 h01 hrows hμ
  rw [htr] at this; linarith

/-- **Tight at the star window**: a star with `p ≤ n − 3` has `μ = 2(n − 2 − p)` at each element, and
the ceiling is `κ ≤ p − 3`, the value [F77](../../../findings/fence-posts.md)'s witness attains. -/
theorem star_value (n p κ b00 b01 b11 : ℝ) (h00 : 0 ≤ b00) (h01 : 0 ≤ b01)
    (hrows : 4 * b00 + 4 * b01 + b11 = n - 5 - κ)
    (hμ : 2 * (n - 2 - p) ≤ 2 * (b00 + 2 * b01 + b11)) : κ ≤ p - 3 := by
  have := spectral_ceiling n κ b00 b01 b11 (2 * (n - 2 - p)) h00 h01 hrows hμ
  linarith

/-- **`p = 16` at `n = 12`**: if some unit `x ∈ E₀` has `μ₃₄(x) ≥ 1/60`, L249 puts `θ` below
`θ₀(12) = √(220/144)`. The edge `θ√32 = 7` sits just above `θ₀(12)√32 ≈ 6.992`, and
`(7 − 1/120)² / 32 = 703921/460800 < 220/144`. -/
theorem p16_below_theta0 (θ κ μ : ℝ) (hθ : 0 ≤ θ) (hκ : κ = θ * Real.sqrt 32)
    (hceil : κ ≤ 7 - μ / 2) (hμ : 1 / 60 ≤ μ) : θ < Real.sqrt (220 / 144) := by
  have h32 : Real.sqrt 32 ^ 2 = 32 := Real.sq_sqrt (by norm_num)
  have hs32 : 0 < Real.sqrt 32 := Real.sqrt_pos.mpr (by norm_num)
  have hk : θ * Real.sqrt 32 ≤ 839 / 120 := by rw [← hκ]; linarith
  have hsq : θ ^ 2 * 32 ≤ (839 / 120) ^ 2 := by
    have := mul_self_le_mul_self (by positivity) hk
    nlinarith [h32]
  rw [← Real.sqrt_sq hθ]
  apply Real.sqrt_lt_sqrt (by positivity)
  nlinarith

/-- **`p = 16` at `n = 12`, the near-decomposable branch.** If every unit `x ∈ E₀` has
`T(x) = ∑_{i≥2} s_i² ≤ (5/4) μ₃₄(x)` with `μ₃₄ < 1/60`, then `tr x⁴ = 2 ∑ s⁴ ≥ 2 (1 − T)²` at every unit
`x`, the sphere average `E tr x⁴ ≤ 3 tr(A₀²)/(p(p+2)) = 3 tr(A₀²)/288` gives `2(1 − T)²·288 ≤ 3 tr(A₀²)`,
and L246 caps `tr(A₀²) ≤ 5.5 · tr A₀ = 176`: contradiction. -/
theorem p16_near_dec_contradiction (T μ trA2 : ℝ) (hT0 : 0 ≤ T) (hT : T ≤ 5 / 4 * μ)
    (hμ : μ < 1 / 60) (htr : 2 * (1 - T) ^ 2 * 288 ≤ 3 * trA2) (hL246 : trA2 ≤ 176) : False := by
  have hT1 : T < 1 / 48 := by linarith
  nlinarith [sq_nonneg (1 - T)]

/-- The label count behind `T ≤ (5/4) μ₃₄`: with `sum14` at least `2(T − s₂²)` (four full label
pairs) and at least `s₂²/2` when `s₃ < s₂/2`, or `T − s₂² ≥ s₂²/4` otherwise, `sum14 ≥ (2/5) T`. -/
theorem label_count (T s2sq sum14 : ℝ) (h0 : 0 ≤ s2sq) (hle : s2sq ≤ T)
    (hfull : 2 * (T - s2sq) ≤ sum14)
    (hcase : s2sq / 2 ≤ sum14 ∨ s2sq / 4 ≤ T - s2sq) :
    2 / 5 * T ≤ sum14 := by
  rcases hcase with h | h
  · by_cases hs : 4 / 5 * T ≤ s2sq
    · linarith
    · push Not at hs; linarith
  · linarith

end HamiltonsCubic.L249SpectralCeiling
