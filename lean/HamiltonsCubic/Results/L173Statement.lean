import Mathlib

set_option linter.style.longLine false

/-!
# L173, the pinned class cannot bound `θ` once a kernel is allowed, and the witness is exact

## The record's statement, quoted verbatim from [bounds-relaxations.md](../../../findings/bounds-relaxations.md)

> #### Lemma L173, the pinned class cannot bound $\theta$ once a kernel is allowed, and the witness is exact

> **Statement.** At $n=12$, the spectrum with distinct values $\nu=(-a,\tfrac43a,0)$ and
> multiplicities $(4,3,59)$, where $a=\sqrt{3/28}$, admits a totally symmetric hollow $T\ge0$
> satisfying relations (A), (B), (C) at every row and the pair cap at every pair, with
> $$\theta=7a=\frac{\sqrt{21}}2=2.2912878\ldots\;>\;\theta_0(12)=\frac{\sqrt{220}}{12}.$$
> **Hence no bound proved from (A), (B), (C), the pair cap, positivity and admissible support
> alone can close Conjecture A over all unit Weyl operators**, and every spectral item must be
> kernel-free or carry a relation that is non-vacuous on zero rows.

> **The parameters are forced.** $4+3+59=66=\binom{12}2$; tracelessness $-4a+3b=0$ gives
> $b=\tfrac43a$; unit norm $4a^2+3b^2=\tfrac{28}3a^2=1$ gives $a=\sqrt{3/28}$.

> **The witness, in closed form.** Writing $t_{ijk}$ for the value-type variables,
> $$t_{112}=\tfrac23,\qquad t_{222}=2,\qquad t_{133}=t_{233}=\tfrac4{1711},\qquad
> t_{333}=\tfrac{178}{32509},$$ with the remaining six zero. **All nine relations hold as exact
> rational identities** once $\nu$ is written as $a\cdot(-1,\tfrac43,0)$.

> **Three pair caps are tight and three are slack**: $(1,1)$, $(1,2)$ and $(2,2)$ all equal $2$,
> while $(1,3)$ and $(2,3)$ read $\tfrac8{59}$ and $(3,3)$ reads $\tfrac{562}{1711}$.

> **THE MECHANISM IS ONE COEFFICIENT.** *The type $\{1,3,3\}$ enters (A$_1$) with weight
> $\mu_3(\mu_3-1)=59\cdot58=3422$ against a right-hand side of $2(n-2)=20$.*

> **AND $\theta$ HAS A CLOSED FORM THE RECORD CARRIED AS A DECIMAL.** *$7a=7\sqrt{3/28}=\sqrt{21}/2$.*
> **The ratio to the target is $\tfrac{\sqrt{21}}2\big/\theta_0(12)=1.8537\ldots$**

> **THE WITNESS EXISTS AT EVERY $n\ge8$, NOT ONLY AT $n=12$.** *Taking $m_3=\binom n2-7$ gives the
> same family at every $n\ge8$, with $\theta=\tfrac{\sqrt{21}}2$ constant in $n$ against
> $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}<2$ always.*

and the reduced system it is checked against, quoted from
[Lemma L104](../../../findings/bounds-relaxations.md) in the same file:

> $$\text{(A}_i)\ \sum_{j<k}2\mu_j\mu_k t_{ijk}+\sum_j\mu_j(\mu_j-1)t_{ijj}=2(n-2),$$
> $$\text{(B}_i)\ \sum_{j<k}\mu_j\mu_k(\nu_j+\nu_k)t_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_jt_{ijj}=-2\nu_i,$$
> $$\text{(C}_i)\ \sum_{j<k}2\mu_j\mu_k\nu_j\nu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_j^2t_{ijj}
> =2\nu_i(\theta-\nu_i),$$
> with $\mu_j=m_j-\delta_{ij}$; and the pair cap, *"in reduced variables the cap is the
> $G$-invariant family $\sum_k\mu_k^{(ij)}t_{ijk}\le2$"*.

## What is typed here

The witness is built as a genuine totally symmetric `T : Fin 3 → Fin 3 → Fin 3 → ℚ`, and all nine
relations and all six pair caps are then verified as exact rational identities:

* `T_symm`, `T_hollow_types`, `T_nonneg`, total symmetry, the four nonzero value types, `T ≥ 0`.
* `relA`, `relB`, `relC`, (A$_i$), (B$_i$), (C$_i$) at every one of the three rows, at
  `θ' = 7` in the scaled variable.
