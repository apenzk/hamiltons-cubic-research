# Verifier v160, Observation L5, the census of rival critical-point families, as rewritten after Gate 2

Cold read of [BRIEF_L05.md](BRIEF_L05.md), worked from [conventions.md](../findings/conventions.md) and the definitions the blocks themselves quote. **No numerical work was done.** Every value below is exact rational or exact surd arithmetic carried by hand on objects named in the record; the only decimals appearing are the record's own printed figures, quoted so the comparison can be made against them. No script, no Sage, no sweep, no census re-run, which matters here, since the result under review *is* a census. Log: [agent_logs/verify-L05-v160.log](../agent_logs/verify-L05-v160.log).

## The claim table

| # | Claim attacked | Verdict | Reason |
| --- | --- | --- | --- |
| 1 | $\theta<\sqrt{2/(k-1)}$ for any $k$-block sphere product, uniformly in $n$ | **CONFIRMED AS ALGEBRA** | the implication is one line from [ungraded-slack.md:29](../findings/ungraded-slack.md)'s closed form and holds for every $k$ and every $n$, but that closed form is "verified symbolically for $k=2,3,4$", so the premise is unproved from $k=5$ up |
| 2 | The route the block takes to it, the $\lVert W\rVert^2$ identity, then "hence" | **CONFIRMED AS ALGEBRA** | the identity is exactly equivalent to the closed form, but only *given* $\theta=1/(2\lVert W\rVert)$, an import the block never names and whose stated hypothesis is *irreducible*; $n=\sum_an_a$ is never stated either |
| 3 | $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$, "by proof rather than by the two points tabulated" | **CONFIRMED** | the printed derivative is reproduced term for term by hand; its cubic is positive on all $m>0$; sup attained at $m=2$ over the whole series |
| 4 | That this closes "the quaternionic-Kähler operators" | **CONFIRMED AS ALGEBRA** | proved for the $\mathbb{HP}^m$ series only; the other Wolf spaces are quaternionic-Kähler and are not covered |
| 5 | $S^5\times S^7$ at $\theta^2=264/175>3/2$, beating padded $W_{\mathbb{CP}^2}$ | **CONFIRMED** | $264\cdot2-3\cdot175=3>0$; the block's own partition identity decodes and checks |
| 6 | "an infinite such family exists whenever $p,q\ge5$" | **REFUTED AS STATED** | false at $(5,5)$, $\theta=6/5$ exactly, and at $(5,6)$, $\theta^2=40/27$; the existential survives, the "whenever" does not |
| 7 | The surviving conclusion at $n=12$: $\theta_0(12)>\theta(S^5\times S^7)$ | **CONFIRMED** | $55/36>264/175$ by $9625>9504$ |
| 8 | That it holds at every $n$ the record needs, odd $n$ included | **CONFIRMED, and the block does not carry it** | the max over two-factor splits at fixed $n$ *is* $\Theta_n$, in both parities, by convexity of $x\mapsto1/(x-1)$ |
| 9 | "the simple-isotropy members of Lemma L4's family, which top out at $P\leq0.837$" | **REFUTED** | $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$ gives $\theta=\tfrac34\sqrt{10/7}=\sqrt{45/56}=0.896421$; on the record in the very file that owns L4 |
| 10 | That the multi-block families lose to the balanced product at every admissible $n$ | **CONFIRMED at $k\le4$, and the block does not carry it** | $k\ge3$ forces $n\ge6$, and $\min_{n\ge6}\Theta_n=\Theta_6=\sqrt{10/9}=1.054093>1$ |
| 11 | "the open two are the strongly-regular-graph solutions, swept only to $n=200$" | **REFUTED AS STALE** | [L144](../findings/diagonal-half.md) proves $\theta<\tfrac12$ for **every** primitive SRG at **every** $n$, sharp supremum $\tfrac14$, and the imprimitive half is the balanced product. The open classes are one, not two |
| 12 | The non-Lie-group simple-isotropy class, scoped as open | **CONFIRMED AS SCOPED** | but its own recorded witness is the one that refutes row 9 |
| 13 | The canonical statement in [results.md](../results.md) | **REFUTED AS STATED** | it still carries the refuted text verbatim, "Lemma L5", "Six further families lose to both named competitors", "$P\leq0.837$", "$m\leq4$", none of the 2026-09-04 rewrite reached it |
| 14 | The landscape line, [results.md:118](../results.md) | **REFUTED AS STATED** | "Six families eliminated on value" and "one family attains $\sqrt{3/2}$ exactly" cannot both hold, and the stated margin $0.109$ is the margin of a strict subset |
| 15 | "there is no $n$-quantifier though every constituent check is bounded" | **PARTLY DISCHARGED** | three constituents are now uniform in $n$ (multi-block at $k\le4$, $\mathbb{HP}^m$, SRG); one is not, and the statement still carries no quantifier |

## The one-line summary

The surviving comparison holds at every $n$ including odd, but the block's ceiling clause is refuted by $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$ at $\sqrt{45/56}=0.896421$, its multi-block theorem rests on a closed form verified only at $k\le4$ while quantifying over "3+ factors", its "whenever $p,q\ge5$" clause is false at two closed-form points, its open-class paragraph is stale on the half already closed at every $n$, and none of the 2026-09-04 rewrite reached [results.md](../results.md), where the fully refuted text still stands as **Lemma** L5.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$ …* … the target of Problem P is $\Theta_n$."
- $\Theta_n$: "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $M(n)$: "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$ … Distinct from $\Theta_n$, which is the *diagonal* maximum".
- Padding: "**Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this."
- $S(W)$: "the gradedness slack. **Read [W4](../findings/INDEX-traps.md) before using it**: the screen is vacuous when $\ker W\ne0$".
- "**'Critical point' is $Q(W)=\theta W$**, the first-order condition on $\{\lVert W\rVert=1\}$."

## 1. The hypothesis inventory

