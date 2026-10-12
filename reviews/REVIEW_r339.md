# Reviewer 339, Lemma L74, the strongly regular graph family, and the saturation test

**Method**: analysis only. Every verdict below is closed-form algebra derived from the definitions in the brief, with no code from the record read or imported. Three arithmetic screens were taken, on matrices and parameter sets I constructed myself ([scripts/reviewers/r339/](../scripts/reviewers/r339/)); they are marked as screens, they guard against transcription slips, and no positive claim below rests on one.

| claim | verdict |
|---|---|
| **V4** the saturation test | **REFUTED, on all three sub-claims**, the criterion is Lemma L73's *bound* mistaken for Lemma L70's *saturation*, the ratio is computed on the sign branch that makes $\theta<0$, and the conclusion is false: $K_{m,m}$ is in the family and saturates exactly, at every even $n$. The parting line about Lemma L73 is refuted by V3's own control |
| **V2** the condition is automatic | **CONFIRMED**, re-derived independently; the reduction is exact and lands on $k(k-\lambda-1)=(v-k-1)\mu$ with nothing left over |
| **V1** the closed form | **CONFIRMED**, every step re-derived, constant and sign independently checked. One strengthening: the ansatz is forced more strongly than stated |
| **V3** the control | **PART-CONFIRMED / one REFUTED parameter**, the value $5/\sqrt{60}$ and the identification with the $n=6$ maximal torus are both **correct and structural**, not a coincidence of $\theta$. But the octahedron is $\mathrm{SRG}(6,4,2,\mathbf 4)$, not $(6,4,2,3)$: the quoted $\mu$ **violates the very identity V2 confirms**. $C_5$ is correct |

---

## V4, the saturation test, which is wrong three times over

### (a) "The $\Lambda^2$ eigenvalues are the entries of $M$", CONFIRMED, with the multiplicities

$W=\mathrm{diag}(w)$ acts on $\Lambda^2\mathbb R^n$ by $W\varphi_{ab}=M_{ab}\varphi_{ab}$, so the spectrum is the multiset $\{M_{ab}\}_{a<b}$ exactly. For $M=aA+b(J-I-A)$ this is $a$ with multiplicity $vk/2$ and $b=-ak/w$ with multiplicity $vw/2$, and

$$\frac{vk}2+\frac{vw}2=\frac v2\big(k+(v-1-k)\big)=\binom v2=\dim\Lambda^2\mathbb R^v .$$

The count closes with nothing left over, so **there is no extra zero eigenvalue** and none is missing. The forced $0$ eigenvalue of $M\mathbf 1=0$ lives in the $n\times n$ spectrum of $M$, which is a *different* object from the $\Lambda^2$ spectrum of $W$; the record's Lemma L74 block is right not to import it, and the earlier "spectral cap" sections of [diagonal-half.md](../findings/diagonal-half.md) use the $n\times n$ one. **The two must not be crossed, and the block does not cross them.**

### (b) The ratio $(v-1-k)/k$ is the **wrong sign branch**

Criticality $M^{\circ2}+M^2=\theta M+\mathrm{diag}(s)$ is odd in $M$: replacing $M\mapsto-M$ leaves the left side fixed and the diagonal fixed, so it sends $\theta\mapsto-\theta$. **Both $\pm M$ are critical points**, and only the sign is a convention, but the sign of $a$ decides which entry is $\lambda_{\max}$:

$$a>0:\quad\lambda_{\max}=a,\ \lambda_{\min}=-ak/w,\quad\frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac wk;\qquad a<0:\quad\frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac kw .$$

The record asserts $\lambda_{\max}/\lvert\lambda_{\min}\rvert=(v-1-k)/k=w/k$ flatly, which silently fixes $a>0$. **That is the branch on which $\theta$ is negative** wherever $F<0$, including at the octahedron, where the record's own Gate 1(a) reports $F=-5$ and then quietly flips sign to report $\lvert\theta\rvert$. The conjecture is about $\theta>0$, so the physical representative is $a<0$ and the ratio is $k/w$, the **reciprocal** of what the block uses. The block reports a value it has already abandoned two sentences earlier.

### (c) Lemma L70's saturation ratio is $n/(n-2)$, not $n-2$, REFUTED

