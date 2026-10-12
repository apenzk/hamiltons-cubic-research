# VERIFY v199, Lemma L26, the dangerous eigenvalue of the two-block spectrum

**Cold read.** I received [BRIEF_L26.md](BRIEF_L26.md) with no prior knowledge of this result and rebuilt every claim from the definitions in [conventions.md](../findings/conventions.md). **No numerical work of any kind was done**, no script, no Sage, no Python, no floating point. Every number below is exact rational arithmetic performed by hand, and the one place the record's own history invites a scan (the five splits that missed $(3,4)$), was settled by solving an integer inequality instead. Log: [agent_logs/verify-L26-v199.log](../agent_logs/verify-L26-v199.log).

**The brief was truncated when I first read it.** Section C ended mid-sentence at *"…as free symbols, the same"*, cutting the three-block formula, the criticality clause and the whole *"What it does not reach"* paragraph. I had already read the block in situ at [findings/nondegeneracy.md](../findings/nondegeneracy.md) lines 78-106 before forming any verdict, so no verdict here was formed against the incomplete text; the brief has since been repaired to lines 78-106 and I re-read it, and the restored passage matches the in-situ text word for word.

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $X=\phi_\pi\odot\phi_\rho$ minus its $\Lambda^4$ part lies in $\mathrm{Weyl}_n$ | **PROVEN** |
| 1a | the block's stated reason ("support is disjoint index pairs" | **PROVEN FOR TRACE-FREENESS ONLY**), first Bianchi comes from the $\Lambda^4$ removal, not from disjointness |
| 2 | $X$ has coefficients $\tfrac23,\tfrac13,-\tfrac13$ on the three pairings | **PROVEN**, and it pins $\odot$ to the *unhalved* convention and the pairings to the order $(12\vert34),(13\vert24),(14\vert23)$ |
| 3 | $\lVert X\rVert^2=\tfrac43$ | **PROVEN** |
| 4 | $e\circ X=\lambda X$ with $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ for any three-block diagonal operator | **PROVEN**, and I supply the closed-form support argument the block delegates to an enumeration |
| 5 | $\mu=\dfrac{n-2}{2(p-1)(q-1)}$ | **PROVEN** |
| 6 | $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$ | **PROVEN** |
| 7 | excess $\tfrac1{2(n-3)}$ at $p=2$ | **PROVEN**, and it is a strict excess at every $n\ge4$ |
| 8 | "the family **reaches** $\tfrac12$ exactly at $p=2$ … and at $(3,3)$" ([results.md:434](../results.md)) | **BROKEN AS WORDED**, at $p=2$ the value is never attained |
| 9 | "exceeds at $p=2$, equals at $(3,3)$, never collapse them" ([nondegeneracy.md:89](../findings/nondegeneracy.md)) | **CORRECT, this is the reading the display forces** |
| 10 | "criticality is unused" ([results.md:138](../results.md)) | **BROKEN AS WORDED**, criticality is what produces the number $\mu$ |
| 11 | "proved for any three-block diagonal operator" | **PROVEN**, with the scope correction that inside $\mathcal W_n$ that family is one-dimensional |
| 12 | $\lambda_{\max}<\mu$ clears to $3p+2q-4-pq>0$ and factors as $(p-2)(q-3)<2$ | **PROVEN** |
| 13 | over $q\ge p\ge3$ that admits exactly $(3,3)$ and $(3,4)$ | **PROVEN** by hand, no search |
| 14 | gap $=1/(2\max(p,q)-2)$ off the two exceptions; $\tfrac1{12}$ at $(3,4)$ | **TRUE, AND HYPOTHESIS-DEBT IN THE CANONICAL COPY**, it is an upper bound on the whole spectrum, sourced only in [L27](../findings/nondegeneracy.md), which [results.md:429-435](../results.md) never cites |
| 15 | "it bounds $\lambda_{\max}$ from below only" | **PROVEN**, and both consumers ([L11](../findings/nondegeneracy.md), [L133](../results.md)) respect it |
| 16 | $\lambda_{\max}$ carries three incompatible senses inside [results.md](../results.md) | **CONFIRMED, and material** |
| 17 | $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ | **PROVEN for one normalisation of $W_{p,q}$ that the record never states**, and that constant is not $\theta$ |

**Summary.** Every mathematical claim in L26 is correct and I rebuilt all of it independently, including the eigenvector, the eigenvalue, the threshold, the coefficients, the norm, the factorisation and the two-point lattice count, but the canonical copy in [results.md](../results.md) carries the one word its own findings block forbids, asserts that criticality is unused where criticality is what fixes the number, and states a two-sided gap clause whose only source is [L27](../findings/nondegeneracy.md).

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

> **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

> $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself

> **$\#$ and $\mathrm{Ric}$** … $\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal

> **The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix.

> **$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$**, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$. So … $\mathrm{Alt}$ is self-adjoint and idempotent, and $\mathrm{Alt}(H)=0$ for every $H$ satisfying the first Bianchi identity

> **"Diagonal" means diagonal in coordinate $2$-planes $e_i\wedge e_j$** of an orthonormal frame of $\mathbb R^n$

> **$\mu$ here is [L26](nondegeneracy.md)'s dangerous eigenvalue $\frac{n-2}{2(p-1)(q-1)}$**, a fourth sense of a letter this table already flags as carrying three.

> **Padding commutes with $Q$**, and preserves both the norm and $\theta$.

The symbol $\odot$ is tabled only for vectors, inside the Li quotation (*"With $u\odot v=u\otimes v+v\otimes u$"*) and never for bivectors. §3 shows L26's own recorded numbers pin the same unhalved reading, so I adopt it; that it has to be recovered from the numbers rather than read from the table is an inventory item, booked in §1.

## 1. Hypothesis inventory

