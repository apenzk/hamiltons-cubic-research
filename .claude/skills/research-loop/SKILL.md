---
name: research-loop
description: Drive the Conjecture A research programme one cycle at a time, take the top open task from plan.md, search the literature before deriving anything, run an independent adversarial review, fold the verdict into findings/INDEX.md and results.md, improve this skill, then pick the next task and repeat. Use when the user says "research loop", "next task", "keep going on the proof", "work the plan", or invokes /research-loop.
---

# Research loop

**One loop runs at a time.** No rule here may assume a second session writing the record concurrently; a reason of that shape is unsound and is deleted rather than repaired.

A continuous cycle over the proof programme. One pass through steps 1–9 is one **cycle**; step 9 hands back to step 1 and the loop continues inline in the same session until the user interrupts or a stop condition fires.

The goal never changes and is stated in [README.md](../../../README.md); read it there rather than restating it here, so this file stays true when the goal is a different one. **Numerics are a LAST RESORT, and the deliverable is always an argument.** This is stronger than a ranking and stronger than a tiebreak, and it is meant to be: a cycle that runs a computation where a derivation was reachable has failed, even when the number is right. Numerics have exactly three legitimate uses, **refuting** a candidate, **checking** something already derived, and **screening** an object's validity. Establishing a positive claim is not among them, and *"it would have been slow to derive"* is not a reason, because the alternative on offer is not a slower proof but no proof at all.

**THE DELIVERABLE IS AN ELEGANT ANALYTICAL PROOF, a human can read it and check it.** This governs the *goal*, not just the method, and it is the rule the rest of this section serves. A machine-produced certificate is not it: an exact SDP, a Sturm run over hundreds of minors, a rational Gram fitted at one dimension and transferred, each may be *true*, and none is a proof anyone can hold in their head. **A route whose endgame is a certificate is a route with no analytical endgame**, and the plan says so beside it rather than discovering it four steps in.

*The failure this prevents is slow and every step of it is legal.* A certificate route is ranked top because it is the only one with a live method; its sub-steps are then honest work; the objects it needs get built; the cost of building them gets measured; the measurements get audited. **Nothing in that chain is wrong and the whole of it is off-target**, because the question "what statement would a reader end up with" was answered once, at the start, and never revisited. So it is asked every cycle, at step 1, in one line: *what does this item let someone prove, and could they follow it?*

**A cycle that measures the cost of a computation has produced nothing.** Timings, cost ratios, a line fitted through four leg counts, how many samples a routine needs, these are engineering facts about an implementation. They are not `derivation`, whatever the commit says, and they are not `refutation` unless the number kills a claim on the record. **Benchmarking is `none`.**

**So the order is fixed: derive first, and reach for code only once a named analytical attempt has failed.** Before writing a script, say what the argument would have to look like and try it, starting from the identities the record has already proved, which is where this project's derivations have actually come from. If the attempt fails, record what blocked it; that sentence is what licenses the computation and is worth more than the run. A run with no such sentence behind it is the thing this rule forbids.

## Continuation is the default

**The loop runs until a listed stop condition fires, and every turn continues into the next action by default.** This is the rule the whole file rests on, so it is stated before the mechanics rather than inside them.

What makes it fail is never forgetting it. It is that a unit of work *feels* finished: a commit lands cleanly, a limitation gets written into the record, a status summary reads as complete, a question gets answered. Each leaves the record consistent while the task list is unchanged, and consistency of the record is what completion feels like. **None of them is a stopping point.**

So the test is mechanical rather than a judgement: **a turn's last action is a tool call, not prose.** If the closing message would end by saying what comes next (a gap to attack, a method to try, a dimension not reached) that sentence is the instruction to keep going, and the turn continues into it.

**Arm the flag first, as the cycle's opening action, nothing else arms it, and an unarmed hook is indistinguishable from one that allowed the stop:** `echo "session: $CLAUDE_CODE_SESSION_ID" > .claude/research-loop-active`. It binds to one session so unrelated threads are never pushed into the plan; delete it to disarm.

A `Stop` hook enforces this while a cycle is marked active. It reads the top live item from [plan.md](../../../plan.md) and hands it back by name, so a blocked ending arrives with a concrete task rather than a reminder. It also checks one condition for itself instead of trusting recall: **if any file in this skill's folder has uncommitted changes, [SKILL.md](SKILL.md), [computational-practice.md](computational-practice.md), [results-spec.md](results-spec.md), [README.md](README.md), or one added later, the cycle owes the user an approval pause**, and the hook blocks the resumption rather than the stop. *The folder is the unit rather than SKILL.md alone, because the guidance a cycle follows is spread across every file in it, and a rule moved out of SKILL.md is not thereby made the cycle's to change.* The hook is not the user, an instruction from the user to hold outranks it, and the hold is re-declared each turn it lasts.

## Where everything lives

| File | Role |
|---|---|
| [README.md](../../../README.md) | The goal. Fixed. |
| [plan.md](../../../plan.md) | The task list and the standing rules, in three sections, advance, build, disprove. Rewritten by this loop. |
| [STATUS.md](../../../STATUS.md) | **Where the programme stands, between sessions**: the chain from the goal to the current item, the share of the work done, and a GENERATED block ([status_report.py](../../../scripts/misc/status_report.py)) carrying the plan's grade table, the Lean debt and the proposal score bands. *The judgement half persists, because one re-invented at every status is one nobody can argue with.* |
| [DECISIONS-TO-MAKE.md](../../../DECISIONS-TO-MAKE.md) | **Anything owed to the user, read at the head of every cycle and named in every status.** *A decision compressed into a chat sign-off is seen by luck; three sat unnoticed for hours that way. An item carries the ask, a firm recommendation, and what each answer changes, and is DELETED once acted on.* |
| [findings/INDEX.md](../../../findings/INDEX.md) | **The index.** What is settled, which findings file holds which subject, every catalogued $\theta$ by value, and every fence post, one line each. Short by design; read in full every cycle. |
| [findings/](../../../findings/) | The mathematics itself, one file per subject. Open the one the index names; leave the rest closed. |
| [ATTEMPTS.md](../../../ATTEMPTS.md) | The lab notebook, what was tried, in the order it was tried. Append-only. |
| [reviews/INDEX.md](../../../reviews/INDEX.md) | Adversarial verdicts. **The entry point**: an index naming every reviewer, then a section each. From reviewer 58 the full report also lives in `REVIEW_rN.md`, and the index links it, but the sections are *not* droppable summaries, since some carry synthesis found nowhere else. |
| [results.md](../../../results.md) | **The numbered canon.** Every result stated with its hypotheses, organised by route, each pointing at the findings file that proves it. Claims only, Gate 2 passed. |
| [routes.md](../../../routes.md) | **The route register.** Every route live or closed, mechanism, why it closed, and *what a successor must clear*. Read whole before proposing a route. |
| [references/](../../../references/) | One subfolder per consulted source. |
| [lean/INDEX.md](../../../lean/INDEX.md) | **What is machine-checked, and (for each numbered result) what its Lean file does NOT state.** A row's `statement: typed` marks that the result's own claim is a Lean proposition; the prose beside it names what was left out, which a `sorry`-free file does not otherwise show. |
| [scripts/](../../../scripts/) | Verification code. |
| `agent_logs/` | Heartbeat logs, gitignored. |

## The agent budget: one or two, both at step 2

The cycle runs **inline**. Exactly one step spawns subagents: **step 2's adversarial review**, where a cold start is the point, each reviewer works from the definitions alone, so it cannot inherit the author's assumptions. **A reviewer's output is a derivation.**


**A RESULT WHOSE LEAN PROOF IS COMPLETE IS REVIEWED BY ONE AGENT, NOT TWO, WHETHER IT IS NEW MATHEMATICS OR AN ALREADY-AUDITED RESULT.** Lean's kernel checks every step, so the errors two independent readers sample (a wrong manipulation, a missing case) cannot survive a build. What survives is a statement that type-checks and is not the result: quantified over the wrong type, weakened to something it implies, or vacuous. That is one comparison against the source. **Ship it with the checks that need no judgement**: `#print axioms`, so no `sorry` hides behind a name; one object satisfying the hypotheses, so vacuity is visible; and the source's statement quoted in the file, so the comparison is a diff rather than a recollection. **THE ONE REVIEWER ALSO CHECKS THAT THE PROSE PROOF FOLLOWS THE LEAN PROOF'S STEPS**, since the prose is the deliverable a reader checks by hand. **Two reviewers stay wherever any step of the claim exists only in prose.**

**SO THE COUNT IS DECIDED BY ONE QUESTION: IS THE ROUND CHECKING AN ARGUMENT, OR COMPARING TEXT AGAINST SOMETHING ALREADY FIXED?**

- **Checking an argument, TWO.** New mathematics with any step not yet proved in Lean, where the reasoning is being made rather than read. Two readers sample a wide distribution of reasoning errors and rarely find each other's.
- **Comparing against something fixed, ONE.** A complete Lean proof against the claim and its prose, a Lean file against the result it claims, an index row against the declarations it names, a fold against the findings it answers, a hook against the behaviour it asserts. *There is no reasoning to sample: the comparison is a single act, and two readers perform it identically and report it in different words.*

**A LONE REVIEWER'S FINDING IS A CLAIM, AND ITS REACH IS CHECKED BEFORE IT REACHES THE RECORD.** *A second reader's real purchase on such a round is a catch on the first reader's own overstatement: a finding true of one file, reported of a whole layer, and adopted unexamined because it arrived under a reviewer's letterhead.* **A grep buys the same protection at a fraction of the cost.**

**AND NO REVIEWER IS SPENT ON WHAT A SCRIPT DECIDES.** *A dangling anchor, a duplicate id, a table whose arithmetic contradicts its own ladder, a blank line that ends a table, a numbered result with no row, a hook naming a flag nothing writes*, each is one pass over the file, and each is the kind of defect a round can be wholly consumed by. **They belong in the commit gate**, and a brief that asks a reader for one of them has spent an agent on a `grep`. **AND A CHECKER'S TOTAL IS NOT A RESULT UNTIL EVERY FLAG IS CLASSIFIED.** *An audit is correct on its own terms and wrong about the record whenever the thing it cannot see is what most of its flags are: a convention, a notation, a column read as something it is not.* **So report the mechanism the checker cannot see, beside the number**, and where the classification has not been done, report the raw count as raw. *A number large enough to indict a layer is almost always measuring a convention.*
**AND A REVIEWER READS THE WRITTEN CHAIN, LINK BY LINK, BEFORE IT DERIVES ANYTHING.** *A result can have exact constants and a written argument that does not establish them*, a monotonicity step never stated, an infimum substituted where the value at hand was needed, a boxed clause true and argued nowhere. **This defect is invisible to numerical verification, to a second derivation of the same constant, and to the author, because everything each of them checks is the conclusion.** *A reviewer that reimplements and agrees has confirmed the number and said nothing about the proof.*

**So the brief asks, of every step: does this follow from the one above it and from the hypotheses actually stated?** Where it does not, the finding is that the argument has a gap, **not that the result is wrong**, which it usually is not, and which is why the gap survives so long. **This is the most common defect the record produces**, and every instance of it has exact constants.

**NOBODY WRITES THE SHARED REVIEWER INDEX UNTIL EVERY REPORT OF THE ROUND IS FINAL.** *Independence is the whole reason two readers are run, and the index is the one file both are certain to open.* **A reviewer forced to file its own row publishes its verdicts where its counterpart will read them; a parent that pre-writes a row attributes a verdict its author has not given yet, and the author must then correct the record about itself.** *Both failures read afterwards as agreement, and agreement between readers who saw each other, or who were told what they concluded, is worth nothing.* **So a commit gate that demands indexing must exempt a report filed by a reviewer, and the fold writes every row after the last report lands.**

**QUOTE THE BRIEF FROM THE BLOCK AS IT STANDS AT DISPATCH, VERBATIM, AND NEVER FROM A DRAFT OR A PARAPHRASE.** *A brief assembled while the block is still being repaired quotes a version that no longer exists, and the audit spends itself refuting text the record does not carry, the reviewers right, the findings real, and none of it reaching the record.* **A paraphrase is worse, because it can invert the claim**: restating "the derivative is negative" as "increasing" flips the conclusion, so the reviewer is asked to check an argument the block does not make and either passes the wrong thing or refutes it. *Both failures are invisible in the reports, which read as ordinary findings.* **So re-read the block off disk after its last edit lands, and copy, the pull to skip it is strongest exactly when the block was just edited, which is when it matters.** **THIS COVERS EVERY QUOTED PREMISE, NOT ONLY THE BLOCK UNDER AUDIT.** *A brief that hands over an earlier result as a given is quoting a second block, and a paraphrase there is harder to catch because the reviewer has no reason to doubt it*, **a given rendered without one of its clauses invents a hypothesis debt the record does not carry, and two reviewers will report it identically.**

**A COLD BRIEF WITHHOLDS THE RECORD, NEVER WHAT ITS OWN ATTACK ITEMS DEPEND ON.** *Withholding is what makes the read cold and is right. Withholding a constant, threshold or premise that an item on the checklist needs makes that item unanswerable, and an item nobody could answer is indistinguishable from one checked and cleared, which is the protection the checklist exists to give.* **So every constant an item names is quoted beside it, and every result the audited claim rests on is stated as a given.** *An item asking whether a conclusion follows, from a brief missing the premise it actually follows from, produces a correct refutation of the brief and a false one of the record, and two independent reviewers will produce it identically, which reads as corroboration.* **The cost is quoting a number and naming a lemma; the failure costs an audit.**

