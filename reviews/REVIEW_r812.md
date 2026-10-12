# r812: Gate 2 on the fold: did the repairs the last round demanded reach the substance?

*Cold brief. I was given four commits and the pointers, and read [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [L183Statement.lean](../lean/HamiltonsCubic/Results/L183Statement.lean), [lean/INDEX.md](../lean/INDEX.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/diagonal-half.md](../findings/diagonal-half.md), [plan.md](../plan.md), [skill_reread.py](../.claude/hooks/skill_reread.py), [loop_stop.py](../.claude/hooks/loop_stop.py), [loop_flag.py](../.claude/hooks/loop_flag.py), [skill-proposals.md](../.claude/skill-proposals.md) and both prior reports on disk.*

| Target | Verdict |
|---|---|
| **A**, the Lean repair, `409a229e` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** `falsifier_at_dim4` is true, builds clean, and its distinctness clause does exactly the work [r810](REVIEW_r810.md) and [r811](REVIEW_r811.md) said was missing. *But L191's hypothesis is a COMMON SIX-DIMENSIONAL SUPPORT, and no clause of the declaration says the two forms have common support at all.* **So the typed statement is still consistent with the four-dimensional analogue holding**, which is the shape of the defect the repair was made for, one clause along. `sdCombo_independent` is right and the basis claim is accurate. |
| **B**, the record fold, `8e80de5a` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** The L191 row and the star-layer paragraph are now accurate against the declarations, and the *"four things L178 step 1 needs"* checks out against the block. **The L144 revert is incomplete in the two places both prior reviewers named**: row 163 of [findings/INDEX-results.md](../findings/INDEX-results.md) still reads *"the primitive half is now PROVED"* and *"so this becomes a `Lemma`"*, and the new box that names the contradiction ends by asserting one side of it. |
| **C**, the compaction hook, `ddf7215f` | **REFUTED.** *The verification loop's flag is `.claude/verification-active`, and [skill_reread.py](../.claude/hooks/skill_reread.py) looks for `.claude/verification-loop-active`*, which nothing writes. **The hook can never fire for the verification loop**, which is one of the two loops the rule it enforces names. The audit loop's flag is not in the table at all. *And the marker gates the TURN ENDING, not the next cycle action.* |
| **D**, the scoring rule, `6c43b437`, `74448b2e`, `9badd8ad` | **SPLIT.** The occurrence test is **CONFIRMED** as correct and does not over-split. *The `!` narrowing is **REFUTED** as written*: it overrides two of the three disjuncts in the bullet it was appended to. **Its own first application breaks it**: the two split-off failures became prose inside proposal 81 rather than the two proposals the rule demands. **Proposal 57 is padded across at least two different repairs and is still at `APPLY`. Proposal 75, the other row over the bar, has no body anywhere in the repository.** |

**One line.** *Every declaration under review is true and the Lean builds clean. What fails is that three of the four repairs were made to the letter of the finding: the falsifier gained the clause it was told to gain and still omits the hypothesis it must meet, the L144 revert moved the heading and not the table, and the scoring rule was written and then not applied to the two rows it was written to protect.*

## 0. What I checked, and the standing rule

**Analysis only.** One screen was run: `lake build HamiltonsCubic.Results.L191Statement`, which the brief names as permitted, reported `Build completed successfully (8712 jobs)`. One second screen parsed the 69-row table in [skill-proposals.md](../.claude/skill-proposals.md) for arithmetic, duplicate ids and impact-against-occurrence consistency. Both are reported as screens below and neither is offered as evidence for a positive claim. Everything else is by hand against the files on disk.

## 1. Target A, the falsifier

### 1.1 The distinctness clause is real and does the work it was added for

On disk, [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean) ends with

```
theorem falsifier_at_dim4 :
    inner2 (unitSD 0) (unitSD 0) = 1 ∧ inner2 (unitSD 1) (unitSD 1) = 1 ∧
      inner2 (unitSD 0) (unitSD 1) = 0 ∧
      unitSD 0 * unitSD 0 = unitSD 1 * unitSD 1 ∧
      wedgeSelf (unitSD 0) 0 1 2 3 = wedgeSelf (unitSD 1) 0 1 2 3 ∧
      unitSD 1 ≠ unitSD 0 ∧ unitSD 1 ≠ -unitSD 0
```

The two distinctness clauses are proved from orthonormality alone, and the route is right: if `unitSD 1 = unitSD 0` then `inner2 (unitSD 0) (unitSD 1)` is `1` rather than `0`, and if `unitSD 1 = -unitSD 0` then `inner2_neg_right` makes it `-1`. `inner2_unitSD` in the base layer gives `if i = j then 1 else 0`, so `h00` and `h01` are what the proof says they are. **This is the clause [r810](REVIEW_r810.md) and [r811](REVIEW_r811.md) found absent, and it is now present and load-bearing.**

### 1.2 The gap moved rather than closed: the common-support hypothesis is typed nowhere

The record's L191, quoted from [findings/INDEX-results.md](../findings/INDEX-results.md) row 191: *"TWO $2$-FORMS WITH A COMMON SIX-DIMENSIONAL SUPPORT, EQUAL SQUARES AND EQUAL SELF-WEDGES SATISFY $\omega_2=\pm\omega_1$"*. Three hypotheses, not two. The four-dimensional analogue the file claims to falsify therefore reads: two forms with a common four-dimensional support, equal squares and equal self-wedges satisfy `ω₂ = ±ω₁`.

**Nothing in `falsifier_at_dim4` says the two forms have common support, or that either is nondegenerate.** Orthonormality does not give it: two orthonormal skew forms can each be degenerate. So the typed conjunction is satisfied by configurations that do not meet the analogue's hypotheses, and the typed statement is consistent with the analogue holding. That is precisely the criticism the repair answers, one clause along: *the declaration does not by itself contradict the statement the file header says it contradicts.*

**The strongest defence, which I built and which does not save the prose.** The fact is not in doubt. `unitSD_sq` in the same imported layer gives `unitSD k * unitSD k = (-(1/2)) • 1`, so each `unitSD k` is invertible with inverse `-2 • unitSD k`, hence of rank four, hence supported on all of `ℝ⁴`. The support hypothesis is automatic for members of `Λ⁺ℝ⁴`, so the mathematical falsification is airtight and the missing clause costs one line. **But that is exactly the position the fold itself calls out three files away**: [lean/INDEX.md](../lean/INDEX.md) now says of the dimension that it is *"a consequence of what is typed rather than something typed"*, and the same sentence is owed here. The file header instead says flatly *"So L191's conclusion fails at `dim V = 4`"*, which needs the hypothesis to be met, and no declaration says it is.

### 1.3 The single `Λ⁴` component is enough, and this one I could not break

The self-wedges are compared only at `(0,1,2,3)`. Against that: [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) carries `wedgeSelf_swap01`, `wedgeSelf_swap12`, `wedgeSelf_swap23` and `wedgeSelf_diag01`, all for skew `X`. The three transpositions generate `S₄`, and `wedgeSelf_diag01` with them kills every tuple carrying a repeated index, so on `Fin 4` the value at `(0,1,2,3)` determines the function. **The file's own docstring says so**, and it is right. The full function equality is also typed outright as `wedgeSelf_unitSD_eq` in [L183Statement.lean](../lean/HamiltonsCubic/Results/L183Statement.lean), though that file is not in L191's import closure (L191 imports L190, which imports L187, L186, L185 and the base layer). **So the component comparison is a presentational choice, not a gap.**

### 1.4 `sdCombo_independent` and the basis claim

`selfDual_expand` gives `X = (-X 0 1) • sdForm 0 + (-X 0 2) • sdForm 1 + (-X 0 3) • sdForm 2` for skew self-dual `X`, and `sdCombo_independent` reads the coefficients back off entries `(0,1)`, `(0,2)` and `(0,3)`. I checked those three entries by hand from `phi i j a b = [j=a][i=b] - [i=a][j=b]`: at `(0,1)` only `sdForm 0` contributes and contributes `-1`, at `(0,2)` only `sdForm 1`, at `(0,3)` only `sdForm 2`. **The proof is sound and the two together do give a basis**, `sdForm_mem` putting the three in the submodule. The row's claim is accurate, including its insistence that no declaration states the dimension. I grepped the layer: `finrank`, `LinearIndependent`, `Submodule.span` and `Basis` appear in docstrings and nowhere else.

### 1.5 One inherited inaccuracy

Both the file header and the two index rows say the falsifier sits *"one dimension below"* the hypothesis. `dim V = 4` is two below `dim V = 6`. It reads as one rung down a ladder of even dimensions, and it predates this commit, so it is noted rather than charged.

## 2. Target B, the record fold

### 2.1 The L191 row is repaired, and correctly

Row 87 of [lean/INDEX.md](../lean/INDEX.md) now names `falsifier_at_dim4`, quotes its clauses, says which one is load-bearing, records that `pair_coincidences_at_dim4` *"falsified nothing"*, and attributes both findings. Row 191 of [findings/INDEX-results.md](../findings/INDEX-results.md) matches. **No overclaim survives here**, subject to §1.2, which is a defect of the declaration rather than of the row: the row credits `falsifier_at_dim4` with exactly the clauses it has.

### 2.2 The star-layer paragraph

*"THE DIMENSION ITSELF IS STATED BY NO DECLARATION ... so $\dim\Lambda^2_+=3$ is a consequence of what is typed rather than something typed"* is **accurate**, on the grep in §1.4. *"the three exhibited members are a basis"* is accurate as a consequence and is labelled as one.

The new clause I attacked hardest is *"it is one of four things [L178](../findings/diagonal-half.md)'s step 1 needs, the others being the $\Lambda^\pm$ splitting with $W$ block-diagonal for it, each summand trace-free ... and the rank trichotomy"*. Step 1 on disk reads *"On $\Lambda^2V$ the operator splits as $W^+\oplus W^-$ with each summand self-adjoint and trace-free on a three-dimensional space, so each has rank $0$, $2$ or $3$, never $1$."* Four ingredients, exactly as listed, and step 4 confirms the trace-freeness costs first Bianchi as well as tracelessness. **The correction is right and the old credit to spanning alone was wrong.**

*One stale figure survives the rewrite.* The paragraph still says the file is *"$728$ lines"*. It is 794 on disk, 773 at the base of this range, and `409a229e` is what lengthened it. The paragraph was rewritten in the next commit without the count being reread.

### 2.3 The L144 revert is incomplete in the two places both prior reviewers named

The heading at [findings/diagonal-half.md:538](../findings/diagonal-half.md) is back to `Observation L144`, and the single anchor referring to it and the [plan.md](../plan.md) citation were both updated. That half is clean.

**Row 163 of [findings/INDEX-results.md](../findings/INDEX-results.md) was not touched by the fold and still reads:** *"**Gate 2: GAP, and the gap runs in its favour: the primitive half is now PROVED** ... **$\theta<\tfrac12$ for every primitive strongly regular graph, at every $n$, with no census**, and $\tfrac14$ is the sharp unattained supremum, *so this becomes a `Lemma`*"*. Its type column says `Observation`. [r810](REVIEW_r810.md) §4.4 item 1 named that row. [r811](REVIEW_r811.md) recommendation 4 named it by line number and quoted the same words: *"the table label at line 163 and [plan.md](../plan.md)'s I18(a) clause must all say one thing"*. **The fold changed the heading and left the table, which is the mirror image of the defect the previous commit was refuted for, and it is the more load-bearing of the two by the record's own argument that the table is what a citation resolves against.**

**And the new box asserts the thing it was written to stop asserting.** It opens *"A DERIVATION OF THE PRIMITIVE HALF EXISTS AND IS UNAUDITED, SO THE TYPE STAYS `Observation`"* and closes, unchanged from the box it replaced, *"The block's own grade of 'screened and not proved' was honest and is now superseded by a proof."* Those are contradictory in one paragraph. The brief asks whether the fold moved an overclaim rather than removing one: **here it removed the headline and left the sentence.**

*The defence I tried.* The box's job after the revert is to record the contradiction rather than arbitrate it, and stating what the derivation says is part of that job. That defends *"What the derivation says: ..."*, which is properly attributed. It does not defend *"is now superseded by a proof"*, which is the block speaking in its own voice about its own status, and it does not defend row 163 at all.

*Attribution check.* The box's *"both halves rest on [r676](REVIEW_r676.md)'s own derivations, which no independent reader has checked"* is [r811](REVIEW_r811.md)'s own wording, carried from its index row. The box is correct about which reviewers found what.

## 3. Target C, the compaction hook

### 3.1 The SessionStart contract is right

`source` takes `startup`, `resume`, `clear`, `compact` and `fork`, `compact` fires on both automatic and manual compaction, the payload carries `session_id` and `cwd`, and a SessionStart hook's stdout is added to the model's context at exit 0. **[skill_reread.py](../.claude/hooks/skill_reread.py) reads the contract correctly**, and [.claude/settings.json](../.claude/settings.json) parses and registers it without a matcher, which is right for an event whose matchers are sources.

### 3.2 The hook cannot fire for the verification loop

```
LOOPS = {
    ".claude/research-loop-active": ".claude/skills/research-loop/SKILL.md",
    ".claude/verification-loop-active": ".claude/skills/verification-loop/SKILL.md",
}
```

[loop_flag.py](../.claude/hooks/loop_flag.py) defines `FLAG = "research-loop-active"`, `AUDIT_FLAG = "audit-active"` and `VERIFY_FLAG = "verification-active"`. [.gitignore](../.gitignore) ignores `.claude/research-loop-active` and `.claude/verification-active`. **`.claude/verification-loop-active` is written by nothing, ignored by nothing and read by this hook alone.** The verification loop is one of the two loops [research-loop-reread.md](../.claude/rules/research-loop-reread.md) names, and the audit loop's flag is not in the table at all.

**So the hook enforces the rule for one of the three loops in the repository, and is silently inert for the other two.** The cause is visible in the code: it reimplements the session binding instead of importing `loop_flag.armed_for`, which is the single reader written so *"the session-binding and TTL rules cannot drift apart between them"*. Two further consequences of the same duplication: the twelve-hour TTL `armed_for` enforces is not applied here, so an expired flag still writes the marker, and the substring test `session not in armed` is skipped entirely when `session_id` is absent, which contradicts the docstring's *"Inert unless a loop flag names this session"*.

*With two flags naming the same session*, the loop writes for the first match in dict order and returns, so the research loop's skill is demanded and the verification loop's never is.

### 3.3 The branch sits where the commit says, and the marker does not gate a cycle action

The branch is at [loop_stop.py](../.claude/hooks/loop_stop.py) between the `stop-declared` check and `_skill_dirty`, so it is before the branch dispatch and its `_bump(claude_dir, blocks, head, total)` call has all four names bound. **That part of the claim holds.**

What does not hold is *"loop_stop.py refuses to hand back a plan item while that marker exists"* and the file's own *"the reread is owed BEFORE the next cycle action rather than after"*. A Stop hook fires when the model tries to end its turn. Compaction happens mid-turn and the turn continues, so between the compaction and the next Stop the model can take any number of cycle actions with the marker sitting unread on disk. **The only mechanism that acts before the next cycle action is the SessionStart stdout**, which is an instruction in context, which is the mechanism the commit body opens by saying has *"been in context and skipped"*. The Stop branch is a backstop that fires after the actions it was written to precede.

Two earlier exits also stand in front of it. `if blocks >= MAX_BLOCKS or total >= MAX_BLOCKS_HARD: sys.exit(0)` means a session already at the futility cap never sees the demand. `stop-declared` is removed and the hook exits before the marker is read, so a declared stop closes the turn with the reread still owed.

### 3.4 The marker is global, and there is a path that writes it without clearing it

`.claude/skill-reread-owed` carries no session id. A session that compacts and then ends without deleting it leaves it on disk for the next session, which will be told *"This session was compacted"* when it was not, at every Stop until it deletes a marker it did not earn or `MAX_BLOCKS` stands the hook down. Two sessions running loops share the one file, so either can discharge the other's obligation. **Not a hard wedge, because the futility cap bounds it, and a false block up to that cap.**

*The defence.* Failing closed is this repository's stated preference for loop flags, and a spurious demand to read a skill is cheap. That defends the false positive. It does not defend §3.2, where the hook fails open and silently for the loop it names in its own docstring.

## 4. Target D, the scoring rule

### 4.1 The occurrence test is correct, and I could not make it over-split

*"does the rule as written stop this one, and is the repair the same repair?"* is a question about the kind of repair, not the token. Two incidents of one rule repaired in two different files still take the same repair, so a legitimate recurrence survives the test. The failure mode it names is real and is demonstrated on the record by proposal 81 itself: three incidents, one description, one promotion.

### 4.2 The `!` narrowing overrides two disjuncts it was not aimed at

The bullet on disk now reads: *"A `!` marks a **critical** one: it would have falsified a recorded claim, corrupted a bound in the unsafe direction, or let a defect survive an audit that was looking for it. **An audit that CAUGHT the defect it was aimed at earns no `!`**, since the net worked."*

**The three conditions are a disjunction, and only the third is about an audit.** The first is a counterfactual about the incident: had it stood, a recorded claim would have been false. Whether a net later caught it is irrelevant to whether it would have. The appended sentence is unqualified, so as written it strips the mark from incidents that satisfy the first or second disjunct, and it was applied that way: `6c43b437`'s body says *"the mark means a defect that survived an audit looking for it"*, which is the third disjunct standing in for all three.

**The cost is not hypothetical.** Proposal 81's incident is a row in [lean/INDEX.md](../lean/INDEX.md) asserting a dimension no declaration states. That row stood on the record and was false about what the file says, which is the first disjunct exactly. **Read strictly, the narrowing empties the mark**, because every incident in this file is on the record by virtue of some audit having caught it. The defensible narrowing attaches to the third disjunct alone and says so.

*The defence.* The intent is plainly the third disjunct, and a reader of goodwill supplies the qualification. **The author of `6c43b437` was that reader and did not supply it**, which is the evidence that the sentence needs it.

### 4.3 The rule's own first application violates the rule

The new text: *"**Where two incidents need different repairs they are two proposals**, however naturally one sentence covers both."* What `74448b2e` actually did was leave one proposal and write the two split-off failures into its body as prose: *"Two neighbours were first counted here as recurrence and are separate failures with separate fixes."* **No rows 84 or 85 exist**: the table ends at 83. So the two incidents are now recorded inside the entry they were removed from, unscored and unranked, which is the state the rule exists to prevent. The vacuous-declaration incident is additionally waved off as *"already covered by the exhibit-one-object check"*, and no rule of that name exists in any skill. The nearest is [research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md)'s *"A true statement that is trivially true"*, which is about a finding rather than a Lean declaration.

### 4.4 Proposal 57 under the new test: padded, and still at `APPLY`

The bar is 70 ([skill-proposals.md](../.claude/skill-proposals.md) line 604: *"`**APPLY**` at a total of 70 or more, `waits` below it"*). Row 57 is `80 = 10 × 8` at `5!`. Writing the fix beside each incident in its body, as the new rule demands:

| Incident in the body | The fix it takes |
|---|---|
| A missed log-name pattern | Reuse the hook's detector |
| Three blind watchdogs | Reuse the hook's detector |
| The bracket expression `[0-9:._ TZ[]+-]` matching nothing | *"Test a closure detector against a real closed log and a real heartbeat before arming it"*, the body's own words |
| Three agents tripping a fifteen-minute cold threshold while mid-report | *"set the cold threshold from the longest silent phase the work actually has"* |

**Two of the four take a repair the row's own title does not name, and the fourth is not prevented by the title at all**: a watchdog that reuses the hook's closure test perfectly still reports every healthy agent as cold on a threshold set from a round figure. Under the new test that is two further proposals, and the count for the reuse rule is four rather than five. **Proposal 57 is padded in the way proposal 81 was, it is the higher-scoring of the two rows carrying an irreversible action, and `9badd8ad` left it untouched.**

*The defence.* Reuse would in fact have prevented the bracket-expression incident, since a reused detector has no regex to break, so keeping it under this row is arguable. That defends one of the two, not the threshold paragraph, and the body itself prescribes the different repair.

### 4.5 Proposal 75, the other row over the bar, has no body

Row 75 is `81 = 9 × 9` at `2!`, action `APPLY`, and its proposal cell links to `#promoted-2026-09-08`. **There is no such heading.** The phrase *"Nobody writes the shared index until every report is final"* occurs exactly once in the repository, in that row. So there is no text stating the two incidents, no fix beside either, and **the new test cannot be applied to it at all**. `9badd8ad`'s body says *"57 and 75 are the only entries at or over the bar"*, so both were looked at and this was not seen.

### 4.6 Screen of the table

Reported as a screen. Parsing the 69 data rows: the count of 69 is right, every `total = impact × importance` holds exactly, **id 79 is used by two different proposals**, and ten rows carry an impact the stated occurrences-to-impact mapping does not give: 80, 79, 62, 59, 60, 53, 71, 56, 54 and 55. Row 55 is the widest, at six occurrences and impact 5 where the rule says 10.

**Why this matters to the target rather than being tidiness.** The new test changes occurrence counts, and the scoring section says *"Occurrences drive it"*. In ten of sixty-nine rows they do not, so recounting occurrences under the new rule will not move those scores. `9badd8ad`'s *"all 69 rows have consistent arithmetic"* is true of the product and was not a check of the rule the new text depends on.

## 5. What would falsify each verdict, and what I did to look

| Target | What would falsify my verdict | What I did |
|---|---|---|
| **A** | A declaration in L191's import closure stating that `unitSD 0` and `unitSD 1` have common support or full rank, or the record's L191 turning out to have two hypotheses rather than three | Read the whole of [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean) and the `sdForm`/`unitSD` region of [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), traced the import chain L191 to L190 to L187 to L185, quoted L191's statement from row 191 rather than from a commit body, and screened the build |
| **B** | Row 163 of [findings/INDEX-results.md](../findings/INDEX-results.md) reading consistently with `Observation`, or the *"superseded by a proof"* sentence being absent | Read row 163 and the whole L144 block on disk after the fold, checked every `L144` anchor and heading in the tree, and compared against both prior reports' numbered items |
| **C** | A file `.claude/verification-active` being what [skill_reread.py](../.claude/hooks/skill_reread.py) reads, or any writer of `.claude/verification-loop-active` | Grepped the hooks, the skills and [.gitignore](../.gitignore) for all four flag names, read [loop_flag.py](../.claude/hooks/loop_flag.py)'s constants, read `main()` in [loop_stop.py](../.claude/hooks/loop_stop.py) from its first line to the new branch, and confirmed the SessionStart contract against the published hook reference |
| **D** | Rows 84 and 85 existing for the two split-off failures, a body for proposal 75 anywhere in the tree, or proposal 57's threshold paragraph being prevented by its own title | Read the scoring section, all three diffs, proposal 57's body in full, grepped the repository for proposal 75's title and for `exhibit`, and screened the table for arithmetic, duplicate ids and impact against the occurrence mapping |

**The one thing I could not check.** Whether the compaction hook has ever fired: that is a claim about a live session, and the brief's rule and mine keep me to the files.
