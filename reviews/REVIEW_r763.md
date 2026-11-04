# Review 763, whether [Lemma L174](../findings/second-order.md)'s Gate 2 findings were applied faithfully

**Cold brief.** [BRIEF-g2-l174fold.md](BRIEF-g2-l174fold.md) was read in full before any file of the record, and before either of [REVIEW_r761.md](REVIEW_r761.md) and [REVIEW_r762.md](REVIEW_r762.md). **No numerical work was done**, no sweep, no search, no falsifier hunt. Every value below is exact rational arithmetic; the one screen is named as a screen where it appears. The Lean toolchain is at `~/.elan/bin` and [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) was **built in the kernel**, not audited at statement level: `lake build HamiltonsCubic.Results.L174` completes, 825 jobs. Log: [agent_logs/g2-l174fold-r763.log](../agent_logs/g2-l174fold-r763.log).

| # | claim | verdict |
|---|---|---|
| 1 | Finding 1, the norm, the statement now pins $\lVert M\rVert_F=1$ | **LANDED, ONE CLAUSE STRENGTHENED INTO A FALSEHOOD**, *"[conventions.md](../findings/conventions.md) does not table it; its one tabled sense returns $4$"* is refuted by that file's own two-spectra bullet and by its $t,\kappa$ row |
| 2 | Finding 2, L94's unstated attainment of $\max_F$ | **LANDED**, faithfully placed in the proof; both reviewers also *discharged* it and the record does not say so |
| 3 | Finding 3, the maximiser hypotheses are idle | **LANDED AS A REMARK, AND THE BLOCK MISDESCRIBES ITSELF**, the displayed statement was never restated; it still quantifies over I36's class |
| 4 | Finding 4, the Lean docstring's *"the whole risk"* refuted, the risk inside `def L94` | **LANDED WITH ITS CONTENT SUBSTITUTED**, both reviewers named the two invisible risks as the **normalisation** and the **per-frame/extremal swap**; the record names the normalisation and *attainment*, and the swap is gone from all three sites |
| 5 | Finding 5, the band is inhabited by $S^5\times S^7$ | **LANDED WITHOUT ITS SUPPORT**, the sentence never says *local maximiser* and drops [L69](../findings/graded-half.md), which is the whole of why the witness is one; and the reviewers disagreed here |
| 6 | Finding 6, remark (b) is the closure condition and its trailing clause is false at $4\le n\le11$ | **LANDED IN THE MARKDOWN, NOT IN THE LEAN FILE**, [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) line 66 still carries the refuted clause verbatim |
| 7 | Finding 7, what the reformulation buys is narrow | **LANDED**, all three qualifications, faithfully |
| 8 | Finding 8, the strictness of $\theta>\sqrt{3/2}$ is load-bearing | **LANDED**, block and plan; the plan attributes the new obligation to the item rather than to the strictness claim |
| 9 | Finding 9, the cheaper citation $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$ | **LANDED**, faithfully |
| 10 | Attack item 3, what the fold did with the two disagreements | **BOTH RESOLVED SILENTLY**, one of them onto the refutable side; neither disagreement is recorded anywhere |
| 11 | Attack item 4, the arithmetic that landed | **CONFIRMED EXACTLY**: $\tfrac{220}{144}=\tfrac{55}{36}$, $\theta^2_{5,7}=\tfrac{264}{175}$, $\tfrac32<\tfrac{264}{175}<\tfrac{55}{36}$, and the $n\ge12$ closure at both parities |
| 12 | Attack item 7 (findings dropped entirely | **THREE, TWO OF THEM FOUND BY BOTH REVIEWERS**), the ordered-pair reading of $t$, that the weaker hypothesis makes the item **harder**, and that weakening the threshold to $\theta_0(n)$ is available |

**Actionable in one line.** Seven of nine findings landed and the mathematics is right, but the fold substituted *attainment* for the **per-frame/extremal swap** in the Lean docstring and in [lean/INDEX.md](../lean/INDEX.md), left finding 6's refuted clause standing inside the Lean file it was about, wrote an unqualified falsehood about [conventions.md](../findings/conventions.md) into the lemma's own statement, and dropped the one hypothesis [r762](REVIEW_r762.md) ranked most dangerous.

## 0. Conventions, fixed once

Read from [conventions.md](../findings/conventions.md) before anything below was derived, and quoted rather than recalled.

