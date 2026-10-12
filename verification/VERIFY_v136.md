# VERIFY v136, Lemma L27: the ten-summand multiplicity-free decomposition, the four zero eigenvalues, and $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $S^p\times S^q$

*Cold brief, verifier v136, round [ROUND_L27.md](ROUND_L27.md). **No numerical work was done**: no script was run, no interpreter was opened, and every number below is an exact hand evaluation of a closed form on file. Log: [agent_logs/verify-L27-v136.log](../agent_logs/verify-L27-v136.log). Sources read rather than recalled: [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) (Proposition 4.6, its summary display, Remark 4.7, Appendix I), [REVIEW_r34.md](../reviews/REVIEW_r34.md), [REVIEW_r38.md](../reviews/REVIEW_r38.md), [ATTEMPTS.md](../ATTEMPTS.md):2014.*

## Claim table

| # | Claim, read alone as a consumer would | Verdict |
|---|---|---|
| C1 | The ten-summand decomposition of $\mathrm{Weyl}_n$ is the source's | **PROVEN**, it is the summary display after Nienhaus Prop 4.6, quoted correctly, read at the source |
| C2 | The ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$ | **PROVEN**, polynomial identity, derived in full below |
| C3 | The ten Young labels are pairwise distinct | **PROVEN**, trivially, as ordered pairs of partitions |
| C4 | Distinctness $\Rightarrow$ multiplicity-free | **GAP**, distinctness gives non-isomorphism, never irreducibility; at $p$ or $q\in\{3,4\}$ irreducibility is the asserted input, supplied here only by computation |
| C5 | Schur/division-algebra: $L_e$ is a real scalar on each summand | **PROVEN**, and symmetry is strictly stronger than what the step needs |
| C6 | $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$, that summand being the orbit tangent | **PROVEN**, the identification is Nienhaus Prop 4.6(b), read |
| C7 | $\dim(\text{orbit})=pq$ | **PROVEN**, two independent hand routes |
| C8 | $-\mu$ on $S^2_0\otimes S^2_0$, forced uniquely by $\operatorname{tr}L_e=0$ | **PROVEN**, the trace identity closes to $0$ identically; verified in full below |
| C9 | $L_e=0$ on $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | **GAP**, mechanisms named and attested, no derivation on file a reader can check |
| C10 | $\tfrac12$ is the maximum on $W^\perp$, attained on the orbit alone | **PROVEN**, conditional on C4 and C9 |
| C11 | $\dim E(\tfrac12)=pq$ | **PROVEN**, conditional on C4 and C9 |
| C12 | "$S^p\times S^q$ is Morse–Bott nondegenerate" | **GAP**, the block never cites the Hessian bridge its conclusion runs through |
| C13 | $(3,3)$ fails, as an eigenvalue coincidence and not representation mixing | **PROVEN**, both commutant dimensions confirmed by hand |
| C14 | "The $p,q\ge5$ case is proved in the source" | **PROVEN, hypotheses corrected**: Prop 4.6 reads $k,l\ge5$ *and $k,l\ne6$*; the $\ne6$ is inherited from $\Lambda^3(\mathbb R^6)$, outside $\mathrm{Weyl}_n$ |
| C15 | The landscape and neighbouring forms carry the corrected content | **BROKEN**, four live carriers of already-refuted or already-superseded content, §10 |

**Verdict: `GAP`.** The lemma's spine is correct and I could reproduce every arithmetical claim in it by hand, including four figures nobody asked me to check; what it does not have is a written proof of the four zero eigenvalues, and the multiplicity-freeness it advertises as following "by Young labels" does not follow from labels alone at $p,q\le4$.

**One line.** Every value, every dimension, the trace identity, the $(3,3)$ commutants and the whole exact-spectrum table check out to the digit by hand, and the load-bearing gaps are elsewhere: the four zeros are attested rather than derived, the small-$p$ irreducibility is computed rather than argued, and the Morse–Bott conclusion crosses a bridge the block does not name.

## 0. Conventions, fixed once

- $n=p+q$; $P$ block is the first $p$ coordinates, $Q$ block the last $q$; $W=W_{p,q}$ is the unit Weyl tensor of the round $S^p\times S^q$, $\theta=P(W)>0$, $e=W/\theta$.
- $L_eV=e\circ V$ with $\circ$ the Böhm–Wilking product; $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric and $L_e$ is self-adjoint ([second-order.md](../findings/second-order.md):62, via [r285](../reviews/REVIEW_r285.md) Claim 1). $W^\perp$ is $L_e$-invariant because $L_ee=e$ (criticality) and $L_e$ is self-adjoint (same line).
- $\dim\mathrm{Weyl}_m=m(m+1)(m+2)(m-3)/12$, written $W(m)$. It is the true dimension for $m\ge3$ and **not** for $m=2$, where it returns $-2$ against a true $0$.
- $s_m=\dim S^2_0(\mathbb R^m)=(m+2)(m-1)/2$, $c_m=\dim\Lambda^2(\mathbb R^m)=m(m-1)/2$, $X(m)=\dim X_m=m(m^2-4)/3$.
- $\mu=\dfrac{n-2}{2(p-1)(q-1)}$, $\lambda_m=\dfrac{m-2}{2(m-1)}$.
- $O(m)$-irreducibles are labelled by partitions $\lambda$ with $\lambda'_1+\lambda'_2\le m$; the labels in play are $[\,]$, $[1]$, $[2]$, $[1,1]$, $[2,1]$, $[2,2]$.

## 1. Hypothesis inventory

**Carried by the block's own statement.** (i) $p,q\ge3$; (ii) $(p,q)\ne(3,3)$; (iii) $n=p+q$.

**Carried by the block's proof but absent from its statement.**

| # | Hypothesis the proof uses | Where it is discharged | Used in the written proof? |
|---|---|---|---|
| H1 | $W_{p,q}$ is a critical point of $P$ on the unit sphere, with $Q(W)=\theta W$, $\theta\ne0$ | [nondegeneracy.md](../findings/nondegeneracy.md):742, $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ | yes, twice, for the orbit's $\tfrac12$ and for $L_ee=e$ |
| H2 | $\mathrm{Weyl}_n$ is $O(n)$-irreducible and non-trivial | Nienhaus Appendix II ($n\ge5$; $\mathrm{Weyl}_4$ is $O(4)$-irreducible by $D=\mathrm{diag}(1,1,1,-1)$). $p,q\ge3\Rightarrow n\ge6$ | yes, the trace identity, and nothing else |
| H3 | $T(X,Y,Z)$ fully symmetric, so $\operatorname{tr}L_e=\langle e,\sum_iQ(V_i)\rangle$ | [second-order.md](../findings/second-order.md):62 | yes, the trace identity |
| H4 | $L_e$ self-adjoint | same | yes, the division-algebra step |
| H5 | Each of the ten summands is $O(p)\times O(q)$-**irreducible** | source, $k,l\ge5$ proved / $k,l\ge3$ asserted; $p,q\le4$ by commutant computation in [r38](../reviews/REVIEW_r38.md) | **claimed via labels, which do not supply it**, §3 |
| H6 | $\mathrm{Ric}(W)=0$ | Weyl tensors are Ricci-flat by construction | yes, inside the $X_p\otimes\mathbb R^q$ index proof |
| H7 | $\mathrm{Hess}(P|_S)=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$ | [Lemma L24](../findings/second-order.md):62 | **used and never cited**, §8 |
| H8 | $\lambda_m<\tfrac12$ for all $m$ | in the block's own value list; $m-2<m-1$ | yes |

