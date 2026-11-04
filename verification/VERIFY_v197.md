# Verification v197, Lemma L26, the dangerous eigenvalue of the two-block spectrum

*Verifier v197, cold reader. The brief [BRIEF_L26.md](BRIEF_L26.md) was read cold, before any other file. **No numerical work of any kind was done**, no script, no Sage, no Python, no floating point. Every number below is closed-form arithmetic done by hand on objects constructed for the purpose, which is the screening allowance in [analysis-only.md](../.claude/rules/analysis-only.md); none of it is offered as evidence for a positive claim. In particular the five splits whose scan missed $(3,4)$ were **not** re-run. Log: [agent_logs/verify-L26-v197.log](../agent_logs/verify-L26-v197.log).*

*__The brief was truncated when I first read it__, section C ending mid-sentence at "…as free symbols, the same". I had already read the source block at [findings/nondegeneracy.md](../findings/nondegeneracy.md) lines 78–106 in full, directly, before the coordinator's correction arrived, so the three items that rest on the cut passage ("criticality is unused", "any three-block diagonal operator", and the direction of the bound), were settled against the complete text. I re-read the restored brief and confirmed it matches the source verbatim.*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $X=\phi_\pi\odot\phi_\rho$ minus its $\Lambda^4$ part satisfies first Bianchi | **PROVEN** |
| 2 | $X$ is Ricci-flat, "because its support is disjoint index pairs" | **PROVEN**, and the stated reason is the right one |
| 3 | Coefficients $\tfrac23,\tfrac13,-\tfrac13$ on the three pairings | **PROVEN**, and forced, not merely computed |
| 4 | $\lVert X\rVert^2=\tfrac43$ | **PROVEN** at the record's own $\odot$ and bivector normalisations |
| 5 | $e\circ X=\lambda X$ for **any** three-block diagonal $e$, $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ | **PROVEN**, re-derived here by hand, entry by entry |
| 6 | "Criticality is unused" | **PROVEN for the eigenvector and for $\lambda$**; criticality *is* used to collapse $\lambda$ to $\mu$, as the block says and the landscape line does not |
| 7 | $\mu=\frac{n-2}{2(p-1)(q-1)}$ | **PROVEN** |
| 8 | $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$ | **PROVEN** |
| 9 | Excess $\tfrac1{2(n-3)}$ at $p=2$ | **PROVEN** |
| 10 | The binding cases are $p=2$ (strict) and $(3,3)$ (equality) | **PROVEN, statement C is right, statements A and B are defective** |
| 11 | $\lambda_{\max}<\mu$ clears to $3p+2q-4-pq>0$ | **PROVEN**, but **false under the block's own other live sense of $\lambda_{\max}$** |
| 12 | It factors as $(p-2)(q-3)<2$ | **PROVEN**, exact identity |
| 13 | Over $q\ge p\ge3$ that admits exactly $(3,3)$ and $(3,4)$ | **PROVEN** |
| 14 | At $(3,4)$, $\mu=\tfrac5{12}$, $\lambda_{\max(p,q)}=\tfrac13$, gap $\tfrac1{12}$ | **PROVEN** |
| 15 | Otherwise for $p,q\ge3$ the gap is $\tfrac1{2\max(p,q)-2}$ | **HYPOTHESIS-DEBT**, true, but not reachable from L26 and cited to nothing |
| 16 | "It bounds $\lambda_{\max}$ from below only" | **PROVEN, and claim 15 violates it** |
| 17 | $\frac{n-1}{pq}$ "fixes the three values" | **GAP**, the ratios are fixed by two Ricci-flatness equations that are never stated, and the constant is at an unstated non-standard normalisation |
| 18 | $X\perp$ orbit tangent, needed for the $(3,3)$ conclusion | **not on file in this block** |

**Summary in one line.** The eigenvalue, its threshold, its excess, its coefficients, its norm, the three-block generality and the whole $(3,4)$ closure criterion all re-derive exactly and by hand; what fails is the **gap clause**, which is an upper bound on the spectrum sitting inside a lemma whose own next paragraph says it supplies only lower bounds, cited to nothing, together with three notational and one accounting defect.

**Verdict: `HYPOTHESIS-DEBT`.**

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), not restated:

- > **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.
- > $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself
- > $\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$
- > **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**
- > **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal
- > **$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$**, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$. So … $\mathrm{Alt}(H)=0$ for every $H$ satisfying the first Bianchi identity
- > With $u\odot v=u\otimes v+v\otimes u$
- > **$\mu$ here is [L26](nondegeneracy.md)'s dangerous eigenvalue $\frac{n-2}{2(p-1)(q-1)}$**, a fourth sense of a letter this table already flags as carrying three.
- > **A critical orbit is Morse–Bott nondegenerate when $\ker\mathrm{Hess}_SP$ equals the orbit tangent exactly.** Via [L24](second-order.md)'s $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ that kernel is the eigenspace **at** $\tfrac12$, *so an eigenvalue **above** $\tfrac12$ off the orbit costs maximality and contributes nothing to the kernel, and the two failures must never be collapsed.*
- > $\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$**

Two conventions L26 needs are **not in that file and not in the block**: the meaning of the word **"gap"**, and the normalisation of **$W_{p,q}$** at which $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$. Both are load-bearing; see §7 and §9.

## Hypothesis inventory

| hypothesis | stated? | used? | where |
| --- | --- | --- | --- |
| $n=p+q$ exactly, no padding | yes, in the statement | **yes**, and critically: the $\mu$ formula reads $n=p+q$, so a padded consumer who substitutes the ambient $n'$ gets a wrong number | §10 |
| $p,q\ge2$ | yes | yes, $(p-1)(q-1)\ne0$ is needed for $\mu$ to exist | §5 |
| $\pi\subseteq P$, $\rho\subseteq Q$, both coordinate 2-planes | yes | yes, disjointness of the four core indices is the whole of §1–§4 | §1–§5 |
| $e$ is diagonal in the coordinate-pair basis, with the value depending only on the plane's block type | **implicit only**, the block says "the sphere product's $e$" and reveals the three-block hypothesis only in the *proof* | **yes**, it is the sole structural hypothesis of the eigenvector computation | §5 |
| $e$ is self-adjoint / $T$ symmetric | no | not needed for the eigenvector; needed by consumers |, |
| $Q(e)=e$ (criticality) | via "$Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$" | **yes**, and only to fix the scale of the three $\varepsilon$'s | §9 |
| $\mathrm{Ric}(e)=0$ and $\mathop{\mathrm{tr}}e=0$, i.e. $e\in\mathcal W_n$ | **never stated** | **yes**, these two equations are what fix the *ratios* $\varepsilon_{PP}:\varepsilon_{QQ}:\varepsilon_{PQ}$, and criticality fixes only the remaining scalar | §9 |
| $q\ge p$ | stated for the lattice count only | used there; **not** stated for the gap clause, which is written unordered | §8 |
| completeness of the ten-summand $O(p)\times O(q)$ decomposition, and $L_e$ scalar on each summand | **never stated in this block** | **yes**, the gap clause is unreachable without it | §7 |
| $X\perp$ orbit tangent | **never stated** | **yes** for the $(3,3)$ degeneracy conclusion | §11 |

