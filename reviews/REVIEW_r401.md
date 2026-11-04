# Review r401, Gate 2 on the four-set reduction, the row-mass refutation, and the entry-spread price

*Adversarial review of the last three sections of [ATTEMPTS.md](../ATTEMPTS.md), 2026-09-02. Everything in §0–§4 was re-derived from the setup before the sections were opened: the two-factor family from zero row sums and criticality, the row-mass accounting, the four-set ratio in closed form, and the $\theta-p_a$ evaluation. Analysis only, inherited: the arithmetic below is exact rational evaluation of objects this review constructed, reported as a screen and never as evidence for a positive claim; every verdict also has a closed-form proof that needs no run.*

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1a | the four-set clause follows from $3m_4-\tfrac12\sigma^2<\theta^2$ | **CONFIRMED** |
| 1b | $\sigma^2\le6m_4$, equality exactly when all six entries are equal | **CONFIRMED** |
| 1c | "**the worst case is $\sigma=0$**" | **REFUTED.** $\sigma=0$ four-sets exist in band and are the *easiest* on the record's own family; the maximum sits at $\sigma\ne0$ |
| 2 | the margin does not decay in $n$ | **CONFIRMED, and upgraded from screen to closed form**: the ratio is $\tfrac9{2(p-1)^2}$ at every $(3,1)$ set, family supremum **exactly $\tfrac9{32}$** at $p=5$ and *every* $q\ge7$ |
| 3a | $m_4\le\tfrac12\sum_{a\in S}s_a$ | **CONFIRMED**, direction and constant both right, equality iff $E=0$ |
| 3b | the witness forces $\sum_{a\in S}s_a\ge1.002$, so four rows carry more than half the mass | **CONFIRMED but the weakest available figure.** The true value is $\sum_{a\in S}s_a=\tfrac{168}{115}=1.460870$, four of $48$ rows carry $73\%$ of the total mass, rising to $80\%$ in the $q\to\infty$ limit |
| 3c | the row-mass reduction is refuted | **CONFIRMED as a refutation of the *unconditional* hypothesis**, with three corrections to what it is attributed to |
| 3d | "the $-\tfrac12\sigma^2$ term is the criterion's load-bearing half", **at this witness** | **CORRECTED.** At $S^5\times S^{43}$ the $m_4$-only criterion $3m_4<\theta^2$ **holds** ($0.501203<0.532255$); it first fails at $S^5\times S^{66}$ |
| 3e | "a successor may not reduce the joint inequality to any statement in $m_4$ alone" | **OVERREACH.** At $\sigma=0$ the joint inequality *is* a statement in $m_4$ alone, and it holds throughout the family |
| 4a | $\lVert\tilde o\vert_I\rVert_\infty\le\sqrt{\max_as_a}\,\lVert\tilde o\rVert/\min_{a\in I}\lvert\theta-p_a\rvert$ | **CONFIRMED as derived** |
| 4b | "every quantity is on the record: $\lVert\tilde o\rVert$ from [Lemma L68](../findings/diagonal-half.md)" | **CORRECTED.** L68 gives $\lVert\tilde o\vert_I\rVert$, not $\lVert\tilde o\rVert$; the numerator needs $\lVert\tilde o\rVert^2=\lVert\tilde o\vert_I\rVert^2+2M_{jk}^2$ |
| 4c | $\theta-p_a\in\{8.6g,13g\}$ at $S^6\times S^6$ | **CONFIRMED exactly** ($43u$ and $65u$, $u=\theta/55$, $g=\lvert\gamma\rvert=\theta/11$), **but the evaluation is empty**: a within-factor pair of $S^p\times S^q$ is a **twin** pair, where $\tilde o\vert_I\equiv0$ and the left side is identically zero |
| 4d | "the one thing that would make it bite is $\min_{a\in I}\lvert\theta-p_a\rvert$ small" | **CONFIRMED, and now bounded**: at most **two** indices in the whole of $[n]$ can ever carry it, for any pair |
| 5 | it fails F51's two tests, so it is a price and not a route | **directionally right, under-evidenced**, the section never evaluates the conversion where it has anything to convert |

