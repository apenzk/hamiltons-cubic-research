# Review r625, Lemma L93, the min-entry bound, and its collision with Lemma L55

**Reviewer A of a pair on identical briefs (the other takes r626). Cold derivation from the definitions; analysis only, no computation run.**

## Verdict: REFUTED as a block, the inequality is right, the number is not, and three surrounding claims are false

The mathematics of [L93](../findings/bispectral.md) is correct and is *already numbered 55*. The block should be struck and replaced by a pointer. Independently of the duplication, the block carries one false numerical claim with an explicit witness against it, one paragraph that is impossible on its face, and an asserted equality case.

| item | verdict |
|---|---|
| duplication with [L55](../findings/diagonal-half.md) | **same result, same constant, same extremiser**, 55 survives, 93 is struck |
| the inequality $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$ | **CONFIRMED**, and stronger than stated: symmetry is never used |
| the extremal-configuration step | **true but ASSERTED**, two lines are owed, and [L55](../findings/diagonal-half.md) already carries them |
| the constant $n(n-1)(n-2)$ | **CONFIRMED**, no double count, because $t$ is the ordered-pair sum |
| equality forces a perfect matching | **ASSERTED, never argued**; the displayed family is an extremiser only for $c>0$, and $K=0$ is a second equality case |
| the odd-$n$ ratios $\sqrt{5/3}$, $1.16024$, $1.11153$ | **first two CONFIRMED analytically; the third REFUTED**, the true value is $\sqrt{21/17}=1.111438$ |
| "the values quoted are $\min_{a\ne b}\lvert K_{ab}\rvert$, not $\lvert\min_{a\ne b}K_{ab}\rvert$" | **REFUTED**, the two functionals are swapped, and the sentence contradicts the block's own $\sqrt n$ claim |
| "exactly $\sqrt n$ at the balanced sphere product" | **CONFIRMED, and now proved** rather than measured |
| "Why it matters" | **the same file states a $\sqrt n$ stronger fact eight paragraphs above**, so the lemma is not needed for its advertised use |
| provenance note on Reviewer 104 | **CLEAN**, the run existed, the partial says what the note says, and the ordering is as claimed |

## 1. The duplication, which decides whether the block should exist

### The statements are the same statement

Hypothesis by hypothesis, [L55](../findings/diagonal-half.md) and [L93](../findings/bispectral.md) are word-for-word identical: $K$ hollow, symmetric, zero row sums, $\lVert K\rVert_F^2=t$; conclusion $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$. Neither has a hypothesis the other lacks. The only difference in *placement*: L55 carries the extremiser characterisation inside the statement ("the extremizers being exactly the perfect matchings"), L93 carries it in a following paragraph ("Equality *forces* a perfect matching").

**The normalisation is the same in both, and it is the ordered-pair one.** Both proofs write $t=\lVert K\rVert_F^2=\sum_a s_a$ with $s_a=\sum_b K_{ab}^2$, which counts each off-diagonal entry twice, once from each endpoint. This is the reading the constant requires; under the unordered convention $\sum_{i<j}$, which [diagonal-half.md](../findings/diagonal-half.md) itself uses eight lines below L55, in $\lVert W\rVert^2=\sum_{i<j}M_{ij}^2$, the constant would carry a factor $2$. So the collision the brief warns of is live *in the same file* as L55, but neither block's proof falls into it.

### The proofs are two different arguments, and the weaker one is L93's

They are not copies of each other.

- **L55's**: fix the row achieving the *global* minimal entry $-m$; every entry of every row is $\ge-m$, so each row lies in the polytope $\{x\in\mathbb R^{n-1}:\sum x=0,\ x_b\ge-m\}$; the convex functional $s_a$ is maximised at an extreme point, which has one coordinate $(n-2)m$ and the rest $-m$; hence $s_a\le(n-1)(n-2)m^2$ **for every row**; sum.
- **L93's**: fix a row $a$ and bound its own least entry by $\sqrt{s_a/((n-1)(n-2))}$; then pick the row with $s_a\ge t/n$.

They reach the same constant, and each is sound. L55's is the better one: it bounds every row at once against the global $m$, so its equality analysis reads off directly, whereas L93 has to compare a per-row minimum with the global one and then discards $n-1$ of the $n$ rows. **L93 also asserts its extremal step where L55 proves it** (see §2).

