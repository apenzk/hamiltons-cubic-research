# Review r867 on the rank count at one removal, the two-removal chain, and the emptiness of $n=5$

*Reviewer r867, 2026-09-10. The brief was **cold**: I read the brief and nothing else of the record, and I opened no findings file, plan, review or notebook. **No numerical work beyond screening was done.** Every derivation below is by hand and every value is exact. One exact-rational screen (five-by-five matrices over $\mathbb Q$, integer triangle counts) was run to catch arithmetic slips in figures I was about to record, and it is reported as a screen and never as evidence. Log: [agent_logs/review-r867-rankcount.log](../agent_logs/review-r867-rankcount.log).*

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| C1 | $\sum_{\alpha\ne1}\Pi_\alpha=c\,\mathrm{Id}-\Pi_1$ has eigenvalues $c-1$ twice and $c$ else; positivity gives $c\ge1$; rank gives $a\ge\frac n2+1$ when $c>1$; admissible sizes $a=\frac n2$ or $a\ge\frac n2+1$ | **SOUND** |
| C1a | "a rank count that **prunes every dimension at once**" | **OVERSTATED**: it prunes exactly one value of $a$, and only at odd $n$. At even $n$ the disjunction is the positivity bound restated |
| C1b | "which is the rank bound again" (of $c\ge1$) | **LOOSE LABEL, HARMLESS**: $c\ge1$ is $2a\ge n$, a rank count on $\Theta$, and it is a different statement from the record's Gram-rank $\ge n$ |
| C2 | The complement obeys the same bound at constant $2(N-a)/n$ | **SOUND**, on the stated hypothesis that the full eigenbasis is decomposable |
| C3 | At $n=5$: $a\in\{4,5,6\}$, divisibility leaves $a=5$ coordinate-spannable, falsifier candidates $a\in\{4,6\}$, and those two are one case | **SOUND** |
| C4 | The explicit $a=3$ contradiction from $P_1,P_2$, the forced $\Pi_3$, and its failure of positive semidefiniteness; trace $1/5$ | **SOUND, AND STRONGER THAN CLAIMED**: the pair is unique up to $O(5)$, so the computation is a complete proof for $a=3$, and $(\Pi_3)_{55}=6/5>1$ kills it a second way |
| C5 | $\Pi_1+\Pi_2$ has eigenvalues $1\pm c,1,1,0$ for two $2$-planes in $\mathbb R^5$ with one right principal angle | **SOUND**, degenerate cases included |
| C6 | The $a=4$ chain: eigenvalue list, trace $4$, $c\le\frac35$, forced zero eigenvalue, $c=\frac35$ at every pair, row sum $\frac{27}{25}$ against $\frac{30}{25}$ | **SOUND, WITH A REDUNDANT SECOND KILL**: $\Pi_3+\Pi_4$ must carry eigenvalue $1$ twice and carries it none |
| C7 | $C_5$ is $\mathrm{srg}(5,2,0,1)$, its complement is another $5$-cycle, the $\pm1$ weighting is Ricci-flat and a two-eigenvalue diagonal critical point | **SOUND, WITH A MATERIAL OMISSION**: that critical point has $\theta=0$ exactly, so it is no competitor for the maximum |
| C8 | "at $n=5$ the only isotropic decomposable subspaces have $a=5$" | **FALSE AS LITERALLY STATED**: $a=10$ is isotropic with a decomposable basis, and $a\in\{7,8,9\}$ fall only to the complement half. The intended statement, quantified over the two-eigenvalue decomposable locus, is sound |
| C9 | "the falsifier hunt at $n=5$ is over for the non-divisible degrees" | **SOUND** |

**Summary in one line: both arguments hold, every step reproduced independently, and the two defects are in the prose around them. The headline "prunes every dimension" oversells a one-value gain that vanishes at even $n$, and the closing sentence drops the quantifier that makes it true, while the pentagon's critical point sits at $\theta=0$, which the block does not say.**

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$, the orthogonal projection onto $P=\mathrm{span}\{u,v\}$. **This holds for exactly this normalisation**: the $1/\sqrt2$ convention returns $\tfrac12\Pi_P$.
- $\omega$ is **decomposable** when $\omega=u\wedge v$, equivalently $\omega\wedge\omega=0$.
- $\mathcal W_n$ is the space of algebraic Weyl tensors. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. At $n=5$, $\theta_0(5)=2\sqrt6/5=0.979796$.
- $S_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$, the plain trace with no factor $\tfrac12$. $N=\binom n2$, $a=\dim E=\lvert A\rvert$, $c=2a/n$.

## Hypothesis inventory

What the two arguments actually consume, and where.

