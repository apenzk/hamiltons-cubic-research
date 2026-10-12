# VERIFY v33, L157: the crossing root $\eta^*$, its maximality clause, the range of $t$, and the $0.808$ that does not belong to any of them

*Cold brief, verifier v33, [ROUND_L157](ROUND_L157.md). **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from a closed form, each of which is displayed before it is evaluated. Log: [agent_logs/verify-L157-v33.log](../agent_logs/verify-L157-v33.log).*

## Claim table

| # | Claim, as written | Verdict |
|---|---|---|
| 1 | $\eta$ and $t(1-\eta)^2$ cross at $\eta^*=\frac{2t+1-\sqrt{4t+1}}{2t}$ | **CORRECT**, reproduced from the entry's own crossing equation; equals $\frac{s-1}{s+1}$, $s=\sqrt{4t+1}$ |
| 2 | the crossing root is unique in $(0,1)$ | **CORRECT, ARGUMENT ABSENT**, true for every $t>0$; no argument on file |
| 3 | "the other root being its reciprocal" | **CORRECT, ARGUMENT ABSENT**, the product of roots is $t/t=1$; not shown in the entry |
| 4 | "and spurious" | **CORRECT ONLY UNDER AN UNSTATED RESTRICTION**, needs $\eta<1$, which neither form states |
| 5 | "the minimum of the two is maximised there" | **CORRECT ONLY UNDER AN UNSTATED RESTRICTION**, false on $\eta\in[0,\infty)$, where the min is unbounded; true on $[0,1]$; no argument on file |
| 6 | the crossing identity $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$ | **CORRECT AND EMPTY**, it is the crossing equation multiplied by $\gamma$ |
| 7 | "$\gamma$ does not cancel" | **CORRECT**, $J\gamma=C(\alpha,\gamma)$, which still carries $\gamma$ |
| 8 | "$J$ is stationary at the optimum, so $J^*$ is right to $O(t^2)$" | **CORRECT, AND THE ERROR IS EXACTLY $1/(1-\eta^{*2})$** |
| 9 | "$\sup_wt\to\tfrac18$ at $w=1$" | **BROKEN**, it is $\lambda/8$, and the entry's own $\lambda$ is $1.53$ asymptotically and $6.275$ at $n=12$ |
| 10 | "so $(1-\eta^*)^2\to0.808$ at every dimension" | **BROKEN**, $0.808$ is exactly the value at $t=\tfrac18$; at $n=12$ on the entry's own constants the factor lies in $[0.390,0.536]$ |
| 11 | "a $13$–$22\%$ overstatement at $n=12$, $20\%$ at the binding direction" | **BROKEN**, every one of these percentages is a $\lambda=1$ number |
| 12 | "the loss is $2.9$–$3.4$" together with claim 10 | **MUTUALLY INCONSISTENT**, the loss is identically $4(1-\eta^*)^2$, and $4\times0.808=3.23$ is a point, not the range |
| 13 | hypotheses of the statement | **NONE STATED; SIX USED**, one of them ($\ker W^*=0$) with a named witness against it |
| 14 | the two forms | **THEY DIFFER**, the canonical form drops clauses 2, 3, 4 and 5 and states as settled what the findings form records as disputed |

**One line the round can act on:** the displayed **Lemma L157 is correct in every clause** and is a genuine result, but **it carries no hypotheses, three of its four clauses have no argument on file, and the paragraph that supports it is arithmetic at $\lambda=1$, a value the next paragraph of the same entry replaces by $1.53$ and then by $6.275$**, so $0.808$, the $13$–$22\%$ and the $20\%$ all fall, and $\sup_wt$ at $n=12$ is $0.962$ rather than $\tfrac18$.

## 0. Conventions, fixed once