## 1. $X\in\mathrm{Weyl}_n$: first Bianchi, **PROVEN**

Fix the four core indices $1,2\in P$ and $3,4\in Q$, so $\pi=\mathrm{span}(e_1,e_2)$ and $\rho=\mathrm{span}(e_3,e_4)$, and write $R^0=\phi_\pi\odot\phi_\rho$. Membership in $\mathrm{Weyl}_n$ needs two independent conditions, and the brief is right to insist they be checked apart: **first Bianchi**, and **Ricci-flatness**. The block's one-clause justification addresses the second only; the first is carried by the construction.

By [conventions.md](../findings/conventions.md), $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$ and kills exactly the tensors satisfying first Bianchi. "With its $\Lambda^4$ component removed" is therefore $X=(\mathrm{Id}-\mathrm{Alt})R^0$, and $\mathrm{Alt}\,X=(\mathrm{Alt}-\mathrm{Alt}^2)R^0=0$ by idempotence. So $X$ satisfies first Bianchi. This is definitional and there is nothing further to check.

## 2. $X\in\mathrm{Weyl}_n$: Ricci-flatness, **PROVEN, and the stated reason is the right one**

The block says the Ricci part vanishes *"because its support is disjoint index pairs"*. That reason is exactly correct, and it covers $X$ itself rather than only $R^0$, which is the point a careless reader would miss, since $X$ acquires support on the two cross pairings that $R^0$ lacks.

Write $\mathrm{Ric}(R)_{ij}=\sum_aR_{iaja}$. A component $R_{ijkl}$ of $X$ is nonzero only when $\{i,j\}$ and $\{k,l\}$ are the two halves of one of the three partitions of $\{1,2,3,4\}$ into two pairs, and in **all three** partitions the two pairs are disjoint. For $R_{iaja}$ to be nonzero the summation index $a$ would have to lie in both halves at once, and the halves are disjoint. So every term vanishes and $\mathrm{Ric}(X)=0$.

The one step the block elides is that the removed piece is itself Ricci-flat, so that no Ricci can leak in through the subtraction. For a totally antisymmetric $A$, swapping the second and third slots of $A_{iaja}$ gives $A_{iaja}=-A_{ijaa}=0$. This is one standard line, and I record it as an elision rather than a gap: the conclusion is unaffected either way, because the disjointness argument in the paragraph above applies to $X$ directly.

## 3. The coefficients $\tfrac23,\tfrac13,-\tfrac13$, **PROVEN, and forced**

Coordinatise $S^2(\Lambda^2)$ on the core by the three pairings: let $a=R_{1234}$, $b=R_{1324}$, $c=R_{1423}$, the pair symmetry and the two antisymmetries fixing every other component.

A pure $4$-form $\omega=e_1\wedge e_2\wedge e_3\wedge e_4$ sits at $(a,b,c)=(1,-1,1)$, since $\omega_{1324}=-\omega_{1234}$.

Normalise $R^0$ by $R^0_{1234}=1$, which is the record's own $\odot$, [conventions.md](../findings/conventions.md) fixes $u\odot v=u\otimes v+v\otimes u$, so $\phi_\pi\odot\phi_\rho$ places $1$ at the $(12),(34)$ entry. Then $R^0=(1,0,0)$ and

$$\mathrm{Alt}(R^0)_{1234}=\tfrac13(R^0_{1234}+R^0_{1342}+R^0_{1423})=\tfrac13(1-0+0)=\tfrac13,$$

using $R^0_{1342}=-R^0_{1324}=-b$. So $\mathrm{Alt}(R^0)=\tfrac13\omega=(\tfrac13,-\tfrac13,\tfrac13)$ and

$$X=R^0-\mathrm{Alt}(R^0)=\left(\tfrac23,\ \tfrac13,\ -\tfrac13\right).$$

Two independent confirmations. **First**, Bianchi in these coordinates reads $a-b+c=0$, and $\tfrac23-\tfrac13-\tfrac13=0$. **Second**, and more strongly, §5 shows the coefficients are *forced* by the eigenvector property rather than merely consistent with it: requiring $(e\circ X)_{(13),(24)}=\lambda X_{(13),(24)}$ for all three block values independently gives $-\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})(c+b)=\varepsilon_{PQ}(a-2b)$, hence $c=-b$ and $a=2b$, which is $\tfrac23:\tfrac13:-\tfrac13$ exactly.

## 4. $\lVert X\rVert^2=\tfrac43$, **PROVEN**

By [conventions.md](../findings/conventions.md) the record runs at $\lVert\varphi_{ab}\rVert^2=1$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal and an element of $S^2(\Lambda^2)$ is a symmetric matrix in that basis under the Frobenius pairing over **ordered** pairs of pair-indices, which is [conventions.md](../findings/conventions.md)'s stated default. $X$ has zero diagonal and exactly three off-diagonal entries $a,b,c$, each appearing twice, so

$$\lVert X\rVert^2=2(a^2+b^2+c^2)=2\left(\tfrac49+\tfrac19+\tfrac19\right)=2\cdot\tfrac23=\tfrac43 .$$

A third check that the two claims share one normalisation: $\lVert R^0\rVert^2=2$ and $\lVert\mathrm{Alt}\,R^0\rVert^2=2\cdot\tfrac39=\tfrac23$, and $2=\tfrac43+\tfrac23$, so Pythagoras holds for the orthogonal splitting $R^0=X+\mathrm{Alt}\,R^0$. **The coefficients and the norm are consistent with each other and with the record's own $\odot$; under the competing $\odot=\tfrac12(u\otimes v+v\otimes u)$ they would read $\tfrac13,\tfrac16,-\tfrac16$ and $\tfrac13$, so the block's two numbers jointly pin the convention even though the block cites none.**

## 5. $e\circ X=\lambda X$ for any three-block diagonal $e$, **PROVEN, re-derived here**

I did not take this on the scripts' authority. The whole computation is finite and I carried it out by hand; it is short enough to write down.

**Setup.** $Q(X)=X^2+X^\#$ polarises to $X\circ Y=\tfrac12(XY+YX)+X\# Y$, and the record's $\#$ gives, in the orthonormal pair basis,

