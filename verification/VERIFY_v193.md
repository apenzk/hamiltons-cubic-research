# VERIFY_v193, L48 (the reducible case, and the symmetric-space theorem)

Verifier v193, cold read of [BRIEF_L48.md](BRIEF_L48.md). **No numerical work was done**, no script, no Sage, no Python, no numeric evaluation. Every figure below is closed-form rational arithmetic on objects constructed for the purpose, reported as a screen. The programme's analysis-only rule was in force throughout. Log: [agent_logs/verify-L48-v193.log](../agent_logs/verify-L48-v193.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | For a product, $R$ is block-diagonal on $\Lambda^2$ and zero on the mixed terms | **PROVEN** |
| 1b | The same is *not* true of $W$; the mixed blocks of $W$ carry $-c\,\mathrm{Id}$ and are part of $B$ | **CORRECT AS WRITTEN, MISLEADABLE**, the block says "$R$", and is right |
| 2 | $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, $B=\sum_af(n_a)-\tfrac n{8(n-1)}$, $f(m)=\tfrac m{8(m-1)}$ | **PROVEN**, derived twice, independently |
| 3 | $B$ depends on the partition alone | **HYPOTHESIS-DEBT**, true only at $\mathrm{Ric}=\tfrac12g$; false without Einstein, and the block states neither |
| 3b | $n$ in $\tfrac n{8(n-1)}$ is $\sum_an_a$, never an ambient dimension | **GAP**, never stated in the canonical block; the record has already paid for this omission once |
| 4 | $f$ decreasing and convex | **PROVEN**, $f'=-\tfrac1{8(m-1)^2}$, $f''=\tfrac1{4(m-1)^3}$ |
| 4b | Jensen's direction and constraint | **PROVEN**, convexity, $\sum n_a=n$, $k$ fixed, gives a *minimum* at the balanced point; "decreasing" is stated and never used |
| 5 | $k\,f(n/k)=\tfrac{kn}{8(n-k)}$, increasing in $k$ | **PROVEN**, derivative $\tfrac{n^2}{8(n-k)^2}>0$ |
| 5b | The range of $k$ is $k\ge2$ | **GAP**, unstated; $k=1$ is in the formula's domain and gives the strictly smaller $B=0$ |
| 6 | $\lVert W_a\rVert^2\ge0$, vanishing exactly when the factor is a sphere | **HYPOTHESIS-DEBT**, "$\Rightarrow$" needs Einstein with $\lambda>0$; and it yields constant curvature, not $S^{n_a}$ |
| 7 | The reducible minimum is $\tfrac{n^2}{8(n-1)(n-2)}=\tfrac1{4\theta_0(n)^2}$ | **PROVEN at even $n$**, the lemma paragraph omits "even", which the Theorem supplies |
| 8 | $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$ | **PROVEN**, and the threshold $6+2\sqrt7$ is genuinely recovered |
| 9 | **Theorem**, quantifier: every compact Einstein symmetric space, $n\ge12$ | **HYPOTHESIS-DEBT**, still too wide: $W\ne0$ is missing, and $S^{12}$ and $T^{12}$ are instances where $\theta$ is $0/0$ |
| 10 | **Theorem**, Einstein is load-bearing | **PROVEN**, and load-bearing in three separate places, of which the repair note names one |
| 11 | **Theorem**, equality exactly at $S^{n/2}\times S^{n/2}$, round, equal constant, $n$ even | **HYPOTHESIS-DEBT**, $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ attains it and is excluded by the wording |
| 12 | Odd $n$: $\theta^2=\tfrac{120}{77}$ against $\theta_0^2=\tfrac{264}{169}$ at $n=13$ | **PROVEN**, both rederived exactly, and $\tfrac{120}{77}$ reproduces [conventions.md](../findings/conventions.md)'s $\Theta_n$ |
| 13 | The repair summary, "two hypotheses were missing, and neither changes a value" | **UNFAIR AS A DESCRIPTION**, the count is short by one and the sentence hides that the theorem was narrowed |
| 14 | L46's four hypotheses checked against L48's object | **GAP**, two of the four ($\lambda\ne0$, $\lambda=\tfrac12$ at a *product*) are never checked in the canonical block |
| 15 | Consumer chain: [results.md](../results.md) line 294, "$\theta\le\theta_0(n)$ becomes the single inequality $\lVert W\rVert^2\ge\tfrac16$ (the form Lemmas 47 and 48 verify" | **BROKEN**), refuted in closed form by L48's own extremiser |
| 16 | Symbol hygiene: $B$, $f$, $k$, $c$ | **GAP**, L48's $B$ is a fourth live object under that letter and is untabled; $f$ crosses three files untabled |

**Summary in one line.** Every number in the block is right and I rederived each of them two ways, but the canonical block is a lossy abridgement of the correct argument in [graded-half.md](../findings/graded-half.md), it drops the Einstein normalisation that makes "partition alone" true, drops $n=\sum_an_a$, drops $k\ge2$, weakens "constant curvature" to "sphere", and the Theorem it carries still omits $W\ne0$; verdict `HYPOTHESIS-DEBT`, with one `BROKEN` sentence found in the import's canonical entry.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$, the gap being $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$ from the identity $(n-2)^2(n+1)-n^2(n-3)=4$.*"
- $\Theta_n$: "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $R_I$, $R_{\mathrm{ric}_0}$, $R_W$: "the three $O(n)$-irreducible pieces of an algebraic curvature operator, scalar, **trace-free** Ricci, and Weyl. $R_{\mathrm{ric}_0}=0$ makes a slice **Einstein**".
- $B$: "$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point ... *This is a third object under the letter $B$ in this record*". And separately: "**THE LETTER $B$ MEANS TWO THINGS, live.** [conventions.md]'s Killing form above is $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)$; [sym3-blocks.md](../findings/sym3-blocks.md) writes $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$".
- $N$: "$\binom n2=\dim\Lambda^2\mathbb R^n$".
- The normalisation L48 silently runs in is quoted from [L47](../findings/problem.md): "Normalising to Einstein constant $\tfrac12$ forces $\mathop{\mathrm{tr}}R=n/4$, makes the centre constant universal at $c=\frac1{2(n-1)}$, and gives $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$."

## 1. Hypothesis inventory

Split by object, because the brief is right that these are two different things.

**The lemma (the closed form and the minimisation), as the canonical block states it.**

| # | hypothesis | stated in the block? | used? | where it bites |
| --- | --- | --- | --- | --- |
| H1 | the metric is a Riemannian product (equivalently, reducible holonomy) | yes, "for a product" | yes | claim 1 |
| H2 | the space is **Einstein**, $\mathrm{Ric}=\lambda g$ | **no**, the word appears only inside the Theorem's blockquote | yes, three times | claims 3, 6, and the factorwise identity |
| H3 | the normalisation $\lambda=\tfrac12$ | **no** | yes | every figure: $f$, $B$, $\tfrac16$, $\tfrac{n^2}{8(n-1)(n-2)}$ |
| H4 | $n=\sum_an_a$ (no ambient padding) | **no** | yes | the $-\tfrac n{8(n-1)}$ term |
| H5 | $k\ge2$ | **no** | yes | the "increasing in $k$" step |
| H6 | each $n_a\ge2$ | **no** | yes | $f(1)$ is a pole |
| H7 | $n$ even, for the equality clause | **no** in the lemma paragraph; **yes** in the Theorem | yes | claim 7 |
| H8 | $W\ne0$ | **no** | yes | $\theta$ is $0/0$ otherwise |

