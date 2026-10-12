# Review r816, the cleanup round: the distribution, the mechanical gate, step 7's rule, and the Gate 2 message

**Sole reviewer on this round.** Range `d5cb1137..HEAD`, four targets.

| Target | Commit | Verdict |
|---|---|---|
| A, the distribution | `8541c02a` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** No content lost, and every content line survives verbatim. Two of the commit body's six claims are false as written. |
| B, the mechanical gate | `e4b469ec` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** The ladder is faithful and the cross-file case is handled correctly. The blank-line check misses the incident named in its own docstring, a false positive is available today, and `git commit -a` bypasses the whole gate. |
| C, step 7's rule | `b6d610ef`, `03739837` | **CONFIRMED**, with one gap. The rule is self-consistent and the contradiction `03739837` names was real. Its central instruction names no method, and Target A is the exhibit of what that costs. |
| D, the Gate 2 message | `ad9a29cd` | **REFUTED** on its central claim. The message says the count is step 2's judgement, but [step 2 on disk](../.claude/skills/research-loop/SKILL.md) says *"Spawn **two** agents on the same brief"* and states no other case. |

---

## Target A: the distribution, `8541c02a`

### What is fully confirmed: nothing was lost

I reconstructed the deleted file with `git show 8541c02a^:findings/plan-notes.md` and split it on its `##` headings. It carries **seventeen** blocks, not sixteen: the sixteen that went to findings files plus `I39`, which returned to its plan item. I then normalised the two link rewrites the commit performed and tested every non-empty content line of every block for verbatim presence in the working tree.

**All seventeen blocks are present in full, and every one of the fifty-seven content lines matches character for character after the link rewrite.** Nothing was paraphrased, nothing was trimmed, and no block was dropped. This is the thing that mattered on this commit and it is completely achieved.

Two further checks pass. The prefix rewrites `](findings/` and `](lean/` were applied exhaustively, with no instance of either surviving in a moved section. And no file anywhere in the repository still references `plan-notes.md`, so the deletion left no dangling pointer.

### Overclaim 1: the links were not rewritten for their new depth

The commit body states, verbatim:

> relative links are rewritten for their new depth, and all sixteen plan items now point at the file and the anchor rather than at a holding pen

Two prefix families were rewritten. Seven were not. Resolving every relative link inside the seven `## Working notes carried by the plan` sections against the filesystem gives **thirteen distinct broken targets, seventeen instances**:

| File | Link | Resolves to |
|---|---|---|
| [bounds-relaxations.md](../findings/bounds-relaxations.md) | `[Payne](references/payne-2010-soliton-metrics/notes.md)` | `findings/references/…` |
| [bounds-relaxations.md](../findings/bounds-relaxations.md) | `[Lauret–Will](references/lauret-will-2006-einstein-solvmanifolds-moment-map/notes.md)` | `findings/references/…` |
| [target.md](../findings/target.md) | `[SKILL.md](.claude/skills/research-loop/SKILL.md)` | `findings/.claude/…` |
| [problem.md](../findings/problem.md) | `[audit-results](.claude/skills/audit-results/SKILL.md)` | `findings/.claude/…` |
| [problem.md](../findings/problem.md) | `[results.md](results.md)` | `findings/results.md` |
| [route-a.md](../findings/route-a.md) | `[Problem P](README.md)` | `findings/README.md` |
| [second-order.md](../findings/second-order.md) | `[BW08 eq. (6)](references/boehm-wilking-2008-space-forms/notes.md)` | `findings/references/…` |
| [second-order.md](../findings/second-order.md) | `[ATTEMPTS.md](ATTEMPTS.md)` | `findings/ATTEMPTS.md` |
| [second-order.md](../findings/second-order.md) | `[ROUND_L145](verification/ROUND_L145.md)` | `findings/verification/…` |
| [second-order.md](../findings/second-order.md) | `[R11](routes.md)` | `findings/routes.md` |
| [second-order.md](../findings/second-order.md) | `[README.md](README.md)` | `findings/README.md` |
| [ungraded-slack.md](../findings/ungraded-slack.md) | `[SKILL.md](.claude/skills/research-loop/SKILL.md)` | `findings/.claude/…` |
| [ungraded-slack.md](../findings/ungraded-slack.md) | `[R12](routes.md)` | `findings/routes.md` |

