# Brief, round L67

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement ([findings/bispectral.md](../findings/bispectral.md) line 517, under the heading at line 503)

At $S^m\times S^m$ with $n=2m$, normalised to $\lVert W\rVert_F=1$ and $m\ge2$, the spectrum of $\mathring W$ takes three values: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$. *The argument is the surrounding material in this file, and [Li 2022](../references/li-2022-product-manifolds-second-kind/README.md) Theorem 1.8 supplies the product rule it rests on.*

## Passage B, the proof written at the block ([findings/bispectral.md](../findings/bispectral.md) line 507)

> **THE PROOF IS THREE LINES AND IS SUPPLIED HERE**, the block having carried a locator to material $260$ lines away that names no heading and identifies no eigenspace. Write $R=G^{(1)}+G^{(2)}$ and $W=R-cG$ with $c=(m-1)/(2m-1)$. Then $\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch$ splits $S^2_0$ into three $O(m)\times O(m)$-invariant summands (the two within-factor trace-free parts and the cross block), whose eigenvalues stand in ratio $m:-(m-1):-2m(m-1)$. *Corroborated against [nondegeneracy.md](nondegeneracy.md)'s $0.210818511$ at $S^3\times S^3$, which is this lemma's $B$-block value to nine digits.*

## Passage C, the value of $A$ written at the block ([findings/bispectral.md](../findings/bispectral.md) lines 511-513)

> **$A$ WAS DEFINED IN NO CANONICAL BLOCK, AND IT IS THE LEMMA'S ONLY REAL USE.** *The normalisation fixes $A^2$, not $A$; the two signs are the two index orders, which [conventions.md](conventions.md) flags as the sharpest hazard here.* **With the record's $iklj$ order,**
> $$A=\frac1{m\sqrt{(m-1)(2m-1)}}>0 ,$$
> confirmed two independent ways, by $\sum\mu^2=1$ and by $\sum\omega^2=3$. **The bottom eigenvalue is $-2m(m-1)A$**, which is what every citer takes and what the canon must state.

## Passage D, the surrounding material the statement points at ([findings/bispectral.md](../findings/bispectral.md) lines 172-196)

#### The maximiser's position in the bi-spectral plane, in closed form

#### Proved symbolically in $m$; the literature input is [Li 2022 Thm 1.8](../references/li-2022-product-manifolds-second-kind/README.md)

For an Einstein product, $\mathrm{spec}(\mathring R)=\mathrm{spec}(\mathring R_1)\cup\mathrm{spec}(\mathring R_2)\cup\{0^{(n_1n_2)}\}\cup\{-\tfrac{n_1\rho_2+n_2\rho_1}{n_1+n_2}\}$, verified here to $1.8\times10^{-15}$ on six sphere products built from true metrics rather than from the vertex matrix ([run_li_thm18_check.py](../scripts/runs/run_li_thm18_check.py)).

Specialising to the balanced $S^m\times S^m$ at $n=2m$ and subtracting the Einstein part to reach the Weyl tensor, the $\omega$-spectrum is three values:

| eigenvalue of $\mathring W$ | multiplicity |
|---|---|
| $mA$ | $(m-1)(m+2)$ |
| $-(m-1)A$ | $m^2$ |
| $-2m(m-1)A$ | $1$ |

with $A=\dfrac1{m\sqrt{(m-1)(2m-1)}}$. The multiplicities sum to $2m^2+m-1=\dim S^2_0(\mathbb R^{2m})$, and $\sum\omega=0$, $\sum\omega^2=3$ identically, the normalisation the identity requires. Hence

$$p_3(\mu)=\frac1{m\sqrt{(m-1)(2m-1)}},\qquad p_3(\omega)=-\frac{4m^2-6m-1}{m\sqrt{(m-1)(2m-1)}} .$$

#### $A$ is not a new constant

it equals the record's $\mathop{\mathrm{tr}}(W^3)=2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at the balanced product, checked to be identically zero difference. And the identity closes symbolically,

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)-\theta_0(2m)=0\quad\text{identically in }m,$$

the residual radical resolving as $\sqrt{4m^4-12m^3+13m^2-6m+1}=2m^2-3m+1$ ([run_maximiser_closed_form.py](../scripts/runs/run_maximiser_closed_form.py)).

## Passage E, the canonical statement ([results.md](../results.md) line 336, landscape, and line 1102, detail)

- **Lemma L67 (second-order). The second-kind spectrum of the balanced product.** At $S^m\times S^m$, $n=2m$, normalised to $\lVert W\rVert_F=1$, the second-kind operator $\mathring W$ has exactly three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, with $A$ the normalising constant. The product rule is Li's Theorem 1.8.

