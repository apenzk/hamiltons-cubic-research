# REVIEW r380, Gate 2 on the trace–Frobenius ceiling, the ascent argument, and the $\theta\le\sqrt2$ corollary

*2026-09-02. Adversarial review of the last three sections of [ATTEMPTS.md](../ATTEMPTS.md): "Why no criticality consequence can close the pair clause", "Spending the band by ascent", and "A ceiling that works: the trace–Frobenius bound on $\widetilde N$". Both moment identities, the exact spectrum of $\widetilde N$ at $S^m\times S^m$, and the Wolkowicz–Styan form were derived from the definitions before the author's text was opened; the order of work is in [agent_logs/gate2-ceiling-B.log](../agent_logs/gate2-ceiling-B.log).*

**Analysis only.** Two screens were run (seconds each, on $S^m\times S^m$ matrices built here for the purpose) and each reproduced hand algebra that stands without it (criticality residual $2.8\times10^{-17}$, $\lVert M\rVert_F^2=2$ to machine precision). They are reported as screens and are evidence for nothing positive below. The witness in verdict 2 is exhibited by exact algebra, not by a search.

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 0 | $\operatorname{tr}\widetilde N=-2M_{jk}$ and $\lVert\widetilde N\rVert_F^2=2-\lVert o\rVert^2-2M_{jk}^2$ | **CONFIRMED**, both re-derived independently, exact |
| 1a | $(\dagger)$ clears at $S^6\times S^6$ with slack $0.0709$ | **CONFIRMED**, $1.299956$ against $1.370873$ |
| 1b | "*it clears asymptotically … with margin of order $1/n$*" | **REFUTED**, the margin is $\tfrac{11\sqrt2}{2n^2}\approx7.78/n^2$, and the reasoning asserts $\sqrt2\le\theta+M_{jk}$, which is false at every $S^m\times S^m$ |
| 1c | the ceiling is a strong instrument at $S^6\times S^6$ | **REFUTED**, it spends $71.3\%$ of the true slack at $m=6$, $95.5\%$ at $m=32$, $99.87\%$ at $m=1024$ |
| 2a | $(\dagger)$ is enough, given $\theta\ge\sqrt{3/2}$ and the recorded identities | **REFUTED, with witness**, $(n,\theta,M_{jk},\lVert o\rVert)=(12,\ 1.236033,\ 0.05,\ 0)$ satisfies every recorded constraint and fails $(\dagger)$ by $0.0436$ |
| 2b | $(\dagger)$ can prove the pair clause where $o\ne0$ | **REFUTED structurally**, the clause is an *equality* at every such pair, and Wolkowicz–Styan is strict there |
| 3a | ascent from a positive-Hessian direction reaches a critical point | **CORRECTED**, true, on Łojasiewicz; the flow *from $W$* is stationary, so a perturbed start is needed |
| 3b | "*the pair clause is unconditionally true at every pure critical point attaining $\Theta_n$*" | **REFUTED**, the argument assumes the live target, which [findings/INDEX.md](../findings/INDEX.md) records as open |
| 4 | $\theta\le\sqrt2$ at every pure critical point, free | **CONFIRMED**, valid, and doubly redundant against the record |
| 5 | "*a lower bound on $M_{jk}$ is the remaining gap … $M_{jk}$ is not yet controlled*" | **CORRECTED**, $M_{jk}>0$ is already forced in an orbit-free block by [r378](REVIEW_r378.md)'s own identity, and the exact threshold is derived below |

---

## 0. The two moments, re-derived

$N$ is a principal submatrix of a hollow $M$, so $\operatorname{tr}N=0$; row $j$ of $M$ sums to zero, so $\sum_{i\in I}u_i=-M_{jk}$ and likewise for $v$. Hence $\operatorname{tr}\widetilde N=\sum_i(u_i+v_i)=-2M_{jk}$.

