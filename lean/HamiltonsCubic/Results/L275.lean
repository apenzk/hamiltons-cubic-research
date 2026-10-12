import Mathlib

set_option linter.style.longLine false

/-!
# L275: J1 on the face `P = Q`

[second-order.md](../../../findings/second-order.md)'s L275: for a real symmetric `m × m` matrix `U` with zero
diagonal, `m ≥ 4`, with `x_ij = U_ij²`, `D_i = Σ_j x_ij` and `S = Σ_i D_i`,
`tr U³ · √S ≤ λ_m Σ_{i≠j} (D_i D_j − x_ij²)`, `λ_m = √(2m) (m − 2)/(m − 1)^{3/2}`. Since `U` has zero diagonal,
`Σ_{i≠j} D_i D_j = S² − Σ_i D_i²` and `Σ_{i≠j} x_ij² = Σ_{i,j} U_ij⁴`, which is how `L275_bound` states it.

`L275_bound` itself is proved in [L275Proof.lean](L275Proof.lean), after [J1.lean](J1.lean), whose rows and pairing it reuses at `V = 0`. Two steps of the record's proof are proved here: step (3)'s bound on
`f(p, q) = (1 − p)(1 − q)/(1 − pq)` (`L275_pair`, cleared of its denominator), and the polynomial inequality that closes
step (5) (`L275_close`).

`L275_interp` is the per-pair inequality that interpolates between the `Q = 0` face (L274) and this face in the
J1 working note's reduction of the mixed case: `(1+t)ab ≤ [t(a²+b²) + (1−t)(a+b)/2]·[1 − (1−a)(1−b)(1−t²)]` on `[0,1]³`,
proved by AM-GM down to `a = b = √(ab)` and there by `g(1−g)(1−t)Q(g,t)` with `Q ≥ 0`.
-/

namespace HamiltonsCubic.L275

open Matrix Finset

/-- **Step (3)**: `2(1 − p)(1 − q) ≤ (2 − p − q)(1 − pq)` on `[0, 1]²`, the difference being `p(1 − q)² + q(1 − p)²`. -/
theorem L275_pair (p q : ℝ) (hp : 0 ≤ p) (hq : 0 ≤ q) :
    2 * ((1 - p) * (1 - q)) ≤ (2 - p - q) * (1 - p * q) := by
  nlinarith [mul_nonneg hp (sq_nonneg (1 - q)), mul_nonneg hq (sq_nonneg (1 - p))]

/-- **Step (5)'s closing inequality**: for `4 − 2√2 < κ < 2`, written as `κ² − 8κ + 8 < 0`, and `1 − 1/κ ≤ s ≤ ½`,
`(κ s + 1 − κ)(1 − s)(2 − κ + 2κ s) ≤ s (2 − κ)`, which is `s/((1 − s)(1 + γ s)) ≥ κ s + 1 − κ` with `γ = 2κ/(2 − κ)`.
The difference is `(1 − 2s)((κ − 1) − (κ(1 − s) − 1)²)`. -/
theorem L275_close (κ s : ℝ) (hk : κ ^ 2 - 8 * κ + 8 < 0) (hk2 : κ < 2) (hs0 : 1 - 1 / κ ≤ s) (hs1 : s ≤ 1 / 2) :
    (κ * s + 1 - κ) * (1 - s) * (2 - κ + 2 * κ * s) ≤ s * (2 - κ) := by
  have hk1 : 1 < κ := by nlinarith
  have hv : κ * (1 - s) ≤ 1 := by
    have : 1 - 1 / κ ≤ s := hs0
    have h : κ * (1 - 1 / κ) = κ - 1 := by field_simp
    nlinarith
  have hv2 : κ / 2 ≤ κ * (1 - s) := by nlinarith
  have hbr : 0 ≤ (κ - 1) - (κ * (1 - s) - 1) ^ 2 := by
    have : (κ * (1 - s) - 1) ^ 2 ≤ (1 - κ / 2) ^ 2 := by nlinarith
    nlinarith
  have hfac : s * (2 - κ) - (κ * s + 1 - κ) * (1 - s) * (2 - κ + 2 * κ * s)
      = (1 - 2 * s) * ((κ - 1) - (κ * (1 - s) - 1) ^ 2) := by ring
  nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ 1 - 2 * s) hbr]

