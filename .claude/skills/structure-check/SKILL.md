---
name: structure-check
description: Check that the record's folders comply with their defined structure, every lemma and theorem numbered, every number indexed, every folder's contents indexed, and every reference in the required format. One straight line of checks, ending in a pass/fail report. Use when the user says "structure check", "check the structure", "does the record comply", "audit the folders", or invokes /structure-check.
---

# Structure check

**One straight line of four checks over the record's folders, ending in a report.** It reads; it does not repair. A failing check names the file, the line and what the spec requires, so the fix is somebody's decision rather than this skill's side-effect.

Run it after a cycle that added results, after a sort or a merge, and before anything is sent out.

## The structure, defined

This section is the spec. **A check fails against what is written here**, so a deliberate change to the record's shape is made here first.

### findings/

| path | required |
|---|---|
| [INDEX.md](../../../findings/INDEX.md) | which file holds which subject, and pointers to the three lookups |
| [INDEX-results.md](../../../findings/INDEX-results.md) | one row per numbered result: number, kind, short name, file. Ends with the count and the next free number |
| [INDEX-values.md](../../../findings/INDEX-values.md) | every catalogued $\theta$ by value |
| [INDEX-traps.md](../../../findings/INDEX-traps.md) | the warnings `W1`…, the fence posts, and the standing-rule index |
| [conventions.md](../../../findings/conventions.md) | every definition and normalisation, stated once |
| one file per subject | the mathematics |

**Every numbered result is a heading**, exactly `#### Lemma L<N>, <short name>`, or `#### Observation L<N>,`, or `#### Conjecture L<N>,`. **Every fence post is** `## Post F<N>, <what cannot work>`. An id appears as a heading **exactly once** across [findings/](../../../findings/); ids are permanent addresses and are never reused.

**The prefixes are the point.** A bare number collides with everything else in this record (dimensions, multiplicities, block counts, the value of $n$) so `Lemma L34` and `Post F34` are each findable by one grep where *"34"* was not. The convention is the one [reviews/](../../../reviews/) already uses for reviewers, `r257`, and for the same reason.

**`L` means result, not lemma.** Lemma, Observation and Conjecture share a single counter, so they share a single prefix; giving each kind its own letter would imply three counters and break the guarantee that an id names exactly one result. Warnings are `W<N>` and standing rules are `R<N>`, each with its own counter.

**A foreign result keeps its own numbering and takes no prefix**, *Fox's Lemma 1*, *Nienhaus Lemma 2.13*. The check must not flag these, and a migration must not rename them.

**The labels are literal.** `Lemma` asserts Gate 1 and Gate 2 passed. `Observation` asserts numerical verification at the dimensions stated. `Conjecture` asserts neither. A result with no Gate 2 verdict is still a `Lemma` if proved, and it belongs on the Gate 2 debt ledger in [LEDGER.md](../../../findings/LEDGER.md).

### references/

One folder per source, slug-named, each holding **all four**:

```
references/<slug>/
  README.md     the index card, what it is, what it was consulted for, link,
                authors, arXiv id and version, date retrieved, and the verdict
  notes.md      the extraction transcribed, numbered statements verbatim in LaTeX
                with full hypotheses, the proofs that matter, what they cite
  <paper>.pdf   the source as retrieved
  <paper>.txt   pdftotext -layout output, for grepping
```

**Every folder appears in [references/INDEX.md](../../../references/INDEX.md), and every row there names a folder that exists.**

**A source that could not be obtained is compliant without a PDF** when its `README.md` carries a `Not obtained` section naming what was tried. That is a correct state; a folder holding a substitute paper or a summary standing in for one is not.

### reviews/ and verification/

| path | required |
|---|---|
| `reviews/REVIEW_r<N>.md` | one per research-loop reviewer, each with a row **and** a section in [reviews/INDEX.md](../../../reviews/INDEX.md) |
| `verification/VERIFY_v<N>.md` | one per verifier, listed in its round file |
| `verification/ROUND_<id>.md` | one per verification round |

