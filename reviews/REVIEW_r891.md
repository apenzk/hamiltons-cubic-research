# REVIEW r891: does the promotion gate behave as its three documents assert?

**A fixed-text comparison, not new mathematics.** The brief asked whether [loop_stop.py](../.claude/hooks/loop_stop.py), [editing-skills/SKILL.md](../.claude/skills/editing-skills/SKILL.md) and [skill-proposals.md](../.claude/skill-proposals.md) agree with each other and with what commit [8ab13f95](../.claude/hooks/loop_stop.py) claims. I read all three plus [loop_flag.py](../.claude/hooks/loop_flag.py) and the commit's own diff, ran [_promotable()](../.claude/hooks/loop_stop.py#L158) on the live file and on fifteen constructed copies, and ran [main()](../.claude/hooks/loop_stop.py#L520) end to end in a throwaway git repository under six configurations, including the pre-change hook recovered from `8ab13f95^`. Everything ran in seconds on objects I built for the purpose, inside the analysis-only footing the brief restates. No repository file was modified except this report. Log: [agent_logs/review-r891-hookgate.log](../agent_logs/review-r891-hookgate.log).

## The assertions

| # | Assertion | Verdict | Reason |
|---|---|---|---|
| A1 | A row at 80 or more with no `HOLD` is written into the skill at once, either mode, under a 120-word ceiling | **PARTLY** | the threshold, the veto and the ceiling are stated identically in both documents and the hook stops refusing at that point, but "at once" fails in practice because an uncommitted earned edit still hits the terminal approval-pause block and exits 2, and [SKILL.md](../.claude/skills/editing-skills/SKILL.md#L58) states a second, lower bar forty lines below |
| A2 | `HOLD` vetoes regardless of score | **HOLDS, with a caveat** | verified in both directions on constructed files, though the test is a substring search over the whole line rather than the action column, so it over-vetoes on an innocent "threshold" and misses the prose spelling "held" |
| A3 | The hook permits a locked-mode edit exactly when such a row exists, else refuses with a message naming the threshold | **PARTLY** | the permit-or-refuse switch is exactly the existence of a qualifying row and the refusal names 80 verbatim, but "permits" means only that the revert demand is dropped: the earned turn is still blocked with an approval-pause demand |
| A4 | An earned edit is still subject to the 120-word ceiling, which no locked-mode edit previously reached | **PARTLY** | the second clause is exact, verified against the pre-change file, and the ceiling does fire on the earned path for a tracked edit, but an untracked new file in the skill folder counts as zero added words, so a 402-word addition passes |
| A5 | Exactly one live row qualifies: 103 at 81, three more at 81 held, 105 at 72 below | **HOLDS** | [_promotable()](../.claude/hooks/loop_stop.py#L158) returns 81 on the live file and the qualifying set is `{103}`, with 75, 60 and 53 vetoed and 105 below the bar |
| A6 | The three files agree, and no statement of the old threshold 70 survives | **FAILS** | no literal 70-as-threshold survives, so the narrow claim holds, but the files do not agree: a 50 bar survives in four places, and row 105's own action cell still asserts it is above the bar at 72 |

**One line.** The gate is implemented in the direction its documents claim, is tighter than they admit in one place (an earned edit still stops the turn) and looser in four (the substring veto, the untracked-file hole, the non-critical routes to exactly 80, and a surviving 50 bar).

## The hypotheses the gate rests on

| Hypothesis | Status |
|---|---|
| H1. The total is the second column and bolded | Holds on the live file, all 91 rows matched. A row whose total is unbolded is invisible and returns `None`, which fails closed |
| H2. The only row-shaped lines in the file are the ranked table's | Holds today, all 91 matches between lines 21 and 111. A row-shaped line anywhere else authorises: one appended at the foot returned 95. Fails open |
| H3. `HOLD` appears only as the action marker | Holds today, all seven occurrences sit in the action column. A title containing "threshold" or "placeholder" fails closed, the marker spelled "held" fails open |
| H4. A total of 80 needs a critical occurrence | **Fails.** Impact 10 for five or more occurrences times importance 8 is exactly 80, and impact 8 for three or four occurrences times importance 10 is exactly 80. Both routes are non-critical |
| H5. The filer is not the beneficiary of the score | Fails by construction. The same cycle writes the row, assigns impact and importance, and asserts the `!` mark, and the hook's own refusal message invites it to file |
| H6. The edit corresponds to the qualifying row | Unchecked, and the docstring says so plainly |
| H7. The word count measures this cycle's edit | Fails twice. An untracked file contributes zero words, and another thread's uncommitted skill edits count into this cycle's total |
| H8. The mode comes from the active loop's flag | Holds. [mode()](../.claude/hooks/loop_flag.py#L98) is called with `active_flag`, and a flag with no `mode:` line reads as locked |

## 1. What `_promotable()` actually returns

It walks [skill-proposals.md](../.claude/skill-proposals.md) line by line, keeps every line matching `^\|\s*\d+\s*\|\s*\*\*(\d+)\*\*\s*\|`, drops any whose uppercased text contains `HOLD`, and returns the largest surviving total that is 80 or more, or `None`.

- **Malformed table.** The regex is the whole of the parse, so malformation is silent. A qualifying row whose total loses its bold markers returns `None`. A qualifying row whose id column gains a letter returns `None`. Both fail closed.
- **Missing file.** The `except Exception` returns `None`, which the locked branch reads as "no row earned it" and refuses. A directory in place of the file takes the same path.
- **A total not bracketed as the regex expects.** Same as malformation above, the row is skipped rather than reported, so a filing slip silently removes an authorisation. Nothing in the hook distinguishes "no row qualifies" from "the file could not be parsed", and the refusal message asserts the first: "which no row currently carries".
- **`HOLD` outside the action column.** The docstring says "no `HOLD` in its action column" and the code tests the whole line, so the docstring misdescribes its own implementation. **The wrong answer is reachable in both directions.** Retitling row 103 as "Set the threshold from the longest silent phase the work has" returns `None`, and the word "threshold" is ordinary in this file's subject matter, as is "placeholder" in a path. Pointing row 103 at a `placeholder-practice.md` destination also returns `None`. In the other direction the veto is spelled "held" throughout the file's own prose ("A row reaching the bar through a correction rather than through a new incident is held"), and a row whose action cell reads `**held**` is promoted: my constructed file returned 81.
- **Is any live row at risk?** No. All seven `HOLD` occurrences in the table are the action marker, and no table cell anywhere carries "hold" as an innocent substring, checked over all eight columns of all 91 rows.

## 2. The locked-mode branch, traced

[main()](../.claude/hooks/loop_stop.py#L614) computes `earned = _promotable(cwd)` before it reads the mode, then branches on `mode == "locked" and earned is None`.

- **When a row qualifies**, the condition is false, so control falls through to the word-ceiling check and then to the terminal approval-pause block. It does not exit early. Confirmed by running the hook: locked mode with the live table and a twelve-word edit produced the approval-pause message and exit 2, and with a 200-word edit produced the ceiling message.
- **When nothing qualifies**, the refusal names the threshold by interpolating `PROMOTE_AT`: "the skill folder is read-only unless a proposal has earned the edit: a total of 80 or more with no HOLD, which no row currently carries". Verified verbatim.
- **Learning mode is untouched.** The mode test short-circuits on `mode == "locked"`, so `earned` never affects a learning-mode turn, and the diff changes nothing else in that region. Learning mode with a small edit gives the approval pause and with a large edit gives the ceiling, which is what the pre-change file did. The one new cost is that `_promotable()` reads the proposals file on every learning-mode turn and discards the answer.
- **The gap A1 does not survive.** [SKILL.md](../.claude/skills/editing-skills/SKILL.md#L24) says "A promotion at 80 or more commits itself. The score is the review." The hook's terminal block tells the earned cycle the opposite: it "owes the user an approval pause", must not start the next task, must produce a handoff and end the turn. The two are reconcilable only if the cycle commits the promotion inside the same turn, because the hook sees nothing once the folder is clean. A cycle that writes the rule and reaches its Stop before committing is told to stall, which is the failure the commit message says it set out to fix.

## 3. Runs, against what A2, A3 and A5 predict

| Input | Returned | Predicted |
|---|---|---|
| the live repository | 81 | 81, row 103 (A5) |
| 103 given a `HOLD` | `None` | `None`, the veto beats 81 (A2) |
| every 81 rewritten to 79 | `None` | `None`, nothing at the bar (A3) |
| the same, with 105 raised to exactly 80 | 80 | 80, the bar is inclusive (A3) |
| the same, with 105 raised to 79 | `None` | `None` |
| the table emptied, header kept | `None` | `None` |
| the file absent | `None` | `None` |
| a `HOLD` row raised to 99 above a clean 81 | 81 | 81, the veto removes the row rather than the file |
| 103 retitled with the word "threshold" | `None` | 81 was expected, this is the substring defect |
| the sole 81 marked `**held**` | 81 | `None` was intended, this is the spelling defect |
| a row-shaped line appended at the foot at 95 | 95 | nothing, the ranked table is meant to be the source |

The qualifying set on the live file is `{103}` at 80, and also at 79 and at 81, because the live totals jump from 72 to 81.

## 4. The boundary

The comparison is `total >= PROMOTE_AT` with `PROMOTE_AT = 80`, so 80 qualifies and 79 does not. Verified by construction rather than by reading alone: a file whose highest clean row is 80 returns 80, and the same file with that row at 79 returns `None`. The live table has no row at 73 to 80, so the boundary is exercised by nothing on disk and the inclusive reading matters only for rows yet to be filed. **It matters more than it looks**, because the two non-critical routes to exactly 80 in H4 land on the boundary itself rather than above it.

## 5. A6, the agreement

No statement of 70 as a threshold survives in the three files. The only live 70 is the total of row 55, which carries a `HOLD`. **The agreement claim still fails, because a 50 bar survives in four places and one row still carries the old bar's verdict.**

- [SKILL.md](../.claude/skills/editing-skills/SKILL.md#L58): "**Promote at half the maximum, and let everything below it wait to see whether it recurs.**" The total is out of 100 by [the scoring section](../.claude/skill-proposals.md#L13), so this states the bar as 50, in the same file whose lines 18 and 24 state it as 80.
- [skill-proposals.md](../.claude/skill-proposals.md#L115), the "Ready, promote on approval" head: "**Total 50 or more** ... *These are the only proposals put to the user for approval; everything under **Noted** waits.*" [SKILL.md](../.claude/skills/editing-skills/SKILL.md#L18) says instead that everything below 80 "waits in the file, silently ... the run neither stops nor reports it".
- [skill-proposals.md](../.claude/skill-proposals.md#L117): "*(none, every proposal at 50 or more has landed.)*" Thirty-three rows of the ranked table score 50 or more and 23 of them read `waits`.
- [skill-proposals.md](../.claude/skill-proposals.md#L131): "if the total reaches 50 the proposal moves to **Ready** on its own".
- Row 105 at 72 still carries the action `**ABOVE THE BAR, awaiting the user**`, which was true under 70 and is false under 80. A reader working the table takes the action column at its word, and the hook takes only the number, so the file now says two different things about that row. Row 103's cell says the same phrase and is correct.
- [Step 4 of the filing guard](../.claude/skill-proposals.md#L625) asks the filer to write `**APPLY**` at 80 or more. Neither row above the bar carries that label, so the guard's own example is unmet by the live table.

## 6. A4, the ceiling

**Reached on the earned path, and unreachable before the change.** The pre-change file recovered from `8ab13f95^` exits inside the locked branch unconditionally, so [_skill_diff_words()](../.claude/hooks/loop_stop.py#L125) was dead code for every locked-mode turn. Run with a 200-word locked-mode edit, the pre-change hook gives the read-only refusal and the current hook gives the ceiling message. That half of A4 is exact, read from the code rather than from the commit message.

**The ceiling does not bind the form a promotion most naturally takes.** [_skill_diff_words()](../.claude/hooks/loop_stop.py#L125) runs `git diff HEAD -- .claude/skills/`, which sees tracked changes only, while [_skill_dirty()](../.claude/hooks/loop_stop.py#L97) uses `git status --porcelain` and so sees untracked files. An untracked 402-word file added to the skill folder therefore reports `_skill_dirty() == ['new-practice.md']` and `_skill_diff_words() == 0`, and the earned locked-mode turn walks past the ceiling. A promotion whose destination is a new practice file takes exactly that shape. A second, smaller leak in the same measure: the diff covers the whole folder, so a sibling thread's uncommitted skill edits are counted into this cycle's word total.

## 7. What the gate cannot do

**The docstring admits it in full**: "The hook cannot check that the staged edit is the rule that row describes, and does not pretend to: what it enforces is that some rule has earned promotion and that the edit stays inside the word ceiling." That is an accurate description of the code.

Two statements around it read as more than the code delivers.

- [SKILL.md](../.claude/skills/editing-skills/SKILL.md#L24): "**The score is the review.**" The score is three numbers and a `!` mark assigned by the same cycle that wants the edit, with no second reader and no check that the occurrences are distinct, so the sentence credits a self-assessment as an audit.
- [skill-proposals.md](../.claude/skill-proposals.md#L17): "**Applied automatically at a total of 80 or more.**" Nothing applies anything. The hook stops refusing, and the writing is the model's, so the word "automatically" describes an absence of a block as an action.

The docstring's stated justification also overclaims: "At 80 a row is reachable essentially only with a critical occurrence, whose test is written down and is not the filer's to assert." H4 gives two non-critical arithmetic routes to exactly 80, and the `!` mark that the sentence leans on is itself written by the filer. The written test constrains what the mark ought to mean, not who may type it.

## 8. The counting, recounted from the live table

| Figure | The commit says | Live table |
|---|---|---|
| Rows in the ranked table | 91 | **91**, lines 21 to 111 |
| Importance 8 or 9 | 43 of 91 | **43 of 91**, importance 8 on 19 rows and 9 on 24 |
| Totals cluster at | 27, 54, 72, 81 | those are exactly the products of importance 9 with the four non-critical impact lookups, so the mechanism is right, but as a frequency claim it is wrong: the commonest totals are 18 on 12 rows, then 56 and 12 on 9 each, then 27 on 8 and 63 on 7, while 54 has 3 rows, 72 has 5 and 81 has 4 |
| The widest gap above 50 | 72 to 81 | **correct**, 9 points, against 5 for 49 to 54 and 6 for 64 to 70 |
| 70 would admit five rows tied at 72 | five | **five rows sit at 72**, of which three carry a `HOLD`, so the new veto would admit two of them, and one of those (93) was already applied |
| Rows qualifying at 70 against 80 | not stated | at 70: **10 rows** ignoring the veto, **3** with it (93, 103, 105). At 80: **4 rows** ignoring the veto, **1** with it (103) |

Every row's impact times importance equals its printed total, checked across all 91.

## 9. What would break it

**The input.** A row filed with five or more occurrences and importance 8, or with three or four occurrences and importance 10, reaches exactly 80 with no critical mark at all, and the gate opens. That is the "count of incidents grouped into a row" the change was made to exclude, arriving one impact bracket higher. The grouping is the filing cycle's own judgement, which is the property the threshold was raised to escape.

**The edit.** A cycle in locked mode that wants a skill edit can file the proposal itself, which the hook's own refusal message instructs it to do, score it at 9 by 9, and edit the skill in the same turn. Nothing ties the edit to the row, and if the edit is a new untracked file in the skill folder the word ceiling reads zero.

**A quieter one.** Any line anywhere in [skill-proposals.md](../.claude/skill-proposals.md) shaped like `| digits | **digits** |` authorises. A proposal body that quotes a table row to illustrate a filing rule would arm the gate from inside the prose, and the body sections of that file already quote its own conventions.

**What I did to look.** I enumerated the parse's assumptions and attacked each with a constructed file: unbolded totals, non-numeric ids, an emptied table, a missing file, a directory in place of the file, a stray row at the foot, a higher-scoring held row above a clean one, `HOLD` moved into the title and into the destination path, and the veto spelled as the file's prose spells it. I then ran the hook end to end under six configurations to see which branch each case lands in, and recomputed the reachable products from the impact lookup table to test the docstring's claim about criticality.

## Verdict

**The change does what it says in the direction it says, and three of the six assertions need amending rather than defending.** The threshold, the inclusive boundary, the veto, the live qualifying set and the previously unreachable ceiling all check out exactly as asserted. Against that, five things need amending:

- An earned locked-mode edit still stops the turn with the approval-pause demand that [SKILL.md](../.claude/skills/editing-skills/SKILL.md#L24) says is not owed.
- The `HOLD` test is a whole-line substring where the docstring promises a column, wrong in both directions, harmless on today's table.
- The 120-word ceiling reads zero for an untracked new file in the skill folder.
- A 50 bar survives in four places across the two documents, and row 105 still carries the old bar's verdict in its action cell.
- The stated justification for 80, that only a critical occurrence reaches it, is refuted by two non-critical products that land exactly on the boundary.