| hypothesis | stated where | used where | verdict |
| --- | --- | --- | --- |
| $p,q\ge2$ | both copies of the statement | guarantees a coordinate $2$-plane exists inside each block; nothing else | **stated and used**; at $p=2$ the $p$-block has exactly one plane, which is enough |
| $n=p+q$, i.e. the **unpadded** dimension | both copies | the closed form is read at this $n$ | **stated and used, and load-bearing**, see §8, padding |
| $e$ is *the sphere product's* $e$ | both copies | fixes $\varepsilon_{PP},\varepsilon_{QQ},\varepsilon_{PQ}$, hence the number $\mu$ | **stated and used** |
| $e$ is diagonal in coordinate $2$-planes with three block values | the Argument only | the entire eigenvector computation | **used in every step**; it is the real hypothesis and the Statement never names it |
| criticality, $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ | the Argument | fixes the scale of $e$, and only that | **used**, contradicting [results.md:138](../results.md)'s "criticality is unused"; see §6 |
| the normalisation of $W_{p,q}$ behind the constant $\frac{n-1}{pq}$ | **nowhere** | needed for that display to have a truth value | **USED, NEVER STATED**, see §10 |
| $\odot$ unhalved | **nowhere** (conventions tables it for vectors only) | the coefficients $\tfrac23,\tfrac13,-\tfrac13$ and $\lVert X\rVert^2=\tfrac43$ | **USED, NEVER STATED**; the halved reading gives $\lVert X\rVert^2=\tfrac13$ |
| $q\ge p$ | the gap sentence, and only there | the substitution $\lambda_{\max}=\frac{q-2}{2(q-1)}$ inside the criterion | **stated and used, and indispensable**, see §7, where I exhibit $(5,3)$ |
| the full $L_e$ spectrum at $S^p\times S^q$ | **not in [results.md:429-435](../results.md)** | the gap clause, which is two-sided | **USED, NOT CITED IN THE CANONICAL COPY**, see §9 |
| $p,q\ge5$ (Nienhaus Prop. 4.6) | the Sources line | identifies $X$'s summand as $\Lambda^2\otimes\Lambda^2$ | **stated**, but consumed by [L27](../findings/nondegeneracy.md) at $p,q\ge3$; L27 repairs the $m=3,4$ case itself, see §11 |

No hypothesis is stated and left unused. Two are used and never stated, and both are normalisations.

## 2. The object, written out

Take $1,2\in P$ and $3,4\in Q$, $\pi=e_1\wedge e_2$, $\rho=e_3\wedge e_4$. With $\odot$ unhalved, $R_{ijkl}=\phi_{ij}\psi_{kl}+\psi_{ij}\phi_{kl}$ where $\phi_{12}=1$, $\psi_{34}=1$, so the only nonzero entries are $R_{1234}=R_{3412}=1$.

First Bianchi fails: $R_{1234}+R_{1342}+R_{1423}=1+0+0=1$. So $\mathrm{Alt}(R)_{1234}=\tfrac13$, and

$$X=R-\mathrm{Alt}(R):\qquad X_{1234}=\tfrac23,\qquad X_{1342}=-\tfrac13,\qquad X_{1423}=-\tfrac13 .$$

Reading the three pairings in the order $(12\vert34),(13\vert24),(14\vert23)$ (that is, listing $X_{1234},X_{1324},X_{1423}$) and using $X_{1324}=-X_{1342}$, the coefficients are

$$\tfrac23,\qquad \tfrac13,\qquad -\tfrac13,$$

exactly as recorded. **Claim 2 is PROVEN**, and the check is sharp in two directions: with the halved $\odot$ the triple is $\tfrac13,\tfrac16,-\tfrac16$, and with the pairings listed as $X_{1234},X_{1342},X_{1423}$ the triple is $\tfrac23,-\tfrac13,-\tfrac13$. The record's own [second-order.md:915](../findings/second-order.md) states the same fact from the other side, *"whose recorded coefficients $\tfrac23,\tfrac13,-\tfrac13$ become the signed triple $(\tfrac23,-\tfrac13,-\tfrac13)$ because first Bianchi reads $T_{1234}-T_{1324}+T_{1423}=0$"*, so the two readings are both on the record and correctly reconciled there.

**Norm.** In the orthonormal pair basis $\{\varphi_{ab}\}_{a<b}$, $X$ has six nonzero matrix entries: $X_{(12)(34)}=X_{(34)(12)}=\tfrac23$, $X_{(13)(24)}=X_{(24)(13)}=\tfrac13$, $X_{(14)(23)}=X_{(23)(14)}=-\tfrac13$. Plain Frobenius on the pair matrix gives

$$\lVert X\rVert^2=2\!\left(\tfrac49\right)+2\!\left(\tfrac19\right)+2\!\left(\tfrac19\right)=\tfrac{12}9=\tfrac43 .$$

**Claim 3 is PROVEN.**

## 3. $X\in\mathrm{Weyl}_n$, trace-freeness and first Bianchi, separately

**Pair symmetry.** $R\in S^2(\Lambda^2)$ by construction and $\Lambda^4\subset S^2(\Lambda^2)$, so $X$ is pair-symmetric. ✓

**First Bianchi.** $\mathrm{Alt}$ is an idempotent projection, so $\mathrm{Alt}(X)=\mathrm{Alt}(R)-\mathrm{Alt}(R)=0$, which by the quoted convention is exactly the first Bianchi identity. ✓ **This is delivered by the $\Lambda^4$ removal and by nothing else.**

**Trace-freeness.** $\mathrm{Ric}(R)_{jl}=\sum_i R_{ijil}=\sum_i(\phi_{ij}\psi_{il}+\psi_{ij}\phi_{il})$. Each product needs $i\in\{1,2\}$ and $i\in\{3,4\}$ simultaneously, so every term vanishes. ✓ And $\mathrm{Ric}(\mathrm{Alt}\,R)=0$ because a totally antisymmetric tensor has $A_{ijil}=0$ termwise. ✓

**Verdict on claim 1a.** The block's clause *"its Ricci part vanishes because its support is disjoint index pairs"* is a correct and complete justification of trace-freeness and of nothing else. First Bianchi is not a consequence of disjoint support, the untouched $\phi_\pi\odot\phi_\rho$ has disjoint support and violates Bianchi by $1$, as computed above. The statement is saved by the words *"with its $\Lambda^4$ component removed"*, so this is a **completeness note on the stated reason, not a gap**: the two conditions have two different mechanisms and the block names one.

