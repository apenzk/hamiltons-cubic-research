import Mathlib
import HamiltonsCubic.Results.L244RowA

/-!
# The symmetric part of a certificate vector's pair product lives in the middle eigenspace

[the per-vector note](../../../reviews/2026-09-25-I73c-per-vector-rows.md), the paragraph on the
certificate space's pair products.

For a complete skew family `ψ` split into three classes and a skew `w`, put
`c(γ, δ) = ⟨ψ_δ, [w, ψ_γ]⟩`. The pair-family vector `x_w` with coefficients `x_uv = ⟨[u, v], w⟩`
(`u ∈ E₀`, `v ∈ E₂`) has product `X = ∑_u u · P₂[w, u]`, whose symmetric part is half of
`∑_{γ ∈ E₀, δ ∈ E₂} c(γ, δ) {ψ_γ, ψ_δ}`. **`sym_split`**: that sum equals
`[w, S₀] − ∑_{γ ∈ E₀, δ ∈ E₁} c(γ, δ) {ψ_γ, ψ_δ}` with `S₀ = ∑_{γ ∈ E₀} ψ_γ²`, because the
`E₀ × E₀` block vanishes (`c` is antisymmetric, `inner2_br_skew`) and the full sum over `δ` is the
commutator `[w, S₀]` (`anticomm_sum`). **`comm_middle`**: when `S₀ = S₂` and `S₀ + S₁ + S₂` is scalar,
`[w, S₀] = −½ [w, S₁]`. So on the symmetric family the symmetric part is carried by `E₁` alone.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.ClassTraceMiddle

variable {n : ℕ}

local notation "Mat" => Matrix (Fin n) (Fin n) ℝ

/-- `∑_k {u_k, [w, u_k]} = [w, ∑_k u_k²]` over any finite set. -/
theorem anticomm_sum {K : Type*} (s : Finset K) (u : K → Mat) (w : Mat) :
    ∑ k ∈ s, (u k * br w (u k) + br w (u k) * u k)
      = w * (∑ k ∈ s, u k * u k) - (∑ k ∈ s, u k * u k) * w := by
  have h : ∀ k, u k * br w (u k) + br w (u k) * u k = w * (u k * u k) - (u k * u k) * w := by
    intro k; simp only [br, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_assoc]; abel
  rw [Finset.sum_congr rfl (fun k _ => h k), Finset.sum_sub_distrib, Finset.mul_sum,
    Finset.sum_mul]

