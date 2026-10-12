# REVIEW r708, Gate 2 on [Lemma L156](../findings/second-order.md)'s corollary, and on its claim to [I33](../plan.md)

*Reviewer r708, 2026-09-05, cold brief. Analysis only: the sole computation is an exact-rational re-evaluation of the corollary's own closed forms at eight values of $m$, run as a screen on objects built for that purpose and reported as a screen. Everything else is hand algebra.*

## Verdicts

| claim | verdict |
|---|---|
| **C1**, the corollary's monotonicity and the intervals $\tfrac{10}3\le C^*<4$, $\tfrac{40}9\le J^*<8$ | **CONFIRMED**, with two corrections to the wording of "attained" and "dimension-free" |
| **C2**, that C1 supplies *exactly* what [I33](../plan.md) records as owed | **REFUTED as stated.** It supplies one input of at least three, and the corollary reaches that reading by silently changing [I33](../plan.md)'s plural to a singular |

## C1, every step checks, and three of them check twice

**The monotonicity chain is correct in every link, including the direction the brief asks about.**

- $\alpha^*=\tfrac D2=\tfrac{2m-1}{2(m-1)}=1+\tfrac1{2(m-1)}$ is an identity, and it decreases strictly to $1$.
- $J(\alpha)=\tfrac{4(1+\alpha)}{\alpha^2}$ has $J'(\alpha)=4\cdot\tfrac{\alpha^2-2\alpha(1+\alpha)}{\alpha^4}=-\tfrac{4(\alpha+2)}{\alpha^3}<0$ for every $\alpha>0$. **Strictly decreasing, as claimed.**
- **The composition direction is right.** $\alpha^*(m)$ decreasing and $J$ decreasing gives $J^*(m)=J(\alpha^*(m))$ **increasing**, with $\sup_m J^*=J(1)=8$ approached and not attained, since $\alpha^*>1$ at every finite $m$.
- $C^*=2+\tfrac{4(m-1)}{2m-1}$ increases, because $\tfrac{d}{dm}\tfrac{m-1}{2m-1}=\tfrac1{(2m-1)^2}>0$, with limit $4$.

**Two internal consistency checks the corollary does not run, and both pass.**

- $C^*$ recomputed from $C(\alpha,\gamma)$ rather than quoted: at $\alpha^*=\tfrac D2$ the kink gives $d=\alpha^*$ and $\gamma^*=\tfrac{\alpha^*}2$, so $C^*=\tfrac{\alpha^*(1+\alpha^*)}{\alpha^*\cdot\alpha^*/2}=2+\tfrac2{\alpha^*}=2+\tfrac{4(m-1)}{2m-1}$, and $J^*=C^*/\gamma^*=\tfrac{4(1+\alpha^*)}{\alpha^{*2}}$. **Both stated forms are the same object.**
- $D$ recomputed from scratch. Tracelessness of $W^*$ on $\Lambda^2$ with multiplicities $m(m-1)$ and $m^2$ forces $\lambda_+/\lvert\lambda_-\rvert=\tfrac m{m-1}$, hence $D=1+\tfrac m{m-1}=\tfrac{2m-1}{m-1}$; normalising $\lVert W^*\rVert_F=1$ returns $\lvert\lambda_-\rvert=\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, **which is [Lemma L145](../findings/second-order.md)'s $g_n$ exactly**. The corollary's $D$ and the record's $g_n$ are one computation, and $m=2$ is inside it.

**Screen.** Exact rationals at $m\in\{2,3,4,5,6,10,10^2,10^4\}$: $\alpha^*=1+\tfrac1{2(m-1)}$, $C=C^*$, $J=J^*$, $\gamma^*<1$ and $D=1+\tfrac m{m-1}$ all hold identically, with $J^*$ running $4.444,\,5.760,\,6.367,\,6.716,\,6.942,\,7.380,\,7.940,\,7.9994$. Monotone increasing toward $8$. *This confirms the closed forms against each other; it is not evidence for the lemma.*

### Correction 1, "attained at $m=2$" is true of the formula and false of the programme

$m=2$ is admissible for **L156 itself**: $W^*=S^2\times S^2$ still has the two-point spectrum ($\lambda_+$ with multiplicity $2$, $\lambda_-$ with multiplicity $4$), $D=3$, $g_n=\tfrac12\sqrt{1/3}\ne0$, and the binding constraint $\gamma^*<1$ holds. **Nothing in L156 degenerates there.** *Indeed $\gamma^*=\tfrac D4<1$ is equivalent to $m>\tfrac32$, so L156's own "slack for every $m\ge2$" is exactly sharp and $m=2$ is its true left endpoint.*

**But nothing else in the chain holds at $m=2$.** The programme works at $n\ge12$, i.e. $m\ge6$; [Lemma L146](../findings/second-order.md) and [Lemma L149](../findings/second-order.md) carry an explicit $m\ge5$ from $c_0\ge\tfrac34\theta_0$; and $\lambda_m=\tfrac{m-2}{2(m-1)}$ is $0$ at $m=2$, so [Lemma L27](../findings/nondegeneracy.md)'s margin is not on the summand the chain uses. **So the endpoint at which the corollary declares its bound attained is a dimension at which the constant has nothing to be a constant of.**

