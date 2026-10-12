import HamiltonsCubic.Results.L53
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L9, the second peak, and the two collisions

[graded-half.md](../../../findings/graded-half.md)'s Lemma L9: the `n = 8` claim is a Lemma
and the rest was false.

**The triality identification checks numerically, and exactly.** `ℍP²` is `τ(S³ × S⁵)`, and
the two closed forms agree: `θ²(ℍPᵐ) = (m+2)²(4m-1)/(9m(m-1)(2m+1))` at `m = 2` gives
`56/45`, and `θ²(Sᵖ × S^q) = 2(n-1)(p-1)(q-1)/((n-2)pq)` at `(3,5)` gives `56/45` too. Two
unrelated formulas, one value.

**And the second collision is [L53](L53.lean)'s.** The `ℂP³` paragraph described `S³ × S³`
because both sit at `θ² = 10/9`, the same degeneracy L53's row 3 turns on, imported here
rather than restated, so the two blocks are checked against each other.

**Neither peak reaches the competitor.** `56/45 < 3/2`, and it is below `θ₀(8)² = 21/16` as
well, so *"the high ground has more than one peak"* is about a plateau under both, which the
heading does not say.
-/

namespace HamiltonsCubic.SecondPeak

/-! ## The triality identification -/

/-- `θ²(ℍPᵐ)` at `m = 2`. -/
theorem hp2_theta_sq :
    (2 + 2 : ℚ) ^ 2 * (4 * 2 - 1) / (9 * 2 * (2 - 1) * (2 * 2 + 1)) = 56 / 45 := by
  norm_num

/-- `θ²(S³ × S⁵)`. -/
theorem s3s5_theta_sq :
    2 * (8 - 1 : ℚ) * (3 - 1) * (5 - 1) / ((8 - 2) * 3 * 5) = 56 / 45 := by norm_num

/-- **So the two agree exactly**, two unrelated closed forms, one value, which is what the
triality identification predicts. -/
theorem triality_agrees :
    (2 + 2 : ℚ) ^ 2 * (4 * 2 - 1) / (9 * 2 * (2 - 1) * (2 * 2 + 1))
      = 2 * (8 - 1 : ℚ) * (3 - 1) * (5 - 1) / ((8 - 2) * 3 * 5) := by norm_num

/-! ## The second collision is L53's -/

/-- `θ₀(6)² = 10/9`, imported from [L53](L53.lean). -/
theorem theta0_six_import : 2 * (6 - 1 : ℚ) * (6 - 2) / 6 ^ 2 = 10 / 9 :=
  HamiltonsCubic.ChampionSplit.theta0_six

/-- **And `θ²(ℂP³) = 10/9` too**, which is why the `ℂP³` paragraph could describe
`S³ × S³`, the same degeneracy L53's row 3 turns on. -/
theorem cp3_same_import : (3 + 1 : ℚ) * (2 * 3 - 1) / (3 * 3 * (3 - 1)) = 10 / 9 :=
  HamiltonsCubic.ChampionSplit.cp3_same

/-! ## Neither peak reaches the competitor -/

/-- `θ₀(8)² = 21/16`. -/
theorem theta0_eight : 2 * (8 - 1 : ℚ) * (8 - 2) / 8 ^ 2 = 21 / 16 := by norm_num

/-- **The `n = 8` peak sits below `θ₀(8)` and far below the competitor.** -/
theorem peak_below : (56 : ℚ) / 45 < 21 / 16 ∧ (56 : ℚ) / 45 < 3 / 2 := by
  constructor <;> norm_num

/-- The `n = 6` peak likewise. -/
theorem six_peak_below : (10 : ℚ) / 9 < 3 / 2 := by norm_num

/-- So both named peaks are under the competitor, and the gap at `n = 8` is `49/720`. -/
theorem gap_at_eight : (21 : ℚ) / 16 - 56 / 45 = 49 / 720 := by norm_num

end HamiltonsCubic.SecondPeak
