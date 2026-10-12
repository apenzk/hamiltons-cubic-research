# Review r869: the moment reduction of $\theta$, and the class system at three eigenvalues

*Reviewer r869, independent and adversarial. The brief was **cold**: the only files read were the brief itself and this report's own directory listing, so nothing in the findings, the plan, the other reviews or the attempts notebook informed a single line below. **No numerical work was done beyond screening.** Every value in this report is exact: rationals, surds and symbolic identities, no floating point in any claim. Three screens were run to guard against my own arithmetic, each on an object I constructed for the purpose, each reported as a screen and never as evidence for a positive claim. The derivations stand on the algebra written out here. Log: [review-r869-moments.log](../agent_logs/review-r869-moments.log).*

## Claim table

| # | Claim, as the record states it | Verdict |
|---|---|---|
| 1 | $\theta=\sum_ia_i\mu_i^3+\tfrac12m_3$ | **CONFIRMED** |
| 2 | $\sum_{jk}t_{ijk}=2(n-2)a_i$, hence $m_0=2(n-2)N$ and $m_1=0$ | **CONFIRMED** |
| 3 | $\sum_{jk}\mu_jt_{ijk}=-2a_i\mu_i$, hence $m_2=-2$ | **CONFIRMED** |
| 4 | Class weights $\tfrac13,\tfrac13,1$ for $m_1,m_2,m_3$ | **CONFIRMED**, all three class types |
| 5 | Marginal in class form, $\tfrac13\sum_Sm_i(S)v_S=2(n-2)a_i$ | **CONFIRMED** |
| 6 | Relation (B) in class form, factor $\tfrac16$ | **CONFIRMED as an equation** |
| 7 | "its inner factor being the average of the remaining two values" | **WRONG**, it is the **sum**, a factor 2 in the gloss |
| 8 | Caps $\sum_kt_{ijk}\le a_ia_j$ and $\le a_i(a_i-1)$ | **WRONG off the decomposable locus**, a factor 2, and $W_{\mathbb{CP}^2}$ violates every nontrivial instance |
| 9 | "in class form caps the classes containing the pair $\{i,j\}$" | **INCOMPLETE**, the functional is $\sum_kv_{\{i,j,k\}}/n(\{i,j,k\})$ and the weights are not 1 |
| 10 | Exactly four classes carry positive $\sigma_3$, namely $111,122,123,133$ | **CONFIRMED** |
| 11 | "no negative class is free of it except the three all-negative ones" | **WRONG**, there are **four** such classes: $222,223,233,333$ |
| 12 | "the feasible polytope is four-dimensional before the caps" | **WRONG**, the six equalities have rank **5**, so the affine set is **five**-dimensional |
| 13 | At two values, four types and the equalities collapse to three | **CONFIRMED** (four equalities, rank three), and it is the same single dependency |
| 14 | Boundedness from $m_0$ and the $i=1$ marginal alone, without the caps | **CONFIRMED**, with the caps buying sharpness only |
| 15 | Summing (C) against $\mu_i$ returns $m_3=2\theta-2\sum_ia_i\mu_i^3$ | **CONFIRMED as an identity** |
| 16 | "Relation (C) must NOT be added" | **OVERSTATED**, one of its three level-set equalities is redundant and two are not |
| 17 | The two-value case reproduces the established bound of given 16 | **CONFIRMED**, formula and both endpoints of the range |
| 18 | The mirror case "runs the same way with the roles of the signs exchanged" | **WRONG**, six positive classes, the structural fact fails, and it is the minimisation problem |
| 19 | The three-value sign analysis covers the cases | **INCOMPLETE**, the $(+,0,-)$ stratum is missing and holds $n=4$'s local maximum |

## Summary in one line

The reduction is sound and every combinatorial factor in it is right, including the two the brief flagged as the historical failure mode. What is wrong is the fence around it, where the caps are a factor of two too tight off the decomposable locus and exclude $W_{\mathbb{CP}^2}$, the polytope is five-dimensional rather than four, and the sign bookkeeping miscounts the all-negative classes and mis-describes the mirror case.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=\Pi_P$.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

## Hypothesis inventory

What every claim below is entitled to lean on, named once so the reader can see where each derivation's weight lands.

