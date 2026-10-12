# VERIFY v144, L8: the pinning formula $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, "one table lookup", and the finite check

**Verifier v144, cold brief.** I was given the block at [findings/graded-half.md](../findings/graded-half.md):421– and the canonical form at [results.md](../results.md):367, with the heading word withheld. **No numerical work was done: no script was run, and every value below is an exact hand evaluation from the record's own closed forms.** Log: [agent_logs/verify-L08-v144.log](../agent_logs/verify-L08-v144.log). I did not read [VERIFY_v143.md](VERIFY_v143.md) or [VERIFY_v145.md](VERIFY_v145.md); two of their lines surfaced incidentally in a grep and nothing from them is used here.

## Claim table

| # | claim, as a consumer would read it | verdict |
|---|---|---|
| **C1** | *"is pinned by its pair's dimensions, $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$"* ([results.md](../results.md):369, unrestricted) | **BROKEN**, the denominator vanishes on an infinite Pell family of pairs that are inside the statement's scope and above the rival maximizer |
| **C2** | the algebraic elimination producing that formula from the two block relations | **PROVEN**, I re-derived it exactly; the elimination is correct, and the pole is intrinsic to it |
| **C3** | *"the value follows from three integers and one table lookup"* | **BROKEN**, $\mathfrak{so}(m)$ takes $c_{\mathfrak k}=m-2$ in one pair and $2(m-2)$ in another, on the record's own catalogue; the embedding index is a fourth input the sentence omits |
| **C4** | *"it reproduces the Ricci-flat Kähler family … identically"* | **PROVEN**, I verified $(\mathfrak{su}(m),\mathfrak{so}(m))$ symbolically for all $m$ |
| **C5** | *"… and the sphere pairs identically"* | **BROKEN**, exact at balanced splits (verified for all $m$), false at every unbalanced one, undefined at infinitely many |
| **C6** | the $\mathbb{CP}^m$/$\mathfrak u(m)$ family | **BROKEN, wider than the record says**, undefined at $m=2$, needs $c_{\mathfrak k}=-7/4$ at $m=3$; the record's own refutation says "$m\ge4$" and is short by two |
| **C7** | *"the compact symmetric pairs being classified, the equivariant graded case is a finite check"* | **HYPOTHESIS-DEBT**, no classification source is in [references/](../references/) |
| **C8** | *"the check that was run settles the balanced splits only"* ([findings/graded-half.md](../findings/graded-half.md):427) | **PROVEN**, an accurate statement of the sweep's reach, and I confirm the screen is what produced it |
| **C9** | *"every sphere product is defect-free"* ([results.md](../results.md):124) | **PROVEN**, the one-line reason on file is a genuine proof and I reconstructed it |
| **C10** | scope: the pinning holds for the pair's **equivariant** point only | **HYPOTHESIS-DEBT**, the witness is a numerical object; the record labels it *Candidate, Gate 2 owed*, which is honest |
| **C11** | the heading: [results.md](../results.md):124 says **Lemma L8**, [results.md](../results.md):367 and [findings/graded-half.md](../findings/graded-half.md):421 say **Conjecture L8** | **BROKEN**, the same file uses both words for one id, and distinguishes them elsewhere |
| **C12** | *"Sphere products exceed the rival maximizer's value exactly when $p,q\ge5$, which needs $n\ge12$"* | **GAP**, the reduction to $n^2-7n-54\ge0$ is exact and I re-derived it; the clause "$p,q\ge5$ … needs $n\ge12$" is false, $p=q=5$ giving $n=10$ |

**Overall verdict: BROKEN.**

**One line.** The elimination behind L8 is correct and its two flagship families check out exactly by hand, but the sentence a consumer actually cites, [results.md](../results.md):369, carries the formula with none of its hypotheses, and it is *undefined* at $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$ and at infinitely many further sphere pairs that sit above $\sqrt{3/2}$ inside [Lemma L69](../findings/graded-half.md)'s own range.

## 0. Conventions, fixed once

- $(\mathfrak h,\mathfrak k)$ is a compact symmetric pair with $\mathfrak h\subseteq\mathfrak{so}(n)$ the **support** of $W$, $\mathfrak h=\mathfrak k\oplus\mathfrak m$, $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, $p+q=\dim\mathfrak h$. For the sphere pairs $\mathfrak h=\mathfrak{so}(n)$ and $p+q=\binom n2$; for $(\mathfrak{su}(m),\mathfrak{so}(m))$ it does **not**, $p+q=m^2-1$. [ATTEMPTS.md](../ATTEMPTS.md):1029 fixes this reading and I use it throughout.
- $C$ = Casimir of $\mathfrak k$ on $\mathfrak m$; $c_{\mathfrak k}$ = adjoint Casimir of $\mathfrak k$ on itself, both in the $\mathfrak{so}(n)$-induced normalisation $\sum_b\lVert[a,b]\rVert^2=c\lVert a\rVert^2$, which gives $c=2(k-2)$ for $\mathfrak{so}(k)$ **acting standardly** ([findings/conventions.md](../findings/conventions.md), as quoted at [reviews/REVIEW_r504.md](../reviews/REVIEW_r504.md):89).
- Sphere blocks: split $\mathbb R^a\oplus\mathbb R^b$ with $a+b=n$ corresponds to $S^a\times S^b$ (Correction 1 in the same file), so $\mathfrak k=\mathfrak{so}(a)\oplus\mathfrak{so}(b)$, $p=\binom a2+\binom b2$, $q=ab$.
- Sphere-product value, the record's own closed form: $\theta^2=\dfrac{2(n-1)(a-1)(b-1)}{(n-2)ab}$.
- Rival maximizer $\sqrt{3/2}$; $\theta_0(2m)=\sqrt{(2m-1)(m-1)}/m$.
- Letter collision, flagged once and then avoided: inside the blockquote at [findings/graded-half.md](../findings/graded-half.md):429 the symbols $p,q$ denote $\dim\mathfrak k,\dim\mathfrak m$ in the pinning formula and the **sphere block dimensions** in $\theta^2=2(n-1)(p-1)(q-1)/((n-2)pq)$, two meanings, four lines apart, in one paragraph. I write $a,b$ for blocks.

## 1. Hypothesis inventory

### 1a. Hypotheses the block carries

