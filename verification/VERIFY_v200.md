# VERIFY_v200, Lemma L21, cold verification

**Verifier v200, cold on [BRIEF_L21.md](BRIEF_L21.md).** The brief was read as given, with its three internal disagreements unlabelled; conventions were taken from [conventions.md](../findings/conventions.md). **No numerical work of any kind was done**, no script, no Sage, no Python, no floating point, and no re-diagonalisation of the four $F_\lambda$. Every positive claim below is closed-form hand algebra on objects the record already names. The one screen allowed by the standing rule was not needed and was not used. Log: [verify-L21-v200.log](../agent_logs/verify-L21-v200.log).

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | Schur gives $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$ with no multiplicity-free hypothesis | **PROVEN, HYPOTHESES CORRECTED**; it needs absolute irreducibility, which is never stated and does hold at $m\ge5$ |
| 2 | the type set and the multiplicities $20,20,6,10,4,1$ do not depend on $n$ | **PROVEN**, re-derived here by hand, no stability theorem used, valid at every $m\ge5$ |
| 3 | every $F_\lambda$ spectrum is identical across dimensions | **HYPOTHESIS-DEBT**, no argument on file, and the in-range exact evidence is **one** dimension, not three |
| 4 | the fifth row, "$0$ throughout" on the two higher types | **PROVEN**, both the degree argument and the image claim check out, separately |
| 5 | the two unnamed types are $4\,V_{(2,1)}\oplus 1\,V_{(2,2)}$, and $698+940=1638$ identically in $m$ | **PROVEN**, branching and the quartic identity verified by hand |
| 6 | section C's five-row table against section D's four-row table | **WITHDRAWN as a contradiction**, no false statement can be exhibited; re-reported as an incompleteness that makes D's own closing sentence unreachable from D's own table |
| 7 | "the stable range begins at $n-4\ge8$" (C) against "valid at every $n\ge9$" (D) | **C IS BROKEN, D IS RIGHT**, the governing threshold is $m\ge5$, i.e. $n\ge9$; $n=8$ genuinely fails |
| 8 | $T_u(SO(n).u)=2\cdot\text{trivial}\oplus4\cdot\text{vector}$, $\dim=4n-14$ | **GAP**, the $\mathfrak{so}(4)$ and $\mathfrak{so}(m)$ halves are right; $\mathfrak{stab}(u)\cap(\mathbb R^4\otimes\mathbb R^m)=0$ is asserted and never argued |
| 9 | the $\tfrac12\theta^*$-eigenspace **is** the orbit, block by block | **ONE INCLUSION PROVEN, THE OTHER INHERITS #3**, $T_u\mathcal O\subseteq E_{1/2}$ is [L24](../findings/second-order.md); equality is a dimension count off the disputed table |
| 10 | the conclusion is $\alpha\le\tfrac13$, with equality attained | **BOTH, AND CONSISTENTLY NORMALISED**, but both consumers inherit #3 |
| 11 | section A states no result | **BROKEN**, the canonical statement is reconstructed in §7 below |
| 12 | section B's landscape line as a summary of it | **UNFAITHFUL**, it drops the dimension hypothesis and asserts the unproved half |
| 13 | D's reduction of the whole obligation to one $20\times20$ block | **BROKEN**, the projection defining $\mathcal W_n$ acts in the vector, $\Lambda^2$ and $S^2_0$ blocks too |
| 14 | [L21.lean](../lean/HamiltonsCubic/Results/L21.lean) as machine-checking of the branching | **OVER-CITED**, it checks two dimension polynomials and some arithmetic; its "degree" theorem is $0<2\wedge1<2$ |

**Verdict: HYPOTHESIS-DEBT.** The structural half of L21 is real and I re-proved all of it by hand, the type set, the multiplicities, the annihilation of $940$ of the $1638$ dimensions, and the exhaustion identity in $m$. The spectral half (that the four $F_\lambda$ matrices themselves do not move with $m$), has no argument anywhere on the record, and the record's own in-range exact evidence for it is a single dimension. Everything L20 and L134 take from L21 rests on that one clause.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md):

- $\mathcal W_n$ is "the space of algebraic Weyl curvature operators on $\mathbb R^n$", of dimension "$\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$".
- $Q(W)$ is "Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"; $P(W)=\langle W,Q(W)\rangle$.
- The competitor, from [problem.md](../findings/problem.md): "Nienhaus's $W_{\mathbb{CP}^2}$ … is the Weyl operator of $\mathbb{CP}^2$ **in dimension 4** ($\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2(\mathbb{R}^4)$), zero-padded into $\Lambda^2(\mathbb{R}^n)$ … and $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ for **every** $n$."
- $\theta^*$ is fixed by [results.md](../results.md): "Write $\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$". The two tables of the brief are normalised by $\sqrt{3/2}$ (section C) and by $\theta^*$ (section D), **these agree**, which is the one place the two tables are demonstrably the same object.
- $F_u$ is defined in the brief itself, section E: "$F_u(h)=\tfrac12(uh+hu)+u\# h$", and [route-a.md:235](../findings/route-a.md) identifies it: it "**is** $u\circ h$, since polarising $Q(X)=X^2+X^\#$ gives $X\circ Y=\tfrac12(XY+YX)+X\#Y$; hence $F_u=\theta^*L_e$".

**Symbol collisions live in this block, all four of them.**

| letter | sense here | the colliding sense | where they meet |
| --- | --- | --- | --- |
| $u$ | the padded competitor $W_{\mathbb{CP}^2}\in\mathcal W_n$ | "the orbit acceleration $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$", [conventions.md](../findings/conventions.md)'s $\Pi$ row | the record's only tabled $u$ is the *other* one; L21's $u$ is tabled nowhere |
| $m$ | $n-4$, throughout section D | the value of the cubic: "$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$" and "$m$ is the maximum over all of them", section E | [route-a.md:139](../findings/route-a.md) against [route-a.md:186](../findings/route-a.md), **forty-seven lines apart in one file**, and the tube proof's "$\gamma_V\le m$" would read "$\gamma_V\le n-4$" under the other sense |
| $\alpha$ | $\sqrt{2/3}\langle F_uV,V\rangle$ | an eigenframe index, and a coefficient of the cubic $\psi$ in [stratum-two-negative.md](../findings/stratum-two-negative.md), tabled in [conventions.md](../findings/conventions.md) | no live confusion inside L21; flagged because L21's $\alpha$ is itself untabled |
| $M_\lambda$ | the multiplicity space | $M(n)$, "the global maximum of $P$ on the unit sphere"; and $M$, "the $n\times n$ **sectional** matrix" | three senses of one letter, none of them L21's, and L21's is untabled |

**Two items belong in [conventions.md](../findings/conventions.md) and are not there: $F_u$ and $\theta^*$.** Both are load-bearing across [route-a.md](../findings/route-a.md), [results.md](../results.md) and [second-order.md](../findings/second-order.md), and $\theta^*$ is defined only in passing inside another lemma's entry.

