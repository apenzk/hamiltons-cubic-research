# REVIEW r876 on the last three commits: the r871 fold inverts its source on relation (B), and six of the report's repairs did not land

**A text-against-text round.** I compared what the three commits wrote into the record against what their sources actually say, and **re-derived no mathematics**: the one piece of arithmetic below is a screen of a primal the source itself constructed, run to settle whether a constraint set contains a named relation, and reported as a screen. Sources read: the three diffs, [REVIEW_r871.md](REVIEW_r871.md) in full, the edited regions of [research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md) and [verification-loop/SKILL.md](../.claude/skills/verification-loop/SKILL.md), [editing-skills/SKILL.md](../.claude/skills/editing-skills/SKILL.md), [reviewer_watchdog.sh](../scripts/misc/reviewer_watchdog.sh), [plan.md](../plan.md), [routes.md](../routes.md) and [findings/diagonal-half.md](../findings/diagonal-half.md), with [findings/bounds.md](../findings/bounds.md), [lean/INDEX.md](../lean/INDEX.md), [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean) and [ATTEMPTS.md](../ATTEMPTS.md) searched for the copies items 2 and 8 ask about. Log: [agent_logs/review-r876-fold2.log](../agent_logs/review-r876-fold2.log).

## Claim table

| # | What I was asked | Verdict |
|---|---|---|
| 1 | Does the r871 fold state what r871 found? | **UNFAITHFUL ON ITS HEADLINE, FAITHFUL ON EVERYTHING ELSE.** Every other figure traces to the report. The closing claim attributes the $4.4907$ optimum to an LP over *the marginal and relation (B)*, and r871's LP carries **no** relation (B) |
| 1b | Is the inference the fold draws from that number valid? | **NO, AND IT RUNS THE INEQUALITY BACKWARDS.** Adding (B) shrinks the primal feasible set, so the (B)-augmented LP is **at most** $4.4907$. The number bounds the augmented programme from ABOVE and is cited as a floor under it |
| 2 | Does any claim r871 refuted still stand somewhere? | **THREE SURVIVING COPIES.** The retired minimax overclaim stands unmarked where it is asserted ([diagonal-half.md:1254](../findings/diagonal-half.md)), in the machine-checked file's docstring ([L203DualBound.lean:6](../lean/HamiltonsCubic/Results/L203DualBound.lean)), and the "all-within ACTIVE" reading at [diagonal-half.md:1256](../findings/diagonal-half.md) |
| 3 | Do the two promoted rules satisfy [editing-skills](../.claude/skills/editing-skills/SKILL.md)? | **COMPLIANT ON EVERY CLAUSE I CAN CHECK FROM DISK.** Failure modes, no dates, no run references, no counts, destinations govern the act, the gated-command rule is in **both** loops, both rows and both bodies deleted, incident in the notebook and not duplicated |
| 4 | Are the two promoted rules true as written? | **BOTH TRUE.** The watchdog rule matches [reviewer_watchdog.sh](../scripts/misc/reviewer_watchdog.sh) line by line, including both failure shapes. The gate rule matches the shape of the two PreToolUse hooks that enforce it |
| 5 | Do the two regrades follow the rubric? | **I76 YES, I77 NO.** I76's *closes* $2\to1$ is the scale's own "a sub-step". I77's *attackable* $3\to1$ is the one value the scale does not offer for a route the row itself calls untried |
| 6 | Is the plan's headline claim true? | **TRUE, BOTH HALVES, COUNTED FROM THE TABLE.** Maximum value is $3$, and exactly six graded items are zeroed on `attackable` alone. Every product recomputes correctly and the table is sorted |
| 7 | Does the route register row match the record? | **MATCHES ON THE FIRST LINK, OVERSTATES THE SECOND.** "No method" is exactly what the I75 block holds. "Its second link is largely proved" contradicts the same row's "two untried inputs" and I74's own grade |
| 8 | What did the folds lose? | **SIX REPAIRS, and the sharpest is the one the block still says is owed.** r871 wrote the correctly-counted per-index dual and the record's next block asks for it as an open debt |
| 9 | Anything a script would have caught | **TWO.** A missing blank line fuses two blockquote blocks into one paragraph at the line the fold edited, and the machine-checked docstring carries a retired overclaim with no index row flagging it |
| 10 | What would make this round wrong | **ANSWERED**, with the four misreadings that would falsify it and what I did to rule each out |

