# REVIEW r710, Gate 2 on [Lemma L157](../findings/second-order.md), the reach fraction and the elimination of $\sigma$

*Reviewer r710, 2026-09-05, cold brief. Analysis only: the sole computation is an evaluation of the lemma's own closed form $\sigma^*(t)$ at six values of $t$ and of one elementary integral, run as a screen on objects built for that purpose and reported as a screen. Everything else is hand algebra from the definitions.*

## Verdicts

| claim | verdict |
|---|---|
| **C1**, $\sigma$ is the reach fraction; the same $\sigma$ sets the Cauchy margin; freezing it loses | **CONFIRMED**, and it is stronger than stated: $\sigma$ is not a free parameter but is *determined*, $\sigma=r/\rho$. **The correction is to the provenance**: the record does define the branch, in [r450](REVIEW_r450.md) with the display $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$ |
| **C2**, the branches in units of $\rho$ are $\sigma$ and $t(1-\sigma)^2$ with $t=\sqrt{c_p+w^2}/(2J\gamma)$ | **PLAUSIBLE.** The **shape** is right and survives both reconstructions of branch $2$. The **constant** is imported from an order-level display and is a factor $2$ pessimistic against the record's own tail expansion; and the $\gamma$ inside $t$ is cosmetic, since $2J\gamma\equiv2C$ |
| **C3**, $\sigma^*=\frac{2t+1-\sqrt{4t+1}}{2t}=t-2t^2+O(t^3)$, unique in $(0,1)$, maximising the min | **CONFIRMED** in every part, with a one-line uniqueness proof the lemma does not give, and with the range of the expansion recorded |
| **C4**, at the crossing $\gamma$ cancels, leaving two terms with $J^*<8$ and **no free parameter** | **REFUTED as stated**, three ways: $\gamma$ does not cancel beyond leading order and its correction pushes $\gamma$ off [L156](../findings/second-order.md)'s optimum; the displayed leading-order chain is a **lower** bound inflated by $(1-2t)^{-1}$; and $S$ and branch $2$'s numerator constant are free parameters, as the lemma's own closing paragraph says |
| **C5**, freezing $\sigma=\tfrac12$ costs a factor approaching $4$, essentially the full $4$ at $w=0$ | **REFUTED as stated.** The arithmetic is right and the asymptotic is right, but **$w=0$ is precisely where branch $2$ is vacuous** by [Lemma L148](../findings/second-order.md), which [Lemma L149](../findings/second-order.md) states in terms; in the regime where branch $2$ is present the factor is $3.09$–$3.44$ at $n=12$, and it is a factor on the branch-$2$/branch-$3$ minimum rather than on $r$ |

## C1, the reading is right, it is sharper than the lemma makes it, and the record already had it

**The identification is correct and it is forced.** The estimate the chain uses is Cauchy at an intermediate real base point $s$ on the segment: the largest disc about $s$ inside the disc of analyticity is $\rho-\lvert s\rvert$, so $\lVert A''(s)\rVert\le\frac{2!\,M}{(\rho-\lvert s\rvert)^2}$ with $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$. **The exponent $2$ and the factor $2$ are both right**: $k=2$ gives $k!=2$ and $(z-s)^{-(k+1)}$ contributes $r_0^{-3}$ against a contour of length $2\pi r_0$, leaving $2M/r_0^2$. And $M$ is correctly the supremum on $\lvert z\rvert=\rho$, because the disc of radius $\rho-\lvert s\rvert$ about $s$ is internally tangent to $\lvert z\rvert=\rho$, the sup over the smaller disc would be a different and non-uniform quantity, and by the maximum principle the circle and the closed disc give the same $M$ anyway. *Taking the supremum over $\lvert s\rvert\le r$ puts the worst case at the endpoint, which is exactly $r=\sigma\rho\Rightarrow(1-\sigma)\rho$.* **So the reach and the Cauchy margin are the same parameter, and they do oppose.**

### The lemma is weaker than the truth: $\sigma$ is determined, not optimised

