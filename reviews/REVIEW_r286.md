# REVIEW r286, Gate 2, route F's gradient identity and route D's closure

Reviewer 286. Commits under review: `10be9f8` (primary), `384e334`, `779997d`, `c3ac30d`.
Primary file: [plan.md](../plan.md) route F. Supporting: [findings/diagonality.md](../findings/diagonality.md), [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/problem.md](../findings/problem.md), [references/beitz-2018-bianchi-convexity/notes.md](../references/beitz-2018-bianchi-convexity/notes.md), [reviews/REVIEW_r283.md](REVIEW_r283.md), [reviews/REVIEW_r284.md](REVIEW_r284.md).
Scripts: [scripts/reviewers/r286/](../scripts/reviewers/r286/). Reviewer 285 runs the identical brief concurrently and independently; nothing of r285's was read.

Everything numeric below is built from [review_r27_core.py](../scripts/review_r27_core.py)'s structure constants, `sharp_bilinear`, `Q` and `weyl_basis`. Padded $W_{\mathbb{CP}^2}$, the stratum family, the Hessian, the Plücker minimisation and the orbit tangents are my own, built in $\Lambda^2$ from the self-dual forms rather than from any 4-tensor constructor in the tree; [weyl.py](../scripts/weyl.py)'s `Q_general` is called only as the *object of* claim 1(c).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\nabla P=3Q(W)$ | **THE IDENTITY IS TRUE, THE CONFIRMING CHECK IS WORTHLESS, AND THE FAULT IS FOUND AND NAMED.** (a) True on all of $\mathrm{Sym}^2(\mathfrak{so}(n))$, one line from full trilinear symmetry, which holds and is needed in exactly the form used. (b) The check at the critical point has **zero** discriminating power, six deliberately false gradients pass it identically, both sides $\sim10^{-17}$. A test with power ($4$ random non-critical $W$, $8$ directions) gives rel err $\le3\times10^{-10}$ for $3Q(W)$ against $1.33$, $0.49$, $0.51$, $1.00$, $0.08$ for the false ones. (c) The fault is [weyl.py](../scripts/weyl.py)'s `Q_general`: it returns a matrix missing the whole off-diagonal part of $W^\#$, $\lVert Q_{\rm g}-Q\rVert=0.73\lVert Q\rVert$, right $\langle W,Q(W)\rangle$, wrong $\langle Q(W),V\rangle$, reproducing residuals of $2\times10^{-1}$ and $2.5$ |
| 2 | Does the gradient-flow claim follow? | **IT FOLLOWS AND IT BUYS NOTHING.** $\nabla_S P=3(Q(W)-P(W)W)$ and $Q(\mathrm{Weyl}_n)\subseteq\mathrm{Weyl}_n$ (verified to $8\times10^{-16}$ at $n=6,8,10$), so the flow is gradient ascent inside $\mathrm{Weyl}_n$. But attractors are **local** maxima, and the record already owns a second one at the wrong value, padded $W_{\mathbb{CP}^2}$, $\theta=\sqrt{3/2}$. **F's stated falsifier cannot fire**: $S^{n/2}\times S^{n/2}$ is Morse–Bott nondegenerate on file, hence an attractor already |
| 3 | Is route F fenced? | **F's THEOREM IS REFUTED AS WRITTEN, BY A WITNESS: $C=\mathbb R_+W^*$ satisfies every clause of it.** And [problem.md:129](../findings/problem.md) does fence F, [ATTEMPTS.md](../ATTEMPTS.md) item 5 is a prior, specific analysis of this exact route, uncited, exactly as route D was the lifting lemma uncited. Two further errors: the plan's *"neither route produces a bound on $\theta$"* is false of F's own third clause, and [the Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) record that the cone conjecture is **strictly stronger** than Conjecture A |
| 4 | Route D's closure | **BOTH HALVES CONFIRMED INDEPENDENTLY, and the criterion is the right one.** $\max\mathop{\mathrm{spec}}(L_e\vert_{W^\perp})=0.500000000000$ with $\mathbf0$ eigenvalues above at $n=8,12$; the $\tfrac12$-eigenspace is $18$ and $34$, equal to the orbit-tangent rank; $\min\lVert\omega\wedge\omega\rVert=0.5$ on the $2$-dimensional $(-0.408248)$ eigenspace. The Hessian formula $6\theta(L_e-\tfrac12)$ reproduces second differences of $P$ to $3\times10^{-7}$ |
| 5 | The mechanism D left | **(i) TRUE, and analytic; (ii) TRUE for $n\ge12$; (iii) REFUTED TWICE OVER.** The implication $\text{Plücker-obstructed}\Rightarrow\theta\le\sqrt{3/2}$ is a converse error, and it is **false**: obstructed points are dense, so it would force $\theta\le\sqrt{3/2}$ everywhere. Witness at $n=12$: $\theta=1.235844074>\sqrt{3/2}$, Plücker-obstructed at $0.615$, Ricci $3\times10^{-16}$. And even granted it would not close the conjecture, since Plücker is *sufficient, never necessary* |
| 6 | The sweep and the index | **THE INDEX IS NOT COMPLETE, 77 filed reports have no row, including every one of r202–r258.** `c3ac30d` added five rows and left the larger gap untouched; [plan.md](../plan.md) cites *"reviewer 250"* for a live result whose report the index cannot locate. Three of r283's four unapplied items are still live in the tree |