**One line someone can act on.** The record now says reintroducing relation (B) is known not to be a way out, on the strength of a number computed **without** relation (B), and the report it cites recommends reintroducing (B) as *the repair worth attempting*: that reading needs withdrawing in [findings/diagonal-half.md](../findings/diagonal-half.md) at two blocks, [plan.md](../plan.md), [reviews/INDEX.md](INDEX.md) and [ATTEMPTS.md](../ATTEMPTS.md), and I77's grade recomputing once the route is no longer treated as closed.

## 1. The r871 fold against r871

### 1.1 What the fold wrote

The fold's central sentence, now at [diagonal-half.md:1265](../findings/diagonal-half.md):

> **THE WHOLE RELAXATION IS CLOSED, WITH A NUMBER: even the EXACT LP optimum over the marginal and relation (B) is $11/\sqrt6=4.4907$ at $n=12$** ([r871](REVIEW_r871.md)), *above the record's standing $3.0509$, so no choice of multipliers saves it and the two failed repair attempts below were attempts at something that cannot work.*

And the successor block at [diagonal-half.md:1267](../findings/diagonal-half.md):

> **Only two ways out survive, since reintroducing (B) is now known not to be one**: add the PAIR CAP [...] *Reintroducing (B) with the best possible multipliers reaches $4.4907$ at $n=12$ and no further, which is what closes the family rather than merely bounding this attempt.*

### 1.2 What r871 says

The LP whose optimum is $4.4907$ is defined in that report's §4, and its constraint list is printed there in full:

> maximise $\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma S_{\alpha\beta\gamma}$ over $S\ge0$, $S$ totally symmetric and hollow, $\sum_{\beta\gamma}S_{\alpha\beta\gamma}=2(n-2)\ \forall\alpha$.

Nonnegativity, symmetry, hollowness, the marginal. No relation (B). §10.3 computes the optimum "of §4" at that spectrum, and states its own scope:

> **Conclusion for item 10.** Any bound whose only structural input about $T$ is L153's marginals is at least $11/\sqrt6=4.4907$ at $n=12$ [...] **What is needed is an input that couples $T$ to the spectrum, and one is already in the record and explicitly discarded here: relation (B)** [...] **The natural repair is to put (B) back in and redo the dual**, not to maximise the present bound over spectra.

And verdict item 5, the report's own statement of the surviving direction:

> **The direction that survives.** Relation (B) is linear in $T$ at fixed spectrum, so it belongs in the same LP with its own multipliers. **Adding it is the repair worth attempting.**

The record's own derivation block agrees with the report about the inputs, one screen above the fold, at [diagonal-half.md:1254](../findings/diagonal-half.md): *"No caps, no decomposability, no criticality, and **no relation (B)**."*

### 1.3 The screen that settles it

r871's §10.3 exhibits the optimal primal itself: $T_{123}=10$ at the padded $W_{\mathbb{CP}^2}$ spectrum $\lambda_1=2c$, $\lambda_2=\lambda_3=-c$, with the remaining $63$ indices carrying kernel triples. Relation (B), in the form r871 quotes, is $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$. At $k=1$ that primal gives $\lambda_2T_{123}+\lambda_3T_{132}=-10c-10c=-20c$, against the $-2\lambda_1=-4c$ the relation demands. **The optimal primal violates relation (B) by a factor of five**, so the feasible set it optimises over provably does not include (B). Reported as a screen, on an object the source constructed, and it agrees with the three textual readings above.

