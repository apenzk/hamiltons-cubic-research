import Mathlib

set_option linter.style.longLine false

/-!
# L224, the pair-block subalgebra carries no value above the diagonal: the polynomial cores

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L224: for `n ≥ 4` and `j ≠ k`, every unit
`W ∈ 𝒟ₙ ⊕ V_{jk}` has `P(W) ≤ Θₙ`, with equality exactly at the `(j,k)`-rotations of L57's maximisers.
Writing `W = E + D⁻_y + ν_x`, `P(W) = P(E) + 3(q_E(y) + q_E(x))` with `q_E(z) = ⟨E, G_z⟩`, and a quadratic
form summed over two columns is at most its top eigenvalue times their total mass, which one column attains.

## What is typed

* `two_columns_le`: `q y + q x ≤ λ (‖y‖² + ‖x‖²)` from `q z ≤ λ ‖z‖²`;
* `two_columns_eq`: equality in it forces equality in each column;
* `pair_value_le`: the comparison `P(W) ≤ P(W') ≤ Θ (‖E‖² + 2s)^{3/2}`, as arithmetic on the pieces;
* `block_form`: at a block-constant tensor with `j` and `k` in different blocks, `q_B(z) = (α_A + α_B - 2γ)(Σ_{A'} z)²`
  at `Σ z = 0`, so `q_B` has rank one;
* `sub_lt_of_mass`: `P(E) ≤ Θ ‖E‖³ < Θ` when `‖E‖² = 1 - 2s` and `s > 0`.

**Not typed**: `𝒲ₙ`, the product, the parity and character expansion of the cubic and L57, which enter as
hypotheses and are the prose.
-/

namespace HamiltonsCubic.L224Statement

/-- **Two columns against one**: if `q z ≤ λ ‖z‖²` for every `z`, then `q y + q x ≤ λ (‖y‖² + ‖x‖²)`. -/
theorem two_columns_le {V : Type*} (q : V → ℝ) (nrm : V → ℝ) (lam : ℝ) (hq : ∀ z, q z ≤ lam * nrm z)
    (y x : V) : q y + q x ≤ lam * (nrm y + nrm x) := by
  have := hq y; have := hq x; linarith

/-- **Equality in the two-column bound is equality in each column.** -/
theorem two_columns_eq {V : Type*} (q : V → ℝ) (nrm : V → ℝ) (lam : ℝ) (hq : ∀ z, q z ≤ lam * nrm z)
    (y x : V) (h : q y + q x = lam * (nrm y + nrm x)) : q y = lam * nrm y ∧ q x = lam * nrm x := by
  have := hq y; have := hq x; constructor <;> linarith

/-- **The comparison with a diagonal tensor**: `P(W) = P(E) + 3Q`, `Q ≤ λ s`, `P(W') = P(E) + 3λ s` and
`P(W') ≤ Θ` give `P(W) ≤ Θ`, and `P(W) = Θ` forces `Q = λ s` and `P(W') = Θ`. -/
theorem pair_value_le (PW PE PW' Q lam s Θ : ℝ) (hW : PW = PE + 3 * Q) (hQ : Q ≤ lam * s)
    (hW' : PW' = PE + 3 * (lam * s)) (hL57 : PW' ≤ Θ) :
    PW ≤ Θ ∧ (PW = Θ → Q = lam * s ∧ PW' = Θ) := by
  refine ⟨by linarith, fun h => ⟨by linarith, by linarith⟩⟩

/-- **The block-constant form has rank one.** At a tensor with value `αA` on pairs inside block `A`, `αB` inside
`B` and `γ` across, with `j ∈ A`, `k ∈ B`, the form `q_B(z) = Σ z_a² (B_ja + B_ka) - B_jk ‖z‖² + Σ_{a≠b} B_ab z_a z_b`
over the remaining indices `A' ⊕ B'` equals `(αA + αB - 2γ)(Σ_{A'} z)²` when `Σ z = 0`. -/
theorem block_form {α β : Type*} [Fintype α] [Fintype β] (z : α ⊕ β → ℝ) (αA αB γ : ℝ)
    (hz : ∑ i, z i = 0) :
    (∑ a : α, z (Sum.inl a) ^ 2 * (αA + γ) + ∑ b : β, z (Sum.inr b) ^ 2 * (γ + αB))
      - γ * (∑ a : α, z (Sum.inl a) ^ 2 + ∑ b : β, z (Sum.inr b) ^ 2)
      + αA * ((∑ a : α, z (Sum.inl a)) ^ 2 - ∑ a : α, z (Sum.inl a) ^ 2)
      + αB * ((∑ b : β, z (Sum.inr b)) ^ 2 - ∑ b : β, z (Sum.inr b) ^ 2)
      + 2 * γ * (∑ a : α, z (Sum.inl a)) * (∑ b : β, z (Sum.inr b))
      = (αA + αB - 2 * γ) * (∑ a : α, z (Sum.inl a)) ^ 2 := by
  rw [Fintype.sum_sum_type] at hz
  have hB : ∑ b : β, z (Sum.inr b) = -∑ a : α, z (Sum.inl a) := by linarith
  rw [hB]
  have e1 : ∑ a : α, z (Sum.inl a) ^ 2 * (αA + γ) = (αA + γ) * ∑ a : α, z (Sum.inl a) ^ 2 := by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun a _ => by ring
  have e2 : ∑ b : β, z (Sum.inr b) ^ 2 * (γ + αB) = (γ + αB) * ∑ b : β, z (Sum.inr b) ^ 2 := by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun b _ => by ring
  rw [e1, e2]
  ring

/-- **A diagonal part of smaller norm stays below `Θ`**: `P(E) ≤ Θ ‖E‖³` with `‖E‖² = 1 - 2s`, `0 < s < 1/2`
and `Θ > 0` give `P(E) < Θ`, written with `e = ‖E‖`. -/
theorem sub_lt_of_mass (PE Θ e s : ℝ) (hΘ : 0 < Θ) (he : 0 ≤ e) (hes : e ^ 2 = 1 - 2 * s) (hs : 0 < s)
    (hP : PE ≤ Θ * e ^ 3) : PE < Θ := by
  have he1 : e < 1 := by nlinarith
  have h3 : e ^ 3 ≤ e ^ 2 := by nlinarith [sq_nonneg e]
  have h2 : e ^ 2 < 1 := by linarith
  nlinarith

/-- A witness for `pair_value_le`: `P(E) = 1`, `Q = λ s = 0`, `Θ = 1`. -/
example : (1 : ℝ) ≤ 1 ∧ ((1 : ℝ) = 1 → (0 : ℝ) = 1 * 0 ∧ (1 : ℝ) = 1) :=
  pair_value_le 1 1 1 0 1 0 1 (by norm_num) (by norm_num) (by norm_num) le_rfl

end HamiltonsCubic.L224Statement
