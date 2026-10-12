# REVIEW r1630: L122Cap.lean (commit d19f7187), L122's cap discharged from L24

**Verdict: CONFIRMED WITH GAPS.** The four theorems are correct, kernel-checked and faithful to [Lemma L122](../findings/second-order.md) at coordinate-diagonal maximisers. The gaps sit in [lean/INDEX.md](../lean/INDEX.md)'s L122 row, which reads **proved** and "Owed: nothing" while one of the record's two consequences has only a count as its declaration.

Footing: analysis only. The runs were one `lake build HamiltonsCubic.Results.L122Cap` (exit 0) and `python3 scripts/misc/axiom_audit.py --only L122Cap.lean` (10/10 on the standard three). No numerical screen was run.

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `foxProd_pairVec` ([L122Cap.lean:46](../lean/HamiltonsCubic/Results/L122Cap.lean#L46)): the pair block of `M ∘` in the basis `f_i` is `Lb` | CONFIRMED |
| 2 | `innerOp_pairVec` (factor 2), `innerOp_diag_pairVec` (orthogonality to `M`) | CONFIRMED |
| 3 | `hcap_of_max` ([L122Cap.lean:141](../lean/HamiltonsCubic/Results/L122Cap.lean#L141)): the cap at a unit critical local Weyl maximiser with `θ > 0` | CONFIRMED |
| 4 | `L122_lambda_min_of_max` ([L122Cap.lean:216](../lean/HamiltonsCubic/Results/L122Cap.lean#L216)): L122's spectral condition | CONFIRMED |
| 5 | INDEX L122 row reads **proved**, "Owed: nothing" | CONFIRMED WITH GAPS |
| 6 | Axiom audit | CONFIRMED, 10/10 standard three |

## 1. foxProd_pairVec

- Hypotheses are `w` symmetric and hollow, `j ≠ k`, `X` skew. No row sum enters, which is the record's "diagonality alone" for the bracketed form.
- `Lb` ([L122Statement.lean:92](../lean/HamiltonsCubic/Results/L122Statement.lean#L92)) has diagonal `½(M_ji + M_ki − M_jk)` and off-diagonal `½ M_im`, the record's displayed matrix. The coefficient of `f_m` is `∑_i Lb_{mi} c_i`, and `Lb` is symmetric, so the index order carries no content.
- The proof reduces to `pair_invariant` and drops the `q ∈ {j,k}` terms through `phi_self` (`f_j = f_k = 0`). Hollowness enters at the diagonal of `Lb` (line 74).
- Breaking object: a `w` with `w_aa ≠ 0` or asymmetric `w`. Both are excluded by the binders, and the kernel accepts the proof.

## 2. The Gram factor and orthogonality

- `innerOp_pairVec` gives `⟨∑ κ_i f_i, ∑ c_i f_i⟩ = 2 ∑ κ_i c_i`, the record's "common norm `√2`" with the uniform factor the record says is owed nowhere. It agrees with `pair_gram` in L122Pair.lean.
- `innerOp_diag_pairVec` needs symmetry only, and matches `pair_perp` in L122Orbit.lean.

## 3. hcap_of_max

- **Hypotheses match `L24_weyl` ([L24Weyl.lean:200](../lean/HamiltonsCubic/Results/L24Weyl.lean#L200)) binder for binder**: `normSq2 a = 1`, `IsWeyl2 a` (supplied by `diagOp_isWeyl` from `IsWeight`), `Qop2 a = lam • a`, `IsLocalMaxOn Pcubic2` on `{normSq2 R = 1 ∧ IsWeyl2 R}`, `0 < Pcubic2 a`.
- As an encoding of "coordinate-diagonal maximiser": a global maximiser on the Weyl sphere is a local one, is critical by Lagrange, and has `P > 0` because `P` is odd and nonzero on `W_n`. The theorem therefore covers every global maximiser and every local one with `θ > 0`, which is exactly the scope the record gives [Lemma L24](../findings/second-order.md). `hcrit` is derivable from `hmax` and is carried only because `L24_weyl` takes it.
- **Units.** `θ := Pcubic2 a`. By `Pcubic2_eq_innerOp2` and `hcrit`, `P(a) = lam · normSq2 a = lam`, the eigenvalue in `Q(M) = θM`, which is independent of the norm convention. `innerOp2_foxProd2_self` gives `⟨a, Q v⟩ = ⟨M ∘ v, v⟩`, so `L24_weyl`'s `⟨a, Q v⟩ ≤ θ/2` at unit `v` is the cap `L_M ≤ θ/2` on `W^⊥`. That matches L122Statement.lean's docstring "`hcap` ... in `L_M` units", and the same `θ/2` is `orbit_eigen`'s orbit eigenvalue.
- **Normalisation.** `v = pairVec c` is Weyl on the cut (`pairSpan_isWeyl`) and orthogonal to `a`. It satisfies `‖v‖² = 2 nrmS` and `⟨a, Q v⟩ = 2 quadS(Lb)`.
  - At `nrmS = 0` every `c_i` on `Sset` vanishes, so `quadS = 0` and both sides are `0`.
  - Otherwise `r = (2 nrmS)^{-1/2}` makes `r • v` unit. `Q(rv) = r² Q(v)` gives `(2 nrmS)⁻¹ · 2 quadS ≤ θ/2`, which is `quadS ≤ (θ/2) nrmS`.
  - Both cases are correct.

## 4. L122_lambda_min_of_max

- It is `lambda_min_bound` with `hsym := hwt.symm`, Ricci rows `hR := fun i _ => hwt.rowSum i` (the `n−2` rows are taken from the full `IsWeight`, which is the Weyl condition), and `hcap` discharged by `hcap_of_max`.
- The conclusion `−(θ + M_jk) ‖x‖² ≤ xᵀ Δ^{(jk)} x` for all `x` with `∑_{Sset} x_i = 0` is the Rayleigh form of `λ_min(Δ^{(jk)}|_{𝟙^⊥}) ≥ −(θ + M_jk)`. `Δ^{(jk)}` is symmetric and preserves `𝟙^⊥` (`kirchhoff_row_sum`), so the two forms are equivalent.
- **Padded `S⁶ × S⁶`.** At the two padded indices `M_jk = 0`, and the `𝟙^⊥` eigenvalue `−12γ` lies below `−θ = −11γ`. The point is unit (after scaling), critical, Weyl and has `θ > 0`, so it satisfies every binder except `hmax`. The theorem's contrapositive then says it is not a local maximiser, which is what the record asserts. Nothing false is stated.
- Breaking object searched for: a unit critical diagonal Weyl point with `θ > 0` that meets `hmax` and violates the bound. The only candidate the record names is padded `S⁶ × S⁶`, and it fails `hmax`. The proof is kernel-checked, so no such object exists relative to the standard three axioms.
- Observation: no declaration exhibits a point that satisfies all the binders. L122Statement.lean's nonvacuity witness is the zero matrix at `θ = 0`, which fails `hθ`. Exhibiting a maximiser is a separate result, and this does not bear on correctness.

## 5. INDEX L122 row ([lean/INDEX.md:356](../lean/INDEX.md#L356))

| Record clause | Declaration | Status |
|---|---|---|
| Bracketed form, diagonality alone | `pairBlock` (L122Block.lean), `foxProd_pairVec` | present |
| Laplacian rewriting with the `n−2` Ricci rows | `block_eq_kirchhoff`, `quadS_Lb`, `degree_eq` | present, entrywise on `Lb` |
| Degrees `−(M_ij + M_ik)` | `degree_eq` | present |
| Ricci cut = `𝟙^⊥` | `pair_ric`, `pair_ricciFlat_iff`, `kirchhoff_row_sum` | present |
| Inequality at maximisers | `L122_lambda_min_of_max` | present |
| `tr Δ = 2M_jk` forcing a negative eigenvalue | `kirchhoff_trace` and the pigeonhole in L122.lean | present, spectral theorem imported (the row says so) |
| Orbit direction eigenvalue `θ/2` | `orbit_eigen` | present |
| **Within-factor blocks are orbit-free** | **none**: `s3s3_within_factor` is `choose 3 2 + choose 3 2 = 6` by `decide` | **gap** |
| Within-factor top `(p−2)/(2(p−1))`, "now proved" in L122's section | `withinTop` in L127.lean is arithmetic on the printed value | **gap if counted as L122's** |

Gaps:

- **G1.** "Within-factor pair blocks at `S^p × S^q` carry no orbit direction, since `M_ji = M_ki`" has no declaration.
  - [L122Orbit.lean:61](../lean/HamiltonsCubic/Results/L122Orbit.lean#L61) asserts "`T_jk = 0` on the within-factor blocks" in a docstring only.
  - [L122.lean:147](../lean/HamiltonsCubic/Results/L122.lean#L147) proves the count 6, which is binomial arithmetic.
  - The missing theorem: `(∀ i, w j i = w k i) → orbitTan (diagOp w) j k = 0` on skew arguments. It is one line from `orbit_in_pairBlock` with `x = 0`.
  - The row's "**Owed**: nothing of L122's claims as a declaration" is therefore an overclaim for this clause.
- **G2.** The within-factor top eigenvalue `(p−2)/(2(p−1))` is printed inside the L122 section of [second-order.md](../findings/second-order.md) as "now proved".
  - [L122Statement.lean](../lean/HamiltonsCubic/Results/L122Statement.lean)'s docstring lists it as absent.
  - The L122 row does not mention it.
  - It belongs to L127 more naturally. The row should say where it is owed, or say that it is out of L122's scope.
- **G3 (wording).** The row still says of the bracketed and Kirchhoff forms "no theorem composes the two". `L122_lambda_min_of_max` now composes them at the level of the quadratic form, through `lambda_min_bound` and `quadS_Lb`. The operator identity `M ∘ (∑ c_i f_i) = ∑ (−½Δc − ½M_jk c)_m f_m` remains a two-step rewrite with no single declaration. The sentence should be restated as that.

## 6. Axiom audit

`axiom_audit.py --only L122Cap.lean` reports 10/10 declarations clean, on `propext`, `Classical.choice` and `Quot.sound`. There is no `sorry` and no `native_decide`. The full build of the module succeeded.

## Summary

`hcap` is genuinely discharged from `L24_weyl`, and L122's spectral condition now holds as a theorem at every unit critical coordinate-diagonal local Weyl maximiser with `θ > 0`. The INDEX row's "proved, owed nothing" misses the orbit-free within-factor clause (G1) and leaves the within-factor top (G2) unplaced.
