# Verifier v152, Lemma L35 ($\le2$ negative eigenvalues cap $\theta$ at $\sqrt{3/2}$), its $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$ chain, Lemma L42's dual weight, and the residual one-variable inequality

I read [BRIEF_L35.md](BRIEF_L35.md) cold and worked from [conventions.md](../findings/conventions.md) and the two statements it quotes, rebuilding every step I could reach from the definitions rather than from the surrounding prose. **No numerical work was done.** Every constant below is exact or is a hand screen of a claim I was about to record, reported as a screen and never as evidence for a positive claim: the four-figure decimals in §7 are arithmetic on closed forms I wrote out, done to check that a recorded number is the number the recorded formula produces, and they establish nothing on their own. Log: [agent_logs/verify-L35-v152.log](../agent_logs/verify-L35-v152.log).

## Claim table

| # | claim attacked | verdict | reason |
|---|---|---|---|
| 1 | The two forms of the statement differ (results.md carries no unit-norm hypothesis) | **CONFIRMED, the difference is vacuous** | $\theta=P/\lVert W\rVert^3$ is homogeneous of degree $0$, so the hypothesis normalises and does not restrict |
| 2 | The eigenframe identity $\theta=\sum\lambda^3+3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$, coefficient $3$, no Bianchi | **CONFIRMED** | $\langle W,W^\#\rangle=\tfrac12\sum_{\rm ordered}T\lambda\lambda\lambda$ and $T$ vanishes on repeats, so $\tfrac12\cdot6=3$; uses only symmetry of $W$ on $\Lambda^2$ |
| 3 | $G$'s closed form $\sum\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ | **REFUTED AS WRITTEN** | under the block's own reading of $\sum\lambda^3$ (three lines above, over **all** $\alpha$) it gives $8/(3\sqrt6)$ at $(2,-1,-1)/\sqrt6$ against $\theta=9/(3\sqrt6)$, the chain runs backwards at the equality point |
| 4 | $(+++)$ / $(+--)$ decoupling is an identity, not an inequality | **CONFIRMED** | the two blocks load disjoint pair-constraint sets and $(++-)$ is zeroed by sign at the maximum |
| 5 | Lemma L42: $3M(\lambda_P)\le h(s^2-u)$, constant unimprovable | **CONFIRMED** | dual is correct, $z=\tfrac h3\lambda_\alpha\lambda_\beta$ feasible, weak duality closes, and $t_{\alpha\beta\gamma}=2/(k-2)$ attains it for $k\ge3$ |
| 6 | $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$, $\sum_P\lambda^3\le A^3+\min(A,\sqrt d)d$, $d\le\sigma^2$ | **CONFIRMED** | each reproduces from the definitions in two lines; all three need $d=u-\lambda_1^2$, not either other sense of $d$ |
| 7 | $R(A,s,u)$ strictly increasing in $s$ and $u$, so $s^2=2-2u$, forcing $b=c$ | **CONFIRMED AS ALGEBRA** | $\partial_uR\ge\tfrac32s+2A>0$, $\partial_sR=2s\min(A,K_0\sqrt d)+6As+3bc>0$, and $s^2\le2-2u\iff(b-c)^2\ge0$ |
| 8 | The three regions cap at $1.017217$, $1.067666$, and an envelope peaking at $\sqrt{3/2}$ | **CONFIRMED AS ALGEBRA** | region I collapses to $5A(1-u)-(2-2u)^{3/2}/4$ and region II to $2A^3+A(5-6u)-(2-2u)^{3/2}/4$ exactly, both reproducing their maxima |
| 9 | The endpoint constants $g(A_0)=\sqrt6/2$, $g'(A_0)=0$, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$, $t^*=\sqrt2\varepsilon$, $\psi^*=\tfrac32\sqrt6\varepsilon^2$ | **CONFIRMED** | all five reproduce exactly by hand; the margin $\tfrac34\sqrt6$ is right |
| 10 | "$(b+c)^2+b^2+c^2\ge1$ **is Cauchy–Schwarz**", the record's own correction | **REFUTED AS ATTRIBUTED, CONFIRMED AS ALGEBRA** | the step is $\lVert\lambda_P\rVert_1\ge\lVert\lambda_P\rVert_2$; Cauchy–Schwarz gives $\lVert\lambda_P\rVert_1\le\sqrt k\lVert\lambda_P\rVert_2$, the opposite direction |
| 11 | "The cases of one and two positive eigenvalues close in closed form" | **CONFIRMED AS ALGEBRA, but the argument is in a review, and the canonical companion lemma says it is owed** | the $k=2$ reduction reconciles exactly with $G$ and maxes at $\sqrt{3/2}$; it appears only in [REVIEW_r63](../reviews/REVIEW_r63.md), while [L29](../findings/stratum-two-negative.md)'s block records it as owed and says L35 cannot discharge it |
| 12 | "unconditionally", the one-negative case | **HYPOTHESIS-DEBT (self-declared)** | the written chain presupposes two negative indices at four places; the closure argument is one line and is not written |
| 13 | The reduction from $G$ to $F(A)=g(A)+\psi^*(A)$ | **HYPOTHESIS-DEBT** | $R$, the region split, $\alpha,\beta,\gamma,T,K_0,\mathrm{FTP}$ appear nowhere in [findings/](../findings/) or [results.md](../results.md); the middle of the proof lives only in reviews |
| 14 | The residual $F\le\sqrt{3/2}$ on $(\tfrac13,A_0]$ | **NOT CHECKABLE HERE, certified numerics, as the block itself says** | $200$-bit interval arithmetic and branch-and-bound are open hypotheses to this loop |
| 15 | $\ker W\ne0$ | **CONFIRMED, no finding** | $G$ is supported on the nonzero eigenvalues, padding preserves $\theta$ and $\lVert W\rVert$, and zero indices contribute nothing to any block |
| 16 | Three incompatible tilings of $(0,A_0]$ in one file | **CONFIRMED as a record defect** | $(0,\tfrac13]/(\tfrac13,0.7]/(0.7,A_0]$, versus $(0,0.7096]/[0.7096,A_0]$, versus "$(\tfrac13,0.7096]$ by IA and $[0.7,0.7096]$ by bisection" |
| 17 | $\alpha,\beta,\gamma,T$ each carry two meanings inside this one lemma | **CONFIRMED, and not on the record** | they are the tensor indices and the tensor in the first half, the cubic's coefficients and the cap in the second |

## One-line summary

Every hand-checkable step of L35 is correct and I reproduced each one exactly, including the two region maxima and all five endpoint constants, but the block's own closed form for $G$ is false under the reading its own preceding display fixes, the "Cauchy–Schwarz" the record added as a correction points the wrong way, and the entire middle of the proof (the three-parameter relaxation and the region split) exists nowhere in [findings/](../findings/), so the canonical block is not a proof a reader can follow.

## 0. Conventions, fixed once

Quoted, not restated. From [conventions.md](../findings/conventions.md):

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$.

> The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is **[Lemma L31](../findings/stratum-two-negative.md)**, proved with its equality case characterised. The row marginal is **[Lemma L153](../findings/bounds.md)**, in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$ […] **The marginal has two readings and consumers use both**: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered pairs, $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=n-2$ over unordered, so convert before comparing constants.

> $A$, $d$, $G$, $A_0$ | in the two-negative relaxation: $A=\lambda_1$, $d=u-\lambda_1^2$, $G$ the pair-capped fractional triangle packing that the chain's bound **is**, and $A_0$ the interior maximiser of $g$. **None was defined in [findings/](.)** […] **$d$ collides with the negative-eigenvalue count in [bounds-relaxations.md](../findings/bounds-relaxations.md)**, under which reading [L35](../findings/stratum-two-negative.md)'s bound would read $h\le3/2$ and be vacuous

