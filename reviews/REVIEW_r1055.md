# Review r1055: the withdrawals and the tool changes

**Scope**: `4a4623c4` (withdraw L72Algebra, drop the dead-open category), `a12143dd` (the nested-namespace repair), `eb0260cf` (three residues and the id audit). SOLE reviewer. Analysis-only footing: the runs below are a four-probe Lean screen on namespaces I constructed, one `lake build` on the tree as committed, and re-runs of the two audit scripts on objects in hand. All reported as screens.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | the L72Algebra withdrawal is correct and complete | **PLAUSIBLE as an action, REFUTED as stated.** The deletion is safe and the tree builds, but *"takes the SAME hypotheses"* is false for all three theorems and *"strict superset"* does not hold |
| 2 | the dead-open category is genuinely empty | **CONFIRMED**, and by a stronger route than the parent gave. All four forms raise `unknown namespace`, and the unstated premise, that every file is built, also holds |
| 3 | what survives of the tool is correct | **REFUTED**, with a live counterexample. `--ns` finds **two of the four** files that open `HamiltonsCubic.RealLayer.OperatorNorm`, and one of the two it misses is load-bearing |
| 4 | `lean_id_audit.py` does what it claims | **CONFIRMED on the parent's own test**, with three latent holes and one demonstrated gap in the regex |
| 5 | the three residue fixes | **REFUTED on completeness.** *"BINDS"* is correct, but **four further sites** still assert the superseded state, one of them two rows below a row `4a4623c4` edited, and the sentence removal left broken markup |
| 6 | two files per id, held by 143 of 145 | **REFUTED on the count and on the conclusion.** The true figure is **127**, and **fourteen** ids carried three or more files at that commit, [L34](../lean/HamiltonsCubic/Results/L34.lean) carrying thirteen |
| 7 | overreach sweep | **four items**, the largest being that the deletion rule was applied selectively and that the surviving query has a worse demonstrated miss rate than the category that was deleted |

---

## Claim 1: the withdrawal is safe, the reason given for it is not

**The action is sound.** Nothing in the tree imports [L72Algebra.lean](../lean/HamiltonsCubic/Results/L72Algebra.lean): after the deletion `grep -rn L72Algebra .` returns only [lean/INDEX.md](../lean/INDEX.md) row 123, this review and [r1054](REVIEW_r1054.md), all prose. The root import at [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) was removed, and **`lake build` completes successfully over 9250 jobs** on the tree as committed (run here, roughly nine minutes, tree already in hand). The parent's commit does not say it checked this.

**But `rows_force_spectrum` does not take the same hypotheses, and it is not a strict superset of any of the three.** It carries hypotheses each deleted theorem does without:

| deleted theorem | its hypotheses | what [rows_force_spectrum](../lean/HamiltonsCubic/Results/L72Statement.lean) adds |
|---|---|---|
| `eq_of_rows` | `0 < a`, `0 < b`, `lam = a + b`, `0 ≤ T`, rows (ii) and (iii) | **row (i)** and the **unit norm** `lam^2 + a^2 + b^2 = 1` |
| `theta_eq_of_rows` | `0 < a`, `lam = 2 * a`, rows (i) and (ii) | **`0 ≤ T`**, **`0 < b`**, **row (iii)** and the **unit norm** |
| `scale_of_unit` | `0 < a`, `lam = 2 * a`, `lam ^ 2 + a ^ 2 + a ^ 2 = 1` | **all three rows** and **`0 ≤ T`**. `scale_of_unit` is pure arithmetic and needs no criticality row at all |

A theorem with more hypotheses and more conclusions is not a superset. The correct statement is narrower and still supports the deletion: **the FILE [L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean) subsumes the CONTENT**, because `branch_split` plus `second_branch_impossible` together derive `a = b` from exactly `eq_of_rows`' hypotheses, that being the derivation inlined at lines 115 to 119 of `rows_force_spectrum`. **What has no standalone counterpart is `scale_of_unit`**, whose statement over `lam` and `a` alone appears nowhere else in the layer. It is recoverable in one `nlinarith` line, so the loss is negligible, but the record should say the content is recoverable rather than that it is already proved.

