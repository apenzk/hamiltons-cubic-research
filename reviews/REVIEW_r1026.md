# Review r1026: Frechet differentiability and the sphere curve

Reviewer r1026, cold brief, independent of r1027. Log: [agent_logs/r1026.log](../agent_logs/r1026.log).

Commits under review: `631e9235`, `791bfd2c`, `6e0d3ee3`, `6e63bcd3`. Every kernel claim below was run with `lake env lean` from [lean/](../lean/) under the project's 4.33.1, on a tree whose `lake build` completes over 9225 jobs.

| # | Item | Verdict |
|---|------|---------|
| 1 | `hasFDerivAt_Pcubic2` usable by Fermat, or stranded on the wrong bundling | CONFIRMED usable |
| 2 | `hasFDerivAt_Pcubic2` non-vacuous | CONFIRMED |
| 3 | The little-o argument and its quantifier order | CONFIRMED |
| 4 | `sphereCurve_mem` and what the cone membership still needs | CONFIRMED |
| 5 | Which of r1016's pieces the record says remain | REFUTED |
| 6 | The withdrawal in `6e0d3ee3` | CONFIRMED |
| 7 | Overreach sweep over the four commits' prose | REFUTED |

**The headline.** *Every declaration in the four commits is correct and every axiom check is clean.* **What fails is again the prose, and this round it fails at the point the file is proudest of**: [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean)'s account of why a second bundling of the differential was needed does not survive the kernel. `hasFDerivAt_Pcubic2 hR` inhabits `HasFDerivAt Pcubic2 (PcubicDiff R) R` verbatim, so `PcubicDiffS` bought nothing the imported functional did not already give.

## 1. Fermat consumes it. CONFIRMED, and the reason the file gives for building `PcubicDiffS` is wrong

**The chain compiles end to end.** Inside the `OperatorNorm` scope, with `s = {S | normSq2 S = 1}`:

```lean
example {R y : CurvOp2 ι} (hR : IsSelfAdjoint2 R)
    (hmax : IsLocalMaxOn Pcubic2 {S : CurvOp2 ι | normSq2 S = 1} R)
    (hy : y ∈ posTangentConeAt {S : CurvOp2 ι | normSq2 S = 1} R) :
    PcubicDiffS R y ≤ 0 :=
  hmax.hasFDerivWithinAt_nonpos (hasFDerivAt_Pcubic2 hR).hasFDerivWithinAt hy
```

So `HasFDerivAt` gives `HasFDerivWithinAt` by `HasFDerivAt.hasFDerivWithinAt`, `PcubicDiffS R` unifies with the `f' : StrongDual ℝ E` the lemma wants, and `posTangentConeAt` elaborates at `CurvOp2 ι` under the scoped instances. **The theorem is not stranded.** *What stands between this and a real conclusion is `hy`, which is item 4's subject and remains unproved.*

**The two bundlings are one term, and the kernel says so three ways.** `PcubicDiffS R = PcubicDiff R` holds by `rfl`. `PcubicDiff R` is accepted as `f'` in the Fermat chain above with no change. And, decisively:

```lean
example {R : CurvOp2 ι} (hR : IsSelfAdjoint2 R) : HasFDerivAt Pcubic2 (PcubicDiff R) R :=
  hasFDerivAt_Pcubic2 hR
```

compiles. *The two `HasFDerivAt` statements are the same proposition up to defeq.*

**So [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean)'s "THE FIX IS TWO MOVES" is wrong on the first move.** The docstring says a `→L` built OUTSIDE the scope "carries `ContinuousLinearMap.topologicalSpace` and a `HasFDerivAt` about it elaborates with a MIXED instance set", and that `LinearMap.mkContinuous` inside the scope is what repairs it. **I reproduced the `rw` failure at `PcubicDiffS`, the functional built INSIDE the scope**, and the error prints the mixed set:

```
@HasFDerivAt ℝ _ (CurvOp2 ι)
  OperatorNorm.instNormedAddCommGroupCurvOp2.toAddCommGroup   -- scoped
  ContinuousLinearMap.module                                   -- native
  ContinuousLinearMap.topologicalSpace                         -- native
  ... Pcubic2 (PcubicDiffS R) R
```

*The mixing is in `HasFDerivAt`'s own instance arguments at `CurvOp2 ι`, which resolve the `AddCommGroup` through the scoped norm and the `Module` and `TopologicalSpace` through `ContinuousLinearMap`.* **It is independent of which constructor bundled the functional**, since the two statements are defeq and the `rw` fails identically at both. **Only the second move, using `hasFDerivAt_iff_isLittleO_nhds_zero` as a TERM, is load-bearing.**