### 1.4 The inference, which fails in its own right

The primal is a **maximisation**. Adding relation (B) as a constraint shrinks the feasible set, so

$$\mathrm{LP}_{\text{marginal}+(B)}\ \le\ \mathrm{LP}_{\text{marginal}}\ =\ 11/\sqrt6 .$$

So $4.4907$ is an **upper** bound on what the (B)-augmented relaxation returns at that spectrum, and the record cites it as a floor under it. The direction matters here rather than academically: at that same spectrum the true $\theta$ is $\sqrt{3/2}=1.2247$, which is **below** $\theta_0(12)=1.2360$, so the padded $W_{\mathbb{CP}^2}$ spectrum is not even a candidate obstruction for a relaxation tight enough to see it. Nothing on the record bounds the (B)-augmented programme below at any spectrum, so "the whole relaxation is closed, with a number" has no number behind the half it claims to close.

### 1.5 Where the reading has spread

Five places, four of them from the audited commits:

| location | commit | text |
|---|---|---|
| [diagonal-half.md:1265](../findings/diagonal-half.md) | `1f13334e` | "the EXACT LP optimum over the marginal and relation (B)" |
| [diagonal-half.md:1267](../findings/diagonal-half.md) | `1f13334e` | "reintroducing (B) is now known not to be one" |
| [reviews/INDEX.md:1210](INDEX.md) | `1f13334e` | "reintroducing relation (B) with the best possible multipliers cannot save the line" |
| [plan.md:67](../plan.md) | `11339600` | "the exact LP optimum over the marginal and relation (B) is $4.4907$" |
| [ATTEMPTS.md:6637](../ATTEMPTS.md) | `da696832` | "the EXACT LP optimum over the marginal and relation (B)" |

The plan row is the one that does damage beyond the record's prose, because I77's regrade is built on it.

### 1.6 What the fold got right

Checked one by one against the report, all confirmed: validity as a proof rather than a survey and its reason, W's own $T$ feasible for the LP the dual bounds (§4); ten spectra screened with no violation (§4.2, ten rows); $z=1/220$ and $y=\tfrac34\,55^{-3/2}$ at $n=12$ (§6); the bound equal to $\theta_0(2p)$ identically in $p$ with the true $\theta$ of $S^p\times S^p$ recomputed independently to match (§7); tightness structural by complementary slackness, with $\operatorname{supp}T$ exactly the active types (§8); the uniform family a strict sub-family of the dual, $221/\sqrt6=90.2229$ against $11/\sqrt6=4.4907$, a factor of twenty (§8, §10.3); the mechanism, $y$ charged against the whole $T$-mass including the kernel while the truth collects only triples of three nonzero eigenvalues (§10.2c). **The $3.0509$ comparison is a sound extension rather than a quotation**: r871 states $3.8536>11/\sqrt{13}=3.0509$ and the fold applies the same comparison to $4.4907$, which holds arithmetically.

## 2. Refuted claims still standing elsewhere

**The minimax overclaim, unmarked at the point of assertion.** The fold withdraws it at [line 1265](../findings/diagonal-half.md). Eleven lines above, at [line 1254](../findings/diagonal-half.md), the derivation block still opens with it and carries no marker:

> *The programme's vertex enumeration is unnecessary: LP duality turns it into a one-dimensional minimax.*

That is the sentence r871's item 8b and verdict item 4 retire verbatim. A reader meeting the section at its head meets the withdrawn reading as the block's own framing.

**The same overclaim in the machine-checked layer.** [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean), lines 6 to 8, untouched by any of the three commits:

> LP duality turns the triangle-type programme into a one-dimensional minimax: any `y, z` with ... gives `θ ≤ ∑ λ³ + (n-2) N y`

[r873](REVIEW_r873.md) corrected that file's docstrings for the *other* retracted reading and the index row records seven omissions plus two, so the file has been audited since. This one was not on the list, and the address a reader consults for what is typed still asserts it.

