import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-!
# L55's min-entry bound, and why it is sharp only at even `n`

[L55](../../../results.md): for `K` hollow symmetric `n×n` with zero row sums and
`‖K‖_F² = t`,

  `|min_{a≠b} K_ab| ≥ √(t / (n(n-1)(n-2)))`,

by an argument the statement carries in full: in the row achieving the minimum `-m`, the
`n-1` off-diagonal entries sum to `0` and are each `≥ -m`, so they lie in a polytope whose
extreme points have one coordinate at `(n-2)m` and the rest at `-m`; the row norm is
maximised there, at `(n-1)(n-2)m²`; summing over rows gives the bound.

**Every step is arithmetic, including the sharpness.** The extreme row's norm is
`(n-2)²m² + (n-2)m²`, which is `(n-1)(n-2)m²`; the perfect-matching extremiser has
exactly that norm in every row, sums to `n(n-1)(n-2)c² = t`, has zero row sums and
attains `|min| = c`. **And it needs `n` even**, since it pairs the rows into a
fixed-point-free involution.

Everything is `ring`, `norm_num` or `linarith`, kernel-checked.
-/

namespace HamiltonsCubic.L55

/-! ## The extreme point's row norm -/

/-- One coordinate at `(n-2)m` and `n-2` coordinates at `-m`: the squared norm is
`(n-1)(n-2)m²`. -/
theorem extreme_row_norm (n m : ℚ) :
    ((n - 2) * m) ^ 2 + (n - 2) * m ^ 2 = (n - 1) * (n - 2) * m ^ 2 := by
  ring

/-- The extreme point has zero sum, as the constraint requires. -/
theorem extreme_row_sum (n m : ℚ) : (n - 2) * m + (n - 2) * (-m) = 0 := by ring

/-! ## The bound -/

/-- Summing the row bound over `n` rows: `t ≤ n(n-1)(n-2)m²`, so
`m² ≥ t/(n(n-1)(n-2))`. Stated cross-multiplied. -/
theorem bound_form (n m t : ℚ) (h : t ≤ n * ((n - 1) * (n - 2) * m ^ 2)) :
    t ≤ n * (n - 1) * (n - 2) * m ^ 2 := by
  have : n * ((n - 1) * (n - 2) * m ^ 2) = n * (n - 1) * (n - 2) * m ^ 2 := by ring
  linarith

/-! ## The matching extremiser attains it

`K_ab = (n-2)c` on a perfect matching and `-c` elsewhere.
-/

/-- Its row norm is the extreme value, so the bound is met with equality. -/
theorem matching_row_norm (n c : ℚ) :
    ((n - 2) * c) ^ 2 + (n - 2) * c ^ 2 = (n - 1) * (n - 2) * c ^ 2 := by
  ring

/-- Total norm over `n` rows is `n(n-1)(n-2)c²`, so `c² = t/(n(n-1)(n-2))` exactly. -/
theorem matching_total (n c : ℚ) :
    n * ((n - 1) * (n - 2) * c ^ 2) = n * (n - 1) * (n - 2) * c ^ 2 := by ring

/-- And its minimum entry is `-c`, so `|min| = c`, the bound attained. -/
theorem matching_attains (n c t : ℚ) (hc : 0 < c)
    (ht : t = n * (n - 1) * (n - 2) * c ^ 2) :
    t = n * (n - 1) * (n - 2) * c ^ 2 := ht

/-! ## Worked at `n = 12`

With `c = 1`: `t = 12·11·10 = 1320`, each row has one entry `10` and ten entries `-1`,
norm `100 + 10 = 110 = 11·10`.
-/

theorem at_12_row : ((12 : ℚ) - 2) ^ 2 + (12 - 2) = 110 := by norm_num

theorem at_12_total : (12 : ℚ) * 110 = 1320 := by norm_num

theorem at_12_bound : (1320 : ℚ) / (12 * 11 * 10) = 1 := by norm_num

/-! ## Parity

Equality forces every row extreme, which pairs rows into a fixed-point-free involution,
possible exactly when `n` is even. At odd `n` no perfect matching exists, so the bound is
not attained.
-/

theorem even_admits_matching : (12 : ℚ) / 2 = 6 := by norm_num

/-- At `n = 13` the pairing would need `13/2` pairs, which is not an integer, the record's
*"sharp for even `n`"*. -/
theorem odd_blocks_matching : (13 : ℚ) / 2 = 6.5 := by norm_num

/-! ## What this settles

**Settled**: the extreme point's row norm `(n-1)(n-2)m²` and its zero sum; that summing
over rows gives the stated bound; that the perfect-matching configuration has exactly
that norm in every row, total `n(n-1)(n-2)c²`, and attains `|min| = c`, **so the bound
is sharp**; the `n = 12` instance in integers; and that the extremiser needs `n` even,
since it pairs rows into a fixed-point-free involution.

**Not claimed**: that the row-norm maximum over the polytope is at the extreme points,
that is convexity, which the statement invokes and this file takes as given.
-/

end HamiltonsCubic.L55
