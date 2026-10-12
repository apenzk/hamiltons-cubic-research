# Review r859: Ricci-flatness as $\ker S$, the rank bound $\operatorname{rank}S\ge n$, the coordinate configuration's flexibility, and the $T$-marginal consistency check

**Reviewer r859. The brief was cold: the only inputs were the brief's conventions, its thirteen givens and the three quoted blocks of [I74](../plan.md), and no other file of the record was opened. No numerical work beyond hand screening was done, no search or sweep was run, and every value below is exact and closed form. Log: [agent_logs/review-r859-gram.log](../agent_logs/review-r859-gram.log).**

## Verdicts

| # | Claim, as the record states it | Verdict | Reason |
|---|---|---|---|
| 1 | Ricci-flatness of $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ is exactly $S\lambda=0$ | CONFIRMED | both directions hold, the reverse from definiteness of $\operatorname{tr}(AB)$ on $\mathrm{Sym}^2$ plus $\sum\lambda_\alpha\Pi_\alpha$ lying in the span it is tested against |
| 2 | the Ricci-flat weightings are $\ker S$, of dimension $\binom n2-\operatorname{rank}S$ | CONFIRMED | rank-nullity on a $\binom n2$-square matrix, and at the coordinate configuration the space **is** the zero-row-sum weightings of $K_n$, not merely of that dimension |
| 3 | $S$ is positive semidefinite and $\operatorname{rank}S=\dim\operatorname{span}\{\Pi_\alpha\}$ | CONFIRMED | $S$ is a Gram matrix in $(\mathrm{Sym}^2\mathbb R^n,\operatorname{tr}(AB))$. Both facts are invariant under rescaling the inner product, the constants $S_{\alpha\alpha}=2$ and $\operatorname{tr}S=n(n-1)$ are not |
| 4 | $\Xi=\lVert S\rVert_F^2\ge(\operatorname{tr}S)^2/\operatorname{rank}S$ and $\operatorname{tr}S=n(n-1)$ | CONFIRMED | Cauchy-Schwarz over the at most $\operatorname{rank}S$ nonzero eigenvalues, and $\operatorname{tr}S=\sum_\alpha\operatorname{tr}\Pi_\alpha=2\binom n2$ |
| 5 | $\operatorname{rank}S\ge n$ at every orthonormal decomposable basis | CONFIRMED, INCOMPLETE AS WRITTEN | the result is true and I give a shorter proof that uses neither the cap's equality case nor [L201](../findings/INDEX.md). The written argument treats only $\operatorname{rank}S=n-1$ and never disposes of $\operatorname{rank}S<n-1$, which needs one added line |
| 6 | the coordinate configuration has $S=A(J(n,2))+2\,\mathrm{Id}$, spectrum $2n-2,\,n-2,\,0$, rank exactly $n$ | CONFIRMED | verified in closed form at general $n$ and separately at $n=4$ ($6,2,0$ with multiplicities $1,3,2$) and $n=5$ ($8,3,0$ with $1,4,5$) |
| 7 | the Ricci-flat weight space is at most $\binom n2-n$, attained at the coordinate configuration | CONFIRMED | immediate from claim 5, and I strengthen it: $\operatorname{rank}S=n$ holds **only** at the coordinate configurations |
| 8 | a generic configuration admits no nonzero Ricci-flat weighting, "the count being $\binom n2$ unknowns against $\tfrac{n(n+1)}2$ conditions" | REFUTED AS STATED, conclusion CONFIRMED at $n=4$ | the count is not an argument, since the $\tfrac{n(n+1)}2$ conditions are never independent and the same count would deny the coordinate configuration its $\binom n2-n$ solutions. The conclusion is earned instead by the closed-form configuration of §6.3, which has $\operatorname{rank}S=6$ at $n=4$, plus lower semicontinuity of rank |
| 9 | $\sum_\gamma T_{\alpha\beta\gamma}=S_{\alpha\beta}$ off the diagonal, $\hat S=S-2\,\mathrm{Id}$, and relation (B) is $S\lambda=0$ | CONFIRMED | Parseval on $[\omega_\alpha,\omega_\beta]$ with given 8, and $S_{\alpha\alpha}=2$ at every configuration |
| 10 | summing relation (C) over $k$ reproduces $\lambda^{\mathsf T}\hat S\lambda=-2\lVert W\rVert^2$, with $\operatorname{tr}W=0$ the only extra input | CONFIRMED AS ALGEBRA | the algebra is right, and $\operatorname{tr}W=0$ is an input the block already owns: it is the $\mathbf 1$-contraction of $S\lambda=0$. With $S$ positive semidefinite the summed (C) is equivalent to $S\lambda=0$, so it is slightly stronger than the block claims |
| 11 | "two independent arrivals at $S\lambda=0$" | REFUTED AS STATED | both arrivals contract the same operator identity $W\#\mathrm{Id}=-W$, which is Ricci-flatness itself. The block's own billing as a consistency check is the accurate one |

**One line to act on: the mathematics of [I74](../plan.md)'s first step stands, and two of its written justifications do not. Patch the rank bound with the $\operatorname{rank}S<n-1$ case (or replace it with the shorter proof in §4.3, which drops the dependence on [L201](../findings/INDEX.md) and yields "$\operatorname{rank}S=n$ iff coordinate"), and replace the genericity count with the exhibited $n=4$ configuration of §6.3.**

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$, the orthogonal projection onto $P=\mathrm{span}\{u,v\}$. This holds for exactly this normalisation: the $1/\sqrt2$ convention returns $\tfrac12\Pi_P$.
- $\omega$ is decomposable when $\omega=u\wedge v$, equivalently $\omega\wedge\omega=0$. The record's wedge is TWICE the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

Two inner products run side by side through this argument and must not be conflated: $\Lambda^2$ carries $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, while $\mathrm{Sym}^2\mathbb R^n$, where the $\Pi_\alpha$ live, carries the plain $\operatorname{tr}(AB)$ fixed by given 10. The pair is consistent: $\lVert\omega_\alpha\rVert_{\Lambda^2}=1$ and $\operatorname{tr}(\Pi_\alpha^2)=\operatorname{tr}\Pi_\alpha=2$.

## Hypothesis inventory

What the three blocks actually assume, in the order they use it:

1. A fixed **orthonormal basis $\{\omega_\alpha\}_{\alpha=1}^{\binom n2}$ of the whole of $\Lambda^2\mathbb R^n$ by decomposable unit forms** (the "configuration"), with $\Pi_\alpha$ the projection onto $\omega_\alpha$'s plane and $S_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$.
2. $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$, so **that basis is an eigenbasis of $W$**. This is the load-bearing hypothesis of the whole block and it is a genuine restriction on $W$, discussed in §8.
3. Given 1 ($\Theta$ basis-independent, additive, $\Theta(\Lambda^2\mathbb R^n)=(n-1)\mathrm{Id}$) and given 2 (Ricci-flatness is $\sum_\mu\lambda_\mu\Theta(E_\mu)=0$).
4. Given 8 for the range of $S$ off the diagonal, given 10 for the cap $\Xi\le n^2(n-1)$ with equality exactly at integrality, given 9 (L201) for integral implies coordinate, given 11 for the coordinate Gram matrix, given 12 for relations (B) and (C), given 13 for the norm.
5. $n\ge3$ throughout. The rank bound's final division needs $n\ge3$, and $n=3$ is the degenerate case where $\ker S=0$ and there is no nonzero Weyl tensor at all.

Nowhere does the block need $\lambda\ne0$, criticality, $\theta$, or first Bianchi. Bianchi is free here, which §9 records.

## 1. Is Ricci-flatness really equivalent to $S\lambda=0$?

Write $M=\sum_\alpha\lambda_\alpha\Pi_\alpha\in\mathrm{Sym}^2\mathbb R^n$. Given 2 with the eigen-decomposition of hypothesis 2, together with $\omega_\alpha\omega_\alpha^{\mathsf T}=\Pi_\alpha$ from the brief's normalisation, says Ricci-flatness is $M=0$. So the question is whether $M=0\iff\operatorname{tr}(M\Pi_\beta)=0$ for every $\beta$, that is $\iff S\lambda=0$.

**Forward.** $M=0$ gives $\operatorname{tr}(M\Pi_\beta)=0$ for every $\beta$ at once, so $(S\lambda)_\beta=\sum_\alpha\lambda_\alpha\operatorname{tr}(\Pi_\alpha\Pi_\beta)=0$. This direction needs nothing.

**Reverse.** Suppose $(S\lambda)_\beta=0$ for every $\beta$, so $M$ is $\operatorname{tr}$-orthogonal to every $\Pi_\beta$ and hence to $\operatorname{span}\{\Pi_\beta\}$. But $M$ is by construction a linear combination of the $\Pi_\alpha$, so $M$ lies in that same span, so $\operatorname{tr}(M^2)=0$. On real symmetric matrices $\operatorname{tr}(A^2)=\sum_{ij}A_{ij}^2$, a positive definite quadratic form, so $M=0$.

The step therefore needs exactly two things: $M\in\operatorname{span}\{\Pi_\alpha\}$, which is automatic since $M$ is that combination, and definiteness of $\operatorname{tr}(AB)$ on symmetric matrices. The block's phrase "the $\Pi$'s spanning the same space" is a compressed way of saying the first, and it is correct, though the load actually sits on definiteness, which the block never names. Nothing about decomposability, orthonormality of the $\omega_\alpha$, or the size of the index set is used in this step: the same argument holds for any finite family of symmetric matrices. Decomposability enters one step earlier, in $\omega_\alpha\omega_\alpha^{\mathsf T}=\Pi_\alpha$, which is where the $\Pi_\alpha$ come from at all.

Normalisation. Under the $1/\sqrt2$ bivector convention one gets $\omega_\alpha\omega_\alpha^{\mathsf T}=\tfrac12\Pi_\alpha$, $S$ is scaled by $\tfrac14$, and the equivalence is untouched because it is scale-free. The constants $S_{\alpha\alpha}=2$, $\operatorname{tr}S=n(n-1)$ and the cap $n^2(n-1)$ are not scale-free, and everything from §4 on depends on them, so the block's convention has to be held fixed from here.

## 2. Is $\ker S$ the space of Ricci-flat weightings, of dimension $\binom n2-\operatorname{rank}S$?

Yes on both counts. §1 gives the equality of sets $\{\lambda:\ W(\lambda)\ \text{Ricci-flat}\}=\ker S$, and $S$ is a symmetric $\binom n2\times\binom n2$ matrix, so rank-nullity gives $\dim\ker S=\binom n2-\operatorname{rank}S$ with no further hypothesis.

**The coordinate configuration, checked against $K_n$.** Here $\Pi_{ij}=E_{ii}+E_{jj}$, so $S_{\{ij\},\{kl\}}=\lvert\{i,j\}\cap\{k,l\}\rvert$, which is $2$, $1$ or $0$ according as the pairs are equal, meet in one index, or are disjoint. Reading $\lambda$ as an edge weighting of $K_n$,
$$\sum_{i<j}\lambda_{ij}\Pi_{ij}=\sum_{i<j}\lambda_{ij}(E_{ii}+E_{jj})=\operatorname{diag}(d_1,\dots,d_n),\qquad d_i=\sum_{j\ne i}\lambda_{ij},$$
so the Ricci-flat weightings are exactly the zero-row-sum weightings of $K_n$. **The two spaces coincide, they do not merely share a dimension**, and the block is right to say "it is exactly" here. The dimension is $\binom n2-n$ for $n\ge3$, because the map $\lambda\mapsto(d_i)$ is the unsigned incidence map of $K_n$, whose rank is $n$ for a connected non-bipartite graph. At $n=3$ that gives $\dim\ker S=0$, matching $\mathcal W_3=0$.

The block's closing remark that "a NONZERO critical point requires a degenerate Gram matrix" is right as stated but slightly mislabelled: what $\det S\ne0$ excludes is any nonzero Ricci-flat $W$ with this eigenbasis, critical or not. Criticality plays no part in the argument.

## 3. Is $S$ positive semidefinite, and is $\operatorname{rank}S=\dim\operatorname{span}\{\Pi_\alpha\}$?

Both hold, and both are the standard Gram facts. For any $x\in\mathbb R^{\binom n2}$,
$$x^{\mathsf T}Sx=\sum_{\alpha\beta}x_\alpha x_\beta\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\operatorname{tr}\Big(\big(\textstyle\sum_\alpha x_\alpha\Pi_\alpha\big)^2\Big)=\Big\lVert\sum_\alpha x_\alpha\Pi_\alpha\Big\rVert_F^2\ge0,$$
which also identifies $\ker S$ with the linear relations among the $\Pi_\alpha$ and hence gives $\operatorname{rank}S=\binom n2-\dim\ker S=\dim\operatorname{span}\{\Pi_\alpha\}$. This is a second route to §1's reverse direction, and it makes plain that the only analytic input anywhere is definiteness of the Frobenius form.

