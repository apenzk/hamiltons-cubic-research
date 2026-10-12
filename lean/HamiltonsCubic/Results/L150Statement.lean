import Mathlib

set_option linter.style.longLine false

/-!
# L150, WITHDRAWN: it is post F50's chain with post F50's surviving term deleted

The record's block, quoted verbatim from
[second-order.md](../../../findings/second-order.md):

> #### Lemma L150, WITHDRAWN: it is post F50's chain with post F50's surviving term deleted
>
> *Recorded and withdrawn 2026-09-03. **Gate 2: [r454](../../../reviews/REVIEW_r454.md) REFUTED it
> as a route**, the algebra is right and the consequence was already refuted, in this file, 230
> lines above where it was written.*
>
> **And it was strictly weaker than the incumbent it duplicated.** Post F50 keeps `Σ ≤ 3m₄ − ½σ²`;
> L150's step `½(3S₂ − S₁²) ≤ (3/2)S₂` discards the `−½σ²`. *F50 closes with the instruction a
> successor needs and this one ignored: **use the identity, not the mass alone.*** At every in-band
> witness the true `Σ` is exactly `0`, so the discarded term carried the whole content.

The block records only the withdrawal, so L150's own statement is taken from its Gate 2 review,
[r454](../../../reviews/REVIEW_r454.md), which quotes it:

> | 1 | the boxed chain `Σ = ½(3S₂ − S₁²) ≤ (3/2)S₂ ≤ 3m₄`, with its three tightness conditions |
> **CONFIRMED**, correct algebra, correct normalisation |
> | 3 | *"it suffices that no four indices carry half the Frobenius mass of `M`"*, the reduction as
> I18's named input | **REFUTED** |
> | 7 | *"a hollow `4×4` with zero row sums and `A+B+C=0` saturates every step"* | **CONFIRMED but
> understated**, the whole four-supported family saturates, automatically |
>
> - **L150's stated sufficient condition, `m₄ < ½` at every four-subset, is false at `S⁵ × S⁴³`**,
>   a pure critical point, `n = 48 ≥ 12`, `θ = 1.263631 > √(3/2) = 1.2247`. Its `(4,0)` four-subsets
>   carry `50.12%` of the mass.
> - **L150's whole chain stops concluding at `S⁵ × S⁶⁶`**, and the failure is permanent:
>   `3m₄/θ² → 9/8` as `q → ∞` at `p = 5`, so **no constant repairs it**.

## The objects

On a four-subset `S = {i,j,k,l}` of a hollow symmetric `M` normalised by `∑_{a<b} M_ab² = 1`, the
three perfect matchings give `A = M_ij + M_kl`, `B = M_ik + M_jl`, `C = M_il + M_jk`; `σ = A+B+C`
is the sum of all six entries, `S₂ = A²+B²+C²`, `m₄ = ∑_{{a,b}⊂S} M_ab²` is the four-set's
Frobenius mass, and post F50's identity is `Σ = (3/2)S₂ − ½σ²`, taken here as the definition of `Σ`.

## What this file types

* `step_one`, `step_two`, `chain`, L150's boxed chain, and the three tightness conditions;
* `discarded_term`, the exact quantity the second step drops, `½σ²`;
* `f50_surviving` and `f50_strictly_stronger`, post F50's `Σ ≤ 3m₄ − ½σ²`, and that it implies
  L150's chain rather than the other way round;
* `L150`, the lemma itself: `m₄ < ½` together with the band `θ² ≥ 3/2` gives `Σ < θ²`, hence the
  four-set clause `Σ ≠ θ²`;
* `hollow_zero_row_sum_saturates`, r454's claim 7, that a hollow symmetric `4×4` with zero row sums
  saturates all three steps automatically, with `σ = 0` and `Σ = 3m₄`;
* `hypothesis_fails_at_S5xS43`, `chain_fails_at_S5xS66`, `no_constant_repairs`, the refutation's
  recorded arithmetic;
