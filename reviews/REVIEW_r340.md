# Reviewer 340, Lemma L74, the strongly regular graph family, and its saturation test

**Method**: analysis only. Every verdict below is closed-form algebra done from the definitions in the brief. One parameter-level arithmetic screen was taken, on objects I constructed myself, purely to guard against transcription slips in figures I quote; it is marked as a screen and carries no positive claim. Its script is [screen.py](../scripts/reviewers/r340/screen.py).

| claim | verdict |
|---|---|
| **V4** no member saturates [Lemma L70](../findings/bounds.md), corroborating [Lemma L71](../findings/bounds.md) | **REFUTED**, the saturation criterion is the wrong constant ($n-2$ is [Lemma L73](../findings/bounds.md)'s, not [Lemma L70](../findings/bounds.md)'s), the ratio is orientation-dependent and only one orientation was read, and the family **does** contain a saturating member: $K_{v/2,v/2}$, which is the balanced sphere product. The corroboration survives in *repaired and stronger* form |
| **V2** the admissibility condition is the standard SRG identity | **CONFIRMED**, re-derived independently, exactly as recorded |
| **V1** the closed form, constant and sign | **CONFIRMED**, every step reproduces, and the value cross-checks against an independent spectral route at 24 parameter sets. No factor-of-4 normalisation slip |
| **V3** the octahedron control and $C_5$ | **PART-CONFIRMED / DEFECT**, the number $5/\sqrt{60}$ and the identification are right, but the octahedron's parameters are written $\mathrm{SRG}(6,4,2,3)$, which is **infeasible**: it is $\mathrm{SRG}(6,4,2,4)$. And the identification is stated through the wrong graph |

---

## V4, the saturation test. REFUTED, on three independent counts

### Count 1: the criterion is Lemma L73's constant, not Lemma L70's

[bounds.md](../findings/bounds.md) states plainly that **the hypothesis "saturates Lemma L70" is the scalar spectral equation $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$**. Its spectral consequence is *not* $\lambda_{\max}=(n-2)\lvert\lambda_{\min}\rvert$. Derived from the row calculus, in two lines:

Saturation means $D(v)=0$, i.e. $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$ for unit $v\in E_{\min}$. Row $v$ of (A) gives $\sum_{\beta\gamma}T_{v\beta\gamma}=2(n-2)$, and row $v$ of (B), symmetrised, gives

$$-2\lambda_{\min}\;=\;\sum_{\beta\gamma}\lambda_\beta T_{v\beta\gamma}\;=\;\tfrac12\sum_{\beta\gamma}(\lambda_\beta+\lambda_\gamma)T_{v\beta\gamma}\;=\;\tfrac12(\lambda_{\min}+\lambda_{\max})\cdot2(n-2),$$

since every supported pair has $\lambda_\beta+\lambda_\gamma=\lambda_{\min}+\lambda_{\max}$. Hence $(n-2)\lambda_{\max}=-n\lambda_{\min}$, i.e.

$$\boxed{\ \frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac n{n-2}\ }\qquad\text{and}\qquad \theta=\lambda_{\min}+(n-2)\lambda_{\max}=(n-1)\lvert\lambda_{\min}\rvert .$$

This is exactly [Reviewer 324](REVIEW_r324.md)'s converse and [Reviewer 323](REVIEW_r323.md)'s sharpening, both already on the record in [bounds.md](../findings/bounds.md). The constant $n-2$ that [diagonal-half.md](../findings/diagonal-half.md) uses is [Lemma L73](../findings/bounds.md)'s, the purely spectral bound $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ valid on all of $\mathcal W_n$. The two were swapped.

**The record refutes the swapped criterion by itself.** The $n=6$ maximal torus has $\Lambda^2$ spectrum $(0.516398^{\times3},-0.129099^{\times12})$, hence ratio exactly $4=n-2$, so the swapped criterion declares it saturating. [bounds.md](../findings/bounds.md)'s own equality-case table records its slack as $1.291$. I reproduce that by hand: $\theta=0.645497$ and $\lambda_{\min}+4\lambda_{\max}=-0.129099+2.065591=1.936492$, slack $1.290995$. A point at ratio $n-2$ carries slack $1.291$; the criterion is wrong.

