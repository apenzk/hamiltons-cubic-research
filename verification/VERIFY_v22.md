# VERIFY v22, L147: the radius bound $r_n\gtrsim n^{-1-\beta}$, the $\beta\in[0,\tfrac12]$ range, the $\Theta(n^{-1})$ ceiling, and the branch-1 form $f(u)=(c_p+u^2)/(S+au)$

**Cold brief, worked from the definitions in [findings/second-order.md](../findings/second-order.md) and [findings/conventions.md](../findings/conventions.md).** No script was run and no numerical work was done: every value below is an exact hand evaluation of a closed form, and every decimal is given with the closed form it came from. Log: [agent_logs/verify-L147-v22.log](../agent_logs/verify-L147-v22.log).

## Claim table

| # | Claim as written | Verdict |
|---|---|---|
| C1 | $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\uparrow\sqrt2$ forces $\beta\ge0$ | **PROVEN** |
| C2 | [Lemma L143](../findings/bounds.md) forces $\beta\le\tfrac12$ | **PROVEN**, and **UNUSED** in the displayed inequality |
| C3 | the route is capped at $\Theta(n^{-1})$, via $c_p/S\le c_p/\theta_0\le3/(n-2)$ | **PROVEN AS $O(n^{-1})$**; the $\Theta$ is **OVERSTATED**, and the cap is conditional on a chain L147 never states |
| C4 | $r_n\gtrsim n^{-1-\beta}$ | **HYPOTHESIS-DEBT**, no derivation on file survives; L147's own §4 refutes the only step that produced it |
| C5 | $f'(0)=-ac_p/S^2<0$; $u^*=(\sqrt{S^2+a^2c_p}-S)/a$; $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ | **PROVEN**, every line of the algebra is exact |
| C6 | "$u=0$ is **never** its minimum … **at every $\beta$ and every $a$**" | **PROVEN as algebra**, and it is the claim that **breaks C4** whenever $a\gtrsim n^{1/2+\beta}$ |
| C7 | $M=O(\rho)$, hence $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})$ | **GAP**, a real-symmetric Lipschitz fact used under a supremum over a **complex** circle; and by [Lemma L148](../findings/second-order.md) the quantity priced is identically $0$ |
| C8 | "$\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ and $c(H)\gtrsim c_p+w^2$ … **uniformly in $w\in[0,1]$**" | **PROVEN for $m\ge6$ ONLY**; **FALSE at $m=4$**, and no dimension hypothesis is stated |
| C9 | $\ker W^*=0$ | **UNSTATED**, and required by C7 and by branches 2 and 3 |
| C10 | (pre-registered) $u$ and $w$ are the same variable | **REFUTED**, $u$ is the defect's linear rate, $w$ the weight off the joint eigenspace; $u\le Cw$ with $C$ recorded unknown |

**One line the round can act on.** The ceiling and the range are sound; the headline lower bound is not carried by any argument on file, because L147's own two-branch paragraph refutes exactly the step, [Lemma L149](../findings/second-order.md)'s "the first is minimised at $w=0$", from which the value $c_p/S=\Theta(n^{-1-\beta})$ was read.

**Verdict: `GAP`**, with C4 standing as `HYPOTHESIS-DEBT`; what is owed is written out in §7.

## 0. Conventions, fixed once

All from the record, at [findings/second-order.md:887](../findings/second-order.md) and [findings/conventions.md](../findings/conventions.md).

- $n=2m$, $W^*$ the unit-norm Weyl tensor of $S^m\times S^m$, a critical point with $\theta=P(W^*)=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- $P(W)=\langle W,Q(W)\rangle$; $S:=\sup_{\lVert W\rVert=1}\lvert P(W)\rvert$; the lemma's $\beta$ is defined by $S=\Theta(n^\beta)$.
- $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ is the defect, $W_-$ the negative spectral part on $\Lambda^2$; $A(z):=\mathrm{Alt}(W(z)_-)$ along $W(z)=W^*+zH$, $\lVert H\rVert_F=1$.
- $g_n=\lvert\lambda_-\rvert=\sqrt{2(n-2)}\big/\big(n\sqrt{n-1}\big)=\Theta(n^{-1})$ is the spectral gap; $\rho=\rho(H)=\Theta(\min(1,g_n/\lVert H\rVert_{op}))$ the analyticity radius; $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$.
- $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$, $\lambda_m=(m-2)/(2(m-1))$; $c(H)$ the margin at direction $H$.
- $H=H_s+H_r$ with $H_s$ in the **joint** two-copy $\lambda_m$-eigenspace and $w:=\lVert H_r\rVert$.
- $u$: see §2, it is **not** $w$.