**There is no free $\sigma$ to freeze or to optimise.** The reach *is* the tube radius: the bound on $\lVert A''\rVert$ must hold on the whole segment $[0,r]$ that the defect estimate integrates over, so the only admissible reading is $\sigma=r/\rho$. The defect branch is then a **self-consistency condition** rather than a family of bounds indexed by a parameter,
$$r\;\le\;\frac{\Lambda\sqrt{c}}{\sup_{[0,r]}\lVert A''\rVert},\qquad \sup_{[0,r]}\lVert A''\rVert\le\frac{2C\rho}{(\rho-r)^2},$$
whose largest solution is exactly $\sigma^*\rho$ with $\sigma^*$ the root of $\sigma=t(1-\sigma)^2$. **The crossing is the boundary of self-consistency, and the max–min is a coincidence of the same algebra.** *This is a strictly better argument than the lemma's: it needs no claim that the minimum of an increasing and a decreasing function is maximised at the crossing, it explains without appeal why branch $3$ disappears rather than being traded away, and it removes the objection that one may not optimise a parameter that a proof has already fixed.*

**It does change the logical status of the branch, and that should be recorded.** [r451](REVIEW_r451.md) explicitly checked for a fixed point and reported "*what is there instead is an undisplayed constraint, $r_n\le\rho/2$, which is a **cap** rather than a fixed point*". Under L157's own elimination it becomes a fixed point. *That is not a defect (the fixed point is benign, having a unique attracting solution in $(0,1)$) but a successor reading r451 and L157 together will find them describing the same object with opposite words.*

### The provenance claim is false: the record defines the branch, in four places

L157's derivation note says it "*gives $\sigma$ the definition the record never had*", and [L156](../findings/second-order.md)'s box says "*$\sigma$ has no definition on the record*". **Both are wrong about the mathematics and right only about the symbol.**

- **[r450](REVIEW_r450.md)** states it exactly: "*the Cauchy estimate at an intermediate base point $s$ along the segment is $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, so the uniform remainder needs $t\le\rho/2$*", and displays the three-branch chain with $\rho/2$ labelled **validity**.
- **[r451](REVIEW_r451.md)**: "*the Cauchy bound on $\lVert A''(s)\rVert$ at real base points $\lvert s\rvert\le t$ needs $t\le\rho/2$*".
- **[r452](REVIEW_r452.md)** B8 and **[r453](REVIEW_r453.md)** E6 each repeat it and each instruct that the branch be displayed.

**So the $\tfrac12$ was chosen *and said*, three times, with the reason attached**, it is the fraction that leaves half the disc as Cauchy margin, which is the content C1 attributes to $\sigma$. *What L157 supplies is the parameterisation and the elimination, which is real; what it should not claim is that the record lacked the definition.* **The correction: "the record fixed the reach at $\tfrac12$ with its reason ([r450](REVIEW_r450.md)) and never varied it; this varies it."**

## C2, the shape survives two independent reconstructions, the constant survives neither

### Branch $2$ really is $\sqrt{c}/\lVert A''\rVert$, not $\sqrt{2c/\lVert A''\rVert}$

**The brief's alternative shape is excluded, and by the record's own tail expansion.** [r447](REVIEW_r447.md) F2, quoted in [r451](REVIEW_r451.md), carries the defect tail as $\delta^2\le u^2t^2+2Knu\,t^3+K^2n^2t^4$, i.e. $\delta\le ut+Knt^2$ with $Kn=\tfrac12\lVert A''\rVert$, **Taylor with $A(0)=0$**, the quadratic coefficient being $\tfrac12\lVert A''\rVert$ and not $\lVert A''\rVert$. The penalty enters as $\delta^2$ against a margin $ct^2$, so the quartic term $\tfrac14\lVert A''\rVert^2t^4$ is beaten by $ct^2$ exactly when
$$t\;\le\;\frac{2\sqrt c}{\lVert A''\rVert}.$$
*A shape $\sqrt{2c/\lVert A''\rVert}$ would need the defect to enter linearly, or $\lVert A''\rVert$ to multiply $t^3$; neither is what $\delta^2$ with $A(0)=0$ produces.* **The second reconstruction agrees**: reading branch $2$ instead as the defect-**cubic** branch of [Lemma L147](../findings/second-order.md)'s $f(u)=(c_p+u^2)/(S+au)$, whose interior minimum is $\Theta(\min(c_p/S,\sqrt{c_p}/a))$, gives the same $\sqrt c/\lVert A''\rVert$ because the cubic coefficient is $\lVert A''\rVert\lVert A'(0)\rVert$ and $\lVert A'(0)\rVert\lesssim w\lesssim\sqrt c$. **Two routes, one shape, so C2's $(1-\sigma)^2$ scaling is safe.** *It is worth recording that they are two routes and not one: the record's branch $2$ is written once and cited for both.*

