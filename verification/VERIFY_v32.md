# VERIFY v32, the candidate that L156's "$(\alpha,\gamma)$ half separates from $\sigma$" is itself false

*Adjudication of one candidate finding raised against [Lemma L156](../findings/second-order.md), decided from [L156](../findings/second-order.md) and [L157](../findings/second-order.md) alone. **No numerical work was done; every value below is an exact hand evaluation of a rational or closed-form quantity**, and the two decimal figures quoted from the record are quoted, not recomputed. Log: [agent_logs/verify-L156-C6-v32.log](../agent_logs/verify-L156-C6-v32.log).*

**VERDICT: UPHELD.** Every clause of the candidate is derivable from what is written. $\sigma$ is $\eta^*$ evaluated at $t=\lambda\sqrt{c_p+w^2}/(2C)$, and $C=C(\alpha,\gamma)$, so $\sigma$ is a function of $(\alpha,\gamma)$; the quantity the chain maximises is $\gamma\,\eta^*(t)$ rather than $1/J$; and at $\gamma=d/2$ the derivative of that quantity is $\frac{(\sqrt{4t+1}-1)^2}{\sqrt{4t+1}\,(\sqrt{4t+1}+1)}$, which is **strictly positive for every $t>0$**. What the candidate does not touch, and what §5 establishes survives intact, is $\alpha^*=D/2$, the equidistant contour of the lemma's own title.

## 1. What $t$ depends on

[L157](../findings/second-order.md) defines it inside the lemma box:

> *the two coupled branches are $\eta$ and $t(1-\eta)^2$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$*

**As written it contains $J$ and $\gamma$** (besides $\lambda$, $c_p$, $w$, none of which is a contour variable). **It contains neither $\alpha$ nor $C$ explicitly.** But [L156](../findings/second-order.md) defines the objective as $J=C/\gamma$, so $J\gamma=C$ identically, and

$$t=\frac{\lambda\sqrt{c_p+w^2}}{2J\gamma}=\frac{\lambda\sqrt{c_p+w^2}}{2\,C(\alpha,\gamma)},\qquad C(\alpha,\gamma)=\frac{\alpha(1+\alpha)}{d\,(d-\gamma)},\quad d=\min(\alpha,D-\alpha).$$

This is not my substitution: [L158](../findings/second-order.md)'s settled box states it in terms, *"$J\gamma=C$ makes [L157](../findings/second-order.md)'s $t=\lambda\sqrt{c_p+w^2}/(2C)$ **exact** rather than small-$t$"*, and settles against the doubt that the two $\gamma$'s might differ, on the ground that L156 names both in one hypothesis.

**The answer to the question as put.** $t$ is a function of **$C$ alone**, among the four. It is **not** a function of $\gamma$ alone, and it is not a function of $\alpha$ and $\gamma$ separately: it depends on the pair only through the single scalar $C(\alpha,\gamma)$. Since $C$ is a nonconstant function of $\gamma$, on the branch $\alpha\le D/2$ it is $(1+\alpha)/(\alpha-\gamma)$, strictly increasing in $\gamma$, $t$ is a strictly decreasing function of $\gamma$ at fixed $\alpha$, and $\sigma=\eta^*(t)$ is therefore a nonconstant function of $\gamma$. **That alone refutes "separates" in its literal sense.**

*One transcription defect in passing.* The bullet at [L156](../findings/second-order.md) writes the crossing as $t(1-\sigma)^2=\sigma$ with $t=\sqrt{c_p+w^2}/(2J\gamma)$, dropping the $\lambda$ that L157's own box carries. The sign results below hold for every $\lambda>0$, so nothing here turns on it, but the two lines should agree.

## 2. What the chain is actually maximising

The crossing condition is $\eta=t(1-\eta)^2$ with $\eta=r/\rho$, L157's own self-consistency condition, $\eta$ being the reach measured in units of the disc radius. So the quantity solved for, $\eta^*$, is the radius **in units of $\rho$**, and the radius itself is

$$r^*=\eta^*(t)\,\rho=\eta^*(t)\,\frac{\gamma\,g_n}{\lVert H\rVert_{op}} .$$

In the variables L157 holds fixed ($\lambda$, $c_p$, $w$, $g_n$, $\lVert H\rVert_{op}$), maximising the radius over the contour is therefore maximising

$$R(\alpha,\gamma):=\gamma\;\eta^*\!\Big(\frac{\lambda\sqrt{c_p+w^2}}{2\,C(\alpha,\gamma)}\Big).$$

**Minimising $J$ does not maximise this.** Using L157's exact identity at the crossing, $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$, the radius reads

$$R=\underbrace{\frac{\lambda\sqrt{c_p+w^2}}{2J}}_{\text{what }\min J\text{ maximises}}\cdot\;(1-\sigma)^2 .$$