**What the statement quantifies over.** Nothing that is defined. The block's own retained refutation says it: "*rival*, *family* and *found so far* have no definitions here, and there is no $n$-quantifier though every constituent check is bounded." The rewrite of 2026-09-04 did not add definitions for any of the three; it added two theorems and a scoping paragraph. So the population is still undefined, and the surviving sentence at [graded-half.md:69](../findings/graded-half.md) is a list of five named classes, not a quantified claim.

**Every hypothesis of every imported result, and whether the written text uses it.**

| import | its hypotheses | used by the written text? |
| --- | --- | --- |
| The multi-block $\lVert W\rVert^2$ identity, [graded-half.md:59](../findings/graded-half.md) | the object is an unpadded $k$-block round-sphere product, $n=\sum_an_a$, every $n_a\ge2$, and (from its source), $k\le4$ | **used, none stated.** $n$ is a free symbol in the displayed formula |
| $\theta=1/(2\lVert W\rVert)$, [graded-half.md:180–182](../findings/graded-half.md) | via [L46](../findings/problem.md): locally symmetric, **Einstein**, $\lambda\ne0$; then $\lambda=\tfrac12$ "for every compact **irreducible** symmetric space in Petersen–Stanfield's normalisation" | **used and never named.** It is the whole of the word "hence" at line 59, and a sphere product with $k\ge2$ factors is *reducible* |
| [L23](../findings/ungraded-slack.md), the subalgebra family | $\mathfrak h\subseteq\mathfrak{so}(n)$ a subalgebra, $0<r<N$, **and $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ assumed**; $W_{\mathfrak h}$ the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ | **cited, and its own correction is not carried.** L23 caps the family at $\theta_0(n)$; the ceiling the census attaches to the simple-isotropy members is refuted inside L4's block |
| [L9](../findings/graded-half.md:221) | $n=8$, $\mathbb{HP}^2=\tau(S^3\times S^5)$, [L27](../findings/nondegeneracy.md) at $(p,q)=(3,5)$, [L24](../findings/second-order.md)'s Hessian | **cited as a parenthesis only**, "remaining a genuine peak in its own right (Lemma L9)". Nothing in the elimination rests on it |
| The $\mathbb{HP}^m$ supremum | the Petersen–Stanfield §3.5 Wolf eigenvalues, the project's Weyl projection, the three-block sharp sum, and $m\ge2$ (the block masses' factorisation "needs that range") | **used, and the $m\ge2$ range is stated where the masses are derived** |
| Deninger–Grundhöfer–Kramer, Theorem 5.1 | $S$ solves (1) with off-diagonal entries taking **precisely two** values; the correspondence is with $\mathrm{srg}(n,r,\lambda,\mu)$ | **checked at source in the record's own notes**, including the normalisation conversion $\theta_{\text{record}}=\sqrt2\,\hat\theta_{\text{DGK}}$. This is the one import whose hypotheses the record does check against the object |

**Which of these the written text actually uses.** Two of the six carry the surviving load: the multi-block identity (with its unnamed bridge) and the $\mathbb{HP}^m$ supremum. L9 is decorative. L23 is cited for a conclusion whose companion correction the block does not carry. DGK is cited for a class the block itself marks open.

## 2. The multi-block bound, CONFIRMED AS ALGEBRA, by a shorter route than the block takes, on a premise proved only to $k=4$

**The claim.** [graded-half.md:59–63](../findings/graded-half.md): "The multi-block bound reads $\lVert W\rVert^2=\tfrac{k-1}8+\tfrac18\big(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big)$, hence $\theta<\sqrt{\tfrac2{k-1}}$ for any $k$-block sphere product, so $\theta<1$ for every $k\ge3$, **uniformly in $n$**".

**It is a theorem, and the record's own closed form gives it in one line without the bridge.** [ungraded-slack.md:29](../findings/ungraded-slack.md) carries

$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}} .$$

Every summand $(n-n_a)^2/(n_a-1)$ is strictly positive for $k\ge2$ and $n_a\ge2$, and $(n-1)^2<n^2$. Hence

$$\theta^2\ <\ \frac{2(n-1)^2}{(k-1)n^2}\ <\ \frac2{k-1},$$

strict twice, for every $n$. At $k=3$ this reads $\theta<1$, and $\sqrt{2/(k-1)}$ decreases from there. **Uniform in $n$: confirmed.** The consequence is also drawn at the source, [ungraded-slack.md:31](../findings/ungraded-slack.md): "$\theta^2<2/(k-1)$ strictly, so $k\ge3$ forces $\theta<1$ for every partition and every $n$".

### 2-i. The premise is proved only to $k=4$, and the census entry reads "3+ factors"

**Locate.** The sentence immediately under the closed form, [ungraded-slack.md:31](../findings/ungraded-slack.md): "**verified symbolically for $k=2,3,4$** with symbolic block sizes and against the full $Q$ at residual $10^{-16}$."

**Exhibit.** The block sizes are symbolic; the *number of blocks* is not. So $S^{n_1}\times\dots\times S^{n_5}$ (the smallest instance being $(S^2)^5$ at $n=10$), has no proof of the closed form on file, and the L5 clause "for any $k$-block sphere product", against a census entry that reads "multi-block sphere products (**3+ factors**)", quantifies over exactly that unproved range. My derivation above is an implication and inherits the premise's range: valid for every $k$ *given* the closed form, established for $k\le4$.

**Argue the opposite.** A symbolic verification at $k=2,3,4$ with free $n_a$ is strong evidence that the pattern is uniform in $k$, and the formula's structure (one term per block plus a $(k-1)n^2$), reads as manifestly $k$-uniform. Also, the *conclusion* $\theta<1$ for $k\ge3$ can be reached for $k\ge5$ by coarsening: merging blocks of a $k$-block product does not produce a member of the same family, so that route is not available without an argument the record does not carry, and **I do not supply one**.

