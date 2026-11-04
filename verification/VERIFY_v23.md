# VERIFY v23, L147: the radius $r_n\gtrsim n^{-1-\beta}$, the range $\beta\in[0,\tfrac12]$, the $\Theta(n^{-1})$ ceiling, and the branch-1 form $(c_p+u^2)/(S+au)$

*Verifier v23, [ROUND_L147](ROUND_L147.md), phase 1. Worked cold from the brief's verbatim block and from the definitions in [conventions.md](../findings/conventions.md), [bounds.md](../findings/bounds.md) and [second-order.md](../findings/second-order.md). **No numerical work of any kind was run**; every number below is an exact hand evaluation from a closed form, and each is shown with the closed form it comes from. Log: [agent_logs/verify-L147-v23.log](../agent_logs/verify-L147-v23.log). No other verifier's report was read.*

## Verdicts

| # | claim as written in L147 | verdict |
|---|---|---|
| 1 | $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\uparrow\sqrt2$ forces $\beta\ge0$ | **PROVEN** |
| 2 | [Lemma L143](../findings/bounds.md) forces $\beta\le\tfrac12$ | **PROVEN** |
| 3 | both endpoints of $\beta\in[0,\tfrac12]$ are realised | **NOT ESTABLISHED**, neither endpoint has a witness on file, and $\beta$'s existence is itself an added hypothesis |
| 4 | the ceiling, as $O(n^{-1})$, via $c_p/\theta_0\le3/(n-2)$ | **PROVEN**, and the inequality is an equality |
| 5 | the ceiling stated as $\Theta(n^{-1})$ | **GAP**, attainment is not proven here, and way 2 of the four is refuted by [Lemma L148](../findings/second-order.md) |
| 6 | $f(u)=(c_p+u^2)/(S+au)$ has $f'(0)<0$, minimiser $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, value $2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ | **PROVEN**, reproduced exactly in §5; the algebra is right |
| 7 | that $f$ **is** the chain's branch 1 | **HYPOTHESIS-DEBT**, $u$ is undefined, $a$ is undefined, and the form is derived nowhere in [findings/](../findings/) |
| 8 | "the cubic branch always shadows the quartic", read against the headline | **BROKEN as stated**, for $a\gtrsim n^{1/2+\beta}$ the lemma's own §5 gives $n^{-3/2}$, contradicting its headline at every $\beta<\tfrac12$ |
| 9 | $r_n\gtrsim n^{-1-\beta}$ | **HYPOTHESIS-DEBT**, L147 contains no minimisation and no chain; the display is imported from reviewer prose |
| 10 | $M=O(\rho)$ because $x\mapsto x_-$ is $1$-Lipschitz | **GAP**, a real-symmetric argument applied on a complex disc; the record's own contour section gives $M\le6\rho$, not $M\le\rho$ |
| 11 | dimension range | **HYPOTHESIS-DEBT**, none is stated; the imports need exactly $n>6+2\sqrt7$, i.e. $n\ge12$ |
| 12 | $\ker W^*=0$ | **UNSTATED, TRUE at $W^*$**, used by two of the three branches, never named |
| 13 | base point, functional and direction domain | **UNSTATED**, the statement names no $W^*$, no penalty and no $H$-domain, though every step needs all three |

**Verdict: `HYPOTHESIS-DEBT`.**

**One line the round can act on.** The two values survive as orders, but L147 proves neither of the two things it is cited for: the radius display has no minimisation step in it at all, and the branch-1 form the entry introduces ($(c_p+u^2)/(S+au)$), is an assertion in two undefined symbols whose size decides whether the headline is $n^{-1-\beta}$ or $n^{-3/2}$.

## 0. Conventions, fixed once

| symbol | value used here | source |
|---|---|---|
| $P(W)$ | the cubic form $\langle W,Q(W)\rangle$; $\theta=P(W)/\lVert W\rVert^3$, so $P=\theta$ at unit norm | [conventions.md](../findings/conventions.md) lines 16–17 |
| $\theta_0(n)$ | $\theta_0(n)^2=2(n-1)(n-2)/n^2$, the value at the balanced product at even $n$ | [conventions.md](../findings/conventions.md) line 18 |
| $W^*$ | $S^m\times S^m$, $n=2m$, unit Frobenius norm | [Lemma L145](../findings/second-order.md) |
| $g_n$ | $\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\Theta(1/n)$; spectrum of $W^*$ two-valued, $\lambda_+=\tfrac m{m-1}g_n$ | [Lemma L145](../findings/second-order.md) step 1 |
| $c_p$ | the off-orbit margin at $W^*$, $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ | [Lemma L146](../findings/second-order.md) |
| $S$ | $\sup\lvert P\rvert$ over the unit sphere | L147's own statement |
| $w$ | $\lVert H_r\rVert$, the weight of $H$ outside **both** $S^2_0(\mathbb R^m)$ copies | [Lemma L149](../findings/second-order.md) set-up |
| $u$ | **undefined**; see §4 |, |
| $a$ | **undefined**; see §4 |, |
| $A(z)$ | $\mathrm{Alt}(W(z)_-)$ along $W(z)=W^*+zH$, $A(0)=0$ | [Lemma L145](../findings/second-order.md) |
| $\rho$ | the analyticity disc, $\Theta(\min(1,g_n/\lVert H\rVert_{op}))$ | [Lemma L145](../findings/second-order.md) |

