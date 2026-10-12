import Mathlib

set_option linter.style.longLine false

/-!
# L108, the Cauchy–Schwarz bound on the `g`-distribution, with its equality clause repaired

## The record's statement, quoted verbatim from [bounds.md](../../../findings/bounds.md)

> #### Lemma L108 (the Cauchy–Schwarz bound $\theta\le\tfrac12\sqrt{(n-1)G_2}$), the first legal bound

> **The first legal bound, from Cauchy–Schwarz on the $g$-distribution.** The pinned moments are
> $\sum_kg_k=4(n-1)$ and $\sum_k\lambda_kg_k=-4\theta$, with $g_k\ge0$. Cauchy–Schwarz,
> $(\sum\lambda_kg_k)^2\le(\sum\lambda_k^2g_k)(\sum g_k)$, gives
> $$\boxed{\;\theta\;\le\;\tfrac12\sqrt{(n-1)\,G_2}\;}\qquad\text{with equality iff }\lambda_k\text{ is constant on }\operatorname{supp}(g).$$

and the Gate 2 verdict on that block, which changes what the statement is:

> **THE EQUALITY CLAUSE IS REFUTED IN ONE DIRECTION, IN THREE LINES.** $Q$ is a homogeneous
> quadratic map, so $Q(-W)=Q(W)$ and $-W$ is critical with parameter $-\theta$; and $g_k$ depends
> on $\lambda$ only through $(\lambda_\alpha-\lambda_\beta)^2$, **so $g$, $\operatorname{supp}(g)$
> and $G_2$ all survive $W\mapsto-W$ unchanged.** At $-W_{\text{balanced}}$, $\lambda$ **is**
> constant on $\operatorname{supp}(g)$ while $\theta=-\theta_0<0<\theta_0$. **The repair is to box
> $\lvert\theta\rvert$**, and the sign-free form is already correct fourteen lines below, as
> $m_2\ge m_1^2/m_0$.

> **CRITICALITY NEVER ENTERS, AND THE SCOPE IS UNDERSTATED.** $m_0=4(n-1)$ comes from (A) and (B)
> with unit norm, $m_1=-4\theta$ from (B) with weight $\lambda^2$ together with the **definitional**
> cubic identity, **relation (C) is not consumed**, so the bound holds at every unit
> $W\in\mathcal W_n$ and not only at critical points. […] **The $\tfrac12$ is convention-bound**,
> it is $c^{-1/2}$ with $m_0=c(n-1)$ […], while the $(n-1)$ is not.

> **Its live content is the other direction: $G_2\ge4\theta^2/(n-1)$.**

## What is typed here

* `cauchy_schwarz_moment`, the inequality between the three moments, `m₁² ≤ m₂ m₀`, on
  nonnegative `g`. This is the whole analytic content and it is proved, not assumed.
* `theta_sq_bound`, `abs_theta_bound`, the boxed bound **in the repaired form**, `|θ| ≤ ½√((n-1)G₂)`.
  *Criticality appears in no hypothesis*, which is the record's scope correction: the bound holds
  at every unit `W ∈ 𝒲ₙ`.
* `live_content`, the other direction, `G₂ ≥ 4θ²/(n-1)`, which the record names as what the
  lemma actually delivers.
* `abs_theta_bound_general_convention`, the convention-invariant form. Under a normalisation with
  `m₀ = c(n-1)` and `m₁ = -cθ` the constant is `c^{-1/2}`, and `c = 4` is the record's `½`. The
  `(n-1)` is convention-free.
* `negation_flips_theta_and_fixes_G2`, the mechanism of the refutation: `(−λ, g, −θ)` satisfies
  every moment relation that `(λ, g, θ)` does, with the same `m₀` and the same `G₂`.
* `equality_clause_refuted`, a concrete instance of that mechanism: moment data at `n = 12` where
  `λ` **is** constant on `supp(g)` and yet `θ = −11` sits strictly below the bound `11`. So
  "equality iff constant on `supp(g)`" is false as an `iff` for `θ`.
* `equality_clause_repaired`, the surviving direction, for `|θ|`: constant on `supp(g)` gives
  equality in the boxed form.

Everything is proved; there is no `sorry`.

## What is NOT typed here

**The bridge to `HamiltonsCubic.RealLayer` is not typed**, for the same reason as in
[L107Statement.lean](L107Statement.lean): `λ` is the `Λ²` spectrum and `g_k = ‖[ad(v_k), W]‖²`, and
the real Weyl layer has neither. `m₀` and `m₁` therefore enter as hypotheses on abstract data.

**The `iff` in the equality clause is typed in one direction only.** `equality_clause_repaired`
proves that constancy on the support gives equality; the converse (equality forces constancy) is
the equality case of Cauchy–Schwarz, which is true but is not stated here, since what the record's
own Gate 2 changed is the other direction.

**The elimination onto the `Π`-bound lives in [L107Statement.lean](L107Statement.lean)**, which is
where the record puts its home.
-/

