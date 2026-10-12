# Gate 2 brief, (MG) as the endpoint criterion on the great circle through the diagonal part, for I121 (route R54)

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28-LIT-step8-sweep.md](2026-09-28-LIT-step8-sweep.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it, saying why an argument could not (numpy is available under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps, censuses or open-ended searches.

## Definitions

- $\mathcal W_n$ is the space of algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$ with the Hilbert–Schmidt inner product. $Q(R)=R^2+R^\#$, $P(W)=\langle Q(W),W\rangle$, $L_WX=Q(W,X)$ the polarisation, so $\langle L_XY,Z\rangle$ is totally symmetric. A unit critical point has $Q(W)=\rho W$. $\Theta_n=\max P$ on the unit sphere of $\mathcal W_n$, and a global maximiser has $\rho=\Theta_n$.
- In an orthonormal frame, $\mathcal D_n$ is the subspace of operators diagonal in the pair basis, $A=\pi_{\mathcal D}W$, $B=W-A$, $t=\lVert A\rVert$, $b=\lVert B\rVert$, $a=\langle L_AB,B\rangle$. **(MG)**: $\rho\le\max\{\sqrt{3/2},P(A)/\lVert A\rVert^3\}$ in a frame globally maximising $\lVert\pi_{\mathcal D}W\rVert^2$.

## Givens, each stated in full

- **[L214](../findings/second-order.md)** (Gate 2 passed, Lean), in any orthonormal frame, with $D=\pi_{\mathcal D}W$, $N=W-D$, **$t_{214}=\lVert D\rVert^2$** (the square of this brief's $t$), $a=\langle D\circ N,N\rangle$, at a unit critical point:
$$\theta\,t=P(D)+a,\qquad\theta\,(1-t)=2a+P(N),$$
**and if in addition $L_W\le\tfrac\theta2$ on $W^\perp$, which [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement) gives at every GLOBAL maximiser, and at a local one with $\theta>0$, then**
$$a\ \ge\ \tfrac\theta2\,t(1-t),\qquad\text{equivalently}\qquad P(D)\ \le\ \tfrac\theta2\,t(1+t).$$
- **[L120](../findings/second-order.md)** (Gate 2 passed, Lean): $L_M$ preserves each sign-isotypic summand at every diagonal $M$, and $\mathcal D_n$ is the trivial summand, so $Q(M)\in\mathcal D_n$ for diagonal $M$.
- **The outside author's binary endpoint criterion** (rebuilt and CONFIRMED by [r1801](REVIEW_r1801.md) and [r1802](REVIEW_r1802.md)): for $d>0$, $\tau>0$, $q\ge0$, $d\ge2\tau$, $\max_{t,u\ge0,\,t^2+u^2=1}(dt^3+3\tau tu^2+qu^3)=d$ iff $dq^2\le(d+\tau)^2(d-2\tau)$.
- $P(M)\le\Theta_n\lVert M\rVert^3$ for every $M\in\mathcal W_n$, by the definition of $\Theta_n$.

## The claims

- **The circle.** With $\hat A=A/t$ and $\nu=B/b$, $W=\cos\varphi_0\,\hat A+\sin\varphi_0\,\nu$, $\cos\varphi_0=t$, and on the circle $u(\varphi)=\cos\varphi\,\hat A+\sin\varphi\,\nu$
$$g(\varphi)=P(u(\varphi))=p\cos^3\varphi+3r\cos\varphi\sin^2\varphi+q\sin^3\varphi,\qquad p=P(\hat A),\ r=\langle L_{\hat A}\nu,\nu\rangle,\ q=P(\nu),$$
the $\cos^2\varphi\sin\varphi$ term vanishing because $Q(\hat A)$ is diagonal ([L120](../findings/second-order.md)). L214's relations are $\rho=tp+\tfrac{b^2}tr$ and $q=(\rho-2tr)/b$.
- **The equivalence.** At a global maximiser $g\le\rho=g(\varphi_0)$ and $p=g(0)\le\rho$, so above $\sqrt{3/2}$, **(MG) $\iff p=\rho\iff$ the arc $[0,\tfrac\pi2]$ of $g$ peaks at its diagonal end**, which is the outside author's binary endpoint criterion ([r1801](REVIEW_r1801.md) rebuilt it): for $p>0$, $r>0$, $q\ge0$ it holds iff $p\ge2r$ and $p\,q^2\le(p+r)^2(p-2r)$. *Closedness is not used: it makes the circle $P$-invariant, and the criterion needs only $g$.* **So the nonclosed branch asks for the same joint bound on $(r,q)$ against $p$ as the closed one, and the closed branch's reduction to a bound on $q=P(f)$ ([I122](../plan.md)) is the special case $\nu=f$.** Necessity of $p\ge2r$ is second order at $\varphi=0$, and under (MG) the relations force $r=\tfrac{pt}{1+t}$.
- **What it names.** A proof of (MG) is a bound on the off-diagonal direction's own cubic $q=P(\nu)$ and its coupling $r$, jointly with the diagonal value $p$, for $\nu$ allowed by the maximal frame. *The crude $q\le\Theta_n$ is circular, and F67 forbids bounding $r$ and $p$ separately.*

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the circle cubic has no $\cos^2\varphi\sin\varphi$ term | `circle_cubic` in [CircleEndpoint.lean](../lean/HamiltonsCubic/Results/CircleEndpoint.lean) | abstract: a symmetric trilinear $T$ with $T(a,a,b)=0$; **not** that $T(\hat A,\hat A,\nu)=0$, which is L120 |
| L214's relations in the circle's coordinates | none: a substitution of $P(A)=t^3p$, $a=tb^2r$, $P(B)=b^3q$ into L214; check it | |
| above $\sqrt{3/2}$, (MG) $\iff p=\rho$ | `mg_iff_value` | given $p\le\rho$ |
| (MG) $\iff$ the arc peaks at its diagonal end $\iff$ the endpoint criterion | none: the criterion is the author's, a one-variable inequality; check that its hypotheses hold here | |
| under (MG), $r=\tfrac{pt}{1+t}$ | `tie_of_mg` | also that the criterion then holds with equality |
| closedness only makes the circle $P$-invariant; the closed branch's reduction is the case $\nu=f$ | none: a reading of the closed branch; check it | |

## What to attack

1. **The circle cubic**: is $\langle Q(\hat A),\nu\rangle=0$ exactly what kills the $\cos^2\varphi\sin\varphi$ term, with $r=\langle L_{\hat A}\nu,\nu\rangle$ the coefficient of $3\cos\varphi\sin^2\varphi$ in this normalisation?
2. **L214 in these coordinates**: $\rho=tp+\tfrac{b^2}tr$ and $q=(\rho-2tr)/b$, from L214's two relations with $t_{214}=t^2$.
3. **The equivalence at a global maximiser.** Does $g\le\rho$ on the whole circle follow, is $\varphi_0\in(0,\tfrac\pi2)$, and is "(MG) $\iff p=\rho\iff$ the arc peaks at its diagonal end" right? **Are the criterion's hypotheses $p>0$, $r>0$, $q\ge0$, $p\ge2r$ available**, and what happens when one fails (for instance $q<0$ or $r\le0$)? Is the arc $[0,\tfrac\pi2]$ the right domain, or can the circle's maximum sit outside it?
4. **Necessity of $p\ge2r$** as a second-order condition at $\varphi=0$, and the claim that under (MG) the relations force $r=\tfrac{pt}{1+t}$.
5. **The closed branch as a special case**: in the closed branch ($Q(e)=de$, $Q(e,f)=\tau f$, $Q(f)=\tau e+qf$) is the circle through $e$ and $f$ this circle, with $(p,r,q)=(d,\tau,q)$?
6. **Hypotheses**: every place a global maximiser, a globally maximal frame, $0<t<1$, $\rho>0$ or $\rho>\sqrt{3/2}$ is used. Is anything used unstated?