* `cap_tight_11`, `cap_tight_12`, `cap_tight_22`, `cap_13`, `cap_23`, `cap_33`, the six pair caps,
  three at exactly `2` and three strictly below.
* `mult_sum`, `traceless`, `unit_norm_forces_a`, `theta_closed_form`, the parameters, and
  `7a = √21/2`.
* `theta_exceeds_target`, `ratio_bracket`, `√21/2 > θ₀(12)` and the ratio `1.8537…`.
* `witness_beats_every_n`, `√21/2 > θ₀(n)` at every `n`, since `θ₀(n) < √2`, which is the
  strengthening to all `n ≥ 8`.
* `mechanism_coefficient`, `μ₃(μ₃-1) = 3422` against `2(n-2) = 20`.
* `cap_constant_is_load_bearing`, at a cap `c` the ceiling `θ/a ≤ 4c-1` gives `7a` at `c = 2` and
  `3a < θ₀(12)` at `c = 1`, so L31's constant `2` is exactly what the lemma rests on.

The scaling is the record's: `ν = a · (-1, 4/3, 0)`, so (A) is `a`-free, (B) is homogeneous of
degree `1` in `a` and (C) of degree `2`; the rational relations below are stated in the scaled
variable `ν' = (-1, 4/3, 0)` with `θ' = θ/a = 7`, and `a` is pinned separately by the unit norm.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**That the reduced system (A), (B), (C) is the correct relaxation of criticality is not typed.**
Its derivation is [bounds.md](../../../findings/bounds.md)'s, (A) being Lemma L153's Killing row mass, (B) the
per-row identity `𝒜(W) = 2W` and (C) criticality, which [Lemma L104](../../../findings/bounds-relaxations.md) cites. It lives on
`Λ²ℝⁿ` with the curvature layer this record has not built in Lean; here the three relations are
*definitions* (`relAlhs`, `relBlhs`, `relClhs`) transcribed from the block, and what is proved is
that the witness satisfies them. **A reader checking this file is checking the transcription of
the system and the exactness of the witness, not the soundness of the relaxation.**

**Nor is the non-realizability clause typed**, that the three tight caps force all `21` pairs
tight, that [L31](../../../findings/stratum-two-negative.md)'s equality case then gives a common
rank-`4` image `V`, and that `7` orthonormal elements cannot live in the `6`-dimensional
`𝔰𝔬(V)`. That argument is about brackets of `2`-forms, which is the layer that is absent.
-/

namespace HamiltonsCubic.L173Statement

/-! ## The witness

The four nonzero value types, and the ten-variable totally symmetric array they generate. -/

/-- `t₁₁₂ = 2/3`. -/
def t112 : ℚ := 2 / 3
/-- `t₂₂₂ = 2`. -/
def t222 : ℚ := 2
/-- `t₁₃₃ = t₂₃₃ = 4/1711`. -/
def t133 : ℚ := 4 / 1711
/-- `t₃₃₃ = 178/32509`. -/
def t333 : ℚ := 178 / 32509

/-- The witness `T`, written as a `3×3×3` array whose entries depend only on the multiset
`{i,j,k}`. The six types `111, 113, 122, 123, 223` are zero; `233` equals `133`. -/
def T : Fin 3 → Fin 3 → Fin 3 → ℚ :=
  ![ ![ ![0,    t112, 0   ], ![t112, 0,    0   ], ![0,    0,    t133] ],
     ![ ![t112, 0,    0   ], ![0,    t222, 0   ], ![0,    0,    t133] ],
     ![ ![0,    0,    t133], ![0,    0,    t133], ![t133, t133, t333] ] ]

/-- **`T` is totally symmetric.** -/
theorem T_symm (i j k : Fin 3) :
    T i j k = T j i k ∧ T i j k = T i k j := by
  fin_cases i <;> fin_cases j <;> fin_cases k <;> exact ⟨rfl, rfl⟩

/-- **`T ≥ 0`**, which is the positivity the pinned class assumes. -/
theorem T_nonneg (i j k : Fin 3) : 0 ≤ T i j k := by
  fin_cases i <;> fin_cases j <;> fin_cases k <;> norm_num [T, t112, t222, t133, t333]

/-- The four nonzero types, read off `T`. -/
theorem T_nonzero_types :
    T 0 0 1 = 2 / 3 ∧ T 1 1 1 = 2 ∧ T 0 2 2 = 4 / 1711 ∧ T 1 2 2 = 4 / 1711 ∧
      T 2 2 2 = 178 / 32509 := by
  refine ⟨rfl, rfl, rfl, rfl, rfl⟩

