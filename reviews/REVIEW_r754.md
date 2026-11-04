# Reviewer r754, L171, the inner maximisation's constants: $V(t)$, its two branches, and the claim that three constants are two

*Gate 2, on [BRIEF-g2-l171.md](BRIEF-g2-l171.md), read cold. **No numerical work was done**: every value below is exact rational or exact surd, derived by hand and confirmed by one exact-arithmetic screen of claims already formed (Python `fractions`, seconds, on objects constructed for the screen). The record's own provenance for the constants was read only after the mathematics of items 1–7 and 9–12 was settled, and only because item 8 asks what the record says. Log: [agent_logs/g2-l171-r754.log](../agent_logs/g2-l171-r754.log).*

| # | claim | verdict |
| --- | --- | --- |
| S | $V(t)=a$ for $t\le t^*$ and $\tfrac{a^2}{4\lambda t}+\lambda t$ for $t\ge t^*$, $t^*=\tfrac a{2\lambda}$, under $M_{W_1}q=0$ | **PROVEN, HYPOTHESES CORRECTED** ($t\ge0$ and $\lambda>0$ are needed and unstated; false without the first) |
| 1 | the maximiser lies in $\mathrm{span}\{\hat q,v\}$ | **NO ARGUMENT ON FILE, SUPPLIED HERE**, and it holds: $\mathbb Rq$ and $q^\perp$ are both $M_{W_1}$-invariant |
| 2 | a top eigenvector is orthogonal to $q$ | **CONFIRMED for $\lambda>0$, at any multiplicity; FALSE at $\lambda=0$** |
| 3 | $\langle M_{W_1}K,K\rangle=\lambda\sin^2\varphi$ | **CONFIRMED**; symmetry is used, and used exactly once, on $\langle M_{W_1}v,\hat q\rangle$ |
| 4 | the interior critical point of $f(c)=ac+t\lambda(1-c^2)$ is the maximum | **CONFIRMED ONLY FOR $t\lambda>0$**; for $t\lambda<0$ it is the minimum, and the page does not say |
| 5 | $c^*\le1\iff t\ge\tfrac a{2\lambda}$, and $f(1)=a$ below it | **CONFIRMED**, both halves |
| 6 | $\tfrac{a^2}{4\lambda}=\tfrac5{16}$, $t^*=\tfrac{\sqrt{30}}8$, and each pins $\lambda=\tfrac23$ | **CONFIRMED EXACTLY**, and the two pinnings agree; the pair also re-derives $a^2=\tfrac56$ |
| 7 | claim (a), the tangency is structural | **CONFIRMED**; $\min_t(\alpha/t+\beta t)=2\sqrt{\alpha\beta}=a$ at $t=\sqrt{\alpha/\beta}=t^*$, and the join is $C^1$ |
| 8 | claim (b), the mutual agreement is not evidence | **CONFIRMED ON THE RECORD'S PROVENANCE, AND OVERSTATED AS A GENERAL CLAIM**, the record derives $t^*$ from $(a,\lambda)$ and writes it as $\tfrac34\sqrt{\tfrac56}$, which is $\tfrac a{2\lambda}$ verbatim |
| 9 | claim (c), $c_0=1$ is a hypothesis the derivation uses | **CONFIRMED**; the use is at $A=\langle q,K\rangle$, one line, and it is the projection identity |
| 10 | "the record's three constants are two" | **CONFIRMED IN SUBSTANCE, LOOSE IN COUNT**, four numerals, two parameters, and one free parameter once $a$ is given |
| 11 | the edges: $\lambda=0,\lambda<0,a=0,t\le0,q=0,\dim\ker F_u=1$ | **$t<0$ REFUTES THE STATEMENT AS WRITTEN** (exhibited, exactly); $\lambda<0$ is vacuous; the rest are degenerate rather than wrong |

**Actionable summary.** Add $t\ge0$ and $\lambda>0$ to the statement, and add to the proof the one missing sentence, $M_{W_1}q=0$ plus symmetry makes both $\mathbb Rq$ and $q^\perp$ invariant, so for fixed $\langle q,K\rangle$ the free component may be replaced by the top eigenvector of $M_{W_1}|_{q^\perp}$, after which every displayed constant and both pinnings are exact and the lemma stands.

