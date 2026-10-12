# REVIEW r1634: L131Whole.lean and the L131 row (commit e692517e)

**Verdict: CONFIRMED WITH GAPS.** The four new theorems are correct, carry the right hypotheses, build clean and rest on the standard three axioms. The INDEX row's whole-summand sentence is accurate for Weyl and ℝ·Id, and accurate for Λ⁴ only through a spanning fact that is proved by hand and missing from the row's Owed list.

Scope: commit e692517e, [L131Whole.lean](../lean/HamiltonsCubic/Results/L131Whole.lean), the L131 row of [lean/INDEX.md](../lean/INDEX.md) (line 492), against [isotropy-cap.md](../findings/isotropy-cap.md) Lemma L131 (line 423). Analysis-only footing: the only runs were one `lake build` of the target module and the axiom audit.

## Checks run

- `lake build HamiltonsCubic.Results.L131Whole`: exit 0, 8743 jobs. One linter warning in the file, L131Whole.lean:39, `eq_on_skew_of_phi` carries an unused `[Fintype ι]` in its type (cosmetic).
- `python3 scripts/misc/axiom_audit.py --only L131Whole.lean`: 8/8 declarations on the standard three. No `sorry`, no `native_decide` in the file.

## Claim table

| # | Claim | Verdict | Basis |
|---|---|---|---|
| 1 | `isLinOp_sharpCross` (L131Whole.lean:28): `X # Y` linear at linear `X`, `Y` | CONFIRMED | `sharpCross` (FoxProduct.lean:264) is `½(sharpOp(X+Y) − sharpOp X − sharpOp Y)`. `sharpOp_isLinOp` (L209WeylClosure.lean:94) takes `IsLinOp R` from its section variable (L209WeylClosure.lean:42), and the proof supplies it for `X+Y`, `X`, `Y`. The hypotheses are the needed ones: `sharpOp` of a nonlinear `R` has no reason to be linear. |
| 2 | `eq_on_skew_of_phi` (L131Whole.lean:40): linear `F`, `G` agreeing on every `φ_ab` agree on every bivector | CONFIRMED | `skew_expand` (WeylReal.lean:79) writes a skew `Z` as `½ Σ_ij ⟨Z,φ_ij⟩ φ_ij`, and `lin_sum` (L126Orbit.lean:34) with homogeneity moves `F`, `G` through the double sum. Skewness of `Z` is required and assumed. `φ_aa = 0` is covered by the ∀ over all pairs. |
| 3 | `eig_weyl_all` (L131Whole.lean:56): `(diagOp u) # I = −diagOp u` on bivectors at symmetric hollow `u` with zero row sums | CONFIRMED | Direct lift of `eig_weyl` (L131Diag.lean:101) with identical hypotheses. By hand: `sharpCross_diag_id` gives `½(r_a+r_b) − u_ab`, which is `−u_ab` at `r = 0`. |
| 4 | `eig_ricci_all` (L131Whole.lean:63): `(n−4)/2` at `u = knw h`, `Σh = 0` | CONFIRMED | Lift of `eig_ricci` (L131Diag.lean:111). By hand: `r_a = (n−2)h_a`, so `½(n−2)(h_a+h_b) − (h_a+h_b) = ((n−4)/2)(h_a+h_b)`. |
| 5 | `eig_scalar_all` (L131Whole.lean:70): `(diagOp jw) # I = (n−2)·Z` on bivectors | CONFIRMED | Lift of `eig_scalar` (L131Diag.lean:133) then `diagOp_jw_skew`. By hand: `r = n−1`, `(n−1) − 1 = n−2`. |
| 6 | `eig_scalar_line` (L131Whole.lean:76): `(c·I) # I = (n−2)(c·I)` on bivectors | CONFIRMED | `sharpCross_smul_left` (L131Lin.lean:45) at linear `diagOp jw` and `id`, then claim 5. |
| 7 | Row: Weyl entry on its whole summand | CONFIRMED WITH GAPS | True, and it rests on `sharpCross_id` (L131Sharp.lean:104), every `W` with `IsWeyl W`, on every bivector. `eig_weyl_all` only covers diagonal Weyl weights and adds nothing to the whole-summand claim. The row's "So the Weyl, ℝ·Id and Λ⁴ entries hold on their whole summands" follows the L131Whole list and reads as a consequence of it (gap G3). |
| 8 | Row: ℝ·Id entry on its whole summand | CONFIRMED WITH GAPS | ℝ·Id is one-dimensional and `eig_scalar_line` covers every `c`. Its first slot is `c • diagOp jw`, which equals `c • id` on bivectors only. Since `sharpOp` depends on `R` only through skew inputs (`sharpOp_congr_on_skew`, FoxBridge.lean:136), the reading is sound on Λ², and the row's summary sentence omits the reading (gap G2). |
| 9 | Row: Λ⁴ entry on its whole summand | CONFIRMED WITH GAPS | `sharpCross_lam4_span` (L131Lin.lean:83) gives `#I = 2` on every finite combination of `lam4` at distinct indices. That this span is Λ⁴ is stated in the row as "checked by hand and not declared", and the Owed list at the end of the row does not carry it (gap G1). The hand fact is true: the `lam4 i j k l` over `i<j<k<l` are `C(n,4)` operators with disjoint supports, matching `dim Λ⁴`. It is still an undeclared step under a whole-summand claim. |
| 10 | Row: S²₀ entry on its diagonal representatives `h ∧ g` | CONFIRMED | Exactly `eig_ricci_all`. Off-diagonal traceless `h` is not covered and the row says so. |
| 11 | Row Owed list complete | CONFIRMED WITH GAPS | Present and accurate: frame-image spanning of S²₀ with `sharpBil_act`, the reverse inclusion "Weyl_n is the whole −1 eigenspace", `𝒜 = −2(·#I)` off Weyl, and the off-Bianchi identity. Missing: the Λ⁴ spanning (G1). The reverse-inclusion item also needs the four eigenvalues distinct from −1, true for `n ≥ 3`, unstated but implied. |
| 12 | Axioms | CONFIRMED | 8/8 on the standard three. |