**The Theorem, as the blockquote states it.** H1 is replaced by "symmetric" and is not a hypothesis but a dichotomy; H2 is present; H3 is absorbed because $\theta$ is scale-invariant and any Einstein metric can be rescaled to $\lambda=\tfrac12$; H4 is vacuous because the object is a manifold, not an element of $\mathcal W_n$; H5 and H6 follow from de Rham plus H2; H7 is present; **H8 is still absent.**

**Imported hypotheses.** [L46](../findings/problem.md) is consumed, and the record itself lists its hypotheses at [graded-half.md](../findings/graded-half.md) line 69: "*locally symmetric, Einstein, $\lambda\ne0$, $\lambda=\tfrac12$*, **stated for irreducible symmetric spaces, while these objects are products**". Section 9 below discharges each against L48's object and records which two the canonical block never checks. [L47](../findings/problem.md) is consumed for the irreducible half and carries its own two undischarged debts, which L48's Theorem inherits (section 8).

## 2. Claim 1, the decomposition, and what it needs

**What is claimed.** "For a product, $R$ is block-diagonal on $\Lambda^2$ and **zero on the mixed terms**".

**Derivation.** Let $M=M_1\times\cdots\times M_k$ with the product metric, $T_pM=\bigoplus_aV_a$. Then $\Lambda^2T_pM=\bigoplus_a\Lambda^2V_a\oplus\bigoplus_{a<b}V_a\otimes V_b$. The Levi-Civita connection of a product is the direct sum of the factor connections, so $R(X,Y)Z=0$ whenever $X,Y,Z$ do not all lie in one factor, and $R(X,Y,Z,T)$ vanishes unless all four arguments lie in the same $V_a$. Reading $R$ as a symmetric operator on $\Lambda^2$, this says exactly: $R|_{\Lambda^2V_a}=R_a$, $R|_{V_a\otimes V_b}=0$, and every off-block matrix entry is zero. **Verdict: PROVEN.**

**What it needs.** Only that the metric is a local Riemannian product. Curvature is local, so de Rham reducibility suffices and global splitting is not required, which matters, because a compact symmetric space with reducible holonomy need not be a global product (a diagonal quotient of $S^6\times S^6$ is not). The block says "for a product"; the object the Theorem quantifies over is a manifold that may only be *locally* a product. The lemma survives because $\theta$ is a pointwise algebraic invariant of the curvature operator, but the canonical block never says so.

**Claim 1b, the trap the sentence sets.** The vanishing is a fact about $R$, and the block correctly says $R$. It is **not** true of $W$. With $c=\lambda/(n-1)$,

$$W|_{\Lambda^2V_a}=W_a+\Big(\tfrac\lambda{n_a-1}-\tfrac\lambda{n-1}\Big)\mathrm{Id}_a,\qquad W|_{V_a\otimes V_b}=-\tfrac\lambda{n-1}\mathrm{Id}_{ab}\ne0 .$$

So $W$'s mixed blocks are nonzero, and they are precisely part of what $B$ collects. The word "so" joining the two halves of the block's first sentence hides a step: from "$R$'s mixed block is zero" one gets $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$, and only then does the normalised identity convert that into the $W$ statement. [graded-half.md](../findings/graded-half.md) line 128 spells this out, "so $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$. Applying the universal-$c$ identity factorwise", and the canonical block dropped both sentences. **Verdict: correct as written, and the abridgement is where the argument was lost.**

## 3. Claim 2, the closed form, derived twice