**Reported as: the load-bearing hypothesis debt of the surviving theorem.** What is owed is one derivation of the closed form for general $k$, or one qualifier reading "$k\le4$" on the L5 clause. *This is the same finding [v159](VERIFY_v159.md) recorded; I reached it independently after first writing the row as unconditional, and record the correction.*

**The two identities are the same identity.** Write $D=\sum_a\frac1{n_a-1}-\frac1{n-1}$. Using $(n-n_a)^2=(n-1)^2-2(n-1)(n_a-1)+(n_a-1)^2$ and $\sum_a(n_a-1)=n-k$,

$$\sum_a\frac{(n-n_a)^2}{n_a-1}=(n-1)^2\sum_a\frac1{n_a-1}-2k(n-1)+(n-k),$$

so $(n-1)^2\big[(k-1)+D\big]-\big[(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}\big]=(k-1)\big[(n-1)^2-n^2\big]-(n-1)+2k(n-1)-n+k=0$ identically. So the block's $\lVert W\rVert^2$ formula is *exactly* the statement $\theta^2=1/(4\lVert W\rVert^2)$ applied to L23's closed form, nothing more and nothing less.

**Screened against the block's own two anchors.** $S^5\times S^7$: $\lVert W\rVert^2=\tfrac18+\tfrac18\big(\tfrac14+\tfrac16-\tfrac1{11}\big)=\tfrac18+\tfrac{43}{1056}=\tfrac{175}{1056}$, giving $\theta^2=\tfrac{1056}{700}=\tfrac{264}{175}$, i.e. $1.228239$. $(S^3)^4$: $\tfrac38+\tfrac18\big(2-\tfrac1{11}\big)=\tfrac{27}{44}$, giving $\theta^2=\tfrac{11}{27}$, i.e. $0.638285$. Both reproduce the block's printed figures to all digits shown. *Reported as a screen.*

### 2a. The hypothesis debt under the word "hence"

**Step, quoted.** "The multi-block bound reads $\lVert W\rVert^2=\dots$, hence $\theta<\sqrt{2/(k-1)}$."

An identity for $\lVert W\rVert^2$ implies nothing about $\theta$ on its own. The implication is $\theta=1/(2\lVert W\rVert)$, which is [L46](../findings/problem.md) plus the sentence at [graded-half.md:180](../findings/graded-half.md): "*Since $\lambda=\tfrac12$ for every compact **irreducible** symmetric space in Petersen–Stanfield's normalisation*". A product of $k\ge2$ round spheres is a reducible symmetric space, so the object the bridge is applied to fails the hypothesis under which the bridge is stated. **Neither the bridge nor the mismatch appears anywhere in the L5 block.**

*Argue the opposite.* L46 itself asks only for locally symmetric **Einstein** with $\lambda\ne0$, which a suitably scaled product of round spheres satisfies; irreducibility enters only in the normalisation clause $\lambda=\tfrac12$, and my identity above shows the two record formulas agree exactly under $\lambda=\tfrac12$ at every partition, so the normalisation does extend. So the *value* is right. What fails is the writing: a consumer reading the block cannot get from its premise to its conclusion, and the route through [ungraded-slack.md:29](../findings/ungraded-slack.md) needs no bridge at all.

**Reported as: hypothesis debt, not a defect.** What is owed is one clause naming $\theta=1/(2\lVert W\rVert)$ and the range over which $\lambda=\tfrac12$ is being asserted.

### 2b. $\ker W\ne0$, the padded object, and what the statement says at one

**The formula's $n$ is a free symbol, and the record has already paid for this in the sibling block.** [ungraded-slack.md](../findings/ungraded-slack.md), inside L4: "**Reading the closed form at the padded object is an error**: $(n,r)=(12,8)$ returns $\sqrt{22/87}=0.502866$ against the true $0.836660$." The L5 formula has the identical exposure and states no hypothesis against it.

**Exhibited.** Pad $S^5\times S^7$ into $\mathbb R^{14}$; $\theta$ is unchanged at $\sqrt{264/175}=1.2282392$ by the padding convention, and $\ker W\ne0$. Read the block's formula at that object with $n=14$ and blocks $(5,7)$:

$$\lVert W\rVert^2=\tfrac18+\tfrac18\Big(\tfrac14+\tfrac16-\tfrac1{13}\Big)=\tfrac18+\tfrac{53}{1248}=\tfrac{209}{1248},\qquad \theta^2=\tfrac{1248}{836}=\tfrac{312}{209}=1.4928\ldots$$

giving $\theta=1.22181$, **below** $\sqrt{3/2}=1.2247449$. The true value is above it. So the mis-read does not merely shift a digit: it reverses the block's own headline finding, the one the Gate 2 refutation was written to record.

*Argue the opposite.* "for any $k$-block sphere product" arguably fixes $n=\sum_an_a$ by naming the object, and a padded product is not a $k$-block sphere product. Under that reading the formula is fine and the exhibit is a misuse rather than an error.

**Reported as: hypothesis debt.** The charitable reading holds, so this is not a refutation; but the sibling block states the hypothesis and this one does not, and the exposure is the record's own documented trap.

### 2c. The smallest admissible dimension, and the comparison the block does not make

The block's conclusion is $\theta<1$ for $k\ge3$. **$\theta<1$ is not by itself a loss to the balanced product**: $\Theta_4=0.866$ and $\Theta_5=\sqrt{16/18}=0.9428$ are both below $1$. What rescues it is that $k\ge3$ with every $n_a\ge2$ forces $n\ge6$, and

$$\Theta_6^2=\tfrac{2\cdot5\cdot4}{36}=\tfrac{10}9,\qquad \Theta_6=1.054093>1,$$

with $\theta_0(n)^2=2(1-\tfrac1n)(1-\tfrac2n)$ increasing in $n$ and $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ increasing at odd $n$ ($\Theta_7^2=\tfrac{48}{40}$, $\Theta_9^2=\tfrac{96}{70}$), so $\min_{n\ge6}\Theta_n=\Theta_6$. **Every $k$-block product with $3\le k\le4$ therefore loses to $\Theta_n$ at its own $n$, at every admissible $n$**, and the same follows at every $k\ge5$ the moment the closed form is proved there (§2-i). Smallest case, in closed form: $(S^2)^3$ at $n=6$, $\lVert W\rVert^2=\tfrac14+\tfrac18\cdot\tfrac{14}5=\tfrac35$, $\theta^2=\tfrac5{12}$, $\theta=0.645497$ against $\Theta_6=1.054093$.

