# Review r131, Gate 2, cold: the norm budget, Schur–Horn, and the PSD margin

Commits under review: `eb309ed`, `fd7f5bb`, `194798c`, plus the correction `b53566a` that landed mid-review. Files: [findings/bispectral.md](../findings/bispectral.md), [findings/diagonal-half.md](../findings/diagonal-half.md), [findings/target.md](../findings/target.md).

Everything below was derived before any script in [scripts/](../scripts/) was opened. Numerics appear twice only: once as a failed attempt to refute a bound I had already derived, and once as a check that the second-kind norm is what the record says it is.

## Verdicts

| claim | verdict |
|---|---|
| **A** $\sum d^2=\tfrac32\lVert K\rVert_F^2$ as pure algebra | **CONFIRMED**, and stronger than stated, $d$ is a genuine $\mathring W$-diagonal, so Schur–Horn legitimately applies |
| **B** $-d_{\min}\ge\mu_1(K)$, $\omega\succ d\Rightarrow\omega_{\min}\le d_{\min}$, hence $\mu\ge\mu_1(K)$ | **CONFIRMED**, scope OVERSTATED, majorization is not needed, it is a one-line Rayleigh quotient, and it needs $K\ne0$ |
| **C** $K\mathbf1=0$ caps $\mu_1(K)\le\sqrt{t(n-2)/(n-1)}\le\sqrt{2(n-2)/(n-1)}$ | **CONFIRMED** |
| **D** $\sqrt{2(n-2)/(n-1)}=n\theta_0(n)/(n-1)$ identically | **CONFIRMED**, but it is not a coincidence and it is not new, [diagonal-half.md](../findings/diagonal-half.md) already carried it, and the odd-$n$ analogue holds too |
| **E** Schur–Horn and the vertex-matrix budget are ONE obstruction; the route is retired | **FALSE**, the same two ingredients, B and C, applied in the eigenframe of the bottom second-kind eigenvector, *prove* $\mu\le n\theta_0(n)/(n-1)$, which is exactly the estimate [target.md](../findings/target.md) needs and does not prove |
| **F** connected weight graph, $\dim\ker=1$, strict PSD with margin $\varepsilon_1$ | **OVERSTATED with one FALSE premise**, the cross-block entries are the *smallest*, not the largest; the margins are right and I give them in closed form; the table's monotonicity in $n$ holds only for $\lvert p-q\rvert\le1$ |
| **G** branch 1 is an equality at every sphere product, unbalanced included | **CONFIRMED**, and upgradable from "tested" to a closed-form theorem |

## The load-bearing defect

`b53566a` added this sentence to [findings/bispectral.md](../findings/bispectral.md):

> $\mu$ itself is **not** capped, $\mu$ is a second-kind eigenvalue and nothing above bounds it from above.

**That is false, and it is the one sentence in the passage that carries the retirement.** $\mu$ is capped, by exactly the number under discussion:

$$\mu\ \le\ \sqrt{\frac{2(n-2)}{n-1}}\ =\ \frac{n\,\theta_0(n)}{n-1}\qquad\text{for every }W\in\mathrm{Weyl}_n\text{ with }\lVert W\rVert_{\Lambda^2}=1,$$

with no criticality hypothesis. The proof is claims B and C, in the right frame, in five lines.

### The proof

1. Let $h$ be a unit bottom eigenvector, $\mathring Wh=-\mu h$, so $\langle h,\mathring Wh\rangle=-\mu$. It lies in $S^2_0$, so $\mathop{\mathrm{tr}}h=0$ and $\lVert h\rVert_F=1$.
2. Diagonalize it: pick the orthonormal frame $F$ of eigenvectors of $h$, so $h=\mathop{\mathrm{diag}}(v)$ with $\sum_iv_i=0$ and $\lvert v\rvert=1$.
3. In the record's own convention $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$, a diagonal $h$ gives $(\mathring Wh)_{ii}=-\left(K^Fv\right)_i$, so $\langle h,\mathring Wh\rangle=-v^{\mathsf T}K^Fv$. Hence $\mu=v^{\mathsf T}K^Fv$ **exactly**, this is the equality case of claim B, and B in an arbitrary frame gives $\mu\ge\mu_1(K^F)$, so in this frame $\mu=\mu_1(K^F)$.
4. $K^F$ is symmetric, hollow and $K^F\mathbf1=0$ in **every** frame (Weyl is totally trace-free), and $t_F=\lVert K^F\rVert_F^2\le2$ in **every** frame, because $t_F$ is twice the sum of squares of the $\Lambda^2$-diagonal of $W$ and $\lVert W\rVert_{\Lambda^2}=1$. This is the record's own "$t\le2$ at $\lvert W\rvert=1$", which is a per-frame statement.
5. Claim C in frame $F$: $\mu=v^{\mathsf T}K^Fv\le\mu_1(K^F)\le\sqrt{t_F(n-2)/(n-1)}\le\sqrt{2(n-2)/(n-1)}$. $\square$

