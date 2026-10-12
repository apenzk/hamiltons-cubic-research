# Gate 2 review r1878: I122 step 4, the g₂ sharp-eigenoperator and the second-order reduction

Reader two of two, working independently. Brief: [BRIEF_I122_step4.md](BRIEF_I122_step4.md). Note: [2026-09-28j-I122-step4.md](2026-09-28j-I122-step4.md). Lean: [I122TwoWeight.lean](../lean/HamiltonsCubic/Results/I122TwoWeight.lean). Log: [r1878-i122-step4.log](../agent_logs/r1878-i122-step4.log).

**Verdict: the counterexample to step 4 stands and the second-order reduction is correct. Two hypotheses of item 1's general statement need adding, neither touching the g₂ example.**

| item | claim | verdict |
|---|---|---|
| 1 | two-weight rows, Casimir ratio, c₁, quadratic, criterion, symmetric pair | CONFIRMED with two corrections (double root, m ≇ k) |
| 2 | the g₂ ⊃ su(3) example | CONFIRMED, reproduced by an independent construction |
| 3 | its value against the scalar's | CONFIRMED |
| 4 | the boundary case and the scalar-only families | CONFIRMED (boundary and the symmetric-pair family checked) |
| 5 | the second-order reduction | CONFIRMED |
| 6 | scope | CONFIRMED, one wording note |
| Lean | two_weight_roots, g2_su3_root | CONFIRMED (read, no lake run) |

## Item 1

- **Rows constant.** The sharp is equivariant under Ad of the group of h, and G = aP_k + bP_m commutes with ad k, so G#G is a symmetric k-equivariant endomorphism of k ⊕ m. On k (adjoint of a simple algebra, real type) it is scalar. On m of complex type the commutant is ℂ = span(I, J) with J skew (the commutant is closed under transpose, and transpose acts on it as a positive involution, hence as conjugation), so its symmetric part is scalar. Quaternionic type is the same argument. The cross block lies in Hom_k(k, m), which vanishes when m ≇ k. **Correction: state m ≇ k as a hypothesis** (automatic when d_m ≠ d_k, so the g₂ example is unaffected).
- **Row formulas.** With c_{αγδ} totally antisymmetric and [k, m] ⊂ m, a k row sees only k×k pairs (κ) and m×m pairs (C − κ), giving a²κ + b²(C − κ) = 2λa. An m row sees mixed pairs (both orders, total c₁) and m×m pairs (c₂), giving 2λ = ac₁ + bc₂ with c₁ + c₂ = C.
- **Casimir ratio.** In an orthonormal basis for h's metric, B_h(X, X) = −C‖X‖², and B_h restricted to k equals (j h∨_h / h∨_k) B_k, so κ/C = h∨_k/(j h∨_h).
- **c₁.** Summing the m rows, d_m c₁ = 2 Σ_{γ∈k} Σ_{α,δ∈m} c² = 2d_k(C − κ).
- **Quadratic.** Substituting the m row gives (C − κ)r² − c₂r + (κ − c₁) = 0, root r = 1 since c₁ + c₂ = C, product of roots (κ − c₁)/(C − κ). Positivity of r₂ is κ > c₁, which rearranges to κ/C > 2d_k/(d_h + d_k).
- **Correction: the criterion as stated ("exactly when") also admits the double root.** r₂ = 1 exactly when κ/C = ½ + d_k/(2d_h), where the second root coincides with the scalar. The non-scalar criterion is κ/C > 2d_k/(d_h + d_k) and κ/C ≠ ½ + d_k/(2d_h).
- **Symmetric pair.** [m, m] ⊂ k gives c₂ = 0, c₁ = C, r₂ = −1.

## Item 2

