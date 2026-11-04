# VERIFY v50, L145: the boxed $\Theta(n^{-3/2})$ has no upper half, the entry's own closing box draws $\lVert A''\rVert=O(1)$ from a premise that does not give it, and $\inf_H c(H)/C(H)$ is $0$ as written

**Cold brief.** The fenced statement in [ROUND_L145.md](ROUND_L145.md) was read first with provenance stripped, and every input was then checked at its own source, [findings/second-order.md](../findings/second-order.md):1098–1180 for L145, L146 and L147, [results.md](../results.md):355 for L156's canonical contour constant, [findings/conventions.md](../findings/conventions.md):95 for the sign of $W_-$ and for $\mathrm{Alt}$, [findings/problem.md](../findings/problem.md):19–68 for $\theta_0(n)$ and the $n\ge12$ threshold, [findings/INDEX-results.md](../findings/INDEX-results.md):163–168, [plan.md](../plan.md):66 and [plan-verification.md](../plan-verification.md):142. **No numerical work of any kind was done**: no script was run, nothing under [scripts/](../scripts/) was opened, and every value below is a closed form or an exact hand evaluation. Log: [agent_logs/verify-L145-v50.log](../agent_logs/verify-L145-v50.log). *One disclosure: a repository-wide grep for the string L145 returned single matched lines from other verifiers' files; no such file was opened, and every derivation below is from the primary sources named above.*

## Claim table

| # | claim, as the entry states it | verdict |
|---|---|---|
| C1 | **LEMMA L145.** the tube radius about $SO(n)\cdot W^*$ is $r_n=\Theta(n^{-3/2})$ | **BROKEN as a $\Theta$**, the upper half is argued nowhere in the entry, nowhere in L146–L158, and the entry's own step-4 row withdraws it |
| C2 | step 1, the spectrum is two-valued with no kernel, $g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\Theta(1/n)$ | **CONFIRMED**, re-derived exactly from $S^m\times S^m$ in §2, every $m\ge2$ |
| C3 | step 2, $W\mapsto W_-$ analytic on the ball of radius $g_n$; the complex radius must be $\rho<g_n/2$ | **CONFIRMED as stated**, with the strictness correct; the analyticity itself is imported, not proved here |
| C4 | step 3, $C_\delta=O(n^3)$ is **REFUTED**; the corrected constant is $C_\delta=O(n)$ | **CONFIRMED on the direction-blind disc $\rho=\Theta(g_n)$**, and only there; every numeral in the chain reproduced in §3 |
| C5 | $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$, first term vanishing at $A(0)=\mathrm{Alt}(W^*_-)=0$ | **CONFIRMED**, Leibniz exact and $\mathrm{Alt}(W^*_-)=0$ verified in the record's own sign convention |
| C6 | step 4 ($r_n=\Omega(n^{-3/2})$ | **HYPOTHESIS-DEBT**), the order is right against the record, but no derivation of it exists in L145; the minimisation that produces it is written down two entries later |
| C7 | "$n^{-3/2}$ is $\inf_H c(H)/C(H)$, **which is what a tube radius is**" | **BROKEN as written**, with $H$ unrestricted the infimum is exactly $0$; orbit directions are never excluded (§5) |
| C8 | "$n^{-4}$ is $c_n$ over the retracted $C_\delta$; $n^{-2}$ is $c_n/\sup_H C(H)$" | **GAP**, three equalities stated where only three upper bounds on the constants are on file; all three exponents are one-sided (§6) |
| C9 | the per-direction-to-neighbourhood trap is not committed; the geodesic segments **fill** the tube and no normal-injectivity hypothesis is owed | **CONFIRMED, and for a better reason than the entry gives** (§7) |
| C10 | closing box, on the margin summand $\lVert H\rVert_{op}=O(n^{-1/2})$, **so $\lVert A''\rVert=O(1)$ rather than $O(n)$** | **BROKEN**, the inference is invalid by $\sqrt n$; the premise gives $\lVert A''\rVert=O(n^{1/2})$ (§4) |
| C11 | closing box, "**[I31](../plan.md) buys an exponent, not a constant**" | **REFUTED by the record's own later adjudication**, re-derived by hand from L147's $f(u)$ in §4.3 |
| C12 | [results.md](../results.md) carries no L145 entry | **the absence is CORRECT for the headline and WRONG for the parts** (§9) |

**One line the round can act on.** L145 proves its spectral step and its constant-repair and proves neither direction of its own headline: the upper half of the $\Theta$ exists nowhere in the record, the lower half is asserted here and derived two entries later, and the entry's final box, the one that withdrew the equality and told the programme that [I31](../plan.md) buys an exponent, rests on an inference that is wrong by $\sqrt n$ and on a conclusion [ROUND_L149-F](ROUND_L149F.md) has since refuted.

## 0. Conventions, fixed once

- $W^*$ is the Weyl curvature of $S^m\times S^m$ at $n=2m$, normalised to $\lVert W^*\rVert_F=1$. $V_1,V_2$ are the two $m$-dimensional factors; $B_1,B_2$ their index sets.
- The Weyl operator acts on $\Lambda^2\mathbb R^n$, $\dim\Lambda^2=\binom n2$. $\lVert\cdot\rVert_F$ is the Frobenius norm on that space, $\lVert\cdot\rVert_{op}$ the operator norm, and $\lVert X\rVert_F\ge\lVert X\rVert_{op}$ always.
- $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, the positive-semidefinite magnitude of the negative part, [findings/conventions.md](../findings/conventions.md):95, where the sign is recorded as forced rather than chosen.
- $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, so $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$ and $\mathrm{Alt}(H)=0$ for every $H$ satisfying the first Bianchi identity, same source.
- $A(z)=\mathrm{Alt}(W(z)_-)$ along $W(z)=W^*+zH$ with $\lVert H\rVert_F=1$; $\delta^2=\langle A,A\rangle$; $\rho$ the radius of the disc in $z$; $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$. **None of these six symbols is defined in L145.**
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ ([findings/problem.md](../findings/problem.md):21), increasing to $\sqrt2$; $c_p=3\theta_0(n)/(n-2)$; $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$.