## 0. Conventions, fixed once

$H:=\ker F_u$, a finite-dimensional real inner-product space. $M:=M_{W_1}$, the symmetric operator on $H$ representing $K\mapsto T(W_1,K,K)$, so $B=\langle MK,K\rangle$. $q:=\Pi_HQ(W_1)\in H$, $a:=\lVert q\rVert$, and $\hat q:=q/a$ where $a>0$. $\lambda:=\lambda_{\max}(M)$, the top eigenvalue of $M$ on $H$. $v$ is a unit top eigenvector, $Mv=\lambda v$. $K$ ranges over the unit sphere of $H$, which is compact, so every maximum written below is attained.

$$V(t):=\max_{\lVert K\rVert=1}\big[\langle q,K\rangle+t\langle MK,K\rangle\big].$$

Throughout, "$M$ symmetric" means $\langle Mx,y\rangle=\langle x,My\rangle$ for $x,y\in H$; $M$ is the compression of the full-space operator to $H$, and nothing below is claimed about its behaviour off $H$.

## Hypothesis inventory

| hypothesis | stated? | used where |
| --- | --- | --- |
| $M$ symmetric on $H$ | yes | §2 ($q\perp\mathop{\mathrm{im}}M$), §1 ($q^\perp$ invariant), §3 (cross term), spectral theorem throughout |
| $Mq=0$ | yes | §1, §2, §3, and it is strictly stronger than the $\langle q,v\rangle=0$ the proof appears to want; see §1.3 |
| $H$ finite-dimensional, real | implicit | attainment of the maxima; spectral theorem |
| $K$ ranges over the unit sphere of $H$, that is, $c_0=1$ | as claim (c) | §9; the projection identity $\langle Q(W_1),K\rangle=\langle q,K\rangle$ |
| $\lambda>0$ | **no**, the proof says only $\lambda\ne0$ | §1, §2, §4; at $\lambda=0$ the frontier branch is undefined and $v$ need not be $\perp q$ |
| $t\ge0$ | **no** | §1 (the reduction), §4 (concavity); at $t<0$ the statement is false, §11.4 |
| $a>0$, equivalently $q\ne0$ | **no** | the normalisation $\hat q$; at $a=0$ the written proof cannot be formed though the displayed answer survives |
| $\dim H\ge2$ | **no** | the existence of $v\perp q$; implied by $\lambda>0$ together with $Mq=0$, $q\ne0$ |
| $a=\sqrt{5/6}$ (Lemma L101) | yes | §6 only, the general statement is free of it |
| $\lambda=\tfrac23$ | yes, flagged underived | §6 only; the lemma does not derive it and does not claim to |
| $W_1\in V_{1/3}$, $\theta^*=\sqrt{3/2}$, $T$ trilinear symmetric | yes | **unused** in the algebra; they define $q$, $M$ and $t$ upstream and enter nowhere in the maximisation |
| $M_{W_1}q=0$ measured at $n=12,14,16$ | yes | provenance, not a hypothesis of the algebra; the algebra is dimension-free |

## 1. The plane ansatz, the step the lemma rests on, and it has no argument on the page

**What the page does.** It writes "a top eigenvector $v$ … is orthogonal to $q$. Write a unit $K=\cos\varphi\,\hat q+\sin\varphi\,v$" and proceeds. A unit $K\in H$ has, in general, components orthogonal to both $\hat q$ and $v$; nothing on the page rules them out. **So the reduction to the plane is asserted by choosing coordinates, and this is the one step of the lemma that carries real content.** The brief asks for the argument or its refutation; the argument exists, is two lines, and is below.

**1.1 The two-block decomposition.** $Mq=0$ gives that $\mathbb Rq$ is $M$-invariant. Symmetry gives that $q^\perp\cap H$ is too: for $x\perp q$, $\langle Mx,q\rangle=\langle x,Mq\rangle=0$. So $H=\mathbb Rq\oplus(q^\perp\cap H)$ is an orthogonal decomposition into $M$-invariant blocks, and

$$\mathop{\mathrm{spec}}(M)=\{0\}\cup\mathop{\mathrm{spec}}\big(M|_{q^\perp}\big),\qquad\text{hence}\qquad \lambda=\max\big(0,\ \lambda_{\max}(M|_{q^\perp})\big).$$

