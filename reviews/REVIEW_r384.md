# Review r384, Gate 2 on the ordering argument

*2026-09-02. Adversarial review of the last section of [ATTEMPTS.md](../ATTEMPTS.md), "The ordering argument [post F47](../findings/INDEX-traps.md) asked for, and the equality that blocked every estimate is what makes it work". The whole argument, $\widetilde No=To$, $\sum_io_i=0$, $\widetilde N\mathbf1=0$, the Frobenius identity, the closed form for $\lVert o\rVert^2$, the budget and the $8/7$ threshold, was derived from the definitions before the author's text was opened; the order of work is in [gate2-ordering-B.log](../agent_logs/gate2-ordering-B.log). Analysis only: the single run below is a screen of claims already proved by hand, on two-block-constant critical points constructed here for that purpose, and is reported as a screen.*

## Verdict in one line

**The argument is correct, and it is weaker than what the same four lines will give.** Every step survives an independent cold derivation. Three things are wrong around it: $T>0$ is carried as a hypothesis when it is both *necessary* and *automatic*; the band is not needed and neither is $8/7$, because $\theta\ge1$ suffices; and "it settles the generic case" rests on a census that counts only the pairs where $o\ne0$ holds by construction. One free gain: the same budget proves **simplicity** of $T$, which is what [I18](../plan.md)'s pair half actually asks for and what the section does not claim.

