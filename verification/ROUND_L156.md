# ROUND L156, the balanced-orbit contour constant and its optimum

**Id** L156 · **File** [findings/second-order.md](../findings/second-order.md), lines **1406–1440** · **Opened** 2026-09-05

**Verifiers allocated:** v28, v29, v30. **Phase:** 1, dispatched.

**Why this id.** Tier C. **It carries the constant the rest of the chain consumes** ($J$, $C$, $\gamma$ and the optimum $(\alpha^*,\gamma^*)$) and every later round has taken values from it without auditing it. *[ROUND_L149r](ROUND_L149r.md) drew its prefactor $K=\lambda(1-\eta^*)^2/(\sqrt2 J)$ from here; [ROUND_L147](ROUND_L147.md) rested a mechanism repair on its contour constant.*

**Canonical cross-check.** [results.md](../results.md) carries an L156 entry; **both forms go into the brief unlabelled**, and any difference between them is the round's first finding.

**Two pre-registered questions.** Is the optimum interior and *attained*, or approached? And is the $\gamma$ appearing in $\rho=\gamma g_n/\lVert H\rVert_{op}$ the same $\gamma$ as in $J=C/\gamma$, *a doubt raised and dismissed in an earlier round, never adjudicated*?

## The brief as dispatched

**Provenance stripped, mathematics verbatim**, per the independence rule.

