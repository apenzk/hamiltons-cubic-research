# Gate 2 review r132, the norm budget, Schur–Horn, and the PSD margin

Commits under review: [eb309ed](../findings/diagonal-half.md), [fd7f5bb](../findings/bispectral.md), [194798c](../findings/diagonal-half.md), plus the mid-review rewrite [b53566a](../findings/bispectral.md) of claim E. Files: [findings/bispectral.md](../findings/bispectral.md), [findings/diagonal-half.md](../findings/diagonal-half.md), [findings/target.md](../findings/target.md).

Everything below is derived first and checked afterwards. The two scripts I opened ([scripts/runs/run_both_diagonals.py](../scripts/runs/run_both_diagonals.py), [scripts/review_r127_more.py](../scripts/review_r127_more.py)) were opened only after the derivations, to localise disagreements.

## Verdicts

| claim | verdict |
|---|---|
| A | CONFIRMED, and the record's parenthetical denying that $d$ is a diagonal of $\mathring W$ is FALSE |
| B | CONFIRMED, direction correct, but the proof uses no majorization |
| C | CONFIRMED as an inequality; OVERSTATED on attainment |
| D | CONFIRMED as algebra; the "coincidence" is explained, and it FAILS at odd $n$ |
| E | OVERSTATED in both directions, even after the rewrite |
| F | core CONFIRMED with a cleaner proof; three stated components FALSE or OVERSTATED |
| G | CONFIRMED, and upgraded from "tested" to proved for all $p,q\ge2$ |

## The object I derived first, since everything rests on it

For $S^p\times S^q$, $n=p+q$, sectional curvatures $k_p,k_q$ and Einstein constant $\rho=(p-1)k_p=(q-1)k_q$, the Weyl vertex matrix is

$$K_{ab}=\begin{cases} a_1=k_p\,q/(n-1) & a,b\in\text{block 1}\\ a_2=k_q\,p/(n-1) & a,b\in\text{block 2}\\ c=-\rho/(n-1) & \text{across.}\end{cases}$$

From the per-pair vertex equation at a cross pair, $\lambda=c+(p-1)a_1+(q-1)a_2=\rho\big(-1+q+p\big)/(n-1)=\rho$. So **$\lambda=\rho$ identically at every sphere product**. The spectrum of $K$ is $\{-a_1^{\,(p-1)},\,-a_2^{\,(q-1)},\,0,\,\lambda-c\}$, so

$$\mu_1(K)=\lambda+\lvert c\rvert=\lambda+\frac{\lambda}{n-1}=\frac{n\lambda}{n-1}.$$

Checked against the $\lambda$ and $\mu$ rows of [findings/target.md](../findings/target.md): the six $\lambda$ values and all six $\mu$ values reproduce to the printed digits, balanced and unbalanced.

## A, CONFIRMED, and the record disclaims its own justification

$\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=t/2$ because $t$ is the ordered sum. $K$ is symmetric with $K\mathbf1=0$, so $\mathbf1^\perp$ is $K$-invariant and the $n-1$ eigenvalues there have $\sum(\text{eig})^2=\lVert K\rVert_F^2-0^2=t$. Total $\tfrac32t$. Pure algebra, no diagonality used. **The brief's degeneracy worry is a non-issue**: whichever vector of a degenerate kernel is called "the one belonging to $\mathbf1$", the dropped eigenvalue is $0$, so the sum is $t$ either way. The mathematically correct object is $\mathop{\mathrm{spec}}(K|_{\mathbf1^\perp})$, which is always well defined.

**But the sentence attached to A is false.** [findings/bispectral.md](../findings/bispectral.md) says *"a reimplementation that read $d$ as a diagonal of $\mathring W$ in some basis of $S^2_0$ reproduces neither the identity nor the conclusion; the repo's construction is the correct one."* $d$ **is** exactly such a diagonal. Take the frame-adapted orthonormal basis of $S^2_0$

$$E_{ab}=\tfrac1{\sqrt2}(e_a\otimes e_b+e_b\otimes e_a)\ (a<b),\qquad \mathop{\mathrm{diag}}(v_k),\ \{v_k\}\ \text{an orthonormal eigenbasis of }K|_{\mathbf1^\perp}.$$

