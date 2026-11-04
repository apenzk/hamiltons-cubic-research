# Review r931: Lemma L216, the explicit isolation radius

*Reviewer r931, 2026-09-13, Gate 2, identical brief to a second reviewer whose report was not read.* This round checked a written derivation link by link. Read: the L216 block of [second-order.md](../findings/second-order.md) with its Gate 1 note, L24's statement in the same file, L143 in [bounds.md](../findings/bounds.md), the L27 and L207 blocks of [nondegeneracy.md](../findings/nondegeneracy.md), L145's box, the withdrawn L215 radius block and I35 in [problem.md](../findings/problem.md), the [Bernstein notes](../references/queffelec-zarouf-2019-bernstein-inequality/notes.md), and [L216IsolationRadius.lean](../lean/HamiltonsCubic/Results/L216IsolationRadius.lean). Every step was re-derived by hand before its screen. Log: [agent_logs/gate2-l216-r931.log](../agent_logs/gate2-l216-r931.log).

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | Step 1, nearest point and normal direction | **GAP** | every step is right, but the text restricts to $s<\pi/2$ without showing $r<\pi/2$. The proof holds verbatim on $(0,\pi)$ and $r\le\pi$ is forced, a one-line repair |
| 2 | Corollary gap | **CONFIRMED** | the ten L27 values leave $\max(\lambda_p,\lambda_q,\mu,0,-\mu)=\max(\lambda_p,\lambda_q,\mu)$ off $\langle W\rangle$ and the tangent. $\gamma=1/(n-2)$ at balance, radii $0.02460$ and $0.01320$ |
| 3 | Step 2, trigonometric polynomial and L143 | **CONFIRMED** | a real cubic in $(\cos,\sin)$ has frequencies $1$ and $3$, and the circle lies in the unit sphere of $\mathcal W_n$ |
| 4 | Step 3, second derivative | **CONFIRMED** | the explicit expansion $\phi=\theta_0\cos^3+3\theta_0a\cos\sin^2+P(H)\sin^3$ gives $\phi''(0)=6\theta_0a-3\theta_0$ with the curvature term present and correctly signed |
| 5 | Step 4, Bernstein | **CONFIRMED** | the derivative of a degree-$\le3$ polynomial is again degree $\le3$, so the iteration gives $27$ |
| 6 | Step 5, Taylor and contradiction | **CONFIRMED** | the argument uses only the upper bound on $\phi'''$. Criticality forces $\phi'(s)=0$, so $\phi'(s)<0$ excludes it, which is the right direction |
| 7 | Equivariance | **CONFIRMED** | $Q(gX)=gQ(X)$ gives $L_{ge}=gL_eg^{-1}$, and $g$ maps $W_0^\perp\cap T_{W_0}\mathcal O^\perp$ isometrically onto the normal space at $W_1$ |
| 8 | Right set | **CONFIRMED** | $\mathrm{Crit}(P)\cap\{0<\mathop{\mathrm{dist}}(\cdot,\mathcal O)<r\}=\emptyset$ is orbit isolation, gauge copies are on $\mathcal O$. A Frobenius $\varepsilon_n$ converts through chord $\le$ arc |
| 9 | Hypotheses | **CONFIRMED** | $\theta_0>0$ is used in step 3's sign. L143 enters at step 2 only, and maximality nowhere |
| 10 | Exponent | **CONFIRMED** | $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n\to\sqrt2$ gives $\Theta(n^{-3/2})$. The L145 match is between two lower bounds on different quantities and carries no weight |
| 11 | Prior art | **CONFIRMED** | the record holds L145's penalised tube radius and the withdrawn L215 radius only, so "first explicit isolation radius for $P$" stands |
| 12 | Falsifiers | **CONFIRMED** | named four breaking objects. The screen at $(3,4)$ and $(4,5)$ found the spectrum and the normalisation exactly as the corollary needs |

**Summary: L216 is CONFIRMED subject to a one-line repair of step 1's range. Its corollary is CONFIRMED. The Lean file type-checks the real-variable Taylor and sign content of step 5 only.**

## 1. Step 1, the nearest point and the normal direction

- **The distance is attained.** $\mathcal O$ is the continuous image of the compact group $O(n)$, and $V\mapsto\langle W,V\rangle$ is continuous, so a maximiser $W_1=g\cdot W_0$ exists. Geodesic distance on the sphere is $\arccos\langle W,V\rangle$, decreasing in the inner product, so $W_1$ is a nearest point.
- **The normal direction follows from first order at the maximum.** For $\xi\in\mathfrak{so}(n)$, $t\mapsto\langle W,\exp(t\xi)\cdot W_1\rangle$ is stationary at $t=0$, so $\langle W,v\rangle=0$ for every $v\in T_{W_1}\mathcal O$. The orbit lies in the unit sphere, so $\langle W_1,v\rangle=0$. Writing $W=\cos s\,W_1+\sin s\,H$ with $H=(W-\cos s\,W_1)/\sin s$, a unit vector orthogonal to $W_1$, gives $\sin s\,\langle H,v\rangle=0$, hence $H\perp T_{W_1}\mathcal O$ whenever $\sin s\ne0$. The representation is exact.
- **Uniqueness of the nearest point is not needed.** Any maximiser serves: the argument uses only that $W_1$ is a nearest point on $\mathcal O$ and that the gap hypothesis holds there, which item 7 supplies for every point of the orbit.
- **The range $s<\pi/2$ is unused and unargued, which is the gap.** Nothing in steps 1 to 5 needs $\cos s>0$. The representation needs only $0<s<\pi$. As written, a critical point at distance $s\in[\pi/2,r)$ is not covered, and the block never shows $r<\pi/2$.
- **The repair is internal to the argument.** Take any unit normal $H$ at $W_1$. The point $c(\pi)=-W_1$ is critical, and $c'(\pi)=-H$ is tangent there, so $\phi'(\pi)=0$. Step 5 gives $\phi'<0$ on $(0,r)$, so $r\le\pi$. Hence every $s<r$ satisfies $s<\pi$ and the proof applies. *A sharper bound also holds: $\theta_0\le M$ and, by Banach's polarisation bound for symmetric trilinear forms, $\langle L_eH,H\rangle\ge-M/\theta_0$, so $\gamma\le\tfrac12+M/\theta_0$ and $r\le\tfrac29+\tfrac49=\tfrac23<\tfrac\pi2$.* **The fix is to replace $(0,\pi/2)$ by $(0,\pi)$ and add the $-W_1$ sentence.**
- The orbit is a smooth embedded submanifold because it is an orbit of a compact Lie group, which the tangent space in the statement presupposes.

## 2. The corollary's gap

- **L27's ten summands and values**: $1$ on $\langle W\rangle$, $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (the orbit tangent), $\lambda_p=\frac{p-2}{2(p-1)}$ on $S^2_0(\mathbb R^p)$, $\lambda_q$ on $S^2_0(\mathbb R^q)$, $+\mu$ on $\Lambda^2\otimes\Lambda^2$, $-\mu$ on $S^2_0\otimes S^2_0$, and $0$ on $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$.
- **The normal space is exactly the sum of the eight remaining summands**, because $\langle W\rangle$ and the tangent are eigenspaces of the symmetric $L_e$. The supremum of $\langle L_eH,H\rangle$ over unit $H$ there is the largest of the eight values. Since $\lambda_m\ge\tfrac14>0$ for $m\ge3$, that maximum is $\max(\lambda_p,\lambda_q,\mu)$, and $\tfrac12-\lambda_m=\frac1{2(m-1)}$. **The closed form $\min\big(\frac1{2(p-1)},\frac1{2(q-1)},\frac12-\mu\big)$ omits no summand.**
- **$\gamma>0$ is L27's range.** $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ off $(3,3)$.
- **Balanced product**, $p=q=m\ge4$: $\mu=\frac{1}{m-1}$, $\tfrac12-\mu=\frac{m-3}{2(m-1)}\ge\frac1{2(m-1)}$, so $\gamma=\frac1{2(m-1)}=\frac1{n-2}$, a three-way tie at $m=4$.
- **$\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$** ([fence-posts.md](../findings/fence-posts.md) line 39). That is $1.145644$ at $n=8$ and $1.236033$ at $n=12$, giving $r_8=4(1.145644)/(9\cdot6\cdot3.449490)=0.02460$ and $r_{12}=4(1.236033)/(9\cdot10\cdot4.162278)=0.01320$. Both printed values are correct.
- **Screen** (seconds, session scratchpad file /private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/screen_r931.py, uncommitted, on the record's [g1_le_machinery.py](../scripts/lib/g1_le_machinery.py)). I chose splits Gate 1 did not run. At $(3,4)$, where L207 says $\mu$ overtakes $\lambda_q$, the distinct eigenvalues below $\tfrac12$ are exactly $\{-\tfrac5{12},0,\tfrac14,\tfrac13,\tfrac5{12}\}$, the gap is $0.08333333$, the closed form is $\tfrac1{12}$, and $\dim E(\tfrac12)=12=pq$. At $(4,5)$ they are $\{-\tfrac7{24},0,\tfrac7{24},\tfrac13,\tfrac38\}$, the gap is $0.125=\tfrac1{2(q-1)}$, and $\dim E(\tfrac12)=20$. *A screen, reported as such.*

## 3. Step 2

- $\phi(\sigma)=\sum_{j=0}^3\binom3j\cos^{3-j}\sigma\,\sin^j\sigma\;T(W_1^{3-j},H^j)$ with $T$ the symmetric trilinear form of $P$. Each monomial of total degree $3$ in $\cos,\sin$ expands into $e^{\pm i\sigma}$ and $e^{\pm3i\sigma}$, so $\phi$ is a real trigonometric polynomial of degree at most $3$, the case $a_{-k}=\overline{a_k}$ of Theorem 1.1.
- $\lVert c(\sigma)\rVert^2=\cos^2\sigma+\sin^2\sigma=1$ because $W_1\perp H$ and both are unit, and $c(\sigma)\in\mathcal W_n$. L143 is a pointwise bound at unit norm on $\mathcal W_n$, so $\lvert\phi\rvert\le M$ everywhere. **No finding.**

## 4. Step 3, the second derivative

- **Gradient.** The form $\langle X,Y\circ Z\rangle$ is totally symmetric. The $W^2$ part gives $\tfrac12\mathop{\mathrm{tr}}(XYZ+XZY)$, which sums over all six orderings under cyclicity. The $\#$ part is the record's standard fact, and the Weyl projection is self-adjoint. So $DP_W[X]=3\langle Q(W),X\rangle$ and $D^2P_W[X,X]=6\langle X,W\circ X\rangle$. With $W_1=\theta_0e_1$, that is $6\theta_0\langle L_{e_1}H,H\rangle$, by the definition of $e$ alone.
- **Explicit expansion**, independent of the chain rule. $T(W_1,W_1,H)=\langle Q(W_1),H\rangle=\theta_0\langle W_1,H\rangle=0$ by criticality. $T(W_1,H,H)=\langle W_1,Q(H)\rangle=\theta_0a$ with $a=\langle L_{e_1}H,H\rangle$. So $\phi=\theta_0\cos^3\sigma+3\theta_0a\cos\sigma\sin^2\sigma+P(H)\sin^3\sigma$. Near $0$, $\cos^3\sigma=1-\tfrac32\sigma^2+O(\sigma^4)$ and $\cos\sigma\sin^2\sigma=\sigma^2+O(\sigma^4)$, so $\phi''(0)=-3\theta_0+6\theta_0a$.
- **The chain-rule form agrees.** $DP_{W_1}[c''(0)]=DP_{W_1}[-W_1]=-3P(W_1)=-3\theta_0$ by Euler's identity. The curvature term is present, negative, and has factor $3$. $\phi''(0)=6\theta_0(a-\tfrac12)\le-6\theta_0\gamma$ uses $\theta_0>0$. This is L24's $6\theta(L_e-\tfrac12)$ read on $H$.
- **Normalisation screen.** $\lvert\langle W,Q(H)\rangle-\theta\langle L_eH,H\rangle\rvert\le3.6\times10^{-16}$ over random $H\perp W$ at $(3,4)$ and $(4,5)$, with $\langle W,Q(H)\rangle$ read off $P(W\pm H)$, so the record's $L_e$ matrix carries the factor the step assumes. **No finding.**

## 5. Step 4, Bernstein

- If $T=\sum_{\lvert k\rvert\le N}a_ke^{ik\sigma}$ then $T'=\sum ika_ke^{ik\sigma}$ has degree $\le N$, so Theorem 1.1 applies again. $\lVert\phi'''\rVert_\infty\le3\lVert\phi''\rVert_\infty\le9\lVert\phi'\rVert_\infty\le27\lVert\phi\rVert_\infty\le27M$. **No finding.** *The constant is generous: the $e^{\pm i\sigma}$ part is damped, and Gate 1 reports a slack near ten. A floor is all the lemma claims.*