I checked $g_n$ is written two ways in the file and that they agree: $\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\tfrac{\sqrt2}{n}\cdot\tfrac{\sqrt{n-2}}{\sqrt{n-1}}=\tfrac{\sqrt{2(n-2)}}{n\sqrt{n-1}}$. They are the same quantity.

## 1. The hypothesis inventory

### 1a. Hypotheses the statement carries

| hypothesis | stated? | used? |
|---|---|---|
| $\sup\lvert P\rvert=\Theta(n^\beta)$ for some $\beta$ | yes | yes, but only the **upper** half $S=O(n^\beta)$ is needed for the displayed inequality; the lower half is needed only for the ceiling |
| $\beta\ge0$ | derived in the body | yes, to make the ceiling non-vacuous |
| $\beta\le\tfrac12$ | derived in the body | **no**, see §5 |
| a base point for $r_n$ | **NO** | yes, everywhere: $c_p$, $g_n$, "the margin summand" and $P(W^*)$ are all quantities at $W^*=S^m\times S^m$ |
| a dimension range | **NO** | yes: $m\ge6$ is needed by C8, $m\ge5$ by [Lemma L146](../findings/second-order.md)'s order conclusion, $n\ge12$ by the ambient setting at line 887 |
| $\ker W^*=0$ | **NO** | yes: without it $W\mapsto W_-$ is not analytic at $W^*$, and C7's Cauchy estimate and branches 2 and 3 have no domain |
| $a>0$, $c_p>0$, $S>0$, and $u^*$ inside the admissible $u$-range | **NO** | yes, by C5/C6 |
| $u\le Cw$ with $C=O(1)$ | **NO** | yes, it is what makes $f(u)$ a valid lower bound for the two-variable object (§3) |

### 1b. Hypotheses of the imported results, checked against the object

| import | its hypotheses | met by L147's object? |
|---|---|---|
| [L143](../findings/bounds.md), $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | $\lVert W\rVert=1$; holds at every $W\in\mathcal W_n$ ([bounds.md:480](../findings/bounds.md)) | **yes**, L147 applies it to $\sup_{\lVert W\rVert=1}\lvert P\rvert$ |
| $P(W^*)=\theta_0(n)$ | $n$ even, $W^*$ the balanced product ([conventions.md:18](../findings/conventions.md): "at even $n$ only"; at odd $n$ the diagonal maximum is $\Theta_n<\theta_0$) | **yes at $n=2m$**, and L147 says $n^\beta$ without saying $n$ even; the odd-$n$ value is $\Theta_n$, still $\Theta(1)$, so C1 survives |
| [L146](../findings/second-order.md) | $m\ge3$ for the formulae, $m\ge5$ for the margin to sit on that summand, a **single** $h$ | **not checked in L147**; L147 applies it on the joint two-copy eigenspace, which L146 itself flags as a place its equality clause fails |
| [L145](../findings/second-order.md)'s Cauchy machinery | $\ker W^*=0$, analyticity on the ball of radius $g_n$, $\rho<g_n/2$ **strictly** | **not stated** |
| [L149](../findings/second-order.md)'s sweep, cited as "it returns these values" | $m\ge6$; $H\perp W^*$; $H\perp T_{W^*}\mathcal O$; $\ker W^*=0$; and an **open** `HYPOTHESIS-DEBT` on the $\tfrac29$ penalty coefficient | **none stated in L147**, and L149's repair is recorded in its own closing line as *unaudited* |
| [L27](../findings/nondegeneracy.md)'s ten summands |, | invoked by name only |

**The pattern in this inventory is the one the round was told to expect.** L147 states exactly one hypothesis and uses at least seven.

## 2. The pre-registered question, settled, what $u$ is, and where $f$ is minimised

### 2a. $u$ is not $w$

The record defines $u$ once, at [findings/second-order.md:1227](../findings/second-order.md): *"$-\kappa_n\delta^2$ contributes $\lvert\kappa_n\rvert u^2t^2$ against the margin. Since $A'(0)$ is linear and vanishes on the margin subspace by [Lemma L148](../findings/second-order.md), $u\le w$."*

Read against §0, this fixes $u$ as **the defect's first-order rate along $H$**, $\delta(W(t))=u\,t+O(t^2)$, i.e. $u=\lVert A'(0)[H]\rVert$, while $w=\lVert H_r\rVert$ is the weight of $H$ outside the joint $\lambda_m$-eigenspace. They are different functions of $H$:

- $u$ is a norm of a **linear image** of $H$; $w$ is a norm of an **orthogonal component** of $H$.
- The only relation on file is $u\le Cw$, and [findings/second-order.md:1421](../findings/second-order.md) records the constant explicitly: *"**The $u\lesssim w$ constant** linking the two decompositions of $H$ is recorded as unknown."* [Line 1360](../findings/second-order.md) says the same.
- The relation is one-sided. $u=0$ is forced by $w=0$ (that is [Lemma L148](../findings/second-order.md)), but $u$ may be far below $w$ at a direction with off-eigenspace weight and no defect response.

**So the answer to the pre-registered question's second half is: no, $u\ne w$**, and L147 never says what $u$ is. The definition it needs lives twenty lines below it, in a lemma written after it.

### 2b. Where $f$ is minimised, the algebra is exact and correct

With $f(u)=(c_p+u^2)/(S+au)$ and $a,c_p,S>0$:

$$f'(u)=\frac{2u(S+au)-a(c_p+u^2)}{(S+au)^2}=\frac{au^2+2Su-ac_p}{(S+au)^2},\qquad f'(0)=-\frac{ac_p}{S^2}<0 .$$

The positive root of $au^2+2Su-ac_p=0$ is $u^*=\big(-2S+\sqrt{4S^2+4a^2c_p}\big)/(2a)=(\sqrt{S^2+a^2c_p}-S)/a$, matching the entry. At stationarity $ac_p=au^{*2}+2Su^*$, so $c_p+u^{*2}=2u^{*2}+2Su^*/a=(2u^*/a)(S+au^*)$ and

$$f(u^*)=\frac{2u^*}{a}=\frac{2c_p}{S+\sqrt{S^2+a^2c_p}} ,$$

the last step by rationalising $\sqrt{S^2+a^2c_p}-S=a^2c_p/(\sqrt{S^2+a^2c_p}+S)$. Since $S+\sqrt{S^2+a^2c_p}\asymp\max(S,a\sqrt{c_p})$, we get $f(u^*)\asymp c_p/\max(S,a\sqrt{c_p})=\min(c_p/S,\sqrt{c_p}/a)$. **Every claim of the paragraph checks out.**

**The three hypotheses it needs and does not state**: $a>0$ (at $a=0$ the function is increasing and $u=0$ *is* the minimum, so the word "never" is false at $a=0$); $c_p>0$; and $u^*$ inside whatever range $u$ actually runs over. On the last, at $n=12$, $\beta=0$, $a=n$ the value is $u^*=0.5146$ (§4), comfortably inside $[0,1]$, so the interior claim is safe at the parameters the record reaches, but it is safe by accident rather than by hypothesis.

## 3. The conflation is safe in direction, and that is the charitable reading

The chain's real object is two-variable: the numerator is the margin $c(H)\ge c_p+\rho^{\mathrm{eff}}w^2$, in $w$; the denominator is $S$ plus a defect penalty proportional to $u$. Writing both slots in one letter $u$ is a conflation, and the round should record that it runs the **safe** way:

$$\frac{c_p+w^2}{S+au}\;\ge\;\frac{c_p+u^2}{S+au}\;=\;f(u)\qquad\text{since }u\le w .$$

So $\inf_H(\text{true})\ge\inf_uf(u)=f(u^*)$, and using $f$ as a lower bound is legitimate. This is the most charitable reading the words support, and I adopt it. What it costs is that $f(u^*)$ may be a strict underestimate, which is exactly the mechanism of §4.

## 4. The finding: §4 of the entry breaks the headline unless $a\lesssim n^{1/2+\beta}$, and $a$ is never defined

**Located.** [findings/second-order.md:1173](../findings/second-order.md): *"$f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=-ac_p/S^2<0$, so $u=0$ is **never** its minimum; the minimum is interior at $u^*=\dots$ with $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$, **at every $\beta$ and every $a$**."*

**What it needs and lacks.** The headline $r_n\gtrsim n^{-1-\beta}$ needs the branch-1 infimum to be $\Omega(c_p/S)$. By C5 that infimum is $\Theta(\min(c_p/S,\sqrt{c_p}/a))$, so the headline holds **iff** $\sqrt{c_p}/a\gtrsim c_p/S$, i.e. iff

$$a\;\lesssim\;\frac{S}{\sqrt{c_p}}\;=\;\Theta\!\big(n^{\beta}\cdot n^{1/2}\big)\;=\;\Theta(n^{1/2+\beta}).$$

**L147 defines $a$ nowhere, bounds it nowhere, and explicitly quantifies "at every $a$".** The symbol occurs in this one sentence and in no other line of the entry.

**Exhibited concretely, in closed form, at a named parameter.** Take $n=12$, $\beta=0$ with $S=\theta_0(12)$, and $a=n=12$, the value the record's own $\lVert A''\rVert=O(n^{1/2}+nw)$ reaches, and the $\lVert A''\rVert=\Theta(n)$ that L147's own third paragraph discusses. Exactly:

$$\theta_0(12)=\frac{\sqrt{220}}{12}=\frac{\sqrt{55}}{6},\qquad c_p=\frac{3\theta_0}{10}=\frac{\sqrt{55}}{20},\qquad S^2=\frac{55}{36},\qquad a^2c_p=144\cdot\frac{\sqrt{55}}{20}=\frac{36\sqrt{55}}{5}.$$

With $\sqrt{55}=7.4161985$: $a^2c_p=53.3966290$, $S^2=1.5277778$, $\sqrt{S^2+a^2c_p}=\sqrt{54.9244068}=7.4110995$, $S=1.2360331$, and $2c_p=\sqrt{55}/10=0.7416199$. Hence

$$f(u^*)=\frac{0.7416199}{8.6471326}=0.0857636,\qquad\text{against}\qquad f(0)=\frac{c_p}{S}=\frac{3}{n-2}=\frac{3}{10}=0.3\ \text{exactly}.$$

A factor $3.4980$ below the value the headline needs, and $u^*=(7.4110995-1.2360331)/12=0.5145889$, in range. Asymptotically the loss is an **exponent**, not a constant: at $a=\Theta(n)$, $\sqrt{c_p}/a=\Theta(n^{-1/2})/\Theta(n)=\Theta(n^{-3/2})$, so at $\beta=0$ the entry's own branch-1 formula returns $\Theta(n^{-3/2})$ where the statement claims $n^{-1}$.

**Argued the opposite, the charitable reading, which I state because it is real.** $a$ is not free in the chain: matching $f$'s large-$u$ regime $c/(au)\approx\sqrt c/a$ against [L149](../findings/second-order.md)'s branch 2 $\sqrt{c_p+w^2}/(a_0n^{1/2}+nw)$ identifies $a$ with $\lVert A''\rVert$ up to [L157](../findings/second-order.md)'s $\lambda$, i.e. $a=a(w)=\Theta(n^{1/2}+nw)$. Under that coupling the exhibit dissolves, reaching $a=\Theta(n)$ requires $w=\Theta(1)$, hence a numerator $\Theta(1)$ rather than $c_p$, and the coupled minimum stays $\Theta(n^{-1})$ at $\beta=0$, which is L149's uniformity result. **But that coupling is precisely what "at every $a$" denies**, and L147 states no coupling, no definition of $a$, and no bound on it. The entry therefore proves a statement about a decoupled one-variable $f$ and reads it back into a chain where $a$ is a function of the same variable.

**Consequence for the headline.** The single sentence in L147 that asserts the lower bound is *"It returns these values and the $\Theta(n^{-1})$ ceiling"*, [line 1171](../findings/second-order.md), pointing at [Lemma L149](../findings/second-order.md), whose own statement reads *"the first is minimised at $w=0$"*. That is the step L147's §4 refutes. So the entry cites for its value a lemma whose value-producing step it strikes out two paragraphs later, and supplies no replacement. Downstream, [line 1282](../findings/second-order.md) reads the refutation back at L149 in exactly these terms: *"its infimum is **strictly below** $\kappa/(nS)$ and does not sit at $u=0$."*

## 5. Quantifier order and scope

- **$\sup\lvert P\rvert$** is over $\lVert W\rVert=1$ in $\mathcal W_n$ ([bounds.md:25](../findings/bounds.md)); L147 uses it consistently. **No finding.**
- **$r_n$ is an infimum over directions**, [L145](../findings/second-order.md) is explicit: *"$n^{-3/2}$ is $\inf_Hc(H)/C(H)$, which is what a tube radius is."* L147 never says so, and its §4 minimises a one-variable $f$ instead. This is the distribution the brief names: an infimum over a **two-variable** admissible region $\{(w(H),u(H)):u\le Cw\}$ replaced by a minimum over one variable with the other slot's parameter $a$ frozen and then universally quantified. The direction of the substitution is safe (§3); the frozen $a$ is not (§4).
- **$M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is per-direction**, since $\rho=\rho(H)$. §7's *"$\lVert A''\rVert=O(1/\rho)=O(n^{1/2})$ on the margin summand"* is a per-summand bound; the entry's own next paragraph names this as the quantifier error and widens to all ten of [L27](../findings/nondegeneracy.md)'s summands. **Self-corrected, no separate finding.**
- **The hypothesis is stronger than the displayed conclusion needs.** $r_n\gtrsim n^{-1-\beta}$ needs only $S=O(n^\beta)$; the $\Theta$ is spent on the ceiling.
- **$\beta\le\tfrac12$ is stated and never used in the inequality.** The chain gives $\min(\Theta(n^{-1-\beta}),\Omega(n^{-1}),\Omega(n^{-1}))=\Theta(n^{-1-\beta})$ for **every** $\beta\ge0$; nothing in the derivation of the display consumes $\beta\le\tfrac12$. It is used only for the bracket $r_n\in[n^{-3/2},n^{-1}]$ in the prose. An unused hypothesis, as the brief asks about.