namespace HamiltonsCubic.L108Statement

open Finset

variable {κ : Type*} [Fintype κ]

/-! ## The analytic content -/

/-- **CAUCHY–SCHWARZ ON THE `g`-DISTRIBUTION.** `(∑ λ g)² ≤ (∑ λ² g)(∑ g)` for `g ≥ 0`, the
weighted form, with the weight carried by `g` rather than by a square root. -/
theorem cauchy_schwarz_moment {lam g : κ → ℝ} (hg : ∀ k, 0 ≤ g k) :
    (∑ k, lam k * g k) ^ 2 ≤ (∑ k, lam k ^ 2 * g k) * ∑ k, g k :=
  Finset.sum_sq_le_sum_mul_sum_of_sq_le_mul Finset.univ
    (fun k _ => mul_nonneg (sq_nonneg _) (hg k)) (fun k _ => hg k)
    (fun k _ => le_of_eq (by ring))

/-! ## The bound -/

/-- **The squared form of the boxed bound**, `4θ² ≤ (n-1)G₂`, from the two pinned moments.
*No criticality hypothesis appears.* -/
theorem theta_sq_bound {lam g : κ → ℝ} {n θ G2 : ℝ}
    (hg : ∀ k, 0 ≤ g k)
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hm2 : ∑ k, lam k ^ 2 * g k = G2) :
    4 * θ ^ 2 ≤ (n - 1) * G2 := by
  have h := cauchy_schwarz_moment (lam := lam) hg
  rw [hm0, hm1, hm2] at h
  nlinarith [h]

/-- **THE BOXED BOUND, IN THE REPAIRED FORM `|θ| ≤ ½√((n-1)G₂)`.** The record's own Gate 2 refutes
the boxed `θ` in one direction and names `|θ|` as the repair; this is that statement. -/
theorem abs_theta_bound {lam g : κ → ℝ} {n θ G2 : ℝ}
    (hg : ∀ k, 0 ≤ g k)
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hm2 : ∑ k, lam k ^ 2 * g k = G2) :
    |θ| ≤ (1 / 2) * Real.sqrt ((n - 1) * G2) := by
  have hsq := theta_sq_bound hg hm0 hm1 hm2
  have hb : (2 * |θ|) ^ 2 ≤ (n - 1) * G2 := by
    rw [mul_pow, sq_abs]; linarith
  have h2 : 2 * |θ| ≤ Real.sqrt ((n - 1) * G2) := by
    have := Real.sqrt_le_sqrt hb
    rwa [Real.sqrt_sq (by positivity)] at this
  linarith

/-- **THE LIVE CONTENT, `G₂ ≥ 4θ²/(n-1)`.** The record records that as an upper bound on `θ` the
inequality bounds nothing alone, and that the direction it actually delivers is this one. -/
theorem live_content {lam g : κ → ℝ} {n θ G2 : ℝ}
    (hn : 0 < n - 1)
    (hg : ∀ k, 0 ≤ g k)
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hm2 : ∑ k, lam k ^ 2 * g k = G2) :
    4 * θ ^ 2 / (n - 1) ≤ G2 := by
  have hsq := theta_sq_bound hg hm0 hm1 hm2
  rw [div_le_iff₀ hn]
  linarith

/-- **THE CONVENTION-INVARIANT FORM.** Under a normalisation in which the pinned moments read
`m₀ = c(n-1)` and `m₁ = -cθ`, the constant in front of `√((n-1)G₂)` is `c^{-1/2}`; the `(n-1)` is
convention-free. *The record's `½` is the case `c = 4`, which is ordered slots with Hamilton's `½`
in `#`.* -/
theorem abs_theta_bound_general_convention {lam g : κ → ℝ} {n θ G2 c : ℝ}
    (hc : 0 < c)
    (hg : ∀ k, 0 ≤ g k)
    (hm0 : ∑ k, g k = c * (n - 1))
    (hm1 : ∑ k, lam k * g k = -c * θ)
    (hm2 : ∑ k, lam k ^ 2 * g k = G2) :
    |θ| ≤ (1 / Real.sqrt c) * Real.sqrt ((n - 1) * G2) := by
  have h := cauchy_schwarz_moment (lam := lam) hg
  rw [hm0, hm1, hm2] at h
  have hsq : c * θ ^ 2 ≤ (n - 1) * G2 := by nlinarith [h]
  have hcs : Real.sqrt c > 0 := Real.sqrt_pos.mpr hc
  have hcsq : Real.sqrt c ^ 2 = c := Real.sq_sqrt hc.le
  have hb : (Real.sqrt c * |θ|) ^ 2 ≤ (n - 1) * G2 := by
    rw [mul_pow, sq_abs, hcsq]; linarith
  have h2 : Real.sqrt c * |θ| ≤ Real.sqrt ((n - 1) * G2) := by
    have := Real.sqrt_le_sqrt hb
    rwa [Real.sqrt_sq (by positivity)] at this
  rw [one_div, inv_mul_eq_div, le_div_iff₀ hcs, mul_comm]
  exact h2