**The activity reading, at one of two copies.** [diagonal-half.md:1256](../findings/diagonal-half.md) still describes the Lean file as checking "the all-within and all-cross triples both ACTIVE at $z=1/4$", which is r871's item 5b and r873's correction: the all-within class is EMPTY at $p=2$ and the binding pair is one-within-two-cross with all-cross. [Line 1260](../findings/diagonal-half.md) and the [lean/INDEX.md](../lean/INDEX.md) row both carry the correction, so the file contradicts itself four lines apart. Pre-existing rather than introduced by these commits.

**Clean:** "uniqueness included" survives only inside the two reports discussing it, the factor-of-$2.47$ framing is retired at [line 1265](../findings/diagonal-half.md) and survives only in unrelated contexts and in older reviewer files, and the "precision of the hand arithmetic" hedge is gone with the exact figures in place at [line 1256](../findings/diagonal-half.md).

## 3. The two promoted rules against editing-skills

Answered clause by clause, since this item has five parts.

**Failure mode rather than incident, and no dates, runs or counts.** Both pass. The rule as it landed in [research-loop/SKILL.md:464](../.claude/skills/research-loop/SKILL.md):

> **A COMMAND A GATE CAN REFUSE IS THE ONLY THING IN ITS CALL.** *A refused gate discards the WHOLE call, so anything chained with it never ran, and the retry repeats only the part the error names.* **The damage is not the lost work, it is that the retry SUCCEEDS** [...]

The proposal body it replaced carried "Every occurrence has been a stage or an edit placed ahead of a gated commit" and a note about the locked-mode contradiction. Both are gone from the rule and both are in [ATTEMPTS.md](../ATTEMPTS.md)'s new entry, which is where step 4 sends them. The watchdog rule likewise drops "Six occurrences, one per dispatch" and keeps the mechanism. Neither rule names a dimension, a tensor or a date.

**Destination governs the act.** The gate rule sits beside the staging and structure-gate paragraphs of research-loop's commit step and beside verification-loop's own commit paragraph. The watchdog rule sits inside the paragraph that arms the watchdog, which already links the script. Both are rules about running the loop, in the loops' own files, as step 2 directs.

**Written into both loops.** Yes, and this was the item most at risk. [research-loop/SKILL.md:464](../.claude/skills/research-loop/SKILL.md) and [verification-loop/SKILL.md:171](../.claude/skills/verification-loop/SKILL.md) both carry it, in the same imperative with the verification copy compressed. A reader of either loop meets it.

**Rows and bodies deleted, incident moved and not duplicated.** Rows 89 and 102 and both body sections are gone from [skill-proposals.md](../.claude/skill-proposals.md), and grep finds no surviving link to either anchor anywhere in the repository. The incidents are in [ATTEMPTS.md](../ATTEMPTS.md) under a new dated heading. One residue: the earlier entry at [ATTEMPTS.md:6643](../ATTEMPTS.md) still reads "Two decisions are the user's and are carried forward: proposals 89 and 102, both above the promotion bar and both held by locked mode", and the new entry does not name the entry it resolves. That is a chronology carrying its own history, which is what the notebook is for, so I record it and do not call it a defect.

**Word budget.** The commit reports 101, 70 and 69 added words. I count 100, 69 and 68. Off by one in the same direction three times, which is a counting convention rather than a discrepancy, and all three sit under the 120-word ceiling.

**One clause I cannot check from disk.** `## Report every edit verbatim` requires the turn's reply to open with `the skill has changed` and quote the delta with removed words struck through. Nothing on disk records what the reply said, so I make no finding either way.

## 4. Are the rules true?