| # | hypothesis | where it is stated | does the written argument use it? |
|---|---|---|---|
| H1 | $W$ is a **critical point**, $Q(W)=\theta W$ | in the statement | yes, both block relations are rows of $Q(W)=\theta W$ |
| H2 | $W$ is **graded**: $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$, i.e. $\mathfrak h$ is a $\mathbb Z_2$-graded subalgebra | in the statement | yes, [ATTEMPTS.md](../ATTEMPTS.md) Step 3 makes the $\mathfrak m$-equation *equivalent* to it |
| H3 | $W$ is **$\mathrm{ad}(\mathfrak p)$-equivariant** | in the SCOPE REFUTED banner | yes, Schur is what makes $W$ scalar per summand |
| H4 | $\mathfrak k$ acts on $\mathfrak m$ with a **single** Casimir: $\mathfrak k$ simple, or its ideals interchanged by a symmetry of the pair | **[ATTEMPTS.md](../ATTEMPTS.md):1037 only** | yes, decisively, it is the two-eigenvalue ansatz |
| H5 | $2q>p$ | **[ATTEMPTS.md](../ATTEMPTS.md):1037 only**, as a sweep screen | yes, it is the denominator |
| H6 | $c_{\mathfrak k}\ge0$ and $C>0$ | **[ATTEMPTS.md](../ATTEMPTS.md):1037 only** | yes, §3d shows $\mathbb{CP}^3$ violates it |
| H7 | $\mathfrak h$ acts **irreducibly** on $\mathbb R^n$ | [ATTEMPTS.md](../ATTEMPTS.md):1029, 1035 | yes, it is what makes $\mathrm{Ric}(W)$ scalar, hence the dimension-only ansatz Ricci-flat |
| H8 | the **embedding index** of $\mathfrak k$ in $\mathfrak{so}(n)$ | [ATTEMPTS.md](../ATTEMPTS.md):1035, in passing | yes, §3c shows the value changes without it |
| H9 | $\ker W=0$ | **nowhere in the block** | not used; but [Lemma L7](../findings/bounds.md)'s equality class is a symmetric pair *only* when $\ker W=0$ |

**H4, H5, H6 and H8 appear in no citable form of the result.** They are in [ATTEMPTS.md](../ATTEMPTS.md) alone. Neither [results.md](../results.md):369, nor [results.md](../results.md):124, nor the canonical block at [findings/graded-half.md](../findings/graded-half.md):421 states any of them. That single fact drives C1, C3, C5 and C6.

### 1b. Hypotheses of the results the block imports

| imported result | its hypotheses | checked against the object here |
|---|---|---|
| $\Delta=0\iff\mathrm{ad}(\mathfrak p)$-equivariant ([findings/bounds.md](../findings/bounds.md)) | *on a graded point*; and per the labelling table, **vacuous where $\ker W\ne0$** | the block invokes it for the mechanism; its own counterexample is stated to have trivial kernel, so it applies **there**. It does **not** license the converse direction the block's assembly wants |
| the classification of compact symmetric pairs | that a classification exists and is complete | **no source in [references/](../references/)**, see §4 |
| the $\mathbb Z_2$-grading enumeration of $\mathfrak{so}(n)$ | complete **only for $n\ne8$** ([findings/graded-half.md](../findings/graded-half.md):~405) | the block's own worked example is at $n=8$. It survives, because it names the pair rather than enumerating, but any *exhaustiveness* reading of "finite check" inherits $n\ne8$ and the block never says so |
| [Lemma L69](../findings/graded-half.md) | $n\ge12$, $\theta\ge\sqrt{3/2}$, equivariant, pair-graded | [results.md](../results.md):124's L8 line asserts "every equivariant graded point above the rival maximizer is a sphere product" with **no $n\ge12$ and no $n\ne8$** attached |
| the $\mathrm{ad}(\mathfrak p)$-commutant count | *"one-dimensional at every symmetric pair **tested**"*, five pairs | this is the replacement for the classification ([findings/graded-half.md](../findings/graded-half.md):382). It is a measurement at $(3,5),(4,4),(2,6),(5,5),(4,6)$, not a theorem |

**No finding on H9:** the block neither needs nor excludes $\ker W\ne0$, because the two-eigenvalue operator $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$ has both eigenvalues nonzero by construction. But that is itself informative, see §5c.

## 2. Pre-registered question 1, what is established, and what is checked

**The general reduction, and it is genuinely general.** One statement is proved for all objects in scope, and it is an *algebraic elimination*, not a fact about critical points. Given the two relations the record writes down,

$$\text{(R1)}\quad \theta=\frac{qC-p}{\sqrt{pq(p+q)}},\qquad\qquad \text{(R2)}\quad c_{\mathfrak k}=\frac{C(2q-p)-2(p+q)}{q},$$

(R2) solves to $C=\dfrac{c_{\mathfrak k}q+2(p+q)}{2q-p}$, and substituting into (R1):

$$qC-p=\frac{c_{\mathfrak k}q^2+2q(p+q)}{2q-p}-p=\frac{c_{\mathfrak k}q^2+2pq+2q^2-2pq+p^2}{2q-p}=\frac{c_{\mathfrak k}q^2+2q^2+p^2}{2q-p}.$$

So the boxed formula is an exact consequence of (R1) and (R2), for every $(p,q,c_{\mathfrak k})$ with $2q\ne p$. **That much is proved and I confirm it** (C2). Note where the division by $2q-p$ enters: it is the step that eliminates $C$, so the pole is not cosmetic, it is the point where $C$ is not determined by $c_{\mathfrak k}$.

**What is *not* proved for all objects in scope.** (R1) itself. [ATTEMPTS.md](../ATTEMPTS.md):999 introduces it as *"The law … Verified exactly (ansatz match, $C$ integral) at every two-eigenvalue point in the catalogue"* and lists seven points. No derivation of (R1) from $Q(W)=\theta W$ appears anywhere I could find. (R2) **is** derived, total antisymmetry of the structure constants gives $A_{\mathfrak{mm}}=qC/p$ and the $\mathfrak k$-block reduces, and Step 4's counting identity $\sum_ic_ip_i+3q\sum_iC_i=c^{\mathrm{ad}}_{\mathfrak h}(p+q)$ **is** derived. So the record's own confidence note is the accurate one: *"High for the law as stated (exact match with integral $C$ at seven catalogue points …)"*. Under this programme's first rule that is agreement, not evidence. **(R1) is hypothesis-debt: what would have to be shown is that the $\mathfrak m$-block of $Q(W)=\theta W$, evaluated on $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$, reduces to $\theta\sqrt{pq(p+q)}=qC-p$.**

**What is verified family by family, and which families.** From [ATTEMPTS.md](../ATTEMPTS.md):1037, Step 5: $594$ pairs over $\mathfrak h=\mathfrak{so}(N)$ with $\mathfrak k=\mathfrak{so}(j)\oplus\mathfrak{so}(N-j)$ or $\mathfrak u(N/2)$; $\mathfrak h=\mathfrak{su}(m)$ with $\mathfrak k=\mathfrak{so}(m),\mathfrak{sp}(m/2),\mathfrak s(\mathfrak u(j)\oplus\mathfrak u(m-j))$; $\mathfrak h=\mathfrak{sp}(m)$ with $\mathfrak k=\mathfrak u(m)$ or $\mathfrak{sp}(j)\oplus\mathfrak{sp}(m-j)$; $N,m\le40$. Of those, **53 survive the screen**, $500$ rejected for non-single $\mathfrak k$ (H4), $38$ for $2q\le p$ (H5), $3$ on Casimir sign (H6).

**So the honest separation is:**

- **proved for all objects in scope:** the elimination (R1)+(R2) $\Rightarrow$ boxed formula, and *nothing else*;
- **verified family by family:** the balanced $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ splits, $(\mathfrak{su}(m),\mathfrak{so}(m))$, Fox, $\mathbb{HP}^2$ ideal-wise, and the $\mathfrak{sp}$/$\mathfrak{su}$ **rejections**;
- **not covered at all:** every unbalanced $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ split, every $\mathfrak u(m)$ pair, and the exceptional algebras, the last named as outstanding by the block, the first two not named anywhere a consumer reads.

