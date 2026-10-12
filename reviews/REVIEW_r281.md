# REVIEW r281, Gate 2, the padding dichotomy and the retracted obstruction

Reviewer 281. Commits under review: `f27eb56` (primary), `90ce9a5`, `bac2049`/`6bcf1b6`, `8ab7e82`.
Primary file: [plan.md](../plan.md) at `f27eb56`, the routing block and section 1. *The working tree has since moved: `c079378` replaced route S with routes D and F, so the block reviewed below is read from `git show f27eb56:plan.md`, not from the tree.*
Supporting: [findings/support-dichotomy.md](../findings/support-dichotomy.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/nondegeneracy.md](../findings/nondegeneracy.md), [findings/sym3-blocks.md](../findings/sym3-blocks.md), [findings/problem.md](../findings/problem.md), [reviews/REVIEW_r277.md](REVIEW_r277.md)–[REVIEW_r280.md](REVIEW_r280.md).
Scripts: [scripts/reviewers/r281/](../scripts/reviewers/r281/). Reviewer 282 runs the identical brief concurrently and independently.

Everything below is rebuilt from $Q(W)=W^2+W^\#$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $P(W)=\langle W,Q(W)\rangle$ through [review_r30_core.py](../scripts/review_r30_core.py), with criticality re-certified at each point. Support dimension is computed frame-covariantly as $\operatorname{rank}G$, $G_{ip}=\sum_{jkl}W_{ijkl}W_{pjkl}$, from the Riemann tensor rebuilt out of the $\Lambda^2$ operator.

