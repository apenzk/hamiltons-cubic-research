import Mathlib
import HamiltonsCubic.Results.BianchiTraced

/-!
# L251: at `n = 12` the symmetric family has no critical point above `θ₀` with `p = 15`

[the per-vector note](../../../reviews/2026-09-25-I73c-per-vector-rows.md), the paragraph on `p = 15`.

**`quartic_sum_le`**: for any family of skew matrices `ψ_a`,
`∑_{a,b} tr(ψ_a ψ_b ψ_a ψ_b) ≤ ½ ∑_{a,b} tr(ψ_a ψ_b)²`, since by `wedge_gram` the difference is
`(1/24) ∑_{ijkl} (∑_a ψ_a ∧ ψ_a)²_{ijkl} ≥ 0`. For a `½ tr`-orthonormal family the right side is `2p`.

**`moment_ceiling`**: with the sphere average `E tr x⁴ = (2 tr A₀² + ∑_{a,b} tr(ψ_aψ_bψ_aψ_b))/(p(p+2))`
over the unit sphere of `E₀`, the bound above and `tr A₀² ≤ (11/2) tr A₀ = 11p` give
`E tr x⁴ ≤ 24/(p+2)`, `24/17` at `p = 15`.

**The angle steps.** `x` has angles `s₁ ≥ … ≥ s₆ ≥ 0`, `∑ s² = 1`, and `μ₃₆(x)` is twice the sum of
the 15 smallest of the 30 values `(s_i ∓ s_j)²`. That order-statistic reduction, and the Gram row-sum
bound (any `q` of the values on a vertex set carrying `∑ s² = T` sum to at most `(q+1) T`), enter as
hypotheses: the layer defines no angles of a skew matrix. What is typed here are the scalar steps
each case of the dichotomy ends in (`slice_gap`, `vertex_split`, `three_way`, `four_way`, `band_constants`), the
threshold `p15_threshold`, and the closing contradiction `p15_contradiction`.
-/

open HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer HamiltonsCubic.BianchiTraced Matrix

