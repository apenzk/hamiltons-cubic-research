# REVIEW r1745: L57 on the block family, [L57Block.lean](../lean/HamiltonsCubic/Results/L57Block.lean)

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every declaration states what the file header and the INDEX rows say, the proofs are sound as read, and the L227 and L228 rows claim only what is typed, with the rotation still owed. The observations are two stale record paragraphs, an unlisted item-3 assembly in the L228 row, and a hypothesis stronger than used.

Scope: the file as committed in b2beb8d7 (identical to the working tree), [L226Statement.lean](../lean/HamiltonsCubic/Results/L226Statement.lean) for `eps`, `blockCoeff`, `blockOp`, `opOf`, `Ric_blockOp_J`, `Ric_blockOp_outer`, [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) for `diagOp` and `IsWeight`, [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `Ric`, `Pcubic`, `norm`, `L57_diagonal` in [L57Diagonal.lean](../lean/HamiltonsCubic/Results/L57Diagonal.lean), Lemmas L227 and L228 in [second-order.md](../findings/second-order.md), and the L227 and L228 rows of [lean/INDEX.md](../lean/INDEX.md). No `lake build` was run. The file has no `sorry`, `native_decide` or `axiom`. Its `.olean` is dated 01:22 against a source mtime of 01:21:34 and the trace carries no error, which is consistent with a clean compile (an inference from timestamps). No numerical screen was run: every check below is by hand from the definitions.

## (1) `wOf` is the right weight

- J pair: `blockCoeff (inl p) (inl q) (inl r) (inl s) = Σ_{x,y} ε_pqx ε_rsy S_xy`. At diagonal `S` this is `Σ_x ε_pqx ε_rsx S_xx`. For `p ≠ q` only `x = c`, the complement, survives, and `ε_rsc ε_pqc` is `+1` at `(r,s) = (p,q)`, `-1` at `(q,p)`, `0` otherwise. So the J block sends `φ_pq` to `S_cc φ_pq`, and `wOf (inl p) (inl q) = Σ_x ε_pqx² S_xx = S_cc`. This matches `blockOp_J` and the record's frame `φ_23, φ_31, φ_12 ↔ e_1, e_2, e_3` (L227 step 4: `Q ∈ SO(3)` acts on that frame by itself, so a diagonal `S` is coordinate-diagonal).
- `{p, a}`: `blockOp_M` gives `W φ_pa = Σ_q (M_a)_pq φ_qa`, diagonal `M_a` gives `(M_a)_pp`, which is `wOf (inl p) (inr a)` and its mirror.
- `{a, b}`: `blockOp_K` gives `K_ab`. `wOf (inr a) (inr b) = K a b`, with `K_aa = 0` supplying hollowness.
- Falsifier: a diagonal `S` with distinct entries where `W φ_23 ≠ S_11 φ_23`, or an `(M_a)` for which `W φ_pa` has a component off `φ_pa`.

## (2) `blockCoeff_diag` in every index pattern

- `(inl,inl,inl,inl)`: `eps_diag`, correct as computed in (1), including `p = q`, where both sides vanish.
- `(inl p, inr a, inl q, inr b)`: `δ_ab M_a pq = δ_ab δ_pq M_a pp`, and the right side is `M_a pp (δ_pq δ_ab - 0)`. Correct.
- `(inr a, inl p, inl q, inr b)`: `-δ_ab M_a pq`, right side `M_a pp (0 - δ_ab δ_pq)`. Correct, the minus sign sitting in the second Kronecker term.
- `(inl p, inr a, inr b, inl q)`: `-δ_ab M_a pq`, right side `M_a pp (0 - δ_pq δ_ab)`. Correct.
- `(inr a, inl p, inr b, inl q)`: `δ_ab M_a pq`, right side `M_a pp (δ_ab δ_pq - 0)`. Correct.
- `(inr,inr,inr,inr)`: at `a ≠ b` the two branches are exclusive (both would force `a = b`) and give `K_ab (δ_ac δ_bd - δ_ad δ_bc)`. At `a = b` the left side is `0` and the right side is `K_aa · (…) = 0` by `hK0`. Correct.
- Remaining patterns: `blockCoeff` is `0`, and on the right both Kronecker terms compare an `inl` with an `inr`, so they vanish too.
- Falsifier: a quadruple where the two sides differ, e.g. `(inr a, inl p, inl p, inr a)`, which must read `-M_a pp`.

## (3) `blockOp_diag_eq` and the passage to `Pcubic`, `norm`

- `blockOp = opOf (blockCoeff …)` is `rfl`. With `C = w_ij(δ_ik δ_jl - δ_il δ_jk)`, `sum_kl` gives `Σ_kl C_ijkl φ_kl = 2 w_ij φ_ij` (by `phi_swap`), so `blockOp X = ½ Σ_ij ⟨X, φ_ij⟩ w_ij φ_ij`.
- Entry `(a,b)`: `weight_phi_entry` replaces `w_ij φ_ij(a,b)` by `w_ab φ_ij(a,b)` for symmetric `w` (`φ_ij` is supported on `{(i,j),(j,i)}`), and `skew_expand` gives `½ Σ ⟨X, φ_ij⟩ φ_ij = X` at skew `X`. The result is `w_ab X_ab = diagOp w X`. Sound, and skewness is used exactly there.
- Skew inputs suffice. `Pcubic_eq_restrictLin` rewrites `Pcubic2` of the restriction as `foxTri` of the restriction through `Pcubic2_eq_innerOp2`, `innerOp2_comm`, `foxProd2_self`, and `foxTri_eq_foxTri2_restrictLin` identifies it with `foxTri R R R`, which `foxTri_self` turns into `Pcubic R`. `normSq_eq_restrictLin` is direct: `normSq` is `½ Σ_ij ⟨R φ_ij, R φ_ij⟩` and each `φ_ij` is skew. Both operators are linear (`opOf_add`, `opOf_smul`, `isLinOp_diagOp`) and preserve `Λ²` (`opOf_isSkew`, `diagOp_skew`), so equal restrictions give equal `Pcubic` and `norm`.
- Falsifier: a skew `X` with `blockOp X ≠ w ∘ X`, or a `Pcubic` that reads the operator off `Λ²` (it reads it only on the `φ_ij`).

## (4) `wOf_isWeight` and the Ricci hypothesis

- `symm`: `ε_qpx² = ε_pqx²` by `eps_swap12`, and `hK` for the outer block. Correct.
- `hollow`: `ε_ppx = 0` from `eps_swap12 p p x`, and `hK0`. Correct.
- `rowSum` at `inl p`: `Ric_pp = (tr S - S_pp) + Σ_a (M_a)_pp` (`Ric_blockOp_J`, whose symmetry hypotheses come from `isSymm_of_diag`), and the row sum is `Σ_q S_{c(p,q)} + Σ_a (M_a)_pp = (tr S - S_pp) + Σ_a (M_a)_pp` by `eps_sq_row`. Equal, so `Ric_pp = 0` gives a zero row.
- `rowSum` at `inr a`: `Ric_aa = tr M_a + Σ_b K_ab` (`Ric_blockOp_outer`), which is the row sum `Σ_p (M_a)_pp + Σ_b K_ab`. Correct.
- Only the diagonal entries `Ric (inl p) (inl p)` and `Ric (inr a) (inr a)` are used. `hRic : ∀ i j, Ric … = 0` is Ricci-flatness of `Ric R a b = Σ_c ⟨R φ_ac, φ_bc⟩`, the record's trace condition for `𝒲_n`. It omits first Bianchi, which makes `L57_block` a stronger theorem, and is harmless since the conclusion passes through `diagOp w` with `w` a weight, where `L57_diagonal` needs nothing more. See O3.
- Falsifier: a diagonal block operator with vanishing diagonal Ricci whose `wOf` has a nonzero row sum.

## (5) `Θ` and the range

- `L57_diagonal` bounds `Pcubic (diagOp w)` by `√(2(N−1)(N−2))/N · norm^3` at `N = Fintype.card ι`. `hcard` gives `N = m + 3` for `Fin 3 ⊕ Fin m`, so `L57_block`'s constant is the record's `Θ_n` at `n = m + 3`.
- `1 ≤ m` is `4 ≤ m + 3`, exactly `L57_diagonal`'s `4 ≤ card`, and L228's setting (`n ≥ 4`, `m = n − 3`). At `m = 1`, `Θ_4 = √12/4 = √3/2`, L225's value.
- Falsifier: an `m ≥ 1` diagonal Ricci-flat block operator with `P > Θ_{m+3} ‖W‖³`, which would also refute L57.

## (6) The INDEX rows

- L227 row: records `L57_block` for diagonal `S`, `M_a` and owes "the rotation to a coordinate-diagonal tensor and the membership of `W'`". That is what is typed.
- L228 row: records `L57_block` and owes "item 4 and the rotation to a coordinate-diagonal tensor". What is typed is claimed correctly. See O2 for what the owed list leaves out.
- Falsifier: a row claiming the rotation, or item 3 or 4, as proved.

## Observations

- **O1. The record's Lean paragraphs are stale.** [second-order.md](../findings/second-order.md) L227 says "The rotation to a diagonal tensor, L57 and the bridges of L226 are outside the files", and L228 says "Item 4, the rotation to a coordinate-diagonal tensor, and L57's use are owed in Lean". Both should now name `L57_block` as the coordinate-diagonal end. The commit touched neither.
- **O2. The L228 row's owed list omits item 3's operator-level assembly.** Item 3 needs the Birkhoff move (`align_to_frame`) composed with `L228_item2` into a new block operator `W'` with equal norm and no smaller `P`, and `W'`'s Ricci-flatness, which is `L57_block`'s hypothesis. The L227 row owes "the membership of `W'`", while the L228 row owes only "item 4 and the rotation". The previous row had the same gap, so this is carried forward, not introduced.
- **O3. `hRic` is stronger than used.** Only `Ric i i = 0` enters. Weakening to the diagonal would widen `L57_block`'s reach at no cost, and it matches what a consumer would build for `W'`.
- **O4. The name "coordinate-diagonal end" is accurate at the operator level.** `blockOp S M K` with diagonal `S`, `M_a` agrees with `diagOp (wOf …)` on `Λ²` only. The two functions differ on symmetric inputs, which is immaterial because `Pcubic` and `norm` read `Λ²` alone.
