# Reviewer 297, $\Delta$ as orbit-motion mass, the route it closes, and the dimension screen

Cold adversarial audit of F1–F4. Every number below comes from [core297.py](../scripts/reviewers/r297/core297.py), written from the definitions in the brief: structure constants of $\mathfrak{so}(n)$ in the basis $\phi_{ij}=E_{ij}-E_{ji}$ under $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^\mathsf{T}Y)$; $\mathrm{ad}(x)$ realised as $M\mapsto[x,M]$ on $\Lambda^2$; $\sharp$, $Q$, $P$ and $L_e$ from their formulas; $\mathcal W_n$ as the nullspace of first Bianchi together with Ricci. Neither [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) nor [review_r30_core.py](../scripts/lib/review_r30_core.py) was imported. Controls: $\dim\mathcal W_n=84,300,770$ at $n=6,8,10$ matching $n(n+1)(n+2)(n-3)/12$; criticality residuals $\le3.6\times10^{-16}$ and $\theta$ reproduced at $S^3\times S^3$, $S^3\times S^5$, $S^4\times S^4$, $\mathbb{CP}^{2,3,4}$ and the $C_5$ blow-up.

## Verdicts

| Claim | Verdict | One-line reason |
|---|---|---|
| **F1** | **CONFIRMED, and proved** | $g_\gamma$ *is* the squared orbit-tangent norm, exactly, with no factor and no projection; the total is $4(n-2)-4\mathop{\mathrm{tr}}(W^\sharp)=4(n-1)$, and it is a $\mathcal W_n$ fact, not a $\Lambda^2$ one |
| **F2** | **CONFIRMED, and proved** | Exactly $0.500000000$ on the whole orbit tangent at six critical points; criticality is load-bearing, Weyl-ness is not, and the orbit tangent is $\perp W$ identically, so the $e^\perp$ caveat is empty |
| **F3** | **REFUTED as a route closure** | The bound it invokes is a *necessary condition for a maximum*, not a fact about critical points. Every one of **35** independent $\Delta>0$ critical classes with $\theta>0$ that I constructed **violates** it, $\lambda_{\max}$ from $1.07$ to $96.29$, and at the $C_5$ blow-up $P$ genuinely rises along a direction with **zero** orbit component |
| **F4** | **REFUTED as stated; its first sentence CONFIRMED** | $\dim\mathcal O\le\dim\mathfrak m+\dim\ker W$ is proved and holds at every point tested. The "contrapositive" drops $\dim\ker W$ and has four counterexamples; the genericity consequence is false at the parameters it names |

---

## F1, $g_\gamma$ is the orbit-tangent norm, CONFIRMED

**The identification is exact.** Computing $Z_\delta=\mathrm{ad}(v_\delta)W-W\,\mathrm{ad}(v_\delta)$ as a commutator of $N\times N$ matrices and taking $\lVert Z_\delta\rVert_F^2$ reproduces the brief's $\sum_{ab}(\lambda_a-\lambda_b)^2T_{\delta ab}$ to $\le5.6\times10^{-15}$ at every point tested, critical or not, Weyl or not. There is no missing factor and no projection: in the eigenframe $(\mathrm{ad}(v_\delta)W-W\,\mathrm{ad}(v_\delta))_{ab}=c_{\delta ab}(\lambda_b-\lambda_a)$, and squaring gives the formula termwise.

**It is the same subspace [orbit_tangent](../scripts/lib/review_r30_core.py) returns.** The span of $\{[\mathrm{ad}(v_\delta),W]\}$ and the span of $\{[\mathrm{ad}(\phi_a),W]\}$ have equal dimension and minimum principal cosine $1.000000$ at all eleven test points, as they must, since $x\mapsto[\mathrm{ad}(x),W]$ is linear and the two families are two bases of the same source.

**The total, derived rather than measured.** With $M_{ab}=\sum_\delta T_{\delta ab}$,

$$\sum_\gamma g_\gamma=\sum_{ab}(\lambda_a-\lambda_b)^2M_{ab}=2\lVert W\rVert^2\!\sum_b M_{ab}-2\,\lambda^\mathsf{T}M\lambda=4(n-2)\lVert W\rVert^2-4\mathop{\mathrm{tr}}(W^\sharp),$$

