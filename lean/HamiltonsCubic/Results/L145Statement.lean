import Mathlib

set_option linter.style.longLine false

/-!
# L145, the constant chain for the balanced-orbit tube radius, and the `Ω(n^{-3/2})` it supports

The record's statement, quoted verbatim from
[second-order.md](../../../findings/second-order.md):

> **LEMMA L145.** *At the balanced product `W* = S^m × S^m` with `n = 2m ≥ 12`, and over directions
> `H` with `‖H‖_F = 1`, `H ⊥ W*` and `H ⊥ T_{W*}𝒪`, the penalised functional's tube radius about
> `SO(n)·W*` satisfies `r_n = Ω(n^{-3/2})`.*

with its step table, also verbatim:

> | the spectrum is two-valued with no kernel, so `g_n = |λ_-| = (2/n)√((n-2)/(2(n-1))) = Θ(1/n)` | **CONFIRMED**, recomputed cold twice |
> | `W ↦ W_-` is analytic on the ball of radius `g_n` in the record's Frobenius norm | **CONFIRMED**; the complex radius must be `ρ < g_n/2`, not `ρ = g_n/2` |
> | the Cauchy estimate gives `C_δ = O(n³)` | **REFUTED**, two independent errors |
> | `r_n = Ω(n^{-3/2})` | **CONFIRMED as a lower bound.** *The equality reading is withdrawn* |
>
> **THE CORRECTED CONSTANT IS `C_δ = O(n)`, NOT `O(n³)`.** Two errors compounded: the Cauchy
> supremum is `M = O(g_n)` rather than `O(1)`, giving `‖A^{(k)}‖ = O(n^{k-1})`; and `C_δ` is
> `(δ²)''' = 2⟨A''',A⟩ + 6⟨A'',A'⟩`, whose first term **vanishes at `A(0) = Alt(W*_-) = 0`**.
>
> *Done by hand, `f(u*) = 2u*/a` is `Θ(n^{-3/2})` only for `sup|P| = O(√n)` and `Θ(n^{-2})` at
> `Θ(n)`, so the step needs L143, which this entry does not cite.*

## What this file types

The **constant chain**, step by step, as arithmetic on the record's own closed forms.

* `gapN` is the spectral gap `g_n = √(2(n-2))/(n√(n-1))`, which is the displayed
  `(2/n)√((n-2)/(2(n-1)))`, `gapN_eq_record_form` proves the two agree.
* `gap_lower`, `gap_upper`, `1/n ≤ g_n ≤ √2/n`, so `g_n = Θ(1/n)` with explicit constants, at
  every `n ≥ 3`. `gap_at_twelve` reproduces the record's own witness `g₁₂ = (1/6)√(5/11)`.
* `cauchy_step`, the corrected Cauchy estimate, as the arithmetic implication it is: from
  `‖A^{(k+1)}‖ ≤ (k+1)! · M / ρ^{k+1}` and `M ≤ C·ρ` one gets `‖A^{(k+1)}‖ ≤ C · (k+1)! / ρ^k`,
  which at `ρ ≥ c/n` is `O(n^k)`. *The exponents are written `k+1` and `k` rather than `k` and
  `k-1` so that no truncated subtraction enters.* `cauchy_at_gap` reads it at `ρ = Θ(g_n)`.
* `Cdelta_first_term_vanishes`, `C_δ = 2⟨A''',A⟩ + 6⟨A'',A'⟩` reduces to `6⟨A'',A'⟩` when
  `A(0) = 0`, the record's second correction.
* `radius_lower`, **the load-bearing step**, `c_p/S ≥ 2·n^{-3/2}` at every `n ≥ 12`, with
  `c_p = 3θ₀(n)/(n-2)` and `S ≤ 1 + √(n-2)` the bound L143 supplies. *The chain
  `2S ≤ (8/3)√(n-2) ≤ 3√(n-2) ≤ 3√n ≤ 3n√n/(n-2)` is the whole of it.* This is where
  `sup|P| = O(√n)` buys the exponent `-3/2`, and `radius_lower_at_linear_S` records the contrast:
  at `S = Θ(n)` the same quotient is only `Θ(n^{-2})`.