## Gaps

- **G1** (lean/INDEX.md:492, Owed clause): add "that the four-set elements over `i<j<k<l` span Λ⁴", which the same row calls "checked by hand and not declared". The whole-summand Λ⁴ claim leans on it.
- **G2** (lean/INDEX.md:492, sentence "`eig_scalar_line` gives the scalar entry on all of ℝ·Id"): state that `I` in the first slot is read as `diagOp jw`, equal to the identity on bivectors, as the docstring at L131Whole.lean:68 already does.
- **G3** (lean/INDEX.md:492, sentence "So the Weyl, ℝ·Id and Λ⁴ entries hold on their whole summands"): attribute each summand to its source (`sharpCross_id`, `eig_scalar_line`, `sharpCross_lam4_span` with the hand spanning), since `eig_weyl_all` is the diagonal case only.
- **G4** (L131Diag.lean:23-26, stale docstring): it still lists "that `X ↦ X # I` is linear in `X`" as not typed, which L131Lin.lean and L131Whole.lean now discharge. It also says the "three Bianchi summands" need frame images, whereas after `sharpCross_id` and `eig_scalar_line` only S²₀ does.
- **G5** (L131Whole.lean:39, cosmetic): unused `[Fintype ι]` in `eq_on_skew_of_phi`'s type, flagged by the linter.

## What would break each claim, and what I did to look for it

- Claims 1, 2: a nonlinear `X`, `Y` or `F`, or a non-skew `Z`. I checked that each hypothesis is present and consumed (`IsLinOp` feeds `sharpOp_isLinOp` and `lin_sum`, `IsSkew` feeds `skew_expand`).
- Claims 3-6: an arithmetic slip in the row sums. I recomputed the three values from `sharpCross_diag_id` by hand (screen only).
- Claim 7: a Weyl operator outside the diagonal locus. `sharpCross_id` quantifies over every `IsWeyl W` (WeylReal.lean:126), so none exists.
- Claim 8: an operator in ℝ·Id that differs from `c • diagOp jw` on Λ². None exists, and `sharpOp_congr_on_skew` makes the off-Λ² difference invisible to `#`.
- Claim 9: an element of Λ⁴ outside the `lam4` span. I checked by hand that the `C(n,4)` elements have disjoint supports (screen only). The step is undeclared in Lean, which is G1.
- Claim 10: an S²₀ element off the diagonal locus. None is claimed, and the row lists it as owed.
