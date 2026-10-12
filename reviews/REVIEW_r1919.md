# REVIEW r1919: B12 restriction, sphere element and four-set sectors

*Gate 2 review of [B12Restrict.lean](../lean/HamiltonsCubic/Results/B12Restrict.lean) and [B12Sphere.lean](../lean/HamiltonsCubic/Results/B12Sphere.lean) (6a39a43e), [B12Four.lean](../lean/HamiltonsCubic/Results/B12Four.lean) (417ece32) and [B12FourSector.lean](../lean/HamiltonsCubic/Results/B12FourSector.lean) (adecab48). Every algebraic claim was re-derived by hand from the definitions in [L121Block.lean](../lean/HamiltonsCubic/Results/L121Block.lean), [L120Four.lean](../lean/HamiltonsCubic/Results/L120Four.lean), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), [L27Four.lean](../lean/HamiltonsCubic/Results/L27Four.lean) and [L161.lean](../lean/HamiltonsCubic/Results/L161.lean). Analysis-only footing: the only runs were the four axiom audits.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `trace_comp_idem`, `projS_idem`, `sq_comm`, `trace_sector_restrict` | CONFIRMED |
| 2 | `diagW` is the record's diagonal operator on the `weylModuleS` encoding, `sphS` is `t · W_T` with `t` free, `sphS_fixed` | CONFIRMED WITH OBSERVATIONS |
| 3 | `Lop_fourMap`: `L_{diagW w}` acts on `(x, y)` by `Kmap(A, B, C)` | CONFIRMED |
| 4 | `trace_Kmap_sq`: `tr K² = (A²+B²+C²−AB−BC−CA)/2`, agreeing with `four_eigen_sq` | CONFIRMED |
| 5 | `mem_range_projS_iff`, `fourEquiv`, `trace_four_sector` | CONFIRMED |
| 6 | At the unit sphere product the four-set sectors carry exactly `e_p e_q` eigenvalues `+μθ` and `e_p e_q` eigenvalues `−μθ`, consistent with `trLe2` | CONFIRMED WITH OBSERVATIONS |
| 7 | Axiom audits: 5/5, 6/6, 9/9, 4/4 on the standard three | CONFIRMED |

**Summary: all four files are sound and state what B12's entry says they state. The four-set sectors account for all of `trLe2`'s `e_p e_q μ²` term and `e_p e_q` of its `d_p d_q μ²` term, leaving `(d_p d_q − e_p e_q) μ²` for the pair and diagonal sectors (steps 4 and 5).**

## 1. trace_comp_idem and the restriction step

- The statement is right: for `P ∘ P = P` and `A ∘ P = P ∘ A` on a finite-dimensional real space, `tr(A ∘ P) = tr(A|_{range P})`. The generality is adequate for B12 (any finite `V` over `ℝ`). It would hold over any field, which B12 does not need.
- The Bool-indexed family `N true = range P`, `N false = ker P` is a sound use of `DirectSum.isInternal_submodule_iff_isCompl`: the side conditions are `true ≠ false` and `{true, false} = univ`, both discharged, and `IsCompl (range P) (ker P)` is Mathlib's `LinearMap.IsIdempotentElem.isCompl`.
- `A ∘ P` preserves both summands (it kills `ker P` and maps `range P` into itself by commutation), so `trace_eq_sum_trace_restrict` applies. On `ker P` the restriction is `0`. On `range P` it equals `A|_{range P}` because `P(Py) = Py`. The sum is therefore the claimed trace.
- `projS_idem` reads `proj t` of a vector already carrying character `setChar t` through `proj_of_char` at `u = t`, where the `if` resolves to the identity. Sound.
- `sq_comm` is two applications of `Lop_projS` with associativity. `trace_sector_restrict` is `trace_comp_idem` at `A = L_e²`, `P = projS t`. Both are exactly r1917's second owed item.
- Screen: `P = diag(1, 0)`, `A = diag(a, b)` gives `tr(AP) = a = tr(A|_{range P})`.

## 2. diagW and sphS