The block's criterion is that $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ equal $n-2$. **$n-2$ is [Lemma L73](../findings/bounds.md)'s *bound*, a necessary condition on all of $\mathcal W_n$; it is not [Lemma L70](../findings/bounds.md)'s saturation condition.** Lemma L70 saturates when $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$, and [bounds.md](../findings/bounds.md)'s recorded converse (Reviewer 324) reads: $D(v)=0$ at a critical unit $W\in\mathcal W_n$ forces $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)$. **The two constants are $n/(n-2)$ and $n-2$**, equal only at $n=4$, which is below the range.

I do not need that converse. Solving the saturation equation inside the family closes it in one line. On the $a<0$ branch, $\lambda_{\min}=a$, $\lambda_{\max}=-ak/w$, $\theta=aF$, so $\theta=\lambda_{\min}+(v-2)\lambda_{\max}$ divides by $a\ne0$ to

$$F=1-\frac{(v-2)k}{w}\quad\Longleftrightarrow\quad (v-1)^2\lambda+2k(v-1)-k^2v+(v-2)kw=0 ,$$

and expanding $(v-2)kw=(v-2)k(v-1)-(v-2)k^2$ collapses the $k$ terms to $kv(v-1)$ and the $k^2$ terms to $-2k^2(v-1)$, so after dividing by $v-1$:

$$\boxed{\ \lambda=\frac{k(2k-v)}{v-1}\ }\qquad\text{is saturation of Lemma L70, in the parameters.}$$

At $K_{m,m}=\mathrm{SRG}(2m,m,0,m)$: $\lambda=m(2m-2m)/(2m-1)=0$. **It holds identically.**

### (d) The conclusion "no strongly regular graph solution saturates for $k\ge2$" is FALSE

$K_{m,m}$ is regular of degree $m$, non-complete, non-empty, with $\lambda=0$ and $\mu=m$, a strongly regular graph, and it is a member of the record's own enumeration two sections above, where [diagonal-half.md](../findings/diagonal-half.md)'s Theorem (2-class case) names $(k,\lambda,\mu)=(n/2,0,n/2)$, "the complete bipartite $K_{n/2,n/2}$, which is the balanced two-block sphere product", as the **maximiser** of the very family Lemma L74 closes. Lemma L74's own formula returns $\theta_0$ there. With $v=2m$, $k=m$, $\lambda=0$, $w=m-1$:

$$Fw^2=2m(2m-1)-2m^3+(m-1)^2=-(m-1)^2(2m-1)\ \Rightarrow\ F=-(2m-1),$$

$$\lvert\theta\rvert=(2m-1)\sqrt{\frac{2(m-1)}{2m\cdot m\cdot(2m-1)}}=\frac{\sqrt{(2m-1)(m-1)}}m=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

And the balanced sphere product is the record's flagship saturating point, [bounds.md](../findings/bounds.md)'s salvage table gives slack $0.000000000$ at $n=6,8,10,12$. **So the family contains saturating members at every even $n$, and the blanket claim is refuted.** Directly, at $n=6$: $a=-2/\sqrt{90}$ on the $9$ edges, $b=3/\sqrt{90}$ on the $6$ non-edges, giving $\lambda_{\min}+4\lambda_{\max}=(-2+12)/\sqrt{90}=10/\sqrt{90}=1.054093=\theta$. **Exactly saturating**, and $\lambda_{\max}/\lvert\lambda_{\min}\rvert=3/2=n/(n-2)$, not $n-2=4$.

*Screen* (own construction, [screen.py](../scripts/reviewers/r339/screen.py)): criticality residual $5.6\times10^{-17}$, row sums $5.6\times10^{-17}$, $\lVert W\rVert=1.000000000$, Lemma L70 slack $0.000000000$.

### The corrected statement, which is stronger than the one it replaces

Run the saturation equation $\lambda=k(2k-v)/(v-1)$ against the strong-regularity identity. On the $a<0$ branch the necessary spectral ratio is $k/w=v/(v-2)$, i.e. $k(v-2)=v(v-1-k)$, i.e. $2k(v-1)=v(v-1)$, i.e. $k=v/2$. Write $v=2m$; the identity $k(k-\lambda-1)=(v-k-1)\mu$ becomes $m(m-\lambda-1)=(m-1)\mu$, and $\gcd(m,m-1)=1$ forces $(m-1)\mid(m-\lambda-1)$. Since $0\le\lambda\le k-1=m-1$ gives $0\le m-\lambda-1\le m-1$, the only options are

* $m-\lambda-1=0$: $\lambda=m-1$, $\mu=0$, the disconnected $2K_m$;
* $m-\lambda-1=m-1$: $\lambda=0$, $\mu=m$, the complete bipartite $K_{m,m}$.