With the brief's convention $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$: $\langle E_{ab},\mathring WE_{ab}\rangle=K_{ab}$, and for diagonal $h$ one has $(\mathring Wh)_{ii}=-\sum_kW_{ikik}h_k=-(Kh)_i$, so the compression of $\mathring W$ to traceless diagonals is exactly $-K|_{\mathbf1^\perp}$ and those diagonal entries are $-\mathop{\mathrm{eig}}(K|_{\mathbf1^\perp})=d_\psi$. The counts match: $\binom n2+(n-1)=(n-1)(n+2)/2=\dim S^2_0$.

I built that basis independently on random Weyl tensors at $n=5,6,7$: Gram matrix $=I$ to $5\times10^{-16}$, and $\mathop{\mathrm{diag}}(\mathring W)$ in it equals $d$ to $2\times10^{-16}$, reproducing both $\sum d^2=\tfrac32t$ and $\omega\succ d$. The failed reimplementation the record cites almost certainly dropped the $1/\sqrt2$ on $E_{ab}$ (that gives $2K_{ab}$ and $\sum d^2=3t$). The repo's own script agrees with me and against the prose: [scripts/runs/run_both_diagonals.py](../scripts/runs/run_both_diagonals.py) names its function `npw_diag` and its docstring states "(ii) the psi-block of ringW is exactly -K restricted to 1-perp".

*Implementation note, secondary.* That script selects $d_\psi$ by `keep = [i for i in range(n) if abs(V[:,i] @ v1) < 0.9]`. If $0$ is a repeated eigenvalue of $K$, `eigh` may return a rotated kernel basis with no vector above the $0.9$ threshold, `dpsi` gets length $n$, and the majorization comparison is then between vectors of different lengths. Project onto $\mathbf1^\perp$ and diagonalise there instead.

## B, CONFIRMED, and the Schur–Horn machinery is not doing any work

$-d_{\min}=\max\{\max_{a<b}(-K_{ab}),\,\mu_1(K)\}$ is immediate from the two blocks of $d$. $\mu_1(K)$ is attained on $\mathbf1^\perp$ because $K\mathbf1=0$ and $\mathop{\mathrm{tr}}K=0$ force $\mu_1(K)>0$ for $K\ne0$. **Majorization direction, derived not quoted**: $\omega\succ d$ means $\sum_{i\le k}\omega_{[i]}\ge\sum_{i\le k}d_{[i]}$ for every $k$ with equality at $k=N$; subtracting the $k=N-1$ inequality from the $k=N$ equality gives $\omega_{[N]}\le d_{[N]}$, i.e. $\omega_{\min}\le d_{\min}$. So $\mu\ge-d_{\min}\ge\mu_1(K)$. The record has it the right way round.

**But no majorization is used.** $\omega_{\min}\le d_{\min}$ is nothing but the Rayleigh bound $\omega_{\min}\le\langle h,\mathring Wh\rangle$ applied at the single basis element attaining $d_{\min}$. Equivalently, $-\mu_1(K)$ is an eigenvalue of the compression of $\mathring W$ to traceless diagonals, and Cauchy interlacing gives $\omega_{\min}\le-\mu_1(K)$ in one line. Only partial sums of several entries would use majorization, and branch 1 needs only the extreme entry. This matters for E.

**Literature.** The mechanism is published, in the pair form. Both $E_{ij}$ and $(e_i\otimes e_i-e_j\otimes e_j)/\sqrt2$ have Rayleigh quotient $\pm R_{ijij}$, which is exactly why the literature gets "**two**-nonnegative curvature operator of the second kind $\Rightarrow$ nonnegative sectional curvature" ([Li 2021](https://arxiv.org/pdf/2112.08465), [Nienhaus–Petersen–Wink](https://www.math.ucla.edu/~petersen/Papers/64.pdf)) rather than needing full nonnegativity. Claim B is the same computation with the pair $(i,j)$ replaced by a general eigenvector of $K$; I found no source stating $\mu\ge\mu_1(K)$, so the statement looks unstated but the method is standard. **The record's "no spectral comparison exists" is scope-overstated in one place**: [Fluck–Li, dimension three](https://link.springer.com/article/10.1007/s12220-024-01639-0) publishes the two-sided comparison $\lambda_-\le a\le b\le c\le\lambda_+$ between the first- and second-kind spectra. It is inapplicable here ($W\equiv0$ at $n=3$), but "the literature carries nothing of this shape" is not right.

## C, CONFIRMED as an inequality, OVERSTATED on attainment

$K$ symmetric, $\mathop{\mathrm{tr}}K=0$, $K\mathbf1=0$: the $m=n-1$ eigenvalues on $\mathbf1^\perp$ sum to $0$ with squares summing to $t$, so $\mu_1\le\sqrt{t(m-1)/m}=\sqrt{t(n-2)/(n-1)}$, with equality iff that spectrum is $\big(x,-\tfrac x{n-2},\dots\big)$. Then $t\le2$ gives the stated ceiling.

**"Attained only when $t=2$" states a necessary condition as if it characterised.** $t=2$ is necessary and not sufficient: equality also needs the extremal spectral shape, i.e. $a_1=a_2$ among sphere products, i.e. **balanced only**. At $S^3\times S^4$, $t=2$ exactly and $\mu_1(K)=1.278019$ against a ceiling of $\sqrt{2\cdot5/6}=1.290994$.

## D, CONFIRMED as algebra; the coincidence is explained, and it fails at odd $n$

$n\theta_0(n)/(n-1)=\sqrt{2(n-1)(n-2)}/(n-1)=\sqrt{2(n-2)/(n-1)}$. Trivially identical.

**It is not a coincidence.** It is the single statement that the balanced sphere product saturates B and C simultaneously: there $\mu=\mu_1(K)$ (B tight), $\mu_1(K)=\sqrt{2(n-2)/(n-1)}$ (C tight), and $\lambda=(n-1)\mu/n$ (branch 1 tight). Since $\theta_0(n)$ *is defined* as the balanced-product value, the identity is that fact rewritten.

**And it fails for the odd-$n$ constant.** With $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))$,

