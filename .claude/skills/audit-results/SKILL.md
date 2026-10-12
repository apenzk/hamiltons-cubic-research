---
name: audit-results
description: Audit the record's numbered results (Lemmas, Observations, Conjectures and Corollaries alike) for correctness, in dependency order from the leaves up, two independent reviewers per claim, fixing what is found rather than recording it. Use when the user says "audit the results", "audit the lemmas", "audit the canon", "check the results are correct", or invokes /audit-results.
---

# Audit the results

**A result with no recorded verdict is unaudited, whatever anyone remembers.** The audit establishes that verdict and repairs what it finds.

## One result at a time, in dependency order

**The unit is a single result, audited and repaired and closed before the next one starts.** A refuted input invalidates every audit above it, so the next result taken is one whose own inputs are already audited **and none of them marked `BROKEN`**, a leaf first, then whatever the leaves unlock.

**Build the order by scanning each result's block for the numbers it cites**; a result citing nothing numbered is a leaf, and a result outside the graph can be taken whenever.

**Errors at the leaves have propagated for the life of the record and nothing has ever checked them.**

## Two reviewers

**Run the pair by [research-loop](../research-loop/SKILL.md)'s step 2**, which fixes how a brief is written, the logging protocol, what to do when a reviewer dies, and how to cite one. Three things are specific to auditing:

- **One result per brief**, matching the unit above.
- **Each reviewer is told not to read the other's report.** Independence is the whole value; a second verdict that has seen the first is one verdict.
- **The brief cites what the record holds, not the sources behind it.** A reference's `notes.md` is the record's own reading of that source, and it usually carries the claim under audit already. **Send a reviewer to a source only when the notes do not answer the question, and then to a targeted search rather than to the file**, *a brief that names a large file has not checked what the record holds, and reading one is how a reviewer is spent.*
- **A reviewer creates its report file before any mathematics and appends each verdict as it reaches it.** A report assembled at the end exists only in context, and a process that ends first loses everything it concluded.
- **Salvaging a dead reviewer includes closing its log.** *An unclosed log is indistinguishable from a working one*, so a reviewer that died leaves the next turn waiting on it, write `FAILED` with what happened as the first word of the last line, alongside whatever was salvaged into the report.
- **A dead reviewer's cause is two lines away, in the tail of its transcript.** The task's output file is a full JSONL transcript and reading it whole floods the context, but `tail -2 <file> | cut -c1-300` is cheap and settles it. **An interrupt of the launching turn kills every subagent still in flight**, and that transcript ends in `[Request interrupted by user]` rather than in an error, so after an interrupt lands near a launch, confirm each reviewer is alive before waiting on it.

## What a brief attacks, in order

1. **Does the block state the claim its heading announces?** A heading promising a bound, above prose that never displays an inequality, is a defect and not a lemma.
2. **Rebuild from the definitions**, not from the block's argument. Recompute every dimension, multiplicity and constant.
3. **The quantifier and the exceptional cases**, every $n$, or only where checked?
4. **The norm**, against the conventions file rather than the block's own usage.
5. **What cites it, and whether that use is inside its hypotheses**, including the canon.
6. **What the record already knows about it.** Read [findings/](../../../findings/) for the quantity and the information it is bounded from, not for the identifier, which a related block rarely carries. *Facts that settle a result routinely sit in a second file, unjoined.*

**When a repair does not come quickly, look before deriving.** The record's own findings first, then [references/](../../../references/), a result may be published, and its published form carries the hypotheses the block is missing. **Deriving what is already held costs a cycle and risks getting it wrong.**

## Understand before applying, and say how

**A reviewer's report is a lead. Nothing from it enters the record until it has been rebuilt from the source it describes.** Read the block, the definitions and the conventions the finding rests on, and reach the conclusion independently, *a report arrives with a table and a witness, and applying it feels like diligence.*

**Never paste a reviewer's phrasing into the record.** A sentence copied without being understood carries whatever the reviewer got wrong, and the copy reads as the record's own voice. **Write the finding in the record's terms, from the source.**

**A reviewer's REFUTED rewrites the record; a CONFIRMED costs little if wrong.** So a refutation is reproduced by a route sharing nothing with the reviewer's before it changes anything, and the commit names that route.