because $\sum_bM_{ab}=2(n-2)$ is the adjoint Casimir and $\lambda^\mathsf{T}M\lambda=\sum_\delta 2(W^\sharp)_{\delta\delta}$. Measured at the $C_5$ blow-up: row marginal $16.000000$ against $2(n-2)=16$, and $\lambda^\mathsf{T}M\lambda=-2.000000$ against $2\mathop{\mathrm{tr}}(W^\sharp)=-2.000000$.

**So "constant on $\mathcal W_n$" is the right scope, and the qualifier is load-bearing.** The constancy rests entirely on $\mathop{\mathrm{tr}}(W^\sharp)=-\lVert W\rVert^2$, which is a $\mathcal W_n$ identity: at unit random symmetric elements of $\mathrm{Sym}^2(\Lambda^2)$ that are not Weyl, $\mathop{\mathrm{tr}}(X^\sharp)$ returns $-0.203,+0.244,-0.420,-0.185$ at $n=5,\dots,8$, and the total falls to $12.759$ and $13.174$ against $16$ at $n=5$, $17.522$ and $16.942$ against $20$ at $n=6$, $21.166$ and $20.700$ against $24$ at $n=7$. On $\mathcal W_n$ it is $4(n-1)$ to $\le1.8\times10^{-14}$ at every point, critical or not, **criticality contributes nothing**, which is the honest scope and is what the brief says.

**One reading to avoid.** "Share of the orbit motion" is the trace of the pullback metric over $\mathfrak p$, not a count of directions. That distinction is what breaks F3 below.

## F2, every orbit direction is an exact $\tfrac12$-eigenvector, CONFIRMED

**Measured.** On an orthonormalised basis of the whole orbit tangent, $\max\lVert L_eu-\tfrac12u\rVert$ is $\le6.1\times10^{-16}$ and the Rayleigh spectrum is $[0.500000000,0.500000000]$ at $S^3\times S^5$ (15 directions), $S^4\times S^4$ (16), $S^3\times S^3$ (9), $\mathbb{CP}^2$ (2), $\mathbb{CP}^3$ (6) and the $C_5$ blow-up (40, $\Delta=12$). The brief's three measurements are reproduced and three more added.

**Criticality is load-bearing; nothing else is.** At non-critical Weyl tensors at $n=6$ the same computation gives Rayleigh spectra $[-9.40,10.73]$ and $[-239.00,279.16]$ with $\max\lVert L_eu-\tfrac12u\rVert$ of $13.9$ and $324$. What the derivation needs is $O(n)$-equivariance of $Q$ (which holds on all of $\mathrm{Sym}^2(\Lambda^2)$, not only on $\mathcal W_n$) together with $Q(W)=\theta W$, and $\theta\ne0$ to normalise $L_e=L_W/\theta$. Weyl-ness enters only through the ambient space in which criticality is asserted.

**The $e^\perp$ caveat the brief invites is empty.** $\langle[\mathrm{ad}(x),W],W\rangle=\mathop{\mathrm{tr}}(\mathrm{ad}(x)W^2)-\mathop{\mathrm{tr}}(W\,\mathrm{ad}(x)W)=0$ identically, since $\mathrm{ad}(x)$ is skew and $W$ symmetric on $\Lambda^2$. Measured at $\le5.6\times10^{-17}$ at every point including non-critical and non-Weyl ones. **The whole orbit tangent lies in $e^\perp$ always**, so there is no part of it outside the subspace Lemma L24 speaks about.

**Degeneracy and small orbits do not break it.** $\mathbb{CP}^2$ has a $3$-dimensional kernel and an orbit of dimension $2$ out of $\dim\mathfrak{so}(4)=6$; the two orbit directions still sit at exactly $\tfrac12$. Individual $g_\delta$ values are basis-dependent inside a degenerate eigenspace; $\Delta$, being a trace over $\mathfrak p$, is not.

## F3, the route closure, REFUTED

### The premise is misread

Lemma L24 does not read $\lambda_{\max}\le\tfrac12$. It reads *if $W$ is a maximizer then* $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, a necessary condition, and the entire content of [Observation L25](../findings/second-order.md) is that critical points routinely violate it, $\lambda_{\max}$ running over $[1.17,96.3]$. F3 uses the conclusion of a conditional as though it held at the point under test. Read that way, no second-order test could ever fail and Lemma L24 would have no content, so the reading contradicts the file it cites, two sections apart.

