# VERIFY_v198, Lemma L26, the dangerous eigenvalue of the two-block spectrum

**Cold read of [BRIEF_L26.md](BRIEF_L26.md), with the conventions quoted from [conventions.md](../findings/conventions.md).** **No numerical work of any kind was done**: no script, no Sage, no Python, no numeric evaluation. Everything below is closed-form hand derivation over the integers and rationals, including the two places where the record's own proof delegates to a script. The screening allowance was not needed and was not used. Log: [agent_logs/verify-L26-v198.log](../agent_logs/verify-L26-v198.log).

**The brief was truncated when I first read it.** Section C stopped mid-sentence at *"as free symbols, the same"*, cutting the three-block collapse, the criticality sentence and the whole *What it does not reach* paragraph. I noticed this on my first read and went to the source, [nondegeneracy.md](../findings/nondegeneracy.md) lines 78–106, so every verdict below was formed against the complete block rather than the truncated extract. The coordinator has since repaired the brief and I re-read section C against it; the restored text is identical to the source I had used, and no verdict changed.

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $X=\phi_\pi\odot\phi_\rho$ minus its $\Lambda^4$ part lies in $\mathrm{Weyl}_n$, trace-free and first Bianchi, separately | **PROVEN** |
| 2 | the Ricci part vanishes *because the support is disjoint index pairs* | **PROVEN**, and the reason given is the right one; the block omits the second half (that removing $\mathrm{Alt}$ preserves it), which is one line and true |
| 3 | coefficients $\tfrac23,\tfrac13,-\tfrac13$ on the three pairings | **PROVEN** |
| 4 | $\lVert X\rVert^2=\tfrac43$ | **PROVEN**, and it is what pins $\odot$ to $u\odot v=u\otimes v+v\otimes u$ |
| 5 | $e\circ X=\lambda X$ for **any** three-block diagonal $e$, $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ | **PROVEN**, re-derived here in closed form, not by enumeration |
| 6 | the eigenvalue $\mu=\frac{n-2}{2(p-1)(q-1)}$ | **PROVEN** |
| 7 | threshold $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$ | **PROVEN** |
| 8 | excess $\tfrac1{2(n-3)}$ at $p=2$ | **PROVEN** |
| 9 | *"the family reaches $\tfrac12$ exactly at $p=2$ … and at $(3,3)$"* (statements A and B) | **BROKEN as prose**, at $p=2$ the value is strictly above $\tfrac12$; statement C is the description the display supports |
| 10 | *"criticality is unused"* (statement B) | **BROKEN as written**, criticality is what fixes the three block values, and the object $e$ presupposes it; the canonical block states it correctly |
| 11 | *"proved for any three-block diagonal operator"* | **PROVEN**, and the hypothesis is sufficient rather than minimal |
| 12 | $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ as the criticality input | **HYPOTHESIS-DEBT**, true only of the representative $W_{p,q}=\frac{n-1}{pq}e$; at $\lVert W_{p,q}\rVert=1$ the value is $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, and a consumer has already read it the wrong way |
| 13 | the criterion $\lambda_{\max}<\mu$ clears to $3p+2q-4-pq>0$ and factors as $(p-2)(q-3)<2$ | **PROVEN** |
| 14 | over $q\ge p\ge3$ that admits exactly $(3,3)$ and $(3,4)$ | **PROVEN**, and the ordering hypothesis $q\ge p$ is load-bearing |
| 15 | the gap is $\frac1{2\max(p,q)-2}$ off the two exceptions, and $\tfrac1{12}$ at $(3,4)$ | **HYPOTHESIS-DEBT**, arithmetically right, but it is an upper bound on the whole spectrum, which this lemma does not supply and does not cite at that sentence |
| 16 | *"it bounds $\lambda_{\max}$ from below only"* | **PROVEN**, and both consumers stay inside the licence |
| 17 | the finite-verification argument (the plane $r$ is the third side of a triangle) | **PROVEN**; the *universe* claim beside it is asserted with a reason that does not cover the summation indices |

**One-line summary.** Every mathematical claim in L26 is correct and I re-derived all of them by hand, including the eigenvalue the record proves by script; what is defective is the prose around them, one hypothesis denied that is used, one binding case described as attainment when it is strict excess, one criticality constant quoted in an unstated normalisation that a downstream file has already misread, and one clause of the statement that belongs to [L27](../findings/nondegeneracy.md).

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- **The $\circ$ product**: *"$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$."*
- **$\#$**: *"$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$."*
- **Structure constants**: *"$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**."*
- **Bivector norm**: *"$\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing … which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal."*
- **$\mathrm{Alt}$**: *"$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ … $\mathrm{Alt}(H)=0$ for every $H$ satisfying the first Bianchi identity."*
- **$\odot$**: *"With $u\odot v=u\otimes v+v\otimes u$."*
- **Diagonal**: *"'Diagonal' means diagonal in coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$."*
- **$\mu$**: *"$\mu$ here is [L26](nondegeneracy.md)'s dangerous eigenvalue $\frac{n-2}{2(p-1)(q-1)}$, a fourth sense of a letter this table already flags as carrying three."*
- **Padding**: *"Padding commutes with $Q$, and preserves both the norm and $\theta$."*
- **Criticality**: *"'Critical point' is $Q(W)=\theta W$, the first-order condition on $\{\lVert W\rVert=1\}$."*