/-- `Q(g, t) = 2t(t+1)g² − (3t−1)(t+1)g + t² ≥ 0` on `[0,1]²`. -/
theorem L275_interp_Q (g t : ℝ) (hg0 : 0 ≤ g) (_hg1 : g ≤ 1) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    0 ≤ 2 * t * (t + 1) * g ^ 2 - (3 * t - 1) * (t + 1) * g + t ^ 2 := by
  rcases le_total t (1 / 3) with h | h
  · have : 0 ≤ (1 - 3 * t) * (t + 1) * g := mul_nonneg (mul_nonneg (by linarith) (by linarith)) hg0
    nlinarith [mul_nonneg (mul_nonneg ht0 (by linarith : (0:ℝ) ≤ t + 1)) (sq_nonneg g), sq_nonneg t]
  · have ht : 0 < t := by linarith
    have key : 8 * t * (2 * t * (t + 1) * g ^ 2 - (3 * t - 1) * (t + 1) * g + t ^ 2)
        = (t + 1) * (4 * t * g - 3 * t + 1) ^ 2 + (1 - t) * (t ^ 2 + 4 * t - 1) := by ring
    have h1 : 0 ≤ (t + 1) * (4 * t * g - 3 * t + 1) ^ 2 := mul_nonneg (by linarith) (sq_nonneg _)
    have h2 : 0 ≤ (1 - t) * (t ^ 2 + 4 * t - 1) := mul_nonneg (by linarith) (by nlinarith)
    have : 0 ≤ 8 * t * (2 * t * (t + 1) * g ^ 2 - (3 * t - 1) * (t + 1) * g + t ^ 2) := by rw [key]; linarith
    by_contra hc; push Not at hc; nlinarith

/-- The symmetric case of PI, through `g(1−g)(1−t) Q(g,t)`. -/
theorem L275_interp_sym (g t : ℝ) (hg0 : 0 ≤ g) (hg1 : g ≤ 1) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    (1 + t) * g ^ 2 ≤ (2 * t * g ^ 2 + (1 - t) * g) * (1 - (1 - g) ^ 2 * (1 - t ^ 2)) := by
  have hQ := L275_interp_Q g t hg0 hg1 ht0 ht1
  have e : (2 * t * g ^ 2 + (1 - t) * g) * (1 - (1 - g) ^ 2 * (1 - t ^ 2)) - (1 + t) * g ^ 2
      = g * (1 - g) * (1 - t) * (2 * t * (t + 1) * g ^ 2 - (3 * t - 1) * (t + 1) * g + t ^ 2) := by ring
  have : 0 ≤ g * (1 - g) * (1 - t) * (2 * t * (t + 1) * g ^ 2 - (3 * t - 1) * (t + 1) * g + t ^ 2) :=
    mul_nonneg (mul_nonneg (mul_nonneg hg0 (by linarith)) (by linarith)) hQ
  linarith

/-- **The interpolation between the two faces of J1** (the J1 working note's PI), cleared of its denominator, in `a = 1 − p`, `b = 1 − q`: reduced to the symmetric case at `g = √(ab)`. -/
theorem L275_interp (a b t : ℝ) (ha0 : 0 ≤ a) (ha1 : a ≤ 1) (hb0 : 0 ≤ b) (hb1 : b ≤ 1) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    (1 + t) * (a * b) ≤ (t * (a ^ 2 + b ^ 2) + (1 - t) * (a + b) / 2) * (1 - (1 - a) * (1 - b) * (1 - t ^ 2)) := by
  set g := Real.sqrt (a * b) with hgdef
  have hg0 : 0 ≤ g := Real.sqrt_nonneg _
  have hg2 : g ^ 2 = a * b := Real.sq_sqrt (mul_nonneg ha0 hb0)
  have hg1 : g ≤ 1 := by
    have : a * b ≤ 1 := by nlinarith
    nlinarith
  have hm : g ≤ (a + b) / 2 := by nlinarith [sq_nonneg (a - b), sq_nonneg (g - (a + b) / 2)]
  have hF : 2 * t * g ^ 2 + (1 - t) * g ≤ t * (a ^ 2 + b ^ 2) + (1 - t) * (a + b) / 2 := by
    have : 2 * g ^ 2 ≤ a ^ 2 + b ^ 2 := by rw [hg2]; nlinarith [sq_nonneg (a - b)]
    nlinarith [mul_le_mul_of_nonneg_left hm (by linarith : (0:ℝ) ≤ 1 - t)]
  have hD : 1 - (1 - g) ^ 2 * (1 - t ^ 2) ≤ 1 - (1 - a) * (1 - b) * (1 - t ^ 2) := by
    have h : (1 - a) * (1 - b) ≤ (1 - g) ^ 2 := by nlinarith
    have : 0 ≤ 1 - t ^ 2 := by nlinarith
    nlinarith [mul_le_mul_of_nonneg_right h this]
  have hF0 : 0 ≤ 2 * t * g ^ 2 + (1 - t) * g := by
    have := mul_nonneg (by linarith : (0:ℝ) ≤ 1 - t) hg0; nlinarith [sq_nonneg g]
  have hD0 : 0 ≤ 1 - (1 - g) ^ 2 * (1 - t ^ 2) := by
    have : (1 - g) ^ 2 ≤ 1 := by nlinarith
    have : 0 ≤ 1 - t ^ 2 := by nlinarith
    nlinarith
  have hs := L275_interp_sym g t hg0 hg1 ht0 ht1
  calc (1 + t) * (a * b) = (1 + t) * g ^ 2 := by rw [hg2]
    _ ≤ (2 * t * g ^ 2 + (1 - t) * g) * (1 - (1 - g) ^ 2 * (1 - t ^ 2)) := hs
    _ ≤ _ := mul_le_mul hF hD hD0 (le_trans hF0 hF)

end HamiltonsCubic.L275
