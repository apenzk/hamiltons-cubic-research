# ROUND L145, the entry the whole block now rests on

**Id:** L145. **Source:** [findings/second-order.md](../findings/second-order.md):1098–1124. **Date:** 2026-09-05. **Verifiers allocated:** v48, v49, v50. **Phase:** 1, dispatched.

**Why this id, promoted above four queued rows at the user's direction.** [ROUND_L149-F](ROUND_L149F.md) refuted L149's boxed $r_n\gtrsim n^{-1-\beta}$ and left $r_n\gtrsim n^{-3/2}$, **L145's own order**. So after ten rounds the chain's surviving bound is the one L145 stated before L146–L158 existed, and **L145 is the only weight-bearing entry in the block that no round has read.**

**The round therefore answers two things at once**: whether L145 holds, and whether the eight entries built on top of it add anything to it.

**There is no canonical form.** [results.md](../results.md) carries no L145 entry, and the absence is a question rather than a given.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Is $\Theta(n^{-3/2})$ proved, in both directions?** A $\Theta$ is an upper and a lower bound. **Check each separately**, and say which of the two the constant chain actually establishes.
2. **What does L145 need from the entries that came after it?** If its proof cites L146–L158, the block is not merely decoration on it and the dependency runs both ways. **If it does not, say what L145 stands on alone.**

## The brief as dispatched

*Provenance stripped, mathematics verbatim.*

#### Lemma L145, the balanced-orbit tube radius is $\Theta(n^{-3/2})$, and the constant chain that gives it

*Migrated from [I2](../plan.md)'s ingredient (2) on 2026-09-03, where the chain lived as plan prose and its load-bearing step lived only in a prior review. an audit: a prior review and a prior review, independently on identical briefs.*

> **LEMMA L145.** *At the balanced product $W^*=S^m\times S^m$, $n=2m$, the penalised functional's tube radius about $SO(n)\cdot W^*$ is $r_n=\Theta(n^{-3/2})$.*

**Steps 1, 2 and 4 are CONFIRMED by both reviewers; step 3 is REFUTED by both.**

| step | status |
|---|---|
| the spectrum is two-valued with no kernel, so $g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\Theta(1/n)$ | **CONFIRMED**, recomputed cold twice |
| $W\mapsto W_-$ is analytic on the ball of radius $g_n$ in the record's Frobenius norm | **CONFIRMED**; the complex radius must be $\rho<g_n/2$, not $\rho=g_n/2$ |
| the Cauchy estimate gives $C_\delta=O(n^3)$ | **REFUTED**, two independent errors |
| $r_n=\Omega(n^{-3/2})$ | **CONFIRMED as a lower bound.** *The equality reading is withdrawn: [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) removes its support, and $\Theta(n^{-1})$ is reachable* |

> **THE CORRECTED CONSTANT IS $C_\delta=O(n)$, NOT $O(n^3)$.** Two errors compounded: the Cauchy supremum is $M=O(g_n)$ rather than $O(1)$, giving $\lVert A^{(k)}\rVert=O(n^{k-1})$; and $C_\delta$ is $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$, whose first term **vanishes at $A(0)=\mathrm{Alt}(W^*_-)=0$**. *That $\mathrm{Alt}(W^*_-)=0$ is genuinely about $W^*_-$ and not merely $W^*$: $W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$, three Bianchi tensors.*

**The three exponents are three different quantities, which is why the plan appeared to contradict itself.** $n^{-4}$ is $c_n$ over the retracted $C_\delta=O(n^3)$; $n^{-2}$ is the direction-uniform quotient $c_n/\sup_H C(H)$; and $n^{-3/2}$ is $\inf_H c(H)/C(H)$, **which is what a tube radius is**.

