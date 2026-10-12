# REVIEW r814: the falsifier's common-support clauses, the compaction hook, the L144 and `finrank` record repairs, and the proposals table

**Reviewer r814, Gate 2 on the second fold.** Brief taken cold. **No numerical work was done**: every check below is either a reading of the file on disk, a Lean build, or a screen of seconds on objects constructed for that purpose, and every value is exact. Log: [agent_logs/g2-fold2-r814.log](../agent_logs/g2-fold2-r814.log). Range audited: `git log --oneline 298e8e52..HEAD`, plus [b3cd5212](../.claude/hooks/skill_reread.py), which the brief names as target B and which sits one commit *below* that range (it is the parent of `298e8e52`).

| Claim | Verdict |
|---|---|
| **A**, the falsifier's common-support clauses, `9c0f7bde` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** The two invertibility clauses *do* give the four-dimensional analogue's common-support hypothesis, and *common* is automatic once each form is invertible. The file builds. **A fourth thing is still missing**: the self-wedge coincidence is typed at the single `(0,1,2,3)` component where the hypothesis is an equality in `Λ⁴`, and the full-strength lemma is already proved three files away at [L183Statement.lean:419](../lean/HamiltonsCubic/Results/L183Statement.lean). |
| **B**, the hook repair, `b3cd5212` | **CONFIRMED, one residual.** The import works, `os.path.basename(flag)` is the right argument shape, `re` is in scope, a foreign session cannot be blocked, and no session can be wedged. **Residual, screened**: the marker's `session:` line is written from the payload alone while `armed_for` also matches `CLAUDE_CODE_SESSION_ID`, so in the env-only case the backstop is silently inert. |
| **C1**, L144's row and box, `54f89fec` | **REFUTED. A fourth place still asserts the promotion**: [findings/diagonal-half.md:480](../findings/diagonal-half.md) reads *"[Lemma L144](#observation-l144--…)"*. The heading revert changed the anchor and left the visible label, and this commit did not reach it. |
| **C2**, the `finrank` scope correction, `6114e00f` | **CONFIRMED.** The narrowed claim is exactly true: 18 files under [Results/](../lean/HamiltonsCubic/Results/) use `finrank`, 11 use `Submodule.span`, and [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) carries neither in any declaration. |
| **C3**, the `!` narrowing, `d9733ff6` | **CONFIRMED as a sentence, and its own first application was not revisited.** Proposal 81's `!` was stripped by `6c43b437` on the ground this commit refutes, and row 81 was left unmarked. |
| **D**, the proposals table, `54f89fec` | **CONFIRMED on the arithmetic, and the table no longer renders as a table.** All ten corrections re-derived independently and all ten are right. The pre-state carried exactly ten violations, agreeing with [r812](REVIEW_r812.md) and [r813](REVIEW_r813.md). **A blank line at [.claude/skill-proposals.md:47](../.claude/skill-proposals.md), left by `6114e00f`, ends the markdown table and drops the 43 rows below it out of it.** |
| **Bystander**, `d9733ff6` | **[reviews/INDEX.md](INDEX.md) now carries two rows numbered 813**, at lines 1155 and 1156. The fold indexed r813 in a commit that already had r813's own row from `298e8e52`. |

**One line, actionable.** *Four of the five repairs land in substance. The defect the round was convened to find has recurred once in the mathematics (target A's self-wedge component) and once in the record (target C1's fourth L144 site), and the two commits that made record repairs each introduced a new structural defect of their own.*

## 0. Conventions, fixed once

- **The support of a `2`-form** `ω` on `V` is `range ω`, which equals `range(-ω²)` by [L180](../findings/diagonal-half.md)'s own step (`ω²x = 0` forces `‖ωx‖² = -xᵀω²x = 0`). A skew `ω` on `ℝ⁴` is invertible exactly when its support is all of `ℝ⁴`.
- **L191's hypothesis**, quoted from [findings/diagonal-half.md:750](../findings/diagonal-half.md): *"Let ω₁, ω₂ be 2-forms with a common six-dimensional support, ω₁² = ω₂² and ω₁∧ω₁ = ω₂∧ω₂. Then ω₂ = ±ω₁."*
- **The four-dimensional analogue** is that sentence with *six* replaced by *four*. A falsifier must exhibit a pair satisfying every hypothesis and failing the conclusion.
- **`wedgeSelf X`** is [SelfDual.lean:106](../lean/HamiltonsCubic/Base/SelfDual.lean)'s `wedge2 X X`, a raw four-index function `ι → ι → ι → ι → ℝ`, not a quotient by alternation. `Phi X = (X * X, wedgeSelf X)`.
- **The impact ladder**, quoted from [.claude/skill-proposals.md:12](../.claude/skill-proposals.md): *"5+ scores 10, 3–4 scores 8, twice scores 6, once scores 3. A critical single occurrence overrides that and scores 7, and a critical recurrence scores 9–10."* Total is impact times importance; the promotion bar is 70.

