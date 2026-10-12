import Mathlib

set_option linter.style.longLine false

/-!
# L165, the frontier requirement in closed form

## The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md)

> #### Lemma L165, the frontier requirement in closed form: its cubic piece holds at every $n$ and both parities, and no single constant carries the other piece

> Put $\sigma^2=1-3\alpha$ […] with $c=\cos\beta=\sqrt{1-\sigma^2}$ and $t=\sigma/c$. **The
> requirement's right side is then exact rather than estimated**:
> $3-5\alpha=3-\tfrac53(1-\sigma^2)=\tfrac13(4+5\sigma^2)$. Multiplying
> $\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}$ through by $\sqrt{3/2}$ turns it into
> $$H_\theta(\sigma):=\frac{4+5\sigma^2}{3\sqrt2}-3c^2\sigma\,V(t)-\theta\,\sigma^3>0,
> \qquad\sigma\in[0,1],$$
> where $\theta$ is the block's constant. **The branch point transcribes exactly**:
> $t^*=\sqrt{30}/8$ gives $\sigma^{*2}=t^{*2}/(1+t^{*2})=15/47$, hence
> $\alpha^*=\tfrac13(1-\tfrac{15}{47})=\tfrac{32}{141}$.

> **Two pieces, and only the first is a cubic.**
> $$3c^2\sigma\,V(t)=\begin{cases}\dfrac{\sqrt{30}}2\,\sigma(1-\sigma^2), & \sigma\le\sigma^*,\\[8pt]
> \dfrac{\sqrt{1-\sigma^2}\,(15+17\sigma^2)}{16}, & \sigma\ge\sigma^*.\end{cases}$$

> **(a) The cubic piece holds at every $n$, at both parities.** Multiplying by $3\sqrt2$ on
> $\sigma\le\sigma^*$,
> $$3\sqrt2\,H_\theta(\sigma)=\Psi_\theta(\sigma):=\big(3\sqrt{15}-3\sqrt2\,\theta\big)\sigma^3
> +5\sigma^2-3\sqrt{15}\,\sigma+4 .$$
> The $\sigma^3$ coefficient decreases in $\theta$ and $\sigma^3\ge0$, so $\Psi_\theta\ge\Psi_{\sqrt2}$
> whenever $\theta\le\sqrt2$, **which both parities satisfy strictly**:
> $\theta_0(n)^2=2-\frac{2(3n-2)}{n^2}<2$, and the odd formula has $\tilde\theta_0(n)^2<2$ because
> $(n-1)(n-3)-(n+1)(n-2)=5-3n<0$ for $n\ge2$. At $\theta=\sqrt2$ the cubic is
> $\Psi_{\sqrt2}(\sigma)=(3\sqrt{15}-6)\sigma^3+5\sigma^2-3\sqrt{15}\,\sigma+4$, whose discriminant is
> $$\Delta=18abcd-4b^3d+b^2c^2-4ac^3-27a^2d^2=12312\sqrt{15}-48197<0,$$
> since $15\cdot12312^2=2{,}273{,}780{,}160<2{,}322{,}950{,}809=48197^2$. **One real root, then**;
> the leading coefficient $3(\sqrt{15}-2)$ is positive and $\Psi_{\sqrt2}(0)=4>0$, so that root is
> negative and $\Psi_{\sqrt2}>0$ on the whole of $\sigma\ge0$. Hence $H_\theta>0$ on $[0,\sigma^*]$:
> **the requirement holds for every $\alpha\in[\tfrac{32}{141},\tfrac13)$, at every $n$ and both
> parities.**

> **(b) No single constant carries the piece below $\alpha^*$, and $\sigma=\tfrac34$ says so in
> closed form.** There $c=\sqrt7/4$ and
> $$H_\theta(\tfrac34)=\frac{109\sqrt2}{96}-\frac{393\sqrt7}{1024}-\frac{27}{64}\theta,$$
> so the requirement at $\alpha=\tfrac7{48}$ holds exactly when
> $$\theta<\Theta_{3/4}:=\frac{218\sqrt2}{81}-\frac{131\sqrt7}{144}=1.39925\ldots<\sqrt2 .$$
> **Since the constant increases to $\sqrt2$, $\theta_0(n)$ at even $n$, $\tilde\theta_0(n)$ at odd
>, it crosses $\Theta_{3/4}$, at $n\ge142$ for even $n$ and $n\ge143$ for odd.**