In particular $\lambda\ge0$ **automatically**, whenever $q\ne0$, a fact the page does not use and which repairs its "$\lambda\ne0$" into the "$\lambda>0$" it needs (§11.2).

**1.2 The reduction.** Let $\lVert K\rVert=1$ and write $K=c\,\hat q+s\,w$ with $c=\langle K,\hat q\rangle\in[-1,1]$, $s=\sqrt{1-c^2}\ge0$ and $w$ a unit vector in $q^\perp\cap H$ (when $s=0$ take any such $w$). Then $\langle q,K\rangle=ac$, and since $M\hat q=0$ and $M$ is symmetric,

$$\langle MK,K\rangle=c^2\underbrace{\langle M\hat q,\hat q\rangle}_{0}+cs\big(\underbrace{\langle M\hat q,w\rangle}_{0}+\underbrace{\langle Mw,\hat q\rangle}_{0}\big)+s^2\langle Mw,w\rangle=s^2\langle Mw,w\rangle .$$

**For $t\ge0$**, $ts^2\ge0$, so $\langle q,K\rangle+t\langle MK,K\rangle=ac+ts^2\langle Mw,w\rangle\le ac+ts^2\lambda_{\max}(M|_{q^\perp})$, with equality at $w=v$ any top eigenvector of the restricted block. Under $\lambda>0$ that restricted top eigenvalue **is** $\lambda$ (by §1.1), and $v\perp q$. Hence the maximum over the whole sphere is attained inside $\mathrm{span}\{\hat q,v\}$ and

$$V(t)=\max_{c\in[-1,1]}\big[ac+t\lambda(1-c^2)\big]=\max_{c\in[-1,1]}f(c),$$

which is the page's one-variable problem. **The reduction is valid; it is missing from the page.**

**1.3 What the hypothesis actually buys, and why the weaker reading fails.** The step needs $Mq=0$, not merely $\langle q,v\rangle=0$. With $q$ orthogonal to the top eigenspace but $Mq\ne0$, the expansion above retains $c^2\langle M\hat q,\hat q\rangle$ and $2cs\langle M\hat q,w\rangle$; the optimal $w$ then depends on $c$ and the maximiser leaves the plane in general. This is precisely the distinction between the classical trust-region hard case, where $q\perp$ the extreme eigenspace and the solution is $(M-\mu I)^\dagger q$ plus a multiple of $v$, generally outside any fixed $2$-plane, and the present, stronger, situation. The record's "hard-case trust-region problem" label in [Observation L22](../findings/route-a.md) is the right label, and the plane is a bonus of $Mq=0$ over the hard case rather than a feature of it.

**Argued the opposite.** The strongest reading of the page is that "$K=\cos\varphi\,\hat q+\sin\varphi\,v$" is shorthand for "by §1.1–§1.2 the maximiser may be taken of this form". That reading is available to a reader who already knows the reduction, and the conclusion is unaffected. It is still an elision of the only non-mechanical step, and it silently consumes $t\ge0$.

## 2. The hard-case hypothesis, and orthogonality of the top eigenvector

**Restricted how, exactly.** $Mq=0$ with $M$ symmetric gives $\langle q,Mx\rangle=\langle Mq,x\rangle=0$ for every $x\in H$, so **$q\perp\mathop{\mathrm{im}}(M)$ as an operator on $H$**, the compression's image, entirely. Nothing is asserted about the image of the ambient operator before compression, and nothing needs to be.

**Top eigenvector, $\lambda>0$.** If $Mv=\lambda v$ with $\lambda\ne0$ then $v=M(v/\lambda)\in\mathop{\mathrm{im}}M$, hence $\langle q,v\rangle=0$. **Multiplicity is irrelevant**: the argument applies to every vector of the $\lambda$-eigenspace, so the whole eigenspace is $\perp q$, and §1.2's maximum is attained at any unit vector of it, with the same value $\lambda$. So multiplicity $>1$ changes the set of maximisers and not $V$.