**Correction owed** at [lean/INDEX.md](../lean/INDEX.md) row 123 and in the commit's own reasoning: replace *"takes the SAME hypotheses and returns all three conclusions ... so it is a strict superset"* with the file-level claim, and name `branch_split` and `second_branch_impossible` as the pair that carries `eq_of_rows`.

**One housekeeping note.** Before the build above, `.lake/build/lib/lean/HamiltonsCubic/Results/L72Algebra.olean` was still on disk. A stale `olean` keeps `import HamiltonsCubic.Results.L72Algebra` resolving locally, so a green local build is weaker evidence than a fresh checkout would be. Here it does not matter, since no file writes that import.

## Claim 2: CONFIRMED, and the premise the parent left unstated also holds

**Four probes, all four error** (against Mathlib, toolchain `v4.33.1`, files removed after):

| form | result |
|---|---|
| `open X` | `error: unknown namespace` |
| `open scoped X` | `error: unknown namespace` |
| `open X in #check (1 : Nat)` | `error: unknown namespace`, **and the `#check` still prints** |
| `open scoped X in #check (1 : Nat)` | `error: unknown namespace`, and the `#check` still prints |

The deferred-elaboration case the brief asked about changes the *recovery* behaviour and not the *diagnostic*: Lean reports the error and carries on elaborating the command. An error still fails the build, so the conclusion survives.

**The argument has a premise the commit does not state: every file must actually be built.** A file no import reaches would never be elaborated and could carry a dead open indefinitely. I checked it. **Two of the 543 files are absent from the root import list**, [CP2Sharp.lean](../lean/HamiltonsCubic/Base/CP2Sharp.lean) and [KillingForm.lean](../lean/HamiltonsCubic/Base/KillingForm.lean), and **both are reached transitively** (by [RelationC.lean](../lean/HamiltonsCubic/Base/RelationC.lean), [RelationBSharp.lean](../lean/HamiltonsCubic/Base/RelationBSharp.lean) and [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean)), and the build covers 9250 jobs. So the category is empty on this tree, and the deletion removed nothing that could fire. **Record the reachability premise beside the probe**, because it is the half that could stop holding when someone adds an orphan file.

## Claim 3: REFUTED, and the counterexample is already in the tree

**`--ns HamiltonsCubic.RealLayer.OperatorNorm` reports two files. Four open that namespace.**

| file | how it opens | reported |
|---|---|---|
| [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) line 59 | `open scoped HamiltonsCubic.RealLayer.OperatorNorm` | yes |
| [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) line 189 | `open scoped HamiltonsCubic.RealLayer.OperatorNorm` | yes |
| [SphereFermat.lean](../lean/HamiltonsCubic/Results/SphereFermat.lean) line 27 | `open scoped NNReal Matrix.Norms.Frobenius OperatorNorm`, inside `namespace HamiltonsCubic.RealLayer` | **no** |
| [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) line 809 | `open scoped OperatorNorm`, inside the same namespace | **no** |

**The cause is the regex.** `re.findall(r"HamiltonsCubic\.[A-Za-z0-9_.]+", line)` demands a literal `HamiltonsCubic.` prefix, so an `open` written relative to the enclosing namespace is invisible. The very repair `a12143dd` made for `namespace` lines, tracking the enclosing scope, was not made for `open` lines, though the same nesting causes the same blindness.

**And the miss is load-bearing.** `OperatorNorm` declares two `scoped instance`s, `NormedAddCommGroup (CurvOp2 ι)` and `NormedSpace ℝ (CurvOp2 ι)`. [SphereFermat.lean](../lean/HamiltonsCubic/Results/SphereFermat.lean) opens it for exactly those. Remove one and SphereFermat stops elaborating while the audit says only two files are at risk. **This is precisely the EMPTIED-OPEN failure the tool was written for, on the only namespace anyone has examined.**

**The docstring overclaims in both directions.** *"it lists the files that reach that namespace's names through `open`, which is exactly the set that stops compiling"*:

- **over-inclusion**: a file that opens `X` and uses no name from it is listed and would not break. The tool matches `open` lines and never checks use.
- **under-inclusion by qualification**: a file inside any `namespace HamiltonsCubic.Y` reaches `X.foo` by prefix resolution with no `open` line at all, as does one writing the fully qualified name. Neither is detectable by this scan.
- **under-inclusion by relative `open`**: the four-file case above.
- **`export`** would re-export a name into a third namespace and create a breakage path through a file that opens neither. There is no `export` in the tree today, so this is latent rather than live.
- `line.startswith("open ")` also misses an indented `open`. None today.

**The honest description** is *"the files that name this namespace in a fully qualified `open`"*, which is a useful heuristic and not a compiling set. **Correction owed** in the docstring and at [scripts/INDEX.md](../scripts/INDEX.md).

## Claim 4: CONFIRMED on the parent's test, with holes worth recording

**It would have found [L72Statement.lean](../lean/HamiltonsCubic/Results/L72Statement.lean).** `lean_id_audit.py L72` lists it with seven theorems, one `sorry`, and `rows_force_spectrum` by name. `lean_id_audit.py I77` lists all three I77 files with their twelve sorry-free theorems. The parent's own case passes.

**Four holes.**

- **The second half of the report is empty in both test cases**: *"OTHER FILES MENTIONING L72: 0"* and the same for I77. The path that would catch content under a different filename returns nothing on either test, so it is claimed rather than demonstrated.
- **A file proving an id's content without writing the id string is invisible.** The tool's reach is naming and mention, not content. That is the case the brief asks about, and the answer is no.
- **`^(?:theorem|lemma) (\S+)` misses a real declaration.** [L23Statement.lean](../lean/HamiltonsCubic/Results/L23Statement.lean) line 159 carries `private theorem sqrt_four_mul`, uncounted. Attribute-prefixed, `nonrec` and indented declarations go the same way.
- **The `sorry` counter `^\s*sorry\s*$` misses an inline `sorry`.** A file with `:= by sorry` on one line reports **0 sorry**, which reads as *"a superset may already be proved, sorry-free"*, the exact conclusion the tool exists to support. No instance in the tree today, so it is latent, and it is the hole most likely to cause the failure the tool was written to prevent.

## Claim 5: the fixes are true, and the fold is still short by four sites

**"BINDS" is correct and is [r1053](REVIEW_r1053.md)'s own word.** The cap cuts the feasible set, the record's low-branch vertex at `n = 12`, `s = 6` carries `t_3 = 120` against an allowance of `2s(s-1) = 60`, it binds on exactly `n/2 ≤ s ≤ n-2`, and it takes the `n = 12` maximum from `3.853570` to `2.42212`. The description in [plan.md](../plan.md) is right.

**Two fixes land, one lands partly, and four sites were never reached.**

| site | state |
|---|---|
| [plan.md](../plan.md) line 125 | fixed, and `4a4623c4` correctly hedged `2.42212` as *"on r1053's SCREEN"* |
| [plan.md](../plan.md) line 73 | says the cap BINDS, but states `2.42212` **flat, with no screen hedge**. The hedge reached one of two sites |
| the dangling *"struck text is kept below"* sentence | **removed, and the removal broke the markup**: [diagonal-half.md](../findings/diagonal-half.md) line 1403 now reads `... and it was not made.** **SO THE PAIR CAP ...`, closing a span opened with a single `*` on a double |
| the dead link | fixed, `[the successor paragraph](#)` is now plain text |
| [diagonal-half.md](../findings/diagonal-half.md) line 1401 | **still asserts** *"What remains untried in I77 is the PAIR CAP"* |
| [diagonal-half.md](../findings/diagonal-half.md) line 1403 | **still asserts** *"SO THE PAIR CAP IS UNTRIED AND THE ITEM IS LIVE"*, in the same paragraph the commit edited |
| [lean/INDEX.md](../lean/INDEX.md) row 124 | **still asserts the refuted claim**: *"it types why the PAIR CAP cannot move I77's triangle programme, which the plan had carried as untried"*. `4a4623c4` edited row 123 and left row 124 |
| [I77PairCap.lean](../lean/HamiltonsCubic/Results/I77PairCap.lean) line 6 | the file's **title line still reads** *"# I77: the pair cap is INERT in the triangle programme"*, while lines 15 and 16 of the same docstring record that the claim is FALSE and refuted by r1053 |

