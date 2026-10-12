# Round L84, Casimir separation is forced

**Id:** L84 · **Date:** 2026-09-14 · **Verifiers:** v290, v291, v292 · **Brief:** [BRIEF_L84.md](BRIEF_L84.md) · **Logs:** `agent_logs/verify-L84-v290.log`, `agent_logs/verify-L84-v291.log`, `agent_logs/verify-L84-v292.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 38, 54-60 |
| the table, given | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36 |
| the Lean statement | [L84Statement.lean](../lean/HamiltonsCubic/Results/L84Statement.lean) lines 53 onward |

**Withheld**: [sym3-blocks.md](../findings/sym3-blocks.md) lines 40-52 (the Gate 2 stack), [L84.lean](../lean/HamiltonsCubic/Results/L84.lean) and lines 1-52 of the statement file, both quoting the Gate 2 verdicts, and every index row.

## The findings from phase 0

**No [results.md](../results.md) entry exists for L84.** Brief definitions.

**The heading says the pair separates and the body says "the quartic generator" does**, and the block's argument sits in a section below a Gate 2 stack. Brief items 1 and 3.

## Adjudication

**Verdicts: [v290](VERIFY_v290.md), [v291](VERIFY_v291.md), [v292](VERIFY_v292.md) all `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *Unanimous: separation is forced once $C_4$ is required to be a generator.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the heading's "the PAIR $(C_2,C_4)$ separates all $24$" | $C_4$ undefined, and $C_4=C_2^2$ reads $(30,900)$ on $(4,1)$ and $(3,3)$ | v290, v292 (`REFUTED AS STATED`), v291 (`CONFIRMED` once a generator) | **confirmed**, $C_4\notin\mathbb R[C_2]$ written into the heading and statement |
| C2 | "leading terms are the power sums" as the carrier of separation | a leading term does not fix an eigenvalue; the step needed is that $\gamma(C_4)$ carries $p_4$ with nonzero coefficient, which the next sentence's invariant ring supplies and presents as "Equivalently" | v290 (`HYPOTHESIS-DEBT`), v291 (withdrawn on reading), v292 (noted) | **settled inline**: the proof now runs Harish-Chandra first, with $a\ne0$ from injectivity of $\gamma$ |
| C3 | $\ell_1>\ell_2>0$, recovery of $\lambda$ from $(p_2,p_4)$, $\mathbb R[p_2,p_4]$ | direct, the isomorphism classical and unfiled | v290, v291, v292 (`CONFIRMED`) | **confirmed** |
| C4 | $21$ values of $c_2$ with three collisions, the six $p_4$ values | by hand | v290, v291, v292 (`CONFIRMED`) | **confirmed** |
| C5 | "$C_2^2$ ... separates nothing" | false literally ($0$ at $(0,0)$, $16$ at $(1,0)$), true of the three pairs | v290 (`REFUTED AS STATED`), v291, v292 (`CONFIRMED` in context) | **rewritten** to "none of the three colliding pairs", with the witness |
| C6 | "Reviewer 178; the $22$ ... came from a run made before $\rho$ was corrected" | nothing on file | v290, v291, v292 (`HYPOTHESIS-DEBT`) | **removed** |
| C7 | the Lean statement | power sums only, no central element, docstring "no other collisions" with no theorem | v290, v291, v292 (`CONFIRMED AS ALGEBRA`) | **recorded** in [lean/INDEX.md](../lean/INDEX.md) |
| C8 | no [results.md](../results.md) entry | phase 0 | round | **added**, landscape and detail |

**No adjudication pair was spent.**

### Withdrawn

- **v291: "the" quartic generator suggesting uniqueness.** None is distinguished and every one serves, which the block now says.
- **v292: the literal reading of "separates nothing".** Folded into C5.

### Dependents

- **[sym3-blocks.md](../findings/sym3-blocks.md)'s L92 note** records that L92 retires L84 as a dependency. **Mention.**
- **Observation L83** supplies only the $24$ labels, and the separation holds for every dominant weight. **Nothing moves.**

**Impact `CONTAINED`.**

### What changed

- [sym3-blocks.md](../findings/sym3-blocks.md): the Gate 2 stack replaced by the audit line and the statement with its hypothesis; the proof rewritten Harish-Chandra first; the provenance note removed and the $C_2^2$ sentence corrected.
- [results.md](../results.md): landscape and detail entries added. [lean/INDEX.md](../lean/INDEX.md): the statement row's scope.
- [ATTEMPTS.md](../ATTEMPTS.md): the removed stack and sentences, quoted.