- $s:=\sqrt{4t+1}$ throughout. $t>0$.
- $\eta=r/\rho$, the reach in units of the analyticity radius $\rho$; $\rho=\gamma g_n/\lVert H\rVert_{op}$ and $M\le C\gamma g_n$ are the imports from [Lemma L156](../findings/second-order.md) that make the entry's $t$ what it is.
- $C(\alpha,\gamma)=\frac{\alpha(1+\alpha)}{d(d-\gamma)}$, $J=C/\gamma$, $D=\frac{2m-1}{m-1}$, $d=\min(\alpha,D-\alpha)$, $\alpha^*=D/2$, $\gamma^*=D/4$, all from [Lemma L156](../results.md).
- $n=2m$; $\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n}$, which is the one form under which the record's $c_p=3\theta_0/(n-2)$ and $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$ agree; $\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big)$; $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$.
- "the loss" means the ratio of the fixed-point reach to the reach obtained by freezing $\eta=\tfrac12$, which is how the entry's "not the factor $4$ first claimed" reads.
- $w$ is [Lemma L149](../findings/second-order.md)'s weight outside **both** $S^2_0(\mathbb R^m)$ copies, on $\lVert H\rVert_F=1$, so $w\in[0,1]$.

## 1. The hypothesis inventory

**What the statement of L157 carries: nothing.** Neither form states a base point, a dimension, a range for $w$, a range for $t$, or a kernel condition. The blockquote opens "In units of $\rho$" and proceeds.

**What the written proof and the display actually use.**

| Hypothesis | Where it is needed | Where it is stated |
|---|---|---|
| $t>0$ | the displayed formula is $0/0$ at $t=0$; the root is in $(0,1)$ only for $t>0$ | nowhere |
| $\eta\in(0,1)$, i.e. $r<\rho$ | clauses 4 and 5 both fail without it (§3) | signalled by "the unique root in $(0,1)$" in Form A; **absent from Form B** |
| $W^*=S^m\times S^m$, $n=2m$ | $\rho$, $M$, $g_n$, $\gamma$, $c_p$, $\kappa_n$ all exist only there | nowhere |
| $\ker W^*=0$ | [Lemma L149](../findings/second-order.md): without it $W\mapsto W_-$ is not analytic at $W^*$ and "branches 2 and 3 have no domain" | nowhere |
| $n\ge12$ | $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ needs $\theta_0(n)>\sqrt{3/2}$, and $\theta_0(10)=\tfrac65<\sqrt{3/2}$, L149 records exactly this | nowhere |
| $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ | the margin $c_p$ excludes the $\langle W\rangle$ and orbit summands; L149 states it | nowhere |
| $w\in[0,1]$ | $\sup_w$ has no meaning otherwise, and the claim "at $w=1$" is a claim about an endpoint | nowhere |
| $m\ge2$ (L156's $C$), $m\ge5$ (L148's "margin") | inherited through $J$, $\gamma$, and the vanishing at $w=0$ | nowhere |
| $c(H)\ge c_p+w^2$ | the $\sqrt{c_p+w^2}$ in $t$ | used silently; [Lemma L149](../findings/second-order.md) records this exact form as **"a lower bound stated upward … unsafe exactly on $n\in\{12,14\}$"**, the true coefficient being $0.7416$ at $n=12$ |

**No finding on one point:** the entry uses no hypothesis that is *false* at its own base point. The defect is that it states none of the nine, and that the ninth is one its own source flags as unsafe at the two dimensions the programme works at.

## 2. The crossing root (pre-registered question 1, first clause)

*Locate.* "the two coupled branches are $\eta$ and $t(1-\eta)^2$ … they cross at the unique root in $(0,1)$ $\eta^*(t)=\frac{2t+1-\sqrt{4t+1}}{2t}$".

The crossing condition is $\eta=t(1-\eta)^2$, i.e.

$$t\eta^2-(2t+1)\eta+t=0,\qquad \eta=\frac{2t+1\pm\sqrt{(2t+1)^2-4t^2}}{2t}=\frac{2t+1\pm s}{2t},\quad s=\sqrt{4t+1},$$

since $(2t+1)^2-4t^2=4t+1$ exactly. **The displayed root is the minus branch, and it is right.**

It has a form the entry does not give and which makes the rest transparent. Substituting $t=\frac{s^2-1}{4}$, so $2t=\frac{s^2-1}{2}$:

$$\eta^*=\frac{\frac{s^2-1}{2}+1-s}{\frac{s^2-1}{2}}=\frac{s^2-2s+1}{s^2-1}=\frac{(s-1)^2}{(s-1)(s+1)}=\boxed{\frac{s-1}{s+1}},\qquad 1-\eta^*=\frac{2}{s+1},\qquad (1-\eta^*)^2=\frac{4}{(1+\sqrt{4t+1})^2}.$$

