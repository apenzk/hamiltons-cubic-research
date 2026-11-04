# Review r1051: L231's row, the re-measured count, and the W7 fold

Sole reviewer on the scope, the round comparing text against something already fixed. Commits [e77293b8](../lean/INDEX.md) (the lean index re-measurement, L231's row, the withdrawn 45) and [65b5ec2d](../findings/INDEX-traps.md) (r1050 folded into W7 and [diagonal-half.md](../findings/diagonal-half.md), L15's duplicate Alt removed). Analysis only. The two machine steps below are an axiom print on cached oleans and a seconds-long numerical screen of a claim I derived by hand first.

Log: [agent_logs/r1051-l231-and-w7-fold.log](../agent_logs/r1051-l231-and-w7-fold.log)

| # | claim | verdict |
|---|-------|---------|
| 1 | The count: 230 numbered, 186 own rows, 43 named inside another, exactly 1 absent | **REFUTED in the split, CONFIRMED in the headline.** The true split is 212 / 17 / 1 |
| 2 | L231 is machine-checked by `diagCubicFormula`, at every `ι`, no dimension hypothesis | **CONFIRMED**, one wording correction |
| 3 | The "45 carry none" was an artefact, nothing left [lean/INDEX.md](../lean/INDEX.md) | **CONFIRMED**, and the artefact is identified |
| 4 | The L15 dedup is proposition-preserving | **CONFIRMED**, with a stale generated file introduced alongside it |
| 5 | The fold is faithful to [r1050](REVIEW_r1050.md) in both directions | **REFUTED**: one reversal, one dropped caveat, one dropped rider |
| 6 | Alt = 0 at every coordinate-diagonal point, for the reason given | **CONFIRMED**, derived independently and screened |
| 7 | The r1050 row in [reviews/INDEX.md](INDEX.md) attributes only what r1050 found | **PLAUSIBLE**, one verdict omitted and one self-assertion lodged in the reviewer's row |
| 8 | Overreach sweep over both commit messages and all changed prose | **REFUTED**: the validation trailer of each commit overstates what was done |

## Claim 1, the count: REFUTED in the split, CONFIRMED in the headline

**The denominator 230 is right and the "exactly ONE genuinely absent" is right. The 186 / 43 split is a pattern artefact of exactly the kind the commit was written to retire.**

My derivation, from [findings/INDEX-results.md](../findings/INDEX-results.md)'s own table against [lean/INDEX.md](../lean/INDEX.md) at `e77293b8^`:

| quantity | mine | the commit's |
|---|---|---|
| numbered results | **230** (rows `0`…`232`, with `60`, `202` and `203` never assigned, no duplicates, no suffixed ids) | 230 |
| carry their own row, meaning the `id` column of the main table names them | **212** | 186 |
| named only inside another row or in the prose and the To-check lists | **17** | 43 |
| named nowhere in the file | **1**, [L231](../findings/INDEX-results.md) | 1 |

**The 186 is the count of results whose `id` cell STARTS with a bare `L<N>`.** I reproduced that figure to the digit at `e77293b8^`, which identifies the pattern. It misses the 147 rows whose `id` cell is a markdown link, `| [L105](../findings/bounds-relaxations.md) | …`, and the rows that name two ids at once, `| [L46](../results.md) and [L47](../results.md) compose | …`. Those are own rows by any reading: they occupy the `id` column and they point at a Lean file of their own.

**Of the 43, twenty-six carry their own row and seventeen do not.** The twenty-six are results 0, 3, 7, 14, 48, 58, 64, 69, 79, 83, 85, 86, 89, 91, 95, 104, 105, 106, 109, 120, 123, 131, 134, 136, 155 and 156. The seventeen genuinely named only elsewhere are 8, 11, 24, 27, 31, 32, 50, 57, 143, 153, 159, 160, 161, 162, 164, 189 and 200.

