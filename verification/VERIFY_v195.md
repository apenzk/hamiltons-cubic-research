# VERIFY_v195, Lemma L51, the variation calculus along a critical orbit

*Verifier v195, cold read of [BRIEF_L51.md](BRIEF_L51.md). The brief was read as given, with the two statements unlabelled and no prior knowledge of which the record prefers. **No numerical work was done**: every check below is closed-form algebra, and the two witnesses are exhibited by hand in exact arithmetic on objects constructed for the purpose. Log at [agent_logs/verify-L51-v195.log](../agent_logs/verify-L51-v195.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $L_Wz=\tfrac\theta2z$ from differentiating equivariance once | **PROVEN** |
| 2 | $Bu=z\circ z$ from differentiating equivariance twice | **PROVEN** |
| 3 | orbit tangent lies in $A(\tfrac12)$; $T(z,z,z)=0$ there | **PROVEN** |
| 4 | fusion rule $\langle z\circ z,y\rangle=\langle u,By\rangle=0$ for $y\in\ker B$ | **PROVEN**, needs identity 2 plus self-adjointness of $B$, nothing further |
| 5 | $[t^3]P(x/\lvert x\rvert)=T(z,z,z)$ | **PROVEN** |
| 6 | $[t^4]P(x/\lvert x\rvert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8$ | **BROKEN as written**, the constant is $-\tfrac{3\theta}8\lVert z\rVert^4$; the stated form is not homogeneous and is right only at $\lVert z\rVert=1$ |
| 7 | stationarity condition is $Bw=\Pi(z\circ z)$, met by $\Pi u$ and not by $u$ | **PROVEN** |
| 8 | the fourth-order value at the stationary corrector is $\langle b,B^+b\rangle=\theta/2$ | **BROKEN as written**, the value is $\tfrac\theta2\lVert z\rVert^4$; refuted in closed form in §6 |
| 9 | that value gives $[t^4]=0$ exactly | **PROVEN** (with the corrected constant of claim 6, the two errors cancel) |
| 10 | the equality needs no positivity; $B\vert_{W^\perp}\succeq0$ licenses only the word *supremum* | **PROVEN**, statement C is right, statement A is true but over-conditioned; witness in §7 |
| 11 | "concave on $W^\perp$", asserted unconditionally in the Argument | **BROKEN**, concavity *is* $B\vert_{W^\perp}\succeq0$, the very hypothesis the Statement disclaims two lines above |
| 12 | "$[t^4]=0$ along the orbit, since $P$ is constant there" as the justification | **GAP**, true, but the chordal curve's ray differs from the orbit's at order $t^3$ and the block does not close that step; derived independently in §5 |
| 13 | counterexample $P=x^3+\tfrac32xy^2+\alpha y^3$ at $(1,0)$: $B\vert_{W^\perp}=0$, no local maximum at $\alpha\ne0$ | **PROVEN** |
| 14 | the guard: bare $B\succeq0$ names the empty set | **PROVEN**; [fence-posts.md](../findings/fence-posts.md) line 307 carries the bare form in a live clause, and that clause is vacuous |
| 15 | fence-posts line 307's "$u$ is the **stationary point**" | **BROKEN**, the stationary point is $\Pi u$; the block in [second-order.md](../findings/second-order.md) says so explicitly and the fence post contradicts it |
| 16 | conventions.md line 36's "$b:=z\circ z$" | **BROKEN**, incompatible with $B(\Pi u)=b$ in the same cell; under it $\langle b,B^+b\rangle=0$, not $\theta/2$ |
| 17 | "None of this uses maximality" | **PROVEN**, checked step by step in §9 |

**Overall verdict: PROVEN, hypotheses corrected.** Every mathematical mechanism of L51 stands: both identities, the fusion rule, both jet coefficients up to one missing factor, the identification of $\Pi u$ as the stationary corrector, the vanishing of the fourth-order value there, and the independence of all of it from positivity and from maximality. Three numbered values and one convention entry are wrong as written, all by the same missing factor $\lVert z\rVert^4$ or by the same confusion of $u$ with $\Pi u$; adding the normalisation $\lVert z\rVert=1$, or writing the two values homogeneously, repairs the statement without touching the argument.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $Q$, $P$, $\theta$, "$Q(W)$ | Hamilton's quadratic map $W^2+W^\#$"; "$P(W)$ | the cubic form $\langle W,Q(W)\rangle$"; "$\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $T$, "**the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint".
- $\circ$, from [second-order.md](../findings/second-order.md) line 11: "$X\circ Y:=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$". Since $Q$ is quadratic this gives $X\circ X=Q(X)$, so $P(x)=T(x,x,x)$ and $\nabla P=3\,x\circ x$ are the same objects the record already uses ("$\nabla P=3Q(W)$", [fence-posts.md](../findings/fence-posts.md), Post F36).
- $B$, "$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point, so $A(\tfrac12)=\ker B$ and $Bu=z\circ z$ along an orbit. **$B\succeq0$ is only ever readable on $W^\perp$**, since $L_WW=\theta W$ gives $BW=-\tfrac\theta2W$ at every $\theta>0$. *This is a third object under the letter $B$ in this record*".
- $\Pi$, "*(i)* the orthogonal projection onto $W^\perp$, at whichever unit $W$ is in play … Sense (i) is meant below. … the orbit acceleration $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$, so $u\notin W^\perp$ and the corrector is $\Pi u=u+\lVert z\rVert^2W$ rather than $u$".
- $b$, $B^+$, "in the orbit calculus $b:=z\circ z$, the **vector** appearing as $B(\Pi u)=b$, and $B^+$ the Moore-Penrose inverse of $B$ on $(\ker B)^\perp$." **These two halves contradict each other**; see §8.

## Hypothesis inventory

What the statement declares, against what the argument consumes.

| hypothesis | declared | consumed | where |
| --- | --- | --- | --- |
| $T$ fully symmetric trilinear | yes | **yes, twice** | self-adjointness of $L_W$ (fusion rule); the multinomial expansion of $P(x)$ in §4 |
| Euclidean space, finite-dimensional | yes ("Euclidean space") | **yes** | $B^+$ as a Moore–Penrose inverse; the spectral splitting $\ker B\oplus\operatorname{ran}B$ |
| $G$ compact | yes | **no, only that $G$ is a Lie group acting orthogonally** | compactness buys a Lie structure and an invariant inner product; both are hypotheses in their own right here and compactness itself is never used |
| action orthogonal | yes | **yes, twice** | $\circ$ is $G$-equivariant (needs $g$ orthogonal, §1); $X$ skew, giving $\langle z,W\rangle=0$ and $\langle u,W\rangle=-\lVert z\rVert^2$ (§3) |
| $P$ $G$-invariant | yes | **yes** | equivariance of $Q$, and "$P$ is constant along the orbit" |
| $W$ a unit critical point, $Q(W)=\theta W$ | yes | **yes, everywhere** | the right-hand side of the differentiated equivariance |
| $\theta>0$ | yes | **no. $\theta\ne0$ suffices, and even that is used only once** | $\theta\ne0$ gives $\ker B\perp W$, hence $A(\tfrac12)=\ker B$ and the fence post's "for every $y\in\ker B$". The *sign* is used nowhere in L51's proof; it is used only to make the guard "$B\succeq0$ is empty" a statement about a definite sign, and by the $e=W/\theta$ of [L24](../findings/second-order.md). **The record already knows this**: [second-order.md](../findings/second-order.md) line 68 invokes L51 "at $\theta<0$, outside L51's own stated $\theta>0$, which its proof of these three clauses does not use" |
| $\lVert z\rVert=1$ | **NO, stated nowhere** | **yes, by claims 6 and 8** | this is the defect of §4 and §6 |
| $B\vert_{W^\perp}\succeq0$ | in statement A only | only for the word *supremum* | §7 |
| maximality | **disclaimed** | **nowhere**; §9 |

## 1. The two identities, and what equivariance and compactness are doing

**Equivariance of $\circ$.** $P$ is $G$-invariant and each $g\in G$ is orthogonal, so polarising $P(gx)=P(x)$ in three slots gives $T(gx,gy,gz)=T(x,y,z)$. Then for every $z$,
$$\langle gx\circ gy,\,gz\rangle=T(gx,gy,gz)=T(x,y,z)=\langle x\circ y,z\rangle=\langle g(x\circ y),\,gz\rangle,$$
the last step because $g$ is orthogonal. As $gz$ runs over the whole space, $gx\circ gy=g(x\circ y)$. Hence $Q(gx)=gx\circ gx=g\,Q(x)$, which is the equivariance the block asserts. **Orthogonality is consumed twice here**, once to move $g$ across the inner product, once to conclude the action is by isometries so that polarisation of the invariance is legitimate.

**What compactness is doing: nothing that is not already assumed.** The argument needs (i) $G$ a Lie group, so that $X$ lives in a Lie algebra and $e^{tX}\in G$ is a smooth curve through the identity; (ii) the action orthogonal; (iii) $P$ invariant. Compactness is a standard sufficient condition for (i) and for arranging (ii) by averaging, but both are stated outright in the hypothesis list, so compactness is a stated-but-unconsumed hypothesis. **It is harmless**, recorded here only because the brief asks and because it is the honest reading of the inventory.

**First derivative.** Set $x(t)=e^{tX}\!\cdot\!W$, so $x(0)=W$, $\dot x(0)=X\!\cdot\!W=z$, $\ddot x(0)=X^2\!\cdot\!W=u$. Equivariance plus criticality gives the identity in $t$
$$Q(x(t))=e^{tX}\!\cdot\!Q(W)=\theta\,e^{tX}\!\cdot\!W .$$
$Q$ is the quadratic $x\mapsto x\circ x$, so $\tfrac{d}{dt}Q(x)=2\,x\circ\dot x$. At $t=0$ the left side is $2\,W\circ z=2L_Wz$ and the right side is $\theta\,X\!\cdot\!W=\theta z$. Hence
$$2L_Wz=\theta z,\qquad\text{i.e.}\qquad L_Wz=\tfrac\theta2z,\qquad Bz=0. \tag{I}$$

**Second derivative.** $\tfrac{d^2}{dt^2}Q(x)=2\,\dot x\circ\dot x+2\,x\circ\ddot x$. At $t=0$: $2\,z\circ z+2L_Wu$, against $\theta\,X^2\!\cdot\!W=\theta u$. So
$$2\,z\circ z=\theta u-2L_Wu=2\big(\tfrac\theta2-L_W\big)u=2Bu,\qquad Bu=z\circ z. \tag{II}$$

Both reproduce the block exactly. **Criticality is what puts $\theta W$ on the right-hand side**; without it the right side is $Q(W)$ and neither identity closes. **Neither uses $\theta>0$, nor $\theta\ne0$, nor any positivity, nor maximality.**

## 2. $z\in A(\tfrac12)$ and $T(z,z,z)=0$

$X$ is skew, since $t\mapsto e^{tX}$ is orthogonal; so $\langle z,W\rangle=\langle XW,W\rangle=0$ and $z\in W^\perp$. With (I) this gives $z\in\ker B\cap W^\perp=A(\tfrac12)$. Then
$$T(z,z,z)=\langle z\circ z,z\rangle=\langle Bu,z\rangle=\langle u,Bz\rangle=0,$$
using (II), self-adjointness of $B$, and $Bz=0$. ✔

*A remark on $A(\tfrac12)$ against $\ker B$.* $L_W$ is self-adjoint and $L_WW=W\circ W=\theta W$, so $W$ is an eigenvector at $\theta$ while $\ker B$ is the eigenspace at $\theta/2$. **When $\theta\ne0$ the two eigenvalues differ and $\ker B\perp W$ automatically, so $A(\tfrac12)=\ker B$**, which is why [results.md](../results.md)'s "for every $y\in A(\tfrac12)$" and [fence-posts.md](../findings/fence-posts.md)'s "for every $y\in\ker B$" say the same thing, and why [conventions.md](../findings/conventions.md) may write "$A(\tfrac12)=\ker B$" flatly. This is the one place $\theta\ne0$ is genuinely spent.

## 3. The fusion rule, what it needs

$$\langle z\circ z,y\rangle=\langle Bu,y\rangle=\langle u,By\rangle=0\qquad\text{for }y\in\ker B .$$
**It needs exactly two things beyond (II): that $B$ is self-adjoint, and nothing else.** Self-adjointness of $B$ reduces to self-adjointness of $L_W$, which is full symmetry of $T$, [conventions.md](../findings/conventions.md) states this in the same breath as $T$ itself ("whose symmetry is what makes $L_e$ self-adjoint"). No positivity, no $\theta$-sign, no maximality, no compactness, no finite dimension. **Answer to the brief's question: no, it needs nothing beyond self-adjointness of $B$, given identity (II).**

Two corollaries the record uses and which follow here. First, the rule holds on all of $\ker B$, not merely on $A(\tfrac12)$, so results.md's phrasing is a true weakening. Second, $b:=\Pi(z\circ z)$ satisfies $b\perp\ker B$: for $y\in\ker B$ one has $\Pi y=y$ (§2, needing $\theta\ne0$) and $\langle b,y\rangle=\langle z\circ z,\Pi y\rangle=\langle z\circ z,y\rangle=0$. This is what makes $B^+b$ meaningful.

## 4. The exact jet, both coefficients rebuilt

Take $x(t)=W+tz+\tfrac{t^2}2w$ with $w\perp W$, and write $a_0=W$, $a_1=z$, $a_2=\tfrac12w$. Put $s=\lVert z\rVert^2$, $c=\langle z,w\rangle$, $d=\lVert w\rVert^2$. Recall $z\perp W$, $w\perp W$, $\lVert W\rVert=1$.

**The denominator.**
$$\lVert x\rVert^2=1+s\,t^2+c\,t^3+\tfrac d4t^4,\qquad
(\lVert x\rVert^2)^{-3/2}=1-\tfrac32s\,t^2-\tfrac32c\,t^3+\big(\tfrac{15}8s^2-\tfrac38d\big)t^4+O(t^5),$$
from $(1+\varepsilon)^{-3/2}=1-\tfrac32\varepsilon+\tfrac{15}8\varepsilon^2-\cdots$ with $\varepsilon^2=s^2t^4+O(t^5)$.

**The numerator**, $P(x)=\sum_{i,j,k}t^{i+j+k}T(a_i,a_j,a_k)$:

| order | terms | value |
| --- | --- | --- |
| $t^0$ | $T(W,W,W)$ | $\theta$ |
| $t^1$ | $3T(W,W,z)=3\theta\langle W,z\rangle$ | $0$ |
| $t^2$ | $3T(W,W,a_2)+3T(W,z,z)$ | $0+3\langle L_Wz,z\rangle=\tfrac{3\theta}2s$ |
| $t^3$ | $T(z,z,z)+6T(W,z,a_2)$ | $T(z,z,z)+3\langle L_Wz,w\rangle=T(z,z,z)+\tfrac{3\theta}2c$ |
| $t^4$ | $3T(W,a_2,a_2)+3T(z,z,a_2)$ | $\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle z\circ z,w\rangle$ |

(The $t^2$ and $t^3$ rows use $L_Wz=\tfrac\theta2z$, i.e. identity (I); the $t^1$ row uses $z\perp W$.)

**Third order.** $[t^3]=p_0q_3+p_2q_1+p_3q_0=\theta(-\tfrac32c)+0+T(z,z,z)+\tfrac{3\theta}2c=T(z,z,z)$. ✔ **Claim 5 confirmed exactly as written.**

**Fourth order.**
$$[t^4]=\theta\big(\tfrac{15}8s^2-\tfrac38d\big)+\tfrac{3\theta}2s\cdot\big(-\tfrac32s\big)+\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle z\circ z,w\rangle
=-\tfrac{3\theta}8s^2-\tfrac{3\theta}8d+\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle z\circ z,w\rangle,$$
since $\tfrac{15}8-\tfrac94=-\tfrac38$. Now $\tfrac34\langle L_Ww,w\rangle-\tfrac{3\theta}8\lVert w\rVert^2=-\tfrac34\langle Bw,w\rangle$, so
$$\boxed{\,[t^4]\,P(x/\lVert x\rVert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8\lVert z\rVert^4\,.}$$

**DISCREPANCY 1, the stated constant is $-\tfrac{3\theta}8$, and it should be $-\tfrac{3\theta}8\lVert z\rVert^4$.**

- *Located.* [second-order.md](../findings/second-order.md) line 199 (the displayed jet inside L51's Argument); the same missing factor propagates to line 195's $\theta/2$.
- *Exhibited.* The stated expression is not homogeneous. Send $X\mapsto\lambda X$, so $z\mapsto\lambda z$ and $w\mapsto\lambda^2w$ (the reparametrisation $t\mapsto\lambda t$ of the same curve). The first term scales by $\lambda^4$, the second by $\lambda^2\cdot\lambda^2=\lambda^4$, and $\lVert z\rVert^4$ by $\lambda^4$, but a bare $-\tfrac{3\theta}8$ by $\lambda^0$. A single formula cannot be right at two values of $\lambda$ unless the term is absent, and it is not: §6's witness has $\lVert z\rVert^2=\tfrac23$ and the two readings differ.
- *Opposite argued.* Could $\lVert z\rVert=1$ be a standing normalisation? It is stated nowhere in L51, and the statement quantifies over "$X$ in the Lie algebra of $G$" with no constraint, $X=0$ is in every Lie algebra. But **the record itself writes the homogeneous form elsewhere**: [second-order.md](../findings/second-order.md) line 68 reads "leaving $-\tfrac38\theta\lVert z\rVert^4$ as the leading term". So the corrected form is the record's own, and L51's display is the outlier. The repair is a hypothesis correction, not a refutation of the mechanism.

## 5. The stationary corrector, and the value there

$L_W$ is self-adjoint with $W$ an eigenvector, so $L_W$ and hence $B$ preserve $W^\perp$ and commute with $\Pi$. On $W^\perp$ the functional
$$F(w)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle b,w\rangle-\tfrac{3\theta}8\lVert z\rVert^4,\qquad b:=\Pi(z\circ z),$$
(the substitution $\langle z\circ z,w\rangle=\langle b,w\rangle$ is legitimate for $w\perp W$) has differential $-\tfrac32(Bw-b)$, so **stationarity on $W^\perp$ is $Bw=\Pi(z\circ z)$** ✔, exactly as the block says.

**$\Pi u$ solves it and $u$ does not.** $\langle u,W\rangle=\langle X^2W,W\rangle=-\langle XW,XW\rangle=-\lVert z\rVert^2$ by skewness, so $\Pi u=u+\lVert z\rVert^2W$ and $u\notin W^\perp$ whenever $z\ne0$. Then, using $BW=-\tfrac\theta2W$ and (II),
$$B(\Pi u)=Bu+\lVert z\rVert^2BW=z\circ z-\tfrac\theta2\lVert z\rVert^2W=\Pi(z\circ z)=b,$$
the last equality because $\langle z\circ z,W\rangle=T(z,z,W)=\langle L_Wz,z\rangle=\tfrac\theta2\lVert z\rVert^2$. ✔ **Claim 7 confirmed.** By contrast $Bu=z\circ z\ne b$ for $z\ne0$, so $u$ genuinely fails the stationarity equation as well as failing to lie in $W^\perp$, the block is right on both counts and [fence-posts.md](../findings/fence-posts.md) line 307 is wrong (claim 15).

**The value.** $b=B\Pi u$ lies in $\operatorname{ran}B$ and $b\perp\ker B$ (§3), so $B^+b$ exists and
$$\langle b,B^+b\rangle=\langle B\Pi u,\;P_{(\ker B)^\perp}\Pi u\rangle=\langle \Pi u,\;B\,P_{(\ker B)^\perp}\Pi u\rangle=\langle \Pi u,B\Pi u\rangle,$$
since $B$ annihilates $\ker B$. And at $w=\Pi u$,
$$F(\Pi u)=-\tfrac34\langle b,\Pi u\rangle+\tfrac32\langle b,\Pi u\rangle-\tfrac{3\theta}8\lVert z\rVert^4=\tfrac34\langle b,B^+b\rangle-\tfrac{3\theta}8\lVert z\rVert^4 .$$
So **$F(\Pi u)=0$ is exactly $\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4$**, the two errors of claim 6 and claim 8 are the same error and cancel in claim 9.

**Now the value itself, derived rather than asserted.** Expand $\langle b,\Pi u\rangle=\langle B\Pi u,\Pi u\rangle$ in terms of $u$. From $u=\Pi u-\lVert z\rVert^2W$ and $Bu=B\Pi u+\tfrac\theta2\lVert z\rVert^2W$,
$$\langle Bu,u\rangle=\big\langle b+\tfrac\theta2\lVert z\rVert^2W,\;\Pi u-\lVert z\rVert^2W\big\rangle=\langle b,\Pi u\rangle-\tfrac\theta2\lVert z\rVert^4 ,$$
using $b\perp W$ and $\Pi u\perp W$. Hence the claim is equivalent to $\langle Bu,u\rangle=0$, i.e. $\langle z\circ z,u\rangle=0$.

**That identity, proved.** Let $y(t)=e^{tX}\!\cdot\!W$, which is unit for all $t$, so $P(y(t))=P(W)=\theta$ is constant by invariance alone. With $y=\sum_kt^kX^kW/k!$ and $T$ trilinear symmetric, the multinomial coefficients at order $4$ are $3\cdot\tfrac1{4!}$, $6\cdot\tfrac1{3!}$, $3\cdot\tfrac1{2!2!}$, $3\cdot\tfrac1{2!}$:
$$0=[t^4]P(y)=\tfrac18T(X^4W,W,W)+T(X^3W,XW,W)+\tfrac34T(u,u,W)+\tfrac32T(u,z,z).$$
Skewness of $X$ gives $\langle W,X^4W\rangle=\lVert X^2W\rVert^2=\lVert u\rVert^2$ and $\langle XW,X^3W\rangle=-\lVert u\rVert^2$, so the first two terms are $\tfrac\theta8\lVert u\rVert^2$ and $\tfrac\theta2\langle z,X^3W\rangle=-\tfrac\theta2\lVert u\rVert^2$. The third is $\tfrac34\langle L_Wu,u\rangle=\tfrac{3\theta}8\lVert u\rVert^2-\tfrac34\langle Bu,u\rangle$ and the fourth is $\tfrac32\langle Bu,u\rangle$. Summing,
$$0=\big(\tfrac\theta8-\tfrac\theta2+\tfrac{3\theta}8\big)\lVert u\rVert^2+\big(-\tfrac34+\tfrac32\big)\langle Bu,u\rangle=\tfrac34\langle Bu,u\rangle .$$
$$\boxed{\;\langle Bu,u\rangle=\langle z\circ z,u\rangle=0,\qquad\text{hence}\qquad\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4\quad\text{and}\quad F(\Pi u)=0.\;}$$
**Claim 9 confirmed.** Nothing in this used positivity, maximality, the sign of $\theta$, or compactness.

**DISCREPANCY 2 (claim 12), the block's one-line justification does not deliver this.** The block writes "equals $0$ because $P$ is constant along the orbit". But $F$ is evaluated on the *chordal* curve $\hat x(t)=W+tz+\tfrac{t^2}2\Pi u$, and the ray of $\hat x(t)$ agrees with the orbit $y(t)$ only to order $t^2$: they differ by $\tfrac{t^2}2\lVert z\rVert^2W$, which is $\tfrac{t^2}2\lVert z\rVert^2y(t)+O(t^3)$, and by the whole of $\tfrac{t^3}6X^3W$ at the next order. So constancy of $P$ on the orbit does not by itself transfer to $[t^4]$ of the chordal jet. **The conclusion is nevertheless true**, and the two agree because both equal $\tfrac34\langle Bu,u\rangle$, but that is the computation above, not the one-liner. *Located, exhibited (the $t^3$ mismatch is explicit), opposite argued: I looked for a reparametrisation making $\hat x$ and $y$ projectively equal to $O(t^4)$ and there is none, since $X^3W$ has a component off $\operatorname{span}(W,z,u)$ in general.* Recorded as a **GAP in the written argument, not in the mathematics**.

## 6. DISCREPANCY 3, $\langle b,B^+b\rangle=\theta/2$ is false as written, with a closed-form witness

- *Located.* [second-order.md](../findings/second-order.md) line 195 and [fence-posts.md](../findings/fence-posts.md) line 307, both reading "$\langle b,B^+b\rangle=\theta/2$".
- *Exhibited.* Take $E=\mathbb R^3$, $P(x)=x_3(x_1^2+x_2^2)$, $G=SO(2)$ rotating $(e_1,e_2)$ and fixing $e_3$, orthogonal, compact, and $P$ is invariant. The symmetric $T$ has $T_{113}=T_{223}=\tfrac13$ and all other independent entries $0$. Then $\nabla P=(2x_1x_3,2x_2x_3,x_1^2+x_2^2)$, and $W=(a,0,c)$ with $a^2=\tfrac23,\ c=\tfrac1{\sqrt3}$ is a unit critical point: $\nabla P(W)=(2ac,0,a^2)=\tfrac2{\sqrt3}W$, so $Q(W)=\theta W$ with $\theta=P(W)=ca^2=\tfrac2{3\sqrt3}>0$. ✔ hypotheses met.

  With $X$ the standard generator ($Xe_1=e_2$, $Xe_2=-e_1$, $Xe_3=0$): $z=XW=ae_2$, $u=X^2W=-ae_1$, $\lVert z\rVert^2=a^2=\tfrac23$, and $\langle u,W\rangle=-a^2$ ✔.

  $L_W=\tfrac13\begin{pmatrix}c&0&a\\0&c&0\\a&0&0\end{pmatrix}$, and $\tfrac\theta2=\tfrac1{3\sqrt3}=\tfrac c3$. So $L_Wz=\tfrac c3ae_2=\tfrac\theta2z$ ✔ **(identity I, exact)**, and $z\circ z=\tfrac{a^2}3e_3=\tfrac29e_3$, while
  $$Bu=\big(\tfrac\theta2-L_W\big)(-ae_1)=-a\big[\big(\tfrac\theta2-\tfrac c3\big)e_1-\tfrac a3e_3\big]=\tfrac{a^2}3e_3=z\circ z\ \checkmark\ \textbf{(identity II, exact)} .$$
  Then $\Pi u=u+a^2W=-\tfrac a3e_1+\tfrac{2c}3e_3$, $b=\Pi(z\circ z)=\tfrac29e_3-\tfrac2{9\sqrt3}W$, and
  $$\langle b,B^+b\rangle=\langle b,\Pi u\rangle=\tfrac29\cdot\tfrac{2c}3=\tfrac4{27\sqrt3}.$$
  The claimed value is $\tfrac\theta2=\tfrac1{3\sqrt3}=\tfrac9{27\sqrt3}$. **They differ by the factor $\lVert z\rVert^4=\tfrac49$, exactly as §4 predicts.** ($\langle z\circ z,u\rangle=\tfrac29\langle e_3,-ae_1\rangle=0$ ✔, confirming §5's identity independently.)
- *Opposite argued.* (i) Is $X$ implicitly unit-normalised? Even with $\lVert X\rVert=1$ one gets $\lVert z\rVert^2=\tfrac23\ne1$ here, so no normalisation of $X$ rescues the bare $\theta/2$; only $\lVert z\rVert=1$ does, and that is a constraint on $W$ and $X$ jointly, stated nowhere. (ii) Is $\lVert z\rVert=1$ forced downstream? [second-order.md](../findings/second-order.md) line 165 does read the condition as "$\langle b,B^+b\rangle\le\theta/2$ … for every **unit** $z\in A(\tfrac12)$", so the consumer normalises and is internally consistent. **This is why the verdict is *hypotheses corrected* and not *broken***: the intended statement is "for unit $z$", and L51 omits the word. (iii) Is the witness degenerate? No: $W$ is a genuine unit critical point with $\theta>0$, $z\ne0$, and all of L51's other conclusions hold there exactly.

**Boundary case, and the smallest admissible dimension.** $X=0$ lies in every Lie algebra, and so does every $X$ in the isotropy algebra of $W$. There $z=0$, $u=X^2W=0$, $b=0$ and $\langle b,B^+b\rangle=0$, again not $\theta/2$, at any $\theta>0$. The corrected form $\tfrac\theta2\lVert z\rVert^4$ reads $0=0$ and survives. **In dimension $1$** the whole statement is vacuous ($W^\perp=0$, $z=0$); **dimension $2$** is where §8's counterexample lives; **dimension $3$** is the smallest where a nonzero orbit tangent and a nontrivial corrector coexist, which is this witness.

## 7. Positivity: for the value, for the word "supremum", or for neither

**For neither, as regards the value.** §5's derivation of $\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4$ and of $F(\Pi u)=0$ used only: identity (II), $BW=-\tfrac\theta2W$, self-adjointness, skewness of $X$, and $P$ constant on the orbit. **Statement C is right and statement A is over-conditioned.**

**For the word "supremum", yes.** $F$ is concave on $W^\perp$ **iff** $B\vert_{W^\perp}\succeq0$. Where that holds, $\Pi u$ is a global maximiser of $F$ and $\sup F=F(\Pi u)=0$; where it fails, $\Pi u$ is a saddle and $\sup F=+\infty$ along any direction with $\langle Bw,w\rangle<0$, while $F(\Pi u)=0$ is untouched. **Claim 10 confirmed; claim 11 is the block's own Argument contradicting its own Statement**, since "a quadratic in $w$, concave on $W^\perp$" is asserted flat two lines after "the equality needs no positivity either". [fence-posts.md](../findings/fence-posts.md) line 307 repeats the flat "the concave quartic functional".

**A witness with $B\vert_{W^\perp}\not\succeq0$ where the equality still holds.** Extend §6 to $E=\mathbb R^4$ with $P(x)=x_3(x_1^2+x_2^2)+2x_4^2x_3$, still $SO(2)$-invariant. The same $W=(a,0,c,0)$ is critical with the same $\theta=\tfrac2{3\sqrt3}$, and $z,u,z\circ z,b$ are unchanged (they live in $\operatorname{span}(e_1,e_2,e_3)$). The new entry is $T_{344}=\tfrac23$, giving $L_We_4=\tfrac{2c}3e_4$ and
$$Be_4=\big(\tfrac\theta2-\tfrac{2c}3\big)e_4=\big(\tfrac1{3\sqrt3}-\tfrac2{3\sqrt3}\big)e_4=-\tfrac1{3\sqrt3}e_4 .$$
So $B\vert_{W^\perp}$ has a **negative** eigenvalue, $\sup F=+\infty$, and $W$ is **not** a local maximum, the tangential second-order coefficient in direction $e_4$ is $-3\langle Be_4,e_4\rangle=+\tfrac1{\sqrt3}>0$, matching the direct expansion $P(a\cos\varepsilon,0,c\cos\varepsilon,\sin\varepsilon)=ca^2+c(2-\tfrac32a^2)\varepsilon^2+O(\varepsilon^4)$ with $c(2-1)=\tfrac1{\sqrt3}$. Yet **every conclusion of L51 holds there verbatim**, including $\langle b,B^+b\rangle=\tfrac4{27\sqrt3}=\tfrac\theta2\lVert z\rVert^4$ and $F(\Pi u)=0$. This is a positive witness that the equality is genuinely unconditional, and simultaneously a witness for claim 17.

## 8. The two-dimensional counterexample, and the guard

**The counterexample, checked in closed form.** $P(x,y)=x^3+\tfrac32xy^2+\alpha y^3$ on $\mathbb R^2$, $W=(1,0)$. Symmetric $T$: $T_{111}=1$, $T_{112}=0$, $T_{122}=\tfrac12$, $T_{222}=\alpha$. Then $\nabla P(1,0)=(3,0)=3W$, so $W$ is a unit critical point with $Q(W)=W\circ W=e_1=W$ and $\theta=1>0$. ✔ $L_W=\begin{pmatrix}1&0\\0&\tfrac12\end{pmatrix}$, $B=\tfrac12I-L_W=\begin{pmatrix}-\tfrac12&0\\0&0\end{pmatrix}$, so on $W^\perp=\mathbb Re_2$, **$B\vert_{W^\perp}=0\succeq0$** ✔ (and $A(\tfrac12)=\mathbb Re_2$).

On the unit circle, $x=\cos s,\ y=\sin s$:
$$P=\cos^3s+\tfrac32\cos s\sin^2s+\alpha\sin^3s=\Big(1-\tfrac32s^2+\tfrac78s^4\Big)+\Big(\tfrac32s^2-\tfrac54s^4\Big)+\alpha s^3+O(s^5)=1+\alpha s^3-\tfrac38s^4+O(s^5).$$
The $s^2$ term cancels ✔ (consistent with $B\vert_{W^\perp}=0$), and for $\alpha\ne0$ the odd $s^3$ term makes $P>P(W)$ on one side. **Not a local maximum.** ✔ **Claim 13 confirmed; $B\vert_{W^\perp}\succeq0$ is strictly weaker than maximality.**

*Two free cross-checks fall out.* $T(z,z,z)=T_{222}=\alpha$ for $z=e_2$, matching the $s^3$ coefficient, an independent confirmation of claim 5. And with $t=\tan s$ the curve $W+te_2$ normalises to $(\cos s,\sin s)$, so $[t^4]=-\tfrac38$; the boxed formula of §4 at $w=0$, $\theta=1$, $\lVert z\rVert=1$ gives $-\tfrac38\theta\lVert z\rVert^4=-\tfrac38$ ✔, an independent confirmation of claim 6's *corrected* constant.

*One caveat on how far this example reaches.* It carries no group; $z=e_2$ is not an orbit tangent, and if it were, $T(z,z,z)=0$ would force $\alpha=0$. So the example bears only on the side-claim "$B\vert_{W^\perp}\succeq0$ is strictly weaker than maximality" and exercises none of L51's orbit conclusions. That is exactly the use the block makes of it, so the scope is honest, recorded because the brief asks about subfamily-to-general leakage and this is where it could have occurred.

**DISCREPANCY 4, the guard, claim 14.** $L_WW=\theta W$ gives $BW=-\tfrac\theta2W$, so at every $\theta>0$ the operator $B$ has a strictly negative eigenvalue on $\mathbb RW$ and **$\{$critical points with $B\succeq0\}=\varnothing$**. [conventions.md](../findings/conventions.md) line 35 records this correctly. **What [fence-posts.md](../findings/fence-posts.md) line 307 asserts as written**: "*where $B\succeq0$ the fourth-order supremum equals $0$*" is a conditional whose antecedent holds at no point of the class the sentence quantifies over, it is vacuously true and asserts nothing at any critical point. Since the post's purpose is to tell a successor what the calculus already gives on the orbit tangent, a vacuous clause there is a live defect: a reader who checks the antecedent concludes the fence post says nothing, and a reader who does not check it imports a condition that cannot be met. **The clause needs $B\vert_{W^\perp}\succeq0$, and by §7 it does not need even that.** *Located, exhibited ($BW=-\tfrac\theta2W$ at §6's witness, $\theta=\tfrac2{3\sqrt3}>0$), opposite argued: one might read "$B\succeq0$" as elliptical for "$B\vert_{W^\perp}\succeq0$", which is how conventions.md line 35 glosses it, but the fence post is the one place a reader arrives without conventions.md in hand, and the same line also mis-states $u$ for $\Pi u$, so the ellipsis reading is not available on charity.*

**DISCREPANCY 5, conventions.md's $b$, claim 16.** [conventions.md](../findings/conventions.md) line 36 reads "in the orbit calculus $b:=z\circ z$, the **vector** appearing as $B(\Pi u)=b$". **The two halves are incompatible.** §5 shows $B(\Pi u)=\Pi(z\circ z)=z\circ z-\tfrac\theta2\lVert z\rVert^2W$, which equals $z\circ z$ only when $z=0$. Worse, the definitional half changes the value: with $b=z\circ z=Bu$ one gets $B^+b=P_{(\ker B)^\perp}u$ and
$$\langle b,B^+b\rangle=\langle Bu,u\rangle=0\qquad(\text{§5}),$$
so a reader taking conventions.md's definition literally derives $0$ where the lemma states $\theta/2$. At §6's witness: $\langle z\circ z,u\rangle=\tfrac29\langle e_3,-ae_1\rangle=0$ against $\tfrac4{27\sqrt3}$. *Opposite argued:* the equation half is the one the rest of the record uses, [second-order.md](../findings/second-order.md) line 165's "$\lVert z\circ z\rVert^2=\tfrac{\theta^2}4+\lVert b\rVert^2$" is exactly the Pythagoras of $z\circ z=\tfrac\theta2W+b$ for unit $z$, which needs $b=\Pi(z\circ z)$ and is false for $b=z\circ z$ unless $\theta=0$. **So $b:=\Pi(z\circ z)$ is the record's operative reading and line 36's colon-equals is the error.**

## 9. "None of this uses maximality", checked against every step

| step | inputs | maximality? |
| --- | --- | --- |
| equivariance of $\circ$ | $P$ invariant, action orthogonal | no |
| identity (I) | equivariance, criticality | no |
| identity (II) | equivariance, criticality | no |
| $z\in A(\tfrac12)$ | (I), $X$ skew | no |
| $T(z,z,z)=0$ | (II), self-adjointness, $Bz=0$ | no |
| fusion rule | (II), self-adjointness | no |
| $[t^3]$, $[t^4]$ | trilinearity, symmetry, (I), $z,w\perp W$ | no |
| $B\Pi u=b$ | (II), $BW=-\tfrac\theta2W$, $\langle u,W\rangle=-\lVert z\rVert^2$ | no |
| $\langle Bu,u\rangle=0$ | $P$ constant on the orbit (invariance alone), $X$ skew | no |
| $\sup F=0$ | the above **plus** $B\vert_{W^\perp}\succeq0$ | no, and positivity is not maximality either, by §8's counterexample |

**Claim 17 confirmed.** Note that "$P$ is constant along the orbit" is pure invariance and does not even use criticality. §7's $\mathbb R^4$ witness is a positive exhibit: a critical point with $\theta>0$, a nonzero orbit tangent, every L51 conclusion holding, and $W$ demonstrably not a local maximum.

## 10. The remaining named traps

- **$\ker W\ne0$ and padded objects.** L51 is stated abstractly, with $W$ a unit vector of a Euclidean space; degeneracy of $W$ as an operator plays no role in any step, and the padded competitors are covered because $\theta=\sqrt{3/2}>0$ at padded $W_{\mathbb{CP}^2}$. The record's padding trap attaches to the screen $S(W)$ ([conventions.md](../findings/conventions.md) line 48, "vacuous when $\ker W\ne0$"), not here. **No bite.**
- **Boundaries of the stated range, and the smallest admissible dimension.** Answered in §6: $X=0$ and every isotropy $X$ sit at $z=0$, where the literal $\theta/2$ fails and the corrected $\tfrac\theta2\lVert z\rVert^4$ holds; dimension $1$ is vacuous, $2$ is the counterexample's home, $3$ the smallest with a nonzero orbit tangent.
- **A claim proven on a subfamily used in general.** The only candidate is the $2$-dimensional counterexample, used for a non-implication, which one witness settles. §8 records that it exercises none of L51's orbit conclusions. **No leakage found.**
- **A hypothesis stated but never used.** Two: **compactness of $G$** (only "Lie group acting orthogonally" is consumed), and **$\theta>0$**, the sign is spent nowhere in L51's proof; $\theta\ne0$ is spent once, in §2's $A(\tfrac12)=\ker B$. The record already books the second at [second-order.md](../findings/second-order.md) line 68.
- **A step using a hypothesis never stated.** Three: **$\lVert z\rVert=1$** (Discrepancies 1 and 3, the substantive one); **$X$ skew-symmetric**, used twice and derivable from the orthogonal action but nowhere written in the block; **finite-dimensionality**, needed for $B^+$ and for the orthogonal splitting, imported silently through the word "Euclidean".
- **A universal claim with no witness.** "None of this uses maximality" is a claim about the proof, and §9 discharges it by inspecting the inputs of every step; §7's $\mathbb R^4$ point is the object witness. The other universal, "the fusion rule holds for every $y\in A(\tfrac12)$", is proved for all of $\ker B$ in §3.
- **An imported theorem whose hypotheses were never checked.** The block's motivation says "The extremal-idempotent calculus of **Krasnov–Tkachev** applies verbatim here". **The word *verbatim* is not checked and the record's own fence post contradicts it**: [fence-posts.md](../findings/fence-posts.md) line 177 is headed "The Weyl algebra has no unit, which bars the sharpest extremal-idempotent theorems", line 185 records that Tkachev's characterisation "assumes a **unital** Euclidean metrised algebra", and line 189 lists the unit-free residue as existence of extremal idempotents plus the spectral bound that is [L24](../findings/second-order.md), not a fusion rule. A second unchecked hypothesis: KT's *extremal* idempotent means a maximiser, which L51 explicitly disclaims. **The saving fact is that the Argument imports nothing**, every step of §§1–5 is derived from scratch and no line cites KT. So this is an **over-claim confined to the motivation paragraph, load-bearing for nothing**. Recorded, because the brief names this as the route that has already died once here. The honest form of the sentence is that the *setting* is KT's (critical points are scaled idempotents, $e=W/\theta$, needing $\theta\ne0$) while the *calculus below is this record's own*.
- **Symbol collisions.** All six live symbols resolve, and I record where each is read from.
  - **$B$**, sense of [conventions.md](../findings/conventions.md) line 35, $\tfrac\theta2\mathrm{Id}-L_W$. That file flags it as "a third object under the letter $B$", against the Killing form $B(X,Y)=(n-2)\operatorname{tr}(XY)$ (line 59, with a second normalisation at line 118) and [L48](../findings/problem.md)'s partition scalar (line 33). **Four or five senses; L51 never says which.**
  - **$b$**, Discrepancy 5. conventions.md line 36 additionally warns that "[second-order.md](../findings/second-order.md) uses the letter $b$ for a *scalar* forty-four lines above its vector use here".
  - **$u$**, the orbit acceleration $X^2\!\cdot\!W$ here; collides with [fence-posts.md](../findings/fence-posts.md) line 181's candidate unit $u$ (same subject matter, adjacent file) and with [conventions.md](../findings/conventions.md) line 39's moment $u$ in "$d=u-\lambda_1^2$".
  - **$z$**, the orbit tangent here; collides with the perturbation parameter $z$ in [second-order.md](../findings/second-order.md)'s own resolvent block (line 1447, "$\lVert zH\rVert\le\rho\lVert H\rVert_{op}$"), i.e. inside the same file.
  - **$\Pi$**, sense (i) of [conventions.md](../findings/conventions.md) line 34, projection onto $W^\perp$, which that entry says is "meant below" and which the block uses correctly. Three other senses live.
  - **$A$**, $A(\tfrac12)$ the Peirce half-space here; collides with [conventions.md](../findings/conventions.md) line 39's $A=\lambda_1$ and with the algebra letter $A$ in the Krasnov–Tkachev quotations of [second-order.md](../findings/second-order.md) line 21 ("$\tfrac12\notin\sigma(A)$"), the same file, and the very passage L51's motivation points at.
  - **$T$** and **$P$** resolve cleanly: $T$ is conventions.md line 24's third sense, and $P(x)=T(x,x,x)$ agrees with line 16's $\langle W,Q(W)\rangle$ because $X\circ X=Q(X)$. Recorded as checked rather than as a defect.

## 11. What would falsify this, and what I did to look for it

**The object that would break the lemma.** A compact Lie group $G$ acting orthogonally on a Euclidean $E$, a fully symmetric $T$ with $P$ invariant, a unit critical point $W$ with $Q(W)=\theta W$, $\theta>0$, and an $X$ in the Lie algebra for which **either** $L_W(X\!\cdot\!W)\ne\tfrac\theta2X\!\cdot\!W$, **or** $B(X^2\!\cdot\!W)\ne(X\!\cdot\!W)^{\circ2}$, **or** $\langle z\circ z,y\rangle\ne0$ for some $y\in\ker B$, **or** $\langle B\Pi u,\Pi u\rangle\ne\tfrac\theta2\lVert z\rVert^4$, the last being equivalent, by §5, to $\langle z\circ z,X^2\!\cdot\!W\rangle\ne0$.

**How I looked.** By reduction, not by search, the analysis-only rule forbids a sweep and I ran none. Each of the four is an identity in the $4$-jet of the single function $t\mapsto P(e^{tX}\!\cdot\!W)$ and its equivariant companion $t\mapsto Q(e^{tX}\!\cdot\!W)$, so a falsifier would have to make one of $[t^1]Q$, $[t^2]Q$, $[t^4]P$ nonzero against $P$ invariant and $W$ critical, which §§1 and 5 close by direct expansion, with no hypothesis left free. **The one place a falsifier does exist is the literal wording**, and I found it: §6's $SO(2)$ point on $\mathbb R^3$, where $\langle b,B^+b\rangle=\tfrac4{27\sqrt3}$ against the stated $\tfrac1{3\sqrt3}$, and the degenerate $z=0$ of every isotropy direction. I then looked for the opposite (a normalisation making the bare $\theta/2$ right) and found that [second-order.md](../findings/second-order.md) line 165 supplies it ("for every unit $z$") while L51 omits it, which is why the verdict is a hypothesis correction.

**A second falsifier hunted and not found.** For claim 10 I looked for a point where positivity is genuinely needed for the *value*, i.e. where $B\vert_{W^\perp}\not\succeq0$ and $\langle b,B^+b\rangle\ne\tfrac\theta2\lVert z\rVert^4$. §7's $\mathbb R^4$ point is exactly such a $B$ and the equality holds there in exact arithmetic; §5 shows why no such point can exist, since the derivation never touches the spectrum's sign. **Statement C stands and statement A is the weaker of the two.**

## Verdict

**PROVEN, hypotheses corrected.**

The three repairs the record owes, each one line:

1. **[second-order.md](../findings/second-order.md) line 195 and 199**, add the normalisation $\lVert z\rVert=1$ to the statement, or write the two values homogeneously as $-\tfrac{3\theta}8\lVert z\rVert^4$ and $\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4$. Line 68 of the same file already uses the homogeneous form.
2. **[second-order.md](../findings/second-order.md) line 201**, "concave on $W^\perp$" must be conditioned on $B\vert_{W^\perp}\succeq0$, which the Statement two lines above expressly disclaims; and "equals $0$ because $P$ is constant along the orbit" needs the $[t^4]$ computation of §5, since the chordal ray and the orbit ray part company at order $t^3$.
3. **[fence-posts.md](../findings/fence-posts.md) line 307**, three errors in one sentence: "$B\succeq0$" names the empty set and should read $B\vert_{W^\perp}\succeq0$ or be dropped by §7; "$u$ is the **stationary point**" should be $\Pi u$; and "$\langle b,B^+b\rangle=\theta/2$" needs $\lVert z\rVert^4$. **Also [conventions.md](../findings/conventions.md) line 36**, whose "$b:=z\circ z$" contradicts the "$B(\Pi u)=b$" in its own cell and yields $0$ for the lemma's value; the operative reading is $b=\Pi(z\circ z)$.

**On the brief's central question: statement C is right.** The fourth-order equality at the stationary corrector needs no positivity, $B\vert_{W^\perp}\succeq0$ licenses only the word *supremum*, exactly as C says. Statement A is true but strictly weaker than what the mathematics supports.
