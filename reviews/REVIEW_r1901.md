# REVIEW r1901: I123 coupling, three extensions of P

Log: agent_logs/r1901-i123-extensions.log. Subject: [2026-09-28o-I123-coupling.md](2026-09-28o-I123-coupling.md). Footing: analysis only. Each claim was derived by hand, then screened in seconds on an explicit halved # on so(6) and on the closed form at n=12 (scratch script, not committed). The screens are reported as screens.

| # | claim | verdict |
|---|---|---|
| 1 | The object paragraph | CONFIRMED (one notational slip) |
| 2 | Extension 1 | CONFIRMED |
| 3 | Extension 2 | CONFIRMED |
| 4 | Extension 3 | CONFIRMED, with an unremarked exact identity for the value |
| 5 | The conclusion | PLAUSIBLE: the decomposition is CONFIRMED, and "the three extensions all fail" is overstated for extension 2 |
| 6 | Prior record | the value is on the record as $\Theta_{13}$, the $S^6\times S^7$ Weyl value. The traceless extension itself is new |

## 1. The object

- The note's $Q(X)=X^2+X^\#$ should read $X^2+X^\#X$ (or $X^2+X\#X$), as in the conventions. This is notation only.
- For symmetric $X,Y,Z$, $\operatorname{tr}(XYZ)$ is cyclic and reversal-invariant ($\operatorname{tr}(XYZ)=\operatorname{tr}(ZYX)$), so it is fully $S_3$-symmetric. $\langle X\#Y,Z\rangle$ is fully symmetric for the Böhm–Wilking product. So $T(X,Y,Z)=\operatorname{tr}XYZ+\langle X\#Y,Z\rangle$ is fully symmetric, with $G(X)=T(X,X,X)$ and $T(X,X,Y)=\langle Q(X),Y\rangle$. Extension 2 uses the second of these.
- On the Weyl subspace $G(W)=\operatorname{tr}W^3+\langle W\#W,W\rangle=P(W)$. This matches the record's normalisation exactly.

## 2. Extension 1

- $G(W+cI)=G(W)+3c\langle Q(W),I\rangle+3c^2\langle Q(I),W\rangle+c^3G(I)$.
- $\langle Q(I),W\rangle=(n-1)\operatorname{tr}W=0$, and $G(I)=\operatorname{tr}I+\langle I\#I,I\rangle=N+(n-2)N=(n-1)N$.
- $\langle Q(W),I\rangle=\lVert W\rVert^2+\langle W\#W,I\rangle=\lVert W\rVert^2+\langle W,I\#W\rangle=\lVert W\rVert^2-\lVert W\rVert^2=0$ by L265 and the symmetry of the triple form. That is the stated cancellation.
- Screen: $38032.054$ on both sides at $n=6$.

## 3. Extension 2

- The first Bianchi map $b$ is the orthogonal projection of $\operatorname{Sym}^2\Lambda^2$ onto $\Lambda^4$ (up to a constant), and the algebraic curvature operators are $\ker b$. So $\Lambda^4$ is their orthogonal complement.
- $Q(W)$ is an algebraic curvature operator (Böhm–Wilking), so $\langle Q(W),Y\rangle=T(W,W,Y)=0$.
- $G(W+Y)=P(W)+3T(W,Y,Y)+G(Y)=P(W)+3\langle Q(Y),W\rangle+G(Y)$. This is correct.
- Criticality: $\lVert W+Y\rVert^2=\lVert W\rVert^2+\lVert Y\rVert^2$, so the normalised ratio is also stationary in the $\Lambda^4$ directions.
- Screens at $n=6$: $\langle Y,R\rangle=10^{-14}$ for a random ACO $R$, $\langle Q(W),Y\rangle=10^{-13}$, and the expansion matches to $10^{-11}$ relative.

## 4. Extension 3

- **ACOs.** $P_{\mathfrak{so}(k)}$ is the curvature operator of $S^k\times\mathbb R^{n-k}$, and $I$ is the round sphere. So the span of $P_{\mathfrak{so}(p)}$, $P_{\mathfrak{so}(q)}$ and $I$, which is the whole family, consists of ACOs. CONFIRMED.
- **Formula.** Expand $X\#X$ with the products:
  - $X\#X=(a^2(p-2)+c^2q)P_p+(b^2(q-2)+c^2p)P_q+c(a(p-1)+b(q-1))P_{\mathrm{mix}}$.
  - Pair with $X$ and use $q\,d_p=\tfrac12pq(p-1)$.
  - This gives $a^3d_p(p-2)+b^3d_q(q-2)+\tfrac32pq\,c^2(a(p-1)+b(q-1))$.
  - Add $\operatorname{tr}X^3=a^3d_p+b^3d_q+c^3pq$. The stated formula follows.
  - The products are consistent with $I\#I=(n-2)I$, and the explicit # at $n=6$, $p=2,3$ reproduces all four products and the formula to $10^{-14}$.
