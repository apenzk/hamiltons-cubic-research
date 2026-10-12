# Round L66-r2, the repair audit of the decomposability exclusion

**Id:** L66-r2 · **Date:** 2026-09-14 · **Verifiers:** v401, v402, v403 · **Brief:** [BRIEF_L66r2.md](BRIEF_L66r2.md) · **Logs:** `agent_logs/verify-L66-v401.log`, `agent_logs/verify-L66-v402.log`, `agent_logs/verify-L66-v403.log`

**Why this round.** [ROUND_L66](ROUND_L66.md) added $n\ge4$, the Nienhaus citation, the direct citation for the total symmetry of $T$ and the exact witness for the absolute values, and restated both canon entries. That text is new and re-enters unchecked, so L66 is audited again whole.

## Sources, verbatim

| passage | source |
| --- | --- |
| the section carrying the argument | [findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 1-17 |
| the block | [findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 33, 37 |
| the canon | [results.md](../results.md) lines 347, 1161, 1163 |
| Lemma L24's argument, given | [findings/second-order.md](../findings/second-order.md) line 67 |
| Nienhaus Proposition 2.25 | [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 1483-1490 |
| conventions | [findings/conventions.md](../findings/conventions.md) lines 15, 24, 77, 136 |
| the Lean files | [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean), [L66.lean](../lean/HamiltonsCubic/Results/L66.lean), declarations only |

**Withheld**: the provenance line at line 35, the section's numerical *Additivity verified* paragraph and everything after it, every prior round file, the Lean docstrings, and every index row.

## The findings from phase 0

**The citation for total symmetry resolves.** Passage A's wording, "the symmetrisation of $\operatorname{tr}(XYZ)$" and "both totally antisymmetric structure constants", matches Lemma L24's argument at [second-order.md](../findings/second-order.md) line 67 in substance, where it reads "both totally antisymmetric $c$'s". Brief item 2.

**The Lean statement file types an abstract form symmetric in two slots.** [lean/INDEX.md](../lean/INDEX.md) marks L66Statement `statement: typed` over a trilinear form symmetric in its first two slots, where Passage A names total symmetry. Brief item 10.

**Index row 66 in [INDEX-results.md](../findings/INDEX-results.md) still carries Gate 2 commentary**, and is corrected at the fold whatever the verdict.

## Phase 2, clustering

**Verdicts: [v401](VERIFY_v401.md), [v402](VERIFY_v402.md), [v403](VERIFY_v403.md) all `PROVEN`.** *All three confirm the definition across the passages, the total symmetry of $T$ for the $W^2$ and $\#$ parts with the $\tfrac12$, additivity with its one slot move, $\lvert P(A_i)\rvert\le M(n)$ by oddness, the chain and its strictness, $\max_i\lvert a_i\rvert<1$, $M(n)>0$ at every $n\ge4$ from Proposition 2.25 at $(k,l)=(2,n-2)$ with its normalisation and $\#$ scale matched to the record's, the absolute-value witness, the canon's detail and landscape lines, and the existence of $\circ$-decomposable elements at every $n\ge4$ from padded self-dual and anti-self-dual pieces.*

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| K1 | "Criticality with ordinary orthogonality is a different hypothesis from $\circ$-orthogonality" | its figures rest on a run at $n=8$ and it says no closed-form witness is on file, and the proof never uses it | v401, v402, v403 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L66r2_K1.md](ADJ_L66r2_K1.md) |
| K2 | `theta0_four`, `M4_exceeds`, `M4_ratio` in L66.lean | no counterpart in the passages | v402, v403 | **check 1**, no adjudication |
| K3 | L66Statement.lean's form symmetric in its first two slots only | weaker than the total symmetry the argument uses, with the Weyl link entering as hypotheses | v401, v402, v403 (`CONFIRMED`) | **not a defect**: the typed statement is a generalisation whose hypotheses the passages supply |

**Withdrawn by their verifiers:** the slot order of $T$ differing between Passages A and C, "$S^k\times S^l$" as shorthand, "fails at any negative coefficient", "strict only because of that", pieces with $\theta_A=0$, $W$ not normalised in the chain, and "maximizer" read as local, each read correctly in context.

**Check 1, the brief against the source.** Every passage was copied off disk by line with its first words asserted. **K2 is brief-induced**: the three declarations formalise $M(4)=\sqrt{3/2}$ against $\theta_0(4)$ in the section's *This is not new* paragraph, which the brief withheld.

**Check 2, the whole record.** No closed-form witness for K1 is written in [findings/](../findings/), [results.md](../results.md), [report/](../report/) or [ATTEMPTS.md](../ATTEMPTS.md). **Copies of the statement**: the report's Lemma 66 at [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1161 agrees with the block. **[09-status.tex](../report/sections/09-status.tex) line 172 drops a hypothesis**: it says $\sum a_i^2=1$ with $k\ge2$ forces every $\lvert a_i\rvert<1$, which $a=(1,0)$ refutes, and the block's "every $a_i\ne0$" is what makes it true. That copy is corrected at the fold.

## Phase 3, adjudication

**Two fresh verifiers on K1, asked the step neutrally:** v404 and v405.

| id | adjudicators | outcome |
| --- | --- | --- |
| K1 | [v404](VERIFY_v404.md) `FAILS`, [v405](VERIFY_v405.md) `FAILS` | **confirmed**: the claim true, the paragraph not establishing it |
| K2 | check 1 | **brief-induced**, no change |
| K3 | not a defect | no change |

**K1.** Both adjudicators find the non-implication true and the paragraph's only support a run with approximate values, which the paragraph itself says has no closed-form witness. **Both give the same witness independently**: at $n=4$ on $\Lambda^+$, where tracelessness of $Q$ forces $Q(A)=3A^2-\operatorname{tr}(A^2)I$, the unit pair $A=\mathrm{diag}(2,-1,-1)/\sqrt6$ and $B=(J-I)/\sqrt6$ is critical at $\theta=\tfrac{\sqrt6}2$ with $\operatorname{tr}(AB)=0$ and $A\circ B=\tfrac14M\ne0$. v402 reached the same pair as a screen in phase 1. The loop checked it by hand: $A^2=\mathrm{diag}(4,1,1)/6$ gives $Q(A)=\mathrm{diag}(1,-\tfrac12,-\tfrac12)=\tfrac{\sqrt6}2A$, the diagonal of $J-I$ is zero so $\operatorname{tr}(AB)=0$, $(AB+BA)_{ij}=(d_i+d_j)(J-I)_{ij}/6$ with $d=(2,-1,-1)$ gives $M/6$, and $\lVert M\rVert^2=12$. Normalised this way $\theta=\sqrt{3/2}$, the $\mathbb{CP}^2$ value, and $Q$ reproduces $\theta_{2,2}=\tfrac{\sqrt3}2$ (v404). The pair replaces the run.

## Phase 4, dependents

**No dependent uses the paragraph**, which the proof never reads. The copies found in phase 2: the report's Lemma 66 agrees with the block, and [09-status.tex](../report/sections/09-status.tex) line 172 dropped "every $a_i\ne0$", corrected in this change. **Impact `CONTAINED`**: the side claim is kept and now carries its witness.

## Phase 5, what was changed

**Verdict: `PROVEN`.**

- [support-dichotomy.md](../findings/support-dichotomy.md): the run report replaced by the closed-form pair at $n=4$.
- [09-status.tex](../report/sections/09-status.tex): the status bullet's bound on $\lvert a_i\rvert$ names every $a_i\ne0$. The report was rebuilt.
- [INDEX-results.md](../findings/INDEX-results.md) row 66: the Gate 2 commentary replaced by the verdict.
- [ATTEMPTS.md](../ATTEMPTS.md): the round's account and the replaced passages.

**The witness paragraph is new text**, so L66 keeps its box with a repair audit owed.

## Phase 6

L66 keeps its box in *To check* with a repair audit owed, and one line goes under *Checked*. The next id is L67.
