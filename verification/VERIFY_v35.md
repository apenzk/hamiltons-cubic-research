# VERIFY v35, L157: the crossing root, its uniqueness, the max–min claim, and the three numerals attached to $t$

*Cold brief, [ROUND_L157](ROUND_L157.md). **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from closed forms already on the record. Log: [agent_logs/verify-L157-v35.log](../agent_logs/verify-L157-v35.log). I read [findings/second-order.md](../findings/second-order.md), [results.md](../results.md) and [reviews/REVIEW_r708.md](../reviews/REVIEW_r708.md) at source; I read no other verifier's report, and none for this round exists on disk.*

## Claim table

| # | Claim, as written | Verdict |
|---|---|---|
| 1 | The two branches cross at a root of $t\eta^2-(2t+1)\eta+t=0$, and that root is $\eta^*=\frac{2t+1-\sqrt{4t+1}}{2t}$ | **CORRECT, algebra checked line by line** |
| 2 | The crossing root is **unique in $(0,1)$** | **TRUE, ARGUMENT ABSENT**, the entry asserts it; the one line that gives it (Vieta: the roots multiply to $1$) is not written, and the entry's own word "reciprocal" presupposes what is to be shown |
| 3 | The other root is **its reciprocal** | **CORRECT**, the product of the roots is $t/t=1$ identically |
| 4 | The other root is **spurious** | **TRUE, ARGUMENT ABSENT**, spurious because $\eta=r/\rho<1$ is forced by the Cauchy estimate $2M/(\rho-\lvert s\rvert)^2$ it comes from; the entry never states $r<\rho$, and without it the second root is a genuine crossing |
| 5 | **The minimum of the two is maximised there** | **TRUE, ARGUMENT ABSENT**, no monotonicity statement appears anywhere in either form; the claim needs "$\eta$ increasing, $t(1-\eta)^2$ decreasing on $(0,1)$", one line, unwritten |
| 6 | The exact identity $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$ | **CORRECT, AND TRIVIAL**, it is the crossing equation multiplied by $\gamma$ |
| 7 | The definition $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ | **CORRECT BUT UNDERIVED HERE, AND ITS MARGIN IS THE UNSAFE FORM**, it reproduces [Lemma L149](../findings/second-order.md)'s $K=\lambda(1-\eta^*)^2/(\sqrt2 J)$ exactly; but it carries $\sqrt{c_p+w^2}$ where L149's repaired numerator is $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$, inflating $t$ by $1.1215$ at $n=12,w=1$, in the direction that overstates the reach |
| 8 | $\sup_w t\to\tfrac18$ at $w=1$ | **REFUTED**, the entry's own $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ gives $\sup_wt\to\lambda_\infty/8=0.19145$; $\tfrac18$ requires $\lambda=1$ |
| 9 | $(1-\eta^*)^2\to0.808$ **at every dimension** | **REFUTED**, $0.7375$ in the limit, and $0.3902$ at $n=12,w=1$ under the entry's own $\lambda(12)=6.275$: a factor $2.07$ |
| 10 | Freezing $\eta=\tfrac12$ cost $2.9$–$3.4$ (Form A) / "about $2.9$" (Form B, the canonical text) | **REFUTED**, the cost is exactly $4(1-\eta^*)^2$, hence $1.561$ at $n=12$ under $\lambda(12)$; $2.9$–$3.4$ is the $\lambda\approx1$–$1.53$ band |
| 11 | "$J^*$ is right to $O(t^2)$" | **MECHANISM CORRECT, SCOPE EMPTY WHERE USED**, $\partial_\gamma(\gamma\eta^*)\vert_{\gamma=d/2}=\frac{(s-1)^2}{s(s+1)}$ is $O(t^2)$, verified exactly; but $t\approx0.96$ at $n=12$ makes an $O(t^2)$ remainder $O(1)$ |
| 12 | Hypotheses of the statement | **NONE STATED, FIVE REQUIRED**, $t>0$, $\eta<1$, $w\in[0,1]$, $n\ge12$, $\ker W^*=0$; each is imported silently |
| 13 | The two forms agree | **THEY DIFFER, TWICE MATERIALLY**, Form B drops uniqueness, reciprocity and the max–min clause and replaces them with "largest solution", which is false without the unstated $\eta<1$; and Form B states a disputed figure ($2.9$) as a single number |
| 14 | Behaviour at $\ker W\ne0$ | **THE STATEMENT ASSERTS SOMETHING IT CANNOT**, at $W_{\mathbb{CP}^2}$, $\dim\ker W=3$, the gap $g_n$ is $0$, so $\rho=\gamma g_n/\lVert H\rVert_{op}=0$ and, by L149's own hypothesis box, branches 2 and 3 have no domain; L157 carries no base-point hypothesis at all |
| 15 | Downstream use in [ROUND_L156](ROUND_L156.md)'s C6, $\eta^*=\frac{s-1}{s+1}$, $\frac{d\eta^*}{dt}=\frac{4}{s(s+1)^2}$, $\partial_\gamma(\gamma\eta^*)=\frac{(s-1)^2}{s(s+1)}$, $\gamma^\dagger/(d-\gamma^\dagger)=s$ | **ALL FOUR CORRECT**, each rederived here from the crossing equation alone; the conviction of L156's C6 rests on algebra that holds |