## 1. Target A: the clauses give the common support, and one hypothesis is still typed at one component

### 1.1 The two clauses do what the commit says

The added clauses, from [L191Statement.lean:100](../lean/HamiltonsCubic/Results/L191Statement.lean):

```
      (∃ ν, unitSD 0 * ν = 1) ∧ (∃ ν, unitSD 1 * ν = 1)
```

`ν` elaborates at `Matrix (Fin 4) (Fin 4) ℝ` and `1` is the identity, so each clause is a right inverse. Over a commutative ring a square matrix with a right inverse is invertible, so each form has range all of `ℝ⁴`. **`Common` is then automatic**: both supports are the whole space, so they coincide, and the coincident support is four-dimensional. There is no gap of the kind the brief asks about, and the same `∃ ν, X * ν = 1` shape is what the record already uses for *invertible, hence rank four* at [L190Statement.lean:60](../lean/HamiltonsCubic/Results/L190Statement.lean)'s `sdCombo_nondecomposable`, so the encoding is the record's own.

The discharge is honest. `hinv` exhibits `(-2 : ℝ) • unitSD k` and closes through [SelfDual.lean:572](../lean/HamiltonsCubic/Base/SelfDual.lean)'s `unitSD_sq`, which states `unitSD k * unitSD k = (-(1/2 : ℝ)) • 1`, so `unitSD k * ((-2) • unitSD k) = (-2) • (-(1/2)) • 1 = 1`. **Screen**: `lake build HamiltonsCubic.Results.L191Statement` completes successfully, no `sorry`, one style linter note on an unused `simp` argument in `inner2_neg_right`.

**The index row is accurate on this.** [lean/INDEX.md](../lean/INDEX.md)'s L191 row now reads *"are each invertible so their supports coincide at all of ℝ⁴"*, which is the conclusion and not only the clauses, and the same row already carried *"consistent with L191 holding at dim V = 4"*, so the four-dimensionality of the witness against L191's six is stated.

### 1.2 The fourth thing: the self-wedge is compared at one component

L191's second coincidence is `ω₁∧ω₁ = ω₂∧ω₂`, an equality in `Λ⁴V`. What the falsifier types, at [L191Statement.lean:98](../lean/HamiltonsCubic/Results/L191Statement.lean), is

```
      wedgeSelf (unitSD 0) 0 1 2 3 = wedgeSelf (unitSD 1) 0 1 2 3
```

**a single component of a four-index function.** The hypothesis a falsifier must *satisfy* is the equality of the whole object. Agreement at one index tuple does not give agreement everywhere unless the function is known to be alternating, and no lemma in this file or in its imports supplies that reduction.

**The record itself treats the two as different.** [lean/INDEX.md](../lean/INDEX.md)'s L183 row calls `wedgeSelf_sdForm_eq` *"the Λ⁴ℝ⁴ one-dimensionality that [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) explicitly declined to check, 256 index tuples at Fin 4"*, and [r810](REVIEW_r810.md) named the same thing on the weaker predecessor: *"Only the (0,1,2,3) component of Λ⁴ is compared, the alternation lemmas that would extend it never invoked."*

**And the full-strength lemma is already proved.** [L183Statement.lean:419](../lean/HamiltonsCubic/Results/L183Statement.lean):

```
theorem wedgeSelf_unitSD_eq (i j : Fin 3) : wedgeSelf (unitSD i) = wedgeSelf (unitSD j)
```

function equality, no `sorry`, and [L183Statement.lean:426](../lean/HamiltonsCubic/Results/L183Statement.lean)'s `Phi_unitSD_eq` packages it with the square as `Phi (unitSD i) = Phi (unitSD j)`. The falsifier's own closing docstring line says *"'the images coincide' and 'the squares and the self-wedges coincide' are the same statement"*, naming `Phi`, whose second component is the full function. So the docstring claims the `Phi` equality and the theorem types one of its components. [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean) imports only [L190Statement.lean](../lean/HamiltonsCubic/Results/L190Statement.lean), which imports [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean) and [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), so the repair is one import line and one term.

