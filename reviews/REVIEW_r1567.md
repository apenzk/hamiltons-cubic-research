# Review r1567: L54's (2) on S²₀ in convex form (commit 4d827964) and r1564's repairs (commit 18854704)

**Standfirst.** [L54_majorizes_S20](../lean/HamiltonsCubic/Results/L54Diag.lean#L129) proves Σ g(d) ≤ Σ g(ω) on S²₀ for every convex g at a Ricci-flat R, with d the record's diagonal (d_φ on the pairs, d_ψ = −spec(K on 𝟏^⊥)) and ω the spectrum of W̊ on S²₀. That is the convex form of the record's ω ≻ d, in the right direction, and it carries the equal-sum half through g = ±id. The proof is Schur's convex inequality on S² with the shared g(0) cancelled, checked by hand. Both files build, L54Diag audits 6/6 and L167Full 25/25 on the standard three, with no `sorry`, `admit` or `native_decide`. Commit 18854704 closes r1564's gaps 1 to 4, and `su2_structure` gives [e₀, e₁] = e₂, [e₁, e₂] = e₀, [e₂, e₀] = e₁ for e_a = −K_a/2, checked by hand from the three proved brackets. The gaps are text: the L54 owed item leaves out an index transport that the subset-sum form also needs, and the L167 row is missing a comma.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `L54_majorizes_S20` is the convex form of the record's ω ≻ d on S²₀, direction right | **CONFIRMED** |
| A-1b | d and ω are the record's objects (d_φ on the pairs, d_ψ = −spec(K on 𝟏^⊥), ω = spec(W̊ on S²₀)) | **CONFIRMED** |
| A-1c | the equal-sum half is carried | **CONFIRMED** (implied by g = id and g = −id, stated nowhere and needing no separate statement) |
| A-1d | the owed item "convex form to L54Statement's subset-sum `Majorizes`, the converse half of HLP" is accurate and the only gap for (2) | **CONFIRMED WITH GAP** (accurate direction, but the subset-sum form also needs ω and d on one index type) |
| A-2 | 18854704 closes r1564 gaps 1 to 4, `su2_structure` correct | **CONFIRMED** |
| B | builds, standard three axioms, no sorry/admit/native_decide | **CONFIRMED** |
| C | no downstream text calls (2) on S²₀ untyped or states it differently | **CONFIRMED** |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (a missing comma in the L167 row) |

**Summary:** (2) on S²₀ is proved in convex form, which is the record's majorisation up to the elementary converse of HLP, and r1564's gaps are closed. Two text gaps remain.

## 1. L54's (2) on S²₀

- **The record.** [bispectral.md](../findings/bispectral.md), Lemma L54 (2): ω ≻ d, with ω the spectrum of W̊ on S²₀ and d = (d_φ, d_ψ) its diagonal in {φ_ab} ∪ {ψ_k}, ψ_k = diag(v_k) for an eigenbasis of K on 𝟏^⊥. Majorisation x ≻ y is [Majorizes](../lean/HamiltonsCubic/Results/L54Statement.lean#L63) x y: equal sums and every k-subset sum of y bounded by some k-subset sum of x.
- **Direction.** The HLP (Karamata) direction is x ≻ y ⇒ Σ g(y) ≤ Σ g(x) for convex g. The theorem has Σ g(d) ≤ Σ g(ω), which is the image of ω ≻ d. Right.
- **Objects.** The left multiset is the φ-block diagonal of `Bw w (ringW R)` over `Pairs n`, which is d_φ = K_ab by `phi_block_diag`, plus −(eigenvalues of K restricted to (ℝ∙𝟏)^⊥), the record's d_ψ by `psi_block` and `dpsi_split`. The right multiset is the eigenvalues of W̊ restricted to (ℝ∙gCoord w)^⊥, the orthogonal complement of the identity's coordinates, which is S²₀. The ∃ over the invariance proofs is harmless because proofs are irrelevant to the eigenvalues. Hypotheses 0 < n and Ricci-flatness are weaker than the record's Weyl, n ≥ 4, and the unit norm, which (2) never uses, is correctly absent.
- **Proof.** [diag_convex_le_spectrum](../lean/HamiltonsCubic/Results/SchurMajor.lean#L159) at `Bw` on S² gives Σ_{S²} g(diag) ≤ Σ g(spec). The diagonal splits over `Pairs n ⊕ Fin n`, the ψ-part being 0 ::ₘ d_ψ by `dpsi_split`, and the spectrum is 0 ::ₘ ω by `ringW_spectrum_split`. Both sides carry g(0) once, and `linarith` cancels it. Correct.
- **Equal sums.** Taking g = id and g = −id (both convex) gives Σ d = Σ ω, so the equal-sum half of majorisation is a consequence of the theorem. It needs no separate statement, and the owed passage to `Majorizes` would produce it the same way.
- **The owed item.** The converse direction (convex inequalities for every convex g ⇒ majorisation) is what stands between this theorem and L54Statement's `Majorizes`, and calling it the converse half of Hardy–Littlewood–Pólya is accurate. It is elementary: g_c(t) = max(t − c, 0) with c the k-th largest entry of ω gives the top-k bound. **Gap 1**: the subset-sum `Majorizes` is a relation between two functions on one `Fintype` N, while here ω is indexed by `Fin (finrank (ℝ∙gW)ᗮ)` and d by `Pairs n ⊕ Fin (finrank (ℝ∙gK)ᗮ)`. Reaching the record's form also needs these two index types identified (both of size C(n,2) + n − 1), which neither [L54Diag.lean:26](../lean/HamiltonsCubic/Results/L54Diag.lean#L26) nor [lean/INDEX.md:279](../lean/INDEX.md#L279) names. With that added, the owed list is complete for (2), since μ ≻ d_φ is already `L54_mu_majorizes` in subset-sum form. **Partial is right.**

## 2. Commit 18854704 against r1564

- **`su2_structure`** ([L167Full.lean:251](../lean/HamiltonsCubic/Results/L167Full.lean#L251)). From [K₀, K₁] = −2K₂, [K₁, K₂] = −2K₀, [K₀, K₂] = 2K₁: [e₀, e₁] = ¼[K₀, K₁] = −K₂/2 = e₂, [e₁, e₂] = ¼(−2K₀) = e₀ and [e₂, e₀] = −¼[K₀, K₂] = −K₁/2 = e₁. The Lean proof does exactly this. Correct.
- **Gap 1 closed.** [L167Statement.lean:56](../lean/HamiltonsCubic/Results/L167Statement.lean#L56) now points at `br_J0K`, `su2_structure` and `u2_indep`.
- **Gap 2 closed.** The L167 row carries 25/25, which matches the audit.
- **Gap 3 closed.** [L167Full.lean:17](../lean/HamiltonsCubic/Results/L167Full.lean#L17) writes [K_a, K_b] = −2ε_abc K_c.
- **Gap 4 closed.** The rescaling is `su2_structure`, and the header says closure and the isomorphism are read off the brackets and structure constants with no `LieSubalgebra` or `LieEquiv` object built, which states the presentation r1564 asked to be made explicit.
- The commit message says plan-lean.md was regenerated, and it is absent from the commit. Its L167 excerpt is truncated before the changed text, so regeneration produced no diff. No gap.

## 3. Soundness

- `lake build HamiltonsCubic.Results.L54Diag HamiltonsCubic.Results.L167Full`: success, linter warnings only (an unused simp argument at L54Diag.lean:94, the flexible `simp` at L167Full.lean:241 r1564 already noted).
- `axiom_audit.py --only L54Diag.lean`: 6/6 on the standard three. `--only L167Full.lean`: 25/25. The counts in the commit messages and rows match.
- No `sorry`, `admit` or `native_decide` in L54Diag.lean, L167Full.lean or L167Statement.lean.

## 4. Downstream

- The L54 files carrying the id are L54, L54Basis, L54Diag, L54Direct, L54Rigid, L54Schur, L54Spectrum, L54Split and L54Statement. The old owed item (x ⊕ 0 ≻ y ⊕ 0 ⇒ x ≻ y, r1549) is gone from the L54 row and from L54Diag's header, and no other file or index carries it.
- [bispectral.md](../findings/bispectral.md)'s L54 block and [findings/INDEX-results.md](../findings/INDEX-results.md)'s row 54 make no Lean claim about (2) on S²₀.
- Minor, optional: [L54Rigid.lean:24](../lean/HamiltonsCubic/Results/L54Rigid.lean#L24) names `L54_rigidity_S20` for (4) on S²₀ and could name `L54_majorizes_S20` for (2) beside it. [L167.lean:32](../lean/HamiltonsCubic/Results/L167.lean#L32) (`stabiliser_four`, a 3 + 1 = 4 theorem) asserts the 𝔰𝔲(2) ⊕ 𝔲(1) reading with no pointer to L167Full, as r1564 noted. Neither calls anything owed.

## 5. Style

- No em dash and no backticks inside link text in either commit's added lines. The dashes in "Hardy–Littlewood–Pólya" are en dashes. No hard wrapping in the two rows. No semicolon splices in the added prose.
- **Gap 2**: [lean/INDEX.md:249](../lean/INDEX.md#L249) reads "`br_K12` (the K_a close as 𝔰𝔲(2)) `su2_structure` (...)", a list item missing its comma.

## 6. Verdict

**CONFIRMED WITH GAPS.** `L54_majorizes_S20` is L54's (2) on the record's S²₀ in convex form, correct in direction and objects, and 18854704 closes r1564's gaps with a correct `su2_structure`. Both files audit clean on the standard three. The gaps are text:

1. [L54Diag.lean:26](../lean/HamiltonsCubic/Results/L54Diag.lean#L26) and [lean/INDEX.md:279](../lean/INDEX.md#L279): the owed passage to `Majorizes` also needs ω and d on one index type (`Fin (finrank (ℝ∙gW)ᗮ)` against `Pairs n ⊕ Fin (finrank (ℝ∙gK)ᗮ)`), which the owed item leaves out.
2. [lean/INDEX.md:249](../lean/INDEX.md#L249): missing comma between the `br_K12` item and `su2_structure`.