$$(e\#X)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta\zeta}\varepsilon_\gamma\,c_{\alpha\gamma\delta}\,c_{\beta\gamma\zeta}\,X_{\delta\zeta},$$

which is the block's $T_{ab}$ up to the factor $-2$ that the block never names. In $\mathfrak{so}(n)$, $[\varphi_{ij},\varphi_{jk}]=\varphi_{ik}$, so $c_{\alpha\beta\gamma}\ne0$ exactly when the three planes are the three sides of a triangle on three indices. **The block's claim that $r$ is determined by $a$ and $m$ is correct**, and it is what makes the sum finite.

**Support, first.** In a nonzero term, $X_{\delta\zeta}\ne0$ forces $\delta,\zeta$ to be a disjoint core pairing, say $\delta=\{d,d'\}$ and $\zeta=\{z,z'\}$ with $\delta\sqcup\zeta=\{1,2,3,4\}$. The index $\gamma$ must complete a triangle with $\delta$ and another with $\zeta$, so $\gamma$ has one index in each: $\gamma=\{d,z\}$. Then $\alpha=\gamma\triangle\delta=\{d',z\}$ and $\beta=\gamma\triangle\zeta=\{d,z'\}$, and $\{\alpha,\beta\}$ is again a disjoint core pairing. **So $e\# X$ is supported on the three pairings and nowhere else**, in particular on no plane carrying a spare index; and the anticommutator part is supported inside $\mathop{\mathrm{supp}}X$ trivially. This settles the block's universe claim without appeal to the enumeration: no spare index survives at all, so "four core indices plus two spare in each block" is generous rather than tight, and the "identically in $p$ and $q$" conclusion is sound because no sum over ambient indices is left to grow.

**The $(12),(34)$ entry.** The anticommutator gives $\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})a$. For the $\#$ part, $\gamma$ must be a cross plane, $\gamma\in\{(13),(14),(23),(24)\}$, each of type $PQ$, and the four terms are

| $\gamma$ | $\delta$ | $\zeta$ | $c_{(12)\gamma\delta}$ | $c_{(34)\gamma\zeta}$ | $X_{\delta\zeta}$ | product |
| --- | --- | --- | --- | --- | --- | --- |
| $(13)$ | $(23)$ | $(14)$ | $-1$ | $-1$ | $c$ | $+\varepsilon_{PQ}c$ |
| $(14)$ | $(24)$ | $(13)$ | $-1$ | $+1$ | $b$ | $-\varepsilon_{PQ}b$ |
| $(23)$ | $(13)$ | $(24)$ | $+1$ | $-1$ | $b$ | $-\varepsilon_{PQ}b$ |
| $(24)$ | $(14)$ | $(23)$ | $+1$ | $+1$ | $c$ | $+\varepsilon_{PQ}c$ |

so $(e\#X)_{(12),(34)}=\tfrac12\varepsilon_{PQ}(2c-2b)=\varepsilon_{PQ}(c-b)=-\tfrac23\varepsilon_{PQ}=-\varepsilon_{PQ}a$, and

$$(e\circ X)_{(12),(34)}=\left[\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}\right]a .$$

**The $(13),(24)$ entry**, structurally different because the anticommutator now returns $\varepsilon_{PQ}$ rather than the block average. Here $\gamma\in\{(12),(34),(14),(23)\}$:

| $\gamma$ | type | $\delta$ | $\zeta$ | $c_{(13)\gamma\delta}$ | $c_{(24)\gamma\zeta}$ | $X_{\delta\zeta}$ | product |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $(12)$ | $PP$ | $(23)$ | $(14)$ | $+1$ | $-1$ | $c$ | $-\varepsilon_{PP}c$ |
| $(34)$ | $QQ$ | $(14)$ | $(23)$ | $+1$ | $-1$ | $c$ | $-\varepsilon_{QQ}c$ |
| $(14)$ | $PQ$ | $(34)$ | $(12)$ | $-1$ | $+1$ | $a$ | $-\varepsilon_{PQ}a$ |
| $(23)$ | $PQ$ | $(12)$ | $(34)$ | $-1$ | $+1$ | $a$ | $-\varepsilon_{PQ}a$ |

giving $(e\#X)_{(13),(24)}=-\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})c-\varepsilon_{PQ}a$. With $c=-b$ and $a=2b$ this is $\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})b-2\varepsilon_{PQ}b$, and adding the anticommutator's $\varepsilon_{PQ}b$,

$$(e\circ X)_{(13),(24)}=\left[\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}\right]b .$$

**The $(14),(23)$ entry** follows by the reflection $\sigma$ swapping $e_3$ and $e_4$. It preserves the block structure, hence fixes $e$ and commutes with $\circ$; it sends $\phi_\rho\mapsto-\phi_\rho$ and so $X\mapsto-X$. Therefore $\sigma(e\circ X)=-(e\circ X)$, and since $\sigma$ carries the $(13),(24)$ entry to the $(14),(23)$ entry with sign $+1$, the third coefficient is $-\lambda b=\lambda c$.

**Conclusion.** $e\circ X=\lambda X$ with $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$, for every operator diagonal in the coordinate-pair basis whose value depends only on the plane's block type. **The block's formula is exactly right, and its generality claim is exactly right.**

## 6. "Criticality is unused", and "any three-block diagonal operator", **both PROVEN, with one compression hazard**

The derivation in §5 uses **one** hypothesis: that $e$ is diagonal in the coordinate-pair basis with a value depending only on the plane's type. No criticality, no $Q(e)=e$, no Weyl condition on $e$, no self-adjointness beyond what diagonality already gives, no $p,q$ bound beyond the existence of the four core indices. So *"the same computation yields $e\circ X=\lambda X$ for **any** three-block diagonal operator"* is correct as written, and I confirm it against every step rather than against the block's assertion.

**The compression hazard sits in the landscape line, not in the block.** [results.md](../results.md) line 138 reads *"Proved for any three-block diagonal operator; criticality is unused"*, in a sentence whose headline number is $\mu$. Read alone (which is how a landscape line is read) that says $\mu$ needs no criticality, and it does: $\lambda$ is criticality-free, $\mu$ is not. The canonical block states the distinction correctly (*"criticality enters only through …, which fixes the three values and collapses $\lambda$ to $\mu$"*); the landscape line drops the second half of the sentence and keeps the first.

## 7. The collapse to $\mu$, and the threshold, **PROVEN**

The block substitutes $\varepsilon_{PP}=\frac{q}{(p-1)(n-1)}$, $\varepsilon_{QQ}=\frac{p}{(q-1)(n-1)}$, $\varepsilon_{PQ}=-\frac1{n-1}$. I verified these four ways before using them, since the block asserts them without derivation.