From this: the product of the two roots is $t/t=1$, so **the other root is $\frac{s+1}{s-1}$, the reciprocal, claim 3 is right**; and their sum is $\frac{2t+1}{t}=2+\tfrac1t>2$, so the roots are distinct for every $t>0$ and exactly one of them lies in $(0,1)$. That $\eta^*\in(0,1)$ needs no case analysis: $s>1$ for $t>0$ gives $0<\frac{s-1}{s+1}<1$ directly.

*Argue the opposite.* There is no reading on which the algebra fails; the entry's own crossing equation forces it. **No finding against clauses 1 and 3, beyond that the entry writes neither the quadratic nor the reciprocity it asserts.**

The inverse is worth recording because every number below uses it: $t=\dfrac{\eta^*}{(1-\eta^*)^2}$.

## 3. "The minimum of the two is maximised there" (pre-registered question 1, second clause)

*Locate.* The final clause of the first sentence of the blockquote, Form A only.

*Exhibit.* As written the clause carries no domain, and **on $\eta\in[0,\infty)$ it is false**. Take $t=\tfrac18$ and $\eta=10$: then $t(1-\eta)^2=\tfrac{81}{8}=10.125>10$, so $\min\big(\eta,t(1-\eta)^2\big)=10$, against the value $\eta^*=5-2\sqrt6=0.101021$ at the crossing. The min is in fact unbounded above on $[\tfrac{s+1}{s-1},\infty)$, where the increasing branch is the smaller one; the solution set of $\eta\le t(1-\eta)^2$ on $[0,\infty)$ is $[0,\eta^*]\cup[\tfrac1{\eta^*},\infty)$, which has **no largest element**, so Form B's "whose largest solution is the crossing root" is, read on $[0,\infty)$, false in the same way.

*Argue the opposite.* The charitable reading holds and I take it: $\eta=r/\rho$ and the bound $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$ is a Cauchy estimate on the disc of radius $\rho$, so $r<\rho$ and $\eta\in(0,1)$ by construction; Form A's own phrase "the unique root in $(0,1)$" signals it. On $[0,1]$ the clause is true and one line: $\eta\mapsto\eta$ increases from $0$ to $1$, $\eta\mapsto t(1-\eta)^2$ decreases from $t$ to $0$, they meet once at $\eta^*$, so the min equals the increasing branch left of $\eta^*$ and the decreasing branch right of it, and is maximised at $\eta^*$ with value $\eta^*$.

*Verdict on the candidate.* **Withdrawn as a break; recorded as an unstated, load-bearing domain restriction, and as an assertion with no argument on file.** The clause is one of two things the round pre-registered; the entry proves neither. What is owed is one sentence: the domain $\eta\in[0,1)$, and the two monotonicities.

**A second reading, and why it is worse.** "the two" has two antecedents in the same entry: the "two coupled branches $\eta$ and $t(1-\eta)^2$" of the sentence itself, and **"branch 1" and "branch 2" of the record**, which the same entry uses four paragraphs later ("Branch 2 is $\lambda\sqrt c/\lVert A''\rVert$", "branch 1 is not untouched", "branch 2 beats branch 1 by about $58\times$"). Those are [Lemma L149](../findings/second-order.md)'s $\frac{c_p+u^2}{S+au}$ and $\frac{\sqrt{c_p+w^2}}{n^{1/2}+nw}$, different objects, minimised over $w$, with no parameter to maximise over. Under that reading the clause is not false but incoherent. **The collision of vocabulary is a finding in its own right**: the entry uses "branch" for two disjoint pairs and never says so.

## 4. Existence, and the range of $t$ (pre-registered question 2)

**Existence: unconditional, and this is a clean negative for the round.** For every $t\in(0,\infty)$, $s>1$ and $\eta^*=\frac{s-1}{s+1}\in(0,1)$. $\eta^*$ is strictly increasing in $t$ (equivalently $t=\eta/(1-\eta)^2$ is increasing on $(0,1)$), with $\eta^*\to0$ as $t\to0^+$ and $\eta^*\to1$ as $t\to\infty$. **No admissible $t$ fails to have a fixed point.** The displayed formula alone is $0/0$ at $t=0$; the $\frac{s-1}{s+1}$ form is not, and $t=0$ is unreachable anyway since $c_p>0$ at every finite $n$.

