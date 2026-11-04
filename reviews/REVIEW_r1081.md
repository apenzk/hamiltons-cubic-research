# Review r1081, Gate 2, second reader on I73's `attackable` grade

**Reviewer**: r1081. **Date**: 2026-09-23. **Role**: SECOND READER on H1, single reader on H2 to H5. **Footing**: analysis only. Nothing here needed a sweep, a census or an unbounded hunt. The two runs used were a type-check of one file already on disk and repeated calls of one hook function on copies of [plan.md](../plan.md), both seconds of compute on objects in hand.

**Did I read [REVIEW_r1080.md](REVIEW_r1080.md) before forming my H1 view?** NO. The view below was formed from [plan.md](../plan.md), the rubric in [research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md), [routes.md](../routes.md), [the R-A note](2026-09-23-I73-route-RA.md), [lean/INDEX.md](../lean/INDEX.md) and the git history of the table. I have still not read r1080's H1 section.

| claim | verdict |
| --- | --- |
| H1, I73 `attackable` 2 is honest | **REFUTED**, the honest value is 1 |
| H2, the moment identity and its Lean | CONFIRMED, with two caveats |
| H3, the claim that this is new | PLAUSIBLE, and the screen looked at the wrong neighbour |
| H4, the gate fixes | CONFIRMED as tested, and the sentinel cannot see the H1 failure |
| H5, I111 at `attackable` 1 | CONFIRMED |

## H1, the grade is inflated. REFUTED

### Three files in this repository say sub-step (ii) is open, and the grade cell says it is done

The row justifies 2 by *"sub-steps (i) and (ii) are done and typed"*. Sub-step (ii), as [plan.md](../plan.md) itself defines it in the I73 bullet, is *"ask whether second-order optimality ([L24](../findings/second-order.md)) forces $\langle W^\#,X\rangle=0$ for such $X$"*. That question is unanswered, and the record says so in three places.

- **[routes.md](../routes.md)**, which [plan.md](../plan.md) names as *"the owner of every route's status"*, gives R30's status as *"sub-step (i) done and typed"* and then, in its own words, *"Sub-step (ii) is open and the record's own warning is against it"*.
- **[The R-A note](2026-09-23-I73-route-RA.md)** closes with *"Sub-steps (i) and (ii) reduced; the question sub-step (ii) poses is NOT answered."* Reduced is not done, and the note is the author's own.
- **[lean/INDEX.md](../lean/INDEX.md)** labels [I73MomentIdentity.lean](../lean/HamiltonsCubic/Results/I73MomentIdentity.lean) as *"I73 (route R30, sub-step ii)"* and in the same row lists what it leaves out as *"whether second-order optimality forces the scalar to vanish, which is the open question"*.

That last row is the mechanism of the inflation. A file that restates the target was filed under the row-name of the sub-step whose question it does not touch, and the grade cell then read the row-name. What was actually spent is sub-step (i) plus a second reformulation of the same statement.

### Even granting the premise, the scale gives 1

Set the factual error aside and ask what R30 contains. Stripped to its content it is four statements of one condition: $W^\#\in\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$, $W^2\in\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$, a degree-2 minimal polynomial, and now $\mathop{\mathrm{Tr}}(W^4)=\mathop{\mathrm{Tr}}(W^3)^2+1/N$. All four are equivalent to I73's conclusion. None of them is a mechanism for proving it.

The one named proving step is that second-order optimality forces the condition, and the route's own entry-state section records the prior against it before spending anything: [second-order.md](../findings/second-order.md) line 200 has $S^3\times S^3$ at $\lambda_{\max}=\theta/2$ exactly with excess $9$, so L24 is tight there and still does not pin the structure, and line 202 caps the trace route. R30's own abandon column then names what a successor owes: *"a successor must test the THIRD-order condition against $\Phi$ rather than L24"*. An instrument a successor must go and find is the scale's 1, *a route must be invented*.

### The plan applies exactly this standard to three other items, in the same table

- **I111**, one row below: *"Lifting it has NO NAMED ROUTE, which is `attackable` 1 by the scale"*, with the explicit gloss *"the ansatz half being spent does not supply one"*. Spent-ness is refused as a source of a route there and accepted as one here.
- **I68**: *"three routes in are closed ... so a method must be invented"*, graded 1.
- **R32** in [routes.md](../routes.md): *"`attackable` 1: no named mechanism yet carries it"*, for a route that is named, registered and held open.

