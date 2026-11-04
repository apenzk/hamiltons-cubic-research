# Review 764, whether [Lemma L174](../findings/second-order.md)'s Gate 2 findings were applied faithfully

**Cold brief.** [BRIEF-g2-l174fold.md](BRIEF-g2-l174fold.md) was read in full before any file of the record, and [REVIEW_r761.md](REVIEW_r761.md) and [REVIEW_r762.md](REVIEW_r762.md) were read in full before the folded block was opened. **No numerical work was done**, no sweep, no search, no falsifier hunt. Every value here is exact rational arithmetic, and the one exact-rational screen is named as a screen where it appears. [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) was **built in the kernel** rather than audited at statement level: `lake build HamiltonsCubic.Results.L174` completes, 825 jobs. Log: [agent_logs/g2-l174fold-r764.log](../agent_logs/g2-l174fold-r764.log).

| # | what was supposed to land | verdict |
|---|---|---|
| 1 | The norm is unstated; the numeral $2$ needs $\lVert M\rVert_F=1$ | **LANDED, faithfully**, pinned in the Statement and given the tabled sense's $4$ as the contrast |
| 2 | L94 carries an unstated hypothesis, attainment of $\max_F$ | **LANDED WRONG**, the block attributes the silence to [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md), **both of which state it**, and drops the discharge both reviewers supplied |
| 3 | The maximiser hypotheses are idle; the equivalence holds at every unit $W$ | **LANDED IN PART**, recorded as a remark, and the block then claims a regeneralisation of the Statement that was not made |
| 4 | The Lean docstring's *"the whole risk"* is refuted; the risk sits inside `def L94` | **LANDED, THEN SUBSTITUTED**, the refutation landed; the two invisible risks were renamed, and the one both reviewers named is now on the record nowhere |
| 5 | The band is inhabited: $S^5\times S^7$ at $\theta^2=\tfrac{264}{175}$ | **LANDED**, one reviewer's finding, taken with its on-record support; the other's abstention is unrecorded |
| 6 | Remark (b) is the reduction's closure condition, $n\ge12$ | **LANDED** in the block; the clause it corrects survives in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean), where $n=12$ scopes it |
| 7 | What the reformulation buys is narrow, three qualifications | **LANDED, all three** |
| 8 | The strictness of $\theta>\sqrt{3/2}$ is load-bearing | **LANDED**, in the block and in [I36](../plan.md), with the right obligation |
| 9 | A cheaper citation for the constant | **LANDED** |
| 10 | Nothing landed that neither reviewer said | **REFUTED**, the *"neither states"* clause of §2 and the *"agreeing on four corrections"* framing trace to neither report |
| 11 | Nothing the reviewers found was dropped | **REFUTED**, [r762](REVIEW_r762.md)'s **H2**, the ordered-pair reading of $t$, its own top-ranked breaking risk, landed nowhere; four smaller items with it |
| 12 | The arithmetic that landed | **CONFIRMED**, exactly: $\tfrac{220}{144}=\tfrac{55}{36}$, $\theta^2_{5,7}=\tfrac{264}{175}$, strictly in the band, closure at $n\ge12$ at both parities |

**Actionable in one line.** Six of the nine landed clean; repair three sentences, put the extremal/per-frame swap back as the second invisible risk in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) and [lean/INDEX.md](../lean/INDEX.md) in place of attainment, strike *"neither states"* from the proof, and either regeneralise the Statement or stop saying it was, and file [r762](REVIEW_r762.md)'s H2.

## 0. Conventions, fixed once

Read from the two reports and from [conventions.md](../findings/conventions.md) before anything below was derived.

