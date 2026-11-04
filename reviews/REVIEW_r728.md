# r728, the complex-$z$ extension of [Lemma L148](../findings/second-order.md), read cold

**Cold brief.** Gate 2 on a derivation held off the record, claiming to discharge the `HYPOTHESIS-DEBT` that [Lemma L148](../findings/second-order.md) carries at [second-order.md:1203](../findings/second-order.md) and that [ROUND_L148-r2](../verification/ROUND_L148r2.md) records as F4. **No numerical work beyond one permitted screen**, reported as a screen in section 3 and used for nothing but a slack margin. Log: [agent_logs/r728.log](../agent_logs/r728.log).

| # | claim of the derivation | verdict |
|---|---|---|
| **C1** | Step 1, one real basis of coordinate $2$-planes diagonalises $W^*$ and $H$, does not depend on $z$, and makes $W(z)=W^*+zH$ diagonal with entries $\lambda_a+zh_a$ | **CONFIRMED**, and weaker than what the same two lines prove: the whole **complex $2$-plane** $\{aW^*+bH\}$ is diagonal in it |
| **C2** | Step 2, $W(z)_-$ is the Riesz contour object, is diagonal in the same basis, and has $a$-th entry $\lambda_a+zh_a$ or $0$ by membership of $\Gamma$'s interior | **CONFIRMED**, with the object under-specified: $W(z)_-$ is **$\Gamma$-dependent** and the derivation never names $\Gamma$, while the record carries two different ones ($\alpha=\tfrac12$ at [r447](REVIEW_r447.md):90, $\alpha^*=\tfrac D2$ at [L156](../findings/second-order.md)) |
| **C2a** | the brief's objection, $W(z)$ is complex symmetric, not normal, so a spectral projection is not orthogonal | **VOID ON $\Sigma$**, twice over: a matrix diagonal in a real orthonormal basis is normal, and [r441](REVIEW_r441.md):77 already records that the Riesz projection needs neither normality nor diagonalisability |
| **C3** | the separation hypothesis is "exactly the one L156 already carries … holds on $\lvert z\rvert\le\rho$ by the Neumann step" | **REFUTED AS STATED, repairable in one line.** L156's family is affine; the consumer's is the **complexified great circle** ([r447](REVIEW_r447.md):26), which the Neumann step as imported does not cover, the correction is $(\cosh\rho-1)\lambda_+$, screened at $0.0115\,g_n$ against $0.548\,g_n$ of slack |
| **C4** | Step 3, $\mathrm{Alt}$ is $\mathbb C$-linear and the four-distinct-index argument survives complexification | **CONFIRMED**, and it makes the conclusion **independent of the index set**, which the derivation's own entry formula obscures |
| **C5** | "What it does NOT give: analyticity of anything … a Cauchy estimate of a function that is identically zero on the disc needs only the pointwise vanishing" | **REFUTED.** The general principle is false, and the derivation's own Step 2 **proves** the analyticity it disclaims: $W(z)_-$ is affine in $z$ on the disc, hence entire there |
| **C6** | the claim's quantifier, "for every complex $z$ with $\lvert z\rvert<\rho$ **such that** $\Gamma$ separates the spectrum of $W(z)$" | **REFUTED AS STATED.** A conditional quantifier delivers no open set, and the consumer's $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ needs one. The body repairs it and the statement does not, **L148's own recorded failure mode**, at the same scale |
| **C7** | "So the extension needs one imported hypothesis and no new object", offered as not on the record | **NOVELTY REFUTED.** It is [r451](REVIEW_r451.md):112 verbatim, *"for all $t$, real or complex"*, in the review that found L148; and it is the second of the two closures [VERIFY_v51](../verification/VERIFY_v51.md):118 already writes out |
| **C8** | that the debt needs a complex statement at all | **REFUTED.** $A$ vanishes at **every** real $t$, so $A\vert_{\mathbb R}$ is the zero function and $A''=0$ with no disc, no contour, no gap and no $\ker W^*=0$, the hypotheses the derivation imports are hypotheses L148 was recorded as **not** needing |

