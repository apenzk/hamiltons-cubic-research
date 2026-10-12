# r1041: the `k = 4` collapse on the face, and the open statement it is supposed to close

**Scope.** The seven claims of the [I106b](../plan.md) face note, all of them against [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) and the [lean/INDEX.md](../lean/INDEX.md) row that records them. Every verdict below comes from re-deriving the object from its definition, from exact rational arithmetic, or from the Lean kernel.

**The headline is a refutation, and it is machine-checked.** [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean), the item's typed open content, is FALSE as typed. An exact rational witness at `k = 4` satisfies every hypothesis it carries and fails its conclusion, with `ν` pairwise distinct and `A` of rank exactly two.

| # | claim | verdict |
|---|---|---|
| 1 | criticality at `(l,m)` is `(ν_m − ν_l)·⟨h_lm, β(ν_l+ν_m)u + c⟩ = 0`, and `⟨h_lm, 1⟩ = 0` is free | **CONFIRMED**, re-derived from `A_{ik} = u_i βν_k² + c_i ν_k` without reading the proof |
| 2 | `h_lm` vanishes at coordinates `l` and `m` at every zero-diagonal `Q` | **CONFIRMED**, structural |
| 3 | `h_lm` lies in a `(k−2)`-dimensional coordinate subspace, and criticality removes two more dimensions | **CONFIRMED in the arithmetic, REFUTED in the attribution.** Criticality removes ONE. The second comes from orthogonality, which claim 1 itself calls free, and the two have different failure modes |
| 4 | at `k = 4` this forces `h_lm = 0` for every pair, under the hypothesis that the complementary indices carry distinct weights | **REFUTED AS STATED, CONFIRMED under the complete hypothesis.** The stated genericity omits `ν_l ≠ ν_m` and understates the weight condition as one where six are needed |
| 5 | `Σ_{l<m} ‖h_lm‖² = (k − ‖Q‖₄⁴)/2` for `Q` with unit rows | **CONFIRMED.** The `1/2` and the `l < m` bookkeeping are right |
| 6 | every `h_lm` vanishes iff `‖Q‖₄⁴ = k`, so the open statement is equivalent to maximising the entrywise ℓ₄ norm | **CONFIRMED, and stronger than claimed.** Nothing is imported from Jin. Jin's Theorem 1(i) is itself a two-line corollary of the identity in this file |
| 7 | the pair-sum map is injective, so the `C(k,2)` sums span only a `k`-dimensional space | **CONFIRMED** for `k ≥ 3`, with the "so" running backwards |

## 1. The witness, and what it refutes

Take `β = 1`, `ν = (0,1,2,3)`, `u = (1,0,1,2)`, `c = (0,5,3,7)` and

```
Q = ⎡ 0    0    3/5  −4/5 ⎤
    ⎢ 0    0    4/5   3/5 ⎥
    ⎢ 1    0    0     0   ⎥
    ⎣ 0    1    0     0   ⎦
```

`Q Qᵀ = 1` exactly, the diagonal is zero, and `Q` is not a signed permutation. The antisymmetric part of `Qᵀ(A ∘ Q)` is the zero matrix, entry by entry, in exact rational arithmetic. So `Q` is a genuine zero-diagonal critical point of `f(Q) = ⟨A, Q ∘ Q⟩` on `O(4)`, by the file's own [first_order_antisymm](../lean/HamiltonsCubic/Results/I106bFace.lean), and it is not a signed permutation.

**Why it works is exactly the claim-4 mechanism running backwards.** The columns pair off: `h_lm = 0` for all five pairs other than `(2,3)`, because columns `0,1` are supported on rows `2,3` and columns `2,3` on rows `0,1`. The one surviving product is `h_23 = (−12/25, 12/25, 0, 0)`, whose complementary indices are `0` and `1`. Orthogonality gives `h_0 + h_1 = 0`, criticality gives `w_0 h_0 + w_1 h_1 = 0` with `w = β(ν_2+ν_3)u + c = (5,5,8,17)`, and `w_0 = w_1`, so the two-by-two system drops rank and the kernel is the line `h_1 = −h_0` that `h_23` sits on. **One failing pair out of six is enough.** The other five carry `w_a − w_b ∈ {−5,−6,−1,−10,−3}`, all nonzero, and `ν` is pairwise distinct throughout.

This is not a numerical near-miss. It is machine-checked: the scratch file derives `False` from the sorry'd statement applied to the witness, and every hypothesis discharge in it is a real proof.

```
'R1041.open_statement_is_false' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]
```

The only `sorryAx` in that chain is the one inside [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean) itself, which is the point: the statement is refuted, not merely unproved.

**A `ν`-degenerate variant of the same `Q` refutes it a second way.** Put `ν_2 = ν_3` and leave `β, u, c` arbitrary. The pair `(2,3)` then carries the factor `ν_3 − ν_2 = 0`, so criticality is satisfied identically in `Q` and every choice of weights, and the same non-signed-permutation `Q` is critical for EVERY rank-two `A` built on that `ν`.

## 2. What the refutation costs the record, and what it does not