- **The two readings of the budget.** $t_F=\lVert K(F)\rVert_F^2$ is the frame's own value; $\kappa^2=\max_Ft_F$ is the extremal one. The record fences the substitution of one for the other, and both reviewers made the check that it had not occurred here.
- **The ordered sum.** $t=\sum_{a\ne b}K_{ab}^2$, over **ordered** pairs, which is what makes the ceiling $2$ rather than $1$. This is [r762](REVIEW_r762.md)'s H2 and it is §11 below.
- **The letter $M$.** The $\Lambda^2$ operator matrix, under which $\lVert M\rVert_F=\lVert W\rVert$; [conventions.md](../findings/conventions.md)'s one tabled sense is the $n\times n$ sectional matrix, under which $\lVert M\rVert_F^2=2$ at a unit Weyl tensor.
- **The three risks, as the reviewers enumerated them.** [r762](REVIEW_r762.md) §8: (i) the per-frame/extremal swap, invisible; (ii) the normalisation, invisible; (iii) the quantifier step, visible and checked. [r761](REVIEW_r761.md) §7.3 enumerates the same pair as the invisible two, *"the unit-norm step of section 2 and the extremal reading of section 1, and **both are assumed rather than checked**"*. **Attainment is in neither enumeration.**
- **The verdicts folded.** Both reports carry **PROVEN, hypotheses corrected**, and both refute the Lean docstring's *"the whole risk"*.

## Hypothesis inventory of the fold

What the folded record now asserts, and where each assertion comes from.

| assertion now in the record | source | status |
|---|---|---|
| $\lVert M\rVert_F=1$ is the working normalisation; the tabled sense returns $4$ | [r762](REVIEW_r762.md) §2, [r761](REVIEW_r761.md) §2 | faithful |
| L94's equality case is an *"iff"* proved in one line by both L94 reviewers | both, at source | faithful |
| L94 carries attainment of $\max_F$, *"which neither states"* | **neither report** | **false as written, §2** |
| The lemma *"is stated above in the generality it has"* | [r761](REVIEW_r761.md) repair 2 asks for it | **announced, not performed, §3** |
| The two risks invisible to the abstraction are *"unit"* and attainment | **neither report** | **substituted, §4** |
| $S^5\times S^7$ inhabits the band, $\theta^2=\tfrac{264}{175}$ | [r761](REVIEW_r761.md) §6 only; [r762](REVIEW_r762.md) §5 declines to assert it | one-sided, and supported, §5 |
| The comparison is the reduction's closure condition, $n\ge12$ | [r762](REVIEW_r762.md) §5 only | faithful, §6 |
| The strictness is load-bearing; the analytic proof is owed | [r761](REVIEW_r761.md) §9 only | faithful, §8 |
| $t$ is the ordered-pair sum | [r762](REVIEW_r762.md) H2, §9.1 | **absent, §11** |

## 1. Finding 1, the norm

**Landed, and landed as stated.** [r762](REVIEW_r762.md) §2: *"the tabled sense gives $\kappa^2\le4$ and the unit-norm step collapses"*. [r761](REVIEW_r761.md) §2 tables three readings and files the repair *"for $W$ with $\lVert M\rVert_F=1$"*. The block now opens: *"normalise so that $\lVert M\rVert_F=1$ for the operator $M$ that L94's bound is stated over, the sense of 'unit' is load-bearing here and [conventions.md](../findings/conventions.md) does not table it; its one tabled sense returns $4$ rather than $2$."* That is both reviewers' repair, in the Statement where they asked for it.

**One reading dropped, harmlessly.** [r761](REVIEW_r761.md) ranked the [post F33](../findings/INDEX-traps.md) reading $\lvert W\rvert_4=1$ (which returns $\kappa^2=\tfrac12$) as its **first** breaking risk, above the sectional reading, on the ground that the sectional one is self-refuting and so warns the reader while the $\lvert W\rvert_4$ one does not. The block keeps only the sectional contrast. **Arguing the opposite:** the repair the ranking was in service of is the naming of $\lVert M\rVert_F=1$, and that landed; once the norm is named, no reading survives to be ranked. **No discrepancy recorded**, the omission costs the reader an illustration, not a hypothesis.

## 2. Finding 2, attainment, and the clause that landed with it

**The hypothesis landed; the sentence carrying it says something neither reviewer said, and it is false.**

The block's proof now reads: L94's equality case is *"an 'iff', Gate 2 confirmed by [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md) with a one-line proof of both halves, and **carrying one hypothesis neither states: attainment of $\max_F$**, used in the direction that produces a diagonalising frame."*