**Imported results, each checked against the object it is applied to.**

| Import | Its hypotheses | The object here | Verdict |
|---|---|---|---|
| Nienhaus Prop 4.6 | $k+l=n$, $k,l\ge5$, **$k,l\ne6$** | $p,q\ge3$ | applied outside its stated range; see §9 |
| the summary display after it | "$k,l\ge5$" for $SO$, "$k,l\ge3$" for $O$, the latter asserted | $p,q\ge3$ | in range as asserted, not as proved |
| Nienhaus Prop 4.6(b) | same | $p,q\ge3$ | the orbit-tangent identification, in range as asserted |
| Nienhaus Appendix I | $X_k$ irreducible under $SO(k)$ for $k\ge5$; $X_4$ under $O(4)$; $O(k)$-irreducibility for $k\ge3$ asserted | $p,q\ge3$ | $X_3$ rests on the asserted sentence |
| [Lemma L26](../findings/nondegeneracy.md):85 | $p,q\ge2$, coordinate $2$-planes | $p,q\ge3$ | **in range**, comfortably |
| $\lambda_m$ from [second-order.md](../findings/second-order.md):595 | $A$ trace-free in the first block; $p\ge2$ | $p,q\ge3$ | **in range**; and the derivation is real, §5 |
| [Lemma L24](../findings/second-order.md):62 | critical point, unit norm | $W_{p,q}$ | in range, but **not cited by the block** |


## 2. The dimension sum is an identity in $p,q$, derived in full (C2)

The block asserts "the ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$" without derivation. Both sides are polynomials of total degree $4$, so a degree-$4$ form in two variables has $15$ coefficients and spot checks are a screen, not a proof. Here is the identity.

Write $W(m)=m(m+1)(m+2)(m-3)/12$. Since $m(m+1)=m^2+m$ and $(m+2)(m-3)=m^2-m-6$,
$$(m^2+m)(m^2-m-6)=m^4-7m^2-6m,\qquad W(m)=\tfrac1{12}(m^4-7m^2-6m).$$

The two degree-$4$ cross terms:
$$(p^2{+}p{-}2)(q^2{+}q{-}2)+(p^2{-}p)(q^2{-}q)=2p^2q^2+2pq-2p^2-2q^2-2p-2q+4,$$
the $p^2q$ and $pq^2$ terms cancelling between the two products. Dividing by $4$ gives $s_ps_q+c_pc_q$. And $X(p)q+X(q)p=(p^3q+pq^3-8pq)/3$.

Multiplying the ten-term sum by $12$:
$$12S=12+(p^4{-}7p^2{-}6p)+(q^4{-}7q^2{-}6q)+12pq+6(p^2{+}p{-}2)+6(q^2{+}q{-}2)$$
$$\qquad+\bigl[6p^2q^2+6pq-6p^2-6q^2-6p-6q+12\bigr]+4(p^3q+pq^3-8pq).$$

Collecting: $p^4+q^4$; $4p^3q+4pq^3$; $6p^2q^2$; $p^2$ gives $-7+6-6=-7$ and likewise $q^2$; $pq$ gives $12+6-32=-14$; $p$ gives $-6+6-6=-6$ and likewise $q$; constants $12-12-12+12=0$. So
$$12S=p^4+q^4+4p^3q+4pq^3+6p^2q^2-7p^2-14pq-7q^2-6p-6q.$$
And $12W(n)=(p+q)^4-7(p+q)^2-6(p+q)$ expands to the same nine terms. **Identity confirmed.**

*Two by-products.* $X(m)=m(m^2-4)/3$ agrees with Nienhaus's construction $\dim(\Lambda^2\otimes\mathbb R^m)-\dim\Lambda^3-m$: $\tfrac{m^2(m-1)}2-\tfrac{m(m-1)(m-2)}6-m=\tfrac m6[3m^2-3m-m^2+3m-2-6]=\tfrac{m(2m^2-8)}6=\tfrac{m(m^2-4)}3$, identically. And the identity uses $W(m)$ as a polynomial, so it holds *as a statement about actual dimensions* only for $p,q\ge3$: at $p=2$, $W(2)=-2$ against $\dim\mathrm{Weyl}_2=0$, and the ten true dimensions **exceed** $\dim\mathrm{Weyl}_n$ by $2$. At $(2,4)$: $1+0+10+8+2+9+18+6+0+32=86$ against $\dim\mathrm{Weyl}_6=84$, reproducing the record's own figure at [second-order.md](../findings/second-order.md):809 exactly. **So $p,q\ge3$ is load-bearing for the decomposition itself, before any eigenvalue is computed.**

## 3. Multiplicity-freeness (C3, C4), and the one step the Young labels do not take

**The labels, as ordered pairs.** $\langle W\rangle=([\,],[\,])$; $\mathrm{Weyl}_p=([2,2],[\,])$; $\mathrm{Weyl}_q=([\,],[2,2])$; $\mathbb R^p\otimes\mathbb R^q=([1],[1])$; $S^2_0(\mathbb R^p)=([2],[\,])$; $S^2_0(\mathbb R^q)=([\,],[2])$; $S^2_0\otimes S^2_0=([2],[2])$; $\Lambda^2\otimes\Lambda^2=([1,1],[1,1])$; $X_p\otimes\mathbb R^q=([2,1],[1])$; $X_q\otimes\mathbb R^p=([1],[2,1])$. Ten pairwise distinct ordered pairs. **C3 holds, for every $p,q$ whatever, since it is a statement about ten symbols.**

**Where the step is real.** At $p=3$ the labels $[1]$ and $[1,1]$ both have dimension $3$, and $[2]$ and $[2,1]$ both have dimension $5$, so dimension cannot separate them and the label must. It does: $-I\in O(3)$ acts as $-1$ on $\mathbb R^3$ and as $+1$ on $\Lambda^2(\mathbb R^3)$, so $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$. Likewise $X_3\cong S^2_0(\mathbb R^3)\otimes\det$. Both hand checks confirm the block's own claim and the record's commutant figures.

**And here is the gap.** The block writes:

> "The Young labels are pairwise distinct for every $p,q\ge3$, so the decomposition is multiplicity-free."

