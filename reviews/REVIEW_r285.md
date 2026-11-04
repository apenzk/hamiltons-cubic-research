# REVIEW r285, Gate 2, route F's gradient identity and route D's closure

Reviewer 285. Commits under review: `10be9f8` (primary), `384e334`, `779997d`, `c3ac30d`.
Primary file: [plan.md](../plan.md) route F. Supporting: [findings/diagonality.md](../findings/diagonality.md), [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [findings/fence-posts.md](../findings/fence-posts.md), [scripts/review_r27_core.py](../scripts/review_r27_core.py), [scripts/weyl.py](../scripts/weyl.py), [reviews/REVIEW_r283.md](REVIEW_r283.md), [reviews/REVIEW_r284.md](REVIEW_r284.md).
Scripts: [scripts/reviewers/r285/](../scripts/reviewers/r285/). Reviewer 286 runs the identical brief concurrently and independently.

Everything numeric below is built from my own structure constants, my own `#`, my own Weyl basis and my own $Q$ ([c1_gradient.py](../scripts/reviewers/r285/c1_gradient.py)); the only reviewed code I call is [Q_general](../scripts/weyl.py) itself, and only in order to indict it.

| # | Claim | Verdict |
|---|---|---|
| 1 | $\nabla P=3Q(W)$ | **CONFIRMED, but by neither of the two commits' arguments, and the fault is now named.** (a) `#` is fully trilinearly symmetric on *all* of $\mathrm{Sym}^2(\Lambda^2)$, from total antisymmetry of the structure constants alone. (b) `10be9f8`'s check is **vacuous**, at a critical point the prediction is $0$ for *every* constant $c$ in $\nabla P=cQ(W)$. (c) **THE FAULT IS [Q_general](../scripts/weyl.py)**: it zeroes the off-diagonal part of $R^\#$ in $R$'s own eigenbasis, which leaves $P$ exact to $10^{-16}$ and $\langle Q(W),V\rangle$ wrong by $10^{-2}$, the reported band, reproduced |
| 2 | Does the gradient-flow claim follow? | **THE MAXIMISER IS AN ATTRACTOR, AND THAT IS A TAUTOLOGY THAT SUPPLIES NOTHING.** $\theta$ is strictly increasing along the flow off critical points (proved below), so every local maximum is an attractor, and **the flow has at least two at $n=12$**: the balanced sphere product ($\theta=1.236033081183$) and padded $W_{\mathbb{CP}^2}$ ($\theta=1.224744871392$), both with $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)=\tfrac12$ and null space exactly the orbit. **F's stated falsifier can never fire** |
| 3 | Is route F fenced? | **THE STATED THEOREM IS CIRCULAR, AND THE PLAN'S FENCE CLEARANCE IS FALSE ON ITS FACE.** A cone $C\subseteq\mathrm{Weyl}_n$ whose sphere-trace lies in $\{P\le\theta_0\}$ yields Conjecture A only if $C=\mathrm{Weyl}_n$, in which case invariance is vacuous and the whole content is the conjecture. And F3 is *"cone $\Rightarrow$ **the bound**"* (a bound on $\theta$) so plan.md's *"neither route produces one"* is false of F by F's own step 3. **The route also is not new**: [problem.md](../findings/problem.md) already carries Beitz's $\Omega_a$ cones, the bridge, and the statement that cone invariance is *strictly stronger* than Conjecture A |
| 4 | Route D's closure | **BOTH HALVES CONFIRMED INDEPENDENTLY, at $n=8$ and $n=12$, and the criterion is the right one.** $\theta=1.224744871392$, criticality $\le4.2\times10^{-15}$, $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)=0.500000000000$ with **zero** eigenvalues above $\tfrac12$ and $18/34$ at $\tfrac12$ against orbit dimensions $18/34$; Plücker minimum $0.500000$ on the $2$-dimensional $-0.408248$ eigenspace |
| 5 | The mechanism D left | **REFUTED BY WITNESS, "Plücker-obstructed $\Rightarrow\theta\le\sqrt{3/2}$" IS FALSE, and the obstruction is GENERIC.** A generic perturbation of the balanced sphere product at $n=12$ has $66$ simple eigenvalues, every eigenline carrying $\lVert\omega\wedge\omega\rVert\ge0.44$, at $\theta$ up to $1.236031>\sqrt{3/2}$. The stated derivation is also a converse error, and its "closes the conjecture" clause inverts the file's own *sufficient, never necessary* |
| 6 | Sweep r259–r284, index | **THE INDEX IS NOW COMPLETE for $259$–$284$, the five rows landed.** Four mathematical items are still live in the tree, three of them filed three or four times: [second-order.md:206](../findings/second-order.md), [sym3-blocks.md](../findings/sym3-blocks.md)'s rank contradiction and its stale heading, and [FINDINGS.md:19](../findings/INDEX.md), which asserts and denies the odd-$n$ diagonal case **in one row** |

---

## Claim 1, the gradient identity

**Verdict: the identity is TRUE, `10be9f8`'s conclusion is right and its evidence is worthless, and `384e334`'s numbers were produced by a bug I can name and reproduce.**

### (a) The derivation, and whether `#` really is trilinearly symmetric

Work in the orthonormal basis $\varphi_{ij}=E_{ij}-E_{ji}$ of $\Lambda^2\mathbb R^n$ with $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, and put $c_{abg}=\langle[\varphi_a,\varphi_b],\varphi_g\rangle$. Because the inner product is $\mathrm{ad}$-invariant, $c$ is **totally antisymmetric**, verified exactly, $0.0$ in both transpositions at $n=5,6$.