### Which came first, and which number survives

`git log -S` puts the mathematics in [bispectral.md](../findings/bispectral.md) first, and gives an unambiguous order:

| when | what |
|---|---|
| 2026-08-26 16:08:41 | `aad4a1be` salvages Reviewer 104's partial, which contains the statement |
| 2026-08-26 16:11:17 | `b1117290` adds the min-entry lemma to [bispectral.md](../findings/bispectral.md), under a descriptive heading, unnumbered |
| 2026-08-31 20:50:27 | `86621751` gives the result a numbered block, **55**, in [diagonal-half.md](../findings/diagonal-half.md), adopting the number the report already used |
| 2026-09-02 | `fe85b5bd` retro-fits a `Lemma L93` heading onto the [bispectral.md](../findings/bispectral.md) text, creating the second number |

**55 survives; 93 is struck.** Three reasons, each sufficient:

1. **The numbering rule.** [findings/INDEX-results.md](../findings/INDEX-results.md) says a number is assigned when a result gets a block. L55's block is 2026-08-31; L93's heading is 2026-09-02. 55 is the earlier block *and* the lower number.
2. **55 is the number already cited elsewhere.** [results.md](../results.md) line 554 and [report/sections/06b-bispectral.tex](../report/sections/06b-bispectral.tex) lines 150 and 179 both carry it as Lemma 55. Nothing outside [findings/](../findings/) cites 93.
3. **93 was created by a mechanical heading pass**, not by a result arriving.

**Which file the subject belongs to is a separate question, and the record has it slightly wrong in both directions.** The number 55 was minted by the report *in its bispectral section*, and the mathematics was written in [bispectral.md](../findings/bispectral.md), so L55's own note, *"the mathematics has always been in this file"*, is false, as the L55 audit also found. But by subject the statement is a pure vertex-matrix fact, and [findings/INDEX.md](../findings/INDEX.md) assigns the vertex matrix and its row-norm caps to [diagonal-half.md](../findings/diagonal-half.md), where [L68](../findings/diagonal-half.md) already "caps every entry by its own row norms", the same subject. **Recommendation: keep the block in [diagonal-half.md](../findings/diagonal-half.md) under number 55, delete the L93 heading and the duplicated statement and proof, and leave in [bispectral.md](../findings/bispectral.md) only the two things that are genuinely bispectral (the "why it matters" sentence and the looseness measurement), each pointing at L55.**

*One consequence to record: there are four copies of this result, [bispectral.md](../findings/bispectral.md), [diagonal-half.md](../findings/diagonal-half.md), [results.md](../results.md) and [report/sections/06b-bispectral.tex](../report/sections/06b-bispectral.tex), and they do not agree. The report's version says "at odd $n$ the bound is strict" without the $t>0$ that makes it true, and L93 says "not attained at odd $n$" with the same omission.*

## 2. The inequality, re-derived

Write $m=\lvert\min_{a\ne b}K_{ab}\rvert$.

**The extremal step, which L93 asserts.** Let $y\in\mathbb R^M$ with $\sum y=0$ and $y_i\ge-m$ for all $i$. Then $y_i=-\sum_{j\ne i}y_j\le(M-1)m$, so the feasible set is a compact convex polytope inside the hyperplane $\sum y=0$, of dimension $M-1$. An extreme point needs $M-1$ independent active constraints $y_i=-m$, so the extreme points are exactly the $M$ vectors with one coordinate $(M-1)m$ and the rest $-m$, where $\sum y^2=(M-1)m^2+(M-1)^2m^2=M(M-1)m^2$. A convex functional on a compact convex set attains its maximum at an extreme point, so

$$\textstyle\sum_i y_i^2\ \le\ M(M-1)m^2,\qquad\text{i.e.}\qquad m\ \ge\ \sqrt{\frac{\sum_i y_i^2}{M(M-1)}}.$$

