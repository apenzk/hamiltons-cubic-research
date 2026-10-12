# Verifier v159, Observation L5, the census of rival critical-point families, as rewritten after Gate 2

I read [BRIEF_L05.md](BRIEF_L05.md) cold and worked from [conventions.md](../findings/conventions.md), the rewritten block at [graded-half.md](../findings/graded-half.md) lines 41–64, its cited sources [ungraded-slack.md](../findings/ungraded-slack.md) and the $\mathbb{HP}^m$ passage 150 lines below it, and the imported paper at [deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md). **No numerical work was done.** Every value below is an exact rational or a closed-form radical, obtained by following the record's own algebra by hand; nothing was screened, swept, sampled or re-run, and in particular the census itself was not re-run. Log: [verify-L05-v159.log](../agent_logs/verify-L05-v159.log).

## Claim table

| # | Claim attacked | Verdict | Reason |
| --- | --- | --- | --- |
| 1 | $\theta<\sqrt{2/(k-1)}$ for any $k$-block sphere product, uniformly in $n$ | **CONFIRMED AS ALGEBRA, $k\le4$ only** | The stated $\lVert W\rVert^2$ identity is equivalent to the cited closed form, but that form is "verified symbolically for $k=2,3,4$"; $k\ge5$ has no argument |
| 2 | The "hence" from $\lVert W\rVert^2$ to $\theta$ in that step | **GAP** | It consumes $\theta=1/(2\lVert W\rVert)$, which the same file records as resting on an Einstein hypothesis "undischarged at $k\ge3$" |
| 3 | The $\lVert W\rVert^2$ identity holds "for any $k$-block sphere product" | **REFUTED AS STATED** | False at $\ker W\ne0$: it reads the ambient $n$, which padding changes while $\lVert W\rVert$ does not |
| 4 | $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$, by proof over all $m$ | **CONFIRMED** | Closed form, derivative and cubic positivity all check by hand; monotone on all real $m>1$ |
| 5 | $S^5\times S^7$ at $\theta^2=264/175$ beats padded $W_{\mathbb{CP}^2}$ | **CONFIRMED** | Exact; reproduced from three mutually independent forms |
| 6 | "an infinite such family exists whenever $p,q\ge5$" | **REFUTED AS STATED** | $p,q\ge5$ is necessary, not sufficient: $(5,5)$ and $(5,6)$ fail, and they are the only two that do |
| 7 | The surviving conclusion, $\theta_0(12)=1.2360331>1.2282392$ | **CONFIRMED**, and it generalises | Exact at $n=12$; the convexity argument on the record extends it to every $n$, odd $n$ included, against $\Theta_n$ |
| 8 | The two admitted-open classes (SRG sweep to $n=200$; simple-isotropy $(n,r)$ list) | **CONFIRMED in the findings file, REFUTED AS STATED in results.md** | [graded-half.md](../findings/graded-half.md) scopes both correctly; [results.md](../results.md) still presents them under a Lemma heading as closed |
| 9 | The canonical statement at [results.md](../results.md) line 318 | **REFUTED** | It still reads "Six further families lose to both named competitors" (the exact sentence Gate 2 refuted) while the findings file reads "Five … four lose … one ties" |
| 10 | The landscape bullet's "margin of $0.109$" | **REFUTED AS STATED** | That is $\mathbb{HP}^2$'s margin against one competitor; the census-wide margin is $0$, since one member ties |
| 11 | "that family also contains the balanced sphere products themselves, and Lemma L23 shows they are its maximum" | **REFUTED AS STATED** | An even-$n$ statement used unrestrictedly; at $n=7$ the cap $n(n-2)/4=35/4$ is not an integer and the balanced split's $r=9$ exceeds it |
| 12 | The imported Deninger–Grundhöfer–Kramer hypotheses | **CONFIRMED where used**, with an unstated restriction | Theorem 5.1 needs precisely two off-diagonal values and the whole paper lives on the diagonal locus; neither restriction is stated by the consumer |

## One-line summary

The rewritten block's mathematics is sound where it is complete, but its one new theorem is proved only for $k\le4$ and its passage from $\lVert W\rVert^2$ to $\theta$ uses a hypothesis the same file marks undischarged at $k\ge3$, and the canonical statement in [results.md](../results.md) was never rewritten at all, so the refuted sentence is still the one a consumer reads.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

> | $P(W)$ | the cubic form $\langle W,Q(W)\rangle$ |
> | $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$ |

> | $\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$, the gap being $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$ from the identity $(n-2)^2(n+1)-n^2(n-3)=4$.* … the target of Problem P is $\Theta_n$.

> | $\Theta_n$ | the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$ …

> | $M(n)$ | **the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … $M(n)>0$ at every $n\ge4$, padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$ …

> **The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** … *Applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$*, and has cost a cycle.

## 1. Hypothesis inventory

### 1a. What the statement itself quantifies over

The Gate 2 pair's finding stands and I add nothing to it: *rival*, *family* and *found so far* carry no definition in the block, in [conventions.md](../findings/conventions.md), or anywhere the block cites. Consequently the census has no population, and no proposition of the form "every $X$ loses" can be extracted from it. The block now concedes this in its own closing line (*"the record of what has been checked and found short"*) which is the correct reading and the only one the text supports.

**There is still no $n$-quantifier.** Every constituent check is bounded: $m\le4$ in the canonical statement's quaternionic entry, $n\le200$ in the graph sweep, $k=2,3,4$ in the multi-block closed form's symbolic verification, $2\le m\le30$ in the $\mathbb{CP}^m$ range. What a consumer may cite is therefore a **finite list of tabulated points plus three genuinely unbounded sub-results**, the $\mathbb{HP}^m$ supremum (all $m$), the multi-block bound (all $n$, $k\le4$), and the two-block convexity maximum (all $n$, all splits). Nothing else in the block is $n$-uniform.

### 1b. Hypotheses of each imported result, and whether the written text uses them

