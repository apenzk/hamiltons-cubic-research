import Mathlib.Tactic

/-!
# The Ky Fan bracket cap: the three-slot bounds behind `κ₆ = 8`

[reviews/2026-09-23-I73c-summed-pairs.md](../../../reviews/2026-09-23-I73c-summed-pairs.md), section 9.

**The claim, quoted from the note**: "for $k=3$ it is $4$, attained by the triangle and by the star
$K_{1,3}$ ... while the configurations with a $\pm$ pair or an $s_a^2$ slot reach $2+\sqrt2$ and
$2+\sqrt3$." A sum over three distinct slots of `−ad_X²`'s spectrum is at most `4 ‖s‖²`, so the top
six eigenvalues, each slot twice, sum to at most `8`.

## What is typed here

* All nineteen three-slot configuration classes, both maximisers (triangle and star) among them,
  each the polynomial inequality `slot sum ≤ 4 Σ s²` over the angles it touches, closed by
  `nlinarith` from explicit squares. The enumeration of the classes is in the section heading the
  last ten.
* Ky Fan's maximum principle is [KyFanPrinciple.lean](KyFanPrinciple.lean)'s `kyFan_sum_le` and the root slots are
  [RootSlots.lean](RootSlots.lean) and L240's slot basis; the list of configurations is by hand.
-/

namespace HamiltonsCubic.Results

theorem slot3_triangle (a b c : ℝ) :
    (a + b) ^ 2 + (a + c) ^ 2 + (b + c) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c)]

theorem slot3_star (a b c d : ℝ) :
    (a + b) ^ 2 + (a + c) ^ 2 + (a + d) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  nlinarith [sq_nonneg (a - 3 * b), sq_nonneg (a - 3 * c), sq_nonneg (a - 3 * d)]

theorem slot3_path (a b c d : ℝ) :
    (a + b) ^ 2 + (b + c) ^ 2 + (c + d) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (c - d), sq_nonneg a, sq_nonneg d]

theorem slot3_path_edge (a b c d e : ℝ) :
    (a + b) ^ 2 + (b + c) ^ 2 + (d + e) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg (d - e), sq_nonneg a, sq_nonneg c]

theorem slot3_matching (a b c d e f : ℝ) :
    (a + b) ^ 2 + (c + d) ^ 2 + (e + f) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (c - d), sq_nonneg (e - f)]

/-- A `±` pair on `(a,b)` and a third slot sharing `a`: at most `4 Σ s²`. The configuration's exact
maximum `2 + √2`, a value from [r1122](../../../reviews/REVIEW_r1122.md)'s screen, is [L237Maxima.lean](L237Maxima.lean)'s
`pm_edge_le` and `pm_edge_attained`. -/
theorem slot3_pm_edge (a b c : ℝ) :
    (a + b) ^ 2 + (a - b) ^ 2 + (a + c) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - c), sq_nonneg b]

/-- A `±` pair and a disjoint slot. -/
theorem slot3_pm_disjoint (a b c d : ℝ) :
    (a + b) ^ 2 + (a - b) ^ 2 + (c + d) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  nlinarith [sq_nonneg (c - d)]

/-- Odd `n`: a path `P₃` with an `s_a²` slot at its centre: at most `4 Σ s²`. The configuration's exact
maximum `2 + √3`, stated in the L239/L240 block of [second-order.md](../../../findings/second-order.md), is
[L237Maxima.lean](L237Maxima.lean)'s `kernel_le` and `kernel_attained`. -/
theorem slot3_path_loop (a b c : ℝ) :
    (a + b) ^ 2 + (a + c) ^ 2 + a ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - 2 * b), sq_nonneg (a - 2 * c), sq_nonneg (b - c)]

/-- An edge with both endpoint loops, `3 < 4`. -/
theorem slot3_edge_loops (a b : ℝ) : (a + b) ^ 2 + a ^ 2 + b ^ 2 ≤ 4 * (a ^ 2 + b ^ 2) := by
  nlinarith [sq_nonneg (a - b)]

/-! ### The other ten classes

Three slots are chosen from the `+` edges `(s_a+s_b)²`, the `−` edges `(s_a−s_b)²` and, at odd `n`,
the loops `s_a²`. Up to relabelling, and up to switching the sign of an angle (which turns a `−`
edge into a `+` edge on every forest, so each tree theorem above covers all its sign patterns),
there are nineteen classes: six with no loop and no `±` pair (the two triangles, star, `P₄`,
`P₃ ∪ K₂`, `3K₂`), two with a `±` pair, seven with one loop, three with two loops, one with three. -/