**The dispatch arms a watchdog over the reviewers, in the same turn**, with [reviewer_watchdog.sh](../../../scripts/misc/reviewer_watchdog.sh) backgrounded over their log paths, **which also registers each log with this session in `.claude/reviewers-in-flight`, the only reviewers the Stop hook treats as in flight for this session**, *a completion notification is the normal return path rather than a guarantee, and nothing else catches an agent that dies mid-write.* **ARM IT AS A TOOL CALL, NOT AS AN INTENTION**: the rule stood here for many rounds while no dispatch armed anything, because it named no mechanism and an unarmed watchdog is indistinguishable from a quiet one. **PASS THE THRESHOLD FIRST AND READ THE FIRST LINE OF OUTPUT**: the script's leading argument is the staleness threshold in seconds, so calling it with logs alone consumes one as the threshold, and it then either watches nothing and reports success at once or loops forever with every comparison erroring. *A running process proves nothing.* **Silence means watching; a success line seconds after a dispatch means the opposite.**

**AND A SILENT SUPERVISOR IS NOT A SATISFIED ONE.** *The Stop hook goes quiet while a reviewer log is warm, which is right, measured gaps in real reviewer logs run past half an hour whenever an agent starts a long computation, so silence is not death and neither a PID nor a short window can tell them apart.* **What that leaves is a dead reviewer producing exactly the same silence as a thinking one, and then, once its log goes cold, a hook that resumes naming the next task**, which reads as the round having passed rather than as its reviewer having died. *The watchdog is what distinguishes them, and it is the only thing that does.* The errors a cold reviewer catches are drawn from a wide distribution and a single draw misses much of it: separate audits in one programme have turned up a missing linear constraint, a family of counterexamples to a converse, and a multiplicity assumed to be one, three unrelated kinds of failure, none of which the others found. Two independent implementations of the same brief sample that distribution twice. Where they agree, confidence rises; where they disagree, exactly one is wrong and finding out which is the next task rather than an inconvenience.

Every other step runs in the session, because context is the loop's most valuable asset and each step depends on what the previous ones learned. Verification runs through the existing validated [scripts/](../../../scripts/): compute is free, output costs tokens.

**Read reviewer logs for CONTENT, not only for liveness.** A wait-loop that checks a PID and a modification time answers "is it still working", which is the less useful question. **The heartbeats carry live state, and live state includes findings**, a reviewer that has just falsified the claim the cycle is building on writes that into its log the moment it finds it, hours before its report is assembled. *A cycle once left a witness falsifying its own top-priority target sitting unread in a log for two hours while it kept building on the target, having polled that same file repeatedly for its timestamp.* **So each poll reads the last few lines, and a line that reads as a result stops the current work until it is checked.**

**A finding in a log is a lead, not a verdict.** It is unreviewed, mid-computation, and possibly wrong, so verify it independently before folding it in, exactly as with a filed report. What the log buys is *time*, not authority.

Each reviewer follows the logging protocol, in its own file: `agent_logs/<task-name>.log`, first line carrying PID and phase plan, a line at every phase transition, a heartbeat at least every ~3 minutes carrying live state rather than a bare "still working", and a closing `DONE <summary>` or `FAILED <reason>` **as the last line written to the file, WITH THAT WORD OPENING THE LINE**, a supervisor reads the end of a log to decide whether an agent is working, so a remark below the closing line makes a finished reviewer read as running, silencing the supervisor rather than tripping it. **THE WORD OPENS THE LINE, AFTER AT MOST A TIMESTAMP**, the test being anchored so that a heartbeat reading `phase3 DONE, still running` is not taken for a closing line. *So `committed <sha>. DONE ...` and `[r921] DONE ...` are both unreadable to it, and a finished reviewer then reads as in flight, which SILENCES the supervisor rather than tripping it: the loop stops with no message.* **AND WHOEVER KILLS AN AGENT WRITES ITS CLOSING `FAILED`**, since an agent stopped mid-turn cannot close its own log and a warm unclosed one reads as work in flight for the whole staleness window. State the log path at launch so it can be tailed. Wait-loops poll PID liveness, and a stale PID with a freshly-modified output file means the work is alive.

## Effort discipline

**Effort escalates by stakes, and the raise is always the user's.** **EVERY LEVEL IS SET IN [.claude/effort-levels.json](../../effort-levels.json), PER LOOP A `main` PAIR, `standing` AND `escalated`, AND A `subagent` LEVEL FOR THE REVIEWERS IT DISPATCHES, AND IS READ THERE RATHER THAN FROM MEMORY.** **Every derivation is attempted at the standing level first. The escalated level is requested only when that attempt is stuck, or when it was refuted at review.** *Stuck* means **at least three distinct approaches, each written into the working note and each ending at a named obstacle**, not a sense that the item matters and not one quick pass that rewrote the object and stopped. Gate 2 is the net for the standing-level attempt. *The refutation trigger stays because failure in derivation work is usually silent: a wrong derivation feels solved, so the attempt that looks finished is audited, and a refuted one is redone at the escalated level.*

**The change is asked for in BOTH directions, and the level is read, never taken on trust.** Before an escalated derivation, state the obstacle the standing-level attempt reached, or the refutation, and what the step will attempt, **WRITE `.claude/effort-expect` (`session: $CLAUDE_CODE_SESSION_ID`, then `class: escalated`) BEFORE ASKING**, then stop until the user has raised it. **WHEN THE TWO LEVELS ARE EQUAL, THE FILE IS STILL WRITTEN AND DELETED, AND NEITHER STOP IS MADE.** **THE MOMENT THE DERIVATION IS ON DISK, DELETE THE FILE, THEN STOP AGAIN AND ASK FOR THE DROP BACK, BEFORE ANY RECORDING, TYPING OR DISPATCH.** [effort_gate.py](../../hooks/effort_gate.py) blocks any tool call whose live level differs from the file's, so both transitions are enforced rather than remembered. *A bare "ok" read as a raise puts route-deciding work on the wrong footing, and a drop back nobody checks bills review at the derivation's rate.*

**THE BASH TOOL CARRIES THE LEVEL OF THE REQUEST RUNNING IT AS `$CLAUDE_EFFORT`.** The settings files record defaults, and the session can differ from them, so the variable is the only source. **Every statement about the level a step ran at quotes the variable's reading**, in commit messages too, where it is later read as evidence about where a result came from.

**A REVIEWER IS DISPATCHED AS `subagent_type: reviewer` WITH `model: opus` IN THE AGENT CALL, NEVER INHERITED FROM THE SESSION.** *A call cannot set a subagent's effort; the [reviewer definition](../../agents/reviewer.md)'s frontmatter does, and [effort_gate.py](../../hooks/effort_gate.py) copies the dispatching loop's `subagent` level into it at every dispatch.*

## The cycle

### 1. Take the open task and solve it, literature first

#### The commit names the cycle's deliverable

Every `feat(` and `fix(` commit carries a trailer, and [cycle_deliverable.py](../../hooks/cycle_deliverable.py) refuses the commit without one:

```
Deliverable: derivation | refutation | dead-end | none
```

`derivation` is an identity, inequality, closed form or reduction, proved **and typed in Lean in the same commit**. *A prose proof that never gets typed is a claim rather than a result*: typing one day of already-audited results found six errors in the record that two independent reviewers had passed. **Deriving in prose first is the right method (you cannot type what you have not worked out), and stopping there is what this refuses.** **A NUMBERED RESULT LANDS WITH ITS LEAN PROOF COMPLETE: ITS OWN STATEMENT TYPED AND PROVED, AND NO `sorry` IN ITS FILE.** *A result numbered with a `sorry` is debt the loop hands to someone else, and the loop that derived it is the one best placed to close it.* **A CLAIM WHOSE PROOF IS NOT YET CLOSED STAYS UNNUMBERED, IN THE WORKING NOTE, UNTIL IT IS.** *`Lean: blocked -- <reason>` names a missing declaration on a commit that numbers nothing.* **THE REASON NAMES A MISSING DECLARATION, AND THE NAME MUST BE ABSENT FROM THE BASE LAYER WHEN GREPPED FOR.** *A reason naming a concept is unfalsifiable prose, and it passes while the layer holds the object under another name. A reason naming a declaration is checkable in one command, by the writer and by every later reader.* **AND A BLOCKER THE CYCLE COULD BUILD IS BUILT IN THE SAME CYCLE, NEVER RECORDED.** *The trailer is for an object out of reach, and out of reach means the layer cannot express it at all, rather than that building it would cost the rest of the cycle.* **So the question asked of every named declaration is whether this cycle could add it, and where the answer is yes the answer is also the work.** *A debt recorded instead is worse than late: nobody re-derives the description, so a blocker written down wrongly stays wrongly written, and the object is usually smaller than the record of its absence.* *Exhortation to look has already failed here, because nothing reads a trailer back and the writer of one is the party least able to see it is wrong.* *An object a layer lacks is usually one contraction or one specialisation from something already in it, since a layer is built for the results it has served and not for the next one, so the trailer is reached by looking and failing, which feels exactly like establishing that it cannot be built.* **The cost of getting this wrong is not the missing file but that everything downstream is briefed on the absence**, and a false premise there propagates into work that cannot detect it. `refutation` is a claim on the record disproved, with the witness that does it. `dead-end` is a route shown unable to work, a fence post. `none` is measurement only: numbers produced, nothing settled. **Three consecutive `none` cycles is refused outright, and so is a run of consecutive `refutation` commits with no `derivation` between them.** *Refutation is the one value that demands no Lean, and the easiest to earn honestly, since every screen that kills a candidate is one. So it is where a numerics ratio escapes while every commit stays correct and every gate passes. Break the run by typing one of them: a refutation that types its replacement carries `derivation`.*

#### A commit that OPENS or REOPENS an item names its search

**A `feat(` or `fix(` commit whose plan item is newly opened or reopened carries a second trailer**, refused by the same hook:

```
Searched: <what was searched> -> references/<slug>/
Searched: none -- <why>
```

**The rule it enforces already exists**, *Search before deriving*, below, is a whole subsection of this step. It gets skipped anyway, and rereading it does not help, for the same reason the `Deliverable:` trailer exists: **every individual step is legal.** Reopening an item is a legitimate act; writing the next derivation is a legitimate act; nothing in between is where a search visibly failed to happen. The omission is only detectable where the item's status changes, which is the commit.

*A record describing an operation in its own words can carry a classical name it has never met, and a single query returns it. The search rarely settles the item; what it does is tell the programme where it is standing.*

**Write `none` when nothing was searched, and let it be uncomfortable.** That is the point: `Searched: none -- assumed no literature exists` is a sentence that has to be defended, and `Deliverable: none` earns its keep the same way. The trailer costs one line when a search happened and forces a decision when it did not.

**`derivation` means an argument, and an optimiser's output is never one.** The word is the whole point of the trailer and it is the easiest thing in the file to stretch: a sweep that establishes a fact *feels* like it derived it, and the commit message can describe the fact in the language of a theorem while the evidence behind it is a sampler and a local solver. Two tests, both cheap, and a claim failing either is `none`:

- **Could the reported statement be wrong if the code had a bug?** A derivation survives its script being deleted. A number does not.
- **Is there a witness or an argument that would make the computation unnecessary?** If a three-line bound, a closed form or a single explicit object settles the same question, the computation was a substitute for thinking and the analytical version is the deliverable.

**The decision that matters happens before the script is written, so that is where the check belongs.** The trailer catches the drift at the commit, by which point the cycle is spent. What actually happens is faster and earlier: a question arises, writing a sweep would answer it in minutes, deriving might not work at all, so the sweep gets written, the question feels answered, and the analytical version becomes owed and never comes. **The trigger to watch for is reaching for code to *establish* a positive claim**, as opposed to screening a candidate, checking a value, or hunting a counterexample, which are what numerics are for.

**When that trigger fires, do this first, before any code.** List the identities the record has *already derived* that bear on the question, and try the argument from them. This is cheap, it is bounded, and it usually works, because the fact needed is generally one the project proved in an earlier cycle and filed. The failure mode it prevents is the expensive one: deriving a structural fact, recording it, and then in the same cycle answering a question that fact settles by writing a sampler instead.

Why a trailer rather than another rule. The rule already exists, at the head of this file: analytical arguments outrank numerical evidence, and numerics never constitute the result. It was ignored across a fifty-one-commit run that produced one derivation, and rereading the skill mid-run did not catch it, because **every individual step was legal**. Writing a script to falsify a candidate fast is exactly what this skill asks for. The drift lives in the ratio, and a ratio is invisible to any per-step check; it is only visible where cycles close, which is the commit.

What it costs and what it does not. Numerics stay fully available as instruments: a run that kills a candidate is a `refutation` or a `dead-end` and passes. What the trailer removes is the option of closing a cycle on numbers while calling it progress, because naming it `none` is then the honest choice and it is meant to be uncomfortable. `docs(`, `chore(`, `refactor(` and `test(` are housekeeping and pass untouched.

#### The plan has three sections, in this order

**[plan.md](../../../plan.md)'s live work is organised as three sections and they are ordered by what each does to a proof.**

| | section | holds | relation to a proof |
|---|---|---|---|
| **1** | **ADVANCE THE PROOFS** | the obligations and the standalone targets, every statement whose proof moves the conjecture | *advances* it |
| **2** | **BUILD WHAT THE PROOFS NEED** | the objects, examples and identities section 1 is missing | *unblocks* it |
| **3** | **DISPROVE** | cheap decisive tests, each able to close an item outright | *prunes* the list |

**A FALSIFIER COMES FROM THE SHARP CONDITION, NEVER FROM THE SUFFICIENT ONE THE ITEM PROVED.** An item that proves *if $X\le c$ then the claim holds* has **not** shown that $X>c$ refutes it: exceeding the bound removes a sufficient condition and says only that this proof stops applying. **Write the *what falsifies it* line from the condition that is actually equivalent to the claim**, and where the item has no such condition, say that it has none rather than promoting the one it has.

**The cost of getting this wrong is a cycle spent hunting a value whose discovery refutes nothing**, and a refutation announced against the programme's central conjecture that is not one.

