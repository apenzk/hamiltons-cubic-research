# VERIFY v28, L156: the contour constant $C=\alpha(1+\alpha)/(d(d-\gamma))$, the objective $J=C/\gamma$, and the claim that its minimum is interior and attained at $(\alpha^*,\gamma^*)=(D/2,D/4)$

*Cold brief, from [ROUND_L156.md](ROUND_L156.md) and the text at [findings/second-order.md:1406–1440](../findings/second-order.md). **No numerical work of any kind was done**: no script was run, no search was made, and every number below is an exact hand evaluation of a closed form, given as a rational wherever it is one. Log: [agent_logs/verify-L156-v28.log](../agent_logs/verify-L156-v28.log).*

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | $\operatorname{spec}(W^*)$ on $\Lambda^2\mathbb R^{2m}$ is the two points $\lambda_-=-g_n$, $\lambda_+=\tfrac m{m-1}g_n$, with $\ker W^*=0$ | **CORRECT, reproduced independently** |
| 2 | $D=\tfrac{2m-1}{m-1}=\lvert\lambda_+-\lambda_-\rvert/g_n$ | **CORRECT** |
| 3 | $\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert=1/(dg_n)$, $d=\min(\alpha,D-\alpha)$ | **CORRECT on $0<\alpha<D$; FALSE outside, where the statement gives no domain** |
| 4 | $C(\alpha,\gamma)=\dfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ | **CORRECT AS A FORMULA, NOT DERIVED BY THE WRITTEN PROOF** |
| 5 | The written proof's factor list ("length $\alpha$", "$\max\lvert\zeta\rvert=(1+\alpha)g_n$", "the Neumann step replaces $d$ by $d-\gamma$") | **GAP: it multiplies to $\alpha(1+\alpha)/(d-\gamma)$, a factor $1/d$ short, and omits the $\gamma$ that makes $J=C/\gamma$** |
| 6 | Reduction to $\tfrac{1+\alpha}{\alpha-\gamma}$ exactly on $\alpha\le D/2$ | **CORRECT** |
| 7 | $\gamma^*=d/2$, and $J=4\alpha(1+\alpha)/d^3$ | **CORRECT** |
| 8 | Both branches strictly monotone toward $\alpha=D/2$; minimum interior and **attained** | **CORRECT, and it is a corner minimum, not a stationary point** |
| 9 | $\alpha^*=D/2$, $\gamma^*=D/4$, $C^*=2+\tfrac{4(m-1)}{2m-1}$, $J^*=4(1+\alpha^*)/\alpha^{*2}$ | **CORRECT, all four** |
| 10 | The binding condition is the resolvent kink; $\alpha<1$ is not a constraint; the content of "no eigenvalue crosses $0$" is $\gamma<1$, slack for every $m\ge2$ | **CORRECT, both halves of the crossing condition collapse to $\gamma<1$, and $\gamma^*=D/4\le\tfrac34$** |
| 11 | Corollary: $\tfrac{42}{11}\le C^*<4$ and $6.9421\le J^*<8$ for $n\ge12$; $\tfrac{10}3$, $\tfrac{40}9$ over all $m\ge2$; fixed $(1,\tfrac12)$ gives $C\equiv4$, $J\equiv8$ | **CORRECT, every value** |
| 12 | "The gain over the frozen $(\tfrac12,\tfrac14)$ is $3.46$" | **CORRECT: exactly $\tfrac{121}{35}$** |
| 13 | "$(\tfrac43,\tfrac23)$ gives $J=23.85$ against the baseline's $24$" | **WRONG NUMBER: $J=\tfrac{350}{13}=26.92$. The conclusion survives a fortiori, that point is strictly worse than the baseline, not marginally better** |
| 14 | Hypotheses carried by the boxed statement | **INCOMPLETE: no domain for $(\alpha,\gamma)$, no $m\ge2$, no $\ker W^*=0$, no norm, and no inequality that $C$ is the constant in** |
| 15 | The two forms, [results.md](../results.md) against [findings/second-order.md](../findings/second-order.md) | **THEY CONTRADICT: results.md asserts the $\sigma$-factorisation that findings withdraws, and omits $J^*$ entirely** |
| 16 | Downstream use of $J^*$ | **BROKEN AT THE CONSUMER: [reviews/REVIEW_r711.md](../reviews/REVIEW_r711.md):40 uses $J^*=\tfrac{40}9$ at $n=12$, where L156 gives $\tfrac{840}{121}$, a factor $\tfrac{189}{121}$, in the unsafe direction** |