**One notational slip, harmless but worth naming.** Section B says "$W_{\mathbb{CP}^2}$ lives in $\Lambda^2(\mathbb R^4)$" and section C says it is "supported entirely inside $\Lambda^2(\mathbb R^4)$". $W_{\mathbb{CP}^2}$ is a symmetric *operator on* $\Lambda^2\mathbb R^4$, an element of $S^2(\Lambda^2\mathbb R^4)$. The intended content (its support as an operator is the $\Lambda^2\mathbb R^4$ block), is what every step actually uses, so nothing downstream breaks.

## 1. Hypothesis inventory

A pass without an inventory is not a pass, so here is every hypothesis the argument needs, whether or not the record states it.

| # | hypothesis | stated? | used? | status |
| --- | --- | --- | --- | --- |
| H1 | $u$ is the padded $W_{\mathbb{CP}^2}$, supported in the $\Lambda^2\mathbb R^4$ block | yes | yes, everywhere | fine |
| H2 | $F_u$ commutes with $G=SO(m)$ acting on the last $m=n-4$ coordinates | yes | yes | **its only support on file is a numerical residual**, "verified at $3.9\times10^{-15}$ over the generators". The *analytic* reason is one line and is never written: $u$ is $SO(m)$-fixed, and $Q$ is $O(n)$-equivariant, so $F_u=u\circ(\cdot)$ commutes with the stabiliser of $u$, which contains $SO(m)$. **Stated as a measurement where a proof was available** |
| H3 | each $V_\lambda$ is **absolutely** irreducible, i.e. $\mathrm{End}_{SO(m)}(V_\lambda)=\mathbb R$ | **no** | yes, silently, in the Schur step | holds at $m\ge5$; see §2 |
| H4 | the six types are pairwise non-isomorphic | **no** | yes, in "$\operatorname{spec}(F_u)=\bigcup_\lambda\operatorname{spec}(F_\lambda)$" and in the block-by-block orbit match | holds at $m\ge5$ |
| H5 | $m\ge5$, i.e. $n\ge9$ | **stated in the annotation, contradicted in the body** ("$n-4\ge8$") | yes | see §6 |
| H6 | the four named $F_\lambda$ have $m$-independent entries | **no, the record states the opposite as a finding** | yes, for every "in every dimension" claim | **the debt**; see §5 |
| H7 | $\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$, i.e. no orbit direction is lost in $\mathbb R^4\otimes\mathbb R^m$ | **no** | yes, for $\dim T_u\mathcal O=4n-14$ | see §8 |
| H8 | $Q$ maps $\mathcal W_n$ to itself, so $F_u$ needs no projection | yes, in [conventions.md](../findings/conventions.md) | yes | taken as the record's convention; §4 shows the image argument survives either reading |
| H9 | $\theta^*>0$, for $F_u=\theta^*L_e$ and for [L24](../findings/second-order.md) | yes, $\theta^*=\sqrt{3/2}$ | yes, in the L135(a) route that consumes L21 | fine |

**A hypothesis stated and never used:** none found. The multiplicity-free condition is stated only as the thing being *avoided*, and it is genuinely avoided.

**A step using a hypothesis never stated:** three, H3, H4 and H7.

## 2. The Schur step, checked against real Schur

The record's justification is: "**Multiplicities are exactly what the spaces $M_\lambda$ absorb**, so Schur applies unconditionally here."

**That sentence is true of the comparison it is making and false as the reason for the displayed identity.** Take the two apart.

*What is right.* The thesis route "works with the full stabilizer and asks each irreducible subspace to be an eigenspace", which needs multiplicity one. Passing to isotypic components removes exactly that: with multiplicity $k$, an equivariant self-adjoint $F$ acts on the isotypic piece as a $k\times k$ matrix rather than a scalar, and nothing is lost. This is a real structural improvement and it is correctly identified.

*What is missing.* $\mathcal W_n$ is a **real** vector space, $F_u$ is real and symmetric, and $V_\lambda$ are **real** irreducibles. Real Schur says $D_\lambda:=\mathrm{End}_{G}(V_\lambda)$ is $\mathbb R$, $\mathbb C$ or $\mathbb H$, and the correct isotypic statement is

$$\mathcal W_n=\bigoplus_\lambda M_\lambda\otimes_{D_\lambda}V_\lambda,\qquad \mathrm{End}_G\big(M_\lambda\otimes_{D_\lambda}V_\lambda\big)\cong\mathrm{End}_{D_\lambda}(M_\lambda).$$

The record's display $F_u=\bigoplus F_\lambda\otimes\mathrm{Id}_{V_\lambda}$, with $F_\lambda$ an $\mathbb R$-linear operator on $M_\lambda$ and $\otimes$ over $\mathbb R$, is the $D_\lambda=\mathbb R$ case and **only** that case. If $D_\lambda$ were $\mathbb C$, $F_\lambda$ would have to be $\mathbb C$-linear and the real dimension bookkeeping $\dim M_\lambda\cdot\dim V_\lambda$ that the record uses (the $698+940=1638$ count), would change by a factor of two in that block. So the step needs H3, absolute irreducibility, and the record never says so.

**Does it have it?** Yes, at $m\ge5$. The six types occurring (§3) are $\nu=(0),(1),(1,1),(2),(2,1),(2,2)$, all with $\ell(\nu)\le2$. For $SO(m)$ an irreducible tensor representation with $\ell(\nu)<m/2$ is of real type, its endomorphism algebra $\mathbb R$; the exceptions are the half-representations at $\ell(\nu)=m/2$ and the spin representations, neither of which occurs. $\ell(\nu)\le2<m/2$ exactly when $m\ge5$. So H3 holds precisely on the range H5 already requires, but for a different reason, and neither is written.

**Verdict: PROVEN, HYPOTHESES CORRECTED.** The conclusion stands; the reason given for it is not the reason, and the hypothesis that makes it work is absent.

## 3. The branching, and the two unnamed types, done by hand

Set $m=n-4$ and split $\Lambda^2\mathbb R^n=A\oplus B\oplus C$ with

$$A=\Lambda^2\mathbb R^4\ (\dim 6),\qquad B=\mathbb R^4\otimes\mathbb R^m\ (\dim 4m),\qquad C=\Lambda^2\mathbb R^m .$$

As $SO(m)$-representations, $A$ is $6$ trivials, $B$ is $4$ copies of the vector $v$, and $C$ is one $\lambda^2:=\Lambda^2\mathbb R^m$. Write $s^2_0=S^2_0\mathbb R^m$, of dimension $\tfrac{m(m+1)}2-1=\tfrac{(m-1)(m+2)}2$.

