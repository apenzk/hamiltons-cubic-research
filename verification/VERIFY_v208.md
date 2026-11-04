# VERIFY_v208, Lemma L13, the spectral-moment ceiling

**Cold read of [BRIEF_L13.md](BRIEF_L13.md), sections A–C, taken as the primary text; [conventions.md](../findings/conventions.md), [second-order.md](../findings/second-order.md), [ATTEMPTS.md](../ATTEMPTS.md), [L13.lean](../lean/HamiltonsCubic/Results/L13.lean), [INDEX-results.md](../findings/INDEX-results.md) and [results.md](../results.md) read afterwards, to check the brief's own citations. No numerical work of any kind was done: no script, no Sage, no Python, no numeric evaluation. Every number below is either quoted from the record or produced by hand in exact or bracketed rational arithmetic, as a screen on a claim I was about to record. Log: [agent_logs/verify-L13-v208.log](../agent_logs/verify-L13-v208.log).**

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | Section A carries a canonical statement of L13 | **BROKEN, there is no statement, only a heading and a proof pointer** |
| 2 | The block carries a proof | **BROKEN, the block is its own statement; no derivation is in it** |
| 3 | $\theta^2(1+k_0/4)\le\tfrac{(n-1)(2n-1)}4$ at a critical point, $k_0=\dim(O(n)\cdot W)$ | **PROVEN, hypotheses corrected**, given claim 5 |
| 4 | The Peirce cap is used in getting there | **REFUTED, the cap is stated and never used; the attainment is** |
| 5 | $\kappa_n=(n-1)(2n-1)/4$ | **HYPOTHESIS-DEBT, proven at even $n\ge6$, fitted at odd $n\le13$, open at odd $n\ge15$** |
| 6 | "the method's ceiling is $\lambda\le2-o(1)$" | **BROKEN as written**, it is the *best conceivable* bound, not the method's guarantee, which the record's own witness degrades to $O(\sqrt n)$ |
| 7 | The $n=12$ excess is $58.9\times$ | **ARITHMETICALLY CORRECT, I bracket it at $58.92$, but it measures the level-2 ceiling while the prose promises the method's best** |
| 8 | The asymptotic excess is $3.09\times$ | **PROVEN**, bracketed strictly inside $(3.09,3.10)$ |
| 9 | "reaching $58.9$ needs $k_0\ge74>66$" | **BROKEN, a mis-transcription of a clause about $49.7$, and it contradicts the sentence before it** |
| 10 | That $k_0$ argument, in its original form about $49.7$ | **BROKEN, the inference is invalid; applied to $\theta_0(12)$ it refutes a point the record says exists** |
| 11 | "attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$" | **REFUTED at critical points; UNRESOLVED at local maxima, where the record's witnesses do not reach** |
| 12 | Only "at least" is consumed downstream | **PROVEN, confirmed verbatim at [second-order.md](../findings/second-order.md)** |
| 13 | "spectral moments of $L_u$ are the wrong invariants … the whole approach is closed" | **HYPOTHESIS-DEBT in the block; the real argument is in [second-order.md](../findings/second-order.md) and the block does not carry or cite it** |
| 14 | Section C's rebuttal, "the moments are complete invariants for $\theta$, so this is backwards" | **HALF-REFUTED, true of a known $L_W$, irrelevant to the method, and the record itself says why** |
| 15 | "the fourth moment reaches only $14\times$ even granting an oracle" | **HYPOTHESIS-DEBT, no derivation, no displayed bound, and no source I could find in the record** |
| 16 | The block splits three ways by label | **REFUTED, it splits at least eight ways** |

**One line.** The chain the block *displays* is correct and one line long, but the block contains no proof of it, its central constant is proven only at even $n$, its "ceiling" is the method's best case sold as the method's guarantee, and the paragraph that was meant to settle its headline number now contradicts itself because a global replacement of $49.7$ by $58.9$ ran through a sentence that was specifically about why $49.7$ is unreachable, a sentence whose own argument is invalid in either form.

