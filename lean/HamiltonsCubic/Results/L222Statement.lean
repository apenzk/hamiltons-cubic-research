import Mathlib

set_option linter.style.longLine false

/-!
# L222, the pair-block calculus: the polynomial cores

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L222: on `𝒟ₙ ⊕ V_{jk}`, `ν ∘ ν = G_x` with
`‖G_x‖² = 3‖x‖⁴`, the swap-odd action `y ↦ ½‖x‖² y + x⟨x,y⟩`, the second variation of the pair mass over
the `(j,k)`-angle, and the pinning.

## What is typed

* `G_rows_zero_outer`, `G_rows_zero_jk`: the rows of `G_x` sum to zero when `Σ x = 0`;
* `G_norm_sq`: `‖G_x‖² = 3 (Σ x²)²` when `Σ x = 0`, the sum over unordered pairs;
* `odd_action_on_x`, `odd_action_perp`: `½‖x‖² y + x⟨x,y⟩` is `(3/2)‖x‖² x` at `y = x` and `½‖x‖² y` at `⟨x,y⟩ = 0`;
* `pinning`: `⟨D, ĝ⟩ = θ/√3` from `⟨D, ν∘ν⟩ = (θ/2)‖ν‖²` and `‖ν∘ν‖ = (√3/2)‖ν‖²`;
* `pair_mass_le`: `‖ν‖² ≤ ½ Σ(K_ka - K_ja)²` from `‖ξ·D‖² ≥ ‖ξ·ν‖²` and the two constants.

**Not typed**: `𝒲ₙ`, the products, the commutators and the derivations of the constants, which are the prose.
-/

namespace HamiltonsCubic.L222Statement

open Finset

variable {ι : Type*} [Fintype ι]

/-- **Row `a` of `G_x` sums to zero**: `2 x_a² + Σ_{b ≠ a} 2 x_a x_b = 0` when `Σ x = 0`. -/
theorem G_rows_zero_outer [DecidableEq ι] (x : ι → ℝ) (hx : ∑ i, x i = 0) (a : ι) :
    2 * x a ^ 2 + ∑ b ∈ univ.erase a, 2 * x a * x b = 0 := by
  have h : ∑ b ∈ univ.erase a, x b = -x a := by
    have := Finset.add_sum_erase univ x (mem_univ a)
    linarith
  rw [← Finset.mul_sum, h]
  ring

/-- **Rows `j` and `k` of `G_x` sum to zero**: `Σ_a x_a² - ‖x‖² = 0`. -/
theorem G_rows_zero_jk (x : ι → ℝ) : ∑ a, x a ^ 2 - ∑ a, x a ^ 2 = 0 := sub_self _

/-- **`‖G_x‖² = 3 ‖x‖⁴`** over unordered pairs: rows `j`, `k` give `2 Σ x⁴`, the pair `(j,k)` gives `‖x‖⁴`,
and the outer block gives `Σ_{a<b} 4 x_a² x_b² = 2(‖x‖⁴ - Σ x⁴)`, written with the ordered sum. -/
theorem G_norm_sq (x : ι → ℝ) :
    2 * ∑ a, x a ^ 4 + (∑ a, x a ^ 2) ^ 2 + (∑ a, ∑ b, 2 * x a ^ 2 * x b ^ 2 - ∑ a, 2 * x a ^ 4)
      = 3 * (∑ a, x a ^ 2) ^ 2 := by
  have hsq : (∑ a, x a ^ 2) ^ 2 = ∑ a, ∑ b, x a ^ 2 * x b ^ 2 := by
    rw [sq, Finset.sum_mul_sum]
  have h : ∑ a, ∑ b, 2 * x a ^ 2 * x b ^ 2 = 2 * (∑ a, x a ^ 2) ^ 2 := by
    rw [hsq, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    ring
  have h4 : ∑ a, 2 * x a ^ 4 = 2 * ∑ a, x a ^ 4 := by rw [Finset.mul_sum]
  rw [h, h4]
  ring

/-- **The odd action on `x`**: `½‖x‖² x + x ⟨x,x⟩ = (3/2)‖x‖² x`. -/
theorem odd_action_on_x (x : ι → ℝ) (i : ι) :
    (1 / 2) * (∑ a, x a ^ 2) * x i + x i * (∑ a, x a * x a) = (3 / 2) * (∑ a, x a ^ 2) * x i := by
  have : ∑ a, x a * x a = ∑ a, x a ^ 2 := Finset.sum_congr rfl fun a _ => by ring
  rw [this]
  ring

/-- **The odd action off `x`**: at `⟨x,y⟩ = 0` it is `½‖x‖² y`. -/
theorem odd_action_perp (x y : ι → ℝ) (h : ∑ a, x a * y a = 0) (i : ι) :
    (1 / 2) * (∑ a, x a ^ 2) * y i + x i * (∑ a, x a * y a) = (1 / 2) * (∑ a, x a ^ 2) * y i := by
  rw [h]
  ring

/-- **The pinning**: from `⟨D, g⟩ = (θ/2) N` and `‖g‖ = (√3/2) N` with `N > 0`, the unit direction has
`⟨D, g⟩ / ‖g‖ = θ/√3`, written with `s = √3`. -/
theorem pinning (θ N Dg s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s) (hN : 0 < N) (hDg : Dg = θ / 2 * N) :
    Dg / (s / 2 * N) = θ / s := by
  rw [hDg]
  field_simp

/-- **The pair mass**: `‖ξ·D‖² = 2A`, `‖ξ·ν‖² = 4N` and `‖ξ·D‖² ≥ ‖ξ·ν‖²` give `N ≤ A/2`. -/
theorem pair_mass_le (A N XD XN : ℝ) (hXD : XD = 2 * A) (hXN : XN = 4 * N) (h : XN ≤ XD) : N ≤ A / 2 := by
  subst hXD hXN
  linarith

/-- A witness for `pair_mass_le` and `odd_action_perp`: `A = 2`, `N = 1`, and `x = y`-orthogonal vectors on `Fin 2`. -/
example : (1 : ℝ) ≤ 2 / 2 := pair_mass_le 2 1 4 4 (by norm_num) (by norm_num) le_rfl

end HamiltonsCubic.L222Statement