**One line the round can act on:** every constant L156 states is right and I reproduced all of them by hand, but the proof of its central formula is one resolvent factor short of the formula it states, the statement carries no domain for $(\alpha,\gamma)$, [results.md](../results.md) contradicts the findings text on $\sigma$ and drops $J^*$, and the first consumer of $J^*$ took the out-of-scope $m=2$ value, so the verdict is **GAP**, with the corrected constants below usable as they stand.

## 0. Conventions, fixed once

- $n=2m$, $W^*$ the unit-norm Weyl operator of the balanced product $S^m\times S^m$ acting on $\Lambda^2\mathbb R^n$, $m\ge2$.
- $g_n=\lvert\lambda_-\rvert$, the **absolute** $\Lambda^2$ spectral gap, per [findings/second-order.md:1447](../findings/second-order.md) and the warning at [findings/second-order.md:956](../findings/second-order.md) that the relative gap $\tfrac{m-1}{2m-1}$ is a different number.
- $\Gamma=\{\lvert\zeta-\lambda_-\rvert=\alpha g_n\}$, $W(z)=W^*+zH$, $\rho=\gamma g_n/\lVert H\rVert_{op}$, $D=\lvert\lambda_+-\lambda_-\rvert/g_n$, $d=\min(\alpha,D-\alpha)$.
- $\Pi(z)$ the Riesz projection over $\Gamma$, $W_-(z)=\Pi(z)W(z)$, $A=-\operatorname{Alt}\big(W_-(z)-W_-(0)\big)$, $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$.
- All norms in the resolvent chain are operator norms; $\lVert\operatorname{Alt}(X)\rVert\le\lVert X\rVert$ is [conventions.md](../findings/conventions.md).
- $C$ and $J$ are **dimensionless in $g_n$**: $C$ is a function of $(\alpha,\gamma,D)$ alone and $M\le C\gamma g_n$ scales with $g_n$. So nothing in L156 depends on the value of $g_n$, and the trap recorded at [findings/second-order.md:960](../findings/second-order.md) (the relative gap used where the absolute one belongs, worth a factor $n$), cannot touch this lemma. That is a robustness fact worth having, and it is not on the record.

## 1. The hypothesis inventory

*A pass without one is not a pass. Every hypothesis, whether the statement carries it or not, and whether the written proof uses it.*