* `theta0_ge_one`, `theta0_lt_sqrt_two`, the two facts about `θ₀(n)` the chain consumes.

## What is NOT typed here

* **The tube radius itself, and the lemma's conclusion.** `r_n` is defined by the penalised
  functional `½Hess(P|_S) - κ_n‖D(Alt W_-)[·]‖²` on `T_{W*}S ∩ T_{W*}𝒪^⊥`, and neither `Alt`, nor
  `W_-`, nor the Hessian, nor the orbit is nameable in the record's Lean layer
  ([WeylReal.lean](../Base/WeylReal.lean) carries `IsWeyl`, `Pcubic`, `theta`, `Qop`, `IsCritical`
  and no more). **So `r_n = Ω(n^{-3/2})` is not stated here**, and what is typed is the chain of
  constants that supports it.
* **That `g_n` is the spectral gap of `W*`**, i.e. that the `Λ²` spectrum of the balanced product
  is two-valued with `|λ_-| = √(2(n-2))/(n√(n-1))`. That is the record's computation; `gapN` here
  is the closed form and nothing more.
* **The analyticity of `W ↦ W_-` on the ball of radius `g_n`**, and the correction that the complex
  radius must be `ρ < g_n/2` strictly.
* **`A(0) = Alt(W*_-) = 0`**, which is L148's and is typed there;
  `Cdelta_first_term_vanishes` takes it as a hypothesis.
* **That `‖A^{(k)}‖ ≤ k!M/ρ^k` for the actual defect `A`**, and that its Cauchy supremum satisfies
  `M = O(ρ)`. Both enter `cauchy_step` as hypotheses on real numbers.
* **The identification of `inf_H c(H)/C(H)` with a tube radius**, and the record's distinction of
  the three exponents `n^{-4}`, `n^{-2}` and `n^{-3/2}` as three different quantities.
* **`S = sup|P| ≤ 1 + √(n-2)`**, which is L143's; it enters `radius_lower` as a hypothesis.
-/

namespace HamiltonsCubic.L145Statement

/-! ## `θ₀(n)`, and the two facts the chain uses -/

/-- `θ₀(n) = √(2(n-1)(n-2))/n`, the balanced product's own value. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

theorem theta0_sq {n : ℝ} (hn : 3 ≤ n) : theta0 n ^ 2 = 2 * (n - 1) * (n - 2) / n ^ 2 := by
  rw [theta0, div_pow, Real.sq_sqrt (by nlinarith)]

theorem theta0_pos {n : ℝ} (hn : 3 ≤ n) : 0 < theta0 n :=
  div_pos (Real.sqrt_pos.mpr (by nlinarith)) (by linarith)

/-- `θ₀(n) ≥ 1` at every `n ≥ 12`, which is `n² - 6n + 4 ≥ 0`. -/
theorem theta0_ge_one {n : ℝ} (hn : 12 ≤ n) : 1 ≤ theta0 n := by
  have h0 : 0 < theta0 n := theta0_pos (by linarith)
  have hsq : 1 ≤ theta0 n ^ 2 := by
    rw [theta0_sq (by linarith), le_div_iff₀ (by positivity)]
    nlinarith
  nlinarith

/-- `θ₀(n) < √2` at every `n ≥ 3`. -/
theorem theta0_lt_sqrt_two {n : ℝ} (hn : 3 ≤ n) : theta0 n < Real.sqrt 2 := by
  refine (Real.lt_sqrt (theta0_pos hn).le).mpr ?_
  rw [theta0_sq hn, div_lt_iff₀ (by positivity)]
  nlinarith

/-! ## Step 1: the spectral gap is `Θ(1/n)` -/

