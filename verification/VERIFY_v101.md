# VERIFY v101, Lemma L57: the diagonal bound $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ at every $n\ge4$, its two parity constants, and its equality clause

*Cold brief, [ROUND_L57.md](ROUND_L57.md). **No numerical work was done**: no script was run, and every number below is an exact hand evaluation of a symbolic expression. Log: [agent_logs/verify-L57-v101.log](../agent_logs/verify-L57-v101.log).*

## Verdicts

| # | claim, as a consumer would read it | verdict |
| --- | --- | --- |
| A | Step 1: $\lambda\le\frac{n-1}{n}\mu$ at a critical point of $\mathcal D_n$ | **PROVEN** |
| B | Step 2: $\mu=2\langle S,Z(v)\rangle$, $Z(v)$ the orthogonal projection, and $\lvert Z\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$ | **PROVEN** |
| C | Step 3: the fourth-moment lemma at both parities | **PROVEN** |
| D | The chaining to $\Theta_n^2$, both parities | **PROVEN** |
| E | The quantifier bridge (critical point $\to$ every diagonal $W$ | **PROVEN) but off the block's own map** |
| F | Attainment: the balanced split beats every other sphere product | **PROVEN** |
| G | Uniqueness half of "equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$" | **PROVEN as a statement about $\mathcal D_n$; the SIGN is wrong in the citable statement** |
| H | $\lVert W\rVert=1 \iff \mathop{\mathrm{tr}}S^2=2$, the normalisation that carries the whole constant across the $W\leftrightarrow S$ bijection | **PROVEN in [diagonal-half.md](../findings/diagonal-half.md), cited from this block nowhere** |
| I | "Equality is up to $\pm1\times S_n$" ([problem.md](../findings/problem.md), *So the all-$n$ diagonal theorem is COMPLETE*) | **BROKEN** |
| J | The sign correction $Z(v)=\lambda V$, $\lambda=-\frac{n(n-3)}{(n-2)(n-1)(n+1)}$, stated unqualified | **GAP, it is the odd-$n$ value only** |
| K | F7 (transferred): the two-value ratio singles out no split | **CONFIRMED against (c)'s numerics; REFUTED as a charge against the theorem** |
| L | F8 (transferred): the computation covers even $n$ only | **REFUTED** |
| M | Third form: a Lean row for L57 | **ABSENT, L57 sits in [lean/INDEX.md](../lean/INDEX.md)'s *out* bucket for a reason that does not apply to it** |

**Summary in one line.** The three steps, the chaining, the two constants and the maximiser-to-everywhere bridge are all correct and I reproduced every one of them exactly by hand; what fails is not the mathematics but the packaging, the equality clause a consumer cites carries the wrong sign, the normalisation that fixes the constant is proved in a file this block cites for something else, the block's own "whole map" omits the bridge, and the Lean row is filed under a reason that is not L57's.

## 0. Conventions, fixed once

Every pairing below is the one the source's own factor of $2$ forces, and I state it here because **the block never states it**.

- **The pair inner product is over UNORDERED pairs**: $\langle A,B\rangle:=\sum_{i<j}A_{ij}B_{ij}$ and $\lvert A\rvert^2=\sum_{i<j}A_{ij}^2$, for $A,B$ symmetric hollow. Consequently $\lvert S\rvert^2=\tfrac12\mathop{\mathrm{tr}}S^2$, and the block's locus $\mathop{\mathrm{tr}}S^2=2$ is exactly $\lvert S\rvert=1$ in this pairing.
- [conventions.md](../findings/conventions.md)'s stated default is the opposite one (*"Sums over pairs are over ORDERED pairs unless the line says otherwise"*) and **no line of the L57 block says otherwise**. What forces the unordered reading is the factor $2$ in step 2's $\mu=2\langle S,Z(v)\rangle$, which is false under the ordered reading. See §7.
- $M$, $S$ and "the vertex matrix" are one object: the $n\times n$ symmetric hollow zero-row-sum matrix of sectional curvatures $M_{ab}=w_{ab}$.
- $\theta(W)=\langle W,Q(W)\rangle/\lVert W\rVert^3$, and on the diagonal locus [diagonal-half.md](../findings/diagonal-half.md) gives it as the weighted-graph functional $\theta=\tfrac12\big(\sum_{a,b}M_{ab}^3+\mathop{\mathrm{tr}}M^3\big)$ under $M\mathbf1=0$, $\mathop{\mathrm{diag}}M=0$, $\mathop{\mathrm{tr}}M^2=2$.
- $v\in\mathbb R^n$ is always a unit vector with $\sum_iv_i=0$; $\mu$ is an eigenvalue of $S$ with $Sv=\mu v$; $\lambda$ is the criticality multiplier, and at $\lvert S\rvert=1$ it equals $\theta$.
- $V$ denotes the sphere product's vertex matrix **in the record's own parametrisation, cross value $+1$** ([r500](../reviews/REVIEW_r500.md)); this sign convention is load-bearing in §8.

## The hypothesis inventory

Every hypothesis the block carries or imports, and whether the written proof uses it.

