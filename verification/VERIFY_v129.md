# VERIFY v129, Lemma L50: the bi-spectral identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, its coefficients, the $n\le5$ collapse range, and the load-bearing index order

*Cold brief. **No numerical work was done**: no script was run, no sample generated, no library imported. Every value below is an exact hand evaluation, and where a figure in the record is a measurement I say so rather than reproducing it. Sources read in [references/](../references/) rather than cited from memory: [dai-fu-2023-einstein-second-kind](../references/dai-fu-2023-einstein-second-kind/) (the arXiv text itself, pp. 5–8, not only the notes), [li-2021-nonnegative-second-kind](../references/li-2021-nonnegative-second-kind/), [boehm-wilking-2008-space-forms](../references/boehm-wilking-2008-space-forms/notes.md). Log: [agent_logs/verify-L50-v129.log](../agent_logs/verify-L50-v129.log).*

*Independence, declared. No file under [verification/](.) other than the dispatched round sheet [ROUND_L50.md](ROUND_L50.md) was opened. A repository-wide grep for "Lovelock" returned single lines from VERIFY_v57, VERIFY_v64, VERIFY_v66 and VERIFY_v78 before they could be excluded; nothing below rests on any of them, and where a conclusion of mine touches the same fact I reached it from [findings/sym3-blocks.md](../findings/sym3-blocks.md) and [findings/fence-posts.md](../findings/fence-posts.md) directly. Gate-2 reviewer reports [REVIEW_r97](../reviews/REVIEW_r97.md), [REVIEW_r98](../reviews/REVIEW_r98.md) and [REVIEW_r274](../reviews/REVIEW_r274.md) were read deliberately, the brief requiring the reports the record cites to be read before anything is called unargued.*

## Verdicts, before any prose

| # | Claim, read as a consumer would read it | Verdict |
| --- | --- | --- |
| C1 | $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$, in Li's $iklj$ order | **PROVEN MODULO ONE LINK**, every step re-derived by hand here except C3 |
| C2 | the dictionary $\alpha=8\operatorname{tr}(M^3)$ | **PROVEN**, re-derived by hand; the argument is on file in [r98](../reviews/REVIEW_r98.md) |
| C3 | the dictionary $\beta=2\langle M^\#,M\rangle$ | **HYPOTHESIS-DEBT**, no derivation anywhere on the record; two independent numerical confirmations only |
| C4 | Dai–Fu Lemma 3.3 at $s=0$, used as a pointwise algebraic identity | **PROVEN AS IMPORTED**, the transfer is sound and the source was read; one link inside the source's own proof is asserted, not proved |
| C5 | $\sum\mu=0$, $\sum\mu^2=1$, $\sum\omega=0$ | **PROVEN** |
| C6 | $\sum\omega^2=3$ | **PROVEN, hypotheses corrected**: the block omits the factor $\lvert W\rvert^2=4\lVert M\rVert_F^2$ that converts Dai–Fu's $\tfrac34\lvert W\rvert^2$ into $3$ |
| C7 | $\beta=\tfrac12\alpha$ at $n=4$ and $n=5$ | **HYPOTHESIS-DEBT**, the Kronecker display is the entire argument and has no derivation on file |
| C8 | $\beta\ne\tfrac12\alpha$ for every $n\ge6$ ("and only there") | **HYPOTHESIS-DEBT**, script evidence at $n=6,7,8,9$; nothing on file reaches $n\ge10$ |
| C9 | "this covers $n=4$ and $n=5$ by one mechanism" | **PROVEN CONDITIONALLY** on C7, the pigeonhole is uniform across $n\le5$ |
| C10 | "$ikjl$ negates $\mathring W$ and the second coefficient" | **PROVEN**, one line from pair antisymmetry, re-derived here |
| C11 | the record uses one index order consistently | **BROKEN**, [stratum-two-negative.md](../findings/stratum-two-negative.md) is written throughout in Bourguignon–Karcher's $ikjl$, and the conversion is still owed |
| C12 | the corollary is "correct only with $\mathrm{pr}$ on both sides" | **HYPOTHESIS-DEBT**, the block's whole warrant is a measurement; the one named-object route is in the Böhm–Wilking notes, not here |
| C13 | "the syzygy is Lovelock's" | **RESTS ON AN UNREAD SOURCE**, [references/](../references/) holds no Lovelock entry |
| C14 | [Lemma L52](../findings/bispectral.md) consumes exactly what L50 establishes | **NO FINDING**, the consumption is clean |
| C15 | a Lean row for L50 | **NONE EXISTS**, L50 appears in [lean/INDEX.md](../lean/INDEX.md) only as an *owed import* of [L62](../lean/INDEX.md) |

**Verdict: `HYPOTHESIS-DEBT`.** The *statement* of L50 survives every check I could run by hand and is corroborated exactly at the balanced sphere products by the record's own closed forms. What is owed is one link of its proof ($\beta=2\langle M^\#,M\rangle$) and the whole of the collapse range's mechanism (the $-\tfrac1{64}$ Kronecker display, in both directions). Separately, the block's claim about the index order is true while the record's practice contradicts the impression the block leaves.

## 0. Conventions, fixed once

- **The $4$-tensor.** $W\in\mathrm{Weyl}_n$: pair antisymmetry $W_{abcd}=-W_{bacd}=-W_{abdc}$, pair exchange $W_{abcd}=W_{cdab}$, first Bianchi $W_{a[bcd]}=0$, and Ricci-flatness $\sum_bW_{abcb}=0$. $\lvert W\rvert^2=\sum_{abcd}W_{abcd}^2$.
- **The $\Lambda^2$ operator.** $M$ is $W$ read on $\Lambda^2\mathbb R^n$ in the basis $\{e_i\wedge e_j\}_{i<j}$, taken orthonormal: $M_{(ij)(kl)}=W_{ijkl}$. Hence $\lVert M\rVert_F^2=\sum_{i<j,k<l}W_{ijkl}^2=\tfrac14\lvert W\rvert^2$, which is [conventions.md](../findings/conventions.md)'s $\lvert W\rvert^2=4\lVert W\rVert_F^2$. $\mu=\operatorname{spec}M$, $p_3(\mu)=\operatorname{tr}(M^3)$.
- **The second-kind operator.** $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ on $S^2_0$, Li eq. (2.2), read at [li-2021-nonnegative-second-kind/notes.md](../references/li-2021-nonnegative-second-kind/notes.md). $\omega=\operatorname{spec}\mathring W$, $p_3(\omega)=\operatorname{tr}(\mathring W^3)$.
- **The cubic.** $Q(W)=W^2+W^\#$ ([README.md](../README.md), [conventions.md](../findings/conventions.md)), $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$. At $\lVert M\rVert_F=1$, $\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle$ is notation, not a claim.
- **Hamilton's $\#$.** Defined on file only in [boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md), eq. (4): $\langle(R\,\#\,S)(h),h\rangle=\tfrac12\sum_{\alpha\beta}\langle[R(b_\alpha),S(b_\beta)],h\rangle\langle[b_\alpha,b_\beta],h\rangle$ with $\{b_\alpha\}$ orthonormal for $-\tfrac12\operatorname{tr}(AB)$.
- **The two cubic contractions**, Dai–Fu p. 5: $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$, $\beta=W_{tspq}W_{tjpl}W_{sjql}$.

**One reading hazard fixed here, because it costs a factor of two.** The block's phrase *"Hamilton's sharp with respect to the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$"* means unnormalised for the $n\times n$ Frobenius pairing, where $\lVert\phi_{ij}\rVert^2=2$. Under Böhm–Wilking's pairing $-\tfrac12\operatorname{tr}(AB)$ (the one their $\#$ is defined against), $-\tfrac12\operatorname{tr}(\phi_{ij}\phi_{ij})=-\tfrac12(-2)=1$, so the *same* $\phi_{ij}$ is **orthonormal** there, and the identification $e_i\wedge e_j\leftrightarrow\phi_{ij}$ is an isometry onto $(\mathfrak{so}(n),-\tfrac12\operatorname{tr})$. So the block's "unnormalised" and Böhm–Wilking's "orthonormal basis" name one and the same choice, and the record's $\#$ is Böhm–Wilking's $\#$ with no rescaling, a fact the BW notes record as checked at $n=6$ against $W\#I=-W$ and $I\#I=(n-2)I$. The word "unnormalised" in the lemma block invites the opposite conclusion and should be read with this line beside it.