### The mechanism it establishes is true; the inference drawn from it is not

What is true, and is [post F37](../findings/fence-posts.md) again: the directions $\Delta$ measures are exactly the orbit-tangent directions, and those sit at exactly $\tfrac12$ whatever $\Delta$'s size. What does **not** follow is that a $\Delta>0$ point satisfies the bound. Between "the orbit cannot supply a violation" and "nothing can supply one" lies the entire orthogonal complement of the orbit, which F3's argument never touches.

**And that complement is where the violation actually lives.** At the $C_5$ blow-up ($\Delta=12$, $\theta=0.670820$, criticality residual $1.3\times10^{-16}$):

- $\lambda_{\max}(L_e|_{\mathcal W_{10}\cap W^\perp})=1.206011330$, with **29** eigenvalues strictly above $\tfrac12$;
- multiplicity of $\tfrac12$ is $60$ against $\dim\mathcal O=40$, so $\Delta$ does not even determine the count at the bound;
- the top eigendirection $H$ has $\lVert\Pi_{\mathcal O}H\rVert=9.2\times10^{-16}$, **exactly orthogonal to the orbit**.

Walking the great circle $W(t)=\cos t\,W+\sin t\,H$ gives $P$ **increasing**, with $(P-\theta)/t^2\to1.420820$ against the second-order prediction $3\theta(\lambda_{\max}-\tfrac12)=1.420820$ at $t=0.3,0.1,0.03,0.01,0.003$ (values $1.295155,1.406509,1.419529,1.420677,1.420807$). So the point is demonstrably not a local maximum, and the demonstration runs entirely through directions $\Delta$ cannot see and F3 never considers.

### The inference F3 declares impossible is supported by everything I can construct

[f3_diaghunt.py](../scripts/reviewers/r297/f3_diaghunt.py) solves criticality on the diagonal locus, where $Q$ is stable (verified: off-diagonal image $0.0$ exactly) and $\mathcal W_n$ is $\{w$ symmetric, zero diagonal, zero row sums$\}$; [f3_gen6.py](../scripts/reviewers/r297/f3_gen6.py) solves it on the full $84$-dimensional $\mathcal W_6$. Counting only $\theta>0$, where Lemma L24 applies:

| population | classes with $\Delta>0$ | $\lambda_{\max}$ range | satisfying $\lambda_{\max}\le\tfrac12$ |
|---|---|---|---|
| $n=6$, general (non-diagonal, $18/18$ converged, residual $\le6.7\times10^{-16}$) | $7$ (from $10$ runs) | $1.670$–$96.292$ | **0** |
| $n=8$, diagonal locus ($35$ runs converged) | $12$ | $1.067$–$7.598$ | **0** |
| $n=10$, diagonal locus ($16$ runs converged) | $15$ | $2.036$–$8.683$ | **0** |
| $C_5$ blow-up | $1$ | $1.206$ | **0** |

**Thirty-five independent classes, zero counterexamples.** Two of them are worth naming. The $n=6$ value $96.291798$ reproduces the top of Observation L25's recorded range exactly, from an implementation that never read it. And the $n=8$ point at $\theta=0.555683$ has $S_{\mathfrak{mmm}}=0.0000$ exactly with $\Delta=11.0449$ and $\lambda_{\max}=1.380653$, a point **on the live target set** $\{S=0,\Delta>0\}$ that fails the second-order bound.

So the implication "$\Delta>0\Rightarrow$ not a local maximum" is not merely unclosed; it is the best-supported unproven statement in this neighbourhood of the record. F3 closes it on an argument that does not reach it. **A route closure resting on a non-sequitur is the most expensive error available here, and this is one.**

### What is genuinely established, at the strength it deserves

Only this: *no argument that evaluates the second-order form on the directions $\Delta$ measures can produce a violation*, because those directions are pinned at $\tfrac12$ by invariance. Even that is narrower than it sounds. $\Delta>0$ is available as a **hypothesis** (it says $\mathfrak p\not\subseteq\mathfrak k(W)$, hence that the isotropy is small) and an argument may consume that hypothesis and then exhibit a violating direction anywhere it likes. Nothing here forbids it. The closure applies to $g$ as a *carrier of directions*, not to $\Delta$ as a *hypothesis*.

