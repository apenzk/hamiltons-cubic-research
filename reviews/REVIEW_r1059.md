# Review r1059, I104 step 8's second link, is its slack zero at the equality case

Reviewer r1059, sole reviewer, comparison round against fixed text ([2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), section added in b56ee8ec) and one script's output ([screen_I104_step8_second_link.py](../scripts/misc/screen_I104_step8_second_link.py), rerun here, every row reproduced).

Log: [agent_logs/r1059-i104-second-link.log](../agent_logs/r1059-i104-second-link.log)

## Verdicts

| claim | verdict |
|---|---|
| Claim 1, the second link's slack is ZERO at the conjecture's own equality case, so the source cannot close I104's $0.0148$ | **REFUTED AS ARGUED.** The named equality case lies outside I104's stratum and outside I104's own equality set, so the premise is a category error. *The CONCLUSION survives on a replacement derivation given below, which is a size argument from the file's own Gram forcing and not a location argument.* |
| Claim 2, the $0.0148$ match is a coincidence | **CONFIRMED**, on the commit clock: the shape row predates the deficit figure by 39 minutes. *One correction to the deficit's stated provenance.* |

## Attack items

| item | question | verdict |
|---|---|---|
| 1 | does a sphere product lie in the I104 stratum, two nonzero block components and $\tau>0$ | **NO**, and the claim's central step falls with it |
| 2 | is the relevant equality set the conjecture's or I104's own chain's | **I104's own**, and the rubric reads the opposite way from the claim's use of it |
| 3 | is $(1,-0.3,-0.7)$ hand-picked, and does the screen price the chain at $0.02$ | **YES to both**, and the screen's $0.02$ is itself stale |
| 4 | is the claim vacuous, no admissible shape far from $(2,-1,-1)$ | **NO**, the shape is free at other surviving configurations and pinned only at the deficit-carrying one |
| 5 | does "a successor needs a source nonzero at the sphere-product shape" follow | **NO**, it overstates on both the locus and the modality |

## Item 1, the stratum excludes the sphere product, and excludes the chain's equality case too