- **The vertex matrix**: $K$ is the symmetric hollow $n\times n$ sectional matrix $K_{ab}=W_{abab}$, and $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, *"the sum over **ordered** pairs"*. The same section's box: *"Writing $K$ as $(W_{abab})_{a<b}$ reads as an index set over unordered pairs, whose square sum is $\tfrac t2\le1$, so the bound $t\le2$ and that reading are inconsistent."* In operator form, $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$.
- **Per-frame against extremal**, the $t,\kappa$ row of the symbol table: *"$t=t_F=\lVert K(F)\rVert_F^2$ per frame, and $\kappa^2=\max_Ft_F$. [Lemma L94](../findings/bispectral.md) gives $\kappa^2\le2\lVert M\rVert_F^2$ with equality exactly at coordinate-diagonal $W$, so $t_F\le2$ in every frame. **The per-frame and extremal readings are distinct and have been swapped**."*
- **The letter $M$, the collision row**: *"$M$ (or $K$) is the $n\times n$ **sectional** matrix in [diagonal-half.md](../findings/diagonal-half.md), where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor; $W$ is the operator on $\Lambda^2$, where $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$."*
- **The two spectra**, in the normalisations list of the same file: *"$\mu=\mathop{\mathrm{spec}}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$, $\omega=\mathop{\mathrm{spec}}(\mathring W)$, with $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$."* **This is §1's whole point.**
- **The sphere-product value**, [target.md](../findings/target.md): $\theta^2(S^p\times S^q)=\dfrac{2(p-1)(q-1)(n-1)}{pq(n-2)}$ at $n=p+q$.
- **The maximiser fact**, [graded-half.md](../findings/graded-half.md): *"Lemma L69 makes **each** sphere product with both factors $\ge5$ a local maximum"*, in a line that names $S^5\times S^7$ at $\theta=1.228239158$ in the $(6,6)$ coordinate grading slice.

## Hypothesis inventory, what this audit consumes

| ingredient | source | status here |
|---|---|---|
| The two reports are the authority on what was found | the brief | assumed; both read in full |
| The three commits `22864d05`, `36875710`, `acb2c498` are the whole of the fold | the brief, confirmed by `git show --stat` | confirmed, they touch [ATTEMPTS.md](../ATTEMPTS.md), [second-order.md](../findings/second-order.md), [INDEX-results.md](../findings/INDEX-results.md), [L174.lean](../lean/HamiltonsCubic/Results/L174.lean), [lean/INDEX.md](../lean/INDEX.md), [plan.md](../plan.md) and nothing else |
| $\theta_0(n)^2=2(n-1)(n-2)/n^2$ and $\Theta_n$'s odd form $2(n-1)(n-3)/((n+1)(n-2))$ | [conventions.md](../findings/conventions.md), [problem.md](../findings/problem.md) | used only in §11's arithmetic check, which reproduces [r762](REVIEW_r762.md)'s derivation |
| The mathematics of L174 itself | [r761](REVIEW_r761.md), [r762](REVIEW_r762.md), both `PROVEN (hypotheses corrected` | **not re-audited**), this brief audits an application |

## 1. Finding 1, the norm landed, and one clause landed as a falsehood

**What the reviewers wrote.** [r761](REVIEW_r761.md): *"Repair, one clause: 'For $W$ with $\lVert M\rVert_F=1$, equivalently unit in the record's $\Lambda^2$ operator norm', in the block and in the `IsUnit` docstring."* [r762](REVIEW_r762.md): *"CONFIRMED, hypothesis supplied: true, and true only under a sense of the letter $M$ that [conventions.md](../findings/conventions.md) does not table; its one tabled sense gives $4$."*

**What the record now says**, [second-order.md](../findings/second-order.md), L174's Statement: *"normalise so that $\lVert M\rVert_F=1$ for the operator $M$ that L94's bound is stated over, **the sense of "unit" is load-bearing here and [conventions.md](../findings/conventions.md) does not table it; its one tabled sense returns $4$ rather than $2$**."*

**The normalisation itself landed.** $\lVert M\rVert_F=1$ is now in the statement line, and the later block adds *"The working sense is the $\Lambda^2$ operator matrix"*. That is [r761](REVIEW_r761.md)'s repair almost verbatim, and it forecloses both misreadings, the sectional one at $\kappa^2\le4$ and [post F33](../findings/INDEX-traps.md)'s $\lvert W\rvert_4=1$ at $\kappa^2=\tfrac12$, which [r761](REVIEW_r761.md) ranked as the live failure and which the fold does not mention. Since the sense is now pinned, the unmentioned $\tfrac12$ reading is no defect.

**The clause attached to it is false, and it is in the lemma's statement.** [conventions.md](../findings/conventions.md) tables the working sense in two places.

1. **The two-spectra bullet**, quoted in §0: *"$\mu=\mathop{\mathrm{spec}}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$ … $\sum\mu^2=1$."* That attaches the letter $M$ to the $\Lambda^2$ operator **and** fixes $\lVert M\rVert_F=1$ at a unit tensor. Under it L94's ceiling is $2\cdot1=2$, not $4$.
2. **The $t,\kappa$ row of the symbol table itself**, quoted in §0, which states L94 as $\kappa^2\le2\lVert M\rVert_F^2$ and concludes *"so $t_F\le2$ in every frame"*. That inference **is** the step $\lVert M\rVert_F=1$; a table row cannot draw it without committing to the sense. So the file not only tables the working sense, it uses it, in the row L174 is downstream of.

So *"conventions.md does not table it"* is refuted, and *"its **one** tabled sense returns $4$"* is refuted twice over: there are two, and the other returns $2$.

**Argued the opposite, in its strongest form.** The defence is that *"table"* means the row headed *"The letter $M$ carries two objects"* (the collision row) which attaches $M$ to the sectional matrix alone and calls the $\Lambda^2$ object $W$. That reading is available for [r762](REVIEW_r762.md)'s sentence, which says *"a sense of the letter $M$ that conventions.md does not table"* while its own §2 names the row it means. **It is not available for the record's sentence**, which names the file, not the row, and says *"its one tabled sense"*, a claim about everything in the file. The record's own next block gets this right: *"under **the table's one attached sense** of $M$"* is exactly the careful form. The two sentences in one block disagree about what was checked.

