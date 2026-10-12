# REVIEW_r563, Lemma L107, the $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$

**Reviewer** r563, independent adversarial audit, working from the definitions. **Target** [Lemma L107](../findings/bounds.md), [bounds.md](../findings/bounds.md) line 343 and its block. **Footing** analysis only: every derivation below is by hand. No computation was run; the two arithmetic checks reported are hand evaluations of closed forms I had already derived, and neither is offered as evidence for a positive claim. Log: [agent_logs/r563-L107.log](../agent_logs/r563-L107.log).

## Verdict table

| item | verdict |
| --- | --- |
| **the inequality $\theta\le(n-1)\lvert\lambda_{\min}\rvert$** | **CONFIRMED**, every step, by two routes |
| **D1** the heading's "derived twice" | **REFUTED**, the block carries **one** derivation; the record carries **three**, two of them 45 lines away in another lemma's section |
| **D2** the measure $\mu_a$ and the moment the chain needs | **REPAIRED**, $\mu_a$ is the $T$-weighted measure, **not uniform**, and its first moment is relation **(B)**, not trace-freeness. The block names neither |
| **D3** the provenance of (A), (B), (C) | **DEFECT**, all three are load-bearing and **none carries a result number** |
| **D4** the sign conditions $\lambda_{\max}>0$, $\lambda_{\min}<0$ | **CONFIRMED, discharge missing from the text**, both are automatic from $\operatorname{tr}_{\Lambda^2}W=0$ with $W\ne0$ |
| **D5** the quantifier | **REPAIRED, and the lemma is stronger than stated**, the bound holds at **every** $W\in\mathcal W_n$ of unit norm, criticality nowhere. It is the withdrawn [L142](../findings/INDEX-results.md) |
| **D6** the letter $\Pi$ | **DEFECT**, three unrelated objects, two of them **incompatible scalars**, and the incompatible pair is where [LEDGER.md](../findings/LEDGER.md) says the lemma is closed |
| **D7** is the bound ever binding | **REFUTED as posed**, it is **exactly tight** at the balanced product and on the whole $S^p\times S^q$ family, so it is binding precisely at the conjectured maximiser |
| **D8** the withdrawn STEP 2 | **CONFIRMED CLEAN**, L107's chain uses no optimality claim about which row is strongest |
| **D9** was the value seen before the derivations | **YES, all three**, the value was on the record at 15:26 and returned by an LP at 20:38; the three derivations land at 22:14, 22:41 and 23:11 the same day |
| **D10** the one-line derivation's stated mechanism | **REFUTED**, the sentence describes a step that cannot produce the displayed inequality; the conclusion is right and its stated route is not |
| **D11** a free sharpening | **REPAIR OFFERED**, excluding the row index from the chord endpoints strengthens L107 **unconditionally**, and returns $\theta$ **exactly** at padded $W_{\mathbb{CP}^2}$, where L107 is slack by $(n-1)/3$ |

**Overall: CONFIRMED as an inequality, REPAIRED as a statement.** Nothing here refutes the mathematics. What is wrong is the heading, the quantifier, the name, and the block's account of where the bound is slack.

## What the block claims, and what is in it

The heading announces a bound "derived twice". The body carries exactly one derivation (the row calculus at $a=\arg\max$), followed by three blockquote retractions and a per-row family that is a different bound. The other derivations sit in the [Lemma L108](../findings/bounds.md) and moment-problem sections 45 to 55 lines earlier, reachable only through one italic aside at line 295 saying "its home is [Lemma L107](../findings/bounds.md)". **A reader who greps the heading finds a lemma whose stated evidential weight lives outside it.**

## The relations the derivation runs on, and their provenance (D3)

With $T_{abc}=c_{abc}^2$ totally symmetric and vanishing on repeated indices ([conventions.md](../findings/conventions.md)), the three per-index relations are

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad\text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad\text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k).$$

**None of the three is a numbered result.** (A) is [conventions.md](../findings/conventions.md)'s Killing marginal, whose companion pair cap is [Lemma L31](../findings/stratum-two-negative.md) while the marginal itself is numbered nowhere; (A) and (B) are [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1's $I\#I=(n-2)I$ and $W\#I=-W$; (C) is the diagonal of $W^\#=\theta W-W^2$. So L107's three inputs can be cited only by prose, in a record whose standing rule is to query by number. This is the failure mode the brief named, and it is structural here rather than incidental: the relations are stated once, in an unnumbered section, and every bound in the file leans on them.

