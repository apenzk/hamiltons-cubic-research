# Review r1024: the `Pcubic2Quad` estimate, its constant, and what it closes

Reviewer: r1024, one of two independent reviewers on this brief. Under review: `a381f677`, `6a48e152`, `4c96c158`.

Log: [agent_logs/r1024.log](../agent_logs/r1024.log). Toolchain: Lean 4.33.1 through `lake env lean` from [lean/](../lean/), `lake build` clean over 9223 jobs. Ten kernel checks were run in a scratch file and are reproduced below. One exact-rational screen was run on objects constructed for it, reported as a screen in items 2 and 3.

| # | Item | Verdict |
|---|------|---------|
| 1 | Does `abs_Pcubic2Quad_le` close what [r1016](REVIEW_r1016.md) named? | **REFUTED**, on two counts |
| 2 | Is the bound non-vacuous and the constant finite and meaningful? | **CONFIRMED**, witness exhibited |
| 3 | The factor chain behind `abs_phiTri_le`'s constant | **CONFIRMED and LOOSE**, matches an independent derivation exactly |
| 4 | Is `abs_innerOp2_le`'s constant right, and `normSq2 id` its natural form? | **CONFIRMED**, and the constant is SHARP |
| 5 | Is `inner2_self_eq_frobenius` right, including the half? | **CONFIRMED** |
| 6 | Does `norm_br_le`'s `2` survive, and is `norm_brS_le` at the right norm? | **CONFIRMED**, and the true constant is `√2` |
| 7 | Overreach sweep | **five sentences**, one of them a third stale owed-claim |

**The round's finding is item 1's, and it is a mis-citation rather than a bad theorem.** *Every declaration in these three commits is correct and I found no error in any bound.* **What is wrong is the sentence attached to them**: [r1016](REVIEW_r1016.md)'s first piece is the bundled `StrongDual`, which [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) closed, and its second is Fréchet differentiability, which this file serves. *Both files say the reverse, so the claim "closes the first of r1016's three pieces" fails an audit against r1016 even though the mathematics it rests on stands.* **And the piece it does serve is not closed either**, one of the two remainder summands being bounded by no declaration.

## 1. The two labels are swapped, and the piece served is not closed. REFUTED

**What [r1016](REVIEW_r1016.md) section 9 actually named, in its own order.** Quoted from the report:

| r1016's piece | Its words | What discharges it |
|---|---|---|
| **1** | *"The functional is not bundled. `f'` must be a `StrongDual ℝ (CurvOp2 ι)`, a continuous linear functional... Boundedness is not on file"* | [PcubicDiff](../lean/HamiltonsCubic/Results/PcubicDiff.lean), `CurvOp2 ι →L[ℝ] ℝ`, plus `abs_innerOp2_le` |
| **2** | *"Fréchet differentiability itself. `HasFDerivAt Pcubic2 f' R` needs `Pcubic2 (R + H) − Pcubic2 R − f' H = o(‖H‖)`"* | the estimate in [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean), in part |
| **3** | *"The positive tangent cone is uncomputed"* | nothing |

**The record assigns them the other way round, in three places.** [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) line 9: *"PcubicDiff.lean closed the second. This file closes the first."* [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) line 9: *"this file closes the second"*, and line 37, *"that is r1016's first piece, an estimate on `Pcubic2Quad`"*. [lean/INDEX.md](../lean/INDEX.md)'s I36 row: *"THIS CLOSES THE FIRST OF r1016's THREE PIECES... the second being PcubicDiff.lean."* **The phrase "an estimate on `Pcubic2Quad`" appears nowhere in r1016's piece 1**, which is about bundling a functional and says nothing about `Pcubic2Quad`.

**And the piece this file does serve, r1016's second, is not closed.** `HasFDerivAt Pcubic2 (PcubicDiff R) R` needs the whole remainder to be `o(‖H‖)`, and that remainder is `Pcubic2Quad R H + Pcubic2 H`. Checked in the kernel, at a self-adjoint `R`, which is where `PcubicDiff_eq_lin` applies:

```lean
example {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) (H : CurvOp2 ι) :
    Pcubic2 (R + H) - Pcubic2 R - PcubicDiff R H = Pcubic2Quad R H + Pcubic2 H := by
  rw [Pcubic2_expand, PcubicDiff_eq_lin hR]; ring
```

**Three things still stand between the commit and `HasFDerivAt`**, and only the first is cheap:

1. **`Pcubic2 H` is bounded by no declaration**, though it is two lines from what is proved. I checked that it follows at once, so this is an omission rather than a gap: `example (H : CurvOp2 ι) : |Pcubic2 H| ≤ cubicConst ι * ‖H‖ ^ 3` closes by `rw [Pcubic2_eq_cubicTri]`, `abs_cubicTri_le H H H` and `ring`. *The commit's own bullet says so, "what is NOT here is the HasFDerivAt statement, which needs the cubic remainder bounded the same way", and the [lean/INDEX.md](../lean/INDEX.md) row repeats it. The file's section header does not.*
2. **No `HasFDerivAt` statement exists in the layer at all**, and Mathlib's `o` machinery has not been invoked anywhere on this object.
3. **The identification of the linear part with the bundled functional carries a hypothesis.** `PcubicDiff_eq_lin` takes `IsSelfAdjoint2 R`, so the remainder identity above holds at self-adjoint `R` and is unproved elsewhere. *That hypothesis is harmless for Fermat, which runs at a `IsWeyl2` critical point, and it belongs in the statement of what is closed.*

**The accurate sentence.** *"This file proves the estimate on `Pcubic2Quad` that [r1016](REVIEW_r1016.md)'s SECOND piece needs, Fréchet differentiability. With [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean)'s `StrongDual`, which closed the FIRST, the second piece now owes only a bound on the cubic remainder `Pcubic2 H`, two lines from `abs_cubicTri_le`, and the `HasFDerivAt` statement itself. The third piece, the `posTangentConeAt` membership, is untouched."*

**The claim as written is therefore half-true**: a real theorem, correctly proved, attached to the wrong one of r1016's three pieces and described as closing a piece that still owes two steps.

## 2. The bound is non-vacuous, and both sides are nonzero at an exhibited pair. CONFIRMED

**The constant is a positive rational at every index type, and I evaluated it two ways.** The exact screen, over `ℚ` on matrices constructed for it:

| `ι` | `phiWeight ι` | `normSq2 id` | `cubicConst ι` |
|---|---|---|---|
| `Fin 3` | 12 | 3 | 39 |
| `Fin 4` | 24 | 6 | 150 |
| `Fin 5` | 40 | 10 | 410 |

**`normSq2 id = 3` at `Fin 3` agrees with [r1021](REVIEW_r1021.md)**, and both values are confirmed in the kernel, not only in the screen:

```lean
example : normSq2 (ContinuousLinearMap.id ℝ (skewSub (Fin 3))) = 3 := ...
example : normSq2 (ContinuousLinearMap.id ℝ (skewSub (Fin 4))) = 6 := ...
```

**The witness is `R = H = id` at `Fin 3`.** `Pcubic2Quad H H = 3 * Pcubic2 H` at every `H`, from the file's own two identities, and `Pcubic2 id > 0`, both checked in the kernel:

```lean
example {ι : Type*} [Fintype ι] [DecidableEq ι] (H : CurvOp2 ι) :
    Pcubic2Quad H H = 3 * Pcubic2 H := by
  rw [Pcubic2Quad_eq_cubicTri, Pcubic2_eq_cubicTri]; ring

example : (0:ℝ) < Pcubic2 (ContinuousLinearMap.id ℝ (skewSub (Fin 3))) := ...
```

The positivity proof is structural and needs no arithmetic on the fourfold sum: `trCube2 id = normSq2 id = 3`, and `sharpPair2 id = -(1/2) * phiTri id id id` where `phiTri id id id` is `-(1/4)` times a sum of self-pairings, hence `≤ 0`, so `sharpPair2 id ≥ 0`. **The exact screen puts the numbers at `phiTri id id id = -6`, `Pcubic2 id = 6`.** With `‖id‖ = 1`, also kernel-checked through `ContinuousLinearMap.norm_id` at a `Nontrivial (skewSub (Fin 3))` instance built from `phi 0 1`:

- **left side** `|Pcubic2Quad id id| = 18`,
- **right side** `3 * cubicConst (Fin 3) * 1 * 1 = 117`,
- **ratio** `2/13`.

**So neither side is degenerate and the bound is loose by a factor of about 6.5 at this point.** *That is the shape a Cauchy-Schwarz chain should have, and it is a long way from the vacuity a constant like `phiWeight²` might have suggested.*

## 3. The factor chain re-derived independently, and it matches exactly. CONFIRMED and LOOSE

**Re-derived from the definitions without reading the proof**, writing `P = φ_ij`, `Q = φ_kl`, `U` for the first argument of the pairing and `V` for the second:

| step | lemma | contributes |
|---|---|---|
| `\|inner2 U V\| ≤ ‖U‖‖V‖/2` | `abs_inner2_le_norm` | `1/2` |
| `‖U‖ = ‖B([A P, C Q])‖ ≤ ‖B‖ · 2‖A P‖‖C Q‖ ≤ 2‖A‖‖B‖‖C‖‖P‖‖Q‖` | `le_opNorm`, `norm_brS_le` | `2` |
| `‖V‖ = ‖[P, Q]‖ ≤ 2‖P‖‖Q‖` | `norm_brS_le` | `2` |
| per term | | `2·2/2 = 2` |
| `∑_{ijkl} ‖P‖²‖Q‖² = phiWeight²` | `hfac` | `phiWeight ι ^ 2` |
| the form's own coefficient | `phiTri` | `1/4` |
| **product** | | **`(1/4) · 2 · phiWeight² = (1/2) phiWeight²`** |

**That is `abs_phiTri_le`'s constant exactly**, and `phiTri_term_le`'s per-term constant `2 * (‖A‖ * ‖B‖ * ‖C‖) * (‖phi i j‖^2 * ‖phi k l‖^2)` is the fourth row of the table. **No factor is lost or gained anywhere in the chain.**

**One correction to the chain as the brief states it.** *`innerOp2`'s `(1/2)` does not enter `abs_phiTri_le` at all*: [phiTri](../lean/HamiltonsCubic/Results/PhiTri.lean) is built from `inner2` directly and never calls `innerOp2`. That `(1/2)` belongs to item 4's chain, where it composes with `inner2_self_eq_frobenius`'s half to give the quarter already inside `normSq2 id`.

**And `cubicTri`'s own `-(1/2)` halves it again**, `(1/2)·(1/2) = 1/4`, which is `cubicConst`'s second summand. Consistent.

**The bound is loose, and I say so with a number.** At `A = B = C = id` and `Fin 3` the bound gives `(1/2)·12² = 72` against a true value of `6`, a factor of 12. Three sources, in order of size:

- **the fourfold sum charges every index quadruple the maximum**, while `phi i i = 0` and `[φ_ij, φ_ij] = 0` make most of them contribute nothing,
- **each bracket's `2`**, see item 6, where `√2` is available and would halve the constant,
- **Cauchy-Schwarz per term**, which is equality only when the two matrices are parallel.

*Looseness costs nothing here. The estimate's only consumer wants `O(‖H‖²)`, and every one of these factors is a constant.*

## 4. `abs_innerOp2_le`'s constant is right, natural, and sharp. CONFIRMED

**The `rfl` in the proof holds.** `normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) = (1/2) * ∑ i, ∑ j, inner2 (phi i j) (phi i j)` is definitional, `applyPhi id i j` reducing to `phi i j`, and the kernel accepts it at a general `ι`. **The values are `3` at `Fin 3` and `6` at `Fin 4`**, both checked above, and `3` at `Fin 3` is [r1021](REVIEW_r1021.md)'s number.

**The general form is `normSq2 id = n(n−1)/2`**, which is [reviews/INDEX.md](INDEX.md)'s r1022 row, and the screen confirms it at `n = 3, 4, 5`: `3, 6, 10`.

**`normSq2 id` is not merely one natural form of the constant, it is the only one the file needs**, because `phiWeight` is four times it. I proved that at a general index type rather than checking it at `Fin 3`:

```lean
example {ι : Type*} [Fintype ι] [DecidableEq ι] :
    phiWeight ι = 4 * normSq2 (ContinuousLinearMap.id ℝ (skewSub ι)) := ...
```

from `inner2_self_eq_frobenius` and the same `rfl`. **So `cubicConst ι = normSq2 id + 4 (normSq2 id)²`**, and the two summands the docstring calls separate contributions are one object. *This is worth recording: the file presents `normSq2 id` and `phiWeight` as two independent quantities, and they differ by a factor of four.*

**And the constant is SHARP, which is stronger than the docstring claims.** Equality holds at `A = B = id`, checked in the kernel:

```lean
example : |innerOp2 (ContinuousLinearMap.id ℝ (skewSub (Fin 3)))
      (ContinuousLinearMap.id ℝ (skewSub (Fin 3)))|
    = ‖ContinuousLinearMap.id ℝ (skewSub (Fin 3))‖
        * ‖ContinuousLinearMap.id ℝ (skewSub (Fin 3))‖
        * normSq2 (ContinuousLinearMap.id ℝ (skewSub (Fin 3))) := ...
```

Both sides are `3`. **So `normSq2 id` cannot be lowered**, and the looseness of `cubicConst` lives entirely in the `Φ` half.

## 5. `inner2_self_eq_frobenius` is right, half included. CONFIRMED

**Two independent computations at `φ_01` over `Fin 3`, neither using the lemma's own proof.** The pairing side, by unfolding `inner2` as `(1/2)(XᵀY).trace`:

```lean
example : inner2 (phi (0 : Fin 3) 1) (phi (0 : Fin 3) 1) = 1 := ...
```

and the norm side, `‖φ_01‖² = 2`, which `φ_01 = E₁₀ − E₀₁` gives by hand from its two entries of modulus one. **`2/2 = 1`, so `inner2 X X = ‖X‖²/2` holds at this matrix**, and a factor of two anywhere in the bridge would break it.

**The statement is also the only consistent one**, since `inner2_eq_sum` carries an explicit `(1/2)` and `Matrix.frobenius_norm_def` carries none. *Nothing downstream of it is poisoned.*

## 6. The `2` is right, the norm is right, and `√2` is available. CONFIRMED

**The norm question first.** `norm_brS_le` is stated at the `skewSub` subtype norm and proved by handing `norm_br_le` the coercions, which typechecks only if the two norms are definitionally equal. Confirmed directly:

```lean
example (X : skewSub (Fin 3)) : ‖X‖ = ‖(X : Matrix (Fin 3) (Fin 3) ℝ)‖ := rfl
```

**So `‖brS X Y‖ ≤ 2(‖X‖‖Y‖)` is a statement about the Frobenius norm of the ambient matrix**, which is the norm every consumer of the estimate reads. Right norm.

**The `2` is exactly what the argument produces.** `‖XY − YX‖ ≤ ‖XY‖ + ‖YX‖ ≤ ‖X‖‖Y‖ + ‖Y‖‖X‖` by the triangle inequality and `Matrix.frobenius_norm_mul`. *The file's claim, "the `2` is the commutator's two terms and is not improvable by this argument", is a claim about the argument and is true of it.*

**The true constant is `√2`, and that is a theorem rather than a conjecture.** The Böttcher-Wenzel inequality, `‖XY − YX‖_F ≤ √2 ‖X‖_F ‖Y‖_F` over `ℝ` at every `n`, was conjectured by Böttcher and Wenzel in 2005 and proved by Vong and Jin in 2008, with shorter proofs since. **It is attained**, so `√2` is sharp where `2` is not. *Substituting it would take `phiTri_term_le`'s per-term `2` to `1`, `abs_phiTri_le`'s constant to `(1/4) phiWeight²` and `cubicConst` at `Fin 3` from `39` to `21`.*

**I recommend leaving the `2` in place.** *Mathlib carries no Böttcher-Wenzel, so the improvement costs a proof of a nontrivial inequality to buy a constant the only consumer discards.* The docstring's sentence should say which of the two claims it is making, since "not improvable by this argument" reads to a hurried reader as "not improvable".

## 7. Overreach sweep: five sentences

