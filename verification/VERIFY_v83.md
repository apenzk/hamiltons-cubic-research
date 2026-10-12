# Verifier v83, L149-r2: the uniformity proof, the $\tfrac29$ coefficient, and what the two boxes each assert

*Cold read of [findings/second-order.md](../findings/second-order.md):1211–1264 as quoted in [ROUND_L149r2.md](ROUND_L149r2.md). **No numerical work**: no script was run, and every value below is an exact hand evaluation from the constants the entry names. Log: [agent_logs/verify-L149r2-v83.log](../agent_logs/verify-L149r2-v83.log).*

## Verdicts

| # | claim | verdict |
|---|---|---|
| C1 | $\inf_{w\ge0}g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$, and its $n$-free coefficient is $\big(\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$ | **PROVEN**, both derived exactly |
| C2 | that coefficient increases in $n$ and equals $0.7197978$ at $n=12$; hence $g_\rho\ge0.71979/n$ uniformly on $w\in[0,1]$ | **PROVEN**, I get $0.7197983$; the truncation to $0.71979$ is in the safe direction |
| C3 | $\rho^{\mathrm{eff}}_n=\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$; strictly increasing; positive at $n=12$; cubic form $11n^3-55n^2-224n+256>0$ worth $8656$ | **PROVEN**, all four verified in closed form |
| C4 | $\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2=\tfrac29\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2$ is an **identity**, not a bound | **PROVEN**, re-derived exactly from [L133](../findings/second-order.md) steps 2 and 4 |
| C5 | $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ with $a_0n^{-1/2}=1/\sqrt{m-1}$ from [L146](../findings/second-order.md), applied to the **joint** two-copy eigenspace | **PROVEN**, L146's supremum re-derived; the joint application is licensed by L146's own cross-plane box |
| C6 | $\ker W^*=0$, the gap being $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ | **PROVEN**, re-derived from [L133](../findings/second-order.md) step 1's spectrum |
| C7 | the boxed lemma's clause "the first is minimised at $w=0$" | **REFUTED, AND THE ENTRY SAYS SO**, $f'(0)=-ac_p/S^2<0$ |
| C8 | "$c(H)\gtrsim c_p+w^2$ … **is unsafe exactly on $n\in\{12,14\}$**" | **BROKEN**, false for the coefficient the chain carries: $\rho^{\mathrm{eff}}_{16}<1$ |
| C9 | "the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to0.416>0$" | **CONTRADICTS C4's BOX**, this is the coefficient-$1$ reading the $\tfrac29$ box calls *excluded* |
| C10 | "the $m$-form … and this $n$-form are the same quantity … both equal to $c_{\min}-c_p$" | **FALSE under the reading the display forces**, true under the charitable one |
| C11 | the final display $r_n\gtrsim n^{-3/2}$ over every direction | **HYPOTHESIS-DEBT**, needs $\beta\le\tfrac12$ ([L143](../findings/bounds.md)), which the entry never states |
| C12 | the joint minimisation that would establish the boxed conclusion | **OWED, AS THE ENTRY SAYS**, and the one candidate quoted for it substitutes $w$ for $u$ |

**Summary.** The written proof (the uniformity of branch 2), is correct in every step and every numeral I could reach by hand; what fails is the prose around it, which prices the penalty at coefficient $1$ in one paragraph and at $\tfrac29$ in three others, misstates where a superseded bound is unsafe, and leaves the entry's own headline resting on an unstated hypothesis and an unperformed minimisation. **Verdict: `HYPOTHESIS-DEBT`.**

## 0. Conventions, fixed once

$n=2m$, $W^*=S^m\times S^m$ unit-norm, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, $e=W^*/\theta_0$. $H$ ranges over $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$; $H=H_s+H_r$ with $H_s$ in the joint $\lambda_m$-eigenspace (both $S^2_0(\mathbb R^m)$ copies) and $w=\lVert H_r\rVert$. Margins are $3\theta_0(\tfrac12-\lambda)$ per [L27](../findings/nondegeneracy.md) summand: $\lambda_m=\tfrac{m-2}{2(m-1)}$ gives $c_p=3\theta_0/(n-2)$; $+\mu=\tfrac1{m-1}$ gives $3\theta_0\tfrac{m-3}{2(m-1)}$; the four zero-$L_e$ summands give $\tfrac32\theta_0$. $\kappa:=nc_p=3\sqrt{2(n-1)/(n-2)}$, distinct from $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$. $a_0=\sqrt{2n/(n-2)}$, so $a_0n^{-1/2}=1/\sqrt{m-1}$ exactly.

**Two symbols carry two meanings inside the entry, and both are live in the same twenty lines.** $\rho$ is the analyticity radius at line 35 ("$\lVert A''\rVert=O(1/\rho)$") and at branch 3 of the display ("$\rho(H)/2$"), and the margin coefficient at lines 47, 50 and 58 ("$\rho=\rho^{\mathrm{eff}}_n$", "at $\rho=0$"). $\kappa$ against $\kappa_n$ is separated by one subscript, which the entry flags. I use $\rho^{\mathrm{eff}}$ and $g_n$ explicitly throughout below.

## 1. The hypothesis inventory

### 1.1 Stated by L149

| hypothesis | where | checked against |
|---|---|---|
| $m\ge6$ | the lemma box, and the "two inputs" line | admissible: every import below admits $m=6$, and $\rho^{\mathrm{eff}}_{12}=0.7190434>0$ |
| $H\perp W^*$ | hypotheses box | supplied by the domain $T_{W^*}S$; removes $\langle W\rangle$'s $\lambda=1$, i.e. a margin of $-\tfrac32\theta_0$ |
| $H\perp T_{W^*}\mathcal O$ | hypotheses box | supplied by $T_{W^*}\mathcal O^\perp$; removes the $\lambda=\tfrac12$ summand, and $E(\tfrac12)$ **equals** the orbit tangent by [L27](../findings/nondegeneracy.md) at $(p,q)=(m,m)$, $m\ge6$, L27's own exception $(3,3)$ is far outside |
| $\ker W^*=0$ | hypotheses box | **holds**, verified in §6 |

### 1.2 Used by L149 and not stated

| hypothesis | where used | status |
|---|---|---|
| $\lVert H\rVert_F=1$ | the convex-combination bullet; $w\in[0,1]$; L146's homogeneity remark | on file at [L145](../findings/second-order.md) and [L147](../findings/second-order.md), absent from L149's box |
| $W^*$ the **balanced** product, $n=2m$ even | every constant in the entry | in the set-up prose ("At $p=q=m$"), absent from the box |
| $\beta\le\tfrac12$, i.e. $\sup\lvert P\rvert=O(\sqrt n)$ | the final display $r_n\gtrsim n^{-3/2}$ | **debt.** The hypotheses box says "$\beta$ enters branch 1 and the final display only" and then never bounds it. [L147](../findings/second-order.md) states it and cites [L143](../findings/bounds.md); [L145](../findings/second-order.md)'s own box records that L145 needs L143 "which this entry does not cite", L149 inherits the omission |
| $\kappa_n<0$ at $W^*$ | the whole penalty account, and $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ | this is what $m\ge6$ actually buys; the entry gives a different and wrong reason (§5, D4) |
| block additivity of margin and defect over [L120](../findings/second-order.md)'s blocks | "the penalty lands on that same summand" | on file at [L133](../findings/second-order.md) step 4 and [L141](../findings/second-order.md)(b); not cited here |

### 1.3 Hypotheses of the imports, each against the object it is applied to

| import | its hypotheses | the object here | verdict |
|---|---|---|---|
| [L27](../findings/nondegeneracy.md) | $p,q\ge3$, $(p,q)\ne(3,3)$; multiplicity-free | $(m,m)$, $m\ge6$ | ✓ |
| [L26](../findings/nondegeneracy.md) | $p,q\ge2$; the $\Lambda^2\otimes\Lambda^2$ identification only "for $p,q\ge5$" | $m\ge6$ | ✓ |
| [L146](../findings/second-order.md) | stated for a **single** $h\in S^2_0(\mathbb R^m)$, $m\ge3$ | applied to the **joint** two-copy eigenspace | ✓, licensed by L146's own cross-plane box, and L149 reproduces its numbers (§4) |
| [L148](../findings/second-order.md) | $m\ge3$; $m\ge5$ for the word "margin"; **both** copies | the joint eigenspace, used for $u\le w$ | ✓ |
| [L133](../findings/second-order.md) | $n=2m\ge12$ | the $\tfrac29$, $\lvert\kappa_n\rvert$, $g_n$ | ✓ |
| [L145](../findings/second-order.md) | needs [L143](../findings/bounds.md), uncited there | the final display | inherited debt, §7 |

**No finding on the domain.** [L141](../findings/second-order.md)(b) records that orthogonality to the orbit inside $\mathcal W_n$ is not enough ($H=W^*$ is orbit-orthogonal and gives $Q(W^*)=+3\theta_0>0$) and L149's domain is the intersection $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, which excludes the radial direction. The entry uses the right domain.

## 2. Pre-registered question 1, does the entry state one thing about its own conclusion?

**No, in one place of form and one of substance.**

**Of form.** The lemma box reads: *"For $m\ge6$, the second branch is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$, the first is minimised at $w=0$, **this clause does not follow and is owed**…"*. A boxed lemma statement asserts a clause and refutes it inside the same sentence. A citation reading the box takes the first half; a reader of the whole sentence takes the second. The refutation itself is correct, $f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=(2u(S+au)-a(c_p+u^2))/(S+au)^2$, which at $u=0$ is $-ac_p/S^2<0$, so $u=0$ (hence $w=0$, which forces $u=0$) is where branch 1 is **largest**, and it agrees with the second box, with [L147](../findings/second-order.md)'s own text and with [results.md](../results.md):363. The three statements about the *owed* thing therefore agree; what disagrees is the box with itself.

**Of substance.** The $\tfrac29$ box says *"The coefficient-$1$ reading is **excluded** rather than disfavoured"*, and the box above it says that under coefficient $1$ "monotonicity is false under that reading rather than merely unproved". Eleven lines later the entry computes in exactly that reading, see §5, D3. Two paragraphs of one entry, one excluding a reading and the other using it.

**The headline is not in dispute.** The final display $r_n\gtrsim n^{-3/2}$ is attributed to [L145](../findings/second-order.md)'s independent proof and marked "untouched by this correction"; the second box says the *L149-specific* conclusion is "owed rather than refuted", and its reason (a lower bound cannot be falsified by a smaller lower bound), is correct, every branch of a $\min$ bounding $r(H)$ below. With $\beta\in[0,\tfrac12]$, $n^{-1-\beta}\ge n^{-3/2}$, so the display and the $n^{-1-\beta}$ form are consistent.

## 3. Pre-registered question 2, identity or bound?

**It is an identity, it is correctly used as one in the $\rho^{\mathrm{eff}}$ boxes, and one paragraph of the entry uses the coefficient-$1$ bound instead.**

### 3.1 The identity, re-derived

[L133](../findings/second-order.md) step 2 gives, in the signed coordinates $(x,y,z)$ of a $(2,2)$-split four-set block with Bianchi $x+y+z=0$,
$$\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac\gamma3x^2,\qquad \lVert H\rVert^2=\gamma(x^2+y^2+z^2),$$
and nothing outside the $(2,2)$ blocks contributes. So $\sigma=x^2/(3(x^2+y^2+z^2))$ with $\gamma$ cancelling, which is the entry's $\sigma$ and its "$\gamma$ … cancelling" exactly.

L133 step 4 writes the block's $\mathbf1^\perp$ as $H=\alpha(2,-1,-1)+\beta(0,1,-1)$, the two vectors orthogonal ($0-1+1=0$) and the $+\mu$ and $-\mu$ eigenvectors of $L_e$. Then $x=2\alpha$, so
$$\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac\gamma3\cdot4\alpha^2=\tfrac43\gamma\alpha^2,\qquad \lVert\Pi_{+\mu}H\rVert^2=\gamma\alpha^2\lVert(2,-1,-1)\rVert^2=6\gamma\alpha^2,$$
whence $\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac29\lVert\Pi_{+\mu}H\rVert^2$ **exactly, for every $H$**, the $\beta$ component dropping out of the numerator, which is the entry's "$\gamma$ and $\beta$ cancelling". Summing over the $\binom m2^2$ blocks gives the displayed identity once $\bigoplus_{(2,2)}\mathbb R X_{ijkl}=\Lambda^2\otimes\Lambda^2$.

### 3.2 The bound, and the containment

On the Bianchi plane, $\max x^2/(x^2+y^2+z^2)$ subject to $y+z=-x$ is attained at $y=z=-x/2$, where $y^2+z^2=x^2/2$, giving $x^2/(\tfrac32x^2)=\tfrac23$ and $\sigma=\tfrac29$, with equality **iff** the block component is proportional to $(2,-1,-1)$. Note the entry's "**Hence** $\sigma\le\tfrac29$ on all of $\mathcal W_n$": the *bound* is this elementary Bianchi computation and owes nothing to the identification; only the *equality locus* needs it. The word attributes the wrong half of the sentence to the preceding argument.

The containment argument checks out. $X=(1,0,0)-\tfrac13(1,1,1)=\tfrac13(2,-1,-1)$ gives $\sigma=(4/9)/(3\cdot\tfrac23)=\tfrac29$ ✓. There is one such line per $(2,2)$ four-set, $\binom m2^2$ of them, supported on disjoint index sets hence independent; [L27](../findings/nondegeneracy.md) puts $+\mu$ on $\Lambda^2\otimes\Lambda^2$ alone with $\dim=\binom p2\binom q2=\binom m2^2$ and the ten $L_e$ values pairwise separated at $m\ge5$ ($\mu=\tfrac15$ against $\lambda_6=\tfrac25$, $\pm$, $0$, $\tfrac12$, $1$ at $m=6$); equal dimensions inside a containment give equality. **No debt here**, and [L26](../findings/nondegeneracy.md)'s own Sources note already records this family as "the $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ summand, for $p,q\ge5$", and [r725](../reviews/REVIEW_r725.md) §3–§4, which the box cites, carries the derivation. The box's claim to have "joined" ingredients the record held separately is accurate.

### 3.3 The identity is what the coefficient needs

The margin is a genuine convex combination: $c(H)=\sum_j m_j\lVert H_j\rVert^2$ with $\sum_j\lVert H_j\rVert^2=1$. The smallest margin outside $H_s$ is the $+\mu$ one, $3\theta_0\tfrac{m-3}{2(m-1)}$, and **the same summand carries the whole penalty**, so no trade-off between "smallest margin" and "largest penalty" arises and
$$c(H)-\lvert\kappa_n\rvert\sigma(H)\ \ge\ c_p+\Big[3\theta_0\tfrac{m-4}{2(m-1)}-\tfrac29\lvert\kappa_n\rvert\Big]w^2=c_p+\rho^{\mathrm{eff}}_nw^2,$$
using $3\theta_0\tfrac{m-3}{2(m-1)}-c_p=3\theta_0\tfrac{m-4}{2(m-1)}$, which holds because $c_p=3\theta_0/(n-2)=3\theta_0\tfrac1{2(m-1)}$, the entry's "the two fractions differ by one in the numerator", verified. This is [r725](../reviews/REVIEW_r725.md)'s display and [L141](../findings/second-order.md)(b)'s $\tfrac29\lvert\kappa_n\rvert s$ at $s=1$; **the $\tfrac29$ was already load-bearing at L141(b) before this box discharged it.**

## 4. The named trap, where each factor of each branch is read

| place | numerator read at | denominator read at | direction of the error |
|---|---|---|---|
| branch 2 of the display | $c_p$ at all $w$; $\rho^{\mathrm{eff}}_nw^2$ at the running $w$ | $a_0n^{1/2}$ at $\lVert H_s\rVert_F=1$, i.e. **at $w=0$**; $nw$ at the running $w$ | **the trap is present and declared**: the entry writes "homogeneous so $\lVert H_s\rVert_F<1$ only helps". Correct, the true envelope is $a_0n^{-1/2}\sqrt{1-w^2}+w$, so the written denominator is larger and $g_\rho$ smaller. Safe |
| $\lVert A''\rVert=O(1/\rho)\to a_0n^{1/2}+nw$ |, | $a_0n^{1/2}$ is $n\lVert H_s\rVert_{op}$, whereas $\lVert H_s\rVert_{op}/g_n=n\lVert H_s\rVert_{op}\sqrt{\tfrac{n-1}{2(n-2)}}$ | the written denominator exceeds $1/\rho$ by $\sqrt{2(n-2)/(n-1)}\in(1.348,\sqrt2]$, so again safe; the constants are parked in [L158](../findings/second-order.md)'s $K$, which the entry's last box states |
| the stationary point $\inf_{w\ge0}g_\rho$ | both factors at the same $w^*=\kappa/(\rho a_0\sqrt n)$ | same | exact; no trap |
| the $n$-free coefficient $\big(\tfrac{a_0^2}\kappa+\tfrac1\rho\big)^{-1/2}$ | $1/\rho^{\mathrm{eff}}_n$ at the running $n$ | $a_0^2/\kappa$ at the same running $n$ | **both at one point.** Each is separately decreasing in $n$, so the minimum is at $n=12$ and the $\rho\ge\rho^{\mathrm{eff}}_{12}$ of the monotonicity box is consistent with it. **The trap is not committed in the uniformity proof** |
| the penalty paragraph, line 70 | margin $\tfrac32\theta_0$ at $n\to\infty$ | $\lvert\kappa_n\rvert$ at $n\to\infty$ | both at $\infty$, and the difference $9\sqrt{3/2}-\tfrac{15}2\theta_0$ decreases in $n$, so "$>0$" is safe as a limit. But at finite $n$ the binding margin is $3\theta_0\tfrac{n-6}{2(n-2)}$, which is $1.11243$ against $\tfrac32\theta_0=1.85405$ at $n=12$, the expression overstates the net at every finite $n$ |
| the quoted branch-1 minimisation, line 42 | numerator at $u=w$ | denominator's $a=n\max(n^{-1/2},w)$ at the same $w$ | **the trap, committed by substitution of one variable for another**, see D8 |

## 5. The discrepancies, each by the three-step protocol

### D1, "the same quantity" is false under the reading the display forces

**Locate.** Line 48: *"The $m$-form $3\theta_0\tfrac{m-4}{2(m-1)}$ of the bullet above and this $n$-form are the same quantity under $n=2m$, both equal to $c_{\min}-c_p$."* The display two lines above defines $\rho^{\mathrm{eff}}_n=3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert$, so "this $n$-form" names $\rho^{\mathrm{eff}}_n$.

**Exhibit.** At $n=12$, $m=6$: $\theta_0=\sqrt{220}/12=1.2360331$, so the $m$-form is $3\theta_0\cdot\tfrac2{10}=0.7416198$ and $\rho^{\mathrm{eff}}_{12}=0.7416198-\tfrac29(0.1015939)=0.7190434$. They differ by $\tfrac29\lvert\kappa_{12}\rvert=0.0225764$. **The entry prints both numerals itself**, $0.7416$ in the bullet, $0.71904$ in the box, so it contradicts its own arithmetic in the same paragraph. Only the $m$-form equals $c_{\min}-c_p$; $\rho^{\mathrm{eff}}_n$ is $c_{\min}-c_p-\tfrac29\lvert\kappa_n\rvert$.

**Argue the opposite.** The most charitable reading takes "this $n$-form" to name the first summand $3\theta_0\tfrac{n-8}{2(n-2)}$ rather than the whole display. Under it the sentence is exactly true: $\tfrac{n-8}{2(n-2)}=\tfrac{2m-8}{4(m-1)}=\tfrac{m-4}{2(m-1)}$ at $n=2m$, and that quantity is $c_{\min}-c_p$.

**Verdict: stands**, as a mislabel with a live consequence, it is the sentence that would license a reader to use $0.7416$ where $\rho^{\mathrm{eff}}_{12}$ belongs, which is the substitution error the entry's own proof paragraph warns about for $\kappa$.

### D2, "unsafe exactly on $n\in\{12,14\}$" is false for the coefficient the chain carries

**Locate.** Line 33: *"the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$. **It is unsafe exactly on $n\in\{12,14\}$**"*.

**Exhibit.** The chain's numerator carries $\rho^{\mathrm{eff}}_n$, not the $m$-form (line 37's display; line 46's "the coefficient the chain carries"). At $n=16$: $\theta_0(16)=\sqrt{420}/16=\sqrt{105}/8$, so
$$\rho^{\mathrm{eff}}_{16}=\sqrt6-\frac{\sqrt{105}}8\cdot\frac{32}{28}=\sqrt6-\frac{\sqrt{105}}7 .$$
This is $<1$ exactly: the claim is $7\sqrt6-7<\sqrt{105}$, and squaring both positive sides gives $343-98\sqrt6<105$, i.e. $238<98\sqrt6$, i.e. $\sqrt6>\tfrac{17}7$, i.e. $6>\tfrac{289}{49}=5.8980$, true. So $c(H)\ge c_p+w^2$ fails at $n=16$ as well, numerically $\rho^{\mathrm{eff}}_{16}=0.9856395$. At $n=18$ it holds: $\rho^{\mathrm{eff}}_{18}=\sqrt6-\tfrac{17\sqrt{34}}{72}$, and $72\sqrt6-72>17\sqrt{34}$ squares to $36288-10368\sqrt6>9826$, i.e. $\sqrt6<2.55227$, true. **The correct set is $n\in\{12,14,16\}$.** [r725](../reviews/REVIEW_r725.md), cited by the very box that fixes the coefficient, lists $\rho^{\mathrm{eff}}$ at $n=12,14,16,18$ as $0.719043,\,0.872390,\,0.985640,\,1.072737$, its own third entry refutes the sentence.

**Argue the opposite.** The sentence's own numerals are the un-penalised $m$-form ($0.7416$, $0.9463$, and $1.0979$ at $n=16$), so read strictly as a claim about *the bullet's* coefficient it is self-consistent. But the bullet is the input to the display, the display carries $\rho^{\mathrm{eff}}$, and the sentence is written to tell a reader where the superseded bound may still be used.

**Verdict: stands. `BROKEN` at sentence level**; it is not load-bearing, since the chain never uses $c_p+w^2$.

### D3, the penalty paragraph computes in the coefficient-$1$ reading the $\tfrac29$ box excludes

**Locate.** Line 70: *"the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.416>0$, **positive by 20%**"*. Against line 54: *"**The coefficient-$1$ reading is excluded rather than disfavoured**"*, and line 52: *"At penalty coefficient $1$ the record's own values run $0.6400\to0.4161$, **decreasing**, so monotonicity is false under that reading"*.

**Exhibit.** $\tfrac32\sqrt2-9(\sqrt2-\sqrt{3/2})=2.1213203-1.7052183=0.4161020$. That is **exactly** the right-hand end of line 52's excluded sequence $0.6400\to0.4161$. Under the identity the same limit is $\tfrac32\sqrt2-\tfrac29\cdot9(\sqrt2-\sqrt{3/2})=2.1213203-0.3789374=1.7423829$, which is the $\rho^{\mathrm{eff}}$ box's own stated limit $1.74238$. The two paragraphs price the same quantity at $0.416$ and $1.74238$, a factor $4.187$, and the entry marks neither as superseding the other. "Positive by 20%" is a statement about a margin the rest of the entry puts at $82\%$.

**Argue the opposite.** Line 70 derives its inequality from $u\le w$ alone, which it states, and $u\le w$ is true; so the paragraph proves a weaker true statement rather than a false one, and since $9\sqrt{3/2}-\tfrac{15}2\theta_0$ decreases in $n$ the limit $0.4161$ is its infimum over $n\ge12$ and "$>0$" is safe. On that reading the paragraph is a cruder route to the same positivity.

**Verdict: stands**, not as a false claim, but as the entry using, unrepaired, the reading two of its own boxes declare excluded and destructive of monotonicity. This is the answer to pre-registered question 2.

### D4, "$\rho^{\mathrm{eff}}$ has no definition" at $n=10$

**Locate.** Line 30: *"at $n=10$, $\theta_0=6/5<\sqrt{3/2}$, so $\lvert\kappa_n\rvert$ is negative and $\rho^{\mathrm{eff}}$ has no definition."*

**Exhibit.** $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=12/10=6/5$ ✓ and $\sqrt{3/2}=1.2247>1.2$ ✓. But the closed form evaluates: $\rho^{\mathrm{eff}}_{10}=\sqrt6-\tfrac65\cdot\tfrac{26}{16}=2.4494897-1.95=0.4994897$, defined and positive. And $\lvert\kappa_{10}\rvert$ is not negative, an absolute value never is; what is negative is the *expression* $9(\theta_0-\sqrt{3/2})$ that the entry writes for it, because $\kappa_{10}=9(\sqrt{3/2}-\theta_0)=+0.2227>0$ where $\kappa_{12}=-0.1016<0$. The real obstruction at $n=10$ is that $-\kappa_n\delta^2$ stops being a penalty and becomes a bonus.

**Argue the opposite.** Read "$\rho^{\mathrm{eff}}$" as naming the expression *as written with $\lvert\kappa_n\rvert$*, and that expression is ill-formed at $n=10$. Line 52 states the correct version, "$\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ … carries its sign only for $n\ge12$".

**Verdict: stands** as an overstated reason. **The dimension floor $m\ge6$ is itself correct** and rests on exactly this sign, since no other ingredient fails at $m=5$: $\tfrac{m-4}{2(m-1)}=\tfrac18>0$, [L27](../findings/nondegeneracy.md) is multiplicity-free from $m\ge3$, and [L26](../findings/nondegeneracy.md)'s identification holds from $p,q\ge5$.

### D5, "the smallest surviving one, the $\Lambda^2\otimes\Lambda^2$ summand"

**Locate.** Line 46: *"its coefficient is the **smallest surviving** one, the $\Lambda^2\!\otimes\!\Lambda^2$ summand, attained"*.

**Exhibit.** The smallest margin that survives $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ is $c_p=3\theta_0/(n-2)=0.3708$ at $n=12$, on the $S^2_0(\mathbb R^m)$ copies. The $\Lambda^2\otimes\Lambda^2$ margin is $3\theta_0\tfrac{m-3}{2(m-1)}=1.11243$, three times larger.

**Argue the opposite.** "Surviving" plainly means "surviving into the coefficient of $w^2$", i.e. smallest among summands outside $H_s$, and the bullet says "smallest **off-summand** margin", which is precise. The arithmetic downstream uses the off-summand minimum correctly.

**Verdict: stands as a wording slip only.** It is in the class the brief flags (a noun standing for a set it does not name) but the charitable reading is the intended one and nothing computes from the literal one.

### D6, the substance display's first arrow, WITHDRAWN

**Locate.** Line 25: $\lVert A''\rVert=\Theta(n)\Rightarrow\lVert H\rVert_{op}=\Theta(1)\Rightarrow w=\Theta(1)\Rightarrow c(H)=\Theta(1)$.

**Exhibit attempt.** The entry's only relation between $\lVert H\rVert_{op}$ and $w$ is the **upper** bound $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$, which cannot force $\lVert H\rVert_{op}$ upward from a hypothesis on $\lVert A''\rVert$.

**Argue the opposite.** The implication that actually runs is $\lVert A''\rVert=\Theta(n)\Rightarrow n\lesssim n^{1/2}+nw\Rightarrow w=\Theta(1)$, read straight off $\lVert A''\rVert=O(n^{1/2}+nw)$; $\lVert H\rVert_{op}=\Theta(1)$ then *follows* from $w=\Theta(1)$ via $\lVert H\rVert_{op}\ge w-\lVert H_s\rVert_{op}\ge w-\Theta(n^{-1/2})$. The display is the same three facts with the middle one derived rather than used.

**Verdict: withdrawn**, the display is a précis whose arrows are not the proof's order; no defect.

### D7, $\rho$ carries two meanings four lines apart, recorded, not a defect

Line 35's $O(1/\rho)$ and the display's branch 3 $\rho(H)/2$ are the analyticity radius; line 47's $\rho^{\mathrm{eff}}_n$, line 50's "at $\rho=0$" and line 58's "$\rho=\rho^{\mathrm{eff}}_n$" are the margin coefficient. Both are in force in the same twenty lines, and the hypotheses box's "branches 2 and 3 have no domain" refers to the first while line 30's "$\rho^{\mathrm{eff}}$ has no definition" refers to the second. The entry separates $\kappa$ from $\kappa_n$ at length and does not separate these. **No mathematical error; a live citation hazard.**

### D8, the quoted branch-1 minimisation substitutes $w$ for $u$

**Locate.** Line 42: *"The minimisation of $(c_p+w^2)/(S+n\max(n^{-1/2},w)w)$ is reported by one reader as $\Theta(n^{-1-\beta})$ attained at $w=0$, which would pay the debt"*, against line 39: *"$u$ is the defect's linear rate and is **not** $w$, the only relation on file being $u\le w$."*

**Exhibit.** The admissible set is $u\in[0,w]$; a lower bound on the branch needs $\min_{u\in[0,w]}f(u)$. Setting $u=w$ evaluates at the top of that interval. Since $f'(0)<0$ and $f$ has its interior minimum at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with $u^*\le\sqrt{c_p}=\Theta(n^{-1/2})$ ([L147](../findings/second-order.md), and [results.md](../results.md):363), $f(w)>\min_{[0,w]}f$ for every $w>u^*$, so the substituted form **over**-estimates the branch and cannot discharge a lower-bound debt. Separately, "attained at $w=0$" is inconsistent with $f'(0)<0$: at $w=0$ the substituted form is $c_p/S$, which the function falls below immediately; its *order* $\Theta(n^{-1-\beta})$ is nonetheless right, since $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$.

**Argue the opposite.** The entry labels the report "unadjudicated" and rests nothing on it, and it is quoted as a candidate payment rather than as a payment.

**Verdict: stands** as a warning attached to the quoted candidate. It matters because the candidate is the only route on file to the boxed conclusion, and it is the very substitution the entry forbids three lines earlier.

## 6. What I could verify, in closed form

### 6.1 The uniformity proof, correct in every step

For $g_\rho(w)=\sqrt{c_p+\rho w^2}/(A+Bw)$ with $A=a_0n^{1/2}$, $B=n$, the square $h=(c_p+\rho w^2)/(A+Bw)^2$ has $h'=0$ at $\rho wA=Bc_p$, i.e. $w^*=Bc_p/(\rho A)$, and
$$h(w^*)=\frac{c_p}{A^2+B^2c_p/\rho}=\frac{\rho c_p}{\rho A^2+B^2c_p}=\frac{\rho\kappa}{n^2(\rho a_0^2+\kappa)},$$
using $c_p=\kappa/n$, $A^2=a_0^2n$, $B^2=n^2$. So $\inf_{w\ge0}g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$, the entry's display exactly. Its $n$-free part is $(a_0^2/\kappa+1/\rho)^{-1/2}$ with
$$\frac{a_0^2}\kappa=\frac{2n/(n-2)}{3\sqrt{2(n-1)/(n-2)}}=\frac{2n}{3\sqrt2\sqrt{(n-1)(n-2)}}=\frac{\sqrt2\,n}{3\sqrt{(n-1)(n-2)}},$$
the entry's expression exactly. Both terms decrease in $n$: $n^2/((n-1)(n-2))=1/(1-3/n+2/n^2)$ and $3/n-2/n^2$ has derivative $(4-3n)/n^3<0$; and $1/\rho^{\mathrm{eff}}_n$ decreases because $\rho^{\mathrm{eff}}_n$ increases (§6.2). Hence the coefficient increases and its minimum over even $n\ge12$ is at $n=12$. **The step "no case analysis on the location of the stationary point is needed" is legitimate**: only $\inf_{[0,1]}\ge\inf_{[0,\infty)}$ is used.

### 6.2 $\rho^{\mathrm{eff}}$, both forms, monotone and positive

$3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\cdot9(\theta_0-\sqrt{3/2})=\theta_0\big[\tfrac{3(n-8)}{2(n-2)}-2\big]+2\sqrt{3/2}=\sqrt6-\theta_0\tfrac{n+16}{2(n-2)}$, since $\tfrac{3n-24-4n+8}{2(n-2)}=-\tfrac{n+16}{2(n-2)}$ and $2\sqrt{3/2}=\sqrt6$. The subtracted term is $\tfrac{n+16}{6n}\kappa$ (check: $\tfrac{n+16}{6n}\cdot\tfrac{3\theta_0n}{n-2}=\tfrac{\theta_0(n+16)}{2(n-2)}$ ✓) and $\tfrac{n+16}{6n}=\tfrac16+\tfrac{8}{3n}$ and $\kappa=3\sqrt{2+2/(n-2)}$ are both positive and decreasing, so $\rho^{\mathrm{eff}}$ strictly increases. Positivity at $n=12$: $\theta_0(12)\cdot\tfrac{28}{20}=\tfrac{\sqrt{220}}{12}\cdot\tfrac75=\tfrac{7\sqrt{55}}{30}$ (using $\sqrt{220}=2\sqrt{55}$), so the claim is $6>\tfrac{49\cdot55}{900}$, i.e. $5400>2695$ ✓. The cubic: $6>\tfrac{(n-1)(n+16)^2}{2n^2(n-2)}$ expands to $12n^3-24n^2>n^3+31n^2+224n-256$, i.e. $11n^3-55n^2-224n+256>0$, worth $19008-7920-2688+256=8656$ at $n=12$ ✓. **All four as written.**

### 6.3 $\ker W^*=0$ and $g_n$

[L133](../findings/second-order.md) step 1 gives $W^*\propto\tfrac m{2m-1}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ (multiplicity $m(m-1)$) and $-\tfrac{m-1}{2m-1}$ on the $m^2$ mixed planes. Unit norm forces the scale $c$ by $c^2\tfrac{m^2(m-1)}{2m-1}=1$, so
$$g_n=\lvert\lambda_-\rvert=\frac{m-1}{2m-1}\cdot\frac{\sqrt{2m-1}}{m\sqrt{m-1}}=\frac{\sqrt{m-1}}{m\sqrt{2m-1}}=\frac{\sqrt{2(n-2)}}{n\sqrt{n-1}},$$
the entry's expression exactly, and nonzero at every $n$, so **$\ker W^*=0$ holds**. It is $0.1123666$ at $n=12$ and $\Theta(n^{-1})$, matching the entry's "$\Theta(n^{-1})=\Theta(g_n)$".

### 6.4 L146's supremum, re-derived

With $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2=1$ and $\lVert H\rVert_{op}=\tfrac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, maximising the linear functional $\langle h,e_1+e_2\rangle$ on the traceless sphere gives $\lVert P_0(e_1+e_2)\rVert\lVert h\rVert=\sqrt{\tfrac{2(m-2)}m}\cdot\sqrt{\tfrac{2(m-1)}{m(m-2)}}=\tfrac{2\sqrt{m-1}}m$, so $\sup\lVert H\rVert_{op}=\tfrac m{2(m-1)}\cdot\tfrac{2\sqrt{m-1}}m=\tfrac1{\sqrt{m-1}}$ ✓, which is $a_0n^{-1/2}=\sqrt{2/(n-2)}$ ✓. The joint two-copy application is safe: in-block eigenvalues on $B_i$ planes see only one copy, and the cross-plane branch caps at $\sqrt{m-2}/m<1/\sqrt{m-1}$ since $(m-1)(m-2)<m^2$. At $n=12$ these are $2/6=0.3333$ and $1/\sqrt5=0.4472$, the entry's $0.333$ and $0.447$ ✓.

## 7. The edges of every range

**Smallest dimension.** $m=6$ is admissible and is the true floor; the entry's reason for it is wrong (D4) and its true reason is the sign of $\kappa_n$.

**$w=0$.** $g_\rho(0)=\sqrt{c_p}/(a_0n^{1/2})=\sqrt\kappa/(a_0n)=2.1094262/1.5491933/n=1.3616249/n$, comfortably above the claimed floor. Branch 2 is genuinely *absent* there, [L148](../findings/second-order.md) makes the defect identically zero on the joint eigenspace, which is why the statement is $\Omega$ and not $\Theta$; the entry says so and is right.

**$w=1$, and the floor is tight.** $w^*=\kappa/(\rho^{\mathrm{eff}}_{12}a_0\sqrt{12})=4.4497191/(0.7190434\cdot5.3665631)=1.153186>1$, so $g_\rho$ is **decreasing throughout $[0,1]$** at $n=12$ and the true constrained infimum is at $w=1$:
$$g_\rho(1)=\frac{\sqrt{0.3708099+0.7190434}}{5.3665631+12}=\frac{1.0439700}{17.3665631}=\frac{0.7213631}{12}.$$
Against the claimed $0.7197978/n$ this leaves **0.22% of slack**. The uniform bound is therefore true, unattained, and nearly sharp; any future sharpening of $a_0$ or weakening of $\rho^{\mathrm{eff}}$ consumes it. Worth recording, since the entry's own $\ge$ is derived from the *unconstrained* infimum, which lies outside the admissible interval.

**$\ker W\ne0$.** The hypothesis is on $W^*$, where it holds (§6.3). The record's witness that it is not vacuous is $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$, at which [L147](../findings/second-order.md) says $g_n$, $\rho$, $M$ and branches 2–3 do not exist, and [L148](../findings/second-order.md) says its own conclusion still holds and $\delta^2=\tfrac19\ne0$. L149's hypotheses box states this correctly and nothing in the entry is applied at a base point with a kernel. **No finding.**

## 8. The numerals, each against the constants the entry names

| numeral | entry | my exact evaluation | verdict |
|---|---|---|---|
| $\theta_0(10)=6/5$ | line 30 | $\sqrt{144}/10=6/5$ | ✓ |
| $\lvert\kappa_{12}\rvert=0.1016$ | line 58 | $9(\sqrt{220}/12-\sqrt{3/2})=0.1015939$ | ✓ |
| $\kappa=4.4497$ | line 58 | $3\sqrt{2.2}=4.4497191$ | ✓ |
| exceeds by a factor $43.8$ | line 58 | $4.4497191/0.1015939=43.799$ | ✓ |
| $0.19994$ (wrong-$\kappa$ substitution) | line 58 | $(2.4/0.1015939+1.3907320)^{-1/2}=0.1999427$ | ✓ exact |
| $0.71980$ / $0.71979$ | line 58, 62 | $0.7197983$ | ✓; $0.71979$ truncates downward, safe |
| $0.7197978$ | line 62 | $0.7197983$ | ✓ to 6 digits |
| $\rho^{\mathrm{eff}}_{12}=0.71904$ | line 48 | $0.7190434$ | ✓ (and matches [plan-verification.md](../plan-verification.md)'s $0.7190434$) |
| $\rho^{\mathrm{eff}}_\infty=1.74238$ | line 48 | $\sqrt6-\tfrac{\sqrt2}2=1.7423829$ | ✓ |
| $0.7416$ at $n=12$, $0.9463$ at $n=14$ | line 33 | $0.7416198$, $0.9462601$ | ✓ |
| "reaching $1$ only from $n=16$" | line 33 | $m$-form at $n=16$ is $1.0978876$ | ✓ for the $m$-form |
| "unsafe exactly on $n\in\{12,14\}$" | line 33 | $\rho^{\mathrm{eff}}_{16}=0.9856395<1$ | **✗, see D2** |
| $5400>2695$; $8656$ | line 50 | $6\cdot900$, $49\cdot55$; $19008-7920-2688+256$ | ✓ |
| $0.6400\to0.4161$ | line 52 | $0.6400260$, $0.4161020$ | ✓ |
| $2.1213-1.7053=0.416$ | line 70 | $2.1213203-1.7052183=0.4161020$ | ✓ arithmetically, **but see D3** |
| $0.689771$ | line 54 | $(0.5393598+1.5624366)^{-1/2}=0.689771$ | ✓ exact |
| $0.589804$ | line 54 | $(\tfrac{\sqrt2}3+1/0.4161020)^{-1/2}=(0.4714045+2.4032569)^{-1/2}=0.589804$ | ✓ exact |
| $0.582938$ | line 54 | $(0.5393598+2.4032569)^{-1/2}=0.5829543$ | **✗ at the 5th decimal**; I could not reproduce $0.582938$ from the stated recipe ($a_0^2/\kappa$ frozen at $n=12$ inside the $n\to\infty$ limit). The numeral is a withdrawn one, so nothing rests on it |
| $\sqrt{m-2}/m=0.333$, $1/\sqrt{m-1}=0.447$ | line 30 | $1/3$, $0.4472136$ | ✓ |
| $c_p/\theta_0\le3/(n-2)$ | line 72 | $c_p=3\theta_0/(n-2)$, so this is an equality | ✓ (a "$\le$" where "$=$" holds) |

**Everything I could not reproduce:** the withdrawn $0.582938$ only. Everything else in the entry reproduces exactly or to the digits printed.

## 9. The two forms, results.md

**[results.md](../results.md) carries no canonical L149**, and none of L145–L148 either; the block appears there only from L154 onward. It also does not appear in the "Audit owed" closing list, which carries L0, L1, L68 and L72. **The absence is defensible and should be recorded rather than repaired**: the file's own rule is "a result appears here once Gate 2 has passed", and L149's Gate 2 returned PLAUSIBLE *with the margin step refuted as stated*, while the entry itself says "the repair is itself unaudited". Its neighbours L145–L148 are in the same position. [findings/INDEX.md](../findings/INDEX.md) is a file-level index and registers no individual lemma numbers, so there is no registry against which the omission counts as a gap.

**Two differences worth naming.**

1. [results.md](../results.md):363, inside L158's entry, is the only L149 content in the canon. It agrees with the entry on every fact they share, $f'(0)=-ac_p/S^2<0$, $u^*\le\sqrt{c_p}$, $\kappa=nc_p\approx4.45$, branch 2 of order $n^{-1}$, the joint minimisation owed, and it names the trap in the same words the brief does ("read the numerator and the coefficient at two different points"). It uses the **sharper** branch-2 envelope $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$, whose kink is at $w_0=(n-4)/n$, verified: $a_0n^{-1/2}\sqrt{1-w^2}=1-w$ with $c^2=2/(n-2)$ gives $w=(1-c^2)/(1+c^2)=(n-4)/n=\tfrac23$ at $n=12$ ✓. L149's $g_\rho$ uses the uncapped envelope, which is larger in the denominator, so **L149's function is the smaller of the two and both are lower bounds; the minima sit at different $w$ ($1$ against $\tfrac23$) with no contradiction.** No finding.
2. [results.md](../results.md):355–357, L157's entry, still carries $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$, **coefficient $1$ on $w^2$**, the reading L149's box excludes. This is already recorded as D6 of [plan-verification.md](../plan-verification.md)'s L157 row and is unrepaired. It is a live instance of the pattern D3 exhibits inside L149 itself: the $\tfrac29$ correction reached some paragraphs and not their neighbours.

## 10. What would falsify the statement, and what I did to look for it

**Branch 2's uniformity.** A falsifier is a $w\in[0,1]$ with $g_{\rho^{\mathrm{eff}}_{12}}(w)<0.71979/12$ at $n=12$, or a dimension where the $n$-free coefficient dips below its $n=12$ value. I evaluated the endpoints exactly ($1.3616249/n$ at $w=0$, $0.7213631/n$ at $w=1$), located the unique stationary point at $w^*=1.153186$ outside $[0,1]$, and proved both terms of $(a_0^2/\kappa+1/\rho^{\mathrm{eff}}_n)$ monotone decreasing. **No such $w$ and no such $n$ exists.**

**The final display.** A falsifier is a direction family with branch 1 of order $o(n^{-3/2})$. Since $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))=\Theta(\min(n^{-1-\beta},n^{-3/2}))$ and $a\le n$, **the only way to build one is $\beta>\tfrac12$, i.e. $\sup\lvert P\rvert$ growing faster than $\sqrt n$**, excluded by [L143](../findings/bounds.md), which this entry never cites. That is the object, and its absence is precisely the unstated hypothesis of §1.2.