Symbol collisions I checked and cleared, since the brief names them. $\mu$, the block uses it only in the tabled L26 sense, never as the $\Lambda^2$ spectrum of [L67](../findings/bispectral.md) or as $-\min\omega$; there is no collision inside the block. $e$, used only as $W/\theta$; the record's other $e_i$ (frame vectors) never appear here. $X$, the block's $X$ is the eigenvector, distinct from the generic argument of the trilinear form $T(X,Y,Z)$, and the block's own $T_{ab}$ is a *fourth* use of $T$ that [conventions.md](../findings/conventions.md) does not table alongside the three it lists; it is defined in place, so it is legible, but the letter is now carrying four senses. $\pi,\rho$, coordinate 2-planes, used nowhere else in the record for a projection in this file. **$\phi_\pi$ is not tabled**: the record's bivector symbol is $\varphi_{ab}$, and $\phi_\pi$ appears only here. It is unambiguous, but claim 4's value is what fixes the pairing convention, and that dependency is invisible from the block, see §4.

## Hypothesis inventory

| hypothesis | where stated | used? |
| --- | --- | --- |
| $n=p+q$, i.e. the **unpadded** dimension | statement | **used**, $\mu$ is a function of $p+q$, not of any ambient dimension. See §9 on padding |
| $p,q\ge2$ | statement | **used**, two indices are needed in each block for $\pi$ and $\rho$ to exist; at $q=1$ the object does not exist |
| $\pi$ a coordinate 2-plane in the $p$-block, $\rho$ one in the $q$-block | statement | **used** throughout; "coordinate" is what makes $e$ diagonal on the four core indices |
| $\Lambda^4$ component removed | statement | **used**, without it $X\notin\mathrm{Weyl}_n$, and the eigen-equation fails: the raw $\phi_\pi\odot\phi_\rho$ is not an eigenvector |
| $e$ is the sphere product's, i.e. $e=W_{p,q}/\theta$ at a critical point | statement | **used**, and *only* at the final substitution, this is the criticality that statement B says is unused |
| $e$ diagonal with three block values | Argument | **used**, this is the real hypothesis of the eigen-equation |
| $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ | Argument | **used**, in an unstated normalisation, §7 |
| $q\ge p$ | the criterion sentence only | **used, and load-bearing**, the factored form is false as an unordered statement, §10 |
| $p,q\ge3$, $(p,q)\notin\{(3,3),(3,4)\}$ | gap clause | **used**, and the clause additionally consumes the completeness of the spectrum, which is not stated as a hypothesis anywhere in the block |
| the full multiplicity list / [L27](../findings/nondegeneracy.md) | *What it does not reach* | **used by the gap clause**, cited two paragraphs away from the sentence that needs it |

No hypothesis is stated and unused. One hypothesis is **used and denied**: criticality, in statement B. One is **used and never stated**: the completeness of the $L_e$ spectrum, in the gap clause.

## 1. $X\in\mathrm{Weyl}_n$, trace-freeness and first Bianchi, checked separately

Write $\pi=\mathrm{span}(e_1,e_2)$ inside the $p$-block and $\rho=\mathrm{span}(e_3,e_4)$ inside the $q$-block, so the four core indices are distinct, and let $X_0=\varphi_{12}\odot\varphi_{34}$.

**First Bianchi.** $\mathrm{Alt}$ is an orthogonal projection ([conventions.md](../findings/conventions.md)), so $\mathrm{Alt}(X)=\mathrm{Alt}(X_0)-\mathrm{Alt}^2(X_0)=0$, and a tensor with the pair symmetries and $\mathrm{Alt}=0$ satisfies the first Bianchi identity. This is immediate and needs nothing about the support.

**Trace-freeness.** The nonzero components of $X_0$ have $\{i,j\}=\{1,2\}$ and $\{k,l\}=\{3,4\}$, or the reverse. In $\mathrm{Ric}(X_0)_{ac}=\sum_b X_{0,abcb}$ a nonzero term needs $b\in\{1,2\}$ and $b\in\{3,4\}$ at once, which is impossible. So $\mathrm{Ric}(X_0)=0$ **exactly for the reason the block gives**: the two planes carry disjoint index pairs. The block stops there. The missing half-line is that the subtraction preserves it: for a totally antisymmetric $A$, $A_{abcb}$ is antisymmetric under exchanging the two slots that both carry $b$, hence vanishes termwise, so $\mathrm{Ric}(\mathrm{Alt}\,X_0)=0$ and $\mathrm{Ric}(X)=0$. **Both conditions hold, and they hold for different reasons, the block's single sentence covers only one of them.**

$X\ne0$ by §3, so the membership claim is not vacuous.

## 2. The support and the pairings

The three pairings of $\{1,2,3,4\}$ are $(12|34)$, $(13|24)$, $(14|23)$. Normalise $X_{0,1234}=1$; every other pairing is zero in $X_0$.

$\mathrm{Alt}(X_0)_{1234}=\tfrac13(X_{0,1234}+X_{0,1342}+X_{0,1423})=\tfrac13(1+0+0)=\tfrac13$.
$\mathrm{Alt}(X_0)_{1324}=\tfrac13(X_{0,1324}+X_{0,1243}+X_{0,1432})=\tfrac13(0-1+0)=-\tfrac13$.
$\mathrm{Alt}(X_0)_{1423}=\tfrac13(X_{0,1423}+X_{0,1234}+X_{0,1342})=\tfrac13(0+1+0)=\tfrac13$.