| Tag | Content | Used in |
|---|---|---|
| H1 | $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ with $c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle$ is nonnegative, totally symmetric and hollow, over an orthonormal eigenbasis (given 12, given 14) | everywhere |
| H2 | $(W^\#)_{kk}=\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$, the sum over **ordered** pairs (given 14) | 1 |
| H3 | The operator norm is $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2$, so the inner product on symmetric operators is the plain trace (given 13) | 1, 3 |
| H4 | The marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ at every index, Lemma [L153](../findings/bounds.md) (given 15) | 2, 5, 8, 10, 14 |
| H5 | Relation (B), $\sum_{\beta\gamma}\lambda_\beta T_{\alpha\beta\gamma}=-2\lambda_\alpha$ at every index, the diagonal of $W\#I=-W$ (given 12, given 15) | 3, 5, 9, 10 |
| H6 | Relation (C), $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=2\lambda_\alpha(\theta-\lambda_\alpha)$ at a critical point (given 12, given 15) | 9 |
| H7 | The pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$ in general and $\le1$ on the decomposable locus (given 15), with $\sum_\gamma T_{\alpha\beta\gamma}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$ for orthogonal decomposable unit forms (given 8) | 6 |
| H8 | Trace-freeness $\sum_ia_i\mu_i=0$ and unit norm $\sum_ia_i\mu_i^2=1$ (given 17) | 2, 3, 8, 10 |
| H9 | $W_{\mathbb{CP}^2}$ at $n=4$ is critical and a local maximum at $\theta=\sqrt{3/2}$ exactly, self-dual with blocks $c\,\mathrm{diag}(2,-1,-1)$ and $0$ (given 5), with $(W^\#)|_{\Lambda^\pm}=2\mathcal A^2-\operatorname{tr}(\mathcal A^2)\mathrm{Id}_3$ (given 3) | 0, 1, 3, 6, 11 |
| H10 | The two-value bound $(n-1)\sqrt{s/(N(N-s))}$ on $\tfrac n2\le s\le\tfrac{n(n-2)}4$, maximum $\theta_0(n)$ at the endpoint (given 16) | 10 |

Notation, fixed for the rest of the report. The eigenbasis splits into level sets $L_1,\dots,L_L$ of **distinct** eigenvalues $\mu_i$ with $a_i=\lvert L_i\rvert$ and $\sum_ia_i=N=\binom n2$. Then

$$t_{ijk}=\sum_{\alpha\in L_i}\sum_{\beta\in L_j}\sum_{\gamma\in L_k}T_{\alpha\beta\gamma},$$

which is symmetric in $(i,j,k)$ because $T$ is, and nonnegative. For a size-three multiset $S$ from the index set, $n(S)=3!/\prod_im_i(S)!$ is the number of ordered triples of class $S$, $\tau_S$ is the common value of $t_{ijk}$ on them, and $v_S=n(S)\tau_S$ is, as the record defines it, the total of $T$ over the ordered triples of that class. $\sigma_r(S)$ is the $r$-th elementary symmetric function of the three values **listed with multiplicity**, and $\pi_i(S)$ is the product of the two values other than one chosen copy of $\mu_i$.

## 0. The witness used throughout, exhibited in closed form

Everything below that is checked against an object is checked against this one, and it is written out here so the reader can redo any of it by hand.

At $n=4$ take $f_1,f_2,f_3$ and $g_1,g_2,g_3$ with $f_i=(\varphi_{1,i+1}\pm\varphi_{\cdot\cdot})/\sqrt2$ in the usual pairing, explicitly

$$f_1=\tfrac{\varphi_{12}+\varphi_{34}}{\sqrt2},\quad f_2=\tfrac{\varphi_{13}+\varphi_{42}}{\sqrt2},\quad f_3=\tfrac{\varphi_{14}+\varphi_{23}}{\sqrt2},$$

and the $g_i$ with the minus signs. These six are orthonormal for $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$. With $L_{ab}=E_{ab}-E_{ba}=-\varphi_{ab}$ and $[L_{ab},L_{cd}]=\delta_{bc}L_{ad}+\delta_{ad}L_{bc}-\delta_{ac}L_{bd}-\delta_{bd}L_{ac}$,

$$[L_{12}+L_{34},\,L_{13}+L_{42}]=-L_{23}-L_{14}-L_{14}-L_{23}=-2(L_{14}+L_{23}),$$

so $[f_1,f_2]=\sqrt2\,f_3$, and $[\Lambda^+,\Lambda^-]=0$. Hence the only nonvanishing $T$ are $T=2$ on the six orderings of $(f_1,f_2,f_3)$ and $T=2$ on the six orderings of $(g_1,g_2,g_3)$. The marginal is $2\cdot2=4=2(n-2)$ at every index, which is H4 verified rather than assumed.

$W_{\mathbb{CP}^2}=c\,\mathrm{diag}(2,-1,-1)$ on $\{f_i\}$ and $0$ on $\{g_i\}$, with $6c^2=1$ so $c=1/\sqrt6$. Its spectrum has **three** level sets:

$$\mu_1=2c\ (a_1=1),\qquad \mu_2=-c\ (a_2=2),\qquad \mu_3=0\ (a_3=3),\qquad a_1+a_2+a_3=6=N.$$

Trace-free: $2c-2c+0=0$. Unit norm: $4c^2+2c^2=1$. Its class variables are $v_{122}=6\cdot2=12$, $v_{333}=6\cdot2=12$, and every other $v_S=0$.

## 1. The objective, and what the $\tfrac12$ rests on

By H3 the pairing on symmetric operators is the plain trace, so

$$\langle W,W^2\rangle=\operatorname{tr}(W^3)=\sum_\alpha\lambda_\alpha^3=\sum_ia_i\mu_i^3,$$

$$\langle W,W^\#\rangle=\operatorname{tr}(WW^\#)=\sum_k\lambda_k(W^\#)_{kk}\overset{\text{H2}}{=}\tfrac12\sum_{k\beta\gamma}\lambda_k\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\tfrac12m_3 .$$

At unit norm $\theta=P(W)$, so $\theta=\sum_ia_i\mu_i^3+\tfrac12m_3$. **CONFIRMED.**

The $\tfrac12$ rests on exactly three things, and the third is the trap. First, that the operator pairing carries no factor of its own (H3, which given 13 fixes by way of $\lVert W\rVert^2=\sum\lambda^2$). Second, H2's own $\tfrac12$. Third, and this is where a factor of two would enter unnoticed, that the sum in H2 runs over **ordered** pairs $(\beta,\gamma)$: over unordered pairs the same content would read $(W^\#)_{kk}=\sum_{\beta<\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$ with no prefactor, and a reader who imported that form into $m_3$, which is defined as a sum over all ordered triples, would double the cubic term.

The witness pins it rather than merely tolerating it. From section 0, $\sum_\alpha\lambda_\alpha^3=c^3(8-1-1)=6c^3=1/\sqrt6$, and

$$m_3=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=6\cdot2\cdot(2c)(-c)(-c)=24c^3=\frac{24}{6\sqrt6}=\frac{4}{\sqrt6},$$

the $g$-triple contributing nothing because $\mu_3=0$. Then $\theta=1/\sqrt6+2/\sqrt6=3/\sqrt6=\sqrt{3/2}$, which is H9 to the last digit. With a $1$ in place of the $\tfrac12$ the same witness would give $5/\sqrt6=2.041$, contradicting given 5. Independently, H9's own route agrees: $\mathcal A=c\,\mathrm{diag}(2,-1,-1)$ gives $\mathcal A^2=c^2\mathrm{diag}(4,1,1)$ and $\operatorname{tr}(\mathcal A^2)=1$, so $W^\#|_{\Lambda^+}=\mathrm{diag}(\tfrac13,-\tfrac23,-\tfrac23)$, $W^\#|_{\Lambda^-}=0$, and $\operatorname{tr}(WW^\#)=2c=2/\sqrt6=\tfrac12m_3$.

## 2. $m_0$ and $m_1$

Summing H4 over $\alpha\in L_i$ gives $\sum_{jk}t_{ijk}=\sum_{\alpha\in L_i}\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)a_i$, which is the record's level-set marginal. **CONFIRMED.** Summing over $i$,

$$m_0=\sum_{ijk}t_{ijk}=2(n-2)\sum_ia_i=2(n-2)N=n(n-1)(n-2),$$

and weighting by $\mu_i$,

$$m_1=\sum_{ijk}\mu_it_{ijk}=2(n-2)\sum_ia_i\mu_i=2(n-2)\operatorname{tr}W=0 .$$

$m_1=0$ needs **trace-freeness of $W$ as an operator on $\Lambda^2$ and nothing more.** H4 is a statement about the structure constants of $\mathfrak{so}(n)$ in an orthonormal basis and is indifferent to $W$, so no decomposability, no Ricci-flatness and no criticality enters. Two remarks worth recording.

- $m_1=0$ is not an independent constraint on the $v_S$. It is implied by the three level-set marginals contracted against $\mu_i$, which is the first half of the rank deficiency found in section 12.
- $m_0$ cross-checks against given 10 through given 8: on the decomposable locus $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$, so $m_0=\sum_{\alpha\ne\beta}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=n(n-1)(n-2)$, the fixed total given 10 states. Two independently established facts land on the same integer, which is the kind of agreement a miscounted factor of two does not survive.

Witness: $m_0=v_{122}+v_{333}=24=2(n-2)N=2\cdot2\cdot6$, and $m_1=\tfrac13[\sigma_1(122)\cdot12+\sigma_1(333)\cdot12]=\tfrac13[0+0]=0$ since $\sigma_1(122)=\mu_1+2\mu_2=2c-2c=0$.

## 3. $m_2=-2$

Multiply H5 by $\lambda_\alpha$ and sum:

$$m_2=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}=\sum_\alpha\lambda_\alpha\Big(\sum_{\beta\gamma}\lambda_\beta T_{\alpha\beta\gamma}\Big)=-2\sum_\alpha\lambda_\alpha^2=-2\lVert W\rVert^2=-2 .$$

