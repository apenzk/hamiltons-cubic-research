# Review r714, Gate 2 on [Lemma L158](../findings/second-order.md)'s settlement paragraph: does $J$ divide, and can the threshold be pinned?

*Reviewer r714, 2026-09-05, cold brief, analysis-only. Every derivation below is hand algebra against the definitions in [L156](../findings/second-order.md), [L157](../findings/second-order.md), [L149](../findings/second-order.md) and [conventions.md](../findings/conventions.md). Computation used: five screens of seconds each, re-evaluating the record's own closed forms ($\theta_0(n)$, $c_p$, $g_n$, $C(\alpha,\gamma)$, $\eta^*(t)$), on objects built for that purpose, reported as screens and never as evidence for a positive claim. No sweep, census, optimisation or falsifier hunt was opened. Every constant below was located by its **defining relation and value**, not by its letter: $J$ via $C/\gamma$ and $C(1/2,1/4)=6$ against [L152](../findings/second-order.md)'s recorded $M\le6\rho$; $a_0$ via $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$; $1/g_n$ via $\lvert\lambda_-\rvert$.*

## Verdicts

| claim | verdict |
|---|---|
| **C1**, $\lVert A''\rVert\le2M/((1-\eta)\rho)^2$, $M\le C\rho$, $\rho=\gamma g_n/\lVert H\rVert_{op}$ give $\lVert A''\rVert\le2J\lVert H\rVert_{op}/((1-\eta)^2g_n)$, $J=C/\gamma$ | **CONFIRMED.** The algebra is exact and every premise is [L156](../findings/second-order.md)'s own. $M\le C\rho$ is verified independently: $C(\tfrac12,\tfrac14)=\tfrac{0.5\cdot1.5}{0.5\cdot0.25}=6$ reproduces [r441](REVIEW_r441.md)'s recorded $M\le6\rho$, and $J(\tfrac12,\tfrac14)=24$ reproduces L156's "baseline's $24$" |
| **C2**, hence branch 2 $=K\sqrt{c_p+w^2}/(a_0n^{1/2}+nw)$ with $K=\lambda(1-\eta^*)^2/(\sqrt2J)$, so $J$ divides $K$ | **CONFIRMED in substance, REFUTED in three constants.** $J$ divides: [r711](REVIEW_r711.md) is right and [r712](REVIEW_r712.md)'s omission is a factor $2J/(ng_n)=10.30$ at $n=12$. The press-point about two $\gamma$'s **fails**: L156 defines $\rho=\gamma g_n/\lVert H\rVert_{op}$ and $J=C(\alpha,\gamma)/\gamma$ in one sentence, so it is one $\gamma$. What is wrong is $\sqrt2$ (should be $ng_n=1.3484$), $a_0$ (not $n$-free, and set to $1$ by the $\sqrt{\kappa(1+\kappa)}$ shape), and treating $K$ as constant in $w$ |
| **C3**, the threshold exceeds every proved bound on $S$ at $n=12$, so branch 2 binds there | **CONFIRMED, and by a far wider margin than the entry claims.** Threshold $52.92$ against [L143](../findings/bounds.md)'s $4.162$ (factor $12.7$) and [L70](../findings/bounds.md)'s $10$ (factor $5.3$). It survives every input uncertainty: $\lambda$ would have to exceed $\approx100$ to bring it to $10$. **The disagreement never mattered at $n=12$, even [r712](REVIEW_r712.md)'s $J$-free $4.446$ exceeds $4.162$** |
| **C4**, the threshold's value is not pinned; $39.4$ / $31.6$ / $60.2$ against $21$ and $3.7$–$4.5$ | **REFUTED.** The value is pinnable from constants the record has already fixed and Gate-2'd: $\mathbf{52.92}$ at $n=12$ on L156's own $(\alpha^*,\gamma^*)$, $\mathbf{51.83}$ at the true contour optimum, $\approx\mathbf{49}$ after [L157](../findings/second-order.md)'s $5\%$ branch-1 correction. The five-way spread is an artefact of five separately identifiable slips, each traced below; none is an open constant |

