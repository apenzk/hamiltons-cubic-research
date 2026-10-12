import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

/-!
# L133, the balanced-orbit stability threshold in closed form, and it clears `κₙ` for every `n ≥ 12`

## The record's statement, verbatim

> #### Lemma L133, the balanced-orbit stability threshold in closed form, and it clears $\kappa_n$ for every $n\ge12$
>
> **Setting.** $n=2m\ge12$; $W^*$ the unit-norm Weyl tensor of $S^m\times S^m$, a pure critical
> point with $\theta=P(W^*)=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$; $e=W^*/\theta_0$;
> $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ the defect of Conjecture L16, $W_-$ the negative
> spectral part of $W$ as an operator on $\Lambda^2$. Write $\mathcal O=SO(n)\cdot W^*$ and define
> the **balanced-orbit threshold**
> $$\kappa_n^{\mathrm{Hess}}:=\sup\left\{\frac{\tfrac12\,\mathrm{Hess}(P|_S)_{W^*}[H,H]}{\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2}:H\in T_{W^*}S,\ D(\mathrm{Alt}\,W_-)_{W^*}[H]\neq0\right\},$$
> the second-order rate at which $P-\theta_0$ can be bought against $\delta^2$ on approach to
> $\mathcal O$.
>
> **Statement.**
> $$\boxed{\ \kappa_n^{\mathrm{Hess}}\;=\;\frac{27}{2}\,\theta_0(n)\left(\frac{2}{n-2}-\frac12\right)\ }$$
> **the supremum being over directions with $D(\mathrm{Alt}\,W_-)_{W^*}[H]\neq0$**, and attained on
> Lemma L26's direction inside **every** $(2,2)$-split four-subset, the maximiser set is the span
> of those $\binom m2^2$ directions, not one of them, and
> $$\kappa_n^{\mathrm{Hess}}\;\le\;\kappa_n=9\big(\sqrt{3/2}-\theta_0(n)\big)\qquad\text{for every }n\ge12,$$
> strictly, by a factor of $49.3$ at $n=12$ **decreasing monotonically** to the infimum $5.598$ as
> $n\to\infty$. **So Conjecture L16 is not refuted at its own conjectured maximiser, and the
> balanced orbit is not where its constant is decided.**
>
> **Step 4, the sup, and it is one direction.** [...] There, writing
> $H=\alpha(2,-1,-1)+\beta(0,1,-1)$, the whole of $\mathbf 1^\perp$,
> $$\frac{\tfrac12\mathrm{Hess}[H,H]}{\lVert\mathrm{Alt}\,DW_-[H]\rVert^2}=\frac{3\theta_0\gamma\big[(\mu-\tfrac12)6\alpha^2-(\mu+\tfrac12)2\beta^2\big]}{\tfrac\gamma3\,4\alpha^2},$$
> maximised at $\beta=0$, where it equals $\frac{18\theta_0(\mu-\tfrac12)}{4/3}=\frac{27}2\theta_0\big(\mu-\tfrac12\big)$. **The weight $\gamma$ cancels**, so no normalisation convention enters
> the answer. Substituting $\mu=\tfrac2{n-2}$ gives the boxed formula.
>
> **Step 5, the comparison with $\kappa_n$, in one line.** $\kappa_n^{\mathrm{Hess}}\le\kappa_n$
> reads $\tfrac32\theta_0\big(\tfrac2{n-2}-\tfrac12\big)\le\sqrt{3/2}-\theta_0$, i.e.
> $$\theta_0(n)\left(\frac3{n-2}+\frac14\right)\;\le\;\sqrt{3/2}.$$
> The bracket decreases in $n$, so at $n\ge12$ it is at most $\tfrac3{10}+\tfrac14=0.55$; and
> $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n<\sqrt2$ for every $n$, since $(n-1)(n-2)<n^2$. Hence the left
> side is below $0.55\sqrt2=0.778<1.2247=\sqrt{3/2}$. $\square$
>
> **An independent consistency check of the formula.** At $n=6$ it returns $\mu=\tfrac12$ and
> $\kappa^{\mathrm{Hess}}=0$, and $n=6$ is exactly where the record reports
> $\dim E(\tfrac12)=18$ at $S^3\times S^3$, the threshold vanishes precisely where the block
> becomes degenerate.