**The brief's target (a broken step in claim 3), is not there. The inequality is right, the arithmetic is right, and the refutation of the unconditional row-mass hypothesis stands.** What the audit found instead is that the closure is narrower than recorded, that its load-bearing sentence is attached to the wrong point, and that the route dies on $E$ rather than on row concentration. **The genuinely broken step is claim 1c**, and it is the one that directs the open work.

---

## 0. The family, re-derived cold

$M_{ab}=\alpha$ within $F_1$ ($\lvert F_1\rvert=p$), $\beta$ within $F_2$ ($\lvert F_2\rvert=q$), $\gamma$ across, $n=p+q$, $D=n-1$. Zero row sums give $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$; cross criticality collapses to $\gamma(1-n)=\theta$; $\mathop{\mathrm{tr}}M^2=2$ closes it:

$$\gamma=-\frac\theta D,\qquad \alpha=\frac{\theta q}{D(p-1)},\qquad \beta=\frac{\theta p}{D(q-1)},\qquad \theta^2=\frac{2(n-1)(p-1)(q-1)}{pq(n-2)} .$$

Reproduces $\theta=1.263631$ at $(5,43)$ and $m_4=6\alpha^2=0.501203$ on a $(4,0)$ set, to every printed digit. **The band forces $p\ge5$**: at $p=4$, $\theta^2=\tfrac32\big(1-\tfrac3{q^2+2q}\big)<\tfrac32$ for every $q$, so no $S^4\times S^q$ is in band. That is what pins the family supremum in §2.

## 1. The reduction, and the extreme that is stated backwards

**1a is right.** $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ and $(x+y)^2\le2(x^2+y^2)$ on each opposite pair gives $A^2+B^2+C^2\le2m_4$, hence $\Sigma\le3m_4-\tfrac12\sigma^2$. Since $\Sigma\ge0$ always (three numbers satisfy $\sum x^2\ge\tfrac13(\sum x)^2$), the one-sided sufficient condition is the right shape for [Lemma L128](../findings/second-order.md)(ii)'s $\Sigma\ne\theta^2$. ✓ *Note the two Cauchy–Schwarz steps are different: the tightness of $\Sigma\le3m_4-\tfrac12\sigma^2$ is equality of opposite pairs, while $\sigma^2=6m_4$ is equality of all six. The section uses only the second, correctly.*

**1b is right.** $\sigma^2\le6m_4$ with equality iff all six entries agree, which is exactly the $(4,0)$ type. ✓

> ### 1c is FALSE, and it is the step that misdirects the open work
>
> The section writes *"the worst case for the joint bound is the opposite extreme $\sigma=0$, where it reads $m_4<\theta^2/3$"*, and [plan.md](../plan.md) carries it forward as *"the extremes are understood"*. **At fixed $m_4$ that is a triviality; as a statement about where the criterion binds it is refuted by the record's own family.**
>
> **$\sigma=0$ four-sets exist in band.** On a $(1,3)$ set, $\sigma=3(\beta+\gamma)=3\theta\,\tfrac{p-q+1}{D(q-1)}$, which vanishes exactly at $q=p+1$. *Screen, exact rationals*: $S^6\times S^7$ ($n=13$, $\theta^2=1.558442$, in band) has $\sigma=0$ on its $(1,3)$ sets with $3m_4-\tfrac12\sigma^2=0.125\,\theta^2$; $S^7\times S^8$ gives $0.091837\,\theta^2$; $S^{12}\times S^{13}$ gives $0.03125\,\theta^2$.
>
> **And the maximum sits far from $\sigma=0$.** The family supremum $\tfrac9{32}\theta^2$ is attained at $S^5\times S^7$'s $(3,1)$ set, where $\sigma=\tfrac9{44}\theta\ne0$, **more than twice the largest $\sigma=0$ value**, and the $\sigma=0$ branch decays in $n$ while the maximiser does not.
>
> **So $\sigma=0$ is, on everything the record can construct, the *easiest* case and not the worst.** A successor who reduces the joint inequality to its $\sigma=0$ extreme, as the section's framing invites, reduces to the branch that is already clear by a factor of $8$ and drops the branch that binds.