| | Hypothesis | Used in |
|---|---|---|
| H1 | $W$ has exactly two eigenvalues $\mu>0>\nu$ and no kernel, so $1\le a\le N-1$ | the enumeration's endpoints, and it alone excludes $a\in\{0,10\}$ at $n=5$ |
| H2 | $W$ lies on the decomposable locus: an orthonormal eigenbasis every member of which is decomposable. Both $E$ and $E^\perp$ inherit such a basis by partitioning it | every rank step, on both sides |
| H3 | Isotropy $\Theta(E)=c\,\mathrm{Id}$ at $c=2a/n$, equivalent to Ricci-flatness under H1 (given 14) | the whole of both arguments |
| H4 | $\Pi_\alpha$ is a rank-$2$ orthogonal projection: positive semidefinite, trace $2$, spectrum $\{1,1,0,\dots\}$ | items 1, 2, 3, 8, 9 |
| H5 | $\Lambda^2$-orthogonality of $\omega_\alpha,\omega_\beta$ leaves exactly one principal angle free, so $S_{\alpha\beta}=\cos^2\vartheta_1\in[0,1]$ (given 15) | items 8, 9, 10 |
| H6 | $\Theta(E)+\Theta(E^\perp)=(n-1)\mathrm{Id}$ (given 15) | item 4 |
| H7 | $n\mid 2a$ is necessary for coordinate-spannedness (given 16) | the reduction of $\{4,5,6\}$ to $\{4,6\}$ |

**H2 is the load-bearing hypothesis for the complement half.** For an isolated isotropic $E$ with a decomposable basis and no assumption on $E^\perp$, the argument bounds $a$ from below and says nothing from above. This is the source of defect C8.

**H3's own consistency, checked.** Under H1, Ricci-flatness reads $\mu\Theta(E)+\nu\Theta(E^\perp)=0$ (given 2), and with H6 this is $(\mu-\nu)\Theta(E)=-\nu(n-1)\mathrm{Id}$, so isotropy of $E$ and of $E^\perp$ hold together, with $\operatorname{tr}\Theta(E)=2a$ (given 1) fixing $c=2a/n$. Trace-freeness $a\mu+(N-a)\nu=0$ follows rather than being assumed, since $2N=n(n-1)$. Note that this half of given 14 needs no decomposability at all: **isotropy of the complement is free, and only the complement's rank count needs H2.**

## 1. The eigenvalues of $c\,\mathrm{Id}-\Pi_1$

$\Pi_1$ is the orthogonal projection of $\mathbb R^n$ onto a $2$-plane (H4), so its spectrum is $1$ with multiplicity $2$ and $0$ with multiplicity $n-2$, on the orthogonal splitting $P_1\oplus P_1^\perp$. That splitting diagonalises $c\,\mathrm{Id}-\Pi_1$ too, with $c-1$ on $P_1$ and $c$ on $P_1^\perp$. So the spectrum is $c-1$ twice and $c$ with multiplicity $n-2$. **Verified.** Trace check: $nc-2=2a-2=2(a-1)$, which is $\operatorname{tr}\sum_{\alpha\ne1}\Pi_\alpha$, as given 1 requires.

The identity $\sum_{\alpha\ne1}\Pi_\alpha=c\,\mathrm{Id}-\Pi_1$ is H3 minus one term, and $\Theta(E)=\sum_{\alpha\in A}\Pi_\alpha$ holds because $\omega_\alpha\omega_\alpha^{\mathsf T}=\Pi_\alpha$ at the brief's normalisation. **At the $1/\sqrt2$ convention it would read $\tfrac12\Pi_\alpha$ and every constant in both arguments would move.** The brief's convention is the one used throughout, consistently.

## 2. The positivity step

A sum of orthogonal projections is positive semidefinite, so $c\,\mathrm{Id}-\Pi_1\succeq0$, so its least eigenvalue $\min(c-1,c)=c-1$ (for $n\ge3$, where both eigenvalues occur) is $\ge0$. Hence $c\ge1$, that is $2a\ge n$. **Verified.**

At $c=1$ exactly, meaning $n$ even and $a=n/2$: the identity becomes $\sum_{\alpha\ne1}\Pi_\alpha=\mathrm{Id}-\Pi_1$, of rank $n-2=2(a-1)$, which saturates the rank bound of item 3 and yields no contradiction. So the case split "$c=1$, or $c>1$" is exhaustive and correct, and it is exhaustive because $c=2a/n$ takes the value $1$ only at $a=n/2$.

**On the label C1b.** The block calls $c\ge1$ "the rank bound again". The honest reading is that $c\ge1$ is exactly $\operatorname{rank}(c\,\mathrm{Id})=n\le\sum_{\alpha\in A}\operatorname{rank}\Pi_\alpha=2a$, a rank count on $\Theta$ itself. That is a different statement from given 17, which bounds the rank of the *Gram matrix* of a full orthonormal decomposable basis below by $n$. The two are not the same object and the identification should not be made in a sentence a reader may cite.

## 3. The rank step, and the disjunction

$\sum_{\alpha\ne1}\Pi_\alpha$ is a sum of $a-1$ matrices of rank $2$, so its rank is at most $2(a-1)$. **Verified.** When $c>1$ both $c-1$ and $c$ are strictly positive, so $c\,\mathrm{Id}-\Pi_1$ is nonsingular, of rank $n$. **Verified.** Hence $n\le2(a-1)$ and $a\ge\frac n2+1$. **Concluded, not refuted.**

The disjunction "$a=\frac n2$ exactly or $a\ge\frac n2+1$" is correct. **Its content, however, depends on the parity of $n$**, and this is defect C1a:

- **$n$ even.** For integer $a$, "$a=\frac n2$ or $a\ge\frac n2+1$" is precisely "$a\ge\frac n2$", which is the positivity bound of item 2. The rank step adds nothing.
- **$n$ odd.** $c=1$ is unreachable, so $c>1$ always, and $a\ge\frac n2+1=\frac{n+2}2$ forces $a\ge\frac{n+3}2$. Positivity alone had given $a\ge\frac{n+1}2$. **The gain is exactly one value of $a$, namely $a=\frac{n+1}2=\lceil n/2\rceil$**, and with the complement one more, $N-a=\lceil n/2\rceil$.

So "prunes every dimension at once" is not what the count does. Read as "the count is uniform in $n$" it is defensible. Read as a claim about how many dimensions $a$ it removes, it is wrong by a wide margin: two values at odd $n$, none at even $n$. The sentence should say which.

## 4. The complement

By H6, $\Theta(E^\perp)=(n-1)\mathrm{Id}-\tfrac{2a}n\mathrm{Id}=\tfrac{n(n-1)-2a}n\mathrm{Id}=\tfrac{2(N-a)}n\mathrm{Id}$ using $2N=n(n-1)$. **The constant is right.**

$E^\perp$ carries an orthonormal decomposable basis by H2, being spanned by the complementary block of the eigenbasis, so items 1 to 3 apply verbatim with $a$ replaced by $N-a$: positivity gives $2(N-a)\ge n$, and $2(N-a)/n>1$ gives $N-a\ge\frac n2+1$. **The same bound is available.** Withdraw H2 and this half of the argument goes with it.

## 5. The $n=5$ enumeration

$n=5$, $N=10$, $c=2a/5$, and $c=1$ is unreachable since $5\nmid 2a$ for integer $a$. So positivity gives $c>1$ at every admissible $a$, and item 3 gives $a\ge3.5$, hence $a\ge4$. The complement gives $10-a\ge4$, hence $a\le6$. **$a\in\{4,5,6\}$ is right.**

- **$a=3$ excluded.** $c=6/5>1$, so item 3 applies and $3<3.5$. **Yes.** Also $a\in\{1,2\}$ excluded, already by positivity ($c=2/5$ and $4/5$).
- **$a=7$ excluded.** $N-a=3$ on the complement side, same computation. **Yes.** Likewise $a=8$ ($N-a=2$) and $a=9$ ($N-a=1$) by positivity on the complement.
- $a=0$ and $a=10$ are excluded by H1, not by the count. See §12.

Divisibility (H7): $5\mid 2a$ is $5\mid a$, so of $\{4,5,6\}$ only $a=5$ can be coordinate-spanned. **The falsifier candidates are $a\in\{4,6\}$.** Correct, and this is the collapse of the earlier list $\{3,4,6,7\}$: $3$ and $7$ die by §3 and §4, $4$ and $6$ survive to §9.

The forced Gram data quoted in the block is right. For $\alpha\in A$, $\sum_{\beta\in A}S_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Theta(E))=\tfrac{2a}n\operatorname{tr}\Pi_\alpha=\tfrac{4a}n$, which is $16/5$ at $a=4$. Subtracting $S_{\alpha\alpha}=2$ leaves $6/5$ across the three off-diagonal entries of each row. For $\beta\in B$ the same trace against $\Theta(E)$ gives $\sum_{\alpha\in A}S_{\beta\alpha}=\tfrac{4a}n=16/5$ as well. Both **verified**.

## 6. The swap

Two readings, and they differ in a way worth stating.

**As a question about configurations, the swap is exact and needs no operator at all.** The property "$E$ has an orthonormal decomposable basis, $\Theta(E)$ is isotropic, and $E^\perp$ has one too" is symmetric in $E\leftrightarrow E^\perp$, since isotropy of one gives isotropy of the other by H6 (§4) with the constant $2(N-a)/n$. So emptiness at $a=4$ transfers to $a=6$ verbatim, by running §9 on the four-dimensional block, whichever side of the splitting it sits on. **This is how the $a=6$ case is actually closed, and it is airtight.**

**As a question about operators, negation does the work but moves $\theta$.** $\mathcal W_n$'s defining conditions (symmetry, first Bianchi, Ricci-flatness, trace-freeness) are all linear in $W$, so $-W\in\mathcal W_n$. $-W$ has the same eigenspaces, hence the same eigenbasis, so **the decomposable locus is preserved**, and its positive eigenspace is $E^\perp$ with eigenvalue $-\nu>0$, of dimension $N-a$. For criticality: $W^\#$ is quadratic in $W$, so $(-W)^\#=W^\#$, and $(-W)^2=W^2$, giving
$$Q(-W)=W^2+W^\#=\theta(W)\,W=\bigl(-\theta(W)\bigr)(-W),$$
so $-W$ is critical exactly when $W$ is. **Criticality is preserved.** And $P(-W)=\langle -W,Q(W)\rangle=-P(W)$ with $\lVert -W\rVert=\lVert W\rVert$, so $\theta(-W)=-\theta(W)$: **the swap negates $\theta$.**

