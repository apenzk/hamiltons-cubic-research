# REVIEW r1917: B12 steps 1 and 2, the sector split of tr(L_e^2) on the Weyl module

*Gate 2 review of [B12Sectors.lean](../lean/HamiltonsCubic/Results/B12Sectors.lean) (d3d6641a) and [B12Support.lean](../lean/HamiltonsCubic/Results/B12Support.lean) (0746e1ff) against the B12 entry of [lean/INDEX.md](../lean/INDEX.md). Every theorem in both files is correct and kernel-checked on the standard three axioms. Two inputs the later steps need are neither proved here nor claimed here: that the unit sphere-product element of `weylModuleS` is fixed by every `diagSet u`, and that `projS t` is idempotent. Both are true by short arguments and belong on the owed list.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `projS_coe`, `sum_projS` | CONFIRMED |
| 2 | `Lop_actS`, `Lop_projS`, and the hypothesis `∀ u, act (diagSet u) e = e` | CONFIRMED WITH OBSERVATIONS |
| 3 | `trace_sectors`, `trace_sq_sectors` | CONFIRMED WITH OBSERVATIONS |
| 4 | `char_coord`, `projS_card`, `projS_eq_zero`, `trace_sq_support` | CONFIRMED |
| 5 | Fidelity to the B12 entry and to L120's decomposition | CONFIRMED WITH OBSERVATIONS |
| 6 | Axiom audit | CONFIRMED |
| 7 | Falsifiers | CONFIRMED |

**Summary: steps 1 and 2 are sound and say exactly what the INDEX entry says, and the entry's owed list should gain two items: sign-fixedness of the sphere-product element in `weylModuleS`, and idempotence of `projS t` (for the passage from `tr(A ∘ P_t)` to the trace on the sector).**

## 1. `projS` is `proj` on `weylModuleS`, and the projectors sum to the identity

- `projS t` is defined as `2^{-n} ∑_u chi t u • actS (diagSet u) _`, and [L120Decomp.lean](../lean/HamiltonsCubic/Results/L120Decomp.lean)'s `proj t B` is `2^{-n} ∑_u chi t u • act (diagSet u) B`. The coercion of `actS g _ Y` is `act g Y` by definition ([WeylTraceInvariance.lean](../lean/HamiltonsCubic/Results/WeylTraceInvariance.lean)), so `projS_coe` is the unfolding plus coercion lemmas for `smul` and `sum`, closed by `rfl`. Correct.
- `sum_projS` reduces through `Subtype.ext` and `projS_coe` to `sum_proj`, which holds on all of `CurvLin`. Correct, and it holds with no hypothesis on the element.

## 2. `L_e` commutes with the sign action at a sign-fixed `e`

