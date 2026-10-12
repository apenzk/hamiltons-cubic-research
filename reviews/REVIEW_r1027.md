# Review r1027: Frechet differentiability of Pcubic2 and the sphere curve

Reviewer r1027, independent of r1026 on the identical brief. Commits under review: `631e9235`, `791bfd2c`, `6e0d3ee3`, `6e63bcd3`. Log: [agent_logs/r1027.log](../agent_logs/r1027.log).

| # | Item | Verdict |
|---|---|---|
| 1 | Is `hasFDerivAt_Pcubic2` usable by Fermat, or stranded on the wrong bundling? | **CONFIRMED USABLE**, and the two bundlings are the same term at the same type |
| 2 | Is `hasFDerivAt_Pcubic2` non-vacuous? | **CONFIRMED**, witness proved in the kernel |
| 3 | The little-o argument: quantifier order and the `‖H‖ ≤ 1` hypothesis | **CONFIRMED** |
| 4 | Is `sphereCurve_mem` right, and is `sphereCurve` the curve a cone membership needs? | **CONFIRMED**, with the file's account of the cone definition refuted |
| 5 | Does the record say correctly which of r1016's pieces remain? | **REFUTED**, the swap survives in a fifth place and four owed-claims are falsified |
| 6 | Is the withdrawal in `6e0d3ee3` itself correct? | **CONFIRMED**, and it does not over-concede |
| 7 | Overreach sweep over the four commits' docstrings and record lines | **REFUTED**, seven sentences claim more than the declarations beside them |

Everything below was run under `lake env lean` from [lean/](../lean/) at the project toolchain, against a `lake build` that completed clean over 9225 jobs. Probe files are in the session scratchpad. Every probe run carried a deliberately false control so that a silent pass could be distinguished from a silent misrun: the first control I wrote, `PcubicDiff R = PcubicDiffS R` by `rfl`, passed, and that is itself finding 1 rather than a broken harness, so a real control (`normSq2 R = 17`) was added and fires.

## 1. Fermat consumes `hasFDerivAt_Pcubic2` directly, and `PcubicDiff` would serve equally

**The theorem is usable, and the kernel says so.** This elaborates and closes with no `sorry`:

```lean
example {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R)
    (hmax : IsLocalMaxOn Pcubic2 {S : CurvOp2 ι | normSq2 S = 1} R)
    (y : CurvOp2 ι) (hy : y ∈ posTangentConeAt {S : CurvOp2 ι | normSq2 S = 1} R) :
    PcubicDiffS R y ≤ 0 :=
  hmax.hasFDerivWithinAt_nonpos (hasFDerivAt_Pcubic2 hR).hasFDerivWithinAt hy
```

- **`HasFDerivAt` gives `HasFDerivWithinAt`** through [HasFDerivAt.hasFDerivWithinAt](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Calculus/FDeriv/Basic.html), which under this toolchain needs only `AddCommGroup`, `Module` and `TopologicalSpace`.
- **`StrongDual ℝ E` is a reducible abbreviation for `E →L[ℝ] ℝ`**, `#print StrongDual` confirming it, so `PcubicDiffS R` inhabits it with nothing to convert.
- **The whole application sits inside the `OperatorNorm` scope**, where `NormedAddCommGroup` and `NormedSpace ℝ` are the instances Fermat's binders want.

**The sharper finding: `PcubicDiff` and `PcubicDiffS` are the same term at the same type, so no bundling is wrong and none is dead for a type reason.** Three kernel facts, each from a probe that carries a firing control:

1. `PcubicDiff R = PcubicDiffS R` holds by `rfl`. Both are `ContinuousLinearMap.mk` of the same linear map, and the continuity fields are proofs, so proof irrelevance closes it.
2. Printed with `pp.explicit`, the two types are character-for-character identical, and the topology in both is `ContinuousLinearMap.topologicalSpace`, the native one. The claim in [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) that *"the two differ only in which topology their `→L` carries"* is false: neither carries the scoped topology.
3. `hasFDerivAt_Pcubic2 hR` inhabits `HasFDerivAt Pcubic2 (PcubicDiff R) R` by `exact`, with no bridging lemma, and the full proof script of `hasFDerivAt_Pcubic2` reproves that statement verbatim with `PcubicDiff` substituted throughout, `abs_remainder_le hR H h1` included, on the standard three axioms.

**So the fourth "correct theorem at a domain nobody uses" did not happen.** What did happen is one step of unnecessary work and a misattributed cause, which section 7 records.