**The $\tfrac29$.** A falsifier is an $H\in\mathcal W_n$ with $\sigma(H)>\tfrac29$. The constrained maximum of $x^2/(x^2+y^2+z^2)$ on $x+y+z=0$ is $\tfrac23$, attained only at $(2,-1,-1)$, and $\mathrm{Alt}\,DW_-$ is supported on $(2,2)$ blocks alone ([L133](../findings/second-order.md) step 2), so a ratio of sums is at most the largest per-block ratio. **No such $H$ exists.**

## Verdict

**`HYPOTHESIS-DEBT`.**

The uniformity proof the entry actually writes is correct, I re-derived the infimum, the $n$-free coefficient, its monotonicity, the closed form and monotonicity of $\rho^{\mathrm{eff}}_n$, the positivity cubic, [L146](../findings/second-order.md)'s supremum, $g_n$, and the $\tfrac29$ identity, all in closed form, and reproduced every numeral but one withdrawn constant. What is owed is what the entry says is owed, and I confirm it is unpaid:

1. **The joint minimisation** of $\min\big(\tfrac{c_p+u^2}{S+au},\,g_\rho(w),\,\tfrac{\rho(H)}2\big)$ over the admissible $(u,w)$, whose only recorded relation is $u\le w$. The single candidate on file substitutes $u=w$ and so estimates the branch from above (D8).
2. **$\sup\lvert P\rvert=O(\sqrt n)$**, i.e. $\beta\le\tfrac12$ from [L143](../findings/bounds.md), which the final display needs and the hypotheses box does not state.

And three things should be repaired in the text before it is cited: the false "unsafe exactly on $n\in\{12,14\}$" (D2, correct set $\{12,14,16\}$), the coefficient-$1$ penalty paragraph that contradicts the $\tfrac29$ box (D3), and the "same quantity" sentence that equates $\rho^{\mathrm{eff}}_n$ with a quantity $\tfrac29\lvert\kappa_n\rvert$ larger (D1).

*No computation was performed. Screening allowance unused.*