Splitting $\lVert M\rVert_F^2=2$ over the blocks gives $\lVert N\rVert_F^2=2-2\lVert u\rVert^2-2\lVert v\rVert^2-2M_{jk}^2$, and adding the diagonal $\lVert u+v\rVert^2$ collapses the cross terms:
$$\lVert\widetilde N\rVert_F^2=2-\big(\lVert u\rVert^2+\lVert v\rVert^2-2u\!\cdot\!v\big)-2M_{jk}^2=2-\lVert o\rVert^2-2M_{jk}^2 .$$

Both agree with the record exactly. The Wolkowicz–Styan form quoted is the sharp one from the first two moments, attained precisely when the lower $d-1$ eigenvalues coincide, a point verdict 2b turns on.

## 1. The ceiling at $S^6\times S^6$: right number, wrong reading, wrong asymptotics

**The exact spectrum is available and the record never takes it.** At $S^m\times S^m$ with $\alpha=-m\gamma/(m-1)$, $\gamma^2=(m-1)/(m^2(2m-1))$, $\theta=\sqrt{(m-1)(2m-1)}/m$, a **within-factor** pair has $u=v$ exactly, and $\widetilde N$ decomposes over the equitable partition $\{A\setminus\{j,k\},\ B\}$ into
$$\operatorname{spec}\widetilde N=\{\underbrace{\alpha}_{m-3},\ \underbrace{2\gamma-\alpha}_{m-1},\ 0,\ -2(m-1)\gamma\},$$
the $2\times2$ symmetric-vector block having determinant identically zero. So
$$\lambda_{\max}(\widetilde N)=2(m-1)\lvert\gamma\rvert,\qquad \textbf{true slack}=\theta+\alpha-\lambda_{\max}=\frac{\theta}{m-1}\ \ \text{exactly}.$$

**The comparison the record owes.** At $m=6$: $\lambda_{\max}=1.123666$, $\theta+M_{jk}=1.370873$, true slack $0.247207$. The ceiling sits at $1.299956$, so it clears by $0.070917$ (the recorded figure, **CONFIRMED**) but it overshoots the truth by $0.176289$, which is $71.3\%$ of everything there was to spend. The trend is monotone and terminal:

| $m$ | $n$ | true slack | ceiling's slack | fraction of true slack spent |
|---|---|---|---|---|
| 4 | 8 | $0.381881$ | $0.187263$ | $51.0\%$ |
| 6 | 12 | $0.247207$ | $0.070917$ | $71.3\%$ |
| 12 | 24 | $0.120500$ | $0.015366$ | $87.2\%$ |
| 32 | 64 | $0.044549$ | $0.001990$ | $95.5\%$ |
| 1024 | 2048 | $0.001381$ | $0.0000019$ | $99.87\%$ |

**The asymptotic claim is false as stated, and its argument is false too.** The record reasons that the left side of $(\dagger)$ tends to $\sqrt2\sqrt{1-1/(n-2)}<\sqrt2\le\theta+M_{jk}$. The last inequality is the error: $\theta+M_{jk}<\sqrt2$ at *every* $S^m\times S^m$ within-factor pair, $1.370873$ at $m=6$, $1.397802$ at $m=20$, $1.413869$ at $m=1024$, always under $\sqrt2=1.414214$, and the record's **own** corollary $\theta\le\sqrt2$ (verdict 4) makes $\theta+M_{jk}\ge\sqrt2$ impossible unless $M_{jk}\ge\sqrt2-\theta$, which is an unproved lower bound of exactly the kind the section says it lacks. Both sides tend to $\sqrt2$, so the comparison must be made at second order. Expanding $\theta=\sqrt{(m-1)(2m-1)}/m$, $\alpha=1/\sqrt{(m-1)(2m-1)}$ and the ceiling in $1/m$:
$$\theta+M_{jk}-\text{ceiling}\;=\;\frac{11\sqrt2}{8m^2}+O(m^{-3})\;=\;\frac{11\sqrt2}{2n^2}+O(n^{-3})\approx\frac{7.78}{n^2},$$
against a true slack of $\theta/(m-1)\sim\sqrt2/m=2\sqrt2/n$. The residual fraction is $11/(8m)=11/(4n)\to0$. *Screen: $(\theta+M_{jk}-\text{ceiling})\cdot m^2$ runs $1.9474$, $1.9452$, $1.9447$, $1.9446$ at $m=1024,4096,16384,65536$ against $11\sqrt2/8=1.944544$; the residual fraction matches $11/(8m)$ to four digits at each.*

