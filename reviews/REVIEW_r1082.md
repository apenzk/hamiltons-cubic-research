# REVIEW_r1082, Gate 2 on I112 / route [R31](../routes.md)

*Commits `8c76d3af` and `17ba5b1f`, and the impasse entry of `8964c2a2` in [DECISIONS-TO-MAKE.md](../DECISIONS-TO-MAKE.md). Detail at [the note](2026-09-23-I112-bochner-transfer.md). ONE-READER round: every claim below is a comparison against something fixed, a reading of an audited passage, a recount against a table, or a grade against [the rubric](../.claude/skills/research-loop/SKILL.md). No item on the brief turned out to be an argument needing a second reader. Analysis only. No run of any kind was needed or made.*

| claim | verdict |
| --- | --- |
| **J1**, the Bochner transfer kills [R31](../routes.md) | **REFUTED as argued, CONFIRMED in its conclusion by other evidence** |
| **J2**, the id high-water mark | **CONFIRMED with one false clause** |
| **J3**, the impasse distribution | **CONFIRMED, exactly** |
| **J4**, I112's regrade to `attackable` $1$ | **REFUTED, and the correct grade is $0$ rather than $2$** |
| **J5**, the gate in both directions | **CONFIRMED mechanically, and the quiet reading is an artefact** |

**THE ROUND'S FINDING: [R31](../routes.md) IS DEAD, AND THE RECORD CLOSED IT IN 2026-08 UNDER ANOTHER NAME.** *[Post F33](../findings/fence-posts.md) swept all seven stored second-kind references and found the obstruction is source-independent. [fence-posts.md](../findings/fence-posts.md)'s closed-route table already carries "3a, Cheng–Wang transfer" as closed with a clearance criterion R31 does not clear.* **The [step 9 sweep](2026-09-23-LIT-step9-sweep.md) proposed R31 without screening against either**, and [the note](2026-09-23-I112-bochner-transfer.md) then reached a weaker version of the same verdict from a passage that does not carry it.

---

## J1, the load-bearing claim

### What checks out

**The quotation is verbatim and in scope.** [nondegeneracy.md](../findings/nondegeneracy.md) line 208, section *"The shift is legitimate and the constants cancel, what survives is elementary"*, reads *"Cheng–Wang's Lemma 3.2 is pointwise algebra end to end … **No Bochner term, no second Bianchi, no integration**; those enter downstream at Lemma 3.3."* The note's ellipsis drops an ingredient list and changes nothing.