**One-line verdict: the settlement paragraph is right about $J$ and right about $n=12$, and wrong to call the number unpinned, the threshold is $\approx50$ at $n=12$, falls monotonically to $42.5$, and the three published figures differ only by errors the record itself has already named.**

## C1, the chain, with every premise located by its value

**Cauchy at radius $(1-\eta)\rho$ on a disc where the analytic function is bounded by $M$**: $\lVert A''(0)\rVert\le2M/((1-\eta)\rho)^2$. With $M\le C\rho$ this is $2C/((1-\eta)^2\rho)$, and $1/\rho=\lVert H\rVert_{op}/(\gamma g_n)$ gives

$$\lVert A''\rVert\;\le\;\frac{2C}{\gamma}\cdot\frac{\lVert H\rVert_{op}}{(1-\eta)^2g_n}\;=\;\frac{2J\lVert H\rVert_{op}}{(1-\eta)^2g_n},\qquad J=\frac C\gamma .$$

**Each premise is the record's, checked by value rather than by symbol.** [Lemma L156](../findings/second-order.md) states the objective outright (*"$J=C/\gamma$, from $\sup\lVert A''\rVert\le2M/((1-\sigma)\rho)^2$"*) and its $C(\alpha,\gamma)=\alpha(1+\alpha)/(d(d-\gamma))$ evaluates to $6$ at the frozen $(\tfrac12,\tfrac14)$, which is exactly the $M\le6\rho$ [L152](../findings/second-order.md) attributes to [r441](REVIEW_r441.md); $J$ there is $24$, L156's "baseline's $24$". **So $M\le C\rho$ is not an assumption imported into this paragraph, it is the relation that defines $C$, and it checks numerically against two independent entries.**

**The one thing the display should say and does not**: the $\eta$ here is [L156](../findings/second-order.md)'s $\sigma$ and [L157](../findings/second-order.md)'s reach, and the bound must hold along the whole segment $[0,r]$, which is what makes $\eta$ a fixed point rather than a free parameter. With $\eta=\eta^*$ that is satisfied. **C1 is CONFIRMED.**

## C2, $J$ divides, the two $\gamma$'s are one $\gamma$, and three constants are wrong

### The algebra, and it is right

$\text{branch }2=\lambda\sqrt{c_p+w^2}/\lVert A''\rVert$ with C1's bound gives

$$\text{branch }2\;=\;\frac{\lambda(1-\eta^*)^2\,g_n\,\sqrt{c_p+w^2}}{2J\,\lVert H\rVert_{op}}\;=\;\underbrace{\frac{\lambda(1-\eta^*)^2\,(ng_n)}{2J}}_{K}\cdot\frac{\sqrt{c_p+w^2}}{a_0n^{1/2}+nw},$$

using $\lVert H\rVert_{op}\le a_0n^{-1/2}+w=(a_0n^{1/2}+nw)/n$. **$J$ divides $K$, so a larger $J$ shrinks branch 2 and raises the threshold on $S$: [r711](REVIEW_r711.md) is right in direction and [r712](REVIEW_r712.md)'s omission is an error worth $2J/(ng_n)=10.30$ at $n=12$.** The entry's conclusion on this point is CONFIRMED.

### The press-point about two $\gamma$'s fails, there is only one

**[Lemma L156](../findings/second-order.md) fixes $\rho=\gamma g_n/\lVert H\rVert_{op}$ and $J=C(\alpha,\gamma)/\gamma$ in the same statement, with the same $\gamma$**: $\gamma$ is the disc radius in units of $g_n\!/\!\lVert H\rVert_{op}$, and it appears in $C$ through the Neumann step's $d-\gamma$. So the $\gamma$ in $\rho$ and the $\gamma$ inside $J^*$ are the same object, and C2 survives the press.

**A cross-check that closes it.** [L157](../findings/second-order.md)'s $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ simplifies to $t=\lambda\sqrt{c_p+w^2}/(2C)$, and branch 2 in absolute units is $\rho\cdot t(1-\eta)^2$. Substituting $\rho=\gamma g_n/\lVert H\rVert_{op}$ returns the display above **identically**: the explicit $\gamma$ of $\rho$ cancels against the $\gamma$ inside $t$, and what survives is $J=C/\gamma$. *Two routes, one answer, so the $J$ in $K$ is L156's $J$ and no other.*