At the level of level sets the same computation gives $\sum_{jk}\mu_jt_{ijk}=-2a_i\mu_i$, so both of the record's statements hold. **CONFIRMED.**

**Unit norm is the only extra input past H5**, in the sense that no further property of $W$ is used. It is worth being explicit that H5 is not free: it is the diagonal of $W\#I=-W$, which is where Ricci-flatness sits, so $m_2=-2$ carries Ricci-flatness through H5 even though the step above adds only $\lVert W\rVert=1$. Witness: $\sigma_2(122)=2\mu_1\mu_2+\mu_2^2=-4c^2+c^2=-3c^2$, so $m_2=\tfrac13(-3c^2)(12)=-12c^2=-2$.

## 4. The class factors, derived from the count of ordered triples

The device that settles all of them at once. Fix a class $S$ and label the three entries of the multiset as distinguishable copies $e_1,e_2,e_3$ with values $\mathrm{val}(e)$. There are $3!=6$ labelled permutations, and each distinct ordered triple of class $S$ arises from exactly $6/n(S)=\prod_im_i(S)!$ of them. Since $t_{ijk}=\tau_S$ on all of them, any contraction can be computed over the six labelled permutations and then divided by $6/n(S)$.

**$m_1$.** Over labelled permutations the slot-one value sums to $2\sigma_1(S)$, because each labelled copy occupies slot one in two of the six. So the sum over distinct orderings is $\tfrac{n(S)}{6}\cdot2\sigma_1(S)=\tfrac{n(S)}{3}\sigma_1(S)$, and

$$m_1=\sum_S\tfrac{n(S)}{3}\sigma_1(S)\tau_S=\tfrac13\sum_S\sigma_1(S)v_S .$$

**$m_2$.** Over labelled permutations the product of the slot-one and slot-two values sums to $2\sigma_2(S)$, because each ordered pair of distinct labelled copies occupies the first two slots exactly once and each unordered pair therefore contributes twice. So the distinct-ordering sum is $\tfrac{n(S)}{6}\cdot2\sigma_2(S)=\tfrac{n(S)}{3}\sigma_2(S)$, and $m_2=\tfrac13\sum_S\sigma_2(S)v_S$.

**$m_3$.** Every ordering of the class has the same product $\sigma_3(S)$, so the distinct-ordering sum is $n(S)\sigma_3(S)\tau_S=\sigma_3(S)v_S$, and $m_3=\sum_S\sigma_3(S)v_S$ with no factor.

All three claimed weights, $\tfrac13$, $\tfrac13$ and $1$, are **CONFIRMED.** The brief asks for the three class types separately, and they are worth seeing because the $\tfrac13$ arrives by a different route in each.

| $S$ | $n(S)$ | $v_S$ | $m_1$ contribution, direct | $\tfrac13\sigma_1v_S$ | $m_2$ contribution, direct | $\tfrac13\sigma_2v_S$ | $m_3$ contribution, direct | $\sigma_3v_S$ |
|---|---|---|---|---|---|---|---|---|
| $111$, all equal | $1$ | $\tau$ | $\mu_1\tau$ | $\tfrac13(3\mu_1)\tau=\mu_1\tau$ | $\mu_1^2\tau$ | $\tfrac13(3\mu_1^2)\tau=\mu_1^2\tau$ | $\mu_1^3\tau$ | $\mu_1^3\tau$ |
| $112$, two equal | $3$ | $3\tau$ | $(2\mu_1+\mu_2)\tau$ | $\tfrac13(2\mu_1+\mu_2)3\tau$ | $(\mu_1^2+2\mu_1\mu_2)\tau$ | $\tfrac13(\mu_1^2+2\mu_1\mu_2)3\tau$ | $3\mu_1^2\mu_2\tau$ | $\mu_1^2\mu_2\cdot3\tau$ |
| $123$, all distinct | $6$ | $6\tau$ | $2\sigma_1\tau$ | $\tfrac13\sigma_1\cdot6\tau$ | $2\sigma_2\tau$ | $\tfrac13\sigma_2\cdot6\tau$ | $6\sigma_3\tau$ | $\sigma_3\cdot6\tau$ |

Two conditions on which the correctness of these weights depends, neither of them stated in the record's block, and both of which a later reader can get wrong.