Exact values used below, each from the closed form above and no computation: $\theta_0(8)=\sqrt{21}/4$, $\theta_0(10)=6/5$, $\theta_0(12)=\sqrt{55}/6$, $\sqrt{3/2}=1.224744\ldots$, and $c_p(12)=3\theta_0(12)/10=\sqrt{55}/20$.

## 1. The hypothesis inventory

**Carried by the statement, explicitly.** Exactly one: $\sup\lvert P\rvert=\Theta(n^\beta)$, together with the side condition $\beta\in[0,\tfrac12]$.

**Carried by the statement, silently, and needed by every step.**

1. **The base point.** $r_n$ is a tube radius *about the orbit of $W^*=S^m\times S^m$ under the penalised functional*, that is [Lemma L145](../findings/second-order.md)'s object, and L145's statement names it. L147's statement names neither the point, nor the functional, nor the penalty $-\kappa_n\delta^2$ whose sign condition its own imports need. A reader who takes $r_n$ at face value has an unquantified symbol.
2. **The direction domain.** Every branch is an infimum over $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$. L147 never writes it. The two orthogonality conditions are what exclude $\langle W\rangle$'s negative margin and the orbit's zero margin, so the domain is load-bearing rather than decorative.
3. **$\ker W^*=0$.** Branches 2 and 3 are Cauchy estimates on $z\mapsto\mathrm{Alt}(W(z)_-)$, and $W\mapsto W_-$ is analytic at $W^*$ only because $0\notin\mathop{\mathrm{spec}}(W^*)$. [Lemma L149](../findings/second-order.md) states this hypothesis and discharges it; L147 uses it and states it nowhere. It **holds** at $W^*$: the spectrum is $\{\lambda_-,\lambda_+\}$ with $\lambda_-=-g_n<0<\lambda_+=\tfrac m{m-1}g_n$. See §7 for why the omission still matters.
4. **A dimension floor.** None appears. §6 shows the imports need $n\ge12$ exactly.
5. **The penalty positivity $\tfrac32\theta_0-\lvert\kappa_n\rvert>0$.** Needed for the margin to survive the penalty. It holds, at $n=12$, $\lvert\kappa_{12}\rvert=9(\sqrt{55}/6-\sqrt{3/2})=0.101592$ against $\tfrac32\theta_0(12)=1.854049$, and in the limit $\tfrac32\sqrt2-9(\sqrt2-\sqrt{3/2})=2.121320-1.705221=0.416099$, but it is a hypothesis of the chain, unnamed here.
6. **$a>0$ and $u^*$ admissible.** §5's minimiser exists only for $a>0$ and lies in the range only if the range is an interval reaching $u^*$. Neither is stated. Both happen to hold under every reading I could construct (§5).

**Imported results, and each checked against the object it is applied to.**

| import | its hypotheses | met by L147's object? |
|---|---|---|
| [Lemma L143](../findings/bounds.md): $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | unit-norm sphere; $\nabla P=3Q$; the marginals of [Lemma L31](../findings/stratum-two-negative.md) and [Lemma L153](../findings/bounds.md); no dimension restriction | **yes**, same object, same normalisation, all $n$ |
| [Lemma L146](../findings/second-order.md): $\lVert H\rVert_{op}=O(n^{-1/2})$ on the summand | $H$ the Weyl image of a **single** $h\in S^2_0(\mathbb R^m)$, $\lVert H\rVert_F=1$, $m\ge3$, and $m\ge5$ for the margin to sit there | **partially**, L147 applies it to "the margin summand" while the chain quantifies over all ten of [Lemma L27](../findings/nondegeneracy.md)'s summands, which L147's own next box charges as a quantifier error (§3) |
| [Lemma L27](../findings/nondegeneracy.md): the ten summands and $E(\tfrac12)=$ the orbit tangent |, | used only to name the summands; consistent |
| the Cauchy estimate $\lVert A''(0)\rVert\le2M/\rho^2$ | $A$ holomorphic on the open disc of radius $\rho$, $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ | **yes at $z=0$**; the chain needs it along $\lvert s\rvert\le r$, where the constant is $2M/(\rho-\lvert s\rvert)^2$, L147 uses the $z=0$ form only |
| [Lemma L148](../findings/second-order.md): the defect vanishes identically on the margin summand | $W^*$ and $H$ simultaneously diagonal | **yes**, and it *displaces* L147's central substitution box, see §3 |