**It does not touch [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean).** The witness is critical, and it is nowhere near maximal: `value A (Q ∘ Q) = 28`, while the assignment `σ = id` on the same `A` already gives `54`. The item's goal survives untouched. What is refuted is the ROUTE, `zero_diag_critical_is_isSignedPerm`, which [r1034](REVIEW_r1034.md) opened on the ground that first-order information alone would suffice.

**So the route's real content is now known: first-order information alone does NOT suffice.** The critical set on the face contains non-signed-permutations on a nonempty parameter locus, and maximality or genericity has to be reinstated to exclude them. Two repairs are available, and I recommend the first.

1. **Add the genericity to the statement**, as `∀ l m, l ≠ m → ν l ≠ ν m` together with a per-pair condition `w^{(l,m)}_a ≠ w^{(l,m)}_b` on the two complementary indices. At `k = 4` the collapse then goes through as the note describes, and the theorem becomes true and provable in the layer as it stands. The cost is that R28 must then supply the genericity for its own `(β, ν, u, c)`, which is a real obligation rather than a formality, since `w_a = w_b` reads `c_a − c_b = −β(ν_l+ν_m)(u_a − u_b)` and is reachable at physical data.
2. Keep the statement parameter-free and reinstate `hmax`, which returns the item to a second-order argument of the kind [Jin 2026](../references/jin-2026-l4-norm-orthogonal-group/notes.md) needs for the quartic objective.

**The [lean/INDEX.md](../lean/INDEX.md) row needs three corrections.** "THE OPEN STATEMENT IS A THEOREM AT `k = 4`" is false at the parameters above. "criticality removes two more dimensions there" attributes to criticality a condition the same row credits to orthogonality four sentences earlier. "Its cost is one stated hypothesis" undercounts: it is six weight conditions and the pairwise distinctness of `ν`.

## 3. The dimension count, redone

The brief asked whether criticality removes two dimensions or one. **It removes one, and the total of two is still right**, so the `k = 4` arithmetic is not where the note fails.

| condition on `h_lm` | source | count |
|---|---|---|
| `h_lm(l) = h_lm(m) = 0` | zero diagonal, structural | ambient drops from `k` to `k − 2` |
| `⟨h_lm, 1⟩ = 0` | orthogonality of columns `l` and `m` | one |
| `⟨h_lm, β(ν_l+ν_m)u + c⟩ = 0` | criticality, and ONLY when `ν_l ≠ ν_m` | one |

Two conditions on `k − 2` coordinates leave `k − 4`, so `k = 4` leaves dimension zero. **The count is sound but conditional in two places the note treats as automatic.** The criticality row is empty when `ν_l = ν_m`, and "leaves dimension zero" needs the two functionals to be independent after restriction, which is `(1,1)` and `(w_a, w_b)` being independent, which is `w_a ≠ w_b`. Both failures are realised by the single witness of section 1.

**The count is also an implication and not merely a count, which is worth saying plainly.** `h_lm` is not a free vector in that subspace, it is determined by `Q`, so the dimension language is doing nothing the two linear equations do not already do. Where the two equations have full rank they force `h_lm = 0` outright, and [hadamard_collapse_of_two_conditions](../lean/HamiltonsCubic/Results/I106bFace.lean) is exactly that step with nothing hidden in it. It assumes no more than it says: two scalars, two equations, `w_a ≠ w_b`. The gap between it and the `k = 4` claim is that nothing in the file supplies its hypotheses from `Q`, `A` and criticality, so the assembly is prose.

**And the closing step is sound.** All six `h_lm = 0` means the columns have pairwise disjoint support, so the `k` supports are nonempty, disjoint and inside `k` coordinates, hence singletons, hence each column is `±e_j` with distinct `j`. That is a signed permutation, and it needs nothing beyond unit columns.

## 4. Claims 5 and 6, and the Jin citation

**Claim 5 is right, including the bookkeeping the brief asked about.** `‖h_lm‖² = Σ_i Q_il² Q_im²`, so

`Σ_{l<m} ‖h_lm‖² = ½ Σ_i Σ_{l≠m} Q_il² Q_im² = ½ Σ_i [(Σ_l Q_il²)² − Σ_l Q_il⁴] = ½ (k − ‖Q‖₄⁴)`,

where the middle step is [row_offdiag_eq_sq_sub_quartic](../lean/HamiltonsCubic/Results/I106bFace.lean) applied at `q = ` row `i`, and the unit-row hypothesis enters only at the last step. The Lean lemma sums over ORDERED pairs `l ≠ m` and carries no `1/2` and no unit hypothesis, which is correct for what it states. It is a general vector identity and the docstring's halving to `l < m` is right. Screened to `5e-16` at `k = 3,4,5,6` on random orthogonal matrices, and the algebra is a one-liner independent of the screen.