**Every one of these was a working link in [plan.md](../plan.md) before `14997758`**, which is inside the range under review. I confirmed this for `[R11](routes.md)`: `git show 14997758^:plan.md` carries it, and from the repository root it resolves. So the damage was introduced by `14997758` and `8541c02a` is the commit that undertook to repair it and repaired two ninths of it.

### Overclaim 2: the anchors are the section's, not the item's

The sixteen plan items point at seven anchors, all of the form `#working-notes-carried-by-the-plan`. **Nine of the sixteen point at the same anchor**, `findings/second-order.md#working-notes-carried-by-the-plan`, which sits above nine different blocks. The anchors exist and resolve. What they do not do is identify the item's notes.

This is a strict loss of precision against what was replaced. The old links were `#i1`, `#i2`, `#i4` and so on, sixteen distinct per-item anchors. And the per-item anchors exist in the new files: every block carries a heading `### From [I<n>](../plan.md)`, whose GitHub slug is `from-i<n>`.

It also contradicts the rule the pass was run under. Step 7's own `#### Referencing` subsection reads:

> **Link to the block, not to the file.** *A bare file link makes the reader search a long document for the paragraph the item meant; an anchored link lands them on it.*

An anchor above nine blocks makes the reader search a long section for the paragraph the item meant, which is the failure the rule names, one level down.

### A structural defect the pass introduced

In the deleted file, `I7`'s block was:

```
## I7

**Order of work:** I2 first, …

### The verification audit's owed items, filed 2026-09-07

*Nine debts named by rounds L35 through L47 …*
```

The audit paragraph was a level-3 subheading **inside** the level-2 `I7` block, so it belonged to `I7`. In [second-order.md:1674](../findings/second-order.md) the block's own heading became level 3, `### From [I7](../plan.md)`, while the audit heading stayed at level 3. **The two are now siblings, so the audit paragraph is attributed to no plan item at all**, and an item pointing at `I7`'s notes reaches a section that ends before that paragraph. The content survives, which is why this is not a loss; the ownership does not.

### The owner heuristic

Stated in the commit body as: *"each block's owner is read from the lemmas it cites"*. I counted, for each block, which findings file defines the most of the numbered results it names.

**The heuristic agrees with the destination on thirteen blocks and is undefined on four.** `I39`, `I40`, `I32` and `I8` cite no numbered result whatever, so nothing was counted and the owner was chosen by some other means the commit body does not state.

**`I34` is a block in a file that does not own its subject.** Its content is the audit's ordering rule, a done-list of eleven audited leaves, and a note that [results.md](../results.md) is rebuilt at the end. That is task state. It landed in [problem.md](../findings/problem.md) because its done-list happens to name three results that live there, which is a coincidence of the list rather than a fact about the subject. By the author's own reasoning for `I39` (*"ranking rationale rather than mathematics, so it returns to its own plan item, which is where task state belongs"*), `I34` should have gone back to its item. `I7` is the same shape in its first sentence (*"Order of work: I2 first … I3 follows it … Fallback, unchanged"*), though its second clause carries a genuine mathematical fact about the chain, so `I7` is mixed rather than misplaced.

### The uniqueness verdict, argued against

The commit says *"every block was searched against its **destination** first, per the rule's two cases. All sixteen were unique."* The rule says search **the record**, which is a larger set: a block duplicating a passage in a third file would be counted unique by the search actually performed. I attacked the block most likely to be duplicated, `I34`'s done-list, and found the string in one other place only, [REVIEW_r462.md](REVIEW_r462.md), which is a review record rather than a copy of the note. **So the verdict survives my check while the method used cannot establish it.**

### Falsification and verdict, A

**What would falsify A**: a block, or any line of one, absent from the working tree; a rewritten link that resolves to the wrong file rather than to none; a plan anchor that does not exist. I reconstructed the file from `8541c02a^`, tested all fifty-seven content lines against the whole record, resolved every link in all seven destination sections against the filesystem, and checked all sixteen plan anchors against the headings on disk. None of the three falsifiers is present.

**CONFIRMED AS TYPED, PROSE OVERCLAIMS.** The work is sound and the risk it carried was fully retired. Two of the commit body's six bullets are false as written.