**Which hypotheses the written proof actually uses.**

- $\sup\lvert P\rvert=\Theta(n^\beta)$ is used **only in its upper half**, $S=O(n^\beta)$, to turn branch 1 into $n^{-1-\beta}$. The lower half $S=\Omega(n^\beta)$ is used nowhere; the ceiling clause uses the *different* lower bound $S\ge\theta_0$. The stated $\Theta$ is therefore stronger than the proof needs.
- **The range $\beta\in[0,\tfrac12]$ is not used by the displayed inequality at all.** $r_n\gtrsim n^{-1-\beta}$ follows from $S=O(n^\beta)$ for any real $\beta$. The range is used only in the separate remark that the ceiling question is empty. This is an unused hypothesis in the sense item 1 of the brief asks about, and it is the more conspicuous because the headline advertises it.

## 2. Quantifier order and scope

The object is $r_n=\inf_H r(H)$ with $r(H)\gtrsim\min(\text{branches})$, an infimum over directions of a minimum over branches. Three readings occur in L147 and they do not agree.

- **The ceiling clause is a supremum-side statement about the bound.** "The $P$-side branch caps itself at $c_p/\theta_0$" evaluates branch 1 at one direction ($w=0$) and concludes a cap. For an infimum this is valid ($\inf_H\le$ the value at any admissible $H$) but what it caps is *the bound the route delivers*, not $r_n$. L147 then writes "*So the radius lives in $[n^{-3/2},n^{-1}]$*", which reads the cap as an upper bound on the radius itself. Nothing in the entry bounds $r_n$ from above; an infimum of lower bounds is not an upper bound on the quantity bounded. The charitable reading ("radius" abbreviating "the radius this route certifies"), is available, and [Lemma L149](../findings/second-order.md)'s closing box takes it explicitly ("a limit on the method rather than on the problem"). I record the sentence as loose rather than false.
- **A $\min$ over branches was distributed across a shared variable, and correctly.** $\inf_w\min(f,g)=\min(\inf_wf,\inf_wg)$ is an identity, and [Lemma L158](../findings/second-order.md) says so. No finding.
- **The genuine scope failure is inside the entry.** The substitution box asserts $\lVert A''\rVert=O(n^{1/2})$ "on the margin summand"; the next box charges precisely that restriction as a quantifier error, since the chain's $\lVert A''\rVert$ ranges over all ten summands. Both boxes stand, with no statement of which is operative, so the entry contains a claim and its refutation and a reader cannot tell what is being asserted. §3 takes this up.

## 3. What the two boxes do to each other, and what [Lemma L148](../findings/second-order.md) does to both

**Locate.** Line 1167–1169 of [second-order.md](../findings/second-order.md): "$\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})$ on the margin summand". Line 1171: "[Lemma L146](../findings/second-order.md) bounds one summand; the chain's $\lVert A''\rVert$ ranges over all ten".

**Exhibit.** The two are inconsistent as assertions: the first is a bound on a restricted set, the second says that the restricted set is the wrong quantifier. And [Lemma L148](../findings/second-order.md), recorded eight lines below L147, empties the first outright: on the margin summand $W^*$ and $H$ are simultaneously diagonal, so $W(t)_-$ is diagonal, so $A(t)=\mathrm{Alt}(W(t)_-)\equiv0$ and $\lVert A''\rVert=0$ there. The box therefore prices a quantity that is identically zero on the set it prices it over, the record says so itself, in L146's own displacement box.

**Argue the opposite.** L147 was written before L148 was found (L148 was found while attacking L147), and the bound $\lVert A''\rVert=O(n^{1/2})$ is *true* on that summand, vacuously. The box's real content is the arithmetic $M=O(\rho)\Rightarrow\lVert A''\rVert=O(1/\rho)$, which is correct and is what the mixed directions later reuse. So this is not a false statement; it is a true statement about an empty quantity, left in place with no marker, next to a second box that withdraws its scope.

**Finding stands, as a presentation defect with mathematical teeth:** the entry's only displayed estimate is one the record elsewhere says prices nothing.

## 4. The pre-registered question, settled: what is $u$, and where is $f$ minimised

**What $u$ is: nothing, in L147.** The letter is introduced at line 1173 without definition. The record carries three distinct quantities under it, two of them inside this very lemma:

1. **Line 1171**, in L147 itself: "a single mixed direction with $u\asymp n^{-1/2}$", a *direction weight*, the role $w$ plays in [Lemma L149](../findings/second-order.md).
2. **Line 1227**, in L149: the first-order defect size, for which the record proves only "$u\le w$", because $A'(0)$ is linear and vanishes on the margin subspace by [Lemma L148](../findings/second-order.md).
3. **Line 1173**, in L147: the argument of $f$.