**Route A, from $\lVert R\rVert^2$ (the record's own route, reconstructed).** With $\lambda=\tfrac12$, [L47](../findings/problem.md) gives $\mathop{\mathrm{tr}}R=n/4$, $c=\tfrac1{2(n-1)}$ and

$$\lVert W\rVert^2=\lVert R-cI\rVert^2=\lVert R\rVert^2-2c\mathop{\mathrm{tr}}R+c^2N=\lVert R\rVert^2-\tfrac n{4(n-1)}+\tfrac{n}{8(n-1)}=\lVert R\rVert^2-\tfrac n{8(n-1)} ,$$

using $N=\binom n2$. The same identity read inside factor $a$ (legitimate exactly because the factor is itself Einstein at the *same* constant $\tfrac12$), gives $\lVert R_a\rVert^2=\lVert W_a\rVert^2+f(n_a)$ with $f(m)=\tfrac m{8(m-1)}$. Claim 1 gives $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$. Substituting,

$$\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-\tfrac n{8(n-1)} .$$

**Route B, from the Weyl decomposition, sharing nothing with Route A.** For Einstein metrics $R=W+\tfrac{s}{n(n-1)}\mathrm{Id}$ with $s=n\lambda$, so on the blocks $W$ is as displayed in section 2. Since $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$, the cross terms $\langle W_a,\mathrm{Id}_a\rangle$ vanish and the blocks are orthogonal, so with $c_a=\lambda\big(\tfrac1{n_a-1}-\tfrac1{n-1}\big)$ and $D=\sum_{a<b}n_an_b=\tfrac{n^2-\sum n_a^2}2$,

$$\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\sum_ac_a^2\binom{n_a}2+\frac{\lambda^2D}{(n-1)^2}.$$

Expanding $c_a^2\binom{n_a}2=\lambda^2\big[\tfrac{n_a}{2(n_a-1)}-\tfrac{n_a}{n-1}+\tfrac{n_a(n_a-1)}{2(n-1)^2}\big]$ and summing,

$$B=\lambda^2\Big[\sum_a\tfrac{n_a}{2(n_a-1)}-\tfrac n{n-1}+\tfrac{\sum n_a^2-n}{2(n-1)^2}+\tfrac{n^2-\sum n_a^2}{2(n-1)^2}\Big]=\lambda^2\Big[\sum_a\tfrac{n_a}{2(n_a-1)}-\tfrac n{2(n-1)}\Big],$$

the $\sum n_a^2$ terms cancelling exactly. **The two routes agree iff $\lambda^2/2=1/8$, i.e. $\lambda=\tfrac12$.** So the block's formula is the general one specialised to the Petersen–Stanfield normalisation, and in no other. **Verdict: PROVEN, at $\lambda=\tfrac12$.**

**Claim 3, "depending on the partition alone", HYPOTHESIS-DEBT.** Route B exhibits the dependence the phrase denies: $B=\lambda^2\big[\cdots\big]$, so $B$ depends on the partition *and on $\lambda^2$*, and $\lVert W\rVert^2$ is not scale-invariant. Two things must be fixed before "partition alone" is true, and the canonical block states neither:

1. **Einstein.** Route B assumed every factor Einstein at a common $\lambda$; otherwise $R_{\mathrm{ric}_0}\ne0$ and neither the block decomposition of $W$ above nor the factorwise identity of Route A holds. $B$ then genuinely depends on the individual $\lambda_a$.
2. **The normalisation $\lambda=\tfrac12$.** Given Einstein, this is available by rescaling and is therefore harmless, but it is a *choice*, and every figure in the block is wrong in any other. The record holds it, at [L46](../findings/problem.md) ("In Petersen–Stanfield's normalisation, where $\lambda=\tfrac12$") and at [L47](../findings/problem.md) ("Normalising to Einstein constant $\tfrac12$"). [conventions.md](../findings/conventions.md)'s standing rule is that "definitions and conventions are quoted, never restated"; L48 neither quotes nor restates it.

The [graded-half.md](../findings/graded-half.md) copy repairs point 1 in one sentence, "The Einstein normalisation forces every factor of a product to be Einstein with the same constant $\tfrac12$, so no flat factors occur", which is correct (restriction of $\mathrm{Ric}=\tfrac12g$ to a factor is $\mathrm{Ric}_a=\tfrac12g_a$, and a flat factor has $\lambda=0$). **That sentence is the load-bearing one, and it is absent from the canonical block.**

**Claim 3b, the meaning of $n$, GAP.** The canonical block never says that $n=\sum_an_a$. [graded-half.md](../findings/graded-half.md) line 65 states it in bold and records what its omission costs: "**The dimension must be the sum of the blocks and not the ambient one.** *Read at a padded copy the identity is false, $(S^3)^3$ padded into $\mathbb R^{12}$ returns $\tfrac{27}{64}$ against $\tfrac{75}{176}$*". Screening that pair: at $k=3$, $n_a=3$, the identity reads $B=\tfrac{k-1}8+\tfrac18\big(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big)$, giving $\tfrac28+\tfrac18(\tfrac32-\tfrac18)=\tfrac{27}{64}$ at the true $n=9$ and $\tfrac28+\tfrac18(\tfrac32-\tfrac1{11})=\tfrac{75}{176}$ at the ambient $n=12$. Padding preserves $\theta$, so $\tfrac{27}{64}$ is the correct value and the ambient reading is the error. **This is the brief's padded-object trap, and the canonical block is the copy that omits the guard.**

## 4. Claims 4, 4b, 5, 5b, Jensen, and the direction it is used in

**$f$ is decreasing and convex.** $f(m)=\tfrac m{8(m-1)}=\tfrac18+\tfrac1{8(m-1)}$ on $m>1$, so $f'(m)=-\tfrac1{8(m-1)^2}<0$ and $f''(m)=\tfrac1{4(m-1)^3}>0$. Both hold on the whole admissible range $m\ge2$. **PROVEN.**

**The direction Jensen is used in, and the constraint.** The brief asks this explicitly. For $f$ convex on $(1,\infty)$ and $n_1,\dots,n_k$ with $\sum_an_a=n$ and $k$ **fixed**, Jensen gives

$$\tfrac1k\sum_af(n_a)\ \ge\ f\big(\tfrac1k\sum_an_a\big)=f(n/k),\qquad\text{i.e.}\qquad \sum_af(n_a)\ \ge\ k\,f(n/k).$$

So convexity gives a **minimum** of $\sum f$ at the balanced point, under the constraint "sum fixed, number of terms fixed". The block says "for fixed $k$", which is the right constraint. The direction is the one the lemma needs, because $\theta=\lambda/\lVert W\rVert$ **inverts the ordering**: minimising $\lVert W\rVert^2$ is maximising $\theta$. The block never says this inversion out loud either, but it uses it correctly. **PROVEN.**

Two riders:

- **"Decreasing" is stated and never used.** Jensen consumes convexity alone; the $k$-comparison is done by direct differentiation. This is the brief's "hypothesis stated but never used", harmless, but it is there.
- **Integrality.** Jensen is applied over the reals while the $n_a$ are integers. As a **lower bound** this is sound at every $n$ and is exactly what the Theorem needs. As an **attainment** claim it needs $k\mid n$, which for $k=2$ is $n$ even. The lemma paragraph asserts attainment ("the reducible minimum sits at $S^{n/2}\times S^{n/2}$, where $\lVert W\rVert^2=\ldots$") without the parity condition; only the Theorem's blockquote supplies "when $n$ is even".

**The $k$-monotonicity.** $f(n/k)=\dfrac{n/k}{8(n/k-1)}=\dfrac n{8(n-k)}$, so $k\,f(n/k)=\dfrac{kn}{8(n-k)}$, as claimed. Differentiating in $k$ on $0<k<n$: $\dfrac{d}{dk}\dfrac{kn}{8(n-k)}=\dfrac{n(n-k)+kn}{8(n-k)^2}=\dfrac{n^2}{8(n-k)^2}>0$. **PROVEN, increasing.** Since the $-\tfrac n{8(n-1)}$ term carries no $k$, $B$ inherits the monotonicity, and the minimum over $k$ sits at the smallest admissible $k$.

**Claim 5b, $k=1$ against $k\ge2$, GAP.** The smallest admissible $k$ is not stated. $k=1$ lies in the domain of every formula in the block and gives $1\cdot f(n)=\tfrac n{8(n-1)}$, hence $B=0$, **strictly smaller than the value at $k=2$**, and the "increasing in $k$" step therefore selects $k=1$ unless the range is restricted. $k=1$ is the irreducible case, where $\lVert W\rVert^2=\lVert W_1\rVert^2$ and [L47](../findings/problem.md) takes over. The block's phrase "the reducible minimum" carries the restriction by implication only. Combined with claim 5, what is actually proved is: for every $k\ge2$, $B\ge\tfrac{2n}{8(n-2)}-\tfrac n{8(n-1)}$, and

$$\frac{2n}{8(n-2)}-\frac n{8(n-1)}=\frac n8\cdot\frac{2(n-1)-(n-2)}{(n-1)(n-2)}=\frac n8\cdot\frac n{(n-1)(n-2)}=\frac{n^2}{8(n-1)(n-2)},$$

which is the block's stated value. **The arithmetic is right; the range is unstated.**

## 5. Claim 6, $\lVert W_a\rVert^2\ge0$ vanishing exactly at a sphere, both directions

$\lVert W_a\rVert^2\ge0$ is a norm and needs no argument. The biconditional does.

**($\Leftarrow$) Constant curvature $\Rightarrow W_a=0$.** For $R_a=\kappa\,\mathrm{Id}$ on $\Lambda^2V_a$ the trace-free Ricci part vanishes and $\tfrac{s_a}{n_a(n_a-1)}=\kappa$, so $R_a$ is entirely scalar and $W_a=0$. **Holds unconditionally.**

**($\Rightarrow$) $W_a=0\Rightarrow$ constant curvature.** From $R_a=W_a+\tfrac2{n_a-2}(\mathrm{ric}_0\owedge\mathrm{id})+\tfrac{s_a}{n_a(n_a-1)}\mathrm{Id}$, Einstein kills the middle term and $W_a=0$ leaves $R_a=\tfrac{s_a}{n_a(n_a-1)}\mathrm{Id}$, constant sectional curvature. **This direction needs Einstein, and it needs $\lambda>0$ to exclude the flat case.** Without Einstein it is false at every $n_a\le3$, where $W_a$ vanishes identically; and the counterexample is not exotic, it is a symmetric space: $S^{10}\times T^2$ is a compact symmetric space of dimension $12$ whose $T^2$ factor has $W_a=0$ and is not a sphere. Under the Theorem's Einstein hypothesis at $\lambda=\tfrac12$ this is excluded (a flat factor forces $\lambda=0$) and the small dimensions are safe too: $n_a=1$ has $\lambda=0$ and is excluded; $n_a=2$ with $\mathrm{Ric}=\tfrac12g$ has $K=\tfrac12$; $n_a=3$ Einstein is constant curvature. So the biconditional is **true under H2 and false under the block's stated hypotheses**, which is claim 6's verdict.

**And the conclusion is "constant curvature", not "sphere".** $\mathbb{RP}^{n_a}$ and every spherical space form have $W_a=0$. [graded-half.md](../findings/graded-half.md) line 132 says "vanishes exactly when that factor **has constant curvature**, i.e. is a sphere"; the canonical block kept only the second half. The precise half is the one that was dropped. This is the same degradation as in section 2, and it is what powers the equality-case discrepancy in section 7.

**Boundary check on $f$.** $f$ has a pole at $m=1$. A circle factor ($S^{11}\times S^1$ at $n=12$, a compact symmetric space), sends $B$ to $+\infty$. It is excluded by Einstein and by nothing else in the block. The consumer at [results.md](../results.md) line 567 says the condition "fails outright at $p\le4$ for every $n$"; screening $p=4$: $\tfrac13+\tfrac1{n-5}-\tfrac1{n-1}>\tfrac13$ since $\tfrac1{n-5}>\tfrac1{n-1}$, and $p\le3$ gives $\tfrac1{p-1}\ge\tfrac12>\tfrac13$ already. **$p=1$ is covered by the pole, not by the inequality**, and the consumer's "for every $n$" reads over it.

## 6. Claims 7 and 8, the value, and the meeting with no gap

**The value.** At $k=2$, $p=q=n/2$, both factors of constant curvature, $\lVert W_a\rVert^2=0$ and

$$\lVert W\rVert^2=B=2f(n/2)-\tfrac n{8(n-1)}=\tfrac18\Big(1+\tfrac4{n-2}-\tfrac1{n-1}\Big)=\tfrac18\cdot\frac{(n-1)(n-2)+4(n-1)-(n-2)}{(n-1)(n-2)}=\frac{n^2}{8(n-1)(n-2)} .$$

**And $\tfrac1{4\theta_0(n)^2}$ is the same number**, from conventions' $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$: $\tfrac1{4\theta_0^2}=\tfrac{n^2}{8(n-1)(n-2)}$. **PROVEN**, and this pins H3: the identification $\lVert W\rVert^2=\tfrac1{4\theta_0^2}$ is *equivalent* to $\lambda=\tfrac12$, since L46 gives $\theta=\lambda/\lVert W\rVert$ and hence $\lVert W\rVert^2=\lambda^2/\theta^2$. The block's own displayed equality is therefore the place where the unstated normalisation becomes visible.

**Screen at the witness.** $n=12$: $2f(6)-\tfrac{12}{88}=\tfrac3{10}-\tfrac3{22}=\tfrac{33-15}{110}=\tfrac9{55}$, and $\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{55}{36}$, with $\tfrac{1/4}{9/55}=\tfrac{55}{36}$. ✓ This agrees with [conventions.md](../findings/conventions.md)'s independent line "at $n=12$ the three squares are $\tfrac{99}{65}<\tfrac{55}{36}<\tfrac{220}{117}$". **The universal claim has a witness.**

**The equivalence.** For $n\ge3$, $(n-1)(n-2)>0$, so multiplying $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}$ by $24(n-1)(n-2)$ preserves the sense:

$$4(n-1)(n-2)\ \ge\ 3n^2\iff 4n^2-12n+8\ge3n^2\iff n^2-12n+8\ge0 .$$

Both directions are the same chain of reversible steps, so it is an equivalence. **PROVEN.** Roots $6\pm2\sqrt7$; $2\sqrt7\in(5.29,5.30)$ since $27.99<28<28.09$, so the positive root is in $(11.29,11.30)$ and the least admissible integer is $n=12$. **The threshold polynomial is genuinely recovered**, not assumed: it enters as the comparison of two separately derived quantities, $\tfrac16$ from [L47](../findings/problem.md)'s irreducible bound and $\tfrac{n^2}{8(n-1)(n-2)}$ from this lemma. That it is the *same* polynomial as $\theta_0(n)=\sqrt{3/2}$ is not a coincidence but an identity ($\lVert W\rVert^2=\tfrac1{4\theta^2}$ maps each inequality to the other) so "recovered rather than assumed" is fair, provided a reader does not take it as an *independent* confirmation. It is one statement read at two normalisations.

**One thing the argument does not cover.** The displayed equivalence compares $\tfrac16$ with $\theta_0(n)$'s value, which is the reducible optimum only at even $n$. At odd $n$ the reducible branch tops out at $\Theta_n$, and whether the branches still meet is the separate question $\Theta_n^2\ge\tfrac32$, i.e. (screening) $4(n-1)(n-3)\ge3(n+1)(n-2)$, i.e. $n^2-13n+18\ge0$, root $\tfrac{13+\sqrt{97}}2\in(11.4,11.5)$, satisfied at every odd $n\ge13$. **The conclusion survives; the argument on file establishes it only at even $n$.** I record this as an observation, not a discrepancy: the Theorem needs only the $\ge$ direction of the real relaxation, which holds at every parity.

## 7. The Theorem, checked separately

> **Theorem.** For every $n\ge12$, every compact **Einstein** symmetric space of dimension $n$ satisfies $\theta\le\theta_0(n)$, with equality exactly at $S^{n/2}\times S^{n/2}$ **with both factors of constant curvature and equal Einstein constant**, when $n$ is even.

**Is Einstein load-bearing? Yes, in three places, of which the repair note names one.**

1. **L46's identity.** $Q(W)=\lambda W$ requires $\mathrm{Ric}=\lambda g$. This is the note's reason, and it is correct.
2. **The closed form itself.** Section 3 Route B: without a common $\lambda$, $B$ is not a function of the partition and the whole minimisation has no object. The note does not say this.
3. **The sphere characterisation.** Section 5: the "$\Rightarrow$" direction fails without Einstein, at $S^{10}\times T^2$ among others. The note does not say this either.

