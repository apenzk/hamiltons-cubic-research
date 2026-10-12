# Position before the sweep, 2026-09-13b

**Written on Opus before the switch, so the sweep reads this and no other part of the record whole.** *This is the second sweep of 2026-09-13. The first is [2026-09-13-LIT-step8-sweep.md](2026-09-13-LIT-step8-sweep.md) and its chosen route closed at its root the same day.*

## Why this sweep is being run, which is different from every previous one

**The task list is NOT empty. The rubric was changed instead**, on the user's instruction, after they asked what the loop was actually doing if the problem was untouched. *The `closes` factor now scores against the one remaining open statement alone, and securing a result the record already carries scores $0$ and leaves section 1 for [plan-verification.md](../plan-verification.md).*

**The regrade cut eight items out of section 1, three of them its graded top an hour earlier, and left nineteen.** *What the new table says: top value $4$, and **every item that would settle the open statement outright is zeroed on `attackable`**.* **So the sweep's purpose is not to fill an empty list. It is to find a METHOD for one inequality**, and a candidate that does not bear on that inequality is not a candidate.

## The one remaining open statement

$$\theta\le\sqrt{3/2}\quad\text{at every NON-DIAGONAL critical point of }P\text{ on the unit sphere of }\mathcal W_n.$$

In two halves, both open: **the $S=0$ half** ([I1](../plan.md), [I7](../plan.md)) and **the $S>0$ half** ([I37](../plan.md)). *Everything else in Problem P is proved: the diagonal case outright at every $n\ge4$ including odd $n$, and the symmetric-space case for every $n\ge12$ with equality exactly at $S^{n/2}\times S^{n/2}$.*

**The load-bearing hypothesis is DIAGONALITY, not $S$.** *The $S=0$ class contains the balanced sphere products, which run up to $\sqrt2$, so only diagonality keeps them out of the target. Any argument must carry diagonality to the end.*