> **AND THE CUBIC PIECE'S OWN CRITICAL CONSTANT IS CLOSED** […] *The binding point on
> $[0,\sigma^*]$ is the endpoint, so the piece survives every constant below*
> $$\theta_{\mathrm{crit}}=\frac{263\sqrt{1410}-1440\sqrt{30}}{1350}=1.472899\ldots,$$
> **which is $4.1509\%$ above $\sqrt2$**.

> **THE MARGIN IS THIN AND THAT IS WHY THE DISCRIMINANT IS THE ARGUMENT.** *$3\sqrt2H_{\sqrt2}$ has
> its free minimum $0.0389\ldots$ at $\sigma=0.5850\ldots$, just OUTSIDE $[0,\sigma^*]$.*

> **AND THE CONCLUSION IS ABOUT THE BOUND AT ITS RECORDED CONSTANT, NOT ABOUT THE REQUIREMENT.**
> *The block carries $\theta\le\theta_0(n)$, while the crossing argument substitutes
> $\theta=\theta_0(n)$, and $H_\theta$ decreases in $\theta$, so the substitution runs the wrong
> way.*

## What is typed here

* `right_side_exact`, the change of variable: `3 - 5α = (4+5σ²)/3` at `α = (1-σ²)/3`.
* `branch_point_transcribes`, `t* = √30/8` gives `σ*² = 15/47` and `α* = 32/141`, exactly.
* `Psi_eq`, `3√2·H_low θ σ = Ψ_θ(σ)`, so the record's `Ψ` is the record's `H` rescaled.
* `Psi_discriminant`, `Psi_discriminant_neg`, the cubic discriminant is `12312√15 - 48197`, and it
  is negative because `15·12312² < 48197²`.
* `Psi_sqrt2_pos`, **`Ψ_{√2}(σ) > 0` for every `σ ≥ 0`**, by an exact positivity certificate
  (`Ψ = (3√15-6)·σ(σ-½)² + (3√15-1)σ² - ((15√15-6)/4)σ + 4`, the residual quadratic having
  discriminant `(3667 - 948√15)/16 < 0`).
* `Psi_mono_theta`, `cubic_piece_holds`, `Ψ_θ ≥ Ψ_{√2}` when `θ ≤ √2`, hence `H_θ > 0` on the
  cubic piece at every `θ ≤ √2`.
* `theta0_lt_sqrt_two`, `thetaTilde0_lt_sqrt_two`, both parities satisfy `θ ≤ √2` strictly.
* `H_at_three_quarters`, `requirement_at_three_quarters`, `Theta34_bracket`, `Theta34_lt_sqrt_two`,
  the closed form at `σ = 3/4` and the constant `Θ_{3/4} = 1.39925…`.
* `crossing_even`, `θ₀(140) < Θ_{3/4} < θ₀(142)`, which is the record's `n ≥ 142`.
* `H_decreasing_in_theta`, `substitution_runs_the_right_way`, the Gate-2 correction: `H` decreases
  in `θ`, so `θ ≤ θ₀` and `H_{θ₀} > 0` give `H_θ > 0`, while `H_θ ≤ 0` does **not** follow from
  `H_{θ₀} ≤ 0`.
* `theta_crit_bracket`, `theta_crit_percent`, the cubic piece's own critical constant in closed
  form, `1.47291 < θ_crit < 1.47292`, which is between `4.15%` and `4.16%` above `√2`. *The record
  writes this constant's decimal as `1.472899…`, while its own closed form
  `(263√1410 - 1440√30)/1350` evaluates to `1.4729158…`; the bracket here is the closed form's.
  The record's `4.1509%` matches the closed form, so the decimal is the outlier.*
