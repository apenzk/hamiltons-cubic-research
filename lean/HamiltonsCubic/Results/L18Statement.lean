import Mathlib

set_option linter.style.longLine false

/-!
# L18, the priced term, in the Gram mechanism that prices it, and the three thresholds it is read against

## The record's statement, verbatim

[problem.md](../../../findings/problem.md)'s *Lemma L18, the priced term, and the conditional
dichotomy it feeds*, as its audit splits it:

> **AUDITED 2026-09-04: REFUTED AS STATED, AND IT IS TWO CLAIMS OF DIFFERENT STATUS.**
>
> **The pricing half is a Lemma**: unconditional, pointwise, dimension-free,
> $J_4\le24\,\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ from the positive-semidefinite
> Gram form with constant $\tfrac32$. *The constant $24$ is right:
> $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$ because $\mathrm{Alt}(W)=0$, so
> $\operatorname{tr}D=6\cdot4\delta^2$.*
>
> **The dichotomy half is an Observation on two grants**, and the block named one.

with the mechanism spelled out:

> **What that proof gives, exactly**: $D_{ij}=\tfrac32\langle a_i,a_j\rangle$ makes $D\succeq0$
> free, $\operatorname{tr}D=\tfrac32\cdot4\lVert\mathrm{Alt}\rVert^2=6\lVert\mathrm{Alt}\rVert^2$,
> and $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ gives $24\delta^2$, needing
> $\mathrm{Alt}(W)=0$ and **no criticality at all**, contrary to the framing.

and the three thresholds the dichotomy is read against:

> $\tilde\theta_0$, $\hat\theta_0$ AND $\Theta_n$ ARE THREE DIFFERENT NUMBERS, STRICTLY ORDERED.
> [...] $\tilde\theta_0$ is **defined**, at Jäger's Notation 3.0.3, the $S^m\times S^{m+1}$
> value, and $\hat\theta_0(n)=\frac{n-2}{n-3}\tilde\theta_0(n)$ by definition [...] **At even $n$
> they separate**: $\theta_0(n)^2-\tilde\theta_0(n)^2=\frac{8(n-1)}{n^2(n+1)(n-2)}>0$, and at
> $n=12$ the three squares are $\tfrac{99}{65}<\tfrac{55}{36}<\tfrac{220}{117}$.

> **THE STATED COST IS THE WRONG LEVEL.** [...] the chain penalty is $(J_4-J_5)/\sqrt{1-e^2}$ and
> the block quotes the numerator. *At Fox's $\mathcal S^4(\alpha)$, $\sqrt{1-e^2}=\tfrac23$ and
> $J_5=0$, so the chain penalty is exactly $\tfrac32J_4$.*

> **That width is $\theta_0(12)-\sqrt{3/2}$, between $0.0112$ and $0.0113$**

## What is NOT typed here

**The dichotomy half.** *"Every critical point clearing the threshold has either
`scal(|W|) ≥ (n+1)θ̃₀(n)`, or defect bounded below by an explicit constant"* quantifies over
critical points of `P` and speaks about `scal(|W|)` and `δ² = ‖Alt(W₋)‖²`. None of `Weyl_n`,
criticality, `|W|`, `Alt` or the spectral decomposition `W = W₊ − W₋` has a Lean base layer in
this repository, so the dichotomy cannot be stated. **It is in any case an Observation on two
grants**, `J₅ ≥ 0` and the E-track certificate, which the record marks *single-author since
inception, never audited*, and whose output is the headline `c(12) ≈ 10⁻³`, so what would be
typed is a claim resting on an unchecked input.

**Nor is the identification of `J₄` with a Gram contraction.** What is proved below is the
mechanism at the level of abstraction at which it is true and complete: **a Gram matrix
contracted against a symmetric form is bounded by that form's largest eigenvalue times the Gram
trace.** That is the whole of *"`D ⪰ 0` free"* plus the trace bound, and it needs no curvature.
The two normalisation identities the record supplies,
`tr D = 6‖Alt(|W|)‖²` and `Alt(|W|) = 2 Alt(W₋)`, enter `pricing_bound` as explicit hypotheses,
**named as the record's own inputs rather than proved**, and the theorem's content is the
constant `24` that follows from them.

**Also not typed:** that `Alt(W) = 0` for a Weyl tensor, which is what makes
`Alt(|W|) = 2 Alt(W₋)` hold.
-/

