# Review r709, Gate 2 on [Lemma L157](../findings/second-order.md): the reach fraction, the crossing, and what the crossing does not close

*Reviewer r709, 2026-09-05, cold brief. Analysis only: the sole computation is an evaluation of the entry's own closed forms ($\sigma^*(t)$, $C^*$, $J^*$, $c_p$, $g_n$), at $n=12$ across $w\in[0,1]$, run as a screen on objects built for that purpose and reported as a screen. Every derivation below is hand algebra.*

## Verdicts

| claim | verdict |
|---|---|
| **C1**, $\sigma$ is the reach fraction, the same $\sigma$ sets the Cauchy margin, and the two uses oppose | **CONFIRMED as mathematics, and the novelty claim attached to it is REFUTED.** The coupling is written out on the face of [r450](REVIEW_r450.md) D7, which is where branch 3 came from, and the parameter already sits in [findings/second-order.md](../findings/second-order.md) at $\eta=\tfrac12$ with its constant $8$ |
| **C2**, the branches in units of $\rho$ are $\sigma$ and $t(1-\sigma)^2$, $t=\sqrt{c_p+w^2}/(2J\gamma)$ | **PLAUSIBLE.** The shape is right and the algebra is internally consistent ($J\gamma=C$, so $t=\sqrt{c}/2C$), but $t$'s constant is not: the record's own collapse gives branch $2=2\sqrt c/a$ and $a$ carries $\lvert\kappa_n\rvert$, so $t$ is understated by a factor $\lambda\in[1.5,2]$. And branch $1$ is not $\sigma$-free |
| **C3**, the crossing root, its uniqueness, its expansion, and the max-min | **CONFIRMED**, with a cleaner proof of uniqueness, the spuriousness of the second root, and a usable two-sided inequality |
| **C4**, $\gamma$ cancels, leaving $\sqrt{c_p+w^2}\,g_n/(2J^*\lVert H\rVert_{op})$ with no free parameter | **REFUTED as stated.** $\gamma$ does not cancel; the exact identity is $\sigma^*\gamma=\tfrac{\sqrt c}{2J}(1-\sigma^*)^2$, so the displayed branch **overstates a lower bound** by $13$–$22\%$ at $n=12$ and the error does not vanish with $n$ at $w=\Theta(1)$. Three free parameters remain, one of them inside $t$ itself |
| **C5**, freezing $\sigma=\tfrac12$ costs a factor approaching $4$; at $w=0$, $t=\Theta(n^{-1/2})$ and the loss is essentially the full $4$ | **PLAUSIBLE as an asymptotic, wrong at every number in the programme's range.** The loss at $n=12$ runs $3.47$ down to $3.11$, is $\approx3.2$ at the binding direction and $\approx2.9$ once $\lvert\kappa_n\rvert$ enters; $w=0$ is not the binding direction and is the one direction where [L148](../findings/second-order.md) empties branch $2$; and "two orders in $n$" is $n^{1/2}$, a factor $7.2$ at $n=12$ |

**One-line verdict: the crossing is real, correctly solved, and correctly aimed, and the lemma states its result in the one direction a lower bound may not be stated, drops the constant that decides its own headline number, and claims a definition the record already had twice.**

## C1, the identification is right, and it is [r450](REVIEW_r450.md)'s own display read once more

**The mathematics.** [r450](REVIEW_r450.md) D7 introduces branch $3$ in these words: *"The Cauchy estimate at an intermediate base point $s$ along the segment is $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, so the uniform remainder that [r447](REVIEW_r447.md) F4 relies on needs $t\le\rho/2$."* Put $\lvert s\rvert\le t\le\sigma\rho$ into that display and it reads $\lVert A''\rVert\le2M/((1-\sigma)\rho)^2$. **So the reach and the Cauchy shrinkage are one parameter, and the $\tfrac12$ was chosen to make $\rho-\lvert s\rvert\ge\rho/2$.** The opposition is real: $\sigma\uparrow$ raises branch $3$ and raises $\lVert A''\rVert$, lowering branch $2$. **CONFIRMED.**

