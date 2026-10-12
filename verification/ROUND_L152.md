# ROUND L152, the numerator identity, and what survives a refuted entry

**Id:** L152. **Source:** [findings/second-order.md](../findings/second-order.md):1453–1473. **Date:** 2026-09-05. **Verifiers allocated:** v43, v44, v45. **Phase:** 1, dispatched.

**Why this id, and why it was demoted first.** L152 is already marked `REFUTED AS STATED`, and the queue put it below L156–L158 on the ground that a round on a refuted entry buys less than one on a live entry. **It comes up now because what survives it is load-bearing**: [L156](../findings/second-order.md)'s proof imports "L152's surviving half", $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, and three rounds have taken that identity as given. *A refuted entry with a surviving clause is more dangerous than a refuted entry, because the clause is cited without the refutation.*

**There is no canonical form.** [results.md](../results.md) carries no L152 entry, so this round has one form only, **and the absence is itself a question**: a numbered result with no canonical statement is either correctly excluded or silently missing.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Is the surviving identity actually proved here, and at what generality?** $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ is used elsewhere as a general fact about the contour. **Check whether the entry proves it, whether it needs $\lambda_-$ real and negative, and whether it holds when $\Gamma$ encircles $0$.**
2. **Does the refutation reach the whole entry, or only the constant?** The heading says the identity holds and the constant it was built into has no range. **Verify both halves independently**, a correct identity inside a refuted entry is exactly what gets cited without its context.

## The brief as dispatched

*Provenance stripped, mathematics verbatim.*

#### Lemma L152, REFUTED AS STATED: the numerator identity holds, the constant it was built into has no range, and the disagreement it claimed to resolve was never one

*Derived 2026-09-03 to settle the live split recorded above. *

> **WHAT SURVIVES:** $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, the numerator identity below, for any complex centre. **WHAT FALLS, IN TWO PLACES.** *The constant it was built into is stated with no range and is false outside it*: $W^*$ is symmetric, so $\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert=1/(d\,g_n)$ with $d=\min(\alpha,D-\alpha)$ and $D=\tfrac{2m-1}{m-1}$, while a prior review and this lemma both use $1/(\alpha g_n)$ unconditionally, valid only for $\alpha\le D/2$, and **at a prior review's own optimum $(\tfrac43,\tfrac23)$ at $m=6$ the true constant is $17.9$ against the recorded $3.5$.** *And the disagreement it claimed to resolve was never one*: a prior review never estimates $\max_\Gamma\lvert\zeta\rvert$, its $\tfrac m{m-1}$ is $\lVert W^*\rVert_{op}/g_n$ multiplying the **second** term of a prior review's decomposition $A=\mathrm{Alt}(-\Pi(z)(W(z)-W^*)-(\Pi(z)-\Pi(0))W^*)$, where it is exact. **Two valid bounds by different routes, and a prior review stays inside $\alpha<1<D/2$, so it never commits the resolvent error.** *The claimed $20\%$ gap is the $\alpha\to0$ limit; at the true optimum it is $9.5\%$.* **The corrected constant and the optimum are [Lemma L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour).***

**The Riesz representation, with every factor named.** $W_-=-\tfrac1{2\pi i}\oint_\Gamma\zeta\,(W-\zeta)^{-1}\,d\zeta$, the contour $\Gamma$ enclosing **the negative spectrum only**. At $W^*$ that spectrum is the single eigenvalue $\lambda_-$, with $\lvert\lambda_-\rvert=g_n$ by definition of the gap. Taking $\Gamma$ the circle of radius $\alpha g_n$ about $\lambda_-$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$,

$$\lVert W_-\rVert\;\le\;\frac1{2\pi}\cdot\underbrace{2\pi\alpha g_n}_{\text{length}}\cdot\underbrace{\max_\Gamma\lvert\zeta\rvert}_{\;}\cdot\underbrace{\max_\Gamma\lVert(W-\zeta)^{-1}\rVert}_{\;}.$$

> **THE NUMERATOR IS $\max_\Gamma\lvert\zeta\rvert$, AND ON A CIRCLE ABOUT $\lambda_-$ IT IS $\lvert\lambda_-\rvert+\alpha g_n=(1+\alpha)g_n$.** *So the numerator is set by the eigenvalue the contour **encloses**, together with the contour's own radius.* **a prior review's $\tfrac m{m-1}$ is $\lambda_+/g_n$**, the **positive** eigenvalue, which $\Gamma$ does not enclose and whose magnitude therefore never bounds $\lvert\zeta\rvert$ on $\Gamma$.