| # | hypothesis | where it comes from | applies to | used? |
| --- | --- | --- | --- | --- |
| H1 | $S$ symmetric | definition of $\mathcal D_n$ | $S$ | yes, throughout; $\mu$ real, spectral theorem |
| H2 | $S$ hollow ($s_{ii}=0$) | definition of $\mathcal D_n$ | $S$ | yes, step 1 ($(S^{\circ2})_{ii}=0$, so $D$ absorbs the diagonal), step 2 ($\langle S,(v_iv_j)\rangle=\mu/2$ needs the diagonal to drop) |
| H3 | $S\mathbf1=0$ | Ricci-flatness | $S$ | yes, both contractions of step 1; $v\perp\mathbf1$; step 2's residual orthogonality |
| H4 | $\mathop{\mathrm{tr}}S^2=2$ | the locus | $S$ | yes, **and only in step 2**, at $\mu\le2\lvert S\rvert\lvert Z\rvert$. Steps 1 and 3 are scale-free in $S$ |
| H5 | $S\ne0$ | **nowhere stated** | $S$ | yes, silently, step 1 divides by $\mu$, which needs $\mu>0$, which needs $S\ne0$. Discharged by H4, which already excludes $S=0$ |
| H6 | $Q(S)=\lambda S$, i.e. $S^{\circ2}+S^2=\lambda S+D$ | [diagonal-half.md](../findings/diagonal-half.md) | $S$ | yes, step 1's identity $(*)$ |
| H7 | $v$ unit, $v\perp\mathbf1$, $Sv=\mu v$ | the block's opening | $v$ | yes, everywhere |
| H8 | $\mu$ is the **largest** eigenvalue | the block's opening | $\mu$ | **no.** The proof needs only $\mu>0$; "largest" is never used. Any positive eigenvalue gives the same chain |
| H9 | $n\ge4$ | the statement | $n$ | yes, step 3's Proof I needs a fourth coordinate; and $\mathcal D_3=\{0\}$ |
| H10 | $n\ge5$ for odd uniqueness | *Two corrections* bullet 4 | $n$ | vacuous inside $n\ge4$: the smallest odd $n$ in range is $5$ |
| H11 | $W$ diagonal in **some** frame | the statement | $W$ | yes, it is what puts the problem on $\mathcal D_n$ |
| H12 | $\lVert W\rVert^2=\sum_{a<b}M_{ab}^2$ | [diagonal-half.md](../findings/diagonal-half.md), the graph-functional display | the $W\leftrightarrow S$ bijection | yes, and **the L57 block never cites it**, see §7 |
| H13 | $\mathcal D_n$ is a linear subspace, $\theta$ continuous and $3$-homogeneous | the bridge paragraph | $\mathcal D_n$ | yes, the compactness reduction, §6 |
| H14 | restricted criticality $=$ criticality | [diagonal-half.md](../findings/diagonal-half.md)'s symmetric-criticality paragraph | $\mathcal D_n\subset\mathcal W_n$ | yes, §6 |
| H15 | Ricci-flat locally symmetric $\Rightarrow$ flat (Cartan) | imported by **L46**, not by L57 |, | **no.** L57 imports nothing from L46; the Cartan hypothesis-debt recorded against L46 does not touch L57 |
| H16 | $\ker W=0$ |, | $W$ | **no**, and the proof is right not to need it: on $\mathcal D_n$, $\ker W\supseteq\mathop{\mathrm{span}}\{\varphi_{ab}:M_{ab}=0\}$ is nonzero at almost every sphere product, and nothing in the chain sees it. [conventions.md](../findings/conventions.md)'s kernel trap **W4** attaches to the gradedness slack $S(W)$, which L57 does not use |
| H17 | compactness / completeness of an underlying manifold | (|), | **no.** L57 is an algebraic statement about $\mathcal W_n$; the compactness dispute recorded against L46 does not reach it |

**Nothing is imported from a published source.** Every step is internal. [references/](../references/) holds [jaeger-2016-diagonal-case](../references/jaeger-2016-diagonal-case/), which the record positions as the *competing* published result (even $n\ge16$) rather than an input, and the block cites it for nothing. So no claim here rests on an unread source.

## 1. Step 1, $\lambda\le\frac{n-1}{n}\mu$, **PROVEN**

I re-derived it cold, line by line, and every line stands.

Pair $S^{\circ2}+S^2=\lambda S+D$, $D=\mathop{\mathrm{diag}}(r_i)$, $r_i=\sum_js_{ij}^2$, with $v\otimes v$:

$$v^{\mathsf T}S^{\circ2}v+\mu^2=\lambda\mu+\sum_ir_iv_i^2 .$$

Now $\sum_ir_iv_i^2=\sum_{i,j}s_{ij}^2v_i^2=\tfrac12\sum_{i,j}s_{ij}^2(v_i^2+v_j^2)$ by the symmetry of $s^2$, and $v^{\mathsf T}S^{\circ2}v=\sum_{i,j}s_{ij}^2v_iv_j$, so the difference is $\tfrac12\sum_{i,j}s_{ij}^2(v_i-v_j)^2=\sum_{i<j}s_{ij}^2(v_i-v_j)^2$, giving

$$\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2 .\tag{$*$}$$

The two contractions:

$$\sum_{i<j}s_{ij}(v_i-v_j)^2=\underbrace{\sum_{i,j}s_{ij}v_i^2}_{=\,\sum_iv_i^2(S\mathbf1)_i\,=\,0}-\underbrace{\sum_{i,j}s_{ij}v_iv_j}_{=\,v^{\mathsf T}Sv\,=\,\mu}=-\mu,\qquad \sum_{i<j}(v_i-v_j)^2=n\textstyle\sum v^2-(\sum v)^2=n .$$

Cauchy–Schwarz on the two families $\big(s_{ij}(v_i-v_j)\big)_{i<j}$ and $\big(v_i-v_j\big)_{i<j}$ gives $\mu^2\le n\sum_{i<j}s_{ij}^2(v_i-v_j)^2$, so with $(*)$, $\lambda\mu\le\mu^2-\mu^2/n$. **Dividing by $\mu$ requires $\mu>0$**, true because $\mathop{\mathrm{tr}}S=0$ (H2) and $S\ne0$ (H4), so the largest eigenvalue is strictly positive; this also makes $v\perp\mathbf1$ automatic, since $\mathbf1$ is a $0$-eigenvector (H3). Hence $\lambda\le\frac{n-1}{n}\mu$. $\square$

**Findings.** *No finding on the mathematics.* Two on the hypotheses: **H8** ("largest") is unused, any positive eigenvalue serves; and the positivity $\mu>0$ that licenses the division is **nowhere written**, though it is free from H2+H4. **Parity: free.** **Normalisation: free in $S$**, this step holds at any scale, so it cannot be the site of a $\sqrt2$ error.

## 2. Step 2, the projection and its norm, **PROVEN**

**(a) $Z(v)\in\mathcal D_n$.** Reproduced: with $\sum_{j\ne i}v_j=-v_i$ and $\sum_{j\ne i}v_j^2=1-v_i^2$,

$$\sum_{j\ne i}Z_{ij}=-v_i^2+\frac{(n-2)v_i^2+1}{n-2}-\frac{n-1}{(n-1)(n-2)}=-v_i^2+v_i^2+\frac1{n-2}-\frac1{n-2}=0 .$$

**(b) Orthogonality.** The residual is $a_i+a_j+c$ with $a_i=-v_i^2/(n-2)$, $c=\frac1{(n-1)(n-2)}$, and for $T\in\mathcal D_n$, $\sum_{i<j}(a_i+a_j)T_{ij}=\sum_{i\ne j}a_iT_{ij}=\sum_ia_i\cdot0=0$ and $c\sum_{i<j}T_{ij}=\tfrac c2\sum_i(\text{row sum})=0$. Correct as written.

**(c) $\mu=2\langle S,Z(v)\rangle$.** Since $S$ is hollow, $\langle S,(v_iv_j)\rangle=\sum_{i<j}s_{ij}v_iv_j=\tfrac12v^{\mathsf T}Sv=\mu/2$; since $S\in\mathcal D_n$ and $Z$ is the orthogonal projection, $\langle S,Z\rangle=\langle S,(v_iv_j)\rangle$. Hence $\mu=2\langle S,Z\rangle\le2\lvert S\rvert\lvert Z\rvert=2\lvert Z\rvert$, using H4.

