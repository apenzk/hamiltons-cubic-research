# REVIEW r282, Gate 2, the padding dichotomy and the support dimension

Reviewer 282. Commits under review: `f27eb56` (primary), `90ce9a5`, `bac2049`/`6bcf1b6`, `8ab7e82`.
Primary file: [plan.md](../plan.md), the routing block and section 1, reviewed **as of `f27eb56`**, since `c079378` landed mid-review and replaced the reviewed block with routes D and F. Supporting: [findings/support-dichotomy.md](../findings/support-dichotomy.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/sym3-blocks.md](../findings/sym3-blocks.md), [findings/problem.md](../findings/problem.md), [findings/nondegeneracy.md](../findings/nondegeneracy.md), [reviews/REVIEW_r277.md](REVIEW_r277.md)–[REVIEW_r280.md](REVIEW_r280.md).
Scripts: [scripts/reviewers/r282/](../scripts/reviewers/r282/). Reviewer 281 runs the identical brief concurrently and independently.

Every number below comes from a toolkit written for this review from the definitions alone, [weyl.py](../scripts/reviewers/r282/weyl.py) builds $\mathrm{Weyl}_n$ by projecting a random $4$-tensor through the curvature symmetries, first Bianchi and the Kulkarni–Nomizu trace removal, and computes $W^\#$ from the $\mathfrak{so}(n)$ structure constants as $(W^\#)_{ab}=\tfrac12c_{a\gamma\delta}c_{b\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$. It agrees with [curvature_operator.py](../scripts/curvature_operator.py)'s independent bracket-quadratic-form route to $5.6\times10^{-17}$ at $n=4,5,6$ and reproduces $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ exactly.

