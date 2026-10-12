# VERIFY v146, Lemma L69: the $p,q\ge5$ threshold, the invariant count that replaced the classification, and the nondegeneracy citation

**Verifier v146, cold brief, round L69.** Checked: [findings/graded-half.md](../findings/graded-half.md):363–385 (the block as dispatched in [ROUND_L69.md](ROUND_L69.md)) against the canonical form at [results.md](../results.md):553 and the landscape line at :180. **No numerical work was done: no script was run, and every value below is an exact hand evaluation from the record's own closed forms.** Log: [agent_logs/verify-L69-v146.log](../agent_logs/verify-L69-v146.log).

## Claim table

| # | claim, as a consumer would read it | verdict |
|---|---|---|
| C1 | the split condition $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13$ is the reading of $\lVert W\rVert^2\le\tfrac16$, and of $\theta\ge\sqrt{3/2}$ | **PROVEN**, the reduction is exact, and the two routes are one identity |
| C2 | every two-factor split with $p,q\ge5$ satisfies it at every $n\ge12$, both parities | **PROVEN**, convexity in $p$ puts the worst case at $p=5$, where it is $n\ge12$ exactly |
| C3 | no split with a factor $\le4$ satisfies it, at any $n$ | **PROVEN** for $p\in\{2,3,4\}$; $p=1$ is excluded by a separate sentence, not by the inequality |
| C4 | the boundary figures ($7/18$, $7/20$, $1/132$, $4/165$, $1/1056$ | **PROVEN**), all five exact, and mutually consistent |
| C5 | $k\ge3$ is excluded by the budget | **PROVEN**, $\tfrac18(2-\tfrac1{n-1})\ge\tfrac{21}{88}>\tfrac16$ at $n\ge12$ |
| C6 | every factor is a sphere, "by [Lemma L47](../findings/problem.md)'s quantitative $\lVert W_a\rVert^2\ge\tfrac16$" | **PROVEN, hypotheses corrected**: L47 covers rank $\ge2$ and $\mathbb{OP}^2$; the rank-one families are L10/L38, and the link points at a file holding no L47 |
| C7 | the invariant count $3-0-2=1$, uniform over the gradings | **GAP**, the count is right and derived in [r502](../reviews/REVIEW_r502.md); "uniform rather than case-checked" is refuted by the block's own three displays |
| C8 | "needing no classification at all" / "with no appeal to the classification of symmetric spaces" | **BROKEN as written**, the count quantifies over the $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$, which is a classification, and [r317](../reviews/REVIEW_r317.md) already said "a smaller appeal, not none" |
| C9 | the enumeration of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$, complete for $n\ne8$ | **HYPOTHESIS-DEBT**, rests on $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$, asserted at three sites, sourced nowhere in [references/](../references/) |
| C10 | the threshold conversion imports Einstein and $\lambda\ne0$ from [L46](../results.md):292 and [L48](../findings/problem.md):234 | **GAP**, load-bearing per [r462](../reviews/REVIEW_r462.md)/[r463](../reviews/REVIEW_r463.md), stated in neither citable form of L69; the material discharging it is in a review report |
| C11 | "an equivariant graded critical point on a pair is the sphere product's Weyl tensor" | **BROKEN read alone**, false at a $\mathfrak u(m)$ pair; the correction sits in the same paragraph, ahead of the sentence, unchanged since [r317](../reviews/REVIEW_r317.md) called it false as written |
| C12 | each surviving split is Morse–Bott nondegenerate, $\lambda_{\max}=\tfrac12$ on the orbit tangent alone | **PROVEN**, [L27](../findings/nondegeneracy.md):457 covers $p,q\ge3$ minus $(3,3)$, and $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ exactly |
| C13 | the gap to the second eigenvalue is $\tfrac1{2(M-1)}$, $\tfrac1{12}$ at $S^5\times S^7$ | **PROVEN**, and [LEDGER.md](../findings/LEDGER.md):770's "the true figure is $\tfrac7{24}$" is withdrawn four lines below itself |
| C14 | the universal form: above $\sqrt{3/2}$ at $n\ge12$ there is nothing else | **PROVEN** relative to C9, six candidate families tried, none reaches; the enumeration is the single load-bearing input |
| C15 | the Lean row | **PROVEN, and honestly scoped**, [L69.lean](../lean/HamiltonsCubic/Results/L69.lean) proves the split arithmetic and nothing else, and both index rows say so |

**Verdict: GAP.** Both halves of the statement survive every attack made here, and every number in the block is exact. What the *written proof* lacks is on the record but not in the block: the Einstein hypothesis it imports (C10), the case-by-case warrant for its invariant count (C7), and a source for the grading enumeration the count quantifies over (C9, the one genuine hypothesis debt). Three sentences are false read alone (C8, C11) or over-credit their citation (C6). **Cite [results.md](../results.md):553, not [graded-half.md](../findings/graded-half.md):363–385**: the canonical form carries the scope caveats the block leaves thirty lines downstream.

**One line.** The lemma is true and its arithmetic is exact to the last unit fraction; its proof as written borrows an Einstein hypothesis it never states, calls a case-by-case count uniform, and rests on a classification of gradings that no source in this record supplies.

## 0. Conventions, fixed once

- $n=p+q$ throughout; $N=\binom n2$; $\mathcal W_n=\mathrm{Weyl}_n$ is the space of Ricci-flat algebraic curvature operators on $\Lambda^2\mathbb R^n$.
- **The record writes $\mathfrak p$ for the isotropy subalgebra and $\mathfrak m$ for its complement** in the $\mathbb Z_2$-grading $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$. This is the convention of the block ("the $\mathfrak p$-internal cross-block between the simple factors of $\mathfrak p$", "$\mathfrak p_2\times\mathfrak p_2$, i.e. $\mathfrak{so}(5)$" at the $(3,5)$ witness) and of [r502](../reviews/REVIEW_r502.md). [Lemma L27](../findings/nondegeneracy.md):457 and parts of [problem.md](../findings/problem.md) use $\mathfrak h/\mathfrak m$ for the same split.
- **"Graded" is sense (C), pair-graded**, $W$ is $\mathrm{ad}(\mathfrak p)$-invariant for a symmetric pair $(\mathfrak{so}(n),\mathfrak p)$, per the labelling table at [graded-half.md](../findings/graded-half.md):388. (A) sign-graded and (B) slice-graded are different classes; (C) and (A) are incomparable and both sit strictly inside (B).
- **Two normalisations of $\lVert W\rVert$ are in play and the whole lemma turns on the bridge between them.** The geometric one normalises to Einstein constant $\tfrac12$, so $\operatorname{scal}=n/2$ and $\operatorname{tr}R=n/4$; there $\lVert W\rVert^2$ is a number like $175/1056$. The algebraic one puts $W$ on the unit sphere of $\mathcal W_n$ and evaluates $\theta=P(W)$. The bridge is [L46](../results.md):292: $$\theta=\frac1{2\lVert W\rVert},\qquad\theta^2=\frac1{4\bigl(\lVert R\rVert^2-(\operatorname{tr}R)^2/N\bigr)}.$$
- $f(m)=\dfrac m{8(m-1)}=\dfrac18\Bigl(1+\dfrac1{m-1}\Bigr)$; $S(p,q):=\dfrac1{p-1}+\dfrac1{q-1}-\dfrac1{n-1}$; $M=\max(p,q)$, $m=\min(p,q)$; $\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{n^2}$.

## 1. The hypothesis inventory

**A pass without one is not a pass, so here is every hypothesis, and then which the written proof uses.**

### 1.1 Hypotheses the block carries in its own statement

