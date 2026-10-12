# REVIEW r488, Lemma L24, second-order optimality as an eigenvalue bound

**Target.** [Lemma L24](../findings/second-order.md), the canonical block in [findings/second-order.md](../findings/second-order.md). 55 citations, cites nothing, never audited. Worked cold: every step below was derived from the definitions in [conventions.md](../findings/conventions.md) before the block's own argument was reread.

## Verdict

**PLAUSIBLE**

*Read the word precisely.* **The inequality itself is correct and is re-derived here from scratch**, the Hessian formula, every factor of 2 and 3, the multiplier's sign and magnitude, the geodesic correction, self-adjointness, and the invariance of $W^\perp$ all come out exactly as the lemma states. The 55 citations of $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ are safe. **PLAUSIBLE records that the block *as written* has two unstated load-bearing steps, one false clause inside the Argument, and a Scope paragraph that is false at its own named witness**, not doubt about the bound.

| part of the block | verdict |
| --- | --- |
| **Statement** ($\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$, hence $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$) | **correct**, re-derived independently below |
| **Argument**, Hessian half | **correct**, but two load-bearing steps are used silently |
| **Argument**, sharpness half | $\tfrac12$ is attained, **correct**; the clause $\langle e,L_ee\rangle=1$ is **false** and is a non sequitur besides |
| **Scope** ("$\theta>0$ load-bearing; at $\mathfrak u(2)$, $\theta=-0.866$, the inequality reverses") | **false at its own witness**, and the general inference it draws is impossible |
| **Prior art** (KT Prop 6.6, the normalisation dictionary) | **correct**; the dropped "$1$ simple" is a free corollary, and it is a *usable* one the record derives point-by-point instead |

---

## 1. The Hessian, derived cold

Write $T(X,Y,Z):=\langle X\circ Y,Z\rangle$ with $X\circ Y=\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)$, so $X\circ X=Q(X)$ and $P(X)=T(X,X,X)$ **once $T$ is known to be fully symmetric** (§2).

- **Gradient.** $dP_W(Y)=3T(W,W,Y)=3\langle Q(W),Y\rangle$, so $\nabla P=3Q(W)$. ✓ *This already uses full symmetry*, without $\langle X\circ Y,Z\rangle=\langle X,Y\circ Z\rangle$ the gradient of $\langle W,Q(W)\rangle$ is $Q(W)+ (DQ_W)^{*}W$, not $3Q(W)$.
- **Ambient second differential.** $D^2P_W(Y,Y)=6T(W,Y,Y)=6\langle L_WY,Y\rangle$, i.e. the ambient Hessian operator is $6L_W=6\theta L_e$. ✓
- **The multiplier.** At a unit critical point, $\nabla P=3\theta W$ and $\nabla(\lVert W\rVert^2)=2W$, so the multiplier is $\mu=\tfrac32\theta$ and the constrained Hessian is $6L_W-2\mu\,\mathrm{Id}=6\theta L_e-3\theta\,\mathrm{Id}=6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. **The block's $-3\theta\,\mathrm{Id}$ is right, in both sign and magnitude.** ✓
- **The geodesic term the brief asks about is not silently zero, it is exactly the multiplier term.** Along $\gamma(t)=W\cos t+Y\sin t$ with $Y\in W^\perp$ of unit norm, $\ddot\gamma(0)=-W$, so
$$\tfrac{d^2}{dt^2}P(\gamma)\big\vert_0=D^2P_W(Y,Y)+dP_W(\ddot\gamma(0))=6\langle L_WY,Y\rangle-3\langle Q(W),W\rangle=6\theta\langle L_eY,Y\rangle-3\theta .$$
  The normal-direction correction $dP_W(-W)=-3P(W)=-3\theta$ **is** the $-3\theta\,\mathrm{Id}$; the Lagrange route and the geodesic route agree because they are the same term computed twice. So "verified through the geodesic second derivative" is not an independent check of the multiplier, it is the multiplier.

**Screened** (seconds, on objects built for the purpose, at $n=5,6$ on random Weyl tensors): the finite-difference geodesic second derivative matches $6\langle W\circ Y,Y\rangle-3P(W)$ to $6\times10^{-9}$ at step $10^{-4}$, i.e. to the step's own truncation order.

