# Review r932, Gate 2 on Lemma L216 (explicit isolation radius)

This round checked a written derivation link by link, on a cold brief identical to the second reviewer's. Read: the L216 block of [second-order.md](../findings/second-order.md), L24 and L145 to L147 in the same file, L143 in [bounds.md](../findings/bounds.md), the L27 and L207 blocks of [nondegeneracy.md](../findings/nondegeneracy.md), the Bernstein notes at [notes.md](../references/queffelec-zarouf-2019-bernstein-inequality/notes.md), the Lean file [L216IsolationRadius.lean](../lean/HamiltonsCubic/Results/L216IsolationRadius.lean), I35 in [problem.md](../findings/problem.md) and [plan.md](../plan.md), and the Gate 1 script [screen_isolation_radius.py](../scripts/runs/screen_isolation_radius.py). Log: [agent_logs/gate2-l216-r932.log](../agent_logs/gate2-l216-r932.log). Every positive verdict below rests on the hand derivation. The seconds-scale screen in section 13 is reported as a screen.

| # | Item | Verdict | Reason |
|---|------|---------|--------|
| 1 | Step 1, nearest point and normal direction | CONFIRMED | distance attained by compactness, normality from maximising $\langle W,g_tW_1\rangle$, formula exact for $0<s<\pi$, uniqueness unused, and $r\le2/3$ puts the only $s$ that matter below $\pi/2$ |
| 2 | Corollary gap from L27's ten summands | CONFIRMED | the eight summands off $\langle W\rangle$ and $\mathbb R^p\otimes\mathbb R^q$ carry $0,0,0,0,\lambda_p,\lambda_q,\mu,-\mu$, and $\tfrac12$ minus their maximum is the stated min, including the $(3,4)$ exception, $\gamma=1/(n-2)$ at $n=2m\ge8$, radii $0.0246015$ and $0.0131983$ |
| 3 | Step 2, trigonometric polynomial and L143 | CONFIRMED | a real homogeneous cubic in $(\cos,\sin)$ has frequencies $1$ and $3$ only, and the circle lies in the unit sphere where L143 is a pointwise bound |
| 4 | Step 3, second derivative factors | CONFIRMED | chain rule gives $D^2P[H,H]+DP[c'']$, total symmetry of $\langle X\circ Y,Z\rangle$ gives $6\langle W_1\circ H,H\rangle$, Euler gives $DP_{W_1}[W_1]=3\theta_0$ |
| 5 | Step 4, Bernstein iteration and 27 | CONFIRMED | $\phi'$ and $\phi''$ are again real trigonometric polynomials of degree at most $3$, so three applications give $3^3M$ |
| 6 | Step 5, Taylor bound and contradiction | CONFIRMED | integral remainder needs only $\phi'''\le27M$, $c'(s)\perp c(s)$ makes $\phi'(s)$ the Riemannian gradient paired with a unit tangent, and the contradiction runs critical $\Rightarrow\phi'(s)=0$, the correct direction |
| 7 | Equivariance clause | CONFIRMED | $Q(gX)=gQ(X)$ for every $g\in O(n)$, the action is isometric and $T_{gW_0}\mathcal O=g\,T_{W_0}\mathcal O$, so the whole hypothesis transports |
| 8 | Right set for isolation | CONFIRMED | the conclusion is $\mathrm{Crit}(P)\cap\{0\le\mathop{\mathrm{dist}}<r\}=\mathcal O$, which is what "$\varepsilon_n<r_i$ finishes the localisation" consumes, with the distance geodesic |
| 9 | Hypothesis inventory | CONFIRMED | $\theta_0>0$ enters three times, criticality once, maximality never, L143 only through $M$, and the metrised identity is load-bearing inside "L24's Hessian formula" |
| 10 | The exponent | CONFIRMED | $\theta_0(n)\to\sqrt2$ gives $r_n\sim\tfrac{4\sqrt2}9n^{-3/2}$, a $\Theta$ of the displayed floor and an $\Omega$ for the true radius, and the L145 exponent match shares a mechanism while measuring a different object |
| 11 | Prior record and literature | CONFIRMED | no explicit radius for $\mathrm{Crit}(P)$ exists on the record, and L145 to L147's $P$-side branch is the same margin-over-$\sup\lvert P\rvert$ mechanism for the penalised functional, owed a credit line |
| 12 | What would break it | CONFIRMED | falsifiers named (a normal $H$ above $\tfrac12-\gamma$, a failure of total symmetry, a failure of L143), and the screen found none at four splits outside Gate 1 |

**Summary: L216 and its corollary both stand as written, and the Lean file type-checks step 5's calculus alone, with steps 1 to 4 entering as hypotheses.**

## 1. Step 1, the nearest point and the normal direction

- **Attainment.** $O(n)$ acts on $\mathcal W_n$ by $\Lambda^2g$-conjugation, which is Frobenius-isometric, so $\mathcal O$ is a compact subset of the unit sphere and $\mathop{\mathrm{dist}}(W,\cdot)$ attains its minimum on it at some $W_1=gW_0$.
- **Exactness of the circle.** For $0<s<\pi$ the minimising arc from $W_1$ to $W$ is unique, and with $H=(W-\cos s\,W_1)/\sin s$ one has $H\perp W_1$, $\lVert H\rVert=1$ and $W=\cos s\,W_1+\sin s\,H$ exactly.
- **Normality, by a first variation the reader can check in one line.** For $\xi\in\mathfrak{so}(n)$ put $W_1(t)=\exp(t\xi)W_1\in\mathcal O$. Since $\cos\mathop{\mathrm{dist}}(W,W_1(t))=\langle W,W_1(t)\rangle$ is maximal at $t=0$, $0=\langle W,\xi W_1\rangle=\cos s\,\langle W_1,\xi W_1\rangle+\sin s\,\langle H,\xi W_1\rangle=\sin s\,\langle H,\xi W_1\rangle$, the first term vanishing because the action is isometric. With $\sin s\ne0$ this is $H\perp T_{W_1}\mathcal O$.
- **Why $s<\pi/2$.** Nothing forces it for a general $W$, and the proof uses $s$ only in $(0,r)$. What makes the window harmless is that $r\le2/3$ always: for any unit normal $H$, Bernstein twice gives $\lvert\phi''(0)\rvert\le9M$, and step 3 gives $\phi''(0)\le-6\theta_0\gamma$, so $\theta_0\gamma\le\tfrac32M$ and $r=4\theta_0\gamma/(9M)\le2/3<\pi/2$. The normal space is nonzero because the orbit has dimension below that of the sphere ($P$ is odd, so the orbit is a proper subset). *Suggested wording: "for $W$ with $0<s<r$", the bound $r\le2/3$ noted once.*
- **Uniqueness of $W_1$.** Unused. Any minimiser yields a valid $(W_1,H)$ pair, and the argument runs on that pair alone, so two nearest points change nothing.

No finding.

## 2. The corollary's gap

- **The list.** L27's ten summands and scalars: $1$ on $\langle W\rangle$; $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$; $0$ on $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$; $\lambda_p$ and $\lambda_q$ on $S^2_0(\mathbb R^p)$ and $S^2_0(\mathbb R^q)$, with $\lambda_m=\frac{m-2}{2(m-1)}$; $+\mu$ on $\Lambda^2\otimes\Lambda^2$; $-\mu$ on $S^2_0\otimes S^2_0$.
- **The orbit tangent is exactly $\mathbb R^p\otimes\mathbb R^q$.** L27 gives $E(\tfrac12)=$ orbit tangent with dimension $pq$, and $\mathbb R^p\otimes\mathbb R^q$ is a $pq$-dimensional $\tfrac12$-eigenspace, so the two coincide.
- **The Rayleigh bound.** $L_e$ is self-adjoint (L24, [r285](REVIEW_r285.md) Claim 1) and the decomposition is orthogonal and $L_e$-invariant, so $\sup\langle L_eH,H\rangle$ over unit $H$ in the complement of $\langle W\rangle\oplus T\mathcal O$ is the maximum scalar over the eight remaining summands.
- **The minimum.** $\tfrac12$ minus each scalar is $\tfrac12$ (four times), $\tfrac1{2(p-1)}$, $\tfrac1{2(q-1)}$, $\tfrac12-\mu$, $\tfrac12+\mu$. Since $\tfrac1{2(m-1)}\le\tfrac14<\tfrac12$ for $m\ge3$ and $\mu>0$, the four entries $\tfrac12$ and $\tfrac12+\mu$ never attain the minimum, which leaves exactly $\min\big(\tfrac1{2(p-1)},\tfrac1{2(q-1)},\tfrac12-\mu\big)$. No summand is omitted. Every summand in the list is nonzero at $p,q\ge3$ except $\mathrm{Weyl}_3=0$, whose value $0$ never binds.
- **The $(3,4)$ exception of [nondegeneracy.md](../findings/nondegeneracy.md) is inside the formula**: $\min(\tfrac14,\tfrac16,\tfrac12-\tfrac5{12})=\tfrac1{12}$, the recorded value.
- **Balanced product.** $p=q=m$: $\mu=\frac{2m-2}{2(m-1)^2}=\frac1{m-1}$, so $\tfrac12-\mu=\frac{m-3}{2(m-1)}$, which is $\ge\frac1{2(m-1)}$ exactly when $m\ge4$ (equality at $m=4$). Hence $\gamma=\frac1{2(m-1)}=\frac1{n-2}$ at $n\ge8$, as stated.
- **Radii.** With $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ from [conventions.md](../findings/conventions.md): $\theta_0(8)=\sqrt{84}/8=1.1456439$, $r_8=4(1.1456439)/(9\cdot6\cdot3.4494897)=0.0246015$; $\theta_0(12)=\sqrt{220}/12=1.2360331$, $r_{12}=4(1.2360331)/(9\cdot10\cdot4.1622777)=0.0131983$. Both round to the stated $0.0246$ and $0.0132$.
- **Credit, minor.** The corollary attributes the closed form to L27 plus L26's $\mu$. The two $\tfrac1{2(m-1)}$ terms are L27's $\lambda_m$, which the sentence already covers by citing L27, so no change is owed.

No finding.

## 3. Step 2, the function along the circle

- $\phi(\sigma)=\sum_{a+b=3}\binom3aC(W_1^{a},H^{b})\cos^a\sigma\sin^b\sigma$ with $C$ the symmetric trilinear form of $P$. Each $\cos^a\sin^b$ with $a+b=3$ expands into $e^{\pm i\sigma}$ and $e^{\pm3i\sigma}$, so $\phi$ is a real trigonometric polynomial of degree at most $3$, which is Theorem 1.1's case $a_{-k}=\overline{a_k}$.
- $\lVert c(\sigma)\rVert^2=\cos^2\sigma+\sin^2\sigma=1$ because $H\perp W_1$ and both are unit, so every $c(\sigma)$ is a unit vector of $\mathcal W_n$ and L143's $\sup_{\lVert W\rVert=1}\lvert P\rvert\le1+\sqrt{n-2}$ applies pointwise.

No finding.

## 4. Step 3, the second derivative

- **Chain rule.** $\phi'(\sigma)=DP_{c}[c']$ and $\phi''(\sigma)=D^2P_c[c',c']+DP_c[c'']$. At $\sigma=0$: $c=W_1$, $c'=H$, $c''=-W_1$. The curvature term is present with sign minus.
- **The factors.** Write $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, totally symmetric (L24's argument, [r285](REVIEW_r285.md)). Then $P(W)=T(W,W,W)$, so $DP_W[H]=3T(W,W,H)=3\langle Q(W),H\rangle$ and $D^2P_W[H,H]=6T(W,H,H)=6\langle W\circ H,H\rangle$. With $W_1=\theta_0e_1$, $e_1=W_1/\theta_0$, this is $6\theta_0\langle L_{e_1}H,H\rangle$. The identity holds at every point, criticality unused.
- **Euler.** $DP_{W_1}[W_1]=3P(W_1)=3\theta_0$, using $\lVert W_1\rVert=1$ and $P(W_1)=P(W_0)=\theta_0$.
- **First derivative.** $\phi'(0)=3\langle Q(W_1),H\rangle=3\theta_0\langle W_1,H\rangle=0$, using criticality $Q(W_1)=\theta_0W_1$.
- **Result.** $\phi''(0)=6\theta_0\big(\langle L_{e_1}H,H\rangle-\tfrac12\big)\le-6\theta_0\gamma$, the inequality using the transported gap (item 7) and $\theta_0>0$.
- **Notation.** The block writes $L_e$ at $W_1$ where $L_{e_1}=L_{ge}$ is meant. Step 1's equivariance sentence supplies the identification, so this is notation only.

No finding.

## 5. Step 4, Bernstein

- If $T$ is a real trigonometric polynomial of degree at most $N$, so is $T'$ (differentiation multiplies $a_k$ by $ik$ and keeps the support). Applying Theorem 1.1 to $\phi$, $\phi'$, $\phi''$ in turn gives $\lVert\phi'\rVert_\infty\le3M$, $\lVert\phi''\rVert_\infty\le9M$, $\lVert\phi'''\rVert_\infty\le27M$.
- The constant is valid and loose. Frequencies $1$ and $3$ only would allow a sharper bound, and the block's own screen reports roughly a factor ten of slack, which affects the size of $r$ and never its correctness.