Which normalisation each needs: neither. Both statements survive replacing $\operatorname{tr}(AB)$ by any positive multiple, since that rescales $S$. What the plain trace buys is the numerology used from §4 on, $S_{\alpha\alpha}=\operatorname{tr}\Pi_\alpha=2$ and $\operatorname{tr}S=n(n-1)$. The $\tfrac12$-convention of the $\Lambda^2$ product would halve $\operatorname{tr}S$ and break the cap's constant, so given 10's insistence on the plain trace is load-bearing exactly there.

## 4. The rank bound

### 4.1 The inequality and the trace

$\Xi=\sum_{\alpha\beta}S_{\alpha\beta}^2=\lVert S\rVert_F^2=\sum_i\sigma_i^2$ over the eigenvalues of $S$, since $S$ is symmetric. With $r=\operatorname{rank}S$ nonzero eigenvalues, Cauchy-Schwarz on the vector of nonzero eigenvalues against $\mathbf 1\in\mathbb R^r$ gives $(\operatorname{tr}S)^2=\big(\sum_{i}\sigma_i\big)^2\le r\sum_i\sigma_i^2=r\,\Xi$, so $\Xi\ge(\operatorname{tr}S)^2/r$. Correct, and it does not even need positive semidefiniteness, only a real spectrum. And $\operatorname{tr}S=\sum_\alpha\operatorname{tr}(\Pi_\alpha^2)=\sum_\alpha\operatorname{tr}\Pi_\alpha=2\binom n2=n(n-1)$. Correct.

For completeness, given 10's cap is itself one line from the givens, which is worth recording because everything downstream leans on it: $\sum_\alpha\Pi_\alpha=\Theta(\Lambda^2\mathbb R^n)=(n-1)\mathrm{Id}_n$ by given 1, so $\sum_{\alpha\beta}S_{\alpha\beta}=\operatorname{tr}\big((n-1)^2\mathrm{Id}\big)=n(n-1)^2$ and hence $\sum_{\alpha\ne\beta}S_{\alpha\beta}=n(n-1)^2-n(n-1)=n(n-1)(n-2)$, matching given 10. Since $S_{\alpha\beta}\in[0,1]$ off the diagonal by given 8, $S_{\alpha\beta}^2\le S_{\alpha\beta}$ there, so $\Xi\le 2n(n-1)+n(n-1)(n-2)=n^2(n-1)$, with equality iff every off-diagonal entry is $0$ or $1$, which is integrality.

### 4.2 The contradiction at $r=n-1$, and the ranks the block forgets

At $r=n-1$ the bound reads $\Xi\ge n^2(n-1)^2/(n-1)=n^2(n-1)$, against the cap $\Xi\le n^2(n-1)$, so $\Xi=n^2(n-1)$ exactly. That is the **cap's** equality case, so by given 10 the configuration is integral, so by L201 its planes are the coordinate $2$-planes of some frame, whose $S$ has rank $n$ by §5. Since $n\ne n-1$, contradiction. Every step of that is sound, and note what it uses: the equality case of the cap, not the equality case of Cauchy-Schwarz. The block does not use Cauchy-Schwarz equality and does not need to.

**But the block only ever rules out $r=n-1$, then writes "the contradiction gives $\operatorname{rank}S\ge n$".** That is a gap, and it is the one item on the attack list where the written chain does not reach its stated conclusion. The repair is one line, since the bound is decreasing in $r$: for any $r\le n-1$,
$$\Xi\ \ge\ \frac{n^2(n-1)^2}{r}\ \ge\ \frac{n^2(n-1)^2}{n-1}\ =\ n^2(n-1),$$
strictly for $r<n-1$, which contradicts the cap outright without any appeal to integrality, and at $r=n-1$ leaves the argument of the previous paragraph. So all ranks below $n$ are excluded, and the omission is presentational rather than substantive. It should still be written, because as it stands the block's most quoted sentence rests on an unstated monotonicity.

### 4.3 A shorter proof that needs neither L201 nor the cap's equality case

The configuration always has one eigenvalue of $S$ for free. From $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}_n$,
$$(S\mathbf 1)_\beta=\sum_\alpha\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\operatorname{tr}\big((n-1)\Pi_\beta\big)=2(n-1),$$
so $S\mathbf 1=2(n-1)\mathbf 1$ at **every** orthonormal decomposable basis. Split that eigenvalue off before applying Cauchy-Schwarz. The remaining nonzero eigenvalues are $r-1$ in number and sum to $\operatorname{tr}S-2(n-1)=(n-1)(n-2)$, so
$$\Xi\ \ge\ 4(n-1)^2+\frac{(n-1)^2(n-2)^2}{r-1}.$$
Against the cap $\Xi\le n^2(n-1)$ this gives $(n-1)^2(n-2)^2/(r-1)\le n^2(n-1)-4(n-1)^2=(n-1)(n-2)^2$, hence $(n-1)\le r-1$, hence
$$\boxed{\operatorname{rank}S\ \ge\ n}\qquad (n\ge3),$$
with no case analysis, no integrality and no appeal to L201. Equality forces the other $n-1$ nonzero eigenvalues all to equal $(n-1)(n-2)/(n-1)=n-2$, which is precisely the coordinate spectrum of §5, and forces $\Xi=n^2(n-1)$ exactly, so the cap's equality case plus L201 upgrades the block's "the coordinate configurations attain it" to
$$\operatorname{rank}S=n\iff\text{the configuration is coordinate}.$$
The block's claim is therefore true and slightly understated, its argument is sound but incomplete as written, and the dependence on L201 can be moved from the bound itself to the classification of the extreme case, which is a cleaner division of labour.

## 5. Do coordinate configurations attain rank $n$?

