# Reviewer 106, the min-entry lemma, the refuted extremiser, and the two single-audited claims

Cold brief, own implementation from the definitions, adversarial. Scripts in [scripts/reviewers/r106/](../scripts/reviewers/r106/); log at [agent_logs/reviewer106.log](../agent_logs/reviewer106.log).

## Verdicts

| Claim | Verdict |
|---|---|
| 1, the min-entry lemma and the proof offered | **CONFIRMED**, every step, and **sharp**: the constant is attained at every even $n$. The record's "not attained" is wrong |
| 2, the sphere product is not the extremiser | **Refutation CONFIRMED and strengthened**; the comparison numbers are the **wrong functional**; "no sharp constant is thereby established" is **REFUTED**, it is established, analytically |
| 3, monotone $+$ exact at $t=2$ $\Rightarrow$ $R\ge\theta_0$ | **Implication CONFIRMED** (it is three lines and they are right). **Every consequence drawn from it fails**: "vacuous" does not follow, the monotonicity is not automatic, and the sharpest bound of the fenced shape violates the hypothesis |
| 4, linear degradation, slope $1.05$–$1.23$ | **Numbers REPRODUCED exactly**, and they measure the **relaxation**, not $\theta$. The true first-order coefficient is **exactly $0$** in a fixed frame and **strictly negative** in $\kappa^2$. The statement is true, weak, conditional, and follows from a closed form already audited in the record |

**The one-line summary.** Claims 1 and 2 are better than advertised and the record understates them; Claims 3 and 4 are the two that were never independently reproduced, and both survive as *statements* while failing as *conclusions*, and they contradict each other.

## The implementation these verdicts rest on

Built from the brief's definitions ([r106_core.py](../scripts/reviewers/r106/r106_core.py)): random algebraic Weyl tensors by pair-symmetrisation, Bianchi projection and Kulkarni–Nomizu trace removal; $M_{(ij),(kl)}=W_{ijkl}$ over $i<j$; $K_{ab}=W_{abab}$; structure constants of $\mathfrak{so}(n)$ in the unnormalised $\varphi_{ij}=E_{ij}-E_{ji}$, and

$$\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle,\qquad M^\#_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}M_{\gamma\varepsilon}M_{\delta\zeta}.$$

**The factor $\tfrac12$ is not fitted, it is forced and it is $n$-independent**: solving $\theta(S^{n/2}\times S^{n/2})=\theta_0(n)$ for the scale returns $0.50000000$ at $n=6,8,10,12$ separately ([r106_calibrate.py](../scripts/reviewers/r106/r106_calibrate.py)). Controls, all passing before anything was reviewed ([r106_anchors.py](../scripts/reviewers/r106/r106_anchors.py)):

| control | value | record |
|---|---|---|
| $\theta(S^{n/2}\times S^{n/2})$, $n=6,8,10,12$ | $\theta_0(n)$ to $10^{-15}$ |, |
| $\theta(\mathbb{CP}^2)$, padded to $n=6$ and $n=12$ | $1.224745$ | $\sqrt{3/2}$ |
| $\theta(\mathbb{CP}^3),\ \theta(\mathbb{CP}^4),\ \theta(\mathbb{CP}^5)$ | $1.054093,\ 0.986013,\ 0.948683$ | all three |
| $\kappa^2(\mathbb{CP}^m)$, $m=2,3,4,5$ | $1,\ 0.75,\ 0.6,\ 0.5$ | $3/(m+1)$ |
| $\theta(S^3\times S^5),\ \theta(S^5\times S^7)$ | $1.115547,\ 1.228239$ | $\sqrt{56/45}$, $\sqrt{264/175}$ |
| sampler rank at $n=5,6,7$ | $35,84,168$ of $35,84,168$ | $\dim\mathcal W_n$, gap $\ge4.8\times10^{-1}\to6.2\times10^{-15}$ |

Spanning is load-bearing for none of the four claims, Claims 1 and 3 are proofs, Claim 2 is an optimisation over an explicitly parametrised linear space, Claim 4 is exact linear algebra on the whole space, but it makes the identity checks non-vacuous.

## Claim 1, CONFIRMED, and it is sharp

### The middle step survives, and it has a two-line proof better than the one offered

The brief asks hardest about "the configuration minimising $\lvert\min y\rvert$ is $M-1$ equal negatives against one positive". It is the right configuration and the right value, but the *reason* offered (inspection of configurations), is the weak form. The clean argument inverts the problem:

> Fix $c>0$ and ask which $y$ with $\sum y=0$ satisfy $y_i\ge-c$. That set is a **bounded** polytope: $y_i=-\sum_{j\ne i}y_j\le(M-1)c$. Its vertices need $M-1$ active constraints, so they are exactly the $M$ permutations of $(-c,\dots,-c,(M-1)c)$, each with $\sum y^2=M(M-1)c^2$. Since $\sum y^2$ is **convex**, it is maximised at a vertex. So $\sum y^2=s$ is feasible only if $s\le M(M-1)c^2$, i.e. $\lvert\min y\rvert\ge\sqrt{s/(M(M-1))}$.

Boundedness is the step the configuration argument skips and it is where an incorrect version would fail. Numerically ([r106_claim12.py](../scripts/reviewers/r106/r106_claim12.py)), SLSQP over $600$ starts returns the claimed value to $8$ digits at $(M,s)=(3,1),(5,1),(7,2),(9,0.7)$, and the argmin is the stated configuration in every case.

### The two steps do combine, and the brief's suspicion is unfounded

$\sum_as_a=\lVert K\rVert_F^2=t$ gives $\max_as_a\ge t/n$; row $a$ has $M=n-1$ entries because $K$ is hollow, and they sum to zero because $K\mathbf1=0$ with $K_{aa}=0$. The global minimum is $\le$ the row minimum, both are negative, so $\lvert\min_{a\ne b}K_{ab}\rvert\ge\lvert\min_bK_{ab}\rvert\ge\sqrt{t/((n-1)(n-2)n)}$. Nothing is lost in the combination.

### The constant IS attained, the record's item (c) is wrong

[plan.md](../plan.md) item (c) says "the derived $\sqrt{t/(n(n-1)(n-2))}$ is not attained". **It is, at every even $n$.** Equality needs $s_a=t/n$ in *every* row and the extremal configuration in one, hence in all; so every vertex carries exactly one heavy entry, and the heavy entries must pair up by symmetry, a **perfect matching**. Write $c=\sqrt{t/(n(n-1)(n-2))}$ and

$$K_{ab}=\begin{cases}(n-2)c,&b=\sigma(a)\\-c,&\text{otherwise,}\end{cases}\qquad \sigma\ \text{a fixed-point-free involution.}$$

Row sums vanish, $\lVert K\rVert_F^2=n(n-1)(n-2)c^2=t$, and $\lvert\min K\rvert=c$ exactly. It is a genuine vertex matrix: the coordinate-diagonal $W$ with $W_{abab}=K_{ab}$ has Weyl residual $\le8\times10^{-17}$, $\lVert M\rVert_F=1.000000000000$ and $t=2.000000000000$ at $n=6,8,10,12$ ([r106_claim12b.py](../scripts/reviewers/r106/r106_claim12b.py)). Its $\theta$ is $0.645497$, $0.540062$, $0.474342$, $0.428174$, far below $\theta_0(n)$, so the witness is harmless for Conjecture A and decisive for the lemma.

**So the sharp constant in the min-entry lemma is the derived one, for even $n$, and item (c) of the queue is closed by exhibition.**

### At odd $n$ the constant is not attained, and the true one is a different closed form

Equality forces a perfect matching, which an odd vertex set cannot carry. Minimising $\lvert\min K\rvert$ directly at $t=2$ ($60$ SLSQP starts):

| $n$ | numeric min | lemma bound | ratio |
|---|---|---|---|
| $5$ | $0.2357023$ | $0.1825742$ | $1.29099=\sqrt{5/3}$ |
| $7$ | $0.1132278$ | $0.0975900$ | $1.16024$ |
| $9$ | $0.0700198$ | $0.0629941$ | $1.11153$ |
| $6$ | $0.1290995$ | $0.1290994$ | $1.00000$ |

The three odd values fit $\sqrt{t\big/\bigl(n(n-1)(n-2)-\tfrac32(n-1)^2\bigr)}$ exactly, denominators $36$, $156$, $408$ against $60$, $210$, $504$. Offered as a **conjecture with three data points**, not a theorem; the even case needs no such caveat.

## Claim 2, the refutation stands, the numbers are the wrong functional, and the conclusion is refuted

### The sphere-product figures measure $\min_{a\ne b}\lvert K_{ab}\rvert$, not $\lvert\min_{a\ne b}K_{ab}\rvert$