> $d$ | **three senses**: the distinct-eigenvalue count in [L104](../findings/bounds-relaxations.md), $\dim\mathfrak m$ in [L114](../findings/bounds-relaxations.md) of the same file, and $u-\lambda_1^2$ in [L35](../findings/stratum-two-negative.md).

> **Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this.

> hollow | […] **of a $3$-tensor**, vanishing whenever any two indices coincide, the sense [L104](../findings/bounds-relaxations.md) and [L35](../findings/stratum-two-negative.md) use

Notation used below, all of it from the block or from [REVIEW_r63](../reviews/REVIEW_r63.md): $P$ is the set of positive eigenvalues, $k=\lvert P\rvert$, $s=\sum_P\lambda$, $u=\sum_P\lambda^2$, $A=\lambda_1=\max P$, $d=u-A^2$, $\sigma=s-A$, $-b\le-c<0$ the two negatives, $K_0=\tfrac3{2\sqrt2}$, $T=\tfrac{2\sqrt2}3A$ (the cap on the auxiliary variable $t=\sqrt d$, **a second sense of the letter $T$**, see §9).

## 1. The hypothesis inventory

**A pass with no inventory is not a pass.** Three columns: what the hypothesis is, what object it is applied to, and whether the written proof uses it.

### 1a. Hypotheses the statement carries

| hypothesis | where stated | applied to | used? |
|---|---|---|---|
| $W\in\mathrm{Weyl}_m$ | both forms | the operator on $\Lambda^2\mathbb R^m$ | **only through $\mathop{\mathrm{tr}}W=0$ and symmetry.** First Bianchi is never used, the block says so, and I confirm it in §2. Ricci-flatness is never used either, and the block does not say so |
| $\lVert W\rVert=1$ | proof block only; **absent from [results.md](../results.md)** | normalising the spectrum | **used**, at the identity, at $bc=(s^2+u-1)/2$, and at $s^2\le2-2u$. The omission in results.md is harmless, see §3 |
| at most two negative eigenvalues | both forms | the $\Lambda^2$ spectrum | **used**, and the proof needs *exactly* two, see §11 |
| "at any number of positive ones" | both forms | $k\ge1$ | used; $k\le2$ and $k\ge3$ take different routes, and only the second is on file in [findings/](../findings/) |
| "at any $m$" | both forms | $m\ge4$; $\mathrm{Weyl}_m=0$ below | used only as *absence*: $G$ is free of $m$ and of $\binom m2$ |
| implicit: $W\ne0$ | nowhere | $\theta$ is $0/0$ at $W=0$, which has zero negative eigenvalues and so satisfies the stated hypothesis | not used, not needed, but the statement as written quantifies over an object where $\theta$ is undefined |
| implicit: eigenvalues counted **with multiplicity** | nowhere in either form | the negative-eigenvalue count | **used throughout.** [L33](../findings/stratum-two-negative.md) in the same file is *false* under the other reading, and its block says so; L35 inherits the same exposure, see §12 |

### 1b. Hypotheses of every imported theorem, checked against the object

| import | its hypotheses | the object here | verdict |
|---|---|---|---|
| **[L31](../findings/stratum-two-negative.md)** (pair cap $\le2$) | $X,Y$ **orthonormal** in $\mathfrak{so}(n)$, under $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$ | $v_\alpha,v_\beta$, two members of an orthonormal eigenbasis of the symmetric operator $W$ on $\Lambda^2\cong\mathfrak{so}(m)$ | **checks.** Orthonormality is all that is needed; nothing about the eigenvalues, so the cap holds on kernel directions too. Dimension-free: L31's $(s_1+s_2)^2\le2$ needs $\sum_is_i^2=1$ and nothing else |
| **[L153](../findings/bounds.md)** (row marginal) | $v\in\mathfrak{so}(n)$, $n\ge2$, summed over an orthonormal basis | the same eigenbasis; unordered reading $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=m-2$ | **checks, and the factor-$2$ conversion the block flags is correct.** Then **discarded**, see §5 |
| **[L42](../findings/stratum-two-negative.md)** (dual weight) | **at least three positives**, all strictly positive (the derivation divides by $\lambda_\alpha\lambda_\beta\lambda_\gamma$) | $\lambda_P$ at $k\ge3$ | **checks at $k\ge3$; undefined at $k\le2$**, where $h$ has no value and $M=0$. The block routes $k\le2$ elsewhere, see §11 |
| **envelope (Danskin)** | $\psi(t;A)$ jointly $C^1$, feasible set $[0,T(A)]$ with $T\in C^1$, maximiser unique | $\psi=\alpha t+\beta t^2+\gamma t^3$, $\gamma<0$, $\alpha>0$ on $A<A_0$ | **checks.** $\gamma<0$ and $\alpha>0$ make $\psi'$ a downward parabola with $\psi'(0)>0$, so exactly one positive critical point and it is the max, uniqueness holds, and the capped branch's extra term $\psi_t(T)T'$ is exactly the one Danskin adds |
| **Cauchy–Schwarz** |, | $(\sum_P\lambda)^2\ge\sum_P\lambda^2$ | **misattributed.** The inequality is true and elementary; Cauchy–Schwarz gives the reverse, see §10 |
| **L31's equality clause**, **[L29](../findings/stratum-two-negative.md)**, **[L30](../findings/stratum-two-negative.md)**, the descent | (|), | **not used by L35 at all.** The block says the descent was refuted and that this proof replaces it; I confirm no step of the chain calls any of them, except the $k\le2$ hand-off in §11 |

### 1c. Hypotheses the proof uses that the statement never states

| step | hypothesis it needs | stated? |
|---|---|---|
| $bc=(s^2+u-1)/2$, $s^2\le2-2u$ | **exactly two** negative eigenvalues, both nonzero | no, the statement says "at most two" |
| the $(+--)$ transport $2bc\lambda_1$ | two distinct negative **indices** | no |
| $R$'s monotonicity in $u$ | $s^2-u\ge0$ | no; it is true (§10) but is used unremarked |
| the convexity step $(X-2t^2)^{3/2}\ge X^{3/2}-3t^2\sqrt X$ | $X-2t^2\ge0$, i.e. $u\le1$ | no; it follows from unit norm |
| $\Sigma\lambda^3$ in $G$'s closed form | the sum ranges over the **positives only** | no, and the same paragraph fixes the opposite reading three lines earlier (§4) |

### 1d. Hypotheses stated and never used

- **The first Bianchi identity** (through $W\in\mathrm{Weyl}_m$). Self-flagged by the block, and correct: what is proved is the stronger statement about any trace-free symmetric operator on $\Lambda^2$.
- **Ricci-flatness.** Also unused, and *not* flagged. It is the hypothesis that carries [L29](../findings/stratum-two-negative.md), [L30](../findings/stratum-two-negative.md) and [L33](../findings/stratum-two-negative.md) in the same file, so its absence here is worth stating positively rather than leaving to inference.
- **The row marginal $m-2$** ([L153](../findings/bounds.md)). Stated, then discarded one clause later. Self-flagged, loudly, and the flag is right: I confirm in §5 that no later step reads it.

## 2. The eigenframe identity, and the claim that it needs no Bianchi, CONFIRMED

With $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ in an orthonormal eigenbasis of $\Lambda^2$ and $\#$ the halved Böhm–Wilking product of [conventions.md](../findings/conventions.md), $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$, bilinearity gives

