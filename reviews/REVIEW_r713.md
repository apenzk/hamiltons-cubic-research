# Review r713, Gate 2 on [Lemma L158](../findings/second-order.md)'s settlement blockquote: does $J$ divide, and where is the threshold?

*Reviewer r713, 2026-09-05, cold brief, analysis-only. Every derivation below is hand algebra; the sole computation is a re-evaluation of closed forms already on the record ($\theta_0(n)$, $c_p$, $g_n$, $C(\alpha,\gamma)$, $\eta^*(t)$, $\kappa_n$) at the dimensions in scope, on objects built for that purpose, reported as a screen and never as evidence for a positive claim. No sweep, census, optimisation or falsifier hunt was opened.*

## Verdicts

| claim | verdict |
|---|---|
| **C1**, $\lVert A''\rVert\le2M/((1-\eta)\rho)^2$, $M\le C\rho$, $\rho=\gamma g_n/\lVert H\rVert_{op}$ give $\lVert A''\rVert\le2J\lVert H\rVert_{op}/((1-\eta)^2g_n)$ | **PLAUSIBLE, valid as an inequality, defective as the identity it is presented as.** The step $M\le C\rho$ holds only at $\lVert H\rVert_{op}=1$; the record's own $M$-bound is $M\le C\gamma g_n=C\rho\lVert H\rVert_{op}$, and the sharp conclusion is **quadratic**, $\lVert A''\rVert\le2J\lVert H\rVert_{op}^2/((1-\eta)^2g_n)$. Since $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ the displayed linear form is a valid over-estimate, so nothing downstream breaks, and at the binding direction $\lVert H\rVert_{op}=1$, where the two coincide |
| **C2**, hence branch $2=K\sqrt{c_p+w^2}/(a_0n^{1/2}+nw)$ with $K=\lambda(1-\eta^*)^2/(\sqrt2J)$, so $J$ divides | **CONFIRMED pointwise; REFUTED as a factorisation under $\min_w$.** $J$ does divide, the two $\gamma$'s **are** the same $\gamma$, and the record verifies the identification twice over. [r711](REVIEW_r711.md) is right to carry $J^*$ and [r712](REVIEW_r712.md) wrong to omit it. But $K$ carries $w$ through $\eta^*$ and may not be pulled out of the minimisation, and $a_0$ is not a constant |
| **C3**, the threshold exceeds every proved bound on $S$ at $n=12$, so branch 2 binds there | **CONFIRMED**, and by a wider margin and over a far wider range of $n$ than the entry claims. The reason given is only a third of the truth: three further corrections push the threshold **down** and it survives all of them. Branch 2 provably binds at every $n$ up to $\approx1800$ |
| **C4**, the threshold is not pinned: $39.4$ / $31.6$ / $60.2$ against $21$ and $3.7$–$4.5$ | **CONFIRMED in letter, REFUTED as an obstacle, and the spread has a cause none of the three parties named.** The entry's three numbers are internally consistent but all rest on $a_0=1$ and the limit $g_n$; the term that actually moves the threshold is $\lambda$, which the record evaluates at $n=\infty$ while working at $n=12$. Pinned below |

**One-line verdict: $J$ divides and r711 is right, but the entry settles the disagreement with the wrong constants in three of the four slots it names, and the largest of them, $\lambda$, is wrong by a factor $4.1$ at $n=12$ because the record substitutes $\lvert\kappa_n\rvert$'s $n\to\infty$ value at $n=12$, where its own [Lemma L133](../findings/second-order.md) and [Lemma L134](../findings/route-a.md) both print $\lvert\kappa_{12}\rvert=0.10159$. Correcting everything, the threshold at $n=12$ is $\approx19$, not $39.4$, $21$ or $4.4$, and the conclusion is unchanged, because $19\gg10$.**

## The two $\gamma$'s are one $\gamma$, so C2's structural claim stands

**The brief's sharpest press-point fails, and it fails three ways.**

