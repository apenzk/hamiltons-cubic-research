# Round L88, the unknown count is real symmetric, and the 24 are gauge

**Id:** L88 · **Date:** 2026-09-14 · **Verifiers:** v299, v300, v301 · **Brief:** [BRIEF_L88.md](BRIEF_L88.md) · **Logs:** `agent_logs/verify-L88-v299.log`, `agent_logs/verify-L88-v300.log`, `agent_logs/verify-L88-v301.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 106, 120-130 |
| the block table, given | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36 |

**Withheld**: the Gate 2 stack under the heading, every index row, and both Lean files, whose docstrings quote prior verdicts.

## The findings from phase 0

**No [results.md](../results.md) entry exists for L88**, and its three dimensions are sums over Observation L83's multiplicities. Brief items 1 and 6.

## Adjudication

**Verdicts: [v299](VERIFY_v299.md), [v300](VERIFY_v300.md), [v301](VERIFY_v301.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED`.** *Unanimous on every cluster.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | $\dim\mathrm{Sym}^2(U)^{O(5)}=65$, $\dim\Lambda^2(U)^{O(5)}=24$ | a script, and multiplicities with no derivation; the Schur step from forms to $\sum\binom{m\pm1}2$ unwritten | v299, v300, v301 (`HYPOTHESIS-DEBT`) | **narrowed**: the Schur step written, the counts stated on Observation L83's multiplicities |
| C2 | the three sums over the table | exact | v299, v300, v301 (`CONFIRMED AS ALGEBRA`) | **confirmed** |
| C3 | $65+24=89$ as a check | termwise identity, true for any list | v299, v300, v301 | **stated** as checking nothing |
| C4 | every block of real type | classical; the passage's "integral" excludes quaternionic type only, complex type needing self-duality | v299, v300 (`CONFIRMED`), v301 (the self-duality step missing) | **settled inline**: self-duality from $-1\in W(B_2)$ written |
| C5 | "so the $24$ ... are of $\Lambda^2$ ... gauge" | inferred from a dimension match; the step owed is the $S+iA$ splitting of an invariant Hermitian form | v299, v300 (`GAP`), v301 (`CONFIRMED`) | **settled inline**: the splitting written; gauge scoped to the Gram-to-sextic map, with $I+2iJ$ showing it fails in the PSD cone |
| C6 | "the kernel direction is the imaginary coordinate iff $\operatorname{Im}h=0$" | $Q=\mathrm{diag}(1,i)$ gives $h=I$ with a real symmetric kernel direction | v299, v300, v301 (`REFUTED AS STATED`) | **corrected** to "only if" |
| C7 | the measured $h$, "$4000$ bases", $0.541$ | sampled measurements | v299, v300, v301 (`HYPOTHESIS-DEBT`) | **kept** as measurements, labelled so in place |
| C8 | no [results.md](../results.md) entry | phase 0 | round | **added** |

**No adjudication pair was spent.**

### Withdrawn

- **v300, v301, v299: gauge inside the PSD cone.** The passage made no cone claim; the block now states the limit.
- **v299: "integral" read in the Lie-theoretic sense.** The block now names the $e$-basis coordinates.
- **v300: $O(5)$ against $SO(5)$ counts.** $-I$ acts trivially, so they agree.

### Dependents

- **L89**, whose nullity $51=65-14$ reads the $65$. **NARROWED**, on Observation L83's multiplicities; its round is next.

**Impact `CONTAINED`**: the counts are unchanged and their standing was already L83's.
