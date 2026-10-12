# Review r1581: L52's Σω = 0 in any complete basis (commit d0c0b800), L52's bound at the record's objects on S²₀ (commit 9dc81f16), and r1579's repairs (commit bbee7d34)

Log: agent_logs/r1581.log

**Standfirst.** The three commits do what they say, and the mathematics is sound. [L52S20.lean](../lean/HamiltonsCubic/Results/L52S20.lean)'s `L52_record_S20` is Lemma L52's display at the record's objects: ω ranges over the spectrum of W̊ restricted to the orthogonal complement of the metric's coordinates, which is S²₀, and K′ is the multiset of the pair diagonal together with minus the spectrum of K on 𝟏^⊥, which is the record's K′ entry for entry. The hypotheses are the record's Weyl conditions and unit norm, with n > 0 in place of the record's n ≥ 4. The derivation of 0 ≥ −m from Σω = 0 on a non-empty S²₀ is correct. `sum_omega_w_zero` and `neg_m_le_zero` are correct and are what the row says they are. bbee7d34 closes all three of r1579's gaps. The build is clean, the audit reads 5/5 on the standard three, and there is no `sorry`, `admit` or `native_decide`. Three text-level or hygiene gaps remain. The first is that `L52_record_S20` picks up the unused section binders `w` and `hw`, so its type asks a caller for an arbitrary complete family the proof never uses (the build warns about it). The second is that the docstring and the row say the theorem composes with `omega_lower_iff`, which its proof does not call. The third is one semicolon clause splice in the L52 row.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `L52_record_S20` is L52's display, P ≤ (3/2)[p₃(K) + 3M₊(1 − p₂(K))] − (1/2)[p₃(K′) + 3m(p₂(K′) − 3)], with ω ≥ −m on the spectrum on S²₀ and the record's K′ | **CONFIRMED** |
| A-1b | its hypotheses are the record's (unit norm, first Bianchi, Ricci-flat, n > 0) | **CONFIRMED WITH GAP** (the type also carries an unused complete family `w` with `hw`, [L52S20.lean:109](../lean/HamiltonsCubic/Results/L52S20.lean#L109)) |
| A-1c | 0 ≥ −m follows from Σω = 0 on S²₀, S²₀ being non-empty because Σω² = 3 | **CONFIRMED** |
| A-1d | "composing `L52_record` at `wK` with `dpsi_split`, `omega_lower_iff` and `sum_diag_split`" | **CONFIRMED WITH GAP** (the proof goes through `ringW_spectrum_split` and `sum_diag_split` and never calls `omega_lower_iff`) |
| A-2a | `sum_omega_w_zero`: Σω = 0 for `Bw w` at any complete w and Ricci-flat R | **CONFIRMED** |
| A-2b | `neg_m_le_zero`: a lower bound −m on a mean-zero family over a non-empty index is nonpositive | **CONFIRMED** |
| A-3 | bbee7d34 closes r1579's gaps 1, 2 and 3 | **CONFIRMED** |
| A-4 | the L52 row is accurate, the equality clause's two halves are the only remaining owed items, and the row stays partial | **CONFIRMED WITH GAP** (wording, gaps 2 and 3) |
| B | `lake build HamiltonsCubic.Results.L52S20` clean, audit on the standard three | **CONFIRMED** (5/5) |
| C | downstream text consistent | **CONFIRMED** |
| D | markdown style | **CONFIRMED WITH GAP** (one semicolon clause splice, [lean/INDEX.md:377](../lean/INDEX.md#L377)) |

**Summary:** L52 at the record's objects on S²₀ is now one kernel-checked theorem on the standard three axioms, and only the equality clause's two halves remain owed, with three small text and hygiene gaps.

## 1. Files and rows carrying the id

Lean files: [L52.lean](../lean/HamiltonsCubic/Results/L52.lean), [L52Bound.lean](../lean/HamiltonsCubic/Results/L52Bound.lean), [L52Frame.lean](../lean/HamiltonsCubic/Results/L52Frame.lean), [L52S20.lean](../lean/HamiltonsCubic/Results/L52S20.lean), [L52Statement.lean](../lean/HamiltonsCubic/Results/L52Statement.lean), and for the diagonal passage [L54Diag.lean](../lean/HamiltonsCubic/Results/L54Diag.lean) and [L54Spectrum.lean](../lean/HamiltonsCubic/Results/L54Spectrum.lean). Rows: [lean/INDEX.md:377](../lean/INDEX.md#L377) (L52) and [lean/INDEX.md:378](../lean/INDEX.md#L378) (L52 statement). The L52 row's file column names only L52.lean and L52S20.lean, while its body cites L52Bound.lean and L52Frame.lean for proved content. That omission predates these commits and is recorded here as a note.

## 2. Fidelity of `L52_record_S20`

The record ([findings/bispectral.md](../findings/bispectral.md), Lemma L52) takes W ∈ Weyl_n with ‖M‖_F = 1, μ ≤ M₊ on the spectrum of M, ω ≥ −m on the spectrum of W̊, K the sectional vector and K′ the W̊ diagonal in the basis {φ_ij, ψ_k} whose ψ_k are an eigenbasis of K on 𝟏^⊥.

- **ω's range.** The hypothesis `hω20` bounds the eigenvalues of `hTW.restrict_invariant hWW`, the restriction of `Bw (wK R) (ringW R)` to (ℝ∙`gCoord w`)^⊥. `ew w` is orthonormal for complete w (`frob_ew`, `w_orth`), so the Euclidean complement of the metric's coordinate vector is S²₀ and the restricted spectrum is W̊'s spectrum there. This is the record's condition.
- **K′.** The multiset in the statement ([L52S20.lean:122](../lean/HamiltonsCubic/Results/L52S20.lean#L122)) is the pair diagonal `Bw w (ringW R) (inl p) (inl p)`, which `Bw_diag_pair` identifies with K_ab = W_abab, plus −spec(K|𝟏^⊥). The record's ψ-block is diag(−κ_k) over an eigenbasis of K on 𝟏^⊥, so the two multisets coincide entry for entry, C(n,2) + n − 1 entries in each. The Lean basis `wK` is Mathlib's eigenbasis of K on ℝⁿ, which need not contain 𝟏/√n when the kernel of K is degenerate. That does not matter: the statement uses the multiset, and `dpsi_split` proves that the layer's ψ-diagonal is this multiset plus one 0 whatever the eigenbasis. `sum_diag_split` then passes power sums across, the extra 0 contributing g(0) = 0 to p₂ and p₃.
- **K and the μ side.** p₂(K) and p₃(K) are sums over pairs of `Kmat R a b`, the sectional vector. `hμ` bounds the spectrum of `Mpair`, which is M.
- **Hypotheses.** `hR`, `hskew`, `hsym` (linear, preserving skew matrices, self-adjoint on them), `hB` (first Bianchi) and `hRic` (Ricci-flat) are the algebraic Weyl conditions, `hunit : normSq R = 1` is ‖M‖_F = 1 through `sum_mu_sq`, and `hn : 0 < n` is weaker than the record's n ≥ 4, so the theorem is at least as general as the record.
- **The spurious binder.** `L52_record_S20` sits under `include hR hskew hsym hw` ([L52S20.lean:30](../lean/HamiltonsCubic/Results/L52S20.lean#L30)) without `omit hw in`. Its body shadows `w` with `let w := wK R hR hskew hsym`, so the section's `w` and `hw` are unused, and the build prints *"automatically included section variable(s) unused in theorem `L52_record_S20`: hw"* at line 109. A `#check` screen confirms the type begins `∀ ... (w : Fin n → Fin n → ℝ), (∀ i j, ∑ k, w k i * w k j = if i = j then 1 else 0) → 0 < n → ...`. The hypothesis is satisfiable (`wStd_complete`, `wK_complete`), so this is not a soundness defect, but the theorem as stated asks for an object the record's display does not mention. `sum_diag_split` has the correct `omit hw in` and does not carry it.
- **The existentials.** The invariance proofs `hWW` and `hWK` sit under ∃. Since they are proofs of propositions, any two are equal, and the restricted eigenvalues do not depend on which one is chosen. The form is harmless.
- **The 0 ≥ −m step.** `hsum0` reads Σω on S² = 0 (`sum_omega_w_zero`) through `ringW_spectrum_split`'s split into 0 :: rest, giving Σ rest = 0. `hne` shows rest is non-empty: if rest were empty, the S² spectrum would be {0}, and `sum_omega_w_sq` with unit norm gives Σω² = 3 ≠ 0. A non-empty index then feeds `neg_m_le_zero`, and −m ≤ min ≤ mean = 0. The argument is sound. It then reassembles ω ≥ −m on S² and applies `L52_record` at `wK`, rewriting both diagonal sums through `sum_diag_split`.
- **What the proof composes.** The docstring ([L52S20.lean:17](../lean/HamiltonsCubic/Results/L52S20.lean#L17)) and the row say the theorem composes `L52_record` with `omega_lower_iff`. The proof ([L52S20.lean:129](../lean/HamiltonsCubic/Results/L52S20.lean#L129), [L52S20.lean:156](../lean/HamiltonsCubic/Results/L52S20.lean#L156)) calls `ringW_spectrum_split` and reproves the needed direction of `omega_lower_iff` inline. The content is the same, and the attribution is inaccurate.

## 3. `sum_omega_w_zero` and `neg_m_le_zero`

- `sum_omega_w_zero` ([L52S20.lean:60](../lean/HamiltonsCubic/Results/L52S20.lean#L60)) equates Σ eigenvalues of `Bw w (ringW R)` with its trace, the trace with `Bmat`'s through `trace_Bw_eq`, and `Bmat`'s trace with its eigenvalue sum, which `sum_omega_zero` makes 0 at Ricci-flat R. It needs no Bianchi and asks for none. This is exactly what the row says and what r1579's gap 2 asked for.
- `neg_m_le_zero` ([L52S20.lean:71](../lean/HamiltonsCubic/Results/L52S20.lean#L71)) is the elementary card · (−m) ≤ Σx = 0 with card > 0. Correct and general.

## 4. bbee7d34 against r1579

- **Gap 1** (sign). The row and docstring now say "minus the spectrum of K on 𝟏^⊥ with one extra 0, which is the record's ψ-block of K′ plus one 0". That is what `dpsi_split` proves and agrees with the L54 row. Closed.
- **Gap 2** (owed list). bbee7d34 added the composition at S²₀ and Σω = 0 for `Bw w` to the owed list. d0c0b800 and 9dc81f16 then discharged both and removed them. Closed.
- **Gap 3** (L119 comma). The comma after `dim_p_mul_sq_le`'s parenthesis is present. Closed.

## 5. The L52 row

- The row's new sentences on `sum_omega_w_zero`, `neg_m_le_zero` and `L52_record_S20` are accurate, apart from the `omega_lower_iff` attribution in section 2.
- **Owed.** The row owes the equality clause's "if" half (the ψ stipulation) and its "only if" half (Karamata). Against the record's block, the inequality is now fully typed at the record's objects, and the equality clause is not typed anywhere in the L52 files, so these two are the remaining items. **L52 stays partial**, correctly.
- The owed list is headed "**Owed** ([r1579](../reviews/REVIEW_r1579.md))". Both items r1579 added are closed, and the two halves still listed were owed before r1579. The citation now points at a review whose additions are gone. Minor wording.
- The row reads *"deriving $0\ge-m$ from $\sum\omega=0$ on a non-empty $S^2_0$; L52S20 5/5 on the standard three."* That semicolon joins two independent clauses.

## 6. Soundness

- `cd lean && ~/.elan/bin/lake build HamiltonsCubic.Results.L52S20`: *Build completed successfully (8736 jobs)*, exit 0. The only warning in L52S20.lean is the unused `hw` at line 109.
- `python3 scripts/misc/axiom_audit.py --only L52S20.lean`: *5/5 clean, resting on the standard three alone*.
- No `sorry`, `admit` or `native_decide` in L52S20.lean.
- The `#check` in section 2 is a screen of the theorem's elaborated type, not evidence for any positive claim.

## 7. Downstream

- [findings/bispectral.md](../findings/bispectral.md) and [findings/INDEX-results.md](../findings/INDEX-results.md) name none of the new theorems. Row 52 of INDEX-results.md reads "Lean: proved" against the statement file, which stays proved, and defers the rest to lean/INDEX.md. Nothing is contradicted.
- [lean/INDEX.md](../lean/INDEX.md) carries the new names only in the L52 row. The L54 row's reading of `dpsi_split` now agrees with the L52 row.
- plan-lean.md's L52 row is truncated and says partial, consistent.

## 8. Style

No em dash in any of the three commits' markdown additions, no backticks inside link text, and the row is a single line. One semicolon clause splice, section 5.

## Verdict

**CONFIRMED WITH GAPS.** `L52_record_S20` is Lemma L52's display at the record's objects on S²₀, `sum_omega_w_zero` and `neg_m_le_zero` are correct, the 0 ≥ −m derivation is sound, bbee7d34 closes r1579's three gaps, and L52 correctly stays partial on the equality clause alone. Gaps:

1. [L52S20.lean:109](../lean/HamiltonsCubic/Results/L52S20.lean#L109) (with the `include` at [L52S20.lean:30](../lean/HamiltonsCubic/Results/L52S20.lean#L30)): `L52_record_S20` carries the unused section binders `w` and `hw`, so its type demands an arbitrary complete family the record's display does not have. Add `omit hw in`, as `sum_diag_split` has.
2. [L52S20.lean:17](../lean/HamiltonsCubic/Results/L52S20.lean#L17), [L52S20.lean:106](../lean/HamiltonsCubic/Results/L52S20.lean#L106) and [lean/INDEX.md:377](../lean/INDEX.md#L377): the theorem is said to compose `L52_record` with `omega_lower_iff`, while its proof calls `ringW_spectrum_split` and `sum_diag_split` and reproves that direction inline. Either call `omega_lower_iff` or name `ringW_spectrum_split`.
3. [lean/INDEX.md:377](../lean/INDEX.md#L377): a semicolon splice ("on a non-empty $S^2_0$; L52S20 5/5 on the standard three"), and the owed list's "([r1579](../reviews/REVIEW_r1579.md))" now cites a review whose two added items are closed while the remaining halves predate it.
4. Note, pre-existing: [lean/INDEX.md:377](../lean/INDEX.md#L377)'s file column omits L52Bound.lean and L52Frame.lean, which the row body cites for proved content.