**(d) The norm formula, derived here in full**, because it is the one line of the block that is stated and never computed anywhere on the record. Write $\beta=\frac1{n-2}$, $\gamma=\frac1{(n-1)(n-2)}=\frac\beta{n-1}$, $F=\sum_iv_i^4$. Expanding $\sum_{i\ne j}Z_{ij}^2$ term by term, with $\sum v=0$, $\sum v^2=1$:

| term | value |
| --- | --- |
| $\sum_{i\ne j}v_i^2v_j^2$ | $1-F$ |
| $2\beta\sum_{i\ne j}v_iv_j(v_i^2+v_j^2)=4\beta\sum_iv_i^3\sum_{j\ne i}v_j$ | $-4\beta F$ |
| $-2\gamma\sum_{i\ne j}v_iv_j$ | $+2\gamma$ |
| $\beta^2\sum_{i\ne j}(v_i^2+v_j^2)^2=\beta^2[2(n-1)F+2(1-F)]$ | $2\beta^2[(n-2)F+1]$ |
| $-2\gamma\beta\sum_{i\ne j}(v_i^2+v_j^2)=-4\gamma\beta(n-1)$ | $-4\gamma\beta(n-1)$ |
| $\gamma^2\sum_{i\ne j}1$ | $\gamma^2n(n-1)$ |

The $F$-terms collect to $-F(1+4\beta-2\beta^2(n-2))=-F(1+2\beta)=-F\frac{n}{n-2}$, using $\beta^2(n-2)=\beta$. The constants, over the common denominator $(n-1)(n-2)^2$, have numerator

$$(n-1)(n-2)^2+2(n-2)-2(n-1)+n=(n-1)(n-2)^2+(n-2)=(n-2)\big[(n-1)(n-2)+1\big]=(n-2)(n^2-3n+3),$$

so the constant is $\frac{n^2-3n+3}{(n-1)(n-2)}$. Halving:

$$\lvert Z(v)\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac{n}{2(n-2)}\sum_iv_i^4 . \qquad\square$$

**Exactly the block's formula.** The coefficient of $\sum v^4$ is negative, so **maximising $\lvert Z\rvert$ means minimising the fourth moment**, the direction the chain needs, and it is correct.

**Findings.** *No finding on the mathematics.* One on the record: the norm formula's derivation exists in **neither** [problem.md](../findings/problem.md) nor [r123](../reviews/REVIEW_r123.md) nor [r124](../reviews/REVIEW_r124.md), all three of which audit claims 1 and 2 (membership and orthogonality) and state the norm without deriving it. It is correct (I derived it above) but until this report it was an unproved link in the chain that fixes the constant. **Parity: free. Normalisation: uses H4, in the unordered pairing.**

## 3. Step 3, the fourth-moment lemma, **PROVEN, and parity-blind**

**Proof I ([r123](../reviews/REVIEW_r123.md)), checked in full.**

*Lemma A.* $t_1+t_2+t_3=0\Rightarrow\sum t_i^4=\tfrac12(\sum t_i^2)^2$. Newton with $e_1=0$: $p_1=0$, $p_2=-2e_2$, $p_3=3e_3$, $p_4=e_1p_3-e_2p_2+e_3p_1=-e_2p_2=\tfrac12p_2^2$. Correct.

*Theorem.* Lagrange for $\min\sum v^4$ under $\sum v=0$, $\sum v^2=1$, the constraint qualification holds, since $\mathbf1$ and $2v$ are independent whenever $v$ is non-constant, which the two constraints force, gives $4v_i^3=\alpha+2\beta v_i$, a cubic with **no quadratic term**, so at most three distinct values and any three of them sum to $0$. Suppose a minimiser has exactly three, $r_1,r_2,r_3$. Take one coordinate carrying each, let $\sigma=r_1^2+r_2^2+r_3^2>0$, and replace that triple by any $t\in C=\{\textstyle\sum t=0,\sum t^2=\sigma\}\subset\mathbb R^3$. Both constraints are preserved and, by Lemma A, so is the objective, so the new vector is again a global minimiser and again has $\le3$ values. $C$ is a circle; the excluded set (a repeated entry, or an entry equal to one of $r_1,r_2,r_3$) is $\{t_a=t_b\}$ and $\{t_a=r_b\}$, each a plane meeting the circle in at most two points, so at most $6+18=24$ points are excluded and a good $t$ exists. Since $n\ge4$ some coordinate is untouched and still carries one of the old values, so the new vector has $\ge4$ distinct values. **Contradiction.** Hence at most two, and exactly two (one value forces $v=0$).

*The two-value value.* Multiplicities $p,q=n-p$, values $a,b$ with $pa+qb=0$, $pa^2+qb^2=1$ give $a^2=\frac q{np}$, $b^2=\frac p{nq}$ and

$$\sum v^4=\frac{q^2}{n^2p}+\frac{p^2}{n^2q}=\frac{p^3+q^3}{n^2pq}=\frac{n^3-3pqn}{n^2pq}=\frac n{pq}-\frac3n,$$

decreasing in $pq$, minimised at $pq=\lfloor n/2\rfloor\lceil n/2\rceil$. Even $n$: $\frac4n-\frac3n=\frac1n$. Odd $n$: $\frac{4n}{n^2-1}-\frac3n=\frac{4n^2-3n^2+3}{n(n^2-1)}=\frac{n^2+3}{n(n^2-1)}$. **Both constants confirmed exactly.** $\square$

**Proof II ([r124](../reviews/REVIEW_r124.md)), a second route, and the one comparison in it that I could check by hand holds:** $\frac1{n-1}>\frac{n^2+3}{n(n^2-1)}$ reduces, on multiplying by $n(n-1)(n+1)>0$, to $n^2+n>n^2+3$, i.e. $n>3$. Correct. The sub-lemma it rests on (*"$(n-1)M_4-M_2^2$ expands with all $24$ monomials positive"*), is **asserted in one clause and the $24$ monomials are shown nowhere**, in [problem.md](../findings/problem.md) or in this summary of it. That does not weaken step 3, which Proof I closes on its own; it means the record's *"proved by two independent arguments"* is one proof plus a sketch.

**Findings.** The block's own one-line summary of step 3 (*"A three-coordinate smoothing reduces a minimiser to two values"*), **misdescribes the proof it points at.** [r123](../reviews/REVIEW_r123.md) says so in terms: *"The 'three-coordinate smoothing argument' the source asserts is not a smoothing at all, it is a whole circle of directions along which the objective does not move."* The corrected description is three headings below the summary, and the summary was never updated. **Parity: the proof is parity-blind; only the evaluated constant splits.**

## 4. The chaining, both constants, **PROVEN**

$$\lambda\ \le\ \tfrac{n-1}n\mu\ \le\ \tfrac{n-1}n\cdot2\lvert Z(v)\rvert\ \le\ \tfrac{n-1}n\cdot2\lvert Z\rvert_{\max},$$

