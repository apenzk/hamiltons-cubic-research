# REVIEW r564, Lemma L107, the $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$

Reviewer r564. Brief: audit Lemma L107 in [bounds.md](../findings/bounds.md), working from the definitions alone. Analysis-only footing: no computation beyond screening a claim about to be recorded.

Status: **complete**. Overall verdict: the inequality is CONFIRMED; the block around it is REPAIRED on eight counts, one of which (V6) refutes where the record says the lemma is closed.

## Log of verdicts

**Method.** Every derivation below was done by hand from [conventions.md](../findings/conventions.md) and the three row relations, before reading [REVIEW_r337.md](REVIEW_r337.md) and [REVIEW_r338.md](REVIEW_r338.md). No computation was run: the only arithmetic is closed-form algebra reproduced in the text, and the two git timestamp queries in V4, which read metadata rather than mathematics. The other reviewer's report on this brief was not opened.

| # | claim | verdict |
| --- | --- | --- |
| V1 | the inequality $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ at every critical point | **CONFIRMED**, by two routes, one of them not the block's |
| V2 | the two sign conditions the division needs | **REPAIRED**, both are automatic, and the block discharges neither |
| V3 | "derived twice", and "a second, independent derivation, sharing nothing" | **REFUTED AS STATED**, the block carries one derivation, the record carries three plus an LP, and the two analytic ones are one system contracted twice |
| V4 | the derivation predicted the value | **REFUTED**, it postdates the value by eight hours and the LP that reproduced it by two and a half |
| V5 | the equality case, and whether the bound is ever binding | **REPAIRED, and it is the block's most valuable missing fact**, equality is exactly $\mathop{\mathrm{supp}}(g)\subseteq E_{\min}$, attained at **every** Einstein $S^p\times S^q$, the balanced one included |
| V6 | [post F40](../findings/fence-posts.md)'s closure, which [LEDGER.md](../findings/LEDGER.md) cites as where L107 is closed | **REFUTED**, it transfers [post F28](../findings/bounds-relaxations.md)'s equality case to a different quantity; the record's own padded $W_{\mathbb{CP}^2}$ is the witness |
| V7 | $\Pi$, the symbol the lemma is named after | **UNDEFINED IN THE BLOCK**, and the letter carries **four** objects on the record, not the three [conventions.md](../findings/conventions.md) now tables |
| V8 | "the positive rows do not see the extremum at all", three paragraphs under a bound derived at $\arg\max$ that is exactly tight there | **REPAIRED**, true of the $M_a$ family, false of the row, and [r338](REVIEW_r338.md)'s repair for the same paragraph is filed and unapplied |
| V9 | the prose of the one-line derivation | **REFUTED**, it names the wrong inequality twice for a step that needs the opposite one |
| V10 | the in-file link at [bounds.md](../findings/bounds.md) line 11 | **REFUTED**, the anchor is dead; line 295's is the live one |

**Overall: CONFIRMED as an inequality, REPAIRED as a block.** The mathematics of $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ survives every attack I could mount and is provable in one line from data the record already holds. Everything the block says *about* that inequality, how many derivations there are, whether they are independent, which of them is in the block, where the bound binds, what $\Pi$ means, and where it is closed, needs correcting.

## V1, the inequality. CONFIRMED, twice

**The measure and the moment the block never names.** Row $a$ of (A) has total mass $\sum_{\beta\gamma}T_{a\beta\gamma}=2(n-2)$ and $T\ge0$, so $\mu_a:=T_{a\bullet\bullet}/2(n-2)$ is a probability measure on **ordered** pairs $(b,c)$, ordered by [conventions.md](../findings/conventions.md)'s standing rule, which is what makes the mass $2(n-2)$ rather than $n-2$. Since $T$ is symmetric in $b,c$, (B) gives $\mathbb E_{\mu_a}[\lambda_b]=\mathbb E_{\mu_a}[\lambda_c]=-2\lambda_a/2(n-2)$, hence

$$\mathbb E_{\mu_a}[X]=\frac{-\lambda_a}{n-2},\qquad X=\tfrac{\lambda_b+\lambda_c}2 .$$

**So the brief's question (1) answers yes, and the $(n-2)$ is (A)'s, not a miscount of (B)'s.** It is $-\lambda_a/(n-2)$ and never $-\lambda_a/(n-1)$: the denominator is the row mass $2(n-2)$ of the Killing marginal, and I re-derived that mass from the definition rather than from the record, $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{ad}_{v_\alpha}^2)$, which is minus the Killing form at $v_\alpha$, and [conventions.md](../findings/conventions.md)'s $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ with $\mathop{\mathrm{tr}}(v^2)=-2$ gives $2(n-2)$. The moment is stated at [bounds.md](../findings/bounds.md) line 315, **forty lines above the block that consumes it**, and the block states neither it nor $\mu_a$.

