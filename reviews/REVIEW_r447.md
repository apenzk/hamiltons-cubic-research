# Review r447, adversarial audit of ingredient (2) of [I2](../plan.md), the radius of analyticity and the tube radius

*Reviewer r447, 2026-09-03, cold adversarial brief. Target: the four-step chain of [I2](../plan.md) ingredient (2), the two-valued spectrum and gap $g_n$, the analyticity of $W\mapsto W_-$, the Cauchy estimate on the defect's third derivative, and the tube radius $r_n$. Read in full: the [I2](../plan.md) item, [findings/conventions.md](../findings/conventions.md), [Lemma L133](../findings/second-order.md), [Lemma L141](../findings/second-order.md), [Lemma L120](../findings/second-order.md), [post F60](../findings/second-order.md), [Lemma L143](../findings/bounds.md), [REVIEW_r442.md](REVIEW_r442.md), [REVIEW_r443.md](REVIEW_r443.md). **Analysis only**, every derivation below is by hand; one numerical screen re-evaluates closed forms I had already derived and is reported as a screen and is evidence for nothing. Working: [agent_logs/r447-I2-ingredient2.log](../agent_logs/r447-I2-ingredient2.log).*

## Verdicts, per numbered step

| step | claim | verdict |
| --- | --- | --- |
| **1** | two-valued spectrum, multiplicities $m(m-1)$ and $m^2$, no kernel, $g_n=\lvert\lambda_-\rvert=\Theta(1/n)$ | **CONFIRMED**, every arithmetic check re-derived cold |
| **2** | $W\mapsto W_-$, and $\delta^2$ with it, real-analytic on a ball of radius $g_n$ about $W^*$ | **CONFIRMED** for the *real* ball, by Weyl's inequality; the *complex* radius must be $\rho<g_n/2$, not $\rho=g_n/2$ (F3) |
| **3** | Riesz projection holomorphic, Cauchy bounds the third derivative by $O(g_n^{-3})$, hence $C_\delta=O(n^3)$ | **REFUTED as stated in the brief.** Two independent errors give $n^3$; the true figure is $C_\delta=O(n)$ at $W^*$ (F1). The item itself already disavows $O(n^3)$ and then re-asserts it (F5) |
| **4** | with $c_n=3\theta_0/(n-2)$, $r_n=\Omega(n^{-3/2})$ | **CONFIRMED**, reconstructed by hand independently of [r443](REVIEW_r443.md) and landing on the same three branches, **and strengthened**: $n^{-3/2}$ is also the chain's *ceiling*, unconditionally on $\sup\lvert P\rvert$ (F2) |

**The exponent I believe: $r_n=\Theta(n^{-3/2})$ for this method.** Neither $n^{-4}$ nor $\Theta(n^{-2})$ survives. They are not different quantities, they are $c_n/C$ computed with two wrong values of $C$.

**The per-direction trap is NOT committed** (F4). This is the audit's most valuable confirmation, and the reason is structural rather than incidental, so it is set out in full below.

**But the item as written is not in a state to be quoted.** It asserts $r_n=\Theta(n^{-2})$ *exactly* and $r_n=\Omega(n^{-3/2})$ eight lines apart; it carries two errors it declares "now fixed" in a later paragraph while the earlier paragraphs still contain them; and one paragraph is textually corrupted mid-sentence (F5).

---

## F1, step 3 is wrong twice over, and the item knows it once

The brief's step 3 reads: Cauchy bounds the third derivative of $t\mapsto\mathrm{Alt}(W(t)_-)$ by $O(g_n^{-3})$, hence $C_\delta=O(g_n^{-3})=O(n^3)$. Both halves fail.