**The two populations never share a namespace**: reviewers are `r<N>`, verifiers are `v<N>`.

### scripts/

Reusable machinery indexed in `scripts/INDEX.md`; one-off reviewer scripts in `scripts/INDEX-reviewers.md`.

## The checks, in order

Run all four, then report. **A check that errors is a failure, not a skip.**

### Run the checker

```
python3 .claude/skills/structure-check/check.py          # human-readable
python3 .claude/skills/structure-check/check.py --json   # for a caller that will act on it
```

**The four checks are set comparisons, so they live in [check.py](check.py) rather than in a reading of the tree.** A compliance check that gives two different answers on two runs is not a check, and a model reading the tree misses what a set difference cannot: *a heading with no index row, and an index row whose result has no heading.*

It exits `0` when every check is clean and `1` otherwise, so it can gate a commit or a send.

### What each check does

| | catches |
|---|---|
| **A** | a result-shaped heading with no id, excluding foreign results |
| **B** | an id with no index row, an index row with no id, **an id used twice**, and the same both ways for fence posts, *posts are collected into a list rather than a set, since a set makes a duplicate id invisible by construction* |
| **C** | a file present but unindexed, or indexed but absent, in [references/](../../../references/) and [reviews/](../../../reviews/) |
| **D** | a `references/<slug>/` missing its `README.md`, `notes.md`, PDF or `.txt` |
| **E** | an index row whose **Gate 2 verdict disagrees with [LEDGER.md](../../../findings/LEDGER.md)** |
| **F** | a **Lemma whose block cites an Observation**, reported, since citing is not depending on |
| **G** | an **id asserted outside a `####` heading**, which phase B cannot see |

**The excusals are in the script, not in the reader's judgement.** A source with `Not obtained` in its `README.md` passes without a PDF, and without a `.txt`, since there is nothing to extract from. **A ledger row that landed on a version it then refuted leaves the repair unaudited, so an index row calling it owed agrees rather than contradicts.**

**A result inherits the status of its weakest input**, so a Lemma resting on an Observation is an Observation at the dimensions that Observation names. *F cannot tell resting from mentioning, so it prints the pairs and each is a reading.*

**E counts the numbered rows that state no verdict and prints the count without failing on it.** *A claim nobody remembers is unreviewed gets treated as reviewed, and the count is what keeps that visible.*

**Keep [check.py](check.py) and the spec above in step.** They are two halves of one statement, and the spec is the half that governs: if they disagree, the script is wrong.

## The report

**One table, then a single verdict line.** The table is the work list: each row is one thing that needs changing, carrying the file or folder, the line where relevant, what the spec requires, and **the fix that would satisfy it**. A reader must be able to approve or reject a row without opening this file or the record.

**Then stop and ask whether the table is right.** Phase B does not begin until the user has seen it and said so.

*The reason is that a check reports what the spec says, and the spec can be wrong about a particular case.* A row can name a heading that is a duplicate of its own canonical block, or flag a compliant folder whose source genuinely cannot be obtained. **Each would be "fixed" into a worse state.** The table is cheap to read and the fixes are not cheap to undo, so the pause pays for itself the first time a row is wrong.

Close with the counts: `A n/n · B n/n · C n/n · D n/n`, and `PASS` only when all four are clean.

**Report a failure even when it is the skill's own doing**, a spec this file states and the record does not meet is a finding about one of the two, and which one is the user's call.

## After the report, propose what would improve this skill

**Every run ends by asking what would have caught its findings sooner, or spared it a false one.** A check that fires is evidence about the record; a check that fires *wrongly*, or fails to fire at all, is evidence about this file, and that evidence is only available while the run is fresh.

Look at three things, in this order:

1. **A rule that produced a wrong count.** *A check demanding one form of indexing while the index legitimately uses another reports most of the corpus as broken.* A check whose failures need a human to discount them is worse than no check, because the discounting stops happening.
2. **A failure the spec does not describe.** If something is plainly wrong with the record and no check names it, the spec has a hole.
3. **A check that has never fired.** Either the record is clean in that respect, or the check does not work. Say which you believe and why.

### How a proposal is written

**One blockquote, carrying the text as it will read, with every new word in CAPITALS and every kept word left as it stands.**

> **What it fixes**, one line.
>
> **In `<section>`:**
>
> > the text as it will read after the change, WITH THE NEW WORDS IN CAPITALS and the kept words unchanged

**One block, not two.** Quoting the old text and then the new doubles the reading and hides small edits inside two near-identical paragraphs. A single line shows the result and the change at once: read it straight through for what the file will say, and read the capitals alone for what moves.

**Capitals mark the edit, not emphasis.** A proposal that rewrites more than it claims is visible immediately, because the capitals spread.

**A deletion has nothing to capitalise**, so quote the sentence that survives on either side and name what goes between them.

**Propose; do not apply.** The spec is what the record is checked against, so changing it changes every future verdict, that is the user's call, and a skill that edits its own spec after a failing run can define its failures away.

## Phase B, fix what the report found

**Phase B starts only after the user has approved the table.** No row is worked before that, and a row the user rejects or amends is dropped or reworded in the table before anything is touched. Then the approved rows are worked in this order, because a fix late in the list can be invalidated by one earlier.

| order | failure | the fix |
|---|---|---|
| 1 | **a number on two headings** | decide which block is canonical (the one with the proof) and turn the other into a pointer to it. **Never renumber**: a number is a permanent address and something already cites it |
| 2 | **an index row with no heading** | find the result; if it exists under another heading, restore the number there. If it does not exist at all, the row goes, and the deletion is recorded |
| 3 | **an unnumbered result** | allocate the next free number centrally, place the heading, add the index row, and put it on the Gate 2 debt ledger unless it carries a verdict |
| 4 | **an unindexed file** | add its row to the folder's index |
| 5 | **a reference missing `notes.md`, `README.md` or `.txt`** | generate from the PDF it already holds |
| 6 | **a reference missing its PDF** | fetch it, or write the `Not obtained` section naming what was tried |

### What phase B fixes, and what it hands on

**It fixes structure: numbers, headings, index rows, folder contents.** These have one right answer, and the check that found the gap also defines it.

**It hands on anything that needs a judgement about the mathematics**, with the finding stated:

- **a wrong or contradictory statement**, the verification loop's, not this skill's
- **a result whose label may be wrong**, whether a `Lemma` deserves the label is Gate 2's question
- **a decision about which of two divergent copies is right**, the check reports both; choosing is a round's work

**A fix that would require reading the mathematics to decide is not a structural fix.** Stop, report it, and say which loop owns it.

### The rules the fixing obeys

- **Allocate numbers centrally before placing any heading**, in one edit to [INDEX-results.md](../../../findings/INDEX-results.md). *Parallel agents allocating from a shared counter overwrite each other's files.*
- **A fix adds or replaces; it does not annotate.** The file must read as though the gap had never been there.
- **Re-run the checks after fixing** and report the second table beside the first. A fix that does not move a count did not work.
- **Commit each fix as it completes, not at the end.** This repository is written by several sessions at once, and an unstaged file is swept into whoever commits next, landing inside another thread's commit under a message describing something else. **A half-done fix committed honestly beats a complete one that arrives in someone else's history.**

## What this skill does not do

**It does not judge mathematics.** Whether a `Lemma` deserves the label is Gate 2's question. This skill checks that the label is present, unique, and indexed.

## Editing this file

**An edit here follows [editing-skills](../editing-skills/SKILL.md)**, when it is allowed, where the lesson goes, and the verbatim report it owes.
