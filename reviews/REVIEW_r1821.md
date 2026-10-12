# REVIEW r1821: (MG) as the endpoint criterion on the great circle through the diagonal part (I121, R54)

Brief: [BRIEF_I121_circle.md](BRIEF_I121_circle.md). Log: [agent_logs/r1821-i121-circle.log](../agent_logs/r1821-i121-circle.log). Script: [r1821_circle_tie_check.py](../scripts/reviewers/r1821_circle_tie_check.py) (seconds, a value check only).

**Verdict: no claim is refuted. The circle, the relations, the equivalence and the tie all hold. Two observations bear on how the route is graded: the equivalence uses no property of the frame, and at $b>0$ the criterion can hold only with equality, so after substituting L214 it is (MG) in new coordinates rather than a reduction of it.**

| # | claim | verdict |
|---|---|---|
| 1 | the circle cubic, no $\cos^2\varphi\sin\varphi$ term, coefficients $p,r,q$ | CONFIRMED |
| 2 | L214 in circle coordinates: $\rho=tp+\tfrac{b^2}tr$, $q=(\rho-2tr)/b$ | CONFIRMED |
| 3 | the equivalence (MG) $\iff p=\rho\iff$ arc peaks at diagonal end $\iff$ endpoint criterion | CONFIRMED, with observations O1 to O4 |
| 4 | necessity of $p\ge2r$, and $r=\tfrac{pt}{1+t}$ under (MG) | CONFIRMED |
| 5 | closedness unused, closed branch is the case $\nu=f$ | CONFIRMED, with observation O5 |
| 6 | what it names, and hypotheses | PLAUSIBLE, with observations O2, O6 |

## 1. The circle cubic

Write $T(x,y,z)=\langle Q(x,y),z\rangle$, totally symmetric with $T(x,x,x)=P(x)$. Trilinear expansion of $P(c\hat A+s\nu)$ gives $c^3P(\hat A)+3c^2s\,T(\hat A,\hat A,\nu)+3cs^2\,T(\hat A,\nu,\nu)+s^3P(\nu)$. The middle-left term is $\langle Q(\hat A),\nu\rangle$, which vanishes because $Q(\hat A)\in\mathcal D_n$ (L120) and $\nu\in\mathcal D_n^\perp$. The next coefficient is $T(\hat A,\nu,\nu)=\langle L_{\hat A}\nu,\nu\rangle=r$, multiplied by $3\cos\varphi\sin^2\varphi$ as stated. $\hat A\perp\nu$ are unit, so $u(\varphi)$ is unit, and $W=t\hat A+b\nu$ with $b=\sqrt{1-t^2}$ places $W$ at $\cos\varphi_0=t$. [CircleEndpoint.lean](../lean/HamiltonsCubic/Results/CircleEndpoint.lean)'s circle_cubic types exactly the abstract step, as its table row says. I compiled the file (copy supplied by the coordinator, the move into lean/ pending) with lake env lean from lean/: all three declarations build, no sorry, and #print axioms shows propext, Classical.choice and Quot.sound only.

## 2. L214 in these coordinates

With $D=A$, $N=B$, $t_{214}=t^2$: $P(A)=t^3p$, $a=\langle L_AB,B\rangle=tb^2r$, $P(B)=b^3q$. The first relation $\rho t^2=t^3p+tb^2r$ divides by $t$ to $\rho=tp+\tfrac{b^2}tr$. The second $\rho b^2=2tb^2r+b^3q$ divides by $b^2$ to $q=(\rho-2tr)/b$. Both need $0<t<1$. A consistency check the source does not make: the first relation is exactly $g'(\varphi_0)=0$ (the derivative at $\varphi_0$ reduces to $3b(t\rho-t^2p-b^2r)$), and given the first, the second is exactly $g(\varphi_0)=\rho$. This matches L214's own remark that the two relations are one plus $P(W)=\rho$, and the script confirms both at an off-tie point.

## 3. The equivalence