The block's own sentence *"the check that was run settles the balanced splits only"* ([findings/graded-half.md](../findings/graded-half.md):427) states this correctly. **C8: PROVEN.** The screen H4 is what did it: $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ with $a\ne b$ has two ideals of different dimension, so no symmetry of the pair interchanges them, so every unbalanced split falls in the $500$ before it is evaluated.

## 3. Pre-registered question 2, does the value follow from the pair's dimensions and one Casimir ratio?

**Answer: on the balanced sphere splits and on $(\mathfrak{su}(m),\mathfrak{so}(m))$, yes and exactly. Off them, no, and in two different ways, one of which the record has not recorded.**

### 3a. Balanced sphere pairs $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$, exact for every $m$

$p=m(m-1)$, $q=m^2$, $p+q=2m^2-m=m(2m-1)=\binom{2m}2$ ✓, $c_{\mathfrak k}=2(m-2)$. Then

$$c_{\mathfrak k}q^2+2q^2+p^2=\big(2(m-2)+2\big)m^4+m^2(m-1)^2=2m^4(m-1)+m^2(m-1)^2=m^2(m-1)\big[2m^2+m-1\big]=m^2(m-1)(2m-1)(m+1),$$
$$2q-p=2m^2-m^2+m=m(m+1),\qquad \sqrt{pq(p+q)}=\sqrt{m(m-1)\cdot m^2\cdot m(2m-1)}=m^2\sqrt{(m-1)(2m-1)},$$
$$\theta=\frac{m^2(m-1)(2m-1)(m+1)}{m(m+1)\cdot m^2\sqrt{(m-1)(2m-1)}}=\frac{\sqrt{(m-1)(2m-1)}}{m}=\theta_0(2m).\quad\square$$

Cross-check against the sphere closed form at $a=b=m$, $n=2m$: $\theta^2=\dfrac{2(2m-1)(m-1)^2}{(2m-2)m^2}=\dfrac{(2m-1)(m-1)}{m^2}$ ✓ identical. At $m=6$, $n=12$: $\theta^2=5\cdot11/36=55/36$, matching the record's exact rational for the $6{+}6$ split.

### 3b. The Ricci-flat Kähler family $(\mathfrak{su}(m),\mathfrak{so}(m))$, exact for every $m$

$p=\tfrac{m(m-1)}2$, $q=\tfrac{(m+2)(m-1)}2$, $p+q=m^2-1=\dim\mathfrak{su}(m)$ ✓, $C=m$. Via (R1):

$$qC-p=\frac{m(m+2)(m-1)}2-\frac{m(m-1)}2=\frac{m(m-1)(m+1)}2,\qquad pq(p+q)=\frac{m(m-1)^3(m+1)(m+2)}4,$$
$$\theta=\frac{m(m-1)(m+1)/2}{\tfrac{(m-1)}2\sqrt{m(m-1)(m+1)(m+2)}}=\frac{m(m+1)}{\sqrt{m(m-1)(m+1)(m+2)}},\qquad \theta^2=\frac{m(m+1)}{(m-1)(m+2)}.\quad\square$$

That is [Lemma L38](../results.md):162's closed form identically, for all $m$. **C4: PROVEN.**

### 3c. "Three integers and one table lookup", refuted on the record's own catalogue

Feed 3b through (R2). With $2q-p=(m-1)(m+4)/2$ and $C=m$:

$$c_{\mathfrak k}=\frac{m(m-1)(m+4)/2-2(m^2-1)}{(m+2)(m-1)/2}=\frac{m(m+4)-4(m+1)}{m+2}=\frac{m^2-4}{m+2}=m-2.$$

So in the $(\mathfrak{su}(m),\mathfrak{so}(m))$ pair the isotropy $\mathfrak{so}(m)$ carries $c_{\mathfrak k}=m-2$. In the balanced sphere pair the isotropy $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ carries $c_{\mathfrak k}=2(m-2)$, §3a. **Same algebra, two values, a factor of $2$ apart**, because $\mathfrak{so}(m)\subset\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ acts on $\mathbb R^{2m}$ as *two* copies of $\mathbb R^m$, index $2$.

This is not my arithmetic against the record's; it is the record's own catalogue read back. [ATTEMPTS.md](../ATTEMPTS.md):1037 lists $(p,q,c_{\mathfrak k})$: $\mathfrak{su}(3)\ (3,5,1)$ (and $m-2=1$, not $2(m-2)=2$; $\mathfrak{su}(4)\ (6,9,2)$), $m-2=2$; $\mathfrak{su}(6)\ (15,20,4)$, $m-2=4$. Three exact hits for $m-2$, three misses for $2(m-2)$. Against the spheres: $S^3\times S^3\ (6,9,2)=2(3-2)$, $S^4\times S^4\ (12,16,4)=2(4-2)$, $S^6\times S^6\ (30,36,8)=2(6-2)$.

**So a consumer who reads *"the value follows from three integers and one table lookup"*, looks up $\mathfrak{so}(3)$ in the record's own convention ($c=2(k-2)=2$) and applies it to the $\mathfrak{su}(3)$ pair gets the wrong $\theta$.** [ATTEMPTS.md](../ATTEMPTS.md) knows this (it writes *"needing only the embedding index"*) and no citable form of L8 repeats it. **C3: BROKEN**, hypothesis H8 omitted.

### 3d. The $\mathfrak u(m)$ / $\mathbb{CP}^m$ family, and the record's own refutation is short by two

At a $\mathfrak u(m)$ pair, $\mathfrak h=\mathfrak{so}(2m)$, $\mathfrak k=\mathfrak u(m)$, so $p=m^2$, $q=\binom{2m}2-m^2=m(m-1)$, $p+q=m(2m-1)$, and

$$2q-p=2m(m-1)-m^2=m(m-2).$$

The unique invariant at a $\mathfrak u(m)$ pair is $\mathbb{CP}^m$ ([findings/graded-half.md](../findings/graded-half.md):382), with $\theta^2=\dfrac{(m+1)(2m-1)}{3m(m-1)}$.