**Locate.** [nondegeneracy.md](../findings/nondegeneracy.md):475–476. **Exhibit.** Multiplicity-freeness of a decomposition is two claims: each summand is irreducible, and no two are isomorphic. Distinct labels deliver the *second* and say nothing about the *first*. The gap is not idle: at $p=4$ the summands $\Lambda^2(\mathbb R^4)$, $\mathrm{Weyl}_4$ and $X_4$ each **split** under $SO(4)$, and are irreducible only because $D=\mathrm{diag}(1,1,1,-1)$ interchanges the halves, a fact about the group and the reflection, which no Young label carries. Had the acting group been $SO(4)\times SO(q)$, the same sentence would be word-for-word unchanged and the conclusion false. **Argue the opposite.** The most charitable reading is that "the Young labels" presupposes that each summand *is* the irreducible its label names, folding irreducibility into the premise. That reading rescues the sentence, and relocates the load onto exactly the input the record itself calls asserted: "the multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$" ([nondegeneracy.md](../findings/nondegeneracy.md):490). **The candidate survives all three steps.**

**What is actually on file for $p,q\le4$.** I read [r34](../reviews/REVIEW_r34.md) and [r38](../reviews/REVIEW_r38.md) before recording this. r34's M8 states it plainly: *"the result is conditional on Nienhaus's $O(k)\times O(l)$ irreducibility at $k,l\ge3$, which has not been re-derived here."* r38 records that one reviewer then paid it by exact $O(m)$-commutant computation at $m=3,4$, checked independently. So the position is: **an exact finite computation, not an argument.** That is legitimate as a finite verification and it is honestly labelled in the block; it is not what "so the decomposition is multiplicity-free" advertises. At $p,q\ge5$ the source's Appendix I Lemma supplies $X_k$ and the display supplies the rest.

**What would falsify C4.** A pair among the ten that is $O(p)\times O(q)$-isomorphic at some $p,q\ge3$, or one summand reducible under $O(p)\times O(q)$. I looked for the first by evaluating all the small-dimension coincidences the labels permit ($[1]$ against $[1,1]$ and $[2]$ against $[2,1]$ at $m=3$) and both are separated by $-I$. For the second, the candidates are exactly the $p=4$ splittings, and the source proves $X_4$ and $\mathrm{Weyl}_4$ $O(4)$-irreducible directly (Appendix I, and the Appendix II preamble). No falsifier found.

## 4. The Schur / division-algebra step (C5), and what actually makes it work

**The step as written.** *"a symmetric element of a real division algebra of operators has a real eigenvalue and is therefore a real scalar."*

**It is correct, and here is the derivation.** Let $V$ be a real irreducible $G$-module, $D=\mathrm{End}_G(V)\in\{\mathbb R,\mathbb C,\mathbb H\}$ by real Schur, and let $d\in D$ be self-adjoint for the invariant inner product. Self-adjointness gives a real eigenvalue $\lambda$. Then $d-\lambda\,\mathrm{id}\in D$ is not invertible, and a division algebra has no non-invertible non-zero element, so $d=\lambda\,\mathrm{id}$. Multiplicity-freeness makes each summand an entire isotypic component, so equivariance sends $L_e$ into each summand rather than across, and $L_e|_{V}\in D$. **Nothing in the chain is missing.**

**The pre-registered question: is symmetry what makes it work?** No, it is strictly stronger than needed. The only property used is *"has a real eigenvalue"*, equivalently *"$d-\lambda$ is singular for some real $\lambda$"*. Any element of $D$ with one real eigenvalue is already a real scalar; symmetry is one convenient sufficient condition for that, and the record has it for free from [second-order.md](../findings/second-order.md):62. **A second, sharper observation the block does not make:** every $O(m)$-irreducible is of *real* type, so every one of the ten summands is absolutely irreducible and $D=\mathbb R$ in all ten cases, the $\mathbb C$ and $\mathbb H$ generality is never exercised. I record this as an observation on what the argument needs, not as a repair: the block's version is correct as written and does not depend on knowing which $D$ occurs.

**And the block is right about what symmetry cannot do.** Its italic aside, *"Symmetry is what does this work; it cannot, as the first version had it, change a representation's type"*, is exactly the distinction. See §10 for where the withdrawn version is still standing.

## 5. The ten values, one at a time (Q3)

| summand | dimension | $L_e$ | reached how | in $W^\perp$? |
|---|---|---|---|---|
| $\langle W\rangle$ | $1$ | $1$ | $e\circ e=e$ from $Q(W)=\theta W$ | **no**, this is the excluded line |
| $\mathbb R^p\otimes\mathbb R^q$ | $pq$ | $\tfrac12$ | differentiate $Q(W_t)=\theta W_t$ along the orbit | yes |
| $S^2_0(\mathbb R^p)$ | $s_p$ | $\lambda_p$ | derived, [second-order.md](../findings/second-order.md):595 | yes |
| $S^2_0(\mathbb R^q)$ | $s_q$ | $\lambda_q$ | same | yes |
| $\Lambda^2\otimes\Lambda^2$ | $c_pc_q$ | $+\mu$ | [Lemma L26](../findings/nondegeneracy.md):85 | yes |
| $S^2_0\otimes S^2_0$ | $s_ps_q$ | $-\mu$ | the trace identity, §6 | yes |
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$ | $W(p),W(q)$ | $0$ | attested, §7 | yes |
| $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $X(p)q,X(q)p$ | $0$ | attested, §7 | yes |

**Is $\tfrac12$ the maximum, or only attained?** It is the maximum **on $W^\perp$**, and the answer turns entirely on the restriction. $1>\tfrac12$ on $\langle W\rangle$, and $\langle W\rangle$ is exactly the line the restriction removes, that is why the statement must read $\lambda_{\max}(L_e|_{W^\perp})$ and not $\lambda_{\max}(L_e)$. It does. Among the other nine:

- $\lambda_m=\frac{m-2}{2(m-1)}<\tfrac12$ for every $m$, since $m-2<m-1$. Strict at every $m$, approaching $\tfrac12$ as $m\to\infty$ but never reaching it. At $m=3,4,5,6,7$: $\tfrac14,\tfrac13,\tfrac38,\tfrac25,\tfrac5{12}$.
- $-\mu<0$ since $\mu>0$.
- $0<\tfrac12$ on the four.
- $\mu<\tfrac12$ iff $(p-2)(q-2)>1$. **Derived:** $(p-1)(q-1)-(n-2)=pq-p-q+1-p-q+2=pq-2p-2q+3=(p-2)(q-2)-1$, so $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which is the block's display, confirmed. For $p,q\ge3$ the product $(p-2)(q-2)\ge1$ with equality only at $(3,3)$, so $(p,q)\ne(3,3)$ gives $(p-2)(q-2)\ge2>1$ and $\mu<\tfrac12$ strictly.

**So $\tfrac12$ is both the maximum on $W^\perp$ and attained, on the orbit summand alone, and nothing else reaches or exceeds it.** Had any other summand reached $\tfrac12$, $\dim E(\tfrac12)$ would exceed $pq$ by that summand's dimension and the Morse–Bott conclusion would fail, which is exactly what happens at $(3,3)$, §9.