## 1. The hypothesis inventory

**Carried by the statement.**

| # | hypothesis | checked against |
|---|---|---|
| H1 | the base point is $W^*=S^m\times S^m$ | **stated, and stated well**, L145 is the one entry in this block whose conclusion is anchored to a named base point in its own sentence |
| H2 | $n=2m$, so $n$ even | stated; odd $n$ is out of scope, and [findings/problem.md](../findings/problem.md):68 records that $\theta_0$ is attained only at even $n$ |
| H3 | $\lVert W^*\rVert_F=1$ | **unstated and load-bearing**: $g_n$'s closed form is the normalised eigenvalue and is meaningless without it (§2) |
| H4 | there is a "penalised functional", with a "tube radius" | **named, never defined.** The penalty $-\kappa_n\delta^2$ that its imports need appears nowhere in the entry |

**Used by the written proof and not stated.**

| # | hypothesis | status at the object |
|---|---|---|
| H5 | $\ker W^*=0$ | **holds**, and here it is a computed fact rather than a debt, step 1 proves it (§2). It is the hypothesis of step 2's analyticity, and step 2 does not name it |
| H6 | $\lambda_+>\lvert\lambda_-\rvert$, so that $g_n=\lvert\lambda_-\rvert$ **is** $\mathop{\mathrm{dist}}(\mathop{\mathrm{spec}},0)$ | **holds at every $m\ge2$**: $\lambda_+/\lvert\lambda_-\rvert=m/(m-1)$ (§2). Never remarked on |
| H7 | $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ | **absent, and its absence is fatal to the displayed formula**, see §5, where the unrestricted infimum is $0$ |
| H8 | a dimension floor | **no range whatever is stated.** Step 1 is honest at $m\ge2$; the closing box imports L146, which needs $m\ge3$ and whose margin-summand clause needs $m\ge5$; the surrounding programme needs $n\ge12$ (§8) |
| H9 | the record's $W_-$ sign and $\mathrm{Alt}$ normalisation | **holds**, checked at [findings/conventions.md](../findings/conventions.md):95, and the entry's $W^*_-$ formula is right in that convention, sign included (§3.3) |

**Hypotheses of the results L145 imports.**

| import | its hypotheses | met? |
|---|---|---|
| [Lemma L146](../findings/second-order.md), $\lVert H\rVert_{op}=O(n^{-1/2})$ on the margin summand | $H$ the Weyl image of a **single** $h\in S^2_0(\mathbb R^m)$; $m\ge3$; $m\ge5$ for the margin to sit on that summand | the single-copy qualifier is **not carried across** into L145's box. It happens not to bite: on the joint two-copy eigenspace L146's equality clause fails but its supremum is unchanged, the cross branch capping at $\sqrt{m-2}/m<1/\sqrt{m-1}$, an inequality equivalent to $(m-1)(m-2)<m^2$, i.e. $-3m+2<0$, true at every $m\ge1$. **No finding, recorded as checked.** $m\ge5$ is not carried across either, and that one does bite (§8) |
| analyticity of $W\mapsto W_-$ on a spectral disc | $\ker W^*=0$; a contour separating $\lambda_-$ from $\lambda_+$ and from $0$ | met at $W^*$; the result itself is imported without a source and re-proved only at [Lemma L156](../results.md), a later entry |
| the Cauchy estimate | the **closed** disc of radius $\rho$ inside the domain of analyticity | met, and this is exactly what the entry's own correction "$\rho<g_n/2$, not $\rho=g_n/2$" secures |

**No finding on one point worth stating positively.** Every ingredient the entry uses on the input side is uniform in $H$, using only $\lVert H\rVert_F=1$, exactly as its box claims. The Cauchy radius $\rho<g_n/2$ is direction-blind by construction, so nothing in steps 1–3 has a hidden per-direction quantifier.

## 2. Step 1 re-derived from the metric, and it is exact

$S^m\times S^m$ with unit round factors has $R=\tfrac12(g_p\owedge g_p+g_q\owedge g_q)$, sectional curvature $1$ on planes inside a factor and $0$ on mixed planes, so as an operator on $\Lambda^2$, $R$ is the projection onto $\Lambda^2V_1\oplus\Lambda^2V_2$. Then $\mathrm{Ric}=(m-1)g$, $\mathrm{Ric}_0=0$, $s=2m(m-1)$, and since $\tfrac12g\owedge g=\mathrm{id}$,

$$W^*_{\text{unnorm}}=R-\frac s{2n(n-1)}g\owedge g=R-\frac{m-1}{2m-1}\,\mathrm{id}.$$

Its spectrum is therefore two-valued:

$$\lambda_+=1-\frac{m-1}{2m-1}=\frac m{2m-1}\ \ (\text{multiplicity } 2\tbinom m2=m(m-1)),\qquad \lambda_-=-\frac{m-1}{2m-1}\ \ (\text{multiplicity } m^2),$$

