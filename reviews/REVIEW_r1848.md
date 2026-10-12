# Reviewer r1848, L27's orbit-tangent span and the rectangle identity's operator steps (orbit_pairVec, cross_half_line, L27_half_orbit, orbitOp_props, L27_half_span, triple_char_zero, Rot_T, Rot_comm, fox_w4, fox_matched, tau_matched, the L27 and I121 INDEX rows)

Cold Gate 2 review of commits 2fd883fa, 46afc170 and db4cb734 on the Lean layer, under the analysis-only footing. I read [L27Orbit.lean](../lean/HamiltonsCubic/Results/L27Orbit.lean), [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean) and [RectOp.lean](../lean/HamiltonsCubic/Results/RectOp.lean) in full, and at source the definitions the brief names: `orbitTan` and `orbit_in_pairBlock` ([L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean)), `cross_top_iff` ([L127Mult.lean](../lean/HamiltonsCubic/Results/L127Mult.lean)), `cross_orbit_exists` ([L127Spec.lean](../lean/HamiltonsCubic/Results/L127Spec.lean)), `pairVec` and `LeLin_pairVec_iff` ([L127Le.lean](../lean/HamiltonsCubic/Results/L127Le.lean)), `Rot`, `Smat`, `Rot_orth`, `c45` ([PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean)), `uj`, `vy`, `uj_norm` ([DiagSquare.lean](../lean/HamiltonsCubic/Results/DiagSquare.lean)), `sig4`, `w4`, `sig_eq`, `w4_weyl` ([FourSquare.lean](../lean/HamiltonsCubic/Results/FourSquare.lean)), `rot_out` ([L224Rot.lean](../lean/HamiltonsCubic/Results/L224Rot.lean)), `foxProd2_coordOp` ([ItemFour.lean](../lean/HamiltonsCubic/Results/ItemFour.lean)), `norm_sig` ([FourStep5.lean](../lean/HamiltonsCubic/Results/FourStep5.lean)), `sigA_mat` and `sigB_mat` ([FourIdent.lean](../lean/HamiltonsCubic/Results/FourIdent.lean)), `foxProd_congr_on_skew` ([FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean)), `comp`, `sum_comp` ([L120Decomp.lean](../lean/HamiltonsCubic/Results/L120Decomp.lean)), `comp_sector` and `L27_half` ([L27Main.lean](../lean/HamiltonsCubic/Results/L27Main.lean)), `setChar`, `setChar_sep`, `char_orth` ([L120Blocks.lean](../lean/HamiltonsCubic/Results/L120Blocks.lean)), `setChar_symmDiff` ([L221Ops.lean](../lean/HamiltonsCubic/Results/L221Ops.lean)), `foxProd2_char2` ([L222Op.lean](../lean/HamiltonsCubic/Results/L222Op.lean)), `sphereWeight` and its entry lemmas ([Families.lean](../lean/HamiltonsCubic/Base/Families.lean)), and the L27 and I121 rows of [lean/INDEX.md](../lean/INDEX.md) at HEAD, together with the conventions section of [the I121 note](2026-09-28d-I121-smallmass-direct.md). I ran `lake env lean` on two scratch files under `/private/tmp/r1848/` holding `#print axioms` for ten declarations and `#check` of three signatures. No numerical computation was run. Every check below that is not a Lean output is a hand derivation. Heartbeat log: [agent_logs/review-r1848.log](../agent_logs/review-r1848.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | `rk2_phi_self_left`, `rk2_phi_self_right`, `orbit_pairVec`: `T_jk = pairVec j k (w_{j·} − w_{k·})` on skew matrices | CONFIRMED |
| 2 | `cross_half_line`: a Ricci-cut coefficient vector carrying `θ/2` at a cross pair is a multiple of `(w_{ji} − w_{ki})_i` | CONFIRMED |
| 3 | `comp_LeLin`, `L27_half_orbit`: every nonzero isotypic component of a `1/2`-eigenvector in `W⊥` is `a · T_jk` for a cross pair | CONFIRMED |
| 4 | `corb`, `corb_sum`, `orbitOp`, `pairVec_corb`, `orbitOp_apply`, `orbitOp_nuX` | CONFIRMED |
| 5 | `orbitOp_props`: a cross `T_jk` is Weyl, of character `ε_jε_k`, nonzero, orthogonal to `M`, and a `1/2`-eigenvector of `L_e` | CONFIRMED |
| 6 | `crossOrbit`, `mem_cross`, `L27_half_span`: `E(1/2) ∩ W⊥` is the span of the cross orbit tangents | CONFIRMED |
| 7 | `triple_char_zero`, `single_zero`: the note's step 1 | CONFIRMED |
| 8 | `isOrth_mul'`, `Rot_T`, `mulRot`, `Rot_comm` | CONFIRMED |
| 9 | `uj_mul_zero`, `uj_dot_zero`, `w4_hollow'`, `w4_off`, `w4_mul`, `w4_had`, `w4_T'`, `fox_w4` | CONFIRMED |
| 10 | `fox_matched`, `tau_matched`, and their reading as the identity's `4X₁₂X₁₃X₂₃` at raw `(0,1,1)` | CONFIRMED |
| 11 | The L27 INDEX row at HEAD, its proved parts and its owed list | CONFIRMED WITH OBSERVATIONS |
| 12 | The I121 (the rectangle identity) INDEX row at HEAD | CONFIRMED WITH OBSERVATIONS |

Summary: every Lean claim holds on the standard three axioms and says what its docstring says, `L27_half_span` is a faithful two-sided characterisation of `E(1/2) ∩ W⊥`, `tau_matched` is correctly the identity's pure-`X` basis value, and the two INDEX rows carry a garbled owed sentence, an owed list missing one item, a within-factor lemma elsewhere in the layer whose hypothesis no sphere product meets, and one unsupported remark about frames.

## A. `orbit_pairVec` and `cross_half_line`

- `orbit_in_pairBlock` gives `orbitTan (diagOp w) j k X = ∑_i (w_{ji} − w_{ki}) · rk2(φ_{ji}, φ_{ki}) X` over all `i` for skew `X`, under symmetry and hollowness of `w`. `pairVec j k c` sums the same summand over `i ∉ {j, k}`. The two sums differ by the terms `i = j` and `i = k`, where one argument of `rk2` is `φ_{ii} = 0` by `phi_self`, and `rk2` is bilinear in its two matrix arguments (`rk2 U V X = ⟨V,X⟩U + ⟨U,X⟩V`). So the dropped terms vanish and `c_i = w_{ji} − w_{ki}` is right. The proof splits the sum by `sum_filter_add_sum_filter_not` and kills the complement with the two `rk2_phi_self` lemmas, which is exactly this argument.
- `cross_top_iff` characterises the `θ/2`-eigenvectors on the pair span at a cross pair, `j ∈ T`, `k ∉ T`, as `c_q = S_T/(p − 1)` for `q ∈ T \ {j}` and `c_q = S_O/(q − 1)` for `q ∉ T ∪ {k}`, with `S_T`, `S_O` the partial sums over the pair's index set. On the Ricci cut, `S_O = −S_T`.
- The sphere-weight entries, from `sphereWeight` in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean): `t·q/(p−1)` inside `T`, `t·p/(q−1)` inside `Tᶜ`, `−t` across (here `p = |T|`, `q = |Tᶜ|`). By hand, for `i ∈ T \ {j}`: `w_{ji} − w_{ki} = t·q/(p−1) − (−t) = t(p+q−1)/(p−1)`. For `i ∉ T ∪ {k}`: `w_{ji} − w_{ki} = −t − t·p/(q−1) = −t(p+q−1)/(q−1)`.
- With `a = S_T/(t(p+q−1))`, the first gives `a·t(p+q−1)/(p−1) = S_T/(p−1)` and the second gives `−S_T/(q−1) = S_O/(q−1)`. Both match `cross_top_iff`. The Lean witness is exactly this `a`, and the two branches close by `field_simp; ring` after rewriting with `sphereWeight_in`, `sphereWeight_cross`, `sphereWeight_out` and `hSO`.
- `cross_half_line` uses only the forward direction of `cross_top_iff`, which is all `L27_half_orbit` needs. The converse direction (the orbit coefficients do carry `θ/2`) is supplied separately by `cross_orbit_exists` in `orbitOp_props`.