**$\lambda_m$ is genuinely derived, and the citation resolves.** [second-order.md](../findings/second-order.md):595 carries it: with $a$ on $pp$ pairs, $b$ on $qq$, $c=-s$ mixed, Ricci-freeness giving $a=qs/(p-1)$, $b=ps/(q-1)$ and $\theta=(n-1)s$, the Weyl projection of $H_A$ leaves the shape $\beta(\alpha_i+\alpha_j)$ on $pp$, $0$ on $qq$, $\gamma\alpha_i$ mixed subject to $\beta(p-2)+q\gamma=0$; that one condition makes the shape one-dimensional, which is what forces scalarity, and the $pp$ entry collapses to $\lambda=\frac{(p-2)(a-c)}{2\theta}=\frac{p-2}{2(p-1)}$. The mixed entry independently returns $[(n-2)(p-1)-q]/[2(n-1)(p-1)]$, and I confirm the reconciliation by hand: $(p+q-2)(p-1)-q=p^2-p+pq-q-2p+2-q$, while $(p-2)(n-1)=(p-2)(p+q-1)=p^2+pq-p-2p-2q+2$; both equal $p^2+pq-3p-2q+2$. **The two expressions agree identically, so the consistency check the derivation had to pass does pass.** (See §10 for the sentence eight lines below it that says this is *"a fit and not a proof"*.)

## 6. The trace identity closes exactly (C8), derived in full

**The identity.** $\mathcal W_n$ is $O(n)$-irreducible and non-trivial, so it carries no invariant vector. $\sum_iQ(V_i)$ over an orthonormal basis is basis-independent, hence $O(n)$-invariant, hence zero. Full symmetry of $T$ gives $\operatorname{tr}L_e=\sum_i\langle e\circ V_i,V_i\rangle=\langle e,\sum_iQ(V_i)\rangle=0$. **Unconditional, and correct as written.** It needs H2 and H3 and nothing else, in particular not $p,q\ge3$.

**The check, with $\nu$ the unknown on $S^2_0\otimes S^2_0$.** Weighting each value by its dimension:
$$1\cdot1+\tfrac12pq+\lambda_ps_p+\lambda_qs_q+\mu\,c_pc_q+\nu\,s_ps_q+0=0 .$$
Two collapses: $\lambda_ps_p=\frac{p-2}{2(p-1)}\cdot\frac{(p+2)(p-1)}2=\frac{p^2-4}4$, and $\mu\,c_pc_q=\frac{n-2}{2(p-1)(q-1)}\cdot\frac{p(p-1)}2\cdot\frac{q(q-1)}2=\frac{(n-2)pq}8$. Substituting the candidate $\nu=-\mu$ gives $\nu s_ps_q=-\frac{n-2}{2(p-1)(q-1)}\cdot\frac{(p+2)(p-1)(q+2)(q-1)}4=-\frac{(n-2)(p+2)(q+2)}8$. Multiplying the whole line by $8$:
$$8+4pq+2(p^2-4)+2(q^2-4)+(p{+}q{-}2)pq-(p{+}q{-}2)(p{+}2)(q{+}2)$$
$$=4pq+2p^2+2q^2-8+(p{+}q{-}2)\bigl[pq-(pq+2p+2q+4)\bigr]$$
$$=4pq+2p^2+2q^2-8-2(p{+}q{-}2)(p{+}q{+}2)=4pq+2p^2+2q^2-8-2\bigl[(p{+}q)^2-4\bigr]=0 .$$
**Zero identically in $p,q$.** And since $s_ps_q\ne0$ for $p,q\ge3$, the linear equation determines $\nu$ uniquely from the other nine. **The block's claim that the trace identity forces $-\mu$ is correct, and the "given the other nine" qualifier it attaches is exactly right**, the identity is one equation, so it determines one unknown and no more.

**The discriminating figures, all four confirmed by hand.** Reversing the two tensor summands changes the trace by $\Delta=2\mu(s_ps_q-c_pc_q)$.

| split | $\mu$ | $s_ps_q$ | $c_pc_q$ | $\Delta$ | record |
|---|---|---|---|---|---|
| $(3,5)$ | $\tfrac38$ | $5\cdot14=70$ | $3\cdot10=30$ | $\tfrac34\cdot40=30$ | $30$ ✓ |
| $(4,4)$ | $\tfrac13$ | $9\cdot9=81$ | $6\cdot6=36$ | $\tfrac23\cdot45=30$ | $30$ ✓ |
| $(5,5)$ | $\tfrac14$ | $14\cdot14=196$ | $10\cdot10=100$ | $\tfrac12\cdot96=48$ | $48$ ✓ |
| $(5,7)$ | $\tfrac5{24}$ | $14\cdot27=378$ | $10\cdot21=210$ | $\tfrac5{12}\cdot168=70$ | $70$ ✓ |

**All four exact, none of them near zero.** The assignment of $+\mu$ to $\Lambda^2\otimes\Lambda^2$ rather than to $S^2_0\otimes S^2_0$ is therefore pinned by the trace, independently of L26, which is the strongest thing in this block and is correctly billed as a check that is not in the argument that produced it.

## 7. The four zero eigenvalues (C9), what is on file, read before recording

The four zeros are load-bearing twice: they enter the maximum claim (a non-zero value there could exceed $\tfrac12$), and they enter the trace identity's determination of $-\mu$, which is a single linear equation and therefore fixes one unknown only once the other nine are known. So the block's whole spectral list stands or falls with them. I read [ATTEMPTS.md](../ATTEMPTS.md):2014, [r34](../reviews/REVIEW_r34.md) and [r38](../reviews/REVIEW_r38.md) before writing this section.

**$L_e=0$ on $\mathrm{Weyl}_p$ and $\mathrm{Weyl}_q$.** Two routes are named, in one sentence each ([nondegeneracy.md](../findings/nondegeneracy.md):724, [r34](../reviews/REVIEW_r34.md) M4): (a) via $\Phi(V)=2V$ on $\mathrm{Weyl}_n$ with $\Phi(V)_{\alpha\beta}=\tfrac12\operatorname{tr}(\{A_\alpha,A_\beta\}V)$, "established by Schur plus an $n$-independence argument through zero-padding"; (b) via $e=\eta I_n+(A-\eta)I_p+(B-\eta)I_q$ with $L_{I_n}\equiv0$ on $\mathrm{Weyl}_n$ (Böhm–Wilking, $\mathrm{Ric}=0$) "with a support argument for the rest". **Neither route is written out anywhere I could find.** Route (b) in particular does not close on its face: $L_{I_n}\equiv0$ leaves $(A-\eta)L_{I_p}+(B-\eta)L_{I_q}$ on $\mathrm{Weyl}_p$, and support alone does not kill $L_{I_p}$ there, r38's own arithmetic records $\mathrm{sharp\_bilin}(I_p,\cdot)=\tfrac{p-4}2$ on the $(pp,pp)$ part, which is non-zero for $p\ne4$. A reader cannot check "the rest".

