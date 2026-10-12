# Review r1174: L244 row (A) in the record's variables, section hA of L244RowA.lean

*Gate 2, one reviewer. Log: [agent_logs/r1174.log](../agent_logs/r1174.log). Scope: comparison of Lean declarations in [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean) against [second-order.md](../findings/second-order.md) L244 (Setting, line 305) and [the I73c note](2026-09-25-I73c-per-vector-rows.md). Screens only, by typechecking a scratch file (/tmp/r1174_check.lean) against the built olean.*

| # | Claim | Lean | Verdict |
|---|---|---|---|
| 1 | bAB is the record's b_ab(x) | bAB | CONFIRMED (at an orthonormal eigenbasis with cls the eigenspace label) |
| 2 | R(x) = sum over a, b of b_ab | rowMass_eq_sum_bAB | CONFIRMED |
| 3 | b_ab = b_ba | bAB_symm | CONFIRMED |
| 4 | row (A) at unit skew x, feeding hA | hA_of_basis | CONFIRMED |

## Claim 1: bAB

- The record (second-order.md line 305) sets b_ab(x) = ⟨B_ab x, x⟩ = ½ Σ_{γ∈E_a, δ∈E_b} ⟨[ψ_γ, ψ_δ], x⟩². bAB is exactly this sum with the same ½, γ over cls⁻¹(a) in the first bracket slot and δ over cls⁻¹(b) in the second.
- Inner product: inner2 X Y = ½ tr(Xᵀ Y) (L82Statement.lean line 182, the RealLayer one opened here). The record's convention note (second-order.md line 583) fixes ½ tr(Xᵀ Y) at the Λ² level, making φ_ij orthonormal. Same convention, and the value n − 2 in row (A) agrees with it (the Lean proof reaches n − 2 through casimir_skew_lt).
- br X Y = XY − YX, the matrix commutator, as in the record.
- The definition itself is a formula in (ψ, cls, x) and carries no tie to W's eigenspaces. It equals the record's ⟨P_a # P_b x, x⟩ when ψ is an orthonormal basis adapted to the eigenspaces and cls labels them. That identification is the instantiation's job and is outside this file, which is how the docstring presents it.

## Claim 2: rowMass_eq_sum_bAB

- rowMass ψ ψ x = ½ Σ_γ Σ_δ ⟨[ψ_γ, ψ_δ], x⟩² split fibrewise by cls on both indices. Holds for any ψ and cls, with no hypotheses needed. The statement is the record's R(x) = Σ_{a,b} b_ab(x) summed over the ordered pairs (a, b).

## Claim 3: bAB_symm

- [ψ_δ, ψ_γ] = −[ψ_γ, ψ_δ] and the square removes the sign. Matches the record's use of b_20 = b_02 ("ad-invariance"), which at this level is just antisymmetry of the bracket.

## Claim 4: hA_of_basis

- Conclusion: b00 + b11 + b22 + 2(b01 + b02 + b12) = ↑n − 2, the coercion taken before the subtraction (checked with pp.coercions: `↑n - 2` in ℝ, so no truncated ℕ subtraction). This is Σ_{a,b} b_ab over ordered pairs after folding b10, b20, b21 into b01, b02, b12 by claim 3, i.e. the record's row (A) at unit x: ⟨(I # I) x, x⟩ = (n − 2)⟨x, x⟩ = n − 2.
- Feeds the consumer: a scratch example composing hA_of_basis into per_vector_ceiling at n := (n : ℝ), with b01 := bAB 0 1, b02 := bAB 0 2, b12 := bAB 1 2, typechecks with no rewriting. The variable roles coincide exactly.
- Axioms: `#print axioms` on hA_of_basis, rowMass_eq_sum_bAB and bAB_symm gives propext, Classical.choice, Quot.sound only.
- Vacuity screen: hypotheses are satisfiable. basisFam n is complete (scratch proof from phi_expand_ordered), and x = φ_01 at n = 3 has inner2 x x = 1 (scratch proof). At n ≤ 1 the only skew x is 0, so hunit fails there, which is the correct regime since n − 2 < 0.
- Orthonormality: the hypothesis hψ is the Parseval-frame identity Y = Σ_k ⟨ψ_k, Y⟩ ψ_k on skew Y. It implies orthonormality exactly when r equals dim so(n) = n(n−1)/2, and otherwise admits tight frames (screen: basisFam with a zero matrix appended satisfies hψ). This makes the theorem more general than the record's, with the same conclusion: for every Parseval frame and every 3-colouring cls the identity holds (the proof goes through basis independence of Σ_γ ‖[ψ_γ, x]‖², bracket_sum_indep). For a non-orthonormal frame the bAB numbers are no longer ⟨P_a # P_b x, x⟩, so rows (B), (C) and the caps would not hold for them, but that concerns their hypotheses at the consumer, not this statement. At the record's instantiation (orthonormal eigenbasis) the statement is the record's row (A) verbatim.
- cls is arbitrary: row (A) is a statement about the total, so any partition gives it, and nothing is lost by leaving cls unconstrained.

## Corrections

- None required. Optional wording: the docstring of rowMass_total_any says "in particular an orthonormal basis adapted to W's eigenspaces", which is accurate. hA_of_basis's docstring could add that hψ is satisfied by any Parseval frame, so a reader does not take "complete skew family" as asserting orthonormality.
