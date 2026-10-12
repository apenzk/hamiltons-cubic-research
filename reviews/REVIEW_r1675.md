# REVIEW r1675: L52, `L52_eq_S20` (e292ded1) and r1674's repairs (c77c8231)

**Verdict: CONFIRMED WITH GAPS.** `L52_eq_S20` is correct, kernel-checked and faithful: its hypotheses are `L52_record_S20`'s exactly and its conclusion is the "only if" half of that display. r1674's G1 and G2 are repaired, and **partial** is the right state. The gap is in the Owed clause: it describes the remaining S²₀ restriction as a change of basis at a degenerate 0-eigenspace of `K`, and the restriction involves no such change. The pair–ψ vanishing is basis-free, and `psi_block` makes the ψ block diagonal at every orthonormal eigenfamily of `K`. So the owed item is a short corollary of existing declarations, and the row should say so.

## Claims

| # | Claim | Verdict |
|---|---|---|
| 1 | `L52_eq_S20` has `L52_record_S20`'s hypothesis set and concludes the "only if" half | **CONFIRMED** |
| 2 | The S² lower bound on ω is derived from the S²₀ one through `neg_m_le_zero` | **CONFIRMED** |
| 3 | The S²₀ → S² conversion through `sum_diag_split` is sound | **CONFIRMED** |
| 4 | The Owed clause accurately describes the remaining S²₀ restriction | **CONFIRMED WITH GAP** (G1) |
| 5 | A Lean witness of the staircase counterexample is genuinely owed | **CONFIRMED** |
| 6 | **partial** is the right state for the L52 row | **CONFIRMED** |
| 7 | r1674 G1 and G2 are repaired | **CONFIRMED** |
| 8 | Axiom audit on L52EqS20.lean: 1/1 on the standard three | **CONFIRMED** (rerun) |

## 1. `L52_eq_S20`

- **Hypotheses.** [L52EqS20.lean:32-44](../lean/HamiltonsCubic/Results/L52EqS20.lean#L32) against [L52S20.lean:110-122](../lean/HamiltonsCubic/Results/L52S20.lean#L110): `hn`, `hB`, `hunit`, `hRic`, `Mp`, `m`, `hμ`, the same seven `let`s, the same `∃ hWW hWK`, and the same `ω ≥ −m` on the spectrum of `W̊` restricted to `(ℝ ∙ gW)ᗮ`. Identical term for term.
- **Equality.** Lines 45-51 are `L52_record_S20`'s right-hand side at :125-127 with `≤` replaced by `=` and `K'` inlined, the same inlining r1674 accepted for `L52_if_psi_S20`. The restricted eigenvalues depend on the proofs `hWW` and `hWK` only, and proof irrelevance makes the choice immaterial.
- **Conclusion.** `M` off-diagonal zero in the pair basis and `Bw (wK) (ringW R)` off-diagonal zero. That is `L52_record_eq`'s conclusion ([L52RecordEq.lean:44](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L44)) at `w = wK`, the "only if" half.
- **The lower bound (claim 2).** Lines 61-86 repeat L52S20.lean:138-165 verbatim. `Σω = 0` on S²₀ comes from `sum_omega_w_zero` and `ringW_spectrum_split`'s extra `0`. Non-emptiness comes from `Σω² = 3`. Then `neg_m_le_zero` gives `−m ≤ 0`, and the extra `0` joins the S²₀ spectrum to give `ω ≥ −m` on S². Sound.
- **The conversion (claim 3).** `sum_diag_split` at `g = t³` and `g = t²` (both `g 0 = 0`) rewrites `Σ_u Bw_uu^k` as the `K'` power sum. Line 88 rewrites right-to-left, turning the S²₀ equality into `L52_record_eq`'s S² form. The second `hWK` is discarded, which proof irrelevance makes harmless.
- **Hypothesis strength.** `0 < n` is weaker than the record's `n ≥ 4`, so the theorem is stronger than the record needs. Satisfiability is unaffected (r1674's `n = 4` tensor).

## 2. The conclusion's reading and the Owed clause