**Located, and the repair is one word.** [second-order.md](../findings/second-order.md), L174's Statement line: *"conventions.md does not table it"* → *"conventions.md's letter-$M$ collision row does not carry it, that row's one attached sense returns $4$, while the file's two-spectra bullet carries the working sense at $\lVert M\rVert_F=1$."*

## 2. Finding 2, attainment landed, and its discharge did not

**What landed**, in the proof: *"carrying one hypothesis neither states: **attainment of $\max_F$**, used in the direction that produces a diagonalising frame."* That is [r762](REVIEW_r762.md)'s claim 4 and [r761](REVIEW_r761.md)'s second edge, word for word in substance, including the one-direction-only qualifier. **Faithful.**

**One asymmetry, in the debt direction.** Both reviewers not only stated the hypothesis but discharged it. [r762](REVIEW_r762.md): *"a continuous function on a compact set attains its supremum. So the record's writing $\max$ rather than $\sup$ is justified, and **H5 is discharged rather than owed**."* [r761](REVIEW_r761.md): *"Confirmed and needed … $O(n)$ is compact, so the maximum is attained."* The record states the hypothesis and stops, so a later reader meets an open debt where the audit closed one. **Repair: six words**, *"discharged by compactness of $O(n)$ and continuity of $F\mapsto t_F$"*. Recorded as understatement rather than as a defect.

## 3. Finding 3, the idleness landed as a remark, and the block claims a restatement it did not perform

**What the reviewers asked for.** [r761](REVIEW_r761.md), repair 2: *"**State it that way.** … 'For every unit $W$, $\kappa^2=2$ iff $W$ is coordinate-diagonal in some frame. Hence for **any** class $\mathcal C$ of unit tensors, $(\forall W\in\mathcal C:\exists F\,\mathrm{diag})\iff(\forall W\in\mathcal C:\kappa^2=2)$, and I36 is the instance $\mathcal C=\{$local maximisers with $\theta>\sqrt{3/2}\}$.'"* [r762](REVIEW_r762.md) §7 states the same general form.

**What landed.** A new pull-quote (*"AND THE MAXIMISER HYPOTHESES ARE DECORATION … the equivalence holds at **every** unit $W$"*), plus the proof's closing *"on any class of $W$ whatever including the empty one"*, plus the Lean docstring's *"the maximiser hypotheses are idle"*, plus the row in [INDEX-results.md](../findings/INDEX-results.md). The **content** landed everywhere it should.

**The displayed statement did not change.** `git show 22864d05` carries the display line as unmodified context, and it still reads

$$\big(\text{every local maximiser with }\theta>\sqrt{3/2}\text{ is coordinate-diagonal in some frame}\big)\iff\big(\text{every such maximiser has }\kappa^2=2\big).$$

That is I36's class, exactly the form both reviewers said is one line longer than the lemma. **Yet the same pull-quote asserts** *"the lemma is stated above in the generality it has rather than in the one [I36](../plan.md) happens to need."* Read against the display, that sentence is false: the lemma is stated above in precisely the one I36 happens to need.

**Argued the opposite.** *"Above"* could reach the proof's closing clause, which does carry the generality, so the sentence might mean *the block establishes it above*. Two things defeat that. First, the sentence says *"the lemma is **stated**"*, and the lemma's statement is the display. Second, the contrast it draws (*"rather than in the one I36 happens to need"*), is a claim that the I36-shaped form was **not** used, and it was.

**Severity.** This is the record asserting a repair it did not make, which is precisely the class of error a fold audit exists to catch. **Repair: perform the restatement [r761](REVIEW_r761.md) wrote out, or change the sentence to "the proof establishes it in the generality it has".**

## 4. Finding 4, the docstring was corrected, and one of the two risks was swapped for a different one

**This is the most serious finding in this review.**

**What both reviewers wrote, independently.** [r762](REVIEW_r762.md) §8, enumerating: *"There are three risks in this reformulation, and the abstraction can see one. **(i) The per-frame/extremal swap, invisible**, because `kappaSq` is an opaque `Weyl → ℝ` and nothing in the file distinguishes $\max_Ft_F$ from $t_F$ … **(ii) The normalisation of §2, invisible** … (iii) The quantifier step, visible, and checked. … So the sentence claims kernel cover for exactly the two risks the kernel cannot see, and **the record's standing warning is that (i) has already happened once**."* [r761](REVIEW_r761.md) §7, point 3: *"The two steps that do carry risk are inside `def L94` … The passage from one to the other is **the unit-norm step of section 2 and the extremal reading of section 1**, and both are assumed rather than checked."* And [r761](REVIEW_r761.md) §1: *"A swapped reading, `kappaSq` meaning the per-frame $t_F$ of a distinguished frame, typechecks identically and the theorem still goes through. **The kernel is blind to attack item 1 by construction.**"*

**Both name the same two: the normalisation, and the per-frame/extremal swap.**