## Verdicts

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $\widetilde No=To$ at every pure critical point and every pair | **CONFIRMED**, re-derived cold from the $(i,j)$ and $(i,k)$ criticality equations and hollowness alone |
| 2 | $\sum_io_i=0$, so $\mathbf1\perp o$ | **CONFIRMED**, from $M\mathbf1=0$ on rows $j$ and $k$ |
| 3 | $\widetilde N\mathbf1=0$ | **CONFIRMED**, and **asserted without proof**; it also has a consequence the section misses (row 6) |
| 4 | $\lVert\widetilde N\rVert_F^2=2-\lVert o\rVert^2-2M_{jk}^2$ | **CONFIRMED**, and it needs **no criticality**, only hollowness, symmetry and $\lVert M\rVert_F^2=2$ |
| 5 | [Lemma L68](../findings/diagonal-half.md): $\lVert o\rVert^2=s_j+s_k-2\theta M_{jk}$, cited in this normalisation | **CONFIRMED**, scope and normalisation both, see [§ L68](#l68-is-inside-its-scope-and-the-citation-can-be-made-scope-free) |
| 6 | $T>0$ is a hypothesis, with sufficient condition $u\!\cdot\!v>-2\theta^2$ | **CORRECTED.** $T>0$ is *necessary* for the conclusion and *automatic* in the band; the stated sufficient condition is arithmetically right and redundant |
| 7 | The eigenvalue-sum step $\lambda^2+T^2\le\lVert\widetilde N\rVert_F^2$ | **CORRECTED (presentation).** Sound for multiplicity, sound for $n\le4$; the two cases $\lambda_{\max}\in\{0,T\}$ are left unwritten and are benign **only because $T>0$** |
| 8 | $\theta^2>8/7$ suffices | **CONFIRMED as stated**, and **superseded**: $\theta\ge1$ suffices, see [§ threshold](#the-threshold-is-thetage1-not-87-and-the-band-is-not-needed) |
| 9 | The band $\theta\ge\sqrt{3/2}$ is needed | **REFUTED.** The theorem survives on all of $\theta\ge1$, which covers every catalogued pure critical point above $\mathbb{CP}^3$ |
| 10 | "It settles the generic case", orbit-free pairs being non-generic | **CORRECTED, overstatement.** The supporting census counts cross pairs only; over *all* pairs, $o=0$ pairs are $45\%$ to $78\%$ at every catalogued in-band point |
| 11 | The reduction leaves [I18](../plan.md)'s pair half on the orbit-free blocks alone | **CONFIRMED**, once row 12 is folded in; **the pair half is one of three I18 clauses**, and nothing here touches the four-set or $\mathcal D_n$ clauses |
| 12 | Free gain not taken: the same budget makes $T$ a **simple** eigenvalue for $\theta>1$ | **NEW.** That is [Lemma L128](../findings/second-order.md)(ii)'s pair half verbatim ("no block contributes a $\tfrac12$-vector beyond the $o^{jk}$") which $\lambda_{\max}=T$ alone does not give |
| 13 | The leftover budget $\theta^2+5M_{jk}^2+2\lVert u\rVert^2\ge2$ in the orbit-free case | **CONFIRMED**, both the algebra and the failure: $1.915659$ at the $S^6\times S^6$ within-factor pair, against a true margin of $0.247207$ |
| 14 | A counterexample: an in-band pure critical point with $o\ne0$ and $\lambda_{\max}(\widetilde N)>T$ | **NONE FOUND**, and none exists, the argument is a proof. See [§ screen](#the-screen) for what was tested and what the record leaves untestable |

## What the cold derivation gives, in the order it came out

**(a) $\widetilde No=To$.** For $i\in I$, criticality at $(i,k)$ reads $v_i^2+\sum_{l\in I}M_{il}v_l+u_iM_{jk}=\theta v_i$, because $(M^2)_{ik}=\sum_{l\in I}M_{il}v_l+u_iM_{jk}$ once $M_{kk}=0$ is used; the same at $(i,j)$ with $u\leftrightarrow v$. Subtracting,
$$\sum_{l\in I}M_{il}o_l=(\theta+M_{jk})o_i-(u_i+v_i)o_i,$$
and adding $\operatorname{diag}(u+v)$ back gives $(\widetilde No)_i=To_i$. **Criticality at the $n-2$ pairs $(i,j)$ and the $n-2$ pairs $(i,k)$ is the whole input; the equation at $(j,k)$ is not used here.**

**(b) $\sum_io_i=0$, and $\widetilde N\mathbf1=0$.** Row $j$ of $M\mathbf1=0$ gives $\sum_Iu_i=-M_{jk}$, row $k$ gives $\sum_Iv_i=-M_{jk}$, so $\sum_Io_i=0$. The same two row sums give $(\widetilde N\mathbf1)_i=\sum_{l\in I}M_{il}+u_i+v_i=(0-u_i-v_i)+u_i+v_i=0$.

**(c) The Frobenius identity.** $\lVert\widetilde N\rVert_F^2=\lVert N\rVert_F^2+\sum_i(u_i+v_i)^2$ since $N$ is hollow. Splitting $\lVert M\rVert_F^2=2$ over the three regions, $\lVert N\rVert_F^2=2-2\lVert u\rVert^2-2\lVert v\rVert^2-2M_{jk}^2$, and $\sum_i(u_i+v_i)^2=\lVert u\rVert^2+\lVert v\rVert^2+2u\!\cdot\!v$, so
$$\lVert\widetilde N\rVert_F^2=2-\lVert u\rVert^2-\lVert v\rVert^2+2u\!\cdot\!v-2M_{jk}^2=2-\lVert o\rVert^2-2M_{jk}^2 .$$
**No criticality anywhere.** The section's "the Frobenius identity, already audited" is safe, and it is safer than advertised.

**(d) The closed form for $\lVert o\rVert^2$, from criticality at $(j,k)$.** $(M^2)_{jk}=u\!\cdot\!v$, so criticality gives $u\!\cdot\!v=\theta M_{jk}-M_{jk}^2$; with $s_j=M_{jk}^2+\lVert u\rVert^2$ and $s_k=M_{jk}^2+\lVert v\rVert^2$,
$$\lVert o\rVert^2=\lVert u\rVert^2+\lVert v\rVert^2-2u\!\cdot\!v=s_j+s_k-2\theta M_{jk}.$$

## $\widetilde N\mathbf1=0$ makes $T>0$ necessary, and the normalisation makes it automatic

**Necessary.** $\widetilde N\mathbf1=0$ puts $0$ in the spectrum at *every* pair, orbit-free or not, so $\lambda_{\max}(\widetilde N)\ge0$ unconditionally. The pair clause $\lambda_{\max}\le T$ therefore *implies* $T\ge0$. A pure critical point in the band with $T<0$ would refute the clause outright rather than merely escape this proof, so $T>0$ is not a convenience the argument buys itself, it is part of what the clause asserts, and the section's framing of it as one hypothesis among four understates it.

**Automatic.** $s_j\ge M_{jk}^2$ and $s_k\ge M_{jk}^2$, while $\sum_is_i=\lVert M\rVert_F^2=2$ forces $s_j+s_k\le2$. Hence
$$2M_{jk}^2\le s_j+s_k\le2,\qquad\lvert M_{jk}\rvert\le1,$$
with equality only if $u=0$ and $s_i=0$ off the pair, which $M\mathbf1=0$ then turns into $M_{jk}=0$. So $\lvert M_{jk}\rvert<1$ at every pure critical point with $n\ge3$, and $T=\theta+M_{jk}>\theta-1>0$ for every $\theta>1$, the band included, with room to spare.

**The recorded sufficient condition is correct and redundant.** From [r378](REVIEW_r378.md)'s $M_{jk}^2-\theta M_{jk}+u\!\cdot\!v=0$, the smaller root exceeds $-\theta$ exactly when $3\theta>\sqrt{\theta^2-4u\!\cdot\!v}$, i.e. $u\!\cdot\!v>-2\theta^2$. The arithmetic checks. It is a condition on a quantity that has to be estimated, where $\lvert M_{jk}\rvert<1$ is a consequence of the normalisation alone.

## The eigenvalue-sum step

**Correct, with the case analysis left out.** $\widetilde N$ is symmetric, and $\mathbf1$ and $o$ are eigenvectors for $0$ and $T$ that are orthogonal and, when $o\ne0$, independent. Write $\lambda=\lambda_{\max}(\widetilde N)$.

- $\lambda=T$: the clause holds with equality, nothing to prove.
- $\lambda=0$: the clause holds because $T>0$. **This is the case where $T>0$ is load-bearing and where the written proof, which passes from $\lvert\lambda\rvert\le T$ to $\lambda\le T$, silently needs it.**
- $\lambda\notin\{0,T\}$: its eigenvector is orthogonal to $\mathbf1$ and to the whole $T$-eigenspace, so $\lambda^2+T^2\le\lVert\widetilde N\rVert_F^2$ and the budget applies.

**Multiplicity strengthens rather than threatens.** If $\dim E(T)=m$ then the budget reads $\lambda^2+mT^2\le\lVert\widetilde N\rVert_F^2$, which is tighter. **Fewer than three distinct eigenvalues is likewise safe**: at $n=4$ the pair $\{\mathbf1,o\}$ spans $\mathbb R^I$ and $\lambda_{\max}=\max(0,T)=T$; at $n=3$, $\widetilde N\mathbf1=0$ and $\widetilde No=To$ on a one-dimensional space force $T=0$ unless $o=0$, so the hypotheses are vacuous there. **The argument carries no lower bound on $n$**, which is worth recording since [I18](../plan.md) is stated at $n\ge12$.

## The threshold is $\theta\ge1$, not $8/7$, and the band is not needed

**The recorded step is right.** $2T^2+\lVert o\rVert^2+2M_{jk}^2=2\theta^2+2\theta M_{jk}+4M_{jk}^2+s_j+s_k$, and dropping $s_j+s_k\ge0$ leaves a quadratic in $M_{jk}$ minimised at $-\theta/4$ with value $\tfrac74\theta^2$. So $\theta^2>8/7$ suffices and $\theta\ge\sqrt{3/2}$ gives $21/8$. **CONFIRMED.**

**Keeping $s_j+s_k$ costs nothing and buys the rest.** Write $x=M_{jk}$ and $P=\lVert u\rVert^2+\lVert v\rVert^2$, so $s_j+s_k=2x^2+P$ and, by (d), $u\!\cdot\!v=\theta x-x^2$. Then
$$2T^2+\lVert o\rVert^2+2M_{jk}^2=2\theta^2+2\theta x+6x^2+P,\qquad P\ \ge\ 2\lvert u\!\cdot\!v\rvert=2\lvert\theta x-x^2\rvert$$
by Cauchy–Schwarz followed by AM–GM. Two cases exhaust it:

- $\theta x\ge x^2$, which for $\theta>0$ forces $x\ge0$: then $P\ge2\theta x-2x^2$ and the total is at least $2\theta^2+4\theta x+4x^2=2\theta^2+4xT\ge2\theta^2$.
- $\theta x<x^2$: then $P\ge2x^2-2\theta x$ and the total is at least $2\theta^2+8x^2\ge2\theta^2$.

> **Lemma (proposed). At every pure critical point and every pair $\{j,k\}$, $\;2T^2+\lVert o\rVert^2+2M_{jk}^2\ \ge\ 2\theta^2$,** with equality only when $M_{jk}=0$ and $u=v=0$. Its inputs are hollowness, $M\mathbf1=0$, criticality at $(j,k)$ and $\lVert M\rVert_F^2=2$.

**Consequence.** The ordering claim holds under $\theta\ge1$ and $o\ne0$, with $T>0$ then automatic by the previous section. $8/7$ corresponds to $\theta\ge1.069$ and the band to $\theta\ge1.2247$; **the theorem survives on all of $\theta\ge1$**, which brings in $\mathbb{CP}^3$ at $1.054093$, $S^3\times S^5$ at $1.115547$, $S^3\times S^7$ at $1.133893$ and $S^4\times S^6$ at $1.185854$, every unbalanced sphere product the record catalogues above $1$. An intermediate sharpening, keeping only $s_j+s_k\ge2M_{jk}^2$, gives $\theta^2\ge12/11$; the Cauchy–Schwarz step supersedes it.

## The same budget gives simplicity, which is what I18 asks for

[Lemma L128](../findings/second-order.md)(ii) reads "$\ker\mathrm{Hess}=T_W\mathcal O$ says exactly that no block contributes a $\tfrac12$-vector beyond the $o^{jk}$", and [plan.md](../plan.md) states the pair half as $\ker B\cap\mathbf1^\perp=\mathbb Ro$. **That is a simplicity statement, and $\lambda_{\max}(\widetilde N)=T$ does not imply it.** Under the identification $\widetilde N=-\Delta^{(jk)}$ of [Lemma L122](../findings/second-order.md), the block's $L_e$-values are $(\lambda-M_{jk})/(2\theta)$, so $L_e=\tfrac12$ is $\lambda=T$ and $\ker B\cap\mathbf1^\perp$ is the $T$-eigenspace of $\widetilde N$ inside $\mathbf1^\perp$.

**It follows from the budget already written.** If $\dim E(T)=m$ then $mT^2\le\lVert\widetilde N\rVert_F^2=2-\lVert o\rVert^2-2M_{jk}^2$, so $m\ge2$ requires $2T^2+\lVert o\rVert^2+2M_{jk}^2\le2$, contradicted by the proposed lemma as soon as $\theta>1$. So

> **at every pure critical point with $\theta>1$ and every pair with $o\ne0$, $T$ is a simple eigenvalue of $\widetilde N$ and $\ker B\cap\mathbf1^\perp=\mathbb Ro$.**

**This is the gain that matters.** With it, the section delivers [I18](../plan.md)'s pair half on the $o\ne0$ pairs rather than a weaker cousin of it, and it does so on $\theta>1$ rather than on the band.

## L68 is inside its scope, and the citation can be made scope-free

**Scope: CONFIRMED.** [Lemma L68](../findings/diagonal-half.md)(iii) is stated on the diagonal locus, and [Lemma L128](../findings/second-order.md) defines a pure critical point as a **frame-diagonal** one, so the setup sits exactly where L68 lives. **Its $o$ is this $o$ up to sign**: $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ and $\lVert M_a-M_b\rVert^2=2M_{ab}^2+\lVert o\rVert^2$ by hollowness, so $g_{jk}=2\lVert o\rVert^2$ identically and the sign of $o$ never enters.

**Normalisation: CONFIRMED.** L68's identity is normalisation-free given criticality (it relates $s_a$, $\theta$ and $M_{ab}$ with no appeal to $\lVert M\rVert_F$) and the screen below reproduces it to $1.7\times10^{-16}$ at seven points built in the setup's own convention $\lVert M\rVert_F^2=2$, which returns the record's $\theta=1.236033$ at $S^6\times S^6$. The factor-of-two trap that [diagonal-half.md](../findings/diagonal-half.md) warns about between the $\Lambda^2$ pairing and the $n\times n$ Frobenius one does not bite here, because every quantity in the argument is on the $n\times n$ side.

**A free simplification.** Step (d) above derives $\lVert o\rVert^2=s_j+s_k-2\theta M_{jk}$ from the single off-diagonal criticality equation at $(j,k)$, in three lines, with no defect machinery. Citing that instead of L68 removes the diagonal-locus scope question from the argument entirely and drops one item from the section's hypothesis list.

## "It settles the generic case" is measured on the wrong population

**The census counts only cross pairs.** [Post F47](../findings/INDEX-traps.md)'s evidence is "$664$ of $664$ in-band cross pairs are equality blocks". At $S^p\times S^q$ a cross pair has $o\ne0$ **by construction** ($o_i=\gamma-\alpha$ on one factor and $\alpha-\gamma$ on the other) so the census confirms that cross pairs are cross pairs. The $o=0$ population lives entirely in the within-factor pairs, which the census excludes.

**Counted over all pairs, $o=0$ is the common case, not the rare one.** At $S^p\times S^q$ the within-factor pairs are exactly the $o=0$ pairs:

| point | $\theta$ | pairs | $o=0$ pairs | share |
| --- | --- | --- | --- | --- |
| $S^6\times S^6$, $n=12$ | $1.236033$ | $66$ | $30$ | $45.5\%$ |
| $S^5\times S^7$, $n=12$ | $1.228239$ | $66$ | $31$ | $47.0\%$ |
| $S^2\times S^{10}$, $n=12$ | $0.994987$ | $66$ | $46$ | $69.7\%$ |
| $S^{10}\times S^{10}$, $n=20$ | $1.307670$ | $190$ | $90$ | $47.4\%$ |
| $S^5\times S^{35}$, $n=40$ | $1.263008$ | $780$ | $605$ | $77.6\%$ |

So at the two points that clear $\sqrt{3/2}$ at $n=12$ (the only in-band points the record catalogues), **close to half of the pairs are the case this argument does not reach**, and the fraction rises with imbalance. "Orbit-free pairs are non-generic" is true of cross pairs and false of pairs.

**What survives, stated positively.** The clause is now proved at every pair with $o\ne0$, which is every cross pair; [I18](../plan.md)'s pair half reduces to the twin pairs, where $u=v$; the reduction itself is airtight, since the two cases are complementary. **The claim to make is "it closes the equality blocks", which is exactly the class [post F47](../findings/INDEX-traps.md) fenced, and it is a real result.** The claim to withdraw is that what remains is a thin edge case.

**And the pair half is one clause of three.** [I18](../plan.md) also needs $\Sigma\ne\theta^2$ at every four-subset ([Lemma L121](../findings/second-order.md)) and no $\tfrac12$ in $\mathcal D_n\cap W^\perp$. Nothing here bears on either.

## The screen

*Objects constructed for this review; exact closed forms, evaluated once. Reported as a screen, and none of the positive claims above rests on it.*

The two-block-constant family is critical for every $(p,q)$ with $\gamma=-\theta/(n-1)$, $\alpha=q\theta/((p-1)(n-1))$, $\beta=p\theta/((q-1)(n-1))$ and $\theta^2=2(n-1)^2\big/\big(pq^2/(p-1)+p^2q/(q-1)+2pq\big)$, derived here, and returning $\theta=1.236033$ at $S^6\times S^6$, which is the record's value, and $\Theta_{12}$ at the band's top. Seven points, both pair types each: criticality residual $\le2.8\times10^{-16}$, $\lVert M\rVert_F^2=2$ to $10^{-15}$, $\widetilde No-To$ to $6.4\times10^{-16}$, $\widetilde N\mathbf1$ to $6.6\times10^{-16}$, [Lemma L68](../findings/diagonal-half.md) to $1.7\times10^{-16}$, the Frobenius identity to $6.7\times10^{-16}$.

| point | pair | $o\ne0$ | $T$ | $\lambda_{\max}(\widetilde N)$ | $\dim E(T)$ | $2T^2+\lVert o\rVert^2+2M_{jk}^2$ vs $2\theta^2$ |
| --- | --- | --- | --- | --- | --- | --- |
| $S^6\times S^6$ | within | no | $1.370873$ | $1.123666$ | $0$ | $3.794949\ge3.055556$ |
| $S^6\times S^6$ | cross | yes | $1.123666$ | $1.123666$ | $1$ | $3.161616\ge3.055556$ |
| $S^5\times S^7$ | within | no | $1.423641$ | $1.116581$ | $0$ | $4.129870\ge3.017143$ |
| $S^5\times S^7$ | cross | yes | $1.116581$ | $1.116581$ | $1$ | $3.147013\ge3.017143$ |
| $S^2\times S^{10}$ | cross | yes | $0.904534$ | $0.904534$ | $1$ | $2.752727\ge1.980000$ |
| $S^5\times S^{35}$ | cross | yes | $1.230623$ | $1.230623$ | $1$ | $3.476676\ge3.190376$ |

**No counterexample, and none is possible for $o\ne0$**, the argument is a proof, and the screen only confirms the arithmetic. Three things it did turn up:

- **Cross pairs are exactly the equality blocks and $T$ is simple at every one of them**, which is [post F47](../findings/INDEX-traps.md) and row 12 together, measured.
- **Within-factor pairs have $T$ outside the spectrum entirely**, with slack $T-\lambda_{\max}=\theta\big(1+\tfrac q{p-1}\big)\big/(n-1)$ against $\lambda_{\max}=\theta(n-2)/(n-1)$ and $T=\theta\big(1+\tfrac q{(p-1)(n-1)}\big)$, a closed form, exact at all seven points, and off the record. So the clause is comfortable in the orbit-free blocks even though the budget cannot see it: at $S^6\times S^6$ the recorded orbit-free budget $\theta^2+5M_{jk}^2+2\lVert u\rVert^2$ returns $1.915659$ against the required $2$, a shortfall of $4.2\%$, while the true margin is $0.247207$, or $18\%$ of $T$. **The section's "the Frobenius budget is the failing $\theta^2+5M_{jk}^2+2\lVert u\rVert^2\ge2$" is confirmed, algebra and failure both.**
- **$S^2\times S^{10}$ sits at $\theta=0.994987$, below the $\theta\ge1$ threshold, and the argument still clears there**, $2.752727$ against the required $2$. So $\theta\ge1$ is sufficient and not necessary, and the true reach is wider still.

**What the screen cannot reach, and it is the point of [I18](../plan.md).** The record catalogues no non-sphere-product pure critical point inside the $\theta$-band: the $C_5$ blow-up sits at $0.670820$, the exact $n=6$ point at $0.308607$, the ungraded ceiling at $0.9067$, and the DGK/SRG points [route R15](../routes.md) owes are not yet pinned. At $n=12$ the band $[1.224745,\,1.236033]$ contains $S^6\times S^6$ and $S^5\times S^7$ and nothing else on record. **So no screen can currently test the ordering claim off the sphere products**, which is an argument for the analytical proof, not against it, and it is why the proposed lemma above is worth having in the record independently of this section.

## Silently used hypotheses

1. **$\lVert M\rVert_F^2=2$**, twice: as the ceiling $2$ in the Frobenius identity, and (in the repair of row 6) as $\sum_is_i=2$ giving $\lvert M_{jk}\rvert<1$. Both are the record's convention, and both should be named where the identity is stated.
2. **Symmetry of $\widetilde N$**, for the orthogonality of eigenvectors that turns "$\mathbf1$ and $o$ are eigenvectors" into "a third eigenvalue's square fits in the remaining budget". True by construction, unstated.
3. **$T>0$ in the passage from $\lvert\lambda\rvert\le T$ to $\lambda\le T$**, the section lists $T>0$ as a hypothesis but does not mark where it is spent.
4. **$\lambda_{\max}$ is a "third" eigenvalue.** The proof bounds a third eigenvalue and concludes about the top; the two coincidence cases need naming.
5. **$n\ge3$** for $\lvert M_{jk}\rvert<1$, and the $n=3$ degeneracy that makes the hypotheses vacuous.

## What to change in the section

- **Replace "$\theta\ge\sqrt{3/2}$ (used only as $\tfrac74\theta^2>2$, so anything above $\theta^2>8/7$ suffices)" with $\theta\ge1$**, and record the proposed lemma $2T^2+\lVert o\rVert^2+2M_{jk}^2\ge2\theta^2$ as the step that gives it.
- **Move $T>0$ out of the hypothesis list**, replacing it with $\lvert M_{jk}\rvert<1$ from the normalisation, and note that $\widetilde N\mathbf1=0$ makes $T\ge0$ a consequence of the clause rather than an assumption.
- **Add the multiplicity line**, four extra words in the same display, and upgrade the claim from $\lambda_{\max}(\widetilde N)=T$ to $\ker B\cap\mathbf1^\perp=\mathbb Ro$, which is what [I18](../plan.md) needs.
- **Rewrite the genericity paragraph** around the pair count above: the result closes the equality blocks, which is the class no estimate could touch, and the twin pairs that remain are $45\%$ to $78\%$ of the pairs at every catalogued in-band point.
- **Re-derive $\lVert o\rVert^2$ from criticality at $(j,k)$ in place of the [Lemma L68](../findings/diagonal-half.md) citation**, which removes the scope question and shortens the hypothesis list.
- **Record the orbit-free closed form** $T-\lambda_{\max}=\theta\big(1+\tfrac q{p-1}\big)\big/(n-1)$ at $S^p\times S^q$: it shows the remaining case is true with margin at every catalogued point, and it says the successor instrument needs to see roughly $18\%$ where the second moment sees $-4\%$.
