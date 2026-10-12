# Gate 2 review r1877: I122 step 4, the g₂ sharp-eigenoperator and the second-order reduction

Reader one of two. Brief: [BRIEF_I122_step4.md](BRIEF_I122_step4.md). Log: [agent_logs/r1877-i122-step4.log](../agent_logs/r1877-i122-step4.log). Lean read: [I122TwoWeight.lean](../lean/HamiltonsCubic/Results/I122TwoWeight.lean).

**Verdict: the block is correct. Step 4 is false as stated, the g₂ solution is exact, and the second-order reduction is right. Two small corrections to the criterion and one upgrade: the two-weight screen of the reduced inequality is a theorem on that family.**

| item | claim | verdict |
|---|---|---|
| 1 | two-weight rows, Casimir ratio, c₁, quadratic, criterion, symmetric r₂ = −1 | CONFIRMED, with two edge conditions on the criterion |
| 2 | g₂ ⊃ su(3) example, r₂ = 1/3, λ = 28/9, irreducibility, exact solution | CONFIRMED |
| 3 | values 1.0568 and 1.0690, the latter the table's g₂ value | CONFIRMED |
| 4 | g₂ ⊂ so(7) on the boundary, scalar-forcing families | CONFIRMED (boundary, symmetric pairs, u(2) ⊂ su(3)) |
| 5 | second-order reduction λ ≥ Ct/(N + t²), g₂ numbers | CONFIRMED |
| 6 | scope | CONFIRMED, one sentence overreaches mildly, and the family screen undersells a proof |

## Item 1

