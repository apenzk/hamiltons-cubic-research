# Computational practice

Reactive guidance: consult this when a cycle is about to run something. **It does not license running something**, that decision is [SKILL.md](SKILL.md)'s, where numerics are a last resort. These rules make a run correct once it is already justified. Each was paid for by a failure in this project.

## Where code lives

**Every script gets a line in [scripts/INDEX.md](../../../scripts/INDEX.md) in the same edit that creates it**, except a reviewer's one-off `review_rNN_*.py`, which goes in [scripts/INDEX-reviewers.md](../../../scripts/INDEX-reviewers.md). The split exists because one-offs grew to swamp the reusable machinery, which is the one thing the index is for. Indexing lapses silently and compounds: once behind, nobody reads it, and it falls further behind.

**A module something imports lives in [scripts/lib/](../../../scripts/lib/); a script nothing imports lives in a sibling subfolder** (`reviewers/rNN/`, `route-b/`, `runs/`, `pipelines/`, `misc/`). Put the library on the path with `sys.path.insert(0, 'scripts/lib')` resolved from the repo root, so depth never matters. **Never use a `__file__`-relative insert**, it silently points at the script's own folder once the file is filed, and a large batch of scripts once had to be rewritten for exactly that. A file needing the repo root walks up looking for `plan.md` rather than counting levels.

**A number the tree cannot regenerate is not a result.** Work typed into a shell produces figures that reach the record while the code disappears: nobody can re-run it, and a later audit disagreeing with it has nothing to compare against. The script exists in [scripts/](../../../scripts/) and is indexed *before* its number enters the record.

## Running it

**Verify through the scripts that already exist.** Most checks are a variant of one already in [scripts/](../../../scripts/). Compute is free and output costs tokens, run widely, report narrowly.

**Choose the lane before launching, from the shape of the work, not after the first kill.** A bounded job gets a generous explicit timeout; one of genuinely unknown length goes to the background. The harness cap is a *setting* (`BASH_DEFAULT_TIMEOUT_MS` and `BASH_MAX_TIMEOUT_MS`) so raise it once rather than re-scoping three runs smaller against the same ceiling.

**Every long-running script prints progress, and its first run is scoped to finish.** A silent job gives no way to tell convergence from a stall, so it gets killed with nothing to show.

**Compute at a generic parameter value, not merely the smallest reachable.** The cheapest dimensions are frequently degenerate, where families collide and multiplicities merge, so a pattern read off them describes the exception. Reach one value past the smallest before believing a spectrum, a count or a closed form.

**A timeout measures the implementation, not the problem**, the cost observed is the cost of the code written. Establish where the time actually goes before recording anything as infeasible; the gap between naive and well-written is routinely two orders of magnitude.

**When a computation stalls, characterise the object instead of enlarging the machine.** Stop building the ambient apparatus (a basis of the whole space, a full operator matrix) and find a direct description of the object: its projectors, its support, the equations it satisfies. That typically costs a fraction of one heavy run and removes the ceiling rather than raising it. **The signal to switch is the second timeout, not the fourth.**

## Processes

**Launch background jobs through the registry, and kill each the moment its answer is read.** `job.sh run <label> <cmd...>`, `job.sh list`, `job.sh kill <label>`. A job stops being useful the instant its question is settled, and nothing stops it running. Say the same in a subagent's brief, so its jobs are registered too.

**Never kill by a pid read out of `ps`.** Pids are reused, so a number noted minutes ago can name an unrelated process. The registry records the pid *and* the launch command line, and refuses to kill anything whose live command line no longer matches.

**Cap BLAS threads at launch: `OMP_NUM_THREADS=2 NUMEXPR_NUM_THREADS=2 MKL_NUM_THREADS=2 VECLIB_MAXIMUM_THREADS=2`.** An uncapped `numpy` call spawns a thread per core, so one worker can hold nearly the whole machine while its siblings starve.

**The registry sees workers, not watchers, and neither survives review, sweep for both.** `job.sh list` reporting every job dead is **not** nothing running:

- A **wait-loop** written `until ! pgrep -f "<script> <args>"` never exits, because the wrapper carries that string in its own command line and `pgrep -f` finds the waiter. Wait on the artefact instead, the output file, a `DONE` line, or a pid captured at launch (`p=$!`, then `kill -0 $p`). Where a name must match, exclude the waiter: `pgrep -f "[<]script>"`.
- A subagent's Python child **outlives the shell that started it**, orphaned at `PPID 1`, still holding a core with its output file already closed so nothing can read what it computes.

Sweep whenever a reviewer finishes, not when the machine is noticed to be hot, and kill a watcher **before** the job it watches:

```
ps -eo pid,ppid,%cpu,etime,args | awk '$2==1 && /Python/'
```

*Each form of this failure looks different and has one cause: the compute is legitimate and nobody is watching what it costs.*

**Stage by path, never `git add -A`.** A blanket stage sweeps in whatever else the tree holds, a file deliberately held back for approval, another session's work in progress, a reviewer's scratch, and buries it in a commit whose message describes something else entirely. The commit log then fails to record that the held file changed at all, which is worse than an unapproved commit: it is an invisible one. **Name every path being committed**, and when something is being held, say so in the message of the commit that goes in beside it.

**Chain the edit and its commit with `&&`, never a newline.** A heredoc edit followed on the next line by `git add && git commit` runs the commit *even when the edit failed*, a stale anchor raises, the script exits nonzero, and the commit lands anyway carrying a message that describes changes the commit does not contain. **That is worse than a failed edit**: the record reads as corrected while being unchanged, and the commit log becomes evidence for a fix that was never applied. Make the edit script's exit status gate the commit, and have it assert every anchor before writing.

## Never verify a formula against the code that produced it

**A formula and the code implementing it share every error in the derivation, so running that code confirms nothing about the formula.** If a factor was dropped on the way to the formula, it is dropped in the implementation too, and the agreement is guaranteed rather than informative. **Check against an independent construction**, a different route to the same quantity, an explicit object whose value is known, or a case the record already settled.

*The failure produces false confidence rather than visible error: a wrong formula confirmed by its own implementation enters the record as verified, and nothing downstream re-examines it.*

**A REIMPLEMENTATION IS RUN ON A KNOWN VALUE BEFORE ITS DISAGREEMENT IS BELIEVED.** *Reproduce a value the record already carries, and assert the agreement, before using the code to compare anything.* **One that has not reproduced a known value is evidence about itself and nothing else.** Where no such value exists, that absence is the finding.

*The failure is silent in the favourable direction: a broken implementation that AGREES harms nothing, while one that disagrees reads as a discovery, so the error surfaces only when it is acted on.* **The order is the whole rule**, since reaching for the control after a disagreement appears is reaching for it exactly when the disagreement makes the new code feel vindicated.

