# Reviewer 111, the $Q$ decomposition, the cap refinement, the $S$-jump scoping, and the separation shortcut

Adversarial audit, own implementation, cold brief. Code in [scripts/reviewers/r111/](../scripts/reviewers/r111/); log in [agent_logs/reviewer111.log](../agent_logs/reviewer111.log).

| Claim | Verdict |
| --- | --- |
| 1, the $Q$ decomposition and its two constraints | **CONFIRMED**, and strengthened: the per-row identity is a *linear* identity on $\mathcal W_n$ valid for every unit $v\in\mathfrak{so}(n)$, not only eigenvectors |
| 2, the cap refinement cancels; the uniform cap is saturated at the maximiser | **CONFIRMED as scoped**, with an exact closed form for the cancellation, and **one generalisation REFUTED** ("weaker, never stronger" fails at unbalanced sphere products and at padded $W_{\mathbb{CP}^2}$). The attack question is answered: a non-cancelling bound **does** exist, and it gains exactly nothing at the maximiser |
| 3, the $S$-jump is mis-scoped | **CONFIRMED**, and the new question answered: **$S$ does not jump on $\mathrm{Crit}(P)$ near $W_{\mathbb{CP}^2}$**, it is identically $0$ there |
| 4, the separation shortcut | **REFUTED as a proof route.** Its topological half is correct and trivial; its input, finiteness from the Cartan enumeration, is a statement about symmetric pairs, and "route sketch" is too strong |

## Gatekeepers, before any verdict

Everything below is built from the brief's definitions in [core111.py](../scripts/reviewers/r111/core111.py), importing nothing from the project's own scripts.

| gate | result |
| --- | --- |
| $\dim\mathcal W_n$ at $n=4,5,6,7,8$ | $10,35,84,168,300$, exact |
| $\theta(W_{\mathbb{CP}^2})$ at $n=4$ | $1.224744871392=\sqrt{3/2}$, criticality residual $4\times10^{-16}$ |
| $\theta(S^{n/2}\times S^{n/2})$ at $n=6,8,10,12$ | $\theta_0(n)$ to all printed digits, residuals $\le6\times10^{-16}$ |
| $\theta(S^5\times S^7)$ at $n=12$ | $1.228239157726$, reproduces the record's $1.228239$ |
| $\theta(SO(8)/U(4))$ | $0.986013297$, reproduces the record |

---

## Claim 1, CONFIRMED, and the "definitional" reading is right

All seven identities hold at $n=5,6,7,8$ on random Weyl operators, balanced sphere products and padded $W_{\mathbb{CP}^2}$, worst deviation $3.6\times10^{-14}$ ([c1.py](../scripts/reviewers/r111/c1.py)):

$$\rho_\alpha=2(n-2),\quad \textstyle\sum_\alpha\lambda_\alpha R_{\gamma\alpha}=-2\lambda_\gamma,\quad g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma,$$
$$\textstyle\sum_\gamma Q_\gamma=-2\lVert W\rVert^2,\quad \sum_\gamma\lambda_\gamma Q_\gamma=2\langle W^\#,W\rangle,\quad \sum_\gamma g_\gamma=4(n-1),\quad \sum_\gamma\lambda_\gamma g_\gamma=-4\theta.$$

**The claim that the equalities carry nothing new is correct, and here is the whole chain in four lines.**

- $\rho_\alpha=-\operatorname{tr}\mathrm{ad}(v_\alpha)^2=(n-2)\operatorname{tr}(v_\alpha^{\mathsf T}v_\alpha)=2(n-2)$, the Killing form of $\mathfrak{so}(n)$, no Weyl structure used.
- $g_\gamma=\sum_{\alpha\beta}T_{\gamma\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2$ expands term by term into $2\sum\lambda^2R-2Q$. Algebra only.
- $\sum_\gamma\lambda_\gamma Q_\gamma=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\gamma\alpha\beta}=2\langle W^\#,W\rangle$ **is** the definition of $\#$ in an orthonormal basis, $(W^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}W_{\gamma\epsilon}W_{\delta\zeta}$, read in the eigenbasis. Nothing is being verified.
- $\sum_\gamma Q_\gamma=\lambda^{\mathsf T}R\lambda=\lambda\cdot(-2\lambda)=-2\lVert W\rVert^2$, and the two contractions then give $4(n-1)$ and $-4\theta$ directly.

**One correction to the framing, in the record's favour.** "Definitional" understates the per-row identity, which is Ricci-flatness rather than a definition, but it is weaker than the record treats it. I find ([c1b.py](../scripts/reviewers/r111/c1b.py)) that