with trace $\big(m(m-1)m-m^2(m-1)\big)/(2m-1)=0$, as a Weyl tensor must have. Hence

$$\lVert W^*_{\text{unnorm}}\rVert_F^2=\frac{m^2(m-1)}{(2m-1)^2}\big[m+(m-1)\big]=\frac{m^2(m-1)}{2m-1},$$

and at unit Frobenius norm

$$\lvert\lambda_-\rvert=\frac{m-1}{2m-1}\cdot\frac{\sqrt{2m-1}}{m\sqrt{m-1}}=\frac{\sqrt{m-1}}{m\sqrt{2m-1}}.$$

Against the entry's closed form at $n=2m$: $\ \tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\tfrac1m\sqrt{\tfrac{2m-2}{2(2m-1)}}=\tfrac{\sqrt{m-1}}{m\sqrt{2m-1}}$. **Exact match.** At $n=12$ both read $\sqrt{55}/66$.

**No kernel, and $g_n$ is the distance to $0$.** Both eigenvalues are non-zero at every $m\ge2$, and $\lambda_+/\lvert\lambda_-\rvert=\tfrac m{2m-1}\cdot\tfrac{2m-1}{m-1}=\tfrac m{m-1}>1$, so $\mathop{\mathrm{dist}}(\mathop{\mathrm{spec}}W^*,0)=\lvert\lambda_-\rvert=g_n$. **C2 CONFIRMED**, including the "no kernel" clause, at every $m\ge2$.

**The order.** $g_n=\tfrac{\sqrt{m-1}}{m\sqrt{2m-1}}\sim\tfrac1{m\sqrt2}=\tfrac{\sqrt2}n$, so $g_n=\Theta(1/n)$. **CONFIRMED.**

## 3. The constant repair, checked numeral by numeral

### 3.1 The Cauchy ladder

With $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$ and $\rho=\Theta(g_n)=\Theta(1/n)$, Cauchy gives $\lVert A^{(k)}(0)\rVert\le k!\,M\rho^{-k}$. Substituting $M=O(g_n)$:

$$\lVert A^{(k)}\rVert=O\!\big(g_n\cdot n^k\big)=O(n^{k-1}),$$

so $\lVert A'\rVert=O(1)$, $\lVert A''\rVert=O(n)$, $\lVert A'''\rVert=O(n^2)$. **The entry's $\lVert A^{(k)}\rVert=O(n^{k-1})$ is CONFIRMED**, and it is a statement about the direction-blind disc $\rho<g_n/2$ and about no other.

Substituting the alternative $M=O(1)$: $\lVert A^{(k)}\rVert=O(n^k)$, so $A'''=O(n^3)$, **the entry's rank-spent branch, CONFIRMED.**

### 3.2 The third derivative of $\delta^2$

$\delta^2=\langle A,A\rangle$ gives $(\delta^2)'=2\langle A',A\rangle$, $(\delta^2)''=2\langle A'',A\rangle+2\langle A',A'\rangle$, and

$$(\delta^2)'''=2\langle A''',A\rangle+2\langle A'',A'\rangle+4\langle A'',A'\rangle=2\langle A''',A\rangle+6\langle A'',A'\rangle.$$

**Exact; C5's identity CONFIRMED.** With $A(0)=0$ the first term vanishes and $C_\delta=6\langle A'',A'\rangle=O(n)\cdot O(1)=O(n)$. **CONFIRMED.** On the rank-spent branch the same second term is $O(n^2)\cdot O(n)=O(n^3)$, so the retracted $O(n^3)$ is CONFIRMED as the value of the *other* branch, which is the entry's own account of why the two figures differ.

### 3.3 $A(0)=\mathrm{Alt}(W^*_-)=0$

By §2 the negative eigenspace is the cross-plane space $V_1\wedge V_2=\Lambda^2\ominus(\Lambda^2V_1\oplus\Lambda^2V_2)$, so under $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$,

$$W^*_-=\lvert\lambda_-\rvert\big(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2}\big),$$

**exactly as the entry writes it, sign included**, I checked the sign against [findings/conventions.md](../findings/conventions.md):95 rather than assuming it, because the opposite convention would have flipped it. Each of $\mathrm{id}=\tfrac12g\owedge g$, $P_{\Lambda^2V_1}=\tfrac12g_1\owedge g_1$ and $P_{\Lambda^2V_2}=\tfrac12g_2\owedge g_2$ is a Kulkarni–Nomizu product of a symmetric $2$-tensor with itself, hence satisfies the first Bianchi identity, hence is annihilated by $\mathrm{Alt}$. **The entry's "three Bianchi tensors" justification is CONFIRMED**, and its parenthetical that this is genuinely about $W^*_-$ and not merely about $W^*$ is right: $\mathrm{Alt}(W^*)=0$ holds for every Weyl tensor and would say nothing about the negative part.

### 3.4 Where the norm is spent, and whether it is worth $n^2$

$\lVert X\rVert_F\le\sqrt{\mathop{\mathrm{rank}}X}\,\lVert X\rVert_{op}$ with $\mathop{\mathrm{rank}}\le\binom n2$, and

$$\sqrt{\tbinom n2}\;g_n=\sqrt{\frac{n(n-1)}2}\cdot\frac2n\sqrt{\frac{n-2}{2(n-1)}}=\frac2n\cdot\frac{\sqrt{n(n-2)}}2=\sqrt{1-\frac2n}.$$