- **$m=2$, the formula is undefined at the rival maximizer itself.** $p=4$, $q=2$, $2q-p=0$; the numerator is $4c_{\mathfrak k}+8+16>0$, so this is a genuine pole, not a $0/0$. $W_{\mathbb{CP}^2}$ is the point that *attains* $\sqrt{3/2}$, the whole reason the family is on the record, and the pinning formula returns no value there.
- **$m=3$, the formula requires a negative Casimir.** $p=9$, $q=6$, $2q-p=3$, $pq(p+q)=9\cdot6\cdot15=810=81\cdot10$, so $\sqrt{810}=9\sqrt{10}$. And $\theta^2=\tfrac{4\cdot5}{3\cdot3\cdot2}=\tfrac{10}9$, $\theta=\tfrac{\sqrt{10}}3$. Then $\theta\,(2q-p)\sqrt{pq(p+q)}=\tfrac{\sqrt{10}}3\cdot3\cdot9\sqrt{10}=90$, while the numerator is $36c_{\mathfrak k}+2\cdot36+81=36c_{\mathfrak k}+153$. Hence $c_{\mathfrak k}=-\tfrac{63}{36}=-\tfrac74$. **Negative**, so no adjoint Casimir, and it violates H6 outright.
- **$m=4$, irrational.** $p=16$, $q=12$, $2q-p=8$, $pq(p+q)=16\cdot12\cdot28=5376=256\cdot21$, $\sqrt{5376}=16\sqrt{21}$; $\theta^2=\tfrac{5\cdot7}{3\cdot4\cdot3}=\tfrac{35}{36}$, $\theta=\tfrac{\sqrt{35}}6$. Then $\theta(2q-p)\sqrt{pq(p+q)}=\tfrac{\sqrt{35}}6\cdot8\cdot16\sqrt{21}=\tfrac{64}3\sqrt{735}=\tfrac{448}3\sqrt{15}$, irrational, so $c_{\mathfrak k}=\big(\tfrac{448}3\sqrt{15}-544\big)/144$ is irrational.

**The blockquote at [findings/graded-half.md](../findings/graded-half.md):429 says the pinning *"fails at … $\mathbb{CP}^m$ for $m\ge4$".* It fails at $m=2$ and $m=3$ as well**, and at $m=2$ it fails harder than anywhere else on the record. Structurally the reason is uniform: $\mathfrak u(m)=\mathfrak u(1)\oplus\mathfrak{su}(m)$ has ideals of unequal dimension for every $m\ge2$, so no symmetry of the pair interchanges them and **H4 fails for the entire family**. **C6: BROKEN**, and the record's own correction is itself short by two members.

### 3e. A pair where the two sides could differ, and the falsifier the record does not hold

The brief asked for a named symmetric pair where the two sides could come apart. I took two, and the second is the finding of this report.

**(i) $S^5\times S^7$ at $n=12$, finite and wrong.** $\mathfrak k=\mathfrak{so}(5)\oplus\mathfrak{so}(7)$, $p=10+21=31$, $q=5\cdot7=35$, $p+q=66=\binom{12}2$ ✓, $2q-p=39$. The true value is $\theta^2=\dfrac{2\cdot11\cdot4\cdot6}{10\cdot35}=\dfrac{264}{175}$, the record's own exact rational. Squaring the pinning formula and clearing:

$$\big(c_{\mathfrak k}\cdot1225+3411\big)^2=\theta^2(2q-p)^2\,pq(p+q)=\frac{264}{175}\cdot1521\cdot71610=\frac{264\cdot1521\cdot71610}{175}.$$

$71610/175$ is not an integer and $71610\cdot264/175=108028.8$ lies strictly between $328^2=107584$ and $329^2=108241$, so $c_{\mathfrak k}$ is **irrational**. No Casimir table contains it. The same happens at the block's own headline pair $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$: $p=13$, $q=15$, $2q-p=17$, $pq(p+q)=5460$, $\theta^2=56/45$, and $17^2\cdot5460\cdot\tfrac{56}{45}=289\cdot6794.\overline{6}$ is not a square. This confirms what the blockquote already says.

**(ii) $S^{20}\times S^5$ at $n=25$, the formula has a pole, and the point is above the rival maximizer.** This one the record does not hold.

$\mathfrak k=\mathfrak{so}(20)\oplus\mathfrak{so}(5)$ inside $\mathfrak{so}(25)$:

$$p=\binom{20}2+\binom52=190+10=200,\qquad q=20\cdot5=100,\qquad p+q=300=\binom{25}2\ \checkmark,\qquad \boxed{2q-p=200-200=0.}$$

Its value, from the record's own closed form:

$$\theta^2=\frac{2\cdot24\cdot19\cdot4}{23\cdot100}=\frac{3648}{2300}=\frac{912}{575}>\frac32=\frac{862.5}{575}.$$

So this is an **equivariant graded critical point, in a compact symmetric pair, at odd $n=25\ge12$, with $\theta>\sqrt{3/2}$**, squarely inside the scope of [results.md](../results.md):369 and inside [Lemma L69](../findings/graded-half.md)'s range, **and the formula that is said to pin it returns no value at all.** Both blocks have dimension $\ge5$, so it also satisfies the record's own above-threshold criterion.

**It is not an isolated accident. There are infinitely many, and they are a Pell family.** For $\mathfrak k=\mathfrak{so}(a)\oplus\mathfrak{so}(b)$, $a+b=n$: $p+q=\binom n2$, so $2q=p$ forces $p=\tfrac23\binom n2$ and hence $q=\tfrac13\binom n2$, i.e. $ab=\tfrac{n(n-1)}6$. With $a+b=n$ the discriminant is

$$n^2-4\cdot\frac{n(n-1)}6=\frac{3n^2-2n^2+2n}{3}=\frac{n(n+2)}3,$$

so integrality needs $n(n+2)=3s^2$, i.e. $(n+1)^2-3s^2=1$, **Pell's equation**. Its solutions $(n+1,s)=(2,1),(7,4),(26,15),(97,56),(362,209),\dots$ give

| $n$ | $s$ | $(a,b)=\big(\tfrac{n+s}2,\tfrac{n-s}2\big)$ | $p$ | $q$ | $2q-p$ | above $\sqrt{3/2}$? |
|---|---|---|---|---|---|---|
| $6$ | $4$ | $(5,1)$ | $10$ | $5$ | $0$ | no, a degenerate $S^1$ factor |
| $25$ | $15$ | $(20,5)$ | $200$ | $100$ | $0$ | **yes**, $\theta^2=912/575$ |
| $96$ | $56$ | $(76,20)$ | $3040$ | $1520$ | $0$ | **yes** |
| $361$ | $209$ | $(285,76)$ | (|), | $0$ | **yes** |

($n=96$: $p=\binom{76}2+\binom{20}2=2850+190=3040$, $q=76\cdot20=1520$, $p+q=4560=\binom{96}2$ ✓.) Every entry from $n=25$ on has both blocks $\ge5$ and $n\ge12$, so by §5a every one exceeds $\sqrt{3/2}$.

**Where the pole comes from, and why it is not a contradiction in the mathematics.** At $2q=p$, (R2) reads $c_{\mathfrak k}q=-2(p+q)<0$, so no pair with $2q=p$ can satisfy the two-eigenvalue system with $c_{\mathfrak k}\ge0$. The resolution is H4: $\mathfrak{so}(20)\oplus\mathfrak{so}(5)$ has two non-interchangeable ideals, so the two-eigenvalue ansatz was never the right operator there and the ideal-wise system of [ATTEMPTS.md](../ATTEMPTS.md) Step 2 is what applies. **The mathematics is consistent; the sentence is not.** The sentence asserts a pinning of *the* equivariant graded critical point of *a* compact symmetric pair, and there are infinitely many such points at which it is undefined.

## 4. Pre-registered question 3, what does "finite" rest on?

**The classification used.** The block's word is explicit: *"Since the compact symmetric pairs are classified, the graded case is then a finite check"*, and [results.md](../results.md):369 repeats it. The classification meant is Cartan's list of compact symmetric pairs (equivalently the $\mathbb Z_2$-gradings of the compact simple algebras).