| Import | Its hypotheses | Used by the L5 text? |
| --- | --- | --- |
| The multi-block closed form, [ungraded-slack.md](../findings/ungraded-slack.md) line 29 | $S^{n_1}\times\dots\times S^{n_k}$ with $n=\sum n_a$; each $n_a\ge2$ (the form has a pole at $n_a=1$); "verified symbolically for $k=2,3,4$" | **Used, and its $k$-restriction is dropped.** The L5 text writes "for any $k$-block sphere product" |
| $\theta=1/(2\lVert W\rVert)$, [graded-half.md](../findings/graded-half.md) line 182 | Locally symmetric **and Einstein**; $\lambda=\tfrac12$ asserted "for every compact **irreducible** symmetric space in Petersen–Stanfield's normalisation" | **Used silently.** The word "hence" in the L5 step is exactly this conversion; neither hypothesis is stated there, and a $k$-block product is reducible |
| [Lemma L23](../findings/ungraded-slack.md) | $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ **satisfying $Q(W)=\theta W$**; the cap $r\le n(n-2)/4$; value $\theta_0(n)$ at the cap | **Used, unrestricted in $n$.** The cap is attained only where $n(n-2)/4$ is an integer, i.e. even $n$ |
| [Lemma L9](../findings/graded-half.md) | $\mathbb{HP}^2$ at $n=8$ is a strict local maximum with nonzero defect | **Cited and not load-bearing**, it supports "a genuine peak in its own right", which is not part of the elimination |
| $\sup_m\theta(\mathbb{HP}^m)$, [graded-half.md](../findings/graded-half.md) line 204 | $m\ge2$ integer (the pole at $m=1$ is $\mathbb{HP}^1=S^4$, $W=0$); Petersen–Stanfield §3.5 Wolf-space eigenvalues; the three-block sharp sum with $S_{\mathfrak{mmm}}\ne0$ | **Used, and it is stronger than the consumer's claim**: the canonical statement still says $m\le4$ |
| Deninger–Grundhöfer–Kramer, Theorem 5.1 | $S$ solves (1); off-diagonal entries take **precisely two** values; everything inside the **diagonal locus** | **Used, both restrictions unstated.** DGK's own §6.4 and §7.5 exhibit three- and four-valued diagonal solutions, outside the theorem |

### 1c. A hypothesis stated but never used, and a step using a hypothesis never stated

**Stated but never used.** [Lemma L9](../findings/graded-half.md) is cited in the census entry for the quaternionic family. It is a second-variation statement; the elimination is entirely a comparison of values. Removing the L9 citation changes nothing in the argument. This is benign but it is what the item asks for.

**Used but never stated, three.** (i) The Einstein hypothesis of the $\theta\leftrightarrow\lVert W\rVert$ conversion, §2 below. (ii) $n_a\ge2$ in the multi-block identity: at $n_a=1$ the term $1/(n_a-1)$ diverges, and what excludes $S^1\times S^{n-1}$ is precisely Einstein-ness, not anything the block says. (iii) $n=\sum_a n_a$, §3 below.

## 2. Claim 1 and Claim 2, the multi-block bound

### 2.1 The identity as written is the cited closed form, and I checked the equivalence by hand

The L5 block writes

$$\lVert W\rVert^2=\tfrac{k-1}8+\tfrac18\Big(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\Big),\qquad\text{hence}\qquad\theta<\sqrt{\tfrac2{k-1}}.$$

Its cited source, [ungraded-slack.md](../findings/ungraded-slack.md) line 29, carries a different expression:

$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}}.$$

**The $\lVert W\rVert^2$ form appears nowhere in the cited file**, it is written fresh in the L5 block, undecorated by a derivation. The two are the same identity under $\theta=1/(2\lVert W\rVert)$, which I verified by expanding rather than by evaluation. Writing $D:=(n-1)^2\big[(k-1)+\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big]$,

$$D=(k-1)(n-1)^2+\sum_a\frac{(n-1)^2}{n_a-1}-(n-1),$$

and since $(n-1)^2-(n-n_a)^2=(n_a-1)\big(2n-1-n_a\big)$ the difference against the cited denominator is

$$D-\Big[(k-1)n^2+\sum_a\tfrac{(n-n_a)^2}{n_a-1}\Big]=(k-1)\big[(n-1)^2-n^2\big]+\sum_a(2n-1-n_a)-(n-1)=(k-1)(1-2n)+(2kn-k-n)-(n-1)=0.$$

So the two forms coincide exactly, and $\theta^2=2/\big[(k-1)+\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big]$ is the single underlying statement. It reproduces every value the record attaches to it, exactly and by hand: $(S^3)^4$ gives $2/[3+2-\tfrac1{11}]=\tfrac{11}{27}$, $\theta=0.638285$; $(S^8)^3$ gives $2/[2+\tfrac37-\tfrac1{23}]=\tfrac{161}{192}$; $S^{12}\times S^{12}$ gives $2/[1+\tfrac2{11}-\tfrac1{23}]=\tfrac{253}{144}$; $S^5\times S^7$ gives $2/[1+\tfrac14+\tfrac16-\tfrac1{11}]=\tfrac{264}{175}$; and $n_1=\dots=n_k=n/k$ at $k=2$ gives $\theta_0(n)^2$.

The bound follows in two lines and is correct: every $n_a<n$ for $k\ge2$, so $\sum_a\tfrac1{n_a-1}>\tfrac k{n-1}>\tfrac1{n-1}$, the bracket exceeds $k-1$, and $\theta^2<2/(k-1)$ strictly.

### 2.2 The discrepancy: proved for $k\le4$, stated for all $k$

**1. Locate.** [ungraded-slack.md](../findings/ungraded-slack.md) line 31: *"verified symbolically for $k=2,3,4$ with symbolic block sizes and against the full $Q$ at residual $10^{-16}$."* The L5 block imports the consequence as *"for any $k$-block sphere product"* and *"for every $k\ge3$, **uniformly in $n$**"*.

