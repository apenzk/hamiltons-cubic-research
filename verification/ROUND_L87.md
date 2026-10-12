# Round L87, the rank-one step: the orbit Gram meets the cap, so every even block loses exactly one multiplicity

**Opened** 2026-09-06. **Verifiers** v75, v76, v77. **Adjudicators** allocated at phase 3.

**Source.** [findings/sym3-blocks.md:140](../findings/sym3-blocks.md), the paragraph under `#### Lemma L87`.

**How this round arrived.** By transfer from [round L62](ROUND_L62.md), which found a defect on material that is not L62's argument. **The transfer carries a question and no verdict**, since no adjudication ran on it there.

## Phase 0, the statement, and the one place it lives

**There is one form, not two.** [results.md](../results.md) has **no statement of L87**, the result is named once, at [results.md:23](../results.md), inside a sentence about a different result. **A load-bearing lemma with no canonical statement is this round's first finding**, and it is recorded before any verifier reads anything: there is nothing to check the findings form against.

The statement, [findings/sym3-blocks.md:140](../findings/sym3-blocks.md):

> **The rank of the Gram matrix $\langle g_a W_0, g_b W_0\rangle^3$ over $3700$ orbit points is exactly $3570$ over $\mathbb F_{46337}$.** A mod-$p$ rank is a *lower* bound for the characteristic-zero span, and $3570$ is the theoretical cap, $\sum_\lambda d_\lambda$ over the $\lambda_2$-even blocks, using $\dim V_\lambda^H\le1$. **The two meet, so the span is exactly $3570$, every one of the sixteen evaluation maps is nonzero, and every even block loses exactly one multiplicity.**

## The pre-registered question, held out of the brief

**The transferred question is recorded here and withheld from the verifiers**, by the rule this round's predecessor proposed for itself: *a brief may name the step to check, and never the property to look for.* A brief carrying the property would return three reports carrying it back.

**The question.** [round L62](ROUND_L62.md)'s adjudicators, examining L62's own reduction step, said of this one that its orbit points are Cayley transforms of skew matrices drawn **over $\mathrm{GF}(46337)$** (elements of $O(5,\mathbb F_p)$) and asked in what sense a mod-$p$ rank of such a matrix bounds a characteristic-zero span. Each said L87's conclusion survives by an integral lift the record names in half a sentence and supplies nowhere. **It is adjudicated in this round on its own neutral question, not inherited as a finding.**

**The verifiers are asked for the warrant sentence and the cap, with no property named.**

## Phase 4, part 1, the dependent set, built while phase 1 runs

Searched by number, by the statement's signature ($3570$, the sixteen even blocks, the rank-one step), and by reading the blocks around the owning file's index row.

| site | kind |
|---|---|
| [sym3-blocks.md:98](../findings/sym3-blocks.md) | **load-bearing**, [L86](../findings/sym3-blocks.md)'s heading claims a number its section proves only as $\ge36$; *"the rank-one step is L87's"* is what closes it |
| [sym3-blocks.md:146](../findings/sym3-blocks.md) | **load-bearing**, [L88](../findings/sym3-blocks.md)'s $47=36+11$ is transported *"through L86's parity rule and L87's rank-one step"*; this is also the sentence [round L62](ROUND_L62.md) left a `HYPOTHESIS-DEBT` against |
| [sym3-blocks.md:273](../findings/sym3-blocks.md) | **load-bearing**, L87 *"retires [L84](../findings/sym3-blocks.md) as a dependency while leaving it untouched as a theorem"* |
| [sym3-blocks.md:56](../findings/sym3-blocks.md) | **load-bearing**, L87 kills two of three collisions |
| [sym3-blocks.md:299](../findings/sym3-blocks.md) | the chain L87 → [L59](../results.md) → [L62](../findings/sym3-blocks.md) |
| [results.md:23](../results.md) | **L87's only appearance in the canon**, and inside a sentence about another result |
| [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) | the $3570$ as the rank of the orbit average's catalecticant |

**Two facts the search settles on its own, before any adjudication.**