each link with a positive multiplier, so the chain is legitimate in the direction needed. Substituting the two minima:

**Even $n$**, $\sum v^4\ge\frac1n$:
$$\lvert Z\rvert^2_{\max}=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac1{2(n-2)}=\frac{n^2-4n+4}{2(n-1)(n-2)}=\frac{(n-2)^2}{2(n-1)(n-2)}=\frac{n-2}{2(n-1)},$$
$$\Big(\tfrac{n-1}n\Big)^2\cdot4\lvert Z\rvert^2_{\max}=\frac{(n-1)^2}{n^2}\cdot\frac{2(n-2)}{n-1}=\frac{2(n-1)(n-2)}{n^2}=\Theta_n^2 .\ \checkmark$$

**Odd $n$**, $\sum v^4\ge\frac{n^2+3}{n(n^2-1)}$:
$$\lvert Z\rvert^2_{\max}=\frac{(n^2-3n+3)(n+1)-(n^2+3)}{2(n-2)(n-1)(n+1)}=\frac{(n^3-2n^2+3)-(n^2+3)}{2(n-2)(n-1)(n+1)}=\frac{n^2(n-3)}{2(n-2)(n-1)(n+1)},$$
$$\Big(\tfrac{n-1}n\Big)^2\cdot4\lvert Z\rvert^2_{\max}=\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\Theta_n^2 .\ \checkmark$$

**Both constants are exactly the block's, and I obtained them from the three steps and nothing else.**

**One notational finding.** The block writes the chain as *"$\lambda^2\le\big(\tfrac{n-1}n\big)^2\cdot4\lvert Z\rvert^2_{\max}$"*. Squaring $\lambda\le X$ does not give $\lambda^2\le X^2$, it needs $\lambda\ge-X$ as well, which the chain never establishes. The conclusion the theorem needs is the **one-sided** $\lambda\le\Theta_n$, and that follows from the unsquared chain directly. So the squared form is loose rather than wrong; a consumer who quotes it as $\lvert\lambda\rvert\le\Theta_n$ would be quoting something the proof does not give.

## 5. Attainment, and F7, **the bound is attained; balancedness is an OUTPUT of step 3, not an input**

**(a) The attainment paragraph's own step is correct.** With $p+q=n$ fixed,
$$\Big(1-\tfrac1p\Big)\Big(1-\tfrac1q\Big)=\frac{(p-1)(q-1)}{pq}=1-\frac{p+q}{pq}+\frac1{pq}=1-\frac{n-1}{pq},$$
strictly increasing in $pq$, and $pq$ is maximised over $p+q=n$ at the balanced split. So *"the balanced split beats every other sphere product"* holds, with a cleaner reason than the one given. It collapses correctly: at $p=q=\tfrac n2$, $\frac{2(n-1)\frac{(n-2)^2}4}{(n-2)\frac{n^2}4}=\frac{2(n-1)(n-2)}{n^2}$; at $p,q=\frac{n\mp1}2$, $\frac{2(n-1)\frac{(n-3)(n-1)}4}{(n-2)\frac{(n-1)(n+1)}4}=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$. **Both exact.**

**(b) I verified attainment independently and exactly, at $n=6$, from the graph functional alone.** Take $M$ two-block, $3+3$, within value $x$, cross $z$; the row sum forces $2x+3z=0$. With $z=-1$, $x=\tfrac32$: $\sum_{a<b}M^2=6x^2+9z^2=\tfrac{27}2+9=\tfrac{45}2$. The spectrum is $0$ (on $\mathbf1$), $2x-3z=6$ (on the block-difference), and $-x=-\tfrac32$ with multiplicity $4$; trace $6-6=0$ and $\sum\mu^2=36+9=45=\mathop{\mathrm{tr}}M^2$, both checks passing. Then $\sum_{a,b}M^3=2\big(6x^3+9z^3\big)=2\big(6\cdot\tfrac{27}8-9\big)=2\big(\tfrac{81}4-9\big)=2\cdot\tfrac{45}4=\tfrac{45}2$, and $\mathop{\mathrm{tr}}M^3=216+4(-\tfrac{27}8)=216-\tfrac{27}2=\tfrac{405}2$. So the unnormalised $\theta=\tfrac12\big(\tfrac{45}2+\tfrac{405}2\big)=\tfrac{225}2$, and at $\mathop{\mathrm{tr}}M^2=2$ the scale is $t=\sqrt{2/45}$:
$$\theta=\tfrac{225}2\Big(\tfrac2{45}\Big)^{3/2}=\tfrac{225}2\cdot\frac{2\sqrt2}{135\sqrt5}=\frac53\sqrt{\tfrac25}=\frac{\sqrt{10}}3=\sqrt{\tfrac{10}9}=\Theta_6 .$$
**Exactly $\Theta_6$.** The same matrix gives the criticality multiplier: at the within-block entry, $(M^{\circ2}+M^2)_{12}=x^2+\big(x^2+3z^2\big)=\tfrac94+\big(\tfrac94+3\big)=\tfrac94+\tfrac{21}4=\tfrac{15}2$, against $\lambda x=\tfrac32\lambda$, so $\lambda=5$; at a cross entry, $z^2+(4xz)=1-6=-5$ against $\lambda z=-\lambda$, so $\lambda=5$ again. **Consistent, and equal to $n-1$ in magnitude**, confirming [r500](../reviews/REVIEW_r500.md)'s $\lambda_V=1-n$ and its $\sum_{i<j}V_{ij}^2=\frac{pq(n-1)(n-2)}{2(p-1)(q-1)}=\frac{9\cdot5\cdot4}{2\cdot2\cdot2}=\tfrac{45}2$, matching my $\tfrac{45}2$. And since a critical point's multiplier scales like $t$, $\theta=\lambda_V/\lvert V\rvert$, which squares to r500's closed form. **The whole attainment claim is derived, not measured.**

**(c) F7 is CONFIRMED where it was aimed, and REFUTED as a charge against the theorem.**

*Located.* [problem.md](../findings/problem.md), under *Step 2 is now PROVED here*, item **(c)**: *"$\frac{Z_{\text{same block}}}{Z_{\text{cross}}}=-\frac{n/2}{n/2-1}$, which is exactly the within/cross ratio of $S^{n/2}\times S^{n/2}$'s vertex matrix, verified as $-1.5,-4/3,-1.25,-1.2$ at $n=6,8,10,12$."*

