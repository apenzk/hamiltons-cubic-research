# REVIEW r1667: Lean fidelity of L274 (HamiltonsCubic.L274.L274_bound)

Log: [agent_logs/r1667.log](../agent_logs/r1667.log). Source: [L274.lean](../lean/HamiltonsCubic/Results/L274.lean). Record: [second-order.md](../findings/second-order.md), block "Lemma L274, J1 at Q = 0".

## Verdicts

| claim | verdict |
|---|---|
| C1 typed statement is the record multiplied by √S, same hypotheses, same K_m | CONFIRMED |
| C2 fully proved, standard axioms | CONFIRMED |
| C3 hypotheses satisfiable, equality at J − I | CONFIRMED |
| C4 helpers state their docstrings, no hidden restriction | CONFIRMED (one docstring states a hypothesis the Lean statement omits, harmlessly) |

## C1

- Trace: `(W * W * W).trace` is tr W³ by definition of the matrix product and [Matrix.trace](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html). The elaborated `#check` shows exactly this term.
- Degrees: `∑ j, W i j ^ 2` is D_i, `∑ i, ∑ j, W i j ^ 2` is S = ‖W‖², and `∑ i, (∑ j, W i j ^ 2) ^ 2` is Σ_i D_i². The record's S² − Σ D_i² is typed verbatim.
- Constant: the Lean factor is √m (m − 2)/((m − 1)√(m − 1)). All subtractions are on the real casts `(m : ℝ) - 2` and `(m : ℝ) - 1`, so no truncated natural subtraction occurs. For m ≥ 3 the base m − 1 ≥ 2 is positive, and (m − 1)√(m − 1) = (m − 1)^{3/2}. The factor equals K_m for every m ≥ 3.
- Multiplication by √S: at S > 0, √S > 0, so `tr W³ · √S ≤ K_m (S² − ΣD²)` is equivalent to the record's `tr W³ ≤ K_m (S² − ΣD²)/√S`. Nothing is lost.
- Hypotheses: `Wᵀ = W` (symmetric), `∀ i, W i i = 0` (zero diagonal), `3 ≤ m`, real entries. These are the record's hypotheses. The record's W ≠ 0 is dropped. W ≠ 0 is equivalent to S > 0 for real W, and at S = 0 the left side is tr W³ · 0 = 0 while the right side is K_m · 0 = 0 (W = 0 gives D_i = 0), so the multiplied form holds there, as the record's last clause says. The Lean proof handles this case explicitly (the `hS0` branch).
- The equality clause "with equality at W = J − I" is outside the typed statement. It is checked by hand under C3 and is recorded here as untyped.

## C2

`#print axioms HamiltonsCubic.L274.L274_bound`, from a scratch file importing the module against an olean newer than the source:

```
'HamiltonsCubic.L274.L274_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The source contains no `sorry`, no `native_decide`, and no `axiom` declaration.

## C3 (hand screen, not evidence for the inequality)

W = J − I satisfies all hypotheses. Its eigenvalues are m − 1 (once) and −1 (m − 1 times).

- m = 3: tr W³ = 8 − 2 = 6. D_i = 2, S = 6, Σ D_i² = 12, S² − ΣD² = 24. K_3 = √3/2^{3/2}. Right side K_3 · 24/√6 = 24√3/(2√2 · √6) = 24√3/(4√3) = 6. Equality.
- m = 4: tr W³ = 27 − 3 = 24. D_i = 3, S = 12, Σ D_i² = 36, S² − ΣD² = 108. K_4 = 4/3^{3/2}. Right side 108 · 4/(3√3 · 2√3) = 432/18 = 24. Equality.
- General m: tr W³ = (m − 1)³ − (m − 1) = m(m − 1)(m − 2). S = m(m − 1), S² − ΣD² = m(m − 1)³. K_m · m(m − 1)³/√(m(m − 1)) = m(m − 1)(m − 2). Equality for every m ≥ 3, so the bound is attained and the constant is sharp on this family.

## C4

- `symm_entry`: W j i = W i j from Wᵀ = W. Matches.
- `rows`: step (1), tr W³ ≤ Σ_ij |W_ij| √((D_i − W_ij²)(D_j − W_ij²)), under symmetric and zero diagonal only. Matches.
- `pairing`: step (2), Cauchy–Schwarz against √(D_i D_j) over i ≠ j. Matches; no extra hypothesis.
- `L274_simplex`: Σ p_k(1 − p_k)(n p_k − 1) ≥ 0 on a probability vector over n ≥ 2 points. The docstring's equivalent form ((n − 1)/n)² − ((n − 1)/n)(Σp² − 1/n) simplifies to (n − 1)(1 − Σp²)/n, which is `hbound`'s right side divided by n. Matches.
- `simplexF`, `hbound`: transfers to a Finset of card ≥ 2 and the rearranged form. Match their docstrings.
- `tangent`: the docstring says "for 0 ≤ t < 1"; the Lean statement assumes only 0 ≤ t and 1 ≤ n. The Lean statement is the stronger one (t < 1 is unused), so it restricts nothing. Cosmetic.
- `walk`: requires S > 0; `L274_bound` discharges this by the S = 0 case split, so it does not restrict the main theorem. Its constant m(m − 2)²/(m − 1)³ = K_m², matching the docstring.
- `L274_bound` applies `walk` to x_ij = W_ij², whose non-negativity, symmetry and zero diagonal follow from the hypotheses. No hidden hypothesis reaches the main statement, which the `#check` output confirms: its only binders are m, 3 ≤ m, W, Wᵀ = W and the zero diagonal.

## Corrections

None required. Optional: drop "< 1" from the `tangent` docstring, or note it is unused.
