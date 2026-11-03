---
name: lean-loop
description: Machine-check the record's numbered results in Lean, one per round, split the claim into the part the record holds data for and the part it does not, formalise the first, state the second, and record which is which in lean/INDEX.md. Use when the user says "lean loop", "formalise the next result", "check it in Lean", "next lean round", or invokes /lean-loop.
---

# Lean loop

**One loop runs at a time.** No rule here may assume a second session writing the record concurrently; a reason of that shape is unsound and is deleted rather than repaired.

**The layer is described once, in [lean-layer.md](../lean-layer.md); how to write a file is [lean-practice.md](../lean-practice.md).**

**READ [STATUS.md](../../../STATUS.md) AND [DECISIONS-TO-MAKE.md](../../../DECISIONS-TO-MAKE.md) AT THE HEAD OF EVERY ROUND.** *The first says where the programme stands and carries this layer's own debt figures. The second carries what is owed to the user.* **THIS LOOP REGENERATES [STATUS.md](../../../STATUS.md)'s COUNTS AND NEVER WRITES ITS JUDGEMENT SECTIONS**, because securing what is proved cannot move the position, and a loop that edits the position it cannot move is reporting progress it did not make. *It carries what is owed to the user, and a round that needs a decision writes it there rather than into a reply, because a reply is read once and a file is read every round.*

One numbered result per **round**. A round ends with that id carrying one of [lean-layer.md](../lean-layer.md)'s four states in [lean/INDEX.md](../../../lean/INDEX.md), and the next id opened in the same turn.

This loop **checks** the record with a machine. The [verification-loop](../verification-loop/SKILL.md) checks it with readers, and the [research-loop](../research-loop/SKILL.md) extends it. **THE RESEARCH LOOP NUMBERS A RESULT ONLY WITH ITS LEAN PROOF COMPLETE, SO THIS LOOP'S WORK IS THE BACKLOG NUMBERED BEFORE THAT RULE.**

## This loop spawns no agents

**The kernel is the adversary.** Every other loop here fans out because a reader can be wrong and independent readers are the only correction; a proof that type-checks needs no corroboration, and one that does not is not improved by a second opinion. So a round is the loop's own work throughout, and the only cost is time.

**What that trades away**: a kernel checks the proof it was given, never whether the statement is the one the record meant. Statement fidelity is this loop's whole exposure, ~~which is why the round quotes the source rather than paraphrasing it~~ **SO A ROUND THAT TYPES A STATEMENT SHIPS IT TO ONE READER AGAINST THE RESULT IT CLAIMS**, with the source quoted, `#print axioms`, and one object satisfying the hypotheses. *Quoting is done by the author, which every other rule here treats as unreliable. It passes a point condition under a docstring claiming monotonicity, and a name shadowing the library's own.* A Lean statement that disagrees with the record is triaged before it is trusted. **ONE READING PER STATEMENT: A REPAIR TO AN INDEX ROW, A FILE HEADER OR AN OWED LIST IS COMMITTED WITHOUT A FURTHER READER, AND A NEW READER IS SENT ONLY WHEN THE TYPED STATEMENT ITSELF CHANGES.** *A reader spent on the index's wording checks nothing a result depends on.*

## Effort

**THIS LOOP RUNS AT THE `lean.main` STANDING LEVEL SET IN [.claude/effort-levels.json](../../effort-levels.json) THROUGHOUT.** [effort_gate.py](../../hooks/effort_gate.py) blocks the first tool call at any other level while the loop is armed, so a level raised for other work is caught before a round runs on it.

## The round

### Phase S, scan for new items (optional)

**Run it when the queue is empty, when results have landed since the last scan, or when the user asks, never mid-round.** A scan that interrupts a round re-ranks the list the round is standing on.

**The queue is [plan-lean.md](../../../plan-lean.md)'s coverage table**: every numbered result the layer does not prove, read from [findings/INDEX-results.md](../../../findings/INDEX-results.md) against [lean/INDEX.md](../../../lean/INDEX.md), main route first. **A ROUND TAKES THE TABLE'S TOP ROW. WHILE A MAIN-ROUTE ROW THAT IS NOT `out` REMAINS, ONLY A MAIN-ROUTE ROW IS WORKED, AND A ROUND ON ANY OTHER ROW NAMES IN ITS COMMIT WHY THE ROWS ABOVE IT CANNOT BE WORKED.** *Unenforced: read at the start of every round.* **A `partial` or `statement only` row is on it as much as an untouched id**, since an unfinished half nobody typed carries no `sorry` for the statement debt to find. For each row, record what a Lean proof would need:

| bucket | meaning |
|---|---|
| `ready` | needs nothing this project does not already have |
| `blocked on <piece>` | needs one named piece of the base layer |
| `out` | needs library machinery that does not exist, with what named |

**Classify by what the argument needs, not by what the statement mentions.** A result about objects the base layer has not defined can still have an argument that never touches them, and reading the statement alone files it as blocked when it is ready. **That is the scan's one systematic error**, and it costs a round that would have closed.

**The scan classifies and does not formalise.** A bucket is a guess that phase 1's split confirms or overturns; a row that turns out misfiled is re-filed with the reason.

**Within each route tier of the table, order `ready` first, except that a `B` row outranks them when it unblocks more rows than remain `ready`.** Otherwise the loop spends its cheap rows and then stops, with every remaining row waiting on something nothing can schedule. **A `B` row also carries its bound** (the smallest version that unblocks its rows) since infrastructure has no statement to stop it growing.

Record the commit the scan read, so the next one is incremental.

### Phase 0, read the machinery before the prose

**Open the verifying script and the stored data before the findings block.** A block says what a result claims; a script says what was actually checked, and the two can disagree, the block is the later document and drifts, while the script is executable and does not.

**Read every file the object appears in, not only the block's own.** A result's construction and the definition of the object it constructs are routinely in different files, and the second carries the identification the first assumes. Grep the object's name across the record before formalising anything: a witness built from the wrong member of a family type-checks, passes every conditions check, and proves a statement the block did not make.

Record in the round's notes, from the source rather than from memory: the statement, the data files it rests on, and what the existing verifier does and does not check.

### Phase 1, split the claim before formalising anything

**Separate the part the record holds data for from the part it does not, and name both.** A claim is rarely uniformly checkable: one half can be exact rational data sitting in the tree, the other an inference from a computation whose inputs were never stored.

**What the record foregrounds is the computation; what it states in passing is the structure. The structural half is the cheaper and the stronger one, and it is where the round starts.** A block leads with its certificate, its table or its measured values, and carries its general claim in a subordinate clause, *both defining conditions are linear*, *the ordering follows*, *the constant cannot be improved*. That clause is usually a theorem at every dimension, provable in the kernel, while the foregrounded half needs data the record may not hold. **It is also where the record's own errors are not**: across the rounds run so far the computational half has carried refuted values and a measurement standing in for a proof, and the structural half has not been wrong once.

**The record's decimals are exact algebraic numbers, and restating them exactly is often the whole content.** A figure written to six places is a measurement; the same figure as a fraction or a surd is a theorem, and it usually says more, a closed form where the decimal gave one dimension, a connection to a result already proved, or a counterexample that no longer depends on a rounding. **Reach for the exact form before deciding the claim needs anything else**, and check where the irrationality actually lives: it is often entirely in a normalisation, and the unnormalised statement is rational and decidable.

This costs nothing and decides the whole round. **The split is the deliverable even when nothing is proved**, a round that establishes *this half is checkable and that half rests on a measurement the record does not hold* has produced a finding about the record, which is what the loop is for.

### Phase 2, formalise the checkable half

**Generate the Lean from the data file; never retype the numbers.** A transcription is a second copy that can drift from its source, and drift in a certificate is undetectable by reading. Emit the Lean from the stored data in one step, and say in the file's header which file it came from.

**Check the packing convention before trusting the entries.** Stored data is often not the object it represents, a packing may omit factors, halve off-diagonals, or store a related matrix. Read the producer or the verifier for the convention, and formalise the object the certificate *represents*.

**Prefer the kernel.** `norm_num` and `decide` are checked by the kernel; `native_decide` trusts the compiler, so reach for it only when the kernel genuinely cannot carry the computation.

**Read the library for a name rather than guessing it.** A wrong lemma name is found only by building, and a build is the slowest step in the round, so grep the library source for the signature first, including its argument order and which arguments are implicit. **Dot-notation is the quiet form of the same guess**: it resolves against a hypothesis's current type, so a tactic that rewrote that type breaks the projection with an error naming something unrelated.

### Phase 3, state the rest, and never fake it

