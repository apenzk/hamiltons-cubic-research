# VERIFY_v196, L51, the orbit identity and the disputed fourth-order clause

Verifier v196, cold reader, working from [BRIEF_L51.md](BRIEF_L51.md). **No numerical work of any kind was done**, no script, no Sage, no Python, no numeric evaluation. The programme's [analysis-only rule](../.claude/rules/analysis-only.md) applies; everything below is closed-form algebra done by hand, and the one witness I construct is exhibited in exact arithmetic on a five-dimensional algebra I write out in full. Log: [agent_logs/verify-L51-v196.log](../agent_logs/verify-L51-v196.log).

## Claim table

| # | claim, as written | verdict |
| --- | --- | --- |
| 1 | $2L_Wz=\theta z$ from differentiating $Q(e^{tX}\!\cdot\!W)=\theta e^{tX}\!\cdot\!W$ once | **PROVEN** |
| 2 | $Bu=z\circ z$ from differentiating it twice | **PROVEN** |
| 3 | the orbit tangent lies in $A(\tfrac12)$ | **PROVEN**, and $\theta\ne0$ is consumed here |
| 4 | fusion rule $\langle z\circ z,y\rangle=\langle u,By\rangle=0$ for $y\in\ker B$ | **PROVEN**, self-adjointness of $B$ and nothing else |
| 5 | $T(z,z,z)=0$ on the orbit tangent | **PROVEN** |
| 6 | $[t^3]P(x/\lvert x\rvert)=T(z,z,z)$ | **PROVEN** |
| 7 | $[t^4]P(x/\lvert x\rvert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8$ | **BROKEN as written**, the constant is $-\tfrac38\theta\lVert z\rVert^4$; the block dropped the unit-norm hypothesis that [second-order.md line 135](../findings/second-order.md) carries |
| 8 | the fourth-order value at the stationary corrector is $\langle b,B^+b\rangle=\theta/2$ | **BROKEN as written**, $\tfrac\theta2\lVert z\rVert^4$, and under [conventions.md](../findings/conventions.md)'s own $b:=z\circ z$ the left side is $0$, not $\theta/2$ |
| 9 | that value gives $[t^4]=0$ exactly | **PROVEN**, but **GAP** in the proof: it needs $\langle Bu,u\rangle=0$, a third identity with no argument on file |
| 10 | the equality needs no positivity; $B\vert_{W^\perp}\succeq0$ licenses only the word *supremum* | **PROVEN**, statement C is right, statement A is true but strictly weaker |
| 11 | $P(x,y)=x^3+\tfrac32xy^2+\alpha y^3$ at $(1,0)$ has $B\vert_{W^\perp}=0$ and is no local maximum at $\alpha\ne0$ | **PROVEN** |
| 12 | [fence-posts.md line 307](../findings/fence-posts.md)'s "where $B\succeq0$" | **BROKEN**, vacuous, the hypothesis names the empty set |
| 13 | "$u$ is the stationary point" at [second-order.md line 147](../findings/second-order.md) and [fence-posts.md line 307](../findings/fence-posts.md), against "satisfied by $\Pi u$ and not by $u$" at line 201 | **withdrawn as a defect**, both are true, on two different domains the record never distinguishes |
| 14 | "None of this uses maximality" | **PROVEN**, checked step by step |
| 15 | "The extremal-idempotent calculus of Krasnov–Tkachev applies verbatim here" | **overstated, and inert**, the record's own [fence post at line 177](../findings/fence-posts.md) says the sharpest such theorems are barred by non-unitality; L51's argument imports nothing |

**Verdict: GAP.** The disputed clause resolves cleanly in favour of statement C, the fourth-order equality needs no positivity, and $B\vert_{W^\perp}\succeq0$ buys only the word *supremum*. Two recorded constants are wrong as written, by a factor $\lVert z\rVert^4$ and by a projection, and I exhibit a witness satisfying every stated hypothesis where the block's own formula returns $[t^4]=\sqrt6/2$ at a point where $P$ is exactly constant along the orbit. The step "equals $0$ because $P$ is constant along the orbit" needs one identity beyond the two the block derives, and that identity has no argument on file.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), which is the record's authority and which I restate nowhere.

> $B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point, so $A(\tfrac12)=\ker B$ and $Bu=z\circ z$ along an orbit. **$B\succeq0$ is only ever readable on $W^\perp$**, since $L_WW=\theta W$ gives $BW=-\tfrac\theta2W$ at every $\theta>0$. *This is a third object under the letter $B$ in this record*

> in the orbit calculus $b:=z\circ z$, the **vector** appearing as $B(\Pi u)=b$, and $B^+$ the Moore-Penrose inverse of $B$ on $(\ker B)^\perp$. **Neither was defined anywhere on the record**, and [second-order.md](second-order.md) uses the letter $b$ for a *scalar* forty-four lines above its vector use here

> **the letter carries four unrelated objects and they must be read from context.** *(i)* the orthogonal projection onto $W^\perp$, at whichever unit $W$ is in play; … Sense (i) is meant below. **It carries real content and had no definition anywhere on the record**: the orbit acceleration $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$, so $u\notin W^\perp$ and the corrector is $\Pi u=u+\lVert z\rVert^2W$

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

Two of these three entries turn out to be part of the finding rather than part of the background, and I say so in §6 and §8.

## 1. Hypothesis inventory

A pass with no inventory is not a pass. The statement's hypotheses, and where each is consumed:

| hypothesis | consumed at | note |
| --- | --- | --- |
| $T$ fully symmetric trilinear | $L_W$ self-adjoint; the polarised jet | load-bearing throughout; without full symmetry the fusion rule collapses |
| $P(x)=T(x,x,x)$, $\langle x\circ y,z\rangle=T(x,y,z)$ | $\nabla P=3\,x\circ x$, hence $Q(x)=x\circ x$ | this is what makes $Q(W)=\theta W$ read as $L_WW=\theta W$ |
| $G$ acts **orthogonally** | equivariance of $Q$; $X$ skew, hence $z\perp W$ and $\langle u,W\rangle=-\lVert z\rVert^2$ | used three times; the sharpest single hypothesis in the block |
| $G$ leaves $P$ invariant | equivariance of $Q$ | with orthogonality it gives $Q(gx)=gQ(x)$, §2 |
| $G$ **compact** | **nowhere** | a Lie group acting orthogonally and preserving $P$ is all the argument uses. Compactness is stated and never consumed |
| $X$ in the Lie algebra of $G$ | $e^{tX}\in G$ for all $t$ | needs $G$ a Lie group, which is implicit in "Lie algebra" |
| $W$ unit | the jet: $\lvert x\rvert^2=1+\dots$; $\Pi u=u-\langle u,W\rangle W$ with no $\lVert W\rVert^2$ divisor | load-bearing |
| $Q(W)=\theta W$ (criticality) | every step | load-bearing |
| $\theta>0$ | **the sign** only at the guard remark (§8); **$\theta\ne0$** at $\ker B\perp W$ so $A(\tfrac12)=\ker B$, at $\Pi u\ne u$, and at $B^+$ acting on the $W$-line | the sign is genuinely used, but only for the guard, not for the identities. [second-order.md line 68](../findings/second-order.md) already records that L51's first three clauses do not use it and invokes them at $\theta<0$ |
| **$\lVert z\rVert=1$** | the constant $-\tfrac{3\theta}8$ and the value $\theta/2$ | **stated nowhere in the block**, carried at [second-order.md line 135](../findings/second-order.md) ("for $z\in A(\tfrac12)$ of unit norm") and at line 165 ("for every unit $z\in A(\tfrac12)$"). This is the missing hypothesis of §6 |
| $\langle Bu,u\rangle=0$ | the words "equals $0$" | **derived nowhere**; §7 |
| $B\vert_{W^\perp}\succeq0$ | concavity, hence the word *supremum* | correctly identified as needed for that and nothing else; §9 |

## 2. Equivariance of $Q$, and what compactness is doing

$P$ is $G$-invariant and $G$ acts orthogonally. Differentiating $P(gx)=P(x)$ in $x$: for all $h$,

$$3T(gx,gx,gh)=DP(gx)[gh]=DP(x)[h]=3T(x,x,h),$$

so $\langle Q(gx),gh\rangle=\langle Q(x),h\rangle=\langle gQ(x),gh\rangle$ using $g^{\mathsf T}g=\mathrm{Id}$; as $gh$ ranges over everything, $Q(gx)=gQ(x)$. Polarising the same identity gives $(gx)\circ(gy)=g(x\circ y)$.

Hence $Q(e^{tX}W)=e^{tX}Q(W)=\theta\,e^{tX}W$ for every $t$. **What is doing the work is orthogonality plus invariance of $P$ plus $G$ being a Lie group.** Compactness is doing nothing: it is what would let one *build* an invariant inner product, but here the action is assumed orthogonal already, and it is what guarantees a maximiser exists, which L51 explicitly does not use. **Compactness is a stated hypothesis that is never consumed.** It is harmless, and it should be recorded as unused rather than quietly carried, because a reader may conclude the identity is unavailable for a non-compact symmetry group, and it is available.

## 3. The two identities, derived

Write $y(t)=e^{tX}W$, so $y(0)=W$, $\dot y(0)=z=X\!\cdot\!W$, $\ddot y(0)=u=X^2\!\cdot\!W$. Since $Q(x)=x\circ x$ with $\circ$ symmetric bilinear, $\tfrac{d}{dt}Q(y)=2\,y\circ\dot y$ and $\tfrac{d^2}{dt^2}Q(y)=2\,\dot y\circ\dot y+2\,y\circ\ddot y$.

**First derivative.** $2L_Wz=\theta z$, i.e. $L_Wz=\tfrac\theta2z$, i.e. $Bz=0$. ✔ as written.

**Second derivative.** $2\,z\circ z+2L_Wu=\theta u$, so $z\circ z=\big(\tfrac\theta2-L_W\big)u=Bu$. ✔ as written.

**The orbit tangent lies in $A(\tfrac12)=\ker B\cap W^\perp$.** $Bz=0$ gives the kernel. For $z\perp W$: the action is orthogonal, so $X$ is skew, so $\langle XW,W\rangle=0$. ✔

**Where $\theta\ne0$ is consumed.** $L_W$ is self-adjoint because $\langle W\circ x,y\rangle=T(W,x,y)=\langle x,W\circ y\rangle$, so $B$ is self-adjoint, and $BW=-\tfrac\theta2W$ makes $W$ an eigenvector with eigenvalue $-\tfrac\theta2$. At $\theta\ne0$ that eigenvalue is distinct from $0$, so $\ker B\perp W$ and $A(\tfrac12)=\ker B$ exactly. **This is the one place the two statements of the fusion rule, over $y\in A(\tfrac12)$ in [results.md](../results.md) and over $y\in\ker B$ in [fence-posts.md](../findings/fence-posts.md), are made to agree**, and it is why the block may write either.

## 4. The fusion rule needs nothing beyond self-adjointness

For $y\in\ker B$: $\langle z\circ z,y\rangle=\langle Bu,y\rangle=\langle u,By\rangle=\langle u,0\rangle=0$.

The chain uses $Bu=z\circ z$ and $B=B^{\mathsf T}$, which is full symmetry of $T$. **It uses no positivity, no maximality, no criticality beyond what already produced $Bu=z\circ z$, and no property of $u$ at all**, $u$ appears only as a vector paired against $By=0$. Answering the brief's question directly: **no, it needs nothing beyond self-adjointness of $B$.**

$T(z,z,z)=\langle z\circ z,z\rangle$ and $z\in\ker B$, so $T(z,z,z)=0$ is the fusion rule read at $y=z$. ✔

## 5. The jet, rebuilt from scratch

Let $x(t)=W+tz+\tfrac{t^2}2w$ with $\lVert W\rVert=1$, $z\perp W$, $w\perp W$, $L_Wz=\tfrac\theta2z$, and write $b:=z\circ z$ for the moment as the **unprojected** vector.

**Norm.** $\lvert x\rvert^2=1+t^2\lVert z\rVert^2+t^3\langle z,w\rangle+\tfrac{t^4}4\lVert w\rVert^2$, so with $s$ the $t$-dependent part and $(1+s)^{-3/2}=1-\tfrac32s+\tfrac{15}8s^2-\dots$,

$$\lvert x\rvert^{-3}=1-\tfrac32t^2\lVert z\rVert^2-\tfrac32t^3\langle z,w\rangle+t^4\big(\tfrac{15}8\lVert z\rVert^4-\tfrac38\lVert w\rVert^2\big)+O(t^5).$$

**Cubic.** With $a_0=W$, $a_1=z$, $a_2=w/2$ and $P(x)=\sum_{i,j,k}t^{i+j+k}T(a_i,a_j,a_k)$, using $T(W,W,\cdot)=\theta\langle W,\cdot\rangle$ and $T(W,z,\cdot)=\tfrac\theta2\langle z,\cdot\rangle$:

$$[t^0]=\theta,\quad[t^1]=0,\quad[t^2]=\tfrac{3\theta}2\lVert z\rVert^2,\quad[t^3]=T(z,z,z)+\tfrac{3\theta}2\langle z,w\rangle,\quad[t^4]=\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle b,w\rangle.$$

**Third order.** $[t^3]P(x/\lvert x\rvert)=T(z,z,z)+\tfrac{3\theta}2\langle z,w\rangle+\theta\cdot(-\tfrac32\langle z,w\rangle)=T(z,z,z)$. **✔ exactly as written**, and the $w$-dependence cancels, which is the content of the claim.

**Fourth order.**

$$[t^4]P(x/\lvert x\rvert)=\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle b,w\rangle+\tfrac{3\theta}2\lVert z\rVert^2\cdot\big(-\tfrac32\lVert z\rVert^2\big)+\theta\big(\tfrac{15}8\lVert z\rVert^4-\tfrac38\lVert w\rVert^2\big).$$

The two $\lVert z\rVert^4$ terms combine as $\theta\lVert z\rVert^4(-\tfrac94+\tfrac{15}8)=-\tfrac38\theta\lVert z\rVert^4$, and $\tfrac34\langle L_Ww,w\rangle-\tfrac{3\theta}8\lVert w\rVert^2=\tfrac34\langle(L_W-\tfrac\theta2)w,w\rangle=-\tfrac34\langle Bw,w\rangle$. So

$$\boxed{\;[t^4]P(x/\lvert x\rvert)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac38\theta\lVert z\rVert^4.\;}$$

## 6. Discrepancy 1, the constant is $-\tfrac38\theta\lVert z\rVert^4$, and the block drops a hypothesis it holds elsewhere

**Located.** [second-order.md line 199](../findings/second-order.md), reproduced verbatim in [BRIEF_L51.md](BRIEF_L51.md) §C, and in the value at line 195; and [fence-posts.md line 307](../findings/fence-posts.md).

**Exhibited, in closed form, twice.**

*By homogeneity.* Replacing $(z,w,t)$ by $(\lambda z,\lambda^2w,t/\lambda)$ leaves the curve $x(t)$ pointwise unchanged, so $[t^4]$ must scale by $\lambda^4$. The two written $w$-terms do; the written constant $-\tfrac{3\theta}8$ does not. A formula that is not homogeneous cannot be the $t^4$ coefficient of a reparametrisation-covariant quantity. $-\tfrac38\theta\lVert z\rVert^4$ is.

*By direct evaluation on the record's own counterexample algebra.* Take $P(x,y)=x^3+\tfrac32xy^2$ (the $\alpha=0$ member of §10's family), $W=(1,0)$, $\theta=1$, $z=\lambda e_2$, $w=0$. Then $x(t)=(1,\lambda t)$, $P(x)=1+\tfrac32\lambda^2t^2$, $\lvert x\rvert^2=1+\lambda^2t^2$, and