```
#### Lemma L156, the contour constant corrected, and its optimum attained at the equidistant contour


> **LEMMA L156.** *At $W^*=S^m\times S^m$, with $\Gamma$ the circle of radius $\alpha g_n$ about $\lambda_-$, disc radius $\rho=\gamma g_n/\lVert H\rVert_{op}$, and $D=\tfrac{2m-1}{m-1}=\lvert\lambda_+-\lambda_-\rvert/g_n$,*
> $$C(\alpha,\gamma)=\frac{\alpha(1+\alpha)}{d\,(d-\gamma)},\qquad d=\min(\alpha,\,D-\alpha),$$
> *reducing to $\tfrac{1+\alpha}{\alpha-\gamma}$ exactly on $\alpha\le D/2$. The objective is $J=C/\gamma$, and its minimum is **interior and attained** at*
> $$\alpha^*=\tfrac{D}2=\tfrac{2m-1}{2(m-1)},\qquad \gamma^*=\tfrac{D}4,\qquad C^*=2+\tfrac{4(m-1)}{2m-1},\qquad J^*=\tfrac{4(1+\alpha^*)}{\alpha^{*2}} .$$

**Proof.** $W^*$ is symmetric with spectrum $\{\lambda_-,\lambda_+\}$, so $\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert$ is the reciprocal of $\mathop{\mathrm{dist}}(\Gamma,\mathop{\mathrm{spec}})$, which is $\alpha g_n$ while $\lambda_-$ is nearest and $(D-\alpha)g_n$ once $\lambda_+$ is, the switch at $\alpha=D/2$. The Neumann step over the disc replaces $d$ by $d-\gamma$, and the contour length contributes $\alpha$; with $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ ([L152](../findings/second-order.md#lemma-l152-refuted-as-stated-the-numerator-identity-holds-the-constant-it-was-built-into-has-no-range-and-the-disagreement-it-claimed-to-resolve-was-never-one)'s surviving half) this gives $C$. Minimising $J=C/\gamma$ over $\gamma$ maximises $\gamma(d-\gamma)$, so $\gamma=d/2$, **$\gamma=\alpha/2$ is the special case $d=\alpha$, true at the optimum and false past the kink**. Substituting, $J=\tfrac{4\alpha(1+\alpha)}{d^3}$, which on $\alpha\le D/2$ is $\tfrac{4(1+\alpha)}{\alpha^2}$, strictly decreasing, and on $\alpha\ge D/2$ is $\tfrac{4\alpha(1+\alpha)}{(D-\alpha)^3}$, strictly increasing. Both branches run toward $\alpha=D/2$, so the minimum sits there and is attained. $\square$

**What binds, and it is none of the three the record asserted.** $\alpha<1$ is **not a constraint**: $\mathop{\mathrm{spec}}(W^*)$ is two points, so a contour enclosing $0$ adds no spectral point, and the integrand $\zeta(W-\zeta)^{-1}$ is regular there, checked at the integral, the projection identification and the Neumann step by both reviewers. $\alpha+\gamma<D$ is real and **slack** at the optimum. **The binding condition is the resolvent kink**, which no party had named. *The real content of "no eigenvalue crosses $0$" is $\gamma<1$, a constraint on the disc, slack for every $m\ge2$.*

**$\alpha^*g_n=\tfrac12\lvert\lambda_+-\lambda_-\rvert$, the contour equidistant from the two eigenvalues.** *That is a prior review's recommendation 5, which a prior review quoted and dismissed as "within four per cent". It was the answer.*

**Numbers at $n=12$ ($m=6$).** $D=\tfrac{11}5$, $(\alpha^*,\gamma^*)=(1.1,0.55)$, $C^*=\tfrac{42}{11}=3.818$, $J^*=6.942$. **The gain over the frozen $(\tfrac12,\tfrac14)$ is $3.46$, not the recorded $4.8$**, and a prior review's $(\tfrac43,\tfrac23)$ gives $J=23.85$ against the baseline's $24$, **no improvement at all**, while sitting past the kink where its own formula fails. *a prior review's $M\le6\rho$ at $(\tfrac12,\tfrac14)$ is inside the regime where the recorded and corrected formulas agree identically, so it could not have seen the error; and it is not an independent third computation, r456 having stated that it inherited r441's bookkeeping.*

**COROLLARY, THE OPTIMUM'S TWO CONSTANTS LIE IN DIMENSION-FREE INTERVALS. SINGLE-AUDITED: a prior review CONFIRMED, a prior review OWED.** *Write $\alpha^*=1+\tfrac1{2(m-1)}$, which decreases to $1$; $J'(\alpha)=-4(\alpha+2)/\alpha^3<0$, so $J$ is strictly decreasing and $J^*$ therefore **increases** in $m$, to the supremum $J(1)=8$, unattained since $\alpha^*>1$ always; likewise $C^*$ increases to $4$.* **In the programme's range $n\ge12$,**

$$\tfrac{42}{11}\le C^*<4,\qquad 6.9421\le J^*<8 .$$

*Over all $m\ge2$ the intervals open at $C^*=\tfrac{10}3$ and $J^*=\tfrac{40}9$, but $m=2$ is out of scope for everything this feeds, $n\ge12$ here, $m\ge5$ in [L146](../findings/second-order.md#post-f60-withdrawn-the-two-pinned-halves-live-on-orthogonal-blocks-and-never-bind-together) and [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform).* **It is the interval that is dimension-free, not $C^*$**, which varies with $m$; *and if a single contour is wanted instead, the fixed $(\alpha,\gamma)=(1,\tfrac12)$ gives $d=1$ and hence $C\equiv4$, $J\equiv8$ at **every** $m$, one contour, no $m$-dependence, $15\%$ off the optimum.*

> **THE VALUES SIT ONE RULING AWAY FROM THEIR OPPOSITE.** Every one of them has $\alpha^*>1$, admissible only because the resolvent kink and not $\alpha<1$ is what binds ([L156](#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)). *Under the rejected $\alpha<1$ the same algebra returns $C>4$ and $J>8$, the suprema here are exactly the $\alpha=1$ values.*

**WHAT THIS DOES NOT DO, AND THE CLAIM THAT IT DID IS WITHDRAWN.** [I33](../plan.md) records *"the absolute Cauchy **constants** … and **they** decide it"*, plural; an earlier reading of this corollary made that singular and claimed to supply it. **Three constants in the chain remain open**:

- **$\sigma$ has no definition on the record.** It occurs once in all of [findings/](.), in this lemma's own closing line, with no value; the number entering $\lVert A''\rVert$ is $2J^*/(1-\sigma)^2$, not $J^*$. *It is also the **reach**, [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform)'s branch 3 written as $\rho/2$, so $\sigma=\tfrac12$ was chosen and never said, costing about $3.4\times$ at $n=12$.* **The repair a prior review supplies**: the branch-2/branch-3 crossing $t(1-\sigma)^2=\sigma$ with $t=\sqrt{c_p+w^2}/(2J\gamma)$, in which $\gamma$ cancels for small $t$, *that*, rather than the assertion below, is what legitimises splitting the optimisation.
- **Branch 1 carries no Cauchy constant at all**; its constant is [I31](../plan.md), open.
- **The $u\lesssim w$ constant** linking the two decompositions of $H$ is recorded as unknown.

*[Lemma L151](../findings/second-order.md#lemma-l151-withdrawn-it-froze-a-free-parameter-at-an-inadmissible-value-and-called-the-remainder-bounded)'s withdrawal box already states that at least nine constants enter the chain; a corollary pinning one of them does not decide a minimum taken over three branches.*

**What the objective is, which the record had never stated.** $J=C/\gamma$, from $\sup\lVert A''\rVert\le2M/((1-\sigma)\rho)^2$. **The $(\alpha,\gamma)$ half separates from $\sigma$**, so that half is the one-parameter problem L156 solves in closed form; *the claim that $\sigma$ factorises out of the whole is withdrawn, $\sigma$ being tied to the reach by the crossing condition above.*
```

