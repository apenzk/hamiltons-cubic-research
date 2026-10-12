# Round L100, the 8 <= n <= 11 dichotomy

**Id:** L100 · **Date:** 2026-09-14 · **Verifiers:** v311, v312, v313 · **Brief:** [BRIEF_L100.md](BRIEF_L100.md) · **Logs:** `agent_logs/verify-L100-v311.log`, `agent_logs/verify-L100-v312.log`, `agent_logs/verify-L100-v313.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and statement | [findings/route-a.md](../findings/route-a.md) lines 55, 69 |
| L20, given | [findings/route-a.md](../findings/route-a.md) lines 109, 127-141 |
| L21, given | [findings/route-a.md](../findings/route-a.md) lines 178, 180, 196 |

**Withheld**: the Gate 2 stacks under L100, L20 and L21, both Lean files for L100, and every index row.

## The findings from phase 0

**The heading's range starts at $8$ and the body's argument at $9$**, the two horns are not independent given the padding value, and no [results.md](../results.md) entry exists. Brief items 1 and 2.

## Phase 2, clustering

**Verdicts: [v311](VERIFY_v311.md), [v312](VERIFY_v312.md), [v313](VERIFY_v313.md) all `HYPOTHESIS-DEBT`.**

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| A1 | the heading's range at $n=8$ | L21 gives $\alpha\le\tfrac13$ at $n\ge9$ only, and nothing else on file reaches $n=8$ | v311, v312, v313 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L100_A1.md](ADJ_L100_A1.md) |
| A2 | L20's radius step, $\psi\le1$ on $[0,0.5748]$ | the bracket $s^*\in(0.5436,0.5437)$ contains $\sin(0.5748)=0.5436669$, so it does not order them | v312, v313 (`HYPOTHESIS-DEBT`), v311 (withdrawn as L20's given) | **phase 3**, [ADJ_L100_A2.md](ADJ_L100_A2.md) |
| C | the two horns, the metric, L20's proof below the crossover, parity | direct | v311, v312, v313 (`CONFIRMED`) | no finding |

**Phase 2 search of the whole record, before adjudication.** For A1: [ATTEMPTS.md](../ATTEMPTS.md) records $\alpha\le\tfrac13$ as verified in floating point at $n=8$ and argued at $n\ge9$; nothing on file argues it at $n=8$. For A2: [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) proves the bracket $(0.5436,0.5437)$ in the kernel and nothing that orders $s^*$ against $\sin(0.5748)$.

## Phase 3, adjudication

**Two fresh verifiers per finding, asked the step neutrally:** A1 to v314 and v315, A2 to v316 and v317.

| id | adjudicators | outcome |
| --- | --- | --- |
| A1 | [v314](VERIFY_v314.md) `VALID`, [v315](VERIFY_v315.md) `VALID` | **withdrawn** |
| A2 | [v316](VERIFY_v316.md) `VALID`, [v317](VERIFY_v317.md) `VALID` | **withdrawn** |

**The defence of A1, from both adjudicators independently.** Every input of L20's argument except $\alpha\le\tfrac13$ is dimension-free, and the dichotomy consumes only $m\le1$, never the sphere-product witness. Zero-padding $\iota:\mathcal W_8\to\mathcal W_9$ lands in $\mathcal W_9$, is an isometry fixing $u$, intertwines $\#$ because $\mathfrak{so}(8)$ is a subalgebra, and maps $u^\perp\cap T_u\mathcal O_8^\perp$ into $u^\perp\cap T_u\mathcal O_9^\perp$: the $\mathfrak{so}(8)$ directions by equivariance, the mixed directions by the reflection $\sigma=\mathrm{diag}(1,\dots,1,-1)$, which fixes padded operators and negates mixed generators. So L21 at $n=9$ gives $\alpha\le\tfrac13$ at $n=8$, and $n=8$ owes exactly what $n=9$ owes. **Both also refute the Gate 2 note's "at $n=8$ the failure is structural"**: the $SO(4)$ splitting stops L21's isotypic proof at $m=4$ and leaves the inequality standing.

**The defence of A2, from both adjudicators independently.** On $[0,\pi/2)$, $\psi\le1$ is $s^2(1-s)(1-s-s^2-s^3)\ge0$ with $s=\sin\varphi$, after squaring two positive sides, so $\psi\le1\iff s\le s^*$. $\sin x\le x-x^3/6+x^5/120$ at $x=0.5748$ gives $\sin(0.5748)<0.543672$ in exact rationals, and $0.5436890<s^*$ is `bracket_tight` in [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) (v317 also gives $g(0.54368)<0$ by hand). v315 found, outside its step, that L20's printed bracket $(0.5436,0.5437)$ contains the printed $\sin(0.5748)=0.5436669$ and so orders nothing, which is the text the step's defence replaces.

**A correction to phase 2's search.** It said TubeRadius.lean orders nothing against $\sin(0.5748)$. `bracket_tight` puts $s^*$ above $0.5436890$, which with any upper bound on $\sin(0.5748)$ below that orders them, so half of A2's defence was already on file.

## Phase 4, dependents

**No finding was confirmed, so nothing propagates.** The search for L100 by number, by its statement ("$8\le n\le11$", "$0.5748$" with "dichotomy") and by its file finds [INDEX-results.md](../findings/INDEX-results.md) row 100, two [lean/INDEX.md](../lean/INDEX.md) rows, [L100.lean](../lean/HamiltonsCubic/Results/L100.lean), [L100Statement.lean](../lean/HamiltonsCubic/Results/L100Statement.lean) and a node in [diagram-full-dag.tex](../report/sections/diagram-full-dag.tex), all mentions. No result consumes L100. **Copies of L20's radius comparison**: [route-a.md](../findings/route-a.md) line 139 and [90-appendix.tex](../report/sections/90-appendix.tex), whose version rested on a decimal crossing $\varphi_c$. **Impact `CONTAINED`.**

## Phase 5, what was changed

**Verdict: `PROVEN, hypotheses corrected`.** The hypothesis is $\alpha\le\tfrac13$, which the block's own sentence carried as "wherever $\alpha\le\tfrac13$ holds" and its heading dropped. It is L21's at $9\le n\le11$ and L21's at $n=9$ for $n=8$, so L100 carries L21's debt, routed as I54, and no debt of its own.

- **[route-a.md](../findings/route-a.md)**: the Gate 2 stack and the "bonus" paragraph replaced by a statement at $8\le n\le11$ with the hypothesis inside it, a proof pointing at L20's chain, and the padding step written out. L20's comparison replaced by the exact reduction and the Taylor bound.
- **[results.md](../results.md)**: a landscape line and a detail entry, the first L100 has had.
- **[INDEX-results.md](../findings/INDEX-results.md)** row 100, **[lean/INDEX.md](../lean/INDEX.md)** rows for L100 and the tube radius, **[L100.lean](../lean/HamiltonsCubic/Results/L100.lean)** retyped from "the honest range $9\le n\le11$" to the dimension each $n$ draws L21 at, and the owed Taylor comparison named in the TubeRadius row.
- **[90-appendix.tex](../report/sections/90-appendix.tex)**: the exact comparison in place of $\varphi_c$, the odd-$n$ witness in place of "the balanced sphere product at every $n\ge12$", and two em dashes removed.
- **[ATTEMPTS.md](../ATTEMPTS.md)**: the removed passages and the round's account.

**The added text is new**, so L100 and L20 re-enter the queue for a repair audit. The padding step and the Taylor comparison are each derived by two independent readers.

## Phase 6

L100 stays in *To check* with its repair audit owed, L20 returns there, and the next id is L101.
