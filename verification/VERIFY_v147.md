# VERIFY v147, L69: the split condition $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$, the threshold $p,q\ge5$ at $n\ge12$, the enumeration of $\mathbb Z_2$-gradings behind "every equivariant graded critical point", and the nondegeneracy citation

**Cold brief.** Verifier v147, checking the block at [findings/graded-half.md](../findings/graded-half.md):363– with its canonical form at [results.md](../results.md):553 and the landscape line at [results.md](../results.md):180. **No numerical work was done: no script was run, and every value below is an exact hand evaluation over $\mathbb Q$.** Log: [agent_logs/verify-L69-v147.log](../agent_logs/verify-L69-v147.log).

## Claim table

| # | claim, as a consumer would read it | verdict |
|---|---|---|
| C1 | $\lVert W\rVert^2\le\tfrac16$ reduces to $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$ for a two-factor sphere product | **CORRECT**, and I re-derived it independently from the Nienhaus closed form |
| C2 | the reduced condition is *equivalent* to $\theta^2\ge\tfrac32$, not merely implied by it | **CORRECT**, both sides are $P(s+4)\ge3s(s+1)$, $s=n-2$, $P=(p-1)(q-1)$ |
| C3 | no split with a factor $\le4$ clears the threshold, at any $n$ | **CORRECT** at $p\in\{2,3,4\}$; **$p=1$ is asserted, not argued, in the block** (argued in [r502](../reviews/REVIEW_r502.md)) |
| C4 | every split with $p,q\ge5$ and $n\ge12$ clears the threshold | **CORRECT**, checked at both parities and at the boundary |
| C5 | $n\ge12$ is where an admissible split first exists | **CORRECT** |
| C6 | every $\mathfrak u(m)$ pair at $n=2m\ge12$ sits below $\sqrt{3/2}$ | **CORRECT**, $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$, all four quoted values reproduced exactly |
| C7 | "each is nondegenerate" is [Lemma L27](../findings/nondegeneracy.md), whose range $p,q\ge3$, $(p,q)\ne(3,3)$ strictly contains $p,q\ge5$ | **CORRECT, and the citation reaches what is proved**, from [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md), a read source |
| C8 | the gap to the second eigenvalue is $\frac1{2(M-1)}$, $M=\max(p,q)$, i.e. $\tfrac1{12}$ at $S^5\times S^7$ | **CORRECT and internally consistent**, $M=7$, $\frac1{2\cdot6}=\frac1{12}$ |
| C9 | the invariant count $3-0-2=1$, $4-1-2=1$, $3-1-1=1$ | **CORRECT and derived on file, but in [r502](../reviews/REVIEW_r502.md), not in the block**; the block states the numbers only |
| C10 | "at **every** $\mathbb Z_2$-grading of $\mathfrak{so}(n)$" (the enumeration | **HYPOTHESIS-DEBT), rests on an unread source.** No Cartan, Helgason, Berger or Besse entry exists in [references/](../references/) |
| C11 | the reducible step $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B(n_1,\dots,n_k)$, imported from [Lemma L48](../findings/problem.md) | **HYPOTHESIS-DEBT, L48's own boxed correction makes Einstein load-bearing; L69 never states or discharges it** |
| C12 | "every factor is a sphere by [Lemma L47](../findings/problem.md)'s quantitative $\lVert W_a\rVert^2\ge\tfrac16$" | **BROKEN CITATION twice over**, wrong file, and the citable L47 does not carry the rank-one factors |
| C13 | the repaired joint is supported by measurements at $(3,5),(4,4),(2,6)$ at $n=8$ and $(5,5),(4,6)$ at $n=10$ | **the same defect the block convicts its own first version of**, every witness is outside $n\ge12$ |
| C14 | "$\Delta=0\Rightarrow$ L69 applies" | **guarded at [results.md](../results.md):553, unguarded in the block and at [results.md](../results.md):180** |

**One line.** The arithmetic that is new here is right and I re-derived all of it by hand, including the equivalence the block never states; what L69 does not own are three imports (the grading enumeration (unread source), L48's Einstein hypothesis, and L47's rank-one coverage) so the verdict is **HYPOTHESIS-DEBT**, with nothing refuted.

## 0. Conventions, fixed once

- $n=p+q$ throughout; $p\le q$ without loss. $\mathcal W_n$ is the space of Weyl operators on $\Lambda^2\mathbb R^n$; $\theta$ is the cubic evaluated at $\lVert W\rVert=1$.
- $f(m)=\frac m{8(m-1)}=\frac18\bigl(1+\frac1{m-1}\bigr)$, defined for $m\ge2$ and **undefined at $m=1$**. This matters once, at C3.
- Symmetric spaces are normalised to Einstein constant $\tfrac12$, which is what makes $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$ ([Lemma L46](../findings/problem.md), quoted inside [Lemma L47](../findings/problem.md)). Under that normalisation $\theta=\tfrac12/\lVert W\rVert$, so $\theta^2=\frac1{4\lVert W\rVert^2}$ and $\theta\ge\sqrt{3/2}\iff\lVert W\rVert^2\le\tfrac16$. **I verify this identity in §1 rather than assume it**, because the block uses the two conditions interchangeably and states the bridge nowhere.
- Abbreviations for the three senses of "graded" are the record's own, at [graded-half.md](../findings/graded-half.md):280–: **(C)** pair-graded, **(A)** sign-graded ($\ker W=0$ plus the bracket relations), **(B)** slice-graded. L69 is **(C)**.
- Write $a=p-1$, $b=q-1$, $s=a+b=n-2$, $P=ab$. Every rational below is exact.

## 1. The hypothesis inventory

**A pass without this section is not a pass, so it comes before any derivation.**

### 1.1 Hypotheses the block carries in its own statement

| # | hypothesis | where it is used in the written proof |
|---|---|---|
| H1 | $n\ge12$ | *nowhere as an input.* The block says so explicitly: "$n\ge12$ enters as the dimension at which an admissible split first exists, rather than as a hypothesis the argument consumes." I confirm this in §3: the proof derives $n\ge12$, and the only place the hypothesis is *consumed* is in silently excluding the $n=8$ exceptional gradings and the $n=4$ point $\mathbb{CP}^2$ |
| H2 | the point is a **critical** point of $\theta$ | via [Lemma L46](../findings/problem.md)'s $Q(W)=\lambda W$, which is what makes $\theta$ quadratic and the $f$-budget available at all |
| H3 | the point is **graded**, in sense (C) | to have a symmetric pair, hence a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$, hence the enumeration |
| H4 | the point is **equivariant**, i.e. $\mathrm{ad}(\mathfrak p)$-invariant | to make the invariant count bite: the count bounds the $K$-invariant Weyl operators, and a non-equivariant graded point is not among them |
| H5 | $\theta\ge\sqrt{3/2}$ | converted to $\lVert W\rVert^2\le\tfrac16$ and spent on the budget |