- **Located.** [second-order.md](../findings/second-order.md), the L174 block, the proof paragraph, the clause *"carrying one hypothesis neither states"*. The only plural antecedent in the sentence is [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md).
- **Exhibited.** [REVIEW_r101.md](REVIEW_r101.md) line 32: *"$O(n)$ is compact and the objective continuous, so the max is attained."* [REVIEW_r102.md](REVIEW_r102.md) line 31: *"the maximum is attained because $O(n)$ is compact."* **Both state it, in the one-line proof the same clause cites.** [r761](REVIEW_r761.md) §9 says so in terms, *"[r101](REVIEW_r101.md) states this step explicitly in its one-line proof"*, so the fold contradicts the report it is folding.
- **Argued the opposite.** The strongest reading is that *"neither"* means *neither L174's statement nor its proof*, which is [r762](REVIEW_r762.md)'s H5, *"unstated"* meaning unstated **in L174**. That reading has no antecedent in the sentence, and the sentence is built to attach the omission to the two named reviewers. **The reading the words support is the false one.**

**And the discharge was dropped, which is the substantive half.** [r762](REVIEW_r762.md) §4: *"a continuous function on a compact set attains its supremum. So the record's writing $\max$ rather than $\sup$ is justified, and **H5 is discharged rather than owed**."* [r761](REVIEW_r761.md) §9: *"Confirmed and needed"*, supplied by compactness. The record now carries attainment as a bare unstated hypothesis with no discharge, and §4 shows the Lean layer then promoting it to a live risk. **A hypothesis both reviewers closed has been reopened in the folding.** *This is the strengthening direction the brief warns about: a reviewer's discharged edge became the record's outstanding debt.*

**Repair, one clause:** *"and consuming one step the block does not state, attainment of $\max_F$, supplied by compactness of $O(n)$ with $F\mapsto t_F$ continuous, and used in the direction that produces a diagonalising frame."*

## 3. Finding 3, the idle maximiser hypotheses

**The finding landed. The repair it asked for did not, and the block says it did.**

The blockquote is faithful and correctly attributed: *"L94 needs the norm and nothing else, so the equivalence holds at **every** unit $W$ … **Both audits found this independently**"*, true, [r761](REVIEW_r761.md) claim 10 (**REFUTED**, the hypothesis does work) and [r762](REVIEW_r762.md) claim 7 (**CONFIRMED IDLE**). The proof line *"on any class of $W$ whatever including the empty one"* carries the generality.

**The defect is the trailing clause.** The same blockquote ends: *"and the lemma **is stated above in the generality it has** rather than in the one [I36](../plan.md) happens to need."*

- **Located.** [second-order.md](../findings/second-order.md), the L174 block, the *"decoration"* blockquote, last clause, read against the **Statement** paragraph directly above it.
- **Exhibited.** The Statement's display is unchanged: $\big(\text{every local maximiser with }\theta>\sqrt{3/2}\text{ is coordinate-diagonal in some frame}\big)\iff\big(\text{every such maximiser has }\kappa^2=2\big)$. That is the I36-relativised form, word for word what [r761](REVIEW_r761.md) §8 asked to be replaced: *"the honest statement of L174 is one line shorter and strictly more general … **Repair:** state it that way."* The general form [r761](REVIEW_r761.md) wrote out, the pointwise biconditional at every unit $W$, then the relativisation to an arbitrary class $\mathcal C$, with I36 as the instance, appears nowhere in the block.
- **Argued the opposite.** *"Stated above"* could be read as *stated somewhere above in this block*, which the proof's *"on any class of $W$ whatever"* would satisfy. That is a real reading and it is why this is a defect of degree rather than a falsehood: the generality is **on the record**, in the proof, and only the Statement fails to carry it. **But the clause claims a change to the Statement that the commit did not make**, and the Statement is the line a later reader quotes.

**Repair:** either write [r761](REVIEW_r761.md)'s two-sentence general form into the Statement, or downgrade the clause to *"and the proof below establishes it in the generality it has"*.

## 4. Finding 4, the Lean docstring, where the substitution is

**The refutation landed. The content it was a refutation of was replaced with something neither reviewer wrote, and the risk both named has left the record.**

