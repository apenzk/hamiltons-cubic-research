import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# L168, the two pinned moments of `F_u`, and the check they run on L21's table

[route-a.md](../../../findings/route-a.md)'s Lemma L168. `tr(F_u) = 0` and
`tr(F_u²) = ((n-1)(2n-1)/4)‖u‖²` at every `u ∈ Weyl_n`, whence
`‖T‖² = ((n-1)(2n-1)/4)·dim Weyl_n`; and [L21](../../../findings/route-a.md)'s tabulated
spectrum satisfies both identically in `m = n - 4`.

**What is checked here.** The four block traces read off the tabled spectra; the weighted
collapse as a polynomial identity in `m`; its value at `n = 12`; the third moment's value;
and the table's failure at `n = 6`.

**What is not.** The two Schur steps, which need `Weyl_n` absolutely irreducible as an
`O(n)`-representation, and the inherited Killing constant.
-/

namespace HamiltonsCubic.PinnedMoments

/-! ## The four block traces, from the tabled spectra -/

/-- Trivial block: `2·1 + 6·(1/36) + 6·0 + 3·(1/9) + 2·(1/4) + 1·1 = 4`, over 20 entries. -/
theorem trace_trivial :
    2 * (1 : ℚ) + 6 * (1 / 36) + 6 * 0 + 3 * (1 / 9) + 2 * (1 / 4) + 1 * 1 = 4 := by norm_num

/-- Vector block: `4·(1/4) + 12·0 + 4·(1/4) = 2`, over 20 entries. -/
theorem trace_vector : 4 * (1 / 4 : ℚ) + 12 * 0 + 4 * (1 / 4) = 2 := by norm_num

/-- `Λ²` block: `2·(1/36) + 3·0 + 1·(1/9) = 1/6`, over 6 entries. -/
theorem trace_lambda2 : 2 * (1 / 36 : ℚ) + 3 * 0 + 1 * (1 / 9) = 1 / 6 := by norm_num

/-- `S²₀` block: `6·(1/36) + 1·0 + 3·(1/9) = 1/2`, over 10 entries. -/
theorem trace_s2 : 6 * (1 / 36 : ℚ) + 1 * 0 + 3 * (1 / 9) = 1 / 2 := by norm_num

/-- Every block is separately traceless, which is more than the identity demands. -/
theorem first_moments_vanish :
    2 * (-1 : ℚ) + 6 * (-1/6) + 3 * (1/3) + 2 * (1/2) + 1 = 0 ∧
    4 * (-1/2 : ℚ) + 4 * (1/2) = 0 ∧
    2 * (-1/6 : ℚ) + 1 * (1/3) = 0 ∧
    6 * (-1/6 : ℚ) + 3 * (1/3) = 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## The weighted collapse -/

/-- **`4 + 2m + m(m-1)/12 + (m+2)(m-1)/4 = (2m+7)(m+3)/6`**, identically in `m`. -/
theorem collapse (m : ℚ) :
    4 + 2 * m + m * (m - 1) / 12 + (m + 2) * (m - 1) / 4 = (2 * m + 7) * (m + 3) / 6 := by
  ring

/-- Substituting `m = n - 4` gives `(2n-1)(n-1)/6`. -/
theorem collapse_in_n (n : ℚ) :
    (2 * (n - 4) + 7) * ((n - 4) + 3) / 6 = (2 * n - 1) * (n - 1) / 6 := by ring

/-- **And `θ*² = 3/2` times that is the Killing constant `(n-1)(2n-1)/4`.** -/
theorem matches_killing (n : ℚ) :
    3 / 2 * ((2 * n - 1) * (n - 1) / 6) = (n - 1) * (2 * n - 1) / 4 := by ring

/-- At `n = 12` both sides read `253/4`. -/
theorem at_twelve : (12 - 1 : ℚ) * (2 * 12 - 1) / 4 = 253 / 4 := by norm_num

/-! ## The third moment carries no check -/

/-- The table's third moment is `θ*³·(2n² - 15n + 1)/36`. **Nothing fixes its coefficients
independently**, and the invariant cubics on `Weyl_n` form a *two*-dimensional space, not a
line, so "invariant cubic hence a multiple of `P(u)`" was a non-sequitur. -/
theorem third_moment (m : ℚ) :
    -(2 / 3 : ℚ) + m * 0 + m * (m - 1) / 2 * (1 / 36) + (m + 2) * (m - 1) / 2 * (1 / 12)
      = (2 * m ^ 2 + m - 27) / 36 := by ring

/-- In `n`: `(2m² + m - 27)/36 = (2n² - 15n + 1)/36` at `m = n - 4`. -/
theorem third_moment_in_n (n : ℚ) :
    (2 * (n - 4) ^ 2 + (n - 4) - 27) / 36 = (2 * n ^ 2 - 15 * n + 1) / 36 := by ring

/-! ## The table's range is `n ≥ 7` -/

/-- **At `m = 2` the `V_{(2,2)}` row's dimension formula returns `-2`** where the space is
zero, so the six rows total `86` against `dim Weyl₆ = 84`. The identities hold at `n = 6` by
Schur; it is the check that is vacuous there. -/
theorem table_fails_at_six :
    (2 : ℚ) * (2 + 1) * (2 + 2) * (2 - 3) / 12 = -2 ∧
      (6 : ℚ) * (6 + 1) * (6 + 2) * (6 - 3) / 12 = 84 := by
  refine ⟨by norm_num, by norm_num⟩

/-- The dimension polynomial itself, which pins the multiplicity column, a sharper
transcription check than either moment, and one the block never ran. -/
theorem dimension_polynomial (n : ℚ) :
    n * (n + 1) * (n + 2) * (n - 3) / 12
      = (n ^ 4 - 7 * n ^ 2 - 6 * n) / 12 := by ring

end HamiltonsCubic.PinnedMoments
