# Reviewer 105, the min-entry lemma, its alleged non-extremiser, and the two single-audited claims

Cold brief, own implementation from the definitions, adversarial. Scripts in [scripts/reviewers/r105/](../scripts/reviewers/r105/); log at [agent_logs/reviewer105.log](../agent_logs/reviewer105.log). Independent of Reviewer 103's build; nothing was copied from the record, and the record was read only to identify *which* function Claims 3 and 4 are about.

## Verdicts

| Claim | Verdict |
|---|---|
| 1, the min-entry lemma and its two-step proof | **CONFIRMED**, both steps and the join. And **upgraded: the bound is sharp at every even $n$**, which the record twice states it is not |
| 2, the sphere product is not the extremiser | **Conclusion CONFIRMED, every number in it REFUTED.** The comparison baseline is $\max K$, not $\lvert\min K\rvert$; at $n=10$ the exhibited witness is *worse* than the sphere product; and "no sharp constant is thereby established" is false, the sharp constant is Claim 1's own bound |
| 3, any monotone bound exact at $t=2$ is vacuous | **Theorem CONFIRMED (it is a two-line tautology); its stated mechanism REFUTED.** Monotonicity is not automatic, and the conclusion has a correct one-tensor proof that needs no monotonicity at all |
| 4, linear, not square-root, degradation | **REPRODUCED exactly, and upgraded to a theorem with a closed-form slope.** The falsifier does not fire at $n=14,16$. But the statement is *weaker* than the conjecture everywhere off $t=2$, and its $t=2$ anchor at $n=12,14$ rests on a point the record itself calls open in two different places |

**Claims 3 and 4 reproduce.** Both were single-audited; my build reproduces Claim 4's numbers to the digit and Claim 3's conclusion by a different and shorter route. Details under each claim.

## The implementation

Built from the brief's definitions ([r105_core.py](../scripts/reviewers/r105/r105_core.py)): random algebraic Weyl tensors by Bianchi projection then Kulkarni–Nomizu trace removal; $M$ on $\Lambda^2$ over $i<j$; $\mathring W$ on $S^2_0$ in the $\{\varphi_{ab},\psi_k\}$ basis; $K_{ab}=W_{abab}$; and $\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle$ computed **from the brief's $\#$ convention directly**, $(M^\#)_{ijkl}=\sum_{p,q}(W_{ipkq}W_{jplq}-W_{iplq}W_{jpkq})$, never from the bi-spectral identity.

Controls that passed before any claim was touched:

| control | result |
|---|---|
| $\theta(S^{n/2}\times S^{n/2})$ vs $\theta_0(n)$, $n=6,8,10,12$ | agree to $10^{-15}$: $1.05409255$, $1.14564392$, $1.20000000$, $1.23603308$ |
| $\theta(W_{\mathbb{CP}^2})$, padded to $n=4,6,12$ | $1.224745=\sqrt{3/2}$ at every $n$ |
| $\theta(\mathbb{CP}^4)$ at $n=8$; $\theta(\mathbb{CP}^3)$ at $n=6$ | $0.986013$; $1.054093$, the record's figures |
| $\kappa^2(\mathbb{CP}^m)=3/(m+1)$ | $t=1.0$, $0.75$, $0.6$ at $m=2,3,4$ |
| $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$ | to $10^{-16}$ on random Weyl tensors |
| $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ | agrees with the $\#$-formula to $10^{-16}$, $n=6,8$, an independent re-confirmation of Lemma L40 |

## Claim 1, CONFIRMED, and the bound is attained

### The middle step is right, and here is the proof it should carry

The brief asks whether "$M-1$ equal negatives against one positive" really minimises $\lvert\min y\rvert$ and whether the value is right. Both hold, and the clean argument is the reverse one, fix $m=\lvert\min y\rvert$ and maximise $s$:

Let $y_1,\dots,y_M$ have $\sum y=0$, $\sum y^2=s>0$, and $\min y=-m$. Since $\sum y=0$ and $y\ne0$, at least one entry is positive, so at most $M-1$ entries are negative; call that count $k\le M-1$. The negatives contribute at most $km^2$. The positives sum to $P=\sum_{y_i<0}\lvert y_i\rvert\le km$, and for non-negative reals $\sum p_i^2\le(\sum p_i)^2$, so they contribute at most $k^2m^2$. Hence $s\le(k^2+k)m^2\le M(M-1)m^2$, i.e. $m\ge\sqrt{s/(M(M-1))}$, with equality iff $k=M-1$, all negatives equal $-m$, and the single positive is $(M-1)m$. So the configuration named is the extremal one and the constant is right.

### The join is right too

$\sum_a s_a=\lVert K\rVert_F^2=t$ over $n$ rows gives some $s_a\ge t/n$; that row has $M=n-1$ off-diagonal entries summing to zero (the diagonal is zero and $K\mathbf 1=0$); and the global minimum is $\le$ that row's minimum, both being negative, so $\lvert\min_{a\ne b}K_{ab}\rvert\ge\lvert\min_b K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$. The two steps combine as stated. No hypothesis is unused and none is missing.

### The correction: the bound is sharp, and the record says twice that it is not

[plan.md](../plan.md) item (c) records "the derived $\sqrt{t/(n(n-1)(n-2))}$ is not attained" and calls the sharp constant open. It is attained, for every even $n$, by the **perfect-matching vertex matrix**:

$$K_{ab}=n-2 \text{ on a perfect matching},\qquad K_{ab}=-1 \text{ otherwise}.$$

Row sums: $(n-2)+(n-2)(-1)=0$. Norm: $n(n-2)^2+n(n-2)=n(n-1)(n-2)$. Both steps of Claim 1's proof are tight simultaneously, every row carries mass exactly $t/n$, and every row is $n-2$ equal negatives against one positive of $(n-2)$ times their size. Rescaled to $t$, its minimum entry is exactly $\sqrt{t/(n(n-1)(n-2))}$.

It is a genuine object, not a matrix that happens to satisfy the constraints ([r105_claim12.py](../scripts/reviewers/r105/r105_claim12.py) and the realisability run): the coordinate-diagonal $W$ with $W_{abab}=K_{ab}$ has Riemann-symmetry, Bianchi and trace-free residuals $\le8\times10^{-17}$, $\lVert M\rVert_F=1$, $t=2.000000000000$, and $\theta=0.645497$, $0.540062$, $0.474342$, $0.428174$ at $n=6,8,10,12$, comfortably under $\theta_0(n)$, as the diagonal case requires.

### The whole problem collapses to one integer

$\lvert\min K\rvert$ is homogeneous of degree 1 and $t$ of degree 2, so

$$\min\bigl\{\lvert\min K\rvert:\ K \text{ hollow symmetric},\ K\mathbf1=0,\ \lVert K\rVert_F^2=t\bigr\}=\sqrt{t/N^\ast(n)},\qquad N^\ast(n)=\max\bigl\{\lVert K\rVert_F^2:\ K_{ab}\ge-1\bigr\},$$

a maximum of a convex function over a compact polytope, hence attained at a vertex. Claim 1's proof *is* the statement $N^\ast\le n(n-1)(n-2)$; the matching is the vertex meeting it. A Frank–Wolfe vertex ascent (60 random starts per $n$, LP steps via HiGHS) returns exactly $120$, $336$, $720$, $1320$ at $n=6,8,10,12$, the bound, to the digit.

**Odd $n$ is a separate constant and the lemma is not sharp there.** The search returns $N^\ast=156$, $408$, $840$ at $n=7,9,11$ against $n(n-1)(n-2)=210,504,990$, at a near-matching plus one triangle: value $n-2$ on a perfect matching of $n-3$ vertices, $(n-3)/2$ on a triangle over the remaining three, $-1$ elsewhere. That fits $N^\ast(n)=n(n-1)(n-2)-\tfrac32(n-1)^2$ at all three. The construction gives that value rigorously (so the true minimum is $\le\sqrt{t/N}$); the matching upper bound at odd $n$ is numerical only.

