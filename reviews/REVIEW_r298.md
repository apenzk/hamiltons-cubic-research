# Reviewer 298, $\Delta$ as orbit-motion mass, the route it closes, and the dimension screen

Cold adversarial audit of the four claims in the brief. Every number below comes from an implementation written from the definitions in [scripts/reviewers/r298/](../scripts/reviewers/r298/), sharing no code with [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) or [review_r30_core.py](../scripts/lib/review_r30_core.py). The independent $\#$ was derived from the Hamilton structure-constant form $(W^{\#})_{ab}=\tfrac12c_{anm}c_{bpq}W_{np}W_{mq}$ and then checked against the record's $-\tfrac12\operatorname{tr}(A_aWA_bW)$: agreement to $0.0$ at $n=5,6,8$. The Weyl basis was rebuilt from the $4$-tensor Bianchi and Ricci conditions and reproduces $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$ at $n=4,\dots,8$.

| claim | verdict |
|---|---|
| **F1**, $g_\gamma$ is the orbit-tangent norm; total $4(n-1)$ constant on $\mathrm{Weyl}_n$ | **CONFIRMED** |
| **F2**, every orbit direction is an exact $\tfrac12$-eigenvector of $L_e$ | **CONFIRMED** (and it holds off $\mathrm{Weyl}_n$ and at $\theta<0$) |
| **F3**, the second-order route through $\Delta$ is closed | **CONFIRMED**, with a scope correction: what is proved is that $\Delta$ cannot supply the violating direction. The literal sentence "the inference CANNOT work" is only **PLAUSIBLE**, the implication $\Delta>0\Rightarrow$ not a maximiser is untouched by the argument and holds at every point computed |
| **F4**, the dimension screen, and $\Delta>0$ generic in the band | **REFUTED.** The inequality $\dim\mathcal O\le\dim\mathfrak m+\dim\ker W$ is CONFIRMED; the contrapositive as written and the genericity consequence are both refuted, the latter at its own worked example |

---

## F1, CONFIRMED, as an exact identity with no factor and no projection

$g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert_F^2$ holds to machine precision, not merely up to a constant. Written out: with $\{v_a\}$ the orthonormal eigenbasis of $W$, $\langle v_a,[\mathrm{ad}(x),W]v_b\rangle=(\lambda_b-\lambda_a)c_{xab}$, so the Frobenius norm of the commutator is $\sum_{ab}(\lambda_a-\lambda_b)^2c_{\gamma ab}^2$, which is the record's $\sum_{ab}(\lambda_a-\lambda_b)^2T_{\gamma ab}$ because the $\tfrac12$ inside $T$ is exactly the factor that turns $\operatorname{tr}(X^{\!\top}Y)$ into the metric $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\!\top}Y)$ in which the $\phi_{ij}$ are orthonormal. Measured $\max_\gamma\lvert g_\gamma-\lVert[\mathrm{ad}(v_\gamma),W]\rVert_F^2\rVert$:

| population | worst deviation |
|---|---|
| seven catalogued critical points | $\le3.6\times10^{-15}$ |
| six random **non-critical** $\mathrm{Weyl}_n$ tensors, $n=5,6,7$ | $\le6.2\times10^{-15}$ |
| generic symmetric operators **off** $\mathrm{Weyl}_n$, incl. diagonal and rank one | $\le2.7\times10^{-15}$ |

So the identification needs neither criticality nor Weyl-ness, it is linear algebra about $x\mapsto[\mathrm{ad}(x),W]$.

**The total.** $\sum_\gamma g_\gamma=4(n-1)$ to ten digits at $n=4,5,6,7,8$ on random $\mathrm{Weyl}_n$ tensors, and it **fails off** $\mathrm{Weyl}_n$ ($11.28$ against $16$ at $n=5$; $16.76$ against $20$ at $n=6$). This matches what [target.md](../findings/target.md) already records, the constancy is a $\mathrm{Weyl}_n$ identity, not a criticality one. It also holds at $n=4$, where fence post F18's $n\ge5$ caveat concerns the *separate* traces over $\Lambda^2_\pm$, not the total.