$J(n,2)$ is the triangular graph $T(n)$, strongly regular of degree $2(n-2)$ on $\binom n2$ vertices, with spectrum $2(n-2)$ once, $n-4$ with multiplicity $n-1$, and $-2$ with multiplicity $\binom n2-n$. That is given 11's list, and §2 confirms $S=A(J(n,2))+2\,\mathrm{Id}$ from $S_{\{ij\},\{kl\}}=\lvert\{i,j\}\cap\{k,l\}\rvert$. Adding $2$ shifts the spectrum to
$$2n-2\ (\times1),\qquad n-2\ (\times\,n-1),\qquad 0\ (\times\,\tbinom n2-n),$$
so $\operatorname{rank}S=n$ for every $n\ge3$, the top eigenvector being $\mathbf 1$ as §4.3 predicts, and $\Xi=(2n-2)^2+(n-1)(n-2)^2=n^2(n-1)$, the cap. The projections span the frame's diagonal matrices, of dimension $n$, matching §3.

$n=4$: $\binom42=6$, spectrum $6,2,2,2,0,0$, rank $4=n$, $\dim\ker S=2=\binom42-4$, and the kernel is the zero-row-sum weightings of $K_4$. Those satisfy $\lambda_{12}=\lambda_{34}$, $\lambda_{13}=\lambda_{24}$, $\lambda_{14}=\lambda_{23}$ together with $\lambda_{12}+\lambda_{13}+\lambda_{14}=0$: subtracting rows $1$ and $2$ and adding rows $3$ and $4$ gives $2(\lambda_{13}+\lambda_{14})+2\lambda_{34}=0$, so $\lambda_{34}=-(\lambda_{13}+\lambda_{14})=\lambda_{12}$. Two free parameters, confirming the count. $\Xi=36+3\cdot4=48=4^2\cdot3$, the cap.

$n=5$: $\binom52=10$, Johnson spectrum $6,1(\times4),-2(\times5)$, so $S$ has spectrum $8,3(\times4),0(\times5)$, rank $5=n$, $\dim\ker S=5=\binom52-5$. $\Xi=64+4\cdot9=100=5^2\cdot4$, the cap. Note that $n=4$ is the case where the middle Johnson eigenvalue $n-4$ vanishes, which shifts to $2$ and costs no rank, so nothing special happens there.

## 6. The flexibility claim

### 6.1 The upper bound on the weight space

Conditional on §4, $\dim\ker S=\binom n2-\operatorname{rank}S\le\binom n2-n$ at every configuration, and §2 and §5 show the coordinate configuration attains it with the space itself identified. Confirmed, and by §4.3 the coordinate configurations are the only ones attaining it.

### 6.2 The parameter count is not an argument

The count as stated is $\binom n2$ unknowns against $\tfrac{n(n+1)}2$ conditions, the conditions being the entries of the symmetric matrix equation $\sum_\alpha\lambda_\alpha\Pi_\alpha=0$. The tally of each is right, and $\binom n2-\tfrac{n(n+1)}2=-n$ for every $n$, so the count says "over-determined by $n$" at every dimension. That is precisely why it cannot support the conclusion: **the same count applies verbatim at the coordinate configuration, which has an $\big(\binom n2-n\big)$-dimensional solution space.** The conditions are never independent, and their number is capped structurally: the image of $\lambda\mapsto\sum\lambda_\alpha\Pi_\alpha$ lies in $\operatorname{span}\{\Pi_\alpha\}$, of dimension $\operatorname{rank}S\le\binom n2$, so at most $\binom n2$ of the $\tfrac{n(n+1)}2$ conditions can ever be independent, and $\Theta$ forces one more relation than a naive count sees, namely $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}$.

The honest criterion is the one §3 supplies: the configuration admits no nonzero Ricci-flat weighting iff the $\binom n2$ projections $\Pi_\alpha$ are linearly independent in $\mathrm{Sym}^2\mathbb R^n$, that is iff $\operatorname{rank}S=\binom n2$. There is no dimensional obstruction to that, since $\binom n2\le\binom{n+1}2$, and at $n=3$ it actually happens ($\operatorname{rank}S=3=\binom32$, consistent with $\mathcal W_3=0$). To claim it for generic configurations at $n\ge4$ one must exhibit one such configuration and know that rank is lower semicontinuous, which is what the block never does. So the sentence as written is unearned. The next subsection earns it at $n=4$.

### 6.3 What "generic" can mean at $n=4$, and a configuration that has no Ricci-flat weighting at all

Appendix A derives, in closed form, a dictionary for $n=4$: orthonormal decomposable bases of $\Lambda^2\mathbb R^4$ correspond to sextuples of unit vectors $a_\alpha\in S^2\subset\mathbb R^3$ with
$$\sum_{\alpha=1}^6 a_\alpha a_\alpha^{\mathsf T}=2\,\mathrm{Id}_3,\qquad\text{and then}\qquad S_{\alpha\beta}=1-(a_\alpha\cdot a_\beta)^2\ \ (\alpha\ne\beta),\qquad S_{\alpha\alpha}=2 .$$
Take for $\{a_\alpha\}$ the six axes of a regular icosahedron, which are equiangular with $\lvert a_\alpha\cdot a_\beta\rvert=1/\sqrt5$ and form a tight frame because their Gram matrix commutes with an irreducible action of the icosahedral group on $\mathbb R^3$. Then
$$S=\tfrac45\big(\mathbf{1}\mathbf{1}^{\mathsf T}-\mathrm{Id}\big)+2\,\mathrm{Id}=\tfrac45\,\mathbf{1}\mathbf{1}^{\mathsf T}+\tfrac65\,\mathrm{Id},$$
whose spectrum is $\tfrac{24}5+\tfrac65=6$ once and $\tfrac65$ five times. Every eigenvalue is positive, so $\operatorname{rank}S=6=\binom42$ and $\det S=6\,(6/5)^5=46656/3125\ne0$: **this configuration admits no nonzero Ricci-flat weighting whatsoever.** Three independent checks that it is a legitimate configuration and not an artefact: $\operatorname{tr}S=12=n(n-1)$; $\sum_{\alpha\ne\beta}S_{\alpha\beta}=30\cdot\tfrac45=24=n(n-1)(n-2)$, exactly given 10's fixed total; $S\mathbf 1=6\mathbf 1=2(n-1)\mathbf 1$, exactly §4.3's universal eigenvalue. Its off-diagonal entries are $4/5\in(0,1)$, so it is non-integral and by L201 non-coordinate, as it must be. And $\Xi=24+30\cdot\tfrac{16}{25}=\tfrac{1080}{25}=43.2<48$, comfortably under the cap.

