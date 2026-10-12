# Verifier v231, Lemma L42 (the sharp dual weight): the bound by weak duality, the binding triple, sharpness, Passage E's dual normalisation, Passage A's pointer, the Lean statement, and the boundary

The brief ([BRIEF_L42.md](BRIEF_L42.md)) was read cold. No numerical work was done, every value below is exact and derived by hand, and no scripts were written. Log: [agent_logs/verify-L42-v231.log](../agent_logs/verify-L42-v231.log).

| # | Claim | Verdict |
|---|---|---|
| S | The statement $3M(\lambda_P)\le h(s^2-u)$ for $k\ge3$ positive entries (Passages A, B, C) | CONFIRMED |
| 1 | Passage D's weak duality establishes the bound (dual, feasibility on every triple, summation) | CONFIRMED |
| 2 | The three largest entries are the binding triple, ties included | CONFIRMED |
| 3 | "The constant cannot be improved" (A, B, D) and "the constant is attained, so no better weight exists for this relaxation" (C) | CONFIRMED (as a constant factor, worst case over spectra) |
| 4 | Passage E: $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible exactly when $\mu$ is at least the triple's harmonic mean, so the binding value is $h$ | REFUTED AS STATED |
| 5 | Passage A's pointer lands on the argument | REFUTED |
| 6 | The Lean statement (Passage F) is the record's claim | CONFIRMED (statement only, it carries a sorry) |
| 7 | Boundary: $k=3$, all entries equal, ties, $k\le2$ | CONFIRMED |

