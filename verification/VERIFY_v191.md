# VERIFY_v191, L48: the reducible case, and the symmetric-space Theorem

**Cold read of [BRIEF_L48.md](BRIEF_L48.md), verifier v191.** The brief was read before the sources; conventions were taken from [conventions.md](../findings/conventions.md) and quoted. **No numerical work of any kind was done**, no script, no Sage, no numeric evaluation. Every figure below is exact rational arithmetic carried out symbolically in the text, on objects the record already names, and none of it is offered as evidence for a positive claim. Log: `agent_logs/verify-L48-v191.log`.

**The block carries two objects and they are kept apart throughout**: a lemma about products (the decomposition, the closed form, Jensen, the threshold meeting) and a Theorem about symmetric spaces stated inside a blockquote. They receive separate verdicts.

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | For a product, $R$ is block-diagonal on $\Lambda^2$ and zero on the mixed terms | **CONFIRMED**, unconditional for $R$; **it is $R$ and not $W$**, and $W$ is $-cI$ on the mixed block, never zero |
| 2 | $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, $B=\sum_af(n_a)-\tfrac n{8(n-1)}$, $f(m)=\tfrac m{8(m-1)}$ | **CONFIRMED**, derived twice independently below, the two routes agreeing |
| 3 | $B$ depends on the partition alone | **CONFIRMED for $B$**; **the landscape line's "$\lVert W\rVert^2$ depends on the partition alone" is FALSE as written** |
| 4 | the closed form needs nothing but the partition | **REFUTED**, it needs every factor Einstein with the **same** constant; unstated in the canonical block, stated in [graded-half.md](../findings/graded-half.md) |
| 5 | $f$ decreasing and convex | **CONFIRMED**, $f'=-\tfrac1{8(m-1)^2}$, $f''=\tfrac1{4(m-1)^3}$ |
| 6 | Jensen minimises $\sum f$ at the balanced split for fixed $k$ | **CONFIRMED**, and the direction is the right one; the constraint is $\sum_an_a=n$ at fixed $k$, and the relaxation to real $n_a$ is safe because a **lower** bound on $\sum f$ is what the argument spends |
| 7 | $k\,f(n/k)=\tfrac{kn}{8(n-k)}$, increasing in $k$ | **CONFIRMED**, the identity is exact and $\tfrac{d}{dk}\tfrac k{n-k}=\tfrac n{(n-k)^2}>0$ |
| 8 | $\lVert W_a\rVert^2\ge0$ vanishes exactly when the factor is a sphere | **HALF REFUTED**, $\Leftarrow$ holds; $\Rightarrow$ gives **constant curvature**, which $\mathbb{RP}^m$ also satisfies. [graded-half.md:389](../findings/graded-half.md) already records this and the canonical block still says "sphere" |
| 9 | the reducible minimum **sits at** $S^{n/2}\times S^{n/2}$ | **CONFIRMED as a bound, REFUTED as attainment at odd $n$**, the paragraph carries no parity hypothesis; the Theorem's blockquote does |
| 10 | that minimum is $\tfrac{n^2}{8(n-1)(n-2)}=\tfrac1{4\theta_0(n)^2}$ | **CONFIRMED**, both equalities derived |
| 11 | $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$ | **CONFIRMED**, and the polynomial is genuinely recovered, not assumed |
| 12 | the Theorem's quantifier, "every compact Einstein symmetric space of dimension $n\ge12$" | **REFUTED, a third hypothesis is still missing.** $W\ne0$ is owed, and $S^{12}$, $\mathbb{RP}^{12}$ and $T^{12}$ are all inside the quantifier |
| 13 | equality exactly at $S^{n/2}\times S^{n/2}$, round factors, equal Einstein constant, $n$ even | **REFUTED as written**, $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ attains it; and both added clauses are **implied** by the theorem's own hypotheses rather than restrictions on it |
| 14 | Einstein is load-bearing | **CONFIRMED, and load-bearing twice over**, the block names only [L46](../findings/problem.md)'s identity; the closed form of claim 2 needs it independently |
| 15 | a reducible symmetric space with unequal factor Einstein constants is not Einstein | **CONFIRMED** |
| 16 | "sphere" alone does not fix the metric | **CONFIRMED**, the radius is free, and $\theta$ is not |
| 17 | at $n=13$, $\theta^2=\tfrac{120}{77}$ against $\theta_0^2=\tfrac{264}{169}$ | **CONFIRMED**, both derived, and $\tfrac{120}{77}$ is exactly [conventions.md](../findings/conventions.md)'s $\Theta_{13}^2$ |
| 18 | the reduction of an arbitrary compact Einstein symmetric space to "irreducible or product" | **GAP**, de Rham is used and never invoked; no argument on file in either copy |
| 19 | the repair's summary, "two hypotheses were missing, and neither changes a value" | **REFUTED as a description**, three things changed, a fourth is still owed, and a narrowed quantifier is a changed theorem even when no number moves |
| 20 | the argument exists in exactly one place | **REFUTED**, a second full copy is in [graded-half.md](../findings/graded-half.md), and the two disagree on the hypothesis of claim 4 |

**One line.** The lemma's arithmetic is right and I could not break any of it, the closed form, Jensen's direction, the $k$-monotonicity and the threshold equivalence all survive a cold rebuild, but the canonical block states the closed form without the Einstein hypothesis that produces it, its "is a sphere" clause is false in the direction it is used, and the Theorem above it is still missing $W\ne0$, a hypothesis the record insists on one block earlier.

