import Mathlib

set_option linter.style.longLine false

/-!
# L56, the spectral-gap ordering of the sphere products, in the corrected closed form

**The canon's statement, quoted verbatim from [results.md](../../../results.md):**

> ##### Observation L56, the named graded families have a floor; the graded set has another
>
> For the two-block sphere products $S^p\times S^q$ at fixed $n=p+q$, the smallest modulus among the vertex entries $-q/(p-1)$, $-p/(q-1)$ and $1$ is $p/(q-1)$, which is $3/(n-4)$ at $p=3$ before normalisation, so the gap is smallest at the most unbalanced factorisation and largest at the balanced one: $0.062994$ at $S^3\times S^7$ for $n=10$ and $0.038925$ at $S^3\times S^9$ for $n=12$. Multi-block products interleave rather than extend the trend, $(S^3)^4$ at $0.0580$ sits between $S^3\times S^9$ and $S^4\times S^8$. The floor is a property of the named families at the dimensions stated; the graded set is wider than the families (Lemma L58) and its floor is a different number.

**And the correction, quoted verbatim from [ungraded-slack.md](../../../findings/ungraded-slack.md), which refutes those two values:**

> $S^3\times S^7$ is **not** the most unbalanced factorisation ($S^2\times S^8$ is) and the floor is $2/\big((n-2)\sqrt{(n-1)(n-3)}\big)$, giving $0.031497$ and $0.020101$ against the recorded $0.062994$ and $0.038925$.
>
> $$\mathrm{gap}(p,q)=\sqrt{\frac{2p(p-1)}{q(q-1)(n-1)(n-2)}}\quad(p<q),\qquad \mathrm{gap}\big(\tfrac n2,\tfrac n2\big)=\frac{\sqrt2\sqrt{n-2}}{n\sqrt{n-1}},$$
>
> strictly increasing in $p$, with the balanced case the strict maximum.
>
> $\mathrm{gap}(\mathbb{CP}^m)^2=\frac{(m-2)^2}{3m(m^2-1)(2m-1)}$ ... **$\mathbb{CP}^{n/2}$ is below the floor at $n=6$, ties exactly at $n=8$, and is above from $n\ge10$**.

## What this file states

The corrected closed forms, and the ordering as the theorem at every `n` that the two reviewers
derived, not as an observation at two dimensions. Squares are used throughout, so no square root
is taken and the comparisons are exact rational arithmetic.

`floor_eq_gap_at_two` is what refutes the canon: the family minimum sits at `p = 2`, and the two
figures the canon reports are the values at `p = 3`, which `gap_strictMono_in_p` places strictly
above. Everything here is proved; there is no `sorry`.

**The multi-block clause** at the canon's `(S³)⁴` is [L56Multi.lean](L56Multi.lean)'s `multi_between`, through
an equal-block closed form, and the correction's unequal `(2,2,8)` at `gap² = 4/3003` is its `gap_228` and
`gap_228_below`.
-/

namespace HamiltonsCubic.L56Statement

/-- `gap(p,q)²` for the two-block sphere product `S^p × S^q` at `n = p + q`, with `p < q`. -/
noncomputable def gapSq (p q : ℝ) : ℝ := 2 * p * (p - 1) / (q * (q - 1) * (p + q - 1) * (p + q - 2))

/-- `gap(n/2, n/2)²` for the balanced product, which the `p < q` form does not cover. -/
noncomputable def balancedGapSq (n : ℝ) : ℝ := 2 * (n - 2) / (n ^ 2 * (n - 1))

/-- The corrected family floor, `(2/((n-2)√((n-1)(n-3))))²`. -/
noncomputable def floorSq (n : ℝ) : ℝ := 4 / ((n - 2) ^ 2 * (n - 1) * (n - 3))

/-- `gap(ℂPᵐ)² = (m-2)²/(3m(m²-1)(2m-1))`. -/
noncomputable def cpGapSq (m : ℝ) : ℝ := (m - 2) ^ 2 / (3 * m * (m ^ 2 - 1) * (2 * m - 1))

/-! ## The floor is the value at `p = 2`, not at `p = 3` -/

/-- **The corrected floor is `gap(2, n-2)`**, which is what makes `S²×S^{n-2}` the most
unbalanced factorisation and refutes the canon's `S³×S^{n-3}`. -/
theorem floor_eq_gap_at_two {n : ℝ} (hn : 3 < n) : floorSq n = gapSq 2 (n - 2) := by
  have h1 : n - 2 ≠ 0 := by linarith
  have h2 : n - 3 ≠ 0 := by linarith
  have h3 : n - 1 ≠ 0 := by linarith
  have hg : gapSq 2 (n - 2) = 4 / ((n - 2) ^ 2 * (n - 1) * (n - 3)) := by
    rw [gapSq]; congr 1 <;> ring
  rw [floorSq, hg]

