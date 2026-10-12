# VERIFY v107, L10: the closed form holds and is exact, the heading it is filed under is false at its own first member, and "one critical point each" is one-dimensionality restated over a dimension count that was computed rather than proved

**Verifier v107, cold brief, [ROUND_L10.md](ROUND_L10.md).** Sources checked: [findings/graded-half.md](../findings/graded-half.md):468–476, [results.md](../results.md):128 and :379–381, [results.md](../results.md):501–505 (L38), [lean/INDEX.md](../lean/INDEX.md):260, [lean/HamiltonsCubic/Results/L10.lean](../lean/HamiltonsCubic/Results/L10.lean), [findings/INDEX-values.md](../findings/INDEX-values.md), [findings/INDEX-results.md](../findings/INDEX-results.md):25, [findings/conventions.md](../findings/conventions.md), [findings/INDEX-traps.md](../findings/INDEX-traps.md):22, [findings/target.md](../findings/target.md):462, [findings/problem.md](../findings/problem.md):152, [findings/LEDGER.md](../findings/LEDGER.md):1021, and the three reports the record cites for this claim, [agent_logs/review_r15_report.md](../agent_logs/review_r15_report.md), [reviews/REVIEW_r461.md](../reviews/REVIEW_r461.md), [reviews/REVIEW_r462.md](../reviews/REVIEW_r462.md). **No numerical work was done: no script was run, and every number below is an exact hand evaluation of a rational the record itself records.** Log: [agent_logs/verify-L10-v107.log](../agent_logs/verify-L10-v107.log).

## Verdicts

| # | Claim, as a consumer would read it alone | Verdict |
|---|---|---|
| C1 | *"The reducible-isotropy families carry one critical point each, all below the threshold"*, the heading at [graded-half.md](../findings/graded-half.md):468, [results.md](../results.md):128 and [results.md](../results.md):379 | **BROKEN** |
| C2 | *"All sit far below $\sqrt{3/2}$"*, [graded-half.md](../findings/graded-half.md):476 | **GAP** |
| C3 | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ on the $\mathbb{CP}^m$ family (the closed form itself | **GAP**), derived on the record, in a file L10 does not cite, over an unstated normalisation constant. See §9 |
| C4 | The value is exactly $\tfrac32$ at $m=2$ | **PROVEN** |
| C5 | Strictly decreasing in $m$, limit $2/3$ | **PROVEN** |
| C6 | *"there is exactly one per family"* / *"one critical point each"* | **BROKEN** |
| C7 | *"Ricci-flatness together with the first Bianchi identity cuts each one-parameter-per-factor family down to a one-dimensional space"* | **HYPOTHESIS-DEBT** |
| C8 | The four decimals $1.115547$, $0.852944$, $0.720082$, $0.596068$ | **PROVEN** as decimals of the record's own rationals |
| C9 | *"Three of these are ungraded, with slack between $0.57$ and $0.96$"* | **PROVEN**, with one endpoint rounded the wrong way, the largest slack is $0.9631$ |
| C10 | The closed form's admissible range of $m$ | **GAP**, L10 states none; [L38](../results.md):503 states $m\ge2$ |
| C11 | The name *"reducible-isotropy"* | **GAP**, the record's own table calls $\mathfrak u(n/2)$ irreducible |
| C12 | The Lean row | No finding: [lean/INDEX.md](../lean/INDEX.md):260 is the one place on the record that states the $m=2$ case correctly in the same breath as the bound |

**Overall verdict: BROKEN**, on C1 and C6, with C3's gap and C7's debt standing behind the parts that survive.

**One line.** The mathematics of the $\mathbb{CP}^m$ half is right and I reproduce every recorded number by hand from the record's own rationals; what is wrong is the sentence a consumer cites, the heading asserts *below* where the family's first member sits exactly *at*, and the count "one per family" is false by a factor of two under the record's own convention and, once repaired to "one up to sign", is the definition of a one-dimensional space rather than a theorem about $P$.

## 0. Conventions, fixed once

Taken from [findings/conventions.md](../findings/conventions.md), quoted rather than restated.

- $\mathcal W_n$ is the space of algebraic Weyl curvature operators on $\mathbb R^n$, $Q(W)=W^2+W^\#$ is Hamilton's quadratic map sending $\mathcal W_n$ to itself, and $P(W)=\langle W,Q(W)\rangle$.
- $\theta=P(W)/\lVert W\rVert^3$, and at a critical point $Q(W)=\theta W$. **$\theta$ is signed**: $P$ is a cubic form, so $P(-W)=-P(W)$ and $\theta(-W)=-\theta(W)$. This single fact drives §5.
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$ and $\Theta_n$ is the diagonal maximum. Neither is "the threshold" of L10.
- **"The threshold" in L10 is the constant $\sqrt{3/2}$.** Three independent lines fix this: the block's own last-but-one sentence names $\sqrt{3/2}$; the canonical body at [results.md](../results.md):381 says *"exactly $\tfrac32$ at $m=2$ … every **other** family's point sits below the threshold"*, a sentence that is only well formed if $m=2$ fails to sit below it; and the [conventions.md](../findings/conventions.md) row for $M(n)$ records *"padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$"*, so the $m=2$ member's value **is** $\sqrt{3/2}$.
- $\sqrt{3/2}=1.224745\ldots$, exact to the six places the record uses: $1.224745^2=1.500000400\ldots>3/2$, and the deficit $4.0\times10^{-7}$ divided by $2\times1.224745$ is $1.6\times10^{-7}$, so $\sqrt{3/2}=1.2247448\ldots$, which rounds to $1.224745$.

## 1. Hypothesis inventory

*A pass without one is not a pass. Each row: the hypothesis, the object it applies to, and whether the written argument uses it.*

### 1a. Hypotheses the block carries

| # | Hypothesis | The object it applies to | Stated in the block? | Used by the written argument? |
|---|---|---|---|---|
| H1 | $m\ge2$ | the $\mathbb{CP}^m$ closed form | **No.** [L38](../results.md):503 carries it; L10 carries no range at all | Silently, see §7 |
| H2 | The family is *one-parameter-per-factor*, i.e. the honest ansatz has one free scalar per simple ideal of the isotropy algebra plus the centre | the $\mathfrak u(m)$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(k)$ and $\mathfrak u(1)\oplus\mathfrak{su}(a)\oplus\mathfrak{su}(b)$ families | Named, never defined. Its only definition on the record is in a reference note, [petersen-stanfield notes](../references/petersen-stanfield-2025-poincare-polynomials/notes.md):23 | Load-bearing and unstated |
| H3 | Ricci-flatness holds on the family, i.e. the parametrised operators are cut down to trace-free ones | each family's ansatz space | Yes | Yes |
| H4 | The first Bianchi identity holds on the family | same | Yes | Yes |
| H5 | The resulting space is **one**-dimensional | each named family, at every $m$ | Asserted | Yes, everything downstream rests on it. **No argument, see §6** |
| H6 | $Q$ maps $\mathcal W_n$ into $\mathcal W_n$ | $Q$ | No | Yes, implicitly: "the critical point in each is forced" is otherwise unavailable |
| H7 | $Q$ is $O(n)$-equivariant | $Q$ | **No**, the word does not occur in the block | Yes, and this is the whole of "forced rather than found". See §5 |
| H8 | $\theta>0$ is the chosen representative of $\pm W$ | the family's two unit Weyl operators | No | Yes, and its absence is C6 |