The two definitions in the record agree exactly (max difference $0.0$ at $n=5,6$):

$$(X\#Y)_{ab}=-\tfrac12\mathop{\mathrm{tr}}(A_aXA_bY),\qquad (X\#Y)_{ab}=\tfrac12\,c_{apq}c_{brs}X_{pr}Y_{qs},\qquad (A_a)_{mn}=c_{amn}.$$

The second form settles the symmetry question **analytically**, and it is one line. Using cyclicity of $c$,

$$\langle X\#Y,Z\rangle=\tfrac12\sum c_{pqa}\,c_{rsb}\,X_{pr}\,Y_{qs}\,Z_{ab},$$

in which the two structure constants' **first** indices are contracted through $X$, their **second** through $Y$, their **third** through $Z$. Permuting the three slots in both $c$'s simultaneously permutes $(X,Y,Z)$ and multiplies by $(\pm1)^2=+1$. So $T(X,Y,Z)=\langle X\#Y,Z\rangle$ is **fully symmetric on all of $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$**, no Bianchi, no trace-freeness, no criticality. Confirmed numerically: all six orderings agree to $4\times10^{-14}$ at $n=5$ and $1\times10^{-13}$ at $n=6$ on random symmetric matrices ([c1_gradient.py](../scripts/reviewers/r285/c1_gradient.py)).

*Is the symmetry needed in the form used?* Yes, and only in that form. The step is $\mathrm d\langle W^\#W,W\rangle[V]=2\langle V\#W,W\rangle+\langle W^\#,V\rangle$, and it closes only because $\langle V\#W,W\rangle=\langle W\#W,V\rangle$, a **transposition moving $V$ from slot 1 to slot 3**, which the $X\!\leftrightarrow\! Y$ symmetry alone (immediate from the definition) does not supply. So the load-bearing half is exactly the half that needs total antisymmetry of $c$. It holds.

Adding $\mathrm d\mathop{\mathrm{tr}}(W^3)[V]=3\langle W^2,V\rangle$ gives $\mathrm dP[V]=3\langle Q(W),V\rangle$ **for every $V$**, in the ambient space.

### The step the plan does not state, and which happens to hold

$\nabla P=3Q(W)$ *as an identity in $\mathrm{Weyl}_n$* needs more than $\mathrm dP[V]=3\langle Q(W),V\rangle$ for $V\in\mathrm{Weyl}_n$: it needs $Q(W)$ itself to lie in $\mathrm{Weyl}_n$, else the intrinsic gradient is $3\pi_{\mathrm{Weyl}}Q(W)$ and route F's flow $\dot W=Q(W)$ is **not tangent to the space it is supposed to move in**. Neither commit checks this, and it is the one place the identity could have failed for route F's purposes.

It holds. At random unit $W\in\mathrm{Weyl}_n$ ([c1c_qweyl.py](../scripts/reviewers/r285/c1c_qweyl.py)):

| $n$ | $\lVert Q(W)\rVert$ | $\lVert Q(W)-\pi_{\mathrm{Weyl}}Q(W)\rVert$ | $\lVert\mathrm{Bianchi}(Q(W))\rVert$ | $\lVert\mathrm{Ric}(Q(W))\rVert$ |
|---|---|---|---|---|
| $6$ | $0.52$–$0.62$ | $\le3.4\times10^{-16}$ | $\le5.8\times10^{-17}$ | $\le2.3\times10^{-16}$ |
| $8$ | $0.41$–$0.45$ | $\le3.3\times10^{-16}$ | $\le1.1\times10^{-16}$ | $\le2.1\times10^{-16}$ |

So $\mathrm{Weyl}_n$ is $Q$-invariant: Bianchi by Hamilton's lemma, and the Ricci trace of $Q(R)$ vanishes when $\mathrm{Ric}(R)$ does. **Route F's flow is tangent, and this is the one structural fact route F needs that the plan never claimed.**

### (b) The confirming check cannot distinguish the identity from a false one

`10be9f8` checks at the balanced sphere product, *"critical to $3\times10^{-16}$"*. At a critical point $Q(W)=\theta W$, so for any tangential $V$ ($\langle W,V\rangle=0$)

$$\langle Q(W),V\rangle=\theta\langle W,V\rangle=0 .$$

The prediction is $0$ **for every constant $c$ in $\nabla P=cQ(W)$**, and indeed for every candidate gradient of the form $f(W)W+(\text{anything}\perp V)$. A test whose prediction is $0$ under the claim and $0$ under its negation decides nothing; it re-measures criticality, which was assumed going in. The commit's own numbers say so out loud: *measured* $-8.9\times10^{-10}$ against *predicted* $-1.6\times10^{-32}$, **twenty-two orders of magnitude apart**, and read as agreement because both are "small". The measured value is finite-difference noise.

**A test that can distinguish, and its result.** Take $W$ random in $\mathrm{Weyl}_n$ (criticality residual $\approx0.4$–$0.5$, so nowhere near critical), $V$ random in $\mathrm{Weyl}_n$, central differences of $P$ ([c1b_fd.py](../scripts/reviewers/r285/c1b_fd.py)):

| $n$ | crit. residual at $W$ | $3\langle Q(W),V\rangle$ | central difference | relative error |
|---|---|---|---|---|
| $6$ | $0.49$ | $-0.109008856626$ | $-0.109008856640$ | $1.4\times10^{-11}$ |
| $6$ | $0.54$ | $-0.049736775505$ | $-0.049736775517$ | $1.2\times10^{-11}$ |
| $6$ | $0.51$ | $0.140647692159$ | $0.140647692171$ | $1.2\times10^{-11}$ |
| $8$ | $0.42$ | $-0.040272183020$ | $-0.040272183017$ | $2.4\times10^{-12}$ |
| $8$ | $0.41$ | $0.078026304045$ | $0.078026304047$ | $1.5\times10^{-12}$ |
| $8$ | $0.43$ | $0.104571799336$ | $0.104571799344$ | $7.8\times10^{-12}$ |

The basis is orthonormal to $2\times10^{-15}$ and every test direction is Weyl to $6\times10^{-16}$. **The identity is confirmed where it has content.**

### (c) The fault, named and reproduced

`10be9f8` attributes the $2\times10^{-2}$ residuals to *"a fault in the construction"* without saying which. It is [Q_general](../scripts/weyl.py), the repo's own $Q$:

```
w, V = np.linalg.eigh(Rmat)
Rsharp_diag = 0.5 * np.einsum('ABG,B,G->A', cp**2, w, w)
Qmat = V @ np.diag(w**2 + Rsharp_diag) @ V.T
```

It computes only the **diagonal** of $R^\#$ in $R$'s eigenbasis and reassembles $Q$ as if the off-diagonal were zero. It is not zero. Measured ([c1d_fault.py](../scripts/reviewers/r285/c1d_fault.py)) at random unit Weyl $W$:

| $n$ | $\lVert Q_{\text{true}}\rVert$ | $\lVert Q_{\text{true}}-Q_{\texttt{general}}\rVert$ | $\lVert\text{offdiag}(Q_{\text{true}})\rVert$ in $W$'s eigenbasis | error in $P$ | residual with $Q_{\text{true}}$ | residual with $Q_{\texttt{general}}$ |
|---|---|---|---|---|---|---|
| $6$ | $0.597$ | $0.452$ | $0.452$ | $3.7\times10^{-16}$ | $1.6\times10^{-11}$ | $\mathbf{1.4\times10^{-1}}$ |
| $6$ | $0.531$ | $0.346$ | $0.346$ | $2.2\times10^{-16}$ | $9.9\times10^{-12}$ | $\mathbf{8.6\times10^{-2}}$ |
| $8$ | $0.441$ | $0.325$ | $0.325$ | $1.5\times10^{-16}$ | $8.4\times10^{-12}$ | $\mathbf{3.3\times10^{-2}}$ |
| $8$ | $0.430$ | $0.346$ | $0.346$ | $4.5\times10^{-17}$ | $2.7\times10^{-13}$ | $\mathbf{1.2\times10^{-2}}$ |
| $8$ | $0.429$ | $0.320$ | $0.320$ | $5.9\times10^{-17}$ | $1.7\times10^{-12}$ | $\mathbf{8.0\times10^{-2}}$ |

Three things line up exactly. The discrepancy equals the discarded off-diagonal mass to every digit. $P$ is untouched, because $P=\langle W,Q(W)\rangle$ is a *diagonal* pairing in $W$'s own eigenbasis, which is precisely what the shortcut preserves, so the **left** side of the finite-difference test was right and only the **right** side was wrong. And the $n=8$ residuals land at $1.2\times10^{-2}$, $3.3\times10^{-2}$, $8.0\times10^{-2}$, straddling `384e334`'s reported $2.9\times10^{-4}$, $2.3\times10^{-2}$, $1.8\times10^{-2}$.

**So `384e334`'s diagnosis was half right and pointed at the wrong half.** It blamed the test *directions* (Bianchi-kernel instead of Weyl) and reported that projecting onto the Weyl basis *"did not repair it"*, correctly, because the directions were never the problem: the $Q$ on the right-hand side was. [Q_general](../scripts/weyl.py)'s own docstring warns it is *"UNSAFE FOR POLARIZATION"* and directs the reader to a basis-free $Q$ *"for any Hessian or polarization computation"*; a gradient pairing against a generic direction is exactly that class of use, and the warning was not heeded.

**What both commits should have recorded.** `384e334`'s "UNDETERMINED" was the right verdict on the evidence it had. `10be9f8` reached the right conclusion on evidence that does not support it, and recorded the fault as located *"in the construction"* while leaving it unnamed, so the same bug is still live in [scripts/weyl.py](../scripts/weyl.py) for the next caller. F1 stands; its stated warrant does not.

## Claim 2, does the gradient-flow claim follow?

**Verdict: the maximiser is an attractor, the statement is a tautology, and it carries none of the weight route F puts on it.**

### The flow is the gradient flow, and $\theta$ is strictly monotone along it

This much is right and worth stating cleanly. $P$ is homogeneous of degree $3$, so Euler gives $\langle\nabla P,W\rangle=3P(W)$; at $\lVert W\rVert=1$ the sphere-tangential gradient of $P/3$ is $\tfrac13(3Q(W)-3P(W)W)=Q(W)-P(W)W$, which is the plan's projected ODE exactly. And along the *unnormalised* flow $\dot W=Q(W)$, writing $\theta=P(W)/\lVert W\rVert^3$,

$$\dot\theta=\frac{3\big(\lVert Q\rVert^2\lVert W\rVert^2-P^2\big)}{\lVert W\rVert^5}\ \ge\ 0$$

by Cauchy–Schwarz on $P=\langle W,Q\rangle$, with equality **iff** $Q(W)\parallel W$, i.e. iff $W$ is critical. So $\theta$ increases strictly off the critical set.

### Therefore every local maximum is an attractor, and there is more than one

A gradient flow's attractors are its local maxima. The global maximiser is one, so it is an attractor, but that is a consequence of it being the maximiser, not an independent fact, and the implication route F needs runs the other way: *the attractor is the maximiser*. That is false, because the flow has several.

Measured on the full Weyl space with my own Hessian ([c24_hessian.py](../scripts/reviewers/r285/c24_hessian.py)):

| $n$ | point | $\theta$ | criticality | $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)$ | $>\tfrac12$ | $=\tfrac12$ | orbit |
|---|---|---|---|---|---|---|---|
| $8$ | balanced sphere product | $1.145643923739$ | $9.9\times10^{-16}$ | $0.500000000000$ | $0$ | $16$ | $16$ |
| $8$ | padded $W_{\mathbb{CP}^2}$ | $1.224744871392$ | $1.4\times10^{-15}$ | $0.500000000000$ | $0$ | $18$ | $18$ |
| $12$ | balanced sphere product | $1.236033081183$ | $6.2\times10^{-15}$ | $0.500000000000$ | $0$ | $36$ | $36$ |
| $12$ | padded $W_{\mathbb{CP}^2}$ | $1.224744871392$ | $4.2\times10^{-15}$ | $0.500000000000$ | $0$ | $34$ | $34$ |