- By hand: κ/C = 3/(1·4) = ¾ > 16/22, c₁ = 2·8·(C/4)/6 = ⅔C, c₂ = ⅓C, r₂ = (1/12)/(1/4) = ⅓, 2λ = C(⅔ + 1/9) = 7C/9, so λ = 28/9 at C = 8 for the unnormalised G = P_su(3) + ⅓P_m.
- m ≅ ℂ³ as a real 6-dimensional su(3)-module, irreducible of complex type (ℂ³ is not self-conjugate), so item 1's argument gives constant rows.
- **Own construction** (bounded in advance in the log, seconds): so(7) in the basis e_ij with the record's sharp (I#I = 5I checked), g₂ as the kernel of the derivation action on φ = e123 + e145 + e167 + e246 − e257 − e347 − e356 (dimension 14), su(3) as the stabiliser of e₇ in it (dimension 8). Results: C_g₂ = 8.000, κ/C = 0.7500, λ = 3.1111 = 28/9 with residual ‖G#G − λG‖ = 6×10⁻¹⁵ at r = ⅓, λ = 4 with residual 8×10⁻¹⁵ at r = 1.

## Item 3

- At r = ⅓, T = λ/‖G‖ = (28/9)/√(26/3) = 1.05679. At r = 1, T = (C/2)/√14 = 4/√14 = 1.06904, the table's g₂ value. Both reproduced by the construction.
- Along the family (r from 0.1 to 1.6 in steps of 0.1) T falls to 1.0569 near r = 0.3, rises to its maximum 1.0690 at r = 1 and falls again, consistent with a local minimum at ⅓ and a local maximum at 1.

## Item 4

- g₂ ⊂ so(7): κ/C = 4/5 = 28/35 = 2·14/(21 + 14), so r₂ = 0 exactly.
- Symmetric pair family checked (item 1: r₂ = −1). The u(2) ⊂ su(3) and root-plane families were not rechecked.

## Item 5

- G is positive definite on h, so any symmetric X on h keeps G + εX positive for small ε of either sign, and X = I_h − tG with t = tr G satisfies ⟨X, G⟩ = t − t = 0.
- ⟨A#B, C⟩ is totally symmetric, so with ‖G‖ = 1 the Lagrangian's second variation is 6⟨G#X, X⟩ − 2μ‖X‖² with 3λ = 2μ, giving ⟨G#X, X⟩ ≤ (λ/2)‖X‖².
- On h the so(m) sharp restricts to h's own (c_{αγδ} = 0 for α ∉ h and γ, δ ∈ h), so I#I = (C/2)I with C the Casimir of h in so(m)'s metric. Hence ⟨G#I, I⟩ = Ct/2 and ⟨G#I, G⟩ = ⟨G#G, I⟩ = λt. With ‖X‖² = N − t² the condition is Ct/2 − λt² ≤ (λ/2)(N − t²), that is λ ≥ Ct/(N + t²). At G = I/√N both sides equal C/(2√N).
- g₂ saddle: t = 10/√(26/3) = 3.3968, Ct/(N + t²) = 27.175/25.538 = 1.0641 > λ = 1.0568, so the test along I rejects it. C = 8 = κ_g₂ is the right constant on h = g₂.
- The logic of the reduction holds: steps 1 to 3 put a maximiser at a full-range positive sharp-eigenoperator on a simple h, and a strict reverse inequality at every non-scalar one leaves only the scalar.

## Item 6

- The reduced inequality is labelled unproved, the abstract two-weight screen is labelled a screen and was not reproduced here (it is a sweep). The r₂ > 1 threshold κ/C > ½ + d_k/(2d_h) is correct by hand: r₂ > 1 ⇔ 2κ > C + c₁ ⇔ 2κd_h > C(d_h + d_k).
- The falsifier screen is correctly called uninformative. Wording note: "so it cannot see full-range saddles" is stronger than the evidence, which shows only that this optimiser did not reach one.
- λ is used unnormalised (28/9) in the example and normalised (1.0568) in the reduction. **Suggest labelling the normalisation** at each use.

## Lean

- two_weight_roots: the product (b − a)(b(C − κ) − a(κ − c₁)) expands to hk + e, so the linear_combination is correct and the statement matches the note's rows.
- g2_su3_root: both sides of the k row equal (7/9)a²C, and a/3·C/4 = aC/12 = a(¾ − ⅔)C. The non-vacuity example at C = 4, κ = 3, c₁ = 8/3 checks.
