import HamiltonsCubic.Results.L2

/-!
# Warning W5, the diagonal maximum is not the global one

> `Θₙ ≤ M(n)`, strictly at the small dimensions: `M(4) = √(3/2)` and `M(6) ≥ √(3/2)` against
> `Θ₄ = 0.866` and `Θ₆ = 1.0541`, both values of padded `W_{ℂP²}`; no upper bound on `M(6)`
> is on the record (r649, r1941).

The warning records **two sightings in consecutive audits**, with one cause: the
file wanting the global maximum had no symbol for it and reached for the
nearest.

**The strictness is [L2](L2.lean)'s threshold read at two points.** `Θₙ² < 3/2`
is `n² - 12n + 8 < 0`, which holds exactly on `4 ≤ n ≤ 11`, so it holds at
`n = 4` and `n = 6` and needs no separate computation. The decimals `0.866` and
`1.0541` are `√3/2` and `√(10/9)`, and both comparisons are rational once
squared.
-/

namespace HamiltonsCubic.W5

open HamiltonsCubic.L2

/-- `Θ₄² = 3/4`, the square of `0.866…`. -/
theorem theta0Sq_four : theta0Sq 4 = 3 / 4 := by unfold theta0Sq; norm_num

/-- `Θ₆² = 10/9`, the square of `1.0541…`. -/
theorem theta0Sq_six : theta0Sq 6 = 10 / 9 := by unfold theta0Sq; norm_num

/-- **Strict at `n = 4`**, and it is the threshold theorem rather than a
separate fact: `4² - 12·4 + 8 = -24 < 0`. -/
theorem strict_four : theta0Sq 4 < 3 / 2 := by
  rw [theta0Sq_four]; norm_num

/-- **Strict at `n = 6`**: `6² - 12·6 + 8 = -28 < 0`. -/
theorem strict_six : theta0Sq 6 < 3 / 2 := by
  rw [theta0Sq_six]; norm_num

/-- And the general form the two are instances of: the diagonal maximum falls
strictly short of `√(3/2)` exactly on `4 ≤ n ≤ 11`, by [L2](L2.lean). -/
theorem strict_iff {n : ℤ} (h4 : 4 ≤ n) : n ^ 2 - 12 * n + 8 < 0 ↔ n ≤ 11 := by
  constructor
  · intro h
    by_contra hc
    exact absurd h (not_lt.mpr (le_of_lt (threshold_pos (by omega))))
  · exact threshold_neg h4

end HamiltonsCubic.W5