- **There is no `scripts/reviewers/r174/`.** The measurement the block attributes to reviewer 174 has no directory; [r173](../scripts/reviewers/r173/r173_orbit_span.py) holds an orbit-span script. **An attribution is checkable against the filesystem**, and this one fails there rather than in anyone's reading.
- **The debt [round L62](ROUND_L62.md) filed lands on a sentence this round is auditing.** L88's transport of the gauge property rests on L87's rank-one step, so whichever way L87 goes, that debt moves with it. **Recorded as a link between the two rounds rather than resolved in either.**

## The whole-record search, run before any adjudication, and it changes what this round is

**Every finding the verifiers raised is already on the record, in a six-item repair list that was written and never applied.** [REVIEW_r682](../reviews/REVIEW_r682.md) closes with:

1. replace the headline, the cap is a theorem, the attainment one exact finite computation;
2. state the cap on the hypothesis that gives it, [L86](../findings/sym3-blocks.md)'s full parity rule, *"without the odd-block vanishing the cap is $5640$ and the squeeze does not close"*;
3. **replace the mod-$p$ one-liner with a two-line semicontinuity argument**, which r682 supplies in full;
4. fix the attribution in both blocks, the measurement is [r170](../reviews/REVIEW_r170.md)'s, confirmed by [r173](../reviews/REVIEW_r173.md); [r174](../reviews/REVIEW_r174.md) derived the cap;
5. say *"an independent construction of $W_0$ and exact arithmetic"* rather than *"independently"*;
6. add the links, the review, the script, [L86](../findings/sym3-blocks.md), [L83](../findings/sym3-blocks.md), the corroborating runs.

**None of the six was applied.** So the round's subject is not a defect nobody had found; it is **a recorded repair list that never reached the text it was written for**, and three cold verifiers rediscovered its contents item by item.

**The repairing argument exists too.** r682 gives it: $W_0$ is integral and $SO_5$ is smooth over $\mathbb Z[\tfrac12]$; with $\Lambda\colon\mathrm{Sym}^3(\mathcal W_5)^*\to\mathbb Z[\tfrac12][SO_5]$ sending $f$ to $g\mapsto f(gW_0)$ and $L$ its matrix over $\mathbb Z[\tfrac12]$-bases, $SO_{5,k}$ is reduced over any field of characteristic $\ne2$, so $f$ kills the image exactly when $L_kf=0$. **This is a Gate 2 reviewer's mathematics, produced in the loop where new mathematics belongs**, rather than an argument invented inside a check, so it may be adopted, and adopting it is what item 3 asks for.

**What this does to phase 3.** The findings are not open questions: two independent Gate 2 reviewers already graded them, agreeing, and the record carries their verdict. **What is genuinely open is whether r682's replacement argument is correct**, because applying it writes new mathematics into the block. That single question goes to adjudication; the rest is application of a verdict the record already holds.

**And it names a candidate defect class**, in the sense of phase 4's last item: **a Gate 2 `GAP` whose repair list was recorded and never applied**. The siblings are enumerable by one pass over [findings/INDEX-results.md](../findings/INDEX-results.md) for `GAP` rows whose blocks still carry the graded text.

## The roster, corrected

**v75 was allocated and produced nothing**, launched immediately before a user interrupt, it left no log and no report. **The number is spent, not reused**, and **v78** was dispatched on the identical brief so the round keeps its three independent draws.

## Phase 3, the one question that goes to adjudication

**Adjudicators v79 and v80**, on the replacement argument, asked neutrally and told neither who wrote it nor that it is a replacement.

## The stop condition this round is carrying toward

**[REVIEW_r682](../reviews/REVIEW_r682.md) records an open run and declines to make it**, under the same analysis-only rule this loop inherits: evaluate the $41$ highest-weight vectors of [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py), read as cubic polynomials, at a handful of orbit points $g\cdot W_0$ **over $\mathbb Q$**. *A single nonzero value per even block settles that block's rank at $1$ by itself*, **sixteen independent small facts in place of one $3700\times3700$ mod-$p$ rank**, with no cap and no attainment needed.

