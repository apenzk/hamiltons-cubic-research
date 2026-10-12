# Verifier v281, the repaired L03: criticality and sign of the balanced product, the transverse Hessian bound $-6\theta/(n-2)$ and its attainment, local maximality from the Hessian, and the scope lines

Cold brief ([BRIEF_L03_repair.md](BRIEF_L03_repair.md)), no prior verdict read. No numerical work: every value is exact, no scripts were written or run. Log: [agent_logs/verify-L03-v281.log](../agent_logs/verify-L03-v281.log). The quotation in the brief (lines 7-23) was diffed against [findings/second-order.md](../findings/second-order.md) lines 37-53 and is identical.

| # | Claim | Verdict |
|---|---|---|
| 1a | $W^*$ critical with $\theta=\theta_{m,m}=\sqrt2\,\frac{m-1}m\sqrt{\frac{n-1}{n-2}}>0$ from Proposition 2.25 | CONFIRMED |
| 1b | Sign remark: $P$ odd, $e$ unchanged under $W\mapsto-W$, Hessian changes sign with $\theta$ | CONFIRMED AS ALGEBRA |
| 2a | Values of $L_e$ on $W^{*\perp}$ quoted from L27 at $p=q=m$ | CONFIRMED |
| 2b | $\mu=\frac1{m-1}$ | CONFIRMED AS ALGEBRA |
| 2c | $\lambda_m-\mu=\frac{m-4}{2(m-1)}\ge0$, tie at $m=4$ | CONFIRMED AS ALGEBRA |
| 2d | $\tfrac12$ on the orbit tangent and nowhere else in $W^{*\perp}$ | CONFIRMED |
| 2e | $\mathrm{Hess}\,P\le-6\theta/(n-2)$ on $N$, equality on $S^2_0(\mathbb R^m)$ | CONFIRMED |
| 3a | Tubular neighbourhood of $\mathcal O$ with uniform $\rho$ | CONFIRMED |
| 3b | $f(0)=\theta$, $df(0)=0$, $d^2f(0)=\mathrm{Hess}\,P\vert_N$ | CONFIRMED |
| 3c | Taylor bound $f(v)\le\theta-\frac{3\theta}{n-2}\lvert v\rvert^2+K\lvert v\rvert^3$ on $\lvert v\rvert\le\rho/2$ | CONFIRMED |
| 3d | Transport of the bound along $\mathcal O$ with the same $K$ | CONFIRMED |
| 3e | Choice of $\rho'$, $U$ a neighbourhood of $\mathcal O$, $P<\theta$ on $U\setminus\mathcal O$ | CONFIRMED |
| 4 | The statement is what the proof reaches, including local maximality at $W^*$ | CONFIRMED |
| 5a | The $n=6$ paragraph as a statement of scope | CONFIRMED |
| 5b | The last line ("at $n\ge12$") as a statement of the lemma's scope | REFUTED AS STATED |
| 6 | Boundary: $n=8$, the tie, the directions attaining the bound, $v=0$ | CONFIRMED |

**Summary: the statement and its proof hold link by link for every even $n\ge8$. The one surviving discrepancy is the closing line after the $\square$, which names the range $n\ge12$ where the lemma proves $n\ge8$.**

## 0. Conventions, fixed once

- $m=n/2$, $\Sigma$ the unit sphere of $\mathcal W_n$ with the round metric induced by the Frobenius inner product, $\mathcal O=O(n)\cdot W^*$, $\theta=P(W^*)$.
- $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, $L_e=e\circ(\cdot)$, $e=W^*/\theta$.
- $N$ is the orthogonal complement of $T_{W^*}\mathcal O$ in $T_{W^*}\Sigma=W^{*\perp}$.
- $\mathrm{Hess}\,P\le c$ on $N$ means $\mathrm{Hess}\,P(v,v)\le c\lvert v\rvert^2$ for all $v\in N$.
- "Line $k$" refers to the brief, and the source line is $k+30$ in [findings/second-order.md](../findings/second-order.md) for $k\in[7,23]$.
- $K$ in the Taylor step is read as any finite upper bound for the operator norm of $d^3f$ on the closed ball of radius $\rho/2$ in $N$.