*The failure, concretely.* The record refutes its own evidence three headings later, in *Two corrections*, bullet 3: block-constant elements of $\mathcal D_n$ satisfy $(p-1)x+qz=0$ and $(q-1)y+pz=0$, a **one-dimensional** solution space **for every split $(p,q)$**. So for *any* two-value $v$ with multiplicities $(p,q)$ (balanced or not), $Z(v)$ is block-constant, hence automatically proportional to $S^p\times S^q$'s vertex matrix, and the ratio match is an identity that holds at every split. The four numerics $-1.5,-4/3,-1.25,-1.2$ are therefore **evidence for nothing**: they are $-\frac n{n-2}$, which I obtain in closed form as $Z_{\text{same}}=\frac1{n-1}$, $Z_{\text{cross}}=-\frac{n-2}{n(n-1)}$ at $a=-b=1/\sqrt n$. F7 is right about (c).

*The most charitable reading.* (c) is not the step that picks the split, and does not claim to be, it is the **identification** step, run *after* step 3 has already forced $v$ to be the balanced two-value vector. Read that way its job is to name the matrix $Z(v)$ is parallel to, and the one-dimensionality bullet does that job better than the ratio does. **Balancedness enters the proof at exactly one place: the minimisation of $\sum v^4$ over $pq$ in step 3**, which is a genuine optimisation with a genuine unique answer. So balancedness is an output.

*Verdict.* **F7 stands as a defect in (c)'s stated warrant and in its numerics; it does not touch the theorem.** The repair is one clause: cite the one-dimensionality bullet where (c) currently cites the ratio, and drop the four measurements.

## 6. Pre-registered question 1, the quantifier, **the reduction EXISTS, and the block's own "whole map" omits it**

*The question.* The statement quantifies over **every** diagonal $W$ at every $n\ge4$; the proof opens *"at a critical point $Q(S)=\lambda S$"*. What carries it from critical points to all of $\mathcal D_n$?

**Located.** [problem.md](../findings/problem.md), under the heading *So the all-$n$ diagonal theorem is COMPLETE*: *"$\mathcal D_n$ is a linear subspace and the cubic is continuous and homogeneous, so its maximum over the unit sphere of $\mathcal D_n$ (compact), is attained, and the maximiser is critical for the restricted problem. **$Q$ preserves $\mathcal D_n$**, so that restricted criticality is the equation the chain solves."*

**It is a correct argument, and I checked every joint.**
- $\mathcal D_n$ is cut out by linear conditions, so it is a subspace; its unit sphere is compact and $\theta$ is continuous, so the max is attained at some $S_\star$.
- $S_\star$ is a critical point of $\theta$ restricted to that sphere, i.e. $\Pi_{\mathcal D_n}Q(S_\star)=\lambda S_\star$ for a multiplier $\lambda$, and pairing with $S_\star$ gives $\lambda=\langle Q(S_\star),S_\star\rangle=\theta(S_\star)$ at $\lvert S_\star\rvert=1$. **So the $\lambda$ the chain bounds IS the quantity the theorem bounds**, a point the block never states.
- Homogeneity of degree $3$ then gives $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for every $W\in\mathcal D_n$, zero included.

**One clause of it is false as written, and the true version is in another file.** *"$Q$ preserves $\mathcal D_n$"* is not true: $S^{\circ2}+S^2$ has diagonal $r_i=\sum_js_{ij}^2\ne0$, so it leaves the hollow subspace. What is true, and what the argument needs, is that the projection is *just dropping the diagonal*: the off-diagonal row sums of $S^{\circ2}+S^2$ are $r_i+\big[(S^2\mathbf1)_i-(S^2)_{ii}\big]=r_i-r_i=0$, using $S\mathbf1=0$. Hence $\Pi_{\mathcal D_n}Q(S)=Q(S)-D$, and restricted criticality reads $S^{\circ2}+S^2=\lambda S+D$ exactly. **[diagonal-half.md](../findings/diagonal-half.md) proves this properly**, it derives the Ricci-flatness multiplier $v_i+v_j$, shows it vanishes, and states the equivalence as an iff, adding that the "if" direction is symmetric criticality on the fixed-point set of the coordinate sign-flip group. So the block's one-clause version is a lossy paraphrase of something correct next door.

**The finding is where the bridge sits, not whether it is sound.** The L57 block opens with *"The argument is spread over five places, and **this is the whole map**"*, and then names: the three steps and their chaining; the Step 1 heading; the Step 2 heading; the Step 3 heading; the odd-equality heading; and [diagonal-half.md](../findings/diagonal-half.md) for the criticality equation. **The bridge's heading is not among them.** A reader who follows the map exactly reads six pointers, finds a bound at critical points only, and has no reason to look further, the map has told them they have seen everything. This is precisely the record's signature failure named in the brief: the completion lands *beside* the statement, under a heading the statement's own map does not name.

**Verdict: PROVEN, but off the block's own map.** The repair is one heading name added to the map.

## 7. The normalisation trap, **consistent, and consistent for a reason the block never gives**

**Which normalisation each step uses.**

| step | normalisation of $S$ | normalisation of $v$ | pairing |
| --- | --- | --- | --- |
| 1 | **none** (scale-free | $\lvert v\rvert=1$, $v\perp\mathbf1$ |), |
| 2 | $\lvert S\rvert=1$, i.e. $\mathop{\mathrm{tr}}S^2=2$ | $\sum v^2=1$, $\sum v=0$ | **unordered pairs**, $\sum_{i<j}$ |
| 3 | none | $\sum v^2=1$, $\sum v=0$ |, |

**The chaining is consistent.** The only place a scale enters is step 2's $\mu\le2\lvert S\rvert\lvert Z\rvert$, and the locus $\mathop{\mathrm{tr}}S^2=2$ is exactly $\lvert S\rvert=1$ in the unordered pairing. The warning the block gives, *"not $\lvert S\rvert=1$, which under plain Frobenius over ordered pairs gives $\Theta_n/\sqrt2$"*, is the right warning and it is discharged correctly.

**But the block never says which pairing step 2 is in, and [conventions.md](../findings/conventions.md)'s stated default is the other one.** That file's rule reads *"Sums over pairs are over ORDERED pairs unless the line says otherwise"*, and no line of the L57 block says otherwise. Under the ordered reading, $\langle S,(v_iv_j)\rangle=\sum_{i\ne j}s_{ij}v_iv_j=\mu$, so step 2's identity would be $\mu=\langle S,Z\rangle$ with no factor $2$, and $\lvert Z\rvert^2$ would double; the norm formula in §2(d) would carry a factor $2$; and a consumer chaining consistently in the ordered pairing would land on $\Theta_n$ again only by cancelling two errors. **The factor $2$ in "$\mu=2\langle S,Z(v)\rangle$" is the only tell that the unordered pairing is in force, and it is never named as such.**

