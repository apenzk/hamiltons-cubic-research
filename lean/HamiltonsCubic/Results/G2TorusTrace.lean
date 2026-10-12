import Mathlib
import HamiltonsCubic.Results.TraceThreshold

/-!
# Every positive-definite torus idempotent of `𝔤₂` has trace at least `2`

[The working note](../../../reviews/2026-09-28l-I117-g2-torus.md) on I117, "The trace on `𝔤₂`'s
torus family". Long weights `x i` on the long roots `L_i`, short weights `y i` on the short roots
`S_i`, with `L_i ⟂ S_i`. The short rows of `C # C = C` read
`y_i (1 − σ_i) = x_k y_j + x_j y_k + (4/3) y_j y_k` with
`σ_i = x_j² + x_k² + (4/9) y_i² + (1/9)(y_j² + y_k²)`, and `tr C = tr A + 2 ∑ w` with
`tr A = 2 ∑ x² + (2/3) ∑ y²`.

**Typed**: `row_bound` (the row of the largest short weight bounds its row sum plus `σ` below by
`1`), `weight_lt`, `trace_of_row`, `g2_torus_trace` (so `tr C ≥ 2` at every solution with positive short weights), and
`g2_torus_H` (with `g2_threshold`'s hypotheses, `‖C‖² ≥ 36/49`). **Not typed**: the torus rows
themselves (the product table, Gate 2 [r1884], [r1885]) and the pairing identity, a hypothesis as
in `TraceThreshold`.
-/

namespace HamiltonsCubic.G2TorusTrace

/-- **The row of the largest short weight.** -/
theorem row_bound (a b y0 ya yb : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hy0 : 0 < y0) (hya : 0 ≤ ya)
    (hyb : 0 ≤ yb) (h1 : ya ≤ y0) (h2 : yb ≤ y0)
    (hrow : y0 * (1 - (a ^ 2 + b ^ 2 + 4 / 9 * y0 ^ 2 + 1 / 9 * (ya ^ 2 + yb ^ 2)))
      = b * ya + a * yb + 4 / 3 * ya * yb) :
    1 ≤ a + b + 2 / 3 * (ya + yb) + (a ^ 2 + b ^ 2 + 4 / 9 * y0 ^ 2 + 1 / 9 * (ya ^ 2 + yb ^ 2)) := by
  have hle : b * ya + a * yb + 4 / 3 * ya * yb ≤ y0 * (a + b + 2 / 3 * (ya + yb)) := by
    nlinarith [mul_le_mul_of_nonneg_left h1 hb, mul_le_mul_of_nonneg_left h2 ha,
      mul_le_mul_of_nonneg_left h1 hyb, mul_le_mul_of_nonneg_left h2 hya]
  have := hrow ▸ hle
  nlinarith

/-- A row's bound on the short weight: `y0 < 9`, since the row's right side is positive. -/
theorem weight_lt (a b y0 ya yb : ℝ) (_ha : 0 ≤ a) (_hb : 0 ≤ b) (hy0 : 0 < y0) (hya : 0 < ya)
    (hyb : 0 < yb)
    (hrow : y0 * (1 - (a ^ 2 + b ^ 2 + 4 / 9 * y0 ^ 2 + 1 / 9 * (ya ^ 2 + yb ^ 2)))
      = b * ya + a * yb + 4 / 3 * ya * yb) : y0 < 9 := by
  have hpos : 0 < y0 * (1 - (a ^ 2 + b ^ 2 + 4 / 9 * y0 ^ 2 + 1 / 9 * (ya ^ 2 + yb ^ 2))) := by
    rw [hrow]; positivity
  have h1 := (pos_iff_pos_of_mul_pos hpos).mp hy0
  nlinarith [sq_nonneg a, sq_nonneg b, sq_nonneg ya, sq_nonneg yb]

/-- Every weight in the row's combination carries at least twice as much trace. -/
theorem trace_of_row (a b c y0 ya yb : ℝ) (_ha : 0 ≤ a) (_hb : 0 ≤ b) (hc : 0 ≤ c) (hy0 : 0 < y0)
    (hya : 0 ≤ ya) (hyb : 0 ≤ yb) (h9 : y0 < 9)
    (hG : 1 ≤ a + b + 2 / 3 * (ya + yb) + (a ^ 2 + b ^ 2 + 4 / 9 * y0 ^ 2 + 1 / 9 * (ya ^ 2 + yb ^ 2))) :
    2 ≤ 2 * (a ^ 2 + b ^ 2 + c ^ 2) + 2 / 3 * (y0 ^ 2 + ya ^ 2 + yb ^ 2)
      + 2 * (a + b + c) + 2 * (y0 + ya + yb) := by
  nlinarith [mul_pos hy0 (by linarith : (0 : ℝ) < 9 - y0), sq_nonneg c, sq_nonneg ya,
    sq_nonneg yb]

/-- **The trace is at least `2`.** -/
theorem g2_torus_trace (x0 x1 x2 y0 y1 y2 : ℝ) (hx0 : 0 ≤ x0) (hx1 : 0 ≤ x1) (hx2 : 0 ≤ x2)
    (hy0 : 0 < y0) (hy1 : 0 < y1) (hy2 : 0 < y2)
    (r0 : y0 * (1 - (x1 ^ 2 + x2 ^ 2 + 4 / 9 * y0 ^ 2 + 1 / 9 * (y1 ^ 2 + y2 ^ 2)))
      = x2 * y1 + x1 * y2 + 4 / 3 * y1 * y2)
    (r1 : y1 * (1 - (x0 ^ 2 + x2 ^ 2 + 4 / 9 * y1 ^ 2 + 1 / 9 * (y0 ^ 2 + y2 ^ 2)))
      = x2 * y0 + x0 * y2 + 4 / 3 * y0 * y2)
    (r2 : y2 * (1 - (x0 ^ 2 + x1 ^ 2 + 4 / 9 * y2 ^ 2 + 1 / 9 * (y0 ^ 2 + y1 ^ 2)))
      = x1 * y0 + x0 * y1 + 4 / 3 * y0 * y1) :
    2 ≤ 2 * (x0 ^ 2 + x1 ^ 2 + x2 ^ 2) + 2 / 3 * (y0 ^ 2 + y1 ^ 2 + y2 ^ 2)
      + 2 * (x0 + x1 + x2) + 2 * (y0 + y1 + y2) := by
  by_cases hA : y1 ≤ y0 ∧ y2 ≤ y0
  · have g := row_bound x1 x2 y0 y1 y2 hx1 hx2 hy0 hy1.le hy2.le hA.1 hA.2 r0
    have t := trace_of_row x1 x2 x0 y0 y1 y2 hx1 hx2 hx0 hy0 hy1.le hy2.le
      (weight_lt x1 x2 y0 y1 y2 hx1 hx2 hy0 hy1 hy2 r0) g
    linarith
  by_cases hB : y0 ≤ y1 ∧ y2 ≤ y1
  · have g := row_bound x0 x2 y1 y0 y2 hx0 hx2 hy1 hy0.le hy2.le hB.1 hB.2 r1
    have t := trace_of_row x0 x2 x1 y1 y0 y2 hx0 hx2 hx1 hy1 hy0.le hy2.le
      (weight_lt x0 x2 y1 y0 y2 hx0 hx2 hy1 hy0 hy2 r1) g
    linarith
  have hC : y0 ≤ y2 ∧ y1 ≤ y2 := by
    rcases not_and_or.mp hA with h | h <;> rcases not_and_or.mp hB with h' | h' <;>
      constructor <;> linarith
  have g := row_bound x0 x1 y2 y0 y1 hx0 hx1 hy2 hy0.le hy1.le hC.1 hC.2 r2
  have t := trace_of_row x0 x1 x2 y2 y0 y1 hx0 hx1 hx2 hy2 hy0.le hy1.le
    (weight_lt x0 x1 y2 y0 y1 hx0 hx1 hy2 hy0 hy1 r2) g
  linarith

/-- **H on `𝔤₂`'s torus family.** With the scalar core and Cauchy–Schwarz of `TraceThreshold`,
trace at least `2` gives `‖C‖² ≥ 36/49`, H's `N/(n−2)²` at `n = 9`. -/
theorem g2_torus_H (τ q : ℝ) (hτ : 2 ≤ τ) (hcore : τ - (4 - 5 / 3) * τ ^ 2 / 14 ≤ 5 / 3 * q)
    (hcs : τ ^ 2 ≤ 14 * q) : 36 / 49 ≤ q :=
  TraceThreshold.g2_threshold τ q hcore hcs (by linarith)

/-- Non-vacuity: `I/4` (every weight `1/4`) meets the three short rows. -/
example : (1 / 4 : ℝ) * (1 - ((1 / 4) ^ 2 + (1 / 4) ^ 2 + 4 / 9 * (1 / 4) ^ 2
    + 1 / 9 * ((1 / 4) ^ 2 + (1 / 4) ^ 2))) = 1 / 4 * (1 / 4) + 1 / 4 * (1 / 4)
    + 4 / 3 * (1 / 4) * (1 / 4) := by norm_num

end HamiltonsCubic.G2TorusTrace
