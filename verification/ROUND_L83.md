# Round L83, the 24-block table of Sym^3(W_5)

**Id:** L83 · **Date:** 2026-09-14 · **Verifiers:** v287, v288, v289 · **Brief:** [BRIEF_L83.md](BRIEF_L83.md) · **Logs:** `agent_logs/verify-L83-v287.log`, `agent_logs/verify-L83-v288.log`, `agent_logs/verify-L83-v289.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the setting | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 3, 7, 9, 13 |
| the table and its argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 29-42 |
| the canon | [results.md](../results.md) lines 284 and 942 |
| the Lean file | [L83.lean](../lean/HamiltonsCubic/Results/L83.lean) |

**Withheld**: [sym3-blocks.md](../findings/sym3-blocks.md) line 11 and lines 17-27 (a reviewer's construction and the Gate 2 notes), and every index row. *[L83.lean](../lean/HamiltonsCubic/Results/L83.lean) line 14 mentions "the record's own audits", left in place because the file is read whole.*

## The findings from phase 0

**Queued from the candidate class**: a Gate 2 `GAP` whose repair list was recorded and never applied. The block's own notes say the multiplicity column is imported and the "four independent ways" are one. Brief items 1 to 3.

## Adjudication

**Verdicts: [v287](VERIFY_v287.md), [v288](VERIFY_v288.md), [v289](VERIFY_v289.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, relabelled `Observation`, impact `NARROWS`.** *Unanimous on every cluster.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the weight list and multiplicity column | no argument on file, a script link only | v287, v288, v289 (`HYPOTHESIS-DEBT`) | **confirmed**, relabelled `Observation`, the character identity routed to Support owed |
| C2 | "the table is arithmetic on the highest weights ... no linear algebra on the $7770$" | Weyl's formula and the Casimir take a weight and return a dimension, never a multiplicity or the list | v287, v288, v289 (`REFUTED AS STATED`) | **confirmed**, rewritten to the dimension and Casimir columns |
| C3 | "closes four independent ways" | $24$, $41$, $65$ are moments of the multiplicity column; swapping the multiplicities of $(2,2)$ and $(2,1)$ passes all four | v287, v288, v289 (`REFUTED AS STATED`) | **confirmed**, rewritten with the swap as the witness |
| C4 | the dimension column and the sums | by hand in the basis $ae_1+be_2$ | v287, v288, v289 (`CONFIRMED`) | **confirmed**, the basis now stated |
| C5 | $[2,2]=4\omega_2$, Casimir $16$ against $12$ | direct | v287, v288, v289 (`CONFIRMED AS ALGEBRA`) | **confirmed** |
| C6 | $SO(5)$ labels as $O(5)$ blocks, the unknowns column | $-I$ acting trivially and real type, both used and unstated | v287, v288, v289 (`HYPOTHESIS-DEBT`) | **stated** in the block |
| C7 | trivial multiplicity $1$ at $n=5$ and $2$ from $n\ge6$, "one-dimensional at $n\le5$" | the Lovelock relation is recorded underived, spanning by the two contractions and $\operatorname{tr}(W^3)\not\equiv0$ unstated, and at $n=3$ there are no cubic invariants | v287, v288, v289 (`HYPOTHESIS-DEBT`), v289 (`REFUTED AS STATED` at $n=3$) | **narrowed** to $n=5$ with the two steps named as owed; the $n\ge6$ clause removed |
| C8 | the canon's "every number re-derives by hand", "one block is closed by an external count" | the multiplicities do not, and the external count names no block | v287, v288 (`HYPOTHESIS-DEBT`, `GAP`), v289 | **restated** |
| C9 | the Lean file | the table typed as data, the arithmetic proved, a docstring's "$a\ge b$ checked below" with no theorem | v287, v288, v289 (`CONFIRMED AS ALGEBRA`) | **recorded**, no statement of the lemma exists to type until the identity is proved |

**No adjudication pair was spent.**

### Withdrawn

- **v287: the $n=3$ edge as a defect of the $n=5$ table.** It bears on the $n\le5$ sentence alone (C7).
- **v288: the ten labels with $a+b$ odd as $\det$-twisted modules.** Harmless read as $SO(5)$ highest weights.
- **v287: floor division in the Lean file, and "parity-sensitive".** Wording.

### Dependents

- **[sym3-blocks.md](../findings/sym3-blocks.md)'s L86, L87, L88 and L89** read counts off the table: the $\lambda_2$-even dimension sum $3570$, the $29/12$ split of the $41$, $\sum\binom m2=24$ and the $65$. **NARROWED**: each now rests on an `Observation`. *All four are queued in the candidate class, L86, L88 and L89 as the next rounds, and each writes the condition into its own block.*
- **The report's full DAG** marks the node `L83.O`.

**Impact `NARROWS`.**

### What changed

- [sym3-blocks.md](../findings/sym3-blocks.md): the Gate 2 stack replaced by the relabelled statement, what is proved, the one external check and the swap witness; the table's two framing sentences and the trivial-multiplicity sentence rewritten; the in-file anchor updated.
- [results.md](../results.md) and [INDEX-results.md](../findings/INDEX-results.md): relabelled, the lowercased heading repaired. [diagram-full-dag.tex](../report/sections/diagram-full-dag.tex): the node label.
- [ATTEMPTS.md](../ATTEMPTS.md): the removed stack and sentences, quoted.