At $n=12$ **both** points are Morse–Bott local maxima, so the flow has at least two attracting critical manifolds, at $\theta=1.236033$ and $\theta=1.224745$. Being an attractor does not rank them; only the *value* does. The record's own [post F9](../findings/fence-posts.md) says the critical set is *"exponentially large and mostly symmetry-free"*, and [nondegeneracy.md](../findings/nondegeneracy.md) records $61$ distinct critical points inside a single grading at $n=6$, so the true attractor count is far above two.

### The stated falsifier cannot fire

plan.md offers *"Falsifier: the sphere product is not the flow's attractor, testable at once."* It is testable at once and it has now been tested: the balanced sphere product has $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)=\tfrac12$ exactly with zero eigenvalues above and null space exactly its $36$-dimensional orbit, at $n=12$. **It is an attractor.** It would have failed only if the sphere product were not even a local maximum, which would refute Conjecture A outright and is refuted by data the record has carried since [nondegeneracy.md](../findings/nondegeneracy.md). A falsifier whose failure mode is "the conjecture is false in the crudest possible way" is not a test of route F.

### What F2 would actually need

Not a Lyapunov function, $P$ already is one, and that is all the gradient structure supplies. F2 must exclude every *other* basin, i.e. establish

$$\sup\{\,P(W):W\in\mathrm{Weyl}_n,\ \lVert W\rVert=1,\ W\ \text{critical}\,\}=\theta_0(n),$$