- **$v_S$ must be the total over ORDERED triples, as the block indeed defines it.** Reading $v_S$ as the common value $\tau_S$ instead multiplies each class's weight by $n(S)$, so the $\tfrac13$ becomes $\tfrac13n(S)$ and $m_0=\sum_Sv_S$ fails at once. The block's own $m_0$ identity is the guard here, and it is consistent.
- **$\sigma_r(S)$ must be taken of the three values WITH multiplicity**, so $\sigma_1(112)=2\mu_1+\mu_2$, $\sigma_2(111)=3\mu_1^2$ and $\sigma_3(112)=\mu_1^2\mu_2$. The block's phrase "the $r$-th elementary symmetric function of the three values" is that reading, and the table above fails on any other.

## 5. The six equalities in class form

**The marginal.** $\sum_{jk}t_{ijk}$ is the total of $T$ over ordered triples whose first slot lies in $L_i$. Among the $n(S)$ distinct orderings of a class, the fraction with first index $i$ is $m_i(S)/3$, since slot one takes each labelled copy equally often, giving $n(S)m_i(S)/3$ orderings, which is $2$ for $(S,i)=(112,1)$, $1$ for $(112,2)$, $2$ for $(123,1)$ and $1$ for $(111,1)$, each checkable by listing. Hence

$$\sum_{jk}t_{ijk}=\sum_S\frac{n(S)m_i(S)}{3}\tau_S=\frac13\sum_Sm_i(S)v_S=2(n-2)a_i .$$

**CONFIRMED.**

**Relation (B).** Now weight the second slot. Over the six labelled permutations, the pairs (slot one, slot two) run over all ordered pairs of distinct labelled copies exactly once each, so

$$\sum_{\text{labelled}}\mathbb 1[\mathrm{val}(\text{slot }1)=\mu_i]\cdot\mathrm{val}(\text{slot }2)=\sum_{e:\,\mathrm{val}(e)=\mu_i}\ \sum_{f\ne e}\mathrm{val}(f)=m_i(S)\big(\sigma_1(S)-\mu_i\big),$$

and dividing by $6/n(S)$,

$$\sum_{jk}\mu_jt_{ijk}=\sum_S\frac{n(S)}{6}m_i(S)\big(\sigma_1(S)-\mu_i\big)\tau_S=\frac16\sum_Sm_i(S)\big(\sigma_1(S)-\mu_i\big)v_S=-2a_i\mu_i .$$

**The factor $\tfrac16$ is CONFIRMED.** The verbal gloss is not. **$\sigma_1(S)-\mu_i$ is the SUM of the remaining two values, not their average**, and the two readings differ by exactly the factor of two the brief warned about: with the average as the inner factor the prefactor would have to be $\tfrac13$, since $\tfrac16m_i(\sigma_1-\mu_i)=\tfrac13m_i\cdot\tfrac{\sigma_1-\mu_i}{2}$. As written, equation and gloss cannot both be right, and it is the equation that is right. The witness separates them numerically at every index:

| $i$ | $\tfrac16\sum_Sm_i(S)(\sigma_1(S)-\mu_i)v_S$ | $-2a_i\mu_i$ | with the "average" reading |
|---|---|---|---|
| $1$ | $\tfrac16\cdot1\cdot(0-2c)\cdot12=-4c$ | $-4c$ | $-2c$, wrong |
| $2$ | $\tfrac16\cdot2\cdot(0+c)\cdot12=4c$ | $4c$ | $2c$, wrong |
| $3$ | $0$ | $0$ | $0$, undecided |

**A by-product the record will need, and which is missing.** The same device applied to two weighted slots gives relation (C) in class form. Over labelled permutations, each copy $e$ of value $\mu_i$ occupies slot one in two permutations, both contributing the product of the other two values, so the labelled sum is $2m_i(S)\pi_i(S)$ and

$$\sum_{jk}\mu_j\mu_kt_{ijk}=\frac13\sum_Sm_i(S)\pi_i(S)v_S=2a_i\mu_i(\theta-\mu_i).$$

The prefactor here is $\tfrac13$, not $\tfrac16$: the two weighted slots restore a factor two relative to (B). On the witness at $i=2$: $\tfrac13\cdot2\cdot(\mu_1\mu_2)\cdot12=8\mu_1\mu_2=-16c^2=-\tfrac83$, against $2a_2\mu_2(\theta-\mu_2)=-4c(\theta+c)=-2-\tfrac23=-\tfrac83$.

**Internal consistency, which is the cheapest audit of all five weights at once.** Contract each family against $\mu_i$ and sum over $i$, using $\sum_im_i(S)\mu_i=\sigma_1(S)$, $\sum_{e}\mathrm{val}(e)(\sigma_1-\mathrm{val}(e))=\sigma_1^2-\sum\mathrm{val}^2=2\sigma_2$ and $\sum_em_i\mathrm{val}(e)\pi(e)=3\sigma_3$:

- marginals against $1$ return $m_0=\sum_Sv_S$, and against $\mu_i$ return $m_1=\tfrac13\sum\sigma_1v_S$;
- (B) against $\mu_i$ returns $\tfrac16\cdot2\sum\sigma_2v_S=\tfrac13\sum\sigma_2v_S=m_2$;
- (C) against $\mu_i$ returns $\tfrac13\cdot3\sum\sigma_3v_S=\sum\sigma_3v_S=m_3$.

Each of the three moment weights is recovered from the corresponding equality's weight, so a factor error in any one of the five would show up as a mismatch here. There is none.

## 6. The caps, and the configuration they exclude

Translate the pair cap. For $i\ne j$,

$$\sum_kt_{ijk}=\sum_{\alpha\in L_i}\sum_{\beta\in L_j}\ \sum_\gamma T_{\alpha\beta\gamma}\le \kappa\,a_ia_j,$$

there being $a_ia_j$ ordered pairs in $L_i\times L_j$ and $L_i\cap L_j=\emptyset$, where $\kappa$ is H7's per-pair bound. For $i=j$ the pairs with $\alpha=\beta$ contribute nothing, because hollowness gives $T_{\alpha\alpha\gamma}=c_{\alpha\alpha\gamma}^2=0$ and indeed $\sum_\gamma T_{\alpha\alpha\gamma}=\lVert[\omega_\alpha,\omega_\alpha]\rVert^2=0$, leaving $a_i(a_i-1)$ ordered pairs and $\sum_kt_{iik}\le\kappa\,a_i(a_i-1)$.

