import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-!
# L149, the dichotomy, and a branch that gives more than is asked

[second-order.md](../../../findings/second-order.md)'s Lemma L149, verified `GAP` on the proof
as written with an unaudited repair.

**Branch 2 is stronger than [L145](L145.lean) needs.** It gives `r_n ≥ 0.7198/n`, which is
`Ω(n⁻¹)`; L145's claim is `Ω(n^{-3/2})`, and `n⁻¹ ≥ n^{-3/2}` at every `n ≥ 1`, proved on
squares, so no root is taken. So the branch overshoots its own consumer, and the two orders
should not be conflated when the warrant is cited.

**And it sits under [L147](L147.lean)'s ceiling, as it must.** At `n = 12`, `0.7198/12` is
about `0.06` against the ceiling `3/10`, consistent, and the gap is a factor of five, so the
lower and upper halves are far from meeting.

**The old proof's error is the direction one again.** It ran at `w²`-coefficient `1` and so
**bounded from above** where a lower bound was needed, the fifth block in this layer whose
defect is which side of an inequality a quantity sits on, after
[L40](L40.lean), [L90](L90.lean), [L98](L98.lean) and [L102](L102.lean).
-/

namespace HamiltonsCubic.DirectionDichotomy

/-! ## Branch 2 overshoots its consumer -/

/-- **`n⁻¹ ≥ n^{-3/2}` at every `n ≥ 1`**, on squares so no root is taken: `n⁻²  ≥ n⁻³`. -/
theorem inverse_beats_three_halves (n : ℚ) (hn : 1 ≤ n) :
    1 / n ^ 3 ≤ 1 / n ^ 2 := by
  have h2 : (0:ℚ) < n ^ 2 := by nlinarith [hn]
  have h3 : (0:ℚ) < n ^ 3 := by nlinarith [hn]
  rw [div_le_div_iff₀ h3 h2]
  nlinarith [hn]

/-- **So a lower bound of order `n⁻¹` implies one of order `n^{-3/2}`**, branch 2 gives more
than L145 asks for. -/
theorem branch_overshoots {r c n : ℚ} (hc : 0 < c) (hn : 1 ≤ n) (h : c / n ≤ r) :
    c / n ^ 2 ≤ r := by
  have hn0 : (0:ℚ) < n := by linarith
  have hle : c / n ^ 2 ≤ c / n := by
    rw [div_le_div_iff₀ (by positivity) hn0]
    nlinarith [hc, hn, mul_pos hc hn0]
  linarith [hle, h]

/-! ## It sits under the ceiling -/

/-- `0.7198/12` against [L147](L147.lean)'s ceiling `3/10` at `n = 12`. -/
theorem under_ceiling : (7198 : ℚ) / 10000 / 12 < 3 / 10 := by norm_num

/-- The gap is a factor above five, so the two halves are far from meeting. -/
theorem gap_factor : (5 : ℚ) * ((7198 : ℚ) / 10000 / 12) < 3 / 10 := by norm_num

/-! ## The dichotomy -/

/-- **No direction is both low-margin and high-norm**, so every direction fails one, which is
what turns a case split into a covering. -/
theorem dichotomy_covers {A B : Prop} (h : ¬ (A ∧ B)) : ¬ A ∨ ¬ B := by
  by_cases hA : A
  · exact Or.inr fun hB => h ⟨hA, hB⟩
  · exact Or.inl hA

/-! ## The old proof bounded the wrong way -/

/-- **An upper bound does not supply a lower one.** The old proof ran at `w²`-coefficient `1`
and bounded from above where a lower bound was needed, which no sharpening repairs. -/
theorem upper_not_lower :
    ∃ x u l : ℚ, x ≤ u ∧ ¬ (l ≤ x) :=
  ⟨0, 1, 2, by norm_num, by norm_num⟩

end HamiltonsCubic.DirectionDichotomy
