# Review r868: do the folds of r860 to r863 say what those reports said?

*Reviewer r868, 2026-09-10. This was a TEXT-AGAINST-TEXT round. The four reports [r860](REVIEW_r860.md), [r861](REVIEW_r861.md), [r862](REVIEW_r862.md) and [r863](REVIEW_r863.md) were taken as fixed and authoritative, and the record as edited after them was read against them line by line. **No mathematics was re-derived and no verdict of those reports was adjudicated.** The programme's analysis-only footing was respected: nothing was computed, no screen was run, and no object was constructed. Files read: the four reports, [diagonal-half.md](../findings/diagonal-half.md)'s [L201](../findings/diagonal-half.md) block and its I74, I75, I76 and I77 sections, [INDEX.md](INDEX.md) rows 860 to 863, [results.md](../results.md)'s L201 entries, [plan.md](../plan.md)'s I74 to I77 items and grading rows, [ATTEMPTS.md](../ATTEMPTS.md)'s last four dated entries, and [lean/INDEX.md](../lean/INDEX.md)'s L201, I76 and I77 rows, with [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) opened only to read the docstring and the hypothesis list two reports quote. Log: [agent_logs/review-r868-fold.log](../agent_logs/review-r868-fold.log).*

## Finding-by-finding table

Treatment codes: **APPLIED** (the record says what the report said), **CONTRADICTED** (the refuted claim still stands somewhere), **OVERSTATED** (the record claims more than the report), **UNDERSTATED** (an independent agreement recorded as one reviewer's), **LOST** (established or offered and carried nowhere), **PARTIAL**.

| # | Finding as the report states it | Report | Treatment in the record |
|---|---|---|---|
| 1 | Subtraction, constant, at-every-index quantifier all hold | r860, r861 | APPLIED, [diagonal-half.md](../findings/diagonal-half.md) I76 opening |
| 2 | Trace-freeness is redundant and is IMPLIED by Ricci-flatness plus completeness | r860 #4, r861 §2 | APPLIED, "Trace-freeness is a CONSEQUENCE and not a hypothesis" |
| 3 | "A combinatorial condition on the configuration alone" is overstated: it is linear, on the pair (configuration, subset) | r860 #5 | APPLIED verbatim in substance, "combinatorial" dropped |
| 4 | $A$-regularity does NOT force integrality, refuted in closed form by the rotated witness at $n=4$ | r860 #8, r861 §7.2 | APPLIED, and the joint arrival recorded |
| 5 | The conditional "if it does, every two-eigenvalue point is coordinate-diagonal" is vacuous, that route closed | r860 #9, r861 §8 | APPLIED, the conditional re-pointed at the operator target |
| 6 | The narrowing is thin: $W_{\mathbb{CP}^2}$ already carries three distinct eigenvalues | r860 #10 | APPLIED |
| 7 | "It needs no new machinery" is refuted | r860 #11, r861 #9 | APPLIED, but credited to r860 alone (UNDERSTATED) |
| 8 | The prose's Lean hypothesis list omits $N\ne0$ | r860 #13 | APPLIED in findings; LOST in [lean/INDEX.md](../lean/INDEX.md):99, whose list of the same hypotheses still omits it |
| 9 | $A$-regularity with that constant is EQUIVALENT to a two-valued Ricci-flat weighting with level set $A$ | r860 #14, r861 §6 | APPLIED, as "the round's central finding", agreement recorded |
| 10 | Tightness generalises to every $S^p\times S^p$ with constant $2(p-1)$ | r860 #6, r861 §5 | APPLIED |
| 11 | Criticality is never consumed, so the statement covers every two-valued Ricci-flat tensor on the locus | r860, r861 §3 | APPLIED |
| 12 | $\mu>0>\nu$ is a consequence, and a two-valued spectrum here has no kernel | r860 §4, r861 §4 | APPLIED |
| 13 | `integrality_forces_frame` carries `sorryAx`, so the machine-checked chain stops at $A$-regularity | r860 #12, r861 §10 | APPLIED in findings; [INDEX.md](INDEX.md) row 860's "the Lean files all HOLD" omits the gap |
| 14 | $\Xi$ detects the non-integrality that $A$-regularity misses, so given 10 stays the sharp tool | r860 §7 | LOST as a statement, though r861's $\Xi$ formula at the target is carried |
| 15 | The constant $10$ three ways: formula, spectral ratio, and $c=2d$ at the $5$-regular $2K_6$ | r861 §5, §9 | APPLIED in [INDEX.md](INDEX.md) row 861 |
| 16 | $\mu\ne\nu$ is redundant in prose under $\mu>0>\nu$ and earns its place only in Lean | r861 #4 | APPLIED |
| 17 | Trace-freeness PINS the weights, $\mu:\nu=(N-a):(-a)$ | r861 #6 | APPLIED |
| 18 | The structural reason no such implication can exist: $A$-regularity is invariant under eigenspace rotation, integrality is not | r861 §7.1 | APPLIED in [plan.md](../plan.md)'s I76 |
| 19 | A second falsifier AT the target, with $\Xi=n^2(n-1)-2(n-3)\sin^22t$ | r861 §7.3 | APPLIED, digits exact |
| 20 | On the coordinate locus the condition is exactly "$A$ is a regular graph", one notch weaker than R15 | r861 §9 | APPLIED |
| 21 | The typed statement is wider on the objects and narrower on the hypotheses | r861 §10, r860 #12 | APPLIED |
| 22 | The kernel exclusion is where the planes ARE load-bearing, so "nothing about planes is used" is inaccurate for it | r861 §4 | PARTIAL: the exclusion is recorded, the caveat is not, and r860's contrary reading is the one kept |
| 23 | D1: "strictly stronger than the $A$-regularity above" is FALSE, the two are equivalent | r862 D1 | APPLIED in findings, ATTEMPTS and [INDEX.md](INDEX.md); **CONTRADICTED at [lean/INDEX.md](../lean/INDEX.md):99, still "the stronger MATRIX form"** |
| 24 | D2: the witness has FOUR non-integral pairs, not two, at two values | r862 D2, r863 §11 | APPLIED at the I76 block; **CONTRADICTED at [diagonal-half.md](../findings/diagonal-half.md):1167, still "its two mixed pairs"**; credited to r863's log alone (UNDERSTATED) |
| 25 | D3: $\lambda_{\max}=1/\sqrt{55}$ and the bound $28\sqrt{55}/55=3.775519$, not $0.1349$ and $3.774$ | r862 D3, r863 claim 2 | APPLIED, digits exact; credited to r863 alone (UNDERSTATED) |
| 26 | D4: no pencil is isotropic at ANY $r$ once $n\ge3$, the $r=1$ reading being an implication read as an equivalence | r862 D4, r863 §9 | APPLIED, agreement recorded |
| 27 | D5: integrality holds at every DISTINCT pair, the diagonal being $2$ | r862 D5 | APPLIED |
| 28 | D6: "L198 sharp only off the locus" needs $\lambda_{\max}^2<1$ from trace-freeness | r862 D6, r863 §6 | APPLIED, cited to r862 alone (UNDERSTATED) |
| 29 | D7: the dictionary's converse needs $\Theta(E)$ diagonal, which coordinate planes supply | r862 D7, r863 §10 | APPLIED, cited to r862 alone (UNDERSTATED) |
| 30 | D8: at two eigenvalues first Bianchi is the separate condition $\mathrm{Alt}(\Pi_E)=0$ | r862 D8 | APPLIED, but jointly cited to r863, which never raises it (MISATTRIBUTION) |
| 31 | D9: the factor $2$ needs the PLAIN Frobenius trace, the record's $\Lambda^2$ product returning $1$ | r862 D9, r863 §1 | APPLIED in the findings block and in [results.md](../results.md) |
| 32 | "Exactly its coordinate planes" needs injectivity plus the count, the only place basis-ness is spent | r862 §3, r863 §3 | APPLIED; **[INDEX.md](INDEX.md) row 863 asserts r862 did not reach it, which is false** |
| 33 | The row-bound test needs decomposability only on $(\ker W)^{\perp}$, so it excludes more | r862 §13, r863 §6 | APPLIED; same false claim of exclusivity in [INDEX.md](INDEX.md) row 863 |
| 34 | The general identity $2\operatorname{tr}(T-T^2)=\tfrac12\sum_i\sin^2(2\vartheta_i)$, and the isoclinic $45^\circ$ pair showing orthogonality is load-bearing | r862 §1, §2, r863 §1 | APPLIED |
| 35 | No point besides padded $W_{\mathbb{CP}^2}$ sits in the test's window, so no new exclusion is demonstrated | r862 §6, r863 §6 | APPLIED |
| 36 | The sharper non-composition reason: the row bound pushes $\lvert\lambda_{\min}\rvert$ up, weakening L107 | r862 §7 | LOST. Only r863's $(1+x^2)/(2x)\ge1$ reason is carried |
| 37 | The regular-from-Ricci, strong-from-criticality split carries a qualification: relation (C) does not separate cleanly, and it is not a claim of exclusivity | r862 §10, r863 §10 | LOST |
| 38 | $n\ge3$ is inert, and at $n=3$ the integrality hypothesis is vacuous | r862 §3, r863 H4 | LOST |
| 39 | Cross-commuting forces EITHER side's algebra to be reducible, by Schur, and the $n=4$ attempt collapses to coordinate-spanned | r862 §11 | APPLIED, weakened to "one side's algebra" |
| 40 | The isoclinic exclusion covers bases all of whose members are complex lines, and mixed configurations are untouched | r863 §12, r862 §12 | LOST: the scope caveat r863 asked for is absent |
| 41 | The docstring of `integrality_forces_frame` still describes the DELETED induction, and its `sorry` is open, so the theorem is stated and not checked | r863 claim 1 | **LOST**: the docstring is unchanged and the finding is recorded nowhere |
| 42 | "Strictly sharper at every $\lambda_k<1$" should read $\lvert\lambda_k\rvert<1$ | r863 claim 2 | **LOST**: [diagonal-half.md](../findings/diagonal-half.md):1179 still reads $\lambda_k<1$ |
| 43 | Write the identity with $\operatorname{tr}$ explicit rather than with a subscript $F$ | r863 §1 | PARTIAL: the identity is now explicit, the summed bound keeps $\lVert\cdot\rVert_F^2$ |
| 44 | The isotropy equivalence rests on trace-freeness together with $N=\binom n2$, and belongs in the mathematics rather than as a Lean remark | r863 §8 | PARTIAL: the equivalence is stated, the count still appears only as the Lean hypothesis |
| 45 | Coordinate-spannedness forces $n\mid2a$ | r863 §10 | APPLIED |
| 46 | The sharp question is settled AFFIRMATIVELY at $n=4$ by chirality parity, $a=3$ empty, $a\in\{2,4\}$ coordinate-spanned | r863 §14 | APPLIED |
| 47 | At $n=5$ the live degrees are $a\in\{3,4,6,7\}$, with the $a=3$ Gram data FORCED at $S=1/5$ within and cross rows $12/5$ | r863 §14 | APPLIED, and handed on as the record's own next task |
| 48 | The rank range $n/2\le a\le N-n/2$ | r863 §9 | APPLIED |
| 49 | A two-eigenvalue Ricci-flat $W$ is invertible, so padded points lie outside the claim | r863 §13, r862 §13 | APPLIED |
| 50 | The isoclinic exclusion has a second proof from the Kähler two-sphere | r863 §12 | APPLIED in [INDEX.md](INDEX.md) row 863 |

## Summary in one line

Every REFUTED verdict of the four reports reached the record, and two of them are contradicted elsewhere in it: r862's D1, the round's one refutation, still stands as "the stronger MATRIX form" at [lean/INDEX.md](../lean/INDEX.md):99, and the two-pair miscount D2 still stands at [diagonal-half.md](../findings/diagonal-half.md):1167 sixteen lines above the block that corrects it, while [INDEX.md](INDEX.md) row 863 credits r863 with two repairs r862 also made.

## 1. Every REFUTED and REFUTED-AS-STATED finding, and where it landed

Six verdicts across the four reports carry the word refuted or its equivalent. Five landed cleanly.

- **r860 #8 and r861 #7, "does $A$-regularity force integrality" answered NO.** Landed at [diagonal-half.md](../findings/diagonal-half.md)'s I76 block, "The first hope was that $A$-regularity forces integrality of the chosen basis, and THAT IS FALSE", with the witness, the constant $4$ and the two entries $\cos^2t$ and $\sin^2t$. Also in [plan.md](../plan.md)'s I76 item ("The stronger reading ... is false") and in the ATTEMPTS entry. Nothing anywhere still asserts the implication: a repository-wide search for the phrases "forces integrality", "no new machinery" and "strictly stronger" returns no live claim of it outside the reports themselves.
- **r860 #11 and r861 #9, the "structural narrowing needs no new machinery" claim.** Withdrawn explicitly, "The claim that this needs no new machinery is WITHDRAWN". Credited to r860 alone though both reached it, which is section 4's point.
- **r860 #4, trace-freeness is not a necessity.** Landed as "Trace-freeness is a CONSEQUENCE and not a hypothesis" with the one-line reason.
- **r860 #5, "on the configuration alone" overstated.** Landed as "a linear condition on the PAIR of a configuration and a subset rather than on the configuration alone".
- **r862 D1, "strictly stronger" is FALSE.** Landed in three places, [diagonal-half.md](../findings/diagonal-half.md) ("the two are EQUIVALENT rather than one stronger ... the 'strictly stronger' reading withdrawn"), the ATTEMPTS entry ("The one refutation is a word") and [INDEX.md](INDEX.md) row 862. **And it did not land in the fourth**: [lean/INDEX.md](../lean/INDEX.md):99 still reads "`two_eigenvalue_isotropic` is the stronger MATRIX form ... so isotropy is typed and `A`-regularity is its contraction", which is the sentence shape r862 refuted, at the one address a reader consults for what is typed. A reading exists on which the row is about Lean hypotheses rather than about mathematical strength, the matrix Ricci hypothesis being formally stronger than the row form, but the row pairs "stronger" with "is its contraction" exactly as the refuted sentence did, so the fix is owed there in words.
- **r862 D2, the witness has four non-integral pairs.** Landed at the I76 block, which now names all four pairs and their values and says so in capitals. **It did not land at [diagonal-half.md](../findings/diagonal-half.md):1167**, in the I74 section of the same file, where the same witness is still described as having "its two mixed pairs having $\operatorname{tr}(\Pi\Pi')=\cos^2t$ and $\sin^2t$". This is the defect the brief names: a finding accepted in one block while the refuted count stands in another block of the same file.

r863 refuted nothing, and the record does not claim otherwise: [INDEX.md](INDEX.md) row 863 opens "Nothing refuted", matching that report's own closing line.

## 2. Attribution: is anything credited to a reviewer who did not say it?

I checked every r860 to r863 citation in the four findings sections and in the four index rows.

- **One misattribution in the findings.** [diagonal-half.md](../findings/diagonal-half.md)'s I76 block attaches "at two eigenvalues first Bianchi is the separate condition $\mathrm{Alt}(\Pi_E)=0$, free when $E$ carries a decomposable basis, and a two-eigenvalue Ricci-flat $W$ is forced invertible" to ([r862](REVIEW_r862.md), [r863](REVIEW_r863.md)) jointly. The invertibility half is in both, r862 §13 and r863 §13. The Bianchi half is r862's D8 alone: r863 mentions first Bianchi only once, in its list of quoted conventions, and raises no condition on $\Pi_E$. Split the citation.
- **One false claim of exclusivity in the index.** [INDEX.md](INDEX.md) row 863 reads "two repairs the other reviewer did not reach", naming L201's injectivity-plus-count and the $(\ker W)^{\perp}$ strengthening. Both are in r862: §3 states injectivity from $\Lambda^2P$ being a line and surjectivity from the count, in as many words, and §13 weakens the row bound's hypothesis to "$\omega_k$ is decomposable and so is every eigenvector with nonzero eigenvalue" and calls the contrapositive "stronger than advertised". The row's claim is therefore false as written, and the same misreading explains why the findings blocks credit both repairs to r863 alone.
- **One editorial addition presented inside a report summary.** [INDEX.md](INDEX.md) row 862 closes "The last is the L200 hazard at a new address and the Lean instance is what pins it." r862 pins the convention on the Lean instance and never mentions L200, having read only the brief and the Lean file. The gloss is the record's, and a row is read as the report's content.
- **Everything else checks out.** The equivalence to r860 and r861 jointly, the witness to both, the pencil correction to r862 and r863 jointly, "strictly stronger" to r862 alone, $n\mid2a$ and the $n=5$ Gram data to r863 alone, the Schur lead to r862 alone: each matches its report.

## 3. Do the index rows overstate or understate their reports?

- **Row 860 understates two things.** Its verdict cell says "the Lean files all HOLD", where r860 confirms two declarations gap-free and states that `integrality_forces_frame` carries `sorryAx` so the machine-checked chain stops at $A$-regularity. A reader trusting the row would not know a gap is in the file. The row also opens "Twelve items answered" while that report's claim table carries fourteen rows and names no count of its own.
- **Row 861 is accurate.** The three routes to $10$, the invariance reason, the second falsifier with its $\Xi$ formula, the pinned weights, the regular-graph reading: all present in the report at the values quoted.
- **Row 862's headline overstates by one word.** "All three claims HOLD, every link" applies claim 1's verdict, "HOLDS, EVERY LINK", to all three, where claim 3's verdict is "HOLDS EXCEPT ONE SUB-CLAIM, WHICH IS REFUTED". The body does carry "'strictly stronger' is FALSE", so the information is in the row, but the word REFUTED appears in the report's verdict and nowhere in the row, and verdict cells are what a later reader scans. The count "nine defects" is right, D1 to D9.
- **Row 863 carries the round's one false statement about a report**, treated in section 2. Its other content is accurate, and it omits three things the report asked for: the $\lvert\lambda_k\rvert<1$ correction, the stale docstring, and the rank range $n/2\le a\le N-n/2$ (the last is carried in the findings, so only the row is thin).

## 4. Agreements as agreements, disagreements as disagreements

**Recorded correctly.** The r860 and r861 equivalence ("independently"), their shared arrival at the witness ("reached the same witness from the same given"), the r862 and r863 pencil correction, the invertibility clause, and "both held every load-bearing step" in ATTEMPTS.

**Recorded as one reviewer's where both found it, six times.** The "no new machinery" withdrawal (r860 and r861, cited r860). The four-pair count (r862 and r863, credited to r863's log). The D3 figures (r862 and r863, credited to r863 as "supplied the closed forms"). D6, the trace-freeness step behind "sharp only off the locus" (r862 and r863, cited r862). D7, the dictionary's converse (r862 and r863, cited r862). The injectivity-plus-count and the $(\ker W)^{\perp}$ strengthening (r862 and r863, cited r863, and asserted as r863-only in its index row). Each of these is an independent confirmation, which is the most valuable thing a two-reviewer round produces, and each is on the record as one voice.