**So hollowness enters in exactly one place, the diagonal, and it enters correctly: the $-1$ in $a_i(a_i-1)$ is right.** What is wrong is $\kappa$. H7 gives $\kappa=2$ in general and $\kappa=1$ only on the decomposable locus, so **the record's caps are the decomposable-locus caps stated without their hypothesis, and are a factor of two too tight for a general Weyl tensor.**

This is not a hypothetical. The witness of section 0 is a certified critical point and local maximum of the programme by H9, its basis is not decomposable ($f_1=(\varphi_{12}+\varphi_{34})/\sqrt2$ has $f_1\wedge f_1\ne0$), and it attains $\sum_\gamma T_{\alpha\beta\gamma}=2$ on every pair inside a chirality. Its pair marginals against both readings of the cap:

| $(i,j)$ | $\sum_kt_{ijk}$ at $W_{\mathbb{CP}^2}$ | record's cap | correct general cap |
|---|---|---|---|
| $(1,2)$ | $\tfrac13v_{112}+\tfrac13v_{122}+\tfrac16v_{123}=4$ | $a_1a_2=2$, **violated** | $2a_1a_2=4$, tight |
| $(2,2)$ | $\tfrac13v_{122}+v_{222}+\tfrac13v_{223}=4$ | $a_2(a_2-1)=2$, **violated** | $2a_2(a_2-1)=4$, tight |
| $(3,3)$ | $v_{333}+\tfrac13v_{133}+\tfrac13v_{233}=12$ | $a_3(a_3-1)=6$, **violated** | $2a_3(a_3-1)=12$, tight |
| $(1,1)$, $(1,3)$, $(2,3)$ | $0$ | satisfied | satisfied |

**Consequence for the programme, stated plainly.** A vertex enumeration over the three-value polytope with the caps as written would be an enumeration over a region that does not contain $W_{\mathbb{CP}^2}$'s class vector, at the very spectrum type $(a_1,a_2,a_3)=(1,2,3)$ where $W_{\mathbb{CP}^2}$ lives. Any upper bound it returned would bound a strictly smaller set than $\mathcal W_4$, so it would not be a theorem about $\theta$. And if the returned value fell below $\sqrt{3/2}$ it would contradict given 5 outright. The repair is one character in three places, $\kappa=2$, together with the sentence that $\kappa=1$ is available only after decomposability is imposed.

**Two further corrections to the cap paragraph.**

- "in class form caps the classes containing the pair $\{i,j\}$" understates what is needed. The functional is $\sum_kt_{ijk}=\sum_kv_{\{i,j,k\}}/n(\{i,j,k\})$, whose weights are $\tfrac13$ or $\tfrac16$ or $1$ according to the class, as the table above shows. Written out at three levels: $\tfrac13v_{112}+\tfrac13v_{122}+\tfrac16v_{123}\le2a_1a_2$ off the diagonal, and $v_{111}+\tfrac13v_{112}+\tfrac13v_{113}\le2a_1(a_1-1)$ on it. An enumeration that used weight $1$ throughout would be solving a different problem.
- **Hollowness gives a free tightening the caps do not deliver: $v_S=0$ whenever $m_i(S)>a_i$ for some $i$**, since a class needs $m_i(S)$ pairwise distinct indices from $L_i$. At $a_1=1$ this kills $v_{111},v_{112},v_{113}$, and at $a_1=2$ it kills $v_{111}$, which no pair cap does. The witness satisfies it, with $v_{122}$ the only surviving class meeting $L_1$. This should be added to the constraint list before any vertex enumeration, since it removes variables outright.

## 7. The signs at $\mu_1=p>0>\mu_2=-q\ge\mu_3=-r$

Here $q,r>0$ and $r\ge q$. Taking $\sigma_3$ with multiplicity:

| $S$ | $\sigma_3(S)$ | sign | contains index $1$ |
|---|---|---|---|
| $111$ | $p^3$ | $+$ | yes |
| $112$ | $-p^2q$ | $-$ | yes |
| $113$ | $-p^2r$ | $-$ | yes |
| $122$ | $pq^2$ | $+$ | yes |
| $123$ | $pqr$ | $+$ | yes |
| $133$ | $pr^2$ | $+$ | yes |
| $222$ | $-q^3$ | $-$ | no |
| $223$ | $-q^2r$ | $-$ | no |
| $233$ | $-qr^2$ | $-$ | no |
| $333$ | $-r^3$ | $-$ | no |

**Exactly four classes carry positive $\sigma_3$, and they are the four the record names: $111$, $122$, $123$, $133$. CONFIRMED**, with the values as stated. The structural claim that every positive class contains the index of the positive eigenvalue is also **confirmed**, and it is the fact section 8 turns into boundedness.

**The count of all-negative classes is wrong.** The record says "except the three all-negative ones". The classes drawn entirely from $\{2,3\}$ are the size-three multisets of a two-element set, of which there are $\binom{2+3-1}{3}=4$, namely $222,223,233,333$. The table shows all four. The claim is otherwise right: the only negative classes meeting $L_1$ are $112$ and $113$.

## 8. Boundedness without the caps

**The claim is true.** Every class with $\sigma_3>0$ has $m_1(S)\ge1$, by section 7's last column, so nonnegativity of the $v_S$ plus the $i=1$ marginal alone gives

$$\sum_{S:\,\sigma_3(S)>0}v_S\ \le\ \sum_Sm_1(S)v_S\ =\ 3\cdot2(n-2)a_1\ =\ 6(n-2)a_1,$$

and therefore, discarding the negative classes,

$$m_3=\sum_S\sigma_3(S)v_S\le\Big(\max_{S:\,\sigma_3>0}\sigma_3(S)\Big)\sum_{S:\,\sigma_3>0}v_S\le 6(n-2)a_1\cdot p\max(p^2,r^2),$$