## 6. The edges of the ranges, and the two traps by name

### 6a. $\beta\in[0,\tfrac12]$, neither endpoint is known to be attained

- **$\beta\ge0$ is forced, and correctly.** $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n=\sqrt2\sqrt{1-3/n+2/n^2}$, and $-3/n+2/n^2$ has derivative $(3n-4)/n^3>0$, so $\theta_0\uparrow\sqrt2$ strictly from below. With $S\ge\theta_0(12)=\sqrt{55}/6=1.2360331>0$, $S=\Theta(n^\beta)$ gives $\beta\ge0$. **PROVEN.** (At odd $n$ the value at the balanced split is $\Theta_n<\theta_0$ per [conventions.md:18](../findings/conventions.md), still a positive constant, so C1 survives the parity L147 leaves unsaid.)
- **$\beta\le\tfrac12$ is an upper bracket only.** L143 is an **upper** bound $S\le1+\sqrt{n-2}$, so it bounds $\beta$ above and says nothing about attainment. The statement calls $\beta=\tfrac12$ "**confirmed**"; what is confirmed is the conditional, not that $\sup\lvert P\rvert$ grows like $n^{1/2}$. Under [Conjecture A](../README.md) the truth is $\beta=0$.
- **$\beta$ may not exist at all, and the entry's own last paragraph says so.** [Line 1175](../findings/second-order.md): *"$\sup\lvert P\rvert$ is **bracketed rather than known**, so $\beta$ is not an exponent."* That contradicts the statement's hypothesis $\sup\lvert P\rvert=\Theta(n^\beta)$ two displays above it. Charitably the lemma is a conditional over a hypothetical $\beta$; but then the parenthetical verdicts "confirmed" and "plausible" are verdicts about hypotheses, not about $r_n$.

### 6b. The smallest admissible dimension, L147 states none, and C8 is false at $m=4$

L147's third paragraph states the two sweep inputs *"uniformly in $w\in[0,1]$"* with no dimension restriction. [L149](../findings/second-order.md)'s repaired form of the margin input is $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$, and under $n=2m$ the coefficient is exactly

$$3\theta_0\frac{m-4}{2(m-1)}=\frac{3(n-8)}{n}\sqrt{\frac{n-1}{2(n-2)}} .$$

Hand-evaluated at the four dimensions that matter:

| $n$ | $m$ | coefficient, closed form | value |
|---|---|---|---|
| $8$ | $4$ | $0$ | $\mathbf{0}$ **exactly** |
| $12$ | $6$ | $\sqrt{55}/10$ | $0.7416199$ |
| $14$ | $7$ | $\tfrac97\sqrt{13/24}$ | $0.9462602$ |
| $16$ | $8$ | $\tfrac32\sqrt{15/28}$ | $1.0978877$ |

**Exhibited concretely.** At $n=8$ ($m=4$) the coefficient is identically zero: take $H$ a unit vector in the smallest surviving off-summand, so $w=1$ and $c(H)=c_p=\Theta(1/n)$, while the stated input demands $c(H)\gtrsim c_p+1$. **The clause fails at every order at $m=4$.** The record corroborates the arithmetic independently, [L149](../findings/second-order.md) records that the smallest off-summand margin $3\theta_0\tfrac{m-3}{2(m-1)}$ "*ties with $c_p$ at $m=4$*", and at $m=4$ that reads $3\theta_0/6=\theta_0/2$ against $c_p=3\theta_0/6=\theta_0/2$. Confirmed.

**And the range fails one dimension higher than the entry's neighbours assume.** At $n=10$, $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=\sqrt{144}/10=6/5$ **exactly**, which is below $\sqrt{3/2}=1.2247449$; so $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})<0$ and $\rho^{\mathrm{eff}}$ has no definition. At $n=12$, $\lvert\kappa_{12}\rvert=9(1.2360331-1.2247449)=9(0.0112882)=0.1015938$, positive, matching the record's $0.10159$.

**Argued the opposite.** The ambient setting at [line 887](../findings/second-order.md) is $n=2m\ge12$, and every neighbouring lemma states its own range ($m\ge3$, $m\ge5$, $m\ge6$). A reader of the whole file supplies $n\ge12$. **The finding stands anyway**, because the brief asks whether the *statement* carries what its steps use, and because L147 is the entry that is cited elsewhere with no dimension attached.

### 6c. $\ker W\ne0$, the recurring obstruction, and it is unstated