**Is a reducible symmetric space with unequal factor Einstein constants non-Einstein?** Yes. Every de Rham factor of a symmetric space is itself symmetric, and an irreducible symmetric space is isotropy-irreducible hence Einstein; a flat factor is Einstein at $\lambda=0$. For $M=M_1\times M_2$ with $\mathrm{Ric}_a=\lambda_ag_a$, $\mathrm{Ric}=\lambda_1g_1\oplus\lambda_2g_2$, which is $\lambda g$ iff $\lambda_1=\lambda_2$. **The note's sentence is correct**, and its careful phrasing ("*the formula never applied to it*"), is honest: it says the old claim was *unsupported* on those spaces, not that it was false there. Nothing on file exhibits a non-Einstein compact symmetric space violating the old bound, and I did not look for one, since that would require computing $P(W)$ at a non-critical $W$ with no identity available.

**Does "sphere" alone fix the metric? No, and the repair is right to add roundness, but it is still not exact.** Two levels are conflated in the repaired sentence. "Compact Einstein symmetric space" is a manifold-level hypothesis; "$\theta$" is a pointwise algebraic invariant of the curvature operator. No manifold-level "exactly" can be right, because the equality set is closed under passing to quotients and covers.

**DISCREPANCY 1, the equality clause is still not exact.** *Located:* [problem.md](../findings/problem.md) line 260, "with equality exactly at $S^{n/2}\times S^{n/2}$". *Exhibited in closed form:* take $n=12$ and $M=\mathbb{RP}^6\times\mathbb{RP}^6$, each factor of constant curvature $\kappa=\tfrac1{10}$ so that $\mathrm{Ric}=5\kappa\,g=\tfrac12g$. $M$ is a compact Einstein symmetric space of dimension $12$; its curvature operator at any point is identical to that of $S^6(\tfrac1{10})\times S^6(\tfrac1{10})$, so $\lVert W\rVert^2=\tfrac9{55}$ and $\theta^2=\tfrac{55}{36}=\theta_0(12)^2$ exactly. It is not isometric to $S^6\times S^6$. *The opposite argued:* one may read "$S^{n/2}\times S^{n/2}$" as naming a curvature model rather than a manifold, in which case the clause is right, and the repair's own added words, "both factors of constant curvature and equal Einstein constant", are curvature-level, which supports that reading. But then "compact Einstein symmetric space" is manifold-level in the same sentence, and the word "exactly" attaches to the wrong level; the honest statement is *equality holds exactly when the curvature tensor is that of a balanced product of two space forms of equal Einstein constant*. **The discrepancy survives all three tests, at the level of scope; it changes no value, and the consumer at [results.md](../results.md) line 567 reads it at the curvature level ("$W$ is the Weyl tensor of a two-factor sphere product") and is unharmed.**

**DISCREPANCY 2, the quantifier is still too wide: $W\ne0$ is missing.** *Located:* the same line, "every compact **Einstein** symmetric space of dimension $n$ satisfies $\theta\le\theta_0(n)$". *Exhibited in closed form:* take $n=12$ and $M=S^{12}$ with $\mathrm{Ric}=\tfrac12g$, i.e. constant curvature $\tfrac1{22}$. Then $R=\tfrac1{22}\mathrm{Id}$ on $\Lambda^2$, and $c=\lambda/(n-1)=\tfrac1{22}$, so $W=R-cI=0$ **exactly**. $M$ is compact, Einstein, symmetric, of dimension $12\ge12$, and $\theta=P(W)/\lVert W\rVert^3$ is $0/0$: the asserted inequality has no truth value at an instance of its own quantifier. $T^{12}$ is a second instance, at $\lambda=0$. *The opposite argued:* one might set $\theta:=0$ when $W=0$, making the statement vacuously true. The record refuses that twice, in the same file and within thirty lines: [L47](../findings/problem.md), "$S^n$ and $\mathbb{RP}^n$ have $W=0$, **which is why $W\ne0$ is a hypothesis and not a remark**: at $S^4$ ... $\theta$ is $0/0$", and [L46](../findings/problem.md), which books $\lambda\ne0$ for the same reason and adds "**the conclusion needs $W\ne0$ and neither the block nor the canon says so**". [conventions.md](../findings/conventions.md) defines $\theta=P(W)/\lVert W\rVert^3$ and assigns no value at $W=0$. **The discrepancy survives all three tests.** It is the brief's "boundary of every stated range" and its "smallest admissible dimension" trap at once: the failure sits at $n=12$, the first admissible dimension, at the most familiar space there.

Severity: **HYPOTHESIS-DEBT, not BROKEN.** Adding "with $W\ne0$" restores the statement and changes no value; the consumer carries $\theta\ge\sqrt{3/2}>0$, which forces $W\ne0$, so nothing downstream moves.

**Is the case analysis otherwise complete?** Yes, once H8 is added. The universal cover of a compact symmetric space splits as $\mathbb R^j\times M_1\times\cdots\times M_r$ with $M_i$ irreducible of compact type. Einstein at $\lambda>0$ forces $j=0$ and every $\lambda_i=\lambda$. $r=1$ is [L47](../findings/problem.md); $r\ge2$ is this lemma. $\lambda=0$ is flat, hence $W=0$, hence excluded by H8. Compactness gives $\mathrm{Ric}\ge0$, so $\lambda\ne0$ and $\lambda>0$ coincide here.

**Is $n\ge12$ load-bearing? Yes, and sharply.** At $n=4$ the statement is outright false: $\mathbb{CP}^2$ is a compact Einstein symmetric space with $\theta^2=\tfrac32$ while $\theta_0(4)^2=\tfrac{2\cdot3\cdot2}{16}=\tfrac34$. The polynomial $n^2-12n+8\ge0$ is exactly the condition under which [L47](../findings/problem.md)'s irreducible ceiling clears $\theta_0(n)$, and $n=12$ is the first integer satisfying it. At $n=12$ the clearance is strict, $\tfrac32<\tfrac{55}{36}$, so no irreducible space can tie the extremiser and the equality case is reducible, consistent with the clause.

**The odd-$n$ figures.** At $n=13$ the best split is $6+7$, so

$$\lVert W\rVert^2=f(6)+f(7)-\tfrac{13}{96}=\tfrac3{20}+\tfrac7{48}-\tfrac{13}{96}=\tfrac{144}{960}+\tfrac{140}{960}-\tfrac{130}{960}=\tfrac{154}{960}=\tfrac{77}{480},$$

and $\theta^2=\tfrac{1/4}{77/480}=\tfrac{120}{77}$. ✓ And $\theta_0(13)^2=\tfrac{2\cdot12\cdot11}{169}=\tfrac{264}{169}$. ✓ Both figures reproduce. Strictness: $\tfrac{120}{77}$ against $\tfrac{264}{169}$ is $120\cdot169=20280$ against $264\cdot77=20328$, so $\tfrac{120}{77}<\tfrac{264}{169}$ **strictly**, as claimed.