/-- The unbalanced triangle, one `−` edge, which no sign switch removes. -/
theorem slot3_triangle_unbalanced (a b c : ℝ) :
    (a + b) ^ 2 + (a + c) ^ 2 + (b - c) ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b + c)]

/-- A `±` pair with a loop on one of its vertices. -/
theorem slot3_pm_loop_on (a b : ℝ) :
    (a + b) ^ 2 + (a - b) ^ 2 + a ^ 2 ≤ 4 * (a ^ 2 + b ^ 2) := by
  nlinarith [sq_nonneg a, sq_nonneg b]

/-- A `±` pair with a loop elsewhere. -/
theorem slot3_pm_loop_off (a b c : ℝ) :
    (a + b) ^ 2 + (a - b) ^ 2 + c ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg a, sq_nonneg b, sq_nonneg c]

/-- A path `P₃` centred at `b` with a loop at the end `a`. -/
theorem slot3_path_loop_end (a b c : ℝ) :
    (a + b) ^ 2 + (b + c) ^ 2 + a ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg a, sq_nonneg c]

/-- A path `P₃` with a loop off it. -/
theorem slot3_path_loop_off (a b c d : ℝ) :
    (a + b) ^ 2 + (b + c) ^ 2 + d ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (b - c), sq_nonneg a, sq_nonneg c, sq_nonneg d]

/-- Two disjoint edges with a loop on a vertex of one. -/
theorem slot3_edges_loop_on (a b c d : ℝ) :
    (a + b) ^ 2 + (c + d) ^ 2 + a ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (c - d), sq_nonneg a, sq_nonneg b]

/-- Two disjoint edges with a loop off both. -/
theorem slot3_edges_loop_off (a b c d e : ℝ) :
    (a + b) ^ 2 + (c + d) ^ 2 + e ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (c - d), sq_nonneg e]

/-- An edge with a loop at one endpoint and one loop off it. -/
theorem slot3_edge_loop_on_off (a b c : ℝ) :
    (a + b) ^ 2 + a ^ 2 + c ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg a, sq_nonneg c]

/-- An edge with two loops off it. -/
theorem slot3_edge_loops_off (a b c d : ℝ) :
    (a + b) ^ 2 + c ^ 2 + d ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg c, sq_nonneg d]

/-- Three loops. -/
theorem slot3_loops (a b c : ℝ) : a ^ 2 + b ^ 2 + c ^ 2 ≤ 4 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  nlinarith [sq_nonneg a, sq_nonneg b, sq_nonneg c]

/-- **The corollary's arithmetic**: seven eigenvectors with every pair at the cap `2` give a row sum
`6 · 2 = 12`, above `κ₆ = 2 · 4 = 8`. -/
theorem l173_row_exceeds : (8 : ℝ) < 6 * 2 := by norm_num

/-- **Section 10: an equal-angle rank-`4` element has top-six sum exactly `6` at unit norm.** Its
angles `(x, x)` give slot values `(2x)²` twice and kernel couplings `x²`, four of them in the top six:
`2(2x)² + 4x² = 6 · (2x²)`. -/
theorem equal_angle_top6 (x : ℝ) : 2 * (x + x) ^ 2 + 4 * x ^ 2 = 6 * (x ^ 2 + x ^ 2) := by ring

/-- **And equal angles are load-bearing**: at angles `(2, 1)` (unnormalised, `x² + y² = 5`) the top six
at `n ≥ 6` are `(x+y)²` twice and the kernel coupling `x²` four times, `2·9 + 4·4 = 34 > 6·5`. -/
theorem rank4_top6_fails : 2 * ((2 : ℝ) + 1) ^ 2 + 4 * 2 ^ 2 > 6 * (2 ^ 2 + 1 ^ 2) := by norm_num

/-- **The triangle-realised seven-frame totals at most `44`, below the `54.064` that closes L173's
ray**: one `κ₆`-extremal row of `8` and six equal-angle rank-`4` rows of at most `6`. -/
theorem triangle_frame_total : (8 : ℝ) + 6 * 6 = 44 ∧ (44 : ℝ) < 54 := by norm_num

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.slot3_triangle
#print axioms HamiltonsCubic.Results.slot3_star