### 1b. Hypotheses of the results the block imports

| # | Imported result | Its hypothesis | Checked against L10's object? |
|---|---|---|---|
| I1 | $Q(\mathcal W_n)\subseteq\mathcal W_n$, proved at [problem.md](../findings/problem.md) from [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) eq. (6), the one hypothesis here that is read from a source held in [references/](../references/) | $\mathrm{Ric}(W)=0$ | Yes, H3 supplies it |
| I2 | The gradedness slack $S$, imported for the "three of these are ungraded" sentence | **[Trap W4](../findings/INDEX-traps.md):22, the screen is vacuous when $\ker W\ne0$, so trust it only at $\ker W=0$.** The block records no kernel for any of the four points | **Does not bind**, and only by luck: the block uses $S$ in the direction $S>0\Rightarrow$ not graded, which is the sound direction. Had the block asserted the $S=0$ rows *graded*, as [graded-half.md](../findings/graded-half.md):452 does, forty lines above, the trap would bite and the kernels would be owed |
| I3 | Cartan's classification, on which "the families" being an enumeration rests | [conventions.md](../findings/conventions.md) records it as *"invoked in four findings files and cited to no source anywhere on the record; [references/](../references/) holds no Helgason or Cartan entry"* | **Unread source.** The block does not invoke it by name, but "the reducible-isotropy families" is only a closed list if something enumerates them |
| I4 | [L38](../results.md):501, cited by name in the [results.md](../results.md):381 form for the monotonicity | $m\ge2$ | The citing sentence drops the range. See §7 |

**The two hypotheses that decide the verdict are H5 and H7**, and neither is written anywhere in the block, in either of its two copies.

## 2. Pre-registered question 1, is every point below the threshold? **No. The family's first member is exactly on it.**

### 2a. The evaluation, by hand

$$\theta^2\big|_{m=2}=\frac{(m+1)(2m-1)}{3m(m-1)}\bigg|_{m=2}=\frac{3\cdot3}{3\cdot2\cdot1}=\frac96=\frac32.$$

So $\theta=\sqrt{3/2}$ at $m=2$, and $\sqrt{3/2}$ *is* the threshold, by all three of §0's independent fixings. **The $m=2$ member sits at the threshold, not below it.**

### 2b. What the heading and the canonical form claim

Three separate lines, each of which a consumer can cite on its own:

| Where | The words | Reads |
|---|---|---|
| [graded-half.md](../findings/graded-half.md):468 | *"Lemma L10 (the reducible-isotropy families carry one critical point each, **all below the threshold**), canonical statement and proof"* | **False** |
| [results.md](../results.md):128 | *"**Lemma L10 (landscape). The reducible-isotropy families carry one critical point each, all below the threshold.**"* | **False** |
| [results.md](../results.md):379 | *"##### Lemma L10, the reducible-isotropy families carry one critical point each, **all below the threshold**"* | **False** |
| [results.md](../results.md):381 (body) | *"exactly $\tfrac32$ at $m=2$ and strictly decreasing in $m$ (Lemma L38); every **other** family's point sits below the threshold"* | **True** |
| [graded-half.md](../findings/graded-half.md):476 (body) | *"equal to exactly $3/2$ at $m=2$ … All sit far below $\sqrt{3/2}$"* | See §2d |

So the record carries the correction in the body of two of its three copies and in **none** of its three headings.

### 2c. Discrepancy C1, under the protocol

**Located.** The heading string *"all below the threshold"*, verbatim at [graded-half.md](../findings/graded-half.md):468, [results.md](../results.md):128 and [results.md](../results.md):379.

**Exhibited concretely, at a named object.** Take $m=2$: the object is $W_{\mathbb{CP}^2}$, the Weyl operator of $\mathbb{CP}^2$ at $n=4$, which the record names in five places and whose value it fixes independently of this closed form, [conventions.md](../findings/conventions.md)'s $M(n)$ row (*"padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$"*), [results.md](../results.md):589 (*"the saturating ones are $S^2\times S^2$ and $W_{\mathbb{CP}^2}$"*), and [fence-posts.md](../findings/fence-posts.md):345 (*"padded $W_{\mathbb{CP}^2}$ … gives $\theta=1.224745$"*). It is a member of the $\mathbb{CP}^m$ family, which is one of the reducible-isotropy families the heading quantifies over, and its $\theta$ equals the threshold exactly. A universal statement with an exhibited exception at its own first member is false.

**Argued the opposite, the most charitable reading the words support.** Two candidates, and both close.
1. *"The threshold" might mean $\theta_0(n)$ or $\Theta_n$ rather than $\sqrt{3/2}$.* Closed by the block's own final sentences, which name $\sqrt{3/2}$ and nothing else, and by the canonical body's *"every **other** family's point"*, a phrase that carries no meaning unless the $\mathbb{CP}^m$ family's point fails the predicate.
2. *"Below" might be read loosely, as "does not exceed".* Closed by the fact that the entire programme turns on whether anything reaches $\sqrt{3/2}$: the target is a maximisation, [L2](../results.md):302 records that *"below the crossover the $\mathbb{CP}^2$-type competitor genuinely wins"*, and $M(n)\ge\sqrt{3/2}$ is what makes this point the rival maximizer rather than a member of the field. In the one context where the distinction between $<$ and $\le$ decides the programme's headline, it cannot be read loosely.

**Verdict C1: BROKEN.** Not withdrawn.

### 2d. Discrepancy C2, *"All sit far below $\sqrt{3/2}$"*

**Located.** [graded-half.md](../findings/graded-half.md):476, third sentence from the end.

**Exhibited concretely.** Two failures, of different weight.
- *Scope.* The antecedent of "All" is ambiguous between the four decimals of the immediately preceding sentence and every value the paragraph has named, the $\mathbb{CP}^m$ family included. On the second reading it is flatly false at $m=2$, where the paragraph has said four words earlier that the value is $3/2$.
- *"Far".* On the first reading, the largest of the four is $\mathbb{HP}^2$ at $\theta=1.115547$, against $\sqrt{3/2}=1.224745$: a gap of $0.109198$. The record itself, at [graded-half.md](../findings/graded-half.md):454 (**eighteen lines above this very block, in the same file**), calls exactly this number tight: *"cutting the gap to $\sqrt{3/2}$ from $0.324$ to $0.109$ and turning the ungraded half from a loose problem into a tight one."* So the same file describes $0.109$ as tight in one paragraph and as "far below" in another.

**Argued the opposite.** The nearest-antecedent reading is the natural one ("All" most plausibly ranges over the four decimals just listed) and on that reading the inequality itself is true, since $1.115547<1.224745$. The identical sentence at [graded-half.md](../findings/graded-half.md):101, *"every one sits far below $\sqrt{3/2}=1.224745$"*, is attached to the Wolf/Grassmannian table alone, which supports the narrow reading. So the sentence is not false on its best reading, and "far" is a rhetorical overstatement rather than a mathematical error.