**Verdict: `BROKEN`.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- $\theta$, "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$, "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$*".
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$".
- $\dim\mathcal W_n$ ("$\frac{n(n-3)(n+1)(n+2)}{12}$), $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$".
- $\kappa_n$, "**two meanings and one of them falsifies a lemma** … [L17](../findings/route-a.md)'s penalty coefficient, $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, **negative exactly at $n\ge12$** … *This table's other $\kappa_n$ is the algebra's Killing constant $\tfrac{(2n-1)(n-1)}4$, which is $63.25$ at $n=12$*".
- $B$, "$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point … *This is a third object under the letter $B$ in this record*"; and, separately, "**THE LETTER $B$ MEANS TWO THINGS, live.** [conventions.md]'s Killing form above is $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)$; [sym3-blocks.md](../findings/sym3-blocks.md) writes $B(X,Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$".
- The operator the block calls $L_u$ already has a name here: "$F_u(h)=\tfrac12(uh+hu)+u\#h$", with "$u=W_{\mathbb{CP}^2}$ padded to unit norm, $\theta^*=P(u)=\sqrt{3/2}$".

## 1. Hypothesis inventory

A pass with no inventory is not a pass. The chain the block displays needs eleven things. Two are stated, one is stated and never used, seven are used and never stated, and one is missing outright.

| # | hypothesis | in the block? | used? | status |
| --- | --- | --- | --- | --- |
| H1 | $n$ in a range where $\mathcal W_n\ne0$, i.e. $n\ge4$ | no | yes | **undeclared**; the block names no range at all |
| H2 | $W$ critical: $Q(W)=\theta W$ | yes, "from criticality alone" | yes | ok |
| H3 | $\lVert W\rVert=1$ | no | yes, it drops the $\lVert W\rVert^2$ it had just written | **undeclared** |
| H4 | $\theta>0$ | no | yes, twice: to keep $W$ out of the $\theta/2$-eigenspace, and to form $e=W/\theta$ | **undeclared** |
| H5 | $L_W$ symmetric | no | yes, without it $\mathop{\mathrm{tr}}(L_W^2)$ is not $\sum\mu_i^2$ | **undeclared** |
| H6 | $Q$ is $O(n)$-equivariant | no | yes, it is the whole of the $\theta/2$ multiplicity | **undeclared** |
| H7 | $\mathcal W_n$ irreducible, with no $O(n)$-invariant vector | no | yes, it is the whole of both trace identities | **undeclared** |
| H8 | $W$ a **local maximum** | implied by naming a "Peirce cap" | **no** | **stated and never used** |
| H9 | $\kappa_n=(n-1)(2n-1)/4$ | asserted, unproved | yes | **debt**, §4 |
| H10 | $k_0\le\binom n2$ | yes | yes, for the ceiling | true of the *orbit dimension*; **false** of the $\theta/2$-multiplicity, §6 |
| H11 | a lower bound on $k_0$ | **absent** | needed for any numeric bound at all | **the gap**, §7 |

H8 and H11 are the two the brief named in advance, and both land.

## 2. What Section A would have to say

[results.md](../results.md) lines 577–579 carry a heading, a blank line, and "**Proof:** [curvature-invariants.md](../findings/curvature-invariants.md)". There is no statement between them. This is a strictly worse case than the one the record has already acted on: the very next entry, [L14](../results.md), was **withdrawn as a numbered result** because "**The heading promised a bound and the block displays no inequality**". L13's canonical entry displays no inequality, no quantifier, no hypothesis and no conclusion.

Drawn from the argument as written, and from nothing else, the canonical statement would have to be:

> **Lemma L13 (spectral-moment ceiling).** Let $n\ge6$ be even, let $W\in\mathcal W_n$ satisfy $\lVert W\rVert=1$ and $Q(W)=\theta W$ with $\theta>0$, and let $L_W$ be the polarisation $L_WH=\tfrac12(WH+HW)+W\# H$, so that $P$'s symmetric trilinear form is $T(A,C,D)=\langle L_AC,D\rangle$. Then $L_W$ is symmetric, $L_WW=\theta W$, $\mathop{\mathrm{tr}}(L_W)=0$, $\mathop{\mathrm{tr}}(L_W^2)=\tfrac{(n-1)(2n-1)}4$, and every vector tangent to the orbit $O(n)\cdot W$ is an eigenvector of $L_W$ of eigenvalue exactly $\theta/2$. Consequently
> $$\theta^2\Bigl(1+\tfrac{k_0}4\Bigr)\le\frac{(n-1)(2n-1)}4,\qquad k_0=\dim\bigl(O(n)\cdot W\bigr),$$
> and since $k_0\le\binom n2$ the smallest value the right-hand side can ever force is
> $$\theta^2\le\frac{2(n-1)(2n-1)}{n^2-n+8}\longrightarrow4^-,$$
> so no critical point with a $\binom n2$-dimensional orbit can be excluded by this inequality below $\theta=2-o(1)$.

Everything after "Consequently" is what the record means by "the ceiling". Note what the statement does **not** contain: any claim about "wrong invariants", any claim about refinements, and any margin. Those are separate pieces, §9.

## 3. The ceiling, derived, and the cap is not used

The block gives no derivation, so what follows is a statement of **what the block would have to contain**, not a supply of a missing argument: the verdict on the block itself is that it has none.

$P(W)=T(W,W,W)$ with $T$ symmetric, so $\nabla P=3Q(W)$ with $Q(W)=T(W,W,\cdot)^\sharp$, and $L_W:=T(W,\cdot,\cdot)^\sharp$ is symmetric. Two facts follow with no optimality anywhere:

1. **Euler.** $L_WW=T(W,W,\cdot)^\sharp=Q(W)=\theta W$.
2. **Equivariance.** $Q(gW)=gQ(W)$ for $g\in O(n)$. Differentiating along $g=\exp(tX)$, $X\in\mathfrak{so}(n)$, at $t=0$ with $z=X\cdot W$ gives $2L_Wz=X\cdot Q(W)=\theta z$, i.e. $L_Wz=\tfrac\theta2z$ **exactly**, at every nonzero critical point.

$L_W$ preserves $W^\perp$, since $\langle L_WH,W\rangle=T(W,H,W)=\langle L_WW,H\rangle=\theta\langle W,H\rangle$. So the spectrum of $L_W$ contains $\theta$ once and $\theta/2$ with multiplicity at least $k_0=\dim(O(n)\cdot W)$, and these are distinct because $\theta>0$. Symmetry gives $\mathop{\mathrm{tr}}(L_W^2)=\sum_i\mu_i^2$, hence

$$\frac{(n-1)(2n-1)}4=\mathop{\mathrm{tr}}(L_W^2)\ \ge\ \theta^2+k_0\Bigl(\frac\theta2\Bigr)^2=\theta^2\Bigl(1+\frac{k_0}4\Bigr).$$

**The Peirce cap is not used.** The step is a *lower* bound on a sum of squares, and it consumes only that $\theta/2$ is attained with multiplicity $\ge k_0$. An upper bound $L_W|_{W^\perp}\preceq\theta/2$ contributes nothing to it. The block writes the cap into the same sentence as the attainment, joined by "attained on", and then says the inequality follows "from criticality alone", which is true of what it uses and false of what it wrote. Section C's annotation is right on this point and right about why: the cap is the constrained second-derivative test. With multiplier $3\theta/2$ from $3Q(W)=\mu\cdot2W$, the Lagrangian Hessian is $6L_W-3\theta\,\mathrm{Id}\preceq0$ on $W^\perp$, which is the cap; it needs local maximality, the attainment does not.

**Where the ceiling comes from.** With $k_0\le\binom n2=\tfrac{n(n-1)}2$,

$$\theta^2\le\frac{(n-1)(2n-1)/4}{1+n(n-1)/8}=\frac{2(n-1)(2n-1)}{n^2-n+8}=4-\frac{2n+30}{n^2-n+8},$$

strictly below $4$ at every $n$ and tending to $4$. Against $\theta_0(n)^2=2(n-1)(n-2)/n^2\to2$ the ratio of bound to target tends to $\sqrt2$, matching [second-order.md](../findings/second-order.md)'s independently recorded "$\mathrm{bound}/\theta_0$ peaking at $1.5104$ near $n=10$ and tending to $\sqrt2$". So the arithmetic of the ceiling is sound. Its **framing** is not: §7.

## 4. $\kappa_n$, proven at even $n$, fitted at odd $n$, used at all $n$

By Schur, $\mathop{\mathrm{tr}}(L_xL_y)$ is an $O(n)$-invariant symmetric bilinear form on an irreducible module, hence $\kappa_n\langle x,y\rangle$ for **some** constant; and $\mathop{\mathrm{tr}}(L_x)=\langle x,\tau\rangle$ with $\tau$ invariant, hence $0$ because $\mathcal W_n$ carries no invariant vector. That much is free at every $n$. The **value** of $\kappa_n$ is not.

What the record actually holds, from [second-order.md](../findings/second-order.md):

- "It was first fitted to those four points and then checked at them, **which is no derivation**; two Gate 2 reviewers independently supplied the real one **at every even $n$**, by summing the six recorded Peirce families to $\sum\lambda^2=m^2(4m-1)/\big(4(m-1)\big)$."
- "$\kappa_W=(2n-1)(n-1)/4$ is **exact across $n=4\ldots13$**", that is verification, not proof.
- "**A proof still requires evaluating $\lVert T\rVert^2$ directly** as a contraction of the $\mathfrak{so}(n)$ structure constants against the Weyl projector."
- Fox's Theorem 1.3 supplies the *shape* of both identities; the constant is "a value **Fox's Remark 1.4 leaves open** above $\dim V=4$". So the import supplies nothing here.

The even-$n$ derivation closes: at $n=2m$, $\theta_0(2m)^2=(2m-1)(m-1)/m^2$, so
$$\kappa_{2m}=\theta_0^2\sum\lambda^2=\frac{(2m-1)(m-1)}{m^2}\cdot\frac{m^2(4m-1)}{4(m-1)}=\frac{(2m-1)(4m-1)}4=\frac{(n-1)(2n-1)}4 .$$
That is a genuine proof at even $n\ge6$ ($m=3$ is where the family $V_{(1,1);(1,1)}$ of dimension $m^2(m+1)(m-3)/4$ vanishes), and Schur then extends it from the sphere product to all of $\mathcal W_n$ **at that $n$**. It does not cross to odd $n$, because it is evaluated at the balanced product, which conventions.md says "is the value at the balanced sphere product **at even $n$ only**".

Section C's annotation is therefore right, and the finding the brief anticipated lands squarely:

- **A constant proven at even $n$ and used at all $n$.** The ceiling $\theta\le2-o(1)$ is an *asymptotic* statement; along odd $n$ it has no proof. The block states it without parity, and the annotation's own range "$n\ge12$" contains $13,15,17,\dots$.
- Odd $n$ is verified only at $n=5,7,9,11,13$ and is **open at every odd $n\ge15$**, including the entire asymptotic regime the ceiling is about.
- Section C's proposed closure, "$\kappa_n\dim\mathcal W_n=\lVert T\rVert^2$", is a correct identity, summing $\mathop{\mathrm{tr}}(L_{B_i}L_{B_i})=\kappa_n$ over an orthonormal basis gives it by total symmetry of $T$, but [second-order.md](../findings/second-order.md) already records that "**It is a corollary of the second identity, not an independent route** … so it restates the constant rather than proving it". The annotation offers as the closing lemma a thing the record has already ruled non-closing. **The closure route is the direct evaluation of $\lVert T\rVert^2$, and it is not on file.**

**Smallest admissible $n$.** The block names none. $\mathcal W_n\ne0$ from $n=4$; the Schur step needs $O(4)$ rather than $SO(4)$ at $n=4$, the record recording "commutant $=1$ at $n=5\ldots10$, with $n=4$ returning $2$"; the $\kappa_n$ derivation starts at $n=6$. So the honest range of the displayed chain is **even $n\ge6$**, and nothing in the block says so.

## 5. The margin, checked in exact arithmetic, and it is a ratio of gaps

**What the number is a ratio of.** Not bound-to-target. The block's own denominator, made explicit in [ATTEMPTS.md](../ATTEMPTS.md)'s source table ("$\theta_0(n)$ | gap\* | best bound | excess / gap\*"), is
$$R(n)=\frac{\text{bound}(n)-\theta_0(n)}{\theta_0(n)-\sqrt{3/2}},$$
the overshoot measured in units of the window between the conjectured maximiser and the padded $W_{\mathbb{CP}^2}$ competitor. **The block never displays this denominator**, and it is the whole of the factor.

**The asymptotic figure.** With $2\to$ bound, $\sqrt2\to\theta_0$: from $1.4142135<\sqrt2<1.4142136$ and $1.224744<\sqrt{3/2}<1.224745$,
$$\frac{2-\sqrt2}{\sqrt2-\sqrt{3/2}}\in\Bigl(\frac{0.5857864}{0.1894696},\ \frac{0.5857865}{0.1894685}\Bigr)\subset(3.09,3.10).$$
✔ matches the printed $3.09\times$.

**At $n=12$.** $\kappa_{12}=\tfrac{11\cdot23}4=\tfrac{253}4$; $k_0\le\binom{12}2=66$ gives $1+\tfrac{66}4=\tfrac{35}2$ and $\theta^2\le\tfrac{253}{4}\cdot\tfrac2{35}=\tfrac{253}{70}$. $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}$. Bracketing each root by squaring rationals, no root is taken:
$$\Bigl(\tfrac{190112}{10^5}\Bigr)^2<\tfrac{253}{70}<\Bigl(\tfrac{190113}{10^5}\Bigr)^2,\quad \Bigl(\tfrac{1236033}{10^6}\Bigr)^2<\tfrac{55}{36}<\Bigl(\tfrac{1236034}{10^6}\Bigr)^2,\quad \Bigl(\tfrac{1224744}{10^6}\Bigr)^2<\tfrac32<\Bigl(\tfrac{1224745}{10^6}\Bigr)^2 .$$
Then $\text{bound}-\theta_0\in(0.665078,0.665100)$ and $\theta_0-\sqrt{3/2}\in(0.011288,0.011290)$, so $R(12)\in(58.90,58.92)$, and the sharper hand check puts it at $58.922$. ✔ **$58.9\times$ is right to the digit printed, under the block's own denominator.** The Lean file brackets only $58<R<59$; the extra digit is mine and is a screen, not evidence.