**$L_e=0$ on $X_p\otimes\mathbb R^q$ and $X_q\otimes\mathbb R^p$.** This one is written to a greater depth ([nondegeneracy.md](../findings/nondegeneracy.md):736, [r38](../reviews/REVIEW_r38.md)): the identity $\mathrm{sharp\_bilin}(X,Y)=\mathrm{Sym}_{\text{pair}}\mathrm{Alt}_{ij}H$ with $H$ given explicitly, the specialisation $X=I_p$, the single use of Ricci-flatness to force $\rho=0$, then *"a six-case exhaustion by block type kills five cases on support or on the $\chi$ factors, and the single live $(PP,MX)$ case uses Bianchi twice to return exactly $-V_{ijkl}/2$."* **The six cases are not enumerated and the two Bianchi applications are not shown**, and the step from $\mathrm{sharp\_bilin}(I_p,V)=-V/2$ to $L_eV=0$ is not written at all.

**Verdict on C9: `GAP`, not `HYPOTHESIS-DEBT`.** There is an argument on file, a named mechanism, a stated identity carrying no hypotheses, the exact point where Ricci-flatness enters, and the scope note *"no Schur, no irreducibility, no $p,q\ge3$"* which is itself informative. What there is not is a derivation a reader can follow to the end. The corroboration offered instead is exhaustive exact-integer verification over all $N^2$ entries of every basis vector at 24 splits with negative controls firing ([r38](../reviews/REVIEW_r38.md)), which under this programme's own standing rule is evidence and not proof, however clean.

**What would falsify C9.** A Weyl tensor $V$ supported in the $(pp,\mathrm{mix})$ block with $e\circ V\ne0$ at some $p,q\ge3$, or a $V\in\mathrm{Weyl}_p\subset\mathrm{Weyl}_n$ with $e\circ V\ne0$. I looked for one structurally rather than numerically: by scalarity such a $V$ would make the whole summand carry a non-zero value $z$, and the trace identity would then force $\nu\ne-\mu$ by $z\,X(p)q/(s_ps_q)$, so any non-zero value there is visible in the trace and would have to be compensated. Since §6 shows the ten stated values close the trace to zero identically in $p,q$, **a non-zero value on one of the four would have to be cancelled by a non-zero value on another**, which is a genuine constraint but not an exclusion. No falsifier found; none ruled out by the record either.

## 8. The orbit tangent, and the Morse–Bott conclusion, three separate claims

The brief asks that $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ be checked as separate claims. It is three.

**(a) $\dim E(\tfrac12)=pq$.** By scalarity, $E(\tfrac12)$ is a sum of whole summands; by §5 the only summand in $W^\perp$ carrying $\tfrac12$ is $\mathbb R^p\otimes\mathbb R^q$, of dimension $pq$. **Holds, conditional on C4 and C9.**

**(b) $\dim(\text{orbit})=pq$.** Two independent routes, both by hand. *From the stabiliser:* the isotropy of $W_{p,q}$ in $\mathfrak{so}(n)$ is $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, so $\dim\mathcal O=\binom n2-\binom p2-\binom q2=\tfrac12[(p{+}q)^2-(p{+}q)-p^2+p-q^2+q]=pq$. *From the source:* Nienhaus Prop 4.6(b) states that inside $(\mathbb R^k\otimes\mathbb R^l)_k\oplus(\mathbb R^k\otimes\mathbb R^l)_l$ there is a $k\cdot l$-dimensional subspace generated by $[\mathrm{ad}_v,W_{S^k\times S^l}]$ "that corresponds to the tangent space of $SO(n).W_{S^k\times S^l}$". **Read at the source, not recalled. Holds.**

**(c) $E(\tfrac12)$ *is* the orbit tangent, not merely equidimensional with it.** This is the claim the block's "attained exactly on the orbit tangent" makes, and it is the one that matters, equality of dimensions would not exclude a $\tfrac12$-eigenspace transverse to the orbit while the orbit itself sat at some other eigenvalue. It holds because the same Prop 4.6(b) identifies the summand *as* the orbit tangent, and the orbit's own eigenvalue is $\tfrac12$ by differentiating $Q(W_t)=\theta W_t$: with $Q$ quadratic, $DQ_W(V)=2W\circ V=2\theta\,e\circ V$, and equivariance plus constancy of $\theta$ along the orbit gives $DQ_W(\dot W)=\theta\dot W$, so $e\circ\dot W=\tfrac12\dot W$. **Holds.** *Note that this makes $\lambda_{\max}(L_e|_{W^\perp})\ge\tfrac12$ automatic at every non-zero critical point, the record says so itself at [graded-half.md](../findings/graded-half.md):231, so the entire content of L27 is the upper bound and the multiplicity, which is what §§3–7 are about.*

**(d) The Morse–Bott conclusion, and the bridge the block does not name.** *Locate.* The block's statement ends *"so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$ is Morse–Bott nondegenerate"* ([nondegeneracy.md](../findings/nondegeneracy.md):465–467). *Exhibit.* Morse–Bott nondegeneracy is a statement about $\ker\mathrm{Hess}(P|_S)$, and nothing in the block connects the $\tfrac12$-eigenspace of $L_e$ to that kernel. The bridge is $\mathrm{Hess}(P|_S)=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, **[Lemma L24](../findings/second-order.md):62, which the block never cites**, and which additionally needs $\theta\ne0$ for the kernel identification. *Argue the opposite.* The most charitable reading is that "$\dim E(\tfrac12)=\dim(\text{orbit})$" is being used as the record's working definition of Morse–Bott nondegeneracy at a critical orbit, in which case the last clause is a restatement rather than an inference. That reading is supported by [second-order.md](../findings/second-order.md):39, which performs the same step and *does* cite L24 for it. **The candidate survives**: the block is the canonical form, it is what consumers cite, and read alone it crosses from a spectral fact to a Hessian conclusion with no bridge on the page. The repair is one citation, not new mathematics.

## 9. The excluded cases and every edge of the range (Q2)

**$(p,q)=(3,3)$, excluded by the object.** $\mu=\frac{6-2}{2\cdot2\cdot2}=\tfrac48=\tfrac12$ exactly, so $\Lambda^2\otimes\Lambda^2$ carries $\tfrac12$ alongside the orbit summand. Its dimension is $c_3c_3=3\cdot3=9$, giving $\dim E(\tfrac12)=9+9=18$ against an orbit of $9$. **The point is genuinely Morse–Bott degenerate; the exclusion is not an artefact of the argument.**

*And the stated mechanism is right.* Under $O(3)$, $-I$ acts as $-1$ on $\mathbb R^3$ and as $+1$ on $\Lambda^2(\mathbb R^3)$, so $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$ and the two $\tfrac12$-summands are non-isomorphic. I confirm both commutant figures by hand: under $O(3)^2$ the two summands are non-isomorphic irreducibles, so the commutant of $E(\tfrac12)$ is $\mathbb R\oplus\mathbb R$, **dimension $2$**; under $SO(3)^2$ they are isomorphic, so it is $M_2(\mathbb R)$, **dimension $4$**. Both match the block. So Schur permits no mixing and each summand carries $\tfrac12$ separately: **an eigenvalue coincidence, not representation mixing**, exactly as the block says.

*Uniqueness.* The block's "symbolic solve over all $45$ summand pairs" ($45=\binom{10}2$) is a superset of what is needed. By hand the question is narrower: which non-orbit summand can reach $\tfrac12$? $\lambda_m$ never; $-\mu$ never, being negative; $0$ never; $1$ sits on $\langle W\rangle$, outside $W^\perp$; and $\mu=\tfrac12$ iff $(p-2)(q-2)=1$, which over integers $\ge1$ forces $p=q=3$. **The exception list is closed, by a factorisation and not a search.**

