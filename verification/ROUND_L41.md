# Round L41, a $\lambda$-weighted identity, and the bound it gives

**Id:** L41 · **Date:** 2026-09-07 · **Verifiers:** v227, v228, v229 · **Brief:** [BRIEF_L41.md](BRIEF_L41.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 603-607 |
| the landscape statement | [results.md](../results.md) line 190 |
| the block | [findings/target.md](../findings/target.md) lines 696-708 |
| a neighbouring lemma's hypothesis, quoted for that clause alone | [results.md](../results.md) line 617 |

## The findings from phase 0

**Both identities are stated without a normalisation, and homogeneity says they cannot hold without one.** Under $W\mapsto tW$, $\lambda_\gamma\mapsto t\lambda_\gamma$ and $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2\mapsto t^2g_\gamma$, **so $\sum_\gamma\lambda_\gamma g_\gamma$ is homogeneous of degree three while $\theta=P(W)/\lVert W\rVert^3$ is homogeneous of degree zero.** *The same argument makes $\sum_\gamma g_\gamma=4(n-1)$ a degree-two claim against a constant.* **So both hold at one scale only, and no copy says which.**

**The record already knows this defect and fixed it one lemma away.** A neighbouring result's canonical statement carries *"**with $\lVert W\rVert=1$**, the identity holds at one scale only, its two sides being homogeneous of different degrees"*. **The correction reached that lemma and not this one**, which is the source-repaired-copy-not shape this audit has recorded repeatedly, here across two results rather than two files.

**One claim is universal and the block does not argue it.** *"$\sum_\gamma g_\gamma=4(n-1)$ on all of $\mathcal W_n$, critical or not"*, **stated only in the canon, absent from the block**, and it is what turns the identity into a bound.

**The block is again in the report's LaTeX**, `\[…\]`, and carries no annotations at all, the third block in three rounds that does not render where it lives.

## What the verifiers are asked beyond the standing list

Whether $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ follows in two lines from $A(W)=2W$ and the definition of $\#$, **and at what normalisation**; whether $\sum_\gamma g_\gamma=4(n-1)$ holds on all of $\mathcal W_n$ and by what argument; whether the bound $\theta\le\lvert\lambda_{\min}\rvert\frac{4(n-1)-\Delta-G_0}4$ follows, **and whether $\Delta$ and $G_0$ are defined anywhere**; whether the equality case is exactly $g$ supported on the $\lambda_{\min}$ eigenspace; and **whether the equality case really is [L70](../findings/bounds.md)'s in other coordinates**, as the canon asserts.

**And the kernel**: $G_0$ is mass on $\ker W$, so this lemma's bound depends on an object the record's recurring trap is about. *Ask what the bound says at a padded critical point.*

## Adjudication

**Verdicts: [v227](VERIFY_v227.md), [v228](VERIFY_v228.md), [v229](VERIFY_v229.md) all `BROKEN`. Round verdict: `BROKEN`, repaired, impact `NARROWS`.** *Unanimous, and the mathematics survives every one of them: what broke is three clauses of how the record states it.*

### The scale question, and the record already held the answer

**All three derived the corrected forms and all three found them already tabled.** $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ **are what [conventions.md](../findings/conventions.md) carries**, so the canon contradicted its own conventions file. *The neighbouring lemma's repair (insert $\lVert W\rVert=1$), is right in kind and does not fix the second clause, which explicitly reaches off the sphere and needs the $\lVert W\rVert^2$ factor instead.*

**The bound is the worst of the three and its failure is not cosmetic.** Its bracket mixes $4(n-1)$ at degree zero with $\Delta$ and $G_0$ at degree two, **so it changes sign.** *Screened here exactly*: at $2\times$ padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$ the bracket reads $44-128=-84$ and the bound asserts $\theta\le-17.15$.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | both identities' scale | degree three and two against degree zero | 3/3 | **`BROKEN`**, corrected forms written |
| **C2** | the bound's scale | bracket mixes degrees, changes sign | 2/3 | **`BROKEN`**, witness screened |
| **C3** | the equality clause | only-if fails; the kernel is unconstrained | 3/3 | **`BROKEN`**, true class $E_{\lambda_{\min}}\oplus\ker W$ |
| **C4** | the L70 identification | different equality sets | 3/3 | **`BROKEN`**, and the entry double-counted |
| **C5** | *"in two lines"* | they close, from three unnamed inputs | 3/3 | `CONFIRMED`, inputs named |
| **C6** | criticality | stated; used only as a carrier of $\lVert W\rVert=1$ | 3/3 | `CONFIRMED` |
| **C7** | $\Delta$, $G_0$, $A(W)$ | defined elsewhere, elsewhere, and nowhere in [findings/](../findings/) | 3/3 | `CONFIRMED`, tabled |
| **C8** | *"saturates on L23's family"* | | 3/3 | **`PROVEN`**, one line |

### C3, and the correction was already written down somewhere else

**The exact slack is $\sum_{\lambda>0}\lambda_\gamma g_\gamma+\sum_{\lambda<0}(\lambda_\gamma-\lambda_{\min})g_\gamma$, which constrains nothing on $\ker W$**, $G_0$ having been subtracted already. So the only-if half fails and the true class is $E_{\lambda_{\min}}\oplus\ker W$. *Witness in closed form, reached independently by all three*: padded $W_{\mathbb{CP}^2}$ has $\Delta=0$ by $U(2)$-invariance and one negative eigenvalue, so equality holds at every $n\ge5$ **with $G_0=4(n-4)$ units of mass on the kernel**, $0$ at $n=4$, $16$ at $n=8$, $32$ at $n=12$.

**The clause is [L107](../findings/bounds.md)'s, correct for its own weaker bound and copied onto this sharper one.** *And [bounds-relaxations.md](../findings/bounds-relaxations.md) already records that it should read $E_{\min}\oplus\ker W$.* **So this is the source-repaired-copy-not pattern for the seventh time in this audit**, the correction existed, in a third file, and reached neither of the two that state the lemma.

### C4, where the entry contradicts itself three sentences apart

**L41's equality is blind to the $\mathfrak m\times\mathfrak m$ bracket mass, which is the whole of L70's condition.** L41 saturates *automatically* on all of [L23](../results.md)'s subalgebra family, since $\mathrm{ad}(v)$ commutes with $\Pi_{\mathfrak h}$ for $v\in\mathfrak h$ and $g$ vanishes on $\mathfrak h$, **while L70 separates the balanced sphere products from that same family**, its own table showing the maximal tori slack by $1.29$ to $3.43$, and $W_{\mathbb{CP}^m}$ at $m\ge3$ missing L70's equality by $2(m-2)\theta$. *The canonical entry's own closing sentence asserts the saturation and its identification clause denies it.* **Citing the two as one piece of evidence double-counts**, and the live risk one verifier names is transporting [L71](../findings/bounds.md)'s rigidity onto $\mathbb{CP}^3$.

### What the round leaves standing

**No proof of L41 existed on the record**; the provenance note pointed at a section asserting *"in two lines"* over a numerical table. **The two lines do close** (all three reconstructed them), from $A(W)=2W$, Petersen–Wink Proposition 1.7 with the orthonormality it supplies, and the total symmetry of $T$, with [L153](../findings/bounds.md) additionally carrying the $4(n-1)$ claim. *Four ingredients used, none named.* All are now in the block.

### What is not repaired here

**Nothing.** Every finding was a correction and all are applied, the block rewritten out of the report's LaTeX, the hypotheses stated, both identities restored to their scale-covariant forms, the equality class fixed, the L70 identification withdrawn, and $\Delta$, $G_0$ and $A(W)$ tabled with the factor-two collision named.

