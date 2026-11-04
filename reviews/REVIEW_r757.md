# Reviewer r757, L173, the pinned class's kernel witness at $n=12$, Gate 2

**Cold brief.** I read [BRIEF-g2-l173.md](BRIEF-g2-l173.md) and nothing else from [bounds-relaxations.md](../findings/bounds-relaxations.md) until every verdict below was fixed. **No numerical work was done and every value in this report is exact**, rational arithmetic throughout, with one exact-rational screen of my own hand derivations reported as a screen and never as evidence. Log: [agent_logs/g2-l173-r757.log](../agent_logs/g2-l173-r757.log).

## Claim table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | The nine relations (A$_i$), (B$_i$), (C$_i$) hold at the displayed witness, exactly | **CONFIRMED**, all nine, re-derived from $\mu$ and $\nu$ rather than transcribed |
| 2 | The pair-cap coefficient $\mu^{(ij)}_k=m_k-\delta_{ik}-\delta_{jk}$, including at $i=j$ | **CONFIRMED**, correct at $i=j$, and hollowness is what makes it correct |
| 3 | The six caps: $(1,1)$, $(1,2)$, $(2,2)$ tight at $2$; $(1,3)=(2,3)=\tfrac8{59}$; $(3,3)=\tfrac{562}{1711}$ | **CONFIRMED**, and they re-sum to the Killing row mass $20$ at all three rows |
| 4 | Admissibility: every $m_i\ge3$, all ten types exist, no inadmissible type set nonzero | **CONFIRMED**, $m_2=3$ sits exactly on the edge that $t_{222}\ne0$ needs |
| 5 | $T\ge0$ at all ten types | **CONFIRMED** in the record; **ABSENT from the Lean file**, whose docstring claims it |
| 6 | Forced parameters: $4+3+59=\binom{12}2$, $b=\tfrac43a$, $a=\sqrt{3/28}$ | **CONFIRMED** |
| 7 | $\theta=7a=\sqrt{21}/2>\theta_0(12)$, ratio $\sqrt{189/55}$ | **CONFIRMED** |
| 8 | The $\theta$ of (C) is the functional's $\theta$ | **CONDITIONAL, and the conclusion does not need it.** The identification holds exactly under realizability, and **the witness is provably NOT realizable** (§7) |
| 9 | The conclusion, *"no bound proved from (A), (B), (C), positivity and support alone can close Conjecture A"* | **CONFIRMED**, and **understated on two counts**, the pair cap belongs in the list, and the witness exists at **every $n\ge8$** |
| 10 | The kernel mechanism, and whether it needs $m_3$ large or merely $\ge3$ | **CONFIRMED**; *"merely $\ge3$"* is **REFUTED**, the supply is linear in $m_3$ and needs $2n-16\le2m_3$ |
| 11 | [L173.lean](../lean/HamiltonsCubic/Results/L173.lean) `row2_B` states relation (B$_2$) | **REFUTED**, it states row 3's identity, duplicating `row3_BC`; (B$_2$) is checked nowhere |
| 12 | [L173.lean](../lean/HamiltonsCubic/Results/L173.lean) checks *"the nine relations"* and *"the witness is nonnegative"* | **REFUTED**, eight of nine relations, and no nonnegativity theorem exists |

**Overall verdict: PROVEN, hypotheses corrected.**

**One-line actionable summary.** The witness is exact and the lemma's conclusion stands and generalises to every $n\ge8$; add the pair cap to the conclusion's ingredient list, record that the witness is **not realizable** (which is what makes this the record's own outcome (ii) rather than outcome (iii) or (iv)) and repair `row2_B`, which never states (B$_2$).

## 0. Conventions, fixed once

- $n=12$, $N=\binom{12}2=66$, $d=3$; classes $1,2,3$ with $\nu=a\cdot(-1,\tfrac43,0)$ and $m=(4,3,59)$, $a=\sqrt{3/28}$.
- **Everything is carried in units of $a$.** (A) is rational; (B) is homogeneous of degree $1$ and I divide it by $a$; (C) is homogeneous of degree $2$ and I divide it by $a^2$, writing $\Theta:=\theta/a$. The witness claim is $\Theta=7$.
- $\mu^{(i)}_j=m_j-\delta_{ij}$ for a row, $\mu^{(ij)}_k=m_k-\delta_{ik}-\delta_{jk}$ for a pair.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ ([problem.md](../findings/problem.md), line 549), so $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}$.
- **Norm.** $\lVert Z\rVert^2=\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$ on $\mathfrak{so}(n)$, the record's, which is the normalisation the constant $2$ in the pair cap rests on ([conventions.md](../findings/conventions.md), line 29).
- The witness: $t_{112}=\tfrac23$, $t_{222}=2$, $t_{133}=t_{233}=\tfrac4{1711}$, $t_{333}=\tfrac{178}{32509}$, and $t_{111}=t_{113}=t_{122}=t_{123}=t_{223}=0$.