**Verdict (the lemma: `PROVEN), hypotheses corrected`.** **Verdict, the Theorem: `HYPOTHESIS-DEBT`.** The round's headline verdict is the weaker of the two.

## 0. Conventions, fixed once

Quoted, not restated.

- $\theta$: "*$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$*".
- $\theta_0(n)$: "***the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$*". The gloss that was removed on 2026-09-04 is precisely the one L48's paragraph still leans on, which is why §5 below separates the bound from the attainment.
- $\Theta_n$: "*the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$*".
- $R_I$, $R_{\mathrm{ric}_0}$, $R_W$: "*the three $O(n)$-irreducible pieces of an algebraic curvature operator, scalar, **trace-free** Ricci, and Weyl. $R_{\mathrm{ric}_0}=0$ makes a slice **Einstein***". This is the line that makes §4's finding unavoidable: off the Einstein slice, $R-cI$ is not the Weyl part.
- The pairing: "***The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.*** *The inner product is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level*". Restricting this pairing to a sub-block $\Lambda^2V_a\subset\Lambda^2\mathbb R^n$ is an isometry, so no factor of $2$ enters §3's factorwise sum.
- $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ on $\Lambda^2$, used once, in §3, to get $\mathop{\mathrm{tr}}R=n/4$ at $\lambda=\tfrac12$.
- $N=\binom n2=\dim\Lambda^2\mathbb R^n$.
- The letter $B$: conventions already books **three** objects under it, the Killing form $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$, [sym3-blocks.md](../findings/sym3-blocks.md)'s $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$, and "*$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point … **This is a third object under the letter $B$ in this record***", plus the $B$ tabled among L47's working symbols. **L48's $B$ is a scalar and is a fifth.** See §9.

## 1. Hypothesis inventory

*A pass with no inventory is not a pass. Every hypothesis the argument consumes, and where it is written.*

| # | hypothesis | consumed at | stated where |
| --- | --- | --- | --- |
| H1 | the space is a Riemannian product $M_1\times\cdots\times M_k$ | the decomposition, §2 | in the block ("For a product") |
| H2 | **every factor is Einstein with the same constant, normalised to $\lambda=\tfrac12$** | the closed form, §3–§4 | **not in the canonical block**; in [graded-half.md](../findings/graded-half.md) as "*The Einstein normalisation forces every factor of a product to be Einstein with the same constant $\tfrac12$*"; in the block only obliquely, inside the repair blockquote, as a remark about the Theorem |
| H3 | $\lambda>0$, so no flat factor | H2 with $\lambda=\tfrac12$; and $f$'s pole | **not in the canonical block**; graded-half's "*so no flat factors occur*" |
| H4 | $n_a\ge2$ for every $a$, $f(m)=\tfrac m{8(m-1)}$ has a pole at $m=1$ | Jensen, §5 | **nowhere**; forced by H3 (a $1$-dimensional factor is flat) |
| H5 | $k\ge2$ | the $k$-monotonicity, §5 | carried by the word *reducible* and written nowhere. Load-bearing: at $k=1$ the same monotonicity statement points the other way and $B=0$ |
| H6 | $n$ even, for **attainment** | "the reducible minimum sits at $S^{n/2}\times S^{n/2}$" | **not in the paragraph**; in the Theorem's "when $n$ is even" |
| H7 | $\theta$ is scale-invariant, which is what makes "normalise to $\lambda=\tfrac12$" free | §3, §6 | **nowhere** |
| H8 | de Rham: a compact Einstein symmetric space is irreducible or a product of such | the Theorem's quantifier, §8 | **nowhere** in either copy |
| H9 | [L46](../findings/problem.md): locally symmetric, Einstein, $\lambda\ne0$, **$W\ne0$** | $\theta=\lambda/\lVert W\rVert$ throughout | three of the four discharged; **$W\ne0$ is not**, §7 |
| H10 | [L47](../findings/problem.md): compact, irreducible, symmetric, $W\ne0$, $\lambda=\tfrac12$ | the irreducible half of the Theorem | in L47's block; L47's own owed step (monotonicity of the $\mathbb{CP}^m$ and $\mathbb{HP}^m$ closed forms on $m\ge2$, "*established on a five-point scan*") is inherited here, §10 |
| H11 | $n\ge12$ | the threshold meeting only, §6 | in the Theorem |

**H2, H3, H4, H5, H6, H7 and H8 are the seven the canonical block does not write down.** Of these H2 is the one whose absence makes a displayed identity false rather than merely under-specified.

## 2. The decomposition, derived, and what it needs

Let $M=M_1\times\cdots\times M_k$ with $T_pM=V_1\oplus\cdots\oplus V_k$. The Levi-Civita connection of a product metric is the direct sum of the factors' connections, so for $X\in V_a$, $Y\in V_b$ with $a\ne b$ the fields commute and $\nabla_X\nabla_Y=\nabla_Y\nabla_X$ on any lift, giving $R(X,Y)=0$. Hence $R_{ijkl}=0$ unless all four indices lie in one factor.

Read on $\Lambda^2T_pM=\bigl(\bigoplus_a\Lambda^2V_a\bigr)\oplus\bigl(\bigoplus_{a<b}V_a\otimes V_b\bigr)$ this says two separate things, and the block's phrasing runs them together correctly:

- **block-diagonal**: $\langle R(X\wedge Y),Z\wedge W\rangle=R_{XYZW}=0$ for $X,Y\in V_a$ and $Z,W\in V_b$, $a\ne b$, so the $\Lambda^2V_a$ blocks do not couple;
- **zero on the mixed terms**: $R(X\wedge Z)=0$ for $X\in V_a$, $Z\in V_b$, and likewise against everything.

**What it needs**: the product structure and nothing else. No Einstein hypothesis, no symmetry, no compactness. This is the one claim in the block that is unconditional.

> **A reading trap the block leaves open, and the whole constant $B$ lives inside it.** The sentence is about $R$. It is **false of $W$**: on the mixed block $W=R-cI=-cI\ne0$, and the mixed block contributes $c^2\cdot\tfrac12(n^2-\sum_an_a^2)$ to $\lVert W\rVert^2$, which is one of the two terms that make up $B$. A reader who carries "zero on the mixed terms" across the "so" and applies it to $W$ derives $B=0$.

## 3. The closed form, two independent derivations, agreeing

**Route A, the record's (from [graded-half.md](../findings/graded-half.md)).** At $\lambda=\tfrac12$, $\mathop{\mathrm{scal}}=n\lambda=\tfrac n2$ and $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}R$, so $\mathop{\mathrm{tr}}R=\tfrac n4$ and

$$c=\frac{\mathop{\mathrm{tr}}R}N=\frac{n/4}{n(n-1)/2}=\frac1{2(n-1)}=\frac\lambda{n-1},$$

which is exactly [L46](../findings/problem.md)'s centring constant. Since $\mathop{\mathrm{tr}}W=0$, $W=R-cI$ is orthogonal to $I$ and

$$\lVert W\rVert^2=\lVert R\rVert^2-c^2N=\lVert R\rVert^2-\frac n{8(n-1)}.$$

The same identity **applied factorwise** (which is where H2 enters, since it requires $\lambda_a=\tfrac12$ in each factor), gives $\lVert R_a\rVert^2=\lVert W_a\rVert^2+f(n_a)$ with $f(m)=\tfrac m{8(m-1)}$. With $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$ from §2,

$$\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-\frac n{8(n-1)}.$$

**Route B, built cold from the blocks, as a check on Route A.** On $\Lambda^2V_a$, $W=W_a+(c_a-c)I$ with $c_a=\tfrac1{2(n_a-1)}$; on the mixed block $W=-cI$. The cross term dies because $\langle W_a,I_a\rangle=\mathop{\mathrm{tr}}W_a=0$. So

$$B=\sum_a(c_a-c)^2N_a+c^2\cdot\frac{n^2-\sum_an_a^2}2,\qquad N_a=\frac{n_a(n_a-1)}2 .$$

Expanding one term,

$$(c_a-c)^2N_a=\frac{n_a(n_a-1)}8\Bigl[\frac1{(n_a-1)^2}-\frac2{(n_a-1)(n-1)}+\frac1{(n-1)^2}\Bigr]=f(n_a)-\frac{n_a}{4(n-1)}+\frac{n_a(n_a-1)}{8(n-1)^2},$$

so summing and adding $c^2(n^2-\sum n_a^2)/2=(n^2-\sum n_a^2)/(8(n-1)^2)$,

$$B=\sum_af(n_a)-\frac n{4(n-1)}+\frac{\sum n_a^2-n+n^2-\sum n_a^2}{8(n-1)^2}=\sum_af(n_a)-\frac n{4(n-1)}+\frac{n(n-1)}{8(n-1)^2}=\sum_af(n_a)-\frac n{8(n-1)} .$$

**$\sum_an_a^2$ cancels identically.** That cancellation is the actual content of "depends on the partition alone" at the level of the *shape* of the answer, and it is worth saying that it is a cancellation rather than an obvious fact: the two contributions each carry $\sum n_a^2$ and they carry it with opposite signs.

**Sanity at $k=1$**: $B=f(n)-\tfrac n{8(n-1)}=0$, so the formula degenerates correctly to $\lVert W\rVert^2=\lVert W_1\rVert^2$.

**CONFIRMED.** Two routes, one from the record and one built independently, land on the same $B$.

## 4. "Depending on the partition alone", what is true and what is not

**True**: $B$ is a function of $(n_1,\dots,n_k)$ and of nothing else.

**False as written in the landscape line** ([results.md:172](../results.md)): "*For a product the mixed terms vanish, so $\lVert W\rVert^2$ depends on the partition alone*". It does not: $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, and the first term varies over the factors' geometry at fixed partition. At $n=12$ the partition $(6,6)$ gives $\tfrac9{55}$ at $S^6\times S^6$ and strictly more at $\mathbb{CP}^3\times S^6$, same partition. The canonical block escapes this by attaching the phrase to $B$ (nearest antecedent); the landscape line attaches it to $\lVert W\rVert^2$ and is wrong. The consumer at [results.md:567](../results.md) repeats the loose form and then repairs it in the same breath ("*$\lVert W\rVert^2$ depends on the partition alone with every non-sphere factor adding to it*") which is self-contradictory as a sentence and correct as an intention.

**And the formula needs more than the partition.** This is the finding, and it is the same one the repair blockquote concedes for the Theorem without carrying it back into the paragraph above it.

- $c_a=\lambda_a/(n_a-1)$. Route A's factorwise step and Route B's block decomposition both fix $c_a=\tfrac1{2(n_a-1)}$, which presumes $\lambda_a=\tfrac12$ for **every** factor.
- If the $\lambda_a$ differ, the product is not Einstein (§7 claim 15), and then $W\ne R-cI$ at all: by [conventions.md](../findings/conventions.md), $R_{\mathrm{ric}_0}=0$ is what makes the slice Einstein, and off it the trace-free Ricci piece is nonzero. That piece does **not** vanish on the mixed block (it is a Kulkarni–Nomizu product with a non-scalar symmetric tensor) so the Weyl part of a non-Einstein product is not even block-diagonal.

So H2 is load-bearing for the displayed identity, independently of L46. **The block's repair justifies Einstein by L46 alone.** That is one of the two reasons, and the block names only that one.

## 5. Jensen, direction, constraint, and the relaxation

$f(m)=\tfrac m{8(m-1)}=\tfrac18\bigl(1+\tfrac1{m-1}\bigr)$, so on $m>1$

$$f'(m)=-\frac1{8(m-1)^2}<0,\qquad f''(m)=\frac1{4(m-1)^3}>0 .$$

**Decreasing and convex: CONFIRMED.**

**The direction, and the constraint the brief asks to be named.** Convexity gives, for $n_a>1$ with $\sum_an_a=n$ at **fixed $k$**,

$$\frac1k\sum_af(n_a)\ \ge\ f\Bigl(\frac1k\sum_an_a\Bigr)=f(n/k)\quad\Longrightarrow\quad \sum_af(n_a)\ \ge\ k\,f(n/k).$$

So the constraint is the **fixed sum $\sum n_a=n$ at fixed $k$**, and convexity puts the **minimum** of the sum at the balanced point. This is the direction the argument needs, because the quantity being minimised is $\lVert W\rVert^2$ and $\theta=\lambda/\lVert W\rVert$ is *decreasing* in $\lVert W\rVert$: the maximum of $\theta$ sits at the minimum of $\lVert W\rVert^2$.

> **The relaxation is safe, and it is safe in one direction only.** Jensen is applied over real $n_a$ while the admissible $n_a$ are integers $\ge2$. Because the conclusion is a **lower** bound on $\sum f$, and the integer minimum is at least the real minimum, the *inequality* $\lVert W\rVert^2\ge\tfrac1{4\theta_0(n)^2}$ survives at every $n$ including odd. What does not survive is **attainment**, see §8's odd-$n$ item. Had the argument spent Jensen as an upper bound, the relaxation would have been unsound.

**The $k$-monotonicity.** $f(n/k)=\dfrac{n/k}{8(n/k-1)}=\dfrac n{8(n-k)}$, so $k\,f(n/k)=\dfrac{kn}{8(n-k)}$ (**the identity is exact**) and $\dfrac{d}{dk}\dfrac k{n-k}=\dfrac{(n-k)+k}{(n-k)^2}=\dfrac n{(n-k)^2}>0$ on $0<k<n$. **Increasing: CONFIRMED.**

**$k=1$ against $k\ge2$, the trap named in the brief.** The monotonicity is spent only on $k\ge2$, and must be: $k=1$ gives $1\cdot f(n)-\tfrac n{8(n-1)}=0$, strictly below the $k=2$ value $\tfrac{n^2}{8(n-1)(n-2)}>0$. A reader who admits $k=1$ into "the minimum over $k$" concludes that the minimum of $\lVert W\rVert^2$ is $\lVert W_1\rVert^2$, which is $0$ at $S^n$, and $\theta$ is then $0/0$. The word *reducible* excludes $k=1$ in both copies, and neither writes $k\ge2$. **Adequately scoped, never stated (H5).**

**The joint minimisation is separable, which the block treats as obvious.** $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$ minimises term by term because $\lVert W_a\rVert^2\ge0$ is attainable at $0$ *simultaneously* with the balanced partition, a round factor of dimension $n/2$ exists whenever $n/2$ is an integer $\ge2$. At odd $n$ the two terms are still separately minimisable, and the bound stands; only the partition term fails to reach its relaxed floor.

## 6. The meeting, and the threshold polynomial recovered

**The reducible minimum.** At $k=2$, $n_1=n_2=n/2$, with both factors round so $\lVert W_a\rVert^2=0$: $f(n/2)=\dfrac{n/2}{8(n/2-1)}=\dfrac n{8(n-2)}$, so

$$\lVert W\rVert^2=\frac{2n}{8(n-2)}-\frac n{8(n-1)}=\frac n8\cdot\frac{2(n-1)-(n-2)}{(n-1)(n-2)}=\frac n8\cdot\frac n{(n-1)(n-2)}=\frac{n^2}{8(n-1)(n-2)} .$$

**And that it is $\tfrac1{4\theta_0(n)^2}$.** By conventions, $\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{n^2}$, so $\dfrac1{4\theta_0(n)^2}=\dfrac{n^2}{8(n-1)(n-2)}$. **Identical. CONFIRMED.** With [L46](../findings/problem.md)'s $\theta=\lambda/\lVert W\rVert$ at $\lambda=\tfrac12$, i.e. $\theta^2=\tfrac1{4\lVert W\rVert^2}$, this reads $\theta=\theta_0(n)$ exactly.

**The equivalence.**

$$\frac16\ \ge\ \frac{n^2}{8(n-1)(n-2)}\iff 8(n-1)(n-2)\ge6n^2\iff 8n^2-24n+16\ge6n^2\iff 2n^2-24n+16\ge0\iff n^2-12n+8\ge0 .$$

Both directions are multiplication by the positive quantity $48(n-1)(n-2)$ at $n\ge3$, so the $\iff$ is genuine. **CONFIRMED.**

**Recovered rather than assumed.** The two inputs are $\tfrac16$, L47's irreducible floor, whose provenance is the $\mathbb{CP}^2$ closed form $\lVert W\rVert^2=\tfrac{3m(m-1)}{4(m+1)(2m-1)}$ at $m=2$, a rank-one computation with no threshold in it, and $\tfrac{n^2}{8(n-1)(n-2)}$, which §3 built out of $f$ and the centring constant, again with no threshold in it. The polynomial falls out of setting them equal. Its roots are $n=\tfrac{12\pm\sqrt{144-32}}2=6\pm2\sqrt7$, and $2\sqrt7=5.2915\ldots$, so the positive root is $11.2915\ldots$ and the integer cutoff is $12$. **This is the same polynomial [ATTEMPTS.md:228](../ATTEMPTS.md) reaches from the competitor comparison $2(n-1)(n-2)/n^2=3/2$, which is the same equation divided through, so "recovered" is fair, and the two derivations are the same identity read at two places rather than two independent facts.** Recording it as an independent appearance would be the overclaim; the block says only "recovered rather than assumed", which is exactly right.

**The boundary.** At $n=12$: $144-144+8=8>0$, so the reducible side wins with $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}$ against $\tfrac32=\tfrac{54}{36}$, a margin of $\tfrac1{36}$. At $n=11$: $121-132+8=-3<0$, and the irreducible side is the larger. **The $n\ge12$ is sharp among integers.** $\tfrac{55}{36}$ agrees with conventions' own $n=12$ table, "$\tfrac{99}{65}<\tfrac{55}{36}<\tfrac{220}{117}$".