/-- An antisymmetric coefficient against the symmetric `{u_k, u_l}` sums to zero. -/
theorem antisym_zero {K : Type*} (s : Finset K) (u : K → Mat) (c : K → K → ℝ)
    (hc : ∀ k l, c k l = -c l k) :
    ∑ k ∈ s, ∑ l ∈ s, c k l • (u k * u l + u l * u k) = 0 := by
  set S := ∑ k ∈ s, ∑ l ∈ s, c k l • (u k * u l + u l * u k) with hS
  have h1 : S = -S := by
    conv_lhs => rw [hS, Finset.sum_comm]
    rw [hS, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [hc l k, neg_smul, add_comm]
  have h2 : (2 : ℝ) • S = 0 := by rw [two_smul]; nth_rewrite 2 [h1]; exact add_neg_cancel S
  exact (smul_eq_zero.mp h2).resolve_left (by norm_num)

/-- Ad-invariance: `⟨A, [w, B]⟩ = −⟨B, [w, A]⟩` for skew `A`, `B`. -/
theorem inner2_br_skew (A B w : Mat) (hA : IsSkew A) (hB : IsSkew B) :
    inner2 A (br w B) = -inner2 B (br w A) := by
  unfold inner2 br
  rw [show Aᵀ = -A from hA, show Bᵀ = -B from hB]
  simp only [Matrix.neg_mul, Matrix.mul_sub, Matrix.trace_neg, Matrix.trace_sub]
  have e1 : (A * (w * B)).trace = (B * (A * w)).trace := by
    rw [← Matrix.mul_assoc, Matrix.trace_mul_comm]
  have e2 : (A * (B * w)).trace = (B * (w * A)).trace := by
    rw [Matrix.trace_mul_comm, Matrix.mul_assoc]
  rw [e1, e2]; ring

/-- **The split.** The `E₀ × E₂` anticommutator sum is `[w, S₀]` minus the `E₀ × E₁` one. -/
theorem sym_split {r : ℕ} (ψ : Fin r → Mat) (hψS : ∀ k, IsSkew (ψ k))
    (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k) (cls : Fin r → Fin 3)
    (w : Mat) (hw : IsSkew w) :
    ∑ γ ∈ Finset.univ.filter (fun γ => cls γ = 0), ∑ δ ∈ Finset.univ.filter (fun δ => cls δ = 2),
        inner2 (ψ δ) (br w (ψ γ)) • (ψ γ * ψ δ + ψ δ * ψ γ)
      = w * (∑ γ ∈ Finset.univ.filter (fun γ => cls γ = 0), ψ γ * ψ γ)
          - (∑ γ ∈ Finset.univ.filter (fun γ => cls γ = 0), ψ γ * ψ γ) * w
        - ∑ γ ∈ Finset.univ.filter (fun γ => cls γ = 0),
            ∑ δ ∈ Finset.univ.filter (fun δ => cls δ = 1),
              inner2 (ψ δ) (br w (ψ γ)) • (ψ γ * ψ δ + ψ δ * ψ γ) := by
  set E : Fin 3 → Finset (Fin r) := fun a => Finset.univ.filter (fun γ => cls γ = a) with hE
  set c : Fin r → Fin r → ℝ := fun γ δ => inner2 (ψ δ) (br w (ψ γ)) with hc
  have hanti : ∀ γ δ, c γ δ = -c δ γ := fun γ δ => inner2_br_skew _ _ w (hψS δ) (hψS γ)
  have hexp : ∀ γ, br w (ψ γ) = ∑ δ, c γ δ • ψ δ := fun γ => hψ _ (L244RowA.br_isSkew hw (hψS γ))
  have hterm : ∀ γ, ψ γ * br w (ψ γ) + br w (ψ γ) * ψ γ
      = ∑ b : Fin 3, ∑ δ ∈ E b, c γ δ • (ψ γ * ψ δ + ψ δ * ψ γ) := by
    intro γ
    rw [Finset.sum_fiberwise Finset.univ cls (fun δ => c γ δ • (ψ γ * ψ δ + ψ δ * ψ γ)), hexp γ,
      Finset.mul_sum, Finset.sum_mul, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun δ _ => ?_
    rw [Matrix.mul_smul, Matrix.smul_mul, smul_add]
  have htot := anticomm_sum (E 0) ψ w
  rw [Finset.sum_congr rfl (fun γ _ => hterm γ), Finset.sum_comm, Fin.sum_univ_three] at htot
  have h0 : ∑ γ ∈ E 0, ∑ δ ∈ E 0, c γ δ • (ψ γ * ψ δ + ψ δ * ψ γ) = 0 :=
    antisym_zero (E 0) ψ c hanti
  rw [h0, zero_add] at htot
  change ∑ γ ∈ E 0, ∑ δ ∈ E 2, c γ δ • (ψ γ * ψ δ + ψ δ * ψ γ)
    = w * (∑ γ ∈ E 0, ψ γ * ψ γ) - (∑ γ ∈ E 0, ψ γ * ψ γ) * w
      - ∑ γ ∈ E 0, ∑ δ ∈ E 1, c γ δ • (ψ γ * ψ δ + ψ δ * ψ γ)
  rw [← htot]; abel

/-- **The symmetric family.** When `S₀ = S₂` and `S₀ + S₁ + S₂ = s • 1`,
`[w, S₀] = −½ [w, S₁]`. -/
theorem comm_middle (w S0 S1 S2 : Mat) (s : ℝ) (h02 : S0 = S2) (hsum : S0 + S1 + S2 = s • 1) :
    w * S0 - S0 * w = -(1 / 2 : ℝ) • (w * S1 - S1 * w) := by
  have hS1 : S1 = s • 1 - (2 : ℝ) • S0 := by
    rw [two_smul, ← hsum, h02]; abel
  subst hS1
  simp only [Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_one,
    Matrix.one_mul, smul_sub]
  module
