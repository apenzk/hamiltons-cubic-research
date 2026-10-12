# ROUND L157, the reach fixed point

**Id:** L157. **Source:** [findings/second-order.md](../findings/second-order.md):1245–1271, with the canonical form at [results.md](../results.md):359–362. **Date:** 2026-09-05. **Verifiers allocated:** v33, v34, v35. **Phase:** 1, dispatched.

**Why this id.** Tier C, next in order. **Two rounds have now leaned on L157 to convict its neighbours**, [ROUND_L156](ROUND_L156.md)'s C6 was decided from L157's crossing identity and its $\eta^*(t)$, and L157's own text was used to refute L156's "$\sigma$ has no definition on the record". *A lemma that has served twice as the instrument of conviction and has never itself been audited is the one worth reading next.*

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Is the crossing root the maximiser it is claimed to be?** The statement says the two branches "cross at the unique root in $(0,1)$" and that "the minimum of the two is maximised there". Both clauses need proving, and uniqueness needs the other root shown spurious rather than asserted.
2. **Does the fixed point exist for every admissible $t$, and is $t$'s own range stated?** The entry gives $\sup_w t\to\tfrac18$ at $w=1$. **Whether that supremum is attained, and over what set $w$ ranges, is not in the statement**, and the $O(t^2)$ claims elsewhere in the chain are read against it.

## The brief as dispatched

*Provenance stripped, mathematics verbatim. Both forms are given unlabelled; a difference between them is the round's first finding.*

### Form A

#### Lemma L157, the reach parameter is determined by a fixed point, not chosen: $\eta^*=\tfrac{2t+1-\sqrt{4t+1}}{2t}$

*Derived 2026-09-05 from a prior review's crossing condition. *

**The parameter is $\eta$, and the record has always had it.** a prior review D7 defines the validity branch by exactly the coupling this entry rediscovered ($\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, hence $t\le\rho/2$) and [line 1285 above](../findings/second-order.md#lemma-l151-withdrawn-it-froze-a-free-parameter-at-an-inadmissible-value-and-called-the-remainder-bounded) carries it as *"the already-frozen $\eta=\tfrac12$"* with its constant $8$. **The first version of this lemma said the record had no definition for it; that was a search by vocabulary rather than by object**, a prior review's narrower and true observation (that the *string* $\sigma$ occurs once), widened into a false one about the *quantity*. *[Lemma L150](../findings/second-order.md#lemma-l150-withdrawn-it-is-post-f50s-chain-with-post-f50s-surviving-term-deleted)'s box records this exact failure mode.*

**WHAT IS NEW, AND BOTH REVIEWERS REACH IT INDEPENDENTLY: $\eta$ is not free, it is determined.** The bound on $\lVert A''\rVert$ must hold along the whole segment $[0,r]$, so $\eta=r/\rho$ and the branch is a **self-consistency condition** rather than a family indexed by a parameter:

$$r\;\le\;\frac{\sqrt c}{\sup_{\lvert s\rvert\le r}\lVert A''(s)\rVert}\ .$$

*Its largest solution is the crossing root below.* **a prior review D7 and a prior review A4 both declared this fixed point absent, calling the branch a cap; it exists, and that is the entry's one contribution.**

> **LEMMA L157.** *In units of $\rho$ the two coupled branches are $\eta$ and $t(1-\eta)^2$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$; they cross at the unique root in $(0,1)$*
> $$\eta^*(t)=\frac{2t+1-\sqrt{4t+1}}{2t},$$
> *the other root being its reciprocal and spurious, and the minimum of the two is maximised there. The exact identity at the crossing is*
> $$\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}\,(1-\eta^*)^2 .$$

**The $(1-\eta^*)^2$ does not drop.** *An earlier display here wrote the second branch without it and so stated a lower bound upward*, a $13$–$22\%$ overstatement at $n=12$, $20\%$ at the binding direction, and **it does not vanish with $n$**: $\sup_wt\to\tfrac18$ at $w=1$, so $(1-\eta^*)^2\to0.808$ at every dimension. *This is the error a prior review B8 already charged against [Lemma L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform), repeated.* **And $\gamma$ does not cancel**; what is true is that $J$ is *stationary* at the optimum, so $J^*$ is right to $O(t^2)$.

**Three constants inside $t$, and the record's own value for one.** Branch 2 is $\lambda\sqrt c/\lVert A''\rVert$ with $\lambda=2/\sqrt{\lvert\kappa_n\rvert}=1.53$, from a prior review D3's factor $2$ and the quartic tail's $\lvert\kappa_n\rvert$. *Every number moves with it: $t$ from $0.135$ to $0.206$ at the binding direction.* **$S$ and the $v\lesssim w$ constant remain open**, so "no free parameter left" is false.