**L105 is the tell, because the superseded plan text already named it.** The old sentence listed [L105](../findings/bounds-relaxations.md) among "the 45" as what [I73](../plan.md) feeds, and L105 has had an own row throughout, in link form. The same result is miscounted by the new pattern for the same reason, which is why 186 / 43 reproduces the defect the commit diagnosed rather than repairing it.

Two smaller notes on the denominator. **Nine of the 230 are `WITHDRAWN`** (14, 132, 137, 138, 139, 142, 150, 151, 200), and the superseded plan text acknowledged that a withdrawn result needs no file while the new text does not. One of them, 200, sits in the seventeen.

**Correction to write.** Replace "186 carry their own row in [lean/INDEX.md](../lean/INDEX.md), 43 are named inside another result's row" with "212 carry their own row, 17 are named only inside another row or in the file's prose", in [plan.md](../plan.md) and in the new [lean/INDEX.md](../lean/INDEX.md) row, both of which print the pair.

## Claim 2, L231's Lean check: CONFIRMED

`#print axioms` over an import of [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean), on cached oleans:

```
'HamiltonsCubic.RealLayer.diagCubicFormula' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.trCube_diagOp'    depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.sharpPair_diagOp' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.sharpQF_diagOp'   depends on axioms: [propext, Classical.choice, Quot.sound]
```

The standard three, with no `sorryAx` and no `Lean.ofReduceBool`, so no `native_decide` anywhere beneath.

**The quantification is as advertised.** `@diagCubicFormula : ∀ {ι : Type u_1} [Fintype ι] [DecidableEq ι], DiagCubicFormula`, so every index type with a finite decidable structure and no cardinality hypothesis. `DiagCubicFormula` is `∀ w, IsWeight w → Pcubic (diagOp w) = diagP w`, and [diagP](../lean/HamiltonsCubic/Base/Families.lean) is `½(∑_a ∑_b w_ab³ + tr w³)`, which is the record's L231 term for term. **The Lean statement is not weaker than the record's L231.**

**The two component theorems are strictly stronger than the record needs**, and the record row's "$\mathcal D_n$'s row-sum clause is never used" checks out against them: `trCube_diagOp` takes hollowness alone and `sharpPair_diagOp` takes symmetry and hollowness, neither taking the row sum, which enters only through `IsWeight` in the packaged `DiagCubicFormula`.

**One correction to the new row's description.** It says "`trCube_diagOp` gives the entrywise cube sum and `sharpPair_diagOp` gives $\tfrac12\mathop{\mathrm{tr}}w^3$". `trCube_diagOp` gives HALF the entrywise cube sum, `trCube (diagOp w) = ½ ∑_a ∑_b w_ab³`. As printed the two halves do not add to `diagP`. The same elision is in the file's docstring at line 41.

Compilation: `lake env lean HamiltonsCubic/Base/SharpDiag.lean` in 43 seconds, zero errors, warnings only, all of them the unused-section-variable linter. **"Recompiles clean, warnings only" is CONFIRMED.** So is the absence claim behind the whole commit: `L231` occurs nowhere under [lean/](../lean/) at `e77293b8^`. The Gate 2 attribution to [r1001](REVIEW_r1001.md) is accurate, that report's claims 1 to 4 covering `Pcubic`, `diagOp`, `diagP` and `DiagCubicFormula`.

## Claim 3, the withdrawal: CONFIRMED

**Nothing left [lean/INDEX.md](../lean/INDEX.md) over the window, and the movement is monotone upward.** Comparing `ef79d8fa` (2026-09-17, the last commit to touch the file on or before the measurement date) against `e77293b8^`:

| | 2026-09-17 | pre-commit | lost |
|---|---|---|---|
| results named in an `id` cell | 211 | 212 | **none** |
| results named anywhere in the file | 228 | 229 | **none** |

The one addition is L232. So the "45 carry none" was never a regression, and the artefact is now identified rather than merely asserted: the 2026-09-17 sentence is the same bare-start pattern applied to a 228-row index, and it swept L105 and twenty-odd others into the gap alongside the seventeen real ones. **The story about patterns is the right story. It is the replacement figure that repeats the mistake.**