## 7. The Theorem, taken separately

> **Theorem.** For every $n\ge12$, every compact **Einstein** symmetric space of dimension $n$ satisfies $\theta\le\theta_0(n)$, with equality exactly at $S^{n/2}\times S^{n/2}$ **with both factors of constant curvature and equal Einstein constant**, when $n$ is even.

### 7.1 Einstein is load-bearing, CONFIRMED, and for two reasons where the block gives one

The block's reason: $\theta$ comes from [L46](../findings/problem.md)'s $Q(W)=\lambda W$, which needs $\mathrm{Ric}=\lambda g$. Correct, L46's statement is "*Let $R$ be the curvature operator of a locally symmetric Einstein space, $\mathrm{Ric}=\lambda g$*", and its step (B), the shift $c=\lambda/(n-1)$ that kills the remainder, is meaningless without a single $\lambda$.

The reason the block omits: **§4's closed form needs it too.** Without a common $\lambda$ the object $R-cI$ is not the Weyl part, the mixed block of $W$ is not $-cI$, and $B$ is not a function of the partition. So Einstein is consumed twice and credited once.

**Is the Einstein-free statement false, or merely unproved?** Unproved. I looked for a witness (a non-Einstein compact symmetric space of dimension $n\ge12$ with $\theta>\theta_0(n)$) and found none in closed form on this record, and constructing one would need the Weyl part of a space like $S^p(r_1)\times S^q(r_2)$ with $r_1\ne r_2$, which nothing on file computes. **I therefore record "load-bearing" as a statement about the proof and not about the truth of the wider claim**, and name it in §11 as a falsifier route.

