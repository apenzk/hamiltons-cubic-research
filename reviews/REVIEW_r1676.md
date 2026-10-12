# REVIEW r1676: L52, `diag_zero_of_complete` and `S20_basis_diag` (8e86a834), r1675's repairs (530939aa)

**Verdict: CONFIRMED WITH GAPS.** Both new theorems are correct and kernel-checked, the composition with `L52_eq_S20` type-checks, and the audit is 3/3 on the standard three. `S20_basis_diag` states two of the three blocks of "diagonal in `{φ_ab, ψ_k}`": the pair–pair block is left to the hypothesis and its docstring then concludes the whole. L52EqS20.lean's header still calls the restriction owed after 8e86a834 discharged it, and the row's "1/1" for L52EqS20 is now 3/3. r1675's G1 and G2 are repaired, the single Owed item is accurate, and **partial** is right.

## Claims

| # | Claim | Verdict |
|---|---|---|
| 1 | `diag_zero_of_complete` is correct | **CONFIRMED** |
| 2 | `S20_basis_diag` is correct | **CONFIRMED** |
| 3 | `S20_basis_diag`'s conclusion is the record's "`W̊` diagonal in `{φ_ij, ψ_k}` on S²₀" | **CONFIRMED WITH GAP** (G1) |
| 4 | Its ψ–ψ part holds without equality and is stated honestly | **CONFIRMED WITH GAP** (G2, minor) |
| 5 | "when the `v_k` span `𝟏^⊥`" marks the S²₀ reading | **CONFIRMED** |
| 6 | `S20_basis_diag`'s hypothesis is `L52_eq_S20`'s conclusion, so the two compose | **CONFIRMED** (screened) |
| 7 | r1675 G1 and G2 are repaired | **CONFIRMED WITH GAP** (G3: 8e86a834 made the G1 repair's header text stale) |
| 8 | The L52 row is consistent, the single Owed item accurate, **partial** right | **CONFIRMED WITH GAP** (G4, minor) |
| 9 | The staircase witness is within the layer's reach | **CONFIRMED** (declaration sketched in §5) |
| 10 | Axiom audit on L52EqS20.lean | **CONFIRMED**, 3/3 on the standard three (rerun) |

## 1. `diag_zero_of_complete` ([L52EqS20.lean:92-105](../lean/HamiltonsCubic/Results/L52EqS20.lean#L92))

- By hand: `X_aa = Σ_b X_bb δ_ba = Σ_b X_bb Σ_k w_k(b) w_k(a) = Σ_k (Σ_b X_bb w_k(b)) w_k(a) = 0`. The hypothesis `hw` is `WᵀW = I` for the square family, which is the completeness `wK_complete` supplies. The proof follows exactly this chain (`← hw`, `Finset.mul_sum`, `sum_comm`, factor, `h k`).
- `omit hR hskew hsym` is right: the statement is about any matrix and any complete family.

## 2. `S20_basis_diag` ([L52EqS20.lean:107-124](../lean/HamiltonsCubic/Results/L52EqS20.lean#L107))

- **Pair–ψ.** `Bw wK (ringW R) (inl p) (inr k)` unfolds through `ew` ([L52Frame.lean:34](../lean/HamiltonsCubic/Results/L52Frame.lean#L34)) to `frob (ringW R (√2 • symB a b)) (diagonal (wK k))`, and `frob_diag_left` ([L52Frame.lean:43](../lean/HamiltonsCubic/Results/L52Frame.lean#L43)) makes it `Σ_a X_aa wK_k(a)`. `hW` at `inl p ≠ inr k` zeros it for every `k`, `diag_zero_of_complete` gives `diag X = 0`, and `frob_diag_left` again gives `⟨X, diag v⟩ = 0` for every `v`. Correct, and basis-free in `v` as r1675 §2 said.
- **ψ–ψ.** The second conjunct is `psi_block` ([L54Basis.lean:123](../lean/HamiltonsCubic/Results/L54Basis.lean#L123)) at `j ≠ k`, over any index type and any orthonormal eigenfamily. It uses neither `hW` nor any equality.

## 3. Is the conclusion the record's?

- The record's basis is `{φ_ij, ψ_k}` of S²₀ with `ψ_k` an eigenbasis of `K` on `𝟏^⊥` ([bispectral.md:75](../findings/bispectral.md#L75)). "`W̊|S²₀` diagonal" in it has three blocks: pair–pair, pair–ψ, ψ–ψ. Every member is trace-free, so the `frob` entries are the matrix of `W̊|S²₀`.
- The conclusion states pair–ψ and ψ–ψ. **The pair–pair block is absent from the conclusion.** It is `hW (inl p) (inl q)`, since the pair entries of `Bw` do not depend on `w`, so it is one line away, but the theorem does not state it while the docstring ([:109-110](../lean/HamiltonsCubic/Results/L52EqS20.lean#L109)) concludes "so `W̊` is diagonal in `{φ_ab} ∪ {diag v_k}`" (G1). The row repeats that sentence.
- **"when the `v_k` span `𝟏^⊥`".** Spanning `𝟏^⊥` exactly forces each `v_k ∈ 𝟏^⊥`, so with orthonormality this is "an orthonormal eigenbasis of `K` on `𝟏^⊥`", the record's ψ. The theorem is stronger (any orthonormal eigenfamily, `𝟏/√n` allowed), and the phrase correctly marks where the record's S²₀ reading is the special case. Such a family exists since `K𝟏 = 0` at Ricci-flat `W` (`K_row_sum`) and `K` is symmetric, though no declaration builds one at type `Fin (n-1)`. That is existence of the record's own stipulated basis, which the record presupposes, and the universal statement covers every instance.

## 4. Honesty of the ψ–ψ clause

- The docstring puts both clauses under "once `W̊` is diagonal in the basis of `S²` at `wK`", and the ψ–ψ one depends on nothing of the kind. The citation "(`psi_block`)" lets a careful reader infer it, and r1675 §2 recorded it as holding without equality. The docstring and row should say "and, without equality, ..." so the conjunction does not read as consequent on `hW` (G2, minor).

## 5. Composition and the staircase witness

- **Composition (screen).** A scratch file applied `L52_eq_S20 ... hμ`, destructured `⟨hWW, hWK, h⟩`, and fed `(h hω heq).2` to `S20_basis_diag`. `lake env lean` accepts it (exit 0) once the universe of the family index is pinned (`S20_basis_diag.{0}`), `S20_basis_diag` being universe-polymorphic in `m`. So the hypothesis is exactly `L52_eq_S20`'s second conjunct after `let`-unfolding. This is a type-check screen, recorded here and not added to the layer.
- **The staircase witness is the one remaining claim of the block, and the existing objects reach it.** A declaration that discharges it:
  - `staircase_strict`, at `R := diagOp (t • Wabc)` with `Wabc` the symmetric hollow weight `a` on `{12,34}`, `b` on `{13,24}`, `c` on `{14,23}`, `a + b + c = 0` (so `IsWeight`, Ricci-flat), `b ≠ c`, and `t` the normalising scale: `IsCoordDiag R`, `∀ i j k l, bianchi R i j k l = 0`, `normSq R = 1`, `w` the Helmert staircase `(1,−1,0,0)/√2, (1,1,−2,0)/√6, (1,1,1,−3)/√12, (1,1,1,1)/2` with completeness, and `∀ Mp m, hμ → hω → Pcubic R < RHS(L52_record at w)`.
  - Proof route: `L52_record` gives `≤`. `L52_eq_diagonalises` ([L52RecordEq.lean:72](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L72)) gives `w_kᵀKw_l = 0` at equality, and `v₂ᵀKv₁ ∝ (b − c) ≠ 0` (r1669 §5's hand computation) refutes it, so `<`. Nonvacuity of `∀ Mp m` follows from taking the spectral extremes, which the declaration can also exhibit.
  - Existing objects: `diagOp`, `IsWeight`, `diagOp_bianchi`, `diagOp_skew`, `diagOp_selfAdjoint`, `diagOp_normSq_smul` in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean#L147). Missing and short: `IsCoordDiag (diagOp w)` (only `IsCoordDiagonalSomeFrame (diagOp w)` is declared, [Frames.lean:57](../lean/HamiltonsCubic/Base/Frames.lean#L57)), `IsLinOp (diagOp w)`, and `Kmat (diagOp w)` in terms of `w`, then a finite computation of one entry at `n = 4`. Within reach, and the Owed wording is accurate.

## 6. r1675's gaps

- **G1.** The row's clause and the header ([:18-20](../lean/HamiltonsCubic/Results/L52EqS20.lean#L18)) now describe the restriction as the corollary it is, from `frob_diag_left`, `diag_block` and `psi_block`. Repaired at 530939aa. 8e86a834 then discharged it in the same file and left that header sentence saying "a corollary the L52 row lists as owed", which the row no longer lists, and the header's bullet list names only `L52_eq_S20` (G3).
- **G2.** The header ([:14-15](../lean/HamiltonsCubic/Results/L52EqS20.lean#L14)) reads "the basis of `S²` at `wK`". Repaired. The same "record's shared frame in the stipulated basis" wording survives in L52RecordEq's header ([L52RecordEq.lean:15-16](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L15)) and its row clause, where `L52_record_eq` is also read on `S²` at `wK`. Outside r1675's scope, recorded under G4.

## 7. The L52 row

- **Owed.** One item, a Lean witness of the staircase counterexample, citing r1669. `grep -rn staircase lean/HamiltonsCubic` finds only L52RecordEq.lean's header prose. Accurate, and complete against bispectral.md:75-84 now that `S20_basis_diag` covers the S²₀ restriction (modulo G1's one-line pair–pair clause).
- **partial** is right: the staircase claim is a statement of the block with no declaration.
- **Counts.** L52EqS20 is cited as "1/1 on the standard three" after `L52_eq_S20` and "3/3" after the two new theorems. The file audits 3/3. The "1/1" is the file's count before 8e86a834 and now reads as a second, conflicting count for the same file (G4). The other counts in the row were not re-audited here.
- **Downstream.** [L52Statement.lean:74-75](../lean/HamiltonsCubic/Results/L52Statement.lean#L74), the paragraph r1674 G1 made complete, names `L52_eq_S20` and not `S20_basis_diag` (G4).

## 8. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L52EqS20.lean`: **3 declarations, 3/3 clean, the standard three alone.**

## Gaps

- **G1, [L52EqS20.lean:111-115](../lean/HamiltonsCubic/Results/L52EqS20.lean#L111), docstring [:109-110](../lean/HamiltonsCubic/Results/L52EqS20.lean#L109), and [lean/INDEX.md:383](../lean/INDEX.md#L383).** The conclusion omits the pair–pair block, which the docstring and row then include in "diagonal in `{φ_ab} ∪ {diag v_k}`". Fix: add the conjunct `∀ p q, p ≠ q → frob (ringW R (√2 • symB p)) (√2 • symB q) = 0` (it is `hW (inl p) (inl q) (by simpa)`), or say the pair–pair block is `hW` itself.
- **G2 (minor), [L52EqS20.lean:108-109](../lean/HamiltonsCubic/Results/L52EqS20.lean#L108) and the row.** The ψ–ψ clause is placed under "once `W̊` is diagonal", and it needs no hypothesis. Fix: "and, at every orthonormal eigenfamily `v` of `K` and without equality, ...".
- **G3, [L52EqS20.lean:6-20](../lean/HamiltonsCubic/Results/L52EqS20.lean#L6).** The header calls the S²₀ restriction "a corollary the L52 row lists as owed", and lists only `L52_eq_S20`. Fix: add bullets for `diag_zero_of_complete` and `S20_basis_diag` and state the restriction as proved there.
- **G4 (minor), [lean/INDEX.md:383](../lean/INDEX.md#L383), [L52Statement.lean:75](../lean/HamiltonsCubic/Results/L52Statement.lean#L75), [L52RecordEq.lean:15-16](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L15).** The row's "1/1" for L52EqS20 is stale beside "3/3". L52Statement's paragraph omits `S20_basis_diag`. L52RecordEq's header and row clause still call the `S²` basis at `wK` "the record's shared frame in the stipulated basis", the wording r1675 G2 corrected in L52EqS20.

## What would break each claim, and what was done

- **Claim 1:** a complete family whose members are all orthogonal to a nonzero diagonal. Impossible since a complete square family spans ℝⁿ. Derived by hand and read the kernel-checked proof against it.
- **Claims 2 and 6:** a mismatch between `hW`'s `Bw (wK R hR hskew hsym)` and `L52_eq_S20`'s `let w := wK ...`, or an `ew` entry that is not `frob_diag_left`'s form. Screened with a scratch composition file under `lake env lean` (exit 0 after pinning the universe) and unfolded `ew` and `Bw` by hand.
- **Claim 3:** a nonzero off-diagonal entry of `W̊|S²₀` in `{φ, ψ}` that the conclusion does not rule out. The pair–pair entries are such entries as stated (G1), though `hW` rules them out.
- **Claims 4 and 5:** a reading under which the ψ–ψ clause needs equality, or an eigenfamily "spanning `𝟏^⊥`" with a member outside it. Neither exists. Read `psi_block` and `diag_block`.
- **Claims 7 and 8:** stale text in the header or row. Read both at HEAD and grepped `S20_basis_diag`, `L52_eq_S20`, `stipulated basis` and `staircase` under lean/ (G3, G4).
- **Claim 9:** a missing object that would make the witness a new construction. Grepped `diagOp`, `IsWeight`, `IsCoordDiag`, `L52_eq_diagonalises`. Only short glue lemmas are missing.
- **Claim 10:** a non-standard axiom. Reran the audit.

*Analysis-only footing: the runs were the per-file axiom audit and one type-check screen of the composition, each seconds on objects in hand. The staircase computation is r1669's by-hand derivation and was not re-run.*