**In scope the sharp statement is tighter and should replace it:** for $m\ge6$,
$$\tfrac{42}{11}\le C^*<4,\qquad 6.9421\le J^*<8,$$
attained at $n=12$. *The corollary's $\tfrac{10}3$ and $\tfrac{40}9$ remain true as bounds and lose their "attained".*

### Correction 2, "dimension-free" belongs to the interval, not to $C^*$ and $J^*$

$C^*$ and $J^*$ are explicit functions of $m$; what is dimension-free is the enclosing interval. **And there is a strictly simpler statement that makes the word literal.** Fix the single $m$-independent contour $(\alpha,\gamma)=(1,\tfrac12)$. Then $d=\min(1,D-1)=1$ for every $m\ge2$, giving
$$C\equiv4,\qquad J\equiv8\qquad\text{at every }m,$$
with **one contour rather than an $m$-indexed family of optima**, and a loss of $15\%$ against the optimum at $n=12$ ($8$ against $6.942$). *A proof that wants an absolute constant should quote this; the $m$-dependent optimum buys $15\%$ at the price of an $n$-dependent contour.*

### The single point of fragility, and it is worth recording

**Every value in the corollary sits at $\alpha^*>1$**, the optimal contour always encloses the origin. That is legitimate only under L156's finding that $\alpha<1$ is not a constraint, which [Lemma L152](../findings/second-order.md), [r456](REVIEW_r456.md) and [r457](REVIEW_r457.md) each denied before it. **Under the rejected constraint the corollary inverts exactly:** on $\alpha<1$ one has $d=\alpha$, $\gamma=\alpha/2$, $J=\tfrac{4(1+\alpha)}{\alpha^2}$ decreasing to an unattained infimum at $\alpha\to1^-$, so
$$C>4,\qquad J>8\qquad\text{for every }m,$$
with the same two numbers as the boundary. *The corollary's suprema $4$ and $8$ are the $\alpha=1$ values, which is why they look absolute: they are the contour through the origin, approached from inside by the rejected reading and from outside by the accepted one.* **The whole corollary is one resolvent-kink ruling away from saying the opposite, and it should say so.**

## C2, the corollary supplies one of the constants, and the sentence claiming otherwise is a plural silently made singular

### The slip, verbatim

- **[I33](../plan.md):** "*STILL OWED: the absolute Cauchy **constants** at the $\beta=0$ end, where $\Theta(n^{-1})=\Theta(g_n)$ puts the tube at the order of the analyticity radius itself and **they decide it**.*"
- **The corollary:** "*[I33](../plan.md)'s outstanding piece is the absolute Cauchy **constant** at the $\beta=0$ end, and this supplies it.*"

**Plural to singular, then the singular is supplied.** That is the whole of C2's force, and it is a substitution rather than a result.

### What C1 does supply, stated precisely, because it is real

Running the record's own chain: $M\le C\rho$ in Frobenius norm (the resolvent sandwich with $\lVert ABC\rVert_2\le\lVert A\rVert_\infty\lVert B\rVert_2\lVert C\rVert_\infty$, which is [Lemma L145](../findings/second-order.md)'s norm bookkeeping), then the Cauchy estimate and $\rho=\gamma g_n/\lVert H\rVert_{op}$:
$$\lVert A''\rVert\;\le\;\frac{2M}{((1-\sigma)\rho)^2}\;\le\;\frac{2C}{(1-\sigma)^2\rho}\;=\;\frac{2}{(1-\sigma)^2}\cdot J\cdot\frac{\lVert H\rVert_{op}}{g_n}.$$
**So $J$ is exactly the constant multiplying $\lVert H\rVert_{op}/g_n$ in [Lemma L149](../findings/second-order.md)'s $\lVert A''\rVert=O(n^{1/2}+nw)$**, the denominator of branch $2$ and of nothing else. *That identification is correct, it is the corollary's substance, and it is worth keeping.* **It is also branch $2$ only.**

### Three constants the $\beta=0$ end needs and this does not give