The record's starting identity, from section D, is $\mathcal W_n=S^2(\Lambda^2\mathbb R^n)\ominus S^2\mathbb R^n\ominus\Lambda^4\mathbb R^n$. **Check it first**, since everything rests on it: at $n=4$, $21-10-1=10=\dim\mathcal W_4$; at $n=12$, $2211-78-495=1638=\dim\mathcal W_{12}$. Both agree with $\frac{n(n-3)(n+1)(n+2)}{12}$. The three pieces are honest $O(n)$-subrepresentations ($\Lambda^4$ is the Bianchi obstruction, $S^2\mathbb R^n$ the Kulkarni–Nomizu image), so multiplicities subtract.

**Expand $S^2(A\oplus B\oplus C)$.**

| piece | decomposition | $SO(m)$-types |
| --- | --- | --- |
| $S^2A$ | $21$-dimensional, $SO(m)$ acts trivially | $21\cdot\mathbf 1$ |
| $A\otimes B$ | $6\times4$ copies of $\mathbb R^m$ | $24\,v$ |
| $A\otimes C$ | $6$ copies of $\Lambda^2\mathbb R^m$ | $6\,\lambda^2$ |
| $S^2B$ | $S^2\mathbb R^4\otimes S^2\mathbb R^m\ \oplus\ \Lambda^2\mathbb R^4\otimes\Lambda^2\mathbb R^m$ | $10\,s^2_0+10\cdot\mathbf 1+6\,\lambda^2$ |
| $B\otimes C$ | $\mathbb R^4\otimes(\mathbb R^m\otimes\Lambda^2\mathbb R^m)$, and $\mathbb R^m\otimes\Lambda^2=\Lambda^3\oplus V_{(2,1)}\oplus\mathbb R^m$ | $4\Lambda^3+4V_{(2,1)}+4v$ |
| $S^2C$ | $S^2(\Lambda^2\mathbb R^m)=\mathcal W_m\oplus S^2\mathbb R^m\oplus\Lambda^4\mathbb R^m$ | $V_{(2,2)}+s^2_0+\mathbf 1+\Lambda^4$ |

**And the two subtractions.**

$$\Lambda^4\mathbb R^n=\mathbf 1+4v+6\lambda^2+4\Lambda^3+\Lambda^4,\qquad S^2\mathbb R^n=11\cdot\mathbf 1+4v+s^2_0 .$$

**Collect.**

| type | $S^2(\Lambda^2\mathbb R^n)$ | $-\Lambda^4\mathbb R^n$ | $-S^2\mathbb R^n$ | multiplicity |
| --- | --- | --- | --- | --- |
| $\mathbf 1$ | $21+10+1=32$ | $-1$ | $-11$ | $\mathbf{20}$ |
| $v$ | $24+4=28$ | $-4$ | $-4$ | $\mathbf{20}$ |
| $\lambda^2$ | $6+6=12$ | $-6$ | $0$ | $\mathbf 6$ |
| $s^2_0$ | $10+1=11$ | $0$ | $-1$ | $\mathbf{10}$ |
| $\Lambda^3$ | $4$ | $-4$ | $0$ | $0$ |
| $\Lambda^4$ | $1$ | $-1$ | $0$ | $0$ |
| $V_{(2,1)}$ | $4$ | $0$ | $0$ | $\mathbf 4$ |
| $V_{(2,2)}$ | $1$ | $0$ | $0$ | $\mathbf 1$ |

**So the record's four multiplicities $20,20,6,10$ are consequences, exactly as section D says, and the two unnamed types are $V_{(2,1)}$ at multiplicity $4$ and $V_{(2,2)}=\mathcal W_m=\mathrm{Weyl}_{n-4}$ at multiplicity $1$.** No stability theorem was used; the only inputs are the two classical decompositions in the table's last two rows, and both are valid at $m\ge5$.

**The dimension formulas.** From $\mathbb R^m\otimes\Lambda^2=\Lambda^3\oplus V_{(2,1)}\oplus\mathbb R^m$,

$$\dim V_{(2,1)}=\frac{m^2(m-1)}2-\frac{m(m-1)(m-2)}6-m=\frac{m(m-1)(m+1)}3-m=\frac{m(m^2-1)}3-m=\frac{m(m-2)(m+2)}3 ,$$

which is the record's expression and the record's factored form, both. And $\dim V_{(2,2)}=\dim\mathcal W_m=\frac{m(m+1)(m+2)(m-3)}{12}$, "the $\dim\mathrm{Weyl}_m$ formula itself", as claimed, matching [conventions.md](../findings/conventions.md)'s $\frac{n(n-3)(n+1)(n+2)}{12}$ term for term.

**The identity in $m$, checked in full.** Over the denominator $12$:

$$20\cdot 12+20m\cdot12+3m(m-1)\cdot 12/3\ \text{…}$$

more usefully, term by term with numerators over $12$:

| block | contribution | numerator over $12$ |
| --- | --- | --- |
| $20\cdot\mathbf 1$ | $20$ | $240$ |
| $20\,v$ | $20m$ | $240m$ |
| $6\,\lambda^2$ | $3m(m-1)$ | $36m^2-36m$ |
| $10\,s^2_0$ | $5(m^2+m-2)$ | $60m^2+60m-120$ |
| $4\,V_{(2,1)}$ | $\tfrac{4m(m^2-4)}3$ | $16m^3-64m$ |
| $1\,V_{(2,2)}$ | $\tfrac{m(m+1)(m+2)(m-3)}{12}$ | $m^4-7m^2-6m$ |

Summing the numerators: $m^4+16m^3+(36+60-7)m^2+(240-36+60-64-6)m+(240-120)=m^4+16m^3+89m^2+194m+120$.

Against the target $\dim\mathcal W_{m+4}=\frac{(m+4)(m+1)(m+5)(m+6)}{12}$, and $(m+1)(m+6)=m^2+7m+6$, $(m+4)(m+5)=m^2+9m+20$, so

$$(m^2+7m+6)(m^2+9m+20)=m^4+16m^3+89m^2+194m+120 .$$

**The two quartics are equal coefficient by coefficient.** The identity holds identically in $m$, not at one dimension, the record's claim is exactly right.

**Spot values, since the record cites them.** At $m=8$: $\dim V_{(2,1)}=\frac{8\cdot6\cdot10}3=160$, $\dim V_{(2,2)}=\frac{8\cdot9\cdot10\cdot5}{12}=300$, so $4\cdot160+300=940$; the named blocks give $20+160+6\cdot28+10\cdot35=20+160+168+350=698$; $698+940=1638$. At $m=6$: $430+4\cdot64+84=770=\dim\mathcal W_{10}$. At $m=10$: $1030+4\cdot320+770=3080=\dim\mathcal W_{14}$. All three columns close.

**Verdict on claim 5: PROVEN.**

## 4. The fifth row, the degree argument and the image claim, separately

### 4a. The image claim