## Hypothesis inventory

What the witness's feasibility consumes, and where each comes from:

| Ingredient | Status here | Source |
| --- | --- | --- |
| (A$_i$) at every row | used, holds | the Killing row mass, [Lemma L153](../findings/bounds.md), holds on all of $\mathcal W_n$ |
| (B$_i$) at every row | used, holds | Ricci-flatness with first Bianchi, holds on all of $\mathcal W_n$ |
| (C$_i$) at every row | used, holds | the diagonal of $W^\#=\theta W-W^2$, **criticality only** |
| $T\ge0$, totally symmetric, hollow | used, holds | $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ |
| the pair cap $\le2$ | **used, holds, and omitted from the conclusion's ingredient list** | [Lemma L31](../findings/stratum-two-negative.md) |
| the value-type reduction to $3d$ equalities | **assumed, not audited here** | [Lemma L104](../findings/bounds-relaxations.md), and the Lean file also declares it out of scope |
| realizability of $(\nu,m,T)$ by an actual unit critical $W$ | **not assumed, and provably false at this witness** | §7 below |

## 1. The nine relations, re-derived

I built each row's coefficients from $\mu^{(i)}$ and $\nu$ rather than reading the displayed integers, then compared. All nine hold.

**Row 1**, $\mu^{(1)}=(3,3,59)$.

- (A$_1$): the only surviving terms are $2\mu_1\mu_2t_{112}=18\cdot\tfrac23=12$ and $\mu_3(\mu_3-1)t_{133}=3422\cdot\tfrac4{1711}=8$, since $1711\cdot2=3422$. Total $20=2(n-2)$. ✓
- (B$_1$): $\mu_1\mu_2(\nu_1+\nu_2)/a=9\cdot(-1+\tfrac43)=3$, so the left side is $3\cdot\tfrac23=2$; the right side is $-2\nu_1/a=2$. ✓ The class-3 terms die because $\nu_3=0$.
- (C$_1$): $2\mu_1\mu_2\nu_1\nu_2/a^2=18\cdot(-1)(\tfrac43)=-24$, so the left side is $-24\cdot\tfrac23=-16$; the right side is $2(-1)(\Theta+1)=-2\Theta-2$. Hence $\Theta=7$. ✓ **This single equation is where $\theta$ is forced**, and no other relation touches it.

**Row 2**, $\mu^{(2)}=(4,2,59)$.

- (A$_2$): $\mu_1(\mu_1-1)t_{112}=12\cdot\tfrac23=8$, $\mu_2(\mu_2-1)t_{222}=2\cdot2=4$, $\mu_3(\mu_3-1)t_{233}=3422\cdot\tfrac4{1711}=8$. Total $20$. ✓
- (B$_2$): $12\cdot(-1)\cdot\tfrac23+2\cdot\tfrac43\cdot2=-8+\tfrac{16}3=-\tfrac83$, and $-2\nu_2/a=-\tfrac83$. ✓
- (C$_2$): $12\cdot1\cdot\tfrac23+2\cdot\tfrac{16}9\cdot2=8+\tfrac{64}9=\tfrac{136}9$, and $2\cdot\tfrac43(7-\tfrac43)=\tfrac83\cdot\tfrac{17}3=\tfrac{136}9$. ✓

**Row 3**, $\mu^{(3)}=(4,3,58)$.