The consequence the block does not spell out: of the two operators $\pm W$ carried by one configuration, exactly one has $\theta>0$ (or both have $\theta=0$). So "$a=4$ and $a=6$ are the same case" is true of the configuration and false of the pair (configuration, sign of $\theta$). Since the argument proves the configuration does not exist, nothing is lost here. **The collapse to a single question is legitimate.**

## 7. The explicit $a=3$ contradiction

**The value $1/5$ is right.** At $n=5$, $a=3$ the row sum is $4a/n=12/5$, so the two off-diagonal entries in each row of the $3\times3$ Gram matrix sum to $12/5-2=2/5$. The three equations $S_{12}+S_{13}=S_{12}+S_{23}=S_{13}+S_{23}=2/5$ force $S_{12}=S_{13}=S_{23}=1/5$. **Verified.**

**The pair meets both conditions.** With $P_1=\mathrm{span}\{e_1,e_2\}$ and $f_1=(e_1+2e_3)/\sqrt5$, $P_2=\mathrm{span}\{f_1,e_4\}$:
$$S_{12}=\operatorname{tr}(\Pi_1\Pi_2)=f_1^{\mathsf T}\Pi_1f_1+e_4^{\mathsf T}\Pi_1e_4=\tfrac15+0=\tfrac15 .$$
Orthogonality in $\Lambda^2$: $\langle e_1\wedge e_2,\ f_1\wedge e_4\rangle=\det\begin{pmatrix}\langle e_1,f_1\rangle&\langle e_1,e_4\rangle\\ \langle e_2,f_1\rangle&\langle e_2,e_4\rangle\end{pmatrix}=\det\begin{pmatrix}1/\sqrt5&0\\0&0\end{pmatrix}=0$. **Both verified**, and the two principal angles are $\arccos(1/\sqrt5)$ and $\pi/2$, consistent with H5.

**The third matrix.** With $D_i=e_ie_i^{\mathsf T}$, $\Pi_1=D_1+D_2$ and $\Pi_2=\tfrac15D_1+\tfrac45D_3+\tfrac25(e_1e_3^{\mathsf T}+e_3e_1^{\mathsf T})+D_4$, so $\Pi_3=\tfrac65\mathrm{Id}-\Pi_1-\Pi_2$ has diagonal $\bigl(\tfrac65-1-\tfrac15,\ \tfrac65-1,\ \tfrac65-\tfrac45,\ \tfrac65-1,\ \tfrac65\bigr)=\bigl(0,\tfrac15,\tfrac25,\tfrac15,\tfrac65\bigr)$ and single off-diagonal pair $-\tfrac25$ at $(1,3)$:
$$\Pi_3=\tfrac15D_2+\tfrac25D_3+\tfrac15D_4+\tfrac65D_5-\tfrac25(e_1e_3^{\mathsf T}+e_3e_1^{\mathsf T}).$$
**Exactly as quoted**, and $\operatorname{tr}\Pi_3=2$ as it must be.

**The failure.** A positive semidefinite matrix with $M_{ii}=0$ has its whole $i$th row zero, since $\lvert M_{ij}\rvert\le\sqrt{M_{ii}M_{jj}}$. Here $(\Pi_3)_{11}=0$ while $(\Pi_3)_{13}=-2/5$. **Not positive semidefinite, so not a projection.** Contradiction.

**Two additions.**

1. **The contradiction is cheaper still.** $(\Pi_3)_{55}=6/5>1$, and any orthogonal projection has $\Pi_{55}=\lVert\Pi e_5\rVert^2\le1$. So the object fails before positivity is invoked. The record's route is correct. This one is shorter and should be the one written down.
2. **The computation is fully general, which the record does not claim but is entitled to.** Two pairs of $2$-planes in $\mathbb R^5$ with the same principal angles are carried to one another by an element of $O(5)$ (CS decomposition), and §7's first paragraph forces the angles of every pair inside $A$ to be $\bigl(\arccos(1/\sqrt5),\pi/2\bigr)$: the second is right by H5, the first by $S_{12}=1/5$. Since $\Pi_3$ is then determined by $\Pi_1,\Pi_2$ through isotropy, **the explicit contradiction proves the $a=3$ case outright and is not merely a sample point.** The block's framing ("first found by explicit contradiction … the rank count then explained the failure and generalised it") undersells it: the explicit route is already general, and the rank count's value is uniformity in $n$, not generality at $n=5$.

## 8. The eigenvalues of $\Pi_1+\Pi_2$

This is the step the brief flags, and it survives.

Take principal vectors: orthonormal $u_1,u_2$ spanning $P_1$ and $v_1,v_2$ spanning $P_2$ with $\langle u_i,v_j\rangle=\delta_{ij}\cos\vartheta_i$, and $\vartheta_2=\pi/2$ by H5. Assume first $0<c<1$ at $c=\cos\vartheta_1$, and write $v_1=cu_1+sw$ with $s=\sin\vartheta_1\ne0$ and $w$ a unit vector orthogonal to $P_1$. From $\langle v_2,u_1\rangle=\langle v_2,u_2\rangle=0$ and $\langle v_2,v_1\rangle=0$ we get $s\langle v_2,w\rangle=0$, so $v_2\perp w$: hence $u_1,u_2,w,v_2$ are orthonormal, and in $\mathbb R^5$ one further unit $z$ completes the frame.