What the reviewers said the two invisible risks are:

| | [r761](REVIEW_r761.md) §7 | [r762](REVIEW_r762.md) §8 |
|---|---|---|
| invisible risk 1 | the unit-norm step of §2 | (ii) the normalisation of §2 |
| invisible risk 2 | **the extremal reading of §1**, *"it would typecheck unchanged if `kappaSq` meant the per-frame $t_F$"* | **(i) the per-frame/extremal swap**, *"substitute the per-frame reading and the file compiles unchanged while the record's claim becomes false"* |
| visible risk | the quantifier step, a tautology | (iii) the quantifier step |

What landed, [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) lines 15–17: *"The two the abstraction cannot see are the sense of 'unit' that makes `2‖M‖²` equal `2`, and **`L94`'s own unstated attainment of `max_F`**."* [lean/INDEX.md](../lean/INDEX.md)'s L174 row repeats it verbatim in substance: *"the other two (the sense of 'unit' and L94's unstated attainment of $\max_F$), being invisible to the abstraction."*

- **Located.** [L174.lean](../lean/HamiltonsCubic/Results/L174.lean), module docstring, and [lean/INDEX.md](../lean/INDEX.md) row L174.
- **Exhibited.** The swap is the risk with a **standing record of having occurred**, [r762](REVIEW_r762.md) §8: *"the record's standing warning is that (i) has already happened once"*, [conventions.md](../findings/conventions.md)'s fenced $t_F$/$\kappa^2$ box and [DERIVE-mx1.md](DERIVE-mx1.md). It is also the risk the file is **structurally unable to detect**, `kappaSq` being an opaque `Weyl → ℝ`, which is exactly why both reviewers named it. It now appears in no sentence of the L174 material: not the block, not the plan entry, not the Lean file, not either index. **What replaced it is a hypothesis both reviewers discharged** (§2). So the corrected docstring names one risk that is real, one that is closed, and omits the one with a history.
- **Argued the opposite.** The docstring's next sentence is a genuine gain and is faithfully [r761](REVIEW_r761.md)'s: *"`L94` below is taken as a hypothesis, and it is **not** the recorded L94 but its unit-norm specialisation, a statement carrying no Gate 2 of its own."* A reader who reaches it learns that the specialisation is where the risk lives, without being told which risks those are. And attainment **is** invisible to the abstraction, so the sentence is not false, it is the wrong pair. **That is precisely the failure mode the brief names**: not a weakened finding and not a strengthened one, but an adjacent one, which reads as compliance.

**Repair:** in both files, *"the sense of 'unit' that makes `2‖M‖²` equal `2`, and the extremal reading of `kappaSq`, nothing in the file distinguishes $\max_Ft_F$ from a per-frame $t_F$, and the swapped reading typechecks unchanged"*. [r761](REVIEW_r761.md) §7's structural repair (`kappaSq` defined as a supremum over `Frame`, so that the swap becomes expressible), is the version that would make the file able to see it, and is §11's fourth drop.

**The rest of the docstring is faithful.** *"That step is a first-order tautology and is the **smallest** of the three risks, not the whole of them, both Gate 2 reviewers refused the claim that it was"* matches both claim tables (**REFUTED**, **REFUTED as written**), and *"the maximiser hypotheses are idle"* matches §3. The file still builds: 825 jobs.

## 5. Finding 5, the witness, and the one place the reviewers differ

**Landed. It is one reviewer's finding taken whole, and the fold does not say so.**

[r761](REVIEW_r761.md) §6 asserts the band is inhabited, with the arithmetic and with a maximality citation. [r762](REVIEW_r762.md) §5 declines: *"whether that region contains any maximiser at all is unknown, and the remark should not be read as asserting one exists."* The block asserts it: *"**The band is not empty and the record holds its witness**: $S^5\times S^7$ at $n=12$ has $\theta^2=\tfrac{264}{175}$, strictly between $\tfrac32$ and $\tfrac{55}{36}$."*