### Count 2: the ratio is orientation-dependent, and only one orientation was read

$W^\#$ is quadratic, so $(-W)^\#=W^\#$ and $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$: **$-W$ is critical whenever $W$ is, with $\theta\mapsto-\theta$.** Both signs of $a$ therefore give critical points, and the family is closed under the swap. With $M=aA+b(J-I-A)$, $b=-at$, $t=k/w$:

* $a>0$: entries $a$ (multiplicity $vk/2$) and $-at$ (multiplicity $vw/2$), so $\lambda_{\max}/\lvert\lambda_{\min}\rvert=1/t=w/k$;
* $a<0$: the same two values with signs exchanged, so the ratio is $t=k/w$.

[diagonal-half.md](../findings/diagonal-half.md) asserts $w/k$ unconditionally, while three lines earlier invoking "the sign being the $M\to-M$ convention" for the octahedron, i.e. using the *other* orientation for the only worked example. The two branches are not cosmetic: **$M\to-M$ is complementation of $\Gamma$.** Writing $M'$ for the solution on $\Gamma^{\mathsf c}$ with $a'>0$, one has $t'=k'/w'=w/k$ and $M'=-M$ with $a'=at$. So the branch $a<0$ on $\Gamma$ is the branch $a>0$ on $\Gamma^{\mathsf c}$, and any classification that reads one branch reads half the family.

### Count 3: the family DOES contain a saturating member, and it is the balanced sphere product

Impose the correct necessary condition $\lambda_{\max}/\lvert\lambda_{\min}\rvert=v/(v-2)$ on both branches. Write $v=2m$.

**Branch $w/k=v/(v-2)$.** Then $(v-1-k)(v-2)=vk$, so $(v-1)(v-2)=2k(v-1)$ and $k=(v-2)/2=m-1$, $w=m$. The SRG identity $k(k-\lambda-1)=w\mu$ reads $(m-1)(m-2-\lambda)=m\mu$; since $\gcd(m-1,m)=1$ we need $m\mid(m-2-\lambda)$, and $0\le\lambda\le k-1=m-2$ puts $m-2-\lambda$ in $[0,m)$. So $\lambda=m-2$, $\mu=0$, and $\Gamma=2K_m$.

**Branch $k/w=v/(v-2)$.** By complementation $k=m$, $w=m-1$, and $m(m-1-\lambda)=(m-1)\mu$ forces $\lambda=0$, $\mu=m$: $\Gamma=K_{m,m}$.

These two parameter sets are complements, hence **one critical point up to sign**. And it saturates, analytically. Take $\Gamma=K_{m,m}$ in the orientation $a<0$, with $A:=\lvert a\rvert=\sqrt{2w/(vk(v-1))}=\sqrt{m-1}\big/\big(m\sqrt{2m-1}\big)$. Then $\lambda_{\max}=At=Am/(m-1)$, $\lambda_{\min}=-A$, and

$$\lambda_{\min}+(n-2)\lambda_{\max}=-A+(2m-2)\cdot\frac{Am}{m-1}=A(2m-1)=\frac{\sqrt{(2m-1)(m-1)}}m .$$

Independently, $F(K_{m,m})$ from [Lemma L74](../findings/diagonal-half.md) with $\lambda=0$, $k=m$, $w=m-1$ has numerator $2m(2m-1)-2m^3+(m-1)^2=-(m-1)^2(2m-1)$, so $F=-(2m-1)$ and

$$\lvert\theta\rvert=\lvert F\rvert\,A=\frac{\sqrt{(2m-1)(m-1)}}m=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