**The chain.** $Y\le X^2$ is AM–GM on reals; $(X-\lambda_{\min})(\lambda_{\max}-X)\ge0$ holds because $X$ is a mean of two eigenvalues, and rearranges to $X^2\le(\lambda_{\min}+\lambda_{\max})X-\lambda_{\min}\lambda_{\max}$. Taking $\mathbb E_{\mu_a}$ of both and multiplying by $n-2$ gives the block's display exactly, for every $a$ including $\lambda_a=0$, where it reads $0\le-(n-2)\lambda_{\min}\lambda_{\max}$.

**At $a=\arg\max$**, with $h=\lambda_{\max}$ and $m=\lvert\lambda_{\min}\rvert$, the left side is $h\theta-h^2$ and the right is $(m-h)h+(n-2)mh=-h^2+(n-1)mh$. The squares cancel, and dividing by $h$ leaves $\theta\le(n-1)m$. **The cancellation is exact and I confirm it.**

**And a route sharing no inequality step with it.** With $g_k:=\lVert[\mathrm{ad}(v_k),W]\rVert^2$, the two pinned moments $\sum_kg_k=4(n-1)$ and $\sum_k\lambda_kg_k=-4\theta$ hold; both are derivable from the same three relations, which is V3's point, but the *argument* through them is different. Since $g\ge0$ and $\lambda_k\ge\lambda_{\min}$ termwise,

$$-4\theta=\sum_k\lambda_kg_k\ \ge\ \lambda_{\min}\sum_kg_k=-4(n-1)m\ \Longrightarrow\ \theta\le(n-1)m .$$

I verified both moments rather than borrowing them: $\sum_kg_k=2\sum_{k\alpha\beta}\lambda_\alpha^2T_{k\alpha\beta}-4\theta\mathop{\mathrm{tr}}W+4\sum\lambda_k^2$, and total symmetry turns the first sum into $\sum_\alpha\lambda_\alpha^2\cdot2(n-2)=2(n-2)$ by (A), giving $4(n-2)+4=4(n-1)$; and $\sum_{k\alpha\beta}\lambda_k\lambda_\alpha^2T=\sum_\alpha\lambda_\alpha^2(-2\lambda_\alpha)=-2\mathop{\mathrm{tr}}W^3$ by (B), which cancels the $+4\mathop{\mathrm{tr}}W^3$ from (C) and leaves $-4\theta$.

## V2, the sign conditions. REPAIRED

The division needs $\lambda_{\max}>0$, and reading $-\lambda_{\min}$ as $\lvert\lambda_{\min}\rvert$ needs $\lambda_{\min}<0$. **Both are automatic and neither is discharged in the block.** $\mathop{\mathrm{tr}}W=0$ on $\Lambda^2$ ([conventions.md](../findings/conventions.md), $\sum\mu=0$) and $W\ne0$ force $\lambda_{\max}>0>\lambda_{\min}$ strictly, so the answer to the brief's question (2) is that they hold at every $W$ the bound is ever applied to. The discharge exists on the record only in [REVIEW_r350.md](REVIEW_r350.md); the block asserts "$\lambda_{\max}>0$" as though it were a hypothesis and never says where it comes from.

**Quantifier and norm.** The bound holds at every critical point of $P$ on the unit sphere of $\mathcal W_n$, at every $n\ge4$, with no sign, gradedness, kernel or multiplicity hypothesis. It needs (C), so it does not extend off the critical set, [bounds.md](../findings/bounds.md)'s own box says so, and every use I checked respects it. It is **homogeneous of degree one on both sides**, so it is free of [conventions.md](../findings/conventions.md)'s $\sqrt2$ normalisation trap: rescaling $W$ scales $\theta$ and $\lambda_{\min}$ together. The one place normalisation could enter is the ratio between (A)'s $2(n-2)$ and (B)'s $-2\lambda_k$, and that ratio is invariant because both scale with $T$.

## V3, "derived twice", and independence. REFUTED AS STATED

**The block carries one derivation.** The heading announces two. The second and third live at [bounds.md](../findings/bounds.md) lines 295–303, forty-five lines earlier, under the heading *The moment problem for $g$*, the moment elimination, and the one-line $g$ argument I reproduced in V1. Line 295 points *forward* to L107 as their "home"; **the block points back at nothing**, so a reader arriving at the heading finds half of what it promises. A fourth reading, the LP at line 432, "returns exactly $\theta\le(n-1)\lvert\lambda_{\min}\rvert$". So the count is one in the block and four on the record.