I can construct the reading under which 2 survives, and I reject it. It runs: R30 is a live named route chosen by the user, sub-step (i) is genuinely spent, therefore *a route exists and is partly spent*. Under that reading any item carrying a named reformulation scores 2 forever, since there is always something restated and something left. The same table refuses that reading one row down.

### What 3 and 1 would require

- **3, a route exists and is untried**, would require a mechanism that has not been run. R30 has none, so 3 was never available, and the sweep's justification *"the reformulation is untried"* was the wrong argument for any number.
- **1, a route must be invented**, requires that the step which would yield the conclusion is not in hand. It is not. **1 is the honest value.**

### The second promotion, which no one has disclosed

The commit message of [d18f0cdb](../plan.md) confesses I73's move from 1 to 2 in the turn the gate went quiet. It does not mention that **I36 moved from `attackable` 1 to 2 in the same rewrite**, [983ad608](../plan.md), on the ground that it *"Inherits R-A's route through I73"*. Two things are wrong with that.

- **I36's own bullet still reads `Grade **3** ($3\times1\times1\times1$)`**, at [plan.md](../plan.md) line 142, while its table row reads `3 | 2 | 1 | 1 | 6`. The table and the prose for one item disagree, today, in the live file.
- **An inherited route is not an independent one.** I36's two links are I75, whose remaining content the plan says *"IS I73"*, and I74, which is *"blocked on an unbounded census"*. If I73 is 1, I36 is 1, which is what I36's own bullet says.

### What this costs, which is the reason to fix it rather than argue it

I ran [\_unreachable\_top](../.claude/hooks/loop_stop.py) against copies of the table. The brief's stake is **out of date**, and in the direction that makes the correction cheap.

| table | top row | gate |
| --- | --- | --- |
| live, as shipped | I73, value 6, closes 3 | quiet |
| live with I73 alone at `attackable` 1 | I36, value 6, closes 3 | **quiet** |
| live with I73 and I36 both at 1 | value 3, closes 3 | **quiet** |
| at [983ad608](../plan.md) as shipped | value 6, closes 3 | quiet |
| at [983ad608](../plan.md) with I73 and I36 restored to 1 | I111, value 4, closes 2 | **FIRES** |
| before the rewrite | I111, value 6, closes 2 | **FIRES** |

Two readings follow, and both matter.

- **In the turn the gate went quiet, the two promotions are exactly what bought the silence.** Restoring them at that commit makes the gate fire. The suspicion the brief was written on is correct as history.
- **Today it no longer is.** r1080's regrade of I111 from 4 to 2 removed the only non-closer that could top the table, so correcting I73 and I36 to 1 leaves the gate quiet on its own merits. **The honest grade is now free**, which removes the last reason to defend the inflated one.

### One observation I am not scoring against the row

I73 scores `closes` 3 against a remaining open statement written as *"$\theta\le\sqrt{3/2}$ at every non-diagonal critical point"*, while I73 is a statement about a global maximiser. Strictly those are different objects. The rubric's own check list settles it in I73's favour, *"a conjecture about a maximiser is not one about every critical point ... a supremum over the whole critical set proves something strictly harder than required"*, so the mismatch is in the head-of-section statement rather than in the row. Worth a line in [plan.md](../plan.md), not a regrade.

## H2, the moment identity. CONFIRMED, with two caveats

**The mathematics is right, and it is Bessel's inequality.** With $W\perp\mathrm{Id}$ and $\langle W,W\rangle=1$, the orthogonal projection of $W^2$ onto $\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$ is $aW+(1/N)\mathrm{Id}$ with $a=\langle W^2,W\rangle$, so the residual has squared norm $\langle W^2,W^2\rangle-a^2-1/N$. [residual\_normSq](../lean/HamiltonsCubic/Results/I73MomentIdentity.lean) states exactly that and [span\_iff\_moment](../lean/HamiltonsCubic/Results/I73MomentIdentity.lean) converts vanishing residual to vanishing scalar through `inner_self_eq_zero`.

**The file type-checks clean.** `lake env lean HamiltonsCubic/Results/I73MomentIdentity.lean` exits 0 with no output, so no `sorry` and no error.

**The normalisations are the right ones and I checked them against the record rather than against the note.** [conventions.md](../findings/conventions.md) line 46 tables $N=\binom n2=\dim\Lambda^2\mathbb R^n$, line 157 gives $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$ for the operator on $\Lambda^2$ at unit norm, and line 93 gives $\sum\mu=0$. So $\langle W^2,\mathrm{Id}\rangle=\mathop{\mathrm{tr}}(W^2)=\langle W,W\rangle=1$ is forced, and `hsqI` is not doing hidden work. It is the same number as `hWW` under the one convention, which is why nothing is being smuggled in.