| # | Claim | Verdict |
|---|---|---|
| 1 | The padding dichotomy | **(a) IS TRUE, AND IT IS TWO LINES, WHICH IS ALSO WHAT DRAINS THE ROUTE.** $G$ is the Gram matrix of the slices $W(e_i,\cdot,\cdot,\cdot)$, so it is PSD with $v^\top Gv=\lVert W(v,\cdot,\cdot,\cdot)\rVert^2$; all four slots are equivalent under the pair symmetries, so $W$ vanishes on $\ker G$ and **is** the padding of $W|_{\operatorname{im}G}\in\mathrm{Weyl}_s$. No non-padding of support $s$ exists. Hence $\theta\le M(s)$, but at $s=n$ that reads $\theta\le M(n)$, the definition of $M(n)$, so the dichotomy buys **nothing on its own residual**. (b) frame-covariance holds, $G\mapsto OGO^\top$, verified at a generic $O(12)$ frame where the rotated padded $W_{\mathbb{CP}^2}$ still returns $s=4$ and a restriction in $\mathrm{Weyl}_4$ with $P$ and $\lVert\cdot\rVert$ unchanged to $10^{-16}$. (c) $\sqrt{3/2}<\theta_0(n)$ for **all** $n\ge12$, $\theta_0$ strictly increasing, but $M(s)$ is **proved only at $s=4,5$**; $6\le s\le11$ is open, and the single method that ever produced one of these constants is recorded as not lifting past $5$. **AND THE STATEMENT IS INCOMPLETE FOR $n\ge14$**: it covers $s\le11$ and $s=n$ and leaves $12\le s<n$, including **odd** $s$, where no bound is proved even in the diagonal case |
| 2 | Is the route fenced? | **UNFENCED, AND FOR A REASON THAT COSTS AS MUCH AS IT SAVES.** No post applies, because $\theta\le M(s)$ is not a bound on $\theta$ at all (it is $M$'s definition composed with a restriction) and every post on the list fences a *bound*. It clears [post F7](../findings/fence-posts.md) by construction, splitting exactly at the crossover $6+2\sqrt7=11.29$; post F35's own witness ($\circ$-indecomposable padded $W_{\mathbb{CP}^2}$) is the point the route removes, so post F35 is answered rather than dodged. What is **not** unfenced is the cost: the $s\le11$ half is seven sharp constants, and [sym3-blocks.md](../findings/sym3-blocks.md) says of the $\Theta_5$ certificate *"It does not lift"*, the Lovelock collapse it runs on fails from $n=6$ |
| 3 | The stall summary and its retraction | **THE RETRACTION IS RIGHT; THE SURVIVING CLAIM IS FALSE AT POST F6 AND MISDESCRIBES POST F26.** $s$ is defined on all of $\mathrm{Weyl}_n$ and separates the two points ($4$ against $12$, reproduced), so *"the record contains no padding-distinguishing quantity"* is refuted in letter. But *"posts 6, 26, 33, 34, 35 all bound padding-invariant quantities"* holds for **two of five**: post F6's $\operatorname{tr}(L_W^2)=\frac{(n-1)(2n-1)}4\lVert W\rVert^2$ is **measured to change under padding**, $13.75\to19.50\to26.25$ for one fixed $W$ padded $6\to7\to8$, and post F6's own recorded diagnosis is a *directional* obstruction, not a padding one; post F26's mechanism is the $O(n)$-**frame orbit**, not padding; post F33's inputs are padding-invariant but its bound carries an explicit $N$-dependence. Posts 34 and 35 are exactly padding-invariant, $1.408248290464$ reproduced at $n=4\dots12$ |
| 4 | The one-line theorem and the r279/r280 reconciliation | **THE THEOREM IS TRUE, ITS DISPLAYED CHAIN IS INVALID AT NEGATIVE $a_i$, AND THE RECONCILIATION'S SECOND HALF IS INVERTED, WITNESSED.** The criticality-free half is right, and the unstated ingredient is **total symmetry of $T$**: $A_i\circ A_j=0$ gives $T(A_i,A_j,A_k)=0$ directly only for $i\ne j$; the case $T(A_i,A_i,A_k)$ needs $T(A_i,A_i,A_k)=T(A_i,A_k,A_i)$. The claim that *criticality derives $A_i\circ A_j=0$ from mere orthogonality* is **REFUTED**: two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ at $n=8$ have $\lVert A\circ B\rVert=0.664362$ (a rotated $S^4\times S^4$ pair gives $0.272738$). The sentence's own second clause states the true direction, $\circ$-orthogonality $+$ criticality $\Rightarrow\langle A,B\rangle=0$, so it contradicts itself. **And at $k=2$ the theorem holds under a strictly weaker hypothesis than $\circ$-orthogonality**, criticality plus ordinary orthogonality already gives exact additivity, verified at both witnesses to $10^{-16}$ |
| 5 | $\Theta_5$ as recorded | **CONFIRMED, all three steps.** $P(W)=3\operatorname{tr}(W^3)$ identically on $\mathrm{Weyl}_5$ (relative $6\times10^{-14}$ at $n=4,5$; ratio off by $1.05$ and $1.18$ at $n=6,7$), so $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2=\tfrac32\lVert W\rVert^6-P(W)^2$ at every scale (checked at $\lVert W\rVert^2$ from $63$ to $159$, agreement to the last digit). $F_5\ge0\iff\lvert\theta\rvert\le\sqrt{3/2}$ is one line of algebra, and SOS $\Rightarrow$ nonneg is the trivial direction. [run_n5_verify.py](../scripts/runs/run_n5_verify.py) re-run here: all $16$ blocks positive definite over $\mathbb Q$ in both normalisations |
| 6 | The r259–r280 sweep | **THREE ITEMS UNAPPLIED, and one of them is r279's and r280's own.** [reviews/INDEX.md](INDEX.md) still has **no index row for r269–r273**, though all five report files exist, the rows run $259$–$268$, then jump to $274$. [sym3-blocks.md](../findings/sym3-blocks.md) still heads the deciding section *"What the certificate **would** establish"* and still carries *"consistency is exactly the open necessary condition: $F_5$ must lie in the image, or the route dies"* above the paragraph that closes it. And r280's claim-1 finding (that the definition of $\circ$-decomposable was missing), was answered by adding a definition whose reconciliation paragraph is the one refuted in claim 4 |

---

## Claim 1, the padding dichotomy, link by link

### (a) THE CRUX: support $s$ **does** force a padding, and the proof is two lines

Write $R_{ijkl}=\langle W\varphi_{ij},\varphi_{kl}\rangle$ for the Riemann tensor of $W\in\mathrm{Weyl}_n$, and $G_{ip}=\sum_{jkl}R_{ijkl}R_{pjkl}$.

1. **$G$ is a Gram matrix.** $G_{ip}=\langle R(e_i,\cdot,\cdot,\cdot),R(e_p,\cdot,\cdot,\cdot)\rangle$, so $G$ is symmetric PSD and $v^\top Gv=\lVert R(v,\cdot,\cdot,\cdot)\rVert^2$. Hence $\ker G=\{v:R(v,\cdot,\cdot,\cdot)=0\}$, *an equality, not an inclusion*. Verified: $\max_a\big\lvert\,\lVert R(v_a)\rVert^2-v_a^\top Gv_a\big\rvert\le6.7\times10^{-16}$ over the full eigenframe at padded $W_{\mathbb{CP}^2}$, at $S^6\times S^6$, and at a random $\mathrm{Weyl}_7$ point.
2. **All four slots are equivalent.** $R_{ijkl}=-R_{jikl}=R_{klij}$, so $v\in\ker G$ kills $R$ in *every* slot. With $V=(\ker G)^\perp=\operatorname{im}G$, $\dim V=s=\operatorname{rank}G$, this gives $R\in S^2(\Lambda^2V)$: $W$ **is** the zero-padding of $W|_V$. Measured: $\max\lvert R\rvert$ over entries touching $\ker G$ is $0.000\mathrm e{+}00$ at padded $W_{\mathbb{CP}^2}$ ($n=12$), at $S^6\times S^6$ padded to $n=14$, and at a random $\mathrm{Weyl}_6$ padded to $n=9$.
3. **The restriction is again Weyl.** $\sum_{a=1}^nR_{iajа}$ splits as $\sum_{a\in V}+\sum_{a\in\ker G}$ and the second sum vanishes term by term, so $\operatorname{tr}_V(W|_V)=\operatorname{tr}_n(W)=0$; Bianchi restricts. So $W|_V\in\mathrm{Weyl}_s$, and $s\ge4$ since $\mathrm{Weyl}_3=0$.
4. **$P$ and $\lVert\cdot\rVert$ are padding-invariant**, [nondegeneracy.md](../findings/nondegeneracy.md)'s $[\Lambda^2V,\Lambda^2V]\subseteq\Lambda^2V$, so $W^\#$ stays in the block. Hence $\theta(W)=\theta(W|_V)\le M(s)$.

**So there is no Weyl tensor of support $s$ that is not a padding of a $\mathrm{Weyl}_s$ element.** The brief asks for a witness or a proof that none exists; the proof is the four steps above, and the searches confirm it: six random seeds in $\mathrm{Weyl}_{n_0}$, $n_0\in\{4,5,6\}$, embedded on a **random** (non-coordinate) subspace of $\mathbb R^8$ all return $\operatorname{rank}G=n_0$ with $P$ and $\lVert W\rVert^2$ agreeing to the last digit between $n=8$ and $n=n_0$.

> **The consequence the plan does not draw.** Because step (a) is a tautology, so is the dichotomy: *every* $W$ has $s\le n$, and $\theta\le M(s)$ at $s=n$ says $\theta\le M(n)$, which is the definition of $M(n)$. The route's whole content is therefore the $s<n$ strata, and at $n=12$ that content is exactly *"padded points are not maximisers"*.

### (b) The support dimension is well defined and frame-covariant

$G(O\cdot W)=OG(W)O^\top$ by four orthogonal contractions, so $\operatorname{rank}G$ is an $O(n)$-invariant, and $\operatorname{im}G$ is the *smallest* $V$ with $W\in S^2(\Lambda^2V)$ (any such $V$ has $V^\perp\subseteq\ker G$). Tested at a generic $O(12)$ frame:

| point | $n$ | $s$ | $P$ | note |
|---|---|---|---|---|
| $S^6\times S^6$ | $12$ | $\mathbf{12}$ | $1.236033081183$ | $=\theta_0(12)$ |
| padded $W_{\mathbb{CP}^2}$, coordinate frame | $12$ | $\mathbf4$ | $1.224744871392$ | $=\sqrt{3/2}$ |
| the same, rotated by a random $O(12)$ | $12$ | $\mathbf4$ | $1.224744871392$ | $\min\operatorname{eig}G=-5.5\times10^{-16}$ |
| random $\mathrm{Weyl}_n$ | $6,7,8$ | $n$ |, | full support is generic |

The rotated point's restriction to $\operatorname{im}G$ has $\max\lvert\text{Bianchi}\rvert=4.1\times10^{-15}$, $\max\lvert\mathrm{Ric}\rvert=4.1\times10^{-15}$, carries the whole norm ($4.000000000000$ of $4.000000000000$), and gives $P=1.224744871392$ recomputed **at $n=4$**. **The plan's measured pair $s=4$ against $s=12$ is confirmed.**

### (c) $\sqrt{3/2}<\theta_0(n)$, and what is actually known about $M(s)$

$\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}>\frac32\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915$, and $\frac{d}{dn}\theta_0(n)^2=\frac{2(3n-4)}{n^3}>0$. **So $\sqrt{3/2}<\theta_0(n)$ for every $n\ge12$, even or odd**, and the plan's *"$<\theta_0(12)$"* is the weakest form of a monotone statement. The commit's *"$\theta\le\theta_0(s)$ is false at the sharp point, $1.2247$ against $\theta_0(4)=0.866$"* is correct.

