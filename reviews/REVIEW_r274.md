# REVIEW r274, Gate 2, the ad-form route and the half-percent deficit

Reviewer 274. Commits under review: `99d4e9a` / `de90c1b` (primary), `57961da`, `cc62ff2`.
Primary file: [findings/ad-form-attempt.md](../findings/ad-form-attempt.md), all sections. Supporting: [scripts/rsharp_basis_free.py](../scripts/rsharp_basis_free.py), [run_frontier_bound_proof.py](../scripts/runs/run_frontier_bound_proof.py), [scripts/weyl.py](../scripts/weyl.py), [findings/bispectral.md](../findings/bispectral.md), [findings/INDEX.md](../findings/INDEX.md) fence posts.
Scripts: [scripts/reviewers/r274/](../scripts/reviewers/r274/). Reviewer 273 runs the identical brief concurrently and independently.

**Nothing below imports from [scripts/](../scripts/).** $M^\#$ is rebuilt from Wilking's ad-form $\langle M^\#x,y\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}_xM\,\mathrm{ad}_yM)$ with $\mathfrak{so}(n)$ realised as explicit $n\times n$ matrices $\phi_{ij}=E_{ij}-E_{ji}$ and $\mathrm{ad}$ taken as a matrix commutator ([r274_weyl.py](../scripts/reviewers/r274/r274_weyl.py)); it is cross-checked against the triangle formula $(M^\#)_{ij}=\sum_k\lambda_{ik}\lambda_{jk}$, against a **pure tensor contraction** with no Lie algebra in it (Dai–Fu's $\beta=W_{tspq}W_{tjpl}W_{sjql}=2\langle M^\#,M\rangle$), and (for the sphere products), against a closed form in $m$. The Weyl projector is built from the Kulkarni–Nomizu decomposition and verified idempotent, self-adjoint, and of the right rank $\tfrac{(n+2)(n+1)n(n-3)}{12}$ at $n=5,6,7$. The sphere-product spectrum is *derived* from the Riemann tensor of $S^m(1)\times S^m(1)$, not asserted.