**$\lambda=0$: the claim fails.** Then $q$ is itself a top eigenvector ($Mq=0\cdot q$) and is not orthogonal to itself. The sentence "a top eigenvector is orthogonal to $q$" is false at $\lambda=0$, and the proof's own guard "$\lambda\ne0$" is exactly what excludes it, correctly, but for the wrong stated reason, since what is needed downstream is the sign, not the non-vanishing (§4). Under $q\ne0$ the two coincide by §1.1.

## 3. The cross term

Both vanishings are needed, and both follow:

- $\langle M\hat q,\hat q\rangle=0$, immediate from $M\hat q=0$, **no symmetry used**.
- $\langle M\hat q,v\rangle=0$, immediate from $M\hat q=0$, **no symmetry used**.

**Where symmetry is genuinely used in the cross term.** For a general (non-symmetric) $M$ the polarisation of $K\mapsto\langle MK,K\rangle$ carries the coefficient $\langle M\hat q,v\rangle+\langle Mv,\hat q\rangle$ on $\sin\varphi\cos\varphi$. The first summand dies on $M\hat q=0$; **the second dies only by symmetry**, $\langle Mv,\hat q\rangle=\langle v,M\hat q\rangle=0$. So symmetry is used exactly once here, and the page's phrase "the $\hat q$ term vanishing and the cross term with it" conflates a consequence of $M\hat q=0$ with a consequence of symmetry. Symmetry is used three further times: the invariance of $q^\perp$ (§1.1), the spectral theorem behind "$\lambda$ its top eigenvalue" and $\langle Mw,w\rangle\le\lambda$ (§1.2), and $q\perp\mathop{\mathrm{im}}M$ (§2). Note also that $B=T(W_1,K,K)$ reads only the symmetric part of any representing operator, so symmetry of $M$ is a normalisation available for free from $T$'s symmetry rather than an extra assumption.

Given all four vanishings, $\langle MK,K\rangle=\sin^2\varphi\,\langle Mv,v\rangle=\lambda\sin^2\varphi$ with $\lVert v\rVert=1$. **Confirmed.**

## 4. The one-variable maximisation, done independently

$f(c)=ac+t\lambda(1-c^2)$ on $[-1,1]$; $f'(c)=a-2t\lambda c$; $f''(c)=-2t\lambda$, constant.

| sign of $t\lambda$ | shape | maximiser | value |
| --- | --- | --- | --- |
| $t\lambda>0$ | strictly concave | $c^*=\dfrac a{2t\lambda}$ if $c^*\le1$, else $c=1$ | $\dfrac{a^2}{4\lambda t}+\lambda t$, else $a$ |
| $t\lambda=0$ | affine, $f(c)=ac$ | $c=1$ (for $a>0$) | $a$ |
| $t\lambda<0$ | strictly **convex** | endpoint, $c=1$ against $c=-1$ | $\max(a,-a)=a$ for $a\ge0$; **the interior point is the minimum** |

**So the interior critical point is a maximum precisely when $t\lambda>0$, and the proof does not say so.** The value at $c^*$, computed independently:

$$f(c^*)=\frac{a^2}{2t\lambda}+t\lambda-t\lambda\cdot\frac{a^2}{4t^2\lambda^2}=\frac{a^2}{2t\lambda}-\frac{a^2}{4t\lambda}+\lambda t=\frac{a^2}{4\lambda t}+\lambda t,$$

matching the display. $c^*\ge-1$ holds automatically when $t\lambda>0$ and $a\ge0$, so only the upper constraint binds.

**Argued the opposite.** In the intended regime $\lambda=\tfrac23>0$ and $t=s/\cos\beta\ge0$, so $t\lambda>0$ and the omission costs nothing there. It costs everything off that regime, which is §11.4.

## 5. The admissibility threshold and the constant branch

With $t>0$, $\lambda>0$, $a>0$: $c^*\le1\iff\dfrac a{2t\lambda}\le1\iff a\le2t\lambda\iff t\ge\dfrac a{2\lambda}=t^*$, the multiplications being by the positive quantities $2t\lambda$ and $2\lambda$. **Confirmed**, and the equivalence is genuine rather than one-directional.

