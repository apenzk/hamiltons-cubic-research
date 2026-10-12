# Step 9 position file, 2026-09-16, written on Opus

**This file replaces reading the record.** The sweep reads it and nothing else of the record whole, appending to `2026-09-16-LIT-step8-sweep.md` after every batch.

## Why step 9 was entered, and it is not an empty plan

The plan holds 27 advance items, 20 build, 2 disprove. **Step 9 was entered for the other reason the skill names**: the top of the graded table does not touch the open statement, so the next action is to invent a route rather than work the top.

Of 24 graded rows, 18 score above zero. **No item scores `closes` 3 and `attackable` ≥ 2.** The two that would close the goal, I36 and I73, score `attackable` 1, a route must be invented. Five that would settle it outright, I1, I7, I37, I3, I4, score `attackable` 0, every named route closed. The live top is I106 at $2\times2\times1\times1=4$, a named *step* of R27.

## The goal, and exactly what is open

The goal is in [README.md](../README.md). **Every other piece of Problem P is proved**: the diagonal case at every $n\ge4$, and the symmetric-space case for every $n\ge12$.

**THE REMAINING OPEN STATEMENT, and `closes` is measured against it alone:**

> $\theta\le\sqrt{3/2}$ at every non-diagonal critical point.

In two halves: the $S=0$ half (plan items I1 and I7) and the $S>0$ half (I37).

## What the last twelve sweeps produced, and the conversion rate

**This is the half most often skipped, and it is the reason this file exists.** Twelve sweeps have run, 2026-09-02 through 2026-09-14c. The six most recent produced seven routes in three days:

| sweep | route | fate |
|---|---|---|
| 2026-09-12 | R19 | **CLOSED the day it opened**, as [post F65](../findings/fence-posts.md) |
| 2026-09-12 | R20 | **CLOSED the day it opened**, both cited sources failing |
| 2026-09-12 | R21 | **CLOSED the day it opened**, no multiplicity cap obtainable in principle |
| 2026-09-13 | R22 | **CLOSED at its root, the day it opened** |
| 2026-09-13 | R23 | **demoted to reserve the same day**, its payoff having no method |
| 2026-09-13b | R24 | live, reserve |
| 2026-09-14 | R25 | live, primary for one day, then superseded |
| 2026-09-14b | R26 | **ABANDON CONDITION MET the day it opened** |
| 2026-09-14c | R27 | live, chosen by the user, and its third rung is still unfinished |

**Five of seven were closed, abandoned or demoted within a day of opening.** A sweep that does not know this repeats it.

**AND THE FAILURES SHARE ONE CAUSE.** R19 closed *as* [post F67](../findings/fence-posts.md); R26 was abandoned because its reflection lemma's decoupled and joint scalar forms are both F67, "a fourth time"; R27 carries F67 as its own abandon condition. **F67 says: decoupling the frame split's two terms cannot beat $\Theta_n$, so no bound of that shape reaches $\sqrt{3/2}$**, because the two quantities are one number at the configurations that matter. *A candidate that bounds block terms against their couplings separately is already dead, and this is the most expensive kind of proposal because it looks new.*

## The live routes, and what each already needs

Eight are live. **Check every candidate against these before proposing it: a route the record already carries outranks a new one.**

- **R27**, block induction on $\mathcal S_J$, climbing $\lvert J\rvert$. *Chosen by the user 2026-09-15.* $\lvert J\rvert=1$ is L57, $\lvert J\rvert=2$ is L224 by a pair-specific mechanism, $\lvert J\rvert=3$ is the live node, $J=[n]$ is the root. **No cell of the register names a step from $\lvert J\rvert$ to $\lvert J\rvert+1$**, and within $\lvert J\rvert=3$ the induction $G(2)\to G(m)$ is also open. Abandon if the step reduces to a decoupled bound.
- **R25**, value-bootstrap tubes at every gapped critical orbit. Clearance: the far region, a maximiser outside every tube; a successor must consume the value or the global comparison, since padded $W_{\mathbb{CP}^2}$ meets criticality and local maximality without being diagonal.
- **R24**, the frame split. Clearance: must not be a four-index inequality in a frame, and must supply a lower bound on the diagonal mass at critical points beyond Schur's frame average $6/((n+1)(n+2))$.
- **R17**, the lifted Jäger chain, primary from 2026-09-03. Needs a proof of the grant on the non-commuting remainder and a sharp two-regime comparison, of which nothing is sketched.
- **R18**, coordinate-diagonality as an integrality condition. **Its first link has no method** and fails at $W_{\mathbb{CP}^2}$ at the threshold itself.
- **R16**, isolation of the pure locus, blocked at I18. **I18 is the programme's most-attempted ground**: nine attempts, four refuted at Gate 2, three fence posts F50, F51, F52.
- **R23**, the Fox algebra's mediality or isospectrality, reserve, payoff has no method.
- **R11**, the conjunction, fallback: needs a critical point that is a local maximum *and* Morse–Bott degenerate. **None has ever been exhibited.**

## The fence posts a candidate must clear

34 posts are stated in full, 69 rows in the traps index. The ones bearing hardest on the open statement:

- **F67**, above. The recurring killer.
- **F68**, freeing two outer blocks at fixed *separate* norms in arbitrary diagonal fields fails; at fixed *total* norm it survives.
- **F69**, a condition on the Lagrange fields can be criticality restated, so a proposed maximality input is tested by substituting that field's own form. Four instances.
- **F65**, the trace-form bound cannot reach $\sqrt{3/2}$, its input exhausted rather than its estimate.
- **F66**, the maximiser is not a moment-map minimal vector: no reductive group both preserves $\mathcal W_n$ and acts non-isometrically.
- **F50, F51, F52**, fencing I18's clauses; F51 proves a rearrangement of the pair data cannot beat a bound already derived from that data.

## Where the current node actually stands

I106, R27's $\lvert J\rvert=3$ step, after 35 batches: **criticality does not force commutativity** (four exact non-commuting critical points), **the second-order conditions do not exclude them**, and three further levers closed this cycle, the conjugation orbit, any condition on the fields, and the $V$ pairing as a source of an upper bound on $\mu$. **The one surviving lever is the value comparison**, which this cycle tested against the three points that clear every recorded necessary condition and won at all three, by $1.535$, $1.444$ and $1.098$. *It is a witness argument at three points, not a proof.*

## Gate 2 debt, owed and undispatched

Batch 34, batch 35, and the I104 Gram exhaustion. All three are marked pending where they are stated and cited nowhere as settled.

## What this sweep is asked to find

**Not another attack on the $\lvert J\rvert=3$ node.** Two things, in order:

1. **A mechanism that carries a block-induction rung to the next one**, since R27's ladder has three bespoke rungs and no rule for making a fourth. Ask what field proves statements of the form "the supremum over a subalgebra filtered by an index set is attained at the commuting locus", stripped of this programme's names.
2. **Failing that, a route to the open statement that is not a decoupled bound**, since F67 has now killed or fenced four.

**Be bold and look past the problem's own boundary.** The record's vocabulary is a local dialect; a sweep that stays inside it finds the record.