**Is the source on file? No.** [references/](../references/) holds sixty entries; I read the folder listing and [references/INDEX.md](../references/INDEX.md) in full. **There is no Cartan, no Helgason, no Berger, no Besse.** The two nearest entries are [reeder-2013-gradings-positive-rank](../references/reeder-2013-gradings-positive-rank/), whose own index line reads *"The classification exists and is finite, Kac coordinates parametrise torsion automorphisms"* and *"Supplies no bound on $\theta$"*, and [schwahn-2020-symmetric-space-stability](../references/schwahn-2020-symmetric-space-stability/), which supplies a counting template rather than a list. **So the "finite check" rests on an unread source**, and the earlier rounds' finding (this record holds no Cartan/Helgason/Berger/Besse entry), is confirmed by direct reading rather than assumed.

**What the check would have to exhaust without it.** For each $n$, every $\mathbb Z_2$-graded subalgebra $\mathfrak h=\mathfrak k\oplus\mathfrak m\subseteq\mathfrak{so}(n)$ up to conjugacy, together with each conjugacy class of embedding. The record's own enumeration table gives the $\mathfrak h=\mathfrak{so}(n)$ row of that: $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$, $\mathfrak u(n/2)$, plus $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ **at $n=8$ only**, the last two being triality images. **That row is complete only for $n\ne8$**, and it covers only $\mathfrak h=\mathfrak{so}(n)$; the $\mathfrak{su}$, $\mathfrak{sp}$ and exceptional supports are a separate enumeration that the block names as outstanding.

**Two further things "finite" does not deliver.**

1. **It is finite per dimension, not finite.** The pairs $(\mathfrak{so}(n),\mathfrak k)$ form a finite set for each $n$; the conjecture quantifies over all $n\ge12$. What discharges that is the *closed forms* ($\theta^2=2(n-1)(a-1)(b-1)/((n-2)ab)$ and $\theta^2=(m+1)(2m-1)/(3m(m-1))$), not the word "finite". The block never says so.
2. **The record has already moved off the classification for the assembly, and onto a measurement.** [findings/graded-half.md](../findings/graded-half.md):382 says *"it no longer needs the classification"* because the $\mathrm{ad}(\mathfrak p)$-commutant in $\mathcal W_n$ is one-dimensional, *"at every symmetric pair **tested**"*, five of them: $(3,5)$, $(4,4)$, $(2,6)$ at $n=8$ and $(5,5)$, $(4,6)$ at $n=10$. **That is agreement at five points, offered in place of a classification.** It is a screen, not a theorem, and swapping an unread classification for it trades one debt for another. **C7: HYPOTHESIS-DEBT**, what would have to be shown is either a citable classification of compact symmetric pairs, or the commutant count $\dim(\mathcal W_n)^{\mathrm{ad}(\mathfrak p)}=1$ for all $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ and all $n$, as a proof.

## 5. Quantifier order, scope, and the edge of every range

### 5a. The exceedance criterion, re-derived, and one clause that is false

The blockquote writes: *"Sphere products exceed the rival maximizer's value **exactly when $p,q\ge5$**, which needs $n\ge12$, the closed form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ reduces the condition to $n^2-7n-54\ge0$."* Here $p,q$ are block dimensions; I write $a,b$.

Set $a'=a-1$, $b'=b-1$, $s=a'+b'=n-2$, $\mu=a'b'$. Then $n-1=s+1$ and $ab=\mu+s+1$, so

$$\theta^2>\tfrac32\iff 4\mu(s+1)>3s(\mu+s+1)\iff \mu(s+4)>3s(s+1).$$

- **$a=4$:** $\mu=3b'$, $s=3+b'$, and the condition is $3b'(b'+7)>3(b'+3)(b'+4)$, i.e. $0>12$. **Impossible for every $b$**, so $a\le4$ never exceeds. The necessity of $a,b\ge5$ is correct.
- **$a=5$:** $\mu=4b'$, $s=4+b'$, and the condition is $4b'(b'+8)>3(b'+4)(b'+5)$, i.e. $b'^2+5b'-60>0$; with $b'=n-6$ this is $n^2-7n-54>0$, root $(7+\sqrt{265})/2\approx11.639$, so $n\ge12$. **The reduction is exact and I confirm it**, and it is [Lemma L69](../findings/graded-half.md)'s own inequality, reached there from $\lVert W\rVert^2\le\tfrac16$. A real cross-check.

**But "exactly when $p,q\ge5$, which needs $n\ge12$" is false as a statement of the logical relation.** $a=b=5$ has both blocks $\ge5$ and $n=10$: $\theta^2=\dfrac{2\cdot9\cdot4\cdot4}{8\cdot25}=\dfrac{36}{25}=1.44<\tfrac32$. And $a=5,b=6$, $n=11$: $\theta^2=\dfrac{2\cdot10\cdot4\cdot5}{9\cdot30}=\dfrac{40}{27}\approx1.4815<\tfrac32$. So the "exactly when" fails, and $p,q\ge5$ does not *need* $n\ge12$, it needs $n\ge10$.

**Most charitable reading:** the intended condition is the conjunction *$a,b\ge5$ **and** $n\ge12$*, which the final clause's own reduction supplies and which is correct. Under that reading the content is right and the sentence misstates the relation between its two halves. **C12: GAP**, not BROKEN, nothing downstream spends it, because [Lemma L69](../findings/graded-half.md) carries $n\ge12$ in its hypotheses.

### 5b. The smallest admissible $n$, and odd $n$

**[results.md](../results.md):369 states no range at all.** No $n\ge12$, no $n\ne8$, no exclusion of $n=4$. Taken at its word:

- **$n=4$:** the pair $(\mathfrak{so}(4),\mathfrak u(2))$ is in scope, and §3d shows $2q-p=0$, a pole at the record's own rival maximizer.
- **$n=8$:** in scope, and the $\mathbb Z_2$-grading enumeration the finite check quotes is **incomplete at exactly $n=8$**. The block's own worked example lives there.
- **odd $n$:** nothing in the block restricts parity, and §3e(ii)'s falsifier is at **odd $n=25$**. The $\mathfrak u(n/2)$ row needs even $n$; the $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ row does not, and that is where the poles are.
- **$n=6$:** the Pell family's first entry, $(a,b)=(5,1)$, is a pole with a degenerate $S^1$ factor. Below the threshold, so harmless, but it is inside the unrestricted statement.

### 5c. $\ker W\ne0$, and the reducible / non-equivariant cases

- **$\ker W$.** The two-eigenvalue operator $W=(q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m})/\sqrt{pq(p+q)}$ has eigenvalues $q$ and $-p$ up to scale, both nonzero, so **the ansatz cannot represent any point with $\ker W\ne0$**. The record's own $W_{\mathbb{CP}^2}$ at $n=4$ has *"its kernel carrying $3$ of $6$"* ([findings/graded-half.md](../findings/graded-half.md):284). So even setting the pole aside, the ansatz operator at $(\mathfrak{so}(4),\mathfrak u(2))$ is not $W_{\mathbb{CP}^2}$. Two independent failures at one point.
- **Padded points.** Any padding of a critical point has $\ker W\ne0$ and is silently outside the ansatz; [results.md](../results.md):369 says nothing.
- **Non-equivariant graded points.** The block is explicit and correct that these are outside it, with [item C3](../plan.md) named as where the graded half is actually open. **No finding against it.**
- **Reducible isotropy.** This is H4 by another name, and it is the omission that carries C1, C3, C5 and C6. Every $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ with $a\ne b$, and every $\mathfrak u(m)$, has reducible non-interchangeable isotropy.