### 1.2 Hypotheses of every imported result, checked against the object L69 applies it to

| import | its hypotheses | does L69's object satisfy them? |
|---|---|---|
| [Lemma L47](../findings/problem.md) (irreducible case) | compact irreducible symmetric space **of rank $\ge2$**, or $\mathbb{OP}^2$; normalised to Einstein constant $\tfrac12$ | **Partly.** Irreducible symmetric spaces are Einstein, so the normalisation is available. But the rank-one spaces are *not* in the citable statement, [results.md](../results.md):525 defers them to "the families of Lemmas 10 and 38". The $\lVert W\rVert^2\ge\tfrac16$ bound for $\mathbb{CP}^m$ and $\mathbb{HP}^m$ exists only in the proof prose at [problem.md](../findings/problem.md):228 |
| [Lemma L48](../findings/problem.md) (reducible case) | a **product**, and (per its own boxed correction), **Einstein**, i.e. all factors carrying the *same* Einstein constant | **NO, not checked, and not derivable from H1–H5 as written.** See §5 |
| [Lemma L47](../findings/problem.md) again, as "$\lVert W_a\rVert^2\ge\tfrac16$ per factor" | same, applied to each factor in its own dimension $n_a$ | the factor must itself be Einstein at constant $\tfrac12$, the same debt as L48; and "vanishes exactly when that factor is a sphere" over-states L47, which gives $W=0$ for **every** space form, $\mathbb{RP}^{n_a}$ included |
| [Lemma L27](../findings/nondegeneracy.md) (nondegeneracy) | $p,q\ge3$, $(p,q)\ne(3,3)$, **$n=p+q$** (no padding) | **YES, with room.** $p,q\ge5$ implies both, and $n=p+q$ holds by construction. Its own input (multiplicity-freeness of the ten summands), "is proved in the source" for $p,q\ge5$, [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Prop 4.6 / Rem 4.7(ii), which **is** in [references/](../references/) |
| the closed form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ | a two-factor sphere product | **YES**, Nienhaus Prop 2.25 at $(k,l)=(p,q)$, a read source |
| the **enumeration** of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ | $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$, $n\ne8$ | **UNREAD SOURCE.** [references/](../references/) holds no Cartan, Helgason, Berger or Besse entry; I checked [references/INDEX.md](../references/INDEX.md) and the directory listing. [reeder-2013-gradings-positive-rank](../references/reeder-2013-gradings-positive-rank/notes.md) is present and its own notes say in a heading: "this paper does NOT cover $\mathfrak{so}(n)$" |
| the invariant count | a $\mathbb Z_2$-grading with $K$ connected; branching of $\Lambda^2\mathbb R^n$ and $(\Lambda^4\mathbb R^n)^K$ | **YES where derived**, [r502](../reviews/REVIEW_r502.md) discharges it case by case for $p=0,1,2,3,4$, $p,q\ge5$, and $\mathfrak u(m)$. It is *not* derived in the block |
| [Lemma L8](../findings/graded-half.md), the **pinning formula** | balanced splits, $2q\ne p$ | **NOT IMPORTED, correctly.** See §2, Q1 |

### 1.3 Which of these the written proof actually uses

The written proof runs **two routes and needs only one of them at a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$**:

- **Route 1, inside the $\square$:** correspondence $\to$ compact symmetric space $\to$ L47 (irreducible) and L48 (reducible) $\to$ the $f$-budget $\to$ $p,q\ge5$, $n\ge12$. This route carries the L47 and L48 debts of §1.2.
- **Route 2, *after* the $\square$:** the $\mathrm{ad}(\mathfrak p)$-commutant is one-dimensional, so the point *is* the pair's Weyl tensor. This route carries no Einstein debt and no rank-one debt, and it is the one [ATTEMPTS.md](../ATTEMPTS.md):2595 records as the replacement for the broken cited step.

**Route 2 is placed outside the proof.** The paragraph beginning "The assembly's weakest joint is repaired" sits after the $\square$, so a consumer who reads only the proof gets Route 1 and inherits both of its debts. That placement is this record's named trap operating exactly as described.

## 2. The three pre-registered questions

### Q1, what enumerates "every equivariant graded critical point"?

**The enumeration is the classification of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ up to conjugacy, and it is a classification, not a sweep.** It is stated as a four-row table at [graded-half.md](../findings/graded-half.md):402–, and reduced there to one classical fact: $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$ with $n=8$ the sole exception. The rows are $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at every $n$, $\mathfrak u(n/2)$ at even $n$, and $\mathfrak{spin}(7)$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $n=8$ alone.

**What it inherits.**

1. **An unread source.** $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ is Cartan's, and this record holds no Cartan, Helgason, Berger or Besse entry. **This is the largest single debt in the lemma**, because the word "every" in the statement is exactly what this fact supplies.
2. **The step from that fact to the table is itself unwritten.** Granting $\mathrm{Aut}=PO(n)$, an involutive automorphism is $\mathrm{Ad}(g)$ with $g\in O(n)$ and $g^2=\pm I$, which splits into the two rows. The block writes the table and the reason for its *completeness*, but not that reduction.
3. **It does NOT need the pinning formula.** [Conjecture L8](../findings/graded-half.md)'s $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$ is refuted off the balanced splits and has an infinite family of poles at $2q=p$; L69 imports none of it. **This is the right answer to the sub-question, and I checked it at a pole that lies inside L69's own scope.** At $(\mathfrak{so}(25),\mathfrak{so}(20)\oplus\mathfrak{so}(5))$, i.e. $S^5\times S^{20}$ at odd $n=25$ with both factors $\ge5$: the pinning denominator is $2q-p=2\cdot100-200=0$, so the formula has **no value there**; L69's own route is untroubled, the budget reads $\tfrac14+\tfrac1{19}-\tfrac1{24}=\frac{114+24-19}{456}=\frac{119}{456}$ against $\tfrac13=\frac{152}{456}$, so it passes; and Nienhaus's closed form gives $\theta^2=\frac{2\cdot24\cdot4\cdot19}{23\cdot100}=\frac{3648}{2300}=\frac{912}{575}>\tfrac32$. **The two agree, and the pinning formula's pole costs L69 nothing.**

**Where the enumeration is a sweep rather than a classification.** In the *block*, the supporting evidence for the one-dimensional commutant is five measurements, $(3,5)$, $(4,4)$, $(2,6)$ at $n=8$ and $(5,5)$, $(4,6)$ at $n=10$. That is a sweep, and **every one of its five points is outside $n\ge12$**. The classification-strength version is [r502](../reviews/REVIEW_r502.md):44–46, which does the branching by hand for every grading type at every $n$; that report is on file and I read it, so the count is not orphaned, but it is not in the block, and the block's phrase "uniform over the gradings rather than case-checked" describes it inaccurately: r502's derivation is precisely a case check over $p=0,1,2,3,4$, $p,q\ge5$ and $\mathfrak u(m)$.

**No finding on one point:** the count itself is right where I could check it independently. For $p,q\ge5$, $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^p\oplus(\mathbb R^p\otimes\mathbb R^q)\oplus\Lambda^2\mathbb R^q$ is three pairwise-inequivalent $K$-irreducibles (inequivalent even at $p=q$, since $(\mathrm{ad},1)\not\cong(1,\mathrm{ad})$ as $SO(p)\times SO(q)$-modules), giving $3$; $(\Lambda^4\mathbb R^n)^K=0$ because an $SO(m)$-invariant in $\Lambda^i\mathbb R^m$ needs $i\in\{0,m\}$ and $4<p,q$, giving $0$; and the Ricci matrix $\begin{pmatrix}p-1&0&q\\0&q-1&p\end{pmatrix}$ has rank $2$, giving $2$. $3-0-2=1$.

### Q2, is $p,q\ge5$ right in both directions?

**Yes, in both, at both parities and at the boundary.** Derivations in §3 and §4. Summary:

- **Every** split with $p,q\ge5$ and $n\ge12$ clears $\sqrt{3/2}$. The budget is strictly decreasing in $q$ at fixed $p$, so the extremal cases are $p=5,q=7$ (passing by exactly $\tfrac1{132}$), $p=6,q=6$ (by $\tfrac4{165}$), and $p\ge7$ where $\frac1{p-1}+\frac1{q-1}\le\tfrac13$ already before the $-\frac1{n-1}$.
- **No** split with a factor $\le4$ clears it, at any $n$ whatever: $p=4$ needs $q\ge n$, $p\le3$ overshoots on the first term alone, and $p=1$ is excluded, but by assertion in the block, and by argument only in [r502](../reviews/REVIEW_r502.md).

### Q3, is "each is nondegenerate" the same statement the record proves?

**Yes, and the citation reaches what is proved, not what is claimed.** Nondegeneracy is established at [Lemma L27](../findings/nondegeneracy.md):457, whose range is $p,q\ge3$ with $(p,q)\ne(3,3)$, strictly wider than $p,q\ge5$, so L69 sits well inside it, and the exclusion $(3,3)$ is unreachable at $p,q\ge5$. Three checks:

1. **The range is genuinely proved, not measured.** L27's mechanism is the ten-summand multiplicity-free decomposition of $\mathrm{Weyl}_n$ under $O(p)\times O(q)$, with $L_e$ scalar on each summand by Schur and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ symbolic in $p,q$. The one input that had been asserted rather than proved in the source (multiplicity-freeness at $p,q\le4$), is supplied by exact commutant computation, and **"the $p,q\ge5$ case is proved in the source"**, i.e. exactly L69's range is the range the read reference covers.
2. **A stale contradiction has been cleared, and it was about L69's flagship case.** [nondegeneracy.md](../findings/nondegeneracy.md):767 formerly read "it is not proven for the unbalanced splits", which would have left $S^5\times S^7$ (L69's headline point), owed. That paragraph now records the obligation as discharged by L27, found at Gate 2 on L69 itself.
3. **The gap claim is consistent.** $\lambda_2=\frac{M-2}{2(M-1)}$ with $M=\max(p,q)$ gives $\tfrac12-\lambda_2=\frac1{2(M-1)}$; at $S^5\times S^7$, $M=7$ and $\frac1{2\cdot6}=\tfrac1{12}$, matching the block. The excluded case for *that formula* is $(p,q)=(3,4)$, which $p,q\ge5$ never meets. **No finding.**