**That is what would make the block's headline true**, and it is `UNRESOLVED, needs computation`. **Routing it to the research loop is the user's call**, which is a stop condition for this loop and is raised as one rather than worked around.

**The repair list is eight items, not six.** Two more sit past the numbered six: reconcile with [L86](../findings/sym3-blocks.md)'s *"what promotes it to an identity is a measurement"* four lines above, recording that the check L86 names is still open; and state in [L59](../results.md) and [L62](../findings/sym3-blocks.md) that the chain has two measured links, **a sentence the record already holds, in [r652](../reviews/REVIEW_r652.md)'s note, and no block carries.**

### v79, `VALID WITH A NAMED GAP`

**What holds.** The conclusion the argument exists to supply goes through, and it genuinely repairs the defect it replaces: $L$ is built from $W_0$ and the group scheme **before any field is chosen**, so the Cayley points (elements of $SO(5,\mathbb F_p)$ that lift to nothing), are never asked to lift. *The objection that killed the original one-liner does not transfer to this one.*

**The gap.** *"Fix $\mathbb Z[\tfrac12]$-bases and let $L$ be its matrix"* has no referent: $\mathbb Z[\tfrac12][SO_5]$ is not finitely generated as a module, carries no grading (the ideal $g^{\mathsf T}g-I$ is inhomogeneous), and is not shown free, so neither *"its matrix"* nor $\operatorname{rank}(L_k)$ is defined. **What must be proved: a finite free $M$ with $\operatorname{im}\Lambda\subseteq M\subseteq\mathbb Z[\tfrac12][SO_5]$.** The adjudicator named it and, correctly, did not supply it.

**Two things it corrects about the argument's own account of itself.** Reducedness is **load-bearing at $k=\mathbb Q$ and inert at $k=\mathbb F_p$**, the reverse of how the sentence attributes it; and *"characteristic $\ne2$"* also admits $p=3$, where the first link fails.

**The whole-record search on this gap, run at once rather than at filing.** `finitely generated`, `free module`, `coordinate ring`, `regular function` across [findings/](../findings/), [results.md](../results.md), [report/](../report/) and the two audits: **the finite-free step appears nowhere.** Unlike round L62's debts, this one survives the search, the argument's missing piece is missing from the record entire.

**So the repair changes shape.** Item 3 of the list cannot be applied as written: substituting this argument would put a hole in the block where a one-liner now sits. **What the block can carry is the argument together with its named gap**, which is strictly better than what stands, a false warrant replaced by a correct argument with one step owed.

### v80, `VALID WITH A NAMED GAP`, agreeing

**The same gap, reached independently**: $\mathbb Z[\tfrac12][SO_5]$ is not finitely generated over $\mathbb Z[\tfrac12]$ and carries no grading, so *"the relevant degree"* has a false presupposition; **what must be proved is a finitely generated free submodule containing the image**, and saturation is not required.

**And a second misdescription the first adjudicator did not reach.** The sentence *"$SO_{5,k}$ is reduced, so $f$ kills the whole image iff $L_kf=0$"* asserts an equivalence at every $k$; the two ends of the chain consume **opposite halves** of it:

| field | half consumed | what supplies it |
|---|---|---|
| $k=\mathbb F_p$ | $\ker L_k\subseteq\{f\text{ vanishing pointwise}\}$ | unconditional, **reducedness is unused here** |
| $k=\mathbb Q$ | the converse, giving $\operatorname{rank}(L_{\mathbb Q})\le\dim U$ | **Zariski density of $SO(5,\mathbb R)$ in $SO_{5,\mathbb C}$**, which reducedness does not give |

**Both adjudicators agree on what the argument's real contribution is**, and it is the thing the block most needs: $L$ depends on the group scheme and the integral $W_0$ and **never on a sampled element**, so it is one matrix reducing both ways, the integral object the original one-liner lacked.