* `L24_does_not_apply`, r454's claim 4, at `S² × S⁴`.

## What is NOT typed here

* **That the recorded numerals are the values of `m₄` and `θ²` at `S⁵ × S⁴³`, `S⁵ × S⁶⁶` and
  `S² × S⁴`.** Those came from r454's screen on tensors built from the criticality equation; only
  the inequalities between the recorded numbers are checked here.
* **The `L₁₂₁`-to-`L_e` translation** that turns `Σ ≠ θ²` into I18's four-set clause, and
  [Lemma L130](../../../findings/diagonal-half.md)(i)'s theorem that no `m₄`-only reduction can
  work, which is what makes the withdrawal permanent rather than a repairable slip.
-/

namespace HamiltonsCubic.L150Statement

variable (Mij Mkl Mik Mjl Mil Mjk : ℝ)

/-! ## The objects on a four-subset -/

/-- The `{ij},{kl}` matching sum. -/
def A : ℝ := Mij + Mkl

/-- The `{ik},{jl}` matching sum. -/
def B : ℝ := Mik + Mjl

/-- The `{il},{jk}` matching sum. -/
def C : ℝ := Mil + Mjk

/-- `σ = A + B + C`, the sum of all six entries of the four-subset. -/
def sig : ℝ := A Mij Mkl + B Mik Mjl + C Mil Mjk

/-- `S₂ = A² + B² + C²`. -/
def S2 : ℝ := (A Mij Mkl) ^ 2 + (B Mik Mjl) ^ 2 + (C Mil Mjk) ^ 2

/-- `m₄`, the four-subset's Frobenius mass. -/
def m4 : ℝ := Mij ^ 2 + Mkl ^ 2 + Mik ^ 2 + Mjl ^ 2 + Mil ^ 2 + Mjk ^ 2

/-- `Σ = (3/2)S₂ − ½σ²`, post F50's identity, taken as the definition. -/
noncomputable def Sig : ℝ := 3 / 2 * S2 Mij Mkl Mik Mjl Mil Mjk - 1 / 2 * (sig Mij Mkl Mik Mjl Mil Mjk) ^ 2

/-- `Σ = ½(3S₂ − S₁²)`: the two ways the record writes the same identity. -/
theorem Sig_eq : Sig Mij Mkl Mik Mjl Mil Mjk
    = 1 / 2 * (3 * S2 Mij Mkl Mik Mjl Mil Mjk - (sig Mij Mkl Mik Mjl Mil Mjk) ^ 2) := by
  rw [Sig]; ring

/-! ## L150's boxed chain -/

/-- **Step one**, `½(3S₂ − S₁²) ≤ (3/2)S₂`, and it is an equality exactly when `σ = 0`. -/
theorem step_one : Sig Mij Mkl Mik Mjl Mil Mjk ≤ 3 / 2 * S2 Mij Mkl Mik Mjl Mil Mjk := by
  rw [Sig]
  nlinarith [sq_nonneg (sig Mij Mkl Mik Mjl Mil Mjk)]

/-- **The term step one discards**, named exactly: it is `½σ²`. -/
theorem discarded_term :
    3 / 2 * S2 Mij Mkl Mik Mjl Mil Mjk - Sig Mij Mkl Mik Mjl Mil Mjk
      = 1 / 2 * (sig Mij Mkl Mik Mjl Mil Mjk) ^ 2 := by
  rw [Sig]; ring

theorem step_one_tight_iff :
    Sig Mij Mkl Mik Mjl Mil Mjk = 3 / 2 * S2 Mij Mkl Mik Mjl Mil Mjk
      ↔ sig Mij Mkl Mik Mjl Mil Mjk = 0 := by
  rw [Sig]
  constructor
  · intro h
    have : (sig Mij Mkl Mik Mjl Mil Mjk) ^ 2 = 0 := by linarith
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  · intro h; rw [h]; ring