**Verdict C2: GAP**, not BROKEN, the inequality survives, the quantifier's range and the word "far" do not.

## 3. Pre-registered numbers, all by hand

### 3a. The closed form's values

Write $f(m)=\dfrac{(m+1)(2m-1)}{3m(m-1)}$. The clean way to see everything at once is to separate the limit:

$$f(m)-\frac23=\frac{3(2m^2+m-1)-2(3m^2-3m)}{3\cdot3m(m-1)}=\frac{6m^2+3m-3-6m^2+6m}{9m(m-1)}=\frac{9m-3}{9m(m-1)}=\frac{3m-1}{3m(m-1)},$$

so

$$\boxed{\;f(m)=\frac23+g(m),\qquad g(m)=\frac{3m-1}{3m(m-1)}.\;}$$

| $m$ | $g(m)$ | $f(m)=\tfrac23+g(m)$ | check |
|---|---|---|---|
| $2$ | $5/6$ | $2/3+5/6=4/6+5/6=9/6=\mathbf{3/2}$ | matches the block |
| $3$ | $8/18=4/9$ | $2/3+4/9=6/9+4/9=10/9$ | $\theta=\sqrt{10}/3=1.0540926$, the record's $\mathbb{CP}^3$ value and $\theta_0(6)$ |
| $4$ | $11/36$ | $24/36+11/36=35/36$ | matches [graded-half.md](../findings/graded-half.md):431's $\mathbb{CP}^4$ figure $\theta^2=35/36$ |
| $8$ | $23/168$ | $112/168+23/168=135/168=\mathbf{45/56}$ | matches the record's independent $m=8$ check |

Direct evaluation confirms the boxed rewriting at $m=8$: $(m+1)(2m-1)=9\cdot15=135$ and $3m(m-1)=3\cdot8\cdot7=168$, and $135/168=45/56$ on dividing by $3$. **Four independent recorded values reproduced exactly.**

### 3b. The limit $2/3$

From the boxed form, $f(m)-2/3=g(m)=\frac{3m-1}{3m^2-3m}\to0$ as $m\to\infty$, since the numerator is degree $1$ and the denominator degree $2$ with positive leading coefficient. **The limit is $2/3$ and it is not attained**, $g(m)>0$ for every $m\ge2$. The block's *"decreasing monotonically to $2/3$"* is correct as a limit statement, and a consumer must not read it as "the family attains $2/3$".

### 3c. The monotonicity

$g(m)=\dfrac{3m-1}{3m^2-3m}$, so by the quotient rule

$$g'(m)=\frac{3(3m^2-3m)-(3m-1)(6m-3)}{(3m^2-3m)^2}.$$

The numerator is $9m^2-9m-(18m^2-9m-6m+3)=9m^2-9m-18m^2+15m-3=-9m^2+6m-3=-3(3m^2-2m+1)$, and $3m^2-2m+1$ has discriminant $4-12=-8<0$ with positive leading coefficient, hence is strictly positive for every real $m$. So $g'(m)<0$ on $m>1$ and **$f$ is strictly decreasing there**, with $f(m)>2/3$ throughout.

*This reproduces, independently and by a different route, the derivative numerator $-3(3m^2-2m+1)$ recorded at [REVIEW_r461.md](../reviews/REVIEW_r461.md):22. Agreement between my hand computation and a report I read after doing it.*

**Verdicts C4 and C5: PROVEN.** The $m=2$ value, the limit and the strict monotonicity are pure arithmetic on the stated formula and I have carried them out.

### 3d. The four decimals

These are not free-standing figures: [findings/INDEX-values.md](../findings/INDEX-values.md) records an exact rational for each, and the check available to a verifier who runs nothing is whether the decimal is the square root of the rational.

| decimal | recorded rational | hand check | verdict |
|---|---|---|---|
| $1.115547$ ($\mathbb{HP}^2$) | $\sqrt{56/45}$, [INDEX-values.md](../findings/INDEX-values.md):24 | $56/45=1.24444\overline4$. $1.115547^2=1.1155^2+2(1.1155)(0.000047)=1.24434025+0.00010486=1.24444511>1.2444\overline4$ by $6.7\times10^{-7}$, so $\sqrt{56/45}=1.115547-3\times10^{-7}=1.1155467$, the record's own long form $1.115546702$ | **confirmed** |
| $0.852944$ ($\mathbb{HP}^3$) | $\sqrt{275/378}$, [INDEX-values.md](../findings/INDEX-values.md):45 | $275/378=0.72751323$. $0.8529^2=0.72743841$; the deficit $7.48\times10^{-5}$ over $2(0.8529)=1.7058$ gives $+4.38\times10^{-5}$, so the root is $0.8529438$ | **confirmed** |
| $0.720082$ ($\mathrm{Gr}_{\mathbb C}(2,2)$) | $\sqrt{14/27}$, [INDEX-values.md](../findings/INDEX-values.md):34 | $14/27=0.5185185$. $0.72^2=0.5184$; deficit $1.185\times10^{-4}$ over $1.44$ gives $+8.23\times10^{-5}$, root $0.7200823$ | **confirmed** |
| $0.596068$ ($\mathrm{Gr}_{\mathbb C}(2,3)$) | $\sqrt{275/774}$, [INDEX-values.md](../findings/INDEX-values.md):35 | $275/774=0.3552972$. $0.596^2=0.355216$; deficit $8.12\times10^{-5}$ over $1.192$ gives $+6.81\times10^{-5}$, root $0.5960681$ | **confirmed** |

**Verdict C8: PROVEN, at the reach a hand check has.** All four decimals are the correct decimal expansions of the rationals the record holds for them. **What this does not establish is that those rationals are the $\theta$ values of those spaces**, that rests on constructed curvature operators and is numerical evidence, never proof. A consumer may cite the decimals as decimals and must not cite them as proved values.

### 3e. A cross-check on the Wolf family that I did not go looking for

[REVIEW_r461.md](../reviews/REVIEW_r461.md):27 closes the Wolf half with $\theta^2_{\mathbb{HP}^m}=\frac{(m+2)^2(4m-1)}{9m(2m+1)(m-1)}$. Evaluating it by hand:

- $m=2$: $\frac{16\cdot7}{9\cdot2\cdot5\cdot1}=\frac{112}{90}=\frac{56}{45}$, the recorded $\mathbb{HP}^2$ rational, exactly.
- $m=3$: $\frac{25\cdot11}{9\cdot3\cdot7\cdot2}=\frac{275}{378}$, the recorded $\mathbb{HP}^3$ rational, exactly.
- $m=4$: $\frac{36\cdot15}{9\cdot4\cdot9\cdot3}=\frac{540}{972}=\frac59$, so $\theta=\sqrt5/3=0.7453560$, which is [problem.md](../findings/problem.md):152's independently constructed $\mathbb{HP}^4$ value $0.745356$ at $n=16$, a figure that formula was not fitted to.

