import Mathlib
import HamiltonsCubic.Results.L226Statement
import HamiltonsCubic.Results.L227Alignment

set_option linter.style.longLine false

/-!
# L227, the `|J| = 3` step of R27 at `n = 5`

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L227: on the block subalgebra `𝒮_J ∩ 𝒲₅` with `|J| = 3`,
every unit `W` has `P(W) ≤ Θ₅`, attained at commuting blocks. With two outer indices the Ricci condition makes
`M_a = m I + X_a` with the same `m` and `K = -3m`, and `U = X₁ + X₂`, `V = X₁ - X₂` put the whole frame dependence of
`P` into `tr(U V²)` against a norm independent of the frames.

## What is typed

* `blockP_m2`: L226's `blockP` at `m = 2` in the traceless variables, proved;
* `normSq_m2`: the norm of L226's `normSq_blockOp` at `m = 2`, proved;
* `value_UV`, `norm_UV`: the change of variables, identities for all `3 × 3` real matrices, proved;
* `rearrangement`: `Σ uᵢ dᵢ ≤ Σ uᵢ wᵢ` from `d₁ ≤ w₁`, `d₁ + d₂ ≤ w₁ + w₂` and equal sums at ordered `u`, proved;
* `alignment_step`: for symmetric `U` and traceless symmetric `V` there is a traceless symmetric `V'` commuting with
  `U`, with `|V'| = |V|` and `tr(U V²) ≤ tr(U V'²)`, proved in [L227Alignment.lean](L227Alignment.lean) by Birkhoff's
  theorem at every size, the squared entries of the orthogonal matrix joining the two eigenframes being doubly stochastic;
* `commuting_improvement`: from `alignment_step`, commuting traceless symmetric `X₁', X₂'` with the same norm
  polynomial and a value at least as large, proved.

**Not typed**: the rotation carrying commuting blocks to a coordinate-diagonal tensor, and [L57](../../../findings/problem.md).
-/

namespace HamiltonsCubic.L227Statement

open Matrix HamiltonsCubic.L226Statement

/-- The value of `P` on `𝒮_J ∩ 𝒲₅` in the traceless variables. -/
def valueX (X₁ X₂ : Matrix (Fin 3) (Fin 3) ℝ) (m : ℝ) : ℝ :=
  6 * ((X₁ * X₁ * X₁).trace + (X₂ * X₂ * X₂).trace) + 9 * ((X₁ * X₁ * X₂).trace + (X₁ * X₂ * X₂).trace)
    - 18 * m * (X₁ * X₂).trace - 72 * m ^ 3

/-- The norm of `W ∈ 𝒮_J ∩ 𝒲₅` in the traceless variables. -/
def normX (X₁ X₂ : Matrix (Fin 3) (Fin 3) ℝ) (m : ℝ) : ℝ :=
  2 * ((X₁ * X₁).trace + (X₂ * X₂).trace) + 2 * (X₁ * X₂).trace + 18 * m ^ 2

/-- **L226's polynomial at two outer indices**, with `M_a = m I + X_a`, `K = -3m` and
`S = N - ½ (tr N) I = X₁ + X₂ - m I`. -/
theorem blockP_m2 (X₁ X₂ : Matrix (Fin 3) (Fin 3) ℝ) (h₁ : X₁.trace = 0) (h₂ : X₂.trace = 0) (m : ℝ) :
    blockP (m := 2) (X₁ + X₂ - m • 1) ![m • 1 + X₁, m • 1 + X₂] (fun a b => if a = b then 0 else -3 * m)
      = valueX X₁ X₂ m := by
  rw [trace_fin_three] at h₁ h₂
  have e₁ : X₁ 2 2 = -X₁ 0 0 - X₁ 1 1 := by linarith
  have e₂ : X₂ 2 2 = -X₂ 0 0 - X₂ 1 1 := by linarith
  simp [blockP, cubicJ, valueX, Fin.sum_univ_two, Fin.sum_univ_three, trace_fin_three, det_fin_three,
    adjugate_fin_three, Matrix.mul_apply, Matrix.one_apply, e₁, e₂]
  ring

