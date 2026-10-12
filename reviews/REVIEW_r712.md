# Review r712, Gate 2 on [Lemma L158](../findings/second-order.md): the branch comparison, the parameter it says is missing, and the number it puts in $S$'s slot

*Reviewer r712, 2026-09-05, cold brief. Analysis only: every derivation below is hand algebra, and the sole computation is a re-evaluation of the record's own closed forms ($\theta_0(n)$, $c_n=3\theta_0/(n-2)$, $g(w)$, $\eta^*(t)$, $1+\sqrt{n-2}$), at the dimensions in scope, run as a screen on objects built for that purpose and reported as a screen. No sweep, census or search was opened.*

## Verdicts

| claim | verdict |
|---|---|
| **C1**, branch $1=(c+w^2)/S$ is increasing in $w$, so $\inf_w=\kappa/(nS)$ at $w=0$ | **CONFIRMED as calculus on the displayed function, REFUTED as a statement about the chain's branch 1.** The record derives branch $1$ as $f(u)=(c_p+u^2)/(S+au)$ with $f'(0)=-ac_p/S^2<0$ ([Lemma L147](../findings/second-order.md), [r450](REVIEW_r450.md) D3, restated in [Lemma L157](../findings/second-order.md)'s own "two couplings" paragraph). Its infimum is interior and **strictly below** $\kappa/(nS)$ |
| **C2**, branch $2$ has an interior minimum at $w^*=Bc/A$ of value $\tfrac{\lambda(1-\eta^*)^2}{n}\sqrt{\kappa/(1+\kappa)}$ | **REFUTED as stated, repairable.** With the lemma's own literal $A=n^{1/2}$, $B=n$ the stationary point is $w^*=\kappa n^{-1/2}$, and $\kappa^2=18(n-1)/(n-2)>18$ puts it **outside $[0,1]$ for every $n\le19$**, $n=12$ included, where $w^*=1.2845$. Under the record's actual constant $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$ the stationary point is $w^*=3\sqrt{n-1}/n\in(0,1)$ for $n\ge8$, but then it is not $Bc/A$ and the value is not the displayed one, which overstates the minimum by $12\%$ at $n=12$. The prefactor is also $w$-dependent and may not be pulled out |
| **C3**, the ratio is $\sqrt{\kappa(1+\kappa)}/(S\lambda(1-\eta^*)^2)$, with no $n$ | **PLAUSIBLE at the order level, REFUTED as "no $n$".** $\kappa=\kappa(n)$ and $\eta^*=\eta^*(n)$, both explicitly; and in the regime C2 actually lives in ($n\le19$, endpoint minimum) the corrected ratio carries a bare $(1+n^{-1/2})$, a $29\%$ term at $n=12$. What is true and is the content: the ratio is $\Theta(1)$, no power of $n$ |
| **C4**, branch 1 binds, and [I31](../plan.md)'s constant is load-bearing, iff $S>\sqrt{\kappa(1+\kappa)}/(\lambda(1-\eta^*)^2)$ | **CONFIRMED as algebra, REFUTED in its evaluation, and the evaluation reverses the answer.** The slot marked $S$ must carry a **proved upper bound** on $\sup\lvert P\rvert$; the lemma fills it with $1.5449$, which is not a bound and is not $\sup\lvert P\rvert$, it is the supremum of the *relaxation bound* $\lambda_{\max}p+B_5$, an identification the record has withdrawn **twice** ([Lemma L142](../findings/bounds.md), [r444](REVIEW_r444.md) D6, [r445](REVIEW_r445.md) D1). With the record's proved $S\le1+\sqrt{n-2}$ ([Lemma L143](../findings/bounds.md)) branch $1$ binds at every $n\ge14$ |
| **C5**, $R(w)=\sqrt{c+w^2}(A+Bw)/(S\lambda(1-\eta^*)^2)$ increases from $\sqrt\kappa/(S\lambda(1-\eta^*)^2)$ to $\Theta(n^{1-\beta})$ | **CONFIRMED**, in every part, and it is the one claim that needs no repair. Two riders: $R(0)$ is formal, since [Lemma L148](../findings/second-order.md) empties branch $2$ there; and the $w$-dependence of $(1-\eta^*)^2$ strengthens rather than threatens the monotonicity |
| **C6**, what blocks evaluating C4 is $\kappa$, which the record fixes only through $c_p=\kappa/n$ and never names | **REFUTED.** $\kappa$ is on the record in closed form and as an **attained** constant: [Lemma L141](../findings/second-order.md)(b) gives $c_n=3\theta_0(n)/(n-2)$ and says it is attained; [Lemma L146](../findings/second-order.md) restates it as $3\theta_0(\tfrac12-\lambda_m)$; and [r709](REVIEW_r709.md), the review L158 names as its own provenance, evaluates it as $c_p=3\theta_0/10=0.37081$ at $n=12$ and lists it among what it inherits. Hence $\boxed{\kappa^2=18(n-1)/(n-2)}$, i.e. $\kappa=3\sqrt{2(n-1)/(n-2)}$, from $4.44972$ at $n=12$ down to $3\sqrt2=4.24264$ |

**One-line verdict: the algebra of the comparison is sound and C5 is exactly right; the lemma then declares missing a constant it inherits from its own cited source, states an interior minimum that lies outside the interval at the dimension in scope, and evaluates its criterion with a measured number that is neither $\sup\lvert P\rvert$ nor an upper bound on it, and the corrected inputs flip the conclusion, so [I31](../plan.md) stays load-bearing.**

## C6 first, because it decides the others, $\kappa$ is named, exactly, three lines of algebra away

**The chain, all of it on the record.** [Lemma L141](../findings/second-order.md)(b) proves $Q(H)\le-c_n\lVert H\rVert^2$ with
$$c_n=\frac{3\,\theta_0(n)}{n-2},\qquad\text{"and this is attained, so the constant is unimprovable."}$$
[Lemma L146](../findings/second-order.md) restates the same number as the margin on the two $S^2_0(\mathbb R^m)$ summands: *"Both reviewers confirmed the margin is exactly [Lemma L145](../findings/second-order.md)'s $c_p$: $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$"*, which checks, since $\tfrac12-\lambda_m=\tfrac1{2(m-1)}=\tfrac1{n-2}$ at $m=n/2$. And [conventions.md](../findings/conventions.md) fixes $\theta_0(n)^2=2(n-1)(n-2)/n^2$ *"and nothing more"*. Therefore
$$\kappa\;=\;n\,c_p\;=\;\frac{3n\,\theta_0(n)}{n-2},\qquad \kappa^2=\frac{9n^2}{(n-2)^2}\cdot\frac{2(n-1)(n-2)}{n^2}=\frac{18(n-1)}{n-2}.$$

| $n$ | $12$ | $16$ | $20$ | $48$ | $\to\infty$ |
|---|---|---|---|---|---|
| $\kappa$ | $4.44972$ | $4.39155$ | $4.35890$ | $4.28851$ | $3\sqrt2=4.24264$ |

**It is decreasing in $n$ and bounded in $[3\sqrt2,\,3\sqrt{2.2}]$ on $n\ge12$.** *So $c_p=\kappa/n$ with $\kappa$ absolute is itself a mild abuse: $\kappa$ moves by $5\%$ across the range, which is the first half of C3's failure.*

> **AND [r709](REVIEW_r709.md) HAD IT NUMERICALLY.** Its C4 screen opens *"$\theta_0(12)=1.23603$, $c_p=3\theta_0/10=0.37081$"* and its inherited-without-re-derivation list closes with *"$c_p=3\theta_0/(n-2)$ from [Lemma L141](../findings/second-order.md)"*. **$12\times0.37081=4.44972$.** L158's provenance line is *"derived 2026-09-05 ... after [r709](REVIEW_r709.md) observed that branch 2 alone decides the radius at $n=12$"*, so the value sits in the document the lemma is built on.

> **THIS IS THE FAILURE MODE THE FILE RECORDS TWICE, AND [LEMMA L157](../findings/second-order.md) IS TWELVE LINES ABOVE.** L157's own opening reads: *"The first version of this lemma said the record had no definition for it; that was a search by vocabulary rather than by object."* [Lemma L150](../findings/second-order.md)'s box names the same thing. **L158 then writes "it is a number the record has never named" about a constant the record names under a different letter ($c_n$ in L141, $c_p$ in L145/L146/L149), in the same file.** *The brief for this review asked whether $\kappa$ is really unnamed; it is not, and searching for the letter rather than the value is exactly how it stayed hidden.*

**Consequence, immediate and large.** L158's closing paragraph says branch $1$ binds when $\sqrt{\kappa(1+\kappa)}<1.91$, i.e. *"$\kappa<1.42$"*. Two things are wrong. **The arithmetic**: the root of $\kappa(1+\kappa)=1.91^2$ is $\kappa=1.4744$, not $1.42$. **And the answer**: $\kappa^2>18$ at every $n$, against a requirement $\kappa^2<2.17$, the test fails by a factor $8$ in $\kappa^2$, which is not a near miss to be settled later. *At the number L158 puts in $S$'s slot, the criterion is decided, and decided against the lemma's suggestion.*

**A notation collision worth fixing while the entry is open.** This chain now carries $\kappa$ (this lemma, $=nc_p$), $\kappa_n$ (the penalty coefficient, $\lvert\kappa_n\rvert=1.7053$, and $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ is built from it), and $\kappa_n^{\mathrm{Hess}}$ ([Lemma L141](../findings/second-order.md)). *Three $\kappa$'s, two of them inside the same displayed ratio.* **Retire the new one: write $nc_p$, or keep $c_p=3\theta_0/(n-2)$ and never introduce $\kappa$ at all**, which also removes C3's spurious "absolute constant" framing.

## C2, the interior minimum is outside the interval at the dimension in scope, under the lemma's own $A$

**The calculus is right.** With $g(w)=\sqrt{c+w^2}/(A+Bw)$,
$$g'(w)=\frac{wA-Bc}{\sqrt{c+w^2}\,(A+Bw)^2},$$
so the sign statement and the stationary point $w^*=Bc/A$ are **CONFIRMED**, as is $g(w^*)=\sqrt c/\sqrt{A^2+B^2c}$, which at $A=n^{1/2}$, $B=n$, $c=\kappa/n$ is $\tfrac1n\sqrt{\kappa/(1+\kappa)}$. *All of that is [Lemma L149](../findings/second-order.md)'s and it survives.*

> **BUT $w$ RANGES OVER $[0,1]$ AND $w^*=\kappa n^{-1/2}$ DOES NOT.** [Lemma L149](../findings/second-order.md) states its own uniformity *"uniformly in $w\in[0,1]$"*, $w=\lVert H_r\rVert$ being the weight of a unit direction outside both margin summands. With $\kappa^2=18(n-1)/(n-2)$,
> $$w^*\le1\iff\kappa^2\le n\iff n^2-20n+18\ge0\iff n\ge10+\sqrt{82}=19.055.$$
> **So for every $n$ from $12$ to $19$ the stationary point is outside the admissible interval and the minimum over $[0,1]$ is the endpoint $w=1$.** At $n=12$, $w^*=1.2845$.

**What that does to the value.** $b_2$ at $w=1$ is $\lambda(1-\eta^*)^2\sqrt{c+1}/(A+B)$ against the claimed $\lambda(1-\eta^*)^2 n^{-1}\sqrt{\kappa/(1+\kappa)}$. Since $g$ is flat near its minimum the numerical cost is small, $0.0939$ against $0.0934$ per unit prefactor at $n=12$, a $0.55\%$ overstatement, **but the direction is the one this file has been corrected for three times: a lower bound stated upward.**

### The deeper fault: $A=n^{1/2}$ is a schematic order, and the record's own constant is different

**[Lemma L146](../findings/second-order.md) gives $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}=\sqrt{2/(n-2)}$**, which [r709](REVIEW_r709.md) uses directly: *"Minimising $\sqrt{c_p+w^2}/(A+w)$ with the record's own $A=\lVert H_s\rVert_{op}\le1/\sqrt{m-1}=0.4472$ puts the interior minimum at $w^*=c_p/A=0.829$ at $n=12$."* [Lemma L149](../findings/second-order.md)'s display $\sqrt{c_p+w^2}/(n^{1/2}+nw)$ reads that $\Theta(n^{-1/2})$ as exactly $n^{-1/2}=0.2887$, **too small by $\sqrt{2n/(n-2)}=1.549$ at $n=12$**, and $w^*$ is inversely proportional to it. With the honest constant,
$$w^*=\frac{c_p}{\sqrt{2/(n-2)}}=\frac{3\theta_0}{\sqrt{2(n-2)}}=\frac{3\sqrt{n-1}}{n},\qquad w^*\le1\iff n^2-9n+9\ge0\iff n\ge7.854,$$
so the interior minimum **is** attained for every $n\ge8$, at $0.8292$ at $n=12$ and $0.4285$ at $n=48$. **The lemma's conclusion is recoverable; its formula $w^*=Bc/A=\kappa n^{-1/2}$ is not, and the two disagree by $55\%$ at $n=12$, $1.2845$ against $0.8292$.** *This is also the reason [Lemma L157](../findings/second-order.md), sixteen lines above, quotes a binding direction of $0.829$ while L158 computes $1.28$ from the same chain: the record carries two incompatible values of $w^*$ in adjacent entries, and neither cites the other.*