## D2, the measure, and the moment that makes the $(n-2)$ appear on both sides

The block writes "Feeding in the two row moments" and displays neither. They are:

$$\mu_a:=\frac{T_{a\bullet\bullet}}{2(n-2)},\qquad \mathbb E_{\mu_a}\Big[\tfrac{\lambda_b+\lambda_c}2\Big]=\frac{-\lambda_a}{n-2},\qquad \mathbb E_{\mu_a}[\lambda_b\lambda_c]=\frac{\lambda_a(\theta-\lambda_a)}{n-2}.$$

Three corrections to the brief's reading of this step:

- **$\mu_a$ is not uniform over the pairs.** It is the normalised squared-structure-constant marginal $T_{a\bullet\bullet}/2(n-2)$. Uniformity would be false at every point that is not a maximal torus.
- **The first moment is not trace-freeness.** It is relation (B), the Weyl identity $W\#I=-W$, which consumes Ricci-flatness *and* first Bianchi. Trace-freeness gives nothing of the form $-\lambda_a/(n-2)$.
- **The $(n-2)$ comes from the ratio of (A)'s mass to (B)'s.** Row mass $2(n-2)$ from (A) against $-2\lambda_a$ from (B) gives $-\lambda_a/(n-2)$. The competing $-\lambda_a/(n-1)$ the brief asks about would need (A) to carry mass $2(n-1)$, which it does not.

The support is $\{(b,c):b\ne c,\ b\ne a,\ c\ne a\}$, since $T$ vanishes whenever two indices coincide. **That exclusion is what D11 below exploits, and the block never uses it.**

## The derivation, rebuilt

Write $X=\tfrac{\lambda_b+\lambda_c}2$, $Y=\lambda_b\lambda_c$, $s=\lambda_{\max}$, $m=\lvert\lambda_{\min}\rvert$.

1. $Y\le X^2$, which is $(\lambda_b-\lambda_c)^2\ge0$, with equality iff $\lambda_b=\lambda_c$.
2. $X\in[\lambda_{\min},\lambda_{\max}]$, being a mean of two eigenvalues; so $(X-\lambda_{\min})(\lambda_{\max}-X)\ge0$, i.e. $X^2\le(\lambda_{\min}+\lambda_{\max})X-\lambda_{\min}\lambda_{\max}$.
3. Take $\mathbb E_{\mu_a}$ of both and substitute the two moments; multiplying by $n-2>0$ gives the block's display $\lambda_a(\theta-\lambda_a)\le-(\lambda_{\min}+\lambda_{\max})\lambda_a-(n-2)\lambda_{\min}\lambda_{\max}$ for every $a$. **Confirmed.**
4. At $a=\arg\max$ the left side is $s\theta-s^2$ and the right is $-s^2+(n-1)ms$, so the squares cancel exactly and $s\theta\le(n-1)ms$. **Confirmed; the cancellation is exact and turns on $-\lambda_{\min}\lambda_{\max}$ appearing once from the chord and $(n-2)$ times from the constant term.**
5. Dividing by $s>0$ gives $\theta\le(n-1)m$.

## D4, the sign conditions, and where they are discharged

Step 5 needs $\lambda_{\max}>0$, and the conclusion is only informative with $\lambda_{\min}<0$. **Both are automatic and neither is stated in the block.** [conventions.md](../findings/conventions.md) records $\sum\mu=0$ for the $\Lambda^2$ spectrum, so a non-zero $W$ has a strictly positive and a strictly negative eigenvalue. At unit norm the hypothesis is therefore vacuous. **Owed: one clause in the block saying so**, since the display it is applied to is stated "for every $a$" and a reader has no way to see that the $\arg\max$ instance is the one with a live divisor.

## D5, the quantifier is understated, and the correction merges two entries of the record

The record files L107 as a critical-point bound, and [r441](REVIEW_r441.md) flags the resulting "unstated link" in the $M(n)\le n-1$ chain: relation (C) holds only at critical points, so the chain is legitimate only because the supremum is attained at one. **The restriction is unnecessary, by the record's own one-line derivation read carefully.**

The intrinsic definition of the $g$-distribution is $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2$ ([bounds-relaxations.md](../findings/bounds-relaxations.md)), which in an eigenbasis is