**One line.** Every step of the mathematics is right; the derivation is redundant twice, against the record, where [r451](REVIEW_r451.md) and [VERIFY_v51](../verification/VERIFY_v51.md) both carry it, and against the mathematics, where the consumer's $\lVert A''\rVert=0$ follows from L148 over $\mathbb R$ alone, and it buys that redundant conclusion at the price of [L156](../findings/second-order.md)'s spectral hypotheses, which is the one thing L148 is on the record for not needing.

## 0. Conventions, fixed once

$\mathcal W_n$ is the space of algebraic Weyl tensors read as symmetric operators on $\Lambda^2\mathbb R^n$ with the Frobenius pairing; $\lVert\cdot\rVert$ is that norm and $\lVert\cdot\rVert_{op}$ the operator norm. $W^*$ is the unit-norm Weyl tensor of $S^m\times S^m$, $n=2m$, with $\mathop{\mathrm{spec}}W^*=\{\lambda_-,\lambda_+\}$, $\lvert\lambda_-\rvert=g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, $\lambda_+=\tfrac m{m-1}g_n$, and $D=\tfrac{2m-1}{m-1}=\lvert\lambda_+-\lambda_-\rvert/g_n$ ([L145](../findings/second-order.md), [L156](../findings/second-order.md)). $\Sigma$ is the joint $\lambda_m$-eigenspace, **both** $S^2_0(\mathbb R^m)$ copies, of dimension $(m+2)(m-1)$ ([L148](../findings/second-order.md)).

$\Gamma$ is a circle of radius $\alpha g_n$ about $\lambda_-$, $d=\min(\alpha,D-\alpha)$, and

$$W_-=\frac{-1}{2\pi i}\oint_\Gamma \zeta\,(W-\zeta)^{-1}\,d\zeta$$

([second-order.md:1475](../findings/second-order.md)). **This object depends on $\Gamma$**, and coincides with the real cone projection $x\mapsto x_-$ only while every eigenvalue inside $\Gamma$ is negative and every eigenvalue outside is positive. $A(z):=\mathrm{Alt}(W(z)_-)$, $M:=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$, and $\mathrm{Alt}(W^*_-)=0$ makes $A(0)=0$ ([r446](REVIEW_r446.md), [r447](REVIEW_r447.md)).

**Two families of $W(z)$ are in play and the record uses both.** The affine $W(z)=W^*+zH$, which is [L156](../findings/second-order.md)'s and the derivation's; and the complexified great circle $W(z)=\cos z\,W^*+\sin z\,H$, which is [r447](REVIEW_r447.md):26's and [r451](REVIEW_r451.md):112's, and which is what the tube geometry actually parametrises. [VERIFY_v49](../verification/VERIFY_v49.md):27 declares them interchangeable because *"the distinction is second order"*, a licence that has to be re-earned wherever the quantity in hand is itself a second derivative, which $A''$ is. Section 3 earns it on $\Sigma$.

Throughout, $\rho$ denotes [L156](../findings/second-order.md)'s $\gamma g_n/\lVert H\rVert_{op}$ with $0<\gamma<\min(d,1)$.

## 1. Step 1, CONFIRMED, and it proves more than it claims

The derivation's Step 1 reads *"L148 gives a real orthonormal basis of Lambda^2 R^n, made of coordinate 2-planes, in which W\* and H are simultaneously diagonal. That basis does not depend on z."*

Both halves hold. $W^*$ is a real combination of $\mathrm{id}$, $P_{\Lambda^2V_1}$ and $P_{\Lambda^2V_2}$, hence diagonal on the coordinate $2$-planes of **any** frame adapted to $\mathbb R^n=V_1\oplus V_2$; for $H\in\Sigma$ built from traceless symmetric $h$ on $V_1$ and $k$ on $V_2$, the frame diagonalising $(h,k)$ inside the two factors is such a frame and gives $H$ the eigenvalue $\eta_i+\eta_j$ on $e_i\wedge e_j$ ([second-order.md:1045](../findings/second-order.md)). The rotation lies in $O(m)\times O(m)$, which fixes $W^*$, this is exactly the *"frame chosen after $H$"* that [ROUND_L148](../verification/ROUND_L148.md) wrote into the lemma. Nothing in the construction sees $z$, because nothing in it sees the coefficient of $H$ at all.

