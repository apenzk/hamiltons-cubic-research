# Round L65-r2, the repair audit of the seed construction

**Id:** L65-r2 · **Date:** 2026-09-14 · **Verifiers:** v396, v397, v398 · **Brief:** [BRIEF_L65r2.md](BRIEF_L65r2.md) · **Logs:** `agent_logs/verify-L65-v396.log`, `agent_logs/verify-L65-v397.log`, `agent_logs/verify-L65-v398.log`

**Why this round.** [ROUND_L65](ROUND_L65.md) renamed and rewrote the section carrying the argument, with the full hypotheses, the partition bound, the proof with both nonvanishing arguments and the seed's description, and restated the block and the canon. That text is new and re-enters unchecked, so L65 is audited again whole.

## Sources, verbatim

| passage | source |
| --- | --- |
| the section carrying the argument | [findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 86-98 |
| the block | [findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 112, 116 |
| the canon | [results.md](../results.md) lines 229, 800, 802 |
| the Lean files | [L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean), [L65.lean](../lean/HamiltonsCubic/Results/L65.lean), declarations only |

**Withheld**: the provenance line at line 114, the section's *Verification* and *What stays open* subsections, the realisation theorem's section, every prior round file, the Lean docstrings, and every index row.

## The findings from phase 0

**Weyl's construction enters as "classical, unfiled".** The proof takes from it the realisation of $V_\lambda$ as traceless tensors, an injective equivariant $\iota_\lambda$, and $V_\lambda\ne0$ for admissible $\lambda$, with no source in [references/](../references/). Brief item 2.

**The Lean statement is not typed.** [lean/INDEX.md](../lean/INDEX.md) files the lemma under *out* with its binders. L65Statement.lean types the equivariance and nonvanishing mechanisms over abstract maps, and L65.lean the admissibility arithmetic. Brief item 10.

**Index row 65 in [INDEX-results.md](../findings/INDEX-results.md) still carries the Gate 2 commentary the last round's repairs answered**, a false pointer and a false "diagram" among it. It is corrected at the fold, whatever the verdict.

## Phase 2, clustering

**Verdicts: [v396](VERIFY_v396.md), [v397](VERIFY_v397.md), [v398](VERIFY_v398.md) all `PROVEN`.** *All three confirm the invariance of $\mathrm{cup}$ from $gg^{\mathsf T}=I$, equivariance slot by slot, nonvanishing by the tensor product and by the contraction to $n^k\iota_\lambda$, the partition bound with its witnesses and the equality at $(2^6)$, the realisation theorem's one stated requirement, and every boundary case, with $n\ge1$ load-bearing exactly at $\lambda=\varnothing$. Weyl's construction enters as a classical theorem named without a reference, and its "only if" half is unused.*

| id | step attacked | mechanism | support | route |
| --- | --- | --- | --- | --- |
| J1 | "given in closed form and need not be searched for" in the block, "constructed rather than searched for" in the canon | both drop Passage A's "relative to $\iota_\lambda$", and at $\lvert\lambda\rvert=12$ the seed is $\iota_\lambda$ itself, whose explicit form no passage gives | v396, v397, v398 (`HYPOTHESIS-DEBT`) | **phase 3**, [ADJ_L65r2_J1.md](ADJ_L65r2_J1.md) |
| J2 | `seed_ne_zero` in L65Statement.lean | it types $\iota$ as a map from `Vlam` to itself, while the section's $\iota_\lambda$ maps $V_\lambda$ into $V^{\otimes\lvert\lambda\rvert}$, so the contraction identity is not an instance | v396, v397, v398 | **check 1c**, a Lean pass in this round, the kernel deciding it |
| J3 | `leg_count` and `diagram_failure_share` in L65.lean | no counterpart in any passage | v396, v398 | **check 1**, no adjudication |

**Withdrawn by their verifiers:** the proof paragraph not naming $V_\lambda\ne0$, which the paragraph before it supplies (all three), "the inclusion" being non-unique, the lemma holding for every choice (v396, v398), equality in the partition bound at labels other than $(2^6)$, where no uniqueness is claimed (v398), and nine candidates of v397's, each read correctly in context.

**Check 1, the brief against the source.** Every passage was copied off disk by line with its first words asserted. **J3 is brief-induced**: `leg_count` formalises [lean/INDEX.md](../lean/INDEX.md)'s row for L65.lean, where the $12$ is checked as a leg count $3\cdot4$, and `diagram_failure_share` the count of $16$ blocks among $71$ carried by index row 65 and the report's certificate after Lemma 65. Neither text was quoted in the brief.

**Check 2, the whole record.** No explicit $\iota_\lambda$ is written anywhere in [findings/](../findings/), [results.md](../results.md), [report/](../report/) or [ATTEMPTS.md](../ATTEMPTS.md). **Copies of the statement**: the report's Lemma 65 at [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 953, "so the seed need not be searched for", and [findings/INDEX.md](../findings/INDEX.md) line 42, "so no block needs a search". The report's certificate after Lemma 65 still calls the padding-diagram description wrong at $16$ of $71$ blocks, which the lemma no longer asserts.

## Phase 3, adjudication

**Two fresh verifiers on J1, asked the step neutrally:** v399 and v400.

| id | adjudicators | outcome |
| --- | --- | --- |
| J1 | [v399](VERIFY_v399.md) `VALID`, [v400](VERIFY_v400.md) `VALID` | **withdrawn** |
| J2 | the kernel | **repaired**, `seed_ne_zero` retyped, commit 0562621f |
| J3 | check 1 | **brief-induced**, no change |

**The defence of J1.** Passage A fixes $V_\lambda$ as Weyl's subspace of $V^{\otimes\lvert\lambda\rvert}$ of traceless tensors of symmetry type $\lambda$, so $\iota_\lambda$ is the inclusion of that subspace and $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is an explicit formula for every admissible label. "Search" in Passage A means hunting for a nonzero element of $M_\lambda$, and none is needed. Choosing a Young symmetriser fixes the copy and is not a search. At $\lvert\lambda\rvert=12$ the lemma's content is Weyl's construction itself, which the section already says. Both adjudicators name Weyl's theorem for $O(n)$ as the standard input, recalled as Fulton and Harris Theorem 19.19. That citation was not read at source, so it does not enter the record.

**J2.** `seed_ne_zero` took `iota : Vlam →ₗ Vlam` and `cap : T →ₗ Vlam`, while the section's $\iota_\lambda$ maps $V_\lambda$ into $V^{\otimes\lvert\lambda\rvert}$ and the cap contraction lands there too. It now takes a third module `U`, with `iota : Vlam →ₗ U` and `cap : T →ₗ U`. The file builds, and the axioms are `propext`, `Classical.choice`, `Quot.sound`.

## Phase 4, dependents

**No confirmed defect in the mathematics**, so no dependent loses support. The copies found in phase 2 carry the statement as the section does: the report's Lemma 65, [findings/INDEX.md](../findings/INDEX.md) line 42, and [results.md](../results.md) lines 229 and 802. **Impact: none.**

## Phase 5, what was changed

**Verdict: `PROVEN`.**

- [L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean): `seed_ne_zero` retyped, with its docstring naming the three spaces.
- [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex): the certificate after Lemma 65 called the padding-diagram description wrong at $16$ of $71$ blocks, a description the lemma no longer makes. It now says those are the blocks with $\lvert\lambda\rvert=12$, where the seed is $\iota_\lambda$ with no cups. The report was rebuilt.
- [INDEX-results.md](../findings/INDEX-results.md) row 65: the stale Gate 2 commentary replaced by the verdict.
- [ATTEMPTS.md](../ATTEMPTS.md): the round's account and the replaced passages.

**No new mathematics entered**, so L65 leaves *To check*.

## Phase 6

L65's box is deleted from *To check* and one line goes under *Checked*. The next id is L66.