**And "sharing nothing" is false of the inputs.** Line 301 calls the $g$ argument "a second derivation, sharing nothing with the elimination above", and line 303 calls it "a second, independent derivation of the $\Pi$-bound". Substituting (C) into the record's own $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$ and using the $\alpha\leftrightarrow\beta$ symmetry of $T$,

$$g_k=2\sum_{\alpha\beta}\big(\lambda_\alpha^2-\lambda_\alpha\lambda_\beta\big)T_{k\alpha\beta}=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2\,T_{k\alpha\beta},$$

**so $g\ge0$ is $T\ge0$, and the two pinned $g$-moments are (A) and (B)-with-(C), summed over rows.** The $g$-route is the same system as the block's row calculus, contracted over all rows instead of read at one. The two arguments differ in their inequality steps (chord plus AM–GM at one row, against $\lambda_k\ge\lambda_{\min}$ termwise) and that is worth saying; what is not true is that they share nothing. *This is the record's own line 369 ("both of this record's standing spectral bounds are one system read twice"), applying inside L107 itself, which the block does not notice.*

## V4, the derivation reconstructs a value it had already seen. REFUTED

The brief asked whether the analytic argument was written after the LP returned the number. It was, and after two other things as well. All four commits are 2026-09-01:

| time | commit | what it added |
| --- | --- | --- |
| 15:06 | 70bd6e16 | $(n-1)\lvert\lambda_{\min}\rvert$ first appears anywhere on the record, in [fence-posts.md](../findings/fence-posts.md) |
| 20:38 | 8d85c17e | the LP over $D$'s raw material "returns **exactly**" that bound |
| 22:41 | c5f9eb18 | the one-line $g$ derivation, committed as "sharing nothing with the first" |
| 23:11 | 0d6af7ef | the row-calculus derivation, which is the block's body |

**So the block's derivation is a reconstruction of a known value, not a prediction of an unknown one.** It is no less valid for that, and the LP is not one of its inputs; but "derived twice" reads as corroboration from two directions, and what happened is that a number found one way was re-reached three more times over eight hours.

## V5, the equality case, and whether the bound ever binds. REPAIRED, this is the block's largest omission

**The block states no equality case.** From the $g$ route the criterion is immediate and exact: equality in $\sum_k\lambda_kg_k\ge\lambda_{\min}\sum_kg_k$ holds iff $g_k=0$ whenever $\lambda_k\ne\lambda_{\min}$, so

$$\theta=(n-1)\lvert\lambda_{\min}\rvert\iff \mathop{\mathrm{supp}}(g)\subseteq E_{\min}\iff\text{every eigendirection outside }E_{\min}\text{ is an infinitesimal symmetry of }W .$$

**Answering the brief's question (4): the bound is not slack at the extremum, it is attained there, exactly.** At the balanced product the block itself records $\lambda_{\max}=h$, $\lambda_{\min}=-m$, $h/m=n/(n-2)$; the block eigenvalues it quotes for $S^p\times S^q$ give multiplicities $\tfrac{n(n-2)}4$ at $h$ and $\tfrac{n^2}4$ at $-m$, so $\sum\lambda^2=\tfrac{n^2m^2(n-1)}{2(n-2)}=1$ fixes $m=\tfrac1n\sqrt{2(n-2)/(n-1)}$ and

$$(n-1)m=\frac1n\sqrt{2(n-1)(n-2)}=\theta_0(n)\quad\textbf{exactly}.$$

**And it is attained on the whole Einstein sphere-product family, by a mechanism the record already owns.** At $S^p\times S^q$ the isotropy $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is exactly $\Lambda^2V_p\oplus\Lambda^2V_q$ and acts by symmetries, so $g$ vanishes there; the block's own quoted spectrum makes those two blocks positive and the mixed block $\lambda_{\min}$, and $W$ has no kernel; so $\mathop{\mathrm{supp}}(g)$ is exactly $E_{\min}$ and **equality holds at every $S^p\times S^q$, balanced and unbalanced alike.** *[r337](REVIEW_r337.md) reaches the same corollary from its closed-form block spectrum, by a route sharing nothing with this one, and notes that the record records the balanced case only; I now find the record does not state even that.*