**And the record itself says $u\ne w$.** Line 1421 lists as an open debt "**the $u\lesssim w$ constant** linking the two decompositions of $H$ is recorded as unknown". So the two are separate variables related by an inequality with an unknown constant, on the record's own account. **The pre-registered question's second half is answered: $u$ is not $w$, and L147 supplies no definition for it.**

**What this costs the numerator.** The proven margin bound is in $w$: $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$. If $u\le Cw$ with $C$ unknown, then $c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)C^2}u^2$, so writing the numerator as $c_p+u^2$ needs $3\theta_0\tfrac{m-4}{2(m-1)}\ge C^2$. L149's own note gives that coefficient as $0.741620$ at $n=12$ and $0.946264$ at $n=14$, both below $1$; so even at $C=1$ the numerator $c_p+u^2$ is **a lower bound stated upward at $n=12$ and $n=14$**, by a factor $1/0.741620=1.348$ at $n=12$ on the $u^2$ term. With $C$ unknown it cannot be checked at all.

**What $a$ is: nothing, in L147, and nothing that pins its size anywhere.** The only gloss on file is [Lemma L157](../findings/second-order.md) line 1254, derived two days later, "branches 1 and 2 are two regimes of the single $f(u)=(c_p+u^2)/(S+au)$ with $a\propto(1-\eta)^{-2}$", which gives a proportionality and no constant. §5 shows the constant is exactly what decides the lemma.

**Where $f$ is minimised: interior, always, and L147's algebra for it is correct.** Verified in §5. **So the pre-registered question's first half is answered in the lemma's favour, and its second half against the lemma.**

**And the record carries branch 1 in two incompatible forms, in one file.**