**Argue the opposite.** `Λ⁴ℝ⁴` is one-dimensional, so the two self-wedges *are* equal as forms, and the mathematics of the falsification is untouched. That is exactly why this is `CONFIRMED AS TYPED, PROSE OVERCLAIMS` rather than `REFUTED`: the witness satisfies the hypothesis, and the kernel has not been told so. It is the same shape as the defect the commit was written to close, one clause further along, for the third round running.

**Verdict A: CONFIRMED AS TYPED, PROSE OVERCLAIMS.**

## 2. Target B: the hook works, and the marker's owner line can be written empty

### 2.1 The four mechanical questions

- **Does importing `loop_flag` work under the harness's invocation?** Yes. [.claude/settings.json:59](../.claude/settings.json) runs `python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/skill_reread.py"`, and running a script by path puts the script's directory on `sys.path[0]` already, so the explicit `sys.path.insert` is redundant and correct. [loop_stop.py](../.claude/hooks/loop_stop.py) imports the same module the same way at line 54.
- **Is `os.path.basename(flag)` the right argument shape for `armed_for`?** Yes. [loop_flag.py:63](../.claude/hooks/loop_flag.py) takes `flag=FLAG` where `FLAG = "research-loop-active"` is a bare filename, and joins it as `os.path.join(cwd, ".claude", flag)`. `LOOPS` builds `".claude/" + loop_flag.FLAG` and then strips the prefix back off, so the prefix in the dict key is decorative, but the value handed to `armed_for` is right.
- **Does `re` exist in the new `loop_stop.py` branch's scope?** Yes, [loop_stop.py:48](../.claude/hooks/loop_stop.py) imports it at module level, and `payload` is bound at line 434 inside the same `main()`.
- **Can the marker block a session that is not its owner, or wedge one?** No to both. The read-side guard requires `owner.group(1) == str(mine).strip()`, so a stale marker from a dead session matches nobody. The message names the file to delete, and the block counter at the head of `main()` exits 0 once `blocks >= MAX_BLOCKS` or `total >= MAX_BLOCKS_HARD`, so the branch cannot hold a session indefinitely even if the file were undeletable.

### 2.2 The residual, screened

[skill_reread.py:59](../.claude/hooks/skill_reread.py) writes the owner line as `"session: " + str(payload.get("session_id", ""))`, from the payload alone. [loop_flag.armed_for](../.claude/hooks/loop_flag.py) matches against *either* the payload id or `CLAUDE_CODE_SESSION_ID`, and its own docstring says the env fallback exists because *"the shell arming the flag and the hook reading it need not agree on which id they see"*. So a session identified only by the environment variable passes `armed_for`, gets its marker written, and the marker's owner line is empty.

**Screen, reported as a screen** (a temporary tree in the scratchpad, no repository file touched): with a flag file reading `session: ENVONLY-123`, `CLAUDE_CODE_SESSION_ID=ENVONLY-123` and a payload of `{"source":"compact"}`, the hook fires and prints its message, and the marker it writes is

```
'.claude/skills/research-loop/SKILL.md\nsession: \n'
```

against which `re.search(r"^session:\s*(\S+)\s*$", marker, re.M)` returns `None`. So `owner` is falsy and [loop_stop.py](../.claude/hooks/loop_stop.py)'s branch never fires. **The backstop is inert in exactly the case the flag matching was widened to cover.** The fix is one expression: write the same `payload.get("session_id") or os.environ.get("CLAUDE_CODE_SESSION_ID", "")` that the read side already uses.

**Argue the opposite.** The failure is fail-open, not fail-closed, so it costs a missed reminder rather than a blocked session, and the SessionStart message still prints, which the hook's own docstring calls the signal that *"actually precedes the next cycle action"*. In every invocation where the harness supplies `session_id` in the payload, which is the normal case, both halves work. This is a residual, not a refutation.

**One coverage note.** `LOOPS` names `FLAG` and `VERIFY_FLAG` and omits `AUDIT_FLAG = "audit-active"`, so the [audit-results](../.claude/skills/audit-results/SKILL.md) loop has no compaction gate. That is a choice the code does not state; [.claude/rules/research-loop-reread.md](../.claude/rules/research-loop-reread.md) names only the two loops, so it is consistent with the rule.