**And the bridge from $\lVert W\rVert$ to $\mathop{\mathrm{tr}}S^2=2$ is real, but off the map too.** The statement bounds $\langle Q(W),W\rangle$ by $\Theta_n\lVert W\rVert^3$ where $\lVert W\rVert$ is the Weyl-operator norm; the proof works at $\mathop{\mathrm{tr}}S^2=2$. These agree because [diagonal-half.md](../findings/diagonal-half.md) establishes $\theta(w)=\sum_{a<b}w_{ab}^3+3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$ under $\sum_{a<b}w_{ab}^2=1$, i.e. $\lVert W\rVert^2=\sum_{a<b}M_{ab}^2=\tfrac12\mathop{\mathrm{tr}}M^2$, which rests in turn on [conventions.md](../findings/conventions.md)'s half-trace pairing, in which $\{\varphi_{ab}\}_{a<b}$ is orthonormal. **The chain closes. The L57 block cites [diagonal-half.md](../findings/diagonal-half.md) for the criticality equation only, and cites nothing at all for this.** My exact $n=6$ evaluation in §5(b) runs the whole chain end to end and lands on $\sqrt{10}/3=\Theta_6$, which is the strongest confirmation available without a script: had the pairing been wrong anywhere, that number would have come out $\Theta_6\sqrt2$ or $\Theta_6/\sqrt2$.

## 8. The equality clause, **attainment PROVEN; uniqueness PROVEN; the SIGN in the citable statement is wrong**

The clause *"equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$"* asserts two things and I check them separately.

**Attainment, PROVEN.** §5(a) and §5(b): the closed form $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ evaluates to $\Theta_n^2$ at the balanced split at both parities, and I confirmed it exactly at $n=6$ from the graph functional with no appeal to the closed form.

**Uniqueness, PROVEN, by the following chain, which I reconstructed because the block states its conclusion in one sentence.** Equality in the chain forces equality at every link. Step 2's Cauchy–Schwarz forces $S\parallel Z(v)$. Step 3 forces $v$ to be two-valued with $pq$ maximal, i.e. balanced multiplicities. Then $Z(v)$ is block-constant for that split, and block-constant elements of $\mathcal D_n$ form a **one-dimensional** space (the *Two corrections* bullet's $(p-1)x+qz=0$, $(q-1)y+pz=0$) so $Z(v)$ is a multiple of the split's vertex matrix and $S$ is the unit vector in that line. Up to the $S_n$ relabelling this is one point at even $n$ and one at odd $n$. Step 1's own equality condition ($s_{ij}$ constant wherever $v_i\ne v_j$) is an *extra* necessary condition that the argument never checks, harmless, because attainment is established independently, so the necessary conditions already used are enough to pin the point and the attainment half is not resting on them.

**The sign, BROKEN in the citable statement.**

*Located.* Three places state the equality case with no sign: [problem.md](../findings/problem.md):557–579, *"with equality exactly at $S^{n/2}\times S^{n/2}$ for even $n$ and at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ for odd $n$"*; [results.md](../results.md):98; [results.md](../results.md):268.

*The failure, concretely, at $n=6$.* In the record's own parametrisation of the vertex matrix $V$ (cross value $+1$, [r500](../reviews/REVIEW_r500.md)), $n=6$ balanced gives cross $z=+1$, within $x=-\tfrac32$. My §5(b) computation is that matrix negated, and it gives $\theta=+\sqrt{10}/3=+\Theta_6$. Since $\theta$ is an **odd** cubic, $V$ itself gives $\theta(V/\lvert V\rvert)=-\Theta_6$, and I confirmed this a second way: $\lambda_V=1-n=-5$ and $\lvert V\rvert=\sqrt{45/2}$, so $\theta=\lambda_V/\lvert V\rvert=-5/\sqrt{22.5}=-\sqrt{10}/3$. **So under the record's own convention for $V$, the matrix the equality clause names is the MINIMISER, and the maximiser is $-V$.**

*The most charitable reading.* "$S^{n/2}\times S^{n/2}$" could be read as naming the *manifold* rather than a signed matrix, in which case the clause is sign-free and the reader is expected to take whichever sign makes $\theta>0$. That reading survives, but it does not survive the block's own next sentence, which fixes a convention for $V$ and then names $S=-V/\lVert V\rVert$; once a convention is fixed, the unsigned name is a defect in it and not an abstraction above it.

*This was found before and not repaired.* [r500](../reviews/REVIEW_r500.md) recorded it, *"the L57 block names a matrix whose stated sign is the minimiser under the record's own $V$ convention. One clause fixes it"*, and [r123](../reviews/REVIEW_r123.md) recorded the same as a caveat on its claim 5. **The clause was not fixed.** The correction sits in [problem.md](../findings/problem.md) under *Two corrections to what this file recorded*, three headings above the statement, and the statement was left as it was. **This is the named trap, at full strength: two of the three citable forms are in [results.md](../results.md), which carries no copy of the correction at all.**

**And one claim is outright false., BROKEN.** [problem.md](../findings/problem.md), *So the all-$n$ diagonal theorem is COMPLETE*: *"**Equality is up to $\pm1\times S_n$**, the maximiser being $-V/\lVert V\rVert$."* The two halves of that sentence contradict each other. $\theta$ is an odd cubic, so $\theta(-S)=-\theta(S)$; if $\theta(S)=\Theta_n>0$ then $\theta(-S)=-\Theta_n<\Theta_n$ strictly, and $-S$ is not an equality point. **The symmetry group of the equality set is $S_n$, not $\{\pm1\}\times S_n$**, as the same sentence's own second half says. Concretely at $n=6$: $\theta$ takes $+\sqrt{10}/3$ at $-V/\lvert V\rvert$ and $-\sqrt{10}/3$ at $+V/\lvert V\rvert$, a gap of $2\sqrt{10}/3$, so the $\pm$ orbit is not contained in the equality set. The charitable reading (that "$\pm$" is inherited from a two-sided bound $\lvert\theta\rvert\le\Theta_n$), fails because the theorem's inequality is one-sided and §4 shows the proof gives only the one-sided form.

## 9. Pre-registered question 3, parity, and F8, **F8 REFUTED; the "every step" claim is TRUE**

Taking the three steps one at a time, as asked.

| step | parity status | evidence |
| --- | --- | --- |
| **1** | **parity-free** | The derivation in §1 contains no case split and no floor or ceiling. $n$ enters once, as $\sum_{i<j}(v_i-v_j)^2=n$ |
| **2** | **parity-free** | §2's membership, orthogonality and norm derivations are polynomial identities in $n$ and $\sum v^4$. No parity |
| **3** | **parity-free in proof, parity-split in value** | [r123](../reviews/REVIEW_r123.md)'s Proof I is one argument valid at every $n\ge4$: Lagrange, Lemma A, the circle, the contradiction. The split appears only when $pq=\lfloor n/2\rfloor\lceil n/2\rceil$ is evaluated: $n^2/4$ or $(n^2-1)/4$. Its own words: *"It is parity-blind, so it re-proves the even case as a corollary and step 3 becomes one theorem rather than two"* |
| chaining | parity-split in evaluation only | §4: one formula $\big(\tfrac{n-1}n\big)^2\cdot4\lvert Z\rvert^2_{\max}$, evaluated at two minima |
| equality identification | **genuinely split**, and **both halves are on file** | even: (c) plus the one-dimensionality bullet; odd: heading (d), which I checked in full below |
| the bridge (§6) | parity-free | compactness and homogeneity see no parity |

