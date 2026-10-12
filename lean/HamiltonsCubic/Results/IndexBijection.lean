import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# The results index is a bijection, the completeness gap, closed

[plan-verification.md](../../../plan-verification.md) carried an index completeness gap as a
queued item. Checking it in both directions closes it.

**Every block has a row and every row has a block.** `158` headings of the form
`#### <kind> L<n>` across [findings/](../../../findings/), `158` rows in
[INDEX-results.md](../../../findings/INDEX-results.md), and the symmetric difference is empty,
neither an orphan block nor a row without one.

**No id is declared twice.** Each of the `158` appears under exactly one heading in exactly one
file, so the id-to-block map is injective. That matters because the record has had the opposite:
[L93](L93.lean) was withdrawn precisely for being [L55](../../../findings/diagonal-half.md) under
a second number, and a repeat would be invisible to a count alone.

**And every pointer resolves.** For each row, the file its `Where` column names declares that
result. Five rows appeared to mismatch on a first pass; all five were the checker reading a
prose cell containing links as though it were the pointer column. **A checker artefact, not a
record defect**, recorded because the distinction is the whole value of the check.

*The arithmetic below is what a bidirectional check needs: equal cardinality alone does not give
a bijection, and inclusion alone does not either.*
-/

namespace HamiltonsCubic.IndexBijection

open Finset

/-! ## What the two directions buy together -/

variable {α : Type*} [DecidableEq α]

/-- **Equal cardinality alone is not enough.** Two sets can have the same size and share no
element. -/
theorem cardinality_alone_insufficient :
    ∃ A B : Finset ℕ, A.card = B.card ∧ A ≠ B := by
  refine ⟨{0}, {1}, by decide, by decide⟩

/-- **Inclusion alone is not enough either.** -/
theorem inclusion_alone_insufficient :
    ∃ A B : Finset ℕ, A ⊆ B ∧ A ≠ B := by
  refine ⟨{0}, {0, 1}, by decide, by decide⟩

/-- **Together they do give equality**, which is why the check runs both ways. -/
theorem both_give_equality {A B : Finset α} (hsub : A ⊆ B) (hcard : B.card ≤ A.card) : A = B :=
  Finset.eq_of_subset_of_card_le hsub hcard

/-- Equivalently, an empty symmetric difference is equality, the form the check reports. -/
theorem symmdiff_empty_iff_eq {A B : Finset α} :
    (B \ A = ∅ ∧ A \ B = ∅) ↔ A = B := by
  constructor
  · rintro ⟨h1, h2⟩
    apply Finset.Subset.antisymm
    · intro x hx; by_contra hn; exact absurd (Finset.mem_sdiff.2 ⟨hx, hn⟩) (by simp [h2])
    · intro x hx; by_contra hn; exact absurd (Finset.mem_sdiff.2 ⟨hx, hn⟩) (by simp [h1])
  · rintro rfl; exact ⟨by simp, by simp⟩

/-! ## Why the count must be over distinct ids -/

/-- **A count alone permits a duplicate and an omission cancelling.** Three entries can carry
two distinct ids, so `158 = 158` would survive one id appearing twice and another not at all,
which is why the check verifies injectivity separately. -/
theorem injectivity_is_needed :
    ∃ l : List ℕ, l.length = 3 ∧ l.toFinset.card < 3 := by
  refine ⟨[0, 0, 1], by decide, by decide⟩

end HamiltonsCubic.IndexBijection
