import Mathlib

set_option linter.style.longLine false

/-!
# L103, the witness `W₁` and its sharp constant, in closed form

**The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md):**

> #### Observation L103 (the witness $W_1$ and its sharp constant), $f(\pi/2)=1.0092168>1$, $c_{12}=1.009216785$
>
> **$f$ HAS A CLOSED FORM, AND THE REFUTATION REDUCES TO $55>54$.** Both endpoints of the witness circle are **orthogonal critical points**, so both cross terms in the cubic expansion vanish ($T(A,A,B)=\theta^*\langle A,B\rangle=0$ and $T(A,B,B)=\theta_0(12)\langle A,B\rangle=0$), leaving
> $$f(\varphi)=\cos^3\varphi+c_{12}\sin^3\varphi,\qquad c_{12}=\sqrt{2/3}\,\theta_0(12)=\frac{\sqrt{330}}{18}=\sqrt{55/54}.$$
> **The heading's two figures are one number at two precisions.** *And $\pi/2$ is the maximiser, derived*: $f'=3\sin\varphi\cos\varphi(c_{12}\sin\varphi-\cos\varphi)$, whose only interior zero is a **minimum**. **The strongest check is that this reproduces the file's own independently recorded $f(\pi/6)=0.7757$**, a number written by a different route at a different angle.
>
> **THE REACH IS WIDER THAN RECORDED AND THE TARGET NARROWER.** The witness exists **iff $n\ge12$** ($n>6+2\sqrt7$ at even $n$, $n>(13+\sqrt{97})/2$ at odd), not at $n=12$ alone.

## What this file states

The closed form and everything the audit derives from it: `c₁₂ = √330/18 = √(55/54)`, the
refutation `c₁₂ > 1` reducing to `55 > 54`, the derivative, the maximiser at `π/2`, the check at
`π/6`, and the two threshold polynomials behind *"the witness exists iff `n ≥ 12`"*. All proved;
there is no `sorry`.

**What is not stated here** is that `f` is the cubic's restriction to the witness circle, or that
`P(W₁) = θ₀(12)`: those are statements about `Weyl₁₂` and its cubic form, which this file does not
build. `theta0_twelve` records the value `θ₀(12) = √55/6` that `c₁₂` is built from.

**And the block's word *"sharp"* is not stated here at all.** The audit records that it needs
`sup P = θ₀(12)` over a 1603-dimensional complement, which is Conjecture A's own strength, so it
is not available to be formalised, and asserting it here would be asserting the open problem.
-/

namespace HamiltonsCubic.L103

open Real

/-! ## The constant -/

/-- `θ₀(12) = √55/6`, from `θ₀(n)² = 2(n-1)(n-2)/n²` at `n = 12`. -/
noncomputable def theta0Twelve : ℝ := Real.sqrt 55 / 6

/-- `c₁₂ = √330/18`. -/
noncomputable def c12 : ℝ := Real.sqrt 330 / 18

/-- **`θ₀(12)² = 55/36`**, which is `2·11·10/144`. -/
theorem theta0_twelve_sq : theta0Twelve ^ 2 = 55 / 36 := by
  rw [theta0Twelve, div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 55)]
  norm_num

/-- **`c₁₂² = 55/54`**, the number whose excess over `1` is the whole of the refutation. -/
theorem c12_sq : c12 ^ 2 = 55 / 54 := by
  rw [c12, div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 330)]
  norm_num

/-- **`c₁₂ > 0`.** -/
theorem c12_pos : 0 < c12 := by
  rw [c12]; positivity

/-- **`c₁₂ = √(2/3)·θ₀(12)`**, the form the block writes it in. -/
theorem c12_eq_sqrt_two_thirds_mul : c12 = Real.sqrt (2 / 3) * theta0Twelve := by
  have hnn : 0 ≤ Real.sqrt (2 / 3) * theta0Twelve := by
    rw [theta0Twelve]; positivity
  have hsq : (Real.sqrt (2 / 3) * theta0Twelve) ^ 2 = 55 / 54 := by
    rw [theta0Twelve, mul_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2 / 3), div_pow,
      Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 55)]
    norm_num
  calc c12 = Real.sqrt (c12 ^ 2) := (Real.sqrt_sq c12_pos.le).symm
    _ = Real.sqrt ((Real.sqrt (2 / 3) * theta0Twelve) ^ 2) := by rw [c12_sq, hsq]
    _ = Real.sqrt (2 / 3) * theta0Twelve := Real.sqrt_sq hnn