**What freezing $\eta=\tfrac12$ actually cost.** *Not the factor $4$ first claimed.* **The binding direction is disputed and $0.829$ is refuted**: a prior review puts the minimum at the $\lVert H\rVert_{op}$ kink $w^*=0.553$, a prior review at the endpoint $w=1$ once this lemma's own $w$-dependence of $(1-\eta^*)^2$ is kept inside the minimisation, and **neither is $0.829$**, *which this entry, a prior review and a prior review all cite.* Across the range where branch 2 exists the loss is $2.9$–$3.4$, the value moving about $3\%$ with the location. *And $\lambda$ here is $2/\sqrt{\lvert\kappa_n\rvert}$ at the **finite** $n$: $\lvert\kappa_{12}\rvert=0.10159$ gives $\lambda(12)=6.275$, not the $1.53$ the $n\to\infty$ value returns ([L158](../findings/second-order.md#lemma-l158-the-branch-comparison-turns-on-one-dimension-dependent-constant-and-it-says-suplvert-prvert-must-grow-before-i31-can-bind)).* **At $w=0$ there is no branch 2 to optimise**, the defect vanishes identically there by [Lemma L148](../findings/second-order.md#lemma-l148-the-defect-vanishes-identically-on-the-margin-summand), so the regime the first version called "the one that matters" is the one where the quantity is absent. *And the reach ratio is $\Theta(n^{1/2})$, a factor $7.24$ at $n=12$, not "two orders in $n$".*

**Two couplings the first version denied.** Branches 1 and 2 are two regimes of the single $f(u)=(c_p+u^2)/(S+au)$ with $a\propto(1-\eta)^{-2}$, so **branch 1 is not untouched**, the effect is about $5\%$ and runs the safe way. And in [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour) it is the **Cauchy radius $\gamma-r$**, not $\gamma$, that wants to be $d/2$.

**One point in the entry's favour that it did not make.** At $n=12$ branch 2 beats branch 1 by about $58\times$, so branch 2 alone decides the radius and its constants are exactly what matter.


### Form B

##### Lemma L157, the reach parameter is determined by a fixed point, not chosen

The tube chain's reach parameter is the record's own $\eta$, r450 D7 defines the validity branch by the coupling $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, and second-order.md carries it frozen at $\eta=\tfrac12$. What is new is that $\eta$ is **not free**: the bound must hold along the whole segment, so $\eta=r/\rho$ and the branch is the self-consistency condition $r\le\sqrt c/\sup_{\lvert s\rvert\le r}\lVert A''(s)\rVert$, whose largest solution is the crossing root $\eta^*=(2t+1-\sqrt{4t+1})/(2t)$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$. r450 D7 and r451 A4 both declared this fixed point absent. The exact identity is $\eta^*\gamma=\tfrac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$; the factor $(1-\eta^*)^2$ does not drop and does not vanish with $n$, $\gamma$ does not cancel, and freezing $\eta=\tfrac12$ cost about $2.9$ at the binding direction rather than the factor $4$ first claimed. At $w=0$ the branch is absent, the defect vanishing identically there.

## Phase 1, returns

- **v34** · `BROKEN` · [VERIFY_v34.md](VERIFY_v34.md). The four boxed clauses are all true and **none has an argument on file**; separately the entry's $(1-\eta^*)^2\to0.808$ is refuted in closed form. $0.808=40-16\sqrt6$ holds only at $t=\tfrac18$, which needs $\lambda=1$, a value **the same entry supersedes two paragraphs later** with $\lambda(12)=6.275$. At that $\lambda$ the admissible range is $[0.390,0.536]$, entirely below $0.808$, and the correct uniform floor is $0.39017$. It independently re-derived [ROUND_L156](ROUND_L156.md)'s $\gamma^\dagger/(d-\gamma^\dagger)=\sqrt{1+4t}$ and calls it exactly right.

### This bears on the round just closed, and the exposure is noted before it is adjudicated

**[ROUND_L156](ROUND_L156.md) priced C6's cost as $O(t^2)$, "about 2–4% at the recorded $t\in[0.135,0.206]$", and that range is L157's**, the same range v34 says is read at a superseded $\lambda$. The round also checked and recorded $0.808$ as the exact surd $40-16\sqrt6$; **that arithmetic is correct and conditional on $t=\tfrac18$**, which is exactly the assumption now in question. *If v34 stands, L156's repair carries a stale $t$ and the C6 cost is understated, v34 puts the same licence at $16.4\%$ at $t=0.962$.* **Held until v33 and v35 return**; a single reader does not move a closed round.

