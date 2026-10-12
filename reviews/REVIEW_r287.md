### Reviewer 287: the fourth-order condition at a critical point of a cubic on a sphere

Adversarial referee report on C1–C5. Everything below is argued from the definitions quoted in the brief. Numbers are recomputed on an independent code path: structure constants $c_{abg}=\langle[\phi_a,\phi_b],\phi_g\rangle$ from the index identity $[\phi_{ij},\phi_{kl}]=\delta_{jk}\phi_{il}-\delta_{jl}\phi_{ik}-\delta_{ik}\phi_{jl}+\delta_{il}\phi_{jk}$; the sharp from the contraction $(R^\#)_{ab}=\tfrac12 c_{apq}c_{brs}R_{pr}R_{qs}$; $\mathcal W_n$ as the orthogonal complement of $\Lambda^4+g\owedge\mathrm{Sym}^2$ inside $\mathrm{Sym}^2(\Lambda^2)$; the sphere products as the Weyl part of the Einstein product metric's own 4-tensor; padded $W_{\mathbb{CP}^2}$ from the constant-holomorphic-sectional-curvature tensor. Validation of that path: $R^\#(\mathrm{Id})=(n-2)\mathrm{Id}$ exactly, $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ for $n=5,\dots,8$, and agreement with `sharp`/`circ`/`weyl_basis` of [review_r30_core.py](../scripts/review_r30_core.py) to $3\times10^{-14}$ and with the repo's test points to $|\langle W_a,W_b\rangle|=1$. [run_fourth_order.py](../scripts/runs/run_fourth_order.py) was read but never imported.

| Claim | Verdict | Where it moves |
| --- | --- | --- |
| C1, the $t^4$ and $t^3$ coefficients | **CONFIRMED** | exact; the "no loss of generality" worry is settled, positively |
| C2, geodesic $t^4$ coefficient $=-3\theta/8$ | **CONFIRMED**, stronger than stated | scope correction: needs $\theta>0$; and it does not touch KT 6.7's actual conclusion |
| C3, $\langle b,B^+b\rangle\le\theta/2$ | **CONFIRMED** as a necessary condition | the fusion-rule half is a rederivation of KT's third-order step, not new content |
| C4, equality on the orbit tangent | **CONFIRMED**, with a sharper mechanism | the identity $B(X^2\!\cdot\!W)=(X\!\cdot\!W)\circ(X\!\cdot\!W)$ is what forces it |
| C5, the measurement | **SPLIT: dimensions CONFIRMED, the $S^3\times S^3$ reason REFUTED, the vacuity inference REFUTED** | $S^3\times S^3$ dies at third order; the supremum there is $+\infty$, not $1.653$ |

---

## C1, CONFIRMED, by argument

Verified by hand. With $x(t)=W+tz+\tfrac{t^2}{2}w$, $z,w\perp W$, $|z|=1$, $L_Wz=\tfrac\theta2 z$:

$$q(t)=|x(t)|^2=1+t^2+\langle z,w\rangle t^3+\tfrac14|w|^2t^4,$$
$$N(t)=P(x(t))=\theta+\tfrac{3\theta}{2}t^2+\Big[T(z,z,z)+\tfrac{3\theta}{2}\langle z,w\rangle\Big]t^3+\Big[\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle z\circ z,w\rangle\Big]t^4+\dots$$

The $t^2$ coefficient of $N$ uses $\langle Q(W),w\rangle=\theta\langle W,w\rangle=0$ and $T(W,z,z)=\langle L_Wz,z\rangle=\theta/2$. Writing $q=1+s$ and $(1+s)^{-3/2}=1-\tfrac32 s+\tfrac{15}8 s^2-\dots$ gives $d_2=-\tfrac32$, $d_3=-\tfrac32\langle z,w\rangle$, $d_4=-\tfrac38|w|^2+\tfrac{15}8$. Then

- $[t^3]P(\gamma)=N_3+\theta d_3=T(z,z,z)+\tfrac{3\theta}{2}\langle z,w\rangle-\tfrac{3\theta}{2}\langle z,w\rangle=T(z,z,z)$;
- $[t^4]P(\gamma)=N_4+N_2d_2+\theta d_4=\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{9\theta}{4}-\tfrac{3\theta}{8}|w|^2+\tfrac{15\theta}{8}$,

and $-\tfrac94\theta+\tfrac{15}8\theta=-\tfrac38\theta$, so $[t^4]=\tfrac34\langle(L_W-\tfrac\theta2)w,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}{8}$. Exactly C1.

