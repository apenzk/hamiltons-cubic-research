# Review r1577: L119's gain cap (commit 12e03673) and r1574's repairs (commit 18f0ca49)

Log: agent_logs/r1577.log

**Standfirst.** [L119Gain.lean](../lean/HamiltonsCubic/Results/L119Gain.lean) is correct and each of its three theorems states what the record's sentence says, in the record's normalisation: `p_nonempty` is "tracelessness keeps 𝔭 non-empty", `dim_p_mul_sq_le` is dim 𝔭 (λ^min_𝔭)² ≤ 1 with λ^min_𝔭 entering as any non-negative lower bound on the positive eigenvalues, and `gain_le` is the cap Δ/(4√d) on μΔ/4. The three are separate statements over free reals: no theorem in the repository puts them together on λ^min_𝔭 = inf over `L119.pp`, which is what the L119 row calls "the gain". A scratch file composes them in ten lines, so the gap is one of wording, and the move of both clauses to proved stands. [max_le_one_exact](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L143) is the composed chain r1574 asked for, with exactly the record's hypotheses, and it closes r1574's gap 2. Gaps 1 and 3 are also closed. Everything builds on the standard three axioms.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `p_nonempty`: Σλ = 0 and Σλ² = 1 give some λ_g > 0, so 𝔭 ≠ ∅ | **CONFIRMED** |
| A-1b | `dim_p_mul_sq_le`: \|𝔭\| μ² ≤ 1 for every μ ≥ 0 bounding the positive eigenvalues below, λ^min_𝔭 among them | **CONFIRMED** |
| A-1c | `gain_le`: μΔ/4 ≤ Δ/(4√d) for d > 0, Δ ≥ 0, dμ² ≤ 1 | **CONFIRMED** |
| A-1d | normalisation Σλ² = 1 over the Λ² spectrum, 𝔭 the strictly positive eigenspace, gain λ^min_𝔭 Δ/4 the gap between the two bounds | **CONFIRMED** |
| A-1e | L119 row: "the gain cap and the non-emptiness of 𝔭 are PROVED" | **CONFIRMED WITH GAP** (the cap is typed as three pieces over free reals, and the composition on λ^min_𝔭 is unwritten) |
| A-2a | r1574 gap 1: the L119 row's untyped list | **CONFIRMED** (closed, then superseded by L119Gain) |
| A-2b | r1574 gap 2: `max_le_one_exact`, m ≤ 1 at 0 < sin φ ≤ s* | **CONFIRMED** |
| A-2c | r1574 gap 3: the L56 semicolon splice | **CONFIRMED** |
| B | builds, standard three only, no sorry, admit or native_decide | **CONFIRMED** |
| C | downstream text consistent with the changes | **CONFIRMED** |
| D | style of the markdown edits | **CONFIRMED** |

**Summary:** the Lean is right and faithful, and the one gap is that the row names `gain_le` as the gain cap on λ^min_𝔭 while the typed statement is about free reals d and μ.

## 1. L119's gain cap and the non-emptiness of 𝔭