**One wording caveat.** "Share of the orbit motion" is a ratio, and $\Delta$ is not one, it is the trace of $g$ over $\mathfrak p$, i.e. $\lVert x\mapsto x\!\cdot\!W\rVert_{HS}^2$ restricted to $\mathfrak p$, against a fixed total. Reading it as a fraction $\Delta/4(n-1)$ is legitimate only because the total is constant, which is itself a theorem being invoked. The claim states this correctly; the risk is downstream paraphrase.

*Sign note, cosmetic:* [orbit_tangent](../scripts/lib/review_r30_core.py) returns $[A_a,W]$ while $\mathrm{ad}(\phi_a)=-A_a$ (verified: $\lVert\mathrm{ad}+A\rVert=0$), so the returned array is $-[\mathrm{ad}(\phi_a),W]$. Span and norms are unaffected; nothing in the record depends on it.

---

## F2, CONFIRMED, and with weaker hypotheses than claimed

The derivation is right and I reproduce it independently. $Q$ is $O(n)$-equivariant on the whole of $\mathrm{Sym}^2(\mathfrak{so}(n))$, so differentiating $Q(e^{tX}\!\cdot\!W)=\theta\,e^{tX}\!\cdot\!W$ at a critical point gives $DQ(W)[z]=\theta z$ for $z=X\!\cdot\!W$; and $Q$ being quadratic, $DQ(W)[H]=2\,W\!\circ\!H$, hence $L_ez=\tfrac12z$.

Measured $\max\lVert L_ez-\tfrac12z\rVert$ over an orthonormal basis of the whole orbit tangent:

| point | $n$ | $\theta$ | $\dim\mathcal O$ | deviation |
|---|---|---|---|---|
| $S^3\times S^3$ | 6 | $1.054093$ | 9 | $1.4\times10^{-16}$ |
| $S^3\times S^5$ | 8 | $1.115547$ | **15** | $2.6\times10^{-16}$ |
| $S^5\times S^5$ | 10 | $1.200000$ | 25 | $1.7\times10^{-16}$ |
| $\mathbb{CP}^2$ | 4 | $1.224745$ | 2 | $3.3\times10^{-16}$ |
| $\mathbb{CP}^3$ | 6 | $1.054093$ | **6** | $3.9\times10^{-15}$ |
| $\mathbb{CP}^4$ | 8 | $0.986013$ | 12 | $4.7\times10^{-15}$ |
| $\mathbb{CP}^2$ padded | 8 | $1.224745$ | 18 | $5.7\times10^{-16}$ |
| $C_5$ blow-up | 10 | $0.670820$ | **40** | $2.9\times10^{-16}$ |

The three counts the claim quotes ($15$, $6$, $40$), are exactly right, and $\Delta=12.0000$ at the $C_5$ blow-up.

Answering the brief's four probes:

- **Criticality is load-bearing.** At random *non-critical* $\mathrm{Weyl}_n$ tensors the deviation is $2.55$, $5.63$, $2.75$, $13.98$, not a near miss.
- **Weyl-ness is not needed.** The argument uses only equivariance of $Q$ on $\mathrm{Sym}^2$. Separately, $\mathrm{Weyl}_n$ turns out to be $Q$-closed ($\lVert Q(W)-\Pi Q(W)\rVert\le3.3\times10^{-16}$ at random $\mathrm{Weyl}_n$ tensors, $n=5,6,7$), so the projected and unprojected critical equations coincide and the question is moot in this setting; had they differed, $\Pi$ is equivariant and the argument survives.
- **$\theta>0$ is not needed** for F2 (it is needed for Lemma L24). At a critical point with $\theta=-1.224745$ the orbit directions are still exact $\tfrac12$-eigenvectors ($1.2\times10^{-15}$).
- **The orbit tangent is entirely inside $e^\perp$.** $\langle[\mathrm{ad}(x),W],W\rangle= \operatorname{tr}(\mathrm{ad}(x)W^2)-\operatorname{tr}(W\,\mathrm{ad}(x)W)=0$ by cyclicity, measured $\le6.4\times10^{-17}$ at arbitrary $W$, critical or not. So "the part not in $e^\perp$" is empty; there is nothing there for the claim to have missed.
- **Degeneracy and small orbits change nothing.** $\mathbb{CP}^2$ carries a repeated negative eigenvalue and a $3$-dimensional kernel with $\dim\mathcal O=2$ out of $6$; padded $\mathbb{CP}^2$ has $\dim\mathcal O=18$ of $28$. Both exact.