## 3. The coefficients $\tfrac23,\tfrac13,-\tfrac13$

Subtracting,

$$X_{1234}=1-\tfrac13=\tfrac23,\qquad X_{1324}=0+\tfrac13=\tfrac13,\qquad X_{1423}=0-\tfrac13=-\tfrac13 .$$

**Exactly the block's three coefficients, in that order.** The first Bianchi identity reads $X_{1234}+X_{1342}+X_{1423}=\tfrac23-\tfrac13-\tfrac13=0$, which is the independent check that the three signs belong together.

## 4. $\lVert X\rVert^2=\tfrac43$, and what it pins

With $\{\varphi_{ab}\}_{a<b}$ orthonormal and plain Frobenius on the pair matrix, the six nonzero entries are $(12,34)$ and $(34,12)$ at $\tfrac23$, $(13,24)$ and $(24,13)$ at $\tfrac13$, $(14,23)$ and $(23,14)$ at $-\tfrac13$:

$$\lVert X\rVert^2=2\Big(\tfrac49+\tfrac19+\tfrac19\Big)=\tfrac{12}9=\tfrac43 .$$

**And it cross-checks by Pythagoras.** $\lVert X_0\rVert^2=2$ under $u\odot v=u\otimes v+v\otimes u$, and $\lVert\mathrm{Alt}\,X_0\rVert^2=2\cdot3\cdot\tfrac19=\tfrac23$; since $\mathrm{Alt}$ is an orthogonal projection, $2=\tfrac43+\tfrac23$. **This is what makes $\tfrac43$ a real check rather than a restatement.**

*The value is convention-pinned and the block does not say so.* Under the other $\odot$ in circulation, $u\odot v=\tfrac12(u\otimes v+v\otimes u)$, the same object has $\lVert X\rVert^2=\tfrac13$. [conventions.md](../findings/conventions.md) tables $u\odot v=u\otimes v+v\otimes u$ but does so inside the $\mathring R$ section, for $S^2(\mathbb R^n)$; L26 applies $\odot$ to bivectors, in $S^2(\Lambda^2)$, which is not separately tabled. The two agree, so nothing is wrong, but a rebuild that takes the halved $\odot$ reproduces the three coefficients and misses $\tfrac43$ by a factor of four.

## 5. $e\circ X=\lambda X$ for any three-block diagonal $e$, derived, not enumerated

The record proves this by symbolic enumeration in [b_twoblock_symbolic.py](../scripts/lib/b_twoblock_symbolic.py). **I did not run it and I do not rely on it.** The whole computation closes by hand, as follows.

Polarising $Q(W)=W^2+W^\#$ gives $e\circ X=\tfrac12(eX+Xe)+e\# X$, and from the rank-one rule $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$,

$$(R\#S)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta\epsilon\zeta}c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}R_{\gamma\epsilon}S_{\delta\zeta},\qquad\text{so}\qquad (e\#X)_{\alpha\beta}=\tfrac12\sum_{\gamma}\varepsilon_\gamma\sum_{\delta\zeta}c_{\alpha\gamma\delta}c_{\beta\gamma\zeta}X_{\delta\zeta}$$

for $e$ diagonal. **This normalisation is the record's**: contracting it on the coordinate-diagonal case returns $R^\#_{ab,ab}=\sum_{c\ne a,b}R_{ac}R_{cb}$, the classical diagonal formula that [nondegeneracy.md](../findings/nondegeneracy.md)'s Gate 2 lists among its gatekeepers. It is also the block's own $T_{ab}=\sum_{m,r,t}c_{amr}\varepsilon_rc_{brt}X_{tm}$ up to the sign of one antisymmetric slot and the factor $2$.

With $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$, the constant $c_{\alpha\beta\gamma}$ is $\pm1$ when $\alpha,\beta,\gamma$ are the three sides of a triangle on three indices and $0$ otherwise. **So $\gamma$ and $\delta$ are determined by $\alpha$ up to which triangle: given $\alpha$ and $\gamma$ sharing one index, $\delta$ is the third side.** That is the block's finiteness sentence, and it is correct.

Write $x_1=X_{12,34}$, $x_2=X_{13,24}$, $x_3=X_{14,23}$; by §3, $(x_1,x_2,x_3)\propto(2,1,-1)$, and first Bianchi is $x_1-x_2+x_3=0$.

**The $(12,34)$ entry.** A common $\gamma$ must share one index with $12$ and one with $34$, so $\gamma\in\{13,14,23,24\}$, all mixed, all carrying $\varepsilon_{PQ}$. The four terms, with signs from the bracket:

| $\gamma$ | $\delta$ | $\zeta$ | $c_{12\gamma\delta}$ | $c_{34\gamma\zeta}$ | $X_{\delta\zeta}$ | term |
| --- | --- | --- | --- | --- | --- | --- |
| $13$ | $23$ | $14$ | $-1$ | $-1$ | $x_3$ | $+x_3$ |
| $14$ | $24$ | $13$ | $-1$ | $+1$ | $x_2$ | $-x_2$ |
| $23$ | $13$ | $24$ | $+1$ | $-1$ | $x_2$ | $-x_2$ |
| $24$ | $14$ | $23$ | $+1$ | $+1$ | $x_3$ | $+x_3$ |

So $(e\#X)_{12,34}=\tfrac12\varepsilon_{PQ}(2x_3-2x_2)=\varepsilon_{PQ}(x_3-x_2)=-\varepsilon_{PQ}x_1$ by Bianchi, and

$$(e\circ X)_{12,34}=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})x_1-\varepsilon_{PQ}x_1=\lambda x_1 .$$