The two agree. **$\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ exactly: Lemma L70 is saturated**, the ratio is $m/(m-1)=n/(n-2)$ as the corrected criterion demands, and $k=v/2\ge2$ for every $v\ge4$. The sentence *"no strongly regular graph solution saturates, for any parameters with $k\ge2$, unconditionally rather than family by family"* is **false**.

It is false at the record's own conjectured maximiser. [diagonal-half.md](../findings/diagonal-half.md) already states, two sections above the saturation paragraph, that $(k,\lambda,\mu)=(n/2,0,n/2)$ is $K_{n/2,n/2}$ and **is the balanced two-block sphere product**, and that it attains $\theta_0(n)$. So the file asserts in one place that the family's maximiser is the balanced sphere product and in another that no member saturates, while [Lemma L71](../findings/bounds.md) says the balanced sphere product is precisely what saturation forces. The three cannot all hold.

### And the record's own exclusion is applied inconsistently

The paragraph disposes of its (wrong) criterion by "forcing $k=1$, a perfect matching, which is not strongly regular ($\mu=0$, disconnected)". Two problems.

* **The perfect matching is already in the family, admitted by the record itself.** $\Gamma=\mathrm{SRG}(v,1,0,0)$ is the complement of the cocktail-party graph $K_{(v/2)\times2}$, a genuinely connected strongly regular graph, so excluding it while admitting its complement is not a well-defined restriction on the set of critical points, the two are one point up to sign.
* **It is the point the record catalogues.** The $\mathrm{SRG}(v,1,0,0)$ member with $a>0$ has entries $a$ on the matching and $-a/(v-2)$ elsewhere, i.e. [Lemma L55](../findings/diagonal-half.md)'s extremiser, i.e. $W=\Pi_{\mathfrak h}-\tfrac r NI$ for $\mathfrak h=\mathfrak{so}(2)^{n/2}$ spanned by the matched bivectors, **the maximal torus.** Its $\theta$ values are $0.645497$, $0.540062$, $0.474342$, $0.428174$ at $n=6,8,10,12$, digit for digit the record's catalogued tori, and its Lemma L70 slacks are $1.290994$, $2.160247$, $2.846050$, $3.425395$, digit for digit [bounds.md](../findings/bounds.md)'s torus row.

**That identification is itself new and worth recording**: the whole maximal-torus family, at every even $n$, is the perfect-matching member of the DGK strongly regular family, not just the single $n=6$ coincidence the record noted through the octahedron.

### The sub-questions, answered directly

**(a) Are the $\Lambda^2$ eigenvalues the entries of $M$?** **Yes**, and the multiplicity bookkeeping is right. $W$ is diagonal in the basis $\{e_i\wedge e_j\}_{i<j}$, so its spectrum is $\{M_{ij}\}_{i<j}$ with multiplicity: $a$ with multiplicity $vk/2$ and $-at$ with multiplicity $vw/2$, summing to $\binom v2=\dim\Lambda^2$. There is **no zero eigenvalue** for $a\ne0$, $k,w\ge1$, so [Lemma L71](../findings/bounds.md)'s $\mathfrak r$ (which includes the kernel) is empty here for free.

*One trap the file sets for its own reader*: the "Theorem (2-class case)" section three paragraphs earlier computes a **different** spectrum ($0,\ \alpha r-\beta(1+r),\ \alpha s-\beta(1+s)$) which is the $v\times v$ spectrum of $M$ as a matrix, carrying the zero from $M\mathbf1=0$. Both are legitimate and both are used ($\theta=\tfrac12[\sum_{ij}M_{ij}^3+\operatorname{tr}M^3]$ mixes them), but they are not the same object and only the entry spectrum is the $\Lambda^2$ spectrum. The file never says so.

**(b) Is the saturation condition $\lambda_{\max}=(n-2)\lvert\lambda_{\min}\rvert$?** **No**, it is $n/(n-2)$, as above. I also checked the sharp-versus-weakened caveat the brief flags, and it does **not** bite here: [bounds.md](../findings/bounds.md) records that the sharp and weakened forms agree whenever $\lambda_{\min}$ has multiplicity $\ge2$, and in this family the multiplicities are $vk/2$ and $vw/2$, both $\ge3$ for every $v\ge5$ with $k,w\ge1$. The defect is a swapped constant, not a sharp/weak confusion.