## Claim 2, the conclusion survives, the numbers do not

### The comparison baseline is the wrong entry of $K$

The sphere product's $\lvert\min K\rvert$ at $t=2$, computed from its Weyl tensor:

| $n$ | Claim 2's "sphere product" | $\max_{a\ne b}K_{ab}$ | $\lvert\min_{a\ne b}K_{ab}\rvert$ |
|---|---|---|---|
| $6$ | $0.3162$ | $\mathbf{0.316228}$ | $0.210819$ |
| $8$ | $0.2182$ | $\mathbf{0.218218}$ | $0.163663$ |
| $10$ | $0.1667$ | $\mathbf{0.166667}$ | $0.133333$ |

The quoted numbers are the **largest** entry of $K$ (the within-block value $\alpha=1/\sqrt{(p-1)(2p-1)}$, $p=n/2$), matched to six digits at all three dimensions. The minimum is the cross-block value $\beta=-\tfrac{p-1}{p}\alpha$. This is not a rounding difference: it changes the verdict at $n=10$, where the exhibited witness $0.1444$ is **above** the sphere product's true $0.1333$. On its own numbers, corrected, Claim 2's search fails to beat the sphere product at one of its three dimensions.

### The witnesses are nowhere near extremal

| $n$ | Claim 2's witness | sphere product | two-block $(2,n-2)$ | **true minimum** (perfect matching) |
|---|---|---|---|---|
| $6$ | $0.1732$ | $0.210819$ | $0.193649$ | $\mathbf{0.129099}$ |
| $8$ | $0.1499$ | $0.163663$ | $0.140859$ | $\mathbf{0.077152}$ |
| $10$ | $0.1444$ | $0.133333$ | $0.110240$ | $\mathbf{0.052705}$ |

The witnesses are $1.34\times$, $1.94\times$, $2.74\times$ the true minimum, and the gap widens with $n$, the signature of a search that found no structure. A diagnostic confirming that: at a genuine optimum $\lvert\min K\rvert=\sqrt{2/N}$ with $N$ the norm at a polytope vertex, an integer here. Claim 2's values give $N=66.67$, $89.02$, $95.91$, none of them a vertex value, and barely growing with $n$ while $N^\ast$ grows as $n^3$. These are stalled-optimiser outputs.

### The load-bearing sentence is false

> "no sharp constant is thereby established, the search giving upper bounds only"

The sharp constant is established, and it is Claim 1's own bound: for even $n$ the minimum of $\lvert\min K\rvert$ at fixed $t$ is **exactly** $\sqrt{t/(n(n-1)(n-2))}$, with the extremisers classified as the perfect matchings. No search is involved and no upper-bound/lower-bound gap remains. What the refutation of the sphere product needed was a two-line construction, not a numerical hunt, and the hunt, having missed even the two-block family $(2,n-2)$, was not going to find it.

**Net effect on the record:** Claim 2's conclusion ("the balanced sphere product does not minimise $\lvert\min K\rvert$") stands and is now proved rather than sampled. Item (c) of [plan.md](../plan.md) ("the sharp constant in the min-entry lemma … Open"), should close.

## Claim 3, the theorem is a tautology, the mechanism is unsound, and the right proof is one tensor

### The theorem carries no content of its own

"Non-increasing in $t$" plus "$R(2)=\theta_0(n)$" gives $R(t)\ge R(2)=\theta_0(n)$ for $t<2$ by the definition of non-increasing. Nothing else in the hypothesis list is used, not the diagonal-information clause, not linearity, not Schur–Horn. The brief's request to "construct a bound satisfying the hypotheses that is NOT vacuous" is therefore impossible by fiat, and that impossibility is a fact about the word "non-increasing", not about the vertex matrix. **All the content sits in the assertion that monotonicity is automatic.**

### Monotonicity is not automatic, and the reason given for it is unsound

The reason offered is: "the diagonal class is a linear space, so scaling $K$ down weakens every constraint that reads it." The step that fails is the identification of *scaling the auxiliary variable* with *moving through the class of $W$*.

