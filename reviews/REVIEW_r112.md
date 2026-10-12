# Reviewer 112, the $Q$ decomposition, the cap refinement, the $S$-jump scoping, and the separation shortcut

Adversarial audit, cold brief. Own implementation throughout: [scripts/reviewers/r112/](../scripts/reviewers/r112/), [r112_core.py](../scripts/reviewers/r112/r112_core.py) builds $\mathcal W_n$ from the Riemann symmetries, first Bianchi and trace-freeness by SVD nullspace; $W^\#$ from the Lie-algebra square in the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$ with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$; $S$ from $\Pi_{\mathfrak m}[\mathfrak m,\mathfrak m]$; nothing imported from the project's scripts.

**Gatekeepers passed before any claim was touched.** $\dim\mathcal W_n=10,35,84,300$ at $n=4,5,6,8$; $\theta(S^{n/2}\times S^{n/2})=\theta_0(n)$ to $2\times10^{-15}$ at $n=6,8,10$; $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ at $n=4$ with criticality residual $6\times10^{-16}$; padded to $n=8$, critical at $3.7\times10^{-15}$ with $S_{\mathfrak{mmm}}=0$ and $S_{\mathfrak{hhm}}=16$, reproducing the record's "$S=0$ and ungraded" witness from scratch. The convention that makes the row marginal $\rho_\alpha=2(n-2)$ is $\phi_{ij}$ orthonormal under $\tfrac12\operatorname{tr}$, confirmed to $3\times10^{-14}$.

| Claim | Verdict |
| --- | --- |
| 1, the $Q$ decomposition and its two constraints | **CONFIRMED**, and stronger than stated |
| 2, the cap refinement fails; the uniform cap is saturated | **PLAUSIBLE** on its load-bearing half; the general statement **REFUTED** |
| 3, the $S$-jump is mis-scoped | **CONFIRMED**, and the new question has a definite answer: **no** |
| 4, the separation shortcut | **REFUTED** as a shortcut; its topological half is correct but its premise is equivalent to its conclusion |

---

## Claim 1, CONFIRMED

[r112_claim1.py](../scripts/reviewers/r112/r112_claim1.py). Every identity reproduces at $n=5,6,7,8$ on random Weyl tensors, balanced sphere products and padded $W_{\mathbb{CP}^2}$:

| quantity | worst residual over 12 points |
| --- | --- |
| $\rho_\alpha-2(n-2)$ | $2.7\times10^{-14}$ |
| $g_\gamma-\big(2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma\big)$, with $g_\gamma$ from $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ | $8.9\times10^{-16}$ |
| $\sum_\alpha\lambda_\alpha R_{\gamma\alpha}+2\lambda_\gamma$ | $2.9\times10^{-15}$ |
| $\sum_\gamma Q_\gamma+2\lVert W\rVert^2$ | $5.3\times10^{-15}$ |
| $\sum_\gamma\lambda_\gamma Q_\gamma-2\langle W^\#,W\rangle$ | $3.1\times10^{-15}$ |
| $\sum_\gamma g_\gamma-4(n-1)$ | $4.3\times10^{-14}$ |
| $\sum_\gamma\lambda_\gamma g_\gamma+4\theta$ | $9.8\times10^{-15}$ |

**Two corrections that strengthen the claim.**

*The identities are not critical-point facts.* The record states them "at $n=5,\dots,8$" in a context of critical points; they hold to the same precision at **random** Weyl tensors. They are identities on all of $\mathcal W_n$, so criticality contributes nothing to them, a sharper version of "definitional".

*The two constraints are one fact and one definition, not two facts.* Both descend from the single per-row identity $\sum_\alpha\lambda_\alpha R_{\gamma\alpha}=-2\lambda_\gamma$: summing it against $\lambda_\gamma$ gives $\sum_\gamma Q_\gamma=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta R_{\alpha\beta}=-2\lVert W\rVert^2$, and $\sum_\gamma\lambda_\gamma Q_\gamma=\sum\lambda_\alpha\lambda_\beta\lambda_\gamma c_{\gamma\alpha\beta}^2$ is $2\langle W^\#,W\rangle$ *by the definition of $W^\#$* evaluated in the eigenbasis. The contractions then follow: $\sum_\gamma g_\gamma=2\sum_\alpha\lambda_\alpha^2\rho_\alpha+4\lVert W\rVert^2=4(n-1)$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4\operatorname{tr}(M^3)-4\langle W^\#,W\rangle=-4\theta$, both by hand.

