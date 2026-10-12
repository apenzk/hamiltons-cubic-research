## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Reading the machine-checked layer.** `lake`, `lean` and `elan` are **not on `PATH`**, they live in `~/.elan/bin`. To build, `cd lean && PATH="$HOME/.elan/bin:$PATH" lake build`. *A bare `which lake` returning nothing is not evidence the toolchain is absent*, and a statement-level audit of a Lean file is weaker than one that has run it. **AND RUN EVERY CHECK THROUGH `lake env lean`, NEVER THROUGH A BARE `lean`.** *Putting `~/.elan/bin` on `PATH` makes `lean` resolve to elan's DEFAULT toolchain, which is not the project's: at the time of writing `lean --version` reports one release and `lake env lean --version` another, and only the second is the one the committed layer is built against.* **A `#print axioms` run under the wrong toolchain is a fact about a different library**, and nothing in its output says so.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -m "..." -- reviews/REVIEW_r<N>.md reviews/INDEX.md`, **options come before `--`, and the reverse order is invalid git**, leaving the index empty so the structure gate fails closed, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.
