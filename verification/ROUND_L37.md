# Round L37, diagonality is decided by a single kernel

**Id:** L37 · **Date:** 2026-09-07 · **Verifiers:** v212, v213, v214 · **Brief:** [BRIEF_L37.md](BRIEF_L37.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 509-513 |
| the landscape statement | [results.md](../results.md) line 160 |
| a summary-table row | [results.md](../results.md) line 16 |
| the block | [findings/target.md](../findings/target.md) lines 632-648 |

## The findings from phase 0

**This is the first row in the queue whose block is a written proof rather than an annotation stack.** Statement, both directions, the corollary, and three paragraphs of scope, no blockquote correcting the text beside it. *So the round's job here is the ordinary one, and a clean pass would be the audit's first.*

**One range appears in the proof and in neither statement.** The converse says *"For $n\ge3$ that forces the $a_i$ themselves distinct"*; the canonical entry, the landscape line and the summary row all state the equivalence with no range at all. **What happens at $n=2$ is the round's first question**, and whether $n\ge3$ is the right threshold the second.

**The summary row calls it "Proven" in a table of the programme's standing claims**, which is a stronger advertisement than either prose statement makes; the round is asked whether the three agree.

## What the verifiers are asked beyond the standing list

Whether $\delta_A$ really is the derivation extension and acts on $\varphi_{ij}$ by $a_i+a_j$; whether $A=\sum_i2^if_if_i^{\mathsf T}$ does what the forward direction needs, and whether *"never a genericity obstruction"* follows; whether pairwise-distinct **sums** force pairwise-distinct $a_i$, and at which $n$; whether simple spectrum on $\Lambda^2$ plus $[W,\delta_A]=0$ really gives diagonality **in $A$'s eigenframe**; whether the corollary's *"all $n$ diagonal matrices"* is right and whether $\dim\ker\Phi_W=1<4$ at $n=4$ is a correct non-vacuity witness; and **whether the Zariski argument for decidability is sound, including that a polynomial non-vanishing on a dense open subset is decidable from the subspace alone.**

**And the standing question**: [Observation L40](../results.md) consumes this test over the catalogued critical points. Say what it may cite, and whether frame-independence is enough for that use.

## Adjudication

**Verdicts: [v212](VERIFY_v212.md), [v213](VERIFY_v213.md), [v214](VERIFY_v214.md) all `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** **The first unanimous pass of this run, and the first row whose block was a written proof rather than an annotation stack.** *The correlation is worth noting and is not evidence: the tidy block still owed six corrections, and one of them was a reversed implication that a stack of visible annotations would have made harder to miss.*

**Every step holds, rebuilt three times.** $\delta_A$ preserving the skew matrices, being the derivation extension with no leftover factor, and acting by $a_i+a_j$; the forward direction with $A=\sum_i2^if_if_i^{\mathsf T}$; the converse; the corollary; the quantifier remark; and frame-independence.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | every step of both directions | independent re-derivation | 3/3 | `CONFIRMED` |
| **C2** | the converse's chain | *"distinct sums forces the $a_i$ distinct, **so** simple spectrum"* | 1/3 | **`CONFIRMED` as written**, see below |
| **C3** | the range | $n\ge3$ in the proof, absent from all three statements | 3/3 | `CONFIRMED`, **the statements are right and the proof owed the case** |
| **C4** | polynomiality | the condition is stated in eigenvalues, which are not polynomial in $A$ | 3/3 | `CONFIRMED`, bridge written, *"decided outright"* struck |
| **C5** | the non-vacuity witness | names no $W$; the record's value is measured | 3/3 | `CONFIRMED`, $W$ named, derivation filed not adopted |
| **C6** | *"only the corollary is one-directional"* | no witness at all | 2/3 | `CONFIRMED`, same treatment |
| **C7** | $W\in\mathcal W_n$ | unused by the **whole** equivalence, not just the corollary | 3/3 | `CONFIRMED`, the scope widened |
| **C8** | *"carries no information about $\theta$"* | not this lemma's claim, and false literally | 3/3 | **`REFUTED`**, reattributed |
| **C9** | $\delta_A$ against the tabled $D_A$ | one operator under two letters | 2/3 | `CONFIRMED`, tabled |
| **C10** | *"all $n$ diagonal matrices"*, *"$A$ commutes with $W$"* | a dimension read as a count; the commuting pair misnamed | 2/3 | `CONFIRMED`, reworded |

### C2, the one defect a clean-looking proof concealed

The converse read *"pairwise-distinct sums. For $n\ge3$ that forces the $a_i$ themselves distinct, **so** $\delta_A$ has simple spectrum"*. **Chained literally that is invalid**: distinct $a_i$ do not give distinct sums, and $A=\mathrm{diag}(0,1,2,3)$ has spectrum $\{1,2,3,3,4,5\}$ on $\Lambda^2$. *One verifier read the sentence charitably (the "so" attaching to the sums rather than to the $a_i$) and found the converse clean, which is the reading that makes it true.* **Both readings are available from the words, which is the defect.** The repaired text says what is actually the case: **distinctness of the sums IS simple spectrum**, the eigenvalues on $\Lambda^2$ being exactly the $a_i+a_j$; distinctness of the $a_i$ is a separate consequence, needed only to make *"$A$'s eigenframe"* well defined.

### C3, and the suspicion resolved the other way

**Phase 0 asked whether the unrestricted statements were overclaiming. They are not.** At $n=2$ the proof's step genuinely fails (there is one pair, so $\mathrm{Id}$ has vacuously distinct sums with $a_1=a_2$), **while the statement is true for an unrelated reason**: $\Lambda^2\mathbb R^2$ is a line, so every $W$ is diagonal and both sides hold. *A range in a proof and in no statement is usually the statement's fault; here it was the proof's.* The block now carries the case and the statements carry no range.

### C5 and C6, where the round declined a gift

**Two of the block's remarks rest on nothing checkable**: the non-vacuity $\dim\ker\Phi_W=1<4$ names no $W$ and is a measured value, and *"only the corollary is one-directional"* names no object. **All three verifiers derived closed forms**, a self-dual parity argument giving $\ker\Phi_{W_{\mathbb{CP}^2}}=\mathbb R\,\mathrm{Id}$ exactly, and padded $W_{\mathbb{CP}^2}$ at $n=8$ with $\dim\ker\Phi_W=1+\binom52=11>8$ while non-diagonal, reproducing a second measured value analytically. *Two of them also reproduced the record's measured kernel dimensions at $n=8$ from a closed form.* **None of it is adopted here.** A check may not write the proof it checks, and these would enter the record as verification while being new mathematics; they are filed in [plan.md](../plan.md) pointing at the reports that hold them.

### C8, reattributed rather than repaired

*"Carries no information about $\theta$"* sat inside a lemma the summary table marks **Proven**. **It is not what this block proves, and on its literal reading it is false**, diagonality bounds $\theta\le\Theta_n$. It belongs to post F22, whose stronger form the record already grades overstated, and the canonical entry now says so.

### What is not repaired here

**C5 and C6's closed forms are filed in [plan.md](../plan.md)**, since writing them in would be the round proving its own subject. Everything else was a correction and is applied.