- **[Lemma L156](../findings/second-order.md) states $\rho=\gamma g_n/\lVert H\rVert_{op}$ in its own hypothesis** and then defines $J=C/\gamma$ from *that* $\rho$: its closing paragraph gives the objective as $J=C/\gamma$, "from $\sup\lVert A''\rVert\le2M/((1-\sigma)\rho)^2$". The quotient $C/\gamma$ has no meaning except as the constant left after the $\gamma$ of $\rho$ has cancelled one power against $C$. There is one $\gamma$.
- **[Lemma L157](../findings/second-order.md)'s $t$ is the independent check.** Its $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ is exactly what the chain returns: $r=\eta\rho$ and $\lVert H\rVert_{op}\rho=\gamma g_n$ turn $r\le\lambda\sqrt c(1-\eta)^2g_n/(2J\lVert H\rVert_{op})$ into $\eta\le t(1-\eta)^2$ with that $t$. **The $\gamma$ in $t$ and the $\gamma$ in $\rho$ must be the same for L157's own display to be what it is.**
- **[r709](REVIEW_r709.md)'s observation is about a different variable.** Its point is that the *Cauchy radius* $\gamma-r$ wants to be $d/2$, i.e. that the reach $\eta$ eats into the disc before the Neumann step is taken, a correction to the value of $\gamma^*$, not evidence of two $\gamma$'s. I price it below and it is worth $1.3\%$.

**And $J\gamma=C$, which is the cleanest statement of the cancellation:** $t=\lambda\sqrt{c_p+w^2}/(2C)$ depends on $C$ alone. *That is the "$\gamma$ cancels" [r708](REVIEW_r708.md) reached for and stated only "for small $t$"; it is exact.*

## C1, the power of $\lVert H\rVert_{op}$ is $2$, and the record's $M\le C\rho$ is the $\lVert H\rVert_{op}=1$ instance

**Where the record's $M$ actually comes from.** $A(0)=\mathrm{Alt}(W^*_-)=0$, so $M=\sup_{\lvert z\rvert\le\rho}\lVert A(z)\rVert$ bounds an increment, and the resolvent identity gives $\lVert W_-(z)-W_-(0)\rVert\le\frac1{2\pi}\cdot2\pi\alpha g_n\cdot(1+\alpha)g_n\cdot\frac{\lVert zH\rVert_{op}}{d(d-\gamma)g_n^2}$ with $\lVert zH\rVert_{op}\le\gamma g_n$. Hence

$$M\;\le\;\frac{\alpha(1+\alpha)\gamma}{d(d-\gamma)}\,g_n\;=\;C\gamma g_n\;=\;C\rho\,\lVert H\rVert_{op}.$$

**The check is [r441](REVIEW_r441.md)'s own number, and it only works with the $\gamma$.** [Lemma L156](../findings/second-order.md) records $M\le\tfrac32g_n=6\rho$ at $(\alpha,\gamma)=(\tfrac12,\tfrac14)$, where $C=6$: $C\gamma g_n=6\times\tfrac14g_n=\tfrac32g_n$ ✓, while the bare Riesz product $\alpha(1+\alpha)/(d-\gamma)=3$ gives $3g_n$. *So the extra $1/d$ in L156's $C$ and the $\gamma$ in $M\le C\gamma g_n$ are one bookkeeping, and dropping the $\gamma$ silently sets $\lVert H\rVert_{op}=1$.*

**Consequently**
$$\lVert A''\rVert\;\le\;\frac{2C\gamma g_n\,\lVert H\rVert_{op}^2}{(1-\eta)^2\gamma^2g_n^2}\;=\;\frac{2J\,\lVert H\rVert_{op}^{\,2}}{(1-\eta)^2\,g_n},$$
**quadratic in $\lVert H\rVert_{op}$, where C1 and [Lemma L149](../findings/second-order.md)'s $\lVert A''\rVert=O(1/\rho)$ are both linear.** Since $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ the linear form is an over-estimate of $\lVert A''\rVert$, hence an under-estimate of the radius: **the chain stays sound and only loses.** *Screen: at $n=12$ the binding direction has $\lVert H\rVert_{op}=1$ exactly, so carrying the correction changes the threshold by nothing there; it matters only on the low-$w$ directions, where branch 2 is not binding.*

## C2, $J$ divides, and here is what else is in $K$

$$\text{branch }2\;=\;\frac{\lambda\sqrt{c_p+w^2}}{\lVert A''\rVert}\;=\;\frac{\lambda(1-\eta^*)^2\,g_n}{2J\,\lVert H\rVert_{op}}\sqrt{c_p+w^2}\;=\;\frac{\gamma\,\eta^*\,g_n}{\lVert H\rVert_{op}},$$
*the last step being [Lemma L157](../findings/second-order.md)'s crossing identity $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$, which makes the whole branch equal to $\eta^*\rho$ as it must be.* **So $J$ divides, [r711](REVIEW_r711.md)'s inclusion is right and [r712](REVIEW_r712.md)'s omission is the error, and it is worth a factor $\sqrt2J^*=9.82$ at $n=12$, which is most of the gap between the two reviewers' numbers.**