$$W^\#=\tfrac12\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta\,[v_\alpha,v_\beta][v_\alpha,v_\beta]^{\mathsf T},\qquad \langle W,W^\#\rangle=\tfrac12\sum_{\alpha,\beta,\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\langle[v_\alpha,v_\beta],v_\gamma\rangle^2=\tfrac12\sum_{\alpha,\beta,\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma .$$

$T$ is totally symmetric and hollow in the $3$-tensor sense, so the ordered sum is $6\times$ the sum over $\alpha<\beta<\gamma$ and the coefficient is $\tfrac12\cdot6=3$. With $P(W)=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ and $\lVert W\rVert=1$,

$$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma .$$

**Nothing here uses the first Bianchi identity, Ricci-flatness, or any property of $W$ beyond symmetry on $\Lambda^2$ and an orthonormal eigenbasis.** The block's claim that it proves a stronger theorem than it states is CONFIRMED. The coefficient check at $(2,-1,-1)/\sqrt6$ also reproduces: $\sum\lambda^3=(8-1-1)/(6\sqrt6)=1/\sqrt6$ and $3T\lambda_1\lambda_2\lambda_3=3\cdot2\cdot2/(6\sqrt6)=2/\sqrt6$, summing to $3/\sqrt6=\sqrt{3/2}$.

## 3. The two forms of the statement, CONFIRMED, and the difference is vacuous

[results.md](../results.md) states L35 with no unit-norm hypothesis; the proof block states it with one and says the identity "requires $\lVert W\rVert=1$". Both are right, and they do not disagree:

$P$ is a cubic form and $\theta=P(W)/\lVert W\rVert^3$, so $\theta(cW)=\theta(W)$ for every $c>0$, **$\theta$ is homogeneous of degree $0$**. The conclusion $\theta\le\sqrt{3/2}$ is therefore invariant under rescaling, and the hypothesis $\lVert W\rVert=1$ selects a representative rather than restricting the claim. Every hypothesis and every conclusion is scale-invariant ("at most two negative eigenvalues" included), so the two statements have the same content on $W\ne0$.

**Where the norm is genuinely load-bearing is inside the proof**, and there the block is right to insist on it: the display $\theta=\sum\lambda^3+3\sum T\lambda\lambda\lambda$ is $P(W)$ and equals $\theta$ only at $\lVert W\rVert=1$; and both $bc=(s^2+u-1)/2$ and $s^2\le2-2u$ read the constant $1$ off $\sum\lambda^2=1$. So the correct account is *normalisation, used*, and the results.md form loses nothing.

**One residue.** Neither form excludes $W=0$, which has zero negative eigenvalues and therefore satisfies "at most two", and at which $\theta$ is undefined. The proof block's parenthesis ("zero negative eigenvalues is impossible by trace-freeness"), is true only for $W\ne0$.

## 4. $G$'s closed form is false under the reading the block's own display fixes, REFUTED AS WRITTEN

**Step 1, locate it.** The block writes, one paragraph after the identity:

> $G=\sum\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ with $bc=(s^2+u-1)/2$.

Three lines above, the same paragraph has fixed $\sum_\alpha\lambda_\alpha^3$ as the sum over **all** $\alpha$. The identical display appears again at [stratum-two-negative.md](../findings/stratum-two-negative.md) line 535 with the same ambiguity, and in [REVIEW_r62](../reviews/REVIEW_r62.md), where it is written $\sum_{\alpha\in P}\lambda_\alpha^3$, i.e. correctly.

**Step 2, exhibit the failure, in closed form.** Take padded $W_{\mathbb{CP}^2}$, spectrum $(2,-1,-1)/\sqrt6$: one positive, so $\mathrm{FTP}(\lambda_P)=0$; $s=\lambda_1=2/\sqrt6$, $u=2/3$, $b=c=1/\sqrt6$, $bc=1/6=(s^2+u-1)/2$ as the display requires. Reading $\sum\lambda^3$ over all eigenvalues:

$$G=\frac1{\sqrt6}+0-\frac{8}{6\sqrt6}+3\cdot\frac16\Big(\frac2{\sqrt6}+\frac4{\sqrt6}\Big)=\frac{6-8+18}{6\sqrt6}=\frac{8}{3\sqrt6},$$

against $\theta=3/\sqrt6=9/(3\sqrt6)=\sqrt{3/2}$. So $G<\theta$ **strictly**, at the exact point where the chain claims equality: the relaxation runs backwards, and $\theta\le G$ fails.

**Step 3, the charitable reading, and it repairs it.** Read $\sum\lambda^3$ over the **positives**. Then trace-freeness $s=b+c$ gives $-s^3+3bcs=-(b^3+c^3)$ identically, so the display is $\sum_{\rm all}\lambda^3+3M(\lambda_P)+6bc\lambda_1$, which is the honest object, and at the base point it returns $1/\sqrt6+0+6\cdot\tfrac16\cdot\tfrac2{\sqrt6}=3/\sqrt6=\sqrt{3/2}$ exactly. I checked the same reconciliation at general $k=2$ ($-6p^3+12bcp$ both ways with two equal positives $p$) and against [REVIEW_r63](../reviews/REVIEW_r63.md)'s independent $k=2$ parametrisation in §11; all three agree.

**Verdict.** REFUTED AS WRITTEN, with the repair known. **This is not a new finding**, [REVIEW_r570](../reviews/REVIEW_r570.md) states it, in the same words and with the same two repairs ("write $\sum_P\lambda^3$, or drop $-s^3+3bcs$"), and [INDEX-results.md](../findings/INDEX-results.md) row 35 records that audit as CONFIRMED. **The finding is that the repair was never applied**: both copies of the display in [stratum-two-negative.md](../findings/stratum-two-negative.md) still read $\sum\lambda^3$, and $\mathrm{FTP}$ is still a second symbol for L42's $M(\lambda_P)$. An audited defect that stays in the canonical block is worse than an unaudited one, because the next reader finds it confirmed and unfixed.

## 5. $\theta\le\mathrm{LP}\le G$: every relaxation points the enlarging way, CONFIRMED