## Clustering

*Phase 2, pending.*

## Adjudications

*Phase 3, pending.*

## Outcome

*Phase 5–6, pending.*

## Phase 1, returns

- **v28** · `GAP` · [VERIFY_v28.md](VERIFY_v28.md) · four findings: the factor list in the proof of $C$ falls short of the stated formula by $1/d$; the statement carries no domain; [results.md](../results.md) and the findings text disagree on whether $\sigma$ factorises; and a downstream consumer takes $J^*$ at an out-of-scope value. Both pre-registered questions answered, the optimum is attained at a corner of the domain, and the two $\gamma$ are one symbol.
- **v30** · `GAP` · [VERIFY_v30.md](VERIFY_v30.md) · the optimisation, the spectral data and all six corollary endpoints reproduced from scratch; the same four defects as v28 plus an arithmetic one. **It reads the factor shortfall in the opposite direction to v28** (v28 has the written factors giving 3 against the formula's 6, v30 has them giving 12) so the mechanism is agreed and the magnitude is not. Both pre-registered questions answered the same way as v28.

## Phase 2, the clustering

All three filed `GAP`. Clustered by the step attacked and the mechanism, never by wording.

| id | step attacked | mechanism | support |
|---|---|---|---|
| **C1** | the proof's factor list, [second-order.md:1415](../findings/second-order.md) | the written recipe carries one resolvent where the identity needs two | v28, v29, v30 |
| **C2** | $J=23.85$ at $(\tfrac43,\tfrac23)$, line 1421 | arithmetic; the exact value is $\tfrac{350}{13}$ | v28, v29, v30 |
| **C3** | the statement box, lines 1410–1413 | no domain, no $\gamma<1$, no $\lVert H\rVert_{op}\le1$, no affine model, and no inequality naming what $C$ is the constant in | v28, v29, v30 |
| **C4** | [results.md:355](../results.md) and [INDEX-results.md:175](../findings/INDEX-results.md) | both carry the $\sigma$-factorisation that [second-order.md:1439](../findings/second-order.md) explicitly withdraws; both omit $J^*$ | v28, v29, v30 |
| **C5** | line 1326 and [REVIEW_r711.md:40](../reviews/REVIEW_r711.md) | $J^*$ taken at $\tfrac{40}9$, the $m=2$ endpoint the corollary itself calls out of scope, and used at $n=12$ | v28, v30 |
| **C6** | the framing sentence at line 1439 | the surviving half ("the $(\alpha,\gamma)$ half separates from $\sigma$"), is itself false, since $\sigma=\eta^*(\Lambda/2C)$ depends on $C$ | v29 |

### C1's magnitude split, settled here by derivation rather than by count

**v28 makes the written factors give $3$ at $(\tfrac12,\tfrac14)$; v29 and v30 make them give $12$. Both readings are right about their own bookkeeping and neither changes the repair.** The three named factors are the contour length $\alpha g_n$, the maximum $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, and the post-Neumann resolvent $1/((d-\gamma)g_n)$, whose product is $\tfrac{\alpha(1+\alpha)}{d-\gamma}g_n$, a bound on a norm, carrying one power of $g_n$. Reading that as $C$ directly gives $3$; dividing it by $\gamma$ first, which is what $M\le C\gamma g_n$ requires, gives $12$. **The two differ only in where the normalising $\gamma$ is counted, and they agree exactly on the mechanism: the recipe has one resolvent where the resolvent-difference identity has two.** So the split is bookkeeping and C1 stands with unanimous support.

**What the correct assembly is.** $A(0)=0$ makes the difference available, and

$$W_-(z)-W_-(0)=\frac{-1}{2\pi i}\oint_\Gamma \zeta\,(W(z)-\zeta)^{-1}(zH)(W^*-\zeta)^{-1}\,d\zeta,$$

whose five factors are the length $\alpha g_n$, the maximum $(1+\alpha)g_n$, the *perturbed* resolvent $1/((d-\gamma)g_n)$, the perturbation $\lVert zH\rVert\le\gamma g_n$, and the *unperturbed* resolvent $1/(dg_n)$, product $\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}\gamma g_n=C\gamma g_n$, the stated $C$ exactly. **The word carrying the error is "replaces":** the Neumann step does not replace $d$ by $d-\gamma$, it introduces a second resolvent at $d-\gamma$ *beside* the one at $d$.