**So the reading "a ceiling that works" is not supported by the evidence offered.** The one point tested is the *easiest* pair the reference family has, and there the ceiling consumes seven-tenths of the slack; asymptotically it consumes all of it. A bound that saturates on the family the conjecture is built around carries no margin for anything else.

## 2. The sufficient condition fails inside the band, witness, and a structural reason

### 2a. An orbit-free tuple in the band at which $(\dagger)$ fails

Solve $(\dagger)$ for $M_{jk}$ with $\lVert o\rVert=0$. Writing $d=n-2$, $c=(d+2)/d=n/(n-2)$, $A=2(d-1)/d=2(n-3)/(n-2)$, the condition squares to $c(c+A)M_{jk}^2+2\theta cM_{jk}+(\theta^2-A)\ge0$, so

> **$(\dagger)$ holds in an orbit-free block if and only if**
> $$M_{jk}\;\ge\;M^*(n,\theta)\;=\;\frac{\sqrt{cA\,(c+A-\theta^2)}-\theta c}{c\,(c+A)} ,$$
> **and $M^*>0$ exactly when $\theta^2<A=2-\tfrac2{n-2}$, which holds at every $S^m\times S^m$ and throughout the band.**

Take $n=12$ and $\theta=\Theta_{12}=1.236033$, the **top** of the band and therefore the most favourable value. Then $M^*=0.083338$. Choose $M_{jk}=0.05$. Every recorded constraint is met:

- **band**: $\theta=1.236033\ge\sqrt{3/2}=1.224745$;
- **[r378](REVIEW_r378.md)'s identity** $M_{jk}^2-\theta M_{jk}+u\!\cdot\!v=0$: forces $u\!\cdot\!v=\lVert u\rVert^2=M_{jk}(\theta-M_{jk})=0.059302$, which is $\ge0$ as an orbit-free block requires;
- **Frobenius budget**: $2\lVert u\rVert^2+M_{jk}^2=0.121103\le1$, with room to spare;
- **row sums**: $\sum_iu_i=-M_{jk}=-0.05$ over $10$ coordinates, unobstructed.

$(\dagger)$ evaluates to $1.329627$ against $\theta+M_{jk}=1.286033$, **it fails by $0.043594$**. So $(\dagger)$ is **not a consequence of the four scalars the section says it is an inequality in**. Proving it needs a fifth input, and that input is now named exactly: $M_{jk}\ge M^*(n,\theta)$.

**How far that input is from free.** $M^*$ is not a formality, it is very nearly what the reference family supplies and no more:

| $m$ | $n$ | $\alpha=M_{jk}$ | $M^*(n,\Theta_n)$ | ratio |
|---|---|---|---|---|
| 4 | 8 | $0.218218$ | $0.102242$ | $2.13$ |
| 6 | 12 | $0.134840$ | $0.083338$ | $1.62$ |
| 20 | 40 | $0.036736$ | $0.031981$ | $1.15$ |
| 2000 | 4000 | $0.000354$ | $0.000353$ | $1.0014$ |

Both are $\sim1/(\sqrt2\,m)$ to leading order, so the margin vanishes, the same fact as verdict 1c seen from the other side. And at the **bottom** of the band, where the record has no lower bound on $\theta$ beyond $\sqrt{3/2}$, the demand hardens rather than softens: $M^*(\infty,\sqrt{3/2})=\big(\sqrt3-\sqrt{3/2}\big)/3=0.169102$, an absolute constant, while $M_{jk}$ at the reference family decays like $1/n$. **A lower bound of the form $M_{jk}\ge M^*$ is therefore incompatible with $\theta$ near $\sqrt{3/2}$ at large $n$ unless something forces $\theta$ up with $n$.** That is the item's real obstruction and it is not the one the section names.