---

## Target B: the mechanical gate, `e4b469ec`

### Does it check only what the diff adds?

Three of five checks are strictly adds-only: [check_anchors](../.claude/hooks/mechanical_check.py), [check_proposal_scores](../.claude/hooks/mechanical_check.py) and [check_flag_names](../.claude/hooks/mechanical_check.py) all operate on the joined added lines. Two are not, and one of them fails in the direction that matters.

**The blank-line check misses the incident its own docstring names.** The gate's header cites *"a blank line that ended a markdown table and dropped 43 rows out of it"*. The check is:

```python
if (not lines[i].strip() and lines[i - 1].startswith("| ")
        and lines[i + 1].startswith("| ") and lines[i + 1] in added):
```

The guard is on the row **below** the blank line. A commit that inserts a blank line into an existing table adds the blank line and nothing else, so `lines[i+1]` is inherited and the condition is false. Screened on a constructed four-row table: with `added={""}` the check returns nothing; adding the row below as well produces the diagnostic. **The gate catches the defect only when the committer also happens to have edited the next row.**

[check_duplicate_ids](../.claude/hooks/mechanical_check.py) counts over the whole file and fires when the duplicated id appears in an added line, so editing an existing row that is already a duplicate is blocked for inherited damage. That is narrow and arguably intended, and I record it as designed rather than as a defect.

### Can it fire on a commit that introduces nothing?

**Yes, and the false positive lands on Target A.** `slug()` strips every non-word character from the heading text, including the markdown link syntax and the URL. Screened:

```
slug('From [I2](../plan.md)')  ->  'from-i2planmd'
GitHub's slugger              ->  'from-i2'
```

GitHub slugs a heading from its rendered text, which for a link is the link text alone. So for any heading containing a link, the gate's model of the anchor and the renderer's disagree. **The correct repair for Target A's anchor imprecision, a plan item whose link target is the bare fragment `#from-i2`, would be rejected by this gate as a link to a heading no file carries.** The gate would block the fix for the defect above it.

**And this is not hypothetical: filing this report hit it.** The gate refused the commit twice over, once for the fragment above and once for the one in the screen below, both of which sit inside code spans in this file. So there is a third defect in the same check: **it reads the raw text and honours neither inline code spans nor fenced blocks**, which makes quoting a link in a report sufficient to be blocked. I removed the two link-shaped quotations to get this committed, which is the exact behaviour the gate's own docstring warns against, a gate teaching the committer to work around it.

Two further over-triggers. `main` returns early unless `"git commit"` appears anywhere in the Bash command string, so any command that merely mentions the phrase is gated, which is how the author's own test payload fired it. And [structure_gate.py](../.claude/hooks/structure_gate.py) uses the identical test, so both gates share it.

### Does the anchor check handle a link into another file?

**Yes, correctly.** The regex is `\]\(#([a-z0-9\-]+)\)`, which requires the `#` immediately after `](`. Screened on a string carrying one cross-file link to `other.md#foo` and one same-file link to the bare fragment `#bar`: only `bar` matches. This attack fails.

The corollary is the interesting part. Because the check is same-file only, **cross-file anchors and cross-file paths are unchecked entirely**, which is exactly the class Target A left broken thirteen times, and exactly the class `14997758`'s own commit body says the gate caught (*"the relocated notes carried anchors into plan.md's headings"*). It caught the anchors those links carried, not the paths.

### Is the ladder the one skill-proposals.md states?

**Yes, clause for clause.** [skill-proposals.md:11](../.claude/skill-proposals.md) reads: *"5+ scores 10, 3–4 scores 8, twice scores 6, once scores 3. A critical single occurrence overrides that and scores 7, and a critical recurrence scores 9–10."* The hook's `ladder(occ, crit)` returns exactly that in both branches. The regex matches 69 of the table's 70 rows, the seventieth being the header, and I re-derived every row: all 69 products are exact and every impact sits in its allowed band, so the table is currently consistent under the gate.

One degenerate case. At `occ == 0` the non-critical branch returns 3, which the prose does not cover, and the critical branch returns 9 or 10, which is wrong for a zero-occurrence row. No row exercises either.

### A complete bypass