$$P(x/\lvert x\rvert)=(1+\tfrac32a)(1+a)^{-3/2}=(1+\tfrac32a)(1-\tfrac32a+\tfrac{15}8a^2)+O(a^3)=1-\tfrac38a^2+O(a^3),\qquad a=\lambda^2t^2,$$

so $[t^4]=-\tfrac38\lambda^4=-\tfrac38\theta\lVert z\rVert^4$, against the written $-\tfrac38$.

**Argued the opposite.** The only defence is an implicit $\lVert z\rVert=1$. It is not in the block: the statement quantifies over $X$ in the Lie algebra of $G$ and sets $z=X\!\cdot\!W$, and the Lie algebra is a vector space, so $\lVert z\rVert$ ranges over a half-line. The defence therefore fails for the block **as a statement**, but it is plainly what was meant, because the same file carries the hypothesis two ways: line 135 states the jet "for $z\in A(\tfrac12)$ **of unit norm**", and line 68 uses the general constant "$-\tfrac38\theta\lVert z\rVert^4$" explicitly. **So the record holds the correct general form and the correct restricted form, and the canonical L51 block states the restricted constant without its restriction.** All three protocol conditions clear. This is a dropped hypothesis, not a wrong computation.

**Repair.** Either restore "$\lVert z\rVert=1$" to the statement, or write the constant as $-\tfrac38\theta\lVert z\rVert^4$ and the value as $\tfrac\theta2\lVert z\rVert^4$. The second is preferable: $z=X\!\cdot\!W$ is not naturally unit, so a normalisation hypothesis on a derived object invites exactly this drift.

