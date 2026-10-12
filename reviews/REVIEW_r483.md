# REVIEW r483, Lemma L67, the second-kind spectrum of the balanced product

**Verdict: CONFIRMED.** The spectrum is right, the multiplicities are right and sum to the dimension, the normalisation constant is right, and every downstream quantity the record reads off it reproduces. I rebuilt the object from the curvature tensor and got the claimed list exactly. What the audit found is **five record defects around the claim, none of them mathematical**: the numbered block omits the constant $A$, its proof pointer is wrong, the file collides on the letter $\mu$, [ATTEMPTS.md](../ATTEMPTS.md) points the reader at the wrong file, and the index labels the result **Lemma** while recording no Gate 2.

Reviewer r483, adversarial audit, brief of 2026-09-04. Target: [Lemma L67](../findings/bispectral.md) at [bispectral.md:450](../findings/bispectral.md#L450). Analysis-only footing observed; the one numerical run is a **screen** of a claim recorded here, on objects constructed for that purpose, and is reported as a screen (§8).

## The claim as written

> At $S^m\times S^m$ with $n=2m$, normalised to $\lVert W\rVert_F=1$, the spectrum of $\mathring W$ takes three values: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$.

## 1. The multiplicities sum to the dimension, HOLDS

$$(m-1)(m+2)+m^2+1=(m^2+m-2)+m^2+1=2m^2+m-1,$$

and $\dim S^2_0(\mathbb R^{2m})=\tbinom{2m+1}2-1=m(2m+1)-1=2m^2+m-1$. Equal identically in $m$. The cheapest refutation is unavailable.

## 2. Recomputed from the definition, HOLDS, exactly

Built without reference to the block's derivation. Let $P_1,P_2$ be the orthogonal projections onto the two factors, $g$ the product metric of two **unit** round spheres. The curvature is $R=G^{(1)}+G^{(2)}$ with $G^{(\alpha)}_{ijkl}=g^\alpha_{ik}g^\alpha_{jl}-g^\alpha_{il}g^\alpha_{jk}$. In Li's $iklj$ order, $(\mathring Rh)_{ij}=\sum_{k,l}R_{iklj}h_{kl}$ gives, in matrix form,

$$\mathring Rh=\sum_{\alpha=1,2}\big[P_\alpha hP_\alpha-P_\alpha\operatorname{tr}(P_\alpha h)\big].$$

Setting $P=\mathrm{Id}$ recovers $\mathring Gh=h-g\operatorname{tr}h$, i.e. $\mathring G=+\mathrm{Id}$ on $S^2_0$, which is [conventions.md](../findings/conventions.md)'s round-sphere anchor for Li's order, so the order is the record's (§4).

The product is Einstein, $\mathrm{Ric}=(m-1)g$ and $S=2m(m-1)$, so the Weyl tensor is $W=R-cG$ with $c=S/(n(n-1))=(m-1)/(2m-1)$, and $\mathring W=\mathring R-c\,\mathrm{Id}$ on $S^2_0$. Writing $h=\begin{pmatrix}X&Y\\Y^{\mathsf T}&Z\end{pmatrix}$ and $\tau=\operatorname{tr}X$, on traceless $h$:

$$\mathring Wh=\begin{pmatrix}(1-c)X-\tau I_m&-cY\\-cY^{\mathsf T}&(1-c)Z+\tau I_m\end{pmatrix}.$$

Three invariant summands, and they are the whole of $S^2_0$:

| summand | dimension | eigenvalue |
| --- | --- | --- |
| $X,Z$ traceless ($\tau=0$) | $2\big(\tfrac{m(m+1)}2-1\big)=(m-1)(m+2)$ | $1-c=m/(2m-1)$ |
| $Y$ arbitrary | $m^2$ | $-c=-(m-1)/(2m-1)$ |
| $X=xI_m,\ Z=-xI_m$ | $1$ | $1-c-m=-2m(m-1)/(2m-1)$ |

With $A_{\text{raw}}=1/(2m-1)$ this is $mA,\ -(m-1)A,\ -2m(m-1)A$ at exactly the claimed multiplicities. **The claim reproduces from the definition.**

## 3. The constant, and everything read off it, all HOLD

The $\Lambda^2$ operator of $W$ has $1-c$ on $m(m-1)$ intra-factor pairs and $-c$ on $m^2$ mixed pairs, so $\sum\mu^2=m^2(m-1)/(2m-1)$ before scaling and unit norm forces

$$A=\frac1{m\sqrt{(m-1)(2m-1)}},$$

the value [bispectral.md:183](../findings/bispectral.md#L183) states. Independently, $\sum\omega^2=3A^2m^2(m-1)(2m-1)=3$ at that $A$, so $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2_{\Lambda^2}$ is satisfied by two separately-computed sides, which is a genuine normalisation check rather than a restatement. Also $\sum\omega=m(m-1)[(m+2)-m-2]A=0$. Then, by hand:

- $p_3(\mu)=A^3m^2(m-1)(2m-1)=A$, matching the recorded $p_3(\mu)=1/(m\sqrt{(m-1)(2m-1)})$, and matching $\operatorname{tr}(W^3)=2\sqrt2/(n\sqrt{(n-1)(n-2)})$ at $n=2m$, so the recorded "$A$ is not a new constant" holds.
- $p_3(\omega)=A(-8m^3+16m^2-4m-1)/(2m-1)=-(4m^2-6m-1)A$, the division being exact. Matches the recorded value.
- [Lemma L50](../findings/bispectral.md#L128): $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\dfrac{A}{2m-1}\big(4m^3-8m^2+5m-1\big)=\dfrac{A(m-1)(2m-1)^2}{2m-1}=A(m-1)(2m-1)=\dfrac{\sqrt{(m-1)(2m-1)}}m=\theta_0(2m)$. **Identically in $m$**, the cubic factoring as $(m-1)(2m-1)^2$. [results.md:740](../results.md#L740)'s "with Lemma L50 the spectrum returns $\theta=\theta_0(2m)$" holds.
- $-\min\omega=2m(m-1)A=2\sqrt{m-1}/\sqrt{2m-1}$, and $\tfrac n{n-1}\theta_0(n)\big|_{n=2m}=2\sqrt{(m-1)(2m-1)}/(2m-1)$, the same number. So [bispectral.md:203](../findings/bispectral.md#L203)'s equality case holds, from the spectrum alone.

**Li's Theorem 1.8, as quoted at [bispectral.md:173](../findings/bispectral.md#L173), is faithfully transcribed.** Its four pieces are exactly my four: $\operatorname{spec}(\mathring R_\alpha)$ on the traceless blocks, $0^{(n_1n_2)}$ on $Y$ (correct: at $c=0$ my $Y$-eigenvalue is $0$), and $-\frac{n_1\rho_2+n_2\rho_1}{n_1+n_2}=-(m-1)$ on the trace split, against my $1-m$. The literature input is not a place this claim can break.

## 4. Normalisations, every one checks

| convention | source | at this point |
| --- | --- | --- |
| index order $iklj$ | [conventions.md](../findings/conventions.md) §"the second-kind operator" | confirmed: $\mathring G=+\mathrm{Id}$ on $S^2_0$ falls out of my formula |
| $\sum\mu^2=1$, $\sum\omega^2=3$ | [conventions.md](../findings/conventions.md) §"Norms and pairings" | both hold at $A$ above, computed separately |
| $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2_{\Lambda^2}$ | same | holds; both sides basis-free, so no $\tfrac12$ can hide in it |
| $\Lambda^2$ diagonal $=K$ | [Lemma L54](../findings/bispectral.md#L444) | holds: my $\Lambda^2$ operator is diagonal in the pair basis with entries $W_{abab}$ |
| $t=\sum_{a\ne b}K_{ab}^2\le2$, $=2$ iff coordinate-diagonal | [conventions.md](../findings/conventions.md) §"The vertex matrix" | $t=2\sum\mu^2=2$; the balanced product is coordinate-diagonal, as required |
| the cross-file trap: $\lVert M\rVert_F=1$ in this file, $p_2(\omega)=3$ | [conventions.md](../findings/conventions.md), post F33 line | the block is on the $\lVert M\rVert_F=1$ side; no $\lvert W\rvert_4$ figure enters |

No factor of $2$ or $\tfrac13$ is missing. The $\tfrac13$ of $\mathrm{Alt}$ does not enter this claim at all.

## 5. The "fourth value" at unbalanced products, HOLDS, with a reason

[results.md:740](../results.md#L740) adds "It reaches the balanced product only; the unbalanced products have a fourth value." True. For Einstein $S^p(k_1^{-1/2})\times S^q(k_2^{-1/2})$, $(p-1)k_1=(q-1)k_2=\rho$ and the $\omega$-spectrum is $\{k_1-c,\ k_2-c,\ -c,\ -\rho-c\}$ with $c=\rho/(n-1)$. Since $k_1,\rho>0$, $k_1-c$ can equal neither $-c$ nor $-\rho-c$, so the values collapse from four to three **exactly** when $k_1=k_2$, i.e. $p=q$. The clause is right and is not vacuous.

## 6. The block does not contain its proof, and its pointer is wrong

The block's whole argument is one italic sentence: *"The argument is the surrounding material in this file."*

- **The material is not surrounding.** It is at [bispectral.md:171–190](../findings/bispectral.md#L171), **275 lines earlier**, under an unrelated heading ("The maximiser's position in the bi-spectral plane, in closed form"). Nothing within a hundred lines of the block bears on it. A reader following the pointer literally finds [Lemma L94](../findings/bispectral.md#L215) and the ascent table.
- **What is there is a sketch, not a derivation.** "Specialising to the balanced $S^m\times S^m$ at $n=2m$ and subtracting the Einstein part to reach the Weyl tensor" is the entire argument, followed by the table. **The $O(m)\times O(m)$ decomposition of $S^2_0(\mathbb R^{2m})$ that produces the multiplicities is written nowhere in the record.** §2 above supplies it in four lines; until now the multiplicities rested on Li's theorem plus a numerical check ([run_li_thm18_check.py](../scripts/runs/run_li_thm18_check.py)).
- **The block omits $A$.** [bispectral.md:454](../findings/bispectral.md#L454) never says what $A$ is, though the material 275 lines above gives it in closed form. As stated the block claims only that $\omega\propto(m,-(m-1),-2m(m-1))$; $\lVert W\rVert_F=1$ does then determine $\lvert A\rvert$, so it is **not** vacuous, but the numbered block is strictly weaker than the unnumbered prose it is supposed to summarise, and a citer reading only the block cannot evaluate the spectrum. [results.md:740](../results.md#L740) inherits the omission ("$A$ is the constant fixed by the normalisation").
- **Sign and range, minor.** $\lVert W\rVert_F=1$ fixes $\lvert A\rvert$, not $\operatorname{sign}(A)$; $A>0$ comes from $W$ being the Weyl tensor rather than its negative, which the block does not say. And $m\ge2$ is implicit, at $m=1$, $W=0$ and the normalisation is unsatisfiable, so the statement is vacuously safe there but should say $m\ge2$.

**None of this touches the truth of the claim.** It is a proof-location and completeness defect.

## 7. Citers, notation, and the duplicate search

**Citers, all inside the hypotheses.**

| citer | what it takes | verdict |
| --- | --- | --- |
| [results.md:740](../results.md#L740) | the spectrum, the multiplicity sum, $\theta=\theta_0(2m)$, the fourth-value clause | all four verified above |
| [results.md:256](../results.md#L256), [results.md:50](../results.md#L50) | the spectrum; Li's Thm 1.8 as the input | correct |
| [bispectral.md:401](../findings/bispectral.md#L401) | $p_3(\omega)=3p_3(\mu)-2\theta_0(n)$ | this is L50 rearranged, $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$; consistent with §3 |
| [bispectral.md:203](../findings/bispectral.md#L203), [target.md:266](../findings/target.md#L266) | $\lambda=\tfrac{n-1}n\mu$ at balanced products | takes one eigenvalue, $\min\omega$, which L67 does give |

**No citer overreaches.** In particular [target.md:157](../findings/target.md#L157) asserts $\lambda=\tfrac{n-1}n\mu$ at **every** $S^p\times S^q$, $p,q\ge2$ (wider than L67's balanced hypothesis) but it credits that to a separate argument (Gate 2, reviewer 132) rather than to L67, so the wider claim does not lean on this lemma.

**A live notation collision, and it sits on L67's own consequence.** [conventions.md](../findings/conventions.md) fixes $\mu=\operatorname{spec}(M)$ on $\Lambda^2$ and $\omega=\operatorname{spec}(\mathring W)$. [bispectral.md:187](../findings/bispectral.md#L187) uses $\mu$ in that sense ($p_3(\mu)$) and then **twelve lines later** [bispectral.md:199](../findings/bispectral.md#L199) writes $\mu:=-\min\omega$, the opposite spectrum, with $\lambda$ introduced undefined in the same display. [target.md:180](../findings/target.md#L180) uses a third scheme, $\nu$ for the second-kind spectrum and $\mu=-\nu_{\min}$, while [target.md:50](../findings/target.md#L50) uses $\mu_1$ for the top eigenvalue of $K$. Three meanings of $\mu$ across two files, one of them inside a single passage. This is the same class of defect [conventions.md](../findings/conventions.md) records for the letter $B$ and for $M$, and it should be added there.

**Wrong file pointer in the narrative.** [ATTEMPTS.md:2306](../ATTEMPTS.md#L2306) closes its account of this result with *"The mathematics is in [target.md](../findings/target.md)."* The mathematics is in [bispectral.md](../findings/bispectral.md); target.md holds no $\omega$-spectrum table.

**Duplicate search, by the quantity.** Two neighbouring spectra at the same point share L67's multiplicity symbols and are **different operators**, so there is no disagreement to find:

- [ATTEMPTS.md:1431](../ATTEMPTS.md#L1431) records a **five**-value spectrum at $S^m\times S^m$ with multiplicities $m^2,\ (m-1)(m+2),\ \binom m2^2$, that is the **Hessian** on $T_{W^*}\mathcal W_n$, of dimension $\dim\mathcal W_n-1$, not $\mathring W$ on $S^2_0$.
- [Lemma L133](../findings/second-order.md#L833) and [second-order.md:857](../findings/second-order.md#L857) record the balanced product's **$L_e$** block spectra ($\pm\tfrac2{n-2}$, $\tfrac12$, $\tfrac{m-2}{2(m-1)}$). Again a different operator.

**The record holds exactly one copy of the $\omega$-spectrum**, at [bispectral.md:177](../findings/bispectral.md#L177), and the numbered block quotes it faithfully apart from dropping $A$. No conflicting copy exists.

## 8. Screen

Permitted screening of a claim recorded here, seconds of compute on objects I constructed. I built the curvature tensor of $S^m(1)\times S^m(1)$ directly, subtracted the scalar part to get $W$, normalised to $\sum\mu^2=1$ on $\Lambda^2$, and assembled $\mathring W$ in Li's $iklj$ order on an orthonormal basis of $S^2_0$, no record code, no vertex matrix. At $m=2,3,4,5$: dimension $9,20,35,54$ as predicted; **maximum deviation from the claimed eigenvalue list $0.0$**; $\sum\omega^2=3.0$; $\theta-\theta_0(2m)=0$; $p_3(\mu)-A=0$; $p_3(\omega)+(4m^2-6m-1)A=0$. *Reported as a screen. The positive claim above rests on §2–§3, which are by hand and hold for all $m\ge2$.*

## 9. Verdict and label

**CONFIRMED.** Hypotheses it needs, all satisfiable and none vacuous: $m\ge2$ (so $n=2m\ge4$ and $W\ne0$); the **balanced** product with **equal radii**, which is what makes it Einstein and collapses the fourth value; the $\Lambda^2$ normalisation $\lVert W\rVert_F=1$ of [conventions.md](../findings/conventions.md), i.e. $\sum\mu^2=1$; and Li's $iklj$ index order. Under those, the spectrum is $\big(mA^{(m-1)(m+2)},\ -(m-1)A^{m^2},\ -2m(m-1)A^{1}\big)$ with $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$, and the multiplicities sum to $\dim S^2_0$.

**The label it deserves is Lemma, but it does not yet hold it.** [findings/INDEX-results.md:81](../findings/INDEX-results.md#L81) lists result **67** as `Lemma` while the row itself reads "**Gate 2: no verdict on the record.**" By that index's own rule, *"Lemma is proven, Gate 1 and Gate 2 passed"*, the label was unearned when written. This review is **one** verdict, so it discharges Gate 1 and half of Gate 2; the row should carry a Gate-2 note naming its reviewers once the twin reports.

## 10. Repairs owed (report only; I edited nothing outside this file)

1. **Put $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$ and $m\ge2$ into the block** at [bispectral.md:454](../findings/bispectral.md#L454) and into [results.md:740](../results.md#L740).
2. **Fix the proof pointer**: "the surrounding material in this file" &rarr; a link to [bispectral.md:171](../findings/bispectral.md#L171). Better, fold §2's four-line block decomposition into that section, which turns the multiplicities from a consequence of a cited theorem plus a numerical check into a derivation.
3. **Fix [ATTEMPTS.md:2306](../ATTEMPTS.md#L2306)**: target.md &rarr; bispectral.md.
4. **Retire the $\mu:=-\min\omega$ overload** at [bispectral.md:199](../findings/bispectral.md#L199) (the file uses $\mu$ for the $\Lambda^2$ spectrum twelve lines above) and record the three-way $\mu$ collision in [conventions.md](../findings/conventions.md) beside the $B$ and $M$ entries.
5. **Update [findings/INDEX-results.md:81](../findings/INDEX-results.md#L81)**'s Gate-2 note once the second reviewer reports.