$M(s)$, from the record and from $40/20/10$ projected ascents per dimension run here:

| $s$ | $\dim\mathrm{Weyl}_s$ | $\max P$ found | status |
|---|---|---|---|
| $4$ | $10$ | $1.224744871392$ | **proved**, the $\mathfrak{so}(4)$ chirality split and Okumura ([post F2c](../findings/fence-posts.md)) |
| $5$ | $35$ | $1.224744871392$ | **proved**, claim 5 below |
| $6\dots11$ | $84\dots1144$ | $1.224744871392$ at every $s$, excess $\le1.1\times10^{-15}$ | **open** |
| $12$ | $1638$ | $1.236033081183=\theta_0(12)$ | the conjecture |
| $13$ | $2275$ | $1.248375567865=\sqrt{120/77}$ | the conjecture, odd case |

The numerical half of *"if $M(s)=\sqrt{3/2}$ for $s\le11$"* is in good shape, every ascent from $s=4$ to $s=11$ lands on $\sqrt{3/2}$ to the sixteenth digit, and $s=12,13$ land on the two published values. **The analytic half has one method on record and it is recorded as not lifting.** $\Theta_5$ is proved through $P=3\operatorname{tr}(W^3)$, the Lovelock collapse, which [post F2g](../findings/fence-posts.md) proves holds *only* for $n\le5$; [sym3-blocks.md](../findings/sym3-blocks.md) closes the $\Theta_5$ section with *"It does not lift. Trace-word transfer needs the stable range, and $n=5$ carries the Lovelock syzygy."*