**(c) Does the corroboration claim hold?** **The conclusion survives; the argument for it does not, and the repaired version is stronger.** Stated plainly:

* The family is **consistent with [Lemma L71](../findings/bounds.md)**, and in the strong sense: the unique saturating member, at every even $n$, is $K_{n/2,n/2}$ = the balanced sphere product. That is what Lemma L71 predicts, and the family reaches it from an independent direction.
* But it is **a weak test**, for a reason the record does not name. Within a two-eigenvalue diagonal family the saturation question is purely spectral (the necessary ratio $n/(n-2)$ plus the two-line integrality argument above settles it) and it never touches Lemma L71's actual content, which is the Lie-theoretic chain $\mathfrak r=0$, $(\mathfrak{so}(n),\mathfrak h)$ a symmetric pair, $\mathfrak h=[\mathfrak m,\mathfrak m]$. The family confirms Lemma L71's *spectral shadow*.
* **It is fully consistent with Lemma L71 being false for reasons this family cannot see.** Lemma L71's whole force is that saturation forces *exactly two* eigenvalues with no such hypothesis assumed. A counterexample would be a saturating critical point with three or more eigenvalues, or a non-diagonal one. Every member of this family has two eigenvalues and is diagonal by construction, so no member can be that counterexample, the family cannot reach the region where Lemma L71 could fail.
* The original framing, "an infinite family of two-eigenvalue critical points that are mostly not sphere products, which is exactly the shape that would refute it", mis-states the shape. Two-eigenvalue points are what Lemma L71 *concludes*, not what would refute it. A non-sphere-product two-eigenvalue point refutes Lemma L71 only if it saturates, and none of the non-sphere-product members do.

**Suggested replacement for the paragraph**: *Within the strongly regular family the saturation ratio $n/(n-2)$ admits exactly two parameter sets, $(2m,m-1,m-2,0)$ and $(2m,m,0,m)$, which are complements and hence one critical point up to sign; that point is $K_{m,m}$, the balanced sphere product, and it saturates exactly. Every other member is strictly slack. This confirms Lemma L71 on a family its proof never saw, in the direction of exhibiting the predicted extremum rather than failing to find a counterexample, and it tests only the spectral shadow of Lemma L71, since a two-eigenvalue family cannot house the $\ge3$-eigenvalue saturating point that would refute it.*

### And the Lemma L73 side-claim is false too

[diagonal-half.md](../findings/diagonal-half.md) closes with: *"the same ratio $(v-1-k)/k$ is this family's value of the quantity [Lemma L73](../findings/bounds.md) bounds by $n-2$, so the SRG points sit strictly inside that bound at every admissible parameter set."* [Lemma L73](../findings/bounds.md) is two-sided, $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ **and** $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$, so both $w/k$ and $k/w$ must be tested, and $k/w=v-2$ has the solution $k=v-2$, $w=1$: the cocktail-party graph $K_{(v/2)\times2}$, a connected strongly regular graph at every even $v\ge6$. **The bound is attained, not strict**, at that member and at its complement the perfect matching, consistent with [INDEX.md](../findings/INDEX.md)'s own row for Lemma L73, "sharp on $\mathbb{CP}^m$ and on **every maximal torus**", which is the same statement. The octahedron, the record's chosen control, is the $v=6$ case.

---

## V2, the condition is automatic. CONFIRMED

Re-derived from scratch. With $M=aN$, $N=pA+qJ+rI$ where $p=1+t$, $q=-t$, $r=t$, and $A$, $J$, $I$ pairwise commuting:

$$N^2=p^2A^2+q^2vJ+r^2I+2pqkJ+2prA+2qrJ,$$

and substituting $A^2=(k-\mu)I+(\lambda-\mu)A+\mu J$,