So $\min_\gamma J$ maximises the first factor exactly, and the second factor moves against it: lowering $J$ at fixed $\gamma$ lowers $C$, raises $t$, raises $\sigma$, and lowers $(1-\sigma)^2$. **The two factors are the same trade-off written twice**, and $J$ is the right objective only if $(1-\sigma)^2$ is treated as a constant, which is the assumption the framing sentence makes and which §1 refutes.

**The trap is the units.** In units of $\rho$ the radius is $\eta^*$, which is maximised by making $t$ as large as possible, i.e. $\gamma\to0$; but then $\rho\to0$. The physical radius is the product, and only the product may be compared across values of $\gamma$.

## 3. The sign, derived

**Monotonicity of $\eta^*$, derived rather than assumed.** Put $u=\sqrt{4t+1}$, so $t=(u^2-1)/4$ and $u>1$ for $t>0$. Then

$$\eta^*=\frac{2t+1-\sqrt{4t+1}}{2t}=\frac{\tfrac{u^2-1}2+1-u}{\tfrac{u^2-1}2}=\frac{u^2-2u+1}{u^2-1}=\frac{(u-1)^2}{(u-1)(u+1)}=\frac{u-1}{u+1}=1-\frac2{u+1}.$$

The rationalised form is the record's own: [L158](../findings/second-order.md)'s box writes $1-\eta^*=2/(\sqrt{4t+1}+1)$. Since $u=\sqrt{4t+1}$ is strictly increasing on $t>0$ and $1-2/(u+1)$ is strictly increasing in $u$, **$\eta^*$ is strictly increasing in $t$**, with

$$\frac{\mathrm d\eta^*}{\mathrm du}=\frac2{(u+1)^2},\qquad \frac{\mathrm du}{\mathrm dt}=\frac2u,\qquad \eta^{*\prime}(t)=\frac4{u\,(u+1)^2}>0 .$$

Two checks that this is L157's root and not another. At $t=2$ the displayed formula gives $(4+1-3)/4=\tfrac12$, and $(u-1)/(u+1)=(3-1)/(3+1)=\tfrac12$; and $t(1-\eta)^2=2\cdot\tfrac14=\tfrac12=\eta$, so the crossing holds exactly there.

**The elasticity, which the record already contains.** From the two derivatives,

$$\frac{\mathrm d\log\eta^*}{\mathrm d\log t}=\frac{t\,\eta^{*\prime}}{\eta^*}=\frac{\tfrac{u^2-1}4\cdot\tfrac4{u(u+1)^2}}{\tfrac{u-1}{u+1}}=\frac1u=\frac1{\sqrt{4t+1}}\in(0,1).$$

This is verbatim the quantity [L158](../findings/second-order.md)'s dispute-settling box computes, $\mathrm d\log(K\sqrt{c_p+w^2})/\mathrm d\log s=1/\sqrt{4t+1}$, so the derivation is consistent with the record at a point the record derived independently.

**The sign at $\gamma=d/2$.** Fix $\alpha$ with $d=\min(\alpha,D-\alpha)$ and write $s=\sqrt{c_p+w^2}$. On the branch where $C=\dfrac{\alpha(1+\alpha)}{d(d-\gamma)}$,

$$t(\gamma)=\frac{\lambda s}{2C}=\frac{\lambda s\,d\,(d-\gamma)}{2\alpha(1+\alpha)}=\beta\,(d-\gamma),\qquad \beta:=\frac{\lambda s\,d}{2\alpha(1+\alpha)}>0,$$

so $t$ is linear and strictly decreasing in $\gamma$. Then $R(\gamma)=\gamma\,\eta^*(\beta(d-\gamma))$ and

$$\frac{\mathrm d\log R}{\mathrm d\log\gamma}=1+\frac{\mathrm d\log\eta^*}{\mathrm d\log t}\cdot\frac{\mathrm d\log t}{\mathrm d\log\gamma}=1-\frac1u\cdot\frac{\gamma}{d-\gamma}.$$

At $\gamma=d/2$ the last ratio is $1$, so

$$\boxed{\;\frac{\mathrm d\log R}{\mathrm d\log\gamma}\Big|_{\gamma=d/2}=1-\frac1u=\frac{u-1}u>0,\qquad \frac{\partial R}{\partial\gamma}\Big|_{\gamma=d/2}=\frac{(u-1)^2}{u\,(u+1)}>0\;}$$