- (A$_3$): $2\mu_1\mu_3t_{133}+2\mu_2\mu_3t_{233}=2(232+174)\cdot\tfrac4{1711}=\tfrac{3248}{1711}=\tfrac{112}{59}$ (both fractions cancelling $29$), and $\mu_3(\mu_3-1)t_{333}=3306\cdot\tfrac{178}{32509}=\tfrac{1068}{59}$ (since $32509=19\cdot1711$ and $3306=2\cdot3\cdot19\cdot29$). Total $\tfrac{1180}{59}=20$. ✓
- (B$_3$): $\mu_1\mu_3\nu_1t_{133}+\mu_2\mu_3\nu_2t_{233}=(-232+174\cdot\tfrac43)\,a\cdot\tfrac4{1711}=0$, against $-2\nu_3=0$. ✓ **This is the one place $t_{133}=t_{233}$ is load-bearing**: the general form is $-4t_{133}+4t_{233}=0$ after dividing by $(m_3-1)a$.
- (C$_3$): every term carries $\nu_3$ or $\nu_3^2$ or a vanishing $t$, so both sides are $0$. ✓

**Screen.** I re-ran the nine relations and six caps from $\mu$ and $\nu$ in exact rationals; every one returned `True`, and no coefficient differed from my hand derivation. Reported as a screen of my own arithmetic, not as evidence.

## 2. The pair-cap coefficient, and the $i=j$ case

**The formula is right, and hollowness is why.** $\sum_\gamma T_{\alpha\beta\gamma}$ runs over all $\gamma$, but $T$ hollow kills $\gamma=\alpha$ and $\gamma=\beta$ outright, so the sum is over $\gamma\notin\{\alpha,\beta\}$, of which class $k$ contributes $m_k-\delta_{ik}-\delta_{jk}$ members. At $i=j$ the formula reads $m_i-1-1=m_i-2$, which is exactly the count of class-$i$ indices other than the two already spent, **so the two removals are correct precisely because they come from the same class**, and the formula needs no separate $i=j$ clause. It does need $m_i\ge2$ for such a pair to exist at all, satisfied at all three classes.

The six caps, computed from that formula:

$$(1,1)=2t_{111}+3t_{112}+59t_{113}=2,\qquad(1,2)=3t_{112}+2t_{122}+59t_{123}=2,\qquad(2,2)=4t_{122}+t_{222}+59t_{223}=2,$$
$$(1,3)=(2,3)=58\cdot\tfrac4{1711}=\tfrac{232}{1711}=\tfrac8{59},\qquad(3,3)=4t_{133}+3t_{233}+57t_{333}=\tfrac{28}{1711}+\tfrac{534}{1711}=\tfrac{562}{1711}.$$

All six agree with the record. **A cross-check the record does not display, and the sharpest test available for an error hidden by a tight cap:** the caps must re-sum to the Killing row mass, $\sum_{\beta}\big(\sum_\gamma T_{\alpha\beta\gamma}\big)=2(n-2)=20$ at every row. Row 1 gives $3\cdot2+3\cdot2+59\cdot\tfrac8{59}=6+6+8=20$; row 2 gives $4\cdot2+2\cdot2+59\cdot\tfrac8{59}=20$; row 3 gives $4\cdot\tfrac8{59}+3\cdot\tfrac8{59}+58\cdot\tfrac{562}{1711}=\tfrac{56}{59}+\tfrac{1124}{59}=\tfrac{1180}{59}=20$. **All three land on $20$ exactly**, which independently confirms (A) at all three rows *through* the cap coefficients, so an error in either the cap coefficients or the row coefficients would have to be a matched pair to survive. It is not.

## 3. Admissibility, and $T\ge0$

$m_1=4$, $m_2=3$, $m_3=59$, so every $m_i\ge3$ and all $\binom{d+2}3=10$ types exist. The witness sets nonzero exactly $t_{112}$ (needs $m_1\ge2$), $t_{222}$ (needs $m_2\ge3$), $t_{133}$, $t_{233}$ (need $m_3\ge2$) and $t_{333}$ (needs $m_3\ge3$). **$m_2=3$ is exactly the edge $t_{222}$ requires**, so the witness lives on the boundary of admissibility in class 2 and any reading that shrank $m_2$ would destroy it.

All ten values are nonnegative rationals: $0,\tfrac23,0,0,0,\tfrac4{1711},2,0,\tfrac4{1711},\tfrac{178}{32509}$. **Verified at every one of the ten types, as the brief asks.**

## 4. The forced parameters