For $S^m\times S^m$ normalised to $t=2$ the vertex matrix has two values only: $+\bigl((2m-1)(m-1)\bigr)^{-1/2}$ within a block and $-\sqrt{m-1}\big/\bigl(m\sqrt{2m-1}\bigr)$ across. The quoted $0.3162=1/\sqrt{10}$, $0.2182=1/\sqrt{21}$, $0.1667=1/6$ are the **positive** entries. The quantity the lemma bounds is the negative one:

| $n$ | quoted as "sphere product" | $\lvert\min_{a\ne b}K_{ab}\rvert$, actual |
|---|---|---|
| $6$ | $0.3162$ | $0.210819$ |
| $8$ | $0.2182$ | $0.163663$ |
| $10$ | $0.1667$ | $0.133333$ |

The ratio is exactly $n/(n-2)$. The refutation survives the correction, $0.1732<0.2108$, but the margin quoted is $1.8\times$ too large at $n=6$.

### I go lower, all the way to the lemma bound

| $n$ | exhibited in Claim 2 | my minimum | lemma bound | attained by |
|---|---|---|---|---|
| $6$ | $0.1732$ | $\mathbf{0.129099}$ | $0.129099$ | matching $K$ |
| $8$ | $0.1499$ | $\mathbf{0.077152}$ | $0.077152$ | matching $K$ |
| $10$ | $0.1444$ | $\mathbf{0.052705}$ | $0.052705$ | matching $K$ |

The exhibited witnesses are $34\%$, $94\%$ and $174\%$ above the true minimum. They are feasible points of an under-converged search, and this is the same failure mode Reviewer 103 caught in the previous round's Claim 4, a maximum quoted from a search whose structured optimum was never in the start set.

### "No sharp constant is thereby established", REFUTED

Correct about the *search*: a search gives upper bounds only. But the sharp constant is not established by the search, it is established by **the lemma as the matching lower bound and the matching $K$ as the witness**, and it is $\sqrt{t/(n(n-1)(n-2))}$ at every even $n$. Claim 2 draws a negative conclusion from the weakness of its own instrument.

## Claim 3, the implication is right, and every consequence drawn from it is wrong

The three-line argument is valid and I have no correction to it: non-increasing gives $R(t)\ge R(2)=\theta_0(n)$ for $t\le2$, and $t=2$ characterises coordinate-diagonality. That is all it gives, and the claim then spends it four times over.

### 1. "Therefore vacuous except at $t=2$" does not follow, the target is exactly $\theta_0$

$R(t)\ge\theta_0(n)$ is **non-improvement**, not vacuity. The constant function $R\equiv\theta_0(n)$ satisfies both hypotheses (weakly non-increasing, exact at $t=2$) and *is* Conjecture A. So the fenced shape is not barred from proving the conjecture; it is barred only from proving something stronger than the conjecture, which nobody wants. What kills a particular relaxation is the **strict** inequality $R(t)>\theta_0$ for $t<2$, and strictness is instance-specific and has to be computed. I confirm it for Schur–Horn (below, and it is a large effect), but no part of that is delivered by the generic argument.

### 2. A non-vacuous bound of the fenced shape exists, and Claim 4's is one

Claim 4 offers $\theta\le\theta_0(n)+O(2-\kappa^2)$ as the round's positive output, and [plan.md](../plan.md) item (a) says it "is not caught by post F24 since it is not a bound of the fenced shape". **It is exactly of the fenced shape**: it reads $W$ only through $\kappa^2$, it is non-increasing in $\kappa^2$, and it equals $\theta_0$ at $\kappa^2=2$. The two claims of this round contradict each other, and the resolution is item 1, the fenced conclusion was never vacuity. A second instance, with an explicit constant, is derived under Claim 4 below:

$$\theta\ \le\ \theta_0(n)\sqrt{1-u}\,\bigl(1+\tfrac u2\bigr)+M(n)\,u^{3/2},\qquad u=1-\tfrac t2 ,$$

non-increasing in $t$, exact at $t=2$, and strictly below the unconstrained bound in a band under $t=2$.

### 3. The monotonicity is not automatic, and the *sharpest* bound of the fenced shape violates it

"Automatic whenever the diagonal class is a linear space" is not a property of the diagonal class; it is a property of a relaxation whose constraints are positively homogeneous in $K$ and one-sided, so that the feasible set nests under $K\mapsto cK$. Schur–Horn is such a relaxation. The demonstration that this is not generic is the extremal case: let