Finding: none.

## B. `L27_half_orbit`, `orbitOp_props`, `L27_half_span`

- `L27_half_orbit`: `comp_sector` puts a nonzero component at `λ = 1/2` on `s = {j, k}` with `j ∈ T`, `k ∉ T`. `comp_LeLin` transfers the eigen-equation to the component through `comp_eigen` at the character-1 operator `M`, with `L_e V = θ⁻¹ (M ∘ V)` and `θ = t(p+q−1)` from `theta_of_critical_unit`. `pair_eq_pairVec` writes the component as `restrictLin (pairVec j k c)` with `c` on the Ricci cut, `LeLin_pairVec_iff` turns `L_e = 1/2` into the bare `foxProd` relation with eigenvalue `θ/2`, `cross_half_line` gives `c = a·(w_{j·} − w_{k·})` on the index set, and `orbit_pairVec` identifies the result with `a · T_jk` on skew matrices. Each step is the one the docstring names.
- Forward inclusion of `L27_half_span`: `sum_comp` writes `H` as the sum of `comp s H` over all `s : Finset (Fin n)` (the full powerset, so no component is missed). Each nonzero component equals `a • orbitOp T t j k` for a cross pair by `L27_half_orbit` and `orbitOp_apply`, hence lies in the span. Zero components contribute zero.
- Backward inclusion: `Submodule.span_induction`, with the generator case from `orbitOp_props` and the zero, sum and scalar cases from linearity of `innerOp2` in the right slot and of `LeLin`. The zero case derives `⟨M, 0⟩ = 0` from additivity, which is valid.
- Orthogonality to `M` in `orbitOp_props`: `M` has character `1` (`trivial_block_iff`), `orbitOp` has `setChar {j, k}`. At the flip `ε = −1` at `j`, `+1` elsewhere, `setChar {j, k} ε = ε_j ε_k = −1` because `j ≠ k`, so `1 · (−1) = −1` and `char_orth` gives `⟨M, T_jk⟩ = 0`. Correct.
- Eigen-relation transfer: `LeLin_pairVec_iff` needs `foxProd (diagOp w) (pairVec j k corb) Z = (1/2 · P)·pairVec j k corb Z` on skew `Z`. `foxProd_congr_on_skew` replaces `pairVec j k corb` by `orbitTan` inside `foxProd`, with hypotheses that `diagOp w` and `pairVec` preserve skew matrices (both hold: `(diagOp_isWeyl hwt).1` and `pairVec_skew`), that the first operators agree (`rfl`) and that `pairVec` and `orbitTan` agree on skew matrices (`hagree`, from `pairVec_corb` and `orbit_pairVec`). Only the unprimed pair is required to preserve skewness, which the lemma's signature confirms. `cross_orbit_exists` then supplies the `θ/2` relation for `orbitTan`, and `hagree` rewrites back. Correct.
- Nonzero: `cross_orbit_exists` gives a skew `X` with `T_jk X ≠ 0`, and `orbitOp_apply` shows `orbitOp` would send it to zero if `orbitOp = 0`.
- `orbitOp_props` is stated at `p, q ≥ 2`, wider than L27's `p, q ≥ 3`. This is harmless and correct, since attainment of `1/2` on cross orbit tangents does not use the four-set bound.