/-! ## The equality clause -/

/-- **THE MECHANISM OF THE REFUTATION.** `g` depends on `λ` only through squared differences, so
`W ↦ -W` (which sends `λ ↦ -λ`), leaves `g`, `supp(g)` and `G₂` alone while flipping `θ`. Here:
whatever moment relations `(λ, g, θ)` satisfies, `(-λ, g, -θ)` satisfies with the **same** `m₀` and
the **same** `G₂`. -/
theorem negation_flips_theta_and_fixes_G2 {lam g : κ → ℝ} {n θ G2 : ℝ}
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hm2 : ∑ k, lam k ^ 2 * g k = G2) :
    (∑ k, g k = 4 * (n - 1)) ∧
      (∑ k, (-lam k) * g k = -4 * (-θ)) ∧
      (∑ k, (-lam k) ^ 2 * g k = G2) := by
  refine ⟨hm0, ?_, ?_⟩
  · have : ∑ k, (-lam k) * g k = -∑ k, lam k * g k := by
      rw [← Finset.sum_neg_distrib]; exact Finset.sum_congr rfl fun k _ => by ring
    rw [this, hm1]; ring
  · have : ∑ k, (-lam k) ^ 2 * g k = ∑ k, lam k ^ 2 * g k :=
      Finset.sum_congr rfl fun k _ => by ring
    rw [this, hm2]

/-- **THE EQUALITY CLAUSE IS FALSE AS AN `iff` FOR `θ`.** Moment data at `n = 12` with `λ` constant
on `supp(g)` (the mass sits at the single index `0`, where `λ = 1`) and yet `θ = -11` lies
**strictly** below the boxed value `½√((n-1)G₂) = 11`. *This is the record's `-W_balanced` in
miniature.* -/
theorem equality_clause_refuted :
    (∀ k, 0 ≤ (![44, 0] : Fin 2 → ℝ) k) ∧
      (∑ k, (![44, 0] : Fin 2 → ℝ) k = 4 * ((12 : ℝ) - 1)) ∧
      (∑ k, (![1, 1] : Fin 2 → ℝ) k * (![44, 0] : Fin 2 → ℝ) k = -4 * (-11 : ℝ)) ∧
      (∑ k, (![1, 1] : Fin 2 → ℝ) k ^ 2 * (![44, 0] : Fin 2 → ℝ) k = (44 : ℝ)) ∧
      (∀ k, (![44, 0] : Fin 2 → ℝ) k ≠ 0 → (![1, 1] : Fin 2 → ℝ) k = 1) ∧
      (1 / 2) * Real.sqrt (((12 : ℝ) - 1) * 44) = 11 ∧
      (-11 : ℝ) < 11 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, by norm_num⟩
  · intro k; fin_cases k <;> norm_num
  · norm_num [Fin.sum_univ_two]
  · norm_num [Fin.sum_univ_two]
  · norm_num [Fin.sum_univ_two]
  · intro k; fin_cases k <;> norm_num
  · rw [show ((12 : ℝ) - 1) * 44 = 22 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
    norm_num

/-- **THE SURVIVING DIRECTION.** If `λ` is constant on `supp(g)` then the repaired bound is an
equality: `|θ| = ½√((n-1)G₂)`. -/
theorem equality_clause_repaired {lam g : κ → ℝ} {n θ G2 c : ℝ}
    (hn : 0 ≤ n - 1)
    (hm0 : ∑ k, g k = 4 * (n - 1))
    (hm1 : ∑ k, lam k * g k = -4 * θ)
    (hm2 : ∑ k, lam k ^ 2 * g k = G2)
    (hconst : ∀ k, g k ≠ 0 → lam k = c) :
    |θ| = (1 / 2) * Real.sqrt ((n - 1) * G2) := by
  have h1 : ∑ k, lam k * g k = c * ∑ k, g k := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rcases eq_or_ne (g k) 0 with h | h
    · simp [h]
    · rw [hconst k h]
  have h2 : ∑ k, lam k ^ 2 * g k = c ^ 2 * ∑ k, g k := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rcases eq_or_ne (g k) 0 with h | h
    · simp [h]
    · rw [hconst k h]
  rw [hm0, hm1] at h1
  rw [hm0, hm2] at h2
  have hth : θ = -(c * (n - 1)) := by linarith
  have hG2 : G2 = c ^ 2 * (4 * (n - 1)) := by linarith
  subst hth
  rw [hG2]
  rw [show (n - 1) * (c ^ 2 * (4 * (n - 1))) = (2 * (|c| * (n - 1))) ^ 2 by
    rw [mul_pow, mul_pow, sq_abs]; ring]
  rw [Real.sqrt_sq (by positivity)]
  rw [abs_neg, abs_mul, abs_of_nonneg hn]
  ring

end HamiltonsCubic.L108Statement