**The Cauchy estimate itself checks in every factor.** $k!=2$ at $k=2$, exponent $2$ on the radius, and $M$ a supremum over a circle of radius $(1-\sigma)\rho$ about a point at distance $\sigma\rho$ from the origin, a circle contained in $\lvert z\rvert\le\rho$, so $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is the right object and the maximum principle for the analytic operator-valued $A$ covers the interior. *[L156](../findings/second-order.md)'s $M\le C\rho$ is a bound on the whole closed disc and is monotone in $\lvert z\rvert$, so it serves at every base point, which is what "uniformly" needs.*

> **BUT THE DEFINITION IS NOT NEW, AND THE FAILURE IS THE ONE [LEMMA L150](../findings/second-order.md)'S BOX RECORDS.** [Lemma L151](../findings/second-order.md)'s withdrawal box, **57 lines above L157 in the same file**, reads: *"Cauchy's $k!=2$ becomes $2M/((1-\eta)\rho)^2$ uniformly, hence $\mathbf 8$ at the already-frozen $\eta=\tfrac12$."* Same parameter, same role, same frozen value, and the constant $2/(1-\tfrac12)^2=8$ printed. **What [r708](REVIEW_r708.md) actually claimed is narrower and is true**: *the string* `(1-\sigma)` occurs once in [findings/](../findings/). [L156](../findings/second-order.md)'s corollary widened that to "$\sigma$ has no definition on the record" and L157 to "it gives $\sigma$ the definition the record never had". *Searching by vocabulary rather than by value is the tell [Lemma L150](../findings/second-order.md)'s box names, and this is the same file.*

**What is genuinely new, stated so the entry can keep it.** Not the parameter and not its two roles, but that the two roles must be traded rather than frozen, and the number that comes out of trading them. **That is worth an entry; "the definition the record never had" is not, and it is the fourth novelty failure this file records.**

### The framing is one step worse than it needs to be

**With $\sigma$ free there is no third branch.** Branch $3$ is not a constraint of the same kind as branches $1$ and $2$: it is the statement that the $\lVert A''\rVert$ used to bound $r$ must be valid on $[0,r]$. Setting $\sigma:=r/\rho$ makes the whole thing one self-consistency condition,
$$r\;\le\;\frac{\sqrt{c(H)}}{\displaystyle\sup_{\lvert s\rvert\le r}\lVert A''(s)\rVert}\;=\;\frac{\sqrt c\,(\rho-r)^2}{2C\rho},$$
whose largest solution is $r=\sigma^*(t)\rho$, **the same answer, obtained without a max-min over an artificial minimum, and it is the fixed point [r450](REVIEW_r450.md) D7 and [r451](REVIEW_r451.md) A4 both declared absent** (*"$\rho$ does not depend on $r_n$, so there is no equation to solve, only a constraint to respect"*). They are right that $\rho$ carries no feedback and wrong that nothing does: the *bound* on $\lVert A''\rVert$ over $[0,r]$ does. **Recording that is a correction to two reviews, and it is stronger than what L157 claims.**

## C2, right shape, internally consistent, wrong constant, and branch 1 is not exempt

**The shape is the record's.** [r452](REVIEW_r452.md) B6 states branch $2$ as $\sqrt{c(H)}/\lVert A''(H)\rVert$ in those symbols, and [r450](REVIEW_r450.md) D7's display carries $\sqrt{c_p}/\lVert A''\rVert$ under the label "defect". **So the brief's alternative $\sqrt{2c/\lVert A''\rVert}$ is not what the record uses**, and C2's reconstruction is the right one: the $\sqrt c$ comes from the *quartic* tail $\tfrac14\lVert A''\rVert^2t^4$ measured against the margin $ct^2$, not from a second-order radius formula.

**The algebra checks.** $\lVert A''\rVert\le2M/((1-\sigma)\rho)^2\le2C/((1-\sigma)^2\rho)$ with $M\le C\rho$, so
$$\frac{\text{branch }2}{\rho}=\frac{\sqrt c}{\rho\lVert A''\rVert}=\frac{\sqrt c\,(1-\sigma)^2}{2C},\qquad t=\frac{\sqrt c}{2C}=\frac{\sqrt c}{2J\gamma}\ \ \text{since }J=C/\gamma.$$
**CONFIRMED as an identity.**