**Three-for-three, by hand.** *This is corroboration, not proof, and the formula is a reviewer's rather than the record's*, see §8.

## 4. Pre-registered question 2, how many critical points does a one-dimensional family carry, and which one holds the value?

### 4a. The count: two

Let $V\subset\mathcal W_n$ be a one-dimensional space of Weyl operators, $V=\mathbb R W$ with $\lVert W\rVert=1$. Then $V\cap S(\mathcal W_n)=\{W,-W\}$, **exactly two points**, since a line through the origin meets the unit sphere twice.

Both are critical points of $P$ on the sphere whenever either is. $P$ is a cubic form, so its gradient $\nabla P$ is a quadratic map, and with the record's normalisation $Q$ is that quadratic map up to the constant that makes the criticality equation read $Q(W)=\theta W$. Being quadratic, $Q(-W)=Q(W)$. Hence, if $Q(W)=\theta W$, then

$$Q(-W)=Q(W)=\theta W=(-\theta)\cdot(-W),$$

so $-W$ is a critical point too, with $\theta(-W)=-\theta$. Independently: $\theta=P(W)/\lVert W\rVert^3$ and $P$ is odd, so $\theta(-W)=-\theta(W)$ directly from [conventions.md](../findings/conventions.md).

### 4b. Which one holds the stated value

$\theta^2=3/2$ is shared by both. The stated value $\theta=+\sqrt{3/2}$ belongs to $+W$, the representative with $\theta>0$, which is the record's standing choice, [conventions.md](../findings/conventions.md) fixing *"normalise $W$ to $\theta>0$ before measuring $S$"*. The block states no such normalisation and names no representative.

### 4c. Discrepancy C6, under the protocol

**Located.** *"there is exactly one per family"*, [results.md](../results.md):381; and *"the reducible-isotropy families carry one critical point each"*, at all three headings.