**This is a difference in coverage rather than a disagreement, and taking [r761](REVIEW_r761.md)'s side is right.** [r762](REVIEW_r762.md) asserts ignorance, not falsity, and did not look; [r761](REVIEW_r761.md) looked and found the record's own statement. I checked the support rather than accepting the citation: [graded-half.md](../findings/graded-half.md) line 331 records *"Lemma L69 makes **each** sphere product with both factors $\ge5$ a local maximum"*, lists $S^5\times S^7$ in the $(6,6)$ coordinate grading slice at $n=12$, gives $\theta=1.228239158$, and adds *"No computation is needed for this."* $\sqrt{264/175}=1.2282391\ldots$, so the value and the maximality are the same object. **Confirmed.**

**What the fold owes and does not pay is a line.** Averaging would have been the defect; taking the supported side is not. But the block writes the witness as though it were common ground, and the *"both CONFIRMING and agreeing"* framing of [INDEX-results.md](../findings/INDEX-results.md) row 174 then presents a one-reviewer finding as a two-reviewer one, §10.

## 6. Finding 6, remark (b) as the closure condition

**Landed, faithfully, and it is [r762](REVIEW_r762.md)'s alone.** The block: *"And the comparison is the reduction's own closure condition, it holds at every $n\ge12$ and fails at every $4\le n\le11$."* That is [r762](REVIEW_r762.md) §5's finding in its own terms, including the direction ([I36](../plan.md) plus [L57](../findings/problem.md) leaves the band below the threshold uncovered unless $\sqrt{3/2}\le\Theta_n$).

**The clause the finding was about was removed from the block and survives in the Lean file.** [r762](REVIEW_r762.md) §5 located the overreach in *"covers strictly more maximisers, including every one at or above the conjecture's own value"*. The block's sentence now stops at *"covers strictly more maximisers"*. [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s `threshold_below_theta_zero` docstring still reads *"covers strictly more maximisers, including every one at or above the conjecture's own value"*.

**Argued the opposite, and I withdraw it as a defect.** That docstring's whole subject is $\theta_0(12)^2=220/144$; at $n=12$ the clause is **true**, as the closure table below confirms, and [r762](REVIEW_r762.md) itself judged the clause *"correct as written"* under the record's convention that Conjecture A means its $n\ge12$ clause. The repair it asked for (*"say $n\ge12$ once"*), is worth making in the Lean docstring for the same reason it was worth making in the block, but its absence is a stylistic residue and not a false statement. **Recorded as a note.**

## 7. Finding 7, what the reformulation buys

**Landed in full, all three qualifications, both reviewers' emphasis preserved.** The block: *"$\kappa^2$ is continuous but **not** differentiable, so the usual variational instruments do not apply to it"* ([r762](REVIEW_r762.md) §6, [r761](REVIEW_r761.md) §7); *"**Half the claim is already free**, $\kappa^2\le2$ is [L94](../findings/LEDGER.md) itself, so only $\kappa^2\ge2$ is owed"* ([r762](REVIEW_r762.md) §6, which called this *"the strongest thing the reformulation delivers"*); *"any **constructive** proof of that inequality exhibits a diagonalising frame, which is the original existential again, so the reformulation pays only where the argument is non-constructive"* ([r762](REVIEW_r762.md) §6). And *"**It does not make I36 less open**"* keeps remark (a)'s verdict, which both confirmed. **Nothing weakened, nothing strengthened.**

## 8. Finding 8 and attack item 6, the strictness, and the plan entry

**Landed in both places, and the obligation is the right one.**

The block carries it as its first blockquote, with $\kappa^2=1$ attributed to [r102](REVIEW_r102.md), the local-maximum status to [r316](REVIEW_r316.md), the survival of the equivalence against the death of the item, and the softness named, *"$\kappa^2=1$ is an ascent value, not that proof"*, which is [r761](REVIEW_r761.md) §9's *"one soft link"* preserved rather than dropped.

[plan.md](../plan.md)'s I36 entry: *"**AND THE STRICT INEQUALITY IS LOAD-BEARING**, which the item did not say: padded $W_{\mathbb{CP}^2}$ is a local maximum at $\theta=\sqrt{3/2}$ **exactly** ([r316](REVIEW_r316.md)) with $\kappa^2=1$ ([r102](REVIEW_r102.md)), so at $\theta\ge\sqrt{3/2}$ the item is **false**. *What it now owes is an analytic proof that this competitor is coordinate-diagonal in no frame.*"*