for every $u>1$, that is **for every $t>0$**, vanishing only in the limit $t\to0$. Direct check of the second form: $R'=\eta^*-\gamma\beta\,\eta^{*\prime}$, and at $\gamma=d/2$ one has $\gamma\beta=\gamma t/(d-\gamma)=t=(u^2-1)/4$, so $R'=\frac{u-1}{u+1}-\frac{u^2-1}4\cdot\frac4{u(u+1)^2}=\frac{u-1}{u+1}-\frac{u-1}{u(u+1)}=\frac{(u-1)^2}{u(u+1)}$. At $t=2$ ($u=3$) both forms give $\tfrac13$.

**The point $\gamma=d/2$ is therefore not the maximiser of the radius; it is strictly on the rising flank.** The maximiser is the fixed point

$$\frac{\gamma^\dagger}{d-\gamma^\dagger}=\sqrt{4t(\gamma^\dagger)+1}\;>1\quad\Longrightarrow\quad \gamma^\dagger=\frac{u}{1+u}\,d\;>\;\frac d2 .$$

**A concrete closed-form failure.** Take $\beta d=8$. Then $\gamma^\dagger=3d/4$ is self-consistent: $t(\gamma^\dagger)=\beta d/4=2$, $u=3$, and $\gamma^\dagger/(d-\gamma^\dagger)=3=u$. There $\eta^*=\tfrac12$ and $R^\dagger=\tfrac{3d}4\cdot\tfrac12=\tfrac{3d}8$. At L156's $\gamma=d/2$: $t_0=\beta d/2=4$, $u_0=\sqrt{17}$, $\eta^*=\frac{\sqrt{17}-1}{\sqrt{17}+1}=\frac{9-\sqrt{17}}8$, so $R_0=\frac{d(9-\sqrt{17})}{16}$. Hence, exactly,

$$\frac{R^\dagger}{R_0}=\frac6{9-\sqrt{17}}=\frac{6(9+\sqrt{17})}{64}=\frac{3(9+\sqrt{17})}{32}\;>\;\frac{3\cdot13}{32}=\frac{39}{32}>1,$$

using only $\sqrt{17}>4$. **L156's $\gamma$ leaves better than a fifth of the radius on the table at that $t$.**

**And the size of the defect at programme values.** Expanding $\eta^*=t-2t^2+O(t^3)$ and writing $\gamma=xd$, $t=2t_0(1-x)$ with $t_0=t(d/2)$, the objective is $R=2dt_0\,f(x)+O(t_0^3)$ with $f(x)=x(1-x)\big(1-4t_0(1-x)\big)$. Then $f'(\tfrac12)=t_0>0$ (the same positive sign again), the maximiser sits at $x=\tfrac12+\tfrac{t_0}2$, and

$$f\big(\tfrac12+\tfrac{t_0}2\big)-f\big(\tfrac12\big)=\tfrac{t_0^2}4,\qquad \frac{R^\dagger-R_0}{R_0}=t_0^2+O(t_0^3).$$

**So the loss is second order in $t$, and it is in the safe direction**: $R_0<R^\dagger$, so every downstream statement of the form *"the radius is at least the value computed from $J^*$"* stays true. The defect costs sharpness, not soundness.

## 4. Whether the record already says this

The two sentences, quoted:

| where | text |
|---|---|
| [L157](../findings/second-order.md), closing | *"**And $\gamma$ does not cancel**; what is true is that $J$ is stationary at the optimum, so $J^*$ is right to $O(t^2)$."* |
| [L156](../findings/second-order.md), framing | *"**The $(\alpha,\gamma)$ half separates from $\sigma$**, so that half is the one-parameter problem L156 solves in closed form"* |

**They contradict each other on the strong reading, and L157's is the one that survives.** If $\gamma$ does not cancel from $t$, then $\sigma=\eta^*(t)$ is a nonconstant function of $\gamma$, and a variable common to both halves is exactly what "separates" denies. L157's sentence is also the derived one: it was written to withdraw the very claim L156's bullet makes two lines above the framing sentence, *"the branch-2/branch-3 crossing $t(1-\sigma)^2=\sigma$ … in which $\gamma$ cancels for small $t$, that … is what legitimises splitting the optimisation."* **The framing sentence at line 1439 is that withdrawn justification restated as a conclusion.**

L157's sentence also prices the damage correctly, and §3 confirms its order independently: $\gamma^\dagger-\tfrac d2=\tfrac{d\,t}2+O(t^2)$ is a first-order displacement, at which the stationary $J$ changes only by $O(t^2)$, and the radius, which is *not* stationary there, changes by the relative $t^2$ computed above.