$u$ is supported in the $A$-block: as an operator on $\Lambda^2\mathbb R^n$ it maps $A\to A$ and kills $B\oplus C$.

*The anticommutator.* $(uh)_{XY}=u_{XA}h_{AY}$, nonzero only for $X=A$; symmetrically $hu$ occupies column $A$. So $\tfrac12(uh+hu)$ is supported in $AA\oplus AB\oplus AC$, and it reads only $h_{AA},h_{AB},h_{AC}$.

*The sharp product.* $u\#h$ contracts $u$ and $h$ against two copies of the $\mathfrak{so}(n)$ structure constants. With $u$ supported on $A=\mathfrak{so}(4)$, the surviving brackets are $[\mathfrak{so}(4),A]\subseteq A$ and $[\mathfrak{so}(4),B]\subseteq B$, while $[\mathfrak{so}(4),C]=0$, this is exactly the record's "$[\mathfrak{so}(4),\mathfrak{so}(m)]=0$". So both free indices of $u\#h$ land in $A\cup B$, and the $h$-slots read only $A\cup B$: the image sits in $AA\oplus AB\oplus BB$ and reads only $h_{AA},h_{AB},h_{BB}$.

**Together: $\operatorname{im}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$.** The record's image claim is correct, and this is the derivation it does not print.

Now read the branching table of §3 for which types those four blocks carry: $AA$ carries $\mathbf 1$ only; $AB$ carries $v$ only; $AC$ carries $\lambda^2$ only; $BB=S^2B$ carries $s^2_0,\mathbf 1,\lambda^2$ only. **None of the four carries $V_{(2,1)}$ or $V_{(2,2)}$.** Since $F_u$ is $G$-equivariant it preserves isotypic components, so on the $V_{(2,1)}$- and $V_{(2,2)}$-isotypics it is a map into a space containing none of that type, hence zero.

**And the complementary half, which the record does not state and which the argument needs:** the $V_{(2,1)}$-isotypic of $\mathcal W_n$ lies entirely in $BC$ and the $V_{(2,2)}$-isotypic entirely in $CC$. §3's table gives this, those two types occur in no other piece of $S^2(\Lambda^2\mathbb R^n)$, and neither subtracted piece contains them, so the isotypics of $\mathcal W_n$ are the isotypics of $S^2(\Lambda^2\mathbb R^n)$ unchanged.

*Robustness to H8.* If one reads $F_u$ as needing a projection $\Pi_{\mathcal W}$ back into $\mathcal W_n$ rather than [conventions.md](../findings/conventions.md)'s "sending $\mathcal W_n$ to itself", nothing changes: $\Pi_{\mathcal W}$ is $O(n)$-equivariant, hence $G$-equivariant, hence preserves isotypics, so it cannot manufacture a $V_{(2,1)}$ or $V_{(2,2)}$ component out of an image that has none.

### 4b. The degree argument

Grade by the number of $\mathbb R^4$-indices: $\deg A=2$, $\deg B=1$, $\deg C=0$, so $\deg AA=4$, $AB=3$, $AC=BB=2$, $BC=1$, $CC=0$.

- The anticommutator sends $h_{AA}\mapsto AA$ ($4\to4$), $h_{AB}\mapsto AB$ ($3\to3$), $h_{AC}\mapsto AC$ ($2\to2$), and kills $h_{BB},h_{BC},h_{CC}$.
- The sharp product sends $h_{AA}\mapsto AA$, $h_{AB}\mapsto AB$, $h_{BB}\mapsto BB$ ($2\to2$), and kills $h_{BC},h_{CC}$.

So "**$F_u$ preserves the $A$-index degree**" is true wherever $F_u$ is nonzero, and "**vanishes on degree $\le1$**" is true: degree $\le1$ is exactly $BC\oplus CC$, and both halves of $F_u$ annihilate it. And "**both higher isotypics sit at degree $0$ and $1$**" is true by §3: $V_{(2,1)}$ in $BC$, $V_{(2,2)}$ in $CC$.

**One correction to the record's wording.** Degree preservation is *not* enough on its own, $BB$ has degree $2$, above the stated threshold, and the anticommutator kills it anyway. The statement that carries the weight is the image claim of 4a, which is strictly stronger. The degree grading is a convenient bookkeeping of it, not an independent second proof.

**Verdict on claim 4: PROVEN**, on both readings, and it is a genuine dimension-free theorem, no $m$ appears in either half. The record's "**the bound never has to look at $940$ of the $1638$**" is earned. Note what this buys: on $940$ of $1638$ dimensions at $n=12$, and on the corresponding $4\dim V_{(2,1)}+\dim V_{(2,2)}$ at every $m\ge5$, the eigenvalue is $0$ **by proof**, so no $\tfrac12$ and no eigenvalue above $\tfrac13$ can hide there. The unproved part of L21 is confined to the $698$.

## 5. The $n$-independence, three data points, and in range only one

**There is no argument on file.** I looked in [route-a.md](../findings/route-a.md), [results.md](../results.md), [second-order.md](../findings/second-order.md), [conventions.md](../findings/conventions.md) and [L21.lean](../lean/HamiltonsCubic/Results/L21.lean). What is there is the table, and the sentence "Every multiplicity-space dimension and every $F_\lambda$ spectrum is **identical** across all three dimensions", repeated in both sections.

The record's own annotations say the same thing three times over, and I agree with all three:

- [route-a.md:190](../findings/route-a.md): "classical stability governs the type set and $\dim M_\lambda$, and **constrains no entry of $F_\lambda$**."
- [route-a.md:139](../findings/route-a.md): "**What would discharge the debt**: that the four rational $F_\lambda$ matrices have the tabulated spectra, by rank certificates over $\mathbb Q$, and that their entries do not depend on $m=n-4$."
- [route-a.md:239](../findings/route-a.md): "the spectra tabulated at $n=10,12,14$ and **asserted stable beyond**; a reader wanting (a) unconditionally at every $n$ should treat that stability as the one external input."

§3 above closes the first half of that, the type set and the $\dim M_\lambda$ are now proved, by hand, at every $m\ge5$, so the multiplicity column of the table needs no data at all. **The spectrum column is untouched by anything in §3.**

**And the evidence is thinner than "three data points".** [route-a.md:117](../findings/route-a.md) records: the four $F_\lambda$ spectra "are verified in floating point at $n=12,14$ and exactly only at $n=6,8,10$." Put that against §3's validity threshold $m\ge5$:

| $n$ | $m=n-4$ | inside $m\ge5$? | evidence quality |
| --- | --- | --- | --- |
| $6$ | $2$ | **no**, $\dim V_{(2,2)}$ evaluates to $-2$ at $m=2$, so the decomposition is not one | exact |
| $8$ | $4$ | **no**, $\Lambda^2\mathbb R^4$ and $\mathcal W_4$ both split, so the type list is wrong | exact |
| $10$ | $6$ | yes | exact |
| $12$ | $8$ | yes | floating point |
| $14$ | $10$ | yes | floating point |

