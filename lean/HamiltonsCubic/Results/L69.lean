import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L69, why `p,q ≥ 5` and `n ≥ 12` are two constraints, not one

[graded-half.md](../../../findings/graded-half.md)'s Lemma L69. Its index row pairs *"sphere
products with `p,q ≥ 5`"* with *"`n ≥ 12` enters as the dimension where an admissible split first
exists"*, and `p,q ≥ 5` alone would give `n ≥ 10`. The reduced condition settles it.

**The condition is `1/(p-1) + 1/(q-1) - 1/(n-1) ≤ 1/3`.** Under it:

* `(5,5)` at `n = 10` **fails**, at `7/18` against `6/18`.
* `(5,6)` at `n = 11` **fails**, at `7/20`.
* `(5,7)` at `n = 12` **passes**, at `43/132` against `44/132`, by exactly `1/132`.
* `(6,6)` at `n = 12` **passes**, at `17/55`, by `4/165`.

So `n ≥ 12` is not implied by `p,q ≥ 5`; it is where the inequality first admits anything, and
the first admissible split clears it by one part in `132`.

**And `p = 4` fails for a reason with no arithmetic in it.** There `1/(p-1) = 1/3` exhausts the
budget exactly, while `1/(q-1) - 1/(n-1) > 0` always, since `n > q`. So the sum strictly exceeds
`1/3` at every `q`, which forces `p ≥ 5` structurally rather than by checking splits, and `p ≤ 3`
fails a fortiori.
-/

namespace HamiltonsCubic.AdmissibleSplits

/-- The reduced condition's left side. -/
def budget (p q : ℚ) : ℚ := 1 / (p - 1) + 1 / (q - 1) - 1 / (p + q - 1)

/-! ## `n = 10` and `n = 11` carry nothing -/

/-- **`(5,5)` fails**, at `7/18` against `1/3 = 6/18`. -/
theorem five_five_fails : budget 5 5 = 7 / 18 ∧ (1 : ℚ) / 3 < 7 / 18 := by
  refine ⟨by unfold budget; norm_num, by norm_num⟩

/-- **`(5,6)` fails**, at `7/20`. -/
theorem five_six_fails : budget 5 6 = 7 / 20 ∧ (1 : ℚ) / 3 < 7 / 20 := by
  refine ⟨by unfold budget; norm_num, by norm_num⟩

/-! ## `n = 12` is where a split first fits -/

/-- **`(5,7)` passes, by exactly `1/132`.** -/
theorem five_seven_passes :
    budget 5 7 = 43 / 132 ∧ (43 : ℚ) / 132 < 1 / 3 ∧ (1 : ℚ) / 3 - 43 / 132 = 1 / 132 := by
  refine ⟨by unfold budget; norm_num, by norm_num, by norm_num⟩

/-- **`(6,6)` passes, by `4/165`.** -/
theorem six_six_passes :
    budget 6 6 = 17 / 55 ∧ (17 : ℚ) / 55 < 1 / 3 ∧ (1 : ℚ) / 3 - 17 / 55 = 4 / 165 := by
  refine ⟨by unfold budget; norm_num, by norm_num, by norm_num⟩

/-- So the two constraints are genuinely different: `p,q ≥ 5` permits `n = 10`, and the
inequality does not. -/
theorem constraints_are_distinct :
    (5 : ℚ) + 5 = 10 ∧ (1 : ℚ) / 3 < budget 5 5 := by
  refine ⟨by norm_num, by unfold budget; norm_num⟩

/-! ## `p = 4` fails structurally -/

/-- **At `p = 4` the first term is exactly the budget.** -/
theorem p_four_exhausts : 1 / ((4 : ℚ) - 1) = 1 / 3 := by norm_num

/-- **And the remainder is strictly positive at every `q`**, since `n > q`. -/
theorem remainder_positive {q : ℚ} (hq : 2 ≤ q) :
    0 < 1 / (q - 1) - 1 / (4 + q - 1) := by
  have h1 : (0:ℚ) < q - 1 := by linarith
  have h2 : (0:ℚ) < 4 + q - 1 := by linarith
  rw [sub_pos, div_lt_div_iff₀ h2 h1]
  linarith

/-- **So `p = 4` exceeds the budget at every `q`**, no split with a `4`-factor is admissible,
and the exclusion needs no case check. -/
theorem p_four_never_admissible {q : ℚ} (hq : 2 ≤ q) : 1 / 3 < budget 4 q := by
  unfold budget
  have h := remainder_positive hq
  have : 1 / ((4:ℚ) - 1) = 1 / 3 := by norm_num
  linarith [h, this]

/-- `p ≤ 3` fails a fortiori, the first term alone exceeding the budget. -/
theorem p_three_exceeds : (1 : ℚ) / 3 < 1 / ((3 : ℚ) - 1) := by norm_num

end HamiltonsCubic.AdmissibleSplits