The $a>0$ branch gives $w/k=v/(v-2)$, i.e. $k=(v-2)/2=m-1$, $w=m$, and the same divisibility argument forces $\lambda=m-2$, $\mu=0$, $2K_m$ again. **The two branches are the same matrix $M$**, since complementation swaps the roles of $a$ and $b$; $K_{m,m}$ and $2K_m$ are complements.

> **CORRECTED V4.** *Within the strongly regular family, the diagonal critical points saturating [Lemma L70](../findings/bounds.md) are **exactly** $K_{m,m}$ (equivalently its complement $2K_m$), for every $m\ge2$, and these are precisely the balanced sphere products $S^m\times S^m$, with $\theta=\theta_0(2m)$. Every other strongly regular graph fails the necessary ratio $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$ and is strictly slack.*

*Screen* ([screen3.py](../scripts/reviewers/r339/screen3.py)): over every feasible parameter set with $v\le200$ passing the identity and multiplicity integrality, and over both signs, the saturation equation $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ holds at $196$ sets and at **no other**; each is $K_{m,m}$ or $2K_m$, and each returns $\theta_0(v)$ to nine digits.

### The corroboration claim, the record's version was VACUOUS; the corrected version is a real test

The brief asks plainly whether a family with no saturating member tests Lemma L71. **It does not.** Lemma L71 is the conditional "saturates $\Rightarrow$ balanced sphere product". A family in which the antecedent is never satisfied satisfies the conditional **vacuously** and supplies zero evidence, it is consistent with Lemma L71 and equally consistent with Lemma L71 being false for a saturating point the family cannot construct. The block's sentence *"Corroboration from a family the lemma's proof never saw"* claims evidential weight that a vacuous truth cannot carry, and had the "no member saturates" finding been correct, the right verdict would have been **no test at all**.

**The corrected finding rescues the claim and inverts its reason.** The family *does* contain saturating members, they are exactly $K_{m,m}$, and $K_{m,m}$ *is* the balanced sphere product. So Lemma L71's conclusion is verified where its hypothesis holds, and its contrapositive is verified across the whole rest of the family, every primitive strongly regular graph is a two-eigenvalue critical point that is not a sphere product, and every one of them fails to saturate. **That is a genuine external test, and it passes.** The record has the right conclusion for the wrong reason and with the wrong mechanism.

### And the parting line against Lemma L73 is refuted by V3's own control

The block closes: *"the same ratio $(v-1-k)/k$ is this family's value of the quantity Lemma L73 bounds by $n-2$, so the SRG points sit strictly inside that bound at every admissible parameter set."* Lemma L73 is two-sided, $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ **and** $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$, so the quantity it caps is $\max(k/w,\,w/k)$ and the sign branch cannot rescue the claim. Saturation is $\max(k/w,w/k)=v-2$, which forces $k=v-2$ (hence $w=1$) or $k=1$.

**$k=v-2$ is the cocktail-party graph $K_{2,2,\dots,2}$, and at $v=6$ that is the octahedron, the block's own control.** Its ratio is $4/1=4=n-2$ **exactly**: it sits **on** the bound, not strictly inside it. This also contradicts [findings/INDEX.md](../findings/INDEX.md), whose Lemma L73 row already records the bound as *"sharp on $\mathbb{CP}^m$ and on every maximal torus"*, and the octahedron **is** the $n=6$ maximal torus, as V3 correctly identifies. **The block refutes itself by combining its own two paragraphs.**

*Screen* ([screen3.py](../scripts/reviewers/r339/screen3.py)): over feasible sets with $v\le60$, the Lemma L73 saturators are exactly $k=v-2$ and $k=1$, at every even $v$, the cocktail-party graphs and the perfect matchings.

---

## V2, the condition is automatic: CONFIRMED

Write $t=k/w$, $u=1+t=(v-1)/w$, and $N=(1+t)A-t(J-I)=uA-tJ+tI$, so that $N_{ij}=1$ on an edge and $-t$ on a non-edge. With $A^2=(k-\mu)I+(\lambda-\mu)A+\mu J$, $AJ=kJ$, $J^2=vJ$:

$$N^2=\underbrace{\big[u^2(\lambda-\mu)+2tu\big]}_{\alpha}A+\underbrace{\big[u^2(k-\mu)+t^2\big]}_{\beta}I+\underbrace{\big[u^2\mu-2tuk+t^2(v-2)\big]}_{\gamma}J .$$