With that witness the genericity statement can be made properly at $n=4$. Appendix A also shows the moduli space of configurations modulo isometry is the set of unit tight frames of six vectors in $\mathbb R^3$ modulo $O(3)$ and per-vector sign, of dimension $12-5-3=4$. On it, $\{\operatorname{rank}S\le5\}=\{\det S=0\}$ is closed and, by the icosahedral point, proper. So "a generic configuration admits no nonzero Ricci-flat weighting" is true at $n=4$ in the only sense that matters, the complement of a proper closed subset, and it is true for the reason the block does not give. At general $n$ the statement remains unproven, since no witness with $\operatorname{rank}S=\binom n2$ has been exhibited for $n\ge5$.

## 7. The consistency check with relations (B) and (C)

**The marginal.** $[\omega_\alpha,\omega_\beta]$ is skew, hence in $\Lambda^2$, and $\{\omega_\gamma\}$ is an orthonormal basis of $\Lambda^2$ in the same inner product that defines $c_{\alpha\beta\gamma}$, so Parseval gives $\sum_\gamma T_{\alpha\beta\gamma}=\sum_\gamma c_{\alpha\beta\gamma}^2=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$, which is $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=S_{\alpha\beta}$ by given 8. So $\sum_\gamma T_{\alpha\beta\gamma}=S_{\alpha\beta}$ for $\alpha\ne\beta$. Confirmed. I checked given 8 itself on one instance to be sure of the normalisation: $[e_1\wedge e_2,\ e_1\wedge e_3]=-E_{23}+E_{32}=e_2\wedge e_3$, of norm $1$, against $\operatorname{tr}(\Pi_{12}\Pi_{13})=1$.

**$\hat S=S-2\,\mathrm{Id}$.** For $\alpha=\beta$ the marginal is $0$, whether one reads it off hollowness of $T$ or off $[\omega_\alpha,\omega_\alpha]=0$, while $S_{\alpha\alpha}=2$ at every configuration. So the matrix $\hat S_{\alpha\beta}=\sum_\gamma T_{\alpha\beta\gamma}$ is $S$ with its diagonal zeroed, and because that diagonal is the constant $2$, $\hat S=S-2\,\mathrm{Id}$ exactly. Confirmed. The constant $2$ is the one place where the plain-trace normalisation shows up in this block.

**Relation (B).** $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=\sum_\beta\lambda_\beta\hat S_{k\beta}=(S\lambda)_k-2\lambda_k$, so (B) reading $=-2\lambda_k$ at every $k$ is exactly $(S\lambda)_k=0$ at every $k$, that is $S\lambda=0$. Confirmed, and this is an equivalence, not merely an implication.

**Relation (C), summed.** Total symmetry of $T$ (given 12) lets the free index be moved into the marginal:
$$\sum_k\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma\sum_k T_{\beta\gamma k}=\lambda^{\mathsf T}\hat S\lambda=\lambda^{\mathsf T}S\lambda-2\lVert W\rVert^2,$$
using given 13 for $\lVert\lambda\rVert^2=\lVert W\rVert^2$. The right-hand side of (C), summed, is $\sum_k2\lambda_k(\theta-\lambda_k)=2\theta\operatorname{tr}W-2\lVert W\rVert^2$. So summing (C) says
$$\lambda^{\mathsf T}S\lambda=2\theta\operatorname{tr}W .$$
The block's version of this is $\lambda^{\mathsf T}\hat S\lambda=\lambda^{\mathsf T}S\lambda-2\lVert W\rVert^2=-2\lVert W\rVert^2$ matching term for term "once $\operatorname{tr}W=0$", which is right, evaluated under $S\lambda=0$. Two corrections of substance:

- **$\operatorname{tr}W=0$ is not extra input.** It follows from Ricci-flatness inside this framework, twice over: taking the trace of $\sum_\alpha\lambda_\alpha\Pi_\alpha=0$ gives $2\sum_\alpha\lambda_\alpha=0$, and equivalently contracting $S\lambda=0$ against $\mathbf 1$ gives $0=\mathbf 1^{\mathsf T}S\lambda=2(n-1)\mathbf 1^{\mathsf T}\lambda$. So the block owns it already, and its remark that "$\theta$ is absent from both" is right for the sharper reason that the $\theta$ term is $2\theta\operatorname{tr}W=0$ rather than that $\theta$ never appeared.
- **The summed (C) is equivalent to $S\lambda=0$, not weaker.** Given $\operatorname{tr}W=0$ it reads $\lambda^{\mathsf T}S\lambda=0$, and $S$ is positive semidefinite by §3, so $\lambda\in\ker S$. So the "consistency check" is in fact a second complete route to Ricci-flatness, which strengthens the block's point rather than weakening it.

**"Two independent arrivals."** This I do not accept. Given 12 records that (B) is the diagonal of $W\#\mathrm{Id}=-W$, and that identity is Ricci-flatness in operator form, so the $T$-marginal route and the $\Theta$-contraction route are two contractions of one identity, not two independent derivations. The agreement is a check on the record's normalisations and index conventions, which has real value, and it is no evidence for $S\lambda=0$ beyond given 2. The block's own words "which is a consistency check rather than new content" are the accurate description, so the defect is confined to the word "independent".

## 8. The kernel

**Nothing in the algebra breaks when some $\lambda_\alpha=0$.** $S$ is built from the configuration and never from $\lambda$, so the rank bound, the cap, the spectrum and §4.3 are untouched. Zero eigenvalues are simply zero entries of $\lambda$, and $\ker S$ is a linear space, so it contains weightings of every support pattern its geometry allows. At the coordinate configuration the kernel is the zero-row-sum weightings of $K_n$, which certainly contains weightings with zeros, and given 4's rotated witness has the weighting $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$, nowhere zero. So $\ker W\ne0$ is not an obstruction to any step of this block, which is a genuine improvement on the record's usual position.

**But there is a hypothesis-scope trap that $\ker W\ne0$ makes sharp.** Every step from §4 on needs the configuration to be a full orthonormal decomposable basis of $\Lambda^2\mathbb R^n$, because that is what given 10's cap and L201 are about. If a Weyl tensor has decomposable eigenforms only on the support of $\lambda$, and the kernel of $W$ is spanned by forms that are not decomposable, then:

- the equivalence of §1 still localises. Restricting to the support indices, $\sum_{\alpha\in\mathrm{supp}}\lambda_\alpha\Pi_\alpha=0$ iff it is $\operatorname{tr}$-orthogonal to $\Pi_\beta$ for $\beta\in\mathrm{supp}$, since the argument only ever tests a vector against a span containing it. So Ricci-flatness is $S'\lambda'=0$ on the principal submatrix $S'$, and §2 and §3 survive verbatim.
- the rank bound does not. $\Xi'$ over a proper subset of a basis has no cap from given 10, and L201 does not apply to a partial configuration, so $\operatorname{rank}S'\ge n$ is unproven. Nothing in §4 rescues it, because the missing $\Pi_\alpha$ are exactly what makes $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}$ available.