**So the exact in-range evidence for the four $F_\lambda$ spectra is one dimension, $n=10$**, and the table's own three columns are one exact point and two floating-point points. That is a materially weaker footing than either section of the brief conveys, and neither section says which of its columns is which.

*What would close it, named and not supplied.* The entries of each $F_\lambda$ in a fixed basis are algebraic functions of $m$, a priori rational in $m$ with $\sqrt m$ available through the normalisation of $g_m$-traces in the trivial block. A **degree bound** on the coefficients of $\det(F_\lambda-x)$ as functions of $m$ would turn finitely many exact evaluations into a proof; without one, no finite number of sample points decides it. This is precisely [route-a.md:192](../findings/route-a.md)'s "plus a degree bound in $m$", and it is the whole remaining obligation.

**Verdict on claim 3: HYPOTHESIS-DEBT.** What must be proved, stated exactly: *for every $m\ge5$, the four matrices $F_{\mathbf 1},F_v,F_{\lambda^2},F_{s^2_0}$ have characteristic polynomials independent of $m$, equal to the tabulated ones.*

## 6. The stable range, the two statements, decided

Section C: "The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$", reasoning that the types live in $\bigotimes^k\mathbb R^{n-4}$ for $k\le4$ and that stability wants $m\ge2k$.

Section D's annotation: "the governing bound is on **row length**, not tensor degree, every partition here has $\ell(\nu)\le2$, so Littlewood restriction needs $m\ge4$ and $SO(m)$-irreducibility $m\ge5$, making the decomposition valid for every $n\ge9$."

**§3 decides it, and decides it in D's favour, by not needing either.** My computation of the multiplicity column used no stability theorem: it expanded $S^2(A\oplus B\oplus C)$ and subtracted two explicit subrepresentations. Every step is an identity of $SO(m)$-representations at every $m$. The only $m$-sensitive inputs are that the six types be irreducible and pairwise distinct, which is $m\ge5$, the same threshold D names, reached independently.

**The boundary cases, each checked.**

- **$m=4$ ($n=8$): genuinely fails.** $\Lambda^2\mathbb R^4$ splits into $\Lambda^2_\pm$ and $V_{(2,2)}=\mathcal W_4$ splits into $S^2_0(\Lambda^2_+)\oplus S^2_0(\Lambda^2_-)$, so the type list is wrong. Both dimension formulas remain positive there ($16$ and $10$), which is why the record's [both_types_present](../lean/HamiltonsCubic/Results/L21.lean) hypothesis $m\ge4$ is right for *positivity* and wrong for *irreducibility*. The two thresholds are different and the Lean file's is the weaker one.
- **$m=5$ ($n=9$): works.** $\ell(\nu)\le2\le\lfloor 5/2\rfloor$ and $m$ is odd, so no half-representation splits. The coincidences at $m=5$ ($\Lambda^3\mathbb R^5\cong\Lambda^2\mathbb R^5$ and $\Lambda^4\mathbb R^5\cong\mathbb R^5$), are harmless because both $\Lambda^3$ and $\Lambda^4$ cancel exactly in §3's table before any identification is made. Multiplicities remain $20,20,6,10,4,1$.
- **$m=6$ ($n=10$): works.** $\Lambda^3\mathbb R^6$ splits under $SO(6)$, but again it cancels wholesale. So the $n=10$ column is inside the range, section C calls its agreement "evidence that even $n-4=6$ is inside it", which under-claims: it is inside it provably.
- **$m=2$ ($n=6$): fails badly**, as §5's table records.

**Discrepancy 1, cleared under the protocol.** *Located*: [route-a.md:170](../findings/route-a.md) and [route-a.md:180](../findings/route-a.md) against [route-a.md:190](../findings/route-a.md). *Exhibited in closed form*: at $m=6$, outside C's claimed range, the multiplicities are $20,20,6,10,4,1$ and $20+120+90+200+4\cdot 64+84=770=\dim\mathcal W_{10}$ exactly, an identity, not a measurement. *The opposite argued*: could C be right and an extra type appear at $m=6$ that stability would hide? No, §3's expansion is an identity of representations at every $m$, so no type can appear or vanish except through a reducibility coincidence, and the complete list of those is $m\le4$. **Real. Section C's stated obligation is over-strong and should be struck.**

**But note what the correction is worth.** It moves the threshold from $n\ge12$ down to $n\ge9$ for the *multiplicity* column, which §3 now proves outright. It changes nothing about §5. The record's [route-a.md:117](../findings/route-a.md) already frames this as a dispute between two reviewers of whom "exactly one is right", on the narrow question of the threshold, D is right; on the wider question, the reviewer who said "the record names the wrong obligation" was right, and that is the more important of the two.

## 7. Section A states no result, what the canonical statement would have to be

Section A is a heading and a proof pointer with nothing between them. Section D says so itself: "[results.md](../results.md)'s L21 entry states the motivation and never the result, the same defect as the L20 entry directly above it." I confirm it: [results.md:713-715](../results.md) carries the heading "Lemma L21, the eigenvalue bound $\alpha\le1/3$ holds in every dimension, for a structural reason" and then "**Proof:** [route-a.md](../findings/route-a.md)". A reader of [results.md](../results.md) alone cannot recover what $u$, $\alpha$, $\theta^*$ or the ambient subspace are, nor the range of $n$.

**Drawn from the argument as written, the canonical statement has to be this.**

> **Lemma L21.** Let $n\ge9$, put $m=n-4$, let $u\in\mathcal W_n$ be the padded competitor $W_{\mathbb{CP}^2}=\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4\subseteq\Lambda^2\mathbb R^n$, let $\theta^*=\sqrt{3/2}=P(u)$, and let $F_u(h)=\tfrac12(uh+hu)+u\#h=u\circ h$ on $\mathcal W_n$. Then:
> **(i)** $F_u$ commutes with $G=SO(m)$ acting on the last $m$ coordinates;
> **(ii)** $\mathcal W_n$ has exactly six $G$-isotypic types, trivial, $\mathbb R^m$, $\Lambda^2\mathbb R^m$, $S^2_0\mathbb R^m$, $V_{(2,1)}$ and $V_{(2,2)}=\mathcal W_m$, with multiplicities $20,20,6,10,4,1$ **independent of $n$**, each type absolutely irreducible;
> **(iii)** hence $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$ and $\operatorname{spec}(F_u)=\bigcup_\lambda\operatorname{spec}(F_\lambda)$, with **no multiplicity-free hypothesis**;
> **(iv)** $F_{V_{(2,1)}}=0$ and $F_{V_{(2,2)}}=0$;
> **(v)** the four remaining $F_\lambda$ have the tabulated spectra, **independent of $n$**;
> **(vi)** $T_u(SO(n).u)=2\cdot\text{trivial}\oplus4\cdot\text{vector}$, of dimension $4n-14$, and equals the $\tfrac12\theta^*$-eigenspace of $F_u$;
> **(vii)** consequently $\max\operatorname{spec}\big(F_u|_{u^\perp\cap T_u\mathcal O^\perp}\big)=\tfrac13\theta^*$ (that is, $\alpha\le\tfrac13$ with equality attained) for every $n\ge9$.

