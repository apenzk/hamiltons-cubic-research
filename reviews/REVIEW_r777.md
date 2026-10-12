# Gate 2 review r777, L182, the uniform lower bound on $\lambda F$

**Cold brief.** Worked from [BRIEF-g2-l182.md](BRIEF-g2-l182.md) alone; [findings/](../findings/) was left unopened. **No search, sweep, optimisation, census or falsifier hunt was run.** The only compute was a permitted screen of digits I was about to record, exact 40-digit decimal arithmetic on the brief's own formulae, seconds of it, reported below as a screen and never as evidence for a positive claim. **Every value in this report is exact or a stated rounding of an exact value, and every one is reproducible by hand from the closed forms given.** Log: [agent_logs/g2-l182-r777.log](../agent_logs/g2-l182-r777.log).

**Mid-review correction from the coordinator, folded in before delivery.** Two statements of the brief were withdrawn: the lemma supplying $F$ **has** passed Gate 2 with four reviewers, with $F(12)=0.38673$ and $F(n)>F(12)$ at even $n\ge14$ both among what survived and only the limit $F(\infty)=0.90304$ unaudited; and the record **already holds** a uniform radius constant, $0.1223/n$ with $K\ge0.13537$. Sections 8 and 9 are written against the corrected picture, and the effect on my verdict is stated in each and in the closing section.

## Claim table

| # | Object under audit | Verdict |
|---|---|---|
| 2 | $2(n-1)(n-2)/n^2 = 2(1-3u+2u^2)$, $u=n^{-1}$ | HOLDS, an identity in $n\neq0$ |
| 3 | $\theta_0^2$ increasing in $n$, via the derivative in $u$ | CONCLUSION CORRECT, REVERSAL STEP UNSTATED |
| 3b | $\lambda$ strictly decreasing in $n$ | HOLDS |
| 4 | "decreasing towards $\lambda_\infty$, hence above it" | VALID, the limit of a monotone decreasing sequence IS its infimum |
| 4b | Strictness of $\lambda(n)>\lambda_\infty$ | HOLDS, on strict monotonicity that the block does establish |
| 5a | $\lambda_\infty=1.53157$ | MIS-STATED DIGIT, correct value $1.5315812$, rounds to $1.53158$ |
| 5b | $\lambda_\infty F(12)=0.5923041$ | ARITHMETICALLY CONSISTENT with the block's own mis-rounded $\lambda_\infty$ |
| 5c | $0.5923041$ as a certified lower bound | UNCERTIFIED at its last two digits |
| 5d | Direction of the strict inequality | CORRECT |
| 5e | The earlier draft's $0.59233$ | REFUTED, the product is $0.5923084$ and never exceeds $0.59233$ |
| 6 | Well-posedness at $n=12$ | WELL POSED, with margin $n^2-12n+8=8$ |
| 6b | $n=10$, $n=11$ | UNDEFINED, $\lambda$ is not real there |
| 6c | Odd $n\ge13$ | INSIDE $\lambda$'s DOMAIN, outside the $F$ given |
| 7a | $\lambda(12)F(12)=2.4267$ | MIS-STATED DIGIT, correct value $2.4266$ |
| 7b | $\lambda_\infty F(\infty)=1.3831$ | HOLDS |
| 7c | "best case" and "worst case" | ASSERTIONS, HYPOTHESIS-DEBT |
| 8 | Sufficiency of the crude bound | SUFFICIENT FOR THE STATED CONCLUSION, SLACK BY A FACTOR $2.34$ |
| 8b | Redundancy against the already-held uniform constant | THE FACT IS REDUNDANT, THE ARGUMENT IS A REAL CONTRIBUTION |
| 8c | The block's presentation of that fact as its own conclusion | NOVELTY OVERSTATED |
| 9 | The three quoted $F$ facts, post-correction | TWO AUDITED (one load-bearing, one numeral-setting), ONE UNAUDITED AND UNUSED |
| 9b | The claim's exposure to unaudited material | NIL |
| 10 | "no dimension left over" | OVERREACH AS PHRASED, TRUE WHEN QUALIFIED |
|, | **The claim itself, $\lambda(n)F(n)>\lambda_\infty F(12)$ at even $n\ge12$** | **UPHELD UNCONDITIONALLY**, the correction discharges the one condition I had attached |