**One wording correction that has propagated.** *"$\sigma^2=6m_4$ makes it vacuous"* ([ATTEMPTS.md](../ATTEMPTS.md) and [plan.md](../plan.md)) is defensible only under the reading *"the criterion then says nothing about $m_4$"*. Under the natural reading it inverts the difficulty: at $\sigma^2=6m_4$ the bound is $0<\theta^2$, which is the clause **automatically satisfied**, the best case available, and (at a $(4,0)$ set), *exact*, since $\Sigma=0$ there too.

**A calibration the record does not have, for the $\sigma=0$ branch.** Take $n=4$ with $M$ the $\mathbb Z_2\times\mathbb Z_2$ Cayley matrix, $M_{12}=M_{34}=a$, $M_{13}=M_{24}=b$, $M_{14}=M_{23}=c$. Zero row sums give $a+b+c=0$; $\mathop{\mathrm{tr}}M^2=2$ gives $a^2+b^2+c^2=\tfrac12$; criticality collapses to $3x^2-\tfrac12=\theta x$ for each of $a,b,c$, so at most two values occur, forcing $a=b=-\tfrac1{2\sqrt3}$, $c=\tfrac1{\sqrt3}$ (up to sign) and $\theta=\tfrac{\sqrt3}2=0.866025$. **Its single four-set has $\sigma=0$, $m_4=1$, and $3m_4-\tfrac12\sigma^2=3>\theta^2=\tfrac34$**, the clause fails by a factor of $4$. This is $n=4$, so it is no counterexample to a clause stated at $n\ge12$; what it establishes is that **the $\sigma=0$ branch is false without the band**, so any proof of $m_4<\theta^2/3$ must consume $\theta\ge\sqrt{3/2}$ and cannot be an unconditional mass estimate.

## 2. The margin, confirmed, and it is a theorem on the family, not a screen

**Closed form, derived cold.** On a $(3,1)$ set inside $F_1$ the six entries are $3\alpha$ and $3\gamma$, so

$$3m_4-\tfrac12\sigma^2=9(\alpha^2+\gamma^2)-\tfrac92(\alpha+\gamma)^2=\tfrac92(\alpha-\gamma)^2,\qquad \alpha-\gamma=\frac{\theta(q+p-1)}{D(p-1)}=\frac\theta{p-1},$$

$$\boxed{\ \Big(3m_4-\tfrac12\sigma^2\Big)\Big/\theta^2=\frac9{2(p-1)^2}\ \ \text{at every }(3,1)\text{ set, and }\frac9{2(q-1)^2}\text{ at every }(1,3)\text{ set.}}$$

Every $(4,0)$ and $(0,4)$ set gives exactly $0$. The $(2,2)$ sets give $\big[\tfrac1{p-1}+\tfrac1{q-1}\big]^2+\tfrac32D^{-2}\big[\tfrac q{p-1}-\tfrac p{q-1}\big]^2$, bounded by $0.1736+0.09375<\tfrac9{32}$ for $5\le p\le q$.

**So $p\ge5$ from §0 pins the supremum at $\tfrac9{2\cdot16}=\tfrac9{32}=0.28125$, attained at $p=5$ for *every* $q\ge7$**, hence at every $n\ge12$. *Screen, exact rationals over $4\le p\le59$, $p\le q\le399$, all five four-set types: maximum $=9/32$ at $(5,7)$'s $(3,1)$ set.* [r400](REVIEW_r400.md)'s $0.28125$ is exact, its $q\le200$ cutoff is irrelevant, and the family margin is $\tfrac{23}{32}\theta^2\ge1.078$ uniformly.