$$\Pi_{\mathcal W}\big(\mathrm{ad}(v)^2\big)=-2\,\Pi_{\mathcal W}\big(vv^{\mathsf T}\big)\qquad\text{for every unit }v\in\mathfrak{so}(n),$$

to $3\times10^{-16}$ at $n=5,6,8$ on random unit $v$, so the per-row identity is one **linear** identity on $\mathcal W_n$, holding at every $W$, critical or not, and at every direction $v$, eigenvector or not. It is a restatement of trace-freeness. Confirmed by hand at $v=\phi_{12}$: $-\operatorname{tr}(M\,\mathrm{ad}(\phi_{12})^2)=\sum_{k\ge3}(W_{1k1k}+W_{2k2k})=-2W_{1212}$ by the Ricci trace.

---

## Claim 2, CONFIRMED as scoped, one generalisation REFUTED, and the attack succeeds without helping

### The cancellation has an exact closed form

Write $\rho=2(n-2)$, $h=\lambda_{\max}$, $l=\lambda_{\min}$, and let the two-moment problem place mass $a$ at $h$ and $b$ at $l$ with $a+b=\rho$, $ah+bl=-2\lambda_\gamma$. Then the refined cap is $\mathrm{Rf}_\gamma=2(ah^2+bl^2)-2\rho lh=2(h-l)(ah-bl)$ against the uniform cap $U=\rho(h-l)^2$, so

$$\mathrm{Rf}_\gamma-U=(a-b)\,(\lambda_{\max}^2-\lambda_{\min}^2)$$

verified to $4\times10^{-15}$ at every test point, $n=6,8,10$ ([c2b.py](../scripts/reviewers/r111/c2b.py)). This is the record's numerics explained rather than measured: the gain from the moment constraint and the loss from $Q_\gamma\ge\lambda_{\min}\lambda_{\max}\rho$ cancel identically, leaving a residue whose **sign is uncontrolled**.

### The recorded numbers reproduce, and the generalisation drawn from them does not

| point | $\max_\gamma\mathrm{Rf}_\gamma/U$ | brief |
| --- | --- | --- |
| $S^3\times S^3$, $S^4\times S^4$, $S^5\times S^5$ | $1.00000$ exactly | $1.0000\times$ ✓ |
| random Weyl, $n=6,8,10$ | $1.0013$–$1.0104$ | $1.001$–$1.011\times$ ✓ |
| $S^3\times S^5$ ($n=8$) | $0.85714$ |, |
| $S^4\times S^6$ ($n=10$) | $0.91667$ |, |
| padded $W_{\mathbb{CP}^2}$, $n=6/8/10$ | $0.94444$ / $0.92593$ / $0.91667$ |, |

**"Weaker, never stronger" is REFUTED as a general statement.** At every unbalanced sphere product and at every padding of $W_{\mathbb{CP}^2}$ the refinement is strictly *stronger*, by up to $14\%$. Within the brief's own scope (balanced products and random points), the claim holds.

### The uniform cap is saturated at the maximiser, and there is a closed form

At $S^{n/2}\times S^{n/2}$, $\min_\gamma(U-g_\gamma)=0$ exactly at $n=6,8,10$. The reading must be $\max_\gamma g_\gamma=U$, not per-$\gamma$ saturation: $\max_\gamma(U-g_\gamma)=U$, i.e. many $\gamma$ carry $g_\gamma=0$. With $p=\dim\mathfrak k$, $q=\dim\mathfrak m$,

$$\max_\gamma g_\gamma=U=2(n-2)\frac{p+q}{pq}=\frac{16(n-1)}{n^2},$$

giving $20/9$, $7/4$, $36/25$ at $n=6,8,10$, matching to all printed digits.

### The attack the brief asked for: a non-cancelling bound exists

The brief names the unused constraint $\sum_\alpha u_{\gamma\alpha}=-2\lambda_\gamma$. Using it *jointly* rather than splitting the estimate in two removes the cancellation entirely. Treat the pair masses $w_{\alpha\beta}=T_{\gamma\alpha\beta}$ as the single unknown and solve

$$\mathrm{JLP}_\gamma=\max\Big\{\textstyle\sum_{\alpha\beta}w_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2\ :\ w\ge0,\ \sum w=\rho,\ \sum w_{\alpha\beta}\tfrac{\lambda_\alpha+\lambda_\beta}2=-2\lambda_\gamma\Big\},$$