**Two side-findings from the script, one of them a withdrawal.** $W_0$ is built from integer data in $\mathrm{Sym}^2(\Lambda^2\mathbb Z^5)$, which is $SO_5$-stable over any ring, so $\mathbb Z[\tfrac12]$ is the right ring and no further prime need be inverted, the candidate failure that $3,5,7$ must also be inverted was constructed and **withdrawn**. And the Cayley transform forces $\det g=1$ in every characteristic, so the sample lies in $SO_5(\mathbb F_p)$ rather than $O_5(\mathbb F_p)$ as the record's prose says, **better than claimed, and exactly what the argument needs**.

### The adjudication's outcome

**Confirmed, both adjudicators, on a neutral question: the replacement is adoptable and carries two named gaps**, the finite free submodule, and the density statement standing where reducedness is written. **Neither adjudicator supplied either**, correctly.

**What both agree it does not do**: verify $3570$; supply the cap, which still rests on the too-weak $\dim V_\lambda^H\le1$ giving $5640$; promote the lemma from measured to proved; or retire the check [L86](../findings/sym3-blocks.md) names.

### v78, `GAP`, and one exhibit that settles the cap's hypothesis

**A closed-form falsifier of the block's stated ground.** Under $\dim V_\lambda^H\le1$ alone the cap is $5640$, and the measured $3570$ forces nothing even so: $r_\lambda=1$ on the eight odd blocks together with $(6,4)$, $(6,2)$, $(2,2)$, $(3,0)$ sums to exactly $3570$ **with twelve of the sixteen evaluation maps at rank $0$**. *This is an exhibit against a written hypothesis, not a new theorem*, which is why it enters the block: it shows the stated ground cannot carry the conclusion, whatever else does.

**A second lift route on the record.** [r681](../reviews/REVIEW_r681.md) supplies an integral Cayley lift where [r682](../reviews/REVIEW_r682.md) uses smoothness over $\mathbb Z[\tfrac12]$. **Two independent repairs exist and neither reached the lemma.**

**Held out of the block, deliberately.** v78 proved two of the sixteen evaluation maps nonzero by hand, the trivial block by $\operatorname{tr}(W_0^3)=48\ne0$, and $(1,0)$ through r173's pseudovector covariant. **Two of the eight block deaths would then stand independently of every run.** That is new mathematics arriving inside a check, so it is recorded here as a lead for the research loop and **not written into the record as established**.

## Phase 5, what changed

| site | change |
|---|---|
| [sym3-blocks.md](../findings/sym3-blocks.md), the L87 block | rewritten as a derived cap and an exact finite computation, with both hypotheses named, the falsifier, r682's argument in place of the false one-liner, its two owed steps, the corrected attribution, and the links the block had none of |
| [sym3-blocks.md](../findings/sym3-blocks.md), L86's copy | the same attribution corrected, and the joining step named as owed |
| [results.md:23](../results.md) | L87's rank no longer rides on L62's warrant; only L62 has it |

**Deleted, not annotated.** Five Gate 2 blockquotes and the superseded headline are gone; one line of provenance names the round.

## Phase 6, verdict

**`GAP`**, impact **`NARROWS`**. The conclusion holds and every number stands, $3570$, the $25$, the $36$, the $29$, the shape, the eight deaths, the surviving collision. **What was unjustified was the warrant, and it is now stated correctly with its two owed steps visible.**

**Verifiers** v76, v77, v78, *v75 spent, produced nothing*. **Adjudicators** v79, v80, agreeing.

**`UNRESOLVED, needs computation`, handed over rather than attempted**: evaluating the $41$ highest-weight vectors at orbit points over $\mathbb Q$ would replace the whole rank argument with sixteen independent small facts. **Routing it is the user's call.**

### The candidate defect class, enumerated

**A Gate 2 `GAP` whose repair list was recorded and never applied.** [findings/INDEX-results.md](../findings/INDEX-results.md) carries **21** such rows: **2, 53, 59, 61, 63, 64, 83, 84, 85, 86, 87, 88, 89, 90, 91, 98, 100, 101, 111, 113, 115, 144**. L87 was one of them and is now applied; **the other twenty are candidates, not verdicts**, each settled by its own round.

*The class is worth naming because its members look audited. A `GAP` row reads as a result someone checked (and it is) but the checking produced instructions, and nothing in the record distinguishes instructions carried out from instructions filed.*