which is Conjecture A verbatim. Gradient-flow language converts the problem from "maximise $P$" to "rank the attractors", and the ranking is the whole difficulty.

## Claim 3, is route F fenced?

**Verdict: the target theorem as stated is circular; the plan's fence clearance is false at F3; and the route is the record's own cone-invariance material, which already prices it above Conjecture A.**

### The stated theorem does not imply the conjecture

plan.md's theorem: *"a cone in $\mathrm{Weyl}_n$, invariant under $\dot W=Q(W)$, containing the sphere-product ray and meeting the unit sphere only where $P\le\theta_0(n)$, Conjecture A by cone invariance."*

Cone invariance is a statement of the form *$W(0)\in C\Rightarrow W(t)\in C$*. It constrains points **inside** $C$ and says nothing about points outside it. So from $C\cap S\subseteq\{P\le\theta_0\}$ one concludes $P\le\theta_0$ on $S$ only if $S\subseteq C$, i.e. only if $C=\mathrm{Weyl}_n$, at which point invariance is trivially true and every ounce of content sits in "$C\cap S\subseteq\{P\le\theta_0\}$", which **is** Conjecture A. **The other reading is worse:** for a proper cone the theorem is satisfied by the sphere-product ray itself, which is invariant (it is a critical ray, $Q(W)=\theta W$) and meets the sphere at $P=\theta_0$, a true statement that proves nothing.

Claim 2's monotonicity sharpens this. Since $\theta$ strictly increases off the critical set, a forward-invariant cone whose sphere-trace lies in $\{\theta\le\theta_0\}$ must have every non-critical boundary point strictly below $\theta_0$: the level $\theta=\theta_0$ can be reached inside $C$ only at critical points. So the cone F wants is one whose top face consists of critical points, again, exactly the classification the conjecture asks for.

### The plan's own fence clearance is false

plan.md closes with *"Both routes are checked against every fence post: the posts fence **bounds on $\theta$**, and neither route produces one."* **F3 is literally "Cone $\Rightarrow$ the bound."** Route F's deliverable is $P\le\theta_0(n)\lVert W\rVert^3$ (a bound on $\theta$) so the sentence exempting F from the posts is contradicted by F's own step list two lines above it. Whether any *individual* post reaches F's method is a separate question (posts 1, 2, 2b, 33, 34, 35 each fence a specific mechanism, the $\mathop{\mathrm{tr}}W^3$ split, term-by-term estimates, Xu's Rayleigh step, two moments, Cauchy–Schwarz on the sharp term, norm-type caps, and cone invariance is none of them), but the *blanket clearance the plan grants itself is not available*, and the grade rests on it.

### The problem.md sentence does not fence F. Something stronger does

[problem.md:129](../findings/problem.md) reads: cone-invariance arguments *"are the closest thing to a viable strategy, but they are dynamical (ODE-invariance under $\dot W=Q(W)$) rather than static, and no one has yet built the static analogue needed here."* plan.md answers *"the reframe is to stop requiring one."*