- The record's K' lives on S²₀ in `{φ_ij, ψ_k}` with `ψ_k` an eigenbasis of `K` on `𝟏^⊥` ([bispectral.md:75](../findings/bispectral.md#L75)). So the literal "only if" conclusion is `W̊|S²₀` diagonal in that basis, and the S² reading at `wK` is one step short of it. The item is genuinely owed for literal fidelity.
- **The step needs no change of basis at the 0-eigenspace.** Derived by hand from the definitions:
  - The pair–pair block is `⟨W̊φ_p, φ_q⟩`, independent of `w`.
  - The pair–ψ entry is `Bw w (inl p) (inr k) = Σ_a (W̊φ_p)_aa · w_k(a)` by `frob_diag_left` ([L52Frame.lean:43](../lean/HamiltonsCubic/Results/L52Frame.lean#L43)). It vanishes for every `k` and the `wK_k` span ℝⁿ, so `diag(W̊φ_p) = 0` and `⟨W̊φ_p, diag ψ⟩ = 0` for every `ψ`, in any basis of `𝟏^⊥`.
  - The ψ–ψ block is `−ψ_jᵀKψ_k` (`diag_block`, [L54Basis.lean:108](../lean/HamiltonsCubic/Results/L54Basis.lean#L108)), which is `diag(−κ)` at every orthonormal eigenfamily of `K` whatever its index type (`psi_block`, [L54Basis.lean:123](../lean/HamiltonsCubic/Results/L54Basis.lean#L123)). An eigenbasis of `K|𝟏^⊥` is such a family, since `K𝟏 = 0` at Ricci-flat `W`. This block is diagonal without equality.
  - The `φ_ab` and `diag ψ_k` are trace-free, so these entries are exactly `W̊|S²₀` in `{φ, ψ}`.
- So the degenerate 0-eigenspace, and whether `wK` contains `𝟏/√n`, play no role. What remains is to type an eigenbasis of `K|𝟏^⊥` in ℝⁿ (from `K_spectrum_split`'s restriction) and the three facts above. The clause's wording presents a routine corollary as an obstacle (G1).

## 3. The staircase counterexample

- The record's equality clause states, as its own bullet ([bispectral.md:83](../findings/bispectral.md#L83)), that the "if" half is **false** without the ψ stipulation. That is a mathematical claim of the block, and the heading "what its equality clause needs" promises it.
- It is formalisable with objects the layer holds: a coordinate-diagonal `W` at `n = 4` and a complete non-eigenbasis `w` with strict inequality in `L52_record` at `w`. The lean-loop skill reserves prose for statements whose objects are undefined, which is not this case.
- `grep -rl staircase lean/HamiltonsCubic` finds only L52RecordEq.lean's docstring, which says "no declaration". The item is undeclared and genuinely owed.

## 4. The row's state

- L52Statement.lean carries no `sorry` (its own row reads **proved**), so the row's **partial** rests on the two owed items alone.
- Both are claims of the record, and neither is declared, so **partial** is right. Discharging G1's corollary and a staircase witness would move it to **proved**.

## 5. r1674's gaps

- **G1.** [L52Statement.lean:74-75](../lean/HamiltonsCubic/Results/L52Statement.lean#L74) now names `L52_if_psi_S20` and also `L52_eq_S20`. Repaired, and the paragraph is complete against L52RecordEq, L52IfPsi and L52EqS20.
- **G2.** [L52IfPsi.lean:20-22](../lean/HamiltonsCubic/Results/L52IfPsi.lean#L20) lists `L52_if_psi` and then `L52_if_psi_S20`, now worded "`L52_if_psi` on `S²₀`". Repaired.

## 6. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L52EqS20.lean`: **1/1 clean, resting on the standard three alone.** It matches the row's "1/1", and the run confirms the file compiles.

## Gaps

- **G1, [lean/INDEX.md:383](../lean/INDEX.md#L383) (the Owed clause) and [L52EqS20.lean:18-19](../lean/HamiltonsCubic/Results/L52EqS20.lean#L18).** Both describe the S²₀ restriction as "a change of basis when K's 0-eigenspace is degenerate and `wK` does not contain `𝟏/√n`". §2 shows the pair–ψ vanishing is basis-free and `psi_block` covers every eigenbasis of `K|𝟏^⊥`. Fix: word the item as the corollary it is ("`W̊|S²₀` diagonal in `{φ, ψ}` for any eigenbasis `ψ` of `K|𝟏^⊥`, from `frob_diag_left`, `diag_block` and `psi_block`"), or discharge it.
- **G2 (minor), [L52EqS20.lean:14-15](../lean/HamiltonsCubic/Results/L52EqS20.lean#L14).** The header calls `{φ_ab} ∪ {diag (wK k)}` "the record's shared frame in the stipulated basis". The stipulated basis lives on S²₀ in `𝟏^⊥`, which lines 18-19 concede. Fix: say "the S² basis at `wK`".

## What would break each claim, and what was done

- **Claims 1 and 3:** a hypothesis in one of `L52_eq_S20` and `L52_record_S20` absent from the other, a right-hand side that differs, or a conversion using `sum_diag_split` at a `g` with `g 0 ≠ 0`. Diffed the two statements line by line and read both `sum_diag_split` calls. None.
- **Claim 2:** a W̊ with `ω ≥ −m` on S²₀ and `0 < −m`, so that the S² bound fails. Excluded by `Σω = 0` on a non-empty S²₀ (non-empty since `Σω² = 3`). Checked the kernel-accepted chain.
- **Claim 4:** an equality-attaining Ricci-flat W where `Bw (wK)` is diagonal but `W̊|S²₀` is not diagonal in some eigenbasis ψ of `K|𝟏^⊥`. By-hand derivation from `Bw`, `ew`, `frob_diag_left`, `diag_block` and `psi_block` (§2) shows none exists. That also shows the clause's stated obstacle is absent (G1).
- **Claim 5:** a declaration of the staircase witness already in lean/, or a record that does not claim it. Grep found only the "no declaration" docstring, and bispectral.md:83 states it as a claim.
- **Claim 6:** a `sorry` in L52Statement.lean holding the row partial, or a clause of the block neither declared nor owed. Grep found no `sorry`. The owed list is complete against bispectral.md:75-84.
- **Claim 7:** a declaration missing from L52Statement's equality paragraph, or a header referent that reads wrongly. Read both at HEAD. None.
- **Claim 8:** a non-standard axiom. Reran the audit: 1/1 on the standard three.

*Analysis-only footing: the one run was the per-file axiom audit (a few minutes, on the file in hand). The claims in §2 and §3 are derived by hand and were not screened numerically.*
