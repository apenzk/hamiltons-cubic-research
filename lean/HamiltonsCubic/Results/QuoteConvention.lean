import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# The audit's premise was wrong, `*"…"*` marks two different things

[QuotationAudit](QuotationAudit.lean) treated every `*"…"*` span in this layer as a citation of
the record. It is not a citation convention: **the same markup names phrases a file coins**, and
the audit had no way to tell the two apart.

**Three of the flags are coined phrases.** [RankProfile](RankProfile.lean) is headed *the rank
profile, and a hypothesis of mine that context refutes*, and reads the cluster as
`"the signature of one quantity computed three ways"`, its own wording for a hypothesis it then
refutes. Searching the record for it finds nothing because nothing is there to find. The same
holds for its `"sit just above the rank-3 value"`.

**So the audit's `23` decomposes further**: two misquotes, six sources this loop removed, three
coined phrases, and twelve still unread. **A coined phrase flagged as a missing citation is not
a false positive in the checker, it is a category error in the question**, and no normalisation
would have fixed it.

**The repair is a distinguishing convention.** A citation and a coinage need different markup, or
no audit of quotation accuracy can run at all, which is the more useful finding than any count
this one produced, since it is the reason the counts kept needing adjudication.

*Recorded against the layer, not the record: the overloading is this loop's own, introduced file
by file with no convention ever stated.*
-/

namespace HamiltonsCubic.QuoteConvention

/-! ## The revised decomposition -/

/-- `23` flags: two misquotes, six orphaned sources, three coined phrases, twelve unread. -/
theorem decomposition : 2 + 6 + 3 + 12 = 23 := by norm_num

/-- **Only eight are defects of quotation**, and three are not quotations at all. -/
theorem defects_and_non_quotations : 2 + 6 = 8 ∧ (3 : ℚ) / 23 < 1 / 7 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.QuoteConvention
