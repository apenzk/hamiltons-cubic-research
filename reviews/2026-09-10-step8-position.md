# Step 9 position, 2026-09-10

**Written on Opus before the switch, so the sweep reads this and not the record.** The record is what a sweep from inside would rediscover; this file is the part a sweep needs and the rest is deliberately withheld.

## Why the step fired

**Section 1's highest-value live item was a falsifier hunt on the family where the bound is already attained.** [I38](../plan.md) closed the same day as its own theorem, and closing it advanced [I1](../plan.md) by nothing: `θ ≤ √(3/2)` is ATTAINED at padded `W_ℂP²`, which has rank exactly three, so the family is the conjecture's sharpest test rather than a step toward it.

**And the primary route's own decomposition grades 2, 1 and 0.** [R17](../routes.md) is primary since 2026-09-03, split into [I2](../plan.md) (grade 2), [I6](../plan.md) (1) and [I3](../plan.md) (0, four formulations refuted). [R16](../routes.md) is a blocked reserve, [R11](../routes.md) a fallback. So no live item reaches the goal, which is the state this step exists for.

## The three nodes that would move Problem P, and none has a route

| node | what it would give | why it has no route |
|---|---|---|
| **[I68](../plan.md)**, a bound `rank(W : Λ² → Λ²) ≤ r` at every non-diagonal critical point above `√(3/2)` | turns [I38](../plan.md)'s closed theorem into progress on [I1](../plan.md) | nothing has ever worked on it, and the record carries no attempt |
| **[I37](../plan.md)**, a constant `c > 0` with every non-diagonal critical point at `S ≥ c` strictly below the graded ceiling | the other half of the critical set, which [I1](../plan.md) does not cover | needs [R12](../routes.md)'s link, unproved |
| **the diagonal case** | it is granted throughout | assumed, not proved, and out of scope by choice |

## WHAT PREVIOUS SWEEPS COVERED, AND WHAT THEY MISSED

Three sweeps are on file, all within two days of each other: [2026-09-02](2026-09-02-LIT-step8-sweep.md), [2026-09-03](2026-09-03-LIT-step8-sweep.md), [2026-09-03b](2026-09-03b-LIT-step8-sweep.md).

**Covered, with the outcome recorded:** fixed points of `Ṙ = R² + R^#` (Bhattacharya); gradedness against Lie triple systems, nothing found; spectral bounds as LP duals, nothing found; **maximisers of an invariant cubic on an irreducible module**, which returned orbit geometry, taut and cohomogeneity-three representations; **Morse–Bott nondegeneracy of critical orbits of a cubic curvature invariant**, nothing beyond Schwahn; multi-bubble stability read end to end; Łojasiewicz as the mechanism; `I5`, `L16(a)` and Route 3 stripped of names.

**NEITHER I68 NOR I37 HAS EVER BEEN SWEPT.** Every one of the three aimed at the route's headline or at items that are now closed or refuted. *That is the failure the loop's own rule names: a plan whose searches all aimed at the headline leaves its other items unsearched, and an unsearched item absorbs attempt after attempt at a question the standard theory may simply answer.*

## The two nodes stripped of this programme's vocabulary

**This is what the sweep should search, and the phrasing matters more than the breadth.**

- **I68 is a rank bound at a critical point of an equivariant quadratic map.** Stripped: `Q(W) = W² + W^#` is an `O(n)`-equivariant quadratic self-map of an irreducible `O(n)`-module; `θ = ⟨W, Q(W)⟩/‖W‖³` is its associated cubic. **The question is why a maximiser of an invariant cubic on a module should have low rank as an operator on the module's own defining space.** *Adjacent fields: real algebraic geometry of eigenvalues of symmetric tensors (Z-eigenvectors), the variational theory of trace forms on Jordan and Lie triple systems, low-rank structure of extremisers of matrix-valued quadratic forms, and semidefinite extremal-rank theory, where "extreme points of a spectrahedron have low rank" is a theorem rather than a hope.*
- **I37 is a gap theorem for a defect functional.** Stripped: on the critical set of the cubic there is a nonnegative functional `S` vanishing exactly on a distinguished sublocus; **the question is whether `S ≥ c > 0` forces the cubic strictly below its ceiling.** *Adjacent fields: quantitative rigidity and stability of extremals with a defect, Łojasiewicz-type inequalities near a degenerate critical set, and the "no-neck" or gap theorems of harmonic-map and Yang–Mills theory.*

## Standing constraints the sweep inherits

- **Analysis only.** No searches beyond the literature itself, no sweeps, no optimisation. A candidate route is proposed on a mechanism and a source, never on a computation.
- **Rank the routes analytical-first.** A route promising a closed-form statement outranks one promising better data, even when the data route looks easier.
- **Screen every candidate by GREPPING [findings/](../findings/) FOR ITS MECHANISM**, not by reading the fence-post table, and look the mechanism up in [ATTEMPTS.md](../ATTEMPTS.md)'s index rather than by name. Also reach [reviews/](.), [references/](../references/) and [verification/](../verification/), where conventions and derivations live that never earned a findings block.
- **Read [routes.md](../routes.md) whole** for what a successor to each closed route must clear.

## What the record has that a route could stand on

Stated positively, and short, because the sweep is meant to look outward.

- The `Λ²`-rank-`≤3` theorem, closed today, with its equality case pinned to padded `W_ℂP²`.
- The two-negative stratum's chain, which bounds `θ` at **every** rank with no rank reduction in it, and misses `√(3/2)` by `0.13%` at `n = 12`. *Its driver is identified as the bracket cap on the single negative pair, and five estimates have been aimed at it.*
- `Λ²ℝ⁶ ≅ 𝔰𝔬(6)` and the Pfaffian adjugate law, at six dimensions.
- The `Φ`-sphere identity `tr(ω⁴) + ‖ω∧ω‖²_⊥ = 2⟨ω,ω⟩²`, at every `n`.