The same argument gives more than the bottom eigenvalue: every $\omega$ obeys $\lvert\omega\rvert\le\sqrt{2(n-2)/(n-1)}$, so the whole second-kind spectrum sits inside that interval.

### Why this refutes E rather than refining it

The passage's closing sentence poses the open question itself: *"whether any admissible $d$ can do better"*, a different frame, a different pairing. **The answer is yes, and it is the best possible answer.** Taking $d$ in the eigenframe of $h$ turns the inequality $\mu\ge\mu_1(K)$ into the identity

$$\mu=\max_{F\ \text{orthonormal frame}}\mu_1\!\left(K^F\right),$$

because $\{\mathop{\mathrm{diag}}_F(v):F,\ v\perp\mathbf1,\ \lvert v\rvert=1\}$ is *all* of the unit sphere of $S^2_0$, every traceless symmetric $h$ is diagonal in its own eigenframe. So the lower bound is not merely improvable; in the right frame it is exact. And the cap of claim C, which applies frame by frame, then caps $\mu$ itself.

So the object the passage calls the obstruction ("the loss is in the budget behind it rather than in the majorization"), is not a loss. It is the deliverable. What was missing was never a sharper majorization; it was the single move of evaluating in the eigenframe of $h$ instead of in the coordinate frame.

### And the record already knew the conclusion

an outside progress report (unpublished, held in the private record) proves $\mu^2\le2(n-2)/(n-1)$ at line 601, states it as the Second-kind projection estimate $\tfrac{n-1}n\mu\le\Theta_n\lvert W\rvert$ at line 655, and reaches it through the same "diagonalize $h$" step. outside material (unpublished, held in the private record) records this project's own audit of it: *"Holds everywhere; worst ratio $0.72$"*, exactly tight at every balanced product. [target.md](../findings/target.md) then leans on it: with $\mathrm{CD}_n$, *"it closes the conjecture"*.

**So `b53566a` inserted, into [findings/bispectral.md](../findings/bispectral.md), the negation of a proposition the project has audited and depends on.** A reader taking the new sentence at face value would discard the estimate that closes branch 1. That is the most expensive kind of error the record can carry, and it is worse than the loose version it replaced.

**What to write instead.** Keep the fixed-frame observation, it is true and worth having: *evaluated in the coordinate frame, the chain certifies branch 1 only where $\mu_1(K)$ is essentially maximal, i.e. $t=2$.* Then state the fix rather than a retirement: *the frame is the free parameter, and in the eigenframe of $h$ the same two ingredients give $\mu\le n\theta_0(n)/(n-1)$ outright, a three-line reproof of the second-kind projection estimate, independent of the source's $Z(h)$ and fourth-moment route.* The one thing genuinely retired is the Schur–Horn apparatus, and for the opposite reason to the one recorded: majorization was never load-bearing, the Rayleigh quotient does all the work.

*Caveat, and it is the only place the source's route is stronger.* My step 5 gives $\sqrt{2(n-2)/(n-1)}$ at every $n$, which is sharp at even $n$ and loose at odd $n$; the source's fourth-moment lemma gives the sharper odd-$n$ constant $2n^2(n-3)/((n-1)(n+1)(n-2))$. At $n=7$ that is $1.2780$ against my $1.2910$, and $1.2780$ is attained. So the short proof closes branch 1 to $\theta_0(n)$ at every $n$, and to $\Theta_n$ at even $n$ only.

## Claim-by-claim

### A, CONFIRMED, and stronger than recorded

$\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=t/2$. $K$ preserves $\mathbf1^\perp$ (symmetric, $K\mathbf1=0$), so the restriction $K|_{\mathbf1^\perp}$ is a well-defined operator whose spectrum is $\mathop{\mathrm{spec}}(K)$ with one $0$ deleted; $\sum d_\psi^2=t-0=t$. Total $\tfrac32t$. No diagonality of $\mathring W$ used, exactly as claimed.