**The $(13,24)$ entry.** Now $\gamma\in\{12,14,23,34\}$, and the two extreme ones carry the *block* values:

| $\gamma$ | $\varepsilon_\gamma$ | $\delta$ | $\zeta$ | $c_{13\gamma\delta}$ | $c_{24\gamma\zeta}$ | $X_{\delta\zeta}$ | term |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $12$ | $\varepsilon_{PP}$ | $23$ | $14$ | $+1$ | $-1$ | $x_3$ | $-x_3$ |
| $14$ | $\varepsilon_{PQ}$ | $34$ | $12$ | $-1$ | $+1$ | $x_1$ | $-x_1$ |
| $23$ | $\varepsilon_{PQ}$ | $12$ | $34$ | $-1$ | $+1$ | $x_1$ | $-x_1$ |
| $34$ | $\varepsilon_{QQ}$ | $14$ | $23$ | $+1$ | $-1$ | $x_3$ | $-x_3$ |

So $(e\#X)_{13,24}=-\tfrac{x_3}2(\varepsilon_{PP}+\varepsilon_{QQ})-x_1\varepsilon_{PQ}$, and adding the anticommutator's $\varepsilon_{PQ}x_2$,

$$(e\circ X)_{13,24}=-\tfrac{x_3}2(\varepsilon_{PP}+\varepsilon_{QQ})+(x_2-x_1)\varepsilon_{PQ}=\tfrac{x_2}2(\varepsilon_{PP}+\varepsilon_{QQ})-x_2\varepsilon_{PQ}=\lambda x_2,$$

using $x_2=-x_3$ and $x_2-x_1=-x_2$, both from $(2,1,-1)$. **The $(14,23)$ entry follows by the transposition $(3\,4)$**, which fixes $e$ (both indices lie in the $q$-block), sends $x_1\mapsto-x_1$ and exchanges $x_2\leftrightarrow x_3$, hence sends $X\mapsto-X$; equivariance of $\circ$ under $O(n)$ then carries the $(13,24)$ identity to $(14,23)$.

**Everything off the support vanishes.** Three cases, and none of them needs the values of $\varepsilon$:

- *$\alpha$ carries a spare index*, say $\alpha=\{1,s\}$ with $s\notin\{1,2,3,4\}$. Then $\gamma=\alpha\bigtriangleup\delta$ contains $s$, while $\zeta$ must be a core plane disjoint from $\delta$ for $X_{\delta\zeta}\ne0$; so $\gamma\cap\zeta=\emptyset$ and $c_{\beta\gamma\zeta}=0$ for every $\beta$. **Every term dies, for every $\beta$**, and by symmetry of $e\#X$ the same holds when $\beta$ carries the spare index. If both indices of $\alpha$ are spare, no triangle meets a core plane at all.
- *$\alpha=\beta$*: the two triangles coincide, so $\delta=\zeta$ and $X_{\delta\delta}=0$.
- *$\alpha\ne\beta$ both core, not a complementary pair*, the cases $(12,13)$, $(12,23)$, $(13,14)$ and their images. A common $\gamma$ is either $\{1,k\}$ with $k$ outside the two planes, forcing $\delta$ and $\zeta$ to share $k$, or the third core plane, forcing $\{\delta,\zeta\}$ to share an index. Either way $X_{\delta\zeta}=0$.

**So $e\circ X=\lambda X$ with $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$, for any $e$ diagonal in coordinate planes taking three block values. Claim 5: PROVEN**, and criticality was nowhere in it.

Two refinements the block does not make. **The hypothesis is sufficient, not minimal**: the derivation reads only $\varepsilon$ on the six core planes, so it suffices that the four mixed core planes share a value, an $e$ with any values on planes touching spare indices gives the same $\lambda$. And **"three-block" names three *plane* classes from two *index* blocks**, which the phrase invites a reader to hear as three index blocks.

## 6. The block values, and $\mu$, derived from scratch

[nondegeneracy.md](../findings/nondegeneracy.md):722 states $\varepsilon_{PP}=\frac q{(p-1)(n-1)}$, $\varepsilon_{QQ}=\frac p{(q-1)(n-1)}$, $\varepsilon_{PQ}=-\frac1{n-1}$. I derived them independently rather than taking them.

For $S^p(r_1)\times S^q(r_2)$ the curvature operator is coordinate-diagonal with sectionals $a,0,b$; the Weyl part is $W_{ij}=K_{ij}-\frac{\mathrm{Ric}_{ii}+\mathrm{Ric}_{jj}}{n-2}+\frac{\mathrm{scal}}{(n-1)(n-2)}$. Einstein forces $(p-1)a=(q-1)b$; normalise to $\mathrm{Ric}=\mathrm{id}$, so $a=\frac1{p-1}$, $b=\frac1{q-1}$, $\mathrm{scal}=n$, and the correction is $-\frac2{n-2}+\frac n{(n-1)(n-2)}=-\frac1{n-1}$:

$$W_{PP}=\frac1{p-1}-\frac1{n-1}=\frac q{(p-1)(n-1)},\qquad W_{QQ}=\frac p{(q-1)(n-1)},\qquad W_{PQ}=-\frac1{n-1}.$$

Ricci-freeness checks: $(p-1)W_{PP}+qW_{PQ}=1-\frac{p-1+q}{n-1}=0$. **These are the record's three values exactly.**

*They are $e$'s, not $W$'s, and the reason is that this tensor is already its own $e$.* With $u=W_{PP}$, $v=W_{QQ}$, $w=W_{PQ}$ and the classical diagonal formula,

$$Q(W)_{PP}=u^2+(p-2)u^2+qw^2=(p-1)u^2+qw^2=\frac{q^2/(p-1)+q}{(n-1)^2}=\frac q{(p-1)(n-1)}=u,$$
$$Q(W)_{PQ}=w^2+(p-1)uw+(q-1)vw=w\Big[\frac{-1+q+p}{n-1}\Big]=w .$$

So $Q(W)=W$ at this normalisation, i.e. $W=e$, and

$$\mu=\tfrac12(u+v)-w=\frac1{n-1}\Big[\frac{q(q-1)+p(p-1)}{2(p-1)(q-1)}+1\Big]=\frac{(n-1)(n-2)}{(n-1)\cdot2(p-1)(q-1)}=\frac{n-2}{2(p-1)(q-1)} .$$

**Claim 6: PROVEN.** Two independent corroborations, neither used in the derivation. $\lVert e\rVert^2=\binom p2u^2+\binom q2v^2+pqw^2=\frac{pq(n-2)}{2(n-1)(p-1)(q-1)}$, so $\theta^2=1/\lVert e\rVert^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, which is [problem.md](../findings/problem.md):170's Nienhaus Proposition 2.25 value, verbatim. At $p=q=\tfrac n2$ it gives $\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$ and at $\{p,q\}=\{\tfrac{n-1}2,\tfrac{n+1}2\}$ it gives $\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\tilde\theta_0(n)^2$, both as [conventions.md](../findings/conventions.md) records them. **A wrong $e$ would not reproduce two published closed forms.**

Also note $\mu=\tfrac12(a+b)$ in terms of the *metric's* sectionals: the Ricci and scalar corrections cancel identically in the combination $\tfrac12(W_{PP}+W_{QQ})-W_{PQ}$. The eigenvalue is half the sum of the two curvatures, which is why it is so simple.

## 7. Claim 12, the criticality constant is quoted in an unstated normalisation

**Located.** [nondegeneracy.md](../findings/nondegeneracy.md):99 and :722, *"$Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$"*.

**Exhibited in closed form.** $Q$ is homogeneous of degree two, so $Q(ce)=c^2Q(e)=c^2e=c\cdot(ce)$: a relation $Q(W)=\kappa W$ determines the representative, $W=\kappa e$. The quoted constant therefore says $W_{p,q}=\frac{n-1}{pq}e$, whose entries are $\frac1{p(p-1)},\frac1{q(q-1)},-\frac1{pq}$ and whose Ricci is $\frac{n-1}{pq}g$. Its norm is $\frac{n-1}{pq}\lVert e\rVert$, which at $(3,3)$ is $\tfrac59\sqrt{0.9}=0.527$, **not $1$**; and at $\lVert W_{p,q}\rVert=1$ the eigenvalue is $\theta=\sqrt{\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}}$, which at $(3,3)$ is $\theta_0(6)=\tfrac{\sqrt{10}}3=1.054$ against the quoted $\tfrac59=0.556$. **The two differ by no universal factor**, the ratio is $1.897$ at $(3,3)$ and $2.191$ at $(3,4)$, so this is not one of the tabled $\sqrt2$ or $2$ normalisation slips.

