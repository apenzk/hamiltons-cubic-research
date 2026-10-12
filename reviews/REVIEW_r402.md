# Review r402, Gate 2 on the four-set reduction, the row-mass refutation, and the entry-spread price

*Second adversarial review of the last three sections of [ATTEMPTS.md](../ATTEMPTS.md), 2026-09-02, run cold. §0–§4 below were derived from the setup alone, the two-factor family from hollowness, zero row sums and criticality; the row-mass accounting; the four-set ratio in closed form; the maximisation of $3m_4-\tfrac12\sigma^2$; and $\theta-p_a$ at $S^6\times S^6$, **before either the sections or [r401](REVIEW_r401.md) were opened**. Analysis only, inherited: every figure below is exact evaluation of objects this review constructed, reported as a screen; each verdict also carries a closed-form proof that needs no run.*

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1a | $m_4\le\tfrac12\sum_{a\in S}s_a$, and it is right with that constant | **CONFIRMED.** It is the double-counting identity $\sum_{a\in S}s_a=2m_4+E$ with $E$ dropped; equality iff $E=0$ iff $S$ is a union of components, so **never tight** under the connectedness the item assumes |
| 1b | four rows carry more than half the total mass at an in-band pure critical point | **CONFIRMED**, and the looseness is in the safe direction. Cold value $\sum_{a\in S}s_a=\tfrac{168}{115}=1.460870$, against the recorded floor $1.002406$ |
| 1c | that reading generalised to *every* in-band point | **REFUTED** (guard against a mis-citation the sentence invites). At $S^6\times S^6$ every four-subset has $\sum_{a\in S}s_a=\tfrac23$ and $\max m_4=\tfrac6{55}=0.109091$ |
| 2 | the margin does not decay in $n$ | **CONFIRMED, and it is a closed form rather than a screen**: $\big(3m_4-\tfrac12\sigma^2\big)/\theta^2=\tfrac9{2(p-1)^2}$ at every $(3,1)$ set, supremum exactly $\tfrac9{32}$. *Independently identical to [r401](REVIEW_r401.md) §2* |
| 2b | the scope of that non-decay | **CORRECTED.** It is non-decay across the two-factor family, which is every point the record can evaluate, not across the class the clause quantifies over |
| 3 | "the worst case for the joint bound is $\sigma=0$" | **REFUTED.** $\sigma=0$ is the *easiest* branch. Second independent witness family supplied: the $(2,2)$ sets at $q(q-1)+p(p-1)=4(p-1)(q-1)$, in band at $S^7\times S^{22}$, $S^{22}\times S^{78}$, $S^{78}\times S^{287}$, with $m_4/\theta^2=0.0292$, $0.00274$, $0.000203$ |
| 3b | "a successor may not reduce the joint inequality to any statement in $m_4$ alone" | **CONFIRMED and now provable, [r401](REVIEW_r401.md)'s "OVERREACH" is a mislabel.** See §3.2; the proof uses [r401](REVIEW_r401.md)'s own in-band $\sigma=0$ sets |
| 4a | $\theta-p_a\in\{8.6g,13g\}$ at a within-factor pair of $S^6\times S^6$ | **CONFIRMED exactly**: $\tfrac{43}5\lvert\gamma\rvert$ and $13\lvert\gamma\rvert$ |
| 4b | "$\min_{a\in I}\lvert\theta-p_a\rvert$ small … whether that configuration is reachable in the band is a well-posed question" | **ANSWERED: it is not reachable.** $p_a<\theta$ at **every** pure critical point in the band, unconditionally, with $\theta-p_a\ge(1-s_a)/(2\theta)$. §4 |
| 5 | novelty | §5. Claim 2's closed form is [r401](REVIEW_r401.md)'s, reached here independently; §4's closure is new against both the record and [r401](REVIEW_r401.md) |

**The brief asked whether the row-mass inequality is loose and whether the conclusion survives. It is loose, it discards $E=0.458464$, $31\%$ of the row mass, and the conclusion survives *a fortiori*, since the discard moves $\sum_{a\in S}s_a$ upward.** The one broken step in the three sections is the $\sigma=0$ framing. **The one open question they close by asking it is §4's**, and it closes the other way from the way the section expects: the denominator cannot vanish, and the band is exactly the hypothesis that makes it so.

---

## 0. The family, reconstructed cold