No finding.

## 6. Step 5, the Taylor bound and the contradiction

- **Taylor.** $\phi'(\sigma)=\phi'(0)+\sigma\phi''(0)+\int_0^\sigma(\sigma-u)\phi'''(u)\,du$. The weight $\sigma-u\ge0$ on $[0,\sigma]$, so an upper bound $\phi'''\le27M$ alone gives $\phi'(\sigma)\le-6\theta_0\gamma\sigma+\tfrac{27M}2\sigma^2$. A one-sided bound suffices.
- **Sign.** The right side is negative for $0<\sigma<\frac{2\cdot6\theta_0\gamma}{27M}=\frac{4\theta_0\gamma}{9M}=r$.
- **Pairing.** $\phi'(s)=\langle\nabla P(c(s)),c'(s)\rangle$ and $c'(s)=-\sin s\,W_1+\cos s\,H$ is a unit vector orthogonal to $c(s)$, so the normal component of $\nabla P$ pairs to zero and $\phi'(s)=\langle\mathop{\mathrm{grad}}_{S}P(W),c'(s)\rangle$.
- **Direction of the contradiction.** A sphere-critical $W$ has $\mathop{\mathrm{grad}}_SP(W)=0$ (equivalently $Q(W)\parallel W$, at any value of $P(W)$), which forces $\phi'(s)=0$. The proof shows $\phi'(s)<0$, so $W$ is non-critical. A gradient vanishing in the circle's direction while nonzero elsewhere is the converse, which the proof never uses.
- **Wording.** "If $W=\phi$'s point at $\sigma=s$" means $W=c(s)$, and "contradicts step 5" sits inside step 5 and refers to the displayed Taylor bound. Both are presentation.