$$R^\star(t)=\sup\{\theta(W):\kappa^2(W)=t\}$$

be the best possible bound of exactly this shape. If Conjecture A holds then $R^\star(2)=\theta_0(n)$ is the **global maximum** of $R^\star$, and my second-order computation below shows it is a **strict local maximum** with slope $-\tfrac32\theta_0/(n-2)$. So $R^\star$ *increases* into $t=2$ and is not non-increasing. **The optimal member of the fenced family fails the fence's hypothesis.** Hence "so would any successor built from the vertex matrix or the sectional-curvature function" is false as stated.

### 4. "Diagonal information of size $t$" is not well defined enough to carry the scope claim

The argument quantifies over $R$ as a function of the **scalar** $t$. A bound reading the whole vertex matrix ($R(K)$), is untouched: monotonicity in $t$ is not even a meaningful hypothesis for it. **Claim 1's min-entry lemma is precisely such a functional**, and it lives inside the family the post says it closes. The honest scope is: *a bound that factors through $\lVert K\rVert_F^2$ alone, and is monotone in it, cannot beat $\theta_0$.* Everything wider is unsupported.

### What I do confirm

The specific relaxation is strictly loose below $t=2$, independently rebuilt ([r106_relax.py](../scripts/reviewers/r106/r106_relax.py)), see the table under Claim 4. So Claim 3's *application* to the both-sided Schur–Horn relaxation is right; its generalisation is not.

## Claim 4, the numbers reproduce, the object is the wrong one, and the truth is stronger

### The numbers are real: I rebuilt the relaxation and hit them

Independent build of the both-sided relaxation ([r106_relax.py](../scripts/reviewers/r106/r106_relax.py)), the two sides decouple, so it is $\tfrac32\max\{p_3(\mu):\mu\succ\mathop{\mathrm{diag}}M,\ \textstyle\sum\mu=0,\sum\mu^2=1\}+\tfrac12\max\{-p_3(\omega):\omega\succ d,\ \sum\omega=0,\sum\omega^2=3\}$, each by SLSQP over sorted vectors with $12$–$20$ starts. At $K=c\,K_{S^6\times S^6}$, $n=12$:

| $2-t$ | $R-\theta_0(12)$ | slope | Claim 4's figure |
|---|---|---|---|
| $0.000400$ | $0.000412$ | $1.030$ |, |
| $0.003998$ | $0.004204$ | $1.051$ | $0.0042$ at $0.0040$ |
| $0.039800$ | $0.044519$ | $1.119$ | $0.0445$ at $0.0398$ |
| $0.195000$ | $0.240532$ | $1.234$ | $0.2405$ at $0.1950$ |

Three digits on all three, and $R(2)=1.236033=\theta_0(12)$ to $10^{-15}$. **Claim 4's arithmetic is reproduced.** It survives at other $n$ too, with an $n$-dependent constant the claim does not mention: the slope at $2-t=4\times10^{-4}$ is $1.298$ at $n=8$, $1.030$ at $n=12$, $0.902$ at $n=16$ ([r106_relax2.py](../scripts/reviewers/r106/r106_relax2.py)).

### But that is the slope of $R$, and $R$ is an upper bound, so it carries no information about $\theta$

$R$ is a *relaxation*: $\theta(W)\le R(t)$. A relaxation whose value climbs away from $t=2$ tells you the relaxation is degrading, not that $\theta$ is. Both inequalities point the same way, and $\theta$'s own behaviour is unconstrained by them. Nor is the failure "a sampling artefact", there is no sample; $c\mapsto cK^*$ is a curve, and the quantity is computed on it correctly. **The defect is that the wrong function was differentiated.**

### The true first-order coefficient, exactly

Split $M=D+\Delta$, $D=\mathop{\mathrm{diag}}M$ and $\Delta$ the rest. Both sit in $\mathcal W_n$: $D$ is the coordinate-diagonal tensor with $W_{abab}=K_{ab}$, and $K\mathbf1=0$ is exactly what makes it trace-free, so $\mathcal W_n=\mathcal W_n^{\mathrm{diag}}\oplus\mathcal W_n^{\mathrm{off}}$ orthogonally (dimensions $9+75=84$ at $n=6$, $20+280=300$ at $n=8$, matching $n(n-3)/2$ and $\dim\mathcal W_n$). With $\lVert M\rVert=1$: $\lVert D\rVert^2=t/2$, $\lVert\Delta\rVert^2=1-t/2$.