$$\frac{\big(\text{cap}\big)^2}{\big(n\Theta_n/(n-1)\big)^2}=\frac{(n+1)(n-2)^2}{n^2(n-3)}=\frac{n^3-3n^2+4}{n^3-3n^2}>1 ,$$

the numerator exceeding the denominator by exactly $4$. So at odd $n$ the chain's ceiling sits strictly **above** what branch 1 needs, by a factor $\to1$. Consequence for E: at odd $n$ the chain certifies branch 1 throughout $\lambda\le\theta_0(n)$, a band that overshoots the true bound $\Theta_n$, at $n=13$, $\Theta_{13}=1.24836$ against $\theta_0(13)=1.24993$. That sliver is the only place the chain could ever act on a would-be counterexample, and it only opens for odd $n\ge13$.

## E, OVERSTATED in both directions, after the rewrite as before it

The rewrite in [b53566a](../findings/bispectral.md) fixes the direction error, and the fixed direction is right: branch 1 is a claim to be *proved*, proving it needs a **lower** bound on $\mu$, and B supplies one. That much is correct. Two things remain wrong.

**(i) It understates the failure.** Certification needs $\mu_1(K)\ge n\lambda/(n-1)$; with C that requires

$$\lambda\ \le\ \frac{n-1}n\sqrt{\frac{t(n-2)}{n-1}}\ =\ \theta_0(n)\sqrt{t/2}\ \le\ \theta_0(n).$$

At even $n$ the conjecture's own bound is $\theta_0(n)$, so **the chain can never certify branch 1 at any point that would be a counterexample**. Stronger still, branch 2 already covers $\lambda\le\sqrt{3/2}$, so the chain adds anything at all only when $\theta_0(n)\sqrt{t/2}>\sqrt{3/2}$, i.e.

$$t\ >\ \frac{3n^2}{2(n-1)(n-2)},$$

which exceeds $t_{\max}=2$ for every $n\le11$ ($2.700$ at $n=6$, $2.286$ at $n=8$, $2.083$ at $n=10$) and first drops below $2$ at $n=12$ ($1.964$). **The chain is not "tight only on the diagonal locus", it is entirely vacuous below $n=12$ and confined to $t\in(1.964,2]$ at $n=12$.** That reproduces, from the $t$-budget alone, the "inert through $n=11$, first fires at $n=12$" already recorded in [findings/target.md](../findings/target.md), and explains it.

**(ii) It mislocates the loss.** "Sharpening the majorization cannot help, because the loss is in the budget behind it" is true in conclusion and wrong in diagnosis: per B there is no majorization content in the chain to sharpen. The sharp statement about the family the rewrite names as open:

- Over **all** admissible $d$ (diagonals of $\mathring W$ in orthonormal bases of $S^2_0$), one has $\sup(-d_{\min})=\mu$ exactly, attained by any basis containing the bottom eigenvector. So the family carries **no cap whatsoever**; Schur–Horn is not the obstruction.
- **"A different frame" is definitively NO.** In a frame-adapted basis every diagonal entry is a function of $K$ alone: $-d_{\min}\le\max\{\sqrt{t/2},\sqrt{t(n-2)/(n-1)}\}=\sqrt{t(n-2)/(n-1)}$ for $n\ge3$, and $t\le2$ holds in **every** frame. Rotating the frame cannot escape the cap.
- **"A different pairing of the two Schur–Horn constraints" is also NO**, for the same reason: both constraints are frame-adapted, and the combined $d$ already contains both blocks.
- So the cap is a cap on *what the frame-diagonal data $K$ can certify*, nothing more. Escaping requires a test direction $h\in S^2_0$ that is not diagonal in any frame, one whose Rayleigh quotient sees the off-diagonal part $F$ of $W$. The record's own bottom-eigenvector candidate in [findings/target.md](../findings/target.md) is exactly such a direction; the open question should be restated as *which non-frame-adapted directions are controllable*, not as "which $d$".

The retirement itself is sound, and my (i) makes it stronger than the record claims.

## F, core CONFIRMED with a cleaner proof, three components wrong