### 2b. Where $o\ne0$, $(\dagger)$ can never work, and the record's own reference point shows it

[r376](REVIEW_r376.md)'s unconditional relation is $\widetilde No=(\theta+M_{jk})o$. So at **every** pair with $o\ne0$,
$$\lambda_{\max}(\widetilde N)\;\ge\;\theta+M_{jk},$$
and the pair clause holds there only as an **equality**. Wolkowicz–Styan is strict unless the lower $d-1$ eigenvalues coincide, so $(\dagger)$ must fail at every such pair whose spectrum is not of that degenerate shape.

The **cross** pair of $S^m\times S^m$ is the demonstration, and it is the programme's own reference critical point. With $j\in A$, $k\in B$, $M_{jk}=\gamma<0$, $\lVert o\rVert^2=2(m-1)(\alpha-\gamma)^2>0$:
$$\operatorname{spec}\widetilde N=\{\underbrace{\gamma}_{2m-4},\ 0,\ -2(m-1)\gamma\},\qquad \lambda_{\max}=2(m-1)\lvert\gamma\rvert=\theta+\gamma\ \textbf{ exactly}.$$
The true slack is **zero at every $m$**, the lower eigenvalues $\{\gamma,0\}$ are distinct, and $(\dagger)$ overshoots by $+0.004577$ at $m=6$ ($\theta=1.236033\ge\sqrt{3/2}$), $+0.001195$ at $m=12$, $+0.000436$ at $m=20$. *Screen: exact eigenvalues reproduce the closed forms to $10^{-16}$.*

**Consequence for the record.** $(\dagger)$ is written as a ceiling "in $(\theta,M_{jk},\lVert o\rVert,n)$ alone" and is offered as implying "the pair clause". It implies the clause only on the orbit-free subset $\lVert o\rVert=0$; on its complement it is guaranteed to fail. [I18](../plan.md)'s declared scope is orbit-free blocks, so this is a scope statement rather than a refutation of the item, **but $(\dagger)$'s statement must carry $\lVert o\rVert=0$ as a hypothesis rather than as a variable**, otherwise it invites exactly the failure exhibited above.

## 3. The ascent argument

**3a, convergence.** $P$ is a polynomial and $S$ is compact and real-analytic, so the Łojasiewicz gradient inequality gives convergence of every gradient trajectory to a *single* critical point. The conclusion is therefore true; **the analyticity is used silently**, and without it the $\omega$-limit set of an ascent trajectory on a compact manifold can be a continuum of critical points rather than one. Two smaller corrections: the flow started *at* $W$ is stationary, since $\nabla P(W)=0$, a strict-saddle escape requires starting at $W+tx$ for small $t>0$, where $P(W+tx)=P(W)+\tfrac{t^2}2\lambda+O(t^3)>P(W)$; and the argument needs $x\in V_{jk}\subseteq T_WS$, which the section asserts rather than checks.

**3b, the claim at $\theta=\Theta_n$ is circular.** The chain is: clause fails $\Rightarrow$ ascent reaches $W'$ with $P(W')>\Theta_n$ $\Rightarrow$ [Lemma L57](../findings/problem.md) makes $W'$ non-diagonal $\Rightarrow$ "*which refutes the record's live target*". [findings/INDEX.md](../findings/INDEX.md) records the live target ($\sup\{\theta:Q(W)=\theta W,\ S=0,\ \text{non-diagonal}\}\le\sqrt{3/2}$) as **open**. So what the argument establishes is
$$\text{live target}\ \Longrightarrow\ \text{pair clause at }\theta=\Theta_n,$$
and the pair clause is a step *toward* the live target. **"Unconditionally true" is the wrong word for a statement proved from an open conjecture**, and as a step in the programme the implication runs backwards and delivers nothing. A further hypothesis is silent: the target's $S=0$ clause must hold at the endpoint $W'$, which the argument never establishes for the flow.

**What survives.** The record's own parenthesis, "*consistent with [Corollary L128.1](../findings/second-order.md) proving it there by block arithmetic*", is the load-bearing sentence. The clause at $\theta=\Theta_n$ is already proved independently, so nothing is lost by withdrawing the variational claim, and the section's *second* paragraph (that a variational argument cannot deliver the clause on the open band) stands and is the section's real content.

