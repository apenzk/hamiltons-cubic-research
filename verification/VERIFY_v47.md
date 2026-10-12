# VERIFY_v47, adjudication of the five standing findings against Lemma L149

*Adjudicator v47, 2026-09-05. Five candidate findings (F7, F9, F10, F11, F12), filed against [Lemma L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform), carried through six rounds and never adjudicated. Each is judged against the **current** text of [second-order.md](../findings/second-order.md), lines 1197–1243, read in full.*

**No numerical work was done. No script was run.** Every value below is an exact hand evaluation from closed forms already on the record; where a number is a decimal it is a decimal expansion of a stated radical, and the radical is given. Log: [verify-L149F-v47.log](../agent_logs/verify-L149F-v47.log).

## VERDICTS

| # | CANDIDATE | VERDICT |
|---|---|---|
| **F7** | THE KERNEL HYPOTHESIS $\ker W^*=0$ IS NOWHERE STATED | **SUPERSEDED** |
| **F9** | $\rho^{\text{eff}}_n>0$ ACROSS THE RANGE HAS NO ARGUMENT ON FILE | **HYPOTHESIS-DEBT** |
| **F10** | THE $m=4$ ARGUMENT NAMES THE WRONG FAILURE | **SUPERSEDED** |
| **F11** | $\kappa$ AND $w^*$ EACH NAME TWO QUANTITIES IN ONE BLOCK | **UPHELD IN PART** |
| **F12** | "THE FIRST IS MINIMISED AT $w=0$" | **UPHELD** |

## Standing constants, fixed once

All five sections use the same imports, each already on the record and none re-derived here.

- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, from [second-order.md:887](../findings/second-order.md#L887). At $n=12$, $\theta_0=\sqrt{220}/12=1.236033081$; $\theta_0\uparrow\sqrt2$.
- $L_e$'s ten summand eigenvalues at $W^*=S^m\times S^m$, from [Lemma L27](../findings/nondegeneracy.md#lemma-l27-sphere-products-are-morsebott-nondegenerate-canonical-statement-and-proof): $1$ on $\langle W\rangle$; $\tfrac12$ on the orbit; $\lambda_m=\tfrac{m-2}{2(m-1)}$ on each $S^2_0(\mathbb R^m)$ copy; $+\mu$ on $\Lambda^2\!\otimes\!\Lambda^2$ and $-\mu$ on $S^2_0\!\otimes\!S^2_0$ with $\mu=\tfrac1{m-1}$ at $p=q=m$; $0$ on the four remaining summands.
- The margin of a summand is $3\theta_0(\tfrac12-\lambda)$, so $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ and $\kappa:=n\,c_p=3\sqrt{2(n-1)/(n-2)}$, which is $3\sqrt{2.2}=4.449719$ at $n=12$ and falls to $3\sqrt2$.
- $a_0^2=2n/(n-2)$, from [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects); $a_0^2=2.4$ at $n=12$.

## 1. F7, the kernel hypothesis, SUPERSEDED

**Locate.** The finding says $\ker W^*=0$ is nowhere stated. The current block states it, in its own blockquote at [second-order.md:1227](../findings/second-order.md#L1227):

> **HYPOTHESES THE CHAIN USES.** $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$, which the domain $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ supplies; and **$\ker W^*=0$**, without which $W\mapsto W_-$ is not analytic at $W^*$ and branches 2 and 3 have no domain, it **holds**, the gap being $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ recorded above.

**Which commit repaired it.** `1d5d1d26` `fix(L149): GAP on the proof as written -- it ran at coefficient 1 and so bounded from above` inserted that blockquote; `git log -S 'HYPOTHESES THE CHAIN USES'` returns that commit alone. The passage names the hypothesis, gives its analytic role, gives the gap in closed form, and asserts that it holds at the base point. That is everything the finding asked for.

**Do the branches genuinely need it, the second half of the question.** Yes, and the dependence is not decorative. Line 1212 reads "Hence $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$". The only route from the operator-norm bullet to that display is $\rho(H)\ge g_n/\lVert H\rVert_{op}$, since $g_n=\Theta(n^{-1})$ and $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ give $1/\rho\le\Theta(n)\big(\Theta(n^{-1/2})+w\big)=\Theta(n^{1/2})+\Theta(n)w$, which is the display exactly. At $n=12$, $g_n=\sqrt{20}/(12\sqrt{11})=0.112366$ and $1/g_n=8.899$. With a kernel there is no $g_n$, no analyticity disc, no $\rho$, and hence no branch 2 or 3, which is what the record already records against $W_{\mathbb{CP}^2}$ at [second-order.md:1181](../findings/second-order.md#L1181), $\dim\ker W=3$.

**Argue the opposite.** The strongest defence of the finding is that the hypothesis is stated but the inequality that consumes it is not: $\rho(H)\ge g_n/\lVert H\rVert_{op}$ appears nowhere in the block, and line 1212's "Hence" asks the reader to reconstruct it. That is a real residual and it is named here, but it is a different finding from the one filed, which was that the hypothesis itself is absent. On the finding as written the text has moved and the charge no longer lands.

**Direction of consequence.** None: the repair adds a hypothesis and moves no bound.

**What the text should say.** It says it. The residual repair, if the record wants it, is one clause at line 1212 ("by $\rho(H)\ge g_n/\lVert H\rVert_{op}$, which is where $\ker W^*=0$ is spent"), turning an implicit step into a stated one.

## 2. F9, positivity of $\rho^{\text{eff}}_n$, HYPOTHESIS-DEBT

**Locate.** [second-order.md:1222–1223](../findings/second-order.md#L1222):

> $$\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert,\qquad\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big),$$
> **increasing from $0.71904$ at $n=12$ to $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.74238$.**

The closed form is new since the finding was filed (`b9a831ad` introduced it) and it does change the shape of the debt. It does not discharge it. What stands between the closed form and the conclusion is the word **increasing** and the endpoint pair, with no derivation anywhere in the block.

**Exhibit what is owed, in closed form.** Substituting $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ collapses the display to one term:

$$\rho^{\text{eff}}_n=\theta_0(n)\left[\frac{3(n-8)}{2(n-2)}-2\right]+\sqrt6=\sqrt6-\theta_0(n)\,\frac{n+16}{2(n-2)},$$

since $3(n-8)-4(n-2)=-(n+16)$. This agrees with the record's own $n$-form at [second-order.md:1322](../findings/second-order.md#L1322). At $n=12$ it is $\tfrac{\sqrt{55}}{10}-\tfrac{\sqrt{55}}3+\sqrt6=\sqrt6-\tfrac7{30}\sqrt{55}=0.719043429$, reproducing the block's $0.71904$ exactly; as $n\to\infty$ it tends to $\sqrt6-\tfrac{\sqrt2}2=1.742383$, reproducing the block's $1.74238$ exactly. Both endpoints are right.

Positivity across the range is then the polynomial inequality

$$\rho^{\text{eff}}_n>0\iff (n+16)^2(n-1)<12\,n^2(n-2)\iff D(n):=11n^3-55n^2-224n+256>0,$$

reached by squaring $\theta_0(n)(n+16)/(2(n-2))<\sqrt6$. At $n=12$, $D(12)=19008-7920-2688+256=8656$. **Neither this inequality, nor any equivalent of it, nor any argument for the monotonicity, appears in the block.** The block offers two evaluated values here and two more at line 1322 ($0.8724$, $0.9856$, $1.0727$), which is a table, not a proof.

**Precisely what is owed, and it is two statements rather than one.**

1. **Positivity, uniform in $n$**: $\inf_{n\ge12}\rho^{\text{eff}}_n>0$. This is what separates the two exponents, and the finding is right to say the gap is not cosmetic. At $\rho=0$ the second branch is $\sqrt{c_p}/(a_0n^{1/2}+nw)$, whose value at $w=1$ is $\sqrt{\kappa/n}/(a_0n^{1/2}+n)=\Theta(n^{-3/2})$, the very order the lemma exists to beat.
2. **$\rho^{\text{eff}}_n\ge\rho^{\text{eff}}_{12}$ for every even $n\ge12$**, which is strictly stronger than (1) and is what the proof of uniformity actually consumes. [second-order.md:1233](../findings/second-order.md#L1233) reads "whose $n$-free coefficient $\big(\tfrac{\sqrt2 n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$ **increases** in $n$ … and equals $0.7197978$ at $n=12$, **its minimum over even $n\ge12$**". That coefficient is $(a_0^2/\kappa+1/\rho)^{-1/2}$, so calling $n=12$ its minimum is exactly the claim $1/\rho_n\le1/\rho_{12}$, i.e. statement (2). The block's headline floor $g_\rho\ge0.71979/n$ rests on it.

**Argue the opposite.** Three defences, and none carries.

- *The closed form is checkable, so the reader can verify it.* True, and it is why the debt is smaller than when the finding was filed. But a checkable claim with no check on file is a hypothesis, and this programme's standing rule is that a lemma is correct only if its proof is correct. Verification by the reader is not an argument on the record.
- *The endpoints bracket the range, so positivity follows.* It does not: two endpoint values bound nothing about the interior of a family without monotonicity, and monotonicity is the thing being asserted.
- *Positivity holds under either reading of the penalty coefficient, so the debt is inert.* The block's own [$\tfrac29$ debt box](../findings/second-order.md#L1225) says the opposite ("**the monotonicity turns on it**") and its alternative reading is itself unproved.

**A defect found while checking this, reported because it sits inside the same claim.** [second-order.md:1225](../findings/second-order.md#L1225) states "**At coefficient 1 the constant reads $0.689771$ and *decreases* to a floor of $0.582938$**". Under the reading its own words give (the same display with $1$ in place of $\tfrac29$), the constant is

$$\rho^{(1)}_n=3\theta_0\frac{n-8}{2(n-2)}-9\big(\theta_0-\sqrt{3/2}\big)=9\sqrt{3/2}-\theta_0(n)\,\frac{3(5n-4)}{2(n-2)} ,$$

which at $n=12$ is $11.022704-1.236033\times8.4=0.640026$, and whose limit is $9\sqrt{3/2}-\tfrac{15}2\sqrt2=11.022704-10.606602=0.416102$. Hand values at $n=14,16,18,20$ are $0.613844$, $0.592857$, $0.575584$, $0.561346$, so it does decrease, monotonically, to $0.416102$. **The qualitative claim of that box holds and both of its numerals are wrong**, $0.689771$ against $0.640026$ is high by $7.8\%$, and the floor $0.582938$ against $0.416102$ is high by $40.1\%$; $0.582938$ is not a floor at all, being a value the family passes between $n=16$ and $n=18$. Both are numerals for a lower-bound coefficient, so both are wrong in the unsafe direction.

**Direction of consequence.** If $\rho^{\text{eff}}_n$ dips below $\rho^{\text{eff}}_{12}$ anywhere, the stated floor $0.71979/n$ is **too large**, an overstated lower bound in a chain that is a lower bound throughout, and the same failure mode `15c1a9ec` recorded when $0.7198$ was found to round $0.7197978$ upward. If $\rho^{\text{eff}}_n\to0$ the branch degrades to $\Theta(n^{-3/2})$ and the lemma's headline goes with it.

**What the text should say.** Statement (2) above, stated as the thing the proof consumes, together with whatever argument the record chooses to give for it; and the two numerals in the $\tfrac29$ box replaced by $0.640026$ and $0.416102$, with $0.416102$ named as a limit rather than a floor reached. One further wording point: "increasing … **to** $1.74238$" reads as attained, and $1.74238$ is a supremum approached as $n\to\infty$; since $\rho^{\text{eff}}$ enters as a lower-bound coefficient, reading it as attained would overstate.

## 3. F10, the $m=4$ argument, SUPERSEDED

**Locate.** The argument the finding attacks is no longer in the file. It read, in the `b9a831ad` text of the block:

> **WHAT THE COEFFICIENT DOES BUY, AND IT IS THE EXPONENT RATHER THAN THE CONSTANT.** At $\rho=0$, which is $m=4$, branch 2 degrades to $\Theta(n^{-3/2})$, *so $m\ge5$ is load-bearing for the $\Omega(n^{-1})$ conclusion itself, not merely for its constant*.

`1d5d1d26` deleted it; `git log -S 'WHAT THE COEFFICIENT DOES BUY'` returns exactly the pair that added and removed it, and `grep -n 'degrades to\|load-bearing for the'` over the current file returns nothing. What survives at $m=4$ is one scope clause inside the margin bullet at [second-order.md:1210](../findings/second-order.md#L1210): "the smallest off-summand margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$, which is **zero at $m=3$** and ties with $c_p$ at $m=4$, reaching $\ge\tfrac34\theta_0$ only from $m=5$."

**Exhibit the finding's own value, which is right.** At $m=4$, $\lambda_4=\tfrac{4-2}{2\cdot3}=\tfrac13$ and $\mu=\tfrac1{m-1}=\tfrac13$: the two coincide **exactly**. So $\Lambda^2\!\otimes\!\Lambda^2$ lies inside the $\lambda_m$-eigenspace of $L_e$ there. Reading the set-up at [second-order.md:1205](../findings/second-order.md#L1205) ("$H_s$ in the **joint** $\lambda_m$-eigenspace") as naming that eigenspace, the smallest margin strictly outside it is carried by the four zero-eigenvalue summands ($\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\!\otimes\!\mathbb R^q$, $X_q\!\otimes\!\mathbb R^p$) at $3\theta_0(\tfrac12-0)=\tfrac32\theta_0$, against $c_p=3\theta_0/(n-2)=\tfrac12\theta_0$ at $n=8$. Hence $\rho=c_{\min}-c_p=\tfrac32\theta_0-\tfrac12\theta_0=\theta_0>0$. **The finding's number is exact.** The deleted sentence's "$\rho=0$, which is $m=4$" was therefore a claim about a different subspace from the one the set-up names, and the failure it asserted at $m=4$ does not occur on the reading its own block supplies.

**Argue the opposite.** The set-up's apposition pins $H_s$ the other way: "$H_s$ in the joint $\lambda_m$-eigenspace, **both copies**, and $w:=\lVert H_r\rVert$ the weight outside **both**". Under that reading $H_s$ is the two $S^2_0(\mathbb R^m)$ copies as a subspace, whatever $L_e$ does elsewhere, and at $m=4$ the smallest margin outside them is $\Lambda^2\!\otimes\!\Lambda^2$'s $3\theta_0\tfrac{m-3}{2(m-1)}=\tfrac12\theta_0=c_p$, giving $\rho=0$. On that reading the surviving clause at line 1210 is exact, and so are its two companions: $3\theta_0\tfrac{m-3}{2(m-1)}$ is $0$ at $m=3$ and $\tfrac34\theta_0$ at $m=5$. **The two readings are equivalent for every $m\ge5$**, since $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}>0$ there, and they diverge only at $m=4$, which is $n=8$, outside the scope of every statement in this chain, the lemma being stated for $m\ge6$ and the programme for $n\ge12$.

**Direction of consequence.** None on any live claim: the sentence that would have been overstated is gone, and the divergence between the two readings is confined to a dimension no result in the chain reaches.

**What the text should say.** Nothing further is owed for the finding. The one clarification worth a clause, if the record wants the two readings never to diverge again, is at line 1205: $H_s$ is the span of the two $S^2_0(\mathbb R^m)$ copies, which **is** the $\lambda_m$-eigenspace exactly when $m\ge5$.

## 4. F11, $\kappa$ and $w^*$, UPHELD IN PART

The finding names two collisions. They have different fates, and the question put (whether a collision can mislead a reader who follows the text), is answered yes for one and moot for the other.

### 4a. $w^*$, superseded

Both occurrences are gone. The `b9a831ad` text carried $w^*$ twice with two different values: "$w^*=Bc/(\rho A)$" in a blockquote, and "$g$ has a single interior minimum at $w^*=Bc/A=\kappa n^{-1/2}$" in the proof, the same symbol for the stationary point of two different functions, differing by a factor $\rho$, in one block. `1d5d1d26` replaced the whole stationary-point analysis with the envelope argument now at [second-order.md:1229](../findings/second-order.md#L1229), whose first sentence is "**No case analysis on the location of the stationary point is needed**". `grep -n 'w\^\*'` over the current file returns one hit, at [second-order.md:1266](../findings/second-order.md#L1266), and it is inside [L158](../findings/second-order.md#lemma-l158-the-branch-comparison-turns-on-one-dimension-dependent-constant-and-it-says-suplvert-prvert-must-grow-before-i31-can-bind), a different block, where it names the operator-norm kink $0.553$. Nothing collides in L149.

### 4b. $\kappa$, upheld

**Locate.** Two symbols, both in L149, differing only by a subscript, naming quantities that differ in sign and by a factor $44$:

- [second-order.md:1222](../findings/second-order.md#L1222): "$\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big)$", which is $0.101594$ at $n=12$, with $\kappa_{12}=-0.101594$.
- [second-order.md:1229](../findings/second-order.md#L1229): "$c_p=\kappa/n$", used in the display at [second-order.md:1231](../findings/second-order.md#L1231), $\inf_{w\ge0}g_\rho=\frac1n\sqrt{\frac{\rho\,\kappa}{\rho\,a_0^2+\kappa}}$. Here $\kappa=n\,c_p=3\sqrt{2(n-1)/(n-2)}=4.449719$ at $n=12$.

**$\kappa$ is never defined in the block.** $c_p$ is never given as an equation inside L149 either, so "$c_p=\kappa/n$" defines neither symbol. The definition exists, at [second-order.md:1285](../findings/second-order.md#L1285), fifty-six lines below, inside L158, and L149 does not cite it. $\lvert\kappa_n\rvert$, by contrast, is defined in the block, seven lines above the collision.

**Exhibit the misleading, concretely.** A reader who follows the text reaches line 1231 with exactly one $\kappa$ defined and substitutes it. With $\rho=0.719043$, $a_0^2=2.4$ and $\kappa\mapsto\lvert\kappa_{12}\rvert=0.101594$:

$$\frac{\rho\kappa}{\rho a_0^2+\kappa}=\frac{0.073050}{1.725704+0.101594}=0.039977,\qquad \sqrt{\;}=0.199943,$$

against the block's $0.7197978$, **too small by a factor $3.60$**. With the signed $\kappa\mapsto\kappa_{12}=-0.101594$ it is worse: the numerator is $-0.073050$ and the denominator $1.624110$, so the radicand is $-0.044980$ and the square root does not exist. The correct substitution $\kappa=4.449719$ gives $a_0^2/\kappa=0.539360$, $1/\rho=1.390737$, and $(0.539360+1.390737)^{-1/2}=1.930097^{-1/2}=0.71980$, which is the block's number.

**And it has already misled, twice, on this record.** [second-order.md:1284](../findings/second-order.md#L1284) is a whole blockquote titled "**$\kappa$ IS ON THE RECORD AND THE ENTRY SAID IT WAS NOT**", closing "the entry had searched for the letter $\kappa$ rather than the quantity $n c_p$"; and [second-order.md:1322](../findings/second-order.md#L1322) records that "the base has never been reproduced from the record's constants by any reader who has tried". A collision that produces a documented false gap in one round and an unreproducible numeral in another is misleading in the operative sense the question asks about.

**Argue the opposite.** The defence is that $\kappa$ and $\kappa_n$ are typographically distinct, that the subscript is consistent, and that a reader who reaches L149 has passed [Lemma L145](../findings/second-order.md#lemma-l145-the-constant-chain-for-the-balanced-orbit-tube-radius-and-the-lower-bound-r_nomegan-32-it-supports), where $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ is fixed, so $\kappa=nc_p$ is recoverable. That defence is real but it is refuted by the record's own history: two rounds of readers, on this exact block, did not recover it. A distinction carried by a subscript alone, between a positive $4.45$ and a negative $-0.102$, inside one display, is not a distinction a reader is entitled to be held to.

**Direction of consequence.** No stated bound moves, the block's own numeral $0.7197978$ was computed with the right $\kappa$, as the reproduction above confirms. The damage is that the single checkable number in the lemma is not reproducible from the block, and that the branch-comparison threshold downstream in L158 turns on $\kappa$'s value, $4.45$ against a claimed $1.42$, which is the reversal recorded at [second-order.md:1288](../findings/second-order.md#L1288). A reader taking $0.199943$ would understate a lower bound, which is the safe direction; a reader taking $\kappa_{12}$ gets no number at all.

**What the text should say.** One clause at line 1229: $c_p=\kappa/n$ with $\kappa=n c_p=3\sqrt{2(n-1)/(n-2)}=4.4497$ at $n=12$, falling to $3\sqrt2$, the values already at [second-order.md:1285](../findings/second-order.md#L1285), imported rather than restated as new. Renaming one of the two symbols would serve as well and is the record's call.

## 5. F12, "the first is minimised at $w=0$", UPHELD

This candidate has been raised, withdrawn, withdrawn again and restored without ever being settled. It is settled here: **the clause is false, and the boxed statement built on it says something false.**

**Locate.** [second-order.md:1218](../findings/second-order.md#L1218), the lemma box itself:

> **LEMMA L149.** *For $m\ge6$, the second branch is $\Omega(n^{-1})$ **uniformly in $w\in[0,1]$**, the first is minimised at $w=0$, ***this clause does not follow and is owed***: [L148] pins the **variable** $u$ to zero on the named copy, not the **coefficient** $a$, and at $u=0$ with $a>0$ the function $f$ is *decreasing*, so $w=0$ is where branch 1 is largest rather than smallest. … Hence*
> $$r_n\;\gtrsim\;n^{-1-\beta}\quad\text{over every direction},\qquad\text{with }\Theta(n^{-1})\text{ the ceiling of the method.}$$

**Exhibit the failure in closed form.** Branch 1 is displayed at [second-order.md:1214](../findings/second-order.md#L1214) as $(c_p+u^2)/(S+au)$, and line 1216 states the only relation on file, $u\le w$. Write $f(u)=(c_p+u^2)/(S+au)$. Then

$$f'(0)=-\frac{a\,c_p}{S^2}<0,\qquad f'(u)=0\iff au^2+2Su-ac_p=0\iff u^*=\frac{\sqrt{S^2+a^2c_p}-S}{a},$$

and at that point $c_p=u^{*2}+2Su^*/a$, so $c_p+u^{*2}=\tfrac{2u^*}a(S+au^*)$ and

$$f(u^*)=\frac{2u^*}{a}=\frac{2\big(\sqrt{S^2+a^2c_p}-S\big)}{a^2}=\frac{2c_p}{\sqrt{S^2+a^2c_p}+S}\;\ge\;\frac{c_p}{S+a\sqrt{c_p}}\;\ge\;\tfrac12\min\!\Big(\frac{c_p}{S},\frac{\sqrt{c_p}}{a}\Big).$$

This is [L147](../findings/second-order.md#lemma-l147-the-tube-radius-tracks-suplvert-prvert-on-betain0tfrac12-and-the-route-ends-at-thetan-1)'s own identity, already on the record at [second-order.md:1179](../findings/second-order.md#L1179). Since $f$ is decreasing on $[0,u^*]$, the infimum over the feasible set $u\in[0,w]$ is $f(\min(u^*,w))$, which is **non-increasing in $w$**: $w=0$ gives $f(0)=c_p/S$, the largest value the branch takes, not the smallest. The clause is false, and the block's inline retraction of it is correct.

**And the consequence is an order, not a constant.** L149's own operator-norm chain gives $a=O(n^{1/2}+nw)$ at line 1212, and $c_p=\kappa/n=\Theta(1/n)$. Take $w=\Theta(1)$, so $a=\Theta(n)$ and $a^2c_p=\Theta(n)$. For $\beta<\tfrac12$, $S^2=\Theta(n^{2\beta})=o(n)$, so $\sqrt{S^2+a^2c_p}=\Theta(n^{1/2})$, $u^*=\Theta(n^{-1/2})$ (inside $[0,1]$) and

$$f(u^*)=\frac{2u^*}{a}=\Theta(n^{-3/2}).$$

So the branch-1 infimum over the feasible set is $\Theta(n^{-3/2})$, and the box's "Hence $r_n\gtrsim n^{-1-\beta}$ over every direction" is **false for every $\beta\in[0,\tfrac12)$**, which is the whole of L147's admissible range bar its endpoint. The witness is not new: it is the direction already named at [second-order.md:1171](../findings/second-order.md#L1171), "a single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$".

**The mechanism of the failure, which is the useful part.** The display at line 1214 puts $c_p$ in branch 1's numerator and $c_p+\rho^{\text{eff}}_nw^2$ in branch 2's. The same margin $c(H)$ produced both, so branch 1 has been handed the uniform floor where branch 2 keeps the direction's own value. That substitution is legitimate as an inequality and it is exactly what discards the lemma's sweep: the sweep says a direction with $\lVert A''\rVert=\Theta(n)$ has $w=\Theta(1)$ and hence $c(H)=\Theta(1)$, and branch 1 as displayed cannot see that, because its numerator was frozen at $\Theta(1/n)$ before the sweep was applied.

**Argue the opposite.** The strongest defence is that the box is honest: it prints the clause and immediately marks it "***this clause does not follow and is owed***", crediting three verifiers, so no reader is deceived about its status. That defence covers the clause and fails on the display. The word between them is "**Hence**", and the display it introduces is the lemma's conclusion, asserted without qualification, in the box, downstream of a premise the same box has just withdrawn. A second defence, that $\Omega$ rather than $\Theta$ makes the display safe, runs the wrong way: $\gtrsim$ is a lower bound, and a lower bound stated at $n^{-1-\beta}$ when the branch reaches $n^{-3/2}$ is stated **too large**. A third, that branch 1 might not attain $u=u^*$ because $u$ is determined by $H$ rather than free, is the correct objection in principle, but the record's only constraint on $u$ is $u\le w$, so the block cannot invoke it, and line 1171's witness supplies the direction anyway.

**Direction of consequence.** The stated lower bound is **too large**, on the interval $\beta\in[0,\tfrac12)$. Downstream, [L158](../findings/second-order.md#L1278) takes $\inf_w\text{branch }1=\kappa/(nS)$, which is precisely the $w=0$ value, and builds its branch-comparison ratio on it, so the overstatement propagates into the threshold at [second-order.md:1280](../findings/second-order.md#L1280); note that [second-order.md:1298](../findings/second-order.md#L1298) of the same block already refutes the $(c_p+w^2)/S$ form it uses, so L158 currently disagrees with itself about branch 1. The record's confirmed headline, $r_n=\Omega(n^{-3/2})$ at [second-order.md:1111](../findings/second-order.md#L1111), is untouched: it is exactly what the corrected branch-1 infimum returns.

**What the text should say, and it is determinate.** Branch 1's numerator carries the direction's own margin, matching branch 2: $f(u)=\big(c(H)+u^2\big)/(S+au)$ with $c(H)\ge c_p+\rho^{\text{eff}}_nw^2$. Then the bound derived above reads

$$\text{branch }1\;\ge\;\tfrac12\min\!\left(\frac{c(H)}{S},\ \frac{\sqrt{c(H)}}{a}\right),\qquad \frac{\sqrt{c(H)}}{a}\;=\;\frac{\sqrt{c_p+\rho^{\text{eff}}_nw^2}}{a_0n^{1/2}+nw}\;=\;g_\rho(w),$$

so the second alternative is the lemma's own $g_\rho$ and is $\ge0.71979/n$ by the proof already in the block, while the first is $\ge c_p/S=\Theta(n^{-1-\beta})$. The minimum of the two is $\Theta(n^{-1-\beta})$ for every $\beta\ge0$, and the display is recovered, **through the sweep, uniformly in $w$, with no claim about where branch 1 is minimised**. The clause "the first is minimised at $w=0$" is then deleted rather than repaired, since nothing needs it.

## What the record must act on

**Two of the five.** [F12](#5-f12-the-first-is-minimised-at-w0-upheld) is the one that moves a bound: the lemma box asserts $r_n\gtrsim n^{-1-\beta}$ from a premise the box itself withdraws, the claim is false on $\beta\in[0,\tfrac12)$ as the block's display stands, and the repair is written out above in closed form. [F9](#2-f9-positivity-of-rhotexteff_n-hypothesis-debt) is the one that must be stated as a debt rather than repaired: $\rho^{\text{eff}}_n\ge\rho^{\text{eff}}_{12}$ for every even $n\ge12$ is what the uniformity proof consumes and nothing on file proves it, and the $\tfrac29$ box's two alternative numerals are wrong in the unsafe direction and should read $0.640026$ and $0.416102$. [F11](#4-f11-kappa-and-w-upheld-in-part) costs one clause of repair and no mathematics. [F7](#1-f7-the-kernel-hypothesis-superseded) and [F10](#3-f10-the-m4-argument-superseded) were repaired by `1d5d1d26` and need nothing.