### What needs adjudicating

**C6 alone.** C2 is exact arithmetic reproduced three times and again by the round: at $m=6$, $d=\min(\tfrac43,\tfrac{13}{15})=\tfrac{13}{15}$, $d-\gamma=\tfrac15$, $C=\tfrac{700}{39}$ and $J=\tfrac{350}{13}=26.923$, and the entry's "no improvement at all" survives *a fortiori*, the point being 12% worse than the baseline rather than 1% better. C3, C4 and C5 are documentary and were checked at source by the round. **C6 rests on [L157](../findings/second-order.md), which is unaudited and next in the queue**, so it is adjudicated now rather than inherited.

## Phase 4, the repairs, for the five settled clusters

Applied in [ed9975ac](../findings/second-order.md). C6 is held until its adjudication returns, so [line 1443](../findings/second-order.md) is untouched.

| id | what replaced what |
|---|---|
| **C1** | the sentence *"The Neumann step over the disc replaces $d$ by $d-\gamma$"* is gone. The resolvent-difference identity stands in its place with all five factors, and $M\le C\gamma g_n$ names what $C$ is the constant in. |
| **C2** | $J=23.85$ replaced by $\tfrac{350}{13}=26.923$, with $d=\tfrac{13}{15}$ and $C=\tfrac{700}{39}$ shown. **"No improvement at all" became "12 per cent worse"**, the conclusion strengthens. |
| **C3** | the statement box gained $m\ge2$, $\ker W^*=0$, the affine model, $\lVert H\rVert_{op}\le1$, and the domain $0<\alpha<D$, $0<\gamma<\min(d,1)$. |
| **C4** | [results.md](../results.md) and [INDEX-results.md](../findings/INDEX-results.md) lost the withdrawn $\sigma$-factorisation and gained $J^*$ with the $m=2$ endpoint marked out of scope. |
| **C5** | line 1326 now names $\tfrac{40}9$ as the out-of-scope endpoint and gives $2J^*=\tfrac{1680}{121}$ at $n=12$, agreeing with line 1302, which had already caught it. |

**The record caught C5 once and repeated it anyway.** [Line 1302](../findings/second-order.md) already flagged r711's $J^*=\tfrac{40}9$ as *"L156's out-of-scope $m=2$ endpoint"*; [line 1326](../findings/second-order.md), 24 lines later in the same entry, carried the value it produced with no such mark. **A correction written at the site of the error does not reach the site of its use**, which is the same shape as the domain check that fired where a quantity was defined and not where it was consumed.