### But $J^*$ is a valid choice of contour rather than the optimum for this objective, [r709](REVIEW_r709.md)'s point, made exact

**Since $t$ depends on $(\alpha,\gamma)$ only through $C$, the true branch-2 objective is $(1-\eta^*(t(C)))^2\,\gamma/C$, not $\gamma/C$.** L156 maximises $\gamma(d-\gamma)$ and lands on $\gamma^*=d/2$; the extra factor is increasing in $C$, hence in $\gamma$, so the joint optimum sits at $\gamma>d/2$. *Screen, at $n=12$, over $\alpha\in(0,4]$, $\gamma\in(0,\min(d,1))$: the optimum is $(\alpha,\gamma)=(1.10,0.63)$, $\alpha^*$ unmoved, $\gamma$ up from $0.55$, worth $2.1\%$ in branch 2 and lowering the threshold from $52.92$ to $51.83$.*

**This does not break C2; it qualifies it.** Any admissible $(\alpha,\gamma)$ gives a **valid** lower bound, so using $(\alpha^*,\gamma^*)$ is safe and merely conservative, and [L157](../findings/second-order.md)'s *"$J$ is stationary at the optimum, so $J^*$ is right to $O(t^2)$"* is confirmed with a number: $2.1\%$. **What should change is the wording, from "the optimum" to "L156's contour, which is within $2\%$ of the best contour for this branch."**

### $a_0$ is not $n$-free, and the $\sqrt{\kappa(1+\kappa)}$ shape silently sets it to $1$

**[r711](REVIEW_r711.md)'s $\sqrt{2/(n-2)}$ and [r712](REVIEW_r712.md)'s $1/\sqrt{m-1}$ agree** ($m=n/2$ gives $m-1=(n-2)/2$) and both are [Lemma L146](../findings/second-order.md)'s. Matching to $a_0n^{-1/2}$,

$$a_0=\sqrt{\frac{2n}{n-2}}:\qquad 1.5492\ (n=12),\quad1.4720\ (n=20),\quad\downarrow\sqrt2 .$$

**So $a_0$ is $n$-dependent, decreasing, and $n$-free only in the limit.** Two consequences.

- **[Lemma L149](../findings/second-order.md)'s schematic $A=n^{1/2}$ is $a_0=1$**, too small by $1.549$ at $n=12$, which is why its $w^*=\kappa n^{-1/2}$ leaves $[0,1]$ below $n=19$ while the record's own binding direction is $0.829$. Both reviewers already have this.
- **The interior-minimum value $\min_w\sqrt{c+w^2}/(A+Bw)=\sqrt c/\sqrt{A^2+B^2c}$ becomes $\sqrt\kappa/(n\sqrt{a_0^2+\kappa})$**, so the ratio is $\sqrt{\kappa(a_0^2+\kappa)}/(SK)$ and **not** $\sqrt{\kappa(1+\kappa)}/(SK)$. Writing $\sqrt{\kappa(1+\kappa)}$ is the assertion $a_0=1$. At $n=12$ the correction is $\sqrt{4.4497\cdot6.8497}/\sqrt{4.4497\cdot5.4497}=1.1211$, **a $12.1\%$ understatement of the threshold carried by [L158](../findings/second-order.md), [r711](REVIEW_r711.md) (which uses $a_0^2=2$, the limit) and [r712](REVIEW_r712.md) alike.**

### $1/g_n\to n/\sqrt2$ is right as a limit and wrong as a value at $n=12$

$g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, so $ng_n=2\sqrt{\tfrac{n-2}{2(n-1)}}=1.34840$ at $n=12$ against $\sqrt2=1.41421$, and $1/g_n=8.8994=0.7416\,n$ against $n/\sqrt2=8.4853$. **The limit is approached from below, so using $\sqrt2$ in $K$ overstates branch 2 by $4.88\%$ and understates the threshold by the same**, a lower bound stated upward, the direction [L157](../findings/second-order.md) has already been corrected for twice. It reaches $1\%$ only at $n\approx60$.