## 3. The arithmetic, derived in full

### 3.1 The reduction to the budget, correct

With $f(m)=\frac18\bigl(1+\frac1{m-1}\bigr)$ and $\lVert W\rVert^2=f(p)+f(q)-\frac n{8(n-1)}$,
$$8\lVert W\rVert^2=\Bigl(1+\tfrac1{p-1}\Bigr)+\Bigl(1+\tfrac1{q-1}\Bigr)-\Bigl(1+\tfrac1{n-1}\Bigr)=1+\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1},$$
so $\lVert W\rVert^2\le\tfrac16$ is $1+\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\tfrac86=\tfrac43$, i.e. the display. The block's "the $\tfrac18$ cancels" is the right description of the step. **Correct.**

### 3.2 The bridge the block never states, and which I therefore checked

The block moves between $\theta\ge\sqrt{3/2}$ and $\lVert W\rVert^2\le\tfrac16$ without writing the identity that connects them. On the two-factor sphere products it is
$$\lVert W\rVert^2=\frac1{4\theta^2},$$
and it is exact. Writing $a=p-1$, $b=q-1$, $s=a+b=n-2$, $P=ab$:
$$8\lVert W\rVert^2=1+\tfrac1a+\tfrac1b-\tfrac1{s+1}\ \Longrightarrow\ 8ab(s+1)\lVert W\rVert^2=ab(s+1)+b(s+1)+a(s+1)-ab=(s+1)(P+s)-P=s(P+s+1),$$
while Nienhaus's $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ gives
$$\frac{8ab(s+1)}{4\theta^2}=\frac{8ab(s+1)\cdot s(a+1)(b+1)}{4\cdot2(s+1)ab}=s(a+1)(b+1)=s(P+s+1).$$
The two agree identically. **So $\lVert W\rVert^2\le\tfrac16\iff\theta^2\ge\tfrac32$, with no slack in either direction**, the budget is not a sufficient proxy for the threshold, it *is* the threshold. Spot checks, all exact: $(5,7)$ gives $\lVert W\rVert^2=\frac{175}{1056}$ and $\theta^2=\frac{264}{175}$, product $\frac{264}{1056}=\frac14$; $(6,6)$ gives $\frac9{55}$ and $\frac{55}{36}$, product $\frac9{36}=\frac14$; $(3,9)$ gives $\frac{135}{704}$ and $\frac{176}{135}$, product $\frac{176}{704}=\frac14$.