### The constant is a factor $2$ pessimistic, and it was never derived

$t=\sqrt{c_p+w^2}/(2J\gamma)$ presumes branch $2=\sqrt c/\lVert A''\rVert$ **with the constant exactly $1$**. That normalisation comes from [r450](REVIEW_r450.md)'s display, which is an order-level $\gtrsim$ with implied constants throughout. The quartic route above gives $2\sqrt c/\lVert A''\rVert$, hence
$$t=\frac{\sqrt{c_p+w^2}}{C}\quad\text{rather than}\quad\frac{\sqrt{c_p+w^2}}{2C},$$
and since the surviving bound is linear in $t$, **the recorded constant is a factor $2$ below what the record's own ingredients give.** *In the other direction the margin-versus-penalty normalisation is not $\delta\le\sqrt c\,r$ either: the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert=0.416$ ([Lemma L149](../findings/second-order.md)), so the true constant carries $\kappa_n$ and the unknown $u\lesssim w$ constant of [r452](REVIEW_r452.md) B4.* **The honest statement is $t=\Lambda\sqrt{c_p+w^2}/(2C)$ with $\Lambda\in[1,2]$ unpinned**, which is exactly the constant [L156](../findings/second-order.md)'s box lists as still open and which L157 then writes as though it were $1$.

### The $\gamma$ in $t$ is cosmetic

$J:=C/\gamma$, so $2J\gamma\equiv2C$ identically: **$t$ depends on the contour only through $C(\alpha,\gamma)$**, and writing it as $\sqrt c/(2J\gamma)$ inserts a $\gamma$ that is then celebrated for cancelling. *The substantive statement is that the surviving branch is $\sqrt c\,\gamma/(2C)\cdot g_n/\lVert H\rVert=\sqrt c\,g_n/(2J\lVert H\rVert)$, which is a statement that $J$ is the objective, [L156](../findings/second-order.md)'s finding, restated, and not a cancellation.*

## C3, confirmed in every part, with a shorter uniqueness argument

$\sigma=t(1-\sigma)^2$ is $t\sigma^2-(2t+1)\sigma+t=0$, discriminant $(2t+1)^2-4t^2=4t+1$, roots $\frac{2t+1\pm\sqrt{4t+1}}{2t}$. **The closed form is exactly the minus root, as displayed.**

> **THE UNIQUENESS HAS A ONE-LINE PROOF THE LEMMA DOES NOT GIVE, AND IT ALSO DISPOSES OF THE OTHER ROOT.** The quadratic is *palindromic*, its outer coefficients both being $t$, so the product of its roots is $1$. **Both roots are positive** (their sum is $(2t+1)/t>0$), so they are $\sigma^*$ and $1/\sigma^*$: **exactly one lies in $(0,1)$ and the other is its reciprocal, strictly above $1$ and therefore outside the admissible range of a reach fraction for every $t>0$.** *The spurious root is spurious by an identity, not by inspection.*

**The expansion is right**: $\sqrt{1+4t}=1+2t-2t^2+4t^3-\dots$, so the numerator is $2t^2-4t^3+O(t^4)$ and $\sigma^*=t-2t^2+O(t^3)$. **The max–min claim is right** as stated ($\sigma$ increasing, $t(1-\sigma)^2$ decreasing, both continuous), and is subsumed by C1's self-consistency reading.

**Screen** (own objects, seconds): $\sigma^*$ against $t-2t^2$ and the residual $\sigma^*-t(1-\sigma^*)^2$:

| $t$ | $\sigma^*$ | $t-2t^2$ | residual | $4\sigma^*/t$ |
|---|---|---|---|---|
| $10^{-3}$ | $0.000998$ | $0.000998$ | $6\cdot10^{-14}$ | $3.992$ |
| $0.0849$ | $0.072963$ | $0.070484$ | $4\cdot10^{-16}$ | $3.438$ |
| $0.1$ | $0.083920$ | $0.080000$ | $-1\cdot10^{-16}$ | $3.357$ |
| $0.156$ | $0.120633$ | $0.107328$ | $1\cdot10^{-16}$ | $3.093$ |
| $0.3$ | $0.194601$ | $0.120000$ | $1\cdot10^{-16}$ | $2.595$ |