## C3, CONFIRMED, and the margin is not close

**The threshold, computed from the definitions.** With $c_p=3\theta_0/(n-2)$, $A'=\lVert H_s\rVert_{op}=1/\sqrt{m-1}$, $\lambda=2/\sqrt{\lvert\kappa_n\rvert}=1.53154$, $C^*=\tfrac{42}{11}$, $J^*=\tfrac{8.4}{1.21}=6.94215$ and $\eta^*$ from [L157](../findings/second-order.md)'s fixed point evaluated **inside** the $w$-minimisation:

$$\inf_w\text{branch }2=\frac{\lambda g_n}{2J^*}\min_{w\in[0,1]}\frac{(1-\eta^*(w))^2\sqrt{c_p+w^2}}{A'+w},\qquad \text{threshold}=\frac{c_p}{\inf_w\text{branch }2}.$$

*Screen at $n=12$: $\theta_0=1.236033$, $c_p=0.370810$, $g_n=0.1123666$, $A'=0.4472136$; the minimum of the bracket is $0.565306$, at $w=1$; $\inf_w\text{branch }2=0.0070074$; threshold $=52.921$.*

| comparand at $n=12$ | value | threshold / bound |
|---|---|---|
| [Lemma L143](../findings/bounds.md), $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | $4.162$ | $12.7$ |
| [Lemma L70](../findings/bounds.md), $\sup\lvert P\rvert\le n-2$ | $10$ | $5.3$ |
| $\theta_0(12)$, the proved **lower** bound and Conjecture A's value | $1.236$ | $42.8$ |

**And the conclusion is robust to every input that is genuinely open.** *Screen: holding everything else fixed, the threshold is $72.97$ at $\lambda=1$, $52.92$ at $\lambda=1.53$, $43.97$ at $\lambda=2$, $34.03$ at $\lambda=3$, $19.08$ at $\lambda=10$, $\lambda$ would have to exceed $\approx100$ to bring it down to [L70](../findings/bounds.md)'s $10$.* The contour re-optimisation costs $2.1\%$; [L157](../findings/second-order.md)'s branch-1 denominator costs $5\%$; both together leave $\approx49$.

> **THE DISAGREEMENT WAS NEVER LOAD-BEARING AT $n=12$.** [r712](REVIEW_r712.md)'s $J$-free threshold is $4.446$ and [L143](../findings/bounds.md)'s proved bound is $4.162$. **Every party's number exceeds every proved bound on $S$ at $n=12$**, so branch 2 binds there under the smallest threshold anyone published. *What $J$ changes is not the verdict at $n=12$ but the dimension at which the verdict could conceivably turn.*

**One correction of kind, which [L158](../findings/second-order.md)'s own box gets right and [r712](REVIEW_r712.md)'s table gets wrong.** Branch 1 binds iff $S>\text{threshold}$, and the record's bounds on $S$ are **upper** ones, so they can only show branch 1 **fails** to bind. r712's table column headed "binds" reads $S<\text{threshold}$ as "branch 1" from $n=14$, the reverse of its own C4 verdict, which states the asymmetry correctly. *With $2J$ restored the rows are wrong twice over: the dimension at which [L143](../findings/bounds.md)'s bound first reaches the threshold is $n=1839$, not $14$, and even there nothing binds.*

## C4, REFUTED: the number is pinned, and the spread is five named slips

**The threshold at $n=12$, and the whole $n$-range.** *Screen, re-evaluating the closed forms at each $n$:*

| $n$ | $12$ | $16$ | $20$ | $48$ | $100$ | $1000$ | $\to\infty$ |
|---|---|---|---|---|---|---|---|
| threshold on $S$ | $52.92$ | $52.21$ | $51.63$ | $49.34$ | $47.63$ | $44.31$ | $42.50$ |
| threshold on $s=S/\theta_0$ | $42.81$ | $40.76$ | $39.48$ | $36.02$ | $34.19$ | $31.38$ | $30.09$ |

**It is bounded and monotone decreasing, $\Theta(1)$, as [L158](../findings/second-order.md) claims, but moving $20\%$ across the range, so "the comparison is $n$-free" remains the overstatement both reviewers charged.**

### Where each published figure comes from

| figure | source | what it does |
|---|---|---|
| $39.4$ | [L158](../findings/second-order.md) | $a_0=1$ ($\times1.121$), $\eta^*$ at $w=0$ ($\times1.108$), $\sqrt2$ for $ng_n$ ($\times1.049$). Product $1.3028$; $39.32\times1.3028=51.2$, and the residual to $52.92$ is the minimiser's position |
| $31.6$ | [L158](../findings/second-order.md), $\eta^*=0$ | drops the $(1-\eta^*)^2$ [L157](../findings/second-order.md) exists to restore, the error L157 records against itself, and against [L149](../findings/second-order.md) before that |
| $60.2$ | [L158](../findings/second-order.md), $\lambda=1$ | sets $\lambda=1$ in the prefactor while leaving $\lambda=1.53$ inside $t$, so it is not the $\lambda=1$ theory of anything |
| $21$ | [r711](REVIEW_r711.md) | **not a threshold.** It is r711's own ratio $32.87/S$ evaluated at $S=1.5449$, the number r711 spends a full section refuting as not $\sup\lvert P\rvert$. Its own $\inf_w\text{branch }2=0.01128$ gives $32.87$, and its displayed formula gives $30.4$ |
| $3.7$–$4.5$ | [r712](REVIEW_r712.md) | omits $2J/(ng_n)=10.30$ entirely, and $a_0=1$ on top |

> **AND [r711](REVIEW_r711.md)'s $J^*$ IS OUT OF SCOPE.** It carries $J^*=\tfrac{40}9$, hence $2J^*=8.89$. [Lemma L156](../findings/second-order.md)'s corollary says in terms: *"Over all $m\ge2$ the intervals open at $C^*=\tfrac{10}3$ and $J^*=\tfrac{40}9$, but $m=2$ is out of scope for everything this feeds, $n\ge12$ here"*, and gives the in-scope interval $6.9421\le J^*<8$, with $J^*(m{=}6)=6.9421$ printed in the same lemma's own numbers-at-$n=12$ paragraph. **r711 imported the $m=2$ endpoint, a factor $1.562$ low.** *With $J^*(6)$ its own chain returns $51.3$.*

## The finding neither reviewer nor the entry reached: the branch-2 minimiser is the endpoint

**Once [L157](../findings/second-order.md)'s $w$-dependence of $(1-\eta^*)^2$ is kept inside the minimisation (which is exactly what the entry's closing paragraph says must happen), the minimiser moves to $w=1$ at every $n\ge12$.**