**So [results.md](../results.md)'s *"Every step holds at both parities"* is correct, and F8 (*"the computation covers even $n$ only"*), is REFUTED.** The odd case is not asserted from the even one anywhere; it has its own evaluation at every point where one is needed, and its own equality identification under heading (d).

**I checked (d) exactly.** At the odd extremiser, $p=\tfrac{n-1}2$ (value $a$), $q=\tfrac{n+1}2$ (value $b$), §3's two-value formulas give $a^2=\frac{n+1}{n(n-1)}$, $b^2=\frac{n-1}{n(n+1)}$ (both matching (d)) and $ab=-\sqrt{a^2b^2}=-\tfrac1n$. Then, using $Z_{aa}=a^2\frac{n}{n-2}-\frac1{(n-1)(n-2)}$:

$$Z_{aa}=\frac{n+1}{(n-1)(n-2)}-\frac1{(n-1)(n-2)}=\frac n{(n-1)(n-2)},\qquad Z_{bb}=\frac{n-1}{(n+1)(n-2)}-\frac1{(n-1)(n-2)}=\frac{n(n-3)}{(n-1)(n-2)(n+1)},$$

both exactly (d)'s values. For the cross value, over the denominator $n(n^2-1)(n-2)$ the numerator of $Z_{ab}=-\tfrac1n+\frac{a^2+b^2}{n-2}-\frac1{(n-1)(n-2)}$ is $-(n^2-1)(n-2)+(2n^2+2)-n(n+1)=-n^3+3n^2=-n^2(n-3)$, so

$$Z_{ab}=\frac{-n(n-3)}{(n-1)(n-2)(n+1)}=-Z_{bb} .$$

Hence $\dfrac{Z_{aa}}{Z_{ab}}=-\dfrac{n+1}{n-3}$ and $\dfrac{Z_{bb}}{Z_{ab}}=-1$, **identically in $n$**, matching the vertex matrix's $\big(-\tfrac{n+1}{n-3},-1,1\big)$. (d) is correct.

**But (d) cannot be checked from (d).** Its own display writes the third entry as literally *"$Z_{ab}=\text{(the cross value)}$"*, and then asserts two ratios against a quantity it has not given. The value $Z_{ab}=-Z_{bb}=-\frac{n(n-3)}{(n-1)(n-2)(n+1)}$ appears **three headings later**, in the *Two corrections* bullet list. A consumer reading (d) alone has a claim with a hole in it. **GAP in presentation, not in mathematics.**

**And one correction is stated without its parity qualifier, GAP.** *Two corrections*, bullet 1: *"$Z(v)=\lambda V$ with $\lambda=-\tfrac{n(n-3)}{(n-2)(n-1)(n+1)}<0$, verified symbolically, $-0.1389,-0.1167,-0.0964,-0.0815$ at $n=5,7,9,11$."* That formula is the **odd** case only, it is $Z_{bb}$ against $V_{bb}=-1$, and every dimension in its own list is odd. At even $n$ the constant is different: from §5(c)'s closed forms, $Z_{\text{cross}}=-\frac{n-2}{n(n-1)}$ against $V_{\text{cross}}=+1$ gives $\lambda_{\text{even}}=-\frac{n-2}{n(n-1)}$, which at $n=6$ is $-\tfrac2{15}=-0.1\overline3$ and is **not** the bullet's formula ($-\frac{6\cdot3}{4\cdot5\cdot7}=-\frac{18}{140}=-0.1286$). The bullet states the odd value unqualified in a file whose theorem is at both parities. The sign conclusion $\lambda<0$ survives at both parities (that is the load-bearing half, and it holds) but the constant does not.

## 10. The three forms compared, and the Lean row

| form | where | what it says |
| --- | --- | --- |
| findings | [problem.md](../findings/problem.md):557–579 | $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for every diagonal $W$ at every $n\ge4$; both constants; *"equality exactly at"* the balanced product; *"At even $n$, $\Theta_n=\theta_0(n)$"* |
| canon, glance | [results.md](../results.md):98 | $\theta\le\Theta_n$ for every unit $W$ diagonal **in some frame**; both constants; equality exactly at the balanced product; *"Three steps, each proved"* |
| canon, detail | [results.md](../results.md):268 | the same, plus the normalisation clause *"$\lVert M\rVert$ normalised to $\lVert W\rVert=1$"*, plus the three-step summary, plus *"Every step holds at both parities"*, plus the non-goal *"It does not reach any $W$ that is diagonal in no frame"* |
| **Lean** | **none** | see below |

**The three prose forms are mutually consistent on the mathematics**, and each carries something the others lack: only :268 names the normalisation, only :268 states the diagonal-only scope as an explicit non-goal, and only [problem.md](../findings/problem.md) records $\Theta_n=\theta_0(n)$ at even $n$. **All three carry the sign defect of §8, and none of the three carries the correction that repairs it.** [conventions.md](../findings/conventions.md)'s $\Theta_n$ row cites *"result 57"* and gets the constants right, including the square root that it records as having been missing until 2026-09-04.

**There is no Lean form.** [lean/INDEX.md](../lean/INDEX.md) mentions L57 exactly once, at line 359, in the bucket *"out, needs machinery Mathlib does not have"*, grouped with **L46, L47, L48, L8** under the reason *"the classification of compact symmetric spaces"*.

**That reason is not L57's.** L57's proof, as verified above, is: a criticality equation on $n\times n$ real symmetric matrices; two applications of Cauchy–Schwarz in $\mathbb R^{\binom n2}$; a Lagrange-multiplier count of distinct values; a Newton-identity lemma about three reals; a minimisation of $n/(pq)$ over integer splits; and a one-dimensionality count for block-constant matrices. **No symmetric space is classified anywhere in it.** The sphere product enters only as an explicit block-constant matrix (the object I wrote down by hand in §5(b)), never as a member of a classified list. L57 is misfiled, and the reason attached to it belongs to its four bucket-mates.

**What the row would have to claim.** The formalisable core is the finite-dimensional statement, with no manifold in it:

> For $n\ge4$ and $S\in\mathbb R^{n\times n}$ symmetric with $S_{ii}=0$, $S\mathbf1=0$ and $\mathop{\mathrm{tr}}S^2=2$: $\ \tfrac12\big(\sum_{i,j}S_{ij}^3+\mathop{\mathrm{tr}}S^3\big)\le\Theta_n$, with $\Theta_n^2$ as stated at each parity, and equality iff $S$ is the negative unit block-constant matrix of a $\lfloor n/2\rfloor+\lceil n/2\rceil$ split.