$X\ne0$ since $\lVert X\rVert^2=\tfrac43$, so the claim is non-vacuous at every $p,q\ge2$, including $n=4$.

## 4. The eigenvector, derived in full

**The operator.** For diagonal $e$ with $e_{\gamma\epsilon}=\varepsilon_\gamma\delta_{\gamma\epsilon}$, polarising $Q=W^2+W^\#$ gives

$$(e\circ X)_{\alpha\beta}=\underbrace{\tfrac12(\varepsilon_\alpha+\varepsilon_\beta)X_{\alpha\beta}}_{\text{(I)}}\;+\;\underbrace{\tfrac12\sum_{\gamma,\delta,\zeta}\varepsilon_\gamma\,c_{\alpha\gamma\delta}\,c_{\beta\gamma\zeta}\,X_{\delta\zeta}}_{\text{(II)}} ,$$

the two $\#$ cross terms coinciding because $c$ is antisymmetric in its last two slots on both factors. Term (II) is the block's $T_{ab}=\sum_{m,r,t}c_{amr}\varepsilon_rc_{brt}X_{tm}$ up to the factor $-\tfrac12$ and a slot transposition, which is internal bookkeeping.

**Structure constants.** With $v_{ij}=E_{ij}-E_{ji}$ (unit under the half-trace pairing), $[v_{ij},v_{jk}]=v_{ik}$, so $c$ is $\pm1$ on triangles of planes pairwise sharing one index and zero otherwise. **The block's claim that "the plane $r$ is determined by $a$ and $m$ as the third side of a triangle" is exactly this and is correct.**

**The support closure, the step the block delegates to an enumeration, proved here in closed form.** Term (II) is nonzero only if $X_{\delta\zeta}\ne0$, i.e. $\delta\sqcup\zeta=\{1,2,3,4\}$. Then $\gamma$ must share exactly one index with $\delta$ and exactly one with $\zeta$, so $\gamma\subset\{1,2,3,4\}$ with one index in each. Write $\delta=\{a,b\}$, $\zeta=\{c,d\}$, $\gamma=\{a,c\}$. The triangle $(\gamma,\delta)$ lives on $\{a,b,c\}$ with third side $\alpha=\{b,c\}$, and the triangle $(\gamma,\zeta)$ lives on $\{a,c,d\}$ with third side $\beta=\{a,d\}$. Hence $\alpha\sqcup\beta=\{a,b,c,d\}$, a pairing of the four core indices. Term (I) is supported on $X$'s support, which is the same three pairings. **So $e\circ X$ is supported on the three pairings, no ambient index enters, and checking three entries is a complete proof.** This is stronger than the block's justification: no spare indices are needed at all, so the result holds already at $n=4$.

**Entry $(12\vert34)$.** (I) $=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})\cdot\tfrac23$. For (II), $\gamma\in\{(13),(14),(23),(24)\}$, each of value $\varepsilon_{PQ}$:

| $\gamma$ | $c_{(12)\gamma\delta}$, $\delta$ | $c_{(34)\gamma\zeta}$, $\zeta$ | $X_{\delta\zeta}$ | product |
| --- | --- | --- | --- | --- |
| $(13)$ | $-1$, $(23)$ | $-1$, $(14)$ | $-\tfrac13$ | $-\tfrac13\varepsilon_{PQ}$ |
| $(14)$ | $-1$, $(24)$ | $+1$, $(13)$ | $+\tfrac13$ | $-\tfrac13\varepsilon_{PQ}$ |
| $(23)$ | $+1$, $(13)$ | $-1$, $(24)$ | $+\tfrac13$ | $-\tfrac13\varepsilon_{PQ}$ |
| $(24)$ | $+1$, $(14)$ | $+1$, $(23)$ | $-\tfrac13$ | $-\tfrac13\varepsilon_{PQ}$ |

(II) $=\tfrac12\left(-\tfrac43\varepsilon_{PQ}\right)=-\tfrac23\varepsilon_{PQ}$, and the total is $\tfrac23\left[\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}\right]=\lambda X_{(12)(34)}$.

**Entry $(13\vert24)$.** (I) $=\varepsilon_{PQ}\cdot\tfrac13$. For (II), $\gamma\in\{(12),(14),(23),(34)\}$:

| $\gamma$ | $\varepsilon_\gamma$ | $c_{(13)\gamma\delta}$, $\delta$ | $c_{(24)\gamma\zeta}$, $\zeta$ | $X_{\delta\zeta}$ | product |
| --- | --- | --- | --- | --- | --- |
| $(12)$ | $\varepsilon_{PP}$ | $+1$, $(23)$ | $-1$, $(14)$ | $-\tfrac13$ | $+\tfrac13\varepsilon_{PP}$ |
| $(14)$ | $\varepsilon_{PQ}$ | $-1$, $(34)$ | $+1$, $(12)$ | $+\tfrac23$ | $-\tfrac23\varepsilon_{PQ}$ |
| $(23)$ | $\varepsilon_{PQ}$ | $-1$, $(12)$ | $+1$, $(34)$ | $+\tfrac23$ | $-\tfrac23\varepsilon_{PQ}$ |
| $(34)$ | $\varepsilon_{QQ}$ | $+1$, $(14)$ | $-1$, $(23)$ | $-\tfrac13$ | $+\tfrac13\varepsilon_{QQ}$ |

(II) $=\tfrac16(\varepsilon_{PP}+\varepsilon_{QQ})-\tfrac23\varepsilon_{PQ}$, and the total is $\tfrac16(\varepsilon_{PP}+\varepsilon_{QQ})-\tfrac13\varepsilon_{PQ}=\lambda\cdot\tfrac13=\lambda X_{(13)(24)}$.

**Entry $(14\vert23)$.** (I) $=-\tfrac13\varepsilon_{PQ}$. For (II), $\gamma\in\{(12),(13),(24),(34)\}$:

| $\gamma$ | $\varepsilon_\gamma$ | $c_{(14)\gamma\delta}$, $\delta$ | $c_{(23)\gamma\zeta}$, $\zeta$ | $X_{\delta\zeta}$ | product |
| --- | --- | --- | --- | --- | --- |
| $(12)$ | $\varepsilon_{PP}$ | $+1$, $(24)$ | $-1$, $(13)$ | $+\tfrac13$ | $-\tfrac13\varepsilon_{PP}$ |
| $(13)$ | $\varepsilon_{PQ}$ | $+1$, $(34)$ | $+1$, $(12)$ | $+\tfrac23$ | $+\tfrac23\varepsilon_{PQ}$ |
| $(24)$ | $\varepsilon_{PQ}$ | $-1$, $(12)$ | $-1$, $(34)$ | $+\tfrac23$ | $+\tfrac23\varepsilon_{PQ}$ |
| $(34)$ | $\varepsilon_{QQ}$ | $-1$, $(13)$ | $+1$, $(24)$ | $+\tfrac13$ | $-\tfrac13\varepsilon_{QQ}$ |

(II) $=-\tfrac16(\varepsilon_{PP}+\varepsilon_{QQ})+\tfrac23\varepsilon_{PQ}$, and the total is $-\tfrac16(\varepsilon_{PP}+\varepsilon_{QQ})+\tfrac13\varepsilon_{PQ}=-\tfrac13\lambda=\lambda X_{(14)(23)}$.

All three entries carry the same factor. **Claim 4 is PROVEN:**

$$e\circ X=\lambda X,\qquad \lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ},$$

for every operator diagonal in coordinate $2$-planes with three block values, criticality nowhere used.

## 5. The number $\mu$, derived independently

The sphere product's Weyl tensor is diagonal in coordinate planes with entries $K_{ij}-\frac{\lambda_{\mathrm{Ein}}}{n-1}$. Normalising the Einstein constant to $n-1$:

$$\varepsilon_{PP}=\frac{q}{p-1},\qquad \varepsilon_{QQ}=\frac{p}{q-1},\qquad \varepsilon_{PQ}=-1 .$$

**Ricci-flatness check** (the two conditions that cut the three-block family down to a line): for $i\in P$, $(p-1)\varepsilon_{PP}+q\varepsilon_{PQ}=q-q=0$; for $i\in Q$, $(q-1)\varepsilon_{QQ}+p\varepsilon_{PQ}=p-p=0$. ✓

**Criticality, derived rather than assumed.** For a coordinate-diagonal operator, $(W^\#)_{(ij)(ij)}=\sum_{k\ne i,j}\varepsilon_{ik}\varepsilon_{jk}$. On a $P$-plane, $\varepsilon_{PP}^2+(p-2)\varepsilon_{PP}^2+q=\frac{q^2}{p-1}+q=\frac{q(n-1)}{p-1}=(n-1)\varepsilon_{PP}$. On a $Q$-plane, symmetrically $(n-1)\varepsilon_{QQ}$. On a mixed plane, $1-(p-1)\varepsilon_{PP}-(q-1)\varepsilon_{QQ}=1-q-p=(n-1)\varepsilon_{PQ}$. So $Q(W)=(n-1)W$ in this normalisation, and $e=W/(n-1)$:

$$\varepsilon^e_{PP}=\frac{q}{(p-1)(n-1)},\qquad \varepsilon^e_{QQ}=\frac{p}{(q-1)(n-1)},\qquad \varepsilon^e_{PQ}=\frac{-1}{n-1},$$

which are **verbatim the three values the record states** at [nondegeneracy.md:722](../findings/nondegeneracy.md), reached here without reading them.

**Substituting into §4's formula.** The numerator is
$$\tfrac12\!\left(\frac{q}{p-1}+\frac{p}{q-1}\right)+1=\frac{q(q-1)+p(p-1)+2(p-1)(q-1)}{2(p-1)(q-1)}=\frac{n^2-3n+2}{2(p-1)(q-1)}=\frac{(n-1)(n-2)}{2(p-1)(q-1)},$$
so dividing by $n-1$,
$$\mu=\frac{n-2}{2(p-1)(q-1)} .$$
**Claim 5 is PROVEN.**

**Two independent cross-checks that the $\varepsilon$'s are the record's.** With $\lVert W\rVert^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)}$ in the same normalisation, $\theta=\frac{n-1}{\lVert W\rVert}$ gives $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, which is [problem.md:170](../findings/problem.md)'s Nienhaus value word for word; and at $p=q=n/2$ it collapses to $\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$, at $p=\frac{n-1}2$ to $\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\Theta_n^2$ at odd $n$, both matching [conventions.md](../findings/conventions.md).

**Threshold.** $\mu\ge\tfrac12\iff n-2\ge(p-1)(q-1)\iff p+q-2\ge pq-p-q+1\iff pq-2p-2q+4\le1\iff(p-2)(q-2)\le1$. Equivalently $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, the identity the record uses at [nondegeneracy.md:447](../findings/nondegeneracy.md) and in [L27](../findings/nondegeneracy.md). **Claim 6 is PROVEN.**

**Excess.** At $p=2$, $q=n-2$, so $\mu=\frac{n-2}{2(n-3)}$ and $\mu-\tfrac12=\frac{(n-2)-(n-3)}{2(n-3)}=\frac1{2(n-3)}$. **Claim 7 is PROVEN**, and it is **strictly positive at every $n\ge4$**.

## 6. The two statements of the binding cases, which one the display forces

**The display forces statement C.** $(p-2)(q-2)\le1$ over $p,q\ge2$ has exactly two kinds of solution and they are of different kinds:

- $\min(p,q)=2$: $(p-2)(q-2)=0<1$, so the inequality is **strict**, and §5 computes the strictness exactly as $\mu-\tfrac12=\frac1{2(n-3)}>0$. Witness in closed form: at $(2,4)$, $n=6$, $\mu=\frac{4}{2\cdot1\cdot3}=\frac23\ne\tfrac12$.
- $(3,3)$: $(p-2)(q-2)=1$, so the inequality is an **equality**, and $\mu=\frac{4}{2\cdot2\cdot2}=\tfrac12$ exactly.