For $t<t^*$: $f'(c)=a-2t\lambda c\ge a-2t\lambda>a-2t^*\lambda=0$ for all $c\le1$, so $f$ is strictly increasing on $[-1,1]$ and the maximum is at $c=1$, where $f(1)=a\cdot1+t\lambda(1-1)=a$. **Confirmed**, and $c=1$ is realisable ($\varphi=0$, $K=\hat q$, $B=0$).

**Consistency at the join.** At $t=t^*=\tfrac a{2\lambda}$ the frontier expression gives $\dfrac{a^2}{4\lambda}\cdot\dfrac{2\lambda}a+\lambda\cdot\dfrac a{2\lambda}=\dfrac a2+\dfrac a2=a$, so the two branches agree there and the case split may be written with $\le$ or $<$ indifferently, as the statement does. Two further structural checks pass: $V(t)\ge f(1)=a$ for every $t\ge0$, and $V$ is convex on $t\ge0$, being a pointwise maximum of affine functions of $t$, the displayed piecewise function is convex and $C^1$, consistent with both.

## 6. The two pinnings, exact

At $a^2=\tfrac56$, $\lambda=\tfrac23$:

$$\frac{a^2}{4\lambda}=\frac{5/6}{8/3}=\frac{5}{6}\cdot\frac38=\frac{15}{48}=\frac5{16},\qquad t^*=\frac a{2\lambda}=\frac{\sqrt{5/6}}{4/3}=\frac34\sqrt{\frac56}=\frac34\cdot\frac{\sqrt{30}}6=\frac{\sqrt{30}}8 .$$

Squared, $t^{*2}=\dfrac{a^2}{4\lambda^2}=\dfrac{5/6}{16/9}=\dfrac{15}{32}=\dfrac{30}{64}=\left(\dfrac{\sqrt{30}}8\right)^2$. Both **confirmed exactly**; both agree with [L171.lean](../lean/HamiltonsCubic/Results/L171.lean)'s `frontier_coefficient`, `branch_point_squared` and `root_thirty_over_eight`, which I read after deriving them.

**Each pins $\lambda$ independently, given $a^2=\tfrac56$.**

- From $\dfrac{a^2}{4\lambda}=\dfrac5{16}$: $\lambda=\dfrac{a^2}{4}\cdot\dfrac{16}{5}=\dfrac{4a^2}{5}=\dfrac45\cdot\dfrac56=\dfrac23$.
- From $t^*=\dfrac a{2\lambda}=\dfrac{\sqrt{30}}8$: $\lambda=\dfrac a{2t^*}=\dfrac{\sqrt{30}/6}{\sqrt{30}/4}=\dfrac46=\dfrac23$, using $a=\sqrt{5/6}=\sqrt{30}/6$ and $2t^*=\sqrt{30}/4$.

**They agree, and the agreement is not an artefact of assuming $a$.** The map $(a,\lambda)\mapsto(\alpha,\tau):=\big(\tfrac{a^2}{4\lambda},\tfrac a{2\lambda}\big)$ is invertible on $a,\lambda>0$, with $a=2\alpha/\tau$ and $\lambda=a/(2\tau)=\alpha/\tau^2$. Feeding the record's own pair in:

$$a=2\cdot\frac5{16}\cdot\frac8{\sqrt{30}}=\frac5{\sqrt{30}}=\sqrt{\frac5 6},\qquad \lambda=\frac{5/16}{15/32}=\frac{5}{16}\cdot\frac{32}{15}=\frac23 .$$

So $\left(\tfrac5{16},\tfrac{\sqrt{30}}8\right)$ recovers **both** $a^2=\tfrac56$ and $\lambda=\tfrac23$, exactly. Screened in exact rational arithmetic alongside the record's own spot values: at $t=\tfrac34$ the parametrisation returns $A=a^2/(2t\lambda)=\tfrac56$ and $B=\lambda(1-c^{*2})=\tfrac19$, and at $t=\tfrac9{10}$ it returns $A=\tfrac{25}{36}$ and $B=\tfrac{91}{324}=0.280864\ldots$, the two pairs [Observation L22](../findings/route-a.md) displays, reproduced to the last digit it prints. That is a screen of the parametrisation, not evidence for $\lambda$.

**No algebraic slip found.** The one place a slip could have manufactured an agreement is the $\tfrac34$ in $t^*=\tfrac34\sqrt{\tfrac56}$, which is $\tfrac1{2\lambda}$; it is right.