**Verdict B: CONFIRMED, with the empty-owner residual named.**

## 3. Target C: two of three repairs land, and L144 has a fourth site

### 3.1 L144: the label survives at [findings/diagonal-half.md:480](../findings/diagonal-half.md)

The three places the brief asks after are now coherent. The heading at [findings/diagonal-half.md:538](../findings/diagonal-half.md) reads `#### Observation L144`; row 144 of [findings/INDEX-results.md](../findings/INDEX-results.md) opens `| **144** | Observation |` and its cell now says *"THAT DERIVATION IS THE REVIEWER'S OWN AND NO INDEPENDENT READER HAS CHECKED IT, so the type stays `Observation`"*; [plan.md:387](../plan.md) reads `[Observation L144]`. The rewritten box no longer closes on *"superseded by a proof"* and now closes on *"a reviewer's derivation entering the record as a verdict is the thing Gate 2 exists to catch"*, which is the honest statement.

**A fourth place asserts the promotion.** [findings/diagonal-half.md:480](../findings/diagonal-half.md), inside the L74 sign box, reads

```
[Lemma L144](../findings/diagonal-half.md#observation-l144-no-dgk-point-lies-in-the-band-except-the-balanced-product)
```

and the diff of `8e80de5a` shows precisely how it got there: the line went from `[Lemma L144](#lemma-l144--…)` to `[Lemma L144](#observation-l144--…)`. **The revert updated the anchor and left the visible label**, so the file that owns the block still calls L144 a Lemma in prose while its own heading four dozen lines below calls it an Observation. `54f89fec`, whose whole subject was the incomplete revert, did not reach it. `git log -S` confirms this is the only occurrence of the pattern and that `8e80de5a` introduced it.

**Argue the opposite.** It is link text rather than a type column, and the anchor it points at is correct, so a reader who follows the link lands on the right heading and sees the right type. That is why the record is *inconsistent* rather than *wrong*. It is nonetheless a type assertion in a findings file, which is the same category of thing the two prior rounds refuted twice.

**r813's three Lemmas citing an Observation: CONFIRMED, and it matters as little as the other 21.** Screen, reported as a screen: [.claude/skills/structure-check/check.py](../.claude/skills/structure-check/check.py) reports `F Lemmas citing an Observation: 24 (reported, not enforced)`, and three of the edges are `L74 -> L144`, `L96 -> L144` and `L130 -> L144`. So the count is right. The check is advisory, 21 such edges predate the revert, and [findings/LEDGER.md:1528](../findings/LEDGER.md) keeps a standing list of *"Observations carrying Lemmas"*, so the pattern is a tolerated one. All three citations are of L144's closed form, which both [r675](REVIEW_r675.md) and [r676](REVIEW_r676.md) confirmed cold, and not of the unaudited primitive half, so no live claim rests on the unchecked derivation.

*Bystander, outside the targets and not introduced by this round*: that same LEDGER line links `[L144](route-a.md)` where L144's block is in [diagonal-half.md](../findings/diagonal-half.md).

### 3.2 The `finrank` correction is itself correct

**What the docstring now says**, [SelfDual.lean:63](../lean/HamiltonsCubic/Base/SelfDual.lean):

> *"**The `finrank` statement `dim Λ²₊ = 3`.** `star4_star4` proves `⋆ ∘ ⋆ = id` on bivectors, `selfDual_expand` proves the three exhibited members span, and `sdCombo_independent` proves they are independent, so `Λ²₊` has a three-element basis. **No declaration states the dimension**, and no declaration in this file states it. `finrank` and `Submodule.span` are used freely in [Results/](../lean/HamiltonsCubic/Results/), so the absence is this layer's rather than the repository's."*

**Checked against the tree.** 18 files under [Results/](../lean/HamiltonsCubic/Results/) contain `finrank` and 11 contain `Submodule.span`, among them [L34Statement.lean](../lean/HamiltonsCubic/Results/L34Statement.lean), [L30Statement.lean](../lean/HamiltonsCubic/Results/L30Statement.lean), [L179Statement.lean](../lean/HamiltonsCubic/Results/L179Statement.lean) and [L184Statement.lean](../lean/HamiltonsCubic/Results/L184Statement.lean). [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) contains the tokens only inside doc comments, in no declaration. **So the narrowed claim is exactly true and [r810](REVIEW_r810.md)'s wider one was false**, as [r813](REVIEW_r813.md) reported. The [lean/INDEX.md](../lean/INDEX.md) paragraph carries the same narrowing.

