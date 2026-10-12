import Mathlib

/-!
# L158, the branch comparison

From [second-order.md](../../../findings/second-order.md), the block headed *"Lemma L158, the
branch comparison turns on one dimension-dependent constant"*, quoted so the Lean can be read
against it:

> **The surviving mechanism.** With [Lemma L149](../../../findings/second-order.md)'s `c_p = κ/n`,
> branch 1 `= (c_p + w²)/S` is increasing in `w` with infimum `κ/(nS)`, and branch 2 has an infimum
> of order `n⁻¹`. **The `n⁻¹` cancels from their ratio**, so which branch binds is decided by an
> inequality carrying no dimension … *and branch 1 binds, making `S = sup|P|`, hence
> [I31](../../../plan.md), load-bearing, exactly when `S` exceeds `√(κ(1+κ))/K`.*
> **`inf_w min(f,g) = min(inf f, inf g)` is an identity, so comparing separately-taken infima is
> sound.**

## What is NOT typed here

- **That branch 1 and branch 2 are the two branches of anything.** `W* = Sᵐ × Sᵐ`, `H ⊥ T_{W*}𝒪`,
  `sup|P|` and the second-variation quotient are not in this layer, so the two branches enter as
  functions of `w` with the record's own shapes and the conclusion is about those functions.
- **`κ`'s value.** The block fixes `c_p = 3θ₀/(n−2)`; here `κ` is a positive real parameter, which
  is the generality the ratio argument uses.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L158Statement

open Finset