using $r\ge q$ so that $\max(q^2,qr,r^2)=r^2$. Unit norm bounds the eigenvalues, since $a_i\mu_i^2\le\sum_ja_j\mu_j^2=1$ and $a_i\ge1$ give $\lvert\mu_i\rvert\le1$, so $m_3\le6(n-2)a_1\le6(n-2)N$ and $\theta\le\sum_ia_i\mu_i^3+3(n-2)N$, finite. The same argument through $m_0$ gives $m_3\le m_0\max\sigma_3^+=2(n-2)N\max\sigma_3^+$, so either constraint suffices, and the $i=1$ marginal is the sharper of the two whenever $a_1<N/3$. **CONFIRMED.**

**What the caps buy is sharpness, not finiteness.** The bound above is crude by orders: at $n=4$ it permits $m_3$ of order $6(n-2)a_1=12a_1$ where the witness has $m_3=4/\sqrt6\approx1.63$. So the caps, corrected as in section 6, are what stand between the programme and a bound far above $\theta_0(n)$, and the block's sentence should be read as an existence remark rather than as a reason not to impose them.

**One caveat on the argument's reach.** In the mirror case no single marginal does the job, because $\sigma_3>0$ there for the classes with an even number of copies of the negative index, and among these $111$ misses $L_2$ while $222$ misses $L_1$. The sum of the $i=1$ and $i=2$ marginals covers all of them, giving $\sum_{\sigma_3>0}v_S\le6(n-2)(a_1+a_2)$, so boundedness survives, by a different constraint than the one the record names.

## 9. The circularity warning

Multiply H6 by $\lambda_\alpha$ and sum over the eigenbasis:

$$\sum_\alpha\lambda_\alpha\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=m_3,\qquad \sum_\alpha2\lambda_\alpha^2(\theta-\lambda_\alpha)=2\theta\lVert W\rVert^2-2\sum_\alpha\lambda_\alpha^3=2\theta-2\sum_ia_i\mu_i^3,$$

so $m_3=2\theta-2\sum_ia_i\mu_i^3$, which is section 1's objective rearranged. **CONFIRMED**: that particular contraction of (C) is the objective identity and carries no information about the $v_S$ beyond it. Unit norm is used, and in class form the contraction is the last bullet of section 5.

**But the prohibition as stated is too broad, and it forecloses a legitimate strengthening.** At three level sets (C) is *three* equalities, and only the one-dimensional combination $\sum_i\mu_i(\cdot)$ is the tautology. The quotient carries two independent constraints. They involve $\theta$, so they cannot enter a plain linear programme in the $v_S$ with $\theta$ as the objective, but they enter a $\theta$-parametric feasibility formulation without any circularity: for each fixed $t$, ask whether the system consisting of the marginals, (B), (C) with $\theta:=t$, the corrected caps, the support conditions and $m_3=2t-2\sum_ia_i\mu_i^3$ has a nonnegative solution, and take the supremum of feasible $t$. That supremum is a valid upper bound on $\theta$ over critical points of the given spectrum type, and it is at least as sharp as the cap-free enumeration because it imposes strictly more. The correct statement is therefore: *the contraction of (C) against $\mu_i$ is the objective and must not be double-counted as a constraint, and the remaining two combinations are new and usable, parametrically.*

## 10. The two-value consistency check

Two level sets: $\mu$ with multiplicity $a$ and $\nu$ with multiplicity $b=N-a$, four classes $111,112,122,222$ with variables $x=v_{111}$, $y=v_{112}$, $z=v_{122}$, $w=v_{222}$, all nonnegative. Write $C=2(n-2)$. Trace-freeness gives $a\mu+b\nu=0$, so $\mu=kb$, $\nu=-ka$, and unit norm gives $k^2ab(a+b)=k^2abN=1$, that is $k=(Nab)^{-1/2}$, which is given 16's ratio $\mu:\nu=(N-a):(-a)$.

Sections 5's two families give four equalities:

$$3x+2y+z=3Ca,\qquad y+2z+3w=3Cb,$$
$$3\mu x+(\mu+\nu)y+\nu z=-6a\mu,\qquad \mu y+(\mu+\nu)z+3\nu w=-6b\nu .$$

**The rank is three.** Contracting the two marginals against $(\mu,\nu)$ and adding the two (B) rows produce the same functional of $(x,y,z,w)$, namely $\tfrac16[6\mu x+(4\mu+2\nu)y+(2\mu+4\nu)z+6\nu w]$, and the same right-hand side $0$, because $a\mu+b\nu=0$. So one dependency, rank three, and the solution set is a segment once $v\ge0$ is imposed. This is the record's "the six per-level-set equalities collapse to three", right in substance, with the pedantic note that at two values there are four such equalities rather than six.

Eliminating with $\mu=kb$, $\nu=-ka$ gives, after dividing the (B) row by $k$ and substituting $z=3Ca-3x-2y$,

$$3Nx+Ny=3Ca^2-6ab\ \Longrightarrow\ 3x+y=K:=\frac{6a(2a-n)}{n},$$

using $N=n(n-1)/2$ and $C=2(n-2)$. **The lower endpoint of given 16's range is exactly the nonnegativity of this combination:** $3x+y\ge0$ forces $K\ge0$, that is $a\ge n/2$.

Parametrise by $x$: $y=K-3x$, $z=3Ca+3x-2K$, $w=C(N-3a)+K-x$. The coefficient of $x$ in $m_3=\mu^3x+\mu^2\nu y+\mu\nu^2z+\nu^3w$ is $\mu^3-3\mu^2\nu+3\mu\nu^2-\nu^3=(\mu-\nu)^3>0$, so $\theta$ increases in $x$ and is maximised at the segment's upper end, which is $x=K/3$, that is $y=v_{112}=0$, provided $w\ge0$ there. Then $z=3Ca-K$ and $w=C(N-3a)+\tfrac23K$, and with $\sum_ia_i\mu_i^3=k^3ab N(N-2a)=(N-2a)/\sqrt{Nab}$,

$$m_3=k^3\Big[\tfrac K3b^3+(3Ca^3b-Ka^2b)-a^3\big(C(N-3a)+\tfrac23K\big)\Big] =k^3\Big[\tfrac K3(a+b)^2(b-2a)+2CNa^3\Big],$$