- $4+3+59=66=\tfrac{12\cdot11}2=\binom{12}2$. ✓
- **Tracelessness.** $\sum_im_i\nu_i=4(-a)+3b+59\cdot0=0$ gives $b=\tfrac43a$. ✓ Note $m_3$ enters nowhere, because $\nu_3=0$.
- **Unit norm.** $\sum_im_i\nu_i^2=4a^2+3\cdot\tfrac{16}9a^2=\tfrac{12+16}3a^2=\tfrac{28}3a^2=1$, so $a^2=\tfrac3{28}$. ✓ Again $m_3$ is invisible. **So $a$ is pinned by $m_1=4$ and $m_2=3$ alone**, a fact §8 turns into the generalisation.

## 5. The closed form

$(7a)^2=49\cdot\tfrac3{28}=\tfrac{147}{28}=\tfrac{21}4$, so $7a=\tfrac{\sqrt{21}}2=2.29128784\ldots$ ✓ And $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}=1.5\overline{27}<\tfrac{21}4=5.25$. ✓ The ratio squared is $\tfrac{21}4\cdot\tfrac{144}{220}=\tfrac{3024}{880}=\tfrac{189}{55}$, so the ratio is $\sqrt{189/55}=1.85374\ldots$ ✓ All three confirmed.

## 6. The machine-checked statement, two defects

**Defect 1: `row2_B` does not state relation (B$_2$).** It reads `(174 : ℚ) * (4 / 3) = 232`, docstring *"Row 2: (B₂), which closes because $174b=232a$."*