| # | Claim | Verdict |
|---|---|---|
| 1 | The half-percent table | **CONFIRMED, EVERY DIGIT, AND UPGRADED TO CLOSED FORM.** Independently reproduced at $n=6,8,\dots,30$: $\mathop{\mathrm{tr}}(M^3)=\frac1{m\sqrt{(m-1)(2m-1)}}$, $\langle M^\#,M\rangle=\frac{2m-3}{\sqrt{(m-1)(2m-1)}}$, $\lVert M^\#\rVert_F^2=\frac{4m^3-12m^2+10m-1}{m(m-1)(2m-1)}$, and $\theta-\theta_0(2m)=0$ **identically in $m$** under `radsimp`. $\theta_0=\sqrt{2(n-1)(n-2)}/n$ is the right comparison. The excess is not a table but a formula: $\frac{1}{8m^2}+O(m^{-3})=\frac1{2n^2}$. *Two small errors*: $\mathop{\mathrm{tr}}(M^3)$ is $\mathbf{0.395\%}$ of $\theta$ at $n=24$, not the stated $0.5\%$; and the six-term ratio list cannot span "$n=6\dots20$" in steps of two |
| 2 | The concentration claim | **REFUTED, at every $n$ tested, by a factor of thirty.** Riemannian ascent on the unit sphere of $\mathrm{Weyl}_n$ finds $\big(\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\big)/\theta_0=\mathbf{1.3403},\ 1.2399,\ 1.1881,\ \mathbf{1.1564},\ 1.1350,\ 1.1196$ at $n=6,8,10,12,14,16$, against the brief's refutation threshold of $1.005$ and the record's "half a percent". **The maximisers are not near-extremal**: at $n=12$ the winner sits at $\theta/\theta_0=0.9757$ with $\cos\varphi=0.7617$. The difficulty is *not* concentrated at the extremal object; it is concentrated where Cauchy–Schwarz is loose, which is everywhere else. *The record's measurement survives*: 40 genuine unit Weyl tensors at $n=12$ give mean $0.216\,\theta_0$, reproducing its $\approx0.21$, so what fails is the inference from 8 samples, not the samples |
| 3 | Is the proposed inequality the right target | **IT IS THE CONJECTURE VERBATIM, AND IT IS FALSE AT $n=6,8,10$.** $\theta\equiv\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$ and $\cos\varphi:=\langle M^\#,M\rangle/\lVert M^\#\rVert_F$, so "$\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\cos\varphi\le\theta_0$" is $\theta\le\theta_0$ with two symbols substituted. Zero reduction, the exact shape [fence post F28](../findings/INDEX.md) already fences off. Worse, as a statement over *all* unit Weyl tensors it is **false below $n=12$**: maximising $\theta$ returns $\sqrt{3/2}$ at $n=6,8,10$, i.e. $1.1619,\ 1.0690,\ 1.0206$ times $\theta_0$, the maximiser having $\Lambda^2$ spectrum $(2,-1,-1,0,\dots)/\sqrt6$, **the record's own padded $W_{\mathbb{CP}^2}$**. So the table's $n=6$ row reports a $3.27\%$ Cauchy–Schwarz excess at a dimension where the target itself is out by $16.2\%$ |
| 4 | The frontier package's reach | **THE ALGEBRA IS RIGHT AND THE ROUTE IS DEAD AT THE RECOMBINATION STEP.** $W^\#=W_+^\#+W_-^\#-2W_+\#W_-$ reproduces to $10^{-16}$, sign included. But at $S^m\times S^m$ the two halves have **disjoint support**, $\mathrm{parts}$ lives on the $m(m-1)$ same-factor coordinates, $\mathrm{cross}$ on the $m^2$ mixed ones, so $\lVert W^\#\rVert_F^2=\lVert\mathrm{parts}\rVert_F^2+\lVert2\,\mathrm{cross}\rVert_F^2$ exactly, and **any** triangle-inequality recombination loses $\frac{p+q}{\sqrt{p^2+q^2}}\to\sqrt2$. Even with *exact* norms for all three pieces the split returns $1.393\,\theta_0$ at $n=12$ and $\sqrt2\,\theta_0$ asymptotically. Adding Theorem 1 and L2 as actually stated gives $9.909$ at $n=12$, **$8.0\times\theta_0$**, worse than the $3.25\times$ the record calls the failing baseline. *And the recorded caution misdiagnoses its own error*: L3's $\mathop{\mathrm{tr}}$ **is** the ordinary trace (= $\mathrm{scal}/2$, so "not the Frobenius pairing" is vacuous); the real trap is $A\#B\ne A^\#B$, and the identity's true content is $\mathop{\mathrm{tr}}(W^\#)=-1$, verified here to $10^{-15}$ at $n=6,8,10,12$ |
| 5 | The fence posts | **POST F26 IS NOT DODGED, IT IS FAILED AT ITS OWN ANCHOR; 29 AND 33 GENUINELY DO NOT APPLY.** The bound is *not* exact at the coordinate-diagonal end, so post F26's hypothesis is unmet, but it misses on the wrong side: it is already $+3.27\%,+1.42\%,+0.79\%,+0.50\%$ over $\theta_0$ **at $t=2$**, where post F26 only needed it to be $\ge\theta_0$ for $t<2$. Post F29 does not reach it, $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ is $O(n)$-invariant, drift $10^{-15}$ over random rotations, and post F33 does not either, since $\lVert M^\#\rVert_F$ is not a function of two moments. So the record's *"nothing on the fence-post list closes this route"* is **half right and immaterial**: the route is closed by claim 2's optimisation instead |
| 6 | The validation ledger | **r259/r260's $r=6+\lvert\lambda\rvert/2$ is VALIDATED, mechanism and arithmetic.** The independence criterion is confirmed **sharp in both directions** by the rank of the diagram Gram matrix $[n^{c(D\cup D')}]$ over two 31-bit primes: full rank exactly when $n\ge r$, and one short of the threshold it drops, $10<15$ at $(r,n)=(3,2)$, $91<105$ at $(4,3)$. The leg arithmetic follows: a covariant $V^{\otimes12}\to V_\lambda$ pairs against $V_\lambda\subset V^{\otimes\lvert\lambda\rvert}$, giving $2r=12+\lvert\lambda\rvert$. At $n=6$ only $\lambda=\varnothing$ survives; at $n=12$ the $\lvert\lambda\rvert=12$ blocks sit at $r=12=n$, **zero slack** |

---

## Claim 1, the half-percent table

Evidence: [r274_c1_indep.py](../scripts/reviewers/r274/r274_c1_indep.py), [r274_c1_symbolic.py](../scripts/reviewers/r274/r274_c1_symbolic.py).