**This is true, so the assertion is a gap and not an error**, but it is the heart of the argument and L93 supplies no line of it. Note also that L93's parametrisation $y=(\alpha,\dots,\alpha,-(M-1)\alpha)$ is only consistent with its own conclusion when $\alpha<0$: at $\alpha>0$ the minimum is $-(M-1)\alpha$ and $\lvert\min y\rvert=(M-1)\alpha$, which is $M-1$ times, not equal to, $\sqrt{s/(M(M-1))}=\alpha$. The block calls them "$M-1$ equal negatives", so the intent is right and the display is unsigned. **The same sign omission, in the same place, as the extremiser (§3).**

**From one row to the matrix.** Apply this with $M=n-1$ to the off-diagonal entries of row $a$, which sum to zero by hollowness plus $K\mathbf1=0$: $s_a\le(n-1)(n-2)m^2$, using the *global* $m$ since every entry is $\ge-m$. Now $\sum_a s_a=\sum_{a,b}K_{ab}^2=\lVert K\rVert_F^2=t$ **exactly**, the Frobenius norm already sums over ordered pairs, so there is no double count to correct and no factor to insert. Hence $t\le n(n-1)(n-2)m^2$, the display. L93's route (some row has $s_a\ge t/n$) gives the same constant.

**Which hypotheses are consumed.** Hollowness and zero row sums, nothing else. **Symmetry is never used** (the derivation reads rows one at a time and never compares $K_{ab}$ with $K_{ba}$) so the bound holds for any hollow $K$ with $K\mathbf1=0$. This matches what the concurrent audit of L55 found, and **L93 does not say it**: it states symmetry among the hypotheses and never remarks that the inequality is free of it. That symmetry is only needed for the equality case is not a cosmetic point; it is what produces the parity obstruction (§4).

**The absolute value is cosmetic.** Summing all off-diagonal entries gives $\sum_a\sum_{b\ne a}K_{ab}=0$, so for $K\ne0$ some off-diagonal entry is strictly negative and $\min_{a\ne b}K_{ab}<0$. At $K=0$ both sides are $0$.

## 3. The equality case: the same two omissions as the sibling, and no forcing argument at all

**The $c<0$ omission is present in L93 too.** Take $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere. Every stated hypothesis holds for either sign of $c$: rows sum to $(n-2)c-(n-2)c=0$, and $\lVert K\rVert_F^2=n[(n-2)^2c^2+(n-2)c^2]=n(n-1)(n-2)c^2=t$. But at $c<0$ the minimum entry is $(n-2)c$, so

$$\bigl\lvert\min_{a\ne b}K_{ab}\bigr\rvert=(n-2)\lvert c\rvert=(n-2)\sqrt{\frac{t}{n(n-1)(n-2)}},$$

**missing the bound by a factor $n-2$.** L93's sentence (*"$K_{ab}=(n-2)c$ … and $-c$ elsewhere makes both steps of the proof tight at once"*), is therefore false as written and needs $c>0$. **Witness, smallest case $n=4$**: $K$ with $K_{12}=K_{34}=-2$, all other off-diagonal entries $+1$; $t=4\cdot3\cdot2\cdot1=24$; bound $=\sqrt{24/24}=1$; actual $\lvert\min K_{ab}\rvert=2$.

**And $K=0$ is a second equality case at every $n$**, odd included, which falsifies L93's *"not attained at odd $n$"* as stated. Both the block and the report's copy need $t>0$.

**Uniqueness is asserted, not proved.** L93 says "Equality *forces* a perfect matching" and then verifies only that the displayed family is tight, the sufficiency direction, and only for $c>0$. The forcing direction appears nowhere in the block. It is true, and here is what it costs, since the brief asks whether the analysis is present:

1. **Every row must be extreme.** $\sum y^2$ is *strictly* convex, so its maximum over a compact convex set is attained only at extreme points; equality in $\sum_a s_a\le n(n-1)(n-2)m^2$ forces $s_a=(n-1)(n-2)m^2$ for every $a$, hence every row has one entry $(n-2)m$ at some column $\sigma(a)\ne a$ and the rest $-m$. *The word "strictly" is the missing clause: without it a row could sit on a face.*
2. **Symmetry turns the permutation into an involution.** From $K_{a\sigma(a)}=(n-2)m$ and symmetry, $K_{\sigma(a)a}=(n-2)m$; row $\sigma(a)$ has exactly one entry of that value (for $m>0$, $n\ge3$, since $(n-2)m\ne-m$), so $\sigma(\sigma(a))=a$. **This is the only step where symmetry enters the whole result**, and neither L93 nor L55 names it.
3. **Parity.** A fixed-point-free involution on $n$ points exists exactly for $n$ even, so at odd $n$ with $t>0$ the bound is strict.

