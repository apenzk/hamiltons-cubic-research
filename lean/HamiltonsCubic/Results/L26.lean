import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L26, the missing exception, and why it is the only one

[nondegeneracy.md](../../../findings/nondegeneracy.md)'s Lemma L26: the body is exact and one
clause was missing an exception, namely `(p,q) ≠ (3,4)`.

**The overtaking condition factors, and that is what makes the exception unique.** Comparing
this family's `μ = (p+q-2)/(2(p-1)(q-1))` against `λ_max = (q-2)/(2(q-1))` clears to

`3p + 2q - 4 - pq > 0`, i.e. **`(p-2)(q-3) < 2`**,

and over `q ≥ p ≥ 3` that leaves exactly `(3,3)` and `(3,4)`, with `(3,3)` already excluded
by [L126](L126.lean)'s scope. So `(3,4)` is the **only** split needing the new exception, and
the record's *"the one split"* is a theorem rather than the result of a search. That also
explains why five checks missed it: it is a single lattice point inside a region the
inequality closes off.

At `(3,4)` the values are `μ = 5/12` against `λ_max = 1/3`, so the overtaking is by `1/12`.
-/

namespace HamiltonsCubic.MissingException

/-- The family's dangerous eigenvalue. -/
def mu (p q : ℚ) : ℚ := (p + q - 2) / (2 * (p - 1) * (q - 1))

/-- The competing within-factor value at the larger factor. -/
def lamMax (q : ℚ) : ℚ := (q - 2) / (2 * (q - 1))

/-! ## The values at `(3,4)` -/

theorem mu_at_three_four : mu 3 4 = 5 / 12 := by unfold mu; norm_num

theorem lam_at_four : lamMax 4 = 1 / 3 := by unfold lamMax; norm_num

/-- **`μ` overtakes at `(3,4)`, by `1/12`.** -/
theorem overtakes_at_three_four : lamMax 4 < mu 3 4 ∧ mu 3 4 - lamMax 4 = 1 / 12 := by
  rw [mu_at_three_four, lam_at_four]
  constructor <;> norm_num

/-! ## The condition factors -/

/-- **`3p + 2q - 4 - pq = 2 - (p-2)(q-3)`**, identically, so overtaking is `(p-2)(q-3) < 2`. -/
theorem condition_factors (p q : ℚ) : 3 * p + 2 * q - 4 - p * q = 2 - (p - 2) * (q - 3) := by
  ring

/-- **And the comparison clears to that condition.** -/
theorem comparison_clears (p q : ℚ) (hp : 3 ≤ p) (hq : p ≤ q) :
    lamMax q < mu p q ↔ 0 < 3 * p + 2 * q - 4 - p * q := by
  unfold mu lamMax
  have h1 : (0:ℚ) < p - 1 := by linarith
  have h2 : (0:ℚ) < q - 1 := by linarith
  rw [div_lt_div_iff₀ (by linarith) (by nlinarith [h1, h2])]
  constructor <;> intro h <;> nlinarith [h, h1, h2]

/-! ## `(3,4)` is the only exception in range -/

/-- **Over integers with `q ≥ p ≥ 3`, `(p-2)(q-3) < 2` forces `p = 3`.** Past that, `p-2 ≥ 2`
and `q-3 ≥ 1` already reach the bound. -/
theorem forces_p_three (p q : ℤ) (hp : 3 ≤ p) (hq : p ≤ q)
    (h : (p - 2) * (q - 3) < 2) : p = 3 := by
  by_contra hne
  have h1 : 2 ≤ p - 2 := by omega
  have h2 : 1 ≤ q - 3 := by omega
  nlinarith [h, h1, h2]

/-- **And then `q ∈ {3,4}`**, so the condition has exactly two solutions in range. -/
theorem only_two_solutions (p q : ℤ) (hp : 3 ≤ p) (hq : p ≤ q)
    (h : (p - 2) * (q - 3) < 2) : p = 3 ∧ (q = 3 ∨ q = 4) := by
  have hp3 := forces_p_three p q hp hq h
  subst hp3
  omega

/-- Both are genuine solutions, so neither is excluded by the criterion itself. -/
theorem both_satisfy :
    ((3 : ℤ) - 2) * ((3 : ℤ) - 3) < 2 ∧ ((3 : ℤ) - 2) * ((4 : ℤ) - 3) < 2 := by
  constructor <;> norm_num

/-- **So once `(3,3)` is excluded on other grounds, `(3,4)` is the unique split the clause must
name**, the record's *"the one split"* is a theorem, not the residue of a search. -/
theorem unique_after_exclusion (p q : ℤ) (hp : 3 ≤ p) (hq : p ≤ q)
    (h : (p - 2) * (q - 3) < 2) (hne : ¬(p = 3 ∧ q = 3)) : p = 3 ∧ q = 4 := by
  obtain ⟨hp3, hq34⟩ := only_two_solutions p q hp hq h
  subst hp3
  rcases hq34 with rfl | rfl
  · exact absurd ⟨rfl, rfl⟩ hne
  · exact ⟨rfl, rfl⟩

end HamiltonsCubic.MissingException