- **$g\le\rho$ on the whole circle.** Every $u(\varphi)$ is unit and $\rho=\Theta_n$ at a global maximiser, so $g\le\Theta_n=\rho$. $g(\varphi_0)=P(W)=\rho$. CONFIRMED.
- **$\varphi_0\in(0,\tfrac\pi2)$** iff $0<t<1$. $t>0$ holds in a maximal frame because a nonzero Weyl tensor has some nonzero sectional curvature, so some frame has $A\ne0$. $t=1$ is the case $W=A$, where (MG) holds trivially and $\nu$ is undefined. The source leaves both unsaid (O6).
- **(MG) $\iff p=\rho$** above $\sqrt{3/2}$ given $p\le\rho$: mg_iff_value, correct.
- **$p=\rho\iff$ the arc peaks at $0$.** The arc contains $\varphi_0$, so $\max_{[0,\pi/2]}g=\rho$ exactly, and the arc peaks at $0$ iff $g(0)=p=\rho$. The arc is the right domain: the circle's maximum is $\rho$ and is attained inside the arc, and $g(\varphi+\pi)=-g(\varphi)$ makes the other half irrelevant. CONFIRMED.
- **O1, the criterion's hypotheses.** The source restricts to $p>0$, $r>0$, $q\ge0$ without saying which are available. They sort as follows.
  - $r>0$ is available: L214's inequality $a\ge\tfrac\rho2t_{214}(1-t_{214})$ reads $tb^2r\ge\tfrac\rho2t^2b^2$, so $r\ge\tfrac{\rho t}2>0$. It uses L24 at a global maximiser, $\rho>0$, and L214_frame_global's $n\ge4$.
  - $p\le0$: (MG) fails since $\rho>\sqrt{3/2}>0$, and $p\ge2r>0$ fails, so both sides are false.
  - $q<0$: (MG) forces $q=\tfrac{p(1-t)(1+2t)}{(1+t)b}>0$, so (MG) fails. And $p\ge2r$ fails too, since with $q\le0$ and $p\ge2r$ one has $g\le pc^3+3rcs^2\le p$ on the arc, which would force $p=\rho$ and so $q>0$.
  - So at a global maximiser the equivalence holds with no sign hypothesis on $p$ or $q$. The source's hedge is harmless but should be replaced by this case split. For $q<0$ the stated inequality is also the wrong criterion in general (there it would be $p\ge2r$ alone), which is one more reason to discharge the case rather than restrict it.
- **O2, the criterion is tight or false.** At $0<t<1$ the strict inequality $pq^2<(p+r)^2(p-2r)$ with $p>2r$ would put $g<p$ on $(0,\tfrac\pi2]$, contradicting $g(\varphi_0)=\rho\ge p$. So at a global maximiser with $b>0$ the criterion holds iff it holds with equality, and tie_of_mg is that equality. The script confirms at $t\in\{0.05,0.3,0.6,0.9\}$ that at the tie the arc's maximum is $p$, attained at $0$ and at $\arccos t$.
- **O3, the frame is unused.** Nothing in 1 to 3 uses the maximality of the frame. L214 holds in every frame and L24 at every global maximiser. So "(MG)'s value $\iff$ criterion" holds in every orthonormal frame. Frame maximality enters only through which $\nu$ occurs, which is where claim 6 puts it.
- **O4, the sequence of iffs** needs $p\le\rho$, which holds because $\hat A$ is unit. The source says so, and mg_iff_value takes it as hypothesis.

## 4. Necessity of $p\ge2r$ and the tie

Near $0$, $g(\varphi)=p+(3r-\tfrac32p)\varphi^2+q\varphi^3+O(\varphi^4)$. So $p<2r$ puts $g>p$ just right of $0$ for every $q$, and $p\ge2r$ is necessary, second order as stated. At $p=2r$, $g=p-\tfrac38p\varphi^4+q\varphi^3+\dots$, so $q=0$ is forced, which agrees with the criterion. Under (MG), $\rho=p$ in the first relation gives $pt(1-t)=b^2r=(1-t)(1+t)r$, so $r=\tfrac{pt}{1+t}$. Then $p\ge2r$ is $1+t\ge2t$, automatic. tie_of_mg types this and the equality. CONFIRMED.