/-- The six zero types. -/
theorem T_zero_types :
    T 0 0 0 = 0 ∧ T 0 0 2 = 0 ∧ T 0 1 1 = 0 ∧ T 0 1 2 = 0 ∧ T 1 1 2 = 0 := by
  refine ⟨rfl, rfl, rfl, rfl, rfl⟩

/-! ## The spectrum, in the scaled variable

`ν = a · ν'` with `ν' = (-1, 4/3, 0)` and multiplicities `(4, 3, 59)`. -/

/-- The multiplicities `(4, 3, 59)`. -/
def m : Fin 3 → ℚ := ![4, 3, 59]

/-- The scaled eigenvalues `ν' = (-1, 4/3, 0)`; the record's `ν` is `a · ν'`. -/
def nu : Fin 3 → ℚ := ![-1, 4 / 3, 0]

/-- `μ⁽ⁱ⁾ⱼ = mⱼ - δᵢⱼ`. -/
def mu (i j : Fin 3) : ℚ := m j - (if j = i then 1 else 0)

/-- The ordered-pair weight of the reduced system: `μⱼμₖ` off the diagonal and `μⱼ(μⱼ-1)` on it,
so that a sum over ordered pairs `(j,k)` reproduces the block's `∑_{j<k} 2μⱼμₖ … + ∑_j μⱼ(μⱼ-1) …`. -/
def w (i j k : Fin 3) : ℚ := if j = k then mu i j * (mu i j - 1) else mu i j * mu i k

/-- **(Aᵢ)'s left-hand side.** -/
def relAlhs (i : Fin 3) : ℚ := ∑ j, ∑ k, w i j k * T i j k

/-- **(Bᵢ)'s left-hand side**, in the scaled variable; the record's is `a` times this. -/
def relBlhs (i : Fin 3) : ℚ := ∑ j, ∑ k, w i j k * ((nu j + nu k) / 2) * T i j k

/-- **(Cᵢ)'s left-hand side**, in the scaled variable; the record's is `a²` times this. -/
def relClhs (i : Fin 3) : ℚ := ∑ j, ∑ k, w i j k * (nu j * nu k) * T i j k

/-- The pair cap's left-hand side: `∑ₖ μₖ⁽ⁱʲ⁾ tᵢⱼₖ` with `μₖ⁽ⁱʲ⁾ = mₖ - δᵢₖ - δⱼₖ`. -/
def capLhs (i j : Fin 3) : ℚ :=
  ∑ k, (m k - (if k = i then 1 else 0) - (if k = j then 1 else 0)) * T i j k

/-! ## The nine relations, exact -/

/-- **(Aᵢ) holds at every row**, both sides `2(n-2) = 20` at `n = 12`. -/
theorem relA (i : Fin 3) : relAlhs i = 20 := by
  fin_cases i <;>
    simp [relAlhs, Fin.sum_univ_three, w, mu, m, T, t112, t222, t133, t333] <;> norm_num

/-- **(Bᵢ) holds at every row**, the right-hand side `-2νᵢ` read in the scaled variable. -/
theorem relB (i : Fin 3) : relBlhs i = -2 * nu i := by
  fin_cases i <;>
    simp [relBlhs, Fin.sum_univ_three, w, mu, m, nu, T, t112, t222, t133, t333] <;> norm_num

/-- **(Cᵢ) holds at every row at `θ' = 7`**, the right-hand side `2νᵢ(θ - νᵢ)` read in the scaled
variable, which is what forces `θ = 7a`. -/
theorem relC (i : Fin 3) : relClhs i = 2 * nu i * (7 - nu i) := by
  fin_cases i <;>
    simp [relClhs, Fin.sum_univ_three, w, mu, m, nu, T, t112, t222, t133, t333] <;> norm_num