Under the normalisation $\lVert M\rVert_F=1$ the two are coupled: $\tfrac t2+\lVert M-\operatorname{diag}M\rVert_F^2=1$, so lowering $t$ does not relax anything, it **forces** off-diagonal mass $1-t/2$ into $M$, and the off-diagonal part is precisely what carries the unknown part of $\theta$. The classes $\{W:t(W)=\tau\}$ are disjoint slices of the unit sphere, not a nested family, and $\tau\mapsto\{W:t(W)=\tau\}$ has no inclusion in either direction. Monotonicity of a *relaxation over auxiliary spectra at fixed $K$* is a fact about the majorization feasible set (Reviewer 103 proves that correctly); it does not transfer to an arbitrary "bound that reads diagonal information", which is what Claim 3 quantifies over.

The clause "depends on $W$ only through diagonal information of size $t$" is also not well defined enough to carry a genericity claim. It has to distinguish three different things, a function of the scalar $t$; a function of the single-frame matrix $K(F)$; a function of $K(F)$ for all $F$, and Claim 3's own escape hatch ("the multi-frame family escapes") shows the boundary is doing real work while remaining unstated.

**A non-vacuous bound of the fenced shape is already in the record.** [plan.md](../plan.md) item 2, the live target $\sup\{\theta:S=0,\text{ non-diagonal}\}\le\sqrt{3/2}$, reads $W$ only through whether $t=2$, equals $\theta_0(n)$ at $t=2$, and is strictly below $\theta_0(n)$ for $n\ge12$ off the diagonal locus. It is not monotone, which is exactly why it is not fenced. If Claim 3's mechanism were as generic as stated, it would close the record's own top-ranked target.

### The conclusion is right, and it has a shorter proof that needs no hypothesis

$\theta$ is a frame invariant; $t=\lVert K(F)\rVert_F^2$ is not. The sphere product's own frame orbit already sweeps the interval ([r105_frames.py](../scripts/reviewers/r105/r105_frames.py)):

| $n$ | $\theta$ over the orbit | $t$ over 60 random frames | frame minimum of $t$ |
|---|---|---|---|
| $6$ | $1.05409255$, invariant to $2\times10^{-16}$ | $[0.0292,\ 0.4704]$ | $0.0000$ |
| $8$ | $1.14564392$, invariant to $3\times10^{-15}$ | $[0.0464,\ 0.3847]$ | $0.0054$ |
| $12$ | $1.23603308$, invariant to $2\times10^{-15}$ | $[0.0233,\ 0.1541]$ | $0.0029$ |

$SO(n)$ is connected and $t$ is continuous on it, so $t$ attains **every** value in $[t_{\min},2]$ on the orbit of the single tensor $W_{S^{n/2}\times S^{n/2}}$, with $\theta=\theta_0(n)$ throughout. Hence any $R$ with $\theta(W)\le R(\lVert K(F)\rVert_F^2)$ for all $W$ and all frames satisfies $R(t)\ge\theta_0(n)$ on that whole interval. One tensor, no monotonicity, no linear space, no Schur–Horn, no diagonal case.

This is strictly better than Claim 3 in three ways: it drops the hypothesis that does all the work and cannot be checked; it says *why* the multi-frame family escapes (on the orbit $\kappa^2\equiv2$, so the orbit contributes the single point $t=2$ and the argument evaporates); and it makes the fenced class precise, **single-frame** bounds, which is a checkable property, rather than "monotone in diagonal information", which is not.

**Verdict:** the conclusion of [fence post F24](../findings/fence-posts.md) stands; its stated proof should be replaced by the frame-orbit argument, and the sentence "the mechanism is generic, with nothing specific to Schur–Horn or majorization" should be narrowed to single-frame bounds.

## Claim 4, reproduced exactly, upgraded to a theorem, and weaker than it sounds

### It reproduces, independently

I rebuilt the relaxation from the definitions ([r105_relax.py](../scripts/reviewers/r105/r105_relax.py)), inner problems solved in sorted coordinates so the majorization constraints are linear, SLSQP with multiple starts, feasibility re-checked on every returned point:

