import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.SpecialFunctions.Pow.Real

set_option linter.style.longLine false

/-!
# L136's sign argument and its assembly

[route-a.md](../../../findings/route-a.md), Lemma L136: on `{F = 0} ∩ T_u𝒪^⊥` the competitor cross term
`2a⟨⋆, X₂⟩` is nonpositive, so `Δ₂ ≤ ‖g₁‖²`. The record signs the anti-self-dual branch by the `ψ` argument
([r427](../../../reviews/REVIEW_r427.md)): *"`φ ≥ 0` with `φ(0) = 0` gives `φ'(0⁺) ≥ 0` from nothing else"*. This
file proves that argument and the arithmetic the box is assembled from:

* **`limit_nonneg`**: a function nonnegative on `t > 0` has a nonnegative limit of `φ(t)/tᵏ` as `t ↓ 0`, so its
  leading one-sided Taylor coefficient is nonnegative at every order;
* **`rightDeriv_nonneg`**: the first-order case, `φ ≥ 0` on `t > 0` and `φ(0) = 0` give `φ'(0⁺) ≥ 0`, which is
  r427's argument as the record runs it, on the Schur sliver `s ↦ tr(Π_A (D_s)₋)`. The chain below runs `limit_nonneg` at `k = 2`
  instead;
* **`trace_proj_psd`**: `tr(Π N) ≥ 0` for an orthogonal projection `Π` and a positive-semidefinite `N`, which is
  why `φ(t) = tr(Π_A (u+tH)₋)` is nonnegative, `(u+tH)₋ = ½(|u+tH| - (u+tH)) ⪰ 0`;
* **`trA_nonneg`**: `tr(Π_A X₂) ≥ 0`, when `X₂` is the `t²`-coefficient of `tr(Π_A (u+tH)₋)` with the lower
  orders vanishing, which is the hypothesis `hlim`. The constant order is `tr(Π_A u₋) = 0`, `u` vanishing on `A`,
  and the first order is `tr(Π_A D₋)`, which `F = 0` kills;
* **`cross_term_nonpos`**: with `⋆ = Π_E - Π_A`, `tr(Π_E X₂) = 0` and `tr(Π_A X₂) ≥ 0`, the cross term is
  nonpositive and `Δ₂ ≤ ‖g₁‖²`;
* **`L136_box`**: the boxed chain `Δ₂ ≤ ‖g₁‖² - ⅔(‖Π_A c₂‖² + ‖Π_A c₃‖²) ≤ ‖g₁‖²` from the record's two identities,
  `𝒦 ≥ 0`, `B₁₂ = B₁₃ = 0` and `a = 1/(3√6)`, the constant being `2a√6 = ⅔`.

**The weak box uses the first identity** for `tr(Π_E X₂) = 0` at `B₁₂ = B₁₃ = 0`, the `E` half lying outside the
sign argument's reach since `tr(Π_E u₋) ≠ 0`. It uses Hansen–Pedersen nowhere.

**Owed**, each entering here as a hypothesis: the expansion `Δ₂ = ‖g₁‖² + 2a⟨⋆, X₂⟩` (`hΔ`); the two trace
identities for `X₂`; and `X₂` as the `t²`-coefficient of `tr(Π_A (u+tH)₋)` with the first order `tr(Π_A D₋)`
vanishing on the cone, which is where `F = 0` enters (`hlim`).
-/

namespace HamiltonsCubic.L136

open Filter Topology Matrix Set

/-- **A function nonnegative on `t > 0` has a nonnegative limit of `φ(t)/tᵏ` at `0⁺`.** -/
theorem limit_nonneg {φ : ℝ → ℝ} {e : ℝ} (k : ℕ) (hφ : ∀ t, 0 < t → 0 ≤ φ t)
    (h : Tendsto (fun t => φ t / t ^ k) (𝓝[>] 0) (𝓝 e)) : 0 ≤ e :=
  ge_of_tendsto h (eventually_nhdsWithin_of_forall fun t (ht : 0 < t) =>
    div_nonneg (hφ t ht) (pow_nonneg ht.le k))

