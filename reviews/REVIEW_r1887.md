# REVIEW r1887: G2TorusWeyl, the Weyl-invariant solve on g2's torus family

Gate 2 review, one reader, of [G2TorusWeyl.lean](../lean/HamiltonsCubic/Results/G2TorusWeyl.lean) against [the note](2026-09-28l-I117-g2-torus.md), brief [BRIEF_I117_g2_weyl_lean.md](BRIEF_I117_g2_weyl_lean.md). Log: [agent_logs/r1887-i117-g2-weyl-lean.log](../agent_logs/r1887-i117-g2-weyl-lean.log). Analysis-only footing: the reduction was checked by hand, and the one computation beyond the compile is a lex Gröbner basis of two plane equations in Sage (seconds), reported as a screen.

| Item | Verdict |
|---|---|
| 1. Statement fidelity | CONFIRMED |
| 2. Axioms and vacuity | CONFIRMED WITH ONE CORRECTION (the non-vacuity example checks the first equation only) |
| 3. Prose against proof | CONFIRMED |

**One line.** `weyl_invariant_solutions` types the "only these two" half of the claim exactly, and compiles on the standard three axioms. The "these two are solutions" half is true (checked by hand below) but the file's example checks only the first equation at each point.

## Item 1. Statement fidelity: CONFIRMED

- **The hypotheses.** `hx : 0 < x`, `hy : 0 < y`, `h1` is $x(1-6x^2-2y^2)=x^2+y^2$ and `h2` is $1-2x^2-\tfrac23y^2=2x+\tfrac43y$, letter for letter the note's two equations ([G2TorusWeyl.lean:22](../lean/HamiltonsCubic/Results/G2TorusWeyl.lean#L22)). The conclusion is the disjunction of the two points.
- **The reduction, by hand.** Take short roots of length one in a model plane, $s_1=(1,0)$, $s_2=(\tfrac12,\tfrac{\sqrt3}2)$, $s_3=(-\tfrac12,\tfrac{\sqrt3}2)$, and long roots $L_1=s_1+s_2$, $L_2=s_2+s_3$, $L_3=s_3-s_1$, then rescale so $\lvert L\rvert^2=2$, $\lvert s\rvert^2=\tfrac23$. The squared inner products are $4$ (long with itself), $1$ (distinct long, and long with a non-orthogonal short), $0$ (each long with its orthogonal short), $\tfrac49$ (short with itself) and $\tfrac19$ (distinct short).
- **A long row $\gamma$.** The sum is $x^2(4+1+1)+y^2(1+1+0)=6x^2+2y^2$. The decompositions $\gamma=\pm\alpha\pm\beta$ are one long pair and one short pair (for $\gamma=L_1$: $L_2-L_3$ up to sign, and $s_1+s_2$), each with coefficient $\tfrac12$, so the right side is $2\cdot\tfrac12x^2+2\cdot\tfrac12y^2=x^2+y^2$. This is `h1`.
- **A short row $\gamma$.** The sum is $x^2(1+1+0)+y^2(\tfrac49+\tfrac19+\tfrac19)=2x^2+\tfrac23y^2$. For $\gamma=s_1$ the decompositions are $L_1-s_2$ and $s_3-L_3$ (long with short, coefficient $\tfrac12$) and $s_2-s_3$ (two shorts, coefficient $\tfrac23$), so the right side is $2\cdot\tfrac12\cdot2xy+2\cdot\tfrac23y^2=2xy+\tfrac43y^2$. Dividing by $y>0$ gives `h2`. The division is legitimate under `hy`, so the Lean statement and the six-equation system restricted to uniform weights have the same positive solutions.

## Item 2. Axioms and vacuity: CONFIRMED WITH ONE CORRECTION

- `lake env lean HamiltonsCubic/Results/G2TorusWeyl.lean` exits 0 with no messages, so no `sorry` and no warnings.
- `#print axioms HamiltonsCubic.G2TorusWeyl.weyl_invariant_solutions` gives `[propext, Classical.choice, Quot.sound]`, the standard three.
- **Non-vacuity holds for a trivial reason and the example is incomplete.** The theorem is an implication with a disjunctive conclusion, so it cannot be vacuous in the dangerous sense unless its hypotheses are contradictory, and they are satisfiable: at $(\tfrac14,\tfrac14)$ both sides of `h1` are $\tfrac18$ and of `h2` are $\tfrac56$, and at $(\tfrac9{28},\tfrac3{28})$ both sides of `h1` are $\tfrac{45}{392}$ and of `h2` are $\tfrac{11}{14}$. The file's example ([G2TorusWeyl.lean:54](../lean/HamiltonsCubic/Results/G2TorusWeyl.lean#L54)) checks `h1` at both points and `h2` at neither.
- **Correction.** Extend the example with `h2` at both points (`norm_num` closes it), or state the converse so the file types the note's "exactly" in both directions. Until then the note's "Typed: the Weyl-invariant enumeration" is accurate for the exclusion half, and the membership half is typed for the first equation only.

## Item 3. Prose against proof: CONFIRMED

- `g1` is $x+\tfrac{56}{207}y^3+\tfrac{190}{207}y^2+\tfrac{10}{69}y-\tfrac8{23}=0$, $x$ a cubic in $y$, and `g2` is $(4y-1)(28y-3)(4y^2+8y-9)=0$, both by `linear_combination` from `h1`, `h2` ([G2TorusWeyl.lean:26](../lean/HamiltonsCubic/Results/G2TorusWeyl.lean#L26)).
- **Screen (Sage, seconds).** The reduced lex basis ($x>y$) of the ideal of `h1`, `h2` is exactly $\{g_1,\ \tfrac1{448}(4y-1)(28y-3)(4y^2+8y-9)\}$, and the quotient has dimension $4$. So "a lexicographic Gröbner basis's lifts" is literally right, and the system has four complex solutions, matching the note's "the other two roots".
- **The quadratic factor.** $g_1-(\tfrac{14}{207}y+\tfrac{13}{138})(4y^2+8y-9)=x+\tfrac12$ (confirmed in the screen and by the compile), so both roots of $4y^2+8y-9$, namely $y=-1\pm\tfrac{\sqrt{13}}2$, carry $x=-\tfrac12$, which `hx` excludes. The note's "the other two roots have $x=-\tfrac12$" is correct.
- The linear factors give $y=\tfrac14$, $y=\tfrac3{28}$, and `g1` then gives $x=\tfrac14$, $x=\tfrac9{28}$, as the proof's `norm_num at g1; linarith` steps do.
- The module docstring's "Not typed" clause (the product table, the reflection-type solve) matches the note's "Untyped here".

## Observations outside the items

- **The note's reflection table header is broken** ([2026-09-28l-I117-g2-torus.md:40](2026-09-28l-I117-g2-torus.md#L40)). The byte sequence `\r` of `\rVert` was written as a newline, so the header reads `$\lVert C` on line 40 and `Vert^2$ | identified |` on line 41, and the table does not render. Restore `$\lVert C\rVert^2$` on one line.
- `G2TorusWeyl` has no row in [lean/INDEX.md](../lean/INDEX.md). The note's result is unnumbered, so this may be by design, and the module is imported from [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean).
