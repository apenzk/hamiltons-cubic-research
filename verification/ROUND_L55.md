# Round L55, the min-entry bound, sharp for even $n$

**Id:** L55 · **Date:** 2026-09-14 · **Verifiers:** v253, v254, v255 · **Brief:** [BRIEF_L55.md](BRIEF_L55.md) · **Logs:** `agent_logs/verify-L55-v253.log`, `agent_logs/verify-L55-v254.log`, `agent_logs/verify-L55-v255.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement | [findings/diagonal-half.md](../findings/diagonal-half.md) lines 452-456, under the heading at line 436 |
| the proof | [findings/diagonal-half.md](../findings/diagonal-half.md) line 458 |
| the landscape statement | [results.md](../results.md) line 206 |
| the canonical entry | [results.md](../results.md) line 709 |
| the Lean statement | [L55Statement.lean](../lean/HamiltonsCubic/Results/L55Statement.lean), no `sorry`, uniqueness not typed |

## The findings from phase 0

**The block is an annotation stack above an unchanged statement, and the canon still carries what the notes call false**: the extremiser without $c>0$, and "at odd $n$ the bound is strict", which $K=0$ refutes. Brief items 2 to 4.

**The uniqueness half of "exactly" is asserted in one clause of the proof**, the strictness of the row step and the symmetry step forcing an involution unwritten; the Lean file proves the inequality and attainment and says it does not type uniqueness. Brief item 2.

**The duplicate is settled**: [L93](../findings/bispectral.md) is withdrawn as a number in favour of L55, and nothing outside the two blocks cites L55.

## Adjudication

**Verdicts: [v253](VERIFY_v253.md), [v254](VERIFY_v254.md), [v255](VERIFY_v255.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED`.** *Unanimous on every claim.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the inequality | holds, symmetry unused; needs $n\ge3$, the display being $0/0$ at $n=2$ | v253, v254, v255 | **confirmed**, $n\ge3$ written in |
| C2 | attainment by the matching matrix, $c$ unsigned | at $n=4$, $\sigma=(12)(34)$, $c=-1$: $\lvert\min\rvert=2$ against the bound $1$ | v253, v254, v255 | **confirmed**, $c>0$ written in |
| C3 | uniqueness, "exactly the perfect matchings" | needs strictness at the extreme points, $m>0$, and symmetry, which Passage B never invokes; a non-symmetric cyclic matrix attains equality with no involution | v253, v254, v255 | **debt, discharged**: written in prose and proved in Lean |
| C4 | "at odd $n$ the bound is strict" | $K=0$ attains equality at every odd $n$, and is the whole class at $n=3$ | v253, v254, v255 | **confirmed**, restated for $t>0$ |
| C5 | "bounds the smallest sectional curvature, no information about $\theta$" | undefined terms in the brief | v253, v254 (`HYPOTHESIS-DEBT`), v255 | **dropped** from the canon |
| C6 | the Lean file | uniqueness and the symmetry of the extremiser untyped; its header credited the record with a strict-convexity-and-symmetry argument Passage B did not contain | v253 (`GAP`), v254, v255 | **confirmed, discharged**: uniqueness now typed |

### The discharge

**[L55Statement.lean](../lean/HamiltonsCubic/Results/L55Statement.lean) proves uniqueness**: `entries_extreme` (every entry $-m$ or $(n-2)m$ at equality), `unique_large` (one large entry per row, from the zero row sum), `extremiser_is_matching` (symmetry makes the map a fixed-point-free involution and $K$ the matching matrix) and `even_of_matching` (Mathlib's fixed-point count mod $2$). **The prose in [diagonal-half.md](../findings/diagonal-half.md) is that argument in words.** *A kernel-checked argument replaces the second verifier pair a written repair would otherwise need; the statement it types was compared against the record's by the round.*

### Dependents

**None outside the block and its withdrawn duplicate [L93](../findings/bispectral.md).**