- **v33** · `GAP` · [VERIFY_v33.md](VERIFY_v33.md). Reaches v34's refutation independently and by a different route: $2J^*\gamma^*=\tfrac{4(4m-3)}{2m-1}$, so $\sup_wt\to\lambda/8$ and **$\tfrac18$ holds only at $\lambda=1$**. At $n=12$ on the entry's own $\lambda(12)=6.27476$, $t$ runs over $[0.50036,0.96209]$. It also finds the paragraph internally inconsistent: the loss is identically $4(1-\eta^*)^2$, so *"$0.808$ at every dimension"* and *"the loss is $2.9$–$3.4$"* cannot both hold.

**The two agree on the licence in two algebraically distinct forms.** v33 gives $J(\gamma^\dagger)/J(\gamma^*)=1/(1-\eta^{*2})$, v34 gives $(1+s)^2/(4s)$; since $1-\eta^{*2}=\tfrac{2}{s+1}\cdot\tfrac{2s}{s+1}=\tfrac{4s}{(s+1)^2}$ these are the same number, and the round checked the identity. It is $1.0\%$ at $t=\tfrac18$ and $16.4\%$ at $t=0.962$.

### The round corrects its own predecessor, on two readers and its own derivation

**[ROUND_L156](ROUND_L156.md)'s repair priced C6 at "about $2$–$4\%$ at the recorded $t\in[0.135,0.206]$". That range is read at $\lambda=1$ and is wrong at $n=12$.** The round reproduced the correct range from the record's own constants, $c_p=\kappa/n=0.37081$ and $2J^*\gamma^*=\tfrac{84}{11}$ at $m=6$ give $t\in[0.50036,0.96209]$, matching both readers to five digits, so the C6 licence at $n=12$ is **about $16\%$, not $2$–$4\%$**. Corrected in [findings/second-order.md](../findings/second-order.md) and [results.md](../results.md). *The error was the round's own, introduced while repairing L156, and it is exactly the failure the same round had just written up: a superseded constant surviving in a neighbouring paragraph.*

- **v35** · `GAP` · [VERIFY_v35.md](VERIFY_v35.md). Reaches the same refutation by a third route, the entry's own *"$t$ from $0.135$ to $0.206$"* is a ratio of $1.526$, which is the $\lambda:1\to1.53$ rescaling, so the $\tfrac18$ column is visibly a $\lambda=1$ computation. **And it finds one thing neither other reader did**, recorded as D6 below.

## Phase 2, the clustering

