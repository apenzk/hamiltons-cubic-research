import Mathlib

set_option linter.style.longLine false

/-!
# L223, the stability of L57 at a near-critical diagonal tensor: the polynomial cores

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L223: for `S ∈ 𝒟ₙ` of unit norm with
`S ∘ S = λ S + E`, `E ∈ 𝒟ₙ`, L57's three steps hold with their defects, and every defect is bounded by
`Δ = Θ̄ - λ + e₋/μ`, so `S` lies within `(√2 + 4√(n-2)/(1 - Δ/Θ̄)) √(Δ/Θ̄)` of a sphere product.

## What is typed

* `Z_norm_sq`: `Σ_{i≠j} Z_ij v_i v_j = 2(n²-3n+3)/(2(n-1)(n-2)) - (n/(n-2)) Σ v⁴` at `Σ v = 0`, `Σ v² = 1`,
  the norm formula L57 carried without a derivation;
* `fourth_moment_defect`: `Σ (v_i² - 1/n)² = Σ v⁴ - 1/n` at `Σ v² = 1`;
* `coord_bound`: `|a - c| ≤ |a² - c²| / c` for `a ≥ 0 < c`;
* `chain_defects`: the three defect bounds from the chained inequality;
* `cube_le`, `mu_lower`: the lower bound `μ ≥ (λ - |E|)/2`;
* `one_sub_sq_le`, `Zstar_theta`, `radius_constant`, `theta_gap_odd`: the constants;
* `unit_diff_le`: `‖x/‖x‖ - y/‖y‖‖ ≤ 2‖x - y‖/‖x‖`.

**Not typed**: `𝒟ₙ`, the product, the pairing of the critical equation with `v ⊗ v`, the orthogonal projection
`Z(v)` and the block-constant reduction to a sphere product, which are the prose.
-/

namespace HamiltonsCubic.L223Statement

open Finset

variable {ι : Type*} [Fintype ι]

/-- **The fourth-moment defect is a sum of squares**: `Σ (v_i² - 1/n)² = Σ v⁴ - 1/n` when `Σ v² = 1`. -/
theorem fourth_moment_defect (v : ι → ℝ) (hn : 0 < (Fintype.card ι : ℝ)) (h2 : ∑ i, v i ^ 2 = 1) :
    ∑ i, (v i ^ 2 - 1 / (Fintype.card ι : ℝ)) ^ 2 = ∑ i, v i ^ 4 - 1 / (Fintype.card ι : ℝ) := by
  have e : ∀ i, (v i ^ 2 - 1 / (Fintype.card ι : ℝ)) ^ 2
      = v i ^ 4 - 2 / (Fintype.card ι : ℝ) * v i ^ 2 + 1 / (Fintype.card ι : ℝ) ^ 2 := fun i => by ring
  simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, h2,
    Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  field_simp
  ring