**Actionable summary in one line.** The inequality survives every attack in the checklist and, after the correction, survives it unconditionally; the block should be repaired at three numerals ($\lambda_\infty\to1.53158$, $\lambda(12)F(12)\to2.4266$, the constant restated as $0.5923$), the best-case/worst-case superlatives demoted to endpoint evaluations, the reversal $du/dn<0$ written into the monotonicity step, and the headline restated as *why* the constant stays away from zero rather than *that* it does.

## 0. Conventions, fixed once

- $u=n^{-1}$ throughout, and $n$ ranges over the reals wherever a derivative is taken, over even integers $\ge12$ wherever $F$ appears.
- $\theta_0(n)=+\sqrt{2(n-1)(n-2)/n^2}$, the positive root, defined and real for $n\ge2$.
- $\lambda(n)=2\big/\sqrt{9(\theta_0(n)-\sqrt{3/2})}$, defined and positive exactly where $\theta_0(n)>\sqrt{3/2}$.
- $\lambda_\infty=2\big/\sqrt{9(\sqrt2-\sqrt{3/2})}$, a closed-form constant, and separately the limit of $\lambda$, section 4 shows the two agree.
- "Increasing" and "decreasing" mean strictly so; where only the weak sense holds I say weakly.
- A numeral written with $k$ decimals means the exact value rounds to it at $k$ decimals. Where a numeral is used as a bound I say which side it is safe on.

## 1. Hypothesis inventory

**Used and stated.**

- H1, $\theta_0(n)^2=2(n-1)(n-2)/n^2$, the definition; audited in section 2.
- H2, $F(12)=0.38673$; quoted, carries Gate 2 debt of its own.
- H3, $F(n)>F(12)$ at every even $n\ge14$; quoted; **the load-bearing import**, section 9.
- H4, the range is even $n\ge12$.

**Used and unstated, the block relies on each without writing it.**

- U1, $du/dn=-n^{-2}<0$, the substitution's reversal. The block passes from "the derivative in $u$ is negative" straight to "$\theta_0^2$ increases in $n$", and the step that licenses the passage is absent. Section 3.
- U2, $x\mapsto2\big/\sqrt{9(x-\sqrt{3/2})}$ is decreasing on $x>\sqrt{3/2}$. This is what turns "$\theta_0-\sqrt{3/2}$ increases" into "$\lambda$ decreases", and it is used silently.
- U3, $\theta_0(n)>\sqrt{3/2}$ at every $n$ in range, so that $\lambda$ is defined along the whole chain. The brief supplies the crossover; the proof block does not invoke it. Section 6.
- U4, positivity of both factors at the multiplication. From $F(n)\ge F(12)=0.38673>0$ and $\lambda(n)>\lambda_\infty>0$; the step is sound and the hypothesis is unwritten.
- U5, $\theta_0(n)\to\sqrt2$, hence $\lambda(n)\to\lambda_\infty$ by continuity at $\sqrt2>\sqrt{3/2}$. The block asserts "decreasing towards $\lambda_\infty$" and never says why $\lambda_\infty$ is the limit.
- U6, for a monotone decreasing sequence the limit is the infimum. Valid, and invoked implicitly. Section 4.
- U7, the radius bound of order $n^{-1}$ whose constant this is. The conclusion "the $\Omega(n^{-1})$ radius holds" imports a downstream statement that appears in no hypothesis list. Section 10.

**Stated and unused.**

- $F(n)\to0.90304$, enters only the asserted worst case $1.3831$, never the claim.
- $\theta_0(12)=1.236033$ and $\sqrt2=1.414214$ as numerals, used for the two endpoint evaluations only; the claim itself needs neither.
- $\theta_0(n)\to\sqrt2$ as a *numeral* $1.414214$, the claim needs the exact $\sqrt2$, which is what $\lambda_\infty$'s closed form carries.

## 2. The algebra