## 1. The hypothesis inventory

### 1a. Hypotheses the block itself carries

| Hypothesis | Where stated | Used by the written proof? |
| --- | --- | --- |
| $W\in\mathrm{Weyl}_n$, pair symmetries | statement | **Yes**, in both dictionary steps |
| $W$ satisfies the first Bianchi identity | implicit in "$\mathrm{Weyl}_n$" | **Yes**, inside Dai–Fu Lemma 3.3, whose $\alpha$/$\beta$ reductions on their p. 5 are explicitly "by the first Bianchi identity". *Not* used by the dictionary, [r97](../reviews/REVIEW_r97.md) and [r98](../reviews/REVIEW_r98.md) both report the dictionary holds on all of $S^2(\Lambda^2)$ |
| $W$ is Ricci-flat (trace-free) | implicit in "$\mathrm{Weyl}_n$" | **Yes**, three times: it is the $s=0$ of Lemma 3.3; it is what makes $\mathring W$ preserve $S^2_0$ (Li §2, quoted below); and it gives $\sum\mu=0$ |
| $\lVert M\rVert_F=1$ | statement | **Only for the normalisation clause.** Both sides of the identity are homogeneous of degree $3$ in $W$, so the identity itself needs no normalisation, a point the block never makes and a consumer may need |
| Li's $iklj$ order for $\mathring W$ | statement | **Yes**, it fixes the sign of the second term |
| $n\ge4$ | **nowhere** | Not needed: $\mathrm{Weyl}_3=0$ and the statement is vacuous there. Recorded as an absence, not a defect |
| $\ker W\ne0$ | **nowhere, and nothing needs it** | The identity is an identity of polynomials on $\mathrm{Weyl}_n$; degenerate $M$ or degenerate $\mathring W$ enter nowhere, since $p_3$ of a spectrum is a trace and needs no simple eigenvalues. **No finding** |
| Parity of $n$ | **nowhere, and nothing needs it** | Every step is uniform in $n$. The only $n$-sensitive statement in the block is the collapse threshold, which is a threshold at $6$ and not a parity, a point [sym3-blocks.md:78](../findings/sym3-blocks.md) makes against a neighbouring block's wording. **No finding for L50** |

### 1b. Hypotheses of every imported result, checked against the object it is applied to

