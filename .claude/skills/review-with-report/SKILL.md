---
name: review-with-report
description: Adversarially audit the lemmas of the proof programme for analytical correctness and write the verdicts into full-review.md. Reviewers run at most three at a time, work from cold briefs, triple-check every discrepancy before reporting it, and commit the report as they go. Use when the user says "review with report", "audit the lemmas", "adversarial review of the findings", or invokes /review-with-report.
---

# Review with report

An audit of what the programme claims to have proven. It reads the record and attacks it; it does not extend it. One pass over a set of lemmas is one **sweep**, and a sweep ends with every lemma in that set carrying a verdict in [full-review.md](../../../full-review.md).

The goal of the programme is in [README.md](../../../README.md). This skill serves it by making the difference between *proven* and *believed* explicit for every lemma the proof rests on.

## The rule that outranks every other rule here

**A lemma is correct only if its proof is correct. Numerical agreement is not evidence.**

Every claim of the form "verified at $n=12,14,16$", "zero violations at 20 points", "residual $10^{-15}$" is, to this skill, an **open hypothesis**, the exact debt shape the audit exists to find. A reviewer that closes a lemma on numerical grounds has failed its brief.

Exact symbolic computation is admissible: a `sympy` identity over $\mathbb{Q}$ or $\mathbb{Q}(n)$, an integer-arithmetic rank, a closed-form expansion. Floating-point sampling is not, at any precision, for any number of points.

## Where everything lives

| File | Role |
|---|---|
| [full-review.md](../../../full-review.md) | **This skill's only output.** Append-only. One section per lemma. |
| [findings/INDEX.md](../../../findings/INDEX.md) | What the programme claims is true. The audit's input. |
| [ATTEMPTS.md](../../../ATTEMPTS.md) | Where a lemma's proof was actually carried out. |
| [reviews/INDEX.md](../../../reviews/INDEX.md) | Prior verdicts, by reviewer. **Withheld from reviewer briefs.** |
| [results.md](../../../results.md) | The outgoing write-up. Its lemma statements are the canonical ones. |
| [findings/LEDGER.md](../../../findings/LEDGER.md) | The Gate 2 debt ledger names what was never audited, and every result's verdict. Start there. |
| `agent_logs/` | Heartbeat logs, gitignored. |

## Phase 1, inventory, inline, no agents

You cannot audit what is not listed. Before any reviewer is spawned, build the inventory in the session:

1. **Enumerate every lemma** the proof depends on, from [results.md](../../../results.md) and [findings/INDEX.md](../../../findings/INDEX.md). Give each a stable id (`L01`, `L02`, …) and record: exact statement, every hypothesis, where the proof lives, and what cites it.
2. **Build the dependency graph.** A lemma that others rest on is load-bearing; a false leaf invalidates everything above it.
3. **Order the sweep in reverse dependency order**, deepest dependency first. Auditing a corollary before its lemma wastes the cycle.
4. **Rank within a tier by exposure**: anything on the Gate 2 debt ledger, anything single-authored, and anything whose support is numerical goes first.

Write the inventory into [full-review.md](../../../full-review.md) as the sweep's header before dispatching. It is the sweep's contract, and it is what makes an interrupted sweep resumable.

## Phase 2, dispatch, at most three at a time

**Three reviewers run in parallel, one lemma each.** Three is the cap, not the target: a tier with two load-bearing lemmas dispatches two. When a reviewer returns, the next lemma in the order takes its slot.

**Duplicate the brief on load-bearing lemmas.** Two reviewers on the same lemma, on identical briefs, working independently: where they agree, confidence rises; where they disagree, exactly one is wrong and finding out which is the next task. This is what caught the moment/trace and graded-classification results. Spend the duplication on lemmas that carry weight, not on leaves.

### The brief a reviewer receives

**Give it:** the lemma statement verbatim, its hypotheses, the full proof as written, and the definitions the proof needs.

**Withhold:** the prior verdict, the reviewer number that blessed it, the surrounding narrative, and any indication that the result is believed. Anchoring is precisely what a re-read misses. A reviewer that knows the answer is expected to be "correct" will find it correct.

**Instruct it to attack in this order:**

