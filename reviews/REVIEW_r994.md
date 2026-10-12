# Review r994: the typed obligation, and the r993 fold

Gate 2, sole reviewer by design, on [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) and the fold of [r993](REVIEW_r993.md). Brief: [BRIEF_I67_pfsquared_fold.md](BRIEF_I67_pfsquared_fold.md). Scope: exactly `f886591a` and `baec9b71`, the report-graph commits `334b329f`, `0d383099` and `7313f09c` being another session's and untouched here.

## Verdicts

| # | claim | Lean | verdict |
|---|---|---|---|
| 1 | $\mathrm{Pf}(X)^2=\det X$ STATED for skew $X$, carries a `sorry` | `pf_sq_eq_det` | **CONFIRMED**, and the statement is TRUE at $\dim 6$ |
| 2 | $\det J=1$ STATED at a complex structure, carries a `sorry` | `det_complex_structure` | **CONFIRMED**, TRUE at EVERY complex structure, skewness not needed |
| 3 | $\mathrm{pf6}(J)=\pm1$ PROVED from rows 1 and 2 and nothing else | `pf6_complex_structure` | **CONFIRMED** |
| 4 | those two `sorry`s are the only gaps in the file | `#print axioms` | **CONFIRMED** |
| 5 | the composition carries `sorryAx` | `starWedge_of_pf` ∘ `pf6_complex_structure` | **CONFIRMED**, formed and printed |
| 6 | the [r993](REVIEW_r993.md) row in [reviews/INDEX.md](INDEX.md) says what r993 returned | none | **CONFIRMED** |
| 7 | [lean/INDEX.md](../lean/INDEX.md) and [LEDGER.md](../findings/LEDGER.md) say what r993 returned | none | **CONFIRMED on content, with ONE correction**: the index has no row for the new module |
| 8 | r993's two docstring corrections applied, no file contradicts itself | docstrings | **CONFIRMED**, with one heading to fix |
| 9 | NOT claimed anywhere: `StarWedgeIdentity` proved, or $\mathrm{Pf}^2=\det$ available | none | **CONFIRMED** |

Nothing is refuted. Two corrections follow, one of them a coverage gap in [lean/INDEX.md](../lean/INDEX.md) that the fold did not close.

## Row 5, attacked first: the composition is formed, and it carries `sorryAx`

The claim is checked rather than argued. I wrote the composition in a scratch file outside the repository and elaborated it under `lake env lean`:

```lean
theorem r994_composed : StarWedgeIdentity :=
  starWedge_of_pf pf6_complex_structure
```

It type-checks with no coercion, no auxiliary lemma and no bridging step, because `starWedge_of_pf`'s hypothesis is literally `∀ J, IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1` and `pf6_complex_structure` is literally a term of that type. Lean's own signatures, elaborated:

* `starWedge_of_pf : (∀ (J : Matrix (Fin 6) (Fin 6) ℝ), IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1) → StarWedgeIdentity`
* `pf6_complex_structure : ∀ (J : Matrix (Fin 6) (Fin 6) ℝ), IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1`

`#print axioms` then separates the three:

| declaration | axioms |
|---|---|
| `r994_composed` | `propext`, **`sorryAx`**, `Classical.choice`, `Quot.sound` |
| `starWedge_of_pf` | `propext`, `Classical.choice`, `Quot.sound` |
| `adjugate_law`, `starWedge_of_adjugate`, `stdJ6_isComplexStructure` | `propext`, `Classical.choice`, `Quot.sound` |
| `pf_sq_eq_det`, `det_complex_structure`, `pf6_complex_structure` | `propext`, **`sorryAx`**, `Classical.choice`, `Quot.sound` |

So the trap is exactly as the record describes it: a one-line term whose stated conclusion IS `StarWedgeIdentity`, whose two inputs are both honest theorems, and which is unsound as evidence. Read from artifacts `lake build --no-build` reports up to date across `9206` jobs.

**The record says so in all three places the brief names**, and I read each rather than trusting the commit message: [diagonal-half.md](../findings/diagonal-half.md) line 918, [lean/INDEX.md](../lean/INDEX.md) in both the I67Relabel and the I67Pf6 rows, and [plan.md](../plan.md) line 206. All three name both declarations, say the composition type-checks, say the term carries `sorryAx`, and say the identity is therefore not proved. **Three of three, and the wordings agree.**

## Rows 1 and 2: the statements are TRUE, which is what a `sorry` under them requires

A `sorry` under a false statement is a debt no cycle can ever discharge, so the statements are checked before the gaps.