/-- The spectral gap at the balanced product, `g_n = √(2(n-2))/(n√(n-1))`. -/
noncomputable def gapN (n : ℝ) : ℝ := Real.sqrt (2 * (n - 2)) / (n * Real.sqrt (n - 1))

/-- **The record's own written form.** `g_n = (2/n)√((n-2)/(2(n-1)))`. -/
theorem gapN_eq_record_form {n : ℝ} (hn : 3 ≤ n) :
    gapN n = 2 / n * Real.sqrt ((n - 2) / (2 * (n - 1))) := by
  have hn0 : (0 : ℝ) < n := by linarith
  have h1 : (0 : ℝ) < n - 1 := by linarith
  have h2 : (0 : ℝ) ≤ n - 2 := by linarith
  have hs1 : (0 : ℝ) < Real.sqrt (n - 1) := Real.sqrt_pos.mpr h1
  have hs2 : Real.sqrt (2 * (n - 1)) = Real.sqrt 2 * Real.sqrt (n - 1) :=
    Real.sqrt_mul (by norm_num) _
  have hs3 : Real.sqrt (2 * (n - 2)) = Real.sqrt 2 * Real.sqrt (n - 2) :=
    Real.sqrt_mul (by norm_num) _
  have hsq2 : (0 : ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  rw [gapN, Real.sqrt_div h2, hs2, hs3]
  field_simp
  rw [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]

/-- **`1/n ≤ g_n`**, at every `n ≥ 3`: it is `n - 1 ≤ 2(n-2)`. -/
theorem gap_lower {n : ℝ} (hn : 3 ≤ n) : 1 / n ≤ gapN n := by
  have hn0 : (0 : ℝ) < n := by linarith
  have hs1 : (0 : ℝ) < Real.sqrt (n - 1) := Real.sqrt_pos.mpr (by linarith)
  have hmono : Real.sqrt (n - 1) ≤ Real.sqrt (2 * (n - 2)) := Real.sqrt_le_sqrt (by linarith)
  rw [gapN, div_le_div_iff₀ hn0 (by positivity)]
  nlinarith

/-- **`g_n ≤ √2/n`**, at every `n ≥ 3`: it is `2(n-2) ≤ 2(n-1)`. Together with `gap_lower` this is
`g_n = Θ(1/n)` with explicit constants. -/
theorem gap_upper {n : ℝ} (hn : 3 ≤ n) : gapN n ≤ Real.sqrt 2 / n := by
  have hn0 : (0 : ℝ) < n := by linarith
  have hs1 : (0 : ℝ) < Real.sqrt (n - 1) := Real.sqrt_pos.mpr (by linarith)
  have hs2 : Real.sqrt 2 * Real.sqrt (n - 1) = Real.sqrt (2 * (n - 1)) :=
    (Real.sqrt_mul (by norm_num) _).symm
  have hmono : Real.sqrt (2 * (n - 2)) ≤ Real.sqrt (2 * (n - 1)) := Real.sqrt_le_sqrt (by linarith)
  rw [gapN, div_le_div_iff₀ (by positivity) hn0]
  nlinarith

/-- **The record's own witness**, `g₁₂ = (1/6)√(5/11)`. -/
theorem gap_at_twelve : gapN 12 = 1 / 6 * Real.sqrt (5 / 11) := by
  have h20 : Real.sqrt (2 * (12 - 2)) = 2 * Real.sqrt 5 := by
    rw [show (2 : ℝ) * (12 - 2) = 2 ^ 2 * 5 by norm_num, Real.sqrt_mul (by positivity),
      Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 2)]
  have hdiv : Real.sqrt ((5 : ℝ) / 11) = Real.sqrt 5 / Real.sqrt 11 :=
    Real.sqrt_div (by norm_num) _
  have h11 : (0 : ℝ) < Real.sqrt 11 := Real.sqrt_pos.mpr (by norm_num)
  rw [gapN, show (12 : ℝ) - 1 = 11 by norm_num, h20, hdiv]
  field_simp
  ring

