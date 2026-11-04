# Round L01, the granted diagonal case, repaired at the threshold dimensions

**Id:** L01 · **Date:** 2026-09-07 · **Verifiers:** v218, v219, v220 · **Brief:** [BRIEF_L01.md](BRIEF_L01.md)

## Sources, verbatim

| passage | source |
|---|---|
| the section's framing | [findings/problem.md](../findings/problem.md) lines 448-464 |
| the block | [findings/problem.md](../findings/problem.md) lines 468-483 |
| the index's status row | [findings/INDEX.md](../findings/INDEX.md) line 19 |
| the index's file row | [findings/INDEX.md](../findings/INDEX.md) line 45 |

## The findings from phase 0

**This row's status is stated three incompatible ways, and the queue already recorded a fourth that has since changed under it.** The section says **"NEVER AUDITED, and OUT OF SCOPE"** and *"nothing in this project depends on Lemma L1"*. The index's file row says **"audited, and conditional on Result 5b"**. The index's status row says the diagonal case is **proved outright at every $n\ge4$ by this record's own theorem, so the grant is no longer load-bearing**, while $n=12,14$ are *"closed by Lemma L1"*. **All three cannot hold.** *The demotion note in [plan-verification.md](../plan-verification.md) resolved an earlier version of this contradiction against the index; the index line it cited no longer reads as it did.*

**The block is conditional on an object the record does not carry.** *"Result 5b is unnumbered, unindexed and has never been through Gate 2, so L1 is conditional on it until it is."* **A numbered result conditional on an unnumbered one is a dependency the index cannot show**, which is why the status contradiction can persist.

**One step is machine-checked and the block says so.** *"The one-dimensional remainder is discharged by validated interval arithmetic, ten subintervals, each with a proven negative bound … So both dimensions are machine-checked rather than swept."* **This loop does no numerical work, and the question is not whether the run is right but whether a validated-interval discharge is a proof the record can stand on**, say what it establishes and what it assumes.

**The block already records that a census in it reported the opposite of what it found.** The round is asked whether the census as it now stands is correct.

## What the verifiers are asked beyond the standing list

Which of the three status claims the mathematics supports, and whether anything on the record actually depends on L1; whether **two** dimension constraints carry Jäger's Theorem A and whether the rounding-slack account of the threshold is right, including $\mathop{\mathrm{tr}}S^4\le E(n)$ rounded to $16/(8n+9)$ and the clearing $41n-57\ge0$; **whether the $n=12$ moment-body step is sound** (that the floor of one moment forces the other off its ceiling) and whether its two hypotheses are load-bearing as claimed; whether weak duality alone licenses the supporting line, and whether the convexity appealed to is genuinely surplus; and **what Result 5b is, where it is, and what L1 loses without it.**

## Adjudication

**Verdicts: [v218](VERIFY_v218.md) and [v219](VERIFY_v219.md) `HYPOTHESIS-DEBT`, [v220](VERIFY_v220.md) `GAP`. Round verdict: `HYPOTHESIS-DEBT`, repaired, impact `CONTAINED`.** *Impact is contained because all three established, by search rather than by trust, that **nothing on the record depends on L1**.*

### The status contradiction, resolved five ways

**D is the statement the mathematics supports.** The row is audited and conditional on Result 5b.

| statement | outcome |
|---|---|
| **A**, *"NEVER AUDITED"* | **stale**, the audit is on file and the block cites it |
| **A**, *"nothing in this project depends on Lemma L1"* | **true**, and confirmed by search |
| **D**, *"audited, conditional on Result 5b"* | **accurate** |
| **C**, *"proved outright at every $n\ge4$ by this record's own theorem"* | **true** |
| **C**, *"the proof lives only in results.md, has no ledger row, Gate 2 unrecorded"* | **false in all three parts, and backwards** |
| a fourth, [LEDGER.md](../findings/LEDGER.md), *"do not spend reviewers on it"* | **stale**, 372 lines above the row recording the audit |