### 7.2 Unequal factor Einstein constants, CONFIRMED

For $M=M_1\times M_2$ with each factor Einstein, $\mathrm{Ric}_M=\lambda_1g_1\oplus\lambda_2g_2$, which is $\lambda g$ if and only if $\lambda_1=\lambda_2=\lambda$. If a factor is not itself Einstein the product is not either. **The block's clause is exactly right**, and its consequence ("*so the formula never applied to it*"), is right as well.

### 7.3 "Sphere" alone does not fix the metric, CONFIRMED

$\theta$ is scale-invariant, so the *radius* is not what breaks; what breaks is the comparison **between the two factors**. $S^p(r_1)\times S^q(r_2)$ has $\lambda_1=(p-1)/r_1^2$ and $\lambda_2=(q-1)/r_2^2$, and these agree only on a codimension-one set of $(r_1,r_2)$. So "$S^{n/2}\times S^{n/2}$" without a metric names a family on which $\theta$ is non-constant and mostly not even defined by L46. **The clause the repair added is genuinely needed as a specification.**

### 7.4 $\lVert W_a\rVert^2=0$ iff the factor is a sphere, HALF REFUTED, and the record already knows

**$\Leftarrow$**: a round sphere has $R=\text{const}\cdot I$ on $\Lambda^2$, hence $W=0$. Holds.