Finding: none.

## C. Statement fidelity against L27

- With `L27_half` (every eigenvalue on a nonzero Weyl `H ⊥ M` is at most `1/2`), `orbitOp_props` (`1/2` is attained) and `L27_half_span` (`E(1/2) ∩ W⊥` is the span of the cross orbit tangents), the Lean layer holds the eigenvector-level content of *"`λ_max(L_e|_{W⊥}) = 1/2`, attained on the cross orbit tangents"* and L207's *"the cross-pair `1/2`-eigenvector IS the orbit direction"*.
- What remains of L27, checked against the owed list:
  - `dim E(1/2) = pq`: the `pq` cross `T_jk` are nonzero with pairwise distinct characters `ε_jε_k` (distinct pairs `{j,k}` give distinct Finsets, separated by `setChar_sep`), so they are pairwise orthogonal by `char_orth` and linearly independent. The INDEX names this route through `split_unique`. Accurate and short.
  - `dim(orbit) = pq`: the orbit tangent space is spanned by all `T_ab`, and the within-factor ones vanish. By hand, for `a, b ∈ T`, `w_{ai} − w_{bi}` is `0` at every `i ∉ {a, b}` (both `t·q/(p−1)` inside `T`, both `−t` across), so `orbit_pairVec` gives `T_ab = 0` on skew matrices in two lines, and likewise inside `Tᶜ`. Accurate, but see O3: the layer's existing within-factor lemma does not deliver this.
  - The Hessian step behind *Morse–Bott*, with `critMap_kernel_iff`'s `DF = θ(2L_e − Id)`. Accurate.
  - Missing from the list: `λ_max(L_e|_{W⊥})` is a statement about an operator on `W⊥`, so it needs `L_e` to map `W⊥` into itself and to be self-adjoint there, so that the eigenvalue bound of `L27_half` bounds the whole spectrum. Both are standard (`⟨M∘H, K⟩` is symmetric at self-adjoint arguments by `foxTri2_symm_right`, and `L_e M = M` gives invariance of `M⊥`), but neither is named. See O2.