Of these, **(i)–(iv) are proved** (this report's §2, §3, §4; (i) has an available one-line proof the record replaces with a residual). **(v) is the debt** of §5. **(vi) is half-proved**, §8. **(vii) follows from (iii)–(vi)** and from nothing weaker.

**Section B as a summary of that.** B reads: "$W_{\mathbb{CP}^2}$ lives in $\Lambda^2(\mathbb{R}^4)$, so the construction is $SO(n-4)$-equivariant and Schur applies with **no multiplicity-free hypothesis**. Four spaces of dimensions $20,20,6,10$ carry every nonzero eigenvalue and do not vary with $n$, making the bound a fixed finite computation."

It is **unfaithful in three ways**:

1. **No dimension hypothesis.** "in every dimension" in the heading and no $n\ge9$ in the line. The statement is false below $n=9$ as a decomposition and unavailable below $n=9$ as a bound.
2. **It presents (v) as established.** "do not vary with $n$" is the disputed clause, and B gives it as flatly as it gives the multiplicities. Compare the L20 entry three lines above, which *does* carry the caveat: "$\alpha\le\tfrac13$ rests on four $F_\lambda$ spectra tabulated at $n=10,12,14$ and asserted stable beyond". **The record is honest about the debt at L20 and silent about it at L21, which is the wrong way round.**
3. **"Four spaces … carry every nonzero eigenvalue" is stated as an observation and is in fact clause (iv)**, a theorem with a real proof. B gives away the strongest thing L21 actually establishes by phrasing it as bookkeeping.

**Verdict on claims 11 and 12: BROKEN and UNFAITHFUL.**

## 8. The two tables, the candidate contradiction, and why it is withdrawn

Section C has five rows, the fifth reading "two higher types, $0$ throughout"; section D has four and says "Only four types carry a nonzero eigenvalue."

**Applying the discrepancy protocol.** *Locate*: [route-a.md:162-168](../findings/route-a.md) against [route-a.md:204-209](../findings/route-a.md). *Exhibit a failure in closed form*: **I cannot.** §4 proves the fifth row, so "only four types carry a nonzero eigenvalue" is a **true sentence**, and D's table omits a row whose every entry is $0$. There is no false statement to point at. *Argue the opposite*: D's four-row table plus the theorem of §4 is exactly C's five-row table. **Withdrawn, the two tables do not contradict each other.**

**What is real, and is a different defect: D's table cannot deliver D's own closing sentence.** [route-a.md:213](../findings/route-a.md) says the diagonalisation reproduces the full spectrum "with multiplicities summing to $\dim\mathrm{Weyl}_n$ exactly". At $n=12$, off the four rows:

| eigenvalue $/\theta^*$ | multiplicity from the four rows | with the fifth row |
| --- | --- | --- |
| $1$ | $1$ | $1$ |
| $\tfrac12$ | $2+4\cdot8=34$ | $34$ |
| $\tfrac13$ | $3+28+3\cdot35=136$ | $136$ |
| $0$ | $6+12\cdot8+3\cdot28+35=221$ | $221+940=1161$ |
| $-\tfrac16$ | $6+2\cdot28+6\cdot35=272$ | $272$ |
| $-\tfrac12$ | $4\cdot8=32$ | $32$ |
| $-1$ | $2$ | $2$ |
| **total** | $\mathbf{698}$ | $\mathbf{1638}$ |

**$698\ne1638$.** So the sentence at [route-a.md:213](../findings/route-a.md) is unreachable from the table printed directly above it, and reachable from C's five-row table once the fifth row is filled in. **The repair is to print one table, five rows, with the fifth row's entries supplied**: $\dim V_\lambda=\tfrac{m(m-2)(m+2)}3$ and $\tfrac{m(m+1)(m+2)(m-3)}{12}$, $\dim M_\lambda=4$ and $1$, spectrum $\{0\}$, and to cite §4's theorem, not the numerics, for that row.

*Two further internal consistency checks passed while I was in the arithmetic, both worth recording as evidence the table is at least self-consistent.* [route-a.md:435](../findings/route-a.md) reports building $F_{W_1}$ over "**all 78** basis vectors of $V_{1/3}$" at $n=10$: the table gives $3\cdot1+1\cdot15+3\cdot20=78$. And section D's "$\tfrac13$ IS SHARP, ATTAINED ON $136$ DIMENSIONS AT $n=12$" matches $3+28+105=136$. Both agree with the table exactly.

## 9. The orbit

**The Lie algebra split is right.** $\mathfrak{so}(n)=\mathfrak{so}(4)\oplus(\mathbb R^4\otimes\mathbb R^m)\oplus\mathfrak{so}(m)$, which as $SO(m)$-types is $6\cdot\mathbf 1\oplus4v\oplus\lambda^2$.

**$\mathfrak{so}(m)$ acts trivially on $u$**: $u$ is supported in $\Lambda^2\mathbb R^4$, on which $SO(m)$ acts trivially. Correct.

**$\dim\mathfrak{so}(4)/\mathfrak{stab}_4=2$ is correct, and checkable in closed form from the record's own spectrum.** With $u=\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$, the zeros sit on one chirality block and $(-1,-1,2)$ on the other. Under $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ acting as $\mathfrak{so}(3)$ on each $\Lambda^2_\pm$: the stabiliser of a scalar-zero block is all of $\mathfrak{so}(3)$ (dimension $3$), and the stabiliser of $\operatorname{diag}(-1,-1,2)$ in $\mathfrak{so}(3)$ is $\mathfrak{so}(2)$ (dimension $1$). Total $4=\dim\mathfrak u(2)$, leaving $6-4=2$, of trivial $SO(m)$-type. **Correct.**

**The remaining step is asserted and never argued.** For $\dim T_u\mathcal O=2+4m$ one needs $\mathfrak{stab}(u)\cap(\mathbb R^4\otimes\mathbb R^m)=0$, that no $\xi$ in the off-diagonal block kills $u$. The record writes "modulo the stabilizer the orbit directions are $\mathfrak{so}(4)/\mathfrak{stab}_4$ … together with $\mathbb{R}^4\otimes\mathbb{R}^{n-4}$" and supplies nothing for the second summand. **What would prove it, named and not supplied**: $\xi\cdot u$ has $(B,A)$-block $\mathrm{ad}(\xi)\circ u|_A$, so the claim is that no nonzero $\xi\in\mathbb R^4\otimes\mathbb R^m$ annihilates $\operatorname{im}(u|_{\Lambda^2\mathbb R^4})$, which for this $u$ is one full chirality block.

**The arithmetic is right either way**: $2+4(n-4)=4n-14$, and the stabiliser reading $\binom n2-\binom m2-4=(4m+6)-4=4m+2=4n-14$ agrees.

**The coincidence with the $\tfrac12\theta^*$-eigenspace: one inclusion is a theorem, the other is the table.**

- *Orbit $\subseteq E_{1/2}$ is proved, and not here.* [second-order.md:64](../findings/second-order.md): "the orbit directions are exact $\tfrac12$-eigenvectors by equivariance … the equivariance identity $2L_W\delta_vW=\theta\,\delta_vW$ with $\delta_vW\perp W$ puts an exact $\tfrac12$-eigenvector in $W^\perp$ at every such point." Combined with $F_u=\theta^*L_e$, this gives the inclusion at every $n$, free.
- *Equality is a dimension count off the disputed table*, and **the record itself flags this exact trap**: [second-order.md:27](../findings/second-order.md), "The multiplicity relation is $\operatorname{mult}(\tfrac12)\ge\dim\mathcal O$, an **inequality** rather than an identity", with $S^3\times S^3$ giving $18$ against an orbit of $9$. So a coincidental extra $\tfrac12$ is a phenomenon this programme has actually met.

**And equality is load-bearing, not decorative.** A single extra $\tfrac12\theta^*$-eigenvector transverse to $\mathbb Ru\oplus T_u\mathcal O$ turns $\alpha\le\tfrac13$ into $\alpha\le\tfrac12$, at which (section E), "the interval is empty and the theorem is vacuous". **§4 removes that risk on $940$ of the $1638$ dimensions by proof; on the remaining $698$ it rests on the tabulated spectra.**

**Verdict on claims 8 and 9: GAP on the stabiliser step; one inclusion proven, equality inherits §5.**

## 10. The conclusion's direction, bound, attained, or both

**Both, and the record is right to say so; the two consumers are both served, and both by the same unproved input.**

*The normalisation closes.* $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ (section E) and the top transverse eigenvalue is $\tfrac13\theta^*=\tfrac13\sqrt{3/2}$, so $\alpha\le\sqrt{2/3}\cdot\tfrac13\sqrt{3/2}=\tfrac13$, since $\sqrt{2/3}\cdot\sqrt{3/2}=1$. The $\tfrac13$ of the table and the $\tfrac13$ of the tube proof are the same number in the same units. **This is worth stating because the two sections normalise differently** (C by $\sqrt{3/2}$, D by $\theta^*$) and they agree only because $\theta^*=\sqrt{3/2}$.

*Bound.* [L20](../findings/route-a.md) needs $\max\operatorname{spec}(F_u|_{u^\perp\cap T_u\mathcal O^\perp})\le\tfrac13\theta^*$, an upper bound over the whole transverse space. That is what "deleting $\mathbb Ru$ and the orbit leaves top eigenvalue $\tfrac13\theta^*$" delivers, *provided* the deletion is exhaustive, i.e. provided clause (vi)'s **equality**. Deleting a subspace of the $\tfrac12$-eigenspace would leave $\tfrac12$ behind.

*Attained.* [L134](../results.md) "consumes the numerical $\tfrac13$" as a value. Attainment is the easier half: the $\tfrac13\theta^*$-eigenspace has dimension $3+\dim\Lambda^2\mathbb R^m+3\dim S^2_0\mathbb R^m$ ($136$ at $n=12$, $78$ at $n=10$) and by the block structure it lies inside $u^\perp\cap T_u\mathcal O^\perp$, since $u$ is the $\theta^*$-eigenvector and the orbit is the $\tfrac12\theta^*$-eigenspace, all three eigenvalues being distinct.

*Which is more exposed.* **The bound.** Attainment needs one $\tfrac13$ to be in the spectrum at every $m$; the bound needs the *whole* transverse spectrum to stay at or below $\tfrac13$ at every $m$, including in the $940$ dimensions §4 handles and the $698$ it does not. **Both consumers therefore inherit §5, and L20 inherits it more heavily.**

*And one further inconsistency the direction question exposes.* Section C closes: "**This removes the last external dependency of Lemma L20.**" Section E, thirteen lines earlier in the same file, still says of the same input: "**This is the lemma's one unproved input, and the citation given for it does not carry it.**"

**Discrepancy 2, cleared under the protocol.** *Locate*: [route-a.md:179](../findings/route-a.md) against [route-a.md:139](../findings/route-a.md). *Exhibit*: both cannot hold; and by §5 the dependency was **converted, not removed**, from "Nienhaus 4.14, whose Schur step needs multiplicity-freeness" to "the four $F_\lambda$ matrices are $m$-independent", which is an unproved statement of this record's own. *Argue the opposite*: could E be stale text predating C? Even granting that, C's sentence is over-strong on its own terms, because [route-a.md:192](../findings/route-a.md) (written *after* C, in D), still lists rank certificates and a degree bound in $m$ as outstanding. **Real. C's removal claim should read "replaces the external dependency with an internal one, stated in §(v)".**

## 11. The traps, answered by name

- **$\ker W\ne0$ and padded objects.** $u$ is maximally padded: $\ker u\supseteq B\oplus C$, of codimension $3$ in $\Lambda^2\mathbb R^n$, and $u$ has a further $3$-dimensional kernel inside $A$ from the $\operatorname{diag}(0,0,0,\cdot,\cdot,\cdot)$ block. **Nothing in L21 divides by $u$ or inverts it**, the whole argument is *about* the support of $u$, which is the padding read positively. The one place the kernel does bite is elsewhere and the record knows it: [route-a.md:247](../findings/route-a.md), "$\delta^2$ is one-sided at $u$ because $u$ has a kernel". L21 is clean here.
- **$n=9$.** Inside, by §6, $m=5$, odd, $\ell(\nu)\le2$. The record's C section would place it outside; D's annotation and my §3 place it inside. **This is the tightest boundary in the lemma and neither table column tests it.**
- **$n=10$.** Inside, and it is the *only* dimension at which the spectra are both in range and exactly verified (§5).
- **$m=4$ ($n=8$).** **Fails**, and the failure is exhibited: $\Lambda^2\mathbb R^4$ and $\mathcal W_4$ both split. No consumer is harmed, since every consumer runs at $n\ge9$ or $n\ge12$, but [L21.lean](../lean/HamiltonsCubic/Results/L21.lean)'s hypothesis is $4\le m$, which is the positivity threshold and not the irreducibility threshold, so the Lean file's stated range is one step too generous for the mathematics it is attached to.
- **$m=5,6$.** Both inside; the $\Lambda^3$ and $\Lambda^4$ coincidences at those dimensions cancel before they can do damage (§6).
- **The crossover $n=6+2\sqrt7\approx11.29$.** It does **not** enter L21, L21's threshold is $n\ge9$, from representation theory, and the crossover is where $\theta_0(n)>\theta^*$, from [problem.md](../findings/problem.md). **They are unrelated thresholds that both land near $n\approx11$, which is precisely the kind of coincidence that invites a false merge.** The consumer L20 needs both: $n\ge9$ for L21 and $n>6+2\sqrt7$ for the contradiction, so its $n\ge12$ is set by the crossover and L21 is not the binding constraint. No error found; recorded because the two are easy to conflate.
- **A claim proven on a subfamily and used in general.** **Present, and it is the central defect.** Three sampled dimensions (in fact one exact in-range dimension), carry clause (v) for all $n$. §5.
- **A hypothesis stated but never used.** None found. Multiplicity-freeness is named only as the hypothesis being avoided, and it is genuinely avoided.
- **A step using a hypothesis never stated.** Three: absolute irreducibility (§2), pairwise-distinctness of the six types, and the stabiliser step (§9).
- **A universal claim with no witness.** "Every $F_\lambda$ spectrum is identical" quantifies over all $n$ with five witnesses, two of them floating point and two of them outside the range where the objects quantified over are even defined.
- **An imported theorem whose hypotheses were never checked.** The record's own instance is Nienhaus Theorem 4.14, "whose Lemma 4.13 is valid only on **multiplicity-free** isotypic components", and L21 exists to replace it, so L21 must not cite it. **It does not.** The unital-algebra trap ([second-order.md:29](../findings/second-order.md): "§4.2 concerns **unital** algebras, which $\mathrm{Weyl}_n$ is not") is likewise not invoked here. But section E records that the *tube proof* still cites 4.14 for $\alpha\le\tfrac13$ rather than citing L21, **so the broken citation is still the one in the load-bearing position, and L21 sits beside it rather than in it.** That is a routing defect in [route-a.md:139](../findings/route-a.md), not an error in L21.
- **Symbol collisions.** Four, tabulated in §0. The live one is $m$, which is $n-4$ throughout section D and the cubic's value in section E, forty-seven lines apart in one file, where "$\gamma_V\le m$" would read as "$\gamma_V\le n-4$" under the wrong sense.

## 12. What would falsify it, and what I did to look

**The object.** A dimension $n\ge9$ and a vector $H\in\mathcal W_n$ with

$$H\perp u,\qquad H\perp T_u(SO(n).u),\qquad F_uH=\mu H\ \text{ with }\ \mu>\tfrac13\theta^* .$$

By §2–§4 such an $H$ is forced into one of the four named multiplicity spaces, so it is equivalently: **a fifth eigenvalue $\tfrac12$ in the $20\times20$ trivial block $F_{\mathbf 1}$, or a fifth in the $20\times20$ vector block $F_v$, or any eigenvalue in $(\tfrac13,\tfrac12)\cup(\tfrac12,1)$ anywhere in the four blocks, at some $m\ge5$.** The cleanest single form: an $m$ at which $\operatorname{mult}_{F_u}(\tfrac12\theta^*)>4n-14$.

**Where I looked, and it was analysis only.**

1. **The $940$.** I derived the block support of $\operatorname{im}F_u$ and the block location of both higher isotypics independently (§4), and the two higher types cannot host such an $H$ at any $m$. **A whole majority of the space is closed to the falsifier by proof.** This is the strongest positive result in the lemma and it is the one B omits.
2. **The multiplicity column.** I re-derived $20,20,6,10,4,1$ from scratch (§3) and checked the resulting dimension identity as an equality of quartics in $m$, not at sample points. **The falsifier cannot come from a type the table missed**, there is no seventh type at any $m\ge5$.
3. **The boundary.** I tested $m=2,4,5,6$ by hand against the irreducibility requirements and located the exact threshold, $m\ge5$. **The falsifier cannot come from $n=9$ or $n=10$ being outside the range**, which is what section C's obligation would have suggested.
4. **The four blocks themselves.** **I did not look, and could not.** Deciding whether $F_{\mathbf 1}$ or $F_v$ acquires a fifth $\tfrac12$ at some $m$ means writing down those matrices as functions of $m$ and computing, which is exactly the computation this loop is forbidden to run and exactly the computation the record already ran at five dimensions. **I neither reproduced nor contradicted the record's numbers; I have no independent knowledge of them.**
5. **Internal consistency, which is the one thing I could test on the numbers already written.** Every row of both tables sums to its own $\dim M_\lambda$ ($2{+}6{+}6{+}3{+}2{+}1=20$; $4{+}12{+}4=20$; $2{+}3{+}1=6$; $6{+}1{+}3=10$); the $\tfrac13$-eigenspace comes to $78$ at $n=10$ and $136$ at $n=12$, both of which the record independently reports elsewhere; the $\tfrac12$-eigenspace comes to $2+4m=4n-14$, which the orbit dimension independently reports; and the whole spectrum sums to $\dim\mathcal W_n$ **once the fifth row is restored**. **The table is consistent with everything else on the record. Consistency is not $n$-independence.**

**Where the falsifier is not excluded**: item 4, on $698$ of the $1638$ dimensions at $n=12$ and the corresponding blocks at every other $m$.

## Verdict

**HYPOTHESIS-DEBT.**

L21's structural half is real, is stronger than the record claims for it, and I re-proved every part of it by hand: the Schur step is sound once absolute irreducibility is supplied (§2); the six types and their multiplicities $20,20,6,10,4,1$ are $n$-independent by an identity in $m$, valid at every $n\ge9$ (§3, §6); the two higher types are annihilated by $F_u$ for a reason with no dimension in it, which closes $940$ of $1638$ dimensions at $n=12$ against every possible falsifier (§4); and the exhaustion identity $698+940=\dim\mathcal W_n$ holds coefficient by coefficient as quartics in $m$ (§3).

**The lemma is nonetheless not proved, and one clause is why.** That the four surviving $F_\lambda$ have $m$-independent spectra has no argument anywhere on this record; the record's own annotations say so three times; and the exact evidence *inside the range where the decomposition is valid* is **one dimension, $n=10$**, the other two exact points sitting at $m=2$ and $m=4$ where the type list is wrong and the other two in-range points being floating-point. What is owed is stated exactly in §5: characteristic polynomials of $F_{\mathbf 1},F_v,F_{\lambda^2},F_{s^2_0}$ independent of $m\ge5$, by rank certificates over $\mathbb Q$ together with a degree bound in $m$.

**Three repairs are owed to the text and none of them needs new mathematics:** strike section C's "$n-4\ge8$" for $n\ge9$; print one five-row table with the fifth row filled in and cited to §4's theorem rather than to numerics; and state the result in [results.md](../results.md), with its $n\ge9$ hypothesis and with clause (v) marked as the input, as the L20 entry three lines above already does for the same object.