**This is a strengthening the block is entitled to and does not take.** Written as an equivalence, the budget also gives the converse direction of Q2 for free.

### 3.3 The four boundary values quoted, all correct

| split | $n$ | $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}$ | against $\tfrac13$ | block's claim |
|---|---|---|---|---|
| $(5,5)$ | $10$ | $\tfrac14+\tfrac14-\tfrac19=\tfrac{7}{18}$ | $\tfrac6{18}$, **fails** | "fails at $\tfrac7{18}$ against $\tfrac6{18}$" ✔ |
| $(5,6)$ | $11$ | $\tfrac14+\tfrac15-\tfrac1{10}=\tfrac{7}{20}$ | $\tfrac{20}{60}$ vs $\tfrac{21}{60}$, **fails** | "$(5,6)$ at $\tfrac7{20}$" ✔ |
| $(5,7)$ | $12$ | $\tfrac14+\tfrac16-\tfrac1{11}=\tfrac{33+22-12}{132}=\tfrac{43}{132}$ | $\tfrac{44}{132}$, **passes by $\tfrac1{132}$** | "passes by exactly $\tfrac1{132}$" ✔ |
| $(6,6)$ | $12$ | $\tfrac15+\tfrac15-\tfrac1{11}=\tfrac{22-5}{55}=\tfrac{17}{55}=\tfrac{51}{165}$ | $\tfrac{55}{165}$, **passes by $\tfrac4{165}$** | "and $(6,6)$ by $\tfrac4{165}$" ✔ |

### 3.4 $p\le4$, and the one place the argument has no arithmetic to run

- **$p=4$.** $\frac1{p-1}=\tfrac13$ exhausts the budget, and $\frac1{q-1}-\frac1{n-1}>0$ because $n=q+4>q$ gives $n-1>q-1$. So the sum exceeds $\tfrac13$ **strictly**, at every $q$ and every $n$. Equivalently the condition reads $\frac1{q-1}\le\frac1{n-1}$, i.e. $q\ge n$, impossible. **Correct, and it genuinely needs no case check.**
- **$p=3$**: $\tfrac12>\tfrac13$ before the other two terms, and $\frac1{q-1}>\frac1{n-1}$, so the total exceeds $\tfrac13$. **$p=2$**: $1>\tfrac13$ likewise. **Correct.**
- **$p=1$.** $f(1)=\frac1{8\cdot0}$ is **undefined**, so the budget cannot be evaluated and the display's $\frac1{p-1}$ has no value. The block covers this by the single parenthetical "*$p=1$ carries no equivariant point at all*", with no argument attached. The argument exists, [r502](../reviews/REVIEW_r502.md):46 gives it in one line ($\Lambda^2\mathbb R^n$ has two $K$-summands, Ricci forces both coefficients to $0$), but it is not in the block, in [results.md](../results.md):553, or in [results.md](../results.md):180. **Finding: the $p=1$ case has no argument at its point of use.**

### 3.5 $p=5$ gives exactly $n\ge12$, correct, in both of the record's two forms

At $p=5$, $q=n-5$: $\tfrac14+\frac1{n-6}-\frac1{n-1}\le\tfrac13$ is $\frac{(n-1)-(n-6)}{(n-6)(n-1)}=\frac5{(n-6)(n-1)}\le\tfrac1{12}$, i.e. $(n-6)(n-1)\ge60$, i.e. $n^2-7n+6\ge60$, i.e. $n^2-7n-54\ge0$. Its positive root is $\frac{7+\sqrt{265}}2$, and $16^2=256<265<289=17^2$, so the root lies strictly between $\frac{7+16}2=11.5$ and $\frac{7+17}2=12$; over the integers the condition is $n\ge12$. The Lean row's variable change to $q$ gives $(q-1)(q+4)\ge60$, i.e. $q^2+3q-64\ge0$, root $\frac{-3+\sqrt{265}}2\in(6.5,7)$, so $q\ge7$ and $n=q+5\ge12$. **Both forms correct and mutually consistent.**

### 3.6 Three or more factors, the inequality is right, its hypothesis is not discharged

For a $k$-factor product of spheres, $8\lVert W\rVert^2=\sum_a\bigl(1+\frac1{n_a-1}\bigr)-\bigl(1+\frac1{n-1}\bigr)=k-1+\sum_a\frac1{n_a-1}-\frac1{n-1}>k-1-\frac1{n-1}$, which is the block's display. At $k=3$ and $n\ge12$ the right side is at least $2-\tfrac1{11}=\tfrac{21}{11}$, so $\lVert W\rVert^2>\tfrac{21}{88}>\tfrac{16}{96}=\tfrac16$. **The inequality is correct.** Its hypothesis is §5's subject. The block's own criticism of the first version ("a global minimum at $k=2$ constrains nothing at $k=3$"), is well taken and the replacement is the right shape.

## 4. Quantifier order, scope, and every edge of every range

**Quantifier order.** The statement reads $\forall n\ge12\ \forall W$ (equivariant, graded, critical, $\theta\ge\sqrt{3/2}$) $\exists p,q\ge5$ with $W=W_{S^p\times S^q}$, **and then** $\forall$ such $(p,q)$: nondegenerate with $\lambda_{\max}=\tfrac12$ on the orbit tangent. The second clause quantifies over *all* splits with $p,q\ge5$, not merely the ones realised by a point above the threshold, a strictly stronger claim than the first clause needs. It is nonetheless true, because [Lemma L27](../findings/nondegeneracy.md) is unconditional on $p,q\ge3$, $(p,q)\ne(3,3)$. **No finding.**

**The monotonicity that makes the range check finite.** At fixed $p$, increasing $q$ by one decreases $\frac1{q-1}$ by $\frac1{(q-1)q}$ and increases $-\frac1{n-1}$ by $\frac1{(n-1)n}$; since $n>q$ the first change dominates, so the budget is strictly decreasing in $q$. Hence for each $p$ only the smallest admissible $q$ needs checking.