## 1. Hypothesis inventory

| Source | Hypothesis | Holds where applied | Used by the proof |
|---|---|---|---|
| Statement | $n$ even, $n\ge8$ | assumed | yes, as $m\ge4$ for L27 and for $\lambda_m\ge\mu$ |
| Statement | $W^*$ the unit Weyl tensor of $S^{n/2}\times S^{n/2}$ with $P(W^*)>0$ | identified with Nienhaus's $W_{S_{m,m}}$, see 2.1 | yes |
| Prop. 2.25 | $S_{k,l}$ with $n=k+l$ | $k=l=m$, $n=2m$ | yes |
| Prop. 2.25 | output: $Q(W_S)=\theta_{k,l}W_S$, $P(W_S)=\theta_{k,l}$ | gives criticality, unit norm and $\theta>0$ | yes |
| L24 | $W$ critical, $\theta=P(W)>0$ | from Prop. 2.25 | yes, only the Hessian formula, the "hence" clause is unused |
| L27 | $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$, at $W_{p,q}$ | $p=q=m\ge4$, $n=2m$ | yes |
| Tubular nbhd thm | $\mathcal O$ a compact embedded submanifold of the smooth Riemannian manifold $\Sigma$ | yes: orbit of the compact Lie group $O(n)$ under a linear orthogonal action | yes |
| Taylor | $f$ of class $C^3$ on a convex set containing $[0,v]$, $d^3f$ bounded there | $f$ smooth on the open $\rho$-ball in $N$, closed $\rho/2$-ball compact and convex | yes |
| Definitions | $O(n)$ acts orthogonally on $\mathcal W_n$, $P$ invariant | given | yes, for $P\equiv\theta$ on $\mathcal O$ and the transport |

Used but not written in the proof, each following from the givens or standard facts, none a finding:

- $\mathcal O$ is an embedded submanifold. Asserted without reason (line 17). It is the standard fact for orbits of compact groups, and checking the tubular theorem's hypotheses is within this audit's remit. Recorded as a withdrawn candidate in 3.W1.
- The eight non-orbit summands are mutually orthogonal and orthogonal to $T_{W^*}\mathcal O$, so $N$ is their direct sum and the quadratic-form bound follows eigenvalue by eigenvalue. This follows from self-adjointness of $L_e$ (L24's argument, line 31) with distinct eigenvalues, and within one eigenvalue from the multiplicity-free decomposition of an orthogonal representation (L27, line 52).
- The identification of $W^*$ with L27's $W_{p,q}$ at $p=q=m$. $L_e$ depends only on the line of $W$: scaling $W$ by $c\ne0$ scales $\theta$ by $c$ and leaves $e$ fixed. So normalisation and sign conventions for $W_{p,q}$ do not affect the values quoted.
- $\theta>0$ fixes the direction of the inequality $6\theta(L_e-\tfrac12)\le6\theta(\lambda_m-\tfrac12)$ on $N$. It is stated in line 11.

## 2. Criticality and sign (brief item 1)

### 2.1 Derivation

- Proposition 2.25 at $k=l=m$: $\theta_{m,m}=\sqrt2\sqrt{\big(\frac{m-1}m\big)^2\frac{n-1}{n-2}}=\sqrt2\,\frac{m-1}m\sqrt{\frac{n-1}{n-2}}$, the root of the square taken positive since $m-1>0$. This matches line 11.
- $\theta_{m,m}>0$ since $m\ge4$ gives $\frac{m-1}m>0$ and $n\ge8$ gives $\frac{n-1}{n-2}>0$.
- $P(W_S)=\langle W_S,Q(W_S)\rangle=\theta\lvert W_S\rvert^2$ and $P(W_S)=\theta\ne0$ force $\lvert W_S\rvert=1$. So $W_S$ is a unit Weyl tensor with $Q(W_S)=\theta W_S$, $\theta=P(W_S)>0$: critical on $\Sigma$ in the sense of the Definitions (line 64), and it is the $W^*$ of the statement.
- Sign: $Q$ is quadratic, so $Q(-W)=Q(W)$ and $P(-W)=\langle-W,Q(W)\rangle=-P(W)$. $-W^*$ satisfies $Q(-W^*)=\theta W^*=(-\theta)(-W^*)$, so it is critical with value $-\theta$, and $(-W^*)/(-\theta)=e$. The formula $6\theta(L_e-\tfrac12)$ then flips sign. L24 is stated only for $\theta>0$, and the proof applies it only at $W^*$, so the remark is expository and sits on no link of the chain.

Verdicts: 1a CONFIRMED, 1b CONFIRMED AS ALGEBRA.

**No finding** on item 1.

## 3. The Hessian paragraph (brief item 2)

### 3.1 The quoted values

L27 at $p=q=m$ (hypotheses checked in section 1) gives on $W^\perp$: $\tfrac12$ on $\mathbb R^m\otimes\mathbb R^m$, $\lambda_m$ on $S^2_0(\mathbb R^m)$ for each of the two factors, $+\mu$ on $\Lambda^2\otimes\Lambda^2$, $-\mu$ on $S^2_0\otimes S^2_0$, $0$ on the remaining four. Line 13 quotes exactly these, the value $1$ on $\langle W\rangle$ being correctly left out of $W^{*\perp}$. Count: $1+1+2+1+1+4=10$ summands, matching "the ten values". L27's "$\lambda_{\max}=\tfrac12$ attained exactly on the orbit tangent" (lines 40, 52) is the "and nowhere else". 2a CONFIRMED.

### 3.2 $\mu$

L27's formula at $p=q=m$: $\tfrac12-\mu=\frac{(m-2)^2-1}{2(m-1)^2}$. Then
$$\mu=\frac{(m-1)^2-(m-2)^2+1}{2(m-1)^2}=\frac{(2m-3)+1}{2(m-1)^2}=\frac{2(m-1)}{2(m-1)^2}=\frac1{m-1}.$$
Cross-check against L27's own $(3,3)$ remark: $m=3$ gives $\mu=\tfrac12$, as L27 states (line 39). 2b CONFIRMED AS ALGEBRA.

### 3.3 The comparison

$$\lambda_m-\mu=\frac{m-2}{2(m-1)}-\frac{2}{2(m-1)}=\frac{m-4}{2(m-1)},$$
which is $\ge0$ for $m\ge4$ and $0$ exactly at $m=4$. The remaining off-orbit values are $-\mu<0$ and $0$, and $\lambda_m=\frac{m-2}{2(m-1)}>0$ for $m\ge4$. So the maximum over the eight off-orbit summands is $\lambda_m$. 2c CONFIRMED AS ALGEBRA.

### 3.4 $\tfrac12$ only on the orbit tangent

The off-orbit values are $\lambda_m$, $\mu$, $-\mu$, $0$. $\lambda_m<\tfrac12$ since $m-2<m-1$. $\mu=\frac1{m-1}\le\tfrac13<\tfrac12$ for $m\ge4$. So none equals $\tfrac12$, agreeing with L27's statement. The orbit tangent is the $\tfrac12$ summand by L27 ("attained exactly on the orbit tangent", $\dim E(\tfrac12)=pq=\dim$ orbit). 2d CONFIRMED.

### 3.5 The bound and its attainment

L24 gives $\mathrm{Hess}\,P=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^{*\perp}$. On $T_{W^*}\mathcal O$ this is $6\theta\cdot0=0$. For $v\in N$ write $v=\sum_i v_i$ over the eight off-orbit summands (orthogonal, section 1). Then
$$\mathrm{Hess}\,P(v,v)=6\theta\sum_i(\lambda^{(i)}-\tfrac12)\lvert v_i\rvert^2\le6\theta(\lambda_m-\tfrac12)\lvert v\rvert^2,$$
using $\theta>0$ and $\lambda^{(i)}\le\lambda_m$. And $\lambda_m-\tfrac12=\frac{(m-2)-(m-1)}{2(m-1)}=-\frac1{2(m-1)}$, so $6\theta(\lambda_m-\tfrac12)=-\frac{3\theta}{m-1}=-\frac{6\theta}{2m-2}=-\frac{6\theta}{n-2}$. Equality holds for every $v$ in the $\lambda_m$-eigenspace within $N$, which contains $S^2_0(\mathbb R^m)$ of either factor. 2e CONFIRMED.

**No finding** on item 2. The equality set is discussed at the boundary in section 7.

## 4. From the Hessian to a local maximum (brief item 3)

### 4.1 Tubular neighbourhood (3a)

$O(n)$ is a compact Lie group acting linearly and orthogonally on $\mathcal W_n$, preserving $\Sigma$. Its orbit $\mathcal O\cong O(n)/\mathrm{Stab}(W^*)$ is a compact embedded submanifold of $\Sigma$. $P\equiv\theta$ on $\mathcal O$ by invariance. The tubular neighbourhood theorem for a compact embedded submanifold of a Riemannian manifold gives $\rho>0$, independent of the base point by compactness, with the normal exponential map a diffeomorphism from $\{(x,v):v\perp T_x\mathcal O,\ \lvert v\rvert<\rho\}$ onto an open neighbourhood of $\mathcal O$. The hypotheses hold. CONFIRMED.

### 4.2 $f$ and its derivatives at $0$ (3b)

- $f(v)=P(\exp_{W^*}v)$ is smooth on the open $\rho$-ball of $N$, and $f(0)=P(W^*)=\theta$.
- $d(\exp_{W^*})_0=\mathrm{Id}$, so $df(0)=dP_{W^*}\vert_N$. Criticality on $\Sigma$ ($Q(W^*)=\theta W^*$, $\nabla P=3Q$ by L24's argument) makes the ambient gradient normal to $\Sigma$, so $dP_{W^*}$ vanishes on $W^{*\perp}\supseteq N$. $df(0)=0$.
- For $v\in N$, $t\mapsto\exp_{W^*}(tv)$ is a geodesic $\gamma$, so $\frac{d^2}{dt^2}P(\gamma(t))\vert_0=\mathrm{Hess}\,P(v,v)+dP(\nabla_{\dot\gamma}\dot\gamma)=\mathrm{Hess}\,P(v,v)$. Also $\frac{d^2}{dt^2}f(tv)\vert_0=d^2f(0)(v,v)$. A symmetric bilinear form is fixed by its quadratic form, so $d^2f(0)=\mathrm{Hess}\,P\vert_N$.

CONFIRMED.

### 4.3 The Taylor bound (3c)

The closed ball $\bar B_{\rho/2}\subset N$ is compact, convex and inside the domain of the smooth $f$, so $K=\sup_{\bar B_{\rho/2}}\lVert d^3f\rVert<\infty$ (or any larger number). For $\lvert v\rvert\le\rho/2$ the segment $[0,v]$ lies in the ball and Taylor's theorem with Lagrange remainder gives
$$f(v)=\theta+0+\tfrac12\mathrm{Hess}\,P(v,v)+R,\qquad\lvert R\rvert\le\tfrac K6\lvert v\rvert^3\le K\lvert v\rvert^3.$$
By 3.5, $\tfrac12\mathrm{Hess}\,P(v,v)\le-\frac{3\theta}{n-2}\lvert v\rvert^2$. So the displayed bound holds for $\lvert v\rvert\le\rho/2$. CONFIRMED.

### 4.4 Transport along the orbit (3d)

For $g\in O(n)$, $g$ restricts to an isometry of $\Sigma$, so $g\circ\exp_x=\exp_{gx}\circ dg_x$ with $dg_x=g$. $g$ maps $\mathcal O$ onto itself, so $g\,T_{W^*}\mathcal O=T_{gW^*}\mathcal O$, and $g$ maps $W^{*\perp}$ onto $(gW^*)^\perp$ isometrically. Hence the normal space at $gW^*$ is $gN$ and $\lvert gv\rvert=\lvert v\rvert$. Then $P(\exp_{gW^*}(gv))=P(g\exp_{W^*}v)=P(\exp_{W^*}v)=f(v)$. Every $x\in\mathcal O$ is some $gW^*$ and every normal $u$ at $x$ is $gv$ with $v=g^{-1}u\in N$, so $P(\exp_xu)=f(g^{-1}u)$ obeys the same bound in $\lvert u\rvert$ with the same $K$. Several $g$ with $gW^*=x$ give the same conclusion. CONFIRMED.

### 4.5 $\rho'$ and $U$ (3e)

With $c=\frac{3\theta}{n-2}>0$ and $K>0$: for $0<\lvert v\rvert<\rho'=\min(\rho/2,c/K)$, the Taylor bound applies ($\lvert v\rvert<\rho/2$) and $-c\lvert v\rvert^2+K\lvert v\rvert^3=\lvert v\rvert^2(K\lvert v\rvert-c)<0$. $U$ is the image of the open subset $\{\lvert v\rvert<\rho'\}$ of the $\rho$-disc bundle under a diffeomorphism onto an open set, so $U$ is open in $\Sigma$ and contains $\mathcal O$ (the zero section). A point $y\in U\setminus\mathcal O$ is $\exp_xu$ with $\lvert u\rvert<\rho'$ and $u\ne0$, since $u=0$ gives $y=x\in\mathcal O$. So $P(y)<\theta$. CONFIRMED.

### 4.6 Withdrawn candidates

**3.W1, the orbit's submanifold property is asserted without reason.**
1. Location, line 17: "$\mathcal O$ is a compact submanifold of $\Sigma$".
2. Exhibit: no argument or citation on file for embeddedness, a hypothesis of the tubular theorem.
3. Charitable reading: every orbit of a compact Lie group acting smoothly is a compact embedded submanifold, the standard fact underlying the tubular theorem's use for orbits, and the brief directs a check that the standard theorems' hypotheses hold as applied. They do (4.1). Withdrawn: the hypothesis holds by a standard fact, no missing step of the proof.

**3.W2, division by $K$ when $K=0$.**
1. Location, line 19: "$\rho'=\min\big(\rho/2,\,3\theta/((n-2)K)\big)$".
2. Exhibit: if $K$ is taken as the supremum of $\lVert d^3f\rVert$ and that supremum is $0$, $3\theta/((n-2)K)$ is undefined.
3. Charitable reading: line 17 says "a bound $K$", and any larger number is again a bound, so $K>0$ may be chosen. Withdrawn.

**3.W3, the Taylor constant.**
1. Location, line 18: remainder written as $K\lvert v\rvert^3$.
2. Exhibit: the Lagrange remainder of order three is $\frac1{3!}d^3f(\xi)(v,v,v)$, bounded by $\frac K6\lvert v\rvert^3$, not equal to $K\lvert v\rvert^3$.
3. Charitable reading: the displayed inequality is an upper bound and $\frac K6\le K$. The written bound is true. Withdrawn.

## 5. Statement against proof (brief item 4)

- "Strictly so transverse to its $O(n)$-orbit: some neighbourhood $U$ of $\mathcal O$ in $\Sigma$ has $P<P(W^*)$ on $U\setminus\mathcal O$": exactly the conclusion of 4.5.
- "A local maximum of $P$ on $\Sigma$": $U$ is an open set containing $W^*$ with $P\le\theta$ on $U$ ($=\theta$ on $\mathcal O$, $<\theta$ off it). This is local maximality at $W^*$, and hence also within $\mathcal D_n$.
- "The Hessian transverse to $\mathcal O$ is at most $-6\theta/(n-2)$, and the bound is attained": 3.5.
- Range "every even $n\ge8$": the proof uses $m\ge4$ at every step where $m$ is constrained (L27's hypotheses, $\lambda_m\ge\mu$, $\mu<\tfrac12$).

The proof reaches every clause of the statement and nothing in the statement goes beyond it. **No finding.** Verdict 4 CONFIRMED.

## 6. The $n=6$ paragraph and the last line (brief item 5)

### 6.1 The $n=6$ paragraph (5a)

- $n=6$ gives $(p,q)=(3,3)$, excluded by L27's hypotheses, correctly stated.
- $\mu=\frac1{m-1}=\tfrac12$ at $m=3$, and L27's statement records "$\mu=\tfrac12$ giving $\dim E(\tfrac12)=18$ against an orbit of $9$". $\dim(\Lambda^2\otimes\Lambda^2)=3\cdot3=9$ and $\dim(\mathbb R^3\otimes\mathbb R^3)=9$ are consistent with $18$.
- With $\theta\ne0$ the Hessian kernel in $W^{*\perp}$ is $E(\tfrac12)$, of dimension $18$, containing the $9$-dimensional orbit tangent. Its part in $N$ has dimension $9$: "nine Hessian null directions transverse to the orbit" is right, and the second-order sufficient test indeed cannot conclude.
- "Whether $P$ rises along them is a third-order question, turning on whether $P$ is nonzero on that null space." Read as scope, not as a claim with a proof. See 6.3.W1.

The paragraph claims no result and every checkable number in it agrees with the givens. 5a CONFIRMED.

### 6.2 The last line (5b), surviving finding

1. **Location**, line 23 (source line 53): "So at $n\ge12$ the balanced product is a strict local maximum transverse to its orbit, and what remains open is whether it is the global one."
2. **Exhibit**: at $n=8$ ($m=4$, $(p,q)=(4,4)$) and at $n=10$ ($m=5$, $(p,q)=(5,5)$) every hypothesis of the statement holds, and sections 2-5 carry the proof through: $\mu=\tfrac13$, $\lambda_4=\tfrac13$, Hessian bound $-\theta$ at $n=8$, and $\mu=\tfrac14$, $\lambda_5=\tfrac38$, bound $-\tfrac34\theta$ at $n=10$. So the balanced product is a strict transverse local maximum at $n=8$ and $n=10$, which the closing line's range $n\ge12$ leaves out. The statement, two paragraphs above, says "every even $n\ge8$".
3. **Charitable reading**: the sentence is a true consequence for the range it names, since $\{n\ge12\text{ even}\}\subset\{n\ge8\text{ even}\}$, and "balanced" supplies evenness. It asserts nothing false about $n=8,10$. It does, however, open with "So", presenting itself as the lemma's conclusion, and brief item 5 asks for it as a statement of scope. As a statement of the lemma's scope it misreports the range proven.

The candidate survives as a scope misstatement. Verdict 5b REFUTED AS STATED, as a statement of the lemma's scope. The mathematical sentence is true and the lemma above the $\square$ is unaffected. The correction it would need is the range in that line, $n\ge8$ in place of $n\ge12$.

### 6.3 Withdrawn candidates

**6.3.W1, "a third-order question".**
1. Location, line 21: "Whether $P$ rises along them is a third-order question, turning on whether $P$ is nonzero on that null space."
2. Exhibit: for a unit $v$ in the transverse null space, $P(\cos t\,W^*+\sin t\,v)=\theta\cos^3t+3\theta\cos t\sin^2t\,\langle L_ev,v\rangle+\sin^3t\,P(v)$, using $T(W^*,W^*,v)=\theta\langle W^*,v\rangle=0$. With $\langle L_ev,v\rangle=\tfrac12$ this is $\theta+t^3P(v)+O(t^4)$. If $P\equiv0$ on that space the question passes to fourth order and to curves mixing null and non-null directions, so "third-order question" does not settle it in that case.
3. Charitable reading: the sentence is a scope remark naming the next order to examine, and "turning on whether $P$ is nonzero" is correct in the direction that decides: $P(v)\ne0$ makes $P$ rise along $v$ or $-v$. It does not assert that $P\equiv0$ there gives a maximum. Withdrawn.

## 7. The boundary (brief item 6)

- **$n=8$, the tie.** $m=4$: $\lambda_4=\tfrac13=\mu$, L27's hypotheses hold ($(4,4)\ne(3,3)$), $\tfrac12-\mu=\frac{(4-2)^2-1}{2\cdot3^2}=\tfrac16>0$, so $\mu=\tfrac13$. The maximum off the orbit is still $\lambda_4$, the tie only enlarging the equality set. Bound $6\theta(\tfrac13-\tfrac12)=-\theta=-\frac{6\theta}{6}$. No step of section 4 uses strictness of $\lambda_m>\mu$.
- **Directions attaining the bound.** The equality set in $N$ is the $\lambda_m$-eigenspace: $S^2_0(\mathbb R^m)\oplus S^2_0(\mathbb R^m)$ (both factors) for $m\ge5$, and additionally $\Lambda^2\otimes\Lambda^2$ at $m=4$. Line 15 says "with equality on $S^2_0(\mathbb R^m)$", which is true (equality does hold there) and suffices for "the bound is attained". It does not claim that the equality set is exactly that summand, so the extra directions at $m=4$ are no defect. No finding.
- **$v=0$.** $f(0)=\theta$ and the bound reads $\theta\le\theta$. The strict inequality is claimed only for $0<\lvert v\rvert<\rho'$ and only on $U\setminus\mathcal O$, whose points have $v\ne0$ (4.5). No finding.
- **$n=6$** lies outside the statement's range and is handled as scope (6.1).

Verdict 6 CONFIRMED.

## 8. Quantifier order and scope

Order in the proof: $\rho$ (from compact $\mathcal O$, uniform over the orbit), then $f$ at the single point $W^*$, then $K$ from the closed $\rho/2$-ball of $N$ at $W^*$, then transport (4.4) making the same $\rho$-domain and the same $K$ valid at every $x\in\mathcal O$, then $\rho'=\min(\rho/2,\frac{3\theta}{(n-2)K})$ depending on $\rho,K,\theta,n$ only, then $U$ as the $\rho'$-disc-bundle image. No choice depends on a point of the orbit: $\rho$ by the tubular theorem, $K$ and $\rho'$ because they are fixed at $W^*$ and carried by isometries. **No finding.**

## 9. Falsifying objects and what was done to look for them

| Claim | Object that would falsify it | Search |
|---|---|---|
| 1a | A normalisation of Prop. 2.25 at $k=l$ giving a different $\theta_{m,m}$, or $P(W_S)<0$ | Substituted $k=l=m$ into the quoted formula, checked sign and unit norm |
| 1b | A $W$ with $P(-W)\ne-P(W)$ | Expanded $Q(-W)=Q(W)$ |
| 2a-2d | An off-orbit summand with $L_e$-value $>\lambda_m$ or $=\tfrac12$ | Evaluated all eight values in closed form for $m\ge4$ against L27 |
| 2e | $v\in N$ with $\mathrm{Hess}\,P(v,v)>-\frac{6\theta}{n-2}\lvert v\rvert^2$ | Decomposed $v$ over orthogonal summands, used $\theta>0$ |
| 3a-3e | A point $x\in\mathcal O$ where the Taylor constant fails, or $y\in U\setminus\mathcal O$ with $P(y)\ge\theta$ | Checked uniformity of $\rho$, the transport identity, openness of $U$, $u\ne0$ off $\mathcal O$, and the edge cases $K=0$ and the $\frac16$ factor |
| 4 | A $W$ arbitrarily near $W^*$ in $\Sigma$ with $P(W)>\theta$ | Reduced to 3e via $W^*\in\mathcal O\subset U$ |
| 5a | A mismatch of the $n=6$ counts with L27's $(3,3)$ remark | Recomputed $\mu$ at $m=3$ and the dimensions $9+9=18$ |
| 5b | An even $n\ge8$ below $12$ where the lemma holds | Found: $n=8$ and $n=10$ (6.2) |
| 6 | A step using $\lambda_m>\mu$ strictly, failing at $m=4$ | Re-read sections 3-4 with $m=4$, none uses strictness |

## 10. Overall verdict

**PROVEN.** The statement and proof on source lines 37-51 are correct for every even $n\ge8$, every link following from the hypotheses, the givens (Proposition 2.25, L24, L27) applied within their hypotheses, and the tubular neighbourhood and Taylor theorems with their hypotheses met. Outside the $\square$, the closing line on source line 53 misstates the lemma's range as $n\ge12$ (REFUTED AS STATED as a statement of scope, 6.2), a record inconsistency that does not touch the lemma.