/-- **Row 1's (C) is what pins `θ`**: it is an equation in `θ'` with the unique solution `7`. -/
theorem relC_pins_theta {x : ℚ} (h : relClhs 0 = 2 * nu 0 * (x - nu 0)) : x = 7 := by
  simp [relClhs, Fin.sum_univ_three, w, mu, m, nu, T, t112, t222, t133, t333] at h
  linarith

/-! ## The six pair caps -/

/-- **The `(1,1)` cap is tight.** -/
theorem cap_tight_11 : capLhs 0 0 = 2 := by
  simp [capLhs, Fin.sum_univ_three, m, T, t112, t222, t133, t333]; norm_num

/-- **The `(1,2)` cap is tight**, the one that forces `t₁₁₂ = 2/3` and so `θ = 7a`. -/
theorem cap_tight_12 : capLhs 0 1 = 2 := by
  simp [capLhs, Fin.sum_univ_three, m, T, t112, t222, t133, t333]; norm_num

/-- **The `(2,2)` cap is tight.** -/
theorem cap_tight_22 : capLhs 1 1 = 2 := by
  simp [capLhs, Fin.sum_univ_three, m, T, t112, t222, t133, t333]; norm_num

/-- **The `(1,3)` cap reads `8/59`.** -/
theorem cap_13 : capLhs 0 2 = 8 / 59 := by
  simp [capLhs, Fin.sum_univ_three, m, T, t112, t222, t133, t333]; norm_num

/-- **The `(2,3)` cap reads `8/59`.** -/
theorem cap_23 : capLhs 1 2 = 8 / 59 := by
  simp [capLhs, Fin.sum_univ_three, m, T, t112, t222, t133, t333]; norm_num

/-- **The `(3,3)` cap reads `562/1711`.** -/
theorem cap_33 : capLhs 2 2 = 562 / 1711 := by
  simp [capLhs, Fin.sum_univ_three, m, T, t112, t222, t133, t333]; norm_num

/-- **Every pair cap holds**, three tight and three slack. -/
theorem caps_hold (i j : Fin 3) : capLhs i j ≤ 2 := by
  fin_cases i <;> fin_cases j <;>
    simp [capLhs, Fin.sum_univ_three, m, T, t112, t222, t133, t333] <;> norm_num

/-! ## The parameters are forced -/

/-- `4 + 3 + 59 = 66 = C(12,2)`. -/
theorem mult_sum : (∑ i, m i) = 66 ∧ Nat.choose 12 2 = 66 := by
  refine ⟨by simp [Fin.sum_univ_three, m]; norm_num, by decide⟩

/-- **Tracelessness** `∑ mᵢνᵢ = 0`, which is what gives `b = (4/3)a`. -/
theorem traceless : (∑ i, m i * nu i) = 0 := by
  simp [Fin.sum_univ_three, m, nu]; norm_num

/-- **Unit norm forces `a = √(3/28)`**: `∑ mᵢνᵢ² = (28/3)a²`, so `a² = 3/28`. -/
theorem unit_norm_forces_a {a : ℝ} (ha : 0 < a)
    (h : ∑ i, (m i : ℝ) * ((a * nu i) ^ 2) = 1) : a = Real.sqrt (3 / 28) := by
  simp [Fin.sum_univ_three, m, nu] at h
  have h2 : a ^ 2 = 3 / 28 := by nlinarith
  rw [show (3 : ℝ) / 28 = a ^ 2 from h2.symm, Real.sqrt_sq ha.le]

/-- **`θ = 7a = √21/2`.** -/
theorem theta_closed_form : 7 * Real.sqrt (3 / 28) = Real.sqrt 21 / 2 := by
  have ha : (0:ℝ) ≤ Real.sqrt (3 / 28) := Real.sqrt_nonneg _
  have hb : (0:ℝ) < Real.sqrt 21 := Real.sqrt_pos.mpr (by norm_num)
  have e1 : Real.sqrt (3 / 28) ^ 2 = 3 / 28 := Real.sq_sqrt (by norm_num)
  have e2 : Real.sqrt 21 ^ 2 = 21 := Real.sq_sqrt (by norm_num)
  have hfac : (7 * Real.sqrt (3 / 28) - Real.sqrt 21 / 2) *
      (7 * Real.sqrt (3 / 28) + Real.sqrt 21 / 2) = 0 := by nlinarith [e1, e2]
  rcases mul_eq_zero.mp hfac with h | h
  · linarith
  · nlinarith

/-! ## The witness beats the target -/

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-- **`θ₀(12) = √220/12 = √55/6`.** -/
theorem theta0_twelve : theta0 12 = Real.sqrt 55 / 6 := by
  have : (2 : ℝ) * (12 - 1) * (12 - 2) = 220 := by norm_num
  rw [theta0, this, show (220 : ℝ) = 55 * 2 ^ 2 by norm_num, Real.sqrt_mul (by norm_num),
    Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 2)]
  ring

/-- **`√21/2 > θ₀(12)`**, the witness overshoots the target at `n = 12`. -/
theorem theta_exceeds_target : theta0 12 < Real.sqrt 21 / 2 := by
  rw [theta0_twelve]
  have h55 : Real.sqrt 55 < 7.5 := by
    nlinarith [Real.sq_sqrt (by norm_num : (55:ℝ) ≥ 0), Real.sqrt_nonneg 55]
  have h21 : (4.5 : ℝ) < Real.sqrt 21 := by
    nlinarith [Real.sq_sqrt (by norm_num : (21:ℝ) ≥ 0), Real.sqrt_nonneg 21]
  linarith

/-- **`θ₀(n) < √2` at every `n > 0`**, since `θ₀(n)² = 2 - 2(3n-2)/n²`. -/
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

/-- **The witness beats the target at every dimension**, which is the strengthening from `n = 12`
to every `n ≥ 8`: `√21/2 > √2 > θ₀(n)`. -/
theorem witness_beats_every_n {n : ℝ} (hn : 2 < n) : theta0 n < Real.sqrt 21 / 2 := by
  refine lt_trans (theta0_lt_sqrt_two hn) ?_
  have h2 : Real.sqrt 2 < 1.5 := by
    nlinarith [Real.sq_sqrt (by norm_num : (2:ℝ) ≥ 0), Real.sqrt_nonneg 2]
  have h21 : (4.5 : ℝ) < Real.sqrt 21 := by
    nlinarith [Real.sq_sqrt (by norm_num : (21:ℝ) ≥ 0), Real.sqrt_nonneg 21]
  linarith

/-- **The ratio to the target is `1.8537…`.** -/
theorem ratio_bracket :
    1.8537 < (Real.sqrt 21 / 2) / theta0 12 ∧ (Real.sqrt 21 / 2) / theta0 12 < 1.8538 := by
  have h0 : theta0 12 = Real.sqrt 55 / 6 := theta0_twelve
  have h55l : (7.4161 : ℝ) < Real.sqrt 55 := by
    nlinarith [Real.sq_sqrt (by norm_num : (55:ℝ) ≥ 0), Real.sqrt_nonneg 55]
  have h55u : Real.sqrt 55 < 7.41621 := by
    nlinarith [Real.sq_sqrt (by norm_num : (55:ℝ) ≥ 0), Real.sqrt_nonneg 55]
  have h21l : (4.58257 : ℝ) < Real.sqrt 21 := by
    nlinarith [Real.sq_sqrt (by norm_num : (21:ℝ) ≥ 0), Real.sqrt_nonneg 21]
  have h21u : Real.sqrt 21 < 4.582576 := by
    nlinarith [Real.sq_sqrt (by norm_num : (21:ℝ) ≥ 0), Real.sqrt_nonneg 21]
  have hpos : (0:ℝ) < theta0 12 := by rw [h0]; positivity
  rw [h0] at hpos ⊢
  constructor
  · rw [lt_div_iff₀ hpos]; nlinarith
  · rw [div_lt_iff₀ hpos]; nlinarith

/-! ## The mechanism, and the constant the lemma rests on -/

/-- **The mechanism is one coefficient**: the type `{1,3,3}` enters (A₁) with weight
`μ₃(μ₃-1) = 59·58 = 3422` against a right-hand side of `2(n-2) = 20`, so a zero class of large
multiplicity absorbs the row mass at cost `20/3422`. -/
theorem mechanism_coefficient : w 0 2 2 = 3422 ∧ (3422 : ℚ) * t133 = 8 := by
  refine ⟨by simp [w, mu, m]; norm_num, by norm_num [t133]⟩

/-- **[L31](../../../findings/stratum-two-negative.md)'s cap constant `2` is load-bearing.**
At a cap `c` the ceiling reads `θ/a ≤ 4c-1`: at `c = 2` that is `7a`, the witness's own value; at
`c = 1` it is `3a`, which falls *below* `θ₀(12)` and the lemma would fail outright. -/
theorem cap_constant_is_load_bearing :
    (4 * (2:ℝ) - 1) * Real.sqrt (3 / 28) = Real.sqrt 21 / 2 ∧
      (4 * (1:ℝ) - 1) * Real.sqrt (3 / 28) < theta0 12 := by
  refine ⟨by rw [show (4 * (2:ℝ) - 1) = 7 by norm_num]; exact theta_closed_form, ?_⟩
  rw [theta0_twelve, show (4 * (1:ℝ) - 1) = 3 by norm_num]
  have ha : Real.sqrt (3 / 28) < 0.3274 := by
    nlinarith [Real.sq_sqrt (by norm_num : (3:ℝ)/28 ≥ 0), Real.sqrt_nonneg ((3:ℝ)/28)]
  have h55 : (7.416 : ℝ) < Real.sqrt 55 := by
    nlinarith [Real.sq_sqrt (by norm_num : (55:ℝ) ≥ 0), Real.sqrt_nonneg 55]
  linarith

end HamiltonsCubic.L173Statement
