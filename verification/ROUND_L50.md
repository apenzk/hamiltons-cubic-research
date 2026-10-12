# ROUND L50, the two-spectra identity, its collapse range, and an index order called load-bearing

**Id:** L50. **Source:** [findings/bispectral.md](../findings/bispectral.md):127–149, with the canonical form at [results.md](../results.md):707 and the landscape line at :244. **Date:** 2026-09-07. **Verifiers allocated:** v128, v129, v130. **Phase:** 6, closed. **Verdict:** `HYPOTHESIS-DEBT`, repaired, impact `NARROWS`.

**Why this id.** Tier 1, cited eight or more times, and **it is what L52, L53 and L54 are built on**, the identity that makes $\theta$ a function of two spectra at all. A round on L52 confirmed the bound that consumes it without checking the identity itself.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Does the identity hold, with those coefficients?** **Derive it, check $\tfrac32$ and $-\tfrac12$ against the contraction they come from, and say which normalisations the pair depends on, including why $\sum\omega^2=3$ rather than $1$, and what the coefficients become under the alternatives the record uses elsewhere.**
2. **Is the collapse range exactly $n\le5$?** **Check both directions: that $\beta=\tfrac12\alpha$ holds at $n=4$ and $n=5$, and that it fails at $n=6$. Say what the generalised-Kronecker display establishes and whether it covers both small dimensions by one mechanism as claimed.**
3. **Is the index order load-bearing as stated?** *The block says Li's $iklj$ is load-bearing and that $ikjl$ negates $\mathring W$ and the second coefficient.* **Check that claim, and check whether the record uses one order consistently.**

**A source is read, never cited from memory.** *Dai–Fu and Li are cited by arXiv number; if they are not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

**Statement.** Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$. Let $\mathring W$ be the curvature operator of the second kind on trace-free symmetric $2$-tensors, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with spectrum $\omega$. Then

$$\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega),\qquad \sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3 .$$

The index order $iklj$ is Li's and is load-bearing: the order $ikjl$ negates $\mathring W$ and the second coefficient.

**Proof.** Write $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$ and $\beta=W_{tspq}W_{tjpl}W_{sjql}$ for the two cubic contractions. Expanding each in the coordinate pair basis and using only the pair symmetries gives $\alpha=8\operatorname{tr}(M^3)$ and $\beta=2\langle M^\#,M\rangle$, where $M^\#$ is Hamilton's sharp with respect to the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$. Dai–Fu's Lemma 3.3, at $s=0$ and used as the pointwise algebraic identity it is, gives $\operatorname{tr}(\mathring W^3)=\tfrac18\alpha-\beta$, hence $p_3(\omega)=p_3(\mu)-2\langle M^\#,M\rangle$. Substituting into $\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle$ eliminates the sharp term and yields the display. The norm relation is Lemma 3.3's second identity at $s=0$, $\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$. $\square$

**The collapse, and its exact range.** For $n\le5$ (and only there), $\beta=\tfrac12\alpha$, so $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ and $\theta=3\operatorname{tr}(W^3)$ is a function of $\mu$ alone. The mechanism is Lovelock's dimensionally-dependent identity: the generalized Kronecker delta on six indices vanishes identically when $n\le5$, and

$$\beta-\tfrac{\alpha}{2}=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\,W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}.$$

This covers $n=4$ and $n=5$ by one mechanism. **It corrects a claim on this project's record** which attributed the $n=4$ collapse to the reducibility of $\mathrm{Weyl}_4$ as an $O(4)$-module and concluded it could not extend: $\mathrm{Weyl}_5$ is $O(5)$-irreducible and collapses regardless, so reducibility is not the separating fact.