The bolded *"No declaration states the dimension"* that precedes the narrowing is a claim about `dim Λ²₊` and not about the tokens, and it survives: no declaration anywhere in [lean/](../lean/) states a rank or `finrank` of `selfDualForms`. So the sentence is redundant rather than an overclaim, and the redundancy is the only thing I would still change.

### 3.3 The `!` sentence is right, and its first application was left standing

**What the sentence now says**, [.claude/skill-proposals.md:9](../.claude/skill-proposals.md):

> *"A `!` marks a **critical** one: it would have falsified a recorded claim, corrupted a bound in the unsafe direction, or let a defect survive an audit that was looking for it. **The third disjunct alone is about the net**, so an audit that CAUGHT its target earns no `!` on that ground. The first two stand independently and are counterfactual: what the defect would have done had it survived, which an audit catching it does not change."*

**This is correct.** Disjuncts one and two are counterfactual conditionals about the defect's consequences, and whether an audit intercepted it is not among their truth conditions. The superseded sentence, *"An audit that CAUGHT the defect it was aimed at earns no `!`, since the net worked"*, discharged all three on a ground that touches only the third, which is what [r812](REVIEW_r812.md) and [r813](REVIEW_r813.md) both refuted.

**Does the table's existing use of `!` match it?** The narrowing is permissive: it restores marks the old sentence would have struck, so no `!` standing in the table becomes wrong by it. **The one row it should have reopened was not reopened.** `6c43b437` stripped proposal 81's mark, and its own commit body gives the ground: *"the mark means a defect that survived an audit looking for it; all three were caught by the audit aimed at them, so it is unearned."* That is the reading `d9733ff6` refutes, three commits later, and row 81 still reads `| 81 | **24** | 3 | 8 | 1 | waits |` with no `!` and no note that its mark rests on a withdrawn reading. **The finding was answered in the sentence and not in the row**, which is this round's own subject.

**Argue the opposite.** The narrowing does not automatically restore any mark: it says an audit's catch is no longer a reason to strike one, leaving whether disjunct one or two applies to 81's incident as a fresh judgement nobody has made. So the correct action is to re-examine 81, not to re-mark it, and the omission is a missing judgement rather than a wrong figure. That distinction does not save it, because at 1 occurrence the mark is worth 4 points of impact and 32 of total, and the row's score is currently the product of a reading the record has withdrawn.

**Verdict C: REFUTED on L144, CONFIRMED on `finrank`, CONFIRMED on the `!` sentence with its first application unrevisited.**

## 4. Target D: the ten corrections are all right, and the table stopped being a table

### 4.1 Re-derivation, independent of the commit body

Screen, reported as a screen: I parsed the table at `e402c155` (the state before the repair) and at `HEAD`, applied the ladder quoted in §0 to each row's occurrence count and `!`, and compared.

**Before: exactly ten violations**, which is [r812](REVIEW_r812.md)'s count and [r813](REVIEW_r813.md)'s, on the same ten rows:

| id | occ | `!` | impact was | ladder gives | now |
|---|---|---|---|---|---|
| 80 | 1 | yes | 6 | 7 | 7 |
| 79 | 3 | yes | 8 | 9–10 | 9 |
| 62 | 1 | yes | 6 | 7 | 7 |
| 59 | 3 | no | 5 | 8 | 8 |
| 60 | 3 | yes | 7 | 9–10 | 9 |
| 53 | 3 | yes | 7 | 9–10 | 9 |
| 71 | 2 | yes | 8 | 9–10 | 9 |
| 56 | 3 | yes | 6 | 9–10 | 9 |
| 54 | 1 | no | 6 | 3 | 3 |
| 55 | 6 | no | 5 | 10 | 10 |

**All ten are right.** Every new impact is the ladder's value and every total is the exact product with the untouched importance.

**On the critical recurrences.** Five rows are critical recurrences (79, 60, 53, 71, 56) and the ladder gives them a *band*, 9 to 10, not a value. All five were set to 9, which is consistent, and the choice changes no outcome: at 10 the totals would be 80, 90, 90, 80, 80, still all at or over the bar, and all five carry `HOLD` either way. So for those five the edit is a defensible reading of a discretionary band rather than an arithmetic determination, and the commit body's *"corrected to the table's own mapping"* is stronger than the mapping supports for them. It is exact for the other five.