/-! ## Step 3: the corrected Cauchy estimate -/

/-- **THE CORRECTED CAUCHY ESTIMATE, AS ARITHMETIC.** From `‖A^{(k+1)}‖ ≤ (k+1)!·M/ρ^{k+1}` and the
corrected supremum `M ≤ C·ρ` (rather than `M = O(1)`), one gets `‖A^{(k+1)}‖ ≤ C·(k+1)!/ρ^k`.

*The exponents are written `k+1` and `k` so that no truncated subtraction enters.* -/
theorem cauchy_step (k : ℕ) (A M C ρ : ℝ) (hρ : 0 < ρ) (hM : M ≤ C * ρ)
    (hA : A ≤ (Nat.factorial (k + 1) : ℝ) * M / ρ ^ (k + 1)) :
    A ≤ C * (Nat.factorial (k + 1) : ℝ) / ρ ^ k := by
  have hfac : (0 : ℝ) < (Nat.factorial (k + 1) : ℝ) := by
    exact_mod_cast Nat.factorial_pos (k + 1)
  have hpk : (0 : ℝ) < ρ ^ k := pow_pos hρ k
  have hpk1 : (0 : ℝ) < ρ ^ (k + 1) := pow_pos hρ (k + 1)
  refine le_trans hA ?_
  rw [div_le_div_iff₀ hpk1 hpk, pow_succ]
  nlinarith [mul_le_mul_of_nonneg_left hM (le_of_lt (mul_pos hfac hpk))]

/-- Read at `ρ ≥ c/n` with `c > 0`, the same estimate is `O(n^k)`: the record's
`‖A^{(k)}‖ = O(n^{k-1})`. -/
theorem cauchy_at_gap (k : ℕ) (A M C c n ρ : ℝ) (hc : 0 < c) (hn : 0 < n) (hρ : 0 < ρ)
    (hgap : c / n ≤ ρ) (hCpos : 0 ≤ C) (hM : M ≤ C * ρ)
    (hA : A ≤ (Nat.factorial (k + 1) : ℝ) * M / ρ ^ (k + 1)) :
    A ≤ C * (Nat.factorial (k + 1) : ℝ) * (n / c) ^ k := by
  have h1 := cauchy_step k A M C ρ hρ hM hA
  have h2 : (c / n) ^ k ≤ ρ ^ k := pow_le_pow_left₀ (by positivity) hgap k
  have h3 : (0 : ℝ) < (c / n) ^ k := by positivity
  have h4 : C * (Nat.factorial (k + 1) : ℝ) / ρ ^ k
      ≤ C * (Nat.factorial (k + 1) : ℝ) / (c / n) ^ k := by
    apply div_le_div_of_nonneg_left _ h3 h2
    exact mul_nonneg hCpos (by positivity)
  refine le_trans h1 (le_trans h4 (le_of_eq ?_))
  rw [div_pow, div_div_eq_mul_div, div_pow]
  field_simp

/-! ## Step 3, second half: the first term of `C_δ` vanishes -/

/-- **`C_δ = 2⟨A''',A⟩ + 6⟨A'',A'⟩` reduces to `6⟨A'',A'⟩` when `A(0) = 0`**, the record's second
correction. *`A(0) = Alt(W*_-) = 0` is L148's and is typed there; here it is a hypothesis.* -/
theorem Cdelta_first_term_vanishes (ip3 ip21 A0 : ℝ) (hA0 : A0 = 0) :
    2 * (ip3 * A0) + 6 * ip21 = 6 * ip21 := by
  rw [hA0]; ring

/-! ## Step 4: the exponent, and where `sup|P| = O(√n)` buys it -/

/-- **THE LOAD-BEARING STEP.** With `c_p = 3θ₀(n)/(n-2)` and `S = sup|P| ≤ 1 + √(n-2)` (L143's
bound), the quotient `c_p/S` is at least `2·n^{-3/2}` at every `n ≥ 12`.

