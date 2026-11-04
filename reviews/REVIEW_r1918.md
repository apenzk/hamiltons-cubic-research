# REVIEW r1918: I124 batch 1, the great circle toward the diagonal part

Log: [agent_logs/r1918-i124-circle.log](../agent_logs/r1918-i124-circle.log). Section under review: [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md), its two opening paragraphs and batch 1. Footing: analysis only. No numerical screen was run. Every verdict below rests on a derivation from the definitions, plus the Lean file for the identity.

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every step of the chain holds. The main observation is on novelty: batch 1's identity is [L214](../findings/second-order.md#lemma-l214-the-frame-split-two-exact-relations-in-every-frame-and-one-inequality-under-the-second-order-cap)'s cancellation (step 3, test vector $X=tN-(1-t)D$), rewritten in circle coordinates. What batch 1 adds is one line: by AM-GM, L214's necessary inequality holds strictly whenever $P(d)\le\theta$.

| # | claim | verdict |
|---|---|---|
| 1 | second-variation formula, orbit tangents with equality | CONFIRMED |
| 2 | closure of $D$ under $Q$, polarisation, $T(x,x',y)=0$ | CONFIRMED (one notational slip) |
| 3 | circle restriction and $3E$ | CONFIRMED |
| 4 | component equations, identity, descent bound, the test | CONFIRMED |
| 5 | appeal to L57, edge cases | CONFIRMED WITH OBSERVATIONS |
| 6 | the two bullets | CONFIRMED WITH ONE CORRECTION (the block form leaves out the circle direction) |
| 7 | Lean | CONFIRMED (standard axioms only) |
| 8 | prior record | DUPLICATES L214 step 3, with a one-line sharpening |

## 1. The second-variation formula

Put $f(t)=P(\cos t\,W+\sin t\,v)$ with unit $v\perp W$. Then $f=\theta\cos^3t+3\cos^2t\sin t\,T(W,W,v)+3\cos t\sin^2t\,T(W,v,v)+\sin^3t\,P(v)$. Here $T(W,W,v)=\langle Q(W),v\rangle=\theta\langle W,v\rangle=0$ and $P(W)=\langle Q(W),W\rangle=\theta$. Hence $f''(0)=-3\theta+6T(W,v,v)=6\big(T(W,v,v)-\tfrac\theta2\lvert v\rvert^2\big)$. This agrees with [second-order.md](../findings/second-order.md)'s Hessian $6\theta(L_e-\tfrac12)$ because $T(W,v,v)=\theta\langle L_ev,v\rangle$. At an orbit tangent $v=X\cdot W$ we have $v\perp W$, since the action is skew. `L24_sharp_vec` gives $W\circ v=\tfrac\theta2v$, so $T(W,v,v)=\tfrac\theta2\lvert v\rvert^2$ and equality holds. **CONFIRMED.**

## 2. Closure of $D$ under $Q$

- $W^2$: the $\varphi_{ab}$ are orthonormal, so $W^2=\sum w_{ab}^2\varphi_{ab}\varphi_{ab}^{\mathsf T}$, which is diagonal.
- $W^\#W=\tfrac12\sum w_{ab}w_{cd}[\varphi_{ab},\varphi_{cd}][\varphi_{ab},\varphi_{cd}]^{\mathsf T}$. The bracket $[e_a\wedge e_b,e_c\wedge e_d]$ is zero unless the two pairs share exactly one index. When they do, it is $\pm$ the wedge on the symmetric difference of the pairs (for example $b=c$ gives $\pm\varphi_{ad}$). So each term is a multiple of some $\varphi_{ij}\varphi_{ij}^{\mathsf T}$, which is diagonal. **Notational slip:** the note writes "a multiple of $\varphi_{ac}\varphi_{ac}^{\mathsf T}$", and that is right only for the labelling $b=d$. The operator is diagonal whichever pair it is, so the conclusion is unaffected.
- **No Weyl projection is needed.** $Q$ maps Weyl to Weyl (a premise), and $Q(W)$ is diagonal in the $\varphi$ basis, so $Q(W)\in D$. $D$ is a linear subspace (the Weyl space intersected with the span of the $\varphi_{ab}\varphi_{ab}^{\mathsf T}$), so $x+x'\in D$. Polarisation $x\circ x'=\tfrac12(Q(x+x')-Q(x)-Q(x'))$ then gives $D\circ D\subseteq D$, and so $T(x,x',y)=\langle x\circ x',y\rangle=0$ for $y\perp D$. **CONFIRMED.**
- $\pi_DW$ also has a direct description. Ricci-flatness constrains only the pair-diagonal entries $W_{abab}$, so keeping those entries already gives a Weyl tensor, and that tensor is $\pi_DW$. This is L214's remark, citing L123. The projection taken inside the Weyl space and the one taken inside $\mathrm{Sym}^2\Lambda^2$ coincide.

## 3. The circle restriction and $3E$

$\hat A\perp\nu$ and both are unit, so $\varphi\mapsto\cos\varphi\,\hat A+\sin\varphi\,\nu$ is a unit-speed great circle through $W$ at $(\cos\varphi,\sin\varphi)=(a,b)$. The cross term $3\cos^2\varphi\sin\varphi\,T(\hat A,\hat A,\nu)$ vanishes by item 2. Differentiating by hand:

- $(c^3)''=6cs^2-3c^3$
- $(cs^2)''=2c^3-7cs^2$
- $(s^3)''=6c^2s-3s^3$

So $f''=3\big[p(2cs^2-c^3)+r(2c^3-7cs^2)+q(2c^2s-s^3)\big]=3E$ at $(c,s)=(a,b)$. **CONFIRMED.** The restriction is R54's $g(\varphi)$ ([2026-09-28 sweep](2026-09-28-LIT-step8-sweep.md), Phase 3a), with $r=T(\hat A,\nu,\nu)=\langle L_{\hat A}\nu,\nu\rangle$.

## 4. Component equations, the identity, and the descent bound

- $\langle Q(W),\hat A\rangle=a^2T(\hat A,\hat A,\hat A)+2abT(\hat A,\hat A,\nu)+b^2T(\nu,\nu,\hat A)=a^2p+b^2r$, and this equals $\theta a$.
- $\langle Q(W),\nu\rangle=a^2\cdot0+2ab\,r+b^2q=\theta b$.
- These are L214's relations with $t_{L214}=a^2$, $D=a\hat A$ and $N=b\nu$.
- The identity $b^2E=2ap-\theta(1+a^2)$ is `circle_second`, a `linear_combination` certificate that uses $a^2+b^2=1$. $a\ge0$ gives $2ap\le2a\theta$, and then $b^2E\le-\theta(1-a)^2$, which is strictly negative for $a<1$ and $\theta>0$. Dividing by $b^2>0$ gives $P''=3E\le-3\theta(1-a)^2/b^2$.
- **Is this the right test? Yes.** $W$ is critical, so the first derivative vanishes along every geodesic. The second derivative of $P$ along the unit-speed great circle is the Riemannian Hessian at its unit tangent $u=-b\hat A+a\nu$. That Hessian is quadratic in $u$, so a negative value makes both $\pm u$ strict second-order descents, including $-u$, the direction toward $\hat A$. This is item 1's $6(T(W,u,u)-\tfrac\theta2)$ read at $u$. **CONFIRMED.**
- **Cross-check against L214.** Its step 3 gives $\langle L_WX,X\rangle=\theta t(1-t)-a_{L214}$ at $X=tN-(1-t)D$. Here $X=ab\cdot u$ and $\lvert X\rvert^2=a^2b^2$. So the Hessian along $u$ is $6\big(P(D)-\tfrac\theta2t(1+t)\big)/(t(1-t))=3\big(2ap-\theta(1+a^2)\big)/b^2$, which is batch 1's formula exactly.

## 5. L57 and the edge cases

- $\hat A$ is a unit diagonal Weyl tensor, so L57 gives $p\le\Theta_n\le\theta$. This covers every critical point with $\theta\ge\Theta_n$, in every frame with $a,b>0$. **CONFIRMED.**
- **The brief's premise formula for $\Theta_n$ is the even-$n$ one only.** The record's $\Theta_n$ is $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}<\theta_0(n)$ at odd $n$ ([conventions.md](../findings/conventions.md) rows 18–19, [problem.md](../findings/problem.md) L2). The section itself writes only "$\Theta_n$" with a link to L57, which is correct at both parities. The commit title's "above $\theta_0$" is weaker than what is proved at odd $n$, so it is also correct.
- **$a=1$** is excluded by $b>0$, which non-diagonality supplies in every frame.
- **$a=0$** leaves $\hat A$ undefined, so the prose rightly assumes $a>0$. The conclusion still holds in a stronger form: for any unit $x\in D$, $T(W,x,x)=\langle x\circ x,\nu\rangle=0$, so the Hessian is $-3\theta$ on all of $D$, with no appeal to L57. This matches the identity at $a=0$, $b=1$. `circle_descent` already allows $a=0$.
- **$a>0$ in some frame always holds**: $\pi_DW=0$ in every frame would make every $W_{abab}$ vanish in every frame, hence $W=0$. This matters for the maximal frame in item 6.
- "Which a global maximiser satisfies whatever its value": correct, since $p=P(\hat A)\le\max P=\theta$. At a global maximiser, L214 already gives the non-strict inequality. Batch 1 adds strictness with a margin of $\theta(1-a)^2$.

## 6. The bullets

- **"The ascent direction must leave $\mathop{\mathrm{span}}\{W,\pi_DW\}$."** Take $a>0$. Then the span is $\mathop{\mathrm{span}}\{\hat A,\nu\}$, and its intersection with $T_W=W^\perp$ is the line $\mathbb Ru$. Batch 1 makes the Hessian negative on that line, so no tangent ascent direction lies in the plane. **CONFIRMED.**
- **Block form: signs and factors are right.** With $v=x+y$, $x\in D\ominus\hat A$, $y\in D^\perp\ominus\nu$, the expansion $T(W,v,v)=aT(\hat A,v,v)+bT(\nu,v,v)$ gives the following terms:
  - $T(\hat A,x,y)=0$ by closure.
  - $T(\nu,x,x)=\langle x\circ x,\nu\rangle=0$.
  - What remains is $a\langle\hat A\circ x,x\rangle+a\langle\hat A\circ y,y\rangle+2b\langle\nu\circ x,y\rangle+b\langle\nu\circ y,y\rangle$, as written.
  - $x\perp W$ and $y\perp W$ hold as stated.
- **Correction: the block form is the Hessian on $W^\perp\ominus\mathbb Ru$, a subspace of codimension one, and it is not the whole second variation.** $W^\perp=\mathbb Ru\oplus(D\ominus\hat A)\oplus(D^\perp\ominus\nu)$, and the $u$-row does not decouple. By closure:
  - $T(W,u,x)=ab\,\langle\nu\circ\nu-\hat A\circ\hat A,\,x\rangle$
  - $T(W,u,y)=(a^2-b^2)\langle\hat A\circ\nu,y\rangle+ab\langle\nu\circ\nu,y\rangle$

  Both are generically nonzero. An ascent direction may therefore mix $u$ with $x+y$, and a negative block on $\{x+y\}$ together with the negative $u$ entry would not rule ascent out. The bullet should say that the displayed form is the restriction to $u^\perp\cap W^\perp$. The two candidate families lie inside that subspace, so they stand as candidates.
- **Diagonal block alone.** With $y=0$ the form is $a\langle\hat A\circ x,x\rangle-\tfrac\theta2\lvert x\rvert^2$, so ascent holds iff $a$ times the top of the compression $\pi_{D\ominus\hat A}L_{\hat A}|_{D\ominus\hat A}$ exceeds $\tfrac\theta2$. **Minor:** $D\ominus\hat A$ is invariant under $L_{\hat A}$ only when $Q(\hat A)\parallel\hat A$, so "$\lambda_{\max}(L_{\hat A}|_{D\ominus\hat A})$" should be read as the compression. Here $L_{\hat A}=\hat A\circ\cdot$ is unnormalised, unlike $L_e=\theta^{-1}W\circ\cdot$. **CONFIRMED** with that reading.
- **$X\cdot\hat A\in D^\perp$.** For $x'\in D$, $\langle[\mathrm{ad}_X,\hat A],x'\rangle=\mathop{\mathrm{tr}}(\mathrm{ad}_X(\hat Ax'-x'\hat A))=0$, because $\hat A$ and $x'$ are both diagonal in the $\varphi$ basis and so commute. **CONFIRMED.**
- **The maximal frame's first-order condition.** $\tfrac{d}{ds}\lVert\pi_D(e^{-sX}\cdot W)\rVert^2|_0=-2a\langle\hat A,X\cdot W\rangle=2a\langle X\cdot\hat A,W\rangle=2ab\langle X\cdot\hat A,\nu\rangle$, using skewness and $\langle X\cdot\hat A,\hat A\rangle=0$. The maximum exists because $O(n)$ is compact, and $a>0$ there by item 5. So the condition is $\langle X\cdot\hat A,\nu\rangle=0$, and together with $X\cdot\hat A\perp D$ this gives $X\cdot\hat A\perp W$, in fact $X\cdot\hat A\in D^\perp\ominus\nu$. **CONFIRMED.** This is the "first-order condition" already used in R53 ([r1816](REVIEW_r1816.md), [r1817](REVIEW_r1817.md)).

## 7. Lean

[I124Circle.lean](../lean/HamiltonsCubic/Results/I124Circle.lean), imported from [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) at line 1121.

- `circle_second` states exactly $b^2E=2ap-\theta(1+a^2)$ under $a^2+b^2=1$ and the two component equations, with $E$ defined as in the prose.
- `circle_descent` adds $0\le a<1$, $\theta>0$ and $p\le\theta$, and concludes both $b^2E\le-\theta(1-a)^2$ and $b^2E<0$. Both match the table.
- Non-vacuity: the example at $(a,b,p,\theta)=(3/5,4/5,1,2)$ with $r=21/16$ and $q=17/32$ checks by hand ($\tfrac{9}{25}+\tfrac{16}{25}\cdot\tfrac{21}{16}=\tfrac{30}{25}=\tfrac65$, and $\tfrac{24}{25}\cdot\tfrac{21}{16}+\tfrac{16}{25}\cdot\tfrac{17}{32}=\tfrac{63}{50}+\tfrac{17}{50}=\tfrac85$). The example fixes all hypotheses except $0\le a<1$, $\theta>0$ and $p\le\theta$, which hold by inspection.
- As the table says, the declarations are scalar algebra over reals. The geometry (closure, restriction, second derivative) enters only through the hypotheses. The operator-level analogue of the same cancellation is already typed as `L214_frame` and `L214_frame_cap` ([L214Frame.lean](../lean/HamiltonsCubic/Results/L214Frame.lean)), and these instantiate the component equations at $P$'s own operators.

`#print axioms`: both `circle_second` and `circle_descent` depend on `[propext, Classical.choice, Quot.sound]` only, with no `sorryAx`. **CONFIRMED.**

## 8. On the record already?

- **The circle and its restriction are R54's**, from the [2026-09-28 sweep](2026-09-28-LIT-step8-sweep.md) Phase 3a, where L120 (as here) gives the vanishing $\cos^2\sin$ term. **The component equations are L214's two relations**, and the sweep writes them as $\rho=tp+\tfrac{b^2}tr$ and $q=(\rho-2tr)/b$.
- **The second variation along the circle direction is L214 steps 2–4.** The test vector $X=tN-(1-t)D$ is $ab\,u$, the cancellation $\langle L_WX,X\rangle=\theta t(1-t)-a$ is batch 1's identity after normalisation, and L214's inequality $P(D)\le\tfrac\theta2t(1+t)$ is exactly $b^2E\le0$. So `circle_second` is a restatement of L214's cancellation. What is new is the reading of the sign.
- **The sharpening is one line**, and I found it nowhere on the record. Put $P(D)=t^{3/2}P(d)$. When $P(d)\le\theta$, $t^{3/2}\theta\le\tfrac\theta2t(1+t)$ holds because $2\sqrt t\le1+t$, strictly for $t<1$. So **L214's second-order inequality is never violated, and never informative, at a critical point with $\theta\ge\Theta_n$.** L214's inequality is a necessary condition for a maximiser, and batch 1 shows that above $\Theta_n$ every critical point satisfies it, strictly. This belongs beside [post F67](../findings/INDEX-traps.md) in spirit: one more L214 consequence that is slack exactly where it would matter. It closes nothing new, but it is correctly stated as a closure of the simplest candidate direction.
- **Recommendation.** Batch 1 should cite L214 steps 2–4 as the source of the identity, and state its content as "L214's inequality holds strictly above $\Theta_n$ by AM-GM and L57". It should not read as a new second-variation computation. R54's note that "necessity of $p\ge2r$ is second order at $\varphi=0$" concerns the endpoint $\hat A$, not $W$, so there is no conflict.