1. **Hypotheses before steps.** The recurring failure in this programme is an unstated assumption, not a bad manipulation, an imported theorem carries a hypothesis the object does not satisfy, and the step reads as valid because the hypothesis was never written down. For every theorem the proof imports, state the source's hypotheses and check each one against the object it is applied to.
2. **Quantifier order and scope.** Where a bound is taken, over what, and whether a $\sup$ was distributed across terms that share a variable.
3. **The edge of the range.** Whether the argument survives at the boundary of every stated interval, and at the crossover $n = 6 + 2\sqrt{7}$.
4. **The gap between what is proven and what is used.** A lemma proven on a subfamily and cited in general is a finding.

### Consulting the source

Checking an imported theorem's hypotheses means reading the theorem, not the citation of it. A reviewer that needs a paper fetches it and **stores it under [references/](../../../references/)** in the programme's convention: one subfolder per source carrying the PDF, a text extraction, and a `notes.md` recording what was checked and where in the source it was found.

This is the one place a reviewer creates files outside the report, and it is expected rather than tolerated, a hypothesis check that cannot point at a line in the source is an opinion. **Search-tool prose is a lead to verify, never a citation**: a summarization layer once fabricated a reference in this programme, so quote the source text or grep the extraction.

A reviewer that finds a source contradicting the programme's use of it has found a discrepancy, and it goes through the same three-step protocol as any other.

## The discrepancy protocol, the core of this skill

**A reviewer that finds a discrepancy has found a candidate, not a result.** Most apparent errors are the reviewer's own. Reporting one costs the programme a cycle to disprove, so the burden sits with the reviewer, before the report, not with the reader after it.

Before a discrepancy is written to the report, the reviewer must clear **all three**:

1. **Re-derive independently.** Set the original proof aside and derive the step from the definitions in its own notation. If the discrepancy came from a transcription slip, this is where it dies.
2. **Exhibit the failure concretely.** Name the object, the parameter value, or the hypothesis at which the step breaks, in closed form. "The bound seems loose" is not a finding; "at $k=3$ the $\sup$ over $W_1$ is taken twice in terms that share $W_1$, losing a factor $1.40$" is.
3. **Argue the opposite.** Attempt to prove the step *correct*. A reviewer that cannot construct the strongest defence of a step has not understood it well enough to attack it.

Only a discrepancy surviving all three is reported as `BROKEN` or `GAP`. One that fails any of them is recorded as `CHECKED, candidate discrepancy withdrawn`, with the reason. **That line has value**: it stops the next reviewer spending a cycle on the same dead end.

## Verdict vocabulary

Every lemma section closes on exactly one:

| Verdict | Meaning |
|---|---|
| `PROVEN` | The proof is correct and complete as written. |
| `PROVEN, hypotheses corrected` | Correct once a hypothesis missing from the statement is added. State it. |
| `GAP` | A step is unjustified. The conclusion may hold; the proof does not establish it. |
| `BROKEN` | The statement is false, or the proof has an error that cannot be repaired at that step. |
| `HYPOTHESIS-DEBT` | Support is numerical only. Names precisely what would have to be proven. |
| `UNDECIDED` | The reviewer could not settle it. States what it would take. |

`UNDECIDED` is an honest verdict and is preferred over a `PROVEN` the reviewer cannot defend.

## Writing to the report

[full-review.md](../../../full-review.md) is **append-only** and is written by several agents at once. Two rules keep it intact:

- **Append in a single shell redirect**, one `cat >> full-review.md <<'EOF' … EOF` per section. Never Edit or Write the whole file: a whole-file write clobbers a section another reviewer appended in the interim, silently.
- **Never edit another reviewer's section.** A disagreement is a new section that cites the one it disputes.

Each section carries: lemma id and statement, the reviewer's own restatement of what it checked, the three-step record for any candidate discrepancy, the verdict, and (where the verdict is not `PROVEN`) exactly what would close it.

### Committing

**A reviewer commits [full-review.md](../../../full-review.md) as soon as it has appended a section**, so an interrupted sweep loses nothing. This is a deliberate, narrow exception to the standing rule that commits are approved one at a time.

