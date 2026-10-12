# REVIEW r1612: I117Statements torus rows and the L260/L270 H implications

Log: [agent_logs/r1612.log](../agent_logs/r1612.log)

Scope: [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean) at HEAD 3aa2e5ca, against [findings/second-order.md](../findings/second-order.md) L260, L264, L268, L270, L271 and the matching [lean/INDEX.md](../lean/INDEX.md) rows. Analysis only: no computation was run, the Lean tree was not rebuilt, and sorry-freeness beyond the parent's axiom audit was checked textually (every `sorry` in the file located and every reference to a sorry'd declaration grepped).

| claim | declaration | verdict |
|---|---|---|
| C1 | L268_torus_pd | CONFIRMED |
| C2 | L270_torus_light | CONFIRMED WITH GAPS |
| C3 | L271_norm | CONFIRMED |
| C4 | L260_H_of_norm_bound, L270_H_of_Us' | CONFIRMED WITH GAPS |
| C5 | INDEX rows L260, L264, L268, L270, L271 | CONFIRMED WITH GAPS |

## Conventions checked first

- `innerOp2 R S = ½ Σ_{i,j} inner2(R φ_ij, S φ_ij)` is the Hilbert–Schmidt pairing `tr(RᵀS)` on Λ², with the ½ removing the ordered-pair doubling. `normSq2` is its square norm.
- In `torusMat` the Cartan coordinate is `x_k = X(k,1)(k,0) = ⟨φ_k, X⟩` for the unit bivector of the k-th plane, and the diagonal block returned is `(Σ_t A_kt x_t) J2`, which is `Σ_t A_kt x_t φ_k`. So `A` is the Cartan block in an orthonormal basis of 𝔱.
- The J-commuting part `cPart` carries weight `ε_i − ε_j` (`[h_i, ·]` acts as `J·`, `[h_j, ·]` as `−·J`, equal and opposite on a J-commuting block), so `U ↔ ε_i − ε_j`, `V ↔ ε_i + ε_j`, as the record's L271 notation says.
- `Amu` is `2 Σ_α μ_α² u_α u_αᵀ` with `u = (e_i ∓ e_j)/√2`: diagonal `d_i`, off-diagonal `V_ij² − U_ij²`, matching L271 (2)'s `A_ii = d_i`, `A_ij = −P_ij Q_ij`.

## C1. L268_torus_pd: CONFIRMED

- **It is L268's clause.** L268's proof ends "A ≻ 0 when every μ_α > 0 since the coroots span 𝔱". The typed theorem is that clause together with positivity on the root planes, at `A = A_μ`. `Amu_quad` is the coroot argument written as a sum of squares, `½ Σ (U²(x_k − x_l)² + V²(x_k + x_l)²)`, and `inner2_torusMat` adds `U‖cPart B‖² + V‖aPart B‖²` per block.
- **P > |Q| ⟺ U > 0 and V > 0**: `U+V > U−V ⟺ V > 0` and `U+V > V−U ⟺ U > 0`. So `hpos` is L271 (2)'s condition exactly.
- **Dropping idempotency is a true strengthening that matches L268.** Idempotency enters the record's clause only by forcing `A = A_μ` (L268's first sentence). The typed theorem fixes `A = Amu U V` directly, so the hypothesis is replaced by its only consequence the argument uses. L268's positivity argument never uses the cubic system.
- **Scope note.** L271 (2) says "positive definiteness *is* P > |Q|", an equivalence. The typed theorem is the ⇐ half. The ⇒ half (PD forces every weight positive) is immediate from a single root-plane test vector and is untyped. The record's L268 status line and the `L268_torus_idem` docstring both claim only "positive weights give a positive definite operator", so nothing overclaims.
- `hm : 3 ≤ m` is used only to find `l ≠ k`, for which `m ≥ 2` would do. Harmless.

## C2. L270_torus_light: CONFIRMED WITH GAPS