**So the commit that names the counting-sites rule, and calls it broken for the second time that day, broke it a third time in the same commit.** It claimed *"the fold reached one site of three"*. On the record there were at least seven, and after the commit four still assert the superseded state, two of them in files the same session edited.

**A fifth site, from `4a4623c4` rather than `eb0260cf`.** [scripts/INDEX.md](../scripts/INDEX.md) row 416 still describes the dead-open check as live: *"catching two failures Lean accepts SILENTLY ... A DEAD OPEN names a namespace nothing declares ... reports NO dead opens, which is correct"*, and closes *"Exits non-zero when a dead open is present, so it is gate-ready"*. **The code path was deleted and the tool now always returns 0.** `4a4623c4` touched [lean/INDEX.md](../lean/INDEX.md), [plan-lean.md](../plan-lean.md) and [plan.md](../plan.md) and did not touch [scripts/INDEX.md](../scripts/INDEX.md). That row also carries a stray `*` after *"do exist."*.

## Claim 6: REFUTED, the count and the inference both

Grouping every `lean/HamiltonsCubic/**/*.lean` file by the leading `[A-Z]+[0-9]+` of its stem, at the tree of `eb0260cf` itself (544 files):

| quantity | value |
|---|---|
| ids with more than one file | **147** (146 under four narrower groupings, so the parent's 145 is within rounding of the grouping choice) |
| of those, holding exactly `X` and `XStatement` | **127**, not 143 |
| of those, holding exactly two files under any naming | **133** |
| **ids holding THREE OR MORE files** | **14** |

**The inference is the larger error.** A third file is the layer's routine pattern, not a signal. [L34](../lean/HamiltonsCubic/Results/L34.lean) carries **thirteen** files (`L34`, `L34Statement`, `L34b` through `L34l`), [L30](../lean/HamiltonsCubic/Results/L30.lean) six, [L35](../lean/HamiltonsCubic/Results/L35.lean) and [I67](../lean/HamiltonsCubic/Results/I67Pf6.lean) five each, [I106](../lean/HamiltonsCubic/Results/I106Criticality.lean) four, and [L33](../lean/HamiltonsCubic/Results/L33.lean), [L19](../lean/HamiltonsCubic/Results/L19.lean), [L42](../lean/HamiltonsCubic/Results/L42.lean), [L61](../lean/HamiltonsCubic/Results/L61.lean), [L70](../lean/HamiltonsCubic/Results/L70.lean), [L71](../lean/HamiltonsCubic/Results/L71.lean), [L73](../lean/HamiltonsCubic/Results/L73.lean) three each, plus I77 and L72. A detector keyed on *"a third file exists"* fires on fourteen ids, twelve of which are the layer working normally.

**The refinement that survives, and is worth recording.** The layer extends an id with a **lettered** suffix, `L34b`, `L30c`. A third file with a **word** suffix is genuinely rare: at `eb0260cf` only four ids carry one, and **two of the four are the parent's own additions of that day**, `L72Algebra` and `I77PairCap`. The other two are `I67` and `I106`, which have no `X`/`XStatement` pair at all and are word-suffixed throughout. **So the signal is not the third file, it is a word-suffixed file beside an existing `X`/`XStatement` pair**, which fires on exactly `L72Algebra` and nothing else in the tree. That is a sharper detector than the one claimed and it is one line of the same script.

**Correction owed** in the [scripts/INDEX.md](../scripts/INDEX.md) row for [lean_id_audit.py](../scripts/misc/lean_id_audit.py), which repeats *"the layer's convention is two files per id ... so a THIRD file for an id is the signal"*.

## Claim 7: overreach sweep

- **"a strict superset"**, [lean/INDEX.md](../lean/INDEX.md) row 123. False, see claim 1.
- **"which is exactly the set that stops compiling"**, [lean_open_audit.py](../scripts/misc/lean_open_audit.py). False in both directions, with a live four-file counterexample, see claim 3.
- **"A checker whose findings are all false trains its reader to ignore it, so the repair is deletion."** The premise is right for the dead-open check and the conclusion follows there. **The rule was then applied selectively.** The same sentence appears in `a12143dd` to justify a REPAIR and in `4a4623c4` to justify a DELETION, so it is not doing the distinguishing work its placement claims. What distinguishes the two is that the dead-open CATEGORY is empty while the emptied-open category is not. **And the survivor is the weaker instrument on the evidence available**: the dead-open check produced one false positive, and `--ns` misses two of four on the single namespace anyone has checked. Judged by the sentence the parent wrote, `--ns` is the one that trains its reader to ignore it.
- **"the --ns query is unaffected and still returns exactly the three files that open HamiltonsCubic.L15Statement."** True as a count, and the word *"exactly"* travels into the docstring where it becomes false.
- **"the layer's convention is TWO files per id, held by 143 of the 145."** The numerator is wrong by sixteen, see claim 6.
- **"Both withdrawals wait on r1054."** One landed. [I77PairCap.lean](../lean/HamiltonsCubic/Results/I77PairCap.lean) is still in the tree with an INERT title line and an intact [lean/INDEX.md](../lean/INDEX.md) row asserting the refuted claim, and nothing in the record says that withdrawal is outstanding.

**Two things checked and found sound, recorded so they are not re-opened.**

- **[plan-lean.md](../plan-lean.md)'s `542` to `543` across a deletion is correct**, though the direction reads wrong. The figure is written by [lean_debts.py](../scripts/misc/lean_debts.py) from `len(files)`, the pre-existing `542` was stale by two, and `543` matches the tree exactly.
- **`a12143dd`'s "438 to 443"** is consistent: the audit reports 442 today, one lower because `4a4623c4` deleted `HamiltonsCubic.L72Algebra`.

**One consequence nobody has noted.** After `4a4623c4`, the `declared` set that `a12143dd`'s namespace-stack repair was built to compute **has no consumer left but a summary `print`**. The careful fix survives as a number in a status line. Either give it back a use, by having `--ns` warn when the queried namespace is undeclared, or drop the stack tracking with the category it served.

---

## Recommendations, in order

1. **Fix [lean_open_audit.py](../scripts/misc/lean_open_audit.py)'s `open` scan the way `a12143dd` fixed its `namespace` scan**, by resolving a relative `open` against the enclosing namespace stack. Until then, downgrade the docstring from *"exactly the set that stops compiling"* to *"the files naming this namespace in a fully qualified open"*, and say the set is neither sound nor complete.
2. **Reach the four unfixed pair-cap sites**: [diagonal-half.md](../findings/diagonal-half.md) lines 1401 and 1403, [lean/INDEX.md](../lean/INDEX.md) row 124, and [I77PairCap.lean](../lean/HamiltonsCubic/Results/I77PairCap.lean)'s title line. Hedge `2.42212` at [plan.md](../plan.md) line 73 as a screen, matching line 125.
3. **Repair the broken emphasis** at [diagonal-half.md](../findings/diagonal-half.md) line 1403, `not made.**` for `not made.*`.
4. **Rewrite [scripts/INDEX.md](../scripts/INDEX.md) row 416.** The tool it describes no longer has a dead-open path and no longer exits non-zero, so the row promises a gate that cannot fire.
5. **Correct [lean/INDEX.md](../lean/INDEX.md) row 123** to the file-level subsumption, naming `branch_split` and `second_branch_impossible` as the pair carrying `eq_of_rows`, and record that `scale_of_unit` is recoverable rather than already proved.
6. **Replace the two-files-per-id claim** with the word-suffix detector, which fires on `L72Algebra` alone and on none of the fourteen ids that legitimately carry three or more files.
7. **Count inline `sorry` in [lean_id_audit.py](../scripts/misc/lean_id_audit.py)** and widen its declaration regex past `private`, attributes and indentation. A latent `0 sorry` on a file that carries one would produce exactly the duplication the tool exists to prevent.