$$\frac{2(n-1)(n-2)}{n^2}=\frac{2(n^2-3n+2)}{n^2}=2\left(1-\frac3n+\frac2{n^2}\right)=2(1-3u+2u^2).$$

An identity at every $n\neq0$, with no branch, no sign convention and no domain restriction beyond $n\neq0$. **HOLDS.** Screened at $n=5,12,37$: the difference is exactly $0$ at 40 digits.

## 3. The monotonicity, with the sign checked twice

Write $g(u)=2(1-3u+2u^2)$, so $\theta_0(n)^2=g(u(n))$ with $u(n)=n^{-1}$.

**First check, the composition.** $g'(u)=2(4u-3)=2(-3+4u)$, which is $<0$ for $u<3/4$. So $g$ is **decreasing in $u$** on $u<3/4$. And $u(n)=n^{-1}$ is **decreasing in $n$** on $n>0$. A decreasing function of a decreasing function is increasing, so $\theta_0^2$ is **increasing in $n$** for $n>4/3$. The block's conclusion is right.

**Second check, the chain rule, done directly.**

$$\frac{d}{dn}\,\theta_0(n)^2=g'(u)\cdot\frac{du}{dn}=2\left(-3+\frac4n\right)\cdot\left(-\frac1{n^2}\right)=\frac{2\left(3-\frac4n\right)}{n^2}=\frac{2(3n-4)}{n^3},$$

positive for $n>4/3$. **The two independent routes agree.** Screen, as a third: $\theta_0(12)^2=220/144=1.527\overline{7}$, $\theta_0(14)^2=312/196=1.591837$, $\theta_0(20)^2=1.71$, increasing, as derived.

**Where the block is thin.** The written step is "its derivative is $2(-3+4u)$, negative for $u<\tfrac34$, so $\theta_0^2$ increases in $n$". The word "so" hides exactly one fact, U1, that $du/dn<0$, the very reversal the brief warns about. The block gets the direction right and omits the reason. **This is an exposition gap, and the conclusion stands.**

**A warning about the checklist's own paraphrase.** Item 3 of the brief describes the argument as "increasing in $u$ on $u<\tfrac34$". The proof text says *negative*, hence *decreasing* in $u$. Under the paraphrase's reading the composition would come out **decreasing in $n$**, $\lambda$ would come out increasing, and the claim would fail. The proof text is the correct one; anyone repairing this block should keep the word "negative" and add U1 rather than rewrite the sentence from the paraphrase.

**One over-general range.** The block gives $n>4/3$. That is the honest range for the *square*. For $\theta_0$ itself one needs $\theta_0^2\ge0$, i.e. $(n-1)(n-2)\ge0$, i.e. $n\ge2$; on $(4/3,2)$ the square is negative and $\theta_0$ is not a real number. Immaterial at $n\ge12$, and worth one clause.

**From $\theta_0$ to $\lambda$.** $\theta_0$ increasing and non-negative gives $\theta_0-\sqrt{3/2}$ increasing; on the region where that is positive, $9(\theta_0-\sqrt{3/2})$ increases, its square root increases, and $\lambda=2/\sqrt{\cdot}$ decreases. Strictly, since $d\theta_0^2/dn>0$ strictly at $n\ge12$. **HOLDS**, with U2 and U3 unwritten.

## 4. "Decreasing towards $\lambda_\infty$, hence above it"

**The inference is valid, and it needs no separate fact.** The brief's needle ("a decreasing sequence need not stay above its limit if it is not the infimum"), describes a situation that cannot arise: **for a monotone decreasing sequence the limit and the infimum coincide, always.**

*Proof.* Let $a_n$ be non-increasing with $a_n\to L$, and suppose $a_N<L$ for some $N$. For every $n\ge N$, $a_n\le a_N$, so $L=\lim_n a_n\le a_N<L$, a contradiction. Hence $a_n\ge L$ for every $n$, and $L=\inf_n a_n$. $\square$

So the step "decreasing towards $\lambda_\infty$, hence $\lambda(n)>\lambda_\infty$" carries its own justification once monotonicity and convergence are in hand. Two riders decide whether the *strict* form is earned:

- **Strictness.** The argument above gives $a_n\ge L$. The strict $a_n>L$ needs strict decrease, which section 3 supplies: $d\theta_0^2/dn=2(3n-4)/n^3>0$ strictly at every $n\ge12$, so $\lambda$ strictly decreases and $\lambda(n)>\lambda_\infty$ strictly at every finite $n$ in range. **Earned.**
- **That $\lambda_\infty$ is the limit.** U5. $\theta_0(n)^2=2(1-3u+2u^2)\to2$ as $u\to0$, so $\theta_0\to\sqrt2$; the map $x\mapsto2/\sqrt{9(x-\sqrt{3/2})}$ is continuous at $x=\sqrt2$ because $\sqrt2>\sqrt{3/2}$; hence $\lambda(n)\to\lambda_\infty$. **Earned, and unwritten in the block.**

**A corroborating route the block could have taken.** $\theta_0(n)^2<2\iff2(1-3u+2u^2)<2\iff2u^2<3u\iff0<u<3/2$, true at every $n>2/3$. So $\theta_0(n)<\sqrt2$ at every finite $n$ outright, and $\lambda(n)>\lambda_\infty$ follows with no monotonicity at all. I record this as corroboration of an argument that is present and correct, and the block's route stands on its own.

**VALID.**

## 5. The arithmetic of the constant

**$\lambda_\infty$.** $\sqrt2=1.4142135624$, $\sqrt{3/2}=1.2247448714$, difference $0.1894686910$; times $9$ is $1.7052182188$; its square root is $1.3058400417$; and

$$\lambda_\infty=\frac2{1.3058400417}=1.5315811536.$$

**The block writes $1.53157$. The correct rounding at five decimals is $1.53158$**, the block's value is low by $1.15\times10^{-5}$, a wrong sixth significant figure. **MIS-STATED DIGIT.** The error happens to fall on the safe side for a lower bound, by luck rather than by design, and a repair should say so explicitly if it keeps a conservative rounding.

**The product.** $1.53157\times0.38673$ is exactly $0.5923040661$ (integer check, $153157\times38673=5{,}923{,}040{,}661$) which rounds to $0.5923041$. **So the displayed constant is arithmetically consistent with the block's own $\lambda_\infty$.** With the correct $\lambda_\infty$ the product is $1.5315811536\times0.38673=0.5923083795$, so the displayed numeral sits $4.3\times10^{-6}$ *below* the true product.

**The direction of the strict inequality.** From $\lambda(n)>\lambda_\infty>0$ and $F(n)\ge F(12)>0$,

$$\lambda(n)F(n)>\lambda_\infty F(n)\ge\lambda_\infty F(12),$$

strict at the first step at every finite $n$, weak at the second with equality exactly at $n=12$. The composite is strict throughout. **CORRECT**, and it consumes U4, the positivity of both factors, which the block leaves unwritten.

**The earlier draft's $0.59233$, confirmed refuted.** $0.5923041<0.59233$ and $0.5923084<0.59233$, so under either value of $\lambda_\infty$ the product falls short of $0.59233$ and a claim of $\lambda F>0.59233$ would have been unsupported. The brief's account of the earlier error is exactly right.

**The defect the checklist does not ask about, the numeral carries more digits than its inputs support.** $0.5923041$ shows seven decimals, built from $\lambda_\infty$ to six significant figures and $F(12)$ to five decimals. Suppose $F(12)=0.38673$ is itself a five-decimal rounding of a true value in $[0.386725,0.386735)$. Then

$$\lambda_\infty F(12)\in[0.5923007,\;0.5923160),$$

whose lower end lies **below** the displayed $0.5923041$. **So $0.5923041$ is uncertified as a lower bound at its last two digits**, and only the leading five survive the input precision. The certified statement is $\lambda(n)F(n)>0.5923$; $\lambda(n)F(n)>0.59230$ is available only if $F(12)=0.38673$ is exact rather than rounded, which the given does not say. **UNCERTIFIED.**

## 6. $\lambda$'s definition at the range's edge

$\lambda$ requires $\theta_0(n)>\sqrt{3/2}$, and

$$\frac{2(n-1)(n-2)}{n^2}>\frac32\iff4(n-1)(n-2)>3n^2\iff4n^2-12n+8>3n^2\iff n^2-12n+8>0,$$