No finding.

## 7. The equivariance clause

- $W^2$ is conjugation-equivariant, and $W^\#$ is built from the structure constants of $\mathfrak{so}(n)$, which every $g\in O(n)$ preserves because $g[a,b]g^{-1}=[gag^{-1},gbg^{-1}]$. So $Q(gX)=gQ(X)$, $(gX)\circ(gY)=g(X\circ Y)$ and $L_{ge}=gL_eg^{-1}$.
- $\langle gX,gY\rangle=\langle X,Y\rangle$, so $P(gX)=P(X)$ and $W_1=gW_0$ is a unit critical point with value $\theta_0$.
- $\xi\cdot(gW_0)=g\big((\mathrm{Ad}_{g^{-1}}\xi)\cdot W_0\big)$, so $T_{gW_0}\mathcal O=g\,T_{W_0}\mathcal O$. Hence $H\perp W_1$, $H\perp T_{W_1}\mathcal O$ iff $g^{-1}H\perp W_0$, $g^{-1}H\perp T_{W_0}\mathcal O$, and $\langle L_{ge}H,H\rangle=\langle L_eg^{-1}H,g^{-1}H\rangle\le\tfrac12-\gamma$. The orbit-tangent condition transports with the rest.
- The $O(n)$-orbit may have two $SO(n)$-components. Both are covered by the same computation.

