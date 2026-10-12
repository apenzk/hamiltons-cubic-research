# r1010: the converse restriction, forced linearity, and the quadratic expansion

**This was a cold brief**, [BRIEF-g2-converse.md](BRIEF-g2-converse.md), read without sight of the work that produced the claims or of what its author concluded. **No numerical work was done and every value here is exact**, the only compute being kernel checks of statements built for this round, run through [lake env lean](../lean/lakefile.toml) at Lean 4.33.1, never a bare `lean`. Log at [agent_logs/r1010.log](../agent_logs/r1010.log).

| # | claim | verdict |
|---|---|---|
| 1 | [isWeyl_add](../lean/HamiltonsCubic/Base/Bivectors2.lean#L360) and [isWeyl_smul](../lean/HamiltonsCubic/Base/Bivectors2.lean#L389): the record's [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) forces linearity | **CONFIRMED**, and the reach is exactly the skew arguments |
| 2 | the consequence claimed for the layer: [IsLinOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L97) free, hence redundant | **CONFIRMED on bivectors, REFUTED as a redundancy** |
| 3 | [restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L597), [isWeyl2_restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L608), and the round trip | **CONFIRMED**, one direction of the round trip holds and the other FAILS |
| 4 | [brS_add_left](../lean/HamiltonsCubic/Base/Bivectors2.lean#L451), [brS_add_right](../lean/HamiltonsCubic/Base/Bivectors2.lean#L459) | **CONFIRMED**, with half of bilinearity left behind |
| 5 | [sharpTerm_add](../lean/HamiltonsCubic/Base/Bivectors2.lean#L480), the quadratic expansion | **CONFIRMED**, and NOT enough for bilinearity |
| 6 | [theta2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L535), [theta2_of_unit](../lean/HamiltonsCubic/Base/Bivectors2.lean#L538), [normSq_extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L256) | **CONFIRMED**, and the link is HALF ON FILE |

**Actionable summary**: strike the redundancy claim at [Bivectors2.lean:353](../lean/HamiltonsCubic/Base/Bivectors2.lean#L353), because [compOp_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean#L143) is FALSE without [IsLinOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L97) at an operator that satisfies [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126), and add the four one-line lemmas this round proved: the round trip `restrict (isWeyl_extend h) = R`, the two [brS](../lean/HamiltonsCubic/Base/Bivectors2.lean#L447) homogeneity lemmas that bilinearity needs, and `Pcubic (extend R) = Pcubic2 R`, without which [theta2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L535) is not yet the record's [theta](../lean/HamiltonsCubic/Base/WeylReal.lean#L180).

## 0. Conventions, fixed once

- `Λ²` is [skewSub](../lean/HamiltonsCubic/Base/Bivectors2.lean#L40), the skew matrices as a submodule of `Matrix ι ι ℝ`, and its addition and scalar action are the matrix ones, with the coercion injective. Nothing below distinguishes a member of `Λ²` from its underlying matrix except where the type does.
- **Off `Λ²`** means at a matrix argument that is not skew. The record's [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) is a predicate on a BARE function `Matrix ι ι ℝ → Matrix ι ι ℝ`, and all four of its clauses read that function at skew arguments alone: clause one is guarded by `IsSkew X`, clause two by `IsSkew X` and `IsSkew Y`, and [bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean#L110) and [Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106) read it on the [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) family alone. **So `IsWeyl` constrains a function only on `Λ²`, and leaves it free elsewhere.**
- [IsLinOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L97) by contrast is `(∀ X Y, R (X + Y) = R X + R Y) ∧ (∀ c X, R (c • X) = c • R X)`, quantified over ALL matrices. That difference in quantifier range is the whole of section 2.
- All arithmetic is exact. The one operator built here is defined by a case split on `IsSkew` and carries no floating point.
- Every positive claim below was kernel-checked and every one carries a control that must fail. **Seven controls were written and all seven were rejected**, each for the reason named against it.

## Hypothesis inventory

| declaration | hypotheses it carries | axioms |
|---|---|---|
| [isWeyl_add](../lean/HamiltonsCubic/Base/Bivectors2.lean#L360) | `IsWeyl R`, `IsSkew X`, `IsSkew Y` | `propext, Classical.choice, Quot.sound` |
| [isWeyl_smul](../lean/HamiltonsCubic/Base/Bivectors2.lean#L389) | `IsWeyl R`, `IsSkew X`, `c` free | `propext, Classical.choice, Quot.sound` |
| [restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L597) | `IsWeyl R`, `Fintype ι`, `DecidableEq ι` | `propext, Classical.choice, Quot.sound` |
| [restrict_apply](../lean/HamiltonsCubic/Base/Bivectors2.lean#L604) | the same, and it is `rfl` | `propext, Classical.choice, Quot.sound` |
| [isWeyl2_restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L608) | `IsWeyl R` | `propext, Classical.choice, Quot.sound` |
| [brS_add_left](../lean/HamiltonsCubic/Base/Bivectors2.lean#L451), [brS_add_right](../lean/HamiltonsCubic/Base/Bivectors2.lean#L459) | none beyond the types | `propext, Classical.choice, Quot.sound` |
| [sharpTerm_add](../lean/HamiltonsCubic/Base/Bivectors2.lean#L480) | none beyond the types | `propext, Classical.choice, Quot.sound` |
| [theta2_of_unit](../lean/HamiltonsCubic/Base/Bivectors2.lean#L538) | `normSq2 R = 1` | `propext, Classical.choice, Quot.sound` |
| [normSq_extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L256), [isWeyl_extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L235) | none, and `IsWeyl2 R` | `propext, Classical.choice, Quot.sound` |

**All eleven are on the standard three axioms, no `sorryAx`**, and the build of [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) and [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) completed over 8713 jobs with warnings only.

## 1. The argument for forced linearity, and its reach

**The argument is correct.** Take `Z = R (X + Y) - R X - R Y`. Clause one of [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) makes each of `R (X + Y)`, `R X` and `R Y` skew, so `Z` is skew. Clause two then applies at the pairs `(X + Y, Z)`, `(X, Z)` and `(Y, Z)`, all four entries skew, and moves `R` across the pairing, so `⟨Z, Z⟩` becomes `⟨X + Y, R Z⟩ - ⟨X, R Z⟩ - ⟨Y, R Z⟩`, which is zero by [inner2_add_right](../lean/HamiltonsCubic/Base/WeylReal.lean#L223) and symmetry. [inner2_self_eq_zero](../lean/HamiltonsCubic/Base/Bivectors2.lean#L91) is a sum of squares over `ℝ` and closes it. [isWeyl_smul](../lean/HamiltonsCubic/Base/Bivectors2.lean#L389) is the same three steps with `c` in place of the second summand. **Both clauses are load-bearing and neither is decorative**: clause one is the only route to `Z` skew, which clause two then requires of its second argument, and clause two is the only thing that collapses the self-pairing. The file's docstring at [line 356](../lean/HamiltonsCubic/Base/Bivectors2.lean#L356) describes exactly this.

**THE REACH IS EXACTLY THE SKEW ARGUMENTS, AND NOTHING FOLLOWS OFF `Λ²`.** The two theorems carry `IsSkew X` and `IsSkew Y` as hypotheses, and those hypotheses cannot be dropped. **The control**: `isWeyl_add hW (X := X) (Y := Y)` applied at free `X` and `Y` leaves `IsSkew X` and `IsSkew Y` as unproved goals and is REJECTED, which is the statement's own reading and not an accident of the script.

**And the failure off `Λ²` is not merely unproved, it is exhibited.** At `ι = Fin 2` put

```
Rbad : Matrix (Fin 2) (Fin 2) ℝ → Matrix (Fin 2) (Fin 2) ℝ := fun X => if IsSkew X then 0 else 1
```

Every clause of [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) holds, each one reading `Rbad` at skew arguments alone where it returns `0`: clause one because `0` is skew, clause two because both sides are `⟨0, ·⟩`, [bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean#L110) and [Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106) because the [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) family is skew. **And additivity fails at the identity matrix**, which is symmetric: `Rbad (1 + 1) = 1` while `Rbad 1 + Rbad 1 = 1 + 1`, and the two differ in entry `(0,0)` as `1` against `2`. **`IsWeyl Rbad ∧ ¬ IsWeylOp Rbad` is kernel-checked on the three standard axioms**, with the control `Rbad ≠ fun _ => 0` also checked so the witness is not the trivial one wearing a case split.

**Verdict: CONFIRMED.** Linearity is forced on `Λ²` and only there, and the negative half is a theorem rather than an absence of proof.

## 2. The consequence claimed for the layer, which is where the round turns

The file says at [line 353](../lean/HamiltonsCubic/Base/Bivectors2.lean#L353) that the record's `IsWeyl` **already forces linearity on `Λ²`**, which the layer does not notice, since [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) carries [IsWeylOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L101) as `IsLinOp ∧ IsWeyl` and **on bivectors the first conjunct is free**.

**The words as written are true.** On bivectors the first conjunct is free, which is section 1.

**The inference a reader takes from them is false, and section 1's own witness refutes it.** [IsLinOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L97) quantifies over ALL matrices, so `IsWeylOp` is strictly stronger than `IsWeyl`, `Rbad` satisfying the second and failing the first. **That is not a technicality about the predicate, because every lemma in the layer that takes `IsLinOp` states its conclusion at an ARBITRARY matrix argument**: [compOp_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean#L143) at every `Z`, [sharpQF_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean#L150) at every `η`, [sharpOp_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean#L177) and [Qop_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean#L190) at every `X`, and [foxProd_self](../lean/HamiltonsCubic/Base/FoxProduct.lean#L234) as an equality of bare FUNCTIONS. Their proofs invoke the hypothesis at matrices that section 1 does not reach, `hR.2 c (R Z)` at free `Z` being the clearest case.

**And the first of them is FALSE without the hypothesis**, which is the finding. At `Rbad`, which is `IsWeyl` and therefore linear on `Λ²`:

- `compOp (2 • Rbad) 1 = 2 • Rbad (2 • Rbad 1) = 2 • Rbad (2 • 1) = 2 • 1`, since neither `1` nor `2 • 1` is skew.
- `2 ^ 2 • compOp Rbad 1 = 4 • Rbad (Rbad 1) = 4 • Rbad 1 = 4 • 1`.
- The two differ in entry `(0,0)` as `2` against `4`.

**`compOp_smul` with `IsLinOp` deleted is a false statement, kernel-checked as a disequality on the three standard axioms.** So `IsLinOp` is load-bearing exactly where the layer uses it, and deleting it is not a simplification but a break.

**Three further points, so the correction is not read as more than it is.**

- **Where the layer INSTANTIATES these lemmas, the arguments are skew.** [Lidem_idemOf](../lean/HamiltonsCubic/Base/FoxProduct.lean#L341) and [foxProd_idemOf_self](../lean/HamiltonsCubic/Base/FoxProduct.lean#L329) apply [Qop_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean#L190) at the [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) family, so a version of each lemma restated with skew arguments and an `IsWeyl` hypothesis would serve the present call sites. **That is a restatement of five lemmas and not a deletion of a predicate**, and the file claims the latter.
- **In HYPOTHESIS position the change runs the other way.** [L98Statement.lean:313](../lean/HamiltonsCubic/Results/L98Statement.lean#L313) quantifies over `IsWeylOp W`, so replacing it by `IsWeyl W` widens the quantifier and STRENGTHENS the proposition rather than simplifying it.
- **Nothing is blocked by the predicate in practice**, since [isLinOp_diagOp](../lean/HamiltonsCubic/Results/L99Statement.lean#L290) discharges it for the only concrete family the layer exhibits.

**The real simplification is the one the file already made, one level up.** On the new domain the question dissolves, because [CurvOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L244) is a `ContinuousLinearMap` and [IsWeyl2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L341) carries three clauses where the record has four. **The saving is in the type, and it is banked already.** What section 1 adds is the CONVERSE, that no record-Weyl operator is lost in the move, which is section 3.

**Verdict: CONFIRMED on bivectors, REFUTED as a redundancy.** The sentence at [line 353](../lean/HamiltonsCubic/Base/Bivectors2.lean#L353) should say that the clause is free on the NEW domain and load-bearing on the old one.

## 3. `restrict`, `isWeyl2_restrict`, and the round trip

**[restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L597) is genuinely the restriction of `R`.** [restrict_apply](../lean/HamiltonsCubic/Base/Bivectors2.lean#L604) is `rfl`, so the underlying function of the bundled operator IS `R` composed with the coercions, with no bridging step. The two fields are section 1's theorems and the codomain membership is clause one of `IsWeyl` applied to `X.2`.

**The continuity is sound and it is Mathlib's, not an appeal to finite dimensions in prose.** [LinearMap.toContinuousLinearMap](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/Algebra/Module/FiniteDimension.html#LinearMap.toContinuousLinearMap) carries `[CompleteSpace 𝕜]`, `[T2Space E]` and `[FiniteDimensional 𝕜 E]` on the DOMAIN together with a topological module structure on both sides, and every one of those is synthesized for `skewSub ι` at a `Fintype` index from the subtype instances of the product topology on matrices. **The elaborated type of [restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L597) is `CurvOp2 ι` with no norm in it**, and it was used in this round OUTSIDE the file's `open scoped Matrix.Norms.Frobenius` and outside `OperatorNorm`. **The control**: `Norm (CurvOp2 (Fin 4))` fails to synthesize in that same context and is REJECTED, so the construction is independent of the scoped instances r1008 found and the scoping repair holds.

**[isWeyl2_restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L608) is the record's three clauses on the nose**, each field the corresponding projection of `hW` with no bridging, which is [r1009](REVIEW_r1009.md)'s reading and reproduces here.

**THE ROUND TRIP HOLDS ONE WAY AND FAILS THE OTHER, AND NEITHER IS ON FILE.**

**`restrict ∘ extend` IS the identity**, proved here in one line from [extend_apply](../lean/HamiltonsCubic/Results/TensorBridge.lean#L214):

```
theorem restrict_extend_id (R : CurvOp2 (Fin n)) (h : IsWeyl2 R) : restrict (isWeyl_extend h) = R :=
  ContinuousLinearMap.ext fun X => Subtype.ext (extend_apply R X)
```

kernel-checked on the three standard axioms. **So the two classes match in both directions as objects and not only as predicates**, which is stronger than what [line 607](../lean/HamiltonsCubic/Base/Bivectors2.lean#L607) claims, and the layer carries no such lemma.

**`extend ∘ restrict` IS NOT the identity, and the failure is exhibited.** [extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L210) precomposes with [skewProj](../lean/HamiltonsCubic/Results/TensorBridge.lean#L192), so `extend (restrict hW)` is `R ∘ skewProj`, which forgets `R` off `Λ²` entirely. At `Rbad` of section 1, `skewProj 1 = 0` and so `extend (restrict Rbad_isWeyl) 1 = Rbad 0 = 0` against `Rbad 1 = 1`. **`extend (restrict Rbad_isWeyl) ≠ Rbad` is kernel-checked.** The control `extend (restrict hW) = R` by `rfl` is REJECTED, so the composite is not even definitionally the input.

**That failure is expected rather than a defect**, since a bare function has data off `Λ²` that `CurvOp2` has nowhere to put, and the honest statement is the one the two files support: the composite AGREES with `R` on `Λ²` and is its canonical skew-projected representative elsewhere. **It does mean [extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L210) and [restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L597) are a retraction and a section, not an isomorphism of the two classes**, and any prose saying the classes correspond should say which of the two it means.

**Verdict: CONFIRMED**, with the round trip resolved in both directions and both lemmas owed.

## 4. `brS_add_left` and `brS_add_right`

**Nothing is lost and nothing is added in the additive half.** The submodule's addition IS the matrix addition and the coercion is injective, so `Subtype.ext` reduces each statement to the matrix-level additivity of [br](../lean/HamiltonsCubic/Base/WeylReal.lean#L42), which is `Matrix.add_mul` and `Matrix.mul_add`. The membership side condition is discharged by [br_mem_skewSub](../lean/HamiltonsCubic/Base/Bivectors2.lean#L298) inside [brS](../lean/HamiltonsCubic/Base/Bivectors2.lean#L447) itself and never surfaces, so the carry is free.

**WHAT IS LOST IS THE OTHER HALF OF BILINEARITY.** The record's `br` is bilinear on matrices, and the layer has the matrix-level homogeneity as [br_smul_right](../lean/HamiltonsCubic/Base/FoxProduct.lean#L130). **On the submodule only additivity is carried**: `brS_smul_left` and `brS_smul_right` are absent, and `#check` on the first reports an unknown identifier, which is the control. **That absence is exactly what section 5 runs into**, so the two items are one gap read at two places.

**Verdict: CONFIRMED**, with the correction that "the record's `br` is bilinear" is carried to the submodule only halfway.

## 5. `sharpTerm_add`, and what bilinearity actually rests on

**The expansion is correct.** Writing `C(A, B)` for the crossed composite `-(1/4) ∑ᵢⱼ ⟨brS A (R (brS B (R φᵢⱼ))), φᵢⱼ⟩`, the definition of [sharpQF2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L469) is `C(η, η)` on the nose, and [sharpTerm_add](../lean/HamiltonsCubic/Base/Bivectors2.lean#L480) is [brS_add_left](../lean/HamiltonsCubic/Base/Bivectors2.lean#L451) on the outer bracket, `map_add` on `R`, and [brS_add_right](../lean/HamiltonsCubic/Base/Bivectors2.lean#L459) on the inner one, in that order. Summing it against the [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) family through [inner2_add_left](../lean/HamiltonsCubic/Base/StructureConstants.lean#L152) gives, kernel-checked here,

```
sharpQF2 R (X + Y) = sharpQF2 R X + C(X, Y) + C(Y, X) + sharpQF2 R Y
```

and therefore, with the `½` of [sharpBil2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L489), `sharpBil2 R X Y = ½(C(X, Y) + C(Y, X))`. **So the polarisation IS the symmetrised cross term and carries no residue**, which is the content the docstring is reaching for.

**IT IS NOT ENOUGH FOR BILINEARITY, AND THE MISSING HALF IS NAMED.** What [sharpTerm_add](../lean/HamiltonsCubic/Base/Bivectors2.lean#L480) supplies is ADDITIVITY, in both slots, and that part is complete: `C` is additive in each slot from the same three lemmas, and `sharpBil2 R (X + Y) Z = sharpBil2 R X Z + sharpBil2 R Y Z` follows, kernel-checked here.

**HOMOGENEITY NEEDS TWO LEMMAS THE FILE DOES NOT CARRY**: `brS (c • X) Y = c • brS X Y` and `brS X (c • Y) = c • brS X Y`. Both are one line by `Subtype.ext` and `Matrix.smul_mul`, `Matrix.mul_smul`, and with them `C(c • X, Y) = c · C(X, Y)` and `C(X, c • Y) = c · C(X, Y)` follow through `map_smul` and [inner2_smul_left](../lean/HamiltonsCubic/Base/FoxProduct.lean#L133), giving `sharpBil2 R (c • X) Y = c · sharpBil2 R X Y`. **All four of these were proved in this round on the three standard axioms**, so the gap is real and small.

**And the consequence for [sharpMap](../lean/HamiltonsCubic/Base/Bivectors2.lean#L513) needs a third thing beyond bilinearity**: the map is a bare function `skewSub ι → skewSub ι`, so "a linear map" means a `LinearMap` bundling that [sharpMap](../lean/HamiltonsCubic/Base/Bivectors2.lean#L513) does not have, and the docstring's "hence `sharpMap` a linear map" is a plan rather than a consequence. [r1008](REVIEW_r1008.md) named that bundling as owed and it remains owed.

**Verdict: CONFIRMED**, with the claim at [line 479](../lean/HamiltonsCubic/Base/Bivectors2.lean#L479) corrected to the additive half, the two `brS` homogeneity lemmas named as what else is needed, and the bundling named as what stands beyond them.

## 6. `theta2`, `theta2_of_unit`, and the link to the record's `theta`

**[theta2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L535)'s denominator is the record's, character for character.** The record has [theta R = Pcubic R / norm R ^ 3](../lean/HamiltonsCubic/Base/WeylReal.lean#L180) with [norm R = Real.sqrt (normSq R)](../lean/HamiltonsCubic/Base/WeylReal.lean#L177), and [theta2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L535) is `Pcubic2 R / Real.sqrt (normSq2 R) ^ 3`, the same composition with the same cube outside the root. **[theta2_of_unit](../lean/HamiltonsCubic/Base/Bivectors2.lean#L538) is correct and its hypothesis is genuinely needed**: the same three-step script with `normSq2 R = 1` deleted is REJECTED, leaving `Pcubic2 R / √(normSq2 R) ^ 3 = Pcubic2 R`, which is the control.

**[normSq_extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L256) is the right link and it is exact.** It rewrites `extend R (φᵢⱼ)` to [applyPhi](../lean/HamiltonsCubic/Base/Bivectors2.lean#L272) through [extend_apply](../lean/HamiltonsCubic/Results/TensorBridge.lean#L214) under the double sum, with the outer `½` of [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135) and [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L276) untouched on both sides. **The control**: the identical script with the right-hand side `2 * normSq2 R` is REJECTED, so the lemma pins the constant and is not an artefact of the rewrite.

**THE LINK IS HALF ON FILE, AND THE MISSING HALF IS THE NUMERATOR.** What [normSq_extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L256) buys, proved here, is

```
theta (extend R) = Pcubic (extend R) / Real.sqrt (normSq2 R) ^ 3
```

so the two denominators ARE the same real number. **`theta (extend R) = theta2 R` does not follow, because `Pcubic (extend R) = Pcubic2 R` has no lemma anywhere in the layer**, and there is no `Pcubic_extend`, `trCube_extend` or `sharpPair_extend`. **The control**: the same script pushed at that identity is REJECTED and leaves exactly `Pcubic (extend R) / √(normSq2 R) ^ 3 = Pcubic2 R / √(normSq2 R) ^ 3` as the residual goal, which names the owed lemma precisely. [r1008](REVIEW_r1008.md) reports proving `Pcubic Rb = Pcubic2 R` at every bare function agreeing with the operator on `Λ²`, so the mathematics is settled and it is the TYPED statement that is absent.

**Verdict: CONFIRMED**, with `Pcubic (extend R) = Pcubic2 R` added to the owed list, and [r1009](REVIEW_r1009.md)'s third owed lemma discharged only on its denominator.

## Overall verdict

**PROVEN (hypotheses corrected).** Every declaration under review is true and kernel-clean on the standard three axioms, and the build is clean. **Two prose claims overreach and one of them is refuted by a witness**: the redundancy of [IsLinOp](../lean/HamiltonsCubic/Base/FoxProduct.lean#L97), which is false at the layer's own type because [compOp_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean#L143) fails without it at an `IsWeyl` operator, and the sufficiency of [sharpTerm_add](../lean/HamiltonsCubic/Base/Bivectors2.lean#L480) for bilinearity, which reaches the additive half alone. **Four one-line lemmas are owed and all four were proved in this round**: `restrict (isWeyl_extend h) = R`, `brS_smul_left`, `brS_smul_right`, and the numerator half of the `θ` link, `Pcubic (extend R) = Pcubic2 R`.