**$\theta$ is $P(W)/\lVert W\rVert^3$ with $P(W)=\langle W,Q(W)\rangle$ and $Q(W)=W^2+W^{\#}$, and criticality is $Q(W)=\theta W$.** *The bracket form $[W,Q(W)]=0$ is strictly weaker and every diagonal Weyl tensor satisfies it.*

## The nineteen live items, with grades, and what each would give

| item | value | what it would settle | why it scores what it does |
| --- | --- | --- | --- |
| [I71](../plan.md) | **4** | a constraint on $\theta$ at every critical point of every rank, from the diagonal of $Q(W)=\theta W$ read row by row | the only item above $3$, and the only one with an untried route on a path to the statement |
| [I36](../plan.md) | 3 | every local maximiser above $\sqrt{3/2}$ is coordinate-diagonal, whence [L57](../findings/problem.md) finishes | a route must be invented, and it is gated on [I74](../plan.md) and [I75](../plan.md) |
| [I73](../plan.md) | 3 | a global maximiser's spectrum takes exactly two values, whence [L105](../findings/bounds-relaxations.md) gives the conjecture | **the destination, no route known** |
| [I89](../plan.md) | 2 | a Fox-algebra criterion identifying the balanced product among idempotents | the algebra is not medial, so Krasnov--Tkachev's classification is unavailable |
| [I68](../plan.md) | 2 | a $\Lambda^2$-rank bound at every non-diagonal critical point above $\sqrt{3/2}$ | **[F64](../findings/INDEX-traps.md) says it has no literature**, under six phrasings across four fields |
| [I76](../plan.md) | 2 | that a two-eigenvalue critical point of the decomposable locus is coordinate-diagonal | would put the two-eigenvalue case inside the granted half |
| [I77](../plan.md) | 2 | a bound on $\theta$ over the decomposable locus from $T$'s marginal and relation (B) | the marginal relaxation was closed with a number, so this is its remnant |
| [I6](../plan.md) | 2 | the interior scenario as a perturbed criticality equation | one of [R17](../routes.md)'s three scenarios |
| [I48](../plan.md), [I53](../plan.md), [I2](../plan.md) | 2 | a stratum case, the third orbit identity, the balanced-orbit split | sub-steps with routes on file |
| [I81](../plan.md), [I74](../plan.md), [I75](../plan.md) | 1 | [R11](../routes.md)'s object, and [I36](../plan.md)'s two halves | each needs a route invented |
| [I7](../plan.md), [I1](../plan.md), [I37](../plan.md), [I3](../plan.md), [I4](../plan.md) | **0** | **the statement itself and its two halves, plus [R17](../routes.md)'s two live scenarios** | **all five zeroed on `attackable`: this is the obstruction, wearing five numbers** |

## What previous sweeps already covered, which is the half most often skipped

| sweep | what it proposed | outcome |
| --- | --- | --- |
| [2026-09-13](2026-09-13-LIT-step8-sweep.md) | the maximiser as a moment-map minimum, via GIT | **CLOSED at its root the same day**, [F66](../findings/INDEX-traps.md): $Q(W)=\theta W$ is the criticality of a CUBIC, not the zero of a quadratic moment map, and no reductive group gives $\mathcal W_n$ a non-trivial minimal-vector structure |
| [2026-09-12](2026-09-12-LIT-step8-sweep.md) | the Killing-constant bound at every critical point; the pure-curvature-operator literature; tight-fusion-frame packing | **all three closed within a day**, [F65](../findings/INDEX-traps.md) for the first (its INPUT is exhausted, not its estimate) and [F21](../findings/INDEX-traps.md)'s successor for the third (no multiplicity cap is obtainable) |
| [2026-09-10b](2026-09-10b-LIT-step8-sweep.md) | five items searched in their own objects, two catalogues opened, Petersen--Stanfield read at the theorems | the record's last open census class closed, as a transcription confirming a recorded bound |
| [2026-09-10](2026-09-10-LIT-step8-sweep.md) | both nodes stripped of names, five parallel searches, three untouched fields | produced [F64](../findings/INDEX-traps.md), that [I68](../plan.md) and [I37](../plan.md) have NO literature under six phrasings across four fields |

**So four sweeps in four days have produced four fence posts and no live method.** *That is the fact the next sweep has to beat, and it is why a candidate must be screened against these four files before it is proposed.*

## The fence posts that bear on this statement, and what each kills

| post | what a candidate must clear |
| --- | --- |
| [F66](../findings/INDEX-traps.md) | no moment-map or minimal-vector reformulation: $P$ is a cubic, criticality is not a moment-map zero |
| [F65](../findings/INDEX-traps.md) | the trace-form bound's input is exhausted, so no refinement of Fox's two trace identities reaches $\sqrt{3/2}$ |
| [F64](../findings/INDEX-traps.md) | the two hardest items have no literature under their own names or six paraphrases, so a search by name will find nothing |
| [F63](../findings/INDEX-traps.md) | high $\Lambda^2$-rank does NOT suppress $\theta$, so the natural contrapositive of a rank bound is false |
| [F62](../findings/INDEX-traps.md) | moduli do not preclude bounds, so "too many moduli" is not an obstruction argument |
| [F61](../findings/INDEX-traps.md) | any four-set criterion dropping $S_1$ is false, witnessed by $S^5\times S^q$ |
| [F59](../findings/INDEX-traps.md) | no bound on $\delta^2$ alone constrains its second-order coefficient at the competitor |
| [F57](../findings/INDEX-traps.md) | a partition argument cannot replace the two-regime comparison |
| [F55](../findings/INDEX-traps.md), [F56](../findings/INDEX-traps.md), [F58](../findings/INDEX-traps.md) | the $\#$-trace, the polarised scal identity and the $\ell_{a,b}$ law are all inert on Weyl tensors |

*Sixty-six posts in total, in [INDEX-traps.md](../findings/INDEX-traps.md).*

## What the sweep must do differently, stated as instructions to itself

1. **Search by the OBJECT, never by the programme's vocabulary**, and never by an item's name: [F64](../findings/INDEX-traps.md) is the record that names find nothing here. *Query by the defining relation, by the pair "what is bounded" and "what it is bounded from", and by the numeric value.*
2. **Strip the statement of this programme's names and ask which field it belongs to.** *A cubic form on the space of algebraic curvature tensors, maximised on a sphere, with a criticality equation $Q(W)=\theta W$ and a hypothesis of non-diagonality in every frame.* **Read that field, including machinery the programme has never used.**
3. **Screen every candidate against SEVEN places, and read the seventh first**, which is [INDEX-literature.md](../findings/INDEX-literature.md), the record's own table of transcribed theorems: a candidate whose mechanism is a cited theorem is settled there in one read. *Then the fence posts, [findings/](../findings/), [ATTEMPTS.md](../ATTEMPTS.md) by MECHANISM through its index, [reviews/](.), [references/](../references/) and [verification/](../verification/).*
4. **A candidate that does not bear on the one open statement is not a candidate**, whatever else it would improve. *That is the whole content of the rubric change this sweep exists to serve.*
5. **Say plainly if the answer is that no route exists.** *Four sweeps have produced four posts, and a fifth post is a real outcome. What is not acceptable is a route proposed without its mechanism screened, since that is how three of the last four were spent.*