No finding.

## 8. Is the radius statement about the right set

- **What it says.** For every critical $W$ on the sphere, $\mathop{\mathrm{dist}}(W,\mathcal O)<r$ implies $W\in\mathcal O$. That is $\mathrm{Crit}(P)\cap U_r(\mathcal O)=\mathcal O$, so $\mathcal O$ is open and closed in $\mathrm{Crit}(P)$ with an explicit collar.
- **Fit to the route.** I35 ([problem.md](../findings/problem.md)) asks for $r_i$ with "$\varepsilon_n\le\min_ir_i$". The lemma's tube is open, so the consumer needs $\varepsilon_n<r$ strictly, or a closed-tube reading at $\varepsilon_n\le r'$ for any $r'<r$. Gauge-rotated copies of $W_0$ lie on $\mathcal O$ and are correctly allowed.
- **Metric.** $r$ is geodesic. A localisation stated in Frobenius distance $\lVert W-W_1\rVert=2\sin(s/2)\le s$ converts through $\varepsilon<2\sin(r/2)$, a loss below $10^{-4}$ relative at these radii. *A consumer should state which distance its $\varepsilon_n$ uses.*
- **Per orbit.** The lemma isolates one orbit at a time. The route needs one $r_i$ per rigid orbit, and the block's own WHAT IT DOES NOT GIVE records padded $\mathbb{CP}^2$ as owed.

