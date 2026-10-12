# Review r1549: L112's doubly stochastic statement from (A) and (B) (L112Doubly.lean, commit 4096c0e7) and L54's diagonal half over 1⊥ with r1548's gaps (L54Diag.lean, commit e09fd1cc)

**Standfirst.** Both files are correct, faithful and sorry-free, and the audits return 7/7 and 3/3 on the standard three. `R_doublyStochastic`, `R_eigen` and `shadow_convex` are the record's L112 with (A) and (B) typed at the right index placement, and `shadow_convex` is the majorisation −λ/(n−2) ≺ λ in its Hardy–Littlewood–Pólya convex form, which is new in the layer. `dpsi_split` and `gCoord_wStd_eq_gvec` are right and close r1548's gap 3, and gaps 1 and 2 are closed as well. The gaps are in the record around L112: [L112Doubly.lean](../lean/HamiltonsCubic/Results/L112Doubly.lean) reproves most of [L112Statement.lean](../lean/HamiltonsCubic/Results/L112Statement.lean) without citing it, the L112 statement row still calls the full majorisation untyped, and the main row's L73 link points to the file that holds only L73's tracelessness half.

| # | claim | verdict |
| --- | --- | --- |
| A-1 | L112Doubly.lean states L112 and L73 faithfully from (A) and (B) | **CONFIRMED** |
| A-2 | the L112 row is accurate and its owed item is the remaining gap | **CONFIRMED WITH GAP** (reproof uncited, L73 link, owed list short of T's own hypotheses) |
| A-3 | L54Diag.lean's `dpsi_split` and `gCoord_wStd_eq_gvec`, and the new L54 owed item | **CONFIRMED WITH GAP** ((4) needs a multiset cancellation, not a majorisation one) |
| A-4 | e09fd1cc closes r1548's gaps 1–3, and the rewritten L135 row is accurate | **CONFIRMED** |
| B | build, axiom audit, no sorry, admit or native_decide | **CONFIRMED** (one flexible-simp linter warning) |
| C | no downstream text still calls the doubly stochastic statement, the shadow or L54's d passage untyped | **GAP** (lean/INDEX.md:452) |
| D | style of the markdown edits | **CONFIRMED** |

**Summary: CONFIRMED WITH GAPS. The Lean in both commits is sound and faithful and r1548's three gaps are closed, but lean/INDEX.md:452 still calls −λ/(n−2) ≺ λ untyped, the L112 row presents as new what L112Statement.lean already proved, and the row's L73 link names L73.lean where L73's statement lives in L73Statement.lean.**

## 1. Fidelity of L112Doubly.lean (A-1)

- **Hypotheses on T.** The record has T_abc = c_abc² totally symmetric. The file assumes symmetry in the first two slots (`hT`), nonnegativity (`hT0`) and, for `S_hollow` only, vanishing on a repeated first pair (`h0`). All three follow from total symmetry of a square, and assuming less gives a stronger theorem, so the hypotheses are faithful.
- **(A) and (B).** `hA : ∀ k, ∑ β, ∑ γ, T k β γ = 2 * (n - 2)` and `hB : ∀ k, ∑ β, ∑ γ, lam β * T k β γ = -2 * lam k` are the record's (A) and (B) ([findings/bounds.md:264](../findings/bounds.md)) with k in the first slot and λ weighting the second, which is the placement (Sλ)_k = Σ_β S_kβ λ_β needs.
- **R.** Row sums of S are (A), column sums follow from `S_symm`, entries are nonnegative, and 2(n−2) > 0 at n > 2, so `R_doublyStochastic` is exact. `R_eigen` is (B) divided by 2(n−2). The record's n ≥ 3 is the file's n > 2 with n real and decoupled from the index type, which is harmless since the content sits in `hA` and `hB`.
- **`shadow_convex`** ([L112Doubly.lean:71–76](../lean/HamiltonsCubic/Results/L112Doubly.lean)) is `diagonal_le_spectrum` at R with the diagonal rewritten by `R_eigen`: Σ_k g(−λ_k/(n−2)) ≤ Σ_k g(λ_k) for every convex g on ℝ. For vectors of equal length this family of inequalities is equivalent to x ≺ y (Hardy–Littlewood–Pólya), the equal-sum condition coming from g = ±id. So it is a faithful convex form of the majorisation.
- **`L73_shadow`** ([L112Doubly.lean:81–100](../lean/HamiltonsCubic/Results/L112Doubly.lean)) proves −(n−2)·lmax ≤ λ_k ≤ (n−2)·(−lmin) for any lower and upper bounds lmin, lmax, by reading −λ_k/(n−2) as a convex combination of the spectrum through row k of R. At lmin = λ_min, lmax = λ_max this is L73 ([findings/bounds.md:539](../findings/bounds.md)) with −λ_min in place of |λ_min|. The two agree when λ_min ≤ 0, which the file does not prove but which the L112 row's trace condition supplies and [L73Statement.lean](../lean/HamiltonsCubic/Results/L73Statement.lean)'s `lamMin_nonpos` proves. As the "one-index shadow" the record means (r649/r650: the k = 1 case of −λ/(n−2) ≺ λ), the statement is the max-entry and min-entry cases of the majorisation, which is what the per-row convex combination delivers. Faithful.
- **Hollowness** is used by nothing: `R_doublyStochastic`, `R_eigen`, `shadow_convex` and `L73_shadow` take no `h0`. `S_hollow` records the lemma's "hollow" and is the input for the record's two-distinct-eigenvalue sharpening ([findings/bounds.md:543](../findings/bounds.md)), which is untyped here. Keeping it is right, since the record states it.

## 2. The L112 row (A-2)

- The row's account of the four theorems is accurate, and "7/7 on the standard three" matches the audit. L112 staying **partial** is right: (A) and (B) are hypotheses.
- **Gap 1, the reproof is uncited.** [L112Statement.lean](../lean/HamiltonsCubic/Results/L112Statement.lean) already proves `Smat_symm`, `Smat_nonneg`, `Smat_hollow` (lines 85–97), `hatS_doublyStochastic` against Mathlib's `Matrix.doublyStochastic` (line 111), `hatS_eigenvector` (line 133), and `L73_one_index_shadow` with `L73_abs_form` (lines 151, 172). L112Doubly.lean's `S_symm`, `S_nonneg`, `S_hollow`, `R_doublyStochastic`, `R_eigen` and `L73_shadow` restate these. The new row ([lean/INDEX.md:451](../lean/INDEX.md)) says "The doubly stochastic statement and the shadow are PROVED from (A) and (B) in L112Doubly.lean" and removed an owed item that the statement row at line 452 had already discharged, and neither the row nor the file header names L112Statement.lean. The genuinely new theorem is `shadow_convex`.
- **Gap 2, the L73 link.** The row ends "[L73](HamiltonsCubic/Results/L73.lean)'s statement as the one-index case". [L73.lean](../lean/HamiltonsCubic/Results/L73.lean) holds only the tracelessness half and its header says the n−2 bound "is not in this file". L73's statement is [L73Statement.lean](../lean/HamiltonsCubic/Results/L73Statement.lean)'s `two_sided`, `lamMax_le` and `abs_lamMin_le`.
- **Gap 3, the owed list.** "(A) and (B) in this T-form from the layer's I#I = (n−2)I and W#I = −W" is the right principal item, since those are the Killing form and Ricci-flatness with first Bianchi. The row's list omits the other inputs that enter as hypotheses: T = c² for the structure constants in an eigenbasis of W with λ its eigenvalues, from which `hT`, `hT0` and `h0` follow by total antisymmetry of c. They are elementary, but the owed list reads as complete.

## 3. L54Diag.lean (A-3)

- **`dpsi_eq_neg_eigen`** is `Bw_diag_psi` at `wK` with `wK_eigen` and `wK_norm`, giving the layer's d_ψ(k) = −κ_k. Correct.
- **`dpsi_split`** composes that with `K_spectrum_split`: the multiset of the layer's d_ψ over ℝⁿ is 0 together with minus the eigenvalues of K restricted to 1⊥. The record's d_ψ ([findings/bispectral.md:488](../findings/bispectral.md), item 1) is by definition the ψ-diagonal at an eigenbasis of K on 1⊥, which `psi_block` identifies with minus that restricted spectrum. So `dpsi_split` states that the layer's d_ψ is the record's d_ψ plus one 0, at any eigenbasis Mathlib chooses. The `psi_block` step is cited in the row rather than typed as a theorem, which is acceptable because it is a direct instance.
- **`gCoord_wStd_eq_gvec`** ([L54Diag.lean:60–74](../lean/HamiltonsCubic/Results/L54Diag.lean)) proves frob(1, √2·symB a b) = 0 on pairs a < b and frob(1, E_aa) = 1 on the diagonal, which is `gvec = Sum.elim 0 1`. This is exactly r1548's gap 3, and the L50 row at [lean/INDEX.md:393](../lean/INDEX.md) now cites it.
- **The owed item.** W̊ kills g at a Ricci-flat R (`Bw_gCoord`), so the layer's spectrum is ω ⊕ 0 and, by `dpsi_split`, the layer's diagonal is d ⊕ 0. `L54_omega_majorizes` gives ω ⊕ 0 ≻ d ⊕ 0 on S². The implication x ⊕ c ≻ y ⊕ c ⇒ x ≻ y is **true** for any shared c: in convex form subtract g(c) from both sides, and the equal-sum condition subtracts c. So the owed step for (2) is the true remaining step, together with reindexing between the Fin-indexed statements.
- **Gap 4, (4) is a different cancellation.** At t_F = 2, `L54_rigidity` gives equal sorted vectors on S², hence 0 ::ₘ ω = 0 ::ₘ d as multisets, and ω = d follows by `Multiset.cons_inj_right`. The row ([lean/INDEX.md:273](../lean/INDEX.md)) and the file header ([L54Diag.lean:20–21](../lean/HamiltonsCubic/Results/L54Diag.lean)) file (4) under the majorisation cancellation. The item is smaller than named, and the wording should separate the two.

## 4. r1548's gaps and the L135 row (A-4)

- **Gap 1.** [L140Statement.lean:45–46](../lean/HamiltonsCubic/Results/L140Statement.lean) now cites L140Abs.lean's `g1_sq_le_quarter_of_sq` for `habs`. Closed.
- **Gap 2.** The L140 row ([lean/INDEX.md:497](../lean/INDEX.md)) names the `hdef` binder c₂ = Δ₂ − 1/9, with its pieces proved and unassembled at the competitor. Closed.
- **Gap 3.** Closed by `gCoord_wStd_eq_gvec`, and [L54Spectrum.lean:19–20](../lean/HamiltonsCubic/Results/L54Spectrum.lean) now names SecondKindMatrix.lean as `Bmat`'s home.
- **The L135 row** ([lean/INDEX.md:475](../lean/INDEX.md)). `coeff_identity` ([L135Statement.lean:220–227](../lean/HamiltonsCubic/Results/L135Statement.lean)) concludes c₂ = Δ₂ − A for abstract h, k related by h(t) = (1 + t²)k(arctan t) with one-sided expansions at A, which is what the row says. `defect_u` ([DefectCP2.lean:162](../lean/HamiltonsCubic/Results/DefectCP2.lean)) proves δ²(u) = 1/9 at the padded competitor for n ≥ 4. The owed item, both instantiated at the competitor with h and k the defect along the line and the circle, is the true remaining assembly. Accurate.

## 5. Soundness (B)

- `lake build HamiltonsCubic.Results.L112Doubly HamiltonsCubic.Results.L54Diag` completed (exit 0). The only diagnostic in the two new files is a flexible-tactic linter warning at [L54Diag.lean:56](../lean/HamiltonsCubic/Results/L54Diag.lean), `simp [Function.comp_def]` followed by `exact List.Perm.refl _`. It is style, not soundness.
- `axiom_audit.py --only L112Doubly.lean`: 7/7 clean on the standard three. `--only L54Diag.lean`: 3/3 clean. Neither file contains `sorry`, `admit` or `native_decide`.

## 6. Downstream (C)

- **Gap 5.** The L112 statement row ([lean/INDEX.md:452](../lean/INDEX.md)) still reads "The full majorization −λ/(n−2) ≺ λ is not typed, only its k = 1 case". `shadow_convex` now types it in convex form.
- No remaining text in lean/INDEX.md, findings/bounds.md or findings/INDEX-results.md calls L54's d passage "by reading" as an open step: the r1443 sentence at [lean/INDEX.md:273](../lean/INDEX.md) survives as history and is followed by the proved diagonal half.
- *Observed outside these commits*: the L73 row ([lean/INDEX.md:624](../lean/INDEX.md)) opens "PROVED: see the statement row below" and closes "The n−2 bound itself needs the Killing row mass and Ricci-flatness and is owed", a pre-existing internal inconsistency that the new theorem sharpens.

## 7. Style (D)

The added lines in lean/INDEX.md, STATUS.md and plan-lean.md carry no em dash and no backtick inside link text, and each row stays on one line. The semicolons in the L112, L54 and L140 rows separate list items that carry commas.

## 8. Verdict

**CONFIRMED WITH GAPS.** Both files are sound and faithful, and r1548's gaps are closed. Gaps:

1. [lean/INDEX.md:451](../lean/INDEX.md) and [L112Doubly.lean:6–21](../lean/HamiltonsCubic/Results/L112Doubly.lean): the doubly stochastic statement and the shadow were already proved in L112Statement.lean (lines 85–172), and neither the row nor the header cites it. The new content is `shadow_convex`.
2. [lean/INDEX.md:451](../lean/INDEX.md): the L73 link names L73.lean, whose header says the n−2 bound is not in that file. L73's statement is L73Statement.lean.
3. [lean/INDEX.md:451](../lean/INDEX.md): the owed list omits T = c² in W's eigenbasis, the source of `hT`, `hT0` and `h0`.
4. [lean/INDEX.md:273](../lean/INDEX.md) and [L54Diag.lean:20–21](../lean/HamiltonsCubic/Results/L54Diag.lean): (4) needs `Multiset.cons_inj_right`, not the majorisation cancellation.
5. [lean/INDEX.md:452](../lean/INDEX.md): the L112 statement row still calls −λ/(n−2) ≺ λ untyped.
6. [L54Diag.lean:56](../lean/HamiltonsCubic/Results/L54Diag.lean): flexible-simp linter warning.