the first bracket using $b^3-3a^2b-2a^3=(a+b)^2(b-2a)$. With $a+b=N$ this is $m_3=\dfrac{2k^3Na}{n}\big[(2a-n)N(N-3a)+2n(n-2)a^2\big]$, so

$$\theta=\frac{N-2a}{\sqrt{Nab}}+\frac{(2a-n)N(N-3a)+2n(n-2)a^2}{n\,b\sqrt{Nab}} .$$

Given 16's value is $(n-1)\sqrt{a/(N(N-a))}=(n-1)a/\sqrt{Nab}$, so the two agree if and only if

$$(2a-n)N(N-3a)+2n(n-2)a^2=n\,b\big[(n+1)a-N\big],$$

and this is an identity. Expanding with $2N=n(n-1)$, the coefficient of $aN$ on the left minus the right is $2N^2+N[3n-n(n+2)]=N[n(n-1)-n(n-1)]=0$, and the coefficient of $a^2$ is $-6N+2n(n-2)+n(n+1)=-3n(n-1)+3n^2-3n=0$, while the $nN^2$ terms cancel outright. Hence

$$\boxed{\ \theta=(n-1)\sqrt{\frac{s}{N(N-s)}}\ }\qquad\text{with } s=a \text{ the multiplicity of the positive eigenvalue.}$$

**The upper endpoint of given 16's range is exactly the nonnegativity of $w=v_{222}$ at that vertex.** From $w=C(N-3a)+\tfrac23K\ge0$, multiplying by $n/2$,

$$4a^2-n(3n-4)a+\tfrac12n^2(n-1)(n-2)\ \ge\ 0,$$

whose discriminant is $n^2[(3n-4)^2-8(n-1)(n-2)]=n^4$, giving roots $a=\tfrac{n(n-2)}4$ and $a=N$. For $a<N$ the inequality holds precisely when $a\le\tfrac{n(n-2)}4$, which is given 16's upper limit, and at $a=\tfrac{n(n-2)}4$ both $y$ and $w$ vanish, the segment degenerates to a point, and $\theta=\theta_0(n)$: with $N-s=n^2/4$ one has $s/(N(N-s))=2(n-2)/(n^2(n-1))$ and $(n-1)\sqrt{\cdot}=\sqrt{2(n-1)(n-2)}/n$.

**Two-value verdict: CONFIRMED, formula and both endpoints and all constants.** The smallest instance is worth writing out because it is entirely explicit. At $n=4$, $a=2$: $N=6$, $b=4$, $K=0$, so $x=y=0$, $z=24$, $w=0$, a single feasible point. Then $k=1/\sqrt{48}$, $\mu=4/\sqrt{48}$, $\nu=-2/\sqrt{48}$, $\sum a_i\mu_i^3=2/\sqrt{48}=1/(2\sqrt3)$, $m_3=\mu\nu^2\cdot24=384/48^{3/2}=2/\sqrt3$, and $\theta=1/(2\sqrt3)+1/\sqrt3=3/(2\sqrt3)=\sqrt3/2=\theta_0(4)$. The same computation at $(n,s)=(6,3),(6,6),(8,4),(8,12)$ returns $\sqrt{15}/6$, $\sqrt{10}/3$, $\sqrt{42}/12$, $\sqrt{21}/4$, matching given 16 at each and $\theta_0(n)$ at each upper endpoint.

I note what this check does *not* establish. The class system is a set of necessary conditions on $T$, so its optimum is an upper bound on $\sup\theta$ at a given spectrum type and sharpness is a separate question. At two values the bound is attained, by given 16, so the relaxation is lossless there. Nothing in the block's argument shows the same at three.

## 11. Degeneracies

**Two equal $\mu$'s.** The level-set construction presupposes distinct values, so this is the two-value system, not a boundary of the three-value one, and the framing covers it only by changing $L$. It matters more than bookkeeping: section 12's rank argument uses $\mu_i\ne\mu_j$ at every pair, and if one insists on carrying a spurious third index with $\mu_3=\mu_2$ the rank drops from $5$ to $4$ and the polytope gains a dimension of pure relabelling freedom. Any enumeration should therefore be run per value of $L$, with the three-value run restricted to pairwise-distinct $\mu$.

**A zero eigenvalue.** The class system itself is unaffected: no expression in sections 4 to 6 divides by any $\mu_i$, and my class form of (C) is stated through $\pi_i(S)$ precisely so that it survives $\mu_i=0$. What does change is section 7's sign structure. With $\mu_3=0$ the six classes containing index $3$ all have $\sigma_3=0$, and only $111$ and $122$ carry positive coefficients, $112$ and $222$ negative. **This stratum is not one of the block's two cases, and it is exactly where the record's own local maximum at $n=4$ lives**: $W_{\mathbb{CP}^2}$ has spectrum $(2c,-c,0)$ with multiplicities $(1,2,3)$. Trace-freeness with three distinct values forces at least one positive and one negative, so the third value is positive, negative, or zero, and the sign cases are three, not two. The zero case is a limit of the other two and a bound continuous in $\mu$ would cover it by closure, but the block asserts coverage by a two-case split, and that assertion is wrong as stated.

**$a_i=0$.** Then there are not three level sets. If an empty index is carried anyway, the system is consistent and self-repairing: the marginal at that index reads $\tfrac13\sum_Sm_i(S)v_S=0$, which with $v_S\ge0$ kills every class containing $i$, and the system collapses to the two-value one. So no contradiction, but the block's implicit $a_i\ge1$ should be written down, together with the stronger support conditions $v_S=0$ when $m_i(S)>a_i$ from section 6, which are the real constraint in the small-multiplicity cases the interesting spectra have.

**The mirror case, two positive against one negative.** Here the block is wrong twice. First the count: $\sigma_3>0$ exactly when the multiplicity of the negative index is even, so the positive classes are $111,112,122,222$ (multiplicity $0$) and $133,233$ (multiplicity $2$), **six** classes, not four. Second the structure: the fact that makes the $(+,-,-)$ case tractable is that every positive class meets $L_1$, and it fails here, since $111$ misses $L_2$ and $222$ misses $L_1$. Third, and most substantively, "runs the same way with the roles of the signs exchanged" is not a symmetry that saves the work. $P$ is homogeneous of degree three, so $\theta(-W)=-\theta(W)$: the negation that exchanges the sign pattern also reverses the objective, and **maximising $\theta$ over $(+,+,-)$ spectra is the minimisation problem for $(+,-,-)$ spectra**, whose optimum sits at different vertices of the same polytope. The mirror case needs its own enumeration in the opposite direction, not a relabelled copy of the first.