**$\Rightarrow$**: $W_a=0$ with $M_a$ Einstein forces constant curvature, for $n_a\ge4$ because $R=W+(\text{Ric part})+(\text{scalar part})$ collapses to the scalar part; for $n_a\in\{2,3\}$ because $W\equiv0$ identically there and Einstein already forces constant curvature. So the conclusion is **constant curvature**, i.e. a spherical space form, and among compact symmetric spaces those are $S^m$ **and $\mathbb{RP}^m$**.

**The discrepancy, cleared on all three counts.**

1. **Located**: [problem.md:256](../findings/problem.md), "*each $\lVert W_a\rVert^2\ge0$ vanishes exactly when that factor is a sphere*", and the same clause in [graded-half.md](../findings/graded-half.md)'s copy ("*has constant curvature, i.e. **is a sphere***").
2. **Exhibited, in closed form**: $\mathbb{RP}^6\times\mathbb{RP}^6$ at $n=12$, each factor of constant curvature normalised to $\lambda=\tfrac12$. It is compact, symmetric, Einstein with a single constant, of dimension $12$, and locally isometric to $S^6\times S^6$, so it has the identical curvature operator, $\lVert W\rVert^2=\tfrac{144}{880}=\tfrac9{55}$ and $\theta=\theta_0(12)=\tfrac{\sqrt{55}}6$. It is not $S^6\times S^6$: $\pi_1=\mathbb Z/2\times\mathbb Z/2$. $S^6\times\mathbb{RP}^6$ does the same job.
3. **Argued opposite**: (i) *Is $\mathbb{RP}^m$ a compact symmetric space?* Yes, a rank-one one, and **the record itself lists it**, [problem.md:241](../findings/problem.md), "*$S^n$ and $\mathbb{RP}^n$ have $W=0$*". (ii) *Could the Theorem mean "up to local isometry"?* It does not say so, and it takes the trouble to pin the metric ("constant curvature", "equal Einstein constant"), so the intended reading is at the level of spaces. (iii) *Is this already booked?* **[graded-half.md:389](../findings/graded-half.md) books it**, "*every factor has **constant curvature**, the criterion the record actually checks, which $\mathbb{RP}^m$ also satisfies, so "is a sphere" is stronger than what is established*", credited to Gate 2 [r501](../reviews/REVIEW_r501.md)/[r502](../reviews/REVIEW_r502.md). So the finding is not new to the record; **it is new to this block, which still carries the refuted clause, and to graded-half's own Theorem 250 lines above the paragraph that refutes it.**

**Impact: none on any value.** The correct clause is "*vanishes exactly when that factor has constant curvature*", and the correct equality case is "*locally isometric to a product of two spherical space forms of equal dimension and equal curvature*".

### 7.5 The quantifier, still one hypothesis short. $W\ne0$ is owed.

**This is the round's principal finding.**