which is the two-dimensional LP whose value is $\rho$ times the upper concave envelope of $\{(\tfrac{\lambda_\alpha+\lambda_\beta}2,(\lambda_\alpha-\lambda_\beta)^2)\}$ at $-2\lambda_\gamma/\rho$. Since it is the exact optimum of the feasible set the split bound relaxes, $g_\gamma\le\mathrm{JLP}_\gamma\le\min(U,\mathrm{Rf}_\gamma)$ **always**, it can never be weaker than the uniform cap, which is exactly the failure mode the record diagnosed.

| point | $\max_\gamma\mathrm{JLP}_\gamma/U$ |
| --- | --- |
| $S^3\times S^3$, $S^4\times S^4$, $S^5\times S^5$ | $1.00000$ |
| $S^3\times S^5$ / $S^4\times S^6$ | $0.66667$ / $0.75000$ |
| padded $W_{\mathbb{CP}^2}$, $n=6/8/10$ | $0.83333$ / $0.77778$ / $0.75000$ |
| random, $n=6,8,10$ | $0.9898$–$1.0000$ |

**So the record's conclusion survives for the reason it gave, but the reason was wrong.** The gain does not cancel because no better bound on $Q_\gamma$ exists; it cancels because the two moments were spent separately. Spending them together is a strict improvement, and it buys **exactly nothing at the maximiser** ($\mathrm{JLP}=U$ there) and at most $1\%$ at random points. And the joint LP is a transportation problem over $T$'s marginals, so it is inside the class [post F10](../findings/fence-posts.md) names and Reviewers 67/68 ceilinged. *The route stays closed; the sentence closing it should be replaced.*

One further reason the family cannot close, not in the record: at random points $\max_\gamma g_\gamma$ is $0.92$–$2.20$ against $U\approx5$–$7.5$, a standing overshoot of about $5\times$ that no marginal-based cap can recover.

---

## Claim 3, CONFIRMED, and the new question has a clean negative answer

### The scoping correction is right

