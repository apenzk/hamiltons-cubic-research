import Mathlib

set_option linter.style.longLine false

/-!
# L221, L220's chain on several four-set blocks: the scalar steps

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L221: *(a) on `𝒟ₙ ⊕ V_{Q₁} ⊕ ⋯ ⊕ V_{Q_m}` with the
`Q_i` pairwise disjoint, a unit critical point with some nonzero block component has `θ ≤ √(3/2)`; (b) on
`𝒟ₙ ⊕ V_{Q₁} ⊕ V_{Q₂} ⊕ V_{Q₁△Q₂}` with `|Q₁ ∩ Q₂| = 2`, a unit critical point with at least two nonzero block
components and `τ ≤ 0` has `θ² ≤ 6/5`.*

## What is typed

* `nu_square_norm`: `‖ν ∘ ν‖² = (3/4)‖ν‖⁴` on a four-set block, as the polynomial identity in the signed
  coordinates `a + b + c = 0`;
* `per_block`: the per-block inequality `(5/6)θ² ≤ 1 - N/2 + N_i` from the pinning `u ≥ θ/√3` and the chain's
  upper bound, over the scalars;
* `sum_three` and `sum_two`: summing the per-block inequalities gives `θ² ≤ 6/5`.

**Not typed**: `𝒲ₙ`, the subalgebras, the products, the cross-term angle and the chain's hypotheses, which is the
prose, as in [L220Statement.lean](L220Statement.lean).
-/

namespace HamiltonsCubic.L221Statement

/-- **`‖ν∘ν‖² = (3/4)‖ν‖⁴` on `V_Q`**: with `a + b + c = 0`, the pattern `x = 2a² - b² - c²` and cyclically has
`2(x² + y² + z²) = (3/4)(2(a² + b² + c²))²`. -/
theorem nu_square_norm (a b c : ℝ) (h : a + b + c = 0) :
    2 * ((2 * a ^ 2 - b ^ 2 - c ^ 2) ^ 2 + (2 * b ^ 2 - a ^ 2 - c ^ 2) ^ 2 + (2 * c ^ 2 - a ^ 2 - b ^ 2) ^ 2)
      = 3 / 4 * (2 * (a ^ 2 + b ^ 2 + c ^ 2)) ^ 2 := by
  have hc : c = -a - b := by linarith
  subst hc
  ring

/-- **The per-block step.** From `θ u ≤ u²/(2√3) + (1 - N/2 + N_i)/√3`, written with `s = √3` (`s² = 3`), and
`θ/√3 ≤ u ≤ 1 < √3 θ`, the left side's monotonicity gives `(5/6) θ² ≤ 1 - N/2 + N_i`. -/
theorem per_block (θ u s N Ni : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s) (hθ : 0 < θ)
    (hu : θ ≤ s * u) (hu1 : u ≤ 1) (hθu : 1 ≤ s * θ)
    (hchain : θ * u ≤ u ^ 2 / (2 * s) + (1 - N / 2 + Ni) / s) :
    5 / 6 * θ ^ 2 ≤ 1 - N / 2 + Ni := by
  -- multiply the chain by s: s θ u ≤ u²/2 + (1 - N/2 + Ni)
  have h1 : s * θ * u - u ^ 2 / 2 ≤ 1 - N / 2 + Ni := by
    have := mul_le_mul_of_nonneg_left hchain hs0.le
    have e : s * (u ^ 2 / (2 * s) + (1 - N / 2 + Ni) / s) = u ^ 2 / 2 + (1 - N / 2 + Ni) := by
      field_simp
    nlinarith [this, e]
  -- g(u) = sθu - u²/2 is increasing for u ≤ sθ, and u ≥ θ/s, so g(u) ≥ g(θ/s) = θ² - θ²/6
  have hg : s * θ * (θ / s) - (θ / s) ^ 2 / 2 ≤ s * θ * u - u ^ 2 / 2 := by
    have hlow : θ / s ≤ u := by rw [div_le_iff₀ hs0]; linarith
    have hup : u ≤ s * θ := by nlinarith
    nlinarith [mul_nonneg (sub_nonneg.mpr hlow) (sub_nonneg.mpr hup), hs]
  have hv : s * θ * (θ / s) - (θ / s) ^ 2 / 2 = 5 / 6 * θ ^ 2 := by
    field_simp
    rw [hs]
    ring
  linarith

/-- **Summing three blocks**: `θ² ≤ 6/5`. -/
theorem sum_three (θ N N1 N2 N3 : ℝ) (hN : N = N1 + N2 + N3) (hN0 : 0 ≤ N)
    (h1 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N1) (h2 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N2)
    (h3 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N3) : θ ^ 2 ≤ 6 / 5 := by
  nlinarith

/-- **Summing two blocks**, the third component zero: `θ² ≤ 6/5`. -/
theorem sum_two (θ N N1 N2 : ℝ) (hN : N = N1 + N2)
    (h1 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N1) (h2 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N2) : θ ^ 2 ≤ 6 / 5 := by
  nlinarith

/-- A witness for `sum_three`: `θ² = 6/5`, `N = 0` fits the hypotheses at their boundary. -/
example : True := by
  have := sum_three (Real.sqrt (6 / 5)) 0 0 0 0 (by norm_num) le_rfl
    (by rw [Real.sq_sqrt (by norm_num)]; norm_num) (by rw [Real.sq_sqrt (by norm_num)]; norm_num)
    (by rw [Real.sq_sqrt (by norm_num)]; norm_num)
  trivial

end HamiltonsCubic.L221Statement