- **Scope is the report plus any source the reviewer stored.** `git add full-review.md` and the `references/<slug>/` folder this reviewer created, nothing else. [findings/INDEX.md](../../../findings/INDEX.md), [plan.md](../../../plan.md), [ATTEMPTS.md](../../../ATTEMPTS.md), [reviews/INDEX.md](../../../reviews/INDEX.md), [results.md](../../../results.md) and [scripts/](../../../scripts/) belong to the research loop; a reviewer that stages one has exceeded its brief.
- **Commit message**: `review(<lemma-id>): <verdict>`, or `refs(<slug>): stored for <lemma-id>` when the commit carries only a source.
- **On a locked index**, wait briefly and retry rather than forcing, three reviewers share one working tree, so `.git/index.lock` contention is expected, not an error.
- Reviewers never push, never amend, never rebase.

## Logging

Each reviewer logs to `agent_logs/review-<lemma-id>.log`: first line carrying PID and phase plan, a line at every phase transition, a heartbeat at least every ~3 minutes carrying live state rather than a bare "still working", and a closing `DONE <verdict>` or `FAILED <reason>`. **State the log path at launch** so the sweep can be tailed. Wait-loops poll PID liveness; a stale PID with a freshly-modified output file means the work is alive.

Heartbeats carry what the reviewer is doing ("re-deriving step 4 from the definitions", "constructing the defence of the $k=3$ case") so a stalled reviewer is visible as a repeated line rather than inferred from silence.

## Phase 3, adjudication, inline

When the sweep's tier is done, read the sections back in the session and:

- **Reconcile duplicated briefs.** Agreement is a result. Disagreement is a task, and it outranks continuing the sweep.
- **Propagate upward.** A `BROKEN` or `GAP` invalidates every lemma above it in the dependency graph; mark those `UNDECIDED, depends on <id>` rather than leaving them at their old verdict.
- **Hand the consequences to the research loop.** The report is the whole deliverable; acting on a verdict is the loop's step 6, not this skill's. A `BROKEN` or `GAP` becomes a task there, and the Gate 2 debt ledger clears there.

**This skill writes [full-review.md](../../../full-review.md) and nothing else**, apart from a source a reviewer stores under [references/](../../../references/). [findings/INDEX.md](../../../findings/INDEX.md), [plan.md](../../../plan.md), [ATTEMPTS.md](../../../ATTEMPTS.md), [reviews/INDEX.md](../../../reviews/INDEX.md) and [results.md](../../../results.md) are read-only to a sweep. That is what lets a sweep run alongside a live research-loop cycle, in a separate worktree, without either one losing an update.

The sweep's closing line in [full-review.md](../../../full-review.md) is the count by verdict. That number, not a narrative, is the deliverable.

## Running alongside the research loop

A sweep and a live cycle share a repository, so they share `.git/index` and every tracked file. Different sessions do not isolate that. Give the sweep its own worktree:

```
git worktree add ../hamiltons-cubic-audit -b audit-<yyyy-mm-dd>
```

Run the sweep from that directory. It gets its own checkout, its own index, and its own branch, git refuses to check out `main` twice, so the sweep cannot commit onto the loop's branch by accident.

- **Local state is already per-worktree.** `agent_logs/` and `.claude/stop-declared` are gitignored, so heartbeats and stop conditions never cross between the two.
- **The research-loop stop hook is tracked**, so it also fires in the sweep's worktree and asks for cycle conditions that do not apply there. Cosmetic; the sweep's own stop conditions are below.
- **Merging back is a fast-forward in practice.** [full-review.md](../../../full-review.md) is a new file on the audit branch and nothing else on that branch is shared. The one collision to watch is two `references/<slug>/` folders created under the same slug in both trees.
- **Remove the worktree when the sweep is merged**, with `git worktree remove ../hamiltons-cubic-audit`, so a stale checkout is not mistaken for live work.

Running a sweep in the main worktree while a cycle is active risks the loop's `/commit` staging a half-written report. Do it only when the loop is idle.

## Stop conditions

Stop and hand back when: the user interrupts; a `BROKEN` verdict lands on a load-bearing lemma, since the sweep's order is now wrong and re-ranking is the user's call; two duplicated briefs disagree; or the tier is complete and the next tier needs the user's go-ahead.

Reporting a result is not a stop condition. Neither is asking whether to continue.

## Editing this file

**An edit here follows [editing-skills](../editing-skills/SKILL.md)**, when it is allowed, where the lesson goes, and the verbatim report it owes.
