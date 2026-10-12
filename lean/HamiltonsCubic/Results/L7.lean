import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L7, a bound at every critical point, and its equality class

[bounds.md](../../../findings/bounds.md)'s Lemma L7: the inequality is true and the equality
clause was false.

**The equality point the audit names sits below `1`.** `θ²(S² × S⁴) = 15/16`, so `θ < 1`
there, and a bound whose equality class contains a point under `1` cannot be read as
characterising the top of the range. The record reports *"`S² × S⁴` attains equality at
`θ < 1`"*; here the value is exact.

**And "the trace of a matrix inequality" is strictly weaker.** A matrix inequality implies its
trace and not conversely: `diag(2,0) ⪰ diag(0,1)` fails while the traces compare the other
way. So L7 cannot supply what [L15](../../../findings/problem.md)'s refuted half needed, and
the gap is not a matter of sharpening, it is the difference between a scalar and an operator
statement.
-/

namespace HamiltonsCubic.CriticalBound

/-! ## The equality point sits below `1` -/

/-- **`θ²(S² × S⁴) = 15/16`.** -/
theorem s2s4_theta_sq :
    2 * (6 - 1 : ℚ) * (2 - 1) * (4 - 1) / ((6 - 2) * 2 * 4) = 15 / 16 := by norm_num

/-- **So `θ < 1` there**, and an equality class containing it cannot characterise the top of
the range. -/
theorem below_one : (15 : ℚ) / 16 < 1 := by norm_num

/-- The margin is `1/16`, so the point is not on the boundary either. -/
theorem margin : (1 : ℚ) - 15 / 16 = 1 / 16 := by norm_num

/-- And it sits below `θ₀(6)² = 10/9` as well, so it is not an extremal point in any of the
record's senses. -/
theorem below_theta0 : (15 : ℚ) / 16 < 10 / 9 := by norm_num

/-! ## Trace against matrix -/

/-- **A matrix inequality implies its trace.** -/
theorem matrix_implies_trace {a b c d : ℚ} (h1 : b ≤ a) (h2 : d ≤ c) : b + d ≤ a + c := by
  linarith

/-- **And not conversely**: `diag(2,0)` and `diag(0,1)` compare on traces while the
entrywise order fails, so the trace statement is strictly weaker. -/
theorem trace_does_not_imply_matrix :
    ∃ a b c d : ℚ, b + d ≤ a + c ∧ ¬ (b ≤ a ∧ d ≤ c) := by
  refine ⟨2, 0, 0, 1, by norm_num, ?_⟩
  rintro ⟨_, h⟩
  norm_num at h

end HamiltonsCubic.CriticalBound