$M_{ab}=\alpha$ inside $F_1$ ($\lvert F_1\rvert=p$), $\beta$ inside $F_2$ ($\lvert F_2\rvert=q$), $\gamma$ across; $n=p+q$, $D=n-1$. Zero row sums give $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$. Cross-block criticality is $\gamma^2+(M^2)_{jk}=\theta\gamma$ with $(M^2)_{jk}=(p-1)\alpha\gamma+(q-1)\beta\gamma=-n\gamma^2$, so $\gamma(1-n)=\theta$; within-block criticality is then an identity in $\theta$, and $\operatorname{tr}M^2=2$ closes it:

$$\gamma=-\frac\theta D,\qquad\alpha=\frac{\theta q}{D(p-1)},\qquad\beta=\frac{\theta p}{D(q-1)},\qquad\theta^2=\frac{2(n-1)(p-1)(q-1)}{pq(n-2)} .$$

*Validated against three catalogued values before anything was built on it*: $\theta=1.236033$ at $(6,6)$, $1.228239$ at $(5,7)$, $1.263631$ at $(5,43)$, all to every printed digit. **The band forces $\min(p,q)\ge5$**: at $p=4$, $\theta^2=\tfrac32\big(1-\tfrac3{q(q+2)}\big)<\tfrac32$ for every $q$, and $p=5$ enters at $q=7$.

**One identity carries most of what follows**, and it is the reason every ratio below is $q$-free:

$$\alpha-\gamma=\frac{\theta(q+p-1)}{D(p-1)}=\frac\theta{p-1},\qquad \beta-\gamma=\frac\theta{q-1} .$$

## 1. The row-mass step: an identity with a defect, used in the safe direction

**1a.** Each pair inside $S$ lies in two of the four rows, each pair leaving $S$ in one:

$$\sum_{a\in S}s_a=2m_4+E,\qquad E:=\!\!\sum_{a\in S,\,c\notin S}\!\!M_{ac}^2\ \ge0 .$$

So $m_4\le\tfrac12\sum_{a\in S}s_a$ is the identity with $E$ discarded, **direction and constant both forced**, equality exactly when $S$ is a union of connected components of $\operatorname{supp}M$. Connectedness is one of the item's standing hypotheses, so **the inequality is strict at every point the item is about**, and the step is never tight.

**1b, computed cold at the witness.** At $S^5\times S^{43}$'s $(4,0)$ set inside the $5$-factor, $s_a=4\alpha^2+43\gamma^2=\tfrac{2021}{8836}\theta^2$ for each $a\in F_1$, hence

$$\sum_{a\in S}s_a=\frac{2021}{2209}\theta^2=\frac{168}{115}=1.4608696,\qquad E=0.4584638 .$$

*Screen: $5s_a+43s_b=1.826087+0.173913=2$ exactly.* **Four of $48$ rows carry $73.0\%$ of the total mass**; in the $q\to\infty$ limit at $p=5$, $\alpha\to\theta/4$, $\theta^2\to\tfrac85$, and the share rises to $\sum_{a\in S}s_a\to\tfrac85$, i.e. $80\%$. The record's $\ge1.002$ is the truth divided by $1.46$.

**So the looseness question the brief poses has a clean answer.** The discarded $E$ is $31\%$ of $\sum_{a\in S}s_a$, so the inequality is badly lossy, **but it is applied as $\sum_{a\in S}s_a\ge2m_4$, and the loss makes the left side larger.** The conclusion "four rows carry more than half" is therefore not merely intact but understated. *A route that needed the inequality in the other direction, $m_4$ bounded above by row masses, would lose the whole of $E$ and is dead at this witness.*

> ### 1c, the sentence is existential and must stay that way
>
> Read as a universal (*four rows carry more than half the mass at in-band pure critical points*), it is **false**, and the counterexample is the conjecture's own equality case. At $S^6\times S^6$, $s_a=\tfrac16$ for every row by symmetry, so **every** four-subset has $\sum_{a\in S}s_a=\tfrac23$, a third of the total; the largest $m_4$ there is $6\alpha^2=\tfrac6{55}=0.109091$, below the threshold by a factor of $4.6$. The concentration is a $p=5$ phenomenon and it starts late: the smallest in-band point with any four-subset above half is $S^5\times S^8$ at $n=13$, $\sum_{a\in S}s_a=1.018182$.
>
> *This matters because [findings/INDEX-traps.md](../findings/INDEX-traps.md)'s [post F50](../findings/INDEX-traps.md) is stated in the existential form and the [ATTEMPTS.md](../ATTEMPTS.md) sentence is one comma from the universal one.*