**Error one: the Cauchy supremum.** Write $A(z)=\mathrm{Alt}(W(z)_-)$ along the complexified great circle, holomorphic on $\lvert z\rvert<\rho=\Theta(g_n)$. Cauchy gives $\lVert A^{(k)}(0)\rVert\le k!\,M/\rho^k$ with $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$. Getting $O(g_n^{-3})$ for $k=3$ requires $M=O(1)$. **$M=O(g_n)$**, so $\lVert A'''\rVert=O(g_n^{-2})=O(n^2)$, and generally $\lVert A^{(k)}\rVert=O(n^{k-1})$, which is exactly the record's own Cauchy estimate, quoted in the item's own italics and in [r443](REVIEW_r443.md) D5.

**Error two, and it is the larger one: $C_\delta$ is the third derivative of $\delta^2$, not of $A$.** With $\delta^2=\langle A,A\rangle$,

$$(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle,$$

and $A(0)=\mathrm{Alt}(W^*_-)=0$ kills the first term at the base point. So $A'''$ (the only place $f^{[3]}$ appears), never multiplies anything but $O(t)$, and $(\delta^2)'''(0)=6\langle A''(0),A'(0)\rangle=O(n)\cdot O(1)=O(n)$. This is [r442](REVIEW_r442.md) FINDING 3 and [r443](REVIEW_r443.md) D2, and the item reproduces it correctly in its own parenthesis while leaving the $O(n^3)$ sentence standing in front of it.

### $\mathrm{Alt}(W^*_-)=0$, CONFIRMED, and by a shorter argument than [Lemma L133](../findings/second-order.md)'s

[Lemma L133](../findings/second-order.md) Step 1 gets it by writing $W^*_-\propto\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2}$ and observing that each summand is a Riemannian curvature operator (the round sphere, and $S^m\times\mathbb R^m$ twice), hence Bianchi, hence Alt-free. That is correct. The shorter route needs no geometry: with $\mathrm{Alt}$ the orthogonal projection onto $\Lambda^4$ ([conventions.md](../findings/conventions.md)), $\mathrm{Alt}(T)$ is carried only by entries on **four distinct indices**, and $W^*_-=\lvert\lambda_-\rvert P_{\text{mixed}}$ is **diagonal in the coordinate-$2$-plane basis**, so $T_{ijkl}\ne0$ only when $\{i,j\}=\{k,l\}$ and every $\Lambda^4$ component is zero entrywise. This is [Lemma L133](../findings/second-order.md)'s own Step 2 observation applied to the base point rather than to the derivative.

**It is $W^*_-$ that is Alt-free, not merely $W^*$**, the brief's question answered in the affirmative, and the property is load-bearing exactly as claimed: it is what removes the $\Theta(n^2)$ term from $(\delta^2)'''$ and what makes $M=O(g_n)$ possible.

### The stated reason for $M=O(g_n)$ is incomplete, and $M$ is load-bearing for the exponent

The item says: *the zeroth Neumann term is the unique $\Theta(1)$ term and $\mathrm{Alt}(W^*_-)=0$ kills it.* That is half of it. Writing $W_-=-W\Pi$ with $\Pi$ the Riesz projection onto the negative part, and using $\mathrm{Alt}(W^*_-)=0$ with $\lVert\mathrm{Alt}\rVert\le1$,

$$\lVert A(z)\rVert\;\le\;\lVert W(z)_--W^*_-\rVert\;\le\;\underbrace{\lVert W(z)-W^*\rVert_F\,\lVert\Pi(z)\rVert_{op}}_{O(g_n)\cdot O(1)}\;+\;\underbrace{\lVert W^*\rVert_{op}\,\lVert\Pi(z)-\Pi(0)\rVert_F}_{?}.$$