$$F(K)=\tfrac32\max\{p_3(\mu):\textstyle\sum\mu=0,\ \sum\mu^2=1,\ \mu\succ d_\varphi\}-\tfrac12\min\{p_3(\omega):\sum\omega=0,\ \sum\omega^2=3,\ \omega\succ d\}.$$

| $t$ | $0.25$ | $0.5$ | $1.0$ | $1.5$ | $1.9$ | $2.0$ |
|---|---|---|---|---|---|---|
| $n=6$, mine | $3.727827$ | $3.524505$ | $2.809705$ | $1.938507$ | $1.223004$ | $1.054093$ |
| $n=6$, R103 | $3.7278$ | $3.5245$ | $2.8097$ | $1.9385$ | $1.2230$ | $1.054093$ |
| $n=12$, mine | $3.831947$ | $3.479642$ | $2.690668$ | $1.910888$ | $1.353512$ | $1.236033$ |
| $n=12$, R103 | $3.8319$ | $3.4796$ | $2.6907$ | $1.9109$ | $1.3535$ | $1.2360$ |

And the slope itself, at the same three points: $F-\theta_0=0.004204$, $0.044519$, $0.240532$ at $2-t=0.0040$, $0.0398$, $0.1950$, secant slopes $1.0514$, $1.1186$, $1.2335$. Claim 4's "$0.0042$, $0.0445$, $0.2405$, slope $1.05$ to $1.23$" is exact. **Claims 3 and 4 are no longer single-audited on the numbers.**

### The slope is not a sampling artefact, it has a closed form

The linearity is provable, and the proof also produces the constant the plan says is owed.

*The perturbation is $O(\sqrt{2-t})$ in norm but only inside level sets.* Write $K=c\hat K$ with $\lVert\hat K\rVert_F^2=2$, $t=2c^2$, and let $\delta=\omega^\downarrow-(c\hat d)^\downarrow$. Majorization gives $S_j=\sum_{k\le j}\delta_k\ge0$ with $S_m=0$, and Abel summation against the decreasing $\hat d$ gives $\langle \hat d,\delta\rangle=\sum_j(\hat d_j-\hat d_{j+1})S_j\ge0$; the norm identity $\lVert\omega\rVert^2=3$ then forces
$$\lVert\delta\rVert^2\ \le\ 3(1-c^2)=\tfrac32(2-t),\qquad \langle \hat d,\delta\rangle\le\tfrac{3}{4c}(2-t).$$
Expanding $p_3(\omega)-c^3p_3(\hat d)=3c^2\langle \hat d^2,\delta\rangle+3c\langle \hat d,\delta^2\rangle+p_3(\delta)$: the two rightmost terms are $O(\lVert\delta\rVert^2)=O(2-t)$ directly. The first is linear in $\delta$ and would be $O(\sqrt{2-t})$ if $\delta$ were free, it is not. Abel again, with $\hat d_j^2-\hat d_{j+1}^2=(\hat d_j-\hat d_{j+1})(\hat d_j+\hat d_{j+1})$, converts it into $\sum_j(\hat d_j-\hat d_{j+1})(\hat d_j+\hat d_{j+1})S_j$, and every $j$ with a negative coefficient has $\hat d_j>\hat d_{j+1}$, hence $S_j\le\langle \hat d,\delta\rangle/(\hat d_j-\hat d_{j+1})=O(2-t)$. Inside a level set of $\hat d$ the coefficient vanishes identically. So **every term is $O(2-t)$**: linearity, for every $n$ and every $K$, not just along the sphere-product ray.

*The exact slope.* To leading order the budget $\sum_b x_b+2\sum_j g_jS_j=3(1-c^2)$ ($x_b=\lVert\delta\rVert^2$ inside level set $b$, $g_j$ the gaps) is spent on a one-constraint linear programme, so the optimum is the single best direction, and the two sides give
$$\boxed{\ \text{slope}=\tfrac94\bigl(A-B\bigr)-\tfrac34\,\theta_0(n)\ }$$
with $A$ the largest of $\{\hat d_\varphi$ at its **degenerate** levels$\}\cup\{\tfrac12(\hat d_{\varphi,j}+\hat d_{\varphi,j+1})$ at its gaps$\}$ and $B$ the analogous minimum for $\hat d$, the $-\tfrac34\theta_0$ coming from $c^3=(t/2)^{3/2}$. Singleton levels contribute nothing, since a sorted perturbation inside a singleton must vanish.