## 7. Discrepancy 2, "equals $0$" needs a third identity, and it is not on file

The block's chain is: the quadratic $f(w)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle b,w\rangle-\tfrac38\theta\lVert z\rVert^4$ on $W^\perp$ has stationarity condition $Bw=\Pi b$; $\Pi u$ satisfies it; the value there is $0$ "because $P$ is constant along the orbit".

**The stationarity claim is right.** $B$ preserves $W^\perp$ (self-adjoint with $W$ an eigenvector), so $\nabla f(w)=-\tfrac32Bw+\tfrac32\Pi b$ on $W^\perp$. And $B(\Pi u)=Bu+\lVert z\rVert^2BW=b-\tfrac\theta2\lVert z\rVert^2W=\Pi b$, using $\langle b,W\rangle=T(z,z,W)=\langle L_Wz,z\rangle=\tfrac\theta2\lVert z\rVert^2$. ✔ And $\langle u,W\rangle=\langle X^2W,W\rangle=-\lVert XW\rVert^2=-\lVert z\rVert^2$, so $\Pi u=u+\lVert z\rVert^2W$. ✔

**The value claim is where the gap is.** Since $w^\ast=\Pi u$ solves $Bw=\Pi b$ and $\langle B w^\ast,w^\ast\rangle=\langle\Pi b,w^\ast\rangle$,