Now $\Pi_1+\Pi_2$ acts blockwise on $\mathrm{span}\{u_1,w\}\oplus\mathrm{span}\{u_2\}\oplus\mathrm{span}\{v_2\}\oplus\mathrm{span}\{z\}$:

- $u_2$: $\Pi_1u_2=u_2$ and $\Pi_2u_2=0$, since $\langle u_2,v_1\rangle=\langle u_2,v_2\rangle=0$. **Eigenvalue $1$.**
- $v_2$: $\Pi_2v_2=v_2$ and $\Pi_1v_2=0$. **Eigenvalue $1$.**
- $z$: annihilated by both. **Eigenvalue $0$.**
- $\mathrm{span}\{u_1,w\}$: $\Pi_1u_1=u_1$, $\Pi_1w=0$, $\Pi_2u_1=c\,v_1$, $\Pi_2w=s\,v_1$, so in the basis $(u_1,w)$ the block is $\begin{pmatrix}1+c^2&cs\\ cs&s^2\end{pmatrix}$, of trace $2$ and determinant $(1+c^2)s^2-c^2s^2=s^2$. Its eigenvalues solve $\lambda^2-2\lambda+s^2=0$, giving $\lambda=1\pm\sqrt{1-s^2}=1\pm c$.

So the spectrum is $\{1+c,\ 1-c,\ 1,\ 1,\ 0\}$ with $c=\sqrt{S_{12}}\in[0,1]$, the sign fixed by $\vartheta_1\in[0,\pi/2]$. **Verified**, trace $4=2+2$ and $\operatorname{tr}\bigl((\Pi_1+\Pi_2)^2\bigr)=4+2S_{12}$ both consistent.

**Which degeneracies move the multiplicities, the formula holding as a multiset throughout:**

| case | geometry | spectrum |
|---|---|---|
| $0<c<1$ | $\dim(P_1+P_2)=4$, $P_1\cap P_2=0$ | $1+c,1-c,1,1,0$, four distinct values |
| $c=0$, i.e. $S_{12}=0$ | mutually orthogonal planes, $\Pi_1+\Pi_2$ a rank-$4$ projection | $1,1,1,1,0$: the $1$ has multiplicity $4$ |
| $c=1$, i.e. $S_{12}=1$ | $P_1\cap P_2$ a line, $\dim(P_1+P_2)=3$ | $2,1,1,0,0$: the $0$ has multiplicity $2$ |

The $c=1$ row needs its own two lines, since $w$ is undefined there: $v_1=u_1$, so $\Pi_1+\Pi_2=2u_1u_1^{\mathsf T}+u_2u_2^{\mathsf T}+v_2v_2^{\mathsf T}$, spectrum $\{2,1,1,0,0\}$, which is the multiset $\{1+c,1-c,1,1,0\}$ at $c=1$. **The record's parenthetical about the degenerate case is right.** $P_1=P_2$ cannot occur, as it would make $\omega_2=\pm\omega_1$, contradicting orthonormality.

## 9. The $a=4$ contradiction chain

$a=4$, $n=5$, isotropy constant $8/5$. Subtracting §8's spectrum from $8/5$ on the same eigenframe:
$$\tfrac85\mathrm{Id}-\Pi_1-\Pi_2\ \text{ has spectrum }\ \bigl\{\tfrac35-c,\ \tfrac35+c,\ \tfrac35,\ \tfrac35,\ \tfrac85\bigr\}.$$
**Verified**, and the trace is $\tfrac{3+3+3+3+8}5=4$, which is $5\cdot\tfrac85-4$ and equals $\operatorname{tr}(\Pi_3+\Pi_4)=2+2$. **Verified.**

By isotropy that matrix is $\Pi_3+\Pi_4$.

- **Positivity.** $\Pi_3+\Pi_4\succeq0$, and the only possibly negative eigenvalue is $\tfrac35-c$, so $c\le\tfrac35$. **Verified.**
- **Rank.** $\operatorname{rank}(\Pi_3+\Pi_4)\le4<5$, so the matrix is singular and some eigenvalue vanishes. Of the five, $\tfrac35+c\ge\tfrac35>0$, $\tfrac35>0$ twice, and $\tfrac85>0$: **only $\tfrac35-c$ can supply the zero.** Verified. Hence $c=\tfrac35$ and $S_{12}=c^2=\tfrac9{25}$.
- **Row sum.** Three off-diagonal entries at $\tfrac9{25}$ give $\tfrac{27}{25}$, against the required $\tfrac65=\tfrac{30}{25}$ from §5. **Contradiction, verified.** Equivalently $\operatorname{tr}(\Theta(E)^2)$ would be $8+12\cdot\tfrac9{25}=\tfrac{308}{25}$ while isotropy demands $5\cdot\bigl(\tfrac85\bigr)^2=\tfrac{320}{25}$.

**A second, independent kill, which the record should record because it makes the chain robust to any slip in the row-sum bookkeeping.** By H5 applied to the orthogonal pair $\omega_3,\omega_4$, the matrix $\Pi_3+\Pi_4$ must itself have a spectrum of §8's shape, so **it must carry the eigenvalue $1$ with multiplicity at least two** (two in the generic case, four at $c'=0$, two at $c'=1$). At $c=\tfrac35$ the spectrum computed above is $\bigl\{0,\tfrac35,\tfrac35,\tfrac65,\tfrac85\bigr\}$, which contains no $1$ at all. Contradiction, without appeal to the row sum.