/-! ## The ordering, as a theorem at every `n` -/

/-- **`gap(p, n-p)²` is strictly increasing in `p`** on `1 ≤ p < p'` with `2p' < n`: the numerator
`2p(p-1)` rises and the factor `q(q-1)` in the denominator falls. -/
theorem gap_strictMono_in_p {n p p' : ℝ} (hp : 1 ≤ p) (hpp : p < p') (hp' : 2 * p' < n)
    (hn : 4 < n) :
    gapSq p (n - p) < gapSq p' (n - p') := by
  have hq : p' < n - p' := by linarith
  have hq1 : 1 < n - p' := by linarith
  have hqp : n - p' < n - p := by linarith
  have hd' : (0 : ℝ) < (n - p') * (n - p' - 1) * (p' + (n - p') - 1) * (p' + (n - p') - 2) := by
    have : p' + (n - p') - 1 = n - 1 := by ring
    rw [this]
    have : p' + (n - p') - 2 = n - 2 := by ring
    rw [this]
    exact mul_pos (mul_pos (mul_pos (by linarith) (by linarith)) (by linarith)) (by linarith)
  have hd : (0 : ℝ) < (n - p) * (n - p - 1) * (p + (n - p) - 1) * (p + (n - p) - 2) := by
    have : p + (n - p) - 1 = n - 1 := by ring
    rw [this]
    have : p + (n - p) - 2 = n - 2 := by ring
    rw [this]
    exact mul_pos (mul_pos (mul_pos (by linarith) (by linarith)) (by linarith)) (by linarith)
  rw [gapSq, gapSq, div_lt_div_iff₀ hd hd']
  have e1 : p + (n - p) - 1 = n - 1 := by ring
  have e2 : p + (n - p) - 2 = n - 2 := by ring
  have e3 : p' + (n - p') - 1 = n - 1 := by ring
  have e4 : p' + (n - p') - 2 = n - 2 := by ring
  rw [e1, e2, e3, e4]
  have hnum : 2 * p * (p - 1) < 2 * p' * (p' - 1) := by nlinarith
  have hqq : (n - p') * (n - p' - 1) < (n - p) * (n - p - 1) := by nlinarith
  have hn1 : (0 : ℝ) < (n - 1) * (n - 2) := by nlinarith
  nlinarith [mul_pos (show (0:ℝ) < n - p' by linarith) (show (0:ℝ) < n - p' - 1 by linarith),
    mul_nonneg (mul_nonneg (by linarith : (0:ℝ) ≤ 2 * p) (by linarith : (0:ℝ) ≤ p - 1)) hn1.le]

/-- **The balanced product is the strict maximum.** At every unbalanced integer split of an even
`n` (where `p + 2 ≤ q`), the balanced gap strictly exceeds it. -/
theorem balanced_strict_max {n p : ℝ} (hn : 6 ≤ n) (hp : 2 ≤ p) (hpq : p + 2 ≤ n - p) :
    gapSq p (n - p) < balancedGapSq n := by
  have hq : (0 : ℝ) < n - p := by linarith
  have hq1 : (0 : ℝ) < n - p - 1 := by linarith
  have hd : (0 : ℝ) < (n - p) * (n - p - 1) * (p + (n - p) - 1) * (p + (n - p) - 2) := by
    have e1 : p + (n - p) - 1 = n - 1 := by ring
    have e2 : p + (n - p) - 2 = n - 2 := by ring
    rw [e1, e2]
    exact mul_pos (mul_pos (mul_pos (by linarith) (by linarith)) (by linarith)) (by linarith)
  have hb : (0 : ℝ) < n ^ 2 * (n - 1) := by nlinarith
  have key : n ^ 2 * (p * (p - 1)) < (n - 2) ^ 2 * ((n - p) * (n - p - 1)) := by
    obtain ⟨d, hd0, rfl⟩ : ∃ d : ℝ, 0 ≤ d ∧ n = 2 * p + 2 + d :=
      ⟨n - 2 * p - 2, by linarith, by ring⟩
    have hp2 : (0 : ℝ) ≤ p - 2 := by linarith
    nlinarith [mul_nonneg hd0 hp2, mul_nonneg hd0 hd0, mul_nonneg (mul_nonneg hd0 hd0) hp2,
      mul_nonneg (mul_nonneg hd0 hp2) hp2, mul_nonneg (mul_nonneg hd0 hd0) hd0,
      sq_nonneg d, sq_nonneg (p - 2), mul_nonneg hp2 hp2]
  rw [gapSq, balancedGapSq, div_lt_div_iff₀ hd hb]
  have e1 : p + (n - p) - 1 = n - 1 := by ring
  have e2 : p + (n - p) - 2 = n - 2 := by ring
  rw [e1, e2]
  nlinarith [key, mul_pos (show (0:ℝ) < n - 1 by linarith) (show (0:ℝ) < n - 2 by linarith)]