> **THE GAP IN THE STATEMENT, and it is not cosmetic.** *"Every point of support $\le11$ has $\theta\le\sqrt{3/2}<\theta_0(12)$, leaving full-support points as the residual"* is a complete dichotomy **at $n=12$ only**. At $n=14$ a point of support $12$ or $13$ is neither. Repairing it means running the whole statement as an induction on $n$, which needs $M(s)\le\theta_0(n)$ for every $12\le s<n$, and for **odd** $s$ that is a bound the record calls conjectural even in the granted diagonal case ([problem.md](../findings/problem.md): *"Odd $n$ is not addressed"*). The measured $M(13)=\sqrt{120/77}=1.2484<\theta_0(14)=1.2618$ says the induction is *consistent*; it is not proof, and the plan names neither the induction nor its odd-dimensional cost. **That is the same unstated inheritance the commit says sank S1's induction, one paragraph after saying so.**

---

## Claim 2, is the route fenced?

**Verdict: nothing on the list touches it, and the reason is structural rather than lucky.**

| post | what it fences | does it reach the dichotomy? |
|---|---|---|
| 6 | spectral moments of $L_W$ | **no**, the dichotomy computes no spectrum of $L_W$ |
| 7 | an inequality that does not change character at $6+2\sqrt7$ | **no, it is cleared by construction.** The dichotomy's split is $s\le11$ against $s\ge12$, i.e. exactly at $6+2\sqrt7=11.2915$. Of every route on the record this is the only one that satisfies post F7 by its own shape |
| 26 | one-sided second-kind cubic caps; bounds exact at $t=2$ and monotone below | **no**, $s$ is not a function of $t=\kappa^2$, and the route never uses the diagonal parameter |
| 33 | two moments plus a one-sided support on $\omega$ | **no**, $s$ is not a moment of either spectrum |
| 34 | Cauchy–Schwarz on $\langle M^\#,M\rangle$ | **no**, no relaxation of the sharp term is taken |
| 35 | any cap on $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F$ converted by the harmonic-square law | **no, and it is *answered*.** Post F35's witness is padded $W_{\mathbb{CP}^2}$, $\circ$-indecomposable, carrying $1+1/\sqrt6$ at every $n$. The dichotomy removes that point by its support ($s=4$) rather than by a conversion, which is precisely the hole post F35 names |
| 31 | a constant SOS certificate cannot hit a rational sharp family | **no**, no certificate is proposed |

**Why no post can apply.** Every post on the list fences a *bound on $\theta$*. $\theta\le M(s)$ is not a bound on $\theta$: $M$ is defined as the supremum, so the inequality is a restriction map composed with a definition. A statement with no estimate in it cannot fail an estimate's fence. *That is also why it cannot succeed on its own*, see claim 1's box.

