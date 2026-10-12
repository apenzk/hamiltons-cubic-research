import Mathlib

set_option linter.style.longLine false

/-!
# L107, the `Π`-bound `θ ≤ (n-1)|λ_min|`, on the moment data it is derived from

## The record's statement, quoted verbatim from [bounds.md](../../../findings/bounds.md)

> #### Lemma L107, the $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$

> **Quantifier: the bound holds at every $W\in\mathcal W_n$, not only at critical points.** The row
> derivation below uses relation (C), which needs criticality; the $g$-route does not,
> $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}\ge0$
> manifestly at every $W$, and $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$
> follow from (A) and (B) with the cubic identity.

> **Both sign conditions are automatic and the block discharged neither.** $\lambda_{\max}>0$ and
> $\lambda_{\min}<0$ follow from tracelessness at any $W\ne0$, and the derivation divides by
> $\lambda_{\max}$ and reads $-\lambda_{\min}=\lvert\lambda_{\min}\rvert$.

> **The bound is TIGHT, not auxiliary.** At the balanced product $(n-1)\lvert\lambda_{\min}\rvert=\theta_0(n)$
> **exactly**, and by the isotropy mechanism equality holds at **every** Einstein $S^p\times S^q$;
> the equality case is $\operatorname{supp}(g)\subseteq E_{\min}$.

and the derivation the record calls the second one, from the same file:

> **A second derivation, sharing nothing with the elimination above.** […] use **$\lambda_k\ge\lambda_{\min}$
> termwise** in $\sum_k\lambda_kg_k=-4\theta$ against $\sum_kg_k=4(n-1)$:
> $-4\theta=\sum_k\lambda_kg_k\ge\lambda_{\min}\sum_kg_k=4(n-1)\lambda_{\min}$, so
> $\theta\le-(n-1)\lambda_{\min}$.

together with the elimination whose home the record names as this lemma:

> $$\theta^2+(n-1)(s-m)\theta-(n-1)^2ms\le0\;\Longrightarrow\;\theta\le\frac{n-1}2\Big[-(s-m)+\sqrt{(s-m)^2+4ms}\Big]=(n-1)m.$$

## What is typed here

The bound and both of the record's routes to it, over the `g`-moment data:

* `Pi_bound`, the one-sided route. `g ≥ 0`, `∑ g = 4(n-1)`, `∑ λ g = -4θ` and `λ ≥ λ_min`
  termwise give `θ ≤ -(n-1)λ_min`, with `Pi_bound_abs` reading the right side as
  `(n-1)|λ_min|` once `λ_min < 0`. **Criticality is nowhere in it**, matching the record's
  quantifier correction, and no sign hypothesis on `n` is used.
* `Pi_bound_equality_case`, `supp(g) ⊆ E_min` turns the bound into an equality, which is the
  record's equality case and its tightness claim at every Einstein `Sᵖ × Sᵍ`.
* `Pi_bound_via_elimination`, the second, independent route: Cauchy–Schwarz below and the support
  inequality above on the free moment `G₂`, eliminated. The discriminant telescoping is what makes
  the collapse exact, and the Lean proof is the corresponding factorisation
  `(θ - (n-1)m)(θ + (n-1)s) ≤ 0`.
* `spectrum_straddles_zero`, the sign conditions the record says the block discharged neither of:
  a trace-free spectrum that is not identically zero has a strictly negative and a strictly
  positive entry.
* `witness`, moment data satisfying every hypothesis, with the bound attained, so none of the
  statements above is vacuous.

Everything is proved; there is no `sorry`.

## What is NOT typed here

**The bridge from `HamiltonsCubic.RealLayer` to this moment data is carried elsewhere**:
`∑ g = 4(n-1)‖W‖²` and `∑ λ g = -4P(W)` are [L41Statement.lean](L41Statement.lean)'s `first_identity` and
`second_identity` in an eigenframe, and [L107Frame.lean](L107Frame.lean)'s `L107_every_exists` states the bound
on the Weyl tensor itself. This file keeps them as named hypotheses on abstract data and proves the
inequality between moments. *The record attributes those two
moment identities to [Petersen–Wink 1908.09958](../../../references/petersen-wink-2019-bochner-technique/notes.md)
Prop 1.7 with the Killing form, and to
[Petersen–Wink 2105.09290](../../../references/petersen-wink-2021-tachibana-special-holonomy/) Prop 1.3.*

**The sharpened chord form is [L107Chord.lean](L107Chord.lean)'s `L107_chord`**, the chord taken over
`[ℓ_a, σ_a]` inside the row calculus in the eigenframe, which carries the tensor `T` this file does not.
-/

namespace HamiltonsCubic.L107Statement

open Finset

variable {κ : Type*} [Fintype κ]

/-! ## The bound, by the one-sided route -/

/-- **THE `Π`-BOUND.** From the two pinned moments of the `g`-distribution, its nonnegativity, and
`λ_min` a lower bound for the spectrum, `θ ≤ -(n-1)λ_min`. *Criticality is not among the
hypotheses, which is the record's own quantifier correction: the bound holds at every
`W ∈ 𝒲ₙ`.* -/
theorem Pi_bound {lam g : κ → ℝ} {n θ lmin : ℝ}
    (hg : ∀ k, 0 ≤ g k)
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hmin : ∀ k, lmin ≤ lam k) :
    θ ≤ -((n - 1) * lmin) := by
  have key : lmin * ∑ k, g k ≤ ∑ k, lam k * g k := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun k _ => mul_le_mul_of_nonneg_right (hmin k) (hg k)
  rw [hm0, hm1] at key
  linarith