$$g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2\,T_{k\alpha\beta}\ \ge\ 0,$$

manifestly, at **every** $W$. [bounds.md](../findings/bounds.md) line 245 instead gives the criticality-specialised rewriting $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$, which is what hides the pointwise reading. Now:

- $\sum_kg_k=4(n-1)\lVert W\rVert^2$ uses **(A) and (B) only**: expanding the square, $\sum_{k\alpha\beta}\lambda_\alpha^2T=2(n-2)\lVert W\rVert^2$ by (A) with $\alpha$ free, twice, and $\sum_{k\alpha\beta}\lambda_\alpha\lambda_\beta T=-2\lVert W\rVert^2$ by (B) with $\alpha$ free.
- $\sum_k\lambda_kg_k=-4P(W)$ uses **(B) and the cubic identity**: the two square terms give $-2\operatorname{tr}W^3$ each by (B) with $\alpha$ free, and the cross term is $-2\sum_{k\alpha\beta}\lambda_k\lambda_\alpha\lambda_\beta T=-4\langle W,W^\#\rangle=-4(P-\operatorname{tr}W^3)$, since $\langle v,W^\#v\rangle=\tfrac12\sum\lambda_\alpha\lambda_\beta c_{v\alpha\beta}^2$ is a definitional identity for $\#$ ([post F40](../findings/fence-posts.md) states it). Total $-4P$.

**Criticality enters neither.** Hence at $\lVert W\rVert=1$, from $\lambda_k\ge\lambda_{\min}$ and $g_k\ge0$,

$$-4P(W)=\sum_k\lambda_kg_k\ \ge\ \lambda_{\min}\sum_kg_k=-4(n-1)\lvert\lambda_{\min}\rvert\ \Longrightarrow\ \theta=P(W)\ \le\ (n-1)\lvert\lambda_{\min}\rvert\quad\text{at every }W\in\mathcal W_n.$$

Reading the same two moments at the other endpoint gives $P\ge-(n-1)\lambda_{\max}$, so $\lvert P(W)\rvert\le(n-1)\lVert\lambda\rVert_\infty$ pointwise. **That is exactly the repaired [L142](../findings/INDEX-results.md) that [r436](REVIEW_r436.md) produced and that [INDEX-results.md](../findings/INDEX-results.md) row 142 files as WITHDRAWN.** So the record holds one inequality twice: once as a critical-point lemma it under-quantifies, and once as a withdrawn result whose repaired form it says "is now the same shape as L107". They are not the same shape; they are the same inequality, and the $g$-route proves both at once.

*Consequence for the consumers.* [r439](REVIEW_r439.md)'s and [r441](REVIEW_r441.md)'s careful "the chain only ever evaluates L107 at a maximiser" is a correct reading of the record and an unnecessary precaution about the mathematics.

## D6, the letter $\Pi$, and the two incompatible scalars

The bound's name refers to no object defined in the block, and the record carries three under the letter:

| sense | object | where |
| --- | --- | --- |
| (i) | the orthogonal projection onto $W^\perp$ | [conventions.md](../findings/conventions.md) |
| (ii) | the scalar $4(n-1)\lvert\lambda_{\min}\rvert$ | [post F40](../findings/fence-posts.md), from $\sum_\gamma g_\gamma=4(n-1)$ over **all** $\gamma$ |
| (iii) | the scalar $\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$ | [post F28](../findings/bounds-relaxations.md)'s slack identity, over the **negative** part only |

**(ii) and (iii) are incompatible, and (iii) is the one the record's own measurements require.** F28's slack identity $\Pi-4\theta=\sum_{\mathfrak m}(\lvert\lambda_{\min}\rvert-\lvert\lambda_\gamma\rvert)g_\gamma+\sum_{\mathfrak p}\lambda_\gamma g_\gamma$ rearranges, against $4\theta=\sum_{\mathfrak m}\lvert\lambda_\gamma\rvert g_\gamma-\sum_{\mathfrak p}\lambda_\gamma g_\gamma$, to $\Pi=\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$ and to nothing else. *Hand check at padded $W_{\mathbb{CP}^2}$, $n=12$*, on the record's own figures: $g$ sits on $E_{\min}\cup\ker W$ with $E_{\min}$-share $4\theta/\lvert\lambda_{\min}\rvert=12$ ([bounds.md](../findings/bounds.md) line 286), so (iii) gives $\Pi=12/\sqrt6=4.898979=4\theta$ and slack zero, which is what F28's "measured slack $\le1.7\times10^{-15}$ across the catalogue, $\Delta=0$ at every $\mathbb{CP}^m$" requires, while (ii) gives $44/\sqrt6=17.962$ and slack $13.063$. **F40's identification is the wrong one**, and [ELIM-bounds.md](ELIM-bounds.md) already said so ("consistent only with $\Pi=\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$ … the definition is not restated in this file and the identity is unreadable without it"). F40 was never amended, and **F40 is the line [LEDGER.md](../findings/LEDGER.md) cites as where L107 is closed.**