| id | step attacked | mechanism | support |
|---|---|---|---|
| **D1** | the boxed clauses | three of the four (uniqueness, the reciprocal root's spuriousness, and the max–min property), **have no argument on file** | v33, v34, v35 |
| **D2** | the statement | none of $t>0$, $\eta<1$, $w\in[0,1]$, $n\ge12$, $\ker W^*=0$ is stated in either form | v33, v34, v35 |
| **D3** | $\sup_wt\to\tfrac18$ and $(1-\eta^*)^2\to0.808$ | both computed at $\lambda=1$, which the same entry supersedes; at $n=12$ the factor is $0.390$, not $0.808$ | v33, v34, v35 |
| **D4** | the paragraph's internal consistency | the loss is identically $4(1-\eta^*)^2$, so *"$0.808$ at every dimension"* and *"the loss is $2.9$–$3.4$"* cannot both hold | v33, v35 |
| **D5** | [results.md](../results.md) against the findings text | Form B drops uniqueness, reciprocity, spuriousness and maximality (the clauses that make its own "largest solution" true) and states the disputed $2.9$ as settled | v33, v34, v35 |
| **D6** | $t$'s numerator | it reads $\sqrt{c_p+w^2}$ where [L149](../findings/second-order.md)'s repaired numerator, forty lines above in the same file, is $\sqrt{c_p+\rho^{\text{eff}}_nw^2}$, a $12.2\%$ inflation of $t$ at $n=12$, **overstating the reach** | v35 |

**D1's arguments exist and are two lines each, and all three readers produced the same two lines**, the crossing quadratic $t\eta^2-(2t+1)\eta+t=0$ has roots multiplying to $t/t=1$, and $\eta$ rises while $t(1-\eta)^2$ falls. *That is corroboration, not a proof the record has audited*, and the round writes them in as its repair rather than adopting them as verification.

**D3 is unanimous by three independent routes**, v33 from $2J^*\gamma^*=\tfrac{4(4m-3)}{2m-1}\to8$, v34 from the $n=12$ constants directly, v35 from the entry's own printed ratio $0.206/0.135=1.526$ being the $\lambda$ rescaling. The round has already acted on it, correcting its own [ROUND_L156](ROUND_L156.md) figure in [20881fa9](../findings/second-order.md).

### D6 goes to adjudication, and it is the one that could be fatal

**Every other cluster here runs conservative or documentary. D6 runs the other way**: if $t$'s numerator should carry $\rho^{\text{eff}}_n$, then the recorded $t$ is too large, $\eta^*$ too large, and the reach **overstated**, the direction that breaks a downstream lower bound rather than loosening it. *It is also, exactly, the failure this entry was written to charge against its neighbours.* **One reader, unadjudicated. v36 and v37 decide it.**

## Phase 3, D6 adjudicated

- **v36** · `UPHELD` · [VERIFY_v36.md](VERIFY_v36.md). The two numerators are the same quantity, same $w\in[0,1]$, same $\lVert H\rVert_F=1$ normalisation, same branch, and [L158's settled box](../findings/second-order.md) writes L157's prefactor $K$ around L149's denominator **in one display**, which closes the different-branches reading. $\rho^{\text{eff}}_n=2\sqrt{3/2}-\theta_0(n)\tfrac{n+16}{2(n-2)}$ is $0.71904<1$ at $n=12$, so **L157's $t$ is too large and the reach is overstated**. The record charges the coefficient-$1$ form twice, both times against L149 and never naming L157, and nowhere states the coefficient as deliberate.

**Two amendments it makes to the candidate.** The $12\%$ is the $w=1$ figure; at L158's own settled minimiser $w_0=\tfrac23$ it is $8.7\%$. And **the scope reaches $n=16$**, $\rho^{\text{eff}}$ runs $0.71904,\,0.87239,\,0.98564,\,1.07274$ at $n=12,14,16,18$, so L149's *"unsafe exactly on $n\in\{12,14\}$"* was read off the un-penalised coefficient and misses $n=16$.

**Why the opposing effect does not rescue it.** $K$ carries $(1-\eta^*)^2$, which falls as $t$ rises; v36 re-derived the elasticity rather than citing it, getting $\mathrm d\log(Ks)/\mathrm d\log s=1/\sqrt{4t+1}\in(0,1)$, **strictly positive, so branch 2 rises with the numerator, and strictly below $1$, so the rise is damped.** An exact bracket with no integration.

### The claim that would make this FATAL, and why the round is not calling it yet

**v36 states that a downstream lower bound fails**, the branch-2 infimum is the chain's lower bound on the tube radius at $n=12$, branch 2 binds there, and its numeral $0.40347$ at [line 1318](../findings/second-order.md) is stated upward. *A `FATAL` impact re-ranks the queue, which is the user's call and not the loop's.* **One adjudicator does not establish it. Held for v37.**

- **v37** · `UPHELD` · [VERIFY_v37.md](VERIFY_v37.md). Independently reaches $\rho^{\text{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434$, exact via $6300-1800\sqrt6<2695$, and agrees on the direction, on the $8.67\%$ inflation at the binding $w_0=\tfrac23$, and on the scope $n\in\{12,14,16\}$. **It adds the provenance: L157 inherited the coefficient rather than inventing it**, L149's own chain display still carried $1$, contradicting its own margin bullet five lines above.

**Both adjudicators note the finding is robust to the open `HYPOTHESIS-DEBT` on the $\tfrac29$ penalty**: all three readings of the penalty on the record give $0.74162$, $0.71904$, $0.64003$, every one below $1$. **The sign is settled; the magnitude is not.**

**D6 `UPHELD`, unanimous.**

## Phase 5, the round's verdict

**`BROKEN`, partly repaired. Impact: `FATAL`.**

**The impact is `FATAL` because a lower bound fails at the programme's binding dimension.** [L158](../findings/second-order.md)'s branch-2 minimum $0.40347$ at $w_0=\tfrac23$, $n=12$ is a **lower bound on the tube radius**, and it is overstated by a factor in $(1,1.0867]$. Every other defect this block has produced ran conservative, loose bounds, understated reaches, wrong framings around right constants. **This one runs the other way.** The site is marked refuted in [794ab93e](../findings/second-order.md) and the corrected minimum is owed.

### What is repaired, and what is owed

**Repaired:** the coefficient at both sites that carried it wrongly (L157's definition of $t$ and L149's chain display) and the refuted numeral marked at its site with the direction, the bracket and the scope.

**Owed, and it is new mathematics rather than a correction:** the branch-2 minimum recomputed with $\rho^{\text{eff}}_n$ in the numerator, which is a fresh joint minimisation over $w$, not a substitution. **The loop does not do that**, and D1's three missing arguments are owed too, the round declines to adopt the verifiers' one-liners as audited proof.

### What survives untouched, on both adjudicators

- The order claims: $r_n\gtrsim n^{-1-\beta}$ and the $\Omega(n^{-1})$ ceiling.
- [L149](../findings/second-order.md)'s own $g_\rho\ge0.71979/n$, **its proof is the one place that already carried $\rho^{\text{eff}}_n$.**
- [L158](../findings/second-order.md)'s verdict that branch 2 binds, **which the repair strengthens**: lowering branch 2 makes it bind more surely.
- [ROUND_L156](ROUND_L156.md)'s conviction of C6, all four identities it took from L157 need only $t>0$ and the crossing equation, and all three verifiers rederived each exactly.
