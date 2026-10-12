# REVIEW r1892: equal_weight_torus against sp(k)'s displayed torus rows

Log: agent_logs/r1892-sp-torus-rows.log. Declaration: `HamiltonsCubic.SpTorusEqualWeight.equal_weight_torus` in lean/HamiltonsCubic/Results/SpTorusEqualWeight.lean. Source: reviews/2026-09-28l-I117-g2-torus.md, section on the sector p = q.

| row | claim | verdict |
|---|---|---|
| 1 | `ha`, `hlong`, `hrow` are the displayed a_i definition, long row and p-row, and no hypothesis exceeds a positive solution with p = q | CONFIRMED |
| 2 | the conclusion is the Statement, no weaker | CONFIRMED |
| 3 | the body follows steps 1 and 2 | CONFIRMED, with two prose corrections |
| 4 | axioms standard, the k = 3 example type-checks and bundles every hypothesis | CONFIRMED |

## Row 1: hypotheses

- `ha`: `a i = 2 * u i ^ 2 + 1/2 * ∑ j, (P i j ^ 2 + Q i j ^ 2)` is the displayed a_i term for term. The sum runs over all of `Fin k`. The j = i term is `P i i ^ 2 + Q i i ^ 2`, which is 0 because `hPQ : Q = P` and `hdiag : P i i = 0`, so it equals the display's sum over j ≠ i.
- `hlong`: `u i * (1 - 2 * a i) = ∑ j, P i j * Q i j` is the long row. The j = i term vanishes the same way.
- `hrow`: the left side is p_ij(1 − X⁻_ij) with X⁻_ij = (a_i + a_j)/2 − (q_ij² − p_ij²)/2 exactly, and the right side is (u_i + u_j) q_ij + ½ Σ_l (p_il p_jl + q_il q_jl). The Lean sum includes l = i and l = j. Those terms are p_ii p_ji + q_ii q_ji and p_ij p_jj + q_ij q_jj, all zero by the zero diagonal, so the Lean row agrees with the display whether its Σ_l is read over all l or over l ∉ {i, j}.
- Screen of consistency (hand arithmetic, not evidence): at p = q = u = 1/(k+1), a_i = (2 + (k−1))/(k+1)² = u, and the p-row reads k/(k+1)² on both sides, so the reading of the ranges above is the one the uniform point satisfies.
- Side hypotheses. `hPQ` is the sector. `hsym : Pᵀ = P` is the convention that p_ij is the weight on the root plane of ±(ε_i − ε_j); the displayed p-row forces it anyway, since its right side and X⁻ are symmetric in i, j. `hdiag` encodes that p_ii names no root. `hpos` and `hu0` are the note's "positive solution". `a` is a free variable pinned by `ha`, so it adds nothing. None exceeds what a positive solution with p = q supplies.
- The q-rows are omitted, which only weakens the hypotheses. At q = p they coincide with the p-rows (X⁺ = X⁻ since q² − p² = 0, and the two right sides are equal term by term), so nothing is lost either.

## Row 2: conclusion

`(∀ i, u i = 1/(k+1)) ∧ ∀ i j, i ≠ j → P i j = 1/(k+1) ∧ Q i j = 1/(k+1)` is the Statement. The derivation from `equal_weight_unique`'s `S i j = 2/(k+1)` with S = 2Q is the `linarith` after `div_eq_mul_one_div`.

## Row 3: body against steps 1 and 2

- Step 1. `hr` gives Σ_j Q_ij² = a_i − 2u_i² from `ha`. Substituted into `hlong` it gives (u_i − a_i)(1 + 2u_i) = 0, and `hu0` kills the second factor, so a_i = u_i (`hau`). The prose writes "give r_i = 4u_i(1 − 2u_i) and so a_i = u_i" and leaves out this factorisation and its use of u_i > 0. **Correction:** step 1 should name the factorisation (u_i − a_i)(1 + 2u_i) = 0 and u_i > 0.
- The bound. The Lean derives u_i < 1 (`hu1`) from u_i(1 − 2u_i) = Σ_j Q_ij² ≥ 0 and u_i > 0, which gives u_i ≤ ½. It uses only non-strict nonnegativity of the sum. The prose's "a_i < ½, so u_i < ½" needs the sum to be strictly positive, which holds only when some j ≠ i exists. **At k = 1 the prose claim is false:** the sum is empty, the long row reads u(1 − 2u) = 0, and the solution has u = a = ½ = 1/(k+1). **Correction:** step 1 should say a_i = u_i ≤ ½ (strict for k ≥ 2), and step 4 needs only u_i < 1. The theorem is unaffected, because the Lean passes u_i < 1 to `equal_weight_unique`.
- Step 2. `heq` is the matrix equation for S = 2 • Q, proved entry by entry. The diagonal uses `hr`, `hau`, symmetry (`Q l i = Q i l`) and `hdiag`, which is the prose's (S²)_ii = 4u_i(1 − 2u_i). The off-diagonal entry uses `hrow` with `hau` and symmetry, and is closed by `linear_combination (-4) * hrow`, which is the prose's (S²)_ij = s_ij(2 − 3(u_i + u_j)). The prose leaves implicit the symmetry used to turn Σ_l s_il s_lj into Σ_l s_il s_jl; the Lean states it. Nothing else the Lean needs is missing from the prose.
- The remaining hypotheses of `equal_weight_unique` (symmetry, zero diagonal and positivity of 2Q) are discharged from `hsym`, `hdiag`, `hpos`.

## Row 4: checks

- `lake env lean` on a scratch copy with `#print axioms` appended: no errors, and `equal_weight_torus` depends on `[propext, Classical.choice, Quot.sound]` only.
- The last `example` type-checks in the same run. It states, for the 3 × 3 uniform P with u = a = ¼, `hsym`, `hdiag`, `hpos`, `hu0`, `ha`, `hlong`, `hrow` with Q written as P, which is every hypothesis of `equal_weight_torus` once `hPQ` is taken as `rfl`.
