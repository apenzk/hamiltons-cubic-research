# Round L66, no maximizer is $\circ$-decomposable

**Id:** L66 · **Date:** 2026-09-14 · **Verifiers:** v271, v272, v273 · **Brief:** [BRIEF_L66.md](BRIEF_L66.md) · **Logs:** `agent_logs/verify-L66-v271.log`, `agent_logs/verify-L66-v272.log`, `agent_logs/verify-L66-v273.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the numbered block | [findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 33-37 |
| the argument | [findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 1-17 |
| the canon | [results.md](../results.md) lines 334 and 1096 |
| the definitions | [conventions.md](../findings/conventions.md) lines 24 and 136, [second-order.md](../findings/second-order.md) line 63 |
| the harmonic-square law | [nondegeneracy.md](../findings/nondegeneracy.md) lines 356-359 |
| the Lean statement | [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean) |

**Withheld**: [support-dichotomy.md](../findings/support-dichotomy.md) lines 19-31 (a numerical check and the section on prior versions), [L66.lean](../lean/HamiltonsCubic/Results/L66.lean), whose docstring cites "the audit", and every index row.

## The findings from phase 0

**Passage C's detail bounds $\lvert P(W)\rvert$ while the argument bounds $P(W)$**, and the step $\lvert P(A_i)\rvert\le M(n)$ rests on $P$ being odd. Brief items 3 and 8.

**$M(n)>0$ is cited to sphere products with no dimension named.** Brief item 3.

**The Lean theorem assumes symmetry in the first two slots of $T$ only**, where the argument names total symmetry. Brief items 2 and 9.

## Adjudication

**Verdicts: [v271](VERIFY_v271.md) `HYPOTHESIS-DEBT`, [v272](VERIFY_v272.md) `PROVEN`, [v273](VERIFY_v273.md) `HYPOTHESIS-DEBT`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *The three agree on every step of the chain and on every side claim, and split only on whether $M(n)>0$ is on file, which the loop settles from the filed source.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the block's pointer | the argument is the file's opening section | v271, v272, v273 (`CONFIRMED`) | **confirmed**, the numbering note replaced by the audit line |
| C2 | additivity and the total symmetry of $T$ | every term with two distinct indices dies once $T$ is fully symmetric, and the cited reason "$\nabla P=3Q$" is the same fact, and the same line of second-order.md proves the symmetry directly | v271, v272, v273 (`CONFIRMED`, the citation candidate withdrawn by each) | **confirmed**, citation replaced by the direct argument |
| C3 | $M(n)>0$ "since any sphere product attains a positive value" | no argument in the passages, false as written at $S^1\times S^{n-1}$, whose Weyl tensor is zero | v271, v273 (`HYPOTHESIS-DEBT`), v272 (`CONFIRMED` on Nienhaus Proposition 2.25) | **split, settled inline**: the filed proposition gives $P(W_{S_{k,l}})=\theta_{k,l}>0$ for $k,l\ge2$, written in |
| C4 | the dimension | $\mathcal W_n=0$ at $n\le3$, where the statement is vacuous and $M(n)$ undefined | v271, v272, v273 | **confirmed**, $n\ge4$ written in |
| C5 | the chain and $\max_i\lvert a_i\rvert<1$ | direct | v271, v272, v273 (`CONFIRMED`) | **confirmed** |
| C6 | the witness at $(0.6,-0.8)$ | exact values $\tfrac{91}{125}M$ and $-\tfrac{37}{125}M$ | v271 (`CONFIRMED`), v272, v273 (`CONFIRMED AS ALGEBRA`) | **confirmed**, written as exact rationals |
| C7 | "criticality does not derive $\circ$-orthogonality" | decimal witnesses from a run only | v271, v272, v273 (`HYPOTHESIS-DEBT`) | **relabelled** as a run with no closed-form witness |
| C8 | "at $k=2$, criticality plus ordinary orthogonality gives exact additivity", "strictly weaker" | no argument on file, unused | v271, v272, v273 (`HYPOTHESIS-DEBT`) | **removed** |
| C9 | the $(S^4)^3$ and $\Lambda^+/\Lambda^-$ splittings, and full-dimension summands | $\circ$-orthogonality of the pieces argued nowhere, unused | v271, v272, v273 (`HYPOTHESIS-DEBT`) | **removed**, the canon's sentence restated as what the lemma does not bound |
| C10 | the canon's $\lvert P(W)\rvert<M(n)$ and "reads $0<0$" | direct | v271, v272, v273 (`CONFIRMED`) | **confirmed** |
| C11 | the canon's harmonic-square clause for $k$ pieces | the law is argued for two pieces, and its derivation needs the pieces critical | v271, v272, v273 (`HYPOTHESIS-DEBT`) | **narrowed** to two critical pieces |
| C12 | "above $\min_i\lvert\theta_i\rvert$ whenever the pieces differ" | fails for distinct pieces with equal $\lvert P\rvert$, holds read charitably | v271, v272 (`CONFIRMED AS ALGEBRA`), v273 (charitable) | **reworded** to the limit statement alone |
| C13 | the Lean statement | abstract core proved with symmetry in the first two slots, the $\mathcal W_n$ instantiation and $M>0$ as hypotheses, the record quote drifted | v271 (`CONFIRMED`), v272, v273 (`CONFIRMED AS ALGEBRA`) | **confirmed**, quotes, docstrings and rows made exact |

**No adjudication pair was spent.** *C3 is a split on whether a fact is on file, settled by reading the filed proposition.*

### Withdrawn

- **v273: "above every heading" misplaces the argument, line 1 being the title.** Withdrawn, the title being a heading the section sits under.
- **v273: Passage C's "every cross term $T(A_i,A_j,\cdot)$" skips terms $T(A_i,A_i,A_l)$.** Withdrawn, full symmetry covering them. The canon now says so.
- **v271, v272, v273: type mismatches and docstring overstatements in the Lean file.** Six candidates in all, each withdrawn with its reason in its report.

### Dependents

- **The report's figures**, *"no maximizer is $\circ$-decomposable"*, and Lemma 66 in [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), a copy. **Corrected** in the tex, $n\ge4$ and the citation added and the $(S^4)^3$ sentence removed. *The PDF is not rebuilt, which the next report update owes.*
- **The conjecture's stratum reduction** uses the lemma at $n\ge12$. **SURVIVES**, $n\ge4$ holding there.

**Impact `CONTAINED`.**

### What changed

- [support-dichotomy.md](../findings/support-dichotomy.md): $n\ge4$, the Nienhaus citation, the direct symmetry citation, the exact witness, the run relabelled, two unargued side claims removed, the block's audit line.
- [results.md](../results.md): both entries restated. [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex): the copy corrected.
- [L66.lean](../lean/HamiltonsCubic/Results/L66.lean), [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean), [lean/INDEX.md](../lean/INDEX.md): docstrings, quotes and rows.
- [ATTEMPTS.md](../ATTEMPTS.md): the twelve removed or replaced passages, quoted.
