# REVIEW r1673: L52's equality tail, `L52_eq_diagonalises` (bf1a119b), r1670's repairs (22de0c04), `coordDiag_of_Mpair` (2c957b24), lean-loop

**Verdict: CONFIRMED WITH GAPS.** Both new theorems are correct, kernel-checked on the standard three (3/3 per file), and faithful to the record. r1670's G1, G2 and G3 are repaired. **partial** remains the right status, since the Owed clause names three undeclared items. The gaps are bookkeeping: six passages of the row carry no N/N audit count, L52Statement.lean's equality paragraph predates the two new files, and the "eigenbasis" step after `L52_eq_diagonalises` is hand-derived.

| # | claim | verdict |
| --- | --- | --- |
| 1 | `L52_eq_diagonalises`: at equality in `L52_record`, `w_kᵀ K w_l = 0` for `k ≠ l` | **CONFIRMED** |
| 2 | "an equality-attaining complete `w` is an eigenbasis of `K`, the ψ stipulation forced by equality" | **CONFIRMED WITH GAP** (G3) |
| 3 | `coordDiag_of_Mpair`: `Mpair` off-diagonal zero gives `IsCoordDiag`, all four orderings and both repeated-index cases | **CONFIRMED** |
| 4 | r1670 G1–G3 repaired | **CONFIRMED** |
| 5 | the L52 row is consistent and every passage carries its audit count | **CONFIRMED WITH GAP** (G1) |
| 6 | the Owed clause is accurate and complete, and **partial** is right | **CONFIRMED** |
| 7 | L52Statement.lean is current | **CONFIRMED WITH GAP** (G2) |
| 8 | axiom audit, L52RecordEq.lean and L52IfPsi.lean | **CONFIRMED** (3/3 and 3/3, standard three) |

**Summary:** the equality clause now runs both ways at the record's objects with the ψ stipulation derived from equality and `M`-diagonality equivalent to `IsCoordDiag`, and what remains is count bookkeeping and one stale paragraph.

## 1. `L52_eq_diagonalises`