So the rank conversion costs **exactly** $\sqrt{1-2/n}\big/g_n$, and the entry's $\sqrt{\binom n2}\asymp1/g_n$ is CONFIRMED to leading order with the constant tending to $1$ from below. Spending it turns $M=O(g_n)$ into $M=O(1)$ and, by §3.1, $A'''$ into $O(n^3)$. **The accounting closes:** $C_\delta$ moves from $O(n^3)$ to $O(n)$, a factor $n^2$, and $r=c_n/C_\delta$ moves from $\Theta(1/n)/O(n^3)=n^{-4}$ to $\Theta(1/n)/O(n)=n^{-2}$, the same factor $n^2$. **"It is worth $n^2$" CONFIRMED.**

**The one step I could not reproduce.** The entry's route to $M=O(g_n)$ is the single clause "*through $\lVert ABC\rVert_2\le\lVert A\rVert_\infty\lVert B\rVert_2\lVert C\rVert_\infty$*". That inequality is true (Hölder for Schatten norms), but the entry never writes the object it is applied to, never exhibits a contour, and never says what $A$, $B$, $C$ are. The step is asserted with its tool named. **Recorded as an exposition gap rather than an error**, because the value $M=O(g_n)$ is independently available at $\rho=\Theta(g_n)$ from $A(0)=0$, $\lVert\mathrm{Alt}\rVert\le1$ and the $1$-Lipschitzness of $x\mapsto x_-$, a route written down at [Lemma L147](../findings/second-order.md), one entry later, and from the explicit contour computation at [Lemma L156](../results.md), eleven entries later. **Both copies of the argument for L145's step 3 live after L145.**

## 4. The closing box, which is where the entry breaks

### 4.1 Locate it

The entry's last box reads:

> *On the summand carrying the margin, $\lVert H\rVert_{op}=O(n^{-1/2})=o(1)$, which is the test [a prior review] set. So $\lVert A''\rVert=O(1)$ rather than $O(n)$ (the input [the other review] named as its own point of failure), the defect branch stops capping, and the radius below becomes a lower bound with an exponent of room in it rather than an equality.* **[I31](../plan.md) buys an exponent, not a constant.**

### 4.2 Exhibit the failure concretely

$M$ is a supremum **over the disc**, so enlarging the disc enlarges it. The entry's own step 2 fixes the disc at $\rho<g_n/2$, i.e. $\rho=\Theta(n^{-1})$, and it is on that disc (and only on that disc) that $M=O(g_n)$ and hence $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n)$. The closing box then invokes L146 to enlarge the disc: with $\lVert H\rVert_{op}=\Theta(n^{-1/2})$ the analyticity radius in $z$ becomes $\rho=\Theta\!\big(g_n/\lVert H\rVert_{op}\big)=\Theta(n^{-1}/n^{-1/2})=\Theta(n^{-1/2})$. Carrying $M=O(\rho)$ across the enlargement:

$$\lVert A''\rVert=O\!\big(M/\rho^2\big)=O(1/\rho)=O(n^{1/2}).$$

**Not $O(1)$. The box is wrong by $\sqrt n$ at the very direction it names.** To reach $O(1)$ one needs $M$ to stay at $O(g_n)$ while $\rho$ grows to $\Theta(n^{-1/2})$, and that needs $\lVert H\rVert_{op}=O(g_n)=O(n^{-1})$, which is a full power of $n$ stronger than what L146 delivers. [Lemma L146](../findings/second-order.md)'s own text says so in as many words: *"It meets only the weaker $o(1)$ wording of [the] test; the mechanism [it] names needs $\lVert H\rVert_{op}=O(g_n)$, which this does not give."* [Lemma L147](../findings/second-order.md) states the correction as a headline: *"THE SUBSTITUTION $\lVert A''\rVert=O(1)$ IS WRONG BY $\sqrt n$, AND BOTH REVIEWERS DERIVED THE SAME REPLACEMENT."*

### 4.3 The conclusion drawn from it is refuted too

The box's payload is that [I31](../plan.md), showing $\sup\lvert P\rvert=\Theta(1)$, i.e. $\beta=0$, buys an exponent. Take the record's own branch function, [Lemma L147](../findings/second-order.md)'s $f(u)=(c_p+u^2)/(S+au)$ with $S=\sup\lvert P\rvert$ and $a=\lVert A''\rVert$. Then $f'(0)=-ac_p/S^2<0$, the minimum is interior at $u^\star=(\sqrt{S^2+a^2c_p}-S)/a$, and $f(u^\star)=2u^\star/a=\Theta\!\big(\min(c_p/S,\ \sqrt{c_p}/a)\big)$. Put $\beta=0$, so $S=\Theta(1)$, and the record's $a=\Theta(n)$, $c_p=\Theta(1/n)$:

$$\min\Big(\frac{\Theta(1/n)}{\Theta(1)},\ \frac{\Theta(n^{-1/2})}{\Theta(n)}\Big)=\min\big(n^{-1},\,n^{-3/2}\big)=\Theta(n^{-3/2}).$$

**Even at $\beta=0$ the chain returns $n^{-3/2}$, not $n^{-1}$.** This is [ROUND_L149-F](ROUND_L149F.md)'s F12 verdict, upheld unanimously and recorded at [plan-verification.md](../plan-verification.md):142 (*"too large on all of $\beta\in[0,\tfrac12)$ … it is replaced by $r_n\gtrsim n^{-3/2}$"*) and it is the position of the reviewer the box decided **against**. So the box's conclusion, "I31 buys an exponent, not a constant", is false against the record, and the exponent turns out to be pinned by $(c_p=\Theta(1/n),\lVert A''\rVert=O(n))$ alone, exactly as the losing side of the disagreement said.

