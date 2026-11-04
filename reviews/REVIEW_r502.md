# REVIEW r502, Lemma L69

**Target**: [Lemma L69](../findings/graded-half.md#L327), `findings/graded-half.md` line 327, "above $\sqrt{3/2}$ the only equivariant graded points are sphere products with both factors $\ge5$, and all of them are nondegenerate".

**Reviewer**: r502, cold adversarial audit, derived from the definitions. Analysis-only footing observed: **no search, sweep, census, optimisation or falsifier hunt was run, and no computation of any kind was performed.** Every number below is either hand arithmetic or a value quoted from the record and checked by hand.

**VERDICT: CONFIRMED, the statement is true and I re-derived every quantitative step from scratch. The proof as written is not, however, a complete warrant for it: its load-bearing first sentence is unproved in this record, and the paragraph that repairs it cites a result whose hypotheses the repair's own case fails. I supply the missing proof below; with it the block stands. Five repairs are listed as REQUIRED.**

---

## 0. What I fixed first: the normalisation, because every later step depends on it

Nothing in the L69 block says which normalisation $\lVert W\rVert^2$ is measured in, and the whole reducible branch is a statement about that number. Recovered from [graded-half.md](../findings/graded-half.md) lines 78–96: Einstein constant $\tfrac12$, so $\mathop{\mathrm{scal}}=n/2$, $\mathop{\mathrm{tr}}\mathcal R=n/4$, and $W=\mathcal R-\frac{1}{2(n-1)}I$ on $\Lambda^2$. With [Lemma L46](../findings/problem.md)'s $Q(W)=\lambda W$ at $\lambda=\tfrac12$ this gives

$$\theta=\frac{1}{2\lVert W\rVert}\quad\Longrightarrow\quad \theta\ge\sqrt{3/2}\iff\lVert W\rVert^2\le\tfrac16 .$$

**So the reducible branch's threshold $\lVert W\rVert^2\le\tfrac16$ is the right translation of $\theta\ge\sqrt{3/2}$.** Confirmed independently against the record's own numbers: $S^5\times S^7$ at $\lVert W\rVert^2=\tfrac{175}{1056}$ gives $\theta=1.228239$, and $S^6\times S^6$ at $\tfrac{9}{55}$ gives $\theta=1.236033$, both the recorded values to every printed digit.

*This is a presentational gap, not an error: the block should quote [conventions.md](../findings/conventions.md) for the normalisation instead of leaving it to be reconstructed.*

## 1. The classification appeal, the load-bearing sentence is NOT established in this record

> *"An equivariant graded point is the Weyl operator of a compact symmetric space, so the recorded classification applies."*

**Where the block says it is proved: [Lemma L8](../findings/graded-half.md). Lemma L8 does not prove it, it assumes it.** L8's own text reads "*Since the compact symmetric pairs are classified, the graded case is then a finite check*", and its content is the value formula $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, which runs *from* a pair *to* a number. The direction L69 needs (an arbitrary equivariant graded critical point *is* such an object), is nowhere derived. The "What it inherits" paragraph at [line 375](../findings/graded-half.md#L375) states the dependency correctly and then names L8 as the supplier, which L8 is not. **This is the same finding [Reviewer 314](INDEX.md#L614) filed** ("nowhere established in this record, Lemma L8 assumes it"), so the defect is known and the block still carries the sentence unqualified.

**There is also a name collision inside that sentence that the block never separates.** For $\mathfrak p=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ the *symmetric space of the pair $(\mathfrak{so}(n),\mathfrak p)$* is the real Grassmannian $\mathrm{Gr}(p,q)$, of dimension $pq$; the *symmetric space whose Weyl operator $W$ is* is $S^p\times S^q$, of dimension $n=p+q$. Two different manifolds sharing one subalgebra, which sits in one as an isotropy and in the other as a holonomy. Nothing downstream misuses it, but a reader cannot tell which is meant.

### 1a. The repair beneath the proof is the real warrant, and its cited support is wrong

The paragraph at [line 341](../findings/graded-half.md#L341) replaces the appeal with: the $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ are only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$ for $n\ne8$, and the $\mathrm{ad}(\mathfrak p)$-commutant in $\mathcal W_n$ is one-dimensional, so $W$ is forced. **That is the correct route and it needs no classification of symmetric spaces at all.** Two problems with how it is warranted:

- **The measurements are all outside the lemma's range.** The commutant count is reported "at every symmetric pair tested: $(3,5)$, $(4,4)$, $(2,6)$ at $n=8$ … and $(5,5)$, $(4,6)$ at $n=10$". The lemma is stated for $n\ge12$. Five data points at $n=8,10$ are not a proof at $n\ge12$. ([Reviewer 314](INDEX.md#L614) reports $n=8,10,12,13$ and a proof "for all $n$ in the sphere case"; graded-half.md carries neither the wider range nor the proof.)
- **The general argument it then cites does not cover its own case.** The sentence "*This is agreement rather than discovery: [ungraded-slack.md](../findings/ungraded-slack.md) already records that under $K$-irreducibility, $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ and $(\Lambda^4\mathbb R^n)^K=0$ the $K$-invariant traceless Weyl operators are $\mathbb R\,W_{\mathfrak h}$*" misapplies that result **twice**:
  - Hypothesis (F2), $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, **fails for every $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p\ne q$**, the invariants are $\Pi_p$ and $\Pi_q$, a two-dimensional space, and $\mathbb R^n$ is $K$-reducible besides. [ungraded-slack.md:134](../findings/ungraded-slack.md#L134) says this in its own words: "*$\mathfrak{so}(n-1)$ and **every unbalanced split** … fail (F2)*." The cited criterion excludes precisely the family L69's conclusion consists of.
  - The $W_{\mathfrak h}$ of that file is the **subalgebra-family** operator $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, which by the same file's line 134 is critical on a symmetric pair *only at the cap* $r=n(n-2)/4$, i.e. only at the balanced split. It is not the sphere product's Weyl tensor at an unbalanced split, and it is not $W_{\mathbb{CP}^m}$ at a $\mathfrak u(m)$ pair (the file says $\mathfrak u(m)$ "never enters the family"). Two different objects under one symbol.

### 1b. The missing proof, supplied, one-dimensionality at every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$, $n\ge12$

Let $K$ be the connected group of $\mathfrak p$ and count $\dim\bigl(\mathcal W_n\bigr)^{K}$ directly. A $K$-invariant algebraic Weyl operator is a $K$-equivariant symmetric endomorphism of $\Lambda^2\mathbb R^n$ that is Bianchi-free and Ricci-flat, so

$$\dim(\mathcal W_n)^K=\dim\mathop{\mathrm{End}}^{\mathrm{sym}}_K(\Lambda^2)-\mathop{\mathrm{rank}}(\mathrm{Alt})-\mathop{\mathrm{rank}}(\mathrm{Ric}).$$

**Case $\mathfrak p=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p,q\ge5$.** $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^p\oplus\Lambda^2\mathbb R^q\oplus(\mathbb R^p\otimes\mathbb R^q)$, three $K$-irreducibles of real type, pairwise inequivalent even when $p=q$ (as $SO(p)\times SO(q)$-modules they are $(\mathrm{ad},1)$, $(1,\mathrm{ad})$, $(\mathrm{std},\mathrm{std})$). So $\mathop{\mathrm{End}}^{\mathrm{sym}}_K=\mathbb R^3$, coordinates $(a,b,c)$. $(\Lambda^4\mathbb R^n)^K=\bigoplus_{i+j=4}(\Lambda^i\mathbb R^p)^{SO(p)}\otimes(\Lambda^j\mathbb R^q)^{SO(q)}=0$, since an $SO(m)$-invariant in $\Lambda^i\mathbb R^m$ needs $i\in\{0,m\}$ and $i,j\le4<p,q$, **so Bianchi is automatic and costs nothing**. Ricci: $\mathop{\mathrm{Ric}}_{ii}=a(p-1)+cq$ for $i$ in the first block and $b(q-1)+cp$ for $i$ in the second; the matrix $\begin{pmatrix}p-1&0&q\\0&q-1&p\end{pmatrix}$ has rank $2$. Hence $\dim(\mathcal W_n)^K=3-0-2=1$, spanned by $\bigl(a,b,c\bigr)=\bigl(\tfrac{q}{p-1},\tfrac{p}{q-1},-1\bigr)$, which is exactly $W_{S^p\times S^q}$ (curvature $\kappa_1,\kappa_2,0$ minus $\tfrac{1}{2(n-1)}I$, whose mixed block is negative).

**The remaining gradings, same count.** $p=0$: $W$ commutes with all of $\mathfrak{so}(n)$, so $W\in\mathbb R I$, and tracelessness gives $W=0$, no point. $p=1$: two summands, Ricci forces both coefficients to $0$, no point (independently, a $1$-dimensional factor cannot carry Einstein constant $\tfrac12$). $p=2$: $\mathbb R^2\otimes\mathbb R^q$ is $K$-irreducible of complex type but its equivariant *symmetric* endomorphisms are still $\mathbb R\,\mathrm{Id}$ ($J\otimes I$ is antisymmetric), so $3-0-2=1$. $p=3$: $\Lambda^2\mathbb R^3\cong\mathrm{std}$, still three inequivalent irreducibles, $(\Lambda^4)^K=0$, so $1$. $p=4$: $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ raises $\mathop{\mathrm{End}}^{\mathrm{sym}}_K$ to $4$ (to $5$ if $q=4$), but the block volume form makes $(\Lambda^4\mathbb R^n)^K$ one-dimensional (two-dimensional if $q=4$), so Bianchi now costs exactly what the splitting added: $4-1-2=1$ (and $5-2-2=1$). *This is why the record's measured $1$ at $(4,4)$ is not an accident, and it is the Lie-algebra-level count the record says it wants.* $\mathfrak p=\mathfrak u(m)$, $n=2m\ge12$: the summands are the centre $\mathbb R\omega$, $\mathfrak{su}(m)$, and $\mathfrak m\cong\Lambda^2\mathbb C^m$ of complex type with symmetric commutant $\mathbb R$, so $\mathop{\mathrm{End}}^{\mathrm{sym}}_K=\mathbb R^3$; $(\Lambda^4\mathbb R^{2m})^{U(m)}=\mathbb R\,\omega\wedge\omega$ is one-dimensional and $(\mathrm{Sym}^2\mathbb R^{2m})^{U(m)}=\mathbb R\,\mathrm{Id}$ makes Ricci one condition: $3-1-1=1$, spanned by $W_{\mathbb{CP}^m}$.

**Conclusion.** At every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ with $n\ge12$ the equivariant Weyl operators form a line, so on the unit sphere an equivariant graded point is $\pm\hat W_{\mathfrak h}$, and $\hat W_{\mathfrak h}$ is automatically critical. **The classification of compact symmetric spaces is not needed anywhere.** *The sign is settled by the threshold and the block should say so: $(-W)^\#=W^\#$, so $Q(-W)=-\theta\,(-W)$ and $\theta(-W)=-\theta(W)<0<\sqrt{3/2}$.*

## 2. The irreducible branch, the cited theorem says what is claimed, with one wording defect

[Lemma L47](../findings/problem.md), quoted at [graded-half.md:90](../findings/graded-half.md#L90): "*On every compact irreducible symmetric space, $\lVert W\rVert^2\ge\tfrac16$, with equality exactly at $\mathbb{CP}^2$.*" Its warrant is a Dimension Lemma ($\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\tfrac16$, Cauchy–Schwarz with the isotropy-block multiplicities at $\mathop{\mathrm{tr}}\mathcal R=n/4$) covering rank $\ge2$ and $\mathbb{OP}^2$, plus the rank-one residue by closed form. **Hypotheses and coverage are as L69 uses them, at every $n$, with no rank or dimension restriction left open.** The residual "*Still owed: the Grassmannian and simple-isotropy classes*" at [line 140](../findings/graded-half.md#L140) belongs to the superseded class-by-class programme, which the Dimension Lemma paragraph explicitly replaces, *and that stale sentence sits 50 lines below the theorem that supersedes it, which is a reading trap.*

Two things L69 gets right that are worth stating: **"equality only at $\mathbb{CP}^2$" is proved, not observed** (the certificates' strictly positive constant terms $616,48,7200,\dots$ are exactly what rules out a second equality case), and since $\mathbb{CP}^2$ has $n=4$, **the irreducible branch is strict at every $n\ge12$**, which is what lets L69 admit equality in $\theta\ge\sqrt{3/2}$.

**Wording defect in L47 as quoted**: the round sphere is a compact irreducible symmetric space with $\lVert W\rVert^2=0$, so the theorem is literally false as stated and needs "with $W\ne0$", or "non-constant-curvature". The exclusion is discussed at [line 88](../findings/graded-half.md#L88) but is absent from the boxed statement L69 cites.

## 3. The two-factor arithmetic, derived from scratch, and it is right

**I derived $B$ rather than accepting it.** For $M=M_1\times\dots\times M_k$ Einstein at constant $\tfrac12$, $\mathcal R$ is block diagonal on $\Lambda^2$ and zero on the mixed blocks, and $\mathcal R_a=W_a+\frac{1}{2(n_a-1)}I_a$. With $u=\frac{1}{2(n-1)}$,

$$\lVert W\rVert^2=\sum_a\Bigl[\lVert W_a\rVert^2+\tbinom{n_a}{2}\bigl(\tfrac{1}{2(n_a-1)}-u\bigr)^2\Bigr]+u^2\!\!\sum_{a<b}\!n_an_b
=\sum_a\lVert W_a\rVert^2+\sum_a f(n_a)-\frac{n}{8(n-1)},$$

the cross terms vanishing because each $W_a$ is trace-free on $\Lambda^2V_a$, and the collapse using $\sum_a n_a(n_a-1)u^2/2+u^2(n^2-\sum n_a^2)/2=\frac{n}{8(n-1)}$. **So $f(m)=\frac{m}{8(m-1)}$ and $B$ depends on the partition alone, confirmed, not assumed.** Three independent checks: $B(5,7)=\tfrac{175}{1056}$, $B(6,6)=\tfrac9{55}$, and $B(n/2,n/2)=\frac{n^2}{8(n-1)(n-2)}=\frac{1}{4\theta_0(n)^2}$ identically.

**The reduction.** $f(m)=\tfrac18\bigl(1+\tfrac1{m-1}\bigr)$, so $f(p)+f(q)-\frac{n}{8(n-1)}=\tfrac18\bigl[1+\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\bigr]\le\tfrac16$ is exactly $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$. **Correct.** *(The block's "the $\tfrac18$ cancels" is loose ($\tfrac18\cdot\tfrac43=\tfrac16$ is a division, not a cancellation) but the result is right.)*

**The endpoints, checked at both ends of the integer boundary as the brief requires.**

| split | $n=12$ | $n=20$ | general |
| --- | --- | --- | --- |
| $p=2$ | $1+\tfrac19-\tfrac1{11}$ |, | $>1$, fails |
| $p=3$ | $\tfrac12+\tfrac18-\tfrac1{11}$ |, | $>\tfrac12-\tfrac1{n-1}>\tfrac13$, fails |
| **$p=4$** | $0.385280>\tfrac13$ | $0.347368>\tfrac13$ | reduces to $q\ge n$, impossible since $q=n-4$, **fails at every $n$** |
| **$p=5$** | $0.325758\le\tfrac13$ | $0.268797\le\tfrac13$ | $\tfrac{5}{(n-6)(n-1)}\le\tfrac1{12}\iff n^2-7n-54\ge0\iff n\ge12$ (root $\tfrac{7+\sqrt{265}}2=11.639$) |

**Both directions of the threshold verified: $p=4$ fails and $p=5$ passes, at $n=12$ and at $n=20$.**

**And the converse, which the block leaves implicit and its consumers rely on.** $g(p)=\frac1{p-1}+\frac1{n-p-1}$ is convex and symmetric about $p=n/2$, so on $5\le p\le n-5$ it is largest at the ends; since $p=5$ passes for $n\ge12$, **every** split with $p,q\ge5$ passes. So for $n\ge12$ the surviving set is *exactly* $\{p,q\ge5\}$, which is what [C3](../findings/graded-half.md#L288) uses when it says the $(6,6)$ slice carries two points above the threshold. Checked against the record: at $n=12$ the four coordinate splits give $\theta=1.236033$, $1.228239$, $1.201553$, $1.141798$ at $(6,6),(5,7),(4,8),(3,9)$, the first two above $\sqrt{3/2}=1.224745$ and the last two below, matching every figure the file quotes elsewhere.

**$p=1$ is not addressed in the block.** It is excluded, but by the Einstein normalisation ("*no flat factors occur*", [line 96](../findings/graded-half.md#L96)) and not by the displayed inequality, into which $f(1)$ cannot be substituted.

## 4. Three or more factors, TRUE, but the proof does not exclude them

The proof's warrant is "*$B$ … minimised at $k=2$ balanced … so above the threshold every factor is a sphere and $k=2$*". **That does not exclude $k=3$.** "Minimised at $k=2$ balanced" gives $B\ge\frac{n^2}{8(n-1)(n-2)}$, which is the *conjecture's* threshold, not $\tfrac16$; a $k=3$ partition satisfying $B\le\tfrac16$ would be perfectly consistent with that sentence. This is exactly the case the brief warns a norm bound can silently permit.

**The exclusion is true and takes one line, which the block should carry.** $f(m)>\tfrac18$ for every $m$, so $\sum_{a=1}^k f(n_a)>\tfrac k8$, and

$$k\ge3\ \Longrightarrow\ B>\tfrac38-\tfrac{n}{8(n-1)}\ \ge\ \tfrac38-\tfrac{12}{88}=0.2386>\tfrac16\qquad(n\ge12),$$

with the bracket decreasing to $\tfrac38-\tfrac18=\tfrac14$ as $n\to\infty$. Tightest instance $(4,4,4)$ at $n=12$: $B=\tfrac12-\tfrac{3}{22}=0.3636$. **So $k\ge3$ is excluded by the same inequality, at every $n$, but by an estimate the proof never performs.**

**A second unperformed step in the same sentence.** "*Each $\lVert W_a\rVert^2$ vanishing exactly when that factor is a sphere, so above the threshold every factor is a sphere*" is a non-sequitur as written: non-vanishing alone does not break a budget. What closes it is the **quantitative** L47 bound, a non-constant-curvature irreducible factor has $\lVert W_a\rVert^2\ge\tfrac16$, and $B>0$ for every $k\ge2$, so $\lVert W\rVert^2>\tfrac16$. *The tightest case is a $\mathbb{CP}^2$ factor at exactly $\tfrac16$, and it is the strictness of $B>0$ that kills it*, e.g. $\mathbb{CP}^2\times S^8$ at $n=12$ gives $\tfrac16+0.17316=0.3398$.

## 5. The nondegeneracy half, CONFIRMED, and the word *exactly* is what is proved

The half is discharged by [Lemma L27](../findings/nondegeneracy.md#L457), and it is a genuine theorem in the required generality, not a check at particular dimensions. $\mathrm{Weyl}_n$ splits into **ten** $O(p)\times O(q)$-summands with pairwise distinct Young labels, hence multiplicity-free; $L_e$ is equivariant and symmetric, so Schur makes it a **scalar on each summand and each value is an eigenvalue rather than a bound**. The values: $1$ on $\langle W\rangle$ (removed by restricting to $W^\perp$), $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (which is precisely the orbit tangent, $\dim pq=\dim\mathfrak m$), $\lambda_m=\frac{m-2}{2(m-1)}$ on each $S^2_0(\mathbb R^m)$, $\pm\mu$ on the two tensor summands, $0$ on the remaining four, and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ off $(3,3)$.

**So $\tfrac12$ is attained on the orbit summand alone**, which is the content the brief identifies, given that [Lemma L24](../findings/second-order.md) already makes $\lambda_{\max}\le\tfrac12$ and the orbit directions exact $\tfrac12$-eigenvectors. **The word *exactly* is proved, symbolically, for every $(p,q)$ with $p,q\ge3$ other than $(3,3)$, and $p,q\ge5$ is the case proved in the source (Nienhaus Prop 4.6 / Rmk 4.7(ii)) rather than the case the record had to supply by hand.** L69's "$p,q\ge5$ implies $p,q\ge3$ with $(p,q)\ne(3,3)$" is trivially correct.

**The second-eigenvalue claim checks out too.** For $p,q\ge5$, $\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}\ge\frac{1}{2(M-1)}$ reduces to $(m-2)(M-2)\ge m$ with $m=\min$, true since $m\ge5$; so $\lambda_2=\lambda_M=\frac{M-2}{2(M-1)}$ and the gap is $\frac{1}{2(M-1)}$, $=\tfrac1{12}$ at $S^5\times S^7$. **Correct, and the warning that the margin decays like $1/n$ is well taken.**

### 5a. A live "open curiosity" in this same file is closed by L69's own sentence

The [COLLISION RESOLVED box at line 283](../findings/graded-half.md#L283) records that the slice maxima $0.375$, $0.3333$, $0.375$, $0.400$ at $(3,5),(4,4),(5,5),(6,6)$ match $\frac{M-2}{2(M-1)}$ "to every digit", calls it "a coincidence of value between two provably different restrictions", and keeps it as "**an open curiosity**" that "**nothing on the record explains**".

**It is not a coincidence and L69 explains it, 56 lines below.** The slice excludes the orbit tangent (the box proves this itself: $\mathrm{ad}X$ for $X\in\mathfrak m$ anticommutes with the grading involution), so $\lambda_{\max}$ on the slice is the **second** eigenvalue of $L_e$, which L69's own line 339 states is $\frac{M-2}{2(M-1)}$. All four values follow: $M=5,4,5,6$ give $\tfrac38,\tfrac13,\tfrac38,\tfrac25$. **The curiosity should be struck and replaced with the identification.**

## 6. Threshold and range, consistent, and nothing needs $n$ even

- $\sqrt{3/2}$ appears in exactly two roles and they agree: as $\lVert W\rVert^2\le\tfrac16$ in both branches, and as the irreducible ceiling of L47. No step uses a different threshold.
- $n\ge12$ is used **once**, at $p=5$, and it is genuinely needed there: $(5,5)$ at $n=10$ gives $\tfrac14+\tfrac14-\tfrac19=0.3889>\tfrac13$, so the lemma is false at $n=10$ and the hypothesis is sharp, not decorative. *The polynomial is $n^2-7n-54$, which is **not** the record's recurring $n^2-12n+8$, the block's "the threshold dimension of the conjecture itself, appearing here for the fourth independent time" is right that both give $n\ge12$, and would be clearer for saying they are different polynomials with the same integer root.*
- **No step needs $n$ even.** The $\mathfrak u(n/2)$ grading exists only at even $n$ and is excluded by the threshold in any case ($\theta(\mathbb{CP}^m)=1.054093,0.986013,0.948683,0.924962$ at $m=3,4,5,6$, decreasing, I checked these against $\lVert W\rVert^2_{\mathbb{CP}^m}=\frac{3m(m-1)}{4(m+1)(2m-1)}$ and they are exact). At odd $n$ only $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ survives and the arithmetic is unchanged: $n=13$ gives $(5,8)$ at $0.309524$ and $(6,7)$ at $0.283333$, both admissible.
- The $n\ne8$ caveat on the $\mathbb Z_2$-grading enumeration is correctly discharged twice over ($n\ge12$, and both exceptional points sit below the threshold).

## 7. Cross-checks against the rest of the record

- **A broken citation, twice on one line.** [Line 339](../findings/graded-half.md#L339) cites [fence-posts.md](../findings/fence-posts.md) for "the unconditional nondegeneracy theorem" and for the family-B formula. **Neither is in fence-posts.md.** Both are in [nondegeneracy.md](../findings/nondegeneracy.md), L27 at line 457, the family-B correction at lines 738–744. [results.md:530](../results.md#L530) cites L27 correctly, so the canonical statement is right and only the findings block is wrong.
- **[bounds.md](../findings/bounds.md) does not contradict L69.** Its line 469 ends "*which is what Lemma L69 needed one for*", attributing a two-eigenvalue hypothesis to L69; L69 uses no such hypothesis anywhere (L23 does). A mis-attribution in bounds.md, harmless to L69.
- **The consumer 25 lines above L69 inherits a defect the labelling table 20 lines below it names.** [Line 302](../findings/graded-half.md#L302) splits the graded class as "*either equivariant, where Lemma L69 applies … or non-equivariant, **which is to say $\Delta>0$***". The labelling table at [line 351](../findings/graded-half.md#L351) marks exactly that inference "**UNSOUND off $\ker W=0$**". The dichotomy itself is fine; its $\Delta$ gloss is not, and C3's open target is stated in terms of the gloss. **This is the "refuted by a passage below it, unreconciled" pattern the brief warns about, present, and in the paragraph that consumes L69.**
- **A scope slip in the definitions block.** [Line 246](../findings/graded-half.md#L246) treats $\mathbb{HP}^3$ and $\mathrm{Gr}_{\mathbb C}(2,3)$ at $n=12$ as members of class (C). They are not: (C) requires $\mathfrak p$ to be a $\mathbb Z_2$-grading of $\mathfrak{so}(12)$, whose dimensions are $30,31,34,39,46,55$ and $36$, while their isotropy algebras have dimension $24$ and $12$ and so contain no grading subalgebra. Harmless to L69 (it only shrinks the class L69 quantifies over) but the record should not claim those points are pair-graded.

## 8. Required repairs

1. **Replace the opening sentence.** Delete the appeal to the classification of compact symmetric spaces and promote the $\mathbb Z_2$-grading + one-dimensional-commutant route, with the count of §1b written out. Stop citing [Lemma L8](../findings/graded-half.md) as the supplier of a correspondence it assumes; the "What it inherits" paragraph must be corrected in the same edit.
2. **Delete the [ungraded-slack.md](../findings/ungraded-slack.md) "agreement" sentence**, or restate it as a contrast: its hypothesis (F2) fails for every unbalanced split, by that file's own line 134, and its $W_{\mathfrak h}$ is a different operator.
3. **Add the $k\ge3$ line** ($\sum_a f(n_a)>\tfrac k8$, so $B>\tfrac38-\frac{n}{8(n-1)}>\tfrac16$) and the quantitative L47 step that turns "vanishes iff a sphere" into "every factor is a sphere".
4. **Fix the two [fence-posts.md](../findings/fence-posts.md) citations on line 339 to [nondegeneracy.md](../findings/nondegeneracy.md) / Lemma L27**, and repair line 375's "unconditional … by a symbolic solve over all 45 summand pairs", which points at the same absent place.
5. **Strike the "open curiosity"** in the line-283 box and replace it with the identification of §5a.

*Also worth doing, lower priority: quote [conventions.md](../findings/conventions.md) for the Einstein-$\tfrac12$ normalisation the block silently assumes; note that $p=1$ is excluded by that normalisation rather than by the inequality; note that the negative sign $-\hat W_{\mathfrak h}$ is excluded by $\theta>0$; and add "$W\ne0$" to L47's boxed statement.*

## 9. What would need computation, and was therefore not done

Nothing in this audit did. Two points were settled by derivation that a run could have been spent on: the commutant dimension at $n\ge12$ (§1b) and the $k\ge3$ exclusion (§4). **If the record wants an independent numerical corroboration of §1b, the run to authorise would be an exact-rational commutant rank at the $n=12$ and $n=13$ gradings**, it would decide whether $\dim(\mathcal W_n)^{\mathfrak p}=1$ at the lemma's own dimensions rather than at $n=8,10$. **A `1` would corroborate the derivation; anything larger would refute §1b and reopen the classification appeal, since a second invariant direction could carry a second equivariant graded critical point on the same pair.** *That run is not authorised here and was not performed.*