**What follows for the block, and for [I24](../plan.md).** A bound attained at the conjecture's own extremal family admits no lossy step in any proof of it, which is [post F34](../findings/fence-posts.md)'s shape; and a bound cited across the record as a source of the constant $n-1$ is, at the points that decide Conjecture A, exact rather than a ceiling. **That is the fact a reader most needs from this block and the one it does not carry.**

## V6, post F40's closure of L107. REFUTED, on the record's own witness

[LEDGER.md](../findings/LEDGER.md) says L107 is "closed at [post F40](../findings/fence-posts.md)", and F40 says: *"since $\sum_\gamma g_\gamma=4(n-1)$ identically on $\mathcal W_n$, $\Pi=4(n-1)\lvert\lambda_{\min}\rvert$, and $\Pi-4\theta\ge0$ is exactly it. **That route is closed** … and its equality case is already characterised there: the slack vanishes exactly when $\Delta=0$ **and** $g$ is carried by the $\lambda_{\min}$ eigenspace within $\mathfrak m$."*

**The equality case it imports belongs to a different quantity.** [Post F28](../findings/bounds-relaxations.md)'s $\Pi$ is $\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$ (its slack identity sums over $\mathfrak m$ and $\mathfrak p$ and never over $\ker W$) while F40's is $\lvert\lambda_{\min}\rvert\sum_\gamma g_\gamma$ over everything. They differ by $\lvert\lambda_{\min}\rvert\sum_{\ker W}g_\gamma$, and F28's condition places no constraint on that mass.

**Witness, and it is the record's own.** At padded $W_{\mathbb{CP}^2}$ the record states $\Delta=0$ and $g$ carried by $E_{\min}\cup\ker W$ ([bounds.md](../findings/bounds.md) line 286), so F28's equality case holds and $\Pi_{F28}=2\sqrt6=4\theta$ exactly ([bounds-relaxations.md](../findings/bounds-relaxations.md) line 43). L107 at the same point gives $(n-1)/\sqrt6$ against $\theta=\sqrt{3/2}$, at $n=12$, $4.490731$ against $1.224745$, **slack by a factor $(n-1)/3$, unbounded in $n$.** So L107's slack does *not* vanish where F40 says it does, and its correct equality case is V5's: $g$ supported on $E_{\min}$, which additionally forbids kernel mass.

*The consequence for the record is narrow and real*: L107 is a genuine inequality with a characterised equality case, **not** the tautology F28 closed. F28's "$\Pi/4=\theta$ identically wherever the problem is hard" is a statement about the $\mathfrak m$-restricted quantity, and inheriting it for L107 understates the lemma.

## V7, $\Pi$. Four objects, none of them defined in the block

The block never says what $\Pi$ is, and the name is the only thing tying it to the rest of the record. The letter carries:

1. the orthogonal projection onto $W^\perp$, [conventions.md](../findings/conventions.md), sense (i);
2. [post F40](../findings/fence-posts.md)'s scalar $4(n-1)\lvert\lambda_{\min}\rvert$;
3. [post F28](../findings/bounds-relaxations.md)'s scalar $\lvert\lambda_{\min}\rvert\sum_{\mathfrak m}g_\gamma$, equivalently [ATTEMPTS.md](../ATTEMPTS.md)'s $\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)$;
4. **$\Pi(\lambda)$, the feasible set of the pinned system at a fixed spectrum**, at [bounds-relaxations.md](../findings/bounds-relaxations.md) line 316, a convex set, not a scalar or a projection.

I reached (2) against (3) independently, by the padded-$W_{\mathbb{CP}^2}$ computation in V6, before seeing that [conventions.md](../findings/conventions.md) had gained a row saying the same during this audit. **That row tables three senses and misses the fourth**, and L107's own name resolves to sense (2) with sense (3)'s equality case attached, which is V6.

## V8, "the positive rows do not see the extremum at all". REPAIRED

Read strictly, the sentence is about the $\theta\le\lambda_a+(n-2)M_a/\lambda_a$ family, and of that family it is correct: [r338](REVIEW_r338.md) confirms both halves and I confirm the arithmetic, the positive row at the balanced product gives $(n-1)h=\theta_0\cdot n/(n-2)$.

**But it sits three paragraphs below a bound derived at $a=\arg\max$ that is exactly tight at that same point.** V5's $(n-1)m=\theta_0$ is read at a positive row. So the block asserts, without scoping, that the positive rows miss the extremum, while its own headline result is a positive row hitting it exactly. Two readers have now had to reconstruct this: [r337](REVIEW_r337.md)'s table gives $\Pi$ **(exact)** against the family's $n/(n-2)$ at the balanced product, and [r338](REVIEW_r338.md) derives the closed criterion, with $M_{\arg\max}=\lambda_{\min}^2$, the family's positive row beats $\Pi$ **iff** $\lvert\lambda_{\min}\rvert<\lambda_{\max}<(n-2)\lvert\lambda_{\min}\rvert$, tying at the endpoints, the upper one being L73's saturation locus.