**Dropping symmetry destroys the parity obstruction, which shows step 2 is load-bearing.** Without it, $\sigma$ need only be a fixed-point-free *permutation*, and any such $\sigma$ gives equality at every $n\ge3$. The smallest witness is the $3$-cycle at $n=3$: $K_{12}=K_{23}=K_{31}=1$, $K_{21}=K_{32}=K_{13}=-1$, hollow with zero row sums, $t=6=n(n-1)(n-2)$, $\lvert\min K_{ab}\rvert=1=\sqrt{t/6}$.

## 4. The odd-$n$ ratios: the first two are exactly right, the third is REFUTED

L93 records "not attained at odd $n$, ratios $\sqrt{5/3}$, $1.16024$, $1.11153$ at $n=5,7,9$". Set $m=1$ and let $N^\ast(n)=\max\lVert K\rVert_F^2$ over hollow symmetric zero-row-sum $K$ with all entries $\ge-1$; the ratio is $\sqrt{n(n-1)(n-2)/N^\ast(n)}$.

**An explicit family gives $N^\ast$ from below at every odd $n\ge5$.** Take a perfect matching on $n-3$ of the vertices carrying $n-2$, a triangle on the remaining three carrying $(n-3)/2$, and $-1$ everywhere else. Rows check: a matched vertex has $(n-2)+(n-2)(-1)=0$; a triangle vertex has $2\cdot\frac{n-3}2-(n-3)=0$. Its norm is

$$\tfrac{n-3}2(n-2)^2+3\Bigl(\tfrac{n-3}2\Bigr)^2+\Bigl[\tbinom n2-\tfrac{n-3}2-3\Bigr],\quad\text{doubled}\ =\ n(n-1)(n-2)-\tfrac32(n-1)^2,$$

an identity of cubics in $n$, checked at $n=5,7,9,11$ and expanded: both sides are $n^3-\tfrac92n^2+5n-\tfrac32$.

| $n$ | $n(n-1)(n-2)$ | this family | ratio | L93 records |
|---|---|---|---|---|
| $5$ | $60$ | $36$ | $\sqrt{5/3}=1.290994$ | $\sqrt{5/3}$ ✔ |
| $7$ | $210$ | $156$ | $\sqrt{35/26}=1.160239$ | $1.16024$ ✔ |
| $9$ | $504$ | $408$ | $\sqrt{21/17}=1.111438$ | $1.11153$ ✘ |

**The $n=9$ entry is too large, and the witness is the $n=9$ member above**, value $7$ on a perfect matching of $\{1,\dots,6\}$, value $3$ on the triangle $\{7,8,9\}$, $-1$ elsewhere; $N^\ast(9)\ge408$, so the ratio is at most $\sqrt{504/408}=1.111438$. A larger recorded ratio corresponds to a *smaller* norm, so $1.11153$ is a stalled optimiser's value, exactly the direction such an error takes.

**The closed form the record holds as three measurements** is, assuming this family is optimal at odd $n$,

$$\sqrt{\frac{n(n-1)(n-2)}{n(n-1)(n-2)-\tfrac32(n-1)^2}}=\sqrt{\frac{2n(n-2)}{(2n-1)(n-3)}}\qquad(n\ \text{odd},\ n\ge5),$$

reproducing $\sqrt{5/3}$ and $1.16024$ and returning $\sqrt{21/17}$ at $n=9$. *I derived the family and the identity by hand before consulting the record.* **Afterwards I found the record already had it**: [reviews/REVIEW_r105.md](REVIEW_r105.md) states $N^\ast(n)=n(n-1)(n-2)-\tfrac32(n-1)^2$ with the same construction and the same values $156$, $408$, $840$, on 2026-08-26, while [reviews/REVIEW_r106.md](REVIEW_r106.md) reports the measured $0.0700198$ against the exact $\sqrt{2/408}=0.0700140$. **So both numbers were on the record, and the block transcribed the measured one over the exact one.**