/-- **`φ ≥ 0` on `t > 0` with `φ(0) = 0` gives `φ'(0⁺) ≥ 0`**, the `ψ` argument's first-order form. -/
theorem rightDeriv_nonneg {φ : ℝ → ℝ} {d : ℝ} (hφ : ∀ t, 0 < t → 0 ≤ φ t) (h0 : φ 0 = 0)
    (hd : HasDerivWithinAt φ d (Ioi 0) 0) : 0 ≤ d := by
  have hs := (hasDerivWithinAt_iff_tendsto_slope' (s := Ioi (0 : ℝ)) (x := 0) (by simp)).mp hd
  refine ge_of_tendsto hs (eventually_nhdsWithin_of_forall fun t (ht : 0 < t) => ?_)
  rw [slope_def_field, h0, sub_zero, sub_zero]
  exact div_nonneg (hφ t ht) ht.le

variable {m : Type*} [Fintype m]

/-- **`tr(Π N) ≥ 0`** for an orthogonal projection `Π` and a positive-semidefinite `N`. -/
theorem trace_proj_psd {P N : Matrix m m ℝ} (hPt : Pᵀ = P) (hPP : P * P = P) (hN : N.PosSemidef) :
    0 ≤ (P * N).trace := by
  have hc : (P * N).trace = (Pᴴ * N * P).trace := by
    rw [conjTranspose_eq_transpose_of_trivial, hPt]
    calc (P * N).trace = (P * (P * N)).trace := by rw [← Matrix.mul_assoc, hPP]
      _ = (P * N * P).trace := by rw [trace_mul_comm]
  rw [hc]
  exact (hN.conjTranspose_mul_mul_same P).trace_nonneg

/-- **`tr(Π_A X₂) ≥ 0`**: `N t` is `(u+tH)₋`, positive semidefinite for `t > 0`, and `hlim` says that
`tr(Π_A (u+tH)₋)` is `tr(Π_A X₂) t² + o(t²)`, its constant order `tr(Π_A u₋) = 0` and its linear order
`tr(Π_A D₋)` vanishing, the second by `F = 0`. -/
theorem trA_nonneg {PA X₂ : Matrix m m ℝ} {N : ℝ → Matrix m m ℝ} (hPt : PAᵀ = PA) (hPP : PA * PA = PA)
    (hN : ∀ t, 0 < t → (N t).PosSemidef)
    (hlim : Tendsto (fun t => (PA * N t).trace / t ^ 2) (𝓝[>] 0) (𝓝 (PA * X₂).trace)) :
    0 ≤ (PA * X₂).trace :=
  limit_nonneg 2 (fun t ht => trace_proj_psd hPt hPP (hN t ht)) hlim

/-- **The cross term is nonpositive**: with `⋆ = Π_E - Π_A`, `tr(Π_E X₂) = 0` on `T_u𝒪^⊥` and `tr(Π_A X₂) ≥ 0`,
`Δ₂ = ‖g₁‖² + 2a⟨⋆, X₂⟩ ≤ ‖g₁‖²`. -/
theorem cross_term_nonpos {PE PA X₂ : Matrix m m ℝ} {a g Δ : ℝ} (ha : 0 ≤ a)
    (hΔ : Δ = g + 2 * a * ((PE - PA) * X₂).trace) (hE : (PE * X₂).trace = 0) (hA : 0 ≤ (PA * X₂).trace) :
    Δ ≤ g := by
  rw [hΔ, Matrix.sub_mul, trace_sub, hE]
  nlinarith

/-- **L136's box**: from the record's two identities
`tr(Π_E X₂) = (√6/3)(B₁₂² + B₁₃²)` and `tr(Π_A X₂) = 𝒦 + √6(‖Π_A c₂‖² + ‖Π_A c₃‖²)`, with `𝒦 ≥ 0`,
`B₁₂ = B₁₃ = 0` on `T_u𝒪^⊥` and `a = 1/(3√6)`,
`Δ₂ ≤ ‖g₁‖² - ⅔(‖Π_A c₂‖² + ‖Π_A c₃‖²) ≤ ‖g₁‖²`. -/
theorem L136_box {PE PA X₂ : Matrix m m ℝ} {a g Δ B12 B13 K s2 s3 : ℝ}
    (hΔ : Δ = g + 2 * a * ((PE - PA) * X₂).trace) (ha : a = 1 / (3 * Real.sqrt 6))
    (hE : (PE * X₂).trace = Real.sqrt 6 / 3 * (B12 ^ 2 + B13 ^ 2))
    (hA : (PA * X₂).trace = K + Real.sqrt 6 * (s2 + s3)) (hK : 0 ≤ K) (hB : B12 = 0 ∧ B13 = 0)
    (hs2 : 0 ≤ s2) (hs3 : 0 ≤ s3) :
    Δ ≤ g - 2 / 3 * (s2 + s3) ∧ g - 2 / 3 * (s2 + s3) ≤ g := by
  have h6 : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hc : 2 * a * Real.sqrt 6 = 2 / 3 := by rw [ha]; field_simp
  have ha0 : 0 ≤ a := by rw [ha]; positivity
  rw [hΔ, Matrix.sub_mul, trace_sub, hE, hA, hB.1, hB.2]
  refine ⟨?_, by linarith⟩
  have : 2 * a * (Real.sqrt 6 / 3 * (0 ^ 2 + 0 ^ 2) - (K + Real.sqrt 6 * (s2 + s3)))
      = -(2 * a * K) - (2 * a * Real.sqrt 6) * (s2 + s3) := by ring
  rw [this, hc]
  nlinarith

end HamiltonsCubic.L136