**Is `PcubicDiff` dead?** *Not quite, and neither is dead in the kernel's eyes, since either serves everywhere the other does.* What [PcubicDiffS](../lean/HamiltonsCubic/Results/Frechet.lean) alone carries is a quantitative operator-norm bound, `‖PcubicDiffS R‖ ≤ 3‖Qop2 R‖ · normSq2 id`, which `LinearMap.toContinuousLinearMap` does not produce. **That gain is real and the file does not state it.** *What the record has instead is three declarations in [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) duplicated up to defeq by three in [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean), under a docstring that says the two "differ only in which topology their `→L` carries" without saying they are the same term.*

## 2. Non-vacuous. CONFIRMED, with a kernel-checked witness

**At `ι = Fin 2`, `R = id` satisfies the hypothesis and `Qop2 R ≠ 0`.** The witness is short because `Λ²(ℝ²)` is one-dimensional and abelian:

- `id_isSelfAdjoint2 : IsSelfAdjoint2 (ContinuousLinearMap.id ℝ (skewSub ι))`, which is `fun _ _ => rfl` at every index type.
- `br_fin2`: the bracket of two skew `2 × 2` matrices is zero, from `A 0 0 = A 1 1 = 0` and `A 1 0 = -A 0 1`.
- Hence `sharpQF2 R η = 0`, `sharpBil2 R X Y = 0`, `sharpMap R X = 0`, and so `Qop2 id = compOp2 id = id`.
- `id ≠ 0` on `skewSub (Fin 2)` because `phi 0 1` has entry `1` at `(1,0)`.

**And the derivative is not the zero functional there.** `PcubicDiffS R (Qop2 R) = 3 · normSq2 (Qop2 R)`, which vanishes only if `Qop2 R = 0` by `normSq2_eq_zero`. *All of this is proved with no `sorry`, in a scratch file run under the project toolchain and then discarded, so it is a check rather than a contribution to the tree.*

**The hypothesis is not decoration either.** At `|ι| ≤ 1` the space `skewSub ι` is trivial and everything is zero, so the theorem is vacuous below `n = 2` and non-vacuous from `n = 2` up.

## 3. The little-o argument. CONFIRMED

**The quantifier order is right.** `Asymptotics.isLittleO_iff` unfolds to `∀ c, 0 < c → ∀ᶠ H in 𝓝 0, ‖f H‖ ≤ c * ‖H‖`. The proof does `intro c hc` first and only then produces the eventually, so the radius `min 1 (c / (K + 1))` may depend on `c` and the bound holds for all `H` in that ball. *That is the order the definition asks for.*

**`abs_remainder_le`'s hypothesis is genuinely available.** `filter_upwards` supplies `hH : ‖H‖ < min 1 (c / (K + 1))`, and `h1 : ‖H‖ ≤ 1` comes from `min_le_left`. **The two halves of the `min` do exactly one job each**: the first discharges `abs_remainder_le`, the second gives `K * ‖H‖ < c` and so `K * ‖H‖² ≤ c * ‖H‖`, with the `‖H‖ = 0` case split out.

**The estimate underneath is right.** `|Pcubic2Quad R H| ≤ 3 · cubicConst ι · ‖R‖ · ‖H‖²` and `|Pcubic2 H| ≤ cubicConst ι · ‖H‖³`, and `‖H‖³ ≤ ‖H‖²` on the unit ball, so the sum is `(3 · cubicConst ι · ‖R‖ + cubicConst ι) · ‖H‖²`. *`cubicConst_nonneg` is what makes the absorption legal and it is proved in the file.*

## 4. The curve is right, and the file's account of what a membership supplies is not

**The algebra is correct.** `normSq2_add_smul` is the polarisation of a symmetric bilinear form and holds with no hypothesis. Under `ha : normSq2 a = 1` and `hy : innerOp2 a y = 0` the cross term drops and `normSq2 (a + t·y) = 1 + t²·normSq2 y`, so `normSq2 (sphereCurve a y t) = (1 + t²k)⁻¹(1 + t²k) = 1` by `normSq2_smul` and `Real.sq_sqrt`.

**At explicit values.** With `normSq2 a = 1`, `innerOp2 a y = 0`, `normSq2 y = 3`, `t = 1`: the scale is `1/2` and `normSq2 = (1/4)(1 + 3) = 1`. **Both hypotheses are load-bearing**: at `innerOp2 a y = 1`, `normSq2 y = 0`, `t = 1` the scale is `1` and `normSq2 (a + y) = 3`; at `normSq2 a = 4`, `y = 0` the curve is `a` and `normSq2 = 4`.

**THE DEFECT: there is no norm-to-infinity condition on `c`, and the file says there is.** [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean)'s closing paragraph says *"a membership supplies `c : ℕ → NNReal` with `‖c n‖ → ∞` together with `d`"*, and `6e63bcd3`'s message says the definition was *"checked rather than recalled"*. **Read under the project toolchain, `tangentConeAt` is**

