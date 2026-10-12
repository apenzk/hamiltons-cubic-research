# Round L90, evaluation is injective on the image

**Id:** L90 · **Date:** 2026-09-14 · **Verifiers:** v305, v306, v307 · **Brief:** [BRIEF_L90.md](BRIEF_L90.md) · **Logs:** `agent_logs/verify-L90-v305.log`, `agent_logs/verify-L90-v306.log`, `agent_logs/verify-L90-v307.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 149, 163-181 |
| L89, given | [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 128 |
| L62, given | [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 260 |

**Withheld**: the Gate 2 stack under the heading, every index row, and both Lean files, which quote prior verdicts.

## The findings from phase 0

**The load-bearing step argues from a rank equality of which only one side is measured.** No [results.md](../results.md) entry exists. Brief items 1 and 2.

## Adjudication

**Verdicts: [v305](VERIFY_v305.md), [v306](VERIFY_v306.md), [v307](VERIFY_v307.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED`.** *Unanimous: the algebra and the cap are proved, and the lower rank is a modular measurement.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | kernel containment and equal ranks giving injectivity | direct | v305, v306, v307 (`CONFIRMED AS ALGEBRA`) | **confirmed** |
| C2 | "$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured" | only the first is measured, and the inequality runs from it to the second | v305, v306, v307 (`HYPOTHESIS-DEBT`) | **repaired**: cap plus one measurement, and the circular sentence replaced |
| C3 | "sampling and reduction only lose rank, so attaining the cap forces equality" | a kernel can grow modulo $p$; the reduction hypothesis is unstated | v306 (`GAP`), v305, v307 (`HYPOTHESIS-DEBT`) | **narrowed**: the three hypotheses the modular reading needs written into the statement and routed |
| C4 | the cap $\le13$ | direct | v305, v306, v307 (`CONFIRMED AS ALGEBRA`) | **confirmed** |
| C5 | $\dim\mathrm{ANN}=1$, $F_5$ in the image, $F_5(W_0)=0$ | the algebra given rank $13$; $F_5(W_0)=324c^6-324c^6$ in closed form | v307 (`CONFIRMED`), v305, v306 | **confirmed**, conditional on C3 |
| C6 | "the restricted rank is a theorem" against "open in $[1,13]$" | two voices ten lines apart | v307 (`REFUTED AS STATED`), v305 (`GAP`), v306 (withdrawn on reading) | **reconciled**: argument gives $[1,13]$, the measurement gives $13$ |
| C7 | "four primes", "two audits", "was nowhere in the record" | two primes named, the audits concern the PSD point, the step appears in L89's block | v305, v306, v307 | **corrected** |
| C8 | the equivariance guard, second-order vanishing, the $36$ | measured or unsourced; the $36$ is L86's | v305, v306, v307 (`HYPOTHESIS-DEBT`) | **kept** with sources named |
| C9 | no [results.md](../results.md) entry | phase 0 | round | **added** |

**No adjudication pair was spent.**

### Dependents

- **L91**, whose rank bounds concern the same map. **SURVIVES**, its round is next.
- **The certificate route**, whose identity step is L90's conclusion. **NARROWED** to one measured rank, routed to Support owed.

**Impact `CONTAINED`**: nothing changes value, and the standing is stated.