**So $a=4$ is empty at $n=5$, twice over, and by §6 so is $a=6$.**

## 10. Degeneracies in that chain

- **Planes sharing a line.** $c=1$ gives $\tfrac35-c=-\tfrac25<0$, excluded by positivity. Covered.
- **Planes spanning fewer than four dimensions.** In $\mathbb R^5$ two distinct $2$-planes span $3$ or $4$ dimensions, and $3$ happens exactly when they share a line, so this is the previous row. Covered.
- **Mutually orthogonal planes.** $c=0$ satisfies positivity but violates the forced zero, since then the spectrum is $\bigl\{\tfrac35,\tfrac35,\tfrac35,\tfrac35,\tfrac85\bigr\}$, nonsingular, of rank $5>4$. Excluded by the rank step. Covered.
- **Unequal $S_{\alpha\beta}$ across pairs, the brief's sharpest question.** **The argument forces every pair separately, and therefore all of them.** The derivation of $c=\tfrac35$ used only two facts about the labels: that $\{1,2\}$ is a pair inside $A$, and that $A\setminus\{1,2\}$ has exactly two elements so that the leftover has rank at most $4$. Both are label-symmetric at $a=4$, so relabelling gives $S_{\alpha\beta}=\tfrac9{25}$ at each of the six pairs, with no assumption that the six agree in advance. **The uniformity is a conclusion, not a hypothesis, and the chain is sound on this point.**
- **Specificity to $a=4$.** The two-removal step needs $2(a-2)<n$. At $n=5$ that is $a<4.5$, so it bites at $a=4$ and at nothing larger: at $a=5$ the leftover has rank bound $6$ and at $a=6$ rank bound $8$, and no zero eigenvalue is forced. **The $a=6$ case is closed only through §6**, by running the chain on the four-dimensional block $B$, and the block's sentence "these two are the same case" is carrying real weight rather than decorating the result.

## 11. The pentagon

Index the coordinate basis of $\Lambda^2\mathbb R^5$ by the edges of $K_5$, $\omega_{ij}=e_i\wedge e_j$, and take $E$ spanned by the five edges of the $5$-cycle $C=\{12,23,34,45,51\}$.

- **$\Theta(E)=2\,\mathrm{Id}$.** $\sum_{ij\in C}\Pi_{ij}=\sum_{ij\in C}(D_i+D_j)=\sum_i\deg_C(i)D_i=2\,\mathrm{Id}$, since $C$ is $2$-regular, and $2=2a/n$ at $a=n=5$. **Isotropic.** The degree $2a/n=2$ is the divisible one, matching H7.
- **$\mathrm{srg}(5,2,0,1)$.** $C_5$ has $5$ vertices, degree $2$; adjacent vertices have no common neighbour, since $C_5$ is triangle-free, so $\lambda=0$; non-adjacent vertices have exactly one, e.g. $N(1)\cap N(3)=\{2\}$, so $\mu=1$. **Verified.**
- **The complement is another $5$-cycle.** The five remaining edges $\{13,24,35,41,52\}$ form a $2$-regular graph on five vertices, and the only such simple graph is $C_5$. **Verified**, and $\Theta(E^\perp)=2\,\mathrm{Id}$ with $2+2=4=n-1$, as H6 requires.
- **Ricci-flat.** Weights $+1$ on $C$ and $-1$ on the pentagram give $\sum_\mu\lambda_\mu\Theta(E_\mu)=2\,\mathrm{Id}-2\,\mathrm{Id}=0$ (given 2). Trace-free: $5-5=0$. First Bianchi: $\mathrm{Alt}(W)=\tfrac16\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ (given 6), every basis form being decomposable. **So $W\in\mathcal W_5$, with exactly two eigenvalues $\pm1$ and no kernel.** Verified.
- **A critical point.** In the coordinate edge basis, $c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle$ is nonzero exactly on the three edges of a triangle, with $[\,L_{12},L_{23}]=L_{13}$ at $L_{ab}=E_{ab}-E_{ba}$, so $T_{\alpha\beta\gamma}\in\{0,1\}$ is the triangle indicator. Given 12's relation (B), $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, fixes the normalisation as $(A^\#)_{kk}=\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\sum_{\text{triangles }\ni k}\lambda_f\lambda_g$, and I checked (B) itself on this weighting at both classes as a consistency test on that normalisation: at $k=12$ the three triangles give $(1-1)+(-1-1)+(-1+1)=-2=-2\lambda_{12}$, and at $k=13$ they give $(1+1)+(1-1)+(-1+1)=2=-2\lambda_{13}$. Off the diagonal $W^\#$ vanishes here, since a pair of edges sharing a vertex determines the third edge of its triangle uniquely, so $c_{\alpha\beta\gamma}c_{\alpha\beta\delta}=0$ whenever $\gamma\ne\delta$: **for a coordinate configuration, $W$ diagonal makes $W^\#$ diagonal.** Then for $k\in C$, over the three other vertices the pairs split as $\lambda_{\mathrm{srg}}=0$ inside $C$, one pair outside $C$, two mixed, giving $(W^\#)_{kk}=0+1-2=-1$. For $k$ in the pentagram, $\mu=1$ inside $C$, none outside, two mixed, giving $1+0-2=-1$. So $W^\#=-\mathrm{Id}$, and since $W^2=\mathrm{Id}$,
$$Q(W)=W^2+W^\#=0=0\cdot W .$$
**It is a critical point, and it is a genuine two-eigenvalue diagonal one.** Verified.

