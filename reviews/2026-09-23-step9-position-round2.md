# Step 9 position file, 2026-09-23, second round

**Written on Opus before the switch, so the sweep spends its budget on judgement rather than on reading the record.** *Phase 2a. The sweep that follows appends to `2026-09-23-LIT-step9-sweep-round2.md` after every batch.*

**Why a second round on the same date.** The [first round](2026-09-23-step9-position.md) produced three routes. One of them, R-C, became [R31](../routes.md) and is now **CLOSED**, killed by a post that predates it by a month and that the proposal never screened against. The other two are [R30](../routes.md) at `attackable` 1 and R32 at `attackable` 1. *So the round delivered no startable route, and the gate is correct to ask for another.*

## The open statement, and the one road to it

- **P**, Conjecture A, as [README.md](../README.md) states it.
- ← **[R25](../routes.md)**, PRIMARY, carrying [L217](../findings/second-order.md) and [L220](../findings/second-order.md).
- ← **[I104](../plan.md)**, its far region, a $0.0148$ deficit.
- ← **[I110](../plan.md)**, SETTLED: the binding corner is excluded, proved twice.
- ← **[I73](../plan.md)**, grade 3, route [R30](../routes.md): a global maximiser's spectrum takes two values, equivalently $W^\#\in\mathop{\mathrm{span}}\{W,\mathrm{Id}\}$ through criticality. **[L105](../findings/bounds-relaxations.md) then closes P outright.** `attackable` 1: sub-step (ii) is open and **what is owed is an instrument**.

## The impasse, measured rather than described

**Section 1 holds 21 items. The `attackable` distribution is $\{0:5,\ 1:15,\ 2:0,\ 3:1\}$.** *Twenty of twenty-one cannot be started.* The three items scoring 3 on `closes`, which is to say the only three that would settle P outright, sit at `attackable` 1, 1 and 0: [I73](../plan.md), [I36](../plan.md) and [I7](../plan.md).

**No item on the list both closes the statement and has a route.** That is the condition the rubric defines step 9 for, and it is now read back by [loop_stop.py](../.claude/hooks/loop_stop.py)'s `_unreachable_top` rather than left in prose.

**Fifteen items zeroed or floored on one factor is one obstruction wearing fifteen numbers.** *The obstruction is that the programme has reductions and no instruments: every remaining node is a statement whose proof would need a tool nobody has named.*

## What previous sweeps have already covered, and must not be re-run

**This is the half of a position file that is most often skipped, and it is the half that stops a sweep repeating itself.**

- **The 2026-09-10 sweep**, four fields, six phrasings, on [I68](../plan.md) and [I37](../plan.md), returning nothing. Recorded as [post F64](../findings/fence-posts.md) with its batches in [the sweep file](2026-09-10-LIT-step8-sweep.md) and [its position file](2026-09-10-step8-position.md). **The four fields: extremal-rank theory for semidefinite programs; symmetric-tensor eigentheory; the higher-dimensional algebraic classification of Weyl tensors; the stability and rigidity of Lie algebras.** *F64 also records that under their own names the Ricci-flow sources carry the ODE, the pinching cones and the two-positive theorem, and that no source treats the maximiser of the cubic on the Weyl sphere.*
- **The 2026-09-23 first round**, four batches: the minimal-polynomial reframing, the curvature operator of the second kind, Schur--Horn and Kostant convexity, and invariant curvature cones. *Schur--Horn came back CLOSED on the record, caught by the screen. The second-kind batch produced R31 and is now closed by F33.*

## The fence posts a new route must clear

| post | what it forbids |
|---|---|
| **[F33](../findings/fence-posts.md)** | **the wall this round just hit.** All seven stored second-kind references carry estimates normalised by $\bar\lambda=\mathrm{scal}/(n(n-1))$, which **vanishes on a Weyl tensor**, so no bound of that shape transfers. *A candidate drawing on Einstein or scalar-curvature rigidity meets this first.* |
| **3a, in the closed-route table** | the Cheng--Wang transfer, shut on a $1.45\times$ loss at the extremiser where the conjecture asserts **equality**. *Any route whose endgame is an inequality loose at the extremiser is this row again.* |
| **[F64](../findings/fence-posts.md)** | the two nodes the goal needs have no literature under their own names or stripped of them. **A sweep that re-runs its four fields returns nothing, and F64 says so in advance.** |
| **the pattern line under the closed-route table** | every closed route reasoned from the $\Lambda^2$ or second-kind **spectrum**, and [problem.md](../findings/problem.md) item 5 **proves** the spectrum cannot decide it: $\langle W^\#,W\rangle$ carries $98.2\%$ of $\theta$ at the maximiser and depends on **eigenspace alignment**. *This is the strongest single constraint on the list.* |
| **[F73](../findings/fence-posts.md)** | no local-to-global theorem for forms on spheres applies to $P$. |
| **[F42](../findings/fence-posts.md)**, **[F6](../findings/fence-posts.md)** | no route through the pinned data closes it, and the moment method needs a fourth universal moment identity nobody has. |

## What the sweep is actually looking for

**An instrument, not a reformulation.** *The record is rich in equivalent statements of [I73](../plan.md) and poor in anything that would prove one.* The first round's R-A is a good reformulation and it did not move `attackable`, which is the lesson to carry in.

**Three properties a candidate needs, and the third is where the last round failed.**

1. It reaches a statement a reader can check by hand, since `analytic` $0$ caps the value at zero.
2. It supplies second-order information at a maximiser, because criticality alone is one equation and every item here is stuck on the gap between critical and maximal.
3. **Its input survives a Weyl tensor.** *Scalar curvature vanishes, the Ricci part vanishes, and any normalisation built from them vanishes with it.* This is F33 generalised, and it is the screen to run FIRST on every candidate rather than last.

**Go outside the dialect.** *The record's vocabulary is local, and a sweep that stays inside it finds the record.* The stripped question is: **how large can an invariant cubic form be at a maximiser on the unit sphere of an irreducible representation, given that the gradient equation is quadratic?** Fields that own some part of that and are NOT in the covered list above: real algebraic geometry of invariant forms, the theory of Jordan algebras and their trace forms, spherical designs and cubature, and the structure of maximal tori acting on representation spheres.