**$q\le2$, excluded twice over, by the object *and* by the argument.**
- *By the object:* at $q=2$, $\mu=\frac{p}{2(p-1)}>\tfrac12$, so $\lambda_{\max}(L_e|_{W^\perp})>\tfrac12$ and the statement is false as written. The record has this at [nondegeneracy.md](../findings/nondegeneracy.md):442 with the excess $\frac1{2(n-3)}$, and correctly distinguishes it from $(3,3)$: **at $q=2$ the point is nondegenerate but not a maximiser; at $(3,3)$ it is degenerate.** Two different failures, correctly separated.
- *By the argument:* the decomposition itself breaks. At $p=2$, $S^2_0(\mathbb R^2)$ is not in $\mathrm{Weyl}_n$ and the ten dimensions **over-count by $2$**, verified by hand in §2 at $(2,4)$, $86$ against $84$. So the input to Schur is wrong before any eigenvalue is asked for.

**$q=1$, outside every version of the statement, and nothing on file addresses it.** *No finding, stated as such:* $S^2_0(\mathbb R^1)=0$, $\Lambda^2(\mathbb R^1)=0$, $X(1)=1\cdot(1-4)/3=-1$ and $W(1)=-1$, so the dimension bookkeeping is meaningless; $S^p\times S^1$ carries a flat factor and is not a member of the family L26 and L27 parametrise. The record never claims it and never disclaims it. **I record the silence rather than filling it.**

**$(3,4)$, inside the range, and the one split where the ordering of the sub-maximal eigenvalues flips.** $n=7$, $\mu=\frac{5}{2\cdot2\cdot3}=\tfrac5{12}$, $\lambda_4=\tfrac13=\tfrac4{12}$, so $\mu>\lambda_{\max(p,q)}$ and the second-largest eigenvalue is $\mu$, gap $\tfrac1{12}$. Nondegeneracy is untouched ($\tfrac5{12}<\tfrac12$) but every argument that *spends* the margin must use $\tfrac1{12}$ here. **Reconstructed in full by hand**, since no exact spectrum for an odd $n$ appears anywhere on file: dimensions $1,0,10,12,5,9,45,18,20,48$ summing to $168=\dim\mathrm{Weyl}_7$; values $1,-,0,\tfrac12,\tfrac14,\tfrac13,-\tfrac5{12},\tfrac5{12},0,0$; trace $1+6+\tfrac54+3-\tfrac{225}{12}+\tfrac{90}{12}=10-\tfrac{120}{12}=0$. **Closes exactly.**

**Odd $n$, no hypothesis, and no exact corroboration either.** Nothing in the argument uses parity: the decomposition, the trace identity and every closed form are polynomial in $p$ and $q$. But *every* exactly-established case on file has even $n$, the five spectra tabulated at [nondegeneracy.md](../findings/nondegeneracy.md):700 are $(3,5),(4,4),(3,7),(4,6),(5,5)$ at $n=8,8,10,10,10$, and the eight exact-arithmetic splits named at :448 are $(4,4),(3,5),(5,5),(3,7),(6,6),(5,7),(3,9)$, all even, plus "over $\mathbb Q$ at $n=6$" whose only splits are $(2,4)$ and $(3,3)$, **both outside L27's scope**. So the numerical corroboration of this lemma contains no odd-$n$ point and no in-scope $n=6$ point. This changes nothing about the proof and is worth knowing about the evidence. §11 supplies the odd-$n$ check by hand.

**Unbalanced splits.** For fixed $p=3$ and $q\to\infty$: $\lambda_q\to\tfrac12$ from below and $\mu=\frac{q+1}{4(q-1)}\to\tfrac14$, so the second-largest eigenvalue is $\lambda_q$ and the gap $\frac1{2(q-1)}\to0$. **Nondegeneracy survives at every $q$; the margin does not survive uniformly.**

**Nienhaus's own range, and the $\ne6$ the block drops.** *Locate.* [nondegeneracy.md](../findings/nondegeneracy.md):490, *"The $p,q\ge5$ case is proved in the source."* *Exhibit.* Proposition 4.6 reads, verbatim at the source: *"Let $k,l\in\mathbb N$ with $k+l=n$ and $k,l\ge5$, $k,l\ne6$."* So at $p=6$, for instance $S^6\times S^6$ at $n=12$, one of the eight splits the record names as established, and squarely inside the range route R2 needs, the cited proposition's hypothesis fails. *Argue the opposite.* The summary display *after* Prop 4.6 states the $\mathrm{Weyl}_n$ decomposition as "orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$" with no exclusion, and the $\ne6$ exists only because $\Lambda^3(\mathbb R^6)$ splits, Appendix I says so in as many words, $\Lambda^2(\mathbb R^6)\otimes\mathbb R^6=\Lambda^3(\mathbb R^6)^+\oplus\Lambda^3(\mathbb R^6)^-\oplus\mathbb R^6\oplus X_6$, and $\Lambda^3\otimes\mathbb R^l$ is one of the spaces Prop 4.6(f) places **outside** $\mathrm{Weyl}_n$. Appendix I's Lemma covers what is needed: *"$X_k$ is an irreducible $SO(k)$-module for any $k\ge5$"*, $6$ included. **This is already adjudicated in the record**, [r34](../reviews/REVIEW_r34.md)'s M1 says *"Dropping $\ne6$ is legitimate, it exists only because $\Lambda^3(\mathbb R^6)$ splits, and $\Lambda^3\otimes\mathbb R^l$ lies outside $\mathrm{Weyl}_n$"*, so the substance stands and only the citation is loose. **Verdict `PROVEN, hypotheses corrected`:** the sentence should read that the source proves it for $k,l\ge5$ *via the summary display*, the proposition's $\ne6$ being an exclusion about a summand outside $\mathrm{Weyl}_n$.

## 10. Compare the forms, and the named trap, four live carriers (C15)

**The forms that agree.** [results.md](../results.md):423 carries the statement verbatim from the canonical block and points to [nondegeneracy.md](../findings/nondegeneracy.md) for the proof: **clean, no drift**. The L27 landscape line at [results.md](../results.md):140 reads *"The isotypic decomposition is multiplicity-free, so Schur makes $L_e$ scalar on each of ten summands and each value is an eigenvalue, not a lower bound. For $p,q\ge3$ other than $(3,3)$, $\lambda_{\max}=\tfrac12$ on the orbit alone"*: **accurate, and it names the one thing that matters, eigenvalue rather than lower bound.**