**The "padding is the $b=0$ degenerate case" material does not fence it either, and it corroborates it.** [nondegeneracy.md](../findings/nondegeneracy.md) line 328: *"Padding leaves $\theta$ unchanged, so it is the $b=0$ degenerate case and the law says nothing about it"*, a statement about the block-sum law's reach, and the dichotomy is a *different* instrument that reaches exactly the case the sum law drops. The same file supplies the route's step 4 for free (line 372: $Q$ commutes with padding, $\max\lvert Q_n(\mathrm{pad}\,W)-\mathrm{pad}\,Q_{n_0}(W)\rvert=0.0$).

**Where the route is genuinely exposed** is not a fence post but an arithmetic fact the plan states and then underweights: the residual at $n=12$ is $\{s=12\}$, which is open and dense in $\mathrm{Weyl}_{12}$ and contains the conjectured maximiser. The dichotomy is a statement about a measure-zero complement.

---

## Claim 3, the retraction is right, the surviving claim is not

### The retraction: correct in letter

`90ce9a5` recorded *"the record contains no padding-distinguishing quantity defined on all of $\mathrm{Weyl}_n$"*. $s=\operatorname{rank}G$ is defined on all of $\mathrm{Weyl}_n$, is $O(n)$-invariant, and takes $4$ at padded $W_{\mathbb{CP}^2}$ against $12$ at $S^6\times S^6$, reproduced independently here. **The retraction in `f27eb56` stands.**

*One clarification the retraction owes.* $s$ is itself padding-**invariant** in the strict sense $s(\mathrm{pad}\,W)=s(W)$ (the commit says as much (*"which is exactly what padding holds fixed"*)) so the two words are being used for two different things: *padding-invariant* for $f(\mathrm{pad}\,W)=f(W)$, *padding-distinguishing* for separating a padded point from a full-support point at fixed $n$. Under the first reading $s$ is a member of the class the obstruction names, not a counterexample to it. **The retraction survives only on the second reading, and the record uses the first two sentences earlier.**

### The surviving claim: false at post F6, wrong mechanism at post F26

*"Posts 6, 26, 33, 34, 35 all bound padding-invariant quantities while $\theta_0(n)$ grows."* Checked one at a time, with one fixed unit $W\in\mathrm{Weyl}_6$ padded to $n=7,8$:

| post | quantity it bounds | padding-invariant? |
|---|---|---|
| **6** | $\operatorname{tr}(L_W^2),\operatorname{tr}(L_W^3)$ | **NO.** $\operatorname{tr}(L_W^2)=13.75\to19.50\to26.25$ at $n=6,7,8$ for the *same* $W$, matching $\frac{(n-1)(2n-1)}4\lVert W\rVert^2$ exactly; $\operatorname{tr}(L_W^3)=0.0200\to0.1199\to0.2475$. The coefficients in [ATTEMPTS.md](../ATTEMPTS.md)'s identities are $n$-dependent, so the invariance fails *by construction* |
| 26 | $p_3(\mu)$ one-sided; bounds monotone in $t=\kappa^2$ | **NOT BY PADDING.** Its second half's mechanism is stated in the record as the balanced product's own $O(n)$-**frame orbit** sweeping $t\in[0.003,2]$ with $\theta$ invariant, a frame statement. Its first half is a numeric comparison at $n=12$ |
| 33 | $p_1(\omega),p_2(\omega)=\tfrac34\lVert W\rVert^2$, support $\omega_i\ge-m$ | **INPUTS YES, BOUND NO.** $p_3^{\min}=\frac9{16mN}-\frac{3m}4$ carries $N=\dim S^2_0$ explicitly, and the recorded overshoot moves, $+0.777/+0.746/+0.717$ at $n=12/24/100$ |
| 34 | $\operatorname{tr}(M^3)+\lVert M^\#\rVert_F$ | **YES** |
| 35 | the same | **YES, exactly**, $1.408248290464$ reproduced here at $n=4,5,6,8,10,12$ on padded $W_{\mathbb{CP}^2}$, against $\theta_0(n)=0.866\dots1.236$ |