- `Lop_actS`: `leftMulS_act` says the conjugate `(actE g).conj (Lop e)` satisfies the defining product identity with `act g e` in place of `e`. Under `he` that is `e`, so `leftMulS_unique` gives `conj (Lop e) = Lop e`. Evaluating at `actE g Y` and cancelling `symm ∘ actE` gives `Lop e (g·Y) = g·(Lop e Y)`. Correct.
- `Lop_projS` pushes that through the linear combination defining `projS t`. Correct.
- **The hypothesis is the right one.** The commutation needs `e` invariant under exactly the group whose characters index the projectors, the group of `diagSet u`, and nothing more. Invariance under every `diagSet u` is equivalent to invariance under every single flip `flip m`, the form the record states ([L219Diag.lean](../lean/HamiltonsCubic/Results/L219Diag.lean)'s `act_diag_set_fix` gives one direction on `Fin n`).
- **It is satisfied at the sphere product, mathematically.** A coordinate-diagonal Weyl operator `diagOp w` sends `φ_ij` to `w_ij φ_ij`. For `g = diagSet u` one has `gᵀ φ_ij g = ε_i ε_j φ_ij`, so `act g (diagOp w)` sends `φ_ij` to `ε_i ε_j w_ij g φ_ij gᵀ = w_ij φ_ij`, and on symmetric inputs both sides vanish (the `skewProj` factor of [WeylModuleSNonzero.lean](../lean/HamiltonsCubic/Results/WeylModuleSNonzero.lean)'s element kills them, and `gᵀ Z g` stays symmetric). [findings/second-order.md](../findings/second-order.md) L120 records the same fact: `𝒟_n` is exactly the Γ-fixed subspace.
- **Neither file proves it, and neither file claims it.** No lemma in the tree states `act (diagSet u) e = e` or `act (flip m) e = e` for `diagOpL w ∘ₗ skewProj`, and the sphere product exists as an element of `weylModuleS` only at `Fin 4` (`weylModuleS_fin4_nonzero`) and as an `IsWeylOp` function on matrices in [L2SphereWeyl.lean](../lean/HamiltonsCubic/Results/L2SphereWeyl.lean)'s `sphereProduct_weylPart`, a different carrier. **The gap sits in the plan for step 6, which the files leave untouched**: step 6 has to build the unit sphere-product element of `weylModuleS ι` for general `ι`, prove its sign-fixedness, and link it to L161Link's `theta` normalisation. The INDEX entry's owed list does not name this.

## 3. The trace split

- `trace_sectors`: `∑_t f ∘ projS t = f ∘ ∑_t projS t = f`, then linearity of the trace. Correct for every endomorphism `f`, no hypothesis on `e`.
- `trace_sq_sectors`: the first conjunct is `trace_sectors` at `Lop e ∘ Lop e`, and the second rewrites `Lop_projS` twice through the associativity. Correct.
- **The second conjunct is half of what the restriction step needs.** To read `tr(A ∘ P_t)` as the trace of `A` on `range P_t` (so that an explicit eigenbasis of the sector gives the sector's contribution as `∑ mult · value²`), one needs `A P_t = P_t A` **and** `P_t² = P_t`. Then `V = range P_t ⊕ ker P_t` with both summands `A`-invariant, `A P_t` equals `A` on the range and `0` on the kernel. Idempotence of `projS t` is not proved in these files or in [L120Decomp.lean](../lean/HamiltonsCubic/Results/L120Decomp.lean) (no `proj_proj` or `proj_idem` there). It follows from `proj_signMat` (each `proj t Y` has character `setChar t`) plus the orthogonality `2^{-n} ∑_u chi s u chi t u = δ_{st}`, a few lines on top of `sum_chi`. **The restriction step is owed**, and so is idempotence as its input. An alternative that avoids it, computing `tr(A ∘ P_t)` directly in a basis of the whole module, would need the other sectors' vectors anyway, so the restriction lemma is the economical route.

## 4. The support argument, `P_t = 0` off `|t| ∈ {0, 2, 4}`

- `char_coord`: `coord_sign` gives `coord (act (signMat ε) R) = ε_i ε_j ε_k ε_l · coord R`, `proj_signMat` gives `act (signMat ε) (proj t Y) = setChar t ε • proj t Y`, `coord_smul` pulls the scalar out, and `mul_right_cancel₀` cancels the nonzero coordinate. Correct, and `proj_signMat` holds for every `Y : CurvLin`, so no membership is used here.
- `projS_card`: membership enters once, in `cd_ext`, which needs `proj t Y ∈ weylModuleS` to conclude `proj t Y = 0` from vanishing coordinates, supplied by `proj_mem`. The evenness step at `ε ≡ -1` gives `(-1)^{|t|} = 1`. The containment step at the single flip at `m ∈ t \ {i,j,k,l}` gives `-1 = 1`. Then `|t| ≤ |{i,j,k,l}| ≤ 4` by `card_four_le` (which counts coincident indices correctly) and evenness give `{0, 2, 4}`.
- **Line-by-line against `block_card`** ([L120Support.lean](../lean/HamiltonsCubic/Results/L120Support.lean)): the same two sign vectors, the same `simp` sets with `setChar` and `Finset.prod_ite_eq'`, the same `card_four_le` and `omega` finish. The only change is the source of the character identity, `char_coord` on `CurvLin` in place of `coord_char` on `CurvOp2`. Faithful.
- `projS_eq_zero` and `trace_sq_support`: pointwise contraposition of `projS_card`, and `sum_filter` with the dropped terms killed by `comp_zero` and `map_zero`. Correct.

## 5. Fidelity

- **Sectors against L120's summands.** `t = ∅` is the Γ-fixed sector, L120's `𝒟_n`. `|t| = 2`, `t = {j,k}`, collects the coordinates `R_{ijik}`-type with character `ε_j ε_k`, L120's pair summand `V_{jk}`. `|t| = 4` collects `R_{ijkl}` with four distinct indices, the four-set summand `V_{ijkl}`. A count at `n = 4` agrees: `2 + 6·1 + 1·2 = 10 = dim 𝒲_4`, with the dimensions `n(n-3)/2`, `n-3`, `2` the entry quotes. The files prove only the support statement, not these dimensions or identifications, and the entry places the dimensions under steps 3 to 5, so nothing is over-claimed.
- **The carrier.** L120's identifications are machine-checked on `CurvOp2`, and B12 works on `weylModuleS ι ⊆ CurvLin ι`. `projS_coe` ties B12's projector to the same `proj` that [L120Decomp.lean](../lean/HamiltonsCubic/Results/L120Decomp.lean)'s `comp` uses through `extendL`, so the sectors coincide under `extendL`. Steps 3 to 5 importing dimension counts from [L120Count.lean](../lean/HamiltonsCubic/Results/L120Count.lean) will need that transfer stated on `weylModuleS`.
- **The INDEX entry's step 1 and step 2 text** matches the files claim for claim: `projS`, `sum_projS`, `Lop_projS` from `leftMulS_act` and `leftMulS_unique`, `trace_sq_sectors` with the commutation, `projS_eq_zero` by the two flips, `trace_sq_support`. The phrase "at an e fixed by every sign flip" is the hypothesis in `diagSet` form, which is equivalent. Nothing in the entry is unproved by the files.
- **What the entry omits** from its owed list: sign-fixedness and existence of the general-`n` sphere-product element of `weylModuleS` (section 2), and idempotence plus the restriction lemma (section 3).

## 6. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only B12Sectors`: 8/8 declarations clean, resting on the standard three alone.
- `python3 scripts/misc/axiom_audit.py --only B12Support`: 4/4 declarations clean, resting on the standard three alone.
- The background tree build log (`/tmp/lean_tree_build.log`) ends in `Build completed successfully`, with only style-linter notes.

## 7. Falsifiers and the search for them

- `sum_projS`: a `Y` with `∑_t proj t Y ≠ Y`, which would need `2^{-n} ∑_t chi t u ≠ [u = ∅]`. Checked `sum_proj`'s reduction to `sum_chi` and the `u = ∅` term.
- `Lop_projS`: an `e` fixed by all `diagSet u` whose product fails to commute with some flip, which would contradict `leftMulS_unique`. Checked that the conjugation direction in `leftMulS_act` matches the evaluation at `actE g Y`: `conj L` is `actE ∘ L ∘ actE.symm`, so evaluating at `actE g Y` returns `actE g (L Y)`, the direction the proof uses.
- `trace_sq_sectors`: none beyond the two above, as it is linear algebra over them.
- `projS_card`: a Weyl `Y` with `proj t Y ≠ 0` at `|t| ∈ {1, 3}` or `|t| ≥ 5`. The global flip kills odd `|t|` and a coordinate touches at most four indices, and the one place a hidden assumption could enter, distinctness of `i, j, k, l`, is handled by `card_four_le`'s `≤`. The `n = 4` dimension count in section 5 is a consistency screen, done by hand.
- No computation was run beyond the axiom audit, under the analysis-only footing.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Steps 1 and 2 are correct, faithful to `block_card` and to the INDEX entry, and axiom-clean. The observations are two owed inputs that the B12 entry should list before step 6: the general-`n` unit sphere-product element of `weylModuleS` with its sign-fixedness, and `projS t` idempotent with the restriction lemma `tr(A ∘ P_t) = tr(A|range P_t)` for `A` commuting with `P_t`.