## 6. The universal claim, and one object from each family

*"Settled across the classical families"* is the heading's own phrase. Here is one object per family, worked.

| family | object tried | pinning formula | verdict |
|---|---|---|---|
| balanced $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ | $S^6\times S^6$, $n=12$: $p=30$, $q=36$, $c_{\mathfrak k}=8$ | $\theta^2=55/36$, §3a for all $m$ | **exact** |
| unbalanced $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$, finite | $S^5\times S^7$, $n=12$: $p=31$, $q=35$ | needs irrational $c_{\mathfrak k}$ | **fails** |
| unbalanced $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$, pole | $S^{20}\times S^5$, $n=25$: $p=200$, $q=100$ | $2q-p=0$, undefined | **fails, and the point is above $\sqrt{3/2}$** |
| $(\mathfrak{su}(m),\mathfrak{so}(m))$ | $\mathfrak{su}(6)$: $p=15$, $q=20$, $c_{\mathfrak k}=4$ | $\theta^2=\tfrac{6\cdot7}{5\cdot8}=\tfrac{21}{20}$ | **exact**, §3b for all $m$ |
| $\mathfrak u(m)$ / $\mathbb{CP}^m$ | $\mathbb{CP}^2$, $n=4$: $p=4$, $q=2$ | $2q-p=0$, undefined | **fails at the rival maximizer** |
| $(\mathfrak{sp}(2j),\mathfrak{sp}(j)\oplus\mathfrak{sp}(j))$ | rejected on Casimir sign | no critical point | **correctly rejected** ([reviews/REVIEW_r503.md](../reviews/REVIEW_r503.md) reconstructs the arithmetic) |
| exceptional class in the enumeration | $\mathbb{HP}^2=(\mathfrak{so}(8),\mathfrak{sp}(1)\oplus\mathfrak{sp}(2))$: $p=13$, $q=15$ | same $(p,q)$ as $S^3\times S^5$, so same irrational $c_{\mathfrak k}$ | **fails**, and it cannot separate the two embeddings |
| exceptional **algebras** $\mathfrak g_2,\mathfrak f_4,\mathfrak e_{6,7,8}$ | (|), | **no data on file.** The block names these as outstanding, correctly. Testing one needs Casimir tables that are not in [references/](../references/), so I did not, and the scope's exceptional corner is untested rather than settled |

*Note on $\mathfrak{su}(6)$:* the row is the closed form $\theta^2=m(m+1)/((m-1)(m+2))$ of §3b evaluated at $m=6$; it is that identity, verified for all $m$, that I checked, and $c_{\mathfrak k}=m-2=4$ is the record's own catalogue entry.

**On $\mathbb{HP}^2$ and triality.** The block's closure, *"Two non-conjugate embeddings of a single pair require an outer automorphism, which $\mathfrak{so}(N)$ possesses only at $N=8$"*, is sound **given the record's own $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ statement, which carries $n\ge5$**. The block quotes the conclusion without the $n\ge5$. Small, and nothing below the threshold turns on it, but it is the same omission pattern.

## 7. Comparing the three forms, and the Lean row

| where | heading | what it says the result is |
|---|---|---|
| [findings/graded-half.md](../findings/graded-half.md):421 | **Conjecture L8** | banner-refuted scope, formula quoted as *"the sentence as originally written"*, **plus a blockquote refuting the pinning off balanced splits** |
| [results.md](../results.md):367 | **Conjecture L8** | the formula asserted in the present tense, **no balanced restriction, no blockquote, no H4/H5/H6/H8** |
| [results.md](../results.md):124 | **Lemma L8** | *"An equivariant graded point's value follows from its pair's dimensions and one Casimir ratio"*, the same unrestricted assertion, in one line |
| [lean/INDEX.md](../lean/INDEX.md):359 | listed as **L8** | in the bucket *"out, needs machinery Mathlib does not have: the classification of compact symmetric spaces"* |

**Three differences in what the record calls this result.**

1. **Two headings for one id.** [results.md](../results.md):124 says *Lemma*; the same file at :367 and the findings block say *Conjecture*. I searched [CONTRIBUTING.md](../CONTRIBUTING.md) and [.claude/rules/](../.claude/rules/) and **found no written labelling rule**, so I record the inconsistency on the record's own usage instead: the very list at :124 contains *"Conjecture L6 (landscape)"* alongside *"Lemma L7 (landscape)"*, so that file does distinguish the two words, and applying both to L8 is an inconsistency rather than a loose convention. It matters here because the block is *Candidate, Gate 2 owed* by its own banner and carries a refuted sentence, the weaker word is the correct one. **C11: BROKEN.**
2. **[results.md](../results.md):124 drops the scope conditions.** It asserts *"every equivariant graded point above the rival maximizer is a sphere product"* with no $n\ge12$ and no $n\ne8$, although that statement is [Lemma L69](../findings/graded-half.md)'s and L69 carries both. Its second half, *"every sphere product is defect-free"*, is fine, see §8b.
3. **The Lean row names the wrong obstruction, twice.** It says L8 is out because it needs *"the classification of compact symmetric **spaces**"*. By §2 the part of L8 that is actually proved (the elimination (R1)+(R2) $\Rightarrow$ boxed formula), is pure algebra in $(p,q,c_{\mathfrak k})$ and needs no classification at all; it is formalisable today. And by the same findings file's **Correction 5**, *"Graded critical points here are indexed by symmetric **pairs** $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$; Petersen–Stanfield classify symmetric **spaces** … their tables do not enumerate what needs enumerating."* **The row names the classification the record has already ruled out as the wrong one.**

**What the row would have to claim instead:** *the elimination lemma*, for $p,q>0$ with $2q>p$ and reals $C,c_{\mathfrak k}$ satisfying (R2), $(qC-p)/\sqrt{pq(p+q)}=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, as `ready`, with the hypothesis $2q>p$ explicit; and separately, the finite check as blocked on a classification of symmetric **pairs** inside $\mathfrak{so}(n)$, which is a different and larger object.

## 8. The named trap, each citable claim read alone, as a consumer would

This record's signature failure is a correction landing *beside* the statement it corrects. **It has happened here, and in the worst place.**

### 8a. The correction is in one file and the citable statement is in another

[findings/graded-half.md](../findings/graded-half.md):429 carries a blockquote headed **"THE PINNING IS REFUTED OFF THE BALANCED SPLITS, AND SO IS THE SENTENCE ABOUT SPHERE PRODUCTS"**, Gate 2 by [r503](../reviews/REVIEW_r503.md) and [r504](../reviews/REVIEW_r504.md), both REFUTED. It names the failures: $S^3\times S^5$, $S^3\times S^7$, $S^4\times S^6$, $S^5\times S^7$, $S^3\times S^9$, $S^4\times S^8$, $S^2\times S^6$, and $\mathbb{CP}^m$ for $m\ge4$.