**The two suspicions named in the brief both come back clean, and I state the positive facts they establish.**

*Truncating $x(t)$ at $t^2$ is fully general.* Adding $a_3\perp W$ changes $N$ by $6T(W,z,a_3)=3\theta\langle z,a_3\rangle$ at order $t^4$ and changes $q$ by $2\langle z,a_3\rangle t^4$, contributing $\theta\cdot(-\tfrac32)\cdot 2\langle z,a_3\rangle$; the two cancel identically. Adding $a_4\perp W$ contributes $3T(W,W,a_4)=3\theta\langle W,a_4\rangle=0$ to $N$ and $2\langle W,a_4\rangle=0$ to $q$. Components of $a_3,a_4$ along $W$ are absorbed by the scalar rescaling $x\mapsto x/\lambda(t)$, under which $P(x/|x|)$ is invariant, and the residue lands at order $\ge t^4$ perpendicular to $W$, where it is inert by the previous sentence. Structurally: at a critical point of $P|_S$ the $\gamma''''$ term of $d^4/dt^4$ has no gradient to pair with, and the $\mathrm{Hess}(P|_S)(z,\gamma''')$ term vanishes because $\mathrm{Hess}(P|_S)=6\theta(L_e-\tfrac12)$ annihilates $A(1/2)$.

*Taking $w\perp W$ loses nothing,* for the same rescaling reason: $W+tz+\tfrac{t^2}{2}(w_\perp+\beta W)=(1+\tfrac{\beta t^2}{2})\big[W+tz+\tfrac{t^2}{2}w_\perp-\tfrac\beta2 t^3z+O(t^4)\big]$.

*The $[t^3]=T(z,z,z)$ half genuinely needs $z\in A(1/2)$,* not merely $\langle L_Wz,z\rangle=\theta/2$: in general $[t^3]=T(z,z,z)+3\langle(L_W-\tfrac\theta2)z,w\rangle$. C1 assumes the eigenvector hypothesis, so this is a caution for reuse rather than a defect. Confirmed numerically: on random symmetric cubics with a planted critical point, null-cone directions that are not eigenvectors give $[t^3]-T(z,z,z)$ as large as $5.5$, while eigenvector directions give $<5\times10^{-15}$.

**Independent numerical corroboration.** Random fully symmetric $T$ on $\mathbb R^5,\mathbb R^8,\mathbb R^{12}$ with $W=e_0$ made critical by forcing $T_{00k}=\theta\delta_{0k}$, for $\theta=0.7$ and $\theta=2.3$: the $[t^4]$ formula holds to $3\times10^{-15}$ in every run.

## C2, CONFIRMED, and stronger than stated; but the "zero information" corollary needs two scope corrections

Setting $w=0$ in the display gives $[t^4]=-3\theta/8$ immediately. Two independent confirmations:

1. **The arclength great circle.** $P(\cos s\,W+\sin s\,z)=\theta\cos^3 s+3\tfrac\theta2\cos s\sin^2 s+\sigma\sin^3 s=\theta+\sigma s^3-\tfrac{3\theta}{8}s^4+O(s^5)$, using $T(W,W,z)=\theta\langle W,z\rangle=0$. Same number, so the difference between $t=\tan s$ and arclength is invisible at order 4 (as it must be, the $s^2$ coefficient being zero).
2. **Generic cubics**, as above: $|[t^4]_{\text{geodesic}}+3\theta/8|<3\times10^{-15}$ across all runs.