**The $\lambda$ vector is derived, not taken.** $S^m(1)\times S^m(1)$ has $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}$ inside each factor and $0$ across, so on $\Lambda^2$ in the coordinate basis $R=\mathrm{diag}(1,\dots,1;0,\dots,0)$ with $1$ on the $m(m-1)$ same-factor 2-forms. It is Einstein with $\mathrm{Ric}=(m-1)g$, so the Weyl tensor is $R-cI$ with

$$c=\frac{2(m-1)}{n-2}-\frac{2m(m-1)}{(n-1)(n-2)}=\frac{m-1}{2m-1},\qquad n=2m,$$

giving $\lVert W\rVert_F^2=\frac{m^2(m-1)}{2m-1}$ and the unit-norm spectrum

$$a=\frac1{\sqrt{(m-1)(2m-1)}}\ \ (\text{mult }m(m-1)),\qquad b=-\frac{\sqrt{m-1}}{m\sqrt{2m-1}}\ \ (\text{mult }m^2).$$

$\sum\mu=0$ and $\sum\mu^2=1$ hold identically in $m$, so **the normalisation is right**.

**$M^\#$ from the ad-form, three ways.** Building $\mathrm{ad}$ from real matrix commutators and evaluating $-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}_aM\,\mathrm{ad}_bM)$ gives, for a coordinate-diagonal $M$, an exactly diagonal $M^\#$ with $(M^\#)_{(ij)}=\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}$, the two agree to $4\times10^{-16}$ at $n=5,6,7$, and the full-matrix form is symmetric to $10^{-14}$ on random non-diagonal input. On the sphere product this closes in $m$:

$$(M^\#)_{\text{same}}=(m-2)a^2+mb^2,\qquad (M^\#)_{\text{mixed}}=2(m-1)ab.$$

**Every column reproduces, and $\theta=\theta_0$ is an identity.**

| $n$ | $\mathop{\mathrm{tr}}(M^3)$ | $\lVert M^\#\rVert_F$ | sum | $\theta_0(n)$ | excess | $\theta-\theta_0$ |
|---|---|---|---|---|---|---|
| $6$ | $0.10541$ | $0.98319$ | $1.08860$ | $1.05409$ | $+3.274\%$ | $2.2\times10^{-16}$ |
| $12$ | $0.02247$ | $1.21979$ | $1.24226$ | $1.23603$ | $+0.504\%$ | $-2.2\times10^{-16}$ |
| $20$ | $0.00765$ | $1.30205$ | $1.30969$ | $1.30767$ | $+0.155\%$ | $0$ |
| $24$ | $0.00524$ | $1.32163$ | $1.32687$ | $1.32550$ | $+0.103\%$ | $-4.4\times10^{-16}$ |

Symbolically, $\mathop{\mathrm{tr}}(M^3)=\frac1{m\sqrt{2m^2-3m+1}}$, $\langle M^\#,M\rangle=\frac{2m-3}{\sqrt{2m^2-3m+1}}$, and their sum is $\frac{\sqrt{2m^2-3m+1}}{m}=\theta_0(2m)$ with **difference exactly $0$**. So *"$\theta=\theta_0$ exactly at the balanced sphere product"* is a theorem in $m$, not four evaluations.

**The Cauchy–Schwarz ratio, in closed form.**

$$\frac{\lVert M^\#\rVert_F^2}{\langle M^\#,M\rangle^2}=\frac{4m^3-12m^2+10m-1}{m(2m-3)^2}\ \longrightarrow\ 1 .$$

Values $1.03638,\,1.01489,\,1.00813,\,1.00513,\,1.00354,\,1.00259,\,1.00197,\,1.00156$ at $n=6,8,\dots,20$. The record's *"$1.036,\,1.015,\,1.008,\,1.005,\,1.003,\,1.002$ at $n=6\dots20$"* lists six values for eight dimensions; $1.002$ is reached at $n=16$, and $n=14$ rounds to $1.004$.

**The excess is $\tfrac1{2n^2}$.** Series-expanding $\frac{\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F}{\theta_0}-1$ gives $\frac1{8m^2}+O(m^{-3})$, i.e. $\frac1{2n^2}$: $0.00521\%$ at $n=100$, $0.000316\%$ at $n=400$. **This is the derivation the section wanted and did not do**, the "half percent, decreasing in $n$" is a rate, and it says the missing step must be sharp to $O(n^{-2})$ *uniformly*.

**One arithmetic slip.** *"$\mathop{\mathrm{tr}}(M^3)$ carries $10\%$ of $\theta$ at $n=6$ and $0.5\%$ at $n=24$."* The $n=6$ figure is exact; at $n=24$ it is $0.00524/1.32550=\mathbf{0.395\%}$. ($0.5\%$ is the *excess* at $n=12$, one column over.)

---

## Claim 2, the concentration claim

Evidence: [r274_c2_opt.py](../scripts/reviewers/r274/r274_c2_opt.py), [r274_c2_more.py](../scripts/reviewers/r274/r274_c2_more.py), [r274_verify.py](../scripts/reviewers/r274/r274_verify.py), [out_c2.txt](../scripts/reviewers/r274/out_c2.txt).

**Method.** Riemannian gradient ascent on the unit sphere of $\mathrm{Weyl}_n$, ambient gradient, projected by the verified Weyl projector, then to the tangent space, with backtracking and 12–25 random restarts. The gradient of $\lVert M^\#\rVert_F^2$ is derived from the ad-form,

$$\partial_{pq}\lVert M^\#\rVert_F^2=-2\sum_{a,b}(M^\#)_{ab}\,(\mathrm{ad}_b\,M\,\mathrm{ad}_a)_{qp}\quad(\text{symmetrised}),$$

and agrees with central differences to $5\times10^{-11}$.

**The record's own screen, redone on genuine Weyl tensors, survives.** 40 random unit Weyl tensors at $n=12$ (not Bianchi-kernel elements) give $\big(\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\big)/\theta_0$ with mean $0.2156$, max $0.2297$, the record's $\approx0.21$, confirmed. Removing the traces changes nothing material.

**Optimisation refutes the conclusion drawn from it.**

| $n$ | max $\big(\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\big)/\theta_0$ | $\theta/\theta_0$ there | $\cos\varphi$ there | random mean |
|---|---|---|---|---|
| $6$ | $\mathbf{1.340321}$ | $1.157$ | $0.804$ | $0.475$ |
| $8$ | $1.239904$ | $1.059$ | $0.785$ | $0.337$ |
| $10$ | $1.188086$ | $1.007$ | $0.771$ | $0.263$ |
| $12$ | $\mathbf{1.156402}$ | $0.976$ | $0.762$ | $0.216$ |
| $14$ | $1.135013$ | $0.954$ | $0.755$ |, |
| $16$ | $1.119599$ | $0.939$ | $0.749$ |, |

Every maximiser is a certified Weyl tensor: unit Frobenius norm to $10^{-12}$, first Bianchi residual $\le7\times10^{-18}$, Ricci $\le3\times10^{-17}$, and $\theta$ recomputed by the Dai–Fu contractions $\alpha/8$ and $\beta/2$ (**a route with no $\mathfrak{so}(n)$ in it**), agreeing to twelve digits. $\lVert M^\#\rVert_F$ at each maximiser is confirmed a third time by the index formula $(R^\#)_{ijkl}=\sum_{p,q}(R_{ipkq}R_{jplq}-R_{iplq}R_{jpkq})$, which agrees with the ad-form to $1.5\times10^{-16}$ ([r274_sharp_tensor.py](../scripts/reviewers/r274/r274_sharp_tensor.py)).

**What this kills.** The brief's threshold was $1.005$; the answer at $n=12$ is $1.156$, thirty times the recorded deficit. The record's sentence *"the bound holds with roughly a factor of five to spare away from the extremal family, and fails by half a percent at it"* is false in its second half's implication: the bound fails by $\mathbf{15.6\%}$ at a point that is **not** extremal ($\theta/\theta_0=0.976$ there). *"The difficulty is not spread over the sphere; it sits entirely where the conjecture is tight"* is refuted.

**And the mechanism is visible.** At the $F$-maximisers $\cos\varphi\approx0.76$, while at the sphere product $\cos\varphi=0.9949$. The relaxation's loss is $\lVert M^\#\rVert_F(1-\cos\varphi)$, and it is maximised *away* from the extremal object, not at it, the opposite of the shape the record attributes to it. Eight samples in $1638$ dimensions found the region where the loss is small and read it as the whole space.

---

## Claim 3, is the proposed inequality even the right target

Evidence: definitional, plus [r274_verify.py](../scripts/reviewers/r274/r274_verify.py).

**It is the conjecture with two symbols substituted.** $\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$ ([bispectral.md](../findings/bispectral.md)), and $\varphi$ is *defined* by $\cos\varphi=\langle M^\#,M\rangle/(\lVert M^\#\rVert_F\lVert M\rVert_F)$. With $\lVert M\rVert_F=1$,

$$\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\cos\varphi\;=\;\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle\;=\;\theta$$

identically, for every $M$ whatever. So *"the exact statement to prove is $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\cos\varphi\le\theta_0(n)$"* is $\theta\le\theta_0(n)$. **Nothing has been reduced.** This is the exact mechanism of [fence post F28](../findings/INDEX.md), *"no bound of the form $\theta\le\Pi/4$ can close the target, because $\Pi/4=\theta$ identically … it is the target restated"*, recurring one file over.

**What *is* a real statement is the relaxation**, $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\le\theta_0(n)$, since $\cos\varphi\le1$. The record calls it false by half a percent. Claim 2 says it is false by $15.6\%$ at $n=12$.

**And the restated target is itself false below $n=12$.** Maximising $\theta$ over the unit sphere of $\mathrm{Weyl}_n$:

| $n$ | $\max\theta$ | $\theta_0(n)$ | ratio | maximiser |
|---|---|---|---|---|
| $6$ | $1.2247449$ | $1.054093$ | $\mathbf{1.161895}$ | $\Lambda^2$ spectrum $(2,-1,-1,0^{12})/\sqrt6$ |
| $8$ | $1.2247449$ | $1.145644$ | $1.069045$ | same, padded |
| $10$ | $1.2247449$ | $1.200000$ | $1.020621$ | same, padded |
| $12$ | $1.2360331$ | $1.236033$ | $\mathbf{1.000000}$ | $S^6\times S^6$, $\cos\varphi=0.994895$ |

$1.2247449=\sqrt{3/2}$ and the spectrum is the record's own $W_{\mathbb{CP}^2}$ ([findings/INDEX.md](../findings/INDEX.md) value table), padded, a genuine Weyl tensor of $\mathbb R^n$ at every $n\ge4$. The crossover is exactly the record's own: $\theta_0(n)\ge\sqrt{3/2}\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7$. **The search independently rediscovers the balanced sphere product as the global maximiser at $n=12$**, returning $\theta/\theta_0=1.000000$ and $\cos\varphi=0.994895$, the claim-1 table's $1.00513$ ratio, inverted.

**Stated fairly**: at $n\ge12$ the restated target is not known to be false, and $\theta\le\theta_0$ over the whole unit sphere would be a genuine strengthening of the symmetric-space statement, the point stands that it is a *restatement*, reached by substitution, and that its own table's first row lies below the dimension where it can hold. So the section states as its target an inequality that is (a) the conjecture verbatim and (b) **false at the first dimension of its own table**. The $n=6$ row's $+3.27\%$ is not a Cauchy–Schwarz deficit to be recovered; at $n=6$ the target is out by $16.2\%$ for reasons Cauchy–Schwarz has nothing to do with.

---

## Claim 4, the frontier package's reach

Evidence: [r274_c4_split.py](../scripts/reviewers/r274/r274_c4_split.py), [r274_c4_symbolic.py](../scripts/reviewers/r274/r274_c4_symbolic.py).

**The split is correct.** $\#$ is a quadratic form with polarisation $A\#B=\tfrac12\big[(A+B)^\#-A^\#-B^\#\big]$, the convention [run_frontier_bound_proof.py:141](../scripts/runs/run_frontier_bound_proof.py) uses, so $(W_+-W_-)^\#=W_+^\#+W_-^\#-2W_+\#W_-$, sign included. Reproduced to $\le10^{-15}$ at $n=6,8,10,12$ on both the sphere product and random Weyl tensors, with $\mathrm{cross}\succeq0$ and $\mathrm{parts}\succeq0$ confirmed (min eigenvalues $\ge-1.4\times10^{-17}$).

**The recorded caution has the right conclusion and the wrong reason.** L3 reads $\mathop{\mathrm{tr}}(AB)+\mathop{\mathrm{tr}}(A\#B)=\tfrac12\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle+3\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle$. Here $\mathop{\mathrm{tr}}$ **is** the ordinary matrix trace; the package's own header gives $\mathrm{scal}=2\mathop{\mathrm{tr}}$ on $\Lambda^2$, so "the scalar-curvature functional, not the Frobenius pairing" is a distinction of a constant factor and cannot save the identity. The actual trap is that $A\#B$ is the *polarised sharp product*, not $A^\#B$: at $A=B=W$ the identity says $\mathop{\mathrm{tr}}(W^2)+\mathop{\mathrm{tr}}(W^\#)=0$, i.e.

$$\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert_F^2=-1,$$

**verified here to $10^{-15}$ at $n=6,8,10,12$ on sphere products and random Weyl tensors alike.** It never was a statement about $\langle W^\#,W\rangle$. The record's $-1$ was the right number attached to the wrong object.

**The route to $\lVert M^\#\rVert_F$ is dead at the recombination, not at the bounds.** At $S^m\times S^m$ the pieces close in $m$, and the striking fact is that they have **disjoint support**:

$$\mathrm{parts}=W_+^\#+W_-^\#=\big[(m-2)a^2+mb^2\big]\ \text{on the }m(m-1)\text{ same-factor coordinates, }0\text{ elsewhere},$$
$$\mathrm{cross}=W_+\#W_-=(m-1)a\lvert b\rvert\ \text{on the }m^2\text{ mixed coordinates, }0\text{ elsewhere}.$$

Hence $\langle\mathrm{parts},\mathrm{cross}\rangle=0$ identically and $\lVert W^\#\rVert_F^2=\lVert\mathrm{parts}\rVert_F^2+\lVert2\,\mathrm{cross}\rVert_F^2$, a **Pythagorean** identity at the maximiser. Any bound assembled as $\lVert\mathrm{parts}\rVert+2\lVert\mathrm{cross}\rVert$ therefore loses exactly

$$\frac{p+q}{\sqrt{p^2+q^2}}\ \longrightarrow\ \sqrt2 .$$

| $n$ | $\lVert W^\#\rVert_F$ | $\lVert\mathrm{parts}\rVert+2\lVert\mathrm{cross}\rVert$ | over $\theta_0$ | with Thm 1 + L2: $\mathop{\mathrm{tr}}(\mathrm{parts})+2\mathop{\mathrm{tr}}(\mathrm{cross})$ | over $\theta_0$ |
|---|---|---|---|---|---|
| $6$ | $0.98319$ | $1.37155$ | $1.301$ | $3.800$ | $3.6\times$ |
| $8$ | $1.10733$ | $1.55821$ | $1.360$ | $5.857$ | $5.1\times$ |
| $12$ | $1.21979$ | $1.72238$ | $\mathbf{1.393}$ | $9.909$ | $\mathbf{8.0\times}$ |
| $24$ | (|), | $1.410$ | (|), |
| $\infty$ | (|), | $\sqrt2$ | (|), |

**Read the two right-hand columns against the deficit the split is meant to close, $0.5\%$.**

- *Even granted exact norms for all three pieces* (no L2, no Theorem 1, perfect knowledge), the triangle step alone returns $1.393\,\theta_0$ at $n=12$, i.e. **eighty times the deficit**, rising to $\sqrt2$.
- *Theorem 1 controls one scalar, not the cross term.* It gives $2\mathop{\mathrm{tr}}(W_+\#W_-)=\lVert\rho\rVert^2+6\delta^2$, a trace. Since $\mathrm{cross}\succeq0$ one may write $\lVert\mathrm{cross}\rVert_F\le\mathop{\mathrm{tr}}(\mathrm{cross})$, but at $n=12$ that is $2.727$ against a true $0.455$, a factor $6$. Combined with L2's $\mathop{\mathrm{tr}}(W_\pm^\#)\le\tau^2$ the chain reaches $9.909=8.0\,\theta_0$, **worse than the $3.25\times$ Okumura baseline the record dismisses as the thing to beat**, and worsening with $n$ ($3.6,5.1,6.6,8.0$ at $n=6,8,10,12$).

So *"Theorem 1 controls the cross term exactly while L2 bounds the pieces"* is accurate about Theorem 1's identity and false about its reach. The package's theorems are not the obstruction; the orthogonality of the two halves at the very point where the bound must be sharp is.

---

## Claim 5, what the fence posts say

Evidence: [r274_c5_posts.py](../scripts/reviewers/r274/r274_c5_posts.py).

**Post F26, second half**, *"no bound exact at the coordinate-diagonal end $t=2$ and monotone below it can close, being $\ge\theta_0(n)$ at every $t<2$"* ([bispectral.md](../findings/bispectral.md), and $t=2$ iff $W$ is coordinate-diagonal). The balanced sphere product **is** coordinate-diagonal, so it sits at $t=2$, and there

$$\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\ =\ 1.032738,\ 1.014180,\ 1.007904,\ 1.005038,\ 1.001547,\ 1.001035\ \text{times }\theta_0$$

at $n=6,8,10,12,20,24$. **The bound is not exact at $t=2$**, so post F26's hypothesis is literally unmet, but that is not an escape. Post F26's conclusion is "$\ge\theta_0$ for $t<2$"; this bound is already $>\theta_0$ *at* $t=2$, the anchor post F26 borrows from Jäger's granted diagonal case. It fails post F26's test one step earlier than post F26 does.

**Post F29** does not reach it. Its mechanism is an $O(n)$-invariant quantity bounded by a frame-dependent one. Here $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ is $O(n)$-invariant: drift $\le1.1\times10^{-15}$ over 20 random $SO(n)$ rotations at $n=6,8$. No invariance mismatch exists to exploit.

**Post F33** does not reach it either. $\lVert M^\#\rVert_F$ is not determined by two moments of either spectrum plus a support bound, it depends on eigenvectors, not only eigenvalues. The record's reading here is right.

**Post F23** is likewise correctly cited: it fences off *linear* identities and explicitly leaves inequalities open.

**Verdict on the record's sentence.** *"Nothing on the fence-post list closes this route, which is the first time that has been true of a coupling attempt"*, the first clause is defensible for posts 23, 29 and 33, wrong in spirit for post F26, and **irrelevant either way**: the route is closed by the optimisation in claim 2, not by the list. Post F28's mechanism does apply to the *target* the section proposes (claim 3).

---

## Claim 6, the validation ledger

Evidence: [r274_c6_ledger.py](../scripts/reviewers/r274/r274_c6_ledger.py), [out_c6.txt](../scripts/reviewers/r274/out_c6.txt).

Validating **r259/r260's $r=6+\lvert\lambda\rvert/2$** ([plan.md:114](../plan.md)), independently and in two halves.

**(A) The criterion, tested sharp in both directions.** The $(2r-1)!!$ Brauer diagrams span $(V^{\otimes2r})^{O(n)}$ at every $n$; the claim is that they are *independent* iff $r\le n$. Their Gram matrix is $G_{D,D'}=n^{c(D\cup D')}$, whose size does not depend on $n$; its rank is the dimension of the span. Ranks taken modulo two 31-bit primes:

| $r$ | $\#$diagrams | $n=1$ | $2$ | $3$ | $4$ | $5$ | $6$ |
|---|---|---|---|---|---|---|---|
| $2$ | $3$ | $1$ | $\mathbf3$ | $3$ | $3$ | $3$ | $3$ |
| $3$ | $15$ | $1$ | $10$ | $\mathbf{15}$ | $15$ | $15$ | $15$ |
| $4$ | $105$ | $1$ | $35$ | $91$ | $\mathbf{105}$ | $105$ | $105$ |

Full rank exactly at $n\ge r$, and it **drops one step below**, $10<15$ at $(3,2)$, $91<105$ at $(4,3)$. The criterion is confirmed as an iff, not just as a sufficient condition.

**(B) The leg arithmetic.** A covariant is a map $V^{\otimes12}\to V_\lambda$. Pairing against $V_\lambda\subset V^{\otimes\lvert\lambda\rvert}$ turns it into an invariant functional on $12+\lvert\lambda\rvert$ legs, so the theorem's $r$ is $(12+\lvert\lambda\rvert)/2=6+\lvert\lambda\rvert/2$, and $\lvert\lambda\rvert$ ranges over $0,2,\dots,12$ for labels of $V^{\otimes12}$:

| $\lvert\lambda\rvert$ | $0$ | $2$ | $4$ | $6$ | $8$ | $10$ | $12$ |
|---|---|---|---|---|---|---|---|
| $r$ | $6$ | $7$ | $8$ | $9$ | $10$ | $11$ | $\mathbf{12}$ |
| $r\le n$ at $n=6$ | yes | no | no | no | no | no | no |
| $r\le n$ at $n=12$ | yes | yes | yes | yes | yes | yes | **equality** |

**VALIDATED.** The record's *"independence holds for every $n\ge6$"* is the $\lambda=\varnothing$ row alone; the widest blocks land at $r=12=n$, zero slack, which is r259/r260's point, and it is right.