---

## 1, the gradient identity

### (a) The identity is true, and there is a shorter derivation than the plan's

Write $A\circ B=\tfrac12(AB+BA)+A\# B$, so that $Q(W)=W\circ W$, and set $T(A,B,C)=\langle A\circ B,C\rangle$. Then $P(W)=T(W,W,W)$, and **if $T$ is fully symmetric** then $\mathrm dP[V]=3T(W,W,V)=3\langle Q(W),V\rangle$ immediately. That is the whole derivation; the plan's split into $\mathrm d\mathop{\mathrm{tr}}(W^3)$ and $\mathrm d\langle W^\#,W\rangle$ is the same content in two pieces.

**Both halves of $T$ are fully symmetric.** For the product part, $\tfrac12\mathop{\mathrm{tr}}\big((AB+BA)C\big)=\tfrac12(\mathop{\mathrm{tr}}(ABC)+\mathop{\mathrm{tr}}(ACB))$ for symmetric $A,B,C$, which is the sum of the two cyclic classes and so is invariant under every permutation. For $\#$, with $c_{abg}=\langle[\varphi_a,\varphi_b],\varphi_g\rangle$ **totally antisymmetric** (ad-invariance of the inner product) and $\langle A\#B,C\rangle=\tfrac12c_{a\gamma\delta}c_{b\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}C_{ab}$:

- $A\leftrightarrow B$: relabel $\gamma\leftrightarrow\delta$, $\varepsilon\leftrightarrow\zeta$; the two sign flips cancel.
- $B\leftrightarrow C$: relabel $(a,b,\delta,\zeta)\to(\delta,\zeta,a,b)$; then $c_{\delta\gamma a}c_{\zeta\varepsilon b}=(-c_{a\gamma\delta})(-c_{b\varepsilon\zeta})$, and again the signs cancel.

**Is the symmetry needed in the form used?** Yes, and only the third permutation is at issue. $\#$ is symmetric in its two arguments by construction, which alone gives $\mathrm d\langle W^\#,W\rangle[V]=2\langle V\# W,W\rangle+\langle W^\#,V\rangle$; the reduction to $3\langle W^\#,V\rangle$ *is* the statement $T(V,W,W)=T(W,W,V)$. So the plan is right to name it, and it is available.

**Measured** ([c1_gradient.py](../scripts/reviewers/r286/c1_gradient.py)), all six orderings of $T$ on three random elements of $\mathrm{Weyl}_8$ agree to a spread of $7\times10^{-18}$, and on three *generic* symmetric $28\times28$ matrices, which are neither Bianchi nor trace-free, to $1.5\times10^{-13}$. The symmetry is an identity of the structure constants; $\mathrm{Weyl}_n$ plays no part in it.

### (b) The confirming check cannot distinguish the identity from a false one

`10be9f8` checked at the balanced sphere product, where $Q(W^*)=\theta W^*$ (criticality residual $2.2\times10^{-16}$ here). At a critical point the tangential part of $Q$ vanishes **and** $\mathrm dP$ vanishes on the tangent space, so the check compares $0$ with $0$ and every candidate passes. Run for six candidates ([c2_criticalpoint_test.py](../scripts/reviewers/r286/c2_criticalpoint_test.py)), three tangential Weyl directions each:

| candidate for $\nabla P$ | at $W^*$: $\max\lvert\text{pred}\rvert$ | at $W^*$: $\max\lvert\text{pred}-\text{meas}\rvert$ | at random $W$: rel err |
|---|---|---|---|
| $3Q(W)$, **true** | $3.1\times10^{-17}$ | $3.1\times10^{-17}$ | $\mathbf{7.8\times10^{-11}}$ |
| $7Q(W)$ | $4.2\times10^{-17}$ | $4.2\times10^{-17}$ | $1.33$ |
| $3W^2$ | $2.1\times10^{-17}$ | $2.1\times10^{-17}$ | $0.489$ |
| $3W^\#$ | $5.9\times10^{-17}$ | $5.9\times10^{-17}$ | $0.511$ |
| $0$ | $0$ | $0$ | $1.00$ |
| $3Q(W)+W^3$ | $3.5\times10^{-17}$ | $3.5\times10^{-17}$ | $0.081$ |

> **The commit's evidence separates nothing.** It would have "confirmed" $\nabla P=0$ to the same precision, on the same run. The quoted $-8.9\times10^{-10}$ against $-1.6\times10^{-32}$ is a finite-difference noise floor either way, and reading it as agreement is reading noise as signal.

**A check with power** is a directional derivative away from $\mathrm{Crit}(P)$. At four random unit $W\in\mathrm{Weyl}_8$ (criticality residuals $0.40$–$0.43$), two Weyl directions each, central differences at $h=10^{-5}$ against $3\langle Q(W),V\rangle$: worst relative error $3.0\times10^{-10}$. Three *ambient* symmetric directions at the same $W$: $\le1.4\times10^{-10}$. So the identity holds tangentially and normally, and is not an artefact of the Weyl projector.

### (c) The fault in the earlier test, named