**Which is the point the derivation misses.** What the frame diagonalises is not one segment but the entire complex $2$-plane

$$\Pi_{\mathbb C}:=\{aW^*+bH:\ a,b\in\mathbb C\}\subset\mathcal W_n\otimes\mathbb C .$$

Every element of $\Pi_{\mathbb C}$ is diagonal in the one fixed real basis, with entry $a\lambda_a+bh_a$. The affine family, the great circle, and any other curve in $\Pi_{\mathbb C}$ are all covered by the same sentence, and section 3's family mismatch never arises if the statement is made at this level. **Recording the plane rather than the segment costs one symbol and removes a hypothesis.**

## 2. Step 2, the object is right, the objection against it is void, and the contour is unnamed

### 2.1 The formula matches what [L156](../findings/second-order.md) defines

L156 never writes $W_-(z)$ alone; it writes the difference

$$W_-(z)-W_-(0)=\frac{-1}{2\pi i}\oint_\Gamma \zeta\,(W(z)-\zeta)^{-1}\,(zH)\,(W^*-\zeta)^{-1}\,d\zeta ,$$

which is the second-resolvent identity applied to the derivation's $W_-=-\tfrac1{2\pi i}\oint_\Gamma\zeta(W-\zeta)^{-1}d\zeta$, and is the same object [second-order.md:1475](../findings/second-order.md) states outright. **So the derivation's Step 2 formula is the record's.** *In passing:* $(A-\zeta)^{-1}-(B-\zeta)^{-1}=-(A-\zeta)^{-1}(A-B)(B-\zeta)^{-1}$ carries a minus that L156's display has absorbed into a prefactor it also keeps, so the two sides differ by a sign. L156 uses the display only inside $\lVert\cdot\rVert$, so nothing there moves; it is recorded because a successor differentiating that line will meet it.

### 2.2 The non-normality objection is void on $\Sigma$, and the record already says why

A matrix diagonal in a **real orthonormal** basis commutes with its conjugate transpose. So on $\Sigma$ the complexified $W(z)$ is normal, its spectral projections are the orthogonal projections onto sums of coordinate $2$-planes, and complex symmetry never enters. Off $\Sigma$ the objection has no force either: [r441](REVIEW_r441.md):77 records that *"diagonalisability is not needed and does not hold. A complex symmetric matrix can be defective. Nothing in the argument uses diagonalisability: $\Pi=\tfrac1{2\pi i}\oint_\Gamma(w-A)^{-1}dw$ is defined and holomorphic whenever $\Gamma$ misses the spectrum."* **The Riesz projection is the right object precisely because it survives non-normality**, and the derivation would have been entitled to say so.

### 2.3 The contour is not named, and $W_-$ depends on it

The derivation writes "$\Gamma$" nine times and fixes it once. The record carries two: [r447](REVIEW_r447.md):90 takes the circle of radius $g_n/2$ about $\lambda_-$, *separating $\lambda_-$ from both $0$ and $\lambda_+$*, and derives the constraint $\rho<g_n/2$ from it; [L156](../findings/second-order.md) takes $\alpha^*=D/2>1$, a circle that **encloses $0$**, and overturns $\alpha<1$ as a constraint. These are different operators $W_-$ in general. They agree on L156's disc, because $\gamma<1$ keeps the negative cluster off $0$ and $\gamma<d$ keeps both clusters on their own sides of both circles, so no eigenvalue lies in the annulus between them. **The derivation inherits this agreement without stating it**, and a successor reading Step 2 beside [r447](REVIEW_r447.md):90 has no way to know which $W_-$ is meant.

