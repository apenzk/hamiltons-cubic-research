# REVIEW r1916: I124 batch 1, the circle toward the diagonal part

Log: [agent_logs/r1916-i124-circle.log](../agent_logs/r1916-i124-circle.log). Section under review: [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md), the two opening paragraphs and batch 1. Lean: [I124Circle.lean](../lean/HamiltonsCubic/Results/I124Circle.lean). Analysis-only footing: every verdict below rests on a hand derivation, and the two screens named are screens.

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every step of batch 1 is correct. The mathematics is on the record already: the circle is [R54](../routes.md)'s (phase 3a of the [2026-09-28 sweep](2026-09-28-LIT-step8-sweep.md), Gate 2 by r1821 and r1822, with `circle_cubic` and `g_at_W` in [CircleEndpoint.lean](../lean/HamiltonsCubic/Results/CircleEndpoint.lean)), its second derivative at $W$ is [L214](../findings/second-order.md)'s step 3 at the unit tangent, and the descent bound is L214's inequality form with the AM–GM slack $\tfrac\theta2T(1-\sqrt T)^2$ read off. What is new is the reading at every critical point with $p\le\theta$ (L214's inequality is stated under the second-order cap, that is at a maximiser). One real defect sits in the second bullet: the block form is the second variation on $W^\perp\ominus u$, missing the row of the circle's own tangent $u$, whose coupling to both blocks is nonzero.

| # | claim | verdict |
|---|---|---|
| 1 | second-variation formula, orbit equality | CONFIRMED |
| 2 | closure of $D$ under $Q$, $T(x,x',y)=0$ | CONFIRMED, one label slip |
| 3 | circle restriction, second derivative $3E$ | CONFIRMED |
| 4 | component equations, identity, descent bound, the test | CONFIRMED |
| 5 | appeal to L57, edge cases | CONFIRMED WITH OBSERVATIONS (scope $a>0$; title "above $\theta_0$" is loose at odd $n$) |
| 6 | the two bullets | first bullet CONFIRMED; block form CORRECT AS STATED BUT INCOMPLETE (omits the $u$-row); $X\cdot\hat A\in D^\perp$ and the first-order condition CONFIRMED |
| 7 | Lean | CONFIRMED, standard axioms, builds clean |
| 8 | on the record already | DUPLICATES L214 step 3 plus the sweep's line 72, SHARPENS only by the critical-point reading |

## 1. The second variation

$f(t)=P(\cos t\,W+\sin t\,v)=\cos^3t\,\theta+3\cos^2t\sin t\,T(W,W,v)+3\cos t\sin^2t\,T(W,v,v)+\sin^3t\,P(v)$. $T(W,W,v)=\langle Q(W),v\rangle=\theta\langle W,v\rangle=0$. At $t=0$ only $\cos^3t$ and $3\cos t\sin^2t$ contribute: $f''(0)=-3\theta+6T(W,v,v)=6\big(T(W,v,v)-\tfrac\theta2\big)$ at $\lvert v\rvert=1$. This is the record's Hessian $6\theta(L_e-\tfrac12)$ ([second-order.md](../findings/second-order.md), the criterion). Orbit tangents: `L24_sharp_vec` gives $W\circ v=\tfrac\theta2v$, so $T(W,v,v)=\tfrac\theta2\lvert v\rvert^2$, equality. CONFIRMED. The great circle is a geodesic of the sphere and $W$ is critical, so $f''(0)$ is the Riemannian Hessian's value on $v$, which answers the test question in row 4.

## 2. Closure of $D$ under $Q$

- $X^2$ of $\sum w_{ab}\varphi_{ab}\varphi_{ab}^{\mathsf T}$ is $\sum w_{ab}^2\varphi_{ab}\varphi_{ab}^{\mathsf T}$ (orthonormal $\varphi_{ab}$). Diagonal.
- $[e_a\wedge e_b,e_c\wedge e_d]$ vanishes unless $\{a,b\}$ and $\{c,d\}$ share exactly one index, and then it is $\pm$ the wedge of the two unshared indices. **Label slip**: with the note's labels the product is a multiple of $\varphi_{\{a,b\}\triangle\{c,d\}}\varphi^{\mathsf T}$, which is $\varphi_{ac}$ only when $b=d$. The conclusion (a pair-diagonal rank one term, or zero) is unaffected.
- $\#$ is bilinear, so $X^\#X$ is a sum of such terms, diagonal. The Weyl projection is unneeded: the premise that $Q$ preserves Weyl tensors makes $Q(X)$ itself Weyl and it is diagonal as computed. (The record's own route is L120 via the sign group, cited in L214.)
- Polarisation: $x\circ x'=\tfrac12(Q(x+x')-Q(x)-Q(x'))\in D$ since $D$ is a linear subspace, so $T(x,x',y)=\langle x\circ x',y\rangle=0$ for $y\perp D$. CONFIRMED.