* `free_minimum_outside_interval`, the free minimiser `0.5850` lies outside `[0, σ*]`, which is why
  the endpoint binds.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**`V(t)`, `γ_max(α)` and the frontier requirement they come from are not defined.** They live on
`ker F_u` with `W₁`, `Q` and `M_{W₁}`, the curvature layer this record has not built in Lean.
`H_low` and `H_high` below are *definitions transcribed from the block*, and what is proved is the
algebra and analysis of those two explicit real functions. In particular **the derivation of the
two-piece display for `3c²σV(t)` is not typed**, nor is the record's own inherited debt: `c₀ = 1`,
`λ = 2/3`, `M_{W₁}Π_ker Q(W₁) = 0`, `θ ≤ Θₙ` (which is Conjecture A restricted to `ker F_u`), and
`P(W₁) = 0` on `V_{1/3}`. The record lists all five as owed.

**Clause (b)'s conclusion is typed as an arithmetic crossing, not as a fence.** `crossing_even`
says `Θ_{3/4}` lies between `θ₀(140)` and `θ₀(142)`; that no *single* constant valid at every `n`
carries the piece below `α*` is the record's reading of that crossing, and reading is not typing.
-/

namespace HamiltonsCubic.L165Statement

/-! ## The change of variable -/

/-- **The requirement's right side is exact**: with `α = (1-σ²)/3`, `3 - 5α = (4+5σ²)/3`. -/
theorem right_side_exact (σ : ℝ) : 3 - 5 * ((1 - σ ^ 2) / 3) = (4 + 5 * σ ^ 2) / 3 := by ring

/-- **The branch point transcribes exactly.** `t* = √30/8` gives `t*² = 15/32`,
`σ*² = t*²/(1+t*²) = 15/47`, and `α* = (1 - σ*²)/3 = 32/141`. -/
theorem branch_point_transcribes :
    (Real.sqrt 30 / 8) ^ 2 = 15 / 32 ∧
      (15 / 32 : ℝ) / (1 + 15 / 32) = 15 / 47 ∧
      (1 - (15 : ℝ) / 47) / 3 = 32 / 141 := by
  refine ⟨?_, by norm_num, by norm_num⟩
  rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 30)]; norm_num

/-! ## The two pieces of `H` -/

/-- The cubic piece, `σ ≤ σ*`. -/
noncomputable def Hlow (θ σ : ℝ) : ℝ :=
  (4 + 5 * σ ^ 2) / (3 * Real.sqrt 2) - Real.sqrt 30 / 2 * (σ * (1 - σ ^ 2)) - θ * σ ^ 3

/-- The frontier piece, `σ ≥ σ*`. -/
noncomputable def Hhigh (θ σ : ℝ) : ℝ :=
  (4 + 5 * σ ^ 2) / (3 * Real.sqrt 2) - Real.sqrt (1 - σ ^ 2) * (15 + 17 * σ ^ 2) / 16 - θ * σ ^ 3

/-- The record's `Ψ_θ`. -/
noncomputable def Psi (θ σ : ℝ) : ℝ :=
  (3 * Real.sqrt 15 - 3 * Real.sqrt 2 * θ) * σ ^ 3 + 5 * σ ^ 2 - 3 * Real.sqrt 15 * σ + 4

private theorem sqrt2_mul_sqrt30 : Real.sqrt 2 * Real.sqrt 30 = 2 * Real.sqrt 15 := by
  rw [← Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 2), show (2:ℝ) * 30 = 2 ^ 2 * 15 by norm_num,
    Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 2)]