- **$a=b=c=1$.** This is $G(I)=(n-1)N$, which is $726$ at $p=q=6$.
- **Ricci-free line.** The sectional values are $a$, $b$ and $c$, so $\operatorname{Ric}=(p-1)a+qc$ on the first factor and $(q-1)b+pc$ on the second. The same holds for the record's $\operatorname{Ric}$, the adjoint of $\cdot\wedge\mathrm{id}$ normalised by $\operatorname{Ric}(I)=n-1$, and it is screened. Its kernel in the 3-dimensional invariant ACOs is the 1-dimensional invariant Weyl line, which contains the Weyl part of $S^p\times S^q$ (with $c<0$). At $p=q=6$ that gives $108900t^3/1980^{3/2}=1.2360331$. CONFIRMED.
- **Maximiser, derived independently.**
  - Put $s=a+b$ and $t=a-b$. The trace condition is $s=-12c/5$ and the norm condition is $79.2c^2+7.5t^2=1$.
  - Eliminating $t^2$ gives $G=554.4c^3-18c$ on $c^2\le1/79.2$.
  - The critical point is $c^2=5/462$, so $c=-\sqrt{2310}/462$ and $G=12\lvert c\rvert=2\sqrt{2310}/77$. Also $t^2=2/105$, so $\tfrac t2=\pm\sqrt{210}/210$ and $\tfrac s2=\sqrt{2310}/385$.
  - The Ricci values are $\mp5\sqrt{210}/210=\mp\sqrt{210}/42=\mp0.34503$.
  - **It is the global maximum on the circle.** The endpoints $c=\mp1/\sqrt{79.2}$ (that is, $t=0$) give $\pm1.2360331$, and with $p=q$ these are exactly the Weyl points. The other critical point gives $-1.2484$. CONFIRMED.
  - Screens: a grid over the circle gives $1.2483756$ at the stated $(a,b,c)$. At $p=5$, $q=7$ the traceless maximum is $1.2443629$ and the Weyl value $1.2282392$, matching the note's $1.24436$ and $1.22824$.
- **Unremarked exact identity, proved symbolically here.** At $p=q=m$ the traceless-plane maximum satisfies $\max^2=\dfrac{4m(m-1)}{(2m-1)(m+1)}$. That is exactly $\Theta(S^m\times S^{m+1})^2$, the Weyl value of the sphere product one dimension up.
  - At $m=6$: $(2\sqrt{2310}/77)^2=9240/5929=120/77=\Theta_{13}^2$.
  - The general $m$ was checked in Sage; the numeric match holds for $m=2..8$.
  - So $1.248376$ is the record's $\Theta_{13}$, [INDEX-values.md](../findings/INDEX-values.md) row "$S^6\times S^7$". The note should say so. Whether a map takes traceless ACOs on $\mathbb R^{2m}$ to Weyl tensors on $\mathbb R^{2m+1}$ was not examined. At the maximiser $a/c=-0.537$ and $b/c=-1.863$, which differs from the $S^6\times S^7$ Weyl ratios $-1.4$ and $-1$, so it is not simply a restriction.

## 5. The conclusion

- **Decomposition.** CONFIRMED. $Q(W)$ is an ACO, so it has no $\Lambda^4$ part, and $\operatorname{tr}Q(W)=0$ (the computation in §2), so it has no scalar part. That leaves Weyl plus traceless Ricci, which are orthogonal. $P(W)=\langle Q(W)_{\mathrm{Weyl}},W\rangle$ holds because $W\perp$ the Ricci part.
- **"An inequality valid on all traceless curvature operators cannot be P".** Correct in its precise reading: the bound $G\le\theta_0(12)\lVert X\rVert^3$ fails on traceless ACOs at $n=12$, so P does not extend there with its constant. The note shows this at $n=12$ only. The identity above shows it for every even $n=2m\ge4$, since $\Theta(S^m\times S^{m+1})>\theta_0(2m)$ there (screened $m=2..8$).
- **Correction: "the three extensions available by lifting all fail" overstates extension 2.**
  - Extensions 1 and 3 do fail: $I$ alone gives $\sqrt{2(n-1)/n}$ (post F14), and the traceless family gives $\Theta_{n+1}$.
  - Extension 2 establishes only first-order stationarity. Whether $G\le\theta_0\lVert\cdot\rVert^3$ holds on $\mathrm{Weyl}\oplus\Lambda^4$ turns on the sign of the second-order term $3\langle Q(Y),W\rangle+\dots$ at the maximiser, which the note does not compute.
  - Suggested wording: "extensions 1 and 3 fail, and extension 2 is undecided at second order."

## 6. Prior record

- $1.248376$ is on the record as $\Theta_{13}$ ([INDEX-values.md](../findings/INDEX-values.md), [route-a.md](../findings/route-a.md), [problem.md](../findings/problem.md)). This is the same number with a different origin, and the identity in §4 explains the coincidence.
- $\sqrt{2310}$ appears only as Weingart's $c_7=2310$ in [curvature-invariants.md](../findings/curvature-invariants.md), which is unrelated.
- "scalar-flat" and "traceless curvature" have no hits in findings/.
- [bounds.md:767](../findings/bounds.md) notes that an identification holds on symmetric traceless operators on $\Lambda^2$. That is a different statement.
- Post F14 ([second-order.md:1200](../findings/second-order.md)) covers the full ACO space (the round sphere, $\sqrt{2(n-1)/n}$). The traceless sharpening is new, as the note says.
- The two-block family with the same products appears in [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md) (evidence for U), but it is used for idempotents and never for $G$.