**The linear term vanishes identically.** $Q(D)=D^2+D^\#$ is diagonal whenever $D$ is: $D^2$ obviously, and $D^\#$ because $[\varphi_\gamma,\varphi_\delta]$ is a **multiple of a single basis element**, so $c_{\alpha\gamma\delta}c_{\beta\gamma\delta}=0$ for $\alpha\ne\beta$ and $D^\#_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}d_\gamma d_\delta$ is supported on $\alpha=\beta$. Verified at $0.0\mathrm{e}{+}00$ (exact zeros, not roundoff) at $n=5,6,7,8,10,12$ ([r106_claim4a.py](../scripts/reviewers/r106/r106_claim4a.py)). Hence $\langle Q(D),\Delta\rangle=0$ and

$$\theta(W)=\Theta(D)+3T(D,\Delta,\Delta)+\Theta(\Delta),$$

$T$ the symmetric trilinear form with $T(X,X,X)=\Theta(X)$ (full symmetry and $\nabla\Theta=3Q$ verified to $10^{-15}$). **There is no $\lVert\Delta\rVert^1$ term, so square-root degradation was never on the table**, that half of Claim 4 is right, and it is right for a reason the claim does not give.

Write $\varepsilon=2-t$, so $\lVert\Delta\rVert^2=\varepsilon/2$, and let $\lambda=\max\{T(\hat D,\Delta,\Delta):\Delta\in\mathcal W_n^{\mathrm{off}},\lVert\Delta\rVert=1\}$ at the diagonal maximiser $\hat D=W^*$. Then

$$\theta\ \le\ \theta_0(n)(1-\tfrac\varepsilon2)^{3/2}+3\lambda(1-\tfrac\varepsilon2)^{1/2}\tfrac\varepsilon2+M(n)(\tfrac\varepsilon2)^{3/2},\qquad \text{slope}=\tfrac32\lambda-\tfrac34\theta_0(n).$$

**And $\lambda=\theta_0(n)/2$ exactly**, at $n=6,8,10,12$ ([r106_claim4b.py](../scripts/reviewers/r106/r106_claim4b.py)), so the slope is $\mathbf{0.00000000}$, to machine precision, at every $n$ tested. In the fixed-frame variable $t$ the degradation has **no linear term at all**.

### Why the coefficient is zero, and what the right variable is

The $\theta_0/2$-eigenspace is **the $O(n)$-orbit of $W^*$**, and nothing else, for $n\ge8$: dimension $pq$ exactly ($16$, $25$, $49$, $64$ at $n=8,10,14,16$), principal angles against the orbit all $1.000000$, orbit Rayleigh quotients $=\theta_0/2$ to $10^{-15}$. Rotating $W^*$ keeps $\theta=\theta_0$ while dropping $t$ in the *fixed* frame, which is precisely why the fixed-frame slope is zero, and why $\kappa^2=\max_F\lVert K(F)\rVert_F^2$ is the only sensible variable. Requiring the coordinate frame to be $\kappa$-maximising is, to first order, exactly $\Delta\perp\text{orbit}$.

**At $n=6$ the top eigenspace is $18=2pq$, not $9$**, my build independently reproduces the record's Morse–Bott exception at $S^3\times S^3$, where $\mu(3,3)=\tfrac12$ collides with the orbit family. $n=6$ is outside the conjecture's range and outside this analysis.

### The true slope is NEGATIVE, in closed form, and it is already in the record

On $\mathcal W_n^{\mathrm{off}}\cap\text{orbit}^\perp$ ([r106_claim4c.py](../scripts/reviewers/r106/r106_claim4c.py), [r106_claim4d.py](../scripts/reviewers/r106/r106_claim4d.py) dense, [r106_claim4e.py](../scripts/reviewers/r106/r106_claim4e.py) deflated):

| $n$ | $\lambda'/\theta_0$ | $\lambda'$ | $C'=\tfrac32\lambda'-\tfrac34\theta_0$ | $-\tfrac32\theta_0/(n-2)$ |
|---|---|---|---|---|
| $8$ | $1/3$ | $0.38188131$ | $-0.28641098$ | $-0.28641098$ |
| $10$ | $3/8$ | $0.45000000$ | $-0.22500000$ | $-0.22500000$ |
| $12$ | $2/5$ | $0.49441323$ | $-0.18540496$ | $-0.18540496$ |
| $14$ | $5/12$ | $0.52570005$ | $-0.15771002$ | $-0.15771002$ |
| $16$ | $3/7$ | $0.54894379$ | $-0.13723595$ | $-0.13723595$ |