Under sense (iii) the honest statement of the family is: the sharp fact is $4\theta\le\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$, and **L107 is its corollary** through $\sum_{\mathfrak m}g_\gamma\le\sum_\gamma g_\gamma=4(n-1)$. The name "$\Pi$-bound" attaches to the corollary.

*Recorded after the fact:* while this audit was running, [conventions.md](../findings/conventions.md)'s $\Pi$ row was rewritten to table exactly this three-way collision. The finding above was reached from F28, F40 and ELIM-bounds independently of that row and agrees with it.

## D7, the bound is tight where the conjecture is decided, and the block's "slack" note is about a different bound

The brief asks whether the $\Pi$-bound is ever binding. **It is an equality at the balanced sphere product.** From the block's own block spectrum, $h/m=n/(n-2)$ there, so $(n-2)h=nm$ and

$$\theta_0(n)=(n-2)h-m=nm-m=(n-1)m=(n-1)\lvert\lambda_{\min}\rvert .$$

*Hand check at $n=6$*, on closed forms derived above: $m=\theta_0(6)/5=0.210819$, $h=\tfrac64m=0.316228$; multiplicities $6$ and $9$ give $6h^2+9m^2=0.6+0.4=1$ and $6h-9m=0$, and $(n-1)m=1.054093=\theta_0(6)$. [r337](REVIEW_r337.md) has the stronger fact already: since $\theta=n-1$ and $\lvert\lambda_{\min}\rvert=1$ in mixed-block units at **every** $S^p\times S^q$, the $\Pi$-bound is exact on the whole sphere-product family, balanced and unbalanced.

**So the block's "slack by exactly $n/(n-2)$" is about the per-row family's positive row, not about the $\Pi$-bound**, and the two sit four lines apart under a heading naming the $\Pi$-bound. A reader taking the note at face value concludes the opposite of the truth. The consequence that matters is the one [post F34](../findings/fence-posts.md) states: a bound sharp on the equality family admits no lossy step, so any proof of Conjecture A routed through L107 must be exact at the balanced products, and it must additionally control $\lvert\lambda_{\min}\rvert$, which is where the route dies, padded $W_{\mathbb{CP}^2}$ giving $(n-1)\lvert\lambda_{\min}\rvert=4.49$ against $\theta=1.2247$ at $n=12$.