*The per-row identity is the only Weyl-specific input, and it is genuinely Weyl-specific.* Recast, it says $\operatorname{tr}\big(-\mathrm{ad}(X)^2M\big)=-2\langle MX,X\rangle$ for unit $X\in\mathfrak{so}(n)$. Measured worst residual: $1.2\times10^{-15}$ on $\mathcal W_6$; $1.07$ on a generic element of $\mathrm{Sym}^2(\Lambda^2\mathbb R^6)$; $3.17$ on a pure $g\owedge h$ Ricci part; $1.89$ on Weyl $+$ Ricci; $2.58$ on the constant-curvature operator. So the decomposition rests on exactly one non-trivial ingredient, already in the record.

---

## Claim 2, the load-bearing half CONFIRMED, the general statement REFUTED

[r112_claim2.py](../scripts/reviewers/r112/r112_claim2.py), [r112_claim2b.py](../scripts/reviewers/r112/r112_claim2b.py).

**Saturation: CONFIRMED, and strengthened.** At $S^{n/2}\times S^{n/2}$, $n=6,8,10$, $\max_\gamma g_\gamma$ equals the uniform cap $2(n-2)(\lambda_{\max}-\lambda_{\min})^2$ to $10^{-15}$, $2.2222$, $1.7500$, $1.4400$. I also solved the **sharp** two-moment problem, $\max\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2A_{\alpha\beta}$ over $A\ge0$ symmetric with $\sum A=2(n-2)$ and $\sum_{\alpha\beta}\lambda_\alpha A_{\alpha\beta}=-2\lambda_\gamma$. Its value is also exactly the uniform cap at those three points. So the conclusion "no sharpening gains anything at the maximiser" now covers **every** bound derivable from $T\ge0$ and the two marginal moments, not only the one attempted.

**"Weaker, never stronger": REFUTED.** The recorded refinement's ratio to the uniform cap:

| point | recorded refinement / uniform | sharp two-moment LP / uniform |
| --- | --- | --- |
| $S^{n/2}\times S^{n/2}$, $n=6,8,10$ | $1.0000$ | $1.0000$ |
| random Weyl, $n=6,8$ (6 points) | $1.0018$–$1.0117$ | $0.979$–$0.998$ |
| $W_{\mathbb{CP}^2}$ padded, $n=6,8$ | $0.9444$, $0.9259$ | $0.8333$, $0.7778$ |
| $S^3\times S^5$, $S^4\times S^6$, $S^5\times S^7$ | $0.8571$, $0.9167$, $0.9455$ | $0.6667$, $0.7500$, $0.8000$ |

The $1.0000$ and $1.001$–$1.011$ figures reproduce exactly. The generalisation does not: at five structured points the recorded refinement is **strictly stronger** than the uniform cap, by $5$–$14\%$. Every cap in the table was checked valid, $g_\gamma\le\text{cap}_\gamma$ for all $\gamma$.

