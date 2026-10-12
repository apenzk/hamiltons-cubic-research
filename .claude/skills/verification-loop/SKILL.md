---
name: verification-loop
description: Check the record's lemmas for correctness, one per round, three independent verifiers, two on a repair audit, attack a single numbered result analytically, every distinct finding is adjudicated by two fresh verifiers asked a neutral question, a confirmed defect gets its spread and impact traced and fixed where possible, and the row moves to plan-verification.md's checked list before the next round starts. Use when the user says "verification loop", "check the lemmas", "verify the findings", "next verification round", or invokes /verification-loop.
---

# Verification loop

**One loop runs at a time.** No rule here may assume a second session writing the record concurrently; a reason of that shape is unsound and is deleted rather than repaired.

**A round that restates a result owes it a machine-checked file, in the same change.** A repair or a restatement is a new claim, and a claim the record carries under a number is owed the same check as the one it replaced, *a correction is where an unchecked assertion most easily enters, because it arrives wearing the authority of the audit that produced it.* **The layer is described once, in [lean-layer.md](../lean-layer.md); how to write a file is [lean-practice.md](../lean-practice.md).**

A continuous loop over the numbered results of the proof programme. One pass over one result is a **round**, and a round ends with that result carrying a verdict, its consequences traced, and its id moved from the *To check* list to the *Checked* list in [plan-verification.md](../../../plan-verification.md). The loop then takes the next id and starts again, in the same turn.

This loop **checks** the record. The [research-loop](../research-loop/SKILL.md) extends it. The goal both serve is in [README.md](../../../README.md).

## The three rules that outrank everything else here

**A lemma is correct only if its proof is correct.** Every claim of the form "verified at $n=12,14,16$", "zero violations at 20 points", "residual $10^{-15}$" is an open hypothesis, not evidence, and a round that closes a result on numerical grounds has failed.

**This loop does no numerical work at all.** No verifier runs a script, and neither does the round. A counterexample is exhibited in closed form or it is not a counterexample; a factor is wrong by derivation or it is not known to be wrong. This is stricter than the research loop's ordering, and deliberately so, the record was built with numerics and the arguments are what went unchecked. The record's own standing rule says why sampling cannot settle these questions: *a control drawn from a distribution that avoids the counterexample family cannot see it*, and every interesting failure in this programme lives on a measure-zero set.

**A quoted sentence's hypotheses are the ones inside it.** A scope clause in the neighbouring sentence governs what that sentence says, not what this one does, and grep returns the claim without it.

**Count the sites before replacing and after.** A correction reaching one copy of several leaves the record asserting both, and the copy that survives is the one the next reader meets.

**A fix REPLACES the defective text. It never annotates it.** The findings file must read as though the defect had never been there, the wrong statement gone, the wrong pointer gone, the corrected mathematics in its place. **A round that leaves the old text standing with a note beside it has not fixed anything**; it has made the file longer and left the next reader to work out which of two passages to believe. Every note explaining what used to be wrong, who found it, and when belongs in [ATTEMPTS.md](../../../ATTEMPTS.md), which exists for exactly that and is read chronologically. What may stay in the findings file is at most one line naming the verdict and the round, so a later reader knows the passage was audited, not a paragraph reconstructing the error.

**AND THE ROUND'S OWN REPAIR GETS THE SCRUTINY THE ROUND GAVE THE TEXT.** *A repair is new text, written by an author under the pressure of a finding, with no cold reader*, **which is the exact condition this loop distrusts everywhere else.** A verifier's supplied argument earns `HYPOTHESIS-DEBT`; a claim needs two independent readers. **The repair gets neither, so the round re-reads it cold before closing**, against the constants it cites, at the dimension in hand, and as a consumer of the statement rather than as its author.

**Writing a trap down does not protect the next paragraph from it**, and a repair that reintroduces a defect is typically written soonest after that defect was named.

**A CORRECTION REACHES THE SITE OF USE, OR IT IS NOT A CORRECTION.** A defect is rarely written once: the passage that stated it was copied into a summary, an index row, a plan item and a proof. **So grep the record for the wrong form the moment the right one is known, and fix every hit before closing the finding**, fix the class, never the instance.

**Two shapes of this that a round reliably misses.** *The correction lands beside the sentence it corrects rather than inside it*, a repair written into the boxes around a boxed statement leaves every citation inheriting the defect, because **a citation reads the statement**. **After a repair, re-read the statement alone, as a consumer would, and check that the correction is inside it.** And *a check attached to grading an item cannot see a value imported four hours later*: **name a recorded value's source and that source's stated range in the same line that first uses it.**

**The shapes above are what the failure looks like in practice**, and the cost is measured in audits that pass while the defect stands.

*This is a core rule because the pressure runs the other way every time.* A correction feels safer when the old claim is left visible beside it, and each such note is small. **They accumulate into a file that states its own history instead of its mathematics**, and then the next round cannot tell the record from the commentary on the record. *One round here rewrote a block correctly and still shipped a sentence quoting the pointer it had just removed.*

**Where a finding genuinely cannot be settled without computing**, it is recorded as `UNRESOLVED, needs computation`, naming the exact quantity and what its value would decide. That is a task for the research loop, where numerics are legal instruments, and it is handed over rather than attempted here.

## Where everything lives