| line | form of branch 1 | minimiser |
|---|---|---|
| 1202 ([Lemma L149](../findings/second-order.md)'s chain display) | $(c_p+w^2)/S$ | $w=0$ |
| 1262 ([Lemma L158](../findings/second-order.md)) | $(c_p+w^2)/S$, "increasing in $w$ with infimum $\kappa/(nS)$" | $w=0$ |
| 1360 ([Lemma L151](../findings/second-order.md)'s box) | "branch $1$, $c_p/S$" | $w=0$ |
| 1173 (**L147**) | $(c_p+u^2)/(S+au)$ | interior $u^*>0$ |
| 1254 ([Lemma L157](../findings/second-order.md)) | $(c_p+u^2)/(S+au)$, $a\propto(1-\eta)^{-2}$ | interior |
| 1282 ([Lemma L158](../findings/second-order.md)'s box) | "*Branch 1 is not $(c_p+w^2)/S$*" | interior |

The two forms differ by the presence of $au$ in the denominator. **Nothing in [findings/](../findings/) derives either form from the chain.** The $/S$ form is what the chain display at line 1202 asserts; the $S+au$ form is asserted against it, at line 1282, as "the chain's own form", citing L147 and L157, that is, citing the two entries that assert it. This is the debt.

## 5. The $f$-algebra, reproduced exactly, and the contradiction it creates with the headline

**Locate.** Line 1173: "$f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=-ac_p/S^2<0$ … the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$, at every $\beta$ and every $a$."

**Every clause checks, by hand.** With $c_p,S,a>0$,
$$f'(u)=\frac{2u(S+au)-a(c_p+u^2)}{(S+au)^2}=\frac{au^2+2Su-ac_p}{(S+au)^2},$$
so $f'(0)=-ac_p/S^2<0$; the numerator is an upward parabola in $u$ with a single positive root
$$u^*=\frac{-2S+\sqrt{4S^2+4a^2c_p}}{2a}=\frac{\sqrt{S^2+a^2c_p}-S}{a},$$
and at it $2u^*(S+au^*)=a(c_p+u^{*2})$, whence $f(u^*)=2u^*/a$. Rationalising,
$$f(u^*)=\frac{2\big(\sqrt{S^2+a^2c_p}-S\big)}{a^2}=\frac{2c_p}{S+\sqrt{S^2+a^2c_p}},$$
and since $\max(S,a\sqrt{c_p})\le S+\sqrt{S^2+a^2c_p}\le3\max(S,a\sqrt{c_p})$,
$$f(u^*)=\Theta\!\left(\frac{c_p}{\max(S,a\sqrt{c_p})}\right)=\Theta\!\left(\min\!\left(\frac{c_p}{S},\frac{\sqrt{c_p}}{a}\right)\right).$$
**Claim 6 is correct in every clause.** Admissibility is fine too: $u^*\le\sqrt{c_p}=O(n^{-1/2})<1$ for every $a>0$, so the interior minimiser lies inside any range of the shape $[0,1]$, and I could not refute the paragraph on range grounds.

**And that is exactly what breaks the headline.** The lemma's headline is $r_n\gtrsim n^{-1-\beta}$ with $c_p=\Theta(1/n)$ and $S=\Theta(n^\beta)$, so $c_p/S=\Theta(n^{-1-\beta})$ while $\sqrt{c_p}/a=\Theta(n^{-1/2}/a)$. The infimum of branch 1 is the **minimum** of the two. Hence

$$\boxed{\ \inf f=\Theta(n^{-1-\beta})\iff a=O(n^{\beta+1/2}),\qquad\text{and }\inf f=\Theta(n^{-1/2}/a)\text{ otherwise.}}$$

**No statement anywhere in [findings/](../findings/) bounds $a$.** L147 says the conclusion holds "at every $\beta$ and **every $a$**", which is precisely the quantifier under which the headline fails.

**Exhibit, in closed form, at a named parameter.** Take $n=12$, $\beta=0$, so $S=\theta_0(12)=\sqrt{55}/6$ and $c_p=3\theta_0/10=\sqrt{55}/20$, and take $a=n=12$, the size the record's own branch-2 denominator $a_0n^{1/2}+nw$ carries at $w=\Theta(1)$.

- $f(0)=c_p/S=(\sqrt{55}/20)(6/\sqrt{55})=6/20=\tfrac3{10}$ exactly, which is also $3/(n-2)$ exactly.
- $a^2c_p=144\cdot\sqrt{55}/20=36\sqrt{55}/5=53.396626\ldots$, $S^2=55/36=1.527\overline{7}$, so $\sqrt{S^2+a^2c_p}=\sqrt{54.924404\ldots}=7.411100\ldots$
- $f(u^*)=2c_p/(S+\sqrt{S^2+a^2c_p})=0.741620/8.647133=0.085765\ldots$, attained at $u^*=(7.411100-1.236033)/12=0.514589\in[0,1]$.

So at $n=12$, $\beta=0$ the interior minimum sits a factor $0.3/0.085765=3.498$ below the $u=0$ value that the headline's $n^{-1-\beta}=n^{-1}$ rests on, and the gap is $2S/(S+\sqrt{S^2+a^2c_p})=\Theta(S/(a\sqrt{c_p}))=\Theta(n^{\beta-1/2})$ for $a\asymp n$, **a factor $\sqrt n$, growing without bound, and exactly the $\sqrt n$ that separates $n^{-1}$ from $n^{-3/2}$.** Under this reading the lemma's body delivers $\Theta(n^{-3/2})$ at every $\beta<\tfrac12$, which is *the same conclusion* that the box immediately above it ("a single mixed direction … restores $n^{-3/2}$ at every $\beta$") declares refuted. **The entry refutes its own refutation, eight lines later, by a different route.**

**Argue the opposite.** The charitable reading is $a=\Theta(1)$: [Lemma L157](../findings/second-order.md)'s $a\propto(1-\eta)^{-2}$ with $(1-\eta^*)^2\to0.808$ has no visible $n$ in it, and under $a=\Theta(1)$ one gets $\sqrt{c_p}/a=\Theta(n^{-1/2})\gg\Theta(n^{-1-\beta})$, so $\inf f=\Theta(c_p/S)=\Theta(n^{-1-\beta})$ and the headline is intact, with the interior minimum costing only the bounded factor $2S/(S+\sqrt{S^2+a^2c_p})\to1$. This reading is available and may well be the intended one. It is not what the entry says: the entry says "every $a$", supplies no constant for the proportionality, and (decisively), [Lemma L158](../findings/second-order.md) line 1282 uses this same form to conclude that branch 1's infimum is "**strictly below** $\kappa/(nS)$", a conclusion which is a bounded-factor correction under $a=\Theta(1)$ and an order-level demolition under $a=\Theta(n)$, with nothing on file distinguishing the two.

**Three-step record: located (line 1173), exhibited (n=12, $\beta=0$, $a=12$, factor $3.498$ growing like $\sqrt n$), opposite argued ($a=\Theta(1)$ rescues it, and is unproven). Finding stands as `HYPOTHESIS-DEBT`: what must be proved is $a=O(n^{\beta+1/2})$, with $a$ first given a definition.**

## 6. The range $\beta\in[0,\tfrac12]$, and the dimension range that is missing

**$\beta\ge0$: PROVEN.** $\theta_0(n)^2=2(n-1)(n-2)/n^2=2(1-3/n+2/n^2)$, whose derivative in $n$ is $2(3n-4)/n^3>0$, so $\theta_0$ increases to $\sqrt2$; at unit norm $P=\theta$, so $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\ge\theta_0(8)=\sqrt{21}/4$. A quantity bounded below by a positive constant and equal to $\Theta(n^\beta)$ forces $\beta\ge0$. The step is correct as written. *(One caveat kept for the record: $\theta_0(n)$ is the balanced value at **even** $n$ only, per [conventions.md](../findings/conventions.md); at odd $n$ the diagonal maximum is $\Theta_n<\theta_0(n)$. Since $n=2m$ throughout, no error arises.)*

**$\beta\le\tfrac12$: PROVEN.** [Lemma L143](../findings/bounds.md) gives $\sup\lvert P\rvert\le1+\sqrt{n-2}=O(n^{1/2})$, at every $n$, on the unit sphere, the same object and normalisation. $\Theta(n^\beta)=O(n^{1/2})$ forces $\beta\le\tfrac12$.

**Is either endpoint attained, forced, or assumed? Assumed, both.** Nothing on file exhibits an $n$-family with $\sup\lvert P\rvert=\Theta(n^{1/2})$, and nothing exhibits one with $\sup\lvert P\rvert=\Theta(1)$. What is on file points the other way: [Lemma L143](../findings/bounds.md)'s own comparison records $\theta_0(12)=1.236$ against the bound $4.162$, "a factor $3.4$ short", and [Post F10](../findings/fence-posts.md) beats the bound at $2.53$. So the interval $[0,\tfrac12]$ is an interval of *admissible* exponents with a witness at neither end, and it may well be the single point $\beta=0$. The headline's "$\beta=\tfrac12$ … is confirmed" means the *conclusion at* $\beta=\tfrac12$ is confirmed by [Lemma L145](../findings/second-order.md), not that $\beta=\tfrac12$ occurs; read that way it is honest, and I record no error, only that the range is decoration on an inequality that never uses it (§1).

**A prior question the range hides: $\beta$ need not exist.** $\sup\lvert P\rvert$ is bracketed between $\Theta(1)$ and $\Theta(n^{1/2})$ and nothing shows it is regularly varying; $\Theta(\log n)$ or $\Theta(\sqrt n/\log n)$ are consistent with everything on file and admit no $\beta$. L147's own closing paragraph says exactly this ("$\sup\lvert P\rvert$ is bracketed rather than known, **so $\beta$ is not an exponent**") while the statement's sole hypothesis posits that it is. The two sentences cannot both be read literally. Charitably the closing paragraph warns against reading the conclusion as an equality; but as written the entry denies its own hypothesis.

**The dimension range, which is absent and which I can pin exactly.** L147 states no floor. Its imports do:

- [Lemma L146](../findings/second-order.md) needs $m\ge5$ for the margin to sit on the $S^2_0$ summands at all.
- The sweep that L147 credits to "both reviewers" and that [Lemma L149](../findings/second-order.md) carries needs $m\ge6$, because $\rho^{\mathrm{eff}}$ is built from $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$ and has no definition where that is negative.
- L149's margin coefficient $3\theta_0\tfrac{m-4}{2(m-1)}$ is **exactly zero at $m=4$** and negative at $m=3$.

The floor is exactly computable: $\theta_0(n)>\sqrt{3/2}\iff2(n-1)(n-2)/n^2>3/2\iff4(n^2-3n+2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915\ldots$, so **$n\ge12$ and no smaller even $n$**. Checked at the boundary: $\theta_0(10)=6/5=1.2<\sqrt{3/2}=1.224744$ and $\theta_0(12)=\sqrt{55}/6=1.236033>\sqrt{3/2}$; at $n=8$, $\theta_0=\sqrt{21}/4=1.145644$, further below.

**Exhibit at the smallest dimension the record admits.** [Lemma L3](../findings/second-order.md) makes the balanced product a local maximum at every even $n\ge8$, so $n=8$ is an object L147's unqualified statement covers. There $m=4$, the margin coefficient $3\theta_0\tfrac{m-4}{2(m-1)}$ is $0$, so the chain has only $c(H)\ge c_p$; branch 2 at $w=1$ is then $\sqrt{c_p}/(a_0n^{1/2}+n)=\Theta(n^{-1/2}/n)=\Theta(n^{-3/2})$, and the $\Omega(n^{-1})$ uniformity fails, and in fact $\lvert\kappa_8\rvert<0$ leaves $\rho^{\mathrm{eff}}$ undefined, so the chain does not even have a domain at $n\in\{6,8,10\}$. **A statement carrying no dimension hypothesis is being read as covering three dimensions at which its own machinery is undefined.**

**Argue the opposite.** The block of entries around L147 works implicitly at $n\ge12$ and says so in the neighbouring lemmas; a reader of the file, rather than of the statement, will not be misled. That is a fair description of practice and no defence of the statement, which is what gets cited.

## 7. $\ker W\ne0$, the recurring obstruction, answered

**It is never stated in L147, it is used, and it holds.** Branches 2 and 3 need $z\mapsto\mathrm{Alt}(W(z)_-)$ holomorphic near $z=0$, which needs $0\notin\mathop{\mathrm{spec}}(W^*)$; the ceiling's third way explicitly invokes $g_n$. At $W^*$ the spectrum is two-valued, $\lambda_-=-g_n$ and $\lambda_+=\tfrac m{m-1}g_n$, both nonzero, with $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}>0$ for $n\ge3$. **So the hypothesis is met, and the brief's trap (that a check run only at a sphere product never reaches it), is not sprung here, because L147 is about a sphere product and nothing else.**

**But the omission is the vector by which it could be sprung.** L147's statement names no base point (§1). $r_n$ read as "the tube radius" at a general critical point immediately meets $\ker W\ne0$: at a degenerate $W$ the map $W\mapsto W_-$ is not analytic, $M$, $\rho$ and $\lVert A''\rVert$ have no definition, and two of the three branches vanish from the argument. [Lemma L149](../findings/second-order.md) states the hypothesis explicitly and discharges it; L147, cited downstream for the same two values, does not. **The repair is one clause: name $W^*$ in the statement.**

## 8. The gap between what is proven and what L147 is cited for

L147 is cited downstream for two things. It gives one of them.

**The $\Theta(n^{-1})$ ceiling, an argument is present, and its arithmetic is exact.** Branch 1 evaluated at a $w=0$ direction is $c_p/S$, and $c_p/S\le c_p/\theta_0=3\theta_0/((n-2)\theta_0)=3/(n-2)$, an identity, not an inequality, so the "$\le$" is safe and the ceiling is $O(n^{-1})$ unconditionally, using only $S\ge\theta_0$ and $c_p=3\theta_0/(n-2)$. A $w=0$ direction exists in the domain for $m\ge3$ (the joint $S^2_0$ eigenspace). **This much is proven.** Two qualifications: the ceiling is on the bound the route yields, not on $r_n$ (§2); and stated as $\Theta(n^{-1})$ it asserts attainment, which L147 does not prove and which [Lemma L149](../findings/second-order.md) later withdraws, "$\Omega$, not $\Theta$ … at $w=0$ the defect vanishes identically, so the branch is **unbounded** there". Of L147's four ways to the ceiling, way 2 ("the corrected quartic branch is $\Theta(n^{-1})$") is the one L148 removes; ways 1, 3 and 4 stand.

**The radius $r_n\gtrsim n^{-1-\beta}$, no argument is present.** The entry contains no chain, no branch display, no infimum and no minimisation. What stands in their place is one sentence: "Both reviewers closed the sweep the lemma owed: $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ … and $c(H)\gtrsim c_p+w^2$ … **It returns these values and the $\Theta(n^{-1})$ ceiling.**" The two inputs are stated; the step from them to $n^{-1-\beta}$, which is the whole content, and which requires the three-branch minimum, the $w$-uniformity and the branch comparison, is asserted, and the asserting sentence attributes it to reviewers. The chain first appears **two entries later**, at line 1202 in [Lemma L149](../findings/second-order.md), whose own repair is marked "itself unaudited" and which closed `GAP` twice. **By the round's own rule this is not evidence: a claim whose argument is "both reviewers derived it" has no argument on file.**

**And the second input is stated upward.** "$c(H)\gtrsim c_p+w^2$" is corrected in L149's own text to $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$ with coefficient $0.741620$ at $n=12$ and $0.946264$ at $n=14$, below $1$ at exactly the two dimensions the programme works at. L147 carries the uncorrected form.

## 9. Withdrawn candidates

**9.1, "the interior minimiser $u^*$ may fall outside the admissible range". Withdrawn.** I looked for a range violation, since an interior stationary point outside $[0,1]$ would make the paragraph vacuous and rescue $w=0$. It does not happen: $\sqrt{S^2+a^2c_p}\le S+a\sqrt{c_p}$ gives $u^*\le\sqrt{c_p}=O(n^{-1/2})$ for **every** $a>0$, so $u^*\in[0,1]$ at every $n\ge3$ and every $a$. The paragraph is safe on this point, and I record it as checked rather than as a finding.

**9.2, "$f'(0)<0$ contradicts branch 1 being increasing, so one of L147 and L149 is wrong". Withdrawn as a *finding*, kept as the debt of §4.** The two functions are different functions: at $a=0$, $f(u)=(c_p+u^2)/S$ has $f'\equiv2u/S\ge0$ and is minimised at $0$; at $a>0$ it is not. Neither entry is wrong *about its own function*. What is missing is the derivation that says which function branch 1 is, and that is `HYPOTHESIS-DEBT`, not a contradiction. Reported that way in §4.

**9.3, "the ceiling clause $c_p/\theta_0\le3/(n-2)$ is wrong". Withdrawn.** It is exact: $c_p=3\theta_0/(n-2)$ by [Lemma L146](../findings/second-order.md), so $c_p/\theta_0=3/(n-2)$ identically. No finding.

**9.4, "$\beta\ge0$ fails because $\theta_0$ is the odd-$n$ value $\Theta_n$". Withdrawn.** [conventions.md](../findings/conventions.md) records the odd/even split and $\Theta_n<\theta_0(n)$ at odd $n$; but $n=2m$ throughout this block, so only the even branch is used and the step is correct. Recorded because the same confusion regrew [Lemma L0](../findings/problem.md)'s refuted constant.

**9.5, "$M=O(\rho)$ is false". Withdrawn as to the order; the *stated reason* is a finding (claim 10).** The order is right and the record has two independent derivations of it. What L147 offers as the reason ("$x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$"), is a statement about **real symmetric** matrices, where $X\mapsto X_-$ is the metric projection onto the negative-semidefinite cone and so is $1$-Lipschitz. But $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is taken on a **complex** circle, where $W^*+zH$ is not real symmetric and $(\cdot)_-$ means the Riesz-projection continuation; the cone projection has no meaning there and its Lipschitz constant does not transfer. The record's own contour section supplies what is actually needed, $M\le C(\alpha,\gamma)\rho$ with $C=\tfrac{1+\alpha}{\alpha-\gamma}$, and the recorded value $M\le\tfrac32g_n=6\rho$ at $(\alpha,\gamma)=(\tfrac12,\tfrac14)$. **A constant of $6$, not of $1$**: so the stated mechanism is not the one that holds, while the order it concludes is right. This is the shape the round brief names (mechanism refuted, order survives) and it is recorded rather than withdrawn.

## 10. What would falsify the statement, and what I did to look for it

**The object that would break it: a value of $a$ growing faster than $n^{\beta+1/2}$, with $u$ ranging over an interval containing $u^*$.** By §5 that gives $\inf f=\Theta(\sqrt{c_p}/a)=o(n^{-1-\beta})$, and the displayed inequality $r_n\gtrsim n^{-1-\beta}$ fails at every $\beta<\tfrac12$, at $a\asymp n$, by a factor $\Theta(n^{1/2-\beta})$, which at $n=12,\beta=0$ is already $3.498$ by the exact evaluation in §5. I could not exhibit such an $a$ **because $a$ has no definition on the record**: that is the finding, and it is why the verdict is `HYPOTHESIS-DEBT` rather than `BROKEN`. Where I looked: every occurrence of the form in [findings/](../findings/) (three: lines 1173, 1254, 1282 of [second-order.md](../findings/second-order.md)), the chain display it is supposed to be a rewriting of (line 1202), the branch-comparison entry that consumes it ([Lemma L158](../findings/second-order.md)), and [conventions.md](../findings/conventions.md), which tables neither $a$ nor $u$ nor $r_n$.

**The parameter value that would break the range clause: an even $n$ with $\theta_0(n)\le\sqrt{3/2}$ at which the statement is nonetheless read.** Those are exactly $n\in\{6,8,10\}$, by $n^2-12n+8>0\iff n>6+2\sqrt7$; and [Lemma L3](../findings/second-order.md) puts admissible objects at $n=8$ and $n=10$. At $n=8$ the margin coefficient $3\theta_0\tfrac{m-4}{2(m-1)}$ is exactly zero and $\lvert\kappa_8\rvert=9(\sqrt{21}/4-\sqrt{3/2})<0$ leaves $\rho^{\mathrm{eff}}$ undefined. **The statement covers these dimensions and its machinery does not.**

**The object that would break the $\ker W$ clause: a critical point with $0\in\mathop{\mathrm{spec}}(W)$, read as an instance of "$r_n$".** It cannot be constructed *against L147 as intended*, because L147 is about $W^*$ alone, where the spectrum is $\{-g_n,\tfrac m{m-1}g_n\}$. It can be constructed against L147 *as written*, because the statement names no base point. I looked at the structured families the record names (the balanced product, $\mathbb{CP}^m$, the four-set family, the diagonal $S=0$ points) and note that the last of these is exactly where the record records degeneracy; none of them is excluded by anything L147 says.

---

*`HYPOTHESIS-DEBT`. What must be proved, in order of weight: **(i)** a derivation of branch 1's form from the chain, with $u$ and $a$ defined, and a bound $a=O(n^{\beta+1/2})$, without which the entry's own §5 gives $n^{-3/2}$ where its headline gives $n^{-1-\beta}$; **(ii)** the minimisation step from the two stated inputs to $r_n\gtrsim n^{-1-\beta}$, which is asserted and attributed rather than written; **(iii)** the dimension floor $n\ge12$, i.e. $n>6+2\sqrt7$, and the base point $W^*$, the direction domain and $\ker W^*=0$, all named in the statement. What survives unconditionally: the ceiling as $O(n^{-1})$, via the identity $c_p/\theta_0=3/(n-2)$; the range endpoints $\beta\ge0$ and $\beta\le\tfrac12$; and the $f$-algebra of §5, every clause of which is exact.*