[second-order.md](../../../findings/second-order.md), Lemma L133.

## What this file states

**Everything the lemma asserts once `κ^Hess` is given by its closed form, PROVED over `ℝ` with the
real square root, no `sorry`:**

- `comparison`: `κ^Hess_n < κ_n` for **every** `n ≥ 12`, and strictly, the lemma's headline;
- `reduction`: that comparison is *equivalent* to Step 5's one line `θ₀(n)(3/(n−2) + 1/4) < √(3/2)`,
  proved as an identity so the reduction is exact rather than merely sufficient;
- `theta0_lt_sqrt_two` and the bracket bound `3/(n−2) + 1/4 ≤ 11/20`, the two inputs Step 5 uses;
- `kappaHess_neg` and `kappa_neg`: **both constants are negative at every `n ≥ 12`**, which the
  record's "strictly" leaves unsaid and which is what makes "by a factor of" a ratio of two
  negative numbers;
- `block_ratio_le` and `block_ratio_at_zero`: Step 4's per-block maximisation, that the displayed
  ratio is `≤ (27/2)θ₀(μ − ½)` with equality at `β = 0`, and (the point the record makes) that
  **the weight `γ` cancels**, so no normalisation convention enters;
- `mu_balanced`: `μ_{m,m} = (n−2)/(2(m−1)²) = 2/(n−2)` at `n = 2m`, the substitution that turns
  Step 4's value into the boxed formula;
- `consistency_at_six`: at `n = 6` the formula returns `μ = ½` and `κ^Hess = 0`;
- `factor_at_twelve` and `factor_at_infinity`: the two ends of the record's "factor of 49.3 …
  to 5.598", bracketed as `49 < κ^Hess/κ < 50` at `n = 12` and `5.59 < · < 5.60` in the limit.

The comparison is stated at `n : ℕ` with `12 ≤ n` and evaluated over `ℝ`, so `n − 2` is an ordinary
difference.

## What is NOT typed here

- **That `κ^Hess_n` IS that supremum.** The definition quantifies over `Hess(P|_S)_{W^*}`,
  `Alt`, `W_-` and `D(Alt W_-)`, none of which the `RealLayer` carries, `Alt` and the negative
  spectral part are named in the brief's list of unnameable objects. So `kappaHess` here is the
  record's closed form, and Steps 1–3, the spectral data of `W^*`, `Alt(W^*_-) = 0`, the
  Daleckii–Krein support table putting the defect response on the `(2,2)`-splits alone, and L27's
  `λ_max(L_e) = ½` attained only on the orbit, are absent. `block_ratio_le` types the *algebra* of
  Step 4 given that reduction, not the reduction.
- **The maximiser set**, "the span of the `C(m,2)²` `(2,2)`-split directions", for the same reason.
- **The monotone decrease of the factor in `n`.** Only its two endpoints are bracketed; that the
  ratio decreases from `49.3` to `5.598` is not proved here.
- **The consequence for Conjecture L16.** That the conjecture "is not refuted at its own conjectured
  maximiser" is a statement about `ProblemP` and the defect, which needs the objects above.
-/

namespace HamiltonsCubic.L133Statement

/-! ## The two constants -/

/-- `θ₀(n) = √(2(n−1)(n−2))/n`, the balanced sphere product's value. -/
noncomputable def theta0 (n : ℕ) : ℝ := Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n

/-- **The balanced-orbit threshold, in the record's closed form**
`κ^Hess_n = (27/2) θ₀(n) (2/(n−2) − ½)`. -/
noncomputable def kappaHess (n : ℕ) : ℝ := (27 / 2) * theta0 n * (2 / ((n : ℝ) - 2) - 1 / 2)

/-- `κₙ = 9(√(3/2) − θ₀(n))`, the record's stability constant. -/
noncomputable def kappa (n : ℕ) : ℝ := 9 * (Real.sqrt (3 / 2) - theta0 n)

/-! ## `θ₀` -/

