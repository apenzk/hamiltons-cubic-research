# Gate 2 brief: is every directional lever contained in batch 21, and does that exhaust R28?

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from, do not import the scripts under review, and do not read the other reviewer's report. Your independence comes from your implementation, not from your instructions.

**This round audits an argument with two halves of different kinds.** One half is mathematics. The other is a claim about what a method consists of, which is not a theorem at all. Say clearly which of your verdicts apply to which, and do not let the mathematics carry the judgement.

## The setting, as a given

$\hat U,V$ are real traceless symmetric $3\times3$ matrices, $\Phi(\hat U,V)=\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle$ with $\alpha=\tfrac{15}4$, $\beta=\tfrac94$, and $T=\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$ the constraint. The Lagrange fields, **given and not under review**, are $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C\equiv\mu V-\beta\{\hat U,V\}$, each up to a multiple of $I$.

**Given, quoted verbatim from the record, and this is the sentence the whole argument turns on.** From the derivation's **batch 21**, the paragraph headed *"The condition"*:

> At a critical point the first differential of $\Phi-\mu T$ vanishes, so along any curve on the constraint surface the second derivative is $D^2(\Phi-\mu T)$ applied to the tangent vector alone, with no contribution from the curve's acceleration. Hence at every local maximum, for all traceless symmetric $X,Y$ with $3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)=0$,
> $$6\alpha\operatorname{tr}(\hat UX^2)+4\beta\operatorname{tr}(XVY)+2\beta\operatorname{tr}(\hat UY^2)\ \le\ \mu\big(3\lvert X\rvert^2+\lvert Y\rvert^2\big).$$

**Given, from batch 33** (its own paragraph, *"What the round added"*): the conjugation orbit's tangent is $X=[\Omega,\hat U]$, $Y=[\Omega,V]$ for skew $\Omega$, and that direction is one admissible $(X,Y)$ inside the condition above.

**Given, three recorded directional levers.** The conjugation orbit (batch 33). The frame variation, tangent $X=0$, $Y=[\Omega,V]$. The radial trade, tangent $X=\lambda\hat U$, $Y=\kappa V$ with $3\lambda\lvert\hat U\rvert^2+\kappa\lvert V\rvert^2=0$.

**Given, post F69's test**: a condition on the Lagrange fields can be criticality restated, and the test is to substitute the field's own form.

## The block under review, quoted verbatim from disk

> **Proved: every DIRECTIONAL lever is contained in batch 21.** [...] **So any lever that picks a tangent direction and computes the second variation along it IS batch 21 evaluated there**, hence implied by batch 21 and unable to exclude anything batch 21 does not. *Three instances are now on the record, each found independently*: the conjugation orbit, the frame variation, and the radial trade. **And the first-order side is empty by post F69, now at six instances**, the Lagrange forms collapsing each stationarity condition to an identity.
>
> **Not proved, and it is a judgement rather than a theorem: that every lever of R28's mechanism is directional.** *R28 excludes an interior tangency by first and second order on the orthostochastic data, and both of those are directional.* **But "the mechanism has no other lever" is a claim about a method, not about the objects.**
>
> **The known escape is non-directional.** The value comparison of batch 29 tests $\Phi$ at the point against $\Phi$ at a different configuration of the same total norm. *It is not a local condition at all, so nothing above touches it.*

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | Batch 21's condition holds for ALL traceless symmetric tangent $(X,Y)$, along any curve, with no acceleration term | mathematics |
| 2 | A lever that picks a tangent direction and computes the second variation along it is batch 21 evaluated at that direction | mathematics |
| 3 | Hence such a lever is implied by batch 21 and excludes nothing batch 21 does not | mathematics |
| 4 | The orbit, the frame variation and the radial trade are each such a direction | mathematics |
| 5 | The first-order side is empty: each stationarity condition collapses to an identity under the Lagrange forms | mathematics |
| 6 | R28 excludes an interior tangency by first and second order, and both are directional | about a method |
| 7 | Therefore R28's mechanism is spent among directional levers | about a method |
| 8 | The value comparison is non-directional and untouched by claims 1 to 5 | mixed |

## The Lean declarations, one row per claim

Every claim has a row. A cell names the declaration that types it, or the reason none can exist. File: [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean).

| # | Lean |
|---|---|
| 1 | none: the quantification is over curves on a constraint surface, and the base layer carries no curve or surface object. `second_variation_expansion` types the expansion at fixed $(X,Y)$ and `constraint_expansion` the tangency, neither the quantifier |
| 2 | none: it quantifies over LEVERS, which is not a type in the layer. Its instances are typed individually, per row 4 |
| 3 | none as stated, being row 2's consequence. For the radial instance `radial_elimination` with `radial_trace_binding` give the implication concretely |
| 4 | orbit: `orbit_equals_batch21`, which carries a named `sorry` for three trace rearrangements. frame: `frame_first_order_vacuous` and `frame_bracket_identity`. radial: `radial_elimination` and `radial_trace_binding` |
| 5 | `orbit_first_order_vacuous` and `frame_first_order_vacuous` type two of the six collapses. The general statement quantifies over conditions and is not a proposition |
| 6 | none: a claim about what a route's mechanism consists of, which is not a proposition about matrices |
| 7 | none: same, and it is the block's own stated judgement rather than its mathematics |
| 8 | none: that a comparison of two configurations is not a directional condition is a statement about a method, not an identity |

## What to do

1. **Claim 1 is the load-bearing given and you should test it rather than accept it.** Does the quoted sentence really give the condition at every tangent direction, or only along curves of some restricted kind? Is the "no contribution from the curve's acceleration" step correct, and what does it need?
2. **Claim 2 is where a reader is most likely to nod.** It sounds like a definition. Ask whether a "directional lever" could compute something other than the second variation, for instance a higher-order term, a constrained extremum along the direction, or a quantity that is not a derivative at all, and whether such a thing would still be inside batch 21.
3. **Claim 4**: verify each of the three is genuinely tangent, and check the frame direction's tangency in particular, since $\operatorname{tr}(\hat U[\Omega,V])$ is not obviously zero.
4. **Claim 5**: apply post F69's own test. Are all six collapses of the same kind, or does one of them survive substitution?
5. **Claims 6 and 7 are NOT mathematics and should not be graded as if they were.** Decide whether the block is right to call them a judgement, and whether it has drawn the line in the correct place. If you think either is actually provable, say how. If you think the block understates or overstates what it has, say which.
6. **Claim 8**: is the value comparison genuinely outside the reach of claims 1 to 5, or does some tangent direction reproduce it?
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**The most useful thing you can do is find a lever of a different shape.** If a fourth kind of condition exists that is neither directional nor a value comparison, the block's conclusion is wrong and naming it is worth more than any verdict.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts. *The test is whether you can say in advance what it will cost and what it will decide.*

**Report.** Write `reviews/REVIEW_r<N>.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit that file by path only**, never `git add -A` and never `git commit -a`. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files every row after the last report lands, so neither reviewer publishes verdicts where the other will read them.

**Log** to `agent_logs/<task-name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state, and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.