For the balanced sphere product this is closed-form: $\hat\alpha=1/\sqrt{(p-1)(2p-1)}$, $\hat\beta=-\tfrac{p-1}{p}\hat\alpha$, $p=n/2$, with $A=\hat\alpha$ and $B=\tfrac12(\hat\beta-(2p-2)\hat\alpha)$, the most negative entry of $\hat d$, $-(2p-2)\hat\alpha$, being a **singleton** eigenvalue and so unusable, which is why $B$ sits at a gap and not at $\min\hat d$.

| $n$ | $12$ | $14$ | $16$ | $20$ | $\to\infty$ |
|---|---|---|---|---|---|
| derived limiting slope | $1.019727$ | $0.946260$ | $0.892034$ | $0.817294$ | $3/(4\sqrt2)=0.530330$ |
| measured secant at $2-t=4\times10^{-5}$ | $1.0229$ | (|), |, | |
| measured secants at $2-t=0.0040/0.0398/0.1950$ | $1.0514/1.1186/1.2335$ | $0.9785/1.0471/1.1659$ | $0.9246/0.9942/1.1156$ | $0.8502/0.9210/1.0456$ | |

**The falsifier does not fire.** Linearity survives at $n=14$ and $n=16$, and the slope *decreases* in $n$. The quoted "$1.05$–$1.23$" is a spread of secants over a $50\times$ range of $2-t$, not an uncertainty in a slope; the derivative is $1.0197$ and the secants converge to it from above ($1.0229$ at $2-t=4\times10^{-5}$). The secant error scales as $\sqrt{2-t}$, the ratios $0.0032:0.0101:0.0317$ across the three decades are $10^{-1/2}$ apart, so Richardson extrapolation of the measured secants is a clean test of the closed form, and it returns $1.019709$ at $n=12$ against the derived $1.019727$, and $0.892412$ at $n=16$ against $0.892034$. The formula is verified independently of the derivation. Along this ray the global constant is also measured: $\sup_t(F-\theta_0)/(2-t)=1.4958$ at $t\approx0.46$, so $\theta\le\theta_0(12)+1.50\,(2-t)$ holds on the whole ray, not only near the endpoint.

### What is not established

- **Uniformity over $W$ is not established, by the record's evidence or by mine.** Every number, theirs and mine, is on the one-parameter ray $K=c\,K_{S^{n/2}\times S^{n/2}}$. The statement $\theta\le\theta_0(n)+O(2-\kappa^2(W))$ quantifies over all $W$, so the constant needed is $\sup_{\hat K}\bigl[\tfrac94(A(\hat K)-B(\hat K))-\tfrac34\theta(\hat W)\bigr]$. My derivation bounds it crudely by $\tfrac94(1+\sqrt3)+\tfrac34\lvert\theta\rvert_{\max}\approx9.2$ using $\lVert\hat d_\varphi\rVert=1$, $\lVert\hat d\rVert=\sqrt3$, finite, so the $O(\cdot)$ *is* uniform in $n$, but the constant is nine times the advertised one and nobody has computed the true supremum. Reporting "slope $1.05$–$1.23$" as the constant of a statement about all $W$ is an extrapolation from one ray.
- **The $\kappa$ version needs a frame argument the claim does not make.** $F$ bounds $\theta$ in every frame, so $\theta\le\min_F F(K(F))$ and one may evaluate at the frame attaining $\kappa^2$, but the slope constant is then frame-dependent too, and the ray evidence is all in the sphere product's own diagonalising frame.
- **The $t=2$ anchor at $n=12,14$ is not free-standing, and the record contradicts itself about it.** The derivation ends in $c^3\theta(\hat W_{\text{diag}})\le c^3\theta_0(n)$, which is the diagonal case. [problem.md](../findings/problem.md) states "$n=12$ and $n=14$ are open **even in the diagonal case**"; [LEDGER.md](../findings/LEDGER.md) says they are "closed in [ATTEMPTS.md](../ATTEMPTS.md) rather than in the literature"; [findings/INDEX.md](../findings/INDEX.md) tabulates them as "closed here". These cannot all be the operative status. At $n\ge16$ even the statement is unconditional on Jäger; at $n=12,14$ (the dimensions every number in Claim 4 is computed at), it is conditional on a project-internal result that one of the three files calls open. **This needs resolving before the stability statement is quoted anywhere.**