> **THE CONSTANT INSIDE $t$ IS NOT $1$, AND THE RECORD SAYS SO IN TWO PLACES.** [r450](REVIEW_r450.md) D3, re-derived by [r452](REVIEW_r452.md) B7 and [r453](REVIEW_r453.md) E5, gives the exact collapse $f(u^*)=2c/(S+\sqrt{S^2+a^2c})$, whose defect regime is $2\sqrt c/a$, **a factor $2$, and [r452](REVIEW_r452.md) B7 states in terms that the collapse "carries constants $1$ and $2$".** And $a$ is not $\lVert A''\rVert$: the quartic tail enters as $\lvert\kappa_n\rvert\tfrac14\lVert A''\rVert^2t^4$ against $ct^2$, so the branch is $2\sqrt{c/\lvert\kappa_n\rvert}/\lVert A''\rVert$, i.e. $\lambda\sqrt c/\lVert A''\rVert$ with $\lambda=2/\sqrt{\lvert\kappa_n\rvert}=1.53$ before any split of the margin between the cubic and quartic tails.

**Consequence, and it is not cosmetic: $t$ scales linearly in $\lambda$ and every number in C3–C5 is a function of $t$.** At the binding direction at $n=12$ (below), $t$ moves from $0.135$ to $0.206$, the correction of C4 from $20\%$ to $28\%$, and C5's headline from $3.2$ to $2.9$.

**And branch 1 is not untouched, which L157's closing paragraph asserts.** The two branches are the two regimes of one function, $f(u)=(c_p+u^2)/(S+au)$ ([Lemma L147](../findings/second-order.md), [r450](REVIEW_r450.md) D3), and $a\propto\lVert A''\rVert\propto(1-\sigma)^{-2}$. **So branch $1$ carries $\sigma$ too**; it merely loses it in the regime where $S$ dominates. *The effect runs the safe way here ($\sigma^*<\tfrac12$ lowers $\lVert A''\rVert$, so branch $1$ improves as well) and it is small, $S/(a\sqrt c)\approx5\%$ at $n=12$. But "the first branch is untouched" is false as a statement about the derivation, and it is the sentence that licenses treating the three-branch minimum as a two-branch crossing.*

## C3, confirmed, with the uniqueness argument the entry does not give

**The quadratic.** $\sigma=t(1-\sigma)^2$ is $t\sigma^2-(2t+1)\sigma+t=0$, roots $\sigma=\tfrac{2t+1\pm\sqrt{4t+1}}{2t}$. **CONFIRMED**, including the sign.

**Uniqueness, in one line rather than by inspection of the formula.** $\phi(\sigma):=\sigma-t(1-\sigma)^2$ has $\phi(0)=-t<0$, $\phi(1)=1>0$ and $\phi'(\sigma)=1+2t(1-\sigma)>0$ on $[0,1]$. **One root, for every $t>0$, and it is a crossing rather than a tangency.**

**The other root is spurious and the reason is structural.** The product of the roots is $t/t=1$, so they are reciprocal: the discarded root is $1/\sigma^*>1$, i.e. a reach exceeding the analyticity radius. **CONFIRMED, and worth stating that way**, reciprocity is cleaner than "the $+$ root is large".

**The expansion.** $\sqrt{1+4t}=1+2t-2t^2+4t^3-O(t^4)$ gives numerator $2t^2-4t^3$ and $\sigma^*=t-2t^2+O(t^3)$. **CONFIRMED.**

**The max-min.** $\sigma$ increases and $t(1-\sigma)^2$ decreases on $(0,1)$, both continuous, min $=0$ at both endpoints, so the minimum is maximised at the unique crossing. **CONFIRMED**, subject to C2's point that the honest objective also carries a mildly $\sigma$-decreasing branch $1$.

**A two-sided bound the entry should carry instead of the expansion.** From $\sigma^*\le t$ and $\sigma^*=t(1-\sigma^*)^2$,
$$t\,(1-t)^2\;\le\;\sigma^*(t)\;\le\;t .$$
*Both sides are exact inequalities at every $t>0$, so a proof can quote them where it cannot quote an $O(t^3)$.*

## C4, REFUTED: $\gamma$ does not cancel, and the displayed branch is a lower bound stated upward

