# Review r1602: L126's clause at a general diagonal M, and r1601's repairs (commit 4324443e)

**Standfirst.** [L126General.lean](../lean/HamiltonsCubic/Results/L126General.lean) proves that at a symmetric weight w, four distinct indices and any θ > 0, some nonzero Bianchi vector v of the four-set span satisfies `foxProd (diagOp w) v = (θ/2) v` on every bivector exactly when D(A,B,C) = θ², with A, B, C the opposite-pair sums. That is the record's spectral clause of Lemma L126 once θ is read as P(M), and it was checked by hand, including both directions of `G_eigen_iff` and the coordinates of `span_coords`. The module builds and audits 4/4 on the standard three. The five r1601 gaps are closed. What remains is that the reading "that is L_e v = ½ v" rests on θ = P(M), which the theorem leaves free, and the bridge from the matrix layer to `LeLin` and `DF(M)` on `CurvOp2` at a general diagonal M is owed without being named as such.

| Claim | Verdict |
|---|---|
| A-1. `G_eigen_iff`: G has an eigenvector in 𝟏^⊥ with eigenvalue θ > 0 iff D = θ² | **CONFIRMED** |
| A-2. `span_coords`: x a + y b + z c sends φ_ij, φ_ki, φ_il to x φ_kl, y φ_jl, z φ_jk | **CONFIRMED** |
| A-3. `general_meets_iff` states the record's clause "a four-set block meets the ½-eigenspace of L_e exactly when Σ_ijkl = θ²" | **CONFIRMED WITH GAPS** |
| A-4. D is the record's Σ_ijkl, with A, B, C matched to G's slots | **CONFIRMED** |
| A-5. θ as a free positive parameter is a faithful generalisation | **CONFIRMED WITH GAPS** |
| A-6. r1601's five gaps repaired accurately | **CONFIRMED** |
| A-7. The rows are honest about what remains owed | **CONFIRMED WITH GAPS** |
| B. Build and axiom audit | **CONFIRMED** |
| C. Downstream text | **CONFIRMED** |
| D. Style | **CONFIRMED WITH GAPS** |

**Summary:** the clause at a general diagonal M is sound and faithful at the matrix layer with θ free, r1601's repairs are accurate, and the gaps are that "L_e v = ½ v" is prose resting on an untyped θ = P(M) and that the general-M bridge to `LeLin` and `DF(M)` is owed under a vague "one composing statement".

## 1. Files and commit

