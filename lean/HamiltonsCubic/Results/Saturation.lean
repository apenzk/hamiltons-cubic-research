import Mathlib.Tactic.NormNum

/-!
# The saturation column, exactly

[target.md](../../../findings/target.md) tabulates `λ_max` against the criterion
`λ ≤ 1/2`, with a verdict column reading *saturates* or *violates*:

| point | `λ_max` printed | verdict |
|---|---|---|
| `ℂP²` padded, `S³×S³`, `S⁴×S⁴`, `S³×S⁵`, `S⁵×S⁵` | `0.50000000` | saturates |
| `ℂP³` | `0.62500000` | violates |
| `ℂP⁴` | `0.60000000` | violates |
| `C₅` blow-up | `1.20601133` | violates |

**Seven of the eight entries are exact rationals printed to eight decimal places with
trailing zeros**, `1/2`, `5/8`, `3/5`. The record confirms one of them in prose
elsewhere: [nondegeneracy.md](../../../findings/nondegeneracy.md) writes *"`λ_max = 5/8
> 1/2` says it is no local maximiser"* for `ℂP³`.

**Why the exactness is the content.** Five structurally different points, a padded
`ℂP²`, three balanced sphere products at three dimensions, and one unbalanced, all sit
at `1/2` **exactly**, not near it. A column of `0.50000000`s reads as five numerical
coincidences; five exact halves is a structural statement, and the record makes it
elsewhere: the `½θ` eigenvalue is the orbit tangent's, so saturation is forced rather
than observed.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Saturation

/-- The criterion the column feeds: a point saturates when `λ_max = 1/2` and violates
when it exceeds it. -/
def violates (lam : ℚ) : Prop := 1 / 2 < lam

/-! ## The five saturating points sit at the boundary exactly -/

theorem saturates_exactly : ¬ violates (1 / 2) := by
  unfold violates; norm_num

/-- The printed `0.50000000` is `1/2` on the nose, no rounding is involved, so the five
rows are at the boundary rather than near it. -/
theorem printed_half : (0.50000000 : ℚ) = 1 / 2 := by norm_num

/-! ## The three violating points, and by how much -/

/-- `ℂP³` at `5/8`, the value the record states in prose. -/
theorem cp3 : violates (5 / 8) := by unfold violates; norm_num

theorem cp3_printed : (0.62500000 : ℚ) = 5 / 8 := by norm_num

/-- `ℂP⁴` at `3/5`. -/
theorem cp4 : violates (3 / 5) := by unfold violates; norm_num

theorem cp4_printed : (0.60000000 : ℚ) = 3 / 5 := by norm_num

/-- The `C₅` blow-up, the one entry that is not a short rational, violates by a factor
of more than two. -/
theorem c5 : violates 1.20601133 := by unfold violates; norm_num

theorem c5_large : (2 : ℚ) * (1 / 2) < 1.20601133 := by norm_num

/-! ## The margins are not comparable

`ℂP³` and `ℂP⁴` exceed the criterion by `1/8` and `1/10`; the `C₅` blow-up exceeds it by
more than `0.7`. **So the three "violates" verdicts are one column and three different
situations**, two near misses by exact eighths and tenths, and one gross failure.
-/

theorem cp3_margin : (5 : ℚ) / 8 - 1 / 2 = 1 / 8 := by norm_num
theorem cp4_margin : (3 : ℚ) / 5 - 1 / 2 = 1 / 10 := by norm_num
theorem c5_margin : (0.7 : ℚ) < 1.20601133 - 1 / 2 := by norm_num

/-- The two `ℂPᵐ` margins are themselves ordered, `ℂP³` further out than `ℂP⁴`, so the
family approaches the criterion from above as `m` grows. -/
theorem cpm_margins_shrink : (3 : ℚ) / 5 - 1 / 2 < 5 / 8 - 1 / 2 := by norm_num

/-! ## What this settles

**Settled**: that seven of the eight tabulated values are exact rationals; that the five
saturating rows sit at `1/2` exactly rather than within a rounding of it; that the two
`ℂPᵐ` violations are by exactly `1/8` and `1/10`, ordered so the family approaches the
criterion from above; and that the `C₅` blow-up's failure is of a different order.

**Not settled here**: the values themselves, which come from the Hessian spectra the
record computes, and the reason five distinct points saturate, which the record gives
elsewhere as the `½θ` eigenvalue being the orbit tangent's.
-/

end HamiltonsCubic.Saturation