/-- **`3√2·H_low = Ψ`.** -/
theorem Psi_eq (θ σ : ℝ) : 3 * Real.sqrt 2 * Hlow θ σ = Psi θ σ := by
  have h2 : Real.sqrt 2 ≠ 0 := by positivity
  have h2sq : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hA : 3 * Real.sqrt 2 * ((4 + 5 * σ ^ 2) / (3 * Real.sqrt 2)) = 4 + 5 * σ ^ 2 := by
    field_simp
  have hB : 3 * Real.sqrt 2 * (Real.sqrt 30 / 2 * (σ * (1 - σ ^ 2)))
      = 3 * Real.sqrt 15 * (σ * (1 - σ ^ 2)) := by
    linear_combination (3 * (σ * (1 - σ ^ 2)) / 2) * sqrt2_mul_sqrt30
  simp only [Hlow, Psi]
  linear_combination hA - hB

/-! ## The discriminant -/

/-- **The discriminant of `Ψ_{√2}` is `12312√15 - 48197`**, computed from
`Δ = 18abcd - 4b³d + b²c² - 4ac³ - 27a²d²` at `a = 3√15-6`, `b = 5`, `c = -3√15`, `d = 4`. -/
theorem Psi_discriminant :
    (18 * (3 * Real.sqrt 15 - 6) * 5 * (-(3 * Real.sqrt 15)) * 4
        - 4 * 5 ^ 3 * 4 + 5 ^ 2 * (-(3 * Real.sqrt 15)) ^ 2
        - 4 * (3 * Real.sqrt 15 - 6) * (-(3 * Real.sqrt 15)) ^ 3
        - 27 * (3 * Real.sqrt 15 - 6) ^ 2 * 4 ^ 2)
      = 12312 * Real.sqrt 15 - 48197 := by
  have h : Real.sqrt 15 * Real.sqrt 15 = 15 := Real.mul_self_sqrt (by norm_num)
  nlinarith [h, Real.sqrt_nonneg 15]

/-- **And it is negative**, since `15·12312² = 2273780160 < 2322950809 = 48197²`. -/
theorem Psi_discriminant_neg : 12312 * Real.sqrt 15 - 48197 < 0 := by
  have h : Real.sqrt 15 ^ 2 = 15 := Real.sq_sqrt (by norm_num)
  nlinarith [h, Real.sqrt_nonneg 15]

/-! ## The cubic piece is positive on `σ ≥ 0` -/

/-- **`Ψ_{√2}(σ) > 0` for every `σ ≥ 0`.** The certificate is
`Ψ = (3√15-6)·σ(σ-½)² + (3√15-1)σ² - ((15√15-6)/4)σ + 4`, whose residual quadratic has
discriminant `(3667 - 948√15)/16 < 0` because `948²·15 = 13480560 > 13446889 = 3667²`. -/
theorem Psi_sqrt2_pos {σ : ℝ} (hσ : 0 ≤ σ) : 0 < Psi (Real.sqrt 2) σ := by
  have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hk : Real.sqrt 15 * Real.sqrt 15 = 15 := Real.mul_self_sqrt (by norm_num)
  have hk1 : (3.87298 : ℝ) < Real.sqrt 15 := by nlinarith [Real.sqrt_nonneg 15]
  have hk2 : Real.sqrt 15 < 3.87299 := by nlinarith [Real.sqrt_nonneg 15]
  have hcube : 0 ≤ σ * (σ - 1 / 2) ^ 2 := mul_nonneg hσ (sq_nonneg _)
  simp only [Psi]
  nlinarith [hcube, sq_nonneg (2 * (3 * Real.sqrt 15 - 1) * σ - (15 * Real.sqrt 15 - 6) / 4),
    hk, hk1, hk2, hσ, sq_nonneg σ, Real.sqrt_nonneg 15]