**Where the norm is spent, and it is worth $n^2$.** On the input side nothing is lost, since $\lVert E\rVert_{op}\le\lVert E\rVert_F$ puts the Frobenius ball inside the operator-norm ball. The loss is on the output: converting $\lVert W_-\rVert_{op}=O(g_n)$ by rank costs $\sqrt{\binom n2}\asymp1/g_n$, and spending it gives $M=O(1)$, $A'''=O(n^3)$ and $r_n=n^{-4}$. **Keeping Frobenius on the perturbation alone**, through $\lVert ABC\rVert_2\le\lVert A\rVert_\infty\lVert B\rVert_2\lVert C\rVert_\infty$, gives $M=O(g_n)$ and $C_\delta=O(n)$.

> **THE PER-DIRECTION-TO-NEIGHBOURHOOD TRAP IS NOT COMMITTED, AND BOTH REVIEWERS CHECKED IT SEPARATELY.** The object is an **infimum** over directions, not a supremum; every ingredient is uniform in $H$, Cauchy using only $\lVert H\rVert=1$; and the geodesic segments from the orbit **fill** the tube by invariance, so nothing is extended from rays and no normal-injectivity hypothesis is owed. *The refuted family of claims took per-direction limits with uncomputed radii, which is the distinguishing feature.*

**The two reviewers disagree on one consequence, and the disagreement is live.** a prior review holds that the defect-cubic branch caps the chain at $n^{-3/2}$ **even with $\sup\lvert P\rvert=O(1)$**, so the exponent is pinned by $(c_p=\Theta(1/n),\lVert A''\rVert=O(n))$ alone and [I31](../plan.md) provably cannot move it. a prior review holds that this is **conditional on an unpriced fact**: the analyticity radius used throughout is direction-blind, being $\Theta(\min(1,g_n/\lVert H\rVert_{op}))$ along $H$, and where $\lVert H\rVert_{op}\asymp g_n$ the disc is $\Theta(1)$ and $\lVert A''\rVert=O(1)$, on such directions the defect-tail branch stops capping and the cubic branch $c_p/\lVert P\rVert_\infty=\Theta(n^{-1})$ takes over.

> **DECIDED BY [LEMMA L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects), FOR a prior review.** *On the summand carrying the margin, $\lVert H\rVert_{op}=O(n^{-1/2})=o(1)$, which is the test a prior review set. So $\lVert A''\rVert=O(1)$ rather than $O(n)$ (the input a prior review named as its own point of failure), the defect branch stops capping, and the radius below becomes a lower bound with an exponent of room in it rather than an equality.* **[I31](../plan.md) buys an exponent, not a constant.**

## Phase 1, returns

- **v49** · `BROKEN` · [VERIFY_v49.md](VERIFY_v49.md).

**Pre-registered question 1: the $\Theta$ is only a lower bound, and the entry does not distinguish the directions.** *Nothing in L145 bounds $r_n$ above; every estimate it carries is an upper bound on a constant sitting in a denominator.* **Its own step-4 row withdraws the equality while the heading and the box still say $\Theta$.** The box fails under all three senses of "tube radius" the record uses, under the first it would assert a violator at distance $\asymp n^{-3/2}$, *which is a refutation of Conjecture L16*; under [L141](../findings/second-order.md)'s $r_n:=c_n/C$ the entry's own constants give $n^{-2}$; under L145's own $\inf_Hc(H)/C(H)$ it is a lower bound by construction.

**Pre-registered question 2 overturns this round's premise.** *The exponent $-3/2$ needs a coupling forbidding a direction from being both low-margin and high-remainder, **which is [L149](../findings/second-order.md)'s sentence, four entries later**, and L149 then cites L145 as though L145 had established it.* **Not a logical circle, but each points at the other for a warrant that sits in exactly one.** *So L145 is not the block's load-bearing entry: the load is on L149 over [L143](../findings/bounds.md).*

**What L145 does establish, all reproduced by hand:** $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$ exactly, with $\lvert\lambda_-\rvert<\lambda_+$ at every $m$; analyticity on the Frobenius $g_n$-ball; the third-derivative identity; $\mathrm{Alt}(W^*_-)=0$ with its Bianchi reason; and **$C_\delta=O(n)$, retracting the plan's $O(n^3)$, its real contribution.**

**Defects.** The $O(n)$ account is wrong though the bound holds, *"two independent errors" is one fact used twice*, $M=O(g_n)$ being the $\mathrm{Alt}$ fact read through the 1-Lipschitz bound. **The quantifier makes the displayed object zero**: only $\lVert H\rVert=1$ is imposed, so at an orbit-tangent $H$ the infimum is $0$, and at $H=W^*$ it is $-1.854$ at $n=12$. $n\ge12$ and the crossover are used and unstated, *L147 and L149 inherited that omission from here.* A decision box is contradicted at source by all three entries it leans on, with no withdrawal mark.

**On the canonical form:** the [results.md](../results.md) absence is **correct**, since canonising the box would install the refuted $\Theta$. **What is wrong is the indexes**, [INDEX-results.md](../findings/INDEX-results.md):164 and [plan.md](../plan.md):66 both carry $\Theta(n^{-3/2})$ under "Gate 2 passed" and "DONE".

**Held for v48 and v50.**

- **v48** · `HYPOTHESIS-DEBT` · [VERIFY_v48.md](VERIFY_v48.md). *"L145 proves a constant chain and does not prove its own headline."*

**It reaches v49's core independently and sharpens the reason.** The upper half of the $\Theta$ is argued nowhere on the record, and **the chain cannot yield one at all**, every ingredient bounds a denominator above or a numerator below, so it can only push $r_n$ up. *The entry distinguishes the two directions in its table and not in its box, **and the box is what [INDEX-results.md](../findings/INDEX-results.md):164 propagated.***

**On the dependency the two readers differ in wording and agree in substance.** v48 lists three imports from later entries, the step-4 withdrawal and the closing decision box are [L146](../findings/second-order.md)'s, the uniformity over directions is [L149](../findings/second-order.md)'s, and calls none of them circular, since **L145's positive content cites no later entry.** *Standing alone it has the spectrum and $g_n$, the analyticity ball, $\mathrm{Alt}(W^*_-)=0$, $C_\delta=O(n)$ at the base point, and the three-exponent distinction.*

**Two named objects where the box is false.** With $\mu=(n-2)/(2(p-1)(q-1))=1/(m-1)$ at the balanced product: $\mu=\tfrac12$ at $m=3$ gives margin zero, so $r_6=0$; $\mu=1$ at $m=2$ gives margin $-\tfrac32\theta_0$, so $r_4=0$. **$c_p=3\theta_0/(n-2)$ is the strict minimum only from $m\ge5$**, and *the block's three entries carry three different floors: none, $m\ge3$, and $m\ge6$.*

**The load-bearing step is an uncomputed infimum.** $n^{-3/2}$ is stated as $\inf_Hc(H)/C(H)$ and never computed, and $c(H)$, $C(H)$, $c_n$, $c_p$, $M$, $A$ are used and never defined. *Doing the minimisation by hand, $f(u^*)=2u^*/a$ is $\Theta(n^{-3/2})$ only for $\sup\lvert P\rvert=O(\sqrt n)$ and $\Theta(n^{-2})$ at $\sup\lvert P\rvert=\Theta(n)$*, **so step 4 needs [L143](../findings/bounds.md), which L145 does not cite, and fails under L107.**

*On the canonical form both readers agree the absence is correct for the statement as written, since entering the box would canonise a withdrawn claim; v48 adds that it is wrong as a resting state, the canon holding L133, L140 and L154–L158 and none of L141–L153.*

- **v50** · `BROKEN` · [VERIFY_v50.md](VERIFY_v50.md). Third independent agreement, and the sharpest statement of the dependency: **"the eight later entries carry L145's proof, not the reverse."** *No $r_n=O(\cdot)$ exists in L145 or in L146–L158; the only "$\le$" on file is L147's ceiling on what the route can prove.* It adds that the closing decision box is **wrong by $\sqrt n$**, from $\lVert H\rVert_{op}=\Theta(n^{-1/2})$ one gets $\lVert A''\rVert=O(1/\rho)=O(n^{1/2})$, where $O(1)$ would need $\lVert H\rVert_{op}=O(g_n)$, which L146's own text denies, and that *"I31 buys an exponent"* is refuted, $\min(c_p/S,\sqrt{c_p}/a)$ being $n^{-3/2}$ at $\beta=0$, **the position the box decided against**. *It could not reproduce $M=O(g_n)$ from the entry's own route, nor $n^{-3/2}$ from anything in L145.*

## Phase 5, the round's verdict

**`BROKEN`, repaired. Impact: `NARROWS`.** Applied in [46db4162](../findings/second-order.md).

**Unanimous on all of it**: the $\Theta$'s upper half is argued nowhere and the chain cannot produce one; three hypotheses were used and none stated, without which the displayed infimum is exactly $0$; there was no dimension floor and the box is false at named objects; and the indexes carried the withdrawn $\Theta$ as a passed result.

### The strategic question this round was promoted to answer

**It was asked backwards, and the answer is the opposite of the premise.** *The round was opened on the reasoning that [ROUND_L149-F](ROUND_L149F.md) had collapsed the block's surviving bound onto L145, making L145 the load-bearing entry that nobody had read.* **L145 is not load-bearing. It is a statement whose proof lives in the eight entries built after it**, the minimisation is L147's, the uniformity L149's, and L145 cites L146 inside its own step-4 row.

**So the block is not decoration on L145, and auditing the `-r2` rows is not polishing.** *The corrected texts of L146, L147, L148 and L149 are where the surviving lower bound actually rests.* **The one thing L145 owns outright is $C_\delta=O(n)$**, retracting the plan's $O(n^3)$ (reproduced by all three readers), together with $g_n$, the analyticity ball, $\mathrm{Alt}(W^*_-)=0$ and the three-exponent distinction.

### Handed to the research loop

**[plan.md](../plan.md):66 carries the refuted $\Theta(n^{-3/2})$ under "DONE".** *This loop does not write there.* The findings text and [INDEX-results.md](../findings/INDEX-results.md) are corrected; the plan is not.