**Is `PcubicDiff` now dead?** As a declaration, yes: `PcubicDiff`, `PcubicDiff_apply` and `PcubicDiff_eq_lin` have no consumer anywhere in the tree, reviews and `ATTEMPTS.md` aside. As a file, [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) is load-bearing, since [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) imports it and reaches [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) through it. **My recommendation is to keep the declarations and delete the claim that the two bundlings differ**, since a second name for a `rfl`-equal term costs nothing and the sentence about it costs a reader an hour.

## 2. Non-vacuous, with a witness proved in the kernel

**At `ι = Fin 2` the identity operator is self-adjoint, has `Qop2 R = R ≠ 0`, and has a nonzero differential.** Proved end to end, standard three axioms on the final declaration:

- `IsSelfAdjoint2 (ContinuousLinearMap.id ℝ (skewSub (Fin 2)))` is `fun _ _ => rfl`.
- At `Fin 2` every bracket of bivectors vanishes, `br X Y = 0` from `Xᵀ = -X` and `Yᵀ = -Y` by the four entry relations, hence `sharpQF2 R η = 0`, hence `sharpBil2 R = 0`, hence `sharpMap R = 0` and `sharpMapCL R = 0` at every `R`.
- So `Qop2 id = compOp2 id = id`, and `id ≠ 0` because `phi 0 1` has entry `(1,0)` equal to `1`.
- `PcubicDiffS id (Qop2 id) = 3 * innerOp2 id id = 3 * normSq2 id ≠ 0`, the last step by `normSq2_eq_zero` against `id ≠ 0`.

**The hypothesis class is wide rather than exotic**, `IsWeyl2.isSelfAdjoint2` carrying every record-Weyl operator into it, so the theorem is not confined to a thin set even before a witness is exhibited. **The witness above is the cheapest one and it is degenerate in one respect worth stating**: at `ι = Fin 2` the sharp term vanishes identically, so the witness exercises `trCube2` alone. A witness at `Fin 3` would exercise both halves and would need `sharpMap id` evaluated, which is a run of unknown cost, so I did not open it.

## 3. The little-o argument is correct, and the quantifier order is the right one

**The order is `c` first, then the ball.** [isLittleO_iff](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Asymptotics/Defs.html) reads `∀ ⦃c⦄, 0 < c → ∀ᶠ x in l, ‖f x‖ ≤ c * ‖g x‖`, and the proof does `intro c hc` and only then builds `Metric.ball 0 (min 1 (c / (K + 1)))`. The radius therefore depends on `c`, which is permitted, and the bound is proved for every `H` in that ball through `filter_upwards`, which is what is required.

**The `‖H‖ ≤ 1` hypothesis is genuinely available at the point of use.** `hH : ‖H‖ < min 1 (c / (K + 1))` gives `h1 : ‖H‖ ≤ 1` by `min_le_left`, and `h1` is exactly what `abs_remainder_le hR H h1` consumes. The `min` exists for this reason and for no other.

**The arithmetic holds at `K = 0`.** `hKnn` gives `0 ≤ K`, the divisor is `K + 1` rather than `K`, and `‖H‖ < c / (K + 1)` gives `K * ‖H‖ ≤ K * c / (K + 1) < c`, so `K * ‖H‖² ≤ c * ‖H‖`. The `‖H‖ = 0` case is split off before the multiplication.

**`abs_remainder_le` itself is right.** `Pcubic2_expand` and `PcubicDiffS_eq_lin hR` give the remainder as `Pcubic2Quad R H + Pcubic2 H`, both summands, and `hH` converts the cubic bound `cubicConst * ‖H‖³` into `cubicConst * ‖H‖²` on the unit ball, so the constant is `3 * cubicConst * ‖R‖ + cubicConst`. The self-adjointness hypothesis is used, in `PcubicDiffS_eq_lin`, and is not decorative.

**Axioms checked independently of the brief**: `hasFDerivAt_Pcubic2`, `abs_remainder_le`, `PcubicDiffS_eq_lin`, `PcubicDiffS`, `cubicConst_nonneg`, `sphereCurve_mem`, `normSq2_add_smul`, `normSq2_smul`, `sphereCurve_zero`, `normSq2_nonneg`, `Pcubic2Lin_selfAdjoint` and `PcubicDiff_eq_lin` all report `[propext, Classical.choice, Quot.sound]`.

## 4. The curve is right and it is the right curve, and the file's account of the cone definition is not