**Six rows crossed the bar**, as claimed: 55 (35 to 70), 79 (64 to 72), 60 (63 to 81), 53 (63 to 81), 71 (64 to 72), 56 (48 to 72). With 75 already at 81 and 57 raised to 80 by the same commit, that is the eight rows at or over the bar that `54f89fec` set to `HOLD`. `6114e00f` then rescored 57 to 64 and `waits`, leaving seven.

**After: the table is arithmetically clean.** 69 rows, no duplicate ids, every product exact, zero ladder violations, seven rows at or over 70 and all seven carrying `HOLD`, and no `HOLD` below the bar.

### 4.2 The renumbering broke no link, and one body was already unreachable

Screen: every table row's anchor was resolved against the file's own headings, GitHub slug rules. **68 of 69 resolve.** Row 84's anchor resolves, and it is distinct from row 79's, so **the renumbering broke nothing**. The one failure is row 75, pointing at `#promoted-2026-09-08`, which is the dead body [r812](REVIEW_r812.md) and [r813](REVIEW_r813.md) reported: the proposal was promoted into a skill and its body deleted. `54f89fec` held 75 rather than fixing it, and its commit body says so, so this is disclosed rather than missed. It is still true that one proposal's body is unreachable.

### 4.3 The blank line inside the table

[.claude/skill-proposals.md:47](../.claude/skill-proposals.md) is empty, between row 13 and row 54. It was left by `6114e00f`, whose diff replaces row 83 in its old position with an empty line after inserting it above row 9:

```
-| 83 | **42** | 6 | 7 | 2 | waits | [hooks/](hooks/) | …
+
```

**A blank line terminates a markdown table.** 26 rows sit above it and **43 sit below**, and those 43 lose the header, the alignment row and the table rendering entirely. Every row from 54 down, including the whole tail of the queue, renders as literal pipe-separated text. The fix is deleting one line.

**Argue the opposite.** The data is intact, every row is still parseable, and the arithmetic screen above reads all 69 rows without difficulty. The defect is presentational. It is worth reporting because this table is the record's own queue, its ordering by total is the thing a reader consults, and it was broken by a commit whose purpose was to repair a row of that same table.

### 4.4 Is `HOLD` coherent?

**As defined, yes.** [.claude/skill-proposals.md:16](../.claude/skill-proposals.md) states what it means (*"the score is not yet trustworthy"*), when it attaches (*"A row reaching the bar through a correction rather than through a new incident is held"*), and how to clear it (*"writing the fix beside each occurrence, splitting the row where the fixes differ, and re-checking the `!` against its three disjuncts"*). That is a complete rule.

**What it lacks is an owner and a trigger.** No loop, hook or skill is obliged to clear a hold, and nothing re-reads the table on a schedule. The observable state is that **all seven rows at or over the bar are held**, so the rule two lines below, *"Applied automatically at a total of 70 or more"*, currently applies to no row at all: one commit disabled the promotion mechanism for every row that reaches it. That is not incoherent, and it is the conservative direction, but a row can now sit at 81 indefinitely with nobody obliged to look at it. The one-line repair is to name the actor, for instance that the fold at the end of a Gate 2 round clears one hold, or to date each hold so an unattended one is visible.

**Verdict D: CONFIRMED on the arithmetic, with the table's rendering broken by the sibling commit and `HOLD` lacking an owner.**

## 5. What would falsify each target, and what I did to look for it