## Claim 4, the L15 dedup: CONFIRMED

**The two definitions are identical, and I proved it in Lean rather than reading it.** Restating the deleted pair verbatim from `65b5ec2d^` alongside the imported ones:

- `oldAltCoeff R i j k l = (1/3) * bianchi R i j k l` equals [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean) `R i j k l` **by `rfl`**, which is also what [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean) records, `altCoeff = alt4 (comp R)` unfolding through [bianchi_eq_comp](../lean/HamiltonsCubic/Base/AltPart.lean) to the same cyclic sum of the same [bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean).
- `oldAltNormSq R = (1/4) * ∑ᵢⱼₖₗ oldAltCoeff R i j k l ^ 2` equals [altNormSq](../lean/HamiltonsCubic/Base/AltPart.lean) `R`, proved through `fourNormSq` and [fourInner](../lean/HamiltonsCubic/Base/AltPart.lean), whose `1/4` is the same `¼`. The only textual difference is `x ^ 2` against `x * x`, closed by `ring`.

**The proposition `L15` asserts is unchanged.** `#check` prints `scalQ R = ricNormSq R + 6 * HamiltonsCubic.AltLayer.altNormSq R`, which by the above is the same real equation as before. The constant is still `6`, the normalisations are still `⅓` and `¼`, and no namespace resolves differently: the file compiles with zero errors, and the only names `open HamiltonsCubic.AltLayer` could have shadowed are `inner2_*` lemmas the file never cites.

**The `sorry` count is one, not two, and it is unchanged.** `grep sorry` returns two hits in each version, but one is the docstring heading "What the `sorry` is". `lake env lean` reports exactly one `declaration uses 'sorry'`, at `L15` itself, and `#print axioms` gives `[propext, sorryAx, Classical.choice, Quot.sound]` for `L15` and the clean three for `zero_satisfies_identity` and `id_satisfies_hypotheses`. [plan-lean.md](../plan-lean.md)'s totals are unchanged at 54.

**One defect the commit introduced.** [plan-lean.md](../plan-lean.md) is generated, and line 62 still places L15's `sorry` at line 137 of [L15Statement.lean](../lean/HamiltonsCubic/Results/L15Statement.lean). The dedup pushed it to line 140. The same commit's regeneration updated [L171Statement.lean](../lean/HamiltonsCubic/Results/L171Statement.lean) to 127 and [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) to 100 and 187, all three of which I checked and all three of which are correct, so the generator ran BEFORE the L15 edit and the commit carries a stale row for the one file it changed. Rerun [lean_debts.py](../scripts/misc/lean_debts.py).

## Claim 5, the fold's fidelity: REFUTED

Three findings, one in each direction and one that is both.

### The reversal: [diagonal-half.md](../findings/diagonal-half.md) asserts what r1050 left open

The new block reads "[I73](../plan.md)'s bound needs something **strictly stronger than criticality at a value**". r1050's second surviving rider says the opposite is still open:

> "What is now shown is that the named intermediate condition is insufficient, which leaves room for a weaker strengthening than global maximality, local maximality or a threshold at $\theta_0(n)$ being the obvious candidates. $S^5\times S^7$ does not sit above $\theta_0(12)=1.2360331$."

A threshold at $\theta_0(n)$ IS criticality at a value. I checked the arithmetic: $\theta_0(12)^2=2(1-\tfrac3{12}+\tfrac2{144})=\tfrac{1375}{900}$, so $\theta_0(12)=1.2360331$, and the witness sits at $1.2282390$, below it. **So the one route r1050 named as surviving is the one the fold declares dead**, and the rider that named it is gone from the record entirely. This is the failure mode the brief flags: a reviewer's correction reversed while being applied.

[W7](../findings/INDEX-traps.md)'s own title is safe, "needs MORE THAN CRITICALITY" being true of any threshold. The defect is the block's sentence alone.

### The dropped caveat: "screened" is gone from both