> **AND THE ADMISSIBLE RANGE OF $\alpha$ IS RECORDED THREE WAYS THAT DO NOT AGREE.** a prior review puts the supremum at $\alpha\to1$ unattained; the agreed list above says *$\alpha$ may exceed $1$*, since $0\notin\operatorname{spec}(W^*)$ and the contour need only separate $\lambda_-$ from $\lambda_+$; and a prior review's optimum near $(\tfrac43,\tfrac23)$ **uses $\alpha>1$**. *The two candidate constraints are $\alpha<1$, which is separation from $0$, and $\alpha<\tfrac{2m-1}{m-1}$, which is separation from $\lambda_+$ at distance $\lvert\lambda_+-\lambda_-\rvert=\tfrac{2m-1}{m-1}g_n$.* **Which one binds decides the optimisation, and the record currently supports both.** *Owed with L152's own an audit.*

**Where $\lambda_+$ does enter, and where it does not.** It fixes the *admissible* $\alpha$: the contour must separate $\lambda_-$ from both $0$ and $\lambda_+$, so $\alpha<1$ keeps $0$ outside and $\alpha<1+\tfrac m{m-1}$ keeps $\lambda_+$ outside, the first binding. **It constrains the range of $\alpha$; it does not appear in the numerator.** *That is the whole of the disagreement.*

**Consequence.** $C(\alpha,\gamma)=\dfrac{1+\alpha}{\alpha-\gamma}$, and the two derivations agree asymptotically because $\tfrac m{m-1}\to1$, *which is why the error was invisible at large $n$ and worth $20\%$ at $n=12$, the dimension the programme works at.*

> **ONE CHECK THE TWO HAVE ALREADY PASSED TOGETHER, AND IT FAVOURS THIS READING.** a prior review computed $M\le6\rho$ at $(\alpha,\gamma)=(\tfrac12,\tfrac14)$. Here $\tfrac{1+\alpha}{\alpha-\gamma}=\tfrac{1.5}{0.25}=6$ **exactly**, while $\tfrac{\alpha+m/(m-1)}{\alpha-\gamma}$ returns $6$ only in the limit. *Three independent computations meet at one value.*

**What this does not settle.** The optimisation over $(\alpha,\gamma)$ is still open, and $\alpha<1$ excludes the optimum a prior review locates near $\alpha=\tfrac43$, *so either that optimum uses a contour enclosing $\lambda_+$ as well, which is a different projection, or it is outside the admissible range.* **A successor settles that before optimising.**
## Phase 1, returns

- **v44** · `PROVEN, hypotheses corrected` · [VERIFY_v44.md](VERIFY_v44.md).

**The surviving identity is true and asserted, not derived**, no line of argument is on file. It needs **neither $\lambda_-$ real nor negative, and no constraint on $\alpha$**: it survives $\Gamma$ encircling $0$ unchanged. What it does need is $\lvert\lambda_-\rvert=g_n$.

**And that is the hypothesis the entry hides.** [Line 1459](../findings/second-order.md) says $\lvert\lambda_-\rvert=g_n$ *"by definition of the gap"*. **It is not a definition**, $g_n$ is L145's analyticity radius $\operatorname{dist}(\operatorname{spec},0)$, so the equality is a theorem, needing $\lambda_+>\lvert\lambda_-\rvert$, i.e. $\dim E_->\dim E_+$. Trace-freeness gives $m^2\lvert\lambda_-\rvert=m(m-1)\lambda_+$, so it holds on the balanced family at every $m\ge2$. *Calling it a definition is what makes $\ker W^*=0$ invisible.*

**Two clauses fail outside the recorded refutation.** The "Consequence" is a `GAP`, the four-factor $ML$ bound gives $\tfrac{\alpha(1+\alpha)}{\alpha-\gamma}g_n$, a bound on $\lVert W_-\rVert$, where $C$ needs five factors, and at the entry's own checkpoint its display returns $3g_n$ against the $\tfrac32g_n$ claimed. *That is [ROUND_L156](ROUND_L156.md)'s C1 defect, in its source.* The $\alpha<1$ ruling is `BROKEN`: [line 1467](../findings/second-order.md) calls separation from $0$ "the first binding" **three lines after its own box says $\alpha$ may exceed $1$**.

### The loose paraphrase is in this loop's own queue file