### The rescues I checked and that do not exist

- **A strict version of Lemma L24.** Krasnov–Tkachev Proposition 6.6 carries "$1$ simple" in addition to $\sigma\subseteq(-\infty,\tfrac12]$. Measured $\mathop{\mathrm{mult}}(1)=1$ at every critical point tested, so that refinement is not violated anywhere and offers $\Delta$ nothing.
- **The moment budget.** $\mathop{\mathrm{tr}}L_e=0$ and $\mathop{\mathrm{tr}}L_e^2=\kappa_n/\theta^2$ reproduced exactly ($12.3750$, $20.0000$, $21.0938$, $95.0000$ at $S^3\times S^3$, $S^4\times S^4$, $S^3\times S^5$, $C_5$). Since $\mathop{\mathrm{mult}}(\tfrac12)\ge\dim\mathcal O$, a large orbit costs $1+\dim\mathcal O/4$ of the budget, but at $\theta=\sqrt{3/2}$ the budget is $17.500,28.500,42.167$ at $n=8,10,12$ against a maximum cost of $8.000,12.250,17.500$. **A factor of two of slack at every $n$**, so no contradiction is reachable this way. This is [fence post F6](../findings/fence-posts.md) once more.

### The one clause of F3 that survives

"Observation L25's failures at ungraded points come from somewhere else" is right in the weak sense that $\Delta>0$ is **not necessary** for failure: $\mathbb{CP}^3$ ($0.625$), $\mathbb{CP}^4$ ($0.600$), $S^2\times S^4$ ($0.666667$) and padded $S^3\times S^3$ at $n=8$ ($0.600000$) all have $\Delta=0$ and all fail. The converse direction is dead; the forward direction, which is the one the programme needs, is untouched.

## F4, the dimension screen, REFUTED as stated

**The inequality is right and I prove it.** $\Delta=0\iff[\mathrm{ad}(x),W]=0$ for all $x\in\mathfrak p\iff\mathfrak p\subseteq\mathfrak k(W)$, so $\dim\mathcal O=\dim\mathfrak{so}(n)-\dim\mathfrak k\le\dim\mathfrak{so}(n)-\dim\mathfrak p=\dim\mathfrak m+\dim\ker W$. Verified at eleven points with $\dim\mathcal O$ and $\dim\mathfrak k$ computed as ranks: equality at the sphere pairs and $\mathbb{CP}^{3,4}$, slack $3$ at $\mathbb{CP}^2$ ($\dim\mathcal O=2$, $\dim\mathfrak m+\dim\ker=5$), and it correctly **fails** at the $C_5$ blow-up ($40>20$, $\Delta=12$). $\mathfrak k(W)$ is closed under the bracket at every point, worst residual $4.3\times10^{-16}$, so calling it an isotropy *algebra* is licensed.

**The $\mathbb{CP}^2$ screen the brief asks for.** $\dim\mathfrak p=1$ against $\dim\mathfrak k=\dim\mathfrak u(2)=4$: the recorded *equality* $\dim\mathfrak p=\dim\mathfrak k$ is indeed false there, and F4 is safe because it only ever uses $\dim\mathfrak p\le\dim\mathfrak k$.

**The stated contrapositive is false.** "A critical point whose orbit is larger than its negative eigenspace must have $\Delta>0$" drops $\dim\ker W$. Four counterexamples, all with criticality residual $\le5.4\times10^{-16}$ and $\Delta=0$ exactly:

| point | $\dim\mathcal O$ | $\dim\mathfrak m$ | $\dim\ker W$ | $\Delta$ |
|---|---|---|---|---|
| padded $\mathbb{CP}^2$, $n=6$ | $10$ | $2$ | $12$ | $0$ |
| padded $\mathbb{CP}^2$, $n=8$ | $18$ | $2$ | $25$ | $0$ |
| padded $\mathbb{CP}^2$, $n=12$ | $34$ | $2$ | $63$ | $0$ |
| padded $S^3\times S^3$, $n=8$ | $21$ | $9$ | $13$ | $0$ |

