import Mathlib

/-!
# No member of the `I`-lift family between H and P is sharp at the balanced product

[The I123 working note](../../../reviews/2026-09-28o-I123-coupling.md), "Third attempt". For
`s ∈ [0,1]` put `G_s(X) = s tr X³ + ⟨X#X, X⟩` on `Sym² 𝔰𝔬(n)`. At a unit Weyl `W`,
`G_s(W + cI) = s A + B + 3c(s-1) + c³N(s+n-2)` with `A = tr W³`, `B = ⟨W#W, W⟩`, so a cap `g_s` on
`G_s` gives `s A + B ≤ b(s) = min_c [g_s (1+c²N)^{3/2} - 3c(s-1) - c³N(s+n-2)]`. With `u = c√N`,
`φ(u) = (1+u²)^{3/2} - u³` and `g_s ≥ G_s(I)/‖I‖³ = (s+n-2)/√N`, the bracket is at least
`((s+n-2)φ(u) + 3u(1-s))/√N`, affine in `s` (`lift_affine`); at `s = 0` its minimum is H's Weyl cap
`β`, and at `s = 1` it is at least `(n-1)/√N > θ₀` because `φ ≥ 1` (`phi_ge_one`,
`theta0_lt_sphere`). So every `s ∈ (0,1]` certifies only a line strictly above the balanced
product's `s t₀ + β`, `t₀ = θ₀ - β` (`lift_not_sharp`).

**Typed**: `φ ≥ 1`, the affine split, the strict and the quantitative gap, `θ₀² < 2(n-1)/n` at
`n = 2m`, and its passage to `θ₀√N < n - 1`. **Not typed**: the expansion of `G_s(W + cI)` (from
`I#W = -W`, `I#I = (n-2)I`), and `β` as the minimum at `s = 0`, attained at `u = -1/√(n(n-2))`
(Gate 2 r1915, r1913); they enter as hypotheses.
-/

namespace HamiltonsCubic.I123LiftFamily

/-- `φ(u) = (1+u²)^{3/2} - u³ ≥ 1`, with `y = (1+u²)^{3/2}` given by `y ≥ 0`, `y² = (1+u²)³`. -/
theorem phi_ge_one (u y : ℝ) (hy : 0 ≤ y) (hy2 : y ^ 2 = (1 + u ^ 2) ^ 3) : 1 ≤ y - u ^ 3 := by
  have key : (1 + u ^ 3) ^ 2 ≤ y ^ 2 := by
    rw [hy2]
    nlinarith [mul_nonneg (sq_nonneg u) (sq_nonneg (u - 1 / 3)), sq_nonneg u]
  nlinarith [sq_nonneg (y - (1 + u ^ 3)), sq_nonneg (y + (1 + u ^ 3))]

/-- The lifted bracket is affine in `s`, between its `H` end and its `P` end. -/
theorem lift_affine (n s φ u : ℝ) :
    (s + n - 2) * φ + 3 * u * (1 - s) = (1 - s) * ((n - 2) * φ + 3 * u) + s * ((n - 1) * φ) := by
  ring

/-- At `n = 2m`, `θ₀² = (2m-1)(m-1)/m²` is below the round sphere's `2(n-1)/n`. -/
theorem theta0_lt_sphere (m : ℝ) (hm : 2 ≤ m) :
    (2 * m - 1) * (m - 1) / m ^ 2 < 2 * (2 * m - 1) / (2 * m) := by
  have hm0 : 0 < m := by linarith
  rw [div_lt_div_iff₀ (by positivity) (by positivity)]
  nlinarith

/-- **No lift is sharp**: for `s ∈ (0,1]`, at every `u`, the lifted bracket (scaled by `R = √N`)
exceeds the balanced product's `s t₀ + β = β + s(θ₀ - β)`, given that `β` is the bracket's minimum
at `s = 0`, `φ ≥ 1`, and `θ₀ R < n - 1`. -/
theorem lift_not_sharp (n s φ u R β θ0 : ℝ) (hs0 : 0 < s) (hs1 : s ≤ 1)
    (hφ : 1 ≤ φ) (hn : 2 ≤ n) (hβ : β * R ≤ (n - 2) * φ + 3 * u) (hθ : θ0 * R < n - 1) :
    (β + s * (θ0 - β)) * R < (s + n - 2) * φ + 3 * u * (1 - s) := by
  rw [lift_affine]
  have h1 : n - 1 ≤ (n - 1) * φ := by nlinarith
  have h2 : (1 - s) * (β * R) ≤ (1 - s) * ((n - 2) * φ + 3 * u) :=
    mul_le_mul_of_nonneg_left hβ (by linarith)
  nlinarith

/-- **The quantitative gap**: for `s ∈ [0,1]` the lifted bracket exceeds the balanced product's
value by at least `s((n-1) - θ₀R)`, which is `s R (√(2(n-1)/n) - θ₀)` at `R = √N`. -/
theorem lift_gap (n s φ u R β θ0 : ℝ) (hs0 : 0 ≤ s) (hs1 : s ≤ 1) (hφ : 1 ≤ φ) (hn : 1 ≤ n)
    (hβ : β * R ≤ (n - 2) * φ + 3 * u) :
    (β + s * (θ0 - β)) * R + s * ((n - 1) - θ0 * R) ≤ (s + n - 2) * φ + 3 * u * (1 - s) := by
  rw [lift_affine]
  have h1 : n - 1 ≤ (n - 1) * φ := by nlinarith
  have h2 : (1 - s) * (β * R) ≤ (1 - s) * ((n - 2) * φ + 3 * u) :=
    mul_le_mul_of_nonneg_left hβ (by linarith)
  nlinarith

/-- `θ₀² < 2(n-1)/n` and `R² = N = n(n-1)/2` give `θ₀ R < n - 1`, the hypothesis of
`lift_not_sharp`. -/
theorem theta0_R_lt (n R θ0 : ℝ) (hn : 1 < n)
    (hRsq : R ^ 2 = n * (n - 1) / 2) (hlt : θ0 ^ 2 < 2 * (n - 1) / n) : θ0 * R < n - 1 := by
  have hn0 : 0 < n := by linarith
  have hsq : (θ0 * R) ^ 2 < (n - 1) ^ 2 := by
    have h1 : θ0 ^ 2 * n < 2 * (n - 1) := by rwa [lt_div_iff₀ hn0] at hlt
    have h2 : (θ0 * R) ^ 2 = θ0 ^ 2 * (n * (n - 1) / 2) := by rw [mul_pow, hRsq]
    rw [h2]
    nlinarith
  by_contra h
  replace h := not_lt.mp h
  have h3 : (n - 1) ^ 2 ≤ (θ0 * R) ^ 2 := by nlinarith
  linarith

/-- Non-vacuity: the hypotheses hold together, at `n = 12`, `s = 1/2`, `φ = 1`, `u = 0`,
`R = 8`, `β = 1`, `θ₀ = 13/10`. -/
example : ((1 : ℝ) + 1 / 2 * (13 / 10 - 1)) * 8 < (1 / 2 + 12 - 2) * 1 + 3 * 0 * (1 - 1 / 2) :=
  lift_not_sharp 12 (1 / 2) 1 0 8 1 (13 / 10) (by norm_num) (by norm_num) le_rfl (by norm_num)
    (by norm_num) (by norm_num)

end HamiltonsCubic.I123LiftFamily