| hypothesis | where | used? |
|---|---|---|
| $n\ge12$ | statement | **used**, but only as the dimension where an admissible split first exists; no step consumes it as a premise. The block says so itself, and it is right |
| the point is **graded**, sense (C) | statement, via the labelling table | **used, decisively**, the whole argument runs through a symmetric pair, and it is what excludes padded $W_{\mathbb{CP}^2}$ at the boundary (§6.2) |
| the point is **equivariant** | statement | **used, decisively**, [L8](../findings/graded-half.md):421's scope refutation exhibits a second graded critical point on the *same* pair $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ at $\theta=1.088948$ with $\Delta=1.512231$. Drop equivariance and one pair carries a family |
| the point is **critical** | statement | **used** only through $\theta$ being defined and positive; the commutant count needs invariance alone |
| $\theta\ge\sqrt{3/2}$, **non-strict** | statement | **used**, and the non-strictness is the sharp edge (§6.2) |

### 1.2 Hypotheses of every imported result, checked against the object

| imported result | its hypotheses | does the object satisfy them? |
|---|---|---|
| [L46](../results.md):292, $Q(W)=\lambda W$, $\theta=1/(2\lVert W\rVert)$ | **locally symmetric**, **Einstein**, $\lambda\ne0$, Einstein normalisation | locally symmetric: yes, once the point is identified with a symmetric space. **Einstein: never checked in either citable form of L69**, see §5. $\lambda\ne0$: yes, since $\theta\ge\sqrt{3/2}>0$ forces $W\ne0$ |
| [L47](../findings/problem.md):221, $\lVert W\rVert^2\ge\tfrac16$ | compact irreducible symmetric, **rank $\ge2$**, plus $\mathbb{OP}^2$; Einstein constant $\tfrac12$ | **partially.** The block applies it to *every* non-sphere factor, including rank-one ones. $\mathbb{CP}^m$ and $\mathbb{HP}^m$ come from L10/L38, not L47 (§4.3) |
| [L48](../findings/problem.md):234, $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, and the Theorem | product of symmetric spaces; the **Theorem** additionally needs **Einstein**, added by [r462](../reviews/REVIEW_r462.md)/[r463](../reviews/REVIEW_r463.md) as load-bearing, with the equality case needing **round factors of equal Einstein constant** | the decomposition itself: yes. The Einstein hypothesis: **unstated in L69** (§5) |
| [L27](../findings/nondegeneracy.md):457, Morse–Bott nondegeneracy | $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$ exactly (padding destroys it) | **yes**, strictly inside: $p,q\ge5$. And the half L69 needs (multiplicity-freeness at $p,q\ge5$), is the half proved in the source rather than the half supplied by computation (§7) |
| the $\mathbb Z_2$-grading enumeration | $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$, $n\ge5$, $n\ne8$ | $n\ge12$ clears $n\ne8$. **The hypothesis itself has no source in this record** (§3) |
| [r502](../reviews/REVIEW_r502.md)'s invariant count | one case per grading class; the generic case assumes $p,q\ge5$ | yes, and the boundary cases $p\le4$ are carried separately in the same report |

### 1.3 Which of these the *written proof* uses

The block's proof uses, in order: the invariant count (§3); the irreducible bound L47 (§4.3); the reducible decomposition L48 (§4.3); the arithmetic reduction and the split analysis (§4.1, §4.2); the $k\ge3$ budget (§4.4); and L27 (§7). **It never states L46, whose identity is the only thing that turns $\theta\ge\sqrt{3/2}$ into $\lVert W\rVert^2\le\tfrac16$**, the step the entire arithmetic half rests on. The identity is on the record ([graded-half.md](../findings/graded-half.md):182) and its hypotheses are stated there; the block silently consumes it in the phrase *"the condition $\lVert W\rVert^2\le\tfrac16$"*.

## 2. Pre-registered question 1, what enumerates "every equivariant graded critical point"?

### 2.1 The enumeration, named

**It is the classification of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$, tabulated at [graded-half.md](../findings/graded-half.md):404–412**: $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$ at every $n$; $\mathfrak u(n/2)$ at even $n$; and, **at $n=8$ only**, $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, the triality images of $\mathfrak{so}(1)\oplus\mathfrak{so}(7)$ and $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$.

**It is a classification, not a sweep.** The commutant is then computed once per class, which is what makes the conclusion universal in $n$ rather than a range of tested dimensions. The measurements the block also reports, the $\mathrm{ad}(\mathfrak p)$-commutant being one-dimensional at $(3,5)$, $(4,4)$, $(2,6)$ at $n=8$ and $(5,5)$, $(4,6)$ at $n=10$, are five sweeps at two dimensions, **both below the lemma's own $n\ge12$**, and they are corroboration rather than warrant. The block's own blockquote says this in terms, against the first version.

### 2.2 What it inherits

**The warrant is $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$ with $n=8$ the sole exception**, from which involutive automorphisms are $\mathrm{Ad}(g)$ with $g^2=\pm I$, giving exactly the two families. That sentence appears three times: [graded-half.md](../findings/graded-half.md):404, trap [W2](../findings/INDEX-traps.md):20, and [r318](../reviews/REVIEW_r318.md):97, which states it and says *"the record never states it"*.

**It has no source in [references/](../references/).** I listed the directory: it holds no Cartan, Helgason, Berger or Besse entry, as the brief warned. The nearest thing is [reeder-2013-gradings-positive-rank](../references/reeder-2013-gradings-positive-rank/notes.md), whose notes derive the **order-3** case by hand (*"for $n\ne8$ every order-3 automorphism of $\mathfrak{so}(n)$ is inner"*) and say nothing about order 2. **So the universal quantifier "at every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$" rests on an unread source.** This is the report's one HYPOTHESIS-DEBT item, and §6.4 shows it is the *only* load-bearing input to the universal form.

### 2.3 Does it need a pinning formula for the value?

**No, and this is the part the block gets right without saying so.** [Conjecture L8](../findings/graded-half.md):421's pinning $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$ is refuted off the balanced splits by [r503](../reviews/REVIEW_r503.md)/[r504](../reviews/REVIEW_r504.md), and it has a **pole** wherever $2q=p$, an infinite family, $n\in\{6,25,96,361,\dots\}$ by the Pell equation $(n+1)^2-3s^2=1$. L69 uses none of it. Its value comes from L46's $\theta=1/(2\lVert W\rVert)$ together with L48's partition decomposition, equivalently from the closed form
$$\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq},$$
which I verify in §4.1 is the *same* statement as the split inequality.

**At a pair where the pinning has no value, L69's route still has one.** The record's own witness is $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$: $2q-p=0$, so the pinning formula divides by zero, while the closed form gives, exactly,
$$\theta^2=\frac{2\cdot24\cdot4\cdot19}{23\cdot100}=\frac{3648}{2300}=\frac{912}{575},$$
which is the $912/575$ the record states, **and it exceeds $\tfrac32$**, at odd $n=25$, with both factors $\ge5$. So the pole family is not a hole in L69; it is a confirming instance, and it is the sharpest test of the odd-parity half of question 2.

## 3. The invariant count, the step everything now rests on

### 3.1 It is derived, and the derivation is correct

The block asserts the count with no working: *"at every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ the space of $K$-invariant symmetric endomorphisms of $\Lambda^2$ has dimension $3$, of which $\mathrm{Alt}$ and $\mathrm{Ric}$ remove $0$ and $2$."* **The derivation is on file**, in [REVIEW_r502.md](../reviews/REVIEW_r502.md):44–46, which the block cites for the replacement. Re-derived here by hand and agreeing at every case:

- **$\mathfrak p=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p,q\ge5$.** $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^p\oplus\Lambda^2\mathbb R^q\oplus(\mathbb R^p\otimes\mathbb R^q)$, three $K$-irreducibles of real type, pairwise inequivalent even at $p=q$, being $(\mathrm{ad},1)$, $(1,\mathrm{ad})$, $(\mathrm{std},\mathrm{std})$. Schur gives $\dim\operatorname{End}^{\mathrm{sym}}_K=3$, coordinates $(a,b,c)$. **Alt costs nothing** because $(\Lambda^4\mathbb R^n)^K=\bigoplus_{i+j=4}(\Lambda^i\mathbb R^p)^{SO(p)}\otimes(\Lambda^j\mathbb R^q)^{SO(q)}=0$: an $SO(m)$-invariant in $\Lambda^i\mathbb R^m$ needs $i\in\{0,m\}$, and $i,j\le4<p,q$. **Ric costs two** because $\operatorname{Ric}_{ii}=a(p-1)+cq$ on the first block and $b(q-1)+cp$ on the second, a matrix $\bigl(\begin{smallmatrix}p-1&0&q\\0&q-1&p\end{smallmatrix}\bigr)$ of rank $2$. So $3-0-2=1$, spanned by $(a,b,c)=\bigl(\tfrac q{p-1},\tfrac p{q-1},-1\bigr)$, **which is $W_{S^p\times S^q}$**, matching the vertex entries $-q/(p-1)$, $-p/(q-1)$, $1$ that [Observation L56](../results.md):553 quotes independently.
- **$p=4$.** $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ raises the endomorphism space to $4$, and the block volume form makes $(\Lambda^4\mathbb R^n)^K$ one-dimensional, so Bianchi now costs exactly what the splitting added: $4-1-2=1$.
- **$\mathfrak p=\mathfrak u(m)$, $n=2m$.** The summands are $\mathbb R\omega$, $\mathfrak{su}(m)$ and $\mathfrak m\cong\Lambda^2\mathbb C^m$; $(\Lambda^4\mathbb R^{2m})^{U(m)}=\mathbb R\,\omega\wedge\omega$ is one-dimensional and $(\mathrm{Sym}^2\mathbb R^{2m})^{U(m)}=\mathbb R\,\mathrm{Id}$ makes Ricci one condition: $3-1-1=1$, spanned by $W_{\mathbb{CP}^m}$.
- **$p=1$** gives two summands and Ricci kills both coefficients, *"no equivariant point at all"*, exactly as the block's parenthetical says. $p=0$ forces $W\in\mathbb R\,\mathrm{Id}$, hence $W=0$ by tracelessness.

**The line is one-dimensional, so the sign is free**, and $-W_{S^p\times S^q}$ has $\theta<0<\sqrt{3/2}$, so the hypothesis disposes of it. No finding.

### 3.2 DISCREPANCY, "uniform over the gradings rather than case-checked" is refuted by the block's own display

**Located.** [graded-half.md](../findings/graded-half.md):367: *"the same count runs $4-1-2$ at $p=4$ and $3-1-1$ at $\mathfrak u(m)$, **so it is uniform over the gradings rather than case-checked**."*

**Exhibited.** $3-0-2$, $4-1-2$ and $3-1-1$ are three different decompositions of three different vector spaces, with three different Bianchi ranks and two different Ricci ranks. Nothing about them is the same except the answer. The source the sentence imports says so: [LEDGER.md](../findings/LEDGER.md):486 describes r502's replacement as *"$\dim\operatorname{End}^{\mathrm{sym}}_K(\Lambda^2)-\operatorname{rank}(\mathrm{Alt})-\operatorname{rank}(\mathrm{Ric})=1$, **case by case**"*, and four lines later, at :490, the same file writes *"uniform rather than case-checked"*. **The record contradicts itself inside one entry.** And r502 itself is organised as seven cases: $p=0$, $p=1$, $p=2$, $p=3$, $p=4$, generic $p,q\ge5$, and $\mathfrak u(m)$.

**Argued the opposite.** The most charitable reading the words support: *the result* is uniform (every grading yields exactly one line) so no grading needs a bespoke argument for its *conclusion*. That reading is true and is worth stating. It is not what the sentence says, and the distinction matters, because "uniform over the gradings" is the property that would license extending the count to a grading nobody enumerated, which is precisely the load the enumeration of §2 is carrying.

**Impact: none on the count, real on its warrant.** The count is proved for every grading in the enumeration. It is proved case by case, so it inherits the enumeration's completeness and cannot be stretched past it.

### 3.3 A second, smaller omission at the same sentence

r502 carries $(4,4)$ separately, as $5-2-2=1$, and observes that this is *"why the record's measured $1$ at $(4,4)$ is not an accident"*. The block quotes only $4-1-2$. $(4,4)$ is the case the block's own closing paragraph singles out as the one where the connected-$K$ criterion of [ungraded-slack.md](../findings/ungraded-slack.md) fails through the self-dual/anti-self-dual splitting, so the dropped sub-case is the interesting one. It changes nothing at $p,q\ge5$.

## 4. Pre-registered question 2, is $p,q\ge5$ right in both directions?

**Every value in this section is an exact hand evaluation. Nothing was run.**

### 4.1 The reduction, and the identity that makes the two routes one

$f(m)=\tfrac18\bigl(1+\tfrac1{m-1}\bigr)$, so for $k=2$,
$$\lVert W\rVert^2=f(p)+f(q)-\frac n{8(n-1)}=\tfrac18\Bigl[\Bigl(1+\tfrac1{p-1}\Bigr)+\Bigl(1+\tfrac1{q-1}\Bigr)-\Bigl(1+\tfrac1{n-1}\Bigr)\Bigr]=\tfrac18\bigl(1+S\bigr),\qquad S=\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}.$$
Hence $\lVert W\rVert^2\le\tfrac16\iff1+S\le\tfrac86=\tfrac43\iff S\le\tfrac13$. **The displayed inequality is exact.** *The block's phrasing "the $\tfrac18$ cancels to leave" is loose (a $1$ is carried across as well as a factor removed) but nothing turns on it.*

**Check at the headline split.** $(5,7)$, $n=12$: $\lVert W\rVert^2=\tfrac18\bigl(1+\tfrac14+\tfrac16-\tfrac1{11}\bigr)$. With denominator $132$: $\tfrac14=\tfrac{33}{132}$, $\tfrac16=\tfrac{22}{132}$, $\tfrac1{11}=\tfrac{12}{132}$, so $S=\tfrac{43}{132}$ and $\lVert W\rVert^2=\tfrac18\cdot\tfrac{175}{132}=\tfrac{175}{1056}$, **the record's own value**, and short of $\tfrac16=\tfrac{176}{1056}$ by exactly $\tfrac1{1056}$, as [graded-half.md](../findings/graded-half.md):192 states.

**The two routes are one identity.** Over the common denominator $(p-1)(q-1)(n-1)$, the numerator of $1+S$ is
$$(n-1)\bigl[(p-1)(q-1)+(q-1)+(p-1)\bigr]-(p-1)(q-1)=(n-1)(pq-1)-(pq-n+1)=pq(n-2),$$
using $p+q=n$ twice. So $1+S=\dfrac{pq(n-2)}{(p-1)(q-1)(n-1)}$, and with $\theta^2=1/(4\lVert W\rVert^2)=2/(1+S)$,
$$\boxed{\ \theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}\ }$$
**identically the closed form [graded-half.md](../findings/graded-half.md):431 quotes**. The two are the same statement, and $\theta^2\ge\tfrac32\iff S\le\tfrac13$.