*What is still open at odd $n$:* the matching *upper* bound on $N^\ast$ (that no other vertex of the polytope beats this family), is numerical only in [r105](REVIEW_r105.md) and is not established here. The concurrent L55 audit reports an analytic route through the fractional perfect matching polytope; if that holds, the odd-$n$ constant is closed and the block's "not attained at odd $n$" acquires a value rather than three measurements. **Deciding it by search would need computation, which this brief does not authorise; what a vertex enumeration of that polytope at $n=5,7,9$ would decide is whether the family above is optimal or merely good.**

## 5. The "wrong functional" paragraph is itself wrong, and contradicts the block two paragraphs above

L93 says the quoted $0.3162$, $0.2182$, $0.1667$ "are $\min_{a\ne b}\lvert K_{ab}\rvert$, not $\lvert\min_{a\ne b}K_{ab}\rvert$, whose true values are $0.2108$, $0.1637$, $0.1333$, smaller by exactly $n/(n-2)$."

**This is impossible on its face.** The minimising pair's entry is one of the moduli, so $\min_{a\ne b}\lvert K_{ab}\rvert\le\lvert\min_{a\ne b}K_{ab}\rvert$ for every hollow $K$. The paragraph asserts the reverse, strictly.

**What the numbers actually are.** The balanced sphere product's vertex matrix at $n=2m$ is the two-valued matrix of [L74](../findings/diagonal-half.md) on $K_{m,m}$: value $a$ on the $m^2$ cross pairs and $-\tfrac m{m-1}a$ on the within-factor pairs, with $a^2=(m-1)/(m^2(2m-1))$ at $\lVert W\rVert=1$, i.e. $t=2$. So the two moduli are

$$a=\sqrt{\frac{m-1}{m^2(2m-1)}}\ \ \text{and}\ \ \frac m{m-1}a=\sqrt{\frac{2}{(n-1)(n-2)}},$$

which at $n=6,8,10$ are $0.2108,0.1637,0.1333$ and $0.3162,0.2182,0.1667$. **The first list is $\min_{a\ne b}\lvert K_{ab}\rvert$ and the second is $\max_{a\ne b}\lvert K_{ab}\rvert$**; the ratio $m/(m-1)=n/(n-2)$ the block quotes is right, and both labels are wrong. Which of them is $\lvert\min_{a\ne b}K_{ab}\rvert$ depends on the sign branch, which the block never names: on the $a>0$ branch it is $0.3162$, on the $a<0$ branch it is $0.2108$.

**And the block picks both branches, in adjacent paragraphs.** Its "exactly $\sqrt n$" claim needs $\lvert\min K_{ab}\rvert=0.3162$; its "true values" claim says $\lvert\min K_{ab}\rvert=0.2108$. Two paragraphs of one block give one quantity two values differing by $n/(n-2)$.

**The $\sqrt n$ claim is the correct one, and it is a theorem rather than a measurement.** On the branch where $\lvert\min K_{ab}\rvert=\tfrac m{m-1}a$,

$$\frac{\lvert\min_{a\ne b}K_{ab}\rvert^2}{t/(n(n-1)(n-2))}=\frac{2/((n-1)(n-2))}{2/(n(n-1)(n-2))}=n,$$

so the ratio is $\sqrt n$ **exactly, at every even $n$**, which the block reports as three measured digits. The accompanying reading, that all rows are equal, so $s_a\ge t/n$ is tight and the entire loss sits in the single-row step, is then correct, and the target $\sqrt{t/((n-1)(n-2))}$ named in the block's first version is the sphere product's own value.

## 6. "Why it matters" is served, better, eight paragraphs above in the same file

The block's use-claim is that with $d_\psi=-\operatorname{spec}(K|_{\mathbf1^\perp})$ the lemma "forces $\max d$ away from zero at every vertex $K$". Two problems.