The correct bound $\dim\mathcal O\le\dim\mathfrak m+\dim\ker W$ is respected in all four ($10\le14$, $18\le27$, $34\le65$, $21\le22$). This is the same trivial-kernel clause that [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py) already flags as load-bearing and once omitted.

**The arithmetic is right; the genericity conclusion drawn from it is false.** At $n=12$ with $\dim\mathfrak m=20$ and trivial kernel, $\dim\mathfrak p=66-20=46$, so $\Delta=0$ needs $\dim\mathfrak k\ge46$ of $66$, the brief's numbers check out. But $S^2\times S^{10}$ **is** such a point: $n=12$, $\theta=0.994987$, criticality residual $3.7\times10^{-16}$, $\dim\mathfrak m=20$ inside the band $3\le\dim\mathfrak m<36$, trivial kernel, $\Delta=0$, and $\dim\mathfrak k=46$ exactly. A $\Delta=0$ point at the named parameters is not rare, it is on the catalogue. With a kernel of dimension $z$ the requirement weakens further, to $\dim\mathfrak k\ge46-z$, so the screen is weakest exactly where padded points live.

**What the screen does say.** $\dim\mathfrak k\ge46$ excludes $\mathfrak u(6)$ ($36$), $\mathfrak{so}(9)\oplus\mathfrak{so}(3)$ ($39$), $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ ($30$) and $\mathfrak{sp}(3)\oplus\mathfrak{sp}(1)$ ($24$), leaving $\mathfrak{so}(12)$, $\mathfrak{so}(11)$ and $\mathfrak{so}(10)\oplus\mathfrak{so}(2)$ among the candidates I enumerated. That is a **rigidity** statement about which pairs can occur, and it is worth more than the genericity it was offered as. *I did not verify that $\mathfrak{so}(10)\oplus\mathfrak{so}(2)$ is the only $46$-dimensional subalgebra of $\mathfrak{so}(12)$; my list is of the standard maximal candidates, not a classification, and that clause is unaudited by me.*

## Relation to the record as it stands

[bounds.md](../findings/bounds.md) was rewritten by Reviewer 298 while this audit was running, and I read that section only after every number above was computed. My independent verdicts agree with it on both refutations and on the mechanism statement, and add: **35** $\Delta>0$ critical classes with $\theta>0$ against its seven, none satisfying the bound; the great-circle demonstration that $P$ actually rises at the $C_5$ blow-up along a direction with zero orbit component; a fourth and fifth counterexample to the ker-free contrapositive; the analytic derivation of $\sum_\gamma g_\gamma=4(n-2)-4\mathop{\mathrm{tr}}(W^\sharp)$ with the off-Weyl failure that shows the $\mathcal W_n$ qualifier is doing work; and the two rescues (Krasnov–Tkachev's "$1$ simple", the $\mathop{\mathrm{tr}}L_e^2$ budget) ruled out.

**One sharpening I would apply to the surviving closure.** Its supportable form is narrower than "no argument deriving second-order failure from the directions $\Delta$ measures can work". $\Delta$ enters a proof as a *hypothesis* about the isotropy, not as a supply of test directions; the closure bites only on arguments that evaluate the second-order form **on** the orbit tangent, which is post F37 verbatim. Stated at the wider strength it would discourage exactly the argument the evidence most supports.

## Scripts

[core297.py](../scripts/reviewers/r297/core297.py) · [f1_orbit_mass.py](../scripts/reviewers/r297/f1_orbit_mass.py) · [f23_le_spectrum.py](../scripts/reviewers/r297/f23_le_spectrum.py) · [f3_refine.py](../scripts/reviewers/r297/f3_refine.py) · [f3_diaghunt.py](../scripts/reviewers/r297/f3_diaghunt.py) · [f3_gen6.py](../scripts/reviewers/r297/f3_gen6.py) · [f4_dimension.py](../scripts/reviewers/r297/f4_dimension.py)

*One caveat on [f3_refine.py](../scripts/reviewers/r297/f3_refine.py): its multi-block rows ($k\ge3$) are built from the two-block entry formula and are **not** critical (residual $3\times10^{-1}$), so they carry no evidence and are excluded from every count above.*