| File | Role |
|---|---|
| [plan-verification.md](../../../plan-verification.md) | **The queue and the verdicts.** Ids only, the descriptions live in the index. Written by this loop alone; [plan.md](../../../plan.md) is the research loop's list and is never touched here. |
| [findings/INDEX.md](../../../findings/INDEX.md) | **Owns the numbering.** Every id is a row in its numbered-results table, which names the statement's kind and the file that holds it. |
| [findings/](../../../findings/) | The proof under review. The file the index names, and nothing else. |
| [lean/INDEX.md](../../../lean/INDEX.md) | **The third form, where a result has one.** Read the row before dispatching. *The layer is described once, in [lean-layer.md](../lean-layer.md).* |
| [results.md](../../../results.md) | The canonical statement of a result, where it has one. **A statement in [findings/](../../../findings/) that disagrees with its canonical form is itself a finding.** |
| [verification/VERIFY_&lt;v&gt;.md](../../../verification/) | One file per verifier, written by the verifier. |
| [verification/ROUND_&lt;id&gt;.md](../../../verification/) | **The round's adjudication**, the clustering, the adjudication outcomes, the spread, the fix. Written by the loop. |
| [reviews/](../../../reviews/) | **The research loop's, and READ-ONLY to this loop.** Its reviewers write here; a verifier that writes here overwrites their work, which has happened. |
| [ATTEMPTS.md](../../../ATTEMPTS.md) | Where a repair or a retraction is appended, chronologically. |
| `agent_logs/` | Heartbeat logs, gitignored. |

## The round

### Phase 0, take the top id and build the brief

**Before the first round of a session, read [findings/INDEX.md](../../../findings/INDEX.md) in full.** Before calling a value or result absent or new, check its value table and grep the record for its most distinctive constant rather than its name.

Take the first unchecked id from [plan-verification.md](../../../plan-verification.md), read its row in [findings/INDEX.md](../../../findings/INDEX.md), and open the one file that row names.

**The brief is quoted, never paraphrased.** Copy the statement, its hypotheses, the proof as written and the definitions the proof needs, verbatim, and record the source as `file:line` in the round file. A paraphrase is the one error three independent verifiers cannot catch, because all three inherit it, every other error they are drawn against independently.

**Check the statement against [lean/INDEX.md](../../../lean/INDEX.md) before dispatching, and put the Lean statement in the brief when there is one.** *Where a row exists, the recurring finding of this loop becomes a comparison rather than a judgement.* **A row absent where the record claims a theorem is itself worth recording.** *Two entries of one block were found carrying statements false at odd $n$ while type-checking, and a third had been re-derived with `sorry` beside a file that already proved it, none of it visible from the prose.*

**Check the statement against [results.md](../../../results.md) before dispatching.** Where the canonical form and the findings form differ, both go into the brief, unlabelled, and the difference is itself the round's first finding.

Open [verification/ROUND_&lt;id&gt;.md](../../../verification/) with the id, the source lines, the verifier numbers about to be allocated, and the date. It is the round's contract and it makes an interrupted round resumable.

**The queue is edited in phase 0, not only in phase 6.** [plan-verification.md](../../../plan-verification.md) carries an **In flight** line naming the id, the round file, the phase and the verifier numbers, and a **Queue changes** entry for every re-ranking with the reason that forced it. *A demotion recorded in the round file alone leaves the queue naming an id nothing is working on.* The queue is the file a resumed session reads first, so a decision that changes the order is not made until it is written there.

### Phase 1, the verifiers, one dispatch

**Three verifiers on a first audit and two on a repair audit, identical briefs, spawned in a single message so they run concurrently, and the same message arms a watchdog over them, emitting when a report lands and when a log goes cold.** *A completion notification is the normal return path rather than a guarantee, and Stop fires only at the end of a turn that has already passed, so nothing else catches an agent that dies mid-write.* Independence comes from their reasoning, not from varying their instructions. More than one because the errors a cold reader catches are drawn from a wide distribution, and independent readers rarely find each other's. **A finding raised by a single verifier is adjudicated exactly as one raised by all of them**, so the count governs recall alone.

**A repair audit briefs only the text the repair wrote**, with the premises it rests on and the statement it serves, and withholds the rest of the result, which its earlier round already checked.

**This loop's agents are VERIFIERS, and they carry their own `v` sequence.** They check the mathematics of a proof as written; they never reimplement it. That is a different job from the research loop's **verifiers**, who write their own implementation to break a result and whose numbers run `r1`, `r2`, …, and the two must never share a namespace.

*A `v` number is cited in round files and in the record, so reusing one silently redirects every citation that already points at it.* **Verifiers are numbered `v1`, `v2`, … in their own sequence, the next integer after the highest `verification/VERIFY_v*.md` on disk, and a `v` number is a permanent address, never reused.** Cite one as `v6`, never as a bare number.

#### What the brief carries

**NOBODY WRITES THE SHARED REVIEWER INDEX UNTIL EVERY REPORT OF THE ROUND IS FINAL.** *Independence is the whole reason two readers are run, and the index is the one file both are certain to open.* **A reviewer forced to file its own row publishes its verdicts where its counterpart will read them; a parent that pre-writes a row attributes a verdict its author has not given yet, and the author must then correct the record about itself.** *Both failures read afterwards as agreement, and agreement between readers who saw each other, or who were told what they concluded, is worth nothing.* **So a commit gate that demands indexing must exempt a report filed by a reviewer, and the fold writes every row after the last report lands.**

**QUOTE THE BRIEF FROM THE BLOCK AS IT STANDS AT DISPATCH, VERBATIM, AND NEVER FROM A DRAFT OR A PARAPHRASE.** *A brief assembled while the block is still being repaired quotes a version that no longer exists, and the audit spends itself refuting text the record does not carry, the reviewers right, the findings real, and none of it reaching the record.* **A paraphrase is worse, because it can invert the claim**: restating "the derivative is negative" as "increasing" flips the conclusion, so the reviewer is asked to check an argument the block does not make and either passes the wrong thing or refutes it. *Both failures are invisible in the reports, which read as ordinary findings.* **So re-read the block off disk after its last edit lands, and copy, the pull to skip it is strongest exactly when the block was just edited, which is when it matters.** **THIS COVERS EVERY QUOTED PREMISE, NOT ONLY THE BLOCK UNDER AUDIT.** *A brief that hands over an earlier result as a given is quoting a second block, and a paraphrase there is harder to catch because the reviewer has no reason to doubt it*, **a given rendered without one of its clauses invents a hypothesis debt the record does not carry, and two reviewers will report it identically.**