**Is the supremum attained?** $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ is strictly increasing in $w$, and $w$ ranges over the closed $[0,1]$ (L149's normalisation, re-derived at [r716](../reviews/REVIEW_r716.md) per [Lemma L149](../findings/second-order.md)). **So the supremum is attained, at $w=1$.** The entry's "$\to$" is a limit in $n$, not a failure of attainment; that much of the pre-registered worry is answered in the entry's favour. **What is absent is the range of $w$ itself**, the statement never says $w\in[0,1]$, and the whole of "$\sup_w$" depends on it.

**The value of the supremum, which is the finding.** At L156's optimum $\alpha^*=D/2$, $\gamma^*=D/4$ one has $d=\alpha^*$, $\gamma^*=\alpha^*/2$, so

$$2J^*\gamma^*=2\cdot\frac{4(1+\alpha^*)}{\alpha^{*2}}\cdot\frac{\alpha^*}{2}=\frac{4(1+\alpha^*)}{\alpha^*}=\frac{4(4m-3)}{2m-1},$$

which is $\tfrac{84}{11}=7.636363\ldots$ at $m=6$ and increases to $8$. Hence, exactly,

$$t=\frac{\lambda\sqrt{c_p+w^2}\,(2m-1)}{4(4m-3)},\qquad \sup_{w\in[0,1]}t=\frac{\lambda\sqrt{c_p+1}\,(2m-1)}{4(4m-3)}\ \longrightarrow\ \frac{\lambda}{8}.$$

**So $\sup_wt\to\tfrac18$ holds if and only if $\lambda\to1$.** The entry's own next paragraph sets $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ with $\lvert\kappa_\infty\rvert=9(\sqrt2-\sqrt{3/2})=1.705218$, so $\lambda_\infty=2/1.305840=1.531572$ and $\sup_wt\to0.191446$; and its last paragraph corrects $\lambda$ to the finite-$n$ value $\lambda(12)=2/\sqrt{0.1015938}=6.274757$.

**At $n=12$, on the entry's own constants, $t$ does not come near $\tfrac18$ at any $w$.** With $c_p=\sqrt{220}/40=0.3708099$ and $\tfrac{2m-1}{4(4m-3)}=\tfrac{11}{84}=0.1309524$:

| $w$ | $\sqrt{c_p+w^2}$ | $t$ at $\lambda(12)=6.274757$ | $s=\sqrt{4t+1}$ | $(1-\eta^*)^2=4/(1+s)^2$ |
|---|---|---|---|---|
| $0$ | $0.608942$ | $0.500360$ | $1.732278$ | $0.535729$ |
| $1$ | $1.170817$ | $0.962087$ | $2.201896$ | $0.390163$ |

**$\sup_wt=0.962$ at $n=12$, not $0.125$**, a factor $7.7$, and $(1-\eta^*)^2$ runs over $[0.390,0.536]$ across the direction sphere, never touching $0.808$.

## 5. The $0.808$, and where it comes from

*Locate.* "**it does not vanish with $n$**: $\sup_wt\to\tfrac18$ at $w=1$, so $(1-\eta^*)^2\to0.808$ at every dimension."

*Exhibit, in closed form.* At $t=\tfrac18$, $s=\sqrt{3/2}$ and

$$\eta^*=\frac{\sqrt{3/2}-1}{\sqrt{3/2}+1}=5-2\sqrt6,\qquad (1-\eta^*)^2=\frac{4}{\big(1+\sqrt{3/2}\big)^2}=\frac{4}{\tfrac52+\sqrt6}=16\big(\tfrac52-\sqrt6\big)=40-16\sqrt6=0.808164\ldots$$

so the entry's $0.808$ is **exactly** the value at $t=\tfrac18$, to every digit it prints. By §4, $t=\tfrac18$ is the $n\to\infty$, $w=1$ value **at $\lambda=1$**. The three values of $\lambda$ the entry itself asserts give, at $w=1$:

| $\lambda$ | $t$ | $(1-\eta^*)^2$ | loss $=4(1-\eta^*)^2$ |
|---|---|---|---|
| $1$, $n\to\infty$ (never asserted; the source of $0.808$) | $0.125$ | $0.808164$ | $3.2327$ |
| $1$, $n=12$ | $0.153326$ | $0.775976$ | $3.1039$ |
| $1.531572$, $n\to\infty$ | $0.191446$ | $0.737537$ | $2.9501$ |
| $1.531572$, $n=12$ | $0.234830$ | $0.698838$ | $2.7954$ |
| $6.274757$, $n=12$ | $0.962087$ | $0.390163$ | $1.5607$ |

*Argue the opposite.* The most charitable reading is that $\lambda$ was meant to sit outside $t$, that the entry's $t$ is the bare $\sqrt c\rho/(2M)$ and $\lambda$ multiplies branch 2 elsewhere. **That reading is closed by the entry's own display**, which puts $\lambda$ inside $t$: $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$; by [second-order.md:1302](../findings/second-order.md), which reads L157's $t$ as $\lambda\sqrt{c_p+w^2}/(2C)$; and by the entry's own sentence three lines later, *"Every number moves with it: $t$ from $0.135$ to $0.206$ at the binding direction"*, a ratio of $1.526$, i.e. exactly the rescaling by $\lambda=1.53$. **$0.808$ is one of the numbers that did not move.**

*The internal contradiction that needs no external constant.* Freezing $\eta=\tfrac12$ gives the reach $t(1-\tfrac12)^2=t/4$; the fixed point gives $\eta^*=t(1-\eta^*)^2$. So the loss is, identically,

$$\frac{\eta^*}{t/4}=4(1-\eta^*)^2=\frac{16}{\big(1+\sqrt{4t+1}\big)^2},$$

and the entry's "the loss is $2.9$–$3.4$" is therefore the statement $(1-\eta^*)^2\in[0.725,0.85]$. **A quantity cannot both range over $[0.725,0.85]$ and equal $0.808$ "at every dimension".** The two sentences are three lines apart. (Their own $t=0.206$ gives loss $2.896$; the entry's "not the factor $4$ first claimed" is the observation that $4(1-\eta^*)^2<4$, the factor $4$ being the $t\to0$ limit of the same expression.)