**And now the defect the brief pointed at.** Section C says, in the same paragraph, both

- "**Applied at $n=12$ that same formula gives strictly between $58$ and $59$**", and
- "$58.9$ is **not a competing reading but an unreachable one** … reaching $58.9$ needs $k_0\ge74>66=\dim\mathfrak{so}(12)$."

$58.9$ lies strictly between $58$ and $59$. The paragraph refutes its own headline one sentence after asserting it.

**Located.** [L13.lean](../lean/HamiltonsCubic/Results/L13.lean) carries the sentence in its original and coherent form, about **$49.7$**: "*Reaching `49.7` needs `λ ≤ 1.7971`, hence `λ² ≤ 3.2295`, hence `1 + k₀/4 ≥ 253/(4·3.2295)`, which puts `k₀ ≥ 74`*". [ATTEMPTS.md](../ATTEMPTS.md)'s ledger entry of 2026-09-06 says the figure was "**Corrected in all seven places the figure stood**". The replacement ran through the one sentence in which the old number was the *subject* rather than the *claim*.

**Exhibited.** $49.7$ requires $\theta=\theta_0+49.7\,(\theta_0-\sqrt{3/2})$, i.e. $\theta\approx1.79707$, $\theta^2\approx3.2294$, $\tfrac{253}{4}/3.2294-1\approx18.586$, $k_0\ge74.3$, the record's $74$. For $58.9$ the same computation gives $\theta\approx1.90090$, $\theta^2\approx3.61342$, $\tfrac{253}4/3.61342-1\approx16.506$, $k_0\ge66.02$: the cap $66$ already delivers $58.92$. **$74$ is the arithmetic of $49.7$ and of nothing else.**

