import Mathlib

set_option linter.style.longLine false

/-!
# L47, the dimension lemma for symmetric spaces, stated as the arithmetic it is

**The record's statement, quoted verbatim from [results.md](../../../results.md):**

> ##### Lemma L47, the dimension lemma for symmetric spaces
>
> For a compact irreducible symmetric space of rank $\ge2$ **with $W\ne0$**, and for $\mathbb{OP}^2$, normalised to Einstein constant $\tfrac12$ so that $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$ (Lemma L46), Cauchy–Schwarz gives $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$, and that dimension bound implies $\lVert W\rVert^2\ge\frac16$, i.e. $\theta\le\sqrt{3/2}$, each space by a nonnegative-coefficient certificate. **$W\ne0$ is load-bearing and is not Lemma L46's $\lambda\ne0$**: $S^n$ has $\lambda=\tfrac12$, $W=0$ and $\theta$ undefined. *The Cauchy–Schwarz step needs only $\operatorname{rank}R\le\dim\mathfrak h$ and $\operatorname{tr}R=n/4$, and is **sharp**, equality holds on every simple-isotropy space.* Among the irreducible spaces equality holds only at $\mathbb{CP}^2$, **modulo the monotonicity of the two rank-one closed forms on $m\ge2$, which is owed**: the record establishes their minima on a five-point scan. **The certificate polynomials and their family assignments live in a script and in no prose file.** The rank-one spaces other than $\mathbb{OP}^2$ are $\mathbb{CP}^m$ at Lemma L10, $\mathbb{HP}^m$ at Observation L5, and $S^n$ and $\mathbb{RP}^n$, where $W=0$.

## What this file states, and what it leaves outside

The lemma's mathematical content is one implication between real numbers, from the two facts
`rank R ≤ dim 𝔥` and `tr R = n/4`, through Cauchy–Schwarz, to `‖W‖² ≥ 1/6` and `θ ≤ √(3/2)`,
and that implication is stated and proved here in full, at general `n`, with no `sorry`.

**The quantifier over symmetric spaces is not stated here.** Ranging over compact irreducible
symmetric spaces of rank `≥ 2` would need a formalisation of symmetric spaces, and the per-family
certificate polynomials that discharge the dimension hypothesis live in
`scripts/route-b/b_symmetric_dimension_lemma.py`, and [L47Cert.lean](L47Cert.lean) transcribes
them, generated from the script's tables, as `cert_*` and `exc_*`. The dimension bound appears here
as a hypothesis of the implication, which is the role the record's own proof gives it.

**The monotonicity the record marks as owed is discharged here for the minima**, which is the use
the equality clause makes of it: `cp_floor` and `hp_floor` prove that the two rank-one closed
forms stay at or above their `m = 2` values on the whole of `m ≥ 2`, so the record's five-point
scan is replaced by a proof at every `m`.
-/

namespace HamiltonsCubic.L47Statement

open Finset

/-! ## The Cauchy–Schwarz step -/

/-- **Cauchy–Schwarz on a support of size at most `h`.** If the eigenvalues of `R` are carried by
a set `s` of at most `h` indices and sum to `tr R`, then `(tr R)² ≤ h · ‖R‖²`. This is the only
place the record's `rank R ≤ dim 𝔥` and `tr R = n/4` enter. -/
theorem trace_sq_le {ι : Type*} (s : Finset ι) (lam : ι → ℝ) (h : ℝ) (hh : (s.card : ℝ) ≤ h) :
    (∑ i ∈ s, lam i) ^ 2 ≤ h * ∑ i ∈ s, lam i ^ 2 := by
  have hcs := sq_sum_le_card_mul_sum_sq (s := s) (f := lam)
  have hnn : (0 : ℝ) ≤ ∑ i ∈ s, lam i ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  nlinarith [hcs, hnn]