**The block carries the first half and not the second.** It proves $\theta<1$ and leaves the reader to establish $\Theta_n>1$ over the admissible range. Verified here; recorded as owed writing, not as a defect.

## 3. $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$, CONFIRMED, proof present and covering every $m$

**The closed form**, [graded-half.md:200](../findings/graded-half.md): $\theta^2(\mathbb{HP}^m)=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$. Anchors, exact: $m=2$ gives $\frac{16\cdot7}{9\cdot2\cdot1\cdot5}=\frac{56}{45}$; $m=3$ gives $\frac{25\cdot11}{9\cdot3\cdot2\cdot7}=\frac{275}{378}$, the tabulated $\mathbb{HP}^3$; $m=4$ gives $\frac{36\cdot15}{9\cdot4\cdot3\cdot9}=\frac59$, the file's out-of-sample check; and the leading behaviour $\frac{4m^3}{18m^3}=\frac29$ is the stated limit $\theta\to\frac{\sqrt2}3$.

**The derivative, recomputed by hand.** With $N=(m+2)^2(4m-1)$, $D=9m(m-1)(2m+1)$, factor $N'=6(2m+1)(m+2)$ and $D'=9(6m^2-2m-1)$. Then

$$N'D-ND'=9(m+2)\Big[6m(m-1)(2m+1)^2-(m+2)(4m-1)(6m^2-2m-1)\Big].$$

The first bracket term expands to $24m^4-18m^2-6m$; the second, via $(m+2)(4m-1)=4m^2+7m-2$, to $24m^4+34m^3-30m^2-3m+2$. Their difference is $-(34m^3-12m^2+3m+2)$, so

$$\frac{d}{dm}\theta^2=-\frac{(m+2)\,(34m^3-12m^2+3m+2)}{9m^2(m-1)^2(2m+1)^2},$$

**term for term the expression the record prints.** Positivity of the cubic on $m>0$, by the record's own two-case argument: for $m\ge\tfrac12$, $34m-12\ge5$ so $m^2(34m-12)\ge5m^2>0$ and $3m+2>0$; for $0<m<\tfrac12$, the quadratic $2+3m-12m^2$ has positive root $\tfrac{3+\sqrt{105}}{24}=0.5520>\tfrac12$, so it is positive throughout, and $34m^3>0$. Hence $\theta^2$ is strictly decreasing on $m>1$, and

$$\sup_{m\ge2}\theta(\mathbb{HP}^m)=\theta(\mathbb{HP}^2)=\sqrt{56/45}=1.115546702<\sqrt{3/2}=1.224744871 .$$

**Covers all $m$: yes.** The domain is $m\ge2$; $m=1$ is $\mathbb{HP}^1=S^4$ with $W=0$, excluded because $\theta$ is undefined there, which the block states. So the census's "$m\leq4$" is superseded by a supremum over the whole series, **which is exactly what results.md still does not say** (§7 below).

**Cross-check of the value by the second route.** The quadratic reformulation gives $\lVert W\rVert^2_{\mathbb{HP}^2}=\tfrac{45}{224}$ ([graded-half.md:114](../findings/graded-half.md)), and $1/(4\cdot\tfrac{45}{224})=\tfrac{224}{180}=\tfrac{56}{45}$. Two record routes, one value.

### 3a. What "the quaternionic-Kähler operators" covers, CONFIRMED AS ALGEBRA, narrower than the words

The proof is for the series $\mathbb{HP}^m$. The Wolf spaces are the quaternionic-Kähler symmetric spaces, and [graded-half.md:198](../findings/graded-half.md) says the Petersen–Stanfield input is available "of every Wolf space of dimension $4n$", but only $\mathbb{HP}^m$ is carried through. [graded-half.md:486](../findings/graded-half.md) confirms the record holds closed forms for the two $\mathbb{HP}$ values and none for the complex-Grassmannian ones. So a consumer may cite *the $\mathbb{HP}^m$ family, closed for all $m$*; a consumer may not cite *the quaternionic-Kähler family*, which is what [results.md:118](../results.md) and [INDEX-results.md:20](../findings/INDEX-results.md) both write. **A claim proved on a subfamily and used in general, real, minor, and fixable by four words.**

## 4. $S^5\times S^7$ and the "$p,q\ge5$" clause

### 4a. The witness, CONFIRMED exactly

$\theta^2(S^5\times S^7)=\tfrac{264}{175}$, and $264\cdot2-3\cdot175=528-525=3>0$, so $\theta^2>\tfrac32$ strictly, by $\tfrac3{350}$. The block's partition identity $\tfrac5{32}+\tfrac7{48}-\tfrac3{22}=\tfrac{175}{1056}$ decodes as $\lVert W\rVert^2=\sum_a\frac{n_a}{8(n_a-1)}-\frac n{8(n-1)}$, since $\frac5{8\cdot4}=\frac5{32}$, $\frac7{8\cdot6}=\frac7{48}$, $\frac{12}{8\cdot11}=\frac3{22}$, which is the block's own displayed formula regrouped, and $165+154-144=175$ over $1056$. **So the "two exact-rational routes" are the same identity written twice**, not two independent routes; the value is nonetheless right, and it is confirmed independently by [ungraded-slack.md:29](../findings/ungraded-slack.md)'s form, $\frac{2\cdot121}{144+\frac{49}4+\frac{25}6}=\frac{242\cdot12}{1925}=\frac{264}{175}$.

### 4b. "an infinite such family exists whenever $p,q\ge5$", REFUTED AS STATED