**A stronger cross-check the block does not offer.** In general at odd $n$, with $m=\tfrac{n-1}2$, $B=\tfrac18\big(1+\tfrac2{n-3}+\tfrac1{n-1}\big)=\tfrac18\cdot\tfrac{(n-2)(n+1)}{(n-3)(n-1)}$, so $\theta^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$, **exactly [conventions.md](../findings/conventions.md)'s $\Theta_n$ at odd $n$**, independently derived here from L48's own $f$. Screening the two places conventions fixes it: at $n=13$ this gives $\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{120}{77}$ ✓, and $\theta_0^2-\Theta_n^2=2(n-1)\tfrac{(n-2)^2(n+1)-n^2(n-3)}{n^2(n+1)(n-2)}=\tfrac{8(n-1)}{n^2(n+1)(n-2)}$ using $(n-2)^2(n+1)-n^2(n-3)=(n^3-3n^2+4)-(n^3-3n^2)=4$ ✓. **L48's arithmetic and conventions' $\Theta_n$ are the same object, and I confirm the identification.**

**That "$k\ge2$ balanced" really is the odd-$13$ optimum**, screened over the integers, since Jensen alone gives only the real relaxation: $f(6)+f(7)=\tfrac{71}{240}$; $f(5)+f(8)=\tfrac5{32}+\tfrac8{56}=\tfrac{35}{224}+\tfrac{32}{224}=\tfrac{67}{224}$, and $\tfrac{71}{240}<\tfrac{67}{224}$ because $71\cdot224=15904<16080=67\cdot240$; $f(4)+f(9)=\tfrac16+\tfrac9{64}=\tfrac{59}{192}$, and $\tfrac{71}{240}<\tfrac{59}{192}$ because $71\cdot192=13632<14160=59\cdot240$; and every $k\ge3$ exceeds $3f(13/3)=\tfrac{39}{80}$, far above. So $6+7$ is the minimiser. ✓

## 8. The inherited debts from [L47](../findings/problem.md)

The Theorem's irreducible half is L47 entire, and L47's own block records two open items that L48 inherits without mention:

- "**THE MINIMA REST ON A FIVE-POINT SCAN, AND THE EQUALITY CLAUSE RESTS ON THEM** ... *What is owed is the monotonicity of both closed forms on $m\ge2$*". L48's Theorem does not depend on the equality clause of L47 (it needs only $\theta\le\sqrt{3/2}$), so this debt does **not** propagate into L48's inequality. It would propagate into any claim that the equality case at $n\ge12$ is *only* the sphere product, which is what L48's own equality clause asserts. At $n=12$ the clearance $\tfrac32<\tfrac{55}{36}$ is strict, so L48's equality clause survives L47's debt at every $n\ge12$. **Not a defect; recorded so a later reader does not have to redo it.**
- "**What no source on file gives is that the type-I list is complete**". This is the brief's "claim proven on a subfamily and used in general", and it is live: L47's bound is verified family by family over a list whose completeness has no source. L48's Theorem quantifies over *every* compact Einstein symmetric space, so **the Theorem is only as complete as that list**. This is the one debt that genuinely reaches L48's quantifier, and neither L48's block nor the repair note mentions it.

## 9. Claim 14, L46's four hypotheses against L48's object

The record lists them at [graded-half.md](../findings/graded-half.md) line 69: *locally symmetric, Einstein, $\lambda\ne0$, $\lambda=\tfrac12$*.

| L46 hypothesis | discharged at L48's object? |
| --- | --- |
| locally symmetric | **yes**, trivially, a symmetric space is locally symmetric; L46's block adds that the identity "needs neither compactness nor irreducibility nor rank", which answers [graded-half.md](../findings/graded-half.md)'s worry that L46 was "stated for irreducible symmetric spaces, while these objects are products" |
| Einstein | **yes**, it is the Theorem's hypothesis, after the repair, and not before |
| $\lambda\ne0$ | **no**, never checked; $T^{12}$ and every flat factor fail it, and this is discrepancy 2 |
| $\lambda=\tfrac12$ | **not in the canonical block**, it is a normalisation, available by rescaling for any Einstein metric, but *for a product* it needs the observation that a single global rescaling cannot fix two unequal $\lambda_a$; that observation exists only at [graded-half.md](../findings/graded-half.md) line 128 |

**Two of the four are undischarged in the canonical block.** This is the brief's import trap answered by name: L46 is cited for $Q(W)=\lambda W$, and the citation is sound, but the hypotheses that make it applicable to *this* object are checked in a different file.

## 10. Claim 15, a broken sentence in the import's canonical entry

**DISCREPANCY 3.** *Located:* [results.md](../results.md) line 294, the canonical entry for L46: "Normalising to Einstein constant $\tfrac12$ makes $\mathop{\mathrm{tr}}R=n/4$ and the centre constant $c=\frac1{2(n-1)}$, so $\theta\le\theta_0(n)$ becomes the single inequality $\lVert W\rVert^2\ge\tfrac16$, **the form Lemmas 47 and 48 verify**."

*Exhibited in closed form.* With $\lambda=\tfrac12$, L46 gives $\theta=\tfrac1{2\lVert W\rVert}$, so

$$\theta\le\theta_0(n)\iff\lVert W\rVert^2\ge\frac1{4\theta_0(n)^2}=\frac{n^2}{8(n-1)(n-2)},$$

which equals $\tfrac16$ only at $n^2-12n+8=0$, i.e. $n=6+2\sqrt7\notin\mathbb Z$. At $n=12$ the true right-hand side is $\tfrac9{55}$, and $\tfrac9{55}<\tfrac16$ since $9\cdot6=54<55$. **L48's own extremiser realises the gap**: $S^6\times S^6$ with $\mathrm{Ric}=\tfrac12g$ is a compact Einstein symmetric space of dimension $12$ with $\lVert W\rVert^2=2f(6)-\tfrac{12}{88}=\tfrac9{55}<\tfrac16$. So the sentence's "single inequality" is false at the very space L48 names, and L48 does not verify it.

*The opposite argued.* (i) Perhaps $\tfrac16$ is shorthand and the $n$-dependence is elided. But the sentence says "$\theta\le\theta_0(n)$ becomes", naming $\theta_0(n)$ explicitly, and conventions fixes $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$ "and nothing more"; $\tfrac{55}{36}\ne\tfrac32$. (ii) Perhaps the intended target is $\sqrt{3/2}$ rather than $\theta_0(n)$. Conventions fixes "the target of Problem P is $\Theta_n$", and $\Theta_{12}=\theta_0(12)$. (iii) Perhaps only L47 is meant, which does prove $\lVert W\rVert^2\ge\tfrac16$ for irreducible spaces. That is the charitable reading and it requires deleting "and 48", the sentence attributes the form to both lemmas jointly, and L48's conclusion is the other inequality. **The discrepancy survives all three tests.**

*Impact.* It sits in L46's canonical entry, not in L48's block, and it misdescribes L48's contribution as proving something L48 refutes. It changes no figure inside L48. Verdict for the sentence: **BROKEN**; the repair is to replace "$\lVert W\rVert^2\ge\tfrac16$, the form Lemmas 47 and 48 verify" with the two separate inequalities, $\lVert W\rVert^2\ge\tfrac16$ at L47 and $\lVert W\rVert^2\ge\tfrac{n^2}{8(n-1)(n-2)}$ at L48, together with the observation that the second is the weaker requirement exactly when $n\ge12$. **I record the repair as what the record owes; I do not apply it.**

## 11. Claim 13, is the repair's own summary fair?