whose positive root is $n=6+2\sqrt7=11.2915026$. So $\lambda$ is defined exactly at $n>6+2\sqrt7$ within the positive range, confirming the crossover the brief quotes.

- **$n=12$.** $144-144+8=8>0$, so $\theta_0(12)-\sqrt{3/2}=1.2360330811-1.2247448714=0.0112882098>0$ and $\lambda(12)=6.2747467870$ is real, finite and positive. **The claim is well posed at $n=12$**, and $n=12$ is the first integer above the crossover, so the conjecture's range begins exactly where $\lambda$ becomes available.
- **$n=10$.** $\theta_0(10)^2=2\cdot9\cdot8/100=1.44$, so $\theta_0(10)=1.2<1.2247448714$ and $9(\theta_0-\sqrt{3/2})=-0.2227$. **$\lambda(10)$ is not a real number**, so the statement at $n=10$ has no truth value under this definition rather than being false. Any extension below the crossover requires a different definition of $\lambda$, which is a separate object and a separate claim.
- **Odd $n$.** $n=11$: $\theta_0=1.2196734<\sqrt{3/2}$, still undefined. $n=13$: $\theta_0=1.2498521>\sqrt{3/2}$, defined, and $\lambda(13)$ is finite and positive. From $n=13$ upward every odd $n$ lies in $\lambda$'s domain and the whole $\lambda$ half of the argument runs verbatim. **The even-only restriction comes from $F$ and from the conjecture's range, and never from $\lambda$**, the block should say which factor forces the parity, and it does not.
- **A structural note.** $\lambda(n)\to\infty$ as $n$ descends to the crossover, so $\lambda$ is largest at the smallest admissible dimension. The bound is therefore at its loosest precisely at $n=12$, where $\lambda(12)F(12)=2.4266$ against the claimed $0.5923$.

## 7. The two endpoint values, and the two superlatives

**$\lambda(12)F(12)$.** $9\times0.0112882098=0.1015938881$; its square root is $0.3187380$; $\lambda(12)=2/0.3187380=6.2747467870$; and

$$\lambda(12)F(12)=6.2747467870\times0.38673=2.4266328.$$

**The block writes $2.4267. The correct rounding at four decimals is $2.4266$.** The discrepancy survives the most charitable reading: feeding the block's own rounded $\theta_0(12)=1.236033$ gives $\lambda(12)=6.2747694$ and a product of $2.4266416$, which still rounds to $2.4266$. **MIS-STATED DIGIT**, off by $7\times10^{-5}$.

**Why the digit slipped, and why it will slip again.** $\theta_0(12)-\sqrt{3/2}$ is a difference of two numbers near $1.23$ whose two leading digits cancel. Seven significant figures of $\theta_0$ therefore leave about five in the difference and about five in $\lambda(12)$. Near the crossover the record's habit of quoting $\theta_0$ to seven figures does not support five figures in $\lambda$, and every numeral computed at small $n$ inherits the loss. A repair should carry the exact surd, or state $\theta_0(12)$ to ten figures.

**$\lambda_\infty F(\infty)$.** $1.5315811536\times0.90304=1.3830790$, which rounds to $1.3831$. **HOLDS.**

**"Best case" and "worst case" are assertions.** The block states plainly that no monotonicity of the product is used or claimed, and the two superlatives are exactly a monotonicity claim about the product, that the maximum sits at $n=12$ and the infimum at the limit. Nothing on file orders any interior value against either endpoint.

**The gap is visible at the very first interior point, in closed form.** $\theta_0(14)=1.2616801237$, $\theta_0(14)-\sqrt{3/2}=0.0369352524$, $9\times$ that is $0.3324172712$, its root $0.5765564$, so $\lambda(14)=3.4688714$. The strongest statement the block's own data supports at $n=14$ is

$$\lambda(14)F(14)>\lambda(14)F(12)=3.4688714\times0.38673=1.3415167,$$