$$f(w^\ast)=\tfrac34\langle\Pi b,\Pi u\rangle-\tfrac38\theta\lVert z\rVert^4,\qquad \langle\Pi b,\Pi u\rangle=\langle b,u\rangle+\lVert z\rVert^2\langle b,W\rangle=\langle Bu,u\rangle+\tfrac\theta2\lVert z\rVert^4.$$

So $f(w^\ast)=\tfrac34\langle Bu,u\rangle$, and **$f(w^\ast)=0$ is exactly equivalent to $\langle Bu,u\rangle=\langle z\circ z,u\rangle=0$.**

That is a *third* identity. It is not implied by $Bu=z\circ z$ together with self-adjointness: for a self-adjoint $B$ and a vector $u$, $\langle Bu,u\rangle$ is unconstrained. **It has no argument on file.** The block's justification ("equals $0$ because $P$ is constant along the orbit"), names the right input but does not connect it, because $x(t)=W+tz+\tfrac{t^2}2\Pi u$ is only the second-order jet of the orbit, and the orbit differs from it at order $t^3$. A perturbation of size $O(t^3)$ contaminates $[t^4]$ at the same order as the coefficient being computed, so the identification is not free.

**I record this as a GAP and do not supply the argument as though it were the record's.** For the record's benefit, two routes close it, and both are short:

- *Fourth derivative of $P$ along the orbit.* $P^{(4)}=36T(\dot y,\dot y,\ddot y)+18T(y,\ddot y,\ddot y)+24T(y,\dot y,y''')+3T(y,y,y'''')$; at $t=0$ with $X$ skew, $\langle z,X^3W\rangle=-\lVert u\rVert^2$ and $\langle W,X^4W\rangle=\lVert u\rVert^2$, giving $0=36\langle Bu,u\rangle+18\big(\tfrac\theta2\lVert u\rVert^2-\langle Bu,u\rangle\big)-9\theta\lVert u\rVert^2=18\langle Bu,u\rangle$.
- *Hessian degeneracy.* The Hessian of the $0$-homogeneous $g=P(\cdot/\lvert\cdot\rvert)$ at $W$ is $-6B$ on $W^\perp$ and kills $W$, so $D^2g(W)z=0$ for $z\in\ker B$, which is precisely what makes the $O(t^3)$ discrepancy between the orbit and its parabolic jet contribute $O(t^5)$ rather than $O(t^4)$.

Either sentence, added to the block, closes it. Neither is there now.

## 8. Discrepancy 3, the recorded value, read by the record's own symbol table, is $0$

**Located.** [conventions.md line 36](../findings/conventions.md) defines "$b:=z\circ z$, the **vector** appearing as $B(\Pi u)=b$", and $B^+$ as the Moore–Penrose inverse of $B$ on $(\ker B)^\perp$. The value clause in [second-order.md line 195](../findings/second-order.md) then reads $\langle b,B^+b\rangle=\theta/2$.

**Exhibited.** Under that literal definition the two assertions in the conventions entry are inconsistent with each other and the value is wrong:

- $B(\Pi u)=\Pi b=b-\tfrac\theta2\lVert z\rVert^2W\ne b$ whenever $\theta\lVert z\rVert\ne0$. The block's own stationarity line writes the condition correctly as $Bw=\Pi(z\circ z)$, so the block and the conventions entry disagree.
- $W$ is an eigenvector of $B$ with eigenvalue $-\tfrac\theta2\ne0$, so $W\in(\ker B)^\perp$ and $B^+W=-\tfrac2\theta W$. Splitting $b=\Pi b+\beta W$ with $\beta=\tfrac\theta2\lVert z\rVert^2$, and noting $B^+$ preserves $\mathrm{span}(W)$ and $W^\perp\cap(\ker B)^\perp$ separately,

$$\langle b,B^+b\rangle=\langle\Pi b,B^+\Pi b\rangle-\tfrac2\theta\beta^2=\tfrac\theta2\lVert z\rVert^4-\tfrac2\theta\cdot\tfrac{\theta^2}4\lVert z\rVert^4=0 .$$

**So the record's headline value, read by the record's own definitions, asserts $0=\theta/2$ at $\theta>0$.**

**Argued the opposite.** The intended object is $b=\Pi(z\circ z)$, and the record's *consumers* use that reading: [second-order.md line 165](../findings/second-order.md) writes $\lVert z\circ z\rVert^2=\tfrac{\theta^2}4+\lVert b\rVert^2$, which is the Pythagorean split of $z\circ z$ with its $W$-component $\tfrac\theta2$ removed and its $A(\tfrac12)$-component killed by the fusion rule, that is $b=\Pi(z\circ z)$, not $z\circ z$. So the defect is localised to the conventions entry and to the block's phrase "it follows from $B(\Pi u)=b$"; the downstream corollary at lines 165–169 is safe. All three protocol conditions clear.

**Repair.** [conventions.md line 36](../findings/conventions.md) should read $b:=\Pi(z\circ z)$, the component of $z\circ z$ in $W^\perp$, which is also its component in $(\ker B)^\perp\cap W^\perp$ by the fusion rule. The fusion rule is then exactly the statement that $b\in\mathop{\mathrm{range}}B$, which is what makes $B^+b$ defined and $\langle Bw,w\rangle$ the same at every solution of $Bw=b$, and that is where the fusion rule is consumed in the fourth-order clause.

**Corrected, and verified on a witness.** With $b=\Pi(z\circ z)$ and the $\lVert z\rVert^4$ of §6 restored: $\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4$, and $f(w^\ast)=\tfrac34\cdot\tfrac\theta2\lVert z\rVert^4-\tfrac38\theta\lVert z\rVert^4=0$. ✔

## 9. The disputed clause, decided: statement C is right

**Statement A** ([results.md](../results.md), brief §A): "where $B\vert_{W^\perp}\succeq0$ the fourth-order supremum over correctors equals $0$ exactly."

**Statement C** ([second-order.md](../findings/second-order.md), brief §C): "the equality needs no positivity either … **$B\vert_{W^\perp}\succeq0$ licenses only the word *supremum***."

**C is right, and A is true but strictly weaker.** The mathematics separates them cleanly:

- The **value at the stationary corrector** is $f(\Pi u)=\tfrac34\langle Bu,u\rangle=0$. Every input to that is positivity-free: $B$ self-adjoint, $Bu=z\circ z$, $BW=-\tfrac\theta2W$, $\langle u,W\rangle=-\lVert z\rVert^2$, the fusion rule, and $\langle Bu,u\rangle=0$. No step consults the sign of $B\vert_{W^\perp}$.
- $f$ is a quadratic with leading part $-\tfrac34\langle Bw,w\rangle$ on $W^\perp$. It is **concave iff $B\vert_{W^\perp}\succeq0$**. Under concavity the stationary point is the global maximiser, so $\sup_{w\perp W}f=f(\Pi u)=0$ and the supremum is attained. Without it there is $w_0\in W^\perp$ with $\langle Bw_0,w_0\rangle<0$, and $f(\Pi u+sw_0)=-\tfrac34s^2\langle Bw_0,w_0\rangle\to+\infty$; the supremum is $+\infty$ and $\Pi u$ is a saddle.

So positivity is needed **for the word *supremum*, and for nothing else**, exactly C's claim. A is not false: under $B\vert_{W^\perp}\succeq0$ the supremum is indeed $0$. A simply states the weaker conditional consequence and omits the unconditional one, which is the whole point of the block. **[results.md](../results.md) should be brought to C's form.**

Note also that A and C differ in a second place the brief does not flag: A quantifies the fusion rule over $y\in A(\tfrac12)$ and D over $y\in\ker B$. These coincide, by §3, because $\theta\ne0$ forces $\ker B\perp W$.

## 10. The counterexample, checked in closed form

$P(x,y)=x^3+\tfrac32xy^2+\alpha y^3$ on $\mathbb R^2$, $W=(1,0)$.

**The symmetric tensor.** Matching coefficients, $T_{111}=1$, $T_{112}=0$, $T_{122}=\tfrac12$, $T_{222}=\alpha$.

**Criticality and $\theta$.** $(W\circ W)_i=T_{i11}$, so $W\circ W=(T_{111},T_{112})=(1,0)=W$. Hence $W$ is a unit critical point with $\theta=1>0$. ✔ (All of L51's hypotheses hold with $G$ trivial.)

**$B$.** $(L_W)_{ij}=T_{i1j}=\begin{pmatrix}1&0\\0&\tfrac12\end{pmatrix}$, so $B=\tfrac12\mathrm{Id}-L_W=\mathrm{diag}(-\tfrac12,0)$. Therefore $BW=-\tfrac12W=-\tfrac\theta2W$ ✔ and $B\vert_{W^\perp}=0\succeq0$ ✔, the claimed configuration, exactly.

**No local maximum at $\alpha\ne0$.** On the unit circle, $\cos^3s+\tfrac32\cos s\sin^2s=\cos s\,(1+\tfrac12\sin^2s)$, and

$$(1-\tfrac{s^2}2+\tfrac{s^4}{24})(1+\tfrac{s^2}2-\tfrac{s^4}6)=1+s^4\big(-\tfrac16-\tfrac14+\tfrac1{24}\big)+O(s^6)=1-\tfrac38s^4+O(s^6),$$

so $P(\cos s,\sin s)=1+\alpha s^3-\tfrac38s^4+O(s^5)$. At $\alpha\ne0$ the cubic term dominates near $s=0$ and changes sign, so $(1,0)$ is not a local maximum. ✔ At $\alpha=0$ it is one, and the leading term $-\tfrac38s^4$ is $-\tfrac38\theta\lVert z\rVert^4$ at $\lVert z\rVert=1$, an independent confirmation of §5's constant.

**Verdict on the counterexample: PROVEN.** $B\vert_{W^\perp}\succeq0$ is strictly weaker than local maximality.

**One scope note, which the block does not make.** The witness lives in $\mathbb R^2$ and refutes the *abstract* implication, which is the implication L51 states, so the "subfamily used in general" trap does not fire. It does **not** exhibit a $W\in\mathcal W_n$ with $B\vert_{W^\perp}\succeq0$ that fails to be a local maximum, and the block should not be read as claiming one, the separate table at [second-order.md line 173](../findings/second-order.md) is where the $\mathcal W_n$ points are handled.

## 11. A witness satisfying every hypothesis, where the written formula fails

The §10 counterexample has $G$ trivial, so $z=u=0$ and the orbit clauses are vacuous there. To exhibit the §6 and §8 defects against the *full* hypothesis set I construct a point with a genuine orbit, in exact arithmetic.

**The algebra.** $V=\{A\in\mathrm{Sym}(3,\mathbb R):\mathop{\mathrm{tr}}A=0\}$, $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$, $P(A)=\mathop{\mathrm{tr}}A^3$, $G=SO(3)$ acting by conjugation, compact ✔, orthogonal ✔, $P$-invariant ✔. Then $T(A,B,C)=\tfrac12\mathop{\mathrm{tr}}((AB+BA)C)$ and $A\circ B=\tfrac12(AB+BA)-\tfrac13\mathop{\mathrm{tr}}(AB)\mathrm{Id}$.

**The critical point.** $W=\tfrac1{\sqrt6}\mathrm{diag}(2,-1,-1)$, so $\lVert W\rVert^2=\tfrac16\cdot6=1$ ✔ and $W\circ W=\tfrac16\mathrm{diag}(4,1,1)-\tfrac13\mathrm{Id}=\mathrm{diag}(\tfrac13,-\tfrac16,-\tfrac16)=\tfrac1{\sqrt6}W$. So $\theta=\tfrac1{\sqrt6}>0$ ✔.

**The orbit data.** $X=E_{12}-E_{21}\in\mathfrak{so}(3)$, acting as $A\mapsto[X,A]$. Writing $c=\tfrac1{\sqrt6}$ and $W=c(3E_{11}-\mathrm{Id})$:

$$z=[X,W]=-3c(E_{12}+E_{21}),\qquad u=[X,z]=-6c(E_{11}-E_{22})=-\sqrt6\,\mathrm{diag}(1,-1,0).$$

**Every stated identity checks exactly.**

- $\lVert z\rVert^2=9c^2\cdot2=3$ and $\langle u,W\rangle=-6c^2(2+1)=-3$, so $\langle u,W\rangle=-\lVert z\rVert^2$ ✔.
- $L_Wz=-\tfrac{3c^2}2(E_{12}+E_{21})=\tfrac\theta2z$ ✔ (using $\theta=c$).
- $z\circ z=z^2-\tfrac13\mathop{\mathrm{tr}}(z^2)\mathrm{Id}=\tfrac32(E_{11}+E_{22})-\mathrm{Id}=\mathrm{diag}(\tfrac12,\tfrac12,-1)$; and $Bu=\tfrac\theta2u-L_Wu=\mathrm{diag}(-\tfrac12,\tfrac12,0)-\mathrm{diag}(-1,0,1)=\mathrm{diag}(\tfrac12,\tfrac12,-1)$. **$Bu=z\circ z$ ✔ exactly.**
- $\langle z\circ z,W\rangle=c(1-\tfrac12+1)=\tfrac{3c}2=\tfrac\theta2\lVert z\rVert^2$ ✔.
- $\langle Bu,u\rangle=\langle z\circ z,u\rangle=-6c(\tfrac12-\tfrac12)=0$ ✔, §7's missing identity, confirmed on the witness.
- $\Pi u=u+\lVert z\rVert^2W=\sqrt6\,\mathrm{diag}(0,\tfrac12,-\tfrac12)$, which is $\perp W$ ✔, and $B(\Pi u)=\mathrm{diag}(0,\tfrac14,-\tfrac14)-\mathrm{diag}(0,-\tfrac12,\tfrac12)=\mathrm{diag}(0,\tfrac34,-\tfrac34)=\Pi(z\circ z)$ ✔.

**Where the written statement fails.** $\langle b,B^+b\rangle$ with $b=\Pi(z\circ z)$ equals $\langle\Pi b,\Pi u\rangle=\sqrt6(\tfrac38+\tfrac38)=\tfrac{3\sqrt6}4$, while the block asserts $\theta/2=\tfrac1{2\sqrt6}$. The ratio is $9=\lVert z\rVert^4$, exactly as §6 predicts. Feeding the written constant into $f(\Pi u)$ gives

$$\tfrac34\cdot\tfrac{3\sqrt6}4-\tfrac38\cdot\tfrac1{\sqrt6}=\tfrac{9\sqrt6}{16}-\tfrac{\sqrt6}{16}=\tfrac{\sqrt6}2\ne0,$$

**a strictly positive $[t^4]$ at a point where $P$ is exactly constant along the orbit**, a flat contradiction with the block's own final sentence. With the corrected constant $-\tfrac38\theta\lVert z\rVert^4=-\tfrac{27}{8\sqrt6}=-\tfrac{9\sqrt6}{16}$ the value is $0$ ✔.

This is exact rational-plus-$\sqrt6$ arithmetic on $3\times3$ diagonal and single-off-diagonal matrices, done by hand. It is a witness, not a search.

## 12. "None of this uses maximality", checked step by step

| step | inputs | maximality? |
| --- | --- | --- |
| $Q$ equivariant | $P$ invariant, action orthogonal | no |
| $L_Wz=\tfrac\theta2z$ | one derivative of the equivariance | no |
| $z\perp W$ | $X$ skew | no |
| $Bu=z\circ z$ | two derivatives | no |
| fusion rule | $B$ self-adjoint | no |
| $T(z,z,z)=0$ | fusion at $y=z$ | no |
| $\ker B\perp W$, $A(\tfrac12)=\ker B$ | $\theta\ne0$ | no |
| the jet | polarisation and a binomial series | no |
| $B(\Pi u)=\Pi(z\circ z)$ | $BW=-\tfrac\theta2W$, $\langle u,W\rangle=-\lVert z\rVert^2$ | no |
| $\langle Bu,u\rangle=0$, hence value $0$ | $P$ constant along the orbit | no |
| $\sup=0$ rather than a stationary value | $B\vert_{W^\perp}\succeq0$, **assumed** | no, it is a hypothesis, not derived from maximality |

**PROVEN.** The last row is the only one that could have hidden maximality, and it does not: positivity is stated as a hypothesis, and §10 shows it is strictly weaker than maximality, so it cannot be smuggling maximality in either.

## 13. The guard, and what [fence-posts.md line 307](../findings/fence-posts.md) asserts as written

The clause reads: "$u$ is the **stationary point** of the concave quartic functional, so where $B\succeq0$ the fourth-order supremum equals $0$, i.e. $\langle b,B^+b\rangle=\theta/2$ exactly."

**As written, the conditional is vacuous.** $BW=-\tfrac\theta2W$ and $\theta>0$ give $\langle BW,W\rangle=-\tfrac\theta2<0$, so $B\succeq0$ holds at **no** critical point with $\theta>0$. The clause therefore asserts nothing about any object the programme contains: it is a true implication with an empty antecedent, and a reader taking it at face value will conclude the fourth-order supremum result is unavailable everywhere, the opposite of the block's actual content, which is that the *equality* is unconditional. **This is where the sign of $\theta$, as opposed to $\theta\ne0$, is genuinely consumed**: at $\theta<0$ the eigenvalue $-\tfrac\theta2$ is positive and the bare guard is not automatically empty.

[conventions.md line 35](../findings/conventions.md) already records the correction ("**$B\succeq0$ is only ever readable on $W^\perp$**") and [second-order.md line 147](../findings/second-order.md) already writes the restricted form. **Post F37 is the one live clause that was not brought along.** It should read $B\vert_{W^\perp}\succeq0$, and by §9 it should say *supremum* rather than the equality.

## 14. The "$u$ is the stationary point" discrepancy, withdrawn, and reclassified

[second-order.md line 147](../findings/second-order.md) and [fence-posts.md line 307](../findings/fence-posts.md) both say "$u$ is the **stationary point** of the concave quartic functional". The L51 block at line 201 says the stationarity condition is "**satisfied by $\Pi u$ and not by $u$**". That is a flat contradiction on its face, and I attempted to report it as a defect. **Arguing the opposite closes it, so it is withdrawn as a defect.**

Redoing §5 with the constraint $w\perp W$ dropped, writing $c=\langle W,w\rangle$: every occurrence of $\lVert z\rVert^2$ in the norm expansion becomes $\lVert z\rVert^2+c$, $p_2$ becomes $\tfrac{3\theta}2(\lVert z\rVert^2+c)$, and

$$[t^4]=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac38\theta(\lVert z\rVert^2+c)^2 .$$

Its unconstrained stationarity condition is $Bw=z\circ z-\tfrac\theta2(\lVert z\rVert^2+c)W$, and at $w=u$ we have $c=-\lVert z\rVert^2$, so the condition reads $Bu=z\circ z$, **which is exactly the block's own second identity.** So $u$ *is* the stationary point of the unrestricted functional, and $\Pi u$ *is* the stationary point of the functional restricted to $W^\perp$; the value is $0$ either way, since at $w=u$ the constant term vanishes and $[t^4]=\tfrac34\langle Bu,u\rangle=0$.

**The finding is therefore not an error but an undeclared domain.** The record states two incompatible-looking things because it never says which functional is meant, and the quadratic's domain is precisely what the block's emphatic "and not by $u$" turns on. Both files should name the domain. I note in passing that the unrestricted reading is the more natural one, $w=u$ is the orbit's actual acceleration and makes the stationarity condition literally the lemma's second identity, and that the restriction to $W^\perp$ costs nothing, the quadratic being flat along $W$ ($-\tfrac34\langle BW,W\rangle-\tfrac38\theta=\tfrac{3\theta}8-\tfrac{3\theta}8=0$), which is the radial gauge freedom of a $0$-homogeneous function.

## 15. The named traps, each answered

- **$\ker W\ne0$ and padded objects.** Does not fire. L51 treats $W$ as a *vector* in a Euclidean space and never as an operator; the only operator built from it is $L_W$, multiplication in the algebra, whose kernel is unrelated to $\ker W\subseteq\Lambda^2$. Padding a $\mathcal W_{n_0}$ point into $\mathcal W_n$ enlarges the isotropy and hence shrinks the orbit tangent, which weakens the *consequences* drawn elsewhere but leaves every identity here intact. The $\Pi$ in the block is projection onto $W^\perp$ **in the algebra**, sense (i) of [conventions.md line 34](../findings/conventions.md), not onto $\ker W$; the block does not say so and should.
- **Boundary of every stated range, and the smallest admissible dimension.** $\theta\to0$ is the live boundary and it breaks §3's $A(\tfrac12)=\ker B$, §8's $B^+$ on the $W$-line, and §13's guard; [second-order.md line 68](../findings/second-order.md) already carries the $\theta=0$ debt for L24 and the same debt reaches the fourth-order clause here. $z=0$ forces $u=X(XW)=0$ and every clause reads $0=0$, true and empty. $\dim V=1$ gives $W^\perp=0$ and the whole statement is vacuous. $G$ trivial likewise, which is exactly the §10 counterexample's situation, and is why it says nothing about the orbit clauses. In $\mathcal W_n$ the smallest admissible case is $n=4$, $\dim\mathcal W_4=10$; nothing in L51 is dimension-specific.
- **A claim proven on a subfamily and used in general.** The §10 counterexample is two-dimensional and is used to refute a universal implication, which is legitimate. It is *not* a $\mathcal W_n$ witness, and §10 records the scope note the block omits.
- **A hypothesis stated but never used.** **Compactness of $G$** (§1, §2), nowhere consumed. The *sign* of $\theta$, consumed only at §13's guard, not by any identity; the record already knows this at line 68.
- **A step using a hypothesis never stated.** **$\lVert z\rVert=1$** (§6), silently carried by the constant $-\tfrac{3\theta}8$ and the value $\theta/2$. This is the round's principal finding.
- **A universal claim with no witness.** "The extremal-idempotent calculus of Krasnov–Tkachev applies verbatim here" (§15 below); and "**None of this uses maximality**", which is universal over the argument's steps and which §12 discharges by exhausting them.
- **An imported theorem whose hypotheses were never checked.** The block's motivation names Krasnov–Tkachev and says the calculus "applies verbatim". The record's own [fence post at line 177](../findings/fence-posts.md) says the opposite for the sharpest results, "The Weyl algebra has no unit, which bars the sharpest extremal-idempotent theorems", and line 189 draws the line precisely: existence of extremal idempotents and the extremal spectral bound (this record's L24) survive without a unit; Tkachev's minimal-algebra characterisation does not. **The overstatement is inert for L51**, because the argument imports nothing, it differentiates the equivariance by hand, and line 209 already says the identity, the jet and the vacuity consequence are new. But "verbatim" should be scoped to Propositions 6.6 and 6.7, with a pointer to the non-unitality fence, or a later reader will take it as licence to import the barred results. Separately, the "critical points are idempotents" step is sound and unit-free: $W\circ W=\theta W$ makes $W/\theta$ idempotent, and the Peirce label $A(\tfrac12)$ is the $\tfrac12$-eigenspace of $L_{W/\theta}$, consistent with $L_Wz=\tfrac\theta2z$.
- **Symbol collisions.** $B$: sense (iii) of [conventions.md line 35](../findings/conventions.md), $\tfrac\theta2\mathrm{Id}-L_W$, distinct from the Killing form and from L48's partition scalar; the block never says which, though the definition is inline so no ambiguity survives a careful read. $b$: **the collision is live and load-bearing**, [conventions.md line 36](../findings/conventions.md) defines it as $z\circ z$, the consumers need $\Pi(z\circ z)$, and §8 shows the literal reading turns the headline value into $0$. $\Pi$: sense (i) of four; correct but undeclared in the block. $u$: the orbit acceleration here, while [fence-posts.md line 181](../findings/fence-posts.md) uses $u$ for a *candidate unit* of the algebra, twenty lines from the same discussion. $z$: the orbit tangent here, and the third slot of $T(x,y,z)$ in the same sentence of the statement, the definition "$\langle x\circ y,z\rangle=T(x,y,z)$" reuses the letter that the lemma then binds to $X\!\cdot\!W$. $A$: $A(\tfrac12)$ is always parenthesised, so it stays clear of L35's scalar $A=\lambda_1$.

## 16. What would falsify this, and what I did to look for it

**The object that would break the corrected statement:** a unit critical point $W$ of $P$ on the sphere in some Euclidean space, with $\theta\ne0$, an orthogonal Lie group action preserving $P$, and an $X$ in its Lie algebra, for which $\langle z\circ z,u\rangle\ne0$, equivalently, for which the fourth-order value at the stationary corrector is nonzero. Such an object would falsify §7's identity, and with it the words "equals $0$ exactly" in every copy of the block.

**What I did to look for it.** I attacked it structurally rather than by search, which is the only route open under the analysis-only rule. Two independent derivations both force $\langle Bu,u\rangle=0$ from hypotheses L51 already assumes, the vanishing fourth derivative of $P$ along the orbit (§7, first route), and the degeneracy $D^2g(W)z=0$ that $z\in\ker B$ supplies (§7, second route). Since both consume only $P$ constant along the orbit, $X$ skew, and $L_Wz=\tfrac\theta2z$, **no such object can exist under the stated hypotheses**, and the way to build one would be to break a hypothesis: a non-orthogonal action ($X$ not skew, so $\langle u,W\rangle\ne-\lVert z\rVert^2$ and $\Pi u$ stops solving the stationarity condition), or a $G$-action not preserving $P$ ($Q$ no longer equivariant, so neither identity holds). I then built the §11 witness in $\mathrm{Sym}_0(3)$ under $SO(3)$, the smallest non-degenerate instance where all of $G$, $z$, $u$, $\ker B$ and $\Pi$ are simultaneously nontrivial, and confirmed every identity exactly, including $\langle Bu,u\rangle=0$. That witness is also what falsifies the block **as written**, at claim 7 and claim 8.

**The object that would break the guard's necessity:** a critical point with $B\vert_{W^\perp}\not\succeq0$ at which the fourth-order supremum is nevertheless finite. None exists: §9 exhibits the ray $\Pi u+sw_0$ along which $f\to+\infty$ whenever a negative direction exists, in closed form.

**The object that would break §10:** a proof that $B\vert_{W^\perp}\succeq0$ implies local maximality. §10's $\alpha\ne0$ family refutes it in two dimensions with exact arithmetic.

---

## Verdict

**GAP.**

- The **central disputed clause is decided for statement C**: the fourth-order equality needs no positivity, $B\vert_{W^\perp}\succeq0$ licenses only the word *supremum*, and statement A in [results.md](../results.md) is true but strictly weaker and should be replaced by C's form.
- The **gap** is at "equals $0$ because $P$ is constant along the orbit": that step requires $\langle Bu,u\rangle=0$, an identity independent of the block's two, with no argument on file. It is true and two short routes close it; neither is written down.
- Two recorded quantities are **wrong as written**: the jet constant $-\tfrac{3\theta}8$ (should be $-\tfrac38\theta\lVert z\rVert^4$, or the block should restore the unit-norm hypothesis it carries at [line 135](../findings/second-order.md)), and $\langle b,B^+b\rangle=\theta/2$ (should be $\tfrac\theta2\lVert z\rVert^4$, and $b$ must be $\Pi(z\circ z)$, under [conventions.md line 36](../findings/conventions.md)'s literal $b:=z\circ z$ the left side is $0$).
- [fence-posts.md line 307](../findings/fence-posts.md)'s bare $B\succeq0$ is **vacuous** and should read $B\vert_{W^\perp}\succeq0$; the same clause should say *supremum*, per §9.

**CLOSED 2026-09-17: the gap this report found is filled, and the finding was right.** *$\langle Bu,u\rangle=0$ is an identity independent of the block's two, exactly as stated here, and it follows from the infinitesimal invariance of $T$ at $(z,z,z)$ with no criticality, no fourth derivative and no skew-adjointness.* **The current statement and its scope are at [L51](../findings/second-order.md)'s block, typed in [I53OrbitIdentity.lean](../lean/HamiltonsCubic/Results/I53OrbitIdentity.lean)**, Gate 2 passed on [r984](../reviews/REVIEW_r984.md) and [r985](../reviews/REVIEW_r985.md). *Left here as a pointer so a later cycle does not rediscover the gap from this page.*
- The "$u$ versus $\Pi u$" contradiction is **withdrawn**: both are stationary points, of the unrestricted and the $W^\perp$-restricted functional respectively, and the record never names the domain.
- Everything else, both identities, the fusion rule, $T(z,z,z)=0$, $[t^3]=T(z,z,z)$, the counterexample, and "None of this uses maximality", is **PROVEN**, and compactness of $G$ is a stated hypothesis that no step consumes.
