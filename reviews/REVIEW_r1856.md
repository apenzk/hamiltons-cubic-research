# Reviewer r1856, L244's class bridge (bMass_class, rowMass_class) and (ii)'s per-vector ceiling at the operators (L244_rows, cap_self, cap_other, L244_ceiling), with the lean/INDEX.md L244 row

Gate 2 on commits b4551742 and 2602a35c. Every declaration was read at source against the record's Lemma L244 (ii) and its proof, together with the definitions it rests on (`bAB`, `bMass`, `rowMass`, `rowMass_split`, `rowMass_cap_self`, `rowMass_cap_x`, `twice_rowMass_le_of_top`, `ψf`, `evf`, `rowA_frame`, `rowB_frame`, `rowC_frame`, `rowC_critical`, `per_vector_ceiling`, `theta_bound`, `NormalForm`, `slotμ`, `pairMu`, RealLayer's `IsCritical`). The row algebra was redone by hand at the spectrum `(−a, 0, a)`. A scratch file ([/private/tmp/r1856/Check.lean](/private/tmp/r1856/Check.lean)) was run with `lake env lean`: `#print axioms` on every reviewed declaration and a one-line proof that every slot eigenvalue is nonnegative. The mathematics is right and the axioms are the standard three. The defects are in the prose: the owed list omits the passage from `a` to `1/√(2p)`, the row's older *Not typed* clause still owes the bridge these commits prove, and L244Sym's module docstring names a declaration that does not exist.