## 3. The circle and $3E$

$T(\hat A,\hat A,\nu)=\langle Q(\hat A),\nu\rangle=0$ kills the $\cos^2\varphi\sin\varphi$ term. Second derivatives: $(\cos^3)''=6cs^2-3c^3$, $(cs^2)''=2c^3-7cs^2$, $(s^3)''=6sc^2-3s^3$, giving $3E$ exactly. Screen (finite difference at three random $(p,r,q,\varphi)$): residuals below $1.2\cdot10^{-7}$ at step $10^{-4}$, a screen only. CONFIRMED. The circle through $W$ is the great circle through $\hat A,\nu$ because $W=a\hat A+b\nu$ with $\hat A\perp\nu$ unit, and its tangent at $W$ is $u=-b\hat A+a\nu$, unit and $\perp W$.

## 4. Component equations, identity, bound

- $Q(W)=a^2Q(\hat A)+2ab\,\hat A\circ\nu+b^2Q(\nu)$. Pairing with $\hat A$: $a^2p+2ab\,T(\hat A,\hat A,\nu)+b^2r=a^2p+b^2r=\theta a$. Pairing with $\nu$: $0+2abr+b^2q=\theta b$. CONFIRMED.
- Identity, derived independently through L214 step 3: $\langle L_WX,X\rangle-\tfrac\theta2\lVert X\rVert^2=\tfrac\theta2T(1-T)-a_{214}$ with $T=a^2$, $a_{214}=\langle D\circ N,N\rangle=ab^2r$, $\lVert X\rVert^2=a^2b^2$, so $f''/6=\tfrac\theta2-r/a$. The first component equation gives $r/a=(\theta-ap)/b^2$, hence $f''=3(2ap-\theta(1+a^2))/b^2$, matching $3E$ with $b^2E=2ap-\theta(1+a^2)$. The unit norm $a^2+b^2=1$ is used (in $\theta b^2-2\theta=-\theta(1+a^2)$). The Lean `linear_combination` certificate also checks it.
- Bound: $2ap\le2a\theta$ needs $a\ge0$, then $2a\theta-\theta(1+a^2)=-\theta(1-a)^2$, strictly negative for $a<1$, $\theta>0$. CONFIRMED.
- In L214's variables the bound is $P(D)=T^{3/2}p\le T^{3/2}\theta\le\tfrac\theta2T(1+T)$, the gap being $\tfrac\theta2T(1-\sqrt T)^2$: AM–GM on $2\sqrt T\le1+T$.

## 5. L57 and the edge cases

- $\theta\ge\Theta_n>0$ and L57 give $p\le\Theta_n\le\theta$. CONFIRMED.
- $a=1$ is excluded by non-diagonality ($b>0$ in every frame). $a=0$: $\hat A$ is undefined, and a non-diagonal $W$ can have frames with $\pi_DW=0$ (all pair-diagonal entries zero), so "in every frame" must read "in every frame with $a>0$", which the statement's own first sentence says. The second sentence drops the qualifier. Correction: write "in every frame where $W$ has a diagonal part".
- **The title and statement say "above $\theta_0$"**, while the hypothesis is $\theta\ge\Theta_n$, which equals $\theta_0(n)$ only at even $n$. At odd $n$ the statement is proved for $\theta\ge\Theta_n$ alone. Correction: "above $\Theta_n$" in the heading.
- At a global maximiser $p\le\theta$ holds by maximality, as the first bullet says, and there $E\le0$ is already L214's inequality. So the batch has content only at non-maximal critical points with $\theta\ge\Theta_n$ (strictness is the one extra at a maximiser).

## 6. The bullets