> **A hypothesis the Statement leaves implicit.** The display is coherent only at $\lVert W\rVert=1$: [conventions.md](../findings/conventions.md) defines $\theta=P(W)/\lVert W\rVert^3$, while $Q(W)=\theta W$ forces $\theta=P(W)/\lVert W\rVert^2$. The two agree exactly on the unit sphere. Writing "$\theta=P(W)$" smuggles $\lVert W\rVert=1$ in; the statement should say *unit-norm* critical point.

> **And criticality is used less than the block suggests.** The identity $\tfrac{d^2}{dt^2}P(\gamma)\vert_0=6\langle L_WY,Y\rangle-3P(W)$ holds at **every** unit $W$ and every unit $Y\perp W$, critical or not. Criticality buys exactly two things: $L_ee=e$ (so $\tfrac12$ is a threshold rather than an arbitrary number), and the invariance of $W^\perp$ (§3).

## 2. Full symmetry of $T$, assumed in the block, proved here

$L_e$ is self-adjoint iff $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, and *nothing in the block says so*. It is true, term by term.

- **The $W^2$ term.** Its polarisation is $\tfrac12(XY+YX)$, and $\langle\tfrac12(XY+YX),Z\rangle=\tfrac12\operatorname{tr}(XYZ+YXZ)$, which is the full $S_3$-symmetrisation of $\operatorname{tr}(XYZ)$, the trace having only the two orbits $XYZ$ and $XZY$. Symmetric. ✓
- **The $W^{\#}$ term.** In [conventions.md](../findings/conventions.md)'s structure constants, $F(X,Y,Z)=\tfrac12c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}X_{\gamma\epsilon}Y_{\delta\zeta}Z_{\alpha\beta}$: $Z$ occupies slot 1 of both $c$'s, $X$ slot 2 of both, $Y$ slot 3 of both. Permuting the three arguments applies the **same** permutation to the slots of **both** $c$'s, and $c$ is totally antisymmetric, so the sign is $\operatorname{sgn}(\pi)^2=+1$. Fully symmetric. ✓

Hence $L_e$ is self-adjoint and "$\lambda_{\max}$" is meaningful. **Screened**: at $n=5,6$ on random Weyl tensors the three pairings of $T(X,Y,Z)$ agree to $4\times10^{-15}$ against values of order $10$.

> **A related worry, checked and dismissed.** If $Q$ did not preserve $\mathcal W_n$ the operator would be the compression $\Pi_{\mathcal W}(e\circ\cdot)$, still self-adjoint, so L24 would survive, but "$Q(W)=\theta W$" in [conventions.md](../findings/conventions.md) would need a projection. **It does preserve it**: screened at $n=5,6$, $\mathrm{Ric}(Q(W))$ and $\mathrm{Alt}(Q(W))$ vanish to $10^{-15}$ against $\lVert Q(W)\rVert\approx20$–$43$. The convention line is right as printed.

## 3. The restriction to $W^\perp$ is legitimate

$W^\perp$ *is* the tangent space to the unit sphere at $W$, so the brief's worry is the real one: is $L_e$ an operator on it, or only a compression?

$L_eW=\tfrac1\theta\,W\circ W=\tfrac1\theta Q(W)=W$ by criticality. A self-adjoint operator with eigenvector $W$ preserves $W^\perp$. **So $L_e\vert_{W^\perp}$ is a genuine restriction, the compression $\Pi_{W^\perp}L_e\Pi_{W^\perp}$ agrees with it, and no downstream citation needs restating.** This is exactly the two-line argument [Lemma L125](../findings/second-order.md) gives, written *later* and cited *by* L24's successors, while L24 itself uses it silently.

## 4. Sharpness, one clause is false, the conclusion survives

The block's three clauses, taken separately:

1. **"$e$ is an idempotent"**, **true, and immediate.** $Q(e)=Q(W)/\theta^2=\theta W/\theta^2=e$, and $Q(e)=e\circ e$ since $Q$ is homogeneous quadratic. Note $\lVert e\rVert=1/\theta$, *not* $1$.
2. **"$\langle e,L_ee\rangle=1$"**, **FALSE.** $\langle e,L_ee\rangle=\langle e,e\rangle=\lVert e\rVert^2=\theta^{-2}$. At the balanced product at $n=12$, $\theta_0^2=220/144$, so the true value is $0.6545$. The intended content is $L_eW=W$, equivalently $\langle W,L_eW\rangle=1$; the clause is that statement with $W$ mistyped as $e$. **And it is a non sequitur where it stands**: it is offered in support of sharpness *on $W^\perp$*, and $W\notin W^\perp$, the $1$-eigenvalue is precisely the direction the restriction removes.
3. **"the orbit directions are exact $\tfrac12$-eigenvectors"**, **true, unconditionally.** Differentiating the $O(n)$-equivariance $Q(g\cdot W)=g\cdot Q(W)$ at $g=e^{tX}$ with $z=X\!\cdot\!W$ gives $2L_Wz=\theta z$, i.e. $L_ez=\tfrac12z$; and $z\perp W$ because the action is orthogonal. **The record's L32 worry does not bite**: isotropy makes *some* $X$ give $z=0$, but the orbit tangent is nonzero at every nonzero critical point, since the only $O(n)$-invariant element of $\mathcal W_n$ is $0$ (the Weyl representation carries no trivial summand at any $n\ge4$). So $\tfrac12\in\sigma(L_e\vert_{W^\perp})$ at every critical point, and the bound is sharp.

**Consequence worth stating and absent from the block:** since $\tfrac12$ is always attained, L24 at a maximiser is an **equality**, $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$, not merely a bound.

## 5. The Scope paragraph is REFUTED, and the reason is structural

> *"The hypothesis $\theta>0$ is load-bearing: at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses."*, traced to [REVIEW_r27](REVIEW_r27.md), whose one line is the whole of the evidence.

**The structural objection kills the inference before any witness is examined.** $e=W/\theta$ is **invariant under $W\mapsto-W$**: $Q(-W)=Q(W)$, so $-W$ is critical with multiplier $-\theta$, and $(-W)/(-\theta)=e$. And $(-W)^\perp=W^\perp$. **So $L_e\vert_{W^\perp}$ is literally the same operator at $W$ and at $-W$, and $\lambda_{\max}(L_e\vert_{W^\perp})$ cannot depend on the sign of $\theta$ at all.** No $\theta<0$ point can witness a failure that its own antipode, with $\theta>0$, does not witness equally.

**Screened at $n=4$** (both points built by hand from the Fubini–Study and product-metric curvature tensors, Weyl-projected, criticality residual $\le5\times10^{-16}$, orthonormal Weyl basis of $\dim\mathcal W_4=10$):

| point | $\theta$ | $\lambda_{\max}(L_e\vert_{W^\perp})$ | $\sigma(L_e\vert_{W^\perp})$ |
| --- | --- | --- | --- |
| $W_{\mathbb{CP}^2}$ | $+1.224745$ | $0.500000$ | $-1^{(2)},0^{(6)},\tfrac12^{(2)}$ |
| $-W_{\mathbb{CP}^2}$ | $-1.224745$ | $0.500000$ | identical |
| $W_{S^2\times S^2}$ | $+0.866025$ | $1.000000$ | $-1^{(4)},\tfrac12^{(4)},1$ |
| $-W_{S^2\times S^2}$ | $-0.866025$ | $1.000000$ | identical |

**Both readings of the numeral fail, and they fail differently:**

- **If $-0.866$ is $-\sqrt{3/2}$ in the $\sqrt2$-deflated normalisation** that [conventions.md](../findings/conventions.md) flags as a standing trap ("*applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$*"; $1.224745/\sqrt2=0.866025$), then the point **is** the $\mathfrak u(2)$ point $-W_{\mathbb{CP}^2}$, and there $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ exactly. **The inequality holds, with equality. Nothing reverses.** This is the reading the label forces: the only $\mathfrak u(2)$-invariant Weyl tensors on $\mathbb R^4$ are the multiples of $W_{\mathbb{CP}^2}$, because $\mathfrak u(2)=\mathfrak{su}(2)_-\oplus\mathfrak u(1)_+$ leaves a one-dimensional invariant space in $\mathrm{Sym}^2_0\Lambda^+$ and none in $\mathrm{Sym}^2_0\Lambda^-$.
- **If $-0.866$ is $-\theta_0(4)$ in the current normalisation**, the point is $-W_{S^2\times S^2}$, the label is wrong, and $\lambda_{\max}=1>\tfrac12$, **but the bound fails identically at $+W_{S^2\times S^2}$, where $\theta=+0.866>0$.** The failure is caused by the point not being a maximum (both signs are saddles: the Hessian $6\theta(L_e-\tfrac12)$ is indefinite either way), never by the sign of $\theta$.

**Where the sign actually enters, and what the honest scope line is.** The only place is the division of $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)\preceq0$ by $6\theta$. Consequently:

| point is | $\theta>0$ | $\theta<0$ |
| --- | --- | --- |
| local **max** of $P\vert_S$ | $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$ | $\lambda_{\min}(L_e\vert_{W^\perp})\ge\tfrac12$ |
| local **min** of $P\vert_S$ | $\lambda_{\min}\ge\tfrac12$ | $\lambda_{\max}\le\tfrac12$ |

and since $P$ is **odd** ($Q$ is quadratic, so $P(-W)=-P(W)$), the two cells giving $\lambda_{\max}\le\tfrac12$ are the two antipodes of one pair, which is why they must agree, and do.

**Three corrections follow.**

1. **Under L24's own hypothesis, "$\theta>0$" is redundant, not load-bearing.** $P$ odd and not identically zero gives $\max_{\lVert W\rVert=1}P=-\min_{\lVert W\rVert=1}P>0$, so a *maximiser* automatically has $\theta>0$. [plan.md](../plan.md) line 198 carries the verification-loop candidate "*Lemma L24's statement omitting $\theta>0$*"; **that candidate should be closed in the opposite direction**, the statement is right to omit it, and it is the Scope paragraph that needs repair.
2. **$\theta>0$ becomes a real hypothesis only if "maximizer" is weakened to "local maximum",** and then the correct reversal is $\lambda_{\min}\ge\tfrac12$, with $\tfrac12$ attained on the orbit, so $\lambda_{\min}=\tfrac12$ exactly. A witness for it must be a critical point whose $\theta>0$ representative is a local **minimum**. $-W_{\mathbb{CP}^2}$ is not one: it is the global minimum at $n=4$, its antipode being the global maximum.
3. **The Scope paragraph has already caused the error it invites.** [bounds.md](../findings/bounds.md) line 70 records the record using L24's conclusion "*as a fact about critical points, under which no second-order test could ever fail*". Presenting $\theta>0$ as the load-bearing hypothesis is what makes "critical with $\theta>0$" look sufficient. It is not, and $W_{S^2\times S^2}$ at $n=4$, critical to $2.6\times10^{-16}$, $\theta=+0.866>0$, $\lambda_{\max}=1$, is a clean witness that it is not.