**The sentence names the dynamical technique as available and the static analogue as the missing piece, so F is indeed the route it points at, not a route it forbids.** But "stop requiring one" misreads what the static analogue is *for*. [ATTEMPTS.md](../ATTEMPTS.md) item 5 spells it out, and it is the same point as the circularity above: Wilking's technique proves *"membership in $C(S)$ is preserved by the flow, an open, slack-carrying, one-sided statement about a whole region"*, whereas Conjecture A is *"a zero-slack, two-sided, single-point statement"*, and *"cone-invariance arguments are built to constrain which regions an ODE trajectory can enter, not to compare two specific, possibly-distant points directly, so there is no direct translation."* Dropping the requirement drops the conclusion.

### The record already contains the cone attempt, and prices it above the conjecture

This is the sharper finding, and neither the plan nor the commit cites any of it. [problem.md:32–104](../findings/problem.md) carries:

- **Beitz's cone family $\Omega_a$**, in which the conjecture is *stated*, Remark 6.3.15, *"the cones $\Omega_a$ are invariant under the ODE for $a\in[0,\tfrac n4]$"*;
- **the bridge**, derived and then found published twice (Beitz (6.24)–(6.25), Xu (3.1)–(3.4)): $P$ *is* the left-hand side of the invariance criterion, and $\theta_0(n)^2=2(n-1)(n-2)/n^2$ *"is not a guess read off the sphere products, it is what cone invariance at $a=0$ requires"*;
- **the price**: *"$a=0$ leaves $R_{\mathrm{ric}_0}$ unconstrained, so the full cone conjecture is strictly more than Conjecture A; Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice"*, with one surviving coupling that a general proof still owes;
- **the sharpness witness**: $\Omega_0$ is *provably non-invariant* for $4\le n\le11$, via padded $W_{\mathbb{CP}^2}$ on $\partial\Omega_0$.

So the direction "invariant cone $\Rightarrow$ the bound" is on record, proved, and F3 is not new work. What F2 proposes to build is the cone whose invariance the record has already shown to be **strictly stronger than the goal**. Route F therefore inherits route D's structural defect one level up: it proposes to reach Conjecture A by proving something that implies it and is harder. *And [ATTEMPTS.md](../ATTEMPTS.md) item 4 records a literature search for exactly this technique, reading Richard's exposition of Wilking's cone construction in full and finding no application to a single point.*

**Scope, honestly.** F's cone lives in $\mathrm{Weyl}_n$ rather than in the full curvature space, so it is not literally $\Omega_0$. That does not rescue it: the circularity argument above applies to any cone inside $\mathrm{Weyl}_n$, and the one thing a $\mathrm{Weyl}_n$-internal cone needs (that the flow stays in $\mathrm{Weyl}_n$), is the invariance I verified under Claim 1, which the plan never claimed.

## Claim 4, route D's closure

**Verdict: both halves verified independently, at $n=8$ and $n=12$, and "local maximum" is established on the right criterion.**

My padded $W_{\mathbb{CP}^2}$ is built from the $\mathbb{CP}^2$ curvature tensor $R=(\delta\delta-\delta\delta)+(JJ-JJ)+2J_{ij}J_{kl}$ on $\mathbb R^4$, projected onto $\mathrm{Weyl}_4$ **in dimension $4$** and then zero-padded, the padding is Weyl in every $n$ because both its Bianchi and its Ricci contractions close inside the $4$-block. *A first attempt that padded first and projected in dimension $n$ gives a different, non-critical point ($\theta=0.960$, residual $2.2\times10^{-1}$); the order matters and the record's constructor gets it right.*

Numbers in Claim 2's table. Reading them against `779997d`:

- **criticality**: $4.2\times10^{-15}$ at $n=12$ against the commit's $\sim10^{-15}$ ✓. This residual is $\lVert Q(W)-\theta W\rVert$ taken in the ambient space, which is the correct criticality test **only because $Q$ preserves $\mathrm{Weyl}_n$**, Claim 1's structural check, which the record uses everywhere without stating.
- **local maximum**: $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)=0.500000000000$ with **zero** eigenvalues above $\tfrac12$, and exactly $34$ at $\tfrac12$ against orbit dimension $34$ ($=\binom{12}2-\dim(\mathfrak u(2)\oplus\mathfrak{so}(8))=66-32$) ✓, and $18=28-10$ at $n=8$ ✓.
- **Plücker**: $\min\lVert\omega\wedge\omega\rVert=0.500000$ over the unit circle of the $2$-dimensional $-0.408248$ eigenspace, scanned at $2\times10^5$ angles plus random starts ✓.

**Is it the right criterion?** Yes, and the second half of the test is what makes it so. $\lambda_{\max}(L_e\mid W^\perp)\le\tfrac12$ alone is only *necessary*, a negative semidefinite Hessian does not give a local maximum. What upgrades it here is that the $\tfrac12$-eigenspace is **exactly** the orbit tangent: orbit directions lie in it automatically by $O(n)$-equivariance, so $\text{orbit}\subseteq E(\tfrac12)$, and the measured dimensions coincide, forcing equality. $P$ is constant along the orbit, so the Hessian is negative **definite** transverse to a critical manifold, Morse–Bott, hence a genuine local maximum. The commit's phrasing (*"max spec … equal to $1/2$ with no eigenvalue above"*) states the necessary half; the sufficient half is the dimension match it also reports, and it should say that is what carries the conclusion.

**And the closure's inference is sound.** Since the same second-order and Plücker data occur at a point that is *not* the maximiser, no argument reading only that data at a maximiser can exclude an obstructed eigenspace. `779997d` is right, r284 is right, and I reproduce every number.