- **They are trace-free.** $\binom p2\varepsilon_{PP}+\binom q2\varepsilon_{QQ}+pq\,\varepsilon_{PQ}=\frac{pq}{2(n-1)}+\frac{pq}{2(n-1)}-\frac{pq}{n-1}=0$.
- **They are Ricci-flat.** For $i\in P$, $(p-1)\varepsilon_{PP}+q\,\varepsilon_{PQ}=\frac{q}{n-1}-\frac{q}{n-1}=0$; symmetrically for $i\in Q$.
- **They satisfy $Q(e)=e$.** For a coordinate-diagonal operator the classical formula reads $Q(K)_{ij}=K_{ij}^2+\sum_{k\ne i,j}K_{ik}K_{kj}$. On a $PP$ plane this is $(p-1)\varepsilon_{PP}^2+q\,\varepsilon_{PQ}^2=\frac{q}{(n-1)^2}\left[\frac{q}{p-1}+1\right]=\frac{q}{(n-1)(p-1)}=\varepsilon_{PP}$; on a mixed plane it is $\varepsilon_{PQ}^2+\varepsilon_{PQ}\frac{p+q}{n-1}=\frac{1-n}{(n-1)^2}=\varepsilon_{PQ}$.
- **They are the geometry.** For the Einstein product with $K_{PP}=\frac1{p-1}$, $K_{QQ}=\frac1{q-1}$, $K_{PQ}=0$, the scalar curvature is $n$ and the scalar part sits at $\frac1{n-1}$ on every plane, so the Weyl sectional values are $\frac1{p-1}-\frac1{n-1}=\frac{q}{(p-1)(n-1)}$ and $0-\frac1{n-1}$, the block's three numbers exactly, with no rescaling.

Then, with $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$,

$$\lambda=\frac1{2(n-1)}\cdot\frac{q(q-1)+p(p-1)+2(p-1)(q-1)}{(p-1)(q-1)}=\frac1{2(n-1)}\cdot\frac{n^2-3n+2}{(p-1)(q-1)}=\frac{n-2}{2(p-1)(q-1)}=\mu .$$

**The collapse is exact.** A fifth check ties it to the record's own constants: $\lVert e\rVert^2=\frac{pq(n-2)}{2(n-1)(p-1)(q-1)}$, so $\theta=1/\lVert e\rVert$, and at $p=q=n/2$ this gives $\theta^2=\frac{2(n-1)(n-2)}{n^2}$, which is [conventions.md](../findings/conventions.md)'s $\theta_0(n)^2$ verbatim; at $(3,3)$ it gives $\theta=\sqrt{10/9}=1.0541$, the tabled $\Theta_6$.

**The threshold.** $\tfrac12-\mu=\frac{(p-1)(q-1)-(n-2)}{2(p-1)(q-1)}$ and $(p-1)(q-1)-(n-2)=pq-2p-2q+3=(p-2)(q-2)-1$, so

$$\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)},\qquad \mu\ge\tfrac12\iff(p-2)(q-2)\le1$$

with the denominator positive throughout $p,q\ge2$. **PROVEN.**

**The excess.** At $p=2$, $q=n-2$ and $q-1=n-3$, so $\mu=\frac{n-2}{2(n-3)}$ and $\mu-\tfrac12=\frac{(n-2)-(n-3)}{2(n-3)}=\frac1{2(n-3)}$. **PROVEN**, and note it is a **strict positive excess** at every $n\ge5$.

## 8. Which statement describes the display, **statement C, and A and B are defective**

The brief gives the two descriptions unlabelled and asks the mathematics to decide. It does, unambiguously.

The display carries $\ge$, and the solution set of $(p-2)(q-2)\le1$ over integers $p,q\ge2$ splits into two structurally different pieces:

| region | value of $(p-2)(q-2)$ | what $\mu$ does |
| --- | --- | --- |
| $p=2$, any $q\ge2$ (and symmetrically $q=2$) | $0$ | $\mu>\tfrac12$, **strictly**, by $\tfrac1{2(n-3)}$ |
| $(p,q)=(3,3)$ | $1$ | $\mu=\tfrac12$, **exactly** |

**So statement C, [findings/nondegeneracy.md](../findings/nondegeneracy.md), "at $p=2$, where $\mu$ **exceeds** $\tfrac12$ … and at $(3,3)$, where it **equals** it", is the correct reading, and statements A and B are not.**

This is a discrepancy and I have cleared all three tests on it.

- **Located exactly.** [results.md](../results.md) line 435, the canonical statement: *"the family reaches $\tfrac12$ exactly at $p=2$ … and at $(3,3)$, where it is an equality"*; and [results.md](../results.md) line 138, the landscape line: *"$\mu\ge\tfrac12$ exactly at $p=2$ and at $(3,3)$"*.
- **Exhibited in closed form.** At $(p,q)=(2,4)$, $n=6$: $\mu=\frac{4}{2\cdot1\cdot3}=\tfrac23$. That is $\tfrac12+\tfrac16$, and $\tfrac16=\frac1{2(6-3)}$. So $\mu\ne\tfrac12$ at $p=2$, and no member of the $p=2$ family attains $\tfrac12$ at any $n$. One split, exact arithmetic, no computation.
- **Argued the opposite.** The defence is that "reaches" may be read as "attains or passes", under which A is true. The record itself refuses that defence and pays for it: [L11](../findings/nondegeneracy.md) records that *"the seed of the error is one word in Lemma L26's prose, 'the family reaches $\tfrac12$ exactly at $p=2$'"*, that *"quoted without the display, 'reaches' reads as 'attains', and $\mu\ge\tfrac12$ failing becomes $\mu=\tfrac12$ holding"*, and that a paragraph in L11 drew exactly that inference for two revisions. [conventions.md](../findings/conventions.md)'s own Morse–Bott row states the reason the two must part: an eigenvalue **above** $\tfrac12$ costs maximality and contributes **nothing** to the kernel, while an eigenvalue **at** $\tfrac12$ is degeneracy. The defence fails.

**The defect is live and the fix was applied to only one of the two canonical copies.** The block in [findings/nondegeneracy.md](../findings/nondegeneracy.md) carries the corrected wording together with an explicit instruction (*"the two cases must never be collapsed into a word like 'reaches'"*) and [results.md](../results.md), which is the copy a consumer meets first and which calls itself the canonical statement, still carries the word "reaches" and still says the family "reaches $\tfrac12$ … at $p=2$, where it gives the recorded excess $\tfrac1{2(n-3)}$". That sentence contradicts itself: an excess of $\tfrac1{2(n-3)}>0$ is precisely the assertion that $\tfrac12$ is **not** attained.