**The repeated-zero worry in the brief is void.** Multiplicity of $0$ never enters: the quantity is $\lVert K|_{\mathbf1^\perp}\rVert_F^2$, which is basis-free, so no choice of "the eigenvector belonging to $\mathbf1$" is required.

**The record understates its own construction.** $d$ is not merely a list with the right norm, it is the actual diagonal of $\mathring W$ in the orthonormal basis $\{\varphi_{ab}\}_{a<b}\cup\{\mathop{\mathrm{diag}}(v^{(m)})\}$ of $S^2_0$, which has $\binom n2+(n-1)=\tfrac{n(n+1)}2-1=\dim S^2_0$ elements. Direct evaluation: $\langle\varphi_{ab},\mathring W\varphi_{ab}\rangle=K_{ab}$ and $\langle\mathop{\mathrm{diag}}(v),\mathring W\mathop{\mathrm{diag}}(v)\rangle=-v^{\mathsf T}Kv$ in the record's convention. *That* is why $\omega\succ d$ is available at all, and the passage's aside about a reimplementation "reproducing neither the identity nor the conclusion" is a sign convention, not a wrong construction: flipping $\mathring W\mapsto-\mathring W$ swaps which half of $d$ carries the minus.

Two consequences the record has separately and should have joined here: $\lVert\mathring W\rVert_F^2=3$ always (a quadratic $O(n)$-invariant of an irreducible representation, hence a multiple of $\lvert W\rvert^2$; checked at $3.000000$ on random $\mathrm{Weyl}_n$, $n=5,6,7,8$), so $\sum d^2=\tfrac32t\le3=\sum\omega^2$ with equality iff $t=2$, the majorization's necessary norm condition is automatic, and saturated exactly on the diagonal locus.

### B, CONFIRMED, scope OVERSTATED

The two halves both hold. $-d_{\min}=\max\{\max_{a<b}(-K_{ab}),\ \mu_1(K)\}$: the largest eigenvalue of $K$ is attained on $\mathbf1^\perp$ because $\mathop{\mathrm{tr}}\left(K|_{\mathbf1^\perp}\right)=0$ forces a nonnegative eigenvalue there, for every $K\ne0$. **$K=0$ is the one exception and the record does not state it**, there $\max$ of an empty positive part collapses and the identity reads $0=0$ vacuously.

Majorization direction, derived rather than quoted: $\omega\succ d$ with equal totals means $\sum_{k\le j}\omega^\downarrow_k\ge\sum_{k\le j}d^\downarrow_k$ for all $j$. At $j=N-1$, subtracting from the equal totals gives $\omega_{\min}\le d_{\min}$. The majorizing sequence is the more spread one, so its minimum is the smaller. **The record has the direction right.**

**But Schur–Horn is not needed and should not be claimed as the mechanism.** $\mu=-\omega_{\min}=\max_{\lVert h\rVert=1}\left(-\langle h,\mathring Wh\rangle\right)\ge-\langle\mathop{\mathrm{diag}}(v),\mathring W\mathop{\mathrm{diag}}(v)\rangle=v^{\mathsf T}Kv$ for every unit $v\perp\mathbf1$, hence $\mu\ge\mu_1(K)$. One line, no majorization, and it generalizes to every frame, which is the whole content of the defect above. Carrying it as a Schur–Horn consequence is what hid the frame as a free parameter.

### C, CONFIRMED

$K|_{\mathbf1^\perp}$ is symmetric on $n-1$ dimensions with trace $0$ and Frobenius norm$^2$ equal to $t$. Cauchy–Schwarz on the $n-2$ non-maximal eigenvalues: $\mu_1^2=\left(\sum_{i\ge2}\lambda_i\right)^2\le(n-2)\left(t-\mu_1^2\right)$, so $\mu_1\le\sqrt{t(n-2)/(n-1)}$. Equality needs the $n-2$ remaining eigenvalues all equal to $-\mu_1/(n-2)$, which is exactly what the balanced sphere products deliver, e.g. $\mathop{\mathrm{spec}}\left(K|_{\mathbf1^\perp}\right)=\{1.2649,-0.3162^{(4)}\}$ at $S^3\times S^3$ with $-1.2649/4=-0.3162$.

### D, CONFIRMED, and not a coincidence

$n\theta_0(n)/(n-1)=\sqrt{2(n-1)(n-2)}/(n-1)=\sqrt{2(n-2)/(n-1)}$. Trivial.

