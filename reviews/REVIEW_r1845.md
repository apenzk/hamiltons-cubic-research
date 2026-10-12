# Reviewer r1845, L27's pair sector, diagonal sector and sign-group assembly (pair_eq_pairVec, pairVec_ne, pairVec_comm, pair_sphere, fox_bridge, dn_sphere, card_four, comp_sector, L27_half, the L27 and L220 INDEX rows)

Cold Gate 2 review of commits 48a49c8e, 5600cc2f and f374c244 on the Lean layer, under the analysis-only footing. I read [L27Pair.lean](../lean/HamiltonsCubic/Results/L27Pair.lean), [L27Dn.lean](../lean/HamiltonsCubic/Results/L27Dn.lean) and [L27Main.lean](../lean/HamiltonsCubic/Results/L27Main.lean) in full, and the statements (and where needed the bodies) of every input the brief names: `LeLin`, `foxProd2_smul_left`, `comp`, `comp_char`, `sum_comp`, `comp_perp`, `comp_perp_ne`, `comp_zero`, `comp_eigen`, `pair_block_iff`, `trivial_block_iff`, `pairLin`, `pairMap`, `pairVec`, `rk2`, `mem_ker_blockSums1`, `cross_LeLin_spectrum`, `within_LeLin_spectrum`, `within_LeLin_spectrum_out`, `LeLin_pairVec_iff` (statement), `cross_top_iff`, `orbit_in_pairBlock`, `dn_excl_fox`, `KL_of_fox`, `dn_eig_line` and its section variables, `dn_units`, `sphereWeight`, `sphere_unit`, and r1844's O2, O3, O5, O6. I ran `lake env lean` on the three sources at HEAD (0 errors each, no `sorry`, `admit` or `native_decide`) and on a scratch file at `/private/tmp/r1845/check.lean` holding `#print axioms` for six declarations and an instance of `L27_half` at `n = 7`, `T = {0, 1, 2}` (0 errors). No numerical computation was run. Heartbeat log: [agent_logs/review-r1845.log](../agent_logs/review-r1845.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | `pair_eq_pairVec`: a Weyl `V` of character `ε_j ε_k` is `restrictLin (pairVec j k c)` with `c` on the Ricci cut | CONFIRMED |
| 2 | `pairVec_ne`, `pairVec_comm` | CONFIRMED |
| 3 | `pair_sphere`: `λ ≤ 1/2` on a nonzero pair component, `λ = 1/2` only at a cross pair | CONFIRMED |
| 4 | `fox_bridge`: `M ∘ D = cD` between restricted diagonal operators gives the bare relation on every `φ_ab` | CONFIRMED |
| 5 | `dn_sphere`: `λ < 1/2` on a nonzero character-1 Weyl operator orthogonal to `M`, at `p, q ≥ 3` | CONFIRMED |
| 6 | `card_four`, `comp_sector` | CONFIRMED |
| 7 | `L27_half`: every `L_e`-eigenvalue on `W⊥` is at most `1/2`, and at `1/2` every nonzero component sits on a cross pair | CONFIRMED |
| 8 | The L27 INDEX row at HEAD, its proved parts and its owed list | CONFIRMED WITH OBSERVATIONS |
| 9 | The L220 row's reworded sentence on the padded `W_CP²` appositive | CONFIRMED |

Summary: all nine Lean claims hold on the standard three axioms, `L27_half` is a faithful proof of the upper-bound half of L27 and of the localisation of `1/2` to the cross-pair sectors, and the L27 row carries one stale sentence and an owed list that should name attainment and the eigenvector-level step explicitly.

## A. `pair_eq_pairVec`