/-- **The norm at two outer indices**, the right side of L226's `normSq_blockOp` there. -/
theorem normSq_m2 (X₁ X₂ : Matrix (Fin 3) (Fin 3) ℝ) (h₁ : X₁.trace = 0) (h₂ : X₂.trace = 0) (m : ℝ) :
    ((X₁ + X₂ - m • 1) * (X₁ + X₂ - m • 1)).trace + ∑ a, (![m • 1 + X₁, m • 1 + X₂] a * ![m • 1 + X₁, m • 1 + X₂] a).trace
      + ∑ a : Fin 2, ∑ b : Fin 2, (if a < b then (fun a b : Fin 2 => if a = b then (0 : ℝ) else -3 * m) a b ^ 2 else 0)
      = normX X₁ X₂ m := by
  rw [trace_fin_three] at h₁ h₂
  have e₁ : X₁ 2 2 = -X₁ 0 0 - X₁ 1 1 := by linarith
  have e₂ : X₂ 2 2 = -X₂ 0 0 - X₂ 1 1 := by linarith
  simp [normX, Fin.sum_univ_two, Fin.sum_univ_three, trace_fin_three, Matrix.mul_apply, Matrix.one_apply, e₁, e₂]
  ring

/-- **The change of variables in the value**, for all `3 × 3` real matrices. -/
theorem value_UV (X₁ X₂ : Matrix (Fin 3) (Fin 3) ℝ) (m : ℝ) :
    valueX X₁ X₂ m
      = 15 / 4 * ((X₁ + X₂) * (X₁ + X₂) * (X₁ + X₂)).trace + 9 / 4 * ((X₁ + X₂) * (X₁ - X₂) * (X₁ - X₂)).trace
        - 9 / 2 * m * ((X₁ + X₂) * (X₁ + X₂)).trace + 9 / 2 * m * ((X₁ - X₂) * (X₁ - X₂)).trace - 72 * m ^ 3 := by
  simp only [valueX, trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.sub_apply]
  ring

/-- **The change of variables in the norm**, for all `3 × 3` real matrices. -/
theorem norm_UV (X₁ X₂ : Matrix (Fin 3) (Fin 3) ℝ) (m : ℝ) :
    normX X₁ X₂ m = 3 / 2 * ((X₁ + X₂) * (X₁ + X₂)).trace + 1 / 2 * ((X₁ - X₂) * (X₁ - X₂)).trace + 18 * m ^ 2 := by
  simp only [normX, trace_fin_three, Matrix.mul_apply, Fin.sum_univ_three, Matrix.add_apply, Matrix.sub_apply]
  ring

/-- **The rearrangement behind the alignment**: at `u₁ ≥ u₂ ≥ u₃`, a diagonal `d` dominated by `w` in the two
Rayleigh senses pairs with `u` no better than `w` does. -/
theorem rearrangement (u₁ u₂ u₃ d₁ d₂ d₃ w₁ w₂ w₃ : ℝ) (hu₁₂ : u₂ ≤ u₁) (hu₂₃ : u₃ ≤ u₂)
    (hd₁ : d₁ ≤ w₁) (hd₁₂ : d₁ + d₂ ≤ w₁ + w₂) (hs : d₁ + d₂ + d₃ = w₁ + w₂ + w₃) :
    u₁ * d₁ + u₂ * d₂ + u₃ * d₃ ≤ u₁ * w₁ + u₂ * w₂ + u₃ * w₃ := by
  have h1 := mul_nonneg (sub_nonneg.2 hu₁₂) (sub_nonneg.2 hd₁)
  have h2 := mul_nonneg (sub_nonneg.2 hu₂₃) (sub_nonneg.2 hd₁₂)
  have h3 : u₃ * ((w₁ + w₂ + w₃) - (d₁ + d₂ + d₃)) = 0 := by rw [hs]; ring
  nlinarith [h1, h2, h3]