| # | Claim | Verdict |
|---|---|---|
| 1 | `bMass_class`, `rowMass_class`: the class family's mass is the record's `b_ab`, its row mass `∑_b b_ab` | CONFIRMED |
| 2 | `bAB_symm` (L244Sym) | CONFIRMED WITH OBSERVATIONS (duplicates L244RowA's `bAB_symm`, O3) |
| 3 | `L244_rows`: rows (A), (B), (C) at a frame vector of class `0` are `hA`, `hB`, `hC` with `K = θ/a + 1` | CONFIRMED |
| 4 | `class_equiv`, `class_orth` | CONFIRMED |
| 5 | `cap_self`, `cap_other`: the `E₀` and `E₂` Ky Fan caps | CONFIRMED |
| 6 | `L244_ceiling` against (ii) | CONFIRMED WITH OBSERVATIONS (frame vector, `a` in place of `1/√(2p)`, O1, O2) |
| 7 | lean/INDEX.md L244 row, new paragraph and owed list | CONFIRMED WITH OBSERVATIONS (owed list incomplete, stale *Not typed* clause, O1, O4) |
| 8 | Axioms | CONFIRMED (propext, Classical.choice, Quot.sound) |

**Summary:** the Lean is correct and faithful at every frame vector of `E₀`, and three prose repairs are owed (the `a = 1/√(2p)` translation onto the owed list, the stale *Not typed* bridge item, the phantom `L244_xfree_frame` in L244Sym's docstring).

## 1. Attack A: `bMass_class` reindexing

- `bMass ψ' φ cls b x = ½ ∑_{i} ∑_{δ : cls δ = b} ⟨[ψ' i, φ δ], x⟩²` ([L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean)), and `bAB ψ cls a b x = ½ ∑_{γ : cls γ = a} ∑_{δ : cls δ = b} ⟨[ψ γ, ψ δ], x⟩²` ([L244RowA.lean:137](../lean/HamiltonsCubic/Results/L244RowA.lean#L137)).
- With `ψ' = ψ ∘ (Subtype.val ∘ e)`, `φ = ψ` and `e : Fin m ≃ {γ // cls γ = a}`, the outer sum over `Fin m` is the outer sum over the subtype by `Equiv.sum_comp`, and the subtype sum is the filtered sum by `Finset.sum_subtype`. The inner sum is untouched. The identity is exact.
- `bAB` is the record's `b_ab(x) = ½ ∑_{γ∈E_a, δ∈E_b} ⟨[ψ_γ, ψ_δ], x⟩²` once `cls` is the eigenvalue labelling of an orthonormal eigenframe, which `hcls` with `a > 0` forces (the three values `−a, 0, a` are distinct, so `cls k` is determined by `evf k`).
- `rowMass_class` rewrites `rowMass` through `rowMass_split` with `φ = ψ` complete, then applies `bMass_class` termwise. CONFIRMED.

## 2. Attack B: `L244_rows`, signs, scaling, normalisation

Hand expansion at `λ = (−a, 0, a)` with `b_ab = b_ba`:

- **Row (A).** `rowA_frame`: `∑_{a,b} b_ab = (n − 2)⟨x, x⟩ = n − 2` at `hunit`. Splitting the nine terms by symmetry gives `b00 + b11 + b22 + 2(b01 + b02 + b12)`. The factor 2 comes from `s01`, `s02`, `s12` (`bAB_symm`), which the `linarith` call has in context. Correct.
- **Row (B).** `rowB_frame`: `∑_{a,b} λ_b b_ab = −⟨Wx, x⟩`. Left side: `−a(b00 + b10 + b20) + a(b02 + b12 + b22)`. Right side: `Wx = −a x` gives `−(−a)·1 = a`. Dividing by `a > 0` and using `b10 = b01`, `b20 = b02`: `b12 + b22 − b00 − b01 = 1`, the record's row (B). The Lean proof is exactly `rB − a·s01 − a·s02` then `mul_left_cancel₀`. Sign and scaling correct.
- **Row (C).** `rowC_frame`: `∑ λ_a λ_b b_ab = ⟨W^# x, x⟩`. Left side: `a² b00 − a² b02 − a² b20 + a² b22 = a²(b00 + b22 − 2b02)`. `rowC_critical` at `λ_c = −a`: `⟨W^# x, x⟩ = λ_c(θ − λ_c) = −a(θ + a)`. So `2b02 − b00 − b22 = (θ + a)/a = θ/a + 1 = K`, the record's row (C). The Lean shows `a·(2b02 − b00 − b22) = θ + a` by `nlinarith` and cancels `a`. Correct.
- **Which θ.** `IsCritical` in scope is RealLayer's ([WeylReal.lean:194](../lean/HamiltonsCubic/Base/WeylReal.lean#L194)): `∀ i j, Qop W (φ_ij) = θ • W (φ_ij)`, i.e. `Q(W) = θW` on the basis, extended to all bivectors by linearity inside `rowC_critical`. This is the record's multiplier in `W² + W^# = θW`.
- **Normalisation.** `W` is unit-normalised nowhere. Only `x` is unit (`hunit`, from the frame's orthonormality). This is harmless for the three conclusions in `a`: under `W ↦ tW`, `t > 0`, both `θ` and `a` scale by `t`, so `θ ≤ a(n − 5)`, `θ ≤ a(κ₀ − 1)`, `θ ≤ a(κ₂ − 3)` are scale-invariant. At unit norm the multiplier is `θ(W) = P(W)/‖W‖³` (the repository's `theta_of_critical_unit`, used for L70), so the record's θ is matched. What the Lean does not supply is the record's `a = 1/√(2p)`, which is exactly where unit norm enters (O1).

## 3. Attack C: the caps

- **`cap_self`.** `class_equiv` gives `e : Fin (m + 1) ≃ {γ // cls γ = 0}` with `(e 0).1 = k₀`, so the class family starts with `x`. `rowMass_cap_self` (with `rowMass_drop_self`, `x`'s own row vanishing) gives `2R ≤ m c + ∑ max(μ − c, 0)` for all `c`, over one normal form `N` of `x`. `twice_rowMass_le_of_top` needs `0 < m` (from `hsize : 2 ≤ m + 1`) and a bound on every `m`-set of slot values of that `N`, which `htop` supplies at `S.card ≤ card − 1 = m`. Then `rowMass_class` turns `R` into `∑_b b_0b`. Correct.
- **`cap_other`.** Same chain through `rowMass_cap_x` with `r = card{cls = 2}`, `0 < r` required. Correct. Its statement takes any skew `x`, and `L244_ceiling` instantiates it at `ψ_{k₀}`.
- **Faithfulness of the κ hypotheses.** `slotμ` takes values `s²`, `(s_c ± s_d)²` or `0` (`pairMu` at [L240SlotBasis.lean:604](../lean/HamiltonsCubic/Results/L240SlotBasis.lean#L604)), so every slot value is nonnegative, and the scratch file proves `0 ≤ slotμ N ij` for every normal form. Hence the least `κ` bounding every set of at most `r` slot values is the top-`r` sum. The slots are indexed by pairs `i < j`, `N = n(n−1)/2` of them, and are the eigenvalues of `−ad²` of the normal form (`slot_plus_general` and siblings), which conjugation by `O` carries to `x`. So "κ₀ bounds every set of at most `m₀ − 1` slot values of every normal form of `x`" is satisfied by `κ₀ = κ_{m₀−1}(x)`, provided the slot multiset is the spectrum of `−ad_x²` with multiplicity. That identification is prose, on the owed list, and the INDEX says so. The universal quantifier over normal forms makes the hypothesis at worst stronger than the record's, never weaker, so no unsound direction opens.
- **Indices.** `cls` labels the eigenvalues exactly, so `card{cls = 0} = dim E₀ = p` and `card{cls = 2} = dim E₂ = p` at the record's multiplicities. `m₀ − 1 = p − 1` and `m₂ = p` match the record's `κ_{p−1}` and `κ_p`.
- **Side conditions.** `m₀ ≥ 2` and `m₂ ≥ 1` are what `twice_rowMass_le_of_top` needs (`0 < r`). Tracelessness of a Weyl operator gives `m₂ = m₀` at this spectrum, so `h2size` follows from `h0size` and is redundant but harmless (O5). The record's case `p = 1` (where `κ₀(x) = 0` and the `E₀` cap is trivially `0 ≤ 0`) is excluded by `h0size`, and with it the other two conclusions at `p = 1` (O2).

## 4. Attack D: `L244_ceiling` against (ii), and the owed list

- **Conclusions.** `θ ≤ a(n − 5)`, `θ ≤ a(κ₀ − 1)`, `θ ≤ a(κ₂ − 3)`. The record's `θ ≤ (min(κ_{p−1}, κ_p − 2, n − 4) − 1)/√(2p)` is the conjunction of `θ ≤ a(κ_{p−1} − 1)`, `θ ≤ a(κ_p − 3)`, `θ ≤ a(n − 5)` at `a = 1/√(2p)`. The three match term for term.
- **Covered.** The bound at every frame vector `ψ_{k₀}` of class `0` of the EigenFrameExist spectral frame, at any critical linear Weyl `W` whose frame eigenvalues all lie in `{−a, 0, a}`, `a > 0`, with `κ₀`, `κ₂` as hypotheses and `cls` quantified.
- **Owed list at HEAD**: (1) every unit `x ∈ E₀`; (2) `κ_r(x)` as the top-`r` eigenvalue sum of `−ad_x²`; (3) `cls` constructed. Each is accurate. On (1): rows (A), (B), (C) already hold at any unit skew `x` with `Wx = −ax`, since `rowA_frame`, `rowB_frame`, `rowC_frame` take arbitrary skew `x` and `rowC_critical` needs only the eigen-equation. Only `cap_self` needs `x` to be a frame vector (through `rowMass_drop_self`). The owed item's wording ("an orthonormal basis of `E₀` extending `x`") is right, and the cheaper route is basis independence of `∑_{γ∈E₀} ‖[ψ_γ, x]‖²` inside `E₀` (Parseval inside the eigenspace), which keeps `ψf` fixed.
- **Missing from the owed list**: (4) `a = 1/√(2p)`, i.e. unit norm `‖W‖² = ∑_k λ_k² = 2pa² = 1` in the frame's normalisation, which is the only place the record's `p` in the denominator comes from (O1). The INDEX paragraph states the record's form "at `a = 1/√(2p)`" as a reading, with no declaration and no owed entry.
- **Multiplicities `(p, N − 2p, p)`.** Unused. The Lean is more general: any class sizes, any `a > 0`, the κ indices read off the class sizes. This does not matter for the three inequalities. Equal outer multiplicities are forced by tracelessness anyway. The multiplicities enter the record's statement only through `a = 1/√(2p)` and the κ indices, both handled above.

## 5. Attack E: hypothesis inventory and vacuity

| Hypothesis | Content | Satisfiable alone |
|---|---|---|
| `ha` | `0 < a` | yes |
| `hc` | `Q(W) = θW` on the basis | yes (`W = 0`, any `θ`) |
| `hcls` | every frame eigenvalue in `{−a, 0, a}`, `cls` its label | yes, jointly with `hc` at `W = 0` only with no class-0 vector |
| `hk₀` | `cls k₀ = 0`, so `−a` is an eigenvalue | excludes `W = 0` |
| `h0size`, `h2size` | `p ≥ 2`, `p ≥ 1` | follow from a `−a` eigenvalue of multiplicity at least 2 and tracelessness |
| `htop0`, `htop2` | κ bounds on slot sets | yes, any large `κ` |

- Every hypothesis except the existence of `W` is trivially satisfiable, and none contradicts another at the level of the definitions.
- Joint non-vacuity is equivalent to the record's symmetric family being non-empty: a critical linear Weyl operator whose spectrum is `{−a, 0, a}` with `dim E_{−a} ≥ 2`. The record exhibits no member (S⁵×S⁷, its check, is outside the family) and uses (ii) as an exclusion lemma (with L250).
- **Hand screen at `n = 4`**: a Weyl operator is `W⁺ ⊕ W⁻`, each traceless on a 3-space, `W^#` acting blockwise as a multiple of the cofactor. A block with entries in `{−a, 0, a}` is `0` or a permutation of `(a, 0, −a)`, and at the `0` entry criticality reads `c·a·(−a) = θ·0`, false. So the family is empty at `n = 4`. This is a screen, not evidence for any positive claim. Larger `n` was not searched (an open-ended hunt, outside the analysis-only footing).
- **Verdict on E:** the statement is not vacuous by construction. Its content is conditional on the family, exactly as the record's (ii) is, and I did not decide whether the family is empty at `n ≥ 5` (O6).

## 6. Attack F: axioms

`#print axioms` in [/private/tmp/r1856/Check.lean](/private/tmp/r1856/Check.lean), run with `lake env lean` from lean/: every one of `L244_ceiling`, `L244_rows`, `cap_self`, `cap_other`, `class_equiv`, `class_orth`, `bAB_symm`, `bMass_class`, `rowMass_class` depends on `[propext, Classical.choice, Quot.sound]`. The file compiled with exit 0 and `grep -c error` returned 0, the `slotμ` nonnegativity `example` included. `#check` confirmed `L244_ceiling`'s statement as quoted and `IsCritical` resolving to `RealLayer.IsCritical`. CONFIRMED.

## 7. Attack G: what would break each statement, and what I did to look

- **`bMass_class`**: a mismatch between `bMass`'s `φ`-filter and `bAB`'s inner filter, or `ψ ∘ e` indexing the wrong class. Checked by unfolding both definitions: the inner sums are literally equal and the outer reindexing is a bijection.
- **`L244_rows`**: a sign error in (B) (`−⟨Wx, x⟩` against `+a`) or (C) (`λ_c(θ − λ_c)` at `λ_c = −a`), or a missing symmetric partner. Checked by expanding all nine terms by hand at `(−a, 0, a)` (section 2), which reproduces the record's rows exactly. The `linear_combination` coefficients `rB − a·s01 − a·s02` match the hand expansion.
- **`cap_self`**: an off-by-one (`κ_{m₀}` in place of `κ_{m₀−1}`), which would silently weaken the cap. Checked: `class_equiv` puts `x` at index `0`, `rowMass_cap_self` drops it, `twice_rowMass_le_of_top` is invoked at `r = m = card − 1`, and `htop`'s side condition is `S.card ≤ card − 1`.
- **`cap_other`**: `r = card{cls = 2}` with no drop, matching `κ_p`. Checked.
- **`L244_ceiling`**: a κ hypothesis that fails at the true `κ_r(x)` (for example if slot values could be negative, making the true top-`r` sum smaller than some `r'`-subset with `r' < r`, or if two normal forms of `x` carried different slot multisets). Checked nonnegativity by proof in the scratch file. Multiset invariance is part of owed item (2).
- **`per_vector_ceiling` / `theta_bound` interface**: `hK : θ = a(K − 1)` at `K = θ/a + 1` holds by `field_simp` at `a ≠ 0`. Checked.

## Observations

- **O1.** The owed list omits `a = 1/√(2p)`: the record's denominator comes from unit norm, `∑ λ² = 2pa² = 1`, which no declaration states. Add it to the owed list, or type it (it is one line from a unit-norm hypothesis and the class counts, in the pattern of L105Op's `uwN_one`).
- **O2.** `h0size` excludes `p = 1` for all three conclusions, including `θ ≤ a(n − 5)` which does not need the `E₀` cap. The record's (ii) formally covers `p = 1`. Harmless for the programme (the `x`-free bound is `L244_xfree_op` in L248Op.lean at every spectrum), but the INDEX paragraph should say "at `p ≥ 2`" or the `n − 5` clause should be split off.
- **O3.** L244Sym's `bAB_symm` duplicates `HamiltonsCubic.L244RowA.bAB_symm` ([L244RowA.lean:159](../lean/HamiltonsCubic/Results/L244RowA.lean#L159)), and the INDEX row lists `bAB_symm` twice (once under `hA`, once under L244Sym) as if new.
- **O4.** The row's older *Not typed* clause still reads "the bridge from L244Caps' `bMass` to `bAB`", which `bMass_class` now proves, and repeats "`cls` being quantified rather than constructed", now also on the new owed list. The row contradicts itself on the bridge.
- **O5.** `h2size` is implied by `h0size` via tracelessness (`m₂ = m₀` at `(−a, 0, a)`). Harmless.
- **O6.** Non-vacuity rests on the record's symmetric family being non-empty. It is empty at `n = 4` by a hand screen and undecided above.
- **O7.** L244Sym's module docstring names `L244_xfree_frame` ([L244Sym.lean:21](../lean/HamiltonsCubic/Results/L244Sym.lean#L21)), which does not exist. The file's theorem is `L244_ceiling`, and the docstring does not mention `class_equiv`, `class_orth`, `cap_self`, `cap_other`.

## Overall verdict

CONFIRMED WITH OBSERVATIONS. The bridge, the rows, the caps and the ceiling are correct and faithful to (ii) at every frame vector of `E₀`, with κ entering as slot-sum hypotheses and `a` in place of `1/√(2p)`, on the standard three axioms. Repairs owed in prose: O1 (owed list), O4 (stale *Not typed* clause), O7 (docstring), with O2 and O3 as wording.