/-- **`c₁₂ > 1`, and the reason is `55 > 54`.** This is the refutation of the `f ≤ 1` premise. -/
theorem one_lt_c12 : 1 < c12 := by
  nlinarith [c12_sq, c12_pos]

/-- **The two figures in the heading are one number at two precisions**, both correct to the
digits printed. -/
theorem c12_bounds : (1.009216 : ℝ) < c12 ∧ c12 < 1.009217 := by
  constructor <;> nlinarith [c12_sq, c12_pos]

/-! ## The function on the witness circle -/

/-- `f(φ) = cos³φ + c·sin³φ`, the cubic restricted to the circle through the two orthogonal
critical points. -/
noncomputable def f (c φ : ℝ) : ℝ := Real.cos φ ^ 3 + c * Real.sin φ ^ 3

/-- **The derivative, `f' = 3 sin φ cos φ (c sin φ - cos φ)`.** -/
theorem f_hasDerivAt (c φ : ℝ) :
    HasDerivAt (f c) (3 * Real.sin φ * Real.cos φ * (c * Real.sin φ - Real.cos φ)) φ := by
  have h1 : HasDerivAt (fun x : ℝ => Real.cos x ^ 3)
      ((3 : ℕ) * Real.cos φ ^ (3 - 1) * (-Real.sin φ)) φ := (Real.hasDerivAt_cos φ).pow 3
  have h2 : HasDerivAt (fun x : ℝ => Real.sin x ^ 3)
      ((3 : ℕ) * Real.sin φ ^ (3 - 1) * Real.cos φ) φ := (Real.hasDerivAt_sin φ).pow 3
  have h3 := h1.add (h2.const_mul c)
  norm_num at h3
  have heq : 3 * Real.sin φ * Real.cos φ * (c * Real.sin φ - Real.cos φ)
      = -(3 * Real.cos φ ^ 2 * Real.sin φ) + c * (3 * Real.sin φ ^ 2 * Real.cos φ) := by ring
  have h4 : HasDerivAt (f c)
      (-(3 * Real.cos φ ^ 2 * Real.sin φ) + c * (3 * Real.sin φ ^ 2 * Real.cos φ)) φ := h3
  rw [heq]
  exact h4

/-- **The interior critical point is where `c sin φ = cos φ`**, and `f` falls strictly before it:
on `(0, π/2)` with `c sin φ < cos φ` the derivative is negative. -/
theorem f_deriv_neg {c φ : ℝ} (h0 : 0 < φ) (h1 : φ < π / 2) (hlt : c * Real.sin φ < Real.cos φ) :
    deriv (f c) φ < 0 := by
  rw [(f_hasDerivAt c φ).deriv]
  have hs : 0 < Real.sin φ := Real.sin_pos_of_pos_of_lt_pi h0 (by linarith [Real.pi_pos])
  have hc : 0 < Real.cos φ := Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos], h1⟩
  have hprod : 0 < 3 * Real.sin φ * Real.cos φ := by nlinarith
  exact mul_neg_of_pos_of_neg hprod (by linarith)

/-- **And it rises strictly after it**: on `(0, π/2)` with `c sin φ > cos φ` the derivative is
positive. So the only interior zero is a minimum, and the maximum on `[0, π/2]` is at an
endpoint. -/
theorem f_deriv_pos {c φ : ℝ} (h0 : 0 < φ) (h1 : φ < π / 2) (hgt : Real.cos φ < c * Real.sin φ) :
    0 < deriv (f c) φ := by
  rw [(f_hasDerivAt c φ).deriv]
  have hs : 0 < Real.sin φ := Real.sin_pos_of_pos_of_lt_pi h0 (by linarith [Real.pi_pos])
  have hc : 0 < Real.cos φ := Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos], h1⟩
  have hprod : 0 < 3 * Real.sin φ * Real.cos φ := by nlinarith
  exact mul_pos hprod (by linarith)

