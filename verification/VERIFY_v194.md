# VERIFY_v194, Lemma L51, the orbit identity and its fourth-order consequence

*Cold read of [BRIEF_L51.md](BRIEF_L51.md), which was taken as the whole of the record for the claim; the two unlabelled statements were adjudicated from the mathematics alone before their provenance was looked up. **No numerical work of any kind was done**, every witness below is exhibited in closed form and every coefficient is derived by hand, under the programme's standing [analysis-only rule](../.claude/rules/analysis-only.md). Log: [agent_logs/verify-L51-v194.log](../agent_logs/verify-L51-v194.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $2L_Wz=\theta z$ from differentiating equivariance once | **PROVEN** |
| 2 | $Bu=z\circ z$ from differentiating twice | **PROVEN** |
| 3 | $A(\tfrac12)=\ker B\cap W^\perp=\ker B$, orbit tangent inside it | **PROVEN** (consumes $\theta\ne0$) |
| 4 | fusion rule $\langle z\circ z,y\rangle=\langle u,By\rangle=0$ on $\ker B$ | **PROVEN**, needs self-adjointness of $B$ and nothing else |
| 5 | $T(z,z,z)=0$ on the orbit tangent | **PROVEN** |
| 6 | $[t^3]P(x/\lvert x\rvert)=T(z,z,z)$ | **PROVEN** |
| 7 | $[t^4]P(x/\lvert x\rvert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8$ | **BROKEN as printed**, the constant is $-\tfrac{3\theta}8\lVert z\rVert^4$; the display is imported from a block that says "of unit norm" and the qualifier was dropped |
| 8 | stationarity is $Bw=\Pi(z\circ z)$, met by $\Pi u$ and not by $u$ | **PROVEN** |
| 9 | the value at the stationary corrector is $0$ exactly | **PROVEN** |
| 10 | that value is $\langle b,B^+b\rangle=\theta/2$ | **BROKEN as printed**, under [conventions.md](../findings/conventions.md)'s tabled $b:=z\circ z$ the expression is **$0$** at every orbit; the true statement is $\langle\Pi b,B^+\Pi b\rangle=\tfrac\theta2\lVert z\rVert^4$ |
| 11 | "$B(\Pi u)=b$" | **BROKEN as printed**, $B(\Pi u)=\Pi b$, and $\Pi b\ne b$ whenever $\theta z\ne0$; the block's own *Argument* paragraph has it right |
| 12 | the equality needs no positivity; positivity licenses only "supremum" | **PROVEN**, statement C is right |
| 13 | statement A's guarded form | **true but weaker**; A and C do not contradict |
| 14 | $P=x^3+\tfrac32xy^2+\alpha y^3$ at $(1,0)$ has $B\vert_{W^\perp}=0$ and is no local maximum at $\alpha\ne0$ | **PROVEN** in closed form |
| 15 | the bare guard $B\succeq0$ names the empty set | **PROVEN**; [fence-posts.md](../findings/fence-posts.md) line 307 therefore carries a **vacuous conditional in a live clause** |
| 16 | "None of this uses maximality" | **PROVEN**, checked step by step |

**One line.** The mathematics of L51 is right and the disputed clause is settled in favour of statement C, the fourth-order value is $0$ with no positivity anywhere, and $B\vert_{W^\perp}\succeq0$ buys only the word *supremum*, but three written objects in the canonical block are wrong as printed: a dropped unit-norm hypothesis in the jet, a missing projection in $\langle b,B^+b\rangle$ that flips its value to $0$, and a guard written $B\succeq0$ where only $B\vert_{W^\perp}\succeq0$ is ever satisfiable.

**Verdict: PROVEN, hypotheses corrected.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- The product and the operator: *"The $\circ$ product: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$."* Hence $Q(x)=x\circ x$ and $L_Wx=W\circ x=\theta L_ex$, so $L_Wx=\tfrac\theta2x\iff L_ex=\tfrac12x$ and the name $A(\tfrac12)$ is the $L_e$-eigenvalue.
- The trilinear form: *"$T$, third sense: the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$, whose symmetry is what makes $L_e$ self-adjoint."*
- $\theta$: *"$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$."*
- $B$: *"$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point, so $A(\tfrac12)=\ker B$ and $Bu=z\circ z$ along an orbit. **$B\succeq0$ is only ever readable on $W^\perp$**, since $L_WW=\theta W$ gives $BW=-\tfrac\theta2W$ at every $\theta>0$. This is a third object under the letter $B$ in this record."*
- $\Pi$: *"(i) the orthogonal projection onto $W^\perp$, at whichever unit $W$ is in play … Sense (i) is meant below … the orbit acceleration $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$, so $u\notin W^\perp$ and the corrector is $\Pi u=u+\lVert z\rVert^2W$ rather than $u$."*
- $b$ and $B^+$: *"in the orbit calculus $b:=z\circ z$, the **vector** appearing as $B(\Pi u)=b$, and $B^+$ the Moore-Penrose inverse of $B$ on $(\ker B)^\perp$."* **This entry is one of the two defects found below**: the record's own consumers use $b=\Pi(z\circ z)$ at $\lVert z\rVert=1$.
- The Hessian link, from the Morse–Bott row: *"$\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$"*, i.e. $\mathrm{Hess}_SP=-6B$ on $W^\perp$. So $B\vert_{W^\perp}\succeq0$ **is** the second-order necessary condition for a local maximum, which is what makes claim 14 the right thing to test.

## 1. Hypothesis inventory

| hypothesis | stated | where consumed |
| --- | --- | --- |
| $T$ fully symmetric trilinear | yes | self-adjointness of $L_W$ and $B$ (claims 4, 5, 9); the multinomial expansion of $P(x)$ (claims 6, 7) |
| $P(x)=T(x,x,x)$, $\langle x\circ y,z\rangle=T(x,y,z)$ | yes | $\nabla P=3Q$, hence the meaning of criticality |
| $G$ acts **orthogonally** | yes | twice, and both are load-bearing: it gives equivariance of $Q$ from invariance of $P$, and it makes $X$ skew, whence $z\perp W$ and $\langle u,W\rangle=-\lVert z\rVert^2$ |
| $G$ **compact** | yes | **nowhere.** Compactness would supply an invariant inner product, but orthogonality of the action is assumed outright, so the hypothesis is surplus. Harmless; recorded because the brief asks for hypotheses stated and never used |
| $G$ a Lie group with a Lie algebra | implicit in "for $X$ in the Lie algebra of $G$" | existence of $t\mapsto e^{tX}$, the object being differentiated |
| $P$ $G$-invariant | yes | equivariance of $Q$ (claims 1, 2) and $P$ constant along the orbit (claim 9) |
| $W$ unit, $Q(W)=\theta W$ | yes | every coefficient of the jet; $\nabla f(W)=0$ in the curve proof of claim 9 |
| $\theta>0$ | yes | **only through $\theta\ne0$**, and in three places: $BW=-\tfrac\theta2W\ne0$ forces $\ker B\perp W$, so $A(\tfrac12)=\ker B$ (claim 3); $\Pi b\ne b$ and $B(\Pi u)\ne b$ (claim 11); the guard $B\succeq0$ is empty (claim 15). The **sign** is consumed nowhere, it is the normalisation *"Normalise $W$ to $\theta>0$ before measuring $S$"* of [conventions.md](../findings/conventions.md), since $W\mapsto-W$ flips it |
| $z\in A(\tfrac12)$ | derived, claim 1 | the $[t^2]$ and $[t^3]$ cancellations in the jet, and the vanishing of the omitted $t^3$ term of $x$ |
| $w\perp W$ | yes | poses the corrector problem on $W^\perp$. **Immaterial to the value**: §5.3 shows $[t^4]$ is independent of the radial part of $w$ |
| $\lVert z\rVert=1$ | **NOT stated in L51** | the printed constant $-\tfrac{3\theta}8$ and the printed value $\theta/2$ both require it. This is the dropped hypothesis of §5 |
| $B\vert_{W^\perp}\succeq0$ | stated in A, disclaimed in C | **only** for concavity, hence for the word *supremum* (§7). Never for the value |
| maximality | not stated | **nowhere** (§9) |

## 2. Equivariance, and what orthogonality is doing

$P$ is $G$-invariant: $P(g\cdot x)=P(x)$ for all $g,x$. Differentiating in $x$ along $h$ and using $\nabla P=3Q$ (which is $DP(x)[h]=3T(x,x,h)=3\langle Q(x),h\rangle$, by full symmetry of $T$):

$$3\langle Q(g\cdot x),g\cdot h\rangle=3\langle Q(x),h\rangle\quad\text{for all }h .$$

Orthogonality gives $g^{\mathsf T}=g^{-1}$, so $\langle g^{-1}Q(g\cdot x),h\rangle=\langle Q(x),h\rangle$ for all $h$, i.e.

$$Q(g\cdot x)=g\cdot Q(x).$$

**Orthogonality is doing two jobs and both are load-bearing.** It converts invariance of the scalar $P$ into equivariance of the vector map $Q$ (without it the adjoint $g^{\mathsf T}$ would not cancel) and it makes each $X\in\mathrm{Lie}(G)$ act as a **skew** operator, since $\tfrac{d}{dt}\big\vert_0\langle e^{tX}a,e^{tX}b\rangle=0$ gives $X^{\mathsf T}=-X$. **Compactness is doing nothing.** Its usual job is to produce an invariant inner product by averaging, and here the inner product is fixed and the action is assumed orthogonal already; the closedness of orbits is never used.

## 3. The two identities

Put $x(t)=e^{tX}\!\cdot\!W$, so $\dot x(0)=X\!\cdot\!W=z$ and $\ddot x(0)=X^2\!\cdot\!W=u$. Equivariance at $g=e^{tX}$ with $Q(W)=\theta W$ gives the identity in $t$

$$Q(x(t))=\theta\,x(t).$$

Since $Q(x)=x\circ x$ is a symmetric bilinear expression, $\tfrac{d}{dt}Q(x)=2\,x\circ\dot x$ and $\tfrac{d^2}{dt^2}Q(x)=2\,\dot x\circ\dot x+2\,x\circ\ddot x$.

**First derivative at $t=0$:** $2\,W\circ z=\theta z$, i.e.

$$\boxed{2L_Wz=\theta z},\qquad\text{equivalently } Bz=0 .$$

**Second derivative at $t=0$:** $2\,z\circ z+2\,W\circ u=\theta u$, i.e. $2\,z\circ z=2(\tfrac\theta2-L_W)u$, so

$$\boxed{B\,u=z\circ z} .$$

Both as stated. **Claims 1 and 2: PROVEN.**

## 4. $A(\tfrac12)$, and where $\theta>0$ is consumed

$L_WW=W\circ W=Q(W)=\theta W$, so $BW=\tfrac\theta2W-\theta W=-\tfrac\theta2W$. At $\theta\ne0$ this makes $W$ an eigenvector of the self-adjoint $B$ at the nonzero eigenvalue $-\tfrac\theta2$; eigenspaces of a self-adjoint operator at distinct eigenvalues are orthogonal, so

$$\ker B\perp W,\qquad\text{hence}\qquad A(\tfrac12)=\ker B\cap W^\perp=\ker B .$$

Separately $\langle z,W\rangle=\langle XW,W\rangle=0$ because $X$ is skew. With $Bz=0$ this puts $z\in A(\tfrac12)$. **Claim 3: PROVEN.**

**This is the single place $\theta>0$ is genuinely consumed**, and only as $\theta\ne0$. It also reconciles the brief's two phrasings: results.md quantifies the fusion rule over $y\in A(\tfrac12)$ and fence-posts.md over $y\in\ker B$, and those sets are equal, so there is no discrepancy between them.

$B$ preserves $W^\perp$ (it is self-adjoint with $W$ an eigenvector), which is what lets the corrector problem be posed on $W^\perp$ at all.

## 5. The exact jet

Write $s=\lVert z\rVert^2$, $b=z\circ z$, and take $x(t)=W+tz+\tfrac{t^2}2w$ with $\lVert W\rVert=1$, $z\perp W$, $z\in\ker B$, $w\perp W$.

### 5.1 The two factors

$$\lvert x\rvert^2=1+t^2s+t^3\langle z,w\rangle+\tfrac{t^4}4\lVert w\rVert^2=:1+\epsilon,$$

using $\langle W,z\rangle=\langle W,w\rangle=0$. Then $\lvert x\rvert^{-3}=(1+\epsilon)^{-3/2}=1-\tfrac32\epsilon+\tfrac{15}8\epsilon^2-\cdots$, and since $\epsilon^2=s^2t^4+O(t^5)$,

$$N:=\lvert x\rvert^{-3}=1-\tfrac32s\,t^2-\tfrac32\langle z,w\rangle\,t^3+\big(\tfrac{15}8s^2-\tfrac38\lVert w\rVert^2\big)t^4+O(t^5).$$

Expanding $P(x)=T(x,x,x)$ multinomially and using $T(W,W,\cdot)=\theta\langle W,\cdot\rangle$ and $T(W,z,\cdot)=\langle L_Wz,\cdot\rangle=\tfrac\theta2\langle z,\cdot\rangle$:

$$P_0=\theta,\quad P_1=3T(W,W,z)=0,\quad P_2=3T(W,z,z)+\tfrac32T(W,W,w)=\tfrac{3\theta}2s,$$
$$P_3=T(z,z,z)+3T(W,z,w)=T(z,z,z)+\tfrac{3\theta}2\langle z,w\rangle,\qquad P_4=\tfrac32\langle b,w\rangle+\tfrac34\langle L_Ww,w\rangle .$$

### 5.2 The two coefficients

$[t^3](PN)=P_3N_0+P_2N_1+P_1N_2+P_0N_3$ with $N_1=0$ and $P_1=0$:

$$[t^3]\,P(x/\lvert x\rvert)=T(z,z,z)+\tfrac{3\theta}2\langle z,w\rangle+\theta\big(-\tfrac32\langle z,w\rangle\big)=T(z,z,z).$$

**Claim 6: PROVEN**, and the cancellation is exactly the $w$-dependence killing itself.

$[t^4](PN)=P_4+P_2N_2+P_0N_4$:

$$[t^4]\,P(x/\lvert x\rvert)=\tfrac32\langle b,w\rangle+\tfrac34\langle L_Ww,w\rangle-\tfrac{9\theta}4s^2+\tfrac{15\theta}8s^2-\tfrac{3\theta}8\lVert w\rVert^2 .$$

The $w$-quadratic terms combine as $\tfrac34\langle L_Ww,w\rangle-\tfrac{3\theta}8\lVert w\rVert^2=\tfrac34\langle(L_W-\tfrac\theta2)w,w\rangle=-\tfrac34\langle Bw,w\rangle$, and the constants as $(-\tfrac{18}8+\tfrac{15}8)\theta s^2=-\tfrac38\theta s^2$. So

$$\boxed{[t^4]\,P(x/\lvert x\rvert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8\lVert z\rVert^4 } .$$

### 5.3 Two checks on the display

*The omitted cubic term of the curve.* Adding $t^3v$ to $x(t)$ changes $P_4$ by $6T(W,z,v)=6\langle L_Wz,v\rangle$ and $\epsilon$'s $t^4$ coefficient by $2\langle z,v\rangle$, hence $N_4$ by $-3\langle z,v\rangle$ and $[t^4]$ by a further $-3\theta\langle z,v\rangle$. The total is $6\langle(L_W-\tfrac\theta2)z,v\rangle=-6\langle Bz,v\rangle$, which vanishes on $\ker B$. This reproduces exactly the $-6\langle Bz,v\rangle$ that [second-order.md](../findings/second-order.md) records, and fixes its normalisation as $x=\cdots+t^3v$ rather than $\cdots+\tfrac{t^3}6v$.

*The radial part of $w$.* Writing $w=w_0+\mu W$ with $w_0\perp W$ and redoing the expansion, $P_2$ becomes $\tfrac{3\theta}2(s+\mu)$, $P_4$ gains $\tfrac{3\mu\theta}4s+\tfrac{3\mu^2\theta}4$, and $\epsilon$'s $t^2$ and $t^4$ coefficients become $s+\mu$ and $\tfrac14(\lVert w_0\rVert^2+\mu^2)$. Collecting, the $\mu$-terms are $\tfrac34\mu\theta s+\tfrac38\theta\mu^2-\tfrac34\theta s\mu-\tfrac38\theta\mu^2=0$. So $[t^4]$ is **independent of the radial component of $w$**, confirming the record's *"a radial component of $w$ is absorbed by rescaling"* and showing the hypothesis $w\perp W$ costs nothing.

### 5.4 The defect: the constant term

**The block prints $-\tfrac{3\theta}8$ where the derivation gives $-\tfrac{3\theta}8\lVert z\rVert^4$.**

*Located.* [findings/second-order.md](../findings/second-order.md), the displayed jet inside the Lemma L51 canonical block, and the same display in [results.md](../results.md)'s statement of L51 by way of that block. The **earlier** jet block in the same file states the hypothesis outright (*"for $z\in A(\tfrac12)$ **of unit norm**, $w\perp W$"*) and the canonical block, whose $z$ is fixed by its own statement to be $X\!\cdot\!W$, dropped it. This is precisely the trap *"a claim proven on a subfamily and used in general"*: the display is correct on the unit sphere of $A(\tfrac12)$ and is quoted for an arbitrary orbit velocity.

*Exhibited, in closed form.* Take the two-variable cubic $P(x,y)=x^3+\tfrac32xy^2$ at $W=(1,0)$, where $\theta=1$ and $L_We_2=\tfrac12e_2$ (computed in §8). With $z=ce_2$ and $w=0$ the curve is $x(t)=(1,ct)$ and

$$P(x/\lvert x\rvert)=\frac{1+\tfrac32c^2t^2}{(1+c^2t^2)^{3/2}}=(1+\tfrac32a)(1-\tfrac32a+\tfrac{15}8a^2+\cdots)=1-\tfrac38a^2+O(a^3),\qquad a:=c^2t^2,$$

so $[t^4]=-\tfrac38c^4=-\tfrac{3\theta}8\lVert z\rVert^4$. At $c=2$ the printed value is $-\tfrac38$ and the true one is $-6$.

*The opposite argued.* Could $\lVert z\rVert=1$ be a silent standing convention of L51? No, on three counts. The statement quantifies over **all** $X$ in the Lie algebra, and $z=X\!\cdot\!W$ scales with $X$, so no normalisation can hold for all of them at once. The printed expression is not homogeneous under the reparametrisation $z\mapsto cz$, $w\mapsto c^2w$, $t\mapsto t/c$, which leaves the curve fixed and must scale $[t^4]$ by $c^4$, the other two terms do and the bare constant does not. And the **boundary case settles it**: for $X$ in the isotropy algebra of $W$, $z=0$ and $u=0$, the curve is constant at $W$, so $[t^4]=0$; the printed constant returns $-\tfrac{3\theta}8\ne0$. **The discrepancy stands.**

## 6. The fusion rule, and what it needs

For $y\in\ker B$,

$$\langle z\circ z,y\rangle=\langle Bu,y\rangle=\langle u,By\rangle=0 .$$

The middle step is the whole of it. $B=\tfrac\theta2\mathrm{Id}-L_W$ is self-adjoint because $\langle L_Wx,y\rangle=T(W,x,y)=T(W,y,x)=\langle L_Wy,x\rangle$, which is full symmetry of $T$ and nothing else. **So the answer to the brief's question is: it needs $Bu=z\circ z$ and self-adjointness of $B$, and nothing beyond them**, no positivity, no maximality, no criticality beyond what already went into $B$, no compactness, no finite dimension. **Claim 4: PROVEN.**

Taking $y=z$, which lies in $\ker B$ by §3, gives $T(z,z,z)=\langle z\circ z,z\rangle=0$. **Claim 5: PROVEN.**

## 7. The disputed clause

### 7.1 Stationarity

On $W^\perp$ the functional is $F(w)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle b,w\rangle-\tfrac{3\theta}8\lVert z\rVert^4$, whose gradient in $W^\perp$ is $-\tfrac32Bw+\tfrac32\Pi b$ (using $B(W^\perp)\subseteq W^\perp$). So stationarity is $Bw=\Pi b$, as the block's *Argument* paragraph says.

Two facts place the solution. $\langle u,W\rangle=\langle X^2W,W\rangle=-\langle XW,XW\rangle=-\lVert z\rVert^2$ by skewness, so $\Pi u=u+\lVert z\rVert^2W$; and $\langle b,W\rangle=T(z,z,W)=\langle L_Wz,z\rangle=\tfrac\theta2\lVert z\rVert^2$, so $\Pi b=b-\tfrac\theta2\lVert z\rVert^2W$. Then

$$B(\Pi u)=Bu+\lVert z\rVert^2BW=b-\tfrac\theta2\lVert z\rVert^2W=\Pi b .$$

So $\Pi u$ solves it; $u$ does not, both because $u\notin W^\perp$ when $z\ne0$ and because $Bu=b\ne\Pi b$. **Claim 8: PROVEN.**

**But the statement paragraph writes "$B(\Pi u)=b$", and that is false**, the identity is $B(\Pi u)=\Pi b$, and $b-\Pi b=\tfrac\theta2\lVert z\rVert^2W\ne0$ whenever $\theta\ne0$ and $z\ne0$. The same wrong form is tabled in [conventions.md](../findings/conventions.md) as *"the vector appearing as $B(\Pi u)=b$"*. It is corrected two paragraphs later by the block's own *Argument*, which prints $Bw=\Pi(z\circ z)$. **Claim 11: BROKEN as printed, self-corrected in the same block.**

### 7.2 The value is $0$, with no positivity

Since $\Pi u\in W^\perp$ and $B\Pi u=\Pi b$,

$$F(\Pi u)=-\tfrac34\langle\Pi b,\Pi u\rangle+\tfrac32\langle b,\Pi u\rangle-\tfrac{3\theta}8\lVert z\rVert^4=\tfrac34\langle\Pi b,\Pi u\rangle-\tfrac{3\theta}8\lVert z\rVert^4,$$

using $\langle b,\Pi u\rangle=\langle\Pi b,\Pi u\rangle$. The fusion rule enters here and only here: for $y\in\ker B$ we have $y\perp W$, so $\langle\Pi b,y\rangle=\langle b,y\rangle=0$, i.e. $\Pi b\perp\ker B$, so writing $\Pi u=B^+\Pi b+k$ with $k\in\ker B$ gives $\langle\Pi b,\Pi u\rangle=\langle\Pi b,B^+\Pi b\rangle$, the value is independent of which solution of $Bw=\Pi b$ one takes, which is what makes $B^+$ legitimate.

**Independently of any of that, the value is $0$.** Let $f=P(\cdot/\lvert\cdot\rvert)$, let $\gamma(t)=e^{tX}\!\cdot\!W$ and let $\tilde\gamma(t)=x(t)/\lvert x(t)\rvert$ with $x(t)=W+tz+\tfrac{t^2}2\Pi u$. Then $\tilde\gamma(t)=W+tz+\tfrac{t^2}2(\Pi u-\lVert z\rVert^2W)+O(t^3)=W+tz+\tfrac{t^2}2u+O(t^3)$, so $\delta:=\tilde\gamma-\gamma=O(t^3)$. Now $f$ is $0$-homogeneous, so $\nabla f(W)=3Q(W)-3P(W)W=0$ by criticality, and $\mathrm{Hess}f(W)[z]=-6Bz=0$ because $z\in\ker B$ (the ambient Hessian of a $0$-homogeneous $f$ agrees on $W^\perp$ with $\mathrm{Hess}_Sf$ at a critical point, and kills $W$ by Euler). Hence $\nabla f(\gamma(t))=O(t^2)$ and

$$f(\tilde\gamma(t))-f(\gamma(t))=\langle\nabla f(\gamma(t)),\delta(t)\rangle+O(\lVert\delta\rVert^2)=O(t^5).$$

Since $f(\gamma(t))\equiv\theta$ ($P$ is constant along the orbit and the orbit stays on the sphere), we get $[t^3]f(\tilde\gamma)=[t^4]f(\tilde\gamma)=0$. **Claim 9: PROVEN, and no step of it touched positivity.** Combining, $\langle\Pi b,B^+\Pi b\rangle=\tfrac\theta2\lVert z\rVert^4$.

### 7.3 The defect: $\langle b,B^+b\rangle$ is $0$, not $\theta/2$

**Located.** The clause *"the fourth-order value at the stationary corrector is $\langle b,B^+b\rangle=\theta/2$"* in the L51 block of [second-order.md](../findings/second-order.md), repeated at [fence-posts.md](../findings/fence-posts.md) line 307 and in the same file's earlier higher-variation block, with $b$ tabled in [conventions.md](../findings/conventions.md) as $b:=z\circ z$.

**Exhibited.** Decompose $b=\Pi b+\beta W$ with $\beta=\tfrac\theta2\lVert z\rVert^2$. Since $BW=-\tfrac\theta2W$ and $W\in(\ker B)^\perp$, $B^+W=-\tfrac2\theta W$, and $B^+$ respects the orthogonal splitting $\mathbb RW\oplus(W^\perp)$. So

$$\langle b,B^+b\rangle=\langle\Pi b,B^+\Pi b\rangle-\tfrac2\theta\beta^2=\tfrac\theta2\lVert z\rVert^4-\tfrac2\theta\cdot\tfrac{\theta^2}4\lVert z\rVert^4=0 .$$

**Under the record's own tabled definition of $b$, the quantity the record says equals $\theta/2$ equals $0$, at every critical orbit with $\theta>0$.**

A closed-form witness carrying an actual group. On $\mathbb R^3$ with coordinates $(a,p,q)$, let $G=SO(2)$ rotate $(p,q)$ and take the invariant cubic $P=a(p^2+q^2)$, so the only nonzero components of $T$ are $T_{app}=T_{aqq}=\tfrac13$ and their permutations. At $W=(\tfrac1{\sqrt3},\sqrt{\tfrac23},0)$: $\nabla P(W)=(\tfrac23,\tfrac{2\sqrt2}3,0)=\tfrac2{\sqrt3}W$, so $W$ is a unit critical point with $\theta=\tfrac2{3\sqrt3}>0$. With $p_0=\sqrt{\tfrac23}$ and $a_0=\tfrac1{\sqrt3}$,

$$L_W=\begin{pmatrix}0&p_0/3&0\\p_0/3&a_0/3&0\\0&0&a_0/3\end{pmatrix},\qquad B=\tfrac\theta2\mathrm{Id}-L_W=\begin{pmatrix}a_0/3&-p_0/3&0\\-p_0/3&0&0\\0&0&0\end{pmatrix},$$

since $a_0/3=\tfrac1{3\sqrt3}=\tfrac\theta2$. The generator gives $z=XW=(0,0,p_0)$, $\lVert z\rVert^2=\tfrac23$, and $u=X^2W=(0,-p_0,0)$ with $\langle u,W\rangle=-\tfrac23=-\lVert z\rVert^2$. Then $b=z\circ z=\tfrac29e_a$ and $Bu=(p_0^2/3,0,0)=\tfrac29e_a=b$, confirming the second identity. Further $\Pi u=(\tfrac2{3\sqrt3},-\tfrac{\sqrt2}{3\sqrt3},0)$, $\Pi b=(\tfrac4{27},-\tfrac{2\sqrt2}{27},0)$, and $B(\Pi u)=\Pi b$ exactly, **not $b$**. Finally $\ker B=\mathbb Re_q$, $\Pi u\perp\ker B$, so $B^+\Pi b=\Pi u$ and

$$\langle\Pi b,B^+\Pi b\rangle=\tfrac4{27}\cdot\tfrac2{3\sqrt3}+\tfrac{2\sqrt2}{27}\cdot\tfrac{\sqrt2}{3\sqrt3}=\tfrac{12}{81\sqrt3}=\tfrac4{27\sqrt3}=\tfrac\theta2\lVert z\rVert^4,$$

while $B^+b$ lies in $\mathbb Re_p$ and $\langle b,B^+b\rangle=0$. Every prediction of §7.2 confirmed and the printed form refuted, in exact arithmetic on an object built for the purpose.

**The opposite argued.** Could $b$ silently mean $\Pi(z\circ z)$? That is in fact what the record's consumers use, the corollary block in [second-order.md](../findings/second-order.md) writes $\lVert z\circ z\rVert^2=\tfrac{\theta^2}4+\lVert b\rVert^2$, which is Pythagoras for $z\circ z=\tfrac\theta2W+b$ at $\lVert z\rVert=1$, so **there $b=\Pi(z\circ z)$ unambiguously.** So the mathematics is right and it is [conventions.md](../findings/conventions.md)'s table entry that is wrong, together with every clause that reads $\langle b,B^+b\rangle$ as written. Could $\lVert z\rVert=1$ rescue the numeral $\theta/2$? It rescues the numeral only for $\langle\Pi b,B^+\Pi b\rangle$; $\langle b,B^+b\rangle$ is $0$ at unit $z$ too. **The discrepancy stands, and the fix is a definition, not a coefficient.**

### 7.4 Which statement is right

**Statement C is right.** The value $0$ was derived twice above without positivity, once algebraically from $B(\Pi u)=\Pi b$ plus the fusion rule plus the jet, once from constancy of $P$ on the orbit, and both routes go through unchanged when $B\vert_{W^\perp}$ has negative eigenvalues.

What positivity buys is exactly one word. $F$ is a quadratic on $W^\perp$ with leading form $-\tfrac34\langle Bw,w\rangle$, concave iff $B\vert_{W^\perp}\succeq0$. If $B\vert_{W^\perp}$ has a negative eigenvalue $\lambda<0$ with eigenvector $\nu$, then $F(\Pi u+r\nu)=F(\Pi u)-\tfrac34\lambda r^2\to+\infty$, so the supremum is $+\infty$ and the stationary point is a saddle. **So: positivity is needed for "supremum", never for the value.** The record itself supplies a witness that this is not idle, [second-order.md](../findings/second-order.md) records the $C_5$ blow-up as a point where $B\vert_{W^\perp}\succeq0$ fails.

**Statement A is true but weaker, and the two do not contradict.** A asserts a conditional whose conclusion holds unconditionally for the value and needs the condition for the word *supremum*; C asserts the sharper decomposition. A's guard is also non-vacuous, [second-order.md](../findings/second-order.md)'s own table lists $S^4\times S^4$, $S^6\times S^6$, $S^5\times S^7$ and padded $W_{\mathbb{CP}^2}$ under "$B\vert_{W^\perp}\succeq0$: yes", so A is not vacuously true, merely under-strength. The live risk in A is a reading, not a falsehood: printed as a single guarded clause it invites the inference that positivity is needed for the equality, which §7.2 refutes. **Claims 12 and 13 as tabled.**

## 8. The counterexample

$P(x,y)=x^3+\tfrac32xy^2+\alpha y^3$ on $\mathbb R^2$, $W=(1,0)$.

*Symmetric $T$.* Matching coefficients in $P=\sum T_{ijk}x_ix_jx_k$: $T_{111}=1$, $3T_{122}=\tfrac32$ so $T_{122}=\tfrac12$, $T_{222}=\alpha$, $T_{112}=0$.

*Criticality and $\theta$.* $\nabla P=(3x^2+\tfrac32y^2,\;3xy+3\alpha y^2)$, so $\nabla P(W)=(3,0)=3W$ and $Q(W)=W$: a unit critical point with $\theta=1>0$, for every $\alpha$.

*The guard holds.* $\langle L_We_2,e_2\rangle=T(e_1,e_2,e_2)=\tfrac12$ and $\langle L_We_2,e_1\rangle=T_{112}=0$, so $L_We_2=\tfrac12e_2$ and $B\vert_{W^\perp}=\tfrac\theta2-\tfrac12=0\succeq0$, for every $\alpha$.

*Maximality fails at $\alpha\ne0$.* Parametrise the circle by $x=\cos\sigma$, $y=\sin\sigma$. Then $\cos^3\sigma=1-\tfrac32\sigma^2+O(\sigma^4)$ and $\tfrac32\cos\sigma\sin^2\sigma=\tfrac32\sigma^2+O(\sigma^4)$, so those two cancel to fourth order, and $\alpha\sin^3\sigma=\alpha\sigma^3+O(\sigma^5)$:

$$P\vert_{S^1}(\sigma)=1+\alpha\sigma^3+O(\sigma^4).$$

At $\alpha\ne0$ this exceeds $1=P(W)$ for small $\sigma$ of the sign of $\alpha$, so $W$ is not a local maximum. **Claim 14: PROVEN in closed form, and $B\vert_{W^\perp}\succeq0$ is strictly weaker than maximality.**

Two cross-checks. The cubic coefficient $\alpha$ is exactly $T(z,z,z)=T_{222}$ at $z=e_2$, so the counterexample is the $[t^3]$ formula of §5.2 doing its job. And $B\vert_{W^\perp}=0$ makes this a *degenerate* critical point, which is the only place third order can decide, consistent with the record's finding that the fusion rule is the third-order maximality condition and kills $S^3\times S^3$.

*Admissibility.* The example carries no group. That is not a defect: L51's hypotheses are satisfied with $G$ trivial, under which $z=u=0$ and the orbit clauses are vacuous, and the example is used only to separate the guard from maximality, one witness suffices to refute an implication. Dimension $2$ is inside "a Euclidean space" as stated.

## 9. "None of this uses maximality"

Step by step, with the hypothesis each consumes.

| step | consumes |
| --- | --- |
| $Q$ equivariant | $P$ invariant, action orthogonal |
| $2L_Wz=\theta z$ | one derivative of an identity |
| $Bu=z\circ z$ | two derivatives of an identity |
| $z\perp W$, $\langle u,W\rangle=-\lVert z\rVert^2$ | $X$ skew |
| $A(\tfrac12)=\ker B$ | $\theta\ne0$, $B$ self-adjoint |
| $T(z,z,z)=0$ | $B$ self-adjoint, $Bz=0$ |
| fusion rule | $B$ self-adjoint, $Bu=b$ |
| the jet coefficients | $Q(W)=\theta W$, $z\in\ker B$, $z,w\perp W$ |
| $B(\Pi u)=\Pi b$ | $BW=-\tfrac\theta2W$, $\langle u,W\rangle=-\lVert z\rVert^2$ |
| the value $0$ | $P$ constant on the orbit; $\nabla f(W)=0$; $\mathrm{Hess}f(W)z=0$ |
| the word *supremum* | $B\vert_{W^\perp}\succeq0$, **stated as a hypothesis where it is used** |

**No step consumes $\mathrm{Hess}_SP\preceq0$ or the global maximality of $W$. Claim 16: PROVEN.**

One qualification worth stating positively, since it is the nearest thing to a hidden import: $B\vert_{W^\perp}\succeq0$ **is** the second-order necessary condition for a local maximum, by $\mathrm{Hess}_SP=-6B$ on $W^\perp$. So statement A's guarded clause is not hypothesis-free, it assumes a consequence of maximality. It remains strictly weaker than maximality, and §8 is the witness. This is exactly what C says by calling the guard *"strictly weaker than maximality"*, and it is why C's separation of the value from the word *supremum* is the honest form.

## 10. The guard, as written

$BW=-\tfrac\theta2W$, so at every critical point with $\theta>0$ the operator $B$ has $-\tfrac\theta2<0$ in its spectrum and **$B\succeq0$ holds at no critical point at all**. [conventions.md](../findings/conventions.md) states this: *"$B\succeq0$ is only ever readable on $W^\perp$."*

[fence-posts.md](../findings/fence-posts.md) line 307 nonetheless reads, in a live clause of Post F37:

> *"and $u$ is the **stationary point** of the concave quartic functional, so where $B\succeq0$ the fourth-order supremum equals $0$, i.e. $\langle b,B^+b\rangle=\theta/2$ exactly."*

**What that clause asserts as written**, taken literally, is three things and all three are defective.

1. *"where $B\succeq0$"* is a conditional on the **empty set** of critical points. The sentence is therefore vacuously true and conveys nothing about any point the programme studies. Since Post F37's job is to tell a successor what is closed, a vacuous guard understates the post: on the correct guard $B\vert_{W^\perp}\succeq0$ the clause has content and non-vacuous instances, and per §7.4 the *value* half needs no guard whatever.
2. *"the concave quartic functional"* asserts concavity unconditionally, which holds iff $B\vert_{W^\perp}\succeq0$. Stated before the guard rather than after it, the adjective does the guard's work in the reader's head.
3. *"$\langle b,B^+b\rangle=\theta/2$"* is the §7.3 defect, value $0$ under the tabled $b$, and the missing $\lVert z\rVert^4$ of §5.4 on top of it.

The one point where fence-posts is **more** defensible than the canonical block: it says *"$u$ is the stationary point"* where the block says the condition is *"satisfied by $\Pi u$ and not by $u$"*. By §5.3 the functional is independent of the radial part of $w$, so on the **full** space the stationary set is $\Pi u+\ker B+\mathbb RW$, which contains $u$; the block's sharper claim is about the equation $Bw=\Pi b$ **posed on $W^\perp$**, where $u$ is not even admissible. Both are right under their own reading, and neither says which. **Claim 15 as tabled.**

## 11. The remaining traps, each by name

- **$\ker W\ne0$ and padded objects.** L51 is stated for an abstract Euclidean space and never touches the operator structure of $W$, so a padded $W$ is an instance and nothing degrades. The one real interaction is a sharpening of §5.4: padding **enlarges the isotropy**, so more $X$ give $z=X\!\cdot\!W=0$, and $z=0$ is exactly the case where the printed constant $-\tfrac{3\theta}8$ returns a nonzero value for a constant curve. The defect bites hardest precisely at the record's padded points.
- **Boundaries of every stated range, and the smallest admissible dimension.** $\dim V=1$: $W^\perp=0$, every clause vacuous and true. $\dim V=2$: the counterexample of §8 lives there. $G$ trivial: all orbit clauses vacuous, *"the orbit tangent lies in $A(\tfrac12)$"* reads $0\in A(\tfrac12)$. $z=0$: refutes the printed constant (§5.4), and makes *"satisfied by $\Pi u$ and not by $u$"* false, since $\Pi u=u$ there. $\ker B=0$: fusion rule vacuous, $B^+=B^{-1}$ on $W^\perp$, everything else intact.
- **A claim proven on a subfamily and used in general.** Fired once, and it is the §5.4 defect: the jet display is proved in [second-order.md](../findings/second-order.md) *"for $z\in A(\tfrac12)$ of unit norm"* and quoted in the canonical block for $z=X\!\cdot\!W$, which is not unit.
- **A hypothesis stated but never used.** **Compactness of $G$** (§2). Also the $\cap W^\perp$ in $A(\tfrac12)=\ker B\cap W^\perp$, which is automatic at $\theta\ne0$, harmless, and correctly reflected in [conventions.md](../findings/conventions.md)'s *"$A(\tfrac12)=\ker B$"*.
- **A step using a hypothesis never stated.** $\lVert z\rVert=1$, §5.4. This is the round's principal finding.
- **Where $\theta>0$ is consumed.** §4 and the inventory: only through $\theta\ne0$, in three places, and the sign is a normalisation.
- **A universal claim with no witness.** Checked and clear. *"$B\succeq0$ names the empty set"* has the witness $BW=-\tfrac\theta2W$; *"$B\vert_{W^\perp}\succeq0$ is strictly weaker than maximality"* has §8's explicit cubic; A's guard is non-vacuous by the record's own table of four points satisfying it; and the fourth-order clause has a witness that it can fail without the guard, the $C_5$ blow-up.
- **An imported theorem whose hypotheses were never checked, the Krasnov–Tkachev unitality trap.** It does not fire, and the reason is on file rather than assumed. The motivation paragraph's *"critical points of $P$ on the unit sphere are idempotents of the metrised algebra"* is verifiable directly: $Q(W)=\theta W$ gives $e\circ e=W\circ W/\theta^2=W/\theta=e$ for $e=W/\theta$, needing $\theta\ne0$ and no unit. [krasnov-tkachev-2018-idempotent-variety/notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) records that their Euclidean metrised algebra is *"equation (48) and positive-definiteness and nothing more"* and that Prop 6.6's proof *"consumes only idempotency, self-adjointness and $D^2f(c)\le0$"*, confirmed by three verifiers at source; the unital hypothesis lives in the *Clifford-type* paper, which the record separately marks as not applying. **And it is moot for correctness here:** L51's argument imports no theorem, every step is derived in-block from two differentiations and self-adjointness. The one residue worth flagging is that KT's Prop 6.7 is stated for an **extremal** (globally maximal) idempotent, whereas L51's fusion rule needs no extremality at all; L51 is the stronger statement and does not lean on theirs.
- **Symbol collisions.** $B$: [conventions.md](../findings/conventions.md) tables the $\mathfrak{so}(n)$ Killing form, L48's partition scalar and this $B=\tfrac\theta2-L_W$, plus a fourth normalisation in [sym3-blocks.md](../findings/sym3-blocks.md); unambiguous inside L51, which defines it in-block. $\Pi$: four senses; sense (i) is meant, and the table says so. $b$: a **scalar** forty-four lines above its vector use in the same file, and (the live problem), mis-tabled as $z\circ z$ where consumers use $\Pi(z\circ z)$ (§7.3). $u$: a vector here, the scalar moment of $d=u-\lambda_1^2$ in [stratum-two-negative.md](../findings/stratum-two-negative.md). $A$: $A(\tfrac12)$ here as a Peirce space, $A=\lambda_1$ in the two-negative relaxation, and $A$ as the algebra's own name in the KT sources whose $A_c(\tfrac12)$ this notation copies, **$A(\tfrac12)$ is used across the record but is nowhere tabled in its own right**, appearing only inside the $B$ row. $T$, $P$, $z$, $W$: all multi-sense, all readable from the block. L51 defines $T$, $P$, $\circ$, $L_W$, $B$ and $A(\tfrac12)$ in its own statement, which is what keeps it safe.

## 12. What would break it, and what was done to look

**The object that would falsify the identities:** a compact $G$ acting orthogonally and preserving $P$, a unit critical $W$ with $\theta>0$, and an $X\in\mathrm{Lie}(G)$ with $L_W(X\!\cdot\!W)\ne\tfrac\theta2X\!\cdot\!W$ or $B(X^2\!\cdot\!W)\ne(X\!\cdot\!W)\circ(X\!\cdot\!W)$. None can exist: both are the first and second $t$-derivatives at $0$ of $Q(e^{tX}W)=\theta e^{tX}W$, an equality of smooth curves holding for all $t$, so a counterexample would have to be a counterexample to differentiation. I looked by re-deriving both from equivariance and by building the $SO(2)$ witness of §7.3, where $Bu=b$ came out exactly.

**The object that would falsify statement C:** an orbit datum $(W,X)$ with $B\vert_{W^\perp}\not\succeq0$ at which the fourth-order value at the stationary corrector is nonzero. It would show the equality does need positivity. None exists: the value was derived twice (§7.2) and neither derivation admits a positivity hypothesis anywhere, the curve route uses only $\nabla f(W)=0$, $\mathrm{Hess}f(W)z=0$ and constancy of $P$ on the orbit, all of which survive indefinite $B$. I looked for one by tracking every hypothesis through both derivations and by re-deriving the algebraic route in the coordinates of §7.3.

**The object that would falsify statement A's guard being weaker than maximality:** a proof that $B\vert_{W^\perp}\succeq0$ at a critical point forces a local maximum. Refuted by the explicit cubic of §8, valid at every $\alpha\ne0$, at $\theta=1>0$, in dimension $2$.

**The object that would falsify "none of this uses maximality":** a step whose validity needs $\mathrm{Hess}_SP\preceq0$. I enumerated all eleven steps in §9 with the hypothesis each consumes; the only one touching the Hessian is the *supremum* clause, and there $B\vert_{W^\perp}\succeq0$ is written as a hypothesis rather than derived from maximality.

**What I did not do.** No script, no Sage, no numeric evaluation, no search or sweep. The two witnesses ($P=x^3+\tfrac32xy^2+\alpha y^3$ on $\mathbb R^2$; $P=a(p^2+q^2)$ on $\mathbb R^3$ with $G=SO(2)$) were constructed by hand for the purpose of screening claims I was about to record, and their arithmetic is exact and printed in full above.

## Verdict

**PROVEN, hypotheses corrected.**

The lemma's mathematics stands in full: both identities, the fusion rule, $T(z,z,z)=0$, both jet coefficients up to the constant, the stationarity of $\Pi u$, the value $0$, the independence from maximality, and the counterexample separating the guard from maximality. The disputed clause resolves in favour of **statement C**: the equality needs no positivity, and $B\vert_{W^\perp}\succeq0$ licenses only the word *supremum*. Statement A is true and weaker, not wrong.

Three written objects need repair before the block is quotable.

1. **Restore $\lVert z\rVert=1$ to the jet display in the L51 block**, as [second-order.md](../findings/second-order.md)'s earlier jet block states it, **or** print the constant as $-\tfrac{3\theta}8\lVert z\rVert^4$. As it stands the display is false at every $\lVert z\rVert\ne1$ and absurd at $z=0$.
2. **Correct $b$ to $\Pi(z\circ z)$** in [conventions.md](../findings/conventions.md)'s table and read $\langle\Pi b,B^+\Pi b\rangle=\tfrac\theta2\lVert z\rVert^4$ wherever $\langle b,B^+b\rangle=\theta/2$ is printed. Under the currently tabled $b:=z\circ z$ the quantity is $0$ at every critical orbit. In the same entry, $B(\Pi u)=b$ should read $B(\Pi u)=\Pi b$.
3. **Change $B\succeq0$ to $B\vert_{W^\perp}\succeq0$ at [fence-posts.md](../findings/fence-posts.md) line 307**, and move the adjective *concave* behind the guard. As written the clause is a conditional on the empty set.