**2. Exhibit.** The smallest $k$ outside the verified range is $k=5$, e.g. $(S^2)^5$ at $n=10$, or $(S^2,S^2,S^2,S^2,S^{56})$ at $n=64$. For no such partition does the record hold a derivation of the closed form; symbolic verification at three values of $k$ with symbolic $n_a$ establishes the identity for those three $k$ and nothing more. What is missing is precisely a statement of the form "the criticality equations for a $k$-block product reduce to this expression for every $k$".

**3. Argue the opposite.** The most charitable reading is that a symbolic check with **symbolic block sizes** at $k=2,3,4$ exhibits a pattern whose general-$k$ derivation is routine, and that in any case the census only needs $\theta<1$ at $k\ge3$, for which $k=3$ is the worst case and is covered. The first half is exactly the move this loop forbids, a pattern is not a proof, and "for any $k$" is not what was verified. The second half fails on its own terms: the census's entry reads *"multi-block sphere products (3+ factors)"*, which includes every $k\ge5$, and the bound $\sqrt{2/(k-1)}$ is the only instrument offered for them.

**Verdict: HYPOTHESIS-DEBT.** What must be proved: *for every $k\ge5$ and every partition $n=\sum_{a=1}^kn_a$ with $n_a\ge2$, the Weyl operator of the Einstein product $S^{n_1}\times\dots\times S^{n_k}$ satisfies $\theta^2=2\big/\big[(k-1)+\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big]$.* I supply no part of it.

### 2.3 The discrepancy the file already knows about: the "hence" is undischarged at $k\ge3$

**1. Locate.** The word *hence* between the $\lVert W\rVert^2$ identity and $\theta<\sqrt{2/(k-1)}$. $\lVert W\rVert$ alone constrains nothing about $\theta=P(W)/\lVert W\rVert^3$, which is scale-invariant; the step needs $\theta=1/(2\lVert W\rVert)$ at [graded-half.md](../findings/graded-half.md) line 182, whose stated premise is *"$\lambda=\tfrac12$ for every compact **irreducible** symmetric space in Petersen–Stanfield's normalisation"*, resting on [Lemma L46](../findings/problem.md)'s *"$Q(R)=\lambda R$ for locally symmetric **Einstein**"*, and the same file adds, of that lemma's own proof, *"the Einstein hypothesis is not incidental"*.

**2. Exhibit.** The failure is named 300 lines below the L5 block, inside [Lemma L69](../findings/graded-half.md) at line 367:

> **The conversion consumes $\theta=1/(2\lVert W\rVert)$ and [Lemma L48](problem.md)'s decomposition, whose Einstein hypothesis is load-bearing and was dropped in transit**, harmless at $k=2$, where the invariant line is one-dimensional, and **undischarged at $k\ge3$**.

The object at which it bites is any $k\ge3$ product, $(S^8)^3$ at $n=24$ is the record's own tabulated instance. Two things break together there. First, a $k$-block product is **reducible**, while the $\lambda=\tfrac12$ sentence is quantified over irreducible spaces. Second, the reason the conversion is "harmless at $k=2$" is that the $K$-invariant line in $\mathrm{Sym}^2(\Lambda^2)$ is one-dimensional; at $k\ge3$ that count is larger, which is the same fact [Lemma L69](../findings/graded-half.md) records as *"the block's own three displays give different counts, so 'uniform' was the wrong word"*. So the L5 block's single surviving theorem applies, at $k\ge3$ and nowhere else, a conversion its own file marks undischarged at $k\ge3$.

**3. Argue the opposite.** The charitable reading is strong and I record it: the cited closed form in [ungraded-slack.md](../findings/ungraded-slack.md) is stated as $\theta^2$ directly and is said to be verified *"against the full $Q$"*, i.e. against the criticality equation rather than through the $\lVert W\rVert$ conversion. Since I showed in §2.1 that the two forms are the same identity, the **conclusion** at $k=3,4$ does stand on a route that never touches the Einstein premise. What does not stand is the L5 block's own derivation as written: the sentence a consumer reads runs $\lVert W\rVert^2\Rightarrow\theta$, and that arrow is the disputed one.

**Verdict: GAP in the presentation, conclusion intact for $k\le4$.** The repair is one sentence (cite the $\theta^2$ form rather than deriving $\theta$ from $\lVert W\rVert^2$) and I do not write it.

### 2.4 The edge of the range: $k=3$, and the smallest admissible dimension

At $k=3$ the bound reads $\theta<\sqrt{2/2}=1$ exactly, so the boundary of the stated range is where the bound is weakest, and it is attained in the limit: for $(m,m,m)$ with $m\to\infty$, $\theta^2=2/[2+\tfrac3{m-1}-\tfrac1{3m-1}]\to1$ from below. The bound is therefore sharp at $k=3$ and never attained, the strictness is load-bearing.

**The elimination needs more than $\theta<1$, and the block does not say so.** $\theta<1$ eliminates the family only if the competitor exceeds $1$. Against $\Theta_n$: $\theta_0(n)^2>1\iff n^2-6n+4>0\iff n>3+\sqrt5=5.236$. Three blocks of size $\ge2$ force $n\ge6$, so the smallest admissible dimension is $n=6$, where $\theta_0(6)=\sqrt{10}/3=1.054093$ against $(S^2)^3$ at $\theta^2=2/[2+3-\tfrac15]=\tfrac5{12}$, $\theta=0.645497$. At odd $n$ the competitor is $\Theta_n$, smaller: $\Theta_7^2=6/5$, $\Theta_7=1.095445>1$, and $\Theta_9^2=48/35$, $\Theta_9=1.171085>1$. So the elimination does hold at the edge, for every $n$ admitting three blocks, **but that verification is mine and is nowhere on the record**; the block stops at $\theta<1$ and leaves the comparison implicit. Since $n=5$ admits no three-block product with all $n_a\ge2$, no dimension is left uncovered.

## 3. Claim 3, $\ker W\ne0$, the recurring obstruction