**One genuine divergence between reports, unrecorded.** r860's hypothesis inventory endorses the block's aside that "nothing about planes is used". r861 §4 says that aside "is accurate for the identity and inaccurate for this exclusion", the exclusion of $\nu=0$ resting on positive semidefiniteness and trace two of the $\Pi_\alpha$. The record keeps "nothing about planes is used", scoped to the Lean statement where it is right, and one clause earlier uses the trace $2a$ of $\sum_{\alpha\in A}\Pi_\alpha$ for the no-kernel argument. The scoping makes the sentence defensible, and r861's caveat about which step spends the planes is carried nowhere.

## 5. Was any finding applied more widely than its report supports?

Little to report here, which is the good news of the round.

- **The equivalence is stated at its report's reach.** "Nothing derived from $A$-regularity alone can force anything" is broader in wording than r860 #8's "cannot force integrality", and r860 §9 does support the broad form: "It is not a consequence that constrains the configuration further" and "$A$-regularity is therefore a restatement of the hypothesis, in different variables".
- **The pencil correction is applied at exactly its width**, "isotropic at NO $r$ once $n\ge3$, the $r=1$ case included", with the rank range added as r863 gave it and no claim made about pencils at $n=2$.
- **The $n=5$ narrowing is the record's own and is framed as such.** r863 offered $a\in\{3,4,6,7\}$ as candidates pending realisability, and the record collapses them by its own rank counts and says so, "[r863]'s list $\{3,4,6,7\}$ collapses to a single question", with the handover marked "derived 2026-09-10 as [r863]'s handed-over task". No verdict of r863's is stretched to cover it.
- **One dimension-transfer to watch.** [lean/INDEX.md](../lean/INDEX.md):99 still opens "`two_eigenvalue_A_regular` IS THE ITEM'S CLAIM AND IT IS PROVED" and marks I76 **proved**. After the fold the item's claim is coordinate-diagonality of the operator and $A$-regularity is a change of variables, which the same row's file is not typed to reach. The status is a statement about the Lean file and is defensible on its own terms, and the sentence about the item's claim is not.