**This is the implementation-side twin of [the section below](#a-check-whose-outcome-its-own-construction-determined)**, which covers a check whose *construction* fixes its outcome; here it is the check's *code* that carries the fault.

## A check whose outcome its own construction determined

**Before offering a computation as evidence, name the term it is meant to discriminate and confirm that term is nonzero on the family it will run against.** A check that could not have failed looks exactly like one that passed.

**Three shapes, all of them seen:**

- **The check rewrites its own input.** An identity assembled as a weighted combination of relations the record already proves tests only the transcription, once the weight on the one *conditional* relation is nonzero, so an agreement to many digits is the conditional relation's own residual pushed through a linear map.
- **The argument consumes only what it is testing.** Substituting an identity back into the equation it came from returns a tautology for any true $a+b+c=d$, with none of the operators in question involved, so the conclusion may be right and the reason empty.
- **The family zeroes the disputed term.** A flat on which every added term vanishes, or a first-order identity blind to a second-order sign, passes whatever it is given.

**This is the failure that leaves a screen worthless while looking like a screen that passed**, which matters here in proportion to how much the programme rests on screens.

## Which side a number bounds, and how you got it

**Every measured number is a floor or a ceiling, and the method decides which, so write that down beside it, because in a table the two are indistinguishable.**

- **A search that climbs to a best value has *attained* it.** That makes it a **lower** bound on the true maximum, and it can never cap anything: the real maximum may be higher, wherever the search did not look.
- **A sweep over a compact grid with a modulus of continuity gives an upper bound**, because it accounts for the points between samples.

*The same figure reads correctly as a witness and incorrectly as a ceiling, and nothing in the number distinguishes the two uses.* **State the kind at the moment of recording**, since the number outlives the memory of how it was produced.

## Trusting the answer

**Before believing a negative, measure what the test returns when there is nothing to find.** A positive control says the instrument can fire; it does not say how far apart two things look when they are the *same* thing. A distance scored against a sampled reference carries a spread from the sampling, and in high dimension a few hundred points cannot cover twenty dimensions, genuine members sit as far out as strangers. Run on held-out known members and report the observation against that null. Inside the null is **no** evidence, not weak evidence.

**A control drawn from a distribution that avoids the counterexample family cannot see it.** Random elements of a space miss its structured subfamilies entirely, so a screen against random draws passes claims that a structured family refutes outright. Name the structured families in every screen. **The catalogue is itself a biased sample** for the same reason: "holds at every point we have" is evidence about how the catalogue was built.

**Test a projector off the subspace, never on it.** Checking that a projection fixes elements already in the target confirms idempotence and nothing else, a map removing non-orthogonal components passes that test while failing to land a general input on the subspace. The result is a start vector off the space by a fraction of a percent, which never announces itself.

**Suspect the instrument when a screen answers uniformly, impossibly, or uninterestingly.** The same value at every point, a bound that violates what it bounds, a result that makes the question pointless, each is more often a broken screen than a fact, and each still prints numbers, so nothing looks wrong.

**The check is one line: run the screen on a case whose answer you already know is different.** A screen that cannot distinguish two cases you can tell apart by hand is measuring something other than what it claims.

**Use SVD, not QR, for subspace work.** A QR factor's leading columns span the column space only when the leading input columns are independent; taking them regardless has reported gross failure where the truth was machine zero.

**A constant entering a bound is a supremum over the whole admissible set, found by ascent, never by sampling and never off a single point.** Random draws understate a supremum badly in high dimension. Name the set, maximise over it, and treat a generously small figure as a reason to check.

**A check described as exhaustive is generated by enumeration, and lives in [scripts/](../../../scripts/).** A hand-written case list reads as complete to whoever wrote it, because the cases that come to mind are the ones already understood; the omitted ones are where the counterexample sits.

**A tooling call's silence is not a mathematical statement.** An empty solver result or a filter keeping nothing is a fact about the call. Predicates on symbolic objects are three-valued, so filtering by one discards everything it cannot decide. Restate a computed absence as the positive claim actually needed, and establish that.

**A correction is not finished until you have grepped for its shape.** After fixing a claim, search the record for the *pattern* that made it wrong rather than for the claim's wording, the other instances rarely share phrasing, and they are found by what the error was, not by what the sentence said.

**Do it in the same turn as the fix.** A defect folded in and left unpropagated reappears as a fresh finding from the next reviewer, and each rediscovery costs a round trip while the record carries the error in the meantime.

## Reviewer scope

**A rule the user sets mid-flight reaches new agents automatically and running ones not at all.** Briefs are fixed at launch, so a reviewer spawned before an instruction keeps working under the rules it was given, and will do exactly what it was told, at length, after the instruction that forbids it. **On any change to how the work is done, message every running agent in the same turn**, not only the ones the change obviously touches.

**When a result is proved mid-audit, withdraw the search instruction from every reviewer still hunting a counterexample to it.** *"Search seriously, one counterexample beats confirming everything else"* is right while the statement is a conjecture and near-worthless once it is a theorem, and the reviewer cannot know the difference. **The trigger is the proof, not the next message.** Redirect them to the analytic clauses of their own brief: an adversarial reading of the new proof's *steps* is where an error would be found, and costs nothing.
