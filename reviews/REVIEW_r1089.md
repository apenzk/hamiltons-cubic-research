# REVIEW r1089

**Cold Gate 2, sole reviewer.** Commits under review: `d87bacfa` (the hook's shape match), `cf68552d` (the `pf6` split), `08582d19` (the `i73` repair and the fourth evasion).

**Footing: analysis-only, and honoured.** Every check below is a read, a grep, or a seconds-long run of a script already in the repo against objects already in hand. **One check DECLINED**: another session holds `lake build` (PID `21646`, elaborating `HamiltonsCubic.lean`), so no Lean process was started and none was killed. The axiom question that run would have answered is settled instead from [lean/axioms.json](../lean/axioms.json), and its date is given where it is used.

| # | claim | verdict |
|---|---|---|
| E1 | the shape match prints every problem `status_report.py` can emit, and nothing it should not | **REFUTED as stated.** All eight blocking kinds print. `NEAR-DUPLICATE PROPOSALS` is emitted and does not match, and `set -e` silences the hook's own guidance whenever nothing matches |
| E2 | the fourth evasion is closed in both forms, and no fifth exists | **REFUTED. FIVE evasions found, every one exiting 0**, one of them hiding the whole section from every check in the file. Plus one false positive |
| E3 | the `pf6` split is right | **CONFIRMED, with one correction**: the bridge is not the whole of the work |
| E4 | `StarWedgeIdentity` and `pf_sq_eq_det` are one question | **CONFIRMED**, and the axiom audit says so rather than the prose |
| E5 | the `ProblemPNamed` goal marker works and cannot silently lapse | **REFUTED on the second half.** The marker works in both directions in [plan-lean.md](../plan-lean.md) and reaches [STATUS.md](../STATUS.md) in neither, and **any debt can be marked away**, demonstrated on `StarWedgeIdentity` |
| E6 | every site that called `L74Bridge` open is now repaired | **REFUTED.** Two survive, and one of them is **on the line the commit rewrote** |

## E1. The shape match, run

**All eight message kinds print.** Each was triggered by mutating [STATUS.md](../STATUS.md), running [status_report.py](../scripts/misc/status_report.py) and applying the hook's own `grep -E "^[A-Z][A-Z0-9 ]+:"`, with the file restored after each: `NO STAMP`, `OVER BUDGET`, `STALE STAMP`, `POSITION MISSING`, `POSITION UNMARKED`, `POSITION RUN TOGETHER` in both of its forms, `POSITION COLLAPSED`, `POSITION EMPTY NODE`. The unmutated file exits 0 and prints nothing.

**EIGHT, NOT SEVEN.** `d87bacfa`'s message lists seven and `08582d19` added `POSITION EMPTY NODE` three minutes later, so the enumeration in the commit that removed the enumeration is already one short. *That is the defect the commit describes, surviving in the commit log rather than in the hook, which is the harmless place for it.*

**THE PROBLEM THE PATTERN DOES NOT MATCH IS REAL AND IS EMITTED ON EVERY RUN.** `NEAR-DUPLICATE PROPOSALS, check whether the repair is the same repair:` begins with a hyphen inside the first word, and `[A-Z0-9 ]` admits no hyphen, so the anchor fails. It appears in the output of every run made for this review, including the clean baseline. **It never reaches the author through the hook**, because it does not set the exit code either: [status_report.py](../scripts/misc/status_report.py)'s `main` returns `1 if problems else 0` and the near-duplicate scan is outside `problems`. *So the one advisory the script carries is invisible at the gate whether or not anything else fires.*

**AND THE HOOK SILENCES ITSELF WHEN NOTHING MATCHES.** The block runs under `set -e`, and `grep` exits 1 on no match, so the shell leaves the `then` branch at that line and the two guidance echoes below it never print:

```
pre-commit: STATUS.md is not current for a commit that moves the position.
EXIT=1
```

*That is the whole output of the branch, reproduced against `/dev/null`.* **The failure mode the commit names, a refusal with no reason, is therefore re-armed for exactly the class it was widened to catch**: a future check whose message does not fit the shape, or a crash of the script. None of `Traceback (most recent call last):`, `ValueError:`, `OSError:`, `KeyError:` matches, nor does an indented message. *A `|| true` after the grep restores the two lines, and printing the log's tail when the grep matched nothing restores the reason.*

**Nothing it should not**: no false positive was observed. The generated block's table rows begin with `|` and its headings with `*` or `**`.

## E2. Five evasions, every one exiting 0

*Each was run against a copy of the real [STATUS.md](../STATUS.md), with the stamp moved so `STALE STAMP` did not mask the result.*

| # | the evasion | result |
|---|---|---|
| 1 | three bullets reading `- ← .`, with the chain deleted | **exit 0, nothing printed** |
| 2 | the real first node repeated three times | **exit 0, nothing printed** |
| 3 | the chain written as ONE PROSE SENTENCE, with three decoy `- ← alpha` bullets under a `###` sub-heading | **exit 0, nothing printed** |
| 4 | a SECOND heading with the identical text, well-formed, after a position section with no bullets at all | **exit 0, nothing printed** |
| 5 | the real nodes in reverse order, goal at the bottom | **exit 0, nothing printed** |

**NUMBER 4 IS THE ONE TO FIX, AND IT IS NOT ABOUT THE POSITION.** `_sections` builds `out[name] = ...` over every `##` heading, so two sections with the same heading text collapse to one entry and **the earlier one is invisible to every check in the file**: `OVER BUDGET`, `NO STAMP`, `STALE STAMP` and the whole position block. *An accidental duplicate heading deletes a section from the gate with no message anywhere.* **The repair is three lines**: report `DUPLICATE HEADING: '<name>' appears N times` and keep both.

**NUMBER 3 REOPENS EVASION 1 IN WORDS.** The node count is taken over the entire section body rather than over one contiguous list, and the outside-the-list arrow check only fires on a line carrying the `←` glyph twice. A chain written with the word "from" and padded with three decoy bullets satisfies the count exactly. *Evasion 1 was closed against the glyph and the shape it was an instance of is open.*

**1, 2 and 5 are the check reading a node without reading what is in it.** They are worth recording and are not worth a check apiece: what they share is that a count cannot see a chain. **The one cheap guard that covers all three is to require the first node to name the goal and the last to carry the current item's marker**, both of which [STATUS.md](../STATUS.md)'s own header already mandates in prose.

**One false positive.** A node whose text contains an ordinary implication arrow, `- ← **R25**, the map $a$ -> $b$`, reports `POSITION RUN TOGETHER`. `ARROWS` holds `->` and `<-` and the test applies it to the node's text rather than to a second node boundary. *No current node trips it. A node describing a map or an implication would.*

## E3. The `pf6` split, tested by the object

**CONFIRMED on all three parts.**

- **`triple6` trilinearity is proved here.** Six theorems, `triple6_add_left`, `_smul_left`, `_add_mid`, `_smul_mid`, `_add_right`, `_smul_right`, in [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean), and the file carries no `sorry`.
- **`AlternatingMap.eq_smul_basis_det` exists where the docstring says, and is what it says.** [Mathlib/LinearAlgebra/Determinant.lean:659](../lean/.lake/packages/mathlib/Mathlib/LinearAlgebra/Determinant.lean) reads `theorem AlternatingMap.eq_smul_basis_det (f : M [⋀^ι]→ₗ[R] R) : f = f e • e.det`. *Applied to the map sending a family to the contraction of its images under `Q`, this is `∑ ε Q ⋯ Q = det Q • ε`, since that map's value on the basis is `det Q` and `ε` is `e.det`.* **A more direct lemma was looked for and does not exist**: nothing in `Determinant.lean` or `LinearAlgebra/Alternating/` states `f.compLinearMap g = det g • f`.
- **The bridge is genuinely absent, checked by object in both directions.** `AlternatingMap`, `MultilinearMap`, `ExteriorAlgebra` and `exteriorPower` appear in **exactly one file of this repository, the new docstring itself**. `Pfaffian` and `pfaffian` appear in **no file of the pinned Mathlib**, and `Mathlib/LinearAlgebra/ExteriorPower/` carries `Basic`, `Basis` and `Pairing` with no wedge multiplication. *So there is no alternating-map presentation of the `levi6` contraction to apply the uniqueness theorem to, under that name or any other.*

**THE CORRECTION: THE BRIDGE IS NOT THE WHOLE OF THE WORK.** What `eq_smul_basis_det` delivers through the bridge is `ε`'s equivariance, a statement about a `6`-linear form on `ℝ⁶`. What the route needs is `Pf(Q X Qᵀ) = det Q · Pf X`, a statement about a CUBIC form on bivectors. *Getting from one to the other is the substitution `(Q X Qᵀ)_{ab} = ∑ Q_{ai} X_{ij} Q_{bj}` into `triple6`'s six nested sums, then one application of the law inside them.* **It is routine and it is a `Finset.sum` manipulation over six indices**, which is the cost this layer has repeatedly found to be the cost. The sentence to change is *"WHAT IS OWED IS THE BRIDGE, AND IT IS THE WHOLE OF THE WORK"*: what is owed is the bridge and one resummation.

## E4. One question, and the audit says so

**CONFIRMED.** `starWedge_of_pf` is `starWedge_of_adjugate adjugate_law hPf`, so it takes **exactly one hypothesis**, `∀ J, IsComplexStructure J → pf6 J = 1 ∨ pf6 J = -1`. The adjugate law is discharged by the theorem `adjugate_law` sixty lines above, whose only hypothesis is that `X` is skew, which `IsComplexStructure.1` supplies.

**The adjugate law is genuinely proved and not itself hypothetical.** [lean/axioms.json](../lean/axioms.json), written 2026-09-22 and covering declarations older than that, gives:

| declaration | axioms |
|---|---|
| `L193Statement.adjugate_law` | `Classical.choice`, `Quot.sound`, `propext` |
| `L193Statement.starWedge_of_adjugate` | `Classical.choice`, `Quot.sound`, `propext` |
| `L193Statement.starWedge_of_pf` | `Classical.choice`, `Quot.sound`, `propext` |
| `I67PfSquared.det_complex_structure` | `Classical.choice`, `Quot.sound`, `propext` |
| `I67PfSquared.pf6_complex_structure` | the three, **and `sorryAx`** |

*The one `sorryAx` enters at `pf_sq_eq_det`, the single `sorry` in the chain, and [I67PfSquared.lean:147](../lean/HamiltonsCubic/Results/I67PfSquared.lean) is the only `sorry` in the five files involved.* **So the reduction is exact**: `StarWedgeIdentity` follows from `pf_sq_eq_det` and nothing else, `det J = 1` being proved outright.

## E5. The marker works, and it reaches nothing and guards nothing

*Run by regenerating [plan-lean.md](../plan-lean.md) in four states and reading back both tables, restoring the sources after each.*

| state | goal table | hypothesis-debt table | what `status_report.py` reads |
|---|---|---|---|
| as committed | `ProblemPNamed` | `StarWedgeIdentity` | `ProblemPNamed`, `StarWedgeIdentity` |
| marker stripped from `ProblemPNamed` | empty | `ProblemPNamed`, `StarWedgeIdentity` | `ProblemPNamed`, `StarWedgeIdentity` |
| marker restored | `ProblemPNamed` | `StarWedgeIdentity` | `ProblemPNamed`, `StarWedgeIdentity` |
| marker ALSO put on `StarWedgeIdentity` | `ProblemPNamed`, `StarWedgeIdentity` | **empty** | `ProblemPNamed`, `StarWedgeIdentity` |

**The control in [lean/INDEX.md](../lean/INDEX.md) reproduces**: strip the marker and the row rejoins the debt list, restore it and the section returns. *That half of the claim holds.*

**NOTHING STOPS A REAL DEBT BEING MARKED AWAY.** The token `Debt class: goal.` in a docstring is the entire test, with no whitelist, no count, and no cross-check against any other file. **Added to `StarWedgeIdentity`, the layer's last hypothesis debt, it empties the hypothesis-debt table**, and the only trace is a second row under a heading reading "The goal, which is NOT a debt". *A programme with one goal listing two of them is what a reader would have to notice unaided.* **The cheap guard is to refuse more than one goal**, or to require the marked name to appear in a named list, and the table's own heading is the argument for the first.

**AND THE MARKER NEVER REACHES THE POSITION FILE.** [status_report.py](../scripts/misc/status_report.py) reads `^\| \`(\w+)\` \|` over the whole of [plan-lean.md](../plan-lean.md), which matches the goal table's rows as well as the debt table's. **So [STATUS.md](../STATUS.md) reads `unproved hypothesis claims | 2 | ProblemPNamed, StarWedgeIdentity` in all four states above**, including the one where the goal is correctly separated and the one where every debt has been marked away. *The separation that [lean/INDEX.md](../lean/INDEX.md) records as bringing the count "from three to one" is undone one file downstream, in the block a status reply quotes verbatim.* **The repair is to read only the section after the hypothesis-debt heading.**

**"Cannot silently lapse" is false in a second way**: no hook runs [lean_debts.py](../scripts/misc/lean_debts.py). [.githooks/pre-commit](../.githooks/pre-commit) runs `lean_orphans.py` and `status_report.py` and nothing regenerates the debt file, so a lapsed marker shows only when somebody runs the script by hand.

## E6. Two sites survive, and one is on the line the commit rewrote

**[L144Statement.lean:485](../lean/HamiltonsCubic/Results/L144Statement.lean), in full**, is the whole finding:

> **WHAT REMAINED FOR THIS BRIDGE WAS THE WEIGHT IDENTIFICATION, AND IT IS NOW DONE**: the bridge is stated about `graphWeight A k` and the theorem about `srgWeight A (tOf v k)`, which the record says agree one `ext` apart, **and the two scale factors must be matched**. *That is **the next round** and it is named here rather than left as a feeling that something is still missing.*

*The diff of `08582d19` replaced the headline of that line and left the rest of it byte for byte.* **So one sentence now says the work is done and the next says it is the next round**, in one line, from the commit whose message is *"a theorem that landed with four sentences still calling it open"*. **This is [r1028](REVIEW_r1028.md)'s finding and [r1088](REVIEW_r1088.md)'s finding occurring a third time, inside the repair for the second one**, and in the same form both times: the substitution reached the words a reader would grep for and stopped before the clause carrying the same claim in other words.

**The second survivor, [L144Statement.lean:464](../lean/HamiltonsCubic/Results/L144Statement.lean)**, in the same docstring: *"It is carried as a hypothesis, in the same way `SphereProductValue` is carried there, so that nothing below silently assumes it."* **Present tense, and it is a theorem.** *The paragraph is malformed as well, carrying a closing `*` that opens nothing.*

**One further stale row, weaker and worth naming.** [lean/INDEX.md:318](../lean/INDEX.md) still reads *"`L74Bridge` assumes what L74 already PROVES in this repo … so the weaker assumption is made where the stronger theorem exists"*. That is the row [r1088](REVIEW_r1088.md) named as line 315 and the commit did not touch it. *It does not call the bridge open, so it is staler rather than wrong, and the audit finding it reports is now discharged rather than outstanding.*

**What IS repaired, checked against the whole record.** A grep for `L74Bridge` over every tracked file outside `.git` and `.lake` returns hits in [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean), [L74Statement.lean](../lean/HamiltonsCubic/Results/L74Statement.lean), [I73ScaleUnique.lean](../lean/HamiltonsCubic/Results/I73ScaleUnique.lean), [lean/INDEX.md](../lean/INDEX.md) and the reviews. *The two `L74Statement.lean` sites and the `I73ScaleUnique.lean` site are past tense and correct, the three repaired `lean/INDEX.md` rows are correct, and the reviews are dated findings that must not be rewritten.* **[plan-lean.md](../plan-lean.md) carries no `L74Bridge` row at all**, which is right.

## Two things found while looking, neither in the three commits

- **An UNTRACKED scratch file in `lean/` refuses every commit that touches `lean/` or the record.** [lean_orphans.py](../scripts/misc/lean_orphans.py) walks the working tree rather than the index, so a file nobody has staged and nobody will commit still fails [.githooks/pre-commit](../.githooks/pre-commit)'s first gate. *Observed twice during this review, on `WCP2Try.lean` and then on `WCP2Entry.lean`, both belonging to the session working in `lean/` alongside this one. Neither was touched.* **The point is the scan and not the files**: an in-progress module is exactly what an author has in the tree while committing something else, and the gate reads the orphan check's purpose, reachability of what the build compiles, off a set the build does not compile.
- **`status_report.py` prints `NEAR-DUPLICATE PROPOSALS` on every clean run.** Whatever the pair is, it has been advertised to nobody for as long as the exit code has been 0.