**Five recorded values reproduced exactly from it, none of them re-derived numerically:**

| split | $n$ | $\theta^2$ | $\theta$ | record |
|---|---|---|---|---|
| $S^5\times S^7$ | $12$ | $\tfrac{2\cdot11\cdot4\cdot6}{10\cdot35}=\tfrac{264}{175}$ | $1.2282392$ | $1.228239158$ ✓ |
| $S^6\times S^6$ | $12$ | $\tfrac{2\cdot11\cdot5\cdot5}{10\cdot36}=\tfrac{55}{36}$ | $1.2360330$ | $1.236033081$ ✓ |
| $S^4\times S^8$ | $12$ | $\tfrac{2\cdot11\cdot3\cdot7}{10\cdot32}=\tfrac{231}{160}$ | $1.2015615$ | $1.20156$ ✓ |
| $S^3\times S^9$ | $12$ | $\tfrac{2\cdot11\cdot2\cdot8}{10\cdot27}=\tfrac{176}{135}$ | $1.1417983$ | $1.14179$ ✓ |
| $S^{20}\times S^5$ | $25$ | $\tfrac{2\cdot24\cdot19\cdot4}{23\cdot100}=\tfrac{912}{575}$ | $>\sqrt{3/2}$ | $912/575$ ✓ |

The first two clear $\tfrac32$; the third and fourth do not, and they are the two splits at $n=12$ with a factor $\le4$. **No finding: the arithmetic half of the lemma is exact everywhere I could check it.**

### 4.2 Direction A, every split with both factors $\ge5$ clears the threshold at $n\ge12$

Fix $n$ and write $h(p)=\dfrac1{p-1}+\dfrac1{n-p-1}-\dfrac1{n-1}$ on $5\le p\le n-5$. Each of $x\mapsto1/(x-1)$ and $x\mapsto1/(n-x-1)$ is convex on that interval, so $h$ is convex and attains its maximum at an endpoint; by the symmetry $h(p)=h(n-p)$ the two endpoints agree, so **the worst case is $p=5$, $q=n-5$** at every $n$. There,
$$h(5)=\tfrac14+\frac1{n-6}-\frac1{n-1}=\tfrac14+\frac5{(n-6)(n-1)},$$
and $h(5)\le\tfrac13\iff\dfrac5{(n-6)(n-1)}\le\tfrac1{12}\iff(n-6)(n-1)\ge60\iff n^2-7n-54\ge0$. The roots are $(7\pm\sqrt{265})/2$ with $\sqrt{265}$ between $16.2$ and $16.3$, so the positive root lies between $11.6$ and $11.65$; over the integers, $n=11$ gives $5\cdot10=50<60$ and $n=12$ gives $6\cdot11=66\ge60$. **Hence $n\ge12$, exactly**, and the block's rendering $n^2-7n-54\ge0$ is right ($144-84-54=6\ge0$; $121-77-54=-10<0$).

**Both parities, at and just above the boundary:**

| $n$ | split | $S$ | vs $\tfrac13$ | |
|---|---|---|---|---|
| $12$ | $(5,7)$ | $\tfrac{43}{132}$ | $\tfrac{44}{132}$ | passes by $\tfrac1{132}$ |
| $12$ | $(6,6)$ | $\tfrac15+\tfrac15-\tfrac1{11}=\tfrac{17}{55}=\tfrac{51}{165}$ | $\tfrac{55}{165}$ | passes by $\tfrac4{165}$ |
| **$13$** | $(5,8)$ | $\tfrac14+\tfrac17-\tfrac1{12}=\tfrac{21+12-7}{84}=\tfrac{26}{84}=\tfrac{13}{42}$ | $\tfrac{14}{42}$ | passes |
| **$13$** | $(6,7)$ | $\tfrac15+\tfrac16-\tfrac1{12}=\tfrac{12+10-5}{60}=\tfrac{17}{60}$ | $\tfrac{20}{60}$ | passes |

So the direction holds at odd $n$ as well as even, and $n=25$'s $(5,20)$, $\tfrac14+\tfrac1{19}-\tfrac1{24}=\tfrac{114+24-19}{456}=\tfrac{119}{456}$ against $\tfrac{152}{456}$, passes with room, consistent with its $\theta^2=912/575$. **No finding.**

*One scope remark, not a defect.* The lemma states only the ⟹ direction: above the threshold, the point is a sphere product with $p,q\ge5$. The converse just verified (every such product **is** above the threshold), is a strictly stronger biconditional, and it is on the record at [graded-half.md](../findings/graded-half.md):431 (*"Sphere products exceed the rival maximizer's value **exactly when** $p,q\ge5$"*) rather than in either citable form of L69. A consumer wanting the converse must cite that line, not L69.

### 4.3 Direction B, nothing with a factor $\le4$ ever clears it, at any $n$

- **$p=4$.** $\tfrac1{p-1}=\tfrac13$ exhausts the budget exactly, so $S\le\tfrac13\iff\tfrac1{q-1}\le\tfrac1{n-1}\iff q\ge n$. Since $n=4+q>q$, **impossible at every $n$**, with no case check, exactly as the block says. Equivalently $\tfrac1{q-1}-\tfrac1{n-1}>0$ strictly, since $n>q$.
- **$p=3$.** $\tfrac1{p-1}=\tfrac12>\tfrac13$ and the remainder is strictly positive, so $S>\tfrac13$ a fortiori. **$p=2$:** $\tfrac1{p-1}=1$. Both fail outright.
- **$p=1$** is a different kind of exclusion and the block handles it in a parenthetical rather than in the inequality: $f(1)$ is undefined and $\tfrac1{p-1}$ divides by zero. The warrant is r502's separate case, two summands, Ricci forcing both coefficients to zero, hence **no equivariant point at all**. *This is correct but it is not the split inequality, and a consumer reading only the inequality would find a division by zero where the record intends an emptiness statement.* Recorded, not counted as a defect: the block does say it.

**Cross-check against the closed form.** At $p=4$, $\theta^2\ge\tfrac32\iff4(n-1)\cdot3\cdot(q-1)\ge3(n-2)\cdot4q\iff(n-1)(q-1)\ge(n-2)q$, and substituting $n=q+4$ gives $(q+3)(q-1)\ge(q+2)q$, i.e. $q^2+2q-3\ge q^2+2q$, i.e. $-3\ge0$. **False at every $q$**, agreeing with the $S$-route. The two routes are the same inequality, as §4.1 proved, so they had to agree; the check is that neither was mis-transcribed.

**And $(4,8)$ at $n=12$ is the concrete witness**: $S=\tfrac13+\tfrac17-\tfrac1{11}=\tfrac{77+33-21}{231}=\tfrac{89}{231}$ against $\tfrac13=\tfrac{77}{231}$ (fails by $\tfrac{12}{231}=\tfrac4{77}$) and $\theta=1.2015615<\sqrt{3/2}=1.2247449$. **No finding.**

### 4.4 $k\ge3$, and the "every factor is a sphere" step

**The budget argument is right.** With $k$ factors, $B=\tfrac18\bigl(k-1+\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\bigr)>\tfrac18\bigl(k-1-\tfrac1{n-1}\bigr)$, so at $k=3$ and $n\ge12$, $\lVert W\rVert^2>\tfrac18\bigl(2-\tfrac1{11}\bigr)=\tfrac{21}{88}$, and $\tfrac{21}{88}>\tfrac16=\tfrac{88}{528}$ since $\tfrac{21}{88}=\tfrac{126}{528}$. **Exceeded by more than $40\%$**, and increasing in $k$. The block is also right that the first version's argument (a global minimum at $k=2$ balanced), constrains nothing at $k=3$.