**1. Locate.** [graded-half.md:49](../findings/graded-half.md), inside the retained Gate 2 quotation: "$S^5\times S^7$ … **it beats padded $W_{\mathbb{CP}^2}$**, and an infinite such family exists whenever $p,q\ge5$."

**2. Exhibit, in closed form.** For $k=2$ the criterion is $\theta^2>\tfrac32\iff D<\tfrac13$ with $D=\frac1{p-1}+\frac1{q-1}-\frac1{p+q-1}$.

| $(p,q)$ | $D$ | $\theta^2$ | against $3/2$ |
| --- | --- | --- | --- |
| $(5,5)$, $n=10$ | $\tfrac14+\tfrac14-\tfrac19=\tfrac7{18}$ | $\tfrac2{1+7/18}=\tfrac{36}{25}$ | $\theta=\tfrac65=1.2<1.224745$, **fails** |
| $(5,6)$, $n=11$ | $\tfrac14+\tfrac15-\tfrac1{10}=\tfrac7{20}$ | $\tfrac2{1+7/20}=\tfrac{40}{27}$ | $\theta=1.217161<1.224745$, **fails** |
| $(5,7)$, $n=12$ | $\tfrac{43}{132}$ | $\tfrac{264}{175}$ | **holds** |

$\tfrac7{18}$ and $\tfrac7{20}$ both exceed $\tfrac13$, so both fail; and $(5,5)$ gives $\theta=6/5$ *exactly*, which is $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=\sqrt{1.44}$, and $(5,6)$ gives $\theta^2=\tfrac{40}{27}$, which is $\Theta_{11}^2=\tfrac{2\cdot10\cdot8}{12\cdot9}$, both are the *balanced* splits of their dimensions, so the failure is not an accident of an unbalanced choice: at $n=10$ and $n=11$ **no** two-factor sphere product beats $\sqrt{3/2}$, because the maximum over splits is $\Theta_n$ and $\Theta_{11}<\sqrt{3/2}<\Theta_{12}$.

**3. Argue the opposite.** Read as a bare existential ("an infinite such family exists"), the claim is true, and provable: $\partial D/\partial p=-\frac1{(p-1)^2}+\frac1{(n-1)^2}<0$, so $D$ is decreasing in each of $p,q$, and its maximum over $p,q\ge6$ is at $(6,6)$, where $D=\tfrac15+\tfrac15-\tfrac1{11}=\tfrac{34}{110}=0.30909<\tfrac13$. So every $(p,q)$ with $p,q\ge6$ beats $\sqrt{3/2}$, an infinite family. The failing region is exactly $\{(5,5),(5,6)\}$ up to order, since $p=5$ needs $\frac1{q-1}-\frac1{q+4}<\frac1{12}$, i.e. $(q-1)(q+4)>60$, i.e. $q\ge7$.

**Verdict: REFUTED AS STATED, existential survives.** The correct threshold is $p,q\ge6$, together with $p=5,q\ge7$. **This clause is inside the Gate 2 quotation block**, so a reader takes it as an adjudicated finding.

### 4c. The surviving conclusion at $n=12$, CONFIRMED exactly

$\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{55}{36}$ against $\tfrac{264}{175}$: $55\cdot175=9625>9504=264\cdot36$. So $\theta_0(12)>\theta(S^5\times S^7)$, strictly, and $n=12$ is even so $\theta_0(12)=\Theta_{12}$ and the citation is legitimate. The block's decimals $1.2360331$ and $1.2282392$ are correct.

### 4d. Does it hold at every $n$, odd $n$ included?, CONFIRMED, by an argument the block does not carry

At fixed $n$, $\theta^2=2/(1+D)$ is maximised where $\sum_a\frac1{n_a-1}$ is minimised, which by strict convexity of $x\mapsto\frac1{x-1}$ is the most balanced split. Evaluating there:

- **$n$ even**, $p=q=\tfrac n2$: $1+D=\frac{(n-2)(n-1)+4(n-1)-(n-2)}{(n-2)(n-1)}=\frac{n^2}{(n-2)(n-1)}$, so $\theta^2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$.
- **$n$ odd**, $p=\tfrac{n-1}2$, $q=\tfrac{n+1}2$: $D=\frac2{n-3}+\frac1{n-1}=\frac{3n-5}{(n-3)(n-1)}$, so $1+D=\frac{(n-2)(n+1)}{(n-3)(n-1)}$ and $\theta^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\Theta_n^2$, **the conventions file's odd formula exactly**.

**So the maximum of the two-factor family at fixed $n$ *is* $\Theta_n$, in both parities.** Every unbalanced two-factor product is strictly below $\Theta_n$ at its own $n$, at every $n$, and the odd case (where $\Theta_n<\theta_0(n)$), is not an exception but the case where $\Theta_n$'s second formula is what the family attains. The trap the conventions file warns about is live only for a consumer who generalises the block's phrase "$\theta_0(12)$" to odd $n$: **at odd $n$ nothing in this family attains $\theta_0(n)$**, and a citation of the form "sphere products lose to $\theta_0(n)$" would be citing a value the family never reaches. The block writes $\theta_0$; the record's target is $\Theta_n$.

## 5. The ceiling clause, REFUTED

**1. Locate.** [graded-half.md:69](../findings/graded-half.md) and [results.md:318](../results.md), identically: "the simple-isotropy members of Lemma L4's family, which top out at $P\leq0.837$".

**2. Exhibit, in closed form, from the family's own formula.** [L4](../findings/ungraded-slack.md) gives $\theta=\frac2n\sqrt{\frac{rN}{N-r}}$ for a member with $r=\dim\mathfrak h$, $N=\binom n2$. Take $\mathfrak h=\mathfrak{spin}(9)\subset\mathfrak{so}(16)$, the isotropy of $\mathbb{OP}^2$: $n=16$, $r=36$, $N=120$, $N-r=84$, so