```lean
irreducible_def tangentConeAt (s : Set E) (x : E) : Set E :=
  {y : E | ClusterPt y ((⊤ : Filter R) • 𝓝[(x + ·) ⁻¹' s] 0)}
```

*and neither direction carries a norm condition.* `mem_tangentConeAt_of_seq` asks for `Tendsto d l (𝓝 0)`, `∀ᶠ n in l, x + d n ∈ s` and `Tendsto (fun n => c n • d n) l (𝓝 y)`, and `exists_fun_of_mem_tangentConeAt` returns exactly those three. **The norm-to-infinity clause belongs to an older Mathlib definition**, so that sentence is recalled and its "checked" is the part that is wrong. *This is the one claim in the four commits that a reader could act on and be misled by, since it would send them looking for a hypothesis they cannot discharge and do not need.*

**`sphereCurve` is nonetheless the right object, and the remaining gap is exactly two limits.** The proposed witness type-checks and reduces the membership to them:

```lean
example (hd0 : Tendsto (fun n : ℕ => sphereCurve a y (1/(n:ℝ)) - a) atTop (𝓝 0))
    (hs : ∀ n : ℕ, normSq2 (sphereCurve a y (1/(n:ℝ))) = 1)
    (hcd : Tendsto (fun n : ℕ => ((n : ℝ≥0)) • (sphereCurve a y (1/(n:ℝ)) - a)) atTop (𝓝 y)) :
    y ∈ posTangentConeAt {S : CurvOp2 ι | normSq2 S = 1} a
```

compiles, with the membership hypothesis discharged by `sphereCurve_mem` at every `n` including `n = 0`, where `1/0 = 0` and `sphereCurve_zero` applies. **What remains unproved is `hd0` and `hcd`**: continuity of `t ↦ sphereCurve a y t` at `0`, and `n·(σ_n − 1) → 0` with `σ_n → 1` for `σ_n = (1 + k/n²)^(−1/2)`. *The file names both and claims neither, which is right.*

## 5. The ordinals. REFUTED, because a fifth occurrence survives

**r1016 section 9's order, read from the source:** (1) the functional is not bundled, needing a `StrongDual`; (2) Fréchet differentiability itself; (3) the positive tangent cone is uncomputed. **The record's mathematical claim is correct**: [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) closes the first, [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) the second, the third is open.

**But `631e9235` says "all four corrected" and there were five.** [lean/INDEX.md](../lean/INDEX.md)'s `PcubicDiff.lean` row still reads: *"This is the type `IsLocalMaxOn.hasFDerivWithinAt_nonpos` consumes and is the second of the three pieces [r1016] named between the line derivative and Fermat."* **That is the swap, uncorrected, in the file the commit says it corrected.** *The row the commit did fix is the `CubicTri.lean` one, and the two rows sit four lines apart.*

**Two further defects in that same row, both refuted by the kernel and by the tree:**

- *"`PcubicDiff_eq_lin` carrying `sorryAx` through `phiTri_starred` as every consumer of the rotation does"*. `#print axioms PcubicDiff_eq_lin` gives `[propext, Classical.choice, Quot.sound]`. **No `sorryAx`.**
- *"**NOT stated**: Fréchet differentiability itself, which needs an estimate on `Pcubic2Quad` that nothing supplies"*. `abs_Pcubic2Quad_le` supplies it and `hasFDerivAt_Pcubic2` states the differentiability.

## 6. The withdrawal. CONFIRMED, and it is if anything too generous to the original report

**[Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean)'s paragraph reads:** *"The repair that would close both at once is an `InnerProductSpace ℝ (CurvOp2 ι)` over `innerOp2`, whose definiteness is `normSq2_eq_zero` above, built with `toNormedAddCommGroupOfTopology` so the existing topology is kept."*

**The subject of "built with" is "an `InnerProductSpace ℝ (CurvOp2 ι)`", the repair.** *The constructor it names, `toNormedAddCommGroupOfTopology`, is a different function from the `ContinuousLinearMap.toNormedAddCommGroup` the scoped instance uses, so the sentence cannot be read as a description of that instance without also misreading which constructor it names.* **The withdrawal is correct.**

**Three things strengthen it beyond what `6e0d3ee3` claims.**