**1. Locate.** *"$\lVert W\rVert^2=\tfrac{k-1}8+\tfrac18\big(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big)$ … for any $k$-block sphere product."* The identity reads a symbol $n$ that is never bound. In a sphere product $n$ means $\sum_an_a$; in the surrounding record $n$ means the dimension of the arena $\mathcal W_n$, and those differ exactly when $\ker W\ne0$.

**2. Exhibit.** Take $(S^3)^3$, a genuine three-block product at $n'=9$, and pad it into $\mathbb R^{12}$, a legitimate operation, and the imported paper's own Lemma: DGK §3 (L424–L427), *"a solution in dimension $n$ padded by zeros is a solution in every $m>n$ with the same $\theta$"*. The padded object is a critical point of $\mathcal W_{12}$ with $\ker W\ne0$ and unchanged $\lVert W\rVert$. Its true norm, from the identity at $n=9$, is $\tfrac18\big[2+\tfrac32-\tfrac18\big]=\tfrac{27}{64}=0.421875$. The identity read at the ambient $n=12$ gives $\tfrac18\big[2+\tfrac32-\tfrac1{11}\big]=\tfrac{75}{176}=0.426136$. The two differ, and $\lVert W\rVert$ does not: **the identity is false at any padded product.**

This is not a corner case in this record. [Lemma L69](../findings/graded-half.md)'s own scope note records that padded $W_{\mathbb{CP}^2}$ at $n=12$ *"has $\ker W$ of dimension $63$ out of $66$"*, and padded $W_{\mathbb{CP}^2}$ is one of the two competitors the census measures against.

**3. Argue the opposite.** Charitably, "a $k$-block sphere product in $\mathbb R^n$" carries $n=\sum n_a$ by definition, and no reader would apply the formula at a padded object. That reading rescues the identity but not the **statement**: "$\theta<\sqrt{2/(k-1)}$ for any $k$-block sphere product" is then silent about padded products, which are exactly the objects the census must exclude if the population is "critical points of $\mathcal W_n$" rather than "products in their own dimension". I record for the next reader that the conclusion is in fact untouched, padding preserves $\theta$ (DGK L424–L427), so a padded $k$-block product carries the value it had at $n'=\sum n_a$, which the bound covers, and separately that misapplying the formula at ambient $n>n'$ only *increases* $\lVert W\rVert^2$ and so *decreases* $\theta$, giving no falsifier in either direction.

**Verdict: REFUTED AS STATED, conclusion unaffected.** The identity needs the hypothesis $n=\sum_an_a$ written down; the bound it yields survives padding for an independent reason the block does not give.

## 4. Claim 4, $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$, and whether the proof covers all $m$

The proof exists and it covers all $m$. I followed it rather than checking it at points.

The closed form at [graded-half.md](../findings/graded-half.md) line 202 is $\theta^2(\mathbb{HP}^m)=\dfrac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$. Evaluating by hand: $m=2$ gives $\tfrac{16\cdot7}{9\cdot2\cdot1\cdot5}=\tfrac{112}{90}=\tfrac{56}{45}$; $m=3$ gives $\tfrac{25\cdot11}{9\cdot3\cdot2\cdot7}=\tfrac{275}{378}$; $m=4$ gives $\tfrac{36\cdot15}{9\cdot4\cdot3\cdot9}=\tfrac{540}{972}=\tfrac59$; and the leading behaviour is $4m^3/18m^3=\tfrac29$, so $\theta\to\tfrac{\sqrt2}3$. All four agree with the record's own tabulated values, the last two of them out of the sample that produced the form.

The monotonicity is the part the supremum needs, and it holds on the whole real range, not on a sampled set. The stated derivative is $\frac{d}{dm}\theta^2=-\dfrac{(m+2)(34m^3-12m^2+3m+2)}{9m^2(m-1)^2(2m+1)^2}$, and its sign is governed by the cubic. I reproduced the record's elementary positivity argument and it is correct: for $m\ge\tfrac12$, $34m-12\ge5$, so $m^2(34m-12)\ge5m^2>0$ and $3m+2>0$; for $0<m<\tfrac12$, write the cubic as $34m^3+(2+3m-12m^2)$, whose quadratic part has positive root $\tfrac{3+\sqrt{105}}{24}=0.5519>\tfrac12$ and is therefore positive throughout $(0,\tfrac12)$. So $\theta^2$ is strictly decreasing on $m>1$ and the maximum over the admissible integers $m\ge2$ is at $m=2$.

**The edge of the range, $m\le4$ against a supremum over all $m$.** The canonical statement in [results.md](../results.md) still reads *"quaternionic-Kähler operators on $\mathbb{HP}^m$, $m\leq4$"*. The proof is strictly stronger than what the consumer cites, the reverse of this record's usual failure, but still a mismatch: a reader of the Lemma cannot tell that $m\ge5$ is covered. The pole at $m=1$ is correctly disposed of in the file ($\mathbb{HP}^1=S^4$ is conformally flat, $W=0$), so the range $m\ge2$ is the right one and its lower edge is where the maximum sits.

**No finding on the block-mass premise.** The passage records that a first derivation set $S_{\mathfrak{mmm}}=0$ on the ground that $(\mathfrak{so}(4m),\mathfrak{sp}(1)\oplus\mathfrak{sp}(m))$ is a symmetric pair, that this is false for $m\ge3$, and that the correct value $S_{\mathfrak{mmm}}=\tfrac{12(m-2)(m-1)(m+1)(2m+1)}m$ vanishes at $m=2$ alone, which is exactly why the wrong premise reproduced $\mathbb{HP}^2$ and failed at $\mathbb{HP}^3$. That is the correct diagnosis of a hypothesis invisible where it happens to hold, and it is already written down.

**Verdict: CONFIRMED.** The supremum is a theorem over all $m$, the elimination margin against $\sqrt{3/2}$ is $\sqrt{3/2}-\sqrt{56/45}=0.109198$, and §7 below says why that number should not be quoted as the census's margin.

## 5. Claim 5 and Claim 6, $S^5\times S^7$, and the "whenever $p,q\ge5$" family

### 5.1 The point itself is exact and I reproduced it three ways