**What the round should do:** keep L42 as proven by Passage D, and repoint Passage A at [stratum-two-negative.md:581](../findings/stratum-two-negative.md#L581) while striking or correcting Passage E's feasibility sentence, which sits under the heading the pointer names.

## 0. Conventions, fixed once

- $k\ge3$ is the number of entries of $\lambda_P$, every $\lambda_\alpha>0$. Triples $T=\{\alpha,\beta,\gamma\}$ and pairs $p=\{\alpha,\beta\}$ are sets of distinct indices. $w_T=\lambda_\alpha\lambda_\beta\lambda_\gamma$.
- Primal: $M=\max\sum_T t_Tw_T$ over $t\ge0$ with $\sum_{T\ni p}t_T\le2$ for every pair $p$. This is Passage A's $M$, since $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}=\sum_{T\ni\{\alpha,\beta\}}t_T$.
- $H_T=3/(\lambda_\alpha^{-1}+\lambda_\beta^{-1}+\lambda_\gamma^{-1})$. $\lambda_{(1)}\ge\lambda_{(2)}\ge\lambda_{(3)}$ are the three largest values counted with multiplicity, and $h=H(\lambda_{(1)},\lambda_{(2)},\lambda_{(3)})$.
- $e_2(T)=\lambda_\alpha\lambda_\beta+\lambda_\beta\lambda_\gamma+\lambda_\alpha\lambda_\gamma$, so $H_T=3w_T/e_2(T)$.
- $s=\sum\lambda$, $u=\sum\lambda^2$, $s^2-u=2\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta$.
- "The constant" is read as the coefficient $\kappa$ in $3M\le\kappa\,h(s^2-u)$, the lemma asserting $\kappa=1$ is valid and minimal. Section 3 checks the other readings.

**Quotation check.** Passages A (lines 536-545), D (lines 581-610) and E (lines 518-525) match [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) verbatim. Passages B and C match [results.md](../results.md) lines 182 and 633-637. Passage F matches [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean) lines 72-128 exactly, but that range stops mid-statement: the conclusion continues on line 129 as `* ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2) := by` and line 130 is `sorry`. As quoted in the brief the inequality would read $3\cdot\mathrm{objective}\le h$, which is false (at $k=3$, $\lambda\equiv1$, $t\equiv2$ it says $6\le1$). This is a defect of the brief's line range, and the file itself is correct. Item 4 refers to text "at the end of Passage D": that is the italic note on line 612, two lines past the quoted range, which I opened as a cited source neighbour.

**Working tree.** At commit time `verification/VERIFY_v232.md` was untracked and belongs to another verifier. I did not open it, stage it, or touch it.

## Hypothesis inventory

| Hypothesis | Where it comes from | Holds for the object? | Used by the proof? |
|---|---|---|---|
| $k\ge3$ | Statement (A: "at least three") | Assumed | Yes, so that $h$ exists. The bound's derivation otherwise never uses it |
| $\lambda_\alpha>0$ for all $\alpha$ | Statement ("positive eigenvalues") | Assumed | Yes: dividing the triple constraint by $w_T>0$, $z\ge0$, and the domain of the harmonic mean |
| $t\ge0$ | Primal definition | Part of $M$ | Yes, inside weak duality (multiplying the dual triple constraints by $t_T$) |
| Pair cap $\le2$ | Primal definition | Part of $M$ | Yes, inside weak duality |
| Weak duality: $t$ primal feasible, $z\ge0$ with $\sum_{p\subset T}z_p\ge w_T$ for every $T$ | Imported | $z_p=\tfrac h3\lambda_\alpha\lambda_\beta\ge0$ since $h>0$ and $\lambda>0$. Triple constraints checked in section 1 | Yes. Only weak duality is used, never strong duality |
| Harmonic mean increasing in each argument | Imported | On $(0,\infty)^3$, $\partial H/\partial x=3x^{-2}/(x^{-1}+y^{-1}+z^{-1})^2>0$ | Yes, for the binding triple |
| $\lambda_\gamma\le\min(\lambda_a,\lambda_b,\lambda_c)$ for $\gamma$ outside the top three | Meaning of "three largest" | By definition | Yes, implicitly in "so the binding triple is the three largest" (section 2) |
| Existence of the maximum $M$ | Implicit in "max" | The feasible set is nonempty ($t=0$) and compact ($0\le t_T\le2$ since each triple contains a pair), so the max exists | The bound holds for every feasible $t$ and needs no attainment. Sharpness exhibits a feasible $t$ meeting the upper bound, which is attainment directly |

**Used but unstated:** nothing substantive. Two routine steps are elided: the existence of the max (irrelevant to the bound) and the one-line exchange from monotonicity to the top three (section 2).

**Quantifier order and scope.** $M$ is a max over $t$ at fixed $\lambda_P$. $h$ is fixed by $\lambda_P$. The dual weight $c=h/3$ is chosen after $\lambda_P$, which weak duality allows because it is applied at a single $\lambda_P$. The feasibility threshold is $c\ge\max_TH_T/3$, a max over triples of the fixed list, and Passage D's "binding triple" is the argmax of that max. Sharpness is a statement over all $\lambda_P$ (and all $k\ge3$): $\sup 3M/(h(s^2-u))=1$, with the sup attained at every equal list. No quantifier is swapped.

## 1. The bound by weak duality (Passage D)

**The dual.** The primal is $\max\{\sum_Tw_Tt_T: \sum_{T\ni p}t_T\le2\ \forall p,\ t\ge0\}$, an LP in standard max form with constraint matrix the pair/triple incidence matrix and right side $2$. Its dual is $\min\{2\sum_pz_p:\sum_{p\subset T}z_p\ge w_T\ \forall T,\ z\ge0\}$. Passage D line 589 writes exactly this. Correct.

**Weak duality, link by link.** For primal-feasible $t$ and dual-feasible $z$:
$$\sum_Tt_Tw_T\ \le\ \sum_Tt_T\sum_{p\subset T}z_p\ =\ \sum_pz_p\sum_{T\ni p}t_T\ \le\ 2\sum_pz_p,$$
the first step using $t\ge0$ and the triple constraints, the middle an exchange of a finite double sum, the last $z\ge0$ and the pair caps. Passage D cites this as "weak duality" and does not write the chain. It is an imported textbook fact whose hypotheses are listed above and hold, so this is no finding.

**Feasibility on every triple, not only the top three.** With $z_{\alpha\beta}=c\lambda_\alpha\lambda_\beta$, the constraint on $T$ is $c\,e_2(T)\ge w_T$. Dividing by $w_T>0$ gives $c\sum_{\alpha\in T}\lambda_\alpha^{-1}\ge1$, that is $c\ge1/\sum_T\lambda^{-1}=H_T/3$. Passage D line 593 writes this, correctly. So $z$ is dual feasible iff $c\ge\max_TH_T/3$. Section 2 shows $\max_TH_T=h$, hence $c=h/3$ satisfies every triple constraint. Also $z\ge0$.

**The summation.** $2\sum_{\alpha<\beta}z_{\alpha\beta}=2\cdot\tfrac h3\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta=2\cdot\tfrac h3\cdot\tfrac{s^2-u}2=\tfrac h3(s^2-u)$. This matches line 599. Every feasible $t$ therefore has objective at most $\tfrac h3(s^2-u)$, so $M\le\tfrac h3(s^2-u)$ and $3M\le h(s^2-u)$.

**Verdict: CONFIRMED.** No finding: each link follows from the one above and from stated hypotheses.

## 2. The binding triple, ties included

Passage D line 595: *"The harmonic mean is increasing in each argument, so the binding triple is the **three largest positives** and $c=h/3$ is feasible."*

**What must hold:** $H_T\le h$ for every triple $T$. Let $\{a,b,c\}$ be any index set realising the three largest values. If $T\ne\{a,b,c\}$, some $\gamma\in T$ lies outside $\{a,b,c\}$ and some index $x\in\{a,b,c\}$ lies outside $T$. By the defining property of the top three, $\lambda_\gamma\le\lambda_x$. Replacing $\gamma$ by $x$ in $T$ keeps three distinct indices and, by monotonicity in that argument (and symmetry of $H$), does not decrease $H$. Each replacement enlarges $|T\cap\{a,b,c\}|$ by one, so at most three replacements reach $\{a,b,c\}$, and $H_T\le h$.

This exchange is the content of the record's "so", and uses only the imported monotonicity and the meaning of "three largest". The record writes the conclusion without the exchange. I read it as an elided one-line step rather than a missing argument, since both of its inputs are named in the sentence itself. The Lean file ([L42Statement.lean:53](../lean/HamiltonsCubic/Results/L42Statement.lean#L53)) lists "the exchange argument" among what its sorry covers, which is a statement about the formalisation.

**Ties.** If several index sets realise the top three, each has the same multiset of values: every such set $\{a,b,c\}$ has all other entries at most its minimum, which forces its sorted values to be $\lambda_{(1)},\lambda_{(2)},\lambda_{(3)}$. So $h$ is well defined, and the exchange above works for any choice. With all entries equal every triple binds, and the argument still gives $H_T\le h$ with equality.

**Verdict: CONFIRMED.**

## 3. Sharpness and what "the constant" is

**The record's witness (line 606), rederived.** Take $k\ge3$ entries equal to $\lambda>0$. Then $h=\lambda$, $s^2-u=k^2\lambda^2-k\lambda^2=k(k-1)\lambda^2$, and the bound reads $3M\le k(k-1)\lambda^3$. Put $t_T=2/(k-2)$ on every triple. A pair lies in exactly $k-2$ triples, so every pair marginal is $(k-2)\cdot\tfrac2{k-2}=2$, feasible. The objective is $\binom k3\cdot\tfrac2{k-2}\cdot\lambda^3=\tfrac{k(k-1)(k-2)}6\cdot\tfrac2{k-2}\lambda^3=\tfrac{k(k-1)}3\lambda^3$. Hence $3M\ge k(k-1)\lambda^3$, and with section 1, $3M=h(s^2-u)$. Every value checks.

**Reading 1, the coefficient.** If $3M\le\kappa\,h(s^2-u)$ held for all lists with some $\kappa<1$, the equal list would give $k(k-1)\lambda^3\le\kappa k(k-1)\lambda^3$, false. So $\kappa=1$ is minimal. This is what "the constant cannot be improved" (A, B, line 606) says under the only constant the statement contains, and it is established. Passage C's "the constant is attained" is true in the same sense (attained on the equal lists).

**Reading 2, the product-form dual weight.** Passage C continues "so no better weight exists for this relaxation". If "weight" is the dual weight $z=c\lambda_\alpha\lambda_\beta$, then $c=h/3$ is the least feasible $c$, since the top triple's constraint is $c\ge h/3$ exactly (section 1). True, though the reason is the binding computation rather than attainment.

**Reading 3, pointwise.** "No better weight" could be read as: no function $\varphi(\lambda_P)$ below $h$ at some list satisfies $3M\le\varphi(s^2-u)$ everywhere. That reading fails, recorded below as a withdrawn candidate, because the passage's own qualifier ("the constant is attained") points to reading 1.

**Verdict: CONFIRMED** in readings 1 and 2. The sharpness is worst case over spectra.

### 3.W Withdrawn candidate: "no better weight exists" read pointwise

1. **Locate.** [results.md:635](../results.md#L635): *"and the constant is attained, so no better weight exists for this relaxation."*
2. **Exhibit.** $k=4$, $\lambda_P=(L,1,1,1)$ with $L>1$. Write $A=t_{123}$, $B=t_{124}$, $C=t_{134}$, $D=t_{234}$ (index 1 carries $L$). Caps: $A+B,\ A+C,\ B+C\le2$ and $A+D,\ B+D,\ C+D\le2$. Objective $L(A+B+C)+D$. Summing the first three caps gives $x:=A+B+C\le3$. Summing the last three gives $x+3D\le6$. So the objective is at most $Lx+(6-x)/3=(L-\tfrac13)x+2\le3L+1$, and $A=B=C=D=1$ (all six caps equal to $2$) attains it: $M=3L+1$. On the other side $h=3/(L^{-1}+2)=3L/(2L+1)$, $s^2-u=(L+3)^2-(L^2+3)=6L+6$, so $h(s^2-u)=18L(L+1)/(2L+1)$ against $3M=(9L+3)$. Then $h(s^2-u)-3M=\tfrac{18L^2+18L-(9L+3)(2L+1)}{2L+1}=\tfrac{3(L-1)}{2L+1}>0$. At $L=2$: $3M=21$, $h(s^2-u)=108/5$, and the pointwise best weight is $3M/(s^2-u)=21/18=7/6<6/5=h$. So the bound is strict at $(2,1,1,1)$, and a weight below $h$ is valid there.
3. **Argue the opposite.** The sentence derives "no better weight" from "the constant is attained", and attainment on equal lists supports exactly reading 1 (the coefficient) and nothing pointwise. The title "the sharp dual weight" and Passage D's "product weight" support reading 2. Both readings are true. Withdrawn: the pointwise reading is not what the text claims. Recorded for the round only as an observation that "sharp" here means worst case, not attained at every spectrum.

## 4. Passage E's normalisation $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$

1. **Locate.** [stratum-two-negative.md:518-521](../findings/stratum-two-negative.md#L518): *"For a triple of positives the dual $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible exactly when $\mu$ is at least the triple's harmonic mean, so the binding value is $h$, the harmonic mean of the three largest positives, and $3M(\lambda_P)\le h\,(s^2-u)$."*
2. **Exhibit.** Here $c=\tfrac32\mu$. By section 1 the constraint on $T$ is $\tfrac32\mu\ge H_T/3$, that is $\mu\ge\tfrac29H_T$. Closed-form failure of "exactly when $\mu\ge H_T$": $k=3$, $\lambda=(1,1,1)$, $H_T=1$. The single triple constraint is $3\cdot\tfrac32\mu\ge1$, so $\mu=\tfrac14$ is feasible while $\tfrac14<1=H_T$. The conclusion does not follow along the sentence's route either: with $\mu=h$, $2\sum z=2\cdot\tfrac32h\cdot\tfrac{s^2-u}2=\tfrac32h(s^2-u)$, so weak duality gives $3M\le\tfrac92h(s^2-u)$, not $3M\le h(s^2-u)$.
3. **Argue the opposite.** Could E's dual carry another normalisation that makes $\mu\ge H_T$ exact? Feasibility is the triple constraint alone. With right side $w_T$ the threshold is $\tfrac29H_T$. With right side $3w_T$ (a dual of $3M$) it is $\tfrac23H_T$. No normalisation stated or implied in the file gives $H_T$. The final inequality in E is true, but the sentence presents it as a consequence of the wrong threshold. The candidate survives.

**Consistency with the file's own note (line 612).** The note states the threshold in this normalisation is $\mu\ge2/(3\sum\lambda^{-1})=\tfrac29H$, that the gloss "at least the harmonic mean of the triple" is wrong by the factor $\tfrac92$, that the earlier form $2/\sum\lambda^{-1}=\tfrac23H$ is also wrong, and that $\mu=h$ gives $3M\le\tfrac92h(s^2-u)$. I rederived each of these above and each is correct. So the file is consistent in its correction, but Passage E itself is unamended, closes with $\square$, and is the text Passage A's pointer names (section 5).

**Verdict: REFUTED AS STATED.** The inequality survives through Passage D. Passage E's feasibility sentence is false, and its route yields only a bound $\tfrac92$ times weaker.

## 5. Passage A's pointer

1. **Locate.** [stratum-two-negative.md:538](../findings/stratum-two-negative.md#L538): *"the argument is in this file under 'The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three nam'"*.
2. **Exhibit.** The heading of that name is line 468 ("...closed modulo three named items"). Its section runs to line 535, where the Lemma L42 block opens at the same level. Inside it the only L42 argument is Passage E (lines 518-525), refuted in section 4. The correct argument, Passage D, is at lines 581-610, under the level-2 heading at line 566, which is a different section. The heading text in the pointer is also truncated ("nam").
3. **Argue the opposite.** Charitably, a reader following the pointer reaches E, whose last clause states the true inequality, and could search onward to D. But the pointer asserts the argument is under that heading, and what is there is a wrong derivation. Line 567, the italic note under heading 566, itself says the L42 block "points at an argument it does not carry". Passage C's proof link goes to the whole file without an anchor, which does not rescue A. The candidate survives.

**Verdict: REFUTED.** The pointer lands on the superseded, erroneous argument. The fix is a repointing, and the mathematics is unaffected.

## 6. The Lean statement (Passage F)

Read against [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean), lines 75-130. I did not build the file (that would be a run).

- **Binders and types.** `k : ℕ` implicit. `t : Fin k → Fin k → Fin k → ℝ`, `lam : Fin k → ℝ`, `a b c : Fin k`. Hypotheses `3 ≤ k`, `∀ i, 0 < lam i`, `Feasible t`, `ThreeLargest lam a b c`. All real-valued, matching the record.
- **Direction and form.** `3 * objective t lam ≤ harmonicMean (lam a) (lam b) (lam c) * ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2)`. This is $3\sum_{\alpha<\beta<\gamma}t w\le h(s^2-u)$ for every feasible $t$. Since $M$ is the max of the objective over the feasible set, "for every feasible $t$" is equivalent to the bound on $M$. Direction correct.
- **objective.** Sums over $\alpha$, $\beta\in$ `Ioi α`, $\gamma\in$ `Ioi β`, so exactly the strictly ordered triples, each once. Matches.
- **Feasible and repeated indices.** `nonneg` on all ordered triples. `symm12` and `symm23` are the transpositions $(12)$ and $(23)$, which generate $S_3$, so $t$ is totally symmetric. `pairCap` for $\alpha\ne\beta$ sums $t\,\alpha\,\beta\,\gamma$ over $\gamma\notin\{\alpha,\beta\}$, which by symmetry is the unordered pair's marginal, imposed twice (as $(\alpha,\beta)$ and $(\beta,\alpha)$) with the same value. Entries with a repeated index ($t\,\alpha\,\alpha\,\gamma$, $t\,\alpha\,\alpha\,\alpha$) are constrained only by nonnegativity and symmetry, and they enter neither `objective` nor `pairCap`. So restricting a Lean-feasible $t$ to distinct triples gives a record-feasible $t$ with the same objective, and any record-feasible $t$ extends (by $0$ on repeated indices) to a Lean-feasible one. The two suprema coincide.
- **ThreeLargest.** Distinct $a,b,c$ with every other entry at most $\min(\lambda_a,\lambda_b,\lambda_c)$. By section 2 this pins the multiset of values, so `harmonicMean` of it is the record's $h$ under any tie-breaking.
- **harmonicMean.** $3/(x^{-1}+y^{-1}+z^{-1})$, matching the brief's definition. Positivity keeps the denominator nonzero.
- **hk.** Redundant given `ThreeLargest` (three distinct elements of `Fin k` force $k\ge3$), harmless.
- **What is not the claim.** The theorem body is `sorry`, so this is a statement check only. Sharpness is not typed (the file says so at line 57). `triple_constraint` (lines 102-104) states $xyz\le c(xy+yz+xz)$ from $H/3\le c$, which is correct since $H/3=xyz/e_2$.
- **Minor.** The module docstring (line 31) quotes the findings heading as "Hypothesis, previously unstated: at least three positives", while line 608 of the findings file reads "Hypothesis: at least three positives". The Lean quotation is not verbatim. The brief's truncation of Passage F is noted in section 0.

**Verdict: CONFIRMED (statement only).** The Lean statement is the record's bound, with no gap in binders, direction, types or the handling of repeated indices.

## 7. Boundary

- **$k=3$ exactly.** One triple, and each of its three pair caps reads $t\le2$, so $M=2w$. Then $3M=6\lambda_1\lambda_2\lambda_3$ and $h(s^2-u)=\tfrac{3w}{e_2}\cdot2e_2=6w$. Equality holds for **every** list at $k=3$, not only equal ones. The record's witness at $k=3$ is $t=2/(3-2)=2$, consistent.
- **All entries equal.** Section 3, equality for every $k\ge3$.
- **Ties among the largest.** Section 2, $h$ is well defined and the binding argument holds.
- **$k\le2$.** No triples exist, the objective is the empty sum, $M=0$, and there is no third largest entry, so $h$ is undefined. Passage D line 610 says exactly this, and the statement excludes the case. The clause "those cases are closed elsewhere" concerns results outside L42 and was not checked.
- **$k-2$ in the witness.** The denominator vanishes only at $k=2$, which is excluded.

**Verdict: CONFIRMED.**

## Gap between proven and stated or used

- **Proven:** $3M\le h(s^2-u)$ for every list of $k\ge3$ positive reals, and minimality of the coefficient $1$ (equality on equal lists and on every list at $k=3$).
- **Stated in A, B, C:** the same. No gap.
- **Stated in E:** a false feasibility threshold and a route that yields only $3M\le\tfrac92h(s^2-u)$ (section 4).
- **Out of scope, not checked:** Passage C's "the relaxation of the bracket tensor's pair cap that Lemma L35 uses", Passage E's bound $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$ and everything after it in E, and the use of $M$ inside $G$ at line 579.

## The falsifying object, and the search for it

A falsifier of the bound would be a list $\lambda_P$ of $k\ge3$ positive reals and a $t\ge0$ meeting every pair cap with $3\sum_Tt_Tw_T>h(s^2-u)$. Section 1 excludes it for every list, because $z=\tfrac h3\lambda_\alpha\lambda_\beta$ is a dual certificate whose feasibility I checked on every triple (section 2). I looked for one analytically at the places a duality proof usually breaks: the triples other than the top three (the exchange of section 2), ties (section 2), $k=3$ where the pair caps coincide (section 7), and a non-equal $k=4$ list where the caps interact (section 3.W, which gives a strict inequality with margin $3(L-1)/(2L+1)$, consistent with the bound). A falsifier of sharpness would be a $\kappa<1$ valid for all lists, which the equal list excludes. For Passage E the falsifying object is exhibited: $k=3$, $\lambda=(1,1,1)$, $\mu=\tfrac14$.

## Overall verdict

**PROVEN.** Lemma L42 as stated in Passages A, B and C is established by Passage D's weak-duality argument, with sharpness in the sense of the coefficient. Two defects sit outside that proof chain and should be fixed in the record: Passage E's feasibility sentence is REFUTED AS STATED, and Passage A's pointer is REFUTED because it names the section carrying Passage E rather than Passage D. The Lean statement matches the claim and remains unproven (sorry).