## Claim 5, the mechanism route D left

**Verdict: the first two sub-claims hold with a caveat the file suppresses; the third (the "useful implication"), is FALSE, and I have the witness.**

### (i) "every one-positive/two-negative element is Plücker-obstructed", conditional on an open clause

The argument in [stratum-two-negative.md](../findings/stratum-two-negative.md) runs: Ricci-flatness gives $\lambda_1v_1v_1^{\mathsf T}=av_2v_2^{\mathsf T}+bv_3v_3^{\mathsf T}$ with all three terms PSD, so the support is $\mathop{\mathrm{im}}v_1$ of even dimension $r$; **at $r=4$** the negative eigenvectors form an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$, and every nonzero self-dual bivector on $\mathbb R^4$ has $\omega\wedge\omega=\lvert\omega\rvert^2\mathrm{vol}\ne0$, so the $2$-plane contains no decomposable. That is a clean proof, **at $r=4$**.

The file's own equality clause says the reduction to $r=4$ is *"reduced but not closed"*: it is equivalent to *"no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ exists for even $r\ge6$"*, and that is **excluded numerically at $r=6,8,10$, with $r\ge12$ untested**. [diagonality.md](../findings/diagonality.md) promotes the conclusion to *"an unrecorded theorem"* without carrying the condition. It is a theorem at $r=4$ and a numerically-supported conjecture above it.

### (ii) "no maximiser lies in that stratum", CONFIRMED, for $n\ge12$

$\theta\le\sqrt{3/2}$ on the stratum is proved and dimension-free, and $\sqrt{3/2}=1.224745<1.236033=\theta_0(12)$, so no maximiser sits there from $n=12$. The bound's own proof is sound as far as the $(+--)$ block and the pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ go, and the file records that the cap is saturated **identically** on the stratum, which is stronger than it needs.

### (iii) "so the useful implication is Plücker-obstructed $\Rightarrow\theta\le\sqrt{3/2}$", REFUTED

**First, it is a converse error.** What the material proves is

$$(\text{one positive, two negative})\Rightarrow\theta\le\sqrt{3/2},\qquad(\text{one positive, two negative})\Rightarrow\text{Plücker-obstructed}.$$

$A\Rightarrow B$ and $A\Rightarrow C$ do not give $B\Rightarrow C$. The file writes *"the implication D2 needed all along is not a second-order argument but Plücker-obstructed $\Rightarrow\theta\le\sqrt{3/2}$"*, presenting a strictly larger hypothesis class as though the stratum's proof reached it.

**Second, the larger class is almost everything.** The obstruction has no criticality and no unit-norm hypothesis, the file's own domain column says so. A $W$ with simple spectrum has $\binom n2$ one-dimensional eigenspaces, each spanned by a bivector that is generically non-decomposable. So **Plücker obstruction is a generic property of $\mathrm{Weyl}_n$**, and the proposed implication asserts $\theta\le\sqrt{3/2}$ on a dense open set, which is false, since $\theta_0(n)>\sqrt{3/2}$ for $n\ge12$ and $\theta$ is continuous.

**Third, the witness** ([c5_plucker_generic.py](../scripts/reviewers/r285/c5_plucker_generic.py)). Perturb the balanced sphere product at $n=12$ along a random unit direction of $\mathrm{Weyl}_{12}$ and renormalise:

| $\varepsilon$ | $\theta$ | $>\sqrt{3/2}$ | min eigenvalue gap | $\min_k\lVert\omega_k\wedge\omega_k\rVert$ |
|---|---|---|---|---|
| $10^{-3}$ | $1.236031177$ | ✓ | $2.3\times10^{-6}$ | $0.495042$ |
| $10^{-2}$ | $1.235847895$ | ✓ | $6.8\times10^{-6}$ | $0.437080$ |
| $3\times10^{-2}$ | $1.234370544$ | ✓ | $2.3\times10^{-5}$ | $0.487442$ |
| $5\times10^{-2}$ | $1.231356944$ | ✓ | $3.0\times10^{-5}$ | $0.529080$ |

All $66$ eigenvalues are simple, so every eigenspace is a line; every one of those $66$ lines has $\lVert\omega\wedge\omega\rVert\ge0.44$, so **every eigenspace is Plücker-obstructed** (a far stronger obstruction than the single obstructed eigenspace the criterion asks for) while $\theta$ stays above $\sqrt{3/2}=1.224745$ at every step. All points are Weyl to $3\times10^{-15}$. *(By contrast the unperturbed sphere product is not obstructed at all: its two eigenspaces, of dimensions $36$ and $30$, contain $36$ and $30$ coordinate bivectors respectively.)*

**Fourth, even if it were true it would not close the conjecture.** [diagonality.md](../findings/diagonality.md) claims it *"would close the conjecture from $n=12$ directly, the non-diagonal locus being exactly where the obstruction lives."* Plücker is **sufficient, never necessary** for non-diagonalisability, the file says exactly that in its instrument table, and r283 and r284 both confirm it. So $\{\text{non-diagonalisable}\}\supsetneq\{\text{Plücker-obstructed}\}$, and a bound valid on the obstructed set leaves the non-diagonalisable-but-unobstructed points untouched. The clause inverts the direction stated three paragraphs above it in the same file.

**Is it fenced?** The question is moot, the implication is false. Had it been true it would have been a bound on $\theta$ over a generic subset of $\mathrm{Weyl}_n$, i.e. a bound on $\theta$ on $\mathrm{Weyl}_n$ up to closure, so **every** $\theta$-fencing post would have applied to it, not merely "the posts apply" as the file allows. *What survives from route D is the stratum lemma, which was already on file.*