**DISCREPANCY, the citation for "every factor is a sphere" over-credits L47, and its link is dead.**

**Located.** [graded-half.md](../findings/graded-half.md):379: *"every factor is a sphere by [Lemma L47](fence-posts.md)'s quantitative $\lVert W_a\rVert^2\ge\tfrac16$."*

**Exhibited, twice.** (i) The link target holds no L47: [fence-posts.md](../findings/fence-posts.md) contains zero occurrences of the string, and L47's canonical block is [problem.md](../findings/problem.md):221 with the statement at [results.md](../results.md):525. (ii) L47's own statement is *"for a compact irreducible symmetric space of **rank $\ge2$**, and for $\mathbb{OP}^2$"*. A product factor may be rank one and not a sphere ($\mathbb{CP}^m$ or $\mathbb{HP}^m$) and for those the bound comes from Lemmas L10 and L38, which L47's own block names as a separate residue. So the sentence credits L47 with a range twice as wide as it has.

**Argued the opposite.** The most charitable reading: L47 is the *name* the record gives the whole $\lVert W\rVert^2\ge\tfrac16$ theorem, whose boxed form at [graded-half.md](../findings/graded-half.md):116 does say *"on every compact irreducible symmetric space"* with the rank-one residue discharged at :114. Under that reading the citation is to the theorem, not the lemma, and the range is right. **The reading is available and I accept it for the conclusion**, but the block writes "Lemma L47" and links a file with no L47 in it, so the consumer cannot get there.

**Impact: none on the conclusion.** Even the tightest factor, $\mathbb{CP}^2$ at $\lVert W\rVert^2=\tfrac16$ exactly, cannot survive: with $k=2$ the partition term alone is $B>\tfrac18\bigl(1-\tfrac1{n-1}\bigr)\ge\tfrac18\cdot\tfrac{10}{11}=\tfrac5{44}$ at $n\ge12$, so $\lVert W\rVert^2>\tfrac16+\tfrac5{44}$, far above the budget. The step survives; the citation does not carry it.

**What would break it.** A non-sphere irreducible symmetric space with $\lVert W\rVert^2<\tfrac16-\tfrac5{44}$, i.e. $\theta>\sqrt{3/2}\cdot\bigl(1-\tfrac{30}{44}\bigr)^{-1/2}$. Nothing on the record approaches it (the record's minimum over non-spheres is exactly $\tfrac16$ at $\mathbb{CP}^2$) and I looked at the two rank-one families and $\mathbb{OP}^2$, which L47 covers directly.

## 5. The Einstein hypothesis, imported and unstated

**Located.** The block's arithmetic half opens *"the condition $\lVert W\rVert^2\le\tfrac16$"* ([graded-half.md](../findings/graded-half.md):371) and the canonical form writes *"the condition $\lVert W\rVert^2\le\frac16$ reads $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$"* ([results.md](../results.md):555). **Neither says what makes $\lVert W\rVert^2\le\tfrac16$ the reading of the hypothesis $\theta\ge\sqrt{3/2}$.**

**Exhibited.** It is [L46](../results.md):292, $\theta=1/(2\lVert W\rVert)$, whose hypotheses [results.md](../results.md):106 states as **locally symmetric, Einstein, $\lambda\ne0$**, under the Einstein normalisation. And the reducible half is [L48](../findings/problem.md):234, whose Theorem carries **Einstein** because [r462](../reviews/REVIEW_r462.md)/[r463](../reviews/REVIEW_r463.md) found the quantifier too wide: *"a reducible symmetric space whose factors carry different Einstein constants is not Einstein, so the formula never applied to it."* [LEDGER.md](../findings/LEDGER.md):235 records the repair and lists the sites where "Einstein" was added, [results.md](../results.md), a mirrored Theorem in [graded-half.md](../findings/graded-half.md), three sites in [report/](../report/). **L69 is not among them, and it is a consumer of exactly the identity that was repaired.**

**Argued the opposite, and this is the reading I think is correct.** The material that discharges the debt is on the record in two places. [graded-half.md](../findings/graded-half.md):122 says *"the Einstein normalisation forces every factor of a product to be Einstein with the same constant $\tfrac12$"*, which fixes the class L48 quantifies over. More decisively, [r502](../reviews/REVIEW_r502.md):44 does not merely count the commutant, it **names the spanning vector**, $(a,b,c)=\bigl(\tfrac q{p-1},\tfrac p{q-1},-1\bigr)$, and identifies it with $W_{S^p\times S^q}$. Once the commutant is one-dimensional and its generator is named, every $\mathrm{ad}(\mathfrak p)$-invariant Weyl operator at that grading is a multiple of the Einstein product's, so the Einstein normalisation is not a restriction on the class but a choice of representative on a single ray.

**Why it is still a gap and not a pass.** *I am not entitled to install that argument and call it checked.* The block does not take that route: it routes the threshold through the irreducible/reducible dichotomy of L47 and L48, and that route consumes Einstein at both ends. What is owed is one sentence in the citable forms, either "the Einstein normalisation is available because the commutant is spanned by the Einstein product's Weyl operator", or the Einstein hypothesis stated outright. **Named exactly: a consumer must be shown that an equivariant graded critical point at an $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ grading corresponds to a product carrying equal Einstein constants, which is what L46's identity needs and what L48's Theorem was repaired to require.**

## 6. Quantifier order, scope, and the universal claim tried against witnesses

### 6.1 Quantifier order

The statement reads: for all $n\ge12$, for all $W$ (equivariant, graded, critical, $\theta\ge\sqrt{3/2}$), there exist $p,q\ge5$ with $W=W_{S^p\times S^q}$; **and** for all such $(p,q)$, the point is nondegenerate. **The order is sound**: nothing in the proof quantifies over $(p,q)$ before $W$, and the second conjunct is a statement about the splits the first produces, not about $W$. One consequence the record states and I confirm: the second conjunct makes L69 assert that **each** admissible split is a local maximum, so at even $n\ge12$ the $(n/2,n/2)$ coordinate slice carries at least two, which [graded-half.md](../findings/graded-half.md):325 uses to refute a uniqueness claim elsewhere. That is a consistent use, not a circularity: it consumes L69 rather than feeding it.

### 6.2 The edge of every range

| edge | verdict |
|---|---|
| $n=12$ exactly | **safe and tight.** The first admissible split clears by $\tfrac1{132}$ in $S$ and $\tfrac1{1056}$ in $\lVert W\rVert^2$; $n=11$ admits nothing |
| **odd $n$** | **safe.** $(5,8)$ and $(6,7)$ at $n=13$ both pass; the $\mathfrak u(m)$ grading does not exist at odd $n$, so the enumeration is *shorter*; and the record's own odd witness at $n=25$ confirms the family reaches above the threshold at odd dimensions |
| $(p,q)=(5,7)$ | **safe**, and it is the tightest point of the whole lemma |
| $(p,q)=(4,8)$ | **excluded**, by $S=\tfrac{89}{231}>\tfrac{77}{231}$ and independently by $\theta^2=\tfrac{231}{160}<\tfrac32$ |
| $\ker W\ne0$ | **outside the lemma, and the block does not say so.** [results.md](../results.md):555 ends *"$\Delta=0$ certifies equivariance only where $\ker W=0$"*; the block at :363–385 carries no such clause, it is in the labelling table at :388–400. See §8.3 |
| $\theta=\sqrt{3/2}$ exactly | **the sharp edge**, and it is decided by the *sense* of "graded" rather than by any inequality. See §6.3 |

### 6.3 The universal claim, tried against one object from each structured family

**Three-step record for each candidate.**

**(a) $\mathbb{CP}^6$ at $n=12$, the only non-$\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ grading in range.** *Locate:* the $\mathfrak u(6)$ grading of $\mathfrak{so}(12)$, whose unique invariant is $W_{\mathbb{CP}^6}$ by the $3-1-1$ count. *Exhibit:* $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ at $m=6$ is $\frac{7\cdot11}{3\cdot6\cdot5}=\frac{77}{90}$, so $\theta=0.9249622$, matching the block's $0.924962$ to every printed digit; the family's four recorded values are $\tfrac{10}9$, $\tfrac{35}{36}$, $\tfrac9{10}$, $\tfrac{77}{90}$ at $m=3,4,5,6$, giving $1.0540926$, $0.9860133$, $0.9486833$, $0.9249622$, **all four exact**. *Argue the opposite:* the family is strictly decreasing with peak $\tfrac32$ at $m=2$, i.e. $\mathbb{CP}^2$ at $n=4$; there is no $m\ge6$ member near the threshold. **Not a falsifier**, and it is the family the block correctly says must be excluded by the threshold rather than assumed away.

**(b) Padded $W_{\mathbb{CP}^2}$ at $n=12$, the boundary object, and the sharpest test here.** *Locate:* $\theta=\sqrt{3/2}$ **exactly**, for every $n$ ([problem.md](../findings/problem.md):250: padding preserves Ricci-flatness and $\theta$), so it satisfies the lemma's non-strict hypothesis $\theta\ge\sqrt{3/2}$, and it is not a sphere product. *Exhibit:* it is critical, it is slice-graded (sense B), and [r317](../reviews/REVIEW_r317.md):158 reports it Morse–Bott nondegenerate with $\lambda_{\max}=\tfrac12$ at $n=8,10$. *Argue the opposite:* it is **not pair-graded**, by r317:125's dimension-and-ideal argument, $\dim\mathfrak k(W)=32$ at $n=12$, while the only symmetric subalgebras of smaller dimension are $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ at $30$ and $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ at $31$, both semisimple, so every simple factor must land in the $\mathfrak{so}(8)$ summand of dimension $28$, and $30>28$, $31>28$. **Not a falsifier of L69, and only because L69 is sense (C).** *Under sense (B) it is a counterexample to the statement word for word*, which is exactly what r317:135 records: *"Lemma L69 does not reach it, and padded $W_{\mathbb{CP}^2}$ is itself a slice-graded critical point at the threshold that is equivariant for no grading"*. **So the non-strict $\ge$ in the statement is load-bearing on the labelling, and the labelling is not in the block.**

*A one-dimension discrepancy in that argument, harmless.* r317 writes the stabiliser as $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ at :119, dimension $4+28=32$, and as $\mathfrak{su}(2)\oplus\mathfrak{so}(8)$ at :125, dimension $31$; [graded-half.md](../findings/graded-half.md):394 copies the second. A semisimple subalgebra of $\mathfrak u(2)\oplus\mathfrak{so}(8)$ lies in $\mathfrak{su}(2)\oplus\mathfrak{so}(8)$, so the exclusion is unaffected.

**(c) The odd Pell point, $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$.** *Locate:* the family where L8's pinning formula has a pole, reaching above the rival maximiser at odd $n$. *Exhibit:* $\theta^2=\tfrac{912}{575}=1.586\ldots>\tfrac32$, computed above from the closed form, at $n=25$ with both factors $\ge5$. *Argue the opposite:* it is a two-factor sphere product with $p,q\ge5$, so it **confirms** the lemma rather than threatening it. **Not a falsifier**, and it is the witness that answers question 1's clause about pairs where the pinning has no value.

**(d) $\mathbb{HP}^3$ at $n=12$, a non-sphere-product rank-one family.** *Locate:* $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}=1.1155467<\sqrt{3/2}$, attained at $m=2$. *Exhibit:* it fails the threshold at every $m$; and its isotropy $\mathfrak{sp}(1)\oplus\mathfrak{sp}(3)$, of dimension $3+21=24$, is not among the $\mathbb Z_2$-gradings of $\mathfrak{so}(12)$, which are $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(6)$. *Argue the opposite:* none available, it is outside the scope twice over. **Not a falsifier.**

