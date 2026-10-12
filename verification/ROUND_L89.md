# Round L89, the rank of multiplication on invariants

**Id:** L89 · **Date:** 2026-09-14 · **Verifiers:** v302, v303, v304 · **Brief:** [BRIEF_L89.md](BRIEF_L89.md) · **Logs:** `agent_logs/verify-L89-v302.log`, `agent_logs/verify-L89-v303.log`, `agent_logs/verify-L89-v304.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 124, 142-150 |
| the two imported numbers | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 56, 110 |
| the canon | [results.md](../results.md) lines 294 and 976 |
| the Lean files | [L89.lean](../lean/HamiltonsCubic/Results/L89.lean), [InvariantsExact.lean](../lean/HamiltonsCubic/Results/InvariantsExact.lean) |

**Withheld**: the Gate 2 stack under the heading, and every index row.

## The findings from phase 0

**The display's $14$ is Observation L85's and its $65$ is L88's, on Observation L83's table**, and the display names the sampled matrix while the theorem is about the abstract map. Brief items 3 and 8.

## Adjudication

**Verdicts: [v302](VERIFY_v302.md), [v303](VERIFY_v303.md), [v304](VERIFY_v304.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED`.** *Unanimous: the exactness step is a theorem, and its two values are Observations.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | $\mu$ surjective and equivariant | true; no argument in the block, and the Lean `split_exists` splits one coordinate, failing on $x_1\cdots x_6$ | v302 (`CONFIRMED`), v303, v304 (`GAP`) | **settled inline**: the degree-$(3,3)$ monomial split written; the Lean docstring corrected |
| C2 | exactness carrying onto to onto on invariants | the Reynolds operator on compact $O(5)$ | v302, v303, v304 (`CONFIRMED`) | **confirmed**, the one-line averaging written |
| C3 | the values $14$ and $51$ | the $14$ is Observation L85's, the $65$ L88's on Observation L83 | v302, v303, v304 (`HYPOTHESIS-DEBT`) | **narrowed**: the statement gives rank and nullity as dimensions, the values with the Observations' standing |
| C4 | the display "$\mathrm{rank}(A)=14$ exactly" | $A$ is the sampled matrix, rank $0$ at the sample $\{0\}$ | v302, v303, v304 (`REFUTED AS STATED`) | **corrected** to $\mu|_{\mathrm{inv}}$, with $\mathrm{rank}(A)\le$ it |
| C5 | "no sample points are needed ... both are now theorems", "follow without a measurement" | the sampled check is not retired, and the values are measured | v302, v303, v304 (`REFUTED AS STATED`) | **removed** |
| C6 | the section heading's "open question on the restricted one" | "restricted" undefined under that heading | v302, v303, v304 (`GAP`) | **replaced** |
| C7 | the canon's "the route consumes $13$ rather than $14$" | neither the domain nor the $13$ defined or argued in the passages | v302, v303, v304 (`HYPOTHESIS-DEBT`) | **removed** from L89's canon; it belongs to L90 and L91, queued next |
| C8 | the Lean files | neither states the lemma; `invariant_lift` proves the abstract step | v302, v303, v304 | **recorded** |

**No adjudication pair was spent.**

### Dependents

- **L90** reads the rank on the restricted space and the cap from L62. **SURVIVES**: it uses the evaluation inequality, which the block now states.

**Impact `CONTAINED`.**
