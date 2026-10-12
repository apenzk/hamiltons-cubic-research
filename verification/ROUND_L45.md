# Round L45, off the slice: five surviving triples, and one coupling

**Id:** L45 · **Date:** 2026-09-14 · **Verifiers:** v236, v237, v238 · **Brief:** [BRIEF_L45.md](BRIEF_L45.md) · **Logs:** `agent_logs/verify-L45-v236.log`, `agent_logs/verify-L45-v237.log`, `agent_logs/verify-L45-v238.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the findings statement | [findings/target.md](../findings/target.md) lines 758-767, under the heading at line 742 |
| the landscape statement | [results.md](../results.md) line 104 |
| the canonical entry | [results.md](../results.md) lines 380-384 |
| the argument | [findings/problem.md](../findings/problem.md) lines 76-92 |
| the Lean statement | [L45Statement.lean](../lean/HamiltonsCubic/Results/L45Statement.lean), whole file, no `sorry` |

## The findings from phase 0

**The block is an annotation stack**: six blockquoted Gate 2 notes sit between the heading and the statement, recording what was wrong rather than the corrected mathematics, the shape this loop's core rule removes. *They are withheld from the brief as prior verdicts.*

**$\mathrm{RHS}_{\rm even}$ and $\mathrm{RHS}_{\rm odd}$ appear in the two-sided bound and are defined in no passage**, while $\mathrm{LHS}_{\rm odd}$ is. Brief item 5 asks.

**Two vanishers have mechanisms the argument does not write**: $(I,I,Y)$ is $(n-1)\operatorname{tr}Y=0$, and $(Y,W,W)$ needs $Q(W)$ Weyl, which is Böhm–Wilking's equation (6). *Screened by hand in phase 0; the argument names Xu (3) for the $I$–$W$ pairings only.* Brief item 2 asks for all five without saying which are written.

**The third form types the combinatorial skeleton and an abstract reflection**, `two_sided` over free reals and `omega0_sign_symmetric` for an arbitrary predicate of the norm, so neither touches the curvature objects. Brief item 7 asks whether their hypotheses exclude anything.

## Adjudication

**Verdicts: [v236](VERIFY_v236.md) and [v238](VERIFY_v238.md) `PROVEN, hypotheses corrected`, [v237](VERIFY_v237.md) `PROVEN`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *Every value rebuilt by hand, the $(Y,Y,W)$ coupling checked on a closed-form operator at $n=4$, and the expansion read against Xu (2.34) and Huisken p. 53 at source. The mathematics stands; the statement omitted what the proof uses.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the multiplicities $3$ | need the total symmetry of $T$, Böhm–Wilking eq. (5), which the argument uses and does not cite; a modified $\Phi$ satisfying every cited block fact shifts $(Y,Y,W)$ | v236, v238 (`GAP`); v237 (note) | **confirmed**, cited in the argument, block and canon |
| C2 | $\mathrm{RHS}_{\rm even}$, $\mathrm{RHS}_{\rm odd}$ | defined nowhere in the statements | v238 (`GAP`); v236 (read charitably); phase 0 | **confirmed**, defined at all three sites |
| C3 | "five survive" | fails at $n=3$, where $W\equiv0$ and three survive | v236, v238; v237 (withdrawn) | **confirmed**, $n\ge4$ written in |
| C4 | the constant $\tfrac3{n-2}$ | holds in Böhm–Wilking's normalisation of $\mathrm{Ric}$ and $\wedge$, reads $\tfrac{12}{n-2}$ in Beitz's | v236, v238; v237 (withdrawn) | **confirmed**, normalisation named |
| C5 | "exactly one new coupling" | $(I,Y,Y)$ and $(Y,Y,Y)$ are also absent from the slice; the claim is one new surviving triple containing $W$ | v236, v237, v238 (each read charitably) | **confirmed as wording**, restated |
| C6 | the canon's proof pointer | lands on the block, which carries the statement and no proof | v238 (`REFUTED AS STATED`) | **confirmed**, pointed at the argument |
| C7 | `slice_odd` | its conclusion is its hypothesis | v236, v237, v238 | **confirmed**, deleted |
| C8 | Lean docstrings | still quote the superseded "$1,3,3,6$"; `coupling_split` carries an unused hypothesis | v237, v238 | **confirmed**, refreshed |
| C9 | the block's Gate 2 notes | an annotation stack; one of them says two vanishers have no named mechanism, which v236 and v238 each found in Xu Proposition 2.7 | phase 0; v236 | **confirmed**, the stack replaced by the corrected statement and its text moved to [ATTEMPTS.md](../ATTEMPTS.md) |

**No adjudication pair was spent.** *C1 carries a closed-form object and a citation read at source; C2 to C9 are scope, wording and text facts.*

### Dependents

- **[L43](../findings/problem.md) SURVIVES**: it lives on the slice, $Y=0$, where the new coupling and $\mathrm{RHS}_{\rm odd}$ vanish together, the consistency check the argument records.
- **The Huisken landscape bullet** in [results.md](../results.md) survives, the agreement read at source by all three.

### What was changed

- [target.md](../findings/target.md): the annotation stack replaced by one pointer line; the statement carries $n\ge4$, the symmetry citation, the normalisation, the surviving-triple reading, the definitions of the $\mathrm{RHS}$ parts, and its closing scope sentence.
- [results.md](../results.md): the same at the landscape and detail statements, and the proof pointer aimed at the argument.
- [problem.md](../findings/problem.md): the argument cites Böhm–Wilking eq. (5) and $n\ge4$, and defines the $\mathrm{RHS}$ parts.
- [L45Statement.lean](../lean/HamiltonsCubic/Results/L45Statement.lean) and [lean/INDEX.md](../lean/INDEX.md): `slice_odd` deleted, docstrings and rows refreshed.

### The round's own defects

**Passage A's quoted line range sat directly below the annotation stack**, so two verifiers checking the quotation read prior Gate 2 grading. *Both disclosed it; v236's finding disagrees with those notes, which is the evidence the exposure did not steer it. Deleting the stack removes the exposure for any later round.*