The first term is $O(g_n)$ from $\lVert W(z)-W^*\rVert=O(\rho)=O(g_n)$ and the contour bound $\lVert\Pi\rVert_{op}\le\frac{\lvert\Gamma\rvert}{2\pi}\sup_\Gamma\lVert R\rVert=O(g_n)\cdot O(1/g_n)=O(1)$. The second needs the resolvent identity, $\lVert\Pi(z)-\Pi(0)\rVert_F\le\frac{\lvert\Gamma\rvert}{2\pi}\lVert R\rVert_{op}\lVert E\rVert_F\lVert R_0\rVert_{op}=O(g_n)\cdot O(1/g_n)\cdot O(g_n)\cdot O(1/g_n)=O(1)$, and then **$\lVert W^*\rVert_{op}=\lambda_+=\Theta(1/n)=\Theta(g_n)$**, which the item never states. It is true, and it is true for a reason particular to this point: $\sum\lambda^2=1$ spread over $\binom n2$ eigenvalues on a nearly flat spectrum forces every eigenvalue to be $\Theta(1/n)$.

**Why this matters rather than being pedantry.** If $M$ were $O(1)$ then $\lVert A''\rVert=O(n^2)$, and the quartic branch of the radius (F2, branch 3) would give $\sqrt{c_p}/n^2=\Theta(n^{-5/2})$. The exponent $-3/2$ rests on $M=O(g_n)$, and $M=O(g_n)$ rests on two facts of which the item records one.

## F2, the arithmetic tension, resolved: $n^{-3/2}$ is right, and it is also the ceiling

The brief's tension is that $r_n=c_n/C$ with $c_n=\Theta(n^{-1})$ and $C_\delta=\Theta(n^3)$ reads $\Theta(n^{-4})$. **$n^{-4}$ and $n^{-3/2}$ are the same quantity computed with two values of $C$, one of them wrong twice (F1).** With the corrected $C$ the same formula returns the same exponent as the direction-resolved chain.

I reconstructed the bookkeeping by hand before reading [r443](REVIEW_r443.md) D5, and it agrees with it. Along the great circle $W(t)=\cos t\,W^*+\sin t\,H$ with $H$ unit, normal to the orbit, write $u=\lVert A'(0)\rVert$ and $v$ for the weight of $H$ on the $(2,2)$-split four-set blocks. Three facts, each from the record:

- **Margin.** $Q$ is block-additive ([Lemma L120](../findings/second-order.md), [Lemma L141](../findings/second-order.md)(b)), $c_p=3\theta_0/(n-2)=\Theta(1/n)$ off the $(2,2)$ blocks and $\Theta(1)$ on them at every internal weight $s$, $3\theta_0(2\mu s-\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert s$ runs from $-2.06$ to $-1.71$ at $n=200$, never near zero. So $c(H)\gtrsim c_p+\Theta(1)v^2$, and $u\le\tfrac{\sqrt2}3v$ ([Lemma L133](../findings/second-order.md) Step 2's $\sigma\le\tfrac29$) gives $c(H)\gtrsim c_p+u^2$.
- **$P$-side tail.** $P(\cos t\,W^*+\sin t\,H)=\cos^3t\,\theta_0+3\cos t\sin^2t\,B(W^*,H,H)+\sin^3t\,P(H)$, the $\cos^2t\sin t$ term vanishing by criticality and $H\perp W^*$. The $t^3$ coefficient is $P(H)$, bounded by $\sup\lvert P\rvert\le1+\sqrt{n-2}$ ([Lemma L143](../findings/bounds.md)); the $O(t^4)$ tails carry only $\theta_0$ and $B$, both $O(1)$.
- **Defect tail.** $\lVert A(t)\rVert\le ut+Knt^2$ from $A(0)=0$ and $\lVert A''\rVert=O(n)$ uniformly on $\lvert s\rvert\le t$, so $\delta^2\le u^2t^2+2Knut^3+K^2n^2t^4$ with the $u^2t^2$ already inside $Q$.

Since $\kappa_n<0$, the penalty $-\kappa_n\delta^2=\lvert\kappa_n\rvert\delta^2$ works *against* the margin, and $F(t)=P-\theta_0-\kappa_n\delta^2\le0$ needs each tail dominated by $c(H)t^2$:

$$r_n\;\gtrsim\;\min_{0\le u\le1/2}\ \min\!\left(\frac{c_p+u^2}{\sup\lvert P\rvert+nu},\ \frac{\sqrt{c_p+u^2}}{n}\right).$$

**All three branches land on $n^{-3/2}$**, which is why the answer is robust:

| branch | where | value at $\sup\lvert P\rvert=\Theta(\sqrt n)$ |
| --- | --- | --- |
| $P$-side, $u=0$ | pure pair-block directions | $c_p/\sup\lvert P\rvert=\Theta(n^{-1})/\Theta(n^{1/2})=\Theta(n^{-3/2})$ |
| defect cubic, $u^*=\Theta(n^{-1/2})$ | the interior minimum | $\Theta(n^{-1})/\big(\Theta(n)\cdot\Theta(n^{-1/2})\big)=\Theta(n^{-3/2})$ |
| defect quartic, $u=0$ | pure pair-block directions | $\sqrt{c_p}/n=\Theta(n^{-1/2})/n=\Theta(n^{-3/2})$ |

**The threshold claim of [r444](REVIEW_r444.md) and [r445](REVIEW_r445.md) is CONFIRMED.** Putting $\sup\lvert P\rvert=\Theta(n^\beta)$, the first two branches give $\Theta(n^{-1-\min(\beta,1/2)})$, $n^{-2}$ at $\beta=1$ ([Lemma L107](../findings/bounds.md)'s $n-1$, which is [post F60](../findings/second-order.md)'s reading), $n^{-3/2}$ at $\beta=\tfrac12$ ([Lemma L143](../findings/bounds.md)), and no better below. $\beta=\tfrac12$ is exactly the threshold.

### The strengthening: $n^{-3/2}$ is a ceiling for this chain, and it needs no bound on $\sup\lvert P\rvert$ at all

Branch 2 alone caps the chain. With $\sup\lvert P\rvert=O(1)$, the best any absolute constant could give, which is what [I31](../plan.md) is for, the interior minimum is still at $u^*=\Theta(n^{-1/2})$ and still returns

$$\frac{c_p+u^{*2}}{1+nu^*}=\frac{\Theta(n^{-1})}{\Theta(n^{1/2})}=\Theta(n^{-3/2}).$$

**So the exponent $-3/2$ is pinned by the pair $\big(c_p=\Theta(1/n),\ \lVert A''\rVert=O(n)\big)$ and by nothing else**, and branch 3 pins it a second, independent time. This confirms the item's claim that [I31](../plan.md) buys the constant alone, and proves it, where the item asserts it. It also means [post F60](../findings/second-order.md) was right in *form* (a ceiling exists) and wrong in *value* (it is $n^{-3/2}$, not $n^{-2}$), which is worth recording since F60 is withdrawn wholesale.

**What a successor would have to break to go past $n^{-3/2}$:** the Cauchy bound $\lVert A''\rVert=O(n)$, [r443](REVIEW_r443.md)'s own open item (iii), whether $\mathrm{Alt}$ saturates it. Breaking $\sup\lvert P\rvert$ further does nothing.

## F3, norms and radii: no mismatch, and the one slip is a constant

**The norm question falls the safe way, so the $\sqrt{\binom n2}$ the brief feared is absent.** The record's $\Lambda^2$-operator normalisation is $\operatorname{tr}(W^2)=\sum\lambda^2=1$ ([conventions.md](../findings/conventions.md), "the two spectra"), i.e. plain Frobenius. The spectral machinery needs the perturbation small in **operator** norm, and $\lVert\cdot\rVert_{op}\le\lVert\cdot\rVert_F$, so a Frobenius ball of radius $g_n$ sits **inside** the operator-norm ball of radius $g_n$. The estimate is conservative. A factor $\sqrt{\binom n2}$ would appear only in the opposite direction (a bound needing Frobenius-smallness supplied with operator-smallness) and no step does that.

**Real-analyticity on the real ball of radius $g_n$ is CORRECT as stated.** For real $t$ the perturbation is Hermitian, so by Weyl's inequality no eigenvalue moves further than $\lVert E\rVert_{op}\le\lVert E\rVert_F<g_n$, hence none crosses zero, the negative eigenspace keeps its dimension, and $W\mapsto W_-$ is real-analytic. Step 2 stands.

**The complex radius $\rho=g_n/2$ does not.** A contour separating $\lambda_-$ from both $0$ and $\lambda_+$ has distance exactly $g_n/2$ to $\operatorname{spec}(W^*)$, the circle of radius $g_n/2$ about $\lambda_-$ realises it, since $\lambda_+-\lambda_-=\lambda_++g_n>g_n$ leaves $\lambda_+$ outside. The Neumann bound $\lVert R\rVert\le\lVert R_0\rVert/(1-\lVert E\rVert\lVert R_0\rVert)$ therefore needs $\lVert E\rVert_{op}<g_n/2$, i.e. $\rho<g_n/2$ **strictly**; the item's "resolvent norm $O(1/(g_n-\rho))$, taking $\rho=g_n/2$" reads the distance as $g_n$ where it is $g_n/2$. Taking $\rho=g_n/4$ repairs it with $\rho=\Theta(g_n)$ preserved, so $\lVert A^{(k)}\rVert=O(n^{k-1})$ is unaffected. **A constant, not an exponent**, recorded because this record has had a gap misread by a factor $n$ once already ([r439](REVIEW_r439.md)) and the same sentence is where it happened.

## F4, the per-direction-to-neighbourhood trap is NOT committed, and this is not a close call

The brief is right that this programme has made this error repeatedly, [I3](../plan.md)'s four refuted formulations share one shape, and [r436](REVIEW_r436.md)'s $g(x,y)=3\beta\phi(y/x^2)(x^2+y^2)$ is the sharpest witness. Step 4 does not have that shape, for three reasons, and all three are needed.

- **The quantifier runs the safe way.** The object is $r_n=\inf_H r(H)$, an **infimum** over directions of a per-direction radius, and the infimum is an explicit positive number. That is the definition of a uniform radius. The trap is a **supremum** over directions, or an infimum that is zero; taking the worst direction is what makes a neighbourhood statement.
- **Every ingredient is uniform in $H$ with no modulus needed.** The Cauchy estimate $\lVert A^{(k)}\rVert=O(n^{k-1})$ uses only $\lVert H\rVert_F=1$, every step of F1's derivation of $M=O(g_n)$ does, and the same holds at intermediate base points $\lvert s\rvert\le\rho/2$ via $k!M/(\rho-\lvert s\rvert)^k$. The margin $c(H)\gtrsim c_p+u^2$ uses only the block weights. $\sup\lvert P\rvert$ is direction-free by construction. There is no direction-dependent constant anywhere in the chain that could blow up.
- **The geometry closes.** Every $W$ on the sphere with $d(W,\mathcal O)=t<r_n$ lies on a minimising great circle from its nearest orbit point $W^*$, whose initial direction $H$ is normal to $T_{W^*}\mathcal O$ and to $W^*$, precisely the domain on which [Lemma L141](../findings/second-order.md)(b)'s margin is proved. The estimate along that circle is an honest one-dimensional Taylor expansion with a Lagrange remainder bounded **uniformly on the whole segment** $[0,t]$, not a limit at $0$. The union of those segments **is** the tube. Nothing is being extended from rays to a neighbourhood; the rays already fill it.

**The contrast with the refuted family is exactly here.** [I3](../plan.md)'s formulations (1)–(3) and [r436](REVIEW_r436.md)'s counterexample all take a per-direction **limit** ($c_2(H)$, $\limsup_{t\to0}$, a one-sided ray) for which the radius of validity is not computed and shrinks to zero as the direction varies. Step 4 computes the radius, and it does not shrink.

**One documentation defect, and it is the reason to say all of the above.** [plan.md](../plan.md) writes "*Per-direction bookkeeping with the record's own Cauchy estimate … gives $r_n=\Omega(n^{-3/2})$*" with no "$\min$", no statement that the estimate is uniform, and no derivation on the page. The phrase alone is the exact shape of the move refuted four times; a reader who checks only the phrase will either reject a correct argument or, worse, copy the phrase into a fifth attempt where it is not licensed. **The displayed minimum belongs in the item.**

## F5, the item is internally contradictory in three places, and one paragraph is corrupted

These are defects of the record rather than of the mathematics, but the item is what a successor reads.

- **$\Theta(n^{-2})$ *exactly* against $\Omega(n^{-3/2})$.** [plan.md](../plan.md) line 78 closes "*Since $c_n$ is attained and $C_\delta=\Theta(n)$ is forced by the third divided difference, $r_n=\Theta(n^{-2})$ **exactly***", and line 86 opens "*[Post F60](../findings/second-order.md) is WITHDRAWN, and the radius improves to $\Omega(n^{-3/2})$*". $\Theta(n^{-2})$ *exactly* and $\Omega(n^{-3/2})$ are incompatible. The second is right; the first is the superseded pairing $\min_Hc/\max_HC$ with $C_P=\Theta(n)$, and its "exactly" was never earned anyway, a $\Theta$ needs a lower bound on the true failure radius, which no one has, and [r441](REVIEW_r441.md) hedged it with "absent an unproven cancellation" that line 78 drops.
- **Two errors declared fixed while still standing.** Line 90 reads "*Two errors of this item's own, both now fixed*", $3\theta_0$ not $6\theta_0$, and the second divided difference not the third. **Neither is fixed in the item.** Line 68 still says "*$c_n$ is $6\theta_0$ times the balanced product's own gap*" ([r442](REVIEW_r442.md) FINDING 1; corrected in [Lemma L141](../findings/second-order.md) but not here), and line 78 still says "*$C_\delta=\Theta(n)$ is forced by the third divided difference*" ([r442](REVIEW_r442.md) FINDING 3, [r443](REVIEW_r443.md) D2). A "now fixed" notice that does not fix is worse than no notice: it stops the next reader looking.
- **A textual splice.** Line 84 runs "*…whose largest recorded value at $n=12$ is $\theta_0(12)=1.236$*'s exponent from $n^{-3/2}$ by the mechanism [r443](REVIEW_r443.md) identifies*", two sentences spliced mid-clause, and the surviving fragment appears to assert something about *moving* the exponent *from* $n^{-3/2}$, which is the opposite of the item's conclusion.
- **The brief's step 3 quotes the superseded reading.** $C_\delta=O(n^3)$ is what [plan.md](../plan.md) line 78 says in its main clause and disavows in its own italics two sentences later. Anyone briefing from the item's main clauses inherits $n^{-4}$.

## F6, vacuity: the statement is not vacuous, and the exponent chase is nonetheless low-value

**Not vacuous, logically.** $\kappa_n=9(\sqrt{3/2}-\theta_0(n))<0$ for $n\ge12$ (screened: $-0.1016$ at $n=12$, $-1.610$ at $n=200$), so [Conjecture L16](../findings/problem.md) on the tube reads $P(W)+\lvert\kappa_n\rvert\delta^2(W)\le\theta_0$, which is **strictly stronger** than local maximality of $P$ at the balanced orbit. It is not the $d=0$ statement re-derived, and the balanced orbit is a genuine equality case rather than an artefact. The brief's comparison also passes: $r_n=\Theta(n^{-3/2})$ is strictly inside the analyticity ball $g_n=\Theta(n^{-1})$, by the factor $n^{-1/2}\to0$. The item's parenthetical that "$\Theta(n^{-1})$ would not be" is loose (a $\Theta(n^{-1})$ with a small enough constant would be inside) but the conclusion it supports is sound, since the bootstrap independently requires $t\le\rho/2=\Theta(g_n)$.

**Low-value, nonetheless, and the exponent does not change that.** The nearest other critical point is $S^{m-1}\times S^{m+1}$ at distance $O(1)$ ([I20](../plan.md)), so the tube contains no competitor at either exponent. The orbit has dimension $\Theta(n^2)$ inside a sphere of dimension $\Theta(n^4)$, and a tube of radius $n^{-3/2}$ about it covers a vanishing fraction, as does one of radius $n^{-2}$, and as [r443](REVIEW_r443.md) D6 already observed of [post F60](../findings/second-order.md)'s own coverage paragraph, so would one of radius $\tfrac12$. **The (α)/(β)/(γ) scenario split therefore leaves (γ) (which *is* the conjecture), carrying everything, identically at $n^{-2}$ and at $n^{-3/2}$.** The improvement is real and the argument is right; what it buys the programme is a sharper statement of a scenario whose complement is undiminished. This is worth saying plainly in the item, because the item currently spends four paragraphs on the exponent and none on what the exponent is for.

---

## What I could not break

- The spectrum, exhaustively. $m(m-1)\lambda_++m^2\lambda_-=0$; $\sum\lambda^2=\tfrac m{2m-1}+\tfrac{m-1}{2m-1}=1$ **exactly**; $m(m-1)+m^2=m(2m-1)=\binom{2m}2=\binom n2$, so the multiplicities **exhaust** $\Lambda^2\mathbb R^n$, **no hidden eigenvalue and no kernel**, and $\lambda_\pm\ne0$ at every $m\ge2$. $\lvert\lambda_-\rvert/\lambda_+=\tfrac{m-1}m<1$, so $g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}\to\tfrac{\sqrt2}n$, and $g_{12}=\tfrac16\sqrt{5/11}=0.112367$. I also re-derived $W^*$ from scratch as the normalised traceless part of $P_{\Lambda^2V_1}+P_{\Lambda^2V_2}$: $\operatorname{tr}=m(m-1)$ over $N=m(2m-1)$ gives the shift $\tfrac{m-1}{2m-1}$ and both eigenvalues in the stated closed form. *Screen (self-constructed, seconds, evidence for nothing): at $n=12,20,50,200$ the four identities hold to machine precision.*
- $\mathrm{Alt}(W^*_-)=0$, by two independent arguments (F1).
- The margin $c_n=3\theta_0/(n-2)$ and its attainment on the within-factor pair block, taken from [Lemma L141](../findings/second-order.md) with [r442](REVIEW_r442.md)'s and [r443](REVIEW_r443.md)'s independent re-derivations from [Lemma L27](../findings/nondegeneracy.md), and re-checked here only for the $(2,2)$-block comparison, where $Q/\lVert H\rVert^2$ stays at $\Theta(1)$ for every internal weight.
- The $\sqrt n$ threshold of [Lemma L143](../findings/bounds.md), re-derived at general $\beta$ (F2).

## What this audit did not check

Block-additivity of $Q$ over [Lemma L120](../findings/second-order.md)'s decomposition, [Lemma L27](../findings/nondegeneracy.md)'s ten summand values, [Lemma L133](../findings/second-order.md)'s support table, and [Lemma L143](../findings/bounds.md)'s proof of $\sup\lvert P\rvert\le1+\sqrt{n-2}$ were taken as given, each carries its own Gate 2. The Schur-multiplier constant behind $\lVert A''\rVert=O(n\,\max\lvert f^{[2]}\rvert)$ is not needed here, the Cauchy route supplying the same order. Whether $\lVert A''\rVert=\Omega(n)$ on any direction, [r443](REVIEW_r443.md)'s open item (iii), is untouched, and it is the only thing between $\Theta(n^{-3/2})$ as this chain's ceiling and a better exponent.