/-- **The form the lemma uses**: with `tr R = n/4` and support at most `h > 0`, the Frobenius
norm is at least `(n/4)²/h`. -/
theorem norm_sq_ge {ι : Type*} (s : Finset ι) (lam : ι → ℝ) (n h : ℝ) (hh : 0 < h)
    (hcard : (s.card : ℝ) ≤ h) (htr : ∑ i ∈ s, lam i = n / 4) :
    (n / 4) ^ 2 / h ≤ ∑ i ∈ s, lam i ^ 2 := by
  have := trace_sq_le s lam h hcard
  rw [htr] at this
  rw [div_le_iff₀ hh]
  linarith

/-! ## The dimension bound, cleared -/

/-- The cleared form of the dimension bound, `P(n,h) = 3n²(n-1) - 2(7n-4)h`. -/
noncomputable def P (n h : ℝ) : ℝ := 3 * n ^ 2 * (n - 1) - 2 * (7 * n - 4) * h

/-- **`P(n,h) ≥ 0` and `h ≤ 3n²(n-1)/(2(7n-4))` are the same condition**, for `n > 4/7`. -/
theorem P_nonneg_iff {n h : ℝ} (hn : 4 / 7 < n) :
    0 ≤ P n h ↔ h ≤ 3 * n ^ 2 * (n - 1) / (2 * (7 * n - 4)) := by
  have hpos : 0 < 2 * (7 * n - 4) := by linarith
  rw [P, le_div_iff₀ hpos]
  constructor <;> intro h' <;> linarith

/-! ## The implication the lemma is -/

/-- **The dimension bound implies the Weyl floor.** With the Einstein normalisation's
`‖W‖² = ‖R‖² - n/(8(n-1))`, Cauchy–Schwarz's `‖R‖² ≥ (n/4)²/h`, and `h ≤ 3n²(n-1)/(2(7n-4))`,
one gets `‖W‖² ≥ 1/6` at every `n > 1`. -/
theorem weyl_floor {n h R2 : ℝ} (hn : 1 < n) (hh : 0 < h)
    (hCS : (n / 4) ^ 2 / h ≤ R2)
    (hdim : 2 * (7 * n - 4) * h ≤ 3 * n ^ 2 * (n - 1)) :
    1 / 6 ≤ R2 - n / (8 * (n - 1)) := by
  have hn1 : (0 : ℝ) < n - 1 := by linarith
  -- `(n/4)²/h ≥ (7n-4)/(24(n-1))`, by the dimension bound.
  have key : (7 * n - 4) / (24 * (n - 1)) ≤ (n / 4) ^ 2 / h := by
    rw [div_le_div_iff₀ (by linarith) hh]
    nlinarith [sq_nonneg n, hh.le]
  -- and `(7n-4)/(24(n-1)) - n/(8(n-1)) = 1/6` identically.
  have id6 : (7 * n - 4) / (24 * (n - 1)) - n / (8 * (n - 1)) = 1 / 6 := by
    field_simp
    ring
  linarith

/-- **The step is exact**: at `h = 3n²(n-1)/(2(7n-4))` with Cauchy–Schwarz tight, `‖W‖²` is
exactly `1/6`, so all the loss in the lemma sits at Cauchy–Schwarz. -/
theorem weyl_floor_sharp {n : ℝ} (hn : 1 < n) :
    (n / 4) ^ 2 / (3 * n ^ 2 * (n - 1) / (2 * (7 * n - 4))) - n / (8 * (n - 1)) = 1 / 6 := by
  have hn1 : (0 : ℝ) < n - 1 := by linarith
  have hn0 : (0 : ℝ) < n := by linarith
  have h7 : (0 : ℝ) < 7 * n - 4 := by linarith
  field_simp
  ring

/-! ## From the floor to `θ ≤ √(3/2)` -/

/-- **`√(3/2)` is `√6/2`**, the form the conversion produces. -/
theorem sqrt_three_halves : Real.sqrt (3 / 2) = Real.sqrt 6 / 2 := by
  rw [show (3 : ℝ) / 2 = 6 * (1 / 2) ^ 2 by norm_num, Real.sqrt_mul (by norm_num),
    Real.sqrt_sq (by norm_num : (0:ℝ) ≤ 1 / 2)]
  ring