**Argued the opposite.** The block never asserts $\lVert W_{p,q}\rVert=1$, and [ATTEMPTS.md](../ATTEMPTS.md):2000 names the quantity *"$\theta_{\mathrm{raw}}=\frac{n-1}{pq}$"*, so read as a statement about a raw representative it is **true**, and L26's own use of it is sound: $e=W/\kappa$ is scale-invariant, the three $\varepsilon$'s at :722 are right, and $\mu$ is unaffected. The defect is that $W_{p,q}$ is the symbol every other file carries at unit norm, where [conventions.md](../findings/conventions.md) fixes *"'Critical point' is $Q(W)=\theta W$, the first-order condition on $\{\lVert W\rVert=1\}$"*.

**The candidate survives all three tests, and it is live rather than cosmetic**: [VERIFY_v136.md](VERIFY_v136.md):46 already tabulates the hypothesis as *"$W_{p,q}$ is a critical point of $P$ on the unit sphere, with $Q(W)=\theta W$"* and cites this very line as its source. A reader has taken the raw constant for the unit-sphere $\theta$. **The repair is one clause: say $\frac{n-1}{pq}$ is $\theta$ of the raw representative, or divide through and write $Q(e)=e$, which is what the argument actually uses.**

## 8. Claims 9 and 10, which description the display supports, and the hypothesis that is denied

