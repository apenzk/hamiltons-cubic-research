---
name: editing-skills
description: How a skill in this repository may be changed, and what a turn that changes one owes the user. Read before editing any SKILL.md or any file in a skill's folder, and follow it in place of that skill's own account of the same thing.
---

# Editing a skill

**A skill file changes how every later run behaves, so the user reads the words rather than a description of them.** That is the whole of this file: when an edit is allowed, where the lesson goes, and how the change is reported.

## When an edit is allowed, and where the lesson goes

**The mode is on the second line of the active loop's flag file**, `mode: locked` or `mode: learning`. Absent, it reads as **locked**.

In **locked** mode the lesson goes to [skill-proposals.md](../../skill-proposals.md): at most three sentences, the rule and the failure it came from. **That file scores its own entries, so filing means writing the rule as a heading, scoring it, and inserting a ranked row, read its scoring section, not only this line.** *An entry appended to the foot is unscored and invisible to the promotion pass, which is what happens when a cycle reads the skill that says where to file and not the file that says how.* The user promotes it when they choose, and the run carries on without pausing.

In **learning** mode the lesson is written into the skill and **the run pauses for approval**, under a ceiling of **120 added words**, a rule needing more than that is not yet understood well enough to write down.

**A proposal scoring 80 or more with no `HOLD` is written into the skill at once, in either mode, under the same 120-word ceiling.** Below that it waits in the file, silently, and is read when someone works the table; the run neither stops nor reports it.

**A proposal that has been written into a skill leaves the file.** The rule now lives where it acts, and the incidents behind it live in the chronology, so the row is a third copy that says nothing the other two do not. **A file holding applied and pending entries together cannot be read at a glance**: every row has to be checked against the skill before anyone knows which are outstanding, which is the work the file exists to save. *Delete the row and its body on the same change that lands the rule.*

**Set the bar at the widest gap in the score distribution, so a one-point re-score cannot flip an irreversible action.** *Impact is a lookup from the occurrence count and importance barely varies, so the total is close to a count of incidents grouped into a row, and the grouping is the filing cycle's own judgement. The bar therefore has to be placed where the totals are sparse rather than where a reason sounds good: at 80 the nearest rows sit nine points below, while at 70 five rows tie two points away.* **A threshold does not make the score honest**: 80 is reachable without a critical occurrence, at impact 10 with importance 8 or impact 8 with importance 10, so it narrows the grouping route rather than closing it. **The bar is high because the score authorises an unreviewed edit, and the error is asymmetric.** A rule that waits costs one more incident. A rule written into a skill that does not belong there misdirects every later run and reads as settled policy, which is the expensive direction.

**A promotion commits itself. The score is the review.** Report it verbatim anyway. **AND EVERY FILING OR PROMOTION REGENERATES [STATUS.md](../../../STATUS.md) IN THE SAME COMMIT**, since its score-band table is read out of this file and goes stale the moment a row moves. *A count nobody regenerates is the failure most of the rows here are about.*

**Every other skill edit pauses, and stays uncommitted until approved.** The uncommitted change is what the Stop hook sees; the pause is what the user gets. **WITH A MANAGER SESSION NAMED IN [.claude/sessions.json](../../sessions.json), A LOOP SESSION NEITHER PAUSES NOR WRITES THE EDIT: IT SENDS THE PROPOSED TEXT TO THE MANAGER, WHICH WRITES IT, REPORTS IT VERBATIM, AND COMMITS IT ON THE USER'S APPROVAL.** *The pause belongs to the session the user is talking to, and a loop that waits on it stands still.*

## Report every edit verbatim

**Summarising an edit, "added a section on ranking", "tightened the wording", hides exactly what a reader would object to, and the objection is the point of showing it.**

**So a turn that edits a skill opens its reply with the line `the skill has changed`, then quotes the new or altered text in full, as a blockquote.** Every added section, every rewritten sentence, every deleted clause. Where a passage was replaced, quote the replacement **with the removed words still in it, struck through**; where a whole section went, name it and say why. **A long edit stays long in the reply**: length is the cost of changing the rules, and is not a reason to paraphrase.

**Head every quoted block with the file it came from, written as a path.** A delta with no address cannot be checked, and naming the skill rather than the file leaves the reader to work out which of its files changed.

**Set the changed words in CAPITALS, and quote enough unchanged text around them to locate the edit.** A blockquote of new text alone shows what the rule now says and hides what moved, leaving the reader to diff it against memory, which is the work the report exists to save. CAPITALS and strikethrough carry the delta together: INSERTED OR REWRITTEN WORDS IN CAPITALS, ~~removed words struck through~~, the surrounding anchor sentences plain. **A report that shows only what arrived hides what left**, and a clause quietly dropped is the edit a reader would most want to object to, so the removed text stays inside the quote, struck, rather than being described beside it. *Italics are the wrong instrument*: these files already italicise for emphasis, so a delta in italics is indistinguishable from the emphasis around it. Where a whole section is new, say so in one line and set the section in CAPITALS. Emphasis the new text wants for its own sake gives way; **CAPITALS mean ARRIVED and STRIKETHROUGH means REMOVED, in these reports and nothing else.**

*This applies to consolidations and deletions as much as to additions*, a merge that quietly drops a clause is the case where a summary misleads most.

## What earns an edit

Any one of these is enough:

- A rule was ambiguous and got read the wrong way.
- Work was done that a rule should have prevented.
- A reviewer caught something a self-check should have.
- A step took a form the file does not describe, and the next run would benefit from the description.
- A tool, script or search that worked well and should be reached for by default.

## Promoting a proposal into a skill

**A lesson is filed as a proposal first and promoted later, and the wait is the point.** A proposal is scored where it is filed, on two numbers whose product decides whether it is worth an edit at all.

- **Impact** is what the failure has already cost, and **occurrences drive it**: seen once it scores low, because one incident is as easily an accident as a pattern. **A critical single occurrence overrides that**, one that would have falsified a recorded claim, corrupted a bound in the unsafe direction, or let a defect survive a check aimed at it. **THE ROW NAMES WHICH OF THE THREE IT WAS, OR THE FLAG COMES OFF.** *The flag is what carries a two-incident row past the bar, and it is the filing cycle's own counterfactual, written minutes after the incident by the party that wants the rule.* **An unnamed flag is a deferral that never resolves**: the same cycle writes `HOLD` because it does not believe itself, and the row then sits above the bar acting on nothing. *A flag that can be named is worth its points, and one that cannot was a wish.*
- **Importance** is what the rule would protect going forward, judged independently of what it has cost.
- **Total = impact × importance.** *The product refuses the trade a sum would allow: something costly that protects little is a one-off to absorb, and something central that has never bitten is a prediction.*

**Everything below the bar waits to see whether it recurs.** A proposal that never recurs is one the files were right not to carry, and a rule added on a single vivid incident costs every later reader the time to read it.

### The four steps, in order

1. **Subtract what the files already hold.** Read the destination and cut the proposal down to the part that is genuinely absent, a rule whose core is already written and whose sharpening is not gets promoted as the sharpening alone. *Most of the gap is smaller than the proposal claims.*
2. **Pick the destination by what governs the act**, not by where the failure happened: the loop's own file for a rule about running the loop, a practice file for a rule about how a computation or an argument is made, the spec for a rule about how a file is written. **A rule reaching two loops is written into both**, because a reader of one will not open the other.
3. **Write the rule and leave the incident behind.** *This is where promotion most often goes wrong*, because the incident is what convinced the author and it feels like the strongest sentence available. **It is inadmissible: `## How to write the rule` below governs the text that lands, and a promoted proposal is subject to it in full.** No dates, no run or round references, no "this cycle", no counts of what happened when, **state what the failure IS: its shape, what it costs, and what distinguishes it from the thing it resembles.** The incident stays in the proposal file, which exists to hold it.
4. **Move the incident to [ATTEMPTS.md](../../../ATTEMPTS.md) and delete the proposal.** *The rule that lands carries no incident, so the evidence for it has to live somewhere*, and that is the notebook, which exists for it. **Keeping a copy in the proposal file as well leaves three records of one fact to hold in step, which is the failure several of these rules describe.**

### After promotion

**Report the edit under `## Report every edit verbatim`, and check the landed text against `## How to write the rule` once more before closing.** *A promotion is an edit written by an author who has just argued for it, which is the condition every other rule here treats as unreliable.*

**A rule governing a step that produces an artefact ships with the check that reads that artefact, or says in the rule that it is unenforced.** *Without a gate a rule is followed while fresh and then not at all, and nothing distinguishes the two states from outside: the file still says the right thing, so an audit of the skill finds no defect.* **Restating does not substitute for gating**, a rule written in four places and gated in none is ignored as reliably as one written once. **The gate need not be strong**: a declaration the author writes into an index, checkable against one row, turns an invisible omission into a visible claim.

## How to write the rule

**Write the fix as a positive instruction, what to do, not what to avoid.** When a section grows past its usefulness, compress it rather than appending.

**A NEW RULE OWES A SEARCH FOR THE TEXT IT CONTRADICTS OR REPEATS, AND THAT TEXT IS DELETED IN THE SAME EDIT.** *An added rule reads as complete on its own, so the passage it overturns is never looked for, and a file that says both governs by whichever half the next reader reaches first.* **Name what the rule makes false before writing it**: a threshold it replaces, a deferral it cancels, a limit it makes unreachable. **A REPETITION IS THE SAME DEFECT WEARING AGREEMENT**: two statements of one rule drift apart under editing, and the reader who meets the weaker one never learns there was a stronger. *A real sharpening usually removes more words than it adds, so the count is the check.*


**A rule states the failure mode, not the incident.** What generalises is the shape of the mistake, a constant taken from too few samples, a bound computed in the wrong direction, and that is what the next reader needs. The run that exposed it does not generalise, so its numbers, durations, dimensions, dates and run references stay out; they belong in [ATTEMPTS.md](../../../ATTEMPTS.md), which exists to hold exactly that.

**Every skill here is written to be lifted into another project.** Read each rule you add as someone arriving with a different problem, different objects and no memory of what happened here. A rule naming this project's papers, subspaces, tensors or constants will read as noise to them, and will still be sitting there after the mathematics it refers to is gone. Keep it about the work, not about the day's work.

**The toolchain is not among those objects.** Lean, Mathlib, `sorry`, `ring`, `norm_num` and `nlinarith` are what the work is done *with* rather than what it is *about*, and this programme relies on them. **A rule about proving something names them plainly**, writing *the layer* or *a machine-checked file* where the step means Lean is vaguer than the step it governs, and reads as a euphemism for the tool everything here depends on.

## Editing this file

**By its own rule**: `the skill has changed`, verbatim blockquote, CAPITALS for the delta.