- The phrase *"attained exactly on the orbit tangent"* also needs the identification of the span of the cross `T_jk` with the whole orbit tangent space, which is the within-factor vanishing above. The row lists it.

Finding: the owed list is accurate in each item and one item short (O2). Its second item is worded ungrammatically (O1).

## D. `triple_char_zero`

- The statement is for an arbitrary `Fintype` index type with `DecidableEq`, arbitrary Finsets `Q₁, Q₂, Q₃` (not only four-sets), and arbitrary `CurvOp2` operators of those sign characters. The `#check` output confirms the universe-polymorphic signature.
- Proof: `foxProd2_char2` gives `A ∘ B` the character `setChar Q₁ · setChar Q₂`, which `setChar_symmDiff` identifies with `setChar (Q₁ △ Q₂)` on sign vectors. `setChar_sep` produces a sign vector separating `Q₁ △ Q₂` from `Q₃` when they differ, and `char_orth` closes. Correct for all Finsets.
- Fidelity: the note's step 1 says `T(ν_{Q₁}, ν_{Q₂}, ν_{Q₃}) = 0` unless `χ_{Q₁△Q₂△Q₃} = 1`. On the sign group, `χ_R = 1` exactly when `R = ∅`, and `Q₁ △ Q₂ △ Q₃ = ∅` exactly when `Q₁ △ Q₂ = Q₃`. The hypothesis `symmDiff Q₁ Q₂ ≠ Q₃` is therefore the exact negation of the note's exceptional case.
- `single_zero`: `Q △ Q = ∅ ≠ Q` for nonempty `Q`. Correct, and the INDEX's gloss `χ_Q³ ≠ 1` is the same fact.

Finding: none.

## E. `Rot_comm`, `Rot_T`, `mulRot`

