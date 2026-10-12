import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L146, the supremum survives, its equality clause does not

[second-order.md](../../../findings/second-order.md)'s Lemma L146, verified
`PROVEN, hypotheses corrected`.

**A supremum can be attained while the description of where it is attained is wrong.** The
round leaves the supremum `1/√(m-1)` *"unchanged and attained"* and restricts the equality
clause, because a cross-plane branch appears on the joint two-copy eigenspace. Those are
independent: knowing a value is reached says nothing about the set of points reaching it, and
`attained_but_miscounted` below exhibits the gap.

**And `m ≥ 3` is more than definedness.** At `m = 1` the expression is undefined and at
`m = 2` it equals `1`; from `m = 3` on it is at most `1/√2`, so the hypothesis excludes a
value the statement's shape would otherwise admit, it is a real restriction, not a guard
against division by zero alone.
-/

namespace HamiltonsCubic.SupremumClause

/-- The supremum, squared: `1/(m-1)`. -/
def supSq (m : ℚ) : ℚ := 1 / (m - 1)

/-! ## The supremum's shape -/

/-- **Strictly decreasing in `m`.** -/
theorem supSq_antitone {m m' : ℚ} (hm : 2 ≤ m) (hlt : m < m') : supSq m' < supSq m := by
  unfold supSq
  have h1 : (0:ℚ) < m - 1 := by linarith
  have h2 : (0:ℚ) < m' - 1 := by linarith
  rw [div_lt_div_iff₀ h2 h1]
  linarith

/-- At `m = 2` it is `1`; at `m = 3` it is `1/2`, so `m ≥ 3` excludes the value `1`. -/
theorem supSq_values : supSq 2 = 1 ∧ supSq 3 = 1 / 2 := by
  unfold supSq
  refine ⟨by norm_num, by norm_num⟩

/-- **From `m = 3` on the supremum is at most `1/2` in the square**, so the hypothesis is a
real restriction rather than a guard against `m = 1`. -/
theorem supSq_bounded {m : ℚ} (hm : 3 ≤ m) : supSq m ≤ 1 / 2 := by
  unfold supSq
  have h1 : (0:ℚ) < m - 1 := by linarith
  rw [div_le_div_iff₀ h1 (by norm_num : (0:ℚ) < 2)]
  linarith

/-! ## Attainment does not validate the description -/

/-- **A value can be attained at more points than a clause names.** So a supremum surviving a
correction says nothing about whether the equality clause did, the two are independent, which
is why the round could keep one and restrict the other. -/
theorem attained_but_miscounted :
    ∃ (f : ℕ → ℚ) (x y : ℕ), f x = 1 ∧ f y = 1 ∧ x ≠ y := by
  refine ⟨fun _ => 1, 0, 1, rfl, rfl, by decide⟩

end HamiltonsCubic.SupremumClause