**Rule two, against the script it names.** [reviewer_watchdog.sh](../scripts/misc/reviewer_watchdog.sh) carries `# Usage:  reviewer_watchdog.sh <stale-seconds> <log> [<log> ...]` and then `STALE="$1"; shift`. So the leading argument is the staleness threshold in seconds and a call with log paths alone consumes the first as the threshold, exactly as the rule says. Both failure shapes hold:

- **One log only.** After the shift, `"$@"` is empty, the `for` loop never runs, `alive` stays $0$, and the script prints "WATCHDOG: every watched reviewer has finished." and exits $0$ immediately. This is the rule's "watches nothing and reports success at once".
- **Several logs.** The first is consumed, so the remaining ones are watched and the first is not. Every staleness test is then `[ "$age" -gt "<a path>" ]`, which errors and returns non-zero, so the stale branch can never fire and the loop turns until the watched reviewers finish. This is the rule's "loops forever with every comparison erroring".

The script prints only on exit, so "Silence means watching; a success line seconds after a dispatch means the opposite" is right. **One detail of the proposal did not survive**: that with several logs it watches *all but the first*, so one reviewer is silently unwatched even when the arity error does not announce itself. Worth a clause, since it is the shape a reader cannot infer from "loops forever".

**Rule one.** The claim is about the harness rather than about this repository, so I checked the shape of what enforces it. [structure_gate.py](../.claude/hooks/structure_gate.py) documents itself as a `PreToolUse gate` that "blocks the commit", and [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) is the same kind of gate on the commit message. A PreToolUse denial refuses the tool call before the shell runs, so a call of the form *stage and then commit* loses the staging entirely and a retry of the commit alone lands without it. The rule is true as written, and its consequence, the retry succeeding while the tree is missing an edit, follows from the same mechanism.

## 5. The two regrades against the rubric

The rubric's scales are in [research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md) under *Grade section 1*.

**I76, from 6 to 3: follows the rubric.** The factor changed is *closes*, $2\to1$. The scale reads "$2$ a named open step $\cdot$ $1$ a sub-step", and the row's own account is that it "closes a sub-step of a route that cannot complete". The rubric also supplies the warrant rule directly: *"Score closes on the item's warrant, not on its ambition. An item whose reach depends on a recorded claim inherits that claim's label."* I76 depends on I75, which has no method, so $1$ is the scale's own answer. Product $1\times3\times1\times1=3$, as recorded.

**I77, from 6 to 2: the factor does not match its own justification.** The factor changed is *attackable*, $3\to1$. The scale is: $3$ a route exists and is untried, $2$ a route exists and is partly spent, $1$ a route must be invented, $0$ every named route is closed. The row's own text says:

> **adds** a node whose ROUTE IS NOW CLOSED: [...] so only the pair-cap variant is untried

A variant that is untried is, by the scale's own words, a route that exists. That reads $3$, or $2$ at most, since the pair cap is already spent once elsewhere in the same findings file: [diagonal-half.md:1244](../findings/diagonal-half.md) closes the $(+,-,0)$ stratum with it, *"AND THE PAIR CAP CLOSES IT EXACTLY"*. **$1$ is the single value on the scale the row's own prose excludes**, because it means the opposite, that no route exists and one must be invented. The coupled consequence is the reason this matters rather than being a quibble: at $2$ the value is $4$ and at $3$ it is $6$, and either figure falsifies the START HERE line's "nothing in section 1 now scores above $3$" and puts I77 back at or near the top. The regrade and the headline stand or fall together, and both rest on §1's misreading of what r871 closed.

**Sorting.** The value column reads $3,3,3,3,2,2,2,2,2,1,1,0,0,0,0,0,0$ down the table, monotone non-increasing. Sorted. Every product recomputes correctly in all seventeen rows.

## 6. The plan's headline claim, counted

Both halves true as recorded.

- **"Nothing in section 1 scores above $3$."** The maximum value in the table is $3$, attained by I76, I36, I73 and I68.
- **"Six of its graded items are zeroed on `attackable` alone."** Exactly six rows carry value $0$: I1, I37, I5, I3, I4 and I7. Each has *closes* $\ge2$, *margin* $\ge1$ and *analytic* $=1$, so `attackable` is the only zero in every one of them. Six, not five and not seven.