$S^5\times S^7$: $\theta^2=2\big/\big[1+\tfrac14+\tfrac16-\tfrac1{11}\big]=2\big/\tfrac{175}{132}=\tfrac{264}{175}=1.5085714>\tfrac32$, so $\theta=1.2282392>\sqrt{3/2}=1.2247449$. The block's partition identity $\tfrac5{32}+\tfrac7{48}-\tfrac3{22}=\tfrac{175}{1056}$ is the same statement in the form $\lVert W\rVert^2=\tfrac18\big[\sum_a\tfrac{n_a}{n_a-1}-\tfrac n{n-1}\big]$, and $\tfrac1{4\cdot175/1056}=\tfrac{1056}{700}=\tfrac{264}{175}$ agrees. The cited source's two-block form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ at $(p,q,n)=(5,7,12)$ gives $\frac{2\cdot11\cdot4\cdot6}{10\cdot35}=\frac{528}{350}=\frac{264}{175}$, a third agreement. **CONFIRMED.**

That the census's only sphere-product entry reads "3+ factors" and so omits two-factor unbalanced products is a plain reading of the text and is correct.

### 5.2 The discrepancy: $p,q\ge5$ is necessary, not sufficient

**1. Locate.** *"and an infinite such family exists whenever $p,q\ge5$."* Read as the sentence's grammar demands (the family of products beating padded $W_{\mathbb{CP}^2}$, on the condition $p,q\ge5$), this asserts $\theta(S^p\times S^q)>\sqrt{3/2}$ for all $p,q\ge5$.

**2. Exhibit.** With $n=p+q$, $\theta^2>\tfrac32\iff\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}<\tfrac13$. Two closed-form counterexamples with $p,q\ge5$:

- $(p,q)=(5,5)$, $n=10$: $\tfrac14+\tfrac14-\tfrac19=\tfrac{7}{18}=0.388889>\tfrac13$, so $\theta^2=\tfrac{2}{1+7/18}=\tfrac{36}{25}=1.44<\tfrac32$. Indeed $\theta=1.2=\theta_0(10)$, and $\theta_0(10)<\sqrt{3/2}$.
- $(p,q)=(5,6)$, $n=11$: $\tfrac14+\tfrac15-\tfrac1{10}=\tfrac{7}{20}=0.35>\tfrac13$, so $\theta^2=\tfrac{2}{1+7/20}=\tfrac{40}{27}=1.481481<\tfrac32$, $\theta=1.217160<1.224745$.

The exceptions are exactly these two. For $p=5$: $\tfrac1{q-1}-\tfrac1{q+4}<\tfrac1{12}\iff\tfrac5{(q-1)(q+4)}<\tfrac1{12}\iff(q-1)(q+4)>60$, which fails at $q=5$ ($36$) and $q=6$ ($50$) and holds from $q=7$ ($66$). For $p\ge6$ the condition holds at $(6,6)$, $\tfrac15+\tfrac15-\tfrac1{11}=\tfrac{34}{110}=0.309091<\tfrac13$, and a fortiori beyond.

The converse direction, which the record states correctly elsewhere ([results.md](../results.md) line 38, *"above $\sqrt{3/2}$ they are two-factor sphere products with both factors $\ge5$"*), does hold: at $p=4$ the expression is $\tfrac13+\big[\tfrac1{q-1}-\tfrac1{q+3}\big]>\tfrac13$ for every $q$, and it is larger still at $p\le3$. So $p,q\ge5$ is a **necessary** condition that the L5 block has written as a **sufficient** one.

**3. Argue the opposite.** The charitable reading is that "an infinite such family exists whenever $p,q\ge5$" asserts only existence (that infinitely many products with $p,q\ge5$ beat $\sqrt{3/2}$) which is true, with $(5,q\ge7)$ alone an infinite family. That reading is available from the word "exists". It is also the reading under which the clause "whenever $p,q\ge5$" does no work at all, since existence needs no such condition attached. A clause that is false under one reading and vacuous under the other should be rewritten either way.

**Verdict: REFUTED AS STATED.** The correct statement is that $p,q\ge5$ is necessary and that the exceptions among $p,q\ge5$ are precisely $(5,5)$ and $(5,6)$.

## 6. Claim 7, the surviving conclusion, at $n=12$ and at every $n$, odd $n$ included

**At $n=12$ it is exact.** $\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{55}{36}=1.527\overline{7}$, so $\theta_0(12)=\tfrac{\sqrt{55}}6=1.2360331$, against $S^5\times S^7$ at $\sqrt{264/175}=1.2282392$. The difference is real and the digits are right. $n=12$ is even, so $\Theta_{12}=\theta_0(12)$ and the comparison is against the target of Problem P as [conventions.md](../findings/conventions.md) fixes it. **CONFIRMED.**

**It generalises, and the argument is on the record.** For fixed $n$ and $k$, maximising $\theta$ means minimising $\sum_a\tfrac1{n_a-1}$, and [ungraded-slack.md](../findings/ungraded-slack.md) line 55 supplies the reason: *"$\theta$ is globally maximised at balanced blocks, by strict convexity of $1/(n_a-1)$."* So every two-factor product at dimension $n$ is at most the most-balanced split's value, with equality only at that split.

**Odd $n$, checked explicitly because the item asks.** At odd $n$ the most-balanced integer split is $\big(\tfrac{n-1}2,\tfrac{n+1}2\big)$ and its value is $\Theta_n$, strictly below $\theta_0(n)$ by the gap [conventions.md](../findings/conventions.md) records, $\theta_0^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}$. The comparison the record needs is against $\Theta_n$, and it holds for the same convexity reason, the competitor at odd $n$ is itself a member of the family being bounded. At $n=11$, for instance, the family's maximum is $(5,6)$ at $\theta^2=\tfrac{40}{27}$, and $\Theta_{11}^2=\tfrac{2\cdot10\cdot8}{12\cdot9}=\tfrac{160}{108}=\tfrac{40}{27}$, the same number, as it must be. **No odd-$n$ failure here.**