/-- **`Ψ_θ ≥ Ψ_{√2}` whenever `θ ≤ √2` and `σ ≥ 0`**, the `σ³` coefficient decreases in `θ`. -/
theorem Psi_mono_theta {θ σ : ℝ} (hθ : θ ≤ Real.sqrt 2) (hσ : 0 ≤ σ) :
    Psi (Real.sqrt 2) σ ≤ Psi θ σ := by
  have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have h2p : (0:ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  have hc : 0 ≤ σ ^ 3 := by positivity
  simp only [Psi]
  nlinarith [mul_nonneg hc (mul_nonneg h2p.le (sub_nonneg.mpr hθ))]

/-- **The cubic piece holds at every constant `θ ≤ √2`**: `H_θ(σ) > 0` for `σ ≥ 0`. -/
theorem cubic_piece_holds {θ σ : ℝ} (hθ : θ ≤ Real.sqrt 2) (hσ : 0 ≤ σ) : 0 < Hlow θ σ := by
  have h2p : (0:ℝ) < 3 * Real.sqrt 2 := by positivity
  have hpos : 0 < Psi θ σ := lt_of_lt_of_le (Psi_sqrt2_pos hσ) (Psi_mono_theta hθ hσ)
  rw [← Psi_eq] at hpos
  exact pos_of_mul_pos_right hpos h2p.le

/-! ## Both parities satisfy `θ ≤ √2` strictly -/

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-- Jäger's odd constant, `θ̃₀(n)² = 2(n-1)(n-3)/((n+1)(n-2))`. -/
noncomputable def thetaTilde0 (n : ℝ) : ℝ :=
  Real.sqrt (2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))

/-- **`θ₀(n) < √2`** at every `n > 2`, since `θ₀(n)² = 2 - 2(3n-2)/n²`. -/
theorem theta0_lt_sqrt_two {n : ℝ} (hn : 2 < n) : theta0 n < Real.sqrt 2 := by
  have hn0 : (0:ℝ) < n := by linarith
  have key : 2 * (n - 1) * (n - 2) < 2 * n ^ 2 := by nlinarith
  have h1 : Real.sqrt (2 * (n - 1) * (n - 2)) < Real.sqrt (2 * n ^ 2) :=
    Real.sqrt_lt_sqrt (by nlinarith) key
  have h2 : Real.sqrt (2 * n ^ 2) = Real.sqrt 2 * n := by
    rw [Real.sqrt_mul (by norm_num : (0:ℝ) ≤ 2), Real.sqrt_sq hn0.le]
  rw [h2] at h1
  rw [theta0, div_lt_iff₀ hn0]
  linarith

/-- **`θ̃₀(n) < √2`** at every `n > 2`, because `(n-1)(n-3) - (n+1)(n-2) = 5 - 3n < 0`. -/
theorem thetaTilde0_lt_sqrt_two {n : ℝ} (hn : 2 < n) : thetaTilde0 n < Real.sqrt 2 := by
  have hd : (0:ℝ) < (n + 1) * (n - 2) := by nlinarith
  have key : 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)) < 2 := by
    rw [div_lt_iff₀ hd]; nlinarith
  rcases le_or_gt 0 (2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))) with h | h
  · rw [thetaTilde0]
    exact Real.sqrt_lt_sqrt h key
  · calc thetaTilde0 n = Real.sqrt (2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))) := rfl
      _ = 0 := Real.sqrt_eq_zero_of_nonpos h.le
      _ < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)

/-- **The `5 - 3n` sign**, which is the record's reason. -/
theorem odd_numerator_sign {n : ℝ} (hn : 2 ≤ n) :
    (n - 1) * (n - 3) - (n + 1) * (n - 2) = 5 - 3 * n ∧ 5 - 3 * n < 0 := by
  refine ⟨by ring, by linarith⟩

/-! ## Clause (b): the frontier piece at `σ = 3/4` -/

/-- `Θ_{3/4} = 218√2/81 - 131√7/144`. -/
noncomputable def Theta34 : ℝ := 218 * Real.sqrt 2 / 81 - 131 * Real.sqrt 7 / 144