**Exhibited concretely, at a named object.** [results.md](../results.md):589 (the record's own canonical statement of the $n=4$ case), reads: *"At $n=4$, where $\mathfrak{so}(4)$ is not simple, the critical points are $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$ up to $O(4)$ and the saturating ones are $S^2\times S^2$ and $W_{\mathbb{CP}^2}$."* So at $n=4$, which is exactly the $m=2$ member of L10's own $\mathbb{CP}^m$ family, **the record counts $\pm W_{\mathbb{CP}^2}$ as two critical points and then names which of the two saturates.** Under the record's own convention, stated in the record's own canon, L10's family carries two critical points and not one.

**Argued the opposite.** The strongest charitable reading is that L10 means *one up to sign*, and this reading has real support: the report the claim descends from says so in as many words. [agent_logs/review_r15_report.md](../agent_logs/review_r15_report.md):115 reads *"Each family contains exactly **one unit Weyl operator up to sign**, so 'exactly one critical point' is forced by linear algebra."* The qualifier is in the source and was dropped in transcription. On that reading the sentence is true.

**But the charitable reading costs the claim its content**, which is the second half of the pre-registered question. A one-dimensional subspace has one unit vector up to sign **by definition of one-dimensional**. So "exactly one critical point per family, up to sign" contributes nothing beyond H5; the only non-trivial assertion left in the sentence is that this operator is a critical point *at all*, and that is H7's job, not the dimension count's. **"One critical point each" is one-dimensionality restated, plus an existence claim carried by an unstated equivariance argument.**

**Verdict C6: BROKEN** as written (false by a factor of two against the record's own $n=4$ convention) and, once repaired to "one up to sign", **vacuous as a statement about $P$**.

## 5. Where the existence half actually comes from, and whether it is written

The block's only words for it are *"so the critical point in each is forced rather than found"*. That "so" carries H6 and H7, neither named.

**The argument does exist on the record, for one of the families, in a different file.** [findings/target.md](../findings/target.md):462 writes it out:

> *"Measured as the nullity of $W\mapsto[\mathrm{ad}(X),W]$ over a basis of $\mathfrak u(m)=\{X\in\mathfrak{so}(2m):XJ=JX\}$ restricted to $\mathrm{Weyl}_n$: $1$ of $10$, $1$ of $84$, $1$ of $300$ at $m=2,3,4$. So $\mathbb{CP}^m$ is the unique $U(m)$-invariant Weyl tensor up to scale, and criticality then follows with no computation, $Q$ is $O(n)$-equivariant, so $Q(W)$ is again $U(m)$-invariant, hence a multiple of $W$."*

That is the correct shape: invariance of $Q$ under the isotropy group, a one-dimensional invariant subspace, Schur. [REVIEW_r462.md](../reviews/REVIEW_r462.md):14 names the same shape in a parenthesis (*"Criticality-is-forced argument is sound (1-dim invariant space + equivariance of Q)"*) and [REVIEW_r583.md](../reviews/REVIEW_r583.md):46 supplies the equivariance itself with a reason. **I am not supplying any of this; I am recording that it exists elsewhere and is absent here.** Three things follow, and they are the finding rather than a repair:

1. **It is written for $\mathfrak u(m)$ only.** No file writes it for $\mathfrak{sp}(1)\oplus\mathfrak{sp}(k)$ or for the two Grassmannian isotropies, which are three of L10's families.
2. **Its dimension input is a measured nullity at $m=2,3,4$**, not an argument at general $m$, see §6.
3. **$Q$'s $O(n)$-equivariance is stated in no findings file and in no row of [conventions.md](../findings/conventions.md)**; it lives in reviewer reports. For a step this load-bearing, that is a convention the record uses without tabling, which is precisely what [conventions.md](../findings/conventions.md)'s own preamble exists to prevent.

**No finding on soundness**: nothing I checked contradicts the argument's shape. The finding is that the block does not contain it.

## 6. Pre-registered question 3, is the dimension count on file?

**It is on file as a computation, at finitely many members, and as an argument nowhere.**

I read the report the record cites for it. [agent_logs/review_r15_report.md](../agent_logs/review_r15_report.md):105–115 is the source of the sentence, and it is a table:

| family | Ricci-flat dim | Ricci-flat **and** Bianchi |
|---|---|---|
| $\mathfrak u(m)$ in $\mathfrak{so}(2m)$, $m=2..6$ | $2$ | $1$ |
| $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ in $\mathfrak{so}(8)$ | $2$ | $1$ |
| $\mathfrak{sp}(1)\oplus\mathfrak{sp}(3)$ in $\mathfrak{so}(12)$ | $2$ | $1$ |
| $\mathfrak u(1)\oplus\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ in $\mathfrak{so}(8)$ | $3$ | $1$ |
| $\mathfrak u(1)\oplus\mathfrak{su}(2)\oplus\mathfrak{su}(3)$ in $\mathfrak{so}(12)$ | $3$ | $1$ |

Every entry is the rank of a linear system, computed. The second, on-file route is the nullity count at [target.md](../findings/target.md):462, *"$1$ of $10$, $1$ of $84$, $1$ of $300$ at $m=2,3,4$"*, also computed, at three members. A third, [graded-half.md](../findings/graded-half.md):492, records *"Checked at every split and at $\mathfrak u(m)$ for $n=6,8,10$ by computing the kernel of the stacked $\mathrm{ad}$-action on the Weyl basis"*, computed, at three dimensions.

**Discrepancy C7, under the protocol.**

**Located.** *"Ricci-flatness together with the first Bianchi identity cuts each one-parameter-per-factor family down to a one-dimensional space of Weyl operators"*, [graded-half.md](../findings/graded-half.md):472 and [results.md](../results.md):381.

**Exhibited concretely.** The sentence is universally quantified over $m$, "each … family", and the closed form it introduces is asserted for all $m$. The evidence is five rows covering $\mathfrak u(m)$ for $m\le6$ and one member each of the other families. **At $m=7$ the claim has no support of any kind on the record**, and nothing on the record rules out the dimension jumping: the count is the dimension of a kernel whose defining system grows with $m$, and dimension counts of exactly this shape have jumped on this record before, [graded-half.md](../findings/graded-half.md):404 records the $\mathbb Z_2$-grading enumeration being *"short by two"* at the one exceptional $n$, and [graded-half.md](../findings/graded-half.md):492's own companion claim that *"each symmetric pair carries an invariant Weyl space of dimension exactly one"* is annotated in place: *"That is refuted by this file's own counterexample above."*

**Argued the opposite.** The most charitable reading is that the dimension count is a representation-theoretic fact (the multiplicity of the trivial $K$-representation in $\mathcal W_n$) which for a symmetric pair is genuinely computable in general by branching, and which the $2\to1$ pattern across five rows makes overwhelmingly likely. That reading is very probably true. **It is not a proof, and it is not on file**: no branching computation, no multiplicity formula, and no general-$m$ argument appears in any findings file, in [results.md](../results.md), or in the reports the record cites. And this record's own standing rule is that numerical agreement across sampled members is an open hypothesis.

**Verdict C7: HYPOTHESIS-DEBT.** What would have to be shown, exactly: *for every $m\ge2$, the space of $K$-invariant elements of $\mathcal W_{2m}$ is one-dimensional, for $K=U(m)$; and the corresponding statement for $K=Sp(1)\times Sp(k)$ in $SO(4k)$ and for the two complex-Grassmannian isotropies at general parameters.* Until that is shown, the block's *"each"* must read *"each of the members computed"*.

## 7. Quantifier order, scope, and the edges of every range

### 7a. The smallest admissible $m$, and $m=1$

L10 states **no range for $m$ in either copy**. [L38](../results.md):503, which [results.md](../results.md):381 cites for the monotonicity, states *"For the $\mathbb{CP}^m$ family, $m\ge2$"*. The citing sentence takes the conclusion and drops the hypothesis.

At the edge: $f(1)=\dfrac{2\cdot1}{3\cdot1\cdot0}$, a **pole**, not an indeterminate form, since the numerator is $2\ne0$. So a consumer substituting $m=1$ into L10's displayed formula gets a division by zero rather than a value, with no warning in the block. Geometrically $m=1$ is $\mathbb{CP}^1=S^2$ at $n=2$, where [conventions.md](../findings/conventions.md)'s $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ evaluates to $\frac{2\cdot(-1)\cdot3\cdot4}{12}=-2$, the formula has left its range of validity, and the Weyl space is trivial for $n<4$. **So $m=1$ is genuinely outside the family**, and the omission is a citation hazard rather than a false statement.

**Verdict C10: GAP**, the range $m\ge2$ belongs in L10's own display.

*A note that is not a defect.* [L10.lean](../lean/HamiltonsCubic/Results/L10.lean) proves `cpSq_lt_threshold` for **real** $m\ge3$, which is strictly stronger than the integer statement the family needs. Harmless.

### 7b. What "one-parameter-per-factor" admits, and the step the block skips

The only definition on the record is in a reference note, [petersen-stanfield notes](../references/petersen-stanfield-2025-poincare-polynomials/notes.md):23, *"Whenever $\mathfrak k$ splits, the honest ansatz has one parameter per factor"*. So the family is the span of the block projectors, one per simple ideal plus one per central factor: $r+1$ parameters for $r$ ideals.

**That is an ansatz, and the block's argument needs an invariant space.** The chain L10 wants is: the family is one-dimensional $\Rightarrow$ its unit vector is critical. As §5 establishes, the only route to the second arrow is *"$Q$ preserves the $K$-invariants, which are one-dimensional, hence $Q(W)\in\mathbb R W$."* **That route needs the space of $K$-invariant Weyl operators to be one-dimensional, not the ansatz.** The two agree only when the block projectors already exhaust the invariants, which fails as soon as the isotropy decomposition of $\Lambda^2\mathbb R^n$ carries a repeated summand, since intertwiners between equal summands are invariant and are not block projectors.

This is a real hypothesis, and the record does close it, **for $\mathfrak u(m)$, by computation, and nowhere else.** [target.md](../findings/target.md):462 measures the nullity over the whole of $\mathrm{Weyl}_n$ and gets $1$ of $10$, $1$ of $84$, $1$ of $300$ at $m=2,3,4$; [graded-half.md](../findings/graded-half.md):492 does the same at $n=6,8,10$; and [nondegeneracy.md](../findings/nondegeneracy.md):518 records $\mathrm{Weyl}_{2m}\otimes\mathbb C$ as $U(m)$-multiplicity-free, which is exactly what would rule the repeated summand out. **For the Wolf and complex-Grassmannian families the record holds no multiplicity statement and no full-invariant nullity at all**, only [review_r15_report.md](../agent_logs/review_r15_report.md)'s ansatz-space ranks. So for three of L10's four families, "the family is one-dimensional" and "the invariants are one-dimensional" are different claims and only the first has been checked.

### 7c. Quantifier order in the sentence itself

*"Ricci-flatness together with the first Bianchi identity cuts each … family down to a one-dimensional space …, so **the** critical point in each is forced rather than found."*

The definite article does the work of an existence quantifier. Read strictly, the clause presupposes a critical point in each family and then asserts a property of it; the sentence never asserts that one exists. Existence is what H7 supplies and what §5 shows is written elsewhere. **The order is: dimension count, then (unstated) equivariance, then existence and uniqueness together**, and the block writes only the first and the last.

### 7d. The scope limiter appears in one copy of two

[results.md](../results.md):381 ends *"The lemma reaches the reducible-isotropy families and no other critical point."* **[graded-half.md](../findings/graded-half.md):472–476 (the copy the round's brief names as the source, and the file the canon points to for the proof), has no such sentence.** A consumer who follows the canon's *"**Proof:** [graded-half.md](../findings/graded-half.md)"* pointer lands on the copy without the limiter.

### 7e. The name

**Verdict C11: GAP.** *"Reducible-isotropy"* is wrong for the family that carries the headline value. The record's own table at [graded-half.md](../findings/graded-half.md):409 lists the $\mathfrak u(n/2)$ grading as acting **"irreducible over $\mathbb R$"** on $\mathbb R^n$, and [graded-half.md](../findings/graded-half.md):413 makes the same point for $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$: *"they act irreducibly on $\mathbb R^8$"*. So two of the four families named "reducible-isotropy" have **irreducible** isotropy representations; what is reducible is the isotropy **algebra**, which is non-simple. The label describes the ansatz, not the geometry, and a consumer who reads it as a representation-theoretic restriction will exclude exactly the members that carry the value. *This was already found by [REVIEW_r462.md](../reviews/REVIEW_r462.md):14 and the name was not changed.*

## 8. Comparing the forms

| Source | Heading correct? | $m\ge2$ stated? | *"exactly one per family"*? | *"every **other** family"* repair? | *"far below"*? | Scope limiter? | Four decimals? |
|---|---|---|---|---|---|---|---|
| [graded-half.md](../findings/graded-half.md):468–476 | **No** | No | No | **No** | **Yes** | **No** | Yes |
| [results.md](../results.md):128 | **No** | No | Yes | Yes | No | No | No |
| [results.md](../results.md):379–381 | **No** | No | Yes | Yes | No | Yes | No |
| [ROUND_L10.md](ROUND_L10.md):31, quoting the canonical form |, | No | Yes | Yes | No | Yes | No |
| [lean/INDEX.md](../lean/INDEX.md):260 | **Yes** | $m\ge3$ for the strict half | Not claimed | Not claimed, declared out of scope | No | Yes, explicitly | No |

**Three findings from the comparison.**

1. **No two prose copies agree.** The findings copy (the one the canon designates as the proof), is the **weakest**: it lacks the *"every other family"* repair that both [results.md](../results.md) copies carry, it alone contains the *"far below"* overstatement, and it alone lacks the scope limiter. So the canon's own proof pointer sends a consumer to the least corrected text.
2. **The transcription in [ROUND_L10.md](ROUND_L10.md):31 differs from [results.md](../results.md):381** in dropping the *"(Lemma L38)"* citation and splitting one sentence into two. Immaterial to the mathematics; recorded because a brief that quotes *"verbatim"* did not.
3. **The Lean row exists and is the only place that gets it right.** [lean/INDEX.md](../lean/INDEX.md):260 reads *"the $\mathbb{CP}^m$ family is **strictly** below $3/2$ from $m=3$ on, with $m=2$ the sole member attaining it"*, and [L10.lean](../lean/HamiltonsCubic/Results/L10.lean) proves both halves (`cpSq_lt_threshold` for $m\ge3$ and `cpSq_two_attains`), by consuming [L38](../lean/HamiltonsCubic/Results/L38.lean) rather than restating it. Its `partial` marking and its stated reason (*"the rest of L10 … needs those families' values, which are not on the record in closed form"*) are both accurate. **One correction the row could carry:** the Wolf half **is** in closed form, in [REVIEW_r461.md](../reviews/REVIEW_r461.md):27, and I confirmed that formula against three recorded values by hand in §3e. It is a reviewer's formula rather than a recorded result, so the row's *"not on the record"* is literally right, and a pointer would still be worth its line.

## 9. The closed form does have a derivation on the record, in a file L10 does not cite

I went looking for one before recording a debt, and found it. [findings/algebra.md](../findings/algebra.md):25 reads:

> *"**The $\mathbb{CP}^m$ family is Fox's, and its values follow from his norm identity with no numerics.** Lemma L10.1 constructs idempotents $S^r(\alpha)$ from an orthogonal complex structure $\alpha$ on an $r$-dimensional subspace, for every even $r$ with $2\le r\le n$, and (10.4) gives $\lvert S^r\rvert^2=6r(r-2)/((r+2)(r-1))$ in his metric. Since $\theta=1/\lvert S^r\rvert$ in the Frobenius normalisation,* $\theta(S^r)^2=\frac{2(r+2)(r-1)}{3r(r-2)}$, *reproducing this project's measured $\theta^2=(m+1)(2m-1)/(3m(m-1))$ at $r=2m$ **exactly**."*

### 9a. The source is in [references/](../references/), and I read it rather than trusting the quotation

[references/fox-2019-nonassociative-curvature-algebra/](../references/fox-2019-nonassociative-curvature-algebra/) holds the paper. Its equation (10.4) reads, verbatim from the extracted text at line 2044:

> $\langle K_r(\alpha),S_r(\alpha)\rangle=\lvert S_r(\alpha)\rvert^2_h=\frac{6r(r-2)}{(r+2)(r-1)}$

**The quotation is faithful.** Two further clauses of the same passage matter and are not quoted into [algebra.md](../findings/algebra.md):

- (10.2)'s idempotents *"are nontrivial and linearly independent when $r\ge4$, while, when $r=2$, $S_2(\alpha)$ is trivial"*. **So Fox himself carries the hypothesis $r\ge4$, i.e. $m\ge2$**, the range L10 omits (§7a) has a source.
- Clause (1) of the same lemma: *"$S_r(\alpha)\in\mathrm{MC}_W(V^*)$"*, the idempotent is a **Weyl** tensor.

### 9b. The reduction to L10's formula, by hand

Substituting $r=2m$ into $\theta^2=\dfrac{2(r+2)(r-1)}{3r(r-2)}$:

$$\frac{2(2m+2)(2m-1)}{3\cdot2m\cdot(2m-2)}=\frac{2\cdot2(m+1)(2m-1)}{3\cdot2m\cdot2(m-1)}=\frac{4(m+1)(2m-1)}{12m(m-1)}=\frac{(m+1)(2m-1)}{3m(m-1)}.$$

**Exactly L10's closed form.** And [algebra.md](../findings/algebra.md)'s six spot values check against §3a's boxed rewriting $f(m)=\tfrac23+\tfrac{3m-1}{3m(m-1)}$: $r=4,6,8,10,12,14$ give $m=2,\dots,7$ and $f=\tfrac32,\tfrac{10}9,\tfrac{35}{36},\tfrac9{10},\tfrac{77}{90},\tfrac{52}{63}$, all six of which I evaluated independently and all six of which agree.

### 9c. The defect in the derivation, and why it does not withdraw it

**Located.** *"Since $\theta=1/\lvert S^r\rvert$ in the Frobenius normalisation"*, [algebra.md](../findings/algebra.md):25, immediately before the display.

**Exhibited concretely.** Taken literally with Fox's $\lvert S^r\rvert^2_h$, that sentence gives $\theta^2=\dfrac{(r+2)(r-1)}{6r(r-2)}$, which at $r=4$ is $\dfrac{6\cdot3}{6\cdot4\cdot2}=\dfrac38$, **not $3/2$, and not the display's value, which is four times larger.** So a conversion $\lvert\cdot\rvert_h=2\lvert\cdot\rvert_{\mathrm{Frob}}$ is used between the sentence and the display and is stated nowhere. This is precisely the class of error [conventions.md](../findings/conventions.md) tables under *"Norms and pairings, where builds have disagreed"*, whose own entry records that misplacing a factor *"inflates every $\theta$ by $\sqrt2$, and has cost a cycle"*.

**Argued the opposite.** The display is not in doubt: it reproduces six exact rationals, three of which ($3/2$, $35/36$, and the $m=8$ case $45/56$ via the same formula) the record obtained by wholly independent constructions. So the missing constant is a transcription gap in one sentence rather than an error in the result, and the charitable reading (that "Frobenius normalisation" is shorthand for "after converting Fox's metric to the record's"), is almost certainly what was meant. **I do not supply the conversion**; establishing $\lvert\cdot\rvert_h=2\lvert\cdot\rvert_{\mathrm{Frob}}$ from Fox's conventions is a derivation, and a verifier who supplied it would be handing the record a fresh proof under the letterhead of a check.

**Verdict C3: GAP.** The closed form is derived on the record from a source held and read, and reduces to L10's display exactly. What is missing: **L10 cites none of it**, neither copy of the block mentions Fox, [algebra.md](../findings/algebra.md), or an idempotent, and the derivation's normalisation constant is unstated. [ungraded-slack.md](../findings/ungraded-slack.md):258 records the same disconnection from the other side: *"THE $\mathbb{CP}^m$ HALF DUPLICATES LEMMA L10, same formula, two numbers, neither block citing the other."*

### 9d. What Fox does and does not rescue

**Does:** existence of the critical point in the $\mathbb{CP}^m$ family, for every even $r$ with $4\le r\le n$, at every $n$, with no dimension count, no Bianchi computation and no sampled member. An idempotent of $(\mathrm{MC}(V^*),*)$ lying in $\mathrm{MC}_W(V^*)$ **is** a critical point, by [algebra.md](../findings/algebra.md):31's *"critical points of $P$ are exactly the idempotents"*. So the conclusion the block draws for its headline family is a theorem in the literature.

**Does not:** the **uniqueness** half, Fox's own closing remark, quoted at [algebra.md](../findings/algebra.md):31, is that *"it would be interesting to describe completely the $G$-orbits of idempotents"*, i.e. the classification is open, and it says nothing about the Wolf or complex-Grassmannian families. **So §6's debt stands, narrowed: it is a debt on the stated mechanism and on "one per family", and on the other three families, rather than on the $\mathbb{CP}^m$ conclusion.**

## 10. The remaining sentences of the block, each checked

### 10a. *"Three of these are ungraded, with slack between $0.57$ and $0.96$"*, C9

Against [graded-half.md](../findings/graded-half.md):452 and [review_r15_report.md](../agent_logs/review_r15_report.md)'s table:

| point | $S$ | graded? |
|---|---|---|
| $\mathbb{HP}^2$, $\theta=1.115547$ | $2.2\times10^{-16}$ | graded |
| $\mathbb{HP}^3$, $\theta=0.852944$ | $0.6734$ | ungraded |
| $\mathrm{Gr}_{\mathbb C}(2,2)$, $\theta=0.720082$ | $0.5714$ | ungraded |
| $\mathrm{Gr}_{\mathbb C}(2,3)$, $\theta=0.596068$ | $0.9631$ | ungraded |

*"Three of these are ungraded"*, **correct**: three of the four listed values, the graded one being the largest. The slack range is $[0.5714,\,0.9631]$; the block writes *"between $0.57$ and $0.96$"*, whose upper endpoint is rounded **down** past the actual maximum, so read as a literal interval the sentence excludes $0.9631$. A consumer taking $0.96$ as an upper bound on the slack of these points is wrong by $0.0031$.

**Verdict C9: PROVEN**, with one endpoint rounded the wrong way. *Recorded rather than dismissed because [graded-half.md](../findings/graded-half.md):219 propagates the figures as the interval "$0.57$–$0.96$".*

### 10b. *"so the rival maximizer is the first member of this family rather than an isolated exception"*

**No finding: correct, and independently supported.** $m=2$ is the smallest admissible index by both L38's range and Fox's $r\ge4$, its value is $\sqrt{3/2}$ by §2a, and [conventions.md](../findings/conventions.md)'s $M(n)$ row fixes the rival maximizer at $\sqrt{3/2}$ via padded $W_{\mathbb{CP}^2}$. **One reading to guard against**: the family's members live at different ambient dimensions, $n=2m$, whereas the rival maximizer enters the programme at every $n$ as the *padded* operator. The identification is of the unpadded $m=2$ member with the unpadded $\mathbb{CP}^2$ operator, and the padding step is [L44](../findings/problem.md)'s, not L10's.

### 10c. Two families meet at $m=2$, and L10 mentions only one

[L38](../results.md):503 records that the $(\mathfrak{su}(m),\mathfrak{so}(m))$ Kähler family also peaks at $\tfrac32$ at $m=2$, *"where the second family's member is $W_{\mathbb{CP}^2}$ itself"*. Checking the two agree there, by hand: that family's $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ gives $\frac{2\cdot3}{1\cdot4}=\frac64=\frac32$ at $m=2$. **They do agree.** So the threshold is attained by two of the record's named families at their common first member, and L10 names one of them. Not a defect in L10; a scope fact a consumer of L10 alone will not have.

## 11. The named trap, each citable claim read alone, as a consumer would

**This record's signature failure is a correction landing beside the statement it corrects. L10 is a clean instance, and the correction has landed beside it four separate times.**

| Where the correction lives | What it says | Did the statement change? |
|---|---|---|
| [REVIEW_r461.md](../reviews/REVIEW_r461.md):25 | *"CAVEAT 1: the block TITLE says 'all below the threshold'; the $m=2$ member EQUALS the threshold $\sqrt{3/2}$ (the body says so). Title overstates."* | **No** |
| [REVIEW_r462.md](../reviews/REVIEW_r462.md):14 | *"DEFECT: the TITLE says 'all below the threshold' but $m=2$ sits EXACTLY AT the threshold $\sqrt{3/2}$ … 'All sit far below $\sqrt{3/2}$' is also false as written"* | **No** |
| [LEDGER.md](../findings/LEDGER.md):1021 | *"L10 states that the reducible-isotropy families sit below the threshold, which is a different claim (and $m=2$ sits **at** $\sqrt{3/2}$ rather than below it"*) and the LEDGER **used** this to resolve a citation dispute against [r551](../reviews/REVIEW_r551.md) | **No** |
| [lean/INDEX.md](../lean/INDEX.md):260 | *"$m=2$ the sole member attaining it"*, and [L10.lean](../lean/HamiltonsCubic/Results/L10.lean) proves it both ways | **No** |

**And the index row is the worst of it.** [findings/INDEX-results.md](../findings/INDEX-results.md):25 reads, in full:

> *"**10** | Lemma | **Gate 2 passed** ([r461](../reviews/REVIEW_r461.md), [r462](../reviews/REVIEW_r462.md)), numbers confirmed with two hypothesis caveats. the reducible-isotropy families carry one critical point each, all below the threshold"*

A consumer reading that row alone gets: a **Gate 2 passed** stamp; a false sentence; the word *"caveats"* with **no statement of what they are**; and two links they must open to discover that one of the caveats is that the sentence they were just handed is wrong. **The stamp and the defect are on the same line, and the stamp is what a consumer reads first.**

Two further things a consumer reading alone would not learn, both from [LEDGER.md](../findings/LEDGER.md):199–205:

- The Gate 2 that the index reports as *passed* is annotated there: *"**NEITHER REVIEWER FILED A REPORT; BOTH WERE SALVAGED FROM THEIR LOGS.** The verdicts are one reviewer's working notes apiece, which is the weight they carry."*
- The LEDGER's own row for result 10 says *"[r462](../reviews/REVIEW_r462.md) records a defect in the statement rather than the arithmetic"*, **naming that a defect exists without saying which statement or what the defect is.** So even the ledger entry that flags the problem does not carry it.

**Read alone, the following are citable and false:** [graded-half.md](../findings/graded-half.md):468, [results.md](../results.md):128, [results.md](../results.md):379, [INDEX-results.md](../findings/INDEX-results.md):25, and [graded-half.md](../findings/graded-half.md):219's back-reference, which reproduces the heading inside its anchor link.

## 12. The gap between what is proven and what is used, and what a consumer may cite

| Component | Status |
|---|---|
| $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ for $\mathbb{CP}^m$, $m\ge2$ | **Derived** at [algebra.md](../findings/algebra.md):25–27 from [Fox](../references/fox-2019-nonassociative-curvature-algebra/) (10.4), a source held and read; reduces to the display exactly (§9b), over one unstated normalisation constant |
| Strictly decreasing, infimum $2/3$ not attained | **Proven**, §3b–3c, by hand here and independently at [r461](../reviews/REVIEW_r461.md) |
| $=\tfrac32$ at $m=2$, $<\tfrac32$ for $m\ge3$ | **Proven**, and machine-checked at [L10.lean](../lean/HamiltonsCubic/Results/L10.lean) |
| A critical point exists in the $\mathbb{CP}^m$ family | **Proven in the literature** (Fox's $S_r(\alpha)$ is an idempotent in $\mathrm{MC}_W(V^*)$ for even $r\ge4$), by a route L10 does not cite |
| Each family is a one-dimensional space of Weyl operators | **Computed** at $\mathfrak u(m)$ for $m\le6$ and at one member each of the other three families. **No argument at general parameter** |
| A critical point exists in the Wolf and Grassmannian families | **Computed only.** No literature route, no argument |
| Exactly one critical point per family | **False as written** (§4); *"one up to sign"* is a restatement of the dimension count above |
| The four Wolf/Grassmannian $\theta$ values | **Constructed numerically**, and confirmed here only as decimals of the record's own rationals |
| Wolf family below the threshold at every $m$ | **Not on the record.** [r461](../reviews/REVIEW_r461.md):27's closed form covers it and checks against three recorded values by hand (§3e), but lives in a reviewer's working notes |
| Complex-Grassmannian family below the threshold at every $(p,q)$ | **Open.** [r461](../reviews/REVIEW_r461.md):29: *"Gr_C family open"* |

**What a consumer may cite from L10, and in these words:**

1. *"On the $\mathbb{CP}^m$ family, $m\ge2$, $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$; it is strictly decreasing in $m$ with infimum $2/3$, and its maximum is **exactly** $\theta=\sqrt{3/2}$, **attained at $m=2$** and strictly below for every $m\ge3$."*
2. *"Four members of the Wolf and complex-Grassmannian families have recorded values $\sqrt{56/45}$, $\sqrt{275/378}$, $\sqrt{14/27}$ and $\sqrt{275/774}$, each below $\sqrt{3/2}$; these are constructed values, not proved ones."*
3. *"Three of those four are ungraded, with slack $0.5714$, $0.6734$ and $0.9631$."*

**What a consumer may not cite:** any form of *"all below the threshold"*; *"one critical point each"* or *"exactly one per family"*; *"far below"*; any statement about the Wolf or complex-Grassmannian families at unlisted parameters; and the claim that the one-dimensionality holds at every $m$.

## 13. What would break it, and what I did to look

**For the heading, "all below the threshold": the falsifier is a member of one of the four families with $\theta\ge\sqrt{3/2}$.** It exists, it is $W_{\mathbb{CP}^2}$, and it is already on this record in five places. I looked by evaluating the block's own closed form at its own smallest admissible index, which the block's own next clause states the answer to. Nothing had to be constructed.

**For the corrected statement, "every *other* family's point sits below the threshold": the falsifier is a Wolf or complex-Grassmannian member with $\theta\ge\sqrt{3/2}$.** What I did to look:

- Read [findings/INDEX-values.md](../findings/INDEX-values.md) end to end for every recorded value of these spaces: four, the largest $\sqrt{56/45}=1.1155467$, all below.
- Evaluated [r461](../reviews/REVIEW_r461.md):27's Wolf closed form by hand at $m=2,3,4$ (§3e), getting $56/45$, $275/378$ and $5/9$, matching three independently recorded values and decreasing. **So no Wolf falsifier exists if that formula is right**, which is a reviewer's claim and not the record's.
- Searched the record for a complex-Grassmannian closed form covering general $(p,q)$: **there is none**, in [results.md](../results.md), in [findings/](../findings/), or in the three reports the record cites. [r461](../reviews/REVIEW_r461.md):29 says so itself, *"Gr_C family open"*.

**So the one place an unexcluded falsifier could live is $\mathrm{Gr}_{\mathbb C}(p,q)$ at $(p,q)$ beyond $(2,2)$ and $(2,3)$**, and the record holds neither a value nor a bound there. Settling it would be computation, which this programme's standing rule places behind explicit approval; naming it is the deliverable here.

**For "one critical point each": the falsifier is a second unit Weyl operator in a family, not a multiple of the first.** [review_r15_report.md](../agent_logs/review_r15_report.md):117 records that the Ricci-flat circle of each $\mathfrak u(m)$ family carries **three** stationary points and that the two extra ones violate the first Bianchi identity, so within the Bianchi-satisfying set none was found, **at the members that were computed.** At $m\ge7$, and at unlisted Wolf and Grassmannian parameters, nothing has been looked for by anyone.

## Verdict

**BROKEN.**

The mathematics of the $\mathbb{CP}^m$ half is sound and I reproduce every recorded number exactly by hand. What is broken is what the record hands a consumer:

- **C1**, the heading *"all below the threshold"*, is false at the family's own first member, in all three of its copies and in the index row that stamps it Gate 2 passed. The correction has been written four times, beside the statement, and the statement has never changed.
- **C6**, *"one critical point each"*, is false by a factor of two against the record's own $n=4$ convention, and true only in the *"up to sign"* form its own source used, in which form it restates the dimension count rather than proving anything about $P$.

**Standing behind them: C3's gap**, the closed form's only derivation is in [algebra.md](../findings/algebra.md), which L10 does not cite, over an unstated normalisation constant, **and C7's hypothesis-debt**, which names exactly what is owed: *for every admissible parameter, that the space of isotropy-invariant Weyl operators is one-dimensional*, for $U(m)$ at $m\ge7$ and for the Wolf and complex-Grassmannian isotropies at every parameter beyond the single members computed.

**The narrowest repair that makes every citable line true** is to replace *"all below the threshold"* with *"the $\mathbb{CP}^m$ family attaining the threshold at $m=2$ and every other point below it"* in all three headings and the index row, and *"one critical point each"* with *"one up to sign"*, after which the surviving claim is the one §12 sets out. **I have made no such edit**: this is a check, and the repair belongs to whoever owns the statement.
