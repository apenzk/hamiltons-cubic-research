import HamiltonsCubic.Results.L56Statement

set_option linter.style.longLine false

/-!
# L56's multi-block clause: `(S³)⁴` sits between `S³ × S⁹` and `S⁴ × S⁸`

[findings/ungraded-slack.md](../../../findings/ungraded-slack.md), Observation L56, and the canon's clause that
`(S³)⁴` at `0.0580` lies between `S³ × S⁹` and `S⁴ × S⁸`, which the record does not refute. The block says its closed form
"also reproduces the recorded `(S³)⁴` value". **This file types the equal-block case, and below it the unequal `(2,2,8)`**. The equal-block case is `k` unit spheres `S^p`,
`n = kp`, Einstein with `Ric = (p - 1)`, so the Weyl tensor is diagonal with weight `1 - c` within a factor and `-c`
across, `c = (p - 1)/(n - 1)`:

* **`multi_rowSum_zero`**: `(p - 1)(1 - c) - (n - p) c = 0`, the weights are Ricci-flat;
* **`multiGapSq`**: the squared spectral gap, `c² / (k·C(p,2)(1 - c)² + (C(n,2) - k·C(p,2)) c²)`, the smallest modulus
  `c` over the Frobenius norm;
* **`gap_S3_four`**: at `k = 4`, `p = 3`, `gap² = 1/297`, so `gap = 1/√297 = 0.05803`;
* **`multi_between`**: `1/660 < 1/297 < 3/770`, that is `gap(S³×S⁹)² < gap((S³)⁴)² < gap(S⁴×S⁸)²`.

* **`einstein_rowSum_zero`**, **`weights_228`**, **`gap_228`**, **`gap_228_below`**: the correction's unequal `(2, 2, 8)`,
  with the record's Einstein factors (`Ric = 1`), has `gap² = 4/3003`, the recorded `0.036497`, below `S³ × S⁹`'s `1/660`
  and above the floor.

The vertex-entry mechanism, and that the Weyl operator of every Einstein product is the diagonal operator with
these weights, are proved in [L56Weyl.lean](L56Weyl.lean) (`product_weylPart_unique`, `unit_weights`, `vertex_entries`),
and the gap as the normalised smallest vertex modulus in [L56Norm.lean](L56Norm.lean).
-/

namespace HamiltonsCubic.L56Statement

/-- The Einstein constant `c = (p - 1)/(n - 1)` of `k` unit spheres `S^p`, `n = kp`. -/
noncomputable def cMulti (k p : ℝ) : ℝ := (p - 1) / (k * p - 1)

/-- **The weights are Ricci-flat**: within a factor `p - 1` neighbours at `1 - c`, across `n - p` at `-c`. -/
theorem multi_rowSum_zero (k p : ℝ) (hn : k * p - 1 ≠ 0) :
    (p - 1) * (1 - cMulti k p) - (k * p - p) * cMulti k p = 0 := by
  have hc : (k * p - 1) * cMulti k p = p - 1 := by rw [cMulti, mul_div_cancel₀ _ hn]
  have : (p - 1) * (1 - cMulti k p) - (k * p - p) * cMulti k p = (p - 1) - (k * p - 1) * cMulti k p := by ring
  rw [this, hc, sub_self]

/-- The squared spectral gap of `(S^p)^k`: the smallest modulus `c` over the Frobenius norm on `Λ²`. -/
noncomputable def multiGapSq (k p : ℝ) : ℝ :=
  cMulti k p ^ 2 / (k * (p * (p - 1) / 2) * (1 - cMulti k p) ^ 2
    + ((k * p) * (k * p - 1) / 2 - k * (p * (p - 1) / 2)) * cMulti k p ^ 2)

/-- **`gap((S³)⁴)² = 1/297`.** -/
theorem gap_S3_four : multiGapSq 4 3 = 1 / 297 := by
  rw [multiGapSq, cMulti]; norm_num

/-- **The canon's clause**: `gap(S³×S⁹)² < gap((S³)⁴)² < gap(S⁴×S⁸)²`. -/
theorem multi_between : gapSq 3 9 < multiGapSq 4 3 ∧ multiGapSq 4 3 < gapSq 4 8 := by
  rw [gap_S3_four, gap_three_nine, gapSq]; constructor <;> norm_num

/-! ## The correction's unequal `(2, 2, 8)`: Einstein factors

The record's products are Einstein, each factor `S^{p_i}` scaled to `Ric = 1`, so its sectional curvature is
`1/(p_i - 1)`. Then the Weyl weight is `1/(p_i - 1) - 1/(n - 1)` within factor `i` and `-1/(n - 1)` across, and for equal
blocks this is the unit-sphere form above up to scale. -/

/-- **The Einstein weights are Ricci-flat**: within factor `i` there are `p_i - 1` neighbours, across `n - p_i`. -/
theorem einstein_rowSum_zero (p n : ℝ) (hp : p - 1 ≠ 0) (hn : n - 1 ≠ 0) :
    (p - 1) * (1 / (p - 1) - 1 / (n - 1)) + (n - p) * (-(1 / (n - 1))) = 0 := by
  field_simp; ring

/-- **`gap((2,2,8))² = 4/3003`** at `n = 12`: weights `10/11` within the two `S²`, `4/77` within `S⁸`, `-1/11` across,
the smallest modulus `4/77`, and `‖W‖² = 2(10/11)² + 36(1/11)² + 28(4/77)²` over the `66` pairs. -/
theorem gap_228 :
    (4 / 77 : ℝ) ^ 2 / (2 * (10 / 11) ^ 2 + 36 * (1 / 11) ^ 2 + 28 * (4 / 77) ^ 2) = 4 / 3003 := by norm_num

/-- The weights at `(2,2,8)`, `n = 12`, from the Einstein form. -/
theorem weights_228 :
    (1 / (2 - 1) - 1 / (12 - 1) : ℝ) = 10 / 11 ∧ (1 / (8 - 1) - 1 / (12 - 1) : ℝ) = 4 / 77 ∧
      (-(1 / (12 - 1)) : ℝ) = -(1 / 11) := by norm_num

/-- **The correction's clause**: `(2,2,8)` at `gap² = 4/3003` (`0.036497`) falls below the canon's `S³ × S⁹` at `1/660`
(`0.038925`), and stays above the corrected floor `1/2475` at `n = 12`. -/
theorem gap_228_below : (4 / 3003 : ℝ) < gapSq 3 9 ∧ floorSq 12 < 4 / 3003 := by
  rw [gap_three_nine, floor_twelve]; constructor <;> norm_num

end HamiltonsCubic.L56Statement
