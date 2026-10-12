# Review r607, Lemma L55, the min-entry bound

*Reviewer A of an independent pair on identical briefs; r608 is the other. Analysis only, no search, sweep or census was run. One screen was taken, on matrices I constructed for the purpose, and it is labelled as a screen where it is used.*

**Verdict: GAP.** The inequality is **CONFIRMED**, re-derived cold, with the constant $n(n-1)(n-2)$ correct under this record's ordered-pair reading of $t$ ([conventions.md](../findings/conventions.md), "The vertex matrix"). The equality case (the half the block states as "the extremizers being **exactly** the perfect matchings"), is **not proved by the argument on the record**, and as stated it is **false without a sign condition the block omits**. The record may cite the inequality freely; it may not yet cite "exactly".

Three separate defects sit alongside the mathematics: the block's header still carries the pointer that [ELIM-halves](ELIM-halves.md) W5 refuted, its provenance sentence is false against `git log`, and the proof note's account of what was missing is overstated by one file.

---

## 1. The inequality, confirmed, and it consumes only two of the three hypotheses

### The derivation, from the definitions

Let $K$ be hollow with $K\mathbf1=0$, and let $m:=\lvert\min_{a\ne b}K_{ab}\rvert$, the minimum over **all** off-diagonal entries.

Fix any row $a$ and write $x_b:=K_{ab}$ for $b\ne a$. Hollowness makes these $n-1$ numbers the whole row, and $K\mathbf1=0$ gives $\sum_{b\ne a}x_b=-K_{aa}=0$. Every entry of $K$ is $\ge-m$, so $x_b\ge-m$ for each $b$, and therefore $x_b=-\sum_{b'\ne b}x_{b'}\le(n-2)m$.