/-- **The floor gives the cubic bound.** At Einstein constant `1/2`, `θ = (1/2)/‖W‖`, so
`‖W‖² ≥ 1/6` reads `θ ≤ √(3/2)`. -/
theorem theta_le_of_floor {W2 : ℝ} (hW : 1 / 6 ≤ W2) :
    (1 / 2) / Real.sqrt W2 ≤ Real.sqrt (3 / 2) := by
  have h6 : (0 : ℝ) < 1 / 6 := by norm_num
  have hWpos : 0 < W2 := lt_of_lt_of_le h6 hW
  have hs : Real.sqrt (1 / 6) ≤ Real.sqrt W2 := Real.sqrt_le_sqrt hW
  have hspos : 0 < Real.sqrt (1 / 6) := Real.sqrt_pos.mpr h6
  have hval : Real.sqrt (1 / 6) = 1 / Real.sqrt 6 := by
    simp [one_div, Real.sqrt_inv]
  have h6pos : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  calc (1 / 2) / Real.sqrt W2 ≤ (1 / 2) / Real.sqrt (1 / 6) :=
        div_le_div_of_nonneg_left (by norm_num) hspos hs
    _ = Real.sqrt 6 / 2 := by rw [hval]; field_simp
    _ = Real.sqrt (3 / 2) := sqrt_three_halves.symm

/-! ## The rank-one closed forms, and the monotonicity the record marks as owed -/

/-- The complex projective closed form `‖W‖²(ℂPᵐ) = 3m(m-1)/(4(m+1)(2m-1))`. -/
noncomputable def cpNormSq (m : ℝ) : ℝ := 3 * m * (m - 1) / (4 * (m + 1) * (2 * m - 1))

/-- The quaternionic projective closed form `‖W‖²(ℍPᵐ) = 9m(2m+1)(m-1)/(4(m+2)²(4m-1))`. -/
noncomputable def hpNormSq (m : ℝ) : ℝ := 9 * m * (2 * m + 1) * (m - 1) / (4 * (m + 2) ^ 2 * (4 * m - 1))

/-- **`ℂPᵐ` meets the floor at `m = 2` and stays above it on all of `m ≥ 2`**, proved at every
real `m ≥ 2` rather than on a five-point scan. -/
theorem cp_floor {m : ℝ} (hm : 2 ≤ m) : 1 / 6 ≤ cpNormSq m := by
  have hd : (0 : ℝ) < 4 * (m + 1) * (2 * m - 1) := by nlinarith
  rw [cpNormSq, le_div_iff₀ hd]
  nlinarith [sq_nonneg (m - 2), sq_nonneg m]

/-- **And `ℂP²` attains it exactly**, which is the equality clause's witness. -/
theorem cp_at_two : cpNormSq 2 = 1 / 6 := by rw [cpNormSq]; norm_num

/-- **`ℍPᵐ` is at or above `45/224` on all of `m ≥ 2`**, with the minimum at `m = 2`. -/
theorem hp_floor {m : ℝ} (hm : 2 ≤ m) : 45 / 224 ≤ hpNormSq m := by
  have hd : (0 : ℝ) < 4 * (m + 2) ^ 2 * (4 * m - 1) := by nlinarith [sq_nonneg (m + 2)]
  rw [hpNormSq, le_div_iff₀ hd]
  nlinarith [sq_nonneg (m - 2), sq_nonneg m, sq_nonneg (m + 2)]

/-- **And `ℍP²` attains `45/224`.** -/
theorem hp_at_two : hpNormSq 2 = 45 / 224 := by rw [hpNormSq]; norm_num

/-- **`45/224 > 1/6`, so no `ℍPᵐ` ties `ℂP²`**, the equality clause's exclusion of the second
rank-one family. -/
theorem hp_above_cp : 1 / 6 < (45 : ℝ) / 224 := by norm_num

/-! ## The hypotheses are not empty -/

/-- **A witness for `weyl_floor`'s hypotheses**, so the implication is not vacuous: at `n = 12`,
`h = 10` and `‖R‖² = 1` every hypothesis holds, and the conclusion follows. -/
example : (1 : ℝ) / 6 ≤ 1 - 12 / (8 * (12 - 1)) :=
  weyl_floor (n := 12) (h := 10) (R2 := 1) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