*Consequences for the percentages.* "$20\%$ at the binding direction" is $1-0.80816=0.19184$, and "$13$–$22\%$" is $1-(1-\eta^*)^2\in[0.13,0.22]$, i.e. $t\in[0.077,0.150]$, the $\lambda=1$ window again. At the entry's own $\lambda(12)$ the overstatement at $n=12$, $w=1$ is $1-0.390163=61\%$, not $13$–$22\%$.

**Verdict on this cluster: BROKEN.** The qualitative conclusion the paragraph is defending (that $(1-\eta^*)^2$ neither drops nor vanishes with $n$), **survives**, and survives comfortably: $(1-\eta^*)^2\ge0.39$ at $n=12$ and increases toward $0.74$. Every number attached to it falls.

## 6. The edges

- **$t\to0^+$.** $\eta^*=t-2t^2+O(t^3)$, from $\sqrt{1+4t}=1+2t-2t^2+O(t^3)$; the reach vanishes linearly with $t$ and the displayed formula is the only thing that misbehaves ($0/0$). The record's $t$ never reaches $0$.
- **$t\to\infty$.** $\eta^*\to1^-$: the reach fills the analyticity disc, consistent with the Cauchy bound blowing up only at $\eta=1$. The statement is well behaved here; note only that $t\ge2$ would make $\eta^*\ge\tfrac12$ and reverse the direction of "what freezing $\eta=\tfrac12$ cost". **On the record no such $t$ exists**: $t$ is largest where $\lambda$ is largest, $\lambda(n)$ decreases in $n$, and $\sup_wt(12)=0.962<2$.
- **Smallest admissible dimension.** $n=12$, forced by $\lambda$: $\theta_0(10)=\tfrac65<\sqrt{3/2}$ makes $\lvert\kappa_{10}\rvert$ negative and $\lambda$ imaginary. **Stated in neither form.** L149 also restricts its uniformity to $m\ge6$.
- **$w=0$.** $t(0)=\lambda\sqrt{c_p}/(2J\gamma)>0$, so the formula returns a **finite** cap $\eta^*(t(0))\rho$, while the entry's own closing paragraph says "At $w=0$ there is no branch 2 to optimise, the defect vanishes identically there by [Lemma L148](../findings/second-order.md)". *Argue the opposite:* the chain is an inequality throughout, and $\sqrt c/\lVert A''\rVert$ uses an **upper** bound on $\lVert A''\rVert$ that does not vanish at $w=0$ even though the defect does, so the finite value is a valid, non-tight lower bound on the reach, exactly as [Lemma L149](../findings/second-order.md)'s "$\Omega$, not $\Theta$" paragraph says. **Candidate withdrawn**, and recorded here because the two sentences read as a contradiction and are not one.
- **$w=1$.** Admissible and attained (§4); it is where $\sup_wt$ sits, and where [r714](../reviews/REVIEW_r714.md) puts the binding direction.
- **$\ker W\ne0$, at $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$.** **L157 asserts nothing there, and says so nowhere.** Its $t$ is built from $\rho$, $M$, $g_n$ and $\gamma$, and [Lemma L147](../findings/second-order.md)'s hypothesis box records that at $W_{\mathbb{CP}^2}$ "$g_n$, $\rho$, $M$ and branches 2–3 **do not exist there**"; [Lemma L149](../findings/second-order.md) makes $\ker W^*=0$ explicit as the condition for analyticity of $W\mapsto W_-$. So $t$ has no value at that point and $\eta^*$ has no argument. **The contrast is the finding**: [Lemma L148](../findings/second-order.md) states in its own box that it "asserts nothing at $W_{\mathbb{CP}^2}$", and [Lemma L147](../findings/second-order.md) was made to carry the same after [ROUND_L147](ROUND_L147.md). L157, written after both, carries neither the hypothesis nor the disclaimer.

