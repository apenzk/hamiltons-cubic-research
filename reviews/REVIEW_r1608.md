# Review r1608: L122's pair block geometry (Results/L122Pair.lean), commit 8da63ac3, and r1605's and r1606's repairs (Results/L126Main.lean and text), commit ba03c3da

**Standfirst.** [L122Pair.lean](../lean/HamiltonsCubic/Results/L122Pair.lean) proves the Gram matrix of the pair basis f_i = φ_ji ⊙ φ_ki (`pair_gram`, ⟨f_i, f_i'⟩ = 2δ), its Ricci contraction (`ric_pairBasis`, `pair_ric`, `pair_ricciFlat_iff`, Σ c_i at (j,k) and (k,j)) and the invariance of the pair span under M ∘ (`foxProd_sum_right`, `pair_invariant`). [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean) gains `sphere_isCritical2`, `L126_kernel_orbit` and `L126_block_meets_iff`, and `L126_sphere` now carries the HasDerivAt conjunct. Every theorem is faithful to the record, the whole-block sphere clause is the record's "met only at S³ × S³", and both modules build and rest on the standard three. What remains is a stale "still absent" sentence in L122Statement.lean, a kernel clause in L126Main that is the algebraic identity only, and one input to `hcap` that the L122 owed list does not name.

| Claim | Verdict |
|---|---|
| A-1. `pair_gram` is the record's "orthogonal of common norm √2" | **CONFIRMED** |
| A-2. `ric_pairBasis` by hand, and `pair_ric`/`pair_ricciFlat_iff` are the record's "Ricci cut on this block is exactly Σ x_i = 0" | **CONFIRMED** |
| A-3. `pair_invariant` is the invariance of the pair span | **CONFIRMED** |
| A-4. `L126_block_meets_iff` composes general_LeLin_iff, theta_of_unit, L126_threshold and recip_iff_three_three, and is the record's whole-block "met only at S³ × S³" | **CONFIRMED** |
| A-5. `L126_kernel_orbit` states ker DF = E_½(L_e) and orbit-freeness faithfully | **CONFIRMED WITH GAPS** |
| A-6. `sphere_isCritical2` and the fuller `L126_sphere` | **CONFIRMED** |
| A-7. r1605's and r1606's gaps closed as the commit message claims | **CONFIRMED WITH GAPS** |
| A-8. The L126 row's **proved** stands, and the L122 row is honest about what is owed | **CONFIRMED WITH GAPS** |
| B. Build and axiom audit | **CONFIRMED** |
| C. Downstream text | **CONFIRMED WITH GAPS** |
| D. Style | **CONFIRMED WITH GAPS** |

**Summary:** the new mathematics is correct and faithful on the standard three, and the gaps are one stale sentence in L122Statement.lean, the kernel clause of `L126_kernel_orbit` carried without the derivative it names, an unnamed Weyl-membership input to `hcap`, and a mid-list insertion in second-order.md.

## 1. Files read

- [L122Pair.lean](../lean/HamiltonsCubic/Results/L122Pair.lean) in full, and the definitions it uses: `inner2`, `phi`, `Ric`, `innerOp` in [WeylReal.lean:39-135](../lean/HamiltonsCubic/Base/WeylReal.lean#L39), `rk2` in [L121Block.lean:102](../lean/HamiltonsCubic/Results/L121Block.lean#L102), `pairBlock` in [L122Block.lean:57](../lean/HamiltonsCubic/Results/L122Block.lean#L57).
- The ba03c3da diff of [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean), and the statements it composes: `general_LeLin_iff` ([L126GenBridge.lean:61](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L61)), `L126_threshold` ([L126Sphere.lean:100](../lean/HamiltonsCubic/Results/L126Sphere.lean#L100)), `recip_iff_three_three` ([L126Statement.lean:103](../lean/HamiltonsCubic/Results/L126Statement.lean#L103)), `theta_of_unit` ([Families.lean:636](../lean/HamiltonsCubic/Base/Families.lean#L636)), `critMap`, `critMap_hasDerivAt`, `critMap_kernel_iff` ([L126Kernel.lean:26-75](../lean/HamiltonsCubic/Results/L126Kernel.lean#L26)), `LeLin` ([L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean#L87)).
- [second-order.md:1211-1240](../findings/second-order.md#L1211), Lemma L122, and [second-order.md:1695-1712](../findings/second-order.md#L1695), Lemma L126.
- [lean/INDEX.md](../lean/INDEX.md) rows L122 (356), L122 statement (357), L126 (482), L126 statement (483), L26 (544), at HEAD.
- [REVIEW_r1605.md](REVIEW_r1605.md) and [REVIEW_r1606.md](REVIEW_r1606.md), their gap lists.

## 2. The pair block geometry (A-1 to A-3)

1. **Normalisation.** `inner2 X Y = ½ tr(XᵀY)` makes {φ_ab : a < b} orthonormal, and `innerOp R S = ½ Σ_{a,b} inner2(R φ_ab, S φ_ab)` is the Hilbert-Schmidt pairing over that basis. `rk2 U V = X ↦ ⟨V,X⟩U + ⟨U,X⟩V` is U ⊗ V + V ⊗ U, with no ½. For orthonormal U ⊥ V this has squared norm 1 + 1 + 2⟨U⊗V, V⊗U⟩ = 2, and for distinct i, i' outside {j,k} the four bivectors φ_ji, φ_ki, φ_ji', φ_ki' are pairwise orthogonal, so the cross Gram entries vanish. `pair_gram`'s 2δ is therefore the record's *"orthogonal of common norm √2"* ([second-order.md:1223](../findings/second-order.md#L1223)) under the record's convention for e ⊙ e', the same one r1606 A-3 confirmed for `pairBlock`.
2. **`ric_pairBasis` by hand.** `Ric R a b = Σ_c inner2(R φ_ac, φ_bc)`. With U = φ_ji, V = φ_ki, this is Σ_c [⟨V,φ_ac⟩⟨U,φ_bc⟩ + ⟨U,φ_ac⟩⟨V,φ_bc⟩]. Using ⟨φ_ki, φ_ac⟩ = δ_ka δ_ic − δ_kc δ_ia, the first sum is Σ_c (δ_ka δ_ic − δ_kc δ_ia)(δ_jb δ_ic − δ_jc δ_ib) = δ_ka δ_jb, the three other products each forcing two of the distinct indices i, j, k to coincide. The second sum is δ_ja δ_kb by symmetry. So Ric f_i = E_kj + E_jk, which is the statement. At a = b both terms vanish since j ≠ k.
3. **The Ricci cut.** `pair_ric` extends by linearity, and `pair_ricciFlat_iff` reads the (k,j) entry, giving Ric(Σ c_i f_i) = 0 iff Σ c_i = 0 for any index set s avoiding j and k. In the coordinates x_i of the basis f_i this is the record's *"Ricci cut on this block is exactly Σ_i x_i = 0"*, the 𝟏^⊥ of the displayed matrix. The theorem holds for every s, a harmless strengthening. **What it does not state** is that the rest of the Weyl conditions hold on the span, namely first Bianchi and bivector preservation. They do hold (each f_i component R_{jiki} carries a repeated index, and b(j,i,k,i) = R_jiki + R_jkii + R_jiik = 0), so the Weyl part of the block is exactly {Σ c_i = 0}, but this is untyped, see §7 gap 3. The record's clause names only the Ricci cut, so fidelity is intact.
4. **Invariance.** `foxProd_sum_right` is a clean induction using `foxProd_add_right`, `foxProd_smul_right` and linearity hypotheses built in place. `pair_invariant` applies it and then `pairBlock` termwise, so M ∘ (Σ c_i f_i) = Σ c_i · ½((w_ji + w_ki − w_jk) f_i + Σ_q w_iq f_q) on every bivector. The q-sum ranges over all of ι, and the q ∈ {j, k, i} terms vanish (φ_jj = φ_kk = 0 makes rk2 zero, w_ii = 0), as r1606 A-2 recorded. So the image lies in the span of {f_q : q ∉ {j,k}}, which is the invariance, at the record's "diagonality alone" (symmetric hollow w).

## 3. The L126 repairs (A-4 to A-6)

1. **`L126_block_meets_iff`.** It derives P(M) = θ from `theta_of_unit` and θ > 0 from `theta_sphereProduct_value`, feeds P(M) > 0 to `general_LeLin_iff` (whose right side is D(A,B,C) = P(M)²), rewrites P(M) as θ, turns D(A,B,C) = θ² into 1/(p−1) + 1/(q−1) = 1 by `L126_threshold` (D unfolds to A² + B² + C² − AB − BC − CA, closed by rfl) and that into (p,q) = (3,3) by `recip_iff_three_three`. The composition is exactly the four named theorems. The left side quantifies over every nonzero coefficient triple with x + y + z = 0, which is the whole two-dimensional Bianchi part of the (2,2) four-set block. Together with `L126_sphere`'s first conjunct (every non-(2,2) block has M ∘ v = 0 on its Bianchi part, hence no ½-eigenvector), this is the record's block-level *"met in the two-factor family only at S³ × S³"*, closing the gap r1605 §3 item 6 raised.
2. **`sphere_isCritical2`.** Lifts `sphere_isCritical` to `CurvOp2` through `isCritical2_of_extend` and the congruence on skew arguments. Correct, multiplier t(n − 1).
3. **`L126_sphere`.** The added conjunct is `(split_DF …).2.1`, the HasDerivAt of s ↦ ⟨Z, critMap(M + s v)⟩ with value ⟨Z, 2M∘v − P(M)v⟩ at every test Z. The sphere clause now states the derivative it names. Confirmed.
4. **`L126_kernel_orbit`.** The orbit conjuncts are `orbit_in_pairBlock` and `orbit_perp_fourSet`, the record's *"the orbit tangent for the (j,k) generator lies in the {j,k} pair block"* and the orthogonality to every φ_ab ⊙ φ_cd on disjoint pairs. Faithful. **The kernel conjunct is `critMap_kernel_iff` alone**: 2M∘H − P(M)H = 0 ↔ L_e H = ½H at P(M) ≠ 0, for every H and at an arbitrary diagonal weight, with no criticality hypothesis, no tangency hypothesis and no derivative. critMap(W) = Q(W) − P(W)W has derivative 2M∘H − P(M)H − DP(M)[H]·M, and the last term vanishes only at a critical M on H ⊥ M, which is `critMap_hasDerivAt`'s hypotheses. The docstring ([L126Main.lean:92](../lean/HamiltonsCubic/Results/L126Main.lean#L92)) and file header ([line 20](../lean/HamiltonsCubic/Results/L126Main.lean#L20)) say *"on the tangent space ker DF(M) is the ½-eigenspace of L_e"*, so the theorem names a derivative it does not contain, the same defect r1605 §3 item 6 found in `L126_sphere` and which ba03c3da repaired there. `critMap_hasDerivAt` on the whole tangent space is still composed nowhere in L126Main, so r1605 A-1 ("restated in L126Main only along four-set Bianchi directions") is unchanged. The clause is true and proved in [L126Kernel.lean](../lean/HamiltonsCubic/Results/L126Kernel.lean), so this is packaging, not mathematics.

## 4. The rows and r1605/r1606 (A-7, A-8)

- **r1605.** Gaps 1 to 3 (the omitted clauses, block level, derivative at the sphere) are closed except as in §3 item 4. Gaps 4 to 7 and 9: the L126 row's scope now names unit norm (`hn`), the statement row names L126Main and no longer points to an owed list, L126Statement.lean names L126Main, second-order.md's L126 note names L126Main, and the L26 row points to `L126_block_meets_iff`. Gap 8, the orphan line now at [second-order.md:1709](../findings/second-order.md#L1709), stands, and the commit says so explicitly.
- **r1606.** Gap 1 (span invariance) is closed by `pair_invariant`. Gap 2: the L122 row now says the Kirchhoff form needs the n − 2 Ricci rows and *"no theorem composes the two"*. Gap 3: the norms, Ricci cut and invariance are now proved (8da63ac3), and the owed list names the orbit θ/2 eigenvector and the maximiser inequality. Gap 4: the L122 statement row and L122Statement.lean point to L122Block.
- **The L126 row's "proved"** stands: every clause of the record's statement is a sorry-free theorem on the standard three, and the block-level form is now composed.
- **The L122 row's owed list** is honest about the orbit eigenvector and the maximiser inequality. It omits the Weyl membership of the span (Bianchi and bivector preservation of Σ c_i f_i), which together with `pair_ricciFlat_iff` identifies the block's Weyl subspace, the domain on which `hcap` is read. The Kirchhoff composition is disclosed earlier in the row rather than in the owed sentence, which is acceptable.

## 5. Soundness (B)

- `cd lean && ~/.elan/bin/lake build HamiltonsCubic.Results.L122Pair HamiltonsCubic.Results.L126Main`: *Build completed successfully (8798 jobs)*. Warnings only from unrelated linters in other files.
- `python3 scripts/misc/axiom_audit.py --only L122Pair.lean`: 6/6 clean on the standard three. `--only L126Main.lean`: 5/5 clean on the standard three. No `sorry`, no `native_decide`.

## 6. Downstream (C) and style (D)

- [L122Statement.lean:60-63](../lean/HamiltonsCubic/Results/L122Statement.lean#L60): *"Still absent here: the common norm √2 of the f_i, and the claim that the Ricci cut on the block is the Σ x_i = 0 of that matrix"*. Both are now proved in L122Pair.lean (8da63ac3 did not touch this file), and the sentence does not point there.
- [lean/INDEX.md:357](../lean/INDEX.md#L357), the L122 statement row, names L122Block but not L122Pair. True as written, and a pointer would help.
- [second-order.md:1704](../findings/second-order.md#L1704): the inserted *"all composed as `L126_general`, `L126_sphere` and `L126_block_meets_iff` in L126Main.lean"* sits after `nonsplit_kill` and before the `split_LeLin`, `split_DF` and `general_LeLin_iff` items it also composes, so the sentence reads as if those came after the composition. A placement fix.
- No em dash in L122Pair.lean, L126Main.lean or the changed INDEX rows. The semicolons in the L122 and L126 rows separate list items that carry commas. No backticks inside markdown link text in the changed text. INDEX rows are single lines, and second-order.md's changed line is one paragraph.

## 7. Gaps

1. [L122Statement.lean:60-63](../lean/HamiltonsCubic/Results/L122Statement.lean#L60) still lists the √2 norm and the Ricci cut as absent without pointing to L122Pair.lean, where both are proved.
2. [L126Main.lean:92-104](../lean/HamiltonsCubic/Results/L126Main.lean#L92): `L126_kernel_orbit`'s first conjunct is `critMap_kernel_iff`, an algebraic identity with no criticality, tangency or derivative, while its docstring and [line 20](../lean/HamiltonsCubic/Results/L126Main.lean#L20) call it ker DF(M) on the tangent space. `critMap_hasDerivAt` is not composed, so r1605 A-1 is unchanged and the commit title's "carries every clause" overstates by that much.
3. [lean/INDEX.md:356](../lean/INDEX.md#L356): the owed list omits the Weyl membership of the pair span (first Bianchi and bivector preservation of Σ c_i f_i), which `hcap` needs alongside `pair_ricciFlat_iff`.
4. [second-order.md:1704](../findings/second-order.md#L1704): the "all composed as … in L126Main.lean" clause is inserted mid-list, before items it also composes.
5. [second-order.md:1709](../findings/second-order.md#L1709): r1605 gap 8, the orphan line, still stands, declared as left to the research session.

## 8. Final verdict

**CONFIRMED WITH GAPS.** `pair_gram`, `ric_pairBasis`, `pair_ric`, `pair_ricciFlat_iff`, `foxProd_sum_right` and `pair_invariant` are correct and faithful to Lemma L122 at diagonality alone, `L126_block_meets_iff` is the record's whole-block "met only at S³ × S³" composed from exactly the four named theorems, both modules build and rest on the standard three, and the L126 row's **proved** stands. The gaps are packaging and text: a stale "still absent" in L122Statement.lean, a kernel clause in L126Main that names a derivative it does not state, an unnamed Weyl-membership input to `hcap`, a misplaced insertion, and r1605's declared orphan line.