$$\theta^2=\frac4{256}\cdot\frac{36\cdot120}{84}=\frac1{64}\cdot\frac{360}7=\frac{45}{56},\qquad \theta=\tfrac34\sqrt{\tfrac{10}7}=\sqrt{\tfrac{45}{56}}=0.896421 .$$

That is $>0.837$. It is a member by L4's own class statement, "isotropy-irreducible symmetric spaces with $b_4=0$ … qualify", and $\mathbb{OP}^2$ has cohomology in degrees $0,8,16$ so $b_4=0$, and [graded-half.md:114](../findings/graded-half.md) says outright "$\mathbb{OP}^2$ is covered by the lemma". **The refutation is already written on the record**, in the file that owns L4: "**The simple-isotropy ceiling is $\tfrac34\sqrt{10/7}=0.896421$, not $0.8367$.** It is attained by $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$".

**3. Argue the opposite.** The most charitable reading is that "simple-isotropy" means the bi-invariant *simple compact Lie group* members, for which $0.837$ is right and provably so: [graded-half.md:162](../findings/graded-half.md) gives $\theta^2=\frac{4(n-1)}{n(n-3)}$ for every compact simple $\mathfrak g$ at once, $\frac{d}{dn}\frac{n-1}{n^2-3n}$ has numerator $-(n^2-2n+3)<0$ so it is decreasing, and the smallest non-degenerate dimension is $n=8$ ($\mathfrak{su}(3)$; $\mathfrak{su}(2)$ at $n=3$ has $W=0$), giving $\theta^2=\tfrac{28}{40}=\tfrac7{10}$ and $\theta=0.836660$. **But that reading is not available**, because the same block eleven lines earlier writes "the **non-Lie-group** simple-isotropy members" as a separate open item, so its own vocabulary distinguishes the two, and the ceiling clause is attached to the union.

**Verdict: REFUTED**, with the correcting witness already on the record.

**Impact, stated plainly.** $0.896421<\sqrt{56/45}<\sqrt{3/2}$, so the *elimination* survives, as [ungraded-slack.md](../findings/ungraded-slack.md) itself says, and no conclusion moves. What is refuted is the figure, in the same class of defect the Gate 2 refutation already named ("*the ceiling reached the report, where a status table called it Proven*"). **Provenance, and it is exculpatory in one direction only:** the $\mathfrak{spin}(9)$ correction landed in commit `451838ee` on **2026-09-07**, three days *after* the L5 rewrite `5b0583d1` of 2026-09-04. So the rewrite did not ignore a standing correction, but the figure is stale as of today in three places at once: [graded-half.md:69](../findings/graded-half.md), [results.md:318](../results.md), and [INDEX-results.md:20](../findings/INDEX-results.md) does not carry it either.

**Symbol note attaching to the same clause.** The record writes "$P\leq0.837$" where $0.837$ is a $\theta$; the two agree only at $\lVert W\rVert=1$, which the clause does not say. And $\sqrt3/2=0.866025$ is tabled at [INDEX-values.md:32](../findings/INDEX-values.md) for $(+\mathrm{Fox})\oplus(-\mathrm{Fox})$ at $n=8$, one character from the census's $\sqrt{3/2}=1.224745$ for Fox's $r=4$, **two Fox objects, two values, one character apart**, and both live in this block's sentences.

## 6. The two admitted-open classes, one is no longer open, and the other refutes the block's own ceiling

**Strongly-regular-graph solutions, the scoping is REFUTED AS STALE, in the record's favour.**

**1. Locate.** [graded-half.md:65](../findings/graded-half.md): "the open two are the strongly-regular-graph solutions, **swept only to $n=200$**, and the non-Lie-group simple-isotropy members".

**2. Exhibit.** [Lemma L144](../findings/diagonal-half.md), in the same findings folder: "**So $\theta<\tfrac12$ for every primitive strongly regular graph, at every $n$, with no census**, conference graphs giving $f=0$ exactly, and $\tfrac14$ the **sharp, never-attained** supremum, which is what the screened $0.4758$ was approaching. *The block's own grade of 'screened and not proved' was honest and is now superseded by a proof.*" The imprimitive half is proved in the same block, $\theta=\sqrt{2(n-1)(g-1)/(n(n-g))}$, maximised at $g=n/2$, which is the balanced product, and every $g\le n/3$ giving $\theta^2\le(n-1)(n-3)/n^2<1$. [problem.md:155](../findings/problem.md) draws the conclusion: "*so the sweep to $n=200$ is a check and no longer the evidence.* **This settles the strongly-regular-graph family, the last named one left unchecked.**"

**3. Argue the opposite.** L144 was graded `GAP` at Gate 2, so one might read the primitive-half proof as reviewer work rather than record. But the grade is "**both GAP, and the gap runs in the block's favour**", the block carries the argument with its load-bearing hypothesis named (multiplicity integrality, the convexity-in-$\mu$ route alone fails at the admissible $(100,50,1)$, returning $\theta^2=1.8636$), and [problem.md](../findings/problem.md) consumes it as settled. The charitable reading makes L5 *more* stale, not less.

**Provenance, exculpatory as to intent.** `49eb931e` promoted L144 at 22:50 on 2026-09-04, three hours after `5b0583d1` wrote the L5 scoping paragraph at 19:31 the same day. The paragraph was right when written and has been wrong since that evening.

**So the open classes are one, not two**, and the census's SRG item is discharged at every $n$ by a bound, $\theta<\tfrac12$, far stronger than the elimination needs. **One mis-description survives independently of the staleness:** the sentence says what is owed is "a closed form plus a whole-range bound per structural class", implying both were missing; the closed form was already an imported theorem with its hypotheses checked at source, DGK Theorem 5.1, $\hat\theta=|\lambda-\mu+1|\sqrt{(n-1)/(nrr^c)}$ over every $\mathrm{srg}(n,r,\lambda,\mu)$, with the conversion $\theta_{\text{record}}=\sqrt2\,\hat\theta_{\text{DGK}}$ recorded and anchored on Example 5.2.