**One scoping correction to the word "lose".** The infinite family of §5 contains the balanced products themselves ($S^5\times S^5$ at $n=10$, $S^6\times S^6$ at $n=12$), and those do not lose to the balanced product, they **are** it. The accurate statement is $\le$, with equality exactly at the balanced member. This is the same defect Gate 2 found in the word "lose" for Fox's $r=4$ subalgebra, recurring at a second site in the rewritten text.

## 7. Claims 8–11, scope, the canonical statement, and the margin

### 7.1 The two admitted-open classes are scoped correctly in the findings file

[graded-half.md](../findings/graded-half.md) now states: *"What the downgrade leaves owed: a closed form plus a whole-range bound per structural class. Four of six are discharged; the open two are the strongly-regular-graph solutions, swept only to $n=200$, and the non-Lie-group simple-isotropy members, whose $(n,r)$ list is nowhere on the record."* Both are named as open, both name the reason, and neither is cited as evidence for a positive claim. That is the correct treatment of a bounded check, and I have no finding against it.

The one thing it leaves implicit: the graph sweep is bounded not only in $n$ but in **shape**. DGK Theorem 5.1's correspondence with strongly regular graphs holds only where *"the off-diagonal entries of $S$ assume precisely two different values"*, and the whole paper lives inside the diagonal locus. So the open class is narrower than "graph-derived solutions" suggests, and DGK's own §6.4 (three off-diagonal values) and §7.5 at $q=73$ (four values, $\theta=0$) are diagonal critical points that the census's SRG entry does not reach at all. Neither threatens, the reference notes give $\theta_{\text{record}}\sim\sqrt{2/(m+\ell)}$ and $\sim\sqrt{2/q}$ respectively, but a consumer should not read the SRG entry as covering the diagonal locus.

### 7.2 The canonical statement in results.md is still the refuted text

This is the most consequential finding in the report, and it needs no derivation.

| File | What it says |
| --- | --- |
| [graded-half.md](../findings/graded-half.md) line 69 | *"**Five further families, of which four lose to both named competitors and one ties.**"* |
| [results.md](../results.md) line 318 | *"Six further families lose to both named competitors:"* |

The second is verbatim the sentence Gate 2 refuted, on the two counts Gate 2 named, the count and the comparative. The findings file's own paragraph immediately after the refutation block carries the corrected version; [results.md](../results.md) was not touched. The headings differ in the same way: line 316 of [results.md](../results.md) reads `##### Lemma L5`, while line 41 of the findings file reads `#### Observation L5`, and [INDEX-results.md](../findings/INDEX-results.md) records the downgrade. **A consumer reading the canonical statement reads a refuted sentence under a label the record has withdrawn.** The brief's central question (what the surviving text licenses), has this answer at the top: whatever the findings file licenses, [results.md](../results.md) currently licenses more.

### 7.3 The landscape bullet's margin

**1. Locate.** [results.md](../results.md) line 118: *"The elimination survives, with a margin of $0.109$ rather than $0.388$."*

**2. Exhibit.** $0.109198=\sqrt{3/2}-\sqrt{56/45}$ is $\mathbb{HP}^2$'s margin against **one** of the two named competitors. It is not the census's margin, on two counts. First, the same bullet says *"one family attains $\sqrt{3/2}$ exactly"*, Fox's $r=4$ subalgebra, which [problem.md](../findings/problem.md) item 6 identifies as a single orbit all at $P/\lVert W\rVert^3=\sqrt{3/2}$, so the census-wide margin against padded $W_{\mathbb{CP}^2}$ is exactly $0$. Second, $\mathbb{HP}^2$ lives at $n=8$, where the other competitor is $\theta_0(8)=\sqrt{21}/4=1.1456439$, and the margin there is $1.1456439-1.1155467=0.0300972$, under a third of the quoted figure. The bullet's own two preceding sentences are in tension for the same reason: a family that attains $\sqrt{3/2}$ exactly is not one whose "highest is $\sqrt{56/45}$".

**3. Argue the opposite.** Charitably, "the highest" and "the margin" both range over the families eliminated *on value*, excluding the one that ties, and the comparison is against the fixed threshold $\sqrt{3/2}$ rather than against a dimension-matched competitor. That reading is coherent. It is also the reading under which the number describes one member of one family against one competitor, and so should not stand as the census's margin in a landscape summary, which is where it stands.

**Verdict: REFUTED AS STATED.** The margin against padded $W_{\mathbb{CP}^2}$ is $0$; the margin at the dimension where the highest eliminated point lives is $0.030$.

### 7.4 The Lemma L23 sentence is an even-$n$ statement used unrestrictedly

**1. Locate.** *"that family also contains the balanced sphere products themselves, and Lemma L23 shows they are its maximum."* No $n$-restriction.

**2. Exhibit.** [Lemma L23](../findings/ungraded-slack.md) caps $r=\dim\mathfrak h$ at $n(n-2)/4$, where the value is $\theta_0(n)$. At even $n$ the balanced product's isotropy $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ has $r=2\binom{n/2}2=\tfrac n2\big(\tfrac n2-1\big)=\tfrac{n(n-2)}4$, hitting the cap exactly, and the sentence is right. At odd $n$ it fails twice over. Take $n=7$: the cap is $\tfrac{7\cdot5}4=\tfrac{35}4=8.75$, not an integer, so **no** subalgebra attains it and $\theta_0(7)$ is attained by no member; and the balanced split $S^3\times S^4$ has isotropy $\mathfrak{so}(3)\oplus\mathfrak{so}(4)$ with $r=3+6=9>8.75$, so it is not a member of the family at all, consistent with its value $\Theta_7=\sqrt{6/5}=1.0954$ falling below $\theta_0(7)=\sqrt{60/49}=1.1066$, exactly the gap [conventions.md](../findings/conventions.md) records. The record itself flags the mechanism at [results.md](../results.md) line 134: the cap *"is not a Lie-theoretic dimension bound"* and fails without the eigen-equation, with $\mathfrak g_2\subset\mathfrak{so}(7)$ at $r=14$ against $35/4$ named there.

