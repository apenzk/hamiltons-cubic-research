# Review r1021: the third claim of discharge, the inner-product core, and the demoted blocker

Reviewer: r1021, sole reviewer. Under review: `a6cef203`, `06432edf`, `0059ff96`.

Log: [agent_logs/r1021.log](../agent_logs/r1021.log)

| # | Item | Verdict |
|---|------|---------|
| 1 | Does `foxTri_symm_right` discharge FoxProduct.lean's debt this time? | **REFUTED** |
| 2 | Is `foxTri_symm_right`'s statement the full symmetry the owed section names? | **CONFIRMED** |
| 3 | Congruence chain: hypotheses weakest that work, docstrings not over-claiming | **REFUTED** |
| 4 | Are the two self-corrections in `0059ff96` accurate? | **PLAUSIBLE** (a), **CONFIRMED** (b) |
| 5 | Is `curvOpCore` the inner product the record means? | **CONFIRMED** |
| 6 | The two side conditions of `toNormedAddCommGroupOfTopology` | **CONFIRMED** |
| 7 | Overreach sweep over the touched docstrings and index rows | **eight sentences**, listed below |

## 1. The debt is claimed discharged a third time, and a third gap of the same shape stands. REFUTED

**`foxTri_symm_right` is a correct theorem and it does not reach the consumers.** Two independent gaps, both verified in the kernel.