/-- **`H_θ(3/4) = 109√2/96 - 393√7/1024 - 27θ/64`** in closed form. -/
theorem H_at_three_quarters (θ : ℝ) :
    Hhigh θ (3 / 4) = 109 * Real.sqrt 2 / 96 - 393 * Real.sqrt 7 / 1024 - 27 * θ / 64 := by
  have hs2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have h7 : Real.sqrt (1 - (3 / 4 : ℝ) ^ 2) = Real.sqrt 7 / 4 := by
    rw [show (1 : ℝ) - (3 / 4 : ℝ) ^ 2 = 7 / 16 by norm_num,
      Real.sqrt_div (by norm_num : (0:ℝ) ≤ 7), show (16:ℝ) = 4 ^ 2 by norm_num,
      Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 4)]
  have hdiv : (4 + 5 * (3 / 4 : ℝ) ^ 2) / (3 * Real.sqrt 2) = 109 * Real.sqrt 2 / 96 := by
    rw [div_eq_div_iff (by positivity) (by norm_num : (96:ℝ) ≠ 0)]
    linear_combination -327 * hs2
  rw [Hhigh, h7, hdiv]
  ring

/-- **The requirement at `α = 7/48` holds exactly when `θ < Θ_{3/4}`.** -/
theorem requirement_at_three_quarters (θ : ℝ) :
    0 < 109 * Real.sqrt 2 / 96 - 393 * Real.sqrt 7 / 1024 - 27 * θ / 64 ↔ θ < Theta34 := by
  rw [Theta34]
  constructor <;> intro h <;> linarith

/-- **`Θ_{3/4} = 1.39925…`.** -/
theorem Theta34_bracket : 1.39925 < Theta34 ∧ Theta34 < 1.39926 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h7 : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  have h2l : (1.414213562 : ℝ) < Real.sqrt 2 := by nlinarith [Real.sqrt_nonneg 2]
  have h2u : Real.sqrt 2 < 1.414213563 := by nlinarith [Real.sqrt_nonneg 2]
  have h7l : (2.645751311 : ℝ) < Real.sqrt 7 := by nlinarith [Real.sqrt_nonneg 7]
  have h7u : Real.sqrt 7 < 2.645751312 := by nlinarith [Real.sqrt_nonneg 7]
  constructor <;> · rw [Theta34]; nlinarith [h2l, h2u, h7l, h7u]

/-- **`Θ_{3/4} < √2`.** -/
theorem Theta34_lt_sqrt_two : Theta34 < Real.sqrt 2 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h2l : (1.41421 : ℝ) < Real.sqrt 2 := by nlinarith [Real.sqrt_nonneg 2]
  linarith [Theta34_bracket.2]

/-- **The crossing is at `n = 142` for even `n`**: `θ₀(140) < Θ_{3/4} < θ₀(142)`. -/
theorem crossing_even : theta0 140 < Theta34 ∧ Theta34 < theta0 142 := by
  have hlo : theta0 140 < 1.39906 := by
    rw [theta0, div_lt_iff₀ (by norm_num : (0:ℝ) < 140)]
    have : Real.sqrt (2 * (140 - 1) * (140 - 2)) < 1.39906 * 140 := by
      rw [show (2:ℝ) * (140 - 1) * (140 - 2) = 38364 by norm_num]
      have := Real.sqrt_lt_sqrt (by norm_num : (0:ℝ) ≤ 38364)
        (by norm_num : (38364:ℝ) < (1.39906 * 140) ^ 2)
      calc Real.sqrt 38364 < Real.sqrt ((1.39906 * 140) ^ 2) := this
        _ = 1.39906 * 140 := Real.sqrt_sq (by norm_num)
    linarith
  have hhi : (1.399263 : ℝ) < theta0 142 := by
    rw [theta0, lt_div_iff₀ (by norm_num : (0:ℝ) < 142)]
    have : (1.399263 : ℝ) * 142 < Real.sqrt (2 * (142 - 1) * (142 - 2)) := by
      rw [show (2:ℝ) * (142 - 1) * (142 - 2) = 39480 by norm_num]
      have h := Real.sqrt_lt_sqrt (by positivity)
        (by norm_num : ((1.399263 : ℝ) * 142) ^ 2 < 39480)
      calc (1.399263 : ℝ) * 142 = Real.sqrt (((1.399263 : ℝ) * 142) ^ 2) :=
            (Real.sqrt_sq (by norm_num)).symm
        _ < Real.sqrt 39480 := h
    linarith
  exact ⟨lt_trans hlo (by linarith [Theta34_bracket.1]),
    lt_trans (by linarith [Theta34_bracket.2]) hhi⟩