## 2. The margin, a theorem on the family, and its scope

On a $(3,1)$ set inside $F_1$ the six entries are $3$ copies of $\alpha$ and $3$ of $\gamma$, so $3m_4-\tfrac12\sigma^2=9(\alpha^2+\gamma^2)-\tfrac92(\alpha+\gamma)^2=\tfrac92(\alpha-\gamma)^2$, and §0's identity gives

$$\boxed{\ \frac{3m_4-\tfrac12\sigma^2}{\theta^2}=\frac9{2(p-1)^2}\ \text{ at every }(3,1)\text{ set},\qquad \frac9{2(q-1)^2}\ \text{ at every }(1,3)\text{ set}.\ }$$

$(4,0)$ and $(0,4)$ give exactly $0$, since all six entries agree and $\sigma^2=6m_4$. Writing $A=\theta/(p-1)$, $B=\theta/(q-1)$, the $(2,2)$ value is $\tfrac52A^2+\tfrac52B^2-AB$, **$\gamma$-free**, and

$$\tfrac92A^2-\big(\tfrac52A^2+\tfrac52B^2-AB\big)=2A^2+AB-\tfrac52B^2\ \ge\ \tfrac12B^2>0\quad(B\le A),$$

so the $(3,1)$ type dominates at every $(p,q)$, no screen needed. With $\min(p,q)\ge5$ from §0 the family supremum is $\tfrac9{2\cdot16}=\tfrac9{32}=0.28125$, **attained at $p=5$ for every $q\ge7$**, hence at every $n\ge12$. *Screen over $2\le p\le299$, $p\le q\le1499$, all five types: maximum $=0.2812500000$.* [r400](REVIEW_r400.md)'s figure is exact and its $q\le200$ cutoff is irrelevant; the clause clears by $\tfrac{32}9=3.56\times$ uniformly.

**This reproduces [r401](REVIEW_r401.md) §2 exactly, reached independently and by a different route** (that review bounds the $(2,2)$ type termwise; the ordering above is unconditional). *Two cold derivations agreeing on a boxed closed form is the strongest form this record's Gate 2 produces, and the figure should move from [r400](REVIEW_r400.md)'s screen line into [findings/second-order.md](../findings/second-order.md) as a lemma on the family.*

**2b, the scope correction.** The ratio depends on $p$ alone. Non-decay in $n$ is therefore automatic *within the family* and says nothing about an arbitrary in-band pure critical point, where no evaluation exists. The comparison drawn against the pair clause's $\tfrac1{2(Q-1)}$ is nonetheless fair (that too is an exact evaluation on the same family) so the sentence should read **"the margin does not decay across the two-factor family"**, keeping the comparison and dropping the implied quantifier.

## 3. $\sigma=0$ is the easiest case, not the worst

**3.1, the framing is inverted.** At fixed $m_4$, $-\tfrac12\sigma^2$ is largest at $\sigma=0$; that is a statement about the relaxed box, not about the set of critical points. Under the true constraints the two coordinates are **anti-correlated**: $m_4$ is large exactly when the six entries are near-equal and same-signed, which is $\sigma^2\to6m_4$, and the $\sigma=0$ corner of the box is populated only at small $m_4$.

**Second witness family, independent of [r401](REVIEW_r401.md)'s $q=p+1$ route.** On a $(2,2)$ set, $\sigma=\alpha+\beta+4\gamma=\tfrac\theta D\big[\tfrac q{p-1}+\tfrac p{q-1}-4\big]$, so $\sigma=0$ exactly when $q(q-1)+p(p-1)=4(p-1)(q-1)$. *Screen over $p\le80$, $q\le600$:*

| point | $n$ | $\theta$ | band | $m_4$ | $\theta^2/3$ | $m_4/\theta^2$ |
| --- | --- | --- | --- | --- | --- | --- |
| $S^7\times S^{22}$ | $29$ | $1.302678$ | in | $0.037999$ | $0.565657$ | $0.02240$ |
| $S^{22}\times S^{78}$ | $100$ | $1.379799$ | in | $0.003473$ | $0.634615$ | $0.00182$ |
| $S^{78}\times S^{287}$ | $365$ | $1.404599$ | in | $0.000268$ | $0.657633$ | $0.00014$ |
| $S^3\times S^7$ | $10$ | $1.133893$ | out | $0.261905$ | $0.428571$ | $0.20370$ |