**The comparison the section draws is fair.** The pair clause's $\tfrac1{2(Q-1)}$ ([r392](REVIEW_r392.md), [r393](REVIEW_r393.md)) is also an exact evaluation on the same two-factor family, so "does not decay, unlike the pair clause" compares like with like. ✓

**The one caveat.** Non-decay is a property of the *catalogued* family. The clause's open case is an arbitrary in-band pure critical point, where no evaluation exists, so the sentence should read "the margin does not decay across the two-factor family" rather than "in $n$".

## 3. The row-mass refutation, the inequality holds, the closure is narrower than recorded

**3a, re-derived.** Each entry inside $S$ sits in two of the four rows, each cross entry in one:

$$\sum_{a\in S}s_a=\sum_{a\in S}\Big[\sum_{b\in S}M_{ab}^2+\sum_{c\notin S}M_{ac}^2\Big]=2m_4+E,\qquad E=\!\!\sum_{a\in S,\,c\notin S}\!\!M_{ac}^2\ge0 .$$

**Direction and constant confirmed, equality iff $E=0$**, iff $S$ is a union of connected components of $\mathop{\mathrm{supp}}M$. ✓ *Absent from [findings/](../findings/) (grep), but it is a double-counting identity, so the novelty is bookkeeping and not mathematics.*

**3b: the arithmetic is right and the figure cited is the weakest available.** $m_4=0.501203\Rightarrow\sum_{a\in S}s_a\ge1.002406$ is correct via $E\ge0$. **The direct value the brief asks for**: at $S^5\times S^{43}$'s $(4,0)$ set, $s_a=\big(\tfrac{2021}{8836}\big)\theta^2$ for each $a\in F_1$, so

$$\boxed{\ \sum_{a\in S}s_a=\frac{2021}{2209}\,\theta^2=\frac{168}{115}=1.4608696\ }$$

against a total of $2$. *Screen: the complementary rows check out, $5s_a+43s_b=1.826087+0.173913=2$ exactly.* **Four of $48$ rows carry $73.0\%$ of the mass**, and in the $(5,q\to\infty)$ limit $\alpha\to\theta/4$, $\gamma\to0$, $\theta^2\to\tfrac85$, giving $s_a\to\theta^2/4$ and $\sum_{a\in S}s_a\to1.6$, **$80\%$ on four rows**. The recorded $1.002$ understates the refutation by a factor of $1.46$.

**3c: the refutation stands, of the hypothesis actually stated.** "$\sum_{a\in S}s_a<1$ at every four-set" is false at an in-band pure critical point. ✓ And the chain it feeds is valid: $\sum_{a\in S}s_a<1\Rightarrow m_4<\tfrac12\le\theta^2/3$ in band. ✓

> ### 3d, the load-bearing sentence is attached to the wrong point
>
> *"The $-\tfrac12\sigma^2$ term is not a refinement of the criterion but its load-bearing half"*, evidenced by the $S^5\times S^{43}$ witness. **At $S^5\times S^{43}$ the $m_4$-only criterion holds**: $m_4=0.501203$ against $\theta^2/3=0.532255$. The witness refutes *"$m_4\ge\tfrac12$ forces $\theta<\sqrt{3/2}$"* ([post F50](../findings/INDEX-traps.md)), which is a different statement, and it leaves $3m_4<\theta^2$ intact.
>
> **Where $\sigma$ actually becomes load-bearing**, re-derived: at $S^5\times S^q$ the $(4,0)$ criterion $3m_4<\theta^2$ reads $18\alpha^2<\theta^2$, i.e. $18q^2<16(q+4)^2$, i.e. $q<\tfrac{16}{4\sqrt2-4}=65.94$. *Screen: $18\cdot(\tfrac{65}{276})^2\cdot16=0.998351<1$ and $18\cdot(\tfrac{66}{280})^2\cdot16=\tfrac{19602}{19600}>1$.* **So the first point at which $-\tfrac12\sigma^2$ is needed is $S^5\times S^{66}$, $n=71$**, already on record in [second-order.md](../findings/second-order.md), but not connected to this sentence.