## 6. The numbers, digit by digit

Every figure in the four findings sections that traces to one of the four reports agrees with it.

- I76: the constant $2\cdot11\cdot30/66=10$, $a=2\binom62=30$, $N=66$, the two case counts $2(p-2)=8$ and $p-1=q-1=5$, the witness's constant $2\cdot3\cdot4/6=4$ and its row sum $2+1+\cos^2t+\sin^2t=4$, the target rotation's $\Xi=n^2(n-1)-2(n-3)\sin^22t$, the weights $\lambda_{12}=\lambda_{13}=\lambda_{24}=\lambda_{34}=\tfrac12$ against $\lambda_{14}=\lambda_{23}=-1$, $\theta=-\theta_0(4)$, the generalisation $2(p-1)$, $\theta=\sqrt{55}/6=\theta_0(12)$, $4a/n=2(n-1)a/N$, $\Theta(E)=(2a/n)\mathrm{Id}$ with $2\cdot2\binom p2/(2p)=p-1$, the range $3\le a\le7$ at $n=5$, and $S=1/5$ within $A$ with cross rows at $12/5$.
- I75: $\lambda_{\max}=2/\sqrt6$, $\lambda_{\max}^2=\tfrac23$, $\theta\lambda_{\max}=1$ against $\tfrac56$ at padded $W_{\mathbb{CP}^2}$, and at the balanced product $6/11$ on $30$ planes, $-5/11$ on $36$, norm $\sqrt{180/11}$, $\lambda_{\max}=1/\sqrt{55}$, $\theta\lambda_{\max}=1/6$, the bound's $28/55$ and $28/\sqrt{55}=3.77551$ against $\theta_0(12)=\sqrt{55}/6$. The bound's decimal is a truncation of r862's and r863's $3.775519$ and not a rounding, which loses nothing and is worth knowing if the figure is ever quoted to five places.
- The two withdrawn figures survive in exactly one place, [ATTEMPTS.md](../ATTEMPTS.md):6569, the earlier of the four dated entries, "where it gives $3.774$". The next entry names it as wrong, "the row bound there is $28\sqrt{55}/55=3.775519$, not $3.774$", so the log reads forward correctly. No live claim anywhere carries $3.774$ or $0.1349$.
- I74's figures trace to r858 and r859 rather than to this round's reports, and I77's to r864 and r865, so neither is checkable here. I77 carries no r860 to r863 citation at all, and its one contact point with this round, the pair cap at $1$ on the decomposable locus against $2$ in general, matches r862 §5.