The count is honest arithmetic on the table as it now stands. It is also downstream of §5: correct the I77 factor and the first half of the claim fails.

## 7. The route register row against the record

**On the first link the row is exactly right.** [routes.md](../routes.md)'s R18 now reads **LIVE, BUT ITS FIRST LINK HAS NO METHOD**, and *"a successor must attack the FIRST link or abandon the route"*. The findings file the item points at supports both halves. [diagonal-half.md:1181](../findings/diagonal-half.md) holds the only handle on I75 and it runs the wrong way:

> **THE COROLLARY IS A TEST, AND IT IS THE FIRST QUANTITATIVE HANDLE ON [I75].** *A critical point with $\theta\lambda_{\max}>(1+\lambda_{\max}^2)/2$ carries NO orthonormal decomposable eigenbasis* [...] **No point besides padded $W_{\mathbb{CP}^2}$ is exhibited in its window, so no new exclusion is demonstrated yet**

An exclusion test certifies the absence of the eigenbasis. The link needs its presence at a maximiser. So "no method" describes the record accurately, and the START HERE line's "fails at the threshold object itself" matches the same block's finding that padded $W_{\mathbb{CP}^2}$ sits at $\theta\lambda_{\max}=1$ against the bound's $\tfrac56$.

**On the second link the row overstates, and contradicts itself.** The added clause reads *"Its second link is largely proved and delivers nothing without the first"*. The same row's unchanged cell says the second link is *"[I74], integrality, with the off-diagonal criticality relations and relation (C)'s Rayleigh form as its two untried inputs"*, and [plan.md](../plan.md)'s I74 row grades it *attackable* $=1$ with *"a mechanism must be invented"*. Two untried inputs and an uninvented mechanism is not "largely proved". What *is* largely proved is [Lemma L201](../findings/diagonal-half.md) and the I76 sub-step at $n=4$ and $n=5$, which sit downstream of integrality rather than being it. The clause should say what survives, that L201 and the $A$-regularity step hold unconditionally while integrality itself is unstarted.

**"The one result that survives any replan is L201, which is unconditional": upheld.** L201 carries **Gate 2 PASSED** at [diagonal-half.md:1139](../findings/diagonal-half.md) and its hypotheses are an orthonormal decomposable basis with integral pairwise traces, nothing standing on I75. One caveat the plan line does not carry: the same block says *"Gate 2 covers the STATEMENT and this proof is new, so it is owed a round of its own"*, so the lemma is unconditional and its current proof is unreviewed.

## 8. What the folds lost

This is the round's second yield and it is larger than the first. r871 supplied eight corrections and additions. Two landed, one landed through [r873](REVIEW_r873.md), and **six are absent from the record**.

**(a) The correctly-counted per-index dual, which the next block still asks for as an open debt.** The sharpest loss. r871 §8 writes the free-$u$ dual out:

> any $y$ and any $u_1,\dots,u_N$ with $\lambda_\alpha\lambda_\beta\lambda_\gamma\le y+u_\alpha+u_\beta+u_\gamma$ at distinct triples give $\theta\le\sum_\alpha\lambda_\alpha^3+(n-2)\big[Ny+3\sum_\alpha u_\alpha\big]$

and §10.3 solves it at padded $W_{\mathbb{CP}^2}$ with an explicit certificate, $y=3c^3$, $u_1=-c^3$, $u_2=u_3=0$, $u_k=-c^3$ on the kernel indices, feasibility checked triple type by triple type, primal equalling dual. Meanwhile [diagonal-half.md:1269](../findings/diagonal-half.md), left untouched by the fold, still records:

> **So what is owed is the dual written from the ordered-triple primal directly, with its coefficients counted rather than inherited**, and until that is done this line records two failures and no bound.