**Is that the right obligation?** Yes, and it is the minimal one. Refuting [I36](../plan.md) at a non-strict threshold needs padded $W_{\mathbb{CP}^2}$ to be coordinate-diagonal in **no** frame; by L94's equality case at the block's own normalisation that is exactly $\kappa^2\ne2$. The recorded $\kappa^2=1$ is a $40$-start ascent, and an ascent **under-reports** $\kappa$ ([r762](REVIEW_r762.md) §6, *"single-start ascent runs $7\%$ low at $n=12$"*), so the numerical value cannot close the gap in the direction needed. **The obligation as filed is the one that would.** The plan entry omits the *"ascent value, not that proof"* qualifier that the block carries, so a reader of [plan.md](../plan.md) alone may take $\kappa^2=1$ as settled; the owed-proof clause immediately following makes that reading unstable, so I record it as a note rather than a defect.

**The grade was not moved.** [plan.md](../plan.md) line 82 still reads $3\times1\times1\times1=3$ with `attackable` at $1$, which is what [r761](REVIEW_r761.md) §7 warned against moving, *"re-grading `attackable` upward on the strength of L174 would be grading a restatement"*. The entry's *"the `attackable` column can be re-read"* sits in tension with that caution, but no re-grade occurred. **Correct outcome.**

## 9. Attack item 4, the arithmetic, verified independently

Derived by hand, then screened in exact rationals; the screen reproduces every line and is recorded as a screen, never as evidence.

- $\theta_0(12)^2=\dfrac{2\cdot11\cdot10}{12^2}=\dfrac{220}{144}=\dfrac{55}{36}$, and $\dfrac{55}{36}-\dfrac32=\dfrac1{36}>0$. **Confirmed.**
- $\theta^2(S^p\times S^q)=\dfrac{2(p-1)(q-1)(n-1)}{pq(n-2)}$ at $(5,7)$, $n=12$: $\dfrac{2\cdot4\cdot6\cdot11}{35\cdot10}=\dfrac{528}{350}=\dfrac{264}{175}$. **Confirmed.**
- Strictly inside the band: $\dfrac32=\dfrac{525}{350}<\dfrac{528}{350}$, and $264\cdot36=9504<9625=55\cdot175$. **Confirmed at both ends.**
- The same formula at $(6,6)$ returns $\dfrac{2\cdot5\cdot5\cdot11}{36\cdot10}=\dfrac{550}{360}=\dfrac{55}{36}=\theta_0(12)^2$, so it reproduces the threshold and is not an independent convention. **Confirmed.**
- The closure condition $\Theta_n^2>\tfrac32$, both parities, $4\le n\le15$: $\tfrac34,\tfrac89,\tfrac{10}9,\tfrac65,\tfrac{21}{16},\tfrac{48}{35},\tfrac{36}{25},\tfrac{40}{27}$ all fail at $n=4,\dots,11$; $\tfrac{55}{36},\tfrac{120}{77},\tfrac{78}{49},\tfrac{21}{13}$ all hold at $n=12,\dots,15$. **So *"holds at every $n\ge12$ and fails at every $4\le n\le11$"* is confirmed as landed**, and the root computations behind it are right: $n^2-12n+8>0$ at $6+\sqrt{28}\approx11.29$ even, $n^2-13n+18>0$ at $\tfrac{13+\sqrt{97}}2\approx11.42$ odd, and no integer separates them from $12$.

## 10. Attack item 2, what landed that neither reviewer said

Two things, one of them §2's, and one of framing.

**(a) *"Neither states"*.** §2. False about the two reports it names.

**(b) *"Agreeing on four corrections"*.** The block's standfirst says the two reviewers were *"both CONFIRMING the equivalence and agreeing on four corrections"*, and [INDEX-results.md](../findings/INDEX-results.md) row 174 says *"Gate 2 PASSED, four corrections ([r761](REVIEW_r761.md), [r762](REVIEW_r762.md), both CONFIRMING and agreeing)"*, then lists them: the norm, attainment, idleness, the band.