**Row 1, hypothesis class.** `pf_sq_eq_det` takes `IsSkew X` and nothing else, where [IsSkew](../lean/HamiltonsCubic/Base/WeylReal.lean) is $X^{\mathsf T}=-X$. That is the right class and the whole class: $\mathrm{Pf}^2=\det$ is a polynomial identity in the fifteen free entries of a skew $6\times6$ and needs no further hypothesis, and it is FALSE off that class, so the hypothesis is load-bearing rather than decorative. The normalisation matches: [pf6](../lean/HamiltonsCubic/Base/Pfaffian6.lean) is `triple6 X X X` at $\tfrac1{48}=(2^3\cdot3!)^{-1}$, which is the standard Pfaffian, and the standard Pfaffian is the one that squares to the determinant. A layer carrying $\tfrac1{24}$ or $\tfrac1{96}$ instead would make the stated identity false by a factor of four, so the constant is what the row turns on.

**Row 2, and it is TRUE more widely than it is stated.** $\det J=1$ holds at every $J$ on $\mathbb R^6$ with $J^2=-\mathrm{Id}$, skew or not. $J$ makes $\mathbb R^6$ a complex vector space of dimension three, so the real Jordan form is three blocks $\begin{pmatrix}0&-1\\1&0\end{pmatrix}$, each of determinant $1$. Equivalently, every such $J$ is $S J_0 S^{-1}$ for some $S\in GL(6,\mathbb R)$ and $\det$ is conjugation-invariant. **So the skew half of `IsComplexStructure` is stronger than row 2 needs.** That is not a defect: the hypothesis is satisfied wherever the theorem is used, and a stronger hypothesis cannot make a true statement false. It is worth recording because it says where the `sorry`'s content actually sits, in $J^2=-\mathrm{Id}$ alone, and the docstring's justification (*"the sign is fixed because `J` has no real eigenvalue"*) is the same argument and is correct: $(\det J)^2=\det(-\mathrm{Id})=1$ gives $\pm1$, and eigenvalues in conjugate pairs give positivity.

*Screen, asserted over exact rationals on objects built for the purpose:* $\mathrm{pf6}(X)^2=\det X$ at twelve random integer skew $X$, with $\mathrm{pf6}$ rebuilt from `levi6` over all $720$ permutations and $\det$ by the Leibniz sum; the CONTROL that the same equality FAILS at random non-skew $M$, so skewness is doing work; $J_0^2=-\mathrm{Id}$, $J_0$ skew, $\det J_0=1$; and $\det\big(SJ_0S^{-1}\big)=1$ with $S J_0 S^{-1}$ squaring to $-\mathrm{Id}$ at ten random invertible integer $S$, skewness dropped.

## Row 3: the proof is honest, and the disjunction is derived

`pf6_complex_structure` reads, in full:

1. `hsq : pf6 J ^ 2 = 1`, by `rw [pf_sq_eq_det J hJ.1, det_complex_structure J hJ]`. The two rewrites are exactly rows 1 and 2, `hJ.1` being the skew component of `IsComplexStructure`, which is `IsSkew J ∧ J * J = -1`.
2. `(pf6 J - 1) * (pf6 J + 1) = 0`, by `nlinarith [hsq]`.
3. `rcases mul_eq_zero.mp this`, then `linarith` in each branch.

**No step smuggles anything in.** Step 2 is $t^2-1=(t-1)(t+1)$ over an ordered field and uses only `hsq`. Step 3 is the zero-product property of $\mathbb R$. The `∨` is genuinely derived from a factorisation and a case split rather than assumed: nothing in the file assumes a disjunction, and `starWedge_of_pf`'s own hypothesis is not in scope here. The only inputs are the file's two stated theorems.

**And the disjunction is not collapsible to one branch.** At the layer's own witness `stdJ6`, whose $\varphi=E_{ba}-E_{ab}$ makes $(\mathrm{stdJ6})_{01}=-1$, the value is $\mathrm{pf6}(\mathrm{stdJ6})=-1$ rather than $+1$. The $X=e_{01}+e_{23}+e_{45}$ that r993 pinned the sign at, with $X_{01}=+1$, is the other convention and gives $+1$. Both branches are realised by actual complex structures, so a future proof cannot shortcut to $\mathrm{pf6}(J)=1$. *Screen, asserted:* $\mathrm{pf6}$ at the layer's $\varphi$-built $J_0$ is $-1$, at the $e$-built $J$ is $+1$, and both square to $1$ against $\det=1$.

## Row 4: two `sorry`s, and no third behind a name

[I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) is fifty-six lines and declares exactly three theorems and nothing else: no `def`, no `instance`, no `example`, no local `axiom`, no `native_decide`, no `decide`, no `unsafe`. Three independent readings agree on the gaps:

* `lake build` emits `declaration uses sorry` at exactly two sites in the file, lines `35` and `41`, which are `pf_sq_eq_det` and `det_complex_structure`.
* `#print axioms` carries `sorryAx` on those two and on `pf6_complex_structure`, which is the correct propagation and not a third gap.
* The file imports only `I67Pf6`, and the dependency runs one way, so nothing it reaches was weakened: `adjugate_law`, `starWedge_of_pf` and `starWedge_of_adjugate` all still print the three standard axioms.

## Rows 6 and 7: the fold says what r993 returned

I read [r993](REVIEW_r993.md) end to end and then each record entry that summarises it. **No entry attributes a verdict r993 did not give, and none drops one it did.**

| what r993 returned | [reviews/INDEX.md](INDEX.md) | [lean/INDEX.md](../lean/INDEX.md) | [LEDGER.md](../findings/LEDGER.md) | [diagonal-half.md](../findings/diagonal-half.md) |
|---|---|---|---|---|
| ten of ten CONFIRMED, nothing refuted | yes | yes | yes | yes |
| PASSED, stated as such | yes | yes, both rows | yes | yes |
| two stale docstrings, its only findings | yes | yes | yes | yes |
| the overall sign pinned as $+\mathrm{Pf}$ | yes | yes | yes | yes |
| the $12$ belongs to the ordered sum, $6$ over $a<b$ | yes | implied | yes | yes |
| the `sorryAx` trap | yes | yes | yes | yes |

**It does not read as an unqualified pass.** Every one of the four entries carries the two corrections in the same breath as the ten CONFIRMED, and each names the trap. The [LEDGER](../findings/LEDGER.md) entry is the one a later reader meets first and it is the fullest of the four. The one claim I could not check against r993's text is the fold's count of *eleven controls*: r993 writes its screens in four grouped bullets that resolve to eleven or twelve assertions depending on how the adjugate-law entry check is counted. That is a fold's own arithmetic over another report's prose and it misleads nobody.

### The correction: [lean/INDEX.md](../lean/INDEX.md) has no row for the new module

[I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) is the **only** one of the 489 modules in [Results/](../lean/HamiltonsCubic/Results/) absent from the index table. I checked every one. It is imported by [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) at line 499, it builds, and it carries the entire remaining debt of `StarWedgeIdentity`, so it is the module a reader chasing that debt arrives at, and the index sends them nowhere. Its four siblings each have a row, including the two that the same fold edited.

**What the row should say**, so it can be copied: *I67 (what `StarWedgeIdentity` waits on) | [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) | **partial** | no numbered result: `pf_sq_eq_det` states $\mathrm{Pf}(X)^2=\det X$ at skew $X$ and `det_complex_structure` states $\det J=1$ at a complex structure, each with a named `sorry`, and `pf6_complex_structure` proves $\mathrm{pf6}(J)=\pm1$ from the two. Both statements are TRUE as stated (r994), the second at every $J$ with $J^2=-\mathrm{Id}$ whether skew or not. The gap is that Mathlib carries no Pfaffian and its `det_fin_*` lemmas stop at `Fin 3`. **THE TRAP**: composing `starWedge_of_pf` with `pf6_complex_structure` yields a term concluding `StarWedgeIdentity` that carries `sorryAx`.*

The state must be **partial**, not `proved`, which is what the table's own column promises.

A related staleness is **pre-existing and outside this scope**, recorded so it is not mistaken for new: the index header's audit sentence, dated 2026-09-09, says every `sorryAx` declaration sits in a `*Statement.lean` file. Five modules already break that independently of this round, [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean), [I36DiagTest.lean](../lean/HamiltonsCubic/Results/I36DiagTest.lean), [L204AltBound.lean](../lean/HamiltonsCubic/Results/L204AltBound.lean), [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean) and [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean). `f886591a` adds a sixth. The sentence is a dated snapshot rather than a live invariant, so this is a re-audit item and not a defect of either commit under review.

## Row 8: both corrections applied, and neither file now contradicts itself