**Building outranks disproof because a missing object blocks every route at once, while a falsifier removes one.** *A programme whose obstacle is an absence rather than an error will spend cycles refuting claims it could have tested directly, had the object existed.*

**Section 3 earns its place only by being cheap and decisive.** A test that is neither is a measurement, and a cycle closing on measurements records `Deliverable: none`. **Refutations far outnumbering derivations across a cycle is the signal that section 3 has swallowed section 1**, which is a state to detect and correct rather than to inhabit.

#### Name the theorem before starting the item

**Every section 1 item names the theorem it would produce, in one sentence, before any work starts.** Not what it builds, what it would let you *state*. "We would be able to state that the table is independent of $n$ for $n\ge12$" is a theorem; "we would have the 184 covariants" is an inventory.

**An item that cannot name one is not an advance item.** It is measurement, and it belongs in section 3 or below a section 1 item that has a theorem. Construction still gets built when a named theorem needs it, as a section 2 item, which is what section 2 is for.

**This is the trigger the derive-first rule at the head of this file lacks.** That rule fires when a *question* arises and code would answer it faster; it has nothing to attach to when the plan hands over a task already shaped as a computation. A cycle then spends itself building correctly while the route's actual theorem sits unproven and ungraded. *Naming the theorem converts a task back into a question.*

#### Type the theorem before deriving it, and attempt the Lean proof before reviewing it

**The sentence naming the theorem is written again as a Lean statement, with `sorry` where the proof goes.** It is a signature, not a proof: the whole obligation here is that the claim type-checks as a *statement*.

**The reason is that a type refuses what prose accepts.** A sentence may say a radius is $\Theta$ of something without saying for which dimensions, over which directions, or which half of the $\Theta$ is in hand; **a type cannot.** Every hypothesis becomes a binder, every parameter carries its domain, a two-sided bound is visibly a conjunction with two obligations, and a constant is a definition rather than a phrase the reader reconstructs. *Each of those is an argument that otherwise happens at review, and the compiler settles it in the first minute for the price of one statement.*

**Then attempt to discharge the `sorry`, before deriving in prose and before Gate 2.** Where the statement is arithmetic Mathlib reaches, `ring`, `norm_num`, `field_simp` and `nlinarith` close it in minutes, and that attempt is the cheapest falsifier the cycle has: **a claim Lean type-checks can still be false at a boundary, or true only by construction, and a reviewer reading prose sees neither.** A tactic that fails on a false claim hands back the point where it fails, retiring the item before a reviewer is spawned, for a fraction of a Gate 2 round, and with a kernel verdict in place of two opinions. **FINISH THE LEAN PROOF BEFORE GATE 2 WHEREVER IT CAN BE FINISHED**, so the round is one reviewer comparing a kernel-checked statement with its claim and its prose, where finishing it afterwards costs two prose readers and then a third reading the file. **WHERE THE PROOF STALLS ON REAL MATHEMATICAL DIFFICULTY RATHER THAN ON FALSITY, THE PROSE DERIVATION CARRIES THE ITEM THROUGH A TWO-REVIEWER GATE 2 WHILE THE LEAN PROOF IS FINISHED, AND THE RESULT IS NUMBERED ONLY ONCE THE `sorry` IS GONE.** WHAT THIS STEP WANTS FIRST IS THE FALSIFIER; WHAT THE NUMBER WANTS IS THE FORMALISATION.

**Then derive in prose as this loop already does.** The statement stays fixed while the derivation moves, so **a proof that reaches something weaker is visible as a mismatch rather than absorbed into a rewritten claim**, the target was set before its difficulty was known.

**Record the split beside it, in [lean-layer.md](../lean-layer.md)'s vocabulary**: which part the item can establish and which it assumes. *The author knows this while deriving and nobody knows it as cheaply afterwards.*

**Where the base layer has no objects to state the claim with, the item returns `unsupported` and names the missing piece.** That is a result about the item, not a failure of it, and it arrives before a cycle is spent rather than at the end of one.

**AND THE TRIGGER IS A CLAIM BEING RECORDED, NOT AN ITEM BEING STARTED.** *A rule that fires when an item opens has nothing to attach to when a claim arises mid-cycle as a sub-step, which is where most of them arise.*

**SO EVERY GATE 2 BRIEF NAMES THE LEAN DECLARATION THAT TYPES THE CLAIM, OR SAYS WHY NONE CAN EXIST.** *That is where the cost lands: readers are the expensive instrument, and a brief whose checklist asks what the compiler settles has spent them on a `#check`.* **Before dispatching, ask of every item on the list whether the kernel could answer it.** *One such item is one statement's worth of work against two opinions' worth of spend.*

**AND THE BRIEF'S LEAN SECTION IS A TABLE, ONE ROW PER CLAIM WITH A DECLARATION COLUMN, NEVER PROSE. AN EMPTY CELL BLOCKS THE DISPATCH**, and is filled with a declaration name or with the reason no declaration can exist. *The rule above was already stated and was violated in writing three times, because one sentence naming six untyped claims at once reads as disclosure and passes the eye, while six empty cells do not.* **Typing is the only check the kernel performs, and it is cheaper than the readers it replaces**, so the gap is made visible per claim at the moment those readers are spent.

#### Grade section 1, sort by grade, then take the top item

**Section 1 is sorted by a written grade each cycle, and the grade is recorded beside the item.** An order carried over from an earlier cycle decays: items get written down where they arose rather than where they rank, results change what each is worth, and "take the top unchecked item" then executes a stale judgement faithfully. **Grading is what stops that, because a number has to be defended and a position does not.**

**The grade has three factors, and the first is a gate.**

| factor | scale | |
|---|---|---|
| **Closes** | $3$ the REMAINING OPEN STATEMENT outright · $2$ a named step on a path to it · $1$ a sub-step of such a step · $0$ anything else, **including repairing the support under a result the record already carries** | **a $0$ here caps the item at the bottom whatever else it scores** |
| **Attackable** | $3$ a route exists and is untried · $2$ a route exists and is partly spent · $1$ a route must be invented · $0$ every named route is closed | this is where a plan lies to itself most easily |
| **Margin** | $2$ a factor of two or more of room · $1$ some slack, **and intrinsic sharpness scores here** · $0$ saturated on a family *wider* than the conjecture's own equality set | scoring the goal's own sharpness as $0$ zeroes every route at once |
| **Moves** | **settles** a named node · **splits** a named node into parts, at least one attackable · **adds** a node on a path to the goal, with its edges · **none** | a *none* here moves the item to section 2, whatever else it scores |

**THE REMAINING OPEN STATEMENT IS NAMED AT THE HEAD OF SECTION 1, AND `closes` IS MEASURED AGAINST IT ALONE.** *A programme whose reductions are done has one statement left, and an item off every path to it closes nothing, however real the gap it repairs.* **So securing what is already proved scores $0$ and LEAVES section 1**, as the verification loop's work, filed in [plan-verification.md](../../../plan-verification.md). *The failure this prevents is a section 1 of honest items at a respectable grade while nothing on the list can reach the goal, which no per-item check can see because no item is wrong.* **When the top of the graded table does not touch the open statement, the cycle's next action is to invent a route rather than to work the top**, and inventing one is step 9.

**Name what each item does to the map of the proof, and check it against that map rather than against the other items.** The other factors compare items with one another, so an entire section can grade well while every item is a sub-step of the *same* node: the list is then correctly ordered, honestly scored, and structurally unable to reach the goal.

**Three answers count as moving the map, and the second and third are how a programme escapes a stalled one.** *Settling* a node is the obvious one. **Splitting** a node names its parts, and earns its place when at least one part is attackable while the whole was not, a node nobody can start is often two nodes, one of which someone can. **Adding** a node proposes a new path, which is what a literature sweep is for and what a plan is entitled to do: a route the field already has, or a decomposition nobody had written down, arrives as a new unproven node and is a real advance before anything about it is proved.

**A SPLIT NEVER REPLACES THE TOP ITEM.** While the top item's `attackable` is 1, the cycle's work is inventing its route: step 9, aimed at that node. A lower-graded piece split off a sibling branch waits until the top item has a method or is blocked.

**An added or split node comes with its edges (what it needs and what it feeds) and must lie on a path from the problem to the goal.** That is the whole discipline, and it is checkable rather than rhetorical: a node with no incoming edge, no outgoing edge, or no path to the goal is not on the map, however promising it reads. *Without it, "adds a node" is the answer every item can give and the column stops filtering anything.*

**An item that does none of the three is a build item by definition**, it belongs in section 2, which exists for work that unblocks, and section 1 keeps only what moves the map.

*The failure this catches is invisible to every per-item check, because no item is wrong.* A plan can carry a full section of live work in which each item names a real theorem and closes a real named step, while the steps that would close the problem outright carry no item at all, nobody chose that, and nobody could see it, because the grade never asked what the item did to the map. **The question is one column and it is asked of every item, every cycle: work this, and what changes on the map?**

**A fourth factor gates the other three: *analytic*.** $1$ if the item's route ends in a statement a reader can check by hand; $0$ if it ends in a machine certificate. **A $0$ here caps the item's value at zero**, exactly as *closes* does, a route that cannot produce a readable proof is not advancing the goal, however much method it has. *An item may still be worked at $0$, but only as an explicit choice the user makes, recorded in the plan with the reason. It is never taken by ranking.*

**A LEAN PROOF CAN STILL BE A MACHINE CERTIFICATE.** Where its key step is a certificate (a large polynomial or sum-of-squares witness, an interval subdivision, `native_decide`, a decision procedure run over boxes), *analytic* scores that step as a certificate. The kernel checking it makes it correct, and a reader still cannot follow it.

**Value is the product, not the sum**, so a zero anywhere sinks the item, which is the intended behaviour, since an unattackable obligation and a proof of nothing are both unworkable however important they look.

**Score *closes* on the item's warrant, not on its ambition.** An item whose reach depends on a recorded claim inherits that claim's label: if the claim is *measured* rather than *proved*, the item closes only what it closes without it. **And the claim then outranks it**, an unproved warrant is a higher-value item than anything standing on it.

**Grade honestly on *attackable*, because that is the factor a plan inflates.** An item whose every named method is closed scores $0$ there and belongs below one that is less important and actually has a route. **Recording it as "open, the hard thing" and leaving it on top is how a cycle spends months on a statement it cannot start.** Such an item stays on the list (as the destination, marked *no route known*) and the work goes to whatever can move.

**Margin is what makes an inequality provable, and it is measurable before any work.** A statement saturated on the family it must cover admits **no lossy step anywhere**: every estimate must be exact across that whole family, so only a structural proof can work. A statement with a factor of two of room tolerates crude estimation. *A programme can spend many cycles on its zero-margin statement while its large-margin one goes untouched.*

**Score margin against the conjecture's own equality set, not against zero, otherwise a sharp conjecture zeroes its every route by construction.** When the goal is an equality at some configuration, *every* route to it inherits that sharpness, so grading each route $0$ on margin empties section 1 and the rubric reports that nothing is worth doing. That is a defect of the scoring rather than a fact about the problem. **Intrinsic sharpness scores $1$**; $0$ is reserved for an item saturated on a family *wider* than the goal's equality set, which is genuine extra difficulty the item took on itself. *The symptom to watch for is every item scoring $0$ on the same factor: a factor that never varies is measuring the problem rather than ranking the work.*

**Four checks, each cheap and each able to zero a factor outright.**

- **Is it stated over the object the theorem is about?** A conjecture about a maximiser is not one about every critical point, and the difference is second-order information: criticality is one equation, maximality adds a definite Hessian. A supremum over the whole critical set proves something strictly harder than required.
- **Is it already settled on the class it can reach?** When the target is a theorem on every point the programme can construct, work there is measurement of a finished region, *closes* drops to $0$.
- **Does the hypothesis it adds survive contact with the unknown object?** A repair is only worth having if the application can verify it on the thing it is applied to. A maximiser supplies its own value and its own criticality; it does not supply a support or a frame.
- **Has an external result or a handoff removed it?** An item pursued elsewhere is recorded as handed off rather than graded, so it stops absorbing attention.

**One re-ranking is the user's and not the cycle's.** The preference for derivation over computation, stated at the head of this file, ranks routes that reason from examples above certificate-style methods (an invariant decomposition, a sum of squares in a representation) that never inspect an individual point. That ordering is right in general and **inverts when the programme's recurring error is example-driven reasoning**, because such a method cannot be misled by a symmetric catalogue. A cycle that finds itself there says so in the plan, names the route and its cost, and **leaves the decision to the user**: reordering the standing priorities overturns a rule this file exists to enforce.

#### Name every borrowed quantity's DOMAIN before the route is graded

**A route that reuses a recorded quantity states, for each one, the set on which it is defined and the hypotheses it was proved under, before the grade is written.** One line per quantity. A route whose mechanism evaluates a quantity outside its domain is refused at the grading step, not discovered at the audit.

*This is the single most expensive recurring error available to a mature programme, because the record is exactly what a good route is built from.* A quantity that has survived Gate 2, carries a closed form and appears in three findings files reads as a fact about the whole space; it is almost always a fact about the family it was derived on. **The failure is silent: the mechanism composes, the arithmetic checks at the points where both objects exist, and the route dies only when a reviewer asks where the quantity lives.**

Four route generations died this way in one programme, each on the same shape and none caught by the grade:

- a conversion factor taken without noticing it requires **two or more pieces**, then applied to a residual defined by having one;
- a hypothesis chosen **for its generality**, then used as though it were the stronger condition it replaced, because only the stronger one supports the argument;
- two quantities borrowed from a lemma that defines them **only on a subfamily**, to build the very argument meant to reach outside it.

**The check costs a line each and fires before a cycle is spent.** For every quantity the route names: *where is it defined, what was assumed to prove it, and does the route's mechanism stay inside that?* Where the answer is "the record does not say", that is itself the finding, a quantity whose domain nobody wrote down is not yet usable, and establishing it is a real item.