r1050's claim 1: "**The existence claim is a screen, not a theorem.** A Newton solution at residual $10^{-9}$ is an approximate critical point, and the record carries no Newton–Kantorovich certificate. The row does say 'screened', which is enough, and the block should keep that word attached to the existence claim rather than only to the residual."

The rewrite removed the word from both places. The superseded W7 said "two **screened** critical points with those counts"; the new row says "off-catalogue generic Newton points" with no screening word and no residual. The superseded block said "**screened** at residual below $10^{-9}$"; the new block gives neither. [bounds.md](../findings/bounds.md) itself carries "screened in $\mathcal W_n$ at residual $<10^{-9}$" at the source sentence, so the record now states more flatly than its own source. **r1050 asked for the word to be attached more firmly and it was deleted.**

### The overreach: the block's heading claims non-boundedness

"**AND THE THRESHOLD DOES NOT BOUND $s$ EITHER**". One witness at $s=3$ above $\sqrt{3/2}$ refutes $s\le2$ there. It refutes no bound above 2, and the two high-$s$ points sit an order of magnitude BELOW the threshold, so they bear on it not at all. The body immediately underneath states the supportable version, "critical AND above the threshold does not give $s\le2$", which is what W7's title also says. **The heading contradicts its own body**, and it is the direct successor of the heading r1050 flagged under claim 7 for exactly this ("'THE LIST IS NOT SHORT WITHOUT IT' is supported for the row count and is not an obstruction claim"). The rewrite moved the overreach from the body into the heading rather than removing it.

### What the fold got right

- The `S^5\times S^7` numbers are correct and I re-derived them independently from [ungraded-slack.md](../findings/ungraded-slack.md)'s own proof: multiplicities $10, 21, 35$ on $\Lambda^2V_5$, $\Lambda^2V_7$ and the mixed block, eigenvalues $\tfrac{7\lambda}{44}, \tfrac{5\lambda}{66}, -\tfrac\lambda{11}$ summing to zero against those multiplicities, $\lVert W\rVert^2=\tfrac{175}{264}\lambda^2$, hence $\theta^2=\tfrac{264}{175}$ and $\theta=1.2282391$ against $\sqrt{3/2}=1.2247449$. Three distinct values, above the threshold.
- The Alt paragraph is faithful to r1050 and correct on its own terms, see claim 6.
- The padded $W_{\mathbb{CP}^2}$ re-anchoring, the off-catalogue provenance, the [r336](REVIEW_r336.md) twenty points at residual $\le5\times10^{-15}$, and the deletion of "may well be enough, the cheapest thing to try next" are all r1050's, all applied, all accurate. [bounds.md](../findings/bounds.md)'s source sentence does open "BUT IT IS A CATALOGUE PROPERTY, NOT A PROPERTY OF CRITICAL POINTS", so the inversion is real and is fixed.
- [INDEX-traps.md](../findings/INDEX-traps.md)'s preamble now reads `W1`…`W7`.
- Dropping I68 from W7 is sanctioned by r1050's recommendation 4, though it goes further than "drop I68 from the reach sentence": the clause's load-bearing status for I68, and r1050's positive consequence that 15 distinct eigenvalues on the 15-dimensional $\Lambda^2$ force $\mathop{\mathrm{rank}}\ge14$, are now recorded nowhere.

**One label to tighten.** The block credits "Gate 2 by [r1050](REVIEW_r1050.md)" without qualification, where [reviews/INDEX.md](INDEX.md) correctly says "SOLE reviewer" and the new [lean/INDEX.md](../lean/INDEX.md) row qualifies its own Gate 2 with "one reviewer". Match the block to those two.

## Claim 6, the Alt derivation: CONFIRMED

**True, and true for the reason given.** Derived from [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean)'s own definitions rather than from the fold's prose: `comp R i j k l = inner2 (R (phi i j)) (phi k l)` and `alt4 T i j k l = ⅓(T_{ijkl} + T_{iklj} + T_{iljk})`, with `altCoeff R = alt4 (comp R)`.