/-- **The alignment step**, from [L227Alignment.lean](L227Alignment.lean). -/
theorem alignment_step (U V : Matrix (Fin 3) (Fin 3) ℝ) (hU : U.IsSymm) (hV : V.IsSymm) (hV₀ : V.trace = 0) :
    ∃ V' : Matrix (Fin 3) (Fin 3) ℝ, V'.IsSymm ∧ V'.trace = 0 ∧ (V' * V').trace = (V * V).trace ∧
      U * V' = V' * U ∧ (U * V * V).trace ≤ (U * V' * V').trace :=
  HamiltonsCubic.L227Alignment.alignment_fin_three U V hU hV hV₀

/-- **The improvement at two outer indices**: every pair of traceless symmetric blocks is matched by a commuting
pair with the same norm polynomial and at least the same value. -/
theorem commuting_improvement (X₁ X₂ : Matrix (Fin 3) (Fin 3) ℝ) (hX₁ : X₁.IsSymm) (hX₂ : X₂.IsSymm)
    (h₁ : X₁.trace = 0) (h₂ : X₂.trace = 0) (m : ℝ) :
    ∃ Y₁ Y₂ : Matrix (Fin 3) (Fin 3) ℝ, Y₁.IsSymm ∧ Y₂.IsSymm ∧ Y₁.trace = 0 ∧ Y₂.trace = 0 ∧ Y₁ * Y₂ = Y₂ * Y₁ ∧
      normX Y₁ Y₂ m = normX X₁ X₂ m ∧ valueX X₁ X₂ m ≤ valueX Y₁ Y₂ m := by
  have hU : (X₁ + X₂).IsSymm := hX₁.add hX₂
  have hV : (X₁ - X₂).IsSymm := hX₁.sub hX₂
  have hV₀ : (X₁ - X₂).trace = 0 := by rw [trace_sub, h₁, h₂, sub_zero]
  obtain ⟨V', hV's, hV'₀, hV'n, hcomm, hle⟩ := alignment_step (X₁ + X₂) (X₁ - X₂) hU hV hV₀
  refine ⟨(1 / 2 : ℝ) • (X₁ + X₂ + V'), (1 / 2 : ℝ) • (X₁ + X₂ - V'), (hU.add hV's).smul _, (hU.sub hV's).smul _,
    ?_, ?_, ?_, ?_, ?_⟩
  · rw [trace_smul, trace_add, trace_add, h₁, h₂, hV'₀]; simp
  · rw [trace_smul, trace_sub, trace_add, h₁, h₂, hV'₀]; simp
  · generalize X₁ + X₂ = U at hcomm ⊢
    rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul]
    congr 2
    simp only [Matrix.add_mul, Matrix.mul_add, Matrix.sub_mul, Matrix.mul_sub, hcomm]
    abel
  · have hsum : (1 / 2 : ℝ) • (X₁ + X₂ + V') + (1 / 2 : ℝ) • (X₁ + X₂ - V') = X₁ + X₂ := by module
    have hdiff : (1 / 2 : ℝ) • (X₁ + X₂ + V') - (1 / 2 : ℝ) • (X₁ + X₂ - V') = V' := by module
    rw [norm_UV, norm_UV, hsum, hdiff, hV'n]
  · have hsum : (1 / 2 : ℝ) • (X₁ + X₂ + V') + (1 / 2 : ℝ) • (X₁ + X₂ - V') = X₁ + X₂ := by module
    have hdiff : (1 / 2 : ℝ) • (X₁ + X₂ + V') - (1 / 2 : ℝ) • (X₁ + X₂ - V') = V' := by module
    rw [value_UV, value_UV, hsum, hdiff, hV'n]
    nlinarith [hle]

end HamiltonsCubic.L227Statement