namespace HamiltonsCubic.L251P15

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The quartic sum of a skew family is at most half its squared Gram traces.** `wedge_gram`
summed over `a, b` is the square of `∑_a ψ_a ∧ ψ_a`, entry by entry. -/
theorem quartic_sum_le {p : ℕ} (ψ : Fin p → Matrix ι ι ℝ) (hψ : ∀ a, IsSkew (ψ a)) :
    ∑ a, ∑ b, (ψ a * ψ b * ψ a * ψ b).trace
      ≤ (1 / 2) * ∑ a, ∑ b, (ψ a * ψ b).trace ^ 2 := by
  have S_sum : ∀ g : Fin p → ι → ι → ι → ι → ℝ,
      (∑ i, ∑ j, ∑ k, ∑ l, ∑ a, g a i j k l) = ∑ a, ∑ i, ∑ j, ∑ k, ∑ l, g a i j k l := by
    intro g
    calc _ = ∑ i, ∑ j, ∑ k, ∑ a, ∑ l, g a i j k l := by
            refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
              Finset.sum_congr rfl fun k _ => Finset.sum_comm
      _ = ∑ i, ∑ j, ∑ a, ∑ k, ∑ l, g a i j k l := by
            refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_comm
      _ = ∑ i, ∑ a, ∑ j, ∑ k, ∑ l, g a i j k l := by
            refine Finset.sum_congr rfl fun i _ => Finset.sum_comm
      _ = _ := Finset.sum_comm
  have hexp : ∑ i, ∑ j, ∑ k, ∑ l, (∑ a, wedgeSelf (ψ a) i j k l) ^ 2
      = ∑ a, ∑ b, (12 * (ψ a * ψ b).trace ^ 2 - 24 * (ψ a * ψ b * ψ a * ψ b).trace) := by
    simp only [sq, Finset.sum_mul_sum]
    rw [S_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [S_sum (fun b i j k l => wedgeSelf (ψ a) i j k l * wedgeSelf (ψ b) i j k l)]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [wedge_gram _ _ (hψ a) (hψ b)]; ring
  have hsq : 0 ≤ ∑ i, ∑ j, ∑ k, ∑ l, (∑ a, wedgeSelf (ψ a) i j k l) ^ 2 :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => Finset.sum_nonneg fun k _ =>
      Finset.sum_nonneg fun l _ => sq_nonneg _
  rw [hexp] at hsq
  simp only [Finset.sum_sub_distrib, ← Finset.mul_sum] at hsq
  linarith

/-- **The sphere average of `tr x⁴` over `E₀` is at most `2n/(p+2)`**, at `n = 12` with the cap
`A₀ ⪯ (11/2) I`: `tr A₀² ≤ 11 p` and the quartic sum at most `2p` give `24/(p+2)`. -/
theorem moment_ceiling (p E trA2 S : ℝ) (hp : 0 < p) (hE : E * (p * (p + 2)) = 2 * trA2 + S)
    (hS : S ≤ 2 * p) (hA : trA2 ≤ 11 * p) : E ≤ 24 / (p + 2) := by
  rw [le_div_iff₀ (by linarith)]
  have h : E * (p + 2) * p ≤ 24 * p := by nlinarith
  exact le_of_mul_le_mul_right h hp

/-- **`p = 15` threshold.** If `θ ≥ θ₀(12) = √(220/144)` then `κ = θ√30` satisfies
`2(7 − κ) < 0.46`, so L249 forces `μ₃₆(x) < 0.46` at every unit `x ∈ E₀`. -/
theorem p15_threshold (θ κ : ℝ) (hκ : κ = θ * Real.sqrt 30) (hθ : Real.sqrt (220 / 144) ≤ θ) :
    2 * (7 - κ) < 46 / 100 := by
  have h30 : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
  have hs30 : 0 < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
  have h0 : Real.sqrt (220 / 144) ^ 2 = 220 / 144 := Real.sq_sqrt (by norm_num)
  have h0p : 0 < Real.sqrt (220 / 144) := Real.sqrt_pos.mpr (by norm_num)
  have hprod : (Real.sqrt (220 / 144) * Real.sqrt 30) ^ 2 = 220 / 144 * 30 := by
    rw [mul_pow, h0, h30]
  have hpos : 0 < Real.sqrt (220 / 144) * Real.sqrt 30 := mul_pos h0p hs30
  have hk0 : 677 / 100 < Real.sqrt (220 / 144) * Real.sqrt 30 := by nlinarith
  have : Real.sqrt (220 / 144) * Real.sqrt 30 ≤ κ := by
    rw [hκ]; exact mul_le_mul_of_nonneg_right hθ hs30.le
  linarith

/-- **The slice `s₁² ∈ [0.83, 0.885)` misses `μ₃₆ ≤ 0.46`, scalar part.** Every value at the top
angle is at least `(s₁ − s_j)²` with `s_j² ≤ T = 1 − s₁²`, which exceeds `0.23`, and the fifteen values
on the other five angles sum to at least `2T > 0.23`. -/
theorem slice_gap (s1 sj T : ℝ) (hs1 : 0 ≤ s1) (hsj : 0 ≤ sj) (hT : s1 ^ 2 + T = 1)
    (hsjT : sj ^ 2 ≤ T) (hlo : 83 / 100 ≤ s1 ^ 2) (hhi : s1 ^ 2 < 885 / 1000) :
    23 / 100 < (s1 - sj) ^ 2 ∧ 23 / 100 < 2 * T := by
  refine ⟨?_, by linarith⟩
  have hs1' : 911 / 1000 < s1 := by nlinarith
  have hsj' : sj < 413 / 1000 := by nlinarith
  nlinarith

/-- **Splitting a gap against a weighted square.** `(a − t)² + c t² ≥ c/(1+c) · a²`, the minimum over
`t` sitting at `t = a/(1+c)`. With `c = 1` it is `d_{1j} + s_j² ≥ s₁²/2`. -/
theorem vertex_split (a t c : ℝ) (hc : 0 < c) : c / (1 + c) * a ^ 2 ≤ (a - t) ^ 2 + c * t ^ 2 := by
  rw [div_mul_eq_mul_div, div_le_iff₀ (by linarith)]
  nlinarith [sq_nonneg ((1 + c) * t - a)]

/-- **A point against two others.** `t² + (a − t)² + (b − t)² ≥ (a² + b²)/3`. -/
theorem three_way (a b t : ℝ) : (a ^ 2 + b ^ 2) / 3 ≤ t ^ 2 + (a - t) ^ 2 + (b - t) ^ 2 := by
  nlinarith [sq_nonneg (3 * t - a - b), sq_nonneg (a - b)]

/-- **A doubled point against two others.** `2t² + (a − t)² + (b − t)² ≥ (a² + b²)/2`. -/
theorem four_way (a b t : ℝ) : (a ^ 2 + b ^ 2) / 2 ≤ 2 * t ^ 2 + (a - t) ^ 2 + (b - t) ^ 2 := by
  nlinarith [sq_nonneg (4 * t - a - b), sq_nonneg (a - b)]

/-- **The band `0.23 < s₁² ≤ 0.46` on a singular angle vector.** With five nonzero angles and
`∑ w = 1`, `w₂ ≥ (1 − w₁)/4 ≥ 0.135` and `Q = w₃ + w₄ + w₅ ≥ 1 − 2 w₁ ≥ 0.08`, so `3Q > 0.23`,
`2 w₂ > 0.23` and `w₁ + w₂ > 0.23`: the three constants the band's cases end in. -/
theorem band_constants (w1 w2 Q : ℝ) (h1 : w1 ≤ 46 / 100) (hlo : 23 / 100 < w1) (h21 : w2 ≤ w1)
    (hsum : w1 + w2 + Q = 1) (hQ : Q ≤ 3 * w2) :
    27 / 200 ≤ w2 ∧ 8 / 100 ≤ Q ∧ 23 / 100 < 3 * Q ∧ 23 / 100 < 2 * w2 ∧ 23 / 100 < w1 + w2 := by
  refine ⟨by linarith, by linarith, by linarith, by linarith, by linarith⟩

/-- **The closing contradiction at `p = 15`.** If every unit `x ∈ E₀` has `s₁² ≥ 0.885`, then
`tr x⁴ = 2 ∑ s⁴ ≥ 2 s₁⁴ ≥ 2(0.885)² > 24/17`, which the sphere average forbids. -/
theorem p15_contradiction (u E : ℝ) (hu : 885 / 1000 ≤ u) (hE : 2 * u ^ 2 ≤ E)
    (hceil : E ≤ 24 / 17) : False := by
  nlinarith

end HamiltonsCubic.L251P15