| Target | What would falsify my verdict | What I did |
|---|---|---|
| **A** | A lemma in [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean) or its imports reducing four-index function equality to the `(0,1,2,3)` component, which would make the single-component clause the full hypothesis; or the invertibility clauses failing to give a *common* support. | Read the file whole and its two imports. Grepped the tree for every `wedgeSelf` lemma and found the full-strength one at [L183Statement.lean:419](../lean/HamiltonsCubic/Results/L183Statement.lean), outside L191's import chain. Traced `unitSD_sq` to check `hinv` is not vacuous. Built the module with `lake` and it compiled clean. |
| **B** | `armed_for` taking a path rather than a filename; `re` absent from `loop_stop.py`'s scope; the marker blocking a foreign session; the payload always carrying `session_id`, which would make the residual unreachable. | Read [loop_flag.py](../.claude/hooks/loop_flag.py) end to end and checked the `flag=` join. Grepped `loop_stop.py`'s imports and located `payload`'s binding. Ran the hook in a scratch tree on an env-only session id and read the marker it wrote, then evaluated the read-side regex against it. |
| **C** | A fourth L144 site not existing, which is what I looked for and found; the `finrank` narrowing being false in either direction; the `!` sentence overriding a disjunct it should override; proposal 81 carrying a `!` after all. | Grepped every `L144` mention outside [reviews/](.) and [ATTEMPTS.md](../ATTEMPTS.md), then used `git log -S` to date the surviving label to `8e80de5a`. Counted `finrank` and `Submodule.span` across [Results/](../lean/HamiltonsCubic/Results/) and inside [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean). Read `6c43b437`'s commit body for the ground on which 81's mark was struck, and read row 81 as it now stands. |
| **D** | Any of the ten corrections disagreeing with the ladder; a different violation count in the pre-state, which would contradict both prior reviewers; row 84's anchor or another row's failing to resolve; the table rendering intact. | Parsed the table at `e402c155` and at `HEAD` and applied the ladder to every row independently of the commit body. Resolved all 69 anchors against the file's headings. Counted the rows on each side of line 47. |

## Overall verdict

**GAP.** *No theorem in the range is wrong, the Lean file builds, and four of the five repairs answer their findings in substance. What is owed is one Lean clause that already exists elsewhere in the tree, one stale label in [findings/diagonal-half.md](../findings/diagonal-half.md), one re-examination of proposal 81's `!`, one deleted blank line, one deduplicated review index row, and one expression in [skill_reread.py](../.claude/hooks/skill_reread.py).* **Every one of the six is a single-line edit.**

## Closing: should the next round be spent on the mathematics?

**Yes, and the process work that remains is smaller than a round.**

Three consecutive rounds have audited repairs, and this round found the recurrence rate falling rather than holding: [r810](REVIEW_r810.md) and [r811](REVIEW_r811.md) found four defects of substance, [r812](REVIEW_r812.md) and [r813](REVIEW_r813.md) found the same shape three times, and I found it twice, in one Lean clause and one link label, with the remaining four items being typos in the ordinary sense. **The loop is converging, and the next iteration of it has a low expected yield.** A fourth process round would be auditing single-line edits, which is the shape of work that costs more to convene than to do.

**Two things argue for stopping now rather than after one more.**

- **The six open items do not need a reviewer.** They need a commit. None involves a judgement a second reader would improve, with the single exception of proposal 81's `!`, which needs one person to ask whether *"an index row credited a declaration with stating a dimension no declaration states"* would have falsified a recorded claim had it survived. That is a paragraph, not a round.
- **The record's own mathematics has a named, tractable next step that nobody has taken.** [I38](../plan.md) has not moved since L191 was derived, and L191's fold states the remaining question in one line: at rank three, *"is `dim V = 4` forced, or is there such a triple with `dim V ≥ 6`?"*, with [L178](../findings/diagonal-half.md) covering `dim V = 4` and `dim V = 2` impossible. At rank two, L191 leaves `dim V ≥ 8` with a repeated eigenvalue of `-ω₁²`, and [r808](REVIEW_r808.md) established that case 1's argument is dimension-free, so the survivor is a *named stratum* rather than an open expanse. **That is a research item with its hypotheses already written down**, which is the state in which a cycle is most likely to produce something.

**What I would still audit, and it is one item rather than a round.** [findings/diagonal-half.md](../findings/diagonal-half.md) records `⋆_V(J ∧ J) = 2ε_J J` as `HYPOTHESIS-DEBT` with *"no machine check in either direction, r808's attempt exceeded its screening budget"*, and [plan.md](../plan.md) carries it as I40. **Two of L191's three cases stand on it**, and [lean/INDEX.md](../lean/INDEX.md)'s L191 row says the layer carries it as `StarWedgeIdentity`, *"a `Prop` neither proved nor assumed"*. That is a live mathematical dependency under an unproved identity, not a process defect, and it is the one thing on the list that a Gate 2 round is the right instrument for. **It also has the property the process items lack: whichever way it comes out, a numbered result changes.**

*So: fold the six one-line repairs into a single commit, put the next round on I40 or I38, and let the process items be audited by the next fold that touches them rather than by a round convened for them.*