[Lemma L149](../findings/second-order.md) states it as a hypothesis in terms: *"and **$\ker W^*=0$**, without which $W\mapsto W_-$ is not analytic at $W^*$ and branches 2 and 3 have no domain."* **L147 states it nowhere**, and it needs it twice: its own Cauchy estimate in §7 below, and every branch it imports.

**Exhibited at a named object from the record's own families.** The statement of L147 carries **no base point**, it says $r_n\gtrsim n^{-1-\beta}$ with no "at $W^*$". Read at the base points the record actually catalogues, [nondegeneracy.md:178](../findings/nondegeneracy.md) records **padded** critical points, where $W$ has a large exact kernel on $\Lambda^2$ and *"the quantity the argument needs is the spectral gap of $W$ on $(\ker W)^\perp$, not on all of $\Lambda^2$"*; padded $S^3\times S^3$ carried into $n=12$ is one, and padded $W_{\mathbb{CP}^2}$ another ([nondegeneracy.md:307](../findings/nondegeneracy.md): *"a padded operator has a large exact kernel"*). At such a $W$, $g_n=0$, the spectral splitting $W\mapsto W_-$ is not differentiable, $M$ and $\rho$ are undefined, and the whole chain is empty. Sphere products have trivial kernel, which is why a check run only at $W^*$ never reaches this.

**Argued the opposite.** L147 plainly *means* $W^*=S^m\times S^m$, its own body invokes $P(W^*)$, $c_p$ and "the margin summand". The charitable reading localises it, and at $W^*$ the hypothesis holds with the explicit gap $g_n>0$. **The finding is the missing localisation, not a counterexample to the intended claim**, and I report it at that strength.

## 7. $M=O(\rho)$ and $\lVert A''\rVert=O(n^{1/2})$, a real-variable fact under a complex supremum

**Located.** [findings/second-order.md:1167–1169](../findings/second-order.md): *"$M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum **over the disc**, so it grows with it: $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$, giving $M=O(\rho)$ and hence $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})$."*

**What the step is, and what is right about it.** On **real symmetric** matrices, $x\mapsto x_-$ is the Frobenius projection onto the negative-semidefinite cone, hence nonexpansive by Moreau; with $A(0)=\mathrm{Alt}(W^*_-)=0$ ([L145](../findings/second-order.md)) and $\lVert\mathrm{Alt}\rVert\le1$ this gives $\lVert A(t)\rVert\le\lVert W(t)_--W^*_-\rVert_F\le\lVert W(t)-W^*\rVert_F=\lvert t\rvert$. The arithmetic that follows is exact: $M/\rho^2=O(1/\rho)$; at $\rho=\Theta(n^{-1/2})$ that is $O(n^{1/2})$, and at $\rho=\Theta(g_n)=\Theta(n^{-1})$ it returns $O(n)$, as the entry says it must.

**The gap.** The estimate $\lVert A''(0)\rVert\le2M/\rho^2$ is a **Cauchy** estimate: it requires $A$ holomorphic on $\lvert z\rvert<\rho$ and $M$ the supremum of $\lVert A\rVert$ over the **complex** circle $\lvert z\rvert=\rho$. The entry writes $\sup_{\lvert z\rvert=\rho}$, so it intends the complex circle. But the Lipschitz argument it offers is the cone-projection fact, which is a statement about the **real** symmetric cone; the holomorphic extension of $z\mapsto W(z)_-$ is defined by a resolvent contour integral and has no cone-projection characterisation, so nonexpansiveness does not transfer. On the real segment $z=\pm\rho$ the bound is sound, and on the real segment there is no Cauchy estimate to make. **L147 supplies no argument that the complexified $A$ obeys $\lVert A(z)\rVert\le\lvert z\rvert$**, and nothing on file does either, [L145](../findings/second-order.md)'s own route to $M$ is a resolvent/Frobenius argument, $\lVert ABC\rVert_2\le\lVert A\rVert_\infty\lVert B\rVert_2\lVert C\rVert_\infty$, giving $M=O(g_n)$ rather than $M=O(\rho)$ for every $\rho$.

**Argued the opposite.** $A$ is holomorphic with $A(0)=0$, so $A(z)/z$ is holomorphic and $M(\rho)/\rho$ is non-decreasing by the maximum principle; a bound $M(\rho_0)=O(\rho_0)$ at any one admissible radius therefore transfers down to every $\rho\le\rho_0$. Since $M=O(g_n)$ at $\rho=\Theta(g_n)$ is on file, $M=O(\rho)$ is available on $\rho\lesssim g_n$, which is where the record's constants are actually read. So the **conclusion** is likely repairable at the radii used; the **argument as written** is not the one that gets there, and it is stated for all $\rho$.

