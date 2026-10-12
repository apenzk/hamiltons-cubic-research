# Review r1025: the Pcubic2Quad estimate, its constant, and what it closes

Reviewer: r1025, one of two on an identical brief. Under review: `a381f677`, `6a48e152`, `4c96c158`.

Log: [agent_logs/r1025.log](../agent_logs/r1025.log)

Every value below is exact rational arithmetic. Every kernel check ran through `lake env lean` from [lean/](../lean/) on the project toolchain after a clean `lake build` at exit 0. Two scratch files were used and are not committed.

| # | Item | Verdict |
|---|------|---------|
| 1 | Does `abs_Pcubic2Quad_le` close what r1016 named? | **REFUTED**, on two counts |
| 2 | Is the bound non-vacuous and the constant finite and meaningful? | **CONFIRMED**, witness exhibited |
| 3 | The factor chain of `abs_phiTri_le` | **CONFIRMED**, and loose by a factor 12 at the witness |
| 4 | `abs_innerOp2_le`'s constant and the form of `normSq2 id` | **CONFIRMED**, and the constant is SHARP |
| 5 | `inner2_self_eq_frobenius`, including the half | **CONFIRMED** |
| 6 | `norm_br_le`'s 2 and the norm `norm_brS_le` is stated at | **CONFIRMED**, with the sharp constant named |
| 7 | Overreach sweep | **six sentences**, two of them stale within their own file |

## 1. The ordinal is wrong and the piece is not closed. REFUTED

**What [r1016](REVIEW_r1016.md) actually named**, in its section 9, in this order:

1. **the functional is not bundled**, `f'` must be a `StrongDual ℝ (CurvOp2 ι)` and boundedness of `S ↦ innerOp2 S (Qop2 R)` was not on file,
2. **Fréchet differentiability itself**, `Pcubic2 (R + H) - Pcubic2 R - f' H = o(‖H‖)` uniformly in `H`, for which r1016 named the missing general-increment expansion,
3. **the positive tangent cone is uncomputed**, no member of `posTangentConeAt {normSq2 = 1} R` is exhibited anywhere.

**Count A: the record swaps r1016's first two pieces, and does so consistently, so a reader who follows the pointer finds the wrong item.** [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) opens with *"this file closes the second"* while it closes what r1016 lists first, the `StrongDual` bundling, and its *what this does not do* paragraph calls the `Pcubic2Quad` estimate *"[r1016](REVIEW_r1016.md)'s first piece"*. [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean#L9) then inherits that numbering, and so do the commit subject of `4c96c158` and [lean/INDEX.md](../lean/INDEX.md#L138). The cheapest fix is to stop numbering and name the piece: *"closes the Fréchet-remainder piece, r1016 having named it second"*.