This distinction is not cosmetic. By [conventions.md](../findings/conventions.md)'s own entry (*"that kernel is the eigenspace **at** $\tfrac12$) so an eigenvalue **above** $\tfrac12$ off the orbit costs maximality and contributes nothing to the kernel"*, only the equality is degeneracy. So **claim 9 is CORRECT and claim 8 is BROKEN as worded.**

**Discrepancy, all three tests cleared.**

1. *Located exactly*: [results.md:434](../results.md), *"So the family reaches $\tfrac12$ exactly at $p=2$"*.
2. *Failure exhibited in closed form*: at $p=2$ the family never takes the value $\tfrac12$; $\mu-\tfrac12=\frac1{2(n-3)}>0$ at every $n\ge4$, e.g. $\tfrac16$ at $(2,4)$.
3. *Argued the opposite*: the same sentence continues *"where it gives the recorded excess $\tfrac1{2(n-3)}$"*, so a reader who finishes the clause is corrected, and *"reaches"* can be strained into *"reaches the threshold $\mu\ge\tfrac12$"*. That defence fails on the record's own evidence: [nondegeneracy.md:437](../findings/nondegeneracy.md) names this exact word as *"the seed of the error"* that *"inverted [L11] for two revisions"*, and [nondegeneracy.md:89](../findings/nondegeneracy.md) instructs that the two cases *"must never be collapsed into a word like 'reaches'"*.

**Verdict.** The canonical statement in [results.md](../results.md) still carries the wording the findings block forbids, and it is the copy a consumer quotes. Correction: replace with *"$\mu$ exceeds $\tfrac12$ at $\min(p,q)=2$, by $\tfrac1{2(n-3)}$, and equals it at $(3,3)$."*

**A second, smaller defect in the same clause.** Both [results.md:138](../results.md) and [results.md:434](../results.md) say *"at $p=2$"*, but the statement's own hypothesis is *"$p,q\ge2$"* with **no ordering**, and $\mu$ is symmetric in $p$ and $q$. So $q=2$ with $p$ arbitrary is equally a solution and is not named. [INDEX-results.md:26](../findings/INDEX-results.md) and [L11](../findings/nondegeneracy.md) both write $\min(p,q)=2$, which is the correct form.

## 7. The gap clause, factorisation and lattice count

**What $\lambda_{\max(p,q)}$ is.** The block never defines it. It is recoverable: the gap $\tfrac12-\lambda_{\max(p,q)}=\frac1{2\max(p,q)-2}$ forces $\lambda_M=\frac{M-2}{2(M-1)}$ with $M=\max(p,q)$, which is [L27](../findings/nondegeneracy.md)'s value on $S^2_0(\mathbb R^M)$ and [LEDGER.md:774](../findings/LEDGER.md)'s $\lambda_2$. At $M=4$ it is $\tfrac13$, as the block states. ✓

**The comparison.** $\lambda_M<\mu$ with $M=q$:
$$\frac{q-2}{2(q-1)}<\frac{p+q-2}{2(p-1)(q-1)}\iff(q-2)(p-1)<p+q-2\iff pq-3p-2q+4<0\iff 3p+2q-4-pq>0 .$$
**The block's clearing is correct.**

**The factorisation.** $(p-2)(q-3)=pq-3p-2q+6$, so $pq-3p-2q+4=(p-2)(q-3)-2$ and the condition is exactly $(p-2)(q-3)<2$. **Claim 12 is PROVEN, the factorisation is an identity, not an approximation.**

**The lattice count, done by hand.** Put $u=p-2\ge1$, $v=q-3\ge0$; $q\ge p\ge3$ becomes $v\ge u-1$. Need $uv\le1$.

- $v=0$: then $q=3$, and $q\ge p\ge3$ forces $p=3$. Gives $(3,3)$, with $uv=0$.
- $v\ge1$: $uv\le1$ forces $u=v=1$, i.e. $(p,q)=(3,4)$. Every $u\ge2$ or $v\ge2$ with the other $\ge1$ gives $uv\ge2$.

**Exactly $(3,3)$ and $(3,4)$. Claim 13 is PROVEN, by an integer argument and no search.** At $(3,4)$, $\mu=\frac5{2\cdot2\cdot3}=\tfrac5{12}$ against $\lambda_4=\tfrac13$, and $\tfrac12-\tfrac5{12}=\tfrac1{12}$. ✓

**The equality locus, which the record does not name and which explains the five misses better than "a single lattice point" does.** $(p-2)(q-3)=2$ over $q\ge p\ge3$ gives $(u,v)\in\{(1,2),(2,1)\}$, i.e. $(3,5)$ and $(4,4)$, **two of the five splits the block lists as having missed the exception**. There $\mu=\lambda_M$ exactly: at $(3,5)$, $\mu=\frac{6}{2\cdot2\cdot4}=\tfrac38=\lambda_5$; at $(4,4)$, $\mu=\frac6{2\cdot3\cdot3}=\tfrac13=\lambda_4$. So those two scans did not merely miss a lattice point, they landed on the boundary of the region and read a tie as a non-event. The gap clause is nonetheless **correct at both**, since $\tfrac12-\mu=\tfrac12-\lambda_M=\frac1{2M-2}$ there.

**A live trap the block creates and its own range clause defuses.** The criterion $(p-2)(q-3)<2$ is **not symmetric in $p$ and $q$**, while both $\mu$ and $\lambda_{\max(p,q)}$ are. Witness: $(p,q)=(5,3)$ gives $(p-2)(q-3)=3\cdot0=0<2$, so the criterion declares an exception, while in fact $M=5$ and $\lambda_5=\tfrac38=\mu$, so $\lambda_{\max}<\mu$ is **false**. Applying the three-part protocol: located at [nondegeneracy.md:89](../findings/nondegeneracy.md), *"which factors as $(p-2)(q-3)<2$"*; exhibited at $(5,3)$; and the opposite argued, the very next clause reads *"over $q\ge p\ge3$"*, which rules $(5,3)$ out of range, and the conclusion, an unordered exception list, is correct. **Reported as a trap for quotation, not as a defect**: the criterion loses its truth value the moment it is quoted without its ordering hypothesis.