/-! ## The canon's two figures, and where they actually sit -/

/-- **The canon's `0.062994` at `S³×S⁷` is `gap(3,7) = 1/√252` exactly.** -/
theorem gap_three_seven : gapSq 3 7 = 1 / 252 := by rw [gapSq]; norm_num

/-- **The canon's `0.038925` at `S³×S⁹` is `gap(3,9) = 1/√660` exactly.** -/
theorem gap_three_nine : gapSq 3 9 = 1 / 660 := by rw [gapSq]; norm_num

/-- **The corrected floor at `n = 10` is `1/1008`**, whose root is `0.031497`. -/
theorem floor_ten : floorSq 10 = 1 / 1008 := by rw [floorSq]; norm_num

/-- **The corrected floor at `n = 12` is `1/2475`**, whose root is `0.020101`. -/
theorem floor_twelve : floorSq 12 = 1 / 2475 := by rw [floorSq]; norm_num

/-- **The refutation at `n = 10`**: the floor sits strictly below the canon's reported minimum. -/
theorem canon_not_minimal_ten : floorSq 10 < gapSq 3 7 := by
  rw [floor_ten, gap_three_seven]; norm_num

/-- **The refutation at `n = 12`**, the same way. -/
theorem canon_not_minimal_twelve : floorSq 12 < gapSq 3 9 := by
  rw [floor_twelve, gap_three_nine]; norm_num

/-! ## Where `ℂP^{n/2}` sits against the corrected floor -/

/-- **`ℂP³` is strictly below the floor at `n = 6`.** -/
theorem cp_below_at_six : cpGapSq 3 < floorSq 6 := by rw [cpGapSq, floorSq]; norm_num

/-- **`ℂP⁴` ties the floor exactly at `n = 8`.** -/
theorem cp_ties_at_eight : cpGapSq 4 = floorSq 8 := by rw [cpGapSq, floorSq]; norm_num

/-- **`ℂPᵐ` is strictly above the floor at every `m ≥ 5`, i.e. every even `n ≥ 10`**, so the
corrected floor stands at every even `n ≥ 8`. -/
theorem cp_above_from_ten {m : ℝ} (hm : 5 ≤ m) : floorSq (2 * m) < cpGapSq m := by
  have h1 : (0 : ℝ) < m := by linarith
  have hda : (0 : ℝ) < (2 * m - 2) ^ 2 * (2 * m - 1) * (2 * m - 3) := by
    have : (0 : ℝ) < 2 * m - 2 := by linarith
    have : (0 : ℝ) < 2 * m - 1 := by linarith
    have : (0 : ℝ) < 2 * m - 3 := by linarith
    positivity
  have hdb : (0 : ℝ) < 3 * m * (m ^ 2 - 1) * (2 * m - 1) := by nlinarith
  rw [floorSq, cpGapSq]
  rw [show (2 * m - 2 : ℝ) ^ 2 * (2 * m - 1) * (2 * m - 3)
      = (2 * m - 2) ^ 2 * (2 * m - 1) * (2 * m - 3) from rfl]
  rw [div_lt_div_iff₀ hda hdb]
  nlinarith [sq_nonneg (m - 5), sq_nonneg (m - 4), sq_nonneg m, sq_nonneg (m - 2),
    mul_nonneg (by linarith : (0:ℝ) ≤ m - 5) (by linarith : (0:ℝ) ≤ m - 1)]

/-! ## The hypotheses are not empty -/

/-- **A witness for `balanced_strict_max`**: `n = 12`, `p = 2`, the most unbalanced split. -/
example : gapSq 2 (12 - 2) < balancedGapSq 12 :=
  balanced_strict_max (n := 12) (p := 2) (by norm_num) (by norm_num) (by norm_num)
