# Round L86, the parity rule and the unknown count

**Id:** L86 · **Date:** 2026-09-14 · **Verifiers:** v296, v297, v298 · **Brief:** [BRIEF_L86.md](BRIEF_L86.md) · **Logs:** `agent_logs/verify-L86-v296.log`, `agent_logs/verify-L86-v297.log`, `agent_logs/verify-L86-v298.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 70, 84-99 |
| the block table, given | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36 |
| the canon | [results.md](../results.md) lines 290 and 962 |

**Withheld**: the Gate 2 stack under the heading, and every index row. *The argument itself names reviewers 170, 174, 177 and 178 as the sources of measurements, left in place because it is quoted whole.*

## The findings from phase 0

**$H$ and $W_0$ are defined nowhere in [findings/](../findings/)**, so the brief defines them. **The unknown count reads Observation L83's multiplicities.** Brief items 2 and 8.

## Adjudication

**Verdicts: [v296](VERIFY_v296.md), [v297](VERIFY_v297.md), [v298](VERIFY_v298.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS`.** *Unanimous on every cluster.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the reduction to $\sigma_\lambda(W_0)=0$ with $\sigma_\lambda(W_0)\in V_\lambda^H$ | algebra right; $F_5(W_0)=0$ unsourced and the certificate model never stated | v296, v297 (`CONFIRMED AS ALGEBRA`, model unstated), v298 (`HYPOTHESIS-DEBT` on $F_5(W_0)=0$) | **confirmed**, both premises routed to Support owed |
| C2 | the stabiliser | attributed to a reviewer, no derivation | v296, v297, v298 (`HYPOTHESIS-DEBT`) | **granted** in the statement, routed |
| C3 | the branching and the parity mechanism | direct | v296, v297, v298 (`CONFIRMED`) | **confirmed** |
| C4 | the parity rule as stated in the canon | $-I\in H$ fixes every $4$-tensor, so on a module where $-I$ acts by $-1$, $V^H=0$; $\mathbb R^5$ at $(1,0)$ and $\det$ at $(0,0)$ | v296, v297, v298 (`REFUTED AS STATED`) | **confirmed**, the hypothesis written into the block and canon; the hand-check $(1,0)\mapsto1$ located in $\mathbb R^5\otimes\det$ |
| C5 | $\varepsilon$ redundant | direct | v296, v297, v298 (`CONFIRMED`) | **confirmed** |
| C6 | $16$ blocks, $3570$, $25$, $36$, the shape, the eight deaths | exact against Observation L83's table | v296, v297, v298 (`CONFIRMED AS ALGEBRA`) | **confirmed**, resting on an Observation |
| C7 | the rank-one step and "exactly $36$" | a measured $3570$, the link to L87 owed by the passage's own account | v296, v297, v298 (`HYPOTHESIS-DEBT`) | **narrowed** to $\ge36$, the step routed |
| C8 | the canon's "the heading claiming $65$" | the heading says $\ge36$ | v296, v297, v298 (withdrawn as editorial) | **removed** |

**No adjudication pair was spent.**

### Dependents

- **L87**, the rank-one step, and **L88**, whose $47=36+11$ transports through the parity rule: both use the rule only on constituents of $\mathrm{Sym}^3(\mathcal W_5)$, where the added hypothesis holds. **SURVIVE** the hypothesis; L88's round is next and reads the narrowed count.

**Impact `NARROWS`.**
