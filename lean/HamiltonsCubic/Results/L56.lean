import Mathlib

/-!
# L56, the sphere-product spectral gap: the ordering, not the values

**The split is the record's own.** Both reviewers *refuted the values* and
*derived the ordering*, so the decimals are not formalised and the closed form
is.

`gap(p,q)² = 2p(p-1) / (q(q-1)(n-1)(n-2))` for `p < q`, `n = p + q`. It is the
smallest nonzero modulus of the normalised `Λ²` spectrum, **the spectral gap,
not a distance to the target**, which the block never says and which reverses
the reading if taken the other way.

Proved here: the ordering is strictly increasing in `p`, so the *most unbalanced*
split is the floor; the two quoted figures are the exact algebraic numbers
`1/252` and `1/660` rather than the recorded decimals; and the corrected floor
at `S² × S^{n-2}` has the closed form the audit put in its place.

The balanced case carries **its own formula**, the `p < q` form does not extend
to `p = q`, which is why the block prints two.
-/

namespace HamiltonsCubic.L56

/-- `gap(p,q)²` at `p < q`, with `n = p + q`. -/
noncomputable def gapSq (p q : ℝ) : ℝ :=
  2 * p * (p - 1) / (q * (q - 1) * (p + q - 1) * (p + q - 2))

/-- The balanced case, which the `p < q` form does not cover. -/
noncomputable def gapSqBalanced (n : ℝ) : ℝ := 2 * (n - 2) / (n ^ 2 * (n - 1))

/-- **The two figures the block records as decimals are exact.** `S³ × S⁷`. -/
theorem gapSq_three_seven : gapSq 3 7 = 1 / 252 := by unfold gapSq; norm_num

/-- `S³ × S⁹`. -/
theorem gapSq_three_nine : gapSq 3 9 = 1 / 660 := by unfold gapSq; norm_num

/-- **The corrected floor.** The audit replaced `S³ × S⁷` as the most unbalanced
split by `S² × S^{n-2}`, whose gap is `2 / ((n-2)√((n-1)(n-3)))`, here as its
square. -/
theorem gapSq_two_floor {n : ℝ} (h : 4 < n) :
    gapSq 2 (n - 2) = 4 / ((n - 2) ^ 2 * (n - 3) * (n - 1)) := by
  have h1 : n - 2 ≠ 0 := by intro hc; nlinarith
  have h2 : n - 3 ≠ 0 := by intro hc; nlinarith
  have h3 : n - 1 ≠ 0 := by intro hc; nlinarith
  unfold gapSq
  rw [show (2:ℝ) + (n - 2) - 1 = n - 1 by ring, show (2:ℝ) + (n - 2) - 2 = n - 2 by ring,
    show n - 2 - 1 = n - 3 by ring]
  field_simp
  ring

/-- **The ordering, at every `n`.** The gap is strictly increasing in `p`, so the
most unbalanced split is the floor and the balanced one the maximum. Stated in
cleared form, the denominators being positive on the range. -/
theorem gap_strictMono {n a b : ℝ} (ha : 2 ≤ a) (hab : a < b) (hb : 2 * b < n) :
    a * (a - 1) * ((n - b) * (n - b - 1)) < b * (b - 1) * ((n - a) * (n - a - 1)) := by
  have hb2 : 2 ≤ b := by linarith
  have hnb : 2 < n - b := by linarith
  have hna : b < n - a := by linarith
  have h1 : a * (a - 1) < b * (b - 1) := by nlinarith
  have h2 : (0:ℝ) < (n - b) * (n - b - 1) := by nlinarith
  have h3 : (n - b) * (n - b - 1) < (n - a) * (n - a - 1) := by nlinarith
  have h4 : (0:ℝ) < a * (a - 1) := by nlinarith
  nlinarith [mul_lt_mul_of_pos_left h3 h4, mul_lt_mul_of_pos_right h1 h2]

end HamiltonsCubic.L56