**[results.md](../results.md):369 (the canonical statement, and the only form a consumer citing "L8" will read), contains none of it.** Read alone it says: *"An equivariant graded critical point … is pinned by its pair's dimensions, $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$ … So the value follows from three integers and one table lookup … **it reproduces the Ricci-flat Kähler family and the sphere pairs identically**."* The final clause is the exact sentence the blockquote refutes, still in the present tense, on the canonical page. Its proof pointer is `**Proof:** [graded-half.md](findings/graded-half.md)`, a whole-file pointer, so a consumer is not even directed to the paragraph carrying the retraction.

[results.md](../results.md):124 repeats the unrestricted version in one line.

**A consumer citing L8 for the value of an unbalanced sphere pair inherits a refuted formula, and nothing in the sentence they read warns them.** That is the trap, exactly.

### 8b. What *does* survive a solitary reading

- *"every sphere product is defect-free"* ([results.md](../results.md):124). **PROVEN**, and the one-line reason on file is a real argument: for $S^a\times S^b$, $W\propto q\Pi_{\mathfrak k}-p\Pi_{\mathfrak m}$ with $\mathfrak m=\mathbb R^a\otimes\mathbb R^b$, so $W_-$ is supported on $\mathfrak m$ alone; $\Pi_{\mathfrak m}=\sum_\alpha v_\alpha\odot v_\alpha$ over the basis $\{e_i\wedge f_j\}$, every member of which is a **decomposable** bivector, and $\mathrm{Alt}(v\odot v)\propto v\wedge v=0$ for decomposable $v$. No balance and no $n$ enters, so *"every dimension and every split"* is exactly right. **C9: PROVEN.** It consumes the sign convention (that $W_-$ sits on $\mathfrak m$) which [findings/conventions.md](../findings/conventions.md) records as a live collision, so that is the one thing to guard.
- The scope banner *"the pinning holds for the pair's EQUIVARIANT critical point, not for every graded one"*. It is prominent, it is at the head of both the findings block and [findings/INDEX.md](../findings/INDEX.md):20, and [results.md](../results.md):369 carries it too. **The scope correction did not land beside the statement, it landed on it.** Credit where due; the failure at 8a is specifically about the *balanced-splits* correction.
- The outstanding list, *"the same closure for the $\mathfrak{su}$ and $\mathfrak{sp}$ families, and the exceptional algebras"*, is accurate.

## 9. The gap between what is proven and what is used, and what a consumer may cite

**Proven.**

- **P1.** The elimination: (R1) and (R2) imply the boxed formula, for any $(p,q,C,c_{\mathfrak k})$ with $2q\ne p$. Pure algebra, §2.
- **P2.** (R2) itself, from total antisymmetry of the structure constants via $A_{\mathfrak{mm}}=qC/p$. [ATTEMPTS.md](../ATTEMPTS.md):1016.
- **P3.** The counting identity $\sum_ic_ip_i+3q\sum_iC_i=c^{\mathrm{ad}}_{\mathfrak h}(p+q)$. [ATTEMPTS.md](../ATTEMPTS.md):1035.
- **P4.** $\theta=\theta_0(2m)$ on balanced sphere pairs and $\theta^2=m(m+1)/((m-1)(m+2))$ on $(\mathfrak{su}(m),\mathfrak{so}(m))$, both for all $m$, §3a, §3b, re-derived here.
- **P5.** Every sphere product is defect-free, §8b.

**Not proven, and used.**

- **D1.** (R1). No derivation from $Q(W)=\theta W$ on file; seven catalogue points and two reproduced closed forms. Everything above (R1) inherits this.
- **D2.** The classification of compact symmetric pairs. No source in [references/](../references/). Its stand-in, the commutant count, is five measurements.
- **D3.** The correspondence *equivariant graded critical point $\leftrightarrow$ compact symmetric pair*. The block states plainly that it **assumes** this, its implication running pair $\Rightarrow$ value and never point $\Rightarrow$ pair. Correctly flagged at [findings/graded-half.md](../findings/graded-half.md):417 and at [results.md](../results.md):555, and **not** flagged at [results.md](../results.md):369.
- **D4.** The scope refutation itself (C10). Its witness is a numerically converged second critical point on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ at $\theta=1.088948$, with bracket inclusions to $10^{-29}$. That is a computed object; the record labels it *Candidate, Gate 2 owed*. **HYPOTHESIS-DEBT**, honestly declared, what would have to be shown is that a second $\mathrm{ad}(\mathfrak k)$-non-invariant graded critical point exists on that pair, by construction or by a dimension count of the graded critical set.

**What a consumer may cite today.**

> For a compact symmetric pair $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$ acting irreducibly, $\mathfrak k$ acting on $\mathfrak m$ with a **single** Casimir (i.e. $\mathfrak k$ simple, or its ideals interchanged by a symmetry of the pair), $2q>p$, and $c_{\mathfrak k}\ge0$, $C>0$: **if** the $\mathfrak m$-block relation (R1) holds at the pair's $\mathrm{ad}(\mathfrak k)$-invariant critical point, **then** $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, with $c_{\mathfrak k}$ the adjoint Casimir of $\mathfrak k$ **in the $\mathfrak{so}(n)$-induced normalisation, i.e. the tabulated ratio times the embedding index**.

Everything in bold there is absent from every citable form. And a consumer may cite, unconditionally: **every sphere product is defect-free**; **$\theta=\theta_0(2m)$ at the balanced splits**; **$\theta^2=m(m+1)/((m-1)(m+2))$ on $(\mathfrak{su}(m),\mathfrak{so}(m))$**.

## 10. The discrepancy protocol, three steps for every candidate

### D-1. The pinning formula is undefined on an infinite family inside its own scope, **UPHELD**

1. **Located.** [results.md](../results.md):369: *"An equivariant graded critical point, the Weyl operator of a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, **is pinned by its pair's dimensions**, $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$"*. Repeated at [results.md](../results.md):124 and quoted at [findings/graded-half.md](../findings/graded-half.md):425.
2. **Exhibited.** $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$: $p=200$, $q=100$, $2q-p=0$, while $\theta^2=912/575>3/2$. And this is the $n=25$ member of a Pell family $(n+1)^2-3s^2=1$ giving $n=6,25,96,361,\dots$, every member from $25$ on above the rival maximizer. §3e(ii).
3. **The opposite, argued.** The most charitable reading imports [ATTEMPTS.md](../ATTEMPTS.md):1037's sweep screen ($\mathfrak k$ with a single Casimir, and $2q>p$) as unwritten hypotheses. Under that reading the formula is not false, and the pair is simply out of scope. **But then the "finite check" is a check over a set that excludes an infinite family of above-threshold points**, and the statement a consumer reads still asserts a pinning that does not hold. Either way the defect stands; the charitable reading converts it from a false statement to an omitted hypothesis with the same consequence. **Not withdrawn.**