which **falls below the asserted worst case $1.3831$.** Reaching $1.3831$ at $n=14$ requires $F(14)>1.3831/3.4688714=0.3987176$, a value that appears nowhere in the given. **This exhibits that the worst-case assertion is unentailed; it refutes nothing**, $F(14)$ may well exceed $0.3987176$, and under the analysis-only footing I did no search for an $n$ where the product actually dips. **HYPOTHESIS-DEBT: this claim has no argument on file.** Both superlatives should be demoted to "the value at $n=12$ is $2.4266$" and "the limiting value is $1.3831$".

## 8. Vacuity and strength

**The bound is non-vacuous and it suffices for the stated conclusion.** $0.5923$ is positive and independent of $n$, and $\Omega(n^{-1})$ asks precisely for a positive $n$-independent constant. The conclusion drawn (that the constant is bounded away from zero uniformly), is exactly what the crude product delivers.

**It is slack by a known amount.** Against a conjectured true infimum of $1.3831$ the bound is low by a factor $2.34$; against the value at $n=12$ it is low by a factor $4.10$. The slack is intrinsic to the method: the bound pairs the *limiting* value of the decreasing factor with the *initial* value of the increasing factor, and those are taken at opposite ends of the range, so no single $n$ realises both. That is the honest price of avoiding a monotonicity claim about the product, and the block is right to pay it and to say that it is paying it.

**Whether the conclusion needs more.** For positivity, no. A consumer needing a numeric constant (a threshold to beat, a comparison against another bound), would need either the product's monotonicity or a per-$n$ argument, and the block names no such consumer. I record the slack as a property of the result rather than a defect in it.

### 8b. Redundancy, given that the record already holds a uniform constant

The coordinator's correction supplies the fact that the audit already recorded a uniform radius constant, $0.1223/n$ with $K\ge0.13537$. **The fact this block announces was therefore already held, and what the block adds is the argument for it.** My assessment splits cleanly in two.

**Redundant as a fact.** "The constant is bounded away from zero uniformly in $n$" is on the record independently, so a reader who wants only that statement gains nothing here. I decline to rank the two numerals against each other: $0.5923$ is a bound on $\lambda F$ while $0.1223/n$ and $K\ge0.13537$ are stated in the radius normalisation, and the brief supplies no conversion between them. **Comparing them would require a fact I do not have, so I record only that both are positive and $n$-independent.**

**A real contribution as an argument, on three counts I can name.**

1. **It locates the monotonicity that does the work.** The whole $\lambda$ side reduces to one derivative, $d\theta_0^2/dn=2(3n-4)/n^3>0$, and everything else is composition of monotone maps. A recorded fact tells a reader the constant survives; this tells them the single inequality that makes it survive, which is what a later sharpening would have to improve.
2. **It isolates the exposure.** The result touches $F$ only through $F(n)\ge F(12)$. So every interior value of $F$, its limit, and any future revision of either leave the constant standing, a robustness statement the bare fact cannot make. Section 9 turns this into a precise account of what would have to fail.
3. **It says why the crude product is the right instrument.** The two factors move in opposite directions, so the product carries no monotonicity to exploit and needs none: pairing $\inf\lambda$ with $\inf F$ converts two one-sided facts into a bound with no extra hypothesis at all. **Stating explicitly that no monotonicity of the product is used is the block's most useful sentence**, because it tells a later reader that the factor-$2.34$ slack is the price of a hypothesis-free step rather than a gap in the derivation.

**Verdict: THE FACT IS REDUNDANT, THE ARGUMENT IS A REAL CONTRIBUTION.** Its value is explanatory and structural, and it should be recorded as such.

### 8c. One consequence for how the block is written

Given that the fact pre-exists, the sentence **"So the constant is bounded away from zero uniformly in $n$, and the $\Omega(n^{-1})$ radius holds at every even $n\ge12$ with no dimension left over"** presents as a first establishment of something the record already carries. The honest headline is the argument: *which* monotonicity keeps the constant away from zero, and why the crude product suffices. **NOVELTY OVERSTATED**, a presentational defect, with the mathematics untouched. It compounds the phrasing problem of section 10, and both are repaired by the same edit.

## 9. The inherited debt, and precisely what fails