**Cross-check against the record's own spectra**, at [nondegeneracy.md:708-712](../findings/nondegeneracy.md), which I read rather than computed. At $(3,7)$: $\mu=\frac8{2\cdot2\cdot6}=\tfrac13$ and the table shows $\pm\tfrac13$; $\lambda_3=\tfrac14$ and $\lambda_7=\tfrac5{12}$, both present; gap $\tfrac12-\tfrac5{12}=\tfrac1{12}=\frac1{2\cdot7-2}$ ✓. At $(4,6)$: $\mu=\tfrac4{15}$ ✓, $\lambda_6=\tfrac25$, gap $\tfrac1{10}$ ✓. At $(5,5)$: $\mu=\tfrac14$ ✓, $\lambda_5=\tfrac38$, gap $\tfrac18$ ✓. The multiplicities also close: $\dim(\Lambda^2\!\otimes\!\Lambda^2)=\binom p2\binom q2$ is $63$ at $(3,7)$ and $100$ at $(5,5)$, matching the $+\mu$ rows.

## 8. The traps, answered by name

**$\ker W\ne0$ and padded objects.** $\varepsilon_{PP}=\frac q{p-1}>0$, $\varepsilon_{QQ}=\frac p{q-1}>0$, $\varepsilon_{PQ}=-1\ne0$, so $\ker W_{p,q}=0$ at every $p,q\ge2$ and no eigenvalue-zero screen is vacuous here. Padding: by [conventions.md](../findings/conventions.md), *"Padding commutes with $Q$, and preserves both the norm and $\theta$"*, so the padded $e$ has the same three block values on the original planes and $0$ on the pad, and $X$, built inside the original block, remains an eigenvector at the **same** $\mu$. The closed form $\frac{n-2}{2(p-1)(q-1)}$ read at the *ambient* dimension would therefore be wrong. **The hypothesis "$n=p+q$" is stated in both copies and this is exactly what it buys.** [L11](../findings/nondegeneracy.md) records the consequence (*"At a padded dimension the $p=2$ family IS degenerate"*) so the record already knows the dimension is part of the statement.

**Every stated boundary.** $p=2$: checked in §5 and §6, strict excess, and the $p$-block has exactly one plane, which is all $\pi$ needs. $(3,3)$: $\mu=\tfrac12$ exactly. $(3,4)$: $\mu=\tfrac5{12}>\tfrac13=\lambda_4$, gap $\tfrac1{12}$. $(2,2)$, $n=4$: $\mu=\frac2{2\cdot1\cdot1}=1$, and the record's own recorded spectrum $(-1)^4,(\tfrac12)^4,1^2$ carries $1$ at multiplicity $2$, consistent, and the four core indices exhaust $\mathbb R^4$ so the §4 support argument needs no spares. $q\ge p$ against unordered pairs: §7, witness $(5,3)$.

**A claim proven on a subfamily and used in general.** Two candidates. (i) The Sources line grants the $\Lambda^2\!\otimes\!\Lambda^2$ identification only *"for $p,q\ge5$"* while [L27](../findings/nondegeneracy.md) consumes it at $p,q\ge3$, §11. (ii) The gap clause is a whole-spectrum statement carried inside a lemma whose proof exhibits one vector, §9. Neither is a false claim; both are scope mismatches in the citation.

**A hypothesis stated but never used.** None found. The Statement's $\lVert X\rVert^2=\tfrac43$ is a recorded datum rather than a hypothesis, and it is consumed downstream at [second-order.md:915](../findings/second-order.md).

**A step using a hypothesis never stated.** Two, both normalisations: $\odot$ unhalved (§2) and the scale of $W_{p,q}$ behind $\frac{n-1}{pq}$ (§10).

**A universal claim with no witness.** The gap clause quantifies over all $p,q\ge3$ outside two points. Its witness is not in L26, §9.

**An imported theorem whose hypotheses were never checked against the object.** L26 imports nothing into its own proof; the only import is Nienhaus Prop. 4.6 in the Sources line, and its stated range is honestly narrower than the consumer's (§11). I found no analogue of the unital-algebra failure the brief warns of: the two structural facts used here (total antisymmetry of $c$ and the halved Böhm–Wilking $\#$), are both tabled in [conventions.md](../findings/conventions.md) and both hold on $\mathcal W_n$ without a unit.

**Symbol collisions.** $\mu$: [conventions.md](../findings/conventions.md) already tables L26's $\mu$ as *"a fourth sense of a letter this table already flags as carrying three"*, and every use inside this block is that sense, clean. $X$: local, defined in the first sentence; distinct from $S_{XYZ}$'s slots and from L33's bivector $x$. $\pi,\rho$: defined in the first sentence; $\rho$ collides with the Ricci form in the Bourguignon–Karcher quotation and with a representation in [L47](../findings/problem.md), but both are far away. $e$: [conventions.md](../findings/conventions.md)'s $W/\theta$, used correctly, though $e_i$ for basis vectors sits in the same sentence. $\lambda$: the three-block eigenvalue here against the Einstein constant elsewhere. **The one that bites is $\lambda_{\max}$, and it is material**, see §12.

## 9. The direction of the bound, and what each consumer may cite

**The lemma exhibits one eigenvector.** That yields $\lambda_{\max}(L_e)\ge\mu$ and $\dim E(\mu)\ge1$. It yields **no** upper bound on anything, because no eigenvector does. **Claim 15 is PROVEN and the block states it correctly** in *"What it does not reach, and this is the point"*.

**[L133](../results.md) may cite L26 for its direction, and does.** L133's claim is that a supremum *"is attained on [Lemma L26](../findings/nondegeneracy.md)'s direction in every $(2,2)$-split four-subset"*. Attainment is an existence statement (a lower bound on a supremum) which is exactly what an exhibited eigenvector supplies. The matching upper bound is L133's own, routed through [L121](../findings/second-order.md) and the $\tfrac29$ identity at [second-order.md:1249](../findings/second-order.md). **Legitimate.**