**Lean.** *There is no row for L27 in [lean/INDEX.md](../lean/INDEX.md).* It appears once only, on the **"out, needs machinery Mathlib does not have"** list at line 361, bracketed with L11, L28 and L69 as *"branching and isotypic decompositions of $\mathfrak{so}(n)$"*. **What a row would have to claim, were one written:** not the decomposition (that is the part Mathlib cannot reach) but the arithmetic downstream of it, namely that given ten dimensions $(1,W(p),W(q),pq,s_p,s_q,s_ps_q,c_pc_q,X(p)q,X(q)p)$ and ten values $(1,0,0,\tfrac12,\lambda_p,\lambda_q,-\mu,\mu,0,0)$, (i) the dimensions sum to $W(p+q)$ identically, (ii) the weighted sum of values is $0$ identically, (iii) $\max$ of the last nine values is $\tfrac12$ exactly when $(p-2)(q-2)>1$, and (iv) over integers $p,q\ge3$ that fails only at $(3,3)$. All four are polynomial identities and integer factorisations of the kind [L26.lean](../lean/HamiltonsCubic/Results/L26.lean) and [L126.lean](../lean/HamiltonsCubic/Results/L126.lean) already carry, and (i)–(ii) are proved by hand in §§2 and 6 above. **The unformalisable part is the hypothesis, not the conclusion.**

**The trap. This record's signature failure is a correction landing *beside* the statement it corrects. I read each citable claim alone, and found four live carriers.**

**T1, the refuted $(3,3)$ mechanism, seven lines above the block that refutes it.** *Locate.* [nondegeneracy.md](../findings/nondegeneracy.md):450: *"At $k=l=3$ one has $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\mathbb R^3$, the orbit's own representation, so two copies land on the same eigenvalue and the kernel is $18$ against an orbit of $9$."* And :452: *"the content lies in the representation isomorphism above."* *Exhibit.* Under $O(3)\times O(3)$, the group L27 uses, and the group :452's own sentence names, that isomorphism is **false**: $\Lambda^2\otimes\Lambda^2\cong(\mathbb R^3\otimes\mathbb R^3)\otimes(\det\boxtimes\det)$, and $\det\boxtimes\det$ is a non-trivial character of $O(3)\times O(3)$. The canonical block seven lines below says so: *"under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$ … Schur permits no mixing."* And the withdrawal note at :444 says so six lines **above** :450: *"That isomorphism is true and computes nothing."* *Argue the opposite.* Read under $SO(3)\times SO(3)$ the isomorphism is true, and :452 explicitly distinguishes the two groups, so :450 could be meant $SO$-wise. But :450 then still asserts the *causal* claim (*"so two copies land on the same eigenvalue"*) which the canonical block and [r34](../reviews/REVIEW_r34.md)'s M7 both refute as the mechanism, on the ground that the coincidence is one of eigenvalues and has no group origin. **The candidate survives.** A consumer reading :448–:452 as a unit gets the refuted account, complete, with the refutation four lines above it and the correction seven lines below it, and no cross-reference from :450 to either.

**T2, the withdrawn division-algebra phrasing, still standing.** *Locate.* [nondegeneracy.md](../findings/nondegeneracy.md):720: *"Absolute irreducibility is what Schur needs, and $L_e$ being symmetric rules out the $\mathbb C$ and $\mathbb H$ cases."* *Exhibit.* The type of $\mathrm{End}_G(V)$ is determined by $G$ and $V$ and is untouched by any property of $L_e$; here every $O(m)$-irreducible is of real type, so $D=\mathbb R$ in all ten cases whatever $L_e$ does. The canonical block at :481–484 withdraws this in italics: *"Symmetry is what does this work; it cannot, as the first version had it, change a representation's type."* **The withdrawn sentence sits 240 lines below the withdrawal, in the file's own longer treatment of the same lemma.** *Argue the opposite.* Read as "rules out $L_e$ being a non-real element of $\mathbb C$ or $\mathbb H$" the sentence is true and is the correct step. **The candidate survives at reduced severity**: the words say the cases, and "the first version had it" identifies this sentence as the version the block repudiates.

**T3, "a fit and not a proof", eight lines below the proof.** *Locate.* [second-order.md](../findings/second-order.md):603, of the same $\lambda_p=\frac{p-2}{2(p-1)}$: *"three points against a two-parameter guess, which is a fit and not a proof … Set up and not finished."* *Exhibit.* [second-order.md](../findings/second-order.md):595, eight lines above, derives it, *"The block closed form is DERIVED … Gate 2, Reviewers 301 and 302 … 302 supplied the proof the record owed"*, with the two-route consistency check I confirm identically in §5. **And :595 is the line L27 cites**, its argument saying *"derived at [second-order.md](../findings/second-order.md)"*. *Argue the opposite.* :603's paragraph is about a wider claim (the $\mathrm{Sym}_0$ criterion across all critical points, r301's widening), and could be read as saying the *widened* statement is a fit. But it names the same two values and the same three splits and says "Set up and not finished" of the same $q$-independence that :595's $\beta(p-2)+q\gamma=0$ resolves. **The candidate survives.** A consumer following L27's own pointer lands in a file that says both.

**T4, "rests entirely on the multiplicity list, which remains numerical", in two live blocks.** *Locate.* [nondegeneracy.md](../findings/nondegeneracy.md):712: *"nondegeneracy for $p,q\ge3$ rests entirely on the multiplicity list below, **which remains numerical**"*, under a heading at :714 calling that list *"nearly proved"*. And, inside **Lemma L26's own canonical block**, :104–:107: *"The statements nondegeneracy needs (that $(3,3)$ is the unique split reaching $\tfrac12$, and that $\dim E(\tfrac12)=pq$), … rest on the full multiplicity list, which is verified numerically at 44 splits to $n=16$ and rigorous only at $n\le12$."* *Exhibit.* Both are false if L27 stands: L27 proves both statements for all $p,q\ge3$ with $(p,q)\ne(3,3)$, uniformly, and the block's own closing header at :758 says *"Hence, unconditionally"*. The $n\le12$ ceiling in particular is contradicted by a lemma whose every step is polynomial in $p,q$. *Argue the opposite.* :104–107 is scoped to what **L26** does not reach, and could be read as historical. It cannot: it is in the canonical block of a Tier-1 lemma, states a present tense *"rest on"*, and names the two statements L27 exists to supply. **The candidate survives, and this is the worst of the four**, it is a live claim, inside a canonical block, that the record's own strongest result is numerical.

**T5, withdrawn.** I considered flagging the canonical block for displaying $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ as what closes the argument, when [r314](../reviews/REVIEW_r314.md)'s correction at :762 shows this is the gap to the family-B block and the true spectral gap is $\frac1{2(M-1)}$, $M=\max(p,q)$, a correction that is **absent from the canonical block**. *Withdrawn on step two:* the block never calls that quantity the margin. It states $\lambda_m<\tfrac12$ separately in its value list, and its conclusion (*"so $\tfrac12$ is attained on the orbit summand alone"*), is supported by both facts together and is correct. **No finding against the block; the observation stands only that a consumer wanting a margin must go to :762 and will not be sent there.**