**Section 1 opens with a grading table**, one row per item, columns `item · moves · closes · attackable · margin · analytic · value`, sorted by value, so the next item is read off rather than argued for. **Write the grade beside each item as well**, as `closes × attackable × margin × analytic = value`, naming what it moves alongside, so the next cycle inherits a judgement it can argue with rather than an order it must guess at. **When the `moves` column reads *none* down the whole table, say so plainly and stop**, an empty section 1 is a finding about the plan, and the next action is to add or split a node rather than to work the top of a list that cannot reach one. *Sections 2 and 3 are ordered by cost rather than graded: what unblocks the most for the least work comes first.*

**A stop condition that fires on one item stops that item, never the cycle.** A stalled item (three cycles without a deliverable) or one blocked by a standing rule is split out, moved to `BLOCKED` with the sentence that would unblock it and what each outcome would decide, and the cycle continues at the next item. **`BLOCKED` is a fourth section below the three**, holding items whose next step is unavailable rather than unattempted. *The stop condition covers a stalled cycle (nothing left to take) and a cycle with a live section 1 is never that.*

Read [plan.md](../../../plan.md) in full. Regrade section 1, sort it by value, and take its top item, dropping to section 2 when the graded top is blocked on a missing object, and to section 3 only when a test is cheaper than the work it would save.
#### Search before deriving

**Search before deriving. This is the rule the project has paid for twice.** In order:

0. **Search THIS REPOSITORY first, the record, the references already filed, and the scripts.** The outward search is step 1 below and it is the one that gets done, because reaching for the literature feels like the diligent move. *A cycle once searched the web for an operator identity, filed a new source for it, and recorded it as the handle a fence post demanded, while the formula sat implemented in a script in this repo and stated in two papers already filed in the references directory.* **A `Searched:` trailer naming an outward search is satisfied by that cycle and the rule still failed**, because the gate asks whether a search happened rather than whether it looked where the answer was. Grep the scripts for the object's own formula, not for the project's name for it; a thing already built is named by its indices, not by the prose around it.

1. **Search** the specific statement, the objects it involves, and the names attached to them, the authors already in [references/](../../../references/) are the starting list, and their citation graph forward is the next. Search recent arXiv listings too; an open problem usually has live work around it.
2. **Store what you find** under [references/](../../../references/) before reading it. One subfolder per source, slug-named, see the layout below. A source consulted and not stored has to be found again next cycle. **Confirm the download is the document before storing it**: publishers behind a bot filter answer a command-line fetch with an HTML challenge page carrying a `.pdf` name, and it reaches the index looking like a source. Check the file type and that extraction yields the paper's own text; when a host refuses, record the refusal and find another copy rather than keeping the placeholder.
3. **Read the actual theorems, hypotheses and proofs.** Extract with `pdftotext -layout`, grep for statement numbers, then **transcribe what you found into `notes.md` in that subfolder**, the extraction is worth keeping in readable form, and doing it while reading costs nothing extra. An abstract or a search-engine summary is not a reading; treating one as a reading costs a full cycle re-deriving what the source already contains.
4. **Apply it.** Check every hypothesis against the case at hand. A dimension restriction is frequently the author's scope rather than the method's limit, census the supporting results and find which comparison actually binds before concluding a theorem fails outside its stated range.
5. **Derive only what the literature genuinely lacks.** When deriving something already published as an independent check, label it confirmation rather than discovery.

**The search covers the ambient structure, not only the statement being proved.** A search aimed at the claim itself will miss the decomposition of the space it lives in, the classification of the group acting on it, the branching rule for the subgroup, facts that are usually older, better known and more likely to be published than anything about the claim. Those are also the facts that convert a computation into a proof, because they supply the hypothesis a structural theorem needs. Before computing an invariant of an object, search for how that object's ambient space breaks up.

**Search again once the derivation has a shape, because the first search could not name it.** The rule to search before deriving assumes the object can be described in advance, and often it cannot: what a cycle produces is an operator, an identity or an invariant whose standard name only becomes visible after it exists. That is not a reason to skip the second search, it is the moment the search finally has usable terms. **When a derivation yields something with a recognisable form, an operator built from a known structure acting on a known module, an identity between standard invariants, search for it under the name of that form before recording it as new**, and pin the attribution to the numbered statement that actually contains it rather than to a nearby one. A published result claimed as new is the most damaging kind of error in a write-up addressed to the person who set the problem, and it is caught by one query.

#### Classify against the record before calling anything new

**WHEN A VALUE LOSES A ROLE, RENAME IT IN THE SAME EDIT TO WHAT IT ACTUALLY MEASURES.** A withdrawal that says only what a number is *not* leaves the old string matching the old slot on every later search: a reader greps the symbol, finds it, and reads the surrounding text as history about that quantity rather than as notice of a different one. **So state the quantity it *is*, give it a distinct name, and let the old name resolve to nothing.**

**A number can be refuted in a role repeatedly, each refutation recorded, and be used in that role again**, for as long as it keeps the name the role gave it.

**SEARCH BY THE OBJECT, NEVER BY THE VOCABULARY THAT NAMES IT.** The record is filed by claim and the letter is the least stable thing about a quantity, so **query by the defining relation or the value, and by the pair *what is bounded* and *what it is bounded from***, not by the symbols the new argument happens to use. *A fence post is written in the vocabulary of the route it closes, and a successor arriving by a different road brings different words.* **The cheapest form of this, and the one that catches the most: before recording into a file, read that file's own fence posts.**

**The failures this prevents are invisible to a search by spelling**: a quantity reported absent while defined under another letter in the same file, a result recorded as new while the record holds it a few lines away, and two questions that turn out to be one system read at two rows.

**Re-derive freely, then classify the result against the record before writing it up.** Deriving something the record already holds is *not* waste: it is independent verification, the same thing a cold reviewer supplies and far cheaper. The defect is never the derivation; it is skipping the classification step afterwards. **A check tests truth, not novelty.** Having derived a statement, grep the record for it (**by the numbers it produces**, since objects get renamed constantly and a $\theta$ never does) and then say which of three things happened:

- **Agreement.** The record already had it, and a second route reached the same place. Record *that*, cite the existing proof, and note the new route as corroboration. This is a good outcome and must not be written up as novelty.
- **Discrepancy.** The two disagree. This is the most valuable outcome available and the reason re-derivation earns its keep, exactly one side is wrong, and finding out which is the next task. Do not resolve it by preferring the fresh work.
- **Genuinely new.** Nothing in the record covers it. Only here does "proved" belong in a commit message.

**Read the file you are about to write into, before you derive.** The classification rules above are applied to the *record* as an abstraction and skipped on the one file the work is going into, which is where the answer usually sits, because a subject's findings file is precisely where its identities were recorded last time. **Grep that file for the statement before deriving it, not after.** **AND GREP IT FOR A BOUND ALREADY DERIVED ON ANY PARAMETER THE NEW ARGUMENT FIXES: A PARAMETER THE FILE HAS BOUNDED TO A RANGE IS CARRIED AS THAT BOUND, NEVER RE-FIXED AT AN ENDPOINT.** *Both passages are individually correct, the author remembers deriving the bound and does not re-read it, and the Lean carries the same assumption as a named hypothesis reading as a side condition, so a `sorry`-free file certifies an argument whose premise is its conclusion.* *A programme has re-derived the same published trace identity three separate times while the target file said, in its own words, that the identity was already there and had been re-derived once before.* The cost of the grep is one command; the cost of skipping it is a cycle written up as discovery and then retracted. **READ THE DESTINATION'S SECTION ON THE OBJECTS THE NEW BLOCK USES, NOT ONLY THE BLOCKS EITHER SIDE OF THE INSERTION POINT.** *A file states what its results rest on in a passage headed by the objects' ROLE, which a grep for the statement never reaches and which is where the collision usually is.* **AND BEFORE OPENING A PLAN ITEM, GREP THE PLAN AND THE FINDINGS FOR THE THEOREM'S OWN OBJECT**: a hit means the item is that one, and a duplicate item arrives under a new name, which is why it looks new.

**And when the record says a result was already re-derived, that is a warning about the next cycle, not a closed incident.** A note reading *"re-derived unwittingly"* marks a statement that is easy to reach independently and therefore easy to reach again. Treat such a note as an index entry: it names exactly the results most likely to be rediscovered, so a cycle working nearby should read them first.

**Check the scope, not just the statement.** A re-derivation that agrees on the claim but disagrees on its hypotheses has found a discrepancy, and the wider version is the suspect one. *Four times in two days this project re-derived a recorded result and mislabelled the outcome: twice reaching a counterexample to a claim being written in the same session, and twice reporting an existing theorem as newly proved, once while a stronger, unconditional form of it stood four paragraphs below in the same file, and once widening $p,q\ge3$ to $p,q\ge2$, where the multiplicity list provably overcounts.*

**A screen that dismisses a recorded item must quote it and name the distinction.** Retrieval is rarely the failure, the killing line is usually found and then waved through, as "a different quantity" or "a different regime", without saying *which* quantity or *which* regime. That phrase is where a refutation already in hand gets lost, and it costs the same as never having looked. **So a dismissal is written as a comparison: the item's own words, the claim's own words, and the difference between them.** If the difference cannot be named in a sentence, the item has not been screened.

**Search the project's own record before calling anything new, and search it by number.** The literature rule is applied faithfully and the same discipline is skipped on the record itself, because a long file feels like something already known rather than something to query. It is not: by the time it holds a few hundred results nobody remembers its tables, and a result can be rediscovered, written up as new, and sent to review without anyone noticing. **The reliable query is the numeric value** (a $\theta$, a dimension, an excess, a multiplicity) because prose describing the same object varies while the number does not. **The value table in [findings/INDEX.md](../../../findings/INDEX.md) exists for exactly this**: check the number against it, then `grep -rn "<value>" findings/` to confirm. Do it before the write-up, not after, and when a result produces a $\theta$ the table does not carry, add the row in the same edit.

#### The checks a claim passes before it is written down

**The reasoning behind step 1's checks lives in [argument-practice.md](argument-practice.md)**, what a claim rests on, a structural claim read off computable points, quoting conventions rather than restating them, where an argument goes wrong, what to establish before believing a bound, evidence or a narrowing, and argument hygiene. Consult it when a claim is about to be recorded; it is reactive, and the loop's mechanics do not depend on it.

#### When a run is justified

**When a run is genuinely justified, the operational rules for making it correct are in [computational-practice.md](computational-practice.md)**, job registry and how to kill what it cannot see, timeouts, progress, generic parameter values, null controls, testing a projector off its subspace, constants by ascent rather than sampling, script indexing and directory layout. Consult it then; it is reactive and confers no licence to compute.

Before writing anything down, pass **Gate 1** yourself: (a) reproduce an already-trusted value with the same code path; (b) reach the number a second way, ideally sharing no code; (c) screen the object's validity (Ricci-flat, first Bianchi, criticality residual, unit norm, spectral gap at zero) checked rather than assumed; (d) check the value against known ceilings, treating any breach as a bug until explained. State which of (a)–(d) the result passed. A result failing Gate 1 is not recorded.

#### references layout

```
references/<slug>/
  README.md          link, authors, arXiv id and version, date retrieved,
                     what it was consulted for, which numbered statements matter,
                     and the verdict, what it settled, what it does not cover
  notes.md           the extraction, transcribed into readable markdown
  <paper>.pdf        the source as retrieved
  <paper>.txt        pdftotext -layout output, for grepping
```

Whenever a PDF is put through an extraction tool, the result is transcribed into [notes.md](notes.md) in the same subfolder. The `.txt` dump is for grepping and reads badly; [notes.md](notes.md) is what a later cycle actually opens. Transcribe into it:

- Every numbered statement that matters, verbatim, in LaTeX (theorem, proposition, lemma, remark) carrying its number and **its full hypotheses**, dimension ranges included. **IN ONE SHAPE, `> **Theorem 1.2.** <statement>`**, a blockquote opening with the bolded kind and number. *[INDEX-literature.md](../../../findings/INDEX-literature.md) is generated by matching it, so a statement written another way is invisible to the screen that reads that index first: two shapes were in use and the narrower reading reported half the shelf as never transcribed.*
- The proof of anything the project depends on, at the level of which estimate binds and where, rather than a summary of what the proof is about.
- What each proof cites, so the citation graph can be walked from here.
- The page or section number each item came from, so it can be checked against the PDF.

Extracting a paper and leaving only the raw dump means the next cycle re-reads the paper. Transcribe once, and the [notes.md](notes.md) becomes the working copy, quotable in [findings/INDEX.md](../../../findings/INDEX.md) and [results.md](../../../results.md) without reopening the source.

The subfolder README stays short: it is the index card, what this source is, what it was consulted for, and the verdict. The mathematics lives in [notes.md](notes.md).

### 2. Adversarial review by an independent agent

Every new result goes through **Gate 2** before it counts. This is not optional and does not need a fresh request from the user, it is part of producing the result.