`staged()` reads `git diff --cached --name-only`. **`git commit -am "…"` stages at commit time, so at the PreToolUse hook the cached diff is empty, the loop over `staged(cwd)` never executes, and the gate returns 0 having checked nothing.** The same holds for `git commit --amend` with nothing staged. The project's conventions discourage `-a`, which reduces the exposure without closing it.

### One more, on the gate beside it, and both defects observed live

[structure_gate.py](../.claude/hooks/structure_gate.py) exempts a commit that stages only `reviews/REVIEW_r*.md`, so a reviewer can file its own unindexed report. **That exemption is defeated by staging and committing in one shell command**, which is the natural form and the one this round's brief invites. Both gates are `PreToolUse` hooks on Bash, so they read the cached diff before the staging half of the same command has run: the staged set is empty, `if paths and all(…)` is false, the exemption never fires, and the full structure check runs and refuses. Staging in a separate call makes it pass.

**And the substring trigger recorded above then fired on the edit that documented it.** Writing this paragraph through a shell heredoc put the literal phrase into the command string, `"git commit" not in command` was false, and the gate ran the whole structure check against a call that stages nothing and commits nothing. Both defects are therefore observed rather than inferred, and I record them because neither is visible from the message the gate prints.

### Inherited damage, measured

Screening the seven destination files plus [plan.md](../plan.md) and [skill-proposals.md](../.claude/skill-proposals.md) as though every line were added surfaces **fourteen same-file anchors that are dangling today**. I checked two by hand and both are genuine rather than slug artefacts: links write `lemma-l120--lm-is-block-diagonal-…` and `lemma-l145--…-rnomegan-32-…` where the headings carry `$L_M$` and `$r_n$`, so the underscore belongs in the slug and the links dropped it. The gate is right not to block on these today, and any session that edits one of those lines is blocked for damage it inherited. That is the correct trade at line granularity and worth knowing.

### Falsification and verdict, B

**What would falsify B**: a check that reports inherited damage on an untouched line; a ladder branch disagreeing with the prose; a cross-file link flagged as a dangling anchor. I read all 159 lines, screened `slug`, the anchor regex and `check_table_breaks` on inputs I constructed for the purpose, re-derived the whole 69-row table against the prose ladder, and screened the eight largest markdown files for anchors the gate would flag.

**CONFIRMED AS TYPED, PROSE OVERCLAIMS.** The five checks are real and the ladder is faithful. The docstring's claim that these defects *"move here"* is not yet true of the blank line, the adds-only promise has a false positive that lands on this very round's other target, and the gate is one flag away from silence.

---

## Target C: step 7's rule, `b6d610ef` and `03739837`

### Is the rule self-consistent?

**Yes.** The apparent conflict dissolves on reading both from disk. Question 3 says *"Replace it with a link."* Case 1 says *"The record already holds it, DELETE the copy **and link to the block**."* Replacing a passage with a link is deleting the passage and inserting a link, so the two describe one act in two registers. Case 2 governs the disjoint situation, a passage the record does not hold, and instructs the opposite.

The contradiction `03739837` claims to have removed was real: the prior text said `delete nothing here` while question 3 required a deletion. Removing it was correct.

### Does the step describe an act a reader can perform?

**Not as written, and this is the gap.** The rule's load-bearing sentence is:

> **Search the record for the passage before touching it. The answer decides which of two things you do, and they are opposites.**

Followed by: *"The check is one search and it is not optional."*

The step names a method exactly once, at question 1: *"Open [findings/INDEX.md](../findings/INDEX.md) and the file it names."* That method finds the file that owns the subject, which is the destination. The two-cases rule needs a different search, across the record, and it names no method, no scope, and no criterion for what counts as a match: verbatim string, restated fact, or same conclusion by another route.

**Target A is the exhibit.** Its commit body reports *"every block was searched against its destination first, per the rule's two cases"*. That is question 1's scope reported as the two-cases search, which is the substitution the missing method invites. The reader executed the one method the step supplies and believed it had discharged the rule that needs the other.

A second instruction has the same shape. *"Name the file that owns the subject before moving anything into it"* gives no procedure. The heuristic actually used, counting cited lemma definitions per file, appears nowhere in the skill and is undefined on four of the seventeen blocks it was applied to.

