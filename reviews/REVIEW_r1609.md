# REVIEW r1609: I117Statements.lean at 77454e60, L272 (1), L273 (3), L264 (2)

Log: [agent_logs/r1609.log](../agent_logs/r1609.log)

File: [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean) at 77454e60, namespace HamiltonsCubic.I117S. Record: [second-order.md](../findings/second-order.md), Lemmas L264, L271, L272, L273. Analysis only: one seconds screen (C3), reported as a screen.

| claim | declaration | verdict |
|---|---|---|
| C1 | L272_square (line 542) | CONFIRMED |
| C2 | L273_J1_implies_H (line 843) | CONFIRMED |
| C3 | L264_not_simple_unstable (line 934) | CONFIRMED |

## Definitions read

- `dvec U V i = ∑_l (U_il² + V_il²)`, the record's d_i.
- `Amu U V` has diagonal d_i and off-diagonal V_ij² − U_ij² = −(U+V)_ij (U−V)_ij = −P_ij Q_ij, which is L271's A_μ.
- `IsPairWeights U` is Uᵀ = U and zero diagonal, which is L271's "symmetric m×m matrices with zero diagonal".
- `TorusSystem U V` is L268's two root equations per pair. `L271_pq_system` (proved) makes it equivalent to L271 (2)'s displayed P, Q system, term for term.
- `torusOp A U V`: on the Cartan, C J_k = ∑_i A_ik J_i with J_i orthonormal under inner2 (inner2(J_i, J_i) = ½ tr(J2ᵀJ2) = 1), and on block (i,j) it is U_ij on the J-commuting part and V_ij on the J-anticommuting part. Checked by hand: torusOp I 1 1 is the identity (cPart + aPart = id, and a skew diagonal block is X(i,1)(i,0) J2), and its norm reads m + 2m(m−1) = m(2m−1) = N under L271 (1), as it must.
- `IsStable`, `IsIdem`, `IsPSD2`, `IsSelfAdjoint2`, `Ftri = −½ phiTri`, `brS` (the matrix bracket on skewSub) read as their docstrings say.

## C1, L272_square: CONFIRMED