**(e) A non-sphere-product graded critical point: the second point on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$.** *Locate:* [graded-half.md](../findings/graded-half.md):427, $\theta=1.088948$ against $S^3\times S^5$'s $1.115547$ on the identical pair, same isotropy Killing spectrum, trivial kernel. *Exhibit:* it is graded and not a sphere product, so if "equivariant" were decorative, L69 would be false at $n=8$. *Argue the opposite:* it has $\Delta=1.512231$ and five distinct positive eigenvalues, so it is **not equivariant**; and $n=8<12$. **Not a falsifier, and it is the object that shows the equivariance hypothesis is doing real work.**

**(f) The exceptional pairs, $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$.** *Locate:* the two gradings the enumeration is short by, at $n=8$ only, through triality. *Exhibit:* the record holds their point, $\mathbb{HP}^2=\tau(S^3\times S^5)$ at $\theta=1.115547$. *Argue the opposite:* $1.115547<\sqrt{3/2}$, and $n=8<12$. **Not a falsifier**, and the block's claim that L69 is *"unaffected, twice over"* is correct on both counts.

### 6.4 What would falsify the universal form, and where I looked

By §3, at any grading in the enumeration the invariant line is one-dimensional and its generator is named. **So a falsifier must be an equivariant graded critical point at $n\ge12$ sitting at a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ that is neither $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ nor $\mathfrak u(n/2)$**, i.e. it must falsify the enumeration itself, not the count. That is exactly the item with no source in [references/](../references/) (§2.2). **I looked for it by reading the record's own account of the enumeration's completeness at [graded-half.md](../findings/graded-half.md):404, trap [W2](../findings/INDEX-traps.md):20 and [r318](../reviews/REVIEW_r318.md):97 (all three assert $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ and none sources it) and by checking [references/](../references/) for a classification text, finding none, and reading the one gradings reference the record does hold, [reeder-2013](../references/reeder-2013-gradings-positive-rank/notes.md), whose derivation is for order 3.** The record itself has been short by two gradings once, at $n=8$, found by r318, which is the strongest available reason to want the order-2 statement sourced rather than asserted.

## 7. Pre-registered question 3, is "each is nondegenerate" the same statement the record proves?

### 7.1 Where it is established, and its range

**[Lemma L27](../findings/nondegeneracy.md):457**, canonical statement and proof, with the landscape line at [results.md](../results.md):140. Its range is $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$ exactly. **L69's range $p,q\ge5$ sits strictly inside it**, so the citation is in range with room, and the block's stated warrant (*"$p,q\ge5$ implies $p,q\ge3$ with $(p,q)\ne(3,3)$"*), is correct.

**The two exclusions fail differently and neither touches L69**: at $(3,3)$ the decomposition holds and two scalars collide, $\mu=\tfrac12$ with $\dim E(\tfrac12)=18$ against an orbit of $9$; at $q\le2$ the ten-summand decomposition is itself false. Both are far below $p,q\ge5$.

### 7.2 Does the citation reach what is *proved*, or what is *claimed*?

