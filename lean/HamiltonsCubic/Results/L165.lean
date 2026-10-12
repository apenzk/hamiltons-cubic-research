import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L165, the frontier requirement in closed form

[route-a.md](../../../findings/route-a.md)'s Lemma L165. Under `σ² = 1 - 3α` the requirement
`γ_max(α) < (3 - 5α)/√3` becomes `H_θ(σ) > 0`, and the piece above `α* = 32/141` is a single
cubic whose positivity holds at every `n` and both parities.

**What is checked here.** The change of variable and its exact right side; the branch point
transcribing to `α*`; the cubic's discriminant, whose sign is an integer comparison; the
critical constant `Θ_{3/4}` and its position below `√2`; and `θ < √2` at both parities.

**What is not, and is stated rather than proved.** That `V(t)` is the inner maximisation's
value, which rests on three inputs [L22](../../../findings/route-a.md) owes, `c₀ = 1`,
`λ = 2/3`, and a vanishing measured at three dimensions, together with `θ ≤ Θ_n`, which is
Conjecture A restricted to `ker F_u`, and `P(W₁) = 0` on `V_{1/3}`, a measured row of L101's
table. **`H_θ` bounds the requirement's slack from below**, so positivity certifies the
requirement and non-positivity shows only that this bound does not deliver it.

No root is taken anywhere below: every surd comparison is squared into ℚ.
-/

namespace HamiltonsCubic.FrontierRequirement

/-! ## The change of variable is exact -/

/-- `3 - 5α = (4 + 5σ²)/3` whenever `σ² = 1 - 3α`. -/
theorem right_side (α σ : ℚ) (h : σ ^ 2 = 1 - 3 * α) :
    3 - 5 * α = (4 + 5 * σ ^ 2) / 3 := by
  rw [h]; ring

/-- The branch point transcribes: `t*² = 15/32` gives `σ*² = 15/47`. -/
theorem sigma_star : (15 / 32 : ℚ) / (1 + 15 / 32) = 15 / 47 := by norm_num

/-- And `σ*² = 15/47` gives `α* = 32/141`, the value the record records. -/
theorem alpha_star : (1 - (15 : ℚ) / 47) / 3 = 32 / 141 := by norm_num

/-! ## The cubic piece, and its discriminant -/

/-- `3√2·H_θ` on `σ ≤ σ*` has `σ³`-coefficient `3√15 - 3√2·θ`, decreasing in `θ`; at the
limiting constant `θ = √2` that coefficient is `3√15 - 6`. -/
theorem limiting_coefficient (q : ℚ) (h : q ^ 2 = 15) :
    3 * q - 3 * 2 = 3 * q - 6 := by ring

/-- **The discriminant of `(3√15-6)σ³ + 5σ² - 3√15·σ + 4` is `12312√15 - 48197`.**
Computed from `Δ = 18abcd - 4b³d + b²c² - 4ac³ - 27a²d²` with `q² = 15`. -/
theorem discriminant_form (q : ℚ) (h : q ^ 2 = 15) :
    18 * (3 * q - 6) * 5 * (-(3 * q)) * 4 - 4 * 5 ^ 3 * 4 + 5 ^ 2 * (3 * q) ^ 2
      - 4 * (3 * q - 6) * (-(3 * q)) ^ 3 - 27 * (3 * q - 6) ^ 2 * 4 ^ 2
      = 12312 * q - 48197 := by
  have h3 : q ^ 3 = 15 * q := by
    calc q ^ 3 = q ^ 2 * q := by ring
    _ = 15 * q := by rw [h]
  have h4 : q ^ 4 = 225 := by
    calc q ^ 4 = q ^ 2 * q ^ 2 := by ring
    _ = 225 := by rw [h]; norm_num
  nlinarith [h, h3, h4]

/-- **`Δ < 0`, as an integer comparison.** `15·12312² = 2273780160 < 2322950809 = 48197²`,
so `12312√15 < 48197`. One real root, and since the leading coefficient and the value at `0`
are both positive, that root is negative and the cubic is positive on all of `σ ≥ 0`. -/
theorem discriminant_negative : 15 * 12312 ^ 2 < 48197 ^ 2 := by norm_num

/-- The same fact in the form the argument uses. -/
theorem discriminant_negative' (q : ℚ) (hq : 0 < q) (h : q ^ 2 = 15) :
    12312 * q - 48197 < 0 := by nlinarith [h, hq]

/-! ## `θ < √2` at both parities -/