The feasible set is $P_m=\{x\in\mathbb R^{n-1}:\sum_bx_b=0,\ x_b\ge-m\}$. Substituting $y_b=x_b+m\ge0$ turns it into $\{y\ge0,\ \sum y_b=(n-1)m\}$, the standard simplex, scaled. Its $n-1$ extreme points each put the whole mass on one coordinate: $y=(n-1)m\,e_b$, i.e. $x_b=(n-2)m$ and $x_{b'}=-m$ for $b'\ne b$. In particular $P_m$ is **compact**, which the block's phrase "the row polytope" asserts without saying why; the upper bound $x_b\le(n-2)m$ derived above is exactly what supplies it.

$s_a(x)=\lVert x\rVert^2$ is convex, so $\max_{P_m}s_a$ is at an extreme point, and all $n-1$ extreme points give the same value:

$$s_a\ \le\ (n-2)^2m^2+(n-2)\,m^2\ =\ (n-2)m^2\big[(n-2)+1\big]\ =\ (n-1)(n-2)\,m^2 .$$

Summing over the $n$ rows, and using that $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ is the **ordered** sum, so $t=\sum_as_a$ with no factor of $2$ to insert or remove:

$$t\ \le\ n(n-1)(n-2)\,m^2\qquad\Longleftrightarrow\qquad m\ \ge\ \sqrt{\frac t{n(n-1)(n-2)}}. \qquad\blacksquare$$

The constant is therefore $n$ rows $\times$ $(n-1)$ entries $\times$ $(n-2)$ from the one entry forced up to $(n-2)m$, the three factors have distinct origins and none of them is a double-count. **Had $t$ been read as the unordered sum $\sum_{a<b}K_{ab}^2$**, as [conventions.md](../findings/conventions.md) warns is the standing ambiguity, the correct constant would be $\tfrac12n(n-1)(n-2)$. The block is consistent with the record's ordered reading; the two are one factor of $2$ apart and the block does not say which it uses. *Recommend the block quote the convention, per [conventions.md](../findings/conventions.md)'s own rule that conventions are quoted rather than restated.*

### Where the hypotheses go, and symmetry is not one of them

| hypothesis | where the **inequality** uses it |
| --- | --- |
| hollow | twice: the row has exactly $n-1$ free entries, and $\sum_{b\ne a}K_{ab}=-K_{aa}=0$ rather than $=-K_{aa}$ |
| zero row sums | the equality constraint defining $P_m$, at **every** row |
| symmetric | **nowhere** |

The derivation reads rows only and never transposes. **The inequality holds verbatim for any hollow $n\times n$ matrix with zero row sums, symmetric or not**, it is strictly stronger than the block states. Symmetry is consumed by the equality case alone (§2), which is a point worth recording rather than losing: it tells a consumer that the bound survives any perturbation that breaks symmetry while keeping hollowness and $K\mathbf1=0$.

### The absolute value, forced, and cosmetic for $K\ne0$

Each row's $n-1$ entries sum to $0$, so each row has an entry $\le0$; hence $\min_{a\ne b}K_{ab}\le0$ always. If the minimum is $0$ then every off-diagonal entry is $\ge0$ with every row summing to $0$, forcing $K=0$. So **for $K\ne0$ the minimum is strictly negative** and $m=-\min_{a\ne b}K_{ab}$; the bars do no work. This uses hollowness and zero row sums, not symmetry, and it does not need $K\ne0$ to be assumed from criticality, it is the two-line argument above. *The record's usual route to a forced sign is $\operatorname{tr}K=0$ with $K\ne0$; that route bounds the spectrum, not the entries, so it is the wrong tool here and the entrywise argument is the right one.* **The block states neither.**

### The block's own wording makes the summation step a non-sequitur

The block opens *"Fix the row $a$ achieving the minimal entry and let $m=\lvert\min_bK_{ab}\rvert$"*, a minimum **over $b$ within that one row**. Under that reading the bound $s_a\le(n-1)(n-2)m^2$ is established for the fixed row only, and *"Summing over rows, $t=\sum_as_a\le n(n-1)(n-2)m^2$"* does not follow: nothing said so far constrains the entries of the other $n-1$ rows.

The repair is one word and the mathematics survives it intact, because $a$ was chosen to achieve the *global* minimum, $m$ coincides with the global $\lvert\min_{a\ne b}K_{ab}\rvert$, and $K_{a'b}\ge-m$ then holds in every row. But that identification is the load-bearing step of the summation and the proof never makes it. **The "fix the row" scaffold is vestigial and should be deleted**: define $m$ globally at the outset and the argument is uniform across rows with nothing to justify.

*This is a defect of the write-up, not of the claim. It is recorded because it is precisely the shape of gap this record's audits keep finding, a quantifier that moves silently between two lines.*

---

## 2. The equality case, the half that is not proved, and is false as stated

### 2a. Attainment: correct, and I confirm the arithmetic

Take $\sigma$ a fixed-point-free involution on $\{1,\dots,n\}$ ($n$ even) and set $K_{ab}=(n-2)c$ for $b=\sigma(a)$, $K_{ab}=-c$ for $b\ne a,\sigma(a)$, $K_{aa}=0$.

- **Hollow** by construction; $\sigma(a)\ne a$ so the large entry never lands on the diagonal.
- **Symmetric** because $\sigma$ is an involution: $b=\sigma(a)\iff a=\sigma(b)$.
- **Zero row sums**: $(n-2)c+(n-2)(-c)=0$.
- **Norm**: the matching carries $n$ ordered entries at $(n-2)c$ and the rest $n(n-1)-n=n(n-2)$ ordered entries at $-c$, so
$$t=n(n-2)^2c^2+n(n-2)c^2=n(n-2)c^2\big[(n-2)+1\big]=n(n-1)(n-2)\,c^2 .$$
- With $c>0$ the minimum entry is $-c$, so $m=c$ and $m^2=t/(n(n-1)(n-2))$ **exactly**. The bound is met.

The arithmetic closes. *Screened at $n=4,6,8$ on matrices built for the purpose: row sums $0$, $t=24,120,336$ against $n(n-1)(n-2)=24,120,336$, and $\lvert\min\rvert$ equal to the bound to machine precision. Reported as a screen of the arithmetic above, not as evidence.*

### 2b. **The sign condition $c>0$ is missing, and without it "exactly" is false**

The block writes the extremizer as *"$K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere"*, with no condition on $c$. Take $c<0$. That matrix is still hollow, still symmetric, still has zero row sums, every hypothesis of the Lemma. But now the minimum entry is $(n-2)c$, not $-c$, so $m=(n-2)\lvert c\rvert$ while $t=n(n-1)(n-2)c^2$ is unchanged, and

$$\frac{m^2}{t/(n(n-1)(n-2))}=(n-2)^2 .$$

The bound is missed by a factor $n-2$. *Screened: at $n=4,6,8$ with $c=-1$ the constructed matrix satisfies every hypothesis and gives $\lvert\min\rvert=2,4,6$ against a bound of $1$.*

So the displayed family contains non-extremizers, and the statement "the extremizers being **exactly** the perfect matchings" is **false on its face** until $c>0$ is added. This is one of the brief's "every hedging clause" items paying out: **"exactly"** is doing work the statement cannot support.

*The same omission is in [results.md:192](../results.md#L192) and [results.md:554](../results.md#L554), which reproduce the family without the sign.*

### 2c. Uniqueness: two steps of the equality analysis are absent

The converse (that nothing outside the family attains the bound), needs the equality case of every inequality used. Two were used, and the block tracks neither.

**(i) The convexity step needs *strict* convexity, and the block asserts only convexity.** *"the extreme point maximising the convex functional $s_a$"* establishes that the maximum **is attained at** an extreme point. It does not establish that the maximum is attained **only** there, a merely convex function can be constant on a whole face, and then equality would not pin the row. The fact needed is that $s_a(x)=\lVert x\rVert^2$ is **strictly** convex: if $x=\tfrac12(y+z)$ with $y\ne z$ in $P_m$ then $\lVert x\rVert^2<\tfrac12(\lVert y\rVert^2+\lVert z\rVert^2)\le\max_{P_m}s_a$, so no non-extreme point is a maximiser. One line, true, and **owed**.

**(ii) The step to a fixed-point-free involution is where symmetry enters, and it is asserted rather than argued.** The block writes *"equality forces every row extreme (one entry $(n-2)c$, the rest $-c$) which pairs the rows into a fixed-point-free involution"*. "Which pairs the rows" is the whole content and is unproved. Every-row-extreme defines a map $\sigma:a\mapsto$ the column carrying $a$'s large entry, with $\sigma(a)\ne a$, that alone is only a **fixed-point-free permutation**, which exists at every $n\ge2$ including odd $n$. Nothing so far forbids a $3$-cycle.

The missing argument, which I supply: symmetry gives $K_{\sigma(a)a}=K_{a\sigma(a)}=(n-2)c$, and since row $\sigma(a)$ is also extreme its unique large entry is at column $a$, unique because $(n-2)c\ne-c$ whenever $c\ne0$ and $n\ne1$. Hence $\sigma(\sigma(a))=a$. **That is the only place symmetry is used in the whole Lemma**, and it is the step the write-up skips.

*The concrete witness for why the step is needed: at $n=3$ the $3$-cycle $\sigma=(123)$ gives $K_{12}=K_{23}=K_{31}=c$ and $K_{13}=K_{21}=K_{32}=-c$, every row extreme, every row sum zero, hollow, and **antisymmetric**, so ruled out by symmetry and by nothing else in the block's chain.*

**Both gaps are reachable**, in two lines each, from material already stated. This is a **GAP**, not a refutation: I believe the uniqueness claim is true once $c>0$ is added, and I have supplied the two missing lines above. But it is not proved by what stands in [diagonal-half.md:410](../findings/diagonal-half.md#L410).

### 2d. Parity, the answer, and what the record should say

| $n$ | status |
| --- | --- |
| $n\le2$ | the constant $n(n-1)(n-2)$ is $0$; the statement is ill-formed and needs $n\ge3$ |
| $n=3$ | $\mathcal D_3=\{0\}$: hollow, symmetric, zero row sums forces $K_{12}=K_{13}=K_{23}=0$, so $t=0$ always and the Lemma is **vacuous** |
| even $n\ge4$ | **attained**, exactly on the matchings with $c>0$ |
| odd $n\ge5$ | **true and unattained for $K\ne0$**; the sharp constant is **open on this record** |

**Strictness at odd $n$ is a consequence of the uniqueness analysis, not an independent fact**, it follows from (i) strict convexity plus (ii) the involution step, which is exactly why those two owed lines matter. Given them: equality forces a fixed-point-free involution on $n$ points, which exists only at even $n$.

**One degenerate exception the record misses.** $K=0$ gives $t=0$ and $m=0$, so the bound reads $0\ge0$, **equality, at every $n$, odd included, and $K=0$ is not a perfect matching**. Both halves of the "exactly" claim therefore need $K\ne0$ (equivalently $t>0$). [results.md:554](../results.md#L554)'s flat assertion *"and at odd $n$ the bound is strict"* is **false at $K=0$**, and [diagonal-half.md](../findings/diagonal-half.md)'s "exactly the perfect matchings" is false there too. Trivial, but this record's convention allows $t=0$ ($t\le2$, per [conventions.md](../findings/conventions.md)), so the exclusion has to be written.

**The sharp odd-$n$ constant is open, and I can say how far the record is from it.** Normalising $m=1$, the odd-$n$ question is: maximise the convex $\lVert K\rVert_F^2$ over the polytope $\{K$ symmetric, hollow, $K\mathbf1=0$, $K_{ab}\ge-1\}$, so the answer sits at a vertex of that polytope and is a finite combinatorial optimisation. Two structural facts come free from the analysis above and cut it down:

1. **Any entry equal to $(n-2)$ forces both of its rows extreme.** If $K_{ba}=(n-2)$ then row $b$'s remaining $n-2$ entries sum to $-(n-2)$ with each $\ge-1$, so each is exactly $-1$, row $b$ is extreme. So the extreme rows are closed under $\sigma$ and, by 2c(ii), come in matched pairs: **the number of extreme rows is even.**
2. **At odd $n$ at least three rows are non-extreme.** The count of extreme rows is even, so at odd $n$ at least one row is non-extreme; and exactly one is impossible. If rows $1,\dots,n-1$ are extreme and matched among themselves, each has $K_{an}=-1$, so row $n$ is all $-1$ and sums to $-(n-1)\ne0$. So the non-extreme count is odd and $\ge3$.

That yields $t\le(n-3)(n-1)(n-2)+\big(\text{three constrained rows}\big)$, a strict improvement on $n(n-1)(n-2)$, but **not the sharp constant**, which would need the optimisation over the residual $3$-row configurations. **Deciding the sharp odd-$n$ value is exactly the kind of item this programme's analysis-only footing sends back for approval**: a vertex enumeration would settle small odd $n$ and suggest the pattern, and I have not run one. What such a run would decide: whether the odd-$n$ extremal ratio has a closed form in $n$ (which would upgrade the Lemma to both parities) or is irregular (which would leave it as a strict-inequality-only statement at odd $n$). **I state it as open and stop.**

*The brief's warning is well aimed here: a neighbouring result was just refuted for carrying an even-$n$ value at both parities. L55 does **not** commit that error, it is correctly qualified "sharp for even $n$" in [diagonal-half.md](../findings/diagonal-half.md), [results.md](../results.md) and [report/sections/06b-bispectral.tex:179](../report/sections/06b-bispectral.tex#L179) alike. **What it does instead is leave the odd case unstated**, which is the milder failure.*

---

## 3. What it feeds, and the consumers need only the inequality

Every citation of L55 outside the block itself:

| site | what it takes |
| --- | --- |
| [results.md:192](../results.md#L192), [results.md:554](../results.md#L554) | restates the whole Lemma, both halves |
| [REVIEW_r340.md:66](REVIEW_r340.md#L66) | identifies the $\mathrm{SRG}(v,1,0,0)$ point as *"Lemma L55's extremiser"*, i.e. the maximal torus $\mathfrak{so}(2)^{n/2}$ |
| [report/sections/06b-bispectral.tex:179](../report/sections/06b-bispectral.tex#L179), [09-status.tex:116](../report/sections/09-status.tex#L116) | status-table entries |
| [plan-verification.md:77](../plan-verification.md#L77) | the unchecked row this audit answers |

**No findings file consumes L55 as a step.** [r340](REVIEW_r340.md)'s use is the only substantive one, and it needs **attainment only** (that the matching matrix *is* an extremiser, which §2a confirms), never uniqueness. So:

- **The inequality is safe to cite anywhere**, and is in fact stronger than advertised (symmetry-free, §1).
- **"Exactly" is currently cited by nothing that needs it.** The exposure is confined to [results.md](../results.md) and [report/](../report/) restating it, so the fix is a statement repair rather than a repair rippling through consumers.

[ELIM-halves:39](ELIM-halves.md#L39) already records the right frame for the Lemma's role (*"true, sharp, and needs no criticality"*) and [results.md:554](../results.md#L554) is candid that it *"carries no information about $\theta$ on its own"*. Both correct.

---

## 4. Provenance and pointers, three defects, checked against `git log`

**(a) The refuted pointer is still in the block, in bold, directly above the proof that replaced it.** [diagonal-half.md:402](../findings/diagonal-half.md#L402) reads:

> *"The statement is below; **the argument is in this file under "It does NOT survive off the diagonal locus, and the failure is systema"**."*

[ELIM-halves W5](ELIM-halves.md#L154) refuted this pointer, and the fix at `18a0ace6` (2026-09-01) supplied the proof **without deleting the sentence that sends the reader elsewhere**. I checked the named section directly: [diagonal-half.md:257](../findings/diagonal-half.md#L257), *"It does NOT survive off the diagonal locus, and the failure is systematic"*, is about $K^2-\lambda K\succeq0$ and the weighted Laplacian, and contains **no min-entry argument**, W5's reading is correct, and still current. The block now contradicts itself in consecutive paragraphs. **This is the brief's point exactly: a repair that lands a proof is not a repair that removes the false pointer.**

**(b) *"the mathematics has always been in this file"* is false.** `git log -S"n(n-1)(n-2)" -- findings/diagonal-half.md` returns exactly two commits: `86621751` (2026-08-31, *"number the 24 results that only the report had numbered"*) (the commit that created the block) and `18a0ace6` (2026-09-01), which added the proof. **Before 2026-08-31 the min-entry bound was not in the file at all.** The sentence should read that the result was numbered in [report/](../report/) and the block was created here on 2026-08-31 carrying the statement.

*This makes seven false provenance notes against three clean ones in this record's running count. The brief's instruction to check rather than assume in either direction is what caught it.*

**(c) *"so the proof was absent from the record"* is overstated by one file.** The proof note at [diagonal-half.md:410](../findings/diagonal-half.md#L410) says the proof was absent from **the record**. It was absent from [findings/](../findings/), but [report/sections/06b-bispectral.tex:156](../report/sections/06b-bispectral.tex#L156) has carried a proof since `052c33b7` (2026-08-26), five days before the block was even created. The accurate statement is *absent from [findings/](../findings/)*.

**A bonus finding in that report proof, since I read it to check (c).** Its route is genuinely independent and reaches the same constant, which is a real corroboration of §1: it bounds one row via *"some row has $s_a\ge t/n$"* rather than summing all rows, and gets $\sqrt{t/(n(n-1)(n-2))}$ by the same arithmetic. **But its displayed vector is the wrong extreme point.** It says *"the configuration minimizing $\lvert\min y\rvert$ is $M-1$ equal negatives against a single positive"* (correct) and then displays $y=(\alpha,\dots,\alpha,-(M-1)\alpha)$, which is $M-1$ **positives** against a single negative. That configuration **maximises** $\lvert\min y\rvert$, at $\sqrt{s(M-1)/M}$, not minimises it. The prose is right, the display is its mirror image, and the stated $s=M(M-1)\alpha^2$ happens to hold for both, which is why it has survived. *Recorded, not fixed, this audit does not edit [report/](../report/).*

**All other pointers resolve.** [ELIM-halves.md](ELIM-halves.md) exists and S4 says what the proof note attributes to it; [ELIM-halves:204](ELIM-halves.md#L204)'s summary line *"statement and sharpness both correct (proof supplied at S4)"* is accurate as to the statement's inequality half, and inherits §2b's and §2c's gaps as to "exactly". No script path is cited by this block.

---

## 5. What is owed

Ordered by cost. Items 1–3 are the mathematics; 4–6 are the record.

1. **Add $c>0$ to the extremizer family**, in [diagonal-half.md:408](../findings/diagonal-half.md#L408), [results.md:192](../results.md#L192) and [results.md:554](../results.md#L554). Without it the word "exactly" is false, with the $c<0$ matrix as witness (§2b).
2. **Exclude $K=0$**, i.e. state the equality case and the odd-$n$ strictness for $t>0$ (§2d).
3. **Write the two missing lines of the equality analysis**, strict convexity of $\lVert\cdot\rVert^2$ pinning the maximiser to extreme points, and the symmetry step from fixed-point-free permutation to involution (§2c). Both are supplied above verbatim.
4. **Delete the refuted pointer** at [diagonal-half.md:402](../findings/diagonal-half.md#L402) (§4a) and correct *"the mathematics has always been in this file"* (§4b) and *"absent from the record"* (§4c).
5. **Record that the inequality needs only hollowness and zero row sums** (§1), and that the minimum is forced $\le0$ by those same two (§1). Both strengthen the statement at no cost.
6. **State the odd-$n$ position explicitly** (true, unattained for $K\ne0$, sharp constant open) and note $n=3$ vacuous, $n\ge3$ required (§2d). **The sharp odd-$n$ value needs a computation this footing does not authorise; it is named, not started.**

**Bottom line, in the form the brief asks for: the inequality holds and is stronger than stated; the equality case is unproven as written and false as written.** The record may cite the display. It may not yet cite "exactly the perfect matchings".
