# Review r1822, (MG) as the endpoint criterion on the great circle through the diagonal part (I121, R54)

Brief: [BRIEF_I121_circle.md](BRIEF_I121_circle.md). Source: [2026-09-28-LIT-step8-sweep.md](2026-09-28-LIT-step8-sweep.md), section "Phase 3a for the sharpened node". Log: [agent_logs/r1822-i121-circle.log](../agent_logs/r1822-i121-circle.log). No script left behind. The Lean file was compiled from the coordinator's scratchpad copy (its move into lean/HamiltonsCubic/Results/ is pending).

**Verdict: every mathematical claim stands. One correction of emphasis to "What it names": under L214's relations $r$ and $q$ are functions of $(p,t,\rho)$, and the criterion is equivalent to $p\ge\rho$ by an identity, so the "joint bound" is one scalar inequality equal in content to (MG).**

| # | claim | verdict |
|---|---|---|
| 1 | the circle cubic and its coefficients | CONFIRMED |
| 2 | L214 in the circle's coordinates | CONFIRMED |
| 3 | the equivalence at a global maximiser, and the criterion's hypotheses | CONFIRMED, with the hypotheses $p>0$, $q\ge0$ discharged below rather than assumed |
| 4 | necessity of $p\ge2r$, and $r=pt/(1+t)$ under (MG) | CONFIRMED |
| 5 | the closed branch as the special case $\nu=f$ | CONFIRMED |
| 6 | hypotheses used | CONFIRMED, three unstated inputs named below, all available |
| 7 | what it names | PLAUSIBLE, with the correction in section 7 |
| L | Lean table | CONFIRMED: compiles, standard three axioms |

## 1. The circle cubic

- Write $T(X,Y,Z)=\langle Q(X,Y),Z\rangle$ with $Q(X,X)=Q(X)$, totally symmetric. Then $P(cX+sY)=c^3T(X,X,X)+3c^2sT(X,X,Y)+3cs^2T(X,Y,Y)+s^3T(Y,Y,Y)$.
- The normalisation is the one L214 uses: expanding $\rho\lVert D\rVert^2=\langle Q(W),D\rangle=P(D)+2T(D,D,N)+T(D,N,N)$ and using $T(D,D,N)=\langle Q(D),N\rangle=0$ gives L214's first relation with coefficient $1$ on $a=\langle L_DN,N\rangle$. The second relation follows the same way with coefficient $2$. So $r=\langle L_{\hat A}\nu,\nu\rangle$ is the coefficient of $3\cos\varphi\sin^2\varphi$.
- The $\cos^2\varphi\sin\varphi$ coefficient is $3\langle Q(\hat A),\nu\rangle$, zero because $Q(\hat A)\in\mathcal D_n$ (L120) and $\nu\in\mathcal D_n^\perp$. Nothing else is needed.
- $u(\varphi)$ is a unit vector since $\hat A\perp\nu$ are both unit.

## 2. L214 in these coordinates

- $P(A)=t^3p$, $a=\langle L_AB,B\rangle=tb^2r$, $P(B)=b^3q$, $t_{214}=t^2$, $1-t_{214}=b^2$.
- First relation: $\rho t^2=t^3p+tb^2r$, so $\rho=tp+\tfrac{b^2}tr$. Second: $\rho b^2=2tb^2r+b^3q$, so $q=(\rho-2tr)/b$. Both need $t>0$, $b>0$.
- **Identity worth recording**: $g(\varphi_0)=t^3p+3tb^2r+b^3q=t^3p+tb^2r+b^2\rho=t^2\rho+b^2\rho=\rho$. So $g(\varphi_0)=\rho$ follows from the relations alone, at any critical point, in any frame.

## 3. The equivalence at a global maximiser