- *The paragraph is a `/-! ... -/` module-section comment sitting above `namespace OperatorNorm`, not a doc-comment attached to either instance.* **The instances carry their own one-line docstrings**, "The operators, normed." and "And a normed space over `ℝ`", and neither says anything about topology. *So "that instance's docstring" was already the wrong object.*
- **The same file says the true thing about a different constructor 630 lines earlier**: at `skewCore`, *"`toNormedAddCommGroup` builds its own topology, which is NOT the subtype one already on `skewSub`"*. That is `InnerProductSpace.Core.toNormedAddCommGroup`, and it is where the confused reading most plausibly came from.
- **The diamond the withdrawal keeps is real and now has a printed witness**, the mixed instance set in section 1 above. *And the record's claim that the two agree only at default transparency is confirmed from the other side, since `PcubicDiffS R = PcubicDiff R` closes by `rfl`.*

**I find nothing the withdrawal over-concedes.**

## 7. Overreach sweep. Five sentences assert more than the declarations beside them

**Both of the shapes the brief names are present, and one is new.**

1. **[Frechet.lean:23-26](../lean/HamiltonsCubic/Results/Frechet.lean)**, *"a `CurvOp2 ι →L[ℝ] ℝ` built OUTSIDE the scope carries `ContinuousLinearMap.topologicalSpace` and a `HasFDerivAt` about it elaborates with a MIXED instance set"*, together with **"THE FIX IS TWO MOVES"**. *The mixing is present at `PcubicDiffS`, built inside the scope, and the first move changes nothing.* **This is a route described from a failed search: the `mkContinuous` rewrite and the term-mode `iff` landed together and the credit was split between them without either being tested alone.**
2. **[SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean)'s closing paragraph**, the `‖c n‖ → ∞` clause, under "checked rather than recalled". Section 4.
3. **[CubicTri.lean:346](../lean/HamiltonsCubic/Results/CubicTri.lean)**, *"What is still absent is the `HasFDerivAt` declaration, which no statement in the tree carries"*, and **[lean/INDEX.md:138](../lean/INDEX.md)**, *"WHAT IS NOT HERE IS THE `HasFDerivAt` DECLARATION, which no statement in the tree carries"*. **Both are claims about the whole tree and both were falsified seven minutes later by `791bfd2c`.** *`6e0d3ee3` and `6e63bcd3` both landed after that and `6e0d3ee3` edited [lean/INDEX.md](../lean/INDEX.md), so the sweep was available and was not made.* (The neighbouring `CubicTri.lean:28` sentence, "What is NOT here is the `HasFDerivAt` statement itself", is file-scoped and stays true.)
4. **[PcubicDiff.lean:37-38](../lean/HamiltonsCubic/Results/PcubicDiff.lean)**, *"whose estimate on `Pcubic2Quad` is now proved in CubicTri.lean while the `HasFDerivAt` statement itself is not"*. Same seven minutes, same commit pair, and this one was written by `631e9235` itself.
5. **[Frechet.lean:40](../lean/HamiltonsCubic/Results/Frechet.lean) and [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean)**, *"which no owed list outside [plan.md](../plan.md) names"*. **[lean/INDEX.md](../lean/INDEX.md)'s `PcubicDiff.lean` row names it**, in its "**NOT stated**" field, which is the record's own owed-list field: *"and the tangent cone at the constraint set"*. *A negative claim about where something is absent, made from a search that did not reach the record's own index.*

**Two smaller ones, recorded without a defect finding.**

- **[Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean)'s `cubicConst_nonneg`**, *"both its summands being sums of self-pairings"*. The second summand is `(1/4) · phiWeight ι ^ 2` and the proof discharges it with `sq_nonneg`, not with a self-pairing argument. *The stated reason is right for one summand of two.*
- **[SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean) writes `‖y‖²` for `normSq2 y` twice**, and `sphereCurve`'s own docstring attributes `normSq2 (a + t·y) = 1 + t²‖y‖²` to orthogonality alone, omitting `normSq2 a = 1`. **The record has been explicit that `‖·‖` at `CurvOp2` is the sup operator norm and that `normSq2 id = ½n(n−1)` against `‖id‖ = 1`**, so these are the two spheres [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) went out of its way to separate.

**Adjacent and outside the four commits, so reported rather than filed**: [plan.md:152](../plan.md)'s I36 OWED list still leads with *"an estimate on `Pcubic2Quad`, which the general-increment expansion names and nothing bounds"*, which `abs_Pcubic2Quad_le` has bounded since `631e9235`.

## What I checked and did not find

**No false theorem, no wrong bound, no missing hypothesis.** `#print axioms` is the standard three on `PcubicDiff`, `PcubicDiff_apply`, `PcubicDiff_eq_lin`, `PcubicDiffS_eq_lin`, `hasFDerivAt_Pcubic2`, `abs_remainder_le`, `sphereCurve_mem`, `sphereCurve_zero`, `normSq2_add_smul`, `normSq2_smul` and `Pcubic2Lin_selfAdjoint`. **The `‖H‖ ≤ 1` hypothesis is used where it is available and nowhere else**, and the `min` in the radius is the only place the two constraints meet.
