# Round L84-r2, the repair audit of Casimir separation

**Id:** L84-r2 · **Date:** 2026-09-14 · **Verifiers:** v411, v412 · **Brief:** [BRIEF_L84r2.md](BRIEF_L84r2.md) · **Logs:** `agent_logs/verify-L84-v411.log`, `agent_logs/verify-L84-v412.log`

**Why this round.** [ROUND_L84](ROUND_L84.md) replaced the block's Gate 2 stack with a statement carrying its generator hypothesis, rewrote the proof Harish-Chandra first, corrected the $C_2^2$ sentence, and added both canon entries. **A repair audit under the skill's rule: two verifiers, briefed on the text that round wrote**, with the premise it rests on.

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and statement | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 38, 42 |
| the proof section and the $C_2^2$ paragraph | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 44-50 |
| the canon | [results.md](../results.md) lines 289, 977, 979 |
| the $24$-block table, given | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-32 |
| the Lean files | [L84Statement.lean](../lean/HamiltonsCubic/Results/L84Statement.lean), [L84.lean](../lean/HamiltonsCubic/Results/L84.lean), declarations only |

**Withheld**: the audit line at line 40, Observation L83's block and its notes, everything after line 50, every prior round file, the Lean docstrings, and every index row.

## The findings from phase 0

**The Harish-Chandra isomorphism enters as imported and unreferenced.** The proof takes from it $\gamma$ injective onto the $W(B_2)$-invariants and $\mathbb R[p_2,p_4]$ as those invariants. Brief item 2.

**The Lean statement is typed in power sums with no central element**, so the Harish-Chandra step and the generator condition stand outside it. Brief item 8.

**Index row 84 in [INDEX-results.md](../findings/INDEX-results.md)** is read at the fold.

## Phase 2, clustering

**Verdicts: [v411](VERIFY_v411.md), [v412](VERIFY_v412.md) both `PROVEN`.** *Both confirm the Harish-Chandra step, $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ with $a\ne0$, the recovery of $\ell$ from $(p_2,p_4)$ with $\ell_1>\ell_2>0$ at every dominant weight, all $24$ values of $c_2$ and the six $p_4$ values by hand, the $C_2^2$ reading, the canon against the block, and the boundary cases.*

**No finding is adjudicated.** Both reports raise remarks and neither grades a defect: the normalisation of $C_2$ is unnamed and every conclusion survives rescaling it, the proof uses two parts of the Harish-Chandra theorem it does not name (that $\gamma$ is an algebra homomorphism sending central elements of degree $n$ to polynomials of degree at most $n$, and $C_2$'s eigenvalue $(\lambda,\lambda+2\rho)$), and `single_quartic_worse` in L84.lean types $18<21<24$ without the quartic its name refers to. v412 withdrew $C_4=iC_2^2$ over $\mathbb C$, the notation $\mathbb R[C_2]$ fixing the real reading.

## Phases 4 to 6

**No defect, so no dependent moves.** Index row 84 carried Gate 2 commentary stating that one generator separates $18$ of $24$, which contradicts the block's "every one serves", and it now carries the verdict. **Verdict: `PROVEN`.** L84's box is deleted from *To check* and one line goes under *Checked*.

**The verification loop pauses here at the user's request**, recorded under *Queue changes* in [plan-verification.md](../plan-verification.md), with ten boxes still open.