**A COLD BRIEF WITHHOLDS THE RECORD, NEVER WHAT ITS OWN ATTACK ITEMS DEPEND ON.** *Withholding is what makes the read cold and is right. Withholding a constant, threshold or premise that an item on the checklist needs makes that item unanswerable, and an item nobody could answer is indistinguishable from one checked and cleared, which is the protection the checklist exists to give.* **So every constant an item names is quoted beside it, and every result the audited claim rests on is stated as a given.** *An item asking whether a conclusion follows, from a brief missing the premise it actually follows from, produces a correct refutation of the brief and a false one of the record, and two independent reviewers will produce it identically, which reads as corroboration.* **The cost is quoting a number and naming a lemma; the failure costs an audit.**


**Give it:** the statement verbatim, every hypothesis, the full proof as written, and the definitions the proof needs.

**Withhold:** every prior verdict, every verifier number that blessed it, the surrounding narrative, whether the result is believed, and any explanation of *why* it holds. A verifier told the result is expected to be correct will find it correct, and the author's reasoning is the least tested thing in the record, it was written after the result.

**What the author believes about the claim goes in as a question with its premise, or stays out.** That covers a suspected flaw, a property a step lacks, and what the claim would settle. Name the step and leave the property to the verifier.

#### What the brief instructs

1. **Inventory the hypotheses first.** List every hypothesis the statement carries, then every hypothesis of every theorem the proof imports, then check each against the object it is applied to. **Then check which of them the written proof actually uses**, a hypothesis nobody uses and a step using a hypothesis nobody stated are both findings. **The recurring failure in this programme is an unstated assumption, not a bad manipulation**, one route died because a cited theorem assumes a *unital* algebra and $\mathcal W_n$ has no unit.
2. **Quantifier order and scope.** Where a bound is taken, over what, and whether a $\sup$ was distributed across terms sharing a variable.
3. **The edge of every range.** The boundary of each stated interval, the crossover $n=6+2\sqrt7$, the smallest admissible dimension, and $\ker W\ne0$, **the kernel is this record's recurring obstruction**, and a check run only on objects with trivial kernel never reaches it.
4. **The gap between what is proven and what is used.** A result proven on a subfamily and cited in general is a finding.
5. **Read a formal statement against the record's before reading its proof**, quantifiers, hypotheses, the direction of every inequality. A file that type-checks a different claim reports a guarantee the record does not have, and the kernel cannot object.
5. **Whether the Lean statement is the claim.** Where [lean/INDEX.md](../../../lean/INDEX.md) names a file for the result, read its `theorem` line against the record's sentence: the binders, the hypothesis set, the direction of every inequality, and the type each variable ranges over, `ℚ` against `ℝ` is a different theorem. **A file that type-checks a different claim is worse than none**, because it reports a guarantee the record does not have, and nobody re-reads a statement the kernel has already accepted.

#### Silence is not a verdict, every attack line is answered explicitly

**A verifier answers every item on the list below in writing, including the ones where it found nothing.** *"No finding: the statement carries no quantifier over $n$ that the proof does not use"* is an answer. **Saying nothing is not**, and it is the single largest source of missed defects: an item nobody thought about and an item checked and cleared look identical in a report, and only one of them is safe.

The list is fixed so that omission is visible when the round clusters. **A report missing an item is returned to its verifier rather than counted.**

#### The traps this record actually falls into, checked by name, every round

Carried in every brief, because these are where this programme's real errors have been, and a general instruction to "look for edge cases" does not reach them:

- **$\ker W\ne0$.** A check run only on sphere products never reaches it, since they have trivial kernel. Ask what the statement says at a padded object.
- **The boundary of every stated range**, the smallest admissible dimension, odd $n$, and the crossover $n=6+2\sqrt7$.
- **A claim proven on a subfamily and used in general**, the gap between what the proof reaches and what the record cites.
- **A hypothesis stated but never used**, and a step using a hypothesis never stated. Both are findings.
- **A universal claim with no witness.** "Every member has…", "none is…", the verifier's job is to try one object from each structured family the record names: diagonal, padded, subalgebra-Casimir, sphere products, $\mathbb{CP}^m$, the tori. **Random objects cannot see these failures**; the record's own standing rule says the interesting ones live on measure-zero sets.
- **An imported theorem whose hypotheses were never checked against the object.** One route here died because a cited theorem assumes a *unital* algebra and $\mathcal W_n$ has no unit.

#### Name what would break it

**Every report ends by naming the object that, if it existed, would falsify the statement, and saying what was done to look for it.** A verifier that cannot say what a counterexample would look like has read the proof without understanding what it claims, and its `PROVEN` carries no weight. This converts passive reading into an active search, which is the difference between checking a proof and skimming it.

#### A verifier CHECKS the written proof. It does not build its own.

**The job is to read what is written and ask, line by line, whether it follows.** Does this step follow from the previous one and from the hypotheses actually stated? Is every hypothesis the step uses written down? Does the chain of steps reach the stated conclusion, or something weaker?

**A verifier never supplies a missing argument.** Where a claim has no proof on file, the finding is *"this claim has no argument on file"*, full stop. It is not the verifier's job to write one, and a verifier that does hands the record a fresh proof nobody audited, arriving under the letterhead of a check. *Three verifiers on one round each derived a closed form the record had only fitted; each derivation may well be right, and all three would have entered the record as verification rather than as new mathematics.* **The correct output there is `HYPOTHESIS-DEBT`, naming precisely what would have to be proved**, and the research loop proves it, under Gate 2, where new results belong.

