# Gate 2 brief (one reader): G2TorusWeyl.lean against the note's Weyl-invariant claim

**This round compares a complete Lean proof against the claim it types, so it has one reader.** Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: read and compare; the smallest computation that settles a point (seconds), and `lake env lean` on the one file if needed.

## The claim, verbatim from [the note](2026-09-28l-I117-g2-torus.md)

- **On the Weyl-invariant weights** (long $x$, short $y$) the system is $x(1-6x^2-2y^2)=x^2+y^2$ and $1-2x^2-\tfrac23y^2=2x+\tfrac43y$, whose positive solutions are exactly $(\tfrac14,\tfrac14)$, which is $I/4$, and $(\tfrac9{28},\tfrac3{28})$, which is L263's. *Solved exactly; the other two roots have $x=-\tfrac12$.*

The two equations are the note's six-equation system with every long weight $x$ and every short weight $y$ (Gate 2 [r1884](REVIEW_r1884.md), [r1885](REVIEW_r1885.md) confirmed the reduction).

## Items

1. **Statement fidelity.** Does `weyl_invariant_solutions` in [G2TorusWeyl.lean](../lean/HamiltonsCubic/Results/G2TorusWeyl.lean) state exactly the claim: the same two equations, positivity of both weights, and the conclusion that the pair is one of the two points? Check the two equations against the six-equation system of the note restricted to uniform long and short weights.
2. **Axioms and vacuity.** `#print axioms` on it (the standard three only), and the non-vacuity example.
3. **Prose against proof.** Does the note's Lean sentence describe what the proof does (the Gröbner lifts, the factor $(4y-1)(28y-3)(4y^2+8y-9)$, the quadratic factor forcing $x=-\tfrac12$)?

## Lean table

| claim | declaration |
|---|---|
| the Weyl-invariant positive solutions are exactly the two points | `weyl_invariant_solutions` |
