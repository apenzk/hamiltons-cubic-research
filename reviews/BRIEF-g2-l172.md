# Gate 2 brief, whether Jäger's Assumption 1 binds at $n=12,14$

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below and from the source itself. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -- reviews/REVIEW_r<N>.md reviews/INDEX.md -m "..."`, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## The source

[references/jaeger-2016-diagonal-case/](../references/jaeger-2016-diagonal-case/) holds the PDF, a `pdftotext -layout` extraction, and notes. **Read the source, not the notes.** Its Theorem A is the record's granted diagonal case, and it is stated for $n\ge16$ while the record consumes it at $n=12,14$.

## The statement under review

> In Jäger's Chapter 3, the hypothesis $m\ge8$ of Assumption 1 is invoked at exactly one step, and that step needs only $m\ge5$. **So Assumption 1 does not bind at $n=12$ or $n=14$**, and the unnumbered "Result 5b" that was supposed to remove it is not required for this purpose.

## The argument as written

> **The census.** Across the whole of Chapter 3 the string $m\ge8$ occurs three times: in the statement of Theorem 3.0.2, in the statement of Assumption 1, and once inside a proof, *"choose $l\in A_k$ with $l\notin\{a,b,c,d\}$, which is possible because $m\ge8$ and $\#A=m(m-1)$"*. Every other constraint in $m$ is $m\ge2$ or $m\ge3$. The separate $n\ge15$ pair inside Lemma 3.5.6 is a different hypothesis and is untouched.
>
> **Why $m\ge5$ suffices.** $\mathfrak k\cong\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ acts on $n=2m$ indices split into two blocks of $m$, and $A$ is the set of within-block pairs, so $\#A=2\binom m2=m(m-1)$, which is the count the sentence cites, and it is not the count the choice needs. The choice needs an index of $A_k$, the block containing $k$, avoiding the at most four indices $a,b,c,d$; and $\lvert A_k\rvert=m$. So the step goes through as soon as $m-4\ge1$.

## The machine-checked statement, which exists and which you should check against the record

`lean/HamiltonsCubic/Results/L172.lean`, state `partial`, built in the kernel. It carries:

- `free_index_exists (m : ℕ) (hm : 5 ≤ m) : 1 ≤ m - 4`
- `threshold_dimensions : (5 : ℕ) ≤ 6 ∧ (5 : ℕ) ≤ 7`
- `pair_count (m : ℚ) : 2 * (m * (m - 1) / 2) = m * (m - 1)`
- `cited_count_is_larger (m : ℕ) (hm : 3 ≤ m) : m ≤ m * (m - 1)`

**Read it and say whether its statements are the ones the lemma needs.** A binder that is missing, or a statement weaker than the prose it stands for, is a finding, and its docstring is part of what you audit.

## What to attack

1. **The census is the load-bearing claim and it is a negative one.** *"Invoked at exactly one step"*, verify it yourself against the source, and **do not rely on a single string search**: the extraction may render the inequality differently in places, and the hypothesis can be consumed implicitly through a lemma that assumes Assumption 1 wholesale. **Enumerate what Chapter 3's results assume, not what its prose spells.**
2. **Which set does the step draw from?** Establish $\lvert A_k\rvert$ from the source rather than from the brief. Is $A_k$ a block of size $m$, and is $k\in A_k$? Check the definition and the lemma the sentence cites (3.6.7).
3. **How many indices must $l$ avoid, and must $l$ share a block with $a$?** The bracket $[e_l\wedge e_a,x]$ has to lie in $\mathfrak k$ and has to kill the second term. Work out the real constraint on $l$; **if it must avoid more than four, or must lie in a smaller set, the bound moves.**
4. **Whether $a,b,c,d$ can lie in different blocks**, and whether that makes the step easier or harder. The brief's argument takes the worst case as all four in one block, check that this is the worst case.
5. **The "without loss of generality" in the source** (*"$a\ne c$ and $a\ne d$ can be assumed"*), is it actually without loss of generality, and does it change the count?
6. **The induction that follows.** The sentence sits inside an induction on the number of basis vectors in a linear combination. **Does the induction step need a fresh index each time, and does that accumulate a larger bound than the single step does?** This is the most likely place for the argument to fail.
7. **Whether Assumption 1's $m\ge8$ is used anywhere outside Chapter 3**, and whether Theorem 3.0.2's own $m\ge8$ is inherited from Assumption 1 or independent.
8. **The scope claim.** *"The separate $n\ge15$ constraint in Lemma 3.5.6 is untouched"*, confirm that it is separate, and that nothing in this argument bears on it.
9. **Hypothesis inventory** for the lemma as stated, and which of its hypotheses go unused.
10. **Name what would break it**, what, in the source, would show $m\ge8$ genuinely needed.