No finding.

## 9. Scope and hypotheses

| Hypothesis | Where used |
|---|---|
| $\lVert W_0\rVert=1$, $\theta_0=P(W_0)$ | Euler in step 3, the circle lying in the unit sphere in step 2 |
| criticality $Q(W_0)=\theta_0W_0$ | $\phi'(0)=0$ in step 3, only there |
| $\theta_0>0$ | defining $e$; preserving the inequality when multiplying $\langle L_eH,H\rangle-\tfrac12\le-\gamma$ by $6\theta_0$ in step 3; $r>0$ |
| $\gamma>0$ | $r>0$ (at $\gamma\le0$ the statement is vacuous) |
| gap on $W_0^\perp\cap T\mathcal O^\perp$ | step 3, after transport in step 1 |
| total symmetry of $\langle X\circ Y,Z\rangle$ | $D^2P=6T(W,\cdot,\cdot)$ and $\nabla P=3Q$ in step 3, carried in the "What is used" line as "L24's Hessian formula" |
| L143 | only as $M$, in steps 2 and 4 and the radius |
| isometric $O(n)$-action, compact orbit | step 1 and item 7 |

- **Maximality.** Unused. L24's eigenvalue bound at a maximiser plays no role, only its Hessian formula, which step 3 re-derives from definitions at any point. The lemma applies to saddles with a positive gap, although at the sphere products with $\min(p,q)=2$ the gap is negative ([L207](../findings/nondegeneracy.md)) and the lemma says nothing there.
- **L143 elsewhere.** Not used anywhere else.

No finding.

## 10. The exponent

- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n\to\sqrt2$, so $r_n=\frac{4\theta_0(n)}{9(n-2)(1+\sqrt{n-2})}\sim\frac{4\sqrt2}{9}n^{-3/2}$. As a statement about the displayed expression, $r_n=\Theta(n^{-3/2})$ is correct.
- **Hazard, recorded as a wording recommendation.** The true isolation radius of the balanced orbit is at least $r_n$, so for that radius the lemma gives $\Omega(n^{-3/2})$ and no upper bound. The L145 box carried a $\Theta$ that was refuted for exactly this reading and the indexes propagated it. *Recommended: "the floor $r_n$ is $\Theta(n^{-3/2})$", or "the isolation radius is $\Omega(n^{-3/2})$".* The block's own sentence "so the radius is a floor" already says this, two paragraphs later.
- **The L145 match.** L145 is a lower bound $\Omega(n^{-3/2})$ on the penalised functional's tube radius about $SO(n)\cdot W^*$ at $n\ge12$, a different functional and a different set. The exponents coincide for a shared reason: L147's $P$-side branch pins $n^{-3/2}$ as margin $c_p=3\theta_0/(n-2)=\Theta(1/n)$ over $\sup\lvert P\rvert=O(\sqrt n)$ from L143, and L216's radius $4\theta_0\gamma/(9M)$ is the same margin over the same $M$, with the same two orders. So "matches" is fair as an exponent statement and misleading as a comparison of radii. The block says "matches L145's" without saying which quantity, and one clause naming the shared mechanism would settle it.