**And a third blow to the same box.** [Lemma L148](../findings/second-order.md) proves the defect vanishes identically on the very summand the box computes on, so (in L146's own words), *"the operator norm computed here prices a quantity that is not present"*. The box's premise is not merely too weak; it is measured on a summand where the quantity it is meant to control is zero.

### 4.4 Argue the opposite

The most charitable reading is that the box is holding $M=O(g_n)$ fixed as a property of $A$ rather than of the disc, and asking only how $\rho$ moves. On that reading $\lVert A''\rVert=O(g_n/\rho^2)=O(n^{-1}/n^{-1})=O(1)$ and the box is arithmetically right. **That reading is available and it is the one the record has already adjudicated against, twice**, when two reviewers on the same question split by exactly this $\sqrt n$ and two further reviewers resolved it for the growing supremum on the ground that a Cauchy supremum over a larger disc is larger and that $x\mapsto x_-$ is $1$-Lipschitz. Nothing on file bounds $M$ by $O(g_n)$ on a disc of radius $\Theta(n^{-1/2})$. **The finding stands.**

## 5. The displayed definition of the tube radius is $0$ as written

**Locate it.** *"$n^{-3/2}$ is $\inf_H c(H)/C(H)$, **which is what a tube radius is**."*

**Exhibit the failure.** The infimum carries no restriction on $H$ anywhere in the entry, indeed the box two paragraphs later insists that *"every ingredient is uniform in $H$, Cauchy using only $\lVert H\rVert=1$"*, which reads as a claim that no restriction is needed. Take $H$ a unit vector in $T_{W^*}\mathcal O$, the tangent space to the orbit $SO(n)\cdot W^*$. The functional is $SO(n)$-invariant, so its restriction to the orbit is constant, the margin along $H$ is $c(H)=0$, and $c(H)/C(H)=0$. Hence $\inf_H c(H)/C(H)=0$, not $\Theta(n^{-3/2})$. The same happens along $H\propto W^*$ under any scale normalisation.

**Argue the opposite.** The entry plainly intends the infimum over the normal directions, that is what a tube radius is about an orbit, and [ROUND_L147](ROUND_L147.md) later wrote $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ into the neighbouring entry as previously unstated hypotheses. So this is an omission, recoverable by a reader who knows the setting, and **not** a false theorem.

**Why it is a finding anyway.** It is an omission in the single formula the entry offers as its *definition* of the object in its own title, in an entry that has never been read, and whose consumers include eight later entries. And the direction of the omission is the unsafe one: adding the restriction raises the infimum, so a reader who takes the formula literally cannot even recover the order by being conservative. **GAP, not withdrawn.**

**A second scope debt in the same formula.** The record's own treatment of this infimum is over **two** parameters, [Lemma L147](../findings/second-order.md) sweeps $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ against $c(H)\gtrsim c_p+w^2$, so the admissible pairs $(c(H),C(H))$ form a two-dimensional region. L145 writes a one-parameter infimum and characterises the region nowhere. Its value therefore cannot be evaluated from anything in L145.

## 6. The three exponents: three upper bounds presented as three equalities

The taxonomy paragraph is the entry's best paragraph and its equalities are still one-sided. Each of $n^{-4}$, $n^{-2}$ and $n^{-3/2}$ is a *quotient of a margin by a cubic constant*, and every constant on file is an upper bound:

- $C_\delta=O(n^3)$ and $C_\delta=O(n)$ are Cauchy **upper** bounds. A matching lower bound would need a lower bound on $\lVert A''\rVert\,\lVert A'\rVert$ at some direction, and [Lemma L147](../findings/second-order.md) records that no such bound exists, *"it needs a **lower** bound on $\lVert A''\rVert$, and [L148](../findings/second-order.md) sets that to zero on the very summand."*
- So $c_n/\sup_HC(H)\ \gtrsim\ n^{-2}$, and the entry's "$n^{-2}$ **is** the direction-uniform quotient" is a $\gtrsim$ dressed as an $=$.
- The ordering the paragraph relies on is nonetheless sound: $\inf_H\big[c(H)/C(H)\big]\ \ge\ \big(\inf_Hc(H)\big)/\big(\sup_HC(H)\big)$, and $n^{-3/2}>n^{-2}$ is the right side of that inequality. **The entry does not distribute a $\min$ across a shared variable, and it does not invert the inequality. No finding on the quantifier order itself**, this is the one place in the block where the distinction is handled explicitly and handled right.

## 7. The per-direction-to-neighbourhood box, confirmed, on a better ground

The box claims the geodesic segments from the orbit **fill** the tube by invariance, so nothing is extended from rays and no normal-injectivity hypothesis is owed. **This is correct, and invariance is not what makes it correct.** The ambient $\mathcal W_n$ is a finite-dimensional inner-product space and $\mathcal O=SO(n)\cdot W^*$ is compact, so every $X$ with $\mathop{\mathrm{dist}}(X,\mathcal O)<r$ has a nearest point $p\in\mathcal O$, and $X-p$ is orthogonal to $T_p\mathcal O$ by first-order optimality. The "geodesics" are straight segments; the tube is filled by normal segments of length $<r$ with no hypothesis at all. Normal **injectivity** would be needed only for a foot point that is unique, and a lower bound on the radius does not need uniqueness. **C9 CONFIRMED.**

*What invariance genuinely supplies* is that the per-direction estimate proved at $W^*$ transports to $gW^*$ in direction $gH$, so the infimum need be taken at one orbit point. That is also true and also unstated.

## 8. The edges of every range

- **Smallest admissible dimension: none is stated, and three different floors are in play.** Step 1 is honest at $m\ge2$ (§2). The closing box imports [Lemma L146](../findings/second-order.md), whose statement requires $m\ge3$ and whose margin-summand identification requires $m\ge5$. The programme around it requires $n\ge12$. **L145 states no floor**, so as written it asserts its conclusion at $n=4$, where $\theta_0(4)=\sqrt{12}/4=\sqrt3/2\approx0.866$ and the ambient invariance the penalised functional is built on provably fails ([findings/problem.md](../findings/problem.md):66).
- **The crossover $n=6+2\sqrt7$.** $\theta_0(n)^2-\tfrac32=\frac{4(n-1)(n-2)-3n^2}{2n^2}=\frac{n^2-12n+8}{2n^2}$, whose roots are $6\pm2\sqrt7$, and $6+2\sqrt7=11.2915\ldots$ **L145 asserts nothing at the crossover and does not know it exists.** The consequence is concrete and adverse at $n=10$: $\theta_0(10)^2=\tfrac{2\cdot9\cdot8}{100}=1.44<\tfrac32$, so the reach parameter $\lvert\kappa_n\rvert$ that the block's later entries build on is negative there and $\rho^{\text{eff}}$ has no definition, yet nothing in L145 excludes $n=10$.
- **Odd $n$.** Out of scope by H2, and correctly so. Worth stating positively: the $\Theta$ in the title is an asymptotic in $n$ that is only ever evaluated along the even subsequence.
- **$\ker W\ne0$, and the named witness $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$.** **L145 asserts nothing at any point with a kernel, and this is the entry's cleanest hypothesis behaviour in the block.** Its statement names its base point in its own sentence, and its step 1 *proves* $\ker W^*=0$ rather than assuming it. At $W_{\mathbb{CP}^2}$, padded, kernel $63$ of $66$ at $n=12$ ([findings/INDEX-traps.md](../findings/INDEX-traps.md):22), there is no $g_n$, $W\mapsto W_-$ is not analytic, and $A''$ has no definition; L145 makes no claim there and must not be read as making one. **The one thing to watch** is that its conclusion is written as the bare symbol "$r_n$", carrying no $W$, so the symbol travels to consumers stripped of the base point that the sentence around it supplies. That is what happened at [Lemma L147](../findings/second-order.md), whose round faulted it for exactly this.

## 9. The missing canonical form, is the absence correct?

**Correct as to the headline; wrong as to the parts.**

- **Correct**: [results.md](../results.md) is the canonical-form file, and the canonical form of L145 would be "$r_n=\Theta(n^{-3/2})$", a statement whose upper half exists nowhere and which the entry's own step-4 row withdraws. Canonising it would have put a refuted equality into the record's most-quoted file. The absence protects the record.
- **Wrong**: what does survive is consumed everywhere and canonised nowhere. $g_n$'s closed form, the two-valued spectrum with $\ker W^*=0$, $W^*_-$'s three-Bianchi form and $\mathrm{Alt}(W^*_-)=0$, and $C_\delta=O(n)$ are each cited by several later entries, and each is re-derived in this report as correct. **A reader looking them up in [results.md](../results.md) finds nothing.**
- **And the withdrawn $\Theta$ is canonised anyway, twice, outside that file.** [findings/INDEX-results.md](../findings/INDEX-results.md):164 reads *"Gate 2 passed … the balanced-orbit tube radius is $\Theta(n^{-3/2})$"*, and [plan.md](../plan.md):66 reads *"(iii) remainder: DONE, Lemma L145, Gate 2 passed, the radius is $\Theta(n^{-3/2})$"*. Both state as a passed result the equality the entry itself retracted three lines below its own box. **The absence in [results.md](../results.md) is therefore not the record's protection at all; the claim is loose in two other index files.**

## 10. The pre-registered questions

### Q1, is $\Theta(n^{-3/2})$ proved in both directions?

**No. One direction only, and it is the lower one.**

- **Lower, $r_n=\Omega(n^{-3/2})$**: **not proved in L145**, and right against the record. L145 asserts it as step 4 and offers no derivation, no $f(u)$, no admissible region, no minimisation. The derivation exists at [Lemma L147](../findings/second-order.md) and its adjudication at [ROUND_L149-F](ROUND_L149F.md); both are later entries. I re-derived the value by hand in §4.3 from L147's formula and it is $\Theta(n^{-3/2})$ at every $\beta\in[0,\tfrac12]$. **`HYPOTHESIS-DEBT` on this half, taken alone.**
- **Upper, $r_n=O(n^{-3/2})$**: **absent everywhere.** Nothing in L145 or in L146–L158 bounds $r_n$ from above. The only "$\le$" on file is [Lemma L147](../findings/second-order.md)'s $\Theta(n^{-1})$ ceiling, proved by $c_p/S\le c_p/\theta_0=3/(n-2)$, and that is a cap on **what this route can prove**, not a bound on the radius. A cap on a method is not an upper bound on the object.
- **Does the entry distinguish them?** **Its step table does, and its statement does not.** The table says "$r_n=\Omega(n^{-3/2})$, **CONFIRMED as a lower bound**. *The equality reading is withdrawn*". The boxed LEMMA and the section title both say $\Theta$. **A lemma is its statement**, and this statement claims a two-sided bound of which one side has no argument on file. That is what makes C1 `BROKEN` rather than `GAP`.
- **And the withdrawal's stated reason has since failed, without restoring the equality.** The table withdraws the equality because *"[L146](../findings/second-order.md) removes its support, and $\Theta(n^{-1})$ is reachable"*. L146's own entry disclaims settling the question, and [ROUND_L149-F](ROUND_L149F.md) refutes the reachability of $n^{-1}$. So both halves of the reason are gone, and the withdrawal is still right, because the equality was never proved in the first place.

### Q2, what does L145 need from the entries after it?

**It needs them for its own step table, and for the only written derivations of two of its four steps. The dependency runs both ways.**

L145 cites [Lemma L146](../findings/second-order.md) **inside its own step-4 row** and again in its closing box. That alone makes the file order circular. Worse, the citation is not decoration:

| L145 step | where its only argument is written |
|---|---|
| 1, $g_n$, two-valued, no kernel | **in L145**, and it is correct (§2) |
| 2, analyticity on the ball of radius $g_n$, $\rho<g_n/2$ | imported without a source; the contour that makes it explicit is [Lemma L156](../results.md) |
| 3, $C_\delta=O(n)$ | the Cauchy ladder and the Leibniz identity are **in L145** and correct (§3); the input $M=O(g_n)$ is asserted with a tool named, and both written proofs of it, the $1$-Lipschitz one and the contour one, are at [Lemma L147](../findings/second-order.md) and [Lemma L156](../results.md) |
| 4, $r_n=\Omega(n^{-3/2})$ | **nowhere in L145.** The minimisation is at [Lemma L147](../findings/second-order.md), adjudicated at [ROUND_L149-F](ROUND_L149F.md) |

**What L145 stands on alone.** Exactly this, and it is worth having: the spectrum of $W^*$ and its consequences ($g_n$'s closed form, $\lambda_+/\lvert\lambda_-\rvert=m/(m-1)$, $\ker W^*=0$, $W^*_-$'s three-Bianchi form, $\mathrm{Alt}(W^*_-)=0$); the exact Leibniz expansion of $(\delta^2)'''$; the Cauchy ladder $\lVert A^{(k)}\rVert=O(n^{k-1})$ on the disc $\rho=\Theta(g_n)$, given $M=O(g_n)$; the rank-conversion arithmetic $\sqrt{\binom n2}g_n=\sqrt{1-2/n}$ and the resulting $n^2$; and the refutation of $C_\delta=O(n^3)$ as the value on the direction-blind disc. **Its headline is not on that list.**

**So the eight later entries are not decoration on L145.** Two of them carry L145's own missing arguments, and three of them (L146, L147, L148) contradict its closing box. The round's premise (that if they add nothing over L145, auditing them polishes passages that carry nothing), is answered the other way: **they carry L145's proof.**

## 11. What a reader may take from this entry

**Take, with this report's confirmation:**

1. $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\tfrac{\sqrt{m-1}}{m\sqrt{2m-1}}=\Theta(1/n)$; the spectrum of $W^*$ is $\{\tfrac m{2m-1},-\tfrac{m-1}{2m-1}\}$ before normalisation, $\ker W^*=0$, and $\lambda_+=\tfrac m{m-1}\lvert\lambda_-\rvert$, at every $m\ge2$.
2. $W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ in the record's sign convention, and hence $\mathrm{Alt}(W^*_-)=0$.
3. $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$.
4. $\lVert A^{(k)}\rVert=O(n^{k-1})$ and $C_\delta=O(n)$, **on the direction-blind disc $\rho<g_n/2$ and nowhere else**, and conditional on $M=O(g_n)$, whose argument is elsewhere.
5. $\sqrt{\binom n2}\,g_n=\sqrt{1-2/n}$, and the rank-spent branch's $M=O(1)$, $A'''=O(n^3)$, $r=n^{-4}$.
6. The **taxonomy** that $n^{-4}$, $n^{-2}$ and $n^{-3/2}$ are three different quantities. Take the taxonomy; do not take the third value from here.

**Do not take:**

1. The boxed $r_n=\Theta(n^{-3/2})$, in the upper direction, no argument exists for it anywhere.
2. The value $n^{-3/2}$ **from this entry**, cite [Lemma L147](../findings/second-order.md) and [ROUND_L149-F](ROUND_L149F.md), which is where the minimisation is.
3. $\inf_Hc(H)/C(H)$ as written, restrict $H$ to the normal space first, or the object is $0$.
4. $\lVert A''\rVert=O(1)$ on the margin summand, it is $O(n^{1/2})$, and the summand carries no defect.
5. "[I31](../plan.md) buys an exponent, not a constant", refuted.

## 12. Findings, with the three-step record

| # | finding | located | exhibited | opposite argued | status |
|---|---|---|---|---|---|
| F1 | the boxed $\Theta$ has no upper half | the LEMMA box and the section title | no statement of the form $r_n=O(\cdot)$ exists in L145 or in L146–L158; the only "$\le$" is a cap on the route | the step table says "lower bound" and withdraws the equality, so a careful reader is warned | **upheld**, the statement is the lemma, and two index files quote the $\Theta$ (§9) |
| F2 | the closing box's $\lVert A''\rVert=O(1)$ | *"So $\lVert A''\rVert=O(1)$ rather than $O(n)$"* | at $\lVert H\rVert_{op}=\Theta(n^{-1/2})$: $\rho=\Theta(n^{-1/2})$ and $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})$ | holding $M=O(g_n)$ fixed across the enlargement gives $O(1)$ | **upheld**, that reading is the one the record adjudicated against twice, and nothing bounds $M$ by $O(g_n)$ on the larger disc |
| F3 | $\inf_Hc(H)/C(H)=0$ as written | *"$n^{-3/2}$ is $\inf_Hc(H)/C(H)$"* | $H\in T_{W^*}\mathcal O$ unit: the functional is constant on the orbit, $c(H)=0$, quotient $0$ | the normal restriction is obviously intended, and was written into a neighbour later | **upheld as a `GAP`**, it is the entry's only definition of its own title's object |
| F4 | three equalities on three upper bounds | the exponent-taxonomy paragraph | every $C$ on file is a Cauchy upper bound; a lower bound on $\lVert A''\rVert$ is recorded as missing and is $0$ on the margin summand | the paragraph's purpose is to separate three quantities, not to pin them | **upheld as a `GAP`**, with the ordering itself confirmed sound |
| F5 | "I31 buys an exponent" | the box's last sentence | at $\beta=0$: $\min(c_p/S,\sqrt{c_p}/a)=\min(n^{-1},n^{-3/2})=n^{-3/2}$ | the box predates [ROUND_L149-F](ROUND_L149F.md) | **upheld**, the text stands uncorrected and is quoted forward |
| F6 | no dimension floor at all | the statement | at $n=4$ and $n=10$ the ambient setting fails ($\theta_0<\sqrt{3/2}$), and L145 excludes neither | step 1 is honest at $m\ge2$, and the rest is plainly meant at $n\ge12$ | **upheld as a hypothesis debt** (§8) |
| F7 | six undefined symbols, and three names for the margin | $c_n$, $c_p$, $c(H)$, $C(H)$, $C_\delta$, $\delta$, $A$, $P$, "penalised functional" | $c_n$ and $c_p$ both appear in the entry and neither is defined; they are used as if equal | the block's other entries define them | **upheld as a notation finding** |
| W1 | *withdrawn*, "the $W^*_-$ formula has the wrong sign" | the corrected-constant box | under $W_-=\min(W,0)$ the formula would need a minus | **the record fixes $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$** at [findings/conventions.md](../findings/conventions.md):95, under which the entry is exactly right | **withdrawn**, checked at source rather than assumed |
| W2 | *withdrawn*, "'the segments fill the tube' owes normal injectivity" | the trap box | a tubular-neighbourhood claim normally needs a focal-radius bound | the ambient is a linear space and the orbit compact, so nearest-point feet exist and are normal with no hypothesis; a lower bound needs no uniqueness | **withdrawn** (§7) |
| W3 | *withdrawn*, "L146 is imported without its single-copy qualifier, so the box's $O(n^{-1/2})$ may fail" | the closing box | the joint two-copy eigenspace carries a cross-plane branch L146's clause misses | the cross branch caps at $\sqrt{m-2}/m<1/\sqrt{m-1}$, since $(m-1)(m-2)<m^2$ at every $m$, so the supremum and the order are unchanged | **withdrawn** |

## 13. What would break the statement, and what I did to look for it

**The object that would falsify it.** A unit direction $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ at $W^*=S^m\times S^m$ with margin $c(H)=\Theta(1/n)$ and cubic constant $C(H)=\omega(n)$, or, equivalently, an $n$-family on which the balanced-orbit tube radius is $o(n^{-3/2})$. That would refute even the surviving $\Omega$.

**The parameter value that would rescue the $\Theta$.** A proof that some direction attains $C(H)=\Omega(n)$ with $c(H)=O(1/n)$ (a **lower** bound on $\lVert A''\rVert\lVert A'\rVert$ at a named $H$) which would turn L145's Cauchy upper bounds into two-sided estimates and make the $n^{-2}$ and $n^{-3/2}$ equalities true rather than one-sided.

**What I did.** I read [Lemma L146](../findings/second-order.md), [Lemma L147](../findings/second-order.md) and [Lemma L148](../findings/second-order.md) at source, [Lemma L156](../results.md)'s canonical contour constant, and the adjudication at [ROUND_L149-F](ROUND_L149F.md) via [plan-verification.md](../plan-verification.md):142, looking specifically for any lower bound on a defect constant or any upper bound on $r_n$. **I found neither.** [Lemma L147](../findings/second-order.md) states the lower bound on $\lVert A''\rVert$ as needed and missing, and [Lemma L148](../findings/second-order.md) sets the defect to zero on the one summand where the record has computed anything. I minimised [Lemma L147](../findings/second-order.md)'s $f(u)$ by hand at both endpoints of $\beta$ and reproduced $\Theta(n^{-3/2})$ at each. No computation of any kind was run.

## Verdict

**`BROKEN`.**

The spectral step is exact and I re-derived every digit of it; the constant repair from $O(n^3)$ to $O(n)$ is right on the disc the entry itself fixes, and its factor $n^2$ closes. But the entry's title and boxed statement claim a $\Theta$ whose upper half is argued nowhere in the record, its own definition of the object in that title evaluates to $0$ as written, and its final box, the one that withdrew the equality and told the programme what [I31](../plan.md) is worth, infers $\lVert A''\rVert=O(1)$ from a premise that gives $O(n^{1/2})$, on a summand where a later lemma proves the defect is identically zero, and concludes something [ROUND_L149-F](ROUND_L149F.md) has since refuted.

**The surviving lower bound $r_n\gtrsim n^{-3/2}$ is not L145's to give.** It is asserted here without derivation and proved two entries later. The correct reading of this block is that the entries after L145 carry L145's proof, not that L145 carries theirs.