- `pairLin j k c` has `toFun Y := ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) Y` ([L120Pair.lean:168](../lean/HamiltonsCubic/Results/L120Pair.lean#L168)), and `pairVec j k c` is the same expression as a bare function ([L127Le.lean:32](../lean/HamiltonsCubic/Results/L127Le.lean#L32)). The closing `rfl` is therefore a genuine definitional unfolding of a structure field, and it compiles.
- `pairMap j k c` is `pairLin j k c ∘ₗ skewProj`. The proof evaluates at `X : skewSub`, applies `skewProj_skew` to remove the projection on a skew argument, and concludes by `ContinuousLinearMap.ext` over every `X` in the domain `skewSub (Fin n)`. The equality therefore holds on every skew matrix, which is the whole domain of a `CurvOp2`.
- Ricci cut: `mem_ker_blockSums1 A c` gives `(∀ i ∉ A, c i = 0) ∧ ∑ i ∈ A, c i = 0`, and the proof keeps the second conjunct with `A` the filter set. The first conjunct is discarded, which is harmless because `pairVec` reads `c` only on `A`. The sum condition is exactly the `hsum` shape the three spectrum theorems consume.
- `pairVec_ne` is the contrapositive: all coefficients on `A` zero makes every summand `0 • _`. `pairVec_comm` rewrites the filter by `and_comm` and uses that `rk2 U V = rk2 V U` up to `add_comm`, which holds from `rk2 U V X = ⟨V,X⟩U + ⟨U,X⟩V`.

Finding: none.

## B. `pair_sphere`

- `j ∈ T, k ∈ T`: `within_LeLin_spectrum` gives `λ ∈ {0, λ_p, −μ}`. `j ∉ T, k ∉ T`: `within_LeLin_spectrum_out` gives `λ ∈ {0, λ_q, −μ}`. `j ∈ T, k ∉ T`: `cross_LeLin_spectrum` with `hj hk` directly gives `λ ∈ {0, 1/2}`.
- `j ∉ T, k ∈ T`: the proof rewrites the filter set to the swapped order in `hsum` and `hne`, transfers `heig` along `pairVec j k c = pairVec k j c` (a `restrictLin` equality proved pointwise), and calls `cross_LeLin_spectrum T … hk hj`, whose signature asks `(hj : k ∈ T) (hk : j ∉ T)` and the swapped filter. The arguments line up and the file compiles. The conclusion `Or.inr ⟨hj, hk⟩` is the correct disjunct.
- `λ_p < 1/2`: `(p − 2)/(2(p − 1)) < 1/2` is `p − 2 < p − 1` after clearing the positive denominator `2(p − 1)`, valid at `p ≥ 2`. The same for `λ_q`. `−μ ≤ 0 < 1/2` since `μ = (p + q − 2)/(2(p − 1)(q − 1)) ≥ 0` at `p, q ≥ 2` (numerator `≥ 2`, denominator `≥ 2`). In the equality clause each non-cross value is shown `≠ 1/2` by `norm_num` (for `0`) or `linarith` against these strict bounds.
- The theorem proves no multiplicities, and L207's "`0` with multiplicity `n − 4` and `1/2` exactly once" is outside its claim. See E and O3.

Finding: none.

## C. `dn_sphere`

- `trivial_block_iff` writes the character-1 Weyl `D` as `restrict (diagOp_isWeyl hu)` for a weight `u`, and `u ≠ 0` follows from `D ≠ 0`. The eigen-equation becomes `M ∘ D = (λθ) D` through `LeLin M V = (Pcubic2 M)⁻¹ • foxProd2 M V` (the definition of `LeLin` plus `foxProd2_smul_left`) and `Pcubic2 M = Pcubic (diagOp w) = θ = t(n − 1)` (`Pcubic2_restrict`, `theta_of_unit`, `theta_of_critical_unit` at `sphere_isCritical`). `fox_bridge` then yields the bare relation on every `φ_ab` through `restrict_eq_restrictLin'` and `bridge_apply`, which is what `dn_excl_fox` consumes.
- `dn_excl_fox` places `λθ` in `{θ·1, θλ_p, θλ_q, θ(−μ), 0}`. Cancelling `θ > 0` gives `λ ∈ {1, λ_p, λ_q, −μ, 0}`. The last four are below `1/2` by the bounds of B and `dn_units`.
- The value `1`: `KL_of_fox` turns the bare relation into `KL w u = (λθ) • u`, and with `λθ = θ·1` this is `u ∈ dnWeights ⊓ eigenspace(dnθ T t * 1)`. `dn_eig_line` is stated under the section variables `hp : 3 ≤ T.card`, `hq : 3 ≤ Tᶜ.card`, `ht : t ≠ 0` ([L127DnEig.lean:59](../lean/HamiltonsCubic/Results/L127DnEig.lean#L59)), and `dn_sphere` supplies `hp hq ht.ne'`. It returns `span{sphereWeight T}`, so `u = s • sphereWeight T`.
- Then `D = coordOp u = s • coordOp(sphereWeight T) = (s/t) • M`, the rewrite chain using `coordOp_eq_restrict`, `coordOp_smul'` and `div_mul_cancel₀`. `⟨M, D⟩ = (s/t)·normSq2 M` by `innerOp2_smul_right`.
- `normSq2 M = 1`: `normSq2_restrict` identifies `normSq2 (restrict (diagOp_isWeyl hwt))` with `normSq (diagOp w)`, which is `hn`. So `⟨M, D⟩ = s/t = 0` forces `s = 0` (as `t ≠ 0`), then `u = 0`, contradicting `hu0`. The exclusion is correct.
- Mathematically this is the record's "`1` on `⟨W⟩`": on `𝒟_n` the `θ`-eigenspace of `M∘` is the line of `W` itself, which meets `W⊥` in `0`.

Finding: none.

## D. `comp_sector` and `L27_half`

- Exhaustiveness: `comp_zero s H hHW` concludes `comp s H hHW = 0` whenever `¬(|s| = 0 ∨ |s| = 2 ∨ |s| = 4)`, so `hs0 : comp s H hHW ≠ 0` forces the three-way split. `card_eq_zero`, `card_eq_two` and `card_four` then give `s = ∅`, `s = {j, k}` with `j ≠ k`, and `s = {i, j, k, l}` with six distinctness facts.
- `comp_perp`: `comp_perp hM1 ∅ hHW hperp` returns `comp ∅ H ∈ weylPerp M`, whose second component is `innerOp2 M (comp ∅ H) = 0`, exactly `dn_sphere`'s `hperp`. The character-1 hypothesis `hM1` on `M` comes from `trivial_block_iff` in the reverse direction. For `s ≠ ∅` orthogonality to `M` is automatic (`comp_perp_ne`) and unused, correctly, since the pair and four-set sectors carry no `⊥ M` hypothesis. The character of `comp ∅ H` is `setChar ∅ = 1` by `signChar_congr` with `simp [setChar]`.
- Units: `hLe` is `LeLin M V = θ⁻¹ • foxProd2 M V` with `θ = Pcubic2 M = t(n − 1)`, `hfox` is `foxProd2 M H = (λθ) • H`, `comp_eigen` carries it to `foxProd2 M (comp s H) = (λθ) • comp s H`, and `hcLe` returns `LeLin M (comp s H) = θ⁻¹ • (λθ) • comp s H = λ • comp s H` by `field_simp` under `θ ≠ 0`. Each sector therefore receives the same `λ` in `L_e` units.
- Four-set sector: `four_sphere_lt` is stated on `coordOp (t • sphereWeight T)`, and `hce'` rewrites through `coordOp_eq_restrict`. Its `θ > 0` hypothesis is discharged in place by `theta_of_unit` and `hPθ`, which is r1844 O3's suggestion carried out at the call site. After rewriting `θ`, `4(λθ)² < θ²` gives `4λ² < 1`, hence `λ < 1/2` (indeed `|λ| < 1/2`).
- `L27_half`: `sum_comp` writes `H` as the sum of its components, so `H ≠ 0` gives a nonzero component, `comp_sector` on it gives `λ ≤ 1/2`, and `comp_sector` on every nonzero component gives the cross-pair localisation at `λ = 1/2`.

Finding: none.

## E. Statement fidelity of `L27_half` against L27

What `L27_half` proves at a unit sphere product with `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, `t > 0`: every real eigenvalue of `L_e` on a nonzero `H ∈ W⊥` is at most `1/2`, and a `1/2`-eigenvector has all its nonzero isotypic components on cross-pair characters `ε_j ε_k`, `j ∈ T`, `k ∉ T`. It uses no representation theory of `O(p) × O(q)`, as the row says.

What L27 states beyond that, in its own order:

1. **Attainment** of `λ_max = 1/2`. `L27_half` only bounds, so equality of `λ_max` with `1/2` needs a nonzero `H ⊥ M` with `L_e H = H/2`. It follows from items 2 and 4 below once the orbit tangent is known to be nonzero, and it can also be obtained directly from `cross_top_iff` at a nonzero factor-constant `c` plus `LeLin_pairVec_iff`. The row does not name it. See O2.
2. **`E(1/2) ⊆` orbit tangent, eigenvector level.** `L27_half` places a `1/2`-eigenvector's components in the cross sectors, and `pair_eq_pairVec` plus `cross_LeLin_spectrum` gives each component the eigenvalue `1/2`, but no declaration yet says the component lies on `cross_top_iff`'s factor-constant line. That step is `LeLin_pairVec_iff` (LeLin to bare `foxProd`) composed with `cross_top_iff`, followed by the identification of that line with `orbitTan (diagOp w) j k` through `orbit_in_pairBlock`. The row names the second half ("the `1/2`-line of each cross pair block as the orbit direction") and leaves the first implicit. See O2.
3. **Orbit tangent `⊆ E(1/2)`**, and the orbit tangent inside `W⊥`. The first is the converse direction of 2 and falls out of the same identification. The second is `orbitTan ⊥ M`, which the row does not name. It is short but it is a separate fact.
4. **`dim E(1/2) = pq = dim(orbit)`.** Needs each cross line to be one-dimensional (L207's "`1/2` exactly once"), the within-factor `orbitTan` to vanish, and independence of the `pq` cross directions (distinct characters give orthogonality). The row's "`dim(orbit) = pq` with the orbit tangent spanned by the `T_jk`" covers the orbit side. Once 2 and 3 identify `E(1/2)` with the orbit tangent, the eigenspace side follows, so this item is complete in substance.
5. **Morse–Bott**: the Hessian-to-`L_e` step through `critMap_kernel_iff` (`DF = θ(2L_e − Id)`). Named in the row.

A hand check of item 2's identification, reported as a screen and outside any positive claim: at the sphere weight, `w_ji − w_ki` for `i ∈ T∖{j}` is `q/(p − 1) + 1 = (n − 1)/(p − 1)`, and for `i ∉ T ∪ {k}` it is `−1 − p/(q − 1) = −(n − 1)/(q − 1)`. The coefficients are constant on each factor and sum to `(n − 1) − (n − 1) = 0` over the `p − 1` and `q − 1` indices, which is the shape `cross_top_iff` characterises. For `j, k` in one factor the differences vanish off `{j, k}`, and the `i ∈ {j, k}` terms carry `φ_jj = 0` or `φ_kk = 0`. Nothing here suggests the owed step will fail.

Verdict on fidelity: `L27_half` is exactly what its docstring and the row say it is. It is the `≤` half and the sector localisation of L27, and the row's **partial** state and "statement: not typed" are accurate.

## F. Hypothesis inventory, axioms and an instance

- `#print axioms` on `pair_eq_pairVec`, `pair_sphere`, `fox_bridge`, `dn_sphere`, `comp_sector`, `L27_half`: each `[propext, Classical.choice, Quot.sound]`.
- Hypotheses of `L27_half`: `T` with `3 ≤ |T|`, `3 ≤ |Tᶜ|`, `¬(|T| = 3 ∧ |Tᶜ| = 3)`, `t > 0` with `normSq (diagOp (t • sphereWeight T)) = 1`, `H` Weyl, `⟨M, H⟩ = 0`, `H ≠ 0`, `L_e H = λH`. Each is one of L27's hypotheses or the meaning of "eigenvalue on `W⊥`". No hypothesis restates a conclusion. `pair_sphere` asks only `p, q ≥ 2` and is used at `p, q ≥ 3`. `four_sphere_lt`'s `θ > 0` is discharged inside `comp_sector`.
- Instance: [/private/tmp/r1845/check.lean](../../../../private/tmp/r1845/check.lean) (absolute `/private/tmp/r1845/check.lean`) proves by `decide` that `T = {0, 1, 2} ⊆ Fin 7` has `|T| = 3`, `|Tᶜ| = 4`, off `(3, 3)`, obtains `t > 0` with the unit normalisation from `L2Operators.sphere_unit`, and states and proves, through `L27_half`, `∀ H Weyl, ⟨M, H⟩ = 0 → H ≠ 0 → ∀ λ, L_e H = λH → λ ≤ 1/2` at that `t`. It compiles with 0 errors. The geometric hypotheses are therefore jointly satisfiable at `p = 3, q = 4`. The `H`-level hypotheses are not exhibited by a concrete operator: a nonzero `L_e`-eigenvector on `W⊥` exists by the spectral theorem for the self-adjoint `L_e` on a space of positive dimension, and exhibiting one concretely in Lean is item 1 of E.

## G. What would break each statement, and what I did to look

- `pair_eq_pairVec`: a character-`ε_j ε_k` Weyl operator outside `pairMap`'s image on the Ricci cut, or `pairLin` differing from `pairVec` off the skew subspace. I read `pair_block_iff` (an iff into the kernel's image), `pairMap` (precomposition with `skewProj`) and both definitions. The domain is skew, where `skewProj` is the identity.
- `pair_sphere`: a within-factor pair value `≥ 1/2`, or a cross value outside `{0, 1/2}`. I read the three spectrum statements and checked the three values against `1/2` at `p, q ≥ 2` by hand.
- `dn_sphere`: a character-1 value-`1` eigenvector off the sphere-weight line, or a `normSq2` normalisation other than `1`. I read `dn_eig_line`'s hypotheses and the `normSq2_restrict` rewrite, and followed the `s/t` scaling line by line.
- `comp_sector`: a nonzero component at a character of size `1`, `3` or `≥ 5`, a component whose eigenvalue differs from `H`'s, or `comp ∅ H` not orthogonal to `M`. I read `comp_zero`, `comp_eigen` and `comp_perp`, and checked the `θ⁻¹ · λθ = λ` unit conversion.
- `L27_half`: a nonzero `H` with every component zero. `sum_comp` rules it out.
- Joint vacuity: the `n = 7` instance of F.

## Observations

- **O1.** The L27 row at HEAD still carries the sentence "**Owed for the assembly**, each sector's spectrum being already typed: `𝒟_n` through `dn_excl_fox` and `dn_eig_line`, with `W⊥` excluding the value `1`; the pair blocks through `cross_LeLin_spectrum` and `within_LeLin_spectrum`, with `cross_top_iff` placing `1/2` on the orbit line, once a character-`ε_j ε_k` component is written on the pair span; and the assembly itself." The same row then records the `𝒟_n` sector, the pair sector and the assembly as **PROVED**. The sentence is stale and contradicts the row's later text. Remove it, keeping only its `cross_top_iff` clause, which belongs to the closing owed list.
- **O2.** The row's closing owed list is accurate for what it names and should add two items by name. First, attainment: a nonzero `H ⊥ M` with `L_e H = H/2`, since `L27_half` bounds and `λ_max = 1/2` needs equality. Second, the eigenvector-level step: a cross-pair component with `L_e`-eigenvalue `1/2` lies on `cross_top_iff`'s factor-constant line, through `LeLin_pairVec_iff`, before that line is matched with `orbitTan` through `orbit_in_pairBlock`. It may also name `orbitTan ⊥ M` (the orbit tangent inside `W⊥`). None of these needs representation theory, and none affects the **partial** state.
- **O3.** L207's multiplicity clause ("`0` with multiplicity `n − 4` and `1/2` exactly once") is not typed by `pair_sphere`, which proves membership of the value only. The one-dimensionality of the `1/2` line is what `dim E(1/2) = pq` rests on. It is implicit in `cross_top_iff` (the line is fixed by two sums tied by `hsum`, leaving one free parameter), and the owed `dim` item should cite it.
- **O4.** `pair_eq_pairVec` discards the first conjunct of `mem_ker_blockSums1` (`c` vanishes off the filter set). This is correct, since `pairVec` never reads those coefficients, and it means the returned `c` is not unique. Any later use that needs a canonical coefficient vector should take it from the kernel condition, which the theorem's statement does not export.
- **O5.** The L220 row's reworded sentence, "the appositive naming the six operators padded `W_CP²` on `Q` is argued in the record's step 9 and is untyped here, CP2Real's `Wc` being the object a typed comparison would use (r1844 O2)", resolves r1844 O2: it places the appositive inside L220 as untyped rather than outside it. It omits r1844's suggested "carries no weight in the inequality, the equality set or the `n ≥ 12` clause", which is a clarity loss and changes no claim.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** `pair_eq_pairVec`, `pairVec_ne`, `pairVec_comm`, `pair_sphere`, `fox_bridge`, `dn_sphere`, `card_four`, `comp_sector` and `L27_half` are correct, compile at HEAD on the standard three axioms, and have jointly satisfiable hypotheses at `p = 3, q = 4`. `L27_half` proves the upper bound of L27 and localises the value `1/2` to the cross-pair sectors, faithfully to its docstring. The L27 row's **partial** state is right. Its stale "Owed for the assembly" sentence should go (O1), and its owed list should name attainment and the eigenvector-level step through `LeLin_pairVec_iff` (O2, O3). The L220 rewording is accepted (O5). No REFUTED verdict.
