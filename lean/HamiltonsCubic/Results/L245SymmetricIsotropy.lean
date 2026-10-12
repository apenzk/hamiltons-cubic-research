import Mathlib

set_option linter.style.longLine false

/-!
# L245, the isotropy bound on a symmetric three-value spectrum

## The symmetric case of the record's statement, paraphrased from [second-order.md](../../../findings/second-order.md) (Lemma L245 states the general ceiling $h_c$)

> At a critical point with eigenvalues $(-a,0,a)$, $\operatorname{Ric}(e)=0$ forces $A_0=A_2$, and with
> $A_0+A_1+A_2=(n-1)I$, $A_1\succeq0$, every unit $x\in\mathbb R^n$ has $\langle A_0x,x\rangle\le\tfrac{n-1}2$; so the
> negative eigenspace contains no $e_1\wedge U$ with $\dim U>\tfrac{n-1}2$.

## What is typed here

`isotropy_half`: the scalar core. If `a₀ = a₂`, `a₀ + a₁ + a₂ = n − 1` and `0 ≤ a₁` (the three quadratic forms
at one unit `x`), then `a₀ ≤ (n − 1)/2`. `no_large_star`: if moreover `d ≤ a₀` (a star `e₁ ∧ U` with
`dim U = d` inside the eigenspace, at `x = e₁`), then `2d ≤ n − 1`. `n12_star_le5`: at `n = 12`, `d ≤ 5`.

## What is NOT typed here

The isotropy matrices on `Λ²ℝⁿ`: `A_c = ∑ ΨΨᵀ`, `∑ A_c = (n − 1)I`, `∑ λ_c A_c = Ric(W) = 0`, and
`⟨A_c e₁, e₁⟩ ≥ dim U` for `e₁ ∧ U ⊆ E_c`; they enter as the hypotheses. The scalar ceilings
`ceiling_h0`, `ceiling_h1`, `ceiling_h2` and `star_h0` hold at every three-valued spectrum.
-/

namespace HamiltonsCubic.L245SymmetricIsotropy

theorem isotropy_half (n a0 a1 a2 : ℝ) (h02 : a0 = a2) (hsum : a0 + a1 + a2 = n - 1) (h1 : 0 ≤ a1) :
    a0 ≤ (n - 1) / 2 := by linarith

theorem no_large_star (n a0 a1 a2 d : ℝ) (h02 : a0 = a2) (hsum : a0 + a1 + a2 = n - 1) (h1 : 0 ≤ a1)
    (hd : d ≤ a0) : 2 * d ≤ n - 1 := by linarith

theorem n12_star_le5 (d : ℕ) (hd : 2 * (d : ℝ) ≤ 12 - 1) : d ≤ 5 := by
  have : (d : ℝ) ≤ 5.5 := by linarith
  have : (d : ℝ) < 6 := by linarith
  exact_mod_cast Nat.lt_succ_iff.mp (by exact_mod_cast this)

/-! ## The general ceiling `h_c`, at any three-valued spectrum

From `a₀ + a₁ + a₂ = N` and `λ₀a₀ + λ₁a₁ + λ₂a₂ = 0` with `a ≥ 0` and `λ₀ ≤ λ₁ ≤ λ₂`:
`(λ₂ − λ₀)a₀ ≤ Nλ₂`, `(λ₂ − λ₀)a₂ ≤ −Nλ₀`, and `a₁` under both `(λ₁ − λ₀)a₁ ≤ −Nλ₀` and
`(λ₂ − λ₁)a₁ ≤ Nλ₂`, the record's `h_1` being the smaller. Stated multiplied out, so no sign case
on a denominator. -/

theorem ceiling_h0 (N l0 l1 l2 a0 a1 a2 : ℝ) (hsum : a0 + a1 + a2 = N)
    (hric : l0 * a0 + l1 * a1 + l2 * a2 = 0) (h1 : 0 ≤ a1) (h12 : l1 ≤ l2) :
    (l2 - l0) * a0 ≤ N * l2 := by
  subst hsum; nlinarith [mul_nonneg h1 (sub_nonneg.mpr h12)]

theorem ceiling_h2 (N l0 l1 l2 a0 a1 a2 : ℝ) (hsum : a0 + a1 + a2 = N)
    (hric : l0 * a0 + l1 * a1 + l2 * a2 = 0) (h1 : 0 ≤ a1) (h01 : l0 ≤ l1) :
    (l2 - l0) * a2 ≤ N * (-l0) := by
  subst hsum; nlinarith [mul_nonneg h1 (sub_nonneg.mpr h01)]

theorem ceiling_h1 (N l0 l1 l2 a0 a1 a2 : ℝ) (hsum : a0 + a1 + a2 = N)
    (hric : l0 * a0 + l1 * a1 + l2 * a2 = 0) (h0 : 0 ≤ a0) (h2 : 0 ≤ a2) (h01 : l0 ≤ l1)
    (h12 : l1 ≤ l2) :
    (l1 - l0) * a1 ≤ N * (-l0) ∧ (l2 - l1) * a1 ≤ N * l2 := by
  subst hsum; constructor
  · nlinarith [mul_nonneg h2 (sub_nonneg.mpr (h01.trans h12))]
  · nlinarith [mul_nonneg h0 (sub_nonneg.mpr (h01.trans h12))]

/-- A star `e ∧ U ⊆ E₀` with `dim U = d ≤ a₀` has `(λ₂ − λ₀)d ≤ (n − 1)λ₂`. -/
theorem star_h0 (n l0 l1 l2 a0 a1 a2 d : ℝ) (hsum : a0 + a1 + a2 = n - 1)
    (hric : l0 * a0 + l1 * a1 + l2 * a2 = 0) (h1 : 0 ≤ a1) (h02 : l0 < l2) (h12 : l1 ≤ l2)
    (hd : d ≤ a0) : (l2 - l0) * d ≤ (n - 1) * l2 := by
  have := ceiling_h0 (n - 1) l0 l1 l2 a0 a1 a2 hsum hric h1 h12
  nlinarith [mul_le_mul_of_nonneg_left hd (sub_nonneg.mpr h02.le)]

/-- Non-vacuity: at `n = 12`, `λ = (−4, 3, 7)` and `a = (7, 0, 4)` satisfy both identities with
`a₀` on its ceiling `h₀ = 7`, so `ceiling_h0` is attained. -/
example : (7 - (-4 : ℝ)) * 7 ≤ (12 - 1) * 7 ∧ (-4 : ℝ) * 7 + 3 * 0 + 7 * 4 = 0 := by norm_num

end HamiltonsCubic.L245SymmetricIsotropy