- **The Lean** ([L52RecordEq.lean:71-84](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L71)) takes `L52_record_eq`'s second conjunct at `u = Sum.inr k`, `v = Sum.inr l` (`S2Idx n = Pairs n ⊕ Fin n`, [SecondKindMatrix.lean:56](../lean/HamiltonsCubic/Results/SecondKindMatrix.lean#L56)), distinct by `Sum.inr_injective`, and rewrites that entry by `diag_block` ([L54Basis.lean:108](../lean/HamiltonsCubic/Results/L54Basis.lean#L108)), `frob (ringW R (diagonal u)) (diagonal v) = −(u ⬝ᵥ K v)`, which holds at any vectors `u`, `v` with no eigen or orthogonality hypothesis. Hypotheses are exactly `L52_record_eq`'s. Correct.
- **Completeness makes it an eigenbasis.** `hw` is `∑_k w_k(i) w_k(j) = δ_ij`, so the square matrix with rows `w_k` is orthogonal and `{w_k}` is an orthonormal basis of `ℝⁿ`. Then `K w_l = ∑_k (w_kᵀ K w_l) w_k = (w_lᵀ K w_l) w_l`, so each `w_l` is an eigenvector. The Lean states the off-diagonal vanishing, which is "`w` diagonalises `K`" literally. The docstring's further "is an eigenbasis of `K`" is this one-line expansion, and it is hand-derived (G3).
- **Is "forced by equality" faithful?** The record ([bispectral.md:75](../findings/bispectral.md#L75), [:78](../findings/bispectral.md#L78)) stipulates ψ an eigenbasis of `K` for the "if" half. The theorem shows the stipulation is necessary for equality in the S² display at `w`: no complete `w` outside the eigenbases attains equality. That is the right sense of "forced". It is the S² reading, `w` over `ℝⁿ` where the record's ψ lives on `𝟏^⊥`, and the passage to S²₀ is the Owed clause's second item. Faithful as scoped.
- **Non-vacuous.** `L52_if_psi` at a coordinate-diagonal first-Bianchi unit `R` attains equality at `wK`, so the hypothesis set is inhabited.

## 2. `coordDiag_of_Mpair`

- **Definition** ([L54Basis.lean:186-187](../lean/HamiltonsCubic/Results/L54Basis.lean#L186)): `∀ i j k l, ¬((k = i ∧ l = j) ∨ (k = j ∧ l = i)) → R4 R i j k l = 0`. The theorem's conclusion is this, verbatim, and the hypothesis is `∀ p q, p ≠ q → Mpair R p q = 0`, the same form `coordDiag_frame`'s first conjunct produces. So the two together are the equivalence r1670 §4 checked by hand.
- **Repeated indices.** `i = j`: `R4_self_left` ([L54Basis.lean:49](../lean/HamiltonsCubic/Results/L54Basis.lean#L49)), from `phi i i = 0` and linearity. `k = l`: `R4_anti2 i j k k` ([L209FoxClosure.lean:249](../lean/HamiltonsCubic/Results/L209FoxClosure.lean#L249)) gives `x = −x`. Both correct, and the `hne` hypothesis is rightly unused there.
- **Four orderings** ([L52IfPsi.lean:84-88](../lean/HamiltonsCubic/Results/L52IfPsi.lean#L84)), with `e : a < b → c < d → ¬(c = a ∧ d = b) → R4 a b c d = 0`:
  - `i<j, k<l`: `e` on `(i,j,k,l)`, excluded case `k=i ∧ l=j` is `hne`'s left disjunct.
  - `i<j, l<k`: `e` on `(i,j,l,k)`, excluded case `l=i ∧ k=j` is `hne`'s right disjunct swapped. `R4_anti2 i j l k` gives `R4 i j l k = −R4 i j k l`.
  - `j<i, k<l`: `e` on `(j,i,k,l)`, excluded case `k=j ∧ l=i` is `hne`'s right disjunct. `R4_anti1 j i k l` ([SecondKind.lean:74](../lean/HamiltonsCubic/Results/SecondKind.lean#L74)) gives `R4 i j k l = −R4 j i k l`.
  - `j<i, l<k`: `e` on `(j,i,l,k)`, excluded case `l=j ∧ k=i` is `hne`'s left disjunct swapped, and both antisymmetries compose.
  Each excluded case maps to the correct disjunct, and the kernel confirms the terms.
- **Hypotheses.** `R4_anti1` needs `hskew` and `hsym` (it routes through `R4_pair`), which the section's `include` supplies. No Bianchi, no norm, as it should be.

## 3. r1670's gaps

- **G1** (the "needs only M diagonal" reading resting on an undeclared bridge): 22de0c04 marked it owed, and 2c957b24 declares it. The row now reads `coordDiag_of_Mpair` … "so at `wK` the "if" half needs only `M` diagonal" with the declaration named. Repaired by proof.
- **G2** (L52Statement stale): [L52Statement.lean:58-59](../lean/HamiltonsCubic/Results/L52Statement.lean#L58) now cites SchurMajor's `diag_doublyStochastic`, the heading at [:64](../lean/HamiltonsCubic/Results/L52Statement.lean#L64) is "What is typed elsewhere", and the paragraph names `Mpair_diag` and `Bw_diag_pair`. Repaired. The equality paragraph a few lines down is now stale in turn (G2 here).
- **G3** (S²₀ reading of the "if" half unowed): the Owed clause's first item is exactly `L52_if_psi` with `sum_diag_split` at a Ricci-flat `W`. Repaired.

## 4. The L52 row as a whole ([lean/INDEX.md:383](../lean/INDEX.md#L383))

- **Consistency.** No passage contradicts another. `L52_eq_diagonalises` and `coordDiag_of_Mpair` no longer appear in the Owed clause. The r1669 staircase is marked "checked by hand … no declaration" and its witness is owed. The per-file counts read "2/2" after the first two declarations of L52RecordEq and L52IfPsi and "3/3" after the third, which is sequential and correct, though a reader may take "2/2" as the file total.
- **Audit counts.** Carried as N/N: L52S20 5/5, DoublyStochasticEq 3/3, L52Equality 5/5, CubicConvexity 7/7, L52RecordEq 3/3, L52IfPsi 3/3. **Not carried as N/N** (G1): the L52.lean cap passage ("Kernel-checked, no `native_decide`"), DoublyStochastic.lean, SchurMajor.lean, L52Bound.lean and L52Frame.lean ("Standard three axioms" with no count), and SpectralTrace.lean (nothing).
- **Owed clause.** Three items: the S²₀ "if" reading, the S²₀ off-diagonal ("only if") reading with its three named needs (`Bw_gCoord` or `psi_one_null`, Ricci-flatness, change of basis at a degenerate 0-eigenspace), and the staircase witness. Checked against the record's equality clause ([bispectral.md:77-79](../findings/bispectral.md#L77)): the "if" half with stipulation is declared (S²), the "if" half's failure without it is owed as a witness, the "only if" half is declared at the record's objects, and the ψ stipulation's necessity is now declared. The "what it costs" identity on the diagonal family is `L52_if_psi` read on S². Nothing the record states in L52's statement or equality clause is missing from declared-or-owed. Accurate and complete.
- **partial.** Correct: three items are owed, one of them (the staircase witness) a statement the record makes about the lemma itself.

## 5. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L52RecordEq.lean`: "auditing 3 declarations across 1 files, 3/3 clean -- resting on the standard three alone".
- `python3 scripts/misc/axiom_audit.py --only L52IfPsi.lean`: the same, 3/3.
- Run from a script with no other lake process, working tree clean under `lean/`. A screen of compilation and axioms.

## Gaps

- **G1, [lean/INDEX.md:383](../lean/INDEX.md#L383).** Six passages carry no N/N count: L52.lean (13 top-level declarations by grep), DoublyStochastic.lean (5), SchurMajor.lean (6), L52Bound.lean (5, "Standard three axioms"), L52Frame.lean (21, "Standard three axioms"), SpectralTrace.lean (12). The grep counts include `def`s and are not audit counts.
- **G2, [L52Statement.lean:71-73](../lean/HamiltonsCubic/Results/L52Statement.lean#L71).** "The equality clause is not typed here" lists `L52_record_eq` and `L52_record_if` only, omitting `L52_eq_diagonalises` in the same file and L52IfPsi.lean's `coordDiag_frame`, `L52_if_psi` and `coordDiag_of_Mpair`, which is where the stipulated "if" half now lives.
- **G3, [L52RecordEq.lean:69-70](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L69) and [:18-19](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L18).** The docstring's "is an eigenbasis of `K`" is one hand step past the declared off-diagonal vanishing (`K w_l = (w_lᵀ K w_l) w_l` by completeness). True, and a two-line corollary would close it, or the docstring can say "diagonalises `K`" as the row does.

## What would break each claim, and what was done

- **Claim 1:** an equality-attaining complete `w` with `w_kᵀ K w_l ≠ 0`. This needs `diag_block` to fail at non-eigen vectors or `Sum.inr` to index something other than `diag w_k`. Read `diag_block`'s signature (no eigen hypothesis) and `S2Idx`'s definition. None.
- **Claim 2:** a complete `w` with `WᵀKW` off-diagonal zero that is not an eigenbasis. Impossible for orthonormal `w` by the expansion in §1. For the S² versus S²₀ mismatch, the object is `wK` omitting `𝟏/√n` at a degenerate kernel, already owed.
- **Claim 3:** an index quadruple where `IsCoordDiag` asks for zero and no `Mpair` entry covers it. Traced all six cases (two repeated, four orderings) and the disjunct mapping. None, and the kernel agrees.
- **Claim 4:** a r1670 gap line still carrying its defect. Read each cited line at HEAD. None.
- **Claim 5:** a passage without a count, or a claim contradicting another. Split the row at full stops and listed every count. Six uncounted passages (G1).
- **Claim 6:** a statement of the record's L52 neither declared nor owed. Walked bispectral.md:75-83 clause by clause. None.
- **Claim 7:** a sentence naming the equality clause's files incompletely. Found (G2).
- **Claim 8:** `sorryAx` or `Lean.ofReduceBool`. Ran the audit. None.
