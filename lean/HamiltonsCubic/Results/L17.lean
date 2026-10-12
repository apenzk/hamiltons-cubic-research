import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L17, first-order protection, and a subspace described as three families

[route-a.md](../../../findings/route-a.md)'s Lemma L17: confirmed as an inequality, refuted as
stated.

**A linear subspace and a list of families are different kinds of object.** `{F = 0}` is a
subspace, so it is closed under addition and scaling, and therefore contains every
combination of anything in it. A list of three families names points; the subspace they sit in
contains all their sums, so the list understates it unless the families already span. The
record lists three and the truth is a linear subspace of codimension at most `186` at `n = 12`, a proper
subspace and so measure zero among directions.

**`8/9` is `88.9%`**, the record's printed figure to the digit given. It is a ratio of
dimensions at best, since a proper subspace is measure zero among directions, and the record's
own count bounds that ratio below by `1451/1637`.
-/

namespace HamiltonsCubic.FirstOrderProtection

/-! ## A subspace contains more than its listed members -/

/-- **A finite list need not be closed**, so a list is not a subspace: `{1, 2}` omits
`1 + 2`. -/
theorem list_not_closed : ∃ (S : Set ℚ) (x y : ℚ), x ∈ S ∧ y ∈ S ∧ x + y ∉ S := by
  refine ⟨{1, 2}, 1, 2, by simp, by simp, ?_⟩
  intro h
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at h
  rcases h with h | h <;> norm_num at h

/-! ## The reported share -/

/-- **`8/9 = 88.9%`**, matching the record's `~89%` to the digit given. -/
theorem eight_ninths_bracket :
    (888 : ℚ) / 1000 < 8 / 9 ∧ (8 : ℚ) / 9 < 889 / 1000 := by
  constructor <;> norm_num

/-- And the complement is `1/9`, arithmetic on the printed figure. -/
theorem complement : (1 : ℚ) - 8 / 9 = 1 / 9 := by norm_num

theorem complement_share : (111 : ℚ) / 1000 < 1 / 9 ∧ (1 : ℚ) / 9 < 112 / 1000 := by
  constructor <;> norm_num

end HamiltonsCubic.FirstOrderProtection