**Three riders, each of which the entry's display gets wrong.**

- **$K$ is not a constant and may not leave the minimisation.** $\eta^*=\eta^*(t(w))$, so the object to minimise is $\gamma\eta^*(t(w))g_n/\lVert H\rVert_{op}(w)$, which is **not** of the form (constant) $\times\sqrt{c_p+w^2}/(a_0n^{1/2}+nw)$. Doing it correctly moves the minimiser and the minimum; the entry evaluates $\eta^*=0.104$, which is its $w=0$ value, the one direction [Lemma L148](../findings/second-order.md) empties, while locating the minimum elsewhere. *This is the same slip [r712](REVIEW_r712.md) charged and it survived the rewrite.*
- **$\eta^*<\tfrac12$ at every $w$**, so the validity branch $r\le\rho/2$ is slack and dropping branch 3 is legitimate, **confirmed, by a computation the record does not do.**
- **$\lambda$ is $w$-free** ($\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ depends on $n$ alone), so of the brief's two, only $\eta^*$ is at risk from the single-$w$ evaluation.

### $a_0$ is not $\sqrt2$, not $1$, and not $n$-free

**[Lemma L146](../findings/second-order.md) gives $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}=\sqrt{2/(n-2)}$**, which is what both [r711](REVIEW_r711.md) and [r712](REVIEW_r712.md) carry, so they agree. Written in the blockquote's own shape $a_0n^{-1/2}$,
$$a_0=\sqrt{\tfrac{2n}{n-2}}\;=\;1.5492\ (n=12)\ \downarrow\ \sqrt2 .$$
**So $a_0$ is $n$-dependent, is $\sqrt2$ only in the limit, and the entry's $1$ is too small by $55\%$ at $n=12$**, the value that produces its $39.4$.

### $1/g_n$: the limit costs $4.9\%$ at $n=12$, and the exact form is prettier than either

$g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$ gives $1/g_n=\tfrac n{\sqrt2}\sqrt{\tfrac{n-1}{n-2}}$, which is $8.8994$ at $n=12$ against the limit's $8.4853$, **the limit understates $\lVert A''\rVert$ and so overstates branch 2 by $4.88\%$, lowering the threshold by the same.** *And since $\kappa=3\sqrt{2(n-1)/(n-2)}$, the exact identity is*
$$\frac1{g_n}=\frac{n\kappa}6=\frac{n^2c_p}6 ,$$
**so $1/g_n$ and the margin constant are the same quantity twice**, which is why the $n^{-1}$ cancels from the branch ratio at all, and a cleaner statement of L158's mechanism than the one it gives.

## The finding: $\lambda$ is $6.275$ at $n=12$, not $1.53$

**$\lambda$ does belong in branch 2, and its derivation fixes its size.** The quartic tail of $-\kappa_n\delta^2$ costs $\lvert\kappa_n\rvert\lVert A\rVert^2$ with $A(r)\approx\tfrac12A''r^2$ on the subspace where $A(0)=A'(0)=0$, so the tube condition $c\,r^2\ge\tfrac14\lvert\kappa_n\rvert\lVert A''\rVert^2r^4$ gives $r\le2\sqrt c/(\sqrt{\lvert\kappa_n\rvert}\lVert A''\rVert)$, **exactly [r450](REVIEW_r450.md) D3's factor $2$ and [r709](REVIEW_r709.md)'s $\lvert\kappa_n\rvert$, so $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ is right and belongs.**