1. **Located**: the Theorem blockquote, "*every compact **Einstein** symmetric space of dimension $n$ satisfies $\theta\le\theta_0(n)$*", in both copies.
2. **Exhibited, in closed form, three witnesses inside the quantifier**:
   - $S^{12}$ round at $\lambda=\tfrac12$. Then $R=cI$ on all of $\Lambda^2$ with $c=\tfrac1{22}$, so $W=R-cI=0$, $\lVert W\rVert=0$, and $\theta=P(W)/\lVert W\rVert^3$ is $0/0$. Under the very formula the Theorem's proof runs on (L46's $\theta=\lambda/\lVert W\rVert$), the value is $+\infty$, which **violates** $\theta\le\theta_0(12)$ rather than merely failing to be defined.
   - $\mathbb{RP}^{12}$, identically.
   - $T^{12}$, the flat torus. $\mathrm{Ric}=0=0\cdot g$, so it is Einstein under the standard definition, compact, symmetric, of dimension $12$; $W=0$; and it additionally fails L46's booked $\lambda\ne0$.
3. **Argued opposite**: (i) *Does "Einstein" exclude these?* No, $S^n$ is Einstein at $\lambda=\tfrac12$ and the record says so explicitly. (ii) *Does L46's $\lambda\ne0$ cover it?* **[problem.md:241](../findings/problem.md) rules that defence out by name**: "*This is not [Lemma L46]'s already-booked $\lambda\ne0$, which $S^n$ satisfies at $\lambda=\tfrac12$*". (iii) *Is $\theta:=0$ a defensible convention at $W=0$?* The record refuses it one block earlier, "***which is why $W\ne0$ is a hypothesis and not a remark***", and L47's statement carries $W\ne0$ explicitly, so L48's Theorem is inconsistent with its own import. (iv) *Is $T^{12}$ really symmetric?* Yes, flat tori are symmetric spaces of Euclidean type, and it is the case H3 exists to exclude, but H3 is stated in graded-half and not in the block, and the **Theorem** states neither.

**So the count "two hypotheses were missing" is itself short by one.** The third is $W\ne0$, and it is the one L47 spends a sentence insisting on.

### 7.6 The two added clauses are implied by the hypotheses, not restrictions on them

Given "Einstein" in the quantifier: a product is Einstein **iff** the factors carry equal constants (§7.2), so "*equal Einstein constant*" in the equality clause is automatic. Given Einstein plus $W_a=0$: constant curvature follows (§7.4), so "*both factors of constant curvature*" is automatic too. **Both added clauses are consequences of the theorem's own hypotheses made explicit, not narrowings of it.** That is a fair and useful edit (it says which object attains the bound) but it is a clarification, and calling it a missing *hypothesis* mislabels what it does.

### 7.7 The odd-$n$ figures, CONFIRMED, and they cross-check against conventions

At $n=13$ the best two-factor split is $\{6,7\}$ (convexity: the most balanced integer split minimises $f(p)+f(q)$ at $p+q=13$). Then

$$\lVert W\rVert^2=f(6)+f(7)-\frac{13}{8\cdot12}=\frac6{40}+\frac7{48}-\frac{13}{96}=\frac{72}{480}+\frac{70}{480}-\frac{65}{480}=\frac{77}{480},$$

$$\theta^2=\frac1{4\lVert W\rVert^2}=\frac{480}{308}=\frac{120}{77}. \qquad\checkmark$$

$$\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}. \qquad\checkmark$$

$\tfrac{120}{77}=1.5584\ldots<\tfrac{264}{169}=1.5621\ldots$, so the split falls **strictly** below, as claimed. **And the value cross-checks against a second, independent formula**: conventions gives $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ at odd $n$, which at $n=13$ is $\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{240}{154}=\tfrac{120}{77}$, **identical**. Two derivations from unrelated closed forms agreeing exactly is the strongest single corroboration in this round.

*And $k=3$ does not compete at $n=13$*: the Jensen floor there is $3f(13/3)-\tfrac{13}{96}$ with $3f(13/3)=\tfrac{39}{80}$, against $\tfrac{142}{480}=\tfrac{71}{240}$ at $k=2$, and $\tfrac{39}{80}>\tfrac{71}{240}$.

## 8. The reduction step, which has no argument on file, GAP

The Theorem quantifies over *every* compact Einstein symmetric space. The proof has exactly two cases: irreducible (L47) and "a product" (this lemma). **Nothing on the block gets from the first phrase to the two cases.** The de Rham decomposition theorem is what does it, together with the observation that $\theta$ depends only on the curvature operator and so descends to quotients, a compact symmetric space need not be a *global* product even when its universal cover is, and $\bigl(S^6\times S^6\bigr)/\Gamma$ for a finite diagonal $\Gamma$ is the standing example.