**[L11](../findings/nondegeneracy.md) needs an upper bound and does not take it from L26.** Its proof paragraph cites L26 for the closed forms $\mu$ and $\tfrac12-\mu$ only, the classification of which splits have $\mu\ge\tfrac12$, which is a statement about **this family** and is entirely within L26's reach, and then says *"[Lemma L27] then shows that in the remaining range $\tfrac12$ is attained on the orbit tangent alone"*. **The upper bound is routed to L27 explicitly. Legitimate**, and [INDEX-results.md:26](../findings/INDEX-results.md) records the same routing.

**But the gap clause inside L26 itself is an upper-bound claim.** *"For $p,q\ge3$ other than $(3,3)$ and $(3,4)$ the gap is $1/(2\max(p,q)-2)$"* asserts that **nothing else in the spectrum** sits between $\lambda_M$ and $\tfrac12$. That is precisely what L26's proof cannot deliver. The findings block discharges it, the *"What it does not reach"* paragraph routes it to [L27](../findings/nondegeneracy.md), *"which has since made a theorem at every $p,q\ge3$ with $(p,q)\ne(3,3)$"*, exactly the clause's range. **The canonical copy at [results.md:429-435](../results.md) carries the gap clause and cites nothing.**

**Discrepancy, all three tests.** (1) Located at [results.md:434](../results.md). (2) Concretely, a reader given only that block has an exhibited eigenvector at $\mu$ and is asked to believe a two-sided statement about the second-largest eigenvalue; nothing in the block bounds any other eigenvalue, and $L_e$ carries $1$ on $\langle W\rangle$, so even the sign of the claim is unavailable from what is written. (3) Against: the clause is **true**, and the whole record supports it. **So this is HYPOTHESIS-DEBT rather than a break**, the fix is one citation, not a new argument. **Claim 14: TRUE, DEBT IN THE CANONICAL COPY.**

## 10. Criticality, and the three-block generality

**"Proved for any three-block diagonal operator", checked against every step.** Step (1), $X\in\mathrm{Weyl}_n$: no operator involved. Step (2), the support closure: uses only that $e$ is diagonal in coordinate $2$-planes. Step (3), the three entries: uses only diagonality plus constancy on the three block types. **Claim 11 is PROVEN.**

**One scope correction it needs.** Among three-block diagonal operators, Ricci-flatness imposes $(p-1)\varepsilon_{PP}+q\varepsilon_{PQ}=0$ and $(q-1)\varepsilon_{QQ}+p\varepsilon_{PQ}=0$ (two conditions on three parameters) and first Bianchi is automatic (all three terms of $\mathrm{Alt}$ vanish on a coordinate-diagonal operator). **So inside $\mathcal W_n$ the three-block diagonal operators are exactly the line $\mathbb R W_{p,q}$.** The advertised generality therefore lives outside $\mathcal W_n$, where $\circ$ is defined by the formula rather than by [conventions.md](../findings/conventions.md)'s $Q:\mathcal W_n\to\mathcal W_n$. This is true and harmless, but it means the generality reduces, on the record's own domain, to homogeneity along one ray.