| # | Hypothesis | Carried by the statement? | Used by the written proof? | Checked against the object |
|---|---|---|---|---|
| H1 | $W^*$ symmetric | no (implied by "$W^*=S^m\times S^m$") | **yes**, explicitly, it is what makes $\lVert(W^*-\zeta)^{-1}\rVert=1/\operatorname{dist}(\zeta,\operatorname{spec})$ | holds: the Weyl operator on $\Lambda^2$ is symmetric |
| H2 | $\operatorname{spec}(W^*)$ is exactly two points, so $\ker W^*=0$ | no | **yes**, explicitly | holds at $S^m\times S^m$, §2, and its failure is catastrophic, §6 |
| H3 | $n=2m$ and $m\ge2$ | no | yes, through $D$ | $m=1$ makes $D$ undefined and $W^*=0$; the corollary evaluates at $m=2$, the chain at $m\ge6$ |
| H4 | $0<\alpha<D$ | **no** | yes, silently, $d>0$ and the encirclement of $\lambda_-$ alone both need it | §5 exhibits a point outside it that falsifies the minimum claim as written |
| H5 | $0<\gamma<d$ | **no** | yes, through "$d-\gamma$" | at the optimum $d-\gamma=D/4>0$ |
| H6 | $\gamma<1$ (no perturbed eigenvalue crosses $0$) | no (it is in the entry's prose, not the box) | no | holds: $\gamma^*=D/4\le\tfrac34<1$ for all $m\ge2$, §4 |
| H7 | $W(z)=W^*+zH$ affine, so $\lVert W(z)-W^*\rVert_{op}\le\gamma g_n$ on the disc | no | **not mentioned**, yet the $\gamma g_n$ it supplies is the factor that cancels into $J=C/\gamma$ | §3 |
| H8 | $\lVert\operatorname{Alt}(X)\rVert\le\lVert X\rVert$ | no | not mentioned | holds, [conventions.md](../findings/conventions.md) |
| H9 | The norm in which $M$, and hence $C$, is measured | no | no | operator norm throughout; a Frobenius $M$ would change $\lVert W(z)-W^*\rVert$ to $\lvert z\rvert\lVert H\rVert_F$ and so change $\rho$'s definition |
| H10 | $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ | as an import | **yes**, cited to L152's surviving half | holds: $\max_{\lvert\zeta-\lambda_-\rvert=\alpha g_n}\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n$, attained on the ray from $0$ through $\lambda_-$ |
| H11 | The inequality $C$ is the constant in ($M\le C\gamma g_n$ | **no: the box defines a function and never says what it bounds** |), | §3 recovers it and checks it against [r441](../reviews/REVIEW_r441.md) |

**No finding on the imports themselves.** H10 is L152's surviving half and is exactly true, not an estimate. H1 and H8 are conventions. The findings are H4, H5, H7, H9 and H11 (hypotheses the proof needs and the statement does not carry) and they are collected as claim 14.

## 2. The spectrum, computed independently, and the kernel question

$S^m\times S^m$ with both factors of curvature $1$ has $R=\operatorname{id}$ on $\Lambda^2V_1$ and on $\Lambda^2V_2$ and $R=0$ on $V_1\otimes V_2$, the mixed planes being flat. It is Einstein: $\operatorname{Ric}=(m-1)g$, $\operatorname{scal}=2m(m-1)$, so the Weyl operator is $W=R-\tfrac{\operatorname{scal}}{n(n-1)}\operatorname{id}=R-\tfrac{m-1}{2m-1}\operatorname{id}$. Hence

$$\lambda_+=1-\tfrac{m-1}{2m-1}=\tfrac m{2m-1}\ \ (\text{multiplicity } m(m-1)),\qquad \lambda_-=-\tfrac{m-1}{2m-1}\ \ (\text{multiplicity } m^2),$$

and $m(m-1)+m^2=m(2m-1)=\dim\Lambda^2\mathbb R^{2m}$, so the list is **exhaustive**: there is no third eigenvalue and no kernel. The trace is $m(m-1)\tfrac m{2m-1}-m^2\tfrac{m-1}{2m-1}=0$, as a Weyl operator's must be. Then $\lambda_+/\lvert\lambda_-\rvert=\tfrac m{m-1}$ and $\lvert\lambda_+-\lambda_-\rvert/\lvert\lambda_-\rvert=\tfrac{2m-1}{m-1}=D$, both as the record has them.

Two independent confirmations that this is the right operator and the right normalisation, neither of which I needed to compute anything to obtain. First, $\lvert\lambda_-\rvert$ in the curvature-$1$ scaling is $\tfrac{m-1}{2m-1}$, which is verbatim the "relative gap" the record names at [findings/second-order.md:960](../findings/second-order.md). Second, after rescaling to $\lVert W\rVert_F=1$ ($\lVert W\rVert_F^2=\tfrac{m^2(m-1)}{2m-1}$ from the two multiplicities), the gap becomes $\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, which is character-for-character the value at [findings/second-order.md:1108](../findings/second-order.md).

**One alarm raised and withdrawn, with its reason.** [findings/bispectral.md:493](../findings/bispectral.md) records a **three**-valued spectrum at $S^m\times S^m$ ($mA$, $-(m-1)A$, $-2m(m-1)A$), of which two values are negative, which would put a second negative eigenvalue outside $\Gamma$ and destroy the Riesz identification. **Withdrawn**: the multiplicities there sum to $(m-1)(m+2)+m^2+1=2m^2+m-1=\dim S^2_0(\mathbb R^{2m})$, not $\dim\Lambda^2\mathbb R^{2m}=2m^2-m$. That is the curvature operator of the **second kind**, a different operator on a different space, and it does not bear on L156.

## 3. The formula, and the gap between it and its proof

### 3.1 What the correct derivation is

$A$ is the difference of two Riesz integrals. Writing $A=-\operatorname{Alt}(W_-(z)-W_-(0))$ and using the resolvent identity $(W(z)-\zeta)^{-1}-(W^*-\zeta)^{-1}=(W(z)-\zeta)^{-1}(W^*-W(z))(W^*-\zeta)^{-1}$,

$$\lVert A\rVert\ \le\ \frac1{2\pi}\cdot\underbrace{2\pi\alpha g_n}_{\text{length}}\cdot\underbrace{(1+\alpha)g_n}_{\max_\Gamma\lvert\zeta\rvert}\cdot\underbrace{\frac1{(d-\gamma)g_n}}_{\text{resolvent at }W(z)}\cdot\underbrace{\gamma g_n}_{\lVert W(z)-W^*\rVert}\cdot\underbrace{\frac1{d\,g_n}}_{\text{resolvent at }W^*}\ =\ \frac{\alpha(1+\alpha)}{d(d-\gamma)}\,\gamma g_n .$$

**Five factors.** So $M\le C\gamma g_n$ with $C=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$, the stated formula, exactly. Three checks that this is the intended object and not a reconstruction of my own: (i) r447's decomposition $A=\operatorname{Alt}(-\Pi(z)(W(z)-W^*)-(\Pi(z)-\Pi(0))W^*)$, quoted at [findings/second-order.md:1445](../findings/second-order.md), telescopes to $-\operatorname{Alt}(W_-(z)-W_-(0))$ identically, so the two routes bound the same $A$; (ii) at $d=\alpha$ the display returns $\tfrac{1+\alpha}{\alpha-\gamma}$, r456's constant, which is the reduction clause the statement asserts; (iii) at $(\alpha,\gamma)=(\tfrac12,\tfrac14)$ it gives $M\le6\cdot\tfrac14 g_n=\tfrac32g_n$, which is [r441](../reviews/REVIEW_r441.md)'s independently computed value **exactly**.

### 3.2 The finding

**Locate.** [findings/second-order.md:1415](../findings/second-order.md): *"The Neumann step over the disc replaces $d$ by $d-\gamma$, and the contour length contributes $\alpha$; with $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ … this gives $C$."*

**Exhibit.** That sentence enumerates **three** factors where the derivation has five. Multiplied out it gives $\tfrac{\alpha(1+\alpha)}{d-\gamma}$. At $(\alpha,\gamma)=(\tfrac12,\tfrac14)$, $m=6$: the sentence yields $\tfrac{(1/2)(3/2)}{1/4}=3$; the stated formula yields $\tfrac{(1/2)(3/2)}{(1/2)(1/4)}=6$; r441's independent value is $6$. The two missing factors are the **second** resolvent $1/(dg_n)$, at the unperturbed $W^*$, and the perturbation $\lVert W(z)-W^*\rVert\le\gamma g_n$. The second of these is load-bearing beyond the formula: it is the $\gamma$ that cancels against $\rho\lVert H\rVert_{op}$ and so is the reason the objective is $C/\gamma$ rather than $C/\gamma^2$.

**Argue the opposite.** The most charitable reading available: "replaces $d$ by $d-\gamma$" describes *which of two* resolvent factors changes under the Neumann step, with the pair $d\cdot d$ and the intervening $\gamma$ understood from the resolvent-difference structure that the preceding subsection supplies; on that reading the sentence is elliptical rather than false, and the formula it announces is correct. This reading is genuinely available, but it requires importing from outside the proof the one structure the proof never names, and the proof presents its factor list as complete ("this gives $C$"). **The candidate stands as a gap in the written argument, not as an error in the result.**

### 3.3 The units, which the statement does not fix

The box never says what inequality $C$ is the constant in. The entry's own set-up at [findings/second-order.md:1388](../findings/second-order.md) says $M\le C\rho$, which is dimensionally the $\lVert H\rVert_{op}=1$ case of $M\le C\gamma g_n=C\rho\lVert H\rVert_{op}$. This is already recorded elsewhere, [findings/second-order.md:1308](../findings/second-order.md) credits r713 with exactly this correction, **and it was not carried into L156**, which is now the canonical home of the constant. *No finding on the objective, though:* substituting either form into $\sup\lVert A''\rVert\le2M/((1-\sigma)\rho)^2$ leaves the $(\alpha,\gamma)$-dependence as $C/\gamma$ in both cases, since $\rho^{-2}$ contributes $\gamma^{-2}$ and $M$ contributes $\gamma^{+1}$. So $J=C/\gamma$ is robust to the normalisation.

## 4. Pre-registered question 2, is the $\gamma$ of $\rho=\gamma g_n/\lVert H\rVert_{op}$ the $\gamma$ of $J=C/\gamma$?

**Settled: they are one symbol, and they must be.** The doubt is dissolved by writing the objective out from the lemma's own hypothesis:

$$\sup\lVert A''\rVert\ \le\ \frac{2M}{((1-\sigma)\rho)^2}\ \le\ \frac{2\,C\gamma g_n}{(1-\sigma)^2}\cdot\frac{\lVert H\rVert_{op}^2}{\gamma^2g_n^2}\ =\ \frac{2\lVert H\rVert_{op}^2}{(1-\sigma)^2 g_n}\cdot\frac C\gamma .$$

The $\gamma$ in $J=C/\gamma$ **is** the $\gamma$ of the disc radius: it enters twice through $\rho^{-2}$ and once through $M$, and $J$ is the surviving first power. There is no second parameter and no room for one, $\gamma$ occurs in the chain only as the disc radius in units of $g_n/\lVert H\rVert_{op}$, and $C$'s own $\gamma$ is that same disc radius entering the Neumann step. The prefactor $2\lVert H\rVert_{op}^2/((1-\sigma)^2g_n)$ carries no $(\alpha,\gamma)$, which is what licenses minimising $J$ alone at fixed $\sigma$.

**No finding.** The earlier doubt is refuted, and the reason it can be refuted from the lemma's own hypothesis is that $\rho$'s definition is part of the statement.

## 5. Pre-registered question 1, interior and attained, or approached?

**Attained, and I state precisely what makes the minimum exist.**

**The inner problem.** At fixed $\alpha$, $J=\tfrac{\alpha(1+\alpha)}{d\,\gamma(d-\gamma)}$, so minimising $J$ maximises $\gamma(d-\gamma)$ on $(0,d)$, a strictly concave parabola with maximum $d^2/4$ at $\gamma=d/2$, attained, interior, unique. Substituting, $J(\alpha)=\tfrac{4\alpha(1+\alpha)}{d^3}$.

*The constraint $\gamma<1$ never binds anywhere on the domain, not merely at the optimum:* $d=\min(\alpha,D-\alpha)\le D/2=\tfrac{2m-1}{2(m-1)}\le\tfrac32$ for every $m\ge2$, so $\gamma=d/2\le\tfrac34<1$ throughout. That is stronger than the entry's "slack for every $m\ge2$" and it is what makes the inner problem unconstrained.

**The outer problem.** On $(0,D/2]$, $d=\alpha$ and $J=4(1+\alpha)/\alpha^2=4\alpha^{-2}+4\alpha^{-1}$, with $J'=-8\alpha^{-3}-4\alpha^{-2}=-4(\alpha+2)/\alpha^3<0$: strictly decreasing. On $[D/2,D)$, $d=D-\alpha$ and $J=4\alpha(1+\alpha)/(D-\alpha)^3$ has a numerator strictly increasing and positive and a denominator strictly decreasing and positive: strictly increasing. $J$ is continuous across $\alpha=D/2$, where both branches equal $4(1+D/2)/(D/2)^2$.

**Why the minimum exists rather than being a supremum of admissible values**, the point the round asked for. The admissible set is the **open** interval $\alpha\in(0,D)$, so existence is not automatic. What supplies it is coercivity at both ends together with continuity: $J\to+\infty$ as $\alpha\downarrow0$ (like $4/\alpha^2$) and as $\alpha\uparrow D$ (like $4D(1+D)/(D-\alpha)^3$), so every sublevel set $\{J\le J(D/2)+1\}$ is a compact subset of the open interval and Weierstrass applies on it. The minimiser is then interior by construction, and unique because $J$ is strictly monotone on each side.

**One correction to how it is described.** The minimum is a **corner**, not a stationary point: the left derivative at $\alpha^*=D/2$ is $-4(\alpha^*+2)/\alpha^{*3}\ne0$, so $J$ is not differentiable there and no first-order condition holds. The proof's actual argument (*"both branches run toward $\alpha=D/2$"*), is the right one for a corner and is correct as written; the word "interior" in the statement should be read as interior-to-the-domain, which it is, and not as stationary, which it is not.

**Values, all exact.** $\alpha^*=D/2$, $\gamma^*=D/4$, $C^*=\tfrac{(D/2)(1+D/2)}{(D/2)(D/4)}=2+\tfrac4D=2+\tfrac{4(m-1)}{2m-1}$, and $J^*=C^*/\gamma^*=\tfrac 8D+\tfrac{16}{D^2}=\tfrac{4(1+\alpha^*)}{\alpha^{*2}}$. All four as stated.

### The one candidate that would refute the minimum, and its status

**Locate.** The box at [findings/second-order.md:1410–1413](../findings/second-order.md) asserts "*its minimum is interior and attained at* $\alpha^*=D/2$, $\gamma^*=D/4$" while giving **no domain for $(\alpha,\gamma)$**.

**Exhibit.** Take $m=6$, so $D=\tfrac{11}5$, and the pair $(\alpha,\gamma)=(4,10)$. Then $d=\min(4,\tfrac{11}5-4)=-\tfrac95$, $d-\gamma=-\tfrac{59}5$, $d(d-\gamma)=\tfrac{531}{25}$, $\alpha(1+\alpha)=20$, so $C=\tfrac{500}{531}$ and $J=\tfrac{50}{531}=0.0942$, against $J^*=\tfrac{840}{121}=6.9421$. Read as a bare minimisation of the displayed formula, the claim is false; and the family $\alpha>D$, $\gamma\to\infty$ drives $J\to0$.

**Argue the opposite.** The domain is genuinely on the record, two paragraphs below the box: $\Gamma$ must enclose $\lambda_-$ and exclude $\lambda_+$, which is $0<\alpha<D$; the Neumann step needs $\gamma<d$; the entry names $\alpha+\gamma<D$ and $\gamma<1$ explicitly. A reader of the whole entry has every constraint, and $d=\min(\alpha,D-\alpha)$ is a distance, meaningless where it is negative.

**Verdict on the candidate: it stands, but only as a statement-level defect**, the box is not self-contained and cannot be quoted alone, which is exactly how a constant travels. It is not a refutation of the lemma.

## 6. The edge of every range

**Smallest admissible dimension.** The statement carries none. $m\ge2$ is needed for $D$ to be defined at all, and the chain that consumes L156 runs at $n\ge12$, i.e. $m\ge6$ ([findings/second-order.md:1173](../findings/second-order.md), [1185](../findings/second-order.md)). The corollary evaluates at $m=2$, where the formulas are internally fine ($D=3$, $\alpha^*=\tfrac32$, $\gamma^*=\tfrac34<1$, $C^*=\tfrac{10}3$, $J^*=\tfrac{40}9$) but out of scope by the corollary's own sentence. §8 shows that value being taken at $n=12$ by the next consumer.

**Admissible range of the contour parameter.** $0<\alpha<D$ and $0<\gamma<d$, neither in the statement; $\gamma<1$ additionally, never binding (§5). At $\alpha=D$ exactly, $\lambda_+$ sits on $\Gamma$ and the resolvent is unbounded; at $\alpha\downarrow0$ the contour collapses and $C\to\infty$. Both ends are excluded and both send $J$ to $+\infty$, which is the coercivity §5 uses.

**$\ker W\ne0$, what this lemma asserts there.** *Nothing, and it must assert nothing.* The record's named witness is $W_{\mathbb{CP}^2}$ at $n=4$ with $\dim\ker W=3$ ([findings/second-order.md:1173](../findings/second-order.md), which records that $g_n$, $\rho$, $M$ and branches 2–3 do not exist there). L156 is stated at $W^*=S^m\times S^m$, where $\ker W^*=0$ by §2, so it is silent at the witness, correctly. **What is worth recording is how violently it would fail if it were not silent.** With $0\in\operatorname{spec}$, the distance from $\Gamma$ to the spectrum acquires a third term and $d$ becomes $\min(\alpha,\lvert1-\alpha\rvert,D-\alpha)$. At the lemma's own optimum, $m=6$ and $\alpha^*=\tfrac{11}{10}$, that is $\min(\tfrac{11}{10},\tfrac1{10},\tfrac{11}{10})=\tfrac1{10}$, while $\gamma^*=\tfrac{11}{20}>\tfrac1{10}$, so $d-\gamma<0$, $C$ is negative and the bound is not merely weaker but meaningless. The kernel hypothesis is therefore not a technicality: **the optimum $\alpha^*>1$ is precisely what makes a kernel fatal**, because $\Gamma$ then passes within $(\alpha^*-1)g_n=\tfrac{g_n}{2(m-1)}$ of the origin. That $\alpha^*>1$ is the entry's own headline ruling makes this the hypothesis most worth writing into the box.

## 7. Quantifier order and scope

- **Free:** $m$ (hence $D$), $g_n$, $\lVert H\rVert_{op}$, $\sigma$. **Optimised:** $\alpha$ and $\gamma$ jointly. **No finding on the order:** the proof computes $\inf_\alpha\inf_\gamma$, which equals $\inf_{(\alpha,\gamma)}$, and the inner infimum is attained for every admissible $\alpha$, so the iterated minimum is the joint one.
- **One place a maximum is distributed across factors sharing a variable, and it is sound.** The contour bound takes $\max_\Gamma\lvert\zeta\rvert$ and $\max_\Gamma\lVert(\cdot-\zeta)^{-1}\rVert$ **independently**, though both range over the same $\zeta$. That is a valid upper bound in general and it is **lossless here on the left branch**: for $\alpha\le D/2$ the distance from $\Gamma$ to $\lambda_-$ is $\alpha g_n$ at *every* point of $\Gamma$, so the resolvent max is attained everywhere and the two maxima are simultaneously realised. At the optimum $\alpha^*=D/2$ the distances to $\lambda_-$ and $\lambda_+$ coincide, and the minimum distance is again attained at every point of $\Gamma$. **No finding.**
- **Scope of $\sigma$:** the entry states plainly that $\sigma$ has no definition on the record and withdraws the claim that it factorises out. §9 records what results.md does with that.

## 8. The gap between what is proven and what is used

Downstream takes $J^*$, $C^*$ and $(\alpha^*,\gamma^*)$: [ROUND_L149r](ROUND_L149r.md) through $K=\lambda(1-\eta^*)^2/(\sqrt2J)$; L157 through $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$, which needs $J$ **and** $\gamma$ separately, i.e. $C$; L158 through "$2J^*$ inside $\lVert A''\rVert$".

**Does the written statement give each, at the generality used?** $\alpha^*$, $\gamma^*$ and $C^*$: yes, in closed form in $m$. $J^*$: **only as $4(1+\alpha^*)/\alpha^{*2}$**, a formula the reader must evaluate, with no closed form in $m$ and no value in the box. That is the one asymmetry in the statement, and it is the constant that then went wrong.

### The finding

**Locate.** [reviews/REVIEW_r711.md](../reviews/REVIEW_r711.md):40, *"L158 carries the $(1-\eta^*)^{-2}$ up into the numerator and drops the $2J^*$, with $J^*=\tfrac{40}9$, a factor $8.89$, or $2C^*=7.64$"*, carried into the record at [findings/second-order.md:1326](../findings/second-order.md) as "L156's $2J^*=8.89$".

**Exhibit.** $\tfrac{40}9$ is L156's $J^*$ at $m=2$, the corollary's all-$m$ opening value, which the corollary's own next clause declares out of scope. At $n=12$, $m=6$: $D=\tfrac{11}5$, $\alpha^*=\tfrac{11}{10}$, $J^*=\tfrac{4(1+\tfrac{11}{10})}{(\tfrac{11}{10})^2}=\tfrac{4\cdot\tfrac{21}{10}\cdot100}{121\cdot10}=\tfrac{840}{121}$, so $2J^*=\tfrac{1680}{121}=13.884$, not $8.889$. The factor is $\tfrac{840}{121}\big/\tfrac{40}9=\tfrac{189}{121}=1.562$. Two things make this an error rather than a convention: the **same sentence** uses $C^*=\tfrac{42}{11}$, which is the $m=6$ value, so the pair is internally inconsistent; and $J^*$ is *increasing* in $m$, so taking the $m=2$ value at $n=12$ **understates** $\sup\lVert A''\rVert$ and thereby **overstates** the tube radius, the unsafe direction.

**Argue the opposite.** $8.89$ is also, to three figures, the value of $1/g_n=\tfrac{n^2c_p}6=6\sqrt{22/10}=8.899$ at $n=12$, which appears as $B$ in the very same list; so the number may be a transcription of the adjacent constant rather than a reading of the corollary. Either way it is not $2J^*$ at $n=12$, and the threshold "$\approx21$" that L158 records as disputed rests on it.

## 9. The two forms

| | [findings/second-order.md:1406–1440](../findings/second-order.md) | [results.md:353–357](../results.md) |
|---|---|---|
| $C$, $d$, $D$, the reduction clause | present | present, equivalent wording |
| $\alpha^*$, $\gamma^*$, $C^*$ | present | present |
| **$J^*$** | present | **absent** |
| binding condition | resolvent kink; and $\gamma<1$ named as the real content of the crossing condition | resolvent kink; **$\gamma<1$ dropped** |
| **$\sigma$** | *"$\sigma$ has no definition on the record"*; *"the claim that $\sigma$ factorises out of the whole is **withdrawn**"* | *"$\sigma$ factorises out of it, so the joint three-parameter optimisation reduces to one parameter in closed form"* |
| corollary intervals, three open constants | present | absent |

**The difference is material, not editorial.** Take the composite objective the chain actually faces, $F=2J/(1-\eta^*)^2$ with $\eta^*$ the fixed point of $t(1-\eta)^2=\eta$ and $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$, note $J\gamma=C$, so $t$ is a function of $C$ alone. For small $t$, $\eta^*\approx t$ and

$$F\ \approx\ 2J\big(1+2t\big)\ =\ \frac{2C}\gamma+\frac{2\lambda\sqrt{c_p+w^2}}{\gamma}\ =\ \frac{2\big(C+\lambda\sqrt{c_p+w^2}\big)}{\gamma},$$

which is minimised by a **different** $(\alpha,\gamma)$ than $C/\gamma$ is: two admissible pairs with equal $J$ but different $C$ give different $F$, the larger $C$ being preferred. So $\sigma$ does not factorise, the findings text is right to withdraw the claim, and **the canonical index carries the withdrawn version**. Combined with the missing $J^*$, [results.md](../results.md) is the more consulted of the two forms and the less correct one.

*A second, smaller inconsistency inside the findings file itself.* [findings/second-order.md:1455](../findings/second-order.md), inside L152, still reads *"the contour must separate $\lambda_-$ from both $0$ and $\lambda_+$, so $\alpha<1$ keeps $0$ outside … the first binding"*, the ruling L156 overturns, left standing with no forward pointer, in the same file, sixteen lines below L156's own paragraph overturning it.

## 10. What would falsify the statement, and what I did to look for it

- **A third spectral point of $W^*$**, or any kernel, would break the resolvent step and with it $C$, $J^*$ and the optimum. I computed the $\Lambda^2$ spectrum from the product structure and closed it by multiplicity count against $\dim\Lambda^2\mathbb R^{2m}$; I chased the one record entry that reports three eigenvalues at $S^m\times S^m$ and identified it as the second-kind operator by its own multiplicity count. Nothing found.
- **An admissible $(\alpha,\gamma)$ with $J<J^*$** would refute the optimum. I bounded the domain from the geometry ($0<\alpha<D$, $0<\gamma<d$), checked coercivity at both ends and strict monotonicity on both branches, so no such point exists inside the domain. Outside it, $(\alpha,\gamma)=(4,10)$ at $m=6$ gives $J=\tfrac{50}{531}$, which is why the missing domain in the statement is a finding.
- **A value of $\gamma$ at which the constraint $\gamma<1$ bites before $\gamma<d$ does** would break the reduction of the crossing condition. I checked $d\le D/2\le\tfrac32$ for all $m\ge2$, so $\gamma=d/2\le\tfrac34$ everywhere on the domain. None exists.
- **A dimension at which the corollary's intervals fail.** $C^*$ and $J^*$ are both strictly increasing in $m$ with limits $4$ and $8$; the endpoints at $m=6$ are $\tfrac{42}{11}$ and $\tfrac{840}{121}$, at $m=2$ are $\tfrac{10}3$ and $\tfrac{40}9$. Every stated bound holds at its stated range.

## Verdict

**GAP.**

The lemma's every asserted value is correct and I reproduced all of them independently and exactly: the two-point spectrum with $\ker W^*=0$, $D$, the constant $C$, the reduction on $\alpha\le D/2$, $\gamma^*=d/2$, both branches' monotonicity, the attainment at the corner $\alpha^*=D/2$, and $\alpha^*$, $\gamma^*$, $C^*$, $J^*$ and the corollary's four interval endpoints. The gap is fourfold and none of it touches the values:

1. **The proof does not derive its own formula** (§3.2): its factor list yields $\alpha(1+\alpha)/(d-\gamma)$, missing the second resolvent and the $\gamma$ that makes the objective $C/\gamma$.
2. **The statement carries no domain** for $(\alpha,\gamma)$ and no $\ker W^*=0$, $m\ge2$, norm, or defining inequality for $C$ (§1, §5, §6), and at a kernel point the optimum's own $\alpha^*>1$ makes the constant negative.
3. **[results.md](../results.md) contradicts the findings text on $\sigma$ and omits $J^*$** (§9).
4. **The first consumer of $J^*$ took the $m=2$ value at $n=12$** (§8), in the unsafe direction, and a disputed threshold rests on it.

Nothing here requires computation to repair; every item is a sentence.