- **Located.** [second-order.md](../findings/second-order.md)'s L174 standfirst and [INDEX-results.md](../findings/INDEX-results.md) row 174.
- **Exhibited.** Of the four, **two are one-reviewer findings**. Attainment: [r762](REVIEW_r762.md)'s H5, while [r761](REVIEW_r761.md)'s hypothesis inventory files $\max_F$-attainment under *"stated in the block: **asserted by the symbol $\max$**"*, the opposite classification. The band: [r761](REVIEW_r761.md)'s §6, which [r762](REVIEW_r762.md) §5 explicitly declines to assert. **And the one correction both reports filed as a defect (the Lean docstring, REFUTED in both claim tables), is not among the four.**
- **Argued the opposite.** Both reports do reach **PROVEN, hypotheses corrected**, and neither contradicts any of the four; *"agreeing"* could mean *"compatible with"*. But the sentence exists to tell a later reader how much independent weight each correction carries, and on that reading it overstates two of the four and omits the strongest.

**Repair:** *"both CONFIRMING the equivalence, agreeing on the norm, the idleness of the maximiser hypotheses and the refutation of the Lean docstring, with the attainment step and the band's witness contributed one apiece."*

## 11. Attack item 7, what the reviewers found and the fold dropped

The brief's list of nine was written by the folding cycle, and it inherits at least one omission that matters.

**(a) H2, the ordered-pair reading of $t$, dropped, and it is [r762](REVIEW_r762.md)'s own top-ranked hazard.** [r762](REVIEW_r762.md) §9.1: *"If $t_F$ were $\sum_{a<b}K_{ab}^2$ then $t_F\le1$ at unit norm, $\kappa^2=2$ would hold at no $W$, I36_budget would be false outright, and the equivalence would force I36_shape false, refuting the item by a convention. [conventions.md](../findings/conventions.md) fences this explicitly and L174 does not restate it. **This is the single most dangerous inherited hypothesis and it is unstated in L174.**"* Its verdict then bills it jointly with attainment: *"**H2 and H5, one sentence between them**, the ordered-pair reading of $t$, and attainment of $\max_F$."* **H5 landed and H2 did not**, and the brief's nine do not mention it. The block's Statement still writes $\kappa^2=\max_Ft_F$ with no word on which sum $t_F$ is.
  - **Partially mitigated, and I say so.** The cheaper-citation blockquote imports [conventions.md](../findings/conventions.md)'s $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$, and the factor $2$ there **is** the ordered convention in operator form, so a reader who follows the citation cannot get $t\le1$. **But the mitigation is incidental** (the clause is in the block to pin the letter $M$, not the summation range) and half of a jointly-billed repair landed while the half its author ranked first did not.
  - **Repair, one clause in the Statement:** *"with $t_F=\sum_{a\ne b}K_{ab}^2$ over **ordered** pairs, the unordered reading returning $\tfrac{t_F}2$ and a ceiling of $1$."*

**(b) The extremal reading as an invisible risk.** §4. Dropped from every artefact.

**(c) [r761](REVIEW_r761.md) §5's option on the threshold.** *"Weakening I36's threshold from $\sqrt{3/2}$ to $\theta_0(n)$ would leave the conjecture served and the item strictly easier, and the record nowhere records that this is available"*, qualified in the same paragraph by §6, that the band is inhabited, so the weakening drops a real maximiser. Neither the block nor [plan.md](../plan.md)'s I36 records the option or its price. It was flagged *"as an option, not a defect"*, so this is a dropped opportunity rather than a dropped correction, **but it is the one item in either report that would change what the plan does**, and the item it concerns is the top-graded one.

**(d) [r761](REVIEW_r761.md) §7's structural repair to the Lean file.** *"If the file is to earn its keep, state the specialisation's two ingredients as named hypotheses, a `NormOne : Weyl → Prop` with `IsUnit W → kappaSqBound W = 2`, and `kappaSq` defined as a supremum over `Frame` rather than as an opaque function, **so that the swap in attack item 1 becomes expressible**."* Not done; the file's parameters are unchanged. Coupled with §4, the effect compounds: the file cannot see the swap, and no longer says that it cannot.

