# Adjudication brief, round L67-r2, step L2

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From Passage B's detail entry, "The $\Lambda^2$ spectrum at the same point gives $p_3(\mu)=A$, and with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$", read with Passage D, which carries the computation.

**The step: at the normalised Weyl tensor of $S^m\times S^m$, $m\ge2$, the quantity $\theta=\langle W,Q(W)\rangle$ equals $\theta_0(2m)$, and the passages establish this from the two spectra and Lemma L50 as quoted, with nothing the sentence leaves unstated.**

## Passage A, the result's block, statement and proof ([findings/bispectral.md](../findings/bispectral.md) lines 505 and 509-522)

#### Lemma L67, the second-kind spectrum of the balanced product

**Statement.** Let $m\ge2$, $n=2m$, and let $W$ be the Weyl tensor of $S^m\times S^m$, normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by [Lemma L50](../findings/bispectral.md#lemma-l50-the-potential-is-a-function-of-two-spectra-and-collapses-to-one-only-below-dimension-six-canonical-statement-and-proof)'s norm relation. With $R_{ijij}$ the sectional curvature and $\mathring W$ in Li's $iklj$ order ([conventions.md](../findings/conventions.md)), $\mathring W$ on $S^2_0$ has exactly three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, where
$$A=\frac1{m\sqrt{(m-1)(2m-1)}}>0 .$$
At $m=1$ the product is flat and $W=0$.

**Proof.** Let $P_1,P_2$ be the orthogonal projections of $\mathbb R^{2m}$ onto the two factors, $G^{(a)}_{ijkl}=(P_a)_{ik}(P_a)_{jl}-(P_a)_{il}(P_a)_{jk}$ the curvature tensor of the unit sphere on factor $a$, and $G$ the same with $P_a$ replaced by the identity. Then $R=G^{(1)}+G^{(2)}$ is the curvature of the unit product, with Ricci tensor $(m-1)I$, and $W=R-cG$ with $c=\frac{m-1}{2m-1}$, since $G$ has Ricci tensor $(2m-1)I$. For $h\in S^2_0$ and $t_a=\operatorname{tr}(P_ah)$, the $iklj$ contraction gives $\mathring G^{(a)}h=P_ahP_a-t_aP_a$ and $\mathring Gh=h$, so
$$\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch .$$
It has three invariant summands, which together fill $S^2_0$ since $(m-1)(m+2)+m^2+1=2m^2+m-1=\dim S^2_0$.
- *The trace-free parts within each factor*, $h=P_ahP_a$ with $t_a=0$: $\mathring Wh=(1-c)h=\frac m{2m-1}h$, multiplicity $2\big(\binom{m+1}2-1\big)=(m-1)(m+2)$.
- *The cross block*, $h=P_1hP_2+P_2hP_1$: every term but the last vanishes, so $\mathring Wh=-\frac{m-1}{2m-1}h$, multiplicity $m^2$.
- *The line* $h=P_1-P_2$, with $t_1=m$ and $t_2=-m$: $\mathring Wh=(1-m-c)h=-\frac{2m(m-1)}{2m-1}h$, multiplicity $1$.

The unnormalised sum of squares is $\frac{m^2(m-1)}{(2m-1)^2}\big((m+2)+(m-1)+4(m-1)\big)=\frac{3m^2(m-1)}{2m-1}$, so the positive scale $s=\sqrt{(2m-1)/(m^2(m-1))}$ gives $\sum\omega^2=3$, and the eigenvalues become $mA$, $-(m-1)A$ and $-2m(m-1)A$ with $A=s/(2m-1)$. $\square$

*Li's Theorem 1.8 gives the same spectrum as a product rule, in the section on the maximiser's position in the bi-spectral plane above.*

## Passage B, the canonical statement ([results.md](../results.md) line 349, landscape, and lines 1167 and 1169, detail)

- **Lemma L67 (second-order). The second-kind spectrum of the balanced product.** At $S^m\times S^m$, $n=2m$, $m\ge2$, normalised to $\lVert W\rVert_F=1$, the second-kind operator $\mathring W$ in Li's $iklj$ order has exactly three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, where $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$. Li's Theorem 1.8 gives the same spectrum as a product rule.

##### Lemma L67, the second-kind spectrum of the balanced product

Let $m\ge2$ and let $W$ be the Weyl tensor of $S^m\times S^m$ with $n=2m$, normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation, and let $\mathring W$ be its second-kind operator on $S^2_0$ in Li's $iklj$ order, with $R_{ijij}$ the sectional curvature. Then $\mathring W$ has exactly three eigenvalues: $mA$ on the trace-free parts within each factor, multiplicity $(m-1)(m+2)$; $-(m-1)A$ on the cross block, multiplicity $m^2$; and $-2m(m-1)A$ on $P_1-P_2$, multiplicity $1$; where $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$. The multiplicities sum to $\dim S^2_0=2m^2+m-1$. The proof substitutes $W=G^{(1)}+G^{(2)}-\frac{m-1}{2m-1}G$ into the operator, and Li's Theorem 1.8 gives the same spectrum as a product rule. The $\Lambda^2$ spectrum at the same point gives $p_3(\mu)=A$, and with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$.

## Passage C, Lemma L50's statement, a given, with the debts its own block records ([findings/bispectral.md](../findings/bispectral.md) lines 133-139)

**Statement.** Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$. Let $\mathring W$ be the curvature operator of the second kind on trace-free symmetric $2$-tensors, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with spectrum $\omega$. Then

$$\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega),\qquad \sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3 .$$