---

## F3, the mechanism is CONFIRMED, and provable more strongly than the claim argues; the sentence as written overreaches

This is the claim I spent most of the audit on, because it closes the naive route to [plan.md](../plan.md)'s primary open item V1/V2, $\{Q(W)=\theta W,\ S=0,\ \Delta>0\}\Rightarrow\theta\le\sqrt{3/2}$.

### What is true, and stronger than the claim states

The claim argues from an eigenvalue: orbit directions sit at $\tfrac12$, the bound is $\le\tfrac12$, so no violation. The real reason is one line further back, and it is unconditional.

**$P$ is exactly constant along the orbit.** $P(g\!\cdot\!W)=P(W)$ for $g\in O(n)$, measured $\le4.4\times10^{-16}$ over random $g\in SO(n)$ at $S^3\times S^3$ and at the $C_5$ blow-up. So the orbit lies inside the level set $\{P=\theta\}\cap S$, and **every** derivative of $P$ along orbit directions, at every order, is the derivative of a constant. $\Delta$ measures nothing but motion inside that level set.

**And the orbit component of an arbitrary test direction splits off exactly.** $\mathcal O\subseteq E_{L_e}(\tfrac12)$ and $L_e$ is self-adjoint, so $\mathcal O^\perp$ is $L_e$-invariant and for $v=o+x$ with $o\in\mathcal O$, $x\perp\mathcal O$,
$$\langle v,(L_e-\tfrac12)v\rangle=\langle x,(L_e-\tfrac12)x\rangle .$$
Measured over 40 random $v\in e^\perp$: the identity holds to $\le3.3\times10^{-16}$ and the cross term to $\le1.2\times10^{-16}$, at $S^3\times S^3$, $S^3\times S^5$, $\mathbb{CP}^3$ and the $C_5$ blow-up. So a violating direction can never draw any part of its violation from the orbit, not even as a mixed term.

### The one place a "version on a subspace" could have bitten, and it does not

Lemma L24 is not the only condition on file, and the brief is right to ask whether a strict or subspace version exists that $\Delta$ could violate. There is exactly one candidate, and it is aimed precisely at the subspace where the orbit lives: **Krasnov–Tkachev Proposition 6.7**, the third-order fusion rule $\langle z^2,z\rangle=0$ on $A_c(\tfrac12)$. Tested directly:

| point | $\dim\mathcal O$ | $\max\lvert T(z,z,z)\rvert$ over 30 random orbit directions |
|---|---|---|
| $S^3\times S^3$ | 9 | $0.000\times10^{0}$ |
| $\mathbb{CP}^3$ | 6 | $2.3\times10^{-15}$ |
| $C_5$ blow-up ($\Delta=12$) | 40 | $7.2\times10^{-18}$ |

It vanishes identically, as [second-order.md](../findings/second-order.md) already records from stationarity alone ($Bu=z\circ z$). The fourth-order geodesic term is $-\tfrac{3\theta}8<0$ on the whole null cone. So the subspace version is vacuous on the orbit too, at both orders that exist.

**The "second clause" is not a separate lever either.** The brief asks whether $\lambda_{\max}\le\tfrac12$ is the whole of Lemma L24. It is: [the source notes](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) quote Proposition 6.6 as $\sigma(c)\subset(-\infty,\tfrac12]$, "**In particular**, $1$ is a simple eigenvalue", simplicity is a corollary of the bound, not extra content. And the $1$-eigenspace is $L_e$-orthogonal to the $\tfrac12$-eigenspace that contains the orbit, so $\Delta$ cannot reach it either.

### The strongest empirical form of the closure: $\Delta$ carries no second-order information in *either* direction

$\Delta=0$ points straddle the bound. Computed here from the definitions:

| point | $n$ | $\Delta$ | $\lambda_{\max}(L_e\vert_{e^\perp})$ | |
|---|---|---|---|---|
| $S^3\times S^5$ | 8 | $0$ | $0.50000000$ | saturates |
| $S^2\times S^6$ | 8 | $0$ | $0.60000000$ | **violates** |
| $S^2\times S^4$ | 6 | $0$ | $0.66666667$ | **violates** |
| $\mathbb{CP}^3$ | 6 | $0$ | $0.62500000$ | **violates** |
| $\mathbb{CP}^4$ | 8 | $0$ | $0.60000000$ | **violates** |
| $C_5$ blow-up | 10 | $12$ | $1.20601133$ | **violates** |

So $\Delta=0$ neither implies nor is implied by the second-order condition, and the one $\Delta>0$ point violates it for reasons visible in the symmetric directions. On the record's own catalogue $\Delta$ has **zero discriminating power** for Lemma L24. That is the empirical statement F3 is reaching for, and it is both true and checkable, unlike "the inference cannot work".

### The search for the refuting point, and what it returned

A refutation of the *implication* would be a critical point with $\Delta>0$ satisfying $\lambda_{\max}\le\tfrac12$. I solved the criticality system $\langle B_a,Q(W)-\theta W\rangle=0$, $\lVert W\rVert=1$ on the whole of $\mathrm{Weyl}_6$ with an exact Jacobian $DQ(W)[H]=WH+HW+2\,\#(W,H)$ from random starts, screening every solution against the full residual:

| $\theta$ | $\Delta$ (of $20$) | $\dim\mathfrak m$ | $\ker$ | $\lambda_{\max}(L_e\vert_{e^\perp})$ |
|---|---|---|---|---|
| $-0.185058$ | $13.234$ | 6 | 0 | $3.363$ |
| $-0.091388$ | $11.287$ | 7 | 0 | $6.990$ |
| $+0.108100$ | $8.487$ | 8 | 0 | $5.650$ |
| $-0.120922$ | $11.502$ | 7 | 0 | $5.137$ |
| $+0.091388$ | $8.713$ | 8 | 0 | $6.990$ |
| $+0.137670$ | $8.354$ | 8 | 0 | $4.563$ |

Six of six carry $\Delta>0$ and violate by a factor of at least $9$, consistent with Observation L25's range and with no refuting point in it. One further solve on the graded block-diagonal space over $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ at $n=8$ (dimension $155$) converged, at $\theta=-0.088829$, $\Delta=15.845$, $\dim\mathfrak m=13$, $\lambda_{\max}=6.119$, seven for seven, and still no refuting point.

**The one number still missing.** That $n=8$ sweep did not reach the $\theta=1.088948$, $\Delta=1.512231$ witness inside this audit's compute budget, three starts, one convergence, and that one at $\theta<0$ where Lemma L24 has no content. Since [Reviewers 295 and 296](../findings/target.md) have established that the witness is **graded** and is a **saddle**, it is now the record's only high-$\theta$ $\Delta>0$ point, and $\lambda_{\max}(L_e\vert_{e^\perp})$ there is the single most informative number outstanding on this item. It is cheap to produce from the witness's own coordinates, which that solve already has and does not persist.

### Where the claim overreaches

**"A large $\Delta$ piles directions up AT the bound" is false as stated.** $\Delta$ is a mass, not a count, and the count of directions at the bound is $\ge\dim\mathcal O$, which is fixed by the isotropy and is *not* a function of $\Delta$:

| point | $\Delta$ | $\dim\mathcal O$ | $\operatorname{mult}(\tfrac12)$ on $e^\perp$ |
|---|---|---|---|
| $S^3\times S^5$ | $0$ | 15 | 15 |
| $S^5\times S^5$ | $0$ | 25 | 25 |
| $\mathbb{CP}^2$ padded to $n=8$ | $0$ | 18 | 18 |
| $C_5$ blow-up | $12$ | 40 | 60 |

Twenty-five directions sit exactly at the bound at $S^5\times S^5$ with $\Delta=0$. What $\Delta>0$ adds is only that *some* of the pile is generated by $\mathfrak p$ rather than by $\mathfrak m\oplus\ker W$; it adds no direction and raises no multiplicity. The correct sentence is the one the mechanism supports: **every direction $\Delta$ sees is at exactly $\tfrac12$, whatever $\Delta$'s size.**