theorem theta0_nonneg (n : ℕ) : 0 ≤ theta0 n := by
  unfold theta0
  positivity

/-- **`θ₀(n) < √2` for every `n`**, since `(n−1)(n−2) < n²`. Step 5's second input. -/
theorem theta0_lt_sqrt_two (n : ℕ) (hn : 12 ≤ n) : theta0 n < Real.sqrt 2 := by
  have hn' : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hnpos : (0 : ℝ) < (n : ℝ) := by linarith
  have hs : Real.sqrt 2 * (n : ℝ) = Real.sqrt (2 * (n : ℝ) ^ 2) := by
    rw [Real.sqrt_mul (by norm_num), Real.sqrt_sq (le_of_lt hnpos)]
  have h1 : Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) < Real.sqrt 2 * (n : ℝ) := by
    rw [hs]
    exact Real.sqrt_lt_sqrt (by nlinarith) (by nlinarith)
  unfold theta0
  rw [div_lt_iff₀ hnpos]
  exact h1

/-- **`θ₀(n) > √(3/2)` at every `n ≥ 12`**, since `4(n−1)(n−2) > 3n²` there. This is what puts the
balanced product above the band's floor, and it is what makes `κₙ` negative. -/
theorem sqrt_three_halves_lt_theta0 (n : ℕ) (hn : 12 ≤ n) : Real.sqrt (3 / 2) < theta0 n := by
  have hn' : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hnpos : (0 : ℝ) < (n : ℝ) := by linarith
  have hs : Real.sqrt (3 / 2) * (n : ℝ) = Real.sqrt (3 / 2 * (n : ℝ) ^ 2) := by
    rw [Real.sqrt_mul (by norm_num), Real.sqrt_sq (le_of_lt hnpos)]
  have h1 : Real.sqrt (3 / 2) * (n : ℝ) < Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) := by
    rw [hs]
    exact Real.sqrt_lt_sqrt (by nlinarith) (by nlinarith)
  unfold theta0
  rw [lt_div_iff₀ hnpos]
  exact h1

/-! ## Both constants are negative -/

/-- `κ^Hess_n < 0` at every `n ≥ 12`: `2/(n−2) < ½` above `n = 6`, and `θ₀ > 0`. -/
theorem kappaHess_neg (n : ℕ) (hn : 12 ≤ n) : kappaHess n < 0 := by
  have hn' : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hd : (10 : ℝ) ≤ (n : ℝ) - 2 := by linarith
  have hpos : 0 < theta0 n := lt_of_le_of_lt (Real.sqrt_nonneg _) (sqrt_three_halves_lt_theta0 n hn)
  have hbr : 2 / ((n : ℝ) - 2) - 1 / 2 < 0 := by
    have : 2 / ((n : ℝ) - 2) ≤ 2 / 10 := by
      apply div_le_div_of_nonneg_left (by norm_num) (by norm_num) hd
    linarith
  unfold kappaHess
  nlinarith

/-- `κₙ < 0` at every `n ≥ 12`, because `θ₀(n) > √(3/2)` there. -/
theorem kappa_neg (n : ℕ) (hn : 12 ≤ n) : kappa n < 0 := by
  have := sqrt_three_halves_lt_theta0 n hn
  unfold kappa
  linarith

/-! ## Step 5, the reduction, and it is exact -/

/-- **The comparison reduces exactly to `θ₀(n)(3/(n−2) + ¼) < √(3/2)`.** *Stated as a
biconditional, so the reduction loses nothing.* -/
theorem reduction (n : ℕ) (hn : 12 ≤ n) :
    kappaHess n < kappa n ↔ theta0 n * (3 / ((n : ℝ) - 2) + 1 / 4) < Real.sqrt (3 / 2) := by
  have key : kappa n - kappaHess n
      = 9 * (Real.sqrt (3 / 2) - theta0 n * (3 / ((n : ℝ) - 2) + 1 / 4)) := by
    unfold kappa kappaHess
    ring
  constructor <;> intro h <;> linarith