## Claim 6, the sweep, and the index

### The index is complete for $259$–$284$

`c3ac30d` landed the five rows. [reviews/INDEX.md](INDEX.md) now carries a row for every reviewer $259$ through $284$ and every one has a file on disk; I checked both directions. Ordering is untidy ($274$ sits below $269$, and $265/266$, $263/264$, $259/260$ are each transposed) which is cosmetic. **r279's, r281's, r282's and r283's repeated filing is discharged.**

### Four items still live in the tree

| item | filed by | state today |
|---|---|---|
| [second-order.md:206](../findings/second-order.md) still reads *"What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$"* | r278, r279, r280, r283 | **live**, verbatim, at the fourth asking |
| [sym3-blocks.md](../findings/sym3-blocks.md) contradicts itself twelve lines apart: *"THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM"* against *"On the restricted space the argument does not carry, and the rank is open in $[1,13]$"* | r282 | **live** |
| [sym3-blocks.md](../findings/sym3-blocks.md)'s closing heading is still *"What the certificate **would** establish"* over a decided section | r280, r281, r282, r283 | **live** |
| the total-symmetry ingredient behind $\langle A_i,Q(A_j)\rangle=0$ | r281, r283, r284 | **live**, [support-dichotomy.md](../findings/support-dichotomy.md) contains no occurrence of "symmetr" |

### And one contradiction inside a single row

[FINDINGS.md:19](../findings/INDEX.md) says of the diagonal case: *"**Now proved outright at every $n\ge4$, odd included**"* and, in the same row, *"Odd $n$ open"*. [plan.md](../plan.md) takes the second reading (*"odd $n$ remains conjectural even in the diagonal case"*) and [diagonality.md](../findings/diagonality.md) takes it too, while [problem.md](../findings/problem.md) heads the same result *"CANDIDATE … Gate 2 owed"*. **r283 filed this against route D's $n$-range clause and it is unrepaired.** It matters for both live routes: route D's payoff and route F's target set are stated in terms of which $n$ the diagonal case covers.

### Nothing else from r259–r284 is unapplied

The r259–r268 verdicts are in [plan.md](../plan.md)'s validation ledger with their validating reviewers named. r275/r276 (route M, post F34's excess formula), r277/r278 (route S, the diagonal grant), r279–r282 (the $\circ$-indecomposability theorem, $\Theta_5$, the padding dichotomy) are folded into [support-dichotomy.md](../findings/support-dichotomy.md), [09-status.tex](../report/sections/09-status.tex) and the standing-state list. r283/r284's route-D verdicts are in [diagonality.md](../findings/diagonality.md) and the Lemma L66 move is done in the report.

---

## What I would change

1. **Name the fault in [scripts/weyl.py](../scripts/weyl.py)**, in the file itself: `Q_general` returns a $Q$ whose off-diagonal part in $R$'s eigenbasis is zero, so it is safe for $P$ and for nothing else. Its docstring warns about polarization; the gradient pairing is the same trap under a different name and cost a cycle.
2. **Rewrite F1's warrant.** The identity holds; the evidence recorded for it does not support it. Record the non-critical finite-difference check, the analytic one-line symmetry proof from total antisymmetry of $c$, and the fact that $\mathrm{Weyl}_n$ is $Q$-invariant, which is what makes the flow well-posed and is nowhere claimed.
3. **Withdraw F's stated theorem or restate it.** As written it is circular. If a non-circular version exists it must say which cone, and the cone the record knows about ($\Omega_0$) has an invariance strictly stronger than the goal.
4. **Delete the blanket fence clearance.** F3 produces a bound on $\theta$; the posts must be checked against F's mechanism one by one, and the grade recomputed after.
5. **Strike *"Plücker-obstructed $\Rightarrow\theta\le\sqrt{3/2}$"* from [diagonality.md](../findings/diagonality.md) and [plan.md](../plan.md)**, it is false, with a witness. What route D leaves behind is the stratum lemma and nothing more.
6. **Carry the $r=4$ condition** with the "every one-positive/two-negative element is Plücker-obstructed" statement, since the reduction to $r=4$ is the file's own open equality clause.
7. **Fix [FINDINGS.md:19](../findings/INDEX.md)**, which asserts and denies the odd-$n$ diagonal case in one row.

## Outside the brief

- **$\mathrm{Weyl}_n$ is $Q$-invariant**, measured to $3\times10^{-16}$ at $n=6,8$: Bianchi by Hamilton's lemma, and the Ricci trace of $Q(R)$ vanishes when $\mathrm{Ric}(R)$ does. The record uses this silently in `crit_residual`, in every Hessian, and now in route F's premise. It deserves a line in [findings/](../findings/) with its two-step reason.
- **The trilinear symmetry of $\#$ has a one-line proof** from total antisymmetry of the structure constants, in the form $\langle X\#Y,Z\rangle=\tfrac12c_{pqa}c_{rsb}X_{pr}Y_{qs}Z_{ab}$. [problem.md](../findings/problem.md) records it as *"a theorem, [BW08](../references/boehm-wilking-2008-space-forms/) eq. (5), and both reviewers re-derived it"* and then as *"not load-bearing"* in its own context. For F1 it **is** load-bearing, and only in the slot-1-to-slot-3 direction.
- **The Plücker instrument measures a generic property.** At every point the record quotes it on, the obstructed eigenspace is special; at a random Weyl tensor *all* $\binom n2$ eigenspaces are obstructed. Any instrument row for it should say that its information content is "this point is not exceptional", which is the opposite of how the three quoted values read.


---

## Index-row summary, preserved