- **Off-diagonal clause.** The typed (X·X)_ij = X_ij − 2 (U+V)_ij (U−V)_ij² is X² = X − 2 P∘Q∘Q entrywise, with ∘ the Hadamard product. X = (U+V) + diagonal(dvec U V) is P + diag d.
- **Diagonal clause.** The typed (X·X − X)_ii = ∑_l (U+V)_il² + d_i² − d_i is π_i + d_i² − d_i.
- **Hypotheses.** The typed theorem takes IsPairWeights U, IsPairWeights V and TorusSystem U V. The record's "L271's notation" supplies the first two.
- **Dropping positivity is a true strengthening.** The declaration is proved on the standard three axioms (parent's audit), so the statement holds at every solution, sign-unrestricted. The record's proof of (1) uses only L271's P equation and (X²)_ii = π_i + d_i², so positivity plays no part in the argument either.
- **It does not matter downstream.** The record's (1) is the specialisation to positive solutions. Its only in-file consumer pattern, L272_perron, carries hpos itself.
- **No other hypothesis.** m ≥ 3 is absent, and no clause needs it.

## C2, L273_J1_implies_H: CONFIRMED

Link by link against L273's statement and L271 (1):

- **Sphere.** The typed ½(∑_ij (U+V)_ij² + ∑_ij (U−V)_ij²) = 1 is b² = ½(‖P‖² + ‖Q‖²) = 1 with ‖P‖² the full ordered-pair sum (the diagonal is zero). This is the repaired form from r1607. It is consistent with L271 (1): ∑_i d_i = ∑_il (U² + V²) = ½ ∑ (P² + Q²) = b², which is the record's tr A_μ = b² = 1.
- **λ_m.** The typed √(2m)(m − 2)/((m − 1)√(m − 1)) is √(2m)(m − 2)/(m − 1)^{3/2}. Both arguments of `Real.sqrt` elaborate over ℝ (binop leaves coerced), so no natural subtraction truncates.
- **g².** The typed ∑_i d_i² + ∑_{i≠j} (P_ij Q_ij)² is the Frobenius ‖A_μ‖². Squared, the off-diagonal entry −P_ij Q_ij gives exactly this. The Frobenius norm on A is the one L271 (1) uses for ‖A‖² (the J_i are orthonormal, and L271_F_slice types ‖A‖² as ∑∑ A_ij²), so g is measured in the same norm as ‖A‖ in L273 (1)'s Cauchy–Schwarz.
- **T.** The typed ½(tr P³ + tr Q³) is T.
- **Quantifier of J1.** J1 ranges over all pair weights U, V on the sphere, with no sign restriction. That matches "whenever b = 1": H is claimed for every torus-invariant X, so the weights take every sign. J1 mentions no A, as in the record.
- **κ and the norm power.** The conclusion is Ftri C C C ≤ 2(m − 1)/√(m(2m − 1)) · (normSq2 C)^{3/2}. Here κ = c/√N with c = 2m − 2 and N = 2m(2m − 1)/2 = m(2m − 1), so it matches kappaN at n = 2m. normSq2^{3/2} = ‖C‖³ with normSq2 ≥ 0.
- **Other hypotheses.** m ≥ 5 and Aᵀ = A (X ∈ Sym²) match the record.
- **Uniform point, by hand.** Take U = V = u off the diagonal, so P = 2u(J − I) and Q = 0.
  - The typed sphere gives ½ · 4u² · m(m − 1) = 1, so u² = 1/(2m(m − 1)).
  - tr (J − I)³ = (m − 1)³ − (m − 1) = m(m − 1)(m − 2), so T = ½ · 8u³ · m(m − 1)(m − 2) = √2 (m − 2)/√(m(m − 1)).
  - d_i = 2(m − 1)u² = 1/m, so g² = m · (1/m)² = 1/m.
  - λ_m(1 − g²) = √(2m)(m − 2)(m − 1)/(m (m − 1)^{3/2}) = √2 (m − 2)/√(m(m − 1)) = T.
  - So T + λ_m g² = λ_m: equality at the uniform point, as the record says.
- **Dependency, not a defect.** The hypothesis is in root-weight coordinates and the conclusion is in the layer's normSq2 and Ftri. So the typed implication is true exactly when the record's argument holds and L271 (1) holds in the layer's normalisation. That second condition is L271_F_slice, a separate sorry, screened per its docstring. My hand check of the norm at torusOp I 1 1 agrees with it. The F half is unchecked here.

## C3, L264_not_simple_unstable: CONFIRMED

- **The typed hypotheses force commuting ideals.** Let h_i = range D_i and h = range C.
  - The ranges are orthogonal. D₁, D₂ are self-adjoint with D₁D₂ = 0, so inner2(D₁x, D₂y) = inner2(x, D₁D₂y) = 0.
  - h = h₁ ⊕ h₂. First, h ⊆ h₁ + h₂ from C = D₁ + D₂. Conversely, C D₁ = D₁² + D₂D₁ = D₁², and range D₁² = range D₁ for self-adjoint D₁, so h₁ ⊆ h. The same holds for h₂.
  - [h₁, h₂] = 0 is hcomm.
  - [h₁, h₁] ⊆ h₁. By L260 (2) (record-proved, typed as the sorry L260_range_subalgebra), h is a subalgebra, so [h₁, h₁] ⊆ h. By ad-invariance of the trace form, inner2([x, y], z) = inner2(x, [y, z]) = 0 for x, y ∈ h₁ and z ∈ h₂, so [h₁, h₁] ⊥ h₂. Hence [h₁, h] = [h₁, h₁] ⊆ h₁, and likewise for h₂. So h₁, h₂ are nonzero commuting ideals of h. C restricts to D_i on h_i, so each D_i is positive definite there.
  - So h has at least two simple ideals and C is a PD idempotent on h: the record's hypotheses hold, at a split with E = 0.
- **The old counterexample is excluded, and no non-ideal split survives.** The self-adjoint analogue of r1607's split is D₁ = C + t v⟨v,·⟩, D₂ = −t v⟨v,·⟩ with v in the centraliser z of h. The centraliser is the trivial isotypic part of so(n) under h, and ad on semisimple h has no trivial summand, so z ⊥ h and Cv = 0. Then D₁D₂ = −t²‖v‖² v⟨v,·⟩ ≠ 0, which fails hrange. More generally, the argument above shows that any tuple satisfying the typed hypotheses is an ideal split.
- **The weakening is named.** The docstring says "at a split with no cross block" and "The record's (2) also covers a cross block E between the ideals."
- **The typed statement is true given the record.** Put H = ‖D₂‖² D₁ − ‖D₁‖² D₂. It is nonzero (the D_i are nonzero with orthogonal ranges), self-adjoint, and ⊥ C.
  - D₁ # D₂ = 0 because the ranges commute, and D_i # D_i = D_i by the ideal argument.
  - So Ftri C H H = Ftri H H C = ⟨C, H # H⟩ = ‖H‖² > ½‖H‖².
  - This is the record's proof at E = 0.
- **Not vacuous: the instance so(3) ⊕ so(3) ⊂ so(6).** Take h₁ on coordinates {1, 2, 3} and h₂ on {4, 5, 6}, with D_i = Π_i the orthogonal projections, i.e. coordinate-diagonal with weight 1 on pairs inside the block.
  - Each Π_i # Π_i is so(3)'s intrinsic I # I = (3 − 2) I = Π_i. The product is built from the bracket and the restricted trace form, and Π_i # Π_i lands in [h_i, h_i] = h_i.
  - Π₁ # Π₂ = 0 since [h₁, h₂] = 0, so C = Π₁ + Π₂ is idempotent.
  - C is self-adjoint and PSD. Both D_i are self-adjoint and nonzero, D₁D₂ = D₂D₁ = 0, and brS(D₁X, D₂Y) ∈ [h₁, h₂] = 0. Every typed hypothesis holds.
  - Screen (seconds, the repository's [curvature_operator.py](../scripts/lib/curvature_operator.py) product, not evidence): idempotency error 0.0, and H = D₁ − D₂ gives ⟨C#H, H⟩ = 6.0 = ‖H‖² and ⟨H, C⟩ = 0.
- **Cosmetic.** hC follows from hsplit, hD₁ and hD₂. The second conjunct of hrange is the adjoint of the first. Neither redundancy affects truth or strength.

## Corrections

None required.