So the recommendation is to state the hypothesis as "every element of the eigenbasis, kernel included, is decomposable", not "$W$ has a decomposable eigenbasis on its support". The block's algebra assumes the former throughout and its prose does not distinguish them.

A second scope note: when $W$ has a repeated eigenvalue the decomposable eigenbasis is not unique, and different choices can give different $S$ with different ranks. That breaks nothing, since every claim here is per-configuration, and the existential form "there is an orthonormal decomposable eigenbasis" is what the hypotheses supply. It does mean $\operatorname{rank}S$ is an invariant of the configuration and not of $W$.

## 9. Vacuity and triviality

**An object satisfying the hypotheses, in closed form.** Take the coordinate configuration at $n=4$ and the weighting $\lambda_{12}=\lambda_{34}=1$, $\lambda_{13}=\lambda_{24}=-1$, $\lambda_{14}=\lambda_{23}=0$. Row sums vanish, so §2 makes $W=\sum\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ Ricci-flat and nonzero. It is symmetric by construction, trace-free because $\sum_\alpha\lambda_\alpha=0$, and it satisfies first Bianchi for free: given 6 gives $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha$, and every $\omega_\alpha$ is decomposable, so every $\omega_\alpha\wedge\omega_\alpha=0$. **So inside this framework first Bianchi is automatic, and every element of $\ker S$ is an algebraic Weyl tensor.** That is worth stating in the record, since it means the block's $\ker S$ is literally a linear slice of $\mathcal W_n$ and not merely of the Ricci-flat symmetric operators. The hypotheses are therefore satisfiable at every $n\ge4$, and non-trivially so, with $\dim\ker S=\binom n2-n\ge2$.

**What each claim would look like if it were vacuous, and why it is not.**

- Claim 1 would be vacuous if no configuration existed. Coordinate configurations exist at every $n\ge3$, and given 4's rotated witness is a non-coordinate one at $n=4$, so the class of configurations is strictly larger than the isometry orbit of the coordinate one.
- Claim 5 would be vacuous if $\binom n2<n$, which never happens for $n\ge3$, and it would be trivial if $\operatorname{rank}S\ge n$ held for cheap reasons. It does not: at the coordinate configuration $\operatorname{rank}S=n$ exactly, so the bound is attained and therefore sharp.
- Claim 7 would be trivial if $\ker S=0$ always. It is not, by the object above.
- **The genericity claim is a statement about a nonempty set of configurations.** §6.3 exhibits one, the icosahedral configuration with $\operatorname{rank}S=6$, so the set of configurations with no nonzero Ricci-flat weighting is nonempty at $n=4$, and by §6.2 it is the complement of $\{\det S=0\}$ in a $4$-dimensional moduli space. The three ranks $4$, $5$, $6$ are all realised at $n=4$: $4$ at the coordinate configuration, $5$ at given 4's rotated witness (verified independently in Appendix B), $6$ at the icosahedral one. The claim is neither vacuous nor trivial.

**One scope observation that the record should not lose.** $W_{\mathbb{CP}^2}$ of given 5 does **not** satisfy hypothesis 2. It is self-dual, so its eigenvalue $2c$ has a one-dimensional eigenspace inside $\Lambda^+$, spanned by a form $\omega$ with $\omega\wedge\omega\ne0$, and its kernel is the whole of $\Lambda^-$, again containing no basis of decomposable forms. So the programme's known local maximum lies outside the class this block describes, and no bound proved here can bear on it directly. That is a limitation of scope, not an error, but it decides what the block can be used for.

## 10. What would break each claim, and what I did to look

**The rank bound $\operatorname{rank}S\ge n$.** The falsifier is an orthonormal decomposable basis of $\Lambda^2\mathbb R^n$ whose projections span fewer than $n$ dimensions, equivalently one carrying an $\big(\binom n2-n+1\big)$-dimensional space of Ricci-flat weightings. Given the chain, such an object would also have to be a non-coordinate configuration with $\Xi=n^2(n-1)$, refuting given 10's equality case or L201, or a configuration where $\sum_\alpha\Pi_\alpha\ne(n-1)\mathrm{Id}$, refuting given 1. What I did: derived the $n=4$ dictionary of Appendix A, which parametrises **all** configurations at $n=4$, and checked the bound against it directly. Two eigenvalue facts hold there with no reference to L201: $\operatorname{tr}S=12$ and $S\mathbf 1=6\mathbf 1$. If $\operatorname{rank}S=3$ then the two remaining nonzero eigenvalues sum to $6$, so $\Xi\ge36+18=54>48$, contradicting the cap, and the same computation at $\operatorname{rank}S=2$ is worse. So no configuration of rank below $4$ exists at $n=4$, and §4.3 generalises the computation to every $n$. No falsifier, and the bound is now proved twice.

**The flexibility claim.** Two distinct falsifiers. First, for the upper bound $\dim\ker S\le\binom n2-n$: any configuration violating the rank bound, disposed of above. Second, for the genericity statement: a proof that $\operatorname{rank}S<\binom n2$ at **every** configuration, which would make the claim not merely unearned but false. That was the live risk, and it is not idle, because the map $\lambda\mapsto\sum\lambda_\alpha\Pi_\alpha$ at $n=4$ factors through the nine-dimensional space of trace-free symmetric matrices via $\Pi_\alpha=\tfrac12(\mathrm{Id}-X_\alpha)$ with $\sum_\alpha X_\alpha=0$, so the $X_\alpha$ span at most five dimensions and one is tempted to conclude a relation among the $\Pi_\alpha$. Appendix A shows the temptation is wrong: the relation $\sum_\alpha X_\alpha=0$ has coefficient sum $6\ne0$, so it is not a relation among the $\Pi_\alpha$, and independence of the six $\Pi_\alpha$ holds exactly when the $X_\alpha$ span five dimensions. The icosahedral configuration achieves that, so the falsifier does not exist at $n=4$. At $n\ge5$ I looked for neither a witness nor an obstruction, and the genericity claim stands unproven there.