### Against [editing-skills](../.claude/skills/editing-skills/SKILL.md)

The bar is [SKILL.md:64](../.claude/skills/editing-skills/SKILL.md): *"No dates, no run or round references, no 'this cycle', no counts of what happened when."*

**Step 7's own text clears it.** No date, no reviewer id, no round reference, no count of what happened when. Each rule states a failure shape: an item accreting over many cycles can hold the only copy of a derivation; a holding file fills up and becomes the second copy of the record in a new place; a proxy is what a reader games without noticing. The `60 kB` backstop is a specification of step 4's check rather than an incident.

**Three residues survive elsewhere in the same file, and they are inherited rather than introduced.** All three sit in step 2:

- [SKILL.md:355](../.claude/skills/research-loop/SKILL.md): *"Three reviewers were lost this way in one session, one of them three hours in and holding an independent confirmation."* A count and a duration.
- [SKILL.md:363](../.claude/skills/research-loop/SKILL.md): *"which happened to nine reviewers at once, including rounds that overturned more than twenty recorded claims."* A count of what happened when.
- [SKILL.md:371](../.claude/skills/research-loop/SKILL.md): *"Six consecutive Gate 2 rounds were once folded in verbatim."* The same.

`145d67c2` scoped itself to *"the rules I added"*, so in fairness these predate the pass and were not in its declared scope. Its own stated ground is universal, though: *"every skill here is written to be lifted into another project"*, and a reader arriving with a different problem gets nothing from any of the three.

### Falsification and verdict, C

**What would falsify C**: two clauses of the step giving contradictory instructions on one passage; an instruction whose method the skill supplies elsewhere and I missed; incident residue inside step 7 itself. I read step 7 in full from disk, traced each of its three questions against the two cases, read the pre-state of both commits, and grepped the whole skill for dates, `rNNN` citations, round references and counts.

**CONFIRMED**, with the method gap recorded. Both commits fixed what they said they fixed. The rule they produced is correct and not yet executable, and the first attempt to execute it went wrong in exactly the place the method is missing.

---

## Target D: the Gate 2 message, `ad9a29cd`

### Does the message agree with what step 2 says?

**No.** The message hands the judgement to step 2, in capitals:

> per step 2 of the skill, and wait for all of them. THE COUNT IS STEP 2'S JUDGEMENT AND NOT THIS HOOK'S

Step 2 on disk, at [SKILL.md:335](../.claude/skills/research-loop/SKILL.md), opens:

> Spawn **two** agents on the same brief, each to **break** the result.

I read all of step 2, lines 331 to 393, and **it states no other count and mentions no one-reviewer case anywhere.** The one-or-two rule is not in step 2. It is in a different section 280 lines earlier, `## The agent budget`, at lines 51 to 58, under a heading that still reads **"The agent budget: two, both at step 2"**.

So the commit is right that a hook asserting a fixed count had drifted from the rule, and it moved the drift rather than removing it: **the hook now points at the one section of the skill that unconditionally contradicts it**, and the skill's own heading still asserts the count the commit says the skill no longer sets. A reader who follows the hook's pointer arrives at "spawn two".

Against the rule itself, at lines 55 to 58, the paraphrase is faithful with one omission. The skill lists four exemplars of the one-reviewer case: *"A Lean file against the result it claims, an index row against the declarations it names, a fold against the findings it answers, **a hook against the behaviour it asserts**."* The hook's message carries the first three and drops the fourth. **That is the exemplar covering the commits this hook has actually been firing on, and it covers Targets B and D of this very round.**

### Is the case split usable mid-round?

**Not at the hook's own granularity.** The hook's unit of work is *"N feat/fix commits since the last reviewer file"*, which is a batch assembled by a counter and can hold both kinds at once. The rule's split is defined per subject. The message states no tie-break for a mixed batch, so a reader holding one has no rule to apply.

Arguing the opposite, as I must: **it worked on this round.** All four targets are text compared against something already fixed, the batch was homogeneous, and one reviewer was the right call. The split is usable when the batch happens to be of one kind and undefined otherwise, which is a real limitation and not a fatal one.

### Do other messages still carry a dated reference?

