# ROUND L15, the Bianchi defect identity, its constant, and the label it carries

**Id:** L15. **Source:** [findings/problem.md](../findings/problem.md):190–204, with the canonical form at [results.md](../results.md):643 and the landscape line at :218. **Date:** 2026-09-07. **Verifiers allocated:** v122, v123, v124. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.

**Why this id.** Tier 1, cited eight or more times, and **its identity is imported by [Lemma L7](../findings/bounds.md)**, the record's only bound holding at every critical point. A round on L7 pinned that import's coefficient without checking the identity itself.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Does the identity hold, with that constant, in every dimension?** **Derive it, and check the constant $6$ and the claim that there is no cross-term. Say which normalisation of $\#$, of $\operatorname{scal}$ and of the $\Lambda^2$ inner product the constant depends on, and what it would become under the alternatives the record uses elsewhere.**
2. **Is the displayed content this result's own?** *The block records the identity as something another file already carries under a different name.* **Say what is stated here that is not stated there, and what a consumer citing L15 gets that citing the other would not.**
3. **What does the identity establish about the lifting obstruction?** *The heading claims two obstructions rather than one.* **Say which of them the displayed identity bears on, and whether the second is established here, elsewhere, or nowhere.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

$$\operatorname{scal}(R^2+R^\#)=\|\mathrm{Ric}(R)\|^2+6\|\mathrm{Alt}(R)\|^2,$$

$\mathrm{Alt}$ being the projection onto $\Lambda^4$, with the constant exactly $6$ in every dimension and no cross-term. So the invariant master inequality carries an extra $+24\|\mathrm{Alt}(W_-)\|^2$, and that term is not a technicality: at Fox's $\mathcal S^4(\alpha)$ it is exactly what makes his inequality fail, by a factor of three at a genuine critical point, while the corrected version is saturated there. Every sphere product, in any frame, has defect zero.

### The canonical form, quoted alongside without comment

**Observation L15 (lifting). The Bianchi defect of the spectral parts, and its price in Jäger's §3.2, TWO OBSTRUCTIONS, NOT ONE.**

## Phase 2, the clustering

**Reports:** [VERIFY_v122](VERIFY_v122.md), [VERIFY_v123](VERIFY_v123.md), [VERIFY_v124](VERIFY_v124.md) (**all three `PROVEN), hypotheses corrected`, unanimous.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the identity, its constant, the absent cross-term | *no defect.* Derived in full three times and checked at seven objects between them; $6=2(1+c_4)$ with $c_4=2$ **rebuilt from brackets** rather than taken from the record's undisplayed Casimir route | v122, v123, v124 |
| **C2** | **the class of $R$** | absent from both canonical copies. **Read at a curvature operator (the files' default object), $\mathrm{Alt}(R)=0$ and the identity is $0=0$**; the true class is every symmetric $R$ on $\Lambda^2\mathbb R^n$, and only [ATTEMPTS.md](../ATTEMPTS.md) carried it | v122, v123, v124 |
| **C3** | the normalisations | the constant is a product of **four**, and the blocks named one. Under $\operatorname{scal}=\operatorname{tr}$ both right-hand constants halve; under plain Frobenius the $6$ becomes $4$; under the unnormalised Bianchi map $2/3$; **and under the other $\#$ in circulation the identity is false rather than rescaled** | v122, v123, v124 |
| **C4** | [results.md](../results.md):645's "do not satisfy" and "with one exception" | the universal is **refuted at every sphere product by the block's own closing sentence**, and the count was withdrawn on the record. The findings copy reads "need not"; the correction reached three sites and skipped the canonical one | v122, v123, v124 |
| **C5** | the canonical display | **truncated mid-sentence on a dangling comma**, $\mathrm{Alt}$ never defined, "exactly 6 in every dimension" and "no cross-term" both dropped | v122, v123 |
| **C6** | "**Proof:** problem.md" | lands on a file carrying the reading and the evaluations and **no derivation**; the proof is L131 contracted, with $c_4=2$ | v123 |
| **C7** | "L15 is L131 polarised" | **the direction is backwards**, a quadratic form is a contraction of the operator identity, not a polarisation of it. The two determine each other, $\Psi$ being self-adjoint | v122, v123, v124 |
| **C8** | the heading's second obstruction | $X_{\mathrm{inv}}\succeq0$ is **established nowhere**: only its trace and its equality locus are proven, and it is refuted off the diagonal locus. The identity touches it not at all | v122, v123, v124 |
| **C9** | "in every dimension" | no floor; below $n=4$, $\Lambda^4$ is trivial and the constant is vacuous | v122 |
| **C10** | Jäger's Lemma 3.2.2 and eq. (1.6) | **absent from [references/](../references/)**, the *shape* of the master inequality rests on an unread source, though every number in it is derived here. One verifier also found a sentence attributed to 3.2.2's proof that closes 3.2.1's | v122, v123 |
| **C11** | the Fox factor of three | **stronger than recorded**: exact and dimension-free at every $n\ge4$, all four quantities being padding-invariant, where the record had it screened at $n=6,8$ | v122, v123, v124 |

**Withdrawn with reasons:** the overloaded $\lvert W\rvert$ behind "in any frame" (no witness exhibitable without computation), and "no cross-term" understating a vanishing Weyl coefficient (nothing false follows).

## Phase 3, adjudication

**The mathematics is unanimous and complete.** Three independent derivations, seven named objects between them, and $c_4=2$ rebuilt from structure constants by two verifiers who declined to trust the record's own Casimir route. **No verifier contradicted another anywhere.**

**C2 is the round.** *A statement whose natural reading makes it $0=0$ is not a weak statement, it is a different one*, and the class that makes it content-bearing appears in a file nobody cites.

**C3 closes a loop opened one round earlier.** [ROUND_L07](ROUND_L07.md) corrected a $\#$ constant by a factor of two and tabled $\operatorname{scal}=2\operatorname{tr}$; this round reached the same normalisation from the other side and found that **under the alternative the identity is false, not rescaled**, which is why the correction mattered rather than being cosmetic.

**C7 is a direction error, and it is the kind that survives review** because both statements are true and each implies the other; only the word "polarised" is wrong, and it names the step that is not taken.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `PROVEN, hypotheses corrected`. Impact: `CONTAINED`**, the identity holds as stated once its class is written down, and [Lemma L7](../findings/bounds.md)'s import of it **checks exactly, constant included**.

- **Both canonical copies now quantify $R$** over symmetric operators on $\Lambda^2\mathbb R^n$, with the note that at a curvature operator the identity is empty.
- **The canonical block is rewritten rather than patched**, the truncated display completed, $\mathrm{Alt}$ defined, the constant and the absent cross-term restored, "do not satisfy" corrected to "need not" with the sphere products named, "with one exception" gone, and the proof pointer moved to the file that carries the derivation.
- **$\#$ and $\mathrm{Ric}$ are tabled in [conventions.md](../findings/conventions.md)**, with the falsity under the alternative $\#$ recorded beside them.
- **The label's direction is corrected** in the block, in [results.md](../results.md) and in [lean/INDEX.md](../lean/INDEX.md).
- **The second obstruction is recorded as established nowhere**, with what *is* proven named, and Jäger's unread source recorded where the shape is imported.
- **The Fox factor of three is stated as exact at every $n\ge4$**, replacing a screen at two dimensions.