$$N^2=\underbrace{\big[(1{+}t)^2(k{-}\mu)+t^2\big]}_{\text{on }I}I+\underbrace{\big[(1{+}t)^2(\lambda{-}\mu)+2t(1{+}t)\big]}_{=:\ \alpha}A+\underbrace{\big[(1{+}t)^2\mu-2t(1{+}t)k+t^2(v{-}2)\big]}_{=:\ \gamma}J,$$

reproducing the record verbatim (its $t^2v-2t^2$ is my $t^2(v-2)$). On an edge $N_{ij}=1$ and $(N^2)_{ij}=\alpha+\gamma$; on a non-edge $N_{ij}=-t$ and $(N^2)_{ij}=\gamma$. So

$$F_{\text{edge}}=\alpha+\gamma+1,\qquad F_{\text{non}}=-\frac{\gamma+t^2}t,$$

and $F_{\text{edge}}=F_{\text{non}}$ multiplied by $t$ is

$$t\alpha+(1+t)\gamma+t(1+t)=0 .$$

Now $t=k/w$ and $1+t=(v-1)/w$, so multiplying by $w^3$ and then dividing by $(v-1)$:

$$k\big[(v{-}1)(\lambda{-}\mu)+2k\big]+\big[(v{-}1)^2\mu-2k^2(v{-}1)+k^2(v{-}2)\big]+kw=0 .$$

The $k^2$ terms collect as $k^2[2-2(v-1)+(v-2)]=-k^2(v-2)$, and with $kw=k(v-1)-k^2$ the $k^2$ total is $-k^2(v-1)$. Dividing through by $(v-1)$:

$$k\lambda-k\mu+(v-1)\mu-k^2+k=0\ \Longleftrightarrow\ k(k-\lambda-1)=(v-k-1)\mu .$$

Exactly as recorded, with no residue. **Every strongly regular graph gives a critical point, unconditionally.** The reduction is correct.

*Worth noting for what follows*: the reduction is where $\mu$ is used up. $F_{\text{edge}}$ itself is **$\mu$-free**, the $\mu$'s in $\alpha$ and $\gamma$ cancel identically, $(v-1)^2(\lambda-\mu)+(v-1)^2\mu=(v-1)^2\lambda$, which is why $\theta$ depends only on $(v,k,\lambda)$.

---

## V1, the closed form. CONFIRMED, constant and sign

**Forced ansatz.** A hollow symmetric solution constant on edges and on non-edges is $M=aA+b(J-I-A)$; the row sum is $ka+(v-1-k)b=0$, so $b=-ak/(v-1-k)=-at$. Confirmed.

**Norm.** $\lVert W\rVert^2=\sum_{i<j}M_{ij}^2=\tfrac{vk}2a^2+\tfrac{vw}2a^2t^2=\tfrac{a^2vk}2\Big(1+\tfrac kw\Big)=\dfrac{a^2vk(v-1)}{2(v-1-k)}$, so $a^2=2w/(vk(v-1))$ at unit norm. Confirmed.

**The convention is the right one, and there is no factor of 4.** The record's diagonal locus fixes $\operatorname{tr}M^2=2$ at $\lVert W\rVert=1$, and $\tfrac12\operatorname{tr}M^2=\sum_{i<j}M_{ij}^2$, so the two agree. The decisive check is external: $K_{m,m}$ evaluated through this normalisation returns $\sqrt{(2m-1)(m-1)}/m=\theta_0(2m)$ **exactly**, $1.054093$, $1.145644$, $1.200000$, $1.236033$ at $n=6,8,10,12$, and $\theta_0$ is defined outside this file. A factor-of-4 slip in $a$ would move $\theta$ by $2$ and could not do that.

**$F$ on an edge.** $F_{\text{edge}}=\alpha+\gamma+1$, and with $1+t=(v-1)/w$, $t=k/w$,

$$\alpha+\gamma=\frac{(v-1)^2\lambda+2k(v-1)-2k^2(v-1)+k^2(v-2)}{w^2}=\frac{(v-1)^2\lambda+2k(v-1)-k^2v}{w^2},$$