/-- `√2 · (11/20) < √(3/2)`, the numeral Step 5 finishes on. -/
theorem sqrt_two_bracket : Real.sqrt 2 * (11 / 20) < Real.sqrt (3 / 2) := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h3 : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have hn2 : (0 : ℝ) ≤ Real.sqrt 2 := Real.sqrt_nonneg 2
  have hn3 : (0 : ℝ) ≤ Real.sqrt (3 / 2) := Real.sqrt_nonneg _
  nlinarith [h2, h3, hn2, hn3]

/-- **THE LEMMA'S HEADLINE: `κ^Hess_n < κₙ` for every `n ≥ 12`, strictly.** -/
theorem comparison (n : ℕ) (hn : 12 ≤ n) : kappaHess n < kappa n := by
  rw [reduction n hn]
  have hn' : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hd : (10 : ℝ) ≤ (n : ℝ) - 2 := by linarith
  have hbr : 3 / ((n : ℝ) - 2) + 1 / 4 ≤ 11 / 20 := by
    have : 3 / ((n : ℝ) - 2) ≤ 3 / 10 := by
      apply div_le_div_of_nonneg_left (by norm_num) (by norm_num) hd
    linarith
  have hbr0 : (0 : ℝ) < 3 / ((n : ℝ) - 2) + 1 / 4 := by positivity
  have ht := theta0_lt_sqrt_two n hn
  have ht0 := theta0_nonneg n
  calc theta0 n * (3 / ((n : ℝ) - 2) + 1 / 4)
      ≤ theta0 n * (11 / 20) := by nlinarith
    _ ≤ Real.sqrt 2 * (11 / 20) := by nlinarith
    _ < Real.sqrt (3 / 2) := sqrt_two_bracket

/-! ## Step 4, the per-block maximisation, and `γ` cancels -/

/-- **At `β = 0` the block ratio is `(27/2)θ₀(μ − ½)`, and the weight `γ` has cancelled**, so no
normalisation convention enters the answer. -/
theorem block_ratio_at_zero (t μ γ α : ℝ) (hγ : γ ≠ 0) (hα : α ≠ 0) :
    (3 * t * γ * ((μ - 1 / 2) * 6 * α ^ 2 - (μ + 1 / 2) * 2 * 0 ^ 2)) / (γ / 3 * 4 * α ^ 2)
      = 27 / 2 * t * (μ - 1 / 2) := by
  have hα2 : α ^ 2 ≠ 0 := pow_ne_zero 2 hα
  field_simp
  ring

/-- **The block ratio is maximised at `β = 0`.** With `θ₀ ≥ 0` and `μ + ½ ≥ 0` the `β` term only
subtracts, so the displayed ratio never exceeds `(27/2)θ₀(μ − ½)`. -/
theorem block_ratio_le (t μ γ α β : ℝ) (hγ : 0 < γ) (hα : α ≠ 0) (ht : 0 ≤ t)
    (hμ : 0 ≤ μ + 1 / 2) :
    (3 * t * γ * ((μ - 1 / 2) * 6 * α ^ 2 - (μ + 1 / 2) * 2 * β ^ 2)) / (γ / 3 * 4 * α ^ 2)
      ≤ 27 / 2 * t * (μ - 1 / 2) := by
  have hα2 : (0 : ℝ) < α ^ 2 := by positivity
  have hden : (0 : ℝ) < γ / 3 * 4 * α ^ 2 := by positivity
  rw [div_le_iff₀ hden]
  nlinarith [sq_nonneg β, mul_nonneg ht hμ, sq_nonneg (β * γ)]

/-- **`μ_{m,m} = (n−2)/(2(m−1)²) = 2/(n−2)` at `n = 2m`**, the substitution that turns Step 4's
value into the boxed formula. -/
theorem mu_balanced (m : ℕ) (hm : 2 ≤ m) :
    (2 * (m : ℝ) - 2) / (2 * ((m : ℝ) - 1) ^ 2) = 2 / (2 * (m : ℝ) - 2) := by
  have hm' : (2 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have h1 : (m : ℝ) - 1 ≠ 0 := by intro h; linarith [h]
  field_simp

/-! ## The consistency check at `n = 6` -/

