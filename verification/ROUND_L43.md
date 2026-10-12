# Round L43, the criterion at $a=0$ demands exactly $\theta_0(n)$

**Id:** L43 · **Date:** 2026-09-14 · **Verifiers:** v233, v234, v235 · **Brief:** [BRIEF_L43.md](BRIEF_L43.md) · **Logs:** `agent_logs/verify-L43-v233.log`, `agent_logs/verify-L43-v234.log`, `agent_logs/verify-L43-v235.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the findings statement | [findings/problem.md](../findings/problem.md) lines 594-608 |
| the landscape statement | [results.md](../results.md) line 100 |
| the canonical entry | [results.md](../results.md) lines 368-372 |
| the derivation the block points at | [findings/problem.md](../findings/problem.md) lines 32-70 |
| L44's canonical clause on Beitz Lemma 2.3.4 | [results.md](../results.md) line 376 |
| the Lean statement | [L43Statement.lean](../lean/HamiltonsCubic/Results/L43Statement.lean), whole file, no `sorry`, a fragment |

## The findings from phase 0

**The derivation still carries the one-directional reading of Beitz Lemma 2.3.4 that [ROUND_L44](ROUND_L44.md) corrected.** Line 70 of [problem.md](../findings/problem.md) says the lemma "supplies only the converse" of invariance $\Rightarrow G\le0$; [the Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) now transcribe it as a biconditional whose first clause is that direction, and L44's canon says so. *A correction that reached the source note and the canon and not the derivation consuming it.* Brief item 4 puts both passages to the verifiers unlabelled.

**Three forms of the collapsed inequality are in play.** The derivation and the canon collapse to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$; the block's display is $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$; the canon writes "$c(n-1)=\theta_0(n)$" with no normalisation, while the derivation reaches it only after "Normalising $\lVert W\rVert=1$" on $\partial\Omega_0$. *The block's "identity on the whole slice" and the canon's unqualified equality are the claims brief item 2 asks about.*

**A sentence in the derivation is broken by an inserted citation**: *"… is what selects it.* **Three verifiers, [ROUND_L43-arg](…)**, so the bound demanded is"*. The link target is the established file for that earlier round, so the defect is the sentence, not the link.

**The third form is a fragment by design**: [L43Statement.lean](../lean/HamiltonsCubic/Results/L43Statement.lean) types the boundary constant and the agreement of the two readings at unit norm, and states that the collapse needs $\Phi$, $I$ and the decomposition, which the real layer lacks. *Phase 1c applies: whether that base-layer gap is buildable is checked after the reports land.*

## Adjudication

**Verdicts: [v233](VERIFY_v233.md), [v234](VERIFY_v234.md), [v235](VERIFY_v235.md) all `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *All three rebuilt the collapse by hand, $G(cI+W)=\frac2{c^2\lVert\mathrm{ric}\,I\rVert^2}\big(\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2\big)$ at every $c\ne0$, so the block's "identity on the whole slice" stands; what failed is where the canon places the constant, and one citation.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the canon's "$c(n-1)=\theta_0(n)$" (landscape and detail) and the Böhm–Wilking bullet | holds only on $\partial\Omega_0$ at $\lVert W\rVert=1$; witness $R=2(c_0I+W)$ on $\partial\Omega_0$ with $c(n-1)=2\theta_0(n)$ | v233, v234, v235 | **confirmed**, scope written into all three sites |
| C2 | the derivation's "Lemma 2.3.4 supplies only the converse" | at source the first clause is invariance $\Rightarrow G\le0$, and $\tfrac d{dt}\mathrm{scal}>0$ shows only that $\{\mathrm{scal}>0\}$ is invariant | v233, v234, v235 | **confirmed**, replaced |
| C3 | L44's "first clause, whose hypotheses check" | the clause assumes every sublevel set invariant; its proof uses one level, which is what $\Omega_0$ supplies | v234, v235 (`GAP`), v233 (hypotheses corrected) | **confirmed**, both sites now cite the clause through its proof |
| C4 | the Lean docstring's "no $\Phi$" and `lower_nappe_is_different`'s gloss | `Qop` is $\Phi$; the theorem types only the sign of $\theta_0(n)$ | v233, v234, v235; v234, v235 | **confirmed**, docstring and index row repaired |
| C5 | the derivation's sentence with the inserted round citation | does not parse | v233, v234, v235 | **confirmed**, citation removed from the sentence |
| C6 | "the cone has three endpoints" (canon), "convexity forces it independently" (block) | the family has two ends; convexity forces one nappe and needs $I\in\Omega_0$ to choose it | v233, v234; v234 | **confirmed**, reworded |

**No adjudication pair was spent.** *C1 carries a closed-form witness any reader checks in a line; C2 and C3 are readings of one lemma at source, reached identically by three verifiers and agreeing with [the Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) as [ROUND_L44](ROUND_L44.md) corrected them; C4 to C6 are text facts.*

### Dependents

- **[L44](../findings/problem.md) SURVIVES**: it applies the criterion at padded $W_{\mathbb{CP}^2}$, a unit-norm point on $\partial\Omega_0$, exactly the scope C1 writes in. Its citation of Beitz is C3's repair.
- **The landscape bullets naming L43** (the threshold bullet and the Böhm–Wilking bullet in [results.md](../results.md)) survive at the corrected scope; the second carried C1's defect and is repaired.
- **[L45](../findings/target.md)** takes over off the slice and does not use the constant's scope.

### Phase 1c, the third form

**The collapse stays untyped, and the reason is now stated correctly**: the layer has $\Phi$ as `Qop` but no identity operator, no $\mathrm{ric}_0$ decomposition, no $F$, and neither Böhm–Wilking fact. *Typing the collapse with those facts as binders is possible and would be a conditional statement whose content is the quotient-rule algebra; it is filed as the natural next Lean item for L43 rather than built this round.*

### What was changed

- [results.md](../results.md): the scope "on $\partial\Omega_0$ at $\lVert W\rVert=1$" written into the landscape statement, the detail statement and the Böhm–Wilking bullet; "three endpoints" replaced by the family's range; L44's Beitz citation read through the clause's proof.
- [problem.md](../findings/problem.md): the Beitz sentence replaced by the first clause read at one level; the broken sentence repaired; the convexity remark given the hypothesis it needs.
- [L43Statement.lean](../lean/HamiltonsCubic/Results/L43Statement.lean) docstring and [lean/INDEX.md](../lean/INDEX.md): $\Phi$ is `Qop`; `lower_nappe_is_different` glossed as the sign fact it is.

### The round's own defects

**The brief omitted the pathspec form of the commit.** *v234 committed with the index holding the session's staged L49 Lean discharge, so [215ff83d](../lean/HamiltonsCubic/Results/L49Statement.lean) carries that discharge under v234's message; nothing was lost and the build passed, and the provenance is recorded in [ATTEMPTS.md](../ATTEMPTS.md).*
