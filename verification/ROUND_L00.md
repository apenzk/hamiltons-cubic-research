# Round L00, problem p and conjecture a are the same statement

**Result:** 0 in [findings/INDEX.md](../findings/INDEX.md), *problem p and conjecture a are the same statement*, in [problem.md](../findings/problem.md).
**Date:** 2026-09-01. **Reviewers:** v1, v2, v3, v4, v5.
**Round file for:** [verification-loop](../.claude/skills/verification-loop/SKILL.md).

## Why this id, and not L01

[plan-verification.md](../plan-verification.md) ranks **L01** first on [findings/INDEX.md](../findings/INDEX.md)'s line *"Lemma L1, the diagonal case at $n=12,14$, never audited and load-bearing."* [problem.md:346](../findings/problem.md) says the opposite in the file that owns it: *"**NEVER AUDITED, and OUT OF SCOPE.** … **nothing in this project depends on Lemma L1**: what it depends on is the grant. … It is not a dependency, and it is not worth reviewer time."* The index's own status table agrees with [problem.md](../findings/problem.md), the diagonal case is carried by result 57 at every $n\ge4$, so the grant is not load-bearing either.

**The two lines contradict each other and one of them is stale.** L01 is demoted to tier 3 and the contradiction is recorded as a finding of this round rather than of a reviewer's: *the index calls L01 load-bearing; the file that owns it calls it out of scope.* The round proceeds to the next tier-0 id, **L00**.

## Reviewer numbering

r331–r335 are in flight in a concurrent research-loop session (`scripts/reviewers/r335/` exists, no `REVIEW_r335.md` yet), so this round allocates **v1–v5** rather than the next integer after the highest report on disk. Numbers are permanent addresses and are never reused.

## The brief, and where it was quoted from

Identical for all five reviewers, quoted verbatim, no prior verdicts and no narrative:

| part | source |
|---|---|
| The statement under review | [problem.md:405](../findings/problem.md) |
| The definitions of $\mathcal W_n$, $Q$, $P$ and the Goal | [README.md](../README.md), the *Problem* block |
| Material A, the critical-point argument | [problem.md:112–120](../findings/problem.md), *Critical-point structure* |
| Material B, the section the result's own block names as its argument | [problem.md:234–250](../findings/problem.md), *Step 2 is now PROVED here, both halves, in a few lines each* |
| Provenance of the name *Conjecture A* | [problem.md:9–11](../findings/problem.md), *Identity of the conjecture* |

**No canonical form exists.** [results.md](../results.md) does not carry result 0 (it is one of the 33 results named in the canon debt) so the round has only the findings form to compare against, and the reviewers are told so.

Reviewers were instructed to read no file of the record other than what the brief carries, and to fetch any external source into [references/](../references/).

## Phase 1, the five verdicts

| reviewer | verdict | standing | withdrawn |
|---|---|---|---|
| [v1](VERIFY_v1.md) | `GAP` | 5 | 2 |
| [v2](VERIFY_v2.md) | `GAP` | 7 | 2 |
| [v3](VERIFY_v3.md) | `PROVEN, hypotheses corrected` | 4 | 6 |
| [v4](VERIFY_v4.md) | `PROVEN, hypotheses corrected` | 5 | 1 |
| [v5](VERIFY_v5.md) | `GAP` | 5 | 4 |

**The verdicts split 3–2 and the mathematics does not.** All five prove the statement true for $n\ge12$ and all five say the material named as its argument does not establish it; they differ only on whether a result whose proof is absent is a `GAP` or a correction. That is a disagreement about vocabulary, and the clustering below is where the round's content actually sits.

## Phase 2, clustering

Clustered by the step attacked and the mechanism, never by the wording.

| # | step attacked | mechanism | support | class |
|---|---|---|---|---|
| **F1** | The result's own block, naming its argument | The named section proves an unrelated proposition, the $\mathcal D_n$-projection lemma, which mentions no critical point, no $Q$, no attainment. All five re-derived its three parts and found them correct **about something else**. | **5** | MAJORITY |
| **F2** | The second equivalence, $\Rightarrow$ | The published Conjecture A is a conjunction: an $n\ge12$ clause **and** an $8\le n\le11$ clause with $SO(n)\cdot W_{\mathbb{CP}^2}$ removed. Problem P is an $n\ge12$ statement and cannot imply the low-dimensional clause, which carries live content, $\theta_{10}^2=36/25<3/2=P(W_{\mathbb{CP}^2})^2$. | **4** | MAJORITY |
| **F3** | "is maximized on", in both equivalences | Conjecture A is a non-strict $\le$ with no equality clause, so it cannot be equivalent to a uniqueness statement. The reading must be attainment of the maximum **value**. | **5** | MAJORITY |
| **F4** | The whole argument | Attainment of the supremum, and criticality of the maximiser, are never argued in either material, and they are the entire content of the statement. Material A supplies only the first-order condition. | **5** | MAJORITY |
| **F5** | The $\Rightarrow$ direction, "products of spheres" | The direction additionally needs *balanced beats every unbalanced split*, which no supplied material proves. Three reviewers supplied it from the same external source; one reached it independently and withdrew its own candidate on that basis. | **4** | MAJORITY |
| **F6** | Material A's symmetry justification | $\mathop{\mathrm{tr}}(XYZ)=\mathop{\mathrm{tr}}(ZYX)$ covers the $W^2$ half only; the $W^\#$ half rests on total antisymmetry of the structure constants. The conclusion is safe and the stated reason is short. | **3** | MAJORITY |
| **F7** | Material B, part (c) | The two-value ratio $Z_{\text{block}}/Z_{\text{cross}}$ matches $S^k\times S^l$ for **every** split $k+l=n$, so it singles out no split; balancedness is an input to (c) rather than an output. | **1** | MINORITY, transferred, see below |
| **F8** | Material B, part (c) | The computation covers even $n$ only. | **1** | MINORITY, transferred, see below |