*The chain is `2S ≤ (8/3)√(n-2) ≤ 3√(n-2) ≤ 3√n ≤ 3n√n/(n-2) ≤ c_p·n√n`, using `θ₀ ≥ 1` and
`√(n-2) ≥ 3`.* -/
theorem radius_lower {n S : ℝ} (hn : 12 ≤ n) (hSpos : 0 < S) (hS : S ≤ 1 + Real.sqrt (n - 2)) :
    2 / (n * Real.sqrt n) ≤ 3 * theta0 n / (n - 2) / S := by
  have hn0 : (0 : ℝ) < n := by linarith
  have hn2 : (0 : ℝ) < n - 2 := by linarith
  have hu : (0 : ℝ) < Real.sqrt n := Real.sqrt_pos.mpr hn0
  have ht : (0 : ℝ) < Real.sqrt (n - 2) := Real.sqrt_pos.mpr hn2
  have hden : (0 : ℝ) < n * Real.sqrt n := by positivity
  have h9 : Real.sqrt 9 = 3 := by
    rw [show (9 : ℝ) = 3 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
  have ht3 : (3 : ℝ) ≤ Real.sqrt (n - 2) := by
    rw [← h9]; exact Real.sqrt_le_sqrt (by linarith)
  have htu : Real.sqrt (n - 2) ≤ Real.sqrt n := Real.sqrt_le_sqrt (by linarith)
  have hth : (1 : ℝ) ≤ theta0 n := theta0_ge_one hn
  rw [div_le_div_iff₀ hden hSpos]
  -- `2S ≤ 3√(n-2) ≤ 3√n`
  have hA : 2 * S ≤ 3 * Real.sqrt n := by nlinarith
  -- `3√n ≤ (3/(n-2))·n·√n ≤ (3θ₀/(n-2))·(n·√n)`
  have hB : 3 * Real.sqrt n ≤ 3 * theta0 n / (n - 2) * (n * Real.sqrt n) := by
    rw [div_mul_eq_mul_div, le_div_iff₀ hn2]
    nlinarith [mul_pos hn0 hu, mul_nonneg (le_of_lt hu) (le_of_lt hn0)]
  linarith

/-- **The contrast the record draws.** At `S = Θ(n)` the same quotient is only `Θ(n^{-2})`: with
`S ≥ n` and `θ₀ < √2`, `c_p/S ≤ 3√2/((n-2)·n)`. *So the exponent `-3/2` is bought by
`sup|P| = O(√n)` and by nothing else.* -/
theorem radius_lower_at_linear_S {n S : ℝ} (hn : 12 ≤ n) (hS : n ≤ S) :
    3 * theta0 n / (n - 2) / S ≤ 3 * Real.sqrt 2 / ((n - 2) * n) := by
  have hn0 : (0 : ℝ) < n := by linarith
  have hn2 : (0 : ℝ) < n - 2 := by linarith
  have hSpos : (0 : ℝ) < S := by linarith
  have hth : theta0 n < Real.sqrt 2 := theta0_lt_sqrt_two (by linarith)
  have hth0 : 0 < theta0 n := theta0_pos (by linarith)
  have hs2 : (0 : ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  rw [div_div, div_le_div_iff₀ (by positivity) (by positivity)]
  have e1 : 3 * theta0 n * ((n - 2) * n) ≤ 3 * Real.sqrt 2 * ((n - 2) * n) := by
    nlinarith [mul_pos hn2 hn0, hth.le]
  have e2 : 3 * Real.sqrt 2 * ((n - 2) * n) ≤ 3 * Real.sqrt 2 * ((n - 2) * S) := by
    nlinarith [mul_nonneg (mul_nonneg (by norm_num : (0:ℝ) ≤ 3) hs2.le) hn2.le]
  linarith

end HamiltonsCubic.L145Statement