**And the quantity priced is zero.** [Lemma L148](../findings/second-order.md), found by r451 while attacking L147 and sitting eleven lines below it, proves $\mathrm{Alt}(W(t)_-)=0$ identically for $H$ in $S^2_0(\mathbb R^m)$ at $W^*$. So $A\equiv0$ on the margin summand, $\lVert A''\rVert=0$ there, and this paragraph's headline bound $O(n^{1/2})$ "**on the margin summand**" prices a quantity that is not present. L146's own box says exactly this about itself; L147 repeats the step without inheriting the correction.

## 8. The ceiling, proven as $O(n^{-1})$, and the $\Theta$ is the entry's own charge against itself

**What is right.** $S\ge P(W^*)=\theta_0$, so branch 1 at $w=u=0$ is $c_p/S\le c_p/\theta_0=3/(n-2)$, an **equality** for $c_p/\theta_0$, since $c_p=3\theta_0/(n-2)$, and the "$\le$" comes from $S\ge\theta_0$. At $w=0$ the other branches do not bind: the defect vanishes ([L148](../findings/second-order.md)) so branch 2 is unbounded, and $\lVert H\rVert_{op}=O(n^{-1/2})$ gives $\rho/2=\Theta(g_n/n^{-1/2})=\Theta(n^{-1/2})\gg n^{-1}$. So $\min(\text{branches})\le3/(n-2)=\Theta(n^{-1})$, and §4's correction only lowers it further. **The ceiling holds as an $O(n^{-1})$ cap on what the route can output.** The other three reasons the entry gives are each sound: the corrected quartic branch, the validity cap $\rho/2=\Theta(g_n)$ on directions with $\lVert H\rVert_{op}=\Theta(1)$, and $\beta\ge0$ emptying the region.

**Two findings against it.**

1. **"$\Theta(n^{-1})$" overstates a cap.** A ceiling is an $O$. Writing $\Theta$ additionally asserts the route *reaches* $n^{-1}$, which happens only at $\beta=0$ and only if the lower bound at $\beta=0$ holds, which the statement's own parenthetical calls merely "*plausible with an unpinned constant*", and which §4 leaves unproved. [L149](../findings/second-order.md) refuses the $\Theta$ explicitly for the same reason: *"$\Omega$, not $\Theta$ … At $w=0$ the defect vanishes identically, so the branch is **unbounded** there."* The entry's own closing paragraph preaches this discipline for the first display and does not apply it to the ceiling in the same sentence.
2. **The cap is conditional on a chain L147 never writes down.** Every branch, and the fact that the radius is a **min** over them, is imported silently from [L149](../findings/second-order.md).

## 9. What is proven against what is used downstream

The brief asks whether the written proof gives both the radius $r_n\gtrsim n^{-1-\beta}$ and the $\Theta(n^{-1})$ ceiling.

| cited downstream as | does L147's text give it? |
|---|---|
| the $\Theta(n^{-1})$ ceiling | **Yes**, as $O(n^{-1})$, in one correct line, conditional on an unstated chain |
| $r_n\gtrsim n^{-1-\beta}$ | **No.** The entry contains no derivation. The only sentence asserting it is *"It returns these values"*, pointing at [L149](../findings/second-order.md), whose branch-1 step L147's own §4 refutes and does not replace |
| the branch-1 form $f(u)=(c_p+u^2)/(S+au)$ | **Yes**, and the algebra is exact, but $a$ and $u$ are undefined, and the "at every $a$" makes it a claim the headline cannot survive (§4) |

**`HYPOTHESIS-DEBT` on C4, stated exactly.** What would have to be proved is:

$$\inf_{H}\ \frac{c(H)}{S+a(H)\,u(H)}\ \gtrsim\ \frac{c_p}{S}\qquad\text{over }H\in T_{W^*}\mathcal S\cap T_{W^*}\mathcal O^\perp,$$

equivalently: that at the binding direction $a\,C\lesssim n^{1/2+\beta}$, where $C$ is the constant in $u\le Cw$ and $a$ is the defect-penalty coefficient. Neither is on file, $C$ is recorded as **unknown** at [findings/second-order.md:1421](../findings/second-order.md), and $a$ has no definition in L147 at all.

## 10. Candidates raised and withdrawn

### 10a. Withdrawn, "$c(H)\gtrsim c_p+w^2$ is false at $n=12$ and $n=14$"