## 4. $\theta\le\sqrt2$: valid, and redundant twice over

The derivation is correct. $\operatorname{tr}M=0$ with $M\ne0$ gives $\lambda_{\max}(M)>0$; the recorded gap $\operatorname{spec}(M)\cap(0,\theta)=\varnothing$ (from $M^2-\theta M=\Delta_{M^{\circ2}}\succeq0$) upgrades that to $\lambda_{\max}(M)\ge\theta$; and $\lambda_{\max}(M)^2\le\sum_i\lambda_i^2=\lVert M\rVert_F^2=2$. **CONFIRMED.**

Three notes on its standing.

- **It is weaker than the record twice, not once.** The record's own remark that it is weaker than [Lemma L57](../findings/problem.md) is right. It is also weaker than what $\operatorname{tr}M=0$ already buys: Wolkowicz–Styan with $\mu=0$ gives $\lambda_{\max}(M)\le\sqrt{2(n-1)/n}$, hence $\theta\le\sqrt{2(n-1)/n}$, $1.354$ at $n=12$, and that number is on the record as [fence post F14](../findings/second-order.md), where it appears as the value of the same relaxation. The trace is invoked in the derivation and then not spent.
- **The sharper free consequence is also already recorded.** Let $p=\#\{\lambda_i\ge\theta\}$. With $\operatorname{tr}M=0$ and $\sum_+\lambda=S$, Cauchy–Schwarz on the negatives gives $2\ge p\theta^2+S^2/(n-p)\ge p\theta^2 n/(n-p)$, so $\theta^2\le2(n-p)/(pn)$; $p\ge2$ forces $\theta\le\sqrt{(n-2)/n}<1<\sqrt{3/2}$. **In the band, $M$ has exactly one positive eigenvalue.** [diagonal-half.md](../findings/diagonal-half.md) already carries this ("*the vertex matrix of a diagonal critical point at the conjectured value has exactly one positive eigenvalue*", $r\le1.309$ at $\lambda=\theta_0(12)$); the version here is marginally wider, holding at every $\theta>1$ rather than at the conjectured value.
- **Verdict 1b turns on this bound.** Since $\theta\le\sqrt2$ is now on the record, the assertion "$\sqrt2\le\theta+M_{jk}$" in the same file's next section is an assertion that $M_{jk}\ge\sqrt2-\theta\ge0$, i.e. exactly the unproved lower bound the section closes by admitting it lacks.

## 5. The diagnosis "a lower bound on $M_{jk}$ is the remaining gap"

**$M_{jk}$ is not uncontrolled, it is pinned to a quadratic, and its sign is already forced.** In an orbit-free block $u=v$, so $u\!\cdot\!v=\lVert u\rVert^2\ge0$, and [r378](REVIEW_r378.md)'s identity reads
$$\theta M_{jk}=M_{jk}^2+\lVert u\rVert^2\;\ge\;0 .$$
With $\theta>0$ this gives $M_{jk}\ge0$, and $M_{jk}=0$ forces $u=v=0$, so rows $j$ and $k$ vanish entirely, excluded by the connectedness of $\operatorname{supp}(M)$ that the same section already lists among its hypotheses. **So $M_{jk}>0$ strictly, and moreover $M_{jk}=\tfrac12\big(\theta\pm\sqrt{\theta^2-4\lVert u\rVert^2}\big)$ with $\lVert u\rVert\le\theta/2$ on both branches.** The record's "$M_{jk}$ is not yet controlled" understates what its own identity gives, and the answer to whether $M_{jk}$ is guaranteed positive in an orbit-free block is **yes**.

**But the diagnosis is still the wrong one, for two reasons.**