namespace HamiltonsCubic.L18Statement

open Finset

/-! ## The Gram mechanism, in full

*`D_{ij} = 3/2 ⟨a_i, a_j⟩` makes `D ⪰ 0` free*, and the bound that follows is
`⟨D, Ric⟩ ≤ λ_max(Ric) · tr D`, with no positivity of `Ric` needed. -/

/-- **The Gram bound.** For vectors `a i` in `ℝ^d` and a form `R` whose quadratic form is bounded
above by `Λ` times the square norm (*which is exactly `λ_max(R) ≤ Λ` for symmetric `R`*), the
contraction of `R` against the Gram matrix of the `a i` is at most `Λ` times the Gram trace.

*The proof is one exchange of summation: expanding `⟨a_i, a_j⟩` in coordinates turns the
contraction into `∑_α` of `R` evaluated at the `α`-th coordinate vector, and the hypothesis
applies to each.* -/
theorem gram_bound {k d : ℕ} (a : Fin k → Fin d → ℝ) (R : Fin k → Fin k → ℝ) (Λ : ℝ)
    (hΛ : ∀ v : Fin k → ℝ, ∑ i, ∑ j, R i j * v i * v j ≤ Λ * ∑ i, v i ^ 2) :
    ∑ i, ∑ j, R i j * (∑ α, a i α * a j α) ≤ Λ * ∑ i, ∑ α, a i α ^ 2 := by
  have expand : ∀ i j : Fin k, R i j * (∑ α, a i α * a j α) = ∑ α, R i j * a i α * a j α := by
    intro i j
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun α _ => by ring
  calc ∑ i, ∑ j, R i j * (∑ α, a i α * a j α)
      = ∑ i, ∑ j, ∑ α, R i j * a i α * a j α :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => expand i j
    _ = ∑ i, ∑ α, ∑ j, R i j * a i α * a j α :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ α, ∑ i, ∑ j, R i j * a i α * a j α := Finset.sum_comm
    _ ≤ ∑ α, Λ * ∑ i, a i α ^ 2 := Finset.sum_le_sum fun α _ => hΛ fun i => a i α
    _ = Λ * ∑ α, ∑ i, a i α ^ 2 := by rw [Finset.mul_sum]
    _ = Λ * ∑ i, ∑ α, a i α ^ 2 := by rw [Finset.sum_comm]

/-- **`J₄` as the record's Gram contraction**, with the universal constant `3/2`. -/
noncomputable def J4 {k d : ℕ} (a : Fin k → Fin d → ℝ) (R : Fin k → Fin k → ℝ) : ℝ :=
  (3 / 2) * ∑ i, ∑ j, R i j * (∑ α, a i α * a j α)

/-- **`tr D = (3/2) ∑ ‖a_i‖²`**, the Gram trace. -/
noncomputable def trD {k d : ℕ} (a : Fin k → Fin d → ℝ) : ℝ :=
  (3 / 2) * ∑ i, ∑ α, a i α ^ 2

/-- **`J₄ ≤ λ_max · tr D`**, the pricing inequality before the normalisation is put in. -/
theorem J4_le_trD {k d : ℕ} (a : Fin k → Fin d → ℝ) (R : Fin k → Fin k → ℝ) (Λ : ℝ)
    (hΛ : ∀ v : Fin k → ℝ, ∑ i, ∑ j, R i j * v i * v j ≤ Λ * ∑ i, v i ^ 2) :
    J4 a R ≤ Λ * trD a := by
  have h := gram_bound a R Λ hΛ
  simp only [J4, trD]
  nlinarith [h]

/-- **THE PRICING HALF**: `J₄ ≤ 24 δ² λ_max(Ric(|W|))`.

The two hypotheses are the record's own normalisation inputs, and neither is this lemma's
conclusion: `htr` is *"`tr D = 3/2 · 4‖Alt‖² = 6‖Alt‖²`"* and `halt` is
*"`Alt(|W|) = 2 Alt(W₋)`, because `Alt(W) = 0`"*. **The content proved here is the constant `24`
that follows from them** (`6 · (2δ)² = 24δ²`), together with the Gram bound above. *No
criticality enters, contrary to the framing the block gave it.* -/
theorem pricing_bound {k d : ℕ} (a : Fin k → Fin d → ℝ) (R : Fin k → Fin k → ℝ) (Λ A δ : ℝ)
    (hΛ : ∀ v : Fin k → ℝ, ∑ i, ∑ j, R i j * v i * v j ≤ Λ * ∑ i, v i ^ 2)
    (htr : trD a = 6 * A ^ 2) (halt : A = 2 * δ) :
    J4 a R ≤ 24 * δ ^ 2 * Λ := by
  have h := J4_le_trD a R Λ hΛ
  rw [htr, halt] at h
  nlinarith [h]