* **[I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean)**, r993's first correction. *What this leaves owed* now reads *"Nothing in this file"*, names `star_wedge_pairing` as proved below, and moves the debt to the CHAIN, $\mathrm{pf6}(J)=\pm1$, pointing at the new file. The sibling *What is proved* list gained the pairing as a fifth bullet, which is the half r993 noted was missing. The stale *"Gate 2 owed on this file"* is gone and replaced by the pass. **Applied in full, and the file no longer lists as owed the theorem it proves.**
* **[L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) line 138**, r993's second. The docstring of `starWedge_of_adjugate` now says the first input *"is now the theorem `adjugate_law` sixty lines above"* and that only $\mathrm{Pf}(J)=\pm1$ remains. **Applied**, and it matches the file: `adjugate_law` is proved above it and `starWedge_of_pf` below it discharges the hypothesis. The module header at the top of the same file still describes the implication from two inputs, which is accurate about `starWedge_of_adjugate`'s type and is not a contradiction.
* **r993's looser gloss**, that the pairing's left side reduces to fifteen `sigma_i_j` theorems rather than thirty-six, was applied to [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean)'s header even though r993 called it *"worth a line rather than a fix"*. The old wording survives in the I67Pf6 row of [lean/INDEX.md](../lean/INDEX.md) and in [diagonal-half.md](../findings/diagonal-half.md). Cosmetic in both, and both read correctly in context, so this is noted rather than raised.

**One heading to fix, in the new file itself.** [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) line 23 heads its closing section **`## What is NOT stated`** and the text beneath it says *"Neither proposition is proved"*. Both propositions ARE stated, as theorems, and the whole point of `f886591a` is that the debt became a proposition rather than a sentence. The heading should read **`## What is NOT proved`**. A one-word fix, and it inverts the file's own distinction for anyone reading headings.

## Row 9: nothing overclaims

I searched every `.md`, `.lean` and `.tex` in the repository for `StarWedgeIdentity` against the vocabulary of proof. **No file asserts it is proved, and none asserts $\mathrm{Pf}^2=\det$ is available.** What the hits say instead:

* [lean/INDEX.md](../lean/INDEX.md) line 23 and the L191 row both call it *"a `Prop` neither proved nor assumed"*, unchanged by this fold.
* The L184 row still reads **partial** and still says `scalar_case_empty` takes it as an explicit hypothesis.
* [plan.md](../plan.md) line 206 keeps the item **open**, `- [ ]`, names the owed input, and carries the trap.
* [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) mentions it only as the conclusion of two implications.
* [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean)'s *NOT stated* list still names both $\mathrm{Pf}(X)^2=\det X$ and $\mathrm{pf6}(J)=\pm1$.

The fold's own additions to [I67Relabel.lean](../lean/HamiltonsCubic/Results/I67Relabel.lean) and [I67Pf6.lean](../lean/HamiltonsCubic/Results/I67Pf6.lean) claim **GATE 2 PASSED** on those files only, which is what r993 gave, and neither promotes the chain. The `- [ ]` on the plan item is the single most load-bearing character in the fold and it is still unchecked.

## Vacuity

Row 3 would be worthless on an empty hypothesis class, and the class is not empty.

* **The layer carries its own witness, machine-checked.** `stdJ6_isComplexStructure` in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 671 proves `IsComplexStructure stdJ6` for $\mathrm{stdJ6}=\varphi_{01}+\varphi_{23}+\varphi_{45}$, and `#print axioms` on it returns the three standard ones with no `sorryAx`. So `pf6_complex_structure` has at least one instantiation that is not vacuous, and so does the composed term of row 5.
* **The class is infinite, not a point.** $SJ_0S^{-1}$ is a complex structure at every invertible $S$, and $J_1=\varphi_{02}+\varphi_{14}+\varphi_{35}$ is a second skew one. *Screen, asserted:* $J_1^2=-\mathrm{Id}$, $\det J_1=1$, $\mathrm{pf6}(J_1)^2=1$.
* **Both conclusions of the disjunction occur**, as §row 3 records, so the statement is not secretly one-sided.

## What this leaves owed

One sentence, for the record to copy: **what remains owed is $\mathrm{Pf}(X)^2=\det X$ at skew $X$ and $\det J=1$ at a complex structure, both now TRUE as stated and each carrying a named `sorry`, and until one of them is discharged `StarWedgeIdentity` is not proved and no composition through `pf6_complex_structure` may be recorded as proving it.** Two housekeeping items ride along: [lean/INDEX.md](../lean/INDEX.md) needs a row for [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean) marked `partial`, and that file's `## What is NOT stated` heading should read `## What is NOT proved`.

## Method note

Row 5 was formed in Lean and its axioms printed rather than argued from the shape of the declarations. Rows 1 and 2 are derivations, with exact-rational screens on objects built for the purpose, every screen written as an assertion that fails the script rather than as a printed expectation, and one deliberate control that the skew hypothesis is load-bearing. Rows 6 to 9 are text comparisons against [r993](REVIEW_r993.md) read in full, and each record entry was read at its own line rather than through the commit message that wrote it.