> **BUT $1.53$ IS $\lambda$ AT $n=\infty$, AND THE RECORD PRINTS $\lvert\kappa_{12}\rvert$ IN TWO PLACES.** $\lambda=1.53155$ is $2/\sqrt{1.705218}$, and $1.705218=9(\sqrt2-\sqrt{3/2})$ is the **limit** of $\lvert\kappa_n\rvert$. [Conjecture L16](../findings/problem.md) fixes $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$; [Lemma L133](../findings/second-order.md)'s own numbers line reads *"$\kappa_{12}=9(1.224745-1.236033)=-0.10159$"*, [Lemma L134](../findings/route-a.md)'s proof of (b) reads *"$\lvert\kappa_{12}\rvert=0.10159$ and $\lvert\kappa_n\rvert\uparrow9(\sqrt2-\sqrt{3/2})=1.705218$"*, and [LEDGER](../findings/LEDGER.md) prices it as *"at $n=12,14$, $\lvert\kappa_n\rvert$ is $6\%$ and $20\%$ of the binding strength"*. **$0.10159/1.705218=5.96\%$.** Hence
> $$\lambda(12)=\frac2{\sqrt{0.10159}}=6.2747,\qquad \lambda(14)=3.4689,\qquad \lambda(48)=1.7496,\qquad \lambda\downarrow1.5316 .$$
> **A factor $4.10$ at the only dimension the entry evaluates.** *Direction: $1.53$ under-states $\lambda$, hence under-states branch 2 and over-states the threshold, so the chain is sound and lossy rather than wrong, but every number [Lemma L157](../findings/second-order.md) and [Lemma L158](../findings/second-order.md) report at $n=12$ moves, $t$ from $0.206$ to $0.68$ and $\eta^*$ from $0.149$ to $0.32$.*

**And it is the largest $n$-dependence in a ratio the entry's title calls $n$-free.** $\lambda$ moves by $4.1\times$ across $n\ge12$ where $\kappa$ moves by $5\%$ and $a_0$ by $10\%$. *[r712](REVIEW_r712.md) listed $\kappa(n)$ and $\eta^*(n)$ as the carriers of $n$ and missed the one that matters by an order.*

## $J^*$ may be used, and I priced the objection