## 6. Step 5, the Taylor bound and the contradiction

- $\phi'(\sigma)=\phi'(0)+\phi''(0)\sigma+\int_0^\sigma(\sigma-t)\phi'''(t)\,dt\le-6\theta_0\gamma\sigma+\tfrac{27M}2\sigma^2$ for $\sigma\ge0$. Only $\phi'''\le27M$ enters, so a one-sided bound suffices. The right side is negative on $0<\sigma<\frac{12\theta_0\gamma}{27M}=\frac{4\theta_0\gamma}{9M}=r$. The arithmetic checks.
- $c'(s)=-\sin s\,W_1+\cos s\,H$ is a unit vector orthogonal to $c(s)$, so it is tangent to the sphere at $W$, and $\phi'(s)=DP_W[c'(s)]=\langle\nabla P(W),c'(s)\rangle=\langle\mathop{\mathrm{grad}}^{S}P(W),c'(s)\rangle$. A critical $W$ has zero Riemannian gradient, hence $\phi'(s)=0$.
- **The direction is right.** The lemma needs "critical implies $\phi'(s)=0$", whose contrapositive is "$\phi'(s)\ne0$ implies not critical". A gradient vanishing along the circle but nonzero elsewhere would make $\phi'(s)=0$ without criticality, which is harmless because the proof never infers criticality from $\phi'=0$. **No finding.**

## 7. The equivariance clause

- $O(n)$ acts on $\mathcal W_n$ by orthogonal maps, and $W\mapsto W^2$, $W\mapsto W^\#$ and the Weyl projection are equivariant, so $Q(gX)=gQ(X)$. Polarising gives $gX\circ gY=g(X\circ Y)$, and $P(gX)=\langle gX,gQ(X)\rangle=P(X)$.
- $W_1=gW_0$ is critical with $\theta_1=\theta_0$ and $e_1=ge$. From $L_{e_1}(gY)=g(e\circ Y)$ follows $L_{ge}=gL_eg^{-1}$.
- **The orbit-tangent condition transfers.** $g\cdot(\xi\cdot W_0)=(\mathop{\mathrm{Ad}}_g\xi)\cdot W_1$, so $gT_{W_0}\mathcal O=T_{W_1}\mathcal O$, and $g$ maps $W_0$ to $W_1$ isometrically. For unit $H$ normal at $W_1$, $g^{-1}H$ is unit normal at $W_0$, and $\langle L_{e_1}H,H\rangle=\langle L_eg^{-1}H,g^{-1}H\rangle\le\tfrac12-\gamma$. **No finding.**

## 8. Whether the radius is about the right set

- The conclusion is $\mathrm{Crit}(P)\cap\{W:0<\mathop{\mathrm{dist}}(W,\mathcal O)<r\}=\emptyset$, which is isolation of the whole orbit inside $\mathrm{Crit}(P)$. It applies to critical points of every value, including $\theta<0$.
- **Gauge-rotated copies are correctly allowed.** They lie on $\mathcal O$ at distance $0$, and the tube is measured from the orbit, never from a single point. This is exactly the defect r929 found in the withdrawn L215 radius, and here it is handled structurally.
- **For the localisation route**, a statement "every critical point above the rival lies within $\varepsilon_n$ of a rigid orbit" finishes with this lemma once $\varepsilon_n<r$ in geodesic distance. If $\varepsilon_n$ is a Frobenius chord, the condition is $2\arcsin(\varepsilon_n/2)<r$, satisfied by $\varepsilon_n<r$ since arc $\ge$ chord. *The orbit here is the $O(n)$-orbit, while L145 uses $SO(n)$. The larger orbit is what isolation modulo the full gauge needs, and a consumer should keep the group consistent.* **No finding.**

## 9. Scope and hypotheses

| Hypothesis | Where used |
|---|---|
| $W_0$ critical | step 3, $\phi'(0)=0$. Step 1, $W_1$ critical with the same $\theta_0$ |
| $\theta_0>0$ | $e=W_0/\theta_0$ defined, and step 3's inequality $6\theta_0(a-\tfrac12)\le-6\theta_0\gamma$. Also $r>0$ |
| gap $\gamma>0$ on the normal space | step 3 |
| $O(n)$-invariance of $P$, equivariance of $Q$ | step 1 |
| $\mathcal O$ a compact embedded submanifold | step 1, the tangent space and first variation |
| L24's Hessian formula, not its maximiser inequality | step 3 |
| L143 | step 2 only, as $M$, which propagates into steps 4 and 5 |
| Bernstein | step 4 |

- **Nothing about $W_0$ being a maximiser is used.** The lemma applies at saddles with a positive gap too.

## 10. The exponent

- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n\to\sqrt2$, so $r_n=\frac{4\theta_0(n)}{9(n-2)(1+\sqrt{n-2})}\sim\frac{4\sqrt2}{9}n^{-3/2}$. **$\Theta(n^{-3/2})$ is correct as a statement about this formula.**
- **The match with L145 is a coincidence of exponents between two lower bounds.** L145 is $\Omega(n^{-3/2})$ for a penalised functional's tube radius about the $SO(n)$-orbit at $n\ge12$. L216's $r_n$ is a sufficient radius, so it is a lower bound on the true isolation radius of $P$. Both reach $n^{-3/2}$ through $M=O(\sqrt n)$ against a gap $\Theta(1/n)$, so the agreement reflects the shared L143 input and says nothing about the true radius. The sentence is accurate arithmetic and should be read that way.

## 11. Whether it is already on the record

- Searched [findings/](../findings/), [reviews/](.) and [verification/](../verification/) for "isolation radius", "tube radius", "quantitative Morse" and "Bernstein's inequality". The hits are: L145 and its chain (L146 to L158) for the penalised functional, the withdrawn L215 radius (r929, r930), I35's filing note, and [r606](REVIEW_r606.md), which records that no $r_i$ was explicit. **None bounds the isolation radius of $P$ itself**, so the credit "first explicit isolation radius on the record" stands.
- **The mechanism is the standard quantitative-isolation argument**: a Hessian gap transverse to the critical manifold plus a uniform third-derivative bound. What is specific here is that the remainder constant comes from a global bound via Bernstein, so it transfers to every orbit. I ran no external literature search, and I claim no novelty beyond the record.

## 12. What would break it

1. **A summand of the normal space with an eigenvalue above $\max(\lambda_p,\lambda_q,\mu)$**, which would shrink $\gamma$. Checked analytically against L27's full list, and screened at $(3,4)$ and $(4,5)$, where the spectrum below $\tfrac12$ is exactly the five predicted values.
2. **A factor error between $D^2P$ and $L_e$**, which would rescale the margin. Re-derived by explicit expansion, and screened to $4\times10^{-16}$.
3. **L143 failing**, which would invalidate $M$. It is Gate 2 passed and dominated by F10's LP, which I inherit without re-derivation.
4. **A critical point strictly inside the tube**, the direct falsifier. Gate 1 sampled normal directions to $\sigma=0.6$ at three products. The antipode $-W_0$, the one critical point certainly off the orbit on every normal circle, lies at distance $\pi>r$, and it is what forces $r\le\pi$ in the step 1 repair.

- **The $(3,3)$ case correctly falls outside**: there $\gamma=0$ on the normal space, since the $\Lambda^2\otimes\Lambda^2$ summand carries $\tfrac12$, and the lemma asserts nothing.

## The Lean declarations

- **The file type-checks.** `lake env lean` on [L216IsolationRadius.lean](../lean/HamiltonsCubic/Results/L216IsolationRadius.lean) exits $0$, each of the three theorems depending only on propext, Classical.choice and Quot.sound.
- **What type-checks is the real-variable content of step 5, which is weaker than steps 4 and 5.** taylor_bound is the quadratic Taylor bound from an upper bound on the second derivative of $f=\phi'$. sign_step is the negativity below $2a/b$, and no_critical_in_tube composes them with the block's radius $4\theta\gamma/(9M)$ in the type. The conclusion is $f(s)<0$. **The step "$\phi'(s)<0$ implies $W$ is not critical" is untyped**, and no $P$, $\mathcal W_n$, sphere, orbit or $\phi$ appears.
- **Entering only as hypotheses**: hbern carries step 4 and step 2 together (degree three, Bernstein, L143's $M$), and only as a one-sided bound on $[0,\infty)$. h0 carries step 3's $\phi'(0)=0$, so criticality and $H\perp W_1$. h1 carries step 3's $\phi''(0)\le-6\theta\gamma$, so L24's Hessian, the curvature term and the gap. hM carries $M>0$.
- **Absent altogether, not even as hypotheses**: all of step 1 (attainment of the distance, the normal geodesic, the representation $W=\cos s\,W_1+\sin s\,H$, equivariance), and the range restriction item 1 flags.

## Verdicts

- **Lemma L216: CONFIRMED, subject to a one-line repair of step 1.** Replace $s\in(0,\pi/2)$ by $s\in(0,\pi)$ and note that $r\le\pi$ because $-W_1$ is critical on every normal circle. Every other link follows from the one above it and from the stated hypotheses.
- **Corollary at the sphere products: CONFIRMED.** The closed-form gap omits no L27 summand, $\gamma=1/(n-2)$ at the balanced product, $r_8=0.02460$ and $r_{12}=0.01320$, and $r_n=\Theta(n^{-3/2})$. The L145 exponent match is a shared-input coincidence between lower bounds, to be read as arithmetic only.