**"The inference CANNOT work" is stronger than the argument delivers.** What is established is that no argument deriving second-order failure *from the directions $\Delta$ measures* can work. That is not the same as the implication $\Delta>0\Rightarrow$ not a local maximum being false or unprovable, it could still be true, and proved through structure rather than through $g$. On the record's own evidence the implication holds at every point ever computed: the $155$ converged $n=6$ critical points of [Observation L25](../findings/second-order.md) all have $\lambda_{\max}\in[1.17,96.3]$, and the one catalogued $\Delta>0$ point, the $C_5$ blow-up, has $\lambda_{\max}=1.20601133$. **I found no critical point with $\Delta>0$ and $\lambda_{\max}\le\tfrac12$**, which would have refuted the implication outright and made the closure airtight. So F3 closes a *mechanism*, and the record should say so; as a claim about the implication it is unsupported in the strong direction.

### "Failures come from somewhere else", CONFIRMED, and the somewhere else is nameable

That half is true for a trivial reason (eigenvectors at $\lambda\ne\tfrac12$ are orthogonal to the $\tfrac12$-eigenspace), but it is worth more than triviality once located. Decomposing the top eigenvector $v$ of $L_e|_{e^\perp}$ against the orbit tangent and against the **symmetric** directions $H_A=D_AW+WD_A$, $A\in\mathrm{Sym}_0(\mathbb R^n)$, the $GL(n)/O(n)$ metric deformations:

| point | $\lambda_{\max}$ | $\lVert P_{\text{orbit}}v\rVert^2$ | $\lVert P_{\text{symmetric}}v\rVert^2$ |
|---|---|---|---|
| $\mathbb{CP}^3$ | $0.62500000$ | $0.000000$ | $\mathbf{1.000000}$ |
| $\mathbb{CP}^4$ | $0.60000000$ | $0.000000$ | $\mathbf{1.000000}$ |
| $C_5$ blow-up | $1.20601133$ | $0.000000$ | $0.421795$ |

At $\mathbb{CP}^{3,4}$ the violating direction is **entirely** a metric deformation, and at the $C_5$ blow-up a single random $H_A$ already gives Rayleigh quotient $0.5658>\tfrac12$. This is the structural point the record should take from F3: $\Delta$ is built from $\mathrm{ad}(v_\gamma)$, i.e. from the **skew** half of $\mathfrak{gl}(n)$, which is exactly the half on which every variational statement is vacuous; the working second-order instrument already in the tree ([run_defect_instability_trace.py](../scripts/runs/run_defect_instability_trace.py), the $\operatorname{tr}_{GL}$ condition) traces the Hessian over the **symmetric** half. A defect built the same way over $\mathrm{Sym}_0(\mathbb R^n)$ instead of over $\mathfrak p\subset\mathfrak{so}(n)$ is the object that would not be vacuous, that is the constructive content of F3, and it is not in the record.

### Is F3 vacuous?

No. The route it closes is the natural completion of the programme's primary item: $\Delta=0\Rightarrow$ graded is proved and the graded half is settled, so "$\Delta>0\Rightarrow$ not a maximiser" would close the target outright. Anyone reading "$\Delta$ is a defect, defect implies instability" would reach for exactly this. Recording that it cannot be reached through the orbit is worth its place, provided the scope above is written into the sentence.

---

## F4, the inequality is CONFIRMED; the contrapositive as written is REFUTED; the genericity consequence is REFUTED at its own example

### The inequality, CONFIRMED

$\Delta=0\Rightarrow\mathfrak p\subseteq\mathfrak k(W)$, and since $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m\oplus\ker W$ as an eigenspace decomposition with $\dim\mathfrak k=\binom n2-\dim\mathcal O$, the chain $\dim\mathfrak p\le\dim\mathfrak k\Rightarrow\dim\mathcal O\le\dim\mathfrak m+\dim\ker W$ is a two-line count and correct. Measured at eleven points, computing $\dim\mathcal O$ as the rank of $\{[\mathrm{ad}(\phi_a),W]\}$ rather than quoting an isotropy dimension:

| point | $n$ | $\dim\mathfrak p$ | $\dim\mathfrak m$ | $\dim\ker$ | $\dim\mathcal O$ | $\dim\mathfrak k$ | $\Delta$ |
|---|---|---|---|---|---|---|---|
| $S^3\times S^5$ | 8 | 13 | 15 | 0 | 15 | 13 | $0$ |
| $S^5\times S^5$ | 10 | 20 | 25 | 0 | 25 | 20 | $0$ |
| $\mathbb{CP}^2$ | 4 | **1** | 2 | 3 | 2 | **4** | $0$ |
| $\mathbb{CP}^3$ | 6 | 9 | 6 | 0 | 6 | 9 | $0$ |
| $\mathbb{CP}^2$ padded | 8 | 1 | 2 | 25 | **18** | 10 | $0$ |
| $S^3\times S^3$ padded | 10 | 6 | 9 | 30 | **33** | 12 | $0$ |

$\mathbb{CP}^2$ behaves exactly as the record says: $\dim\mathfrak k(W)=4=\dim\mathfrak u(2)$ against $\dim\mathfrak p=1$, so the equality is false and the inequality holds with slack $3$. Confirmed independently.

### The contrapositive as written, REFUTED

> "a critical point whose orbit is larger than its negative eigenspace must have $\Delta>0$"

drops the $\dim\ker W$ term that the displayed inequality carries. Two counterexamples, both already in the record's own catalogue:

- **padded $\mathbb{CP}^2$ at $n=8$**: $\dim\mathcal O=18>\dim\mathfrak m=2$, and $\Delta=0$.
- **padded $S^3\times S^3$ at $n=10$**: $\dim\mathcal O=33>\dim\mathfrak m=9$, and $\Delta=0$.

The sentence in [bounds.md](../findings/bounds.md) states the contrapositive without the kernel hypothesis and only attaches "with trivial kernel" to the *next* sentence. It needs to read "larger than $\dim\mathfrak m+\dim\ker W$", or carry $\ker W=0$ inside itself. This is the same omission the $\Delta$-lemma header records as caught by Gate 2 ("$\ker W=0$ IS LOAD-BEARING AND WAS OMITTED HERE"), reappearing one paragraph later.

### The genericity consequence, REFUTED at the exact parameters it names

> "at $n=12$ with $\dim\mathfrak m=20$ a $\Delta=0$ point would need an isotropy algebra of dimension
> at least $46$ out of $66$, so $\Delta>0$ is the generic case there"

The arithmetic is right and the conclusion does not follow, because **the demand is met, by a catalogued point**. $S^2\times S^{10}$ at $n=12$:

| | value |
|---|---|
| $\theta$ | $0.994987$, criticality residual $2.0\times10^{-15}$ |
| $\dim\mathfrak m$ | $\mathbf{20}$, inside the band $3\le\dim\mathfrak m<\lfloor144/4\rfloor=36$ |
| $\dim\ker W$ | $\mathbf 0$, the trivial-kernel hypothesis holds |
| $\dim\mathfrak k(W)$ | $\mathbf{46}=\dim(\mathfrak{so}(10)\oplus\mathfrak{so}(2))$ |
| $\Delta$ | $0.000$ |

And the demand is not merely met, it is **rigid**. $\Delta=0$ forces $[\mathfrak p,\mathfrak p]\subseteq \mathfrak p$, so $\mathfrak p$ is a $46$-dimensional subalgebra of $\mathfrak{so}(12)$. The maximal subalgebras of dimension $\ge46$ are $\mathfrak{so}(11)$ ($55$) and $\mathfrak{so}(10)\oplus\mathfrak{so}(2)$ ($46$); the largest proper subalgebra of $\mathfrak{so}(11)$ is $\mathfrak{so}(10)$ at $45<46$, so no $46$-dimensional subalgebra lives there. Hence $\mathfrak p=\mathfrak{so}(10)\oplus\mathfrak{so}(2)$ up to conjugacy, $\mathfrak m=\mathbb R^{10}\otimes\mathbb R^2$, and the only $\Delta=0$ candidate at $(n,\dim\mathfrak m)=(12,20)$ is the symmetric pair of $S^2\times S^{10}$. **So the screen at these parameters is a rigidity statement that names one point, not a genericity statement that excludes a region**, and it excludes nothing, since that point exists and is critical.

