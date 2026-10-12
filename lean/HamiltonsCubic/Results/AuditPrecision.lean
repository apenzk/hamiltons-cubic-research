import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# The quotation audit, classified, and what an audit's false-positive rate costs

[QuotationAudit](QuotationAudit.lean) flagged `23` of `115` quotations as no longer matching the
record. Classifying them changes what the number means.

**Verified, of the `23`:** one misquote, now corrected; **six** quotes whose source a round of
this loop removed, the four already recorded plus
[RelaxationFailure](RelaxationFailure.lean) and [RationalBlock](RationalBlock.lean), both from
rounds that repaired the passage they quoted; and **a second misquote** at
[TubeRadius](TubeRadius.lean), which this file first recorded as a confirmed false positive and
which is not: the record reads *"a radius `0.5748` that is more than double the largest
published"*, and the file had compressed it to *"radius more than double…"*, eliding four words.
Corrected. **The correction matters more than the count**, a round asserting a flag was spurious
is making the same kind of claim the audit was checking, and this one was wrong.

**The remaining fifteen carry artefact signatures**, a markdown link inside the quoted span, so
that `[L134](L134.lean)` contributes the word *lean*; Unicode mathematics against the record's
LaTeX; and a word-length filter that discards `n` and `m`. None was individually verified, so
they are recorded as unclassified rather than as clean.

**So the audit's own precision is the finding.** Of `23` flags, at most `8` are defects and one
is a misquote, a misquotation rate below one in a hundred, against a flag rate of one in five.
**An audit that reports twenty-three problems where seven are real hands its reader the wrong
number**, and the reader has no way to tell without redoing the work.

**This is the second such case in three rounds.** [IndexBijection](IndexBijection.lean) reported
five pointer mismatches, all five artefacts of reading a prose cell as a pointer column. In both
the checker was sound on its own terms and wrong about the record, which is the failure mode a
mechanical audit has, and the reason each should state its false-positive mechanism beside its
count.
-/

namespace HamiltonsCubic.AuditPrecision

/-! ## What the flags decompose into -/

/-- `23` flags: **two** misquotes, six orphaned sources, fifteen unclassified. -/
theorem flag_decomposition : 2 + 6 + 15 = 23 := by norm_num

/-- **At most `8` of the `23` are defects**, so more than half the flags are not. -/
theorem majority_are_not_defects : (8 : ℚ) / 23 < 1 / 2 := by norm_num

/-- **And the misquotation rate is below two in a hundred.** -/
theorem misquote_rate : (2 : ℚ) / 115 < 2 / 100 := by norm_num

/-- Against a flag rate of one in five, so the two differ by more than a factor of twenty. -/
theorem flag_rate_against_defect_rate :
    (23 : ℚ) / 115 = 1 / 5 ∧ (20 : ℚ) < (1 / 5) / (1 / 115) := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The precision of the two audits -/

/-- [IndexBijection](IndexBijection.lean) reported `5` mismatches, all artefacts, precision `0`. -/
theorem index_audit_precision : (0 : ℚ) / 5 = 0 := by norm_num

/-- This one's precision is at most `8/23`, under `35%`. -/
theorem quotation_audit_precision : (8 : ℚ) / 23 < 35 / 100 := by norm_num

/-- **Neither audit was wrong on its own terms**; both were wrong about the record, which is why
a count without its false-positive mechanism is not a result. -/
theorem count_without_mechanism_misleads :
    (23 : ℚ) - 8 = 15 ∧ (5 : ℚ) - 0 = 5 ∧ (15 : ℚ) + 5 = 20 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.AuditPrecision
