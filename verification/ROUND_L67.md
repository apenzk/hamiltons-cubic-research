# Round L67, the second-kind spectrum of the balanced product

**Id:** L67 · **Date:** 2026-09-14 · **Verifiers:** v274, v275, v276 · **Brief:** [BRIEF_L67.md](BRIEF_L67.md) · **Logs:** `agent_logs/verify-L67-v274.log`, `agent_logs/verify-L67-v275.log`, `agent_logs/verify-L67-v276.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement | [findings/bispectral.md](../findings/bispectral.md) line 517 |
| the proof at the block | [findings/bispectral.md](../findings/bispectral.md) line 507 |
| the value of $A$ | [findings/bispectral.md](../findings/bispectral.md) lines 511-513 |
| the surrounding material | [findings/bispectral.md](../findings/bispectral.md) lines 172-196 |
| the canon | [results.md](../results.md) lines 336 and 1102 |
| Lemma L50 | [results.md](../results.md) line 322 |
| the convention | [findings/conventions.md](../findings/conventions.md) lines 96-108 |
| the Lean statement | [L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean) |

**Withheld**: [bispectral.md](../findings/bispectral.md) lines 505, 509 and 515 (a numbering note, a Gate 2 verdict, and a hypothesis note citing a reviewer), [L67.lean](../lean/HamiltonsCubic/Results/L67.lean), whose docstring cites "the audit", and every index row.

## The findings from phase 0

**The block is an annotation stack**: its proof sits in a note, its constant $A$ in another, and the statement's pointer names material 330 lines away. Brief items 1 and 6.

**Passage B's objects $G^{(i)},P_i,t_i$ are defined nowhere in the passages.** Brief item 2.

**The canon's detail says "$A$ is the constant fixed by the normalisation" and then states $A$ in a later sentence**, and carries numerical claims ($2.7\%$ at $m=6$, a fourth value off balance). Brief items 6 and 8.

## Adjudication

**Verdicts: [v274](VERIFY_v274.md) `HYPOTHESIS-DEBT`, [v275](VERIFY_v275.md) `PROVEN`, [v276](VERIFY_v276.md) `PROVEN`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *The three agree that the operator formula yields the spectrum, and split on two facts, each settled from the record or by a three-line derivation.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the block's pointer to "the surrounding material" | the proof sat in a Gate 2 note and the pointer named material 330 lines away | phase 0, v274, v276 | **repaired**, the proof written at the block |
| C2 | $G^{(1)},G^{(2)},G,P_1,P_2,t_1,t_2$ | defined nowhere, one reading fitting $c$ | v274, v275, v276 | **confirmed**, defined in the proof |
| C3 | the list of summands | "the two within-factor trace-free parts and the cross block" omits the line $P_1-P_2$, which carries the bottom eigenvalue | v274 (`GAP`), v276 (owed), v275 (withdrawn, the ratio forcing the reading) | **confirmed**, the three summands written with their eigenvalues and multiplicities |
| C4 | the spectrum | direct substitution, and Li's Theorem 1.8 read at source by a second route | v274, v275, v276 (`CONFIRMED`) | **confirmed** |
| C5 | Passage D's "subtracting the Einstein part" | the shift on the spectrum was unwritten | v274, v276 (`GAP`), v275 (`CONFIRMED`, Li's Example 2.1 uncited) | **repaired**, the multiple $\frac{m-1}{2m-1}G$ named and the lemma cited |
| C6 | $A$ fixed by $\lVert W\rVert_F=1$ | v274 found no link from $\lVert W\rVert_F=1$ to $\sum\omega^2=3$ | v274 (`HYPOTHESIS-DEBT`), v275, v276 (`CONFIRMED`, v276 deriving $\sum\omega^2=3\sum\mu^2$) | **split, settled from the record**: Lemma L50's proof carries the norm relation $\mathop{\mathrm{tr}}(\mathring W^2)=\tfrac34\lvert W\rvert^2$ from Dai–Fu. The arithmetic fixing $A$ is written in the proof |
| C7 | the sign convention | the sign of $A$ depends on $R_{ijij}=+\sec$ as well as the index order | v275, v276 | **stated** |
| C8 | $m\ge2$ | missing from the canon, $W=0$ at $m=1$ | v274, v275, v276 | **confirmed**, written into the canon |
| C9 | $p_3(\mu)=A$ | no $\Lambda^2$ spectrum on file | v274, v276 (`HYPOTHESIS-DEBT`), v275 (`CONFIRMED AS ALGEBRA`) | **split, settled inline**: $W=R-c\,\mathrm{Id}$ on $\Lambda^2$ has eigenvalues $\frac m{2m-1}$ at $m(m-1)$ and $-\frac{m-1}{2m-1}$ at $m^2$, sum of squares a third of the $\omega$ one, so the same scale gives $p_3(\mu)=A$. Written into Passage D |
| C10 | the closure to $\theta_0(2m)$ | $\theta_0$ undefined in the brief, the closure resting on L50 | v274, v275, v276 (`HYPOTHESIS-DEBT`) | **withdrawn as a brief artefact**: $\tfrac32A+\tfrac12(4m^2-6m-1)A=(2m^2-3m+1)A=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$, with $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ on file |
| C11 | "the unbalanced products have a fourth value" | no argument, and false at $S^1\times S^q$ | v274, v275, v276 (`HYPOTHESIS-DEBT`) | **removed** from the canon |
| C12 | the corroboration $0.210818511$ | a $\Lambda^2$ modulus, not an $S^2_0$ eigenvalue, and positive against a negative value | v274, v275 (`HYPOTHESIS-DEBT`), v276 (magnitude only) | **removed** with the note that carried it |
| C13 | the Lean files | a fragment on the tabulated list, the quote drifted, "the audit's point" in the docstrings | v274, v275, v276 | **repaired**: quote and docstrings updated, the statement row set to not typed and filed under *ready* with its binders |

**No adjudication pair was spent.**

### Withdrawn

- **v274, v275: unequal radii as a falsifier.** The normalised Weyl tensor does not depend on the radii.
- **v274: $\lVert W\rVert_F$ ambiguous by a factor of two.** Fixed by the record's pairing of $\sum\mu^2=1$ with $\sum\omega^2=3$.
- **v276: Li's printed index order on p. 7 gives zero on symmetric tensors.** A typo in the source, Li's proofs using the record's order.

### Dependents

- **[L107.lean](../lean/HamiltonsCubic/Results/L107.lean)** imports [L67.lean](../lean/HamiltonsCubic/Results/L67.lean) for $A^2=1/90$ at $m=3$. **SURVIVES**, the constant unchanged.
- **[bispectral.md](../findings/bispectral.md)'s remark that $p_3(\mu)$ at the balanced product is L67's constant.** **SURVIVES**, now derived.
- **The report's Lemma 67** in [06b-bispectral.tex](../report/sections/06b-bispectral.tex). **Corrected**, $m\ge2$ and the index order added. *The PDF is not rebuilt.*

**Impact `CONTAINED`.**

### What changed

- [bispectral.md](../findings/bispectral.md): the annotation stack replaced by the statement with its hypotheses and conventions and the full proof. Passage D's shift named and the $\Lambda^2$ derivation of $p_3(\mu)=A$ added.
- [results.md](../results.md): both entries restated, the fourth-value and $2.7\%$ sentences removed.
- [L67.lean](../lean/HamiltonsCubic/Results/L67.lean), [L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean), [lean/INDEX.md](../lean/INDEX.md): as in C13.
- [ATTEMPTS.md](../ATTEMPTS.md): the removed block and canon, quoted.