- **"Lighter than I/c"** is `normSq2 C < normSq2 idOp / (2(m−1))²`. On `ι = Fin m × Fin 2`, `n = 2m`, `c = n − 2 = 2(m−1)`, and `‖I/c‖² = ‖I‖²/c²`. Correct. `normSq2_idOp_torus` gives `‖I‖² = m(2m−1) = N`.
- **Σ_α μ_α²** is `½ Σ_i Σ_j (U_ij² + V_ij²)`. The α run over the `m(m−1)` positive roots, one per unordered pair and sign. Ordered pairs are halved, and the zero diagonal (from `IsPairWeights`) contributes nothing. At `μ ≡ 1/(2(m−1))` it is `½ · m(m−1) · 2 · 1/(4(m−1)²) = m/(4(m−1))` (ordered pairs, two weights each), the record's value. Correct.
- **The conclusion** `< m/(4(m−1))` is the record's strict bound. The proof is the record's: `q = ‖A_μ‖² + 2y ≥ (tr A_μ)²/m + 2y = 4y²/m + 2y` with `tr A_μ = Σ d_i = 2y`, then monotonicity on `y ≥ 0`.
- **Gap 1: `hidem` and `hpos` are unused.** The proof reads neither. The theorem is true for every pair-weight `U, V` with Cartan block `A_μ`. This matches the record, whose proof also uses only `tr A = 2y`, but the typed statement carries two dead hypotheses. It should either drop them or say in the docstring that the bound holds on the whole `A = A_μ` slice.
- **Gap 2: the hypothesis "positive-definite idempotent" enters through `A = A_μ`, and that step rests on `L268_torus_idem`, which is `sorry`.** For a torus-invariant PD idempotent written `torusOp A U V` with general `A`, reaching the typed form needs `A = Amu U V` (L268's idempotency equivalence, forward direction) and `U, V > 0` (the untyped ⇒ half of C1). The typed theorem is L270 (4) on L268's parametrisation. That is a fair reading of "the torus family of L268", but neither the docstring nor the row names the dependence.

## C3. L271_norm: CONFIRMED

- The statement is `‖T(A,U,V)‖² = Σ A_ij² + ½ Σ (U+V)_ij² + ½ Σ (U−V)_ij²` under `IsPairWeights U, V`. It is the record's `‖A‖² + ½‖P‖² + ½‖Q‖²` with Frobenius norms. `‖A‖` is Frobenius in the orthonormal Cartan basis, and `‖P‖²` runs over all ordered pairs, as L270 (4)'s `q = ‖A‖² + 2y` confirms.
- **No symmetry hypothesis on `A` is a genuine generalisation.** `innerOp2_torusOp` has symmetry hypotheses only on the root weights, and the Hilbert–Schmidt norm of the Cartan block is `Σ A_ij²` for any matrix. The record's `C` is symmetric, so its `A` is a special case.
- The zero diagonal in `IsPairWeights` is needed and present: `torusOp` never reads `U_ii`, while `½‖P‖²` would count it.

## C4. L260_H_of_norm_bound and L270_H_of_Us': CONFIRMED WITH GAPS

**The chain.** Both proofs call `statementH_of_unit` → `exists_sa_maximiser` → (the `F ≤ 0` branch closes by `κ_n ≥ 0`) → `L260_psd_cone X` → `Y` is again a maximiser with `F(Y) = F(X)` → `L264_maximiser_stable Y` → `hbound`/`hUs` at `C = Y/F(Y)` (self-adjoint by `isSelfAdjoint2_smul`, PSD by `isPSD2_smul`, nonzero by `normSq2 C = 1/F² > 0`) → `maximiser_le_kappa`.

- **No other sorry'd declaration is used.** The file's sorry'd declarations are `L268_torus_idem`, `L269_phi_test`, `L271_F_slice`, `L273_J1_implies_H`, `L260_range_subalgebra`, `L260_trace_bound`, `L261_coord_diag`, `L265_I_sharp`, `L266_orbit_tangent`, `L267_U_fails`, `L254_conjA_12`, `L260_psd_cone`, `L262_son`, `L263_g2`, `L265_cp`, `L271_split` and `L273_F_bound`. The only one referenced anywhere in the file outside its own statement is `L260_psd_cone`, at lines 2075 and 2113. `L264_maximiser_stable`'s body uses `maximiser_variation`, `quartic_coeffs`, `isSelfAdjoint2_sharp`, `sharpMapCL_smul` and `normSq2_eq_zero`, none of them sorry'd. This agrees with the parent's axiom audit.
- **`exists_sa_maximiser` is sound.**
  - `saR` is a submodule of the finite-dimensional normed space `RecCurv`, so it is proper (`FiniteDimensional.proper_real`) and its unit sphere is compact.
  - `sv_norm_sq` identifies `‖x‖²` with `normSq2`, so the sphere is exactly `{Y self-adjoint, normSq2 Y = 1}`, and every such `Y` is lifted into it (`⟨Y, hY⟩`).
  - The sphere is nonempty because of `idOp/‖idOp‖`, and `normSq2 idOp ≠ 0` is shown by evaluating at `φ_ij` with `i ≠ j`.
  - `F` is continuous as a cubic polynomial in basis coordinates (`continuous_Ftri_sv`), and `IsCompact.exists_isMaxOn` gives the maximiser.
- `maximiser_le_kappa`: `q = 1/f² ≥ N/c²` gives `N f² ≤ c²`, hence `f ≤ c/√N = κ_n`. Correct.

**Against the record.**

- **L260 (3).** The typed hypothesis ranges over nonzero self-adjoint PSD idempotents of 𝔰𝔬(n). By L260 (2) and the closure of `Sym²𝔥` under `#` (L264's proof), these are exactly the record's "positive-definite idempotents on compact semisimple subalgebras", extended by zero. So the typed implication is the record's (3) in the direction H needs, with no L256 composed in (L260 (3)'s bound is already `N/(n−2)²`). It holds at every `n ≥ 3`, a true strengthening of "for n ≥ 9". The converse half of "is" is untyped, and the docstring's "the direction H needs" names that.
- **L270 (3).** The record's premises are U$_{\mathrm s}'$ (stable in `Sym²𝔥`, on simple 𝔥) and L256 (`d/c_𝔥² ≥ N/(n−2)²`). Together with L260 (2), restriction of so(n)-stability to `Sym²𝔥`, and L264 (2) including its cross-block case (prose), they imply the typed hypothesis. That hypothesis quantifies over so(n)-stable PSD idempotents, a smaller class than "stable on its own 𝔥", so it is implied by, and no stronger than, "U$_{\mathrm s}'$ composed with L256". The typed implication composed with that prose is therefore exactly the record's reduction, and the typed step is at least as strong as the record's corresponding step. `hn : 9 ≤ card ι` is used only as `≥ 3`. It marks where L256 applies and is harmless.
- **Gap: `L260_psd_cone` is stated for every `X`, and the chain uses it only at self-adjoint `X`.**
  - For self-adjoint `X` the statement follows from L260 (1) with `Xᵀ = X`. In an eigenframe, `F(X) = Σ λ_k λ_l λ_m w_klm` with `w_klm ≥ 0`, so `F(X) ≤ F(|X|)` and `‖|X|‖ = ‖X‖`.
  - For non-self-adjoint `X`, the typed claim depends on `phiTri`'s extension to non-symmetric operators, `−¼ Σ ⟨X[Xφ, Xψ], [φ, ψ]⟩`, agreeing with whatever `F` on `End(𝔰𝔬(n))` the record's SVD argument uses. Nothing in the file or the record pins that agreement.
  - **Correction:** add `(hX : IsSelfAdjoint2 X)` to `L260_psd_cone`. Both call sites already have it (`hX`). The `sorry` then carries only what is used and what the record certainly proves.

## C5. The INDEX rows: CONFIRMED WITH GAPS

Every declaration any of the five rows calls PROVED exists in the file and is sorry-free, or is stated as resting on `L260_psd_cone` alone. Names checked: `L260_H_of_norm_bound`, `L264_maximiser_stable`, `L264_not_simple_unstable`, `L270_H_of_Us'`, `L268_torus_pd`, `L268_uniform`, `torusOp_isSelfAdjoint2`, `innerOp2_torusOp`, `L270_so`, `L270_torus_light`, `L271_norm`, `L271_pq_system`, `L271_Q_zero`, and the helpers `exists_sa_maximiser`, `statementH_of_unit`, `Amu_quad`, `inner2_torusMat`, `sum_off_one`, `sum_off_two`, `idOp_eq_torusOp`, `normSq2_torusOp`, `quartic_coeffs`, `isSelfAdjoint2_sharp`, `sharpMapCL_smul`, `phiTri_comm_zero`, `perron_unique`, `perron_positive_eigvec`. Every declaration a row calls `sorry` is `sorry`.

| row | finding | severity |
|---|---|---|
| L260 | Accurate. "Rests on (1)'s `sorry` alone" is right. | none |
| L264 | Accurate, including `L270_H_of_Us'` "PROVED from `L260_psd_cone`" with the so(n) reading and the prose reduction to simple subalgebras named. | none |
| L268 | `L268_torus_pd` is described by its proof but not by its statement. Add that it is the ⇐ half (positive weights give PD) at `A = A_μ`, and that the ⇒ half is untyped. The "Earlier" tail "Not stated: the family, the three constants and the reduced system" now reads against the typed `torusOp` and `TorusSystem`. Scope it to I117LemmaF explicitly or trim it. | low |
| L270 | `L270_H_of_Us'` is listed as "(3)" with no status here. Add "PROVED from `L260_psd_cone`, see L264" so this row stands alone. For `L270_torus_light`, name that it holds on the `A = A_μ` parametrisation (the step from an arbitrary PD idempotent rests on `L268_torus_idem`) and that `hidem`/`hpos` are unused. The "Earlier" tail "Not stated: … and (3), which is prose over L256, L260 and L264" now reads against the typed `L270_H_of_Us'`. | low |
| L271 | Accurate on `L271_norm` (sorry-free), `L271_F_slice` and `L271_split` (`sorry`). The "Earlier" tail "Not stated: F on the torus slice, … (3) through L261" reads against the typed `L271_F_slice` and the proved `L271_Q_zero`. | low |

Nothing in any row claims content the file lacks.

## Corrections owed

1. `L260_psd_cone`: add `IsSelfAdjoint2 X` (C4).
2. `L270_torus_light`: drop `hidem` and `hpos`, or record in the docstring that they are unused. Name the `A = A_μ` dependence on `L268_torus_idem` in the docstring and in the L270 row (C2).
3. L268 row: state `L268_torus_pd`'s content as the ⇐ half (C1, C5).
4. L270 row: give `L270_H_of_Us'` its status (C5).
5. L268, L270, L271 rows: scope or trim the stale "Not stated" tails (C5).