[review_r52_m5.py](../scripts/reviewers/r52/review_r52_m5.py) forms `Wp = W + eps*d` with `d` a random combination of `K.weyl_basis(n)` and renormalises. There is no projection back to $\mathrm{Crit}(P)$ anywhere in the file. **CONFIRMED.** (Note the cited script runs 60 perturbations at $n=8$; the record's "200 perturbations" figure comes from [REVIEW.md:770](../REVIEW.md#L770) and I could not locate the script that produced it. The mechanism is the same either way.)

### The new question: does $S$ jump on $\mathrm{Crit}(P)$ near $W_{\mathbb{CP}^2}$? **No.**

Two independent routes, both in [c3a.py](../scripts/reviewers/r111/c3a.py) and [c3b.py](../scripts/reviewers/r111/c3b.py).

**Route 1, solve criticality nearby, analytically.** At a critical point, $\ker\mathrm{Hess}(P|_{S})=\ker\big(H-3\theta\big)\cap W^\perp$ with $H(h)=3\Pi_{\mathcal W}(Wh+hW+2W\#h)$. Measured at padded $W_{\mathbb{CP}^2}$:

| $n$ | $\theta/\theta_0$ | orbit | $\dim\ker\mathrm{Hess}$ | excess |
| --- | --- | --- | --- | --- |
| 6 | $1.1619$ | 10 | 10 | **0** |
| 8 | $1.0690$ | 18 | 18 | **0** |
| 10 | $1.0206$ | 26 | 26 | **0** |

(Controls: $S^4\times S^4$ gives $16=16$; $S^3\times S^3$ gives $18$ against orbit $9$, reproducing the record's anomaly exactly.)

With $\ker dF=T_W(\text{orbit})$ and the orbit contained in $\mathrm{Crit}(P)$, the implicit function theorem on a slice transverse to the orbit gives $\mathrm{Crit}(P)=O(n)\cdot W$ **as a set germ**. So $S\equiv0$ on a whole neighbourhood of $W_{\mathbb{CP}^2}$ in $\mathrm{Crit}(P)$: no jump, and none possible.

**Route 2, perturb and project back.** Perturb by $\varepsilon d$ on the sphere, then Gauss–Newton onto $F(W)=\Pi_{\mathcal W}Q(W)-P(W)W=0$, 12 draws per row:

| point | $n$ | $\varepsilon$ | $S$ on the sphere (min/med/max) | $S$ after projecting to $\mathrm{Crit}(P)$ | off-orbit distance |
| --- | --- | --- | --- | --- | --- |
| padded $W_{\mathbb{CP}^2}$ | 6 | $10^{-6}$ | $3.30$ / $8.57$ / $10.26$ | $1.4\times10^{-47}$ / $2.2\times10^{-46}$ / $2.0\times10^{-45}$ | $1.7\times10^{-12}$ |
| padded $W_{\mathbb{CP}^2}$ | 8 | $10^{-6}$ | $20.59$ / $26.74$ / $44.93$ | $1.9\times10^{-47}$ / $4.4\times10^{-46}$ / $1.9\times10^{-45}$ | $8.1\times10^{-13}$ |
| padded $W_{\mathbb{CP}^2}$ | 8 | $10^{-3}$ | $18.28$ / $30.34$ / $46.85$ | $1.2\times10^{-40}$ / $9.4\times10^{-40}$ / $1.0\times10^{-37}$ | $5.7\times10^{-5}$ |
| $S^4\times S^4$ (control) | 8 | $10^{-6}$ | $0$ / $0$ / $0$ | $\approx3\times10^{-29}$ | $3.1\times10^{-12}$ |

Criticality residual after projection $\le1.8\times10^{-15}$ throughout. Every projected point lands back on the orbit, the off-orbit residual is $O(\varepsilon^2)$, which is the orbit's own curvature.

**So the correction understates the damage.** The recorded jump is not merely off-target; the on-target statement is its opposite. The mechanism is a padding artefact: padded $W_{\mathbb{CP}^2}$ at $n=8$ has $26$ zero eigenvalues, a sphere perturbation splits them and reshuffles $\mathfrak m$, and $S$ leaps. Restricting to $\mathrm{Crit}(P)$ removes the freedom that does the splitting.

**What this buys the programme, positively.** $W_{\mathbb{CP}^2}$'s orbit *is* isolated inside $\mathrm{Crit}(P)$, it is open there by nondegeneracy and closed there by compactness, hence a union of connected components, so it can be excised from any compactness argument. That isolation comes from the Hessian, not from $S$, and it holds at $n=6,8,10$ here and at $n=12$ on the record.

*One caveat, honestly reported:* at $S^3\times S^3$, $n=6$, $\varepsilon=10^{-3}$, one of 12 projections failed to converge ($\lVert F\rVert=0.53$) and drifted. That point is the degenerate one, so Newton has flat directions to wander along; it is not a counterexample to anything above.

---

## Claim 4, the consequential one. REFUTED as a proof route

### What is correct, and it is the easy half

**"A finite union of $O(n)$-orbits is closed outright", CONFIRMED, and it needs no compactness argument beyond the trivial one.** $O(n)$ is compact and acts continuously on $\mathcal W_n$, so each orbit is a continuous image of a compact set, hence compact, hence closed in the Hausdorff space $\mathcal W_n$; a finite union of closed sets is closed; and a set closed in $\mathcal W_n$ is closed in the subspace topology of any subset, $\mathrm{Crit}(P)$ included. This answers the brief's third and fourth questions outright: **yes the orbits are compact, yes a finite union is closed in $\mathrm{Crit}(P)$, and no, a set that is finite-mod-$O(n)$ cannot fail to be closed.** There is no gap on this side.

### What is wrong: the enumeration is about symmetric pairs, exactly as suspected

**Gradedness pins the pair, not the point.** $W$ graded means the eigen-splitting $\mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m$ (nonnegative / negative eigenspaces) is a $\mathbb Z_2$-grading, so $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair and Cartan gives a finite list of conjugacy classes, $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$. That fixes the involution $\sigma$ up to $O(n)$. **It does not fix $W$.** The grading is $\mathrm{Ad}(\sigma)$ for an involution $\sigma\in O(n)$; $\mathcal W_n^\sigma$ is a linear subspace, $Q$ preserves it ($W^\#$ respects the parity, and $\Pi_{\mathcal W}$ is $O(n)$-equivariant), so by symmetric criticality the graded critical points with grading $\sigma$ are the sign-feasible critical points of $P$ restricted to $\mathcal W_n^\sigma$. Measured ([c4b.py](../scripts/reviewers/r111/c4b.py)):

| $n$ | pair | $\dim\mathcal W_n^\sigma$ | $\dim$ of the $H$-invariant slice the enumeration searches |
| --- | --- | --- | --- |
| 6 | $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ | 44 | **1** |
| 6 | $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ | 45 | **1** |
| 6 | $\mathfrak u(3)$ | 48 | **1** |
| 8 | $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ | 160 | **1** |
| 8 | $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ | 155 | **1** |
| 8 | $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ | 156 | **1** |
| 8 | $\mathfrak u(4)$ | 160 | **1** |

($\dim\mathcal W_6=84$, $\dim\mathcal W_8=300$.) The enumeration returns **one ray per pair**; gradedness allows a $43$- to $159$-dimensional sphere of candidates per pair. And that sphere is not empty of critical points: Newton from 59 random starts inside the $45$-dimensional $\mathcal W_6^{\sigma}$ for the $(3,3)$ split returns **39 distinct critical points** ([c4.py](../scripts/reviewers/r111/c4.py)), none of them the enumerated one and none of them sign-feasible on that draw. Finiteness of the *graded* set is not among the things a one-parameter enumeration can establish.

**The record already contains this scoping, twice.**

- [graded-half.md:323](../findings/graded-half.md): "a non-symmetric homogeneous Einstein metric can have a graded Weyl operator ... gradedness ... is strictly weaker than symmetry of the underlying space." The reason given for treating Jensen's metric as "not a new class" is that its $\theta=\sqrt{6/5}$ *coincides* with the $\mathfrak{su}(3)$ Kähler point. **That inference is unsound by the record's own value table**, which lists $S^3\times S^3$ and $\mathbb{CP}^3$ both at $\sqrt{10/9}$ at $n=6$ as distinct orbits, and $\mathbb{HP}^2$ and $S^3\times S^5$ both at $\sqrt{56/45}$ at $n=8$ as an explicit "triality pair, one diagonal and one not". Value coincidence is not orbit identity here, and the record says so elsewhere.
- [graded-half.md:194](../findings/graded-half.md), Reviewer 15's Correction 5: "Graded critical points here are indexed by symmetric *pairs* $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$; Petersen–Stanfield classify symmetric *spaces* ... The plan item proposing that route is withdrawn." The shortcut re-proposes the withdrawn identification with the roles of "space" and "critical point" swapped.

**And the finiteness claim cannot be stronger than step H, which is explicitly conditional.** [plan.md](../plan.md) states **H** as "every graded critical point with $\theta>\sqrt{3/2}$ is a sphere product, **on the subalgebra family at $n\ne8$, both hypotheses load-bearing**". If the record cannot bound $\theta$ on graded critical points outside the subalgebra family, it has not enumerated them either. The shortcut would let the separation be proved from an enumeration whose own value statement is conditional on the same restriction.

### The openness half is overstated too, and it is not an independent leg

The brief presents openness as proved and closedness as the only gap. But [LEDGER.md](../findings/LEDGER.md) says in its own words: **"'Every graded critical point is Morse–Bott nondegenerate' is false"**. Openness is proved *across the classification*, the same restriction as the finiteness claim. So the two halves of the shortcut rest on one assumption, not two, and the argument reads as stronger than it is because the assumption is named differently on each side.

### Two corrections to the record's counterexample list, found here

**The two-block Fox plateau is NOT $\mathbb Z_2$-graded in $\mathfrak{so}(8)$.** Measured ([c4c.py](../scripts/reviewers/r111/c4c.py) and the slack computation in [core111.py](../scripts/reviewers/r111/core111.py)): $\theta=0.866025404$, criticality residual $9.6\times10^{-17}$, spectrum $(-0.288675^{\times4},\,0^{\times22},\,0.57735^{\times2})$, so $\dim\mathfrak h=24$, $\dim\mathfrak m=4$, and

$$S_{\mathfrak{mmm}}=0\quad\text{but}\quad S_{\mathfrak{hhm}}=32.$$

Independently, $\dim\mathfrak m=4$ is not the $\mathfrak m$-dimension of *any* symmetric pair of $\mathfrak{so}(8)$: those are $7,12,15,16$ for $\mathfrak{so}(p)\oplus\mathfrak{so}(8-p)$ and $12$ for $\mathfrak u(4)$. The plateau is the same $S_{\mathfrak{mmm}}=0$-but-ungraded shape as padded $W_{\mathbb{CP}^2}$ ($S_{\mathfrak{hhm}}=16$ there) and for the same reason, a large kernel absorbed into $\mathfrak h$. This is exactly the distinction [bounds.md:85](../findings/bounds.md) drew for padded $W_{\mathbb{CP}^2}$, applied to a point [LEDGER.md](../findings/LEDGER.md) classifies the other way. **So one of the ledger's two stated degenerate-graded counterexamples is not graded.**

**$SO(8)/U(4)$ is graded and nondegenerate.** Built here as the unique $U(4)$-invariant Weyl operator (the invariance system has nullity exactly $1$): $\theta=0.986013297$ matching the record, residual $1.9\times10^{-15}$, $S_{\mathfrak{mmm}}=S_{\mathfrak{hhm}}\approx3\times10^{-28}$, orbit $12$ and kernel excess $0$. I did not test the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family, which is the more likely referent of the ledger's "$\mathfrak{su}(m)$ Kähler points", so that half of its counterexample list stands untested here.

### One empirical probe, and it goes the record's way

At $S^3\times S^3$ ($n=6$), genuinely graded ($S_{\mathfrak{mmm}}=S_{\mathfrak{hhm}}=0$) and genuinely degenerate (kernel $19$ against orbit $9$, excess $9$), slice-constrained continuation along four random transverse kernel directions ([c4d.py](../scripts/reviewers/r111/c4d.py)) gives $\lVert F\rVert=0.27$–$4.6\times\varepsilon^2$ across $\varepsilon\in\{10^{-2},10^{-3},10^{-4}\}$ rather than converging. **No critical branch**: the degeneracy is second-order-obstructed and does not integrate, corroborating the record's own Result 12(a). $S^2\times S^4$ at $n=6$ and $SO(8)/U(4)$ at $n=8$ are graded and nondegenerate outright. So nothing found here contradicts finiteness, but the record's own rule applies: a single search method is not a census, and this is one point at one $n$.

### The failure mode the shortcut does not see

Finiteness is sufficient for closedness and is not necessary, so refuting the shortcut's input leaves closedness open rather than false. The mechanism that would break it is worth stating, because it is checkable and it is the one the argument should target instead.

Let $W_k\to W$ with each $W_k$ graded by an involution $\sigma_k\in O(n)$. Compactness of $O(n)$ gives $\sigma_k\to\sigma$ along a subsequence, and $W$ is $\mathrm{Ad}(\sigma)$-invariant. But gradedness of $W$ requires its **own** nonnegative eigenspace to be the $+1$-space of $\sigma$, and eigenvalues may cross zero in the limit: a direction that was in $\mathfrak m(W_k)$ can land in $\mathfrak h(W)$. That is precisely what makes padded $W_{\mathbb{CP}^2}$ and the Fox plateau ungraded, in both cases a large kernel sits inside $\mathfrak h$ while $[\mathfrak h,\mathfrak h]\not\subseteq\mathfrak h$. So the honest statement is:

> the closure of the graded critical set lies in $\{W\in\mathrm{Crit}(P):W\text{ is }\mathrm{Ad}(\sigma)\text{-invariant for some involution }\sigma\}$, and closedness is exactly the absence of a zero-crossing limit.

That is a statement about eigenvalue gaps on $\mathrm{Crit}(P)$, and it does not need the enumeration.

### Is "route sketch" too strong?

**Yes.** A route sketch asserts that the pieces exist and only assembly is owed. Here the topological piece is real and trivial, and the piece it consumes ("the graded critical set is a finite union of $O(n)$-orbits"), is **not on the record in any form**. What is on the record is a classification of one $H$-invariant ray per symmetric pair, whose own value statement (step H) is conditional on the subalgebra family and $n\ne8$. The accurate label is *a reduction*: it reduces closedness of the graded set to finiteness of the graded set mod $O(n)$, which is a new and unproven statement, strictly stronger than anything the enumeration provides and plausibly comparable in difficulty to the separation itself. Recorded as a route sketch it would be the seventh route-affecting inference of the session drawn from a correct computation.

---

## Corrections owed to the record

1. [findings/nondegeneracy.md](../findings/nondegeneracy.md), the $S$-jump paragraph: the on-$\mathrm{Crit}(P)$ statement is the opposite of the on-sphere one. $S\equiv0$ on a neighbourhood of $W_{\mathbb{CP}^2}$ in $\mathrm{Crit}(P)$, because $\mathrm{Crit}(P)$ is locally exactly the orbit there (excess $0$ at $n=6,8,10$).
2. [findings/nondegeneracy.md](../findings/nondegeneracy.md), the route-sketch paragraph: "the record already carries the finiteness" is false; finiteness of the graded critical set mod $O(n)$ is nowhere established.
3. [findings/LEDGER.md](../findings/LEDGER.md), the two-block Fox plateau is **not** graded ($S_{\mathfrak{hhm}}=32$, $\dim\mathfrak m=4$), so it is not a counterexample to "every graded critical point is nondegenerate".
4. [findings/bounds.md](../findings/bounds.md), the sentence closing the per-coordinate cap should be replaced: the gain does not cancel because no better $Q_\gamma$ bound exists, but because the two moments are spent separately; the joint LP dominates both and is still inside [post F10](../findings/fence-posts.md)'s class.
5. [findings/graded-half.md:323](../findings/graded-half.md), reading Jensen's metric as "not a new class" from a coincidence of $\theta$ contradicts the record's own $\sqrt{10/9}$ and $\sqrt{56/45}$ pairs.
6. Worth recording as new: $\mathrm{Rf}_\gamma-U=(a-b)(\lambda_{\max}^2-\lambda_{\min}^2)$; $\max_\gamma g_\gamma=16(n-1)/n^2$ at the balanced product; $\Pi_{\mathcal W}(\mathrm{ad}(v)^2)=-2\Pi_{\mathcal W}(vv^{\mathsf T})$ for every unit $v$.


---

## Synthesis carried in REVIEW.md

### Reviewers 111 and 112: the Q decomposition, the cap, and the separation shortcut

Full reports: [reviews/REVIEW_r111.md](reviews/REVIEW_r111.md), [reviews/REVIEW_r112.md](reviews/REVIEW_r112.md). Identical briefs, own builds, gatekeepers passed before any claim. **Agreeing on all four verdicts.**

| Claim | Verdict |
|---|---|
| The $Q$ decomposition and its two constraints | **CONFIRMED**, and weaker than stated, criticality contributes nothing |
| The cap refinement cancels; the uniform cap is saturated | Load-bearing half **CONFIRMED**; *"weaker, never stronger"* **REFUTED** |
| The $S$-jump is mis-scoped | **CONFIRMED**; the new question answered **negatively** |
| The finiteness shortcut to the separation | **REFUTED, circular** |

**Two results the round won.** $W_{\mathbb{CP}^2}$'s orbit **is** a union of connected components of $\mathrm{Crit}(P)$, established from the Hessian: padded $W_{\mathbb{CP}^2}$ is Morse–Bott nondegenerate at $n=6,8,10$ with excess $0$, so $\mathrm{Crit}(P)$ is locally exactly the orbit. And since $S$ is $O(n)$-invariant, it is *constant* there, so $S$ does not jump on $\mathrm{Crit}(P)$ near $W_{\mathbb{CP}^2}$ but is identically zero, the reverse of the recorded statement. Perturb-and-project: $S\approx10^{-46}$ after projection against $20.6$–$44.9$ on the sphere.

**The shortcut is circular, which neither the cycle nor the brief saw.** Under its own openness hypothesis $\mathrm{Crit}(P)/O(n)$ is compact Hausdorff and the graded set discrete in it, and a discrete subset of a compact Hausdorff space is finite **iff** closed. Finiteness *is* the conclusion. Three further failures: the record does not carry the finiteness at all (the graded enumeration is a projector ansatz whose exhaustiveness [graded-half.md](findings/graded-half.md) already withdrew, $306$ of $400$ cone starts inside one grading at $n=6$ reach **61 distinct** critical points); gradedness pins the *pair* not the point, the $H$-invariant slice being $1$-dimensional inside a $44$–$48$-dimensional $\mathcal W_6^\sigma$; and openness is overstated, $S^3\times S^3$ being degenerate with excess $9$.

**The repair both reviewers reached independently.** Gradedness can fail in a limit only by an eigenvalue reaching zero, so **closedness of the graded set is equivalent to a uniform lower bound on $\min\lvert\lambda\rvert$ over the graded critical set**, checkable, needing no enumeration. And closedness may not be on the critical path: the compactness step needs only $G$ open.

**Corrections carried into the record.** The refinement is strictly *stronger* at $S^3\times S^5$, $S^4\times S^6$, $S^5\times S^7$ and every padded $W_{\mathbb{CP}^2}$; the joint two-moment LP gains $17$–$33\%$ and still cannot close, sitting in post F10's class. The per-row identity holds for **every** unit $v$, so it is a restatement of trace-freeness rather than something stronger than the LP class's trace. The recorded $16.5$ is a random-sample minimum, and the jump's mechanism is $\dim\mathfrak m$ moving $2\to14$ at $n=8$ as padding contributes $25$ zero eigenvalues. Two misclassifications found: the two-block Fox plateau is **not** $\mathbb Z_2$-graded ($S_{\mathfrak{hhm}}=32$), and $SO(8)/U(4)$ is graded **and** nondegenerate.

## Reviewers 115 and 116, the grading test, and what its controls still missed

*Both worked from the definitions before opening a project script; 115 pinned $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, $\dim\mathrm{Weyl}_6=84$, $\dim\mathrm{Weyl}_6^{\sigma(3,3)}=45$ and $\theta$'s $SO(6)$-invariance to $1.3\times10^{-15}$ as gatekeepers first.*

**All four claims CONFIRMED, and the corrections are to how far they were read rather than to the numbers.** Reviewer 116 pinned the conventions independently before comparing ($\mathrm{Id}^\#=(n-2)\mathrm{Id}$, $\dim\mathrm{Weyl}=10/35/84$ at $n=4/5/6$) and reproduced $\theta=0.418198317$, gap $0.0021748$, $\dim\mathfrak m=10$, $S_{\mathfrak{mmm}}=21.5213$, $S_{\mathfrak{hhm}}=7.1738$ at residual $7.2\times10^{-16}$.

| Claim | Verdict | What decides it |
| --- | --- | --- |
| The test is $S_{\mathfrak{mmm}}=0$ and $S_{\mathfrak{hhm}}=0$, with $S_{\mathfrak{hhm}}\equiv S_{\mathfrak{hmh}}$ | **CONFIRMED**, and the identity is exact | $\max\lvert S_{\mathfrak{hhm}}-S_{\mathfrak{hmh}}\rvert=1.8\times10^{-33}$ over $200$ *arbitrary* splittings, not just eigenvalue ones |
| The sign flip exchanges $\mathfrak h$ and $\mathfrak m$ | **CONFIRMED** exactly | $+1.054093$ graded at $\dim\mathfrak m=9$; $-1.054093$ gives $S_{\mathfrak{mmm}}=12$, $S_{\mathfrak{hhm}}=36$ at $\dim\mathfrak m=6$ |
| The $\theta=0.418198$ point is ungraded | **CONFIRMED**, every digit | as above |
| The $\mathfrak h/\mathfrak m$ split needs a kernel tolerance | **CONFIRMED** in mechanism; the two quoted figures are implementation-specific | with tolerance $\dim\mathfrak m=2$, $S_{\mathfrak{hhm}}=8$, $\theta=\sqrt{3/2}$; without, the same operator gives $\dim\mathfrak m\in\{3,\dots,9\}$ and $S_{\mathfrak{mmm}}\in[0,19.0]$ |
| "The sweep says nothing about the gap floor" | **direction CORRECT, justification understated** | see below |

**Four things the claims did not say, and two are defects.**

- **The candidate's death is doubly determined.** On the flipped sign it has $S_{\mathfrak{mmm}}=0$ *and* $S_{\mathfrak{hhm}}=25.6525$, so the recorded $S=0$ was a one-condition test applied to the wrong sign. **Either error alone would have caught it**, and neither sign is graded.
- **`eigvalsh` and `eigh` disagree on the same matrix**, four negative eigenvalues against five. The untolerated split is not merely wrong; it is not reproducible across routines, so "$2.64$" understates the hazard.
- **DEFECT, in the recovery control.** It re-seeded its generator inside the radius loop, so its three "starts" were three points along **one ray** and its recovery rate was not a rate. Measured over $40$ directions per radius the rate is $68/48/22/32/10/12/0\%$ at relative radii $10^{-3}\to1.0$. **The load-bearing figure is $0$ of $40$ at relative radius $1$**, which is where the sweep's own starts sit; "recovered only within $\varepsilon=0.01$" over-reads a gradual decay. *Fixed.*
- **DEFECT, latent and aimed at the falsifier itself.** The `graded` threshold was absolute at $10^{-16}$ while $S$ scales as $(\text{residual}/\text{gap})^2$. **A genuine graded point with gap $\lesssim10^{-4}$ would be reported ungraded at any residual a solver accepts**, precisely the object being hunted. No recorded zero is affected, but the next one would have been. *Fixed: the threshold now scales.*

**And the inference is stronger than it was stated.** The sweep misses a known critical point in **every** cone that contains one, padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ in $\sigma(2,4)$ and $J$, $S^3\times S^3$ at $\theta_0(6)$ in three of four, with cone ceilings $0.8811$, $0.8811$, $0.7599$, $0.7921$. *Also recorded*: on the full $84$-dimensional sphere at $n=6$, ascent reaches padded $W_{\mathbb{CP}^2}$ from $500$ of $500$ random starts and $S^3\times S^3$ from $0$, which is a saddle there, consistent with $n=6$ sitting below the crossover, where the rival genuinely wins.