1. **Positivity is not the quantity needed.** What $(\dagger)$ needs is $M_{jk}\ge M^*(n,\theta)$, an $\Omega(1/n)$ lower bound at the top of the band and an $\Omega(1)$ lower bound at the bottom. Through the identity, $M_{jk}\ge M^*$ is equivalent to a **lower bound on the row mass $\lVert u\rVert^2=M_{jk}(\theta-M_{jk})$**, on how much of row $j$ of $M$ lives outside $\{j,k\}$. That is the quantity to attack, and the record has no floor on it. The two constraints available point the wrong way: $\sum_iu_i=-M_{jk}$ with Cauchy–Schwarz gives $\lVert u\rVert^2\ge M_{jk}^2/(n-2)$, which fed back into the identity yields the *upper* bound $M_{jk}\le\theta(n-2)/(n-1)$.
2. **Even granted $M_{jk}\ge M^*$, the route covers only $\lVert o\rVert=0$.** Verdict 2b makes $(\dagger)$ structurally incapable of the clause at any pair with $o\ne0$, where the clause is an equality. If [I18](../plan.md) ever needs pairs outside the orbit-free case, this instrument does not extend, and the fence should say so.

**Corrected diagnosis.** The remaining gap is a lower bound of order $\max\!\big(1/n,\ \text{const}(\theta)\big)$ on $M_{jk}$ (equivalently on $\lVert u\rVert^2$), in an orbit-free block, with the constant $M^*(n,\theta)$ growing to $0.169$ as $\theta$ falls to $\sqrt{3/2}$; and $(\dagger)$'s statement must be restricted to $\lVert o\rVert=0$.

## Silently used hypotheses

| # | Hypothesis | Where |
|---|---|---|
| S1 | $\theta+M_{jk}\ge\sqrt2$, i.e. $M_{jk}\ge\sqrt2-\theta$ | the asymptotic clearance argument for $(\dagger)$, false at $S^m\times S^m$ |
| S2 | $\lVert o\rVert=0$ | $(\dagger)$ is stated with $\lVert o\rVert$ free but is unprovable wherever $o\ne0$ |
| S3 | $M_{jk}\ge M^*(n,\theta)$ | $(\dagger)$'s truth; the section calls $M_{jk}$ merely "not yet controlled" |
| S4 | real-analyticity of $P$ (Łojasiewicz), for convergence of ascent to a single point | the variational section |
| S5 | $V_{jk}\subseteq T_WS$, and a perturbed start $W+tx$ rather than $W$ | the variational section |
| S6 | the live target itself, and $S=0$ at the ascent endpoint $W'$ | "the clause is unconditionally true at $\theta=\Theta_n$" |
| S7 | $\theta>0$ and connectedness of $\operatorname{supp}(M)$, for $M_{jk}>0$ | not used, but they are what makes verdict 5's positivity available |

## What the item should carry forward

1. **Replace "a ceiling that works" with the exact threshold.** $(\dagger)$ in an orbit-free block is equivalent to $M_{jk}\ge M^*(n,\theta)=\big[\sqrt{cA(c+A-\theta^2)}-\theta c\big]/\big[c(c+A)\big]$, $c=n/(n-2)$, $A=2(n-3)/(n-2)$. This is a clean reduction and it is the section's genuine content; the $S^6\times S^6$ evaluation is a single point on it.
2. **Record that the ceiling saturates on the reference family**, residual fraction $11/(4n)$ of the true slack, with the margin $\tfrac{11\sqrt2}{2n^2}$ against a true slack $\tfrac{2\sqrt2}{n}$, so a successor route cannot lose anything at all and still clear.
3. **Record the equality obstruction.** At every pair with $o\ne0$ the clause is an equality, so no first-two-moment bound can prove it. This belongs in [routes.md](../routes.md) as a fence on the whole moment-ceiling family, not on $(\dagger)$ alone.
4. **Withdraw "unconditionally" from the $\theta=\Theta_n$ claim**, keeping the section's second paragraph, which is correct and is a fence.
5. **Add $M_{jk}>0$ and $M_{jk}=\tfrac12(\theta\pm\sqrt{\theta^2-4\lVert u\rVert^2})$ in an orbit-free block** to the record, and restate the open gap as a floor on $\lVert u\rVert^2$.