| # | Claim | Verdict |
|---|---|---|
| 1 | The padding dichotomy | **THE CRUX HOLDS (SUPPORT $s$ *DOES* FORCE A PADDING, WITH A ONE-LINE PROOF THE RECORD NEVER GIVES) BUT "THE RESIDUAL IS THE FULL-SUPPORT POINTS" IS FALSE FROM $n=14$.** (a) $T_{ip}=\sum W_{ijkl}W_{pjkl}$ is PSD with $v^\top Tv=\lVert\iota_vW\rVert^2$, so $\ker T=\{v:\iota_vW=0\}$ and $W$ lives on $V=(\ker T)^\perp$; $W|_V$ inherits Bianchi and is $V$-traceless because the missing trace directions contribute zero, so $W|_V\in\mathrm{Weyl}_s$ and $\theta\le M(s)$ is right, *given* that $P$ is padding-invariant, which it is (the bracket of two elements of $\Lambda^2V$ stays in $\Lambda^2V$). (b) Frame-covariant: $T\mapsto gTg^\top$; verified on a random $SO(12)$ rotation of the padded $W_{\mathbb{CP}^2}$, $s=4$ preserved with the operator no longer coordinate-padded. (c) $\sqrt{3/2}<\theta_0(n)$ for every even $n\ge12$, $\theta_0^2=2-6/n+4/n^2$ is increasing and $\theta_0(12)=1.2360>1.2247>\theta_0(11)$. **The defect:** at $n\ge14$ the strata $12\le s<n$ are neither "support $\le11$" nor "full support", and they are populated above $\sqrt{3/2}$, padded $S^6\times S^6$ inside $n=14$ has $s=12$ and $\theta=1.23603$. The residual is $s\ge12$, and closing it needs an induction whose $s=n-1$ case is the **odd-dimensional** conjecture the record's own standing state calls open |
| 2 | Is the route fenced? | **UNFENCED (CONFIRMED) AND IT REOPENS POST F35 ONLY FOR POST F34 TO HOLD THE SAME GROUND.** No post on the list bounds a padding-*dependent* quantity, so none reaches $s$; post F7 (the crossover at $6+2\sqrt7$) is *satisfied* rather than violated, since $s\le11$ against $s\ge12$ **is** that crossover; [nondegeneracy.md](../findings/nondegeneracy.md)'s *"padding is the $b=0$ degenerate case"* fences the **sum law**, which the dichotomy does not use. What the plan does not say: **the dichotomy deletes post F35's witness.** Padded $W_{\mathbb{CP}^2}$, $s=4$, is the whole of post F35's $n\approx356$ obstruction, and the full-support residual does not contain it. But post F34 re-closes the same quantity on the residual: ascending $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F$ reproduces post F34's own $1.3403,1.2399,1.1881,1.1564$ at $n=6,8,10,12$ **and every maximiser is full support**, with $\theta/\theta_0=0.9757$ at $n=12$ |
| 3 | The stall summary and its retraction | **THE RETRACTION IS RIGHT AND UNDERSOLD; THE SURVIVING CLAIM IS FALSE AT POST F6 AND MISDESCRIBES POST F26.** $s$ does distinguish, so *"the record contains no padding-distinguishing quantity defined on all of $\mathrm{Weyl}_n$"* is false, **and it was already false when written**, because [stratum-two-negative.md](../findings/stratum-two-negative.md) carries a *Proposition (padding reduction)* with $\theta(W')=\theta(W)$ and an induction that *"runs down to $n=r$, where $r$ is the larger support dimension"*, and [plan.md](../plan.md)'s own section 2 lists *"the support descent"* among what route S consumes as filed. **Post F6 fails the pattern outright**: its quantity is the spectrum of $L_W$, whose second moment is $(n-1)(2n-1)\lVert W\rVert^2/4$ by the record's own identity, $13.75$, $19.5$, $26.25$ on one fixed padded $W$ at $n=6,7,8$, with $\operatorname{tr}L_W^3$ changing **sign**. Posts 33, 34, 35 do pass it, verified. **Post F26 has no definition anywhere in the record**, only citations |
| 4 | The one-line theorem and the r279/r280 reconciliation | **THE THEOREM IS TRUE, THE CHAIN AS WRITTEN IS INVALID AT A NEGATIVE COEFFICIENT AND REPAIRABLE IN ONE LINE, AND THE RECONCILIATION'S SECOND HALF IS REFUTED.** With $A_i\circ A_j=0$ as hypothesis, criticality is genuinely unused, verified on two **non-critical** coordinate-disjoint pieces (residuals $0.81$ and $0.66$), where $P(aA+bB)=a^3P(A)+b^3P(B)$ to $10^{-16}$ including at negative $a$. But *"criticality is what derives $A_i\circ A_j=0$ from mere orthogonality"* is **false**: two critical, Frobenius-orthogonal padded $W_{\mathbb{CP}^2}$ at $n=8$ have $\lVert A\circ B\rVert=0.626449$. **And the true statement is a third one neither reviewer had**: at those same points additivity still holds exactly, so $\circ$-orthogonality is *sufficient and not necessary* for it. Separately, $\sum a_i^3P(A_i)\le M\sum a_i^3$ needs $a_i\ge0$; the sign flip $A_i\mapsto-A_i$ restores it, so nothing is lost |
| 5 | $\Theta_5$ as recorded | **CONFIRMED, the identity, the implication, and the certificate.** $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$ to $4\times10^{-16}$ on random unit $\mathrm{Weyl}_4$ and $\mathrm{Weyl}_5$ and false from $n=6$ ($6.8\times10^{-2}$), so $P=3\operatorname{tr}(W^3)$ and $F_5=\tfrac32\lVert W\rVert^6-P^2$ **identically**, checked at non-unit norms too. $F_5\ge0$ then gives $P^2\le\tfrac32$, and $P$ odd makes $\max P=\max\lvert P\rvert=\sqrt{3/2}$; ascent over $\mathrm{Weyl}_5$ returns $1.224744871391589$, excess $4\times10^{-16}$. [run_n5_verify.py](../scripts/runs/run_n5_verify.py) runs clean, every block positive definite in both packings. **The file around it is not clean**: [sym3-blocks.md](../findings/sym3-blocks.md) line 111 calls the restricted rank $13$ *a theorem* and line 123 calls it *open in $[1,13]$* |
| 6 | The r259–r280 sweep and the index | **SIX ITEMS UNAPPLIED, three of them live contradictions.** [reviews/INDEX.md](INDEX.md) still has **no index rows for r269–r273** (all five files exist; r273 is a full report, not a salvage), r279 filed this and it is unrepaired. [sym3-blocks.md](../findings/sym3-blocks.md) contradicts itself at lines 111/113 against 123; still heads its $\Theta_5$ section *"what the certificate **would** establish"* (r280's item, unrepaired); and still carries the $40$-equations argument that [run_n5_verify.py](../scripts/runs/run_n5_verify.py) itself labels **circular** after r214, having replaced it with r213's invariant-sextic count. **Post F26 is cited by [plan.md](../plan.md) and defined nowhere**, and r274's verdict on it lives only in [ad-form-attempt.md](../findings/ad-form-attempt.md) |

---

## Claim 1, the padding dichotomy, link by link

Evidence: [c1_support.py](../scripts/reviewers/r282/c1_support.py), [out_c1_support.txt](../scripts/reviewers/r282/out_c1_support.txt), [c1_msweep.py](../scripts/reviewers/r282/c1_msweep.py), [out_c1_msweep.txt](../scripts/reviewers/r282/out_c1_msweep.txt).

### (a) THE CRUX, support $s$ genuinely forces a padding, and here is the proof

Write $T_{ip}=\sum_{jkl}W_{ijkl}W_{pjkl}$ and $s=\mathrm{rank}\,T$. Then $v^\top Tv=\sum_{jkl}\big(\sum_iv_iW_{ijkl}\big)^2=\lVert\iota_vW\rVert^2$, so $T$ is positive semi-definite and

$$\ker T=\{v\in\mathbb R^n:\iota_vW=0\}.$$

Put $V=(\ker T)^\perp$, $\dim V=s$. If any of $i,j,k,l$ has a component in $\ker T$ then $W_{ijkl}=0$, for $i$ directly, for $j$ by antisymmetry, for $k,l$ by pair exchange. **So $W$ is the zero-padding of $W|_V$**, and three things make $W|_V$ a *Weyl* tensor of $\mathbb R^s$ rather than merely a tensor:

- the curvature symmetries and first Bianchi are pointwise identities in the indices, so they restrict;
- $W|_V$ is $V$-traceless: for $k,l\in V$, $\sum_{i\in V}W_{ikil}=\sum_{i=1}^nW_{ikil}=0$, because every $i\in\ker T$ contributes $0$;
- $P$ is padding-invariant. $\langle W,W^2\rangle$ obviously restricts, and $(W^\#)_{ab}=\tfrac12c_{a\gamma\delta}c_{b\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$ is supported on $\Lambda^2V$ because $W$ forces $\gamma,\delta,\varepsilon,\zeta\in\Lambda^2V$ and $[\Lambda^2V,\Lambda^2V]\subseteq\Lambda^2V$; on $\Lambda^2V$ the structure constants are those of $\mathfrak{so}(s)$.

**There is no Weyl tensor of support $s$ that is not a padding.** The question the brief poses as "the whole route fails at step one" is answered in the safe direction, and it is answered by the *definition* of $T$ rather than by measurement, the kernel of the support matrix is exactly the annihilator, so the two notions of support coincide by construction.

Machine confirmation on the contrapositive side: paddings of random $\mathrm{Weyl}_s$ into $n=12$ give $\mathrm{rank}\,T=s$ exactly for $s=4,5,6,7$, with $\lvert\mathrm{Ric}(W|_V)\rvert\le5\times10^{-16}$, $\lvert\mathrm{Bianchi}(W|_V)\rvert\le7\times10^{-16}$ and $P_n=P_s$ to twelve digits. Random $\mathrm{Weyl}_n$ points have $s=n$ at $n=5,6,8,12$, so low support is a measure-zero condition rather than a generic one.

**Consequently $M$ is non-decreasing** ($M(s)\le M(s+1)$, since a padding of the $s$-maximiser competes at $s+1$) which is the fact the dichotomy actually runs on and which the plan leaves implicit.

### (b) The support dimension is well defined and frame-covariant

Under $W\mapsto g\cdot W$ the matrix transforms as $T\mapsto gTg^\top$, so the rank is an $O(n)$-invariant. Verified: a random $SO(12)$ rotation of the padded $W_{\mathbb{CP}^2}$ keeps $s=4$ and $P=1.2247448713915916$ while the operator acquires entries of size $0.09$ outside the padded block, so the invariance is not an artefact of the coordinate padding.

The two measured anchors reproduce exactly: padded $W_{\mathbb{CP}^2}$ has $s=4$ at every $n\in\{5,6,8,12\}$ with $P=1.22474487139159$ and $\Lambda^2$-spectrum $(2,-1,-1,0,0,0)/\sqrt6$; $S^6\times S^6$ has $s=12$ and $P=1.23603308118261=\theta_0(12)$.

### (c) $\sqrt{3/2}$ against $\theta_0(n)$, and what is known about $M(s)$

$\theta_0(n)^2=2(n-1)(n-2)/n^2=2-6/n+4/n^2$ has derivative $6/n^2-8/n^3>0$ for $n>4/3$, so $\theta_0$ is strictly increasing on the live range and $\theta_0(n)\ge\theta_0(12)=1.236033>1.224745=\sqrt{3/2}$ **for every even $n\ge12$**. The crossover is $n^2-12n+8=0$, i.e. $n=6+2\sqrt7=11.2915$, which is [post F7](../findings/fence-posts.md), so the first link and the fence post are the same arithmetic, and $\theta_0(11)=1.219673<\sqrt{3/2}$ makes $s\le11$ exactly the range where the plan's inequality has the direction it needs.

**What is actually known about $M(s)$, $5\le s\le11$:** $M(4)=M(5)=\sqrt{3/2}$ are proved (post F2c and the $F_5$ certificate). **$M(6)$ through $M(11)$ are open**, the record contains no proof for any of them, and the plan's "if $M(s)=\sqrt{3/2}$ for $s\le11$" is the whole of the low-dimensional half. Projected ascent from random restarts finds $\max P=1.224744871392$ at $s=6,\dots,11$, every optimum a padded $W_{\mathbb{CP}^2}$ of support $4$ with spectrum $(2,-1,-1,0^{\cdot})/\sqrt6$, and $1.236033081183$ at $n=12$ with full support, so the presumption is numerically consistent and analytically untouched. That is a conjecture of the same character as Conjecture A itself, in six dimensions at once.

### The defect, "the residual is the full-support points" is false from $n=14$

The dichotomy as written splits $\mathrm{Weyl}_n$ into $s\le11$ and *full support*. Those two do not cover $\mathrm{Weyl}_n$ once $n\ge14$: the stratum $12\le s\le n-1$ is nonempty and lies **above** $\sqrt{3/2}$, so the low-dimensional half does not reach it.

| witness | ambient $n$ | $s$ | $\theta$ | vs $\sqrt{3/2}$ |
|---|---|---|---|---|
| padded $S^6\times S^6$ | $14$ | $12$ | $1.236033081$ | above |
| padded $S^6\times S^6$ | $16$ | $12$ | $1.236033081$ | above |
| padded $S^7\times S^7$ | $16$ | $14$ | $1.261680124$ | above |
| padded $S^6\times S^5$ | $14$ | $11$ | $1.217161239$ | below, the $s\le11$ half does hold |

At $n=12$ alone the statement is correct, because $s\le12$ and $s\ge12$ leave nothing between. **From $n=14$ the honest residual is $s\ge12$**, and reducing it is an induction: for even $s$ with $12\le s<n$, induction on $n$ gives $M(s)=\theta_0(s)<\theta_0(n)$; for odd $s\le n-3$, $M(s)\le M(s+1)=\theta_0(s+1)\le\theta_0(n-2)<\theta_0(n)$. **The one case the induction cannot reach is $s=n-1$**, odd, where monotonicity only gives $M(n-1)\le M(n)$ and the needed bound is the *odd-dimensional* form of Conjecture A, which [plan.md](../plan.md)'s own standing state records as conjectural even in the diagonal case, the granted assumption not reaching it.

So the route inherits **two** open halves, not one: the presumed $M(s)=\sqrt{3/2}$ for $5\le s\le11$, which the commit states, and $M(n-1)\le\theta_0(n)$ at odd $n-1$, which it does not. The commit message closes on the observation that *"an unstated inheritance of exactly that kind is what sank S1's induction"*; the same sentence applies to the paragraph that carries it.

---

## Claim 2, is the route fenced?

Evidence: [c2_fence.py](../scripts/reviewers/r282/c2_fence.py), [out_c2.txt](../scripts/reviewers/r282/out_c2.txt).

**Post by post, the answer is no, and the reason is structural rather than case-by-case.** Every post on the list fences a *bound on $\theta$ built from data that padding leaves fixed*. The dichotomy's input is $s$, which padding is the only thing that moves, so no post can reach it. Individually:

| post | what it fences | does it reach the dichotomy? |
|---|---|---|
| 6 | spectral moments of $L_W$ | no, a different route, and its quantity is not even padding-invariant (claim 3) |
| 26 | a relaxation exact at the coordinate-diagonal end $t=\lVert K\rVert_F^2=2$ and monotone below it | no, the dichotomy is not monotone in $t$ and does not pass through $K$ |
| 33 | $p_3(\omega)$ from two moments plus a one-sided support bound | no, $s$ is not a moment of $\omega$ |
| 34 | $\lvert\langle M^\#,M\rangle\rvert\le\lVert M^\#\rVert_F$ | no, no Cauchy–Schwarz step occurs |
| 35 | a norm-type cap converted to $\theta$ on $\circ$-indecomposables | no, $\theta\le M(s)$ is a restriction, not a conversion |
| 7 | *"every candidate inequality must see the crossover $n=6+2\sqrt7$"* | **satisfied**, not violated: the split at $s\le11$ against $s\ge12$ **is** that crossover, since $\theta_0(11)<\sqrt{3/2}<\theta_0(12)$ |

**[nondegeneracy.md](../findings/nondegeneracy.md)'s padding material does not fence it either.** Line 328, *"padding leaves $\theta$ unchanged, so it is the $b=0$ degenerate case and the law says nothing about it"*, is a limitation of the **sum law** $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$, which the dichotomy never invokes. Line 372 goes the other way and *supports* the route: *"padding is a critical-point-preserving operation, exactly … $Q$ commutes with padding bit for bit"*, which is claim 1(a)'s third ingredient already proved on file.

### What the plan does not say: the dichotomy deletes post F35's witness, and post F34 takes over the ground

Post F35's entire content is one witness, padded $W_{\mathbb{CP}^2}$ carrying $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F=1+1/\sqrt6=1.408248290464$ identically for $n=4\dots16$ while $\theta_0(n)$ first reaches it near $n=356$. That witness has $s=4$ (reconfirmed here at $n=12,14,16$). **On the full-support residual it does not exist**, so a cap on $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F$ restricted to full-support points is not refuted by post F35, and the dichotomy would reopen it.

**It reopens nothing in practice, because post F34's witness is full support.** Riemannian ascent on $F(M)=\operatorname{tr}(M^3)+\lVert M^\#\rVert_F$ over the unit sphere of $\mathrm{Weyl}_n$, with the analytic gradient $3M^2+2(M\#M^\#)/\lVert M^\#\rVert_F$, using the trilinear symmetry of $\langle A\#B,C\rangle$ verified to $0$ at $n=6$, reproduces post F34's four recorded ratios exactly and adds the support:

| $n$ | $\max F/\theta_0$ | post F34 records | $s$ at the maximiser | $\theta/\theta_0$ there |
|---|---|---|---|---|
| $6$ | $1.3403$ | $1.3403$ | $6$ | $1.1573$ |
| $8$ | $1.2399$ | $1.2399$ | $8$ | $1.0590$ |
| $10$ | $1.1881$ | $1.1881$ | $10$ | $1.0075$ |
| $12$ | $1.1564$ | $1.1564$ | $12$ | $0.9757$ |

**Full support at every dimension**, so post F34's *"the loss runs the wrong way"* survives the restriction intact, and with it the closure of that quantity. **The dichotomy is unfenced and it un-fences nothing**, which is a fairer statement of its position than *"not fenced by anything on the list"* alone.

---

## Claim 3, the stall summary and its retraction

Evidence: [c3_padding_invariance.py](../scripts/reviewers/r282/c3_padding_invariance.py), [out_c3.txt](../scripts/reviewers/r282/out_c3.txt).

### The retraction is right, and it is undersold

*"The record contains no padding-distinguishing quantity that is defined on all of $\mathrm{Weyl}_n$"* is false, and $s$ refutes it. **But the record already contained the whole construction**, so this is a re-finding rather than a discovery, and that matters for how much the route can claim to be new:

- [stratum-two-negative.md](../findings/stratum-two-negative.md) states **Proposition (padding reduction)**: a $W$ whose two negative eigenvectors have skew ranks summing below $n$ *"is the padding of some $W'\in\mathrm{Weyl}_{n-1}$, with $\lVert W'\rVert=\lVert W\rVert$, $\theta(W')=\theta(W)$"*, the padding transfer, proved.
- The same file runs the descent: *"the induction runs down to $n=r$, where $r$ is the larger **support dimension**"*, bottoming at $r=4$ where $\max P=\sqrt{3/2}$ *"is on record and proved"*. That is the padding dichotomy, with the same base case, written before the commit that says the record has no such quantity.
- [plan.md](../plan.md)'s own **section 2** lists *"the support descent"* among the machinery route S consumes as filed, three paragraphs above the sentence that denies it exists.

So the overreach was not a gap in the record but a failure to read it, and the correction restores something that was already filed.

### The surviving claim, post F6 breaks it, post F26 is misdescribed

*"Posts 6, 26, 33, 34, 35 all bound padding-invariant quantities while $\theta_0(n)$ grows."* One fixed unit $W\in\mathrm{Weyl}_6$, padded to $n=7$ and $8$, every quantity recomputed in the larger dimension:

| quantity | post | $n=6$ | $n=7$ | $n=8$ | padding-invariant? |
|---|---|---|---|---|---|
| $\operatorname{tr}(L_W^2)$ | 6 | $13.750000$ | $19.500000$ | $26.250000$ | **no** |
| $\operatorname{tr}(L_W^3)$, at padded $W_{\mathbb{CP}^2}$ | 6 | $-0.867528$ | $-0.306186$ | $+0.459279$ | **no, it changes sign** |
| $p_2(\omega),p_3(\omega)$, at padded $W_{\mathbb{CP}^2}$ | 33 | $3.000000,\ 1.224745$ | same | same | yes |
| $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F$ | 34, 35 | $1.408248290464$ | same | same | yes |
| $P$ |, | $1.224744871392$ | same | same | yes (the control) |

**Post F6 is not an instance of the pattern.** Its quantity is the spectrum of $L_W(H)=B(W,H)$ on $\mathrm{Weyl}_n$, and the record's own trace identity $\operatorname{tr}(L_W^2)=\tfrac{(n-1)(2n-1)}4\lVert W\rVert^2$ ([ATTEMPTS.md](../ATTEMPTS.md) line 439) makes the $n$-dependence explicit, reproduced to the digit here at $n=6,7,8$ from an independently built $L_W$ on the exact Weyl basis ($84$, $168$, $300$ dimensions). Post F6 fails for the *opposite* reason to the pattern: it has $n$-dependence to spare and no information, its second moment being *only* a function of $\lVert W\rVert$. *What is padding-invariant at post F6 is $\lambda_{\max}(L_W)$, $0.750618$ and $1.224745$ across all three dimensions, but that is not what post F6 bounds.*

**Post F26 is misdescribed rather than false.** Its *inputs* ($t=\lVert K\rVert_F^2$ and the two spectra) are padding-invariant, but its mechanism is monotonicity in $t$ with exactness at the coordinate-diagonal end, and the bound it fences **equals $\theta_0(n)$ at $t=2$**, so it is $n$-sensitive by construction and cannot be an instance of "padding holds it fixed while $\theta_0$ grows".

**Posts 33, 34 and 35 do carry the pattern**, and post F35 states it itself: *"zero-padding is exact, which is what makes the witness $n$-independent"*. Posts 34 and 35 are the same quantity, so the true count is **three posts and two quantities**, not five.

### Post F26 is cited and never defined

`grep` over [fence-posts.md](../findings/fence-posts.md) finds posts $1$, $2$, $2b$–$2g$, $3$–$10$, $23$–$25$ and $30$–$35$, and **no post F26**. The number appears only in citations, [plan.md](../plan.md) at both `f27eb56` and `c079378`, [ad-form-attempt.md](../findings/ad-form-attempt.md) line 32, and [REVIEW_r274.md](REVIEW_r274.md), which quotes it from [bispectral.md](../findings/bispectral.md) where the statement sits unnumbered. The posts are in fact scattered, $11$, $13$, $14$ in [second-order.md](../findings/second-order.md), $15$, $16$, $21$ in [bounds.md](../findings/bounds.md), $22$ in [target.md](../findings/target.md), so a citation to "the list" resolves to no list, and r274's verdict that **post F26 fails at its own anchor** has nowhere to land.

---

## Claim 4, the one-line theorem and the r279/r280 reconciliation

Evidence: [c4_criticality.py](../scripts/reviewers/r282/c4_criticality.py), [out_c4.txt](../scripts/reviewers/r282/out_c4.txt).

### With $A_i\circ A_j=0$ as hypothesis, criticality is genuinely unused, confirmed

Two random $\mathrm{Weyl}_4$ tensors padded onto the disjoint coordinate blocks $\{0,1,2,3\}$ and $\{4,\dots,7\}$ at $n=8$ are $\circ$-orthogonal ($\lVert A\circ B\rVert=0$ exactly) and **not critical**, criticality residuals $0.8052$ and $0.6611$. Additivity holds anyway:

$$P(aA+bB)=a^3P(A)+b^3P(B)\quad\text{to }10^{-16}\ \text{at }(a,b)=(0.6,0.8),\,(0.8,-0.6),\,(-0.5,\sqrt3/2).$$

So r279's half is right: the hypothesis does all the work, and nothing in the proof consults criticality. *Analytically the reason is one line: $\circ$-orthogonality kills every cross term of the cubic, and cross terms are the only place a first-order condition could enter.*

### But *"criticality derives $A_i\circ A_j=0$ from mere orthogonality"* is false, with a witness

Take $A$ = padded $W_{\mathbb{CP}^2}$ at $n=8$ and $B=g\cdot A$ for $g=\exp(tX)$, $X$ a random skew matrix, with $t$ root-found so that $\langle A,B\rangle=0$. Both are critical by equivariance, both unit, both at $P=1.224744871392$:

| $t$ | $\langle A,B\rangle$ | crit. residuals | $\lVert A\circ B\rVert$ |
|---|---|---|---|
| $0.281688525$ | $-9.0\times10^{-17}$ | $2.7\times10^{-16}$, $6.5\times10^{-16}$ | $\mathbf{0.626449}$ |
| $0.618044105$ | $6.9\times10^{-18}$ | $2.7\times10^{-16}$, $4.6\times10^{-16}$ | $\mathbf{0.356542}$ |
| $0.384647320$ | $2.5\times10^{-15}$ | $2.7\times10^{-16}$, $6.9\times10^{-16}$ | $\mathbf{0.398457}$ |

Criticality plus Frobenius orthogonality does **not** give $\circ$-orthogonality. The clause as written at `6bcf1b6` also has the implication pointing the wrong way, it offers to convert *"the free identity $\langle Q(A),B\rangle=0$ into $\langle A,B\rangle=0$"*, which is a scalar statement, where what is wanted is the tensor equation $A\circ B=0$.

### The statement neither reviewer had

**At each of those three witnesses additivity holds exactly anyway.** At $t=0.281688525$, $P((A+B)/\sqrt2)=0.866025404$ against $a^3P(A)+b^3P(B)=0.866025404$, and the same at $(a,b)=(0.6,0.8)$ and $(0.8,0.6)$, all to nine digits. So on critical Frobenius-orthogonal pairs, **$\circ$-orthogonality is sufficient for additivity and not necessary**, the theorem's hypothesis is strictly stronger than what its proof consumes, and the honest reconciliation is three-way rather than two-way: r279 right about the hypothesis, r280 right that criticality buys something, and what it buys is *additivity direct*, never $\circ$-orthogonality.

### The chain as written, and the one-line repair

At `6bcf1b6` the display reads $P(W)=\sum a_i^3P(A_i)\le M(n)\sum a_i^3\le M(n)\max_ia_i<M(n)$. The first inequality needs $a_i^3\ge0$. With two pieces at $\pm M(n)$ and $(a,b)=(0.6,-0.8)$ the two sides are $+0.891614$ and $-0.362524$, **the chain inverts**. *The theorem is unharmed*: replacing $A_i$ by $-A_i$ and $a_i$ by $-a_i$ preserves unit norm, $\circ$-orthogonality and the sum, so one may assume every $a_i>0$; alternatively $\lvert P(A_i)\rvert\le M(n)$ by oddness gives $\sum\lvert a_i\rvert^3$ directly. The working tree already carries the second repair.

---

## Claim 5, $\Theta_5=\sqrt{3/2}$ as now recorded

Evidence: [c5_theta5.py](../scripts/reviewers/r282/c5_theta5.py), [out_c5.txt](../scripts/reviewers/r282/out_c5.txt).

**The Lovelock collapse, from the definitions.** On random unit Weyl operators, $\max\lvert\langle W,W^\#\rangle-2\operatorname{tr}(W^3)\rvert$ over twelve samples is $4.4\times10^{-16}$ at $n=4$, $2.4\times10^{-16}$ at $n=5$, and then $6.8\times10^{-2}$ at $n=6$ and $1.3\times10^{-1}$ at $n=7$, exactly the $n\le5$ scope the record claims, computed through the structure-constant $\#$ rather than through the chirality splitting that first gave it.

**Hence the identity.** $P(W)=\operatorname{tr}(W^3)+\langle W,W^\#\rangle=3\operatorname{tr}(W^3)$ on $\mathrm{Weyl}_5$, so $9\operatorname{tr}(W^3)^2=P(W)^2$ and

$$F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2=\tfrac32\lVert W\rVert^6-P(W)^2\qquad\textbf{identically on }\mathrm{Weyl}_5,$$

checked at four non-unit norms ($\lVert W\rVert$ from $0.033$ to $1.460$) with residual $\le9\times10^{-16}$, so the $\lVert W\rVert^6$ homogeneity is verified rather than assumed.

**SOS $\Rightarrow$ the bound.** A sum of squares is nonnegative, so $F_5\ge0$; at $\lVert W\rVert=1$ that is $P(W)^2\le\tfrac32$, i.e. $\lvert P\rvert\le\sqrt{3/2}$; $P$ is odd, so $\max P=\max\lvert P\rvert$, and the padded $W_{\mathbb{CP}^2}$ attains it. **$\Theta_5=\sqrt{3/2}$.** No adequacy theorem is owed, because a certificate in hand is one-directional. Independent confirmation without any certificate: projected ascent over $\mathrm{Weyl}_5$ from $60$ restarts returns $1.224744871391589$ against $\sqrt{3/2}=1.224744871391589$.

**The certificate verifies.** [run_n5_verify.py](../scripts/runs/run_n5_verify.py) runs clean here, $47$ coordinates, block shape $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$, every block positive definite both as packed and with off-diagonals halved, by alternating charpoly coefficients over $\mathbb Q$.

**One thing around it is not clean.** [sym3-blocks.md](../findings/sym3-blocks.md) still presents the $40$-equations step as *"$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes. Equal dimensions force equal kernels"*, the very argument [run_n5_verify.py](../scripts/runs/run_n5_verify.py) now prints as **circular** after reviewer 214 (*"it compared $\mathrm{rank}(\mathrm{ev}\cdot\mu)$ with $\mathrm{rank}(\mu)$ and called both measured; only the first is"*), having replaced it with reviewer 213's argument that every row entry and $F_5$ alike are $O(5)$-invariant sextics in a $14$-dimensional space where $120$ explicit contractions attain rank $14$ at those points. The script's version is sound; the findings file carries the retracted one. **The result is not at risk, only its stated reason is.**

---

## Claim 6, the r259–r280 sweep and the index

**Missing index rows, r279's finding, unrepaired.** [reviews/INDEX.md](INDEX.md) runs $\dots$ 274, 275, 276, 277, 278, 279, 280, 281 and then jumps from **268 to 274**. Five reports have no row: [REVIEW_r269.md](REVIEW_r269.md), [REVIEW_r270.md](REVIEW_r270.md), [REVIEW_r271.md](REVIEW_r271.md), [REVIEW_r272.md](REVIEW_r272.md) (the first four salvaged partials) and [REVIEW_r273.md](REVIEW_r273.md), which is a **full report on the ad-form / Cauchy–Schwarz route** and the co-source of post F34. A full report absent from the index is the more expensive of the two failures.

**Unapplied verdicts still live in the tree:**

1. **[sym3-blocks.md](../findings/sym3-blocks.md) contradicts itself twelve lines apart.** Line 111: *"THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM"*, with line 113 boxing $\mathrm{rank}=13$, $\dim\mathrm{ANN}=1$. Line 123: *"On the restricted space the argument does not carry, and the rank is open in $[1,13]$."*
2. **The circular $40$-equations argument** (claim 5 above) is still the one the findings file gives.
3. **The stale heading**, line 136 still reads *"What the certificate **would** establish"* over a section whose first sentence is *"$\Theta_5=\sqrt{3/2}$, DECIDED, and the certificate proves it"*. r280 filed this; unrepaired.
4. **Post F26 has no definition** anywhere in the record (claim 3), so r274's *"post F26 failed at its own anchor"* is recorded only in [ad-form-attempt.md](../findings/ad-form-attempt.md) line 32 with an explicit note that it *"is a separate matter for fence-posts.md"*, which has no post F26 to correct.
5. **Applied, and confirmed applied:** r280's items on [findings/INDEX.md](../findings/INDEX.md) line 38 (now *"proved by an exact rational SOS certificate"*) and the $\Theta_5$ status in [plan.md](../plan.md).

**Out of scope but recorded.** `c079378` landed during this review and replaced the reviewed routing block outright: route S and the padding dichotomy are gone, and routes **D** (prove the maximiser is diagonalisable) and **F** (an invariant cone for $\dot W=Q(W)$) stand in their place. Two carry-overs are worth noting. It repeats *"posts 6, 26, 33, 34, 35"* verbatim, so claim 3's refutation at post F6 applies to the new text unchanged. And its line 33 links *"[Post F22]"* to [fence-posts.md](../findings/fence-posts.md), where post F22 does not live, it is in [target.md](../findings/target.md) line 472.

---

## What I would change

1. **Strike *"posts 6, 26, 33, 34, 35 all bound padding-invariant quantities"*** and write the true, smaller statement: *posts 33, 34 and 35 bound two padding-invariant quantities between them, and post F35 says so itself*. Post F6's quantity is $n$-dependent by the record's own trace identity; post F26's mechanism is monotonicity in the diagonality parameter.
2. **Replace *"the residual is the full-support points"* with *"the residual is $s\ge12$"***, and state the induction that reduces $12\le s<n$ together with the case it cannot reach, $s=n-1$ odd, which needs the odd-dimensional conjecture. The commit's own closing sentence about unstated inheritances applies to itself.
3. **Credit [stratum-two-negative.md](../findings/stratum-two-negative.md)'s padding reduction** as the source. The support descent, the $\theta$-transfer and the $r=4$ base case are all already proved there; the dichotomy is that proposition read forward rather than a new quantity.
4. **Add index rows for r269–r273**, r273 first.
5. **Repair [sym3-blocks.md](../findings/sym3-blocks.md)** at three places: the rank contradiction at lines 111/123, the circular $40$-equations paragraph, and the *"would establish"* heading.
6. **Give post F26 a home**, or renumber. A cited post with no text is worse than an uncited fact, because r274's refutation of it cannot be applied.
