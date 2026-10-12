# Round L65, the seed is a diagram, under admissibility

**Id:** L65 · **Date:** 2026-09-14 · **Verifiers:** v268, v269, v270 · **Brief:** [BRIEF_L65.md](BRIEF_L65.md) · **Logs:** `agent_logs/verify-L65-v268.log`, `agent_logs/verify-L65-v269.log`, `agent_logs/verify-L65-v270.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the numbered block | [findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 112-116 |
| the argument | [findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 86-98 |
| the realisation theorem | [findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 40-50 |
| the block count | [findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 1-13 |
| the canon | [results.md](../results.md) lines 226 and 771 |
| the Lean files | [L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean), [L65.lean](../lean/HamiltonsCubic/Results/L65.lean) |

**Withheld**: lines 51-84 and 100-111 of the findings file, which carry reviewer verdicts, numerical verification and the open obligations, and every index row. *[L65.lean](../lean/HamiltonsCubic/Results/L65.lean) line 25 says "as the audit says" of dimension-freeness, a mild signal left in place because the file is quoted whole.*

## The findings from phase 0

**The block's pointer names the realisation theorem's section, and the argument is in the next section**, whose opening says the realisation theorem says nothing about where a seed comes from. Brief item 1.

**The canon calls the seed a composite and the argument writes a tensor product**, and the heading's "diagram" meets the argument's own remark that at $\lvert\lambda\rvert=12$ there is no cup. Brief items 2 and 7.

**Admissibility is called load-bearing, and $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert\le12$ makes it automatic at $n\ge12$.** Brief item 6.

## Adjudication

**Verdicts: [v268](VERIFY_v268.md), [v269](VERIFY_v269.md), [v270](VERIFY_v270.md) all `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *Unanimous: the construction is right at every $n\ge1$ for every admissible label with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, and the pointer, the heading and the counts around it were wrong or unargued.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | the block's pointer to "The diagram-realisation theorem, one seed per block" | that section proves the realisation theorem and the argument is in the next section | v268, v269, v270 (`REFUTED AS STATED`) | **confirmed**, pointer replaced |
| C2 | $k=(12-\lvert\lambda\rvert)/2$ | no stated hypothesis makes $k$ a nonnegative integer, $\lambda=(1)$ giving $k=\tfrac{11}2$ | v268, v269, v270 | **confirmed**, $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ written in |
| C3 | nonvanishing at small $n$ | at $n=0$, $\mathrm{cup}$ is the empty sum and $c_0=0$ at $\lambda=\varnothing$ | v268, v269 (hypothesis), v270 (hypothesis, the counterexample withdrawn as outside the programme) | **confirmed**, $n\ge1$ written in |
| C4 | equivariance for the full $O(n)$ | $gg^{\mathsf T}=I$ | v268, v269, v270 (`CONFIRMED`) | **confirmed**, the one line written into the proof |
| C5 | nonvanishing by nonzero tensor factors | direct | v268, v269, v270 (`CONFIRMED`) | **confirmed** |
| C6 | "the cap computation returning $n^k\iota_\lambda$" | stated with no derivation, and cap undefined | v268 (`HYPOTHESIS-DEBT`), v269, v270 (`CONFIRMED AS ALGEBRA`) | **split, settled inline**: one cup contracts to $\sum_a\langle e_a,e_a\rangle=n$, so $k$ contractions return $n^k\iota_\lambda$, written into the proof |
| C7 | "Without admissibility $V_\lambda=0$ and $\iota_\lambda$ does not exist" | the two clauses name different failures | v268 (`CONFIRMED AS ALGEBRA`), v269 and v270 (withdrawn as wording) | **rewritten**: Weyl's construction gives the zero space and no nonzero seed exists |
| C8 | "At $n=12$ it holds for all $71$ blocks", tightness at $(2^6)$ | $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ for every partition, so the count is unused and $(2^6)$'s membership among blocks is unargued | v268, v269, v270 | **confirmed**, replaced by the partition bound, tightness stated for the label |
| C9 | "the seed is a diagram" | the seed is $\iota_\lambda$ followed by cups, a diagram only at $\lambda=\varnothing$, and $\iota_\lambda$ itself at $\lvert\lambda\rvert=12$ | v268, v269, v270 (`REFUTED AS STATED`) | **confirmed**, renamed "the seed is the inclusion padded by cups" |
| C10 | the counts $16$ and $17$ of $184$ in the argument | census values with no argument, unused | v268, v269, v270 (`HYPOTHESIS-DEBT`) | **removed** from the section. *The same counts in the file's opening statement belong to the pairing theorem and are outside this round* |
| C11 | "no search", "in closed form" | rests on Weyl's construction of $\iota_\lambda$, unfiled | v269 | **stated** in the section as a classical import |
| C12 | the canon's statement | omits "equivariant" and "nonzero" | v269 | **restated** |
| C13 | the Lean files | abstract ingredients only, the seed never constructed, and [L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean)'s "verbatim" quote drifted | v268, v269, v270 (`REFUTED AS STATED`) | **repaired**: quotes and headings updated, the `hcap` docstring states the derivation, the statement row set to not typed and filed under *out* with its binders |

**No adjudication pair was spent.** *Every finding is unanimous except C6, a split on whether a one-line contraction is on file, which the loop settles by writing the line.*

### Withdrawn

- **v268 and v270: $\lambda=(1)$ and $\lambda=(1^{14})$ give no whole $k$.** Withdrawn as counterexamples, since neither is a block, and kept as the hypothesis of C2.
- **v268, v270: `seed_ne_zero`'s type does not fit the record's maps.** Withdrawn, composing with a projection making it apply.
- **v270: the Lean docstring overstates the tensor-closure theorem.** Withdrawn on the charitable reading.

### Dependents

- **The realisation theorem** needs one nonzero element of $M_\lambda$ per block. **SURVIVES**: every block has $\lvert\lambda\rvert$ even and at most $12$, and $n\ge1$.
- **The report's Lemma 65**, a copy of the block's statement. **Corrected** in [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex). *The PDF is not rebuilt, which the next report update owes.*
- **No other citation of L65 by number or by its heading exists** in [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md) or [routes.md](../routes.md).

**Impact `CONTAINED`**: both added hypotheses hold at every use.

### What changed

- [brauer-pairing.md](../findings/brauer-pairing.md): the section renamed and rewritten with the full hypotheses, the partition bound, the proof with both nonvanishing arguments, and the seed's correct description. The block restated with its pointer.
- [results.md](../results.md) and [INDEX-results.md](../findings/INDEX-results.md): restated and renamed.
- [L65.lean](../lean/HamiltonsCubic/Results/L65.lean), [L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean), [lean/INDEX.md](../lean/INDEX.md): docstrings and rows as in C13.
- [ATTEMPTS.md](../ATTEMPTS.md): the removed section, block and canon, quoted.
