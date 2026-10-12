# Verifier v232, Lemma L42 (the sharp dual weight): the bound by weak duality, the binding triple, sharpness, Passage E's normalisation, Passage A's pointer, and the Lean statement

Cold brief ([BRIEF_L42.md](BRIEF_L42.md)). No numerical work was done, every value is exact, and no scripts were written. Lean was read and not built. Log: [agent_logs/verify-L42-v232.log](../agent_logs/verify-L42-v232.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $3M(\lambda_P)\le h(s^2-u)$ by LP weak duality (Passage D, lines 585-603) | CONFIRMED |
| 2 | The three largest entries are the binding triple, ties included (Passage D, line 598) | CONFIRMED |
| 3a | "The constant cannot be improved" (Passage A line 545, Passage D line 606), read as the uniform multiplicative constant | CONFIRMED |
| 3b | "the constant is attained, so no better weight exists for this relaxation" (Passage C line 635) | CONFIRMED (in the uniform and product-weight readings, see 3.3) |
| 4 | Passage E: $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible "exactly when $\mu$ is at least the triple's harmonic mean" (line 519-520) | REFUTED AS STATED |
| 5 | Passage A's pointer: the argument is "under 'The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three nam'" (line 538) | REFUTED |
| 6 | Lean `sharp_dual_weight` (L42Statement.lean lines 124-130) is the record's bound | CONFIRMED (statement only, the proof is `sorry`, sharpness untyped) |
| 7 | Boundary: $k=3$, all entries equal, ties, $k\le2$ | CONFIRMED |

**What the round should do:** record L42 as proven by Passage D, correct Passage E's threshold to $\mu\ge 2H/9$ (or delete the sentence), and repoint Passage A at the heading on line 581.

## 0. Conventions, fixed once

- $k\ge3$, $\lambda=(\lambda_1,\dots,\lambda_k)$ with every $\lambda_\alpha>0$. A triple $T$ is a 3-element subset of $\{1,\dots,k\}$, a pair $p$ a 2-element subset. $w_T=\prod_{\alpha\in T}\lambda_\alpha$.
- Primal: $M=\max\{\sum_T t_Tw_T : t\ge0,\ \sum_{T\ni p}t_T\le2\ \forall p\}$. Dual: $\min\{2\sum_pz_p : z\ge0,\ \sum_{p\subset T}z_p\ge w_T\ \forall T\}$.
- $H(x,y,z)=3/(1/x+1/y+1/z)$. $H_T$ is $H$ of the values on $T$. $h=H$ of the three largest values. $\mu_1\ge\mu_2\ge\mu_3\ge\dots$ is the sorted list of values.
- $s=\sum\lambda$, $u=\sum\lambda^2$, $s^2-u=2e_2$ with $e_2=\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta$.
- Line numbers refer to [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) unless another file is named. The quotations in the brief were checked against the source: Passages A, D and E match their cited lines, Passage C sits at [results.md](../results.md) lines 633-637 and Passage B at line 182. Passage F in the brief stops at Lean line 128, mid-expression. The file continues on line 129 with `* ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2) := by` and line 130 `sorry`, and the checks below use the full statement.

## Hypothesis inventory

| Hypothesis | Source | Holds for the object? | Used where |
|---|---|---|---|
| $k\ge3$ | statement (A, B, C), D line 608 | assumed | $h$ defined (three largest exist). Sharpness witness $t=2/(k-2)$ needs $k\ge3$ |
| $\lambda_\alpha>0$ for all $\alpha$ | statement | assumed | division by $w_T>0$ (line 595), $H$ defined, $z=c\lambda_\alpha\lambda_\beta\ge0$ |
| $t\ge0$ | primal | yes | weak duality, first inequality (1.1) |
| pair cap $\le2$ | primal | yes | weak duality, second inequality (1.1) |
| $t$ indexed by unordered triples | brief definitions | yes | the dual has one constraint per unordered triple and one variable per unordered pair |
| LP weak duality: primal $\max c^{\mathsf T}t$, $At\le b$, $t\ge0$ has dual $\min b^{\mathsf T}z$, $A^{\mathsf T}z\ge c$, $z\ge0$, and any feasible pair satisfies $c^{\mathsf T}t\le b^{\mathsf T}z$ | imported | yes: $A$ is the pair-triple incidence matrix, $b=2\mathbf 1$, $c=w$. The dual on line 589 is exactly this dual. Feasibility of both sides is shown in 1.1 and 2 | line 599-601 |
| Harmonic mean is increasing in each argument | imported | yes, on $(0,\infty)^3$: $\partial H/\partial x=3x^{-2}/(\sum1/\cdot)^2>0$ | line 598 |
| $M$ is attained (the statement writes max) | statement, unstated | yes: the feasible set is a nonempty polytope ($t=0$ feasible, $0\le t_T\le2$ by any cap containing $T$) | not needed, the bound holds for every feasible $t$ |
| $h\ge0$ so that $z\ge0$ | used, unstated | yes, from positivity | line 598 |

**Used but unstated:** only the two trivially true items in the last rows. No finding.

## 1. The bound by weak duality (brief attack item 1)

### 1.1 Derivation, link by link

1. *Dual as written (line 589).* The primal has variables $t_T$, one cap per pair with right-hand side $2$, objective coefficients $w_T$. Its LP dual has one variable $z_p\ge0$ per pair, objective $\sum_p2z_p$, and one constraint per triple, $\sum_{p\subset T}z_p\ge w_T$, which for $T=\{\alpha,\beta,\gamma\}$ is $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$. Matches line 589 exactly.
2. *Weak duality, spelled out.* For feasible $t$ and $z$: $\sum_Tt_Tw_T\le\sum_Tt_T\sum_{p\subset T}z_p=\sum_pz_p\sum_{T\ni p}t_T\le\sum_p2z_p$. The first inequality uses $t\ge0$ and dual feasibility at every triple. The exchange of sums is finite. The second uses $z\ge0$ and the pair cap. So $M\le2\sum_pz_p$ for every dual-feasible $z$.
3. *Feasibility at every triple (line 594-598).* With $z_{\alpha\beta}=c\lambda_\alpha\lambda_\beta$, the triple constraint is $c(\lambda_\alpha\lambda_\beta+\lambda_\beta\lambda_\gamma+\lambda_\alpha\lambda_\gamma)\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$. Dividing by $w_T>0$ gives $c(1/\lambda_\alpha+1/\lambda_\beta+1/\lambda_\gamma)\ge1$, and since the bracket equals $3/H_T>0$, this is $c\ge H_T/3$. The "i.e." is an equivalence. So $z$ is feasible iff $c\ge\max_TH_T/3$ (and $c\ge0$, implied). By item 2 below, $\max_TH_T=h$, so $c=h/3$ is feasible at every triple, not only the top one.
4. *Summation (line 601).* $2\sum_{\alpha<\beta}\tfrac h3\lambda_\alpha\lambda_\beta=\tfrac{2h}3e_2=\tfrac{2h}3\cdot\tfrac{s^2-u}2=\tfrac h3(s^2-u)$. Hence $M\le\tfrac h3(s^2-u)$, and $3M\le h(s^2-u)$.

Every link follows from the line above and from stated hypotheses. **Verdict: CONFIRMED.**

### 1.2 Candidates

No candidate survived. See 2.2 for the one withdrawn candidate on this chain.

## 2. The binding triple, including ties (brief attack item 2)

### 2.1 Derivation

- Claim needed: $H_T\le h$ for every triple $T$. Let $T$ carry values $x_1\ge x_2\ge x_3$. The $i$-th largest value of a sub-list is at most the $i$-th largest value of the list, so $x_i\le\mu_i$. $H$ is increasing in each argument, so $H(x_1,x_2,x_3)\le H(\mu_1,\mu_2,\mu_3)=h$. Equality at the top triple, so $\max_TH_T=h$.
- Ties: when $\mu_3=\mu_4$ (or more ties), several index triples realise "the three largest". Each has value multiset $\{\mu_1,\mu_2,\mu_3\}$: if $a,b,c$ are distinct and every other index has value $\le\min(\lambda_a,\lambda_b,\lambda_c)$, then $\lambda_a,\lambda_b,\lambda_c$ are the top three order statistics as a multiset. $H$ is symmetric, so $h$ is well defined under any choice.
- Necessity: the top triple forces $c\ge h/3$, so $c=h/3$ is the least feasible product weight.

**Verdict: CONFIRMED.**

### 2.2 Withdrawn candidate

- **Candidate W1: the step "increasing in each argument, so the binding triple is the three largest" omits the coordinatewise comparison $x_i\le\mu_i$.**
  1. Location: line 598, *"The harmonic mean is increasing in each argument, so the binding triple is the **three largest positives**"*.
  2. Failure in closed form: none exists. Every triple satisfies $H_T\le h$ by 2.1. What is absent is only the order-statistics sentence.
  3. Charitable reading: "three largest" defines the triple by coordinatewise domination of every other triple after sorting, which is exactly what monotonicity plus symmetry needs. The step is complete on that reading.
  - **Withdrawn**: step (2) fails, no object exhibits a failure, and the omitted sentence is the definition of "largest".

## 3. Sharpness (brief attack item 3)

### 3.1 What "the constant" is

The statement has one free constant: the factor relating $3M$ to $h(s^2-u)$, equivalently the $3$ on the left or an implicit $1$ on the right. "Cannot be improved" then means: for no $\kappa<1$ does $3M\le\kappa\,h(s^2-u)$ hold for every admissible $\lambda$. This is a $\forall\kappa<1\ \exists\lambda$ statement, and one witness per $\kappa$ suffices.

### 3.2 Derivation

- All $k$ entries equal to $\lambda>0$, $k\ge3$: $h=\lambda$, $s^2-u=k^2\lambda^2-k\lambda^2=k(k-1)\lambda^2$, bound $3M\le k(k-1)\lambda^3$.
- Witness $t_T=2/(k-2)$ on every triple: each pair lies in exactly $k-2$ triples, marginal $(k-2)\cdot2/(k-2)=2$, feasible. Objective $\binom k3\cdot\tfrac2{k-2}\lambda^3=\tfrac{k(k-1)(k-2)}6\cdot\tfrac2{k-2}\lambda^3=\tfrac{k(k-1)}3\lambda^3$. So $3M\ge k(k-1)\lambda^3$, and with 1.1, $3M=k(k-1)\lambda^3$.
- For any $\kappa<1$, $\kappa\,h(s^2-u)=\kappa k(k-1)\lambda^3<3M$, so the constant cannot be lowered, at every $k\ge3$.
- The side remark on line 606, *"The pair-count $\sum t\le k(k-1)/3$ is the same upper bound again, not attainment"*, is correct: $3\sum_Tt_T=\sum_p\sum_{T\ni p}t_T\le2\binom k2$.

**3a verdict: CONFIRMED.** Passage C's inference *"the constant is attained, so no better weight exists for this relaxation"* is valid in the uniform reading, and also in the product-weight reading (2.1, necessity: no $c<h/3$ makes $z=c\lambda_\alpha\lambda_\beta$ feasible). **3b verdict: CONFIRMED** in those readings. The pointwise reading is recorded and withdrawn in 3.3.

### 3.3 Withdrawn candidate

- **Candidate W2: "no better weight exists" is false pointwise, since at some spectra a weight strictly below $h$ satisfies the inequality.**
  1. Location: [results.md](../results.md) line 635, *"the constant is attained, so no better weight exists for this relaxation"*.
  2. Closed form: $k=4$, $\lambda=(1,1,1,\tfrac14)$. Primal $t_{123}=2$, all else $0$, is feasible with value $2$. Dual $z_{12}=z_{13}=z_{23}=\tfrac13$, all else $0$: triple $123$ gives $1\ge1$, and each triple $\{i,j,4\}$ gives $\tfrac13\ge\tfrac14$, feasible with value $2$. So $M=2$ exactly. Here $h=1$, $s=\tfrac{13}4$, $u=\tfrac{49}{16}$, $s^2-u=\tfrac{15}2$. So $3M=6<\tfrac{15}2=h(s^2-u)$, and the weight $h'=\tfrac45<h$ satisfies $3M\le h'(s^2-u)$ at this spectrum.
  3. Charitable reading: "weight" is the lemma's name for the dual weight $c=h/3$ in $z=c\lambda_\alpha\lambda_\beta$, or the uniform constant. In both readings the sentence is true (3.2, 2.1), and "attained" is attainment at the equal spectrum, which is how line 606 argues it.
  - **Withdrawn**: step (3) rescues it. A reader could take the pointwise sense, and the observation that the bound is strict at $(1,1,1,\tfrac14)$ is recorded here for the round, not as a finding.

## 4. Passage E's normalisation (brief attack item 4)

### 4.1 Derivation

- With $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$, the product-weight constant is $c=\tfrac32\mu$. By 1.1 step 3, feasibility on $T$ is $\tfrac32\mu\ge H_T/3$, i.e. $\mu\ge\tfrac29H_T$.
- "Feasible exactly when $\mu\ge H_T$" asserts the threshold is $H_T$. The "if" half is true ($H_T\ge\tfrac29H_T$). The "only if" half is false.
- With $\mu=h$ as the sentence goes on to take, the dual value is $2\sum\tfrac32h\lambda_\alpha\lambda_\beta=3he_2=\tfrac32h(s^2-u)$, so weak duality gives $3M\le\tfrac92h(s^2-u)$, not the boxed bound. The boxed bound corresponds to $\mu=\tfrac29h$.

### 4.2 Finding F1 (survives)

1. Location: line 518-520, *"For a triple of positives the dual $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible exactly when $\mu$ is at least the triple's harmonic mean, so the binding value is $h$ [...] and $3M(\lambda_P)\le h\,(s^2-u)$."*
2. Closed form: triple $(1,1,1)$, $H=1$, $\mu=\tfrac29$. Then $z=\tfrac13$ on each pair, sum $1\ge1=w_T$, feasible, while $\mu=\tfrac29<1=H$. And with $\mu=h$ the chain gives $3M\le\tfrac92h(s^2-u)$, so "so ... $3M\le h(s^2-u)$" does not follow from the sentence.
3. Charitable reading: a different normalisation of $z$ would make "$\mu\ge H$" correct, namely $z=\tfrac\mu3\lambda_\alpha\lambda_\beta$. The text fixes the factor $\tfrac32$ explicitly, so no reading of the printed sentence rescues the threshold. The conclusion $3M\le h(s^2-u)$ is true, by Passage D.

**Verdict: REFUTED AS STATED.** The intermediate threshold is wrong by a factor $\tfrac92$, the final inequality is unaffected because Passage D proves it independently.

### 4.3 Consistency with Passage D

- Passage D's threshold $c\ge H_T/3$ (line 595-596) translates to $\mu\ge\tfrac29H_T$ in Passage E's normalisation. The two passages are inconsistent, and D is the correct one.
- The paragraph at line 612, immediately after the quoted range of Passage D and in the same source file, already records this correction: *"in that normalisation $c=\tfrac32\mu$ and the condition is $\mu\ge2/\big(3\sum\lambda^{-1}\big)$"* and *"$\mu\ge H$ is $\tfrac92$ times the true threshold and matches neither the recorded $2H/3$ nor the truth $2H/9$, with $\mu=h$ the dual gives $3M\le\tfrac92h(s^2-u)$"*. Each figure there agrees with 4.1: $2/(3\sum\lambda^{-1})=2H/9$ because $\sum\lambda^{-1}=3/H$, and $2/\sum\lambda^{-1}=2H/3$. The correction was not carried back to line 519-520, which still states the wrong threshold.

## 5. Passage A's pointer (brief attack item 5)

### 5.1 Finding F2 (survives)

1. Location: line 538, *"the argument is in this file under "The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three nam""*. The quoted heading is also truncated: line 468 reads "...closed modulo three named items".
2. Concrete failure: the section opened by line 468 runs to line 486, where the same-level heading `#### Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally` (line 487) closes it. Lines 469-486 carry a four-row region table and three owed items, and contain no dual, no weak duality and no sharpness witness. Passage E (line 518) sits under the L35 heading at line 487, so the brief's location fact that E sits under line 468 holds only in the loose sense of "after it". Even on that loose sense, what the pointer reaches is Passage E, which carries one sentence whose threshold is refuted in 4.2, and neither the dual feasibility argument nor the sharpness witness. The argument is Passage D, under line 581 inside the `##` section opened at line 566, whose own note says the L42 block "points at an argument it does not carry".
3. Charitable reading: "under" means anywhere later in the file, and "the argument" is the one-sentence sketch of Passage E. On that reading the pointer reaches a sketch whose stated threshold is false and whose conclusion does not follow from it, so it still fails to reach an argument that establishes the lemma.

**Verdict: REFUTED.** Passage C's pointer, [stratum-two-negative.md](../findings/stratum-two-negative.md) as a whole file, does reach Passage D. Passage B carries no proof pointer.

## 6. The Lean statement (brief attack item 6, standing item 5)

### 6.1 Check

- **Binders and types.** `k : ℕ` implicit, `t : Fin k → Fin k → Fin k → ℝ`, `lam : Fin k → ℝ`, `a b c : Fin k`, `hk : 3 ≤ k`, `hpos : ∀ i, 0 < lam i`, `hft : Feasible t`, `h3 : ThreeLargest lam a b c`. Every variable ranges over the right type, and all are universally quantified.
- **Direction and form.** `3 * objective t lam ≤ harmonicMean (lam a) (lam b) (lam c) * ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2)`. The second `∑` binds `lam i ^ 2`, so the factor is $s^2-u$. Direction matches $3M\le h(s^2-u)$. Bounding every feasible $t$ is equivalent to bounding $M$, since $M$ is the maximum over the same set (attained, as in the inventory).
- **`Feasible` and repeated indices.** `nonneg` and total symmetry (`symm12`, `symm23` generate $S_3$) hold at all index triples, repeated ones included. Entries with a repeated index are otherwise free. They never enter: `objective` sums over `α < β < γ` strictly, and `pairCap` requires `α ≠ β` and filters `γ ≠ α ∧ γ ≠ β`. So restriction to strictly increasing triples is a bijection, up to those irrelevant free entries, between Lean-feasible `t` and the record's feasible $t$ on unordered triples. The cap for the ordered pair $(\beta,\alpha)$ equals that for $(\alpha,\beta)$ by `symm12`, so no extra constraint is imposed. `Feasible` matches the primal exactly.
- **`objective`.** $\sum_\alpha\sum_{\beta>\alpha}\sum_{\gamma>\beta}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=\sum_{\alpha<\beta<\gamma}$. Matches.
- **`ThreeLargest` and `harmonicMean`.** By 2.1 (ties), any `a b c` satisfying `ThreeLargest` carry the multiset $\{\mu_1,\mu_2,\mu_3\}$, and `harmonicMean` is symmetric, so the right-hand side is $h$ for every admissible choice. With `hpos` no denominator is zero. `hk` is implied by `ab`, `bc`, `ac` and is harmless.
- **Scope.** The theorem body is `sorry` (line 130). Sharpness and $M$ as a maximum are untyped, as the file's docstring says (lines 55-63). `triple_constraint` states the correct per-triple step ($H/3\le c\Rightarrow xyz\le c(xy+yz+xz)$ for positive $x,y,z$).
- **Observation, no verdict effect.** The file's header claims to quote the record verbatim, and its line 31 quotes the heading as "Hypothesis, previously unstated: at least three positives" while source line 608 now reads "Hypothesis: at least three positives".

**Verdict: CONFIRMED** as a faithful statement of the bound half of L42. It is unproven in Lean and carries no sharpness clause.

## 7. Boundary (brief attack item 7, standing item 3)

- **$k=3$.** One triple, caps give $t_{123}\le2$, so $M=2\lambda_1\lambda_2\lambda_3$. Right side: $h(s^2-u)=\tfrac3{\sum1/\lambda}\cdot2e_2=\tfrac{3\cdot2e_2\cdot\lambda_1\lambda_2\lambda_3}{e_2}=6\lambda_1\lambda_2\lambda_3=3M$. **Equality at every spectrum with $k=3$**, which is stronger than the record states and consistent with it. The witness $t=2/(k-2)=2$ is the case $k=3$.
- **All entries equal.** Equality at every $k\ge3$ (3.2).
- **Ties among the largest.** $h$ well defined (2.1). The Lean `ThreeLargest` admits any tied choice and returns the same $h$.
- **$k\le2$.** No triples, the objective is an empty sum, $M=0$, and "the three largest" do not exist, so $h$ is undefined. The statement excludes these cases by hypothesis ("at least three"), and line 610 says so. The pointer "closed elsewhere" was not followed, it is outside L42.
- **Strictness away from the boundary.** At $(1,1,1,\tfrac14)$ the bound is strict (3.3), so equality is a property of $k=3$ and of equal spectra, not of all spectra.

**Verdict: CONFIRMED.**

## Standing items not covered above

- **Quantifier order and scope (standing 2).** $M$ is a max over $t$ at fixed $\lambda$. $h$ is a max of $H_T$ over triples at fixed $\lambda$, chosen before summation, independent of $t$. $c$ is one scalar for all triples. Sharpness is $\forall k\ge3\ \forall\kappa<1\ \exists\lambda$ (the equal spectrum). Passage C's "attained" is existential in $\lambda$. No finding: every max and bound is taken over the right set.
- **Proven versus stated or used (standing 4).** Passage D proves the bound for every feasible $t$ and uniform sharpness, which is what A, B and C state. Passage E states a false threshold on the way to the same conclusion (F1). Passage E's further sentences ($h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$ and the relaxation) are consumers of L42, outside this brief's definitions, and were not checked. No further gap.
- **Falsifying object (standing 7).** The bound is falsified by a positive list with $k\ge3$ and a feasible $t$ with $3\sum_Tt_Tw_T>h(s^2-u)$. Sharpness is falsified by a $\kappa<1$ valid at every spectrum. I looked in closed form at $k=3$ (equality everywhere, no room), at all-equal spectra (equality), and at $(1,1,1,x)$ with $x\le\tfrac13$ ($M=2$ by matching primal and dual certificates, slack $6x$). None falsifies either clause, and 1.1 rules out the first object in general. Passage E is falsified by $(1,1,1)$ with $\mu=\tfrac29$.

## Overall verdict

**PROVEN.** Passage D's weak-duality argument establishes $3M(\lambda_P)\le h(s^2-u)$ for every positive list with $k\ge3$, and the equal spectrum establishes that the constant cannot be lowered. Two record defects sit outside that proof: Passage E's threshold "$\mu$ at least the triple's harmonic mean" is REFUTED AS STATED (F1, correct threshold $\tfrac29H$, already noted at line 612 but not fixed in place), and Passage A's pointer lands on a section with no L42 argument (F2).