**So on the record's own family the $\sigma=0$ branch clears $m_4<\theta^2/3$ by one to three orders of magnitude, and it decays in $n$, while the maximiser at $\sigma\ne0$ does not.** *This corroborates [r401](REVIEW_r401.md) §1c from a second family and adds the $p\ne q+1$ case it does not cover.*

> ### 3.2, the successor rule is CORRECT, and [r401](REVIEW_r401.md)'s "OVERREACH" is a mislabel
>
> [ATTEMPTS.md](../ATTEMPTS.md) closes with *"a successor may not reduce the joint inequality to any statement in $m_4$ alone"*. [r401](REVIEW_r401.md) grades that OVERREACH on the ground that *at $\sigma=0$ the joint inequality is a statement in $m_4$ alone*. **That reads the sentence as a claim about instances; it is a claim about proof routes, and as such it is a theorem.**
>
> **Proof.** Let $C(m_4,\theta)$ be any condition sufficient for $3m_4-\tfrac12\sigma^2<\theta^2$ at every four-set of every in-band pure critical point. Because in-band four-sets with $\sigma=0$ exist, [r401](REVIEW_r401.md)'s $S^6\times S^7$ $(1,3)$ sets, and §3.1's $S^7\times S^{22}$ $(2,2)$ sets, $C$ must imply $m_4<\theta^2/3$ wherever it is invoked. But $m_4<\theta^2/3$ **fails in band**: at $S^5\times S^{66}$, $n=71$, $\theta=1.264355$, a $(4,0)$ set carries $m_4=0.532919>\theta^2/3=0.532865$, and $\sup m_4/\theta^2=\tfrac38>\tfrac13$ along $p=5$. So no such $C$ holds at every four-set. $\square$
>
> *The two ingredients were on the record separately, [second-order.md](../findings/second-order.md) has the $S^5\times S^{66}$ failure, and [r401](REVIEW_r401.md) §1c supplies the in-band $\sigma=0$ sets, and neither review joined them.* **[r401](REVIEW_r401.md)'s replacement rule, "no $m_4<f(\theta)$ uniform over all four-sets", is the same statement**, so its recommendation 3 would replace a correct sentence with a paraphrase of itself while grading it an overreach. **The sentence should stand, with the two-line proof attached.**

## 4. The conversion's denominator cannot vanish, and the band is exactly why

The section closes by asking whether a pure critical point in the band can have $p_a=M_{aj}+M_{ak}$ close to $\theta$. **It cannot, and the proof is four lines from hollowness.**

**Step 1, a free cap on every entry.** $M$ hollow makes $(M_a-M_b)_a=-M_{ab}$ and $(M_a-M_b)_b=M_{ab}$, so $\lVert M_a-M_b\rVert^2\ge2M_{ab}^2$ **for free**. Criticality gives $(M^2)_{ab}=\theta M_{ab}-M_{ab}^2$, hence $\lVert M_a-M_b\rVert^2=s_a+s_b-2\theta M_{ab}+2M_{ab}^2$, and the two combine to

$$\boxed{\ M_{ab}\ \le\ \frac{s_a+s_b}{2\theta}\ }\qquad\text{at every pure critical point, with equality iff }\{a,b\}\text{ is a twin pair.}$$

*This is [Lemma L68](../findings/diagonal-half.md)'s $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ with the observation that $g_{ab}\ge0$ needs no hypothesis at all, the symmetry defect is nonnegative on hollow matrices by the two coordinates $a$ and $b$ alone.*

**Step 2, two row masses are all a row can hold.** $s_a=\sum_bM_{ab}^2$ sums over the pairs meeting $a$, a subset of all pairs, whose total is $\tfrac12\operatorname{tr}M^2=1$: so $s_a\le1$ for every $a$, and $\sum_as_a=2$ gives $s_a+s_j+s_k\le2$.

**Step 3, the chain, and the band is the last step.**

$$p_a=M_{aj}+M_{ak}\ \le\ \frac{2s_a+s_j+s_k}{2\theta}\ =\ \frac{s_a+(s_a+s_j+s_k)}{2\theta}\ \le\ \frac3{2\theta}\ \le\ \theta,$$