**Opposite argued.** I tried every reading of "excess" I could construct on which $58.9$ would need $k_0\ge74$: the ratio in squared variables gives $75.1$ at $k_0=66$ and needs $k_0\ge76$ for $58.9$; the numerator taken against $\sqrt{3/2}$ gives $59.92$; the plain ratio $\text{bound}/\theta_0$ gives $1.538$; and $k_0=74$ corresponds, under the block's own formula, to $R\approx50.0$, not $58.9$. No reading yields $74$ from $58.9$. **Discrepancy stands.**

## 6. The $k_0$ argument is invalid even in its original form

Separately from the transcription, the inference itself does not hold. It reads: a smaller $\lambda$ requires a larger $k_0$; the required $k_0$ exceeds $\dim\mathfrak{so}(12)$; "**so no critical point produces it**".

$\lambda^2(1+k_0/4)\le\kappa_n$ is an **upper** bound on $\theta$. A critical point may sit arbitrarily far below its own bound, and the inference treats the bound as an equality.

**Exhibited, in closed form.** Apply the same reasoning to $\theta_0(12)=\sqrt{55}/6$, the value the record attributes to the balanced $S^6\times S^6$: reaching it would need $1+\tfrac{k_0}4\ge\tfrac{253/4}{55/36}=\tfrac{253\cdot36}{4\cdot55}=\tfrac{2277}{55}=41.4$, i.e. $k_0\ge161.6>66$. By the argument's own logic **no critical point attains $\theta_0(12)$**, and [second-order.md](../findings/second-order.md) lists "$S^6\times S^6$ balanced | 12 | 1.236033" as a critical point on file. The inference pattern refutes a point the record says exists, so it is invalid.