> **TWO HYPOTHESES WERE MISSING, AND NEITHER CHANGES A VALUE.**

**No, on two counts.**

- **The count is short.** Einstein and roundness were added. $W\ne0$ was not, and it is missing from the same sentence, at the same first admissible dimension, in a file whose neighbouring block calls it "a hypothesis and not a remark" (section 7, discrepancy 2). Three hypotheses were missing; two were supplied.
- **"Neither changes a value" is true and misleading.** True: $\theta_0(n)$, $\tfrac16$, $\tfrac{n^2}{8(n-1)(n-2)}$ and $n^2-12n+8$ are all unmoved, and I confirm each independently above. Misleading: **adding a hypothesis narrows a claim**, and what changed is the domain of quantification. Before the repair the Theorem asserted a bound over every compact symmetric space of dimension $n\ge12$; after it, only over the Einstein ones. The class dropped is not empty and is not exotic, $S^{11}\times S^1$, $S^{10}\times T^2$, and $S^6(\kappa_1)\times S^6(\kappa_2)$ with $\kappa_1\ne\kappa_2$ are all compact symmetric spaces of dimension $12$ that the theorem no longer reaches. A summary whose headline is "neither changes a value" invites the reading that nothing of consequence happened, when the theorem is now strictly weaker and its old scope is unresolved rather than retained.

**What a fair summary would say**, positively: *the theorem now ranges over the Einstein symmetric spaces, where the proof's identity applies; the values are unchanged, and the non-Einstein spaces the old statement covered are no longer claimed either way.* The note's own inner clause, "*the formula never applied to it*", is already exactly this and is the honest sentence in the paragraph; the bolded headline above it is what overstates.

## 12. The traps, answered by name

| trap | finding |
| --- | --- |
| $\ker W\ne0$ and padded objects | **Two hits.** (a) The block never states $n=\sum_an_a$, and the record has already paid for that omission, section 3b. (b) $W=0$ is the extreme case of $\ker W\ne0$ and is discrepancy 2. At the extremiser itself $\ker W=0$: the eigenvalues are $\tfrac1{2(p-1)}-\tfrac1{2(n-1)}>0$, $\tfrac1{2(q-1)}-\tfrac1{2(n-1)}>0$ and $-\tfrac1{2(n-1)}<0$, none zero for $p,q\ge2$, which is what the consumer's "$\Delta=0$ certifies equivariance only where $\ker W=0$" needs. |
| boundary of every stated range | $n=12$ is the first admissible dimension and is where discrepancy 2 bites, at $S^{12}$; $n_a=1$ is the pole of $f$, excluded only by Einstein; $k=1$ is section 5b; $m=2$ is the left endpoint of $f$'s convexity, where $f''=\tfrac14>0$ still. |
| the smallest admissible dimension | $n=12$: checked that $n^2-12n+8\ge0$ first holds there ($144-144+8=8>0$, against $121-132+8=-3<0$ at $n=11$), that $\tfrac32<\tfrac{55}{36}$ strictly, and that the equality case there is reducible. |
| odd $n$ | Handled by the repair note and confirmed: $\tfrac{120}{77}$ and $\tfrac{264}{169}$ both rederived, the general odd formula rederived and matched to conventions' $\Theta_n$, and the integer optimality of $6+7$ screened. The one thing the *argument* does not cover at odd $n$ is the "no gap" claim, section 6, recorded as an observation. |
| $k=1$ against $k\ge2$ | Section 5b: a live `GAP`, since $k=1$ is in the domain and gives a strictly smaller $B$. |
| a claim proven on a subfamily and used in general | Two. (a) L47's type-I list completeness has no source, and L48's Theorem quantifies over all of it, section 8. (b) [ungraded-slack.md](../findings/ungraded-slack.md) records the multi-block identity as "verified symbolically for $k=2,3,4$" while it is consumed at every $k$; L48's derivation does prove it at every $k$, but that derivation lives in [graded-half.md](../findings/graded-half.md) and the canonical block asserts the identity without it. |
| a hypothesis stated but never used | "$f$ is decreasing", section 4. Also "equal Einstein constant" in the equality clause, which is implied by the ambient Einstein hypothesis; harmless, and arguably a useful reminder. |
| a step using a hypothesis never stated | The main finding: H2, H3, H4, H5, H6, H7 in the inventory, six, all used, none stated in the lemma paragraph. |
| a universal claim with no witness | The Theorem has one: $S^6\times S^6$ at $n=12$, with $\lVert W\rVert^2=\tfrac9{55}$ and $\theta^2=\tfrac{55}{36}=\theta_0(12)^2$, cross-checked against conventions' independently recorded $\tfrac{55}{36}$. |
| an imported theorem whose hypotheses were never checked | Section 9: two of L46's four are unchecked in the canonical block. The precedent the brief cites (a cited theorem assuming a unital algebra where $\mathcal W_n$ has no unit), is the same shape, and the same shape recurs here in the milder form of an unchecked normalisation. |
| symbol collisions | Section 13. |

## 13. Claim 16, symbol hygiene

- **$B$.** L48's $B=\sum_af(n_a)-\tfrac n{8(n-1)}$ is a **scalar**. [conventions.md](../findings/conventions.md) already tables three objects under that letter, the Killing form $(n-2)\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)$, [sym3-blocks.md](../findings/sym3-blocks.md)'s $-\tfrac12\mathop{\mathrm{tr}}(XY)$, and the critical-point **operator** $B=\tfrac\theta2\mathrm{Id}-L_W$, with the standing warning "**THE LETTER $B$ MEANS TWO THINGS, live** ... **Say which you mean, every time**". L48's is a **fourth**, it is untabled, and it is the only one that is a scalar, so a reader meeting "$B\succeq0$" and "$B=\sum_af(n_a)-\ldots$" in the same file has no way to sort them but context. **GAP**, it should be tabled.
- **$f$.** Defined only inside L48's own sentence, and consumed in three files, [problem.md](../findings/problem.md) line 256, [graded-half.md](../findings/graded-half.md) lines 130 and 381, and [results.md](../results.md) line 567, with no entry in conventions. It is the record's second-most-travelled unlisted symbol in this neighbourhood after $B$. **GAP.**
- **$k$.** The number of de Rham factors here. It collides with [second-order.md](../findings/second-order.md)'s $k$ in "$m(1)=\binom k2$ and $m(\tfrac12)=k\cdot\mathrm{orb}$ at $(S^3)^k$" (which is *the same* $k$, so this one is benign) and with the index $k$ of $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2$ in [bounds.md](../findings/bounds.md), which is not. Untabled, low severity.
- **$c$.** Not written in L48's block, but consumed through it: the whole argument runs on $c=\tfrac1{2(n-1)}$, and conventions already flags $c$ as colliding with [L44](../findings/problem.md)'s pinned $\partial\Omega_0$ constant "twenty lines up" in the same file. Since L48 sits sixteen lines below L47, which does write $c=\tfrac1{2(n-1)}$, a reader of `problem.md` meets three $c$'s within forty lines.
- **$\lambda$.** Used here as the Einstein constant. Conventions flags it as colliding with "Petersen–Stanfield's block eigenvalues **inside one citation**", and L46 (the import), is that citation.
- **$n$.** The most consequential of all, because it is the one whose ambiguity has already produced a wrong number on this record: ambient dimension against $\sum_an_a$. Section 3b.