**It is not new to the record.** [findings/diagonal-half.md](../findings/diagonal-half.md) already carries both $\mu_1\le\sqrt{2(n-2)/(n-1)}$ and $\theta_0(n)=\tfrac{n-1}n\sqrt{2(n-2)/(n-1)}$, with the same two attainment values $1.264911$ and $1.348400$. `fd7f5bb` re-derives it and adds a numerical check at $n=6,8,10,12,20,100$ of an identity that is one line of algebra, the check is the kind the brief's own rule forbids.

**And it is not a coincidence.** It says only that branch 1 is an *equality* at the extremiser: $\Theta_n=\tfrac{n-1}n\mu_{\max}(n)$ by construction of the extremiser. The brief asks whether it survives at odd $n$. It does, provided the odd $\mu$-cap is used: with $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))$,

$$\left(\frac{n}{n-1}\Theta_n\right)^2=\frac{2n^2(n-3)}{(n-1)(n+1)(n-2)},$$

which is *exactly* the odd-$n$ bound on $\mu^2$ in an outside progress report (unpublished, held in the private record). The apparent failure at odd $n$ appears only if the odd $\Theta_n$ is paired with the even-$n$ cap $\sqrt{2(n-2)/(n-1)}$, $1.2780$ against $1.2910$ at $n=7$, which is a mismatch of two formulas, not a broken identity.

### F, one premise FALSE, conclusion CONFIRMED, table scope narrower than stated

**The identity.** $\left(K^2-\lambda K\right)_{aa}=\sum_cK_{ac}^2$ holds with no hypothesis, and $\left(K^2-\lambda K\right)_{ab}=-K_{ab}^2$ for $a\ne b$ is the vertex equation, i.e. criticality on the diagonal locus. So $K^2-\lambda K=L(w)$, $w_{ab}=K_{ab}^2$, at diagonal critical points. Correct, and the kernel-per-component statement for a weighted Laplacian with $w\ge0$ is standard.

**The false premise.** The commit message and the finding both say *"the cross-block entries are the LARGEST in K"*. They are not. Solving the vertex equations in closed form for $S^p\times S^q$ (the row-sum conditions plus the cross-pair equation) gives, with $x=K$ inside block 1, $y=K$ inside block 2, $z=K$ across:

$$z=-\frac{\lambda}{n-1},\qquad x=\frac{q\lambda}{(n-1)(p-1)},\qquad y=\frac{p\lambda}{(n-1)(q-1)},$$

and the two intra-block equations are then satisfied identically. So $x/\lvert z\rvert=q/(p-1)>1$ and $y/\lvert z\rvert=p/(q-1)$, and **$\lvert z\rvert$ is never the largest entry**, at least one intra-block entry always exceeds it. Numerically, against the record's own table row:

| | $S^3{\times}S^3$ | $S^3{\times}S^4$ | $S^4{\times}S^4$ | $S^6{\times}S^6$ |
|---|---|---|---|---|
| cross $\lvert z\rvert$ (the record's numbers) | $0.2108$ | $0.1826$ | $0.1637$ | $0.1124$ |
| largest intra-block $x$ | $\mathbf{0.3162}$ | $\mathbf{0.3652}$ | $\mathbf{0.2182}$ | $\mathbf{0.1348}$ |

The *conclusion* survives untouched, and for a reason that is both simpler and general: $z=-\lambda/(n-1)\ne0$ whenever $\lambda>0$, so the support graph is the **complete** graph, hence connected, hence $\dim\ker L=1$ and the kernel is the constant direction $K\mathbf1=0$ already forces. Fix the sentence, keep the result.

**The margins are right, and they are closed-form.** $\mathop{\mathrm{spec}}(K)=\left\{\tfrac{n\lambda}{n-1},\,0,\,(-x)^{(p-1)},\,(-y)^{(q-1)}\right\}$, so the eigenvalues of $K^2-\lambda K$ are $\kappa(\kappa-\lambda)$ and

$$\varepsilon_1=\min\left\{\frac{n\lambda^2}{(n-1)^2},\ x(x+\lambda),\ y(y+\lambda)\right\}.$$

With $c_x=q/(p-1)$ and $c_y=p/(q-1)$ the last two are $\tfrac{\lambda^2}{(n-1)^2}c(c+n-1)$, which beats $\tfrac{n\lambda^2}{(n-1)^2}$ iff $c\ge1$. Hence:

- For $\lvert p-q\rvert\le1$ (every product in the record's table), $\varepsilon_1=n\lambda^2/(n-1)^2$, the block-cut direction. At balanced products this is $2(n-2)/(n(n-1))$, giving $0.2667$, $0.2143$, $0.1515$ at $n=6,8,12$, and $7\cdot1.2/36=0.2333$ at $S^3\times S^4$. **All four table entries reproduced exactly.**
- For $\lvert p-q\rvert\ge2$ the minimum moves *inside the small block* and $\varepsilon_1$ is strictly smaller. At $S^2\times S^6$, $c_y=2/5$ gives $\varepsilon_1=2.96\lambda^2/49$ against $8\lambda^2/49$, a factor $2.7$ below the table's pattern. **So "a margin that shrinks with $n$" is a statement about near-balanced products only**, and the finding should say so.

**Consistency with the $n=8$ refutation in `194798c`: no contradiction, and the reason is exactly the one the record gives.** The Laplacian identity needs the off-diagonal vertex equation, which is criticality; reviewer 129's witness is on the diagonal *locus* with criticality residual $0.002$, so $K^2-\theta K$ is not $L(w)$ there and nothing forbids $\lambda_{\min}=-0.0034$. Sphere products are critical, so F applies to them. The two statements are about disjoint hypotheses.

**The frame-rotation reconciliation is logically sound but is asserted, not shown.** $\left(K^2-\lambda K\right)\mathbf1=0$ in every frame, since $K^F\mathbf1=0$ is frame-independent, so the question is genuinely positivity on $\mathbf1^\perp$ and a perturbation of operator norm below $\varepsilon_1$ cannot break it. That much is right. But it is bare continuity (true of *any* strictly positive operator) and the finding claims it *is* "why bounded rotations and fully random frames give opposite answers". Nothing in the commit measures $\lVert\Delta(K^2-\lambda K)\rVert$ for either experiment against $\varepsilon_1$. Recommend downgrading "which is why" to "which is consistent with", or measuring the two perturbations.

### G, CONFIRMED, and provable rather than tested

The record says *"equality at every sphere product tested"*. It is an identity, provable in closed form for all $p,q\ge2$, and the derivation is the one above:

1. On the diagonal locus $\mathring W$ is block-diagonal in the $(\varphi,\psi)$ basis, $\mathring W\varphi_{ab}=K_{ab}\varphi_{ab}$ and $\mathring W\mathop{\mathrm{diag}}(v)=-\mathop{\mathrm{diag}}(Kv)$, so $\omega=d$ **exactly**, not merely $\omega\succ d$.
2. Hence $\mu=-d_{\min}=\max\left\{\lambda/(n-1),\ n\lambda/(n-1)\right\}=n\lambda/(n-1)$, using $\max_{a<b}(-K_{ab})=-z=\lambda/(n-1)$ and $\mu_1(K)=n\lambda/(n-1)$ from the spectrum above.
3. So $\lambda=\tfrac{n-1}n\mu$ identically, at every $S^p\times S^q$, balanced or not. Branch 1 is an equality on the whole two-parameter family.

The normalization closes the loop: $\lambda^2=1/G$ with $G=\tfrac{pq}{(n-1)^2}\left[\tfrac q{2(p-1)}+\tfrac p{2(q-1)}+1\right]$, which collapses to $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at $p=q$ and to $2(n-1)(n-3)/((n+1)(n-2))=\Theta_n^2$ at $q=p+1$. Both of [target.md](../findings/target.md)'s extremal constants fall out of one formula.

The concentration reading is correct arithmetic: a branch-1 point above $\sqrt{3/2}$ needs $\mu^2/3$ of $\lVert\mathring W\rVert_F^2$ at the bottom, and $\mu\le\sqrt{2(n-2)/(n-1)}$ makes the ceiling $2(n-2)/(3(n-1))\to2/3$, which is $60.6\%$ at $n=12$. **Note what the cap now says about this paragraph**: the "share a counterexample needs" and the "share the champion has" are the same number *because the champion saturates the cap*, so the $1.1$ percentage-point gap at $n=12$ is a gap between $\sqrt{3/2}$ and $\theta_0(12)$, not slack in $\mu$.

The "no lossy step anywhere" inference is stated correctly, every step must be an equality *at the product family*, which is weaker than "everywhere" and is what the text says.

## Numerics, and what they were for

Two uses only, both permitted.

**A refutation attempt on the derived cap, which failed.** Maximizing $\mu$ over $\mathrm{Weyl}_n$ by projected iteration (random Bianchi-projected trace-free start, then $W\leftarrow\Pi_{\mathcal W}\left(h\otimes h\right)$ normalized, six seeds):

| $n$ | $\max\mu$ found | cap $\sqrt{2(n-2)/(n-1)}$ | ratio |
|---|---|---|---|
| $5$ | $1.178511$ | $1.224745$ | $0.9623$ |
| $6$ | $1.264911$ | $1.264911$ | $\mathbf{1.000000}$ |
| $7$ | $1.278019$ | $1.290994$ | $0.9899$ |
| $8$ | $1.309307$ | $1.309307$ | $\mathbf{1.000000}$ |

Every maximizer is the most balanced sphere product, and every value equals $n\lambda/(n-1)$ from the closed form, $1.178511$ is $S^2\times S^3$, $1.278019$ is $S^3\times S^4$. The cap is attained at even $n$ and loose by the odd-$n$ factor at odd $n$, precisely as the two formulas predict.

**A check on the normalization.** $\lVert\mathring W\rVert_F^2=3.000000$ at every random Weyl tensor tested, $n=5\dots8$, with Bianchi and trace residuals below $10^{-16}$, confirming that $\lvert W\rvert=1$ means $\lVert W\rVert_{\Lambda^2}=1$ and hence that $t_F\le2$ holds frame by frame, which step 4 of the proof needs.

## Literature check

**The gap the record claims is real, but the record states it too widely.** [findings/target.md](../findings/target.md) says the second-kind sources *"relate the two kinds only through $\alpha$-nonnegativity implications … and carries no spectral comparison"*. The first half is right about the specific comparison branch 1 needs, nothing in the literature compares an eigenvalue of Hamilton's cubic to $\mu$. The second half is too strong: the standard second-kind literature *is* full of spectral comparisons to first-kind data, and they are proved by exactly the Rayleigh-quotient move that claim B is:

- $\left\langle\varphi_{ab},\mathring R\varphi_{ab}\right\rangle$ is the sectional curvature $R_{abab}$, which is why positive curvature operator of the second kind implies positive sectional curvature, stated as an equivalence in the dimension-three work of [Fluck and Li](https://arxiv.org/abs/2303.17663).
- The average of the lowest $n-1$ eigenvalues of $\mathring R$ bounds Ricci from below, the Nishikawa-line estimate, in the [Petersen–Wink Betti number paper](https://arxiv.org/abs/2206.14218).
- In dimension three the second-kind spectrum is written explicitly in the first-kind eigenvalues.

**So "$\mu\ge\mu_1(K)$" should not be recorded as an unpublished comparison.** It is the traceless-diagonal instance of the folklore Rayleigh evaluation those results run on; the novelty in the passage is the pairing with the $K\mathbf1=0$ Cauchy–Schwarz cap, not the inequality. Searches run: eigenvalue comparison between the two kinds; second-kind eigenvalue estimates against sectional curvature; Petersen–Wink lowest-eigenvalue Ricci bounds. Nothing found comparing $\lambda$ to $\mu$, that half of the record's line stands.

## Recommended edits, in priority order

1. **Delete the sentence "$\mu$ itself is not capped"** from [findings/bispectral.md](../findings/bispectral.md) and replace it with the five-line proof of $\mu\le n\theta_0(n)/(n-1)$ above, cross-linked to the source proposition in outside material (unpublished, held in the private record). Convert the retirement into a scoped statement about the coordinate frame.
2. **Fix "the cross-block entries are the largest in $K$"** in [findings/diagonal-half.md](../findings/diagonal-half.md), they are $\lambda/(n-1)$ in magnitude and at least one intra-block entry always exceeds them. Substitute the reason that actually works: $z\ne0$, hence complete graph.
3. **Scope the $\varepsilon_1$ table to $\lvert p-q\rvert\le1$** and record $\varepsilon_1=\tfrac{\lambda^2}{(n-1)^2}\min\{n,\ c_x(c_x+n-1),\ c_y(c_y+n-1)\}$, which covers the unbalanced case where the bottleneck moves inside the small block.
4. **Upgrade claim G from tested to proved** with the three-line closed form, and note that the same computation produces both $\theta_0(n)$ and $\Theta_n$.
5. **Drop the numerical verification of claim D** and cross-reference [findings/diagonal-half.md](../findings/diagonal-half.md), which carried the identity first.
6. **Narrow the literature sentence** in [findings/target.md](../findings/target.md) to "no comparison between $\lambda$ and $\mu$", since second-kind-to-sectional and second-kind-to-Ricci comparisons are standard.