| edge | value | verdict |
|---|---|---|
| **$n=12$ exactly** | $(5,7)\to\tfrac{43}{132}$ pass; $(6,6)\to\tfrac{51}{165}$ pass; $(4,8)\to\tfrac13+\tfrac17-\tfrac1{11}=\tfrac{77+33-21}{231}=\tfrac{89}{231}$ against $\tfrac{77}{231}$, fail; $(3,9)\to\tfrac12+\tfrac18-\tfrac1{11}=\tfrac{44+11-8}{88}=\tfrac{47}{88}$, fail; $\mathfrak u(6)\to\theta^2=\tfrac{7\cdot11}{18\cdot5}=\tfrac{77}{90}<\tfrac32$, fail | **exactly the two splits with $p,q\ge5$ survive**, matching [graded-half.md](../findings/graded-half.md):325's independent statement that the $(6,6)$ slice at $n=12$ carries four sphere products of which two clear the threshold, at $\theta=1.236033$ and $1.228239$; $\theta^2=\tfrac{55}{36}$ and $\tfrac{264}{175}$ ✔ |
| **odd $n$** | $n=13$: $(5,8)\to\tfrac14+\tfrac17-\tfrac1{12}=\tfrac{21+12-7}{84}=\tfrac{26}{84}=\tfrac{13}{42}$ against $\tfrac{14}{42}$, **pass by $\tfrac1{42}$**; $(6,7)\to\tfrac15+\tfrac16-\tfrac1{12}=\tfrac{12+10-5}{60}=\tfrac{17}{60}$, pass; $(4,9)\to\tfrac13+\tfrac18-\tfrac1{12}=\tfrac{8+3-2}{24}=\tfrac38$, fail. $n=25$: $(5,20)\to\tfrac{119}{456}$, pass | **holds at odd $n$**; and odd $n$ carries no $\mathfrak u(m)$ grading at all, so the second row of the enumeration is vacuous there |
| **$(p,q)=(5,7)$** | passes by $\tfrac1{132}$; $\theta^2=\tfrac{264}{175}=\tfrac32+\tfrac{3}{350}$ | **the tightest surviving split on the record**, and consistent under the §3.2 bridge |
| **$(p,q)=(4,8)$** | fails by $\tfrac{12}{231}=\tfrac4{77}$; $\theta^2=\tfrac{231}{160}=1.44375<\tfrac32$ | **correctly excluded**, and the two routes agree |
| **the boundary $\theta=\sqrt{3/2}$ exactly** | equality needs $P(s+4)=3s(s+1)$, i.e. $P=\frac{3(n-2)(n-1)}{n+2}$. Since $n-2\equiv-4$ and $n-1\equiv-3\ \mathrm{mod}\ (n+2)$, this needs $(n+2)\mid36$, so $n\in\{1,2,4,7,10,16,34\}$. At $n=16$: $s=14$, $P=35$, discriminant $196-140=56$, not a square. At $n=34$: $s=32$, $P=88$, discriminant $1024-352=672$, not a square | **no sphere product attains $\sqrt{3/2}$ at any $n$**, so the non-strict $\ge$ in the hypothesis costs nothing, and the only object attaining it is $\mathbb{CP}^2$ at $n=4$, outside the range |
| **$\ker W\ne0$** | the $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ invariant has coordinates $\bigl(\tfrac q{p-1},\tfrac p{q-1},-1\bigr)$, all nonzero, so **every surviving point has $\ker W=0$**. But $W_{\mathbb{CP}^2}$ at $n=4$ has $\ker W$ of dimension $3$ in $6$, and padded $W_{\mathbb{CP}^2}$ at $n=12$ has $\ker W$ of dimension $63$ in $66$ | the conclusion is safe; **the entry route is not**, see §7 |
| **$n=8$ exceptional gradings** | $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ | out of range twice over: $n=8<12$, and their points sit at $\theta=1.115547<\sqrt{3/2}$. **No finding** |

## 5. The gap between what is proven and what is used

### 5.1 The Einstein hypothesis, dropped in transit, DISCREPANCY

**Located.** [graded-half.md](../findings/graded-half.md):369, inside the $\square$:

> "*Reducible:* $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B(n_1,\dots,n_k)$ with $B$ depending on the partition alone"

and mirrored at [results.md](../results.md):555 as "for reducible ones $\lVert W\rVert^2$ depends on the partition alone with every non-sphere factor adding to it (Lemma L48)".

**The failure, concretely.** [Lemma L48](../findings/problem.md)'s own boxed correction says: "**Einstein is load-bearing**: the $\theta$ above comes from Lemma L46's identity $Q(W)=\lambda W$, which needs $\mathrm{Ric}=\lambda g$, *and a reducible symmetric space whose factors carry different Einstein constants is not Einstein, so the formula never applied to it.*" L69's hypotheses are H1–H5 of §1.1; **none of them says the space is Einstein**, and the correspondence sentence delivers only "the Weyl operator of a compact symmetric space", which fixes no metric normalisation. The place this bites hardest is $k\ge3$: at $K=SO(n_1)\times\cdots\times SO(n_k)$ the $K$-invariant symmetric endomorphisms of $\Lambda^2$ number $k+\binom k2$ (one scalar per adjoint block, one per mixed block) against $k$ Ricci conditions, leaving $\binom k2$, which is $3$ at $k=3$, not $1$. So at $k\ge3$ the Weyl direction genuinely moves with the relative scalings, and "$B$ depends on the partition alone" holds only for the Einstein representative. A three-factor object at $n=12$ such as $S^5\times S^5\times S^2$ with unequal Einstein constants is not covered by the display L69 quotes.

**The opposite, argued as charitably as the words allow.** At $k=2$ the debt is harmless, and for a reason the record could have written: the $K$-invariant Weyl operators at $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ form a **one-dimensional** space ([r502](../reviews/REVIEW_r502.md):44), so *every* product of two space forms (Einstein or not), has its Weyl operator on the same line, and the budget computed for the Einstein representative is the budget for all of them. So the two-factor half of the argument survives the missing hypothesis intact. And "compact symmetric space" arguably imports Einstein by convention in the irreducible case, where it is automatic. **What the charitable reading cannot rescue is the $k\ge3$ paragraph**, which is the step the block itself flags as "the step the first version skipped" and repairs, repairing it with a display whose hypothesis it does not check.

**Verdict on this item: HYPOTHESIS-DEBT.** What would have to be shown: *an equivariant graded critical point that is the Weyl operator of a reducible compact symmetric space is the Weyl operator of the Einstein representative of that product*, or, alternatively, that reducible products with $k\ge3$ factors are excluded before L48 is invoked, which the grading enumeration does supply (only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$ are $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$) but the block never says.