Eigen-residuals $\le1.7\times10^{-15}$; $n=10$ from a full dense diagonalisation, the rest orbit-deflated. At $n=6$, $\lambda'=\theta_0/2$ still and $C'=0$, the exception again. So $\lambda'=\theta_0(n)\dfrac{n-4}{2(n-2)}$ and

$$\boxed{\ \theta\ \le\ \theta_0(n)-\frac{3\,\theta_0(n)}{2(n-2)}\bigl(2-\kappa^2(W)\bigr)+o\bigl(2-\kappa^2\bigr)\ }$$

**And $\lambda'$ is not new.** With $p=q=n/2$, $\lambda'/\theta_0=\frac{n-4}{2(n-2)}=\frac{p-2}{2(p-1)}$ is the family $\lambda_m=(m-2)/(2(m-1))$ of the $L_e$ spectrum at $S^p\times S^q$ in [fence-posts.md](../findings/fence-posts.md), the record's "largest competitors $\tfrac5{12},\tfrac25,\tfrac38$" are $n=14,12,10$. That closed form was derived twice and audited twice (Reviewers 30–33). **So the whole stability statement is the record's own Hessian closed form plus a one-line orthogonality**, and the correct version has the opposite sign to the one claimed.

Direct confirmation, not through the expansion ([r106_claim4f.py](../scripts/reviewers/r106/r106_claim4f.py)): at $n=8$, moving along the top orbit-perpendicular direction,

| $2-t$ | $\theta$ | $\theta_0+C'\varepsilon$ | $2-\kappa^2$ |
|---|---|---|---|
| $0$ | $1.14564392$ | $1.14564392$ | $0$ |
| $0.004$ | $1.14451154$ | $1.14449828$ | $0.003993$ |
| $0.020$ | $1.14005592$ | $1.13991570$ | $0.019963$ |
| $0.100$ | $1.11836415$ | $1.11700283$ | $0.099776$ |

$\theta$ **falls**, tracking the prediction to $10^{-5}$, while the relaxation at the same $\varepsilon$ *rises* with slope $+1.30$. The two slopes have opposite signs. And $2-\kappa^2=2-t$ to three digits along this direction, so the change of variable costs nothing.

### The four questions the brief asks