**Non-Lie-group simple-isotropy members.** [graded-half.md:65](../findings/graded-half.md): "whose $(n,r)$ list is nowhere on the record". Correct as to the *list*. But one member of that very class ($\mathfrak{spin}(9)\subset\mathfrak{so}(16)$, $(n,r)=(16,36)$), is on the record with its exact value, and it is the object that refutes the ceiling the same block asserts eleven lines later. **So the block declares the class open and asserts a ceiling over it in the same paragraph**, and the record already holds the member that separates them.

**Neither class is scoped correctly as of today**, one is closed and still recorded as open, the other is recorded as open while a ceiling is asserted over it in the same paragraph, **and neither appears at all in the two places a consumer reads first**, see §7.

## 7. What the surviving text licenses, and what it does not, the central question

**A census records what was examined; the record cites it to exclude rivals.** Precisely:

**A consumer may cite:**

- $\theta<\sqrt{2/(k-1)}$ for every unpadded $k$-block round-sphere product with all $n_a\ge2$, at every $n$, **for $k\le4$**, the range over which the premise is established (§2, §2-i); hence $\theta<1$ at $k=3,4$, hence a strict loss to $\Theta_n$ at every admissible $n\ge6$ (§2c).
- That the strongly-regular-graph class is closed at every $n$, from [L144](../findings/diagonal-half.md), which the block does not cite (§6).
- $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$, over the whole series (§3).
- $\theta(S^5\times S^7)=\sqrt{264/175}>\sqrt{3/2}$, and more generally that the two-factor family's maximum at fixed $n$ is exactly $\Theta_n$ in both parities (§4a, §4d).

**A consumer may not cite:**

- The block as an exclusion of "every other critical-point family found so far", at any $n$. Two of its five named classes are open, and the population is undefined.
- Any ceiling of $0.837$ for the simple-isotropy members (§5).
- "loses to **both** named competitors", refuted from inside the list, by the block's own admission, and by $S^5\times S^7$ from outside it.
- Any statement about the quaternionic-Kähler class beyond the $\mathbb{HP}^m$ series (§3a).
- $\theta_0(n)$ as the balanced value at odd $n$ (§4d).

**The $n$-quantifier, item by item.** Three of the five constituents are now uniform in $n$, multi-block (at $k\le4$), $\mathbb{HP}^m$ over its series $n=4m$, and SRG, by [L144](../findings/diagonal-half.md) since 2026-09-04. One is not: non-Lie-group simple isotropy, with no list. The fifth, Fox's subalgebra and its $r\ge8$ extension, ties rather than loses and carries no $n$-range on the record at all, and that tie is at $\sqrt{3/2}$, which **exceeds** $\Theta_n$ at every $n\le11$ ($\Theta_8=\sqrt{21}/4=1.145644$, $\Theta_{11}=\sqrt{40/27}=1.217161$), so below the conjecture's range that item beats the balanced product rather than losing to it. **The statement still carries no quantifier over $n$, and now it would be a mixed one.**

### 7a. The rewrite did not reach results.md, REFUTED AS STATED

[graded-half.md:53](../findings/graded-half.md) asserts the duplication was "resolved on 2026-09-06: … now holds the statement alone". It does hold the statement alone, and **the statement it holds is the fully refuted one.** [results.md:316–318](../results.md), unchanged since `56848c5e` of 2026-08-31, still reads:

- "##### **Lemma** L5", after the downgrade to `Observation`;
- "**Six** further families **lose to both named competitors**", the count and the comparative that [graded-half.md:69](../findings/graded-half.md) corrects to "Five … four lose … and one ties";
- "quaternionic-Kähler operators on $\mathbb{HP}^m$, **$m\leq4$**", after the supremum over all $m$;
- "which top out at **$P\leq0.837$**", refuted per §5;
- "every primitive case checked … falls well short" with no open-class marker.

**The landscape line, [results.md:118](../results.md), is internally inconsistent on its own terms.** "Six families eliminated **on value**" together with "one family attains $\sqrt{3/2}$ **exactly**" cannot both hold: a family attaining the competitor's value is not eliminated on value. And "The elimination survives, with a margin of $0.109$" is the margin of the strict subset excluding that family, the sentence states its own exception two clauses earlier. *Argue the opposite:* one may read "the highest" as "the highest **of those eliminated**", which repairs the arithmetic. It does not repair the count, which stays at six while the block's own correction says five.

### 7b. The retained refutation paragraph attacks a sentence the block no longer contains

[graded-half.md:45](../findings/graded-half.md) opens: "**'The highest tops out at $0.837$ … none is close' is false three times over, each witness inside the six families that sentence enumerates.**" The phrase "none is close" is nowhere in the current census sentence at line 69, and the current $0.837$ clause is scoped to item 5 alone rather than to all six. Of the three witnesses offered, the $\mathbb{CP}^m$ family is not among the five classes line 69 enumerates. So a consumer reading the quotation as an attack on the *current* text is misdirected, and, more to the point, **the witness that does refute the current clause ($\mathfrak{spin}(9)$, §5) is not among the three.**

*Argue the opposite.* A Gate 2 quotation is a historical record of what was refuted, and quoting the sentence as it then stood is correct practice. Accepted, this is a consumability finding, not a mathematical one, and the fix is one clause saying which sentence is being quoted from when.

## 8. Withdrawn candidates

**W-1. "Fox's $r=4$ subalgebra" is not among the enumerated families.** Item 2 is "Fox's full 5-dimensional hyper-Kähler subalgebra and its $r\ge8$ extension"; $r=4$ is neither. **Withdrawn:** item 2's own parenthesis says both members "collapse onto orbits of already-named competitors", and the named competitor is padded $W_{\mathbb{CP}^2}$, whose value the family's own closed form gives at $r=4$: from [algebra.md](../findings/algebra.md), $\lVert S^r\rVert^2_{\text{Frob}}=\tfrac14\cdot\frac{6r(r-2)}{(r+2)(r-1)}$ and $\theta=1/\lVert S^r\rVert$, so $\theta^2=\frac{2(r+2)(r-1)}{3r(r-2)}$, which at $r=4$ is $\frac{2\cdot6\cdot3}{3\cdot4\cdot2}=\tfrac32$ exactly. The naming is loose; the claim is right.