The index order $iklj$ is Li's and is load-bearing: the order $ikjl$ negates $\mathring W$ and the second coefficient.

**Two links carry this lemma and neither is derived on the record.** **(a) $\beta=2\langle M^\#,M\rangle$** (the step the block calls new), has no derivation anywhere: Gate 2 proved the $\alpha$ half and confirmed this one at $10^{-16}$ over samples, and the pointer to the mathematics leads to a file that no longer carries it. *The whole coefficient pair is that constant: with $\beta=c\sigma$ the identity reads $\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$.* **(b) the generalised-Kronecker display's proportionality**, whose source has no entry in [references/](../references), an unread source, and the whole $n\le5$ collapse rests on it. **And "only there" has no argument at all**: the delta's non-vanishing at $n\ge6$ says nothing about the Weyl cubic, and nothing on file reaches $n\ge10$.

## Passage D, the evaluation at the balanced product in the same file ([findings/bispectral.md](../findings/bispectral.md) lines 174-198)

#### Proved symbolically in $m$; the literature input is [Li 2022 Thm 1.8](../references/li-2022-product-manifolds-second-kind/README.md)

For an Einstein product, $\mathrm{spec}(\mathring R)=\mathrm{spec}(\mathring R_1)\cup\mathrm{spec}(\mathring R_2)\cup\{0^{(n_1n_2)}\}\cup\{-\tfrac{n_1\rho_2+n_2\rho_1}{n_1+n_2}\}$, verified here to $1.8\times10^{-15}$ on six sphere products built from true metrics rather than from the vertex matrix ([run_li_thm18_check.py](../scripts/runs/run_li_thm18_check.py)).

Specialising to the balanced $S^m\times S^m$ at $n=2m$ and subtracting the multiple $\frac{m-1}{2m-1}G$ of the round curvature tensor to reach the Weyl tensor, the $\omega$-spectrum is three values, derived directly in Lemma L67 below:

| eigenvalue of $\mathring W$ | multiplicity |
|---|---|
| $mA$ | $(m-1)(m+2)$ |
| $-(m-1)A$ | $m^2$ |
| $-2m(m-1)A$ | $1$ |

with $A=\dfrac1{m\sqrt{(m-1)(2m-1)}}$. The multiplicities sum to $2m^2+m-1=\dim S^2_0(\mathbb R^{2m})$, and $\sum\omega=0$, $\sum\omega^2=3$ identically, the normalisation the identity requires. Hence

$$p_3(\mu)=\frac1{m\sqrt{(m-1)(2m-1)}},\qquad p_3(\omega)=-\frac{4m^2-6m-1}{m\sqrt{(m-1)(2m-1)}} .$$

*The $\Lambda^2$ side.* $R$ acts on $\Lambda^2$ as the identity on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$ and as $0$ on the mixed part, so $W=R-c\,\mathrm{Id}$ has eigenvalues $\frac m{2m-1}$ at multiplicity $m(m-1)$ and $-\frac{m-1}{2m-1}$ at multiplicity $m^2$. Their unnormalised sum of squares is $\frac{m^2(m-1)}{2m-1}$, a third of the $\omega$ one, so the same scale $s$ normalises both, and $p_3(\mu)=s^3\frac{m^3\cdot m(m-1)-(m-1)^3m^2}{(2m-1)^3}=s^3\frac{m^2(m-1)}{(2m-1)^2}=A$.

#### $A$ is not a new constant

it equals the record's $\operatorname{tr}(W^3)=2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at the balanced product, checked to be identically zero difference. And the identity closes symbolically,

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)-\theta_0(2m)=0\quad\text{identically in }m,$$

the residual radical resolving as $\sqrt{4m^4-12m^3+13m^2-6m+1}=2m^2-3m+1$ ([run_maximiser_closed_form.py](../scripts/runs/run_maximiser_closed_form.py)).

## Passage E, the index convention ([findings/conventions.md](../findings/conventions.md) lines 96-108)

## The second-kind operator, and the index order, SETTLED on Li's $iklj$

$\mathring W$ acts on $S^2_0$, and **the index order is load-bearing**: $W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$ and flips the sign of the bi-spectral identity's $-\tfrac12$ term.

**The record's convention is Li's**, quoted from [Li 2021](../references/li-2021-nonnegative-second-kind/notes.md) §2, equation (2.2), on p. 6 of [arXiv:2112.08465](https://arxiv.org/abs/2112.08465) and again in the introduction on p. 2:

> The second one, denoted by $\mathring R:S^2(V)\to S^2(V)$, is defined by $\mathring R(e_i\odot e_j)=\sum_{k,l}R_{iklj}\,e_k\odot e_l$.

With $u\odot v=u\otimes v+v\otimes u$, so that $h=\tfrac12\sum_{i,j}h_{ij}\,e_i\odot e_j$, this is in matrix form

$$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl},$$

the pair symmetries making the symmetrisation of the output automatic.

## Definitions

- $S^2_0$ is the space of trace-free symmetric $n\times n$ matrices, $p_3$ the sum of cubes of a spectrum, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- A 4-tensor $W$ acts on $\Lambda^2\mathbb R^n$ as the operator $M$. The passages use both $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and fix no relation between them beyond what they state.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Where the value is right but the passages do not establish it as the sentence claims, say both. Return a verdict of VALID or FAILS, with the argument.