### 2.4 Membership of the interior, and whether $\arg z$ can change it

Answering the brief's question directly, in closed form.

- **Negative cluster, and $\arg z$ is irrelevant.** For $\lambda_a=\lambda_-$ the eigenvalue $\lambda_-+zh_a$ sits at distance $\lvert z\rvert\lvert h_a\rvert$ from $\Gamma$'s **centre**, so membership depends on $\lvert z\rvert$ alone and switches exactly at $\lvert z\rvert=\alpha g_n/\lvert h_a\rvert$.
- **Positive cluster, and there $\arg z$ decides.** For $\lambda_a=\lambda_+$ the point $\lambda_++zh_a$ is inside $\Gamma$ iff $\lvert(\lambda_+-\lambda_-)+zh_a\rvert<\alpha g_n$. Fix $a$ with $h_a\ne0$ and take $\lvert z\rvert=\big((D-\alpha)g_n+\varepsilon\big)/\lvert h_a\rvert$. With $\arg z$ chosen so that $zh_a$ is the negative real multiple pointing from $\lambda_+$ towards $\lambda_-$, the eigenvalue is inside; rotating $z$ by $\pi$ puts it at distance $\ge(D-\alpha)g_n$ outside. **Same $\lvert z\rvert$, opposite membership.**
- **Neither happens on L156's disc.** There $\lvert zh_a\rvert\le\rho\lVert H\rVert_{op}=\gamma g_n<dg_n\le\min(\alpha,D-\alpha)g_n$, so no eigenvalue reaches $\Gamma$ from either side and the index set $I=\{a:\lambda_a=\lambda_-\}$ is constant on the closed disc.

Hence on the disc

$$W(z)_-=\sum_{a\in I}(\lambda_a+zh_a)\,P_a ,$$

**affine in $z$**, which is section 5's business.

## 3. The separation hypothesis, and the two discs are two objects

### 3.1 What L156 supplies

L156 supplies separation on the closed disc of radius $\rho=\gamma g_n/\lVert H\rVert_{op}$, for $0<\gamma<\min(d,1)$, at the affine family, under $m\ge2$, $\ker W^*=0$ and $\mathop{\mathrm{spec}}W^*$ two-valued. That is section 2.4's inequality $\gamma<d$, and it is genuinely what its *"$\gamma<d$ keeps the perturbed resolvent finite"* means. **On the affine family the derivation's import is sound.**

The apparent clash with [r447](REVIEW_r447.md):90's $\rho<g_n/2$ is not one: that is the same condition $\gamma<d$ evaluated at $\alpha=\tfrac12$, where $d=\tfrac12$. L156's larger $\gamma^*=D/4$ is admissible only because $\alpha^*>1$ is, which L156 established.

### 3.2 The family the consumer actually integrates over is a different one

**Locate.** The derivation, line 41: *"which holds on |z| <= rho by the Neumann step"*, of the family it declares at line 25, *"W(z) = W\* + zH"*. The consumer, [r447](REVIEW_r447.md):26: *"Write $A(z)=\mathrm{Alt}(W(z)_-)$ **along the complexified great circle**, holomorphic on $\lvert z\rvert<\rho=\Theta(g_n)$"*, and it is r447's chain that [L147](../findings/second-order.md) re-runs. [r451](REVIEW_r451.md):112, the source of L148, likewise writes $W(t)=\cos t\,W^*+\sin t\,H$.

**Exhibit.** On the great circle the perturbation is not $zH$:

$$W(z)-W^*=(\cos z-1)W^*+\sin z\,H,\qquad \lVert W(z)-W^*\rVert_{op}\le(\cosh\rho-1)\lambda_++\sinh\rho\,\lVert H\rVert_{op}\quad(\lvert z\rvert\le\rho).$$