- **Is the slope real or an artefact?** Real, reproduced to three digits, and a property of $R$ alone. As a statement about $\theta$ it is not merely unsupported, it has the wrong sign.
- **Does it survive at $n=14,16$?** For $R$, yes, with the constant drifting ($1.30\to0.90$ over $n=8\to16$). For $\theta$, the correct coefficient survives in closed form at $n=14,16$: $-0.157710$, $-0.137236$.
- **Is the $O(\cdot)$ uniform in $n$, and what is the constant?** The linear coefficient is $\tfrac32\theta_0(n)/(n-2)\to0$ like $3\sqrt2/(2n)$, so uniform and vanishing. The **remainder is not uniform**: the $\varepsilon^{3/2}$ term carries $M(n)=\max_{\lVert W\rVert=1}\lvert\theta\rvert$ by homogeneity alone, and $M(n)$ is bounded only by Xu's $\sqrt{(n^2-1)(n-2)/n}\sim n^{3/2}$ unless Conjecture A is granted. The linear term dominates only for $\varepsilon<8C'^2/M(n)^2$, so the window shrinks like $n^{-2}$ granting the conjecture and like $n^{-5}$ without it. The statement is a *shrinking* neighbourhood of the diagonal locus, not a band of fixed width.
- **Is it stronger than what is known, or does it follow from the record?** It follows from the record. Ingredients: the orthogonal splitting (Reviewer 103's $t/2+\lVert M-\mathop{\mathrm{diag}}M\rVert^2=1$, which I re-verify to $2\times10^{-16}$), $Q(\text{diagonal})$ diagonal (one line), and the $L_e$ closed form (Lemmas of Reviewers 30–33). Nothing else is used. As *stated* ($\theta\le\theta_0+O(2-\kappa^2)$), it is true, weaker than the truth, and weaker than the point result it claims to strengthen anywhere the linear term is positive.

### It is conditional, and at $n=12,14$ on a result the literature does not have

Every version needs $\max\{\theta:W\ \text{coordinate-diagonal},\lVert W\rVert=1\}=\theta_0(n)$, which is the granted diagonal case. [Jäger's theorem](../references/jaeger-2016-diagonal-case/README.md) covers even $n\ge16$; at $n=12,14$ the input is this project's own diagonal result, and for odd $n$ there is none. So the "one positive output of the round" is a **corollary of the diagonal case** at exactly the dimensions where Conjecture A first bites, and it is free-standing nowhere. There is a second, softer conditionality nobody has flagged: the upper-bound direction needs $\max_{\hat D}\Theta(\hat D)$ to be attained on a single $O(n)$-orbit with a gap, i.e. the Morse–Bott nondegeneracy, which the record proves for $p,q\ge3$ **except at $S^3\times S^3$**.

## Does my build reproduce Claims 3 and 4 independently?

The brief asks for this explicitly, and the answer differs between the two.

- **Claim 3: yes for the argument, no for the conclusion.** The three-line implication needs no computation and I checked it as logic; it holds. I separately confirm by my own relaxation build that the Schur–Horn instance really is strictly loose below $t=2$, so the *instance* is closed. The generic reading, the word "vacuous", and the extension to "any successor built from the vertex matrix" I refute above, on three independent grounds.
- **Claim 4: yes for the arithmetic, no for the statement.** Every quoted figure reproduces on an independent implementation, to three digits. The inference from those figures to $\theta\le\theta_0+O(2-\kappa^2)$ is where it fails: the figures belong to $R$, and the true coefficient is zero in $t$ and negative in $\kappa^2$.

## What else I attacked

- **Sample adequacy.** No claim here rests on a sample. Claim 1 is a proof, Claim 2 an optimisation over an explicitly parametrised $\binom n2-n$-dimensional linear space, Claim 3 logic, Claim 4 a curve plus exact linear algebra. The spanning check is recorded above and is load-bearing for nothing.
- **Claims true but inert.** Claim 3 is the inert one, the implication is valid, and the only thing it establishes ($R\ge\theta_0$) is compatible with the conjecture being provable in exactly that shape. Post F24 should be rewritten as *"a bound factoring through $\lVert K\rVert_F^2$ alone and monotone in it cannot beat $\theta_0$; whether it reaches $\theta_0$ is instance-specific and Schur–Horn does not"*, which is a much narrower fence than the one on the page.
- **The internal contradiction.** Claims 3 and 4 cannot both be read as their authors read them: Claim 4's bound is of Claim 3's fenced shape. [plan.md](../plan.md) item (a)'s carve-out is wrong on its face.

## Corrections owed to the record

1. **[plan.md](../plan.md) item (c)**, "the derived $\sqrt{t/(n(n-1)(n-2))}$ is not attained" is **false at every even $n$**. The item is closed: the sharp constant is the derived one, witnessed by the matching $K$. The open part is odd $n$, where the conjectured constant is $\sqrt{t/(n(n-1)(n-2)-\tfrac32(n-1)^2)}$.
2. **Claim 2's sphere-product column** measures $\min\lvert K_{ab}\rvert$, not $\lvert\min K_{ab}\rvert$. Correct values $0.210819$, $0.163663$, $0.133333$.
3. **Claim 2's witnesses** are $34$–$174\%$ above the minimum and should be replaced by the matching $K$.
4. **[Post F24](../findings/fence-posts.md)**, replace "so the bound is useless except at $t=2$" with "so the bound cannot be better than $\theta_0$", drop "or any other quantity that degenerates as $W$ leaves the diagonal locus", and delete the claim that monotonicity is automatic from linearity of the diagonal class. Add that $R^\star(t)=\sup\{\theta:\kappa^2=t\}$ is itself non-monotone at $t=2$.
5. **Post F24's "positive residue"** should be replaced outright. The degradation near $t=2$ is not $+1.05$–$1.23$ linear; the linear coefficient of $\theta$ is $-\tfrac32\theta_0(n)/(n-2)$, the quoted slopes belong to $R$, and the constant comes from the already-audited $L_e$ closed form.
6. **[plan.md](../plan.md) item (a)**, the stability statement is of post F24's fenced shape, and it is a corollary of the granted diagonal case, conditional at $n=12,14$ on this project's own result rather than on Jäger.


*Joint section with Reviewer 105, see [REVIEW_r105.md](REVIEW_r105.md).*