## 6. Prior art, the attribution is right, the dictionary is right, the dropped clause is free

- **The dictionary between the two normalisations is stated and correct.** [The notes](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) record $c=x/\langle x^2,x\rangle$, hence $c=W/\theta=e$, $\lVert c\rVert=1/\theta$, and "maximising $\theta$ is minimising $\lVert c\rVert$". Checked: $L_c$ and $L_e$ are the *same operator*, so **no factor is lost in transit** and the 55 citations inherit nothing from the change of normalisation. The projector form $2L_c-\mathrm{Id}\preceq P_c$ restricted to $c^\perp$ is verbatim $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, and it matches this record's $6\theta(L_e-\tfrac12\mathrm{Id})=3\theta(2L_e-\mathrm{Id})$ up to the positive factor $3\theta$, the only thing the sign of $\theta$ ever touches. The misprint the notes flag ($c\otimes c$ for $P_c$) is downstream of the record's own form and does not reach it.
- **"Extremal idempotent" and "maximizer" are the same hypothesis.** $f$ is degree-zero homogeneous and odd, so $f(c)=\lvert\theta\rvert$ and $c$ is extremal exactly when the $\theta>0$ representative of $W$ is a local maximum of $P\vert_S$. KT's hypothesis therefore *contains* the orientation choice that L24 states separately as $\theta>0$, a second reason that hypothesis is not independent content.
- **"with $1$ simple" is (b) true and free, and (c) useful.** On $W^\perp$ the bound gives $\lambda\le\tfrac12<1$, and $L_eW=W$; so $\dim E(1)=1$ at every maximiser, in one line from the bound. [REVIEW_r298](REVIEW_r298.md) already reached this. **What the record misses is that this is a theorem it establishes by hand elsewhere**: [second-order.md](../findings/second-order.md)'s table of $\dim E(1)$ marks six catalogued points "indecomposable, proved" one at a time, and [fence-posts.md](../findings/fence-posts.md) needs "$\circ$-indecomposable" as a standing hypothesis. **Restoring the clause gives *every maximiser is $\circ$-indecomposable* for free**, which is exactly the residual class those files work in. It is also visibly not free at a mere critical point: $W_{S^2\times S^2}$ at $n=4$ has $\dim E(1)=2$.