the final inequality being **precisely $\theta^2\ge\tfrac32$**. Equality throughout forces $\theta^2=\tfrac32$, $s_a=1$ and $s_j+s_k=1$ with every other row null, so $\operatorname{supp}M$ is a star centred at $a$, whose leaf row sums force $M_{ja}=0$ and hence $M=0$, against $\operatorname{tr}M^2=2$. **Therefore $p_a<\theta$ strictly, for every pair $\{j,k\}$, every $a\in I$, and every in-band pure critical point.**

**Quantitatively**, keeping $s_a$:

$$\theta-p_a\ \ge\ \frac{2\theta^2-2s_a-s_j-s_k}{2\theta}\ \ge\ \frac{1-s_a}{2\theta}\ \ge\ \frac{1-\max_bs_b}{2\theta}\ >\ 0 .$$

**Screen, on the family, and the estimate is exactly tight there.** For every point tested the middle bound $\theta-(2s_a+s_j+s_k)/(2\theta)$ **equals** the true $\min_{a\in I}(\theta-p_a)$ to machine precision, because within-factor pairs are twin pairs and saturate Step 1:

| point | $\theta$ | $\max_as_a$ | true $\min(\theta-p_a)$ | Step-3 bound | $(1-\max s)/2\theta$ | $\theta-\tfrac3{2\theta}$ |
| --- | --- | --- | --- | --- | --- | --- |
| $S^5\times S^7$ | $1.228239$ | $0.240000$ | $0.837436$ | $0.837436$ | $0.309386$ | $0.006979$ |
| $S^6\times S^6$ | $1.236033$ | $0.166667$ | $0.966353$ | $0.966353$ | $0.337100$ | $0.022473$ |
| $S^5\times S^{43}$ | $1.263631$ | $0.365217$ | $0.685587$ | $0.685587$ | $0.251174$ | $0.076576$ |
| $S^5\times S^{70}$ | $1.264416$ | $0.378082$ | $0.666381$ | $0.666381$ | $0.245931$ | $0.078097$ |
| $S^{12}\times S^{12}$ | $1.325498$ | $0.083333$ | $1.199759$ | $1.199759$ | $0.345782$ | $0.193848$ |

*Axioms re-verified at each row: $\max_a\lvert(M\mathbf1)_a\rvert\le8\times10^{-16}$, $\operatorname{tr}M^2=2$, criticality residual $\le3\times10^{-16}$, cap violation $\le2\times10^{-16}$.* Over the whole in-band family the true minimum of $\lvert\theta-p_a\rvert$ across within-factor, cross and other-factor positions is $0.635256$, approaching $\theta/2$ along $p=5$.

**4a is confirmed exactly.** With $u=\theta/55$ at $S^6\times S^6$: $\alpha=6u$, $\gamma=-5u$, $g=\lvert\gamma\rvert=5u$, and for a within-factor pair $\theta-p_a=43u=\tfrac{43}5g=8.6g$ on the same factor and $65u=13g$ on the other. In closed form, $\tfrac{43}{6\sqrt{55}}=0.9663531$ and $\tfrac{13\sqrt{55}}{66}=1.4607664$.

> **What this does to the item.** The section's closing question (*"whether that configuration is reachable in the band"*), is answered **no**, unconditionally, with the band as the only hypothesis spent and spent sharply. It supersedes [r401](REVIEW_r401.md) §4d, which bounds the dangerous indices at **two**; the count is **zero**. *The conversion is therefore never singular, and what remains against it is only [r401](REVIEW_r401.md)'s correct observation that its one recorded evaluation sits at a twin pair, where $\tilde o\vert_I\equiv0$ and there is nothing to convert.*

## 5. Novelty

