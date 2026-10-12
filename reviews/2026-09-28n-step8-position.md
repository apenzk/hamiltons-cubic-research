# Step 9 position, 2026-09-28n: P's remaining node, after the I117 cycles since 28m

*Opened by the loop's step 9 gate: the top closer of section 1 is [I36](../plan.md) (grade 3, `attackable` 1), which stands on [I73](../plan.md#blocked), BLOCKED under the churn cap with its two requirements. The last sweep aimed at P is [28m](2026-09-28m-LIT-step8-sweep.md), a few hours and five I117 commits ago.*

## Phase 1, where the project stands

- **What the cycles since 28m closed, all on [I117](../plan.md) (statement H, the $\#$ half):** [L285](../findings/second-order.md), $\mathfrak{sp}(k)$'s equal-weight sector holds only $I/c$, in Lean; $\mathfrak{sp}(k)$'s torus rows as two square completions ([SpTorusBlocks.lean](../lean/HamiltonsCubic/Results/SpTorusBlocks.lean)); H on a simple subalgebra asks only for a trace lower bound ([TraceThreshold.lean](../lean/HamiltonsCubic/Results/TraceThreshold.lean), Gate 2 [r1896](REVIEW_r1896.md), [r1897](REVIEW_r1897.md)); and every positive torus idempotent of $\mathfrak g_2$ has trace at least $2$, so H asks nothing more of $\mathfrak g_2$'s torus family, and by the same row argument nothing more of $\mathfrak{sp}(2)$'s and $\mathfrak{sp}(3)$'s ([note](2026-09-28l-I117-g2-torus.md), unreviewed).
- **What still stands between the programme and P**, as 28m left it: *a global maximiser is diagonal in some frame* ([L57](../findings/problem.md) finishes from there), with two requirements on any route: **exact on the unbalanced products** to a relative $n^{-3}$ ([L232](../findings/diagonal-half.md)), and **global**, since padded $W_{\mathbb{CP}^2}$ is a second-order critical point at $\sqrt{3/2}<\theta_0$ ([F73](../findings/INDEX-traps.md)). The $\#$ half (I117) feeds P only inside a coupling that uses both halves at one tensor, and no mechanism for that coupling is named.

## The live items and their grades

[I36](../plan.md) (3, stands on I73), [I117](../plan.md) (2), [I115](../plan.md) (2), [I106b](../plan.md), [I100](../plan.md), [I71](../plan.md), [I89](../plan.md), [I68](../plan.md), [I76](../plan.md), [I77](../plan.md), [I6](../plan.md) (2 each), and the grade-1 items. Blocked: [I73](../plan.md#blocked), [I121](../plan.md#blocked).

## Fence posts bearing on the node

[F73](../findings/INDEX-traps.md) (padded $W_{\mathbb{CP}^2}$ is second-order critical below $\theta_0$), [F39](../findings/fence-posts.md) (I73 (b) blind), [F77](../findings/fence-posts.md) to [F79](../findings/fence-posts.md) (I73 (c)), [F26](../findings/INDEX-traps.md) (the halves maximised apart).

## What previous sweeps covered

Thirty-seven sweeps from [2026-09-02](2026-09-02-LIT-step8-sweep.md) to [28m](2026-09-28m-LIT-step8-sweep.md). The goal-level ones are [2026-09-23](2026-09-23-LIT-step9-sweep.md), [28i](2026-09-28i-LIT-step8-sweep.md) and [28m](2026-09-28m-LIT-step8-sweep.md); [28i's position file](2026-09-28i-step8-position.md) lists the subjects searched. The metrised-algebra literature (Tkachev, Krasnov–Tkachev, Fox) is on file in [references/](../references/) with verdicts: no bound on an idempotent's norm or trace, and the extremal idempotent's Peirce spectrum in $(-\infty,\tfrac12]$ (Krasnov–Tkachev Proposition 6.6).

## Questions for this sweep

1. **The largest-weight row, applied to P.** Today's argument turns a positive solution of a system that is linear, with nonnegative coefficients, in a subset of its unknowns into a lower bound on a linear functional, by reading the row of the largest unknown. Do P's criticality equations at a maximiser, written in a frame, have a subsystem of that shape in the off-diagonal part, so that the largest off-diagonal entry forces a mass that global maximality forbids?
2. **The trace reformulation, turned on P.** H became a trace inequality at idempotents by pairing with $I$. Does pairing P's criticality equation with an invariant tensor give a scalar identity that reads the value $\theta$ against the diagonal mass, exact on products?
3. **Outside the dialect.** In the metrised-algebra literature, is there any statement that an extremal idempotent lies in an associative or diagonalisable subalgebra (for P, the diagonal Weyl tensors of a frame)?