**Spawn one agent or two on the same brief, each to break the result, and the count is decided by one question: is the round checking an argument, or comparing text against something already fixed?** *Two where the argument is being made, since two readers sample a wide distribution of reasoning errors and rarely find each other's. One where the comparison is a single act, a Lean file against the result it claims, an index row against the declarations it names, a fold against the findings it answers, a hook against the behaviour it asserts, because there two readers perform it identically and report it in different words.* **The rule and what a lone reviewer's finding is worth are under [the agent budget](#the-agent-budget-one-or-two-both-at-step-2) above.** Give them identical claim lists and identical hypotheses to attack; the independence comes from their implementations, not from their instructions. Number them as consecutive reviewers, and give each its own log and report path so neither overwrites the other.

The brief:

- It works from the mathematical definitions in the [findings/](../../../findings/) file that owns the claim, and the claim under review.
- It **argues from the definitions** and does not import the code under review. Where a number is genuinely needed to refute a claim, it computes the smallest one that does the job and says why the argument could not.
- It hunts for the counterexample, the missing hypothesis, the tautology, and the case the claim quietly excludes.
- It returns a verdict of CONFIRMED, PLAUSIBLE or REFUTED with corrections.
- It logs to `agent_logs/<task-name>.log`: first line with PID and phase plan, a line per phase transition, a heartbeat carrying live state at least every ~3 minutes, and a closing `DONE <summary>` or `FAILED <reason>`. Announce the log path at launch. Wait-loops poll PID liveness rather than a bare sentinel.

**A brief states the claim to be attacked, never the author's explanation of why it holds.** Writing "a suggested reading" of *why* a result is true, or why a refuted claim failed, hands the reviewer the author's own reasoning at the one moment independence is the whole point, and that reasoning is the least tested thing in the cycle, since it was written after the result and never checked against anything. Two reviewers on identical briefs will both inherit it, so the agreement it produces is worthless. Give them the statement, the definitions, and the places it is most likely to break; keep the diagnosis out.

**What the author believes about the claim goes in as a question with its premise, or stays out.** That covers a suspected flaw, a property a step lacks, and what the claim would settle. Name the step and leave the property to the reviewer.

**When two reviewers disagree, ask what question each answered before asking which is wrong.** The instruction to run a disagreement down to which implementation is right assumes they tested the same statement, and they often have not: one measures whether a quantity *predicts* the target, the other whether it *constrains* the target, and a claim phrased loosely admits both readings. Both verdicts can then be correct and the claim still wrong, in a way neither reviewer stated. Recover the two questions first, the reconciled statement is usually sharper than either verdict, and it is the thing to record.

**Reconcile before recording.** Where both reviewers reach the same verdict on a claim, record it with that verdict. Where they differ, the claim is unresolved until the difference is settled, run the disagreement down to which implementation is right, and say in the record what the disagreement was, since a claim two auditors read differently is one a later reader will too.

Each verdict lands in [reviews/INDEX.md](../../../reviews/INDEX.md) as a numbered reviewer section, titled `### Reviewer N: <what was audited>` with `N` the next integer and the title naming the specific claims rather than the topic. Reviewer numbers are permanent addresses cited from [plan.md](../../../plan.md), [findings/INDEX.md](../../../findings/INDEX.md) and [results.md](../../../results.md), so they are never reused or renumbered.

**Cite a reviewer as `r257`, never as a bare number**, in chat, in commit messages, in the plan and in the findings, on every mention rather than only the first. Reviewer indices run in the high hundreds and collide with every other integer in play: dimensions, multiplicities, block counts, the value of $n$. *"256 found" and "256 blocks" differ by one keystroke and by everything else*, and a reader scanning a findings file cannot tell which was meant. The `r` makes a citation unambiguous at a glance.

**A REVIEWER COMMITS A SKELETON REPORT IN ITS FIRST PHASE AND UPDATES IT, RATHER THAN WRITING ONE AT THE END.** *A round ends whenever the user speaks, an interrupt being their only channel mid-turn and killing every agent in flight, so a report written last is the thing most likely never to exist.* **THE ARGUMENT IS THE ASYMMETRY, NOT THE FREQUENCY**: a skeleton costs one commit and losing a round costs the round. **The first commit is the title, the claim table with every verdict `NOT REACHED`, and the log path**, and each phase overwrites one row. *One commit buys that a cancelled reviewer is a partial finding rather than a ghost.*

Salvage a stopped reviewer's log. **STOP THE AGENT FIRST, THEN RUN `python3 scripts/lib/salvage_reviewer.py N --stopped`**, which writes `reviews/REVIEW_rN.md` as a **PARTIAL** report carrying the log verbatim. *The order is that way round because the salvage CLOSES the log, and a closed log tells the supervisor the reviewer has finished: run on a live agent it reports a working reviewer as dead and the round is folded without it.* **NOTHING THE TOOL CAN READ DECIDES WHETHER AN AGENT IS ALIVE**, gaps in live logs running past half an hour, so the flag is an assertion the caller makes and the tool refuses without it. A log is the only durable trace of work in flight: three reviewers were lost in one session, one of them three hours in and holding an independent confirmation. A partial is not a verdict and nothing in it may be cited until rebuilt.

**A reviewer reads the written chain link by link, and rebuilding the number is a second job rather than a substitute.** A conclusion can be correct while the argument for it has a hole, and **re-deriving the same constant by a different route cannot see that hole**, it confirms the number and leaves the proof unexamined. So a review that agrees on every figure has checked the arithmetic and none of the reasoning.

**Search by the object, never by the vocabulary that names it.** A result already on the record is filed under whatever subject its author had in mind, and a search by name misses it. **The distinctive constant is the reliable key**, grep for the coefficient before reporting a derivation as absent.

**A reviewer's numbers are not evidence until they are rebuilt from the object's own definition.** Reviewer 78's values for three complex quadrics were wrong, matched a recorded family to nine digits by coincidence, and reached the record for a commit before a second reviewer caught them.

A reviewer with a standalone `REVIEW_rN.md` still gets an index row and a section here. Filing only the standalone file leaves the reviewer invisible to anyone reading [reviews/INDEX.md](../../../reviews/INDEX.md) top-down, which happened to nine reviewers at once, including rounds that overturned more than twenty recorded claims. Before closing step 2, check that every `REVIEW_r*.md` is linked from the index.

Index any scripts a reviewer leaves behind when the verdict lands, not at commit time. *A review that needed no script leaves none, which is the normal case.*

Take REFUTED seriously and PLAUSIBLE literally, a reviewer that confirms everything was briefed wrong. If the reviewer is itself mistaken, say so with the reason and record the exchange rather than silently overruling it.

#### A FILED VERDICT IS EVIDENCE, NOT AUTHORITY, reproduce it before applying it

**Every reviewer finding is validated independently before it changes the record, and the commit says how.** A filed report reads as settled in a way a log line does not, and that is the whole danger: it arrives with a table, a witness and a script, and applying it feels like diligence. *Six consecutive Gate 2 rounds were once folded in verbatim (every verdict, including retractions of proved results) with not one finding reproduced.*

**The asymmetry is what makes this expensive.** A reviewer's CONFIRMED costs little if wrong: the claim was already on the record and stays. A reviewer's **REFUTED** rewrites the record, retracts a result, and closes a route, and nobody reopens a closed route to check. **So a refutation carries the heavier burden of proof, not the lighter one**, and the instinct runs the other way because a refutation feels like the humble reading.

**Validation is cheap and its absence is invisible.** Reproduce the finding by a route that shares nothing with the reviewer's, its own script re-run is not a validation, it is the same computation twice. Where the finding is an identity, check it symbolically or at a size where it is closed-form; where it is a measurement, compute the same number a different way; where it is a citation, read the cited page.

**Two failures to watch for, both seen:**

- **A true statement that is trivially true.** *A reviewer reported $\langle\Lambda^4(M^\#),M\rangle=0$ and a cycle read it as closing a route. It holds for **every** tensor in place of $M^\#$, being orthogonality of the decomposition against a Bianchi-free $M$, it says nothing whatever about the operation under study.* Ask what the finding would look like if it were vacuous, and check that it is not.
- **A finding that overreaches its own evidence.** A verdict stated for all $n$ and measured at one, or stated for a family and tested on its smallest member, is a finding about what was tested.

**Record the validation in the commit that applies the verdict**, one line naming what was reproduced and by what independent route. A verdict applied with no such line is a verdict taken on faith.

**The verdicts already applied unvalidated are a debt, and it is carried in the ledger beside the Gate 2 debt.** Adding the rule fixes the next verdict and leaves every earlier one exactly as it was, *applied, load-bearing, and unchecked*. Those are not harmless: they include retractions that deleted proved results and closures that removed routes from the plan, and each is now cited by later work as though settled.

**So [plan.md](../../../plan.md) carries a *validation owed* line naming every applied-but-unreproduced verdict**, worked off at the rate of one per cycle at step 3, refutations first because they are the ones that cost. A verdict that fails validation is reopened with the same weight the original refutation was given.

*This is the same shape as the Gate 2 debt ledger and exists for the same reason: an unchecked claim that nobody remembers is unchecked gets treated as checked.* **The difference is that a Gate 2 debt is visible as an absence (no reviewer) while a validation debt is invisible, because the review exists and reads as authority.**

Check the ledger at the head of every cycle, not only when adding to it. A run of cycles that each produce a small result is where the gate quietly stops being applied: no single one feels large enough to warrant an agent, and the debt accumulates invisibly. Reading the ledger before step 1 makes the omission visible while it is still one cycle old rather than five.

Keep a Gate 2 debt ledger. If budget forces a review to wait, mark the affected section **Gate 2 pending** and cite it nowhere as settled, and carry a running *still owed* line in [plan.md](../../../plan.md) naming every result awaiting audit. The ledger is what stops a pending marker from ageing into an assumed result: a claim nobody remembers is unreviewed gets treated as reviewed. Anything single-authored since inception belongs on it too.

### 3. Record the status quo in findings/INDEX.md, the attempt in ATTEMPTS.md

**A ROUTE CLOSED IS FILED BEFORE THE NEXT ITEM STARTS, AND A COMMIT MESSAGE IS NOT FILING.** This is the step most often skipped, because closing a route feels like the result and writing it down feels like clerical work after it. It is not: a fence post that lives only in a commit message is invisible to the next plan, to every reviewer brief, and to the search that would stop the route being reopened. *A cycle once ran step 2 eleven times and this step once, leaving four route closures in commit messages alone, two of which were not even in the plan, and all four of which would have been lost by rewriting it.* **The test is mechanical: after each Gate 2 verdict, the closure is in [fence-posts.md](../../../findings/fence-posts.md) with what a new attempt must clear, and indexed in [findings/INDEX.md](../../../findings/INDEX.md), before any new work begins.**

Two files, two clocks. The cycle's output splits by whether it describes the present or the past:

| | [findings/INDEX.md](../../../findings/INDEX.md) | [ATTEMPTS.md](../../../ATTEMPTS.md) |
|---|---|---|
| Answers | What is true now | What was tried, and how it went |
| Organised by | Topic | Chronology |
| On a correction | The old text is **replaced** | A new entry is **appended** |
| Read by | The step 2 reviewer, [results.md](../../../results.md), the next cycle | Anyone asking whether a route was already walked |
| Grows | Slowly, and shrinks on refutation | Forever |

Both get written every cycle. The attempt entry says what was tried, what it cost, and what came of it, including the routes that failed, which is the whole point of keeping it.

#### The record is an index plus one file per subject

[findings/INDEX.md](../../../findings/INDEX.md) is an **index** and carries no mathematics: what is settled, which file holds which subject, every catalogued $\theta$ by value, and every fence post, one line each. The findings themselves live in [findings/](../../../findings/). The split exists because the record reached 423KB as one file, at which point a cycle either read all of it or grepped it blind.

Reading. Read the index in full (it is the one file a cycle must) then open the single findings file it names for the subject in hand. Opening three because they sound relevant defeats the point.

**A quoted sentence's hypotheses are the ones inside it.** A scope clause in the neighbouring sentence governs what that sentence says, not what this one does, and grep returns the claim without it.

**Count the sites before replacing and after.** A correction reaching one copy of several leaves the record asserting both, and the copy that survives is the one the next reader meets.

Writing. Fold the new result into the findings file that owns the subject, **at the topic it belongs to** rather than at the end, with its Gate 1 evidence, its Gate 2 verdict and its citations. **A result that earns a number gets a `#### Lemma N, <name>` block there and a row in [findings/INDEX.md](../../../findings/INDEX.md)**, which owns the numbering: take the next free number that index reports, never the next number this file happens to use. *Two documents once assigned the same number to different results because each read only its own sequence.* Then [results.md](../../../results.md) carries the statement and a `**Proof:**` pointer to that block, and the report adopts the number. Then update the index if and only if one of these changed: a headline status, a new catalogued $\theta$, a new or corrected fence post, or which file owns a subject. **A finding written into the index instead of a findings file is a bug**, the index stays scannable only because it holds pointers.

**A result is numbered in the same change that lands its complete Lean proof**, step 1's rule: its own statement typed and proved, no `sorry` in its file. So it reaches [findings/INDEX.md](../../../findings/INDEX.md) and the build together, and a claim still waiting on its proof stays unnumbered, in the working note. **The layer is described once, in [lean-layer.md](../lean-layer.md); how to write a file is [lean-practice.md](../lean-practice.md).**

**A `Lean: blocked` trailer names an obligation, and that obligation becomes an item in the same cycle.** *The trailer records the debt at the point the claim is held back from numbering, which is what makes it visible at all. Nothing reads a commit message back, so disclosure on its own leaves the blocker unscheduled while further work is built on the unnumbered claim.* **WHAT REACHES [plan.md](../../../plan.md) IS WHAT THE CYCLE COULD NOT BUILD, AND IT REACHES IT AT ONCE**, carrying the judgement a generator cannot produce: which parts are finite, which are classical, and what closing it would free. *A conditional theorem is real work and the record keeps it; the item is what stops the condition outliving everyone who remembers it.*

**Four indexes are load-bearing and must never fall behind.** [findings/INDEX.md](../../../findings/INDEX.md) is the first: every numbered result, its kind, a short name and the file holding it. **It owns the numbering**, so a result missing from it has no number anyone may cite. The other three are rows in this file:

- **The value table.** Every $\theta$ at a catalogued critical point, with the file that holds it. This is what makes the query-by-number rule work; a value missing here is a refutation waiting to be re-derived.
- **The fence-post table.** Every post, with where each was established, and its own count stated in the index rather than here. A route one of them kills is the most expensive kind of proposal, because it looks new.
- **The status table.** One row per half of the problem, so the head of a cycle can see the position without opening anything.

Links inside [findings/](../../../findings/) point one directory up: a link to the plan is `../plan.md`, to a script `../scripts/x.py`, to a source `../references/slug/notes.md`.

**Corrections are applied in place, never appended.** A section headed `CORRECTION:` is a symptom: it means the refuted claim is still upstream, unmarked, where a top-down reader hits it first. Edit the original section to say the corrected thing, and if the correction itself carries a lesson, state it there in one positive sentence. The full history of the reversal belongs in [ATTEMPTS.md](../../../ATTEMPTS.md) and [reviews/INDEX.md](../../../reviews/INDEX.md), which is what those files are for.

**Delete boldly: a refutation's output is a deletion, and the file ends up smaller.** Anything the cycle refuted comes out, the claim, the reasoning that supported it, and every downstream statement resting on it. A refuted finding left with a strikethrough or a "superseded" note is worse than none, because the next cycle reads it as constraint. A cycle that overturns a claim arrives holding new material (the reviewer's reasoning, the counterexample, the corrected scope) and the natural move is to write that in next to what it overturns. That produces a record which states the claim, then states that the claim is false, and grows by the size of the refutation. **Measure it: note the file's length before the edit and after, and a refutation cycle that added length has layered rather than replaced.** What belongs in the record is the corrected statement with its hypotheses; the reviewer's reasoning belongs in [reviews/INDEX.md](../../../reviews/INDEX.md) and the reversal in [ATTEMPTS.md](../../../ATTEMPTS.md), which is what those files are for.

**EVERY FIX IS FOLLOWED BY A DOWNSTREAM SWEEP, IN THE SAME COMMIT, NOT ONLY A REFUTATION.** *A correction, a strengthening, a dropped hypothesis or a newly proved step changes what every statement resting on it may claim.* **Before committing, search the result three ways, by number, by the statement's own symbols and by its owning file, across findings/, results.md, plan.md, the report and the Lean index**, as the verification loop's Phase 4 sets out, and bring each hit into line: a claim now false is replaced, a debt now paid is struck, a hypothesis now dropped is dropped. *A fix whose dependents still read the old text has moved the error rather than removed it.*

**A hypothesis discovered to be load-bearing is written into the statement, not attached to it.** When an audit finds a claim true only under a restriction, the repair is to restate the claim carrying that restriction, in the same words a reader meeting it for the first time would need. A parenthetical ("scope corrected", "as revised", "see below") is addressed to whoever remembers the earlier version, and every later reader pays for it.

No chronological sections. A heading that only makes sense in reading order (`Gate 2 on X`, `P3b, revisited`, `Four failed attempts at Y`) belongs in [ATTEMPTS.md](../../../ATTEMPTS.md). Headings here name the mathematical object or claim, so a reader can find the current position on any topic by looking for it rather than by reading to the end.

**Edit by a unique anchor, and check afterwards that only the intended lines moved.** Deleting or replacing by index range takes whatever lies between the markers, which is rarely only the section intended; adjacent findings vanish without appearing in any diff anyone thinks to check. Compare the heading list and the file's length against what they were. A document that reuses a lead phrase across sections (the same bolded opener under many results, the same closing formula) will match at the first occurrence, and an edit aimed at the newest section silently rewrites the oldest. Nothing errors, the file still parses, and the loss shows up only if someone reads the clobbered paragraph later. Before replacing text matched by a phrase, count the matches; if there is more than one, anchor on the enclosing section instead, and afterwards check that the diff touched only the intended lines rather than trusting that it did.

**Check for self-contradiction before finishing.** Search for the claim you just changed and confirm no earlier section still asserts the old version. A file that states a claim in one place and its refutation in another is worse than one that states neither, because the step 2 reviewer is briefed from it and a top-down reader meets the stale copy first.

**AN ABSENCE CLAIM IS DATED THE MOMENT IT IS WRITTEN, AND THE DISCIPLINE THE `Lean: blocked` TRAILER CARRIES APPLIES TO EVERY ONE OF THEM.** *"nothing bounds it", "no statement in the tree carries X", "this file did not reach that": each is true when written and is the first thing the next commit falsifies, while nothing re-reads it.* **SO WRITE AN ABSENCE AS A CLAIM ABOUT A NAME A GREP WOULD FIND, NEVER ABOUT THE TREE**, and **THE COMMIT THAT ADDS A DECLARATION GREPS FOR THE PROSE ASSERTING ITS ABSENCE, IN THE SAME CHANGE.** *Stale absence claims outnumber wrong theorems by an order of magnitude, because a theorem is checked by a compiler and a sentence by nobody.* **AND THE COMMIT THAT WRITES THE SENTENCE GREPS THE SCOPE THE SENTENCE NAMES**, not a neighbouring one. *An absence is written at the moment of looking and failing, which feels identical to having established it, so the author is the party least able to see it is wrong.* **THE FAILURE IS ALWAYS THE SAME SHAPE: THE SCOPE CLAIMED IS WIDER THAN THE SCOPE SEARCHED**, a library for one of its namespaces, a tree for one file, and the cited half checks out, which is why it survives review.

Every recorded finding names its sources with links. A finding with no citation is a signal that step 1's search was skipped.

#### Keep the findings files navigable

The index is read in full at the head of every cycle, so **its** size is a running cost on every step, keep it to pointers. The findings files are read one at a time, so the cost there is per-subject rather than global, but the same two habits hold them down: current truth is stated once at its topic rather than restated per cycle, and a section that has become a narrative of how a conclusion was reached is compressed to the conclusion, with the narrative moved to [ATTEMPTS.md](../../../ATTEMPTS.md).

A findings file that outgrows its subject gets split, not padded. The signal is a file whose heading list no longer reads as one topic. Splitting it is a restructuring, so it is the user's call, say so and stop, rather than deciding it mid-cycle.

So compression happens continuously, through the two habits above, rather than in a reorganisation the cycle decides to run.

### 4. Update results.md, then commit

Update [results.md](../../../results.md) when the cycle produced something that changes the outgoing claim, a new lemma, a corrected scope, a retracted assertion. Routine reconnaissance stays in [findings/INDEX.md](../../../findings/INDEX.md).

**The document's specification is in [results-spec.md](results-spec.md)**, what it is, the fixed section order, the glance-entry length budget and its checker, the label tiers, numbering as a permanent address, the detail-entry format, the whole-document reconciliation table, and the editing rules. Read it whenever this step fires; **a whole-document pass is required and appending to section 10 is the failure it exists to prevent.**

**A COMMAND A GATE CAN REFUSE IS THE ONLY THING IN ITS CALL.** *A refused gate discards the WHOLE call, so anything chained with it never ran, and the retry repeats only the part the error names.* **The damage is not the lost work, it is that the retry SUCCEEDS**: a commit whose staging was discarded lands carrying the other files, the gate passes, and nothing announces the absence. *Stage in one call, edit in another, commit in a third.* The cost is two extra calls, against a commit that is wrong in a way its own success message conceals.

**Stage the cycle's own work before committing.** The records, scripts and references a cycle produced are its output and it stages them itself; anything another session or a concurrent agent left in the index rides along, since the index belongs to the repo rather than to this session. **An agent that finds a sibling's file staged names it in its report and leaves the history alone**, since that commit is repairable only by a rewrite. **AND NAME THE PATHS ON THE COMMIT ITSELF, `git commit -- <paths>`**, or clear `git diff --cached --name-only` of anything you did not write first. *Staging by path does not reach this: `git commit` writes everything STAGED, so a sibling that staged between your add and your commit rides in under your message, and every agent involved staged correctly.* **It also makes `report and index row in one commit` achievable**, which it is not while the shared index is committed whole.

**A structure gate runs at the commit, and it is not this file's to remember.** [structure_gate.py](../../hooks/structure_gate.py) runs the four checks over [findings/](../../../findings/), [references/](../../../references/) and [reviews/](../../../reviews/) whenever a commit touches them, and blocks a commit that would leave the record carrying a result nothing can cite, no id, no index row, or an id already on another heading. **It costs nothing when it passes.** When it blocks, invoke the [structure-check](../structure-check/SKILL.md) skill and work its table; fix the rows this cycle is responsible for, and if a row is not yours, say which one rather than committing past it silently.

*The gate exists because this is where results are created and nothing checked them.* A separate audit later found result 73 cited four times with no heading, a lemma declaring its own Gate 2 debt in a heading that carried no number, and two ids each on two headings. **Every one was seconds of work for the cycle that made it.**

**Before committing, check both indexes are complete**, the script index, including anything a reviewer left behind, and the reviewer index. Both lapse silently, and the reviewer one has now lapsed twice at scale:

```bash
# reusable machinery -> scripts/INDEX.md; reviewer one-offs -> scripts/INDEX-reviewers.md
# find, not a glob: the library lives in scripts/lib/ and a top-level glob sees none of it
find scripts -name "*.py" -o -name "*.sage" | while read f; do case "$f" in scripts/reviewers/*|*/review_r*) idx=scripts/INDEX-reviewers.md;; *) idx=scripts/INDEX.md;; esac; grep -q "$(basename $f)" $idx || echo "SCRIPT MISSING from $idx: $f"; done
for n in $(ls reviews/REVIEW_r*.md | sed 's/.*REVIEW_r//;s/\.md//'); do grep -q "REVIEW_r$n.md" reviews/INDEX.md || echo "REVIEWER MISSING FROM INDEX: $n"; done
# the proposals table is READ FROM THE TOP, so an unsorted one hides its highest scorer
python3 -c "
import re
r=[int(m.group(1)) for m in (re.match(r'\| \d+ \| \*\*(\d+)\*\*',l) for l in open('.claude/skill-proposals.md')) if m]
print('PROPOSALS: table is not ordered by total, so the promotion pass cannot read the top') if r!=sorted(r,reverse=True) else None
python3 - <<'PY'
import re
lines=open('plan.md').read().split('\n'); tot=len('\n'.join(lines))/1024
# Items are CHECKBOX BULLETS. A pattern that matches no item measures nothing while
# still printing a clean total, so the check reads as passing for as long as it is wrong:
# verify the pattern against the file whenever either changes.
starts=[i for i,l in enumerate(lines) if re.match(r'^- \[[ x]\] ',l)]
for k,i in enumerate(starts):
    j=starts[k+1] if k+1<len(starts) else len(lines)
    j=min(j, next((m for m in range(i+1,len(lines)) if lines[m].startswith('## ')), j))
    # The ITEM LINE is the signal: an item written to spec runs to several lines,
    # and measuring the block flags that shape while a paragraph on one line passes.
    if len(lines[i])>700:
        print(f"PLAN: item's own line is {len(lines[i])} bytes, where the spec is one line of status: {lines[i][:55]}")
for a,l in enumerate(lines):
    if l.startswith('## DONE'):
        for i in range(a,len(lines)):
            if lines[i].startswith('- ') and len(lines[i])>300:
                print(f"PLAN: retired entry is {len(lines[i])} bytes, where one line is 300: {lines[i][:55]}")
if tot>60: print(f"PLAN: {tot:.1f} kB, past the 60 kB backstop -- step 7 has been skipped for several cycles")
PY
```

#### The cycle ends in a handoff, and the handoff has two forms

**A status summary is not the end of a cycle.** Reporting what happened reads like a natural place to stop, and substituting it for the handoff is how a loop turns into a series of reports. Which handoff to produce depends on one question: **did this cycle change [SKILL.md](SKILL.md)?**

**WITH A MANAGER SESSION NAMED IN [.claude/sessions.json](../../sessions.json), NEITHER A DECISION OWED TO THE USER NOR A CHANGE TO THIS SKILL OR ITS HOOKS STOPS THE CYCLE.** A decision is written into [DECISIONS-TO-MAKE.md](../../../DECISIONS-TO-MAKE.md) and sent to the manager with `SendMessage`. A skill or hook change is sent as its proposed text and commit message, and is not written into the file by this session. The cycle then continues with work that does not depend on the answer. *The manager puts the question to the user and commits the outcome into the record, and a committed outcome is the state of the repository rather than a relayed approval, so the cycle reads it and acts.* **THE HANDOFF IS A `SendMessage` TO THE MANAGER WHOSE FIRST LINE OPENS WITH ITS KIND: `DECISION`, `SKILL CHANGE`, `BLOCKED` OR `DEFECT`.** It carries the ask, a recommendation, and what this session does meanwhile. `BLOCKED` is an action a permission check or a hook refused and this session cannot clear, named with the refusal's own words, and it is never retried by other means.

Without a manager: if the skill changed, stop and wait. Editing the skill changes how every future cycle runs, so it is the user's decision, not the cycle's. Produce:

1. **What the cycle established**, in a line or two, or that it produced no finding, which is equally a result.
2. **The files ready to commit**, listed, with anything unstaged named as unstaged.
3. **The proposed commit message**, in full.
4. **The explicit ask**: approve, revise, or restage.

Then wait. One approval covers exactly one commit.

If the skill did not change, present and continue. The records are the cycle's own bookkeeping, so this handoff is short: name the files the cycle touched, say which are staged and which are not, give the message in full, **say plainly that the skill was untouched** so the user knows no standing rule moved without their sight, and go straight to step 5 in the same turn.

The asymmetry is deliberate: a research result is recorded and moves on, while a change to how the research runs is a decision the user makes.

Then invoke the **commit** skill, which is the route the harness expects: running `git commit` directly instead trips the user's own gate on that command and produces a prompt the skill route does not, so the deviation is visible to the user as friction rather than as a choice.

### 5. Improve this skill

**Ask what went wrong in the cycle just finished, and follow [editing-skills](../editing-skills/SKILL.md) for what to do with the answer**, it holds the mode logic, the proposals route, the word ceiling, the verbatim report format, and how a rule is written so it survives being lifted into another project.

This step runs every cycle, and **also runs immediately whenever something goes wrong mid-cycle** rather than waiting for the cycle to end.

### 6. Audit plan.md

#### What plan.md is

**The task list, and nothing else.** It answers one question: *what is worth working on next, and why that rather than something else.* It is read at the head of every cycle and rewritten at the end of most, so it stays short: **one bullet per live item, one line per retired item, and no mathematics that [findings/INDEX.md](../../../findings/INDEX.md) already holds.** A plan whose items have grown into paragraphs is carrying a record of how a conclusion was reached; move that to [ATTEMPTS.md](../../../ATTEMPTS.md) and leave the task.

This skill holds process; the mathematics lives in [findings/INDEX.md](../../../findings/INDEX.md) and the scripts. A rule here says how a cycle is run, so it stays true whatever the current object of study is. A convention about a particular formula, a factor in a particular identity, a constant's value, those belong in the file or the script that uses them, and in the skill they are noise that survives long after the formula stops mattering.

Process rules live in this skill; [plan.md](../../../plan.md) holds state. Where the same rule appears in both, the skill is the copy that gets edited and the plan carries at most a pointer. Duplicated rules drift apart, and the drift is invisible until two cycles act on different versions of the same instruction.

#### Fixed section order

1. **Goal**, one line, restated from [README.md](../../../README.md), with the standing assumption named.
2. **Where the proof stands**, the primary route and its fallback, one short paragraph each, saying what each would still need.
3. **Live work, in priority order**, the checkbox list. The top item is what the next cycle starts on.
4. **BLOCKED**, items that cannot start. **A blocked item is moved here, out of its section.** Each says what it waits on and who can lift it. Being unscreened is not being blocked.
5. **Carried forward**, pointers to the fence posts, the [route register](../../../routes.md) and the Gate 2 debt ledger, so a rewrite cannot lose them. *A plan rewrite compresses closure criteria to a line and they survive only in git history; the register exists so a rewrite cannot reach them.*
6. **DONE**, finished items. **A ticked item is moved here, out of its section.** One line each, naming what closed it and where the detail lives.

Sections 1 and 5 are near-constant across cycles. Section 3 is rewritten freely. Section 6 only grows, one line at a time.

**Sections 1 to 3 hold only live work.** An item leaves them the moment it blocks or the moment it is ticked, to section 4 or section 6. A ticked item left in place makes the live list longer than the work, and the next cycle reads down a list whose top entries are already finished.

**Move the item the moment it blocks.** Noting the block inside the item leaves it in the live list, where the next cycle reads it as startable. Sections 1 to 3 then hold only work that can be started, which is what makes "take the top item" safe.

**Where only one sub-step is blocked, the item stays live.** Split it: the blocked sub-step moves, the rest keeps its place in its section.

**The size and the format are step 7's, which follows.** *This step decides what the list contains; that one decides how much of it the file may carry.*

Read [plan.md](../../../plan.md) against what the cycle established. **AND WHERE A NODE CLOSED, A ROUTE OPENED OR CLOSED, OR THE TOP ITEM CHANGED, REWRITE [STATUS.md](../../../STATUS.md)'s JUDGEMENT SECTIONS IN THE SAME EDIT.** *Its word budgets are checked by [status_report.py](../../../scripts/misc/status_report.py), so the ceiling forces a rewrite rather than an append, which is the only thing that keeps a position file from becoming a second copy of the record.*

- Move what the cycle closed straight into *DONE*, as one line stating the result and where the detail lives. It leaves the live list in the same edit.
- Rewrite items whose route the cycle invalidated, naming the new route.
- **Delete items that are dead**, subsumed, refuted, retired, or resting on something now known false. Move nothing to a graveyard section; DONE carries one line per item, and everything else goes.
- Re-order the live list by what now blocks the goal, so the top item is genuinely the top item.
- Move any process rule that has accumulated in the plan into this skill, leaving a pointer. Where the two disagree on a rule already in both, the version that survived contact with a real cycle wins, and it ends up here.

**Check an item against the fence posts as it is written, not only when a route is proposed.** Step 9 screens candidate routes, and the same screen is skipped when an item is decomposed into sub-tasks inside a cycle, the sub-task inherits the parent's plausibility and nobody re-reads the proven negatives. A fenced item then becomes a whole cycle's assignment, and the fence post is rediscovered from the inside at full cost. The check is cheap because the fence posts are a short list: for each new item, name the quantity it would bound and the information it would bound it from, and confirm no recorded negative already covers that pair.

#### Item format

Each live item is a plain bullet carrying, in order: its identifier (`I7`, `I13a`), a status word in caps where one clarifies (`OPEN`, `REFUTED`, `BLOCKED`, `THE CRUX`), a one-line statement of where it stands, then the route and what is owed. This is what lets step 8 pick from the list without re-reading [findings/INDEX.md](../../../findings/INDEX.md).

#### The identifier classes

**Every class has one owner and one letter, and no two classes share one.**

| class | id | owner |
|---|---|---|
| results, Lemma, Observation, Conjecture | `L<n>`, sub-results `L<n>.<k>` | the results index under [findings/](../../../findings/), which assigns them |
| fence posts | `F<n>` | the traps index under [findings/](../../../findings/) |
| warnings | `W<n>` | the traps index under [findings/](../../../findings/) |
| routes | `R<n>` | [routes.md](../../../routes.md) |
| standing method rules | `M<n>` | [findings/LEDGER.md](../../../findings/LEDGER.md) |
| reviewers | `r<n>` | [reviews/INDEX.md](../../../reviews/INDEX.md) |
| plan items | `I<n>`, splits `I<n><letter>` | [plan.md](../../../plan.md) |

**The letter names the class**, and **a plan item never takes a result's number**, an item is work, a result is a claim, and a reader following a citation must land on one of them without guessing. **The plan repeats this table at the head of section 1**, so a collision is visible before it is cited.

**A class owned by a working file carries a high-water mark at its head: one line naming the next free id, taken and incremented on assignment, never reused.** *A mark cannot drift out of step with what it numbers; a register of live items can.*

#### What survives every rewrite

Three things outlive any single plan and are re-checked at the end of this step:

1. **The fence posts**, tabulated in [findings/INDEX.md](../../../findings/INDEX.md) and stated in full in the findings files that established them, the proven negatives any new attempt must clear. **The bold-deletion rule does not reach them.** They are results rather than tasks, each cost a cycle to establish, and a plan rewritten without them will propose a route one of them already kills. Add to the list whenever a cycle proves another one.
2. **The primary route, its fallback, and the conditions for abandoning the primary.** A plan with only a primary route has nowhere to go when the primary stalls mid-cycle. **One condition is always this: several attempts failing for the same underlying reason.** That reason is a property of the whole approach, so the next attempt of the same kind fails too, and the plan returns to step 8 instead.
3. **The Gate 2 debt ledger**, kept in [LEDGER.md](../../../findings/LEDGER.md) and pointed at from the plan, every result awaiting audit, so a pending marker cannot age into an assumed result.

**And the method rules, each earned by a refutation.** These outlive the plan that produced them, and a plan rewritten without them repeats the failure that earned each one.

- **Query the record by NUMBER, not by vocabulary.** Three refutations came from points already recorded and missed because the search used words.
- **A reviewer's numbers are not evidence until rebuilt from the object's own definition.** Two reviewers agreeing is not confirmation when they may share a convention, *readers inheriting a sign from the same constructor report the same error and agree.*
- **A screen exists for every hypothesis a lemma has, and a number its own script cannot reproduce is not a number.** A table carried in a docstring and emitted by nothing cannot be rechecked, and the one that overturned a cycle was wrong.
- **Killing constants come from the definition, never from an index convention.**
- **Settle a convention against a derived identity, never against a numeral the record wrote.** When two readings of a symbol are in play, point at a statement the wrong reading makes FALSE, an identity with residual zero, a proved equality case, a sharp constant. *A reading that merely rescales a bound has changed the units and falsified nothing, so citing that bound holds the conclusion as its premise.* **The identity is usually already on file in the file that CONSUMES the symbol rather than the one that defines it**, so search the consumers, and prefer one whose statement is an equality.

- **Run the guards that already exist before disputing what they guard.** A repository that maintains a screen for exactly the error under discussion has answered the question in two seconds; a cycle once spent hours on a dispute that two unrun scripts settled.
- **A quantity can be exact in one pairing and wrong in another.** A map assembled from a diagonal is correct against its own argument and wrong against any other direction, so it gives the right scalar and a badly wrong gradient. Before differentiating anything, check the object against an independent implementation *in the pairing you are about to use*.
- **Elements of a constraint kernel are not elements of the subspace the problem lives in.** A kernel of one linear condition still carries every other component; four separate results in one programme were computed on the wrong space this way.
- **An identity checked where both sides vanish is not checked.** At a critical point every constant multiple of the gradient passes, so the test distinguishes nothing. Test at a generic point, and confirm the check can fail by feeding it a deliberately wrong answer.
- **An even-degree check cannot see a sign error.** Norms, linear constraints and squared traces all pass on a negated object. Only an odd-degree quantity distinguishes it, so a construction's sign is checked by evaluating something cubic.
- **Evaluate a proposed criterion at every dimension where the ambient module changes character**, not only at the one already known to be special.

The fallback stays until the primary is verified line by line. A primary route that looks like it closes is not a closed route, and retiring the alternative on the strength of an unverified finish is how a stalled cycle becomes a stalled project. Retire it after the verification, not after the optimism.

### 7. Clean plan.md: what the record already holds, the plan cites

**A separate step from the audit above, and numbered because it is a different act.** *Step 6 decides what the list should contain; this one decides what the entries are allowed to say, and the two fail in different ways.* **Retiring a closed item and cutting one that has swollen are not the same motion, and doing the first feels like doing both**, which is how an audit can run every cycle while the file grows without bound.

**IT RUNS EVERY CYCLE, WHATEVER THE FILE'S SIZE.** *A plan grows by a paragraph a cycle, and a file one paragraph past useful reads exactly like a file that is fine, so nothing about the document ever announces that the step is due.* **Its trigger is the cycle, not a measurement.**

#### The three questions, in this order

1. **What does the record already hold on this item's subject?** Open [findings/INDEX.md](../../../findings/INDEX.md) and the file it names. *This is first because the answer decides the other two, and skipping it is what turns a plan into a second copy of the record.*
2. **What in this item is mathematics rather than task state?** A derivation, a constant, a case analysis, a reason a route works. **That belongs in the file that owns the subject.** *Task state is what remains: where the item stands, the route, what is owed.*
3. **What is repeated rather than referenced?** A sentence that says what a findings block says is a second copy that will drift from it, and the drift is invisible until two cycles act on different versions. **Replace it with a link.**

#### Referencing

**Link to the block, not to the file.** *A bare file link makes the reader search a long document for the paragraph the item meant; an anchored link lands them on it, so the citation costs the reader nothing and the temptation to restate the content disappears.*

**One fact, one home, and the home is named in the link.** Where an item and a findings block disagree, the block is the record and the item is stale, so an item that only points cannot go stale at all.

#### Two cases, and the check that tells them apart

**Search the record for the passage before touching it. The answer decides which of two things you do, and they are opposites.**

- **The record already holds it, DELETE the copy and link to the block.** This is question 3, and the copy is what would have drifted.
- **The record does not hold it, MOVE it, and never delete it.** *An item that has accreted for many cycles can hold the only copy of a derivation, and a cut made by eye loses it silently, leaving a plan that reads tidier and a record that is missing a step.*

**The check is one search and it is not optional**, because the two cases look identical in the plan: a paragraph of mathematics under a task, either way.

**Name the file that owns the subject before moving anything into it.** *Where no file owns it, that is the finding rather than an obstacle: either the subject needs a file, or the passage is a working note that was never a result.* **A holding file for what has no home fills up and becomes the second copy of the record in a new place**, so it is worth having only while something empties it.

#### The backstop

**Step 4's plan check reports the file against a budget and names the items carrying the most.** *The numbers are a net for a plan that has escaped the step, not the definition of the step*, and [loop_stop.py](../../hooks/loop_stop.py) hands the cleanup back as the next task while the file is past the budget.

### 8. Pick the next task

Take the new top item from [plan.md](../../../plan.md) and return to step 1 **in the same turn**. Naming the next task and beginning it are one action: a turn that ends having named it is the failure this step exists to prevent.

**The test is mechanical, so apply it mechanically: a cycle's last action is a tool call, never prose.** If the closing message would end by saying what comes next (a gap to attack, a method to try, a dimension not reached) that sentence is the instruction to keep going, and the turn continues into it. Two shapes trigger this most reliably and neither is a stopping point: a commit that lands cleanly, and a limitation written into the record. Both make the unit feel closed while the task list is unchanged.

### 9. When no open task remains, research the field, then choose the route and start it

An empty task list is a research problem, so treat it as one rather than as a stopping point. The step runs in four phases, and the cycle chooses the route itself, from the ranking. **The whole step stays in-session**, so it keeps what the cycle has just learned, and the reading sets the ceiling, since shallow reading yields shallow routes however they are ranked.

**EVERY ACTION OF THE STEP, IN ORDER. IT HAS NO STOP OF ITS OWN: THE REACH GATE AND THE CHURN CAP BELOW FIRE ON FACTS.**

| # | action |
|---|---|
| 1 | **Phase 1**, state where the project stands, at the head of the position file |
| 2 | **Phase 2a**, write `reviews/YYYY-MM-DD-step8-position.md` |
| 3 | **Phase 2b**, the literature sweep, appending to `reviews/YYYY-MM-DD-LIT-step8-sweep.md` after every batch |
| 4 | **Phase 3a**, screen each candidate by mechanism against the fence posts, [findings/](../../../findings/) and [ATTEMPTS.md](../../../ATTEMPTS.md)'s index |
| 5 | **Phase 3b**, propose 2–4 routes, ranked analytical-first, and say which you would pick |
| 6 | **Choose** the top route or sequence, unless the reach gate holds it |
| 7 | **Phase 4**, rewrite [plan.md](../../../plan.md)'s live section around the chosen route |
| 8 | hand back to step 1 |

#### Phase 1, state where the project is

In a few lines: what the last cycle closed, what the task list ran out of, and what still stands between the project and the goal in [README.md](../../../README.md).

#### Phase 2, search the field

**THE SWEEP COVERS EVERY LIVE ITEM, NOT THE ROUTE'S HEADLINE.** One search per section 1 and section 2 item, phrased in that item's own objects rather than the programme's, the route's name will surface the route's literature and nothing about the subtask that will actually consume the cycle. **Record the outcome beside the item, including "searched, nothing found", which is itself information** and stops the next cycle repeating the search or assuming it happened.

*A plan whose searches all aimed at the headline leaves its other items unsearched, and an unsearched item can absorb attempt after attempt at a question the standard theory simply answers.* **"A literature sweep was done" is true and useless when the sweep reached one item of many.**

**EVERY SWEEP OPENS BY WRITING ITS POSITION FILE**, `reviews/YYYY-MM-DD-step8-position.md`, the open nodes, the fence posts bearing on them, the live items with their grades, and **what previous sweeps already covered**, which is the half most often skipped and the half that stops a search being repeated. *A sweep that does not read the last one re-runs its batches; the last one's own summary is where "nothing found" is recorded.*

**THE SWEEP THEN WORKS FROM THAT FILE AND NOTHING ELSE OF THE RECORD WHOLE, AND APPENDS TO `reviews/YYYY-MM-DD-LIT-step8-sweep.md`** after every batch, search or derivation, as it finishes. *THE POSITION FILE IS WRITTEN FIRST SO THE SWEEP CARRIES A DIGEST RATHER THAN RE-READING THE RECORD AT EVERY BATCH, WHICH IS WHAT KEEPS A LONG SWEEP INSIDE ONE CONTEXT.* Both names are date first, so each pass's pair sorts together.

**A derivation batch is screened before it is written up, exactly as a route is.** *A sweep can derive identities from the record's own calculus that the record already proves, under lemma numbers the same sweep cited earlier in the same file.* Grep [findings/](../../../findings/) for the formula's distinctive tokens before spending the derivation; when the screen comes back positive, the batch is still worth recording, as a confirmation with the lemma it reproduces named. **A confirmation reported as a discovery is the failure; a confirmation reported as one is a real Gate-2-free check on the record.**

Go wide against the goal, adjacent conjectures, the tools used on the parts already settled, recent arXiv work on the objects in play, and the citation graph forward from the sources already in [references/](../../../references/). Search the web as well as arXiv: an open problem usually has talks, seminar notes, theses and preprints that a title search misses. Store every source the same way, with its `notes.md`.

Read for what would close the problem, not for what is nearby. The sweep's output is a set of candidate routes, each with a mechanism and a reason to believe it reaches the goal.

**Be bold, and look past the problem's own boundary.** The record's vocabulary is a local dialect, and a sweep that stays inside it finds the record. **Ask what field the two open statements belong to when stripped of this programme's names**, and read that field, including machinery the programme has never used. *A route from outside is worth more than a refinement from inside, because the inside is what the record already is.*

#### Phase 3, rank the routes and choose

Rank **two to four candidate routes**.

**PRESENT THEM AS A SCORED TABLE, NOT PROSE, GRADED ON SECTION 1'S OWN RUBRIC.** *One row per route, columns `route · closes · attackable · margin · analytic · value`, value the product, so the choice rests on the same numbers a section 1 item is ranked by rather than on an adjective.* **AND ONE COLUMN THE GRADE DOES NOT CARRY: HOW CLOSE THE ROUTE GETS TO A PROOF OF THE GOAL** in [README.md](../../../README.md), stating what closing it would and would NOT leave outstanding. *A route can score well and still be tool-building that feeds a later argument: the grade ranks the work, this column says where it sits on the road to the goal.*

Each route gets: the mechanism in one or two sentences, what it would take to run, what it would deliver if it works, what would falsify it, and the sources behind it. **Rank them analytical-first**, a route promising a closed-form statement outranks one promising better data, even when the data route looks easier and even when it looks likelier to produce something. The target is an elegant analytical proof, and a plan that drifts into measurement is how a project stops moving toward one.

**Read the record before reading the field, and read each file the way it is built to be read.** The sweep is outward-facing and the failure it invites is proposing something the programme has already done. **Only the small files are read whole**: [findings/INDEX.md](../../../findings/INDEX.md) in full for what is true and what each file holds, and [routes.md](../../../routes.md) in full for every route live or closed and *what a successor must clear*. The large ones are queried, never read: [fence-posts.md](../../../findings/fence-posts.md) by its post table, and **[ATTEMPTS.md](../../../ATTEMPTS.md) through its index by mechanism**, the notebook is the one file that records routes which neither succeeded nor earned a post, and therefore the one a candidate can duplicate invisibly, but it runs to hundreds of kilobytes and reading it whole is neither possible nor necessary. *A route was once proposed, graded top and worked for a cycle before an audit found it was the record's own lifting lemma, closed three times in that notebook and named open in a findings file.* **Look the candidate's mechanism up in the notebook's index, not its name**, a duplicate arrives under a new name, which is why it looks new. The index maps mechanisms to entry numbers, so the lookup is one step and does not depend on guessing the words a past cycle chose.

**The screen covers seven places, and the seventh is read FIRST.** *That is the record's own table of transcribed literature, the numbered statements copied verbatim out of the sources with their hypotheses.* **A candidate whose mechanism is a cited theorem is settled there in one read, and nowhere else cheaply**: a route was proposed, ranked and worked while the theorem it needed sat in that table with its consequence drawn in the same cell, missed by the cycle and by three reviewers. *Two of one sweep's three routes were things the record already held, one of them a citation that did not exist.*

Then the other six: the fence posts, [findings/](../../../findings/) and [ATTEMPTS.md](../../../ATTEMPTS.md), and beyond them **[reviews/](../../../reviews/)**, where conventions and identities that never earned a findings block live; **[references/](../../../references/)**, where a fetched source records what was checked in it; and **[verification/](../../../verification/)**, whose round files hold derivations the audit loop produced. **A screen that stops at the first three declares "no argument on file" while the argument sits in a round file, and rebuilds a convention a literature note already states in a line.**

**When a proposal is an identity between two named operators, ask whether the record holds either under another name.** Both operators can sit on the record, in one file, with the identity invisible to a grep for either symbol.

Check every candidate against the fence posts before proposing it. A route one of them already kills is the most expensive kind of proposal, because it looks new.

**Screen a route's PRICED SUB-STEPS against the record, not only its mechanism.** For each sub-step, ask what it would produce and whether the record already carries it, querying by the quantity produced rather than by the method producing it, since a constant is filed under the claim that consumed it. **A sub-step already on file corrupts `attackable` upward**: the route scores as having a concrete first step while that step is finished, so it reaches the top of the plan carrying work that will take no time because it is done. *Unenforced: no check reads a route's sub-step list.*

**Screen each candidate by GREPPING THE FINDINGS FOR ITS MECHANISM, not by reading the fence-post table.** The table holds the negatives someone thought to number; a route is far more often killed by a proven negative recorded as prose inside a findings file, under the name of the tool it used. That prose is invisible to a table scan and invisible to an outward literature search, so a route can pass both screens and still be one the programme has already closed. **The query is the mechanism's own name** (the theorem, the operator, the author whose result the route borrows) run over [findings/](../../../findings/) before the route is ranked.

*The failure this prevents is specific to step 9 and does not happen anywhere else.* Step 1 opens an item by searching the record, and that gate works. A route chosen at step 8 never passes through it: by the time an item derived from the route reaches step 1, the route is already the plan's chosen direction and reads as settled, so the search runs on the item's sub-objects rather than on the route's mechanism. **The screen therefore belongs here, at the moment the route is proposed, and it is worth one grep per candidate.**

**And when a cycle proves a negative, number it and put it in the index table.** A closure left as prose is a closure the next step 8 will not find, which is how a route gets proposed, graded and planned against a result the record already holds.

**TAKE THE TOP ROUTE, OR THE TOP SEQUENCE, AND START IT, RECORDING THE TABLE IN [routes.md](../../../routes.md) AND [STATUS.md](../../../STATUS.md) AS THE REASON.** *Route choice is tactics: the ranking makes it, and a pause for approval spends the user's attention on a decision the grade already took.* **A sequence advances to its next route without a new ask. The reach gate hands the choice to the user, a `strategy:` stop. The churn cap does not: at five closures the cycle redirects itself.**

- **THE REACH GATE**: the top route's reach column names a single parameter value or a census, where the goal quantifies over a range. **A table whose routes reach only a step toward the goal, or none of it, is still the cycle's to choose from: take the top route and start it.**
- **THE CHURN CAP**: five routes on the same plan item have closed with no `derivation` commit advancing that item between them. The item has no method, so the cycle redirects: it moves the item to `BLOCKED` with its obstruction recorded in [findings/INDEX.md](../../../findings/INDEX.md), records the redirect and its reason in [routes.md](../../../routes.md) and [STATUS.md](../../../STATUS.md), and takes the highest-graded section 1 item that does not stand on it, or runs a fresh step 9 sweep on the goal when none has a route. The user overrules it whenever they choose.

**AT THREE SUCH CLOSURES, RECORD THE PICK AND KEEP GOING.** **The pick comes from a fresh step 9 sweep that questions the approach itself, never from the previous sweep's table**, since three closures usually mean the family of routes is spent and its next row is a fourth variant of it. Record the pick and the table in [routes.md](../../../routes.md) and [STATUS.md](../../../STATUS.md), then start it in the same turn. **A pick the cycle has made is not a decision owed to the user and does not go to [DECISIONS-TO-MAKE.md](../../../DECISIONS-TO-MAKE.md).** The user overrules it whenever they choose. *A stop that ends on a firm recommendation asks the user to approve a decision the cycle has already made, and a run of them spends their attention on the word "ok".* **Stop before five only when there is no recommendation.**

**A route the record already carries as an unregistered chain outranks a new one.** Before ranking, check whether the strongest open statement on the record (the one whose proof would close the goal outright) sits in any plan item or any [routes.md](../../../routes.md) row. *One programme's only chain that would settle its conjecture outright had fallen out of both, surviving as prose in a findings file and one line of canon, while four cycles of step 8 proposed new routes around it.* `grep` the register and the plan for the chain's own quantities, not its name; if nothing comes back, registering it **is** one of the candidate routes, and it is proposed with its open steps priced like any other.

#### Phase 4, plan the chosen route

Rewrite [plan.md](../../../plan.md)'s live section around the chosen route sequence, the first as primary and the rest as its fallbacks in order: the sub-steps that make it startable, what each one is owed, and what would retire it. **Be bold and back your own judgement** on the decomposition.

Carry forward the fence posts, the named fallback and the Gate 2 debt ledger, exactly as step 6 does. A full rewrite is where they are most likely to be lost and where losing them costs most.

Once [plan.md](../../../plan.md) is rewritten, the top item is startable, no fence post was ignored, and the session is back on Opus, go to step 7.

## Stop conditions

**Ending a turn is an action that must be justified, and the justification is naming the stop condition that fired.** A step finishing is not one. Before ending any turn, state which of the conditions below applies; if none does, the turn continues into the next step rather than ending. Reporting a result and starting the next step belong in the same turn.

**Write the condition's name as the first words of the closing message, tagged `STOP: <condition>`.** A message that cannot carry that tag is not a message to send, it is a signal that the next action is owed instead. Answering a question about progress mid-cycle is done at the top of a turn that then continues working; it is never itself the end of one.

The tag is enforced rather than remembered. While a cycle is marked active, a `Stop` hook refuses an ending that declares no condition, handing back the list of valid ones; it stays inert outside a cycle and never blocks twice in a row, so a genuine ending is always reachable. Declaring is a tool call (write the reason to a file the hook consumes) rather than a line of prose, because what a hook can observe with certainty is the filesystem, and a version that scanned the closing message instead failed closed and blocked turns that had named their condition correctly.

The conditions are these, and only these:

- The user interrupts or says to stop.
- A cycle changed [SKILL.md](SKILL.md), pause at step 4 for approval, then resume at step 5. **Reaching this pause means producing the handoff above**, not a status report. A cycle that changed nothing in the skill commits its own records and continues without pausing at all.
- A strategic fact fires: step 9's reach gate. Tag it `strategy:` and name the fact. The churn cap is a redirect, not a stop.
- An escalated derivation is on disk: `.claude/effort-expect` is deleted and the drop back to the standing level is asked for before step 2 begins.
- A decision belongs to the user: a change to the goal, anything that spends real money or reaches an external service. **Every pause of this kind puts a recommendation on the table with its reason, so the user decides against a pick rather than a list.**
- The same task has been attempted across five cycles with no movement AND the churn cap's redirect has nowhere to go: no other section 1 item and no route from a fresh sweep. Say what is blocking it in one line, record the obstruction in [findings/INDEX.md](../../../findings/INDEX.md), and stop rather than looping on it.
- The conjecture is proven and [results.md](../../../results.md) carries the proof, Gate 2 passed.

**A blocked item is not a stop condition.** Move it to section 4 and take the next one. Effort escalation is not a stop condition either: it applies to one derivation, not to the item and not to the plan.

**A failed step is not a stop condition.** A refuted result, a bound that went the wrong way, a route that closed, each of those completes step 1 and hands to step 2 or step 5 exactly as a success would. The loop is designed to absorb failure; stopping on it discards the design.

## Standing conventions

- Prose in markdown files is never hard-wrapped: one paragraph is one line.
- Every file, statement and URL mentioned is a markdown link rather than backticked text, and the link text carries no backticks.
- Write what a thing **is**. A negation tells the next cycle nothing it can use.
- Numerical evidence is labelled as such and never stands in for a proof.