/-- Even `n`: `θ₀(n)² = 2(n-1)(n-2)/n² < 2` for `n ≥ 2`. -/
theorem theta0_sq_lt_two (n : ℚ) (hn : 2 ≤ n) :
    2 * (n - 1) * (n - 2) / n ^ 2 < 2 := by
  have hn0 : (0 : ℚ) < n ^ 2 := by nlinarith
  rw [div_lt_iff₀ hn0]; nlinarith

/-- Odd `n`: `θ̃₀(n)² = 2(n-1)(n-3)/((n+1)(n-2)) < 2`, since `(n-1)(n-3) - (n+1)(n-2) = 5 - 3n < 0`. -/
theorem theta0_odd_sq_lt_two (n : ℚ) (hn : 3 ≤ n) :
    2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)) < 2 := by
  have hd : (0 : ℚ) < (n + 1) * (n - 2) := by nlinarith
  rw [div_lt_iff₀ hd]; nlinarith

/-! ## The critical constant at `σ = 3/4` -/

/-- `H_θ(3/4) = 0` at `θ = Θ_{3/4} = 218√2/81 - 131√7/144`. -/
theorem theta_crit_form (r s : ℚ) (hr : r ^ 2 = 2) (hs : s ^ 2 = 7) :
    (64 / 27 : ℚ) * (109 * r / 96 - 393 * s / 1024) = 218 * r / 81 - 131 * s / 144 := by
  ring

/-- **`Θ_{3/4} < √2`**, which is `137√2/192 < 393√7/1024`, which squares to
`2·140288² = 39361445888 < 39855255552 = 7·75456²`. -/
theorem theta_crit_lt_sqrt_two : 2 * 140288 ^ 2 < 7 * 75456 ^ 2 := by norm_num

/-- **`Θ_{3/4} = 1.39925…`**, the constant at which the frontier branch stops covering
`α = 7/48`. Since `θ₀(n)` increases to `√2 > Θ_{3/4}`, it crosses, and the branch's reach
contracts as `n` grows. -/
theorem theta_crit_bracket (r s : ℚ)
    (hr1 : (14142135 : ℚ) / 10000000 < r) (hr2 : r < (14142136 : ℚ) / 10000000)
    (hs1 : (26457513 : ℚ) / 10000000 < s) (hs2 : s < (26457514 : ℚ) / 10000000) :
    (1399255 : ℚ) / 1000000 < 218 * r / 81 - 131 * s / 144 ∧
      218 * r / 81 - 131 * s / 144 < (1399258 : ℚ) / 1000000 := by
  constructor <;> linarith

/-! ## The cubic piece's own critical constant, which is a different number -/

/-- **`θ_crit = (263√1410 - 1440√30)/1350`** solves `H_θ(σ*) = 0` on the cubic piece, so that
piece survives every constant below it. *Derived at Gate 2 by [r742](../../../reviews/REVIEW_r742.md)
and re-derived from `σ*² = 15/47` before adoption.* **It is NOT `Θ_{3/4}`**, the two constants
belong to the two pieces, and an earlier version of this file carried one's value under the
other's formula. -/
theorem theta_crit_cubic_bracket (u v : ℚ)
    (hu1 : (37549966 : ℚ) / 1000000 < u) (hu2 : u < (37549968 : ℚ) / 1000000)
    (hv1 : (5477225 : ℚ) / 1000000 < v) (hv2 : v < (5477226 : ℚ) / 1000000) :
    (1472913 : ℚ) / 1000000 < (263 * u - 1440 * v) / 1350 ∧
      (263 * u - 1440 * v) / 1350 < (1472919 : ℚ) / 1000000 := by
  constructor
  · rw [lt_div_iff₀ (by norm_num : (0:ℚ) < 1350)]; linarith
  · rw [div_lt_iff₀ (by norm_num : (0:ℚ) < 1350)]; linarith

/-- **`θ_crit` sits above `√2`**, the record's "a constant about 4% above √2", in closed form. -/
theorem theta_crit_above_root_two :
    (1472913 : ℚ) / 1000000 > 14142136 / 10000000 := by norm_num

/-! ## The witness point -/

/-- `σ = 3/4` lies on the frontier branch, since `9/16 > 15/47`. -/
theorem three_quarters_on_branch : (15 : ℚ) / 47 < 9 / 16 := by norm_num

/-- And `σ = 3/4` is `α = 7/48`. -/
theorem alpha_at_three_quarters : (1 - ((3 : ℚ) / 4) ^ 2) / 3 = 7 / 48 := by norm_num

end HamiltonsCubic.FrontierRequirement