## 7. Claim (a), the tangency is structural

For $\alpha,\beta>0$ and $t>0$, $g(t)=\alpha/t+\beta t$ has $g'(t)=\beta-\alpha/t^2$, vanishing at $t=\sqrt{\alpha/\beta}$, with $g''=2\alpha/t^3>0$, so that point is the minimum, of value $\alpha\sqrt{\beta/\alpha}+\beta\sqrt{\alpha/\beta}=2\sqrt{\alpha\beta}$. Here $\alpha=\dfrac{a^2}{4\lambda}>0$ and $\beta=\lambda>0$, so

$$\sqrt{\alpha/\beta}=\sqrt{\frac{a^2}{4\lambda^2}}=\frac a{2\lambda}=t^*,\qquad 2\sqrt{\alpha\beta}=2\sqrt{\frac{a^2}4}=a .$$

**Confirmed, signs included**; both roots are taken positive because $a>0$ and $\lambda>0$, which is where the corrected hypotheses earn their place. The consequence is that $V$ joins its branches with matching value **and** matching derivative (both zero at $t^*$), so the kink is absent and $V\in C^1$, the tangency is a theorem about $\alpha/t+\beta t$, not a coincidence of the fitted numbers. This also reproduces the record's own remark at [Observation L22](../findings/route-a.md) that $V$ is neither the min nor the max of its two branches: the frontier expression exceeds $a$ on both sides of $t^*$, and $V$ follows it only above.

## 8. Claim (b), the epistemics, and what the record actually says