- **$\theta\le\mathrm{LP}$.** $\mathrm{LP}$ maximises the same objective over all nonnegative, totally symmetric $t$ with row marginals $m-2$ (unordered) and pair caps $\le2$. The actual $T$ is nonnegative (a square), totally symmetric (ad-invariance makes $c_{abc}$ totally antisymmetric), meets the marginal by [L153](../findings/bounds.md) and the cap by [L31](../findings/stratum-two-negative.md). So $T$ is **feasible** and $\theta\le\mathrm{LP}$. Direction correct.
- **$\mathrm{LP}\le G$.** $G$ drops the marginals, enlarging the feasible set. Direction correct.
- **The marginal conversion.** [L153](../findings/bounds.md) gives $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(m-2)$ over ordered pairs; the block's display sums over $\beta<\gamma$, where the value is $m-2$. The block's own note is right and the factor $2$ is the reading.
- **"States the row marginal and then discards it."** CONFIRMED by inspection: after $G$ is formed, every step ($M$, the dual, $h$'s bounds, the region split, $F$) reads only nonnegativity, total symmetry and the pair caps. **The bound would survive [L153](../findings/bounds.md) being false.** The states-and-drops classification in L153's consumer table is correct.

**No finding on quantifier order here.** Both relaxations are "enlarge the feasible set of a maximum", the sup is taken once over the whole tensor and never distributed across the sign blocks, and the blocks are decoupled by §6 rather than by bounding each separately.

## 6. The decoupling is an identity, CONFIRMED

With exactly two negatives, indexed $N-1,N$, the sign blocks of $\sum_{\alpha<\beta<\gamma}$ are:

| block | pairs it loads | status |
|---|---|---|
| $(+++)$ | positive–positive pairs only | live; a pair-capped packing on $\lambda_P$ |
| $(++-)$ | mixed | coefficient $\lambda_p\lambda_q(-b)<0$ against $t\ge0$, so **zero at the maximum** |
| $(+--)$ | $(p,N-1)$, $(p,N)$, $(N-1,N)$ | live; worth $2bc\lambda_1$ before the factor $3$ |
| $(---)$ |, | empty: three distinct indices in a $2$-element set |

The $(+++)$ and $(+--)$ blocks load **disjoint** sets of pair constraints, so their maxima are attained simultaneously and $G$ is the sum, not a bound on the sum. **This is where "at most two negatives" is load-bearing**: at three negatives $(---)$ is live and the disjointness fails.

The $(+--)$ value: maximise $\sum_p t_{p,N-1,N}\lambda_p$ subject to the $(N-1,N)$ cap $\sum_p t_{p,N-1,N}\le2$, giving $2\lambda_1$; times $bc$ gives $2bc\lambda_1$, times $3$ gives $6bc\lambda_1$. The concentration $t_{1,N-1,N}=2$ also respects the caps on $(1,N-1)$ and $(1,N)$, which it saturates and which nothing else loads. **Feasible, so the value is attained.**

$bc=(s^2+u-1)/2$: from $s=b+c$ (trace-free) and $u+b^2+c^2=1$ (unit norm), $s^2=(1-u)+2bc$. Exact.

## 7. Lemma L42, the sharp dual weight, CONFIRMED, including its equality case

**The dual.** Each $t_{\alpha\beta\gamma}$ appears in exactly the three pair constraints $(\alpha\beta),(\beta\gamma),(\alpha\gamma)$, each with right-hand side $2$; so the dual of $\max\sum t\lambda\lambda\lambda$ is $\min2\sum_{\alpha<\beta}z_{\alpha\beta}$ subject to $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$, $z\ge0$. As written.

**Feasibility.** $z_{\alpha\beta}=c\lambda_\alpha\lambda_\beta$ turns the triple constraint, after division by $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$, into $c(\lambda_\alpha^{-1}+\lambda_\beta^{-1}+\lambda_\gamma^{-1})\ge1$, i.e. $c\ge\tfrac13H(\alpha,\beta,\gamma)$ since $\sum\lambda^{-1}=3/H$. $H$ is increasing in each argument, so the binding triple is the three largest and $c=h/3$ is feasible. Correct as written.

**Weak duality.** $M\le2\cdot\tfrac h3\cdot\tfrac{s^2-u}2=\tfrac h3(s^2-u)$, i.e. $3M\le h(s^2-u)$. Correct.

**Sharpness.** With $k$ equal positives $\lambda$: $h=\lambda$, $s^2-u=k(k-1)\lambda^2$, bound $3M\le k(k-1)\lambda^3$. The maximiser $t_{\alpha\beta\gamma}=2/(k-2)$ on every triple has pair marginal $(k-2)\cdot\tfrac2{k-2}=2$ (feasible) and $\sum t=\binom k3\tfrac2{k-2}=k(k-1)/3$, so $3M=k(k-1)\lambda^3$ exactly. **Equality holds for every $k\ge3$**, including $k=3$ where $t=2$ on the single triple. The constant is unimprovable, as claimed.

**The $k\le2$ edge, which the brief names.** At $k\le2$ there are no triples, $M=0$, and $h$ is genuinely undefined, the derivation divides by $\lambda_\alpha\lambda_\beta\lambda_\gamma$ over a triple that does not exist. L42's block states the hypothesis; **L35's block does not**, saying only that "the closing lemma is the sharp dual weight" and, four lines later, that $k\le2$ closes separately. The hand-off is correct but is never stated as a hypothesis of the step. See §11 for what the $k\le2$ branch actually rests on.

**The superseded gloss.** The block's own line, the dual $z=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ "is feasible exactly when $\mu$ is at least the triple's harmonic mean", is the form [Reviewer 84](../reviews/REVIEW_r84.md) refuted, and the refutation is right: in that normalisation $c=\tfrac32\mu$ so the threshold is $\mu\ge\tfrac29H$, and $\mu=h$ gives a bound $\tfrac92$ times weaker. **The L35 block still carries the refuted gloss as its statement of the closing lemma**, with the correction living 70 lines below in a different section. The boxed inequality it lands on is nevertheless the correct one.

## 8. The three elementary bounds, and the reduction to two variables, CONFIRMED AS ALGEBRA

Each reproduces from the definitions, and each needs $d=u-\lambda_1^2$ and no other sense of $d$.

- **$h\le\lambda_1$.** The harmonic mean of three numbers is at most their maximum, which is at most $\lambda_1$.
- **$h\le\tfrac3{2\sqrt2}\sqrt d$.** Dropping $\lambda_1^{-1}$ from $\sum\lambda^{-1}$ gives $h\le3\lambda_2\lambda_3/(\lambda_2+\lambda_3)\le\tfrac32\sqrt{\lambda_2\lambda_3}$ by AM–GM, and $\lambda_2^2+\lambda_3^2\le d$ forces $\lambda_2\lambda_3\le d/2$, so $h\le\tfrac32\sqrt{d/2}=K_0\sqrt d$ with $K_0=\tfrac3{2\sqrt2}$. Exact, equality at $\lambda_2=\lambda_3=\sqrt{d/2}$ with $\lambda_1\to\infty$.
- **$\sum_P\lambda^3\le A^3+\min(A,\sqrt d)\,d$.** $\sum_{i\ge2}\lambda_i^3\le\lambda_2\sum_{i\ge2}\lambda_i^2=\lambda_2d$ and $\lambda_2\le\min(A,\sqrt d)$.
- **$d\le\sigma^2$.** $(\sum_{i\ge2}\lambda_i)^2\ge\sum_{i\ge2}\lambda_i^2$ for nonnegative entries.

**The symbol-collision check the brief asks for.** All four of these read $d=u-\lambda_1^2$. Under [conventions.md](../findings/conventions.md)'s first sense, the distinct-eigenvalue count of [L104](../findings/bounds-relaxations.md), the second bound would read $h\le K_0\sqrt d$ with $d$ a small integer and would be vacuous, exactly as the convention table warns. The block gives the reader no way to tell which sense is meant; nothing in [findings/](../findings/) defines $d$ at the point of use, and the definition reached the convention table only after [REVIEW_r570](../reviews/REVIEW_r570.md) found it in a script docstring.

**Assembling.** $G\le R(A,s,u):=A^3+\min(A,\sqrt d)d+\min(A,K_0\sqrt d)(s^2-u)-s^3+3bc(s+2A)$.

**Monotonicity, checked term by term.** With $A$ fixed and $d=u-A^2$, $bc=(s^2+u-1)/2$:

$$\partial_uR\ \ge\ 0\;-\;\min(A,K_0\sqrt d)\;+\;\tfrac32(s+2A)\ \ge\ -A+\tfrac32s+3A\ =\ \tfrac32s+2A\ >\ 0,$$

the first term because $\min(A,\sqrt d)d$ is nondecreasing in $d$, the second because $\min(A,K_0\sqrt d)$ is nondecreasing in $u$ while $s^2-u\ge0$ (§10) so only the $-1$ from $\partial_u(s^2-u)$ can hurt. And

$$\partial_sR=2s\min(A,K_0\sqrt d)+\partial_s\big[-s^3+3bc(s+2A)\big]=2s\min(A,K_0\sqrt d)+6As+3bc>0,$$

since $\partial_s[-s^3+3bcs]=-3s^2+3s^2+3bc=3bc$ and $\partial_s[6Abc]=6As$. Both reproduce the recorded expressions exactly. The functions are continuous and piecewise $C^1$ with each piece monotone, which is enough.

**The constraint that binds.** $s^2\le2-2u$ is equivalent to $2bc\le b^2+c^2$, i.e. $(b-c)^2\ge0$, with **equality exactly at $b=c$**, so "forcing both to the constraint forces $b=c$" is correct. Raising $u$ at fixed $A,s$ preserves $d\ge0$, $A\le s$ and $bc\ge0$, so from any feasible point the boundary is reachable and the maximum sits there. The quantifier order is sound: this is one maximum over a two-dimensional face, not two separate suprema.

## 9. The three regions, CONFIRMED AS ALGEBRA, both closed-form maxima reproduced

On $s^2=2-2u$, $b=c$, so $-s^3+3bcs=-s^3/4=-(2-2u)^{3/2}/4$ and $6Abc=3A(1-u)$. Then

$$R_2(A,u)=A^3+\min(A,\sqrt d)d+\min(A,K_0\sqrt d)(2-3u)-\tfrac14(2-2u)^{3/2}+3A(1-u).$$

- **Region I, $d>A^2$** (so both minima are $A$). Collecting: $A^3+A(u-A^2)+A(2-3u)+3A(1-u)=5A(1-u)$, giving $R_2=5A(1-u)-\tfrac14(2-2u)^{3/2}$ **exactly** as recorded, under $A\le\sqrt{u/2}$ (from $u-A^2>A^2$). Increasing in $A$, so $A=\sqrt{u/2}$; screening the resulting one-variable function reproduces $\approx1.0172$ near $u=0.435$, matching the recorded $1.017217$.
- **Region II, $\tfrac89A^2<d\le A^2$** ($\min(A,\sqrt d)=\sqrt d$, $\min(A,K_0\sqrt d)=A$). $R_2=A^3+d^{3/2}+A(5-6u)-\tfrac14(2-2u)^{3/2}$, and $d^{3/2}\le A^3$ gives the recorded $2A^3+A(5-6u)-\tfrac14(2-2u)^{3/2}$ under $A\le3\sqrt{u/17}$ (from $\tfrac{17}9A^2<u$). Screening at the boundary reproduces $\approx1.0668$ near $u=0.45$, matching $1.067666$. The region condition $K_0\sqrt d\le A\iff d\le\tfrac89A^2$ is right: $K_0^2=\tfrac98$.
- **Region III, $0<d\le\tfrac89A^2$.** Put $t=\sqrt d$, $u=A^2+t^2$. Both minima become $\sqrt d$ and $K_0\sqrt d$. The convexity step $(X-2t^2)^{3/2}\ge X^{3/2}-3t^2\sqrt X$ at $X=2-2A^2$, valid because $y\mapsto(X-y)^{3/2}$ is convex, so it lies above its tangent at $y=0$, and $X-2t^2=2(1-u)\ge0$, yields $R_2\le g(A)+\psi(t)$ with

$$g(A)=A^3-\tfrac1{\sqrt2}(1-A^2)^{3/2}+3A(1-A^2),\quad \alpha=K_0(2-3A^2),\ \beta=\tfrac34\sqrt{2-2A^2}-3A,\ \gamma=1-3K_0<0,$$

and cap $t\le T=\tfrac{2\sqrt2}3A$. I derived all four coefficients independently and they match. $\tfrac14(2-2u)^{3/2}$ at $t=0$ is $\tfrac1{\sqrt2}(1-A^2)^{3/2}$, so $g$ is exactly $R_2$ on the $k=1$ face $d=0$.

**The $A>A_0$ branch, closed analytically, CONFIRMED.** $\alpha\le0\iff A^2\ge\tfrac23$; $\beta<0$ for $A\ge\tfrac13$; $\gamma<0$ always. So $\psi\le0$ and $R_2\le g(A)$. And $g'(A)=3-6A^2+\tfrac3{\sqrt2}A\sqrt{1-A^2}$ is positive at $A=0.8$ and negative at $A=0.83$, with $g'(A_0)=0$, so $A_0$ is the unique root in range and $g\le g(A_0)=\sqrt{3/2}$ there. The recorded alternative form $g'=3-6A^2+\tfrac32A\sqrt{2-2A^2}$ is the same function.

**The symbol collision inside the lemma, a finding.** In the first half of the block $\alpha,\beta,\gamma$ are the tensor indices of $T_{\alpha\beta\gamma}$ and $T$ is the bracket tensor. In the second half $\alpha,\beta,\gamma$ are the coefficients of the cubic $\psi$ and $T$ is the cap $\tfrac{2\sqrt2}3A$. Both senses of all four letters appear in the same file, within eighty lines, and **[conventions.md](../findings/conventions.md) tables neither second sense**; its $\psi$ entry names a different object again ("the polarisation"). The letter $t$ carries three senses across the same material: the packing variable $t_{\alpha\beta\gamma}$, the auxiliary $\sqrt d$, and [L29](../findings/stratum-two-negative.md)'s ratio $b/a$. [LEDGER.md](../findings/LEDGER.md) records these symbols as *undefined*; it does not record that they are *collisions*.

## 10. "Cauchy–Schwarz", REFUTED AS ATTRIBUTED, CONFIRMED AS ALGEBRA

**Step 1, locate it.** The block's own list of corrections:

> *(i)* $(b+c)^2+b^2+c^2\ge1$ **is Cauchy–Schwarz** ($(\sum_P\lambda)^2\ge\sum_P\lambda^2$ with trace-freeness and unit norm), true of any two-negative spectrum, Weyl or not, and both reviewers said so independently.

The same attribution appears as L5 in [REVIEW_r63](../reviews/REVIEW_r63.md): "$d\le\sigma^2$ (Cauchy–Schwarz on the non-leading positives)".

**Step 2, exhibit the failure.** Cauchy–Schwarz against $\mathbf1$ gives $\big(\sum_{i=1}^k\lambda_i\big)^2\le k\sum_{i=1}^k\lambda_i^2$, an **upper** bound on $s^2$ by $u$. The step needs $s^2\ge u$, the opposite direction. At $k=3$, $\lambda=(1,1,1)$: Cauchy–Schwarz says $9\le9$, and at $\lambda=(2,1,1)$ it says $16\le18$, in neither case does it deliver $s^2\ge u$. What does deliver it is $\big(\sum\lambda\big)^2=\sum\lambda^2+2\sum_{i<j}\lambda_i\lambda_j\ge\sum\lambda^2$, positivity of the cross terms, valid only because the $\lambda_i$ are nonnegative, i.e. $\lVert\lambda\rVert_1\ge\lVert\lambda\rVert_2$ on the nonnegative orthant. The named import is not merely a different proof of the same thing; **it is an inequality in the opposite direction, and it is the only justification the record offers for the step.**

**Step 3, the most charitable reading.** "Cauchy–Schwarz" is sometimes used loosely for the whole power-mean family, and one can reach $s^2\ge u$ from $\lVert\lambda\rVert_2\le\lVert\lambda\rVert_1$, which is a norm-monotonicity statement rather than an inner-product bound. On any reading, the direction Cauchy–Schwarz supplies is $s^2\le ku$, so the citation cannot be made to yield the step. **The inequality is true and elementary; nothing downstream fails.**

**Why this matters more than a name.** The attribution was *added by an audit as a correction* (the block records it as one of "three claims corrected" by Gate 2) so the record has replaced an admittedly wrong justification ("credited to the curvature identity") with a second wrong one, and stamped it corrected. The positive statement is: the step is positivity of the cross terms on a nonnegative spectrum, and it needs nonnegativity, which is exactly the hypothesis $\lambda_P>0$.

## 11. $k\le2$, the argument is correct, and it is not where the record says it is

**Step 1, locate it.** The block closes with "The cases of one and two positive eigenvalues close in closed form. $\square$", and cites nothing. The natural referent is [L29](../findings/stratum-two-negative.md), whose own canonical block says:

> **It reaches $k=2$ as well, and the reason first given for stopping at $k=1$ is wrong on both counts**, *though the two-parameter maximisation that carries the $k=2$ claim appears on no site, here or elsewhere, and is owed; [Lemma L35](../results.md) cannot discharge it, its own proof consuming this lemma at $k\le2$.*

So the record contains an explicit circularity warning: L35 leans on L29 at $k\le2$, and L29 says the $k=2$ half of itself is owed and that L35 cannot supply it.

**Step 2, where the argument actually is, and whether it closes.** [REVIEW_r63](../reviews/REVIEW_r63.md) §(i) carries it. I reconstructed it from the definitions and it closes exactly. Writing $q=bc$ (**not** $\lambda_1\lambda_2$, the review's parametrisation only makes sense under $q=bc$, which I confirmed by matching its $\lambda_1=\tfrac12(s+\sqrt{2-3s^2+4q})$ against $\lambda_1\lambda_2=\tfrac12(2s^2-1-2q)$):

$$\textstyle\sum_P\lambda^3=s^3-3\lambda_1\lambda_2s=-2s^3+\tfrac32s+3qs,\qquad -b^3-c^3=-s^3+3qs,$$

so $G=\sum_P\lambda^3-b^3-c^3+6\lambda_1bc=6q(s+\lambda_1)-3s^3+\tfrac32s$, **exactly the review's display**, a third independent confirmation that $\sum\lambda^3$ in §4 must range over the positives. $G$ increases in $q$, so $q=\min(s^2/4,\,s^2-\tfrac12)$, the first branch holding for $s^2\ge\tfrac23$. There $\lambda_1=\tfrac12(s+\sqrt{2-2s^2})$ and

$$G=-\tfrac34s^3+\tfrac34s^2\sqrt{2-2s^2}+\tfrac32s,$$

whose derivative at $s^2=\tfrac23$ is $-\tfrac32\cdot\tfrac23+\tfrac34[2s\cdot s-2s^3/s]+\tfrac32=0$ exactly (using $\sqrt{2-2s^2}=s$ there) and whose value is $-\tfrac12\sqrt{\tfrac23}\cdot\ldots=\sqrt{3/2}$ exactly. On the other branch $q=s^2-\tfrac12$ forces $\lambda_1\lambda_2=0$, i.e. $k=1$, and $G=9s^3-\tfrac92s$, increasing to $\sqrt{3/2}$ at $s=\sqrt{2/3}$. **So $k\le2$ closes in exact closed form, with supremum $\sqrt{3/2}$ attained only in the $k\to1$ degeneration.** Every constant reproduces.

**Step 3, the charitable reading.** One could read L35's sentence as citing r63 rather than L29. But reviews are not canonical here, [results.md](../results.md) and [findings/](../findings/) carry no $k\le2$ argument for L35, and L29's canonical block (the only numbered result in scope), states the claim is owed. **The finding is provenance, not mathematics**: a step of a canonical proof whose only argument lives in a review, cited against a lemma that disclaims it. The repair is to move r63's $k\le2$ computation into [stratum-two-negative.md](../findings/stratum-two-negative.md) and strike the "owed" clause from L29, or to have L35 cite the review by name.

## 12. "Unconditionally", the one-negative case, and the multiplicity convention

**12a. Exactly one negative eigenvalue, HYPOTHESIS-DEBT, self-declared.** The block says the case "is the $c\to0$ boundary and is owed a line". I confirm the debt is real and locate exactly where the written chain presupposes two negatives: the $(+--)$ block (needs two distinct negative indices), $bc=(s^2+u-1)/2$, the disjointness in §6, and "forcing $s^2=2-2u$ forces $b=c$", which at $c=0$ would force $b=0$ and hence $W=0$, so **the one-negative locus is not on the face the maximisation is carried out on; it sits strictly inside $\{s^2<2-2u\}$.** The block's phrase "the $c\to0$ boundary" is a statement about the closure of the two-negative family, not about the constraint face, and the two are different objects. **I do not supply the line.** What is owed, stated exactly: that $G$ is continuous on the closed parameter region and that every one-negative spectrum is a limit of two-negative ones under the constraints $\sum\lambda=0$, $\sum\lambda^2=1$, after which $\sup G$ over the closure covers it. Until that is written, "unconditionally" in the title overstates what the block proves.

**12b. Multiplicity, a statement-scope finding.** Neither form of L35 says whether "at most two negative eigenvalues" counts with multiplicity. The proof needs the count **with multiplicity**: it works with two negative *basis vectors*. This is the exact ambiguity that made [L33](../findings/stratum-two-negative.md) false as quoted, and that file records the lesson in bold ("This file's own convention counts with multiplicity, so the statement was correct in place) and it is quoted in [results.md](../results.md) and in the report, where that convention does not travel." **L35 is quoted in [results.md](../results.md) with the same exposure and no such note.** Under a distinct-values reading the statement would admit, for instance, $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)/(2\sqrt3)\in\mathrm{Weyl}_4$, whose spectrum $(2,2,-1,-1,-1,-1)/(2\sqrt3)$ has one distinct negative value at multiplicity four and which the chain does not touch.

**Screened, and it is not a falsifier.** On $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ the two summands commute, so $T_{\alpha\beta\gamma}=0$ whenever the indices straddle $\Lambda^\pm$ and $P$ decouples across the halves. Each half is a scaled $(2,-1,-1)/\sqrt6$ at norm $1/\sqrt2$, so $P=2\cdot(1/\sqrt2)^3\sqrt{3/2}$ and $\theta=\sqrt{3/2}/\sqrt2=\sqrt3/2\approx0.866$, below the bound. Reported as a screen; it settles this one object and nothing more. **The finding is that the statement's scope depends on a convention stated in neither place it is written.**

## 13. The residual inequality $F=g+\psi^*\le\sqrt{3/2}$, not checkable in this loop, and the file tiles it three ways

**13a. What I could check, and it all reproduces exactly.**

| constant | recorded | my derivation |
|---|---|---|
| $g(A_0)$, $A_0=\sqrt{2/3}$ | $\sqrt6/2$ | $\tfrac{2\sqrt6}9-\tfrac{\sqrt6}{18}+\tfrac{\sqrt6}3=\tfrac{\sqrt6}2$ ✓ |
| $g'(A_0)$ | $0$ | $3-4+\tfrac3{\sqrt2}\sqrt{\tfrac23}\sqrt{\tfrac13}=-1+1=0$ ✓ |
| $-\tfrac12g''(A_0)$ | $\tfrac94\sqrt6$ | $g''(A_0)=-4\sqrt6-\tfrac{\sqrt6}2=-\tfrac92\sqrt6$ ✓ |
| $t^*$ | $\sqrt2\,\varepsilon$ | $\alpha/(2\lvert\beta\rvert)=3\sqrt3\varepsilon/(\tfrac32\sqrt6)=\sqrt2\varepsilon$ ✓ |
| $\psi^*$ | $\tfrac32\sqrt6\,\varepsilon^2$ | $\alpha^2/(4\lvert\beta\rvert)=27\varepsilon^2/(3\sqrt6)=\tfrac32\sqrt6\varepsilon^2$ ✓ |
| endpoint margin | $\tfrac34\sqrt6$ | $\tfrac94\sqrt6-\tfrac32\sqrt6=\tfrac34\sqrt6$ ✓ |
| $\beta=0$ at $A=\tfrac13$ | exact | $\sqrt{2-2A^2}=4A\iff A^2=\tfrac19$; $\beta(\tfrac13)=\tfrac34\cdot\tfrac43-1=0$ ✓ |
| the $(0,\tfrac13]$ cap $\tfrac89$ | $\le\tfrac89$, peaking at $A=\tfrac13$ | at $A=\tfrac13$: $g=\tfrac13$, $\alpha=\tfrac{5}{3}K_0$, $T=\tfrac{2\sqrt2}9$, so $g+\alpha T+\beta T^2=\tfrac13+\tfrac59=\tfrac89$ **exactly** ✓ |
| $\alpha'=-\tfrac{9\sqrt2}2A$, $\beta'=-\tfrac{3\sqrt2A}{4\sqrt{1-A^2}}-3$, $T'=\tfrac{2\sqrt2}3$ |, | all three reproduce ✓ |
| the $C^1$ branch switch | $\psi_t(A_{\rm sw},T)=0$ | correct by the definition of $t_c$; screening $\psi'(T)$ at $A=0.4463$ gives $9\times10^{-4}$, so the recorded switch point is right to four figures ✓ |
| middle-band maximum $1.203230$ | branch-and-bound $[1.20322955981,1.20322956076]$ | evaluating $F$ by hand at $A=0.7$ gives $1.156462+0.046768=1.203230$ ✓, the recorded maximum is $F$ at the band's right endpoint |

Screened at four interior points ($A=0.2,0.5,0.65,0.78$), $F$ rises monotonically toward $F(A_0)=\sqrt{3/2}$ with margins $0.93,0.13,0.042,0.0023$ and no spike. **Reported as a screen only.** It is consistent with the recorded certification of $F'>0$ and establishes nothing.

**13b. What I cannot check.** $200$-bit interval arithmetic, branch-and-bound over $73+21=94$ boxes, and bisection on $[0.7,0.7096]$ are open hypotheses to this loop, exactly as "verified at $n=12,14,16$" is. The block says so itself, "That is rigorous and it is **not hand-checkable**, so this result is a proof with a certified numerical step rather than one a reader can follow end to end", and that self-assessment is accurate and is the right thing for the record to carry.

**13c. Three incompatible tilings of $(0,A_0]$ in one file, a finding.** The same interval is decomposed three ways, and no passage says which is operative:

| passage | tiling |
|---|---|
| the L35 block, "residual inequality is closed" | $(0,\tfrac13]$ closed form; $(\tfrac13,0.7]$ cubic retained; $(0.7,A_0]$ endpoint expansion |
| the L35 block, "what closes symbolically" | $(0,\tfrac13]$ and the endpoint in closed form; $(\tfrac13,0.7096]$ by interval arithmetic; $[0.7,0.7096]$ by bisection |
| "Gate 2 landed (Reviewer 64)" | $(0,0.7096]$ in $73$ boxes; $Q<0$ on $[0.7096,A_0]$ in $21$ |

The regions table then marks $(0.7,A_0]$ with margin $\tfrac34\sqrt6$ while the row's own text withdraws the argument that margin came from. And $[0.7,0.7096]$ is claimed both inside the interval-arithmetic band and as needing separate bisection. **Not a mathematical defect** (belt and braces is legitimate) but the block does not state which decomposition a reader is meant to check, and one of the three names an argument the file has withdrawn.

### Withdrawn candidates

Three candidates I opened and closed, recorded so the next verifier does not spend an adjudication on them.

- **"$F'>0$ certified on $[10^{-12},0.8164]$ stops short of $A_0=0.816497$."** Located; the gap is $5\times10^{-5}$ wide and no argument covers it by monotonicity. **Withdrawn**: the bound on $[0.7096,A_0]$ comes from the $Q<0$ certificate, not from monotonicity, so the gap carries no weight.
- **"Bisection certifies nothing."** Located at "$[0.7,0.7096]$ goes to direct bisection instead"; bisection is a root-finder and proves no strict inequality on an interval. **Withdrawn** under step 3: the surrounding text is explicit about $200$-bit interval arithmetic with branch-and-bound, and "bisection" plainly means interval bisection within that scheme.
- **"$R$'s feasible box may be smaller than the realisable set, making $R\ge G$ fail."** Located at the monotonicity argument. **Withdrawn**: raising $u$ at fixed $A,s$ preserves $d\ge0$, $bc\ge0$ and $A\le s$, so the face $s^2=2-2u$ is reachable from every feasible point and the box only ever enlarges.

## 14. $\ker W\ne0$, the smallest $m$, odd $m$, and the structured families

**$\ker W\ne0$, no finding, and this is the rare place where the record's recurring obstruction does not bite.** A zero eigenvalue contributes nothing to $\sum\lambda^3$ and zeroes every triple containing its index, $G$ is "supported on the nonzero eigenvalues alone" as the block says, and [conventions.md](../findings/conventions.md) records that padding preserves both $\lVert W\rVert$ and $\theta$. So the statement at a padded object is the statement at its unpadded core, and the bound transports. **The sharp case is itself a padded object**: padded $W_{\mathbb{CP}^2}$ has $\ker W$ of dimension $\binom m2-3$, so the equality point of L35 lives entirely inside the degenerate locus, and the lemma is *tested* at $\ker W\ne0$ rather than blind to it. The one place a kernel could have mattered (the pair cap on a pair of kernel eigenvectors), is fine, since [L31](../findings/stratum-two-negative.md) reads only orthonormality.

**Smallest admissible $m$, no finding.** $\mathrm{Weyl}_m=0$ for $m\le3$; at $m=4$, $N=6$, the marginal is $m-2=2$, L31 needs two singular-value pairs and has them, and the bound is attained. The block's "content and sharpness both begin at $m=4$" is right.

**Odd $m$, no finding.** Nothing in the chain reads the parity of $m$; $G$ is free of $m$ and of $\binom m2$ altogether. The parity traps in this record ($\theta_0$ versus $\Theta_n$) enter through the *target* constant, not through L35's bound, and L35's own consumer statement (that $\sqrt{3/2}<\Theta_n$ from $n=12$ at both parities), is [L29](../findings/stratum-two-negative.md)'s clause, not L35's.

**Structured families, tried one at a time.**

| family | negatives | consistent with L35? |
|---|---|---|
| padded $W_{\mathbb{CP}^2}$, $(2,-1,-1)/\sqrt6$ | $2$ | **the equality case**: $\theta=\sqrt{3/2}$ exactly, so the bound is attained inside the stratum and cannot be lowered |
| the one-parameter family $W^+=\mathop{\mathrm{diag}}(q+r,-q,-r)$, $W^-=0$ | $2$ | in the stratum at every $q,r>0$, with $\theta=9qr(q+r)/\lVert W\rVert^3$ maximised at $q=r$, the L29 slice of the same locus |
| $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$ | $4$ with multiplicity | outside the statement; screened at $\theta=\sqrt3/2$, below (§12b) |
| balanced $S^6\times S^6$ at $n=12$ | the Weyl operator has two distinct eigenvalues, on blocks of dimension $m^2=36$ and $m(m-1)=30$ | **the sharpest available consistency test.** $\theta=\Theta_{12}=\theta_0(12)$, $\theta_0(12)^2=\tfrac{220}{144}$, so $\theta_0(12)=1.2360\ldots>\sqrt{3/2}=1.2247\ldots$. L35 therefore **requires** this object to carry at least three negative eigenvalues, and whichever of its two blocks is the negative one it carries at least $30$. The test passes with enormous margin, and it is exactly the test that would have caught a false L35 |
| diagonal (coordinate-diagonal) $W$ at $n\ge12$ |, | same argument: $\Theta_n>\sqrt{3/2}$ from $n=12$, so every diagonal maximiser must leave the stratum, and it does, the negative entries of the sectional matrix $K$ number far more than two |
| $\mathbb{CP}^m$, $m\ge3$; subalgebra-Casimir points; tori |, | **no finding, and I say why rather than staying silent.** At $n=4,6$ [conventions.md](../findings/conventions.md) records $M(n)=\sqrt{3/2}$, so no object there can exceed the bound and $\mathbb{CP}^3$ cannot falsify it. Beyond $n=6$ the record carries no closed-form $\Lambda^2$ Weyl spectrum for $\mathbb{CP}^m$ or for the subalgebra family, and obtaining one is computation this loop may not do. **These families are untested against L35**, and that is a gap in the check, not a clearance |
| flat tori | $W=0$ | $\theta$ undefined; see §3 |

## 15. What would break it, and what I did to look for it

**The falsifier.** A single $W\in\mathrm{Weyl}_m$, of any $m$, with **at most two negative eigenvalues counted with multiplicity** and $\theta(W)>\sqrt{3/2}$. Because the chain is a sequence of relaxations, such a $W$ would break the lemma without breaking any single step, the only step that could be *individually* wrong is the residual $F\le\sqrt{3/2}$, and even a failure there would refute the proof rather than the lemma.

Concretely, such a $W$ would have to satisfy, in its eigenframe: $\sum\lambda=0$, $\sum\lambda^2=1$, two negatives $-b\le-c<0$, and a bracket tensor $T$ whose $(+++)$ and $(+--)$ blocks jointly beat $\sqrt{3/2}$ against the pair caps. Since $G$ already maximises over **all** nonnegative symmetric hollow tensors meeting the caps, the falsifier's spectrum alone would have to satisfy $G(\lambda)>\sqrt{3/2}$, so a falsifier of the lemma is also a falsifier of the purely spectral inequality $\sup G=\sqrt{3/2}$, and needs no curvature tensor at all to exhibit. **That is the shape to hunt: a two-negative spectrum, not a tensor.**

**What I did to look for one.**

- **Followed the reduction to its own two-variable face.** Every step from $\theta$ to $F$ is monotone in the enlarging direction and I verified each one; a spectral falsifier would have to sit where $F(A)>\sqrt{3/2}$ on $(0,A_0]$ or where $g(A)>\sqrt{3/2}$ on $[A_0,1]$. I closed the second analytically (§9). For the first, I checked the two closed-form anchors, $F\le\tfrac89$ at $A=\tfrac13$ with the peak exactly $\tfrac89$, and $F(A_0)=\sqrt{3/2}$ exactly, and screened four interior points, finding $F$ rising with no spike. **A screen, not a search**; the interior is closed on the record by certified numerics I did not and may not run.
- **Attacked the boundary of every stated range.** $k\le2$ (§11, closes exactly), $k=3$ (L42's equality case is live and attained there), exactly one negative (§12a, uncovered by the written argument), $A=\tfrac13$ (where $\beta=0$ and the cap is exactly $\tfrac89$), $A=0.4463$ (where the branch switches, and $F$ is $C^1$), $A=0.7$ (where the recorded middle-band maximum sits, and I reproduced $1.203230$ by hand), $A=0.7096$ and $A_0=\sqrt{2/3}$ (where equality holds and the second-order model was withdrawn), $m=4$, odd $m$, $\ker W\ne0$.
- **Tried one object from each structured family the record names** (§14). Padded $W_{\mathbb{CP}^2}$ attains the bound; the $\mathop{\mathrm{diag}}(2,-1,-1)$-doubled $\mathrm{Weyl}_4$ element leaves the stratum and screens at $\sqrt3/2$; the balanced sphere product at $n=12$ passes the strongest available consistency test, since $\theta_0(12)>\sqrt{3/2}$ forces it out of the stratum and its negative block has dimension at least $30$. $\mathbb{CP}^m$ for $m\ge3$ and the subalgebra-Casimir family are **untested**, for want of a closed-form spectrum on the record.
- **Attacked the imports rather than the algebra**, on the record's own advice that the recurring failure is an unstated assumption. That is what produced §4, §10, §11 and §12: the pair cap and the marginal check out against the object, the dual weight checks out at $k\ge3$ and is undefined at $k\le2$, the envelope theorem's uniqueness hypothesis holds, and Cauchy–Schwarz does not do what it is cited for.

**I found no falsifier, and I am not in a position to say none exists**, the interior of $(\tfrac13,A_0]$ is closed by certified numerics that this loop cannot audit, and two of the record's named families were never tested against this statement.

## Verdict

**GAP, with two defects in the written block and one provenance failure.**

The mathematics is in good condition: every hand-checkable step reproduces exactly, including both region maxima, all five endpoint constants, the $\tfrac89$ cap, the branch switch, and the middle-band maximum. What stands between the block and PROVEN:

1. **REFUTED AS WRITTEN (§4).** $G$'s closed form is false under the reading its own preceding display fixes, exhibited at $(2,-1,-1)/\sqrt6$ where it gives $8/(3\sqrt6)<\theta=9/(3\sqrt6)$. Already found by [REVIEW_r570](../reviews/REVIEW_r570.md) and **never repaired**, in either of the two places the display appears. The repair is one symbol: $\sum_P\lambda^3$.
2. **REFUTED AS ATTRIBUTED (§10).** The step $s^2\ge u$ is credited to Cauchy–Schwarz, which supplies the opposite direction. The step is true by positivity of the cross terms on a nonnegative spectrum. The attribution was itself entered as a Gate 2 correction.
3. **HYPOTHESIS-DEBT (§13b).** The residual on $(\tfrac13,A_0]$ is certified numerics, not an argument, self-declared, and correctly so.
4. **HYPOTHESIS-DEBT (§12a).** The one-negative case, self-declared as owed a line, and the block's description of it as "the $c\to0$ boundary" names the closure of the family rather than the constraint face the maximisation runs on.
5. **HYPOTHESIS-DEBT (§13c, §9, §12b).** The middle of the proof ($R(A,s,u)$, the region split, $\alpha,\beta,\gamma,T,K_0,\mathrm{FTP}$), appears nowhere in [findings/](../findings/) or [results.md](../results.md); four of those letters collide with the tensor indices and the tensor of the block's own first half; the interval is tiled three incompatible ways; and the multiplicity convention the statement depends on is stated in neither place the statement is written.
6. **Provenance (§11).** $k\le2$ closes exactly, but only in [REVIEW_r63](../reviews/REVIEW_r63.md), while the canonical [L29](../findings/stratum-two-negative.md) block declares that half owed and says L35 cannot discharge it.

**Nothing here refutes $\theta\le\sqrt{3/2}$ on the stratum.** The verdict is GAP because the canonical block, read as written, does not carry the proof: one display is false as printed, one justification points backwards, and the reduction that connects $G$ to the inequality that is actually certified is not on the record at all.