*Screen at $n=12$ of $\varphi(w)=(1-\eta^*(w))^2\sqrt{c_p+w^2}/(A'+w)$:*

| $w$ | $0^+$ | $0.5$ | $0.7$ | $0.829$ | $0.95$ | $1$ |
|---|---|---|---|---|---|---|
| $t$ | $0.1221$ | $0.1580$ | $0.1861$ | $0.2063$ | $0.2263$ | $0.2348$ |
| $\lambda(1-\eta^*)^2$ | $1.2430$ | $1.1810$ | $1.1375$ | $1.1084$ | $1.0812$ | $1.0702$ |
| $\varphi(w)$ | $1.1048$ | $0.6414$ | $0.6007$ | $0.5833$ | $0.5702$ | $0.5653$ |

**$\varphi$ is strictly decreasing on $(0,1]$.** The reason is that the prefactor-free $g(w)=\sqrt{c_p+w^2}/(A'+w)$ is extremely flat near its minimum, $g(1)/g(0.829)=1.0037$, while $(1-\eta^*)^2$ falls $3.4\%$ over the same interval. *The prefactor's decline swamps the shape's rise, and the same holds at every $n$ I screened up to $10^9$.*

> **SO THE RECORD'S "BINDING DIRECTION $w^*=0.829$" IS THE MINIMISER OF A FUNCTION THE CHAIN DOES NOT MINIMISE.** It is [r709](REVIEW_r709.md)'s $c_p/A'$, restated in [L157](../findings/second-order.md) and used by [r712](REVIEW_r712.md) to price $\lambda(1-\eta^*)^2=1.1075$. **The true minimiser is $w=1$ and the true prefactor there is $1.0702$**, so [L157](../findings/second-order.md)'s cost of freezing $\eta=\tfrac12$, [r712](REVIEW_r712.md)'s correction 5, and every quantity the record quotes "at the binding direction" are quoted at a non-minimising $w$. *The value moves only $3.2\%$, the location moves $21\%$, and the location is what three entries cite.*

## Whether the comparison is moot under [r712](REVIEW_r712.md)'s $S=s\theta_0$ reformulation

**It is not moot, and the reformulation is the right framing with the wrong number.** Writing $S=s\theta_0(n)$ removes $\theta_0$ from both sides and makes the criterion read *"branch 1 binds iff $\sup\lvert P\rvert$ exceeds its balanced-orbit value by a factor $s$"*, but $s$'s threshold is a pure number that still has to be computed, and it carries the same factor $10.3$ error. **Corrected: $s>42.8$ at $n=12$, falling to $30.1$.** Against Conjecture A's $s=1$ and the proved $s\le(1+\sqrt{n-2})/\theta_0=3.37$ at $n=12$:

- **Under Conjecture A, branch 1 never binds at any $n$**, $s=1$ against a threshold that never falls below $30$.
- **Under the proved upper bound, branch 1 fails to bind for every $n\le1838$**, and above that the criterion is simply undecided, an upper bound on $S$ being unable to show binding.
- **[r712](REVIEW_r712.md)'s "$s>3.1$–$3.6$, so it is a $6\%$ call at $n=12$" becomes a factor-$12.7$ margin.** *The reformulation's value is that it makes the criterion a statement about the conjecture-to-proof gap; its published number made that gap look nearly closed when it is an order of magnitude open.*

## $\lambda$, the one input I could not pin from the definitions

**$\lambda=2/\sqrt{\lvert\kappa_n\rvert}=1.53154$ checks arithmetically** against $\lvert\kappa_n\rvert=1.7053$, and $\lvert\kappa_n\rvert$ appears in [L149](../findings/second-order.md) only inside the display $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053$, whose left term is the **$n\to\infty$** value of $\tfrac32\theta_0$ ($\tfrac32\sqrt2$). *So the record's one numeric anchor for $\lvert\kappa_n\rvert$ sits in a limit display, and whether $\lvert\kappa_n\rvert$ is $n$-dependent is not settled there.* **That it belongs in branch 2 is [L157](../findings/second-order.md)'s, Gate-2'd by [r709](REVIEW_r709.md) and [r710](REVIEW_r710.md), and I did not re-derive it.** The sensitivity screen above bounds the damage: the threshold is monotone decreasing in $\lambda$ and stays above $34$ for every $\lambda\le3$, so **C3's verdict is independent of $\lambda$ over any plausible range.**

## Corrections owed to the entry

1. **Replace $\sqrt2$ by $ng_n=2\sqrt{(n-2)/(2(n-1))}$** in $K$, or say the display is the $n\to\infty$ form. At $n=12$ the exact value is $1.3484$; using $\sqrt2$ states a lower bound upward by $4.9\%$.
2. **Record $a_0=\sqrt{2n/(n-2)}$, $1.5492$ at $n=12$, $\downarrow\sqrt2$** (it is not $n$-free) and replace $\sqrt{\kappa(1+\kappa)}$ by $\sqrt{\kappa(a_0^2+\kappa)}$, which the $1$ in the first form silently denies. Worth $12.1\%$.
3. **Use $J^*(m)$, in scope**: $6.9421\le J^*<8$ for $n\ge12$, $6.94215$ at $n=12$. Note against [r711](REVIEW_r711.md) that its $\tfrac{40}9$ is [L156](../findings/second-order.md)'s explicitly out-of-scope $m=2$ endpoint.
4. **Say that $J^*$ is a valid contour rather than the optimal one for this branch**: $t$ depends on $(\alpha,\gamma)$ through $C$ alone, so the branch-2 objective is $(1-\eta^*(C))^2\gamma/C$ and its optimum is $(1.10,0.63)$, not $(1.10,0.55)$, [r709](REVIEW_r709.md)'s Cauchy-radius point, worth $2.1\%$ and confirming [L157](../findings/second-order.md)'s $O(t^2)$.
5. **Pin the threshold.** $52.92$ at $n=12$ on L156's contour, $51.83$ at the joint optimum, $\approx49$ with [L157](../findings/second-order.md)'s branch-1 denominator; $42.50$ as $n\to\infty$, monotone decreasing. **Delete "known only to be $\gg10$" and the three-value spread**; every one of the five published figures is a named slip, not an open constant.
6. **Correct the minimiser.** $\varphi(w)$ is strictly decreasing on $(0,1]$ once $(1-\eta^*)^2$ is inside, so the branch-2 minimum is the endpoint $w=1$ with $\lambda(1-\eta^*)^2=1.0702$. Reconcile [L157](../findings/second-order.md)'s and [r709](REVIEW_r709.md)'s $w^*=0.829$, which minimises the prefactor-free $g$ only.
7. **Record the strength of C3.** Branch 2 binds at $n=12$ by a factor $12.7$ against [L143](../findings/bounds.md) and $5.3$ against [L70](../findings/bounds.md); it survives $\lambda$ anywhere below $\approx100$; and **it holds under every party's constants, [r712](REVIEW_r712.md)'s included**, so the $J$ dispute, while real, was never what decided $n=12$.
8. **Give the dimensions instead of the verdict.** [L143](../findings/bounds.md)'s $1+\sqrt{n-2}$ first reaches the threshold at $n=1839$; [L70](../findings/bounds.md)'s $n-2$ at $n=52$. Both are upper bounds, so neither shows branch 1 binding, they bound the region where it provably does not.
9. **Fix [r712](REVIEW_r712.md)'s table in the entry's summary of it.** Its "branch 1 binds from $n=14$" contradicts its own C4 verdict on the direction of the bound, and is off by two orders in $n$ once $2J$ is restored.

## What would refute this review

- **On C2**: a derivation in which $M\le C\rho$ holds with a $C$ not equal to L156's contour constant, but $C(\tfrac12,\tfrac14)=6$ reproduces [r441](REVIEW_r441.md)'s recorded $M\le6\rho$ and $J(\tfrac12,\tfrac14)=24$ reproduces L156's baseline, so two independent numbers pin it.
- **On the single $\gamma$**: a place where the disc radius in $\rho$ and the disc radius entering $C$'s Neumann step differ. [Lemma L156](../findings/second-order.md) writes both in one statement; I could not construct one.
- **On C3**: a proved upper bound on $\sup\lvert P\rvert$ **above** $\approx50$ at $n=12$, impossible, since [L143](../findings/bounds.md)'s $4.162$ already stands, or a demonstration that $\lambda\gtrsim100$, which would contradict $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ by a factor $65$.
- **On C4**: a constant in the chain that is genuinely open and moves the threshold by more than the $\approx7\%$ I attribute to the contour and branch-1 corrections. The candidates are $\lvert\kappa_n\rvert$'s $n$-dependence and the $u\lesssim w$ constant ([r452](REVIEW_r452.md) B4); neither has a value on the record, and the second does not enter this comparison.
- **On the endpoint minimiser**: an argument that $w=1$ is inadmissible. $w=\lVert H_r\rVert$ for a unit $H$ and [L149](../findings/second-order.md) states $w\in[0,1]$; $w=1$ is $H$ entirely outside both margin summands, which is a direction, not a degeneracy.

**Inherited without re-derivation**: [L157](../findings/second-order.md)'s $\eta^*(t)$ fixed point and the crossing (Gate 2 by [r709](REVIEW_r709.md), [r710](REVIEW_r710.md)); $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ and $\lvert\kappa_n\rvert=1.7053$; [L146](../findings/second-order.md)'s $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$; [L141](../findings/second-order.md)(b)'s $c_n=3\theta_0/(n-2)$; [L148](../findings/second-order.md)'s vanishing at $w=0$; [L143](../findings/bounds.md) and [L70](../findings/bounds.md). **Everything above compares two branches of a lower bound on $r_n$; whether that chain is tight against the true tube radius is untouched.**