*The REVIEW.md index row carried figures not repeated in this report; kept verbatim.*

ROUTE F's GRADIENT IDENTITY and route D's closure, commits `10be9f8` (primary) / `384e334` / `779997d` / `c3ac30d`. **The identity is TRUE, the confirming check is vacuous, the fault behind the $2\times10^{-2}$ residuals is NAMED, route F's stated theorem is CIRCULAR, and the mechanism route D left behind is REFUTED BY A WITNESS.** *Claim 1*: $\#$ is fully trilinearly symmetric on all of $\mathrm{Sym}^2(\Lambda^2)$, one line from total antisymmetry of $c$, in the form $\langle X\#Y,Z\rangle=\tfrac12c_{pqa}c_{rsb}X_{pr}Y_{qs}Z_{ab}$, and the load-bearing half is the slot-$1$-to-slot-$3$ transposition, not the easy $X\!\leftrightarrow\!Y$ one. **`10be9f8`'s check cannot distinguish the identity from a false one**: at a critical point $\langle Q(W),V\rangle=\theta\langle W,V\rangle=0$ for every tangential $V$, so the prediction is $0$ under $\nabla P=cQ(W)$ for *every* $c$, and the commit's own numbers, measured $-8.9\times10^{-10}$ against predicted $-1.6\times10^{-32}$, are $22$ orders apart. A test with content, random **non**-critical $W$, criticality residual $0.4$–$0.5$, confirms the identity at relative error $10^{-11}$–$10^{-13}$ at $n=6,8$. **THE FAULT IS [Q_general](scripts/weyl.py)**: it assembles $Q$ from the diagonal of $R^\#$ in $R$'s own eigenbasis, so $\lVert Q_{\rm true}-Q_{\tt general}\rVert$ equals the discarded off-diagonal mass to every digit, $P$ is exact to $10^{-16}$ (a diagonal pairing) and $3\langle Q(W),V\rangle$ is wrong by $1.2\times10^{-2}$–$8.0\times10^{-2}$ at $n=8$, the reported band. The directions were never the problem; the $Q$ on the right-hand side was, and the docstring's own "UNSAFE FOR POLARIZATION" warning covers it. **And the step the plan never states holds**: $\mathrm{Weyl}_n$ is $Q$-invariant (off-Weyl mass $3\times10^{-16}$), so the flow is tangent and $\nabla P=3Q(W)$ needs no projection. *Claim 2*: along $\dot W=Q(W)$, $\dot\theta=3(\lVert Q\rVert^2\lVert W\rVert^2-P^2)/\lVert W\rVert^5\ge0$ with equality iff critical, so every local maximum is an attractor, and **at $n=12$ there are at least two**: the balanced sphere product ($\theta=1.236033081183$) and padded $W_{\mathbb{CP}^2}$ ($1.224744871392$), both with $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)=\tfrac12$, zero eigenvalues above, and null space exactly the orbit. **F's falsifier cannot fire**; F2 must rank the attractors, which is Conjecture A verbatim. *Claim 3*: **the target theorem is circular**, invariance constrains points *inside* the cone, so $C\cap S\subseteq\{P\le\theta_0\}$ gives the conjecture only if $C=\mathrm{Weyl}_n$, where invariance is vacuous; for a proper cone the sphere-product ray itself satisfies the statement. **plan.md's fence clearance is false at F3**, which is literally *"cone $\Rightarrow$ the bound"*. And the route is not new: [problem.md](findings/problem.md) carries Beitz's $\Omega_a$, the bridge that makes $\theta_0(n)^2$ *"what cone invariance at $a=0$ requires"*, and the price, *"the full cone conjecture is strictly more than Conjecture A"*. *Claim 4*: **both halves reproduce independently at $n=8$ and $n=12$**, $\theta=1.224744871392$, criticality $\le4.2\times10^{-15}$, $\max\mathop{\mathrm{spec}}(L_e\mid W^\perp)=0.500000000000$ with $0$ above and $18/34$ at $\tfrac12$ against orbit dimensions $18/34$, Plücker $0.500000$ on the $2$-dimensional $-0.408248$ eigenspace. The criterion is right, and it is the **dimension match**, not the semidefiniteness, that upgrades it to a local maximum (Morse–Bott). *Claim 5*: **REFUTED.** *"Plücker-obstructed $\Rightarrow\theta\le\sqrt{3/2}$"* is a converse error ($A\Rightarrow B$, $A\Rightarrow C$, therefore $B\Rightarrow C$) and it is **false**: the obstruction is generic, and a perturbed balanced sphere product at $n=12$ has $66$ simple eigenvalues with every eigenline at $\lVert\omega\wedge\omega\rVert\ge0.44$ while $\theta$ runs $1.231357$–$1.236031$, all above $\sqrt{3/2}=1.224745$. Even if true it would not close the conjecture, Plücker being *sufficient, never necessary*, the clause inverts the instrument table three paragraphs above it. And *"every one-positive/two-negative element is Plücker-obstructed"* is a theorem at $r=4$ only, resting on the file's own open equality clause ($r\ge12$ untested). *Claim 6*: **the index is complete for $259$–$284$**, `c3ac30d` discharged four filings. Four items stay live: [second-order.md:206](findings/second-order.md) at the fourth asking, [sym3-blocks.md](findings/sym3-blocks.md)'s rank contradiction and its *"would establish"* heading, and the total-symmetry ingredient absent from [support-dichotomy.md](findings/support-dichotomy.md); plus **[FINDINGS.md:19](../findings/INDEX.md) asserts and denies the odd-$n$ diagonal case in one row**