**3. Argue the opposite.** Charitably, the sentence is about even $n$ because the balanced sphere product is only unambiguously defined there, and [conventions.md](../findings/conventions.md) is explicit that the gloss "the value at the balanced sphere product" for $\theta_0(n)$ holds *"at even $n$ only"*, and that this very gloss *"is what regrew [L0](../findings/problem.md)'s refuted constant"*. That is a defence of the intent and an indictment of the wording: the record has already paid once for leaving this restriction unwritten.

**Verdict: REFUTED AS STATED.** The sentence needs "at even $n$".

## 8. Claim 12, the imported theorem, hypotheses checked at source

I read [notes.md](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) against the object rather than against the prose. The hypotheses of the two results the census leans on:

- **Theorem 5.1** requires $S$ to solve (1) with *"the off-diagonal entries of $S$ assume precisely two different values $x\ne y$"*. The census's non-primitive case is $mK_\ell$, DGK Example 5.2, whose $S$ is two-valued, hypothesis met, and DGK themselves say it *"corresponds to the Weyl curvature tensor of a product of $m$ round spheres of dimension $\ell$"*, which is the census's *"collapses exactly onto the sphere product"*. **Checked, and it holds.**
- **The $\theta$ normalisation.** DGK's scale-invariant $\hat\theta$ is not this record's $\theta$; the notes fix $\theta_{\text{record}}=\sqrt2\,\hat\theta_{\text{DGK}}$ and verify it against Example 5.2 at $m=2$, recovering $\theta_0(n)$. This is precisely the $\sqrt2$ trap [conventions.md](../findings/conventions.md) names, and the reference folder handles it correctly. **No finding.**
- **The unstated restriction.** DGK is a statement about the **diagonal locus** throughout, *"No statement about non-diagonal critical points; everything is inside the coordinate-eigenvector locus"*, in the notes' own summary of what the paper does not do. The census cites it without that word. A consumer could read "strongly-regular-graph-derived solutions" as a claim about all graph-derived critical points; it is a claim about two-valued diagonal ones.

**On the trap the brief names by name** (a cited theorem assuming a unital algebra where $\mathcal W_n$ has no unit), I found no recurrence. DGK assume nothing of the kind; their hypotheses are matrix conditions on $S$ that the record's objects satisfy or visibly fail, and the notes check the one conversion that could have gone wrong.

## 9. A universal claim with no witness, one object per named family

The item asks for a witness from each structured family, so here they are, all in closed form, all against the two named competitors at the dimension where the object lives.

| Family | Witness | $\theta$ | Competitors at that $n$ | Outcome |
| --- | --- | --- | --- | --- |
| Multi-block, $k=4$ | $(S^3)^4$, $n=12$ | $\sqrt{11/27}=0.638285$ | $\sqrt{3/2}$, $\theta_0(12)=1.236033$ | loses to both |
| Fox, $r=4$ | the hyper-Kähler orbit, $n\ge4$ | $\sqrt{3/2}=1.224745$ | $\sqrt{3/2}$, $\theta_0(10)=1.2$ | **ties one, beats the other at $n\le10$** |
| Quaternionic-Kähler | $\mathbb{HP}^2$, $n=8$ | $\sqrt{56/45}=1.115547$ | $\sqrt{3/2}$, $\theta_0(8)=1.145644$ | loses to both, by $0.030$ |
| Quaternionic-Kähler | $\mathbb{HP}^4$, $n=16$ | $\sqrt{5/9}=0.745356$ | $\sqrt{3/2}$, $\theta_0(16)=1.280869$ | loses to both |
| SRG, primitive | Kneser $K(8,2)$, $n=28$ | $\sqrt2\cdot3\sqrt{\tfrac9{1680}}=0.310530$ | $\sqrt{3/2}$, $\theta_0(28)=1.338213$ | loses to both |
| Simple isotropy | $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ | $0.837$ | $\sqrt{3/2}$, $\theta_0(8)=1.145644$ | loses to both |
| Defect-analysis point | $\mathfrak{so}(5)$ spin-$8$, $n=8$ | $0.387$ | $\sqrt{3/2}$, $\theta_0(8)=1.145644$ | loses to both |
| Ricci-flat Kähler on $\mathbb C^m$ | $m=2$ | $\sqrt{3/2}=1.224745$ | $\sqrt{3/2}$, $\theta_0(10)=1.2$ | **is the competitor** |
| Two-factor, omitted | $S^5\times S^7$, $n=12$ | $\sqrt{264/175}=1.228239$ | $\sqrt{3/2}$, $\theta_0(12)=1.236033$ | **beats one, loses the other** |

The Kneser value is read off DGK Example 5.3, $\hat\theta=|5-m|\sqrt{(m+1)/(m(m-1)(m-2)(m-3))}$ at $m=8$, converted by the record's own $\theta_{\text{record}}=\sqrt2\hat\theta$.

**Three rows out of nine do not lose to both.** The census sentence in [results.md](../results.md) remains false on its own enumeration, and it is false at the boundary of the range as well: Fox's $r=4$ orbit at $\sqrt{3/2}$ beats $\theta_0(n)$ for every even $n\le10$, since $\theta_0(n)^2>\tfrac32\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.29$.

## 10. Symbol collisions

Two, both in the census's own sentences and both against [conventions.md](../findings/conventions.md).

**$P$ used where $\theta$ is meant.** The census writes *"the simple-isotropy members … which top out at $P\leq0.837$"* and *"which also threatens nothing ($P=0.387$)"*, then compares those numbers against $\sqrt{3/2}$ and $\theta_0(n)$, which are $\theta$-values. [conventions.md](../findings/conventions.md) fixes $P(W)=\langle W,Q(W)\rangle$ and $\theta=P(W)/\lVert W\rVert^3$; they agree only at $\lVert W\rVert=1$, and the census states no normalisation anywhere. The neighbouring record shows the collision is live rather than pedantic: [fence-posts.md](../findings/fence-posts.md) line 390 tabulates $0.837$ and $1.673=2\times0.837$ side by side for the same object.