/-! ## The Gate-2 correction on the direction of the substitution -/

/-- **`H` decreases in `θ`.** -/
theorem H_decreasing_in_theta {θ θ' σ : ℝ} (h : θ ≤ θ') (hσ : 0 ≤ σ) :
    Hhigh θ' σ ≤ Hhigh θ σ := by
  have : 0 ≤ σ ^ 3 := by positivity
  simp only [Hhigh]
  nlinarith [mul_nonneg this (sub_nonneg.mpr h)]

/-- **The substitution runs one way only.** From the record's `θ ≤ θ₀(n)` and `H_{θ₀(n)} > 0` one
gets `H_θ > 0`; from `H_{θ₀(n)} ≤ 0` nothing follows about `H_θ`. This is the Gate-2 correction: the
crossing argument's conclusion is about the *bound at its recorded constant*, not about the
requirement. -/
theorem substitution_runs_the_right_way {θ θ0v σ : ℝ} (hle : θ ≤ θ0v) (hσ : 0 ≤ σ)
    (hpos : 0 < Hhigh θ0v σ) : 0 < Hhigh θ σ :=
  lt_of_lt_of_le hpos (H_decreasing_in_theta hle hσ)

/-! ## The cubic piece's own critical constant -/

/-- `θ_crit = (263√1410 - 1440√30)/1350`. -/
noncomputable def thetaCrit : ℝ := (263 * Real.sqrt 1410 - 1440 * Real.sqrt 30) / 1350

/-- **`1.47291 < θ_crit < 1.47292`.** *The record writes the decimal as `1.472899…`; the closed
form it gives evaluates to `1.4729158…`, and this bracket is the closed form's own value. The
record's percentage, `4.1509%` above `√2`, agrees with the closed form and is what
`theta_crit_percent` confirms, so the discrepancy is in the record's decimal alone.* -/
theorem theta_crit_bracket : 1.47291 < thetaCrit ∧ thetaCrit < 1.47292 := by
  have ha : Real.sqrt 1410 ^ 2 = 1410 := Real.sq_sqrt (by norm_num)
  have hb : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
  have hal : (37.5499667 : ℝ) < Real.sqrt 1410 := by nlinarith [Real.sqrt_nonneg 1410]
  have hau : Real.sqrt 1410 < 37.5499668 := by nlinarith [Real.sqrt_nonneg 1410]
  have hbl : (5.4772255 : ℝ) < Real.sqrt 30 := by nlinarith [Real.sqrt_nonneg 30]
  have hbu : Real.sqrt 30 < 5.4772256 := by nlinarith [Real.sqrt_nonneg 30]
  constructor <;> · rw [thetaCrit]; nlinarith [hal, hau, hbl, hbu]

/-- **`θ_crit` is between `4.15%` and `4.16%` above `√2`**, the block's *"a constant about `4%`
above `√2`"*, in closed form. -/
theorem theta_crit_percent :
    1.0415 * Real.sqrt 2 < thetaCrit ∧ thetaCrit < 1.0416 * Real.sqrt 2 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h2l : (1.414213562 : ℝ) < Real.sqrt 2 := by nlinarith [Real.sqrt_nonneg 2]
  have h2u : Real.sqrt 2 < 1.414213563 := by nlinarith [Real.sqrt_nonneg 2]
  obtain ⟨hl, hu⟩ := theta_crit_bracket
  constructor <;> nlinarith [hl, hu, h2l, h2u]

/-- **The free minimiser lies outside `[0, σ*]`**, `σ*² = 15/47 < 0.585²`, which is why the binding
point on the cubic piece is the endpoint. -/
theorem free_minimum_outside_interval : (15 : ℝ) / 47 < 0.585 ^ 2 := by norm_num

end HamiltonsCubic.L165Statement