**Where the statement cannot yet be written (the objects are not defined) write prose, not a theorem.** A trivially true proposition under a real-sounding name reads as proved to everything that later greps the file, and it is the one artifact in this loop that can mislead silently. Either state the thing properly and leave it `sorry`'d, or say in a comment what is missing and why.

### Phase 4, record the state, then triage

Write the id's row in [lean/INDEX.md](../../../lean/INDEX.md), in the shape [lean-layer.md](../lean-layer.md) gives, with the reason the result cannot be closed here.

**A row's state is settled by [axiom_audit.py](../../../scripts/misc/axiom_audit.py), never by the build succeeding.** `lake build` passes with a `sorry` in the tree and passes with `native_decide` in it, so `#print axioms` on the round's theorem is what separates `proved` from `partial`. *It walks the whole dependency tree and returns only the declarations carrying no proof, so one call covers every lemma beneath the result.*

**Then regenerate [plan-lean.md](../../../plan-lean.md)** with [lean_debts.py](../../../scripts/misc/lean_debts.py), and commit it with the round. *A row leaves that file when its debt does, so a stale copy reports work that is already finished.*

**A ROUND THAT CHANGES WHAT IS PROVED SWEEPS DOWNSTREAM BEFORE IT COMMITS.** *A proof that discharges a hypothesis, retires an import or corrects a statement makes false every row, docstring and record passage that still calls it owed, imported or unproved.* **Search the id, the discharged lemma's name and its statement across lean/INDEX.md, the Lean docstrings, findings/, results.md and the report, and repair every hit in the same turn**: layer text in the round's own commit, record text by its owning loop, which is this session's whenever that loop is armed. **Then rebuild the full tree**, since a changed signature breaks consumers the round never opened.

**Triage a refusal before queueing it**, as [lean-layer.md](../lean-layer.md) sets out; a mis-stated hypothesis, or a normalisation taken from somewhere other than [conventions.md](../../../findings/conventions.md), is the usual cause. **The fix is not made here**: tracing what cites a confirmed defect is the [verification-loop](../verification-loop/SKILL.md)'s work, and this loop has no view of it.

### Phase 5, commit and take the next id

**Commit the round as it completes**, per [CONTRIBUTING.md](../../../CONTRIBUTING.md). This repository is written by several sessions at once, and an unstaged file is swept into whoever commits next, landing inside another thread's commit under a message describing something else.

Then take the top row of the regenerated coverage table and open its round in the same turn.

## What this loop does not do

**A CALL THAT IS THE USER'S (AN `unsupported` VERDICT, A DISAGREEMENT THAT SURVIVED RE-STATEMENT, A CHANGE TO THIS SKILL OR ITS HOOKS) GOES TO THE ORCHESTRATOR SESSION NAMED IN [.claude/sessions.json](../../sessions.json) WHEN ONE IS LISTED, AND THE ROUND MOVES ON TO THE NEXT WORKABLE ROW.** *The orchestrator puts it to the user and commits the answer, so the loop reads it from the repository.* **THE HANDOFF IS A `SendMessage` TO THE ORCHESTRATOR WHOSE FIRST LINE OPENS WITH ITS KIND: `DECISION`, `SKILL CHANGE`, `BLOCKED` OR `DEFECT`.** It carries the ask, a recommendation, and what this session does meanwhile. `BLOCKED` is an action a permission check or a hook refused and this session cannot clear, named with the refusal's own words, and it is never retried by other means.

**It does not repair the record.** A defect it finds is queued, and the repair belongs to whichever loop owns the mathematics. **A DEFECT ROUTED OUT OF THIS LOOP IS SENT WITH `SendMessage` TO THE ORCHESTRATOR SESSION NAMED IN [.claude/sessions.json](../../sessions.json), WHICH HANDS IT TO THE OWNING LOOP'S SESSION. WITH NO ORCHESTRATOR LISTED, IT GOES TO THAT LOOP'S SESSION DIRECTLY.** *A handoff with no receiver is a defect left standing under a rule that reads like diligence: the lean loop says the repair is not its own, nobody is named, and the finding ages in an index row while the false statement stays in the tree.*

**It does not compute to fill a gap.** Where a proof needs data the record does not hold, that is the finding. Generating the data is a research task, and this record is on an analysis-only footing where computation is approved per task.

## Editing this file

**An edit here follows [editing-skills](../editing-skills/SKILL.md)**, when it is allowed, where the lesson goes, and the verbatim report it owes.