**The sphere product is diagonal.** [L120's decomposition](../findings/second-order.md) makes $\mathcal D_n$ the $\Gamma$-fixed subspace, and [second-order.md](../findings/second-order.md) reads *"no diagonal critical point is a maximiser, vacuously, the balanced sphere product included"*, so the balanced sphere product sits in $\mathcal D_n$ with EVERY block component zero. [I104](../plan.md) quantifies over points with **two nonzero block components**. So no sphere product is in the stratum, at any $n$.

**And it could not be, because it violates I104's conclusion.** $\theta_0(n)^2=2(n-1)(n-2)/n^2$ ([problem.md](../findings/problem.md)) is $1.5278$ at $n=12$, against I104's $\theta^2\le\tfrac65$. *A sphere product inside I104's stratum would refute I104 rather than saturate it.*

**The object where the second link IS tight is a third thing again.** [L220](../findings/second-order.md) step 9: equality forces $r=0$, $\lVert\nu\rVert^2=\tfrac12$ and $q=t(2,-1,-1)$, and the configuration is **padded $W_{\mathbb{CP}^2}$ on $Q$**, which the lemma names explicitly. That carries ONE nonzero block, so it is outside I104's stratum as well. *The record does call $(2,-1,-1)$ "the $S^2\times S^2$ shape", at step 7, and that naming is sound as a statement about a four-set sectional shape. What does not follow is that a configuration carrying that shape IS the conjecture's extremal object.*

**So the claim's load-bearing sentence, "$(2,-1,-1)$ IS THE SPHERE-PRODUCT SHAPE, WHICH IS THE CONJECTURE'S OWN EXTREMAL OBJECT", moves from a shape of one projection to an identification of the whole tensor.** *This is the file's own recorded naming trap, one section up, in a second instance: there it was the shared-channel $x_i$ against L220's sectional $(x,y,z)$, here it is a four-set shape against a global object.*

## Item 2, the rubric says the opposite

**[research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md) line 227, quoted:** *"Score margin against the conjecture's own equality set, not against zero... Intrinsic sharpness scores $1$; $0$ is reserved for an item saturated on a family WIDER than the goal's equality set."*

**So saturation at the conjecture's equality case is exactly the case the rubric scores $1$.** The claim reaches for $0$ using the property the rubric names as scoring $1$, and would zero the margin of every route to a sharp conjecture, which is the failure mode that sentence exists to prevent.

**And the record already disagrees with the claim.** [plan.md](../plan.md)'s grading table carries I104 at margin $\mathbf1$, unchanged by b56ee8ec, so the record now holds "margin $0$ in the rubric's sense" and a margin of $1$ in the rubric's own table.

*Separately, I104's own equality set is what governs, and I104's conclusion $\theta^2\le\tfrac65$ is saturated nowhere the record has located: its target is strictly below the conjecture's $\tfrac32$ and strictly below L220's sharp bound.*

## Items 3 and 4, where the second link is pinned and where it is free, and this is the replacement argument

**The conclusion is right at the configuration that carries the deficit, and the reason is the Gram bound rather than the sphere product.** [Post F70](../findings/fence-posts.md) fixes that configuration: $t=0.346$, $u$ pinned to $[0.437539,0.438432]$. Three facts about it, all from numbers already in these files:

- **The upper pin IS the Gram bound.** $\sqrt{5t/9}=0.4384315$ to seven digits, so $u=0.438432$ is exactly where $\sum_iu_i^2\le\tfrac53t$ saturates.
- **The file's own joint-system forcing then pins the shape.** $S_2=\sum_ix_i^2\ge(3u^2-t)/1.2$ gives $0.190268$ at the lower pin, the figure the file already carries, and with $\alpha_i=\sqrt3x_i$ the normalised shared-channel coefficient obeys $x/u\ge0.575579$ against $1/\sqrt3=0.577350$. **Slack at most $0.001771$, and exactly $0$ at the upper pin.**
- **So the gain is priced.** $(\tfrac1{\sqrt3}-\max)\,u\,(t-u^2)\le0.001771\times0.437539\times0.154560=0.00012$, which is $0.8\%$ of the $0.0148$.

**That is post F70's kind of argument, not a new kind.** F70 retired its source at $60.8\%$ of the deficit, and this one comes in at under one percent of it. *So "this one fails on LOCATION where post F70's failed on SIZE" mis-states the contrast: both fail on size, and this one fails by two further orders of magnitude.*

**Two conditions on that pricing, and the claim states neither.** It assumes the three blocks share one $N_i$, which is the sweep's own assumption and which [commit 269f871e](../findings/LEDGER.md) already flags as owing a reviewer, and it assumes $x_i>0$. *At $x_i<0$ with $\lvert x_i\rvert/u=0.5756$ the shape is $(-0.5756,0.3269,0.2487)$ and the second link gives up $0.2505$, which is seventeen times the deficit.* **So "gives exactly nothing" is not established, "gives at most $0.00012$ where $x_i>0$" is.**

**NOT vacuous, item 4.** At the file's other recorded surviving configuration, $N_i=0.134$, $t=0.598$, $u=0.496$, the same forcing gives only $x/u\ge0.3976$, so the second link's slack there lies anywhere in $[0,0.1797]$ and is free rather than pinned. *The pinning is a property of the deficit-carrying corner alone, which is why the pricing above has to be done there and not over shapes in general.*

**One padded enumeration.** The claim reports equality *"at $(2,-1,-1)$, at its relabellings, and at $(1,-0.5,-0.5)$"*. $(1,-0.5,-0.5)$ is $(2,-1,-1)$ halved, so after the screen's normalisation it is the SAME point, and the screen carries it as a duplicate control row rather than as a fourth locus.

**One arithmetic correction that runs the other way.** The new section's $0.0104$ at $(3,-1,-2)$ matches the screen's $0.010404$, and the file's OLDER section and [r980](REVIEW_r980.md)'s own text carry $0.0105$ at the same shape. *The new section is right and the old one is off in the fourth digit.*

## Claim 2, the coincidence, CONFIRMED on the clock

**The shape row predates the deficit figure.** [r980](REVIEW_r980.md)'s report landed at `3172b5df`, 2026-09-17 02:09:01, carrying $0.0148$ at $(1,-0.3,-0.7)$ as one row of a six-shape table whose purpose was to check a numeric supremum against $\max(x,y,z)$. The deficit $0.0148$ entered at `269f871e`, 02:48:32, out of a sweep restricted to Gram-admitted configurations, worst shortfall $-0.014793$ at $N_i=0.218$. **Neither number was available to the other's author as a target**, so the agreement is a coincidence and the claim is right to say so.

**$(1,-0.3,-0.7)$ is hand-picked, confirmed.** It sits between $(2,-1,-1)$ and $(1,-1,0)$ in r980's sample and has no relation to any surviving configuration, which had not been characterised when the row was written.

**The screen does price the chain at $0.02$, confirmed**, in its closing line and in its docstring.

**Correction to the deficit's provenance.** The claim says *"the deficit comes from this file's $\tau$ ceiling"*. $\tau$ IS at its ceiling at the worst configuration, $0.0509=\tfrac12(0.218)^{3/2}$, but what moved the deficit from $0.020$ to $0.0148$ is the **Gram bound**, which excluded the old worst configuration outright. *The $\tau$ ceiling was already in force when the figure read $0.020$, so it cannot be what distinguishes the two.*

**And the screen's $0.02$ is stale.** The record corrected the deficit to $0.0148$ on 2026-09-17, and [screen_I104_step8_second_link.py](../scripts/misc/screen_I104_step8_second_link.py) still prints *"the chain is short by 0.02"* in its docstring and its closing line. *The claim cites that line as fixed text, which it is, but a reader taking the screen as current gets the superseded figure.*

## Item 5, the overstatement

**"A successor needs a source that is nonzero at the sphere-product shape" is wrong on the locus and on the modality.**

- **Locus.** The locus that binds is the Gram-saturated corner of the surviving region, which carries that shape only when $x_i>0$. *A source nonzero at $(2,-1,-1)$ and zero at that corner would close nothing.*
- **Modality.** What follows from a source vanishing on a surviving corner is that it cannot close the case BY ITSELF. A second argument that excludes the corner, or a source nonzero there used alongside this one, is untouched. *The file's own earlier section states the weaker form correctly, that a gain must survive the worst case over shapes.*

## Reach

**Every finding above is about the section b56ee8ec added to [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md) and about the numbers in [post F70](../findings/fence-posts.md), [r980](REVIEW_r980.md) and the screen.** *Nothing here is a finding about I104's chain as a whole, about L220 or L221, or about whether $\tau>0$ closes.*

**The replacement pricing in items 3 and 4 is MINE and has one reader.** *It is arithmetic on figures the record already carries, it took seconds, and it is recorded as a claim rather than as a result.* **What would settle it is the sign of $x_i$ at the surviving configuration and whether the three blocks must share one $N_i$**, the second of which the record already lists as owed.

## What I recommend

**Rewrite the section's premise, keep its conclusion.** *The conclusion that step 8's second link cannot close the $0.0148$ is right, and it is right for the reason F70 was right: at the configuration that carries the deficit the source is worth $0.00012$.* **Drop "margin $0$", which the rubric reserves for the opposite case**, and drop the sphere-product identification, which names an object the stratum excludes twice over.