**[r157](REVIEW_r157.md) is genuinely its auditor.** Its item 1 is *"CONFIRMED, without qualification, no Bochner, no second Bianchi, no integration anywhere in L313–L360"*, against [paper.txt](https://arxiv.org/abs/2508.11226), with a five-row ingredient table. The file attributes the sentence to r157 in place (*"Reviewer 157, reading every step"*). Attribution of the **quotation** is sound.

### Why the inference does not follow

**The passage is a positive finding that the transfer SUCCEEDED, read as a report that it failed.** *Lemma 3.2 transfers to a fixed algebraic $W$ precisely because it is pointwise, and "no Bochner term" says what Lemma 3.2 does not contain.* **Nobody attempted to transfer Lemma 3.3**, so "the record's own audited transfer **stops** at the Bochner term" asserts a failure that was never tested. An untried step is not a stopping point.

**The cited source is a counterexample to the inference's own general form.** Cheng–Wang is a Bochner paper, and its spectral cubic lemma is pure pointwise algebra that did transfer. **So "the theorem's proof uses Bochner downstream" carries no information about whether that paper's $\sum_j\lambda_j^3$ bound has an algebraic core.** *The record's one data point on this question points the other way.*

**The load-bearing step is the author's own and is unaudited.** *"A Bochner argument is an integration by parts over a closed manifold, and the algebraic maximum has no manifold"* appears nowhere in [r157](REVIEW_r157.md), whose scope was the shift repair of Lemma 3.2. **Presenting it under r157's name borrows an authority the audit does not supply**, which is what [plan.md](../plan.md) line 142 does when it writes *"The transfer's stopping point is already on the record and audited ([r157](REVIEW_r157.md))"*.

### Is the disclaimer adequate? Inside the note, yes. Outside it, no

**[The note](2026-09-23-I112-bochner-transfer.md)'s section "What this does and does not settle" is honest and correctly scoped**, naming the limit (Cheng–Wang rather than the 2026 papers) and the question still owed. **Three carriers drop it**: the commit subject *"the first sub-step is answered AGAINST route R31"*, the `Deliverable: dead-end` trailer, and [plan.md](../plan.md) line 142's *"already on the record and audited"*. *A grade was moved on the strength of the undisclaimed version.*

### And the conclusion is right, on evidence the note never cited

**[Post F33](../findings/fence-posts.md) already answers the sub-step, source-independently and in the negative.** Its last sentence: *"All seven stored second-kind references were swept: none carries a usable bound, and **none can**, every estimate there being normalised by $\bar\lambda=\mathrm{scal}/(n(n-1))$, which **vanishes** on a Weyl tensor."* *Reviewers 228, 229, 230.*

**That reason applies to the unstored 2026 paper by inspection of the sweep's own quotation of it.** [The step 9 sweep](2026-09-23-LIT-step9-sweep.md) records arXiv:2609.23597's hypotheses as $\lambda_1\ge-L_1\bar\lambda$ and $\tfrac1\alpha\sum_{j\le\alpha}\lambda_j\ge-L_2\bar\lambda$. **Both are normalised by $\bar\lambda$**, so F33's obstruction is the one they meet, whether or not the paper is on file. *The one known workaround, [nondegeneracy.md](../findings/nondegeneracy.md)'s shift $R=W+sR_1$, is spent: [r157](REVIEW_r157.md) item 4 shows the constant cancels identically and the one-parameter family collapses.*

**AND THE ROUTE IS ALREADY IN THE CLOSED-ROUTE TABLE.** [fence-posts.md](../findings/fence-posts.md) carries the row **"3a, Cheng–Wang transfer"**, closed because *"the bound is loose at the extremiser by $1.45\times$, and the conjecture asserts equality there"*, with the reopening condition *"a sharpening of the $\mu_{N-1}+\mu_N$ input worth more than $1.45\times$, the record has no handle on the top of the second-kind spectrum"*. **R31 is 3a's successor on a neighbouring source and clears neither that criterion nor F33.** *[routes.md](../routes.md)'s R31 row names neither, and [the sweep](2026-09-23-LIT-step9-sweep.md) screened R-C against nothing.*

**The one on-file source that supports the note's actual argument is also uncited.** [harmonic-weyl-2026-second-kind/README.md](../references/harmonic-weyl-2026-second-kind/README.md) line 11: *"The machinery is the **Bochner technique**: it consumes $\nabla$ and compactness, neither of which exists in the algebraic problem."* **That is a statement about a 2026 second-kind Bochner paper, which is what the sub-step asked for**, and it was on file the whole time.

**And the sub-step's "Owed" question has an on-file candidate the note did not look at.** [new-rigidity-2025-second-kind/README.md](../references/new-rigidity-2025-second-kind/README.md) line 16: *"Same transfer mechanism as Cheng–Wang, one parameter wider … each $(n,k)$ pair is a proved instance of 'bottom partial sum controls the Bochner cubic'."* *It is inside F33's seven and falls to the same $\bar\lambda$ obstruction, but the note's own framing required looking.*

### Recommended edits

1. **[plan.md](../plan.md) line 142: strike *"already on the record and audited ([r157](REVIEW_r157.md))"*.** What r157 audited is that Cheng–Wang's Lemma 3.2 is pointwise. The stopping-point claim is the author's.
2. **Cite [post F33](../findings/fence-posts.md) and the closed row 3a as the reason R31 dies**, and retire I112 rather than regrading it.
3. **Add F33 and 3a to [routes.md](../routes.md)'s R31 row** under *"a successor must"*, so the next sweep that reaches this literature meets the closure instead of re-proposing it.
4. **[The note](2026-09-23-I112-bochner-transfer.md)'s "Owed" line is answered** and should be replaced by F33's sentence.

## J2, the id high-water mark

| sub-claim | verdict |
| --- | --- |
| the mark read `I109` while `I110` and `I111` were live | **CONFIRMED** |
| *"the next assignment would have COLLIDED"* | **FALSE**, off by one |
| `I109` is genuinely unused | **CONFIRMED** |
| advancing to `I113` | **CORRECT** |
| leaving `I109` spent | **right, for a reason the line does not give** |

**The drift is real.** At `8c76d3af^` the mark read `I109` ([plan.md](../plan.md) line 56) while `I111` carried a live section 1 row and a live bullet and `I110` sat in the Done section. *The mark last moved at `29815786`, which filed I108. I110 and I111 were created without touching it, which is exactly the failure the line's own "it cannot drift because there is no list" rules out.*

**But the collision is two assignments away, not one.** `I109` was never assigned: a grep across the working tree and across [plan.md](../plan.md) at every revision in its history returns nothing but the mark line itself. *So the next assignment takes `I109` cleanly, the mark then increments to `I110`, and the assignment AFTER that collides.* **"The next assignment would have COLLIDED" overstates a defect that did not need overstating.**

**Leaving `I109` spent is the right call and the stated reason is a hypothesis the author could have checked.** The line says *"a number that looks free may be a deleted item's"*. **The history says it is not**, and the real reason is better: a mark just shown to be unreliable cannot vouch for anything below it, so one burned integer is cheaper than a second audit. *Recommend rewriting the clause to say the history was checked and `I109` was never issued.*

## J3, the impasse measurement

**CONFIRMED, exactly, recounted from [plan.md](../plan.md) at `8964c2a2`.** Twenty-one graded rows, matching the claim's own count.

| `attackable` | count | items |
| --- | --- | --- |
| $0$ | **5** | I1, I37, I3, I4, I7 |
| $1$ | **15** | I73, I36, I111, I106b, I100, I71, I89, I68, I76, I77, I6, I104, I81, I74, I75 |
| $2$ | **0** | none |
| $3$ | **1** | I95 |

**"Twenty of twenty-one cannot be started" follows**, I95 being the only row at `attackable` $\ge2$. **"No item has `closes`$\ \ge3$ and `attackable`$\ \ge2$" also holds**: the `closes` $3$ rows are I73 ($1$), I36 ($1$) and I7 ($0$). *One trap avoided in the recount: I3 reads `2` in the `margin` column and `0` in `attackable`, and reading the row left to right without the header lands on the wrong field.*

## J4, I112's own grade

**REFUTED, and not in the direction the brief expected.** *The author did not inflate here. The regrade moved the right way, on evidence that does not carry it, and stopped one step short of the floor.*

**`attackable` $1$ is "a route must be invented", and the row names its route in the same sentence.** [plan.md](../plan.md) line 142 ends *"**Owed**: whether the 2026 functional has a pointwise algebraic core Cheng–Wang's lacks"*, which is a named, bounded, unspent next action. **A row that states its own next action has not earned $1$** on the scale's wording.

**$3$ is also wrong**, against the brief's hypothesis. *"A route exists and is untried" grades the route, and the second-kind transfer is heavily spent: Cheng–Wang was transferred, the constant cancelled, and the tight-at-extremum test lost $1.45\times$. "Whether the 2026 functional has a pointwise core" is a screening question ABOUT the route, not a second route.*

**The correct grade is `attackable` $0$, value $0$**, on the record rather than on the note. *"Every named route is closed" is the literal fit: [post F33](../findings/fence-posts.md) says of the whole second-kind literature "none carries a usable bound, and none can", and 3a sits in the closed-route table.* **The one reading that would keep it at $1$** is that arXiv:2609.23597 is unstored and therefore a route nobody has closed by hand. **F33's reason is source-independent and the sweep's own quotation of that paper's hypotheses shows it carries $\bar\lambda$**, so I do not think the reading survives. *Write the reopening condition into the row: an estimate in that literature NOT normalised by $\bar\lambda$.*

**Recommendation: retire I112 to the Done section as a closed item**, with F33 and 3a as what closed it, rather than leaving a value-$2$ row that reads as live work.

## J5, the gate

**Both readings are mechanically CORRECT**, checked against [loop_stop.py](../.claude/hooks/loop_stop.py)'s `_unreachable_top`.

- **It fires at `8c76d3af`.** I112 at value $4$ is the unique maximum, `closes` $2$, so `top[1] >= 3` is false and the gate returns the top with its closers. *The commit's own reading of why is right.*
- **It goes quiet at `17ba5b1f`.** I112 drops to value $2$, and the maximum is $3$, shared by I73 and I36, and the tie-break `max(rows, key=lambda r: (r[3], r[1]))` at line 364 takes `closes` as the second key with both at $3$. `top[1] >= 3` returns `None`. *Quiet, correctly, by the gate's own rule.*

**AND THE QUIET MEANS LESS THAN IT READS.** `_unreachable_top` returns `None` on `closes` **alone** and never consults `attackable`, although it computes `routed` three lines later. **I73 is `attackable` $1$**, so the gate's silence certifies that the top item *would* close the statement while saying nothing about whether anyone can start it. *[DECISIONS-TO-MAKE.md](../DECISIONS-TO-MAKE.md)'s measurement, no item with `closes`$\ \ge3$ and `attackable`$\ \ge2$, is unchanged by the regrade.*

**The gate therefore rewards downgrading the only startable non-closer**, which is precisely the move these two commits made. *The author did not exploit it: `17ba5b1f` says plainly that the list has no startable item touching P. The design permits it, and this session produced the exact move that would.*

**Recommendation: `_unreachable_top` should also return a finding when the top closer has `attackable`$\ \le1$**, with its own message, since a plan whose only closers cannot be started is the same defect the gate was built for wearing a different number.

---

*Reviewed by r1082, 2026-09-23. Log at [agent_logs/r1082-i112.log](../agent_logs/r1082-i112.log).*