- `Rot j k c s` has column `j` equal to `c e_j + s e_k` and column `k` equal to `−s e_j + c e_k`, identity elsewhere, so on the `(j, k)` block it is `[[c, −s], [s, c]]`. Its transpose is `[[c, s], [−s, c]]`, which is `Rot j k c (−s)`. Correct for all real `c, s`, with no orthogonality hypothesis, as the Lean statement has it.
- `mulRot`: `(A·Rot)_{p x} = c A_{px} + s A_{py}`, `(A·Rot)_{p y} = −s A_{px} + c A_{py}`, other columns unchanged. Matches the statement.
- `Rot_comm`: two matrices that are the identity outside disjoint 2-planes and block rotations inside commute, for all `c, s, c', s'`. The hypotheses are the four cross inequalities plus `a ≠ b`, `a' ≠ b'`, which is exactly disjointness of the planes.
- `isOrth_mul'`: product of orthogonal matrices is orthogonal, both one-sided identities. Correct.

Finding: none.

## F. `fox_w4`, `fox_matched`, `tau_matched`

- By hand, write `u = u_{ij}`, `v = u_{kl}`, `z = u_{mp}`. Their supports are pairwise disjoint, so `u·v = u·z = v·z = 0` (`uj_dot_zero`) and `u·u = 2` (`uj_norm`). Then `w4 ij kl = uvᵀ + vuᵀ`, `w4 ij mp = uzᵀ + zuᵀ`, and `(uvᵀ + vuᵀ)(uzᵀ + zuᵀ) = (u·u) vzᵀ = 2vzᵀ`, the other three terms carrying a vanishing dot product. The reverse order gives `2zvᵀ`. Half the sum is `vzᵀ + zvᵀ = w4 kl mp`. So `w4_mul` holds.
- `w4_had`: the `(a, b)` entry is `(u_a v_b + v_a u_b)(u_a z_b + z_a u_b)`, whose four terms each contain one of `v_b z_b`, `u_a z_a`, `v_a u_a`, `v_a z_a`, all zero by disjoint supports. So `w4_had` holds.
- `fox_w4` then follows from `foxProd2_coordOp`, `(coordOp a) ∘ (coordOp b) = coordOp (a ⊙ b + ½(ab + ba))` for symmetric hollow `a, b`, whose hypotheses are supplied by `vv_sym` and `w4_hollow'`.
- `fox_matched`: `sig_eq` writes each `σ` as `coordOp w4` conjugated by the `45°` rotations in its own two planes, and `Rot_T` turns the transposes into `Rot · · c45 (−c45)`. `rot_out` shows the third plane's rotation fixes each `coordOp w4`, since `w4` vanishes on rows and columns of that plane (`w4_off`). With `Rot_comm` the three sandwiches become `rotR U` of the three coordinate operators for the single `U = R1 R2 R3`, and `foxProd2_rotR` moves `∘` through `U`. Correct.
- The sandwich's raw coordinates, by hand: for skew `X`, `(S_{ij} X S_{kl} + S_{kl} X S_{ij})_{pq} = X_{p'q'}` for `p ∈ {i,j}`, `q ∈ {k,l}`, with `'` the partner in the edge, and zero off those blocks. With `φ_{ab} = E_{ba} − E_{ab}`, this sends `φ_{ij} ↦ 0`, `φ_{ik} ↦ φ_{jl}`, `φ_{il} ↦ φ_{jk}`. So `a = W_{ij,kl} = 0`, `b = W_{ik,jl} = 1`, `c = W_{il,jk} = 1`, Bianchi `a = b − c` holds, `J = 0`, `X = ½(b + c) = 1`.
- Sign convention against `spanVec`: `sigB_mat` states `S_{ij} Y S_{kl} + S_{kl} Y S_{ij} = spanVec i j k l 0 (−1) 1 Y`. The note records that the signed coordinates are `(a, −b, c)` in the raw entries because `spanVec`'s middle term is written with `φ_{ki}`. So signed `(0, −1, 1)` is raw `(0, 1, 1)`, agreeing with the hand computation. `sigA_mat` (signed `(1, 0, −1)`, raw `a = 1` for `σ_{ik|jl}`) is consistent with the same partner rule.
- Normalisation: the note's `rect_norm` gives `‖ν_Q‖² = 2(a² + b² + c²) = 4X² + 3J²`, which at raw `(0,1,1)` is `4`, and `norm_sig` gives `normSq2 (sig4 a b c d) = 4`. So the raw entries are on the same scale as `innerOp2`, and `τ = ⟨σ_{kl|mp}, σ_{kl|mp}⟩ = 4 = 4·1·1·1` is the identity at `J = 0`, `X = 1` on all three blocks, each `ν_{ab}` read in its matched pairing `(e_a|e_b)`.
- Orientation: swapping the two indices of an edge swaps `b` and `c` and negates `a`, so `X` is orientation-independent. The pure-`X` check is therefore independent of how `sig4`'s arguments are ordered within each edge.

Finding: none.

## G. The I121 row

- Eight basis values: `τ` is trilinear in the three blocks' `(J, X)` coordinates, so the identity is equivalent to its values on `2³ = 8` basis triples. `tau_matched` is the `XXX` one. The remaining seven are the six mixed ones (value `0`) and `JJJ` (value `3/2`). The row's "six mixed basis values and the `3/2` at `JJJ`" is accurate.
- *"whose triples of crossing-pairing sandwiches no single frame diagonalises"*: this is a remark about proof route, supported by no Lean statement and no argument in the row. The pure-`J` direction of `V_Q` relative to `(ij|kl)` (raw `(1, ½, −½)`) is a combination of the crossing sandwiches `σ_{ik|jl}` and `σ_{il|jk}`, and the natural frames for `σ_{ik|jl}` and `σ_{ij|mp}` rotate the overlapping planes `ik` and `ij`, so the remark is plausible. But the nonzero eigenspaces of each sandwich are degenerate, which leaves room for other frames, and I did not settle it. See O4.

Finding: accurate on what is owed. The frame remark is an unverified assertion.

## H. Axioms and hypothesis inventory

- `#print axioms` on `L27_half_span`, `orbitOp_props`, `L27_half_orbit`, `cross_half_line`, `triple_char_zero`, `single_zero`, `fox_matched`, `tau_matched`, `Rot_comm`, `Rot_T`: each depends on `[propext, Classical.choice, Quot.sound]` and nothing else.
- [L27Orbit.lean](../lean/HamiltonsCubic/Results/L27Orbit.lean): `orbit_pairVec` assumes `w` symmetric and hollow and `j ≠ k`, `X` skew. `cross_half_line` assumes `p, q ≥ 2`, `t > 0`, a cross pair, the Ricci cut and the `θ/2` relation. `comp_LeLin` assumes `p, q ≥ 2`, `t > 0`, unit norm, `H` Weyl and the eigen-equation. `L27_half_orbit` assumes L27's hypotheses (`p, q ≥ 3`, `(p,q) ≠ (3,3)`, `t > 0`, unit norm), `H` Weyl, `H ⊥ M`, `L_e H = H/2`, and a nonzero component.
- [L27Span.lean](../lean/HamiltonsCubic/Results/L27Span.lean): `corb_sum` assumes `IsWeight w`, `j ≠ k`. `orbitOp_props` assumes `p, q ≥ 2`, `t > 0`, unit norm, `j ∈ T`, `k ∉ T`. `L27_half_span` assumes L27's hypotheses and `H` Weyl. All are satisfiable: the unit-norm `t` exists by scaling, since `normSq (diagOp (t • w))` is `t²` times a positive constant.
- [RectOp.lean](../lean/HamiltonsCubic/Results/RectOp.lean): `triple_char_zero` assumes the three characters and `Q₁ △ Q₂ ≠ Q₃`. `Rot_T`, `mulRot` assume `a ≠ b`. `Rot_comm` assumes two disjoint planes. The `w4`/`sig4` section assumes the fifteen pairwise inequalities among six indices, which is exactly "three disjoint edges". `w4_T'` omits all but `i ≠ j` in its section context and is `vv_sym`.
- No `sorry`, `admit` or `native_decide` in the three files.