- **Located.** [L173.lean](../lean/HamiltonsCubic/Results/L173.lean), theorem `row2_B`.
- **Exhibited.** (B$_2$) carries $\mu^{(2)}=(4,2,59)$, whose coefficients are $\mu_1\mu_2(\nu_1+\nu_2)=\tfrac83a$, $\mu_1\mu_3(\nu_1+\nu_3)=-236a$, $\mu_2\mu_3(\nu_2+\nu_3)=\tfrac{472}3a$, $\mu_1(\mu_1-1)\nu_1=-12a$, $\mu_2(\mu_2-1)\nu_2=\tfrac83a$, $\mu_3(\mu_3-1)\nu_3=0$. **The integers $174$ and $232$ appear in none of them.** They are $\mu_2\mu_3=3\cdot58$ and $\mu_1\mu_3=4\cdot58$ at $\mu^{(3)}=(4,3,58)$ (row 3's coefficients) and `row3_BC` immediately below states the same arithmetic. So the file states row 3's identity twice and (B$_2$) never.
- **Argued the opposite.** Could $174:232$ be (B$_2$) under a rescaling? (B$_2$)'s two surviving terms at the witness are $-12\cdot\tfrac23=-8$ and $2\cdot\tfrac43\cdot2=\tfrac{16}3$, in ratio $-3:2$; the theorem's is $3:4$, not proportional under any scaling. Could the docstring mean *"(B$_2$) reduces to $0=0$ by the same identity"*? (B$_2$)'s right side is $-2\nu_2=-\tfrac83a\ne0$, so it is not a vanishing identity and cannot be that one. **The strongest reading fails; the discrepancy stands.**
- **Impact.** The mathematics is unharmed, I verified (B$_2$) by hand in §1 and it holds. What is harmed is the audit surface: **the kernel checks eight of the nine relations**, and the docstring's *"the nine relations"* overclaims by one.

**Defect 2: the docstring claims a nonnegativity check the file does not contain.** *"What is checked here … that the witness is nonnegative"*, the file's sixteen theorems are `multiplicities`, `traceless`, `unit_norm`, the six row identities, `row3_BC`, `caps_tight`, `caps_slack`, `theta_closed_form`, `exceeds_threshold` and `ratio_squared`. **No theorem asserts $t\ge0$.** It is visible from the displayed literals, which are all nonnegative rationals, but visible is not checked.

**A structural remark on the same file, offered rather than charged.** The witness is never named as an object; its values are re-typed inline in each theorem. So nothing in the kernel enforces that the relations and the caps read the *same* tuple, the file is a list of arithmetic identities rather than a check that one $t$ satisfies one system. That is why `row2_B` could drift to another row's numbers without any statement breaking, and it is the same shape of weakness the record has recorded elsewhere for Lean files that assert numerals rather than evaluations.

**What its statements do get right.** `row1_C`'s $-18\cdot\tfrac43\cdot\tfrac23=-2\cdot7-2$ is $2\mu_1\mu_2\nu_1\nu_2/a^2=-24$ with the sign pulled out front, correct; `row2_C`, `row1_A`, `row2_A`, `row3_A`, `row3_BC`, both cap theorems, `theta_closed_form`, `exceeds_threshold` and `ratio_squared` are each the statement the lemma needs. The `caps_slack` display omits the $3t_{113}+3t_{123}$ and $4t_{123}+2t_{223}$ terms, which are zero, so it states the cap's value rather than its full expansion, acceptable, and weaker than the record's sentence.

## 7. Is the $\theta$ of (C) the functional's $\theta$?, the item the conclusion rests on

**The definition.** [conventions.md](../findings/conventions.md) line 17 defines $\theta=P(W)/\lVert W\rVert^3$, with $Q(W)=\theta W$ at a critical point. [bounds.md](../findings/bounds.md) line 436 states that **(C) is literally the diagonal of $Q(W)=\theta W$**, which is why it needs criticality where (A) and (B) do not.

**Inside the relaxation, $\theta$ is a free scalar that enters through (C)'s right side and nowhere else.** So the honest reading of the pinned system is: it is a linear system in $(t,\theta)$ whose coefficients are built from $(\nu,m)$, and $\theta$ is *whatever number makes (C) consistent*. Nothing in (A), (B), (C), $T\ge0$ or the caps says that number is a value of $P$.

**What the relaxation does give, and it is the strongest positive statement available.** Contract (C$_i$) against $m_i\nu_i$ and sum over $i$:

$$\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=\sum_im_i\nu_i\cdot2\nu_i(\theta-\nu_i)=2\theta\lVert W\rVert^2-2\mathop{\mathrm{tr}}W^3=2\theta-2\mathop{\mathrm{tr}}W^3,$$

which rearranges to $\theta=\mathop{\mathrm{tr}}W^3+\tfrac12\sum\lambda\lambda\lambda\,T$, **exactly the record's cubic identity for $P(W)$** ([bounds.md](../findings/bounds.md) line 444, which notes the two are one equation). So the abstract $\theta$ is precisely the number $P(W)$ *would* take if the triple were realized by an actual unit critical $W$. At this witness $\mathop{\mathrm{tr}}W^3=\tfrac{28}9a^3=\tfrac a3$, and the identity closes on $\theta=7a$ tautologically.

**So the identification is exactly conditional on realizability, and that condition is not idle here. I can settle it: the witness is not realizable.**

**Derivation.** Suppose some unit critical $W\in\mathcal W_n$ has this spectrum and class-averages to this $t$. Write $U$ for the $\nu_1$-eigenspace ($\dim4$), $\mathfrak h$ for the $\nu_2$-eigenspace ($\dim3$), $Z$ for the kernel, with orthonormal eigenvectors $u_1,\dots,u_4$ and $w_1,w_2,w_3$ in $\mathfrak{so}(n)$ under the record's norm.

1. **Every individual cap inside $U\cup\mathfrak h$ is tight.** Each individual $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ by [Lemma L31](../findings/stratum-two-negative.md), and the class-averaged caps $(1,1)$, $(1,2)$, $(2,2)$ all equal $2$. An average of numbers $\le2$ equalling $2$ forces every one of them to be $2$. So **all $6+12+3=21$ pairs drawn from the seven vectors are tight.**
2. **L31's equality case then applies to each.** Its statement: equality forces both arguments to have **rank $4$**, all nonzero singular values $1/\sqrt2$, and **$\mathop{\mathrm{im}}X=\mathop{\mathrm{im}}Y$**.
3. **Transitivity across the tight pairs.** $u_1$ is tight against $u_2,u_3,u_4,w_1,w_2,w_3$, so all seven share one common $4$-dimensional image $V\subset\mathbb R^n$.
4. **The contradiction, by dimension.** A skew-symmetric $Z$ with $\mathop{\mathrm{im}}Z=V$ satisfies $\ker Z\supseteq V^\perp$ and $Z(V)\subseteq V$, so $Z\in\mathfrak{so}(V)$, a space of dimension $\binom42=6$. But $u_1,\dots,u_4,w_1,w_2,w_3$ are orthonormal, hence **seven linearly independent** elements of a $6$-dimensional space. Impossible. $\square$

**This uses only L31's equality case, the vanishing pattern of the witness and $T\ge0$**, no numerics, and nothing beyond what the record already carries.

**Argued the opposite, three ways.** *Could the class-averaged $t$ hide non-tight individual caps?* No, step 1 is an average of quantities bounded above by the average's own value. *Could L31's equality case be inapplicable because orthogonality is missing?* L31 states explicitly that orthogonality is a **consequence** of equality rather than a hypothesis, and its forward direction consumes only $\lVert X\rVert=\lVert Y\rVert=1$, which orthonormal eigenvectors supply. *Could the norm convention shift the cap so that $2$ is not attained?* [conventions.md](../findings/conventions.md) line 29 fixes the record's norm and states that the constant $2$ rests on that normalisation and on nothing else; the witness's caps are computed in the same currency as (A)'s $2(n-2)$, and §2's cap-to-row-mass cross-check confirms the two are consistent.

**What this does to the lemma: nothing bad, and one thing good.**

- **The conclusion survives untouched**, because it is a statement about what a *hypothesis set entails*, not about what a $W$ does. The witness is a model of $\{$(A), (B), (C), $T\ge0$, hollow, support, pair cap$\}$ with $\theta>\theta_0(12)$, so the implication *"these hypotheses $\Rightarrow\theta\le\theta_0(12)$"* is false as a propositional implication, and no derivation drawing only on them can prove it. **A model refutes an implication whether or not the model is realized.**
- **It settles which outcome this is.** [bounds.md](../findings/bounds.md) line 544 enumerates four: (i) infeasible everywhere closes the conjecture; (ii) feasible above $\theta_0$ at a **demonstrably non-realizable** point is *the redirect*, the pinned class is insufficient and realizability is the missing ingredient; (iii) feasible at a point nobody can rule out is **no information**; (iv) feasible at a realizable point is **a counterexample to Conjecture A**. That line also demands the work *"be designed so this outcome is distinguishable from (ii) rather than reported as it."* **L173 as quoted in my brief does not say which it is.** §7 says: it is **(ii)**, and (iv) is foreclosed.

## 8. The conclusion's quantifier

**What one feasible point does establish.** That the deduction *"(A) and (B) and (C) and $T\ge0$ and hollow and support $\Rightarrow\theta\le\theta_0$"* is invalid, at $n=12$, and, by §9, at every $n\ge8$. Since a valid proof from a hypothesis set holds at every model of that set, exhibiting one model with $\theta>\theta_0$ is exactly the right shape of refutation, and one point suffices.

**What it does not rule out**, stated precisely:

- **Any bound that consumes realizability.** By §7 the witness is not realizable, so a theorem proved at *actual* unit Weyl operators, using these relations plus any consequence of $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ beyond total symmetry and nonnegativity, the Jacobi identity or first Bianchi acting on $c$ before squaring, which [bounds.md](../findings/bounds.md) line 440 names as the one open door, is untouched by this witness. **This is the substantive limitation and the word *"alone"* is what carries it**; a reader who drops that word reads the lemma as far stronger than it is.
- **Any bound consuming a further marginal or a further positivity condition on $T$** not in the list.
- **Conjecture A itself**, which stays entirely open.

**Is "support" doing work the argument has not used?** Partly. In the pinned relaxation *"support"* means that $T$'s coefficients are built from the spectrum's atoms $\nu$ with multiplicities $m$, which the value-type construction satisfies by definition rather than as a constraint, so it contributes nothing extra here. [bounds.md](../findings/bounds.md) line 432 already records that *"support"* is close to a tautology in this calculus, *"the atoms **are** the eigenvalues"*. **Its presence in the conclusion's list is harmless but not load-bearing.**

**Two omissions from the conclusion's ingredient list, both making the sentence weaker than the witness earns.**

- **The pair cap is absent, and the record's own account says it is what pins the witness** (*"without it $t_{112}$ runs to $0.8985$ and $\theta$ to $3.2020$"*). Since the witness satisfies the cap as well, the true conclusion is the stronger *"no bound proved from (A), (B), (C), positivity, support **and the pair cap** alone can close Conjecture A"*, and that is the one worth recording, because the cap is the strongest realizability ingredient the class has.
- **Hollowness is absent**, and it is load-bearing twice: for the cap coefficient of §2 and for the row coefficients $\mu_j(\mu_j-1)$.

## 9. The kernel mechanism, the edges, and the generalisation

**The mechanism, confirmed.** In (A$_i$) for $i\ne3$ the type $\{i,3,3\}$ carries weight $\mu_3(\mu_3-1)=59\cdot58=3422$ against a right-hand side of $20$, while $\nu_3=0$ deletes it from (B$_i$) (coefficient $\nu_3$) and from (C$_i$) (coefficient $\nu_3^2$). **So a zero class buys Killing row mass at no cost in the two relations that see $\theta$**, which is precisely what lets (C$_1$) close on $t_{112}$ alone and return $\Theta=7$ rather than a value $\theta_0$ constrains.

**Does it need $m_3$ large or merely $\ge3$?** *Merely $\ge3$ is not enough, and the right statement is quantitative.* The kernel's contribution to row $1$ is $m_3(m_3-1)t_{133}$, while its consumption of the $(1,3)$ pair-cap budget is $(m_3-1)t_{133}$. **The ratio is exactly $m_3$**, so with the cap budget $2$ the kernel can deliver at most $2m_3$ of row mass. Row 1 needs $2(n-2)-12=2n-16$ from it. Hence

$$\textbf{the mechanism needs } 2n-16\le2m_3,\ \text{i.e. } m_3\ge n-8.$$

Existence needs less, $\mu_3\ge2$ for the term to appear at rows $1,2$, and $m_3\ge3$ for $t_{333}$, which (A$_3$) consumes. **Here the requirement is automatic and invisible only because $m_3=\binom n2-7$ is quadratic in $n$**; decouple $m_3$ from $N$ and it binds. So the answer is: $\ge3$ for the mechanism to exist, $\ge n-8$ for it to be strong enough, and the tie $N=\binom n2$ is what makes the second free.

**The edge at $m_3=3$ exactly.** Holding the witness's support and $m_1=4$, $m_2=3$: (B$_1$) still forces $t_{112}=\tfrac23$, so the kernel must supply $2n-16$, and the $(1,3)$ cap reads $(2n-16)/m_3$. At $m_3=3$ that is $\le2$ only for $n\le11$, and $m_3=3$ forces $N=10$, i.e. $n=5$, where $2n-16<0$ and the construction dies on $t_{133}\ge0$. **So $m_3=3$ is unreachable inside this family.**

**Does the witness survive at $n\ne12$? Yes, at every $n\ge8$, and I derived the family rather than checked it.** Keep $m_1=4$, $m_2=3$, $m_3=\binom n2-7$. Then:

- $a=\sqrt{3/28}$ and $b=\tfrac43a$ are unchanged, since §4 showed both are pinned by $m_1,m_2$ alone.
- (B$_1$)'s coefficient is $\mu_1\mu_2(\nu_1+\nu_2)/a=9\cdot\tfrac13=3$, independent of $n$, so $t_{112}=\tfrac23$ always.
- (C$_1$)'s coefficient is $2\mu_1\mu_2\nu_1\nu_2/a^2=-24$, independent of $n$, so $\boxed{\theta=7a=\sqrt{21}/2\text{ at every }n}$.
- (A$_1$) gives $t_{133}=\dfrac{2n-16}{m_3(m_3-1)}$; (B$_3$) forces $t_{233}=t_{133}$; (A$_2$) then forces $t_{222}=2$; and (A$_3$) gives $t_{333}=\dfrac{2n-4-14(2n-16)/m_3}{(m_3-1)(m_3-2)}$.

At $n=12$, $m_3=59$: $t_{133}=\tfrac8{3422}=\tfrac4{1711}$ and $t_{333}=\tfrac{20-112/59}{3306}=\tfrac{1068}{59\cdot3306}=\tfrac{178}{32509}$, **the record's witness falls out of the derivation, both values on the nose.** Nonnegativity needs $n\ge8$; the caps read $(1,3)=(2,3)=(2n-16)/m_3\le2$, which is $(n-1)(n-2)\ge0$, always true. **I screened the whole system at $n=8,9,10,11,12,14,20$ in exact rationals: nine relations, six caps and ten nonnegativities pass at every one.**

**And it beats $\theta_0$ at every dimension, not just $n=12$.** $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is increasing in $n$ with supremum $2$, while $\theta^2=\tfrac{21}4=5.25$. **So $\theta=\sqrt{21}/2$ exceeds $\theta_0(n)$ at every $n$, by a factor of at least $\sqrt{21}/(2\sqrt2)=1.6202$.** The lemma's conclusion is therefore not a $n=12$ phenomenon and should be recorded at $n\ge8$.

## 10. What would break it

Ranked by how much a transcription error there would cost:

1. **The coefficient $\mu_1\mu_2(\nu_1+\nu_2)$ in (B$_1$).** It is the *only* thing pinning $t_{112}=\tfrac23$, and $t_{112}$ is the *only* thing entering (C$_1$), which is the *only* relation carrying $\theta$. Change it and $\theta$ moves directly. **This is the single load-bearing number in the lemma.**
2. **The pair-cap coefficient at $(1,1)$, namely $m_2=3$ against $t_{112}$.** The cap reads exactly $2$; it is the constraint the record says pins the witness, and a coefficient error there is precisely what a tight cap hides. §2's cap-to-row-mass cross-check is what rules this out, and it is why I ran it.
3. **$m_2=3$ itself.** $t_{222}=2$ needs $m_2\ge3$ and the $(2,2)$ cap reads $(m_2-2)t_{222}=2$; at $m_2=4$ the same $t_{222}$ would give a cap of $4>2$ and the witness would be infeasible. **The witness is feasible only because $m_2$ is exactly $3$.**
4. **$\nu_3=0$.** Any nonzero third eigenvalue puts the $3422$-weighted term back into (B) and (C) and the mechanism collapses.
5. **The claim $t_{133}=t_{233}$**, which (B$_3$) forces and which the record displays as an equality rather than deriving.

Least dangerous: $t_{333}=\tfrac{178}{32509}$ and the $(3,3)$ cap, both slack by a wide margin, and neither touching $\theta$.

## What I recommend the record do

1. **Add the pair cap and hollowness to the conclusion's ingredient list.** The witness satisfies both, so the stronger sentence is free and the cap is the ingredient a successor most needs to see foreclosed.
2. **Record the non-realizability of §7**, and with it that this is outcome **(ii)** of [bounds.md](../findings/bounds.md) line 544 (the redirect) rather than (iii) or (iv). The line's own instruction is that the two be distinguished rather than conflated.
3. **State the lemma at $n\ge8$**, with $\theta=\sqrt{21}/2$ constant in $n$ and $\theta_0(n)<\sqrt2$ for all $n$.
4. **Repair `row2_B`** so it states (B$_2$) ($12\cdot(-1)\cdot\tfrac23+2\cdot\tfrac43\cdot2=-\tfrac83$) and **add a nonnegativity theorem**, or delete that clause from the docstring. Naming the witness once as a tuple and reading it in every theorem would close the class of error that produced `row2_B`.

**Overall verdict: PROVEN, hypotheses corrected.** The arithmetic is exact and complete, the conclusion holds and generalises, and the corrections are to the conclusion's ingredient list, to what the record says the witness *means*, and to the Lean file.

## Postscript, written after the verdicts were fixed

[L173.lean](../lean/HamiltonsCubic/Results/L173.lean) was rewritten in the working tree while this review was being written, and its new docstring records **three** defects in the version I audited, found by both Gate 2 reviewers. I found two of them, `row2_B` mislabelling row 3's cancellation as (B$_2$), and the docstring's unbacked nonnegativity claim. **I missed the third, and it is the sharpest of them.**

**`unit_norm` and `theta_closed_form` were vacuous.** Each hypothesised `a ^ 2 = 3 / 28` for `a : ℚ`, and $3/28$ is not the square of a rational, $\sqrt{3/28}=\sqrt{21}/14$, and $21$ is not a perfect square. So the hypothesis is unsatisfiable over $\mathbb Q$ and both theorems held for the empty reason. **I read both statements, checked that their arithmetic was the arithmetic the lemma needs, and did not ask whether their hypothesis had a model**, which is the one question an unsatisfiable hypothesis is caught by. The repaired file drops `a` entirely and states $4+3(\tfrac43)^2=\tfrac{28}3$ instead, which is the right shape: it asserts the coefficient that *forces* $a^2=\tfrac3{28}$ rather than assuming a rational $a$ that does not exist.

**This does not move any verdict in the table above.** §4 and §5 of this report derive the forced parameters and $(7a)^2=\tfrac{21}4$ over $\mathbb R$ by hand, and both hold; the defect was in what the kernel established, not in what the lemma claims. It does sharpen row 12: the version I audited machine-checked **eight of nine relations and two vacuous parameter theorems**, so the audit surface was thinner than even my finding said.