**The disclaimer holds.** The file says it does not state the equivalence to a two-value spectrum, does not state that a maximiser satisfies it, and says nothing about $\#$. All three are true of what is typed. **Criticality really is unnecessary for the equivalence**, and the file is stated over an abstract inner-product space, so this is visible rather than asserted.

**An independent consistency check passed.** Using criticality, $W^\#=\theta W-W^2$ gives $\langle W^\#,W\rangle=\theta-a$ and $\langle W^\#,\mathrm{Id}\rangle=-1$, so the residual of $W^\#$ against the same span is $\lVert W^\#\rVert^2-(\theta-a)^2-1/N$. Substituting $\lVert W^\#\rVert^2=\theta^2-2\theta a+\mathop{\mathrm{Tr}}(W^4)$ returns $\mathop{\mathrm{Tr}}(W^4)-a^2-1/N$. The two residuals agree, as they must.

**Caveat one, a docstring claim that is not typed.** The file's docstring glosses `E = 0` as `W² ∈ span{W, Id}`, and that equivalence is not among the two theorems. The forward direction needs $\langle sq,W\rangle=a$ and $\langle sq,\mathrm{Id}\rangle=1$ to pin the coefficients, which is three lines and true, and the "What is NOT stated" section does not list it. **Fix it by typing it or by adding it to that list.**

**Caveat two, and it is the one that matters for the route.** The resulting scalar $\mathop{\mathrm{Tr}}(W^4)-\mathop{\mathrm{Tr}}(W^3)^2-1/N$ is a function of the $\Lambda^2$ spectrum and of nothing else. [routes.md](../routes.md) states R30's whole rationale as *"The record holds machinery for $\Phi$ ... and NONE for a spectrum, which is the whole content of the reformulation"*. Sub-step (ii)'s output spends that rationale back: it returns the condition to a statement in spectral invariants, the class the route was chosen to leave. That does not make the identity wrong and does not make it useless. **It does mean the step moved along the route's axis in the direction the route was picked to avoid**, and "reducing it to one scalar" should not be read as progress toward a mechanism.

## H3, novelty. PLAUSIBLE

**The record does not carry this identity.** I queried by object rather than by the author's words: `W^4` across [findings/](../findings/), [reviews/](../reviews/) and [lean/](../lean/), `minimal polynomial`, `two-value`, `span\{W`, and residual and projection language. Nothing carries $\mathop{\mathrm{Tr}}(W^4)=\mathop{\mathrm{Tr}}(W^3)^2+1/N$ or the residual of $W^2$ against $\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$. The nearest forward-direction statement is [fence-posts.md](../findings/fence-posts.md) line 429, that a two-eigenvalue spectrum's minimal polynomial reduces a $\{2,2,0\}$ moment to pinned patterns, which is the easy half and is not quantified.

**The F23 screen is correct as far as it goes.** [Post F23](../findings/fence-posts.md) concerns the absence of a linear relation among five degree-four invariants at $n\ge6$. The new statement is a non-linear condition of degree six in $W$, so the two genuinely do not meet, and the note's reasoning on that point is sound.

**But the screen looked at the wrong neighbour, which is the recurring failure this claim was flagged for.** The closer object is [LIT-invariants.md](LIT-invariants.md), lines 89 and 112, which already carries

$$\lVert W^\#\rVert^2=\theta^2\lVert W\rVert^2-2\theta\mathop{\mathrm{tr}}W^3+\mathop{\mathrm{tr}}W^4 \quad\text{at a critical point,}$$

recorded there as [R14](../routes.md)'s circularity trap, that $\lVert W^\#\rVert^2$ collapses to $(\lambda,\theta)$ on the critical locus. The new scalar is that quantity minus $(\theta-a)^2+1/N$, one line away. **The record therefore already held $\mathop{\mathrm{Tr}}(W^4)$, its critical-locus identity, and the fact that quantities of this shape are spectrum-determined at a critical point.** R14 does not refute the new claim, because the scalar is the target rather than free data. It does mean the honest framing is narrower than "screened with no prior hit": what is new is the *characterisation* of the two-value locus by that scalar, on a record that already had the scalar's ingredients and a standing warning about their behaviour on the critical locus.

**So the claim as written in the note is defensible.** *"The underlying inequality is elementary and is not claimed as new; what is new is the link"* is an accurate and modest statement, and it is the first novelty claim in this stretch of the record that survives a reverse-containment check. **The screen should name R14 and [LIT-invariants.md](LIT-invariants.md) beside F23.**