## 7. What the folds lost

Five losses and three partials, in order of what a later reader would miss.

1. **r863's stale-docstring finding, lost entirely.** The docstring of `integrality_forces_frame` in [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) still reads "the derivation in the findings block runs by induction on `n`", the induction the findings block has deleted, and its `sorry` is open. The report states this twice, in claim 1's row and in its verdict. Nothing in [lean/INDEX.md](../lean/INDEX.md)'s L201 row, in the findings block or in ATTEMPTS records it, so a reader of the file is pointed at a proof the record no longer has.
2. **r863's $\lvert\lambda_k\rvert<1$ correction, lost entirely.** [diagonal-half.md](../findings/diagonal-half.md):1179 still reads "strictly sharper than $\theta\lambda_k\le1$ at every $\lambda_k<1$", and the sharpening needs $\lambda_k^2<1$. It is the one arithmetic correction of the round that reached nothing.
3. **r862's second reason for non-composition.** The row bound caps the positive spectrum, and trace-freeness with unit norm then pushes $\lvert\lambda_{\min}\rvert$ up, which is the direction that weakens [L107](../findings/bounds.md). The record carries r863's reason, $(1+x^2)/(2x)\ge1$, and not this one, though the two are independent and the report offers it as "a reason stronger than the one given".
4. **Both reports' qualification on the DGK split.** r862 §10 and r863 §10 warn that relation (C) does not separate cleanly, so criticality is not silent about the degrees and the split should be read as an attribution of sufficiency rather than of exclusivity. The record states the split flatly, "Ricci-flatness supplies the regularity and criticality supplies the strength".
5. **r863's scope caveat on the isoclinic exclusion**, that it reaches bases all of whose members are complex lines and leaves mixed configurations untouched, so "one family is already excluded" should be read as that family and no wider. The record keeps the unqualified sentence.
6. **Partial: the count in the isotropy equivalence.** r863 asks that the equivalence's dependence on trace-freeness together with $N=\binom n2$ be stated in the mathematics. The record states the equivalence and leaves the count as a remark about the Lean hypothesis, which is the placement the report objected to.
7. **Partial: the Frobenius subscript.** r863 recommends writing the identity with $\operatorname{tr}$ explicit. The main identity now is, in both the findings block and [results.md](../results.md), and the summed bound one paragraph later still reads $\sum_{\alpha\ne\beta}\lVert[\Pi_\alpha,\Pi_\beta]\rVert_F^2$, which is where the same hazard sits.
8. **Minor: two inert-hypothesis remarks.** Both reports record that $n\ge3$ does no work in L201 and that at $n=3$ the integrality hypothesis is vacuous, two planes in $\mathbb R^3$ always sharing a line. The statement still carries $n\ge3$ with no note, in the findings block and in [results.md](../results.md). r860's remark that $\Xi$ detects the non-integrality $A$-regularity misses is likewise carried nowhere, and r862's "either side's algebra" is narrowed to "one side's".

