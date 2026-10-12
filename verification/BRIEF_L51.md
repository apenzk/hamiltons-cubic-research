# Brief for round L51

**Verbatim extracts. Nothing here is paraphrased. Two of these disagree; both are given unlabelled.**

## A. The canonical statement, from results.md lines 743-750

```markdown
##### Lemma L51, the variation calculus is an identity along a critical orbit

Let $T$ be a fully symmetric trilinear form on a Euclidean space, $P(x)=T(x,x,x)$, and $x\circ y$ defined by $\langle x\circ y,z\rangle=T(x,y,z)$. Let a compact group $G$ act orthogonally leaving $P$ invariant, let $W$ be a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, $\theta>0$, and put $L_Wx=W\circ x$, $B=\tfrac\theta2-L_W$ and $A(\tfrac12)=\ker B\cap W^\perp$. Then for $X$ in the Lie algebra of $G$, with $z=X\!\cdot\!W$ and $u=X^2\!\cdot\!W$:

$$L_Wz=\tfrac\theta2z,\qquad B\,u=z\circ z .$$

Consequently the orbit tangent lies in $A(\tfrac12)$; $T(z,z,z)=0$ there; the fusion rule $\langle z\circ z,y\rangle=0$ holds for every $y\in A(\tfrac12)$; and where $B\vert_{W^\perp}\succeq0$ the fourth-order supremum over correctors equals $0$ exactly. **None of this uses maximality.**

```

## B. The landscape statement, from results.md line 246

```markdown
- **Lemma L51 (second-order). The variation calculus is an identity along a critical orbit.** At any critical point, differentiating equivariance twice gives $B(X^2\!\cdot\!W)=(X\!\cdot\!W)\circ(X\!\cdot\!W)$. This forces the third-order condition, the fusion rule and the fourth-order inequality to hold with equality on the orbit tangent, with no maximality hypothesis. Any variational route must consume transverse directions.
```

## C. The block in findings/second-order.md, lines 185-202

```markdown
#### Lemma L51, the variation calculus is an identity along a critical orbit, the canonical statement

*Moved here from [results.md](../results.md) on 2026-08-31. The orbit identity and its consequences are derived earlier in this file; what follows is the full statement with its motivation, scope and sources, which existed only in that file.*

**Why it was needed.** The extremal-idempotent calculus of Krasnov–Tkachev applies verbatim here: critical points of $P$ on the unit sphere are idempotents of the metrised algebra whose cubic form is $P$, and a maximizer is an *extremal* idempotent. Its second-order consequence is Lemma L24. What is attractive is the third-order consequence, a fusion rule constraining *products of eigenvectors* rather than spectra, which is the kind of information every spectral route here has lacked. The question is what it actually constrains.

**Statement.** Let $T$ be a fully symmetric trilinear form on a Euclidean space, $P(x)=T(x,x,x)$, and $x\circ y$ defined by $\langle x\circ y,z\rangle=T(x,y,z)$. Let a compact group $G$ act orthogonally leaving $P$ invariant, let $W$ be a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, $\theta>0$, and put $L_Wx=W\circ x$, $B=\tfrac\theta2-L_W$ and $A(\tfrac12)=\ker B\cap W^\perp$. Then for $X$ in the Lie algebra of $G$, with $z=X\!\cdot\!W$ and $u=X^2\!\cdot\!W$:

$$L_Wz=\tfrac\theta2z,\qquad B\,u=z\circ z .$$

Consequently the orbit tangent lies in $A(\tfrac12)$; $T(z,z,z)=0$ there; the fusion rule $\langle z\circ z,y\rangle=0$ holds for every $y\in A(\tfrac12)$; and the fourth-order value at the stationary corrector is $\langle b,B^+b\rangle=\theta/2$, giving $0$ exactly. **None of this uses maximality**, and the equality needs no positivity either: it follows from $B(\Pi u)=b$, from $b\perp\ker B$ (which is the fusion rule already proved) and from $[t^4]=0$ along the orbit, since $P$ is constant there. **$B\vert_{W^\perp}\succeq0$ licenses only the word *supremum***, and it is strictly weaker than maximality: the cubic $P(x,y)=x^3+\tfrac32xy^2+\alpha y^3$ at $(1,0)$ has $B\vert_{W^\perp}=0$ and is no local maximum at $\alpha\ne0$.

**Argument.** $Q$ is $G$-equivariant, so $Q(e^{tX}\!\cdot\!W)=\theta\,e^{tX}\!\cdot\!W$ identically. Differentiating once at $t=0$ gives $2L_Wz=\theta z$. Differentiating twice gives $2\,z\circ z+2L_Wu=\theta u$, which is $Bu=z\circ z$. Then $\langle z\circ z,y\rangle=\langle Bu,y\rangle=\langle u,By\rangle=0$ for $y\in\ker B$, since $B$ is self-adjoint. For the fourth order, the exact jet along $x(t)=W+tz+\tfrac{t^2}2w$ with $w\perp W$ is

$$[t^3]\,P(x/\lvert x\rvert)=T(z,z,z),\qquad [t^4]\,P(x/\lvert x\rvert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8,$$

a quadratic in $w$, concave on $W^\perp$, whose stationarity condition is $Bw=\Pi(z\circ z)$, **satisfied by $\Pi u$ and not by $u$**, since $\langle u,W\rangle=-\lVert z\rVert^2$ puts the orbit acceleration outside $W^\perp$ and the corrector is $\Pi u=u+\lVert z\rVert^2W$. So the supremum is attained at the orbit's own second-order data, and equals $0$ because $P$ is constant along the orbit. $\square$

```

## D. A third copy, findings/fence-posts.md line 307

```markdown
So the orbit tangent lies in $A(\tfrac12)$ automatically, $T(z,z,z)=0$ there, the fusion rule $\langle z\circ z,y\rangle=\langle u,By\rangle=0$ holds there for every $y\in\ker B$, and $u$ is the **stationary point** of the concave quartic functional, so where $B\succeq0$ the fourth-order supremum equals $0$, i.e. $\langle b,B^+b\rangle=\theta/2$ exactly. **No maximality hypothesis is used anywhere.**
```