**The exact identity, which is three lines and which the entry replaces with an asymptotic.**
$$\sigma^*\gamma\;=\;t(1-\sigma^*)^2\,\gamma\;=\;\frac{\sqrt{c_p+w^2}}{2J}\,(1-\sigma^*)^2 .$$
**So the surviving branch is**
$$r\;\ge\;\frac{\sqrt{c_p+w^2}\;g_n}{2J\,\lVert H\rVert_{op}}\cdot(1-\sigma^*)^2,\qquad (1-\sigma^*)^2\ \ge\ (1-t)^2,$$
**and the factor $(1-\sigma^*)^2<1$ is exactly what L157 drops.** *Dropping it enlarges a lower bound, which is the direction [r452](REVIEW_r452.md) B8 refuses for a dropped branch of a minimum and the direction this file has been corrected for three times.* The entry's own $\sigma^*\gamma=\tfrac{\sqrt c}{2J}(1+O(t))$ is honest; the sentence after it (*"so to leading order the second branch is $\sqrt{c_p+w^2}g_n/(2J^*\lVert H\rVert_{op})$"*), is the boxed conclusion, and as a bound it is false.

**Size of the omission (screen, $n=12$, $\lambda=1$).** $\theta_0(12)=1.23603$, $c_p=3\theta_0/10=0.37081$, $\alpha^*=1.1$, $C^*=42/11=3.81818$, $J^*=6.94215$:

| $w$ | $t$ | $\sigma^*$ | $(1-\sigma^*)^2$ | loss at $\sigma=\tfrac12$ |
|---|---|---|---|---|
| $0$ | $0.0797$ | $0.0691$ | $0.867$ | $3.47$ |
| $0.5$ | $0.1032$ | $0.0862$ | $0.835$ | $3.34$ |
| $0.829$ (binding) | $0.1347$ | $0.1073$ | $0.797$ | $3.19$ |
| $1$ | $0.1533$ | $0.1190$ | $0.776$ | $3.11$ |

**A $13$–$22\%$ overstatement across the sweep, $20\%$ where the bound binds, and $28\%$ once $\lambda=1.53$ is put back.** *This confirms the closed forms against each other; it is not evidence for the lemma.*

**It does not go away with $n$.** $t$ increases in $w$, and at $w=1$, $c\to1$ and $C^*\to4$, so $\sup_wt\to\tfrac18$ and $(1-\sigma^*)^2\to0.808$ at **every** dimension. **The $O(t)$ is bounded but bounded away from zero: "to leading order" is exact only as $w\to0$, and $w\to0$ is where [Lemma L148](../findings/second-order.md) removes branch $2$ altogether.** *So the answer to "is $O(t)$ uniform in $w$" is: uniformly bounded, never uniformly small, and largest exactly where the bound binds.*

### What survives of "$\gamma$ cancels", stated correctly

**$\gamma$ does not cancel, the objective depends on the contour through $J=C/\gamma$ **and**, at order $t$, through $C=J\gamma$ inside $t$.** What is true, and is a better statement, is that $J$ is *stationary* at L156's optimum, so using $J^*$ is right to second order. Re-deriving without the two-branch fiction: with $g_n/\lVert H\rVert_{op}$ normalised to $1$ and $C(\gamma)=K/(d-\gamma)$, $K=\alpha(1+\alpha)/d$, the self-consistency condition is
$$r\;\le\;\frac{\sqrt c\,(\gamma-r)^2(d-\gamma)}{2K\gamma},$$
whose right side is maximised at $\gamma^*=\tfrac d2+r+O(r^2)$, **the Cauchy radius $\gamma-r$, not the disc radius $\gamma$, is what wants to be $d/2$.** Substituting returns $r\le\tfrac{\sqrt c\,d^3}{8\alpha(1+\alpha)}\cdot\tfrac{1-2r/d}{1+2r/d}=\tfrac{\sqrt c}{2J^*}(1-4r/d+\cdots)$, i.e. **exactly C4's leading term, exactly the $-2t$ correction found above, and $\alpha^*=D/2$ unmoved.** *So L156's optimum is correct to $O(t^2)$ for this objective, which is more than L157 claims and by a route that does not need the word "cancels".*

### "No free parameter left" is false, and the entry lists two of the parameters itself