**Two additions beyond the verdicts did land in full**, and they are the largest things the reports offered: r863's affirmative settlement of the sharp question at $n=4$ by chirality parity, with $a=3$ empty, and its $n\mid2a$ divisibility condition, both of which the record then built on to empty $n=5$.

## Verdict

**THE FOLDS ARE FAITHFUL IN THE MAIN. TWO REFUTED CLAIMS STILL STAND ELSEWHERE IN THE RECORD, ONE INDEX ROW MAKES A FALSE CLAIM ABOUT A REPORT, AND FIVE REPAIRS WERE LOST.**

- **Repairs owed, in order of size.** First, [lean/INDEX.md](../lean/INDEX.md):99: drop "the stronger MATRIX form" for the equivalence r862 established, and reconsider "IS THE ITEM'S CLAIM" now that the item's claim is coordinate-diagonality. Second, [diagonal-half.md](../findings/diagonal-half.md):1167: two mixed pairs becomes four, at two values. Third, [INDEX.md](INDEX.md) row 863: delete "two repairs the other reviewer did not reach", both being in r862 §3 and §13, and record them as the round's sixth and seventh independent agreements. Fourth, [diagonal-half.md](../findings/diagonal-half.md):1179: $\lambda_k<1$ becomes $\lvert\lambda_k\rvert<1$. Fifth, the docstring of `integrality_forces_frame`, which still describes the deleted induction.
- **Attribution repairs.** Split the Bianchi-plus-invertibility citation, r862 for the first half and both for the second. Add r861 to the "no new machinery" withdrawal, r862 to the four-pair count, the D3 figures, and r863 to D6 and D7. Move [INDEX.md](INDEX.md) row 862's L200 gloss out of the report's summary or mark it as the record's own.
- **Index rows.** Row 860 should name the `sorryAx` in `integrality_forces_frame` and drop or correct "Twelve items answered". Row 862's headline should carry the refutation, not only its body.
- **What the fold got right, and it is most of it.** Every refuted verdict reached the findings blocks, [plan.md](../plan.md) and [ATTEMPTS.md](../ATTEMPTS.md); the equivalence is recorded as the round's central finding with both reviewers named; the withdrawn figures survive only inside a dated log entry that corrects them on the next line; every figure traceable to these four reports is exact; and the two structural additions r863 offered beyond its verdicts were applied and then extended.
- **One incidental, outside the four reports and outside this round's remit.** At [diagonal-half.md](../findings/diagonal-half.md):1209 the letter $c$ carries the isotropy constant $8/5$ and, three clauses later, the cosine $\cos\vartheta_1=\sqrt{S_{12}}$ constrained to $c\le\tfrac35$, in one display. That is the record's own new work rather than a fold of these reports, and it is a symbol collision a later reader will trip on.