**What the record now says.** [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) lines 15–21: *"That step is a first-order tautology and is the **smallest** of the three risks … **The two the abstraction cannot see are the sense of "unit" that makes `2‖M‖²` equal `2`, and `L94`'s own unstated attainment of `max_F`.**"* The same substitution is in [lean/INDEX.md](../lean/INDEX.md)'s L174 row (*"the other two), the sense of "unit" and L94's unstated attainment of $\max_F$ (being invisible to the abstraction"*) and in [ATTEMPTS.md](../ATTEMPTS.md)'s entry for the fold.

**Exhibited.** The record's enumeration is closed (*"the three risks"*, *"the two the abstraction cannot see"*), so replacing one member deletes the other. What is deleted is the $t_F/\kappa^2$ swap: the hazard [conventions.md](../findings/conventions.md)'s $t,\kappa$ row boxes in capitals (*"have been swapped"*), the hazard [DERIVE-mx1.md](DERIVE-mx1.md) is fenced for, the hazard the parent brief for L174 was written around, and the one thing both reviewers said the Lean file **cannot** detect. After the fold, a reader of [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) or of [lean/INDEX.md](../lean/INDEX.md) is told the file's blind spots are the normalisation and attainment, and is thereby told (by the closure of the list) that the swap is either visible to the kernel or not a risk. **Neither is true.** The words *"per-frame"*, *"$t_F$"* and *"swap"* do not occur anywhere in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) or in [lean/INDEX.md](../lean/INDEX.md)'s L174 row.

**Argued the opposite, in its strongest form.** Attainment **is** genuinely invisible to the file: `def L94` asserts the biconditional outright, so whatever compactness argument supports it is assumed along with everything else. So the substituted item is a true statement, not a fabrication. Two things keep this a defect anyway. First, neither reviewer listed attainment among the invisible risks, [r762](REVIEW_r762.md) files it separately as H5 and [r761](REVIEW_r761.md) as an edge in §9, so the enumeration no longer reports what the audit found. Second, and decisively, **attainment and the swap are different objects**: attainment asks whether $\sup_Ft_F$ is achieved, the swap asks whether the symbol $\kappa^2$ denotes $\max_Ft_F$ or some frame's own $t_F$. A file could have attainment and still be swapped, and [r762](REVIEW_r762.md) exhibits the failure that follows, *"substitute the per-frame reading and the file compiles unchanged while the record's claim becomes false"*.

**Located.** [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) line 18; [lean/INDEX.md](../lean/INDEX.md)'s L174 row; [ATTEMPTS.md](../ATTEMPTS.md)'s *"the other two, the sense of "unit", and L94's attainment"*. **Repair: restore the swap as the second invisible risk and carry attainment as a third**, which is what the two reports between them support.

**What did land, and correctly.** The rest of finding 4 is faithful and is an improvement on both reports' phrasing: *"`L94` below is taken as a hypothesis, and it is **not** the recorded L94 but its unit-norm specialisation, a statement carrying no Gate 2 of its own"* is [r761](REVIEW_r761.md) §7 point 3 exactly, and the *"whole risk"* claim is gone. **One residue:** [lean/INDEX.md](../lean/INDEX.md) still closes with *"**Owed: L94 itself**, imported rather than reproved"*, the same phrasing [r761](REVIEW_r761.md) called inaccurate, since what is imported is the specialisation. The docstring was fixed and the index row beside it was not.

## 5. Finding 5, the witness landed, its support did not, and the reviewers disagreed about it

**What the reviewers wrote, and they do not agree.** [r761](REVIEW_r761.md) §6: *"**Confirmed, with an on-record witness the remark does not name.** Strict inclusion of the hypothesis regions does not by itself give strictly more *maximisers*; a local maximiser strictly inside the band … is needed. The record has one … **And it is a local maximiser**: [graded-half.md](../findings/graded-half.md) records that [Lemma L69](../results.md) 'makes each sphere product with both factors $\ge5$ a local maximum', and $(5,7)$ has both factors $\ge5$."* [r762](REVIEW_r762.md) §5: *"'Covers strictly more maximisers' is a statement about the region; **whether that region contains any maximiser at all is unknown**, and the remark should not be read as asserting one exists."*

**What landed.** *"**The band is not empty and the record holds its witness**: $S^5\times S^7$ at $n=12$ has $\theta^2=\tfrac{264}{175}$, strictly between $\tfrac32$ and $\tfrac{55}{36}$."*

**Exhibited.** The landed sentence never says *local maximiser* and never cites [L69](../findings/graded-half.md). Read literally it asserts that the open interval $(\tfrac32,\tfrac{55}{36})$ contains the $\theta^2$ of one sphere product, true, and insufficient for the claim it is attached to, which is *"covers strictly more **maximisers**"*. The half of [r761](REVIEW_r761.md)'s finding that does the work, that $S^5\times S^7$ is a local maximum, by [L69](../findings/graded-half.md) at both factors $\ge5$, is the half that did not land.

**Adjudicating the disagreement, since the fold did not.** [r761](REVIEW_r761.md) is right. [graded-half.md](../findings/graded-half.md) carries, in one line, both that *"Lemma L69 makes **each** sphere product with both factors $\ge5$ a local maximum"* and that the $(6,6)$ slice at $n=12$ contains $S^5\times S^7$ at $\theta=1.228239158$, with *"Two of them clear $\sqrt{3/2}$"*. So the band is inhabited by a local maximiser and [r762](REVIEW_r762.md)'s *"unknown"* is superseded by a record fact it did not reach. **The fold took the right side and dropped the citation that makes it right**, leaving a bare assertion in place of a sourced one.

**Repair: eight words**, *"a local maximum by [L69](../findings/graded-half.md), both factors $\ge5$"*. And record the disagreement, per §10.

## 6. Finding 6, landed in the markdown, and left standing in the Lean file it was about

**What [r762](REVIEW_r762.md) wrote.** *"**One clause therefore overreaches.** 'Covers strictly more maximisers, including every one at or above the conjecture's own value' is true at every $n\ge12$ and false at every $4\le n\le11$ … **the repair is to say $n\ge12$ once**, since the sentence's own evidence is an $n=12$ evaluation."*

**What landed in [second-order.md](../findings/second-order.md).** The trailing clause was **deleted**, and the closure condition added: *"And the comparison is the reduction's own closure condition, it holds at every $n\ge12$ and fails at every $4\le n\le11$."* Since the coverage claim and the closure condition are the same inequality, covering every maximiser at or above $\Theta_n$ needs $\Theta_n>\sqrt{3/2}$, which is the closure condition, the information survives, attached to a different sentence. I record this as **defensible**: the brief warns about the deleting direction, and this deletion carries its content forward rather than losing it. [r762](REVIEW_r762.md)'s literal repair (qualify, do not delete), was not the one taken, and the record is no weaker for it.

**But the same clause is still in the Lean file**, [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) lines 64–67:

> *"So the hypothesis `θ > √(3/2)` is weaker than `θ ≥ θ₀(12)` and covers strictly more maximisers, **including every one at or above the conjecture's own value.**"*

**Located, exhibited, and it is the same words.** `threshold_below_theta_zero`'s docstring is the source [second-order.md](../findings/second-order.md)'s sentence was copied from, and `acb2c498` edited that very file (the module docstring, twelve lines above), without touching it. So the refuted clause now stands in exactly one place in the record, and it is the machine-checked layer, whose whole purpose [r762](REVIEW_r762.md) describes as *"a file whose whole purpose is to be quotable in isolation"*. **This is finding 6 landing at one of its two sites.**

**Argued the opposite.** The theorem it decorates, `(3 : ℚ) / 2 < 220 / 144`, is true and is about $n=12$ alone, where the clause holds; and a reader who takes the docstring as scoped to $n=12$ is not misled. But the clause is written without a dimension, in a file whose other statements are universally quantified schemas, and the record has just judged the identical sentence overreaching. **Repair: delete the clause, or append *"at $n\ge12$"*.**

## 7. Finding 7, landed in full

All three qualifications are in the block, in [r762](REVIEW_r762.md) §6's own order and with its own emphases: *"$\kappa^2$ is continuous but **not** differentiable"*; *"**Half the claim is already free**, $\kappa^2\le2$ is [L94](../findings/LEDGER.md) itself, so only $\kappa^2\ge2$ is owed"*; *"any **constructive** proof of that inequality exhibits a diagonalising frame, which is the original existential again"*. The heading was rewritten to *"STATED NARROWLY BECAUSE IT IS NARROW"* and the block attributes them, *"Three qualifications, all from the audit"*. **Nothing weakened, nothing strengthened.**

**One residue outside the block.** [plan.md](../plan.md)'s I36 entry still reads *"$\kappa^2=2$ is an extremal condition on a **continuous** function the record already estimates"*, unqualified, the exact phrasing [r762](REVIEW_r762.md) says *"invites"* differentiating at a local maximiser, which is unavailable. The plan is where the item is worked from. **Repair: three words, "though not differentiable".**

## 8. Finding 8, landed, with the obligation attached to the wrong claim

**What landed** in [second-order.md](../findings/second-order.md) is faithful to [r761](REVIEW_r761.md) §9 and sharper than it: *"Padded $W_{\mathbb{CP}^2}$ is a local maximum at $\theta=\sqrt{3/2}$ **exactly** ([r316](REVIEW_r316.md)) with $\kappa^2=1$ ([r102](REVIEW_r102.md)) … **So at $\theta\ge\sqrt{3/2}$ both sides of the equivalence are false**, L174 survives, being an equivalence, and the item does not. *What is owed is an analytic proof that this competitor is coordinate-diagonal in no frame; $\kappa^2=1$ is an ascent value, not that proof.*"* The final clause is better than [r761](REVIEW_r761.md)'s own, an ascent bounds $\kappa^2$ from **below**, so it cannot establish $\kappa^2<2$, which is what the argument needs.

**The plan entry attributes the debt to the item.** [plan.md](../plan.md), I36: *"**What it now owes** is an analytic proof that this competitor is coordinate-diagonal in no frame."* I36 as filed carries the strict inequality, so padded $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$ **exactly** is outside its hypothesis and cannot bear on its truth. What owes the proof is the *claim that the strictness is load-bearing*, [r761](REVIEW_r761.md) says so in as many words: *"it is what makes the strictness of I36's threshold a **theorem** rather than a numerical observation"*. So the fold moved a debt from a remark onto the item. **Repair: "What the strictness claim owes".** Small, and in the strengthening direction, which the brief names as the mirror failure.

**One attribution error, in [ATTEMPTS.md](../ATTEMPTS.md).** *"**The second L174 reviewer** found the sharpest thing in either report"*, the finding is [r761](REVIEW_r761.md)'s, its §9, and [r762](REVIEW_r762.md) mentions padded $W_{\mathbb{CP}^2}$ nowhere in connection with the threshold. Cosmetic, but it misdirects anyone tracing the finding.

## 9. Finding 9, landed in full

*"[conventions.md](../findings/conventions.md) carries $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$, which pins the sense of the letter independently"*, with the consequence spelled out. That is [r762](REVIEW_r762.md)'s *"The cheapest repair is to cite the vertex-matrix section's $t\le2$ rather than L94's $2\lVert M\rVert_F^2$ form, since that line carries no ambiguous letter."* **Faithful**, and the block's version of the caveat (*"under **the table's one attached sense** of $M$"*), is the accurate phrasing §1 wishes the Statement had used.

## 10. Attack item 2 and attack item 3, what landed unsourced, and what the fold did with the disagreements

**Attack item 2, claims tracing to neither report nor the record.** Three, all identified above and none of them fabricated mathematics:

- *"the lemma is stated above in the generality it has"*, §3. Traces to a reviewer **recommendation**, recorded as though it were a reviewer **finding about the record's state**.
- *"conventions.md does not table it"*, §1. Traces to [r762](REVIEW_r762.md)'s hedged sentence, promoted to an unqualified claim the file refutes.
- *"L94's own unstated attainment of `max_F`"* as one of the two risks invisible to the abstraction, §4. Traces to a true statement of [r762](REVIEW_r762.md)'s H5, **relocated** into a closed enumeration where it displaces the swap.

Everything else in the block, the plan entry, the Lean docstring and the two index rows traces to one report or to a cited record line. The arithmetic all traces and all checks (§11).

**Attack item 3, the two disagreements.**

| the disagreement | [r761](REVIEW_r761.md) | [r762](REVIEW_r762.md) | what the fold did | who is right |
|---|---|---|---|---|
| Does [conventions.md](../findings/conventions.md) table the working sense of $M$? | **Yes**, at the two-spectra bullet: *"line 92 of conventions.md puts that file at $\lVert M\rVert_F=1$ … The intended reading is recoverable and correct"* | **No**: *"a sense of the letter $M$ that conventions.md does not table"* | took [r762](REVIEW_r762.md), silently, into the lemma's **statement** | **[r761](REVIEW_r761.md)**, §1 |
| Is the band inhabited by a **maximiser**? | **Yes**, $S^5\times S^7$, a local maximum by [L69](../findings/graded-half.md) | **Unknown**: *"whether that region contains any maximiser at all is unknown"* | took [r761](REVIEW_r761.md), silently, and dropped the citation | **[r761](REVIEW_r761.md)**, §5 |

**Neither disagreement is recorded anywhere in the fold**, and the block's standfirst says the reverse: *"both CONFIRMING the equivalence and **agreeing on four corrections**"*. They did agree on four; they also disagreed on two, and one of those disagreements decides the truth of a sentence now in the lemma's statement. **A fold that reports only the agreements has thrown away the part of a two-reviewer design that is worth having.**

## 11. Attack item 4, the arithmetic, verified independently and exactly

Derived from the formulas in §0, then screened in exact rationals; the screen reproduces every line and is recorded as a screen, never as evidence.

$$\theta_0(12)^2=\frac{2\cdot11\cdot10}{144}=\frac{220}{144}=\frac{55}{36},\qquad \frac{55}{36}-\frac32=\frac{55-54}{36}=\frac1{36}>0.$$

$$\theta^2(S^5\times S^7)=\frac{2\cdot4\cdot6\cdot11}{5\cdot7\cdot10}=\frac{528}{350}=\frac{264}{175}.$$

**Strictly inside the band, at both ends, by cross-multiplication only:** $264\cdot2=528>525=3\cdot175$, so $\tfrac{264}{175}>\tfrac32$; and $264\cdot36=9504<9625=55\cdot175$, so $\tfrac{264}{175}<\tfrac{55}{36}$. **Both strict.**

**The formula is not an independent convention.** At $(6,6)$ it returns $\dfrac{2\cdot5\cdot5\cdot11}{6\cdot6\cdot10}=\dfrac{550}{360}=\dfrac{55}{36}=\theta_0(12)^2$, reproducing the band's upper endpoint, so the same expression supplies both numbers and a slip in it would move them together.

**The $n\ge12$ closure condition**, which landed and which neither the brief's list nor the block derives. Even $n$: $\Theta_n^2>\tfrac32\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, which at $n=11$ is $-3$ and at $n=12$ is $8$. Odd $n$: $\Theta_n^2>\tfrac32\iff4(n-1)(n-3)>3(n+1)(n-2)\iff n^2-13n+18>0$, which at $n=11$ is $-4$ and at $n=13$ is $18$. **So the condition holds at every $n\ge12$ and fails at every $4\le n\le11$**, exactly as landed. *(Screened in exact rationals; the screen reproduces all six values.)*

**Nothing in the landed arithmetic is wrong.**

## 12. Attack item 5, does the Lean docstring now describe what the file proves

**Built, not read: `lake build HamiltonsCubic.Results.L174` completes, 825 jobs.** The file is `sorry`-free and contains no `axiom` and no `native_decide`.

**What the file proves.** `shape_iff_budget` is a schema over seven opaque parameters whose whole proof is `constructor` and two `exact`s composing `h94 W hu`; `threshold_below_theta_zero` is `(3 : ℚ) / 2 < 220 / 144` by `norm_num`. **The replacement docstring is a large improvement and does not overclaim about the kernel**: it says the quantifier step is a tautology and the smallest of three risks, it says `def L94` is a specialisation carrying no Gate 2, and it says the maximiser hypotheses are idle, all three true of what I read and of what built.

**Two things in it are still wrong, and both are §4 and §6.**

1. **Line 18 misnames one of the two invisible risks**, attainment in place of the per-frame/extremal swap. So the docstring's account of *what the kernel cannot see* is itself incomplete, in the one direction the record has a standing warning about.
2. **Lines 64–67 still carry the clause finding 6 refuted**, in the docstring of the only theorem in the file with numerical content.

**So the answer to the attack item is: the previous docstring overclaimed and the replacement does not, but the replacement mis-enumerates and one docstring below it was not touched at all.**

## 13. Attack item 6, the I36 entry

**The obligation is recorded**, *"What it now owes is an analytic proof that this competitor is coordinate-diagonal in no frame"*, and **it is the right obligation**: $\kappa^2=1$ at padded $W_{\mathbb{CP}^2}$ is an ascent value, ascent bounds $\kappa^2$ from below, and what the strictness argument needs is $\kappa^2<2$, which no ascent supplies. [r761](REVIEW_r761.md) named exactly this and named the corroboration that does not close it ([L95](../findings/bispectral.md)'s $3/(m+1)$ at the **unpadded** point, plus $\kappa^2(\text{padded})\ge\kappa^2(\text{unpadded})$, which runs the wrong way).

**Two things about the entry are off.**

- **The debt is attached to the item rather than to the strictness claim**, §8. I36 as filed is untouched by a competitor sitting at $\theta=\sqrt{3/2}$ exactly.
- **The entry records none of what both reviewers said about remark (b)'s direction.** See §14(b) and §14(c): that the weaker hypothesis makes the item **harder**, and that a strictly easier item is available at threshold $\theta_0(n)$.

**One thing the entry got right by not doing it.** [r761](REVIEW_r761.md) §7 warned that *"re-grading `attackable` upward on the strength of L174 would be grading a restatement"*. The grade is unchanged at $3=3\times1\times1\times1$ with `attackable` still $1$, and the pre-existing sentence *"the `attackable` column can be re-read"* was not touched. **The caution is honoured in conduct and recorded nowhere**, which leaves the next cycle free to do what it warns against.

## 14. Attack item 7, what the reviewers found and the fold dropped entirely

The brief's list of nine omits all three of these, and the brief says why that might be. **Two of the three were found independently by both reviewers**, which is the strongest signal this record has.

**(a) The ordered-pair reading of $t$, [r762](REVIEW_r762.md)'s H2, and the thing it ranked most dangerous of all.** *"**The unordered reading of $t$.** If $t_F$ were $\sum_{a<b}K_{ab}^2$ then $t_F\le1$ at unit norm, $\kappa^2=2$ would hold at no $W$, I36_budget would be false outright, and the equivalence would force I36_shape false, refuting the item by a convention. [conventions.md](../findings/conventions.md) fences this explicitly and L174 does not restate it. **This is the single most dangerous inherited hypothesis and it is unstated in L174.**"* It is also in [r762](REVIEW_r762.md)'s closing repair list: *"H2 and H5, one sentence between them"*. **H5 landed; H2 did not.** The word *ordered* occurs nowhere in the L174 block, the I36 entry, [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) or [lean/INDEX.md](../lean/INDEX.md)'s row.

This is the sharpest omission because [conventions.md](../findings/conventions.md) records that the ambiguity has already cost the record once (*"THE ORDERED SUM IS THE WHOLE OF THE NORMALISATION AND WAS AMBIGUOUS HERE"*) and because the fold's own newly added citation, $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$, is the ordered form. The block now leans on the constant without naming the convention that produces it. **Repair: one clause in the proof, "with $t_F$ the ordered sum, [conventions.md](../findings/conventions.md)'s reading; the unordered one gives $t_F\le1$ and empties the equality case."**

**(b) That the weaker hypothesis makes I36 a harder item, found by both.** [r761](REVIEW_r761.md): *"A weaker hypothesis on a universally quantified statement makes the **theorem stronger and the item harder**, and neither the block, nor [plan.md](../plan.md), nor the Lean docstring says so."* [r762](REVIEW_r762.md): *"A weaker hypothesis makes I36 a **stronger theorem** and therefore a **harder item**, which the remark does not say."* After the fold, still neither the block, nor [plan.md](../plan.md), nor the Lean docstring says so; the strings *harder* and *stronger theorem* appear in none of them. The record continues to present *"covers strictly more maximisers"* as a bonus, which is the reading both reviewers went out of their way to correct.

**(c) That a strictly easier item is available, [r761](REVIEW_r761.md).** *"**I36 as filed proves more than Conjecture A consumes.** … **Weakening I36's threshold from $\sqrt{3/2}$ to $\theta_0(n)$ would leave the conjecture served and the item strictly easier**, and the record nowhere records that this is available. I flag it as an option, not a defect, with the caveat of section 6, that the band is populated and so the weakening is a real reduction rather than a cosmetic one."* This is a live option on the record's top-graded item, tied to the same $S^5\times S^7$ witness the fold **did** land, and it is nowhere. **The record still nowhere records that it is available.**

**(d) Two smaller ones, listed for completeness.** [r762](REVIEW_r762.md)'s note that `threshold_below_theta_zero` compares numerals while its name promises a comparison of thresholds, the passage from squares to roots being unformalised, [r762](REVIEW_r762.md) called it trivial, and it did not land. And [r761](REVIEW_r761.md)'s caution of §13 about re-grading `attackable`.

## 15. Attack item 8, what would show the fold unfaithful

Ranked by how little would have to be true, and each is checkable against the two reports alone.

1. **A finding's content replaced by an adjacent true statement inside a closed enumeration.** §4. This is realised, and it is the hardest kind to catch, because every sentence in the result is true and only the *list* is wrong.
2. **A hedged reviewer sentence promoted to an unqualified record assertion.** §1. Realised, and it landed in the lemma's statement, the most-quoted line in the block.
3. **A repair recommended but not performed, with the block asserting it was.** §3. Realised.
4. **A finding landed at one of its two sites**, where the second site is the machine-checked layer the finding was about. §6. Realised.
5. **A disagreement resolved without a word.** §10. Realised twice, once onto the side the record itself refutes.
6. **A finding dropped because the brief's own list dropped it first**, the brief having been written by the folding cycle. §14. Realised three times, twice on findings both reviewers made.
7. **A debt moved from a remark onto an item.** §8. Realised, in the strengthening direction.
8. **Arithmetic transcribed rather than re-derived.** *Not realised*, every number checks exactly, and the sphere-product formula reproduces the band's own endpoint, so a slip would have had to move two numbers together.
9. **A finding weakened in the deleting direction.** *Not realised*: the one deletion, finding 6's trailing clause, carries its content forward in the closure-condition sentence that replaced it.

## Overall verdict

**GAP.**

**The mathematics that landed is right.** Every value checks exactly and independently, $\tfrac{220}{144}=\tfrac{55}{36}$, $\theta^2(S^5\times S^7)=\tfrac{264}{175}$ strictly inside $(\tfrac32,\tfrac{55}{36})$ at both ends, and the $n\ge12$ closure at both parities. Seven of the brief's nine findings landed, four of them in the reviewers' own words, and one (that an ascent value cannot establish $\kappa^2<2$), landed sharper than either report put it. The Lean file builds and its replacement docstring no longer overclaims what the kernel checked.

**The fold is nonetheless not what the two reports found**, in six respects, none of which is a mathematical error and four of which delete or displace something:

1. **The per-frame/extremal swap was substituted out** of the list of risks invisible to the abstraction, in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean), in [lean/INDEX.md](../lean/INDEX.md) and in [ATTEMPTS.md](../ATTEMPTS.md), with attainment put in its place. Both reviewers named the swap; the record's own $t,\kappa$ row says it has already happened once. **§4.**
2. **The lemma's statement now asserts that [conventions.md](../findings/conventions.md) does not table the working sense of $M$**, which that file's two-spectra bullet and its $t,\kappa$ row both refute, a reviewer disagreement resolved silently onto the refutable side. **§1, §10.**
3. **The block claims a restatement it did not perform.** The display still quantifies over I36's class. **§3.**
4. **Finding 6's refuted clause still stands** in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) line 66, in the same file the same commit series edited. **§6.**
5. **Three findings were dropped entirely**, two of them made independently by both reviewers: the ordered-pair reading of $t$ ([r762](REVIEW_r762.md)'s *"single most dangerous inherited hypothesis"*), that the weaker hypothesis makes the item **harder**, and that weakening the threshold to $\theta_0(n)$ is a real and available reduction. The brief's list of nine omits all three, exactly as attack item 7 anticipates. **§14.**
6. **Smaller displacements**: the strictness debt attached to I36 rather than to the strictness claim; the band's witness landed without the [L69](../findings/graded-half.md) citation that makes it a maximiser; attainment recorded as owed where both reviewers discharged it; [lean/INDEX.md](../lean/INDEX.md) still owing *"L94 itself"* where the docstring beside it now says *specialisation*; and [plan.md](../plan.md)'s I36 entry still calling $\kappa^2$ *continuous* without the non-differentiability the same audit attached to that word. **§2, §5, §7, §8.**

**What would clear it.** Restore the swap to the docstring's enumeration and to [lean/INDEX.md](../lean/INDEX.md); qualify or correct the *"does not table"* clause; either perform [r761](REVIEW_r761.md)'s restatement or stop claiming it; strike the trailing clause from [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) line 66; and land the three dropped findings, the ordered-pair convention first. None of these is a derivation; all five are quotations from reports already on file.