**The objective L156 optimises is the right one to leading order, and the exact one differs little.** The quantity to maximise is $r=\eta^*\gamma g_n/\lVert H\rVert_{op}$, i.e. $F(\alpha,\gamma)=\gamma\,\eta^*\big(\lambda\sqrt{c_p+w^2}/(2C(\alpha,\gamma))\big)$, **not** $1/J$. Writing $\eta^*=\frac{\sqrt{4t+1}-1}{\sqrt{4t+1}+1}$ (an equivalent closed form for [Lemma L157](../findings/second-order.md)'s root, and easier to differentiate), $\eta^*=t-2t^2+O(t^3)$ gives $F=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-2t+\cdots)$, **so minimising $J$ is maximising $F$ to $O(t)$, which is [Lemma L157](../findings/second-order.md)'s "$J$ is stationary at the optimum" made explicit.** At second order the stationarity condition on the branch $\alpha\le D/2$ is $(s^2-1)(s+1)=\alpha k$, $s=\sqrt{4t+1}$, $k=4T/(1+\alpha)$, $T=\lambda\sqrt{c_p+w^2}/2$; $\alpha^*=D/2$ survives (F increases in $\alpha$ up to the resolvent kink) and only $\gamma^*$ moves.

*Screen at $n=12$, $\alpha=1.1$, at the binding direction:*

| $\lambda$ | L156's $\gamma^*=0.55$ | true optimum | gain in $r$ | threshold |
|---|---|---|---|---|
| $1.5316$ | $F=0.06930$ | $\gamma=0.613$, $F=0.07020$ | $1.3\%$ | $47.6\to47.0$ |
| $6.2747$ | $F=0.17385$ | $\gamma=0.697$, $F=0.18572$ | $6.8\%$ | $19.0\to17.8$ |

**So $J^*$ is admissible (any $(\alpha,\gamma)$ gives a valid bound) and costs at most $7\%$.** *[r711](REVIEW_r711.md) used $J^*=\tfrac{40}9=4.444$, which is [Lemma L156](../findings/second-order.md)'s $m=2$ endpoint and out of scope; at $m=6$ the value is $J^*=6.9421$, and r711's $2J^*=8.89$ is $2\times\tfrac{40}9$. That is a $1.56\times$ understatement and part of why its threshold came out at $21$.*

## The threshold, pinned

**One more constant nobody carried: $\lVert H\rVert_{op}\le\min(\sqrt{2/(n-2)}+w,\;1)$.** The triangle bound exceeds the trivial $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ for $w>1-\sqrt{2/(n-2)}=0.553$ at $n=12$, and the minimum of branch 2 sits **exactly at that kink**, so the binding direction is $w^*=1-\sqrt{2/(n-2)}$, not [r709](REVIEW_r709.md)'s $0.829$ nor [r712](REVIEW_r712.md)'s endpoint $1$.

$$\boxed{\ S^*=\frac{c_p}{\min_{w\in[0,1]}\ \gamma^*\,\eta^*(t(w))\,g_n/\min(\sqrt{2/(n-2)}+w,1)}\ }$$

*Screen, at the record's own $c_p=3\theta_0/(n-2)$, exact $g_n$, $(\alpha^*,\gamma^*,J^*)$ from [Lemma L156](../findings/second-order.md), $\eta^*$ from [Lemma L157](../findings/second-order.md) evaluated inside the minimisation:*

| $n$ | $\lambda_n$ | $S^*$ (corrected $\lambda$) | $S^*$ (record's $\lambda=1.53$) | [L143](../findings/bounds.md) $S\le1+\sqrt{n-2}$ | [L70](../findings/bounds.md) $S\le n-2$ |
|---|---|---|---|---|---|
| $12$ | $6.275$ | $\mathbf{19.0}$ | $47.6$ | $4.16$ | $10$ |
| $14$ | $3.469$ | $27.0$ | $48.2$ | $4.46$ | $12$ |
| $16$ | $2.814$ | $31.1$ | $48.5$ | $4.74$ | $14$ |
| $20$ | $2.315$ | $35.8$ | $48.8$ | $5.24$ | $18$ |
| $48$ | $1.750$ | $43.3$ | $47.9$ | $7.78$ | $46$ |
| $2000$ | $1.536$ | $43.4$ |, | $45.7$ | $1998$ |

**So the threshold at $n=12$ is $19$, rising to a plateau near $43$–$44$; it is $\Theta(1)$ but it moves by $2.3\times$ over the range.** *With the $(\alpha,\gamma)$ re-optimum it is $17.8$ at $n=12$; with [Lemma L147](../findings/second-order.md)'s $au$ in branch 1's denominator, about $5\%$ lower again; so $\approx17$ is the honest figure and every ingredient that remains unpriced moves it by percent, not by factors.*

> **THE CONCLUSION IS UNCHANGED AND ITS MARGIN IS WIDER THAN THE ENTRY CLAIMS FOR IT.** $17\gg10$, so branch 2 binds at $n=12$ under [Lemma L70](../findings/bounds.md) as well as under [Lemma L143](../findings/bounds.md). **And it is not a statement about $n=12$**: $S^*$ plateaus near $43$ while [Lemma L143](../findings/bounds.md)'s bound is $1+\sqrt{n-2}$, so **branch 2 provably binds at every $n$ up to $\approx1800$.** *That reverses [r712](REVIEW_r712.md)'s table (its "branch 1 binds at every $n\ge14$" is the $J$-free threshold read against a growing bound) and it strengthens [r711](REVIEW_r711.md), which drew the conclusion only at $n=12$.*

## The $S=s\theta_0$ reformulation is not moot, and it is not constant-free

**It is a change of variable, so it inherits every constant.** $s^*=S^*/\theta_0(n)$, and at $n=12$ that is $15.4$ (corrected $\lambda$) or $38.5$ (the record's), against [r712](REVIEW_r712.md)'s $3.1$–$3.6$ and against a proved $s\le(1+\sqrt{n-2})/\theta_0=3.37$. **What survives is the *reading* (the criterion measures the conjecture-to-proof gap in $\sup\lvert P\rvert$) which is genuinely the best framing any party reached; what does not survive is the number, which moves with $J$, $\lambda$, $a_0$ and $g_n$ exactly as $S^*$ does.** *So the reformulation cannot be used to sidestep the constants, and [Lemma L158](../findings/second-order.md) currently carries $s>3.1$–$3.6$ in a blockquote two paragraphs above the one that says $J$ divides, two mutually inconsistent thresholds in one entry.*

## What is owed

1. **Correct $\lambda$ at finite $n$.** $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ with $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, giving $6.275$ at $n=12$ against the $1.53$ that [Lemma L157](../findings/second-order.md) and [Lemma L158](../findings/second-order.md) both use, the $n\to\infty$ value, with $\lvert\kappa_{12}\rvert=0.10159$ printed in [Lemma L133](../findings/second-order.md) and [Lemma L134](../findings/route-a.md). **Every $t$, $\eta^*$ and threshold at $n=12$ in both entries moves.**
2. **Record $a_0=\sqrt{2n/(n-2)}$**, $n$-dependent, $1.5492$ at $n=12$, $\downarrow\sqrt2$, and delete the entry's $a_0=1$, which is [Lemma L149](../findings/second-order.md)'s order-level $n^{1/2}$ read as exact.
3. **Use the exact $1/g_n=n\kappa/6=n^2c_p/6$**, not $n/\sqrt2$: the limit is $4.9\%$ low at $n=12$, and the identity explains the $n^{-1}$ cancellation the lemma's mechanism rests on.
4. **Put $\eta^*$ inside the minimisation** and record the binding direction $w^*=1-\sqrt{2/(n-2)}=0.553$ at $n=12$, from $\lVert H\rVert_{op}\le\min(\sqrt{2/(n-2)}+w,1)$, the triangle bound alone exceeds $\lVert H\rVert_F=1$ on the upper half of the interval.
5. **Keep $J^*$, with its range.** $J^*=6.9421$ at $m=6$, $[6.9421,8)$ on $n\ge12$; $\tfrac{40}9$ is the $m=2$ endpoint, out of scope, and [r711](REVIEW_r711.md) used it.
6. **State the threshold as $\approx17$–$19$ at $n=12$ and $\approx43$ asymptotically**, and drop "$n$-free" from the title: $\lambda$ alone moves it by $2.3\times$ across the range.
7. **Reconcile the two thresholds the entry now carries**, $s>3.1$–$3.6$ from [r712](REVIEW_r712.md) and $\gg10$ from the settlement blockquote. They are the same criterion with and without $J$; only the second is right, and the $s$-form should be restated as $s^*\approx15$ at $n=12$.
8. **Record the conclusion at its true strength**: branch 2 binds at every $n$ up to $\approx1800$ under [Lemma L143](../findings/bounds.md), not merely at $n=12$; [I31](../plan.md)'s constant is not load-bearing for the branch minimum anywhere in the programme's range.
9. **Fix the power of $\lVert H\rVert_{op}$** in [Lemma L149](../findings/second-order.md)'s $\lVert A''\rVert=O(1/\rho)$ and in this blockquote: the sharp bound is $2J\lVert H\rVert_{op}^2/((1-\eta)^2g_n)$, from $M\le C\gamma g_n$. It is inert at the binding direction and free elsewhere.

## What would refute this review

- **On $\lambda$**: a statement that branch 2's $\lvert\kappa_n\rvert$ is a *different* penalty constant from [Conjecture L16](../findings/problem.md)'s, but [Lemma L149](../findings/second-order.md)'s own penalty paragraph writes $-\kappa_n\delta^2$ and checks $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053$, which is L16's limit exactly, and [r709](REVIEW_r709.md) is cited for the identification.
- **On C2**: a reading in which L156's $J=C/\gamma$ optimises a $\gamma$ other than the one in $\rho$. I could not construct one, L156 states $\rho=\gamma g_n/\lVert H\rVert_{op}$ in the same sentence that names $C(\alpha,\gamma)$, and L157's $t$ carries $2J\gamma$, which only closes if they are one.
- **On C3**: a proved upper bound on $\sup\lvert P\rvert$ above $\approx17$ at $n=12$. [Lemma L70](../findings/bounds.md)'s $n-2=10$ is the record's weakest and is still below it.
- **On C1**: a derivation in which $M$ does not vanish with the perturbation. $A(0)=\mathrm{Alt}(W^*_-)=0$ is [Lemma L145](../findings/second-order.md)'s and [r446](REVIEW_r446.md)'s, so $M$ is an increment and carries $\lVert zH\rVert_{op}$.

**Inherited without re-derivation**: [Lemma L156](../findings/second-order.md)'s $C(\alpha,\gamma)$, $(\alpha^*,\gamma^*)$ and the resolvent kink; [Lemma L157](../findings/second-order.md)'s crossing and $\eta^*(t)$; [Lemma L146](../findings/second-order.md)'s $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$; [Lemma L141](../findings/second-order.md)'s $c_p=3\theta_0/(n-2)$; [Lemma L143](../findings/bounds.md) and [Lemma L70](../findings/bounds.md); $\theta_0(n)^2=2(n-1)(n-2)/n^2$ and $g_n$ from [conventions.md](../findings/conventions.md). **Whether the chain lower-bounds the true tube radius tightly is untouched**, everything here compares two branches of a lower bound, so it prices what this chain can prove and not $r_n$.