> ### 3e, the successor rule is overreach
>
> *"A successor may not reduce the joint inequality to any statement in $m_4$ alone."* **At $\sigma=0$ the joint inequality *is* a statement in $m_4$ alone** ($m_4<\theta^2/3$), by the section's own sentence two paragraphs earlier, and §1c shows it holds on the whole $\sigma=0$ branch of the family with a factor of $8$ to spare. The rule that survives is narrower: *a sufficient condition of the form $m_4<f(\theta)$ valid at **every** four-set is dead*, since $S^5\times S^{66}$ carries $m_4>\theta^2/3$ with the clause still true.

**And the route dies on $E$, not on concentration.** The exact form of 3a is $\sum_{a\in S}s_a-E<\tfrac23\theta^2$, and **that holds at the witness**: $1.460870-0.458464=1.002406$ against $\tfrac23\theta^2=1.064510$. So row mass is a viable coordinate for the criterion; what is dead is *discarding $E$*, which at the witness is $0.458464$, **$31\%$ of $\sum_{a\in S}s_a$**. Recording it that way tells a successor which term to keep rather than which coordinate to abandon.

## 4. The entry-spread conversion, right, but calibrated where it has nothing to convert

**4a is a valid derivation.** From [r398](REVIEW_r398.md)'s $(M\tilde o)_a=\tilde o_a(\theta-p_a)$ on $I$, $\lvert\tilde o_a\rvert=\lvert\langle M_a,\tilde o\rangle\rvert/\lvert\theta-p_a\rvert\le\sqrt{s_a}\lVert\tilde o\rVert/\lvert\theta-p_a\rvert$, and bounding the max of the ratio by the ratio of extremes gives the stated form. ✓ *Lossy in two places, both acknowledgeable: Cauchy–Schwarz discards the direction of $M_a$, and the $\max/\min$ split decouples a numerator and denominator that vary together.*

**4b is a real gap.** $\tilde o$ lives on $[n]$ with $\tilde o_j=M_{jk}$, $\tilde o_k=-M_{jk}$ ([r398](REVIEW_r398.md) §0), and $(M\tilde o)_a$ reads those two coordinates. **[Lemma L68](../findings/diagonal-half.md) supplies $\lVert\tilde o\vert_I\rVert^2=s_j+s_k-2\theta M_{jk}$, not $\lVert\tilde o\rVert^2=\lVert\tilde o\vert_I\rVert^2+2M_{jk}^2$.** Substituting L68 for the numerator understates the bound by that $2M_{jk}^2$ and is not justified by any step on record. *At a twin pair the error is total: L68 returns $0$ while $\lVert\tilde o\rVert^2=2M_{jk}^2>0$.*

**4c: the numbers are exact and the point is empty.** With $u=\theta/55$ at $S^6\times S^6$: $\alpha=\beta=6u$, $\gamma=-5u$, $\theta=55u$, $g=\lvert\gamma\rvert=5u$. For a within-factor pair, $p_a=2\alpha=12u$ on $F_1\setminus\{j,k\}$ and $p_a=2\gamma=-10u$ on $F_2$, so $\theta-p_a\in\{43u,65u\}=\{8.6g,13g\}$. **Confirmed to the digit.** ✓

> **But a within-factor pair of $S^p\times S^q$ is a twin pair**: every $a\in I$ has $M_{aj}=M_{ak}$, so $\tilde o\vert_I\equiv0$ and $\lVert\tilde o\vert_I\rVert_\infty=0$ exactly, while the bound returns $\sqrt{1/6}\cdot\lVert\tilde o\rVert/(8.6g)>0$. **The conversion's only evaluation is at the one family of pairs where its left side is identically zero**, the same emptiness [r398](REVIEW_r398.md) recorded against that section's claim 7, repeated one section later.