**The most charitable reading the words support, and it is genuinely true.** "Separates" can be read as *"the $(\alpha,\gamma)$ optimisation is the leading-order problem, $\sigma$ entering only as a correction"*. Under it the sentence is correct: $R=\frac{\lambda s}{2J}\big(1-2t+O(t^2)\big)$, so at $t^0$ the radius is exactly $\lambda s/(2J)$ and maximising it *is* minimising $J$. Three things stop this reading from saving the sentence as written. It is not what the words say, "separates" is a statement about the variables, not about an order of approximation, and the sentence claims a closed-form solution of "that half" rather than of its leading term. It carries no error order, where L157's replacement carries one. And it makes L156's $\gamma^*$ an approximation whose error is never stated, while the entry presents $\gamma^*=D/4$ as an attained interior optimum.

*Two further places where the record already leans this way.* [L157](../findings/second-order.md) records that *"in L156 it is the **Cauchy radius $\gamma-r$**, not $\gamma$, that wants to be $d/2$"*, a second, independent coupling of the same $\gamma$ to the same reach. And [L158](../findings/second-order.md) both makes $t=\lambda s/(2C)$ exact and computes the elasticity $1/\sqrt{4t+1}$ that §3 turns into the sign. **The ingredients of this candidate were all on the record; only the conclusion was missing.**

## 5. What survives if the candidate stands

**A wrong framing around a half-correct optimisation.** Precisely:

- **$C(\alpha,\gamma)=\dfrac{\alpha(1+\alpha)}{d(d-\gamma)}$, $d=\min(\alpha,D-\alpha)$, is untouched.** It is a bound on $M$ and mentions no reach; the resolvent kink and the corollary's $\alpha\le D/2$ reduction to $\frac{1+\alpha}{\alpha-\gamma}$ stand as proved.
- **$\alpha^*=D/2$ survives exactly, and survives *for the radius*, not merely for $J$.** At fixed $\gamma$ the radius $R=\gamma\,\eta^*(\lambda s/2C)$ is strictly decreasing in $C$, since $\eta^*$ is increasing in $t$ and $t$ is decreasing in $C$. So the radius-maximising $\alpha$ is the $C$-minimising $\alpha$ at that $\gamma$, and $\partial_\alpha C$ has a $\gamma$-independent sign: on $\alpha\le D/2$, $\partial_\alpha\frac{1+\alpha}{\alpha-\gamma}=-\frac{1+\gamma}{(\alpha-\gamma)^2}<0$; on $\alpha\ge D/2$, $\frac{\alpha(1+\alpha)}{(D-\alpha)(D-\alpha-\gamma)}$ has an increasing numerator over a decreasing positive denominator. **Both branches run to $\alpha=D/2$ for every admissible $\gamma$, so the equidistant contour of the lemma's title is right under the corrected objective too.** The $\alpha$ half does separate from $\sigma$; the $\gamma$ half does not.
- **$\gamma^*=D/4$ retains exactly one correct meaning: it is $\arg\min_\gamma J$, and nothing more.** It is not the contour that maximises the tube radius. Its replacement is $\gamma^\dagger=\frac{u}{1+u}\,\frac D2$ with $u=\sqrt{4t(\gamma^\dagger)+1}$, an implicit but well-posed one-dimensional fixed point, strictly interior to $(\tfrac D4,\tfrac D2)$. The disc constraint $\gamma<1$ from L156 stays slack: at $m=6$, $d=\tfrac{11}{10}$, and $\gamma^\dagger<1\iff u<10\iff t<\tfrac{99}4$.
- **$C^*=\tfrac{42}{11}$, $J^*=\tfrac{4(1+\alpha^*)}{\alpha^{*2}}$ and the corollary's intervals $\tfrac{42}{11}\le C^*<4$, $6.9421\le J^*<8$ remain correct as evaluations at $(\tfrac D2,\tfrac D4)$**, and remain usable, because §3 shows the error runs the safe way: the true optimum gives a *larger* radius, so a lower bound on the radius derived from $J^*$ is still a lower bound. It loses relative $t^2$.
- **What falls is one sentence and one adjective.** The framing sentence's "separates", and the proof's "its minimum is **interior and attained**" insofar as that is read as the chain's optimum rather than as $J$'s.

**If the candidate stands, the record must change as follows.** Replace L156's *"The $(\alpha,\gamma)$ half separates from $\sigma$"* with the statement that $\sigma=\eta^*\big(\lambda\sqrt{c_p+w^2}/2C(\alpha,\gamma)\big)$, so that only the $\alpha$ half separates; restate the lemma's objective as the radius $\gamma\,\eta^*(t)$ with $J=C/\gamma$ named as its $t\to0$ surrogate; keep $\alpha^*=D/2$ with the one-line argument that it minimises $C$ at every fixed $\gamma$; and demote $\gamma^*=D/4$ to $\arg\min_\gamma J$, recording $\gamma^\dagger/(d-\gamma^\dagger)=\sqrt{4t+1}$ as the radius optimum, the relative loss $t^2+O(t^3)$, and the fact that the loss is in the conservative direction.