**So the pattern is two of five, not five of five.** Post F6's own recorded diagnosis says something incompatible with the padding story, *"the obstruction is DIRECTIONAL, not dimensional"* ([second-order.md](../findings/second-order.md) line 53), and *"$\operatorname{tr}(L_W^2)$ is a constant multiple of $\lVert W\rVert^2$: it carries literally no information about $W$ beyond its norm"* ([ATTEMPTS.md](../ATTEMPTS.md)). A quantity carrying no information about $W$ at all fails for a reason that has nothing to do with padding. **The stall summary generalised from posts 34 and 35 (which are one post twice, the same quantity), to a list of five.** That is the same error class as the retracted sentence, in the same commit, and `f27eb56` retracts only the conclusion while keeping the premise.

---

## Claim 4, the theorem, the chain, and the reconciliation

### The theorem is true, and one step of the displayed chain is not

$$P(W)=\sum_ia_i^3P(A_i)\;\le\;M(n)\sum_ia_i^3\;\le\;M(n)\max_ia_i\;<\;M(n).$$

**The first inequality is invalid whenever some $a_i<0$**, which the definition explicitly permits (*"all $a_i\ne0$"*, $\sum a_i^2=1$). At a coordinate-disjoint pair in $\mathrm{Weyl}_8$ with $a=-0.6$ and $P(A)=-0.084156$: $a^3P(A)=+0.018178$ while $a^3M=-0.2808$, so $a^3P(A)\le a^3M$ is **false**. The repair is the file's own later sentence ($P$ is odd, so $\lvert P(A_i)\rvert\le M(n)$), giving $P(W)\le M(n)\sum_i\lvert a_i\rvert^3\le M(n)\max_i\lvert a_i\rvert<M(n)$. **Absolute values are needed in the display, in both places.**

### The unstated ingredient in additivity is total symmetry of $T$

$A_i\circ A_j=0$ for $i\ne j$ gives $T(A_i,A_j,A_k)=\langle A_i\circ A_j,A_k\rangle=0$ **only when $i\ne j$**. The remaining cross terms are $T(A_i,A_i,A_k)=\langle Q(A_i),A_k\rangle$, which the hypothesis does not touch directly; they vanish because $T$ is totally symmetric, $T(A_i,A_i,A_k)=T(A_i,A_k,A_i)=\langle A_i\circ A_k,A_i\rangle=0$. Symmetry verified to $0.00\mathrm e{+}00$ spread on three random $\mathrm{Weyl}_8$ points. Additivity then verified on a **non-critical** $\circ$-orthogonal pair (residuals $0.87$ and $0.86$) at four $(a,b)$ including two negative coefficients, agreement $\le5.6\times10^{-17}$. **So r279's half of the split is right, and the file's *"nothing else is used"* is one ingredient short.**

### The reconciliation's second half is REFUTED, and it contradicts its own next clause

> *"Criticality of the pieces is what one needs to **derive** $A_i\circ A_j=0$ from mere orthogonality, it converts the free identity $\langle Q(A),B\rangle=0$ into $\langle A,B\rangle=0$."*

**The witness.** Take $A_0=$ padded $W_{\mathbb{CP}^2}$ at $n=8$ (critical to $3.8\times10^{-16}$, $P=1.224744871392$) and $B=g\cdot A_0$ for $g=\exp(tS)\in SO(8)$ with $t=0.188296$ chosen so that $\langle A_0,B\rangle=-2.4\times10^{-17}$. $B$ is critical to $7.7\times10^{-16}$ with the same $P$. Then

$$\lVert A_0\circ B\rVert=\mathbf{0.664362}\ne0 .$$

A second, structurally different pair, $S^4\times S^4$ at $n=8$ and a rotated copy, $\langle A,B\rangle=-2.9\times10^{-15}$, criticality $7.3\times10^{-16}$, gives $\lVert A\circ B\rVert=0.272738$. **So criticality plus orthogonality does not derive $\circ$-orthogonality.** What it does derive is the *two* scalar conditions $\langle A\circ B,A\rangle=-3.8\times10^{-17}$ and $\langle A\circ B,B\rangle=9.7\times10^{-17}$, out of the $300$ dimensions of $\mathrm{Weyl}_8$.

**The clause after the dash states the true direction and is the converse of the clause before it.** $\langle Q(A),B\rangle=0$ is not "free", at generic $A,B$ it is nonzero; it is a *consequence* of $A\circ B=0$, and criticality then turns it into $\langle A,B\rangle=0$ when $\theta_A\ne0$. So the correct statement is

> $\circ$-orthogonality $+$ criticality $\Rightarrow\langle A,B\rangle=0$,