**Six majority findings and no wave.** F7 and F8 attack Material B, which F1 has established by unanimity is **not this result's argument**. A wave on them would spend three reviewers each on a section belonging to another result, and would file the answer under a result the section does not support. **Both transfer to the round on L57**, the diagonal theorem, which is where Material B lives, and they are carried there as pre-registered questions rather than as verdicts.

## Phase 3, the wave

**Not run.** No minority finding survives as this result's: see the transfer above.

## Phase 4, spread and impact

**Dependents, read rather than counted.** `grep -rn "Lemma L0"` over [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md), [routes.md](../routes.md) and [report/](../report/) returns four hits: the result's own block, and three in [report/](../report/).

| citation | kind | note |
|---|---|---|
| [problem.md:401](../findings/problem.md) | the block itself | rewritten by this round |
| [report/sections/diagram.tex:36](../report/sections/diagram.tex) | load-bearing | **states the argument correctly**, *"the unit sphere is compact so $\max P$ is attained, at a critical point"* |
| [report/sections/diagram-closed.tex:42](../report/sections/diagram-closed.tex) | load-bearing | the same line |
| [report/sections/diagram-closed.tex:183](../report/sections/diagram-closed.tex) | mention | *"it removes a criticality hypothesis Lemma L0 removes anyway"* |

**The missing argument was never missing from the project, it was missing from [findings/](../findings/).** [report/](../report/) carries the compactness-and-attainment reasoning in two of its three citations, and the reviewers could not see it because the brief withholds the record, correctly. So the defect is that [findings/](../findings/), which owns the mathematics, held a pointer to the wrong section while the write-up downstream of it carried the proof.

**Impact class per finding**

| finding | class | what it cost |
|---|---|---|
| F1 · the block names the wrong section | `CONTAINED` | The conclusion is reached in three lines, and [report/](../report/) already states them. The pointer is replaced by the argument. |
| F2 · $\Rightarrow$ against the published Conjecture A | `NARROWS` | The statement now names the $n\ge12$ clause. No dependent used the wider reading. |
| F3 · "maximized" as uniqueness | `NARROWS` | The value reading is now stated. Rigidity is separated out. |
| F4 · attainment never argued | `CONTAINED` | Supplied. |
| F5 · balanced beats every split | `NARROWS` | "Products of spheres" now names the balanced split, with the monotonicity in $kl$. |
| F6 · the symmetry justification is short | `CONTAINED` | Recorded; the conclusion was never at risk. |

**No `PROPAGATES` and no `FATAL`.** Nothing in [findings/](../findings/) or [results.md](../results.md) cites this result in an argument, and the three [report/](../report/) citations state it in the corrected form already.

**Route register:** untouched. No route closed on this result and no fence post rests on it.

## Phase 5, the fix

**Repaired and narrowed**, in [problem.md](../findings/problem.md): the wrong pointer is replaced by the statement with its three scope conditions and the compactness proof, and the block records the round that rewrote it.

**No hypothesis was added to save the result**, the three conditions narrow what it claims rather than restricting what it applies to, so no dependent can be broken silently by them. Each was checked against the three [report/](../report/) citations above, and all three already read the result in the narrowed sense.

**[results.md](../results.md) is unchanged**: result 0 is one of the 33 the canon debt names as missing, so there is no canonical form to reconcile. *That is itself a debt this round leaves standing rather than one it created.*

## Phase 6, verdict

**`GAP`.** Three reviewers of five returned it and two returned `PROVEN, hypotheses corrected`; the split is over vocabulary, since all five hold that the statement is true and that the record contained no argument for it. `GAP` is the verdict whose definition matches (*a step is unjustified; the conclusion may hold*) and it is preferred over the reading that records a result as proved when its proof was absent.

**The repair is a new result and is not blessed by this round.** L00 returns to tier 0 of [plan-verification.md](../plan-verification.md) unchecked, and the box is ticked when a round audits the argument written today.

**Transferred to the L57 round:** F7, Material B (c)'s two-value ratio matches every split $k+l=n$, so it singles out no split, balancedness being an input rather than an output, and F8, the computation covers even $n$ only. Both are carried there as pre-registered questions.
