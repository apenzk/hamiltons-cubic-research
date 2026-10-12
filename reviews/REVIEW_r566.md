# REVIEW_r566, Lemma L70, the deficiency identity and what saturates it

**Reviewer** r566, independent adversarial audit on a cold brief. **Subject** [Lemma L70, the deficiency identity, and what saturates it](../findings/bounds.md), at [bounds.md](../findings/bounds.md) lines 185–207, with its canonical statement at [results.md](../results.md) line 560. **Footing** analysis only. **No computation was run**: every check below is by hand from the definitions in [conventions.md](../findings/conventions.md), and where I cite a number measured by another reviewer I say whose it is and treat it as corroboration rather than as ground.

## Verdict in one line

**CONFIRMED overall, with two REFUTED sentences and one theorem the block is owed.** The boxed identity, its nonnegativity, its equality characterisation and the Lie-theoretic reduction on [Lemma L23](../findings/ungraded-slack.md)'s family all rebuild cleanly. What fails is the block's newest paragraph (the excluded-index blockquote added after the Gate 2 pair ran), whose opening sentence is false whenever $\dim E_{\min}\ge2$ and is contradicted by its own third sentence, and which has been copied verbatim into [results.md](../results.md). Separately, one consumer of L70 cites a saturation that cannot occur.

| # | defect | verdict |
| --- | --- | --- |
| D1 | the excluded-index blockquote's opening sentence, unconditional | **REFUTED**, repair below |
| D2 | "the boxed form is the **weakened** member", unconditional | **REFUTED**, same cause |
| D3 | "which covers every saturating point on this record", a population claim where a proof is available | **REPAIRED** by the theorem of §4 |
| D4 | "*What the identity does **not** need*: unit norm" | **REFUTED** under [conventions.md](../findings/conventions.md)'s own $\theta$ |
| D5 | hypothesis written $\lambda_{\min}<0\le\lambda_{\max}$ where the equality case needs $\lambda_{\max}>0$ | **REPAIRED** |
| D6 | the fixed mass $\sum c_{vab}^2=2(n-2)$ used with no number and no back-link | **CONFIRMED as a gap** |
| D7 | [nondegeneracy.md](../findings/nondegeneracy.md) line 540, $W_{\mathbb{CP}^m}$ "saturates Lemma L70 exactly" | **REFUTED for $m\ge3$**, and its link is broken |
| D8 | the block's reading of [post F40](../findings/fence-posts.md)'s correction (i) | **flagged**: attached to the wrong bound |
|, | the identity, the equality case, the every-$v$ quantifier, the L23 reduction | **CONFIRMED** |

## 1. Does the block state its heading's claim, and is the argument present?

**Yes to the claim; the argument is present but thirty lines away and uncited.** The heading promises the identity and what saturates it; the body delivers the boxed identity, the equality characterisation, the reduction on the two-eigenvalue family, and a table.

**The derivation is not in the block.** Its opening sentence, *"The bound replaces every product $\lambda_a\lambda_b$ by its minimum $\lambda_{\min}\lambda_{\max}$ over the spectrum and spends the fixed mass $\sum c_{vab}^2=2(n-2)$"*, names two ingredients and cites neither. Both sit at [bounds.md](../findings/bounds.md) line 159, under the unnumbered heading *"The walk identity at the $\lambda_{\min}$ eigenvector"*, in the display
$$\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,c_{1ab}^2,\qquad\sum_{a,b}c_{1ab}^2=-\operatorname{tr}(\mathrm{ad}\,v)^2=2(n-2).$$
That is the same pattern the record has been catching all session: the block's dependency is in its own file, unlinked. **Repair**: L70's first sentence should link to that display.

## 2. Rebuilding the identity from the definitions

Criticality is $Q(W)=W^2+W^\#=\theta W$. Pair against a unit $v\in E_{\min}$:
$$\lambda_{\min}^2+\langle v,W^\#v\rangle=\theta\lambda_{\min}.$$
Expand $\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_bc_{vab}^2$ over an orthonormal eigenbasis, and split off the constant against the fixed mass:
$$\tfrac12\sum_{a,b}\lambda_a\lambda_bc_{vab}^2=D(v)+\tfrac12\lambda_{\min}\lambda_{\max}\!\!\sum_{a,b}c_{vab}^2=D(v)+(n-2)\lambda_{\min}\lambda_{\max}.$$
So $D(v)+(n-2)\lambda_{\min}\lambda_{\max}=\theta\lambda_{\min}-\lambda_{\min}^2$, and dividing by $\lambda_{\min}<0$ gives the boxed form exactly. **CONFIRMED.** The sums are over ordered pairs, which is [conventions.md](../findings/conventions.md)'s default and which the $\tfrac12$ in $D$'s definition matches.

