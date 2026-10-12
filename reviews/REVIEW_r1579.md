# Review r1579: L52's conditions on S² against S²₀ (commit 30b0cdcf) and L119's gain cap at the spectrum (commit 2221fe5c)

Log: agent_logs/r1579.log

**Standfirst.** Both Lean additions are correct and build on the standard three axioms. [L52S20.lean](../lean/HamiltonsCubic/Results/L52S20.lean)'s `omega_lower_iff` states exactly that, at a Ricci-flat R, every eigenvalue of W̊ on S² is at least −m if and only if every eigenvalue of the restriction of `Bw w (ringW R)` to (ℝ∙`gCoord w`)^⊥ is at least −m and 0 ≥ −m. [L119Gain.lean](../lean/HamiltonsCubic/Results/L119Gain.lean)'s `gain_cap` composes `p_nonempty`, `dim_p_mul_sq_le` and `gain_le` at 𝔭 = {λ > 0} with λ^min_𝔭 its `inf'`, which is the record's cap Δ/(4√dim 𝔭) and closes r1577's gap. The text around the L52 addition carries a sign error: it calls the layer's ψ-diagonal "the record's K′ negated", while `dpsi_split` proves it is minus the spectrum of K on 𝟏^⊥, which is the record's K′ ψ-block itself with no negation. The L52 owed list also leaves out that the pieces are not composed into one statement at the record's S²₀, and that 0 ≥ −m rests on a Σω = 0 the row cites to the record while the layer's `sum_omega_zero` is never connected to it.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `omega_lower_iff`: ω ≥ −m on S² iff ω ≥ −m on S²₀ and 0 ≥ −m, S²₀ the restriction of `Bw w (ringW R)` to (ℝ∙`gCoord w`)^⊥ | **CONFIRMED** |
| A-1b | L52 row and L52S20 docstring: at an eigenbasis of K "the diagonal is the record's K′ negated with one extra 0" | **REFUTED AS WORDED** (the multiset is minus spec(K\|𝟏^⊥) plus 0, which is the record's K′ ψ-block plus 0, unnegated, while the substance of `dpsi_split` as K′'s passage stands) |
| A-1c | L52 owed list is now the equality clause's two halves and nothing else | **CONFIRMED WITH GAP** (the composition at S²₀ and the discharge of 0 ≥ −m are untyped and unlisted) |
| A-2a | `gain_cap`: with 𝔭 = {λ > 0} non-empty and λ^min_𝔭 = inf' over 𝔭, λ^min_𝔭 Δ/4 ≤ Δ/(4√\|𝔭\|) for Δ ≥ 0 | **CONFIRMED** |
| A-2b | r1577 gap 1 closed | **CONFIRMED** |
| B | builds, standard three only, no sorry, admit or native_decide | **CONFIRMED** |
| C | downstream text consistent with the changes | **CONFIRMED WITH GAP** (the L52 row's sign wording contradicts the L54 row's correct reading of the same theorem) |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (a dropped comma in the L119 row's list) |

**Summary:** the Lean is right and faithful on both commits, and the gaps are text: a spurious "negated" in the L52 row and L52S20's docstring, an owed list that omits the composition at S²₀ and the discharge of 0 ≥ −m, and a missing comma in the L119 row.

## 1. L52's condition on S² against S²₀

Files carrying the id: [L52.lean](../lean/HamiltonsCubic/Results/L52.lean), [L52Bound.lean](../lean/HamiltonsCubic/Results/L52Bound.lean), [L52Frame.lean](../lean/HamiltonsCubic/Results/L52Frame.lean), [L52S20.lean](../lean/HamiltonsCubic/Results/L52S20.lean), [L52Statement.lean](../lean/HamiltonsCubic/Results/L52Statement.lean). Rows: [lean/INDEX.md:377](../lean/INDEX.md#L377) (L52) and [lean/INDEX.md:378](../lean/INDEX.md#L378) (L52 statement). The L54 files read for the passage: [L54Spectrum.lean](../lean/HamiltonsCubic/Results/L54Spectrum.lean) and [L54Diag.lean](../lean/HamiltonsCubic/Results/L54Diag.lean).

- **The record's hypothesis.** [bispectral.md:69](../findings/bispectral.md#L69) takes ω the spectrum of W̊ on S²₀, with ω_i ≥ −m and Σω² = 3, and K′ the W̊ diagonal in the basis {φ_ij} ∪ {ψ_k}, the ψ_k an eigenbasis of K on 𝟏^⊥. The layer's `L52_record` ([L52Frame.lean:257](../lean/HamiltonsCubic/Results/L52Frame.lean#L257)) takes ω ≥ −m on the S² spectrum of `Bw w (ringW R)` and K′ the full S² diagonal for any complete family w.
- **`omega_lower_iff`.** The statement fixes T = `toEuclideanLin (Bw w (ringW R))`, g′ = `gCoord w`, and asserts the existence of an invariance proof hW for (ℝ∙g′)^⊥ together with the equivalence (∀u, −m ≤ λ_u(T)) ↔ ((∀i, −m ≤ λ_i(T\|(ℝ∙g′)^⊥)) ∧ −m ≤ 0). The existential over a proof term is harmless: by proof irrelevance every hW gives the same restriction. The proof reads `ringW_spectrum_split` ([L54Spectrum.lean:186](../lean/HamiltonsCubic/Results/L54Spectrum.lean#L186)), whose multiset identity spec_S² = 0 ::ₘ spec_S²₀ is exactly what makes the two sides equivalent, and runs each direction by `Multiset.mem_cons` and `Multiset.mem_map`. The hypotheses (0 < n, Ric = 0) are those of the split and hold at a Weyl R. Correct, and it states what the brief asks.
- **`dpsi_split` as the K′ passage.** [L54Diag.lean:48](../lean/HamiltonsCubic/Results/L54Diag.lean#L48) proves that the multiset of the layer's ψ-diagonal at Mathlib's eigenbasis `wK` of K on ℝⁿ equals 0 ::ₘ (−κ_i), κ the spectrum of K restricted to 𝟏^⊥. The record's own derivation ([bispectral.md:495](../findings/bispectral.md#L495)) gives ⟨W̊ψ_k, ψ_k⟩ = −κ_k, so the record's K′ ψ-block **is** {−κ_k}. The φ-block is `Bw_diag_pair` in any frame. So the layer's full diagonal at `wK` is the record's K′ with one extra 0, and since 0 contributes nothing to p₂ or p₃, `L52_record` at `wK` carries the record's display. In substance the row's claim that `dpsi_split` is L52's K′ passage is accurate.
- **The sign wording.** The row says *"at w an eigenbasis of K the diagonal is the record's K′ negated with one extra 0"* ([lean/INDEX.md:377](../lean/INDEX.md#L377)), and the file's docstring says *"the ψ-diagonal is the record's K′ on 𝟏^⊥ negated with one extra 0"* ([L52S20.lean:13](../lean/HamiltonsCubic/Results/L52S20.lean#L13)). Both are wrong as worded: what is negated is the spectrum of **K** on 𝟏^⊥, and the result is the record's K′ (ψ-block) unnegated. The row's version is further off, since it covers "the diagonal", whose φ-block is K_ab with a plus sign. The L54 row reads the same theorem correctly ([lean/INDEX.md:283](../lean/INDEX.md#L283): *"minus the eigenvalues of K on 𝟏^⊥, which is the record's d_ψ"*), so the two rows now disagree. The previous owed text, *"the diagonal is the record's K′ with one extra 0"*, was right, and this commit introduced "negated".
- **The owed list.** The row now owes only the equality clause's "if" half (the ψ stipulation) and "only if" half (Karamata), and both are still owed. Two things the row counts as done are pieces rather than a statement. First, no theorem composes `L52_record` at `wK` with `dpsi_split` and `omega_lower_iff` into the record's display at S²₀. That is the same pattern r1577's gap 1 named for L119, and it is what the second commit here repaired for L119. Second, the conjunct 0 ≥ −m is discharged in the row by *"the record's Σω = 0"*. The layer does prove Σω = 0 at a Ricci-flat R, as `sum_omega_zero` ([L50Traces.lean:68](../lean/HamiltonsCubic/Results/L50Traces.lean#L68)), but for `Bmat` rather than `Bw w`, and with the split it would give 0 ≥ −m from the S²₀ condition. Nothing connects the two, and the row cites the record rather than the theorem. Neither is a false claim. Each is an untyped step missing from an owed list that now reads as though only the equality clause remains.

## 2. L119's gain cap at the spectrum

Files carrying the id: [L119.lean](../lean/HamiltonsCubic/Results/L119.lean), [L119C5.lean](../lean/HamiltonsCubic/Results/L119C5.lean), [L119Gain.lean](../lean/HamiltonsCubic/Results/L119Gain.lean), [L119Statement.lean](../lean/HamiltonsCubic/Results/L119Statement.lean). Rows: [lean/INDEX.md:472](../lean/INDEX.md#L472) (L119) and [lean/INDEX.md:473](../lean/INDEX.md#L473) (L119 statement).

- **`gain_cap`** ([L119Gain.lean:67](../lean/HamiltonsCubic/Results/L119Gain.lean#L67)). Hypotheses Σλ = 0, Σλ² = 1, Δ ≥ 0. Conclusion: there is hP, a proof that 𝔭 = `univ.filter (0 < λ ·)` is non-empty, with (𝔭.inf′ hP λ) · Δ/4 ≤ Δ/(4√\|𝔭\|). The proof takes hP from `p_nonempty`, gets 0 < inf′ from `Finset.exists_mem_eq_inf'`, gets the lower bound on 𝔭 from `Finset.inf'_le`, gets \|𝔭\| > 0 from `card_pos`, and then applies `gain_le` to `dim_p_mul_sq_le`. This is the record's sentence ([bounds-relaxations.md:329](../findings/bounds-relaxations.md#L329)) at the θ scale, as r1577 read it.
- **Against `L119.pp`.** `pp λ` ([L119Statement.lean:57](../lean/HamiltonsCubic/Results/L119Statement.lean#L57)) is the same filter, with the decidability instance supplied classically where `gain_cap` takes it as an argument. `Finset.filter` does not depend on which instance is chosen, so the two are equal by congruence. The `L119_every` bound ([L107Frame.lean:109](../lean/HamiltonsCubic/Results/L107Frame.lean#L109)) uses the same filter.
- **r1577's gap 1.** The gap was that no theorem instantiates `gain_le` at the spectrum with d = \|𝔭\| and μ = λ^min_𝔭. `gain_cap` is that theorem, and the row now names it as the composition. Closed.
- The docstring change to `inf_pos_of_nonempty` ([L119Statement.lean:190](../lean/HamiltonsCubic/Results/L119Statement.lean#L190)) correctly points at `p_nonempty` for the non-emptiness.

## 3. Soundness

- `lake build HamiltonsCubic.Results.L52S20 HamiltonsCubic.Results.L119Gain`: completed, 8737 jobs, exit 0, warnings only (unused-variable and long-line linters in DoublyStochastic.lean and an unused simp argument, all pre-existing and outside both files).
- `axiom_audit.py --only L52S20.lean`: 1/1. `--only L119Gain.lean`: 4/4. Each rests on `propext`, `Classical.choice`, `Quot.sound` alone.
- No `sorry`, `admit` or `native_decide` in either file. Both are imported by [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) (lines 348 and 774).

## 4. Downstream

- [findings/bispectral.md](../findings/bispectral.md), [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) and [findings/INDEX-results.md](../findings/INDEX-results.md) do not name any of the new theorems. Rows 52 and 119 of INDEX-results.md read "Lean: proved" against their statement files, which stay proved, and they defer the gaps to lean/INDEX.md. Nothing there is contradicted.
- The L52 row's "negated" contradicts the L54 row's reading of `dpsi_split` ([lean/INDEX.md:283](../lean/INDEX.md#L283)). The L54 row is the correct one.
- STATUS.md and plan-lean.md change only in the file count, 840 to 841, matching one new file.

## 5. Style

- No em dash in any added line, no backticks inside link text, and every table row is one line.
- The L119 row's new list drops a comma: *"`dim_p_mul_sq_le` (…) `gain_le`, and `gain_cap`"* ([lean/INDEX.md:472](../lean/INDEX.md#L472)) is missing the comma after the parenthesis. The older splice in that row, *"so scaling defeats it; `L119_every` states it"*, is repaired.

## Verdict

**CONFIRMED WITH GAPS.** `omega_lower_iff` and `gain_cap` are correct, faithful to the record, and rest on the standard three axioms, and `gain_cap` closes r1577's gap. Three gaps, all text:

1. [lean/INDEX.md:377](../lean/INDEX.md#L377) and [L52S20.lean:13](../lean/HamiltonsCubic/Results/L52S20.lean#L13): "the record's K′ negated with one extra 0" should read "minus the spectrum of K on 𝟏^⊥ with one extra 0, which is the record's K′ ψ-block". It is K's spectrum that is negated, and K′ is carried unnegated.
2. [lean/INDEX.md:377](../lean/INDEX.md#L377): the owed list omits two untyped steps. One is the composition of `L52_record` at `wK` with `dpsi_split` and `omega_lower_iff` into the display at S²₀. The other is 0 ≥ −m, which the row cites to the record's Σω = 0 while the layer's `sum_omega_zero` ([L50Traces.lean:68](../lean/HamiltonsCubic/Results/L50Traces.lean#L68)) is stated for `Bmat` and never connected to it.
3. [lean/INDEX.md:472](../lean/INDEX.md#L472): a comma is missing after `dim_p_mul_sq_le`'s parenthesis in the list of four theorems.
