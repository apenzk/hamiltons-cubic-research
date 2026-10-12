import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L147, the branch the record minimises without proof, and the band the debt lives in

**This result carries a `HYPOTHESIS-DEBT`** ([ROUND_L147](../../../verification/ROUND_L147.md), v22,
v23, v24), and the file is written to it: *the $\Theta(n^{-1})$ ceiling is proved, the radius
$r_n\gtrsim n^{-1-\beta}$ is asserted here and derived nowhere, and the joint minimisation over $w$
appears in no preceding entry.* Nothing below asserts the radius.

## The record's statement, verbatim

> **LEMMA L147.** *At $W^*=S^m\times S^m$ with $n=2m\ge12$, over directions $H$ with
> $\lVert H\rVert_F=1$, $\lVert H\rVert_{op}\le1$, $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$,
> **all four used by name in the proof and none previously in this box**, and with
> $\sup\lvert P\rvert=\Theta(n^\beta)$,*
> $$r_n\;\gtrsim\;n^{-3/2}\qquad\text{on }\beta\in[0,\tfrac12],$$
> *and the route is capped at $\Theta(n^{-1})$. **$\beta=\tfrac12$ gives $n^{-3/2}$ and is
> confirmed, pinned by the $P$-side branch alone. $\beta=0$ gives $n^{-1}$ and is **owed**, its
> constant unpinned and its joint minimisation not on file.***

> **The admissible range is a closed interval, and that is what makes the ceiling question empty.**
> $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\uparrow\sqrt2$ forces $\beta\ge0$; [Lemma L143] forces
> $\beta\le\tfrac12$. *So the radius lives in $[n^{-3/2},n^{-1}]$ and there is no region in which a
> ceiling above $n^{-1}$ could bind.*

> **The chain has two branches, not three.** $f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=-ac_p/S^2<0$, so
> $u=0$ is **never** its minimum; the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with
> $f(u^*)=2u^*/a$ […] **So the cubic branch always shadows the quartic, and "both defect branches
> moved out of the way" is impossible in principle.**

> **`HYPOTHESIS-DEBT`, RE-OPENED: THE RADIUS $r_n\gtrsim n^{-1-\beta}$ IS OWED, NOT REFUTED.**

[second-order.md](../../../findings/second-order.md), Lemma L147.

## What this file states

[L147.lean](L147.lean) proves the ceiling two-sidedly and prices the hypothesis that has a witness
against it. **What it leaves untyped is the branch the block minimises and the band the debt lives
in**, and both are ordinary real analysis once the geometry is a binder. All PROVED here, no `sorry`:

- `branch_one_gap`, **the block's minimisation, as an exact identity**:
  `f u − 2u*/a = (u − u*)²/(S + au)` for `u*` the interior stationary point. Everything the block
  says about branch 1 falls out of it: `branch_one_min` (the minimum value is `2u*/a`),
  `branch_one_attained` (it is attained at `u*`), and `zero_is_not_the_minimum` (`f 0 − f u* =
  u*²/S > 0`, so `u = 0` is where branch 1 is *largest*, which is the block's `f'(0) < 0` in a form
  that needs no derivative).
- `fixed_point_iff`, **`u*` without the surd.** The record writes `u* = (√(S²+a²c_p) − S)/a`; the
  identity above needs only `a u*² + 2S u* = a c_p`, and the two are equivalent for `u* ≥ 0`. *So no
  square root enters, and no positivity side condition is owed.*
- `radius_band`, **the closed interval, which is what empties the ceiling question.** For `1 ≤ n`
  and `β ∈ [0, ½]`, `n^(−3/2) ≤ n^(−1−β) ≤ n^(−1)`. With `beta_nonneg_of_one_le`, which derives
  `β ≥ 0` from `θ₀ ≤ n^β` and `1 ≤ θ₀`, the two endpoints of the band are exactly the record's two
  readings.
- `gap_is_a_factor`, the ceiling and the asserted radius differ by `n^(−β)`, an order and not a
  constant; `radius_strictly_below_ceiling` gives the strictness at every `β > 0`.

## What is NOT typed here

- **The radius bound `r_n ≳ n^{−1−β}` itself.** It is the debt. It appears here only inside
  `RadiusDebt`, a named `Prop` with the direction variable `w` quantified over `[0,1]`, *the joint
  minimisation the round records as appearing in no preceding entry*, and `debt_at_left_endpoint`
  says what paying it at `β = 0` would buy: the radius would then meet the proved ceiling's order,
  which is why the left endpoint is the whole of the debt.
- **That the chain's `r(H)` is bounded below by the minimum of the branches**, and that branch 1 has
  the form `(c_p + u²)/(S + au)`. Both need the Cauchy chain, the analyticity disc and `‖A''‖`.
- **The four hypotheses** (`W* = Sᵐ×Sᵐ`, `n = 2m` even, `n ≥ 12`, `ker W* = 0`) and that the last
  has `W_{ℂP²}` as a named witness against it. [L147.lean](L147.lean) carries that as
  `false_hypothesis_silences`; nothing is added here.
- **`sup|P| = Θ(n^β)` as a definition of `β`.** The block itself records that `sup|P|` is bracketed
  rather than known, so `β` is not an exponent; here it is a real parameter and the band is what is
  claimed about it.
-/

namespace HamiltonsCubic.L147Statement

/-! ## 1. Branch 1: the interior minimum, as an identity

*`c` is the margin `c_p`, `S` is `sup|P|`, `a` the linear rate's coefficient, `u` the defect's
linear rate, **not** `w`, the only relation on file being `u ≤ w`.* -/

/-- **`u*` without the square root.** The record's `u* = (√(S² + a²c) − S)/a` is exactly the
nonnegative root of `a u² + 2S u = a c`, and it is that equation, not the surd, that the
minimisation uses. -/
theorem fixed_point_iff {c S a ustar : ℝ} (ha : 0 < a) :
    (a * ustar + S) ^ 2 = S ^ 2 + a ^ 2 * c ↔ a * ustar ^ 2 + 2 * S * ustar = a * c := by
  constructor
  · intro h
    have h' : a * (a * ustar ^ 2 + 2 * S * ustar) = a * (a * c) := by nlinarith [h]
    exact mul_left_cancel₀ (ne_of_gt ha) h'
  · intro h; nlinarith [h]

/-- **The whole of branch 1's minimisation, in one identity.** With `u*` the stationary point,
`f u − 2u*/a = (u − u*)² / (S + a u)`, a perfect square over a positive denominator. -/
theorem branch_one_gap {c S a u ustar : ℝ} (hS : 0 < S) (ha : 0 < a) (hu : 0 ≤ u)
    (hfix : a * ustar ^ 2 + 2 * S * ustar = a * c) :
    (c + u ^ 2) / (S + a * u) - 2 * ustar / a = (u - ustar) ^ 2 / (S + a * u) := by
  have hden : 0 < S + a * u := by positivity
  field_simp
  nlinarith [hfix]

/-- **So `2u*/a` is a lower bound for branch 1 at every admissible rate.** -/
theorem branch_one_min {c S a u ustar : ℝ} (hS : 0 < S) (ha : 0 < a) (hu : 0 ≤ u)
    (hfix : a * ustar ^ 2 + 2 * S * ustar = a * c) :
    2 * ustar / a ≤ (c + u ^ 2) / (S + a * u) := by
  have hden : 0 < S + a * u := by positivity
  have h := branch_one_gap hS ha hu hfix
  nlinarith [div_nonneg (sq_nonneg (u - ustar)) hden.le, h]

/-- **And it is attained**, at `u*` itself: the record's `f(u*) = 2u*/a`. -/
theorem branch_one_attained {c S a ustar : ℝ} (hS : 0 < S) (ha : 0 < a) (hus : 0 ≤ ustar)
    (hfix : a * ustar ^ 2 + 2 * S * ustar = a * c) :
    (c + ustar ^ 2) / (S + a * ustar) = 2 * ustar / a := by
  have h := branch_one_gap (u := ustar) hS ha hus hfix
  have h' : (c + ustar ^ 2) / (S + a * ustar) - 2 * ustar / a = 0 := by simpa using h
  linarith

/-- **`u = 0` is where branch 1 is largest, not smallest**, the block's `f'(0) = −a c_p/S² < 0`,
with no derivative taken: `f 0 − f u* = u*²/S`, strictly positive whenever `u* > 0`. -/
theorem zero_is_not_the_minimum {c S a ustar : ℝ} (hS : 0 < S) (ha : 0 < a) (hus : 0 < ustar)
    (hfix : a * ustar ^ 2 + 2 * S * ustar = a * c) :
    2 * ustar / a < c / S := by
  have h := branch_one_gap (u := 0) hS ha le_rfl hfix
  have hsq : (0 : ℝ) < (0 - ustar) ^ 2 := by nlinarith
  have hpos : 0 < (0 - ustar) ^ 2 / (S + a * 0) := div_pos hsq (by simpa using hS)
  norm_num at h hpos
  linarith

/-! ## 2. The band the debt lives in

*`β ≥ 0` from `sup|P| ≥ θ₀ ≥ 1`, `β ≤ ½` from [L143](../../../findings/bounds.md); between them the
radius is pinned to `[n^(−3/2), n^(−1)]` and no ceiling above `n^(−1)` can bind.* -/

/-- **`β ≥ 0` is forced**, and by the elementary half of the reason: `sup|P| ≥ θ₀ ≥ 1` at every
`n ≥ 12`, and `n^β < 1` for negative `β` once `n > 1`. -/
theorem beta_nonneg_of_one_le {n β : ℝ} (hn : 1 < n) (hS : (1 : ℝ) ≤ n ^ β) : 0 ≤ β := by
  rcases lt_or_ge β 0 with h | h
  · exact absurd hS (not_le.mpr (Real.rpow_lt_one_of_one_lt_of_neg hn h))
  · exact h

/-- **The closed interval.** On `β ∈ [0, ½]` the asserted radius sits between the two readings the
block names, and there is no room above `n^(−1)`. -/
theorem radius_band {n β : ℝ} (hn : 1 ≤ n) (h0 : 0 ≤ β) (h2 : β ≤ 1 / 2) :
    n ^ (-(3 / 2) : ℝ) ≤ n ^ (-(1 + β)) ∧ n ^ (-(1 + β)) ≤ n ^ (-1 : ℝ) := by
  refine ⟨Real.rpow_le_rpow_of_exponent_le hn (by linarith),
    Real.rpow_le_rpow_of_exponent_le hn (by linarith)⟩

/-- **The gap between the asserted radius and the proved ceiling is a factor `n^(−β)`**, a
quantity that varies with `n`, so the two differ by an order rather than by a constant. -/
theorem gap_is_a_factor {n β : ℝ} (hn : 0 < n) :
    n ^ (-(1 + β)) = n ^ (-1 : ℝ) * n ^ (-β) := by
  rw [← Real.rpow_add hn]
  ring_nf

/-- And at every `β > 0` the asserted radius is *strictly* below the ceiling. -/
theorem radius_strictly_below_ceiling {n β : ℝ} (hn : 1 < n) (hβ : 0 < β) :
    n ^ (-(1 + β)) < n ^ (-1 : ℝ) :=
  Real.rpow_lt_rpow_of_exponent_lt hn (by linarith)

/-! ## 3. The debt, named rather than asserted -/

/-- **The joint minimisation the round records as appearing in no preceding entry.** `branch` is the
chain's lower bound as a function of the dimension and of the direction weight `w`; the debt is that
it clears `K·n^(−1−β)` **uniformly in `w ∈ [0,1]`**. *Nothing here proves it; the file states it so
that a later round has something to discharge.* -/
def RadiusDebt (branch : ℝ → ℝ → ℝ) (n β K : ℝ) : Prop :=
  ∀ w ∈ Set.Icc (0 : ℝ) 1, K * n ^ (-(1 + β)) ≤ branch n w

/-- **Why the left endpoint carries the whole debt.** Paying it at `β = 0` puts the radius at
`K·n^(−1)`, the order of the ceiling `3/(n−2)` that [L147.lean](L147.lean) proves two-sidedly, so
at `β = 0` the lower and upper halves of the route meet in order, and at every `β > 0` they do not.
-/
theorem debt_at_left_endpoint {branch : ℝ → ℝ → ℝ} {n K : ℝ}
    (h : RadiusDebt branch n 0 K) (w : ℝ) (hw : w ∈ Set.Icc (0 : ℝ) 1) :
    K * n ^ (-1 : ℝ) ≤ branch n w := by
  have := h w hw
  simpa using this

/-! ## A witness, so the branch statements are not quantified over an empty hypothesis

*At `c = 2`, `S = 1`, `a = 2` the stationary point is `u* = 1`, since `2·1² + 2·1·1 = 4 = 2·2`; the
minimum value is then `2u*/a = 1`, and branch 1 at `u = 3` is `11/7`.* -/

example : (2 : ℝ) * 1 ^ 2 + 2 * 1 * 1 = 2 * 2 := by norm_num

example : (2 : ℝ) * 1 / 2 ≤ (2 + (3 : ℝ) ^ 2) / (1 + 2 * 3) :=
  branch_one_min (c := 2) (S := 1) (a := 2) (u := 3) (ustar := 1) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num)

end HamiltonsCubic.L147Statement