**"Criticality is unused", checked against every step.** Steps (1)-(3) use none. Step (4), the collapse $\lambda\to\mu$, uses it: $\lambda$ is homogeneous of degree $1$ in the $\varepsilon$'s, so it has no numerical value until $e$'s scale is fixed, and $e=W/\theta$ is fixed by $Q(W)=\theta W$, criticality. **Discrepancy, all three tests.** (1) Located at [results.md:138](../results.md), *"Proved for any three-block diagonal operator; criticality is unused"*, placed immediately after the display of $\mu$. (2) Failure in closed form: take the three-block diagonal $A$ with $\varepsilon_{PP}=\varepsilon_{QQ}=\varepsilon_{PQ}=1$, i.e. $A=\mathrm{Id}$ on $\Lambda^2$; §4 gives $A\circ X=0\cdot X$, so the three-block hypothesis alone yields $\lambda=0$, not $\frac{n-2}{2(p-1)(q-1)}$. (3) Against: the sentence is true of the *eigenvector* claim, and [nondegeneracy.md:722](../findings/nondegeneracy.md) writes the same thing with the saving qualifier (*"so criticality is never used), it only fixes the number"*, and the L26 block itself says *"criticality enters only through $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$"*. **Verdict: claim 10 is BROKEN as worded in the landscape line, which drops the qualifier the two other copies carry, and asserts it about a sentence whose subject is $\mu$.** Correction: *"the eigenvector claim holds for any three-block diagonal operator and uses no criticality; criticality enters only to fix the scale of $e$, and so to fix the number $\mu$."*

**The normalisation of $W_{p,q}$.** From the $e$-values, $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ commits to $\varepsilon^W_{PQ}=-\frac1{pq}$, $\varepsilon^W_{PP}=\frac1{p(p-1)}$, $\varepsilon^W_{QQ}=\frac1{q(q-1)}$, a scale stated **nowhere on the record**. It is consistent, and $e=W/c$ is scale-free so $\mu$ is untouched, but the constant invites one specific misreading: [conventions.md](../findings/conventions.md) says *"at a critical point, $Q(W)=\theta W$"*, so a reader concludes $\theta_{p,q}=\frac{n-1}{pq}$. **That is false.** At $(3,3)$: $\frac{n-1}{pq}=\tfrac59=0.5\overline5$, while $\lVert W_{3,3}\rVert^2=\frac1{12}+\frac1{12}+\frac19=\frac5{18}$ gives $\theta=\frac{5/9}{\sqrt{5/18}}=\sqrt{10}/3=\theta_0(6)$, the record's own value. **Claim 17: PROVEN for one normalisation, which the record owes.**

## 11. Nienhaus, and the one imported hypothesis

The Sources line grants the summand identification *"for $p,q\ge5$"*. [L27](../findings/nondegeneracy.md) consumes it at $p,q\ge3$, and it is exactly at $p=3$, $q\in\{3,4\}$ that the exceptions live, so the narrow range is not idle. The debt is discharged inside L27, which supplies *"exact $O(m)$-commutant computation at $m=3,4$"*. So the chain closes, but not inside L26, and L26's Sources line does not say so. A one-clause note would fix it. Separately, [L27](../findings/nondegeneracy.md) once cited L26 for *"$-\mu$ and $+\mu$ on the two tensor summands"* where L26 supplies **one** eigenvector on $\Lambda^2\!\otimes\!\Lambda^2$ only; [LEDGER.md:772](../findings/LEDGER.md) and [LEDGER.md:810](../findings/LEDGER.md) record that this was caught and re-credited to the trace identity $\operatorname{tr}L_e=0$. **That repair is in place in the text I read**, L27 now says *"L26 supplying only the first of the two"*. Confirmed closed.

## 12. The $\lambda_{\max}$ collision, and it is material

Inside [results.md](../results.md) alone the symbol carries three senses:

| line | symbol | meaning | value |
| --- | --- | --- | --- |
| [138](../results.md) | $\lambda_{\max}$ | the largest eigenvalue of $L_e$ | $1$, on $\langle W\rangle$ |
| [434](../results.md) | $\lambda_{\max(p,q)}$ | $\frac{M-2}{2(M-1)}$, $M=\max(p,q)$ | $\tfrac13$ at $(3,4)$ |
| [441](../results.md) | $\lambda_{\max}(L_e\vert_{W^\perp})$ | the largest eigenvalue off $\langle W\rangle$ | $\tfrac12$ |

Six lines separate the second and third. The collision is material in both directions: read line 434's $\lambda_{\max(p,q)}$ in sense three and *"$\mu=\tfrac5{12}$ overtakes $\lambda_{\max}$"* becomes false, since $\tfrac5{12}<\tfrac12$; read the findings block's *"the comparison $\lambda_{\max}<\mu$"* in sense one and it is false at every split, since $L_e$ carries $1$. **Neither sense two nor its value is defined anywhere in [results.md](../results.md).** [conventions.md](../findings/conventions.md) tables $\mu$ but not $\lambda_m$. **Claim 16 CONFIRMED**; the fix is to name $\lambda_m=\frac{m-2}{2(m-1)}$ in the conventions table, since [L27](../findings/nondegeneracy.md), [L26](../findings/nondegeneracy.md) and [LEDGER.md:796](../findings/LEDGER.md) all consume it.

## 13. What would falsify this, and what I did to look for it

**The object that would break the core lemma.** A pair of coordinate $2$-planes $\pi\subset P$, $\rho\subset Q$ for which $e\circ X$ has a nonzero component **off** the three pairings of $\pi\cup\rho$, that alone would destroy the eigenvector claim, since Term (I) can never cancel such a component. **What I did:** rather than enumerate plane types, I proved in §4 that no such object exists, by showing that $X_{\delta\zeta}\ne0$ together with two nonzero structure constants forces $\alpha\sqcup\beta=\{1,2,3,4\}$. The argument is closed-form and uses no dimension bound, so it also rules the object out at $n=4$ where the block's "two spare indices in each block" do not exist.

**The object that would break the gap clause.** A split $p,q\ge3$ with $(p,q)\notin\{(3,3),(3,4)\}$ at which $\mu>\lambda_{\max(p,q)}$. **What I did:** solved $(p-2)(q-3)<2$ over the integer cone $q\ge p\ge3$ by hand in §7, finding exactly two points, and separately located the equality locus $\{(3,5),(4,4)\}$, which shows the boundary is populated and where. **I did not re-run the scan that missed $(3,4)$**, and the analysis-only rule is why: the exception is a lattice question, and the lattice question has an answer in four lines.

**The object that would break the eigenvalue.** A three-block diagonal $e$ satisfying $Q(e)=e$ with block values other than §5's, this would give a second $\mu$ at the same $(p,q)$. **What I did:** derived $Q(W)=(n-1)W$ from the diagonal $\#$ formula on all three block types, and checked the resulting $\theta$ against [problem.md:170](../findings/problem.md) and against $\theta_0(n)$ and $\Theta_n$ at both parities. All three agree, so the block values are pinned.

## Verdict

**PROVEN, hypotheses corrected.**

The mathematics is right, all of it, and I rebuilt every step independently rather than checking arithmetic: $X\in\mathrm{Weyl}_n$, the coefficients and the norm, the eigenvector property for any three-block diagonal operator with a support argument stronger than the block's, the eigenvalue $\mu$, the threshold, the excess, the factorisation and the two-point lattice count.

Four corrections are owed, none of them a new argument:

1. **[results.md:434](../results.md) must lose the word "reaches"**, at $\min(p,q)=2$ the family exceeds $\tfrac12$ by $\frac1{2(n-3)}$ and never attains it. This is the word [nondegeneracy.md:437](../findings/nondegeneracy.md) already identifies as having inverted [L11](../findings/nondegeneracy.md) for two revisions, and the canonical copy still carries it. **Statement C, not statement A, is the reading the display forces.**
2. **[results.md:138](../results.md)'s "criticality is unused" must regain the qualifier** the other two copies carry: criticality is unused in the eigenvector claim and is exactly what produces the number $\mu$. Witness: $\varepsilon_{PP}=\varepsilon_{QQ}=\varepsilon_{PQ}=1$ gives $\lambda=0$.
3. **The gap clause carries HYPOTHESIS-DEBT in the canonical copy**, it is an upper bound on the whole spectrum, sourced only in [L27](../findings/nondegeneracy.md), whose range is exactly the clause's. The findings block discharges it; [results.md:429-435](../results.md) cites nothing.
4. **Two normalisations are used and never stated**: $\odot$ unhalved (pinned by $\tfrac23,\tfrac13,-\tfrac13$ and $\lVert X\rVert^2=\tfrac43$), and the scale of $W_{p,q}$ behind $\frac{n-1}{pq}$, which is not $\theta$, and is $\tfrac59$ against $\theta_{3,3}=\sqrt{10}/3$.

And two items for the traps index rather than for the statement: $\lambda_{\max}$ carries three senses inside [results.md](../results.md), sense two defined nowhere; and the criterion $(p-2)(q-3)<2$ is order-dependent, misfiring at $(5,3)$ the moment it is quoted without *"over $q\ge p\ge3$"*.

**No numerical work was done at any point in this verification.**