**The claim is true in a wider range than stated.** For arbitrary unit $z\perp W$, $[t^4]_{\text{geodesic}}=-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$. So the value $-3\theta/8$ holds for *every* $z$ on the null cone of $L_W-\tfrac\theta2$ (every direction in which the second-order term vanishes), not only for $\tfrac12$-eigenvectors. That is the honest statement of the phenomenon: whenever the geodesic second-order term dies, the geodesic fourth-order term is $-3\theta/8$, a number fixed by the degree of $P$ and the critical value alone. My generic-cubic runs confirm it at genuine non-eigenvector null directions.

**Correction 1, the strictness needs $\theta>0$.** At $\theta<0$ the coefficient is $+3|\theta|/8>0$ and the fourth-order inequality is *violated*, i.e. decisive rather than vacuous. C2's blanket "at every critical point of every cubic form" therefore overstates: read it as "at every critical point with positive critical value". This costs nothing at a local maximum, where $\theta=\max P|_S\ge 0$ because $P(-x)=-P(x)$, but the sign hypothesis has to be carried.

**Correction 2, this does not empty Krasnov–Tkachev Prop 6.7.** The transcription in [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) is explicit that the fusion rule is obtained from the **third** derivative: "*The third-derivative identity evaluates to $\langle z^2;z\rangle=0$*." The fourth-derivative inequality is stated alongside and is not what carries Prop 6.7's conclusion. So the correct scope of C2's corollary is: *the fourth-derivative remark accompanying Prop 6.7 is vacuous*, and Prop 6.7 itself is untouched. Any statement of the form "Prop 6.7 carries zero information" is false. C2 as written invites that reading and should be reworded.