Then $F_{\text{edge}}=\alpha+\gamma+1$ and $F_{\text{non}}=-(\gamma+t^2)/t$, so $F_{\text{edge}}=F_{\text{non}}$ is $t\alpha+(1+t)\gamma+t(1+t)=0$. Factoring one $u$ out and multiplying by $w^2$ (using $tw=k$, $uw=v-1$, and $2t^2+t^2(v-2)=t^2v$):

$$k(v-1)(\lambda-\mu)+(v-1)^2\mu-2k^2(v-1)+k^2v+kw=0 .$$

Divide by $v-1$. The last two terms give $k^2+\tfrac{k^2}{v-1}$ and $k-\tfrac{k^2}{v-1}$, whose $\tfrac{k^2}{v-1}$ parts **cancel exactly**, leaving

$$k(\lambda-\mu)+(v-1)\mu-k^2+k=0\ \Longleftrightarrow\ k\lambda+k-k^2+\mu(v-1-k)=0\ \Longleftrightarrow\ \boxed{k(k-\lambda-1)=(v-k-1)\mu} .$$

**Nothing is left over and nothing is divided by a possibly-zero quantity** except $w$ and $t$, both nonzero once $1\le k\le v-2$. So the block's reduction is exact and its conclusion stands: **every strongly regular graph gives a diagonal critical point, with no side condition.** *(One consequence the block does not draw: $\mu$ enters $F_{\text{edge}}$ nowhere, it appears in $\alpha$ and $\gamma$ with opposite signs and cancels. That is why V3's wrong $\mu$ still produced the right number; see below.)*

---

## V1, the closed form: CONFIRMED, and the ansatz is forced more strongly than stated

**Zero row sums.** Row sum $=ak+b(v-1-k)=ak+bw$, so $b=-ak/w$. ✓

**The norm.** In this record's convention $\lVert W\rVert^2=\sum_{i<j}M_{ij}^2=\tfrac12\operatorname{tr}M^2$, consistent throughout [diagonal-half.md](../findings/diagonal-half.md), which states $\sum_{a<b}w_{ab}^2=1$ and $\operatorname{tr}M^2=2$ together. The edge count is $vk/2$ and the non-edge count is $vw/2$, so

$$\lVert W\rVert^2=\frac{vk}2a^2+\frac{vw}2\cdot\frac{a^2k^2}{w^2}=\frac{va^2k}2\Big(1+\frac kw\Big)=\frac{a^2vk(v-1)}{2w},\qquad a^2=\frac{2w}{vk(v-1)} .$$

**Both match the block. There is no factor of $4$ loose here**: the flagged hazard is $\sum_{i<j}$ against $\sum_{i,j}$ (factor $2$) compounded with $\theta$ against $\theta/\lVert W\rVert$, and the block uses $\sum_{i<j}$ consistently with the file's stated normalisation and with the $C_5$ blow-up figures elsewhere in it.

**The $N^2$ expansion** is verified above, term by term, including $(J-I)^2=vJ-2J+I=(v-2)J+I$. ✓

**The numerator, re-derived independently.** $F=F_{\text{edge}}=\alpha+\gamma+1$, and the $\mu$ terms cancel:

$$\alpha+\gamma=u^2\lambda+2tu(1-k)+t^2(v-2)\ \Longrightarrow\ Fw^2=(v-1)^2\lambda+2k(v-1)(1-k)+k^2(v-2)+w^2 .$$

The middle terms are $2k(v-1)+k^2\big[-2(v-1)+(v-2)\big]=2k(v-1)-k^2v$, giving

$$Fw^2=(v-1)^2\lambda+2k(v-1)-k^2v+w^2 ,$$

**exactly the block's numerator, reached without reading it.** With $\theta/\lVert W\rVert=aF$ and $a=\sqrt{2w/(vk(v-1))}$, **LEMMA L74 is CONFIRMED**, subject to the sign caveat below.

**The sign.** The formula as written takes $a>0$, so it returns a **signed** $\theta$ that is negative wherever $F<0$, at the octahedron ($-5/\sqrt{60}$), at $K_{m,m}$ ($-\theta_0$), and generally on the interesting members. The statement should read $\lvert\theta\rvert/\lVert W\rVert=\lvert F\rvert a$, or fix $a=-\mathrm{sgn}(F)\sqrt{\cdots}$. **The block knows this** (it writes "the sign being the $M\to-M$ convention") but the boxed lemma does not carry it, and V4 then reads the ratio off the discarded branch. *That is the whole mechanism of V4's failure: an unrecorded sign convention in the lemma statement, used one section later as if it were the physical one.*