*One disagreement with [r337](REVIEW_r337.md), on remediation rather than on mathematics.* Its owed-fix 2 asks [bounds.md](../findings/bounds.md) to strike "the $\Pi$-bound at the $\lambda_{\max}$ row". **That sentence is true** (the block's own derivation is the $\arg\max$ row of (B) and (C)) and r337's own text says so ("the $\Pi$-bound keeps (B) but replaces $Y$ by the relaxation $Y\le X^2$"). What is false is the *separate* identification of the per-row family's positive half with the $\Pi$-bound, which r337 and [r338](REVIEW_r338.md) both refute correctly. **Applying the fix as written would delete a correct statement**; the repair is to distinguish the two sentences, not to strike the first.

## D8, the withdrawn STEP 2 does not reach the derivation

The retraction inside the block ("STEP 2 WAS WRONG BOTH TIMES, AND NEITHER EXTREME IS OPTIMAL IN GENERAL"), is about which row minimises the **per-row family** $\theta\le\lambda_a+(n-2)M_a/\lambda_a$, and it is correct: $f(x)=x+c/x$ decreases only on $(0,\sqrt c)$, and the product criterion $\lambda_{\max}\lambda_{(2)}\le(n-2)M$ replaces it.

**L107's chain is untouched.** Its display is asserted for every $a$; the derivation instantiates it at $a=\arg\max$ and asks nothing about whether that row is the strongest. Optimality is a claim about the *minimum over rows*, which L107 never takes. **CONFIRMED clean**, and owed: one clause in the block saying so, because the retraction is printed under L107's heading and reads as a caveat on the lemma above it.

## D9, the derivations reconstruct a value they had already seen

From the repository history, all on 2026-09-01:

| time | event |
| --- | --- |
| 15:26 | [post F40](../findings/fence-posts.md) names $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ as "the record's own $\lambda$-weighted bound … a fact the record held before this cycle began" |
| 20:38 | the LP over $D$'s raw material returns "**exactly** $\theta\le(n-1)\lvert\lambda_{\min}\rvert$" ([bounds.md](../findings/bounds.md) line 432) |
| 22:14 | the $m_2$ elimination is written, "collapsing exactly to the $\Pi$-bound" |
| 22:41 | the one-line $g$ argument is written |
| 23:11 | the row-calculus derivation now in L107's block is written |

**All three derivations post-date both the value and the LP that returned it.** None predicted it. The moment-problem block's own register is right ("which is mildly interesting; what matters is why the collapse was forced") and the heading's "derived twice" is the part that reads as evidential weight the chronology does not support.

## D10, the shortest derivation on the record describes a step that does not work

[bounds.md](../findings/bounds.md) line 301: "*use $\lambda_k\le\lambda_{\max}$ termwise in $\sum_k\lambda_kg_k=-4\theta$ against $g_k\ge0$. Splitting at the sign of $\lambda_k$ and bounding the positive part by $\lambda_{\max}$ and the negative by $\lambda_{\min}$ gives $-4\theta\ge\lambda_{\min}\sum_kg_k$*".

Bounding the positive part **above** by $\lambda_{\max}$ yields an upper bound on $\sum_k\lambda_kg_k$ and cannot contribute to the displayed lower bound; and $\lambda_k\le\lambda_{\max}$ is the wrong direction throughout. The step that works is the single inequality $\lambda_k\ge\lambda_{\min}$ for every $k$ against $g_k\ge0$, with no splitting at all. **The displayed conclusion is correct and its stated route is not**, in the one place on the record where the whole argument is a single line.

## D11, REPAIR: the row index is excluded from the support, and using that strengthens the lemma for free

$T$ vanishes on repeated indices, so in row $a$ the variable $X=\tfrac{\lambda_b+\lambda_c}2$ ranges over means of two **distinct** eigenvalues **indexed away from $a$**. Its exact range is $[\ell_a,\sigma_a]$ with

$$\ell_a=\tfrac12\big(\lambda_{(1)}+\lambda_{(2)}\big),\qquad \sigma_a=\tfrac12\big(\lambda^{(1)}+\lambda^{(2)}\big),$$

the means of the two smallest and the two largest eigenvalues over indices $\ne a$. The chord over the true range is valid, and running steps 1–5 with it gives, at $a=\arg\max$,

$$\boxed{\ \theta\ \le\ \lambda_{\max}-\ell_a-\sigma_a-\frac{(n-2)\,\ell_a\sigma_a}{\lambda_{\max}}\ }$$

**It dominates L107 unconditionally.** For nested intervals $[\ell_a,\sigma_a]\subseteq[\lambda_{\min},\lambda_{\max}]$ the difference of the two chords is affine and non-negative at both endpoints of the smaller interval (each endpoint value is $c_{[\lambda_{\min},\lambda_{\max}]}(X)-X^2\ge0$), hence non-negative throughout, and $X$ lives in the smaller interval. Dividing by $\lambda_{\max}>0$ preserves the order. Setting $\ell_a=\lambda_{\min}$, $\sigma_a=\lambda_{\max}$ recovers $(n-1)\lvert\lambda_{\min}\rvert$ identically, so it is a strict extension.

**Where it is free and where it bites**, all by hand:

- **Balanced product**: $\lambda_{\min}$ has multiplicity $n^2/4$ and $\lambda_{\max}$ multiplicity $n(n-2)/4$, so $\ell_a=\lambda_{\min}$, $\sigma_a=\lambda_{\max}$ and the sharpening adds nothing. **Consistent with L107 being an equality there**, a sharpening that moved would have refuted D7.
- **$S^2\times S^{n-2}$**, mixed-block units, $a$ the one-dimensional $\Lambda^2V_2$: $\sigma_a=2/(n-3)$, $\ell_a=-1$, and the bound reads $(n-2)+1-\tfrac2{n-3}+\tfrac{2}{n-3}=n-1=\theta$ **exactly**.
- **Padded $W_{\mathbb{CP}^2}$**, spectrum $(2\varepsilon,-\varepsilon,-\varepsilon,0,\dots)$, $\varepsilon=1/\sqrt6$, $a=\arg\max$: the remaining spectrum is $\{-\varepsilon,-\varepsilon,0^{\times}\}$, so $\ell_a=-\varepsilon$, $\sigma_a=0$ and the bound reads $2\varepsilon+\varepsilon-0-0=3\varepsilon=\sqrt{3/2}$, **exactly $\theta$, at every $n$**, against L107's $(n-1)\varepsilon$. **L107 is slack by $(n-1)/3$ there**, $4.490731$ against $1.224745$ at $n=12$.

The third case is [r337](REVIEW_r337.md)'s two-moment hull answer at padded $W_{\mathbb{CP}^2}$, "$\theta\le3\varepsilon=\sqrt{3/2}$ exactly, for every $n$", which the block calls "what [I24](../plan.md) is now", **recovered by one chord with the right endpoints, needing no hull and no convex geometry.** The same exclusion is already applied on the record to [Lemma L73](../findings/bounds.md), whose free strengthening $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ is exactly this mechanism at one moment; it was never carried across to L107 or to [Lemma L70](../findings/bounds.md), where it applies verbatim at the $\arg\min$ row.

## Owed to the record

1. **[bounds.md](../findings/bounds.md), the L107 heading**, "derived twice" is wrong in both directions. Either move the elimination and the one-line argument into the block or say in the heading that the block carries the row-calculus derivation and the other two are at [Lemma L108](../findings/bounds.md).
2. **[bounds.md](../findings/bounds.md), the L107 block**, state $\mu_a$ and its two moments rather than writing "feeding in the two row moments", and name (B) as the source of the first. Two lines.
3. **[bounds.md](../findings/bounds.md), the L107 block**, add the sign discharge: $\operatorname{tr}_{\Lambda^2}W=0$ with $W\ne0$ gives $\lambda_{\max}>0>\lambda_{\min}$, so step 5's divisor is never an extra hypothesis.
4. **[bounds.md](../findings/bounds.md), the L107 block**, a clause saying the withdrawn STEP 2 is about the per-row family's optimal row and does not reach this derivation, which needs only that the display holds *at* $\arg\max$.
5. **[bounds.md](../findings/bounds.md) and [INDEX-results.md](../findings/INDEX-results.md)**, record the pointwise quantifier: $\lvert P(W)\rvert\le(n-1)\lVert\lambda\rVert_\infty$ at every unit $W\in\mathcal W_n$, with L107 the $\theta$-reading of it, and note that row 142's repaired form and L107 are the same inequality rather than two of the same shape.
6. **[bounds.md](../findings/bounds.md) line 245**, give $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$ as the definition and $2R_k-4\lambda_k(\theta-\lambda_k)$ as the critical-point rewriting. The present order is what hides item 5.
7. **[fence-posts.md](../findings/fence-posts.md), post F40**, $\Pi=4(n-1)\lvert\lambda_{\min}\rvert$ contradicts [post F28](../findings/bounds-relaxations.md)'s slack identity and its measured slack. Correct it to $\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$ and state L107 as the corollary through $\sum_{\mathfrak m}g\le4(n-1)$. [ELIM-bounds.md](ELIM-bounds.md) filed this and it was never applied.
8. **[bounds.md](../findings/bounds.md) line 301**, replace the sign-splitting sentence with the one inequality that produces the display, $\lambda_k\ge\lambda_{\min}$ against $g_k\ge0$.
9. **[bounds.md](../findings/bounds.md), the L107 block**, record that the $\Pi$-bound is **exact** at every $S^p\times S^q$, next to the "slack by $n/(n-2)$" note, which is about the per-row family. Both facts are [r337](REVIEW_r337.md)'s and only the second was folded in.
10. **[bounds.md](../findings/bounds.md)**, add D11's sharpened chord, and the same exclusion at [Lemma L70](../findings/bounds.md)'s $\arg\min$ row.
11. **[r337](REVIEW_r337.md)'s owed-fix 2**, narrow it before applying. "The $\Pi$-bound at the $\lambda_{\max}$ row" is true; the false sentence is the identification with the per-row family's positive half.