**A corollary, correct only with $\mathrm{pr}$ on both sides.** Differentiating the identity gives $\mathrm{pr}(W^\#)=\tfrac12\mathrm{pr}(\iota_1^*(M^2))-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$, with $\mathrm{pr}$ the projection onto $\mathrm{Weyl}_n$ and $\iota^*,\iota_1^*$ the adjoints of $W\mapsto\mathring W$ and of the $\Lambda^2$ inclusion. **The projection on the left is not cosmetic: $W^\#$ is not a Weyl tensor**, about $60\%$ of its norm lying outside $\mathrm{Weyl}_n$. An earlier version of this document stated the identity without it, and read it as writing the sharp map as a difference of two positive semidefinite squares. **That reading is withdrawn**, $\mathrm{pr}$ discards $40$–$69\%$ of the norm and both terms are indefinite after it, in $30$ of $30$ samples. The corollary is the gradient of the identity above, recovered from it by contracting with $W$; it is a restatement rather than new structure. Reviewers 99 and 100, agreeing.

**Attribution.** The identity is [Dai–Fu](https://arxiv.org/abs/2311.18235) Lemma 3.3 specialised; the operator and its convention are [Li](https://arxiv.org/abs/2112.08465) eq. (2.2); the syzygy is Lovelock's. New here are the dictionary connecting their contractions to Hamilton's $\#$, and the three consequences: the isospectral separation, the exact range of the collapse, and the crossover mechanism.

### The canonical form, quoted alongside without comment

**Lemma L50 (second-order). The potential is a function of two spectra.** With $\mu$ the $\Lambda^2$ spectrum and $\omega$ that of the second-kind operator on $S^2_0$, $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$.

## Phase 2, the clustering

**Reports:** [VERIFY_v128](VERIFY_v128.md), [VERIFY_v129](VERIFY_v129.md), [VERIFY_v130](VERIFY_v130.md), **all three `HYPOTHESIS-DEBT`, unanimous.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the identity and its coefficients | *no defect.* The chain closes in symbols, $(\tfrac32,-\tfrac12)$ is **forced rather than fitted**, and it reproduces $\theta_0(6)$ exactly at $S^3\times S^3$ from two independently built anchors | v128, v129, v130 |
| **C2** | $\beta=2\langle M^\#,M\rangle$ | **the step the block calls new, and no derivation exists anywhere.** Gate 2 proved the $\alpha$ half and confirmed this one over samples; the pointer to the mathematics leads to a file that no longer carries it. *The coefficient pair **is** this constant*: with $\beta=c\sigma$ the identity reads $\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$ | v128, v129, v130 |
| **C3** | the generalised-Kronecker display | its proportionality is asserted, its constant script-fitted, and **its source has no entry in [references/](../references/)**, the one claim resting on an unread source, and the whole $n\le5$ collapse rests on it | v128, v129, v130 |
| **C4** | "and only there" | **no argument at all.** The delta's non-vanishing at $n\ge6$ says nothing about the Weyl cubic; nothing on file reaches $n\ge10$ | v128, v129, v130 |
| **C5** | the collapse read pointwise | **false**: padded $W_{\mathbb{CP}^2}$ collapses at every $n$, and the record's own $\operatorname{tr}(W^3)/\theta$ there confirms it. **The repair ("as trilinear forms"), exists only in [ATTEMPTS.md](../ATTEMPTS.md)**, and [results.md](../results.md) inherited the unrepaired version | v130 |
| **C6** | [references/dai-fu-2023-einstein-second-kind/](../references/dai-fu-2023-einstein-second-kind/) | **both files state the identity with $+\tfrac12$** against the canon's $-\tfrac12$ (the sign this lemma declares load-bearing), inside a file that declares Li's order two lines above. It gives $-7\sqrt{10}/30$ at $S^3\times S^3$ against $+\sqrt{10}/3$, and evaluates to $0$ across the whole $n\le5$ range | v128, v129, v130 |
| **C7** | $\sum\omega^2=3$ | correct and **forced**, the ratio being $3$ at every $W$ and every $n$; the block omits the factor $\lvert W\rvert^2=4\lVert M\rVert_F^2$ that converts the source's $\tfrac34\lvert W\rvert^2$ | v128, v129, v130 |
| **C8** | "$Q(W)=\tfrac13\nabla\theta$" | true of $\nabla P$, **false of $\nabla\theta$ at every non-critical point** | v130 |
| **C9** | the index order | the sign claim is a **theorem**, one line from pair antisymmetry, but the record runs two orders, at [stratum-two-negative.md](../findings/stratum-two-negative.md), flagged, and [isotropy-cap.md](../findings/isotropy-cap.md), unflagged | v129, v130 |
| **C10** | the Einstein-to-algebraic strip | the block asserts the transfer and never checks it; **one verifier proved it** from the curvature symmetries via the pair operator $B_{(ij),(kl)}=W_{iklj}$ | v128 |

## Phase 3, adjudication

**The identity is right and its coefficients are forced.** Three verifiers reached that independently, two of them building anchors by hand, and one anchor turned out to be the balanced $S^3\times S^3$, reproducing $\theta_0(6)$, another lemma's $\omega$-spectrum and a boxed cubic ratio from a single construction.

**C2 is the round.** *The one step the block advertises as its own contribution is the one with no derivation*, and it is not a detail: the coefficient pair is that constant, so a reader who doubts $\beta=2\langle M^\#,M\rangle$ doubts $\tfrac32$ and $-\tfrac12$ together. A machine-checked result already imports this half as owed, and **there is no Lean row for L50 at all**.

**C6 is the trap in its purest form.** The correction did not merely land beside the statement, **it landed in the folder a reader opens to check where the statement comes from**, and with a script citation attached. Two verifiers exhibited its falsity at the same object.

**C5 shows a repair that never left the notebook.** The pointwise reading is false, the trilinear-forms repair is right, and it has lived in [ATTEMPTS.md](../ATTEMPTS.md) while both citable forms carried the unrepaired sentence.

**C10 is a debt discharged rather than found.** One verifier proved what the block assumed, so the transfer is now on the record, recorded as its work, not as the block's.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `HYPOTHESIS-DEBT`. Impact: `NARROWS`**, the identity stands and is citable; two named links are owed, and the collapse is a statement about trilinear forms rather than about points.

- **Both debts are booked in the block**, with the note that the coefficient pair *is* the undrived constant, and the Kronecker display's source marked unread.
- **"And only there" is marked as having no argument** above $n=9$.
- **The collapse is restated as an identity of trilinear forms** in the block and in [results.md](../results.md), with the pointwise counterexample named.
- **The sign is corrected in both reference files**, with the closed-form reason ($\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ identically in $m$) and the $S^3\times S^3$ evaluation that exhibits the error.
- **The Einstein-to-algebraic transfer is written into the block** as proved, along with why $\sum\omega^2=3$ is forced.
- **"$\tfrac13\nabla\theta$" becomes "$\tfrac13\nabla P$"**, and the unflagged index order in [isotropy-cap.md](../findings/isotropy-cap.md) is flagged.
