# Step 9 position, 2026-09-26b: I73 after four closures, questioning the approach

**Written under the churn-cap rule's three-closure clause**: R39 (reach gate), route A (class-projector great circles), D3 (two-dimensional slices) and the Theorem 4.17 repair (already held by [L20](../findings/route-a.md)) have closed on [I73](../plan.md) with no derivation between them. The pick must come from a sweep that questions the approach itself.

## The approach being questioned

Every route on I73 characterises the maximiser $W$ from information at $W$: criticality rows, second variation, great circles and slices through $W$, per-eigenspace ceilings. **The teeth tests of the [first sweep](2026-09-26-LIT-step8-sweep.md) show this family is blind at padded $W_{\mathbb{CP}^2}$**: the point beating it is orthogonal to $W$, flat to second order and high-rank in the $E_0$ pair span, and every low-dimensional or averaged family built from $W$'s eigendata misses it. *So what is missing is global information, and the only global datum any route has used is the value comparison $\theta\ge\theta_0(n)$*, which R39 consumes per vector at $O(p)$ against the needed $O(\sqrt p)$.

## Directions outside that family, screened

| direction | what it would use | screen |
|---|---|---|
| a rearrangement map $T$ with $P(TW)\ge P(W)$ and $TW$ two-valued | a global map, the analyst's symmetrisation | no candidate map: the only natural two-valued competitor is the best product, and "$P(W)\le\theta_{p,q}$" is the goal itself |
| Morse theory, Łojasiewicz flow, Z-eigenvalue and nonnegativity certificates | all critical points at once | covered by the ten earlier sweeps ([2026-09-22](2026-09-22-LIT-step8-sweep.md)), no method |
| extremal idempotents (Tkachev, Krasnov–Tkachev) | algebra identities at the extremal idempotent | covered, the Weyl algebra is neither eiconal nor medial ([notes](../references/tkachev-2019-spectral-nonassociative/README.md)) |
| a class-level ceiling from $\theta\ge\theta_0$ scaling with $\sqrt p$ | the value hypothesis at the level of a whole eigenspace | open, no named inequality: the averaged fourth moment gives $\mathbb E\operatorname{tr}x^4\le2n/(p+2)$, already on file as insufficient |

**Web searches** (Huisken-type sharp cubic constant, symmetrisation for invariant cubics on spheres, Tkachev 2025 to 2026, Nienhaus and Böhm–Wilking follow-ups): nothing beyond the shelf.

## Outcome

**No route with a live method.** The pick is the fourth row as an invention task, recorded as D6 and started: it is the only direction that consumes the global datum.