**Owed:** results.md line 435 and line 138 to be brought to the C wording. This is a documentation repair, not a mathematical one, the mathematics is C's and it is right.

## 9. The normalisation of $W_{p,q}$, **GAP in the accounting**

The block writes: *"criticality enters only through $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$, which fixes the three values and collapses $\lambda$ to $\mu$."* Two things are wrong with that sentence, and one of them is a hypothesis used but never stated.

**The equation does not fix the three values.** What fixes the ratios is that $e$ lies in $\mathcal W_n$: Ricci-flatness is two equations on the three block values and forces $\varepsilon_{PP}=\frac{q}{p-1}t$, $\varepsilon_{QQ}=\frac{p}{q-1}t$, $\varepsilon_{PQ}=-t$ for a free scale $t$; trace-freeness is then automatic. Only the remaining scalar $t$ is fixed by criticality, through $Q(e)=e$, which forces $t^2q\frac{n-1}{p-1}=\frac{q}{p-1}t$, hence $t=\frac1{n-1}$. **The two Ricci-flatness equations are the hypothesis this step actually runs on and they appear nowhere in the block.** That is precisely the trap named in the brief: a step using a hypothesis never stated.

**The constant is at an unstated normalisation, and it is not any of the record's three.** At the values the block itself substitutes, $Q(e)=e$ (I verified this in §7) so the $Q$-eigenvalue is $1$, not $\frac{n-1}{pq}$. At $(3,3)$ the three candidates are: $1$ at the geometric Einstein-product normalisation and at its Weyl part alike; $\Theta_6=1.0541$ at the record's unit norm; and $\frac{n-1}{pq}=\tfrac59=0.5556$ as written. All three differ.

Discrepancy protocol, cleared:

- **Located.** [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 99, and again at line 722 in the L27 material. It is absent from [results.md](../results.md), so only the findings copy carries it.
- **Exhibited in closed form.** At $(3,3)$ the substituted values are $\varepsilon_{PP}=\varepsilon_{QQ}=\tfrac3{10}$ and $\varepsilon_{PQ}=-\tfrac15$; the classical diagonal formula gives $Q(K)_{PP}=2\cdot\tfrac9{100}+3\cdot\tfrac1{25}=\tfrac{18}{100}+\tfrac{12}{100}=\tfrac3{10}$, so the eigenvalue is $1$ against the stated $\tfrac59$.
- **Argued the opposite.** The rescue is that $W_{p,q}$ carries its own scale, distinct from $e$'s, namely $W_{p,q}=\frac{n-1}{pq}e$, at which the equation is true by construction and dividing by $\frac{n-1}{pq}$ recovers $e$. That rescue works for the *equation* and is internally consistent. It does not rescue the phrase "fixes the three values", and it leaves the scale undeclared: a consumer who reads $\frac{n-1}{pq}$ as the $\theta$ of the record's unit-normalised $W_{p,q}$ gets $\tfrac59$ where the record's own table gives $1.0541$.

**Verdict.** The mathematics of the collapse is correct (I re-derived it) and the sentence describing it misattributes the work. Recorded as a `GAP` in the accounting rather than a refutation of the result: the Ricci-flatness hypothesis is owed in writing, and the normalisation at which $\frac{n-1}{pq}$ holds is owed a name.

## 10. The $(3,4)$ criterion and the lattice count, **PROVEN, both halves**

Here $\lambda_{\max(p,q)}$ means the $S^2_0(\mathbb R^M)$ family value $\lambda_M=\frac{M-2}{2(M-1)}$ at $M=\max(p,q)$, which the file's own spectrum display fixes. Take $q\ge p$, so $M=q$.

**The comparison clears as claimed.** $\frac{q-2}{2(q-1)}<\frac{p+q-2}{2(p-1)(q-1)}$; multiply by $2(q-1)>0$ and then by $(p-1)>0$:

$$(q-2)(p-1)<p+q-2\iff pq-q-2p+2<p+q-2\iff 3p+2q-4-pq>0 .$$

**The factorisation is an identity.** $(p-2)(q-3)=pq-3p-2q+6$, so $3p+2q-4-pq=2-(p-2)(q-3)$, and the condition is exactly $(p-2)(q-3)<2$.

**The lattice count is complete.** Over $q\ge p\ge3$: at $p=3$ the condition is $q-3<2$, i.e. $q\in\{3,4\}$; at $p\ge4$ it needs $(p-2)(q-3)<2$ with $p-2\ge2$ and $q-3\ge p-3\ge1$, so the product is already $\ge2$ and there is no solution. **Exactly $(3,3)$ and $(3,4)$.**

**The boundary is where the record's five scanned splits sat, and the criterion explains why they missed it.** At $(4,4)$ the product is exactly $2$ (equality, $\mu=\lambda_4=\tfrac13$) so the gap formula still returns the right number there and the scan saw nothing. $(3,4)$ is the single interior lattice point, and it is the one split absent from $(3,5)$, $(4,4)$, $(3,7)$, $(5,5)$, $(4,6)$. **I did not re-run that scan and did not need to**; the criterion settles the closure in two lines.

**Values at the exception.** $\mu(3,4)=\frac{7-2}{2\cdot2\cdot3}=\tfrac5{12}$, $\lambda_4=\frac{2}{2\cdot3}=\tfrac13$, so the second-largest eigenvalue below $\tfrac12$ is $\tfrac5{12}$ and the gap is $\tfrac12-\tfrac5{12}=\tfrac1{12}$. **PROVEN.**

**Screen against the record's own spectra.** Reading the file's table as recorded data and checking it against the closed forms $\mu$, $\lambda_m=\frac{m-2}{2(m-1)}$, $s_m=\frac{(m+2)(m-1)}2$, $c_m=\frac{m(m-1)}2$ and $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$: at $(3,5)$, $\mu=\tfrac38$ coincides with $\lambda_5=\tfrac38$ and the multiplicities add as $c_3c_5+s_5=30+14=44$, matching $\tfrac38^{44}$, with $s_3s_5=70$ at $-\tfrac38$ and the total $70+165+5+44+15+1=300=\dim\mathcal W_8$. At $(3,7)$, $\mu=\tfrac13$ at $c_3c_7=63$ and $-\tfrac13$ at $s_3s_7=135$, $\lambda_7=\tfrac5{12}$ at $s_7=27$, total zeros $770-252=518$. At $(4,6)$, $\mu=\tfrac4{15}$ at $90$ and $-\tfrac4{15}$ at $180$, $\lambda_6=\tfrac25$ at $20$, $\lambda_4=\tfrac13$ at $9$, zeros $446$. **Every recorded row reproduces exactly.** This is a screen on data already on the record, run to test my own formulas, and it is reported as a screen.

## 11. The direction of the bound, and what L11 and L133 may each cite, **the gap clause fails here**

The block's own scope paragraph is correct and I confirm it: *"An exhibited eigenvector bounds $\lambda_{\max}$ and one multiplicity from **below**."* From $e\circ X=\mu X$ with $X\ne0$ one may conclude $\mu\in\mathop{\mathrm{spec}}L_e$, hence $\lambda_{\max}\ge\mu$ and $\dim E(\mu)\ge1$, and nothing more.

**What each consumer may take.**

| consumer | may cite from L26 | may not |
| --- | --- | --- |
| [L11](../findings/nondegeneracy.md) | the closed forms $\mu$ and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$; that $\mu>\tfrac12$ at $\min(p,q)=2$, hence **not a maximiser**; that $\mu=\tfrac12$ at $(3,3)$, hence the Morse–Bott **criterion fails** there | that $\lambda_{\max}=\tfrac12$, that $(3,3)$ is the **unique** failure, or that $\dim E(\tfrac12)=pq$, every one of these is an upper bound on the rest of the spectrum |
| [L133](../results.md) | the **direction** $X$ itself, and $e\circ X=\mu X$ on each $(2,2)$-split four-subset, a witness at which its ratio is achieved | that the supremum **is attained** there, which needs an upper bound over all directions and must come from L133's own argument |

**L11's citation is correct in direction.** Its proof paragraph takes only the closed form from L26 and then says explicitly *"Lemma L27 then shows that in the remaining range $\tfrac12$ is attained on the orbit tangent alone"*, attributing the upper bound to L27, not to L26. **L133's citation is correct in direction too**, since it cites L26 for the extremal direction and carries its own supremum argument.

**The failure is inside L26 itself.** The clause *"For $p,q\ge3$ other than $(3,3)$ and $(3,4)$ the gap is $1/(2\max(p,q)-2)$"* asserts that $\lambda_M$ is the **second-largest** eigenvalue of $L_e$ below $\tfrac12$. That is an upper bound on everything else in the spectrum, exactly the kind of statement the next paragraph of the same block says no eigenvector supplies. And the block cites nothing for it.

Discrepancy protocol, cleared:

- **Located.** [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 89, the gap clause, against the *"What it does not reach"* paragraph fourteen lines below it; and [results.md](../results.md) line 435, where the clause appears with no surrounding context at all.
- **Exhibited in closed form.** At $(5,5)$ the clause asserts the gap is $\tfrac18$, i.e. that nothing lies in the open interval $(\tfrac38,\tfrac12)$. Everything L26 proves is compatible with a spectrum containing $\tfrac{9}{20}$: L26 exhibits $\mu=\tfrac14$ as an eigenvalue and says nothing whatever about what else is present. So the clause is not a consequence of L26's argument, a hypothetical operator with that extra eigenvalue satisfies every claim L26 proves and falsifies the gap clause.
- **Argued the opposite.** The defence is that the gap clause is a corollary of the spectrum table sitting higher in the same file, recorded at L26 for the reader's convenience. That defence fails on two counts. It carries no citation inside the L26 block, not to L27, not to Nienhaus, not to the multiplicity list. And it does not survive the move to [results.md](../results.md), where the clause stands inside Lemma L26's own statement, with Lemma L27 stated separately at line 441 **without** the gap, so a reader of results.md receives the gap clause on L26's authority alone.

**Verdict: `HYPOTHESIS-DEBT`.** The gap clause is **true**, it follows from the ten-summand $O(p)\times O(q)$ decomposition being complete and $L_e$ being scalar on each summand, which [L27](../findings/nondegeneracy.md) establishes, drawing on Nienhaus Proposition 4.6 for $p,q\ge5$ and on an exact commutant computation at $p,q\le4$. What is owed is the hypothesis in writing: **"assuming the ten-summand decomposition of L27, so that the listed values exhaust the spectrum"**, with the citation. Note that the exceptional splits the clause is most delicate at ($(3,3)$, $(3,4)$, $(3,5)$, $(4,4)$), are precisely the ones Nienhaus does not cover, so at those the clause rests on the commutant computation rather than on the cited proposition.

## 12. The traps, each answered by name

### 12.1 $\ker W\ne0$ and padded objects

The statement fixes $n=p+q$, and at that dimension $e$ is diagonal in the pair basis with all three block values nonzero for $p,q\ge2$, so $\ker e=0$ and $\ker W=0$. **L26 has no exposure at its own dimension.**

Under padding to $n'>p+q$ the picture parts in two, and the block says only *"padding changes the answer at $p=2$"* without saying how. What I find:

- **The eigenvector survives.** Padding adds flat directions $F$, so $e$ acquires three further block values, all zero, and becomes six-block. My derivation in §5 never used the values of $\varepsilon$ off the core, and the support argument confines every nonzero term to planes inside $\{1,2,3,4\}$, whose types are unchanged. So $e\circ X=\mu X$ still holds, with the same $\mu$, provided $\mu$ is read at $n=p+q$.
- **The formula is a trap for the padded reader.** $\mu=\frac{n-2}{2(p-1)(q-1)}$ carries $n$, and a consumer working at ambient $n'$ who substitutes $n'$ gets a number that is not an eigenvalue of anything. [L11](../findings/nondegeneracy.md) records the cost of exactly this omission, *"THE DIMENSION IS PART OF THE STATEMENT, AND OMITTING IT IS WHAT MADE THE TWO READINGS LOOK CONTRADICTORY"*, and L26's own display does not say which $n$.
- **The gap clause does not survive padding at all**, since the padded spectrum acquires a large kernel and the multiplicity list is a statement about $\mathcal W_{p+q}$. The clause carries no dimension hypothesis of its own beyond the statement's $n=p+q$, which is adequate, but a reader who has just been told the eigenvector claim is padding-stable will not expect the gap clause to be padding-fragile.

### 12.2 The boundary of every stated range

**$p=2$.** The threshold, the excess and the eigenvector all hold there, and §8 settles that $\mu$ **exceeds** rather than attains. One further boundary fact the block records and does not derive: at $(2,2)$ the spectrum is $(-1)^4,(\tfrac12)^4,1^2$ and $1$ is not simple, because $\mu(2,2)=\frac{2}{2\cdot1\cdot1}=1$ collides with the $\langle W\rangle$ eigenvalue. My formula reproduces that: $c_2c_2=1$, so the $+\mu$ summand is one-dimensional and $1$ has multiplicity $1+1=2$, matching the recorded $1^2$; and $s_2s_2=0$ with $s_2=0$, so no $-\mu$ appears, and $\dim E(\tfrac12)=pq=4$. **The recorded $(2,2)$ spectrum is consistent with the closed forms**, which is worth stating because [L11](../findings/nondegeneracy.md) leans on it as a witness.

**$(3,3)$.** $\mu=\tfrac12$ exactly, and the closed form $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ vanishes there and nowhere else with $p,q\ge3$. The multiplicity arithmetic corroborates: $c_3c_3=9$ joins $pq=9$ to give $\dim E(\tfrac12)=18$ against an orbit of $9$, which is the record's figure exactly.

**$(3,4)$.** Handled in §10; the criterion closes it and the equality boundary at $(4,4)$ is where the old scan survived by luck.

**$q\ge p$ against unordered pairs, a live inconsistency.** The block mixes the two conventions inside one paragraph. The criterion sentence says *"over $q\ge p\ge3$"*, an **ordered** reading. The gap clause says *"For $p,q\ge3$ other than $(3,3)$ and $(3,4)$"*, an **unordered** reading in which $(4,3)$ is an unnamed exception, a reader at $p=4,q=3$ finds $(p,q)\ne(3,4)$ and applies $\frac1{2\max-2}=\tfrac16$ where the true gap is $\tfrac1{12}$. The same mismatch is in the main statement: $p,q\ge2$ is unordered, and *"binds at exactly two places … at $p=2$ … and at $(3,3)$"* silently omits $q=2$, which the display admits on equal terms. Neither is a mathematical error ($\mu$, $X$ and the whole construction are symmetric under $(p,q)\mapsto(q,p)$) but the statement asserts a count ("**exactly** two places") that is false under its own unordered hypothesis. **Owed: one declared ordering, used throughout.**

### 12.3 A claim proven on a subfamily and used in general

This is the trap the record already paid for and has since repaired. The gap formula $\frac1{2\max(p,q)-2}$ was originally inferred from five splits and stated universally; $(3,4)$ was outside the five and falsifies the universal form. The repair is a criterion rather than a wider scan, and §10 confirms the criterion is exact and its lattice count complete. **The trap is closed, and the block says so honestly.** What remains is 12.2's ordering slip, which reopens a sliver of it at $(4,3)$.

### 12.4 A hypothesis stated but never used, and a step using one never stated

**Stated and never used:** none found. Every hypothesis in the statement does work, see the inventory.

**Used and never stated:** three.

1. **Ricci-flatness and trace-freeness of $e$**, which is what fixes the ratios of the three block values (§9). The block credits this to criticality, which fixes only the scale.
2. **The three-block hypothesis on $e$ itself**, which appears only in the proof. The statement says *"for the sphere product's $e$"*, so the reader learns the actual hypothesis of the computation (diagonal in the coordinate-pair basis, value by block type), one paragraph later.
3. **The completeness of the spectrum**, for the gap clause (§11).

### 12.5 A universal claim with no witness

Three universal claims sit in the block. $e\circ X=\mu X$ for all $p,q\ge2$ has a proof, finite verification, and I reproduced it in §5. The criterion's closure over $q\ge p\ge3$ has a proof, and it is additionally machine-checked: [L26.lean](../lean/HamiltonsCubic/Results/L26.lean) carries `condition_factors` by `ring`, `comparison_clears` under $3\le p\le q$, and `only_two_solutions` over $\mathbb Z$, which is the lattice count of §10 discharged in Lean. The **gap clause** is the universal claim with no witness in the block; §11.

### 12.6 An imported theorem whose hypotheses were never checked against the object

L26's own argument imports **nothing**, it is self-contained in the structure constants of $\mathfrak{so}(n)$ and the definition of $\circ$. So the failure mode the brief names, a cited theorem assuming a unital algebra where $\mathcal W_n$ has no unit, has no purchase on the eigenvector claim: no algebra structure on $\mathcal W_n$ beyond the bilinear $\circ$ is used, no identity element is invoked, and no theorem is applied to $\mathcal W_n$ as an algebra.

The one import in the vicinity is Nienhaus Proposition 4.6, cited in the Sources as supplying the decomposition *"for $p,q\ge5$"*. The L26 eigenvalue claim does not rest on it. The **gap clause** does, and its hypothesis $p,q\ge5$ is checked and found **not** to cover the splits the clause is most delicate at ($(3,3)$, $(3,4)$, $(3,5)$, $(4,4)$) which is recorded in §11.

### 12.7 Symbol collisions

**$\lambda$, three senses inside the L26 block, and one of them makes a sentence false.** The block uses $\lambda$ for the general three-block eigenvalue, $\lambda_{\max(p,q)}$ for the $S^2_0(\mathbb R^M)$ family value, and $\lambda_{\max}$ bare in *"The comparison $\lambda_{\max}<\mu$ clears to $3p+2q-4-pq>0$"*. The landscape line uses $\lambda_{\max}$ in a **fourth** sense, $\lambda_{\max}(L_e|_{W^\perp})$, in *"It bounds $\lambda_{\max}$ from below only"*.

Discrepancy protocol, cleared:

- **Located.** [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 89, the sentence beginning *"The comparison $\lambda_{\max}<\mu$"*, against [results.md](../results.md) line 138's *"It bounds $\lambda_{\max}$ from below only"*.
- **Exhibited in closed form.** Under the landscape line's sense, $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ throughout the range, so $\lambda_{\max}<\mu$ reads $\tfrac12<\mu$, which clears to $(p-2)(q-2)<1$, an inequality with **no** solutions over $p,q\ge3$, and not $3p+2q-4-pq>0$. So the sentence is true under one live sense and false under another live sense of the same symbol, both of them the block's own.
- **Argued the opposite.** The defence is that the preceding sentence has just written $\lambda_{\max(p,q)}=\tfrac13$, so context disambiguates. Against that: [INDEX-results.md](../findings/INDEX-results.md) line 41 records *"Both reviewers misread which quantity the clause names"*, the collision has already misled two independent readers on this exact clause, and the prose was not changed after they did.

**Owed:** write $\lambda_M$ or $\lambda_{\max(p,q)}$ in the criterion sentence and reserve $\lambda_{\max}$ for the spectral maximum.

**$\mu$.** [conventions.md](../findings/conventions.md) tables L26's $\mu$ as a fourth sense of a letter already carrying three, and the record in fact carries two more, the measure $\mu=\sum_kg_k\delta_{\lambda_k}$ at [bounds.md](../findings/bounds.md) line 407 and the apolarity multiplication in the $\mathrm{Cat}_F$ row. Inside the L26 block the sense is unambiguous. **No defect, but the table's count is now low by two.**

**$\rho$.** L26's $\rho$ is a coordinate $2$-plane in the $q$-block; the same file uses $\rho_{jl}=\sum_{a\in P}V_{jala}$ for a partial Ricci trace some six hundred lines later. Same file, unrelated objects, and $\rho$ is untabled. **A collision worth tabling.**

**$X$, $\pi$, $e$.** $X$ is local to the block and clear; $\pi$ collides with nothing live ($\Pi$'s four senses are the capital); $e$ is [conventions.md](../findings/conventions.md)'s $W/\theta$, and the block relies on that without citing it, which the quote-don't-restate rule permits but which leaves *"the sphere product's $e$"* undefined for a reader who starts at [results.md](../results.md).

**"Gap".** The word is used four times in the block and defined nowhere, here or in [conventions.md](../findings/conventions.md). It means $\tfrac12$ minus the largest eigenvalue strictly below $\tfrac12$, which the reader can only recover from the L27 material three hundred lines away, and which is **not** the natural reading "distance from $\lambda_{\max}$ to the next eigenvalue", since $\lambda_{\max}=1$ on $\langle W\rangle$. **Owed: a definition.**

### 12.8 One further omission: $X\perp$ the orbit tangent

The $(3,3)$ conclusion needs $X$ to be an eigenvector at $\tfrac12$ **off** the orbit tangent; without that, $\mu=\tfrac12$ is consistent with $\dim E(\tfrac12)=pq$ and shows no degeneracy at all. The block never says this. It is not a defect in the record, [L27](../findings/nondegeneracy.md) supplies it, the orbit tangent being the $\mathbb R^p\otimes\mathbb R^q$ summand and $X$ lying in $\Lambda^2\otimes\Lambda^2$, orthogonal summands, but it is a step the L26 block uses and does not state, and the usual argument from distinct eigenvalues is unavailable at exactly the point it is needed, since $\mu=\tfrac12$ there. **Owed: one sentence in the block, or a pointer to L27.** I screened the claim and it holds; I record that as a screen and not as the record's proof, which remains L27's.

## What would falsify this, and what I did to look for it

**The object.** A three-block diagonal $e$ on $\mathbb R^{p+q}$ and a pair of coordinate $2$-planes $\pi\subseteq P$, $\rho\subseteq Q$ for which $(e\circ X)$ has a nonzero component **off** the three pairings of the four core indices, equivalently, a nonzero entry $(e\circ X)_{\alpha\beta}$ with $\alpha$ or $\beta$ carrying an index outside $\{1,2,3,4\}$. Such an object would make $X$ not an eigenvector and would collapse the lemma to nothing, and it is the one thing the block's proof asserts on the strength of an enumeration it does not display.

**What I did.** Rather than search for it, I proved it cannot exist, in §5: in any nonzero term of $(e\#X)_{\alpha\beta}$ the index $\gamma$ must complete a triangle with each of two **disjoint** core planes $\delta,\zeta$, so $\gamma$ has one index in each, and then $\alpha=\gamma\triangle\delta$ and $\beta=\gamma\triangle\zeta$ are built entirely from core indices and form a disjoint core pairing themselves. No spare index reaches the output. The anticommutator half cannot leave $\mathop{\mathrm{supp}}X$ at all. **So the falsifier does not exist, and the block's "the verification is finite" is not merely finite but two lines.**

**A second falsifier, for the gap clause.** A split $p,q\ge3$ outside $\{(3,3),(3,4)\}$ carrying an $L_e$ eigenvalue strictly between $\frac{M-2}{2(M-1)}$ and $\tfrac12$. I did **not** look for one, searching for it is a spectral census, which is reserved under the analysis-only rule and which is in any case the wrong instrument: the clause's status turns on whether the ten-summand decomposition exhausts $\mathcal W_n$, which is L27's question and not L26's. That is why §11 is a hypothesis debt and not a refutation.

**A third, for the closure criterion.** An integer pair $q\ge p\ge3$ outside $\{(3,3),(3,4)\}$ with $(p-2)(q-3)<2$. The two-line argument in §10 rules it out for every $p\ge4$ at once and enumerates $p=3$ completely, so no scan is needed and none was run; the same statement is machine-checked over $\mathbb Z$ in [L26.lean](../lean/HamiltonsCubic/Results/L26.lean).

## Verdict

**`HYPOTHESIS-DEBT`.**

The mathematical core of L26 is **correct and I re-derived all of it by hand**: $X\in\mathrm{Weyl}_n$ by both conditions separately, the coefficients $\tfrac23,\tfrac13,-\tfrac13$ and $\lVert X\rVert^2=\tfrac43$ at the record's own normalisations, $e\circ X=\lambda X$ for any three-block diagonal $e$ with $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$, the collapse to $\mu=\frac{n-2}{2(p-1)(q-1)}$, the threshold $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$, the excess $\tfrac1{2(n-3)}$ at $p=2$, the clearing to $3p+2q-4-pq>0$, its factorisation as $(p-2)(q-3)<2$, and the lattice count admitting exactly $(3,3)$ and $(3,4)$. Criticality is genuinely unused for the eigenvector and for $\lambda$, and genuinely used to collapse $\lambda$ to $\mu$.

The debt, and the four defects, in the order a repairer should take them:

1. **`HYPOTHESIS-DEBT`, the gap clause.** It is an upper bound on the spectrum inside a lemma that supplies lower bounds only, cited to nothing. It needs *"assuming L27's ten-summand decomposition exhausts $\mathcal W_n$ and $L_e$ is scalar on each summand"* in writing, with the note that $(3,3)$, $(3,4)$, $(3,5)$ and $(4,4)$ fall outside Nienhaus's $p,q\ge5$ and rest on the commutant computation.
2. **Defect, "reaches" in [results.md](../results.md).** Lines 435 and 138 still collapse the strict excess at $p=2$ with the equality at $(3,3)$; the findings copy was repaired and the canonical copy was not. The record documents this wording having inverted [L11](../findings/nondegeneracy.md) for two revisions.
3. **Defect, $\lambda_{\max}$ in the criterion sentence.** True under $\lambda_M$, false under $\lambda_{\max}(L_e|_{W^\perp})$, both live in the block, and two reviewers are already recorded as having misread it.
4. **`GAP`, the accounting at $\frac{n-1}{pq}$.** The three block values are fixed by two never-stated Ricci-flatness equations plus criticality for the scale, and the constant sits at an unnamed normalisation that is none of the record's three.
5. **Defect, ordering and definitions.** $q\ge p$ against the unordered $p,q\ge3$ in the same paragraph, "exactly two places" omitting $q=2$, "gap" undefined, and $X\perp$ orbit tangent used without statement.