## I. What would break each main statement, and what I did to look

- `orbit_pairVec`: a sign or index slip in `orbit_in_pairBlock`, or a nonvanishing `i ∈ {j, k}` term. I checked the dropped terms vanish by `φ_{ii} = 0` and bilinearity of `rk2`.
- `cross_half_line`: a wrong ratio between the two factors' coefficients. I recomputed both branches from `sphereWeight` and matched them to `cross_top_iff` with one scalar.
- `L27_half_orbit` and `L27_half_span`: a component outside the sectors `|s| ∈ {0, 2, 4}`, or a component `sum_comp` misses. I confirmed `sum_comp` ranges over all Finsets, and that the sector bounds come from the already-reviewed `comp_sector` (r1845).
- `orbitOp_props`: an eigen-relation proved for `orbitTan` failing to transfer to the Weyl-typed `orbitOp`. I read `foxProd_congr_on_skew`'s hypotheses and checked each is discharged by a true fact.
- `triple_char_zero`: two distinct Finsets with equal characters. `setChar_sep` flips one coordinate of the symmetric difference, which I checked separates them.
- `fox_matched`: a transpose or angle-sign mismatch between the three conjugations. I checked `Rot_T` by hand and that `sig_eq` with `Rot_T` yields the same `Rot · · c45 (−c45)` in all three.
- `tau_matched` as the identity's `4XXX`: a normalisation mismatch between raw entries and `innerOp2`, or a sign flip in `spanVec`'s middle term. I computed the raw coordinates by hand, read them against `sigB_mat` and the note's signed convention, and matched `rect_norm` to `norm_sig`.
- None of these was found.

