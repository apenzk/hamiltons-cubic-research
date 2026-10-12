# Position file for the 2026-09-10b sweep

**Written on Opus before the switch, and it is the only part of the record the sweep reads whole.** *The sweep that follows appends to [2026-09-10b-LIT-step8-sweep.md](2026-09-10b-LIT-step8-sweep.md) after every batch.*

## Why this sweep runs, which is not the usual reason

**The task list is NOT empty.** *Step 9 normally fires on an empty list, and this one fires on the user's decision after a status showed the shape below.* **Six of fifteen graded section 1 items are attackable, and all eight zeros come from `attackable` alone**, none from importance, margin or analyticity. *So the bottom of the list is one missing route wearing eight numbers, and the items it zeroes are the ones that would close the problem outright.*

## The goal, restated

**Prove $P(W)=\langle W,Q(W)\rangle$ on the unit sphere of $\mathcal W_n$ is maximised by the Weyl tensor of $S^{n/2}\times S^{n/2}$ for even $n\ge12$, granting the diagonal case.** *Equivalently $\theta\le\theta_0(n)$, which is $1.236033$ at $n=12$.* **The best unconditional bound on the record is $\theta\le(n-1)/\sqrt{n+1}$, reading $3.0509$ at $n=12$**, a factor of $2.47$ from the target, and nothing derived today moved it.

## The graded table as it stands

| item | what it would settle | closes | attack | margin | analytic | value |
|---|---|---|---|---|---|---|
| **I36** | every local maximiser above $\sqrt{3/2}$ is coordinate-diagonal, then [L57](../findings/problem.md) finishes | 3 | 2 | 1 | 1 | **6** |
| **I68** | a rank bound at every non-diagonal critical point | 3 | 1 | 1 | 1 | **3** |
| I2 | the balanced-orbit scenario of L16(b), with an explicit radius | 1 | 2 | 1 | 1 | **2** |
| I71 | the uncontracted criticality rows | 1 | 2 | 1 | 1 | **2** |
| I6 | the interior scenario as a perturbed criticality equation | 1 | 1 | 1 | 1 | **1** |
| I35 | an explicit isolation radius per rigid orbit | 1 | 1 | 1 | 1 | **1** |
| **I1** | **the goal itself** | 3 | **0** | 1 | 1 | **0** |
| **I4** | **settles the goal outright**, needing the grant $J_5\ge0$ | 3 | **0** | 1 | 1 | **0** |
| **I7** | the destination, value on the compact set | 3 | **0** | 1 | 1 | **0** |
| **I5** | the non-pure set above $\sqrt{3/2}$ separated from the pure locus | 3 | **0** | 1 | 1 | **0** |
| **I37** | the half [I1](../plan.md) does not, the $S>0$ critical points | 2 | **0** | 1 | 1 | **0** |
| **I3** | the competitor scenario, four formulations refuted | 2 | **0** | 2 | 1 | **0** |
| I70, I69 | retired on filing | 3 | **0** | 2 | 1 | **0** |

**The five items scoring $3$ on `closes` and $0$ on `attackable` are the sweep's real target.** *An outside route that turns one of those zeros into a one changes the programme; a refinement of I36 or I71 does not.*

## The open nodes, stripped of this programme's names

1. **A cubic form on the unit sphere of an irreducible $O(n)$-module, maximised at a distinguished point, and the question is whether every critical point above a threshold lies in a fixed finite-dimensional stratum.** *The programme's name for the stratum is the coordinate-diagonal locus.*
2. **A signed sum of rank-two orthogonal projections vanishing, over the planes of an orthonormal basis of decomposable $2$-forms, and whether that forces the planes into one frame.** *Proved at $n=4$ this cycle by [r850](REVIEW_r850.md), open at $n\ge5$, and the next step is a classification of linear subspaces inside the Plücker quadric.*
3. **A stability constant for a penalised functional near a group orbit, where the penalty vanishes on a set strictly larger than the orbit.** *[Conjecture L16](../findings/problem.md), whose grant $J_5\ge0$ is fenced on four sides.*

## The fence posts that bear on these, and the count

**64 numbered traps and posts are tabled in [INDEX-traps.md](../findings/INDEX-traps.md), and a candidate route must clear the ones below.** *Read the table by post rather than the file whole.*

- **[F36](../findings/fence-posts.md)**, padded $W_{\mathbb{CP}^2}$ is a local maximum at $\theta=\sqrt{3/2}$ **exactly** and is not coordinate-diagonal, so the value hypothesis in I36 is strict and unavoidable. *This refuted a claim of the block written this cycle.*
- **[F37](../findings/fence-posts.md)**, higher variations are identities on the orbit, so a route through them is closed.
- **[F6](../findings/fence-posts.md)**, no moment argument reaches the conjecture.
- **[F44](../findings/second-order.md)**, asks for a frame variation or a character mix. *It lives in [second-order.md](../findings/second-order.md), and both the plan and a block this cycle mis-cited it to [fence-posts.md](../findings/fence-posts.md).*
- **[F43](../findings/fence-posts.md)**, a kernel-free witness fences the kernel side of I68.
- **[F63](../findings/fence-posts.md), [F64](../findings/fence-posts.md)**, the contrapositive route into I68 is closed, and neither I68 nor I37 has a literature.
- **[W1](../findings/INDEX-traps.md)**, $\ker W\ne0$ is the record's recurring obstruction, and a check run only on sphere products never reaches it.