i.e. **criticality is what makes the definition's $\sum a_i^2=1$ compatible with $\lVert W\rVert=1$**, which is exactly r280's point, and exactly what its inverting witness ($\alpha=\beta=1$, $\langle u_A,u_B\rangle=-\tfrac12$) exhibits when that compatibility is dropped. The file reconciles the split by writing the implication backwards.

### And at $k=2$ the hypothesis can be weakened outright

$P(aA+bB)=a^3P(A)+b^3P(B)+3a^2b\,T(A,A,B)+3ab^2\,T(A,B,B)$, and for **critical** pieces $T(A,A,B)=\theta_A\langle A,B\rangle$, $T(A,B,B)=\theta_B\langle A,B\rangle$. So orthogonality alone kills both cross terms. Verified on the two witnesses above, where $\lVert A\circ B\rVert$ is $0.664$ and $0.273$, nowhere near zero, at six $(a,b)$ including negative coefficients, agreement $\le6.9\times10^{-15}$:

| pair | $(a,b)$ | $P(aA+bB)$ | $a^3P(A)+b^3P(B)$ |
|---|---|---|---|
| rotated $W_{\mathbb{CP}^2}$ | $(0.6,0.8)$ | $+0.891614266373$ | $+0.891614266373$ |
| rotated $W_{\mathbb{CP}^2}$ | $(-0.6,0.8)$ | $+0.362524481932$ | $+0.362524481932$ |
| rotated $S^4\times S^4$ | $(0.6,0.8)$ | $+0.834028776482$ | $+0.834028776482$ |

**The scope is exactly $k=2$**: at $k=3$ the triple term survives, $T(A_0,B,C)=-0.103953$ at three mutually near-orthogonal critical points. So the theorem, for two pieces, holds under *critical and Frobenius-orthogonal*, a hypothesis strictly weaker than $\circ$-orthogonality and much easier to check, and one the file's *"the work moves into checking that a given splitting satisfies $\circ$-orthogonality at all"* sends the reader away from.

---

## Claim 5, $\Theta_5$, confirmed at every step

**Step 1, the Lovelock collapse.** $P(W)=3\operatorname{tr}(W^3)$ on $\mathrm{Weyl}_n$ for $n\le5$ and not beyond, at random points and random scales:

| $n$ | $\max$ relative $\lvert P-3\operatorname{tr}(W^3)\rvert$ | $\langle W^\#,W\rangle$ vs $2\operatorname{tr}(W^3)$ |
|---|---|---|
| $4$ | $3.2\times10^{-15}$ | $-4.569380977$ / $-4.569380977$ |
| $5$ | $6.0\times10^{-14}$ | $-9.704861841$ / $-9.704861841$ |
| $6$ | $1.05$ | $-16.946717$ / $-83.331800$ |
| $7$ | $1.18$ | $+129.093504$ / $+143.576107$ |

**Step 2, the identity.** $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ and $\tfrac32\lVert W\rVert^6-P(W)^2$ agree at five random non-unit points, $\lVert W\rVert^2$ from $63.5$ to $159.0$, to the printed digit (largest absolute discrepancy $5.8\times10^{-11}$ on values of order $5\times10^5$, i.e. $10^{-16}$ relative).

**Step 3, SOS $\Rightarrow$ the bound.** $F_5=\sum_aq_a^2\Rightarrow F_5\ge0\Rightarrow P^2\le\tfrac32\lVert W\rVert^6\Rightarrow\lvert\theta\rvert\le\sqrt{3/2}$ at $\lVert W\rVert=1$. Only *SOS $\Rightarrow$ nonnegative* is used, which is one line of algebra; **Hilbert's non-adequacy governs the converse and is not consulted.** r279 and r280 are both right about this.

**Step 4, the certificate is real.** [run_n5_verify.py](../scripts/runs/run_n5_verify.py) re-run from the committed [n5_certificate.json](../scripts/runs/n5_certificate.json): block shape $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$ summing to $47$, every block positive definite by characteristic polynomials with alternating coefficients over $\mathbb Q$, in **both** the as-packed and off-diagonals-halved normalisations, no floating point. Attainment reproduced independently: a $40$-restart projected ascent on $\mathrm{Weyl}_5$ returns $\max P=1.224744871392$, excess $+1.1\times10^{-15}$, criticality residual $6.4\times10^{-9}$.

**Verdict: $\Theta_5=\sqrt{3/2}$ is proved, and the plan is entitled to list it under *Proved and audited*.** What is *not* entitled is [sym3-blocks.md](../findings/sym3-blocks.md)'s live text, see claim 6.

---

## Claim 6, the r259–r280 sweep

