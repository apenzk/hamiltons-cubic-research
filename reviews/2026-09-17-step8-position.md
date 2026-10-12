# Step 9 position file, 2026-09-17

**Written on Opus before the switch, so the sweep that follows reads this rather than the record.**

## Why the sweep is running

**Section 1 has twenty live items and NOT ONE can be started.** Every row scores `attackable` $\le1$: a route must be invented, or every named route is closed. *That is not a low ranking. It is the rubric saying the list cannot be worked.*

```
val atk cls  item
  3   1   3  I73      splits the goal, no route known
  3   1   3  I36      settles the goal via L57, no route known
  2   1   2  I89 I77 I76 I71 I68 I6 I106b I100
  1   1   1  I81 I75 I74 I104
  0   3   0  I95
  0   0   3  I7       the destination, no route known
  0   0   2  I4 I37 I3 I1
```

**Five of the six zeroed items are zeroed by the same factor, `attackable`.** *One obstruction wearing five numbers.*

## The open nodes

**THE REMAINING OPEN STATEMENT IS $\theta\le\sqrt{3/2}$ AT EVERY NON-DIAGONAL CRITICAL POINT**, in two halves: the $S=0$ half ([I1](../plan.md), [I7](../plan.md)) and the rest. Every reduction is done. **One statement remains and it is the hard one.**

Percentages, with denominators named because they disagree: plan items closed **48%**; section 1 rows scoring above zero **70%**; the problem itself, **one statement open**.

## What this session closed, and what it cost

| | |
|---|---|
| **I53** | PROVED, Gate 2 passed. $\langle Bu,u\rangle=0$ from infinitesimal invariance of $T$ at $(z,z,z)$, no criticality, no fourth derivative, no $\theta$ |
| **I48** | PROVED, Gate 2 passed. L35's owed one-negative case gives $\theta\le0$. **Content confined to rank $\ge6$**, which is open |
| **I104** | its last source closed as [post F70](../findings/fence-posts.md): the $x\to\kappa_i$ link is real, sharp and short by a factor $1.65$. Regraded to value 1 |
| **I2** | HANDED OFF to the verification loop, which already owned its debt |
| **I106, I106a** | moved to BLOCKED, `attackable` regraded $2\to0$, their only lever waiting on I106c |

**Three errors of the cycle's own were caught by checks rather than by the author**: a constant recorded as unstated while its derivation stood in the file being edited; a non-existence claim reached by testing one guessed formula; and a substitution into a bound outside its hypothesis class. *Filed as proposals 133, 134 and 135.*

## Live routes, and what each still needs

| route | state | what it needs |
|---|---|---|
| **R28** orthostochastic rung | LIVE, current | its object is a COUPLED pair, and the uncoupled rung is finished while the coupled one is untouched |
| **R27** block induction | LIVE | the $\lvert J\rvert=3$ step, whose remaining lever waits on I106c |
| **R25** value-bootstrap tubes | LIVE, was primary | |
| **R17** the lifted Jäger chain | LIVE, primary from 2026-09-03 | its global half is I2, I3, I6; I2 is now the verification loop's |
| **R24** frame split | LIVE, reserve | |
| **R23** Fox algebra structure | LIVE, reserve | its payoff I89 has no method |
| **R18** integrality | LIVE, **first link has no method** | |
| **R16** isolation of the pure locus | LIVE, reserve, blocked at I18 | |
| **R11** the conjunction | LIVE, fallback | a critical point that is a local maximum AND Morse-Bott degenerate; none has ever been exhibited |

## Fence posts bearing on the open nodes

**[F70](../findings/fence-posts.md), added today**: the $x\to\kappa_i$ link cannot close I104's $0.0148$. A successor must bound a DIFFERENT quantity, not sharpen this one, since the three factors are already at their maxima and the product is still short.

**[F69](../findings/fence-posts.md)**: a condition on the Lagrange fields can be criticality restated, so a proposed maximality input is tested by substituting the field's own form. *Fired five times.*

**F65 to F68** and the full table are in [INDEX-traps.md](../findings/INDEX-traps.md).

## WHAT PREVIOUS SWEEPS ALREADY COVERED

**This is the half most often skipped, and it is what stops a search being repeated.**

| sweep | what it found, and what it exhausted |
|---|---|
| **2026-09-16** | the orthostochastic rung. Batch 1 maximisers of trace polynomials over tuples and when they commute; batch 2 joint $c$-numerical ranges over frames, and orthostochastic matrices, **which is the field's name for the node**; batch 3 read the sources at the theorems, one screened OUT; **batch 4, linear optimisation over the orthostochastic set: searched, NOTHING beyond batch 3.** Chose R28 |
| **2026-09-14c** | R26 read upward, giving R27's block induction |
| **2026-09-14b, 2026-09-14** | R25, the first run from the root of Problem P |
| **2026-09-13b** | R24, the frame split, derived on Fable after **five sweeps found no method** |
| **2026-09-13** | R23, the Fox algebra's mediality and isospectrality |
| **2026-09-02** | R16, isolation of the pure locus |

**So the orthostochastic direction is searched out**, and the sweep that follows should not re-enter it. *Batch 4's "searched, nothing found" is the most useful line in that file.*

## What the sweep should be told to do

**Ask what field the remaining open statement belongs to when stripped of this programme's names**, and read that field including machinery the programme has never used. *The record's vocabulary is a local dialect and a sweep that stays inside it finds the record.* **Six sweeps have now chosen routes from inside; two of the last three routes are blocked or closed.**

**And check the register first**: a route the record already carries as an unregistered chain outranks a new one.
