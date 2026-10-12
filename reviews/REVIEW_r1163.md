# REVIEW r1163: L244's dual form to a numeral, in Lean

Brief: [2026-09-25-L244numeral-gate2-brief.md](2026-09-25-L244numeral-gate2-brief.md). Module: [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean). Analysis-only, plus the background build and the axiom audit.

## Verdicts

| item | verdict |
|---|---|
| 1. `twice_rowMass_le_of_top` states the claim, and `κ = κ_r(x)` is an admissible `htop` | CONFIRMED |
| 2. L244 row of [lean/INDEX.md](../lean/INDEX.md) | PLAUSIBLE, with two small additions to "Not typed" |
| 3. build and axiom audit | CONFIRMED |

## Item 1: CONFIRMED

- The declaration takes `hr : 0 < r`, a normal form `N`, reals `R`, `κ`, the dual form `hdual : ∀ c, R ≤ r c + ∑ max(slotμ N ij − c, 0)` and `htop : ∀ S, S.card ≤ r → ∑_{ij ∈ S} slotμ N ij ≤ κ`, and concludes `R ≤ κ`. This is the claim word for word. The proof is `exists_c_topSum` at the `c` it supplies followed by `hdual c`, so nothing is weakened. `R` is a free real, which makes the lemma more general than the brief's `2R_a(x)` and costs nothing.
- **No vacuity.** `hdual` is exactly the conclusion of `rowMass_cap_x` and `rowMass_cap_self` with `R := 2 * rowMass ψ φ x` (the same `(r : ℝ) * c` cast, the same `slotμ N` over the same index type `{x : ι × ι // x.1 < x.2}`, the same `LinearOrder ι` instance), and `htop` is met by `κ := Finset.sup'` of the slot sums over sets of size at most `r`, or by the top-`r` sum below.
- **`κ_r(x)` is admissible.** Every `slotμ N ij` is `0`, `N.s a ^ 2` or a `pairMu` value `(s_c ± s_d)^2`, hence nonnegative. So for `|S| ≤ r` the sum over `S` is at most the sum of the top `|S|` values, which is at most the top-`r` sum. The slot family is orthonormal, complete and an eigenbasis of `−ad_{N.X}²` with eigenvalues `slotμ N` (`slot_orthonormal`, `slot_complete`, `slot_eigen` in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)), and `x = O N.X Oᵀ` with `O` orthogonal conjugates `ad_x` to `ad_{N.X}`. Hence the multiset of `slotμ N` values is the spectrum of `−ad_x²`, and the top-`r` slot sum is the record's `κ_r(x)` ([second-order.md](../findings/second-order.md) L244 setting), independent of the `N` the existential picks.
- **Composition gives `h0` and `h2` with the record's indices.** With `ψ` a basis of `E_2` (`r = m_2 = p`), `rowMass_cap_x` then `twice_rowMass_le_of_top` give `2 R_2(x) ≤ κ_p(x) = κ₂`. With `ψ` a basis of `E_0` starting at the unit `x` (`m_0 = p = r + 1`), `rowMass_cap_self` then `twice_rowMass_le_of_top` give `2 R_0(x) ≤ κ_{p−1}(x) = κ₀`. `rowMass_split` with three classes and `Fin.sum_univ_three` turns `2 R_a(x)` into `2(b_a0 + b_a1 + b_a2)`, which is the left side of `h0`, `h2` of `per_vector_ceiling` once `b_ab` is read as `bMass`.
- **Remark, no defect.** `hr` excludes `r = 0`, i.e. `p = 1` for `h0`. That case is trivial (the dual form at `c ≥ max slotμ` gives `R ≤ 0`, and `htop` at `S = ∅` gives `0 ≤ κ`), and the record works at `p ≥ 2` throughout.

## Item 2: PLAUSIBLE, with two small additions

- The row names `twice_rowMass_le_of_top` as "the passage from the dual form to the numeral `κ` fed to `per_vector_ceiling` (any `κ` bounding every `r`-set of slot eigenvalues, e.g. the top-`r` sum)", which is what item 1 confirms. The r1162 addition (a basis of `E_0` starting with the unit `x`) is in the "Not typed" list, and r1162's missing passage is now typed, so the list correctly no longer names it.
- **Addition 1.** The identification of the top-`r` slot sum of `N` with the record's `κ_r(x)` (the top-`r` sum of the eigenvalues of `−ad_x²`) is prose: no Lean declaration defines `κ_r(x)`. Its ingredients are typed (`slot_eigen`, `slot_orthonormal`, `slot_complete`, the conjugation in `kyFan_conj`), so the "Not typed" list should name it as the one step joining the numeral to the record's notation, or the row's "e.g. the top-`r` sum" should read "e.g. the top-`r` slot sum, which is `κ_r(x)` by the slot eigenbasis and conjugation (prose)".
- **Addition 2.** `per_vector_ceiling` also takes `h00`, `h01`, `h11`, `h22`, the nonnegativity of `b00`, `b01`, `b11`, `b22`. For `bMass` it is immediate (a nonnegative multiple of a sum of squares) but no declaration states it. The list can name it beside the `bMass = ⟨B_ab x, x⟩` identity, or note it as the one-line fact it is.

## Item 3: CONFIRMED

- `lake build HamiltonsCubic.Results.L244Caps` from `lean/`: `Build completed successfully (8740 jobs)`, zero errors, no `sorry`. Warnings in the module are style only (long lines at 10, 13, 23, 28, unused simp arguments at 40 and 66, and the linter note that `rowMass_eq`'s type does not use one hypothesis).
- `python3 scripts/misc/axiom_audit.py --only L244Caps`: `7/7 clean -- resting on the standard three alone`.