**Written against the corrected picture.** The brief described the supplying lemma as "itself Gate 2 owed"; the coordinator has withdrawn that. The lemma has passed Gate 2 with four reviewers, its composition and every constant were confirmed, and $F(n)>F(12)$ at every even $n\ge14$ is explicitly among what survived. **The only unaudited value is the limit $F(\infty)=0.90304$.** I answer the item twice, first as the dependency structure stands regardless of audit status, then as the correction changes the standing of each entry.

**The dependency structure, unchanged by the correction.**

- **$F(n)>F(12)$ at every even $n\ge14$, LOAD-BEARING.** Should this fail at a single even $n_0$, the step "$F(n)\ge F(12)$ throughout" fails at $n_0$, and since the block holds no other lower bound on $F$, the product bound has nothing to stand on at $n_0$. Uniformity is the whole content of the claim, so one counterexample removes the result entirely.
- **$F(12)=0.38673$, sets the numeral, and supplies positivity.** Any positive value $c$ in its place gives the uniform constant $\lambda_\infty c>0$ and leaves the qualitative conclusion unchanged; only the digits move. The one structural thing it must supply is $F(12)>0$, consumed by U4: at $F(12)\le0$ the chain $\lambda F>\lambda_\infty F\ge\lambda_\infty F(12)$ breaks at its first inequality.
- **$F(n)\to0.90304$, UNUSED by the claim.** It enters only the asserted limiting value $1.3831$ of section 7. Were it wrong, the claim stands verbatim and one endpoint numeral moves.
- **The $\theta_0$ side carries no debt at all.** $\theta_0$'s formula, its monotonicity, its limit and $\lambda_\infty$ are each derived in the block from H1, so the result's whole exposure to imported material is the three $F$ entries above.

**What the correction changes, entry by entry.**

- The **load-bearing** entry is **audited and survived**. The condition I attached to my verdict was precisely this one, and it is discharged.
- The **numeral-setting** entry is **audited and confirmed**, so $F(12)=0.38673$ may be used as written; its positivity, all that the argument structurally needs, is beyond question.
- The **unused** entry is the **only unaudited** one. **The claim's exposure to unaudited material is therefore exactly nil**, which is a stronger position than a proof usually occupies and is worth stating in the block.

**One consequence the correction sharpens rather than softens.** The unaudited $F(\infty)=0.90304$ is exactly the input to the asserted worst case $1.3831$. That assertion was already carrying HYPOTHESIS-DEBT in section 7 for want of any ordering of the product's interior values against its endpoints; it now also rests on the single quoted value that no reviewer has checked. **Two independent reasons to demote it, and the claim itself remains untouched by both**, since it quotes the limit without using it.

**Does the corrected picture change my verdict? Yes, upward, and only on the conditional.** My finding was UPHELD *conditional on the quoted $F$ monotonicity*. That condition is now met by an audit rather than assumed, so the finding becomes **UPHELD unconditionally**: the inequality holds on H1 (verified here), the derived $\lambda$ facts (verified here), and two Gate 2 confirmed imports. **Every other verdict in the table stands exactly as written**, the two mis-stated digits, the uncertified seventh decimal, the unsupported superlatives and the unqualified "no dimension left over" are defects of the block's own text and owe nothing to $F$'s audit status.

## 10. Overreach

**"No dimension left over" is true when qualified and false as phrased.**

- **Qualified to the conjecture's range it holds**, and for a reason worth writing down: the crossover is $11.2915026$ and $12$ is the first integer above it, so every even $n\ge12$ lies inside $\lambda$'s domain with none excluded at the bottom.
- **Read absolutely it fails.** $n=10$ and $n=11$ lie outside $\lambda$'s domain, and odd $n\ge13$ lie inside $\lambda$'s domain while sitting outside the $F$ given, so they are left over. Three classes of dimension are untouched by the claim, and the phrase invites a reader to think otherwise. The fix is one word: "no dimension of the conjecture's range".
- **A second, quieter reach.** "the $\Omega(n^{-1})$ radius holds at every even $n\ge12$" is a statement about the radius bound, and the block proves only that the constant in that bound is positive and uniform. The passage from a positive constant to the radius statement imports U7, the radius bound of order $n^{-1}$ itself, which appears in no hypothesis list here. The block should either cite it or state the conclusion as a fact about the constant, and the citation is available, since the record already carries $0.1223/n$ with $K\ge0.13537$ (section 8b).