**[plan-verification.md](../plan-verification.md):21 calls the survivor "the triangle equality on a circle". That is one hypothesis short**, triangle gives $\lvert\lambda_-\rvert+\alpha g_n$, and reaching $(1+\alpha)g_n$ needs $\lvert\lambda_-\rvert=g_n$, the theorem above. *The sentence is this loop's, written when L152 was demoted.* **A queue file that paraphrases a result is a fifth copy to keep in step**, and it went out of step at the first paraphrase.

**Held for v43 and v45.**

- **v43** · `PROVEN, hypotheses corrected`, the entry staying broken · [VERIFY_v43.md](VERIFY_v43.md). Reaches v44's conclusions independently: $\max_\Gamma\lvert\zeta\rvert=\lvert c\rvert+r$ for any centre $c\ne0$, attained at $\zeta^\star=c(1+r/\lvert c\rvert)$, so the identity needs neither realness nor negativity nor any bound on $\alpha$. **On the round's central question there is no finding, [L156](../findings/second-order.md)'s citation at $\alpha^*=\tfrac{11}{10}>1$ sits inside the clause's hypotheses.** *Only the $\le$ direction is ever used downstream, and a prior review already had it; what L152 adds is the equality, which nothing uses.*

**A third broken clause, which the heading does not name.** *"Three independent computations meet at one value"* is unsupported, the record itself says one of the three inherited another's bookkeeping. **And the $\alpha<1$ ruling is false and still standing sixteen lines below the lemma that overturned it, with no forward pointer.**

**The [results.md](../results.md) absence is correct, on both readers.** That file admits a result once its audit passes; L152's refuted it, and the withdrawn L150 and L151 are absent on the same rule. **The surviving clause is a proof step of L156, not a result**, so the repair is to give L156's proof the triangle inequality with its own reason, after which L152 is cited for nothing.

- **v45** · `PROVEN, hypotheses corrected` · [VERIFY_v45.md](VERIFY_v45.md). Third independent agreement on the identity, its single hypothesis, and the `results.md` absence. **It alone found the closing dichotomy to be a false disjunction**, and the round confirmed it by direct arithmetic: at $m=6$, $\alpha=\tfrac43$, the contour of radius $\tfrac43g_n$ about $\lambda_-$ encloses $0$ at depth $\tfrac13g_n$ while $\lambda_+$, at distance $Dg_n=\tfrac{11}5g_n$, sits $\tfrac{13}{15}g_n$ outside. **Neither horn holds, and the omitted third case is where L156's whole optimisation lives.**

## Phase 2, the clustering, and phase 4, the repairs

**Unanimous, all three readers:** the identity is true and *more general than stated*; its one hypothesis $\lvert\lambda_-\rvert=g_n$ is a theorem the entry calls a definition; the $\alpha<1$ ruling is false and was still standing; the "Consequence" has no derivation here; and [results.md](../results.md)'s absence of an L152 entry is **correct**, matching the withdrawn L150 and L151.

**On the round's central question there is no finding.** *The surviving clause travels correctly*, it needs no bound on $\alpha$ and is indifferent to $\Gamma$ encircling $0$, so L156's import at $\alpha^*=\tfrac{11}{10}$ was always inside its hypotheses. **The danger was real and the damage was not.**

**Repaired in [e1f8ec4a](../findings/second-order.md):** all five clauses, plus two structural fixes, **L156's proof now carries the triangle equality with its own reason**, so L152 is cited for nothing at all; and [results.md](../results.md) stated $C(\alpha,\gamma)$ and its domain while **defining neither $\alpha$ nor $\gamma$**, so a reader of the canonical record alone could not recover the normalisation the $(1+\alpha)$ rests on.

## Phase 5, the round's verdict

**`PROVEN, hypotheses corrected` for the surviving identity; the entry stays `REFUTED AS STATED`, in three more places than its heading named. Impact: `CONTAINED`.**

### What this round adds to the block

**A refuted entry is not a closed one.** Its heading listed two failures and the entry carried five; three of those had been overturned elsewhere in the same file and left standing, one of them *sixteen lines* below the lemma that overturned it. **Nothing cites a refuted entry expecting the refutation to be complete**, which is why the surviving clause was worth this round even though it turned out sound.

**And the paraphrase problem reaches this loop's own files.** [plan-verification.md](../plan-verification.md) described the survivor as "the triangle equality on a circle", one hypothesis short, in a sentence this loop wrote while demoting the entry. *Corrected.* **A queue that paraphrases mathematics becomes another copy to keep in step**, and this one fell out of step immediately.