### Is it stronger than what is known?

Partly, and less usefully than "the round's one positive output" suggests.

- **Against the naive estimate: yes, genuinely.** Splitting $M$ into diagonal and off-diagonal parts gives $\lVert M_{\text{off}}\rVert=\sqrt{(2-t)/2}$, and $\theta$ is a cubic form, so the first-order term gives only $\theta\le\theta_0+O(\sqrt{2-t})$. Linear is a real improvement, and the reason is structural, majorization confines the perturbation to level sets, where the cubic's gradient is constant.
- **Against the conjecture: it is weaker, everywhere off $t=2$.** The bound *exceeds* $\theta_0(n)$ at every $t<2$, by [fence post F24](../findings/fence-posts.md)'s own conclusion. It therefore excludes no $W$ in any neighbourhood of the diagonal locus and cannot close a tube. Calling it "strictly stronger than the point result at $t=2$" is true in the trivial sense that it says something where the point result says nothing; it is not progress toward $\theta\le\theta_0$.
- **What it actually measures is the tool, not the landscape.** Since $F\ge\theta_0$ for all $t<2$ and (conjecturally) $\sup\theta\le\theta_0$, the linear modulus is the rate at which the relaxation's *slack* opens, not the rate at which $\theta$ degrades. The honest headline is: the both-sided relaxation loses its sharpness linearly, with slope $\tfrac94(A-B)-\tfrac34\theta_0$, decreasing in $n$ to $3/(4\sqrt2)$.

## Sample adequacy and spanning

Spanning is load-bearing for none of the four claims and I did not rely on it. Claims 1 and 2 are statements about the polytope of vertex matrices, settled analytically and confirmed by an LP-based vertex ascent rather than by sampling; the one place sampling appears in my work is the frame orbit under Claim 3, where 60 random frames plus a direct search only need to exhibit *some* $t$ below 2, and connectedness of $SO(n)$ supplies the rest. Claim 4's evidence base (theirs and mine), is a single ray and is not a sample of anything; that is its principal weakness and it is not fixed by more points on the same ray.

## Corrections owed to the record

1. [plan.md](../plan.md) item (c) and any text saying the min-entry bound "is not attained": **it is attained at every even $n$**, by the perfect matching, and the sharp constant is $\sqrt{t/(n(n-1)(n-2))}$. Odd $n$ has a different constant, $n(n-1)(n-2)-\tfrac32(n-1)^2$ on three checked cases.
2. Claim 2's comparison values $0.3162$, $0.2182$, $0.1667$ are $\max K$, not $\lvert\min K\rvert$; the true sphere-product values are $0.210819$, $0.163663$, $0.133333$, and the $n=10$ witness does not beat it.
3. [fence post F24](../findings/fence-posts.md): keep the conclusion, replace the proof with the frame-orbit argument, and narrow "generic" to single-frame bounds.
4. The status of the diagonal case at $n=12,14$ is stated three different ways in three files.


---

## Synthesis carried in REVIEW.md

### Reviewers 105 and 106: the min-entry lemma, the extremiser, and the single-audited pair

