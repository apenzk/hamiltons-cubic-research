import Mathlib

set_option linter.style.longLine false

/-!
# Off the equal-`u` ansatz, every block the scalar chain leaves alive has `√3 u_a < θ`

[post F75](../../../findings/fence-posts.md) scopes the invertibility of `θ - 2L_{q_a}` on the Bianchi plane
(eigenvalues `θ ∓ √3 u_a`) to the equal-`N_i`, equal-`u` ansatz, because the Gram bound alone lets a single
`u_a` reach `√(5t/3)`, where `θ - √3 u_a < 0`. The chain's own per-block slack closes that gap: at `θ² = 3/2`
a block with `√3 u_a ≥ θ` has slack `F_a(u_a) > 0` and is excluded, whatever the other blocks carry.

The record's slack, [the I104 note](../../../reviews/2026-09-14-I104-tau-positive.md), section "The scalar
chains with the derived constant":

  `F_a(u) = θu² - u³/(2√3) - (u/√3)(t + (N - N_a)/2) - N_a(θ/2 - τ/N_a)`,  `t = 1 - N`, `N = N₁+N₂+N₃`.

Here `k` stands for `√3` (`k² = 3`, `k > 0`), and the slack is multiplied through by `2k`.

## What is proved

* `surviving_block_invertible`: `θ² = 3/2`, `τ > 0`, `0 ≤ N_a ≤ N`, `0 ≤ u`, `u² ≤ t = 1 - N` and
  `F_a(u) ≤ 0` (the chain's survival condition, [L221](../../../findings/second-order.md) step 4) give `3u² < θ²`. *No equal-`u` or equal-`N_i` hypothesis enters.*

## What is NOT stated

That `u_a = ‖q_a‖ ≤ ‖D‖ = √t`, that `θ ∓ √3 u_a` are the eigenvalues of `θ - 2L_{q_a}` on the plane
([L220](../../../findings/second-order.md) step 5), or the chain inequality itself; all are the record's.
-/

namespace HamiltonsCubic.I111Invertible

theorem surviving_block_invertible (θ k u t N Na τ : ℝ)
    (hθ : θ ^ 2 = 3 / 2) (hθp : 0 < θ) (hk : k ^ 2 = 3) (hkp : 0 < k)
    (hu : 0 ≤ u) (hut : u ^ 2 ≤ t) (ht : t = 1 - N) (hNa : 0 ≤ Na) (hNaN : Na ≤ N) (hτ : 0 < τ)
    (hF : θ * u ^ 2 - u ^ 3 / (2 * k) - u / k * (t + (N - Na) / 2) - Na * (θ / 2) + τ ≤ 0) :
    3 * u ^ 2 < θ ^ 2 := by
  by_contra h
  have hu2 : 1 / 2 ≤ u ^ 2 := by linarith [not_lt.mp h]
  have hu1sq : u ^ 2 ≤ 1 := by linarith
  have hu1 : u ≤ 1 := by
    by_contra h1
    have : 1 < u := not_le.mp h1
    nlinarith
  by_cases hbig : 1 / 2 < Na
  · linarith
  have hbig' : Na ≤ 1 / 2 := not_lt.mp hbig
  -- m = kθ with m² = 9/2, and u₀ = m/3 with u₀² = 1/2
  obtain ⟨m, hm⟩ : ∃ m, m = k * θ := ⟨_, rfl⟩
  have hm2 : m ^ 2 = 9 / 2 := by rw [hm, mul_pow, hk, hθ]; norm_num
  have hmp : 0 < m := by rw [hm]; exact mul_pos hkp hθp
  have hu0 : m / 3 ≤ u := by
    by_contra hlt
    have hlt' : u < m / 3 := not_le.mp hlt
    have : u ^ 2 < (m / 3) ^ 2 := by
      have := mul_pos (sub_pos.2 hlt') (by positivity : (0:ℝ) < m / 3 + u)
      nlinarith
    nlinarith
  obtain ⟨c, hc⟩ : ∃ c, c = t + (N - Na) / 2 := ⟨_, rfl⟩
  have hc' : c = 1 - N / 2 - Na / 2 := by rw [hc, ht]; ring
  have hc1 : c ≤ 1 := by rw [hc']; linarith
  rw [← hc] at hF
  have hE : 2 * k * (θ * u ^ 2 - u ^ 3 / (2 * k) - u / k * c - Na * (θ / 2) + τ)
      = 2 * m * u ^ 2 - u ^ 3 - 2 * c * u - m * Na + 2 * k * τ := by
    rw [hm]; field_simp; try ring
  have hu0le1 : m / 3 ≤ 1 := le_trans hu0 hu1
  have hQ : 0 ≤ 2 * m * (u + m / 3) - (u ^ 2 + u * (m / 3) + (m / 3) ^ 2) - 2 * c := by
    have h1 : 0 ≤ m * (u - m / 3) := mul_nonneg hmp.le (by linarith)
    have h2 : u * (m / 3) ≤ 1 := by nlinarith
    have h3 : (m / 3) ^ 2 = 1 / 2 := by rw [div_pow, hm2]; norm_num
    nlinarith
  have hEu0 : 2 * m * (m / 3) ^ 2 - (m / 3) ^ 3 - 2 * c * (m / 3) - m * Na
      = m / 6 * (1 + 2 * N - 4 * Na) := by
    have e : 2 * m * (m / 3) ^ 2 - (m / 3) ^ 3 - 2 * c * (m / 3) - m * Na
        = m * (2 * m ^ 2 / 9 - m ^ 2 / 27 - 2 * c / 3 - Na) := by ring
    rw [e, hm2, hc']; ring
  have hfac : 2 * m * u ^ 2 - u ^ 3 - 2 * c * u - m * Na
      = (2 * m * (m / 3) ^ 2 - (m / 3) ^ 3 - 2 * c * (m / 3) - m * Na)
        + (u - m / 3) * (2 * m * (u + m / 3) - (u ^ 2 + u * (m / 3) + (m / 3) ^ 2) - 2 * c) := by
    ring
  have hA : 0 ≤ m / 6 * (1 + 2 * N - 4 * Na) := mul_nonneg (by positivity) (by linarith)
  have hB : 0 ≤ (u - m / 3) * (2 * m * (u + m / 3) - (u ^ 2 + u * (m / 3) + (m / 3) ^ 2) - 2 * c) :=
    mul_nonneg (by linarith) hQ
  have hkt : 0 < 2 * k * τ := by positivity
  have hpos : 0 < 2 * k * (θ * u ^ 2 - u ^ 3 / (2 * k) - u / k * c - Na * (θ / 2) + τ) := by
    rw [hE, hfac, hEu0]; linarith
  have hneg := mul_nonpos_of_nonneg_of_nonpos (by positivity : (0:ℝ) ≤ 2 * k) hF
  linarith

end HamiltonsCubic.I111Invertible