**The ansatz is forced, and by more than the block claims.** The block says a two-eigenvalue solution *on a strongly regular $\Gamma$* is edge/non-edge constant. The stronger statement needs no graph in advance. Let $M$ be hollow symmetric with zero row sums and exactly two distinct off-diagonal values $a\ne b$, and let $A$ be the indicator of the value $a$. Zero row sums give $a\deg_A(i)+b(v-1-\deg_A(i))=0$, so $\deg_A(i)=-b(v-1)/(a-b)$ is **constant**, $A$ is regular. Now $J-I-A$ is a polynomial in $A,I,J$, so $(M^2)_{ij}=(a-b)^2(A^2)_{ij}+c_2A_{ij}+c_3$ for constants $c_2,c_3$. Criticality $(M^2)_{ij}+M_{ij}^2=\theta M_{ij}$ makes the left and right sides constant on each class, and since $(a-b)^2\ne0$ this forces $(A^2)_{ij}$ constant on edges and on non-edges, **which is exactly strong regularity.**

> **STRENGTHENING (offered for the record).** *A diagonal critical point whose matrix $M$ takes exactly two off-diagonal values is automatically $aA+b(J-I-A)$ with $A$ the adjacency of a **strongly regular** graph. The strong regularity is a conclusion, not a hypothesis.* This is the exact converse the block's "the ansatz is forced" gestures at, and it is what makes Lemma L74 a **classification** of the two-value diagonal critical points rather than a construction from a supplied graph.

---

## V3, the control: the value and the identification hold; one parameter does not

### The value: CONFIRMED

$v=6$, $k=4$, $\lambda=2$, $w=1$: $Fw^2=25\cdot2+2\cdot4\cdot5-16\cdot6+1=50+40-96+1=-5$, $a=\sqrt{2/120}=1/\sqrt{60}$, $\lvert\theta\rvert/\lVert W\rVert=5/\sqrt{60}=0.645497224$. ✓ And $0.645497$ is the record's catalogued $n=6$ maximal torus value, appearing in [fence-posts.md](../findings/fence-posts.md) alongside $0.540062$ and $0.474342$ at $n=8,10$.

### The identification: CONFIRMED, and it is structural rather than a shared $\theta$

The brief asks whether two different objects merely share a $\theta$ value. **They do not, the objects coincide.** Take the physical branch $a=-1/\sqrt{60}$. Then $M$ carries $-1/\sqrt{60}$ on the $12$ edges and $+4/\sqrt{60}$ on the $3$ non-edges, and the non-edges of $K_{2,2,2}$ are the three antipodal pairs. The maximal torus $\mathfrak{so}(2)^3\subset\mathfrak{so}(6)$ is $W=\Pi_{\mathfrak h}-\tfrac r NI$ with $\mathfrak h=\mathrm{span}\{\varphi_{01},\varphi_{23},\varphi_{45}\}$, $r=3$, $N=15$: the unnormalised spectrum is $\tfrac45$ on $3$ directions and $-\tfrac15$ on $12$, of norm $\sqrt{60}/5$, so the unit-norm spectrum is $4/\sqrt{60}$ (multiplicity $3$) and $-1/\sqrt{60}$ (multiplicity $12$).

**Same eigenvalues, same multiplicities, and the same eigenvectors**, $\mathfrak h$'s three coordinate $2$-planes are the three antipodal pairs, both being the fixed-point-free involution on $6$ letters. So the octahedron's diagonal Weyl tensor **is** the $n=6$ maximal torus, not a second object at the same $\theta$. *Screen* ([screen2.py](../scripts/reviewers/r339/screen2.py)): spectra agree as multisets to machine precision.

*Consequence the block should draw and does not*: since the torus is Lemma L73-sharp and Lemma L70-slack by $1.290994$ (both recorded in [bounds.md](../findings/bounds.md), and both reproduced here from the closed form: $\lambda_{\min}+4\lambda_{\max}=15/\sqrt{60}=1.936492$ against $\theta=0.645497$), **the control was already carrying the counterexample to V4's Lemma L73 sentence.**

### The parameters: REFUTED

**$K_{2,2,2}$ is $\mathrm{SRG}(6,4,2,4)$, not $\mathrm{SRG}(6,4,2,3)$.** Two non-adjacent vertices of the octahedron are an antipodal pair $u,\bar u$; $N(u)$ and $N(\bar u)$ are both $V\setminus\{u,\bar u\}$, so $\mu=4$. The quoted $\mu=3$ fails the identity V2 confirms:

$$k(k-\lambda-1)=4\cdot1=4\qquad\text{against}\qquad(v-k-1)\mu=1\cdot3=3 .$$

**So the record's Gate 1(a) control is run on a parameter set that is not a strongly regular graph at all**, and by the lemma's own admissibility criterion it should have been rejected. With $\mu=3$ the two entrywise equations disagree: $F_{\text{edge}}=-5$ but $F_{\text{non}}=-(\gamma+t^2)/t=-(-21+16)/4=+5/4$. **It only passes because $\mu$ cancels out of $F_{\text{edge}}$**, so the quoted $-5$ is right by accident of which face of the equation was evaluated. With the true $\mu=4$: $\alpha=-10$, $\gamma=4$, $F_{\text{edge}}=F_{\text{non}}=-5$. ✓

*This is a live hazard rather than a typo*: any future check that quotes $F_{\text{edge}}$ alone will validate inadmissible parameter sets, because $F_{\text{edge}}$ is $\mu$-blind. **A Gate 1 on this lemma must evaluate $F_{\text{non}}$ too, or verify the identity first.**

### $C_5$: CONFIRMED

$v=5$, $k=2$, $\lambda=0$, $\mu=1$, $w=2$, $t=1$, $u=2$: identity $2\cdot1=2\cdot1$ ✓; $\alpha=4(0-1)+4=0$, $\gamma=4-8+3=-1$; $F_{\text{edge}}=0-1+1=0$ and $F_{\text{non}}=-(-1+1)/1=0$. Both vanish, so $\theta=0$. ✓ Matching the closed form: $16\cdot0+2\cdot2\cdot4-4\cdot5+4=0$.

*One wording point.* "Its solution degenerates to $\theta=0$" reads as if the tensor degenerates. It does not: $M\ne0$, $\lVert W\rVert=1$, row sums vanish, and it is a genuine critical point of $P$ with critical value $0$. **What degenerates is $\theta$, not $W$**, and a unit-norm critical point at $\theta=0$ is worth more than a footnote, since it is a $\theta$-critical Weyl tensor annihilated by no eigenvalue condition. Note also that $C_5$ has $\lambda_{\max}=\lvert\lambda_{\min}\rvert$, ratio $1$, so Lemma L70 reads $0\le\lambda_{\min}+3\lambda_{\max}=0.632456$: slack, as it must be.

---

## Summary of required corrections to the Lemma L74 block

1. **Lemma L74's statement needs the sign**: $\lvert\theta\rvert/\lVert W\rVert=\lvert F\rvert\sqrt{2w/(vk(v-1))}$, with $F$ the displayed numerator over $w^2$. As written it returns a negative $\theta$ at every member that matters.
2. **The octahedron is $\mathrm{SRG}(6,4,2,4)$.** The recorded $(6,4,2,3)$ violates the identity the same block derives.
3. **The saturation paragraph must be replaced.** The criterion is $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$, equivalently $\lambda=k(2k-v)/(v-1)$; the saturating members are exactly $K_{m,m}\cong$ the balanced sphere product, at every even $n$; and every other strongly regular graph is strictly slack.
4. **The Lemma L71 sentence must be rewritten, keeping its conclusion.** The family does test Lemma L71 and passes, because it contains saturating points and they are the balanced sphere products, and because every primitive member is a non-sphere-product two-eigenvalue critical point that fails to saturate. The current phrasing claims corroboration from a vacuous conditional.
5. **The Lemma L73 sentence must be deleted or reversed.** The family saturates Lemma L73 exactly at $k=v-2$, the cocktail-party graphs, of which the block's own control is the $n=6$ member, consistent with [INDEX.md](../findings/INDEX.md)'s existing "sharp on every maximal torus".
6. *Offered as a gain*: the two-value ansatz forces strong regularity rather than assuming it, so Lemma L74 classifies the two-value diagonal critical points.

**One subtlety checked and cleared.** [bounds.md](../findings/bounds.md) records Lemma L70's boxed form as the *weakened* member of the per-row family, with the sharp version subtracting $m_1$, the minimum over the support, and the two agreeing whenever $\lambda_{\min}$ has multiplicity $\ge2$. In this family $\lambda_{\min}$ has multiplicity $vk/2$ or $vw/2$, both $\ge2$ for every $v\ge4$, **so weakened and sharp coincide throughout and the distinction does not affect anything above.** It is worth saying explicitly that the error was never about which form of Lemma L70 to read: **neither form has $n-2$ as its saturation ratio**, and the constant was imported from a different lemma.