## 7. Quantifier order, and what the downstream uses need

**Inside the statement the order is sound.** $t$ is free of $\eta$ (it is built from $\lambda$, $c_p$, $w$, $J$, $\gamma$, none of which depends on $\eta$) so $\max_\eta\min\big(\eta,t(1-\eta)^2\big)$ is a genuine one-variable problem at fixed $t$, and the $\min$ is not distributed across anything. **No finding.**

**Outside it, the same $\min$ is distributed, and L157 is the entry that says so.** Since $t$ depends on $w$, so do $\eta^*$ and $(1-\eta^*)^2$. [Lemma L149](../findings/second-order.md)'s box writes branch $2=K\,g_\rho(w)$ with $K=\lambda(1-\eta^*)^2/(\sqrt2J)$ **pulled out of the minimisation over $w$**, which is legitimate for the order $\Omega(n^{-1})$ that box claims (it says as much, "$K$ being bounded below by a positive constant") and illegitimate for any constant. L157 itself flags the same thing when it says [r714](../reviews/REVIEW_r714.md) reaches $w=1$ "once this lemma's own $w$-dependence of $(1-\eta^*)^2$ is kept inside the minimisation". **The statement supplies what is needed here** (it exhibits $t$'s $w$-dependence) and the defect lies in the consumers.

**What the consumers need and the statement does not give.**

1. **The identification $\sigma=\eta$.** [Lemma L156](../results.md) writes the reach as $\sigma\rho$ carrying a $(1-\sigma)^2$; L157 writes $\eta$ and asserts the record "has always had it". **Neither form of L157 states that $\sigma$ and $\eta$ are one symbol**, yet [ROUND_L156](ROUND_L156.md) used L157's text to refute "$\sigma$ has no definition on the record". The refutation is correct on the mathematics and unwritten in the lemma.
2. **The generality of $\eta^*$ as a function.** [ROUND_L156](ROUND_L156.md)'s C6 needs $\eta^*$ to be a strictly increasing function of $t$ and $t$ to depend on $C$. **The statement gives neither monotonicity nor the reduction $J\gamma=C$**; the monotonicity is a one-line consequence of $t=\eta/(1-\eta)^2$ that the entry never writes, and the reduction appears only at [second-order.md:1302](../findings/second-order.md), in L158's block rather than in L157.
3. **The $O(t^2)$ claim, which checks out and is sharper than stated.** $J\propto\frac1{\gamma(d-\gamma)}$ is stationary at $\gamma=d/2$, which is exactly $\gamma^*=D/4$; L156's reach optimum solves $\frac{\gamma^\dagger}{d-\gamma^\dagger}=\sqrt{1+4t}=s$, so $\gamma^\dagger=\frac{ds}{1+s}$ and $\frac{\gamma^\dagger}{d/2}-1=\frac{s-1}{s+1}=\eta^*$. Since $\gamma(d-\gamma)=\frac{d^2}{4}\big(1-u^2\big)$ at $\gamma=\frac d2(1+u)$,

    $$\frac{J(\gamma^\dagger)}{J(\gamma^*)}=\frac1{1-\eta^{*2}}\qquad\text{exactly},$$

    which is $1+O(t^2)$ because $\eta^*=O(t)$, **claim 8 confirmed**, and by a route that also confirms claim 1 from the outside, since L156's $\sqrt{1+4t}$ and L157's $\eta^*$ are the same surd reached from two different optimisations. The exact factor is worth having: it is $1.010$ at $t=\tfrac18$ but $1.164$ at the entry's own $t=0.962$ at $n=12$, so "$J^*$ is right to $O(t^2)$" is a $16\%$ statement at the dimension in hand rather than a $1\%$ one.
