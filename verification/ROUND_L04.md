# Round L04, a generator for critical points, and a new family

**Result:** 4 in [findings/INDEX.md](../findings/INDEX.md), in [ungraded-slack.md](../findings/ungraded-slack.md).
**Date:** 2026-09-01. **Reviewers:** v6–v10.
**Round file for:** [verification-loop](../.claude/skills/verification-loop/SKILL.md).

## Concurrency

One of three rounds running at once, chosen so that **no two touch the same findings file**, a phase 5 repair edits the file that owns the result, and two rounds repairing one file would collide. Reviewer numbers are pre-allocated in blocks for the same reason: r331–r335 are held by a concurrent research-loop session, and v1–v5 by round [L00](ROUND_L00.md).

## The brief, and where it was quoted from

Identical for all five reviewers, quoted verbatim from [ungraded-slack.md:105](../findings/ungraded-slack.md), with no prior verdict, no reviewer number and no narrative. Reviewers were told to read no file of the record and to run nothing.

**Withheld deliberately:** the block's own note that the argument was moved from [results.md](../results.md), and the verification paragraph naming prior reviewers, both are confidence signals.

## The round was STOPPED at three of five

**v7 and v9 were killed at 30 minutes**, both still on their first log line, and neither left a partial report. **v6, v8 and v10 filed**, and their findings are below. *The round is not closed and L04 is not verified: three of five is not this loop's threshold, and the box in [plan-verification.md](../plan-verification.md) stays unticked.*

**Why they were stopped: the brief they carried was wrong.** It told them to *re-derive independently*, which is what made each run take ~25 minutes and 110k tokens, and (worse), what led all three filed reports to **supply proofs the record did not have**. A verifier checks what is written; it does not build its own version. [SKILL.md](../.claude/skills/verification-loop/SKILL.md) now says so, and a rerun of L04 under the corrected brief is what would close it.

## Phase 1, the three filed verdicts

| verifier | verdict | standing | withdrawn |
|---|---|---|---|
| [v6](VERIFY_v6.md) | `GAP` | 7 | 1 |
| [v8](VERIFY_v8.md) | `BROKEN` | 4 | 2 |
| [v10](VERIFY_v10.md) | `GAP` | 7 | 3 |

## Phase 2, clustering, PROVISIONAL on three of five

**Findings that are CHECKING, and stand.** Each breaks a universal claim with one object, which is what a verifier is for.

| # | claim attacked | mechanism | support |
|---|---|---|---|
| **G1** | "every member has just two eigenvalues" | A member of the stated hypotheses with three. $SO(5)\times SO(7)\subset SO(12)$, spectrum $(42,20,-24)$, found independently by two; $S^3\times S^5$ and $S^5\times S^7$ by the third. | **3 of 3** |
| **G2** | the cap $r\le n(n-2)/4$ | The same object has $r=31>30$. Every unbalanced split exceeds the cap, since $\binom p2+\binom q2$ is minimised at $p=q$. The cap is delegated to result 23, whose hypotheses this entry does not carry. | **3 of 3** |
| **G3** | $(\Lambda^4\mathbb R^n)^K=0$ as a criticality hypothesis | Idle there, $\dim\mathcal W_n^K=1$ alone forces criticality. One verifier adds that it wrongly excludes $\mathbb{CP}^k$, a genuine critical point. | **3 of 3** |
| **G4** | "none is coordinate-diagonalizable" | False as quantified, and self-contradictory with the entry's own next sentence: the balanced product is asserted to be a member and is diagonal. | **2 of 3** |
| **G5** | "zero-padding preserves everything" | **DISPUTED.** One says padding destroys both hypotheses and the formula; another withdrew that after checking $\mathrm{Ric}(Q(W))=0$ at source; a third says $\theta$ survives via an unstated identity. *Three readings of one word, "everything".* | 1 standing, 1 withdrawn, 1 partial |

**Findings that are DERIVATION, and are demoted.** All three reported that the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$ is *a theorem rather than the fit the entry describes*, each supplying its own proof from a different starting point.

**Those proofs do not enter the record as verification.** The check that was actually asked for is whether the entry supports its own claim, and the answer is that it does not: *"checked against held-out spaces it was never fitted to"* is fitting language, so the finding is **`HYPOTHESIS-DEBT`, the closed form has no argument on file**, naming what would have to be proved. That three capable agents each proved it independently is a strong signal it is provable, and it is a task for the research loop under Gate 2, not a verdict this loop may issue.

## Phase 3 onward, not run

No wave, no spread, no repair. **Nothing from this round has been written into [findings/](../findings/)**, and G1–G4 are candidates awaiting a completed round.