**And the minimum value moves with it.** $g(w^*)=\sqrt c/\sqrt{A'^2+c}$ with $A'^2=2/(n-2)$ rather than $1/n$ gives $0.60894/0.75552=0.80599$ against $\sqrt{\kappa/(1+\kappa)}=0.90337$, **the displayed value overstates the branch-2 minimum by $12.1\%$ at $n=12$**, again upward.

### The prefactor is inside the minimisation, not outside it

$\lambda(1-\eta^*)^2$ is treated as a constant while $w$ is varied. **It is not**: [Lemma L157](../findings/second-order.md) defines $\eta^*=\eta^*(t)$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$, so $t$ increases in $w$, $\eta^*$ increases, and $(1-\eta^*)^2$ **decreases** in $w$. Carrying $\lambda=1.53$ inside $t$ as [r709](REVIEW_r709.md)'s correction 3 requires, at $n=12$ with $C^*=3.81818$:

| $w$ | $0$ | $0.829$ (the true minimiser) | $1$ |
|---|---|---|---|
| $t$ | $0.1220$ | $0.2061$ | $0.2346$ |
| $\lambda(1-\eta^*)^2$ | $1.2420$ | $1.1075$ | $1.0694$ |

*(Screen: the entries re-evaluate L157's own closed form; they confirm the closed forms against each other and are not evidence for anything positive.)*

> **L158'S $\lambda(1-\eta^*)^2\approx1.24$ IS THE VALUE AT $w=0$, WHICH IS THE ONE DIRECTION ITS OWN CAVEAT SAYS BRANCH $2$ IS ABSENT.** [Lemma L148](../findings/second-order.md) empties branch $2$ at $w=0$; L158 quotes it in its caveat paragraph and then prices the branch's prefactor there. **At the direction where branch $2$ actually attains its minimum the prefactor is $1.1075$, so the threshold on $S$ is $12\%$ higher than the lemma states.** *The same slip is visible in the $1.24$ itself: it also equals $\lambda\times0.808$ with $0.808$ read off L157's $t\to\tfrac18$ asymptotic, which is the $n\to\infty$, $\lambda=1$ number multiplied by $\lambda$ a second time.*

**Whether the monotonicity survives**: yes, and it helps. $(1-\eta^*)^2$ decreasing in $w$ pushes the minimiser right and lowers the minimum, so the corrected branch-2 minimum is smaller still, again the direction that raises the threshold on $S$.

## C1, the record's branch 1 has $w$ in its denominator, and says so twice

**As calculus, trivially CONFIRMED**: $(c+w^2)/S$ with $S$ independent of $w$ is increasing, infimum $c/S=\kappa/(nS)$ at $w=0$. **$S=\sup\lvert P\rvert$ is a supremum over the unit sphere of $\mathcal W_n$ and carries no dependence on $H$ or $w$**, the brief's question about the denominator is answered in the affirmative for *this* display.

> **BUT IT IS NOT THE CHAIN'S BRANCH 1.** [Lemma L147](../findings/second-order.md) states, in bold, in this file: *"$f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=-ac_p/S^2<0$, so $u=0$ is **never** its minimum; the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$."* [Lemma L157](../findings/second-order.md) repeats it: *"Branches 1 and 2 are two regimes of the single $f(u)=(c_p+u^2)/(S+au)$ with $a\propto(1-\eta)^{-2}$, so **branch 1 is not untouched**."* [r709](REVIEW_r709.md)'s correction 9 is the same point. **L158 restores the very display L147 was corrected for**, three entries below the correction.

**Which way the error runs, and it runs against L158.** $\inf_w(c_p+w^2)/(S+aw)<c_p/S$, so the true $\inf$ of branch $1$ is **smaller** than $\kappa/(nS)$: the ratio in C3 is an **overestimate**, the threshold on $S$ is an **overestimate**, and branch $1$ binds more easily than the lemma allows. L157 prices the effect at $\approx5\%$ at $n=12$. *So C1's defect and C2's both push the same way, and both push toward "[I31](../plan.md) is load-bearing".*

**The cleaner statement the record already owns, which removes the two-branch fiction entirely.** [r450](REVIEW_r450.md) D3's exact collapse is $f(u^*)=2c/(S+\sqrt{S^2+a^2c})$. Branch $1$ dominates iff $S\gg a\sqrt c$ and branch $2$ iff $a\sqrt c\gg S$, with the crossover at $S=a\sqrt c$ giving $f(u^*)=0.828\,c/S$. **So "which branch binds" is exactly "which term dominates $\sqrt{S^2+a^2c}$", derived from one function with no minimum-of-two-surrogates step and with correct constants at the crossover.** *That is the form the lemma should carry.*

## C3, $\Theta(1)$ is the content; "no $n$" is false twice, and a third time in the endpoint regime

**The algebra is right.** $\dfrac{\kappa/(nS)}{\lambda(1-\eta^*)^2n^{-1}\sqrt{\kappa/(1+\kappa)}}=\dfrac{\sqrt{\kappa(1+\kappa)}}{S\lambda(1-\eta^*)^2}$, since $\kappa/\sqrt{\kappa/(1+\kappa)}=\sqrt{\kappa(1+\kappa)}$. **CONFIRMED as a manipulation.**

**Three carriers of $n$ inside the "no $n$" expression.**

- **$\kappa=3\sqrt{2(n-1)/(n-2)}$**, a $5\%$ range on $n\ge12$, so $\sqrt{\kappa(1+\kappa)}$ runs $4.9244$ down to $4.7183$.
- **$\eta^*$**, through $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ with $c_p=\kappa/n$ and $J=J^*(m)$ itself $m$-dependent ($6.9421\le J^*<8$, [r709](REVIEW_r709.md)). A further few percent.
- **The endpoint regime.** Where $w^*>1$ (every $n\le19$ under the lemma's own $A$, including the only dimension it evaluates), the honest ratio is
$$\frac{\inf b_1}{\inf_{[0,1]}b_2}=\frac{\kappa\,(1+n^{-1/2})}{S\,\lambda(1-\eta^*)^2\,\sqrt{1+\kappa/n}},$$
**with a bare $n^{-1/2}$ that does not cancel, a $29\%$ term at $n=12$.** *It happens to be nearly offset by $\sqrt{1+\kappa/n}$, so the number moves only $0.5\%$; the claim "with no $n$ in it" is still false, and the near-cancellation is an accident of $n=12$.*

**What survives, and it is the lemma's real result.** *The ratio is $\Theta(1)$: both branch minima are $\Theta(1/n)$ with the same power, so the comparison is between constants and no dimension can decide it.* **That is worth an entry. "With no $n$ in it" is a stronger claim than the algebra supports and is the sentence the box should lose.**

## C4, the algebra is right, and the number put into $S$ is the error the record has withdrawn twice

**The equivalence is CONFIRMED**: the ratio is $<1$ (branch $1$ the smaller, hence binding), iff $S>\sqrt{\kappa(1+\kappa)}/(\lambda(1-\eta^*)^2)$, given C2 and C3.

**Two structural questions the brief raises, both answered in the lemma's favour.**

- **$\inf_w\min(b_1,b_2)=\min(\inf_wb_1,\inf_wb_2)$ holds unconditionally**, for any two functions on any set: $\le$ because the left side is below each, $\ge$ because $\min(b_1,b_2)(w)\ge\min(\inf b_1,\inf b_2)$ pointwise. **So comparing separately-taken infima cannot invert the minimum here, and the lemma does not need a hypothesis it lacks.** *And [Lemma L148](../findings/second-order.md) removing branch $2$ at $w=0$ is handled by reading $b_2(0)=+\infty$, which raises the pointwise minimum at $w=0$ and leaves $\inf b_1$ untouched, the caveat is about interpretation, not about validity.*
- **Dropping branch $3$ is legitimate**, though L158 never says why: [Lemma L157](../findings/second-order.md)'s $\eta^*$ is the branch-$2$/branch-$3$ crossing, so the prefactor $(1-\eta^*)^2$ **is** branch $3$, already merged. *State it; a reader checking a three-branch minimum against a two-branch comparison has no way to see it.*

> **WHAT IS WRONG IS THE INPUT. $1.5449$ IS NOT $\sup\lvert P\rvert$, AND THE RECORD SAYS SO IN THREE PLACES.** [second-order.md](../findings/second-order.md) line 380 is explicit that $1.544872$, $1.545809$, $1.546426$, $1.5449$ are values of the **relaxation bound** $\lambda_{\max}p+B_5$ reached by ascent, at a point whose actual $\theta$ is $1.2238$. [r444](REVIEW_r444.md) D6 and [r445](REVIEW_r445.md) D1 each refuted the identification, [Lemma L142](../findings/bounds.md) was withdrawn for it, and [bounds.md](../findings/bounds.md) now carries the corrected sentence: *"not the $\approx1.5449$ an earlier version wrote here, which is the supremum of the relaxation bound rather than of $P$ ... [L142](../findings/bounds.md)'s withdrawn framing error repeated eighteen lines below its own withdrawal notice."* **L158 is the third repetition.**

> **AND EVEN THE RIGHT KIND OF NUMBER WOULD BE THE WRONG ONE. The chain needs an upper bound on $\sup\lvert P\rvert$, because branch $1$ is $c/S$ and only an upper bound on $S$ lower-bounds it.** A measured value from an ascent bounds nothing. The record's proved bound is [Lemma L143](../findings/bounds.md): $\sup\lvert P\rvert\le1+\sqrt{n-2}$.

### Evaluating C4 with the record's proved input, and with the corrected prefactor

| $n$ | $\kappa$ | threshold $\sqrt{\kappa(1+\kappa)}/\lambda(1-\eta^*)^2$ | proved $S=1+\sqrt{n-2}$ | binds |
|---|---|---|---|---|
| $12$ | $4.4497$ | $4.446$ | $4.162$ | branch $2$, by $6.4\%$ |
| $14$ | $4.4159$ | $4.333$ | $4.464$ | **branch $1$** |
| $16$ | $4.3916$ | $4.245$ | $4.742$ | **branch $1$** |
| $24$ | $4.3380$ | $4.018$ | $5.690$ | **branch $1$** |
| $48$ | $4.2885$ | $3.736$ | $7.782$ | **branch $1$** |

*(Screen: the prefactor column re-evaluates L157's $\eta^*(t)$ at each dimension's own $w^*=3\sqrt{n-1}/n$ with $\lambda$ carried inside $t$.)*

**The threshold is bounded, it lives in $[3.7,4.5]$ at every $n$, while the proved $S$ is $\Theta(n^{1/2})$ and unbounded. So branch $1$ binds at every $n\ge14$, and by a growing margin.** *This is not a new conclusion: [plan.md](../plan.md)'s [I31](../plan.md) already says it in exponent form, $r_n\gtrsim n^{-1-\beta}$ with $\beta\in[0,\tfrac12]$, $\beta=\tfrac12$ from L143, and the item "buys an exponent". L158's contribution is to make it a constant-level statement, which is genuinely useful; its evaluation then contradicts the plan item it is about, because of the number in $S$'s slot.*

**And it is undecided at $n=12$, inside the unpriced constants.** $4.162$ against $4.446$ is $6\%$, while C1's omitted $au$ is $5\%$ the other way, [Lemma L146](../findings/second-order.md)'s constant moves the branch-$2$ minimum $12\%$, and [r710](REVIEW_r710.md) prices $\Lambda\in[1,2]$ inside $t$, a factor $2$. **The honest statement at $n=12$ is that the criterion is inside the error bars of its own inputs; the honest statement at $n\ge16$ is that branch $1$ binds.**

### The reformulation that makes the criterion readable, and answers "are $\beta$ and $S$ independent of $\kappa$"

**They are not independent, and the dependence is the whole story.** $\theta_0$ sits in both: $\kappa=3n\theta_0/(n-2)$, and $S=\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$, the inequality that forces $\beta\ge0$ in the first place. Writing $S=s\,\theta_0(n)$, so that $s\ge1$ measures how far the supremum of $P$ exceeds its value at the balanced orbit, the criterion becomes
$$s\;>\;\frac{3n}{(n-2)\,\lambda(1-\eta^*)^2}\sqrt{\frac{1+\kappa}{\kappa}}\;=\;3.59\ (n=12),\quad3.12\ (n\to\infty).$$

> **SO L158'S CRITERION SAYS: BRANCH $1$ BINDS IFF $\sup\lvert P\rvert$ EXCEEDS ITS BALANCED-ORBIT VALUE BY A FACTOR OF ABOUT $3.1$–$3.6$.** Under Conjecture A itself, $\sup\lvert P\rvert=\Theta_n=\theta_0(n)$ at even $n$, i.e. $s=1$, **branch $1$ never binds and [I31](../plan.md)'s constant is not load-bearing.** Under the record's proved $s=(1+\sqrt{n-2})/\theta_0(n)=3.37$ at $n=12$ and $\to\infty$, **it is.** *The criterion is therefore not "an inequality between absolute constants" at all: it is a statement about the gap between what is conjectured and what is proved, and it cannot be evaluated without deciding how much of that gap [I31](../plan.md) closes.* **That is a sharper and more useful reading of the lemma's own algebra than the one it states, and it is what the entry should say.**

## C5, CONFIRMED, and it is the part of the entry that needs nothing

$$R(w)=\frac{b_1(w)}{b_2(w)}=\frac{(c+w^2)/S}{\lambda(1-\eta^*)^2\sqrt{c+w^2}/(A+Bw)}=\frac{\sqrt{c+w^2}\,(A+Bw)}{S\,\lambda(1-\eta^*)^2},$$
a product of two positive increasing factors, hence increasing. $R(0)=\sqrt{c}A/(S\lambda(1-\eta^*)^2)=\sqrt{\kappa/n}\cdot n^{1/2}/(\cdots)=\sqrt\kappa/(S\lambda(1-\eta^*)^2)$, the $n$ cancelling exactly as the lemma says. $R(1)=\sqrt{1+c}(n^{1/2}+n)/(S\lambda(1-\eta^*)^2)=\Theta(n/S)=\Theta(n^{1-\beta})$ at $S=\Theta(n^\beta)$. **Every part checks.**

**Two riders, neither a defect.**

- **$R(0)$ is formal.** [Lemma L148](../findings/second-order.md) makes $b_2(0)=+\infty$, so $R(0^+)$ is a limit of a ratio whose denominator is absent at the endpoint. *Say "extends continuously to $\sqrt\kappa/(S\lambda(1-\eta^*)^2)$ as $w\downarrow0$", not "from".*
- **$(1-\eta^*)^2$ decreasing in $w$ makes $R$ increase strictly faster**, so the monotonicity is robust to the C2 defect. **The one honest use of C5 is the crossing**: with $\kappa=4.4497$ and the proved $S=4.162$ at $n=12$, $R(0^+)=2.109/(4.162\times1.242)=0.408<1$ and $R$ crosses $1$ at $w\approx0.27$, **so branch $1$ is pointwise the smaller one on most of the interval**, which is the pointwise picture the lemma defers to a successor and which its own $R$ delivers in one line.

## Corrections to make

1. **Withdraw "a number the record has never named."** Record $\kappa=3n\theta_0(n)/(n-2)$, $\kappa^2=18(n-1)/(n-2)$, from [Lemma L141](../findings/second-order.md)(b)'s attained $c_n$ and [Lemma L146](../findings/second-order.md)'s restatement, with [r709](REVIEW_r709.md)'s $0.37081$ at $n=12$ as the check. Note it is $n$-dependent, $4.4497\downarrow3\sqrt2$.
2. **Retire the letter $\kappa$** in favour of $nc_p$: the chain already carries $\kappa_n$ and $\kappa_n^{\mathrm{Hess}}$, and $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ appears inside the same display.
3. **Fix "$\kappa<1.42$" to $\kappa<1.4744$**, and then record that $\kappa^2>18$ makes the test fail by a factor $8$ at the $S$ the lemma uses, the criterion is decided there, not open.
4. **Replace $A=n^{1/2}$ with [Lemma L146](../findings/second-order.md)'s $\lVert H_s\rVert_{op}\le\sqrt{2/(n-2)}$**, giving $w^*=3\sqrt{n-1}/n\in(0,1)$ for $n\ge8$ and $g(w^*)=\sqrt c/\sqrt{2/(n-2)+c}$. **State that under the schematic $A=n^{1/2}$ the stationary point leaves $[0,1]$ for every $n\le19$**, and reconcile with [Lemma L157](../findings/second-order.md)'s $w^*=0.829$, which the entry currently contradicts without noticing.
5. **Move the prefactor inside the minimisation.** Quote $\lambda(1-\eta^*)^2=1.1075$ at the minimiser, not $1.24$, which is its value at $w=0$ where [Lemma L148](../findings/second-order.md) removes the branch; carry $\lambda$ inside $t$ per [r709](REVIEW_r709.md)'s correction 3 rather than as a bare multiplier.
6. **Restore branch 1's denominator.** Write $f(u)=(c_p+u^2)/(S+au)$ per [Lemma L147](../findings/second-order.md) and [r450](REVIEW_r450.md) D3, note $\inf b_1<\kappa/(nS)$, and prefer the exact collapse $f(u^*)=2c/(S+\sqrt{S^2+a^2c})$, "which branch binds" is "which term dominates $\sqrt{S^2+a^2c}$", one function, correct constants at the crossover.
7. **Downgrade "with no $n$ in it" to $\Theta(1)$**, listing $\kappa(n)$, $\eta^*(n)$ and, in the endpoint regime, the surviving $(1+n^{-1/2})$.
8. **Delete $1.5449$.** It is the supremum of $\lambda_{\max}p+B_5$, refuted as $\sup\lvert P\rvert$ by [r444](REVIEW_r444.md) D6 and [r445](REVIEW_r445.md) D1 and withdrawn with [Lemma L142](../findings/bounds.md); and a measured value cannot occupy a slot that needs a proved **upper** bound. Use [Lemma L143](../findings/bounds.md)'s $S\le1+\sqrt{n-2}$.
9. **Reverse the conclusion.** With the proved $S$, branch $1$ binds at every $n\ge14$ and the threshold is bounded while $S$ is $\Theta(n^{1/2})$: **[I31](../plan.md) is load-bearing**, as [plan.md](../plan.md) already says in exponent form. At $n=12$ the criterion is inside its own error bars ($6\%$ against unpriced constants of $5$–$100\%$).
10. **State the criterion in the form that reads.** With $S=s\,\theta_0(n)$: branch $1$ binds iff $s>3.1$–$3.6$, i.e. iff $\sup\lvert P\rvert$ exceeds its balanced-orbit value by that factor. **Under Conjecture A ($s=1$) it does not; under the proved bound ($s=3.37$ at $n=12$, growing) it does.**
11. **Say why branch 3 is absent**, [Lemma L157](../findings/second-order.md)'s $\eta^*$ already merges it into the prefactor, and record that $\inf\min=\min\inf$ is an identity, so the two-infima comparison needs no extra hypothesis.
12. **Add the pointwise crossing**, which C5 gives free: at $n=12$ with the proved $S$, $R=1$ at $w\approx0.27$, so branch $1$ is pointwise smaller on $[0.27,1]$.

## What would refute this review

- **On C6**: a reading under which $c_n$ of [Lemma L141](../findings/second-order.md)(b) and $c_p$ of [Lemma L146](../findings/second-order.md)/[Lemma L149](../findings/second-order.md) are different constants. **I could not construct one**, [Lemma L146](../findings/second-order.md) names them equal in its own sentence, [r709](REVIEW_r709.md) cites L141 as $c_p$'s source, and $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ checks against $\lambda_m=(m-2)/(2(m-1))$ at $m=n/2$.
- **On C2**: a place where $w$ is *not* confined to $[0,1]$, but $w=\lVert H_r\rVert$ for a unit $H$, and [Lemma L149](../findings/second-order.md) states the interval in its own uniformity clause.
- **On C4**: a proved upper bound on $\sup\lvert P\rvert$ below $\approx3.7$ at some $n\ge14$. [Lemma L143](../findings/bounds.md)'s $1+\sqrt{n-2}$ and [Lemma L70](../findings/bounds.md)'s $n-2$ are the record's two, and both exceed it from $n=14$. *Producing one is exactly [I31](../plan.md), which is the point.*
- **On C1**: a derivation in which the cubic branch's denominator is $S$ alone. [Lemma L147](../findings/second-order.md) was corrected **for** that reading, in bold, in the same file.

**Inherited without re-derivation**: [Lemma L157](../findings/second-order.md)'s $\eta^*(t)$ and the crossing (Gate 2 by [r709](REVIEW_r709.md), [r710](REVIEW_r710.md), agreeing); $\lambda=2/\sqrt{\lvert\kappa_n\rvert}=1.53$ and $C^*=3.81818$, $J^*=6.94215$ at $n=12$ ([r709](REVIEW_r709.md)); [Lemma L148](../findings/second-order.md)'s vanishing; [Lemma L146](../findings/second-order.md)'s $\lVert H\rVert_{op}\le1/\sqrt{m-1}$; [Lemma L143](../findings/bounds.md)'s $1+\sqrt{n-2}$; $\theta_0(n)^2=2(n-1)(n-2)/n^2$ from [conventions.md](../findings/conventions.md). **Whether the chain itself lower-bounds the true tube radius tightly is untouched**: everything above compares two branches of a lower bound, so it bounds what this chain can prove and not $r_n$.