r871 wrote exactly that object, with its coefficients counted, and the record kept only the number it produced. A successor reading the block will rebuild what is already on file.

**(b) The pairwise-distinct correction to the printed minimax.** r871 §2: *"The record writes the max over $\alpha\ne\beta\ne\gamma$. Read literally that chain permits $\alpha=\gamma$. The intended and correct reading is pairwise distinct [...] the minimax as printed is ambiguous and should say pairwise distinct."* [diagonal-half.md:1254](../findings/diagonal-half.md) still prints $\max_{\alpha\ne\beta\ne\gamma}$.

**(c) The finiteness of the minimax.** r871 §3 flags it as *"Finiteness of the minimax, which the record does not address"* and supplies the argument: the triple sums average to zero, so some triple has $\Sigma\le0$ and some has $\Sigma\ge0$, hence $\min_z$ is finite and attained. Without it the displayed bound has no guarantee of not reading $\theta\le-\infty$. Not in the record.

**(d) The closed form for the padded competitor and its cubic growth.** r871 §10.2(a): $\text{bound}(n)=\tfrac1{\sqrt6}\big(1+\tfrac{n(n-1)(n-2)}6\big)$, which is the strongest form of "no crossover at any $n$" and reproduces both the $5/\sqrt6$ at $n=4$ and the $221/\sqrt6$ at $n=12$. The commit message carries "grows cubically". The record's block carries only r872's $\sqrt{2n}$ on a different family.

**(e) The crossover correction.** r871's §10 closes with it: $n=6+2\sqrt7$ is where $\theta_0(n)$ overtakes the **true** $\sqrt{3/2}$, from $4(n-1)(n-2)=3n^2$, that is $n^2-12n+8=0$, so it is a crossover of true values and does not transfer to a bound that diverges cubically. The commit message carries it. Grep finds it nowhere in [findings/](../findings/) or [plan.md](../plan.md).

**(f) The one line of retreat.** r871 §10.3: *"The single line of retreat available to the claim is to restrict the maximisation to spectra of critical tensors, which the derivation never needed."* The record's "two ways out" list does not mention it, and with (B) wrongly retired it is arguably the third survivor.

**Landed, so not losses:** the $n=4$ activity correction and the degenerate minimax interval $[-\tfrac12,\tfrac14]$ are both at [diagonal-half.md:1260](../findings/diagonal-half.md), credited to r873, which reached them independently; the equality-analysis debt is in [reviews/INDEX.md](INDEX.md)'s r872 row. **Minor and unrecorded:** r871 §9's exact gap factor $5/3$ at $W_{\mathbb{CP}^2}$, that the relaxation permits twice the $T$-mass the geometry puts on the one productive triple.

## 9. What a script would have caught

**A missing blank line, at the line the fold edited.** [diagonal-half.md:1264](../findings/diagonal-half.md) and [1265](../findings/diagonal-half.md) are consecutive `>` lines with no blank line between them, so markdown's lazy continuation renders "WHAT SURVIVES IS A TIGHTNESS THEOREM" and "WHY BOTH RELAXATIONS FAILED THE SAME WAY" as **one** run-on blockquote paragraph, against every other block in the section. It predates the commit, and the commit rewrote line 1265 without fixing it. The check that should catch it is a blank-line separator check over blockquote blocks in [findings/](../findings/), which [structure_gate.py](../.claude/hooks/structure_gate.py)'s four id checks do not cover.

**A stale docstring in the machine-checked layer, with no index row against it.** [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean) asserts the retired minimax reading in its header comment, and the [lean/INDEX.md](../lean/INDEX.md) row for it lists nine omissions without naming this one. The check that should catch it is the one already implied by that row's own existence, a pass over the file's docstrings for each retracted reading when one is retracted, which is what r873 did for the *other* retraction and nothing repeated for this one.