## 12. What would break the reduction, and what I did to look for it

Six candidate falsifiers, and what each search returned.

1. **A miscount of the ordered triples in a class**, which would corrupt $\tfrac13$, $\tfrac13$, $1$, $\tfrac13$ and $\tfrac16$ inconsistently. Looked for by deriving each weight twice, once by the labelled-permutation count of section 4 and once by contracting the equalities back into the moments at the end of section 5, which recovers all three moment weights from the two equality weights. **Nothing found**: all five factors are right.
2. **The $\tfrac12$ in the objective**, the classic ordered-versus-unordered slip. Looked for by deriving $\langle W,W^\#\rangle$ from H2 and then independently reconstructing $\theta$ for $W_{\mathbb{CP}^2}$ from its structure constants, where $\tfrac12$ gives $\sqrt{3/2}$ and $1$ gives $5/\sqrt6$. **Nothing found**, and given 5 now pins the factor rather than merely permitting it.
3. **The caps.** Looked for by rederiving them from H7 and counting ordered pairs, then testing them on a configuration off the decomposable locus. **FOUND**: they are the $\kappa=1$ caps, a factor of two too tight in general, and $W_{\mathbb{CP}^2}$ violates all three of their nontrivial instances at its own spectrum type. This is the defect that would turn the enumeration into a false theorem, since it excludes a certified critical point.
4. **The dimension count.** Looked for by asking whether the six equality rows are independent, and solving $\sum_ic_iM_i+\sum_id_iB_i=0$ coefficientwise: the all-equal classes force $c_i=-\mu_id_i$, the two-equal classes force $\tfrac13(\mu_j-\mu_i)(d_i-d_j)=0$ hence $d_i$ constant, and the all-distinct class is then automatic. **FOUND**: the dependency space is exactly one-dimensional, spanned by $\sum_iB_i=\sum_i\mu_iM_i$, so the rank is $5$ and the affine feasible set is **five**-dimensional, not four. The same dependency is the one that makes the two-value count $4\to3$, so the block's two statements about collapse are inconsistent with each other and the two-value one is the correct instance of the general rule "one dependency".
5. **The sign bookkeeping.** Looked for by tabulating all ten $\sigma_3$ with multiplicity, in both sign patterns. **FOUND, twice**: four all-negative classes rather than three, and six positive classes rather than four in the mirror case, whose enumeration is the min-side problem.
6. **A hidden decomposability or criticality assumption in the pinned moments.** Looked for by tracing each of $m_0,m_1,m_2$ to its hypotheses. **Nothing found**: $m_0$ and $m_1$ need only H4 and trace-freeness, $m_2$ needs H5 and unit norm, and none needs H6, so the moment frame is available off the critical set and off the decomposable locus. This is the reduction's real strength and it survives every attack above.

The screens, reported as screens. Three exact symbolic runs, each on an object constructed for the purpose: the $\mathfrak{so}(4)$ structure constants of section 0 with the resulting $m_0,m_1,m_2,m_3$ and $\theta$; the class identities of sections 4, 5 and 9 as symbolic identities in $\mu_1,\mu_2,\mu_3$ and the ten $v_S$, together with the rank of the six rows; and the two-value endpoint identity with instances at $(n,s)=(4,2),(6,3),(6,6),(8,4),(8,12)$. Every one agreed with the hand derivation above, and none of them is offered as evidence for a positive claim: the claims rest on the derivations.

## Verdict

**The reduction stands, and the paragraphs fencing it do not.**

- **Sound and unaltered:** the objective $\theta=\sum_ia_i\mu_i^3+\tfrac12m_3$; the pinning of $m_0=2(n-2)N$, $m_1=0$ and $m_2=-2$, with their hypotheses correctly and minimally identified; the four class weights the record states and the fifth it implies; the two-value specialisation, which reproduces given 16's bound and both endpoints of its range exactly; the boundedness claim; and the circularity identity. On the specific point the brief flagged, the combinatorial factors from the symmetry of the three-tensor, **the record is right this time**, and the $\tfrac16$ in relation (B) is right where a factor of two would have been easiest to lose.
- **Must be corrected before any enumeration is attempted:** the caps, which are the decomposable-locus caps stated without their hypothesis and which exclude $W_{\mathbb{CP}^2}$ at its own spectrum type; the polytope's dimension, five rather than four; the four all-negative classes; and the mirror case, which is the minimisation problem with six positive classes and no single positive index.
- **Should be rewritten, being right in equation and wrong in words:** "the average of the remaining two values", which is the sum; and the blanket refusal of relation (C), of which one combination is the objective and two are usable in a $\theta$-parametric feasibility formulation.
- **Owed additions the block does not mention:** the support conditions $v_S=0$ when $m_i(S)>a_i$, free from hollowness and strictly stronger than the caps at small multiplicities; the class form of (C), $\tfrac13\sum_Sm_i(S)\pi_i(S)v_S=2a_i\mu_i(\theta-\mu_i)$; the third sign stratum $(+,0,-)$, which holds $n=4$'s local maximum; and a note that the class system is a relaxation, so its optimum bounds $\sup\theta$ from above with sharpness an open question at three values.
- One presentational hazard, since it sits on a load-bearing sentence: $m$ denotes both the moments $m_r$ and the class multiplicities $m_i(S)$, and the boundedness claim "bounded through $m_0$ and the marginal at $i=1$" reads in both senses at once. Rename one of them.

**Verdict: CONFIRMED WITH CORRECTIONS.** The moment reduction is the real result here and it survives an adversarial reading intact. The vertex enumeration it calls for must not be run against the constraint list as currently written, because that list is a factor of two too tight on the caps and one dimension too small on the polytope, and the first of those errors would exclude the programme's own witness.