**Count B, which is the finding: even read as the remainder piece, it is not closed.** `HasFDerivAt Pcubic2 (PcubicDiff R) R` at a self-adjoint `R` needs `Pcubic2 (R + H) - Pcubic2 R - PcubicDiff R H = o(‖H‖)`, and by [Pcubic2_expand](../lean/HamiltonsCubic/Results/PhiTri.lean) together with [PcubicDiff_eq_lin](../lean/HamiltonsCubic/Results/PcubicDiff.lean#L70) that remainder is `Pcubic2Quad R H + Pcubic2 H`. Three things stand between the commit and the statement:

- **no `HasFDerivAt` declaration exists in the tree.** `grep -rn "HasFDerivAt" HamiltonsCubic/` returns five hits, all of them prose, four in [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) and one in [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean#L17), and no theorem statement.
- **the cubic summand carries no named bound.** The brief's *"bounded NOWHERE in this commit"* is one step too strong and the conclusion survives it: [Pcubic2_eq_cubicTri](../lean/HamiltonsCubic/Results/CubicTri.lean#L83) plus [abs_cubicTri_le](../lean/HamiltonsCubic/Results/CubicTri.lean#L350) give `|Pcubic2 H| ≤ cubicConst ι * ‖H‖³` in one rewrite, so the fact is reachable. It is not stated, and the two declarations that would compose sit 267 lines apart with nothing joining them.
- **the little-o step is absent.** Going from two explicit polynomial bounds to `isLittleO` is Mathlib bookkeeping and it is bookkeeping nobody has done here.

**The accurate sentence.** *"`abs_Pcubic2Quad_le` supplies the quadratic half of the estimate r1016's second piece needs, with an explicit constant. The cubic half follows from `abs_cubicTri_le` in one rewrite and is not stated, and `HasFDerivAt` itself is stated nowhere, so the piece is one short assembly from closed rather than closed."*

## 2. Non-vacuous, both constants positive, and a witness with both sides nonzero. CONFIRMED

**The witness is `R = H = id` on `skewSub (Fin 3)`.** Three facts checked in the kernel:

| Fact | How |
|---|---|
| `‖ContinuousLinearMap.id ℝ (skewSub (Fin 3))‖ = 1` | `ContinuousLinearMap.norm_id`, after exhibiting `Nontrivial (skewSub (Fin 3))` from `phi 0 1 ≠ 0` |
| `normSq2 id = 3` at `Fin 3` | `Fin.sum_univ_three` on the `rfl` form, then `norm_num` |
| `0 < Pcubic2Quad id id` | `Pcubic2Quad_eq_cubicTri`, then `phiTri id id id ≤ 0` from `inner2_self_nonneg` at each of the 81 terms |

**The exact values**, computed in exact rationals from the definitions rather than from the Lean proofs:

| | `Fin 3` | `Fin 4` |
|---|---|---|
| `phiWeight` | 12 | 24 |
| `normSq2 id` | 3 | 6 |
| `cubicConst` | 39 | 150 |
| `phiTri id id id` | -6 | -24 |
| `cubicTri id id id` | 6 | 18 |
| LHS, `Pcubic2Quad id id` | **18** | **54** |
| RHS, `3 c ‖R‖ ‖H‖²` | **117** | **450** |
| ratio | 2/13 | 3/25 |

So both sides are nonzero, the inequality is strict with about a factor 6.5 of slack at `Fin 3`, and the constant is a finite positive rational at every finite index set. **`normSq2 id` also matches [r1021](REVIEW_r1021.md)'s independent 3 at `Fin 3`, and the general closed form is `n(n-1)/2`**, which [r1022](REVIEW_r1022.md)'s index row already records.

## 3. The factor chain re-derived from the definitions matches exactly, and the bound is loose. CONFIRMED

**Re-derivation, independent of the Lean proof.** One term of `phiTri A B C` is `inner2 U V` with `U = B(brS (A φ_ij) (C φ_kl))` and `V = brS φ_ij φ_kl`. Write `p = ‖φ_ij‖` and `q = ‖φ_kl‖`.

| Step | Factor |
|---|---|
| `‖V‖ ≤ 2 p q` | the first bracket's 2 |
| `‖brS (A φ_ij) (C φ_kl)‖ ≤ 2 ‖A‖ p ‖C‖ q` | the second bracket's 2 |
| `‖U‖ ≤ ‖B‖ · 2 ‖A‖ ‖C‖ p q` | `le_opNorm` at `B`, no factor |
| `abs_inner2_le_norm` | a 1/2 |
| per term | `(2‖A‖‖B‖‖C‖ p q)(2 p q)/2 = 2 ‖A‖‖B‖‖C‖ p² q²` |
| four-fold sum | `2 ‖A‖‖B‖‖C‖ · phiWeight²` |
| `phiTri`'s own `-(1/4)` | `(1/2) phiWeight² ‖A‖‖B‖‖C‖` |

**That is `abs_phiTri_le`'s constant to the digit**, and [phiTri_term_le](../lean/HamiltonsCubic/Results/CubicTri.lean#L262) states exactly the per-term line above. The `2 · 2 / 2 · (1/4) = 1/2` composition the brief names is right, and `cubicTri`'s further `-(1/2)` turns it into the `(1/4) phiWeight²` sitting in [cubicConst](../lean/HamiltonsCubic/Results/CubicTri.lean#L346). **No factor is wrong.**

**It is loose, and the file says so, which is the right thing to have said.** At `A = B = C = id` on `Fin 3` the bound reads `|phiTri| ≤ 72` against a true value of 6, a factor of 12. Two sources, both identifiable: the bracket 2 used twice where the sharp Frobenius constant is `√2` (item 6), which accounts for a factor 2, and the triangle inequality over the four-fold sum, where `[φ_ij, φ_kl]` vanishes whenever the two index pairs are disjoint or equal, which accounts for the rest. Neither costs anything downstream, since `O(‖H‖²)` is `o(‖H‖)` at any constant.

## 4. The constant is exactly right, its `rfl` form holds, and it is SHARP. CONFIRMED

**The `rfl` inside [abs_innerOp2_le](../lean/HamiltonsCubic/Results/CubicTri.lean#L229) is honest.** Checked directly:

```lean
example : normSq2 (ContinuousLinearMap.id ℝ (skewSub (Fin 3)))
    = (1/2) * ∑ i : Fin 3, ∑ j : Fin 3, inner2 (phi i j) (phi i j) := rfl
```

**Values: 3 at `Fin 3`, 6 at `Fin 4`**, both by evaluating `∑∑ inner2 (phi i j) (phi i j)` (6 and 12) in the kernel. The `Fin 3` value reproduces [r1021](REVIEW_r1021.md).

**`normSq2 id` is the natural form, and it is not independent of `phiWeight`.** Proved here at a general index type, in seven lines from `inner2_self_eq_frobenius`:

```lean
example : phiWeight ι = 4 * normSq2 (ContinuousLinearMap.id ℝ (skewSub ι))
```

*So [cubicConst](../lean/HamiltonsCubic/Results/CubicTri.lean#L346) is `w/4 + w²/4` in the single variable `w = phiWeight ι`, and its docstring's "both summands contribute, `normSq2 id` from the pairing and the `φ`-family weight from `Φ`" reads as two independent contributions where there is one.* This is a presentation point rather than an error, and the identity is worth having on file: it is what makes the constant computable from `phiWeight` alone.

**And the constant is best possible.** At `A = B = ContinuousLinearMap.id`, `|innerOp2 id id| = normSq2 id = 3` and the right-hand side is `‖id‖ · ‖id‖ · normSq2 id = 3`, using `‖id‖ = 1` from item 2. **Equality.** So `abs_innerOp2_le` is sharp, which is stronger than what the file claims for it and is the reason the looseness of the whole estimate sits entirely in the `Φ` half.

## 5. The half is right. CONFIRMED

`inner2 X X = ‖X‖²/2` checked at `X = !![1,2;3,4]` over `Fin 2`, both sides evaluated independently in the kernel to **15**: the pairing as `(1/2)(1 + 4 + 9 + 16)` through `inner2_eq_sum`, and the Frobenius side as `30/2`. The direction of the half is the one the downstream bounds need, `inner2` being the smaller of the two, and it is what makes [abs_inner2_le_norm](../lean/HamiltonsCubic/Results/CubicTri.lean#L253)'s `‖U‖‖V‖/2` come out with a half rather than a two.

## 6. The subtype norm claim holds by `rfl`, and the 2 is loose by exactly `√2`. CONFIRMED

**The `rfl` claim.** `example (X : skewSub (Fin 3)) : ‖X‖ = ‖(X : Matrix (Fin 3) (Fin 3) ℝ)‖ := rfl` elaborates with `Matrix.Norms.Frobenius` open, so [norm_brS_le](../lean/HamiltonsCubic/Results/CubicTri.lean#L170) is at the ambient Frobenius norm and its one-line proof by `norm_br_le` at the coercions is correct. The same `rfl` is used four times inside [phiTri_term_le](../lean/HamiltonsCubic/Results/CubicTri.lean#L262) and is sound there too.

**The docstring's hedge is accurate and the truth is better than the hedge.** *"The `2` is the commutator's two terms and is not improvable by this argument"* is a claim about the triangle inequality plus `Matrix.frobenius_norm_mul`, and that pair does cap at 2, since `‖XY‖ = ‖X‖‖Y‖` is attainable. **The sharp Frobenius constant is `√2`, not 2**, by the Böttcher–Wenzel inequality `‖XY - YX‖_F ≤ √2 ‖X‖_F ‖Y‖_F`. The ratio `√2` is attained at `X = e₀₁`, `Y = e₁₀` over `Fin 2`, where `br X Y = diag(1, -1)`, so `‖br X Y‖ = √2` and `‖X‖ = ‖Y‖ = 1`: verified by hand in exact arithmetic here, not taken from the literature. **So `norm_br_le` is off the truth by a factor `√2` and the file has drawn the line in the right place**, claiming only what its own argument gives. Improving it would need a different proof and would buy a factor 2 in `abs_phiTri_le`, which nothing downstream needs.

## 7. Overreach sweep: six sentences, two of them contradicted inside their own file

**The two that matter, both in [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean)'s module docstring, both stale as of `4c96c158`.**

1. **Lines 24 to 27**: *"WHAT IS PROVED HERE AND WHAT IS NOT. The identification of all four pieces with `cubicTri`, and the form's full trilinearity, are proved. **The bound itself is not**, and the route to it is now NAMED rather than assumed."* `abs_cubicTri_le` and `abs_Pcubic2Quad_le` are proved 320 lines below in the same file. *Accurate: "the bound itself is proved below, from the three pieces this section names."*
2. **Lines 74 to 77**: *"WHAT REMAINS BETWEEN HERE AND `HasFDerivAt` is assembling them on `cubicTri` ... **and it is the state this file did NOT reach**."* The file reached it. *Accurate: "the assembly is below, and what remains beyond it is the cubic summand and the little-o step."*

**The third is the one that reaches past the declarations.** The section docstring at lines 337 to 341: *"and it is now proved: the quadratic part of the increment is `O(‖H‖²)` with an EXPLICIT constant, **so the remainder of `P` at a general increment is `o(‖H‖)`**, which is what `HasFDerivAt` consumes."* The remainder is `Pcubic2Quad R H + Pcubic2 H` and only the first summand is bounded by any declaration. *Accurate: "so the quadratic part of the remainder is `o(‖H‖)`, and the cubic part follows from `abs_cubicTri_le` and is not yet stated."*

**The fourth, the ordinal, in four places.** [CubicTri.lean:9](../lean/HamiltonsCubic/Results/CubicTri.lean#L9), the section docstring at line 338, the subject line of `4c96c158`, and [lean/INDEX.md](../lean/INDEX.md#L138)'s I36 row all call this *"the FIRST of r1016's three pieces"*, where r1016's first is the `StrongDual` bundling. Item 1 has the correction. [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean)'s *"this file closes the second"* is the same swap seen from the other side.

**The fifth, the module header at lines 21 to 23**: *"a trilinear form on a finite-dimensional space is bounded, so `|Pcubic2Quad R H| ≤ 3‖C‖‖R‖‖H‖²` and `|Pcubic2 H| ≤ ‖C‖‖H‖³`"*. The second inequality is on file nowhere, and `‖C‖` names a norm of the trilinear form that no declaration defines. What is proved uses `cubicConst`, which is explicitly not claimed sharp, so the two are different objects wearing one symbol.

**The sixth, [lean/INDEX.md](../lean/INDEX.md#L138)'s I36 row**: *"AND THE ESTIMATE ITSELF IS NOW PROVED"* followed by *"THIS CLOSES THE FIRST OF r1016's THREE PIECES"*. The first clause is true of `Pcubic2Quad` and the second is not true of any piece, for the reasons in item 1. The row's own closing qualifier, *"WHAT IS NOT HERE IS THE `HasFDerivAt` STATEMENT ITSELF"*, is accurate and sits in the same row as the claim it undercuts, which is the recurring shape: the headline states the closure and the qualifier twenty words later withdraws it.

**What the sweep clears.** [ATTEMPTS.md](../ATTEMPTS.md)'s 2026-09-19 entry, [.claude/skill-proposals.md](../.claude/skill-proposals.md)'s entry 151, [reviews/INDEX.md](INDEX.md)'s r1022 and r1023 rows, and both edits to [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) all state what is discharged and what is still owed, and the FoxProduct edits in particular name the remaining half, `L_e` linear through bilinearity of the composition, in both places where the debt was recorded. [lidem_isSelfAdjoint](../lean/HamiltonsCubic/Results/FoxBridge.lean#L252) is at a general index type under three `IsWeyl` hypotheses, which is what those edits say it is. **No sentence in any of those five files claims more than the declarations beside it establish.**

## Overall

**The mathematics is right and the record's account of what it closes is not.** Every constant in the chain from `inner2_sq_le` up to `abs_Pcubic2Quad_le` matches an independent re-derivation, `abs_innerOp2_le`'s constant is sharp, the estimate is non-vacuous at an exhibited witness, and the whole tower is loose by a bounded and identifiable factor that costs nothing at `O(‖H‖²)`. What fails is the closure claim: r1016's piece is the Fréchet remainder, the cubic half of that remainder is one rewrite from a bound and is not stated, and `HasFDerivAt` appears in the tree only in prose.