- $g\le\rho$ on the whole circle: $u(\varphi)$ is unit and $\rho=\Theta_n$ at a global maximiser. CONFIRMED.
- $\varphi_0\in(0,\tfrac\pi2)$: $\cos\varphi_0=t\in(0,1)$ and $\sin\varphi_0=b>0$. CONFIRMED.
- $p=g(0)\le\rho$: $\hat A$ is unit, so $P(\hat A)\le\Theta_n=\rho$. (MG) reads $\rho\le\max\{\sqrt{3/2},p\}$ since $P(A)/\lVert A\rVert^3=p$, so above $\sqrt{3/2}$ it is $p\ge\rho$, i.e. $p=\rho$. CONFIRMED, and this is `mg_iff_value`.
- **The arc is the right domain.** The arc maximum is at least $g(\varphi_0)=\rho$ (an interior point) and at most $\rho$, so it equals $\rho$. "The arc peaks at its diagonal end" means $g(0)$ attains the arc maximum, which is $p=\rho$. The circle's maximum outside the arc is irrelevant, since the value $\rho$ is already attained inside. When $p=\rho$ the peak is attained at both $0$ and $\varphi_0$, which the author's formulation "$\max=d$" allows.
- **The criterion's hypotheses.** Only $r>0$ is available a priori, and the other two are harmless:
  - $r>0$: L214's second-order clause with L24 at a global maximiser gives $a\ge\tfrac\rho2t^2b^2$, so $r\ge\tfrac{\rho t}2>0$. The source does not cite this, and it is where the global maximiser (through L24) enters a second time.
  - $p>0$ is not known a priori. If $p\le0$ then (MG) fails above $\sqrt{3/2}$, and $p\ge2r$ fails since $r>0$. So the iff survives.
  - $q\ge0$ is not known a priori. If $q<0$ and $p\ge2r$, then on the arc $g(\varphi)<p\cos^3\varphi+3r\cos\varphi\sin^2\varphi\le p$ for $\varphi\in(0,\tfrac\pi2]$ (the last step is $(c-1)\big[(p-3r)(c^2+c+1)+3r\big]\le0$ on $[0,1]$, whose bracket is at least $\min\{p,3p-6r\}\ge0$), which contradicts $g(\varphi_0)=\rho\ge p$. So $q<0$ forces $p<2r$, (MG) fails, and the right side of the iff fails too. Under (MG), $q=\rho\,\tfrac{(1-t)(1+2t)}{(1+t)b}>0$.
- So the stated iff holds at every global maximiser with $0<t<1$ and $\rho>\sqrt{3/2}$, with no hypothesis on the signs of $p$ or $q$. The source's "for $p>0$, $r>0$, $q\ge0$" is correct as written but narrower than needed, and it should cite L214 with L24 for $r>0$.

## 4. Necessity of $p\ge2r$, and the tie

- At $\varphi=0$: $g'(0)=0$ (the vanishing $\cos^2\varphi\sin\varphi$ term, so L120 is used here too) and $g''(0)=-3p+6r$. If $p<2r$ then $g>p$ near $0^+$, so the arc does not peak at $0$. At $p=2r$ the next term is $q\varphi^3$, consistent with the criterion forcing $q=0$ there. CONFIRMED.
- Under (MG), $p=\rho$ in $\rho=tp+\tfrac{b^2}tr$ gives $r=\tfrac{tp(1-t)}{b^2}=\tfrac{pt}{1+t}$, and then $p-2r=p\tfrac{1-t}{1+t}>0$. Substituting $q=p\tfrac{(1-t)(1+2t)}{(1+t)b}$: both $pq^2$ and $(p+r)^2(p-2r)$ equal $p^3\tfrac{(1-t)(1+2t)^2}{(1+t)^3}$. CONFIRMED, equality, as `tie_of_mg` states.
- Consistency: $r=\tfrac{pt}{1+t}\ge\tfrac{\rho t}2$ since $t\le1$, so the tie respects L214's lower bound.

## 5. The closed branch