**And the premise is wrong too.** $1.7974$ was never produced by this inequality. [REVIEW_r596.md](../reviews/REVIEW_r596.md) records that "$49.7$ uses `bound_level3(n, N)`, the **level-3** bound … obtained by a grid search", and [second-order.md](../findings/second-order.md) displays that stronger bound outright:
$$\theta^2\le\frac{\kappa_W}{1+\tfrac{\mathrm{orb}}4+\bigl(1+\tfrac{\mathrm{orb}}2\bigr)^2/(D-1-\mathrm{orb})},\qquad D=\dim\mathcal W_n,$$
the extra term being the Cauchy–Schwarz cost of $\mathop{\mathrm{tr}}(L_W)=0$. At $n=12$ with $\mathrm{orb}=66$ and $D=1638$ the denominator is $1+16.5+\tfrac{34^2}{1571}=18.2358$, reproducing the record's own "$18.2$ against $41.4$ at $n=12$" exactly. A bound from a strictly richer relaxation is of course allowed below the level-2 ceiling; there is no contradiction to exhibit.

**Opposite argued.** If one read $k_0$ in that sentence as the *multiplicity of $\theta/2$* rather than the orbit dimension, then $k_0>\binom n2$ is not absurd at all, §7 shows it happens. Either way the sentence fails.

## 7. What the ceiling actually is, and what the block sells it as

[ATTEMPTS.md](../ATTEMPTS.md) states the ceiling with the qualifier the block dropped:

> "Because $k_0\le\dim\mathfrak{so}(n)=\binom n2$, the method's **best conceivable** bound is $\lambda\le2-o(1)$ … **Unconditionally the orbit can be as small as $k_0=n-1$** …, degrading the bound to $O(\sqrt n)$."

The block writes "**the method's ceiling** is $\lambda\le2-o(1)$", and [results.md](../results.md) line 186 writes "landing $58.9\times$ short at $n=12$". Both read as *what the method delivers*. What the method delivers is governed by the **smallest** orbit among critical points, not the largest.

**Exhibited, in closed form, at the dimension the record names.** Padded $W_{\mathbb{CP}^2}$ is a local maximum at $n=8,10,12$ with orbit $\binom n2-4-\binom{n-4}2$, that is $34$ at $n=12$. The block's own inequality there gives
$$\theta^2\le\frac{253/4}{1+34/4}=\frac{253}{38},\qquad \theta\le\sqrt{253/38}=2.5803\ldots$$
**above $2$, at $n=12$, at a point the record calls a local maximum.** The balanced $S^6\times S^6$, stabiliser containing $O(6)\times O(6)$ of dimension $30$, has orbit $36$ and gives $\theta^2\le\tfrac{253/4}{10}=\tfrac{253}{40}$, $\theta\le2.5150$, a ratio $2.035$ to $\theta_0(12)$, matching [second-order.md](../findings/second-order.md)'s independently recorded "**exceeds $\theta_0(n)$ by about $2.0\times$ at sphere-product orbits and $1.5\times$ at trivial stabilisers**". So the $58.9\times$ figure is the trivial-stabiliser best case, and the shortfall at the objects the problem is actually about is roughly twice as large.

One correction to [ATTEMPTS.md](../ATTEMPTS.md) in passing: its witness for $k_0=n-1$ is "the $\mathbb R\times S^{n-1}$ Weyl tensor", and $\mathbb R\times S^{n-1}$ is conformally flat, so that Weyl operator is $0$ and is not a point of the unit sphere. The $O(\sqrt n)$ conclusion survives on a witness the record already carries, padded $W_{\mathbb{CP}^2}$, orbit $4n-14$, giving $\theta^2\lesssim\kappa_n/n\sim n/2$.

**The crossover $n=6+2\sqrt7$, which is the boundary the brief named.** $\theta_0(n)^2-\tfrac32=\tfrac{n^2-12n+8}{2n^2}$, so the block's denominator $\theta_0(n)-\sqrt{3/2}$ vanishes at $n=6+2\sqrt7=11.2915\ldots$ and is **negative for every $n\le11$**. Below the crossover the "excess" is a negative number and means nothing; at $n=12$ the denominator is $0.01129$, two orders below $\theta_0$. **$58.9\times$ is a near-pole value of a statistic whose pole sits three quarters of a unit below $n=12$**, and the same statistic is $3.09\times$ asymptotically. Reporting the $19\times$-inflated end of that range as the headline, in a landscape line that carries no denominator, is the defect [REVIEW_r596.md](../reviews/REVIEW_r596.md) called "load-bearing and undisclosed", and it is still undisclosed.

## 8. The refuted clause, and what is consumed

**The refutation.** "*Attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$*" is contradicted on file: [second-order.md](../findings/second-order.md) ("The multiplicity can exceed the orbit dimension), $18$ against $9$ at $S^3\times S^3$, and $60$ against $21$ at $S^2\times S^3\times S^3$, but the inclusion itself is a theorem." The orbit dimensions check by hand: at $n=6$, $\dim\mathfrak{so}(6)-\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(3))=15-6=9$; at $n=8$, $28-(1+3+3)=21$. ✔ The origin of the false clause is [ATTEMPTS.md](../ATTEMPTS.md)'s Result 3: "*Verified numerically that the multiplicity at the cap equals the orbit dimension*", an equality asserted from two families at three dimensions, where the elementary argument delivers only $\ge$.

