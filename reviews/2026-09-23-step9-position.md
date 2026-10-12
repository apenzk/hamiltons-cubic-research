# Step 9 position file, written on Opus before the sweep, 2026-09-23

**Why this step is running.** The graded table's top item does not touch the remaining open statement. [I111](../plan.md) grades $6$ and scores $2$ on `closes`, a named step; the only items scoring $3$ are [I73](../plan.md) and [I36](../plan.md), both at value $3$ because `attackable` is $1$, a route must be invented. *A gate now fires on exactly this condition ([loop_stop.py](../.claude/hooks/loop_stop.py)'s `_unreachable_top`), because the rule existed in prose and a full session worked the top item anyway.*

## The statement a route must reach

$$\theta\le\sqrt{3/2}\ \text{ at every NON-DIAGONAL critical point,}$$

in two halves: the $S=0$ half ([I1](../plan.md), [I7](../plan.md)) and the $S>0$ half ([I37](../plan.md)). **Everything else in Problem P is proved**: the diagonal case at every $n\ge4$, and the symmetric-space case at every $n\ge12$.

## The two items that would close it, and why neither has a route

- **[I73](../plan.md)**: *a global maximiser of $P$ has a spectrum taking exactly two values.* [L105](../findings/bounds-relaxations.md) finishes from there. **Ten sweeps, no route.** Its last named target is gone: Nienhaus Theorem 4.17 is itself conditional on Conjecture A, so removing its a-priori entry leaves the other standing, and at $n\ge12$ its tube surrounds a point that is no longer the maximiser ([the derivation](2026-09-22-circularity-derivation.md), Gate 2 [r1065](REVIEW_r1065.md), [r1066](REVIEW_r1066.md)).
- **[I36](../plan.md)**: *every local maximiser above $\sqrt{3/2}$ is coordinate-diagonal.* Then [L57](../findings/problem.md) finishes. **It ranks below I73 because I73 is its warrant**: [I75](../plan.md)'s remaining content is the bound $s\le2$, which IS I73.

## What bars the obvious approaches

**[Post F73](../findings/fence-posts.md)**: no local-to-global theorem for forms on spheres applies to $P$. Padded $W_{\mathbb{CP}^2}$ is a genuine local maximum with excess $0$, at $\theta=\sqrt{3/2}<\theta_0(n)$ for $n\ge12$, so it satisfies every local condition the record owns through fourth order and is spurious. *A route bounding $P$ over ALL of $\mathrm{Weyl}_n$ from conditions at one point cannot work.* **An argument confined to a stratum the competitor is not in is untouched.**

## What previous sweeps already covered, so this one does not repeat them

| sweep | batches | outcome |
|---|---|---|
| [2026-09-21](2026-09-21-LIT-step8-sweep.md) | see file | — |
| [2026-09-22](2026-09-22-LIT-step8-sweep.md) | rank-one approximation and Z-eigenvalues; spurious local minima of forms on the sphere; four-point rigidity and Morse theory for exclusion | all screened; the Morse route bounds from below and cannot say which of two nondegenerate local maxima is global |

**References already on file** worth walking forward rather than rediscovering: [agrachev-chebyshev-rank-one-ratio](../references/agrachev-chebyshev-rank-one-ratio/), [lasserre-2021-spurious-local-minima-sphere](../references/lasserre-2021-spurious-local-minima-sphere/), and the Nienhaus source behind I73's retired target.

## What the sweep is asked for

**Strip the programme's vocabulary and ask what field the two open halves belong to.** *The record's names are a local dialect, and a sweep that stays inside it finds the record.* **A route from outside is worth more than a refinement from inside.**

Two to four candidate routes, each with: the mechanism in a sentence or two, what running it would take, what it delivers if it works, what would falsify it, and its sources. **Ranked analytical-first, scored on section 1's own rubric** (`closes × attackable × margin × analytic`), plus one column the grade does not carry: how close the route gets to Problem P, stating what closing it would and would NOT leave outstanding.

*Screen every candidate by GREPPING [findings/](../findings/) for its mechanism's own name before ranking it, and check it against [routes.md](../routes.md) and [ATTEMPTS.md](../ATTEMPTS.md)'s index by mechanism rather than by name. Five novelty claims collapsed in the preceding session for want of exactly that check.*