**Claim 9.** $\mu\ge\tfrac12\iff n-2\ge(p-1)(q-1)\iff pq-2p-2q+3\le0\iff(p-2)(q-2)\le1$, which is claim 7, **PROVEN**, and symmetric in $p$ and $q$. Over $p,q\ge2$ the solution set is $\{p=2\}\cup\{q=2\}\cup\{(3,3)\}$, and the two components are of different kinds:

- at $\min(p,q)=2$, $(p-2)(q-2)=0<1$, so the inequality is **strict**: $\mu=\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}>\tfrac12$, which is claim 8, **PROVEN**;
- at $(3,3)$, $(p-2)(q-2)=1$ exactly, so $\mu=\tfrac12$.

**So statement C is the description the display supports, and statements A and B are not.** By [L24](../findings/second-order.md), $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$, so the kernel is the eigenspace **at** $\tfrac12$ and only the equality case is degeneracy; a value strictly above $\tfrac12$ is an ascent direction, costing maximality and contributing nothing to the kernel. A and B's *"reaches $\tfrac12$ exactly at $p=2$ … and at $(3,3)$"* collapses a strict excess with an attainment, and the record has already paid for that once, [nondegeneracy.md](../findings/nondegeneracy.md):437 records the same word inverting [L11](../findings/nondegeneracy.md) for two revisions. **[results.md](../results.md):435 and :138 still carry it.**

*And a second, smaller boundary slip in the same sentence.* The statement quantifies over $p,q\ge2$ with no ordering, so the exhaustive reading of its own display is $\min(p,q)=2$; "exactly at $p=2$" under-names the solution set. [L11](../findings/nondegeneracy.md) states it correctly as $\min(p,q)=2$, so the record holds both readings of one quantity. The mathematics is untouched (the family is symmetric under exchanging the blocks) but the word "exactly" is doing exhaustiveness work that the asymmetric form does not carry.

**Claim 10, checked against every step.** §1 (membership) uses no criticality; §5 (the eigen-equation) uses no criticality, only coordinate-diagonality and the three block values; §6 (the value) **uses it twice**, the Einstein condition $(p-1)a=(q-1)b$ is what selects the radii, and $e=W/\theta$ is not even defined at a non-critical $W$. So *"criticality is unused"* in [results.md](../results.md):138 is **false as written**, and the canonical block's *"criticality enters only through $Q(W_{p,q})=\ldots$, which fixes the three values"* is right. **The landscape line should read: criticality is unused in the eigenvector computation and fixes the number.** This is the trap of a step using a hypothesis that the statement denies, and it is the mirror image of the usual one.

## 9. Padding, and $\ker W\ne0$

The brief names these and the block does not discuss them, so: **the result survives padding, and the trap is in reading $n$.** If $W_{p,q}$ is padded into $\mathcal W_N$ with $N>n$, then $Q$ commutes with padding and preserves $\theta$ ([conventions.md](../findings/conventions.md)), so the padded $e$ is the padded old $e$ with $\varepsilon=0$ on every plane touching a padded index. My §5 derivation used the values of $\varepsilon$ only on the six core planes, and the off-support vanishing used no values at all, so $e\circ X=\mu X$ holds verbatim at the padded dimension **with $\mu=\frac{n-2}{2(p-1)(q-1)}$, $n=p+q$, not $N$**. A consumer who reads $n$ as the ambient dimension gets a different and wrong number. The record is consistent with this: [L11](../findings/nondegeneracy.md) records that at a padded dimension the $p=2$ family *is* degenerate through [L126](../findings/second-order.md)'s padded four-set carrying $\frac1{2(p-1)}$, **a different family, not this one**, and the two must not be conflated.

$\ker W\ne0$ is not a hazard here: $e$ has a large kernel at every sphere product ([nondegeneracy.md](../findings/nondegeneracy.md) records $\ker L_e$ as four block-support subspaces), and nothing in §1–§6 inverts $e$, divides by an $\varepsilon$, or assumes $e$ is definite. The one division is by $\theta$, which is nonzero at a critical point of positive value.

## 10. The exception at $(3,4)$, the criterion, the factorisation, and the lattice count

The within-factor family is $\lambda_m=\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ ([nondegeneracy.md](../findings/nondegeneracy.md):722ff, and [second-order.md](../findings/second-order.md):595 for its derivation), increasing in $m$, so $\lambda_{\max(p,q)}$ is the larger of the two. At $(3,4)$, $\lambda_4=\tfrac13$ and $\mu=\frac5{12}$, so $\mu$ is the larger; the block's two numbers are right.

**The criterion.** With $q=\max(p,q)$, $\lambda_q<\mu$ reads $\frac{q-2}{2(q-1)}<\frac{p+q-2}{2(p-1)(q-1)}$; multiplying by $2(q-1)>0$ and then by $(p-1)>0$,

$$(q-2)(p-1)<p+q-2\iff pq-q-2p+2<p+q-2\iff 3p+2q-4-pq>0,$$

**the block's inequality exactly.** And since $(p-2)(q-3)=pq-3p-2q+6$, the same inequality is $(p-2)(q-3)-2<0$, i.e. $(p-2)(q-3)<2$. **Claim 13: PROVEN.**