### D-2. "One table lookup", **UPHELD**

1. **Located.** [results.md](../results.md):369: *"So the value follows from three integers and one table lookup, with no curvature operator built at any stage."*
2. **Exhibited.** $\mathfrak{so}(m)$ takes $c_{\mathfrak k}=m-2$ inside $(\mathfrak{su}(m),\mathfrak{so}(m))$, derived in §3c and matching the record's own catalogue at $\mathfrak{su}(3)$, $\mathfrak{su}(4)$, $\mathfrak{su}(6)$, and $2(m-2)$ inside the balanced sphere pair, matching $S^3\times S^3$, $S^4\times S^4$, $S^6\times S^6$. One algebra, two numbers, ratio the embedding index $2$.
3. **The opposite, argued.** [ATTEMPTS.md](../ATTEMPTS.md):1035 says *"tabulated data, needing only the embedding index"*, so the derivation knew. The charitable reading is that "table lookup" tacitly includes the index. **But the index is a second, non-tabulated input that varies with the embedding and not with the algebra**, and the sentence's whole force is that no per-embedding work is needed. **Not withdrawn.**

### D-3. The $\mathbb{CP}^m$ refutation is short by two members, **UPHELD**

1. **Located.** [findings/graded-half.md](../findings/graded-half.md):429: *"…and fails at $S^3\times S^5$, …, and $\mathbb{CP}^m$ for $m\ge4$."*
2. **Exhibited.** $m=2$: $2q-p=m(m-2)=0$, a pole, at the point that attains $\sqrt{3/2}$. $m=3$: $c_{\mathfrak k}=-7/4<0$, exact, violating the sign screen. §3d.
3. **The opposite, argued.** One could read "$m\ge4$" as listing only the members where the formula returns a *wrong finite value*, with $m=2,3$ excluded on other grounds elsewhere. **But the sentence is a list of the cases the pinning fails at, and it omits the two worst of them**; and no other line of the record records the $m=2$ pole. **Not withdrawn.**

### D-4. The heading, Lemma against Conjecture, **UPHELD**

1. **Located.** [results.md](../results.md):124 *"Lemma L8 (landscape)"* against [results.md](../results.md):367 and [findings/graded-half.md](../findings/graded-half.md):421 *"Conjecture L8"*.
2. **Exhibited.** The same list at :124 contains *"Conjecture L6 (landscape)"* and *"Lemma L7 (landscape)"* four and two lines away, so the file uses the distinction deliberately.
3. **The opposite, argued.** I found no written labelling rule in [CONTRIBUTING.md](../CONTRIBUTING.md) or [.claude/rules/](../.claude/rules/), so one could call this a free convention. **But a file that distinguishes the two words elsewhere and then applies both to one id is inconsistent on its own usage**, and the block is *Candidate, Gate 2 owed* by its own banner. **Not withdrawn.**

### D-5. *"exactly when $p,q\ge5$, which needs $n\ge12$"*, **UPHELD as a GAP**

1. **Located.** [findings/graded-half.md](../findings/graded-half.md):429.
2. **Exhibited.** $S^5\times S^5$ at $n=10$: both blocks $\ge5$, $\theta^2=36/25<3/2$. $S^5\times S^6$ at $n=11$: $\theta^2=40/27<3/2$.
3. **The opposite, argued.** The intended condition is plainly the conjunction *$a,b\ge5$ and $n\ge12$*, which the same sentence's reduction to $n^2-7n-54\ge0$ supplies and which I verified is exact. **Downgraded to GAP**: the content is recoverable, only the connective is wrong, and [Lemma L69](../findings/graded-half.md) carries $n\ge12$ in its own hypotheses so nothing downstream spends it.

### D-6 (candidate, **WITHDRAWN**). "The formula reproduces the Ricci-flat Kähler family"

I first read *"Ricci-flat Kähler family"* as the $\mathbb{CP}^m$ family, which would have made the clause false at every $m$. [ATTEMPTS.md](../ATTEMPTS.md):1029 and :1100 fix it as $(\mathfrak{su}(m),\mathfrak{so}(m))$, and §3b verifies the formula there **exactly for all $m$**. **Withdrawn: the clause is true for the family it names.** Only the *"and the sphere pairs identically"* half is false (C5).

### D-7 (candidate, **WITHDRAWN**). $\ker W\ne0$ as an unstated hypothesis

The two-eigenvalue operator has no kernel by construction, so the ansatz simply cannot reach a point with $\ker W\ne0$; that is a consequence of H4, not an independent omission. Recorded in §5c as an observation rather than a discrepancy. **Withdrawn: it is H4 in another guise.**

## 11. What would break it, and what I did to look

**The object that would falsify the statement as written:** a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ carrying an equivariant graded critical point at which the right-hand side is undefined or returns a value different from $\theta$. **I found one, and then an infinite family of them**: $2q=p$ forces $ab=\binom n2/3$ with $a+b=n$, hence $(n+1)^2-3s^2=1$, hence $n\in\{6,25,96,361,\dots\}$, all with $2q-p=0$ and all from $n=25$ on above $\sqrt{3/2}$.

**How I looked.** By hand, from the record's own dimension formulas, and only within the classical families the block claims. Specifically: I solved $2q=p$ over $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ and reduced it to Pell; I solved $2q=p$ over $\mathfrak u(m)$ and got $m(m-2)=0$, i.e. $\mathbb{CP}^2$; and I inverted the formula for $c_{\mathfrak k}$ at $S^5\times S^7$, $S^3\times S^5$, $\mathbb{CP}^3$ and $\mathbb{CP}^4$ to see which returned tabulable values. **I did not search the $\mathfrak{su}$, $\mathfrak{sp}$ or exceptional supports**, the Casimir data for those is not in [references/](../references/), and the block names them as outstanding. So the exceptional corner is untested here, and a further falsifier may live there.

**The object that would falsify the scope refutation (C10):** a proof that every graded critical point on a symmetric pair is $\mathrm{ad}(\mathfrak k)$-equivariant. The record's own $\mathrm{ad}(\mathfrak p)$-commutant measurement points the other way at five pairs, and the $\theta=1.088948$ witness at $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ is the standing counter-object; I did not attempt to build or refute it, that being computation.

## Verdict

**BROKEN.**

The result has a correct core, the elimination is exact, and its two flagship families check out symbolically for all $m$, which I did by hand. But the statement a consumer cites carries none of the four hypotheses the derivation runs on, and with those hypotheses dropped it is **undefined at $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$ and at infinitely many further sphere pairs above $\sqrt{3/2}$, inside [Lemma L69](../findings/graded-half.md)'s own range**; it says *"one table lookup"* where the record's own catalogue gives one algebra two values; and the Gate-2 correction that would warn a reader lives in a different file from the sentence it corrects. Underneath all of that, (R1) (the relation the whole reduction starts from), has no derivation on file, only agreement at seven points.

**The minimal repairs, named.** Attach H4, H5, H6 and H8 to [results.md](../results.md):369 and :124; carry the balanced-splits restriction into both; correct the $\mathbb{CP}^m$ list to $m\ge2$; settle the heading on *Conjecture*; and either derive (R1) or mark it as the assumption it is.
