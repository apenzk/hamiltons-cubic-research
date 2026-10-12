# Review r1606: L122's bracketed form (Results/L122Block.lean), commit f5eecfb3

**Standfirst.** [L122Block.lean](../lean/HamiltonsCubic/Results/L122Block.lean) proves `bracket_pair` and `pairBlock`: at a symmetric hollow weight w and distinct j, k, i, the Fox product `diagOp w ∘ (φ_ji ⊙ φ_ki)` sends every bivector X to ½((w_ji + w_ki − w_jk) f_i X + Σ_q w_iq f_q X). That is column i of the record's ½[diag(M_ji + M_ki) − M_jk Id + M^(jk)], with the hypotheses the record names (diagonality alone). The terms at q ∈ {j, k, i} vanish as the docstring says. The module builds and the audit gives 2/2 on the standard three. The gaps are in what surrounds the column formula: the invariance of the span of the f_q is left untyped (L121Block has `fourSet_span` for its block, L122Block has no counterpart), the INDEX row's "with block_eq_kirchhoff this gives the Kirchhoff form" composes nothing in Lean and drops the n − 2 Ricci rows at that sentence, the owed list names only the maximiser inequality while the Ricci-cut identification and the basis facts that `lambda_min_bound`'s `hcap` needs are also owed, and L122Statement.lean's "What is NOT typed here" and the L122 statement row still say the identification with the pair block is absent.

| Claim | Verdict |
|---|---|
| A-1. `pairBlock` states column i of the record's bracketed matrix | **CONFIRMED** |
| A-2. The sum over all q is harmless at q ∈ {j, k, i} | **CONFIRMED** |
| A-3. f_i = `rk2 (phi j i) (phi k i)` is the record's e_ji ⊙ e_ki, sign and normalisation included, and w_ab is the sectional matrix | **CONFIRMED** |
| A-4. Hollowness and symmetry are within "diagonality alone" | **CONFIRMED** |
| A-5. The pair block is invariant (image in the span of the f_q) and this is stated | **CONFIRMED WITH GAPS** |
| A-6. "With `block_eq_kirchhoff` this gives the Kirchhoff form" | **CONFIRMED WITH GAPS** |
| A-7. The owed item is exactly the maximiser inequality | **CONFIRMED WITH GAPS** |
| B. Build and axiom audit | **CONFIRMED** |
| C. Downstream text | **CONFIRMED WITH GAPS** |
| D. Style | **CONFIRMED** |

**Summary:** the column formula is correct and faithful to the record at diagonality alone, and the gaps are an untyped span-invariance corollary, an overstated Kirchhoff sentence, an incomplete owed list, and two stale "not typed" texts.

## 1. Files read