**The lattice count.** Put $a=p-2\ge1$ and $b=q-3\ge0$ over $q\ge p\ge3$. If $b=0$ then $q=3$, and $q\ge p\ge3$ forces $p=3$: the point $(3,3)$, product $0<2$. If $b\ge1$ then $ab\ge1$, and $ab<2$ forces $ab=1$, so $a=b=1$: the point $(3,4)$. If $a\ge2$ and $b\ge1$ then $ab\ge2$ and the inequality fails. **Exactly $(3,3)$ and $(3,4)$; claim 14: PROVEN**, by exhausting the integer cases rather than by scanning.

**The ordering hypothesis is load-bearing and the block does state it.** $(p-2)(q-3)<2$ is not symmetric, and read over unordered pairs it admits the whole family $(p,3)$ for every $p$, at $(5,3)$ it gives $3\cdot0=0<2$, while the honest comparison there uses $\max=5$ and reads $(3-2)(5-3)=2$, which fails. The block's *"over $q\ge p\ge3$"* is exactly the guard that closes this, and dropping it would turn a two-point exception list into an infinite one. **This is the one place the brief's unordered-pairs trap could have bitten, and the block does not fall into it.**

**The boundary of the criterion, checked.** $(3,5)$ and $(4,4)$ are the equality cases $(p-2)(q-3)=2$, where $\mu=\lambda_{\max}$ exactly ($\tfrac38$ and $\tfrac13$) so both formulas for the gap agree there and nothing is at stake. This is corroborated by the record's own tabled spectra at [nondegeneracy.md](../findings/nondegeneracy.md):705, which I checked against my closed forms without running anything: at $3{+}5$ the entry $\tfrac38^{44}$ is $\mu$ at multiplicity $c_3c_5=30$ plus $\lambda_5$ at $s_5=14$; at $5{+}5$, $\tfrac14^{100}=\mu$ at $c_5c_5$ and $\tfrac38^{28}=\lambda_5$ at $s_5+s_5$; at $3{+}7$, $\tfrac13^{63}=\mu$ at $c_3c_7$ and $\tfrac5{12}^{27}=\lambda_7$ at $s_7$. **Every tabled multiplicity is reproduced by the two closed forms.**

**One editorial correction.** The block explains the five splits' miss by *"it is a single lattice point in the region the inequality closes off"*. The likelier reason is plainer: those five splits are at $n=8,8,10,10,10$ and $(3,4)$ is at $n=7$, **the smallest admissible split in the clause's own range, and the scan began above it.** The region argument is true of the region and does not explain the scan.

## 11. The gap clause, and what it needs that this lemma does not have

$\frac1{2\max(p,q)-2}=\tfrac12-\lambda_{\max(p,q)}$, and $\tfrac1{12}=\tfrac12-\tfrac5{12}$; the arithmetic is right. **But both are statements that nothing in the spectrum lies between, which is an upper bound on the whole spectrum**, precisely what the block's own *What it does not reach* paragraph says an exhibited eigenvector cannot supply. The clause is therefore not proved by this lemma; it consumes the completeness of the ten-value list, i.e. [L27](../findings/nondegeneracy.md), and **the citation sits two paragraphs below the sentence that needs it**, attached instead to the uniqueness and multiplicity claims.

*The ranges do line up*, which is why this is a debt and not a break: L27 covers $p,q\ge3$ with $(p,q)\ne(3,3)$, exactly the gap clause's range.