At a coordinate-diagonal $W$, meaning $W\varphi_{ij}=w_{ij}\varphi_{ij}$, which is [diagOp](../lean/HamiltonsCubic/Base/Families.lean) and is what [diagOp_phi](../lean/HamiltonsCubic/Base/Families.lean) proves, $\mathrm{comp}(W^k)_{ijkl}=w_{ij}^k\langle\varphi_{ij},\varphi_{kl}\rangle$, which vanishes unless $\{i,j\}=\{k,l\}$. Then:

- **Four distinct indices.** The three cyclic terms need $\{i,j\}=\{k,l\}$, $\{i,k\}=\{l,j\}$ and $\{i,l\}=\{j,k\}$ respectively, and each fails because $i$ lies in the left set and not the right. All three vanish separately.
- **Repeated indices.** I checked all six coincidence patterns. Where an index repeats WITHIN a $\varphi$, the term dies because $\varphi_{ii}=0$. Where it repeats ACROSS the two pairs, either the support condition forces a further coincidence the case excludes, or, in the two cases that survive support ($j=i$ with $k=l$, and $i=k$ with $j=l$), the two surviving terms are $\langle W^k\varphi_{ik},\varphi_{ki}\rangle$ and $\langle W^k\varphi_{ik},\varphi_{ik}\rangle$, which cancel because $\varphi_{ki}=-\varphi_{ik}$. **That is antisymmetry doing the work, exactly as the fold says.**

So $\mathrm{Alt}(W^k)=0$ at every coordinate-diagonal $W$, every $k$, every $s$, with no criticality. Screened numerically at $n=6$ on a random symmetric hollow weight, $\max|\mathrm{Alt}(W^k)|=0$ exactly for $k=1,2,3,5$, against a non-diagonal control operator returning $1.6796$. Seconds of arithmetic on an object I built for the screen.

**No tension with $W_{\mathbb{CP}^2}$.** That tensor has $\mathrm{Alt}(W^3)=c^3\star\ne0$ and is NOT coordinate-diagonal, as [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) states in terms ("the sphere product is diagonal in the `φ` basis; `W_{ℂP²}` is not"). And $S^5\times S^7$, being a sphere product, IS coordinate-diagonal, so it refutes nothing about [I75](../plan.md), which is r1050's first rider and which the fold does not contradict.

## Claim 7, the r1050 index row: PLAUSIBLE

Every attributed finding checks out against [r1050](REVIEW_r1050.md)'s text: the three eigenvalues in units of $\mu$ re-derived from the closed form, the Alt vanishing with `comp` spelled out, the $s=15$ point satisfying all thirteen rows, padded $W_{\mathbb{CP}^2}$ as the genuine refutation, the off-catalogue inversion, r336's twenty points, and the single-sourced $\theta=0.091388$. Two things to fix.

- **Claim 6 is unaccounted for.** The row reads "Claims 1, 2, 3 and 8 CONFIRMED; CLAIMS 4, 5 and 7 REFUTED", which is seven of eight. r1050's claim 6, on the warning class and the `where` pointer, was PLAUSIBLE, and its substance (that the row is fence-post shaped, and that filing it as a post would have surfaced the duplication) is the reason the rewrite was needed at all.
- **The row's last sentence is the parent's, not the reviewer's.** "The parent validated the two load-bearing findings independently before folding" is a self-assessment lodged in the reviewer's index row, and it is refuted in its own clause, see claim 8. Move it to the commit message or strike it.

## Claim 8, the overreach sweep: REFUTED

**Each commit's validation trailer claims more than the commit did.**

### `e77293b8`

> "the count was reproduced from [findings/INDEX-results.md](../findings/INDEX-results.md)'s own numbering against [lean/INDEX.md](../lean/INDEX.md), **distinguishing a result's own row from a mention inside another's, which is the distinction the earlier patterns collapsed**."

**That distinction is precisely what the measurement failed to make.** Twenty-six results with their own row are filed under "named inside another row" because the row's `id` cell opens with `[` rather than `L`. The commit names the defect it then commits. Everything else in the message holds: L231 was absent from the whole [lean/](../lean/) tree, `diagCubicFormula` does machine-check it, the docstring now carries the id, and the file recompiles with warnings only.

