# Round L09, the high ground has more than one peak

**Id:** L09 · **Date:** 2026-09-14 · **Verifiers:** v282, v283, v284 · **Brief:** [BRIEF_L09.md](BRIEF_L09.md) · **Logs:** `agent_logs/verify-L09-v282.log`, `agent_logs/verify-L09-v283.log`, `agent_logs/verify-L09-v284.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the statement and proof | [findings/graded-half.md](../findings/graded-half.md) lines 264 and 266 |
| the canon | [results.md](../results.md) lines 140 and 485 |
| Lemma L24, given | [second-order.md](../findings/second-order.md), [results.md](../results.md) line 320 |
| Lemma L27, given | [nondegeneracy.md](../findings/nondegeneracy.md) lines 496-498, 511-518, [results.md](../results.md) line 154 |
| the Lean files | [L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean), [L9.lean](../lean/HamiltonsCubic/Results/L9.lean) |

**Withheld**: [graded-half.md](../findings/graded-half.md) line 262 and lines 268-276 (a provenance note, Gate 2 notes, and the paragraphs on other families), and every index row. *[L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) lines 25-36 carry "the audit's governing fact", withheld by instruction.*

## The findings from phase 0

**The proof's last step reads a transverse negative definite Hessian as strict local maximality**, the step [ROUND_L03](ROUND_L03.md) found unwritten and repaired for the balanced product, and the sign of $\theta$ at $\mathbb{HP}^2$ is not stated. Brief item 5.

**"Defect" and "the two named ones" are used and not defined in the passages.** Brief item 6.

## Adjudication

**Verdicts: [v282](VERIFY_v282.md), [v283](VERIFY_v283.md), [v284](VERIFY_v284.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed, impact `NARROWS`, the repair audited `PROVEN` by v285 and v286.** *Unanimous: triality carries the transverse maximality of $S^3\times S^5$ to its image correctly, and nothing shows the image is $\mathbb{HP}^2$.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | $\tau$ orthogonal, preserving the bracket and $Q$ | direct | v282, v283, v284 (`CONFIRMED`) | **confirmed** |
| C2 | $\tau$ preserves $\mathcal W_8$ by permuting the three $35$s | the weight fact has no argument or filed source | v284 (`HYPOTHESIS-DEBT`), v282, v283 (`CONFIRMED`) | **split, settled inline**: triality permutes $8_v,8_s,8_c$, hence $35_x=S^2_0(8_x)$, and fixes $\mathbf 1$, so it preserves their sum and, orthogonally, $\mathcal W_8$. Written in, under audit |
| C3 | $\mathbb{HP}^2=\tau(S^3\times S^5)$ | asserted, in none of the three filed sources, and the $\theta^2=\tfrac{56}{45}$ agreement is sign-blind | v282, v283, v284 (`HYPOTHESIS-DEBT`) | **confirmed**, the statement narrowed to $\tau W_{3,5}$ and the identification routed to Support owed |
| C4 | L27 at $(3,5)$ and the transfer of orbit tangents and $L_e$ | direct, $\tau\,\mathrm{ad}_X\tau^{-1}=\mathrm{ad}_{\tau X}$ | v282, v283, v284 (`CONFIRMED`) | **confirmed** |
| C5 | "strict local maximality transverse to the orbit" | $\theta>0$ unstated and the step from the Hessian unwritten, as in [ROUND_L03](ROUND_L03.md) | v282 (`HYPOTHESIS-DEBT`), v283 (`CONFIRMED AS ALGEBRA`, the sign withdrawn on convention), v284 (`CONFIRMED` at $\theta>0$) | **confirmed**, $\theta=\theta_{3,5}>0$ from Nienhaus through $P\circ\tau=P$, and L3's step cited |
| C6 | "nonzero defect", "sensitive to the value" | "defect" undefined in the passages, never computed at $\mathbb{HP}^2$, and $\tau$ moves the $\Lambda^4$ part | v282, v283, v284 | **removed** |
| C7 | "more than one peak", "several peaks below the two named ones" | one peak exhibited, its orbit never distinguished from $S^3\times S^5$'s | v282, v283, v284 (`HYPOTHESIS-DEBT`) | **repaired**: the balanced product is a second peak by L3, in a distinct orbit since $\tfrac{56}{45}\ne\tfrac{21}{16}$. Under audit |
| C8 | the landscape line's "strict local maximum" with no orbit or dimension | false literally along the orbit | v283 (`REFUTED AS STATED`), v282, v284 (withdrawn on reading) | **restated** with the orbit and $n=8$ |
| C9 | the Lean files | `theorem L9` a non-strict `sorry`, provable from a global maximiser alone since `IsSpectralSplit` need not preserve skew matrices; a docstring's $11/90$ against a proved $49/720$ | v282, v283, v284 | **repaired**: the docstring corrected, the statement row set to not typed, the lemma filed under *out* |

**No adjudication pair was spent.**

### Withdrawn

- **v282, v283: $O(8)$ reflections breaking "$\tau$ normalises the inner automorphisms".** Only orbit tangents are used, and $O(8)$ and $SO(8)$ share them.
- **v282, v284: the landscape line reaching padded $\mathbb{HP}^2$ at $n>8$.** No such claim is made.
- **v283: multiplicity-freeness at $(3,5)$ unstated.** The highest weights are distinct.

### Dependents

- **[results.md](../results.md) line 68**, *"$\mathbb{HP}^2$ is a strict local maximum with nonzero defect (Lemma L9)"*. **NARROWED** in the same commit to the triality image and its value below $\theta_0(8)$.
- **[INDEX-values.md](../findings/INDEX-values.md)**, *"$\mathbb{HP}^2$ and $S^3\times S^5$, a triality pair"*. **Mention**, a value row.

**Impact `NARROWS`.**

### The repair's audit

**Two fresh verifiers, [v285](VERIFY_v285.md) and [v286](VERIFY_v286.md), on [BRIEF_L09_repair.md](BRIEF_L09_repair.md), both `PROVEN`, every attack item confirmed and every candidate withdrawn.** *Each confirmed the preservation of $\mathcal W_8$ from the $S_3$ acting on the outer nodes, $\theta_{3,5}=\sqrt{56/45}$, the transfer of $L_e$ and orbit tangents, and the distinct orbits, $896\ne945$ on cross-multiplying.*

**One wording note from both, applied**: L3's step carries its constant, $-6\theta/(n-2)=-\theta$ at $n=8$, while the transverse bound at $\tau W_{3,5}$ is $-\tfrac34\theta$ from L27's largest off-orbit value $\tfrac38$. The step needs only a negative bound, and the proof now names the one it uses.

**Scope remarks, recorded and not acted on**: the proof works for any automorphism of $\mathfrak{so}(8)$, and "at least two peaks" holds with $W_{3,5}$ itself, so the triality image adds a new orbit only through the owed $\mathbb{HP}^2$ identification.
