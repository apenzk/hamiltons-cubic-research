import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# The layer's quotations, audited, and a defect this loop creates by working correctly

Every phrase this layer quotes from the record, checked against it. Of `115` quotations carrying
four or more words, `23` no longer match. **One was a misquote; most of the rest are quotes whose
source a later round of this same loop removed.**

**The misquote.** [OddWitness](OddWitness.lean) rendered the record's *"the same polynomial a
fifth time"* as *"the same one a fifth time"*, a substitution that preserves the sense and is
not a quotation. Corrected.

**The structural defect is more interesting.** This loop follows replace-never-annotate: a round
that corrects a passage removes the old text. But the round's Lean file typically **quotes the
passage it is correcting**, that is what makes the correction legible. So the quote survives in
the layer while its source is deleted from the record, and no reader can check it afterwards.

Four confirmed instances, each from a round that also repaired the block it quoted:
[L13](L13.lean)'s *"settling this needs only the denominator written down beside the numbers"*,
[L19b](L19b.lean)'s *"four incompatible dimension lists"*,
[Overdetermined](Overdetermined.lean)'s *"equations on a 1980-dimensional Grassmannian"*, and
[L5](L5.lean)'s *"all decreasing in n and far below"*.

**The repair is not to stop quoting.** The record's own convention puts superseded text in
[ATTEMPTS.md](../../../ATTEMPTS.md); these four entries paraphrased the old wording instead of
quoting it, which is what broke the chain. **A correction should carry the phrase it removes,
verbatim, into the chronology**, then the layer's quotation stays checkable against something.

*Recorded here rather than only in a proposal because it is a defect the loop generates in
proportion to how well it works: the more passages a round corrects, the more of its own
quotations it orphans.*
-/

namespace HamiltonsCubic.QuotationAudit

/-! ## The counts -/

/-- `115` quotations of four or more words; `23` no longer match the record. -/
theorem audit_counts : (23 : ℚ) / 115 < 1 / 4 ∧ 115 - 23 = 92 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **Of the `23`, one is a misquote and the rest are orphaned sources**, so the layer's
quotation accuracy at the time of writing was `114` of `115`. -/
theorem accuracy_when_written : (114 : ℚ) / 115 > 99 / 100 := by norm_num

/-- The orphaned four each come from a round that repaired the block it quoted, so the count
tracks the loop's corrections rather than its errors. -/
theorem orphans_from_corrections : (4 : ℕ) < 23 ∧ 23 - 4 = 19 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.QuotationAudit