**One further consumer-level drift, recorded.** The **L11** landscape line at [results.md](../results.md):140 presents this result as measurement, *"verified at all 36 splits up to $n=14$ and proven in exact arithmetic at eight. The one exception is representation-theoretic rather than dimensional"*, where L27 proves it for all $p,q$ at once, and where "representation-theoretic" is the vocabulary of the mechanism [r461](../reviews/REVIEW_r461.md)/[r462](../reviews/REVIEW_r462.md) refuted. The L27 line four bullets below it is correct. **Two landscape lines about one theorem, one of them numerical and one of them proved.**

## 11. An independent confirmation, done by hand

The record tabulates five exact spectra at [nondegeneracy.md](../findings/nondegeneracy.md):700. **They were produced by computation; I reconstructed all five from the ten-summand model alone, with no script**, as a check that the value list and the dimension list are the same object. Each row: the ten dimensions, then the values grouped.

| split | reconstruction from the model | record | agrees |
|---|---|---|---|
| $(3,5)$ | dims $1,0,35,15,5,14,70,30,25,105$ sum $300$; $\mu=\tfrac38$; $0$'s are $35{+}25{+}105{=}165$; $\tfrac38$'s are $14{+}30{=}44$ | $-\tfrac38^{70},0^{165},\tfrac14^{5},\tfrac38^{44},\tfrac12^{15},1^1$ | ✓ |
| $(4,4)$ | dims $1,10,10,16,9,9,81,36,64,64$ sum $300$; $\mu=\lambda_4=\tfrac13$; $0$'s are $10{+}10{+}64{+}64{=}148$; $\tfrac13$'s are $9{+}9{+}36{=}54$ | $-\tfrac13^{81},0^{148},\tfrac13^{54},\tfrac12^{16},1^1$ | ✓ |
| $(3,7)$ | dims $1,0,168,21,5,27,135,63,35,315$ sum $770$; $\mu=\tfrac13$, $\lambda_7=\tfrac5{12}$; $0$'s are $168{+}35{+}315{=}518$ | $-\tfrac13^{135},0^{518},\tfrac14^{5},\tfrac13^{63},\tfrac5{12}^{27},\tfrac12^{21},1^1$ | ✓ |
| $(4,6)$ | dims $1,10,84,24,9,20,180,90,96,256$ sum $770$; $\mu=\tfrac4{15}$, $\lambda_6=\tfrac25$; $0$'s are $10{+}84{+}96{+}256{=}446$ | $-\tfrac4{15}^{180},0^{446},\tfrac4{15}^{90},\tfrac13^{9},\tfrac25^{20},\tfrac12^{24},1^1$ | ✓ |
| $(5,5)$ | dims $1,35,35,25,14,14,196,100,175,175$ sum $770$; $\mu=\tfrac14$, $\lambda_5=\tfrac38$; $0$'s are $35{+}35{+}175{+}175{=}420$ | $-\tfrac14^{196},0^{420},\tfrac14^{100},\tfrac38^{28},\tfrac12^{25},1^1$ | ✓ |

Every multiplicity, every value, every total. The record's remark that *"the signed pair follows $(n-2)/D$ with $D=16,18,24,30,32$"* is $D=2(p-1)(q-1)$ at the five splits, confirmed. Adding the odd-$n$ reconstruction at $(3,4)$ in §9, **six splits agree with the model by hand, including one the record has no exact spectrum for.**

*What this does and does not establish.* It confirms that the ten dimensions and the ten values are mutually consistent and reproduce the computed spectra exactly, which is a strong check on the bookkeeping. It is not independent evidence for the four zeros or for multiplicity-freeness, since both are inputs to the reconstruction.

## 12. The gap between what is proven and what is used, what a consumer may cite

**Citable without qualification.**
- The ten-summand decomposition of $\mathrm{Weyl}_n$ as the source's, with the ten dimensions summing to $\dim\mathrm{Weyl}_n$ identically for $p,q\ge3$ (§2).
- $\operatorname{tr}_{\mathcal W_n}L_e=0$, unconditionally, for every $n\ge5$ and at every critical point (§6), this is the block's most robust component and it needs neither $p,q\ge3$ nor Schur.
- Given the ten values, the trace identity closes to zero identically in $p,q$, and $-\mu$ on $S^2_0\otimes S^2_0$ is the unique value consistent with the other nine (§6).
- $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, and $\mu=\tfrac12$ over integers $p,q\ge3$ exactly at $(3,3)$ (§5, §9).
- $\dim(\text{orbit})=pq$ (§8b), and the orbit tangent is an exact $\tfrac12$-eigenspace at every non-zero critical point (§8c).
- At $(3,3)$: $\dim E(\tfrac12)=18$ against orbit $9$, and it is an eigenvalue coincidence, with $\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$ (§9).

**Citable with the condition named.** $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ attained exactly on the orbit tangent, and $\dim E(\tfrac12)=pq$, for $p,q\ge3$ with $(p,q)\ne(3,3)$, **conditional on (i) the $O(p)\times O(q)$-irreducibility of the ten summands, which at $p$ or $q\in\{3,4\}$ is asserted in the source and supplied here by exact commutant computation rather than argument, and (ii) $L_e=0$ on the four summands, which is attested and verified exhaustively at 24 splits but not derived on file.**

**Not citable as written.** *"$S^p\times S^q$ is Morse–Bott nondegenerate"* directly from this block: the step needs [Lemma L24](../findings/second-order.md)'s $\mathrm{Hess}(P|_S)=6\theta(L_e-\tfrac12\mathrm{Id})$, which the block does not name (§8d). Cite L27 **and** L24 together, as [second-order.md](../findings/second-order.md):39 already does.

**Not established anywhere on file, and no consumer should assume it.** Anything at $q\le2$ or $q=1$; and any margin figure taken from $\tfrac12-\mu$, which is the gap to one summand and not to the spectrum (§10 T5).

## Verdict

**`GAP`.**

The lemma is right, its two hardest steps are right, and I could reproduce every arithmetical claim in it by hand, the degree-four dimension identity, the trace identity closing to zero identically in $p,q$, all four discriminating figures, both $(3,3)$ commutant dimensions, all five tabulated spectra and a sixth at odd $n$ that the record does not carry. Two things keep it from `PROVEN`:

1. **The four zero eigenvalues have no derivation on file** (§7). Mechanisms are named, one of them in real detail; the six-case exhaustion and the two Bianchi applications are not written, and route (b) for $\mathrm{Weyl}_p$ does not visibly close. These values are load-bearing both for the maximum and for the trace identity's determination of $-\mu$.
2. **"Distinct Young labels, so multiplicity-free" does not follow** (§3). Distinctness gives non-isomorphism; irreducibility at $p$ or $q\in\{3,4\}$ is a separate input, asserted in the source and supplied here by exact commutant computation, as [r34](../reviews/REVIEW_r34.md)'s own M8 says in as many words.

Plus one repairable citation gap (§8d, the Hessian bridge), one hypothesis correction (§9, Prop 4.6's $k,l\ne6$, substance intact, citation loose), and **four live carriers of superseded content** (§10), the worst being [nondegeneracy.md](../findings/nondegeneracy.md):104–107, inside Lemma L26's canonical block, asserting in the present tense that the two statements L27 proves *"rest on the full multiplicity list, which is verified numerically … and rigorous only at $n\le12$."*