**The general assertion is too strong.** If $\tfrac5{16}$ and $\tfrac{\sqrt{30}}8$ had been obtained *separately* (each fitted from the maximisation's output rather than assembled from one $\lambda$), their agreement would carry exactly one real number of information, namely the §6 inversion $a=2\alpha/\tau=\sqrt{5/6}$, and that number would coincide with [Lemma L101](../findings/route-a.md)'s independently derived $a$. **That is evidence**, and it is the reason the lemma cannot end the question by algebra alone: the answer turns on provenance.

**What the record does.** [Observation L22](../findings/route-a.md) says, in its own words, that *"the two suprema $\sqrt{5/6}$ and $\tfrac23$ were measured at $n=10$"*, so the measured quantities are $a$ and $\lambda$, and the display is downstream of them. Two things confirm it:

- the record writes the branch point as $t^*=\tfrac34\sqrt{\tfrac56}$, which is **literally** $\tfrac1{2\lambda}\cdot a$ at $\lambda=\tfrac23$, the assembly is visible in the notation;
- [Observation L22](../findings/route-a.md)'s own re-derivation paragraph runs the tangency in the direction $\left(\tfrac5{16},\tfrac23\right)\Rightarrow t^{*2}=\tfrac{15}{32}$, deriving the branch point from the coefficients rather than measuring it.

**So on the record, claim (b) is right**: the three constants are one measurement of $\lambda$ dressed three ways, and their agreement is arithmetic. **The claim should be stated with its condition**, since it is a claim about provenance and not about the algebra: *given that the record assembles $\tfrac5{16}$ and $t^*$ from a single measured $\lambda$, their agreement is arithmetic rather than evidence*. What the record does carry as independent support for the pair $(a,\lambda)$ is elsewhere and is not this: the three-optimiser agreement on $V$ itself to $10^{-15}$, which tests the pair jointly.

## 9. Claim (c), where $c_0=1$ is used

**It is used, and the use is locatable to one line.** $A=T(W_1,W_1,K)=\langle Q(W_1),K\rangle$, and the step $\langle Q(W_1),K\rangle=\langle\Pi_HQ(W_1),K\rangle=\langle q,K\rangle$ is valid **because $K\in H=\ker F_u$**, an orthogonal projection may be inserted against a vector of the subspace and against no other. The whole display $A+tB$ with $A=\langle q,K\rangle$, $B=\langle MK,K\rangle$ therefore presumes the maximiser's second component lies in $\ker F_u$, which is what $c_0=1$ asserts. Everything after that (§1's two-block decomposition, $M$'s symmetry on $H$, the sphere the maximum runs over), is a statement about $H$.

**With a component $N$ in the non-positive part**, $W_2=K+N$: $A$ gains $\langle Q(W_1),N\rangle$, and $B$ gains $2T(W_1,K,N)+T(W_1,N,N)$, so the objective becomes a form on $H\oplus\langle N\rangle$ with cross terms coupling the two, and the hypothesis $Mq=0$ says nothing about them. **So claim (c)'s substance is right.** Its wording *"neither the reduction nor the closed form survives"* is one degree stronger than what is shown: the honest statement is that the reduction and the closed form are no longer **derivable from $Mq=0$ and $\lambda$ alone**, since the enlarged problem carries a coupling those two hypotheses do not constrain. Whether some other closed form exists there is open and is not addressed either way. The record's own note that $\sup T(W_1,N,N)=\sqrt{2/3}>\tfrac23$ is the force against $c_0=1$ and sits in [Observation L22](../findings/route-a.md), not here.

## 10. "Three constants are two", the count

The display carries **four** numerals: $\sqrt{5/6}$ (the constant branch), $\tfrac5{16}$ and $\tfrac23$ (the frontier's two coefficients), and $\tfrac{\sqrt{30}}8$ (the branch point). The lemma exhibits all four as functions of the **two** parameters $(a,\lambda)$; and since $a$ is derived independently at [Lemma L101](../findings/route-a.md), **one** free parameter remains. So the sharp statement is "four are one, given $a$", or "four are two" unconditionally. "Three are two" is the right direction with a loose count, presumably reading the three as $\{\tfrac5{16},\tfrac23,\tfrac{\sqrt{30}}8\}$ and the two as $(a,\lambda)$, which mismatches the two lists. The substance (that the constants are not independent), is confirmed.

## 11. The edges

**11.1 $\lambda=0$.** Then $M\preceq0$ on $H$ and $q$ is a top eigenvector, so §2's orthogonality claim fails. $t^*=a/(2\lambda)$ is undefined (formally $+\infty$) and the frontier expression is undefined. The true value for $t\ge0$ is $V(t)=a$ for all $t$, attained at $K=\hat q$, which is the limit of the constant branch as $t^*\to\infty$, so the statement degrades gracefully but must be read with $\lambda>0$ to be well-formed.

**11.2 $\lambda<0$.** **Vacuous under the hypotheses**: with $q\ne0$, the Rayleigh quotient at $\hat q$ is $\langle M\hat q,\hat q\rangle=0$, so $\lambda\ge0$. This is the fact that upgrades the proof's stated "$\lambda\ne0$" into the "$\lambda>0$" it uses, and it is not on the page.

**11.3 $a=0$, equivalently $q=0$.** $\hat q$ is undefined and the written proof cannot be formed. The displayed answer nonetheless holds: $t^*=0$, and for $t\ge0$ the frontier expression reads $0+\lambda t$, which is $\max_K t\langle MK,K\rangle=t\lambda$. The hypothesis $Mq=0$ is vacuous here, and $\lambda$ may then have either sign with the formula still correct.

**11.4 $t<0$, the statement as written is false.** The case split reads "$t\le t^*$, $V=a$", and $t^*>0$, so every negative $t$ falls in the constant branch. It does not belong there. **Exhibited exactly**: take $H=\mathbb R^3$, $M=\mathop{\mathrm{diag}}(0,\tfrac23,-1)$, $q=(a,0,0)$ with $a=\sqrt{5/6}$. Then $M$ is symmetric, $Mq=0$, $\lambda=\lambda_{\max}(M)=\tfrac23$ and $t^*=\tfrac{\sqrt{30}}8$, every hypothesis of the statement holds. At $t=-2$, take $K=(c,0,\sqrt{1-c^2})$: the objective is $ac+(-2)(-1)(1-c^2)=ac+2-2c^2$, maximised at $c=a/4$ with value $2+\tfrac{a^2}8=2+\tfrac5{48}=\tfrac{101}{48}=2.10416\overline6$, against the claimed $V(-2)=a=\sqrt{5/6}=0.91287\ldots$. **The gap is a factor of $2.3$, and it is exact.** The cause is §1.2 and §4: for $t<0$ the free component is chosen to make $\langle Mw,w\rangle$ as *negative* as possible, so the relevant spectral quantity is $\min_{w\perp q}\langle Mw,w\rangle$, not $\lambda$. **Repair: state $t\ge0$.** The application supplies it ($t=\sigma/c$ with $\sigma,c\ge0$), so nothing downstream moves.

**11.5 $t=0$.** $V(0)=\max_{\lVert K\rVert=1}\langle q,K\rangle=a$, matching the constant branch, and $0<t^*$ whenever $a>0,\lambda>0$, so the case split assigns it correctly. The frontier expression is singular at $t=0$, which is why the split cannot be written the other way round.

**11.6 $\dim\ker F_u=1$.** With $q\ne0$, $H=\mathbb Rq$ and $Mq=0$ forces $M=0$, hence $\lambda=0$ (so this collapses into §11.1); no $v\perp q$ exists and the ansatz cannot be formed. **$\lambda>0$ implies $\dim H\ge2$**, so the corrected hypothesis covers this case rather than leaving it to be checked.

**11.7 Multiplicity of $\lambda$ greater than one.** Harmless, §2: the entire $\lambda$-eigenspace lies in $q^\perp$, the maximiser set grows to a sphere within $\mathrm{span}\{\hat q\}\oplus E_\lambda$, and $V$ is unchanged.

## 12. What would break it

| break | what it would cost |
| --- | --- |
| **$M_{W_1}q\ne0$ at some $n$**, measured at $n=12,14,16$ only, per [Observation L102](../findings/route-a.md) | the cross term $2cs\langle M\hat q,w\rangle$ returns, the optimal $w$ becomes $c$-dependent, the maximiser leaves the plane (§1.3), and the closed form goes with it. The three constants would then be free to be independent again, and claim (b) with them. **This is the largest exposure and it is a measurement, not a theorem.** |
| **$c_0<1$**, any component of $W_2$ outside $\ker F_u$ | §9: the projection identity fails at the first line and the problem is no longer a maximisation over the sphere of $\ker F_u$ |
| **$t<0$ in the application** | §11.4, exactly and by a factor of $2.3$ in the exhibited instance; excluded by $t=\sigma/c\ge0$ upstream, which should be said |
| **$\lambda=0$** | §11.1: the frontier branch is undefined and §2's orthogonality fails |
| **$a$ other than $\sqrt{5/6}$** | the two pinnings would return different $\lambda$; equivalently, by §6, the pair $\left(\tfrac5{16},\tfrac{\sqrt{30}}8\right)$ forces $a=\sqrt{5/6}$, so a different $a$ would show up as a disagreement here rather than passing silently |
| **$M$ not symmetric on $\ker F_u$** | §3's second vanishing, §1.1's invariance of $q^\perp$, and the spectral theorem all fail together; harmless in fact, since $T$'s symmetry supplies it |

## Overall verdict

**PROVEN, hypotheses corrected.**

The closed form for $V(t)$, the branch point $t^*=\tfrac a{2\lambda}$, the structural tangency, and both pinnings of $\lambda=\tfrac23$ are correct and exact. Three corrections are owed to the page:

1. **$t\ge0$** must be stated; the statement is false for $t$ sufficiently negative, exhibited exactly in §11.4.
2. **$\lambda>0$** must replace "$\lambda\ne0$", with the half-line that $Mq=0$ and $q\ne0$ give $\lambda\ge0$ for free (§11.2), so the replacement costs nothing.
3. **The plane reduction must be written down** (§1.2). It is two lines from the hypotheses already stated, but as the page stands the only step with content is asserted by choice of coordinates.

Claim (a) is confirmed. Claim (b) is confirmed **on the record's provenance** and should be stated with that condition, since as an unconditional epistemic principle it is false, separately obtained constants would agree only up to one real number of coincidence, and that number re-derives $a=\sqrt{5/6}$ (§6, §8). Claim (c) is confirmed in substance, with *"neither survives"* weakened to *"neither is derivable from $Mq=0$ and $\lambda$ alone"* (§9). The count "three constants are two" is loose, four numerals, two parameters, one free once $a$ is given (§10). **The lemma does not derive $\lambda=\tfrac23$ and does not claim to; that debt is unchanged by this review.**