*This checks the closed form against the equation it solves and reproduces the lemma's own loss figures; it is not evidence for the lemma.* **One thing it does show is a range**: at $t=0.3$ the two-term expansion returns $0.120$ against the true $0.1946$, a $38\%$ error, so **the expansion is usable only on $t\lesssim0.15$** and the lemma should say so rather than write $O(t^3)$ unqualified.

## C4, refuted as stated, in three independent places

### 4a. The leading-order chain, as displayed, is not a lower bound

$\sigma^*=t(1-\sigma^*)^2<t$ strictly for every $t>0$. **So the true value is below $\sqrt{c_p+w^2}\,g_n/(2J\lVert H\rVert_{op})$, and a display that drops the correction from a $\gtrsim$ statement asserts more than is proved**, the same species of error as dropping a branch from a $\min$ inside a lower bound, which is [r452](REVIEW_r452.md) B8's finding against [Lemma L149](../findings/second-order.md). *The repair is one symbol.* Since $\sigma\mapsto t(1-\sigma)^2$ decreases and $\sigma^*<t$,
$$\sigma^*\;>\;t(1-t)^2\;>\;t(1-2t),$$
so the honest displays are $r\gtrsim\frac{\sqrt{c_p+w^2}\,g_n}{2J\lVert H\rVert_{op}}(1-2t)$, or simply the exact $\sigma^*(t)\gamma g_n/\lVert H\rVert_{op}$, which costs nothing to carry.

**The size of what is being dropped, and it is uniform in $w$, which answers the brief.** $t=\Lambda\sqrt{c_p+w^2}/(2C)$ with $C=C^*$ is bounded over the whole range: at $n=12$ ($c_p=3\theta_0/(n-2)=0.4243$, $C^*=\tfrac{42}{11}$), $t$ runs from $0.0853$ at $w=0$ to $0.1563$ at $w=1$; at large $n$ the endpoint is $\sqrt{0+1}/(2\cdot4)=0.125$. **So $\sup_{w\in[0,1],\,n\ge12}t\approx0.156$, the $O(t)$ term is uniform in $w$ and in $n$, and the dropped factor is up to $2t\approx31\%$.** *"$t$ is small at $w=1$" is true in the sense that the expansion converges there and false in the sense the lemma uses it: a $31\%$ one-sided overstatement is larger than the $15\%$ that [r708](REVIEW_r708.md) records as the cost of the whole fixed-contour simplification.*

### 4b. The $-2t^2$ is an artifact of the cruder of two available Cauchy estimates