**Clean:** no blank lines inside any table in [plan.md](../plan.md), [routes.md](../routes.md), [reviews/INDEX.md](INDEX.md) or [skill-proposals.md](../.claude/skill-proposals.md); r871 has exactly one index row, inserted in sequence between 870 and 872, with no duplicate; no anchor anywhere points at either deleted proposal section; the `Deliverable:` trailers are present and correctly typed on all three commits, and reading [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py)'s `REOPEN` vocabulary and its plan.md condition, none of the three subjects triggers the `Searched:` requirement.

## 10. What would make this round wrong

| What I would have to have misread | What I did to rule it out |
|---|---|
| That r871's §4 LP excludes relation (B) | Read §4's constraint list verbatim, §10.3's reference to "the LP of §4", §10.3's own scope sentence "whose only structural input about $T$ is L153's marginals", and the recommendation to add (B). Then screened r871's own optimal primal against (B) and found it violates the relation at index $1$ by a factor of five. Four independent readings and one screen, all agreeing |
| That adding a constraint could raise a maximisation's optimum | The primal is a maximisation over $S$, so a further equality shrinks the feasible set and the optimum cannot rise. Stated positively rather than assumed: the record's own class-form constraint set at [diagonal-half.md:1248](../findings/diagonal-half.md) lists (B) as an added equality, so the two programmes differ by that constraint and nothing else |
| That the pair cap is not a route for I77, making *attackable* $=1$ defensible | The plan row itself names it: "only the pair-cap variant is untried". And [diagonal-half.md:1244](../findings/diagonal-half.md) shows the cap already working on one stratum, so the honest reading is a route partly spent, which is $2$ |
| That the minimax overclaim is marked withdrawn where it is asserted | Read [line 1254](../findings/diagonal-half.md) and the Lean header in full. Neither carries a marker, a strikethrough or a reviewer reference to the withdrawal |
| That a later reviewer computed the (B)-augmented LP and the fold was citing that | [reviews/](.) holds no report after r873, and grep for $4.4907$ and $11/\sqrt6$ returns r871 as the only source of either figure for this line |

**A sibling's work in the tree, named and left alone.** At the time of this commit the working tree carried unstaged changes to [findings/bounds.md](../findings/bounds.md) and [lean/HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) plus an untracked [L204AltBound.lean](../lean/HamiltonsCubic/Results/L204AltBound.lean), none of them mine. I staged only this report.

**The one thing I did not verify.** Whether the promotion turn reported its edit verbatim in the reply, as `## Report every edit verbatim` requires. That leaves no trace on disk, so I make no claim about it.

## Verdict

**The two skill promotions are clean and true. The r871 fold inverted its source's central recommendation, and the regrade and the route row inherit the error.**

1. **Withdraw the (B) reading in all five places**, and restate what r871 actually closed: any relaxation whose only structural input about $T$ is the marginal is at least $11/\sqrt6=4.4907$ at $n=12$. The (B)-augmented programme is untouched, is bounded above by that figure rather than below, and is the repair the report recommends.
2. **Recompute I77**, which is not on a closed route: *attackable* is $2$ on the rubric's scale, giving value $4$, which also retires the START HERE line's "nothing above $3$".
3. **Restore the six lost repairs**, starting with the per-index dual and its certificate, because the block immediately below the fold still records that object as an open debt.
4. **Mark the two surviving copies of the minimax overclaim**, at [diagonal-half.md:1254](../findings/diagonal-half.md) and in [L203DualBound.lean](../lean/HamiltonsCubic/Results/L203DualBound.lean)'s header, and align [line 1256](../findings/diagonal-half.md) with [line 1260](../findings/diagonal-half.md) on which classes are active at $p=2$.
5. **Keep both promoted rules as written**, adding one clause to the watchdog rule: with several logs the first is the one left unwatched.
6. **The route row's first-link correction is right and is the commit's real contribution.** Only its claim about the second link needs replacing, with a positive statement of what holds unconditionally there.