**But the witnesses are out of scope of the cap.** [second-order.md](../findings/second-order.md) says "$S^3\times S^3$ **is not a local maximum** of $P$", with nine transverse Hessian null directions "along which $P$ increases at cubic order", and the $p=2$ sphere-product family "violates at excess $\tfrac1{2(n-3)}$". At **local maxima** the record says the opposite: "Excess is $0$ at every local maximum on record ($S^4\times S^4$, $S^6\times S^6$, $S^5\times S^7$, padded $W_{\mathbb{CP}^2}$ at $n=8,10,12$)", and it calls the remaining question sharp: "**is there a critical point satisfying both the second- and third-order conditions with positive excess?**" So:

- read at critical points (the block's own stated scope, "from criticality alone"), the clause is **REFUTED**, and Section C is right;
- read at local maxima (the scope the word "Peirce cap" imports), it is **UNRESOLVED**, and it is the record's own open question.

Section C's "refuted outright" flattens a distinction the record makes elsewhere in the same file. The block, by never stating its hypothesis, licenses both readings.

**What is consumed downstream: confirmed.** [second-order.md](../findings/second-order.md): "$\lambda=1$ **at least** once, at $e$ itself, $\lambda=\tfrac12$ on **at least** the orbit tangent" and "which is harmless for the bound, since it **uses them only as lower bounds** and the expression increases in each". ✔ The clause is load-bearing nowhere. Section C is right that it is harmless.

**And the same clause is what let $k_0$ carry two values.** The chain needs the $\theta/2$-**multiplicity** (from below); the ceiling needs the **orbit dimension** (from above, by $\binom n2$). The false "exactly" is precisely the identification of the two. Once it goes, $k_0\le\binom n2$ is a statement about the orbit only, and the multiplicity is **not** so bounded: $18>15=\binom62$ at $S^3\times S^3$. So "**a hard ceiling that no refinement of it escapes**" does not follow from $k_0\le\binom n2$ at all; a sharper lower bound on the multiplicity beats the stated ceiling, and the record exhibits one.

## 9. Completeness, and the precise sense of "wrong invariant" that survives

**The mathematics of Section C's rebuttal is correct as far as it goes.** At a local maximum with $\theta>0$: $L_W$ is symmetric, $L_WW=\theta W$, $L_W$ preserves $W^\perp$, and the cap puts the rest at $\le\theta/2<\theta$. Hence $\theta=\lambda_{\max}(L_W)$. The moments $\mathop{\mathrm{tr}}(L_W^k)$ determine the characteristic polynomial by Newton's identities, hence the spectrum, hence $\theta$. ✔ For a **known** $L_W$, the moment sequence is a complete invariant for $\theta$.

**And it is irrelevant to the method, for a reason the record itself supplies.** The method never has $L_W$; it has only those moments that are the *same at every critical point*, i.e. universal identities. [second-order.md](../findings/second-order.md):

> "**The moment method stops at two.** A third universal identity does not exist: $\theta^2\mathop{\mathrm{tr}}(L_e^3)$ takes the values $2.625$, $1.3125$, $-1.0$, $1.969$, $2.0$ and $5.906$ across the catalogue", with "$\theta^2\sum\lambda^3$ … $0.3125$ at $S^3\times S^3$ against $-1.5104$ at $\mathbb{CP}^3$, **same $n$ and same $\theta$**".

Two critical points at one $n$ with one $\theta$ and different third moments is a witness that no third universal identity exists. Given that, and given "**the bound is the exact optimum of its moment problem** … no moment-based sharpening exists", the closure claim has a real argument. **So the label "wrong invariant" is neither simply right nor simply backwards.**

**The statement that survives**, precisely:

> The only $O(n)$-universal spectral-moment identities for $L_W$ on $\mathcal W_n$ are $\mathop{\mathrm{tr}}(L_W)=0$, which is vacuous, and $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$, which is **constant on the unit sphere** and so carries nothing about $W$ beyond its norm. The exact optimum of the moment problem built from those two, together with the pinned multiplicities at $1$ and $\tfrac12$, lies above $\theta_0(n)$ at every $n$, by a factor tending to $\sqrt2$.

That is a Lemma-shaped claim resting on an Observation (the non-existence of a third identity, established by a measured pair). What does **not** survive is "spectral moments of $L_u$ are the wrong invariants for this problem" as a standalone: the moments are complete invariants; it is their *universality* that fails. Nor does "a hard ceiling that no refinement of it escapes", for two independent reasons, §8's multiplicity, and the block's own next clause, "the fourth moment reaches only $14\times$ **even granting an oracle**", which concedes that refinements move the number and merely reports where they land.

**The $14\times$ figure.** I could find no derivation, no displayed bound, and no source for it anywhere in the record; [ATTEMPTS.md](../ATTEMPTS.md)'s only level-4 result is about the span of quartic invariants of $W$, not about moments of $L_W$, and its margin table carries $49.7,\ 15.4,\ 7.0,\ 3.4$ at $n=12,14,20,100$, level-3 figures. `HYPOTHESIS-DEBT`.

**What the ceiling actually closes**, then: the level-2 universal relaxation, at even $n\ge6$, at critical points with maximal orbit. Not "the approach".

## 10. The traps, each answered by name

| trap | verdict |
| --- | --- |
| **$\ker W\ne0$ and padded objects** | **Hit.** The margin's denominator is built from padded $W_{\mathbb{CP}^2}$, and the same padded object is a local maximum whose orbit is $4n-14$, at which the block's inequality gives $\theta\le\sqrt{253/38}=2.58$ at $n=12$, above the printed ceiling. §7. |
| **Smallest admissible $n$** | **Hit.** No range is stated. $\mathcal W_n\ne0$ from $n=4$, where the module is not $SO(4)$-irreducible; the constant's derivation begins at $n=6$. §4. |
| **Odd $n$** | **Hit, and it is the parity split.** $\kappa_n$ is proven at even $n\ge6$, verified at odd $n\le13$, open at odd $n\ge15$, so the asymptotic ceiling has no proof along odd $n$. §4. |
| **The crossover $n=6+2\sqrt7$** | **Hit.** It is the zero of the block's undisclosed denominator; below it the "excess" is negative, and $n=12$ sits $0.71$ above it, which is why $58.9$ and $3.09$ differ by $19\times$. §7. |
| **A claim proven on a subfamily, used in general** | **Hit twice**, $\kappa_n$ at even $n$ used at all $n$; and the "exactly $\dim(O(n)\cdot u)$" clause, verified "at two families and three dimensions", stated universally and false. §4, §8. |
| **A hypothesis stated but never used** | **Hit.** The Peirce cap, H8, and $\mathop{\mathrm{tr}}(L_W)=0$, which the block displays and never consumes; the record's own level-3 bound is exactly what consuming it buys. §3, §6. |
| **A step using a hypothesis never stated** | **Hit seven times.** H1, H3–H7 and H11 in §1. |
| **A universal claim with no witness** | **Hit.** "a hard ceiling that no refinement of it escapes", refuted by the record's own $18>15=\binom62$ and by the block's own $14\times$ clause. §8, §9. Also [ATTEMPTS.md](../ATTEMPTS.md)'s $k_0=n-1$ witness, which is the zero Weyl operator. §7. |
| **An imported theorem whose hypotheses were never checked** | **Hit, and it is the named one.** "Peirce cap" imports Jordan-algebra language: for an idempotent $e$ in a *unital* Jordan algebra, $\sigma(L_e)\subseteq\{1,\tfrac12,0\}$ is a theorem holding at every idempotent. Here $Q(e)=e$ for $e=W/\theta$, but $\mathcal W_n$ under $\tfrac12(xy+yx)+x\# y$ has **no unit** and is not Jordan; the eigenvalues are not confined to $\{1,\tfrac12,0\}$, [second-order.md](../findings/second-order.md)'s own table at $S^3\times S^3$ reads $1,\tfrac12,\tfrac14,0,-\tfrac12$, and the $\le\tfrac12$ bound comes from second-order optimality (Krasnov–Tkachev Prop. 6.6), not from Peirce theory. The record concedes this implicitly by saying the cap needs local maximality; a genuine Peirce statement would not. The block never states the hypothesis it silently borrows. |
| **Symbol collisions** | **Hit four times.** Below. |

**The collisions, read in the record's senses.**

- **$B$.** The block's $B(u,H)$ is the polarisation of $Q$, a **fourth** sense, and a needless one, because [conventions.md](../findings/conventions.md) already names this operator: "$F_u(h)=\tfrac12(uh+hu)+u\#h$". Worse, the sense that *typechecks* against "$B(u,H)$" is the Killing form $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$, under which $L_u$ would be the rank-one map $H\mapsto(n-2)\mathop{\mathrm{tr}}(uH)$, with $\mathop{\mathrm{tr}}(L_u)=(n-2)\mathop{\mathrm{tr}}(u)$ and $\mathop{\mathrm{tr}}(L_u^2)=\bigl((n-2)\mathop{\mathrm{tr}}(u)\bigr)^2$, quartic in $u$, not quadratic. The collision is materially misleading, not cosmetic. The record's third sense, $B=\tfrac\theta2\mathrm{Id}-L_W$, is the *cap operator of this very block*, so the block and the conventions file use one letter for an object and for its own complement.
- **$\lambda$.** The block's $\lambda$ is the record's $\theta$; the record's $\lambda$ is a $\Lambda^2$ eigenvalue. Read in the record's sense, "a Peirce cap at $\lambda/2$ on $u^\perp$ … $\lambda^2(1+k_0/4)\le\ldots$ … $\lambda\le2-o(1)$ against a true $\sqrt2$" is a statement about $\Lambda^2$ eigenvalues and is unrelated to the conjecture.
- **$u$ against $W$.** The block uses **both letters for one object inside one sentence**: "the multiplication operator $L_u\colon H\mapsto B(u,H)$ gives $\mathop{\mathrm{tr}}(L_W)=0$, $\mathop{\mathrm{tr}}(L_W^2)=\ldots$, and a Peirce cap at $\lambda/2$ on $u^\perp$". Read in conventions' sense, $u$ is the padded $W_{\mathbb{CP}^2}$ at $\theta^*=\sqrt{3/2}$, a specific non-maximiser, and one that sits on the *other* side of the margin the block is computing.
- **$\kappa_n$.** Section C writes "$\kappa_n=(n-1)(2n-1)/4$" and confines its claim to "$n\ge12$", exactly the range in which conventions.md warns the *other* live $\kappa_n$ is negative, "same letter, same subscript, opposite sign, a factor of six hundred". Neither the block nor the annotation says which is meant.
- **$k_0$.** Undefined in the block, and it carries two values there: the orbit dimension (which the ceiling caps at $\binom n2$) and the $\theta/2$-multiplicity (which the inequality consumes). §8.

## 11. The split, by the record's own rule

`Lemma` asserts a proof, `Observation` asserts numerical verification at the dimensions named, `Conjecture` a candidate. The block does not split three ways; it splits at least eight.

| piece | correct label |
| --- | --- |
| $\mathop{\mathrm{tr}}(L_W)=0$; $\mathop{\mathrm{tr}}(L_WL_{W'})=\kappa_n\langle W,W'\rangle$ for *some* $\kappa_n$ | **Lemma**, all $n\ge5$, prior art, Fox Thm 1.3 |
| $\kappa_n=(n-1)(2n-1)/4$ | **Lemma at even $n\ge6$**; **Observation at $n=4,5,7,9,11,13$**; **open at odd $n\ge15$** |
| Orbit tangents are exact $\theta/2$-eigenvectors, at every nonzero critical point | **Lemma**, the one thing here that is fully proved on the record |
| $L_W|_{W^\perp}\preceq\theta/2$ at a local maximum | **Lemma**, prior art (Krasnov–Tkachev Prop. 6.6 = [L24](../findings/second-order.md)), **and not used by this block** |
| $\theta^2(1+k_0/4)\le\kappa_n$, $k_0=\dim(O(n)\cdot W)$ | **Lemma**, conditional on the row above it |
| $\theta\le2-o(1)$ as the **best conceivable** level-2 bound | **Lemma at even $n$**, once the qualifier is restored |
| "attained on a subspace of dimension **exactly** $\dim(O(n)\cdot u)$" | **refuted at critical points; Conjecture at local maxima**, the record's own open question |
| $58.9\times$, $3.09\times$ | **Corollary**, exact arithmetic from the row above, once the denominator is displayed |
| $49.7\times$, $15.4$, $7.0$, $3.4$ (level-3), $14\times$ (level-4) | **Observation at $n=12,14,20,100$**, by grid search on a bound this block never displays; the $14\times$ has **no source at all** |
| "spectral moments are the wrong invariants; the approach is closed" | **Lemma-shaped, resting on an Observation**, and its argument is in [second-order.md](../findings/second-order.md), not here |

## 12. What would break it, and what I did to look

- **The chain.** A critical point $W$ at some even $n\ge6$ with $\theta^2\bigl(1+\tfrac{\dim(O(n)\cdot W)}4\bigr)>\tfrac{(n-1)(2n-1)}4$. It cannot exist while $\kappa_n$ holds (the derivation in §3 is four lines and uses nothing else) so the only falsifier is $\kappa_n$ itself.
- **$\kappa_n$.** An odd $n\ge15$ at which $\mathop{\mathrm{tr}}(L_W^2)\ne\tfrac{(n-1)(2n-1)}4\lVert W\rVert^2$. **What I did:** read the even-$n$ derivation and found it parity-locked at its evaluation point, the balanced sphere product; read the record's own statement that a direct proof "requires evaluating $\lVert T\rVert^2$ … as a contraction" and that this is not done; read Fox's Remark 1.4 as the record quotes it, which leaves the constant open. **I ran nothing.** The debt is real and the falsifier is unexcluded.
- **The ceiling as a claim about the method.** A critical point with $\theta$ above $\sqrt{2(n-1)(2n-1)/(n^2-n+8)}$ would falsify it; a $\theta/2$-eigenspace of dimension above $\binom n2$ falsifies the *reasoning* rather than the bound. **Found**: $\dim E(\tfrac12)=18>15=\binom62$ at $S^3\times S^3$, on the record.
- **The ceiling as a bound the method delivers.** Any critical point with a small orbit. **Found**, in closed form: padded $W_{\mathbb{CP}^2}$ at $n=12$, orbit $34$, giving only $\theta\le\sqrt{253/38}=2.58$.
- **"No refinement escapes".** A third universal moment identity. **Found the record's witness against one** ($S^3\times S^3$ and $\mathbb{CP}^3$, same $n$, same $\theta$, third moments $0.3125$ and $-1.5104$), so this one holds, and it is the closure argument the block should have carried instead of the one it did.
- **The "at least" clause.** A critical point at which some orbit tangent fails to be a $\theta/2$-eigenvector. Impossible: the equivariance derivation in §3 is an identity with no hypothesis beyond $Q(gW)=gQ(W)$ and $Q(W)=\theta W$.

## Verdict

**`BROKEN`.**

Not because the mathematics is wrong (the displayed inequality is correct and its derivation is four lines) but because every layer the record wraps around it fails a check:

1. **The canonical entry states nothing**, in a record that withdrew the very next result for displaying no inequality.
2. **The block carries no proof**, which [INDEX-results.md](../findings/INDEX-results.md) already records and which is still true.
3. **The headline "ceiling" drops the qualifier "best conceivable"** and so asserts, of the method, something the record's own $O(\sqrt n)$ note and my padded-$W_{\mathbb{CP}^2}$ witness both contradict at $n=12$.
4. **The paragraph that settles the headline number contradicts itself**, through a find-and-replace of $49.7$ by $58.9$ that ran through the sentence explaining why $49.7$ was unreachable, and that explanation is itself an invalid inference, which applied to $\theta_0(12)$ would refute a critical point the record lists.
5. **The central constant is proven at even $n$ and used at all $n$**, with the asymptotic claim living entirely in the unproven parity.
6. **"The wrong invariant" is unsupported in the block and over-corrected in the annotation.** The surviving statement is about the second moment's *constancy* and the *non-existence of a third universal identity*, and it lives in another file.

The **repairs** are all edits and one derivation, and none needs a run: write the statement of §2 into [results.md](../results.md); transcribe the derivation of §3 into the block; restore "best conceivable" and display the $\mathrm{gap}^*$ denominator beside every margin; revert the mis-replaced sentence to $49.7$ and then strike it, since its inference is invalid either way; label by §11; and either evaluate $\lVert T\rVert^2$ directly or restrict every $\kappa_n$-dependent statement to even $n\ge6$.