- **It bounds the wrong end of the spectrum.** Testing $K$ against $(e_a-e_b)/\sqrt2$ gives $\lambda_{\max}(K)\ge-K_{ab}$ for every pair, so the lemma lower-bounds $\lambda_{\max}(K)$, which is $-\min d_\psi$ under the stated convention, not $\max d_\psi=-\lambda_{\min}(K)$.
- **The file already has the statement it wants, with a better constant.** The $n-1$ values of $d_\psi$ sum to zero and have $\sum d_i^2=t$, so the §2 polytope bound with $M=n-1$ gives $\max_i d_i\ge\sqrt{t/((n-1)(n-2))}$ directly, which is exactly what [bispectral.md](../findings/bispectral.md) states eight paragraphs above L93, in the surviving-relaxation block. That constant is **$\sqrt n$ larger** than L93's, and it needs neither hollowness nor the entries of $K$ at all.

**So the lemma is not the analytic replacement for the sampled sweep; the one-line spectral fact in the same file is, and L93 is the $\sqrt n$-weaker shadow of it.** The lemma's real interest is what its equality case says about entries, which is a statement about sectional curvatures, as [results.md](../results.md) already notes. *That is the fifteenth time in this audit programme that the answer sat in the block's own file.*

## 7. Provenance: CLEAN

The note reads: *"Derived, then checked, not established by search. Reviewer 104 reached this statement before being killed mid-run; its partial is not citable, so the proof below is this cycle's own."* Against git, every clause holds.

- **The run existed.** `aad4a1be` (2026-08-26 16:08:41) commits [reviews/REVIEW_r104.md](REVIEW_r104.md), salvaged from a reviewer killed during phase 6 of 7.
- **It reached the statement.** Its log line at 14:37:08 reads *"Found analytic sharp lemma |min K| >= sqrt(t/(n(n-1)(n-2)))"*, the same constant.
- **"Not citable" is accurate as a policy claim.** The partial is present in the repo, not absent; the note claims only that it may not be cited, which is what the salvage commit and the file itself say ("none of it should be cited as a verdict").
- **The ordering is as implied.** The lemma block landed at 16:11:17, two minutes and thirty-six seconds after the salvage, so the *statement* was 104's and the block says so, while 104's log carries no proof, so "the proof below is this cycle's own" stands.

**One clause of the surrounding sentence does not.** 104's log attributes the infeasibility to the **$\mu$ side** ("mu-side Okumura infeasible for $t>4/(n+1)$"); L93's "why it matters" claims the **$\omega$ side**, and the same file elsewhere records that the $\mu$ side is *feasible* at $n=6$, $t=0.25$. The sides may both be genuine at different thresholds, but the block inherits 104's sentence with the side changed and no note of it.

*Reported either way as the brief asks: this is a self-historical note that survives its check.*

## 8. Minor, and pointer hygiene

- **Two consecutive `####` headings.** The `Lemma L93` heading was retro-fitted above the original descriptive heading "A lower bound on the vertex matrix's most negative entry, derived", which is now an empty sibling block. If L93 is struck this resolves itself.
- **Pointers resolve.** [scripts/runs/run_minK_lemma_check.py](../scripts/runs/run_minK_lemma_check.py) exists; [reviews/REVIEW_r105.md](REVIEW_r105.md) and [reviews/REVIEW_r106.md](REVIEW_r106.md) exist. The block names 105 and 106 in prose without linking them, against the record's convention.
- **The hedge "sharp at even $n$" in the heading** is true only with $t>0$ and $c>0$ supplied. **"Not established by search" is true**, and is the eighth such clause I would expect to conceal something and does not.

## What is owed

| owed | reachable? |
|---|---|
| strike L93, keep 55, leave a pointer in [bispectral.md](../findings/bispectral.md) | **yes, now**, no mathematics changes |
| add $c>0$ and $t>0$ to the extremiser claim, in all four copies | **yes, now** |
| supply the extremal step, strict convexity and the symmetry step in the surviving block | **yes**, six lines, given in §2 and §3 above |
| correct the $n=9$ ratio to $\sqrt{21/17}$ | **yes, now**, the exact value is already in [r105](REVIEW_r105.md) |
| withdraw or relabel the "wrong functional" paragraph and name the sign branch | **yes, now** |
| record that symmetry is unused by the inequality, and is the sole source of the parity obstruction | **yes, now** |
| prove the odd-$n$ family optimal | **analysis reachable** via the fractional perfect matching polytope; a vertex enumeration would settle it numerically but needs computation this brief does not authorise |
| decide the $\mu$/$\omega$ side of the Okumura consequence | **needs the neighbouring block**, out of this brief's scope |