Let $W$ be the Weyl tensor of $S^m\times S^m$ with $n=2m$, normalised to $\lVert W\rVert_F=1$, and let $\mathring W$ be its second-kind operator on $S^2_0$. Then the spectrum of $\mathring W$ takes exactly three values: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, where $A$ is the constant fixed by the normalisation; the multiplicities sum to $\dim S^2_0=\binom{n+1}2-1$. The product rule for the second-kind operator of a Riemannian product is Li's Theorem 1.8, and with Lemma L50 **and the $\Lambda^2$ spectrum $p_3(\mu)$**, which this entry omitted, the spectrum returns $\theta=\theta_0(2m)$ identically in $m$, *$p_3(\mu)$ is worth $2.7\%$ at $m=6$, so L50 does not close it alone.* **And $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$ in the record's $iklj$ order**, which no canonical block stated, leaving a reader unable to conclude the bottom eigenvalue is $-2m(m-1)A$. It reaches the balanced product only; the unbalanced products have a fourth value.

## Passage F, Lemma L50 as the canon states it ([results.md](../results.md) line 322)

- **Lemma L50 (second-order). The potential is a function of two spectra.** With $\mu$ the $\Lambda^2$ spectrum and $\omega$ that of the second-kind operator on $S^2_0$, $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$. The identity is Dai–Fu's Lemma 3.3 at $s=0$; the reading is new. **It collapses to one spectrum for $n\le5$ as an identity of trilinear forms**, pointwise the collapse is not a characterisation, padded $W_{\mathbb{CP}^2}$ collapsing at every $n$, and *"only there"* has no argument on the record above $n=9$. **Two links are owed**: $\beta=2\langle M^\#,M\rangle$, which the coefficient pair is, and the generalised-Kronecker display whose source is unread.

## Passage G, the index convention ([findings/conventions.md](../findings/conventions.md) lines 96-108)

## The second-kind operator, and the index order, SETTLED on Li's $iklj$

$\mathring W$ acts on $S^2_0$, and **the index order is load-bearing**: $W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$ and flips the sign of the bi-spectral identity's $-\tfrac12$ term.

**The record's convention is Li's**, quoted from [Li 2021](../references/li-2021-nonnegative-second-kind/notes.md) §2, equation (2.2), on p. 6 of [arXiv:2112.08465](https://arxiv.org/abs/2112.08465) and again in the introduction on p. 2:

> The second one, denoted by $\mathring R:S^2(V)\to S^2(V)$, is defined by $\mathring R(e_i\odot e_j)=\sum_{k,l}R_{iklj}\,e_k\odot e_l$.

With $u\odot v=u\otimes v+v\otimes u$, so that $h=\tfrac12\sum_{i,j}h_{ij}\,e_i\odot e_j$, this is in matrix form

$$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl},$$

the pair symmetries making the symmetrisation of the output automatic.

## Passage H, the Lean statement

[lean/HamiltonsCubic/Results/L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean), read in full from disk.

## Definitions and sources

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, $S^2_0$ the trace-free symmetric $2$-tensors, $\lVert W\rVert_F$ the Frobenius norm of $W$ acting on $\Lambda^2$. $p_3$ is the sum of cubes of a spectrum.
- **Filed source**: [references/li-2022-product-manifolds-second-kind/](../references/li-2022-product-manifolds-second-kind/), for Li's Theorem 1.8. Read it at source where a step needs it.
- **This loop does no numerical work**; a statement supported only by a run is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **Where the argument is**: Passage A says "the surrounding material in this file", Passage B writes a proof. Whether either establishes the spectrum, and what each imports.
2. **Passage B's objects**: whether $G^{(1)},G^{(2)},G,P_1,P_2,t_1,t_2$ are defined anywhere in the passages, whether $R=G^{(1)}+G^{(2)}$ is the curvature of $S^m\times S^m$ in a stated normalisation, and whether $c=(m-1)/(2m-1)$ is the constant that makes $W=R-cG$ trace-free.
3. **The operator formula** $\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch$ against Passage G's convention, and its restriction to $S^2_0$.
4. **The three invariant summands and the ratio** $m:-(m-1):-2m(m-1)$, with the multiplicities $(m-1)(m+2)$, $m^2$, $1$ assigned to the right summands.
5. **Passage D's route**: Li's Theorem 1.8 at source, its hypotheses against the factors, and the step "subtracting the Einstein part to reach the Weyl tensor" on the spectrum.
6. **The constant $A$**: $A=\frac1{m\sqrt{(m-1)(2m-1)}}$ and its sign, from $\lVert W\rVert_F=1$, and which of $\sum\mu^2=1$ and $\sum\omega^2=3$ fixes it. Whether Passage E's "the constant fixed by the normalisation" states it.
7. **$m\ge2$**, and what happens at $m=1$.
8. **Passage D's and Passage E's further claims**: $p_3(\mu)$ and $p_3(\omega)$ at the balanced product, "$A$ is not a new constant", the closure $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ with the radical, "$p_3(\mu)$ is worth $2.7\%$ at $m=6$", and "the unbalanced products have a fourth value". Which are argued, which rest on runs, and which the lemma uses.
9. **Passage B's corroboration** "$0.210818511$ at $S^3\times S^3$, which is this lemma's $B$-block value".
10. **Passage H**: what the Lean file types, and whether it states the lemma.
11. The boundary: $m=1$, $m=2$ ($n=4$), and the sign convention $ikjl$ against $iklj$.