using $-2k^2(v-1)+k^2(v-2)=-k^2v$. Adding $1=w^2/w^2$ gives the recorded numerator exactly. So

$$\frac{\theta}{\lVert W\rVert}=\frac{(v-1)^2\lambda+2k(v-1)-k^2v+w^2}{w^2}\sqrt{\frac{2w}{vk(v-1)}}$$

is **correct as stated**, sign included. $n=v$ is correct: $M$ is $v\times v$, and hollow + symmetric + zero row sums makes $W=\mathrm{diag}(M_{ij})$ Ricci-flat and first-Bianchi (its only components on four distinct indices vanish), hence a genuine element of $\mathcal W_v$.

**Independent cross-check.** $\theta=\operatorname{tr}W^3+\langle W,W^\#\rangle=\tfrac12\big[\sum_{i,j}M_{ij}^3+\operatorname{tr}M^3\big]$, computable from the $v\times v$ spectrum: $0$, and $a[(1+t)\rho+t]$ for $\rho\in\{r,s\}$ with multiplicities $f,g$. Worked by hand at the octahedron: $A$ has spectrum $(4,-2^{\times2},0^{\times3})$, so $M=aN$ has $(0,-6a^{\times2},4a^{\times3})$, $\operatorname{tr}M^2=120a^2=2$ at $a^2=1/60$, $\operatorname{tr}M^3=-240a^3$, $\sum_{ij}M_{ij}^3=6(4-64)a^3=-360a^3$, giving $\theta=-300a^3=-300/60^{3/2}=-0.645497=-5/\sqrt{60}$. *Screen*: the two routes agree at every one of the 24 parameter sets I tabulated, and $\lVert W\rVert^2=1$ throughout.

---

## V3, the control. Number right, parameters wrong, identification right but stated through the wrong graph

### DEFECT: $\mathrm{SRG}(6,4,2,3)$ does not exist

The octahedron $K_{2,2,2}$ has $v=6$, $k=4$, $\lambda=2$, and $\mu=4$, not $3$: two antipodal vertices have all four remaining vertices as common neighbours. The recorded triple fails **the very identity V2 establishes**: $k(k-\lambda-1)=4$ while $(v-k-1)\mu=\mu$, forcing $\mu=4$.

**Why it went unnoticed, and why it still matters.** $F_{\text{edge}}$ is $\mu$-free (V2 above), so the printed $-5$ and $5/\sqrt{60}$ are unaffected. But $F_{\text{non}}$ is not: at the recorded $\mu=3$, $\gamma=75-160+64=-21$ and $F_{\text{non}}=+5/4$ against $F_{\text{edge}}=-5$, so the object the record names **is not a critical point at all**. At the true $\mu=4$, $\gamma=100-160+64=4$ and $F_{\text{non}}=-(4+16)/4=-5=F_{\text{edge}}$. A control whose parameter set violates the admissibility condition the same page just proved is not a control; the check passed for a reason unrelated to the object named.

### The identification: one object, not two sharing a $\theta$

**Confirmed, and it is genuinely the same critical point**, but reached through the complement. The $n=6$ maximal torus is $W=\Pi_{\mathfrak h}-\tfrac3{15}I$ with $\mathfrak h=\mathrm{span}\{e_{12},e_{34},e_{56}\}$: unit-norm $\Lambda^2$ spectrum $(0.516398^{\times3},-0.129099^{\times12})$. The octahedron member with $a>0$ has entries $a=0.129099$ (multiplicity $12$) and $-4a=-0.516398$ (multiplicity $3$), **the exact negative**. So

$$W_{\text{octahedron}}(a>0)=-W_{\text{torus}},\qquad \theta=-0.645497\ \text{vs}\ +0.645497,$$