## What previous sweeps already covered, which is the half most often skipped

| sweep | what it reached | outcome to respect |
|---|---|---|
| [2026-09-02](2026-09-02-LIT-step8-sweep.md) | ODE fixed points, equivariant bifurcation, sharp cubic constants, the Kronecker-square reading, the Peirce second moment, I9 dual certificates, Michel-type maximisers, Morse–Bott at symmetric orbits, **the Plücker and isotropic-Grassmannian node**, the certificate node, the frame-diagonal characterisation | **The Plücker node was already swept once.** Read that batch before proposing it again |
| [2026-09-03](2026-09-03-LIT-step8-sweep.md) | both statements stripped of names, one multi-bubble stability proof end to end, the method without a scale parameter, Łojasiewicz, statement (A) in its own field | Łojasiewicz is the mechanism whose hypotheses the problem already satisfies, and the tool batch 5 pointed at is already filed and unused |
| [2026-09-03b](2026-09-03b-LIT-step8-sweep.md) | I5 and L16(a) stripped of names, Route 3's partition mechanism, Route 4's $\ell_{a,b}$ transformation law, the outside field | Route 3 has no analogue; Route 4's law is the identity on Weyl tensors |
| [2026-09-10](2026-09-10-LIT-step8-sweep.md) | both nodes under six phrasings across four fields | **Neither node has a literature**, and that is now [F64](../findings/fence-posts.md). One source makes I37's constant a red herring |

**So four sweeps have covered the two headline nodes and the Plücker node.** *Proposing any of them again without reading the batch that covered it is the failure this table exists to prevent.*

## What has never been searched, and it is most of the list

**48 of the 50 live section 1 and section 2 items carry no recorded search outcome.** *Every previous sweep aimed at the headline, which the step's own rule forbids: one search per item, phrased in that item's own objects.* The unsearched set includes every one of the five `closes = 3, attackable = 0` items (**I1, I4, I7, I5** and, at `closes = 2`, **I37**) and the whole of section 2's seventeen build items, **I42 through I53** among them.

## The assignment, narrowed to what serves the goal

**The goal is one sentence, quoted from [README.md](../README.md): prove $P(W)=\langle W,Q(W)\rangle$ at unit norm is maximised on the Weyl tensor of products of spheres when $n\ge12$.** *The diagonal case is known and the non-diagonal case is the whole of the work.* **So the sweep's goal is also one sentence: find a route that bounds $\theta$ at a NON-DIAGONAL critical point in dimension at least twelve.**

**THE ASSIGNMENT IS THE FIVE ZEROED ITEMS, AND IT STOPS THERE.** *[I1](../plan.md), [I4](../plan.md), [I7](../plan.md), [I5](../plan.md) and [I37](../plan.md) are the non-diagonal statements themselves, and a route into any one of them is a route to the goal.* **A search per item, in that item's own objects, with the outcome recorded beside it including "searched, nothing found".**

> **AND THE OTHER FORTY-THREE ITEMS ARE NOT SEARCHED THIS PASS, WHICH IS A NARROWING AND IS DELIBERATE.** *An assignment of "one search per unsearched item" is a process target rather than a mathematical one: it can be discharged in full by a table of forty-eight rows reading "nothing found", which satisfies the instruction and delivers nothing.* **Section 2's seventeen build items serve the goal only where a named section 1 theorem needs the object**, and none of the five needs one that the record lacks. *[I36](../plan.md)'s Plücker continuation is excluded twice over: its theorem is at $n=4$ where the goal needs $n\ge12$, and the [2026-09-02 sweep](2026-09-02-LIT-step8-sweep.md) already covered that node.*

> **IF NONE OF THE FIVE YIELDS A ROUTE, THAT IS THE FINDING AND IT IS WORTH MORE THAN A COMPLETE TABLE.** *Five items at `closes` $2$ or $3$ and `attackable` $0$, each searched in its own objects and each coming back empty, is a fence post about the whole programme rather than a gap in a spreadsheet.* **Say so plainly and propose the routes anyway**, since a route invented against five documented dead ends is what phase 3 is for.

## The gap the goal actually has, stated so the sweep aims at it

**Everything the record closed this week is at $n=4$, at $\Lambda^2$-rank at most three, or on a single stratum.** *The goal needs $n\ge12$, non-diagonal, every rank, and no result on the record spans that.* **The best unconditional bound is $\theta\le(n-1)/\sqrt{n+1}$, which is $3.0509$ at $n=12$ against $1.236033$.** *A factor of $2.47$ is not a margin to be tightened. It is a missing mechanism, and a route that only sharpens a constant does not reach the goal.*

## Two things the sweep must not do

**It must not re-derive the record.** *Five claims this session were recorded facts re-derived as new, four of them in files already grepped, so a derivation batch is screened against [findings/](../findings/) by the formula's own tokens before it is written up, and a confirmation is reported as a confirmation.*

**And it inherits the analysis-only footing.** *Searches of the literature are what this step is for. Numerical searches, sweeps, optimisations, censuses and falsifier hunts are not, and screening a claim about to be recorded is the whole of the allowance.*