**One line the round can act on:** the boxed mathematics of L157 is true and its downstream algebra checks out, but two of its three headline clauses have no argument on file, the statement carries none of its five hypotheses, and three numerals attached to it, $\sup_wt\to\tfrac18$, $(1-\eta^*)^2\to0.808$, and the cost $2.9$ that [results.md](../results.md) carries as L157's only figure, are refuted at the entry's own $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$, which no admissible dimension makes equal to $1$.

## 0. Conventions, fixed once

- $\rho$ is the analyticity radius of $W\mapsto W_-$ at the base point, $\rho=\gamma g_n/\lVert H\rVert_{op}$ ([second-order.md:1300](../findings/second-order.md#L1300)); $r$ is the reach; $\eta=r/\rho$; $\sigma$ is the same quantity under [r708](../reviews/REVIEW_r708.md)'s letter.
- $t$ in this report always means L157's dimensionless crossing parameter $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$. **The entry's own opening paragraph uses the same letter for the segment parameter** ("hence $t\le\rho/2$"), which is [r708](../reviews/REVIEW_r708.md)'s $\lvert t\rvert\le\sigma\rho$. Two objects, one letter, four lines apart. Likewise $s$: the segment variable in $\sup_{\lvert s\rvert\le r}$, and $s=\sqrt{1+4t}$ in the L156 box that consumes this lemma.
- $s:=\sqrt{1+4t}$ throughout, so that $\eta^*=\frac{s-1}{s+1}$ and $1-\eta^*=\frac{2}{s+1}$.
- $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ is the spectral gap of $W^*$ at $0$; $g_{12}=\sqrt{20}/(12\sqrt{11})=0.1123667$.
- $\theta_0(12)=\sqrt{55}/6=1.2360331$ (from $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$ and $c_p=3\theta_0/(n-2)$, which agree exactly at $\kappa(12)=3\sqrt{55}/5=4.4497191$); $c_p(12)=\sqrt{55}/20=0.3708099$.
- $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, so $\lvert\kappa_{12}\rvert=\tfrac32\sqrt{55}-9\sqrt{3/2}=11.1242977-11.0227038=0.1015939$ and $\lvert\kappa_n\rvert\to9(\sqrt2-\sqrt{3/2})=1.7052183$.
- $\lambda(n)=2/\sqrt{\lvert\kappa_n\rvert}$, so $\lambda(12)=6.274886$ and $\lambda_\infty=1.5315979$.
- $2J\gamma=2C$ since $J=C/\gamma$; at L156's optimum $C^*=2+4/D$ with $D=\frac{2m-1}{m-1}$, so $2C^*=\frac{84}{11}=7.6363636$ at $n=12$ and $2C^*\to8$.
- All figures above are exact hand evaluations of closed forms already on the record. Nothing here was computed.

## 1. Hypothesis inventory

### 1a. What the statement carries

**Neither form states a single hypothesis.** Form A's box opens "In units of $\rho$ the two coupled branches are…"; Form B opens "The tube chain's reach parameter is the record's own $\eta$…". There is no base point, no dimension range, no range for $w$, no range for $t$, no side condition on $\eta$.

### 1b. What the mathematics requires

| Hypothesis | Where it is needed | Where it comes from | Stated in L157? |
|---|---|---|---|
| $t>0$ | $\eta^*$ is $0/0$ at $t=0$; the roots coincide only there | $c_p>0$ and $\lambda>0$ | no |
| $\eta<1$, i.e. $r<\rho$ | makes the reciprocal root inadmissible; without it Form B's "largest solution" is unbounded | the Cauchy bound $2M/(\rho-\lvert s\rvert)^2$ is meaningless at $\lvert s\rvert\ge\rho$ | no |
| $w\in[0,1]$ | the set the $\sup_w$ runs over, and the reason the sup is attained | [Lemma L149](../findings/second-order.md), "uniformly in $w\in[0,1]$" | no |
| $n\ge12$ ($m\ge6$) | $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ needs $\theta_0(n)>\sqrt{3/2}$; L149 records that at $n=10$, $\theta_0=6/5<\sqrt{3/2}$, so $\lvert\kappa_n\rvert$ is negative and $\rho^{\mathrm{eff}}$ has no definition | [Lemma L149](../findings/second-order.md) | no |
| $\ker W^*=0$ | else $W\mapsto W_-$ is not analytic, $g_n=0$, $\rho=0$, and "branches 2 and 3 have no domain", L149's own words | [Lemma L149](../findings/second-order.md), hypotheses box | no |
| $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ | the margin $c_p$ and the summand bookkeeping | [Lemma L149](../findings/second-order.md) | no |
| $W^*=S^m\times S^m$, $W(z)=W^*+zH$ affine, $\lVert H\rVert_{op}\le1$, $0<\alpha<D$, $0<\gamma<\min(d,1)$ | every appearance of $J$, $\gamma$, $C$, $d$, $D$ inside $t$ | [Lemma L156](../results.md) | no |
| $\rho^{\mathrm{eff}}_n$'s $\tfrac29$ penalty coefficient | $\lambda$ and the margin both descend from $\lvert\kappa_n\rvert$ and $\rho^{\mathrm{eff}}$ | L149 marks this an open `HYPOTHESIS-DEBT` | no |

**Each checked against the object it applies to.** L156's domain conditions do hold at the point L157 evaluates: $\alpha^*=D/2$ and $\gamma^*=D/4$ satisfy $\gamma^*<d=D/2$, and $\gamma^*<1$ for every $m\ge2$ since $D<4$. $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ holds directly, so L156's normalisation is met even where L149's triangle bound $\Theta(n^{-1/2})+w$ exceeds $1$. $n\ge12$ holds throughout the programme's range. $\ker W^*=0$ holds at the sphere product and **fails at the record's named witness**, section 5.

### 1c. Which of these the written proof uses

**Two, both silently.** The derivation as written uses $\eta=r/\rho$ (hence implicitly $\eta<1$, never stated) and the Cauchy coupling $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$ imported from [r450](../reviews/REVIEW_r450.md) D7. Everything else in the box ($t$'s formula, $\lambda$'s value, $J$ and $\gamma$), is quoted, not derived, inside this entry.

*No finding on one point worth recording explicitly: the proof uses no hypothesis that would make the statement narrower than it claims. Its fault is the reverse, it uses hypotheses it does not declare.*

## 2. Pre-registered question 1, is the crossing root the maximiser it is claimed to be?

### 2.1 The crossing equation and the formula

Setting the two branches equal, $\eta=t(1-\eta)^2$, gives $t\eta^2-(2t+1)\eta+t=0$. The discriminant is $(2t+1)^2-4t^2=4t+1$, so the roots are $\frac{2t+1\pm\sqrt{4t+1}}{2t}$, and the minus sign is the entry's $\eta^*$. **Claim 1 is correct**, and the substitution $s=\sqrt{1+4t}$ gives the closed form the downstream entries use: $2t=\frac{s^2-1}{2}$, $2t+1=\frac{s^2+1}{2}$, numerator $\frac{s^2+1}{2}-s=\frac{(s-1)^2}{2}$, hence $\eta^*=\frac{(s-1)^2}{s^2-1}=\frac{s-1}{s+1}$.

### 2.2 Uniqueness in $(0,1)$, true, and the argument is not on file

The product of the roots is $t/t=1$ identically, so the two roots are reciprocal, both positive (their sum $(2t+1)/t>0$), and distinct for every $t>0$ (the discriminant $4t+1$ vanishes only at $t=-\tfrac14$). Exactly one lies in $(0,1)$. Directly: $\eta^*>0\iff(2t+1)^2>4t+1\iff4t^2>0$, and $\eta^*<1\iff\sqrt{4t+1}>1\iff4t>0$.

**What the entry writes is "they cross at the unique root in $(0,1)$ … the other root being its reciprocal and spurious."** Reciprocity is stated and is correct. Uniqueness is asserted. The inference *reciprocal $\Rightarrow$ unique in $(0,1)$* requires knowing first that $\eta^*\in(0,1)$, which is exactly the assertion, so as written the clause leans on itself. The repair is one line and I am not supplying it as the entry's; I record that **the entry contains no argument for uniqueness**, and that my own check found the claim true.

### 2.3 "Spurious", true, and for a reason the entry never gives

The second root $1/\eta^*>1$ is a genuine crossing of the two curves $\eta$ and $t(1-\eta)^2$ extended to $\eta>1$; nothing internal to the quadratic makes it spurious. It is spurious because $\eta=r/\rho$ with $r<\rho$, the Cauchy estimate $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$ is the *source* of the branch and is unbounded as $\lvert s\rvert\uparrow\rho$, so a reach at or beyond $\rho$ prices nothing. **The entry states $\eta=r/\rho$ and never states $r<\rho$**, so the word "spurious" stands unsupported by the text.

Concretely, at $t=\tfrac18$ the value $\eta=100$ satisfies the self-consistency inequality as literally written: $t(1-\eta)^2=0.125\times9801=1225.125\ge100$. So the inequality's solution set on $\eta\in\mathbb R$ is $[0,\eta^*]\cup[1/\eta^*,\infty)$, unbounded above.

### 2.4 The max–min clause, true, and no monotonicity argument appears in either form

On $\eta\in[0,1]$ the first branch $\eta$ increases strictly from $0$ to $1$; the second, $t(1-\eta)^2$, decreases strictly from $t$ to $0$. Hence $\min$ equals $\eta$ on $[0,\eta^*]$ and $t(1-\eta)^2$ on $[\eta^*,1]$, and its maximum is $\eta^*$, attained only there. This holds for **every** $t>0$, including the large-$t$ regime where $t>1$.

**Neither form contains the words "increasing", "decreasing", "monotone", or any equivalent.** The clause "the minimum of the two is maximised there" is a bare assertion. Verdict: true; argument absent.

### 2.5 Quantifier order and scope, as the brief asks

The written object is $\max_\eta\min\big(\eta,\;t(1-\eta)^2\big)$ at **fixed** $t$, which is the correct order and does not distribute, and does not need to, since the maximiser is found directly. Two scope points the statement does not make:

- **The $\max$ does not commute with a $\sup$ or $\inf$ over $w$.** $t$ depends on $w$, and $\rho$ depends on $w$ through $\lVert H\rVert_{op}$, so the uniform radius is $\inf_w\big[\eta^*(t(w))\,\rho(w)\big]$, not $\eta^*(\inf_wt)\inf_w\rho$. [Lemma L158](../findings/second-order.md) separately invokes $\inf_w\min(f,g)=\min(\inf_wf,\inf_wg)$, which **is** an identity (both sides sandwich each other); the corresponding statement for $\sup$ is false, and nothing in L157 depends on it. No finding there.
- **The min is over two of three branches.** [Lemma L149](../findings/second-order.md)'s radius is $\min$ of *three*: $\frac{c_p+u^2}{S+au}$, the validity branch, and $\rho/2$. L157's max–min drops the first, yet its own closing paragraph says branch 1 is *not* independent of $\eta$, "$a\propto(1-\eta)^{-2}$", so branch 1 decreases in $\eta$ too. With two decreasing branches and one increasing, the maximiser of the three-way min is the crossing of $\eta$ with $\min(\text{branch 1},\text{branch 2})$, which is $\eta^*$ **only where branch 2 $\le$ branch 1 at $\eta^*$**. That condition is exactly what [Lemma L158](../findings/second-order.md) leaves *disputed* at $n=12$: r711 puts the threshold near $21$, r712 near $3.98$–$4.44$ against $S\le4.162$ and "calls $n=12$ undecided". Reading $\eta^*$ as the reach therefore imports an unsettled condition, and it errs upward, the unsafe direction for a lower bound on the radius.

## 3. Pre-registered question 2, existence for every admissible $t$, and $t$'s range

### 3.1 Existence: yes, for every $t>0$, and the statement says neither this nor why

By 2.2, $\eta^*\in(0,1)$ for **every** $t>0$, with no upper restriction on $t$ whatsoever, and $t>0$ holds at every admissible parameter since $c_p=3\theta_0/(n-2)>0$ and $\lambda>0$ for $n\ge12$. So the answer to the question is affirmative and unconditional on the admissible set. **The statement gives neither the range of $t$ nor the fact that existence is unconditional on it.**

### 3.2 The range of $t$, and the refutation of $\sup_wt\to\tfrac18$

$t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ and $J\gamma=C$, so $t=\lambda\sqrt{c_p+w^2}/(2C)$. At L156's optimum $2C^*\to8$ and $c_p\to0$, so

$$\sup_{w\in[0,1]}t\;\longrightarrow\;\frac{\lambda_\infty}{8}.$$

**$\sup_wt\to\tfrac18$ therefore holds if and only if $\lambda=1$.** The entry fixes $\lambda$ two paragraphs later as $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$, whose limit is $\lambda_\infty=2/\sqrt{9(\sqrt2-\sqrt{3/2})}=1.5315979$, giving

$$\sup_wt\;\longrightarrow\;\frac{1}{12\sqrt{\sqrt2-\sqrt{3/2}}}\;=\;0.1914497,$$

a factor $1.5316$ above the stated $\tfrac18$. **Claim 8 is refuted by the entry's own definition of $\lambda$.**

The entry's own arithmetic corroborates the diagnosis: "*$t$ from $0.135$ to $0.206$ at the binding direction*" is a ratio of exactly $1.526$, i.e. the same $\lambda:1\to1.53$ rescaling, so the $0.135$ column (and with it the $\tfrac18$), was computed at $\lambda=1$.

### 3.3 Attainment, and the set $w$ ranges over

$t$ is strictly increasing in $w\ge0$, so over $w\in[0,1]$ the supremum **is attained**, at $w=1$; the arrow in the entry is a limit in $n$, not in $w$. The set $w\in[0,1]$ comes from [Lemma L149](../findings/second-order.md) and is nowhere stated in L157. The approach is **from above**: $c_p$ decreases and $2C^*=2(2+4/D)$ increases toward $8$, so $\sup_wt$ decreases in $n$. Hence at *every* finite admissible $n$, $\sup_wt$ exceeds its limit, and the largest admissible value is at the smallest admissible dimension.

### 3.4 The value at $n=12$, in closed form, and the refutation of $0.808$

At $n=12$, $w=1$, with the entry's own $\lambda(12)=6.274886$ and $2C^*=\tfrac{84}{11}$:

$$t=\frac{6.274886\times\sqrt{1.3708099}}{84/11}=\frac{6.274886\times1.1708159}{7.6363636}=\frac{7.3467420}{7.6363636}=0.9620850 .$$

Then $s=\sqrt{1+4t}=\sqrt{4.8483400}=2.2019$, $1-\eta^*=2/(s+1)=0.6246$, and

$$(1-\eta^*)^2=0.390162 .$$

Against the entry's "$(1-\eta^*)^2\to0.808$ **at every dimension**". The three values of $(1-\eta^*)^2$ at $w=1$ are: $0.8082$ at $t=\tfrac18$ (i.e. at $\lambda=1$), $0.7375$ in the limit at $\lambda_\infty$, and $0.3902$ at $n=12$ under $\lambda(12)$. **The stated $0.808$ is attained at no admissible dimension**, and the claim "at every dimension" is false at every dimension. **Claim 9 refuted.**

*The most charitable reading, argued:* "$\to0.808$ at every dimension" may be meant as "the limit is $0.808$, hence the factor does not vanish with $n$", with only the qualitative half load-bearing. **The qualitative half survives**, $t$ is bounded above on the admissible set, so $(1-\eta^*)^2\ge0.3902$ uniformly, and it is the half the entry needed against its predecessor. The numeral does not survive, and it is the numeral that Form A prints and that the "$13$–$22\%$" and "$20\%$" figures beside it are computed from: a $13$–$22\%$ overstatement corresponds to $(1-\eta^*)^2\in[0.820,0.885]$, i.e. $t\in[0.067,0.115]$, *below* even the $\tfrac18$, and inconsistent with $\lambda(12)$, which gives an overstatement of $1/0.3902-1=156\%$.

### 3.5 The cost of freezing $\eta=\tfrac12$, in closed form

At $\eta=\tfrac12$ the min is $\min(\tfrac12,\tfrac t4)=\tfrac t4$ whenever $t\le2$, which holds throughout the admissible range. So the loss from freezing is

$$\frac{\eta^*}{t/4}=\frac{4\,t(1-\eta^*)^2}{t}=4(1-\eta^*)^2,$$

exactly. This reproduces the entry's band as arithmetic: $4\times0.8082=3.233$ at $t=\tfrac18$ and $4\times0.7375=2.950$ at $\lambda_\infty$, the "$2.9$–$3.4$" is precisely the $\lambda\in[1,1.53]$ band. Under the entry's own $\lambda(12)$ it is

$$4\times0.390162=1.561 .$$

**Claim 10 refuted**, and this is the one numeral [results.md](../results.md) carries for L157 ("cost about $2.9$ at the binding direction"). It also disposes of the entry's framing: the cost is a strictly decreasing function of $t$ alone, so "the binding direction is disputed" moves it only through $t(w)$, and the $3\%$ the entry attributes to the location is dwarfed by the $47\%$ its own $\lambda$ moves it.

### 3.6 The $O(t^2)$ claims, read against the range

The entry says "$J$ is *stationary* at the optimum, so $J^*$ is right to $O(t^2)$", and [Lemma L156](../results.md) carries the same. The mechanism checks out exactly. With $t=\Lambda/(2C)$, $C=\frac{\alpha(1+\alpha)}{d(d-\gamma)}$ so $t=B(d-\gamma)$ with $B=t/(d-\gamma)$, and $\frac{d\eta^*}{dt}=\frac{4}{s(s+1)^2}$:

$$\partial_\gamma(\gamma\eta^*)=\eta^*-\frac{\gamma}{d-\gamma}\cdot\frac{s^2-1}{4}\cdot\frac{4}{s(s+1)^2}=\frac{s-1}{s+1}-\frac{\gamma}{d-\gamma}\cdot\frac{s-1}{s(s+1)},$$

which at $\gamma=d/2$ is $\frac{s-1}{s+1}\big(1-\tfrac1s\big)=\frac{(s-1)^2}{s(s+1)}$, the L156 box's expression, exactly. Since $s-1=2t+O(t^2)$ this gradient is $2t^2+O(t^3)$, so the reach's shortfall at $\gamma^*$ is genuinely second order **in $t$**, and $\gamma^\dagger=\frac{ds}{1+s}$ solves $\gamma^\dagger/(d-\gamma^\dagger)=s$ and exceeds $d/2$, as stated.

**The scope is the finding.** At $t=\tfrac18$ the gradient is $\frac{(0.2247)^2}{1.2247\times2.2247}=0.01853$, negligible. At $t=0.9621$ it is $\frac{(1.2019)^2}{2.2019\times3.2019}=\frac{1.44456}{7.05026}=0.20489$, a twenty-percent gradient, and $t^2=0.926$. **An "$O(t^2)$" remainder is $O(1)$ at the smallest admissible dimension under the entry's own $\lambda$.** Every downstream sentence reading "right to $O(t^2)$" as "right" is reading it against the withdrawn $t\le\tfrac18$.

## 4. The definition of $t$, checked at source

The entry asserts $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ with no derivation. It is reconstructible from the record and it is right. From [second-order.md:1300](../findings/second-order.md#L1300), $\lVert A''\rVert\le\frac{2M}{((1-\eta)\rho)^2}$ with $M\le C\rho$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ gives $\lVert A''\rVert\le\frac{2J\lVert H\rVert_{op}}{(1-\eta)^2g_n}$. Branch 2 is then $\lambda\sqrt c/\lVert A''\rVert=\frac{\lambda\sqrt c\,(1-\eta)^2g_n}{2J\lVert H\rVert_{op}}$, and dividing by $\rho$ cancels $g_n$ and $\lVert H\rVert_{op}$ to leave exactly $t(1-\eta)^2$ with the stated $t$. **Two independent confirmations:**

- The identity in the box, $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$, is the crossing equation multiplied by $\gamma$, correct, and worth saying plainly that it is a restatement rather than a new fact. Note that $\gamma$ **does** cancel from branch 2's absolute value (above) while remaining in $t$, because branch 3 $=\eta\rho$ carries it; "$\gamma$ does not cancel" is right about the crossing and would be wrong about branch 2 alone.
- Feeding $g_n\sim\sqrt2/n$ and $\lVert H\rVert_{op}\le a_0/\sqrt n+w$ into that same expression gives branch 2 $=\frac{\lambda(1-\eta)^2}{\sqrt2J}\cdot\frac{\sqrt c}{a_0\sqrt n+nw}$, reproducing **exactly** [Lemma L149](../findings/second-order.md)'s $K=\lambda(1-\eta^*)^2/(\sqrt2J)$. The two entries' prefactors agree asymptotically, which is a real check and not a coincidence of notation.

**The defect this comparison exposes.** L149's numerator is $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$, its repaired form; L157's is $\sqrt{c_p+w^2}$, the form L149 marks in the same file, forty lines above L157, as "**a lower bound stated upward** … unsafe exactly on $n\in\{12,14\}$". With $\rho^{\mathrm{eff}}_{12}=3\theta_0\frac{m-4}{2(m-1)}-\tfrac29\lvert\kappa_{12}\rvert=0.7416199-0.0225764=0.7190435$:

$$\frac{\sqrt{c_p+1}}{\sqrt{c_p+\rho^{\mathrm{eff}}_{12}}}=\frac{\sqrt{1.3708099}}{\sqrt{1.0898534}}=\frac{1.1708159}{1.0439604}=1.121523 .$$

So $t$ is $12.2\%$ too large at $n=12,w=1$, which raises $\eta^*$ (monotone increasing in $t$) and so **overstates the reach**, the same failure mode, in the same direction, that this entry's headline charges against its own predecessor and against [Lemma L149](../findings/second-order.md) via r452 B8. **Claim 7.**

## 5. The edges of every range

| Edge | What L157 asserts there | Verdict |
|---|---|---|
| $t\to0^+$ | nothing | $\eta^*\sim t-2t^2$, and the printed formula is $0/0$ **at** $t=0$; harmless, since $c_p>0$ keeps $t>0$, but the removable singularity is unmentioned |
| $t\to\infty$ | nothing | $\eta^*\to1$: the validity constraint goes vacuous and the reach saturates at $\rho$. This edge is not academic, it is the correct description of $w=0$, see below |
| smallest dimension, $n=12$ | nothing; all its numerals are $n\to\infty$ values | this is where $t$ is **largest** ($0.9621$), where $(1-\eta^*)^2$ is **smallest** ($0.3902$), and where the $O(t^2)$ claims fail. $\lambda(n)$ blows up as $\theta_0\downarrow\sqrt{3/2}$, and $\theta_0(12)=\sqrt{55}/6$ sits only $0.0113$ above it |
| $n\le10$ | nothing | $\lvert\kappa_n\rvert<0$, so $\lambda$ has **no definition**; L157's $t$ does not exist below $n=12$ |
| $w=1$ | $\sup_wt$, "at $w=1$" | attained; correct as attainment, refuted as a value (§3.2) |
| $w=0$ | "there is no branch 2 to optimise, the defect vanishes identically there by [Lemma L148](../findings/second-order.md)" | **the entry's own $t$-formula contradicts this sentence.** At $w=0$ it returns $t=\lambda\sqrt{c_p}/(2C)>0$, hence a *small* $\eta^*$, a tight constraint where the entry says there is none. Both are defensible only because $t$ is built on an **upper** bound for $\lVert A''\rVert$ that does not vanish when the defect does; the truthful reading is $\lVert A''\rVert=0\Rightarrow$ branch 2 $=\infty\Rightarrow t=\infty\Rightarrow\eta^*=1$. The formula is sound but loose there, and the entry never reconciles the two sentences |
| $\ker W\ne0$ | **nothing, and it cannot** | see below |

**$\ker W\ne0$, the record's named witness.** At $W_{\mathbb{CP}^2}$, $\dim\ker W=3$ of $6$ ([INDEX-traps.md](../findings/INDEX-traps.md) W3; padded, kernel $63$ of $66$ at $n=12$, W4). [Lemma L149](../findings/second-order.md)'s hypotheses box is explicit: "**$\ker W^*=0$**, without which $W\mapsto W_-$ is not analytic at $W^*$ and **branches 2 and 3 have no domain**." L157's two coupled branches *are* branches 3 and 2. So at the kernel witness there is no $\rho$ (the gap $g_n$ that defines it is $0$), no $J$ or $\gamma$ (L156 is stated at $W^*=S^m\times S^m$), and no crossing. **L157 asserts nothing there, correctly, but it says nothing there either**, and read literally ("in units of $\rho$ the two coupled branches are…") it presents itself as base-point-free. Given that [INDEX-traps.md](../findings/INDEX-traps.md) W1 records four separate failures of this programme occurring exactly at $\ker W\ne0$, and that all of them were invisible while working with sphere products, a statement in this chain that names no base point is one recurrence away from the same trap.

## 6. The two forms

| | Form A ([second-order.md:1245–1271](../findings/second-order.md#L1245)) | Form B ([results.md:359–362](../results.md#L359)) |
|---|---|---|
| uniqueness in $(0,1)$ | stated | **absent** |
| the other root reciprocal and spurious | stated | **absent** |
| the min is maximised at the crossing | stated | **absent** |
| what replaces them |, | "**whose largest solution is** the crossing root" |
| $\sup_wt\to\tfrac18$, $(1-\eta^*)^2\to0.808$ | stated | absent |
| $13$–$22\%$, $20\%$, $58\times$, $5\%$, $\Theta(n^{1/2})$, $7.24$, $w^*=0.553$ | stated | absent |
| $\lambda=1.53$ and $\lambda(12)=6.275$ | both stated | **neither stated** |
| cost of freezing $\eta=\tfrac12$ | "$2.9$–$3.4$ … the binding direction is **disputed**" | "**about $2.9$** at the binding direction" |
| branch 1 coupled through $a\propto(1-\eta)^{-2}$ | stated | absent |

**Two of these differences are material.**

1. **"Largest solution" is false without the unstated $\eta<1$.** Form A's clause "the unique root in $(0,1)$" carries the domain restriction inside it. Form B drops the restriction and asserts a maximum over the solution set of $r\le\sqrt c/\sup_{\lvert s\rvert\le r}\lVert A''(s)\rVert$, whose solution set in $\eta$ is $[0,\eta^*]\cup[1/\eta^*,\infty)$, unbounded above, as §2.3 exhibits at $t=\tfrac18$, $\eta=100$. *Charitably*: $\eta=r/\rho$ is a fraction of a radius and no reader would take $\eta=100$ seriously, and Form B does say "the bound must hold along the whole segment", which implies $r<\rho$. The clause is repairable by four words. But **the canonical form of the record is the one that dropped the only clause pinning the domain**, and it is the form downstream entries quote.
2. **Form B states a disputed figure as a single number.** Form A says the binding direction "is disputed", that "$0.829$ is refuted", and gives a band $2.9$–$3.4$; Form B says "about $2.9$". A reader of [results.md](../results.md) alone learns neither that the location is disputed nor that the figure moves. And $2.9$ is the endpoint of the band that assumes $\lambda_\infty$, so Form B's single numeral is the one furthest from the value the entry's own $\lambda(12)$ gives ($1.561$).

*One difference in Form B's favour:* by dropping $\sup_wt\to\tfrac18$ and $0.808$ it keeps the two refuted numerals out of the canonical record, leaving only the cost figure.

## 7. What the downstream uses need, at the generality they use it

**[ROUND_L156](ROUND_L156.md)'s C6 and the L156 box at [second-order.md:1437–1443](../findings/second-order.md#L1437) consume four things from L157, and all four are sound.** Rederived here from the crossing equation alone:

- $\sigma=\eta^*=\frac{s-1}{s+1}$, §2.1. ✓
- $\frac{d\eta^*}{dt}=\frac{2}{(s+1)^2}\cdot\frac{2}{s}=\frac{4}{s(s+1)^2}>0$. ✓
- $\partial_\gamma(\gamma\eta^*)\big\vert_{\gamma=d/2}=\frac{(s-1)^2}{s(s+1)}>0$ for every $t>0$, §3.6, derived in full. ✓
- $\gamma^\dagger/(d-\gamma^\dagger)=s$, with $\gamma^\dagger>d/2$: the left side increases from $0$ to $\infty$ on $\gamma\in(0,d)$ while $s=\sqrt{1+4B(d-\gamma)}$ decreases, so the solution is unique, and at $\gamma=d/2$ the left side is $1<s$. ✓

So **the instrument by which L157 convicted its neighbour holds at the generality of that use**: those four consequences need only $t>0$ and the crossing equation, both of which L157 delivers. The conviction of L156's C6 does not fall with anything in this report.

**Where the generality does fall short, in three places.**

- Uses that read $\eta^*$ **as the reach** need branch 2 $\le$ branch 1 at $\eta^*$, which L157 never states and [Lemma L158](../findings/second-order.md) leaves disputed at $n=12$ (§2.5).
- Uses that substitute the **number** $(1-\eta^*)^2$, chiefly [Lemma L149](../findings/second-order.md)'s $K=\lambda(1-\eta^*)^2/(\sqrt2J)$, inherit $0.808$ where $0.3902$ is the $n=12$ value. In L149 this overstates $K$, hence overstates branch 2 and lowers L158's threshold on $S$; that direction happens to *strengthen* L158's conclusion that branch 2 binds, so no downstream verdict reverses, but every printed $K$ is high by a factor up to $2.07$.
- Uses that read "**right to $O(t^2)$**" as "right" are reading it against $t\le\tfrac18$; at $n=12$, $t^2\approx0.93$ (§3.6).

## 8. Discrepancy protocol, the three-step record

Every candidate below was located exactly, exhibited at a named parameter in closed form, and argued against.

| Candidate | Located | Exhibited | Opposite argued | Kept? |
|---|---|---|---|---|
| $\sup_wt\to\tfrac18$ | Form A, "*it does not vanish with $n$*: $\sup_wt\to\tfrac18$ at $w=1$" | $t\to\lambda_\infty/8=0.19145$; $\tfrac18$ requires $\lambda=1$ | "*the constant is generic*", no: the entry fixes $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ two paragraphs later and never revisits the $\tfrac18$ | **kept** |
| $(1-\eta^*)^2\to0.808$ at every dimension | same sentence | $0.7375$ in the limit, $0.3902$ at $n=12,w=1$ | the qualitative half ("does not vanish") survives and is the load-bearing half, recorded, and the numeral still fails | **kept, scoped** |
| cost $2.9$–$3.4$ / "about $2.9$" | Form A "*the loss is $2.9$–$3.4$*"; Form B "*cost about $2.9$*" | cost $=4(1-\eta^*)^2$ exactly, hence $1.561$ at $\lambda(12)$ | "*the binding direction is disputed, so the figure is indicative*", the dispute moves it $3\%$ by the entry's own account; $\lambda$ moves it $47\%$ | **kept** |
| $\sqrt{c_p+w^2}$ in $t$ | Form A and B, the definition of $t$ | inflates $t$ by $1.1215$ at $n=12,w=1$ against L149's $\sqrt{c_p+\rho^{\mathrm{eff}}w^2}$ | "*L157 predates the repair*", the repair sits in the same file forty lines above, and both are dated 2026-09-05 | **kept** |
| uniqueness asserted, not proved | Form A's box | the written inference runs *reciprocal $\Rightarrow$ unique*, which presupposes $\eta^*<1$ | "*Vieta is obvious*", obvious and absent are different, and the brief forbids me supplying it | **kept as a gap, claim true** |
| max–min asserted, not proved | Form A's box | no monotonicity word occurs in either form | as above | **kept as a gap, claim true** |
| Form B's "largest solution" | [results.md:359–362](../results.md#L359) | solution set is $[0,\eta^*]\cup[1/\eta^*,\infty)$; $\eta=100$ solves it at $t=\tfrac18$ | $\eta=r/\rho$ makes $\eta<1$ implicit | **kept, repairable in four words** |
| $t$ overloaded with the segment parameter | Form A, "*hence $t\le\rho/2$*" against the box's $t$ | a reader takes $t\le\rho/2$ for the crossing parameter's range, the very range the round asks for and the entry never gives | the first $t$ is [r708](../reviews/REVIEW_r708.md)'s letter, quoted | **kept as a notation defect** |
| "$\gamma$ does not cancel" | Form A and B | true of the crossing; $\gamma$ *does* cancel from branch 2's absolute value | the sentence is about the crossing, where it is right | **withdrawn**, correct as written |
| L158's $\inf_w\min=\min(\inf_w,\inf_w)$ read into L157 | [Lemma L158](../findings/second-order.md) | both sides sandwich each other; the identity holds | (| **withdrawn**), no defect |
| $J^*$ stationary $\Rightarrow$ $O(t^2)$ | Form A | mechanism verified exactly; only the scope fails | the entry's reason is correct and is an argument, unlike claims 2 and 5 | **withdrawn as an error, kept as a scope finding** |

## 9. What would falsify the statement, and what I did to look

- **A $t>0$ with two roots in $(0,1)$.** Cannot exist: the roots multiply to $t/t=1$ for every $t\ne0$, so one is $<1$ and one is $>1$ unless both equal $1$, which needs $4t+1=0$. I checked the discriminant and both Vieta relations over the whole range $t\in(0,\infty)$, and the two edges $t\to0^+$ and $t\to\infty$ separately.
- **A $t>0$ and an $\eta_0\in[0,1]$, $\eta_0\ne\eta^*$, with $\min(\eta_0,t(1-\eta_0)^2)>\eta^*$.** Cannot exist: below $\eta^*$ the min is at most $\eta_0<\eta^*$; above it, $t(1-\eta_0)^2<t(1-\eta^*)^2=\eta^*$. Checked on both half-intervals and at $t>1$, where the second branch starts above $1$.
- **An admissible $n$ at which $\sup_wt=\tfrac18$.** I looked across the whole admissible range and found none: $\sup_wt$ is $0.9621$ at $n=12$ and decreases monotonically to $0.19145$, so $\tfrac18$ lies strictly below the infimum of the range. That is the falsifier, and it exists.
- **A base point in the chain with $\ker W\ne0$.** The record names one, $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$, where $g_n=0$, $\rho=0$ and by L149's own hypothesis box branches 2 and 3 have no domain. L157 excludes it by no hypothesis. That is a falsifier of the statement's *scope*, and it exists on the record already.
- **A downstream consumer whose verdict reverses under the corrected numerals.** I traced $\eta^*$ and $(1-\eta^*)^2$ into [Lemma L149](../findings/second-order.md)'s $K$, [Lemma L158](../findings/second-order.md)'s threshold, and [Lemma L156](../results.md)'s $\gamma^\dagger$ and $O(t^2)$. None reverses: the $K$ correction moves L158's threshold in the direction that strengthens its conclusion, and L156's four identities need only $t>0$. The damage is confined to the printed constants and to any sentence that reads "$O(t^2)$" as small.

## Verdict

**GAP.**

The boxed mathematics of L157 is true. The crossing formula is correct, the roots are reciprocal, the crossing root is the unique one in $(0,1)$, the min of the two branches is maximised exactly there, and the exact identity is the crossing equation times $\gamma$. Its downstream algebra, the four identities by which it convicted [Lemma L156](../results.md)'s C6, is correct at the generality of that use, and $t$'s definition, though underived in the entry, reproduces [Lemma L149](../findings/second-order.md)'s independently written prefactor.

What is missing and what is wrong:

- **Two of the three headline clauses have no argument on file** (uniqueness in $(0,1)$ and the max–min) and the third, "spurious", rests on $r<\rho$, which the entry never states. Each is one line; none is written; I have not supplied them.
- **The statement carries none of its five hypotheses**: $t>0$, $\eta<1$, $w\in[0,1]$, $n\ge12$, $\ker W^*=0$. The last is the one the record's own trap register calls the recurring obstruction, and the named witness $W_{\mathbb{CP}^2}$ sits outside a fence L157 does not build.
- **Three numerals are refuted at the entry's own $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$**: $\sup_wt\to\tfrac18$ (true value $0.19145$), $(1-\eta^*)^2\to0.808$ at every dimension (true values $0.3902$ at $n=12$, $0.7375$ in the limit), and the cost of freezing $\eta=\tfrac12$ (exactly $4(1-\eta^*)^2$, so $1.561$ at $n=12$, not $2.9$). The third is the only figure [results.md](../results.md) carries for this lemma.
- **$t$ uses the margin form that the same file, forty lines above, marks unsafe at $n\in\{12,14\}$**, inflating $t$ by $12.2\%$ at $n=12$ in the direction that overstates the reach, the error this entry was written to charge against others.
- **Every "$O(t^2)$" in the chain is read against $t\le\tfrac18$** and is $O(1)$ at the smallest admissible dimension.

The lemma needs its two missing lines, its five hypotheses, and its numerals recomputed at a single declared $\lambda(n)$. It does not need a new argument, and nothing that rests on its crossing identity falls.
