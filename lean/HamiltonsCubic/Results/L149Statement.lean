import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L149, the infimum the repaired proof turns on, and the dichotomy as a monotone chain

**The round's verdict on this result is `GAP` on the proof as written, repaired, and *the repair is
itself unaudited*** ([ROUND_L149](../../../verification/ROUND_L149.md), v11, v12, v13, adjudicated by
v14, v15). **Nothing in this file audits it.** What is typed is the algebra the repaired proof runs
on (an identity and a perfect square) which is available to an auditor and settles the one step
the block calls *"no case analysis on the location of the stationary point is needed"*.

## The record's statement, verbatim

> **LEMMA L149.** *For $m\ge6$, the second branch is $\Omega(n^{-1})$ **uniformly in $w\in[0,1]$**,
> the first is minimised at $w=0$, ***this clause does not follow and is owed*** […] and the
> validity branch is $\Omega(n^{-1})$ as well.*

> **Proof of the uniformity.** Write $g_\rho(w)=\sqrt{c_p+\rho w^2}\big/\big(a_0n^{1/2}+nw\big)$
> with $a_0=\sqrt{2n/(n-2)}$ from [Lemma L146], $c_p=\kappa/n$ and $\rho=\rho^{\mathrm{eff}}_n$.
> **Here $\kappa:=nc_p=3\theta_0n/(n-2)=3\sqrt{2(n-1)/(n-2)}=4.4497$ at $n=12$** […] **No case
> analysis on the location of the stationary point is needed**, since
> $$\inf_{w\in[0,1]}g_\rho\;\ge\;\inf_{w\ge0}g_\rho\;=\;\frac1n\sqrt{\frac{\rho\,\kappa}{\rho\,a_0^2+\kappa}},$$
> whose $n$-free coefficient $\big(\tfrac{\sqrt2 n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$
> **increases** in $n$ […] and equals $0.7197978$ at $n=12$, its minimum over even $n\ge12$.
> **Hence $g_\rho\ge0.71979/n$ uniformly in $w\in[0,1]$.** $\square$

> **THE SUBSTANCE, STATED AS BOTH REVIEWERS STATE IT.** *No direction is both low-margin and
> high-operator-norm*, and that single fact is the sweep:
> $$\lVert A''\rVert=\Theta(n)\ \Rightarrow\ \lVert H\rVert_{op}=\Theta(1)\ \Rightarrow\ w=\Theta(1)\ \Rightarrow\ c(H)=\Theta(1).$$

[second-order.md](../../../findings/second-order.md), Lemma L149.

## What this file states

[L149.lean](L149.lean) prices the conclusion, that `0.7198/n` overshoots what
[L145](../../../findings/second-order.md) asks for and sits under [L147](L147.lean)'s ceiling, and
records the direction error the old proof made. **The infimum itself and the dichotomy are the two
things it lists as owed**, and both are elementary once the geometry is a binder. All PROVED here,
with no `sorry`, and every statement is on squares so no square root is taken:

- `branch_two_infimum`, **the uniform bound, as a perfect square.** For `A, B, c, ρ > 0` and every
  `w ≥ 0`, `(c + ρw²)/(A + Bw)² ≥ cρ/(ρA² + B²c)`, because the difference of the cross-multiplied
  sides is exactly `(Bc − ρAw)²`. *That square is why the block needs no case analysis: the
  stationary point is where it vanishes, and the inequality holds whether or not `w` reaches it.*
- `branch_two_attained`, and the bound is attained, at `w* = Bc/(ρA)`, so it is the infimum and not
  merely a bound.
- `chain_value`, the substitution `A² = a₀²n`, `B = n`, `c = κ/n` returns the block's
  `ρκ/(n²(ρa₀² + κ))`, i.e. `g_ρ ≥ (1/n)√(ρκ/(ρa₀² + κ))`, **with the two `κ`s kept apart**: the one
  here is `n c_p`, not the penalty constant `|κₙ|`.
- `coefficient_bracket`, the numeral, from brackets on its inputs: with `a₀² = 12/5` and
  `κ ∈ [4.4497, 4.4498]`, `ρ ∈ [0.71904, 0.71905]`, the `n`-free coefficient squared lies in
  `[0.7197², 0.7199²]`. *The record's `0.7197978` sits inside, and the statement is an inequality
  between rationals with no root taken.*
- `coefficient_increases_iff`, the `n`-dependence, reduced to what actually carries it: the
  coefficient is `1/(a₀²/κ + 1/ρ)`, so it increases exactly when that sum decreases, which is the
  monotonicity the block asserts and consumes.
- `low_margin_forces_low_norm`, **the dichotomy is a monotone chain, not a coincidence.** From the
  block's own two inputs (`c(H) ≥ c_p + ρw²` and `‖H‖_op ≤ b₀ + w`), a direction whose margin is at
  most `c_p + ρt²` has `w ≤ t`, hence `‖H‖_op ≤ b₀ + t` and `‖A''‖ ≤ C(r + nt)`. So *no direction is
  both low-margin and high-operator-norm* is one implication run three times, and it needs nothing
  about the geometry beyond those two inequalities.

## What is NOT typed here

- **The two inputs, which enter here as `hmargin` and `hop`.** The margin input is proved on the operators
  in [L149Margin.lean](L149Margin.lean): `L149_margin` gives `−½ hessQ(H) ≥ c_p‖H‖² + 3θ\frac{m-4}{2(m-1)}‖H_r‖²` for
  `H = H_s + H_r`, and [L149Bridge.lean](L149Bridge.lean) joins it to `hmargin`: `L149_hmargin` gives
  `c_p + ρ^eff_n w² ≤ c(H)` at every unit `H ∈ N`, with `w = ‖H_r‖` of the split `IsSplit`, which `split_unique` makes a
  function of `H`. That `w` is the weight outside the `λ_m`-eigenspace, and `hop` must be stated with the same `w`. The operator-norm input `‖H‖_op ≤ Θ(n^{-1/2}) + w` is
  [L146](../../../findings/second-order.md) plus the triangle inequality.
- **`ρ^eff`'s closed form, positivity and monotonicity**, which [RhoEff.lean](RhoEff.lean) carries,
  and the `2/9` identity that discharges them, an identity attained on `E_{L_e}(μ) = Λ²⊗Λ²`.
- **That the chain's `r(H)` is the minimum of the three branches**, that branch 1 is minimised where
  the block says (*the clause the block itself marks as owed*) and the `Ω` rather than `Θ`, which
  rests on [L148](../../../findings/second-order.md)'s vanishing at `w = 0`.
- **The audit of the repair.** The round left it unaudited and this file does not change that.
-/

namespace HamiltonsCubic.L149Statement

/-! ## 1. The uniform infimum, as a perfect square

*`A` stands for `a₀n^{1/2}`, `B` for `n`, `c` for the margin `c_p` and `ρ` for `ρ^eff_n`. Squares
throughout: `g_ρ` itself carries a square root and none of the statements below do.* -/

/-- **The bound the block takes without case analysis.** Cross-multiplied, the difference of the two
sides is `(Bc − ρAw)²`, a square, nonnegative at every `w`, and zero exactly at the stationary
point. -/
theorem branch_two_infimum {A B c ρ w : ℝ} (hA : 0 < A) (hB : 0 < B) (hc : 0 < c) (hρ : 0 < ρ)
    (hw : 0 ≤ w) :
    c * ρ / (ρ * A ^ 2 + B ^ 2 * c) ≤ (c + ρ * w ^ 2) / (A + B * w) ^ 2 := by
  have hden₁ : 0 < ρ * A ^ 2 + B ^ 2 * c := by positivity
  have hden₂ : 0 < (A + B * w) ^ 2 := by positivity
  rw [div_le_div_iff₀ hden₁ hden₂]
  nlinarith [sq_nonneg (B * c - ρ * A * w)]

/-- **And it is the infimum, not merely a bound**: equality at `w* = Bc/(ρA)`. -/
theorem branch_two_attained {A B c ρ : ℝ} (hA : 0 < A) (hB : 0 < B) (hc : 0 < c) (hρ : 0 < ρ) :
    (c + ρ * (B * c / (ρ * A)) ^ 2) / (A + B * (B * c / (ρ * A))) ^ 2
      = c * ρ / (ρ * A ^ 2 + B ^ 2 * c) := by
  have hden₁ : 0 < ρ * A ^ 2 + B ^ 2 * c := by positivity
  have hA' : A ≠ 0 := ne_of_gt hA
  have hρ' : ρ ≠ 0 := ne_of_gt hρ
  have hkey : A + B * (B * c / (ρ * A)) = (ρ * A ^ 2 + B ^ 2 * c) / (ρ * A) := by
    field_simp
  rw [hkey]
  field_simp

/-- **The block's own substitution.** With `A² = a₀²n`, `B = n` and `c = κ/n`, the infimum value is
`ρκ/(n²(ρa₀² + κ))`, so `g_ρ ≥ (1/n)√(ρκ/(ρa₀² + κ))`, uniformly in `w`. *The `κ` here is `n c_p`
and not the penalty constant `|κₙ|`; the block records twice that readers have substituted the
wrong one.* -/
theorem chain_value {a0 n κ ρ : ℝ} (hn : n ≠ 0) (hd : ρ * a0 ^ 2 + κ ≠ 0) :
    (κ / n) * ρ / (ρ * (a0 ^ 2 * n) + n ^ 2 * (κ / n)) = ρ * κ / (n ^ 2 * (ρ * a0 ^ 2 + κ)) := by
  field_simp

/-! ## 2. The numeral, from brackets on its inputs -/

/-- **`0.7197978` at `n = 12`, without a root.** `a₀² = 2n/(n−2) = 12/5` there; `κ` and `ρ^eff₁₂` are
bracketed from the record; and the coefficient's *square* is then pinned between `0.7197²` and
`0.7199²`. *So the block's `g_ρ ≥ 0.71979/n` is an inequality between rationals at this dimension.*
-/
theorem coefficient_bracket {κ ρ : ℝ} (hκ₁ : 4.4497 ≤ κ) (hκ₂ : κ ≤ 4.4498)
    (hρ₁ : 0.71904 ≤ ρ) (hρ₂ : ρ ≤ 0.71905) :
    (0.7197 : ℝ) ^ 2 ≤ ρ * κ / (ρ * (12 / 5) + κ) ∧
      ρ * κ / (ρ * (12 / 5) + κ) ≤ (0.7199 : ℝ) ^ 2 := by
  have hden : 0 < ρ * (12 / 5) + κ := by nlinarith
  constructor
  · rw [le_div_iff₀ hden]; nlinarith
  · rw [div_le_iff₀ hden]; nlinarith

/-- **Where the `n`-dependence sits.** The coefficient is the reciprocal of `a₀²/κ + 1/ρ`, so it
increases exactly when that sum decreases, which is the monotonicity in `n` the block asserts and
then consumes, reduced to its two factors. -/
theorem coefficient_increases_iff {a0 κ ρ : ℝ} (hκ : 0 < κ) (hρ : 0 < ρ) :
    ρ * κ / (ρ * a0 ^ 2 + κ) = 1 / (a0 ^ 2 / κ + 1 / ρ) := by
  have hκ' : κ ≠ 0 := ne_of_gt hκ
  have hρ' : ρ ≠ 0 := ne_of_gt hρ
  field_simp

/-- And the reciprocal is order-reversing, which is the whole of the monotonicity step. -/
theorem reciprocal_reverses {p q : ℝ} (hp : 0 < p) (hpq : p ≤ q) : 1 / q ≤ 1 / p :=
  one_div_le_one_div_of_le hp hpq

/-! ## 3. The dichotomy, as one implication run three times

*The block's `‖A''‖ = Θ(n) ⇒ ‖H‖_op = Θ(1) ⇒ w = Θ(1) ⇒ c(H) = Θ(1)`, read in the direction that
proves it.* -/

/-- **No direction is both low-margin and high-operator-norm.** From the block's two inputs, a
margin bounded below by `c_p + ρw²` and an operator norm bounded above by `b₀ + w`, a direction
whose margin is at most `c_p + ρt²` has `w ≤ t`, and the two bounds then transfer. *`w ≥ 0` is not
needed: `w² ≤ t²` with `t ≥ 0` already gives it.* *The conclusion
needs nothing about the geometry that is not already in `hmargin` and `hop`.* -/
theorem low_margin_forces_low_norm {cp ρ w t c b0 opn A2 C r n : ℝ}
    (hρ : 0 < ρ) (ht : 0 ≤ t) (hC : 0 ≤ C) (hn : 0 ≤ n)
    (hmargin : cp + ρ * w ^ 2 ≤ c) (hlow : c ≤ cp + ρ * t ^ 2)
    (hop : opn ≤ b0 + w) (hA : A2 ≤ C * (r + n * w)) :
    w ≤ t ∧ opn ≤ b0 + t ∧ A2 ≤ C * (r + n * t) := by
  have h2 : ρ * w ^ 2 ≤ ρ * t ^ 2 := by linarith
  have h3 : w ^ 2 ≤ t ^ 2 := le_of_mul_le_mul_left h2 hρ
  have hwt : w ≤ t := by nlinarith [h3, ht]
  refine ⟨hwt, by linarith, ?_⟩
  have hinner : r + n * w ≤ r + n * t := by
    have := mul_le_mul_of_nonneg_left hwt hn
    linarith
  have hstep := mul_le_mul_of_nonneg_left hinner hC
  linarith

/-! ## Witnesses, so no hypothesis is empty

*The infimum at `A = B = c = ρ = 1` is `1/2`, attained at `w* = 1`; and the dichotomy at
`ρ = 1, t = 1` carries a direction of weight `w = 1/2`.* -/

example : (1 : ℝ) * 1 / (1 * 1 ^ 2 + 1 ^ 2 * 1) ≤ (1 + 1 * (1 : ℝ) ^ 2) / (1 + 1 * 1) ^ 2 :=
  branch_two_infimum one_pos one_pos one_pos one_pos zero_le_one

example : (1 : ℝ) / 2 ≤ 1 := by
  have := low_margin_forces_low_norm (cp := 0) (ρ := 1) (w := 1 / 2) (t := 1) (c := 1 / 4)
    (b0 := 0) (opn := 0) (A2 := 0) (C := 0) (r := 0) (n := 0)
    one_pos zero_le_one le_rfl le_rfl (by norm_num) (by norm_num) (by norm_num) (by norm_num)
  exact this.1

end HamiltonsCubic.L149Statement