*One verifier also found C's own cell self-contradictory, "proved outright at every $n\ge4$, odd included" beside "Odd $n$ open".* **All six sites are now consistent**, and the one live consumer, at [diagonality.md](../findings/diagonality.md), has been moved onto result 57, which carries the diagonal case at every $n\ge4$ and both parities where L1 carries two dimensions conditionally.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | the rounding and its cost | independent derivation | 3/3 | `CONFIRMED`, $-41n+57$, direction correct |
| **C2** | *"valid at every $n\ge2$"* | fails at $n=\tfrac52$, undefined at $n=2,3$ | 1/3 | `CONFIRMED`, corrected to integer $n\ge4$ |
| **C3** | weak duality sufficing, convexity surplus | | 3/3 | `CONFIRMED`, and it returns a minorant, not a supporting line |
| **C4** | the two moment hypotheses | | 3/3 | `CONFIRMED`, **and sharper than stated**: without $\lambda\le1$ the dual collapses to $-\infty$ |
| **C5** | *"the edge itself is $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$"* | that edge **admits** the corner | 2/3 | **`REFUTED`**, see below |
| **C6** | *"a genuine equality case rather than an estimate"* | the corner elimination does not reach the requirement | 2/3 | `CONFIRMED`, overstated |
| **C7** | *"both dimensions are machine-checked"* | the script runs at $n=12$ only | 2/3 | **`REFUTED`**, $n=14$ has no certificate |
| **C8** | *"ten subintervals"* | adaptive, counted at run time | 2/3 | `CONFIRMED`, a run artefact, not a checkable object |
| **C9** | the refuted census sentences | still standing verbatim in four files | 3/3 | `CONFIRMED`, struck everywhere |
| **C10** | Result 5b's necessity | the $m\ge8$ step needs only a fifth free index | 2/3 | `CONFIRMED`, **and this does not make L1 unconditional** |

### C5, refuted and screened

The block named $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ as the edge excluding the corner. **It admits it.** Screened exactly at $n=12$: the corner has $(\mathop{\mathrm{tr}}S^3)^2=\tfrac1{12}=0.0833$ against $E(12)=\tfrac{709}{4680}=0.1515$, so the inequality holds there, *and Jäger already prints it.* **The edge that does the work is $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ with $\mathop{\mathrm{tr}}S\le\sqrt n$**, giving $\mathop{\mathrm{tr}}S^3\ge1/\sqrt n$. The misattribution stood in three files including the Lean docstring, and all three are corrected.

### C6, where two verifiers arrived by different routes at one conclusion

**The corner elimination is not what closes $n=12$.** One verifier reached it numerically-by-hand, the edge yields $\mathop{\mathrm{tr}}S^3\ge1/\sqrt{12}=0.2887$ against a requirement of $0.3152$, while the dual certificate gives $0.3336$. The other reached it structurally, by identifying which edge excludes the corner at all. *They are the same finding: the mechanism the block names is real and insufficient, and the dual is what carries the dimension.* **The Lean index already carried the honest version**, which is where the record disagreed with itself.

### C10, and the restraint that makes it a debt rather than a repair

**Result 5b is what L1 is conditional on, and it is unnumbered, unindexed, never through Gate 2, warranted by brute force at $n=4,5,6$ while used at $n=12,14$, and shares its label with a second Result 5b two scripts cite.** *Without it L1 is emptied rather than weakened.* **And its necessity is asserted**: the $m\ge8$ step it removes chooses one index of $A_k$ outside a four-element set, which needs only a fifth free index. **Both verifiers who found that declined to conclude L1 is unconditional**, no per-lemma audit of Assumption 1 exists in either direction, *and the absence is the debt rather than a licence to drop the condition.* That is the loop working: the cheap conclusion was available and neither took it.

### What is not repaired here

**The four steps with no argument on file are recorded in the block and filed in [plan.md](../plan.md)**: the reduction to Jäger's expression, the dual construction behind $\varphi$, the interval certificate, and Result 5b itself. Three further conditions used and never stated are now stated: $\mathop{\mathrm{rank}}S\le n$, Jäger's (3.16) monotonicity, and the convexity range.

