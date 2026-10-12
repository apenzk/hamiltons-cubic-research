# REVIEW r1169: the Casimir identity on skew matrices and the halving, in Lean

Brief: [2026-09-25-casimir2-gate2-brief.md](2026-09-25-casimir2-gate2-brief.md). Module: [Casimir.lean](../lean/HamiltonsCubic/Results/Casimir.lean). Analysis plus the one named build and the axiom audit.

## Verdicts

| item | verdict |
|---|---|
| 1. declarations state their claims, factor in row (A) | CONFIRMED |
| 2. L244 row and working-file mentions claim only this | CONFIRMED, one note on the working file |
| 3. build and axiom audit | CONFIRMED |

## Item 1: CONFIRMED

- `casimir_skew`: hypothesis `xᵀ = -x` only (satisfiable, no vacuity), conclusion `∑_{i,j} tr([φ_ij,x]ᵀ[φ_ij,x]) = 4((n:ℝ) − 2) tr(xᵀx)` over all ordered pairs of `Fin n`. This is the claimed statement with the Frobenius norm written as `tr(Mᵀ M)`. At `n ≤ 1` the only skew matrix is zero, so the real subtraction `(n:ℝ) − 2` does no harm.
- `sum_halve`: hypotheses `f i j = f j i` and `f i i = 0`, conclusion `∑_{i,j} f = 2 ∑_{i,j} [i < j] f`. Exact.
- `phi_swap` (`φ_ji = −φ_ij`) and `phi_diag` (`φ_ii = 0`): exact.
- `casimir_skew_lt`: `∑_{i,j} [i < j] tr([φ_ij,x]ᵀ[φ_ij,x]) = 2((n:ℝ) − 2) tr(xᵀx)` for skew `x`, obtained from `casimir_skew` and `sum_halve` with symmetry of the summand from `phi_swap` (the bracket changes sign, the square does not) and the diagonal from `phi_diag`. Exact.
- `phi_eq_layer`: `Casimir.phi i j = RealLayer.phi i j`, the layer's `single j i 1 − single i j 1` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean). `casimir_traceless` is `casimir` at `tr h = 0`. Both exact.
- **The factor.** The record's inner product is `⟨X,Y⟩ = ½ tr(XᵀY)` (`inner2` in [L82Statement.lean](../lean/HamiltonsCubic/Results/L82Statement.lean)). Dividing both sides of `casimir_skew_lt` by 2 gives `∑_{i<j} ⟨[φ_ij,x],[φ_ij,x]⟩ = 2(n − 2)⟨x,x⟩`, the identity being homogeneous. The `φ_ij` with `i < j` have `‖φ_ij‖_F² = 2`, so they are the record's orthonormal basis of `Λ²`.
- **Row (A) summed over classes.** [second-order.md](../findings/second-order.md) line 308 states `∑_{a,b} b_ab(x) = n − 2` at unit `x`, with `b_ab(x) = ½ ∑_{γ∈E_a, δ∈E_b} ⟨[ψ_γ,ψ_δ],x⟩²`. Parseval (`rowMass_eq`) gives `∑_b b_ab(x) = ½ ∑_{γ∈E_a} ⟨[ψ_γ,x],[ψ_γ,x]⟩`, and summing over `a` gives `½ · 2(n − 2)⟨x,x⟩ = (n − 2)⟨x,x⟩`. The `½` in `b_ab` exactly cancels the 2 in `casimir_skew_lt`, and the record's proof line 312 (`∑_{γ∈E_a} ‖[x,ψ_γ]‖² = 2∑_b b_ab(x)`) carries the same factor. Screen by hand at `n = 3`, `x = φ_12`: the other two basis elements each bracket to a unit vector, total `2 = 2(3 − 2)`.

## Item 2: CONFIRMED

- The L244 row of [lean/INDEX.md](../lean/INDEX.md) states `casimir_skew` and `casimir_skew_lt` with the constants above, names `sum_halve`, `phi_swap`, `phi_diag` as the route, and records that the assembly into the `b_ab` (the identification of the `i < j` basis with the eigenspace-labelled family fed to `rowMass_eq` and `rowMass_split`) is untyped. That is accurate: no declaration composes these.
- [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md) line 207 cites `casimir_skew_lt` for `∑_{a,b} A_ab = 2(n − 1)(n − 2) I`. The constant checks: `tr ∑ A_ab = ∑_δ ∑_γ ‖[ψ_γ,ψ_δ]‖_F² = N · 4(n − 2)` with `N = n(n − 1)/2`, and dividing by `n` gives `2(n − 1)(n − 2)`. **Note:** what `casimir_skew_lt` supplies is the per-`δ` Casimir constant. The sum over `δ` and the invariance step that makes `∑ A_ab` scalar are prose. The line's closing phrase "the Casimir constant typed" is accurate as worded, and a reader should read the parenthetical citation as the source of that constant rather than as a typed matrix identity. No correction required.
- Line 195 of the same file cites `casimir` (the symmetric identity), outside this round's new declarations, and states it as typed. Accurate.

## Item 3: CONFIRMED

- `lake build HamiltonsCubic.Results.Casimir` from `lean/`: "Build completed successfully (8708 jobs)", zero errors, zero `sorry`. Only warnings are style lints (line 167 over 100 characters).
- `python3 scripts/misc/axiom_audit.py --only Casimir`: "12/12 clean -- resting on the standard three alone".

## Cosmetic

- The module docstring's title is "The Casimir identity on symmetric matrices" while the file now also holds the skew identity and the halving. Worth widening at the next edit of the file.