| item | status |
| --- | --- |
| $\sum_{a\in S}s_a=2m_4+E$, and $\sum_{a\in S}s_a=\tfrac{168}{115}$ at the witness | absent from [findings/](../findings/); **also reached by [r401](REVIEW_r401.md)**, independent agreement, and bookkeeping rather than mathematics |
| $\big(3m_4-\tfrac12\sigma^2\big)/\theta^2=\tfrac9{2(p-1)^2}$, family supremum $\tfrac9{32}$ | **[r401](REVIEW_r401.md)'s**, reproduced here cold and by a different route for the $(2,2)$ comparison. *Not claimed as new; claimed as confirmed twice* |
| the $\sigma=0$ $(2,2)$ family $q(q-1)+p(p-1)=4(p-1)(q-1)$, in band at $S^7\times S^{22}$, $S^{22}\times S^{78}$, $S^{78}\times S^{287}$ | **new**; [r401](REVIEW_r401.md) has the $(1,3)$ family at $q=p+1$ only |
| the two-line proof that no $m_4$-only sufficient condition can exist | **new**; joins [second-order.md](../findings/second-order.md)'s $S^5\times S^{66}$ to [r401](REVIEW_r401.md) §1c |
| $M_{ab}\le(s_a+s_b)/(2\theta)$ **unconditionally**, $g_{ab}\ge0$ being free on hollow matrices | **new as an unconditional statement.** [Lemma L68](../findings/diagonal-half.md) has $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ and calls it a cap; the two-coordinate reason it is nonnegative is not on record |
| $p_a<\theta$ at every in-band pure critical point, and $\theta-p_a\ge(1-s_a)/(2\theta)$ | **new**, and stronger than [r401](REVIEW_r401.md) §4d's two-index bound. Answers the section's own closing question |
| $s_a\le1$ from $\sum_{a<b}M_{ab}^2=1$ | **[r401](REVIEW_r401.md)'s**, used here in Step 2 |
| $\max_as_a\to\tfrac25$ along the $p=5$ ray, so the family never approaches the $s_a=1$ ceiling | **new**, and it is what makes the quantitative bound non-vacuous on everything catalogued |

## 6. Hypotheses used silently by the sections

1. **Every "in-band pure critical point" in the three sections is a two-factor sphere product.** Each quantitative claim, $0.28125$, the non-decay, the $\sigma$ comparison, the $\theta-p_a$ evaluation, is a statement about a two-parameter family of maximally symmetric diagonal points. [ATTEMPTS.md](../ATTEMPTS.md) says so once; [plan.md](../plan.md)'s "the extremes are understood" does not.
2. **Connectedness of $\operatorname{supp}M$** is what makes $E>0$, hence what makes §1's inequality strict and lossy. It is listed among the item's silent hypotheses elsewhere and is not restated where the row-mass step uses it.
3. **$\gamma\ne0$** in the family's construction, the cross-criticality equation is divided by $\gamma$. $\gamma=0$ is the disconnected $M$ that hypothesis 2 excludes.
4. **$\theta>0$** in the entry cap of §4 and in every division by $\theta$ in the block calculus.
5. **The four-set clause's target is $\Sigma\ne\theta^2$, not $\Sigma<\theta^2$** ([r373](REVIEW_r373.md)/[r374](REVIEW_r374.md)). The sections work with the sufficient condition $3m_4-\tfrac12\sigma^2<\theta^2$, which is fine, but "the clause clears by $3.5\times$" is a margin in the sufficient condition and not in the clause.

## 7. What should change on the record

1. **Keep the successor rule** *"a successor may not reduce the joint inequality to any statement in $m_4$ alone"* and attach §3.2's proof; **do not act on [r401](REVIEW_r401.md)'s recommendation 3** to weaken it.
2. **Record $\sum_{a\in S}s_a=\tfrac{168}{115}=1.460870$** with the limit $\tfrac85$, and **state the four-rows sentence existentially**, with $S^6\times S^6$'s $\tfrac23$ beside it so the universal reading is fenced.
3. **Withdraw "the worst case is $\sigma=0$"**, replacing it with §2's closed form and the two $\sigma=0$ families, which together show that branch is the easiest and that it decays in $n$.
4. **Promote $\tfrac9{2(p-1)^2}$ to a lemma in [findings/second-order.md](../findings/second-order.md)**, with both this review's and [r401](REVIEW_r401.md)'s derivations cited, it is now twice-confirmed closed form, not a screen.
5. **Record §4's closure**: the unconditional cap $M_{ab}\le(s_a+s_b)/(2\theta)$, $p_a<\theta$ in band, and $\theta-p_a\ge(1-s_a)/(2\theta)$. It answers the entry-spread section's closing question, supersedes [r401](REVIEW_r401.md) §4d, and identifies the band as the hypothesis that does the work, used at exactly one step, where it is sharp.
