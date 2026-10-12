# REVIEW r1708: J1_odd for m ≥ 7 from L278, and the odd L273 (R48 batch 11)

Log: agent_logs/r1708.log. Reviewed claim: [the R48 working note](2026-09-27-R48-torus-families.md), batch 11. Footing: analysis only, with screens reported as screens.

**Verdict.** J1_odd follows from L278 and L277's lemmas exactly as written: steps 1 to 7 are CONFIRMED. The odd L273 is CONFIRMED given batch 5's formula, with one error in an intermediate claim. The stated range "c₂ + c₃δ + c₄δ² > 0 for δ ≥ −0.5" is false for every m ≥ 9, but the argument only needs δ ≥ 1 − t_u ≥ −1/(4m). A closed-form argument, given below, repairs it and also discharges the "owed" positivity of c₂, c₃, c₄ for all m ≥ 7.

| claim | verdict | reason |
|---|---|---|
| J1_odd (statement) | CONFIRMED | Follows from steps 1–7 and L278. Screen: max of LHS − c₀ is 0 at the uniform point, and at most −8.9e−5 (m=7) and −1.4e−4 (m=8) over 20000 random and near-uniform points each |
| step 1 embedding | CONFIRMED | U′, V′ are symmetric with zero diagonal. In the cyclic trace, a term with ≥2 indices at m+1 has two of them adjacent, which gives the factor P′_{m+1,m+1}=0. Exactly one index at m+1 gives 3 slots × Σ √2w_b P_bc √2w_c = 6wᵀPw, and half of that is 3wᵀPw. Q′=0 on the new edges. Norm: ‖U′‖²+‖V′‖² = ‖U‖²+‖V‖²+2‖w‖². d′ and x′ are as stated. Screen: trace identity error 1e−14 |
| step 2 | CONFIRMED | `cocktail_rows` is generic in `m`, and IsPairWeights holds for U′, V′ |
| step 3 | CONFIRMED | The ordered pairs a≠b split into (both ≤ m) and (one index = m+1), each exactly once. Diagonal terms are 0. Per pair s√(ee′) = √(f′R′) when R′>0, and when R′=0 we get ee′=0 by `ee_le_R`. Cauchy–Schwarz holds within each group |
| step 4 | CONFIRMED | AM-GM with F, R ≥ 0 (`Rw_nonneg`, f′ ≥ 0). Both t_o and t_n are > 0 |
| step 5 | CONFIRMED | 2·hterm_ab = x(1−q)(2γ(1−q) + 1 − γ) = x(1−q)(1+γ(1−2q)). So f′_ij + f′_ji ≤ 2(h_ij+h_ji) is the stated two-term sum. q is taken at d′ because the lemma runs at size m+1, and x′, γ′ equal x, γ on old pairs. (U²−V²)² = x²(1−γ²) = P²Q² (`ww_gam`) |
| step 6 | CONFIRMED | 2w_i² (d′_i−w_i²)(‖w‖²−w_i²)/(d′_i‖w‖²), the same in both orientations. Hence F_n = 4Σw_i²(1−q_{i0})(1−q_{0i}) and R_n = 2‖w‖²Σd′_i, and ½(t_nF_n + R_n/t_n) is L278's 2t_nΣ… + π₀S/t_n. Degenerate cases: see finding 3 |
| step 7 | CONFIRMED | Mass Σ_old x + 2‖w‖² = b² = 1, π_i = d′_i, π₀ = ‖w‖². The x²(1−γ²) terms combine with coefficient λ − 1/(2t_o). λΣ_{i≤m}π_i² matches, and γ ∈ [0,1] (`gam_range`). The result is term for term L278's left side |
| odd L273 | CONFIRMED given batch 5, with one intermediate claim false | Cauchy–Schwarz ⟨A,A_μ⟩ ≤ ag. Ψ_κ closed form: the stationary point 3κa√(1+a²) = 3g with convexity, and κt³ − 3(t²−1)κt = κt(3−2t²). h(t_u) = h′(t_u) = 0 symbolically, and g_u² matches. See findings 1–2 |
| Lean statement | CONFIRMED | n+1 = m and 6 ≤ n ↔ m ≥ 7. λ = 3√2m/(2(2m−1)) and c₀ = √2(2m−1)(4m−1)/(8m²). wᵀPw, the g² split with an explicit i≠j guard, and hb all match the prose. `IsPairWeights` = (Uᵀ = U ∧ ∀i, U i i = 0) |

## Findings

1. **Odd L273, "c₂ + c₃δ + c₄δ² > 0 for δ ≥ −0.5": error in an intermediate claim (not in the result).** Here δ = t − t_u, which the note leaves undefined (a presentational gap). In sympy the exact coefficients are c₂ = (3√2/2)(1 − 1/(m(2m+1))), c₃ = 4(2m−1)/√(m(2m+1)) and c₄ = λκ² = (3√2/2)(2m−1)/(2m+1). Since h is a quartic, h = δ²(c₂ + c₃δ + c₄δ²) exactly. The discriminant is positive, and the larger root is −0.5073 at m=7, −0.50036 at m=8 and −0.4950 at m=9, rising toward −0.4514 as m→∞. So at δ = −0.5 the quadratic is −0.0166 at m=9 and negative for every m ≥ 9. The conclusion survives because t ≥ 1 gives δ ≥ 1 − t_u ≥ −1/(4m), using √(1+1/(2m)) ≤ 1+1/(4m). **Repair:** for m ≥ 7, c₂ > 2 and c₃ < 4√2. Hence for δ ∈ [−1/(4m), 0], c₂ + c₃δ + c₄δ² ≥ 2 − √2/m > 0. For δ ≥ 0 every term is non-negative.
2. **"Owed: Taylor coefficients' positivity for all m ≥ 7": closed in the closed forms above.** Each is manifestly positive for m ≥ 1. The claim "increasing in m" is also true: for c₃ the derivative of (2m−1)²/(m(2m+1)) has sign (2m−1)(6m+1) > 0. The owed item can be struck, and the remaining owed item is only the odd L271.
3. **Degenerate q (gap in the argument, presentational).** When d′_i = 0 or ‖w‖ = 0, q_{i0} or q_{0i} is 0/0 in steps 6–7 and in L278's prose. The affected term carries the factor w_{i0} = w_i² = 0 and f′ = 0 by convention, so nothing changes. The prose should state the convention (Lean's x/0 = 0 does this automatically).
4. **Lean (noted for the formaliser):** J1.lean's `pairing` does one Cauchy–Schwarz over all pairs, so step 3's split needs a two-group variant (the same proof applied to a filtered sum). `pair_bound` and `ee_le_R` apply at size n+2 unchanged.

Screens (numpy/sympy, seconds): the J1_odd random and near-uniform screen at m = 7, 8, the trace identity, and the symbolic double root and Taylor coefficients.