I checked whether the sweep input C8 fails at the dimensions the programme reaches. It does not fail **as written**. [L149](../findings/second-order.md) records the true coefficient as $0.7416199$ at $n=12$ and $0.9462602$ at $n=14$, reaching $1$ only from $n=16$, I reproduced all three exactly in §6b. But L147 writes the clause with $\gtrsim$, which absorbs a constant, and $\sqrt{55}/10$ is a constant bounded away from zero on $m\ge6$. **Withdrawn: no failure at order level.** What survives is the note that any downstream reading of L147's clause at implied constant $1$ overstates by $26\%$ at $n=12$ and $5\%$ at $n=14$, and the genuine failure at $m=4$, which is §6b and is a range finding, not a constant one.

### 10b. Withdrawn, "the ceiling contradicts the lower bound at $\beta=0$"

At $\beta=0$ the statement asserts both $r_n\gtrsim n^{-1}$ and a $\Theta(n^{-1})$ cap, which look like they pin $r_n$ and so contradict "$\gtrsim$, not $\Theta$". They do not: the cap is on what the **route** outputs, not on $r_n$, and the two are consistent as $\Theta(n^{-1})$ for the route's output at $\beta=0$. **Withdrawn.** What survives is the weaker §8 point about the letter $\Theta$.

### 10c. Withdrawn, "conflating $u$ with $w$ invalidates the bound"

Tested in §3 and found to run the safe way: $u\le w$ makes $f(u)$ a lower bound for the true two-variable quantity, so the substitution cannot inflate the conclusion. **Withdrawn as an error of direction.** What survives is that the constant in $u\le Cw$ is recorded as unknown, so even the order is conditional, which is §9's debt, not a separate finding.

### 10d. Withdrawn, "$P(W^*)=\theta_0$ fails at odd $n$, so C1 fails"

[conventions.md:18](../findings/conventions.md) is explicit that $\theta_0(n)$ is the value at the balanced product **at even $n$ only**, the odd-$n$ value being $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}<\theta_0$. L147 says nothing about parity. But $\Theta_n$ is also bounded below by a positive constant and also tends to $\sqrt2$, so $\beta\ge0$ survives at odd $n$. **Withdrawn**; the unstated parity is noted in §1b and costs nothing.

## 11. What would falsify the statement, and what I did to look for it

**The object that would break it** is a direction $H$ in $T_{W^*}\mathcal S\cap T_{W^*}\mathcal O^\perp$, at $n\ge12$, whose defect rate $u(H)$ and off-eigenspace weight $w(H)$ satisfy $a(H)\,u(H)\gg S$ while $c(H)=\Theta(c_p)$, i.e. a direction that is simultaneously **low-margin and high-defect-penalty**. At such an $H$ the branch-1 value is $\Theta(\sqrt{c_p}/a)=\Theta(n^{-3/2})$ and the headline fails at every $\beta<\tfrac12$. Equivalently: any $H$ making the constant $C$ in $u\le Cw$ grow with $n$.

**What I did to look for one.** I read [L148](../findings/second-order.md), which forces $u=0$ on the margin summand and so rules out the cheapest construction; [L149](../findings/second-order.md)'s sweep, whose whole content is that no direction is both low-margin and high-operator-norm and which would rule this out **if** $a$ were controlled by $\lVert H\rVert_{op}$ alone; and [L157](../findings/second-order.md), which makes $a\propto(1-\eta)^{-2}$ with $\eta$ itself a function of $w$. The chain that would close the hole runs $u\le Cw\Rightarrow a\,u\lesssim(n^{1/2}+nw)Cw$, and at $w\lesssim n^{-1/2}$ that is $O(C)$ against $S=\Omega(1)$, safe **iff** $C=O(1)$. **So the falsifier reduces exactly to the unknown constant $C$**, and the record says at two separate lines that $C$ is unknown. I constructed no witness, because constructing one requires computing $A'(0)$ on the mixed directions, which is numerical work this footing forbids; I record instead that the falsifier is one bounded constant away and name which one.

**Second falsifier, for the ceiling.** A direction with $c(H)/C(H)\gg n^{-1}$ at $w=0$ would break the cap. It cannot exist: $c(H)=c_p=3\theta_0/(n-2)$ is fixed on that summand and $S\ge\theta_0$, giving $c_p/S\le3/(n-2)$ with no freedom. **The ceiling is unfalsifiable within the route**, which is §8's verdict.

---

**VERDICT: `GAP`.** The range $\beta\in[0,\tfrac12]$ and the $O(n^{-1})$ ceiling are sound. The headline $r_n\gtrsim n^{-1-\beta}$ has no surviving derivation on file and stands as `HYPOTHESIS-DEBT` in the precise form given in §9. The pre-registered question is settled in the entry's favour on the algebra and against it on the consequence: $f$ is minimised at the interior $u^*$, exactly as written; $u$ is the defect's linear rate and is **not** $w$; and the interior minimum is what removes L147's own source for its headline value.