**$\theta_0(n)$ read as "the balanced sphere product's value".** §7.4 above. [conventions.md](../findings/conventions.md) marks this exact gloss as the one that *"regrew [L0](../findings/problem.md)'s refuted constant"*, and the census's L23 sentence uses it.

## 11. Withdrawn candidates

Recorded so the next verifier does not spend an adjudication on them.

**11a. "The bound $\theta<\sqrt{2/(k-1)}$ leaves $k\ge3$ products above the target at small $n$."** *Withdrawn at step 2.* I looked for an $n$ at which $\theta<1$ fails to eliminate, i.e. an $n$ with a three-block product and $\Theta_n\le1$. $\theta_0(n)>1$ needs $n>3+\sqrt5=5.236$, and three blocks with every $n_a\ge2$ need $n\ge6$; the two ranges do not overlap. Odd $n$ closes too: $\Theta_7=1.095445$ and $\Theta_9=1.171085$. No witness exists.

**11b. "The $\mathbb{HP}^m$ supremum is stated over integers but proved over reals, so the sup could be attained off-integer."** *Withdrawn at step 1.* The direction runs the safe way: monotonicity on the real interval $m>1$ is strictly stronger than what a supremum over integers $m\ge2$ needs, and the maximum sits at the lower endpoint $m=2$, which is an admissible integer.

**11c. "Padding a $k$-block product produces a counterexample to $\theta<\sqrt{2/(k-1)}$."** *Withdrawn at step 2.* DGK's inflation lemma (L424–L427) preserves $\theta$ exactly, so a padded product carries the value the bound already covers; and misreading the norm identity at the ambient $n$ moves $\theta$ down, not up. The identity is still wrong at a padded object (that finding stands at §3) but it yields no falsifier.

**11d. "The $\mathbb{CP}^m$ range $2\le m\le30$ is a bounded check cited as a family statement."** *Withdrawn at step 3.* The charitable reading is the correct one: [algebra.md](../findings/algebra.md) line 29 carries the closed form $\theta^2=(m+1)(2m-1)/(3m(m-1))$ with its monotonicity in $r$ and its maximum at $r=4$, so the family claim rests on a derivation and the range $2\le m\le30$ is a report of where it was tabulated. The bounded range is a presentation defect, not an evidential one.

## 12. What would falsify the surviving statement, and what I did to look for it

**The object.** A critical point $W\in\mathcal W_n$, at some $n$, whose $\theta$ exceeds $\Theta_n$, and, to bear on this result specifically, one lying in a family the census names but whose bounded check did not reach it. Three concrete shapes:

1. A $k$-block sphere product with $k\ge5$ violating $\theta^2=2/[(k-1)+\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}]$, which would break the one unbounded theorem the block now carries, since that form is verified only at $k=2,3,4$.
2. A strongly regular graph on $n>200$ vertices whose $\hat\theta=|\lambda-\mu+1|\sqrt{(n-1)/(nrr^c)}$ satisfies $\sqrt2\,\hat\theta>\Theta_n$, the sweep's stated boundary.
3. A non-Lie-group simple-isotropy pair whose $(n,r)$ the record has never listed, with $\tfrac2n\sqrt{rN/(N-r)}>\Theta_n$.

**What I did.** For (1) I derived the closed form from the block's own $\lVert W\rVert^2$ identity, confirmed it reproduces every recorded multi-block value exactly, and confirmed the bound $\theta^2<2/(k-1)$ follows from it in two lines, so no falsifier can exist *given the form*, and the exposure is entirely in the form's own $k\le4$ provenance. For (2) I read DGK at source and took its largest closed-form primitive family, the Kneser graphs, whose $\hat\theta\sim1/\sqrt{2n}$ against $\Theta_n\to\sqrt2$; the asymptotics run the wrong way for a falsifier, but the notes' summary *"every primitive example has $\hat\theta\to0$"* ranges over DGK's examples, not over all strongly regular graphs, so this shape is genuinely open. For (3) I searched the record for the $(n,r)$ list and confirmed the block's own admission that it is nowhere; with no list there is nothing to test, and I constructed no members, that being the census the rules forbid me to re-run.

**I searched for a two-factor falsifier and found the near miss instead.** Solving $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}<\tfrac13$ in closed form gave §5.2's exact exception set $\{(5,5),(5,6)\}$ and, in the other direction, confirmed by convexity that no two-factor product at any $n$ (odd $n$ included), exceeds $\Theta_n$. The census's true exposure is not there.

## Verdict

**GAP.**

What the surviving text licenses: the $\mathbb{HP}^m$ supremum over all $m$; the multi-block bound $\theta<\sqrt{2/(k-1)}$ for $k\le4$; $S^5\times S^7$ at $\theta^2=264/175$ exactly, and that it exceeds $\sqrt{3/2}$ while falling below $\theta_0(12)$; that no two-factor sphere product at any $n$ exceeds $\Theta_n$; and a record of families examined and found short.

What it does not license: the multi-block bound at $k\ge5$; the step from $\lVert W\rVert^2$ to $\theta$ as written, which uses a hypothesis the same file marks undischarged at exactly the $k$ in question; "whenever $p,q\ge5$" as a sufficient condition; the L23 sentence at odd $n$; the $0.109$ margin as the census's; and (the item a consumer will actually hit first), anything at all from [results.md](../results.md) line 318, which still carries the refuted sentence under a withdrawn label.

**HYPOTHESIS-DEBT, stated exactly.** *For every $k\ge5$ and every partition $n=\sum_{a=1}^kn_a$ with $n_a\ge2$, the Weyl operator of the Einstein product $S^{n_1}\times\dots\times S^{n_k}$ satisfies $\theta^2=2\big/\big[(k-1)+\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big]$*, or, failing that, any $n$-uniform bound on $\theta$ for $k\ge5$ products. Until one exists, "multi-block sphere products (3+ factors)" is eliminated for $k\in\{3,4\}$ and open beyond.