**The consistency check.** The falsifier would be a configuration where $\sum_\gamma T_{\alpha\beta\gamma}\ne S_{\alpha\beta}$, which would refute given 8 or the orthonormality of the basis. I checked given 8 in the coordinate instance recorded in §7 and found it exact.

No searches, sweeps or numerical experiments were run at any point. Every object above is closed form: the coordinate configuration, given 4's witness, and six icosahedral axes.

## Appendix A. The $n=4$ dictionary, and the icosahedral configuration in closed form

Everything here is exact, and it is what §6, §9 and §10 rest on.

**$\Pi$ as a square.** With the brief's convention $\omega=u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$ is skew, so $\Pi_\omega=\omega\omega^{\mathsf T}=-\omega^2$. Hence $S_{\alpha\beta}=\operatorname{tr}(\omega_\alpha^2\omega_\beta^2)$ and $\operatorname{span}\{\Pi_\alpha\}=\operatorname{span}\{\omega_\alpha^2\}$.

**Chirality coordinates.** At $n=4$, $\Lambda^2=\Lambda^+\oplus\Lambda^-$ with the two summands commuting as matrices. Fix $J_1=e_1\wedge e_2+e_3\wedge e_4$, $J_2=e_1\wedge e_3+e_4\wedge e_2$, $J_3=e_1\wedge e_4+e_2\wedge e_3$ spanning $\Lambda^+$ and $J'_i$ the same with the second term negated, spanning $\Lambda^-$. Each satisfies $J^2=-\mathrm{Id}_4$, for instance $J_1^2=-\Pi_{12}-\Pi_{34}=-\mathrm{Id}$, and each has $\lVert J\rVert_{\Lambda^2}=\sqrt2$.

**Decomposable unit forms.** Write $\omega=\tfrac12(A+B)$ with $A=\sum_ia_iJ_i\in\Lambda^+$ and $B=\sum_ib_iJ'_i\in\Lambda^-$. Then $\lVert\omega\rVert^2=\tfrac14(2\lvert a\rvert^2+2\lvert b\rvert^2)$ and $\omega\wedge\omega\propto\lVert\omega^+\rVert^2-\lVert\omega^-\rVert^2$, so $\omega$ is a decomposable unit form exactly when $\lvert a\rvert=\lvert b\rvert=1$. In that case $A^2=B^2=-\mathrm{Id}$ and
$$\Pi_\omega=-\omega^2=-\tfrac14(A^2+2AB+B^2)=\tfrac12\big(\mathrm{Id}-AB\big).$$
Sanity check at $\omega=e_1\wedge e_2$, where $a=b=(1,0,0)$: $AB=J_1J'_1=(u+v)(u-v)=u^2-v^2=-\Pi_{12}+\Pi_{34}$ with $u=e_1\wedge e_2$, $v=e_3\wedge e_4$ and $uv=vu=0$, so $\tfrac12(\mathrm{Id}-AB)=\Pi_{12}$.

**The Gram entries.** Polarising $A^2=-\mathrm{Id}$ over unit $a$ gives $A_\alpha A_\beta=-(a_\alpha\cdot a_\beta)\mathrm{Id}+\tfrac12[A_\alpha,A_\beta]$ with the bracket in $\Lambda^+$, and likewise in $\Lambda^-$. Since $\Lambda^+\perp\Lambda^-$ gives $\operatorname{tr}(CD)=0$ for $C\in\Lambda^+$, $D\in\Lambda^-$, and both are trace-free,
$$\operatorname{tr}\big(A_\alpha B_\alpha A_\beta B_\beta\big)=\operatorname{tr}\big(A_\alpha A_\beta B_\alpha B_\beta\big)=4\,(a_\alpha\cdot a_\beta)(b_\alpha\cdot b_\beta),$$
and with $\operatorname{tr}(AB)=0$ this yields
$$S_{\alpha\beta}=\tfrac14\operatorname{tr}\big((\mathrm{Id}-A_\alpha B_\alpha)(\mathrm{Id}-A_\beta B_\beta)\big)=1+(a_\alpha\cdot a_\beta)(b_\alpha\cdot b_\beta).$$
At $\alpha=\beta$ this is $2$, as it must be.

**What orthonormality of the basis says.** $\langle\omega_\alpha,\omega_\beta\rangle=\tfrac12(a_\alpha\cdot a_\beta+b_\alpha\cdot b_\beta)$, so the six forms are orthonormal exactly when $G^a+G^b=2\,\mathrm{Id}_6$ for the Gram matrices of the $a$'s and $b$'s. Both are positive semidefinite of rank at most $3$, so $G^a$ has at least three eigenvalues equal to $2$ and at most three nonzero ones, forcing the spectrum $\{2,2,2,0,0,0\}$: that is, $G^a=2P$ for a rank-$3$ orthogonal projection $P$ of $\mathbb R^6$, equivalently $\sum_\alpha a_\alpha a_\alpha^{\mathsf T}=2\,\mathrm{Id}_3$, and likewise for the $b$'s, with $\operatorname{col}$-spaces orthogonal, whence $\sum_\alpha a_\alpha\otimes b_\alpha=0$ automatically. Conversely, any six unit vectors with $\sum_\alpha a_\alpha a_\alpha^{\mathsf T}=2\,\mathrm{Id}_3$ determine $b$'s with the required Gram $2\,\mathrm{Id}_6-G^a$, whose diagonal is $2-1=1$, so the $b$'s are automatically unit and the construction closes. **This is a bijection between configurations, modulo isometry, and unit tight frames of six vectors in $\mathbb R^3$, modulo $O(3)$ and per-vector sign.** Its dimension is $12-5-3=4$, the five being the independent equations in $\sum a_\alpha a_\alpha^{\mathsf T}=2\,\mathrm{Id}_3$, whose trace is automatic.

Substituting $b_\alpha\cdot b_\beta=-a_\alpha\cdot a_\beta$ into the Gram formula gives the working form used in §6.3,
$$S_{\alpha\beta}=1-(a_\alpha\cdot a_\beta)^2\quad(\alpha\ne\beta),\qquad S_{\alpha\alpha}=2 .$$
Two checks against the givens. Given 10's fixed total is automatic here: $\sum_{\alpha\ne\beta}(a_\alpha\cdot a_\beta)^2=\lVert G^a\rVert_F^2-6=\lVert 2P\rVert_F^2-6=4\cdot3-6=6$, so $\sum_{\alpha\ne\beta}S_{\alpha\beta}=30-6=24=n(n-1)(n-2)$. And the cap is a two-line consequence: the thirty off-diagonal entries lie in $[0,1]$ and sum to $24$, so their squares sum to at most $24$, giving $\Xi\le24+24=48$ with equality iff every $(a_\alpha\cdot a_\beta)^2\in\{0,1\}$, which is integrality.