[weyl.py](../scripts/weyl.py)'s `Q_general` diagonalises $R$, computes **only the diagonal** of $R^\#$ in $R$'s own eigenbasis, and rebuilds $V\,\mathrm{diag}(w^2+R^\#_{AA})\,V^{\mathsf T}$. That is exact if and only if $R^\#$ is diagonal in $R$'s eigenbasis, which is false: $(R^\#)_{AB}=\tfrac12\sum_{G,D}c_{AGD}c_{BGD}w_Gw_D$ is the Killing form only when all $w$ are equal. Measured at random $W\in\mathrm{Weyl}_8$:

| | sample 0 | sample 1 |
|---|---|---|
| $\lVert Q_{\rm general}-Q\rVert$ | $0.3056$ | $0.2925$ |
| $\lVert Q\rVert$ | $0.4180$ | $0.4065$ |
| off-diagonal mass of $W^\#$ in $W$'s eigenbasis | $0.3056$ | $0.2925$ |
| $\langle W,Q_{\rm general}\rangle$ vs $\langle W,Q\rangle$ | agree to $10^{-15}$ | agree to $10^{-15}$ |
| a finite-difference gradient test built on it | rel err $\mathbf{2.2\times10^{-1}}$ | rel err $\mathbf{2.5}$ |

> **This is the fault, and it has the right signature.** $Q_{\rm general}$ pairs correctly against $W$ (which is why every $P$-value in the record computed through it is right) and wrongly against anything else. A finite-difference test of $\nabla P=3Q(W)$ pairs $Q$ against a *direction*, so it is precisely the misuse the function's own docstring warns of, and it produces residuals of the order `384e334` reported ($2.9\times10^{-4}$, $2.3\times10^{-2}$, $1.8\times10^{-2}$).

Two corrections follow. First, `Q_general`'s docstring says *"Correct for $Q(R)$ alone"*; it is correct for $\langle R,Q(R)\rangle$ alone, and returns a wrong matrix. [reviews/INDEX.md](INDEX.md) item 6 classes it as a *latent* risk *"not presently mis-used"*, it has now been mis-used, in the commit that opened the live route. Second, **neither the failing test nor the confirming test is in the tree**, so `384e334`'s *"whether the fault is the construction or the claim is UNDETERMINED"* was recorded against evidence nobody can re-run. The undetermined verdict was the right call on the evidence; committing the scripts would have made it a five-minute question rather than a two-commit one.

**Net on claim 1:** `10be9f8`'s conclusion is correct and `384e334`'s is not, so the plan's current text says the true thing. It says it on the strength of a vacuous check, and it attributes the earlier failure to *"a fault in the construction"* without naming the fault, the fault is above.

## 2, does the gradient-flow claim follow?

**The projected flow.** For unit $W$, the tangential part of $\nabla P=3Q(W)$ is $3(Q(W)-\langle Q(W),W\rangle W)=3(Q(W)-P(W)W)$, so $\dot W=Q(W)-P(W)W$ is gradient **ascent** of $P/3$ on the unit sphere. That part of F1 is sound.

**And the flow stays in $\mathrm{Weyl}_n$**, which F1 never checks and which the statement needs, since $\mathrm{Weyl}_n$ is cut out by linear conditions that $Q$ has no obvious reason to preserve. It does: at $n=6,8,10$, two random unit $W\in\mathrm{Weyl}_n$ each, $\lVert Q(W)-\mathrm{proj}_{\mathrm{Weyl}}Q(W)\rVert/\lVert Q(W)\rVert\le7.9\times10^{-16}$, with $\lVert\mathrm{Ric}(Q(W))\rVert\le2.6\times10^{-16}$ and Bianchi residual $\le10^{-16}$. The record has half of the reason on file already, [the Beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) carry $\mathop{\mathrm{scal}}(R^2+R^\#)=2\lVert\mathrm{ric}(R)\rVert^2$, giving $\mathop{\mathrm{scal}}(Q(W))=0$ for Weyl $W$; the vanishing of $\mathrm{ric}(Q(W))$ is the other half and is not on file.

**What the claim buys: nothing.** *"The maximiser is its attractor"* is true and is a restatement of *"the maximiser is a local maximum"*, which is on file, [nondegeneracy.md](../findings/nondegeneracy.md) has $S^p\times S^q$ Morse–Bott nondegenerate for $p,q\ge3$, $(p,q)\ne(3,3)$. A gradient flow's attractors are exactly its local maxima, and the record owns a second one at the wrong value: padded $W_{\mathbb{CP}^2}$, $\theta=\sqrt{3/2}$, reconfirmed in claim 4 below at $n=8$ and $n=12$. So the flow has at least two attractors at every $n\ge12$ and knowing that $W^*$ is one of them is not evidence that it is the highest.

> **F's falsifier cannot fire.** *"The sphere product is not the flow's attractor, testable at once"* asks a question whose answer is already in the record, in the direction that keeps the route alive. A falsifier that is known false before it is run is not a falsifier.

**What F2 would actually need**, stated positively: that the basin of attraction of the $W^*$-orbit is all of the unit sphere of $\mathrm{Weyl}_n$ minus a measure-zero set **and** that every other $\omega$-limit has $P\le\theta_0(n)$; equivalently, that every critical value other than $\theta_0(n)$ is below it. That is Conjecture A with the added burden of classifying the whole critical set, which [post F9](../findings/fence-posts.md) says is exponentially large and mostly symmetry-free. The gradient structure moves the problem from *"bound a cubic"* to *"classify the critical values"*, and post F9 is the standing statement that the second is harder.

## 3, is route F fenced?

### F's theorem, as stated, is satisfied by a one-dimensional witness

The plan's theorem reads: *a cone in $\mathrm{Weyl}_n$, invariant under $\dot W=Q(W)$, containing the sphere-product ray and meeting the unit sphere only where $P\le\theta_0(n)$, Conjecture A by cone invariance.*

Take $C=\mathbb R_+W^*$. Then

- **$C$ is invariant.** $Q(cW^*)=c^2Q(W^*)=c^2\theta_0W^*$, tangent to the ray. Verified: $\lVert Q(W^*)-\theta W^*\rVert=2.2\times10^{-16}$ at $n=8$ and $5.4\times10^{-16}$ at $n=12$.
- **$C$ contains the sphere-product ray**, being it.
- **$C\cap S=\{W^*\}$ and $P(W^*)=\theta_0(n)$**, $1.145643923739$ at $n=8$, $1.236033081183$ at $n=12$, matching $\sqrt{2(n-1)(n-2)/n^2}$ to twelve digits.

Every clause holds and nothing whatever is proved. **The stated theorem is not Conjecture A**; the missing clause is that the cone is all of $\mathrm{Weyl}_n$, or that every ray enters it, and under gradient *ascent* a trajectory cannot enter a region of lower $P$, so the second reading is unavailable and the first makes invariance vacuous and the content exactly the static bound. **F3, *"cone $\Rightarrow$ the bound"*, is the step that carries the whole route, and it is one line long with no argument in it.**

### The sentence in problem.md fences F, and F is the route it points at

Both are true at once, and the plan reads only the second half. [problem.md:129](../findings/problem.md) says cone-invariance arguments are *"the closest thing to a viable strategy, but they are dynamical … rather than static, and no one has yet built the static analogue needed here"*, and the plan's reframe is *"stop requiring one"*. But [ATTEMPTS.md](../ATTEMPTS.md) item 5, *"a precise statement of what a static analogue of ODE-invariance would need, and why the obvious route is blocked"*, already says **why** the static analogue is required, and the reason is not a preference:

> Wilking's technique proves an *open, slack-carrying, one-sided statement about a whole region*; Conjecture A is a *zero-slack, two-sided, single-point* statement. *"Cone-invariance arguments are built to constrain which regions an ODE trajectory can enter, not to compare two specific, possibly-distant points directly, so there is no direct translation of the maximum-principle machinery into a global comparison statement."*

The ray witness above is that paragraph's abstract point made concrete. So F is fenced, not by a numbered post but by a prior analysis of this exact route that the plan does not cite, **the same failure `779997d` records for route D** (*"route D is the record's lifting lemma under a new name … cited by neither the plan nor this file"*). The inward search that caught D would have caught F.

### Prior cone-invariance material in the record, none of it cited by F

| where | what it says |
|---|---|
| [problem.md:129](../findings/problem.md) | cone-invariance is the closest viable strategy and needs a static analogue |
| [ATTEMPTS.md](../ATTEMPTS.md) item 4 | Richard's *Curvature cones and the Ricci flow* fetched and read in full as the citable exposition of Wilking's cone construction; no precedent for applying it to a single point |
| [ATTEMPTS.md](../ATTEMPTS.md) item 5 | the precise obstruction, above |
| [problem.md:64](../findings/problem.md), [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py) | $\theta_0(n)^2=2(n-2)(n-1)/n^2$ is *what cone invariance at $a=0$ requires*, already verified as squares |
| [beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) | Conjecture A's **source formulation is cone invariance**: *"the cones $\Omega_a$ are invariant under the ODE (2.4) for $a\in[0,\tfrac n4]$"* |

The last row is the decisive one. The notes derive the bridge: $\Omega_a$ is a sublevel set of $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$, invariance is $\mathrm dF_R(\Phi(R))\le0$, and *"this project's cubic form $P$ is exactly the left-hand side of Böhm–Wilking's invariance criterion"*, with Weyl tensors the extremal directions. The notes then state the relation exactly: **the cone conjecture is strictly stronger than Conjecture A, which is its $R_{\mathrm{ric}_0}=0$ slice.**

> So *"Conjecture A by cone invariance"* proposes to reach the conjecture through a statement the record has already identified as strictly stronger than it. [target.md](../findings/target.md)'s standing verdict on this shape applies verbatim: such restatements are **Conjecture A rewritten, neither easier nor harder.**

### And F does produce a bound on $\theta$

[plan.md](../plan.md) closes the routing block with *"Both routes are checked against every fence post: the posts fence **bounds on $\theta$**, and neither route produces one."* F's own theorem statement contains the clause *"meeting the unit sphere only where $P\le\theta_0(n)$"*, which is a bound on $\theta$ on the cone; if the cone is all of $\mathrm{Weyl}_n$, as F3 needs, it is *the* bound. So the sentence is false for F, and the posts do apply to F3, [post F35](../findings/fence-posts.md) and [post F34](../findings/fence-posts.md) at minimum, since any cone built from a norm-type or split estimate on $Q$ inherits their losses. Checked post by post, no post kills F1 or F2; what fails is the claim of exemption, not a specific post.

## 4, route D's closure

Both halves reproduce from an independently built padded $W_{\mathbb{CP}^2}$: I take the self-dual $2$-forms $\omega_1=(\varphi_{01}+\varphi_{23})/\sqrt2$, $\omega_2=(\varphi_{02}+\varphi_{31})/\sqrt2$, $\omega_3=(\varphi_{03}+\varphi_{12})/\sqrt2$ and set $W\propto2\omega_1\omega_1^{\mathsf T}-\omega_2\omega_2^{\mathsf T}-\omega_3\omega_3^{\mathsf T}$, zero-padded into $\Lambda^2\mathbb R^n$ ([c4_routeD.py](../scripts/reviewers/r286/c4_routeD.py)). Ricci and Bianchi residuals are **exactly** $0$ in floating point, criticality residual $2.2\times10^{-16}$, $\theta=1.224744871392=\sqrt{3/2}$ at both $n$.

| | $n=8$ | $n=12$ |
|---|---|---|
| $\dim\mathrm{Weyl}_n$ | $300$ | $1638$ |
| $\max\mathop{\mathrm{spec}}(L_e\vert_{W^\perp})$ | $0.500000000000$ | $0.500000000000$ |
| eigenvalues $>\tfrac12$ | $\mathbf0$ | $\mathbf0$ |
| eigenvalues $=\tfrac12$ | $18$ | $34$ |
| rank of the $O(n)$-orbit tangent $\{[\mathrm{ad}\varphi_a,W]\}$ | $18$ | $34$ |
| $\min\lVert\omega\wedge\omega\rVert$ on the $(-0.408248)$ eigenspace, $\dim2$ | $0.500000000$ | $0.500000000$ |

**Half (a), local maximum, CONFIRMED, and the criterion is the right one, with the caveat named.** The sphere Hessian of a cubic at a critical point is $6\theta(L_e-\tfrac12\mathrm{Id})$ with $e=W/\theta$: since $P(W)=T(W,W,W)$ with $T$ fully symmetric (claim 1), $\mathrm{Hess}\,P[V,V]=6\langle W\circ V,V\rangle$ and the sphere correction subtracts $3P\lVert V\rVert^2$. Verified against second differences of $P$ along great circles: $-3.64387434$ vs $-3.64387457$ and $-3.45332805$ vs $-3.45332830$ at $n=8$; $-3.64740298$ vs $-3.64740313$ and $-3.57781362$ vs $-3.57781389$ at $n=12$. So *"$\max\mathop{\mathrm{spec}}\le\tfrac12$"* is exactly *"Hessian negative semidefinite"*, **necessary, and not by itself sufficient for a local maximum**, because the $\tfrac12$-eigenspace is a $18$- resp. $34$-dimensional kernel that second order cannot resolve. What closes it is that the kernel **is** the orbit: the orbit-tangent rank equals the multiplicity exactly, and $P$ is constant along the orbit ($\lvert P(W+10^{-3}o)-P(W)\rvert\le1.8\times10^{-6}=O(\varepsilon^2)$ over twenty orbit directions). `779997d` states the multiplicity match but not that the match is what upgrades semidefiniteness to maximality; the conclusion is right and its load-bearing step is unstated.

**Half (b), Plücker, CONFIRMED, and it is closed-form rather than numerical.** The obstructed eigenspace is $\Lambda^2_+\mathbb R^4\cap W^\perp_{\omega_1}=\mathrm{span}\{\omega_2,\omega_3\}$, and every nonzero self-dual $2$-form on $\mathbb R^4$ has $\omega\wedge\omega=\lVert\omega\rVert^2\mathrm{vol}\ne0$. So the minimisation over the unit circle of that plane is constant, which is why the measured value is exactly $0.5$ at every sample and at both dimensions. **The $(+0.816497)$ eigenspace is obstructed too**, at the same $0.5$, the file quotes only the negative one.

**So the closure stands.** A point that is critical, a local maximum, and Plücker-obstructed exists in $\mathrm{Weyl}_{12}$, so no second-order criterion at a maximiser can exclude an obstructed eigenspace, and D2 as respecified is unreachable.

## 5, the mechanism route D left behind

### (i) Every one-positive/two-negative element is Plücker-obstructed, TRUE, with a scope caveat

Verified on the record's own one-parameter family $W^+=\mathrm{diag}(q+r,-q,-r)$ on $\Lambda^2_+$, padded into $n=12$, at $(q,r)=(1,1),(1,0.3),(1,0.05),(2,1.3)$: Ricci and Bianchi $\le1.4\times10^{-16}$, signature $(1,2)$ confirmed, and **every** nonzero eigenspace obstructed at exactly $\min\lVert\omega\wedge\omega\rVert=0.5$, whether the two negative eigenvalues coincide (a $2$-plane) or not (two lines).

The reason is analytic and stronger than the file's: by [stratum-two-negative.md](../findings/stratum-two-negative.md)'s own support argument, Ricci-flatness forces the support to be $\mathrm{im}\,v_1$ of even dimension $r$, and at $r=4$ the stratum is the self-dual family, whereupon **every nonzero eigenvector is a self-dual $2$-form and $\omega\wedge\omega=\lVert\omega\rVert^2\mathrm{vol}\ne0$ identically.** No minimisation and no rank-$4$-plane argument is needed, and the claim holds eigenspace by eigenspace rather than only at the equality case.

**The caveat.** That argument covers the $r=4$ members. The file's own equality clause says the reduction to $r=4$ is *"equivalent to: no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ exists for even $r\ge6$"*, **excluded numerically at $r=6,8,10$ and not proved**. So *"every one-positive/two-negative element"* is proved for $r=4$ and rests on numerics for $r\ge6$. The new theorem inherits the old gap, and `c3ac30d` states it unconditionally.

### (ii) No maximiser lies in that stratum, TRUE for $n\ge12$

$\theta\le\sqrt{3/2}=1.224744871392<1.236033081183=\theta_0(12)$, and $\theta_0$ increases in $n$. The qualifier matters and the file carries it. (At $n=8$ it fails in the other direction: $\theta_0(8)=1.1456<\sqrt{3/2}$, and padded $W_{\mathbb{CP}^2}$ beats the sphere product there, which is what $n\ge12$ is for.)

### (iii) $\text{Plücker-obstructed}\Rightarrow\theta\le\sqrt{3/2}$, REFUTED

**It does not follow from (i) and (ii).** (i) is $\text{stratum}\Rightarrow\text{obstructed}$ and (ii) caps the stratum. Concluding $\text{obstructed}\Rightarrow\theta\le\sqrt{3/2}$ affirms the converse of (i). `c3ac30d`'s commit body, *"the cap saturates identically there, giving an unrecorded theorem … so the implication D2 needed all along is"*, makes exactly that step.

**And the implication is false, by one line and by a witness.** Obstructed points contain a dense open subset of $\mathrm{Weyl}_n$ for $n\ge5$: a generic $W$ has simple spectrum, and the decomposable bivectors form a cone of dimension $2n-3$ inside $\binom n2$, so a generic eigenline misses it. $\theta$ is continuous. So $\theta\le\sqrt{3/2}$ on a dense set would give $\theta\le\sqrt{3/2}$ everywhere, contradicting $\theta(W^*)=\theta_0(12)=1.236033$. **The implication is not merely unproven; it is refuted by the maximiser it is supposed to bound.**

The explicit witness, in case the density argument is thought too quick ([c4_routeD.py](../scripts/reviewers/r286/c4_routeD.py)). Perturb $W^*$ at $n=12$ by a random unit Weyl direction:

| $\varepsilon$ | $\lVert\mathrm{Ric}\rVert$ | Bianchi | $\theta$ | $>\sqrt{3/2}$? | obstructed at |
|---|---|---|---|---|---|
| $10^{-1}$ | $4.5\times10^{-16}$ | $3.1\times10^{-17}$ | $1.217948946$ | no | $0.607$ |
| $3\times10^{-2}$ | $4.1\times10^{-16}$ | $8.1\times10^{-18}$ | $1.234346301$ | **yes** | $0.615$ |
| $10^{-2}$ | $3.1\times10^{-16}$ | $3.0\times10^{-18}$ | $\mathbf{1.235844074}$ | **yes** | $0.615$ |

Every eigenvalue is simple at these $\varepsilon$, so each eigenspace is a line and its $\min\lVert\omega\wedge\omega\rVert$ is an evaluation, not a search.

### And even if it were true it would not close the conjecture

[diagonality.md](../findings/diagonality.md) justifies the implication with *"the non-diagonal locus being exactly where the obstruction lives"*. The file's own instrument table says Plücker is **sufficient, never necessary**, so obstructed is a proper subset of non-diagonalisable and the word *exactly* is wrong. The chain would then read: diagonalisable $\Rightarrow\theta\le\theta_0$ (Jäger, even $n\ge16$; [response.md](../response.md) Lemma L1 at $n=12,14$), obstructed $\Rightarrow\theta\le\sqrt{3/2}$, and **non-diagonalisable-but-unobstructed left untouched**, which is where [problem.md](../findings/problem.md) item 11 says the residual actually lives. Two independent failures, either one fatal.

**What survives and is worth keeping**: (i) as a proved statement about the $r=4$ stratum with the self-duality proof, and (ii). The implication in (iii) should come off the record as refuted rather than stand as a live target.

## 6, the sweep, and the index

### The index is not complete

`c3ac30d` added rows for r269–r273, which closes the gap r283 and r284 named. It leaves a much larger one. Parsing every table row of [reviews/INDEX.md](INDEX.md) that begins with a reviewer number or range, against the files in [reviews/](../reviews/):

- **77 filed reports have no index row** (excluding r285, which is concurrent with this one): $125$, $133$, $137$, $139$–$140$, $147$–$148$, $151$–$169$, $202$–$204$, $207$–$216$, $220$–$233$, $235$–$258$.
- **Every reviewer from 202 to 258 that filed is unindexed.** The numbered rows run $\dots201$, then jump to $259$.
- The index's own header promises that *"from 58 on, each reviewer also has a standalone `REVIEW_rN.md` … the section here carries the verdict"*. For 77 reports there is no section.
- **This is already costing citations.** [plan.md](../plan.md)'s standing-state block reads *"and reviewer 250 shows the padding transfer does not need it"*, [REVIEW_r250.md](REVIEW_r250.md) is an 11 KB report and the index cannot locate it. A reader working top-down from REVIEW.md cannot reach the source of a claim the plan relies on.
- Seven index rows point at reviewers with no file: $135$, $136$, $138$, $141$–$144$.

So the answer to *"is the index now complete"* is **no**, and the five rows added were the smallest part of the gap.

### Still unapplied from r259–r284, verified live in the tree

r283 listed four items; three are unchanged today.

| item | filed by | state now |
|---|---|---|
| [second-order.md:206](../findings/second-order.md) still reads *"What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$, i.e. an a priori bound $M(n)\le\sqrt3$"* | r278, r279, r280, r283 | **LIVE at the fifth asking**, [post F35](../findings/fence-posts.md) says that conversion is the harmonic-square law and holds only on $\circ$-decomposables, the complement of the residual the sentence is about. The sentence sits two lines after the sentence that identifies the residual as $\circ$-indecomposable |
| [sym3-blocks.md:136](../findings/sym3-blocks.md) still heads its closing section *"What the certificate would establish"* | r280, r281, r282, r283 | **LIVE** |
| fence post F26 is defined in no findings file | r282, r283 | **LIVE**, the only occurrence outside the [findings/INDEX.md](../findings/INDEX.md) index row is [ad-form-attempt.md:32](../findings/ad-form-attempt.md), which records it as *failed at its own anchor*. `c079378`'s route-D paragraph that cited it is gone, so nothing now cites an undefined post; the post itself is still undefined |
| the total-symmetry ingredient in the one-line theorem | r281, r283 | applied in [support-dichotomy.md](../findings/support-dichotomy.md) |

### r284's own items, against the commits under review

| r284 verdict | applied? |
|---|---|
| the local-max witness refuting D2's replacement | **yes**, `779997d`, faithfully, and it reproduces here |
| the unitary-isotropy row is a misreading | **partly**, `779997d` appends *"The unitary-isotropy row above is wrong"* and **leaves the wrong row in the table**. [diagonality.md](../findings/diagonality.md) now asserts both *"sufficient, never necessary … native dimension 4 only"* and its refutation, in one file |
| Lemma L66 orphaned Lemma L41's certificate | **yes**, `779997d` moves it |
| route D is the lifting lemma renamed | **yes** |

### One defect of my own finding, outside the r283/r284 lists

[diagonality.md](../findings/diagonality.md)'s closure links *"[Post F22](fence-posts.md) fences it"*, and post F22 is not in [fence-posts.md](../findings/fence-posts.md), that file says *"posts 11–22 are recorded where they were established"*, and post F22 lives in [target.md](../findings/target.md). The link resolves to a file that does not contain the post it names.

---

## What I could not settle

- **Why $Q$ preserves $\mathrm{Weyl}_n$.** Established numerically at $n=6,8,10$ to $8\times10^{-16}$ and half-derived from the record's $\mathop{\mathrm{scal}}(Q(W))=0$; the vanishing of $\mathrm{ric}(Q(W))$ for Ricci-flat $R$ is not on file and I did not derive it. Route F needs it as a lemma, since without it the ODE leaves the space the cone is supposed to live in.
- **Whether any $r\ge6$ full-support rank-$3$ signature-$(1,2)$ Weyl element exists**, which is what claim 5(i) rests on beyond $r=4$. I reproduced neither the numerics nor a proof.