**No, and the commit's claim on this point is fully confirmed.** I extracted every `print(…, file=sys.stderr)` literal from [loop_stop.py](../.claude/hooks/loop_stop.py) and matched each for dates, `rNNN` citations, session references and counts. No message carries a date. Two dates remain in the file, at lines 162 and 366, and both are code comments explaining why a pathspec and a regex are shaped as they are, which is documentation of the code rather than justification of a rule.

One residue survives, in the message this commit wrote: *"**A round has been consumed** by defects a script decides."* Perfect tense, an undated historical assertion. The skill's parallel sentence, rewritten by `145d67c2`, is modal: *"each is the kind of defect a round can be wholly consumed by."* The commit body says *"the reason is now the failure itself"*, and it is one tense short of that.

### Falsification and verdict, D

**What would falsify D**: step 2 on disk carrying the one-or-two rule, which would make the pointer accurate; a dated reference surviving in another printed message; the paraphrase reproducing the skill's list in full. I read step 2 end to end, read `## The agent budget` end to end, diffed the message's exemplar list against the skill's clause by clause, and matched every stderr message in the file against a pattern for dates, reviewer ids and historical counts.

**REFUTED** on its central claim. The message no longer asserts a count, which was the defect it set out to fix, and it delegates to a section that asserts one. The dated-reference claim is confirmed.

---

## On the counting design, as opinion

**First, a correction to the premise.** [loop_stop.py:181](../.claude/hooks/loop_stop.py) counts only subjects beginning `feat(` or `fix(`, and its docstring is explicit: *"Housekeeping commits -- docs, chore, refactor, test -- do not count."* Across the range under review that is 3 `feat` and 1 `fix` against 5 `docs` and 2 `refactor`. **Record repair does not accumulate Gate 2 debt: Target A's own commit is `refactor(findings)` and contributed nothing to the count.** The four that fired the gate are `feat(skills)`, `feat(hooks)`, `feat(hooks)` and `fix(hooks)`, every one of them inside `.claude/`.

So the true statement is narrower and sharper than the one I was handed. **The hook reads the type prefix and ignores the scope**, so `feat(hooks)` owes a reviewer round on the same terms as `feat(findings)`. And the self-reinforcing case is real: `ad9a29cd`, which repaired this hook's message, is a `fix(` and incremented the counter that message drives.

**My opinion, and I mark it as opinion.** A reviewer round exists to put an independent reader between a claim and the record, before anything downstream cites it as settled. The quantity that should drive the counter is therefore claims, not commits. A commit that changes no findings block, no row in [results.md](../results.md) and no Lean statement adds nothing a reader could confirm or refute, so it should not tick a counter whose whole purpose is to stop unreviewed mathematics reaching the record.

The filter I would use is the path rather than the type prefix: count a commit when it touches [findings/](../findings/), [results.md](../results.md), [lean/](../lean/) or [verification/](../verification/), and not otherwise. That keeps every `feat(findings)` in and drops every `feat(hooks)`, which is the split the counter is actually reaching for.

Hooks and skills do deserve review, and this round is the argument for it: three of four targets carry a real defect, and one of them, `slug()` disagreeing with the renderer, is a gate that would reject a correct repair. **But that is a different round with a different question**, namely whether this hook does what its message says, and it should have its own trigger rather than borrowing the mathematics counter. Sharing one counter between the two means a housekeeping stretch manufactures debt that a mathematics reviewer is then briefed to discharge, and each repair the gate prompts adds to its own count. That is the shape of the last four commits.

---

## Was a second reviewer worth it here?

**No, and the round is evidence for the rule rather than against it.** Every finding above is a comparison against something already on disk: a file reconstructed from git against the working tree, a hook's ladder against the prose that defines it, a message against the section it cites. Each is settled by reading two texts, and a second reader would have read the same two and written the same verdicts in different words.

The one place a second reader would genuinely have helped is the opinion section, which is a judgement rather than a comparison, and that was not the round's question.

*One caution I would rather state than leave implicit.* The heaviest checks here ran through short scripts over text I constructed for the purpose, all of them screens in the sense the standing rule allows. A second reviewer would most plausibly have earned its keep by re-deriving the thirteen broken links and the fifty-seven-line completeness check independently, since those two carry the round's positive claims and both rest on one implementation. I have stated the method for each precisely enough that either can be repeated in a few minutes.