- **"The ascent direction must leave $\operatorname{span}\{W,\pi_DW\}$"**: the unit tangents at $W$ in that 2-plane are $\pm u$, and the second variation is even, so no ascent direction lies in the plane. CONFIRMED, read as "is not contained in"; an ascent direction may still carry a $u$-component.
- **The block form**: expanding with $T(\hat A,x,y)=0$ and $T(\nu,x,x)=T(x,x,\nu)=0$ gives exactly the displayed form, factors and signs correct. **It is the form on $W^\perp\ominus u$, not on $W^\perp$.** The $u$-row: using $\langle Q(W),x\rangle=0$ for $x\in D\ominus\hat A$ (so $a^2\langle Q(\hat A),x\rangle=-b^2\langle Q(\nu),x\rangle$, and along $y$, $b\langle Q(\nu),y\rangle=-2a\langle\hat A\circ\nu,y\rangle$),
$$T(W,u,x)=\tfrac ba\langle Q(\nu),x\rangle,\qquad T(W,u,y)=(a^2-b^2)\langle\hat A\circ\nu,y\rangle+ab\langle Q(\nu),y\rangle=-\langle\hat A\circ\nu,y\rangle,$$
both nonzero in general. So with $u$ strictly negative the full form can still have a positive eigenvalue through these couplings. The two candidate families remain valid sufficient tests (each is a sub-block of the form on $W^\perp$), but "what it leaves" is the form on all of $W^\perp$, and a complete test must carry the $u$-row. Correction: add the $u$-row to the display or say the form is on $W^\perp\ominus u$.
- **Diagonal block alone**: $x\in D$, $x\perp\hat A$ gives $x\perp W$, and the form there is $a\langle\hat A\circ x,x\rangle-\tfrac\theta2\lvert x\rvert^2$. The "iff" is right for that block. Notation: here $L_{\hat A}=\hat A\circ\cdot$ unscaled, while the opening defines $L_e=\theta^{-1}W\circ\cdot$. R54's row uses the unscaled one too, so say so.
- **$X\cdot\hat A\in D^\perp$**: the $(cd,cd)$ entry of $X\cdot(\varphi_{ab}\varphi_{ab}^{\mathsf T})$ is $2\langle\varphi_{cd},[X,\varphi_{ab}]\rangle\langle\varphi_{cd},\varphi_{ab}\rangle$, which vanishes for $cd\ne ab$ and is $2\langle\varphi_{ab},\mathrm{ad}_X\varphi_{ab}\rangle=0$ by skewness at $cd=ab$. CONFIRMED.
- **First-order condition**: $\tfrac{d}{ds}\lVert\pi_D(e^{-sX}\cdot W)\rVert^2|_0=-2\langle a\hat A,X\cdot W\rangle=-2ab\langle\hat A,X\cdot\nu\rangle=2ab\langle X\cdot\hat A,\nu\rangle$, using $\langle\hat A,X\cdot\hat A\rangle=0$. So at a maximal frame with $a,b>0$, $\langle X\cdot\hat A,\nu\rangle=0$, and $\langle X\cdot\hat A,W\rangle=0$ follows. CONFIRMED.

## 7. Lean

- `circle_second` and `circle_descent` state exactly the table's two rows, over reals, with $E$ as defined in the note. `circle_descent` takes $0\le a<1$, which with $a^2+b^2=1$ forces $b\ne0$.
- Non-vacuity: the `example` checks the hypotheses at $(a,b,p,\theta)=(3/5,4/5,1,2)$, $r=21/16$, $q=17/32$ (verified by hand). It is arithmetic non-vacuity, with no Weyl tensor realising it.
- The table's "none: prose" row is partly typed on the record already: the circle restriction is `circle_cubic` in [CircleEndpoint.lean](../lean/HamiltonsCubic/Results/CircleEndpoint.lean), and the closure's scalar $T(D,D,N)=0$ with the two component relations at $P$'s own operators in every frame is `L214_frame` in [L214Frame.lean](../lean/HamiltonsCubic/Results/L214Frame.lean). The note should cite them.
- Build and `#print axioms`: `lake env lean` on the file exits 0 with no errors or warnings, and both declarations depend on `propext`, `Classical.choice`, `Quot.sound` only. No `sorry`.

## 8. Against the record

- **The circle** is R54's, phase 3a of the [2026-09-28 sweep](2026-09-28-LIT-step8-sweep.md): same $g(\varphi)=p\cos^3\varphi+3r\cos\varphi\sin^2\varphi+q\sin^3\varphi$, same $p,r,q$, same vanishing term, and the component equations are L214's relations there written $\rho=tp+\tfrac{b^2}tr$, $q=(\rho-2tr)/b$ (with $t$ the note's $a$).
- **The tangent** $u=-b\hat A+a\nu$ is L214's test vector $X=TN-(1-T)D=ab\,u$ and, up to sign, L284's $z$. L214 step 3 computes $\langle L_WX,X\rangle$ exactly, so $3E$ is L214 step 3 renormalised.
- **The bound**: L214's inequality form $P(D)\le\tfrac\theta2T(1+T)$ is exactly $E\le0$. The sweep's line 72 records "$P(\hat A)\le\rho$, which is $a\ge\rho t^2(1-t)$" at a global maximiser, and the difference between that and L214's cap is $\tfrac\rho2t^2(1-t)^2$, which is batch 1's margin $\theta(1-a)^2$ up to the normalisation $a^2b^2$.
- So batch 1 **duplicates** L214 step 3 and the sweep's line 72 in circle coordinates and **sharpens** them only by stating the strict bound at every critical point with $\theta\ge\Theta_n$ (L214's inequality is under the cap, the sweep's line at a maximiser). The note cites neither L214 nor R54's phase 3a for these; it should, and the heading's "(derived, in Lean, unreviewed)" should read as a restatement of L214 at critical points.
- Not searched further: reviews 28g and 28h mention no second derivative of this circle (grep over "great circle", "second derivative").
