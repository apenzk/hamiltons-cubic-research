# REVIEW r275, Gate 2, route M's $\sqrt3$ cap and the falsifier screen

Reviewer 275. Commits under review: `e5f8cbe` (primary), `72c73d2`/`e84e9af`, `7136a12`/`6b7eae1`.
Primary files: [run_m_falsifier.py](../scripts/runs/run_m_falsifier.py), [plan.md](../plan.md) route M, [fence-posts.md](../findings/fence-posts.md) post F34, [second-order.md](../findings/second-order.md) (the $\circ$-orthogonal sum law, post F11), [ad-form-attempt.md](../findings/ad-form-attempt.md).
Scripts: [scripts/reviewers/r275/](../scripts/reviewers/r275/). Reviewer 276 runs the identical brief concurrently and independently.

Every number below comes from an independent build of the machinery, [r275_geo.py](../scripts/reviewers/r275/r275_geo.py), that imports nothing from [scripts/](../scripts/) and nothing from [scripts/reviewers/r274/](../scripts/reviewers/r274/). It builds $\Lambda^2$ from skew matrices and the structure constants $c_{abg}=\langle[\varphi_a,\varphi_b],\varphi_g\rangle$ directly, and carries **two** implementations of the sharp operator, $(M^\#)_{ab}=\tfrac12c_{apq}c_{brs}M_{pr}M_{qs}$, and the $n^6$ tensor contraction $(A\#B)_{ijkl}=\tfrac12\sum_{p,q}[A_{ipkq}B_{jplq}+B_{ipkq}A_{jplq}]$ antisymmetrised in $k,l$, which agree to $10^{-16}$ at $n=5,6,7$, with the trilinear form $\langle A\#B,C\rangle$ verified fully symmetric (that symmetry is what makes the gradient of $\lVert M^\#\rVert^2$ one more $\#$ evaluation, and it is finite-difference checked to $10^{-12}$). It reproduces $\mathop{\mathrm{tr}}(W^\#)=-1$, first Bianchi, Ricci-flatness, $\theta_0(n)$ at every balanced sphere product, and $\theta=\sqrt{3/2}$ at padded $W_{\mathbb{CP}^2}$.

| # | Claim | Verdict |
|---|---|---|
| 1 | Route M's reduction chain | **REFUTED at link (b), and the repair is false too.** The $1/\sqrt2$ is the harmonic-square law's $1/\sqrt k$, which needs $k\ge2$ $\circ$-orthogonal pieces, it exists **only on decomposables**, which is exactly the set the sum law has already deleted. On the residual the cap gives $\theta\le\sqrt3=1.732$ against $\theta_0(12)=1.236$. And the cap that *would* close it is false at the residual's own sharp case: at padded $W_{\mathbb{CP}^2}$, $n=12$, critical to $1.1\times10^{-16}$, $\dim E(1)=1$ so **indecomposable**, off-diagonal mass $0.7071$ so **non-diagonal**, $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F=1+\tfrac1{\sqrt6}=1.4082483$, over $\sqrt{3/2}$ by $15.0\%$. Links (a), (c) confirmed; (d) is a **grant, not a theorem** |
| 2 | Is the target a rearrangement? | **NO, and that is the problem, not the defence.** At $\sqrt3$ it is strictly weaker than Conjecture A and carries no restatement; post F11's $1+\sqrt2$ floor genuinely does **not** fence it (post F11 fences $\max\mathop{\mathrm{tr}}M^3+\max\lVert M^\#\rVert$, a different quantity, and the joint sup is $\approx1.41$). But **no constant makes it work at any even $12\le n\le354$**: $F$ is padding-invariant, so padded $W_{\mathbb{CP}^2}$ pins $\sup_{\text{residual}}F\ge1+1/\sqrt6=1.408248290464$ at every even $n$, while $\theta_0(n)$ reaches that only at $n=356$. New fence post proposed |
| 3 | The falsifier screen | **REPRODUCED, and it was looking in the wrong place.** Two optimisers sharing no code with r274 give $1.412822,\,1.420489,\,1.425703,\,1.429351$ at $n=6,8,10,12$ against the screen's $1.4128,1.4205,1.4257,1.4294$; no falsifier. (b) $860$ basin-hops across $n=6,8,12$ return exactly three values and twenty seed families agree at $n=12$, so the plateau is very probably global, which cuts *against* route M, since the maximiser is a perturbation of padded $W_{\mathbb{CP}^2}$'s own $(2,-1,-1)/\sqrt6$. (c) the geometric fit gives $1.4375$ and a better-fitting free power law gives $1.4618$: four points do not pin a limit. (d) `rand_weyl` **does** produce genuine trace-free Bianchi Weyl operators. *And the screen looks for $F>\sqrt3$, while the route's break is the inference from the cap, no search over $F$ could have found it* |
| 4 | Post F34's exact excess formula | **REFUTED, the formula is wrong and so is its rate.** The true excess is $\sqrt{\tfrac{m-1}{2m-1}}\big/\big(u+\sqrt{u^2+m^2-m}\big)$, matching the measured value to $12$ digits at $n=6\dots16$; post F34's has $\tfrac m{2m-1}$ where $\sqrt{\tfrac{m-1}{2m-1}}$ belongs, and understates the excess by $m/\sqrt{(2m-1)(m-1)}\to1/\sqrt2$. Asymptotically the excess is $\tfrac1{\sqrt2 n^2}$, not $\tfrac1{2n^2}$. Cause: a $\sqrt{mE}$-for-$\sqrt E$ slip in [ad-form-attempt.md](../findings/ad-form-attempt.md)'s $\lVert M^\#\rVert_F$ |
| 5 | Route N's premise (Nienhaus 4.17 at $n=12$) | **THE FLIP IS STRUCTURAL, and it is an identity, not a slack estimate.** Nienhaus's closing quantity at the binding endpoint $\alpha=1/3$ is *identically zero* when the cap is $c=1$, and its sign is **exactly** $\mathop{\mathrm{sign}}(c-1)$, i.e. exactly the statement "$W_{\mathbb{CP}^2}$ has stopped being the global maximizer", which happens at $\theta_0(n)=\sqrt{3/2}$, $n=6+2\sqrt7$. No sharpening of *that* estimate can survive $n\ge12$. The damage is confined to $\alpha\in[0.3223,1/3]$ at $n=12$ and $[0.3025,1/3]$ at $n=14$ (reproducing the ledger's own two numbers to four digits) so a repair by a second bound is possible, and one is on file. Route N inherits the circularity: the cap $c$ is where Conjecture A enters |
| 6 | The validation ledger | **r260 VALIDATED, with more structure than it reported.** Independent enumeration of all $11!!=10395$ matchings: $8667$ carry an intra-tensor pair and give the **identically zero** form (trace-freeness), leaving $1728$; those have rank exactly $\mathbf2$ at $n=6,7,8$, with a spectral gap of $14$ orders ($\sigma_2\approx3$–$5$, $\sigma_3\approx10^{-14}$); and every one of the $1728$ lies in $\mathop{\mathrm{span}}\{\mathop{\mathrm{tr}}(W^3),\langle W^\#,W\rangle\}$ to $10^{-15}$ |

---

## Claim 1, route M's reduction chain

Evidence: [r275_c1_chain.py](../scripts/reviewers/r275/r275_c1_chain.py).

[plan.md](../plan.md) states the chain as: *$\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\le\sqrt3$ on $\circ$-indecomposable unit Weyl operators, hence $M(n)\le\sqrt3$, hence every non-diagonal critical point has $\theta\le\sqrt{3/2}<\theta_0(n)$ for $n\ge12$, hence Conjecture A, the diagonal case being granted.* Four links.

### (a) The sum law does reduce to indecomposables, and it is the source of the trouble

**Confirmed as stated.** [second-order.md](../findings/second-order.md) derives it in two lines from $Q(aA+bB)=a^2Q(A)+2ab(A\circ B)+b^2Q(B)$: if $W=\sum_ia_iA_i$ with the $A_i$ pairwise $\circ$-orthogonal and each critical, criticality forces $a_i\theta_i=\theta$, and $\sum a_i^2=1$ gives

$$\frac1{\theta^2}=\sum_{i=1}^k\frac1{\theta_i^2},\qquad\text{hence}\qquad |\theta|\le\frac{\max_i|\theta_i|}{\sqrt k}\quad (k\ge2).$$

Hypotheses, all named and all needed: the pieces are $\circ$-orthogonal, **each is itself critical**, $k\ge2$, and every $\theta_i\ne0$.

*One of those is part of the definition rather than a consequence, and M1 should say so.* The step $Q(aA+bB)=a^2\theta_AA+b^2\theta_BB$ presumes $Q(A)=\theta_AA$; criticality of $W$ does **not** by itself force criticality of a $\circ$-orthogonal summand. The record proves the implication only in the *block* case ([target.md](../findings/target.md): *"$Q$ maps block-supported operators into the same block, so criticality of the sum forces criticality of each summand rather than assuming it"*), and $\circ$-orthogonality is strictly weaker than disjoint blocks, that is the whole point of the section. So "$\circ$-decomposable" means *"splits into $\circ$-orthogonal **critical** pieces"*, and "$\circ$-indecomposable" is its negation. That reading is self-consistent and the $\dim E(1)$ test certifies exactly it, but it is a definition being carried as if it were a theorem, and M1 asks for every hypothesis named. Under them the sup over critical points is attained at a $\circ$-indecomposable one, so the residual is the $\circ$-indecomposable non-diagonal points. The decidability criterion ($\dim E(1)=1\Rightarrow$ indecomposable) is correct: every $\circ$-summand satisfies $A_i\circ W=a_iQ(A_i)=\theta A_i$, so it lies in $E(1)$ of $L_e$. Reproduced here, $\dim E(1)=1$ at padded $W_{\mathbb{CP}^2}$ and at $S^6\times S^6$, over the full $1638$-dimensional $\mathrm{Weyl}_{12}$.

### (b) The $\sqrt2$, REFUTED

**The $1/\sqrt2$ is $1/\sqrt k$ at $k=2$, and nothing else.** It appears in [second-order.md](../findings/second-order.md) one paragraph after the harmonic-square law, in the same breath as the reduction: *"the residual narrows to $\circ$-indecomposable non-diagonal $S=0$ points … What the cap needs is $|\theta|\le M(n)/\sqrt2\le\sqrt{3/2}$."* The two sentences cannot both be used. $|\theta|\le\max_i|\theta_i|/\sqrt k$ **requires $k\ge2$ $\circ$-orthogonal pieces**; a $\circ$-indecomposable point has $k=1$, and the law then reads $|\theta|\le|\theta|$.

So the chain proves the cap on precisely the set where the halving is unavailable, and the halving is available on precisely the set where the cap is not needed. On the residual, $M(n)\le\sqrt3$ delivers

$$\theta\ \le\ \mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\ \le\ \sqrt3=1.7321\qquad\text{against}\qquad\theta_0(12)=1.2360 .$$

**The halving is also false pointwise, which closes the other reading of link (b).** One could try to read $\theta\le M(n)/\sqrt2$ not as the sum law but as a pointwise inequality $\theta\le F/\sqrt2$ with $F=\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$. It fails at both of the record's own anchor points, and not narrowly:

| | $\theta$ | $F$ | $\theta/F$ | needed |
|---|---|---|---|---|
| padded $W_{\mathbb{CP}^2}$, $n=12$ (in the residual) | $1.224745$ | $1.408248$ | $\mathbf{0.869688}$ | $\le1/\sqrt2=0.707107$ |
| $S^6\times S^6$, $n=12$ | $1.236033$ | $1.242260$ | $\mathbf{0.994988}$ | $\le0.707107$ |

So there is no reading of the $\sqrt2$ that survives: as the sum law it needs $k\ge2$ and the residual has $k=1$; as a pointwise bound it is false by $23\%$ at the sharp case and by $41\%$ at the sphere product.

**And the repair is false.** Replace $\sqrt3$ by whatever constant the residual bound needs. To conclude $\theta\le\sqrt{3/2}$ on the residual by way of $\theta\le\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ one must prove $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\le\sqrt{3/2}=1.224745$ there. The residual's own sharp case refutes it:

| padded $W_{\mathbb{CP}^2}$, $n=12$ | value |
|---|---|
| criticality residual $\lVert Q(W)-\theta W\rVert_\infty$ | $1.1\times10^{-16}$ |
| $\dim E(1)$ of $L_e$ (over $\dim\mathrm{Weyl}_{12}=1638$) | $\mathbf1$, $\circ$-indecomposable |
| frame-minimised off-diagonal mass | $0.707107$, non-diagonal |
| $\theta$ | $1.224744871392=\sqrt{3/2}$ |
| $\mathop{\mathrm{tr}}(M^3)$ | $0.408248290464=1/\sqrt6$ |
| $\lVert M^\#\rVert_F$ | $1.000000000000$ exactly |
| $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ | $\mathbf{1.408248290464}=1+1/\sqrt6$ |
| $\cos\varphi$ | $0.816496581=\sqrt{2/3}$ |

The point is in the residual by the record's own three tests, and it exceeds the needed cap by $15.0\%$.

**None of those six numbers is a measurement.** Padded $W_{\mathbb{CP}^2}$ is supported on a $3$-plane of $\mathfrak{so}(n)$ whose restricted structure tensor is a *single* totally antisymmetric entry $\kappa\varepsilon_{abc}$ with $\kappa=\sqrt2$, the record's own closed rank-$3$ constant, here exact to the last bit ($\lVert c|_{3\text{-plane}}-\kappa\varepsilon\rVert_\infty=0$), and on that plane $W=\mathop{\mathrm{diag}}(2,-1,-1)/\sqrt6$. For a $3$-plane with one structure constant, $\#$ is the adjugate: $(W^\#)_{aa}=\kappa^2\lambda_b\lambda_c$, diagonal in the same frame. Three lines follow:

$$W^\#=\mathop{\mathrm{diag}}\!\big(\tfrac13,-\tfrac23,-\tfrac23\big),\qquad \mathop{\mathrm{tr}}W^\#=-1,\qquad \lVert W^\#\rVert_F=\sqrt{\tfrac19+\tfrac49+\tfrac49}=1,$$
$$\mathop{\mathrm{tr}}W^3=\frac{8-1-1}{6^{3/2}}=\frac1{\sqrt6},\qquad \langle W^\#,W\rangle=\frac{\tfrac23+\tfrac23+\tfrac23}{\sqrt6}=\frac2{\sqrt6},\qquad \theta=\frac3{\sqrt6}=\sqrt{\tfrac32},$$
$$\boxed{\ F=1+\tfrac1{\sqrt6},\qquad \cos\varphi=\tfrac2{\sqrt6}=\sqrt{\tfrac23}\ }$$

and zero rows and columns carry neither trace nor bracket, so padding into any $n$ changes none of them, verified at $n=6,8,10,12,14,16$ to twelve digits. **The witness against route M is a closed-form computation, not a numerical hit.** ([r275_c1_closedform.py](../scripts/reviewers/r275/r275_c1_closedform.py)) The Cauchy–Schwarz step $\langle M^\#,M\rangle\le\lVert M^\#\rVert_F$ loses $1-\sqrt{2/3}=18.4\%$ there, and the loss sits at the sharp point itself, so no choice of constant recovers it. *This is the same failure mode post F34 recorded for route B, now at the residual instead of at the sphere product.*

### (c) Is $\sqrt{3/2}<\theta_0(n)$ for all $n\ge12$?, CONFIRMED, with the crossover exactly as stated

$\theta_0(n)^2=2(n-1)(n-2)/n^2$, so $\theta_0(n)^2>3/2\iff4(n^2-3n+2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915$. So every even $n\ge12$ clears it, and $n=10$ fails ($\theta_0(10)=1.2<1.224745$). **At $n=12$ exactly**: $\theta_0(12)=\sqrt{220}/12=1.236033081183$ against $\sqrt{3/2}=1.224744871392$, a margin of $0.011288$, or $0.913\%$. The crossover $6+2\sqrt7$ in [plan.md](../plan.md) M1 is right. Note what the thinness means: padded $W_{\mathbb{CP}^2}$ sits at $0.99087\,\theta_0(12)$, so the whole of route M's conclusion at $n=12$ rests on a $0.9\%$ gap.

### (d) "Granting the diagonal case", a GRANT, not a theorem in this record

[plan.md](../plan.md)'s standing state lists *"the diagonal half at every $n\ge4$"* under **Proved and audited**. [findings/LEDGER.md](../findings/LEDGER.md)'s open-gaps section says the opposite in its first bullet: *"The diagonal case is published only for even $n\ge16$ (Jäger's Theorem A); $n=12,14$ are closed by Lemma L1, whose proof sits in [response.md](../response.md) rather than in the literature."* And [diagonal-half.md](../findings/diagonal-half.md) still states the diagonal problem as **owed**: *"maximise $\theta(w)$ over weights whose negative graph is triangle-free; is the maximum $\theta_0(n)$…"*, with the spectral half supplying $99.6\%$ of the target at $n=12$ and the coupling term unproved.

So the grant is **legitimate for exactly the range route M needs**, even $n\ge16$ from Jäger's Theorem A, $n=12$ and $n=14$ from the record's own Lemma L1 ([response.md](../response.md) §Lemma L1: Jäger's $n\ge16$ is *"an artifact of rational rounding inside one lemma"*). Two qualifications the plan drops:

- **"at every $n\ge4$" is false.** [response.md](../response.md) states it itself: *"the odd analogue is $S^m\times S^{m+1}$, where even the diagonal case is still conjectural, and Lemma L1 does not change that, its computation covers the bulk of Jäger's argument for odd $n$, but his endgame genuinely needs evenness."* The grant covers even $n\ge12$, not every $n\ge4$.
- **"Proved and audited" is one word too strong for the $n=12,14$ half.** Lemma L1's proof is in [response.md](../response.md), not in the literature and not in [findings/](../findings/); the ledger says so in its first open gap.

Route M inherits the dependency and does not create it, and within even $n\ge12$ the grant holds. But the diagonal *problem* as [diagonal-half.md](../findings/diagonal-half.md) carries it is still open in this record's own hands, it ends at *"what is owed is $\theta\le\frac{n-1}n\mu_1$"* on the vertex-transitive locus and the trade-off $E-E_0\le T_{\max}-T$ in general, so "the diagonal half" is granted from outside, not held inside.

**Verdict on claim 1: the chain breaks at (b), and no strengthening of the cap repairs it.**

## Claim 2, is the target inequality a rearrangement?

Evidence: [r275_c1_chain.py](../scripts/reviewers/r275/r275_c1_chain.py), [r275_c4_excess.py](../scripts/reviewers/r275/r275_c4_excess.py).

**It is not a restatement.** Post F34 killed the previous target because $\cos\varphi$ is *defined* as $\langle M^\#,M\rangle/\lVert M^\#\rVert_F$, making $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\cos\varphi\le\theta_0$ the identity $\theta\le\theta_0$. Route M's $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\le\sqrt3$ has no such collapse: it drops $\cos\varphi$ and raises the constant, so it is a genuinely **weaker** statement than Conjecture A ($\theta\le\theta_0(n)<\sqrt2<\sqrt3$), asserting something true at every point the record holds. The plan is right that this one is not post F28's mechanism.

**Post F11's $1+\sqrt2$ floor does not fence it.** Post F11 bounds the *split*: $\max\mathop{\mathrm{tr}}W^3=1$ and $\max\langle W,W^\#\rangle\to\sqrt2$ separately, so $\max\mathop{\mathrm{tr}}W^3+\max\langle W,W^\#\rangle\ge1+\sqrt2=2.414$. Route M's quantity is the sup of a **sum**, $\sup(\mathop{\mathrm{tr}}M^3+\lVert M^\#\rVert_F)$, and no inequality carries the first floor to the second. Measured, the two are far apart: the joint sup is $\approx1.41$–$1.43$, well under $2.414$. **The plan's reading of post F11 is correct.**

**And it does not matter, because the target is unusable at every constant.** Write $F(M)=\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ and $R_n$ for the residual ($\circ$-indecomposable, non-diagonal, critical). Any route of this shape concludes $\theta\le\sup_{R_n}F$; closing Conjecture A needs that below $\theta_0(n)$. But

$$\sup_{R_{12}}F\ \ge\ F(\text{padded }W_{\mathbb{CP}^2})=1+\tfrac1{\sqrt6}=1.408248\ >\ \theta_0(12)=1.236033 ,$$

by $13.9\%$, and the record's own screen puts the unrestricted sup at $\approx1.4294$. So the constant $\sqrt3$ is not merely unsharp: **there is no constant at which this inequality both holds and closes the conjecture.** Route M sits between a bound that is provable and useless and one that is useful and false, the same trap as route B, entered through a different quantity.

**And the obstruction is $n$-uniform, because $F$ does not see the padding.** Zero-padding a Weyl operator of $\mathrm{Weyl}_{n_0}$ into $\mathrm{Weyl}_n$ lands in $\mathrm{Weyl}_n$ exactly ($\lVert P_{\mathcal W}X-X\rVert_\infty\le7\times10^{-18}$ measured), preserves the norm, and preserves both $\mathop{\mathrm{tr}}(M^3)$ and $\lVert M^\#\rVert_F$, so $F$ is invariant under padding and $\sup_{\mathrm{Weyl}_n}F$ is non-decreasing in $n$. Measured across $n=4\dots16$, $F(\text{padded }W_{\mathbb{CP}^2})=1+1/\sqrt6$ and $\theta=\sqrt{3/2}$ at **every** even $n$, to twelve digits. Two consequences:

- **From one certified point, the route is dead on the whole range in question.** Any valid cap $C$ must satisfy $C\ge F(\text{padded }W_{\mathbb{CP}^2})=1.408248290464$, and $\theta_0(n)>1.408248290464$ only past the exact crossover

$$n_*=90+36\sqrt6+\big(10+4\sqrt6\big)\sqrt{51+12\sqrt6}=355.695343\ldots,$$

the positive root of $2(n-1)(n-2)=\big(1+\tfrac1{\sqrt6}\big)^2n^2$, so the first even dimension clearing it is $n=\mathbf{356}$, where $\theta_0=1.408253397$ against $\theta_0(354)=1.408219715$. **For every even $n$ from $12$ to $354$ there is no constant at all**: $C\ge1.4082>\theta_0(n)$.
- **Past that, the witness only gets better.** $r275$'s own $n=8$ maximiser, padded into $\mathrm{Weyl}_n$, is a unit Weyl operator with $F=1.420488880008$ at every $n\ge8$, above $\sqrt2=1.414214$, hence above $\theta_0(n)$ at every $n$, since $\theta_0(n)\uparrow\sqrt2$. (Its $\circ$-indecomposability is not certified, the $\dim E(1)$ test needs criticality and this point has residual $8\times10^{-3}$, so this half is evidence, where the padded-$\mathbb{CP}^2$ half is proof.)

**Where the maximiser sits, and why that is the point.** At $n=6$ and $n=8$ the ascent's maximiser has spectrum $(+0.8221,-0.4010,-0.4010)$ and $(+0.8316,-0.3891,-0.3891)$ over a cloud of magnitude $\le0.04$, a perturbation of $\lambda=(2,-1,-1)/\sqrt6=(+0.816497,-0.408248,-0.408248)$, which is padded $W_{\mathbb{CP}^2}$'s own rank-$3$ configuration and the record's own closed rank-$3$ optimum. **So restricting the cap to the residual buys $0.005$–$0.012$**: the unconstrained maximiser of $F$ is a small perturbation of the residual's sharp case, not a distant interior point. That is the opposite of what a route needs from a restriction.

**Proposed fence post.** *Bounding $\theta$ by $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ cannot close Conjecture A at any constant, for any even $12\le n\le354$: the quantity is $1+1/\sqrt6=1.408248290464$ at padded $W_{\mathbb{CP}^2}$ (a $\circ$-indecomposable non-diagonal critical point at every even $n$, by padding), against $\theta_0(n)\le\theta_0(354)<1.408248$. The Cauchy–Schwarz loss there is $1-\sqrt{2/3}=18.4\%$ and sits at the sharp point itself.* Reopening condition: a bound on $\langle M^\#,M\rangle$ that is **not** $\lVert M^\#\rVert_F$, one that sees eigenspace alignment, since $\cos\varphi=\sqrt{2/3}$ there and $0.9949$ at the sphere product.

## Claim 4, post F34's exact excess formula

Evidence: [r275_c4_excess.py](../scripts/reviewers/r275/r275_c4_excess.py).

Post F34 states the excess of $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ over $\theta_0$ at the balanced sphere product as $m/\big((2m-1)(u+\sqrt{u^2+m^2-m})\big)$, $u=m(2m-3)$, *"asymptotically $\tfrac1{8m^2}=\tfrac1{2n^2}$"*. **Both halves are wrong.**

Since $\theta=\theta_0$ identically there, the excess is $\lVert M^\#\rVert_F-\langle M^\#,M\rangle$. With the closed forms, all three verified against the independent build to $10^{-15}$ at $n=12$,

$$\mathop{\mathrm{tr}}(M^3)=\frac1{m\sqrt{(m-1)(2m-1)}},\quad \langle M^\#,M\rangle=\frac{2m-3}{\sqrt{(m-1)(2m-1)}},\quad \lVert M^\#\rVert_F=\frac{\sqrt E}{\sqrt{m(m-1)}\,(2m-1)} ,$$

$E=(2m-1)[m(2m-3)^2+m-1]$. Using $m(2m-3)^2+m-1=(u^2+m^2-m)/m$ (exact), $\lVert M^\#\rVert_F=\sqrt{u^2+m^2-m}\,/\,(mD)$ and $\langle M^\#,M\rangle=u/(mD)$ with $D=\sqrt{(m-1)(2m-1)}$, so

$$\boxed{\ \text{excess}=\frac{\sqrt{u^2+m^2-m}-u}{mD}=\frac{m-1}{D\big(u+\sqrt{u^2+m^2-m}\big)}=\frac{\sqrt{\dfrac{m-1}{2m-1}}}{u+\sqrt{u^2+m^2-m}}\ }$$

Checked exactly in sympy at $m=3\dots40$ (symbolic difference identically $0$) and against the measured excess to $12$ digits:

| $n$ | measured excess | this closed form | post F34's | post34/true |
|---|---|---|---|---|
| $6$ | $0.034508782200$ | $0.034508782200$ | $0.032737905309$ | $0.948683$ |
| $8$ | $0.016245401604$ | $0.016245401604$ | $0.014180149056$ | $0.872872$ |
| $10$ | $0.009485250958$ | $0.009485250958$ | $0.007904375799$ | $0.833333$ |
| $12$ | $0.006226617337$ | $0.006226617337$ | $0.005037581463$ | $0.809040$ |
| $14$ | $0.004403683995$ | $0.004403683995$ | $0.003490333177$ | $0.792594$ |
| $16$ | $0.003280038960$ | $0.003280038960$ | $0.002560792209$ | $0.780720$ |

The ratio is exactly $m/\sqrt{(2m-1)(m-1)}\downarrow1/\sqrt2$: post F34 carries $\tfrac m{2m-1}$ where $\sqrt{\tfrac{m-1}{2m-1}}$ belongs. **The asymptotics follow the same factor**: $n^2\cdot\text{excess}\to\tfrac1{\sqrt2}=0.7071$, so the excess is $\tfrac1{\sqrt2n^2}$, not $\tfrac1{2n^2}$ (sympy limit, both confirmed).

**Where the slip came from, and where it did not.** r274's own index row in [reviews/INDEX.md](INDEX.md) carries $\lVert M^\#\rVert_F^2=\dfrac{4m^3-12m^2+10m-1}{m(m-1)(2m-1)}$, and **that is correct**, it equals $E/(m(m-1)(2m-1)^2)$ identically, and gives $1.219786369771$ at $m=6$, matching the measurement to twelve digits. The error entered on transcription: [ad-form-attempt.md](../findings/ad-form-attempt.md) filed $\lVert M^\#\rVert_F=\sqrt{mE}/(\sqrt{m(m-1)}(2m-1))$ at the commit under review, wrong by a factor $\sqrt m$, at $m=6$ it gives $2.987854$ against $1.219786$, and $\sqrt6\cdot1.219786=2.987854$ exactly. The numerator $\sqrt{mE}$ should read $\sqrt E$.

*The $\sqrt{mE}$ was corrected in [ad-form-attempt.md](../findings/ad-form-attempt.md) while this review was in flight, credited to r276, the two reviewers found it independently. The excess formula and the rate below were still uncorrected at that edit.*

**Three places carry the wrong rate**, all traceable to the same closed form: [fence-posts.md](../findings/fence-posts.md) post F34 (*"asymptotically $\tfrac1{8m^2}=\tfrac1{2n^2}$"*), [ad-form-attempt.md](../findings/ad-form-attempt.md) (*"asymptotically $\tfrac1{8m^2}=\tfrac1{2n^2}$"* and *"the excess is $\tfrac1{2n^2}$"*), and r274's index row in [reviews/INDEX.md](INDEX.md) (*"$\tfrac1{8m^2}+O(m^{-3})=\tfrac1{2n^2}$"*). The correct leading term is $\tfrac1{4\sqrt2\,m^2}=\tfrac1{\sqrt2\,n^2}$.

**What survives.** Post F34's *conclusion* is untouched (the excess is strictly positive at every even $n\ge4$ and $O(n^{-2})$) and the strengthened inequality is still false at the balanced sphere product. What changes is the rate a successor must clear: $0.7071/n^2$, $\sqrt2$ tighter than recorded.


## Claim 5, route N's premise: is Nienhaus's $n=12$ sign flip structural?

Evidence: [r275_c5_nienhaus.py](../scripts/reviewers/r275/r275_c5_nienhaus.py), read against [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) L4698–L4790.

**The estimate, reconstructed.** With $f(\varphi)=\sqrt{2/3}\,P(\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W)=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma$, Theorem 4.17 bounds $\gamma$ by minimising

$$g_c(\varphi)=\frac{c-\cos^3\varphi-3\alpha\cos\varphi\sin^2\varphi}{\sin^3\varphi}\ \ge\ \gamma ,$$

where $c$ is an a priori cap on $f$. Nienhaus takes $c=1$, justified by *"the fact that $f(\varphi)\le1$ on $[0,\pi]$"*, which says exactly that $P\le\sqrt{3/2}=P(W_{\mathbb{CP}^2})$, i.e. that $W_{\mathbb{CP}^2}$ is the global maximizer. Differentiating in $k=\cos\varphi$ gives, symbolically, $(1-\alpha)k^2-ck+\alpha=0$, confirming the record's own reading in [route-a.md](../findings/route-a.md). At $c=1$ that is $k=\alpha/(1-\alpha)$, the paper's value, and $\gamma_{\max}=(1+\alpha)\sqrt{1-2\alpha}$, which **confirms route-a.md's correction** of the pdftotext rendering $\sqrt{1-2\alpha(1+\alpha)}$: at $\alpha=1/4$ the true minimum is $0.883883$, the mangled expression gives $0.612372$.

**The flip is an identity.** The closing quantity is $g_1(\alpha)=\tfrac34(3\alpha-1)+\tfrac{\sqrt3}4\gamma_{\max}(\alpha,c)-\alpha$, required strictly negative for $\alpha<1/3$, and Theorem 4.14 delivers $\alpha\le1/3$ with the endpoint attained. At $\alpha=1/3$ the first term vanishes and

$$g_1(\tfrac13)=\tfrac{\sqrt3}4\gamma_{\max}(\tfrac13,c)-\tfrac13,\qquad \gamma_{\max}(\tfrac13,1)=\tfrac4{3\sqrt3}=0.769800359\ \Rightarrow\ g_1(\tfrac13)\equiv0\ \text{at }c=1 .$$

$\gamma_{\max}$ is strictly increasing in $c$, so **the sign of the closing estimate at the binding endpoint is exactly $\mathop{\mathrm{sign}}(c-1)$**, and $c=\sqrt{2/3}\,\Theta>1\iff\Theta>\sqrt{3/2}\iff W_{\mathbb{CP}^2}$ is no longer the maximizer, which is $\theta_0(n)>\sqrt{3/2}$, i.e. $n>6+2\sqrt7=11.2915$. The estimate is not merely tight at $n=12$; it *is* the statement it was invoked to help prove, evaluated at one point.

| $n$ | $c=\sqrt{2/3}\,\theta_0(n)$ | $\gamma_{\max}(1/3,c)$ | $g_1(1/3)$ | $\alpha$-window where $g_1\ge0$ |
|---|---|---|---|---|
| $\le11$ | $\le1$ (cap is $1$) | $0.769800359$ | $0.000000000$ | endpoint only |
| $12$ | $1.009216785$ | $0.783805520$ | $+0.006064413$ | $[0.322283,\,1/3]$ |
| $14$ | $1.030157507$ | $0.814467864$ | $+0.019341597$ | $[0.302467,\,1/3]$ |
| $16$ | $1.045825033$ | $0.836578634$ | $+0.028915841$ | $[0.290183,\,1/3]$ |
| $100$ | $1.137365377$ | $0.956948533$ | $+0.081037537$ | $[0.234983,\,1/3]$ |

The windows reproduce the ledger's *"$\alpha\le0.322$ / $0.302$ covered by Nienhaus's own bound"* to four digits, and the $n=16$ edge $0.290183$ against its coupled bound's $\alpha\ge0.296$ gives the recorded gap of width $0.0058$, three independent confirmations of numbers the record carried unvalidated.

**And $10\le n\le11$ is a squeeze between two opposite failures**, which is the sharpest statement of what the hypothesis is. Theorem 4.17 carries two estimates, and they fail in opposite directions:

| | what fails | why |
|---|---|---|
| $n\le9$ | the **value** estimate $f(\pi/6)\le g_2(1/3)=\tfrac{5\sqrt3}9=0.9622504$ against the requirement $f(\pi/6)<\sqrt{2/3}\,\Theta$ | $\Theta$ is too *small*: $\sqrt{2/3}\,P(W^{\rm crit}_{\rm sym,8})=0.9354143$ and $\sqrt{2/3}\,P(W^{\rm crit}_{\rm sym,9})=0.9561829$, both below $0.9622504$, Remark 4.18 exactly |
| $n\ge12$ | the **derivative** estimate $g_1(\alpha)<0$ on $\alpha<1/3$ | $\Theta$ is too *large*: $c=\sqrt{2/3}\,\Theta>1$ |

Both $P(W^{\rm crit}_{\rm sym,n})$ values reproduce Nienhaus's own Proposition 2.25 numbers exactly on this reviewer's independent build, $6/5$ at $n=10$ and $2\sqrt{30}/9=1.217161239$ at $n=11$, criticality residual $\le8\times10^{-17}$. **The theorem's range is not a scope choice; it is the intersection of two failures**, and the upper end of it is the one route N would have to cross.

**Answer to I3: structural for the estimate, confined for the theorem, and circular for route N as stated.**
- *Structural*: no sharpening of Nienhaus's $\gamma$-bound survives $n\ge12$, because at $\alpha=1/3$ it is an equality at $c=1$ and $c>1$ is exactly what $n\ge12$ means.
- *Confined*: it binds only on an $\alpha$-window at the top, width $0.011$ at $n=12$ growing to $0.098$ at $n=100$, so a second and independent bound on $\gamma$ can close it, and the record has one, at $n=12,14$ only.
- *Circular for N*: the cap $c$ is the only place the dimension enters, and it is an a priori bound on $\max P$. At $n\le11$ it was available because $W_{\mathbb{CP}^2}$'s global maximality was already a theorem there. Transplanting the same shape to the $S^{n/2}\times S^{n/2}$ tube at $n\ge12$ needs the analogous cap $\max P\le\theta_0(n)$, **Conjecture A itself**. [response.md](../response.md) already identifies the escape (use the attained maximum as its own cap), so route N is not dead; but I2's "tube estimate" must supply that bootstrap, and the record's own 4.17 repair is Gate-2 flagged *"conditional on Conjecture A past $n=12$"*. **I3 does not kill N, and it does not license N either: what it shows is that the borrowed shape carries no dimension-free cap, and the cap is the whole content.**

## Claim 6, the validation ledger: r260's "10,395 diagrams to rank 2"

Evidence: [r275_c6_ledger.py](../scripts/reviewers/r275/r275_c6_ledger.py), [out_c6.txt](../scripts/reviewers/r275/out_c6.txt). Independent of r260's scripts and of r265's.

The Brauer diagrams on $12$ legs are the $11!!=10395$ perfect matchings of the index slots of $W\otimes W\otimes W$; each gives a cubic form $\gamma_D(W)$. All $10395$ were enumerated, each evaluated on $8$ random unit Weyl tensors by direct `einsum` contraction, and the rank of the $10395\times8$ value matrix taken.

| $n$ | $\dim\mathrm{Weyl}_n$ | matchings | with an intra-tensor pair | nonzero forms | **rank** | $\sigma_2$ | $\sigma_3$ |
|---|---|---|---|---|---|---|---|
| $6$ | $84$ | $10395$ | $8667$ (all zero) | $1728$ | $\mathbf2$ | $4.81$ | $2.4\times10^{-14}$ |
| $7$ | $168$ | $10395$ | $8667$ (all zero) | $1728$ | $\mathbf2$ | $2.82$ | $1.7\times10^{-14}$ |
| $8$ | $300$ | $10395$ | $8667$ (all zero) | $1728$ | $\mathbf2$ | $4.18$ | $1.1\times10^{-14}$ |

**VALIDATED, and the structure is cleaner than "rank 2" suggests.** Two facts the ledger entry does not carry:

1. **$8667$ of the $10395$ die for one reason, and it is not cancellation.** A matching with both ends of a pair inside the same tensor contracts $W$ against two of its own slots (a trace of a totally trace-free tensor) so the form is *identically* zero, at every $n$ and every $W$. Measured: $0$ of the $8667$ produced a nonzero value. The count $8667=10395-1728$ is exact, and $1728=6\cdot6\cdot2\cdot6\cdot2\cdot2$ is forced, each of the three tensor pairs must be joined by exactly two legs.
2. **The two survivors are the record's own pair.** Every one of the $1728$ nonzero forms lies in $\mathop{\mathrm{span}}\{\mathop{\mathrm{tr}}(W^3),\ \langle W^\#,W\rangle\}$, to a maximum residual of $10^{-15}$ at $n=6,7,8$. So the rank-$2$ statement is not just a number: the quotient is spanned by the two invariants the whole programme already uses, and $8$ sample points is four times what rank $2$ needs to be distinguishable from rank $3$.

The gap between $\sigma_2$ and $\sigma_3$ is fourteen orders of magnitude, so this is not a tolerance artefact. **Ledger entry r260: validated.**


## Claim 3, the falsifier screen

Evidence: [r275_c3_falsifier.py](../scripts/reviewers/r275/r275_c3_falsifier.py), [out_c3.txt](../scripts/reviewers/r275/out_c3.txt), [r275_c3_basin.py](../scripts/reviewers/r275/r275_c3_basin.py), [r275_c3_extrap.py](../scripts/reviewers/r275/r275_c3_extrap.py), [r275_c2_structure.py](../scripts/reviewers/r275/r275_c2_structure.py).

[run_m_falsifier.py](../scripts/runs/run_m_falsifier.py) imports r274's optimiser wholesale (`sys.path.insert(0, "scripts/reviewers/r274")`), so its screen and r274's measurement are one measurement, not two. This reproduction shares no code with either: its own $\Lambda^2$, its own structure constants, its own Weyl projector, its own sharp operator (an $n^6$ tensor contraction rather than $\mathrm{ad}$-traces, cross-checked against a structure-constant implementation to $10^{-16}$), its own gradient (finite-difference checked to $10^{-12}$), and two optimisers.

### (a) Reproduction, CONFIRMED to six digits

Two optimisers, both run from every seed: **A**, retraction ascent on the unit sphere of $\mathrm{Weyl}_n$ with an Adam-style adaptive step and decaying learning rate ($2500$ iterations); **B**, `scipy` L-BFGS-B on the ambient scale-invariant objective $x\mapsto F\big(P_{\mathcal W}(x)/\lVert P_{\mathcal W}(x)\rVert\big)$ over all symmetric $N\times N$ matrices, seeded at A's answer. Seed families: uniform random Weyl; $S^p\times S^q$ for every split; $S^{n/2}\times S^{n/2}$ and perturbations; padded $\mathbb{CP}^k$ for every $k\le n/2$ and perturbations; and r274's saved optima and perturbations of them (read as data, no code imported).

| $n$ | seeds | r275, method A | r275, method B | plan.md's screen | $F/\theta_0$ | post F34's $F/\theta_0$ |
|---|---|---|---|---|---|---|
| $6$ | $82$ | $1.412822$ | $1.412822$ | $1.4128$ | $1.340321$ | $1.3403$ |
| $8$ | $87$ | $1.420489$ | $1.420489$ | $1.4205$ | $1.239904$ | $1.2399$ |
| $10$ | $92$ | $1.425703$ | $1.425703$ | $1.4257$ | $1.188086$ | $1.1881$ |
| $12$ | $81$ | $1.429351$ | $1.429351$ | $1.4294$ | $1.156402$ | $1.1564$ |

*The $n=14$ leg was killed by an external signal before it wrote its row, so this table stops at $n=12$. It would have added a fifth point to a table whose first four already agree with the screen at every digit the screen prints, and it bears on no verdict: the route's break is at $1.408248290464$, which is exact and $n$-independent.*

**No falsifier**: nothing anywhere near $\sqrt3=1.732051$; the best is $0.825\,\sqrt3$. The screen's *number* is right at every dimension, and post F34's $F/\theta_0$ row reproduces too.

*Two arithmetic notes on the plan.* The margin is quoted twice for the same quantity and the two disagree: **$20\%$** in route M's paragraph, **$\approx17\%$** in section 3. The true figure is $1-1.4294/1.7321=17.5\%$ at $n=12$. And the screen searches for the wrong falsifier: a tensor with $F>\sqrt3$ would refute the *cap*, but the route's break is the inference *from* the cap, which no search over $F$ can see. **The screen could not have found the defect it was run to look for.**

### (b) Is the ascent finding the global maximum?, very probably yes, and it does not help

Three independent signals, all pointing the same way:

- **Every seed family lands on the same value.** At $n=12$, random starts, padded $\mathbb{CP}^2$ through $\mathbb{CP}^6$, perturbations of each, and perturbations of r274's own saved optima all return $1.429351$, twenty families, one value. The only families that fall short are the exact critical points used as seeds ($S^6\times S^6$ at $1.242260$, $S^5\times S^7$ at $1.236545$), which sit at stationary points of the gradient and cannot move.
- **Two methods agree to every digit printed** at all four dimensions, and they share no code path.
- **Basin-hopping finds nothing else at three dimensions**, with kicks of size $0.2$ to $1.6$ on a unit sphere (a kick of $2$ is antipodal, so the whole sphere is in reach), each followed by a full re-ascent by both methods: $400$ hops at $n=6$ all return $1.412821882$; $400$ at $n=8$ all return $1.420488880$; $60$ at $n=12$ (the dimension that matters), all return $1.429351$. **$860$ hops, three values, no distinct local maximum anywhere.**

So the plan's caveat (*"ascent finds local maxima on a non-concave quantity"*), is formally right and practically moot: the landscape has one basin at these dimensions. **What matters is that this cuts against route M, not for it.** The maximiser's spectrum is $(+0.8221,-0.4010,-0.4010)$ at $n=6$ and $(+0.8316,-0.3891,-0.3891)$ at $n=8$ over a cloud of magnitude $\le0.04$, a perturbation of $(2,-1,-1)/\sqrt6$, which is padded $W_{\mathbb{CP}^2}$'s own configuration. The global maximum of $F$ sits $0.005$–$0.012$ above the residual's sharp case, so the restriction the route relies on removes almost nothing.

### (c) Is the extrapolation to $1.44$ defensible?, it is one fit of several, and it is answering the wrong question

Fitted on r275's own six-digit values ($n=6\dots12$):

| ansatz | limit | rms residual |
|---|---|---|
| geometric increments, mean ratio $r=0.6899$ | $\mathbf{1.437469}$ |, (exact by construction) |
| free power law $L-cn^{-p}$: $L$, $c=0.1423$, $p=0.5958$ | $\mathbf{1.461752}$ | $3.1\times10^{-5}$ |
| power law with $L$ pinned at $\sqrt3$: $c=0.366226$, $p=0.077152$ | $\sqrt3$ | $3.3\times10^{-4}$ |

- **The plan's $\approx1.44$ is the geometric answer and only that.** A free power law fits the same four points ten times better and lands at $1.4618$, $0.024$ higher. Four points do not separate the ansätze, so the extrapolated limit is a property of the fit, not of the data.
- **$\sqrt3$ is not supported**, but neither is it refuted by an argument. Its fit is ten times worse than the free power law, on data precise to $10^{-9}$, so as a *fit* it is excluded; as a *possibility* nothing here touches it, since a limit is not decided by four points under any ansatz.
- **And none of it matters.** The route dies at $1.408248290464$ (padded $W_{\mathbb{CP}^2}$'s exact value, above $\theta_0(n)$ at every even $n\le354$), not at $1.44$ and not at $\sqrt3$. The extrapolation asks how close $\sup F$ gets to $\sqrt3$; the question that decides the route is how far $\sup F$ sits *above* $\theta_0(n)$, and that is answered in closed form by a single catalogued point. **The plan's sentence *"the maximum is stable in $n$ … so the $\approx17\%$ margin does not close as $n$ grows"* is a fitted trend used as a conclusion, and it is measuring the wrong margin.**

### (d) Does `rand_weyl` produce trace-free Bianchi tensors?, YES

`rand_weyl` projects a random symmetric matrix with `proj_weyl`, so the question is whether that projector is the Weyl projector. Checked on r274's own saved output, with r275's independent tensor conversion: every one of the eleven `best_*_n*.npy` files satisfies $\lVert A-A^{\mathsf T}\rVert_\infty=0$, first Bianchi $\le1.4\times10^{-17}$, $\mathrm{Ric}\le3.5\times10^{-17}$, $\lVert P_{\mathcal W}A-A\rVert_\infty\le7\times10^{-18}$, $\lVert A\rVert=1$ and $\mathop{\mathrm{tr}}(A^\#)=-1.000000000$. r275's own projector, built independently, is idempotent and self-adjoint to $2\times10^{-16}$ and has rank $(n+2)(n+1)n(n-3)/12$. **No defect.**