Files carrying the id: [L119.lean](../lean/HamiltonsCubic/Results/L119.lean), [L119C5.lean](../lean/HamiltonsCubic/Results/L119C5.lean), [L119Gain.lean](../lean/HamiltonsCubic/Results/L119Gain.lean), [L119Statement.lean](../lean/HamiltonsCubic/Results/L119Statement.lean). Rows: [lean/INDEX.md:471](../lean/INDEX.md#L471) and [:472](../lean/INDEX.md#L472). The record: [bounds-relaxations.md:329](../findings/bounds-relaxations.md#L329).

- **Normalisation.** The record's bound is θ ≤ [\|λ_min\| M − λ^min_𝔭 Δ]/4 at unit W, with λ the eigenvalues of W on Λ², summed over the orthonormal bivector basis, so Σλ² = ‖W‖² = 1, and Σλ = 0 since W is traceless on Λ². This is the normalisation L119C5 uses (180c² = 1 over the 45 unordered pairs), and it is the one L119Gain takes as `hn` and `htr`.
- **`p_nonempty`.** If every λ_g ≤ 0 and Σλ = 0 then every λ_g = 0, contradicting Σλ² = 1. The proof is exactly this: a strictly negative entry forces Σλ ≤ λ_g < 0. The conclusion ∃ g, 0 < λ_g is 𝔭 ≠ ∅ with 𝔭 the strictly positive eigenspace, as the record defines it. Correct.
- **`dim_p_mul_sq_le`.** \|𝔭\| μ² = Σ_{𝔭} μ² ≤ Σ_{𝔭} λ² ≤ Σ λ² = 1, using μ ≥ 0 for monotonicity of the square. Taking μ as a free lower bound is a generalisation: λ^min_𝔭 = inf' over 𝔭 satisfies both hypotheses (`Finset.inf'_le` and `inf_pos_of_nonempty`). Correct.
- **`gain_le`.** dμ² ≤ 1 with d > 0 gives μ ≤ 1/√d (the `nlinarith` step covers μ ≤ 0 trivially and μ > 0 by (μ√d)² ≤ 1), and multiplying by Δ/4 ≥ 0 gives the cap. Correct.
- **The gain.** The two bounds are \|λ_min\| M/4 and [\|λ_min\| M − λ^min_𝔭 Δ]/4, so their gap is λ^min_𝔭 Δ/4, which is `gain_le`'s left side. The record's own sentence gives the gap as λ^min_𝔭 Δ at the 4θ scale and the cap Δ/(4√dim 𝔭) at the θ scale. The Lean reads both at the θ scale, which is the consistent reading, and nothing in the record is contradicted.
- **Gap 1.** The row at [lean/INDEX.md:471](../lean/INDEX.md#L471) describes `gain_le` as *"the gain λ^min_𝔭 Δ/4 ≤ Δ/(4√dim 𝔭)"*. `gain_le` is stated for free reals d, μ, Δ, and no theorem instantiates it at d = \|`L119.pp` λ\| and μ = (`L119.pp` λ).inf' λ, discharging d > 0 from `p_nonempty` and dμ² ≤ 1 from `dim_p_mul_sq_le`. This is the pattern r1574's gap 2 named for L20. **Screen, not evidence:** a scratch file importing L119Gain and L119Statement, outside the repository, proves in ten lines that under Σλ = 0 and Σλ² = 1 there is h : (pp λ).Nonempty with 0 < inf' h λ and inf' h λ · Δ/4 ≤ Δ/(4√\|pp λ\|) for Δ ≥ 0, and it elaborates with no error. So the pieces fit, and the repair is either that theorem in L119Gain or row text saying the cap is typed as its three ingredients.
- **Observation.** [L119Statement.lean:191](../lean/HamiltonsCubic/Results/L119Statement.lean#L191) still says in a docstring that tracelessness supplies nonemptiness, with no pointer. It is now true of the repository through `p_nonempty`, and a reference there would connect the two files.

## 2. r1574's repairs

- **Gap 1 of r1574.** 18f0ca49 named the gain cap and 𝔭-nonemptiness as untyped in the L119 row, and 12e03673 then replaced that list with L119Gain. The row now lists L119Gain among its files and its untyped list holds only the catalogue clause, which the record's own Gate 2 block refutes. Closed, up to gap 1 above.
- **Gap 2 of r1574, `max_le_one_exact`.** The hypotheses are cos φ ≥ 0, 0 < sin φ ≤ s*, the exact cubic expansion m = cos³φ + 3 cos φ sin²φ α + sin³φ γ, α ≤ 1/3 and γ ≤ m, which are route-a.md's L20 hypotheses on φ ∈ (0, arcsin s*]. The proof runs in four steps. First, sin φ < 1 from s* < 1 (`sStar_spec`). Second, cos φ = √(1 − sin²φ) from `Real.cos_sq'` and cos φ ≥ 0, so `psi_le_one_iff` gives cos φ + sin³φ ≤ 1. Third, `expansion_step` gives m ≤ cos φ + m sin³φ. Fourth, if m > 1 then (m − 1)(1 − sin³φ) > 0 gives m − m sin³φ > 1 − sin³φ ≥ cos φ, contradicting the step. That is the chain at the exact radius. The row at [lean/INDEX.md:329](../lean/INDEX.md#L329) now says `max_le_one_exact` runs it, and the docstring at [L20Arcsin.lean:110](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L110), *"so the tube argument closes"*, is now backed. The excluded endpoint sin φ = 0 is φ = 0, where m = cos³ 0 = 1 directly, and the record's interval is (0, arcsin s*] anyway. Closed.
- **Gap 3 of r1574.** The L56 parenthetical now reads *"(a definition whose row sums vanish by `multi_rowSum_zero`, the weights themselves being the multi-block form of the owed vertex-entry mechanism)"*, one sentence. Closed.

## 3. Soundness

- `lake build HamiltonsCubic.Results.L119Gain HamiltonsCubic.Results.L20Arcsin`: completed, 8708 jobs, warnings only (a deprecated `push_neg` in L20Statement and a multi-goal linter at [L20Arcsin.lean:130](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L130), both pre-existing).
- `axiom_audit.py --only L119Gain.lean`: 3/3. `--only L20Arcsin.lean`: 9/9. Each on `propext`, `Classical.choice`, `Quot.sound` alone.
- No `sorry`, `admit` or `native_decide` in either file. L119Gain is imported by [HamiltonsCubic.lean:348](../lean/HamiltonsCubic.lean#L348).

## 4. Downstream

- [INDEX-results.md:135](../findings/INDEX-results.md#L135), row 119, reads Lean: proved, which the two L119 rows support. Row 20 is unchanged and consistent.
- [route-a.md:119](../findings/route-a.md#L119) states the exact reduction `psi_le_one_iff` proves and the chain `max_le_one_exact` now runs. The L20 statement row at [lean/INDEX.md:330](../lean/INDEX.md#L330) states the 0.54368 numeric correctly as a separate fact.
- [bounds-relaxations.md](../findings/bounds-relaxations.md) is unchanged by these commits and nothing in it contradicts the Lean. STATUS.md and plan-lean.md change only in the file count, 839 to 840, matching one new file.

## 5. Style

- No em dash and no backticks inside link text in any added line, and every table row is one line.
- No clause splice in the added text. The L119 row carries an older one, *"so scaling defeats it; `L119_every` states it in P"*, which predates both commits.

## Verdict

**CONFIRMED WITH GAPS.** The three L119Gain theorems are correct and faithful to the record's clauses in its normalisation, `max_le_one_exact` composes the L20 chain at s* with the record's hypotheses, r1574's three gaps are closed, and both files rest on the standard three axioms. One gap, text:

1. lean/INDEX.md:471: the row calls `gain_le` *"the gain λ^min_𝔭 Δ/4 ≤ Δ/(4√dim 𝔭)"*, but `gain_le` (L119Gain.lean:54) is stated over free reals, and no theorem instantiates it on λ^min_𝔭 = inf over `L119.pp` with `p_nonempty` and `dim_p_mul_sq_le`. A ten-line composition closes in a scratch screen.