/-! ## The chain penalty is the divided form, and the block quotes the numerator

`(J₄ − J₅)/√(1 − e²)`, which at Fox's `S⁴(α)` (where `√(1−e²) = 2/3` and `J₅ = 0`), is exactly
`3/2 · J₄`, **exceeding the block's quoted ceiling at its own equality point**. -/

/-- **The chain penalty at Fox's competitor is `3/2 · J₄`.** -/
theorem chain_penalty_at_fox (J4v : ℝ) : (J4v - 0) / (2 / 3) = (3 / 2) * J4v := by ring

/-! ## The three thresholds, strictly ordered

`θ̃₀` is Jäger's `S^m × S^{m+1}` value read as a formula in `n`; `θ₀` is the balanced value;
`θ̂₀(n) = ((n−2)/(n−3)) θ̃₀(n)` by definition. -/

/-- **`θ₀(n)² = 2(n−1)(n−2)/n²`.** -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- **`θ̃₀(n)² = 2(n−1)(n−3)/((n−2)(n+1))`**, the unbalanced-split value, which is `Θ_n` at odd
`n` and strictly below `θ₀(n)` at even `n`. -/
noncomputable def thetaTildeSq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1))

/-- **`θ̂₀(n)² = ((n−2)/(n−3))² θ̃₀(n)²`**, which is `2(n−1)(n−2)/((n−3)(n+1))`. -/
noncomputable def thetaHatSq (n : ℝ) : ℝ := ((n - 2) / (n - 3)) ^ 2 * thetaTildeSq n

/-- **`θ̂₀` in lowest terms.** -/
theorem thetaHatSq_eq (n : ℝ) (hn : 4 ≤ n) :
    thetaHatSq n = 2 * (n - 1) * (n - 2) / ((n - 3) * (n + 1)) := by
  have h3 : n - 3 ≠ 0 := by intro h; linarith
  have h2 : n - 2 ≠ 0 := by intro h; linarith
  have h1 : n + 1 ≠ 0 := by intro h; linarith
  simp only [thetaHatSq, thetaTildeSq]
  field_simp
  try ring

/-- **The separation, exactly**: `θ₀(n)² − θ̃₀(n)² = 8(n−1)/(n²(n+1)(n−2))`. *The inner
computation is `(n−2)²(n+1) − n²(n−3) = 4`.* -/
theorem separation (n : ℝ) (hn : 4 ≤ n) :
    theta0Sq n - thetaTildeSq n = 8 * (n - 1) / (n ^ 2 * (n + 1) * (n - 2)) := by
  have h0 : n ≠ 0 := by intro h; linarith
  have h2 : n - 2 ≠ 0 := by intro h; linarith
  have h1 : n + 1 ≠ 0 := by intro h; linarith
  simp only [theta0Sq, thetaTildeSq]
  field_simp
  try ring

/-- **And it is strictly positive**, so `θ̃₀ < θ₀` at every `n ≥ 4`. -/
theorem tilde_lt_zero (n : ℝ) (hn : 4 ≤ n) : thetaTildeSq n < theta0Sq n := by
  have hd : (0:ℝ) < n ^ 2 * (n + 1) * (n - 2) := by
    have h1 : (0:ℝ) < n ^ 2 := by nlinarith
    have h2 : (0:ℝ) < n + 1 := by linarith
    have h3 : (0:ℝ) < n - 2 := by linarith
    exact mul_pos (mul_pos h1 h2) h3
  have hpos : 0 < 8 * (n - 1) / (n ^ 2 * (n + 1) * (n - 2)) := div_pos (by linarith) hd
  linarith [separation n hn]