The first term is absent from L156's hypothesis and is not of order $\rho\lVert H\rVert_{op}$: it is a perturbation of $W^*$ **by itself**, and $\lVert W^*\rVert_{op}=\lambda_+=\tfrac m{m-1}g_n$ is of the order of the very gap the separation argument spends. So the imported inequality $\gamma<d$ is not the inequality the consumer needs; the needed one is

$$(\cosh\rho-1)\tfrac m{m-1}+\sinh\rho\,\lVert H\rVert_{op}/g_n\;<\;d .$$

**Screen** *(permitted: seconds of arithmetic on objects constructed for it; reported as a screen, evidence for nothing)*. At $n=12$ on the margin summand, with $\lVert H\rVert_{op}\le a_0n^{-1/2}=0.4472$ ([L146](../findings/second-order.md), $a_0=\sqrt{2n/(n-2)}$), $g_{12}=0.112367$, $(\alpha^*,\gamma^*)=(1.1,0.55)$ and $\rho=\gamma^*g_n/\lVert H\rVert_{op}=0.13819$: the $\cos$ term contributes $0.0115\,g_n$ and the $\sin$ term $0.5518\,g_n$, against $d\,g_n=1.1\,g_n$. **Slack of $0.548\,g_n$, forty-eight times the correction.**

**Argue the opposite.** The strongest defence is that the mismatch is empty on $\Sigma$, and it is right: by section 1 the whole plane $\Pi_{\mathbb C}$ is diagonal in the fixed frame, so $\mathrm{Alt}$ annihilates the Riesz part of **every** point of it at which that part is defined, whatever the parametrisation. The affine-versus-circle question therefore cannot change the verdict, it can only change whether the sentence as written covers the consumer's object. It does not, and the repair is to state the plane. **Upheld as a defect of statement, refuted as a defect of substance.**

## 4. Step 3, CONFIRMED, and the conclusion does not depend on the index set

$\mathrm{Alt}$ is the Bianchi projector, a linear map with rational coefficients, so its complexification is the same formula and is $\mathbb C$-linear by construction; the derivation's line 46 is correct and needs no argument beyond that. For $R$ diagonal in the coordinate $2$-plane basis, $R_{ijkl}=\langle R(e_i\wedge e_j),e_k\wedge e_l\rangle=0$ unless $\{i,j\}=\{k,l\}$, and

$$\mathrm{Alt}(R)_{ijkl}=\tfrac13\big(R_{ijkl}+R_{iklj}+R_{iljk}\big)$$

has, on four **distinct** indices, three terms each pairing disjoint index pairs. All three vanish. Over $\mathbb C$ the entries are complex and the three terms still vanish termwise. **CONFIRMED, exactly as [VERIFY_v51](../verification/VERIFY_v51.md) reproduces it over $\mathbb R$.**

**And it is stronger than Step 2 lets it be.** Step 2's entry formula ties the conclusion to which eigenvalues sit inside $\Gamma$; Step 3 needs no such information. For **any** subset $I\subseteq\{a\}$, $\sum_{a\in I}c_aP_a$ is coordinate-diagonal and killed by $\mathrm{Alt}$. So the separation hypothesis is needed for $W(z)_-$ to **exist**, and never for it to be annihilated, which is the honest division of labour, and which section 2.4's $\arg z$-dependent membership makes worth saying: the index set may be $\arg z$-dependent outside the disc, and the vanishing does not care.

## 5. The disclaimer, REFUTED, and the derivation's own Step 2 refutes it

**Locate.** Lines 60–64: *"What it does NOT give, Analyticity of anything, which L148 was right to disclaim … A Cauchy estimate of a function that is identically zero on the disc needs only the pointwise vanishing."*

**Exhibit, first count, the general principle is false.** A Cauchy estimate is a theorem about holomorphic functions: $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$ is derived from the integral representation and is unavailable for a function merely *defined* on the disc. From pointwise vanishing of an arbitrary function nothing about $A''$ follows, because $A''$ need not exist. What actually saves the sentence is a different fact: a function vanishing at **every** point of an open set **is** the zero function there, and the zero function is holomorphic with all derivatives zero. The Cauchy estimate is not being used with weakened hypotheses; it is not being used at all. **The distinction bites exactly where the debt lives:** on a function vanishing only on the real diameter the sentence is false, and that is the case L148 hands to L147.