## Observations

- **O1.** The L27 row's owed list reads *"`dim(orbit) = pq`, the orbit tangent space spanned by all `T_ab` with the within-factor ones zero with the orbit tangent spanned by the `T_jk`"*. The doubled "with" makes the clause unparseable. Suggested: *"the orbit tangent space is spanned by all `T_ab`, the within-factor ones are zero, so it is spanned by the `pq` cross `T_jk`"*.
- **O2.** The owed list omits that `L_e` maps `W⊥` into itself and is self-adjoint there, which `λ_max(L_e|_{W⊥})` presupposes and which turns `L27_half`'s eigenvector bound into a spectral bound. Both follow in a few lines (`foxTri2_symm_right` at the self-adjoint `M`, and `L_e M = M`), and the item should be named.
- **O3.** `orbitTan_within_zero` in [L122Cap.lean:230](../lean/HamiltonsCubic/Results/L122Cap.lean#L230) assumes `∀ i, w j i = w k i`. At `i = j` this forces `w_{kj} = w_{jj} = 0`, but at a within-factor pair of a sphere product `w_{kj} = t·q/(p−1) ≠ 0`. So the lemma never applies to the case its docstring names (*"as for `j, k` in the same factor of a sphere product"*), and the owed within-factor vanishing cannot be discharged through it. The fix is to quantify over `i ∉ {j, k}` (or to go through `orbit_pairVec`, as in C). The lemma is unused, so nothing downstream is affected. It sits outside this review's commits and is recorded because it bears on the L27 owed list.
- **O4.** The I121 row's *"no single frame diagonalises"* is an unsupported claim about proof route. It should be marked as a heuristic or dropped, since the owed `JJJ` value can be reached by trilinearity and any representative with `J = 1`, `X = 0`, whichever frame computes it.
- **O5.** `tau_matched` is one of eight basis values, and the file's docstring and the row say so. The row's wording is accurate. No change needed.

## Overall verdict

CONFIRMED WITH OBSERVATIONS. All ten Lean claims are correct on the standard three axioms, `L27_half_span` characterises `E(1/2) ∩ W⊥` in both directions, and `tau_matched` is correctly the rectangle identity's `4X₁₂X₁₃X₂₃` at raw `(0, 1, 1)`. The INDEX rows need O1 and O2 in the L27 owed list, O3 fixed or noted where the within-factor step is taken, and O4 softened in the I121 row.