/-- **The bound as the record boxes it**, `θ ≤ (n-1)|λ_min|`, once the automatic sign condition
`λ_min < 0` is available. -/
theorem Pi_bound_abs {lam g : κ → ℝ} {n θ lmin : ℝ}
    (hg : ∀ k, 0 ≤ g k)
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hmin : ∀ k, lmin ≤ lam k)
    (hneg : lmin < 0) :
    θ ≤ (n - 1) * |lmin| := by
  have h := Pi_bound hg hm0 hm1 hmin
  rw [abs_of_neg hneg]
  linarith

/-- **THE EQUALITY CASE, `supp(g) ⊆ E_min`.** When every index carrying mass sits at `λ_min`, the
inequality is an equality, the record's tightness claim, which it locates at the balanced product
and at every Einstein `Sᵖ × Sᵍ`. -/
theorem Pi_bound_equality_case {lam g : κ → ℝ} {n θ lmin : ℝ}
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hsupp : ∀ k, g k ≠ 0 → lam k = lmin) :
    θ = -((n - 1) * lmin) := by
  have hsum : ∑ k, lam k * g k = lmin * ∑ k, g k := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rcases eq_or_ne (g k) 0 with h | h
    · simp [h]
    · rw [hsupp k h]
  rw [hm0, hm1] at hsum
  linarith

/-! ## The bound, by elimination between the two moment inequalities

*`s = λ_max`, `m = |λ_min|`, `G₂ = m₂` the free moment. The lower bound on `G₂` is Cauchy–Schwarz
([Lemma L108](../../../findings/bounds.md)), the upper bound is the support inequality
`∑ (λ - λ_min)(λ_max - λ) g ≥ 0` unpacked.* -/

/-- **THE ELIMINATION COLLAPSES EXACTLY ONTO THE `Π`-BOUND.** Cauchy–Schwarz below and support
above bracket the free moment `G₂`; eliminating it leaves
`θ² + (n-1)(s-m)θ - (n-1)²ms ≤ 0`, which factors as `(θ - (n-1)m)(θ + (n-1)s) ≤ 0`, and with
`s, m > 0` that is `θ ≤ (n-1)m`. *This is the record's second derivation, sharing no step with
`Pi_bound` above.* -/
theorem Pi_bound_via_elimination {n θ s m G2 : ℝ}
    (hn : 0 < n - 1) (hs : 0 < s) (hm : 0 < m)
    (hCS : 4 * θ ^ 2 ≤ (n - 1) * G2)
    (hsupp : G2 ≤ (-m + s) * (-4 * θ) - (-m) * s * (4 * (n - 1))) :
    θ ≤ (n - 1) * m := by
  nlinarith [mul_pos hn hs, mul_pos hn hm, sq_nonneg (θ - (n - 1) * m),
    sq_nonneg (θ + (n - 1) * s)]

/-! ## The sign conditions, which are automatic -/

/-- **A trace-free spectrum straddles zero.** The record records both sign conditions as automatic
from tracelessness at `W ≠ 0` and as discharged nowhere; this is that step. -/
theorem spectrum_straddles_zero {lam : κ → ℝ} (htr : ∑ k, lam k = 0)
    {j : κ} (hj : lam j ≠ 0) :
    (∃ a, lam a < 0) ∧ (∃ b, 0 < lam b) := by
  constructor
  · by_contra hcon
    have hcon' : ∀ a, 0 ≤ lam a := fun a => not_lt.mp fun h => hcon ⟨a, h⟩
    have hall : ∀ k ∈ (Finset.univ : Finset κ), 0 ≤ lam k := fun k _ => hcon' k
    exact hj ((Finset.sum_eq_zero_iff_of_nonneg hall).mp htr j (Finset.mem_univ j))
  · by_contra hcon
    have hcon' : ∀ b, lam b ≤ 0 := fun b => not_lt.mp fun h => hcon ⟨b, h⟩
    have hall : ∀ k ∈ (Finset.univ : Finset κ), 0 ≤ (fun i => -lam i) k := fun k _ => by
      simpa using hcon' k
    have hsum : ∑ k, (-lam k) = 0 := by simp [Finset.sum_neg_distrib, htr]
    have := (Finset.sum_eq_zero_iff_of_nonneg hall).mp hsum j (Finset.mem_univ j)
    exact hj (by linarith [this])

/-! ## A witness, so that nothing above is vacuous -/

/-- Moment data at `n = 12` satisfying every hypothesis of `Pi_bound`, with the bound **attained**:
all the mass sits at `λ_min = -1`, so `θ = 11 = (n-1)|λ_min|`. -/
example : (∀ k, 0 ≤ (![0, 44] : Fin 2 → ℝ) k) ∧
    (∑ k, (![0, 44] : Fin 2 → ℝ) k = 4 * ((12 : ℝ) - 1)) ∧
    (∑ k, (![1, -1] : Fin 2 → ℝ) k * (![0, 44] : Fin 2 → ℝ) k = -4 * (11 : ℝ)) ∧
    (∀ k, (-1 : ℝ) ≤ (![1, -1] : Fin 2 → ℝ) k) ∧
    (11 : ℝ) = ((12 : ℝ) - 1) * |(-1 : ℝ)| := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · intro k; fin_cases k <;> norm_num
  · simp [Fin.sum_univ_two]; norm_num
  · simp [Fin.sum_univ_two]; norm_num
  · intro k; fin_cases k <;> norm_num
  · norm_num

end HamiltonsCubic.L107Statement