**`sphereCurve_mem` is correct.** `normSq2 (a + t·y) = normSq2 a + 2t⟨a,y⟩ + t²normSq2 y` is polarisation and is proved as such, the two hypotheses collapse it to `1 + t²normSq2 y`, and `normSq2_smul` with `Real.sq_sqrt` on the positive scalar gives `1`. Checked numerically as well at a random orthogonal pair in a three-dimensional model of `Λ²` with `innerOp2 A B = Tr(AᵀB)`, at `t ∈ {0, 0.3, -1.7, 12}`: the curve's `normSq2` is `1` to machine precision at every one, and `n·(γ(1/n) − a) → y` at the predicted rate `1/n`.

**`sphereCurve` is the object the membership needs, and it discharges exactly one of the three obligations.** Under the current Mathlib the usable sufficient condition is [mem_tangentConeAt_of_seq](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Calculus/TangentCone/Defs.html), and with `l = atTop`, `c n = (n : NNReal)` and `d n = sphereCurve a y (1/n) - a` the skeleton elaborates with the middle obligation closed by `sphereCurve_mem` and two `sorry`s left:

```lean
refine mem_tangentConeAt_of_seq atTop (fun n : ℕ => (n : NNReal))
  (fun n : ℕ => sphereCurve a y (1/n) - a) ?_ ?_ ?_
-- 1. Tendsto d atTop (𝓝 0)                    sorry
-- 2. ∀ᶠ n, a + d n ∈ {S | normSq2 S = 1}      closed by sphereCurve_mem
-- 3. Tendsto (fun n => (n : NNReal) • d n) atTop (𝓝 y)   sorry
```

**So what remains unproved is precisely two limits**, `d n → 0` and `n • d n → y`, and the file's statement that the limit is what is missing is accurate. Both are true: `d n = (λₙ − 1)·a + λₙ·(1/n)·y` with `λₙ = (1 + k/n²)^(−1/2)`, so `d n → 0`, and `n·d n = n(λₙ − 1)·a + λₙ·y → y` because `n(λₙ − 1) ~ −k/(2n)`.

**THE DEFECT: the file describes a definition this toolchain does not have, under the words "checked rather than recalled".** [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean)'s closing paragraph says a membership *"supplies `c : ℕ → NNReal` with `‖c n‖ → ∞` together with `d : ℕ → CurvOp2 ι`"*, and `6e63bcd3`'s message says the same. Three things are wrong with it:

- **`tangentConeAt` is the cluster-point definition here**, `{y | ClusterPt y ((⊤ : Filter R) • 𝓝[(x + ·) ⁻¹' s] 0)}`, with no norm condition anywhere and no `ℕ` in it. Its unfolding lemmas quantify over an arbitrary index type and filter.
- **The `‖c n‖ → ∞` form is the pre-PR-34127 definition**, surviving as `mem_tangentConeAt_iff_exists_seq_norm_tendsto_atTop`, whose own docstring says so.
- **That survivor cannot be instantiated at `posTangentConeAt` at all**, since it is stated over a `NontriviallyNormedField`. Instantiating it at `NNReal` fails on `Norm NNReal`, and the underlying reason is not a search artifact: `ℝ≥0` has no additive inverses, so it is not a field.

**The condition the file omits is the one that has to be proved**: the current sufficient lemma wants `d n → 0`, which the `‖c n‖ → ∞` form did not ask for. The omission is therefore not cosmetic, it drops one of the two open obligations from the file's own account of what is open.

## 5. The record does not correctly say which of r1016's pieces remain

**r1016 section 9 names them in this order**: (1) the functional is not bundled, a `StrongDual ℝ (CurvOp2 ι)` is wanted; (2) Fréchet differentiability itself; (3) the positive tangent cone is uncomputed. **The two files under review use this order correctly**, [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) closing the first, [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) the second, [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean) working toward the third. The claim that the first two are closed is true, and I verified the second in the kernel rather than reading it.

**THE SWAP SURVIVES IN A FIFTH PLACE THAT NOBODY COUNTED.** [lean/INDEX.md](../lean/INDEX.md)'s `PcubicDiff.lean` row, line 142, still reads *"This is the type `IsLocalMaxOn.hasFDerivWithinAt_nonpos` consumes and is the second of the three pieces r1016 named between the line derivative and Fermat."* r1024 and r1025 counted four places, `631e9235` corrected those four, and this row was never on the list. It is the row for the very file whose docstring was corrected, one screen below the row that was.

**Four further claims in the record are falsified by the commits that followed them.**