## What would break it, and what I did to look

**Four falsifiers, three of them settled here in closed form.**

1. **An even $n_0\ge14$ with $F(n_0)\le F(12)$.** This kills H3 and with it the result. **Undecidable from this brief** ($F$ arrives quoted, with no formula to test) and hunting for one is a forbidden search. It is the single object that matters, and it belongs to $F$'s own Gate 2, **which, per the coordinator's correction, has run with four reviewers and returned this very statement among what survived.** The falsifier is therefore closed elsewhere rather than open here.
2. **An $n_0\ge12$ with $\theta_0(n_0)\ge\sqrt2$**, which would break $\lambda(n_0)>\lambda_\infty$. **No such $n_0$ exists**, in closed form: $\theta_0(n)^2<2\iff2u^2<3u\iff n>2/3$. Settled for every $n$ in range at once.
3. **An $n_0\ge12$ outside $\lambda$'s domain**, i.e. with $n_0^2-12n_0+8\le0$. **No such $n_0$ exists**: the quadratic is increasing for $n\ge6$ and equals $8$ at $n=12$. Settled for every $n$ in range at once.
4. **An $n_0$ with $\lambda(n_0)F(n_0)<1.3831$**, which would break the asserted worst case while leaving the claim untouched. **Permitted by everything on file**, at $n_0=14$ the block's own data admits values down to $1.3415167$, and I did not search for one, which is why section 7 records HYPOTHESIS-DEBT rather than a refutation.

**Method.** Falsifiers 2 and 3 were settled by an inequality in $n$ valid on the whole range, so no enumeration was needed and none was done. Falsifier 1 was left where it belongs. Falsifier 4 was bounded, in closed form, using only $\theta_0(14)$ and the quoted $F(12)$, and left open. The permitted screen re-derived every numeral above at 40 digits and changed two of them.

## Overall verdict

**CORE UPHELD UNCONDITIONALLY; NUMERALS AND SUPERLATIVES DEFECTIVE; NOVELTY OVERSTATED.**

The inequality $\lambda(n)F(n)>\lambda_\infty F(12)$ at every even $n\ge12$ **stands**. The algebra is an identity, the monotonicity has the sign right by two independent routes, the monotone-limit inference is valid with no auxiliary fact required, the strictness is earned, and the range is well posed at its lower edge with margin $8$. I first wrote this verdict conditional on the quoted $F$ monotonicity; the coordinator's correction discharges that condition with a four-reviewer Gate 2 pass, so **the claim's exposure to unaudited material is nil** and the verdict is unconditional.

Four repairs are owed, none of them touching the argument's shape.

1. **$\lambda_\infty=1.53158$**, replacing $1.53157$.
2. **$\lambda(12)F(12)=2.4266$**, replacing $2.4267$, with the near-cancellation at $n=12$ noted so the digit does not slip back.
3. **The constant restated as $0.5923$**, the precision its inputs support; $0.5923041$ overstates by two digits and is uncertified as a bound if $F(12)$ is itself a rounding.
4. **"Best case" and "worst case" demoted to endpoint evaluations**, and "no dimension left over" qualified to the conjecture's range.

A fifth repair follows from the correction rather than from the text. **The headline should claim the argument, not the fact.** That the constant stays away from zero is already on the record as $0.1223/n$ with $K\ge0.13537$; what this block newly supplies is *which* monotonicity keeps it there, that the whole dependence on $F$ runs through $F\ge F(12)$, and that the crude product of two oppositely-moving bounds needs no monotonicity of the product. **On that reading the lemma earns its place**, and its numerical slack of a factor $2.34$ is the stated price of a hypothesis-free step.

Carrying the debt: the two superlatives, which have no argument on file (HYPOTHESIS-DEBT) and which additionally rest on $F(\infty)=0.90304$, the one quoted value no reviewer has checked; and the imported $n^{-1}$ radius bound that the conclusion consumes without listing, now citable from the record.