**The word "de Rham" appears once in the whole of [findings/](../findings/)** (inside L46's parenthetical about the $\lambda=0$ case) and nowhere in either copy of L48. **I do not supply the step.** What is owed, stated exactly:

> Every compact Einstein symmetric space of dimension $n$ is locally isometric to a product $M_1\times\cdots\times M_k$ of irreducible symmetric spaces, each Einstein with the same constant, with $k=1$ the irreducible case; and $\theta$ is an invariant of the curvature operator, hence unchanged under local isometry.

Both halves are standard; neither is written. This is why the finding is `GAP` and not `BROKEN`, the step is true and routine, and its absence is a hole in the record rather than a defect in the mathematics. It also happens to be the step that makes §7.4's $\mathbb{RP}$ witnesses unavoidable, since it is precisely the passage to quotients.

## 9. Traps, answered by name, including the ones where I found nothing

- **$\ker W\ne0$ and padded objects.** *Checked, and the block is clean here.* At a $k\ge2$ product the spectrum of $W$ is $\mathop{\mathrm{spec}}(W_a)+(c_a-c)$ on each $\Lambda^2V_a$ and $-c$ on the mixed block. Since $n_a<n$ gives $c_a>c$, and $c>0$, **$\ker W=0$ at every all-sphere product**, in particular at the maximiser, which is what the consumer at [results.md:567](../results.md) needs for "*$\Delta=0$ certifies equivariance only where $\ker W=0$*". (At a product with a non-sphere factor, $\ker W\ne0$ is possible when an eigenvalue of $W_a$ hits $-(c_a-c)$; that costs the lemma nothing, since such factors only raise $\lVert W\rVert^2$.) **Padded objects are outside the Theorem's quantifier and correctly so**: padded $W_{\mathbb{CP}^2}$ sits at $\theta=\sqrt{3/2}$ at every $n$, but it is not the Weyl tensor of any $n$-dimensional symmetric space, the natural candidate $\mathbb{CP}^2\times T^{n-4}$ is **not Einstein**, so its Weyl part is not the padded tensor. That is the sharpest illustration of §7.1 available, and neither copy makes it.
- **The boundary of every stated range.** $n=12$ checked (§6, margin $\tfrac1{36}$, $n^2-12n+8=8$); $n=11$ checked and fails, so $n\ge12$ is sharp; $k=1$ against $k\ge2$ checked (§5); $m=1$ in $f$, the pole, checked (H4); $m=2,3$ in the sphere criterion checked (§7.4).
- **The smallest admissible dimension.** $n=12$, and at it the balanced split is $(6,6)$ with $\lVert W\rVert^2=\tfrac9{55}$; both factors have $n_a=6\ge5$, consistent with the consumer's $p,q\ge5$.
- **Odd $n$.** The bound survives, the attainment does not, and the block's *paragraph* claims attainment without a parity hypothesis while the *Theorem* below it says "when $n$ is even" (H6). **The paragraph and the Theorem in the same block disagree.** [conventions.md](../findings/conventions.md) records that exactly this gloss ("*the value at the balanced sphere product*"), "***is what regrew [L0]'s refuted constant***", so the paragraph's sentence is an instance of a failure mode the record has already paid for.
- **A claim proven on a subfamily and used in general.** Jensen is proved on real $n_a$ and used on integers, safe, and safe only because the conclusion is a lower bound (§5). L47 is proved by a census over rank $\ge2$ plus $\mathbb{OP}^2$ plus two rank-one closed forms and used for all irreducible spaces; its own owed step travels here (§10).
- **A hypothesis stated but never used.** *Looked; found none.* "Compact" is used through L47 (whose census is over compact spaces) and to force $\lambda\ge0$; "$n\ge12$" is used in §6 alone and is not idle; "Einstein" is used twice (§7.1).
- **A step using a hypothesis never stated.** *Found seven*, H2 through H8 of §1. H2 is the one that makes a displayed identity false without it.
- **A universal claim with no witness.** *Looked; found none.* The equality case has a witness at every even $n\ge12$ ($S^{n/2}\times S^{n/2}$), and the odd-$n$ strictness claim carries the explicit $n=13$ witness, which I reproduced.
- **An imported theorem whose hypotheses were never checked, [L46](../findings/problem.md), carrying four.** *Locally symmetric*: discharged, a product of symmetric spaces is symmetric. *Einstein*: discharged by the Theorem's own hypothesis. *$\lambda\ne0$*: discharged for compact non-flat, **undischarged for $T^{12}$**, which the quantifier admits. *$W\ne0$*: **undischarged**, §7.5. **So one of L46's four hypotheses is not checked against the object, and a second fails on a member of the quantifier.** This is the same shape as the unital-algebra import the brief names.
- **Symbol collisions.**
  - **$B$.** L48's $B$ is a **scalar depending on a partition**. [conventions.md](../findings/conventions.md) already books three objects under the letter plus a fourth in L47's working-symbol row; **this is a fifth, and it is tabled nowhere.** It sits in the same file as L47's $B$, six lines apart in [problem.md](../findings/problem.md).
  - **$f$.** Defined three times on the record, [problem.md:256](../findings/problem.md), [graded-half.md:381](../findings/graded-half.md), [results.md:567](../results.md), and tabled in conventions **zero** times, against that file's own rule that "*definitions and conventions are quoted, never restated*". The three copies agree today.
  - **$c$.** L48's derivation consumes L46's $c=\lambda/(n-1)$ without naming it, in a file where conventions already flags that "*$c$ collides with [L44](../findings/problem.md)'s pinned $\partial\Omega_0$ constant*". A reader resolving $c$ against L44's $\tfrac1n\sqrt{2(n-2)/(n-1)}$ gets a different $B$.
  - **$k$.** The factor count. No live collision found on the record.
  - **$\theta_0$ against $\Theta_n$ against $\tilde\theta_0$.** The block writes $\theta_0(n)$ and means it (the closed form) and at odd $n$ correctly reports a value **below** it. Conventions' warning is respected here. *This is the one place the block is more careful than its neighbours.*
- **Two copies of one argument.** [graded-half.md](../findings/graded-half.md) carries the argument in full, and the canonical block says it was moved to [problem.md](../findings/problem.md) "*where the argument was the only copy*". It is not the only copy. The two differ on H2 (graded-half states the Einstein normalisation; problem.md does not) and on the location of the odd-$n$ sentence. **The record's own stated reason for the quote-don't-restate rule ("*a convention restated in two files is a convention that will disagree with itself*"), has already come true here.**

## 10. The repair's own summary

> **TWO HYPOTHESES WERE MISSING, AND NEITHER CHANGES A VALUE.**

**Not a fair description, on three counts.**

- **The count is wrong.** Three things changed at that repair, the quantifier narrowed to Einstein, the equality clause gained "round factors of equal Einstein constant", and the equality clause gained "when $n$ is even". And a fourth is **still** missing: $W\ne0$ (§7.5).
- **One of the "two" is not a hypothesis.** The equality-clause additions are consequences of the theorem's own hypotheses made explicit (§7.6). A clarification of which object attains a bound is a different act from restricting the class the bound is asserted over.
- **"Neither changes a value" is true and beside the point.** No number moved: $\theta_0(n)$, $\tfrac{n^2}{8(n-1)(n-2)}$, $n^2-12n+8$, $\tfrac{120}{77}$ and $\tfrac{264}{169}$ all survive this round intact, and I confirmed each. But **adding a hypothesis narrows a claim**: the Theorem now asserts nothing whatever about non-Einstein compact symmetric spaces of dimension $n\ge12$, a class the earlier statement covered and the conjecture cares about. Reporting the repair by what did *not* move understates what did.

**And the narrowing did not travel.** The consumer at [results.md:567](../results.md) still reads "*the Weyl operator of a compact symmetric space*" with no Einstein clause, and invokes L48 for "*reducible ones*" without it. [graded-half.md:381](../findings/graded-half.md) records the gap precisely, "***The conversion consumes $\theta=1/(2\lVert W\rVert)$ and [Lemma L48]'s decomposition, whose Einstein hypothesis is load-bearing and was dropped in transit**, harmless at $k=2$ … and **undischarged at $k\ge3$***", **and that caveat is absent from the canonical entry in [results.md](../results.md).** The findings file knows; the canon does not.

**Inherited debt, named rather than repaired.** L47 supplies the $\tfrac16$ that the whole meeting rests on, and [results.md:539](../results.md) records that its equality case holds "***modulo the monotonicity of the two rank-one closed forms on $m\ge2$, which is owed**: the record establishes their minima on a five-point scan*". The Theorem's irreducible half inherits that debt. It does not touch the *bound* $\tfrac16$ at $\mathbb{CP}^2$, only the claim that no other rank-one space reaches it.

## 11. What would falsify each, they are different objects

**The lemma**, the decomposition, $B$, Jensen, the threshold equivalence. It would be falsified by:

- a Riemannian product whose $R$ couples two $\Lambda^2V_a$ blocks, or is nonzero on a mixed pair;
- a product of equal-$\lambda$ Einstein factors with $\lVert W\rVert^2\ne\sum_a\lVert W_a\rVert^2+B$;
- a partition with $\sum_af(n_a)<k\,f(n/k)$, or a $k'>k\ge2$ with $k'f(n/k')<k\,f(n/k)$;
- an $n\ge3$ at which $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}$ and $n^2-12n+8<0$, or the converse.

*What I did to look.* Derived the decomposition from the product connection rather than accepting it (§2); derived $B$ twice by unrelated routes (the record's centring identity applied factorwise, and a cold block-by-block expansion) and checked that $\sum_an_a^2$ cancels in the second (§3); differentiated $f$ twice and checked the sign of $f''$ on the whole admissible range $m>1$ (§5); derived $k\,f(n/k)$ in closed form and differentiated in $k$ (§5); cleared the threshold equivalence in both directions by multiplication by a quantity positive on the range (§6); evaluated the boundary at $n=11$ and $n=12$, the degenerate case $k=1$, and the pole at $m=1$; and cross-checked the $f$-formula against the consumer's independent form $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13$ and against its $p=5$ reduction $n^2-7n-54\ge0$, both of which reproduce from $B$ exactly. **Nothing broke.**

**The Theorem**, a universally quantified statement about spaces. It would be falsified by:

- a compact Einstein symmetric space of dimension $n\ge12$ with $W\ne0$ and $\theta>\theta_0(n)$;
- a second space attaining $\theta=\theta_0(n)$ that is not a product of two round $n/2$-spheres, **and one exists**, $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$, which falsifies the equality clause as written (§7.4);
- a member of the quantifier on which the conclusion is not even well formed, **and three exist**, $S^{12}$, $\mathbb{RP}^{12}$, $T^{12}$ (§7.5);
- an odd $n\ge13$ at which some split reaches $\theta_0(n)$.

*What I did to look.* Enumerated the quantifier against the record's own inventory of compact symmetric spaces with $W=0$ ([problem.md:241](../findings/problem.md)) and found three members the Theorem does not exclude; tested the equality clause against the spherical space forms, using the record's own $\mathbb{RP}^n$ entry and its own Gate 2 note at [graded-half.md:389](../findings/graded-half.md); checked each of L46's four hypotheses against the objects the Theorem quantifies over; reconstructed the odd-$n$ figures at $n=13$ from $f$ and cross-checked them against conventions' independent $\Theta_n$ formula, where they agree exactly; and traced the case split back to look for the de Rham step, finding the phrase once in [findings/](../findings/) and in neither copy of the lemma. **The value $\theta_0(n)$ and the inequality survived every attack; the quantifier and the equality case did not.**

**A falsifier I could not chase, stated as unfinished.** Whether the *Einstein-free* Theorem is false, whether some non-Einstein compact symmetric space of dimension $n\ge12$ carries $\theta>\theta_0(n)$, is open on this record. Settling it needs the Weyl part of an unequal-radius sphere product in closed form, which nothing on file computes, and I did not compute it: **this loop does no numerical work, and no closed-form derivation of it exists to check.** It is a derivation someone is owed, not a computation.

## Verdicts

- **The lemma (decomposition, closed form, Jensen, the threshold meeting): `PROVEN, hypotheses corrected`.** Every displayed identity verified, twice where a second route existed. The corrected hypothesis list is H1–H7 of §1; the clause "*vanishes exactly when that factor is a sphere*" must read "*has constant curvature*"; and "*the reducible minimum sits at $S^{n/2}\times S^{n/2}$*" must carry $n$ even, or be stated as the bound it is at odd $n$. **No value changes.**
- **The Theorem: `HYPOTHESIS-DEBT`.** $W\ne0$ is owed and its absence admits $S^{12}$, $\mathbb{RP}^{12}$ and $T^{12}$ into a statement whose conclusion is $0/0$ on them and $+\infty$ under its own proof's formula. The equality clause is owed the $\mathbb{RP}$ correction, which the record already holds in a different file. The reduction step of §8 is owed an argument, which is `GAP` in isolation.
- **The repair's summary: `REFUTED as a description`**, per §10. The values it defends are all intact; the account of what changed is not.