4. **The identity of claim 6 is empty.** $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$ is $\eta^*=t(1-\eta^*)^2$ multiplied by $\gamma$. Its content is that $\eta^*\gamma$ is the reach in units of $g_n$, which follows from $\rho=\gamma g_n/\lVert H\rVert_{op}$, **an import stated in [Lemma L158](../findings/second-order.md)'s block and in neither form of L157**. Calling it "the exact identity at the crossing" overstates what it adds. Claim 7, "$\gamma$ does not cancel", is nonetheless **right**: $J\gamma=C(\alpha,\gamma)$ still carries $\gamma$, so the earlier "in which $\gamma$ cancels for small $t$" quoted at [ROUND_L156](ROUND_L156.md) is the sentence that is wrong, not this one.

## 8. The two forms

*Locate.* Form A, [second-order.md:1245–1271](../findings/second-order.md); Form B, [results.md:359–362](../results.md), which the round's header calls canonical.

| | Form A | Form B |
|---|---|---|
| $\eta^*$ formula | in the heading and the blockquote | in the prose |
| "the unique root in $(0,1)$" | present | **absent** |
| "the other root being its reciprocal and spurious" | present | **absent** |
| "the minimum of the two is maximised there" | present | **absent** |
| the branches $\eta$ and $t(1-\eta)^2$ named | present | **absent**, only "whose largest solution is the crossing root" |
| cost of freezing $\eta=\tfrac12$ | "$2.9$–$3.4$", with the binding direction recorded as **disputed** between [r713](../reviews/REVIEW_r713.md) and [r714](../reviews/REVIEW_r714.md), and $0.829$ **refuted** | "about $2.9$ at the binding direction", flat |
| $\lambda$, the $0.808$, the percentages, the $58\times$, the $\Theta(n^{1/2})$ ratio | present | absent |

**Two of these are findings, not abridgements.**

- **Form B drops the only clause that makes its own sentence true.** "whose largest solution is the crossing root" is false on $[0,\infty)$ (§3) and true only once $\eta<1$ is imposed; Form A at least signals that with "the unique root in $(0,1)$" and "spurious". The canonical form is the one downstream readers meet, and it is the one with the domain removed.
- **Form B states as settled what Form A records as disputed.** "cost about $2.9$ at the binding direction" presents a single number at a location Form A says is contested between the $\lVert H\rVert_{op}$ kink and the endpoint, with a third value ($0.829$) refuted. A canonical entry that hides a live dispute in its own findings source is the more consequential of the two differences.

## 9. Candidates raised and withdrawn

| Candidate | Why it was withdrawn |
|---|---|
| "the minimum is maximised there" is false | false only without the domain $\eta<1$, which $\eta=r/\rho$ and the Cauchy estimate on the disc of radius $\rho$ supply; recorded instead as an unstated restriction and an absent argument |
| "largest solution" is false | same restriction; the solution set on $[0,\rho)$ does have a largest element |
| $t(w=0)>0$ contradicts "at $w=0$ the branch is absent" | the chain bounds $\lVert A''\rVert$ from above, so a non-vanishing bound at a vanishing defect is loose rather than wrong; L149's "$\Omega$, not $\Theta$" paragraph says exactly this |
| "$\gamma$ does not cancel" is false because $J\gamma=C$ | $C(\alpha,\gamma)$ retains $\gamma$, so the claim is right; only the display is non-reduced |
| the entry's $t=0.206$ at the binding direction is unreproducible from its own constants ($\tfrac{11}{84}\lambda\sqrt{c_p+1}=0.2348$ at $\lambda=1.53$, $0.1648$ at $w=0.553$) | the entry does not say which $(w,\gamma,J)$ it evaluates at, so the charitable reading survives; the $\lambda$-ratio $0.206/0.135=1.526$ is used above only as evidence of *which* $\lambda$ was applied, which needs no reproduction |