**Line numbers and quotations are from the committed state**, read back with `git show`. *A repair to all three of [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean), [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) and [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) appeared in the working tree while this report was being written, touching (d) and (e) at least. Nothing below was read from it, and the verdicts are against the three commits under review.*

**Two of them are the file describing its own state before the commit that changed it**, and one is the recurring shape this layer keeps hitting.

**(a) [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) lines 25 to 27 say the bound is not proved, thirty lines above its proof.** *"WHAT IS PROVED HERE AND WHAT IS NOT. The identification of all four pieces with `cubicTri`, and the form's full trilinearity, are proved. The bound itself is not, and the route to it is now NAMED rather than assumed."* **`abs_Pcubic2Quad_le` sits at line 377 of the same file.** Stale since `4c96c158`.

**(b) The same file's lines 67 to 69 say the assembly was not reached.** *"WHAT REMAINS BETWEEN HERE AND `HasFDerivAt` is assembling them on `cubicTri`, bounding each of its two summands and then the three arrangements of `Pcubic2Quad`. That is bookkeeping over proved inequalities rather than a missing fact, and it is the state this file did NOT reach."* **That is precisely what `abs_cubicTri_le` and `abs_Pcubic2Quad_le` do.** Stale since `4c96c158`. *Both (a) and (b) are safe errors, a file underclaiming, and both make the header contradict its own line 9.*

**(c) Lines 336 to 339, the section header over the estimate, claim the whole remainder.** *"the quadratic part of the increment is `O(‖H‖²)` with an EXPLICIT constant, so the remainder of `P` at a general increment is `o(‖H‖)`, which is what `HasFDerivAt` consumes."* **The remainder of `P` is `Pcubic2Quad R H + Pcubic2 H`**, and the second summand is bounded by no declaration in this commit. *The inference is available, see item 1, and the sentence states it as done. The [lean/INDEX.md](../lean/INDEX.md) row is honest about the same point in the same commit, which is what makes this a slip rather than a position.*

**(d) The three places that assign r1016's pieces the wrong numbers**, item 1: [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) line 9, [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) lines 9 and 37, and [lean/INDEX.md](../lean/INDEX.md)'s I36 row.

**(e) A THIRD stale owed-claim survives in [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), and it points the reader at the paragraph that contradicts it.** `foxTri_comm`'s docstring, at line 295, untouched by `a381f677`: *"`T` is symmetric in its first two slots. This is `∘`'s commutativity and nothing more; the third slot (the half that makes `L_e` self-adjoint), is owed, see the module docstring."* **The module docstring in the same file now says "Full symmetry of `T`, and self-adjointness of `L_e`: DISCHARGED"**, naming `foxTri_symm_right` and `lidem_isSelfAdjoint`, both of which exist in [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean) at `IsWeyl` hypotheses. *[r1023](REVIEW_r1023.md) found the debt recorded as owed in two places and `a381f677` repaired both. This is the third, twenty lines further down, and the instruction "see the module docstring" now sends the reader from a false sentence to a true one.* **Suggested repair**: *"the third slot needs the operators' Weyl conditions and is `foxTri_symm_right` in [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean)."*

**What I checked and found clean.** [ATTEMPTS.md](../ATTEMPTS.md)'s `2026-09-19` entry states only what the two reviewers established, and its arithmetic claim, `c = normSq2 id` exact with the two halves composing to the quarter, is what item 4 confirms. [.claude/skill-proposals.md](../.claude/skill-proposals.md)'s entry 151 is a process rule about failed instance searches and asserts nothing about the mathematics. [reviews/INDEX.md](INDEX.md)'s r1022 and r1023 rows match their reports, and r1022's `normSq2 id = n(n−1)/2` is correct at `n = 3, 4, 5`. The two paragraphs `a381f677` rewrote in [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) are accurate, including the surviving debt, `L_e` linear through bilinearity of `∘`, for which the file carries `foxProd_split` and no additivity lemma in either slot.

## What I did not do

**No long or open-ended run was opened.** The exact-rational screen in items 2 and 3 took seconds on matrices constructed for it and is reported as a screen. The ten kernel checks ran on declarations already on file. *No sweep, census or search was started, and none is recommended: every remaining question in this file is a statement to write rather than a number to find.*