consistent with $Q(-W)=Q(W)$. And $-W_{\text{octahedron}}$ *is* the family member for the complement, $\Gamma=3K_2=\mathrm{SRG}(6,1,0,0)$: entries $a$ on the matching and $-a/4$ off it, with $a=\sqrt{2\cdot4/(6\cdot1\cdot5)}=0.516398$ and $-a/4=-0.129099$. So the honest statement is: **the maximal torus is the perfect-matching member of the family**, and the octahedron is its complement. Two objects do not share a $\theta$ value; there is one object, and the record identified it through the graph on the wrong side of the sign it then had to apologise for.

The generalisation is immediate and is not on the record: $(n/2)K_2$ reproduces the torus at every even $n$, $0.645497$, $0.540062$, $0.474342$, $0.428174$ at $n=6,8,10,12$, matching [fence-posts.md](../findings/fence-posts.md)'s catalogued $0.645497$, $0.540062$, $0.474342$ and [bounds.md](../findings/bounds.md)'s slacks $1.291$, $2.160$, $2.846$, $3.425$.

### $C_5$: value confirmed, wording overstated

$\mathrm{SRG}(5,2,0,1)$ is feasible ($k(k-\lambda-1)=2=(v-k-1)\mu$), $w=2$, and the numerator is $16\cdot0+2\cdot2\cdot4-4\cdot5+4=0$. So $\theta=0$. **Confirmed.**

"Degenerates" overstates it: $M\ne0$ and $\lVert W\rVert=1$, so this is a genuine unit-norm critical point of the diagonal locus with $\theta=0$, i.e. $W^2=-W^\#$, not a collapse.

**And it is not isolated, an infinite $\theta=0$ subfamily, in closed form.** For any **conference graph**, $k=\tfrac{v-1}2$, $\lambda=\tfrac{v-5}4$, $\mu=\tfrac{v-1}4$, so $w=k$, $t=1$, and the numerator is

$$(v-1)^2\tfrac{v-5}4+(v-1)^2-\tfrac{(v-1)^2}4v+\tfrac{(v-1)^2}4=(v-1)^2\cdot\frac{(v-5)+4-v+1}4=0 .$$

So **every conference graph gives $\theta=0$**, $C_5$ being the smallest; $\mathrm{Paley}(9)$, $\mathrm{Paley}(13)$, $\mathrm{Paley}(25)$ confirm on the screen, as does Petersen, which is not a conference graph, so the $F=0$ locus is strictly larger than the conference family and is worth a line of its own.

---

## Summary of corrections owed to [diagonal-half.md](../findings/diagonal-half.md)

| where | what | severity |
|---|---|---|
| the Lemma L74 saturation paragraph | saturation criterion is $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$, not $n-2$; the ratio is $w/k$ or $k/w$ by orientation; the family **does** saturate, uniquely at $K_{n/2,n/2}$, which is the balanced sphere product | **load-bearing, the stated conclusion is false** |
| the Lemma L71 corroboration | rewrite in the positive direction, and state that a two-eigenvalue family cannot house the counterexample Lemma L71 rules out | **load-bearing, the claimed test is mis-shaped** |
| the Lemma L73 remark | "strictly inside at every admissible parameter set" is false; the bound is attained at $K_{(v/2)\times2}$ and at the perfect matching, at every even $v$ | real |
| Gate 1(a) | $\mathrm{SRG}(6,4,2,3)\to\mathrm{SRG}(6,4,2,4)$; the recorded triple is infeasible and is not a critical point | real, cosmetic in the number only |
| Gate 1(a) | state the identification through $3K_2$, and record that $(n/2)K_2$ is the maximal torus at every even $n$ | gain |
| the $C_5$ remark | every conference graph gives $\theta=0$; $F=0$ is a locus, not a coincidence | gain |
| the $\Lambda^2$ spectrum claim | correct, but say so against the $v\times v$ spectrum used three paragraphs earlier, which carries a zero and is a different object | clarity |

**What stands unshaken**: [Lemma L74](../findings/diagonal-half.md)'s closed form, its constant, its sign, its normalisation, and the automatic-admissibility result. The formula is right; the use made of it is not.