This is also what keeps a round cheap. Reconstructing a theorem costs twenty-five minutes and a hundred thousand tokens; checking whether a written step follows costs a fraction of that, and it is the thing the record actually needs.

**What a verifier may do, in service of checking:**

- **Test a claim against an object.** Producing $SO(5)\times SO(7)\subset SO(12)$ and reading off its spectrum to break "every member has two eigenvalues" is checking, not deriving, the claim is universal and one object settles it.
- **Follow a step's own algebra** to see whether it closes. Expanding what is written is reading it.
- **Read an imported theorem at source** and check its hypotheses against the object it is applied to. The theorem is read, never cited from memory: fetch it into [references/](../../../references/), one subfolder per source with the PDF, a text extraction and a `notes.md` saying what was checked and where. **Search-tool prose is a lead, never a citation**: a summarization layer can fabricate a reference that does not exist.

**What it may not do:** prove the lemma its own way, build machinery the proof does not use, or repair a gap it found. Each of those is the research loop's work, and a verifier doing it is no longer independent of the thing it is checking.

#### The discrepancy protocol every verifier clears

**A discrepancy found is a candidate, not a result.** Most apparent errors are the verifier's own, and reporting one costs the round an adjudication to disprove. Before writing one down, the verifier clears all three:

1. **Locate it exactly.** Name the step, quote the line, and say which hypothesis or definition it needs that it does not have. A defect that cannot be pointed at is a feeling about the proof.
2. **Exhibit the failure concretely.** The object, the parameter value or the hypothesis at which the step breaks, in closed form. *"The bound seems loose"* is not a finding; *"$SO(5)\times SO(7)$ satisfies both hypotheses and has three eigenvalues"* is.
3. **Argue the opposite.** Attempt to read the step as correct, the most charitable reading the words support, including a hypothesis the author may have meant but not written. A verifier that cannot state the strongest defence of a step has not understood it well enough to attack it.

A candidate failing any of the three is reported as `withdrawn`, with the reason. **That line has value**: it stops the next verifier spending an adjudication on the same dead end.

#### What a verifier returns

**The report follows the shape the research loop's reviewers use**, because the record's readers scan reports the same way whichever population wrote them, and a report in its own private format is one nobody reads twice. `verification/VERIFY_v<N>.md`, in this order:

1. **Title** (`# Verifier v<N>) <what was checked>`, naming the specific claims rather than the topic.
2. **A standfirst paragraph.** That the brief was cold and worked from the definitions; that **no numerical work was done and every value is exact**; and the path to the log. *Where the research loop's reviewers list the scripts they wrote, a verifier states that it wrote none, the two populations differ exactly there, and the line says so rather than leaving it inferred.*
3. **The claim table, before any prose.** One row per claim attacked, with its verdict in caps and the reason compressed to a clause. **A claim gets its own verdict** (`CONFIRMED`, `REFUTED`, `REFUTED AS STATED`, `CONFIRMED AS ALGEBRA`) so a lemma that is right in substance and wrong as written comes out of the table saying exactly that. This is the part a later reader actually consumes.
4. **The one-line summary.** One sentence carrying what the round should do. *"The contraction is right and the conclusion drawn from it is wrong"* is the model: a sentence someone can act on without reading the derivation.
5. **`## 0. Conventions, fixed once`**, the notation, normalisations and index conventions the report uses, quoted from the brief rather than restated. Half this programme's disputes have been convention mismatches, and fixing them in one place before section 1 is what makes a derivation checkable by someone who did not write it.
6. **The hypothesis inventory**, every hypothesis of the statement and of every imported theorem, each checked against the object it applies to. **This is the verifier's own contribution to the format and it is not optional**: a pass with no inventory is not a pass.
7. **Numbered sections, one per claim**, carrying the derivation in full, not a summary of a derivation. Each candidate discrepancy shows its three-step record: the independent re-derivation, the concrete failure in closed form, and the defence attempted. Withdrawn candidates get their own subsection with the reason.
8. **The verdict** for the result as a whole, from the vocabulary below.

**A verifier's own numbering is local**, the round renumbers when it clusters.

**A pass with no hypothesis inventory is not a pass.** Unanimous agreement that a proof is correct is the *weakest* signal a round produces: three cold readers can share a blind spot, and this record's failures are unstated hypotheses rather than visible errors. What makes a pass mean anything is the enumeration of what was actually checked.

Each verifier logs to `agent_logs/verify-<id>-v<N>.log`: first line with PID and phase plan, a line per phase transition, **a line at every tool round carrying live state**, and a closing `DONE <verdict>` or `FAILED <reason>`. **The closing line BEGINS with `DONE` or `FAILED`, with nothing before it, and it is the LAST line written to the file**, the Stop hook anchors closure to the start of a line and reads only the end of the log, so a timestamp before it, or a remark for the caller appended below it, leaves a finished verifier reading as one still in flight, and the loop's own continuation goes silent for as long as that log looks live. A remark for the caller belongs in the report. **Put the requirement in the brief in those words**, since a brief asking only for "a closing `DONE`" gets the prefix.

**The heartbeat is keyed to tool rounds, not to the clock.** A wall-clock interval is unenforceable here and asking for one produces silence that looks like a stall: *a verifier reasoning for twenty minutes between tool calls cannot meet a wall-clock interval, and its silence is indistinguishable from a stall.* **So a verifier that is about to think for a long stretch says so in the log first**, naming what it is about to derive, and the loop reads a long gap as depth rather than as death. **State the log paths at launch.** Poll PID liveness rather than a bare sentinel, and **read the last lines for content**, a verifier that has just broken the lemma writes it into the log the moment it finds it, long before its report is assembled.

**A COMMAND A GATE CAN REFUSE IS THE ONLY THING IN ITS CALL.** *A refused gate discards the WHOLE call, so anything chained with it never ran, and the retry repeats only the part the error names, silently without it.* **The damage is that the retry SUCCEEDS**, a commit whose staging was discarded landing with the other files while the gate passes. *Stage, edit and commit in separate calls.*

A verifier commits its own report as soon as it is written (`verify(<id>): v<N> <verdict>`) so an interrupted round loses nothing. Its scope is its own report plus any [references/](../../../references/) folder it created. Nothing else. **Verifiers share one index**, so each reads `git status` first, stages by path, and checks that what it commits is what it staged; a sibling's staged file is named in the report and left alone, since a commit describing one report and containing two is repairable only by a rewrite. **AND NAME THE PATHS ON THE COMMIT ITSELF, `git commit -- <paths>`**, or clear `git diff --cached --name-only` of anything you did not write first. *Staging by path does not reach this: `git commit` writes everything STAGED, so a sibling that staged between your add and your commit rides in under your message, and every agent involved staged correctly.* **It also makes `report and index row in one commit` achievable**, which it is not while the shared index is committed whole.

### Phase 2, cluster the findings

Read the reports back in the session. **Cluster before adjudicating**, and write the clustering table into the round file so the round is auditable.

- **Two findings are the same finding when they attack the same step by the same mechanism.** Same step by different mechanisms is two findings.
- **Cluster by the step, never by the wording.** Verifiers describe one defect in three vocabularies, and matching on words splits one finding into two, which buys a second adjudication on a question already asked.
- Where a merge is genuinely unclear, keep the findings separate. A separate finding costs two verifiers; a wrongly merged pair costs a repair aimed at the wrong step.

Each cluster gets a round-local id, the step it attacks, and its mechanism. **Support is recorded and does not classify.** Every distinct finding goes to phase 3, however many verifiers raised it: at two or three draws the count is too thin to route on, and a defect only one reader saw is the case this loop exists for.

| findings | what happens |
|---|---|
| one or more | each goes to phase 3 and is adjudicated |
| none, from every verifier | **PASS**, subject to the inventory rule below |

**A pass rests on the inventory, not on the silence.** Independent readers converging on "no defect" is weak evidence of correctness, because a shared blind spot produces exactly that. What makes a pass mean anything is the enumeration each verifier returns of what it actually checked: **a thin or generic inventory is a failed round to be re-run, not a pass**, and the round records what each checked rather than the word "correct".

#### Two checks that cost nothing, run before any adjudication

**1. Re-read the brief against the source.** Compare the quoted statement to the file, line by line, at the recorded `file:line`. A mis-transcription produces a finding every verifier shares, because every verifier inherits it and nothing in the reports can see that, and it otherwise buys an adjudication on a defect that exists only in the brief. This is the first thing checked whenever the reports say a step does not follow, or call the statement incoherent or ill-posed.

**1c. A MISSING OR INCOMPLETE THIRD FORM IS ACTED ON, NOT ONLY NOTED, AND IT OUTRANKS THE ROUND'S OTHER REPAIRS.** *Where [lean/INDEX.md](../../../lean/INDEX.md) has no row for the id under audit, or a `partial` row owing the very step the block rests on, the round **files the row itself**, at the head of [lean/INDEX.md](../../../lean/INDEX.md)'s `ready` queue, naming the id, the statement in one line, and **every binder a faithful statement would need**.* **The verifier supplies the binders and never the file**: it has just read the prose more closely than anyone, so it knows what the hypotheses are, and writing the statement would be deciding what the record meant, the thing under audit. *A statement written by its own auditor type-checks and then looks authoritative; one was recorded on this project that was false at odd $n$ for exactly that reason.*

**Where the session can run the [lean-loop](../lean-loop/SKILL.md), it does, in the same turn.** *A handoff that waits for another session is a handoff that waits*, and this loop has filed several that nothing collected. **A filed row with named binders is the minimum; a formalised statement is the deliverable.**

*The priority is not aesthetic.* **An id with no third form is one where the loop's most common finding (a statement carrying hypotheses its box does not) cannot be checked mechanically at all**, so every later round on it repeats the same judgement call by hand.

**1b. Compare the three forms, not two.** [findings/](../../../findings/), [results.md](../../../results.md) **and the Lean statement where [lean/INDEX.md](../../../lean/INDEX.md) names one.** *A difference between any pair is a finding, and the Lean form is the one that settles hypotheses: a binder cannot be omitted the way a clause can.* **Say which form you checked and what each carries that the others do not.**

**2. Search the WHOLE record before accepting "no argument on file".** A verifier's finding that a proof is missing is a claim about the brief, not about the record, the brief withholds the record by design, so a verifier cannot tell "no proof exists" from "the proof was not shown to me". Before that finding is acted on, the loop searches [findings/](../../../findings/), [results.md](../../../results.md), [report/](../../../report/) and [ATTEMPTS.md](../../../ATTEMPTS.md) for the argument itself.

**A unanimous "the argument is absent" commonly means the argument sits elsewhere in the record and the findings file's pointer is wrong**, a far smaller defect than a missing proof. **A finding the search resolves is not adjudicated**: the round file names the line that carries it, and the repair is a pointer to that line.

### Phase 3, adjudicate: two verifiers per finding

**Two fresh verifiers per finding, cold, dispatched together.** One verifier's judgement is not a result; two independent readings of the same question are. **Two rather than three because three resolves a 2–1 split by vote**, and this loop holds that a disagreement about a proof step is not a thing to average, at two, agreement decides and disagreement goes to derivation.

**The adjudicators are asked a neutral question, never given the accusation.** They receive the step, the definitions, and *"prove this step valid as written, or exhibit where it fails"*. They do not receive the finding's argument, the raising verifier's number, or the fact that anyone objected, that is the anchoring this phase exists to escape. **The one exception**: where the finding is a proposed counterexample object, the object is given, because an object is checkable rather than suggestive.

**The neutral question is also the defence.** *"Prove this step valid as written"* asks for the strongest reading the words support, including a hypothesis the author may have meant but not written, so the case for the old text gets made before anything is deleted, by readers who were never told it was under attack. **A loop that deletes mathematics on agreement alone, with nothing arguing the other side, has no defence against a correlated error**, and correlated error is what independent readers produce when they inherit a convention from the same source.

| outcome | result |
|---|---|
| both find the step fails | **Confirmed.** Proceeds to phase 4. |
| both find the step valid | **Withdrawn**, recorded with the reason so it is not re-found. The defence goes into the round file: it is the strongest case for the old text, and a later round reopening this one will want it. |
| they split, or either returns `UNRESOLVED` | The loop settles it inline by deriving the step itself. **If it cannot, the round stops and hands the split to the user**, an unresolvable disagreement about a proof step is not a thing to average. |

The adjudicators take the next `v` numbers and file the same way.

**A finding about material the round has disowned transfers instead of being adjudicated.** Where another finding has established that a section is *not this result's argument*, a finding attacking that section belongs to whichever result the section actually supports: adjudicating would spend two verifiers on a question filed under a result the section does not bear on. **The transfer is recorded in both round files and in [plan-verification.md](../../../plan-verification.md)**, and the receiving round carries it as a pre-registered question in its phase 0, never as a verdict, since no adjudication ran.

#### What a finding must exhibit before it can delete anything

- **A named object, not a general argument.** "$SO(5)\times SO(7)\subset SO(12)$ satisfies both hypotheses and has spectrum $(42,20,-24)$" can be checked by the loop against the record independently of the verifier that found it. "The bound is not tight" cannot.
- **Closed form, so the check is exact.** A witness the loop cannot verify from the record's own definitions is not yet a witness.
- **The removed text, quoted verbatim in the round file**, before it leaves the findings file. The findings file carries no history (that is the core rule) so [verification/ROUND_&lt;id&gt;.md](../../../verification/) is where the deleted passage survives in readable form, beside the reason it went.


### Phase 4, the dependents, before any repair

**A confirmed defect is traced to every result that rests on it, and the trace is transitive.** The fix is local; the damage is not. **A round that repairs the lemma and stops has done the easy half**, the expensive failure is a corrected result whose dependents keep citing the version that was corrected, because nobody enumerated them.

#### 1. Build the dependent set, and do not trust the number search

`grep -rn "Lemma <n>" findings/ results.md plan.md routes.md reviews/ report/` is the **start**, not the answer. **A dependent that cites the result by its statement rather than by its number is invisible to it**, and that is the common case in a record where results were renumbered after they were written. So the search runs three ways:

- **By number**, `Lemma <n>`, `result <n>`, and the id form.
- **By the statement's own signature**, the distinctive symbols, the closed form, the named object, the constant. A result asserting $\theta\le\tfrac2n\sqrt{rN/(N-r)}$ is found by that expression wherever it is used unattributed.
- **By the file that owns it.** Read the findings file's own index row and the sections around the block: a neighbour that uses a result four paragraphs later rarely names it.

**Read every hit.** Counting them overstates the damage and hides which ones matter. Each is classified **load-bearing** (the cited statement is used in an argument) or **mention**, named in passing.

**And hunt for COPIES of the statement, not only for citations of it.** A result stated twice in full is not a dependent, it is a second original, and **a fix applied to one leaves the other standing and correct-looking**. Nobody re-reads the copy, because nothing marks it as a copy.

**A block announcing it was moved out of another file is not evidence the other file stopped carrying it.** The original commonly still holds byte-identical text, so a correction made in one place leaves the other asserting the uncorrected version.

So the search runs one more way: **take a distinctive sentence of the statement and grep it verbatim across [findings/](../../../findings/), [results.md](../../../results.md) and [report/](../../../report/).** Every full copy found is listed in the round file, and **phase 5 corrects every copy in the same commit**, or, better, collapses them to one and leaves a link, which is the only fix that stops the divergence recurring.

#### 2. Close the set transitively

**Every dependent that loses its support becomes a defect in its own right, and its dependents are traced the same way.** Repeat until a pass adds nothing new. **Record the chain, not just the set**: `L<a> → L<b> → L<c>` says which result carried the damage where, and a later round reopening one of them needs to know.

*A knock-on effect is not a footnote to the finding. It is the finding, arriving one result later.*

#### 3. Re-check each dependent against the CORRECTED statement, one line each

**Marking a dependent broken because its support moved is as wrong as leaving it alone.** Most survive, because most uses need less than the statement claimed. So each load-bearing dependent is read against the corrected version and dispositioned:

| disposition | meaning | what it costs |
|---|---|---|
| `SURVIVES` | The use needs only what the corrected statement still gives. | One line in the round file saying which part it uses. |
| `NARROWED` | The use needs the corrected statement plus a hypothesis it does not check. | The dependent's own text is corrected to state that hypothesis, and it re-enters the queue. |
| `UNSUPPORTED` | The use needs the part that fell. | `UNDECIDED, depends on L<id>` **written into the dependent's own block**, replacing its status text rather than sitting beside it, and the id re-enters the queue at the top of tier 1. |

**A `SURVIVES` verdict is stated with its reason.** "Probably fine" is how a broken dependent stays on the record for a year.

#### 4. Classify the impact of the whole finding

| class | meaning |
|---|---|
| `CONTAINED` | The step is wrong; its conclusion is reached another way already on the record, and every dependent `SURVIVES`. |
| `NARROWS` | The proof establishes less than the statement claims, and some dependents are `NARROWED`. |
| `PROPAGATES` | At least one dependent is `UNSUPPORTED`. The chain is recorded and every id on it re-enters the queue. |
| `FATAL` | A headline result or a live route falls. **The loop re-ranks the queue itself, in the same round**, and records the new order with the reason that forced it as a *Queue changes* entry, a fallen route's dependents are demoted or retired, and the ids that fed it re-enter at the top of the tier the fall exposes. *The round that found the fall knows what fell and what rested on it, which is what the ranking turns on; a loop that parks instead stops at the moment its own evidence is freshest.* |

#### 5. Check the route register and the fence posts

A result that closed a route, or that a fence post rests on, reaches [routes.md](../../../routes.md) and [fence-posts.md](../../../findings/fence-posts.md). **A fence post resting on a broken lemma is worse than no fence post**, it is a route wrongly closed, and nobody reopens a closed route to check. Both files are corrected in the same edit as the findings file.

#### 6. Ask whether the defect is one of a class

**A defect produced by a process is rarely alone.** Where the finding came from how a block was written, a pass that created several results the same way, a batch of statements moved from one file to another, a family of blocks pointing at their arguments rather than carrying them, **the siblings are enumerated and listed in [plan-verification.md](../../../plan-verification.md) as a candidate class**, with the sibling ids named. They are not verdicts: each is settled by its own round. *Finding one instance of a batch defect is evidence about the batch in a way an isolated error is not, and the enumeration costs one grep.*

**The round does not close while any load-bearing dependent is undispositioned.**

### Phase 5, fix, narrow, or retract

Exactly one of three, chosen on what the evidence supports rather than on what is recoverable:

- **Repair**, a new proof of the same statement.
- **Narrow**, the statement is weakened to what the proof establishes.
- **Retract**, the statement comes off the record, and [ATTEMPTS.md](../../../ATTEMPTS.md) gets the entry saying what it was and why it fell.

**A repair is a NEW result and is not blessed by its author.** It enters the queue unchecked, at the top of the tier its dependents live in, and gets its own round. A round that repairs a lemma and marks it verified in the same breath has verified nothing.

**A hypothesis added to save a lemma is checked against every use of it.** The cheap repair is to add the hypothesis that makes the proof go through; the failure is that no citation satisfies it, so the lemma is saved and every dependent is broken silently. **Name the added hypothesis, then check each load-bearing dependent against it, in the round file, one line each.** A lemma nothing satisfies is a retraction wearing a repair's clothes.

Corrections land in the findings file that owns the subject, and **the old text is deleted rather than annotated**, see the core rule above. Concretely, in the file:

- **A wrong statement is overwritten** by the corrected one. The old wording does not survive in a parenthesis, a footnote, a struck-through line or a "previously this said" sentence.
- **A wrong pointer is replaced by the thing it should have pointed at**, not by a note explaining that it was wrong.
- **A narrowed claim is restated at its true scope.** The wider version is not kept beside it for comparison.
- **At most one line of provenance stays**, the verdict and the round that issued it. Everything else about the error goes to [ATTEMPTS.md](../../../ATTEMPTS.md).

**Check the diff for growth.** A repair that makes the findings file substantially longer is usually a repair that added text around a defect instead of removing it; read it again before committing. The chronology goes to [ATTEMPTS.md](../../../ATTEMPTS.md), the index row changes where the kind changes, and [results.md](../../../results.md) changes where the result is canonical.

### Phase 6, file the round and take the next id

1. **Finish [verification/ROUND_&lt;id&gt;.md](../../../verification/)**: the clustering table, the adjudication outcomes, the withdrawn candidates with their reasons, the spread, the impact class, and what was changed.
2. **[verification/ROUND_&lt;id&gt;.md](../../../verification/) is the index of the round**, naming every verifier and its verdict. Nothing is written to [reviews/INDEX.md](../../../reviews/INDEX.md): that index belongs to the research loop's reviewers, and mixing two populations there makes a verifier's verdict read as a Gate 2 verdict, which it is not.
3. **Move the id in [plan-verification.md](../../../plan-verification.md)** from *To check* to *Checked*: delete its box from *To check*, so nothing stays there ticked, and add one line under *Checked* carrying the id, the verdict and a link to the round file. **The round file carries the verifiers, the findings and what changed**, and a second copy in the queue grows into paragraphs that nobody keeps in step. Ids that a `PROPAGATES` finding reopened are added to *To check* at the top of tier 1 in the same edit.
4. **Take the next id and open its round in the same turn.**

## Improving this skill, one house format for a proposed change

**A round that exposes a flaw in this file proposes the fix at the end of the round, and never applies it silently.** The rules here decide what counts as a defect and what may be deleted, so a loop that rewrites them mid-run can define its own failures away.

**The format is defined once, in [structure-check](../structure-check/SKILL.md) under "How a proposal is written", and this skill uses it unchanged**, a blockquote carrying what it fixes, the current text, and the replacement with every changed word in CAPITALS. One format across the skills, stated in one place, so a proposal reads the same whichever loop raised it.

Three things a round should look at before closing:

1. **A rule that produced the wrong outcome.** A verdict the adjudication forced and the mathematics contradicts, or a clustering rule that split one defect into two.
2. **A failure this file does not describe.** Something plainly wrong that no phase names.
3. **A rule that has never fired.** Either nothing has triggered it, or it does not work. Say which you believe.

## Verdict vocabulary

The round closes on exactly one verdict for the result, and each finding carries its own.

| Verdict | Meaning |
|---|---|
| `PROVEN` | The proof is correct and complete as written, and the round says what was checked. |
| `PROVEN, hypotheses corrected` | Correct once a hypothesis missing from the statement is added. The hypothesis is stated and every dependent checked against it. |
| `GAP` | A step is unjustified. The conclusion may hold; this proof does not establish it. |
| `BROKEN` | The statement is false, or the proof errs unrepairably at that step. |
| `HYPOTHESIS-DEBT` | The support is numerical only. Names precisely what would have to be proved. |
| `UNDECIDED, depends on <id>` | Carried by a dependent of a broken result, pending that result's repair. |
| `UNRESOLVED, needs computation` | The round cannot settle it analytically. Names the quantity and what its value decides; handed to the research loop. |

`UNRESOLVED` and `UNDECIDED` are honest verdicts and are preferred over a `PROVEN` the round cannot defend.

**A debt the round can discharge, it discharges, in that round.** A standard fact with no source on file is derived and put through Gate 2 before it lands: two reviewers, identical briefs. *The rule against supplying a missing argument guards against an unaudited proof entering under a check's letterhead; a derivation two adversarial readers have attacked is not that.* **Only what the round cannot write routes to [plan.md](../../../plan.md)**, with its theorem named. **Routing means writing the item into [plan.md](../../../plan.md), in that round. A debt named in the round file is queued nowhere**, *the research loop reads the plan, and a "queued elsewhere" heading is a note in a file no loop opens.* **The round file records what was found; the plan records what is owed, and a round that closes without moving its debt has dropped it.** The test is whether the proof can be written, not whether it is new to this record, and never how many rounds have already booked it, since each of those was a round that could have written it.

## Independence, what breaks it

Independent verifiers are worth their count only while nothing correlates them. Each of these collapses the round to one draw, silently:

- **A paraphrased statement.** Every verifier inherits it. Quote, and record the source lines.
- **The author's reasoning in the brief.** Every verifier inherits it, and it is the least tested thing in the record.
- **Any prior verdict, verifier number or confidence signal.**
- **Verifiers reading each other.** Each writes its own report and reads no other; none reads the round file, the ledger, or another's log.
- **A shared convention taken from one constructor.** Independent readers who inherit a sign or a normalisation from the same source report the same error and agree, which reads as corroboration. **A verifier's numbers are not evidence until rebuilt from the object's own definition**, which, in this loop, means rebuilt by derivation.
- **Settle a convention against a derived identity, never against a numeral the record wrote.** When two readings of a symbol are in play, point at a statement the wrong reading makes FALSE, an identity with residual zero, a proved equality case, a sharp constant. *A reading that merely rescales a bound has changed the units and falsified nothing, so citing that bound holds the conclusion as its premise.* **The identity is usually already on file in the file that CONSUMES the symbol rather than the one that defines it**, so search the consumers, and prefer one whose statement is an equality.


## Commits

- Verifiers: `verify(<id>): v<N> <verdict>`, scope their own report plus any [references/](../../../references/) folder they created. **Never anything under [reviews/](../../../reviews/) or [scripts/](../../../scripts/).**
- The round: `docs(verify): <id> <verdict>` for the round file and the [plan-verification.md](../../../plan-verification.md) edit.
- A repair or retraction: `fix(<subject>): <what changed>`, the findings file, [ATTEMPTS.md](../../../ATTEMPTS.md), and [results.md](../../../results.md) where canonical. The message names the round and the verifiers behind it.

**Commit each unit as it completes, not at the end of the round.** This repository is written by several sessions at once, and an unstaged file is swept into whoever commits next, landing inside another thread's commit under a message describing something else. *A rule that tells the agents to commit and says nothing about the loop leaves the loop's own repair uncommitted while every agent's report lands on time.*

The format is in [CONTRIBUTING.md](../../../CONTRIBUTING.md). **If [.claude/research-loop-active](../../../.claude/) names this session**, `feat(` and `fix(` commits also need the `Deliverable:` and `Searched:` trailers that [cycle_deliverable.py](../../../.claude/hooks/cycle_deliverable.py) enforces.

## Running alongside the research loop

**This loop writes to the record**, the findings files, [results.md](../../../results.md), [ATTEMPTS.md](../../../ATTEMPTS.md), so it collides with a live research cycle over the same files and the same `.git/index`. Run it while the cycle is idle, or give it its own worktree:

```
git worktree add ../hamiltons-cubic-verify -b verify-<yyyy-mm-dd>
```

**Do not arm [.claude/research-loop-active](../../../.claude/) for this loop.** That flag routes the Stop hook to the research loop's task list, which is the wrong list: the hook would name a `SECTION 1` item after every round. Continuation here is the skill's own rule, below.

## Continuation is the default

**The loop runs until a stop condition fires, and every turn continues into the next action.** The test is mechanical: **a turn's last action is a tool call, not prose.** If the closing message would end by naming what comes next (the next id, an adjudication to dispatch, a dependent to re-check) that sentence is the instruction to keep going.

What makes this fail is never forgetting it. It is that a round *feels* finished: the verdict is filed, the plan is consistent, the commit is clean. **None of those is a stopping point.**

## Stop conditions

Stop and hand back when: the user interrupts; an adjudication splits and the loop cannot settle it by derivation; a finding is `UNRESOLVED, needs computation` and the user must decide whether to route it to the research loop; or a repair would need new mathematics rather than a correction, which is a research task and not this loop's.

**Reporting a verdict is not a stop condition. Neither is asking whether to continue.**

## Editing this file

**An edit here follows [editing-skills](../editing-skills/SKILL.md)**, when it is allowed, where the lesson goes, and the verbatim report it owes.