**Which relation supplies the mass, and does it carry a number?** It is [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, which is relation (A) a hundred lines below in this same file, attributed there to [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 via $I\#I=(n-2)I$. **It carries no result number**: [INDEX-results.md](../findings/INDEX-results.md) has no row for it, while its companion the pair cap has [Lemma L31](../findings/stratum-two-negative.md). **D6.** L70 is load-bearing on an unnumbered fact, and the $2(n-2)$ that gives the bound its $n$-dependence is that fact.

**Nonnegativity.** For $\lambda_{\min}<0<\lambda_{\max}$ and any $\lambda_a,\lambda_b$ in the spectrum: like signs give $\lambda_a\lambda_b\ge0>\lambda_{\min}\lambda_{\max}$; opposite signs, say $\lambda_a<0<\lambda_b$, give $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_b\ge\lambda_{\min}\lambda_{\max}$. So $\lambda_{\min}\lambda_{\max}$ is the spectral minimum and $D\ge0$ termwise. **CONFIRMED.**

**Equality.** Both inequalities above are strict unless $\lambda_a=\lambda_{\min}$ and $\lambda_b=\lambda_{\max}$, so $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$ holds only on $E_{\min}\times E_{\max}$ and its transpose. Hence $D(v)=0$ iff $\mathrm{ad}(v)$ is supported there. **CONFIRMED.**

**D5.** That last step needs $\lambda_{\max}>0$ strictly, and the block writes the hypothesis as $\lambda_{\min}<0\le\lambda_{\max}$, as do [results.md](../results.md) lines 194 and 562. At $\lambda_{\max}=0$ the whole spectrum is non-positive, $\lambda_{\min}\lambda_{\max}=0$ is still the minimum, so $D\ge0$ survives, but the minimiser is every pair carrying a zero eigenvalue and the stated equality case is false. The hypothesis actually delivered is strict: $\operatorname{tr}W=0$ with $W\ne0$ forces $\lambda_{\min}<0<\lambda_{\max}$. **Repair**: write the strict form; it is what the trace gives and what the equality case needs.

## 3. D1, D2, the excluded-index blockquote

The blockquote opens: *"$\lambda_{\min}\lambda_{\max}$ is attained only on a pair containing the row index, which $c_{vab}$'s support excludes."*

**That is false whenever $\dim E_{\min}\ge2$.** Total antisymmetry kills $c_{vab}$ only when $a$ or $b$ is $v$ itself. It does not touch a pair $(a,b)$ with $\varphi_a\in E_{\min}$, $\varphi_a\ne v$, and $\varphi_b\in E_{\max}$, and such a pair attains $\lambda_{\min}\lambda_{\max}$. The universally valid sharpening subtracts $m_1=\min\{\lambda_a\lambda_b: a\ne b,\ a,b\ne v\}$, and
$$m_1=\lambda_{\min}\lambda_{\max}\quad\text{exactly when }\dim E_{\min}\ge2 .$$
So the sharp and weak forms coincide there, and **D2** follows: the boxed form is the weakened member of the per-row family *only* when $\lambda_{\min}$ is simple. Both sentences are stated unconditionally and are contradicted two sentences later by the blockquote's own *"The two agree whenever $\lambda_{\min}$ has multiplicity $\ge2$."* **REFUTED as written.**

**Direction of the looseness, since the brief asks.** The looseness is in the inequality, never in the identity, and it is conservative. With the sharp constant the same algebra gives
$$\theta=\lambda_{\min}-\frac{(n-2)m_1}{\lvert\lambda_{\min}\rvert}-\frac{D_1}{\lvert\lambda_{\min}\rvert},\qquad D_1=\tfrac12\sum_{a,b}(\lambda_a\lambda_b-m_1)c_{vab}^2\ge0,$$
and $m_1\ge\lambda_{\min}\lambda_{\max}$ makes the sharp bound $\theta\le\lambda_{\min}-(n-2)m_1/\lvert\lambda_{\min}\rvert$ no larger than the boxed one. So dropping $D\ge0$ throws away a piece of size $(n-2)(m_1-\lambda_{\min}\lambda_{\max})/\lvert\lambda_{\min}\rvert$: the boxed bound stays **valid and slack**, and the identity is untouched.

**Should the boxed form be restated over the true support, as [Lemma L107](../findings/bounds.md) was?** **No, and the reason is a theorem rather than a preference.** L107's chord sharpening bites at padded $W_{\mathbb{CP}^2}$ because the $\arg\max$ row's excluded index is the *unique* $\lambda_{\max}$ index, which collapses $\sigma_a$ from $2\varepsilon$ to $0$. L70's row index is a $\lambda_{\min}$ index, and §4 shows every point saturating the boxed form has $\dim E_{\min}\ge n/2$, so the excluded index is never the last one, $m_1=\lambda_{\min}\lambda_{\max}$, and the transplant is **identically void at every saturating point, at every $n$**. It has content only as a bound at points with simple $\lambda_{\min}$, where L70 is not used. The block's decision to flag rather than rewrite is right; the sentences justifying it are not.

**D3.** The blockquote defends the flag with *"which covers every saturating point on this record"*, a claim about the catalogued population, repeated verbatim in [results.md](../results.md) line 560. §4 replaces it with a proof that needs no population.

## 4. The theorem the block is owed, saturation forces two dimensions

> **Claim (r566).** Let $W$ be a critical point of $\mathcal W_n$ and let $v\in E_{\min}$ be a unit vector with $D(v)=0$. Then
> $$\dim E_{\min}\ \ge\ \frac n2,\qquad \dim E_{\max}\ \ge\ \frac{n-2}2 .$$

*Proof.* Choose an orthonormal eigenbasis of $\Lambda^2\mathbb R^n$ containing $v$. Saturation puts the whole mass on the allowed set, so
$$2(n-2)=\sum_{a,b}c_{vab}^2=2\!\!\sum_{a\in E_{\min}}\sum_{b\in E_{\max}}\!\!c_{vab}^2 ,$$
the factor $2$ being the two orders. Total antisymmetry gives $c_{vab}=\langle[\varphi_b,v],\varphi_a\rangle$, so for fixed $b$, $\sum_ac_{vab}^2=\lVert[\varphi_b,v]\rVert^2\le2$ by the pair cap ([Lemma L31](../findings/stratum-two-negative.md), quoted in [conventions.md](../findings/conventions.md)); summing over $b\in E_{\max}$ bounds the double sum by $2\dim E_{\max}$, whence $2(n-2)\le4\dim E_{\max}$. Reading the same double sum along the other index, $\sum_bc_{vab}^2=\lVert[v,\varphi_a]\rVert^2\le2$ for each $a\in E_{\min}$, and the term $\varphi_a=v$ contributes $0$; summing over the remaining $\dim E_{\min}-1$ indices bounds it by $2(\dim E_{\min}-1)$, whence $2(n-2)\le4(\dim E_{\min}-1)$. $\square$

**Three consequences, and one check that the bound is not slack.**

- **$\dim E_{\min}\ge2$ for every $n\ge4$**, so the sharp and weak equality cases of §3 agree at every saturating point, on this record or off it. That is D3's repair.
- **A saturating point with $\dim E_{\max}=1$ exists only at $n=4$**, where $(n-2)/2=1$.
- **Both inequalities are attained**, at [Reviewer 324](REVIEW_r324.md)'s $n=4$ witness $W_{\mathbb{CP}^2}$: spectrum $(2,-1,-1,0,0,0)/\sqrt6$ gives $\dim E_{\min}=2=n/2$ and $\dim E_{\max}=1=(n-2)/2$, exactly. At the balanced products $\dim E_{\min}=n^2/4$ and $\dim E_{\max}=n(n-2)/4$ clear both comfortably.

The claim uses the pair cap and the Killing marginal and nothing else, no criticality beyond what puts $v$ in $E_{\min}$, no spectrum, no Lie theory. It excludes without a search every critical point whose $\lambda_{\min}$ or $\lambda_{\max}$ multiplicity is too small, which is a large part of what [r323](REVIEW_r323.md)'s and [r324](REVIEW_r324.md)'s hunts spent computation on.

## 5. D4, "the identity does not need unit norm" is false in the record's own $\theta$

The block ends its blockquote with *"What the identity does **not** need: unit norm, Weyl membership, $\theta>0$, or $n\ge5$."* [conventions.md](../findings/conventions.md) defines $\theta=P(W)/\lVert W\rVert^3$, adding *"at a critical point, $Q(W)=\theta W$"*, and those two agree only at $\lVert W\rVert=1$. For $Q(W)=\mu W$ at general norm, $P(W)=\mu\lVert W\rVert^2$, so $\theta=\mu/\lVert W\rVert$: **$\theta$ is scale-invariant while the criticality eigenvalue is degree one.**

The identity's right-hand side is degree one in $W$. Replace a unit critical $W$ by $2W$: the right-hand side doubles, and $\theta$ does not. So the boxed identity **fails at every $\lVert W\rVert\ne1$ under the record's definition of $\theta$**, and holds under the eigenvalue reading. **REFUTED as written.** Repair: either restore $\lVert W\rVert=1$ to the hypothesis list, or say that $\theta$ in the box is the criticality eigenvalue.

**This is not a defect the Gate 2 pair caught, both propagated it.** [r323](REVIEW_r323.md)'s hypothesis table records unit norm as *"no, both sides are homogeneous of degree $1$ in $W$"*, and [r324](REVIEW_r324.md)'s the same with a measured residual at $\lVert W\rVert=2.7$. Both are right about the eigenvalue and both read past the convention. The consequence is small (every consumer works at unit norm) and it is exactly the class of collision [conventions.md](../findings/conventions.md) exists to table.

## 6. The quantifier, and whether criticality is needed

**Criticality is genuinely needed, and there is no L107-style understatement here.** The step that brings $\theta$ in is $\lambda_{\min}^2+\langle v,W^\#v\rangle=\theta\lambda_{\min}$, which is criticality read at $v$. The criticality-free core is $\langle v,W^\#v\rangle=D(v)+(n-2)\lambda_{\min}\lambda_{\max}$, and the block says so. L107's $g$-route has no analogue at the $\lambda_{\min}$ row, since relation (B) fixes a first moment and not $\theta$. **CONFIRMED as stated.**

**"Every unit $v\in E_{\min}$" is a consequence, not a hypothesis, and the block's proof of that is stronger than its presentation.** At a critical point $W^\#=\theta W-W^2$ is a polynomial in $W$, so $W^\#$ acts on $E_{\min}$ by the scalar $\theta\lambda_{\min}-\lambda_{\min}^2$ and $D$ is constant on the unit sphere of $E_{\min}$. **That is algebra and needs no verification**; the block hedges it with *"verified to $4\times10^{-16}$"*, which reads as though the constancy were measured. **Recommend** the numerics be labelled as a check on an identity rather than as its ground.

**One open the block does not raise.** Whether the *bound* $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ survives off criticality on $\mathcal W_n$ is unsettled by either Gate 2 report: [r324](REVIEW_r324.md)'s negative-slack witnesses are the unbalanced splits, which its own §5.4 shows are not Weyl tensors at all, and [r323](REVIEW_r323.md) reports an identity *gap* at non-critical $W\in\mathcal W_6$ rather than the bound's sign. Settling it needs a construction I have no approval to run. It threatens nothing, since L70 states criticality; it is a completeness note.

## 7. The Lie-theoretic reduction on Lemma L23's family

**CONFIRMED, and "no computation" is accurate.** On $W=\Pi_{\mathfrak h}-\tfrac rNI$ the two eigenvalues are $c(1-r/N)>0$ on $\mathfrak h$ and $-cr/N<0$ on $\mathfrak m$, so $E_{\max}=\mathfrak h$ and $E_{\min}=\mathfrak m$ once $\theta>0$ fixes $c>0$, which [conventions.md](../findings/conventions.md)'s normalisation rule supplies and the block leaves silent. The support then has three blocks. The $\mathfrak h\times\mathfrak h$ block vanishes because $c_{vab}=\langle[\varphi_a,\varphi_b],v\rangle$, $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ and $v\in\mathfrak m\perp\mathfrak h$, one line, no computation. The $\mathfrak h\times\mathfrak m$ block is the allowed set. So $D=0$ iff the $\mathfrak m\times\mathfrak m$ block vanishes.

**The quantifier is where the care is needed, and the block is covered.** Vanishing for a single $v$ gives only $v\perp[\mathfrak m,\mathfrak m]$; the step to $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, hence to a symmetric pair, needs it for every $v\in\mathfrak m$. The constancy of §6 supplies exactly that, so the reduction is sound, but the block states it without invoking the constancy, and the constancy lives twenty lines further down under a different heading. **Recommend** the reduction cite it, as [r323](REVIEW_r323.md) also asked.

The closing step, that the balanced split is the only critical symmetric pair, $\mathfrak u(m)$ overshooting by $m$, is [Lemma L23](../findings/ungraded-slack.md)'s, and L23's block handles the $n=8$ triality members $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ explicitly at $r=21,13$ against the cap $12$. The citation is inside its source's hypotheses.

## 8. What is proved and what is measured

**The table is measurement, and two sentences around it read as more.**

- **Proved**: the identity, $D\ge0$, the equality characterisation, the reduction to a symmetric pair on the two-eigenvalue family, the constancy on $E_{\min}$, and, via [Lemma L23](../findings/ungraded-slack.md), that the balanced products are the family's only saturating members. The separation of the balanced products from the rest of the *subalgebra family* is therefore a **theorem**, not a reading of the table.
- **Measured at $n=6,8,10,12$**: the criticality residuals, the slacks $1.291,2.160,2.846,3.425$ and $0.836660$, the off-block mass fractions $\tfrac{m-2}{m-1}$, and the counts $0$ of $72,192,400,720$.
- **Neither**: *"with the slack growing in $n$"* is an extrapolation from four points and should read as an Observation at $n=6,8,10,12$. **No downgrade of the lemma is owed** (the separation it claims is proved by other means) so nothing becomes owed by relabelling that clause.

## 9. What cites L70, and whether the use is inside its hypotheses

Grepping the statement rather than the identifier turns up nine consumers. Seven are inside hypotheses: [Lemma L71](../findings/bounds.md) (hypothesis "critical, saturating, $n\ge5$"); [diagonal-half.md](../findings/diagonal-half.md) line 451 (the spectral ratio $n/(n-2)$, which is [r323](REVIEW_r323.md)'s characterisation); [bounds.md](../findings/bounds.md) lines 365, 383, 385, 430 and 493; [bounds-relaxations.md](../findings/bounds-relaxations.md) line 454. Two do not.

**D7, [nondegeneracy.md](../findings/nondegeneracy.md) line 540 is REFUTED.** It says of $e=W_{\mathbb{CP}^m}/\theta$, in a block running at $m\ge3$, that it *"saturates [Lemma L70](second-order.md) exactly"*. The block gives $e$ in closed form,
$$e=-\tfrac{1}{2m-1}P_{\mathfrak m}+\tfrac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\tfrac{2(m-1)}{2m-1}P_\omega ,$$
so for $m\ge2$ the three eigenvalues are $-\tfrac1{2m-1}<0\le\tfrac{m-2}{(m+1)(2m-1)}<\tfrac{2(m-1)}{2m-1}$, since $2(m-1)\ge2>1>\tfrac{m-2}{m+1}$. Hence $E_{\max}$ is the $\omega$ line and $\dim E_{\max}=1$. By §4 saturation requires $\dim E_{\max}\ge(n-2)/2=m-1$, which fails at every $m\ge3$. **So $W_{\mathbb{CP}^m}$ saturates L70 only at $m=2$**, where $n=4$ and $m-1=1$, and that is precisely [r324](REVIEW_r324.md)'s $n=4$ witness. The route is disjoint from the block's, which offers none; it agrees with [r323](REVIEW_r323.md)'s and [r324](REVIEW_r324.md)'s measured slacks $2.108185$, $3.944053$, $5.692100$ at $\mathbb{CP}^{3,4,5}$, taken here as corroboration.
*The same sentence links `[Lemma L70](second-order.md)`, and [second-order.md](../findings/second-order.md) contains no occurrence of L70; the lemma lives in [bounds.md](../findings/bounds.md).*

**A second broken citation.** [bounds.md](../findings/bounds.md) line 35 writes *"the record's standing uniform bound is $n-2$ ([Lemma L70](#))"*, an empty anchor. The arithmetic is sound: at $\lVert W\rVert=1$, $\theta<(n-2)\lambda_{\max}\le n-2$.

**D8, the F40 reading.** The block says *"[Post F40](../findings/fence-posts.md)'s correction (i) refuted 'saturated exactly at the balanced sphere products' **for the $\lambda$-weighted bound**"*. In [post F40](../findings/fence-posts.md) that quoted phrase occurs in the paragraph about the $\dim E_+$ form of Lemma L23's bound, and correction (i) attaches there. The $\lambda$-weighted bound is F40's separate object, and [bounds.md](../findings/bounds.md) line 180 says of it that it *"is tight at all sphere products alike"*, so the refuted claim was never made about it. **Misattribution, no consequence**: what L70 takes from F40 is the adversarial population (tori, $\mathrm{ad}(\mathfrak{su}(3))$, multi-block products) that its own saturation set excludes, and that population is the same either way.

**Brief item 6, settled.** [Post F40](../findings/fence-posts.md)'s refuted **closure claim** is a different sentence, the transfer of [post F28](../findings/INDEX-traps.md)'s equality case across two incompatible objects both written $\Pi$, refuted by [r563](REVIEW_r563.md) and [r564](REVIEW_r564.md). **L70 takes nothing from it.**

## 10. Is the r323/r324 round a Gate 2 on this block as it now stands?

**Yes for the block's mathematical core; no for its newest paragraph.**

- **Covered.** Their brief-local L1 (the identity), L2 (the every-$v$ quantifier), L3 (the saturation set and the L23 reduction) and L5 (the Hilbert–Schmidt twin) map one-to-one onto this block's four claims, and **both CONFIRMED all four independently**, each rebuilding $\mathfrak{so}(n)$, the structure constants and $\mathcal W_n$ from the definitions. Their L4 is route R14, not this lemma. The block has since absorbed their repairs and names them: the $\operatorname{tr}W=0$ hypothesis, the withdrawal of the "control" sentence, the "carries no new information" reading, the $W^\#$-polynomial constancy, and [r324](REVIEW_r324.md)'s scoping correction on the non-Weyl rows.
- **Not covered.** The *"AND THE SUBTRACTED CONSTANT IS THE WRONG ONE"* blockquote postdates them, it is the excluded-index effect from the [L107](../findings/bounds.md) session ([r563](REVIEW_r563.md), [r564](REVIEW_r564.md)), and neither reviewer saw it. It is where D1, D2 and D3 live. D4 they saw and both got wrong the same way.

**So [INDEX-results.md](../findings/INDEX-results.md) row 70's blank should be filled with a Gate 2 keyed to [r323](REVIEW_r323.md) and [r324](REVIEW_r324.md), carrying this round's caveat on the post-dating blockquote, rather than left blank or queued for a third pair.** [LEDGER.md](../findings/LEDGER.md)'s note that L70 "wants reading rather than bookkeeping" is right, and this is the reading.

## 11. Repairs, in the order they should be made

1. **Restrict D1 and D2 to $\dim E_{\min}=1$**, in the blockquote and in [results.md](../results.md) line 560, which carries the same two sentences unconditionally.
2. **Replace D3's population clause with §4's theorem**: saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$, so the sharp and weak equality cases agree at every saturating point at every $n$, and the excluded-index sharpening is void where L70 is used.
3. **Fix D4**, name $\theta$ as the criticality eigenvalue, or restore $\lVert W\rVert=1$.
4. **Fix D5**, the hypothesis is $\lambda_{\min}<0<\lambda_{\max}$, strict, and $\operatorname{tr}W=0$ with $W\ne0$ delivers it.
5. **Fix D7**, [nondegeneracy.md](../findings/nondegeneracy.md) line 540: the saturation holds at $m=2$ alone, and the link goes to [bounds.md](../findings/bounds.md).
6. **Close D6**, give the Killing marginal a number, or link L70's first sentence to [bounds.md](../findings/bounds.md) line 159 and to relation (A).
7. **Label the "slack growing in $n$" clause an Observation** at $n=6,8,10,12$, and the $W^\#$ constancy a proof rather than a measurement.
8. **Correct D8's attribution** and the empty anchor at [bounds.md](../findings/bounds.md) line 35.

## Overall

**CONFIRMED.** [Lemma L70](../findings/bounds.md) is true as its boxed display and its equality clause state it, at every critical point and every unit $v\in E_{\min}$, and the reduction on [Lemma L23](../findings/ungraded-slack.md)'s family is exact. Nothing downstream moves: [Lemma L71](../findings/bounds.md) and its consumers take the scalar hypothesis $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$, which §4 shows carries the dimension bounds for free. The defects are in the block's prose about its own sharpness, in one hypothesis word, and in one consumer that cites a saturation which §4 forbids.
