# REVIEW_r490, Lemma L24, second-order optimality as an eigenvalue bound

**Target.** [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement), in [findings/second-order.md](../findings/second-order.md). 55 citations, cites nothing, never audited.

**Reviewer.** r490, cold brief, analysis-only footing (no searches/sweeps; screening only).

**Phase plan.**

1. Hessian: derive $\nabla P$, the ambient second differential, the multiplier term, and the Riemannian (geodesic) correction from scratch.
2. Self-adjointness of $L_e$ via full symmetry of $T(X,Y,Z)=\langle X\circ Y,Z\rangle$.
3. Invariance of $W^\perp$ under $L_e$; compression vs restriction.
4. Sharpness: $e\circ e=e$; orbit directions as $\tfrac12$-eigenvectors; every critical point?
5. Scope: where $\theta>0$ actually enters.
6. Prior art: Krasnov–Tkachev Prop 6.6, the dropped "$1$ simple", extremal vs maximiser, the normalisation dictionary.
7. Cross-check the record.

**VERDICT: PLAUSIBLE**, the inequality is true and re-derived cold; the block omits self-adjointness and $W^\perp$-invariance, its sharpness clause $\langle e,L_ee\rangle=1$ is false ($=1/\theta^2$) and inert, and its whole Scope paragraph is REFUTED. Details below.

---

## Findings

*(appended as derived)*

### F1, the Hessian is right, factor for factor, and the geodesic term is the multiplier term (CONFIRMED)

Derived cold. Write $T(X,Y,Z)=\langle X\circ Y,Z\rangle$. Since $Q$ is homogeneous of degree $2$, $W\circ W=\tfrac12(Q(2W)-2Q(W))=Q(W)$, so $P(W)=\langle W,Q(W)\rangle=T(W,W,W)$.