| Where | Sentence | Status |
|---|---|---|
| [lean/INDEX.md](../lean/INDEX.md) line 138, rewritten by `631e9235` | *"WHAT IS NOT HERE IS THE `HasFDerivAt` DECLARATION, which no statement in the tree carries"* | The tree carries it, [Frechet.lean:106](../lean/HamiltonsCubic/Results/Frechet.lean), added seven minutes later by `791bfd2c`, which edited this same file without touching this row |
| [lean/INDEX.md](../lean/INDEX.md) line 142 | *"NOT stated: Fréchet differentiability itself, which needs an estimate on `Pcubic2Quad` that nothing supplies"*, and *"`PcubicDiff_eq_lin` carrying `sorryAx`"* | Both false: `abs_Pcubic2Quad_le` supplies the estimate, and `#print axioms PcubicDiff_eq_lin` gives the standard three |
| [lean/INDEX.md](../lean/INDEX.md) line 144 | *"NOT stated: the Fréchet form `HasFDerivAt` ... and is owed beyond the line form"* | True of that file, stale as an owed-claim |
| [plan.md](../plan.md) line 152 and line 145 | *"OWED, in order: an estimate on `Pcubic2Quad`, which the general-increment expansion names and nothing bounds"*, and *"what is proved is a GATEAUX derivative where it wants a FRÉCHET one"* | Both closed this cycle, and the plan is the list every later cycle reads first |

**And the newest file is in no index at all.** [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean) has no row in [lean/INDEX.md](../lean/INDEX.md). Every other file under `Results/` has one, so this is a gap rather than a convention. `6e63bcd3` added the file and the import and stopped there.

## 6. The withdrawal is correct, and it does not over-concede

**The paragraph in question, in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) immediately above `namespace OperatorNorm`, reads**: *"The repair that would close both at once is an `InnerProductSpace ℝ (CurvOp2 ι)` over `innerOp2`, whose definiteness is `normSq2_eq_zero` above, built with `toNormedAddCommGroupOfTopology` so the existing topology is kept."*

**The subject of "built with" is the repair.** The sentence is one clause about a hypothetical `InnerProductSpace`, and `toNormedAddCommGroupOfTopology` is the constructor that repair would use. Nothing in it describes `ContinuousLinearMap.toNormedAddCommGroup`, which is what the instance below actually uses. So `791bfd2c`'s *"the code and its own docstring disagree"* was a misreading, and `6e0d3ee3` withdraws it correctly.

**Nor does the withdrawal concede too much.** I read the surrounding section for any claim that the scoped instances preserve the native topology and found none. The nearest thing, *"the Frobenius one has topology DEFEQ to the instance already on `Matrix`, so opening it creates no diamond"*, is about `Matrix.Norms.Frobenius` and is a claim about matrices, not about `CurvOp2`. The file separately records, 500 lines above, that an earlier version claimed topologies agreed and checked it with a blind `rfl`, and that the check compared one instance with itself. **The record's account of its own instance situation is therefore consistent**, and the original defect report was against a sentence that says what a repair would do.

**One refinement the withdrawal does not make, and it matters for section 7.** The withdrawal keeps *"the scoped norm does build its own topology beside the native one"*. That is true of the terms and needs one qualifier: the two are definitionally equal at default transparency. Inside the scope, `(inferInstance : TopologicalSpace (CurvOp2 (Fin 3)))` against the same expression outside the scope closes by `rfl`. They differ at reducible transparency, which is where `rw` matches, and that difference is the whole of the practical obstacle.

## 7. Overreach sweep

**Seven sentences in the four commits' docstrings and record lines assert more than the declarations beside them establish.** Four are the stale owed-claims tabulated in section 5 and are not repeated here. The other three are accounts of a route, and all three fail in the shape the brief names, a route described from a failed search rather than from a proof.

**7.1 The mixed instance set is not caused by where the functional was bundled, and the file's own statement has the same mixture.** [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) says *"So a `CurvOp2 ι →L[ℝ] ℝ` built OUTSIDE the scope carries `ContinuousLinearMap.topologicalSpace` and a `HasFDerivAt` about it elaborates with a MIXED instance set."* Run `rw [hasFDerivAt_iff_isLittleO_nhds_zero]` against the file's own goal, the one with `PcubicDiffS`, and it fails with the target printed as

```
@HasFDerivAt ℝ ... (CurvOp2 ι)
  OperatorNorm.instNormedAddCommGroupCurvOp2.toAddCommGroup   -- scoped
  ContinuousLinearMap.module                                   -- native
  ContinuousLinearMap.topologicalSpace                         -- native
  ... Pcubic2 (PcubicDiffS R) R
```