**The material omission.** That critical point has $P(W)=\langle W,Q(W)\rangle=0$ and hence
$$\boxed{\theta=0}$$
exactly, against $\theta_0(5)=2\sqrt6/5=0.979796$ and $\sqrt{3/2}=1.224745$. The pentagon is therefore a critical point of no competitive value whatever, and the sentence "$C_5$ is strongly regular … **so** it is a genuine two-eigenvalue diagonal critical point" invites the opposite impression. Two further points about that "so":

1. **Strong regularity is not by itself the reason.** What criticality needs is that $(W^\#)_{kk}+\lambda_k^2=\kappa\lambda_k$ hold on each class. Strong regularity delivers that $(W^\#)_{kk}$ is constant on each class, which is necessary. The two resulting equations in the single unknown $\kappa$ then have to be compatible, and here they are only because $\lvert C\rvert=\lvert C^{\,c}\rvert$ forces $\lambda=\pm1$ and $\lambda^2=1$ on both classes. At an $\mathrm{srg}$ with unequal classes the compatibility is a further condition. **The implication as written is too fast, even though its conclusion is true here.**
2. The pentagon confirms that $a=5$ is non-empty, which is what the block needs it for, and "inside the granted half" is right: the configuration is coordinate.

## 12. Vacuity and scope

**Nothing is vacuous.** Each excluded case has a non-empty hypothesis set before isotropy is imposed:

- $a=3$ at $n=5$: orthonormal decomposable triples exist, e.g. $e_1\wedge e_2,\ e_3\wedge e_4,\ e_1\wedge e_3$. It is isotropy that fails.
- $a=4$: likewise, e.g. any four coordinate forms. Isotropy fails.
- $a=n/2$ at even $n$, the case the disjunction retains: realised, e.g. $e_1\wedge e_2,\ e_3\wedge e_4$ at $n=4$, whose $\Theta$ is $\mathrm{Id}$, with $E^\perp$ spanned by the four remaining coordinate forms and $\Theta(E^\perp)=2\,\mathrm{Id}=(n-1)\mathrm{Id}-\mathrm{Id}$. So §3's retained branch is about real objects.
- $C_5$ at $a=5$: exhibited in §11.

**Defect C8, the one substantive error, is in the closing sentence.** "So at $n=5$ the only isotropic decomposable subspaces have $a=5$" is false as literally stated, on two counts.

1. **$a=10$ is a counterexample.** $E=\Lambda^2\mathbb R^5$ has the coordinate orthonormal decomposable basis and $\Theta=(n-1)\mathrm{Id}=4\,\mathrm{Id}=\tfrac{2\cdot10}5\mathrm{Id}$, so it is isotropic. Its exclusion comes from H1, the requirement of a negative eigenvalue, and not from either rank count. The same holds for $a=0$.
2. **$a\in\{7,8,9\}$ are excluded only through H2 on the complement.** The one-removal count applied to $E$ alone gives a lower bound on $a$ and never an upper one: at $a=9$ it reads $5\le16$. Drop the assumption that $E^\perp$ has a decomposable orthonormal basis, and $a\in\{7,8,9,10\}$ are untouched by everything in these two blocks.

The repair is a quantifier, not new mathematics: *at $n=5$, if $W$ has exactly two eigenvalues $\mu>0>\nu$ and an orthonormal eigenbasis of decomposable forms, then $\dim E=5$.* That statement is what the argument proves and it is sound.

**Two further scope limits the blocks do not state, and a reader will need them.**

- **Everything here is inside the two-eigenvalue case.** Falsifiers with three or more distinct eigenvalues, or with a kernel, are untouched by both arguments, since H3's equivalence to Ricci-flatness is a two-eigenvalue statement (given 14). The brief's framing that these arguments "empty every falsifier candidate at $n=5$" is true only within that class.
- **$a=5$ is not settled and the block says so.** "What remains at $n=5$ is only whether the divisible degree admits a NON-coordinate configuration" is accurate, and "the falsifier hunt at $n=5$ is therefore over for the non-divisible degrees" is accurate. **C9 stands.**

## 13. What would break each argument, and what I did to look

| Argument | The object that would break it | What I did |
|---|---|---|
| One removal (§1 to §3) | A member of the basis that is not decomposable. Then $\omega\omega^{\mathsf T}$ has rank $4$ in $\Lambda^2\mathbb R^5$, positivity survives but the rank bound becomes $4(a-1)$ and $a\ge\frac n4+1$ is all that follows, which at $n=5$ excludes nothing above $a=2$ | Confirmed that H2 rules this out inside the decomposable locus, and traced which of the two steps each hypothesis feeds: positivity needs only that $\Pi_\alpha\succeq0$, the rank step needs $\operatorname{rank}\Pi_\alpha=2$ |
| One removal | The normalisation. At the $1/\sqrt2$ convention $\omega\omega^{\mathsf T}=\tfrac12\Pi$, the isotropy constant halves, and the least eigenvalue becomes $c-\tfrac12$, giving $a\ge n/4$ and killing the enumeration | Checked the brief's convention is the one in force at every constant used, including $c=2a/n$ and $S_{\alpha\alpha}=2$, and that $\operatorname{tr}\Theta(E)=2a$ holds throughout |
| One removal | A parity case where the disjunction hides a gap. It does not hide one, but at even $n$ it hides that there is no gain | Split §3 by parity and computed the gain: two values of $a$ at odd $n$, none at even $n$ |
| Complement (§4) | An isotropic $E$ whose orthogonal complement has no decomposable orthonormal basis. Its $a$ would be bounded below only | Recorded as defect C8, and separated the free part (isotropy of $E^\perp$, which needs no decomposability) from the part that needs H2 (the rank count on $E^\perp$) |
| $a=3$ (§7) | A pair $P_1,P_2$ with $S_{12}=1/5$ and one right principal angle that is *not* $O(5)$-equivalent to the record's. None exists, by the CS decomposition | Derived the uniqueness up to $O(5)$ and thereby upgraded the explicit computation to a complete proof, then re-derived $\Pi_3$ entry by entry and found a second failure at $(\Pi_3)_{55}=6/5>1$ |
| $a=4$ (§8 to §10) | An isotropic four-dimensional $E$ with the six $S_{\alpha\beta}$ not all equal. Ruled out, since the chain forces each pair on its own | Ran the relabelling explicitly, then looked for a spectral escape and found instead a second contradiction: $\Pi_3+\Pi_4$ must carry the eigenvalue $1$ twice and carries it none |
| $a=4$ | A degeneracy that voids §8's normal form: shared line, or planes spanning three dimensions. Both are $c=1$, where positivity gives $\tfrac35-1<0$ | Derived the $c=1$ spectrum $\{2,1,1,0,0\}$ separately, since the normal form's $w$ is undefined there, and confirmed the multiset formula still holds |
| $a=6$ (§6) | A failure of the swap. There is none for the configuration question, which is sign-blind | Verified $-W\in\mathcal W_n$, that eigenspaces and hence the decomposable locus are preserved, that $Q(-W)=Q(W)$ makes criticality symmetric, and that $\theta\to-\theta$, then noted that the cleanest route runs §9 on the four-dimensional block directly and needs no operator |
| The pentagon (§11) | A non-coordinate isotropic configuration at $a=5$, divisibility being necessary and not sufficient | **Not looked for. It needs computation, which this footing withholds**, and it is exactly what the block itself leaves open |

## Verdict

**Both arguments are correct, and I reproduced every step independently rather than checking it.** The one-removal rank count, the complement's version of it, the $n=5$ enumeration to $a\in\{4,5,6\}$, the divisibility reduction to $\{4,6\}$, the collapse of those two by the swap, the explicit $a=3$ contradiction, the spectrum $\{1\pm c,1,1,0\}$ with its degeneracies, and the two-removal chain that empties $a=4$: all hold, all values exact.

**Three things should change in the prose.**

1. **C8, and it is the only real error.** "At $n=5$ the only isotropic decomposable subspaces have $a=5$" is false as written, since $a=10$ is isotropic with a decomposable basis and $a\in\{7,8,9\}$ fall only through the complement's decomposability. Restate it over the two-eigenvalue decomposable locus, where it is exactly right.
2. **C7's omission.** The pentagon's critical point sits at $\theta=0$, computed from $W^2=\mathrm{Id}$ and $W^\#=-\mathrm{Id}$, so it can never be a falsifier. Say so where it is introduced, and weaken the "so" from strong regularity, which supplies the constancy of $(W^\#)_{kk}$ on each class but not the compatibility of the two criticality equations.
3. **C1a.** "Prunes every dimension at once" describes a count that in fact removes $a=\lceil n/2\rceil$ and $N-\lceil n/2\rceil$ at odd $n$ and nothing at even $n$. State the parity.

**Two things are stronger than the record claims and should be banked.** The explicit $a=3$ computation is a complete proof, not an illustration, because the pair of planes is unique up to $O(5)$ once $S_{12}=1/5$ and the right angle are forced. And the $a=4$ chain has a second, independent kill: $\Pi_3+\Pi_4$ is obliged by the same normal form to carry the eigenvalue $1$ with multiplicity at least two, and the forced spectrum $\bigl\{0,\tfrac35,\tfrac35,\tfrac65,\tfrac85\bigr\}$ carries none, so the row-sum step is a convenience rather than a load-bearing link.

**Standing scope, to be carried in the statement and not only in a reviewer's report: this closes the non-divisible degrees at $n=5$ for two-eigenvalue operators on the decomposable locus. Three-or-more-eigenvalue falsifiers, kernels, and the non-coordinate question at the divisible degree $a=5$ are all untouched.**