**Gap A, the index type.** [foxTri_symm_right](../lean/HamiltonsCubic/Results/FoxBridge.lean) is stated at `Fin n`, inherited from [extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L210), which is `Fin n`-only. The consumers are at a general `ι`: [RayleighLE](../lean/HamiltonsCubic/Base/FoxProduct.lean#L370) and [RayleighGE](../lean/HamiltonsCubic/Base/FoxProduct.lean#L376) under `variable {ι : Type*} [Fintype ι] [DecidableEq ι]`, and so are their two live users, [L98Statement.lean:224](../lean/HamiltonsCubic/Results/L98Statement.lean#L224) and [L99Statement.lean:103](../lean/HamiltonsCubic/Results/L99Statement.lean#L103). Applying the theorem there fails:

```
error: Application type mismatch: The argument hZ has type IsWeyl.{u_1} Z
but is expected to have type IsWeyl.{0} ?m.21
```

Nothing in the congruence chain forces `Fin n`: `sharpQF_congr_on_skew` through `foxTri_congr_on_skew`, `restrict`, `foxTri2` and `foxTri2_symm_right` are all at a general `ι`. The restriction enters only through `extend`.

**Gap B, `IsWeyl` at the first argument.** Both consumers evaluate `foxTri` at `idemOf W θ = θ⁻¹ • W`, and the symmetry that makes `L_e` self-adjoint is `foxTri_symm_right` with `X := idemOf W θ`. That needs `IsWeyl (idemOf W θ)`, which is closure of `IsWeyl` under scaling the OPERATOR. **No declaration in the tree states it.** [isWeyl_smul](../lean/HamiltonsCubic/Base/Bivectors2.lean#L406) is a different statement, homogeneity of `R` on `Λ²`:

```
@isWeyl_smul : ... IsWeyl R → ∀ (c : ℝ) {X : Matrix ι ι ℝ}, IsSkew X → R (c • X) = c • R X
```

The derivation of self-adjointness goes through with `IsWeyl (idemOf W θ)` assumed and with nothing else missing: in a scratch, `innerOp (Lidem W θ X) Y = innerOp X (Lidem W θ Y)` at `IsWeylOp W, X, Y` compiles with that one `sorry` and no other. I also proved `IsWeyl (c • R)` in about twenty lines, so this is a fillable gap rather than a false claim.

**The gap direction the brief asked about is favourable.** `IsWeylOp = IsLinOp ∧ IsWeyl` is strictly stronger, so a consumer holding `IsWeylOp X` supplies `hX.2` to a theorem wanting `IsWeyl X`. That half is fine, and it is not where the failure is.

**The sentence to correct**, in [lean/INDEX.md](../lean/INDEX.md)'s I36 FoxBridge row: *"AND THE DEBT IS DISCHARGED, `foxTri_symm_right` at record-Weyl BARE operators, which is what FoxProduct.lean's consumers quantify over and what its own `what is owed` section records."* The consumers quantify at a general `ι` over `IsWeylOp` and evaluate at `idemOf W θ`, and the theorem reaches neither. The accurate sentence is that the symmetry now holds at three record-Weyl bare operators **over `Fin n`**, and that two named steps remain before the consumers can use it: `extend` at a general `ι`, and `IsWeyl` closed under scaling the operator.

**And [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s own *What is owed* section is untouched by all three commits**, so the file that records the debt still records it with no pointer to [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean).

## 2. The two transpositions do generate the full symmetric group, at the hypotheses each carries. CONFIRMED

[foxTri_comm](../lean/HamiltonsCubic/Base/FoxProduct.lean#L288) carries no hypothesis at all, so composing it never costs anything. `foxTri_symm_right` carries three `IsWeyl`s, and every permutation it appears in is a permutation of the same three operators, so the hypothesis set does not grow along a composition. All three remaining elements of the group elaborate at `Fin n`:

| Permutation | Route |
|---|---|
| (1 3), `foxTri X Y Z = foxTri Z Y X` | `symm_right`, `comm`, `symm_right`, `comm` |
| (1 2 3), `foxTri X Y Z = foxTri Y Z X` | `comm`, `symm_right` |
| (1 3 2), `foxTri X Y Z = foxTri Z X Y` | `symm_right`, `comm` |

So *full symmetry of `T`*, the owed bullet's phrase, is the right description of what the pair delivers, over `Fin n` and at three `IsWeyl` arguments.

## 3. The theorems are right and six docstrings claim more than they prove. REFUTED

**The hypothesis sets are the weakest that work.** Each link needs `hR`, the bivector-preservation clause, because the operator is met at arguments the chain itself produces: `sharpQF` applies `R` to `br η (R (phi i j))`, `Qop` applies the second operator at `R X`. `foxTri_congr_on_skew` correctly asks for skew-preservation of the first two arguments only and for agreement alone on the third, which is right because `Z` is met at the `φ` and nowhere else.

**What over-claims is the prose.** Six headlines assert the congruence unqualified where each theorem in fact needs `IsWeyl`'s first clause:

- *"`sharpQF` reads `R` only on bivectors."* False for an `R` that does not preserve bivectors, which is exactly when `br η (R (phi i j))` leaves `Λ²`. The hypothesis `hR` is in the signature and absent from the sentence.
- *"And so does `sharpBil`."*, *"And `sharpOp`, at a bivector."*, *"And `Qop`."*, and `foxProd_congr_on_skew`'s *"given both operators preserve bivectors and agree there"*, which is the one that does state its condition.
- The module docstring's *"The route is that `foxTri` reads its three arguments ONLY on bivectors"*, repeated verbatim in [lean/INDEX.md](../lean/INDEX.md)'s I36 row.

**And one stated reason is false.** `foxTri_congr_on_skew`'s docstring gives the justification *"since `innerOp` evaluates them at the `φ` family and nowhere else"*. [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135) evaluates its two arguments at the `φ` family, and in `foxTri X Y Z = innerOp (foxProd X Y) Z` those arguments are `foxProd X Y` and `Z`. Only `Z` is covered. `X` and `Y` are read by [foxProd](../lean/HamiltonsCubic/Base/FoxProduct.lean#L208) through `Qop = compOp + sharpOp`, hence at `X Z` and at the brackets inside `sharpQF`, none of which is a `φ`. **The five lemmas above it in the file are precisely the work that reason skips**, so the sentence says the theorem is cheap for a reason its own file refutes.

## 4. One self-correction is confirmed in the kernel, the other is an effort estimate I can screen but not settle

**(b) the Fermat claim: CONFIRMED.** Mathlib's [IsLocalMaxOn.hasFDerivWithinAt_nonpos](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/LocalExtr/Basic.lean#L104) sits under `variable {E : Type u} [NormedAddCommGroup E] [NormedSpace ℝ E]`, so it does want exactly the two structures the scoped `OperatorNorm` supplies. The composition the brief asked me to write elaborates, outside the scope, with no coaxing:

```lean
example {s : Set (CurvOp2 ι)} {a y : CurvOp2 ι}
    (h : IsLocalMaxOn Pcubic2 s a)
    (hf : HasFDerivWithinAt Pcubic2 (PcubicDiff a) s a)
    (hy : y ∈ posTangentConeAt s a) : PcubicDiff a y ≤ 0 :=
  isLocalMaxOn_hasFDerivWithinAt_nonpos h hf hy
```

The commit's companion check also holds: `#synth NormedAddCommGroup (CurvOp2 (Fin 3))` fails outside the scope. So demoting the inner product from a blocker to a convenience is right, and it rests on something I verified rather than on r1017's report alone.

**(a) "one STATEMENT and not one lemma": PLAUSIBLE.** The named route is real, [IsCompact.isVonNBounded](../lean/.lake/packages/mathlib/Mathlib/Analysis/LocallyConvex/Bounded.lean#L415) exists with that signature. Whether the remaining work is one lemma or several is an effort estimate, and settling it means opening a proof attempt of unknown cost, which this round is not approved for. **One thing the note omits bears on the estimate**: Mathlib also carries [isVonNBounded_iff](../lean/.lake/packages/mathlib/Mathlib/Analysis/LocallyConvex/Bounded.lean#L485), von Neumann boundedness equals metric boundedness in a normed space, and `CurvOp2` has a normed structure available in the `OperatorNorm` scope. Whether that scope's topology is the native one is the [r1006](REVIEW_r1006.md)/[r1008](REVIEW_r1008.md) trap and I did not resolve it. Recording the second route as unexamined is the honest state.

## 5. The core is built on the record's own pairing, and nonnegativity is not vacuous. CONFIRMED

[curvOpCore](../lean/HamiltonsCubic/Results/CurvOpInner.lean) sets `inner R S := innerOp2 R S`, [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279) being the record's pairing with its `½` and its ordered-pair doubling. Every field is discharged at that pairing with no rescaling anywhere:

| Field | Discharged by | At the record's pairing? |
|---|---|---|
| `conj_inner_symm` | `innerOp2_comm` | yes |
| `re_inner_nonneg` | `innerOp2_self_nonneg` | yes |
| `add_left` | `innerOp2_add_left` | yes |
| `smul_left` | `innerOp2_smul_left` | yes |
| `definite` | `normSq2_eq_zero` | yes, `normSq2 R` is `innerOp2 R R` by definition, so it matches by `rfl` |

**The nonzero witness.** At `idOp = ContinuousLinearMap.id ℝ (skewSub (Fin 3))`, the kernel gives `normSq2 idOp = 3`, hence `0 < innerOp2 idOp idOp`, and `idOp ≠ 0` follows since `normSq2 0 = 0`. That also confirms [Bivectors2.lean:789](../lean/HamiltonsCubic/Base/Bivectors2.lean#L789)'s figure `normSq2 id = ½n(n-1)`, which is `3` at `n = 3` against the sup norm's `1`.

## 6. Exactly two side conditions, and the proved one is the first. CONFIRMED

`#check` gives the constructor's signature, and the explicit arguments are exactly two:

```
ContinuousAt (fun v => inner 𝕜 v v) 0 →
  IsVonNBounded 𝕜 {v | RCLike.re (inner 𝕜 v v) < 1} → NormedAddCommGroup F
```

`curvOpCore.toNormedAddCommGroupOfTopology continuousAt_innerOp2_self_zero h'` elaborates with `h'` as the only hypothesis, so [continuousAt_innerOp2_self_zero](../lean/HamiltonsCubic/Results/CurvOpInner.lean) is accepted as the first side condition and the file's account of what remains is exactly right.

**One sentence beside it is not.** See item 7.

## 7. Overreach sweep, eight sentences across the five touched prose files

**Kernel-refuted, and the largest of the eight.** *"All four instance hypotheses of `toNormedAddCommGroupOfTopology` synthesize in the NATIVE topology, three of them through `ContinuousLinearMap`'s own instances"*, with the four named as `IsTopologicalAddGroup`, `ContinuousConstSMul ℝ`, `T2Space` and `FiniteDimensional ℝ`. `#check` gives the constructor's instance arguments as `RCLike 𝕜`, `AddCommGroup F`, `Module 𝕜 F`, `InnerProductSpace.Core 𝕜 F`, `TopologicalSpace F`, `IsTopologicalAddGroup F`, `ContinuousConstSMul 𝕜 F`. **Neither `T2Space` nor `FiniteDimensional` is among them**, so two of the four belong to a different lemma, presumably the compactness route for the second side condition. And the parenthetical undercounts in the other direction: all five named instances resolve to `ContinuousLinearMap`'s, not three of them.

```
#synth TopologicalSpace (CurvOp2 (Fin 3))        ContinuousLinearMap.topologicalSpace
#synth IsTopologicalAddGroup (CurvOp2 (Fin 3))   ContinuousLinearMap.topologicalAddGroup
#synth ContinuousConstSMul ℝ (CurvOp2 (Fin 3))   ContinuousLinearMap.continuousConstSMul
#synth T2Space (CurvOp2 (Fin 3))                 ContinuousLinearMap.instT2Space
#synth FiniteDimensional ℝ (CurvOp2 (Fin 3))     ContinuousLinearMap.instModuleFinite
```

The sentence stands in four places: [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean)'s module docstring, [lean/INDEX.md](../lean/INDEX.md)'s `innerOp2`-as-inner-product row, [plan.md](../plan.md)'s I36 owed line, and [ATTEMPTS.md](../ATTEMPTS.md). **`0059ff96` corrected two other sentences in the same paragraph and left this one.** The repair is to say that the constructor's three topological instance hypotheses synthesize, all through `ContinuousLinearMap`, and that `T2Space` and `FiniteDimensional` are available for the route to the second side condition.

**A sufficient comparison asserted generally.** *"The scoped `OperatorNorm` states a DIFFERENT unit sphere from the record's, ‖id‖ = 1 against normSq2 id = ½n(n-1)"*, in [lean/INDEX.md](../lean/INDEX.md) and [ATTEMPTS.md](../ATTEMPTS.md). The two spheres differ **from `n = 3`**, which is how [Bivectors2.lean:789](../lean/HamiltonsCubic/Base/Bivectors2.lean#L789) states it and how the restatements drop it. In the kernel: `normSq2 id = 1` at `Fin 2`, where the two spheres coincide, and `normSq2 id = 0` at `Fin 1`, where the space is trivial and `‖id‖ = 1` is false as well. Restoring the four words `from n = 3` fixes it.

**The discharge sentence, in three places.** Item 1's refutation applies verbatim to [lean/INDEX.md](../lean/INDEX.md)'s I36 FoxBridge row, to [plan.md](../plan.md)'s *"FoxProduct.lean's RECORDED DEBT IS DISCHARGED, 2026-09-19 ... at record-Weyl BARE operators, which is what that file's consumers quantify over"*, and to [ATTEMPTS.md](../ATTEMPTS.md)'s *"THE THIRD ATTEMPT IS THE ONE THAT WORKS"*.

**A claim about a layer drawn from one file.** [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean)'s module docstring: *"So `foxTri_symm_right` holds at record-Weyl bare operators, which is what that section records as owed."* The owed section is stated under [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s `variable {ι : Type*} [Fintype ι] [DecidableEq ι]`, and the theorem is at `Fin n`, so "that section" is not what the theorem reaches.

**The false reason on `foxTri_congr_on_skew`**, and the five unqualified congruence headlines. Both are item 3.

**A sequencing defect that reads as an over-claim.** [lean/INDEX.md](../lean/INDEX.md)'s I36 FoxBridge row ends *"ITS REACH IS THE IMAGE OF `extend`, NOT EVERY BARE OPERATOR"*. That sentence is about `foxTri_symm_right_extend` and now sits after the paragraph about `foxTri_symm_right`, whose reach is larger, so the nearest antecedent is the wrong theorem.

**One declaration is dead.** `extend_restrict_isSkew` is referenced nowhere: `foxTri_eq_foxTri2_restrict` takes bivector-preservation from `hX.1` directly. It is correct and carries the standard three axioms. It is simply not a step in the chain its docstring places it in.

**What the sweep confirms.** Every new declaration in both files carries `[propext, Classical.choice, Quot.sound]` and no `sorryAx`: `extend_add'`, `foxProd_extend`, `foxTri_extend`, `foxTri_symm_right_extend`, the five `congr_on_skew` links, `extend_restrict_isSkew`, `curvOpCore`, `continuous_applyPhi`, `continuous_inner2_of`, `continuous_innerOp2_self` and `innerOp2_self_nonneg`. The `I36Budget` repair in [TensorBridge.lean:337](../lean/HamiltonsCubic/Results/TensorBridge.lean#L337) is right: it now quantifies local-maximality over `{S | IsWeyl2 S ∧ normSq2 S = 1}`, matching `I36Shape` six lines above, and `I36Shape_imp_fullSphere` shows which of the two is the stronger statement.

## What I recommend

**Correct the four copies of the instance sentence and the two copies of the sphere comparison first.** They are wrong about something the kernel settles in one line each, and the instance sentence survived a commit that was specifically revisiting that paragraph.

**Then state the debt honestly and name the two steps.** The symmetry holds over `Fin n` at three record-Weyl bare operators, and reaching [RayleighLE](../lean/HamiltonsCubic/Base/FoxProduct.lean#L370) needs `extend` at a general `ι` and `IsWeyl` closed under scaling the operator. Both are small, and neither is done. **The pattern to break is claiming the discharge in the same commit as the theorem.** Three times now the theorem has been correct and the sentence about it has not, and the cheap guard is to write the consumer's own application as an `example` before writing the sentence, which is what I did here and what turned the claim in twenty minutes.