**The inherited hypothesis, and it is misquoted in this block.** L26's Sources say Nienhaus Proposition 4.6 *"supplies the $SO(p)\times SO(q)$ decomposition in which this family is the $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ summand, for $p,q\ge5$"*. The proposition, quoted at [nienhaus notes](../references/nienhaus-2023-second-best-einstein/notes.md):31, reads *"Let $k,l\in\mathbb N$ with $k+l=n$ and $k,l\ge5$, $k,l\ne6$"*, and that file's next line warns *"Hypotheses matter and are frequently misquoted."* **The block drops $k,l\ne6$.** Concretely: at $(6,6)$, $n=12$ (the balanced product this programme's constants are read at), the cited proposition does not apply as quoted, and neither does it at $(4,6)$, one of the five splits the block names. Arguing the opposite: L27 does not rest on the citation alone, deriving multiplicity-freeness from Young labels for every $p,q\ge3$ and checking that the ten dimensions sum to $\dim\mathrm{Weyl}_n$ identically in $p,q$; so the decomposition may well hold far outside Nienhaus's stated range. **The candidate survives as a citation defect: what is written imports a theorem at hypotheses the source does not grant, and the repair is either to restore $\ne6$ or to cite L27's own derivation instead.**

**Claim 15: HYPOTHESIS-DEBT.** What would have to be proved for the clause to stand on its own feet: *the $L_e$ spectrum at $S^p\times S^q$ contains no value in $(\max(\lambda_{\max(p,q)},\mu),\tfrac12)$, for every $p,q\ge3$ with $(p,q)\ne(3,3)$*, which is L27's business, not L26's.

**A wording point that is not a defect.** *"The second-largest eigenvalue is $\mu$"* at $(3,4)$ is third-largest if $1$ is counted; read as "largest below the orbit's $\tfrac12$", which is the sense the gap needs, it is right.

## 12. Claim 16, the direction of the bound, and what each consumer may take

**An exhibited eigenvector gives $\lambda_{\max}\ge\mu$ and $\dim E(\mu)\ge1$, and nothing else.** So L26 licenses exactly: a value being *attained*; a multiplicity being *at least* something; and, through the threshold, the two failure statements below.

- **[L11](../findings/nondegeneracy.md) may cite it for two things and does.** *Non-maximality at $\min(p,q)=2$*: exhibiting one direction with $\mu>\tfrac12$ suffices, since a single ascent direction kills maximality, a lower-bound use. *Degeneracy at $(3,3)$*: exhibiting eigenvectors at exactly $\tfrac12$ beyond the orbit tangent makes the kernel too large, again a lower bound, and degeneracy is the direction that lower bounds settle. **L11 may not cite it for nondegeneracy at $p,q\ge3$**, which needs $\dim E(\tfrac12)\le pq$, and L11 does not: its proof line takes $\mu$ and the threshold from L26 and then says *"[Lemma L27] then shows that in the remaining range $\tfrac12$ is attained on the orbit tangent alone"*. **The division of labour is correct as written.**
- **[L133](../results.md):787 may cite it for attainment only.** Its sentence *"The supremum is attained on [Lemma L26]'s direction in every $(2,2)$-split four-subset"* is a witness claim, which is what an eigenvector gives; the *equality* $\kappa_n^{\mathrm{Hess}}=\frac{27}2\theta_0(\frac2{n-2}-\frac12)$ needs an upper bound over all directions, which must come from [second-order.md](../findings/second-order.md) and not from here. Consistency check that costs nothing: at the balanced split $\mu=\frac{n-2}{2(\frac n2-1)^2}=\frac2{n-2}$, which is exactly the bracket in L133's closed form, **so L133 is taking $\mu$ and the maximiser, and the record's arithmetic agrees.**

**Claim 16: PROVEN, and no consumer over-reads it.** The one caution is that the gap clause inside L26's own statement is the upper-bound-shaped claim, so the lemma states more than its final paragraph says it can prove.

## 13. What would falsify this, and what I did to look for it

**The object.** A pair $q\ge p\ge3$ with $(p,q)\notin\{(3,3),(3,4)\}$ at which $\lambda_{\max(p,q)}<\mu$, this would break the exception list and the gap clause at once; or, more damagingly, a coordinate-diagonal three-block $e$ for which $e\circ X$ has a nonzero component off the three pairings, which would make $X$ no eigenvector at all and take $\mu$ with it.

**What I did.** For the first: solved $(p-2)(q-3)<2$ exactly over the integer lattice by exhausting the three cases $b=0$, $a=b=1$, $a\ge2\wedge b\ge1$ (§10), **no such pair exists**, and the argument leaves no residue for a scan to find. This is the point at which the brief forbids re-running the five-split scan, and I did not: the exhaustion replaces it and is stronger, since it covers every $p,q$ rather than five. For the second: carried $\varepsilon_{PP},\varepsilon_{QQ},\varepsilon_{PQ}$ as free symbols through the whole $\#$ contraction (§5), so any off-support component would have appeared as a surviving term with a free $\varepsilon$ attached; the three off-support cases each die from the structure of the triangle condition, before any value of $\varepsilon$ is chosen. **No such $e$ exists.** For the eigenvalue itself, I looked for a falsifier in the normalisation instead (the likeliest place for it) and found the two independent closed forms $\theta_0(n)^2$ and $\tilde\theta_0(n)^2$ falling out of my $e$, which a wrong $e$ would not do.

**Where a falsifier could still hide: the gap clause, and nowhere else in this lemma.** An eigenvalue of $L_e$ strictly between $\max(\lambda_{\max(p,q)},\mu)$ and $\tfrac12$ at some $p,q\ge3$ would leave every claim of §1–§10 standing and break claim 15. Finding or excluding one is L27's problem, it requires the completeness of the decomposition, and **it is not settled inside L26**.

## Verdict

**PROVEN, hypotheses corrected.**

The mathematics is entirely sound and I re-derived every piece of it by hand: membership, the three coefficients, the norm, the eigen-equation for any three-block diagonal operator, the eigenvalue, the threshold, the excess, the criterion, its factorisation and the lattice count. Four corrections are owed to the prose around it:

1. **[results.md](../results.md):435 and :138**, *"reaches $\tfrac12$ exactly at $p=2$"* must be split into **exceeds** at $\min(p,q)=2$ and **equals** at $(3,3)$, as [nondegeneracy.md](../findings/nondegeneracy.md):89 already does; and "$p=2$" should read "$\min(p,q)=2$".
2. **[results.md](../results.md):138**, *"criticality is unused"* is false of the displayed $\mu$; criticality fixes the three block values and defines $e$. It is unused in the eigenvector computation, which is what the canonical block says.
3. **[nondegeneracy.md](../findings/nondegeneracy.md):99 and :722**, $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ holds of the raw representative $W_{p,q}=\frac{n-1}{pq}e$, not at $\lVert W_{p,q}\rVert=1$, where $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$. [VERIFY_v136.md](VERIFY_v136.md):46 has already read it the other way.
4. **[nondegeneracy.md](../findings/nondegeneracy.md):106**, the Sources line drops Nienhaus Proposition 4.6's $k,l\ne6$.

And one debt stands, named in §11: the gap clause is an upper bound on the spectrum, it is L27's to prove, and its citation is not attached to the sentence that needs it.