Run the same `rw` against the `PcubicDiff` goal and the printed target is identical instance for instance, differing only in the functional's name. **The mixture comes from `CurvOp2` being an abbreviation for a `ContinuousLinearMap` type**, so `Module` and `TopologicalSpace` resolve natively while the scoped `NormedAddCommGroup` supplies the additive group. It is a property of writing `HasFDerivAt` over `CurvOp2` inside the scope, and the bundling site has no bearing on it.

**7.2 "THE FIX IS TWO MOVES" overstates by one move.** Of the two, only the second is load-bearing. The identical proof script proves `HasFDerivAt Pcubic2 (PcubicDiff R) R`, so `LinearMap.mkContinuous` and the explicit bound `abs_innerOp2_le` were not needed for this theorem. What is true, and what the file could say instead: `LinearMap.toContinuousLinearMap` does fail inside the scope, on `IsTopologicalAddGroup (CurvOp2 ι)`, which is why a functional defined inside the scope needs `mkContinuous`, and defining one inside the scope was itself avoidable. **The second move is confirmed**: `rw` fails on both goals, `hasFDerivAt_iff_isLittleO_nhds_zero.mpr` as a term succeeds on both, and the file's explanation of why, default against reducible transparency, is borne out by the error, which reports the target as not type-correct at `implicit` transparency.

**7.3 "checked rather than recalled" is attached to a definition that is recalled.** Section 4 has the detail. The phrase asserts verification, and what follows it is the pre-PR-34127 definition, which this toolchain does not use and which cannot be stated at `NNReal`. **This is the most consequential of the three**, because it drops `d n → 0` from the file's list of what remains open.

**Three smaller ones, recorded without a verdict of their own.**

- **`‖y‖²` is written for `normSq2 y`, twice**, in [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean)'s module docstring and in `sphereCurve`'s own. At `CurvOp2` the `‖·‖` in scope is the sup operator norm, and [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) is explicit that `‖id‖ = 1` against `normSq2 id = ½n(n−1)`, so the two spheres are different from `n = 3`. The Lean is right and only the prose conflates them.
- **`sphereCurve`'s definition docstring drops a hypothesis.** *"The scaling is by the square root of `normSq2 (a + t·y)`, which at an orthogonal `y` is `1 + t²‖y‖²`"* is true only with `normSq2 a = 1`, which the definition hard-codes as the `1` and the docstring does not mention. `sphereCurve_mem` carries both hypotheses correctly.
- **"which no owed list outside [plan.md](../plan.md) names"**, in both [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) and [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean), and *"on no one's list but the plan's"* in [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean). [lean/INDEX.md](../lean/INDEX.md)'s own `PcubicDiff.lean` row names it, in the "NOT stated" field, which is the record's owed-list field: *"and the tangent cone at the constraint set"*. A negative claim about where something is absent, made from a search that did not reach the record's own index.

**What the sweep did not find.** No bound is wrong, no theorem is weaker than its statement, and no declaration carries an axiom beyond the standard three. As in the two rounds before it, every defect is in a sentence about a declaration rather than in a declaration.

## Process note

**I saw four lines of r1026's report, inadvertently, and I record it rather than leave it inferable.** A `grep -rn "SphereCurve" --include="*.md" .` over the repository matched [reviews/REVIEW_r1026.md](REVIEW_r1026.md) and printed four of its lines before I could exclude the path. They touch the `‖c n‖ → ∞` defect of section 4, the `‖y‖²` conflation, and the "no owed list outside plan.md" claim.

**My log records the first of those before the exposure.** The heartbeat written at the phase-3 transition carries the `‖c n‖ → ∞` finding and the `Norm NNReal` failure, and the grep came later, in phase 4. The `‖y‖²` conflation and the owed-list point were written after the exposure and should be read as corroborated rather than independent. Everything in sections 1, 2, 3, 5, 6 and 7.1 through 7.2 was derived before it and from the kernel.

## Recommendations

1. **Strike the `‖c n‖ → ∞` sentence from [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean) and put the three obligations of `mem_tangentConeAt_of_seq` in its place**, `d n → 0` included, since that is the one the old form hid.
2. **Fix [lean/INDEX.md](../lean/INDEX.md) line 142's ordinal**, and strike the three falsified owed-claims at lines 138, 142 and 144 together with [plan.md](../plan.md)'s.
3. **Give [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean) an index row.**
4. **Replace [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean)'s diamond paragraph with what the kernel shows**: the mixture is in `HasFDerivAt` over `CurvOp2` inside the scope whatever the bundling, `rw` fails at reducible transparency, the term form succeeds, and `PcubicDiffS` is `rfl`-equal to `PcubicDiff` at the same type.