### 5.2 The L47 citation, BROKEN, twice, and one of the two changes the meaning

**Located.** [graded-half.md](../findings/graded-half.md):379:

> "And every factor is a sphere by **[Lemma L47](fence-posts.md)**'s quantitative $\lVert W_a\rVert^2\ge\tfrac16$, rather than by non-vanishing"

**Failure 1, the link resolves to a file that does not contain L47.** [fence-posts.md](../findings/fence-posts.md) carries no occurrence of "L47"; the canonical block is [problem.md](../findings/problem.md):221, and [results.md](../results.md):525 points there. A consumer following the link finds nothing.

**Failure 2, the scope.** The citable L47, at [results.md](../results.md):525, reads "For a compact irreducible symmetric space **of rank $\ge2$**, and for $\mathbb{OP}^2$ … $\lVert W\rVert^2\ge\frac16$", and defers the rest: "The rank-one spaces other than $\mathbb{OP}^2$ are the families of Lemmas 10 and 38." So the citable statement gives **no bound at all** for a $\mathbb{CP}^m$ or $\mathbb{HP}^m$ factor. The bound for those exists only inside the proof prose at [problem.md](../findings/problem.md):228, "$\mathbb{CP}^m$ and $\mathbb{HP}^m$ have closed forms with minima $\tfrac16$ at $\mathbb{CP}^2$ and $\tfrac{45}{224}$ at $\mathbb{HP}^2$". A consumer citing L47 as stated cannot exclude a rank-one non-spherical factor.

**Failure 3, smaller, "vanishes exactly when that factor is a sphere" over-states L47 in the other direction.** [problem.md](../findings/problem.md):228 says "$S^n$ **and $\mathbb{RP}^n$** have $W=0$". Every space form has $W=0$, so $\lVert W_a\rVert^2=0$ characterises *constant curvature*, not *sphere*. The conclusion is unharmed at the level of tensors ($W$ is a local invariant, so $W_{\mathbb{RP}^p\times S^q}=W_{S^p\times S^q}$) but the statement as written, read alone, is false.

**The opposite, argued.** The most charitable reading is that "sphere" abbreviates "space form", and that the rank-one closed forms are part of L47 because the proof establishes them. Under that reading the step is sound: $\tfrac{45}{224}>\tfrac16$ (since $45\cdot6=270>224$), $\mathbb{CP}^m\ge\tfrac16$ with equality only at $\mathbb{CP}^2$, and the residual budget $B\ge\tfrac18>0$ makes even the equality case fail $\lVert W\rVert^2\le\tfrac16$. **The mathematics survives; the citation does not carry it.** Not withdrawn: the link is wrong as a matter of fact, and the citable statement is short of what is cited.

## 6. The universal claim with no witness, one object from each structured family the record names

*"The only equivariant graded points above $\sqrt{3/2}$ are two-factor sphere products with $p,q\ge5$."* Every candidate below gets the three-step record: locate, exhibit, argue the opposite.

### 6.1 $\mathbb{CP}^6$ at $n=12$, a non-sphere-product equivariant graded point, in range

- **Locate.** The $\mathfrak u(6)$ grading of $\mathfrak{so}(12)$ is the second row of the enumeration; by [r502](../reviews/REVIEW_r502.md):46 its invariant line is spanned by $W_{\mathbb{CP}^6}$, so this is an equivariant graded point at $n=12$ which is not a sphere product.
- **Exhibit.** $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$ gives at $m=6$: $\frac{7\cdot11}{3\cdot6\cdot5}=\frac{77}{90}$, and $\tfrac{77}{90}<\tfrac{135}{90}=\tfrac32$. So it sits below the threshold and is **not** a counterexample. The four quoted values check exactly: $m=3\to\frac{4\cdot5}{18}=\frac{10}9$, $\sqrt{10}/3=1.054093$; $m=4\to\frac{5\cdot7}{36}=\frac{35}{36}$, $\sqrt{35}/6=0.986013$; $m=5\to\frac{6\cdot9}{60}=\frac9{10}$, $=0.948683$; $m=6\to\frac{77}{90}=0.924962^2$. Monotone decreasing to $\tfrac23$.
- **Argue the opposite.** The most charitable hostile reading is that the block's list "$1.054093, 0.986013, 0.948683, 0.924962$ at $m=3,4,5,6$" is a four-point sweep, so "every $\mathfrak u(m)$ pair with $n=2m\ge12$" is an extrapolation. It is not: the closed form is proved at [graded-half.md](../findings/graded-half.md) as the $\mathbb{CP}^m$ family value, and $\frac{(m+1)(2m-1)}{3m(m-1)}<\frac32$ is $2(2m^2+m-1)<9m^2-9m$, i.e. $5m^2-11m+2>0$, true for every $m\ge3$ (at $m=3$, $45-33+2=14>0$, and the quadratic increases). **Candidate withdrawn, the exclusion is a theorem, not a sweep.**

### 6.2 Padded $W_{\mathbb{CP}^2}$ at $n=12$, $\theta=\sqrt{3/2}$ exactly, not a sphere product

- **Locate.** [problem.md](../findings/problem.md) records $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4$, zero-padded into $\Lambda^2\mathbb R^n$, critical and at $\theta=\sqrt{3/2}$ **for every $n$**. At $n=12$ it therefore satisfies the hypothesis $\theta\ge\sqrt{3/2}$, at the boundary, and it is not a sphere product.
- **Exhibit.** Its kernel is $\binom{12}2-3=63$ of $66$. Under sense **(A)** it is vacuously "graded" ($\Delta=0$ holds vacuously off $\ker W=0$), and under sense **(B)** it is slice-graded. **So under an (A)- or (B)-reading of the word "graded", this object falsifies the statement at $n=12$, at the boundary of the range, exactly.**
- **Argue the opposite.** L69 is sense **(C)**, and in (C) the object is out of scope: [graded-half.md](../findings/graded-half.md):333 shows $\dim\mathfrak k(W)=10$ at $n=8$ while every $\mathbb Z_2$-grading subalgebra of $\mathfrak{so}(8)$ has dimension $12,13,16$ or $21$, so equivariance fails "for no grading whatsoever, in any of the three senses"; the labelling table repeats it at $n=12$ with $\dim\mathfrak k(W)=32$. **So the candidate does not refute L69 as stated.** What survives is §7's finding: the block never says which sense it is stated in, and the sense-fixing table is three sections away.

### 6.3 $(S^3)^4$ at $n=12$, the multi-factor family