- [L122Block.lean](../lean/HamiltonsCubic/Results/L122Block.lean), new in f5eecfb3: `bracket_pair` (line 30), `pairBlock` (line 57).
- [L121Block.lean](../lean/HamiltonsCubic/Results/L121Block.lean): `rk2` (line 102), `sharpCross_rk2` (line 167), `fourSet_span` (line 289).
- [Families.lean:147](../lean/HamiltonsCubic/Base/Families.lean#L147) `diagOp`, and `diagOp_phi` at line 177. [WeylReal.lean:45](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) `phi`. [FoxProduct.lean:217](../lean/HamiltonsCubic/Base/FoxProduct.lean#L217) `foxProd`.
- [L122Statement.lean](../lean/HamiltonsCubic/Results/L122Statement.lean): `Lb` (line 91), `block_eq_kirchhoff` (line 122), `lambda_min_bound` (line 232), "What is NOT typed here" (line 58).
- [lean/INDEX.md:356-357](../lean/INDEX.md#L356), the L122 rows. The record: [second-order.md:1211](../findings/second-order.md#L1211), Lemma L122.

## 2. Fidelity (A-1 to A-4)

- **The column.** Column i of ½[diag(M_ji + M_ki) − M_jk Id + M^(jk)] in the basis (f_i) is ½(M_ji + M_ki − M_jk) at row i and ½M_i'i at row i' ∉ {j, k, i}. `pairBlock`'s right side is ½((w_ji + w_ki − w_jk) f_i + Σ_q w_iq f_q), and with w symmetric w_iq = w_qi, so the entries agree. The Jordan half `jordanProd` supplies ½(w_ji + w_ki) f_i through `diagOp_phi` twice, and `bracket_pair` supplies −w_jk f_i + Σ_q w_iq f_q, halved by `sharpCross_rk2`.
- **The extra terms.** At q = j, `rk2 (phi j j) (phi k j)` sends X to ⟨φ_kj, X⟩·0 + ⟨0, X⟩φ_kj = 0 because `phi j j = single j j 1 − single j j 1 = 0`. The same at q = k. At q = i the coefficient is w_ii = 0 by `hh`. So the Lean sum equals the record's sum over i' ∉ {j, k}, i' ≠ i.
- **The basis and sign.** `rk2 U V X = ⟨V,X⟩U + ⟨U,X⟩V` is the symmetric product U ⊙ V. The record's e_ab and Lean's φ_ab can differ by at most a sign uniform in (a, b), and f_i carries two such factors, so f_i is the same operator under either convention. The ⊙ normalisation scales every f_i alike and leaves the matrix unchanged. `inner2 (phi a b) (phi a b) = ½ tr(φᵀφ) = 1`, so `diagOp w (phi a b) = w_ab • phi a b` makes w_ab the sectional curvature of the plane ab, the record's M_ab.
- **Hypotheses.** Symmetry of w is automatic for a diagonal operator (w_ab and w_ba both name plane ab). Hollowness is a normalisation: `diagOp w X` multiplies X_aa = 0 by w_aa on a bivector, so w_aa is invisible on Λ², and the record's M^(jk) is itself called hollow. Neither Ricci-flatness, tracelessness nor criticality enters, which matches "diagonality alone". The statement is also nonvacuous: at X = φ_ki the left factor `rk2 (phi j i) (phi k i) X = φ_ji` is nonzero, and the hypotheses hold at w = 0 whenever the index type has three elements.

## 3. Invariance (A-5)

- `pairBlock` gives `M ∘ f_i` pointwise on bivectors as a combination of the f_q, so each image lies in span{f_q : q ∉ {j, k}}, and invariance of the span follows by `foxProd_add_right` and `foxProd_smul_right`.
- **That step is not typed.** [L121Block.lean:289](../lean/HamiltonsCubic/Results/L121Block.lean#L289) proves the corresponding `fourSet_span` for L121's block and says "so the four-set span is invariant under L_M". L122Block stops at the column, and neither its header nor the INDEX row states invariance. "The pair block of L_M is" presupposes it, so this is a gap of statement, not of mathematics (a two-line corollary).

## 4. The Kirchhoff sentence and the owed list (A-6, A-7)

- [lean/INDEX.md:356](../lean/INDEX.md#L356) says "With `block_eq_kirchhoff` this gives the Kirchhoff form". `block_eq_kirchhoff` ([L122Statement.lean:122](../lean/HamiltonsCubic/Results/L122Statement.lean#L122)) takes `hsym` and `hR : ∀ i ∈ Sset j k, Σ_b M i b = 0`, the n − 2 Ricci rows. The sentence follows "with diagonality alone" without naming those rows, and no Lean theorem composes `pairBlock` (over an arbitrary `ι`, on `CurvOp`) with `Lb` (over `Fin n`, a bare matrix). The record's scope split is honoured in L122Statement.lean and blurred in the row.
- The owed item is "the maximiser inequality, which needs L24". `lambda_min_bound` ([L122Statement.lean:232](../lean/HamiltonsCubic/Results/L122Statement.lean#L232)) already derives the bound from `hcap`, a Rayleigh cap on the matrix `Lb` over the cut Σx_i = 0. Turning L24's cap on L_M into `hcap` needs three further facts: the invariance of §3, the record's "the Ricci cut on this block is exactly Σ_i x_i = 0" (L121Block has `fourSet_bianchi` for its block, L122 has no counterpart), and the orthogonality and common norm √2 of the f_i, so that Rayleigh quotients in the f basis equal those of `Lb`. The owed list names none of them. The orbit direction's θ/2 eigenvector is also listed in L122Statement.lean as absent and does not appear in the row.

## 5. Soundness (B)

- `lake build HamiltonsCubic.Results.L122Block`: completed successfully (8714 jobs). The only info lines were the pre-existing flexible-tactic linter notes in L121Block.lean.
- `python3 scripts/misc/axiom_audit.py --only L122Block.lean`: "2/2 clean -- resting on the standard three alone".
- No `sorry`, no `native_decide`. The commit's n = 5 Python screen is described as a screen, as it should be. This review ran no screen, the kernel check being the evidence.

## 6. Downstream (C)

- [L122Statement.lean:58-64](../lean/HamiltonsCubic/Results/L122Statement.lean#L58), "What is NOT typed here", still says "That this matrix *is* the pair block of L_M is absent, and with it the basis f_i = e_ji ⊙ e_ki ... All of these need the Fox product ∘ and the operator L_M, which HamiltonsCubic.Base.WeylReal does not carry." The column identification is now proved in L122Block.lean, and the file does not point there.
- [lean/INDEX.md:357](../lean/INDEX.md#L357), the L122 statement row, reads "the identification with L_M's pair block is NEVER typed". True of that file, but it now reads as a claim about the programme and names no successor.
- [findings/second-order.md](../findings/second-order.md) carries no machine-checked note for L122 and [findings/INDEX-results.md:138](../findings/INDEX-results.md#L138) says only "Lean: partial", so neither is stale.
- The commit's STATUS.md and plan-lean.md changes are the regenerated file counts and are consistent.

## 7. Style (D)

- No em dash in L122Block.lean or in the new INDEX text. No semicolon splice in the new INDEX text. No backticks inside link text. The INDEX row is one line.

## Verdict

**CONFIRMED WITH GAPS.** `pairBlock` is the record's column at diagonality alone and is kernel-checked on the standard three. Gaps:

1. Span invariance of the pair block is not typed (L122Block.lean has no analogue of [L121Block.lean:289](../lean/HamiltonsCubic/Results/L121Block.lean#L289)'s `fourSet_span`).
2. [lean/INDEX.md:356](../lean/INDEX.md#L356): "With block_eq_kirchhoff this gives the Kirchhoff form" composes nothing in Lean and omits the n − 2 Ricci rows that `block_eq_kirchhoff` requires.
3. [lean/INDEX.md:356](../lean/INDEX.md#L356): the owed list names only the maximiser inequality, while the Ricci-cut identification, invariance and the f_i orthogonality and norm √2 (all needed to feed `hcap`) and the orbit eigenvector are also owed.
4. [L122Statement.lean:58-64](../lean/HamiltonsCubic/Results/L122Statement.lean#L58) and [lean/INDEX.md:357](../lean/INDEX.md#L357) still describe the pair-block identification as absent without pointing at L122Block.lean.
