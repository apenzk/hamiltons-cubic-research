# REVIEW r722, the $\rho^{\mathrm{eff}}$ positivity derivation is built on a mistranscribed $\theta_0$, and the cubic it rejected is the right one

**Gate 2, cold brief.** Reviewer r722 on the candidate `F9, the two positivity statements the block consumes`, held at `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/f9-positivity.md` and not on the record. Every algebraic step below was redone from the definitions before the candidate's own working was read against it. The programme is on an analysis-only footing ([analysis-only.md](../.claude/rules/analysis-only.md)): the one piece of arithmetic run here is a seconds-long screen of four closed-form values I was about to record, reported as a screen in §6 and load-bearing for nothing. Log: [agent_logs/r722.log](../agent_logs/r722.log).

| # | Claim under review | Verdict |
|---|---|---|
| 1 | The starting closed form, $\rho^{\mathrm{eff}}_n=\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$ with $\theta_0(n)=\sqrt{2(n-1)/(n-2)}$ | **REFUTED**, $\theta_0$ is mistranscribed; the form returns $0.3729542$ at $n=12$ against the record's $0.7190434$ |
| 2 | Claim 1's cubic $P(n)=11n^3-103n^2-80n+160$ | **REFUTED** |
| 3 | Claim 1's expansions and subtraction, taken from its own starting form | **CONFIRMED AS ALGEBRA**, internally exact, and it proves nothing about $\rho^{\mathrm{eff}}$ |
| 4 | The recorded disagreement: the adjudicator's $11n^3-55n^2-224n+256$ | **CONFIRMED**, the adjudicator is right and the candidate is wrong |
| 5 | Claim 1's conclusion, $\rho^{\mathrm{eff}}_n>0$ for all $n\ge12$ | **CONFIRMED**, by the corrected derivation given in §4, not by the one on offer |
| 6 | Claim 2's log-derivative numerator $-37n+20$ | **REFUTED**, the numerator is $-33n^2+80n-64$ |
| 7 | Claim 2's sign convention and the direction $T\downarrow\Rightarrow\rho^{\mathrm{eff}}\uparrow$ | **CONFIRMED** |
| 8 | Claim 2's conclusion, $\rho^{\mathrm{eff}}_n$ strictly increasing, hence $\ge\rho^{\mathrm{eff}}_{12}$ | **CONFIRMED**, by the corrected derivation in §5 |
| 9 | The scope caveat on the $\tfrac29$ penalty coefficient | **REFUTED AS STATED**, under coefficient $1$ Claim 2 is false, not merely unproved, and a second conditioning is omitted |
| 10 | "Both owed statements are proved" | **REFUTED** |
| 11 | That the candidate supplies mathematics the record lacks | **REFUTED**, monotonicity is proved in two lines at [VERIFY_v14.md:51](../verification/VERIFY_v14.md#L51), and positivity follows from it |

**In one line:** both conclusions are true and neither derivation is, because the candidate substituted $\kappa/3$ for $\theta_0$, and the "different cubic" it flagged as a discrepancy for this gate to settle is the correct one.

## 0. Conventions, fixed once

The record fixes $\theta_0$ once, in the setting of the $\kappa^{\mathrm{Hess}}_n$ lemma at [second-order.md:887](../findings/second-order.md#L887):

$$\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n},\qquad \theta_0(12)=\frac{\sqrt{220}}{12}=\frac{\sqrt{55}}{6}=1.2360331 .$$

The effective margin coefficient is [second-order.md:1222](../findings/second-order.md#L1222)'s

$$\rho^{\mathrm{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert,\qquad \lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big),$$

the absolute value taking that sign only where $\theta_0(n)\ge\sqrt{3/2}$, which is $n\ge12$ and is the range in play. Substituting $\tfrac29\lvert\kappa_n\rvert=2(\theta_0-\sqrt{3/2})$ and using $3(n-8)-4(n-2)=-(n+16)$ collapses it to the record's one-term form,

$$\rho^{\mathrm{eff}}_n=2\sqrt{3/2}-\theta_0(n)\frac{n+16}{2(n-2)}=\sqrt6-\underbrace{\frac{n+16}{2n}\sqrt{\frac{2(n-1)}{n-2}}}_{=:\;p(n)},$$

the last equality because $\theta_0(n)=\sqrt{2(n-1)/(n-2)}\cdot\tfrac{n-2}{n}$, so the factor $n-2$ in the denominator cancels against $\theta_0$'s and leaves $2n$. This is the form printed independently at [VERIFY_v46.md:40](../verification/VERIFY_v46.md#L40) and [VERIFY_v14.md:48](../verification/VERIFY_v14.md#L48).

A third quantity shares the neighbourhood and is the trap this review turns on. [second-order.md:1229](../findings/second-order.md#L1229) defines $\kappa:=nc_p=3\theta_0n/(n-2)=3\sqrt{2(n-1)/(n-2)}$, and warns in that same line that "the record has twice documented readers misled by this". So

$$\sqrt{\frac{2(n-1)}{n-2}}=\frac{\kappa}{3}=\theta_0(n)\cdot\frac{n}{n-2},$$

which is $\theta_0$ inflated by $n/(n-2)$, a factor of $1.2$ at $n=12$.

Throughout, $T(n):=\theta_0(n)\tfrac{n+16}{2(n-2)}=p(n)$, so positivity is $T<\sqrt6$ and $\rho^{\mathrm{eff}}=\sqrt6-T$.

## 1. The closed form the candidate starts from is not the record's

The candidate's line 14 reads

    rho_eff(n) = sqrt(6) - theta_0(n) * (n+16) / (2(n-2)),    theta_0(n) = sqrt(2(n-1)/(n-2))

The first half is the record's display verbatim. The second half is the defect: $\sqrt{2(n-1)/(n-2)}$ is $\kappa/3$, not $\theta_0$. Composing the two multiplies the record's $T$ by $n/(n-2)$.

**Located.** The parenthetical `theta_0(n) = sqrt(2(n-1)/(n-2))` on line 14 of the candidate. Nothing in the record assigns $\theta_0$ that value; [second-order.md:887](../findings/second-order.md#L887) assigns it $\sqrt{2(n-1)(n-2)}/n$.

**Exhibited, in closed form at a named value.** At $n=12$ the record's $T$ is

$$T(12)=\frac{\sqrt{55}}{6}\cdot\frac{28}{20}=\frac{7\sqrt{55}}{30}=1.7304463,\qquad \rho^{\mathrm{eff}}_{12}=\sqrt6-\frac{7\sqrt{55}}{30}=0.7190434,$$

which is the numeral the record prints beside the display at [second-order.md:1324](../findings/second-order.md#L1324) and again at [second-order.md:1223](../findings/second-order.md#L1223), and which [VERIFY_v38.md:42](../verification/VERIFY_v38.md#L42), [VERIFY_v39.md:108](../verification/VERIFY_v39.md#L108) and [VERIFY_v47.md:55](../verification/VERIFY_v47.md#L55) each reproduce independently. The candidate's form gives instead

$$T_{\text{cand}}(12)=\sqrt{2.2}\cdot\frac{28}{20}=\frac{7\sqrt{55}}{25}=2.0765356,\qquad \sqrt6-T_{\text{cand}}(12)=0.3729542,$$

which is $\tfrac65$ of the record's $T$ and misses the record's own $\rho^{\mathrm{eff}}_{12}$ by a factor of $1.928$. The record carries four values, $0.7190$, $0.8724$, $0.9856$, $1.0727$ at $n=12,14,16,18$ ([second-order.md:1324](../findings/second-order.md#L1324)); the candidate's form reproduces none of them.

**Argued the opposite.** The strongest defence is that the candidate quotes the record's display character for character, so any fault is the record's. It fails on two counts. First, the record's display is correct under the record's own $\theta_0$, the candidate supplied the wrong value for a symbol the record had already fixed, and did so without checking it against the four numerals sitting one screen away. Second, the candidate's own §"What is owed" says "The record carries the closed form and four evaluated values", so it knew the values were there to check against and did not check. A derivation that contradicts the four data points it names in its opening paragraph has refuted itself before it begins.

## 2. Claim 1's algebra, redone independently

Taking the candidate's starting form at face value, I expand from scratch.

$(n+16)^2=n^2+32n+256$. Then

$$(n-1)(n^2+32n+256)=n^3+32n^2+256n-n^2-32n-256=n^3+31n^2+224n-256 .$$

$(n-2)^3=n^3-6n^2+12n-8$, so $12(n-2)^3=12n^3-72n^2+144n-96$. Subtracting,

$$12(n-2)^3-(n-1)(n+16)^2=(12-1)n^3+(-72-31)n^2+(144-224)n+(-96+256)=11n^3-103n^2-80n+160 .$$

So the candidate's $P(n)$ is exactly what its own starting inequality yields, and its $P(12)=19008-14832-960+160=3376$ is right; independently, $12\cdot10^3-11\cdot784=12000-8624=3376$. Its derivative argument is sound in form: $P''(n)=66n-206>0$ for $n\ge4$, $P'(12)=4752-2472-80=2200>0$, hence $P'>0$ and $P$ increasing on $n\ge12$.

**Verdict CONFIRMED AS ALGEBRA.** Every line follows from the line above. The inequality being manipulated is about a function that is not $\rho^{\mathrm{eff}}_n$, so the chain establishes nothing about the record's quantity.

## 3. The recorded disagreement, settled

The candidate flags at its line 34: *"this disagrees with the polynomial one adjudicator reported ($11n^3-55n^2-224n+256$). Recorded as a discrepancy for Gate 2 rather than resolved here."* The adjudicator is [VERIFY_v47.md:59](../verification/VERIFY_v47.md#L59), carried into [ROUND_L149F.md:39](../verification/ROUND_L149F.md#L39).

I derive the inequality from the record's $\theta_0$ without reference to either party. With $T=\theta_0(n)\tfrac{n+16}{2(n-2)}$ and $\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{n^2}$,

$$T(n)^2=\frac{2(n-1)(n-2)}{n^2}\cdot\frac{(n+16)^2}{4(n-2)^2}=\frac{(n-1)(n+16)^2}{2n^2(n-2)} .$$

Both sides positive, so $T<\sqrt6\iff T^2<6\iff (n-1)(n+16)^2<12n^2(n-2)=12n^3-24n^2$. Subtracting the expansion of §2,

$$12n^3-24n^2-\big(n^3+31n^2+224n-256\big)=11n^3-55n^2-224n+256=:D(n).$$

**The adjudicator's cubic is the correct one, and the candidate's is not.** The whole of the difference is the factor $n/(n-2)$ from §1: the candidate's denominator $12(n-2)^3$ should be $12n^2(n-2)$, and $-24n^2+0n+0$ against $-72n^2+144n-96$ accounts for the $-103$ versus $-55$, the $-80$ versus $-224$ and the $+160$ versus $+256$ term by term. Independent check at $n=12$: $12\cdot144\cdot10-11\cdot784=17280-8624=8656=D(12)$, which is $19008-7920-2688+256$.

The candidate's provisional framing (that the two cubics are rival readings and Gate 2 must choose), understates the asymmetry. The adjudicator's cubic is the one whose $\rho^{\mathrm{eff}}$ matches all four recorded numerals; the candidate's belongs to a function that matches none.

## 4. Claim 1's conclusion, proved

$D(12)=8656>0$. $D'(n)=33n^2-110n-224$, so $D'(12)=4752-1320-224=3208>0$; $D''(n)=66n-110>0$ for $n\ge2$, so $D'$ is increasing on $n\ge12$ and therefore positive there; so $D$ is increasing on $n\ge12$ and $D(n)\ge D(12)=8656>0$ for every $n\ge12$.

Hence $\rho^{\mathrm{eff}}_n>0$ for all $n\ge12$, and in fact $\rho^{\mathrm{eff}}_n\ge\rho^{\mathrm{eff}}_{12}=0.7190434$ by §5, which is the uniform-in-$n$ statement [VERIFY_v47.md:63](../verification/VERIFY_v47.md#L63) identifies as what separates $\Omega(n^{-1})$ from $\Theta(n^{-3/2})$. **The conclusion stands; the route to it in the candidate does not.**

## 5. Claim 2, recomputed from scratch

The candidate's numerator, computed independently: $(n+16)(n-2)=n^2+14n-32$; $2(n-1)(n-2)=2n^2-6n+4$; $3(n-1)(n+16)=3n^2+45n-48$. Summing the first two and subtracting the third gives $(1+2-3)n^2+(14-6-45)n+(-32+4+48)=-37n+20$. So the candidate's arithmetic is again internally exact, and again for the wrong $T$.

For the record's $T$, $T^2=\dfrac{(n-1)(n+16)^2}{2n^2(n-2)}$, so

$$Q(n):=\log T^2=\log(n-1)+2\log(n+16)-\log2-2\log n-\log(n-2),\qquad Q'(n)=\frac1{n-1}+\frac2{n+16}-\frac2n-\frac1{n-2}.$$

Over the common denominator $n(n-1)(n-2)(n+16)$, which is positive on $n\ge12$, the numerator is

$$\underbrace{n(n-2)(n+16)}_{n^3+14n^2-32n}+\underbrace{2n(n-1)(n-2)}_{2n^3-6n^2+4n}\;\underbrace{-\,2(n-1)(n-2)(n+16)}_{-2n^3-26n^2+92n-64}\;\underbrace{-\,n(n-1)(n+16)}_{-n^3-15n^2+16n}\;=\;-33n^2+80n-64 .$$

The cubic terms cancel, $14-6-26-15=-33$, $-32+4+92+16=80$, and the constant is $-64$. This quadratic has discriminant $80^2-4\cdot33\cdot64=6400-8448=-2048<0$ with negative leading coefficient, so it is **strictly negative at every real $n$**, a stronger statement than the candidate's linear numerator delivers, and one that needs no restriction to $n\ge12$.

Hence $Q'<0$, so $T^2$ is strictly decreasing on $n\ge12$; $T>0$ there, so $T$ is strictly decreasing; and $\rho^{\mathrm{eff}}=\sqrt6-T$ with $\sqrt6$ constant, so $\rho^{\mathrm{eff}}$ is strictly increasing and $\rho^{\mathrm{eff}}_n\ge\rho^{\mathrm{eff}}_{12}$ for every $n\ge12$. **The direction is right**, and it is right for the reason the candidate gives: subtracting a decreasing function from a constant increases it.

**Exhibited at a named value.** At $n=12$ the true $Q'$ is $\tfrac1{11}+\tfrac2{28}-\tfrac2{12}-\tfrac1{10}=-\tfrac{3856}{36960}=-0.1043290$, while the candidate's $Q'$ is $\tfrac1{11}+\tfrac2{28}-\tfrac3{10}=-\tfrac{424}{3080}=-0.1376623$. Both negative, so the conclusion survives; the numbers are different objects and only one of them is the log-derivative of the record's $T^2$.

## 6. The screen

One screen, seconds of compute, on expressions I typed for the purpose: $\theta_0(n)$, $\rho^{\mathrm{eff}}_n$ under both readings, $D$ and $P$ at $n=12$, and both log-derivatives at $n=12$. It agreed with every hand computation above to the digits printed: $\theta_0(12)=1.2360331$; $\rho^{\mathrm{eff}}=0.7190434,\,0.8723896,\,0.9856396,\,1.0727372$ at $n=12,14,16,18$ against the candidate's form's $0.3729542,\,0.6095396,\,0.7765182,\,0.9006431$; $D(12)=8656$, $P(12)=3376$; $-0.1043290$ against $-0.1376623$. Reported as a screen. Every positive claim in this review rests on the closed-form algebra of §§2–5, which stands without it.

## 7. The scope caveat

The candidate's closing paragraph says the two statements "are conditional on the $2/9$ reading, since a different penalty coefficient changes $\rho^{\mathrm{eff}}$ and would need the argument re-run."

**Correct in substance, and wrong in strength.** Writing the penalty coefficient as $c$ and using $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$,

$$\rho^{(c)}_n=\theta_0\left[\frac{3(n-8)}{2(n-2)}-9c\right]+9c\sqrt{3/2},$$

so $c$ moves both the coefficient of $\theta_0$ and the additive constant, and the direction in $n$ is not invariant under it. At $c=1$ the record itself states the outcome, at [second-order.md:1225](../findings/second-order.md#L1225): *"At coefficient $1$ the constant reads $0.689771$ and **decreases** to a floor of $0.582938$, reversing the monotonicity above."* Reading the same $c=1$ family directly, $\rho^{(1)}_{12}=0.7416199-0.1015938=0.6400261$ falls to the limit $\tfrac32\sqrt2-9\big(\sqrt2-\sqrt{3/2}\big)=2.1213203-1.7052183=0.4161020$, the $\tfrac32\theta_0-\lvert\kappa_n\rvert=0.4161$ the record prints at [second-order.md:1382](../findings/second-order.md#L1382). So under the other reading of the debt **Claim 2 is false**, not merely unproved, and "would need the argument re-run" misdescribes what happens: re-running it returns the opposite conclusion. Claim 1 survives $c=1$ with a different infimum, and would need its own argument.

**And the caveat is incomplete in two further places.** It does not record that $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ carries that sign only for $n\ge12$, so the one-term closed form the whole derivation rests on is itself range-restricted rather than an identity; the derivation uses the restriction without naming it. And it does not flag the far larger conditionality that §1 establishes, that the form it differentiated is not the record's.

## 8. Whether the derivation was needed

**Monotonicity is already proved on the record, in two lines, correctly.** [VERIFY_v14.md:51](../verification/VERIFY_v14.md#L51), an adjudicator in the earlier [ROUND_L149](../verification/ROUND_L149.md), writes $\rho^{\mathrm{eff}}_n=\sqrt6-\tfrac{(n+16)\kappa}{6n}$ and observes that $\tfrac{n+16}{6n}=\tfrac16+\tfrac8{3n}$ and $\kappa=3\sqrt2\sqrt{1+\tfrac1{n-2}}$ are both positive and decreasing in $n$, so their product decreases and $\rho^{\mathrm{eff}}$ increases. I have checked both factorisations and the identity: $\tfrac{(n+16)\kappa}{6n}=\tfrac{n+16}{2n}\sqrt{\tfrac{2(n-1)}{n-2}}=p(n)$, and a product of two positive decreasing functions is decreasing. The argument is complete, it needs no derivative, and it is stronger in presentation than the log-derivative route.

**Positivity is then a corollary rather than a separate problem.** $\rho^{\mathrm{eff}}$ increasing together with the single evaluation $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434>0$ gives $\rho^{\mathrm{eff}}_n\ge0.7190434$ for every $n\ge12$, which is both statements at once. The cubic in §4 is a second, independent route to the weaker half; the whole apparatus of $P$, $P'$ and $P''$ in the candidate is unnecessary even when correctly derived.

**So [ROUND_L149F.md:39](../verification/ROUND_L149F.md#L39)'s "nothing on file proves either" is false as to monotonicity**, and true only of [findings/](../findings/) and of the L149 block itself. [VERIFY_v46.md:45](../verification/VERIFY_v46.md#L45) reaches the same factorisation and stops one sentence short (*"the direction of each in $n$ decides the direction of $\rho^{\mathrm{eff}}$"*), declining to finish on the ground that "supplying the proof is the record's job". The finishing sentence was already written in the round before.

## 9. Verdict

The candidate is **REFUTED as a derivation** and its two conclusions are **CONFIRMED as statements**, by the corrected routes in §4 and §5 and, more economically, by the argument already at [VERIFY_v14.md:51](../verification/VERIFY_v14.md#L51).

What would make it recordable is small and specific: replace $\theta_0(n)=\sqrt{2(n-1)/(n-2)}$ by the record's $\sqrt{2(n-1)(n-2)}/n$; adopt $D(n)=11n^3-55n^2-224n+256$ and withdraw the discrepancy note in favour of citing [VERIFY_v47.md:59](../verification/VERIFY_v47.md#L59); replace the numerator $-37n+20$ by $-33n^2+80n-64$, or drop the log-derivative for v14's two-factor argument; derive positivity as a corollary of monotonicity rather than in parallel; state the $n\ge12$ restriction on the $\lvert\kappa_n\rvert$ sign as a hypothesis; and say of the $\tfrac29$ debt that the other reading **reverses** the monotonicity, which the record already asserts in print.