The plan's replacement sentence "successive patterns here reported 117, 230, 44, 1 and 0 on one unchanged tree" is a report of the session's own history and is not checkable from the record. The 230 in that list is the row count of [findings/INDEX-results.md](../findings/INDEX-results.md) exactly, which is consistent with one of those patterns having counted rows rather than matches.

### `65b5ec2d`

> "**Validation: both load-bearing findings reproduced independently before applying.** The $S^5\times S^7$ witness **was read off [ungraded-slack.md](../findings/ungraded-slack.md)**"

**Reading a value off the source the reviewer cited is corroboration of a citation, not independent reproduction**, and the sentence concedes it in its own next clause. The Alt half is genuinely independent, being a derivation. The record does carry a full proof of the witness at [ungraded-slack.md](../findings/ungraded-slack.md), and I reproduced it under claim 5, so the FINDING is sound. The claim about how it was checked is not.

> "[ungraded-slack.md](../findings/ungraded-slack.md), **which states in its own words that no threshold repairs the claim**"

**Which claim.** The source sentence, "So the subalgebra family does not exhaust the graded critical set, and no threshold repairs it", is about the Casimir classification of [L23](../results.md)'s subalgebra family, and the paragraph four lines down is about recovering the graded set. Neither is about $s\le2$. r1050 marked the distinction in terms, "there about the Casimir classification". The trailer drops the qualifier, which turns a witness the parent had to apply into a statement the record supposedly already made.

Other absence and completeness claims in the message, checked by grepping the scope each names: "the block's 'may well be enough, the cheapest thing to try next' … is gone" holds, "[INDEX-traps.md](../findings/INDEX-traps.md)'s preamble said the warnings run `W1`…`W5`" holds and is fixed, "the definitions were identical via [bianchi_eq_comp](../lean/HamiltonsCubic/Base/AltPart.lean) and both carried the same `1/4`" holds and is proved above, "Compiles with its pre-existing `sorry` and no other change" holds. The correction to `cb4c92b2`'s trailer is r1050's claim 7 finding restated accurately, though it credits only [ungraded-slack.md](../findings/ungraded-slack.md) where r1050 cited [plan.md](../plan.md)'s I75 row as well.

## What to change

1. **[plan.md](../plan.md) and the new [lean/INDEX.md](../lean/INDEX.md) row**: the split is 212 own rows, 17 named only elsewhere, 1 absent. Say which pattern produced it, since the file's `id` cells come in three shapes.
2. **[diagonal-half.md](../findings/diagonal-half.md) line 1423**: strike "strictly stronger than criticality at a value" and restore r1050's rider, that $S^5\times S^7$ sits below $\theta_0(12)=1.2360331$, so a threshold at $\theta_0(n)$ survives as a candidate and local maximality does too.
3. **[diagonal-half.md](../findings/diagonal-half.md) line 1423, heading**: "THE THRESHOLD DOES NOT BOUND $s$ EITHER" claims non-boundedness on a single $s=3$ witness. Use the body's own sentence, that the threshold does not give $s\le2$.
4. **[W7](../findings/INDEX-traps.md) and the block**: put "screened" back on the $s=10$ and $s=15$ existence claim, with [bounds.md](../findings/bounds.md)'s residual $<10^{-9}$, which is the source's own wording.
5. **[lean/INDEX.md](../lean/INDEX.md)'s L231 row and [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean) line 41**: `trCube_diagOp` gives HALF the entrywise cube sum.
6. **[plan-lean.md](../plan-lean.md) line 62**: rerun [lean_debts.py](../scripts/misc/lean_debts.py), L15's `sorry` is at line 140.
7. **[reviews/INDEX.md](INDEX.md)'s r1050 row**: record claim 6's PLAUSIBLE, and move the parent's self-assessment out of the reviewer's row.
8. **[diagonal-half.md](../findings/diagonal-half.md)**: qualify "Gate 2 by r1050" as one reviewer, matching the other two sites.