## H4, the gate fixes. CONFIRMED as tested, and it cannot see H1

I exercised [\_unreachable\_top](../.claude/hooks/loop_stop.py) directly on copies of the table.

| input | result |
| --- | --- |
| live [plan.md](../plan.md) | `None`, quiet |
| every item row given one extra numeric column | `("PARSE", 21, 0, [])`, loud |
| a literal pipe inside one row's `moves` cell | `("PARSE", 21, 20, [])`, loud |
| I111 raised to value 6 at `closes` 2 and placed ABOVE I73 | `None`, quiet, correctly taking I73 |
| the same tie with I111 below I73 | `None`, quiet |

**All three claims hold.** The row-count check catches column drift, the product check catches a field read from the wrong column, and the `(value, closes)` key takes the closer out of a tie regardless of typing order.

**The break, and it is not a parser bug.** One self-consistent fabricated row steers the verdict in either direction with no PARSE.

- `| **I999** | a node | 2 | 3 | 2 | 1 | **12** |` inserted above I73 makes the gate FIRE, top `I999` at value 12 and `closes` 2.
- `| **I999** | settles the goal | 3 | 3 | 2 | 1 | **18** |` makes it go quiet permanently, top `I999` with `closes` 3.

Neither trips PARSE, because both are internally consistent. **The sentinel validates the table's arithmetic against itself and nothing else**, so it is exactly as strong as the honesty of the numbers, which is the H1 question. That is inherent to reading a self-reported table and I am not calling it a defect. **What I am calling a defect is that the live table already contains an instance**: I36's row says `attackable` 2 while I36's own bullet says $3\times1\times1\times1$, and no check in the file compares a row to its item's prose. A cheap check that would have caught both the I36 drift and, at [983ad608](../plan.md), the I73 promotion: **parse each item's `Grade **v** ($c\times a\times m\times x$)` from its bullet and require it to equal that item's table row.** The plan writes both, so the redundancy is already there and nothing reads it.

**One ranking remark.** I73 and I36 are tied at `(6, 3)` today, which the `(value, closes)` key does not break, so the winner is still the first row typed. It happens to be the intended one. If the tie is meant to break toward the warrant, as I36's bullet says it does, the key needs a third component or the plan needs to stop tying them.

## H5, I111 at `attackable` 1. CONFIRMED

**By the scale, 1 is right.** What is owed is lifting the equal-$N_i$, equal-$u$ ansatz, and no mechanism is named for it. [The minus-branch note](2026-09-22-I111-minus-branch.md) line 65 says *"Lifting the ansatz is the next item and is not this one"*, and [post F75](../findings/fence-posts.md) scopes the invertibility of $\theta-2L_{q_a}$ to the equal-$u$ diagonal, with nothing proposed for extending it. That is *a route must be invented*.

**Nothing in the record supplies a named route that would make it 2.** I looked for one on the ground that a lift usually reuses the input it generalises. The only candidate is the raw Gram bound $\sum_iu_i^2\le\tfrac53t$ worked off the diagonal, and [post F75](../findings/fence-posts.md) closes that direction on its own evidence: off the equal-$u$ diagonal a single $u_i$ reaches $\sqrt{5t/3}$ and $\theta-\sqrt3u$ is negative across the whole window, at $-0.527$, $-0.310$ and $-0.087$. So the one reusable instrument fails off the ansatz.

**A case exists for 0 and I am not making it.** If the raw-Gram direction counts as a named route, it is closed, which is the scale's 0. I read it as an input rather than a route, so 1 stands. The distinction changes nothing downstream, since both leave I111 at value 2 or below and out of the top.

## What I would have the session do

1. **Set I73's `attackable` to 1, value 3**, and set I36's to 1, value 3, which is what I36's own bullet already says. The gate stays quiet at those values, so this costs the session nothing.
2. **Rename [lean/INDEX.md](../lean/INDEX.md)'s row 98** off "sub-step ii". The file is a reformulation of the target, and the label is what let the grade cell read as true.
3. **Add R14 and [LIT-invariants.md](LIT-invariants.md) to the novelty screen** in [the R-A note](2026-09-23-I73-route-RA.md), beside F23.
4. **Put the bullet-versus-row grade check into [loop\_stop.py](../.claude/hooks/loop_stop.py)**, since the plan already writes the grade twice and nothing compares them.
5. **Type or disclaim** the docstring's `E = 0 ↔ W² ∈ span{W, Id}` in [I73MomentIdentity.lean](../lean/HamiltonsCubic/Results/I73MomentIdentity.lean).