## 5. The closed branch as a special case

In the closed branch ([2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md), from L284 at $C=0$), $e=A/t=\hat A$ with $Q(e)=de$, $d=P(e)=p$. $f=B/b=\nu$ is one eigenvector of $L_e$ with eigenvalue $\tau$, so $r=\langle L_ef,f\rangle=\tau$, and $q=P(f)$. Then $P(ce+sf)=dc^3+3\tau cs^2+qs^3$ is this $g$ with $(p,r,q)=(d,\tau,q)$. "Closedness makes the circle $P$-invariant" is loose, since closure under $Q$ makes the plane a subalgebra and $g$ is defined in any case. The substance is right: the criterion reads only $g$. CONFIRMED.

**O5.** I122's reduction "to a bound on $q=P(f)$ alone" rests on more than $\nu=f$. On the balanced product the structure fixes $\tau=c_*=\tfrac d{m-1}$ independently of $\rho$, so the criterion becomes a bound on $q$ alone. Off that case $r$ is a free coupling tied to $\rho$ by the first relation, so the nonclosed branch asks for the same inequality with one more unknown, and it is not a bound on $q$ alone. Combined with the tie, (MG) at $b>0$ in the balanced closed branch forces $\tfrac t{1+t}=\tfrac1{m-1}$, that is $t=\tfrac1{m-2}$, which a successor can use as a quick consistency check.

## 6. What it names, and hypotheses

- **O2 read through the relations.** Given $(\rho,p,t)$, L214 determines $r=\tfrac{t(\rho-tp)}{b^2}$ and $q=\tfrac{\rho-2tr}b$. So the criterion, with the relations substituted, is a condition on $(\rho,p,t)$, and by 3 that condition is exactly $p=\rho$. A "bound on $q$ jointly with $p$ and $r$" therefore has content only if it comes from somewhere other than the relations and $P\le\Theta_n$: the frame constraints on $\nu$, as the claim says. The claim is right in that reading. The route's "attackable 2" presumes such a bound is easier than (MG) itself, and nothing in R54 shows that. I grade the naming claim PLAUSIBLE rather than CONFIRMED for that reason. A strict bound on $q$ would prove more than (MG): by O2 it would prove $b=0$, as the audit note already found for the balanced closed branch.
- "$q\le\Theta_n$ is circular": it is true but useless, since the criterion then compares $\rho$ with $p$, which is (MG). F67's ban on bounding $r$ and $p$ separately applies as stated.
- **O6, hypotheses used.**

| hypothesis | where used | stated? |
|---|---|---|
| global maximiser ($\rho=\Theta_n$) | $g\le\rho$, $p\le\rho$, and $r>0$ through L24 | yes |
| $n\ge4$ | L214_frame_global for $r>0$ | no, harmless since $\mathcal W_n=0$ below |
| $\rho>0$ | $r\ge\rho t/2>0$ | implied by $\rho>\sqrt{3/2}$ |
| $\rho>\sqrt{3/2}$ | (MG) $\iff p=\rho$ only | yes |
| $0<t<1$ | $\nu$ defined, $\varphi_0$ interior, dividing the relations | in Lean only (tie_of_mg), not in the source |
| globally maximal frame | nowhere in the equivalence (O3), only in (MG)'s definition and in claim 6 | yes, as (MG)'s frame |
| $p>0$, $q\ge0$ | the author's criterion | stated as restriction, dischargeable (O1) |

## Corrections requested

1. Replace the restriction "for $p>0$, $r>0$, $q\ge0$" by: $r\ge\rho t/2>0$ from L214's inequality, and $p\le0$ or $q<0$ make both sides false (O1).
2. State $0<t<1$, with $t=1$ trivial and $t>0$ automatic.
3. Add that at $b>0$ the criterion holds only with equality (O2), and that the equivalence is frame-free (O3).
4. Soften "the closed branch's reduction to a bound on $q$ is the special case $\nu=f$": it is the case $\nu=f$ with $\tau$ fixed by structure, which the nonclosed branch lacks (O5).