Granting full symmetry of $T$ (see [F2](#f2-l_e-is-self-adjoint-and-the-block-never-says-so-gap-fillable-in-one-line)):

- $DP(W)[X]=3T(W,W,X)=3\langle Q(W),X\rangle$, so $\nabla P=3Q(W)$. **Correct.**
- $D^2P(W)[X,X]=6T(W,X,X)=6\langle W\circ X,X\rangle$, so the ambient Hessian operator is $6L_W=6\theta L_e$ (bilinearity of $\circ$, $e=W/\theta$). **Correct.**
- Multiplier: maximise $P$ subject to $g(W)=\lVert W\rVert^2=1$, $\nabla g=2W$. Stationarity $3Q(W)=2\mu W$ with $Q(W)=\theta W$ gives $\mu=\tfrac32\theta$. The constrained Hessian is $6\theta L_e-2\mu\,\mathrm{Id}=6\theta L_e-3\theta\,\mathrm{Id}=6\theta(L_e-\tfrac12\mathrm{Id})$. **The block's "$-3\theta\,\mathrm{Id}$" is exactly $-2\mu\,\mathrm{Id}$ and is right.**

**The normal-direction term the brief asks after is handled, and it is not silently zero, it is the multiplier term.** Along the great circle $\gamma(t)=W\cos t+X\sin t$ with $\lVert X\rVert=1$, $X\perp W$, one has $\ddot\gamma(0)=-W$, so

$$\tfrac{d^2}{dt^2}P(\gamma)\big|_0=D^2P(W)[X,X]+\langle\nabla P(W),\ddot\gamma(0)\rangle=6\theta\langle X,L_eX\rangle+\langle 3Q(W),-W\rangle=6\theta\big(\langle X,L_eX\rangle-\tfrac12\big),$$

using $\langle Q(W),W\rangle=P(W)=\theta$ at $\lVert W\rVert=1$. The second fundamental form contributes $-3\theta$, identically the Lagrange term. The block's parenthetical "verified through the geodesic second derivative" is therefore not an independent check but the same computation; it is nonetheless correct.

### F2, $L_e$ is self-adjoint, and the block never says so (GAP, fillable in one line)

The statement's "$\lambda_{\max}$", the operator identity $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$, and the restriction to $W^\perp$ all need $T$ fully symmetric; the block asserts none of it. It is true. On $\Lambda^2\cong\mathfrak{so}(n)$ with $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$ totally antisymmetric ([conventions.md](../findings/conventions.md)):

- $\langle W,W^2\rangle=\operatorname{tr}(W^3)$ polarises to the symmetric $\operatorname{tr}(W_1W_2W_3)$-symmetrisation; gradient $3W^2$.
- With $\langle R^\#u,v\rangle=\tfrac12\sum_{\alpha\beta}\langle[b_\alpha,b_\beta],u\rangle\langle[Rb_\alpha,Rb_\beta],v\rangle$, expanding gives $\langle R^\#,X\rangle=\tfrac12F(R,R,X)$ with $F(R_1,R_2,R_3)=\sum c_{\alpha\beta\gamma}c_{\alpha'\beta'\gamma'}(R_1)_{\alpha\alpha'}(R_2)_{\beta\beta'}(R_3)_{\gamma\gamma'}$. Swapping any two arguments and relabelling the paired index pairs flips **both** $c$ factors, so the signs cancel and $F$ is fully symmetric; gradient $3R^\#$.

Hence $\nabla P=3Q(W)$ and $T$ is fully symmetric, so $\langle X\circ Y,Z\rangle=\langle Y,X\circ Z\rangle$ and $L_e^{\mathsf T}=L_e$. **The record already owns this**, [r285](REVIEW_r285.md) Claim 1 proves exactly $\langle X\#Y,Z\rangle=\tfrac12c_{pqa}c_{rsb}X_{pr}Y_{qs}Z_{ab}$ and names the slot-1-to-slot-3 transposition as the load-bearing half. **The defect is that L24 does not cite it**: the canonical block's proof reads as if self-adjointness were free.

### F3, $W^\perp$ is genuinely $L_e$-invariant, so "$L_e|_{W^\perp}$" is an operator (CONFIRMED; restriction $=$ compression)

$L_eW=\tfrac1\theta W\circ W=\tfrac1\theta Q(W)=W$ by criticality, so $W$ is a $1$-eigenvector; with $L_e$ self-adjoint, $W^\perp$ is invariant and $L_e|_{W^\perp}=\Pi_{W^\perp}L_e\Pi_{W^\perp}$ on that space. **No compression is needed and the 55 citations are safe on this point.** The block does not say it; [Lemma L125](../findings/second-order.md#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) does, one heading below, so the record holds the missing step adjacent to the block that needs it.

### F4, the sharpness sentence: one clause is numerically FALSE and inert, the other is true and is the whole of it

**Clause 1, "$\langle e,L_ee\rangle=1$", is false.** $L_ee=e\circ e=e$, so $\langle e,L_ee\rangle=\lVert e\rVert^2=\lVert W\rVert^2/\theta^2=1/\theta^2$. At the balanced sphere product at $n=12$, $\theta=1.2360\ldots$, this is $0.6545$, not $1$. What is true is $L_ee=e$, i.e. $1\in\sigma(L_e)$ with eigenvector $e$, the Rayleigh quotient, not the inner product.

**And repaired it still certifies nothing.** The eigenvector is $e\parallel W$, which lies *outside* $W^\perp$; the bound being audited is on $W^\perp$. This is the same emptiness the record already boxes one heading below, in [Lemma L125](../findings/second-order.md#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs): "**THE EQUALITY AT $Y=W$ CERTIFIES NOTHING.**" The clause should be struck from the sharpness argument.

**Clause 2, the orbit directions, is true and carries the sharpness by itself.** Derived cold: $O(n)$ acts on $\mathcal W_n$ with $P$ invariant and $Q$ equivariant. Differentiating $Q(g_t\cdot W)=g_t\cdot Q(W)$ at $t=0$ along $A\in\mathfrak{so}(n)$, with $V:=A\ast W=[\rho(A),W]$ and $DQ(W)[V]=2W\circ V$:

$$2\,W\circ V=A\ast Q(W)=\theta\,(A\ast W)=\theta V\quad\Longrightarrow\quad L_eV=\tfrac12V .$$

Exact, and $V\perp W$ because $\lVert g\cdot W\rVert$ is constant. **The record already owns this** ([bounds.md](../findings/bounds.md), [diagonal-half.md:151](../findings/diagonal-half.md), [LEDGER.md:59](../findings/LEDGER.md)); L24's block states it without derivation or citation.

**"at every critical point" is right, and the L32 worry does not bite.** $V=0$ for all $A$ would make $W$ an $O(n)$-invariant element of $\mathcal W_n$. For $n\ne4$, $\Lambda^2$ is $\mathfrak{so}(n)$-irreducible, so Schur forces $W=c\,\mathrm{Id}$, which is not trace-free; at $n=4$, $\Lambda^2=\Lambda^+\oplus\Lambda^-$ gives $W=c_+\Pi_++c_-\Pi_-$, and $\operatorname{tr}W=0$ with $\langle W,\star\rangle=0$ (Bianchi) forces $c_\pm=0$. So the orbit is positive-dimensional at **every** nonzero critical point and $\tfrac12$ is attained on $W^\perp$. A nontrivial stabiliser, [Lemma L32](../findings/isotropy-cap.md)'s territory, lowers $\dim\mathcal O$ and hence $\operatorname{mult}(\tfrac12)$, never to zero.

### F5, the SCOPE paragraph is REFUTED: the witness cannot separate the sign of $\theta$, and it is mislabelled

**The quantity the scope claim is about is invariant under $W\mapsto-W$.** $Q$ is even, so $Q(-W)=Q(W)$ and $P$ is odd: $\theta(-W)=-\theta(W)$, and $-W$ is critical whenever $W$ is. Then

$$e(-W)=\frac{-W}{-\theta}=\frac W\theta=e(W),\qquad (-W)^\perp=W^\perp .$$

**So $L_e|_{W^\perp}$ is literally the same operator at $W$ and at $-W$, and $\lambda_{\max}(L_e|_{W^\perp})$ takes the same value at $\theta=-0.866$ and at $\theta=+0.866$.** A critical point of one sign therefore cannot witness anything about the sign of $\theta$: whatever the inequality does at the recorded point, it does identically at its negation, where $\theta>0$.

**The witness is also mislabelled.** At $n=4$ the critical points are exactly $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$ up to $O(4)$ ([bounds.md:448](../findings/bounds.md)). $\mathfrak u(2)$ is the isotropy of $W_{\mathbb{CP}^2}$ ([nondegeneracy.md:145](../findings/nondegeneracy.md), [fence-posts.md:343](../findings/fence-posts.md)), whose $\theta$ is $\pm\sqrt{3/2}=\pm1.224745$. The value $-0.866025=-\sqrt3/2$ is $-(S^2\times S^2)$, as the record's own tables say ([r329:163](REVIEW_r329.md), [r330:106](REVIEW_r330.md)). **The scope sentence attaches one point's isotropy to another point's $\theta$.**

**And the recorded point is a saddle, so it fails L24's hypothesis before the sign of $\theta$ is reached.** Derived by hand at $n=4$, where $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ and $\circ$ is an orthogonal sum of two algebras ($[\Lambda^+,\Lambda^-]=0$ kills the cross terms in $\#$, and $W^2$ is blockwise). At the balanced point $W=W_1+W_2$ with $W_i=\theta e_i$ and $e_i\circ e_i=e_i$,

$$L_e(\alpha W_1+\beta W_2)=\alpha\,e_1\circ W_1+\beta\,e_2\circ W_2=\alpha W_1+\beta W_2 ,$$

so the whole $2$-plane $\operatorname{span}(W_1,W_2)$ lies in $E_{L_e}(1)$ and $E_{L_e}(1)\cap W^\perp\ne0$: **$\lambda_{\max}(L_e|_{W^\perp})=1$** at $\pm S^2\times S^2$, $n=4$. Independently, on the great circle $\gamma(t)=\cos t\,U+\sin t\,V$ through the balanced point ($U,V$ the unit blocks), $P(\gamma)=\theta\sqrt2(\cos^3t+\sin^3t)$ has $P''(\pi/4)=+3\theta>0$, a local **minimum** along a tangent direction, so the point is a saddle and L24's "maximizer" hypothesis already fails.

**What is actually true, and should replace the paragraph.** $\theta>0$ enters at exactly one step: dividing "$\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})\preceq0$ on $W^\perp$" by $6\theta$. At $\theta<0$ the division flips, and a *local maximiser* with $\theta<0$ satisfies

$$\lambda_{\min}\big(L_e|_{W^\perp}\big)\ \ge\ \tfrac12 ,$$

a lower bound on the **minimum**, not the failure of an upper bound on the maximum. Equivalently (and this is the cleanest form), $W\mapsto-W$ carries a $\theta<0$ local maximiser to a $\theta>0$ local **minimiser** with the same $e$, so there is no separate $\theta<0$ regime: it is the $\theta>0$ theory read at a minimiser. **The recorded witness demonstrates none of this**, and the scope claim as written stands unwitnessed.

### F6, the prior-art attribution is right; the dropped "$1$ simple" is a corollary, and its corollary form is used

Checked against [the record's own KT notes](../references/krasnov-tkachev-2018-idempotent-variety/notes.md); the PDF was not opened.

| question | answer |
| --- | --- |
| Is it Prop 6.6? | **Yes**, verbatim: "for any extremal idempotent $c$ there holds $\sigma(c)\subset(-\infty,\tfrac12]$. In particular, $1$ is a simple eigenvalue of $L_c$." |
| Is "extremal idempotent" the same hypothesis as "maximizer"? | **Yes.** The notes define it as the idempotent attached to a **local maximum** of $\langle x,x^2\rangle$ on the unit sphere. L24's global maximiser is a local maximum, so KT's hypothesis is the weaker one and covers L24's. |
| Is the normalisation dictionary stated, and right? | **Stated and right.** For an idempotent $c$, $x=c/\lVert c\rVert$ has $P(x)=\lVert c\rVert^{-3}\langle c\circ c,c\rangle=1/\lVert c\rVert$, so $\theta=1/\lVert c\rVert$ and maximising $\theta$ is minimising $\lVert c\rVert$. Consistent with $e=W/\theta$, $\lVert e\rVert=1/\theta$. **No factor is lost, and $f(x)=\langle x^2,x\rangle/\lvert x\rvert^3$ is literally [conventions.md](../findings/conventions.md)'s $\theta$.** |
| Is the dropped "$1$ simple" (a) false, (b) true and unused, or (c) needed downstream? | **(b) with a caveat.** It is an immediate corollary of the bound: $L_ee=e$ gives $1\in\sigma(L_e)$, and $\lambda_{\max}(L_e\rvert_{W^\perp})\le\tfrac12<1$ leaves the $1$-eigenspace exactly $\mathbb Re$. [r298](REVIEW_r298.md) reached the same conclusion. So dropping it loses no content, **but it is not vacuous**: it says a maximiser is $\circ$-**indecomposable**, which [trap 48](../findings/INDEX-traps.md) explicitly wants ("add $\circ$-indecomposability, which is free at a maximiser") and which [r306](REVIEW_r306.md) K1 uses. The block would be better for stating the corollary. |

### F7, two smaller points

- **$W^\perp$ means $W^\perp\cap\mathcal W_n$, and the block does not say so.** The tangent space to the unit sphere *of $\mathrm{Weyl}_n$* is the orthogonal complement taken inside $\mathcal W_n$. Read in the ambient $\mathrm{Sym}^2(\Lambda^2)$ the statement is a different (and unproved) one, since $L_e$ is only known to preserve $\mathcal W_n$. [r346](REVIEW_r346.md) already listed this among L24's hypotheses; the canonical block still omits it.
- **$\theta>0$ is automatic for a global maximiser, so the 55 citations never have to check it.** $P$ is odd ($Q$ even), and $P(W_{\mathbb{CP}^2})=\sqrt{3/2}>0$ at $n=4$ with padding preserving $\theta$, so $\max_SP\ge\sqrt{3/2}>0$ at every $n\ge4$. The hypothesis bites only for *local* maximisers.

---

## Impact on the 55 citations

**None of the defects reaches the inequality.** The statement $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ at a maximiser with $\theta>0$ is true, the Hessian normalisation $6\theta(L_e-\tfrac12\mathrm{Id})$ is exact, $W^\perp$ is a genuine invariant subspace so the restriction is not a disguised compression, and $\tfrac12$ is attained. Downstream users that consume the Hessian normalisation ([Lemma L120](../findings/second-order.md), [Lemma L121](../findings/second-order.md), [Lemma L122](../findings/second-order.md), [Lemma L125](../findings/second-order.md), [second-order.md:743](../findings/second-order.md), [:857](../findings/second-order.md), [stratum-two-negative.md:289](../findings/stratum-two-negative.md)) are unaffected.

The one clause that is false (the scope paragraph's witness), is quoted twice in the same file ([:19](../findings/second-order.md) and [:50](../findings/second-order.md)) and once in [r346:78](REVIEW_r346.md) as "the standing witness". Nothing derives a result from it; it is a scope illustration. **The hypothesis it illustrates ($\theta>0$) remains load-bearing and is correctly inherited at [second-order.md:753](../findings/second-order.md).**

## Repairs, in the order they should be made

1. **Strike "$\langle e,L_ee\rangle=1$"** from the sharpness sentence. It is false ($=1/\theta^2$), and repaired to "$L_ee=e$" it is about the radial direction, which [Lemma L125](../findings/second-order.md)'s own box says certifies nothing.
2. **Replace the scope paragraph.** The witness cannot separate the sign of $\theta$ ($e$ and $W^\perp$ are both invariant under $W\mapsto-W$), its label attaches $W_{\mathbb{CP}^2}$'s isotropy $\mathfrak u(2)$ to $-(S^2\times S^2)$'s $\theta=-\sqrt3/2$, and the point is a saddle with $\lambda_{\max}(L_e|_{W^\perp})=1$ at both signs. The correct scope: $\theta>0$ is used to divide by $6\theta$; at a local maximiser with $\theta<0$ one gets $\lambda_{\min}(L_e|_{W^\perp})\ge\tfrac12$, equivalently the $\theta>0$ statement at the local minimiser $-W$, which carries the same $e$.
3. **Add the two unstated ingredients**: full symmetry of $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ (hence $L_e=L_e^{\mathsf T}$), citing [r285](REVIEW_r285.md) Claim 1; and $L_eW=W$, hence $W^\perp$ invariant, citing [Lemma L125](../findings/second-order.md).
4. **Say $W^\perp$ is taken inside $\mathcal W_n$**, and cite the orbit-direction derivation for the sharpness clause rather than asserting it.
5. Optionally restore "$1$ simple" as the corollary $\Rightarrow$ a maximiser is $\circ$-indecomposable, which [trap 48](../findings/INDEX-traps.md) asks for.

**VERDICT: PLAUSIBLE**

*The inequality is true and I re-derived it end to end, including the geodesic term the brief asked after. The verdict is not CONFIRMED because the argument as written omits the two facts it silently uses (self-adjointness of $L_e$ and $L_e$-invariance of $W^\perp$), and because two of its four sentences are wrong: the sharpness clause "$\langle e,L_ee\rangle=1$" is false and inert, and the whole scope paragraph is refuted, its witness is $\pm$-invariant and so cannot witness a sign hypothesis, is mislabelled, and is a saddle. The statement stands; the block does not prove it as written.*