- **Locate.** Named at [results.md](../results.md):553 (Observation L56) as a four-block product at $n=12$.
- **Exhibit.** $8\lVert W\rVert^2=4\bigl(1+\tfrac12\bigr)-\bigl(1+\tfrac1{11}\bigr)=6-\tfrac{12}{11}=\tfrac{54}{11}$, so $\lVert W\rVert^2=\tfrac{27}{44}$, far above $\tfrac16$ (since $27\cdot6=162>44$); and it exceeds the block's $k$-factor floor $\tfrac18(k-1-\tfrac1{n-1})=\tfrac18\cdot\tfrac{32}{11}=\tfrac4{11}=\tfrac{16}{44}$, as the inequality requires. **Correctly excluded, and the block's floor is not vacuous on it.**
- **Argue the opposite.** One could object that $(S^3)^4$ is not reachable at all, since $\mathfrak{so}(3)^{\oplus4}$ is no $\mathbb Z_2$-grading of $\mathfrak{so}(12)$, making the $k\ge3$ paragraph dead weight. That objection is right about sense (C) and wrong about the block, which routes the reducible case through the *symmetric-space* classification, where $k\ge3$ products do occur. **Candidate withdrawn as a falsifier; retained as evidence that the $k\ge3$ paragraph is load-bearing only under the wider reading, which is precisely where §5.1's Einstein debt lives.**

### 6.4 $\mathbb{HP}^3$ and $\mathrm{Gr}_{\mathbb C}(2,3)$ at $n=12$, the non-sphere-product structured families the record itself puts at $n=12$

- **Locate.** [graded-half.md](../findings/graded-half.md):284 names both at $n=12$ with $\ker W=0$, as part of the (C)/(A) discussion.
- **Exhibit.** $\mathbb{HP}^m$ has $\lVert W\rVert^2\ge\tfrac{45}{224}$ with the minimum at $\mathbb{HP}^2$ ([problem.md](../findings/problem.md):228), so by §3.2's bridge $\theta^2\le\frac{224}{4\cdot45}=\frac{56}{45}$, i.e. $\theta\le1.115547$, which is exactly the value the record independently records for $\mathbb{HP}^2$, so the bridge and the bound corroborate each other. $\tfrac{56}{45}<\tfrac32$ since $112<135$. $\mathrm{Gr}_{\mathbb C}(2,3)$ is irreducible of rank $2$, so L47 gives $\theta\le\sqrt{3/2}$ with equality only at $\mathbb{CP}^2$, hence strictly below. **Both correctly excluded.**
- **Argue the opposite.** The hostile reading is that neither is a $\mathbb Z_2$-grading of $\mathfrak{so}(12)$, $\mathfrak{sp}(3)\oplus\mathfrak{sp}(1)$ and $\mathfrak u(2)\oplus\mathfrak u(3)$ are not on the enumeration's table, so if the record calls them (C), then (C) is *wider* than the $\mathbb Z_2$-grading enumeration and the enumeration does not exhaust it. **That objection stands**, and it is why L69 needs Route 1 (L47/L48) as well as Route 2, and therefore why §5.1's and §5.2's debts cannot be dismissed as redundant. It does not refute the statement: both objects fall below the threshold by L47.

### 6.5 The exceptional pairs, scope admits none

$\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ exist only at $n=8$. The scope $n\ge12$ therefore admits **no** exceptional pair, and the highest point they carry, $\mathbb{HP}^2=\tau(S^3\times S^5)$ at $\theta=1.115547$, is below $\sqrt{3/2}=1.224745$ in any case. **No finding.**

### 6.6 An odd-$n$ positive witness, in range, at a pole of the refuted pinning formula

$S^5\times S^{20}$ at $n=25$: budget $\tfrac{119}{456}<\tfrac{152}{456}$, $\theta^2=\tfrac{912}{575}>\tfrac32$, both factors $\ge5$. The pinning formula has no value there ($2q-p=0$), and L69 is unaffected. **The statement's positive content has a witness at odd $n$, which the record's own $n=12$-heavy evidence base did not supply.**

## 7. Comparing the forms, and the named trap

**The record's signature failure is a correction landing *beside* the statement it corrects. I read each citable form alone, as a consumer would, and recorded what each one carries.**

| form | carries $n\ge12$ | carries "$p,q\ge5$ and $n\ge12$ are two constraints" | names the sense (C) | carries the $\ker W\ne0$ / $\Delta$ guard | carries "enumeration is $n\ne8$" | carries Einstein | L47 link resolves |
|---|---|---|---|---|---|---|---|
| [graded-half.md](../findings/graded-half.md):363– (**the Proof site** | yes | **yes**, in bold | **no** | **no** | **no** | **no** | **no**), points at [fence-posts.md](../findings/fence-posts.md) |
| [results.md](../results.md):553, the canonical statement | yes | no | **yes** | **yes** | **yes** | **no** | yes, via [problem.md](../findings/problem.md) |
| [results.md](../results.md):180 (the landscape line | yes | **no**), it writes "The split condition … at $p=5$ reads $n\ge12$", which reads as one constraint | **no** | **no** | **no** | **no** | n/a |
| [lean/INDEX.md](../lean/INDEX.md):226, status **proved** | yes | **yes**, at length | no | no | no | no | n/a |
| [lean/INDEX.md](../lean/INDEX.md):261, status **partial** | yes | yes | no | no | no | no | n/a |

**Reading each alone.**

