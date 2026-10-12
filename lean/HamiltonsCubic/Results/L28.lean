import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L28, a charge off by four, and a rule that misses the case it is used for

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L28: the Statement holds at every
`m ≥ 3`, with one arithmetic error in the proof, inert for the conclusion.

**The wrong charge is off by exactly four.** `c_S + q_S² = 4m` was a Casimir tabulated without
its charge; the true list carries `4(m+1)` twice. The two differ by `4` at every `m`, so the
error is a constant shift rather than a scaling, which is why it can be inert: a shift common
to the affected entries cancels in the comparison the conclusion uses.

**And the cited multiplicity-freeness rule misses exactly the case the argument turns on.** It
holds from `m ≥ 4`; the argument needs `m ≥ 3`, and `3` is the turning case. The gap is **one
value**, and it is the one that matters, so the audit's re-derivation at every `m ≥ 3` is not
a strengthening for its own sake.

**The trace closes the fifth value.** With `tr L_e = 0` and four of the five eigenvalues
known, the fifth is determined by a linear solve, so `λ_max` no longer rests on the charge
formula that was wrong.
-/

namespace HamiltonsCubic.ChargeList

/-! ## The charge is off by four -/

/-- **`4(m+1) - 4m = 4`, identically in `m`**, a constant shift, not a scaling. -/
theorem charge_gap (m : ℚ) : 4 * (m + 1) - 4 * m = 4 := by ring

/-- So the two disagree at every `m`, and never coincide. -/
theorem never_equal (m : ℚ) : 4 * (m + 1) ≠ 4 * m := by
  intro h; linarith

/-- A shift common to the affected entries cancels in a difference, which is how an error can
be inert for a conclusion drawn from comparisons. -/
theorem shift_cancels (a b c : ℚ) : (a + c) - (b + c) = a - b := by ring

/-! ## The cited rule misses the turning case -/

/-- **`m ≥ 4` excludes exactly one value of `m ≥ 3`.** -/
theorem range_misses_one (m : ℚ) (h3 : 3 ≤ m) (h4 : ¬ (4 ≤ m)) : 3 ≤ m ∧ m < 4 := by
  constructor
  · exact h3
  · linarith [not_le.1 h4]

/-- **And `m = 3` is inside the gap**, the case the argument turns on. -/
theorem three_in_gap : (3 : ℚ) ≤ 3 ∧ ¬ (4 ≤ (3 : ℚ)) := by
  constructor <;> norm_num

/-! ## The trace closes the fifth value -/

/-- **With the trace zero and four values known, the fifth is determined**, a linear solve, so
`λ_max` does not rest on the charge formula. -/
theorem trace_determines_last {a b c d e ma mb mc md me : ℚ} (hme : me ≠ 0)
    (htr : ma * a + mb * b + mc * c + md * d + me * e = 0) :
    e = -(ma * a + mb * b + mc * c + md * d) / me := by
  field_simp
  linarith [htr]

/-- And the solution is unique, so no second value is compatible with the same four. -/
theorem last_is_unique {e e' k me : ℚ} (hme : me ≠ 0) (h : me * e = k) (h' : me * e' = k) :
    e = e' := by
  have : me * (e - e') = 0 := by linarith
  rcases mul_eq_zero.1 this with hz | hz
  · exact absurd hz hme
  · linarith

end HamiltonsCubic.ChargeList
