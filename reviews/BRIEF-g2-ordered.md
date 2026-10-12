# Gate 2 brief, whether the ordered-pair convention closes the hazard

**You are one of two reviewers working from identical briefs, cold and independently.**

**This is a narrow brief with one question**, and it is a question about what a file says. *The cycle that wrote the claim has misread the record four times today, a census of strings taken for a census of hypotheses, a consequence sentence read without its neighbour's scope clause, a lemma's threshold reversed, and a tabled convention said not to exist. Each was caught by a reviewer.* Read the files, not this brief's account of them.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Reading the machine-checked layer.** `lake`, `lean` and `elan` are **not on `PATH`**, they live in `~/.elan/bin`. To build, `cd lean && PATH="$HOME/.elan/bin:$PATH" lake build`. *A bare `which lake` returning nothing is not evidence the toolchain is absent*, and a statement-level audit of a Lean file is weaker than one that has run it.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -m "..." -- reviews/REVIEW_r<N>.md reviews/INDEX.md`, **options come before `--`, and the reverse order is invalid git**, leaving the index empty so the structure gate fails closed, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## The hazard

A Gate 2 reviewer ranked this *"the single most dangerous inherited hypothesis"* in [Lemma L174](../findings/second-order.md):

> $t_F$ is a sum over pairs. **Read as a sum over unordered pairs it is half the ordered value**, so $t_F\le1$ rather than $\le2$, and then $\kappa^2=2$ holds nowhere, [L174](../findings/second-order.md)'s budget form is vacuous, and **[I36](../plan.md) is refuted by a convention alone**.

## The claim under review

> The record settles it. [conventions.md](../findings/conventions.md) tables the ordered reading, $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, with $K_{ab}=W_{abab}$ the symmetric hollow sectional matrix, and shows the alternative is inconsistent with the bound it would have to live under: *"writing $K$ as $(W_{abab})_{a<b}$ reads as an index set over unordered pairs, whose square sum is $\tfrac t2\le1$, so the bound $t\le2$ and that reading are inconsistent."*
>
> **So the hazard is real, named, and closed; what L174 owed was the citation rather than the argument.**

## What to attack

1. **Read [conventions.md](../findings/conventions.md) yourself** and say whether it tables the ordered reading, in those words or others. **Quote what you find.** If the quoted sentence is not there, or is there with different force, that is the finding.
2. **Is the quoted inconsistency argument sound?** It says the unordered square sum is $\tfrac t2$, so under that reading the recorded bound $t\le2$ would be a bound of $1$, and calls the two "inconsistent". **Is that inconsistency, or merely a different normalisation that would rescale everything consistently?** A convention cannot be refuted by being different; it can only be refuted by contradicting something else the record holds fixed.
3. **Which reading does [L94](../findings/bispectral.md) itself use?** L94 is the lemma L174 imports, stating $\kappa^2\le2\lVert M\rVert_F^2$ with equality exactly at coordinate-diagonal. **Check that L94's $t$ and conventions.md's $t$ are the same object**, if L94 was derived under the unordered reading, the citation does not transfer.
4. **The equality case.** Under the ordered reading, $t=2$ exactly at coordinate-diagonal. **Verify that at a concrete coordinate-diagonal unit $W$** (the record's own balanced sphere product will do) and say what the unordered reading would give there.
5. **Does anything else on the record consume $t$ under the other reading?** A convention settled in one file and consumed differently in another is this record's recurring defect; say what you checked.
6. **The word "closed".** The claim says the hazard is closed rather than open. **Is that the right status**, or is it closed only for L174 while remaining open for a consumer that does not cite the convention?
7. **Name what would reopen it.**