1. **[results.md](../results.md):180 is the weakest form and the one most likely to be cited**, being the landscape summary. It states the conclusion and the split condition with none of the four guards. A consumer citing it has no way to learn that "graded" here excludes the $\Delta=0$ reading, and §6.2 shows what that costs at $n=12$: padded $W_{\mathbb{CP}^2}$, at $\theta=\sqrt{3/2}$ exactly, is a counterexample under the reading :180 leaves open. **This is the trap, and it is live.**
2. **The block itself carries no sense label either.** The sense is fixed by the labelling table at [graded-half.md](../findings/graded-half.md):385, three sections below the proof, and by the $n\ne8$ enumeration section below that. Both say "Lemma L69 is unaffected", which is correct, but a consumer who stops at the $\square$ never learns which of three incomparable classes the quantifier ranges over. **Correction landing beside the statement, precisely.**
3. **[results.md](../results.md):553 is the only form a consumer can safely cite.** It names the sense, the $\ker W$ guard, the $n\ne8$ enumeration caveat, and the correct proof location. Its one omission is Einstein (§5.1), which no form carries.
4. **The two Lean rows disagree in status for the same result** (one "proved", one "partial") and neither is wrong, because they formalise different things. Row 226's own prose discharges the ambiguity: "**Owed**: the invariant count and the reducible-case norm decomposition, both imported". [L69.lean](../lean/HamiltonsCubic/Results/L69.lean) contains only the split arithmetic, `five_five_fails`, `five_six_fails`, `five_seven_passes`, `six_six_passes`, `constraints_are_distinct`, `p_four_exhausts`, `remainder_positive`, `p_four_never_admissible`, `p_three_exceeds`, over $\mathbb Q$, with no representation theory and no $p=1$ case. **What a Lean row for the lemma proper would have to claim, and does not:** that every equivariant graded critical point at $n\ge12$ with $\theta\ge\sqrt{3/2}$ is $W_{S^p\times S^q}$ with $p,q\ge5$. [lean/INDEX.md](../lean/INDEX.md):362 lists L69 "beyond its split condition" among the results that are `out` for exactly this reason. **The rows are honest; a reader who reads only the status word is not served.**
5. **One consumer overreach inside the record.** [graded-half.md](../findings/graded-half.md):325 reads "Lemma L69 makes **each** sphere product with both factors $\ge5$ a **local maximum**". L69's conclusion is Morse–Bott nondegeneracy with $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ on the orbit tangent; *local maximum* requires [Lemma L24](../findings/second-order.md) in addition, as [results.md](../results.md):114 correctly states for L3 ("by Lemmas L24 and L27"). The sentence also drops the $n\ge12$ hypothesis. **Both are recoverable, and neither is stated at the point of use.**

## 8. Item-by-item answers, including where I found nothing

- **Every hypothesis inventoried**, §1. **Which the written proof uses**, §1.3.
- **Quantifier order and scope**, §4, no finding; the second clause is stronger than needed and still true.
- **$n=12$, odd $n$, $(5,7)$, $(4,8)$, $\ker W\ne0$**, §4, all checked exactly, all consistent.
- **The universal claim**, §6, five structured families tried, one in-scope positive witness at odd $n$ found, **no counterexample to the statement as written**.
- **Form comparison including Lean**, §7.
- **The gap between proven and used**, §5.
- **The named trap**, §7, item 1: live at [results.md](../results.md):180 and at the block.
- **No finding:** the $n\ge12$ threshold is derived rather than assumed, as the block claims; the $p=4$ exclusion needs no case check, as the block claims; the four boundary fractions are exact; the $\mathbb{CP}^m$ exclusion is a theorem rather than the four-point list it looks like; the nondegeneracy citation reaches what is proved; the gap $\frac1{2(M-1)}$ is right; and the $n=8$ exceptional gradings are out of range twice over.
- **No finding:** I looked for a disagreement between the $f$-budget route and the Nienhaus closed form and found instead that they are **identically** equivalent (§3.2). That equivalence is a strengthening the record does not claim.

## 9. What would break it, and what I did to look for it

**The object that would falsify the statement** is a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ at some $n\ge12$ that is not $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and not $\mathfrak u(n/2)$, equivalently, a second $n\ge12$ at which $\mathrm{Aut}(\mathfrak{so}(n))$ is strictly larger than $PO(n)$. Its invariant line would carry a point the threshold argument never sees, since the $f$-budget is a statement about *products* and says nothing at an irreducibly-acting isotropy. The $n=8$ rows are the proof that such objects exist at all: $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ act **irreducibly** on $\mathbb R^8$, so no element of $O(8)$ carries either to a reducible grading, and the record itself says the enumeration "carries $n\ne8$ and every use of it must too".

**What I did to look for one.** I read the enumeration section at [graded-half.md](../findings/graded-half.md):402–, the invariant-count derivation at [r502](../reviews/REVIEW_r502.md):44–46, [r501](../reviews/REVIEW_r501.md):197, [ATTEMPTS.md](../ATTEMPTS.md):2595 and :4537, and searched [references/INDEX.md](../references/INDEX.md) and the [references/](../references/) directory for Cartan, Helgason, Berger and Besse. **There is no such entry**; the closest, [reeder-2013-gradings-positive-rank](../references/reeder-2013-gradings-positive-rank/notes.md), carries a heading saying in terms that the paper does not cover $\mathfrak{so}(n)$. So the exclusion of a second exceptional dimension rests on a source this record has not read, and I did not supply the argument.

**A second, smaller falsifier** would be a reducible symmetric space with $k\ge3$ factors, unequal Einstein constants, whose Weyl operator is an equivariant graded critical point above $\sqrt{3/2}$; §5.1 shows the display L69 quotes does not apply to it. I looked for one among the families the record names (the sphere products, $\mathbb{CP}^m$, $\mathbb{HP}^m$, $(S^3)^4$, the Grassmannians) and found none, because none of them is a $k\ge3$ non-Einstein product on this record. **Absence of a witness is not a discharge of the hypothesis.**

## Verdict

**HYPOTHESIS-DEBT.**

Nothing in L69 is refuted, and everything I could check by hand is correct, including an equivalence (§3.2) stronger than the block claims. Three things would have to be shown for the lemma to stand on this record alone:

1. **That the four-row enumeration of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ is complete for every $n\ge12$**, i.e. $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$, $n\ne8$, together with the unwritten reduction from that fact to the table. **Currently an unread source: [references/](../references/) holds no Cartan, Helgason, Berger or Besse entry.**
2. **That the symmetric space at an equivariant graded critical point is Einstein**, which [Lemma L48](../findings/problem.md)'s own boxed correction makes load-bearing for the reducible norm decomposition, and which no form of L69 states. Harmless at $k=2$ by the one-dimensional invariant line; **undischarged at $k\ge3$**, which is the step the block repairs.
3. **That [Lemma L47](../findings/problem.md) as cited covers rank-one factors**, which the citable statement at [results.md](../results.md):525 does not; and the link at [graded-half.md](../findings/graded-half.md):379 must be repaired to point at [problem.md](../findings/problem.md), which holds L47, rather than at [fence-posts.md](../findings/fence-posts.md), which does not.

**What a consumer may cite today.** [results.md](../results.md):553, in full, including its four guards, and no other form. Citing [results.md](../results.md):180 or the block alone leaves the reader free to read "graded" in sense (A), where padded $W_{\mathbb{CP}^2}$ at $n=12$, $\theta=\sqrt{3/2}$, $\ker W=63$ of $66$, is a counterexample. The split condition, and only the split condition, is machine-checked.