**Claim 6's "iff" holds, and the worry that it imports Jin is unfounded in a way worth recording.** The identity gives `all h_lm = 0 ⟺ ‖Q‖₄⁴ = k` for unit rows, and the missing direction, `‖Q‖₄⁴ = k ⟹ Q` a signed permutation, is the disjoint-support argument of section 3 rather than anything of Jin's. **So Jin's Theorem 1(i) in its entirety, the bound `‖Q‖₄⁴ ≤ k` and the equality case together, is a corollary of `row_offdiag_eq_sq_sub_quartic` plus orthonormality**: the bound is nonnegativity of the left side and the equality case is disjoint support. Jin's content is (ii) and (iii), the local-maximum classification, which the file does not use. The record can say this and drop the citation from (i).

One transport warning. The equivalence of claim 6 is faithful, so it carries the falsity of section 1 with it: the ℓ₄ form of the open statement, "zero-diagonal criticality forces `Q` to maximise `‖·‖₄⁴`", is false at the same witness, which has `‖Q‖₄⁴ = 2 + 2(3/5)⁴ + 2(4/5)⁴ = 1924/625 = 3.0784 < 4`.

## 5. Claims 1, 2 and 7, and vacuity

**Claim 1.** `(Qᵀ(A ∘ Q))_{lm} = Σ_i Q_il A_{im} Q_im = β ν_m² ⟨h_lm, u⟩ + ν_m ⟨h_lm, c⟩`, both brackets symmetric in `l, m`, so the antisymmetric part is `β(ν_m²−ν_l²)⟨h_lm,u⟩ + (ν_m−ν_l)⟨h_lm,c⟩ = (ν_m−ν_l)⟨h_lm, β(ν_l+ν_m)u + c⟩`. That is [asym_factor_columns](../lean/HamiltonsCubic/Results/I106bFace.lean) exactly. `⟨h_lm, 1⟩ = (QᵀQ)_{lm} = 0` for `l ≠ m`.

*One friction, not a defect.* [hadamard_inner_one](../lean/HamiltonsCubic/Results/I106bFace.lean) hypothesises `Qᵀ * Q = 1` while [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean) and [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) hypothesise `Q * Qᵀ = 1`. Composing them needs `Matrix.mul_eq_one_comm`, which appears nowhere in the file. A repair that assembles the `k = 4` argument will have to supply it.

**Claim 2** is one substitution and holds at `l = m` as well.

**Claim 7** is true for `k ≥ 3` and its proof is three sums and a `linarith`, as advertised. The "so" is the wrong way round: the image of a map defined on `ℝ^k` is at most `k`-dimensional for free, and what injectivity buys is that it is exactly `k`, so the sums are pinned rather than merely bounded. At `k = 2` the hypothesis of three distinct indices is unsatisfiable and the map is genuinely non-injective, which the statement handles correctly by making the caller supply the indices.

**Vacuity: the `k = 4` hypotheses are satisfiable, so claim 4 is not empty.** The fixed-point-free signed permutations are zero-diagonal, orthogonal and critical for every `A`, since their distinct columns have disjoint support, which [r1035](REVIEW_r1035.md) already recorded at every `k ≥ 2`. And the conclusion has content, because zero-diagonal orthogonal matrices that are not signed permutations exist at `k = 4`, the witness of section 1 among them. So the repaired claim 4 says something: under the full genericity, the critical set on the face is exactly the derangement signed permutations.

## 6. Axioms

`#print axioms` over all twenty-three declarations of the file. Two carry `sorryAx`, both named in the file as open: [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) and [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean). The other twenty-one depend on `propext`, `Classical.choice` and `Quot.sound` alone, [hadamard_collapse_of_two_conditions](../lean/HamiltonsCubic/Results/I106bFace.lean), [row_offdiag_eq_sq_sub_quartic](../lean/HamiltonsCubic/Results/I106bFace.lean), [pairSum_determines](../lean/HamiltonsCubic/Results/I106bFace.lean) and [hadamard_vanishes_at_own_indices](../lean/HamiltonsCubic/Results/I106bFace.lean) among them. No unexpected axiom, and no declaration outside the two depends on either sorry.

## 7. How the analysis-only rule was honoured

**No sweep, no census, no optimisation, no falsifier hunt.** The counterexample was CONSTRUCTED by reading the claim-4 argument backwards and asking which of its hypotheses could fail while the rest of the structure held, which is analysis. Three runs of seconds each followed, all on objects already in hand and all reported as screens rather than as evidence.

- A floating-point evaluation of the constructed `Q` at random `(β, ν, u, c)` in the two degenerate regimes and one control, to catch an arithmetic slip before the exact version.
- An exact rational evaluation in `fractions.Fraction`, which is the real check on the witness and carries no floating-point caveat.
- A floating-point check of the claim-5 identity on random orthogonal matrices at `k = 3,4,5,6`, as a guard on a derivation done by hand.

The refutation itself rests on the Lean kernel and on exact rational arithmetic, not on any of the three. Two Lean invocations ran, both single-file `lake env lean` on scratch files at the `lean/` top level, both in the background, never concurrently, and no `lake build`.

**Scratch files**, left in place for a successor to re-run or to promote: `lean/_r1041_counterexample.lean` carries the machine-checked refutation and `lean/_r1041_axioms.lean` the axiom probe.