**The $(1-\sigma)^2$ comes from applying the endpoint value of $\lVert A''(s)\rVert$ across the whole segment.** Keeping $s$ inside the integral instead, $\delta(r)\le\int_0^r(r-s)\lVert A''(s)\rVert\,ds$ with $\lVert A''(s)\rVert\le2C\rho/(\rho-s)^2$, gives, with $\sigma=r/\rho$,
$$\delta(r)\;\le\;2C\rho\Big(\ln\tfrac1{1-\sigma}-\sigma\Big)\;=\;C\rho\,\sigma^2\big(1+\tfrac23\sigma+O(\sigma^2)\big),$$
against the crude $C\rho\,\sigma^2(1+2\sigma+O(\sigma^2))$. **The leading order is identical (so C4's leading-order conclusion is robust, which is worth saying) but the first correction is $\tfrac23\sigma$ against $2\sigma$.** *The self-consistency condition becomes $\sigma\le t(1-\tfrac23\sigma+\dots)$ and the crossing $\sigma^*=t-\tfrac23t^2+O(t^3)$, a third of the recorded second-order term.* **So L157 is precise at exactly the order where its input is not**: $\sigma^*=t-2t^2$ is a property of the estimate, not of the object. *(Screen: crude/sharp $=1.10,\,1.15,\,1.24$ at $\sigma=0.07,\,0.10,\,0.15$.)*

### 4c. "$\gamma$ cancels" fails at second order, and the failure pushes $\gamma$ off L156's optimum

At leading order the cancellation is the cosmetic one of C2. **Beyond it, it does not hold.** With $t=\sqrt c/(2C)$ and $C=J\gamma$,
$$\sigma^*(t)\,\gamma\;=\;\gamma\big(t-2t^2+O(t^3)\big)\;=\;\frac{\sqrt c}{2J}\;-\;\frac{c}{2J^2\gamma}\;+\;O(t^3),$$
**and the second term depends on $\gamma$ separately from $J$, growing without bound as $\gamma\to0$.** So the objective is not a function of $J$ alone: maximising it wants $J$ small *and* $\gamma$ large, and [L156](../findings/second-order.md)'s $(\alpha^*,\gamma^*)=(\tfrac D2,\tfrac D4)$ is optimal only for the leading term. *The relative size of the second term is $\sqrt c/C=2t\le31\%$, so the separation of the $(\alpha,\gamma)$ optimisation from $\sigma$ holds to about $30\%$ at $n=12$ and the true optimum sits at a $\gamma$ shifted by $O(t)$.* **The claim to record is "the $(\alpha,\gamma)$ optimisation separates from the reach to first order in $t$, with a $\le31\%$ second-order coupling that favours larger $\gamma$", not "$\gamma$ cancels".**

### 4d. "No free parameter left" is contradicted by the lemma's own closing paragraph

The boxed statement says the chain "*reduces to two terms carrying no free parameter*". **The first of those two terms is $(c_p+w^2)/S$ and $S=\sup\lvert P\rvert$ is [I31](../plan.md), open**, the lemma's own "What it does not do" says exactly this four lines below the box. **The second carries $\Lambda\in[1,2]$ from C2 and the $u\lesssim w$ constant.** *This is the structural error [r708](REVIEW_r708.md) found in [L156](../findings/second-order.md): a headline that asserts closure over a disclaimer that withdraws it, with the disclaimer as a footnote.* **The box should read "*carrying no contour parameter and no reach parameter*", which is what was actually achieved and is worth achieving.**

## C5, the arithmetic is right and the regime is wrong

**The factor is confirmed as arithmetic.** At $\sigma=\tfrac12$ the minimum is $\min(\tfrac12,\tfrac t4)=\tfrac t4$ for all $t<2$, so the loss is $4\sigma^*/t\to4$ as $t\to0$, and the lemma's $3.99$, $3.36$, $2.60$ at $t=10^{-3},0.1,0.3$ all reproduce.

### The regime the lemma calls decisive is the one where branch $2$ is not there

L157: "*in the regime that matters ($t=\Theta(n^{-1/2})$ at $w=0$), the loss is essentially the full factor $4$*". **At $w=0$ the defect vanishes identically** ([Lemma L148](../findings/second-order.md)), and [Lemma L149](../findings/second-order.md) states the consequence in its own text: "*at $w=0$ the defect vanishes identically, so the branch is **unbounded** there rather than $\Theta(n^{-1})$*". **A branch that is $+\infty$ cannot be the one whose crossing with the reach decides the minimum.** *So the asymptotic $4$ is approached only along a limit in which the branch it applies to is being switched off, and the honest range is the one where $w$ is bounded away from $0$: $t\in[0.085,0.156]$ at $n=12$ giving a loss of $3.44$ down to $3.09$, [r708](REVIEW_r708.md)'s $3.4$, not $4$.*

### It is a factor on the sub-problem, not on $r$

The min with branch $1$ is untouched, and **at $\beta=0$ all three branches are $\Theta(n^{-1})$** ([r452](REVIEW_r452.md) B8, [Lemma L151](../findings/second-order.md)'s withdrawal box). *So a factor $3$–$4$ recovered on the branch-$2$/branch-$3$ minimum can be absorbed entirely by $c_p/S$ and change nothing about $r$.* **And at the level of the recorded result ($r_n\gtrsim n^{-1-\beta}$, an order), freezing $\sigma$ cost exactly nothing**: the loss is prospective, in a constant no entry has yet assembled.

### "Two orders in $n$" is wrong

L157's closing: "*$\sigma^*=\Theta(n^{-1/2})$ there, so the reach the record used was larger than the true optimum by two orders in $n$*". **$\tfrac12$ against $\Theta(n^{-1/2})$ is a factor $\Theta(n^{1/2})$ (half an order in $n$**) and numerically it is $0.5/0.0730=6.9$ at $n=12$, which is not two orders of magnitude either. *Under neither reading is the sentence true.*

## What is already on the record, and what L157 adds

**[r708](REVIEW_r708.md) supplies, and [L156](../findings/second-order.md)'s box already quotes verbatim**: the crossing condition $t(1-\sigma)^2=\sigma$, the definition of $t$, $\sigma^*\to t$ for small $t$, the $\gamma$-cancellation, and the $3.4\times$ figure at $n=12$. **[r450](REVIEW_r450.md), [r451](REVIEW_r451.md), [r452](REVIEW_r452.md), [r453](REVIEW_r453.md) supply** the branch itself, its $\rho/2$ value, its name and its derivation from $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$.

**What is new here is the closed form $\sigma^*(t)$, its expansion, the uniqueness, and the loss table.** *That is a real contribution and it is smaller than the entry's framing suggests; the framing should attribute the crossing to [r708](REVIEW_r708.md) (as the derivation note does) and stop claiming that the definition of the reach was absent.*

## Corrections to make

1. **Withdraw "it gives $\sigma$ the definition the record never had"** and replace with: the record fixed the reach at $\rho/2$, with its reason, in [r450](REVIEW_r450.md); this varies it. Same for [L156](../findings/second-order.md)'s "*$\sigma$ has no definition on the record*", which is true of the symbol and false of the object.
2. **Replace the max–min derivation with the self-consistency one.** $\sigma=r/\rho$ is not free; the crossing is the boundary of $r\le\Lambda\sqrt c/\sup_{[0,r]}\lVert A''\rVert$, which is stronger, shorter, and answers why branch $3$ vanishes.
3. **Carry the constant honestly**: $t=\Lambda\sqrt{c_p+w^2}/(2C)$ with $\Lambda\in[1,2]$ unpinned, $2J\gamma\equiv2C$, and the $u\lesssim w$ and $\kappa_n$ normalisations named as what fixes $\Lambda$.
4. **Fix the lower bound**: display $\sigma^*(t)\gamma g_n/\lVert H\rVert_{op}$ exactly, or the leading order times $(1-2t)$. Record $\sup_{w,n}t\approx0.156$ so the $O(t)$ is uniform and its size is stated.
5. **Withdraw the second-order term** $-2t^2$, or attach to it that it is a property of the endpoint-sup estimate: the integral form gives $-\tfrac23t^2$.
6. **Replace "$\gamma$ cancels" with "the $(\alpha,\gamma)$ optimisation separates to first order in $t$"**, and record the $-c/(2J^2\gamma)$ coupling, which favours larger $\gamma$ than [L156](../findings/second-order.md)'s optimum by $O(t)$.
7. **Rewrite the box**: "no contour parameter and no reach parameter", since $S$ remains free.
8. **Restate C5's regime**: the loss is $3.09$–$3.44$ where branch $2$ is present, $w=0$ being where [Lemma L148](../findings/second-order.md) removes the branch; and it is a factor on the branch-$2$/branch-$3$ minimum, which branch $1$ may absorb entirely at $\beta=0$.
9. **Delete "two orders in $n$"**; the ratio is $\Theta(n^{1/2})$, and $6.9$ at $n=12$.
10. **Record the expansion's range**: $t\lesssim0.15$, since at $t=0.3$ the two-term form is $38\%$ off.

## What would refute this review

For C1: a place in the chain where the $\lVert A''\rVert$ bound is needed only at $t=0$ or only on a sub-segment, which would break $\sigma=r/\rho$ and restore $\sigma$ as free. For C2 and C4a: a derivation of branch $2$'s numerator constant that returns exactly $1$, which would make $t=\sqrt c/(2C)$ right rather than pessimistic. For C5: a demonstration that $\lVert A''\rVert$ on the mixed directions is bounded below in a way that keeps branch $2$ binding as $w\to0$, which would restore $w=0$ as the decisive regime, **but [Lemma L148](../findings/second-order.md) is a vanishing statement and not an estimate, so this would have to displace L148.**