/-- **The norm of `L57`'s projection**, over ordered off-diagonal pairs: with
`Z_ij = v_i v_j + (v_i² + v_j²)/(n-2) - 1/((n-1)(n-2))`, `Σ v = 0` and `Σ v² = 1`,
the full double sum of `Z_ij v_i v_j` is `1`, and removing the diagonal leaves twice L57's `|Z(v)|²`.
`n` enters only through `Z`: the identity is algebraic, and `n = card ι` is what makes `Z` the projection. -/
theorem Z_norm_sq (v : ι → ℝ) (n : ℝ) (hn3 : 3 < n)
    (h1 : ∑ i, v i = 0) (h2 : ∑ i, v i ^ 2 = 1) :
    (∑ i, ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j)
      - ∑ i, (v i * v i + (v i ^ 2 + v i ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v i
      = 2 * ((n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * ∑ i, v i ^ 4) := by
  have hn2 : n - 2 ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  have inner : ∀ i, ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j
      = v i ^ 2 * (∑ j, v j ^ 2) + v i ^ 3 / (n - 2) * (∑ j, v j) + v i / (n - 2) * (∑ j, v j ^ 3)
        - v i / ((n - 1) * (n - 2)) * (∑ j, v j) := by
    intro i
    calc ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j
        = ∑ j, (v i ^ 2 * v j ^ 2 + v i ^ 3 / (n - 2) * v j + v i / (n - 2) * v j ^ 3
            - v i / ((n - 1) * (n - 2)) * v j) :=
          Finset.sum_congr rfl fun j _ => by field_simp; ring
      _ = _ := by
          rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.mul_sum,
            Finset.mul_sum, Finset.mul_sum, Finset.mul_sum]
  have h3 : ∑ i, ∑ j, (v i * v j + (v i ^ 2 + v j ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v j
      = 1 := by
    rw [Finset.sum_congr rfl fun i _ => inner i]
    simp only [h1, h2, mul_zero, mul_one, add_zero, sub_zero, Finset.sum_add_distrib, ← Finset.sum_mul,
      ← Finset.sum_div, zero_div, zero_mul]
  have h4 : ∑ i, (v i * v i + (v i ^ 2 + v i ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v i
      = (1 + 2 / (n - 2)) * ∑ i, v i ^ 4 - 1 / ((n - 1) * (n - 2)) := by
    have : ∀ i, (v i * v i + (v i ^ 2 + v i ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) * v i * v i
        = (1 + 2 / (n - 2)) * v i ^ 4 - 1 / ((n - 1) * (n - 2)) * v i ^ 2 := fun i => by ring
    simp only [this, Finset.sum_sub_distrib, ← Finset.mul_sum, h2, mul_one]
  rw [h3, h4]
  field_simp
  ring

/-- **A coordinate near `±1/√n`**: `|a - c| ≤ |a² - c²| / c` for `a ≥ 0` and `c > 0`. -/
theorem coord_bound (a c : ℝ) (ha : 0 ≤ a) (hc : 0 < c) : |a - c| ≤ |a ^ 2 - c ^ 2| / c := by
  rw [le_div_iff₀ hc, show a ^ 2 - c ^ 2 = (a - c) * (a + c) by ring, abs_mul,
    abs_of_nonneg (by linarith : 0 ≤ a + c)]
  exact mul_le_mul_of_nonneg_left (by linarith) (abs_nonneg _)

/-- **The three defects of L57's chain**: from `λ ≤ Θ r cos α - η/μ + e/μ` with `r, cos α ∈ [0,1]` and
`η ≥ 0`, each of `1 - cos α`, `1 - r` is at most `Δ/Θ` and `η ≤ μΔ`, where `Δ = Θ - λ + e/μ`. -/
theorem chain_defects (Θ lam μ r c η e : ℝ) (hΘ : 0 < Θ) (hμ : 0 < μ) (hr0 : 0 ≤ r) (hr1 : r ≤ 1)
    (hc0 : 0 ≤ c) (hc1 : c ≤ 1) (hη : 0 ≤ η)
    (hchain : lam ≤ Θ * r * c - η / μ + e / μ) :
    1 - c ≤ (Θ - lam + e / μ) / Θ ∧ 1 - r ≤ (Θ - lam + e / μ) / Θ ∧ η ≤ μ * (Θ - lam + e / μ) := by
  have hημ : 0 ≤ η / μ := div_nonneg hη hμ.le
  have hrc : r * c ≤ c := by nlinarith
  have hrc' : r * c ≤ r := by nlinarith
  have key : Θ * (1 - r * c) + η / μ ≤ Θ - lam + e / μ := by nlinarith
  refine ⟨?_, ?_, ?_⟩
  · rw [le_div_iff₀ hΘ]; nlinarith
  · rw [le_div_iff₀ hΘ]; nlinarith
  · have h1 : η / μ ≤ Θ - lam + e / μ := by nlinarith
    have := mul_le_mul_of_nonneg_left h1 hμ.le
    rwa [mul_div_cancel₀ η hμ.ne'] at this

/-- **An entry or an eigenvalue below the top eigenvalue**: `s ≤ μ` gives `s³ ≤ μ s²`. -/
theorem cube_le (s μ : ℝ) (hs : s ≤ μ) : s ^ 3 ≤ μ * s ^ 2 := by
  nlinarith [sq_nonneg s]

/-- **The top eigenvalue is bounded below**: `P ≤ 2μ` and `P ≥ λ - |E|` give `μ ≥ (λ - |E|)/2`. -/
theorem mu_lower (lam μ E P : ℝ) (hP : P ≤ 2 * μ) (hPE : lam - E ≤ P) : (lam - E) / 2 ≤ μ := by
  linarith

/-- `1 - r² ≤ 2(1 - r)` for every real `r`. -/
theorem one_sub_sq_le (r : ℝ) : 1 - r ^ 2 ≤ 2 * (1 - r) := by
  nlinarith [sq_nonneg (1 - r)]

/-- **`Θ̄ = ((n-1)/n)·2Z*`**, squared, with `Z*² = (n-2)/(2(n-1))`. -/
theorem Zstar_theta (n : ℝ) (hn : 2 < n) :
    ((n - 1) / n) ^ 2 * 4 * ((n - 2) / (2 * (n - 1))) = 2 * (n - 1) * (n - 2) / n ^ 2 := by
  have : n - 1 ≠ 0 := by linarith
  have : n ≠ 0 := by linarith
  field_simp
  ring

/-- **The radius constant**, squared: `(2√(2(n-2)²/(n-1)) / Z*)² = 16(n-2)`. -/
theorem radius_constant (n : ℝ) (hn : 2 < n) :
    (4 * (2 * (n - 2) ^ 2 / (n - 1))) / ((n - 2) / (2 * (n - 1))) = 16 * (n - 2) := by
  have : n - 1 ≠ 0 := by linarith
  have : n - 2 ≠ 0 := by linarith
  field_simp
  ring

/-- **The odd-`n` gap between the even formula and `Θₙ`**: `Θ̄² - Θₙ² = 8(n-1)/(n²(n+1)(n-2))`. -/
theorem theta_gap_odd (n : ℝ) (hn : 2 < n) :
    2 * (n - 1) * (n - 2) / n ^ 2 - 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))
      = 8 * (n - 1) / (n ^ 2 * (n + 1) * (n - 2)) := by
  have : n - 2 ≠ 0 := by linarith
  have : n + 1 ≠ 0 := by linarith
  have : n ≠ 0 := by linarith
  field_simp
  ring

/-- **Normalising is `2/‖x‖`-Lipschitz**: `‖x/‖x‖ - y/‖y‖‖ ≤ 2‖x - y‖/‖x‖` for nonzero `x`, `y`. -/
theorem unit_diff_le {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (x y : E) (hx : x ≠ 0)
    (hy : y ≠ 0) : ‖‖x‖⁻¹ • x - ‖y‖⁻¹ • y‖ ≤ 2 * ‖x - y‖ / ‖x‖ := by
  have hxn : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hyn : 0 < ‖y‖ := norm_pos_iff.mpr hy
  have split : ‖x‖⁻¹ • x - ‖y‖⁻¹ • y = ‖x‖⁻¹ • (x - y) + (‖x‖⁻¹ - ‖y‖⁻¹) • y := by
    rw [smul_sub, sub_smul]; abel
  have t1 : ‖‖x‖⁻¹ • (x - y)‖ = ‖x - y‖ / ‖x‖ := by
    rw [norm_smul, norm_inv, norm_norm, inv_mul_eq_div]
  have t2 : ‖(‖x‖⁻¹ - ‖y‖⁻¹) • y‖ = |‖y‖ - ‖x‖| / ‖x‖ := by
    rw [norm_smul, Real.norm_eq_abs, show ‖x‖⁻¹ - ‖y‖⁻¹ = (‖y‖ - ‖x‖) / (‖x‖ * ‖y‖) by
      field_simp, abs_div, abs_of_pos (mul_pos hxn hyn)]
    field_simp
  have t3 : |‖y‖ - ‖x‖| ≤ ‖x - y‖ := by
    rw [abs_sub_comm]; exact abs_norm_sub_norm_le x y
  calc ‖‖x‖⁻¹ • x - ‖y‖⁻¹ • y‖ ≤ ‖‖x‖⁻¹ • (x - y)‖ + ‖(‖x‖⁻¹ - ‖y‖⁻¹) • y‖ := by
        rw [split]; exact norm_add_le _ _
    _ = ‖x - y‖ / ‖x‖ + |‖y‖ - ‖x‖| / ‖x‖ := by rw [t1, t2]
    _ ≤ ‖x - y‖ / ‖x‖ + ‖x - y‖ / ‖x‖ := by gcongr
    _ = 2 * ‖x - y‖ / ‖x‖ := by ring

/-- **The balanced split**: `p + q` even and `|p - q| < 2` force `p = q`. -/
theorem balanced_split (p q : ℤ) (h : |p - q| < 2) (hpar : Even (p + q)) : p = q := by
  obtain ⟨k, hk⟩ := hpar
  rw [abs_lt] at h
  omega

/-- **The sign partition's imbalance**: `Σ w = (p - q)/√n`, `Σ v = 0` and `|Σ (w - v)| ≤ √n ‖w - v‖` give
`|p - q| ≤ n ‖v - w‖`, written with `s = √n`. -/
theorem split_le (pq s d : ℝ) (hs : 0 < s) (hsum : |pq / s| ≤ s * d) : |pq| ≤ s ^ 2 * d := by
  rw [abs_div, abs_of_pos hs, div_le_iff₀ hs] at hsum
  nlinarith

/-- A witness for `chain_defects`: `Θ = 1`, `λ = 1/2`, `μ = 1`, `r = c = 1`, `η = e = 0`. -/
example : 1 - (1 : ℝ) ≤ (1 - 1 / 2 + 0 / 1) / 1 ∧ 1 - (1 : ℝ) ≤ (1 - 1 / 2 + 0 / 1) / 1 ∧
    (0 : ℝ) ≤ 1 * (1 - 1 / 2 + 0 / 1) :=
  chain_defects 1 (1 / 2) 1 1 1 0 0 one_pos one_pos zero_le_one le_rfl zero_le_one le_rfl le_rfl
    (by norm_num)

end HamiltonsCubic.L223Statement