1. **$\lambda$, the constant of branch $2$'s numerator** (C2). It sits inside $t$, it is unpriced, and $\lvert\kappa_n\rvert$ alone puts it at $1.53$.
2. **$S=\sup\lvert P\rvert$**, [I31](../plan.md), which L157 concedes in its closing paragraph while the box above says "no free parameter".
3. **The $u\lesssim v\lesssim w$ constant**, which [r452](REVIEW_r452.md) B4 records as *asserted nowhere on the record and not proved there either*. It sets the net margin, hence $c$, hence the numerator of the very branch being priced.

**And $J^*<8$ is a supremum over $m$, not an absolute constant**: $J^*$ is $m$-dependent and increasing, $6.9421\le J^*<8$ on $m\ge6$. *If an absolute number is wanted, [r708](REVIEW_r708.md)'s fixed contour $(\alpha,\gamma)=(1,\tfrac12)$ gives $J\equiv8$ at every $m$ with no $n$-dependent contour, and that (not $J^*$), is the statement a proof should quote.*

## C5, the asymptotic is right, the located regime is wrong, and the two-orders claim is a slip

**The asymptotic.** At $\sigma=\tfrac12$ the minimum is $\min(\tfrac12,\tfrac t4)=\tfrac t4$ for $t<2$, and the loss $4\sigma^*/t\to4$ as $t\to0$. **CONFIRMED as a limit**, and the quoted $3.99/3.36/2.60$ at $t=10^{-3}/0.1/0.3$ reproduce.

> **NO DIMENSION IN THE PROGRAMME'S RANGE IS NEAR $4$.** At $n=12$ the loss runs $3.47$ at $w=0$ down to $3.11$ at $w=1$, is $3.19$ at the binding direction, and falls to $\approx2.9$ once $\lambda=1.53$ is restored. *[L156](../findings/second-order.md)'s corollary already says $3.4$ at $n=12$; L157 raises it to "approaching $4$" and then calls the loss at $w=0$ "essentially the full factor $4$", which is $3.47$.*

**The regime is misidentified, and the record refutes it twice.**

- **$w=0$ is where branch $2$ does not exist.** [Lemma L148](../findings/second-order.md) gives $A\equiv0$ identically on the margin summand, so $\lVert A''\rVert=0$ and the branch is unbounded; [r452](REVIEW_r452.md) B6 refuted precisely the habit of reading the surrogate $\sqrt{c_p+w^2}/(n^{1/2}+nw)$ as the branch at $w=0$. **L157 names as "the regime that matters" the one direction where the quantity it optimises is absent.**
- **$w=0$ is not the binding direction either.** Minimising $\sqrt{c_p+w^2}/(A+w)$ with the record's own $A=\lVert H_s\rVert_{op}\le1/\sqrt{m-1}=0.4472$ puts the interior minimum at $w^*=c_p/A=0.829$ at $n=12$, inside $[0,1]$, and $t$ there is $0.135$, not $\Theta(n^{-1/2})$'s $0.080$.

**"Larger than the true optimum by two orders in $n$" is wrong.** $\tfrac12/\sigma^*=\Theta(n^{1/2})$ (half a power of $n$) and at $n=12$, $w=0$ it is $0.5/0.0691=7.24$. *The frozen reach is too large by a factor $7$, which is worth saying; "two orders in $n$" is not what $\Theta(n^{1/2})$ says at any $n$.*

**One point in the entry's favour, which it does not make and should.** At $n=12$ the three branches are nowhere near each other in constants: branch $1$ is $c_p/\theta_0=0.30$ and branch $2$ at the binding direction is $\approx0.005$, a factor $\approx60$ apart. **So at the programme's own dimension branch $2$ decides the minimum outright**, which is exactly what makes its constants worth pinning, and it qualifies [Lemma L151](../findings/second-order.md)'s *"at $\beta=0$ all three branches are $\Theta(n^{-1})$, so a minimum over three branches cannot turn on $C$ alone"*, an order statement that is constant-false by $60\times$ at $n=12$.

## Corrections to make