Full reports: [reviews/REVIEW_r105.md](reviews/REVIEW_r105.md), [reviews/REVIEW_r106.md](reviews/REVIEW_r106.md). Identical briefs; **both independently reproduced the two claims that 104's death had left single-audited**, 105 to five digits on the relaxation sweeps and exactly on the three slope points, 106 to three digits on the same three. 106's calibration was forced rather than fitted: the $\#$ scale comes out $0.50000000$ separately at $n=6,8,10,12$, and its build reproduces $\sqrt{3/2}$, $0.986013$, $0.948683$, $\sqrt{56/45}$, $\sqrt{264/175}$ and $\kappa^2(\mathbb{CP}^m)=3/(m+1)$.

| Claim | Verdict |
|---|---|
| The min-entry lemma and its proof | **CONFIRMED at every step, and SHARP**, the record twice said it was not attained |
| The sphere product refuted as extremiser | **Conclusion stands; every number refuted**, and "no sharp constant established" is itself refuted |
| Monotone + exact $\Rightarrow R\ge\theta_0$ | **Implication CONFIRMED; every consequence fails**, fence post F24 withdrawn |
| The linear stability statement | **Numbers reproduced exactly; they measure $R$, not $\theta$.** True coefficient $0$ in $t$, **negative** in $\kappa^2$ |

**The lemma is attained, and equality forces a perfect matching.** $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere makes both proof steps tight simultaneously, is a genuine coordinate-diagonal Weyl tensor (residual $\le8\times10^{-17}$, $t=2.000000000000$), and gives $\lVert K\rVert_F^2=n(n-1)(n-2)c^2$. Odd $n$ is not attained, ratios $\sqrt{5/3}$, $1.16024$, $1.11153$ at $n=5,7,9$.

**The extremiser comparison used the wrong functional.** The sphere-product values $0.3162$, $0.2182$, $0.1667$ are $\min_{a\ne b}\lvert K_{ab}\rvert$; the true $\lvert\min_{a\ne b}K_{ab}\rvert$ are $0.2108$, $0.1637$, $0.1333$, smaller by exactly $n/(n-2)$. The exhibited witnesses are $34$–$174\%$ above the true minimum (which is the lemma bound itself) and their implied vertex norms were not vertex values.

**Fence post F24 fails four ways**, and 106 supplied the sharpest: $R\equiv\theta_0$ satisfies both hypotheses and *is* Conjecture A, so "$\ge\theta_0$" marks non-improvement rather than vacuity; the extremal member $R^\star(t)=\sup\{\theta:\kappa^2=t\}$ is **non-monotone at $t=2$** and so fails the fence's own hypothesis; the "automatic monotonicity" mechanism is unsound because lowering $t$ under $\lVert M\rVert_F=1$ forces off-diagonal mass *in*; and the fence would have excluded the same cycle's own recommended result. What survives is 105's replacement: the sphere product's $O(n)$-frame orbit sweeps $t\in[0.003,2]$ at $n=12$ with $\theta$ invariant, so any single-frame bound is $\ge\theta_0$ across that interval, one orbit, no monotonicity, and it explains why multi-frame escapes.

**The stability statement measured the wrong object.** $Q(D)$ is exactly diagonal for diagonal $D$, so the first-order term vanishes identically; at second order the top eigenvalue on $\mathcal W_n^{\text{off}}$ is exactly $\theta_0/2$ and its eigenspace **is** the $O(n)$-orbit (principal angles $1.000000$). Deflating gives $\lambda'=\theta_0\frac{n-4}{2(n-2)}$ and $C'=-\frac{3\theta_0}{2(n-2)}$, verified to $\le1.7\times10^{-15}$ at $n=8,\dots,16$, and directly at $n=8$, $\theta$ *falls* to $1.14451$ while $R$ *rises* with slope $+1.30$. That $\lambda'$ is the record's own audited $L_e$ family, so what remains is a corollary of the granted diagonal case plus one orthogonality, conditional at $n=12,14$ on this project's diagonal result rather than Jäger's.

**A record bug both rounds depend on:** the $n=12,14$ diagonal case is described three incompatible ways across [problem.md](findings/problem.md), [LEDGER.md](findings/LEDGER.md) and [findings/INDEX.md](../findings/INDEX.md).