/-- **`f(π/2) = c`.** -/
theorem f_pi_div_two (c : ℝ) : f c (π / 2) = c := by
  rw [f, Real.cos_pi_div_two, Real.sin_pi_div_two]; ring

/-- **`π/2` is the maximiser on `[0, π/2]` whenever `c ≥ 1`**, so `sup f = c₁₂`: the block's
`f(π/2) = 1.0092168 > 1` is the maximum and not merely one value. -/
theorem f_le_c {c φ : ℝ} (hc : 1 ≤ c) (h0 : 0 ≤ φ) (h1 : φ ≤ π / 2) : f c φ ≤ c := by
  have hs : 0 ≤ Real.sin φ := Real.sin_nonneg_of_nonneg_of_le_pi h0 (by linarith [Real.pi_pos])
  have hc0 : 0 ≤ Real.cos φ := Real.cos_nonneg_of_mem_Icc ⟨by linarith [Real.pi_pos], h1⟩
  have hs1 : Real.sin φ ≤ 1 := Real.sin_le_one φ
  have hc1 : Real.cos φ ≤ 1 := Real.cos_le_one φ
  have hpy : Real.sin φ ^ 2 + Real.cos φ ^ 2 = 1 := Real.sin_sq_add_cos_sq φ
  have e1 : Real.cos φ ^ 3 ≤ Real.cos φ ^ 2 := by nlinarith
  have hs3 : Real.sin φ ^ 3 ≤ Real.sin φ ^ 2 := by nlinarith
  have e2 : c * Real.sin φ ^ 3 ≤ c * Real.sin φ ^ 2 :=
    mul_le_mul_of_nonneg_left hs3 (by linarith)
  have hle : f c φ ≤ Real.cos φ ^ 2 + c * Real.sin φ ^ 2 := by rw [f]; linarith
  nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ c - 1)
    (by nlinarith : (0:ℝ) ≤ 1 - Real.sin φ ^ 2)]

/-- **The independent check at `π/6`**: `f(π/6) = 3√3/8 + c₁₂/8`, which is the record's
separately written `0.7757`. -/
theorem f_pi_div_six : f c12 (π / 6) = 3 * Real.sqrt 3 / 8 + c12 / 8 := by
  rw [f, Real.cos_pi_div_six, Real.sin_pi_div_six]
  have h3 : Real.sqrt 3 ^ 3 = 3 * Real.sqrt 3 := by
    have h : Real.sqrt 3 ^ 3 = Real.sqrt 3 ^ 2 * Real.sqrt 3 := by ring
    rw [h, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 3)]
  rw [div_pow, h3]
  ring

/-- **And it lands at `0.7757` to four places.** -/
theorem f_pi_div_six_bounds : (0.7756 : ℝ) < f c12 (π / 6) ∧ f c12 (π / 6) < 0.7757 := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3pos : 0 < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  have hlo : (1.7320508 : ℝ) < Real.sqrt 3 := by nlinarith
  have hhi : Real.sqrt 3 < 1.7320509 := by nlinarith
  obtain ⟨hc1, hc2⟩ := c12_bounds
  rw [f_pi_div_six]
  constructor <;> linarith

/-! ## The reach: the witness exists exactly from `n = 12` -/

/-- **The even-`n` threshold `n² - 12n + 8 > 0` holds from `n = 12`**, its upper root being
`6 + 2√7 ≈ 11.29`. -/
theorem even_threshold {n : ℝ} (hn : 12 ≤ n) : 0 < n ^ 2 - 12 * n + 8 := by nlinarith

/-- **The odd-`n` threshold `n² - 13n + 18 > 0` holds from `n = 12`** as well, its upper root
being `(13 + √97)/2 ≈ 11.42`. -/
theorem odd_threshold {n : ℝ} (hn : 12 ≤ n) : 0 < n ^ 2 - 13 * n + 18 := by nlinarith

/-- **Both fail at `n = 11`**, which is what makes `12` the first admissible dimension in either
parity, the reach is `n ≥ 12`, not `n = 12` alone. -/
theorem thresholds_fail_at_eleven :
    (11 : ℝ) ^ 2 - 12 * 11 + 8 < 0 ∧ (11 : ℝ) ^ 2 - 13 * 11 + 18 < 0 := by
  constructor <;> norm_num