- `diagW w = diagOpL w ∘ skewProj` is [L120HessPair](../lean/HamiltonsCubic/Results/L120HessPair.lean)'s `weylModuleS` encoding of the diagonal operator `diagOp w`: precomposition with the skew projection is how every element of `weylModuleS` is represented, and `diagW_apply_skew` shows it agrees with `diagOp w` on skew matrices. `diagW_phi` gives `φ_ij ↦ w_ij φ_ij` at symmetric `w`, the defining property of the record's diagonal operator.
- `sphS T t = diagW (t · sphereWeight T)`. [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s `sphereWeight` has `q/(p−1)` inside `T`, `p/(q−1)` inside `Tᶜ`, `−1` across, and [L2Operators.lean](../lean/HamiltonsCubic/Results/L2Operators.lean)'s `theta_sq_sphere` and [L161Link.lean](../lean/HamiltonsCubic/Results/L161Link.lean)'s `kappa_at_operator` use exactly `diagOp (t • sphereWeight S)` as the record's `W_{p,q}`. So `sphS` is the record's sphere product on the `weylModuleS` side.
- The normalisation `t` is left free: `sphS` carries no norm or sign hypothesis on `t`. B12's entry says so explicitly, that `sphS` "still owes its θ and its unit normalisation joined to L161Link.lean's".
- `diagW_flip` is sound: `coord (diagW w)` is supported on `(i,j,k,l) ∈ {(i,j,i,j), (i,j,j,i)}`, where the flip sign is a product of two squares of `sgn m`, hence `1`. `diagW_diagSet` lifts this to every `diagSet u` through `act_diag_set`. `sphS_fixed` is therefore the hypothesis of `Lop_projS` at the sphere product.
- **Observation 2a.** The join owed is two items, and the entry names them only as "its θ and its unit normalisation". First, `trace_leftMulS_comp` pairs through `innerOp (diagW …) (diagW …)`, while `L161Link`'s `kappa_at_operator` assumes `normSq (diagOp (t • sphereWeight S)) = 1`, so a lemma equating the two at `sphS` is owed. Second, `θ(diagOp …)` must be tied to `L_{sphS}` so that raw eigenvalues are `θ` times `trLe2`'s list (`1` on `e`, `½`, `λ_m`, `±μ`, `0`). `κ = tr(L_e²)/⟨e,e⟩` needs both, and neither is typed yet.

## 3. Kmap from fourSet_span

With `A = w_ij + w_kl`, `B = w_ik + w_jl`, `C = w_il + w_jk`, `fourSet_span` gives new coefficients `x' = (Ax + Cy + Bz)/2`, `y' = (Cx + By + Az)/2`, `z' = (Bx + Ay + Cz)/2`. Putting `z = −x − y`:

- `x' = ((A − B)x + (C − B)y)/2`, the first row of `Kmap`.
- `y' = ((C − A)x + (B − A)y)/2`, the second row.
- `z' = ((B − C)x + (A − C)y)/2`, and `−x' − y' = −((C − B)x + (C − A)y)/2 = ((B − C)x + (A − C)y)/2 = z'`.

So the image stays on the Bianchi cut. More generally `x' + y' + z' = (A + B + C)(x + y + z)/2`, since each column of the circulant sums to `A + B + C`, so the cut `x + y + z = 0` is invariant at every weight. `Lop_fourMap` checks the three coefficients coordinatewise through `Lop_spec`, `foxProd_congr_on_skew` and `module`, which is this computation.

## 4. trace_Kmap_sq and the eigenvalue cross-check

Write `K = ½[[a, b], [c, d]]` with `a = A − B`, `b = C − B`, `c = C − A`, `d = B − A`.

- `tr K² = (a² + 2bc + d²)/4`. Here `a² + d² = 2(A − B)²` and `2bc = 2(C² − AC − BC + AB)`, so the numerator is `2(A² + B² + C² − AB − BC − CA) = 2 sig`, and `tr K² = sig/2`.
- `tr K = (a + d)/2 = 0` and `det K = (ad − bc)/4 = −sig/4`. The eigenvalues are `±√sig/2`, each with `4c² = sig`, which is [L27Four.lean](../lean/HamiltonsCubic/Results/L27Four.lean)'s `four_eigen_sq`. Their squares sum to `sig/2`, agreeing with `trace_Kmap_sq`.
- Screen: `A = 1`, `B = C = 0` gives `K = ½[[1, 0], [−1, −1]]`, `tr K² = (1 + 1)/4 = ½ = sig/2`.

## 5. trace_four_sector

- **Statement fidelity.** It states `tr(L_{diagW w}² ∘ P_{{i,j,k,l}}) = sig(A, B, C)/2` at every weight `w` and four distinct indices, on `Fin n`. That is the sector term of `trace_sq_sectors` at a four-set, as B12's step 3 asks, and stronger than needed since `w` is any weight. The ordering of `(i, j, k, l)` permutes `(A, B, C)`, and `sig` is symmetric, so the value is a function of the set `t`.
- **`mem_range_projS_iff`.** Forward: `projS t Z` has character `setChar t = ε_i ε_j ε_k ε_l` by `proj_signMat` and `setChar_four`, and lies in `weylModuleS`, so `fourSummand_mem` puts it in `range fourMap`. Backward: an element of `range fourMap` carries character `setChar t`, so `proj_of_char` gives `projS t Y = Y`. Both directions rest on [L120Four.lean](../lean/HamiltonsCubic/Results/L120Four.lean)'s `fourSummand_mem`, an if-and-only-if, which is the load-bearing input.
- **`fourEquiv`.** `fourMap` is injective by rank–nullity against `fourSummand_finrank = 2`, and surjective onto `range P_t` by the iff. `LinearEquiv.ofBijective` is sound.
- **Trace transport.** `hkey` shows `L_e²|_{range P_t} ∘ φ = φ ∘ K²`. The matrix of the restricted map in the basis `φ(e_1), φ(e_2)` therefore equals the matrix of `K²` in the standard basis, entry by entry through `Basis.map_repr` and `symm_apply_apply`. Equal matrices have equal traces, so the transport is sound.

## 6. Bookkeeping at the unit sphere product

With `p = |T|`, `q = |Tᶜ|`, `α = q/(p−1)`, `β = p/(q−1)`, weight `t · sphereWeight T`:

| four-set type | `(A, B, C)` up to order | `sig` | sector eigenvalues |
|---|---|---|---|
| (4, 0) or (0, 4) | all equal | 0 | `K = 0`, both `0` |
| (3, 1) or (1, 3) | all equal to `t(α − 1)` or `t(β − 1)` | 0 | `K = 0`, both `0` |
| (2, 2), `i, j ∈ T` | `(t(α + β), −2t, −2t)` | `t²(α + β + 2)²` | `±√sig/2` |

- By hand `α + β + 2 = (p + q − 1)(p + q − 2)/((p − 1)(q − 1))`. `sig22` states `sig = ((p + q − 2)/((p − 1)(q − 1)))² θ²` at unit norm, which with μ = `(p + q − 2)/(2(p − 1)(q − 1))` (L26's `mu`) is `sig = 4μ²θ²`. So each (2, 2) sector has eigenvalues `+μθ` and `−μθ` and contributes `sig/2 = 2μ²θ²`. The two expressions agree when `θ = t(p + q − 1)`, which `sig22` carries implicitly and this review did not re-derive.
- There are `C(p,2) C(q,2) = e_p e_q` sectors of type (2, 2), with `e_m = dim Λ²(ℝ^m)` (`dimL`). In `θ = 1` units they contribute `2 e_p e_q μ²`.
- `trLe2` carries `(d_p d_q + e_p e_q) μ²`, `d_m = dim S²_0(ℝ^m) = e_m + m − 1`. The four-set sectors therefore supply all of `Λ² ⊗ Λ²` (one eigenvector per sector) and the fully off-diagonal part of `S²_0 ⊗ S²_0` (the other). The remainder `d_p d_q − e_p e_q = e_p(q − 1) + e_q(p − 1) + (p − 1)(q − 1)` is exactly the part of `S²_0 ⊗ S²_0` that is diagonal in one or both factors, which lives in the pair sectors (`|t| = 2`) and the diagonal sector (`t = ∅`). This matches the record's `±μ` split with no conflict.
- The (4, 0), (3, 1) types give eigenvalue `0`, consistent with `trLe2` having no `λ_p`, `½` or `1` contribution from four-set sectors: `1`, `pq/4`, `d_p λ_p²`, `d_q λ_q²` all come from `|t| ≤ 2`.
- **Observation 6a.** Which of `±μ` belongs to `Λ²⊗Λ²` is invisible to a trace, and B12's bound asks only for the trace sum, so this is recorded as untested rather than as a gap.
- **Observation 6b.** The step-6 sum over four-sets still needs the count `#{(2,2) four-sets} = C(p,2)C(q,2)` and a lemma that `trace_four_sector`'s value is `0` off type (2, 2) (both are in `sig_le_sphere`'s case split in substance). Neither is typed in these files.

## 7. Axiom audits

All four ran in the background with `scripts/misc/axiom_audit.py --only <module>`:

| Module | Result |
|---|---|
| B12Restrict | 5/5 clean, the standard three alone |
| B12Sphere | 6/6 clean, the standard three alone |
| B12Four | 9/9 clean across 2 files, the standard three alone (the `--only` match is a prefix, so it also took B12FourSector) |
| B12FourSector | 4/4 clean, the standard three alone |

No `sorryAx`, no `native_decide` axiom, no project axiom.

## 8. Falsifiers and what was done to look

| Theorem | What would falsify it | What was done |
|---|---|---|
| `trace_comp_idem` | an idempotent `P` commuting with `A` with `tr(AP) ≠ tr(A|range P)` | proof read against the `range ⊕ ker` splitting, `diag` screen in section 1 |
| `projS_idem` | a sector projector with `P² ≠ P` | `proj_of_char` read at `u = t` |
| `diagW_diagSet`, `sphS_fixed` | a coordinate of `diagW w` on a tuple with odd sign count | support of `coord_diagW` read, two-case sign product checked |
| `Lop_fourMap` | a coefficient of `fourSet_span` not matching `Kmap`, or the image leaving `x + y + z = 0` | all three coefficients substituted by hand, section 3 |
| `trace_Kmap_sq` | a mismatch with `sig/2` | expanded by hand, cross-checked against `four_eigen_sq` via `tr K = 0`, `det K = −sig/4`, and a numeric screen |
| `mem_range_projS_iff` | an element of `range P_t` outside `range fourMap`, or the reverse | both directions traced to `fourSummand_mem` and `proj_of_char` |
| `trace_four_sector` | a basis change error in the transport | `hkey` and the `Basis.map` matrix identity read, section 5 |
| Consistency with `trLe2` | four-set sectors supplying more `μ²` than `trLe2` holds | multiplicities counted by hand, section 6: `2 e_p e_q ≤ d_p d_q + e_p e_q` with the remainder assigned to `|t| ≤ 2` |

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** The four files are correct and faithful to B12's entry. The observations are bookkeeping owed by later steps: the unit-norm and units join between `sphS` and `L161Link` (2a), and the typed (2, 2) count and vanishing off type (2, 2) that step 6 needs (6b).