**1. $\sigma$ is not pinned, and it is not even defined on the record.** The string `(1-\sigma)` occurs **exactly once in the whole of [findings/](../findings/)** (in L156's closing paragraph), with no definition, no range and no value. Until it is fixed, $J^*<8$ is not a number for $\lVert A''\rVert$; the number is $2J^*/(1-\sigma)^2$, which is $<64$ at $\sigma=\tfrac12$ and unbounded as $\sigma\to1$.

> **AND "$\sigma$ FACTORISES OUT, SO THE OPTIMISATION SPLITS" IS TRUE OF THE $(\alpha,\gamma)$ HALF AND FALSE OF THE PROBLEM.** $\sigma$ is the Cauchy shrinkage *and* the reach: $\lVert A''\rVert$ is valid only on $\lvert t\rvert\le\sigma\rho$, which is [Lemma L149](../findings/second-order.md)'s third branch, written there as $\rho/2$, **i.e. $\sigma=\tfrac12$ chosen and never said.** Branch $2$ scales as $(1-\sigma)^2$ and branch $3$ as $\sigma$, so the real object is $\max_\sigma\min(\cdot,\cdot)$ and $\sigma$ does not factorise out of *that*.

**The split does survive, and here is the argument L156 owes.** Write branch $2=K_2(1-\sigma)^2$ and branch $3=K_3\sigma$ with $K_2=\tfrac{\sqrt{c_p+w^2}\,g_n}{2J\lVert H\rVert_{op}}$, $K_3=\tfrac{\gamma g_n}{\lVert H\rVert_{op}}$, so $t:=K_2/K_3=\tfrac{\sqrt{c_p+w^2}}{2J\gamma}$. The crossing is at $t(1-\sigma)^2=\sigma$, and the value there is $K_3\sigma^*=\tfrac{g_n}{\lVert H\rVert_{op}}\gamma\sigma^*$; for small $t$, $\sigma^*\to t$ and $\gamma$ **cancels**, leaving $\tfrac{g_n\sqrt{c_p+w^2}}{2J\lVert H\rVert_{op}}$. **So $J$ is the right objective, and the split is legitimate to first order in $t$, which is what L156 should have said instead of "$\sigma$ factorises out".** *At $n=12$, $w=0$, $\theta_0\approx\sqrt2$, $c_p=3\theta_0/(n-2)\approx0.42$: $t\approx0.085$ and $\sigma^*\approx0.073$, so the split holds to about $15\%$, and the unstated $\sigma=\tfrac12$ of branch $3$ costs a factor $\approx3.4$ against $\sigma^*$.* **That factor is precisely the kind of thing I33's "they decide it" is asking for, and the corollary does not touch it.**

**2. Branch $1$ carries no Cauchy constant at all, and its constant is [I31](../plan.md), which is open.** Branch $1$ is $c_p/S$ with $S=\sup\lvert P\rvert$. At $\beta=0$ this is $\Theta(n^{-1})$ like the others, so it enters the minimum on equal terms, and its constant is $S$, [I31](../plan.md), whose own plan line reads "*The $\beta=0$ end is plausible with an unpinned constant, not proved*". **[Lemma L151](../findings/second-order.md)'s withdrawal box states this in terms: "*branch $1$, $c_p/S$, contains no Cauchy constant at all, so a minimum over three branches cannot turn on $C$ alone. At least nine constants enter.*"** *The corollary is a claim that a minimum over three branches turns on $C$ alone.*

**3. The $u\lesssim w$ constant is recorded as unknown.** Same box: "*the $u\lesssim w$ dependency whose constant is unknown under the route [Lemma L149](../findings/second-order.md) actually cites*". It sets the penalty term $-\lvert\kappa_n\rvert u^2t^2$ against the margin, so it enters $c_p+w^2$, which is branch $2$'s **numerator**, the half of branch $2$ that $J$ does not price.

### So the disclaimer is correctly aimed and incorrectly sized

The corollary's closing "*what it does not by itself supply is the rest of that chain, so whether I33 closes is a separate question and is not claimed here*" is **right, and it is the sentence that saves the entry from being wrong.** But it sits under a bold header reading "*THE CONSTANTS ARE ABSOLUTE, AND THIS IS WHAT I33 SAYS IS OWED*", and the two cannot both stand: the header asserts identity with the owed item and the disclaimer withdraws it. **The disclaimer is a footnote to a headline that contradicts it.**

## Corrections to make

1. **Header:** "*this is one of the constants I33 says is owed*", not "*this is what I33 says is owed*"; and restore I33's plural in the body sentence.
2. **State $\sigma$.** Define it, fix it (the record's implied $\sigma=\tfrac12$, from branch $3$'s $\rho/2$), and print the constant that actually enters: $\lVert A''\rVert\le\tfrac{2J^*}{(1-\sigma)^2}\tfrac{\lVert H\rVert_{op}}{g_n}<64\,\tfrac{\lVert H\rVert_{op}}{g_n}$ at $\sigma=\tfrac12$.
3. **Replace "$\sigma$ factorises out"** with the $t$-crossing argument above, which is what makes the split legitimate, and record that $\sigma=\tfrac12$ is a $3.4\times$ loss at $n=12$.
4. **Scope the "attained":** $[\tfrac{42}{11},4)$ and $[6.9421,8)$ at $m\ge6$, with $m=2$ noted as valid for L156 alone.
5. **Add the fixed-contour corollary** $(\alpha,\gamma)=(1,\tfrac12)\Rightarrow C\equiv4$, $J\equiv8$ at every $m$, the genuinely dimension-free statement, $15\%$ off the optimum.
6. **Record the $\alpha>1$ dependence**: under the rejected $\alpha<1$ the same algebra gives $C>4$, $J>8$, so the corollary is the resolvent-kink ruling and nothing else.

## What would refute this review

A place on the record where $\sigma$ is defined and fixed, or a demonstration that at $\beta=0$ branch $2$ binds against branches $1$ and $3$ with margin, so that $J^*$ alone does decide the minimum. **Neither is in [findings/](../findings/) as of this review**, and [Lemma L151](../findings/second-order.md)'s "at least nine constants enter" is the record's own statement to the contrary.