**The informative calibration, supplied.** At the **cross** pair of $S^6\times S^6$ ($j\in F_1$, $k\in F_2$): $p_a=\alpha+\gamma=u$ for *every* $a\in I$, so $\theta-p_a=54u=10.8g$ uniformly, and $\tilde o_a=\pm11u$. *Screen, exact:* $\lVert\tilde o\vert_I\rVert=0.781736$ (matching L68's $s_j+s_k-2\theta M_{jk}=0.611111$), $\lVert\tilde o\rVert=0.797724$, $s_a=\tfrac16$ at every row.

| quantity | value |
| --- | --- |
| truth $\lVert\tilde o\vert_I\rVert_\infty=11u$ | $0.247207$ |
| the bound, with the correct $\lVert\tilde o\rVert$ | $0.268359$, **$8.6\%$ lossy** |
| the bound, with L68's $\lVert\tilde o\vert_I\rVert$ (4b's slip) | $0.262980$ |
| trivial $\lVert\tilde o\vert_I\rVert_\infty\le\lVert\tilde o\rVert$ | $0.797724$ |

**So the conversion is sharp where it has content, and beats the trivial bound by $3.0\times$.** That is a better verdict than the section gives itself, and it should replace the twin-pair evaluation on the record.

**The non-vacuity condition, unstated.** The bound improves on $\lVert\tilde o\vert_I\rVert_\infty\le\lVert\tilde o\rVert$ **only when** $\min_{a\in I}\lvert\theta-p_a\rvert>\sqrt{\max_as_a}$. At the $S^6\times S^6$ cross pair the factor is $\sqrt{1/6}/(54u)=0.336$; nothing on record guarantees it is below $1$ in general.

> ### 4d, the named danger is now bounded, in two lines
>
> The section asks whether $\min_{a\in I}\lvert\theta-p_a\rvert$ can be small and leaves it open. It can be constrained cheaply.
>
> **First, $\sum_as_a=2$ forces $s_a\le1$ for every $a$**, since $\sum_as_a=2\sum_{a<b}M_{ab}^2$ makes $s_a$ a partial sum of a total of $1$. Then $p_a^2=(M_{aj}+M_{ak})^2\le2(M_{aj}^2+M_{ak}^2)\le2s_a\le2$, so $\lvert p_a\rvert\le\sqrt2$ and **$p_a=\theta$ is possible only if $\theta\le\sqrt2$**, no exclusion, since the band runs to $\sqrt2$.
>
> **But it is possible at very few indices.** $p_a=\theta$ forces $s_a\ge\tfrac{\theta^2}2\ge\tfrac34$, i.e. row $a$ alone carries at least $\tfrac38$ of the total mass $2$. Since $\sum_as_a=2$, **at most two indices of $[n]$ can satisfy that, for any pair $\{j,k\}$ whatsoever.** Quantitatively, $\#\{a:\lvert p_a\rvert\ge c\}\le2(s_j+s_k)/c^2\le4/c^2$, so at $c=\theta\ge\sqrt{3/2}$ the count is at most $\lfloor8/3\rfloor=2$.
>
> **So the conversion's blow-up is confined to at most two coordinates, and only at rows carrying $\ge\tfrac38$ of the mass.** A successor can excise those two coordinates by hand and run the bound on the rest. *Absent from [findings/](../findings/): [r398](REVIEW_r398.md) established that $p_a$ itself appears nowhere, and no mass restriction on it exists.*

## 5. The framing, right direction, wrong evidence

**F51 test 1 ("is there a genuinely new input"), answered "no": agreed.** $p_a$ is the eigen-equation's own diagonal ([post F47](../findings/INDEX-traps.md), as [r398](REVIEW_r398.md) established), and $s_a$ enters through a Cauchy–Schwarz that discards direction. ✓