## 10. What would break the statement, and what I did to look for it

**The object that would falsify it is an admissible $t$ at which $\eta^*$ fails to exist, fails to lie in $(0,1)$, or fails to maximise the min.** There is none: §2 gives $\eta^*=\frac{s-1}{s+1}$ in $(0,1)$ for every $t\in(0,\infty)$, with no case analysis and no hypothesis beyond $t>0$, and §3 gives the max-min on $[0,1]$ for the same range. I looked at both ends ($t\to0$, where the displayed quotient is $0/0$ and the root is not; $t\to\infty$, where $\eta^*\uparrow1$), at $t\ge2$ (which would put $\eta^*$ above the frozen $\tfrac12$ and reverse the entry's "cost" sentence, unreachable, since $\sup_wt(12)=0.962$ and $\lambda(n)$ decreases in $n$), and at the domain $[0,\infty)$, where the clause genuinely fails and where I found the concrete witness $t=\tfrac18$, $\eta=10$, $\min=10>\eta^*$, which the unstated restriction $\eta<1$ removes.

**The object that falsifies the entry's generality is $W_{\mathbb{CP}^2}$**, $\dim\ker W=3$: there $\rho$, $M$, $g_n$ and $\gamma$ have no definition, so $t$ has no value and $\eta^*$ no argument, and the statement (which carries no hypotheses at all), says nothing at a point it appears to cover. I looked for it by taking the hypothesis boxes of [Lemma L147](../findings/second-order.md), [Lemma L148](../findings/second-order.md) and [Lemma L149](../findings/second-order.md) at source and checking each against the ingredients of L157's $t$.

**The parameter that falsifies the entry's arithmetic is $\lambda$.** I looked for it by inverting the entry's own printed numbers: $0.808$ inverts to $t=\tfrac18$ exactly ($40-16\sqrt6$), $\tfrac18$ inverts to $\lambda=1$ through $2J^*\gamma^*\to8$, and the entry sets $\lambda=1.53$ and then $6.275$.

## Verdict

**`GAP`.**

The displayed **Lemma L157 is correct in every clause**, the crossing root, the reciprocity, the uniqueness in $(0,1)$, the maximality of the min, and the crossing identity all survive exact checking, and the root has the closed form $\eta^*=\frac{\sqrt{4t+1}-1}{\sqrt{4t+1}+1}$ which reproduces [Lemma L156](../results.md)'s independently derived $\gamma^\dagger/(d-\gamma^\dagger)=\sqrt{1+4t}$. **A lemma that has twice been used to convict its neighbours is not itself convicted here.**

What is owed:

1. **Every hypothesis.** Nine are used and none is stated; $\ker W^*=0$ has a named witness against it at $W_{\mathbb{CP}^2}$ and $n\ge12$ is forced by $\lambda$ alone.
2. **The argument for three of the four clauses** (uniqueness, spuriousness, and the max-min), together with the domain $\eta\in[0,1)$ that all three need and that the canonical form drops.
3. **The withdrawal of $0.808$, of "at every dimension", and of the $13$–$22\%$ and $20\%$ figures**, all of which are $\lambda=1$ arithmetic inside an entry whose own $\lambda$ is $1.531572$ asymptotically and $6.274757$ at $n=12$. The replacement values, exact and hand-derived: $(1-\eta^*)^2=4/(1+\sqrt{4t+1})^2$, which at $n=12$ runs over $[0.390163,0.535729]$ as $w$ runs over $[0,1]$, and whose $n\to\infty$ value at $w=1$ is $0.737537$. The qualitative claim the paragraph exists to make (that the factor neither drops nor vanishes with $n$), **stands**.
4. **One line saying $\sigma=\eta$**, since [ROUND_L156](ROUND_L156.md) decided C6 on that identification.