## 14. What would falsify each, and what I did to look

**The lemma** is the closed form together with the minimisation. It would be falsified by any one of:

- a Riemannian product whose curvature operator has a nonzero mixed block on $\Lambda^2$;
- an Einstein product at $\lambda=\tfrac12$ with $\lVert W\rVert^2\ne\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-\tfrac n{8(n-1)}$;
- integers $k\ge2$, $n_a\ge2$, $\sum n_a=n$ with $\sum_af(n_a)-\tfrac n{8(n-1)}<\tfrac{n^2}{8(n-1)(n-2)}$;
- an Einstein factor at $\lambda>0$ with $W_a=0$ that is not of constant curvature.

*What I did.* Derived $B$ twice by routes sharing nothing, once through $\lVert R\rVert^2=\sum\lVert R_a\rVert^2$ and L47's normalised identity, once by block-expanding $W=R-cI$ and summing $c_a^2\binom{n_a}2$ plus the mixed blocks, and got the same expression, which pinned the unstated $\lambda=\tfrac12$. Differentiated $f$ twice for the convexity direction and $kf(n/k)$ once for the $k$-direction. Closed the partition minimisation as a two-step relaxation (Jensen at fixed $k$, then monotonicity in $k$) and checked the endpoints $k=1$, $n_a=1$, $n_a\in\{2,3\}$ by hand. Screened the closed form at $n=4$ against a direct computation of $S^2\times S^2$, at $n=12$ against conventions' independently recorded $\tfrac{55}{36}$, at $n=13$ against the block's own $\tfrac{120}{77}$, at $S^5\times S^7$ against [graded-half.md](../findings/graded-half.md)'s $\tfrac{264}{175}$, at $(5,5)$ against its $\theta=\tfrac65$, at $(5,6)$ against its $\tfrac{40}{27}$ (which also equals $\Theta_{11}^2$ from conventions' odd formula), and at $(S^3)^3$ against both the padded and unpadded readings. Rederived the general odd-$n$ value from L48's $f$ and found it is conventions' $\Theta_n$ exactly. **No falsifier found; the closed form is right.**

**The Theorem** is a different object, a statement about manifolds, not about a formula. It would be falsified by:

- a compact Einstein symmetric space of dimension $n\ge12$ with $W\ne0$ and $\theta>\theta_0(n)$;
- a space attaining $\theta=\theta_0(n)$ at even $n\ge12$ outside the stated equality set;
- an instance of the quantifier at which the conclusion is not well formed.

*What I did.* Exhausted the de Rham cases against the hypothesis (irreducible → L47; reducible → the lemma; flat → $W=0$) and confirmed the exhaustion is complete once $W\ne0$ is added. Checked $n\ge12$ is sharp by exhibiting $\mathbb{CP}^2$ at $n=4$, where the statement is plainly false, and by locating the integer threshold from $n^2-12n+8$. Checked that no irreducible space can tie at $n\ge12$, so the equality case must be reducible. Looked for equality-case witnesses outside the stated set and **found one**, $\mathbb{RP}^6\times\mathbb{RP}^6$ (discrepancy 1). Looked for ill-formed instances and **found two**, $S^{12}$ and $T^{12}$ (discrepancy 2). Traced the import chain into L46 and L47 and **found a third defect there**, the false sentence at [results.md](../results.md) line 294 (discrepancy 3). I did not attempt to evaluate $\theta$ at any non-Einstein symmetric space: no identity is available there, $P(W)$ would have to be computed, and that is numerical work this loop does not do, so whether the pre-repair statement was *false* on the class it lost, as against merely unsupported, is **not settled by anything on file and is not settled here**.

## Verdict

**`HYPOTHESIS-DEBT`.**

- **The lemma's mathematics is correct and I confirm every figure in it**, by two independent derivations of $B$ and by nine closed-form screens that all reproduce values recorded elsewhere on the record. The claim table's "PROVEN" rows are proven.
- **The canonical block is a lossy abridgement.** The correct and complete argument is at [graded-half.md](../findings/graded-half.md) lines 128–136; the copy at [problem.md](../findings/problem.md) line 256 dropped the Einstein normalisation of the factors, the step $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$, the definition $n=\sum_an_a$, the range $k\ge2$, the parity condition on the equality clause, and weakened "constant curvature" to "sphere". Six hypotheses are used and none is stated in that paragraph.
- **The Theorem still owes $W\ne0$**, and its equality clause is stated at the wrong level and excludes $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$, which attains it.
- **The repair's summary is not a fair description**: three hypotheses were missing and two were supplied, and "neither changes a value" states what did not change while leaving unsaid that the theorem was narrowed to a strictly smaller class.
- **One separate `BROKEN` sentence** was found in the import's canonical entry, [results.md](../results.md) line 294, refuted in closed form by L48's own extremiser.

No value in L48 moves. What is owed is the hypothesis set of the canonical block, the $W\ne0$ clause of the Theorem, the level of its equality clause, and the correction of one sentence in L46's entry.

## 15. Addendum, written after the verdict, the sphere/space-form point is already Gate-2'd on the record

Checked only after the sections above were fixed, so it did not steer them. [graded-half.md](../findings/graded-half.md) line 389 already states discrepancy 1's content and carries a Gate 2 behind it:

> "And every factor has **constant curvature**, the criterion the record actually checks, which $\mathbb{RP}^m$ also satisfies, so "is a sphere" is stronger than what is established ... *Gate 2, [r501](../reviews/REVIEW_r501.md) and [r502](../reviews/REVIEW_r502.md), independently.*"

**This strengthens the round's finding rather than retiring it.** The correction is on the record, it was independently confirmed, and **the canonical block was not updated**: [problem.md](../findings/problem.md) line 256 still reads "vanishes exactly when that factor is a sphere", and line 260 still reads "equality exactly at $S^{n/2}\times S^{n/2}$". So discrepancy 1 is not a fresh defect but an **uncorrected canonical copy standing against a Gate-2'd correction elsewhere in the record**, the same failure mode as sections 2, 3b and 5, and the third instance of it in this block. The repair is a one-word edit in two places, "sphere" to "space form of constant curvature", and it changes no value.

The same line supplies one thing the canonical block leaves to the reader: the exclusion of $k\ge3$ **under the budget**, as against the identification of $k=2$ as the minimiser. The two are different statements, and the note records that an earlier version confused them, "*a global minimum at $k=2$ constrains nothing at $k=3$*". The current block's monotonicity does support the budget form, since it bounds each $k$ from below rather than only locating the minimum: screening $k=3$ at $n=12$ gives $3f(4)-\tfrac{12}{88}=\tfrac12-\tfrac3{22}=\tfrac{4}{11}>\tfrac16$. **No defect; recorded because the distinction is one this block has already been caught on once.**