**A byproduct worth banking.** The notes flag a sign question ("$\partial^4f/\partial z^4|_c\ge0$ as printed), check the sign against the maximum convention". The computation settles it: with $f(x)=\langle x^2;x\rangle/|x|^3$ and $c$ extremal, $\partial^4 f/\partial z^4|_c=4!\,|c|^{-4}\cdot(-\tfrac38\theta)=-9\theta|c|^{-4}<0$. The maximum convention gives $\le0$; the printed $\ge0$ is the opposite convention.

## C3, CONFIRMED as a necessary condition, with the novelty relocated

The derivation is correct and I reproduce it. At a local maximum, the second variation along the geodesic in direction $z\perp W$ is $6\langle L_Wz,z\rangle-3\theta|z|^2\le0$; $L_W$ is self-adjoint (T fully symmetric) and $L_WW=Q(W)=\theta W$, so $W^\perp$ is $L_W$-invariant and the quadratic-form inequality is the operator inequality $L_W\le\tfrac\theta2$ on all of $W^\perp$. The tangent space to the sphere at $W$ *is* $W^\perp$, so there is no part of $W^\perp$ left out and no radial direction wrongly included, the brief's worry does not bite.

With $B=\tfrac\theta2-L_W\succeq0$ on $W^\perp$ and $c=P_{W^\perp}(z\circ z)$, C1 reads $[t^4](w)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle c,w\rangle-\tfrac{3\theta}{8}$, a concave quadratic in $w$. Its supremum is $\tfrac34\langle c,B^+c\rangle-\tfrac{3\theta}{8}$, finite exactly when $c\perp\ker B=A(1/2)$; requiring it $\le0$ is $\langle b,B^+b\rangle\le\theta/2$. Correct. The fourth-order test is legitimately applicable because along every such curve $[t^2]=0$ (for $w\perp W$, $N_2=\tfrac{3\theta}{2}$ cancels against $\theta d_2$) and $[t^3]=T(z,z,z)=0$ at a maximum; and for each fixed $w$ the expansion is a genuine Taylor expansion in $t$, so the $\lambda\to\infty$ argument on $w=\lambda y$, $y\in\ker B$, is legitimate.

Three corrections to how C3 is stated.

- **"Finiteness of the supremum over $\ker B$ is equivalent to the fusion rule" is right but is not new information.** It rederives from the fourth variation what KT get from the third. Polarising $\langle z\circ z,y\rangle=0$ over $z\in A(1/2)$ recovers $A(1/2)A(1/2)\subset A(1/2)^\perp$ either way. The genuinely new content of C3 is only the quantitative inequality $\langle b,B^+b\rangle\le\theta/2$ on the directions where the fusion rule already holds.
- **The condition is per-$z$ and conditional.** It is a necessary condition at each unit $z\in A(1/2)$ *given* $T(z,z,z)=0$; if the third-order term is nonzero the point is already refuted and the fourth-order expression is not a test of anything.
- **It has never been exhibited as a live finite constraint in this project.** At every measured point with zero excess it is an equality by C4; at the one measured point with nonzero excess the fusion rule fails and the quantity is $+\infty$. So the inequality is, so far, a theorem without a single nontrivial instance.

## C4, CONFIRMED, and the mechanism is sharper than the one C4 gives

Both halves hold, and the brief's specific suspicion, whether $e^{tX}W$ really supplies an admissible corrector and whether its higher-order terms matter, resolves in C4's favour, for a reason C4 does not state.

Write $c(t)=e^{tX}\!\cdot\!W$, $z=X\!\cdot\!W$, $u=X^2\!\cdot\!W$. Since $G$ acts orthogonally and leaves $P$ invariant, $Q$ is equivariant, so $Q(c(t))=\theta\,c(t)$ identically.

- $\tfrac{d}{dt}$ at $0$: $DQ_W(z)=2L_Wz=\theta z$, so the orbit tangent lies in $A(1/2)$ with no hypothesis at all.
- $\tfrac{d^2}{dt^2}$ at $0$: $2\,z\circ z+2L_Wu=\theta u$, i.e.
  $$\boxed{\;B\,u=z\circ z\;},\qquad B=\tfrac\theta2\mathrm{Id}-L_W .$$
  Projecting off $W$ and using $\langle u,W\rangle=-|z|^2$, $BW=-\tfrac\theta2 W$, $\langle z\circ z,W\rangle=\tfrac\theta2|z|^2$ gives $B\,v=\Pi(z\circ z)$ for $v=P_{W^\perp}(u)$.

This is the point. $v$ is not merely *a* corrector that happens to achieve $0$; it is the **stationary point** of the concave quadratic $w\mapsto[t^4](w)$, whose stationarity condition is precisely $Bw=\Pi(z\circ z)$. Given $B\succeq0$ the stationary point is the maximiser, so $\sup_w[t^4]=[t^4](v)$, and $[t^4](v)=0$ because $P(c(t))\equiv\theta$. Hence $\langle b,B^+b\rangle=\theta/2$ exactly. C4's own phrasing ("*local maximality caps the sup at 0*"), is a weaker and, on its own, insufficient argument: exhibiting one corrector with value $0$ bounds the supremum from below, not above. The bound from above comes from stationarity, and stationarity is the second-derivative identity, not the maximality hypothesis.

Three further points that C4 gets right or should claim:

- **Higher-order terms of the orbit curve are irrelevant**, by the C1 jet argument above; $c(t)$ and $W+tz+\tfrac{t^2}{2}u$ agree to $O(t^3)$ and that is all that $[t^3],[t^4]$ see.
- **$T(z,z,z)=0$ on the orbit tangent needs no maximality**: $[t^3]$ of $P(c(t))\equiv\theta$ is $T(z,z,z)+3\langle L_Wz,u\rangle=T(z,z,z)+\tfrac{3\theta}{2}\langle z,u\rangle$, and $\langle X\!\cdot\!W,X^2\!\cdot\!W\rangle=0$ because $X$ acts antisymmetrically.
- **The fusion rule is likewise automatic there**: for $y\in A(1/2)=\ker B$, $\langle z\circ z,y\rangle=\langle Bv,y\rangle=\langle v,By\rangle=0$. So both KT conditions are vacuous on the orbit tangent with no hypothesis whatever, which is a cleaner statement than C4's.
- **Only the identification "$\sup=\theta/2$" needs $B\succeq0$**, exactly as C4's parenthesis says.

**Numerically confirmed on the independent path.** The identity $\tfrac\theta2 u-W\circ u=z\circ z$ holds to $4\times10^{-16}$ in the ambient $\mathrm{Sym}^2(\Lambda^2)$ at $S^3\times S^3$, $S^4\times S^4$ and padded $W_{\mathbb{CP}^2}$; the quartic coefficient at the orbit corrector is $<8\times10^{-16}$; and $\langle b,B^+b\rangle=\theta/2$ to $10^{-9}$ on every orbit direction at all six test points. (Separately: $\circ$ maps $\mathcal W_n\times\mathcal W_n$ into $\mathcal W_n$, relative deviation $5\times10^{-16}$, so ambient and projected products coincide and there is no ambiguity in what $z\circ z$ means.)

## C5, the dimension table CONFIRMED; the $S^3\times S^3$ reason REFUTED; the vacuity inference REFUTED

### The dimensions are right

Recomputed end to end on the independent path (own $c$, own $\#$, own $\mathcal W_n$, own test points, own $L_W$):

| point | $n$ | $\theta$ | crit. residual | $\dim A(1/2)$ | orbit tangent | excess |
| --- | --- | --- | --- | --- | --- | --- |
| $S^3\times S^3$ | 6 | 1.054092553 | $2.5\times10^{-16}$ | 18 | 9 | **9** |
| $S^4\times S^4$ | 8 | 1.145643924 | $8.2\times10^{-16}$ | 16 | 16 | 0 |
| $S^6\times S^6$ | 12 | 1.236033081 | $2.6\times10^{-15}$ | 36 | 36 | 0 |
| $S^5\times S^7$ | 12 | 1.228239158 | $3.2\times10^{-15}$ | 35 | 35 | 0 |
| padded $W_{\mathbb{CP}^2}$ | 8 | 1.224744871 | $4.4\times10^{-16}$ | 18 | 18 | 0 |
| padded $W_{\mathbb{CP}^2}$ | 10 | 1.224744871 | $4.4\times10^{-16}$ | 26 | 26 | 0 |
| padded $W_{\mathbb{CP}^2}$ | 12 | 1.224744871 | $4.4\times10^{-16}$ | 34 | 34 | 0 |

The eigenvalue count is stable between tolerances $10^{-7}$ and $10^{-5}$ at every row, and the orbit tangent inclusion $\subset A(1/2)$ holds to $8\times10^{-15}$. The orbit dimensions match the a priori Lie count $\tfrac{n(n-1)}2-\dim\mathfrak{isotropy}$: $pq$ for $S^p\times S^q$ with isotropy $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, and $\tfrac{n(n-1)}2-4-\tfrac{(n-4)(n-5)}2$ for padded $W_{\mathbb{CP}^2}$ with isotropy $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$, $18,26,34$ for $n=8,10,12$. So the measurement is not a numerical accident of one code path.

### The $S^3\times S^3$ verdict is right; the reason given for it is wrong

C5 says the C3 condition is violated with $\sup=1.653$ against $\theta/2=0.527$. Three things are wrong with that.

1. **$S^3\times S^3$ fails at third order, before the fourth-order condition applies.** On the 9-dimensional excess, $\max|T(z,z,z)|=0.395017$ over 4000 sampled directions. Directly from the definition, with no machinery: along the maximising $z$, $P(\gamma(t))-\theta$ is $+1.06\times10^{-8}$ at $t=-0.003$, $+3.91\times10^{-7}$ at $t=-0.01$, $+1.03\times10^{-5}$ at $t=-0.03$, tracking the $\sigma t^3$ prediction to three digits. $P$ strictly increases; the point is not a local maximum. The fourth-order condition is never reached.
2. **The supremum in C3 is $+\infty$, not $1.653$.** On the same excess directions $\max\|\Pi_{A(1/2)}(z\circ z)\|=0.406$, so $z\circ z$ has a component in $\ker B$ and $\sup_w[t^4]=+\infty$ by C3's own $w=\lambda y$ argument. The fusion rule fails at $S^3\times S^3$.
3. **The number itself is a sampled maximum of a different quantity.** $\langle\Pi(z\circ z),B^+\Pi(z\circ z)\rangle$ deletes exactly the $\ker B$ component that makes the true supremum infinite, so it is a *constrained* supremum over $w\perp\mathrm{span}(W)+A(1/2)$, a restriction absent from C1 and C3. Even as that surrogate, $1.653$ is undersampled: my own 200-sample draw gives $1.684$ and gradient ascent from 40 starts reaches $1.712900$.

Since the current [run_fourth_order.py](../scripts/runs/run_fourth_order.py) on disk already reports $\max|T(z,z,z)|$ and the $\ker B$ component in place of a finite "sup" at (3b), points 2 and 3 appear to be recognised; C5 as stated in the brief is the superseded version and should not be quoted.

Worth banking positively: at $S^3\times S^3$ the **second**-order condition is satisfied exactly, $\min\langle Bu,u\rangle/|u|^2$ over $W^\perp$ is $-9.5\times10^{-16}$, i.e. $L_W\le\theta/2$ holds, while the third-order condition kills the point. The higher-variation calculus is strictly stronger than the second-order tool at a point where both are computable. (Corroborating context, computed on the same path: $\theta_{\mathbb{CP}^3}=1.054092553$ at $n=6$, numerically identical to $\theta_{S^3\times S^3}$, so $n=6$ carries a degenerate critical set larger than either orbit, consistent with a 9-dimensional excess.)

### The inference "hence the apparatus is entirely vacuous" is refuted

This is the part that overreaches its evidence, and it overreaches in the direction that matters for the plan's stall trigger.

- **The measurement is taken exactly where it cannot find content.** Excess $=\dim A(1/2)-\dim(\text{orbit tangent})$, and the orbit tangent is large precisely when the isotropy group is small, i.e. at the *most* symmetric points. All seven rows are maximally symmetric homogeneous models. The object route P is aimed at is a hypothetical **non-graded** local maximiser, which by construction has less symmetry, hence a *smaller* orbit tangent, hence (for any given $A(1/2)$), *more* excess. The F1 instrument as run is structurally incapable of returning "content" at the object of interest, so returning "vacuous" at these seven points is close to zero evidence about it.
- **C5's own data shows the apparatus is not intrinsically vacuous.** The one row with nonzero excess is the one row where the apparatus bites, and it bites hard enough to refute the point while the second-order tool cannot. Read correctly, the measurement says: *the third/fourth-order conditions are exactly the conditions "$P$ has no third-order ascent transverse to the orbit", vacuous on the orbit tangent by C4 and live off it.* That is a statement about where the tool has content, not that it has none.
- **What C4 actually licenses.** C4 proves the apparatus is vacuous on the orbit tangent, for every critical point, unconditionally. That is a genuine and complete negative result, and it is the right thing to carry forward: any use of Prop 6.7 must be shown to consume excess directions, or it is proving $0=0$. What C4 does **not** license is any statement about points whose excess is unknown.

So the honest reading of F1 is neither "passed" nor "failed" as the plan's trigger phrases it: it is *the criterion for route P having content has been identified and localised* (namely $\dim A(1/2)>\dim(\text{orbit tangent})$), *and shown to be unmet at every point where it was measurable and where the answer was already known.* Route P's stall trigger reads "F1 showing vacuity"; on the evidence gathered, vacuity has been shown only on the orbit tangent, which C4 settles by pure invariance and which was never where the information could have been. Closing P1 on this evidence would be closing it on a measurement that could only ever have come out this way.

---

## Method statement

**Verified by argument** (no computation load-bearing): all of C1 including the generality of the parametrisation; C2's coefficient and its extension to the whole null cone; C2's two scope corrections; C3's derivation, its equivalence with the fusion rule, and the $L_W\le\theta/2$ step; all of C4, including the identity $Bu=z\circ z$ and the stationarity that replaces C4's cap argument; the structural objection to C5's vacuity inference.

**Verified by computation on an independent code path**: the C1/C2 formulas on generic random cubics with planted critical points ($m=5,8,12$, $\theta\in\{0.7,2.3\}$, eigenvector and null-cone directions); every row of the C5 dimension table; the orbit-direction equality $\langle b,B^+b\rangle=\theta/2$ at all seven points; the $S^3\times S^3$ third-order failure and the direct line search showing $P(\gamma(t))>\theta$; the surrogate value $1.7129$ replacing $1.653$; and the validation of the code path itself ($R^\#(\mathrm{Id})=(n-2)\mathrm{Id}$, $\dim\mathcal W_n$, agreement with [review_r30_core.py](../scripts/review_r30_core.py)).

**Not settled here**: whether any critical point of $P$ on $\mathcal W_n$ with positive excess and a satisfied fusion rule exists, the case in which C3's inequality would first become a live finite constraint. No such point appears in the project's test set, and an argument, not a search, is what would settle it.


---

## Synthesis carried in REVIEW.md

### Reviewers 287 and 288: the fourth-order condition at a critical point of a cubic on a sphere

Full reports in [REVIEW_r287.md](reviews/REVIEW_r287.md) and [REVIEW_r288.md](reviews/REVIEW_r288.md). Identical briefs, independent implementations, **five matching verdicts**.

**What they confirmed.** The exact jet at a critical point, $[t^3]P(\gamma)=T(z,z,z)$ and $[t^4]P(\gamma)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8$, with the parametrisation shown to lose no generality; the orbit identity $B(X^2\!\cdot\!W)=(X\!\cdot\!W)\circ(X\!\cdot\!W)$ and every consequence drawn from it; and all seven excess dimensions, recomputed from scratch and matched against the a priori Lie count.

**What they broke, and it is the cycle's own overreach.** *The inference that the calculus is therefore vacuous everywhere.* **Reviewer 288's form of this is correct and sufficient**: excess $=0$ *is* Morse–Bott nondegeneracy, already a theorem at all six points, so the measurement re-derives what was known and leaves *degenerate* maximisers untouched, and nothing excludes a maximiser from being degenerate. **Reviewer 287's structural form is inverted and does not stand**, validated against its own table before being applied: it argues that a less symmetric maximiser has a *smaller* orbit tangent and hence more excess, whereas smaller isotropy gives a **larger** orbit tangent ($\tfrac{n(n-1)}2=66$ at trivial isotropy against $36$ at $S^6\times S^6$) which makes excess strictly *harder*. And the one row carrying excess is $S^3\times S^3$ at isotropy $6$ of $15$, among the **most** symmetric points tested. *The verdict on the cycle's closure survives on r288's reasoning alone.*

**Two further corrections carried into the record.** The universality of $-3\theta/8$ holds on $A(\tfrac12)$ and not for arbitrary $z$, and the reason first given for it was wrong; and Krasnov–Tkachev Prop 6.7 is **not** emptied, only the fourth-derivative remark beside it is, the fusion rule itself being a third-derivative statement.

**What they add that the cycle did not have.** $T(X\!\cdot\!W,z_1,z_2)=0$ for all $z_1,z_2\in A(\tfrac12)$, so the third-order condition depends on the excess component alone, while the fourth-order one does not, $\Pi(o\circ e)\ne0$. And the observation that C3's inequality, though a theorem, has **no nontrivial instance** in the project: equality wherever excess vanishes, $+\infty$ at the one point with excess. *A critical point with positive excess and a satisfied fusion rule is what would first make it a constraint.*