**Both reviewers' repair for this paragraph is filed and unapplied.** [r338](REVIEW_r338.md)'s recommendation 1, strike the identification, state that neither relaxation dominates, record $\min(\text{row family},\Pi)$ as the standing bound, appears nowhere in [bounds.md](../findings/bounds.md); I grepped for the criterion and for a $\min$ of the two and found neither. The block absorbed r337's hull blockquote and r338's monotonicity retraction, and left the one recommendation that changes what the record's standing bound *is*.

*On the brief's question (5)*: the retraction **STEP 2 WAS WRONG BOTH TIMES** concerns which row of the $M_a$ family is strongest. **L107 does not depend on it.** Its derivation needs only that the displayed inequality holds *at* $a=\arg\max$, which it does for every $a$, and never that $\arg\max$ is the best row. The retraction is nonetheless filed inside L107's block, under a "STEP 2" that has no referent there, so it reads as a retraction of a step of L107, a placement error, not a mathematical one.

## V9, the prose of the one-line derivation names the wrong inequality, twice

[bounds.md](../findings/bounds.md) line 301: *"instead use $\lambda_k\le\lambda_{\max}$ termwise in $\sum_k\lambda_kg_k=-4\theta$ … Splitting at the sign of $\lambda_k$ and bounding the positive part by $\lambda_{\max}$ and the negative by $\lambda_{\min}$ gives $-4\theta\ge\lambda_{\min}\sum_kg_k$."*

The conclusion is a **lower** bound on $\sum\lambda_kg_k$, so the step is $\lambda_k\ge\lambda_{\min}$ termwise, uniformly in the sign of $\lambda_k$. Neither $\lambda_k\le\lambda_{\max}$ nor bounding the positive part above by $\lambda_{\max}$ can produce it; both point the other way, and no splitting at the sign is needed at all. **The argument is right and its description is wrong**, the shortest correct sentence is "$g\ge0$ and $\lambda_k\ge\lambda_{\min}$ termwise".

## V10, a dead anchor

[bounds.md](../findings/bounds.md) line 11 links L107 as `#lemma-l107--the-pi-bound-thetale-n-1lvertlambda_minrvert-derived-twice`; line 295 links it as `#lemma-l107--the-pi-bound-thetalen-1lvertlambda_minrvert-derived-twice`. The heading slugifies to the second. Line 11's link is dead, and it is the link in the file's withdrawal notice for [L142](../findings/bounds.md), which exists to send readers to L107.

## What cites L107, and whether the uses are inside its hypotheses

I grepped the statement rather than the identifier. Every use I found is at a critical point and therefore legitimate:

- **$M(n)\le n-1$ and $\sup\lvert P\rvert\le n-1$**, [r435](REVIEW_r435.md), [r439](REVIEW_r439.md), [r441](REVIEW_r441.md), [ATTEMPTS.md](../ATTEMPTS.md) lines 4134 and 4202, [second-order.md](../findings/second-order.md) line 961. The chain is $P$ odd, sphere compact, supremum attained at a critical point, then L107 with $\lvert\lambda_{\min}\rvert\le1$. Valid, and r439 and r441 both flag that the criticality link is the load-bearing one and that the item using it does not state it.
- **$\theta\le n-1$ as a standing fact in the $d=3$ classification**, [r362](REVIEW_r362.md), [r360](REVIEW_r360.md), [r347](REVIEW_r347.md), [r359](REVIEW_r359.md). All inside a critical-point setting.
- **"There is no second $\Pi$-bound"**, [ATTEMPTS.md](../ATTEMPTS.md) line 2945 and [bounds-relaxations.md](../findings/bounds-relaxations.md) line 454, both correctly observing that L107's derivation has no analogue at $\nu_2$ because the chord needs $\lambda_{\min}$ as the support endpoint. I confirm: replacing $\lambda_{\min}$ by $\nu_2$ needs $X\ge\nu_2$ on the row's support, which fails on any pair inside the bottom class.

**No use outside the hypotheses was found.** [INDEX-results.md](../findings/INDEX-results.md) row 107 carries no Gate 2 verdict, so this audit and its twin are the first on the lemma itself.

## Screens taken

**None.** Every number in this report is closed-form algebra reproduced above. The only tool calls beyond reading were two `git log -S` queries, which read commit metadata for V4.