**(e) [r762](REVIEW_r762.md) §8's note on `threshold_below_theta_zero`.** *"The theorem's name promises a comparison of thresholds and its statement is a comparison of numerals"*, the passage from squares to roots being unformalised. Trivial and unrecorded. **Note only.**

**(f) [r762](REVIEW_r762.md) §2's second-order observation on [conventions.md](../findings/conventions.md)**, that *"$\lVert K\rVert_F^2=2$ at a unit Weyl tensor"* is true on the diagonal locus and false off it, the record's own $\min_F\lVert K(F)\rVert_F=0$ exhibiting the failure. It is a flag against [conventions.md](../findings/conventions.md) rather than against L174, so its absence from an L174 fold is defensible; **it is now filed nowhere at all**, which is the thing worth saying.

**(g) [r761](REVIEW_r761.md) §7's caution on grading.** Landed by inaction, the grade did not move (§8). **No repair owed.**

## 12. Attack item 8, what would show the fold unfaithful

Ranked by how little would have to be true.

1. **A finding that landed as its neighbour.** Realised: §4. The test is to read each landed sentence back against the report's own words and ask whether the *pair* it names is the pair the reviewer named, not merely whether each member is true.
2. **A repair announced in the folding prose but absent from the artefact it names.** Realised: §3, where *"the lemma is stated above in the generality it has"* describes a Statement that was not changed.
3. **A claim about the reviewers rather than about the mathematics.** Realised: §2 and §10, *"neither states"*, *"agreeing on four corrections"*. These are the cheapest sentences to get wrong, because no derivation checks them.
4. **A one-reviewer finding presented as two-reviewer.** Realised in framing: §5 and §10(b). Harmless where the finding is supported, corrosive as a habit, since it retires the reason a second reviewer exists.
5. **A jointly-billed repair half paid.** Realised: §11(a), H5 in and H2 out.
6. **A finding landing in one artefact and not its siblings.** Partly realised: §6's clause, block against Lean file, withdrawn as a defect, the $n=12$ scope holding it up.
7. **A discharged hypothesis reopened as a debt.** Realised: §2, and it propagates into [lean/INDEX.md](../lean/INDEX.md).

**Not realised, and checked for:** no finding was weakened into silence, none was reversed in sign, no mathematics landed that either report refuted, and the arithmetic is exact and correct at every landed value (§9). The blockquotes at findings 7, 8 and 9 are the most faithful part of the fold and are the model the rest should be read against.

## Overall verdict

**GAP.**

**Six of the nine landed clean**, the norm, the idleness as a finding, the closure condition, the narrowness of what the reformulation buys, the load-bearing strictness with its obligation, and the cheaper citation, and every value that landed is exact and correct. **Three did not land as found**, in three different ways, and one owed item never landed at all:

- **§4, the substitution.** The Lean docstring and [lean/INDEX.md](../lean/INDEX.md) name the two invisible risks as *"unit"* and attainment. Both reviewers named *"unit"* and the extremal/per-frame swap. The swap (the risk with a record of having occurred and the one the abstraction structurally cannot see), is now recorded nowhere in the L174 material.
- **§2, the reopening.** Attainment landed as an unstated hypothesis with its discharge stripped and its silence attributed to [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md), **both of which state it in the very proof the clause cites**.
- **§3, the announcement.** The block says the lemma is now stated in the generality it has; the Statement is unchanged.
- **§11(a), the drop.** [r762](REVIEW_r762.md)'s H2, the ordered-pair reading of $t$, its own first-ranked breaking risk, billed in one sentence with the attainment step that did land, is absent from the record and from the brief's list of nine, exactly as the brief's attack item 7 anticipated.

**Nothing false about the mathematics entered the record**, and no finding was reversed or silently dropped in the deleting direction. **What entered is three sentences about the reviewers and the risks that are not what the reviewers wrote**, and they are repairable by editing three sentences and adding two clauses. The fold is faithful in substance and unfaithful in its account of itself, which is the same defect [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s docstring was corrected for.