1. **State the surviving branch as an inequality, not an asymptotic:** $r\ge\tfrac{\sqrt{c_p+w^2}\,g_n}{2J\lVert H\rVert_{op}}(1-\sigma^*)^2$ with $(1-\sigma^*)^2\ge(1-t)^2$, and record that the omitted factor is $13$–$22\%$ at $n=12$ and does not vanish with $n$ at $w=\Theta(1)$.
2. **Replace "$\gamma$ cancels" with the stationarity statement**: the contour enters through $J$, $J$ is stationary at $\gamma=d/2$, so $J^*$ is right to $O(t^2)$; the exact optimum is $\gamma-r=d/2$, i.e. $\gamma^*=d/2+r$.
3. **Price $t$'s numerator.** Branch $2$ is $\lambda\sqrt c/\lVert A''\rVert$ with $\lambda=2/\sqrt{\lvert\kappa_n\rvert}=1.53$ before the margin split, not $\lambda=1$; carry $\lambda$ through $t$ and re-quote every number.
4. **Withdraw "no free parameter left"** and list the three that remain, $\lambda$, $S$ ([I31](../plan.md)), and the $v\lesssim w$ constant ([r452](REVIEW_r452.md) B4), and quote $J\equiv8$ at the fixed contour if an absolute number is wanted.
5. **Withdraw "the definition the record never had."** [r450](REVIEW_r450.md) D7 carries the coupling in its own display and [Lemma L151](../findings/second-order.md)'s box carries the parameter as $\eta=\tfrac12$ with the constant $8$; what is new is the trade-off and its value.
6. **Move the regime.** The binding direction at $n=12$ is $w\approx0.83$, not $w=0$; at $w=0$ branch $2$ is vacuous by [Lemma L148](../findings/second-order.md). Replace "essentially the full factor $4$" with $3.47$ at $w=0$, $3.19$ at the binding direction, and $\approx2.9$ with $\lambda$ restored.
7. **Fix "two orders in $n$"** to $\Theta(n^{1/2})$, a factor $7.2$ at $n=12$.
8. **Reframe branch $3$** as the self-consistency $r\le\sqrt{c}/\sup_{\lvert s\rvert\le r}\lVert A''(s)\rVert$ rather than a third argument of a minimum, and record that this is the fixed point [r450](REVIEW_r450.md) D7 and [r451](REVIEW_r451.md) A4 both declared absent.
9. **Correct "the first branch is untouched"**: branch $1$ carries $\lVert A''\rVert$ through $f(u)=(c_p+u^2)/(S+au)$ and hence carries $\sigma$; the effect is $\approx5\%$ and runs the safe way, but the claim as written is false.

## What would refute this review

- **On C4**: a derivation in which the reach constraint is $r\le\sigma\rho$ with $\sigma$ fixed *independently* of the Cauchy margin, so that the value at the crossing is $\sigma^*\gamma$ with no $(1-\sigma^*)^2$ attached. **I could not construct one**, the two $\sigma$'s are the same number in [r450](REVIEW_r450.md) D7's display, which is the branch's only derivation on the record.
- **On C2's $\lambda$**: a place where branch $2$'s constant is derived and equals $1$. [r450](REVIEW_r450.md) D3's collapse and the $\lvert\kappa_n\rvert$ in the quartic tail both say otherwise, and [Lemma L151](../findings/second-order.md)'s box lists the $u\lesssim w$ constant as unknown.
- **On C1's novelty**: a reading under which "the record" excludes both [reviews/](.) and [Lemma L151](../findings/second-order.md)'s own withdrawal box. *That reading would also excuse the failure [Lemma L150](../findings/second-order.md)'s box was written to prevent.*

**Inherited without re-derivation**: [Lemma L156](../findings/second-order.md)'s $C(\alpha,\gamma)$ and its optimum (Gate 2 by [r705](REVIEW_r705.md), [r706](REVIEW_r706.md), corollary single-audited by [r708](REVIEW_r708.md)); [Lemma L146](../findings/second-order.md)'s $\lVert H\rVert_{op}\le1/\sqrt{m-1}$; [Lemma L148](../findings/second-order.md)'s vanishing; $c_p=3\theta_0/(n-2)$ from [Lemma L141](../findings/second-order.md); $M\le C\rho$ on the complex circle. **Whether $\lVert A''\rVert$ is saturated at $O(M/\rho^2)$ is untouched** ([r443](REVIEW_r443.md) item (iii)), so everything above bounds what this chain can prove and not the tube radius.