**Exhibit, second count, the derivation proves what it disclaims.** Section 2.4 gives, on the disc, $W(z)_-=\sum_{a\in I}(\lambda_a+zh_a)P_a$ with $I$ constant. That is an **affine, hence entire, function of $z$**, and $A(z)=\mathrm{Alt}(W(z)_-)$ is likewise. So Steps 1–2 establish analyticity of $z\mapsto W(z)_-$ on the disc as a by-product, and the headline "analyticity of anything" is contradicted four lines above it. The record agrees: [L145](../findings/second-order.md)'s step table carries *"$W\mapsto W_-$ is analytic on the ball of radius $g_n$"* as **CONFIRMED**, and [L146](../findings/second-order.md):1243 makes $\ker W^*=0$ load-bearing *"without which $W\mapsto W_-$ is not analytic at $W^*$ and branches 2 and 3 have no domain"*.

**Argue the opposite.** The defence is that L148 disclaims analyticity in order to keep its own hypothesis list empty (no gap, no $\ker W^*=0$) and that the derivation is honouring that. The defence fails on its own terms: the derivation has already imported L156, whose hypotheses include both, so it has spent the economy it is protecting. Once $\Gamma$ separates, analyticity is free and should be claimed. **REFUTED.**

## 6. The quantifier, REFUTED AS STATED, and it is L148's own failure mode repeated

**Locate.** Lines 14–17: *"for every complex z with |z| < rho **such that Gamma separates the spectrum of W(z)**: Alt( W(z)\_- ) = 0."*

**Exhibit.** The consumer needs $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert=0$, a supremum over a **circle**. A claim quantified over $\{z:\Gamma\text{ separates}\}$ says nothing about points outside that set, and at such a point $A(z)$ is not zero but **undefined**, the contour meets the spectrum and the integral does not converge. Concretely, take $a$ realising $\lvert h_a\rvert=\lVert H\rVert_{op}$ and $\lambda_a=\lambda_-$: at $\lvert z\rvert=\alpha g_n/\lVert H\rVert_{op}$ the eigenvalue $\lambda_-+zh_a$ lies **on** $\Gamma$ for every $\arg z$. So a reader who takes $\gamma\ge\alpha$ (nothing in the claim forbids it, since the claim names no $\gamma$), gets a circle on which $M$ is the supremum of an undefined function, and the conditional clause absorbs the failure silently instead of excluding it.

**Argue the opposite.** The body repairs it: line 41 asserts separation on all of $\lvert z\rvert\le\rho$, so the intended reading is the unconditional one on L156's disc. Granted, and that is precisely the charge. [ROUND_L148-r2](../verification/ROUND_L148r2.md) refused L148's own text for this: *"a correction written in one passage and not in the passage it corrects, six lines apart, inside a single entry"*, and its whole verdict was that *"the repairs live in boxes and the canonical statement was never edited"*. **A candidate discharging that entry's debt reproduces that entry's defect, twenty-six lines apart.** The fix is one substitution: quantify over $\lvert z\rvert\le\gamma g_n/\lVert H\rVert_{op}$ with $0<\gamma<\min(d,1)$, and let separation be a conclusion rather than a filter.

## 7. Novelty, REFUTED, twice, one of them by the review that found L148

**Locate.** Lines 52–58, *"What this uses that L148 does not state"*, and the debt it answers, [second-order.md:1203](../findings/second-order.md): *"Extending the diagonality to complex $z$ is one sentence and it is not on the record."*

**Exhibit A, [r451](REVIEW_r451.md):112**, the review that found L148 in the first place:

> *"So $W(t)=\cos t\,W^*+\sin t\,H$ is diagonal in one fixed coordinate-plane basis for all $t$, **real or complex**; its Riesz projection and hence $W(t)_-$ are diagonal in the same basis; and a coordinate-plane-diagonal tensor has $T_{ijkl}\ne0$ only for $\{i,j\}=\{k,l\}$, so every component on four distinct indices vanishes and $\mathrm{Alt}(W(t)_-)=0$."*

That is Steps 1, 2 and 3, in one sentence, on the **great-circle** family the consumer actually uses, so it covers section 3's gap as well. L148's entry narrowed *"real or complex"* to *"for every real $t$"* when the finding was written up, and the debt is the record of that narrowing.

**Exhibit B, [VERIFY_v51](../verification/VERIFY_v51.md):118**, the verifier that raised the debt, under *"Argue the opposite"*:

> *"Two one-line closures exist. Either invoke the identity theorem, $A$ is holomorphic on the disc and vanishes on the real diameter, a set with a limit point, hence vanishes identically … Or extend the entry's own argument: $W(z)=W^*+zH$ is diagonal in the same frame for complex $z$, its entries being affine in $z$, and the contour integral of a diagonal matrix is diagonal, so $A(z)=0$ on the whole disc."*

The derivation is the second of those two, expanded from one sentence to fifty lines, with the same import from L156 that v51 names in the same paragraph. v51 also states the sentence to be filed, verbatim, at its line 120.

**Argue the opposite.** [ROUND_L148-r2](../verification/ROUND_L148r2.md) says *"neither is on the record"*, and L148's box says the sentence *"is not on the record"*, so the derivation was answering a question the record itself poses. Read exactly, both are true of **L148 and L147**, which is where a citation looks; they are false of the record, since [verification/](../verification/) and [reviews/](../reviews/) are on it. **The owed act is therefore editorial, move r451's clause into [second-order.md:1199](../findings/second-order.md) with its two citations, and not a derivation.** Filing this as new mathematics would be the fifth vocabulary-over-object failure of this block, after [L157](../findings/second-order.md)'s $\eta$, [L158](../findings/second-order.md)'s $\kappa$, [L150](../findings/second-order.md)'s own recorded instance and [r722](REVIEW_r722.md)'s *"finds the whole derivation unnecessary"*; [r725](REVIEW_r725.md) and [r726](REVIEW_r726.md) withdrew the last candidate on this record for exactly this.

## 8. Whether the consumer needs a complex statement at all, it does not

This is the finding that outranks the rest, and neither the derivation nor the debt line considers it.

**What L147 needs.** The chain uses $\lVert A''(s)\rVert$ for **real** $s$: [r447](REVIEW_r447.md):58 writes *"$\lVert A(t)\rVert\le ut+Knt^2$ from $A(0)=0$ and $\lVert A''\rVert=O(n)$ uniformly on $\lvert s\rvert\le t$"*, and [r450](REVIEW_r450.md) D7's form is $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$. The complex disc appears **only** as the instrument that produces that real bound; the quantity bounded is the second derivative of the real curve $s\mapsto A(s)$.

**What L148 delivers.** $\mathrm{Alt}(W(t)_-)=0$ for **every real $t$**, on the whole line, together with $\mathrm{Alt}(W^*_-)=0$. Hence for $H\in\Sigma$,

$$A(s)=0\quad\text{for every }s\in\mathbb R .$$

$A\vert_{\mathbb R}$ is therefore the zero function of a real variable. The zero function is smooth and $A''(s)=0$ identically. **No disc, no contour, no separation, no $\ker W^*=0$, no two-valued spectrum, no $m\ge2$.**

**Argue the opposite, and it is the strongest defence available.** Two objections deserve answers.