/-- **And `θ₀ < θ̂₀`**, since `(n−3)(n+1) = n² − 2n − 3 < n²`. -/
theorem zero_lt_hat (n : ℝ) (hn : 4 ≤ n) : theta0Sq n < thetaHatSq n := by
  rw [thetaHatSq_eq n hn]
  have hnum : 0 < 2 * (n - 1) * (n - 2) := by nlinarith
  have hd1 : (0:ℝ) < n ^ 2 := by nlinarith
  have hd2 : (0:ℝ) < (n - 3) * (n + 1) := by nlinarith
  simp only [theta0Sq]
  rw [div_lt_div_iff₀ hd1 hd2]
  nlinarith

/-- **The three squares at `n = 12`**: `99/65 < 55/36 < 220/117`. *The middle one is `θ₀(12)²`,
and the number `c(12) ≈ 1.0 × 10⁻³` exists only because the first two differ there.* -/
theorem three_at_twelve :
    thetaTildeSq 12 = 99 / 65 ∧ theta0Sq 12 = 55 / 36 ∧ thetaHatSq 12 = 220 / 117 ∧
    (99:ℝ) / 65 < 55 / 36 ∧ (55:ℝ) / 36 < 220 / 117 := by
  refine ⟨by norm_num [thetaTildeSq], by norm_num [theta0Sq], ?_, by norm_num, by norm_num⟩
  rw [thetaHatSq_eq 12 (by norm_num)]; norm_num

/-- **At odd `n` the first two agree**, which is why `θ̃₀(13)` matches `Θ₁₃`, *the identification
holds at odd `n` only, and `13` is odd*. -/
theorem tilde_is_odd_theta : thetaTildeSq 13 = 240 / 154 := by norm_num [thetaTildeSq]

/-! ## The window the closing bound must fit into

*The rival maximizer forces any closing bound into a window of width `0.011` at `n = 12`*, and
that width is `θ₀(12) − √(3/2)`, which is also the denominator [L13](../../../findings/curvature-invariants.md)
divides by, so the two blocks turn on one number. -/

/-- **`θ₀(12) − √(3/2)` lies strictly between `0.0112` and `0.0113`.** *`θ₀(12) = √55/6` and
`√(3/2) = √6/2`.* -/
theorem window_width :
    0.0112 < Real.sqrt 55 / 6 - Real.sqrt 6 / 2 ∧ Real.sqrt 55 / 6 - Real.sqrt 6 / 2 < 0.0113 := by
  have h55 : Real.sqrt 55 ^ 2 = 55 := Real.sq_sqrt (by norm_num)
  have h55n : (0:ℝ) ≤ Real.sqrt 55 := Real.sqrt_nonneg _
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h6n : (0:ℝ) ≤ Real.sqrt 6 := Real.sqrt_nonneg _
  have a1 : (7.41619:ℝ) < Real.sqrt 55 := by nlinarith
  have a2 : Real.sqrt 55 < 7.4162 := by nlinarith
  have b1 : (2.449489:ℝ) < Real.sqrt 6 := by nlinarith
  have b2 : Real.sqrt 6 < 2.44949 := by nlinarith
  constructor <;> [linarith; linarith]

/-- **And `θ₀(12) = √55/6`**, so the display above is the record's own quantity. -/
theorem theta0_twelve : theta0Sq 12 = (Real.sqrt 55 / 6) ^ 2 := by
  have h55 : Real.sqrt 55 ^ 2 = 55 := Real.sq_sqrt (by norm_num)
  simp only [theta0Sq]
  rw [div_pow, h55]
  norm_num

/-! ## Non-vacuity

The Gram bound's hypothesis is satisfiable, and non-trivially: the zero form has `Λ = 0`, and a
positive multiple of the identity has `Λ` its own scale. -/

/-- **A witness for `hΛ`**: `R = Λ · Id` satisfies the bound with equality. -/
example (k : ℕ) (Λ : ℝ) :
    ∀ v : Fin k → ℝ, ∑ i, ∑ j, (if i = j then Λ else 0) * v i * v j ≤ Λ * ∑ i, v i ^ 2 := by
  intro v
  have : ∀ i : Fin k, ∑ j, (if i = j then Λ else 0) * v i * v j = Λ * v i ^ 2 := by
    intro i
    rw [Finset.sum_eq_single i]
    · simp; ring
    · intro j _ hj
      have : ¬ (i = j) := fun h => hj h.symm
      simp [this]
    · intro h; exact absurd (Finset.mem_univ i) h
  rw [Finset.sum_congr rfl fun i _ => this i, Finset.mul_sum]

end HamiltonsCubic.L18Statement