**1. [reviews/INDEX.md](INDEX.md) has no index row for r269–r273.** Rows present, in the numbered table: $259,260,261,262,263,264,265,266,267,268,274,275,276,277,278,279,280$, $17$ rows for $22$ reviewers. All five report files exist ([reviews/REVIEW_r269.md](REVIEW_r269.md) through [reviews/REVIEW_r273.md](REVIEW_r273.md)). **r279 reported this in its own claim 6 and it is unrepaired; r280's claim 6 lists four other items and does not carry this one.**

**2. [sym3-blocks.md](../findings/sym3-blocks.md) still contradicts itself on $\Theta_5$.** The deciding paragraph sits under the heading *"What the certificate **would** establish"*, and the section above it still carries *"$36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent, and consistency is exactly the open necessary condition: $F_5$ must lie in the image, **or the route dies**"* and *"This replaces an earlier '$F_5$ lies in the image', which assumed what the route exists to establish."* Both r279 and r280 asked for the heading and the adequacy line to be struck; neither is.

**3. The one item that *was* applied introduced the claim 4 defect.** r280's finding was that $\circ$-decomposable is never defined while criticality is load-bearing. `6bcf1b6` added the definition (correctly) and added a reconciliation paragraph whose second half is refuted above. **A repair that answers the audit and imports a new error is worth flagging as a class**: the reviewers' split was reconciled by asserting an implication neither reviewer claimed.

**4. A second live contradiction inside [sym3-blocks.md](../findings/sym3-blocks.md), which neither r279 nor r280 names.** The boxed line reads *"THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM"*; four paragraphs later the same file reads *"On the restricted space the argument does not carry, and the rank is open in $[1,13]$."* Both are current text in the same section.

**5. r274's post-26 verdict is applied in one file and not the other.** *"Post F26 failed at its own anchor"* is in [ad-form-attempt.md](../findings/ad-form-attempt.md) line 32; the post-26 row of [findings/INDEX.md](../findings/INDEX.md)'s fence table still states the fence flat, with no qualification, which matters here, since `f27eb56` cites post F26 as one of its five instances. *Of r259–r268 I checked only that the plan's ledger rows still point at live text; I did not re-derive them, and r279's and r280's verdicts on them stand unchallenged by me.*

**6. Out of scope but recorded**: `c079378` has already replaced the reviewed routing block. Route S is gone from [plan.md](../plan.md) and routes D and F stand in its place, both justified by the same sentence this review refutes in claim 3, *"Every fenced route (posts 6, 26, 33, 34, 35) tried to bound $\theta$"*. That version of the sentence is **true** (all five are bounds) where the reviewed version (*all five bound padding-invariant quantities*), is false. The new plan repaired the premise without saying it had.

---

## What I would change

1. **Strike *"posts 6, 26, 33, 34, 35 all bound padding-invariant quantities"*** and keep the true, narrower statement: posts 34 and 35 bound the *same* padding-invariant quantity, and post F35's witness makes the failure exact. One instance, stated twice, is not a pattern of five.
2. **State the dichotomy as an induction on $n\ge12$ with its odd-dimensional cost named**, or restrict it to $n=12$ where it is complete as written.
3. **Say that $\theta\le M(s)$ is a tautology at $s=n$**, so the route's deliverable is the $s\le11$ half and nothing else, and that the $\Theta_5$ method is on record as not lifting to $s\ge6$.
4. **Fix the sign step** in [support-dichotomy.md](../findings/support-dichotomy.md)'s display ($\lvert a_i\rvert^3$ twice), **name total symmetry of $T$** as the ingredient additivity uses, and **reverse the reconciliation's implication**: criticality converts $\circ$-orthogonality into Frobenius orthogonality, not the other way round. Add that at $k=2$ critical *and orthogonal* already suffices.
5. **Add the r269–r273 index rows**, retitle the $\Theta_5$ section, and resolve the *rank $=13$ / rank open in $[1,13]$* contradiction inside it.

*Scripts: [r281_support.py](../scripts/reviewers/r281/r281_support.py), [r281_ascent.py](../scripts/reviewers/r281/r281_ascent.py), [r281_ascent_hi.py](../scripts/reviewers/r281/r281_ascent_hi.py), [r281_claim4.py](../scripts/reviewers/r281/r281_claim4.py), [r281_claim5.py](../scripts/reviewers/r281/r281_claim5.py), [r281_padinv.py](../scripts/reviewers/r281/r281_padinv.py). Outputs alongside them.*