### Handed to the research loop, unrepaired here

**[plan.md](../plan.md):68 carries the withdrawn $\sigma$-factorisation**, *"factorises out of it, so the three-parameter optimisation is one parameter in closed form"*. [plan.md](../plan.md) is the research loop's file and this loop does not write to it. **The sentence is wrong in the same way [results.md](../results.md):355 was**, and it is the third copy of a claim its own source withdrew.

### Where C6 already has corroboration on the record

[Line 1302](../findings/second-order.md) states, in the entry's own words, that *"$J\gamma=C$ makes [L157](../findings/second-order.md)'s $t=\lambda\sqrt{c_p+w^2}/(2C)$ exact rather than small-$t$"*, so **the record already has $t$ depending on $C$**, which is the premise C6 turns against the separation claim. This is noted, not counted: the adjudication decides it.

## Phase 3, C6 adjudicated

- **v31** · `UPHELD` · [VERIFY_v31.md](VERIFY_v31.md). The round reproduced its closed form independently: with $s=\sqrt{1+4t}$, L157's root collapses to $\eta^*=\tfrac{s-1}{s+1}$ and $1-\eta^*=\tfrac2{s+1}$, so $d\eta^*/dt=4/(s(s+1)^2)>0$ and $\eta^*$ is strictly increasing in $t$. Raising $\gamma$ raises $C$, lowers $t$, lowers $\eta^*$ and raises $(1-\eta^*)^2$ (the factor the $J$-minimisation discards) so $\partial_\gamma(\gamma\eta^*)>0$ at $\gamma=d/2$ and the optimum moves right. **At $t=\tfrac18$ the record's own $0.808$ is the exact surd $40-16\sqrt6$**, which the round checked.

- **v32** · `UPHELD` · [VERIFY_v32.md](VERIFY_v32.md). Reached the same closed form independently and went one step further than v31 on what survives: **$\alpha^*=D/2$ is the right contour for the reach itself, not merely for $J$.** It also fixes the direction, the reach's optimum is $\gamma^\dagger$ with $\gamma^\dagger/(d-\gamma^\dagger)=\sqrt{4t+1}$, strictly above $d/2$, so $\gamma^*$ **understates** the radius and the error is conservative.

**C6 `UPHELD`, unanimous.** Two adjudicators, identical briefs, agreeing on the closed form, on the sign and on what survives.

## Phase 5, the round's verdict

**`GAP`, repaired. Impact: `NARROWS`.**

Six clusters, all repaired. **The finding that matters is C6**, and it is not an arithmetic slip: L156 solved a well-posed optimisation and then claimed it was the chain's, which it is not. Every constant the lemma states is exactly right; what was wrong was the derivation of one of them, the domain none of them was stated on, and the sentence saying which problem they solve.

**Why the chain survives.** The reach at $\gamma^*$ is smaller than at $\gamma^\dagger$, so every downstream lower bound on the tube radius computed from $J^*$ remains valid and merely loose, by $O(t^2)$, 2–4% at the recorded $t\in[0.135,0.206]$. **A defect running the other way would have been `FATAL`**, since L158's threshold is a comparison against a radius.

### What this round adds to the block's pattern

Five rounds in, the recurring shape is no longer "a wrong step". It is **a correction that does not travel**:

- [L157](../findings/second-order.md) refuted *"$\sigma$ has no definition on the record"* when it was written, and L156's block went on carrying the claim.
- [Line 1302](../findings/second-order.md) flagged $J^*=\tfrac{40}9$ as out of scope, and [line 1326](../findings/second-order.md) used it 24 lines later.
- [results.md](../results.md), [INDEX-results.md](../findings/INDEX-results.md) and [plan.md](../plan.md) each kept the $\sigma$-factorisation after its own source withdrew it.

**Three of the six clusters this round are that one failure**, and none of them is a mathematical error, each is a true correction written in one place and not in the others.