/-- At `n = 6` the four-set value is `½` and the threshold vanishes: `κ^Hess₆ = 0`. *The threshold
vanishes precisely where the block becomes degenerate, which no step of the derivation was arranged
to produce.* -/
theorem consistency_at_six : (2 : ℝ) / ((6 : ℕ) - 2) = 1 / 2 ∧ kappaHess 6 = 0 := by
  constructor
  · norm_num
  · unfold kappaHess
    norm_num

/-! ## The two ends of the record's "factor of 49.3 … to 5.598" -/

theorem theta0_twelve : theta0 12 = Real.sqrt 220 / 12 := by
  unfold theta0
  norm_num

private theorem sqrt220_lb : (14.83239 : ℝ) < Real.sqrt 220 := by
  nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 220), Real.sqrt_nonneg 220]

private theorem sqrt220_ub : Real.sqrt 220 < 14.83240 := by
  nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 220), Real.sqrt_nonneg 220]

private theorem sqrt15_lb : (1.224744 : ℝ) < Real.sqrt (3 / 2) := by
  nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 3 / 2), Real.sqrt_nonneg (3 / 2)]

private theorem sqrt15_ub : Real.sqrt (3 / 2) < 1.224745 := by
  nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 3 / 2), Real.sqrt_nonneg (3 / 2)]

private theorem sqrt2_lb : (1.4142135 : ℝ) < Real.sqrt 2 := by
  nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2), Real.sqrt_nonneg 2]

private theorem sqrt2_ub : Real.sqrt 2 < 1.4142136 := by
  nlinarith [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2), Real.sqrt_nonneg 2]

/-- **At `n = 12` the factor is between `49` and `50`**, the record's `49.3`. Both constants are
negative, so `κ^Hess < 49κ` and `50κ < κ^Hess` bracket the ratio `κ^Hess/κ` from below and above. -/
theorem factor_at_twelve : kappaHess 12 < 49 * kappa 12 ∧ 50 * kappa 12 < kappaHess 12 := by
  have hk : kappaHess 12 = -(27 / 80) * Real.sqrt 220 := by
    unfold kappaHess
    rw [theta0_twelve]
    norm_num
    ring
  have hka : kappa 12 = 9 * Real.sqrt (3 / 2) - (3 / 4) * Real.sqrt 220 := by
    unfold kappa
    rw [theta0_twelve]
    ring
  rw [hk, hka]
  exact ⟨by linarith [sqrt220_ub, sqrt15_lb], by linarith [sqrt220_lb, sqrt15_ub]⟩

/-- The limiting constants, `μ → 0` and `θ₀ → √2`. -/
noncomputable def kappaHessInf : ℝ := -(27 / 4) * Real.sqrt 2

/-- `κ_∞ = 9(√(3/2) − √2)`. -/
noncomputable def kappaInf : ℝ := 9 * (Real.sqrt (3 / 2) - Real.sqrt 2)

/-- **In the limit the factor is between `5.59` and `5.60`**, the record's infimum `5.598`. -/
theorem factor_at_infinity :
    kappaHessInf < 5.59 * kappaInf ∧ 5.60 * kappaInf < kappaHessInf := by
  unfold kappaHessInf kappaInf
  exact ⟨by linarith [sqrt2_ub, sqrt15_lb], by linarith [sqrt2_lb, sqrt15_ub]⟩

/-! ## A witness, so the hypotheses are not empty

*`n = 12` satisfies `12 ≤ n`, so `comparison` is not vacuous; and `γ = 1`, `α = 1` satisfy Step 4's
side conditions.* -/

example : kappaHess 12 < kappa 12 := comparison 12 (by norm_num)

example (t μ : ℝ) (ht : 0 ≤ t) (hμ : 0 ≤ μ + 1 / 2) :
    (3 * t * 1 * ((μ - 1 / 2) * 6 * (1 : ℝ) ^ 2 - (μ + 1 / 2) * 2 * (1 : ℝ) ^ 2))
        / ((1 : ℝ) / 3 * 4 * (1 : ℝ) ^ 2)
      ≤ 27 / 2 * t * (μ - 1 / 2) :=
  block_ratio_le t μ 1 1 1 (by norm_num) (by norm_num) ht hμ

end HamiltonsCubic.L133Statement
