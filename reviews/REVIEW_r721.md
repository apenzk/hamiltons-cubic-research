# Review r721, the $\rho^{\text{eff}}$ positivity derivation reduces the wrong function, and the adjudicator's cubic is the right one

**Reviewer r721, Gate 2, cold brief.** The object under review is a scratchpad derivation of the two statements [Lemma L149](../findings/second-order.md) consumes without argument, $\rho^{\text{eff}}_n>0$ on $n\ge12$, and the stronger $\rho^{\text{eff}}_n\ge\rho^{\text{eff}}_{12}$. It is not on the record. Every load-bearing step below is exact hand algebra over $\mathbb Z[n]$; the decimal evaluations are seconds-long screens of claims I was about to record, run under the screening allowance of [analysis-only.md](../.claude/rules/analysis-only.md), and no search, sweep or falsifier hunt was opened. Log: [agent_logs/r721.log](../agent_logs/r721.log).

## Verdicts

| # | Claim under review | Verdict |
|---|---|---|
| 1 | The closed form $\rho^{\text{eff}}_n=\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$ transcribes the record's definition | **CONFIRMED** |
| 2 | The parenthetical gloss $\theta_0(n)=\sqrt{2(n-1)/(n-2)}$ | **REFUTED**, the record's $\theta_0$ is $\sqrt{2(n-1)(n-2)}/n$; the printed value is $\kappa/3$ |
| 3 | Claim 1's squaring, the two expansions and the subtraction, taken as arithmetic | **CONFIRMED AS ALGEBRA** |
| 4 | Claim 1's reduction to $P(n)=11n^3-103n^2-80n+160>0$ | **REFUTED**, $P$ is the reduction of a function the record does not carry |
| 5 | The adjudicator's rival cubic $11n^3-55n^2-224n+256>0$ | **CONFIRMED**, it is the correct reduction, and [VERIFY_v47](../verification/VERIFY_v47.md) already had it |
| 6 | Claim 1's conclusion, $\rho^{\text{eff}}_n>0$ for all $n\ge12$ | **CONFIRMED**, true, and proved here on the corrected cubic |
| 7 | Claim 2's log-derivative numerator $-37n+20$ | **REFUTED**, the correct numerator is $-33n^2+80n-64$ |
| 8 | Claim 2's sign convention and direction ($T\downarrow\Rightarrow\rho^{\text{eff}}\uparrow$) | **CONFIRMED** |
| 9 | Claim 2's conclusion, $\rho^{\text{eff}}$ strictly increasing, hence $\ge\rho^{\text{eff}}_{12}$ | **CONFIRMED**, true, and proved here on the corrected numerator |
| 10 | The scope caveat "both statements are conditional on the $\tfrac29$ coefficient" | **REFUTED AS STATED**, it names the debt the derivation does not depend on and omits the one it does |
| 11 | That the record already proves either statement elsewhere | **UNPROVEN**, nothing on file; F9 is genuinely owed |

**One line.** Both conclusions are true and both routes to them are wrong: the derivation reads $\theta_0$ as $\sqrt{2(n-1)/(n-2)}$ where the record fixes $\theta_0^2=2(n-1)(n-2)/n^2$, so its cubic and its log-derivative numerator both price a function whose value at $n=12$ is $0.3730$ against the record's $0.7190434$, and the cubic the derivation flags as a disagreement to be settled is the correct one.

## 0. Conventions, fixed once

- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, from [conventions.md](../findings/conventions.md), which fixes it as "the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more". At $n=12$ this is $\sqrt{220}/12=\sqrt{55}/6=1.2360331$.
- $\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big)$, which is $0.1015939$ at $n=12$, the quantity [second-order.md:1229](../findings/second-order.md) warns is one subscript from $\kappa:=nc_p=3\theta_0n/(n-2)=3\sqrt{2(n-1)/(n-2)}=4.4497$.
- $\rho^{\text{eff}}_n:=3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert$, the display in [Lemma L149](../findings/second-order.md).
- The range is even $n\ge12$, i.e. $m\ge6$; the record narrows it there because $\rho^{\text{eff}}$ has no definition at $n=10$. Every polynomial statement below is proved on the real half-line $n\ge12$, which covers it.
- $T(n):=\theta_0(n)\tfrac{n+16}{2(n-2)}$, so that $\rho^{\text{eff}}_n=\sqrt6-T(n)$ once §1 is granted, and $T>0$ on the range.

## 1. The closed form is a correct transcription, CONFIRMED

Substituting $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ into the display and using $2\sqrt{3/2}=\sqrt6$:

$$\rho^{\text{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-2\big(\theta_0-\sqrt{3/2}\big)=\sqrt6+\theta_0\left[\frac{3(n-8)-4(n-2)}{2(n-2)}\right]=\sqrt6+\theta_0\cdot\frac{-n-16}{2(n-2)}=\sqrt6-\theta_0(n)\frac{n+16}{2(n-2)} .$$

The identity is exact and needs no hypothesis beyond $n>2$. It is also the form [second-order.md:1324](../findings/second-order.md) already prints, as $2\sqrt{3/2}-\theta_0(n)\tfrac{n+16}{2(n-2)}$.

**Screen against the four evaluated values the record carries** ($0.7190$, $0.8724$, $0.9856$, $1.0727$ at $n=12,14,16,18$). With the record's $\theta_0$ the closed form returns $0.7190434$, $0.8723896$, $0.9856396$, $1.0727372$, four for four, and the exact $n=12$ value $\sqrt6-\tfrac7{30}\sqrt{55}$ falls out because $\theta_0(12)\cdot\tfrac{28}{20}=\tfrac{\sqrt{55}}6\cdot\tfrac75=\tfrac7{30}\sqrt{55}$.

## 2. The gloss on $\theta_0$ is the defect everything else follows from, REFUTED

**Located.** Line 14 of the derivation: `theta_0(n) = sqrt(2(n-1)/(n-2))`.

**The failure, concretely, at $n=12$.** That reading gives $\theta_0(12)=\sqrt{2.2}=1.4832397$, hence

$$\sqrt6-\sqrt{2.2}\cdot\tfrac{28}{20}=2.4494897-2.0765356=0.3729542,$$

against the record's $\rho^{\text{eff}}_{12}=0.7190434$, a factor $1.928$ out. The same substitution puts $\lvert\kappa_{12}\rvert=9(\sqrt{2.2}-\sqrt{3/2})=2.3264534$ where the record has $0.1015939$, a factor $22.9$, and makes the record's own $\kappa=3\theta_0n/(n-2)$ evaluate to $5.3397$ rather than the $4.4497$ that line asserts. Three independent contradictions with the record, from one gloss.

**What the printed quantity actually is.** $\sqrt{2(n-1)/(n-2)}=\kappa/3$, the *other* member of the pair the record twice documents readers confusing. The derivation walked into the trap that [ROUND_L149-F](../verification/ROUND_L149F.md) F11 was upheld for naming.

**Argued the opposite, the strongest defence.** The closed form on the line above the gloss is right (§1), so a reader who ignores the gloss and substitutes the record's $\theta_0$ recovers every correct value; the gloss could be read as a stray annotation rather than a premise. **The defence fails on use:** the very next display squares it, `2(n-1)(n+16)^2 / (4(n-2)^3)`, which is $\theta_0^2\cdot(n+16)^2/(4(n-2)^2)$ only under the wrong reading. The gloss is load-bearing for both claims, not decorative.

## 3. Claim 1's arithmetic is sound, and its cubic is still wrong, CONFIRMED AS ALGEBRA / REFUTED

**Redone independently, coefficient by coefficient.**

$(n+16)^2=n^2+32n+256$. Then

$$(n-1)(n^2+32n+256)=n^3+32n^2+256n-n^2-32n-256=n^3+31n^2+224n-256,$$

and $(n-2)^3=n^3-6n^2+12n-8$, so $12(n-2)^3=12n^3-72n^2+144n-96$. Subtracting,

$$12(n-2)^3-(n-1)(n+16)^2=11n^3-103n^2-80n+160 .$$

Every printed step reproduces, including $P(12)=3376$, $P'(12)=2200$ and $P''>0$ for $n\ge4$; the monotonicity closure is valid as written. **So the arithmetic is confirmed and the object is wrong**: with the record's $\theta_0$,

$$T(n)^2=\frac{2(n-1)(n-2)}{n^2}\cdot\frac{(n+16)^2}{4(n-2)^2}=\frac{(n-1)(n+16)^2}{2n^2(n-2)},$$

whose denominator is $2n^2(n-2)$, not $2(n-2)^3$. The derivation's $P$ is the correct reduction of a function that is not $\rho^{\text{eff}}$.

## 4. The recorded disagreement, settled: the rival cubic is the right one, CONFIRMED

Since $T>0$, $T<\sqrt6\iff T^2<6$, and from §3's $T^2$,

$$(n-1)(n+16)^2<12\,n^2(n-2)=12n^3-24n^2\iff R(n):=11n^3-55n^2-224n+256>0 .$$

Coefficients: $12-1=11$; $-24-31=-55$; $0-224=-224$; $0-(-256)=+256$. **This is the adjudicator's cubic**, and it is the one [VERIFY_v47](../verification/VERIFY_v47.md) records at its line 59 in exactly this form, $(n+16)^2(n-1)<12n^2(n-2)$. The two cubics differ by $48n^2-144n+96=48(n-1)(n-2)$, which is precisely $12\big[n^2(n-2)-(n-2)^3\big]$, the denominator error, isolated.

**Exhibited at a named value.** $12\cdot12^2\cdot10-11\cdot28^2=17280-8624=8656=R(12)$, while $12\cdot10^3-8624=3376=P(12)$. The true margin at $n=12$ is $8656$, not $3376$; that the derivation's number is *smaller* is why the wrong reduction still reached a true conclusion.

**Claim 1's conclusion, proved.** $R(12)=8656>0$; $R'(n)=33n^2-110n-224$ with $R'(12)=4752-1320-224=3208>0$; $R''(n)=66n-110>0$ for $n\ge2$. So $R'$ is increasing and positive at $12$, $R$ is increasing on $n\ge12$, and $R(n)\ge8656>0$ throughout. Hence $\rho^{\text{eff}}_n>0$ for every real $n\ge12$. **CONFIRMED, the conclusion, on a corrected argument.**

## 5. Claim 2's numerator is wrong; its direction is right, REFUTED / CONFIRMED

**The direction first, since it is the half that survives.** $\rho^{\text{eff}}=\sqrt6-T$ with $\sqrt6$ constant, so $\tfrac{d}{dn}\rho^{\text{eff}}=-T'$ and $T$ decreasing does give $\rho^{\text{eff}}$ increasing. $T>0$, so $\log T^2=2\log T$ is a strictly increasing function of $T$ and the sign of $(\log T^2)'$ is the sign of $T'$. The chain of implications is correct as stated, and a strictly increasing $\rho^{\text{eff}}$ on $[12,\infty)$ gives $\rho^{\text{eff}}_n\ge\rho^{\text{eff}}_{12}$ for every $n\ge12$, which is what [second-order.md:1233](../findings/second-order.md) consumes. **CONFIRMED.**

**The numerator, recomputed from scratch as printed.** $(n+16)(n-2)=n^2+14n-32$; $2(n-1)(n-2)=2n^2-6n+4$; $-3(n-1)(n+16)=-3(n^2+15n-16)=-3n^2-45n+48$. Sum: $n^2$ terms $1+2-3=0$; $n$ terms $14-6-45=-37$; constants $-32+4+48=20$. **The printed $-37n+20$ is arithmetically correct**, for $Q=\log(n-1)+2\log(n+16)-\log2-3\log(n-2)$, which is the log of the wrong $T^2$.

**The correct computation.** With $T^2=(n-1)(n+16)^2\big/\big(2n^2(n-2)\big)$,

$$Q(n)=\log(n-1)+2\log(n+16)-\log2-2\log n-\log(n-2),\qquad Q'(n)=\frac1{n-1}+\frac2{n+16}-\frac2n-\frac1{n-2},$$

and over the positive common denominator $n(n-1)(n-2)(n+16)$ the numerator is

$$\underbrace{n(n-2)(n+16)}_{n^3+14n^2-32n}+\underbrace{2n(n-1)(n-2)}_{2n^3-6n^2+4n}-\underbrace{2(n-1)(n-2)(n+16)}_{2n^3+26n^2-92n+64}-\underbrace{n(n-1)(n+16)}_{n^3+15n^2-16n}=-33n^2+80n-64 .$$

Its discriminant is $80^2-4\cdot33\cdot64=6400-8448=-2048<0$ with negative leading coefficient, so it is **negative for every real $n$**, no range hypothesis needed at all. Hence $Q'<0$, $T$ strictly decreases, and $\rho^{\text{eff}}$ strictly increases on $n\ge12$. **Claim 2's conclusion CONFIRMED; its numerator REFUTED.**

**Exhibited at a named value.** At $n=12$ the true $Q'(12)=\tfrac1{11}+\tfrac1{14}-\tfrac16-\tfrac1{10}=-\tfrac{3856}{36960}=-0.1043290$, while $-37n+20$ over the derivation's denominator $(n-1)(n+16)(n-2)$ gives $-424/3080=-0.1376623$, same sign, wrong function, and the agreement in sign is the only reason the conclusion survived.

**Argued the opposite.** One could say the numerator's *sign* is all Claim 2 needs, so the error is cosmetic. It is not: $-37n+20$ is linear and $-33n^2+80n-64$ is a negative-definite quadratic, and a successor reusing the printed numerator (to bound $\lvert T'\rvert$, to locate a crossing, or to extend below $n=12$), would carry a quantity that is wrong by a factor growing like $n$.

## 6. A shorter proof of both, once §5 is available

Claim 1 is a corollary of Claim 2 and does not need a cubic at all: monotonicity gives $\rho^{\text{eff}}_n\ge\rho^{\text{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}$, and

$$\sqrt6>\tfrac7{30}\sqrt{55}\iff 6>\tfrac{49\cdot55}{900}=\tfrac{2695}{900}\iff 5400>2695,$$

one exact integer comparison. Offered as the repair, since the cubic route re-derives at every $n$ what the endpoint plus monotonicity settles once.

## 7. The scope caveat, REFUTED AS STATED

**Located.** "both statements above are conditional on the 2/9 reading, since a different penalty coefficient changes rho_eff and would need the argument re-run."

Three things are wrong with it, and they point in both directions.

- **It is over-broad on Claim 1.** At penalty coefficient $1$ the record's own [line 1227](../findings/second-order.md) keeps the order $\Omega(n^{-1})$, which requires $\rho$ bounded away from zero; and the constant is $\tfrac32\sqrt2-9(\sqrt2-\sqrt{3/2})=0.4161$ in the limit, the "$+0.416$, positive by 20%" the same block records at [line 1241](../findings/second-order.md). Positivity survives both readings. What is conditional is the *cubic*, not the statement.
- **It is too narrow on what the derivation actually depends on.** The caveat names the $\tfrac29$ debt (under which both printed computations would be unchanged in form) and says nothing about the convention for $\theta_0$, which is the premise that in fact fails. A caveat that insures against the wrong hazard is worse than none, because it reads as a completed scoping exercise.
- **It omits the parity and the lower endpoint.** The chain runs over *even* $n\ge12$ ($m\ge6$), and the record narrows it there because $\rho^{\text{eff}}$ is undefined at $n=10$; the derivation says "$n\ge12$" without either. The polynomial arguments happen to cover the real half-line, so nothing breaks, but the scope is inherited, not stated.

**Sufficient?** No. Even repaired, the caveat should say that Claim 2 is the half that genuinely turns on $\tfrac29$ (the record states the direction reverses at coefficient $1$) while Claim 1 holds under both readings.

## 8. Is it needed?, the record proves neither, so F9 is genuinely owed

Read for this question: [Lemma L149](../findings/second-order.md) and its surrounding block, [ROUND_L149-F](../verification/ROUND_L149F.md), [VERIFY_v47](../verification/VERIFY_v47.md), [plan-verification.md](../plan-verification.md), [results.md](../results.md), [conventions.md](../findings/conventions.md), [fence-posts.md](../findings/fence-posts.md).

- The nearest thing to a proof is L149's box, "**increasing from $0.71904$ at $n=12$ to $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.74238$**", an assertion with four evaluations behind it and no argument, which is exactly what F9 charges.
- [fence-posts.md:207](../findings/fence-posts.md) does prove a neighbouring monotonicity: $\theta_0^2=2(n-1)(n-2)/n^2$ is strictly increasing, $\tfrac{d}{dn}=2(3n-4)/n^3>0$. **It does not deliver Claim 2**, $T=\theta_0\cdot\tfrac{n+16}{2(n-2)}$ is an increasing factor times a decreasing one, so the direction is decided only by the comparison §5 performs, and $\theta_0\uparrow$ pushes the wrong way.
- L149's uniformity proof *consumes* Claim 2 rather than supplying it: the $n$-free coefficient $\big(\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$ is asserted to increase in $n$, which needs $1/\rho$ decreasing, i.e. $\rho^{\text{eff}}$ increasing. So the floor $g_\rho\ge0.71979/n$ rests on the statement under review.
- [ROUND_L149-F](../verification/ROUND_L149F.md) records both adjudicators reaching `HYPOTHESIS-DEBT` on F9 and says in terms that "nothing on file proves either".

**So the derivation addresses a real gap, and after the corrections above it closes it.** Verdict on the file as a whole: the two conclusions are true and are now proved; the two printed routes are not the routes, and the file must not go to the record in its present form.

## 9. Appendix, one observation outside the brief, recorded not acted on

[ROUND_L149-F](../verification/ROUND_L149F.md) leaves open that v47 reads the coefficient-$1$ numerals as $0.640026$ and $0.416102$ against the recorded $0.689771$ and $0.582938$. **These are two different quantities, and the first pair maps onto the second at $n=12$.** Screening the record's own uniformity formula at $\rho=0.6400260$ returns $0.6897706$, matching the recorded $0.689771$ to six digits, so $0.689771$ is the $g_\rho$ constant at coefficient $1$, and v47's $0.640026$ is the $\rho$ that produces it. The floor does not close the same way: the limit $\rho=0.4161021$ gives $0.5898026$ against the recorded $0.582938$, a $1.2\%$ gap. **Recorded for whoever takes that debt; no action taken here, it being outside this brief.**