**The coordinate configuration in the dictionary.** For the ordering $(e_1\wedge e_2,\ e_3\wedge e_4,\ e_1\wedge e_3,\ e_4\wedge e_2,\ e_1\wedge e_4,\ e_2\wedge e_3)$ the $a$'s are $(1,0,0),(1,0,0),(0,1,0),(0,1,0),(0,0,1),(0,0,1)$ and the $b$'s the same with alternating signs, so $G^a$ is block diagonal with three all-ones $2\times2$ blocks and $S=2\,\mathrm{Id}_6+\mathbf{1}\mathbf{1}^{\mathsf T}-\mathrm{Id}_3\otimes\mathbf{1}_2\mathbf{1}_2^{\mathsf T}$. On the three antisymmetric vectors of each block $S$ acts as $2\,\mathrm{Id}$, and on the symmetric ones as $2\,\mathbf{1}_3\mathbf{1}_3^{\mathsf T}$, giving the spectrum $6,2,2,2,0,0$ of §5 and rank $4$. Here $X_\alpha=A_\alpha B_\alpha$ runs over $\pm E_{11},\pm E_{22},\pm E_{33}$ in the $3\times3$ picture $X\leftrightarrow a\otimes b$, spanning only three dimensions, which is exactly why the coordinate configuration is the most degenerate one.

**The icosahedral configuration.** The six axes of a regular icosahedron, say the normalisations of $(0,\pm1,\varphi)$ and its cyclic images with $\varphi^2=\varphi+1$, satisfy $a_\alpha\cdot a_\beta=\pm\varphi/(2+\varphi)=\pm1/\sqrt5$ for $\alpha\ne\beta$, and their Gram matrix is a tight frame because $\sum a_\alpha a_\alpha^{\mathsf T}$ commutes with the icosahedral group's irreducible action on $\mathbb R^3$, hence equals $\tfrac63\,\mathrm{Id}=2\,\mathrm{Id}$. The dictionary then delivers a genuine orthonormal decomposable basis of $\Lambda^2\mathbb R^4$ with $S=\tfrac45\mathbf{1}\mathbf{1}^{\mathsf T}+\tfrac65\mathrm{Id}$, spectrum $6$ and $\tfrac65^{(\times5)}$, rank $6$, and hence with $\ker S=0$: no nonzero Ricci-flat weighting, and so no nonzero algebraic Weyl tensor diagonalised by it.

## Appendix B. Given 4's rotated witness, recomputed from the Gram matrix

An independent confirmation of given 4's "one-dimensional solution space", from this block's machinery rather than from the Ricci equations. The six projections are $\Pi_1=E_{11}+g_2g_2^{\mathsf T}$, $\Pi_2=E_{11}+g_3g_3^{\mathsf T}$, $\Pi_3=E_{11}+E_{44}$, $\Pi_4=E_{22}+E_{33}$, $\Pi_5=E_{22}+E_{44}$, $\Pi_6=E_{33}+E_{44}$. Their sum is $3\,\mathrm{Id}_4=(n-1)\mathrm{Id}$, using $g_2g_2^{\mathsf T}+g_3g_3^{\mathsf T}=E_{22}+E_{33}$, as §4.3 requires. The four diagonal ones have diagonals $(1,0,0,1),(0,1,1,0),(0,1,0,1),(0,0,1,1)$, of rank $4$, so they already span all diagonal matrices. $\Pi_1$ carries the off-diagonal part $\sin t\cos t\,(E_{23}+E_{32})$, nonzero because $\sin2t\ne0$, so it is outside that span, while $\Pi_1+\Pi_2$ is diagonal, so $\Pi_2$ is inside the span of the rest. Hence $\dim\operatorname{span}\{\Pi_\alpha\}=5$, so $\operatorname{rank}S=5$ and $\dim\ker S=1$, matching given 4 exactly. The kernel vector is given 4's: $\tfrac12(\Pi_1+\Pi_2)-\Pi_3-\Pi_4+\tfrac12(\Pi_5+\Pi_6)=0$ term by term on each $E_{ii}$. Non-integrality is visible too, since $\operatorname{tr}(\Pi_1\Pi_5)=\cos^2t\in(0,1)$, consistent with L201 and with the configuration being non-coordinate.

## Verdict

**The chain of [I74](../plan.md)'s first step holds, and two of its written justifications do not.**

- Claims 1, 2, 3, 4, 6, 7, 9 and 10 are confirmed, several of them with a shorter proof or a stronger conclusion than the record gives. The identification of Ricci-flatness with $\ker S$ is exactly right, and it makes $\ker S$ a linear slice of $\mathcal W_n$ rather than of the Ricci-flat symmetric operators, because first Bianchi is free once the eigenbasis is decomposable.
- The rank bound $\operatorname{rank}S\ge n$ is **true and incompletely argued**: as written it disposes only of $\operatorname{rank}S=n-1$. Either add the monotonicity line of §4.2, or replace the argument with §4.3, which splits off the universal eigenvalue $S\mathbf 1=2(n-1)\mathbf 1$, obtains $\operatorname{rank}S\ge n$ with no case analysis and no appeal to L201, and upgrades the attainment statement to $\operatorname{rank}S=n$ iff the configuration is coordinate.
- The genericity sentence is **refuted as stated and true at $n=4$ for another reason**. Its parameter count proves nothing, since the same count applies at the coordinate configuration, which has $\binom n2-n$ solutions. The criterion is linear independence of the $\Pi_\alpha$, and §6.3's icosahedral configuration supplies a closed-form point of the $4$-dimensional $n=4$ moduli where that holds, with $S=\tfrac45\mathbf{1}\mathbf{1}^{\mathsf T}+\tfrac65\mathrm{Id}$ of rank $6$. At $n\ge5$ the statement remains unproven.
- Two scope points the record should carry with the result. The hypothesis is that the **whole** eigenbasis, kernel included, consists of decomposable forms: on a partial configuration the equivalence with $\ker S$ survives but the rank bound has no proof. And $W_{\mathbb{CP}^2}$ fails the hypothesis, so nothing here bears on the programme's known local maximum.