/-- **Step two**, `(3/2)S₂ ≤ 3m₄`, from `(x+y)² ≤ 2(x²+y²)` on each of the three matchings. -/
theorem step_two : 3 / 2 * S2 Mij Mkl Mik Mjl Mil Mjk ≤ 3 * m4 Mij Mkl Mik Mjl Mil Mjk := by
  rw [S2, m4, A, B, C]
  nlinarith [sq_nonneg (Mij - Mkl), sq_nonneg (Mik - Mjl), sq_nonneg (Mil - Mjk)]

/-- Step two is tight exactly when each matching is balanced. -/
theorem step_two_tight (h1 : Mij = Mkl) (h2 : Mik = Mjl) (h3 : Mil = Mjk) :
    3 / 2 * S2 Mij Mkl Mik Mjl Mil Mjk = 3 * m4 Mij Mkl Mik Mjl Mil Mjk := by
  rw [S2, m4, A, B, C, h1, h2, h3]; ring

/-- **The chain.** `Σ ≤ 3m₄`. -/
theorem chain : Sig Mij Mkl Mik Mjl Mil Mjk ≤ 3 * m4 Mij Mkl Mik Mjl Mil Mjk :=
  le_trans (step_one _ _ _ _ _ _) (step_two _ _ _ _ _ _)

/-! ## Post F50's surviving form, and why L150 is strictly weaker -/

/-- **Post F50 keeps the term**: `Σ ≤ 3m₄ − ½σ²`. -/
theorem f50_surviving :
    Sig Mij Mkl Mik Mjl Mil Mjk
      ≤ 3 * m4 Mij Mkl Mik Mjl Mil Mjk - 1 / 2 * (sig Mij Mkl Mik Mjl Mil Mjk) ^ 2 := by
  have h := step_two Mij Mkl Mik Mjl Mil Mjk
  rw [Sig]; linarith

/-- **And it implies L150's chain**, so L150 adds nothing: the two differ by exactly `½σ² ≥ 0`. -/
theorem f50_strictly_stronger :
    (3 * m4 Mij Mkl Mik Mjl Mil Mjk - 1 / 2 * (sig Mij Mkl Mik Mjl Mil Mjk) ^ 2)
      ≤ 3 * m4 Mij Mkl Mik Mjl Mil Mjk := by
  nlinarith [sq_nonneg (sig Mij Mkl Mik Mjl Mil Mjk)]

/-! ## The lemma -/

/-- **LEMMA L150, as stated.** In band (`θ² ≥ 3/2`), a four-subset carrying under half the
Frobenius mass has `Σ < θ²`, hence `Σ ≠ θ²`, which is I18's four-set clause there. The algebra is
correct; what the record refutes is its use as a route. -/
theorem L150 (theta : ℝ) (hband : 3 / 2 ≤ theta ^ 2)
    (hm4 : m4 Mij Mkl Mik Mjl Mil Mjk < 1 / 2) :
    Sig Mij Mkl Mik Mjl Mil Mjk < theta ^ 2 ∧ Sig Mij Mkl Mik Mjl Mil Mjk ≠ theta ^ 2 := by
  have hc := chain Mij Mkl Mik Mjl Mil Mjk
  have hlt : Sig Mij Mkl Mik Mjl Mil Mjk < theta ^ 2 := by linarith
  exact ⟨hlt, ne_of_lt hlt⟩

/-! ## r454's claim 7: the hollow zero-row-sum `4×4` saturates every step automatically -/