**The cancellation is an artefact of decoupling, not of $T\ge0$.** The recorded scheme bounds $\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}$ and $Q_\gamma$ **separately** and then adds; the crude $Q_\gamma\ge2(n-2)\lambda_{\min}\lambda_{\max}$ gives back what the moment step won. Bounding $g_\gamma=\sum(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ **jointly** against the same two moments does not cancel: $0.667$–$0.833$ at structured points, $0.979$–$0.998$ at random ones, $1.0000$ at the maximiser. So the record's diagnosis (*the term to attack is $Q_\gamma$*), points the wrong way; the term to attack was the split.

**The "available and unused" constraint is neither.** $\sum_\alpha u_{\gamma\alpha}=\sum_{\alpha\beta}\lambda_\beta T_{\gamma\alpha\beta}=\sum_\beta\lambda_\beta R_{\gamma\beta}$ identically, verified at $5.6\times10^{-16}$. In any programme that fixes the row $R_{\gamma\cdot}$ (which is what the transportation formulation does), the value of $\sum_\alpha u_{\gamma\alpha}$ is **determined by the constraints already imposed**. It is the per-row identity re-summed, and adding it to the LP cannot move the optimum by a single digit. Recorded as available leverage in [bounds.md](../findings/bounds.md); it is not leverage at all.

**Net.** The route-status conclusion the plan draws (the per-direction cap is exhausted), survives, and survives more strongly than argued, because saturation at the maximiser is now known against the sharp two-moment bound. What must be withdrawn is "weaker, never stronger" and the reading that $T\ge0$ is what causes the cancellation.

---

## Claim 3, CONFIRMED, and the new question answered: **no**

[r112_claim3.py](../scripts/reviewers/r112/r112_claim3.py), [r112_claim3b.py](../scripts/reviewers/r112/r112_claim3b.py).

**The scoping correction is right.** [review_r52_m5.py](../scripts/reviewers/r52/review_r52_m5.py) lines 44–52 form `Wp = W + eps*d`, renormalise, and call `slack_structural`, no criticality solve, no projection. The perturbed points are demonstrably off $\mathrm{Crit}(P)$: I measure median criticality residual $1.3\times10^{-6}$ at $\varepsilon=10^{-6}$ and $1.3\times10^{-3}$ at $\varepsilon=10^{-3}$, i.e. $O(\varepsilon)$. The recorded jump is a statement about the unit sphere.

**The recorded number is also not a number.** It is the *minimum of a random sample*. My own 200 draws at $n=8$, $\varepsilon=10^{-6}$ give $S_{\mathfrak{mmm}}\in[8.90,\,23.17]$, median $14.28$. The record quotes minimum $16.5$ in [nondegeneracy.md](../findings/nondegeneracy.md) and $[11.3,22.2]$ five paragraphs later for the same experiment. Three incompatible minima from the same protocol, because a sample minimum is not an invariant.

**The mechanism is the padding, not the geometry.** Padded $W_{\mathbb{CP}^2}$ at $n=8$ has $25$ zero eigenvalues on the $28$-dimensional $\Lambda^2$ and $\dim\mathfrak m=2$. A generic perturbation pushes about half the zeros negative: measured median $\dim\mathfrak m=14$ at both $\varepsilon=10^{-6}$ and $10^{-3}$ (at $n=6$: $2\to8$). $S_{\mathfrak{mmm}}$ jumps because $\mathfrak m$ jumps, and it lands near the base point's $S_{\mathfrak{hhm}}=16$ because the $[\mathfrak h,\mathfrak h]\to\mathfrak m$ leak is reclassified as an $[\mathfrak m,\mathfrak m]\to\mathfrak m$ leak. Nothing about $\mathrm{Crit}(P)$ is involved.

**The new question: does $S$ jump on $\mathrm{Crit}(P)$ near $W_{\mathbb{CP}^2}$? No, $S\equiv0$ on a whole $\mathrm{Crit}(P)$-neighbourhood.**

*Analytically.* I measured Morse–Bott nondegeneracy from my own build of the second-order operator $L_W(v)=\Pi_{\mathcal W}\big[\tfrac12(Wv+vW)+\mathrm{sh}(W,v)\big]$:

| point | $n$ | $\dim E(\theta/2)$ | orbit | excess |
| --- | --- | --- | --- | --- |
| $W_{\mathbb{CP}^2}$ padded | 6 | 10 | 10 | 0 |
| $W_{\mathbb{CP}^2}$ padded | 8 | 18 | 18 | 0 |
| $S^4\times S^4$ | 8 | 16 | 16 | 0 |
| $S^5\times S^5$ | 10 | 25 | 25 | 0 |
| $S^3\times S^3$ | 6 | 18 | 9 | **9** |

$\ker\mathrm{Hess}=T(\text{orbit})$ at padded $W_{\mathbb{CP}^2}$, matching $4n-14$. By the implicit function theorem on a slice transverse to the orbit, $\mathrm{Crit}(P)$ near the point **is** the orbit; $S$ is $O(n)$-invariant, hence constant on it, hence $0$. The jump and the criticality constraint are mutually exclusive here.

*Numerically, by the protocol the correction asks for.* Perturb by $\varepsilon\in\{10^{-3},10^{-2},5\times10^{-2},10^{-1}\}$ and project back by gauge-fixed Gauss–Newton (step confined to the slice orthogonal to the orbit tangent and the radial direction). All $12/12$ starts converge at every $\varepsilon$ and every $n\in\{6,8\}$, residual $<2\times10^{-15}$, and land at

- $S_{\mathfrak{mmm}}\le1.8\times10^{-36}$ (machine zero),
- $S_{\mathfrak{hhm}}=8.0000$ ($n=6$) and $16.0000$ ($n=8$), the base value, unchanged,
- $\theta=1.224744871$ to nine digits,
- gauge-fixed orbit distance $\min_g\lVert\Lambda^2(g)\,W'\,\Lambda^2(g)^{\mathsf T}-W_0\rVert$ between $1.9\times10^{-15}$ and $7.4\times10^{-12}$ over nine endpoints at $n=6$, against raw $\lVert W'-W_0\rVert$ up to $0.048$.

So the endpoints are *on the orbit*, and the raw distance is orbit motion, the record's own standing rule, and it fires here.

**Consequence for the argument the correction was serving.** $W_{\mathbb{CP}^2}$ *is* isolated in $\mathrm{Crit}(P)$, by nondegeneracy rather than by $S$. What is unavailable is the opposite of what the record feared: $S$ cannot separate it from its neighbours, because it has no critical neighbours to separate it from.

---

## Claim 4, REFUTED as a shortcut

[r112_claim4.py](../scripts/reviewers/r112/r112_claim4.py), [r112_claim4b.py](../scripts/reviewers/r112/r112_claim4b.py), [r112_claim4c.py](../scripts/reviewers/r112/r112_claim4c.py).

### The topological half is correct, all three sub-questions come out favourably

$O(n)$ is compact and the action on the unit sphere of $\mathcal W_n$ is continuous, so **every orbit is compact**, hence closed in the Hausdorff sphere. A finite union of compacta is compact, hence closed in $\mathrm{Crit}(P)$ with the subspace topology. And **"finite mod $O(n)$ yet not closed" is impossible**: gradedness is an $O(n)$-invariant condition, so the graded set is a union of full orbits, and finitely many of them are a finite union of compacta. The brief's last worry is unfounded.

### But the shortcut is circular

Grant the hypothesis the shortcut itself invokes, every graded critical point nondegenerate, so each graded orbit is *isolated* in $\mathrm{Crit}(P)$ (a $\mathrm{Crit}(P)$-neighbourhood meeting $\mathrm{Crit}(P)$ only in that orbit; verified above at $W_{\mathbb{CP}^2}$). Write $\mathcal G$ for the graded critical set.

- $\mathrm{Crit}(P)$ is compact and $O(n)$ is compact, so $\mathrm{Crit}(P)/O(n)$ is **compact Hausdorff**.
- Isolation makes $\mathcal G/O(n)$ a **discrete** subspace of it.
- A discrete subspace of a compact Hausdorff space is **finite if and only if it is closed**.

So under exactly the hypothesis the route already assumes, *finiteness of the graded set mod $O(n)$ and closedness of the graded set are equivalent*. The implication "finite union of orbits $\Rightarrow$ closed" is true, and it is a restatement of the goal, not a shortcut to it. **The whole content of the proposal is the finiteness, and finiteness is not weaker than what it was introduced to avoid.**

### The finiteness is not on record, and the record says so itself

The brief asks whether the enumeration's completeness is about critical points or about symmetric pairs. It is about **neither**: it is about the critical points of $P$ restricted to a projector ansatz attached to each symmetric pair. [graded-half.md](../findings/graded-half.md) states the ansatz explicitly, $W=a_1\Pi_{\mathfrak h_1}+\dots+a_r\Pi_{\mathfrak h_r}+g\,\Pi_{\mathfrak m}$, scalar on each isotropy factor, and, in the same section, records that the method's *claim to exhaustiveness* already failed once: *"What fails is the method's claim to exhaustiveness. It cannot have ruled out non-sphere-product graded critical points with unequal values across the factors of $\mathfrak k$, because it never looked there."* Citing that enumeration as carrying finiteness contradicts the file it is drawn from.

Two reductions separate the enumeration from "every graded critical point":

1. **The grading is symmetric-pair data, and this is free.** A graded $W$ makes $\mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m$ a $\mathbb Z_2$-grading, i.e. $\sigma=+1|_{\mathfrak h}\oplus-1|_{\mathfrak m}$ is an involutive automorphism of $\mathfrak{so}(n)$, and involutions fall into **finitely many** conjugacy classes, $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ and $\mathfrak u(n/2)$, with $\mathrm{Aut}/\mathrm{Inn}$ finite even at $n=8$. This step is genuinely available and the record never states it; it is the correct source of the "Cartan" input, and it is finiteness of *gradings*, not of *points*.
2. **The tensor within a grading is not determined by the pair, and this is the gap.** "Scalar on each isotropy factor" is Petersen–Stanfield Proposition 2.2, a theorem about the curvature operator **of a symmetric space**. A graded critical point of $P$ is only required to have $\mathfrak h$ as its non-negative eigenspace; its eigenvalues inside $\mathfrak h$ and inside $\mathfrak m$ are unconstrained by gradedness. Nothing in the record promotes Proposition 2.2 from symmetric-space curvature operators to critical points of $P$.

**The scale of step 2, measured.** For each involution I built the $\sigma$-fixed subspace $\mathcal W_n^\sigma$, by Palais's principle of symmetric criticality, a critical point of $P|_{\mathcal W_n^\sigma}$ is a critical point of $P$, which I confirmed by evaluating the full residual at every solution. At $n=6$ these subspaces have dimension $44$–$49$ out of $\dim\mathcal W_6=84$, against normalisers of dimension $\le6$. Multistart Newton inside them, from starts sampled in the graded cone ($W|_{\mathfrak h}\succeq0$, $W|_{\mathfrak m}\prec0$):

| grading | $\dim\mathcal W_6^\sigma$ | converged | **distinct critical points** |
| --- | --- | --- | --- |
| $\mathfrak{so}(1)\oplus\mathfrak{so}(5)$ | 49 | 259/400 | 8 |
| $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ | 44 | 323/400 | 44 |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ | 45 | 306/400 | **61** |
| $\mathfrak u(3)$ | 48 | 335/400 | 20 |

Criticality inside a single grading is not "one point per symmetric pair", at $n=6$ it is dozens of orbits, and which of them are *graded* is decided by a strict sign condition the enumeration never poses. (None of the $133$ found here is graded; that is a basin fact, not evidence of absence, the control below shows the solver recovers the graded points when it starts near them, and [graded-half.md](../findings/graded-half.md) already records the same phenomenon, "113 converged critical points, all ungraded".)

**Control, so the null above is not read as a result.** From starts $10^{-4}$ from $S^3\times S^3$ inside $\mathcal W_6^{\mathfrak{so}(3)+\mathfrak{so}(3)}$, $20/20$ converge and all $20$ are fully graded at $\theta=1.054092553$; at $10^{-2}$, $17/20$. Independently, the two-eigenvalue projector ansatz on the $\mathfrak u(3)$ grading converges at residual $2.5\times10^{-15}$ to $\theta=1.054092553=\theta_0(6)$ with $S_{\mathfrak{mmm}}=3\times10^{-30}$, $S_{\mathfrak{hhm}}=4\times10^{-29}$, my own confirmation of the record's $\mathbb{CP}^3$/$S^3\times S^3$ tie at $n=6$.

### The other premise is overstated too

"Openness is proved (nondegeneracy across the classification)" is not what the record holds. I measure $S^3\times S^3$ at $n=6$ **degenerate**, $\dim E(\theta/2)=18$ against an orbit of $9$, matching the record, which states the correct scope as *"every two-block sphere product except $S^3\times S^3$"* and then says plainly that *"the clean 'nondegenerate ⇒ open' mechanism is unavailable"*, openness at the degenerate points resting instead on a third-order obstruction checked numerically at a handful of them. So both halves of the clopen argument carry the same completeness debt, and the shortcut does not reduce it, it duplicates it.

### And closedness is not the load-bearing step

The compactness step the separation exists to feed needs $S\ge c>0$ on the ungraded critical set $\mathcal U=\mathrm{Crit}(P)\setminus\mathcal G$. That needs $\mathcal U$ **closed**, i.e. $\mathcal G$ **open**, which nondegeneracy gives directly. Closedness of $\mathcal G$ is equivalent to openness of $\mathcal U$, and openness of $\mathcal U$ appears nowhere in the chain. The extra content of "union of connected components" over "open" is nil for the constant, and $P$ is constant on connected components of $\mathrm{Crit}(P)$ regardless. *A shortcut to a step that is not on the critical path is not a shortcut.*

### The concrete failure mode, for whoever attacks finiteness next

Within a fixed grading, gradedness is an **open** condition: it asks $W|_{\mathfrak m}\prec0$ strictly. Its boundary is therefore eigenvalue crossings through zero, where $\dim\mathfrak m$ and $S$ both jump, the exact discontinuity Claim 3 is about. Padded $W_{\mathbb{CP}^2}$ sits on such a boundary with $25$ zero eigenvalues and $\dim\mathfrak m=2$, while $S^3\times S^3$ and $S^4\times S^4$ sit well inside the cone ($\min|\lambda|=0.2108$, $0.1637$, no zero eigenvalues). **A sequence of graded critical points can only escape gradedness in the limit by an eigenvalue reaching zero**, so a proof of closedness reduces to a uniform lower bound on $\min|\lambda|$ over the graded critical set, a statement of the right shape, in the same currency as the spectral-gap law already in [nondegeneracy.md](../findings/nondegeneracy.md) ($\min|\lambda-\tfrac12|=\tfrac1{2(n_0-1)}$ for a seed at $n_0$), and per-dimension rather than uniform in $n$. That is the one concrete route to the premise this audit found.

### Verdict

**REFUTED as a shortcut, and yes, "route sketch" is too strong for it.** A route sketch names a path whose steps are unproved; this names a step whose hypothesis is *logically equivalent* to its conclusion under an assumption the route already makes. The correct standing of the three components: the orbit topology is a **proved** triviality; the finiteness premise is **unproved and not carried by the record**, whose own graded-half file records the enumeration failing exhaustiveness; and the step it would deliver is **not on the critical path** for the compactness constant. This is the seventh route-affecting inference of the session drawn from correct computations, and it fails the same way as the others: the computation (the Cartan enumeration) is right, and what it is a statement *about* is not what the inference needs.

---

## Corrections owed to the record

1. [bounds.md](../findings/bounds.md), *"the result is $1.0000\times$ the uniform cap at every balanced sphere product and $1.001$–$1.011\times$ at random points, weaker, never stronger"*: the two figures are right, the generalisation is **false**. Strictly stronger at padded $W_{\mathbb{CP}^2}$ ($0.944$, $0.926$) and at $S^3\times S^5$, $S^4\times S^6$, $S^5\times S^7$ ($0.857$, $0.917$, $0.945$).
2. [bounds.md](../findings/bounds.md), *"One constraint on it is already available and unused: $\sum_\alpha u_{\gamma\alpha}=-2\lambda_\gamma$"*: it is $\sum_\beta\lambda_\beta R_{\gamma\beta}$ identically, so it is the constraint already imposed, re-summed. Not available leverage.
3. [bounds.md](../findings/bounds.md), the cancellation should be attributed to **splitting $g_\gamma$ into two separately bounded terms**, not to $T\ge0$. The joint two-moment cap gains $17$–$33\%$ at structured points and still saturates at the maximiser.
4. [nondegeneracy.md](../findings/nondegeneracy.md), the $S$-jump minimum: $16.5$ in one paragraph, $[11.3,22.2]$ in another, $[8.90,23.17]$ here. It is a random-sample minimum and should not be quoted as a value at all. What is stable and worth recording is the mechanism: $\dim\mathfrak m$ jumps $2\to14$ at $n=8$ because padding contributes $25$ zero eigenvalues.
5. [nondegeneracy.md](../findings/nondegeneracy.md), add the settled answer: **$S$ does not jump on $\mathrm{Crit}(P)$ near padded $W_{\mathbb{CP}^2}$; it is identically zero there**, because the point is Morse–Bott nondegenerate ($18=18$ at $n=8$, $10=10$ at $n=6$) so $\mathrm{Crit}(P)$ is locally its orbit, on which the $O(n)$-invariant $S$ is constant. Confirmed by gauge-fixed projection: orbit distance $\le7.4\times10^{-12}$ from every one of $12$ starts at $\varepsilon$ up to $0.1$.
6. [nondegeneracy.md](../findings/nondegeneracy.md) / [plan.md](../plan.md), the shortcut's premise and conclusion are equivalent given its own openness hypothesis; and its finiteness input should be replaced by the fact that actually holds, namely that $\mathfrak{so}(n)$ has finitely many conjugacy classes of involutions, which bounds the number of **gradings** and says nothing about the number of critical points inside one.


*Joint section with Reviewer 111, see [REVIEW_r111.md](REVIEW_r111.md).*
