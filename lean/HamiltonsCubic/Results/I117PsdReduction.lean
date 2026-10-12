import Mathlib

set_option linter.style.longLine false

/-!
# Statement H reduces to positive-definite idempotents: the scalar cores

[The D6 working note](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 33.

## What is proved

* `weighted_amgm`: for nonnegative weights `w t` and reals `a t`, `b t`,
  `∑ w a b ≤ ½ (∑ w a² + ∑ w b²)`. This is Lemma A's step: with `w` the products `σ_k σ_l σ_m` of singular
  values and `a`, `b` the structure constants on the left and right singular frames, it gives
  `F(X) ≤ ½ (F(|Xᵀ|) + F(|X|))`.
* `three_ratio`: `xy/z + yz/x + zx/y ≥ x + y + z` for positive reals, Lemma C's step.
* `delta_scalar`: Lemma D's step: if `W * W = W + diagonal Δ` and `W` has an eigenvector `v` with positive
  entries, then every `Δ i = ρ² - ρ`, so `Δ` is scalar.
* `sympair_idem`: Lemma E's scalar core: on a symmetric-pair family `a P_k + b P_p`, the idempotent equations
  `a² c_k + b² β = a`, `a b c = b` with `c_k + β = c`, `β > 0`, force `a = 1/c` and `b² = 1/c²` once `b ≠ 0`.
* `twocomp_factor`, `twocomp_pd_unique`: Lemma F's scalar core (batch 38): on a two-component family
  `a P_k + b P_p` with `P_k # P_k = c₁ P_k`, `P_k # P_p = α P_p`, `P_p # P_p = x P_k + y P_p`, `c₁ + x = c`,
  `2α + y = c`, the idempotent equations factor as `(c b - 1)((c₁ y² + 4 α² x) b - c (y - x)) = 0`, so with
  `y ≤ x` (equivalently `Cas_k(p) ≥ ½ Cas_k(k)`) the only idempotent with `b > 0` is `a = b = 1/c`.
* `trace_le_of_pairing`: from a nonnegative weight `c i j k` invariant under the cyclic shift, with
  `∑_{i,j} c i j k = 2γ` for every `k`, positive `λ`, and the pairing identity
  `d = ½ ∑ c i j k λ_i λ_j / λ_k`, it follows that `γ ∑ λ ≤ d` (Lemma C's `tr C ≤ d/c`, with `γ` the Casimir
  constant `c`).

## What is NOT stated

Lemma D's Perron–Frobenius step (a positive, simple top eigenvector of a nonnegative irreducible symmetric
matrix: Mathlib carries no Perron–Frobenius theorem) and its conclusion `W = t (J - I)` are prose. The
operator steps (the singular value expansion of `F`, the eigenframe expansion of `⟨C#C, C⁻¹⟩`, the
Casimir row sums, Lemma B's range argument and the equality case) enter as hypotheses or stay in prose.
-/

namespace HamiltonsCubic.I117PsdReduction

open Finset

theorem weighted_amgm {ι : Type*} (s : Finset ι) (w a b : ι → ℝ) (hw : ∀ t ∈ s, 0 ≤ w t) :
    ∑ t ∈ s, w t * a t * b t ≤ (1 / 2) * (∑ t ∈ s, w t * a t ^ 2 + ∑ t ∈ s, w t * b t ^ 2) := by
  rw [← sum_add_distrib, mul_sum]
  apply sum_le_sum
  intro t ht
  have := hw t ht
  nlinarith [sq_nonneg (a t - b t), mul_nonneg this (sq_nonneg (a t - b t))]

theorem three_ratio (x y z : ℝ) (hx : 0 < x) (hy : 0 < y) (hz : 0 < z) :
    x + y + z ≤ x * y / z + y * z / x + z * x / y := by
  rw [div_add_div _ _ hz.ne' hx.ne', div_add_div _ _ (by positivity) hy.ne', le_div_iff₀ (by positivity)]
  nlinarith [sq_nonneg (x * y - y * z), sq_nonneg (y * z - z * x), sq_nonneg (z * x - x * y),
    mul_pos hx hy, mul_pos hy hz, mul_pos hz hx, mul_pos (mul_pos hx hy) hz]

/-- Cyclic relabelling of a triple sum over `Fin d`. -/
theorem cyc_sum {d : ℕ} (g : Fin d → Fin d → Fin d → ℝ) :
    ∑ i, ∑ j, ∑ k, g j k i = ∑ i, ∑ j, ∑ k, g i j k := by
  rw [Finset.sum_comm]
  apply sum_congr rfl
  intro j _
  rw [Finset.sum_comm]

theorem trace_le_of_pairing {d : ℕ} (c : Fin d → Fin d → Fin d → ℝ) (lam : Fin d → ℝ) (γ D : ℝ)
    (hc : ∀ i j k, 0 ≤ c i j k) (hcyc : ∀ i j k, c i j k = c j k i)
    (hrow : ∀ k, ∑ i, ∑ j, c i j k = 2 * γ) (hlam : ∀ k, 0 < lam k)
    (hpair : D = (1 / 2) * ∑ i, ∑ j, ∑ k, c i j k * (lam i * lam j / lam k)) :
    γ * ∑ k, lam k ≤ D := by
  set g : Fin d → Fin d → Fin d → ℝ := fun i j k => c i j k * (lam i * lam j / lam k) with hg
  -- the three cyclic versions of the ratio sum coincide
  have e2 : ∑ i, ∑ j, ∑ k, c i j k * (lam j * lam k / lam i) = ∑ i, ∑ j, ∑ k, g i j k := by
    rw [← cyc_sum g]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    simp only [hg]; rw [hcyc i j k]
  have e3 : ∑ i, ∑ j, ∑ k, c i j k * (lam k * lam i / lam j) = ∑ i, ∑ j, ∑ k, g i j k := by
    rw [← e2, ← cyc_sum (fun i j k => c i j k * (lam j * lam k / lam i))]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    rw [hcyc i j k]
  -- the marginal: the first-slot weights sum to 2γ, so each linear sum is 2γ ∑ λ
  have m1 : ∑ i, ∑ j, ∑ k, c i j k * lam i = 2 * γ * ∑ k, lam k := by
    rw [mul_sum]
    apply sum_congr rfl; intro i _
    have : ∑ j, ∑ k, c i j k = 2 * γ := by
      rw [← hrow i]; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
      rw [hcyc i j k]
    rw [← this, sum_mul]; apply sum_congr rfl; intro j _; rw [sum_mul]
  have m2 : ∑ i, ∑ j, ∑ k, c i j k * lam j = 2 * γ * ∑ k, lam k := by
    rw [← m1, ← cyc_sum (fun i j k => c i j k * lam i)]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    rw [hcyc i j k]
  have m3 : ∑ i, ∑ j, ∑ k, c i j k * lam k = 2 * γ * ∑ k, lam k := by
    rw [← m2, ← cyc_sum (fun i j k => c i j k * lam j)]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    rw [hcyc i j k]
  -- pointwise three_ratio, weighted by c ≥ 0
  have pt : ∑ i, ∑ j, ∑ k, (c i j k * lam i + c i j k * lam j + c i j k * lam k) ≤
      ∑ i, ∑ j, ∑ k, (g i j k + c i j k * (lam j * lam k / lam i) + c i j k * (lam k * lam i / lam j)) := by
    apply sum_le_sum; intro i _; apply sum_le_sum; intro j _; apply sum_le_sum; intro k _
    have h := three_ratio (lam i) (lam j) (lam k) (hlam i) (hlam j) (hlam k)
    have hck := hc i j k
    simp only [hg]
    nlinarith [mul_le_mul_of_nonneg_left h hck]
  simp only [sum_add_distrib] at pt
  rw [m1, m2, m3, e2, e3] at pt
  rw [hpair]
  simp only [hg] at pt ⊢
  linarith

/-- Lemma D's step: a positive eigenvector makes the diagonal defect of `W² = W + Δ` scalar. -/
theorem delta_scalar {n : ℕ} (W : Matrix (Fin n) (Fin n) ℝ) (Δ v : Fin n → ℝ) (ρ : ℝ)
    (hW2 : W * W = W + Matrix.diagonal Δ) (hv : W.mulVec v = ρ • v) (hpos : ∀ i, 0 < v i) :
    ∀ i, Δ i = ρ ^ 2 - ρ := by
  intro i
  have h1 : (W * W).mulVec v = (ρ ^ 2) • v := by
    rw [← Matrix.mulVec_mulVec, hv, Matrix.mulVec_smul, hv, smul_smul, sq]
  have h2 : (W + Matrix.diagonal Δ).mulVec v = ρ • v + fun j => Δ j * v j := by
    rw [Matrix.add_mulVec, hv]
    congr 1
    funext j
    exact Matrix.mulVec_diagonal Δ v j
  rw [hW2, h2] at h1
  have hi := congrFun h1 i
  simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul] at hi
  have hvi := (hpos i).ne'
  field_simp at hi ⊢
  nlinarith [hi]

/-- Lemma E's scalar core: a nonzero `p`-weight forces the identity's weights. -/
theorem sympair_idem (a b c ck β : ℝ) (hc : 0 < c) (hβ : 0 < β) (hsum : ck + β = c)
    (h1 : a ^ 2 * ck + b ^ 2 * β = a) (h2 : a * b * c = b) (hb : b ≠ 0) :
    a = 1 / c ∧ b ^ 2 = 1 / c ^ 2 := by
  have ha : a = 1 / c := by
    have : a * c = 1 := by
      have := mul_right_cancel₀ hb (by linarith [h2] : a * c * b = 1 * b)
      linarith
    field_simp; linarith
  refine ⟨ha, ?_⟩
  subst ha
  have hck : ck = c - β := by linarith
  rw [hck] at h1
  field_simp at h1 ⊢
  nlinarith [h1, hβ]

/-- Lemma F's scalar core: the second root of the two-component idempotent equations. -/
theorem twocomp_factor (a b c c1 x y α : ℝ) (hsum1 : c1 + x = c) (hsum2 : 2 * α + y = c)
    (h1 : a ^ 2 * c1 + b ^ 2 * x = a) (h2 : 2 * a * b * α + b ^ 2 * y = b) (hb : b ≠ 0) :
    (c * b - 1) * ((c1 * y ^ 2 + 4 * α ^ 2 * x) * b - c * (y - x)) = 0 := by
  have e : 2 * a * α + b * y = 1 := by
    have : (2 * a * α + b * y) * b = 1 * b := by linarith
    exact mul_right_cancel₀ hb this
  obtain rfl : c = 2 * α + y := by linarith
  obtain rfl : c1 = 2 * α + y - x := by linarith
  linear_combination (4 * α ^ 2 * (2 * α + y)) * h1
    - ((2 * α + y) * ((2 * α + y - x) * (2 * a * α + 1 - b * y) - 2 * α)) * e

/-- Lemma F's conclusion: with `y ≤ x`, the only idempotent with positive weights is `I/c`. -/
theorem twocomp_pd_unique (a b c c1 x y α : ℝ) (hx : 0 < x) (hα : 0 < α) (hc1 : 0 < c1)
    (hsum1 : c1 + x = c) (hsum2 : 2 * α + y = c)
    (h1 : a ^ 2 * c1 + b ^ 2 * x = a) (h2 : 2 * a * b * α + b ^ 2 * y = b)
    (hb : 0 < b) (hxy : y ≤ x) : a = 1 / c ∧ b = 1 / c := by
  have hf := twocomp_factor a b c c1 x y α hsum1 hsum2 h1 h2 hb.ne'
  have hD : 0 < c1 * y ^ 2 + 4 * α ^ 2 * x := by positivity
  have hpos : 0 < (c1 * y ^ 2 + 4 * α ^ 2 * x) * b - c * (y - x) := by
    have hc : 0 < c := by linarith
    nlinarith [mul_pos hD hb, mul_nonneg hc.le (sub_nonneg.mpr hxy)]
  have hcb : c * b = 1 := by
    rcases mul_eq_zero.mp hf with h | h
    · linarith
    · linarith
  have hc : c ≠ 0 := by intro h; rw [h] at hcb; simp at hcb
  have hbc : b = 1 / c := by field_simp; linarith
  refine ⟨?_, hbc⟩
  have e : 2 * a * α + b * y = 1 := by
    have : (2 * a * α + b * y) * b = 1 * b := by linarith
    exact mul_right_cancel₀ hb.ne' this
  rw [hbc] at e
  have hα2 : 2 * α = c - y := by linarith
  field_simp at e ⊢
  nlinarith [e, hα]

end HamiltonsCubic.I117PsdReduction