**W-2. "the $\mathbb{CP}^m$ family exceeds $0.837$ for every $2\le m\le30$" is a bounded check.** It reads like a sweep bound. **Withdrawn:** it is the exact range, and provably so. With $r=2m$, $\theta^2>\tfrac7{10}\iff20(r+2)(r-1)>21r(r-2)\iff r^2-62r+40<0$, whose roots are $31\pm\sqrt{921}$, i.e. $0.652$ and $61.348$. So the inequality holds exactly for $r\le60$, i.e. $m\le30$, and fails from $r=62$ ($3844-3844+40=40>0$). Checked at both ends: $m=30$ gives $3600-3720+40=-80<0$; $m=31$ gives $+40>0$. The printed "$2\le m\le30$" is sharp, not a sweep.

**W-3. The $\mathbb{HP}^m$ block masses rest on "matching the measured $0,224,810,\tfrac{9504}5$".** Looks like fitting. **Withdrawn:** the formula $S_{\mathfrak{mmm}}=\rho d_3-2(S_{133}+S_{233})$ is derived from the marginal identity and total symmetry of $T$ before the match is quoted, and the match is offered as corroboration. The block also states the unstated premise it repaired, and why it was invisible at $m=2$.

**W-4. $\ker W\ne0$ makes the gradedness screen vacuous, per trap W4.** Looks applicable, since padded objects abound here. **Withdrawn:** the surviving L5 text uses no gradedness slack $S$. Its two theorems are a norm bound and a supremum, neither of which passes through $S$. The exposure that *is* real is the padding of the closed form, recorded at §2b, not the $S$ screen.

## 9. What would falsify the surviving statement, and what I did to look for it

**The object.** A critical point $W$ of $P$ on the unit sphere of $\mathcal W_n$, at some $n\ge12$, belonging to one of the five classes the census names, with $\theta(W)\ge\Theta_n$.

**Where I looked, in closed form only.**

- *Multi-block, $k\ge3$:* excluded outright, $\theta<\sqrt{2/(k-1)}\le1$ and $\min_{n\ge6}\Theta_n=\sqrt{10/9}>1$ (§2, §2c). No such object exists in this class at any $n$.
- *Two-factor:* excluded, the maximum over splits at fixed $n$ is exactly $\Theta_n$, attained only at the balanced split, in both parities (§4d). The class's only escape is against the *other* competitor $\sqrt{3/2}$, and that escape is real and already recorded.
- *$\mathbb{HP}^m$:* excluded, $\sup=\sqrt{56/45}<\sqrt{3/2}<\Theta_{12}$, over all $m$ (§3).
- *The L4 subalgebra family:* capped by L23 at $\theta_0(n)$ with equality exactly at the graded members. I tested the one member the record flags as dangerous, $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$: it is at $\sqrt{45/56}=0.896421$, below both competitors, and it falsifies the *ceiling* rather than the elimination (§5).
- *SRG:* excluded on the record, though not by this block, [L144](../findings/diagonal-half.md) gives $\theta<\tfrac12$ for every primitive graph at every $n$ and the balanced product for the imprimitive half (§6). I did not attempt an independent bound: optimising over the SRG feasible region is a search, reserved under the analysis-only rule.
- *Multi-block at $k\ge5$:* **not excluded.** The bound's premise is verified at $k\le4$ (§2-i). The smallest untested instance is $(S^2)^5$ at $n=10$. Constructing it and evaluating $Q$ is computation, which this loop does not do; I note only that no argument on file covers it.

**So the live falsifier homes are two, and neither is where the block points:** the unlisted non-Lie-group simple-isotropy members, and the $k\ge5$ multi-block partitions whose closed form has no proof on file. The SRG class the block marks open is closed.

## Verdict

**GAP.**

One of the two theorems the rewrite promoted is sound over its whole stated range, $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$, with the printed derivative reproduced term for term. The other, $\theta<\sqrt{2/(k-1)}$, is a correct implication from a premise proved only to $k=4$, quantified in L5 over "3+ factors". The surviving conclusion against the balanced product holds at every $n$, odd $n$ included, by an argument the block does not carry but which is available in three lines from the record's own closed forms. Against that:

1. **The load-bearing premise is proved to $k=4$ and cited for all $k$**, [ungraded-slack.md:31](../findings/ungraded-slack.md)'s "verified symbolically for $k=2,3,4$" against the census's "3+ factors" (§2-i).
2. **A refuted figure still stands**, "$P\leq0.837$", against $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$ at $\sqrt{45/56}=0.896421$, in three files, with the correcting witness on the record since 2026-09-07 (§5).
3. **A false universal stands inside the Gate 2 quotation**, "whenever $p,q\ge5$", refuted at $(5,5)$ and $(5,6)$ in closed form; the correct region is $p,q\ge6$ together with $p=5,q\ge7$ (§4b).
4. **The scoping paragraph is stale on the half that matters**, the SRG class has been closed at every $n$ since three hours after the rewrite was written, and the block still lists it as swept to $n=200$ (§6).
5. **None of the 2026-09-04 rewrite reached [results.md](../results.md)**, where the fully refuted text still stands as *Lemma* L5 with all five of its defects (§7a), and where the landscape line contradicts itself within one sentence.
6. **Two further hypothesis debts** on the surviving derivation: the bridge $\theta=1/(2\lVert W\rVert)$ that the word "hence" carries, whose stated scope is *irreducible* symmetric spaces while the objects are products (§2a); and the unstated $n=\sum_an_a$, whose misreading reverses the block's own headline (§2b).

No value the record depends on moves. What moves is what a consumer may cite, and the gap runs in both directions: the findings file claims one range it has not earned ($k\ge5$) and concedes another it has ($n>200$).
