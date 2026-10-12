# REVIEW r1737: L273Owed.lean against L273

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every theorem in [L273Owed.lean](../lean/HamiltonsCubic/Results/L273Owed.lean) (commit 0b99fffe) states what [findings/second-order.md](../findings/second-order.md) Lemma L273 claims, or something at least as strong, and every proof is sound as read. Two observations, neither a defect in the file's statements.

Footing: analysis-only. One screen of seconds (floating point at m = 3, 4, 5, 6, reported as a screen, not evidence). No `lake build` run. The olean for L273Owed is timestamped one minute after the source, which suggests (inference) that the file compiled.

## Answers

1. **Constants.** `kap m = 2(m-1)/√(m(2m-1))` and `lam m = √(2m)(m-2)/((m-1)√(m-1))` are the record's κ and λ_m verbatim. `a0 m = √(1/(2(m-1)))` is the minimiser at g₀: with t₀² = 1 + a₀² = (2m-1)/(2(m-1)), κ a₀ t₀ = 2(m-1)/√(m(2m-1)) · √(2m-1)/(2(m-1)) = 1/√m = g₀, which is the stationarity relation κ a √(1+a²) = g. The proof of `psi_eq` uses exactly this relation (`hx`, from `jh_constants` c1) and then the value κ t₀(3 - 2t₀²) = λ_m(1 - 1/m) (c2).
2. **`L273_F_eq`.** It is the record's equality case: A = s·A_μ with s ≥ 0, ‖A‖ = √(Σ A_ij²) = s·g, g = √(Σ (A_μ)_ij²), the same norms as `L273_F_bound`. The proof rewrites `Ftri_torus` as 3⟨A, A_μ⟩ + T (off-diagonal A_μ = V² - U² = -(U+V)(U-V), diagonal d_i), then ⟨sA_μ, A_μ⟩ = s g² = √(s²g²)·g using s ≥ 0. It holds for all pair weights with no normalisation, which is stronger than the record needs.
3. **`L273_g_ge`.** The hypothesis is ½(‖U+V‖² + ‖U-V‖²) = 1, the record's b² = ½(‖P‖² + ‖Q‖²) = 1 with P = U + V, Q = U - V, as in `L273_J1_implies_H`. `sum_dvec` gives Σ d_i = b² = 1 = tr A_μ, `Amu_sq` gives g² = Σ d_i² + (off-diagonal squares) ≥ Σ d_i² ≥ (Σ d_i)²/m = 1/m by Cauchy–Schwarz. The m = 0 case is dispatched by contradiction. Correct.
4. **`psi_min`.** `IsLeast` of the image of [0, ∞) under a ↦ κ(1+a²)^{3/2} - 3a g₀ at the value λ_m(1 - g₀²) is exactly "Ψ_κ(g₀) = λ_m(1 - g₀²) with Ψ a min over a ≥ 0": membership at a₀ ≥ 0 from `psi_eq`, the lower bound from `psi_bound` at g = g₀. Hypothesis m ≥ 5 matches the record's scope.
5. **`psi_fails`.** Faithful and stronger. For every real 2 < m < 5 (so m = 4 included) it gives a non-empty interval (g₀, 3a₀/λ_m - g₀) on which the value at a₀ lies strictly below λ_m(1 - g²), hence Ψ_κ(g) < λ_m(1 - g²). The gap identity (g - g₀)(λ_m(g + g₀) - 3a₀) follows from `psi_eq` by ring. Threshold: (2λ_m g₀)² = 8(m-2)²/(m-1)³ and (3a₀)² = 9/(2(m-1)), so 2λ_m g₀ < 3a₀ ⇔ 16(m-2)² < 9(m-1)² ⇔ 4(m-2) < 3(m-1) (both sides positive for m > 2) ⇔ m < 5. Correct, with equality at m = 5, consistent with `psi_bound`.
6. **INDEX row.** Claims only what is typed, with one gloss (observation O1). Status stays **partial**, and the remaining "Not stated" items (J1 itself, L268's torusOp completeness) are still accurate.

## Observations

- **O1.** `psi_fails` and `psi_min` never define Ψ_κ. The INDEX row writes "Ψ_κ(g) ≤ κ(1+a₀²)^{3/2} - 3a₀g < λ_m(1-g²)", whose first inequality is the definition of a minimum over a ≥ 0 evaluated at a₀ ≥ 0. That step is immediate but untyped. The row would be exact if it said the typed statement is at a₀ and Ψ ≤ (value at a₀) is by definition.
- **O2.** The docstring of `L273_F_bound` in [I117Statements.lean:5043](../lean/HamiltonsCubic/Results/I117Statements.lean#L5043) still says "The record's equality case (`A` a non-negative multiple of `A_μ`) is not typed." It is now typed as `L273_F_eq`, so the docstring is stale and should point there.

## Falsifiers

| Statement | What would falsify it |
|---|---|
| `L273_F_eq` | pair weights U, V and s ≥ 0 with F(torusOp(sA_μ)) ≠ 3 s g² + T |
| `L273_g_ge` | U, V with b = 1 and ‖A_μ‖² < 1/m |
| `psi_eq` | a real m > 2 with 3a₀g₀ + λ_m(1 - 1/m) ≠ κ t₀³ |
| `psi_min` | m ≥ 5 and a ≥ 0 with κ(1+a²)^{3/2} - 3a g₀ < λ_m(1 - 1/m) |
| `psi_fails` | m in (2, 5) with 2λ_m g₀ ≥ 3a₀, or g in the interval with value at a₀ ≥ λ_m(1 - g²) |

Screen (floating point, not evidence): at m = 3, 4, 5, 6 the stationarity residual κ a₀ t₀ - g₀ is below 1e-15; the grid minimum over a at g₀ matches λ_m(1 - 1/m) to 1e-8; at g = g₀ + 0.001 the grid Ψ minus λ_m(1 - g²) is negative at m = 3, 4 and positive at m = 5, 6; the interval width 3a₀/λ_m - 2g₀ is 0.577, 0.125, 0, -0.051 at m = 3, 4, 5, 6.