1. *"$M$ is itself a named quantity of the chain; setting $M=0$ needs the circle."* True, and it is the one thing the complex statement buys: [L145](../findings/second-order.md)'s $\lVert A^{(k)}\rVert=O(M/\rho^k)$ is quoted at $k=3$ in the $C_\delta$ chain, and a successor wanting $A'''=0$ from $M=0$ rather than from $A\vert_{\mathbb R}\equiv0$ would want it. But that is a strengthening of the instrument, not a discharge of the debt, and it should be filed as such.
2. *"$\lVert A''\rVert$ enters as a direction-uniform constant $K$, so a per-direction argument is the wrong shape."* The uniform $K$ is an upper bound over directions; the branch that vanishes at $w=0$ vanishes because the **particular** direction has $A\equiv0$, which is how [L148](../findings/second-order.md) is already read at [second-order.md:1255](../findings/second-order.md) and [:1257](../findings/second-order.md). A per-direction zero is exactly what those lines consume.

**So the debt is discharged over $\mathbb R$, and the derivation's own line 62 half-sees it** (*"the claim is that the vanishing holds pointwise at each admissible complex $z$"*) while spending the section on the disc instead of on the segment. And the cost of the route taken is real: L148 is on the record as the **one link in the tube chain that survives a kernel** ([second-order.md:1195](../findings/second-order.md)); routing its consumption through L156 attaches $\ker W^*=0$ and a two-point spectrum to a conclusion that had neither.

## 9. What I would file, and it is three lines

Into [second-order.md:1199](../findings/second-order.md), replacing the debt box:

> *For $H\in\Sigma$ the whole complex $2$-plane $\{aW^*+bH:a,b\in\mathbb C\}$ is diagonal in the one real frame that diagonalises $(h,k)$, so $\mathrm{Alt}$ annihilates the $\Gamma$-Riesz part of each of its points at which that part is defined, in particular on [L156](../findings/second-order.md)'s disc $\lvert z\rvert\le\gamma g_n/\lVert H\rVert_{op}$, $0<\gamma<\min(d,1)$, where the enclosed index set is constant and $z\mapsto W(z)_-$ is affine. Hence $M=0$ and $\lVert A''\rVert=0$ there. **The consumer needs less: $A$ vanishes at every real $t$, so $A\vert_{\mathbb R}$ is the zero function and $A''=0$ with no disc at all.** ([r451](../reviews/REVIEW_r451.md):112, [VERIFY_v51](../verification/VERIFY_v51.md):118.)*

## 10. Two things found against the record in passing

- **[L147](../findings/second-order.md):1173's reason for $M=O(\rho)$ does not survive complexification, and this is not the derivation's to fix.** The entry argues *"$x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm"*, which is the real symmetric **cone projection**; the holomorphic object on $\lvert z\rvert=\rho$ is the Riesz integral and has no cone characterisation. [VERIFY_v22](../verification/VERIFY_v22.md):177 states this already and is not cited at L147. The order survives by an honest route, [L156](../findings/second-order.md)'s $M\le C\gamma g_n=C\rho\lVert H\rVert_{op}$, so the repair is to cite L156 where the Lipschitz sentence stands. **On $\Sigma$ this is moot ($M=0$); on the mixed directions, which is where [L148](../findings/second-order.md) itself says the question lives, it is the live complexification gap**, and the candidate closes the one that was already closed while leaving it open.
- **[ROUND_L148-r2](../verification/ROUND_L148r2.md)'s "neither is on the record" is true of the two entries and false of the record**, since [VERIFY_v51](../verification/VERIFY_v51.md) is the file saying it. The wording is what sent this candidate to re-derive r451's sentence, and one word (*"in L148 or L147"*, which v51's own line 118 has and the round dropped), would have prevented it.

## Verdict

**The candidate is WITHDRAWN as a derivation and stands as an editorial repair.** C1, C2, C2a and C4 CONFIRMED; C3 and C6 REFUTED AS STATED and repairable in one line each; C5 REFUTED; C7 NOVELTY REFUTED against [r451](REVIEW_r451.md):112 and [VERIFY_v51](../verification/VERIFY_v51.md):118; C8 REFUTED, the debt closes over $\mathbb R$, and the complex route pays [L156](../findings/second-order.md)'s hypotheses for a conclusion that is free without them.