No finding against the lemma. One wording recommendation.

## 11. Prior record and literature

- **Search.** Grepped [findings/](../findings/), [verification/](../verification/), [plan.md](../plan.md) and [reviews/](.) for "isolation radius", "tube radius" and "quantitative Morse", excluding [INDEX.md](INDEX.md) and the concurrent reviewer's report.
- **What exists.** The I96 isolation block immediately above L216 (radius refuted and vacuous, [r929](REVIEW_r929.md), [r930](REVIEW_r930.md)), [trap 60](../findings/INDEX-traps.md) (withdrawn), and the L145 to L149 tube-radius chain for the penalised functional, which is order-level with no explicit constant and restricted to the balanced orbit at $n\ge12$. L19's block in [problem.md](../findings/problem.md) records no isolation radius. **So L216 is the first explicit isolation radius for $\mathrm{Crit}(P)$ on the record.**
- **Credit owed.** L216's "Not used: L145's penalised functional" is accurate for the proof. The mechanism, a margin read along normal geodesics from the orbit against a third-order term controlled by $\sup\lvert P\rvert$, with the geodesics filling the tube by invariance, is L145/L147's $P$-side branch, and L146 already identifies its margin as $3\theta_0(\tfrac12-\lambda_m)$, which is exactly $\tfrac12\lvert\sup_H\phi''(0)\rvert$ at the balanced product. What L216 adds is the function $P$ itself (no defect), Bernstein in place of a Cauchy estimate, an explicit constant, and a hypothesis-level gap at any orbit. *Recommended: one sentence crediting L147's $P$-side branch as the precedent for the shape.*
- **Literature.** The step "nondegenerate Hessian plus a bounded third derivative isolates the critical set" is classical in kind (quantitative inverse-function and Morse--Bott arguments), and Markov--Bernstein bounds for polynomials restricted to great circles are standard. I found no source stating this radius for $P$ or for metrised algebras. [Krasnov--Tkachev](../references/krasnov-tkachev-2018-idempotent-variety/notes.md), credited at L24, is the natural place such a statement would appear, and the record's notes on it show none.

## 12. What would break it

- **Named falsifiers.** (a) A unit $H\perp W_{p,q}$, $H\perp T\mathcal O$ with $\langle L_eH,H\rangle>\tfrac12-\gamma_{p,q}$, which would mean a wrong L27 scalar or a missing summand. (b) A failure of total symmetry of $\langle X\circ Y,Z\rangle$, which would break $D^2P=6T(W,\cdot,\cdot)$ and $\nabla P=3Q$. (c) A unit $W$ with $\lvert P(W)\rvert>1+\sqrt{n-2}$. (d) A critical point at geodesic distance in $(0,r)$ from a sphere-product orbit.
- **What I did.** (a) and (b) screened in section 13, both clean. (c) is L143, Gate 2 passed, and F10's LP beats it, so it is not the soft spot. (d) is the open-ended hunt the analysis-only rule excludes, and the derivation above leaves no step for it to exploit.

## 13. Screen (seconds of compute, a screen and no evidence for a positive claim)

Script in the session scratchpad, on the record's [g1_le_machinery.py](../scripts/lib/g1_le_machinery.py).

- **Total symmetry at $n=6$**, random $X,Y,Z$: $\langle X\circ Y,Z\rangle$, $\langle Y\circ Z,X\rangle$, $\langle Z\circ X,Y\rangle$ all $-0.0367979457274319$.
- **Step 3 at a random non-critical unit $W$ and unit $H\perp W$, $n=6$**: finite-difference $\phi''(0)=0.2119111$ against $6\langle W\circ H,H\rangle-3P(W)=0.2119113$, and $\phi'(0)=-0.3606425$ against $3\langle Q(W),H\rangle=-0.3606429$, agreement to the $h^2$ error. This checks the formula off criticality, which Gate 1 did not.
- **Full $L_e$ spectrum at four splits outside Gate 1**:

| $(p,q)$ | residual | $\dim E(\tfrac12)$ | $pq$ | measured gap | formula | $\mathop{\mathrm{tr}}L_e$ |
|---|---|---|---|---|---|---|
| $(3,4)$ | $2.1\times10^{-15}$ | $12$ | $12$ | $0.083333333333$ | $0.083333333333$ | $0$ |
| $(4,5)$ | $2.9\times10^{-15}$ | $20$ | $20$ | $0.125000000000$ | $0.125000000000$ | $-7\times10^{-15}$ |
| $(5,5)$ | $3.4\times10^{-15}$ | $25$ | $25$ | $0.125000000000$ | $0.125000000000$ | $7\times10^{-15}$ |
| $(3,6)$ | $2.9\times10^{-15}$ | $18$ | $18$ | $0.100000000000$ | $0.100000000000$ | $-7\times10^{-15}$ |

- $(3,4)$ is the split where $\mu$ overtakes $\lambda_{\max(p,q)}$, so the third entry of the min is the binding one there, and $(5,5)$ gives $\theta=1.2=\theta_0(10)$.

## 14. The Lean declarations

- **Build.** `lake env lean` on [L216IsolationRadius.lean](../lean/HamiltonsCubic/Results/L216IsolationRadius.lean) exits $0$, and all three declarations print axioms {propext, Classical.choice, Quot.sound}, with sorryAx absent.
- **What type-checks is step 5 alone, which is weaker than steps 4 and 5.** taylor_bound is the one-sided Taylor inequality for arbitrary $f,f_1,f_2$ on $[0,\infty)$, proved by two applications of antitoneOn_of_deriv_nonpos. sign_step is the quadratic sign. no_critical_in_tube composes them with the identity $4\theta\gamma/(9M)=2(6\theta\gamma)/(27M)$.
- **Step 4 enters as the hypothesis hbern** ($f_2\le27M$ on $[0,\infty)$). Bernstein's inequality is absent from Mathlib, as the file's docstring says.
- **Steps 1 to 3 enter only as hypotheses or not at all.**
  - $f,f_1,f_2$ are arbitrary real functions, so the identification $f=\phi'$, $f_1=\phi''$, $f_2=\phi'''$ and the definition of $\phi$ from $P$ are untyped (step 2).
  - h0 ($f(0)=0$) carries criticality and the first half of step 3.
  - h1 ($f_1(0)\le-6\theta\gamma$) carries L24's Hessian formula, the curvature term, the gap hypothesis and its transport by equivariance (second half of step 3, the equivariance of step 1).
  - hbern carries step 2's trigonometric-polynomial structure, L143 and step 4.
  - hM ($M>0$) carries $M=1+\sqrt{n-2}$.
  - The nearest point and the first variation (step 1) and the final inference "$f(s)<0\Rightarrow c(s)$ is non-critical" (the end of step 5) appear only in docstrings.
- **The docstring is accurate about this**, listing the untyped parts, except that it omits step 1's geometry and the last inference from its "Not typed" paragraph.

## 15. Verdicts

- **Lemma L216: CONFIRMED.** Every step follows from the one above and the stated hypotheses. Three presentation fixes are recommended and none is owed for correctness: restrict step 1 to $0<s<r$ with $r\le2/3$; write $L_{e_1}$ at $W_1$; replace "contradicts step 5" by "contradicts the bound above".
- **Corollary at the sphere products: CONFIRMED.** The gap is $\tfrac12$ minus the maximum over every summand off $\langle W\rangle\oplus T\mathcal O$, $\gamma=1/(n-2)$ at $n=2m\ge8$, and the radii are $0.0246015$ and $0.0131983$. Two wording fixes are recommended: state the $\Theta$ as a property of the floor $r_n$ (the true radius being $\Omega$), and credit L147's $P$-side branch for the margin-over-$\sup\lvert P\rvert$ shape that the L145 exponent match reflects.