- [L126General.lean](../lean/HamiltonsCubic/Results/L126General.lean): `G_eigen_iff`, `span_coords`, `phi_entry`, `general_meets_iff`, new in 4324443e and imported at [HamiltonsCubic.lean:548](../lean/HamiltonsCubic.lean#L548).
- Repairs: [L126Final.lean:16-17](../lean/HamiltonsCubic/Results/L126Final.lean#L16), [L126DF.lean:7](../lean/HamiltonsCubic/Results/L126DF.lean#L7), lines 158 and 190, [L126Statement.lean:57-60](../lean/HamiltonsCubic/Results/L126Statement.lean#L57), [lean/INDEX.md:482-483](../lean/INDEX.md#L482), [second-order.md:1704](../findings/second-order.md#L1704).

## 2. G_eigen_iff by hand (A-1)

- G = [[A, C, B], [C, B, A], [B, A, C]] (`Gv` at [L121.lean:32](../lean/HamiltonsCubic/Results/L121.lean#L32)), and on 𝟏^⊥ it satisfies G² = D·I (`G_sq_perp`).
- **Forward.** Gx = θx with x ∈ 𝟏^⊥ gives θ²x = G²x = Dx, so (θ² − D)x = 0, and x ≠ 0 forces D = θ². This holds at every θ, positivity is spent only backwards.
- **Backward.** For u ∈ 𝟏^⊥ put x = Gu + θu. Then x ∈ 𝟏^⊥ (G preserves 𝟏^⊥) and Gx = G²u + θGu = θ²u + θGu = θx. So x is an eigenvector whenever it is nonzero.
- **Both cannot vanish.** At u₁ = (1, −1, 0), Gu₁ = (A − C, C − B, B − A), so x₁ = (A − C + θ, C − B − θ, B − A). At u₂ = (0, 1, −1), Gu₂ = (C − B, B − A, A − C), so x₂ = (C − B, B − A + θ, A − C − θ). If both vanish, the third slot of x₁ gives B = A and the second slot of x₂ gives B − A + θ = 0, so θ = 0, against θ > 0. These are exactly the four coordinates the proof extracts (a1, a3, b1, b2), and linarith closes on a3 and b2. Structurally: u₁ and u₂ span 𝟏^⊥, so both vanishing would make G = −θ·I on 𝟏^⊥, whose trace is 0 since tr G = A + B + C is carried by 𝟏.

## 3. span_coords and the slot match (A-2, A-4)

- rk2 U V X = ⟨V, X⟩U + ⟨U, X⟩V. At X = φ_ij only the term with a factor φ_ij survives, since the six pairs of a four-set are distinct and ⟨φ_ab, φ_cd⟩ vanishes for distinct pairs. So S(φ_ij) = x φ_kl, S(φ_ki) = y φ_jl, S(φ_il) = z φ_jk. Correct, and `phi_entry` reads the coefficient off entry (q, p) of c φ_pq.
- `fourSet_span` ([L121Block.lean:289](../lean/HamiltonsCubic/Results/L121Block.lean#L289)) gives the a, b, c coefficients (w_ij + w_kl)x + (w_il + w_jk)y + (w_ik + w_jl)z, then (w_il + w_jk)x + (w_ik + w_jl)y + (w_ij + w_kl)z, then (w_ik + w_jl)x + (w_ij + w_kl)y + (w_il + w_jk)z. With A = w_ij + w_kl, B = w_ik + w_jl, C = w_il + w_jk these are Ax + Cy + Bz, Cx + By + Az, Bx + Ay + Cz, the three slots of `Gv`. So M∘v = ½ G(x, y, z) in coordinates, and M∘v = (θ/2)v iff G(x, y, z) = θ(x, y, z).
- The record's L121 ([second-order.md:1199-1200](../findings/second-order.md#L1199)) sets A = M_ij + M_kl, B = M_ik + M_jl, C = M_il + M_jk and Σ = A² + B² + C² − AB − BC − CA, with first Bianchi exactly 𝟏^⊥. D is that Σ and is symmetric in A, B, C, so no labelling choice matters.

## 4. Fidelity of general_meets_iff (A-3, A-5)

- The record ([second-order.md:1699](../findings/second-order.md#L1699)): at a diagonal critical M of unit norm with θ = P(M) > 0, ker DF(M) is the ½-eigenspace of L_e, which a four-set block meets exactly when Σ_ijkl = θ². L_M = M∘ has block eigenvalues ±½√Σ on the Bianchi part, and L_e = M∘/θ, so L_e v = ½v iff M∘v = (θ/2)v iff ½√Σ = θ/2 iff Σ = θ². The Lean statement is that equivalence with the eigenspace taken inside the Bianchi part of the block, which is where the record's tangent space meets the block (the 𝟏 direction fails first Bianchi).
- **θ free.** The equivalence is a spectral fact about G at any θ > 0, and criticality and unit norm are not used by it. Instantiating θ := P(M) recovers the record's clause, so the generalisation is faithful and strictly stronger at the matrix layer.
- **Gap.** The reading "that is L_e v = ½ v with e = M/θ" at [L126General.lean:11](../lean/HamiltonsCubic/Results/L126General.lean#L11) and [L126General.lean:101-102](../lean/HamiltonsCubic/Results/L126General.lean#L101), repeated in the row at [lean/INDEX.md:482](../lean/INDEX.md#L482), holds only when θ = P(M), which the theorem does not impose. And the statement lives on `Matrix ι ι ℝ` with `foxProd (diagOp w)`, while L_e is `LeLin` on `CurvOp2` with e = P(M)⁻¹M. At the sphere product that bridge is `split_LeLin`, at a general diagonal M it is untyped, as are `critMap_hasDerivAt`'s hypotheses there (v self-adjoint, ⟨M, v⟩ = 0, v Weyl). All are true by hand for the block's Bianchi vectors: rk2 of two symmetric-product factors is self-adjoint, φ_ij ⊙ φ_kl with disjoint pairs is orthogonal to every pair-diagonal operator and Ricci-traceless. The docstrings should say "when θ = P(M)", and the row's Owed should name the general-M bridge.

## 5. r1601's repairs and the rows (A-6, A-7)

- Gap 1: [L126Final.lean:16-17](../lean/HamiltonsCubic/Results/L126Final.lean#L16) now points to `split_DF` as discharging the hypotheses. Accurate.
- Gap 2: [L126DF.lean:7](../lean/HamiltonsCubic/Results/L126DF.lean#L7), 158 and 190 say "orthogonal to M", which is what `hperp : innerOp2 M v = 0` proves, and row 482 owes v's Weyl property with Ricci-flatness untyped. Accurate.
- Gaps 3 to 5: [second-order.md:1704](../findings/second-order.md#L1704), [L126Statement.lean:57-60](../lean/HamiltonsCubic/Results/L126Statement.lean#L57) and row 483 now name L126Final, L126DF and L126General. Accurate.
- Row 482's former Owed item, the clause at a general diagonal M, is correctly removed and replaced by the `general_meets_iff` sentence, "4/4 on the standard three" matches the audit, and **partial** with "statement: not typed" remains right. The remaining Owed text, "one statement composing these files", is honest but does not say that at a general M the composition needs a general-M `split_LeLin` and θ = P(M) (§4).

## 6. Soundness (B)

- `lake build HamiltonsCubic.Results.L126General`: exit 0, 8793 jobs, warnings only (unused decidable linter).
- `axiom_audit.py --only L126General.lean`: 4/4 clean, resting on propext, Classical.choice, Quot.sound alone. No `sorry` in the file.

## 7. Downstream (C)

- No remaining "owed at this M and v", "tangency discharged" or "proved here only at sphere products" in lean/INDEX.md, second-order.md or the L126 Lean files. The sphere-product phrase at [second-order.md:1806](../findings/second-order.md#L1806) concerns L27's refinement and is unrelated.
- [L126Statement.lean](../lean/HamiltonsCubic/Results/L126Statement.lean)'s list is current.

## 8. Style (D)

- No em dashes in the touched Lean files or the changed rows. No backticks inside link text. The changed markdown rows and paragraph are single lines.
- The new semicolons in rows 482 and 483 separate list items that carry commas, which is their permitted use. The "; standard three axioms" splices in row 482 predate this commit (flagged at r1598).
- **Gap (cosmetic).** Row 483 reads "(`split_LeLin`) [L126Final.lean](...) giving", a missing comma between two list items.

## Verdict

**CONFIRMED WITH GAPS.** `general_meets_iff` is sound and states the record's four-set clause at a general diagonal M at the matrix layer, with θ free and faithful on instantiation θ = P(M), and r1601's five gaps are closed. The gaps are that the L_e reading rests on θ = P(M) in prose, the general-M bridge to `LeLin` and `DF(M)` is owed under an unnamed "composing statement", and a missing comma in row 483.