- **Rows constant.** G is k-invariant and # is equivariant, so G#G commutes with k. On k (adjoint, irreducible) and on m (irreducible) a symmetric commuting operator is scalar in all three real types, since the imaginary part of the commutant acts skew. The off-diagonal block is a k-map k → m and vanishes when m is not isomorphic to the adjoint of k, which holds whenever d_m ≠ d_k. The note should state that hypothesis, or observe it is automatic in its examples.
- **Casimir ratio.** With the metric a multiple μ of the normalised form (long roots of length² 2), Σ_{γδ} c_{αγδ}² equals 2h^∨_h/μ on h and 2h^∨_k/(μj) on k, so κ/C = h^∨_k/(j h^∨_h). In the record's units C(so(m)) = 2(m − 2), so C(so(7)) = 10 and C(g₂) = 8.
- **c₁.** Σ over α ∈ m, γ ∈ k, δ ∈ m of c² equals Σ_{γ ∈ k} (C − κ) = d_k(C − κ), since [k, k] ⊂ k kills the mixed k×k×m terms. Per α ∈ m this is d_k(C − κ)/d_m, and counting ordered pairs doubles it, so c₁ = 2d_k(C − κ)/d_m.
- **Rows.** For α ∈ m, (G#G)_{αα} = ½ b(c₁a + c₂b), giving 2λ = ac₁ + bc₂. For α ∈ k, (G#G)_{αα} = ½(κa² + (C − κ)b²). Dividing gives (C − κ)r² − c₂r + (κ − c₁) = 0, whose coefficients sum to zero, so r = 1 and r₂ = (κ − c₁)/(C − κ). The Lean factorisation in two_weight_roots, (b − a)(b(C − κ) − a(κ − c₁)) = 0 from hk + e, expands correctly.
- **Criterion.** r₂ > 0 is equivalent to κ(d_m + 2d_k) > 2d_kC, that is κ/C > 2d_k/(d_h + d_k). **Correction**: "positive non-scalar exactly when" also needs r₂ ≠ 1, which fails exactly at κ/C = ½ + d_k/(2d_h), and uses C > κ (true whenever m ≠ 0).
- **Symmetric pair.** [m, m] ⊂ k gives c₂ = 0, c₁ = C, r₂ = −1.

## Item 2

- By hand: C = 8, κ = 6, d_k = 8, d_m = 6, so c₁ = 16/3 = ⅔C, c₂ = 8/3, r₂ = (2/3)/2 = ⅓, and 2λ = 16/3 + 8/9 = 56/9, λ = 28/9. The k row gives 6 + 2/9 = 56/9.
- m is the real form of the 3 of su(3), of complex type (3 is not isomorphic to 3̄), hence irreducible over the reals. Its commutant is C = span{1, J} with J orthogonal and skew, so symmetric commuting operators are scalar.
- **Own construction** (43 s): g₂ as the stabiliser in so(7) of φ = e123 + e145 + e167 + e246 − e257 − e347 − e356 (dimension 14), su(3) as the stabiliser of e₇ in it (dimension 8), # from so(7)'s structure constants. I#I = 5I, P_g#P_g = 4P_g (C = 8). At r = ⅓, λ = 3.1111 = 28/9 and ‖G#G − λG‖ = 5.2 × 10⁻¹⁵. At r = 1, λ = 4 and residual 9.1 × 10⁻¹⁵. At r = ½ the residual is 0.094.

## Item 3

- T(⅓) = 1.056792 and T(1) = 1.069045 = 4/√14, which is C/(2√N) = 8/(2√14), the scalar value on g₂ and the table's entry.
- By hand along the family G = P_k + rP_m: ⟨G#G, G⟩ = 24 + 24r² + 8r³ and ‖G‖² = 8 + 6r², and T′ vanishes at 3r² − 4r + 1 = 0, so r = ⅓ is a local minimum and r = 1 a local maximum, as the note says.

## Item 4

- g₂ ⊂ so(7): κ/C = 4/5 = 28/35 = 2·14/(21 + 14), and c₁ = 2·14·2/7 = 8 = κ, so r₂ = 0 exactly.
- Symmetric pairs: done in item 1. With k non-simple the factor rows read (r² − 1)(C − κ_i) = 0, so r = 1 again.
- u(2) ⊂ su(3), weights a on su(2), c on u(1), b on C². In units C = 1, κ_{su(2)} = ⅔, the per-row counts on m are ¼ and ¼, and the rows are λ = (a + c)/4, b² = 2λc, ⅔a² + ⅓b² = 2λa. Eliminating gives (a − c)² = 0, then b = a. Scalar only, confirmed (a double root, the scalar is degenerate in this family).

## Item 5

- X = I_h − tG is supported on h, where G is positive definite, so G ± εX stays positive with range h. ⟨X, G⟩ = t − t = 0.
- ⟨G#I, I⟩ = ⟨I#I, G⟩ = ½Ct and ⟨G#I, G⟩ = ⟨G#G, I⟩ = λt, using the full symmetry of ⟨A#B, D⟩ (swapping two argument pairs flips two signs of c).
- Second variation of the cubic on the sphere at a critical point: 6⟨G#X, X⟩ − 3λ‖X‖² ≤ 0. With ‖X‖² = N − t² and ⟨G#X, X⟩ = ½Ct − λt², this is exactly λ(N + t²) ≥ Ct. At the scalar, t = √N and λ = C/(2√N) give equality.
- g₂ numbers from my construction: t = 3.39683, Ct/(N + t²) = 1.06407, λ = 1.05679, and both trace identities agree to machine precision. C = κ_{g₂} = 8 is the right constant, since the identities use I_h#I_h = ½C I_h on h.
- **Extra**: the Hessian on Sym²(g₂) ⟂ G at r = ⅓ has 1 positive eigenvalue (the I direction), 6 null (the G₂/SU(3) orbit, 14 − 8) and 97 negative, so "saddle" is correct within g₂.

## Item 6

- **The two-weight screen is a theorem.** Along the family, T′(r) is a positive multiple of −r(C − κ)(r − 1)(r − r₂). The tangent to the family at G is proportional to I − tG, and at a critical point the second variation along a curve depends only on the tangent. So the larger root is the family maximum and the smaller the minimum: the reduced inequality holds strictly at every two-weight solution with 0 < r₂ < 1 and fails at every one with r₂ > 1. The note's 3.75 million grid points can be replaced by this line.
- The r₂ > 1 threshold κ/C > ½ + d_k/(2d_h) is correct: r₂ > 1 is equivalent to 2κd_h > C(d_h + d_k).
- The critical-set screen is reported as uninformative, which is what it is. Its listed λ values match the scalar values of so(3), so(4), so(5) and of the principal so(3) ⊂ so(5) (κ/C = 2/(10·3), κ = ⅖, value 1/(5√3)).
- The reduced inequality is labelled unproved, correctly. The reduction's direction of implication is right: strict reverse inequality at every non-scalar full-range solution excludes it as a maximiser.
- **Mild overreach**: "a proof, or a counterexample, turns on whether a full-range solution can weight m above k" is established only for two-weight solutions. General full-range solutions need not be two-weight, so the sentence should be scoped to the family.

## Corrections for the author

1. State the criterion as κ/C > 2d_k/(d_h + d_k) with κ/C ≠ ½ + d_k/(2d_h) (the second excludes r₂ = 1).
2. Add the hypothesis that m is not isomorphic to the adjoint of k (automatic when d_m ≠ d_k), needed for the off-diagonal block of G#G to vanish.
3. Replace the 3.75-million-point screen by the factorisation T′(r) ∝ −r(C − κ)(r − 1)(r − r₂), which proves the reduced inequality on the whole two-weight family with 0 < r₂ < 1 and its failure for r₂ > 1.
4. Scope "turns on whether a full-range solution can weight m above k" to two-weight solutions.