**The core is right and deserves an analytic statement the record does not give.** At a diagonal critical point the vertex equation $K_{ab}^2+(W^\#)_{(ab),(ab)}=\lambda K_{ab}$ with $F=0$ and $(K^2)_{ab}=(W^\#)_{(ab),(ab)}$ gives, off the diagonal, $(K^2-\lambda K)_{ab}=-K_{ab}^2$, while $(K^2-\lambda K)_{aa}=\sum_cK_{ac}^2$. So

$$K^2-\lambda K\;=\;L(w),\qquad w_{ab}=K_{ab}^2\ge0,$$

verified to $6\times10^{-17}$ at ten sphere products. PSD, kernel = constants on each component, all as claimed.

**"The cross-block $K_{ab}$ are the LARGEST entries" is FALSE, at every sphere product.** $\lvert c\rvert/a_1=(p-1)/q$ and $\lvert c\rvert/a_2=(q-1)/p$; both exceeding $1$ needs $p-1>q$ and $q-1>p$ simultaneously, which is impossible. The four tabulated numbers $0.211,0.183,0.164,0.112$ are correct as *cross-block* values (the table's row label is accurate), but the largest entries at those points are $0.316,0.365,0.218,0.135$. At $S^2\times S^6$ the gap is a factor of six: cross $0.141$, maximum $0.845$. The conclusion survives, and the correct premise is far weaker and needs no numerics: $c=-\rho/(n-1)\ne0$ whenever $\rho\ne0$, so the weight graph contains a complete bipartite $K_{p,q}$ and is connected. The record proves connectivity from a false premise.

**"A margin that shrinks with $n$" is an artefact of tabulating near-balanced products.** The spectrum of $L(w)$ at $S^p\times S^q$ is $\{p\,a_1^2+q\,c^2,\ q\,a_2^2+p\,c^2,\ n\,c^2,\ 0\}$, so

$$\varepsilon_1=\min\{p\,a_1^2+q\,c^2,\ q\,a_2^2+p\,c^2,\ n\,c^2\},$$

and $\varepsilon_1=n c^2=\mu^2/n$ exactly when $p-1\le q$ and $q-1\le p$, which is all four tabulated cases, reproducing $0.267,0.233,0.214,0.152$ in closed form. Off that range the minimiser switches to a within-block eigenvector and the margin collapses at *fixed* $n$: at $n=8$, $\varepsilon_1=0.214$ at $S^4\times S^4$ but $0.0587$ at $S^2\times S^6$; at $n=10$, $0.178$ at $S^5\times S^5$ but $0.0754$ at $S^7\times S^3$. The governing variable is imbalance at least as much as $n$. Yes, $\varepsilon_1$ is the algebraic connectivity of the weight graph, by definition; it is normalisation-stable in the sense that $\lvert W\rvert=1$ fixes the scale, and it is $\Theta(1/n)$ along the balanced family only.

**"Breaks it beyond $\varepsilon_1$" is false as an implication.** Weyl's inequality gives sufficiency (a perturbation smaller than $\varepsilon_1$ preserves PSD on $\mathbf1^\perp$) and says nothing about perturbations larger than $\varepsilon_1$. The reconciliation of the two frame-rotation results does not need the second half anyway: a rotated frame leaves $W$ critical but non-diagonal, so the hypothesis of the PSD statement simply fails, while $K\mathbf1=0$ survives in every frame so the perturbation stays $\mathbf1^\perp$-preserving.

**Consistency with the r129 refutation: yes, and here is the precise reason.** The Laplacian identity consumes the per-pair vertex equation, which is criticality, not diagonality, the record's own display says this two paragraphs later, but the inserted paragraph never states the hypothesis it uses. The $n=8$ witness has $K\mathbf1=0$, hollowness and $t=2$ but criticality residual $0.002$, so $L(w)$ is not the right object there, and $\lambda_{\min}=-0.0034$ is the same order as the residual, a genuine near-miss, exactly what one expects of an exact statement on the critical set.

**Provenance defect.** The commit [eb309ed](../findings/diagonal-half.md) pairs this table with [scripts/review_r127_more.py](../scripts/review_r127_more.py), which computes $\mathbb{HP}^m$ and bi-invariant Lie group tensors and contains no cross-block entry, connectivity or spectral-gap computation. Nothing in [scripts/](../scripts/) produces the four $\varepsilon_1$ values. They are correct (I derived them in closed form) but as committed they are unsourced.

## G, CONFIRMED, and it should stop being a numerical observation

Branch 1 is an exact equality at **every** $S^p\times S^q$ with $p,q\ge2$, and here is the proof rather than the table. At any diagonal $W$ the frame-adapted basis of A **diagonalises** $\mathring W$: for $\{a,b\}\ne\{c,d\}$ every term of $\langle E_{ab},\mathring WE_{cd}\rangle$ is an off-diagonal $\Lambda^2$ component of $W$, hence zero, and the traceless-diagonal block is invariant because $(\mathring Wh)_{ij}=\sum_kW_{ikkj}h_k=0$ for $i\ne j$. So $\omega=d$ as multisets, majorization is equality throughout, and $\mu=\max\{\max_{a<b}(-K_{ab}),\mu_1(K)\}=\mu_1(K)$ since $\lvert c\rvert\ll\mu_1$. Combined with $\mu_1(K)=n\lambda/(n-1)$ from the top of this review,

$$\frac{n-1}n\,\mu=\lambda\quad\text{at every }S^p\times S^q .$$

Checked against the $\mu$ row of [findings/target.md](../findings/target.md) at all six products, unbalanced included, to the printed digits, plus $S^2\times S^4$, $S^2\times S^6$, $S^7\times S^3$.

The concentration reading is right: $\mu^2=n^2\lambda^2/(n-1)^2$, so at balanced products $\mu^2/3=2(n-2)/(3(n-1))$, which is $20/33=60.6\%$ at $n=12$ and $\to2/3$. **The useful corollary the record does not draw**: since $\mu_1(K)\le\sqrt{2(n-2)/(n-1)}=n\theta_0(n)/(n-1)$ always, branch 1 at any point with $\lambda>\theta_0(n)$ requires $\mu>\mu_1(K)$ **strictly**. The entire content of branch 1 at the dangerous points is the strict gap $\mu-\mu_1(K)$ between the second-kind bottom and the first-kind vertex top, and that gap is identically zero on the whole equality family. That is a sharper statement of "no lossy step" than the rhetorical one, and it names the quantity a proof has to lower-bound.

## The single most load-bearing defect

**[findings/bispectral.md](../findings/bispectral.md) denies that $d$ is the diagonal of $\mathring W$ in an orthonormal basis of $S^2_0$. It is, explicitly and verifiably, and the denial is the most costly sentence in these three commits.**

It costs two things. First, that reading is the **only** justification for $\omega\succ d$, the hypothesis claim B is built on; with the reading disclaimed, B is asserted without a proof and survives on numerics. Second, it hides that the "both-sided Schur–Horn" apparatus is exactly one Rayleigh quotient (Cauchy interlacing on the compression of $\mathring W$ to traceless diagonals) so there is no majorization to sharpen, and the file's earlier verdict that "applying Schur–Horn on both sides at once is the live direction" is the thing that should have been retired, on grounds of having no content, rather than on grounds of a budget behind it. The denial also contradicts the repo's own script, whose docstring states the identification.

**The fix**, three lines: state the basis $\{E_{ab}\}\cup\{\mathop{\mathrm{diag}}(v_k)\}$, record $\langle E_{ab},\mathring WE_{ab}\rangle=K_{ab}$ and $\Pi_{\text{diag}}\mathring W\Pi_{\text{diag}}=-K|_{\mathbf1^\perp}$, and derive $\mu\ge\mu_1(K)$ by interlacing. Then replace E's scope with the certification region $\lambda\le\theta_0(n)\sqrt{t/2}$, note the vacuity for $n\le11$, and restate the open question as the search for controllable **non-frame-adapted** test directions.