**A search validates a finding only over what it searched.** A claim of the form *nowhere on the record* needs the whole record, not the file the block sits in.

## Fix, do not record

**A finding is closed when the mathematics is right, not when the defect is written down.** In order of what is usually available:

**New mathematics is inside the audit's scope, not outside it.** *A proof supplied here is a proof;* it goes through the same two reviewers as anything else.

- **A wrong statement**, correct it, in the block, the canon and the index.
- **A missing hypothesis**, add it, then discharge it at every use site or say it is open there.
- **A wrong label**, the labels are literal, so a result resting on measurements is an Observation at the dimensions measured whatever it is called. **BUT A DOWNGRADE IS NOT A REPAIR.** *It makes the record honest about the evidence and leaves the result exactly as unproved as it was*, so what the old label asserted becomes an open obligation, named in [LEDGER.md](../../../findings/LEDGER.md) with the statement that is owed. **An audit that downgrades and moves on has recorded a defect, not fixed one**, which is what this skill forbids everywhere else.

  A relabel also carries a radius: every Lemma citing the downgraded result is resting on an Observation until someone reads what it takes from it. *Read them; a note saying the reading is owed leaves the defect standing.*
- **A refuted mechanism under a true conclusion**, supply the proof if the record already holds its inputs, and mark it owed if not.

## Then the blast radius, transitively

**Every correction that narrows a claim leaves anything resting on the wider version unsupported**, and each one found is repaired before the result is closed. *Checking is not fixing: a dependent listed and left is an open defect with a note attached.* The sweep runs until it stops finding things rather than one level down.

**Direct citers are the start, not the end.** A result that survives the correction may still have been cited by a third that does not, so each broken dependent is itself a correction with its own radius. *A one-level check answers a question nobody asked.*

**A narrowed result narrows what the programme claims, and that is the radius working rather than a reason to stop.** *Correcting the canon to match a corrected result is the repair, not an escalation.*

**Results are not the only dependents.** A fence post closes a route on the strength of a result; a route's clearance criteria name results; the plan's grades assume their inputs hold; the canon states results with hypotheses; the report carries them outward. **Each is a place a narrowed claim can leave a false sentence**, and the canon and the report are where a false sentence costs most.

**Grep the statement, not the identifier.** A statement mirrored into a second file for readability does not follow its original, and a mirror rarely carries the number.

**A dependent found broken is repaired, not annotated.** Where the repair is a hypothesis, discharge it at that use site or say plainly that it is open there.

## Where the verdict lives, and what to report

**The verdict is written to the ledger in the same action that produces it**, with the index marker beside it. Written later, it is not written.

**Each closed result is reported with the count still outstanding.** The count is the number of numbered results carrying no recorded verdict, which the structure check already prints, read it rather than keeping a tally, since a tally drifts and a derived count cannot.

## The loop, and what ends it

**One closed result runs into the next.** The audit continues until a condition below fires, and a closed result is not one of them, the count of results awaiting audit is what says whether the work is finished.

**A result that cannot be repaired is marked `BROKEN` in [LEDGER.md](../../../findings/LEDGER.md), and the audit continues to a result that does not depend on it.** *Nothing resting on a broken result may be audited*, its foundation is known bad, so a verdict on it would mean nothing. **The mark is the point**: a defect recorded as BROKEN is visible to every later brief and every grade, where one left in prose is not.

The conditions are these, and only these:

- **The user interrupts or says to stop.**
- **Nothing is awaiting audit.** Every numbered result carries a recorded verdict; this is the terminal.
- **Every remaining result depends on one marked `BROKEN`.** *A repair needing new mathematics is attempted first*, a refuted mechanism under a true conclusion is repaired by proving it, and the inputs are usually already on the record in another block. **When the attempt fails, the result is marked `BROKEN` with the statement it would need and what blocks it**, and the audit moves on; it stops only when nothing independent is left.
- **This file changed**, pause for approval, having reported the edit as the section below requires.
- **A result has been through two full pairs without a verdict**, reviewers irreconcilable, or dying before filing. Mark it `BROKEN` with precisely what is unresolved, and take a result that does not depend on it.

## Editing this file

**An edit here follows [editing-skills](../editing-skills/SKILL.md)**, when it is allowed, where the lesson goes, and the verbatim report it owes. *A summary of a rule is not the rule.*