/-- A hollow symmetric `4×4` with zero row sums has each matching balanced and `σ = 0`, so **all
three steps are equalities at once** and `Σ = 3m₄`, no hypothesis beyond hollowness and zero row
sums, which is r454's "understated" verdict. -/
theorem hollow_zero_row_sum_saturates
    (h1 : Mij + Mik + Mil = 0)
    (h2 : Mij + Mjk + Mjl = 0)
    (h3 : Mik + Mjk + Mkl = 0)
    (h4 : Mil + Mjl + Mkl = 0) :
    Mij = Mkl ∧ Mik = Mjl ∧ Mil = Mjk ∧ sig Mij Mkl Mik Mjl Mil Mjk = 0
      ∧ Sig Mij Mkl Mik Mjl Mil Mjk = 3 * m4 Mij Mkl Mik Mjl Mil Mjk := by
  have e1 : Mij = Mkl := by linarith
  have e2 : Mik = Mjl := by linarith
  have e3 : Mil = Mjk := by linarith
  refine ⟨e1, e2, e3, ?_, ?_⟩
  · rw [sig, A, B, C]; linarith
  · rw [Sig, sig, S2, m4, A, B, C]
    rw [← e1, ← e2, ← e3]
    nlinarith [h1]

/-! ## The refutation's arithmetic -/

/-- **L150's hypothesis fails at `S⁵ × S⁴³`.** `n = 48` is in band, `θ² = 1.596764 ≥ 3/2`, and the
four-subset carries `m₄ = 0.501203 ≥ ½`. -/
theorem hypothesis_fails_at_S5xS43 :
    (3 / 2 : ℚ) ≤ 1.596764 ∧ ¬ ((0.501203 : ℚ) < 1 / 2) := by
  norm_num

/-- **The chain stops concluding at `S⁵ × S⁶⁶`**: `3m₄ = 1.598758` exceeds `θ² = 1.598595`. -/
theorem chain_fails_at_S5xS66 : ¬ ((1.598758 : ℚ) < 1.598595) := by norm_num

/-- **No constant repairs it.** Along `S⁵ × S^q` the ratio `3m₄/θ²` tends to `3·(3/5)/(8/5) = 9/8`,
which exceeds `1`. -/
theorem no_constant_repairs : 3 * (3 / 5 : ℚ) / (8 / 5) = 9 / 8 ∧ (1 : ℚ) < 9 / 8 := by
  norm_num

/-! ## r454's claim 4: L24 is a maximality statement and I18 quantifies over pure critical points -/

/-- **`Σ > θ²` occurs at a pure critical point.** At `S² × S⁴` with a `(2,2)` block at `μ = 2/3`,
`Σ = (16/9)θ²` with `θ² = 0.9375`, so `Σ = 5/3 > θ²`, which is why L24's `Σ ≤ θ²` at maximisers
does not cover the range I18 quantifies over. -/
theorem L24_does_not_apply :
    (16 / 9 : ℚ) * 0.9375 = 5 / 3 ∧ (0.9375 : ℚ) < 5 / 3 := by norm_num

/-- **And the saturating family is out of band**, so it carries no concentration content: its only
critical orbit sits at `θ = √3/2`, and `(√3/2)² = 3/4 < 3/2`. -/
theorem saturating_family_out_of_band : (3 / 4 : ℚ) < 3 / 2 := by norm_num

/-! ## A witness, so nothing above is vacuous -/

/-- The hypotheses of `L150` are satisfiable: a four-subset with `m₄ = 6/100 < ½` in band. -/
example : m4 0.1 0.1 0.1 0.1 0.1 0.1 < 1 / 2 ∧ (3 / 2 : ℝ) ≤ (Real.sqrt (3 / 2)) ^ 2 := by
  constructor
  · rw [m4]; norm_num
  · rw [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 3 / 2)]

/-- And the hollow zero-row-sum saturator is a nonzero object: `x = 1, y = -1, z = 0`. -/
example : (1 : ℝ) + (-1) + 0 = 0 ∧ Sig 1 1 (-1) (-1) 0 0 = 3 * m4 1 1 (-1) (-1) 0 0 := by
  refine ⟨by norm_num, ?_⟩
  rw [Sig, S2, m4, sig, A, B, C]; norm_num

end HamiltonsCubic.L150Statement