**Dai–Fu Lemma 3.3** ([dai-fu-2311.18235.txt](https://arxiv.org/abs/2311.18235), p. 7, read directly): *"Let $(M,g)$ be an $n$-dimensional Einstein manifold. Then the curvature operator of the second kind $\mathring R$ on $M$ has $\operatorname{tr}\mathring R=\tfrac{n+2}{2n}s$, and $\operatorname{tr}((\mathring R)^2)=\tfrac34\lvert R\rvert^2-\tfrac{s^2}{n^2}$, $\operatorname{tr}((\mathring R)^3)=-\beta+\tfrac18\alpha+\tfrac{s^3}{n^3}$."*

- *Hypothesis:* a Riemannian Einstein manifold. *Object:* an abstract algebraic Weyl tensor. **The transfer is legitimate and the source's own proof shows why.** Reading pp. 7–8: the proof computes $\operatorname{tr}A=\tfrac12\sum_{ij}A_{ijij}$ for a self-adjoint $A$ on $S^2(V)$, then evaluates $\operatorname{tr}\tilde R^2$ and $\operatorname{tr}\tilde R^3$ by index contraction, then subtracts the $g/\sqrt n$ direction using *"For Einstein manifolds, the $S^2_0(V)$ is the invariant subspace of $\tilde R$"*. Every ingredient is pointwise algebra in the components of $R$ at one point plus $\mathrm{Ric}=\tfrac sng$. No derivative of $R$, no completeness, no compactness. A Ricci-flat algebraic curvature tensor satisfies the Einstein condition with $s=0$, so the identity applies.
- *A defect inside the imported source, recorded because it is where L50's chain is thinnest.* Dai–Fu's cubic trace enters as **"Similarly we get $\operatorname{tr}(\tilde R^3)=-R_{isjt}R_{kslt}R_{ikjl}+\tfrac18R_{ijkl}R_{ijst}R_{klst}$"**, the word "similarly" is the entire proof of the step L50 leans on hardest. The record's [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) reproduces the same gesture. So the published warrant for the $-\beta+\tfrac18\alpha$ shape is an unexhibited computation in the source. This is not a reason to doubt it; it is a reason not to describe L50 as resting on a *proved* literature identity when what is on file is a stated one.
- *One relabelling the record never writes, and it is needed to match Dai–Fu's two spellings of $\beta$.* Lemma 3.3's proof produces $R_{isjt}R_{kslt}R_{ikjl}$; the definition on p. 5 is $\beta=R_{tspq}R_{tjpl}R_{sjql}$. These agree by pair antisymmetry alone. Applying $R_{xyzw}=R_{yxwz}$ (two sign flips) to each factor of the first turns it into $R_{sitj}R_{sktl}R_{kilj}$, and with $a=s,b=i,c=t,d=j,e=k,f=l$ that is $R_{abcd}R_{aecf}R_{bedf}$, which is $\beta$ under the relabelling $t\to a,s\to b,p\to c,q\to d,j\to e,l\to f$. **Checked by hand; the two spellings are one contraction.**

**Li eq. (2.2)** ([notes.md](../references/li-2021-nonnegative-second-kind/notes.md), transcribed from the arXiv text): a *definition*, so it carries no hypotheses to discharge. It carries one caveat the record does need and does honour: *"$\mathring R$ does not preserve the subspace $S^2_0(V)$ in general, but it does, for instance, when $R$ is Einstein."* Ricci-flat $W$ satisfies this, so "$\omega$ = the spectrum of $\mathring W$ on $S^2_0$" is well posed and the restricted operator is self-adjoint.

**Lovelock's dimensionally-dependent identity.** *No hypotheses can be checked, because there is nothing to check them against.* A repository-wide search returns **no Lovelock entry in [references/](../references/)**, the only occurrence of the name inside that folder is a bibliography line in the Fox text. The attribution *"the syzygy is Lovelock's"* in the block therefore rests on an unread source, as does whatever hypotheses Lovelock's identity carries.

**Hamilton's $\#$.** Defined on file only in the Böhm–Wilking notes, as above. The record's own canon does not define it: [README.md](../README.md) writes *"let $Q(W)=W^2+W^\#$ be Hamilton's quadratic map"* with no formula, and [conventions.md](../findings/conventions.md) forwards to README. **A consumer of L50 who wants to check its middle step has to leave the canon to find out what $M^\#$ is.**

### 1c. Which of these the written proof actually uses

The four-line proof consumes, in order: pair symmetries (dictionary), Böhm–Wilking's $\#$ under the $\phi_{ij}$ basis (dictionary), Dai–Fu Lemma 3.3 third identity at $s=0$ (which imports Bianchi and Ricci-flatness), and Dai–Fu Lemma 3.3 second identity at $s=0$ plus the unstated $\lvert W\rvert^2=4$ (normalisation clause). It does **not** use $n\ge4$, parity, criticality, or any spectral non-degeneracy. That is the complete list.

## 2. Pre-registered question 1, does the identity hold, with those coefficients?

### 2a. The chain, re-derived

Write $p_3(\mu)=\operatorname{tr}(M^3)$ and $\sigma=\langle M^\#,M\rangle$. The block's four steps are:

1. $\alpha=8\operatorname{tr}(M^3)$;
2. $\beta=2\sigma$;
3. Dai–Fu at $s=0$: $\operatorname{tr}(\mathring W^3)=\tfrac18\alpha-\beta$;
4. $\theta=\operatorname{tr}(M^3)+\sigma$.

From (1) and (3), $p_3(\omega)=\operatorname{tr}(M^3)-\beta$; with (2), $p_3(\omega)=p_3(\mu)-2\sigma$. From (4), $\sigma=\theta-p_3(\mu)$, so $p_3(\omega)=p_3(\mu)-2\theta+2p_3(\mu)=3p_3(\mu)-2\theta$, that is

$$\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega).$$

**The two coefficients are not free.** They are forced by the pair $(\tfrac18,-1)$ in Dai–Fu's cubic trace together with the pair $(8,2)$ in the dictionary. Concretely: $\tfrac32$ is $\tfrac12\cdot 3$, where the $3$ is $1+2$, one part $\operatorname{tr}(M^3)$ from $\theta$'s own $W^2$ term and two parts from eliminating $\sigma$ through $\beta=2\sigma$; and $-\tfrac12$ is the reciprocal of the $-2$ that multiplies $\sigma$ in $p_3(\omega)=p_3(\mu)-2\sigma$. Change $\beta=2\sigma$ to $\beta=c\sigma$ and the identity becomes $\theta=\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$: at $c=2$ this is $(\tfrac32,-\tfrac12)$. **So the entire content of the coefficient pair is the constant in the second dictionary entry**, which is the one step with no derivation on file (§2c).

### 2b. Step (1), $\alpha=8\operatorname{tr}(M^3)$, checked by hand, PROVEN

$\alpha=\sum_{t,p,s,q,k,l}W_{tpsq}W_{tpkl}W_{sqkl}=\sum M_{(tp)(sq)}M_{(tp)(kl)}M_{(sq)(kl)}$, where the pair labels run over *all ordered* pairs. By the symmetry of $M$ this is $\sum M_{(sq)(tp)}M_{(tp)(kl)}M_{(kl)(sq)}$, the matrix product $\operatorname{tr}(M^3)$ read over ordered pairs. Each of the three pair indices contributes a factor $2$ relative to the $i<j$ sum, because the summand is invariant under swapping within a pair (two sign flips, one in each of the two factors carrying that pair) and the diagonal $i=j$ contributes nothing. Hence $\alpha=2^3\operatorname{tr}(M^3)=8\operatorname{tr}(M^3)$. **This uses pair antisymmetry and pair exchange and nothing else**, consistent with [r98](../reviews/REVIEW_r98.md)'s report that it holds on all of $S^2(\Lambda^2)$, whose stated reason ("the all-index sum runs over three antisymmetric pairs, each contributing a factor 2") is the same argument. **The record carries an argument for this step and it is correct.**

### 2c. Step (2), $\beta=2\langle M^\#,M\rangle$, HYPOTHESIS-DEBT

**Locate it exactly.** [bispectral.md:139](../findings/bispectral.md) and the identical line at [ROUND_L50.md:25](ROUND_L50.md):

> "Expanding each in the coordinate pair basis and using only the pair symmetries gives $\alpha=8\operatorname{tr}(M^3)$ and $\beta=2\langle M^\#,M\rangle$, where $M^\#$ is Hamilton's sharp with respect to the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$."

and the display form at [bispectral.md:27](../findings/bispectral.md), which attaches the warrant explicitly to a script: *"exactly at every $n\ge4$ ([run_bispectral_dictionary.py](../scripts/runs/run_bispectral_dictionary.py))"*.

**Exhibit the failure concretely.** The clause *"expanding … and using only the pair symmetries gives"* is a description of a computation, not the computation. Unlike $\alpha$, this one cannot be a rebracketing of a matrix product: $\beta=\sum W_{abcd}W_{aecf}W_{bedf}$ pairs its three factors across the pair boundary ($\{a,c\}$ shared between factors 1 and 2, $\{b,d\}$ between 1 and 3, $\{e,f\}$ between 2 and 3) so no index pattern of $\beta$ is a pair-basis matrix entry chain, and the passage to $\#$ has to go through Böhm–Wilking's structure constants $\langle[b_\alpha,b_\beta],b_\gamma\rangle$. Nothing on the record performs it. I looked in: the two canonical copies in [bispectral.md](../findings/bispectral.md), [results.md:707](../results.md), [ATTEMPTS.md:2294](../ATTEMPTS.md), [fence-posts.md:127](../findings/fence-posts.md), the Dai–Fu [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md), the Böhm–Wilking [notes.md](../references/boehm-wilking-2008-space-forms/notes.md), and the three reviewer reports the record cites for it. What the reports contain:

- [r97](../reviews/REVIEW_r97.md): *"CONFIRMED (and stronger than stated)"*, from that reviewer's own nullspace construction of $\mathcal W_n$, a measurement on spanning samples.
- [r98](../reviews/REVIEW_r98.md): *"$\max\lvert\beta-2\langle M^\#,M\rangle\rvert\le8\times10^{-16}$ at $n=4,\dots,8$"*, a measurement, and its one analytical remark covers $\alpha$ only.
- [r274](../reviews/REVIEW_r274.md): rebuilds $M^\#$ from Wilking's ad-form and cross-checks it *against* $\beta=2\langle M^\#,M\rangle$, so it uses the claim rather than proving it.

**Argue the opposite, most charitably.** The words support a reading on which this is routine: $\#$ is a standard object, the free constant is pinned by naming the basis, and two independent implementations agree to $10^{-15}$ on samples that provably span $\mathcal W_n$. On that reading the claim is almost certainly true and the missing text is a page of index bookkeeping nobody wanted to typeset. **I accept that it is very likely true. It is still not proved on this record**, and the programme's standing rule is that numerical agreement is an open hypothesis. The candidate therefore survives all three steps as a debt, not as a refutation.

**What would have to be shown.** $\sum_{abcdef}W_{abcd}W_{aecf}W_{bedf}=2\langle M^\#,M\rangle$ with $M^\#$ as in Böhm–Wilking eq. (4) and $b_\alpha=\phi_{ij}=E_{ij}-E_{ji}$, expanded through $\langle[\phi_{ij},\phi_{kl}],\phi_{pq}\rangle$, in general $n$. One page, and it would close C1 outright.

**What would falsify it.** A $W\in S^2(\Lambda^2\mathbb R^n)$ with $\beta\ne2\langle M^\#,M\rangle$. I did not look for one numerically (the rule forbids it) and the record reports none over spanning samples at $n=4,\dots,8$ in two independent implementations, so the object, if it exists, is not in the range already swept.

### 2d. Which normalisations the coefficient pair depends on, and why $\sum\omega^2=3$ rather than $1$

**The identity itself depends on none of them.** $\theta$, $p_3(\mu)$ and $p_3(\omega)$ are all homogeneous of degree $3$ in $W$, so $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ holds for every $W\in\mathrm{Weyl}_n$, unnormalised. The coefficients depend on exactly two conventions, both of which change *both* sides consistently and so leave $(\tfrac32,-\tfrac12)$ alone: the identification $M_{(ij)(kl)}=W_{ijkl}$ with $\{e_i\wedge e_j\}_{i<j}$ orthonormal, and the $\phi_{ij}$ basis for $\#$. They depend on one convention that does *not* cancel: the $iklj$ index order, which flips $-\tfrac12$ to $+\tfrac12$ (§4).

**The normalisation clause is where $\lVert M\rVert_F=1$ enters, and it is where the block is short a line.** $\sum\mu^2=\operatorname{tr}(M^2)=\lVert M\rVert_F^2=1$ is immediate. For the other:

$$\sum\omega^2=\operatorname{tr}(\mathring W^2)\overset{\text{Dai–Fu, }s=0}{=}\tfrac34\lvert W\rvert^2=\tfrac34\cdot4\lVert M\rVert_F^2=3 .$$

The factor $\lvert W\rvert^2=4\lVert M\rVert_F^2$ is the count of §0, each of the two index pairs doubles the all-index sum against the $i<j$ sum. **It is on the record**, at [conventions.md](../findings/conventions.md) (*"$\lvert W\rvert^2=4\lVert W\rVert_F^2$ relates the two $\Lambda^2$ normalisations in use"*) and in the Dai–Fu [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) (*"With $\lvert W\rvert^2=4\lVert M\rVert_F^2$"*). **It is not in the block.** The block's last sentence supplies $\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$ and stops; a reader who knows only that $\lVert M\rVert_F=1$ cannot reach $3$ from it and has no way to tell whether the intended $\lvert W\rvert$ is the $\Lambda^2$ norm or the $4$-tensor norm. Since the same file elsewhere flags exactly this factor as a **live cross-file trap**, [post F33](../findings/INDEX-traps.md) works at $\lvert W\rvert_4=1$ where $p_2(\omega)=\tfrac34$, this file at $\lVert M\rVert_F=1$ where $p_2(\omega)=3$, the omission is in the one place the record already knows readers go wrong. Verdict **PROVEN, hypotheses corrected**: the block should carry the conversion, and the answer to "why $3$ and not $1$" is that $\mathring W$ is normalised by $\lvert W\rvert$ while $\mu$ is normalised by $\lVert M\rVert_F$, and the two differ by the factor $4$ that Dai–Fu's $\tfrac34$ then turns into $3$.

**What the coefficients become under the alternatives the record uses elsewhere.** At $\lvert W\rvert_4=1$, [post F33](../findings/INDEX-traps.md)'s normalisation, one has $\lVert M\rVert_F^2=\tfrac14$, so $\sum\mu^2=\tfrac14$ and $\sum\omega^2=\tfrac34$. The identity is unchanged, both sides scaling by $8^{-1}$; only the moment constants move. Under the *other index order* the pair becomes $(\tfrac32,+\tfrac12)$ (§4). Under an *orthonormal* $\phi_{ij}/\sqrt2$ for $\#$, [r98](../reviews/REVIEW_r98.md) records that $M^\#$ halves and $\beta=2\langle M^\#,M\rangle$ breaks, the dictionary constant would become $4$, and by §2a the identity would read $\theta=\tfrac32p_3(\mu)-\tfrac14p_3(\omega)$ **while $\theta$ itself changed by the same convention**, so this is a bookkeeping inconsistency rather than a rival identity. **These three are the only sensitivities, and the record names the first two and half of the third.**

### 2e. An exact corroboration of the coefficient pair, by hand, at the balanced sphere products

The record supplies an independent closed form for both spectra at $S^m\times S^m$, $n=2m$ ([bispectral.md:174–184](../findings/bispectral.md), canonised as [L67](../results.md):757): $\mathring W$ has eigenvalues $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ once, with $A=1/(m\sqrt{(m-1)(2m-1)})$, and $p_3(\mu)=A$. All arithmetic below is exact and done here.

- $\sum\omega=A(m-1)\big[m(m+2)-m^2-2m\big]=0$. ✔
- $\sum\omega^2=A^2m^2(m-1)\big[(m+2)+(m-1)+4(m-1)\big]=A^2m^2(m-1)(6m-3)=3A^2m^2(m-1)(2m-1)=3$, using $A^2=1/(m^2(m-1)(2m-1))$. **The normalisation clause of C6 is reproduced exactly at a named family.** ✔
- $\sum\omega^3=A^3m^2(m-1)\big[(m+2)m-(m-1)^2-8m(m-1)^2\big]=A^3m^2(m-1)\big(-8m^3+16m^2-4m-1\big)$. Since $-8m^3+16m^2-4m-1=(2m-1)(-4m^2+6m+1)$, checked by division: $-4m^2(2m-1)=-8m^3+4m^2$, remainder $12m^2-4m-1$; $6m(2m-1)=12m^2-6m$, remainder $2m-1$; $1\cdot(2m-1)$, remainder $0$, this is $p_3(\omega)=-A(4m^2-6m-1)$, matching the record's display exactly.
- Hence $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=A\big[\tfrac32+\tfrac{4m^2-6m-1}2\big]=A(2m^2-3m+1)=A(2m-1)(m-1)=\dfrac{\sqrt{(m-1)(2m-1)}}{m}$.
- And $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at $n=2m$ is $\sqrt{2(2m-1)(2m-2)}/(2m)=2\sqrt{(2m-1)(m-1)}/(2m)=\sqrt{(m-1)(2m-1)}/m$. **Equal, identically in $m$.**

**What this does and does not establish.** It is a consistency check *inside* the record (the $\omega$-spectrum and $\theta_0$ are both the record's own objects) so it is not independent evidence for the identity. What it does do is rule out the two most likely coefficient errors: any pair $(\tfrac32,c)$ with $c\ne-\tfrac12$ fails here for every $m\ge2$, since it would give $A\big[\tfrac32-c(4m^2-6m-1)\big]$, a different polynomial in $m$; and the sign flip $c=+\tfrac12$ gives $\tfrac32p_3(\mu)+\tfrac12p_3(\omega)=A\big[\tfrac32-\tfrac{4m^2-6m-1}2\big]=A(-2m^2+3m+2)$, which is $0$ at $m=2$ and strictly negative for every $m\ge3$, against a $\theta_0(2m)>0$. **So the second coefficient's sign is pinned by an exact closed form in $m$, not only by samples.**

## 3. Pre-registered question 2, is the collapse range exactly $n\le5$?

The block's claim has three parts, and they need separating because only one of them is a theorem.

> "For $n\le5$ (and only there), $\beta=\tfrac12\alpha$ … The mechanism is Lovelock's dimensionally-dependent identity: the generalized Kronecker delta on six indices vanishes identically when $n\le5$, and $\beta-\tfrac{\alpha}{2}=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\,W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}$. This covers $n=4$ and $n=5$ by one mechanism."

- **(i)** $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\equiv0$ when $n\le5$.
- **(ii)** the display: $\beta-\tfrac\alpha2$ **is** that contraction, with constant $-\tfrac1{64}$.
- **(iii)** $\beta-\tfrac\alpha2\ne0$ somewhere, for every $n\ge6$.

### 3a. Part (i) is a theorem, and it is the only part that is one

The generalised Kronecker delta on six upper and six lower indices is the full antisymmetriser over six index slots each drawn from $\{1,\dots,n\}$. For $n\le5$ any six-tuple $(a_1,\dots,a_6)$ repeats a value, and an object antisymmetric in the repeated pair vanishes. So $\delta^{[6]}\equiv0$ for $n\le5$, by pigeonhole, in one sentence, with no dependence on the constant in (ii) and no separate treatment of $n=4$ and $n=5$. **This is what "one mechanism covers both dimensions" means, and it is correct.** It is also stated on the record in that form, at [sym3-blocks.md:78](../findings/sym3-blocks.md): *"$\delta^{[6]}$ vanishes at $n\le5$ by pigeonhole, a one-sentence theorem"*.

**So C9 is right conditionally**, and the block's correction of the superseded [fence post F2g](../findings/fence-posts.md) (which had confined the collapse to $n=4$ via $O(4)$-reducibility and could not reach $n=5$), is right in its diagnosis: reducibility of $\mathrm{Weyl}_4$ separates nothing here, because the delta does not know about module structure. **No finding against the correction.**

### 3b. Part (ii), the display, HYPOTHESIS-DEBT

**Locate it exactly.** [bispectral.md:123–125](../findings/bispectral.md): *"The constant $-64$ is verified at $n=6,7,8$ ([run_lovelock_syzygy.py](../scripts/runs/run_lovelock_syzygy.py))."* [fence-posts.md:133](../findings/fence-posts.md) says the same with $n=6,7,8,9$ and adds *"from a direct $720$-term $S_6$ expansion"*. [ATTEMPTS.md:2296](../ATTEMPTS.md) states the display flatly with no derivation.

**Exhibit the failure concretely.** Everything the collapse claim rests on at $n=4$ and $n=5$ passes through (ii), because (i) is a statement about the right-hand side alone. The record's warrant for (ii) is a script. There is no derivation on file, not in [bispectral.md](../findings/bispectral.md), not in [fence-posts.md](../findings/fence-posts.md), not in [sym3-blocks.md](../findings/sym3-blocks.md), not in [ATTEMPTS.md](../ATTEMPTS.md), and not in [r97](../reviews/REVIEW_r97.md) or [r98](../reviews/REVIEW_r98.md), both of which record the constant as *computed* ($-64.00000000$ at $n=6,7,8,9$ from their own $S_6$ expansions). Nor is there a source: **there is no Lovelock entry in [references/](../references/)**, so the identity cannot be discharged by citation either. The Gate-2 line at [sym3-blocks.md:78](../findings/sym3-blocks.md) that calls the collapse *"derived"* is, read carefully, a claim about part (i) only, it says $\delta^{[6]}$ vanishes and draws the multiplicity conclusion, and says nothing about the display.

**Argue the opposite, most charitably.** Two readings defend it. First, the direction that matters for $n\le5$ needs only that $\beta-\tfrac\alpha2$ is *some* multiple of the $\delta^{[6]}$-contraction; the constant is irrelevant there, and a wrong constant would not damage the collapse. Second, an exact symbolic $S_6$ expansion at four separate dimensions is much stronger than a floating-point sample: both sides are contractions of a *fixed formal expression* in three copies of $W$, so an identity holding at $n=6,7,8,9$ (where nothing degenerates), is naturally read as a formal identity, hence valid in every $n$ including $n\le5$. **I find the second reading persuasive and it is probably how the display was obtained.** But the step "holds at four dimensions in the stable range, therefore holds formally" is a genuine argument with a genuine hypothesis (that the two sides are polynomial in $n$ in the appropriate sense, and that four points suffice), and **it is written nowhere.** The record elsewhere is explicit that stable-range transfer is exactly the kind of step that fails at small $n$, [sym3-blocks.md](../findings/sym3-blocks.md) refuses the Newell–Littlewood route for precisely this reason: *"Route (C), Newell–Littlewood $N_{(2,2),(2,2),(2,2)}=2$, is a stable-range count and does not reach $n=5$."* So the record already knows this inference needs care and does not supply it here.

**What would have to be shown.** Either (a) the $720$-term expansion of $\delta^{[6]}_{[6]}WWW$ carried out in symbols, yielding $-64(\beta-\tfrac\alpha2)$ in general $n$; or (b) a citation to Lovelock read into [references/](../references/), with the identity's own hypotheses checked against $\mathrm{Weyl}_n$; or (c) a direct proof of $\beta=\tfrac12\alpha$ at $n=4,5$ that bypasses the display entirely. Note that (c) is partially on file in a form the block does not cite: [sym3-blocks.md](../findings/sym3-blocks.md) refers to an **exact integer polarisation certificate** in [run_cubic_invariant_dimension.py](../scripts/runs/run_cubic_invariant_dimension.py) showing the two cubic invariants are dependent at $n=4,5$ and independent at $n=6$. That is exact arithmetic rather than floating point, so it is closer to a proof than the $-64$ verification is, **and L50's block cites neither it nor the file it lives in.**

### 3c. Part (iii), "and only there", HYPOTHESIS-DEBT, and it is the weaker half

**Locate it exactly.** The words *"For $n\le5$, and only there"* at [bispectral.md:141](../findings/bispectral.md) and [ROUND_L50.md:27](ROUND_L50.md), and the canonical [results.md:244](../results.md) line *"Collapses to one spectrum exactly for $n\le5$."*

**Exhibit the failure concretely.** *Only there* is a claim about every $n\ge6$. The evidence on file is: [bispectral.md:155](../findings/bispectral.md), *"It fails at $n=6,7$, which is what confines it"* ([run_n5_syzygy.py](../scripts/runs/run_n5_syzygy.py)); the constant checks at $n=6,7,8,9$; and [r98](../reviews/REVIEW_r98.md)'s *"CONFIRMED in every part, including 'only for $n\le5$'"*, which is that reviewer's own computation. **Nothing on file addresses $n\ge10$ at all.** The one-line bridge that would carry a single $n=6$ witness upward is on the record but in another file and never invoked here: [conventions.md](../findings/conventions.md) records that *"padding commutes with $Q$, and preserves both the norm and $\theta$"*, and $\alpha$ and $\beta$ are contractions that a zero-padded $W$ carries unchanged. **I am not supplying that step**, I am naming it, because naming what would have to be shown is what this verdict requires: *a single exhibited $W\in\mathrm{Weyl}_6$ with $\beta\ne\tfrac12\alpha$, plus the observation that padding preserves both contractions, would upgrade (iii) from four measured dimensions to a theorem for all $n\ge6$.*

**Argue the opposite.** The most charitable reading is that "only there" is a *scope disclaimer* rather than a theorem, the block is warning consumers off using the collapse at $n\ge6$, and for that purpose a measured failure at $n=6,7,8,9$ is more than sufficient, since a disclaimer that is too cautious harms nobody. On that reading nothing is wrong. **But the record does not read it that way.** [results.md:244](../results.md) states it as a property of the lemma; [sym3-blocks.md:42](../findings/sym3-blocks.md) and [:283](../findings/sym3-blocks.md) *consume* it in the positive direction, *"the trivial multiplicity is $1$ here and $2$ from $n\ge6$"*, and *"the cubic invariant dimension is $1$ here against $2$ from $n\ge6$"*, which is used to argue that an $n=5$ result **does not lift**. A consumer relying on non-lifting is relying on (iii) as a theorem. So the charitable reading does not survive contact with the citations.

**And one further gap the record itself flags, which belongs to this question.** [sym3-blocks.md:78](../findings/sym3-blocks.md) records that the step from the collapse to the invariant-theoretic conclusion *"owes the step that $\alpha,\beta$ **span** the cubic invariants"*. That owed step is not L50's to discharge, but any consumer who reads L50's "is a function of $\mu$ alone" as an invariant-theoretic statement inherits it.

### 3d. The other direction, $n=4$ and $n=5$, summarised

$\beta=\tfrac12\alpha$ at $n=4$ and at $n=5$ follows from (i) and (ii) together, and (i) is uniform in $n\le5$ so there is no case split. **The claim "one mechanism covers both" is correct and is the block's genuine advance over [fence post F2g](../findings/fence-posts.md).** The debt is entirely in (ii). What a consumer may take from this section: *the collapse at $n\le5$ is true if the display is true, and the display is presently a computation.*

## 4. Pre-registered question 3, is the index order load-bearing as stated?

### 4a. "The order $ikjl$ negates $\mathring W$", PROVEN, one line

$\mathring W$ is built from $W_{iklj}$; the competing order takes $W_{ikjl}$. These differ by a transposition of the last two slots, and $W$ is antisymmetric there:

$$W_{iklj}=-W_{ikjl}.$$

So the operator built from $ikjl$ is $-\mathring W$ exactly, for every algebraic curvature tensor, with no hypothesis beyond pair antisymmetry. **The claim is true, and its proof is the identity above.** The record's own two anchors agree and are stronger than a screen: [conventions.md](../findings/conventions.md) records that Li's order gives $\mathring R=+\mathrm{Id}$ on $S^2_0$ for the round sphere (Li Example 2.4) against $-\mathrm{Id}$ for $ikjl$, and that Bourguignon–Karcher's published $\mathbb{CP}^m$ table is Li's negated. I re-derived the sphere anchor by hand: with $R_{abcd}=g_{ac}g_{bd}-g_{ad}g_{bc}$ one has $R_{iklj}=g_{il}g_{kj}-g_{ij}g_{kl}$, so $\sum R_{iklj}\varphi_{kl}\varphi_{ij}=\lvert\varphi\rvert^2-(\operatorname{tr}\varphi)^2=\lvert\varphi\rvert^2$ on $S^2_0$, Li's stated $\mathring R=\mathrm{Id}$, and $-\mathrm{Id}$ in the other order. **The order is determined, not chosen.**

### 4b. "…and the second coefficient", PROVEN

$p_3$ is odd: $\operatorname{tr}((-\mathring W)^3)=-\operatorname{tr}(\mathring W^3)$, so $p_3(\omega)\mapsto-p_3(\omega)$ and $-\tfrac12\mapsto+\tfrac12$. **Correct as stated.** Note what does *not* move: $\sum\omega^2=\operatorname{tr}(\mathring W^2)$ is even, so the normalisation clause $\sum\omega^2=3$ is order-independent, as [conventions.md](../findings/conventions.md) also records. A consumer who checks only the norms cannot detect an order error, which is exactly why the block is right to call the order load-bearing.

### 4c. Does the record use one order consistently?, BROKEN

**No. It uses two, and the second is a whole findings file.**

**Locate it exactly.** [conventions.md](../findings/conventions.md), under *"The second-kind operator, and the index order, SETTLED on Li's $iklj$"*:

> "[stratum-two-negative.md](../findings/stratum-two-negative.md) is written throughout in BK's $ikjl$, consistently, and now carries a note saying so: its operator is $-\mathring W$, so its $\lambda_{\max}(\mathring R)\le1$ statements read $\lambda_{\min}(\mathring W)\ge-1$ in the record's order. **That conversion changes result statements and is queued for a verification round.**"

and the file's own note at [stratum-two-negative.md:329](../findings/stratum-two-negative.md): *"Everything on this page is correct as written, read in the BK order … Converting this page changes result statements (item (iii) becomes the lower bound $\lambda_1(\mathring W_e)\ge-1$) so the rewrite belongs to a verification round rather than to a convention repair."*

**Exhibit the failure concretely.** [stratum-two-negative.md:323](../findings/stratum-two-negative.md) writes $(\mathring Rh)_{ij}=\sum_{k,l}e_{ikjl}h_{kl}$ and identifies block (a) of $L_e$ with $\tfrac12\mathring R_e$. In L50's order that operator is $-\mathring W_e$, so the block identification reads $-\tfrac12\mathring W_e$. Lemmas 29–36 live in that file, and the record's summary table lists *"The $\le2$-negative stratum, capped at $\sqrt{3/2}$"* as **Proven** ([results.md](../results.md)). So the record simultaneously (a) declares in L50 that the order is load-bearing, (b) carries a proven stratum whose statements are in the other order, and (c) records that converting them changes the statements and has not been done.

**Argue the opposite.** The most charitable reading (and it is a fair one), is that this is a *documented* two-convention record rather than an inconsistent one: both files are internally consistent, each is correct in its own order, the mismatch is flagged in three places, the dictionary between them is written down, and the norm identity $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2$ is order-independent so the shared normalisation does not break. **On that reading nothing is mathematically wrong anywhere.** I accept all of that. The finding is narrower and survives it: **the answer to the pre-registered question is that the record does *not* use one order, and L50's own block gives a reader no way to learn this.** The block says *"The index order $iklj$ is Li's and is load-bearing"* (which a consumer reads as *the record is in $iklj$*) and the qualification lives in [conventions.md](../findings/conventions.md), a different file. That is this record's named trap, in its exact form.

**What would falsify the finding.** A line in [stratum-two-negative.md](../findings/stratum-two-negative.md) converting its statements to $iklj$, or a sentence in L50's canonical block naming the exception. Neither exists as of this round; I checked both files and grepped the record for every occurrence of $iklj$ and $ikjl$.

## 5. The corollary said to be "correct only with $\mathrm{pr}$ on both sides"

**The claim.** [bispectral.md:105–115](../findings/bispectral.md) and the canonical restatement at [:147](../findings/bispectral.md):

$$\mathrm{pr}\big(W^\#\big)=\tfrac12\,\mathrm{pr}\big(\iota_1^*(M^2)\big)-\tfrac12\,\mathrm{pr}\big(\iota^*(\mathring W^2)\big),$$

with *"$W^\#$ is not a Weyl tensor, about $60\%$ of its norm lying outside $\mathrm{Weyl}_n$"* and *"relative error $0.58$ unprojected against $5.8\times10^{-16}$ projected"*.

**What fails without the projection, and at what object, as the record has it.** The block's warrant is entirely a measurement: a relative error, a percentage, and *"$30$ of $30$ samples"*. **No object is named**, no dimension is named, and no argument is given for why $W^\#\notin\mathrm{Weyl}_n$. Under the discrepancy protocol that is a finding in itself: the corollary's load-bearing qualifier is supported by figures, not by an exhibited failure.

**Where the record does name objects, and the block does not cite it.** [boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md) records, against the paper's own eq. (4):

> "The ODE is stated on $S^2_B$, so $R\mapsto R^2+R^\#$ carries $S^2_B$ into itself: **the sum preserves the Bianchi identity.** The paper makes no such claim for $R^\#$ on its own, and it is false, see the Conjecture A record for the cancellation $b(R^\#)=-b(R^2)$, both sides nonzero at $\mathbb{CP}^3$ and $\mathbb{CP}^4$."

That is the structurally right shape of the argument (the Bianchi defect $b$ of $W^\#$ is the negative of that of $W^2$, and both are nonzero) and it names two objects. It is still a measurement, but it is a measurement *at named points* rather than a percentage over samples, and it explains *why* $\mathrm{pr}$ is needed on the left rather than merely that it is. **The block should point at it and does not.**

**The reason the block never states, and which is the actual warrant.** The identity of L50 is a function on $\mathrm{Weyl}_n$, a proper subspace. Its differential at $W$ is a functional on $\mathrm{Weyl}_n$, so any tensor representing it is determined only up to the orthogonal complement, i.e. only $\mathrm{pr}$ of it is well defined. **So $\mathrm{pr}$ on both sides is forced by the domain, before any measurement.** I record this as the missing sentence rather than as my own repair: the block presents a structural necessity as an empirical discovery, and a consumer therefore reads the $60\%$ as the reason instead of as a symptom.

**Verdict `HYPOTHESIS-DEBT`**, with the withdrawal itself sound. The block's *retraction*, that the corollary does not write $W^\#$ as a difference of positive semidefinite squares, because $\mathrm{pr}$ leaves both terms indefinite, is stated as measured and labelled as measured (*"$30$ of $30$ samples"*), and it is a retraction rather than a positive claim, so it needs less. **The self-description "a restatement rather than new structure" is correct**: the corollary is the gradient of the identity, recovered by contracting with $W$, and $\nabla P=3Q(W)$ is standard for a symmetric trilinear form, whose full symmetry the record proves elsewhere ([results.md:276](../results.md), attributing the trilinear symmetry to Huisken via Böhm–Wilking eq. (5)). **No finding on the "inert" verdict.**

## 6. Comparing the forms

| Where | What it says | Assessment |
| --- | --- | --- |
| [bispectral.md:15–21](../findings/bispectral.md), the in-context derivation | full statement, normalisations, **and** the index order named with Li cited by arXiv number | complete |
| [bispectral.md:133–139](../findings/bispectral.md), the canonical block | identical wording to the above, including the index-order sentence | complete, and identical to the canon in [results.md](../results.md), I compared them line by line and they agree verbatim |
| [results.md:709–713](../results.md), the canonical statement | identical to the block | complete |
| [results.md:244](../results.md), the landscape line | *"With $\mu$ the $\Lambda^2$ spectrum and $\omega$ that of the second-kind operator on $S^2_0$, $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$. … Collapses to one spectrum exactly for $n\le5$."* | **two defects for a consumer who cites this line** |
| [fence-posts.md:127–133](../findings/fence-posts.md), post 2g | the collapse and the display, without the identity | consistent |
| [lean/INDEX.md](../lean/INDEX.md) | **no row for L50** | see §6b |

### 6a. What [results.md:244](../results.md) drops

- **The index order is absent.** By §4 the order is the difference between $-\tfrac12$ and $+\tfrac12$, and this line names $\mathring W$ only as "the second-kind operator on $S^2_0$", a description that both orders satisfy, and for which the literature carries both (Li's $iklj$, Bourguignon–Karcher's $ikjl$). A consumer taking the identity from the landscape line and the operator from Bourguignon–Karcher gets the sign wrong with no warning. **This is the named trap in its second instance**: the load-bearing qualifier sits in the canonical block and is absent from the summary line that a reader scanning the landscape will actually copy.
- **The collapse is stated flatly as settled**, *"Collapses to one spectrum exactly for $n\le5$"*, with no marker of the debt in §3. The canonical block at [:707](../results.md) does no better, it omits the collapse entirely, so neither location tells a consumer that "exactly" rests on four measured dimensions.
- **What it gets right:** dropping the normalisations $\sum\mu^2=1$, $\sum\omega^2=3$ is harmless, since the identity is homogeneous (§2d). That is the one omission that costs nothing.

### 6b. The Lean row

**There is no Lean row for L50**, and the only occurrence of L50 in [lean/INDEX.md](../lean/INDEX.md) is inside [L62](../lean/INDEX.md)'s row, in its **Owed** list: *"**Owed**: that $W_0$ is an algebraic Weyl operator at $n=5$ (the padding lemmas) and that $P=3\operatorname{tr}(W^3)$ on $\mathcal W_5$ ([L50](../results.md)'s collapse), both imported."* So a machine-checked result already consumes L50's collapse as an unproven import, that is, it consumes exactly the part carrying the debt of §3b, not the identity itself.

**What the row would have to claim, if written.** Two rows, because the two halves have different standing:

- **The identity.** On $\mathrm{Weyl}_n$ with $\mathring W$ in Li's $iklj$ order, $\langle W,W^2+W^\#\rangle=\tfrac32\operatorname{tr}_{\Lambda^2}(W^3)-\tfrac12\operatorname{tr}_{S^2_0}(\mathring W^3)$, together with $\operatorname{tr}(\mathring W^2)=3\lVert M\rVert_F^2$. **Owed** in any honest row: Dai–Fu Lemma 3.3 at $s=0$ (a literature import), and $\beta=2\langle M^\#,M\rangle$ (§2c), which is the *only* step a Lean formalisation could not simply cite, since it is neither literature nor derived here.
- **The collapse.** $\beta=\tfrac12\alpha$ on $\mathcal W_n$ for $n\le5$. The formalisable half is the pigeonhole: an object antisymmetric in six indices over a set of size $\le5$ is zero. **Owed and stated:** the display of §3b, which is what connects that triviality to $\beta-\tfrac\alpha2$, and which no source on the record supplies.

**Recording the absence is the point.** A row that formalised the pigeonhole and imported the display would look like a machine check of the collapse while checking the only part nobody doubted.

## 7. The gap between what is proven and what is used

### 7a. What a consumer may cite, exactly

- **May cite as proven-modulo-one-named-link:** $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$, with $\mathring W$ in Li's $iklj$ order, for every $W$ (no normalisation needed), the single owed link being $\beta=2\langle M^\#,M\rangle$.
- **May cite as proven:** $\sum\mu=\sum\omega=0$; $\sum\mu^2=1$ and $\sum\omega^2=3$ at $\lVert M\rVert_F=1$; that the $ikjl$ order negates $\mathring W$ and the second coefficient; that $\sum\omega^2$ is order-independent.
- **May cite as conditional on the display:** $\beta=\tfrac12\alpha$, hence $\theta=3\operatorname{tr}(W^3)$, at $n=4$ and $n=5$.
- **May NOT cite as settled:** *"and only there"* / *"exactly for $n\le5$"*, measured at $n=6,7,8,9$, unaddressed at $n\ge10$. Anything whose validity turns on an $n=5$ result **not** lifting is resting on this.
- **May NOT cite at all:** the corollary as a source of positivity, the record withdraws that reading itself and the withdrawal stands.

### 7b. [Lemma L52](../findings/bispectral.md) consumes this identity, is what it uses what this block establishes?

**Yes. No finding.** L52's derivation ([bispectral.md:118–128](../findings/bispectral.md)) uses exactly three things from L50: the identity in the form $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$; $p_2(\mu)=1$; and $p_2(\omega)=3$. All three are L50's display verbatim, at L50's own normalisation $\lVert M\rVert_F=1$, which L52 restates in its conventions line. The normalisation matters here, L52's penalty algebra $\tfrac92M_+\lVert M_{\mathrm{off}}\rVert_F^2+\tfrac32m\lVert\mathring W_{\mathrm{off}}\rVert_F^2$ turns on $p_2(\omega)=3$ and would be wrong at $\lvert W\rvert_4=1$ where it is $\tfrac34$, and **L52 carries the normalisation explicitly and flags the cross-file trap.** So the consumption is clean at the one point where it could have gone wrong.

Two further checks on the joint:

- **The index order composes.** L52 also uses $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$, imported from Nienhaus–Petersen–Wink Prop 3.10. That is a *positive* sectional curvature on the diagonal, which agrees with Li's order (where the round sphere gives $\mathring R=+\mathrm{Id}$ and $K\equiv+1$) and disagrees with $ikjl$. So L52's two imports are in the same order, and the pairing $K\prec\mu$, $K'\prec\omega$ is consistent. **Had L52 taken $\mathring W$ from [stratum-two-negative.md](../findings/stratum-two-negative.md) instead, the majorization would have pointed the wrong way.** The order really is doing work downstream, which is the strongest support for the block's "load-bearing" claim.
- **L52 inherits none of L50's debts in a way that compounds.** L52 is an inequality whose own equality clause the record already audits as defective; it does not consume the collapse, and it does not consume $\beta=2\langle M^\#,M\rangle$ except through the identity it takes as given.

**Everything else the record hangs on L50.** [L67](../results.md):757 (the sphere-product spectrum) consumes the identity *and* the order, and the record already carries the correction that its $A$ is order-dependent and *"no canonical block stated"* it. [L53](../results.md):244 (the champion split) consumes the identity as the direction $(\tfrac32,-\tfrac12)$; a sign error there would relabel which competitor wins, so it too depends on §4. [sym3-blocks.md](../findings/sym3-blocks.md) consumes the **collapse**, in the non-lifting direction, which is the half carrying the debt.

## 8. The named trap, each citable claim read alone, as a consumer would

This record's signature failure is a correction landing *beside* the claim it corrects. I read each citable location cold, without the neighbours. Three instances, in descending severity.

### 8a. The Dai–Fu reference folder states the identity with the WRONG SIGN, the sign this lemma calls load-bearing

**Locate it exactly.** Two files, both in [references/dai-fu-2023-einstein-second-kind/](../references/dai-fu-2023-einstein-second-kind/).

[README.md](../references/dai-fu-2023-einstein-second-kind/README.md), the Verdict line:

> "On $\mathrm{Weyl}_n$ the two cubic invariants $\alpha$ (the $\Lambda^2$-trace of $W^3$) and $\beta$ are exactly the two spectral cubics, and $P(W)=\tfrac32\operatorname{tr}_{\Lambda^2}W^3\,\mathbf{+}\,\tfrac12\operatorname{tr}_{S^2_0}\mathring W^3$ follows"

[notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md), the closing paragraph of *"What this gives on $\mathrm{Weyl}_n$"*:

> "which is the content of the record's bi-spectral identity $\theta=\frac32\operatorname{tr}_{\Lambda^2}M^3\,\mathbf{+}\,\frac12\operatorname{tr}_{S^2_0}\mathring W^3$ (verified to $10^{-16}$ in [run_bispectral_identity.py](../scripts/runs/run_bispectral_identity.py) …)"

Both carry $+\tfrac12$. The canon carries $-\tfrac12$ in all three of its locations. **These are the two files a consumer opens to check the attribution**, and the sign they carry is the one the lemma block declares load-bearing.

**Exhibit the failure concretely, at an object inside the same file.** [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) supplies, on the very line before, every ingredient needed to refute its own display: $\operatorname{tr}\mathring W^3=\tfrac18\alpha-\beta$ and $\alpha=8\operatorname{tr}(M^3)$, so $p_3(\omega)=\operatorname{tr}(M^3)-\beta$; and with the same file's $\beta=2\langle M^\#,M\rangle$ and $\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle$ one gets $\theta=\operatorname{tr}(M^3)+\tfrac\beta2$. Then

$$\tfrac32\operatorname{tr}(M^3)-\tfrac12p_3(\omega)=\tfrac32\operatorname{tr}(M^3)-\tfrac12\operatorname{tr}(M^3)+\tfrac\beta2=\operatorname{tr}(M^3)+\tfrac\beta2=\theta,\qquad\text{whereas}$$
$$\tfrac32\operatorname{tr}(M^3)+\tfrac12p_3(\omega)=2\operatorname{tr}(M^3)-\tfrac\beta2,$$

and $2\operatorname{tr}(M^3)-\tfrac\beta2=\operatorname{tr}(M^3)+\tfrac\beta2$ holds only on the locus $\operatorname{tr}(M^3)=\beta$, not identically. **At the balanced $S^m\times S^m$**, §2e gives the exact numbers: the correct combination is $A(2m-1)(m-1)=\theta_0(2m)>0$, and the file's combination is $A(-2m^2+3m+2)$, which is $0$ at $m=2$ against $\theta_0(4)=\sqrt3/2$, and strictly negative for every $m\ge3$ against a positive $\theta_0(2m)$. So the reference folder's display fails at $S^2\times S^2$, at $S^3\times S^3$, and at every larger balanced product, by an amount that grows.

**Argue the opposite, most charitably.** $+\tfrac12$ *is* the correct coefficient in Bourguignon–Karcher's $ikjl$ order, so a reader might take these two lines as written in the other convention. **That reading is unavailable here**, and the same file closes it: [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) opens with *"Conventions: … $\mathring R(e_i\odot e_j)=R_{iklj}\,e_k\odot e_l$ … following Li"*, and the wrong display uses the symbol $\mathring W$ defined by that line. A second charitable reading (that the sign is a typo of no consequence), also fails, because the display is presented as *"the content of the record's bi-spectral identity"* and is decorated with a script citation and a residual, which is precisely the furniture that makes a reader stop checking.

**Candidate stands.** This is the trap in its purest form: the canon is right, and the file that a consumer consults to verify the canon's *attribution* carries the negation.

### 8b. [results.md:244](../results.md) states the identity without the index order

Covered in §6a. Read alone, the landscape line is compatible with both conventions and so with both signs, and it is the line a reader scanning the landscape will copy.

### 8c. The lemma block leaves a reader believing the record is uniform in $iklj$

Covered in §4c. *"The index order $iklj$ is Li's and is load-bearing"* reads as a statement about the record. The exception (a whole findings file in the other order, with the conversion owed), lives in [conventions.md](../findings/conventions.md).

## 9. The candidate register

Every candidate reached under the three-step protocol, including the ones I dropped.

| Candidate | Located | Exhibited | Opposite argued | Outcome |
| --- | --- | --- | --- | --- |
| $\beta=2\langle M^\#,M\rangle$ has no derivation on the record | [bispectral.md:27](../findings/bispectral.md), [:139](../findings/bispectral.md) | the contraction crosses the pair boundary and cannot be a pair-basis matrix chain; six files and three reviewer reports carry only measurements | *standard object, constant pinned by the named basis, two independent implementations agree on spanning samples* | **stands**, HYPOTHESIS-DEBT |
| the $-\tfrac1{64}$ display has no derivation and no readable source | [bispectral.md:123](../findings/bispectral.md), [fence-posts.md:133](../findings/fence-posts.md) | script warrant only; no Lovelock entry in [references/](../references/) | *the constant is irrelevant to the $n\le5$ half, and an exact $S_6$ expansion at four stable dimensions naturally reads as formal* | **stands**, HYPOTHESIS-DEBT |
| *"and only there"* is measured at four dimensions | [bispectral.md:141](../findings/bispectral.md), [results.md:244](../results.md) | nothing on file reaches $n\ge10$; consumed positively at [sym3-blocks.md:42](../findings/sym3-blocks.md) and [:283](../findings/sym3-blocks.md) | *it is a scope disclaimer, and over-caution harms nobody* | **stands**, the citations use it as a theorem |
| the record does not use one index order | [conventions.md](../findings/conventions.md), [stratum-two-negative.md:329](../findings/stratum-two-negative.md) | Lemmas 29–36 are stated in $ikjl$ and the conversion *"changes result statements"* and is queued | *both files are internally consistent and the mismatch is flagged three times* | **stands as scope**, the pre-registered question is answered "no" |
| the Dai–Fu reference folder carries $+\tfrac12$ | [README.md](../references/dai-fu-2023-einstein-second-kind/README.md), [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) | refuted by ingredients on the same line, and by exact arithmetic at every balanced $S^m\times S^m$ | *$+\tfrac12$ is right in BK's order* (closed by the file's own conventions line naming Li | **stands**), a defect in the reference layer |
| the block omits $\lvert W\rvert^2=4\lVert M\rVert_F^2$ | [bispectral.md:139](../findings/bispectral.md) | $\tfrac34\lvert W\rvert^2$ cannot reach $3$ without it, and the record flags this exact factor as a live trap | *it is one link away in [conventions.md](../findings/conventions.md)* | **stands as an exposition defect**, hypotheses corrected |
| the $\mathrm{pr}$ corollary's warrant is a measurement | [bispectral.md:111](../findings/bispectral.md), [:147](../findings/bispectral.md) | no object named, no dimension named; the named-object route is in the [BW notes](../references/boehm-wilking-2008-space-forms/notes.md) and uncited here | *the retraction it supports needs less than a positive claim would* | **stands, narrowed**, the withdrawal itself is sound |
| *withdrawn*, "Dai–Fu Lemma 3.3 needs a manifold, so the transfer to an algebraic $W$ is illegitimate" |, |, |, | **withdrawn**: I read the source's proof at [dai-fu-2311.18235.txt](https://arxiv.org/abs/2311.18235) pp. 7–8 and every step is pointwise algebra plus $\mathrm{Ric}=\tfrac sng$ |
| *withdrawn* ("Dai–Fu's two spellings of $\beta$ differ" |), |, |, | **withdrawn**: they agree by pair antisymmetry alone, checked by hand in §1b |
| *withdrawn*, "the record's $\lVert W\rVert=1$ may be the $4$-tensor norm, breaking the identity's constants" |, |, |, | **withdrawn**: the identity is homogeneous, and $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ exactly at the balanced products confirms the two normalisations agree (§2e) |
| *withdrawn* ("the block's *unnormalised* $\phi_{ij}$ clashes with Böhm–Wilking's *orthonormal* basis" |), |, |, | **withdrawn**: $\phi_{ij}$ is unit for $-\tfrac12\operatorname{tr}(AB)$, which is Böhm–Wilking's own pairing (§0); the two phrases name one basis |

## 10. What would break the statement, and what I did to look for it

**The object that would falsify L50's identity** is a single $W\in\mathrm{Weyl}_n$ with $\langle W,W^2+W^\#\rangle\ne\tfrac32\operatorname{tr}(M^3)-\tfrac12\operatorname{tr}(\mathring W^3)$ in Li's order. **What I did to look for it**, without running anything: I re-derived the chain in symbols (§2a) and found it closed; I re-derived the one dictionary step that admits a hand proof (§2b) and it holds; I read Dai–Fu's Lemma 3.3 and its proof in the arXiv text rather than in the record's summary of it, and checked its hypotheses against $\mathrm{Weyl}_n$ (§1b); I checked the two spellings of $\beta$ agree (§1b); and I evaluated both sides exactly in closed form at the one infinite family where the record supplies both spectra symbolically, finding agreement identically in $m$ and finding that no other second coefficient reproduces $\theta_0(2m)$ (§2e). **No falsifier surfaced, and the one place a falsifier could still hide is $\beta=2\langle M^\#,M\rangle$**, which no hand argument on file covers.

**The object that would falsify the collapse range** is a $W\in\mathrm{Weyl}_5$ with $\beta\ne\tfrac12\alpha$ (which would refute part (ii) of §3) or a $W\in\mathrm{Weyl}_n$ at some $n\ge10$ with $\beta=\tfrac12\alpha$ for all of $\mathrm{Weyl}_n$, which would refute *"only there"*. **What I did:** I checked that part (i) is a theorem independent of the display, so no falsifier can enter through the pigeonhole; I traced the display's warrant to a single script and confirmed no derivation and no readable source exists; and I located the exact-arithmetic certificate the record does own ([run_cubic_invariant_dimension.py](../scripts/runs/run_cubic_invariant_dimension.py)'s integer polarisation route, via [sym3-blocks.md](../findings/sym3-blocks.md)) which L50 does not cite. **The falsifier at $n\ge10$ is unaddressed by anything on file**, and the one-line padding bridge that would close it is written in [conventions.md](../findings/conventions.md) and never invoked at L50.

**The object that would falsify the index-order claim** is an algebraic curvature tensor with $W_{iklj}\ne-W_{ikjl}$, which pair antisymmetry forbids. **None exists**, and the claim is a theorem.

## Verdict

# `HYPOTHESIS-DEBT`

The identity's statement stands. Its proof has one link with no argument on file ($\beta=2\langle M^\#,M\rangle$) and the collapse range has two: the Kronecker display in both directions, and *"only there"* beyond $n=9$. The index-order claim is a theorem; the accompanying impression that the record is uniform in that order is false, and the sign the block calls load-bearing is written the wrong way round in the reference folder that documents its attribution.

**In one line:** *the two-spectra identity is almost certainly true and is corroborated exactly in closed form, but the record proves three of its four steps and measures the fourth; the collapse to $n\le5$ is a one-sentence pigeonhole resting on a display nobody has derived; and the correct sign is contradicted, with a script citation attached, in the two files a consumer opens to check where the identity comes from.*