**"Generic" also has no measure behind it.** The record's evidence that $\Delta$ is typically positive is random *Weyl tensors* sitting near half the Casimir, and those are not critical (residuals $0.48$–$0.67$ in my own draws), so they cannot speak about critical points. On the catalogue of critical points the count runs the other way: $\Delta=0$ at nine of the ten points in [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py)'s table. That is [fence post F1](../findings/fence-posts.md)'s shape, a sample quoted as evidence that cannot contain the thing being looked for.

**The conclusion may still be true; the argument for it is not.** Among the six converged critical points of my own $\mathrm{Weyl}_6$ sweep (all with $\dim\mathfrak m\in\{6,7,8\}$, inside the band $3\le\dim\mathfrak m<9$), every one carries $\Delta>0$, between $8.35$ and $13.23$ of a total $20$. So "$\Delta>0$ is typical among generic critical points in the band" has direct evidence, and this audit does not contest it. What it contests is the *reason* offered: the dimension screen is not that reason, because the screen's own worked example is satisfied.

*What survives of F4:* the inequality, and the observation that at each band value of $\dim\mathfrak m$ the $\Delta=0$ locus is pinned to subalgebras of $\mathfrak{so}(n)$ of dimension $\binom n2-\dim\mathfrak m$. That is a usable classification handle, for each $(n,\dim\mathfrak m)$ in the band, enumerate the subalgebras of that dimension and the $\Delta=0$ candidates are exhausted. It is the opposite of a genericity claim, and stronger.

---

## What the record should change

1. **[bounds.md](../findings/bounds.md)**, "a large $\Delta$ piles directions up AT the bound" → "every direction $\Delta$ sees sits at exactly $\tfrac12$, whatever $\Delta$'s size". The count at the bound is $\dim\mathcal O$ and is independent of $\Delta$ ($25$ directions at $S^5\times S^5$ with $\Delta=0$).
2. **[bounds.md](../findings/bounds.md)**, "the inference ... CANNOT work" → "$\Delta$ cannot supply the violating direction". The implication itself is untouched by the argument and holds at every critical point on record and at all six found in this audit's own sweep.
3. **[bounds.md](../findings/bounds.md)**, the contrapositive must carry $\ker W=0$ or read "$\dim\mathcal O>\dim\mathfrak m+\dim\ker W$". As written it is refuted by padded $\mathbb{CP}^2$ ($18>2$, $\Delta=0$) and padded $S^3\times S^3$ ($33>9$, $\Delta=0$).
4. **[bounds.md](../findings/bounds.md)**, the genericity sentence must go. Its own example $(n,\dim\mathfrak m)=(12,20)$ is realised by $S^2\times S^{10}$ with $\Delta=0$, trivial kernel, and isotropy exactly $46$. Replace with the rigidity reading: at each band value of $\dim\mathfrak m$ the $\Delta=0$ locus is confined to critical points whose $\mathfrak p$ is a subalgebra of $\mathfrak{so}(n)$ of dimension $\binom n2-\dim\mathfrak m$, which at $(12,20)$ pins $\mathfrak p=\mathfrak{so}(10)\oplus\mathfrak{so}(2)$ uniquely.
5. **Worth adding, and not in the record:** the reason the orbit is vacuous is that $P$ is constant on it, so $\Delta$ (built from $\mathrm{ad}(v_\gamma)$, the *skew* half of $\mathfrak{gl}(n)$), measures the half of the deformation space on which no variational statement can ever bite. The violating directions at $\mathbb{CP}^{3,4}$ are $100\%$ in the *symmetric* half. A defect traced over $\mathrm{Sym}_0(\mathbb R^n)$ is the non-vacuous analogue, and the tree already has an instrument of that shape in [run_defect_instability_trace.py](../scripts/runs/run_defect_instability_trace.py).

## Scope of this audit

Everything above is computed in double precision from independent implementations; no claim rests on a number smaller than $10^{-14}$ being zero. The $\Delta=0\Rightarrow$ gradedness lemma, the $\theta$ values themselves and Observation L25's $155$-point population were **not** re-derived here, they are inputs. The classification step in F4 (that $\mathfrak{so}(10)\oplus\mathfrak{so}(2)$ is the only $46$-dimensional subalgebra of $\mathfrak{so}(12)$ up to conjugacy) uses the standard list of maximal subalgebras and is an argument, not a computation.