/-- **The identity the block leans on**, and the reason comparing separately-taken infima is sound:
the infimum of a pointwise minimum is the minimum of the infima. -/
theorem inf'_min_eq {α : Type*} {s : Finset α} (hs : s.Nonempty) (f g : α → ℝ) :
    s.inf' hs (fun x => min (f x) (g x)) = min (s.inf' hs f) (s.inf' hs g) := by
  refine le_antisymm (le_min ?_ ?_) (Finset.le_inf' hs _ fun x hx => ?_)
  · exact Finset.le_inf' hs _ fun x hx =>
      le_trans (Finset.inf'_le _ hx) (min_le_left _ _)
  · exact Finset.le_inf' hs _ fun x hx =>
      le_trans (Finset.inf'_le _ hx) (min_le_right _ _)
  · exact le_min (le_trans (min_le_left _ _) (Finset.inf'_le f hx))
      (le_trans (min_le_right _ _) (Finset.inf'_le g hx))

/-- **Branch 1**, `(c_p + w²)/S`. -/
noncomputable def branch1 (cp S w : ℝ) : ℝ := (cp + w ^ 2) / S

/-- **Branch 1 is increasing in `w` on `[0,1]`**, which is what puts its infimum at `w = 0`. -/
theorem branch1_mono {cp S : ℝ} (hS : 0 < S) {w₁ w₂ : ℝ} (h0 : 0 ≤ w₁) (h : w₁ ≤ w₂) :
    branch1 cp S w₁ ≤ branch1 cp S w₂ := by
  unfold branch1
  gcongr

/-- **Branch 1's infimum over `w ∈ [0,1]` is `c_p/S`**, attained at `w = 0`. -/
theorem branch1_inf {cp S : ℝ} (hS : 0 < S) {w : ℝ} (_hw : 0 ≤ w) :
    cp / S ≤ branch1 cp S w := by
  unfold branch1
  gcongr
  nlinarith [sq_nonneg w]

/-- **With `c_p = κ/n` the infimum is `κ/(nS)`**, which is the record's display. -/
theorem branch1_inf_eq (kappa n S : ℝ) (hn : n ≠ 0) (hS : S ≠ 0) :
    (kappa / n) / S = kappa / (n * S) := by
  field_simp

/-- **The dimension cancels from the ratio.** With branch 1's infimum `κ/(nS)` and branch 2's
`K·√(κ(1+κ))⁻¹·n⁻¹` (the record's *order `n⁻¹`*), the quotient carries no `n`. -/
theorem ratio_dimension_free (kappa n S K : ℝ) (hn : 0 < n) (hS : 0 < S) (hK : 0 < K)
    (hk : 0 < kappa) :
    (kappa / (n * S)) / (K * kappa / (Real.sqrt (kappa * (1 + kappa)) * n))
      = Real.sqrt (kappa * (1 + kappa)) / (S * K) := by
  have hsq : 0 < Real.sqrt (kappa * (1 + kappa)) :=
    Real.sqrt_pos.mpr (by nlinarith)
  field_simp

/-- **The threshold, and it carries no dimension**: branch 1 binds, the quotient falling below
one, exactly when `S` exceeds `√(κ(1+κ))/K`. -/
theorem branch1_binds_iff (kappa S K : ℝ) (hS : 0 < S) (hK : 0 < K) (hk : 0 < kappa) :
    Real.sqrt (kappa * (1 + kappa)) / (S * K) < 1 ↔ Real.sqrt (kappa * (1 + kappa)) / K < S := by
  have hsq : 0 < Real.sqrt (kappa * (1 + kappa)) :=
    Real.sqrt_pos.mpr (by nlinarith)
  rw [div_lt_one (by positivity), div_lt_iff₀ hK]

/-- **So `sup |P|` is load-bearing**: the record's conclusion that `S` must GROW before the item
can bind is the statement that the threshold is a fixed positive number, independent of `n`. -/
theorem threshold_pos (kappa K : ℝ) (hK : 0 < K) (hk : 0 < kappa) :
    0 < Real.sqrt (kappa * (1 + kappa)) / K :=
  div_pos (Real.sqrt_pos.mpr (by nlinarith)) hK


/-! # Four more steps of the same comparison, none of them numerical

*Added alongside the branch material above. Each is stated on squares or on a variable standing for
a root, so no square root is taken: the record's `√(4t+1)` is `q` with `q ≥ 0` and
`q² = 4t+1`, and its `√(1−w²)` is `r` with `r ≥ 0` and `r² = 1−w²`.*

**Still not typed**, beyond the two exclusions above: `K = λ(1−η*)²/(√2 J)` and
its ingredients, so the threshold `T = 18.00` and the reformulated `s* ≈ 15` carry no numeral
here; and which branch binds at `n = 12`, which needs them. -/

/-! ## L157's root rationalised, and the elasticity it produces

*`q` stands for `√(4t+1)`, carried as a variable with `q ≥ 0` and `q² = 4t+1`, so no root is taken.*

> **THE r713/r714 DISPUTE IS SETTLED WITHOUT ARITHMETIC.** Rationalising [L157]'s root to
> `1 − η* = 2/(√(4t+1)+1)` and writing `s = √(c_p + w²)`, `t = βs`,
> `d log(K(w)√(c_p + ρ^eff w²))/d log s = 1/√(4t+1) ∈ (0,1)` for every `λ, J, γ`. -/

/-- **`1 − η* = 2/(q+1)`**, the rationalisation that settles the dispute in general rather than at
one dimension. -/
theorem one_sub_eta_rationalised {t q : ℝ} (ht : 0 < t) (hq : 0 ≤ q) (hq2 : q ^ 2 = 4 * t + 1) :
    1 - (2 * t + 1 - q) / (2 * t) = 2 / (q + 1) := by
  have hq1 : (0 : ℝ) < q + 1 := by linarith
  have ht' : (2 : ℝ) * t ≠ 0 := by positivity
  field_simp
  nlinarith [hq2]

/-- **And the elasticity is strictly inside `(0,1)`.** `q² = 4t + 1 > 1` with `q ≥ 0` gives `q > 1`,
so `1/q ∈ (0,1)`: the composite rises with `s` at every `λ, J, γ`, which is what refutes r714's point
in general. *`K`'s decrease can never overturn the rise above the kink.* -/
theorem elasticity_in_unit_interval {t q : ℝ} (ht : 0 < t) (hq : 0 ≤ q) (hq2 : q ^ 2 = 4 * t + 1) :
    0 < 1 / q ∧ 1 / q < 1 := by
  have hqgt : 1 < q := by nlinarith
  have hqpos : 0 < q := by linarith
  refine ⟨by positivity, ?_⟩
  rw [div_lt_one hqpos]
  exact hqgt

/-! ## The envelope, and where it crosses

> `‖H‖_op ≤ min(a₀n^{-1/2}√(1−w²) + w, 1)`, **crossing `1` at
> `w₀ = (1 − a₀²/n)/(1 + a₀²/n) = (n−4)/n`.** -/

/-- **The homogeneity kink, derived rather than evaluated.** With `r` standing for `√(1−w²)`, the
envelope `b·r + w` reaches `1` exactly at `w = (1−b²)/(1+b²)`. *`H_s ⟂ H_r` is what makes
`‖H_s‖_F = √(1−w²)` an identity and [L146](../../../findings/second-order.md)'s homogeneity is what
lets it multiply through; both are hypotheses here.* -/
theorem envelope_crossing {b w r : ℝ} (hb : 0 < b) (hw1 : w < 1) (hr : 0 ≤ r)
    (hr2 : r ^ 2 = 1 - w ^ 2) :
    b * r + w = 1 ↔ w = (1 - b ^ 2) / (1 + b ^ 2) := by
  have hden : (0 : ℝ) < 1 + b ^ 2 := by positivity
  constructor
  · intro h
    have hbr : b * r = 1 - w := by linarith
    have hsq : b ^ 2 * r ^ 2 = (1 - w) ^ 2 := by nlinarith [hbr]
    rw [hr2] at hsq
    have hfac : (1 - w) * (b ^ 2 * (1 + w) - (1 - w)) = 0 := by nlinarith [hsq]
    have h1w : (1 : ℝ) - w ≠ 0 := by linarith
    have h2 : b ^ 2 * (1 + w) - (1 - w) = 0 := by
      rcases mul_eq_zero.mp hfac with h' | h'
      · exact absurd h' h1w
      · exact h'
    field_simp
    linarith
  · intro h
    have hrval : r = 2 * b / (1 + b ^ 2) := by
      have hnn : (0 : ℝ) ≤ 2 * b / (1 + b ^ 2) := by positivity
      have hsq : r ^ 2 = (2 * b / (1 + b ^ 2)) ^ 2 := by
        rw [hr2, h]
        field_simp
        ring
      exact (sq_eq_sq₀ hr hnn).mp hsq
    rw [hrval, h]
    field_simp
    ring

/-- **At `b² = a₀²/n = 2/(n−2)` the crossing is the record's `w₀ = (n−4)/n`.** -/
theorem kink_in_n {n : ℝ} (hn : 2 < n) :
    (1 - 2 / (n - 2)) / (1 + 2 / (n - 2)) = (n - 4) / n := by
  have h2 : n - 2 ≠ 0 := by linarith
  have hn0 : n ≠ 0 := by linarith
  have hnum : 1 - 2 / (n - 2) = (n - 4) / (n - 2) := by
    field_simp
    ring
  have hden : 1 + 2 / (n - 2) = n / (n - 2) := by
    field_simp
    ring
  rw [hnum, hden]
  field_simp

/-! ## What an upper bound on `S` can and cannot show

> **The known bounds on `S` are upper ones, and an upper bound can only show branch 1 FAILS to
> bind.** -/

/-- **An upper bound refutes binding when it falls below the threshold.** `S ≤ U ≤ T` gives
`¬ (T < S)`, *"branch 1 does not bind wherever `S`'s upper bound falls below the threshold"*. -/
theorem upper_bound_cannot_show_binding {S U T : ℝ} (hSU : S ≤ U) (hUT : U ≤ T) : ¬ T < S := by
  intro h
  linarith

/-- **And when the upper bound is above the threshold it decides nothing.** Both readings survive,
so no upper bound can establish binding; the lemma is a condition on [I31](../../../plan.md) rather
than a verdict on it. -/
theorem upper_bound_leaves_it_open {U T : ℝ} (hT : 0 < T) (hTU : T < U) :
    ∃ S₁ S₂ : ℝ, S₁ ≤ U ∧ S₂ ≤ U ∧ S₁ < T ∧ T < S₂ := by
  refine ⟨0, (T + U) / 2, by linarith, by linarith, hT, by linarith⟩

/-! ## Witnesses, so no hypothesis is empty

*The envelope at `b = 1` crosses at `w = 0`; the elasticity at `t = 2`, `q = 3`.* -/

example : (0 : ℝ) < 1 / 3 ∧ (1 : ℝ) / 3 < 1 :=
  elasticity_in_unit_interval (t := 2) (q := 3) (by norm_num) (by norm_num) (by norm_num)

example : ((1 : ℝ) * 1 + 0 = 1) ↔ (0 : ℝ) = (1 - 1 ^ 2) / (1 + 1 ^ 2) :=
  envelope_crossing (b := 1) (w := 0) (r := 1) one_pos (by norm_num) zero_le_one (by norm_num)

end HamiltonsCubic.L158Statement