**What is proved.** L27's argument needs the ten-summand decomposition to be multiplicity-free. [nondegeneracy.md](../findings/nondegeneracy.md):457 is explicit about the division of labour: *"The multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$… **The $p,q\ge5$ case is proved in the source**"*, [Nienhaus, arXiv:2311.02404](https://arxiv.org/abs/2311.02404), Proposition 4.6 and Remark 4.7(ii), which **is** in [references/nienhaus-2023-second-best-einstein](../references/nienhaus-2023-second-best-einstein/notes.md). **So L69 consumes exactly the half that rests on a read source, and none of the half supplied by computation.** That is the cleanest import in the whole lemma.

**Gate 2 status.** L27 is CONFIRMED by [r529](../reviews/REVIEW_r529.md) and [r530](../reviews/REVIEW_r530.md) on identical briefs, agreeing on all six attack lines, both deriving $\operatorname{tr}_{\mathcal W_n}L_e=0$ independently, which forces the one eigenvalue the block had sourced wrongly and discriminates the assignment the file was unsure of. [LEDGER.md](../findings/LEDGER.md):804 records that **L69's nondegeneracy half sits strictly inside L27's scope**, so the support is current. **No finding.**

### 7.3 The two exact numbers, checked

**$\lambda_{\max}=\tfrac12$ attained on the orbit tangent alone.** The orbit dimension is
$$\dim O(n)-\dim\bigl(\mathfrak{so}(p)\oplus\mathfrak{so}(q)\bigr)=\tfrac{n(n-1)}2-\tfrac{p(p-1)}2-\tfrac{q(q-1)}2=\tfrac{(p+q)^2-p^2-q^2}2=pq,$$
the linear terms cancelling because $p+q=n$. **Exactly $\dim E(\tfrac12)=pq$, so the multiplicity is the orbit and the excess is zero.** L27's separating inequality is $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which at $(5,7)$ is $\frac{3\cdot5-1}{2\cdot4\cdot6}=\frac{14}{48}=\frac7{24}>0$, and at $(6,6)$ is $\frac{4\cdot4-1}{2\cdot5\cdot5}=\frac{15}{50}=\frac3{10}>0$. **No finding.**

**The gap figure $\tfrac1{2(M-1)}$, and $\tfrac1{12}$ at $S^5\times S^7$: the block is RIGHT.** On $W^\perp$ the ten values are $\tfrac12$ on the orbit summand, $\lambda_m=\frac{m-2}{2(m-1)}$ on each $S^2_0(\mathbb R^m)$, $\pm\mu$ with $\mu=\frac{n-2}{2(p-1)(q-1)}$, and $0$ on the remaining four. At $(5,7)$: $\lambda_5=\tfrac3{8}$, $\lambda_7=\tfrac5{12}$, $\mu=\tfrac{10}{48}=\tfrac5{24}$. **The second largest is $\lambda_7=\tfrac5{12}=\tfrac{10}{24}$, so the gap is $\tfrac12-\tfrac5{12}=\tfrac1{12}$**, the block's figure. $\tfrac7{24}$ is $\tfrac12-\mu$, a *different* eigenvalue's gap.

**DISCREPANCY, and it is in the ledger, not in the lemma.** [LEDGER.md](../findings/LEDGER.md):770 states, in bold, *"the report's margin paragraph for L69, which reads $\tfrac1{12}$ at $S^5\times S^7$ where the true figure is $\tfrac7{24}$"*, over a five-row table of "block's value" against "true gap". **Four lines below, the same entry withdraws itself**: *"The validation above is withdrawn, and the correction it licensed was reverted before commit… which of them is the spectral gap was taken from the reviewers rather than checked against the record. The table above therefore inverted the comparison… Reverted, uncommitted."* **A reader who stops at the bolded sentence inherits a refuted correction and will "fix" a correct number.** This is the record's named failure mode, occurring in the ledger's own bookkeeping.

**The one thing that survives that entry, checked against L69's range.** [r527](../reviews/REVIEW_r527.md)'s witness: at $(3,4)$, $\mu=\tfrac5{12}$ overtakes $\lambda_M=\tfrac13$, so the clause $\tfrac1{2(M-1)}$ needs the exception $(3,4)$ as well as $(3,3)$. **It does not reach L69.** For $p,q\ge5$, $\lambda_M>\mu$ always:
$$\lambda_M>\mu\iff\frac{M-2}{M-1}>\frac{n-2}{(p-1)(q-1)}\iff(M-2)(m-1)>M+m-2\iff M(m-2)>3m-4,$$
and with $M\ge m\ge5$, $M(m-2)\ge m(m-2)$, so $M(m-2)-(3m-4)\ge m^2-5m+4=(m-1)(m-4)\ge4>0$. **Strict at every $p,q\ge5$, so the gap formula is valid exactly on L69's range.** No finding against the lemma; the exception must travel wherever the clause is stated without a range.

**And the block is right that the margin is small.** $\tfrac1{2(M-1)}\le\tfrac1{n-2}$, decaying like $1/n$; $\tfrac1{12}$ at $S^5\times S^7$. The block's warning (*"Nondegeneracy is unaffected; any argument that spends the margin is"*), is exactly the right scoping, and it is one of the few places in the record where a correction is stated as a positive constraint on consumers.

## 8. The four forms compared, and the named trap

### 8.1 The forms

| form | scope caveats it carries | verdict |
|---|---|---|
| [graded-half.md](../findings/graded-half.md):363–385, the block | **none in the block itself.** The sense-(C) labelling is at :388, the $n\ne8$ quotation rule at :404–415, the $\ker W=0$ condition at :392 | **the least safe form.** Everything a consumer needs to *scope* the lemma sits 5–50 lines downstream of the $\square$ |
| [results.md](../results.md):553, canonical | **all three**: *"stated in the pair-graded sense and reaches no non-equivariant graded point; the $\mathbb Z_2$-grading enumeration it quotes is complete for $n\ne8$; and $\Delta=0$ certifies equivariance only where $\ker W=0$"* | **the safe citation.** It also names L27 for nondegeneracy and L47/L48 for the two halves, which the block leaves to a link |
| [results.md](../results.md):180, landscape | none | acceptable as an index line; it is not a citable statement of scope |
| [INDEX-results.md](../findings/INDEX-results.md):83 | records the Gate 2 verdict *"both halves true, three of the proof's sentences unwarranted"* | **accurate**, and it is the row that told me where to look |

**The forms agree on the mathematics.** I found no numerical or logical disagreement between them: same $n\ge12$, same $p,q\ge5$, same split condition, same $\lambda_{\max}=\tfrac12$ on the orbit tangent. What differs is how much scope travels with the sentence.

### 8.2 The Lean row

**Two rows in [lean/INDEX.md](../lean/INDEX.md) point at the same file** (:226 marked **proved** and :261 marked **partial**) which is a bookkeeping duplication rather than a contradiction, since they describe complementary halves and neither overstates. [L69.lean](../lean/HamiltonsCubic/Results/L69.lean) defines `budget p q = 1/(p-1) + 1/(q-1) - 1/(p+q-1)` over $\mathbb Q$ and proves: `five_five_fails` ($7/18$), `five_six_fails` ($7/20$), `five_seven_passes`, `six_six_passes`, `constraints_are_distinct`, `p_four_exhausts`, `remainder_positive`, `p_four_never_admissible` (for all $q\ge2$), `p_three_exceeds`. Row :261 adds the $p=5$ reduction to `q² + 3q - 64 ≥ 0`, which I confirm by hand: $S\le\tfrac13$ at $p=5$ is $(q-1)(q+4)\ge60$, i.e. $q^2+3q-4\ge60$, i.e. $q^2+3q-64\ge0$, and over the integers $q=6$ gives $-10$ and $q=7$ gives $+6$, so $q\ge7$ and $n\ge12$. **Identical to §4.2's $n$-form**, $(n-6)(n-1)\ge60$.