- By the MG audit's reading of L284 ([2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md), "What $C=0$ is"), the closed branch has $e=A/t=\hat A$ with $Q(e)=de$, $f=B/b=\nu$ an eigenvector of $L_e$ with eigenvalue $\tau$, and $Q(f)=\tau e+qf$ with $q=P(f)$.
- On the circle through $e$ and $f$: $p=P(e)=d$, $r=\langle L_ef,f\rangle=\tau$, $q=P(f)$, and the cross term is $\langle Q(e),f\rangle=d\langle e,f\rangle=0$. So it is this circle with $(p,r,q)=(d,\tau,q)$. CONFIRMED.
- "Closedness only makes the circle $P$-invariant, and the criterion needs only $g$": correct. $g$ depends only on $(p,r,q)$, and the vanishing cross term comes from L120, which holds in both branches.

## 6. Hypotheses

Where each is used:

- global maximiser: $g\le\rho$, $p\le\rho$, and (unstated in the source) $r>0$ through L24.
- $\rho=\Theta_n$: $p\le\rho$.
- $\rho>\sqrt{3/2}$: (MG) $\iff p=\rho$.
- $0<t<1$: defining $\hat A$ and $\nu$, and $\varphi_0$ interior.
- $\rho>0$: $r>0$.
- globally maximal frame: only in the definition of (MG). Claims 1 to 4 hold in any frame.

Unstated inputs, all available:

- **$t>0$ in the maximal frame.** If $\lVert\pi_{\mathcal D}(kW)\rVert=0$ for every $k\in O(n)$, then $W$ is orthogonal to the span of the $O(n)$-orbit of $\mathcal D_n$, a nonzero invariant subspace of the irreducible $\mathcal W_n$, which is all of $\mathcal W_n$. So $W=0$, and the maximum is positive.
- **$b>0$.** If $b=0$ then $W=\hat A$ and $p=\rho$, so (MG) holds trivially. The source should say the case is excluded as trivial.
- **$r>0$ from L214 with L24**, as in section 3.

## 7. What it names

**The claim stands, and the correction is to its emphasis.** Under L214's relations, $r=\tfrac{t(\rho-tp)}{b^2}$ and $q=\tfrac{\rho-2tr}b$ are determined by $(p,t,\rho)$. The identity $g(\varphi_0)=\rho$ then makes the criterion equivalent to $p\ge\rho$ for any numbers satisfying the relations, with or without a global maximiser. If $p<\rho$ the arc maximum exceeds $p$, and the author's iff makes the inequality fail.

- So "a joint bound on $(r,q)$ against $p$" has one degree of freedom at given $(t,\rho)$, and it is (MG) restated. Any proof of $pq^2\le(p+r)^2(p-2r)$ has to bring in information that L214's relations lack. The source's "for $\nu$ allowed by the maximal frame" names that information, and the finite-angle inequality is the available carrier. The reformulation moves the problem to a new place, and the difficulty is unchanged.
- "The crude $q\le\Theta_n$ is circular": correct, and also too weak. At $p=\rho$, $q=\rho$ gives $pq^2=\rho^3>(\rho+r)^2(\rho-2r)=\rho^3-3\rho r^2-2r^3$ for $r>0$.
- "F67 forbids bounding $r$ and $p$ separately": consistent with [F67](../findings/fence-posts.md) as recorded.

## Lean

- `circle_cubic`, `mg_iff_value` and `tie_of_mg` compile from the scratchpad copy with `lake env lean`. `#print axioms` gives `propext`, `Classical.choice`, `Quot.sound` for each.
- The statements match the Lean table. `circle_cubic` is abstract (it takes $T(a,a,b)=0$ as a hypothesis), and the table says so. `tie_of_mg` takes $\rho=p$ substituted into L214's relations, which is the right encoding of (MG) after `mg_iff_value`.
- The identity $g(\varphi_0)=\rho$ and the discharge of $q\ge0$ are untyped. They are short `ring` or `nlinarith` facts and would make the Lean table cover the whole of claim 3's scalar part.