**F51 test 2 ("does it beat anything"), answered "no": the argument does not support the answer.** *"The four-set clause does not need a spread bound, the incumbent already clears it by more than $3.5\times$ across the in-band family"* establishes that the conversion beats nothing **where the record already has exact evaluations**. The four-set clause's open case is precisely the arbitrary in-band point, where neither the incumbent nor the conversion has been evaluated. **"It beats nothing" is demonstrated exactly where nothing needs beating.**

**And the price is mispriced.** The section fixes the factor at $\sqrt{\max s_a}/(8.6g)$ from a twin pair. The honest price is the cross-pair figure of §4: a $3.0\times$ gain over the trivial bound at an $8.6\%$ loss against the truth. **"Price and not route" is the right verdict; the number attached to it is from the wrong pair.**

## Novelty

| item | status |
| --- | --- |
| $m_4\le\tfrac12\sum_{a\in S}s_a$ | absent from [findings/](../findings/), the phrase "row mass" there is [second-order.md](../findings/second-order.md)'s $\widetilde N$ condition, unrelated. **Bookkeeping, not mathematics** |
| $\sum_{a\in S}s_a=\tfrac{168}{115}$ at the witness | absent; the record carries only the $\ge1.002$ lower bound |
| $\big(3m_4-\tfrac12\sigma^2\big)/\theta^2=\tfrac9{2(p-1)^2}$, family sup $\tfrac9{32}$ | **new.** $0.28125$ appears only as [r400](REVIEW_r400.md)'s screen figure; the hits in [r140](REVIEW_r140.md) and [r146](REVIEW_r146.md) are $\sum\lambda^3$ at $S^3\times S^3$, unrelated |
| the in-band $\sigma=0$ four-sets at $S^p\times S^{p+1}$ | **new** |
| the $n=4$ out-of-band $\sigma=0$ witness with $3m_4-\tfrac12\sigma^2=3>\theta^2$ | **new**; shows the band is load-bearing for that branch |
| $\lVert\tilde o\rVert^2=\lVert\tilde o\vert_I\rVert^2+2M_{jk}^2$ | implicit in [r398](REVIEW_r398.md) §0, not stated |
| $\#\{a:\lvert p_a\rvert\ge\theta\}\le2$ from $s_a\le1$ and $\sum_as_a=2$ | **new**; $p_a$ appears nowhere in [findings/](../findings/) per [r398](REVIEW_r398.md) |
| $p_a=\alpha+\gamma$ uniformly on $I$ at a cross pair, $\theta-p_a=10.8g$ | **new** |

## What should change on the record

1. **Withdraw "the worst case is $\sigma=0$"** from [ATTEMPTS.md](../ATTEMPTS.md) and the "extremes are understood" clause in [plan.md](../plan.md)'s [I18](../plan.md) entry. Replace with the closed form of §2: the family maximiser is the $(3,1)$ set at $p=5$, ratio $\tfrac9{2(p-1)^2}$, supremum $\tfrac9{32}$, at $\sigma\ne0$; and $\sigma=0$ sets exist in band with ratio $\le\tfrac18$.
2. **Record $\sum_{a\in S}s_a=\tfrac{168}{115}=1.460870$** in place of $\ge1.002$, with the $q\to\infty$ limit $1.6$.
3. **Re-attach the "$-\tfrac12\sigma^2$ is load-bearing" sentence to $S^5\times S^{66}$**, and state the surviving successor rule as *no $m_4<f(\theta)$ uniform over all four-sets*, rather than *no statement in $m_4$ alone*.
4. **Record that the row-mass route dies on discarding $E$** ($31\%$ of $\sum_{a\in S}s_a$ at the witness), since the exact form $\sum_{a\in S}s_a-E<\tfrac23\theta^2$ still holds there.
5. **Replace the twin-pair evaluation of the conversion with the cross-pair one**, and add the numerator correction $\lVert\tilde o\rVert^2=\lVert\tilde o\vert_I\rVert^2+2M_{jk}^2$ and the non-vacuity condition $\min\lvert\theta-p_a\rvert>\sqrt{\max s_a}$.
6. **Add §4d's two-index bound** as the answer to the section's own closing question.