**Both rows are honest about what is out**: :226 lists as owed *"the invariant count and the reducible-case norm decomposition, both imported"*; :261 says *"the rest of L69 is representation theory and is out"*; and :362 lists **L69 (beyond its split condition)** among the results blocked on branching and isotypic decompositions of $\mathfrak{so}(n)$. **No Lean row claims any part of §3, §5 or §7.** *If a row for the representation-theoretic half is ever wanted, it would have to claim: at every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ the space of $\mathrm{ad}(\mathfrak p)$-invariant elements of $\mathcal W_n$ is one-dimensional, which is §3's count, and which needs the enumeration of §2 as an input the layer has no types for.*

### 8.3 The named trap, each citable claim read alone

**(i) The $\mathfrak u(m)$ sentence, still false read alone.** [graded-half.md](../findings/graded-half.md):383 ends: *"so **an equivariant graded critical point on a pair is the sphere product's Weyl tensor, uniquely up to scale**, with no appeal to the classification of symmetric spaces."* Read alone this is **false**: at a $\mathfrak u(m)$ pair the unique invariant is $W_{\mathbb{CP}^m}$, not a sphere product. [r317](../reviews/REVIEW_r317.md):95 says so in terms (*"the sentence drawn from it … is **false as written**"*) and the repair applied was to insert the $\mathfrak u(m)$ exclusion **ahead of** the sentence and leave the sentence unchanged. **This is the record's signature failure, at the sentence a consumer is most likely to lift**, because it is the bolded conclusion of the paragraph. *Charitable reading, which I accept for the paragraph:* the "so" chains it to the threshold exclusion just established, so under $n\ge12$ and $\theta\ge\sqrt{3/2}$ it is true. **The repair owed is two words ("at an $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ pair") which the same paragraph already uses forty words earlier.**

**(ii) "with no appeal to the classification of symmetric spaces" and "needing no classification at all".** Both are **false as stated**. The count runs *"at every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$"*, and knowing what those are is the classification of involutive automorphisms of $\mathfrak{so}(n)$, the same Cartan content, one level down, and the level at which this record has already been caught short by two rows at $n=8$. r317:95 had already priced it: *"a smaller appeal, not none."* **The block kept "none".** What is true, and worth saying positively: the argument no longer needs the classification of symmetric *spaces* by their curvature data, only the enumeration of *gradings*, which is a much shorter list and one the record tabulates.

**(iii) The withdrawn ledger correction.** §7.3: [LEDGER.md](../findings/LEDGER.md):770 reads as a live correction to L69's $\tfrac1{12}$ and is retracted four lines later. **A consumer reading the bold sentence alone would change a correct number to a wrong one.**

**(iv) The dead L47 link.** §4.4: the block links [Lemma L47](../findings/problem.md) to [fence-posts.md](../findings/fence-posts.md), which contains no L47.

**(v) The block carries no scope at all.** A consumer who reads :363–385 and stops gets no sense-(C) restriction, no $n\ne8$, no $\ker W=0$, and the sense-(C) restriction is, by §6.3(b), **the only thing standing between the lemma and padded $W_{\mathbb{CP}^2}$ at exactly $\sqrt{3/2}$**.

## 9. The gap between what is proven and what is used, what a consumer may cite

**May be cited without qualification:**

- For $n\ge12$, a two-factor sphere product $S^p\times S^q$ satisfies $\theta\ge\sqrt{3/2}$ **if and only if** $p,q\ge5$; the condition is $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13$, equivalently $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}\ge\tfrac32$; at $p=5$ it is $n^2-7n-54\ge0$. *(Both directions, both parities, exact, §4. The "only if" is the lemma; the "if" must be cited to [graded-half.md](../findings/graded-half.md):431.)*
- No split with a factor $\le4$ satisfies it at any $n$, and $k\ge3$ factors exceed the budget at $k=3$ already. *(§4.3, §4.4.)*
- Every $S^p\times S^q$ with $p,q\ge5$, $n=p+q$, is Morse–Bott nondegenerate with $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ attained exactly on the orbit tangent, $\dim E(\tfrac12)=pq$; the gap to the second eigenvalue is $\tfrac1{2(M-1)}$, $M=\max(p,q)$. *(§7, this is L27's, in range, resting on a read source.)*

**May be cited with the qualification stated:**

- The classification conclusion, *above $\sqrt{3/2}$ at $n\ge12$ the only equivariant graded critical points are these sphere products*, **in the pair-graded sense (C) only**, and relative to the completeness of the $\mathbb Z_2$-grading enumeration. **Cite [results.md](../results.md):553**, which says both.

**May NOT be cited:**

- *"An equivariant graded critical point on a pair is the sphere product's Weyl tensor"* without "at an $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ pair", false at $\mathfrak u(m)$.
- *"Needing no classification at all"* / *"with no appeal to the classification of symmetric spaces"*, the enumeration of gradings is the appeal, and it is the one input with no source in [references/](../references/).
- Anything that **spends** the nondegeneracy margin, which is $\tfrac1{12}$ and not $0.292$.
- [LEDGER.md](../findings/LEDGER.md):770's $\tfrac7{24}$ correction, withdrawn in its own entry.

## 10. Verdict

**GAP.**

**Both halves of the statement stand.** Every number in the block is exact and I reproduced all of them by hand: $7/18$, $7/20$, $1/132$, $4/165$, $1/1056$, $175/1056$, $264/175$, $55/36$, $231/160$, $176/135$, $912/575$, $77/90$, $35/36$, $9/10$, $10/9$, $n^2-7n-54$, $q^2+3q-64$, $pq$, $7/24$, $1/12$. The reduction from $\lVert W\rVert^2\le\tfrac16$ to the split inequality is exact; the $\lVert W\rVert$ route and the closed-form $\theta^2$ route are one identity, which I proved rather than checked at points; $p,q\ge5$ is right in both directions at both parities; and the nondegeneracy citation lands strictly inside L27's proved range, on the half that rests on a read source.

**What the written proof lacks:**

1. **HYPOTHESIS-DEBT, named exactly.** *What would have to be shown:* that $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$ exhaust the $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ for $n\ge12$, equivalently $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$, $n\ne8$. It is asserted at three sites, sourced at none, and [references/](../references/) holds no Cartan, Helgason, Berger or Besse entry. By §6.4 it is the **only** input a falsifier could attack.
2. **GAP.** The Einstein hypothesis of L46 and L48 is consumed by the threshold conversion and stated in neither citable form (§5). The material discharging it is in [r502](../reviews/REVIEW_r502.md), which names the spanning vector; the block quotes the count from that report and not the vector.
3. **GAP.** *"Uniform over the gradings rather than case-checked"* is refuted by the block's own three displays and by the source's own structure; [LEDGER.md](../findings/LEDGER.md) says "case by case" at :486 and the opposite at :490 (§3.2).
4. **Three sentences false or over-credited read alone** (§8.3): the $\mathfrak u(m)$ conclusion, the two "no classification" claims, and the L47 citation with its dead link.

**None of these is a counterexample, and I did not find one.** The object that would be one, an equivariant graded critical point at $n\ge12$ above $\sqrt{3/2}$ that is not a two-factor sphere product, would have to live at a grading outside the enumeration; the nearest thing on the record, padded $W_{\mathbb{CP}^2}$ at exactly $\sqrt{3/2}$, is excluded by the sense-(C) reading and by r317's dimension-and-ideal argument, and it is a counterexample to the sentence under sense (B).
