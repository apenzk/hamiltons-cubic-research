# Review r1553: L116's "R^# alone does not preserve Bianchi" (commit b12d6784) and its degenerate point on the diagonal locus with r1552's gaps (commit 94c9b669)

**Standfirst.** [L116Sharp.lean](../lean/HamiltonsCubic/Results/L116Sharp.lean) builds, audits 12/12 on the standard three and carries no `sorry`, `admit` or `native_decide`. Both results are faithful to [bounds-relaxations.md](../findings/bounds-relaxations.md#L246)'s Lemma L116 in [L116Statement.lean](../lean/HamiltonsCubic/Results/L116Statement.lean)'s conventions: `Rcp` is a Bianchi curvature operator of W_{ℂP²}'s shape with b(R^#)_{0123} = −12, and `degenerate_diag` is the record's S³ × S³ degeneracy on the whole coordinate-diagonal locus, which is the correction [findings/INDEX-results.md:132](../findings/INDEX-results.md#L132) already recorded. r1552's four gaps are closed. The gaps are one stale header in L116Statement.lean, which still says the failure of R^# alone needs a numerical evaluation, two identifications the prose asserts and the file leaves untyped, and three linter warnings.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `omSD` are the self-dual forms e₁₂+e₃₄, e₁₃+e₄₂, e₁₄+e₂₃ under 0-based indexing, and `Rcp` has W_{ℂP²}'s shape | **CONFIRMED** (the shape is prose, see gap 2) |
| A-1b | `Rcp_bianchi`, `Rcp_sq_0123` and `sharp_not_bianchi` establish "R^# alone does not preserve Bianchi" with `comp`'s ½ and Böhm–Wilking's `sharp` | **CONFIRMED** |
| A-1c | the proof depends on the duality choice | **CONFIRMED** (it needs the three forms of one duality, not self-duality as such) |
| A-2a | `diagT_bianchi`, `comp_diagT`, `degenerate_diag` generalise the record's degenerate point correctly | **CONFIRMED** |
| A-2b | S³ × S³'s Weyl tensor is a `diagT w` with w symmetric hollow | **CONFIRMED WITH GAP** (true by hand, not typed) |
| A-3 | the L116 row at HEAD is accurate, its owed list complete, and partial is right | **CONFIRMED WITH GAP** (the false inference is carried by no named owed item) |
| A-4 | r1552 gaps 1–4 closed | **CONFIRMED** |
| B | build, axiom audit, no `sorry`/`admit`/`native_decide`, heartbeat comment | **CONFIRMED** (three linter warnings, gap 4) |
| C | no downstream text still calls the L116Sharp items untyped | **GAP** ([L116Statement.lean:39–47](../lean/HamiltonsCubic/Results/L116Statement.lean#L39)) |
| D | style of the markdown edits | **CONFIRMED** |

**Summary:** both theorems are sound and faithful, r1552 is fully repaired, and the defects are one stale file header and three minor residues.

## 1. Fidelity of `Rcp` and `sharp_not_bianchi` (A-1)

- **The forms.** `omSD 0` has (0,1) = 1 and (2,3) = 1, which is e₁₂ + e₃₄ one-based. `omSD 1` has (0,2) = 1 and (1,3) = −1, which is e₁₃ − e₂₄ = e₁₃ + e₄₂. `omSD 2` has (0,3) = 1 and (1,2) = 1, which is e₁₄ + e₂₃. With orientation e₁₂₃₄, ⋆e₁₂ = e₃₄, ⋆e₁₃ = e₄₂ and ⋆e₁₄ = e₂₃, so all three are self-dual. The docstring at [L116Sharp.lean:25](../lean/HamiltonsCubic/Results/L116Sharp.lean#L25) is accurate.
- **The shape.** Each ω_a is an orthogonal complex structure, so Σ_j ω_a(i,j) ω_a(k,j) = δ_ik and Ric(Rcp) = (Σ μ_a) δ = 0. Rcp is therefore a trace-free symmetric operator on Λ⁺, zero on Λ⁻, which is W⁺-type Weyl with eigenvalues proportional to (2, −1, −1), the Kähler form carrying the 2. That is W_{ℂP²}'s shape up to scale. None of this is typed in the file (gap 2).
- **Bianchi.** b(ω ⊗ ω) is `wedgeSelf ω`, totally skew, so at n = 4 only the 0123 component matters, and there each ω_a gives ω₀₁ω₂₃ + ω₀₂ω₃₁ + ω₀₃ω₁₂ = 1. Hence b(Rcp)₀₁₂₃ = Σ μ_a = 0. `Rcp_bianchi` checks all 256 cases in the kernel.
- **The square.** The ω_a have disjoint supports with four unit entries each, so Σ_{pq} ω_a(p,q) ω_b(p,q) = 4δ_ab and, with `comp`'s ½, Rcp² = 2 Σ μ_a² ω_a ⊗ ω_a. Then b(Rcp²)₀₁₂₃ = 2(4 + 1 + 1) = 12, which is `Rcp_sq_0123`.
- **The conclusion.** `sharp_not_bianchi` applies [L116Statement.lean:191](../lean/HamiltonsCubic/Results/L116Statement.lean#L191)'s `L116` with all four hypotheses discharged (`Rcp_skew₁`, `Rcp_skew₂`, `Rcp_pair`, `Rcp_bianchi`), so b(Rcp^#)₀₁₂₃ = −12 and `sharp Rcp` fails first Bianchi. Since `sharp` is Böhm–Wilking's (4) and Rcp lies in S²_B, this is exactly "the vector field R ↦ R^# does not preserve S²_B", which is what the record's "R^# alone does not" asserts.
- **Dependence on the duality choice.** Bianchi needs the three ω_a ∧ ω_a to be equal, cross terms being absent from a diagonal sum. Replacing e₁₃ + e₄₂ by the anti-self-dual e₁₃ + e₂₄ gives b₀₁₂₃ = 2 − (−1) − 1 = 2 ≠ 0, so `Rcp_bianchi` would fail. Three anti-self-dual forms would work equally. The proof depends on the forms sharing one duality, and the chosen forms do.

## 2. The diagonal locus (A-2)

- `diagT w` is w_ij(δ_ik δ_jl − δ_il δ_jk), the operator e_ij ↦ w_ij e_ij on Λ². Each e_ij ∧ e_ij vanishes, so `diagT_bianchi` is the standard fact that a curvature operator diagonal in the e_ij basis is Bianchi. `comp_diagT` is correct: the terms p = i, q = j and p = j, q = i each give ½ w_ij², summing to w_ij². `degenerate_diag` then gives b(D²) = b(D_{w∘w}) = 0 and b(D^#) = −0 through `L116`.
- The hollow hypothesis `hh` is superfluous in both `diagT_bianchi` and `comp_diagT`, since `diagT w i i k l` vanishes identically. It restricts nothing, as any w can be made hollow without changing `diagT w`. Observation only.
- **S³ × S³.** At the product of unit spheres, R_ijij is 1 within a factor and 0 across. The product is Einstein with scal = 12 at n = 6, so W = R − (scal/(n(n−1))) · Id on Λ², giving w = 3/5 within a factor and −2/5 across, symmetric and hollow, in an adapted orthonormal frame. `bianchi`, `comp` and `sharp` are O(n)-equivariant, so vanishing in that frame is vanishing. The generalisation is correct and covers S³ × S³. **Gap 2 (minor)**: this instance is argued only in prose at [L116Sharp.lean:17](../lean/HamiltonsCubic/Results/L116Sharp.lean#L17) and in the row. An `example` on `Fin 6` with that weight would type it in a few lines.

## 3. The L116 row (A-3)

- [lean/INDEX.md:469](../lean/INDEX.md#L469) states `Rcp_bianchi`, `Rcp_sq_0123`, `sharp_not_bianchi`, `degenerate_diag` and the 12/12 audit correctly, and names the untyped symmetries of `rankOne vW`.
- Partial is right: "What M actually is" (the formula ⟨x, Mx⟩ = ⟨L_W X, X⟩ and the C₅ ratio 1.206011) and the ℂP³/ℂP⁴ values 0.962 and 0.953 are unproved.
- **Gap 3 (minor)**: the record's "the inference Q(W) = θW is Bianchi, hence b(W²) = 0, is therefore false" needs a Weyl W with Q(W) = θW and b(W²) ≠ 0. r1552 read it as carried by the numerics. Rcp now comes within two identifications of witnessing it: Ricci-flatness (section 1) and Q(Rcp) = θ Rcp, which [Base/CP2Sharp.lean](../lean/HamiltonsCubic/Base/CP2Sharp.lean) proves for the layer's W_{ℂP²} in another representation. The row should say which owed item carries the false inference, either the numerics or an identification of Rcp with CP2Sharp's W.

## 4. r1552's gaps (A-4)

- **Gap 1 closed.** The L167 main row ([lean/INDEX.md:246](../lean/INDEX.md#L246)) ends `statement: not typed`.
- **Gap 2 closed.** The L116 row names "the antisymmetries and pair symmetry of `rankOne vW`" as untyped, citing r1552. [L116Witness.lean](../lean/HamiltonsCubic/Results/L116Witness.lean) does not name them, which r1552 accepted from either place.
- **Gap 3 closed.** [L167.lean:15](../lean/HamiltonsCubic/Results/L167.lean#L15) now points at `parity_splits` ([L167Statement.lean:69](../lean/HamiltonsCubic/Results/L167Statement.lean#L69)) and `stab_mixed_trivial` ([L167Mixed.lean:93](../lean/HamiltonsCubic/Results/L167Mixed.lean#L93)). Both exist.
- **Gap 4 closed.** [L54Rigid.lean:23](../lean/HamiltonsCubic/Results/L54Rigid.lean#L23) now points at `dpsi_split` and `L54_rigidity_S20` in [L54Diag.lean](../lean/HamiltonsCubic/Results/L54Diag.lean), both present (lines 44 and 95). The dropped sentence on a shared extra entry is explanation the new pointer makes unnecessary.
- The minor L167Statement.lean pointer from r1552 is also made.

## 5. Soundness (B)

- `lake build HamiltonsCubic.Results.L116Sharp`: success.
- `axiom_audit.py --only L116Sharp.lean`: 12/12 clean, resting on propext, Classical.choice and Quot.sound alone.
- No `sorry`, `admit` or `native_decide` in the file.
- `set_option maxHeartbeats 8000000 in` on `Rcp_bianchi` ([L116Sharp.lean:37](../lean/HamiltonsCubic/Results/L116Sharp.lean#L37)) carries its reason on the next line, the layout [L178Theta.lean:43](../lean/HamiltonsCubic/Results/L178Theta.lean#L43) uses, and the build raises no linter complaint about it.
- **Gap 4 (minor)**: the build emits three linter warnings, `(try rw [hw])` and `ring` doing nothing at [L116Sharp.lean:104](../lean/HamiltonsCubic/Results/L116Sharp.lean#L104) and the unused simp argument `if_true` at [L116Sharp.lean:108](../lean/HamiltonsCubic/Results/L116Sharp.lean#L108).

## 6. Downstream (C)

- **Gap 1**: [L116Statement.lean:39–47](../lean/HamiltonsCubic/Results/L116Statement.lean#L39), under "Two things the record says that are not typed here", still says that R^# alone failing to preserve Bianchi "needs a witness curvature operator with b(R^#) ≠ 0, which is the same numerical evaluation", and presents the S³ × S³ degenerate point as the record's alone. Both are now proved analytically in L116Sharp.lean, and the header names neither the file nor its theorems.
- [findings/INDEX-results.md:132](../findings/INDEX-results.md#L132) reads "Lean: partial", matching the row, and its remark that the degeneracy holds on the whole diagonal locus is what `degenerate_diag` proves. [bounds-relaxations.md](../findings/bounds-relaxations.md#L246) carries no Lean status for L116. The L116 statement row ([lean/INDEX.md:470](../lean/INDEX.md#L470)) does not discuss these items.

## 7. Style (D)

The L116 and L167 rows at HEAD are single lines with no em dash, no semicolon splice and no backticks inside link text.

## Verdict

**CONFIRMED WITH GAPS.** Both theorems are sound and faithful to Lemma L116, and r1552's gaps are closed. Gaps:

1. [L116Statement.lean:39–47](../lean/HamiltonsCubic/Results/L116Statement.lean#L39): the header still calls the failure of R^# alone and the degenerate point untyped and numerical, where L116Sharp.lean proves both.
2. [L116Sharp.lean:10](../lean/HamiltonsCubic/Results/L116Sharp.lean#L10) and [:17](../lean/HamiltonsCubic/Results/L116Sharp.lean#L17): "W_{ℂP²}'s shape" and "S³ × S³ among it" are prose, the Ricci-flatness of Rcp and the S³ × S³ weight (3/5 within a factor, −2/5 across) untyped and unnamed as such. Minor.
3. [lean/INDEX.md:469](../lean/INDEX.md#L469): no owed item is named as carrying the false inference "Q(W) = θW is Bianchi, hence b(W²) = 0", which Rcp witnesses once identified with CP2Sharp's W. Minor.
4. [L116Sharp.lean:104](../lean/HamiltonsCubic/Results/L116Sharp.lean#L104) and [:108](../lean/HamiltonsCubic/Results/L116Sharp.lean#L108): three linter warnings. Minor.
