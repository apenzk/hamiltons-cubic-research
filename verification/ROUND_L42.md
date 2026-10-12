# Round L42, the sharp dual weight

**Id:** L42 · **Date:** 2026-09-14 · **Verifiers:** v230, v231, v232 · **Brief:** [BRIEF_L42.md](BRIEF_L42.md) · **Logs:** `agent_logs/verify-L42-v230.log`, `agent_logs/verify-L42-v231.log`, `agent_logs/verify-L42-v232.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the findings statement | [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 536-545 |
| the landscape statement | [results.md](../results.md) line 182 |
| the canonical entry | [results.md](../results.md) lines 633-637 |
| the proof | [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 581-610 |
| a second statement of the argument | [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 518-525 |
| the Lean statement | [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean) lines 72-128, one `sorry` on `sharp_dual_weight` |

## The findings from phase 0

**The block's pointer lands on the wrong heading.** It names "The $\dim\mathfrak m\le2$ stratum, assembled" (line 468), under which sits only a one-paragraph summary of the argument; the weak duality proof is under the heading at line 566.

**The summary under that heading states the superseded normalisation, and the correction stands beside the proof rather than replacing it.** Line 518 says $z=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible "exactly when $\mu$ is at least the triple's harmonic mean"; line 610 says that gloss is wrong by a factor $\tfrac92$. *Screened by hand in phase 0: with that $z$, feasibility is $\tfrac32\mu\cdot3/H\ge1$, so $\mu\ge2H/9$.* This is the annotate-beside shape the loop's core rule forbids, and it is left for the verifiers to confirm.

**The canon and the findings file word the sharpness differently**: "the constant cannot be improved" against "the constant is attained, so no better weight exists for this relaxation". Both go into the brief unlabelled.

**The third form is partial**: [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean) types the lemma with one `sorry`, the summation step of weak duality. *Phase 1c: the session runs the Lean discharge in parallel with the verifiers, since the `sorry` is the record's own argument and not a repair.*

## Adjudication

**Verdicts: [v230](VERIFY_v230.md), [v231](VERIFY_v231.md), [v232](VERIFY_v232.md) all `PROVEN`. Round verdict: `PROVEN`, repaired, impact `CONTAINED`.** *Unanimous on the mathematics: Passage D's weak duality establishes $3M\le h(s^2-u)$, ties included, and the equal-spectrum witness makes the constant unimprovable. Every defect sits in text beside the proof.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | Passage E, the summary's feasibility sentence | with $z=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ the threshold is $\mu\ge\tfrac29H$, witness $(1,1,1)$ at $\mu=\tfrac29$ | v230, v231, v232 | **confirmed**, repaired |
| C2 | Passage A's pointer | the named heading holds the summary, the proof is under the heading at line 566 | v230, v231, v232 | **confirmed**, repaired |
| C3 | the proof's opening line | *"the $2800$ draws recorded below"* has no referent in the file | v230 | **confirmed**, removed |
| C4 | the Lean docstring's quotation | it quotes a heading, *"Hypothesis, previously unstated"*, the file no longer carries | v232 | **confirmed**, repaired |
| C5 | the brief | Passage F stopped at Lean line 128, cutting the $(s^2-u)$ factor; and the brief placed Passage E under line 468 where it sits under the L35 heading at line 487 | v230, v231, v232 (F), v232 (E) | **the round's own defect**, no record change |
| W1 | Passages A and C, "no better weight" | read pointwise it fails, $(1,1,1,\tfrac14)$ gives $3M=6<\tfrac{15}2$ and $(2,1,1,1)$ gives $21<\tfrac{108}5$ | v231, v232 | **withdrawn by both**: the words name the uniform constant, which the witness pins |

**No adjudication pair was spent.** *C1 is a one-line closed form and the file already carried its correction two paragraphs later; C2 to C4 are text facts settled by reading the lines named, each checked in the session before repair. None asks whether a proof step is valid, which is the question an adjudication pair answers.*

### Dependents

**None load-bearing is disturbed**: the statement and the proof are unchanged, and every repair is to prose beside them. *[L35](../findings/stratum-two-negative.md) consumes the boxed bound, which all three verifiers confirmed.*

### What was changed

- [stratum-two-negative.md](../findings/stratum-two-negative.md): Passage E restated in the normalisation that is true, $z=\tfrac h3\lambda_\alpha\lambda_\beta$ with $h$ at least the triple's harmonic mean; the annotation that corrected it beside the proof deleted, its text moved to [ATTEMPTS.md](../ATTEMPTS.md); the pointer anchored on the proof's heading; the dangling $2800$ sentence deleted.
- **The third form is complete.** [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean)'s `sorry` is discharged: weak duality summed over ordered distinct triples, kernel-checked, `#print axioms` reporting `propext`, `Classical.choice`, `Quot.sound`. The docstring's quotation is repaired, and [L42b.lean](../lean/HamiltonsCubic/Results/L42b.lean) and [lean/INDEX.md](../lean/INDEX.md) no longer name the summation step as owed.