Everything in it is inside Mathlib's reach; the one step that would need care is the attainment of the maximum on a compact sphere, which Mathlib has. **The part the record holds data for and the part it does not is not the split lean/INDEX.md's bucketing implies**, the whole statement above is proved. What is genuinely outside is only the identification of that block-constant matrix with *the Weyl tensor of a Riemannian product of round spheres*, which is a definitional bridge and not a classification.

## 11. What a consumer may cite, each claim read alone

| citable claim | may a consumer cite it? |
| --- | --- |
| $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for every diagonal $W$, every $n\ge4$, both parities | **Yes.** Fully proved; every step re-derived here |
| $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ (even), $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ (odd) | **Yes.** Both re-derived exactly in §4, and $\Theta_6=\sqrt{10}/3$ confirmed independently in §5(b) |
| the bound is **attained** at the balanced sphere product | **Yes.** §5 |
| the maximiser is **unique up to relabelling** | **Yes**, with the wording repaired: unique up to $S_n$ **at one sign only** |
| *"equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$"*, as literally written in all three forms | **No, not as written.** Under the record's own $V$ convention the named matrix is the minimiser. Cite instead: equality exactly at $-V/\lVert V\rVert$, $V$ the vertex matrix of the $\lfloor n/2\rfloor+\lceil n/2\rceil$ split |
| *"Equality is up to $\pm1\times S_n$"* | **No.** False; §8 |
| *"the balanced split beats every other sphere product"* | **Yes.** §5(a) |
| the ratio computation (c) as evidence that $Z(v)$ selects the balanced split | **No.** It holds at every split; §5(c) |
| *"proved by two independent arguments"* (step 3) | **With care.** Proof I is complete; Proof II's positivity sub-lemma is asserted and its $24$ monomials appear nowhere |
| *"the odd case rests on this theorem and on nothing published"* | **Yes**, and it is the load-bearing consequence: L57 imports nothing, so nothing published is doing work at odd $n$ |
| *"At even $n$, $\Theta_n=\theta_0(n)$"* | **Yes.** Immediate from the two closed forms |

**The gap between what is proven and what is used.** [results.md](../results.md):12, :35, :47, :59, :84 and :88 all rest the diagonal half of Problem P on L57, and :84 says the published grant is *"a courtesy rather than a dependency"*. **That load is carried.** The proven statement is at least as strong as every use I found. The one place where a consumer would inherit a defect is the equality clause, and its consumers are :98 and :268, which repeat it verbatim.

## 12. What would break it, and what I did to look

**The falsifier.** A matrix $S\in\mathcal D_n$ with $\mathop{\mathrm{tr}}S^2=2$ and $\tfrac12\big(\sum_{i,j}S_{ij}^3+\mathop{\mathrm{tr}}S^3\big)>\Theta_n$ at some $n\ge4$, equivalently, since the maximum is attained and the maximiser is critical, a **critical** $S$ with $\lambda>\Theta_n$. By §4 such an $S$ would have to break one of exactly three inequalities: the Cauchy–Schwarz of step 1, the Cauchy–Schwarz of step 2, or the fourth-moment minimum of step 3. **Where I looked.** Each of the three is an inequality between explicit polynomial quantities under explicit constraints, and I derived all three from scratch above rather than checking the source's algebra; there is no room in any of them for a counterexample, because each is a named classical inequality applied to vectors I constructed and verified lie in the right spaces. The one place where such an object could have hidden is step 3's *three-value* branch, which is where a minimiser could in principle beat the two-value bound, and that is exactly the branch [r123](../reviews/REVIEW_r123.md)'s circle argument eliminates by contradiction and [r124](../reviews/REVIEW_r124.md)'s $G\ge\frac1{n-1}$ eliminates by a bound. Both eliminations are checked in §3.

**A second, weaker falsifier, for the equality clause rather than the bound.** A second $S$, not an $S_n$-image of the first, attaining $\Theta_n$. This would need either a second minimiser of $\sum v^4$ (excluded: $pq$ has a unique maximum over $p+q=n$ at each parity) or a second unit vector in the block-constant line (excluded: the line is one-dimensional, and the two unit vectors in it are $\pm$, of which only one has $\theta>0$). **I found this falsifier's near-miss: it is exactly the $\pm$ pair, and the record's *"up to $\pm1\times S_n$"* claims both members of it. §8.**

## Verdict

**PROVEN, hypotheses corrected.**

The theorem is true as a mathematical statement, and I re-derived every step of it by hand, the criticality identity, both contractions, both Cauchy–Schwarz steps, the projection, the norm formula, the fourth-moment minimum, both parity constants, the compactness bridge, and an independent exact evaluation at $n=6$ landing on $\sqrt{10}/3$. The odd case is genuinely parity-free and genuinely unpublished-free. **F8 is refuted. F7 is confirmed against the ratio computation (c) and refuted as a charge against the theorem: balancedness is an output of step 3.**

**The corrections owed, in the order a consumer would meet them.**

1. **The equality clause's sign, in all three forms.** [problem.md](../findings/problem.md):557–579, [results.md](../results.md):98 and [results.md](../results.md):268 name the minimiser. Found by [r500](../reviews/REVIEW_r500.md) and [r123](../reviews/REVIEW_r123.md) and never applied.
2. **"Equality is up to $\pm1\times S_n$" is false.** It is $S_n$ alone. [problem.md](../findings/problem.md), *So the all-$n$ diagonal theorem is COMPLETE*.
3. **The block's "whole map" omits the bridge** that reaches the statement's quantifier. Add the heading.
4. **The pairing is never named.** Step 2 runs over unordered pairs against [conventions.md](../findings/conventions.md)'s stated ordered default; say so on the line.
5. **The normalisation $\lVert W\rVert^2=\sum_{a<b}M_{ab}^2$ is cited nowhere from this block**, though [diagonal-half.md](../findings/diagonal-half.md) carries it.
6. **The sign-correction bullet's constant is the odd-$n$ value, stated unqualified.**
7. **Heading (d) omits the cross value it argues about**; it lives three headings later.
8. **The block's summary of step 3 still calls it a smoothing**, which [r123](../reviews/REVIEW_r123.md) refuted in the very proof the block cites.
9. **The Lean row is misfiled** under a reason (the classification of compact symmetric spaces) that L57's proof never touches.
10. **Two silent hypotheses**: $\mu>0$ (free from hollowness plus $\mathop{\mathrm{tr}}S^2=2$, but nowhere written), and "largest eigenvalue", which is assumed and never used.

*None of the ten changes a constant. All ten change what a reader who cites this block ends up asserting, and the first two change it into something false.*