## 7. One normalisation error found outside the block

[plan.md](../plan.md) line 51 states L24 as "*the maximiser bound $\lambda_{\max}(L_M)\le\theta$*". Two things are wrong with the line, and the same line admits that "pinning that normalisation is the item's first sub-step".

- **The restriction is missing.** Unrestricted, $\lambda_{\max}(L_M)=\theta$ at every maximiser, since $L_MW=\theta W$, so the line as printed is *true and vacuous*.
- **The threshold is halved.** $L_M=\theta L_e$, so L24 in $L_M$ units reads $\lambda_{\max}\big(L_M\vert_{W^\perp}\big)\le\theta/2$.

**The consumers get it right**, which is why this has cost nothing so far: [Lemma L121](../findings/second-order.md) reads $\pm\tfrac12\sqrt{\Sigma}\le\theta/2$ to give $\Sigma\le\theta^2$, [Lemma L122](../findings/second-order.md) reads $-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\preceq\tfrac\theta2$ to give $\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})\ge-(\theta+M_{jk})$, and line 709 of the same file states the convention explicitly. Only the plan line is out.

## 8. What to change

1. **[findings/second-order.md](../findings/second-order.md), Argument**, replace "*Since $e$ is an idempotent, $\langle e,L_ee\rangle=1$*" with "*Criticality gives $L_eW=W$, so $L_e$ is self-adjoint with $W$ an eigenvector and $W^\perp$ is invariant; the restriction is genuine*", and add the one-line reason $T$ is fully symmetric. That repairs the false clause and the two silent steps at once.
2. **[findings/second-order.md](../findings/second-order.md), Scope**, withdraw the $\mathfrak u(2)$ sentence. Replace with: *the hypothesis that does the work is local maximality; $\theta>0$ is automatic at a maximiser, since $P$ is odd. At a local maximum with $\theta<0$ the division by $6\theta$ flips the conclusion to $\lambda_{\min}(L_e\vert_{W^\perp})\ge\tfrac12$. The bound is not a consequence of criticality plus $\theta>0$: $W_{S^2\times S^2}$ at $n=4$ is critical with $\theta=+0.866$ and $\lambda_{\max}=1$.*
3. **Statement**, say *unit-norm* critical point, and record the equality form $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ at a maximiser.
4. **Restore KT's "$1$ simple"** as a corollary, with its consequence: every maximiser is $\circ$-indecomposable.
5. **[plan.md](../plan.md) line 51**, $\lambda_{\max}(L_M\vert_{W^\perp})\le\theta/2$.
6. **[reviews/REVIEW_r27.md](REVIEW_r27.md)**, its $\mathfrak u(2)$ line is the origin of the Scope error and should be marked superseded. Its neighbouring formula $\lambda_{\max}=\tfrac{m+2}{2(m+1)}$ for $\mathfrak u(m)\subset\mathfrak{so}(2m)$ also fails at its own $m=2$: it predicts $\tfrac23$ where $W_{\mathbb{CP}^2}$ gives exactly $\tfrac12$ (this record's own tight case). The formula is a $m\ge3$ statement.

## Method note

Analysis-only footing observed. Three screens were run, each seconds of compute on objects constructed for the purpose, each on a claim recorded above, none offered as evidence for a positive claim: full symmetry of $T$ and the geodesic identity at $n=5,6$ on random Weyl tensors; Ricci- and Bianchi-flatness of $Q(W)$; and the $n=4$ table of §5, whose two points were built by hand from closed-form curvature tensors. Every positive assertion in this report is proved analytically above the screen that checks it.
