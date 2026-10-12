# r1020: the FoxBridge crossing, `I36Shape`'s restated sphere, and the r1019 fold

**Cold brief, no numerical work, every value exact.** The one machine run beyond the build is a kernel SCREEN I constructed for section 4, reported as a screen. All Lean checks went through [lake env lean](../lean/lakefile.toml) at Lean 4.33.1, the project toolchain, after a full [lake build](../lean/) that completed with exit 0. Log: [agent_logs/r1020.log](../agent_logs/r1020.log).

| # | claim | verdict |
|---|---|---|
| 1 | [extend_add](../lean/HamiltonsCubic/Results/CubicBridge.lean#L273), [extend_smul](../lean/HamiltonsCubic/Results/CubicBridge.lean#L277), [innerOp_extend](../lean/HamiltonsCubic/Results/CubicBridge.lean#L282), [extend_add'](../lean/HamiltonsCubic/Results/FoxBridge.lean#L31) | **CONFIRMED.** The two `rfl`s say what they appear to, over genuinely different additions on the two types, and the `funext` is sound. Two of the four have no consumer anywhere in the tree |
| 2 | [foxTri_extend](../lean/HamiltonsCubic/Results/FoxBridge.lean#L49) | **CONFIRMED, CONSTANTS INCLUDED.** Four constants are matched pairwise across the layers and the proof closes by `rw` alone, which is available only if they agree |
| 3 | [foxTri_symm_right_extend](../lean/HamiltonsCubic/Results/FoxBridge.lean#L67), [isSelfAdjoint2_restrict](../lean/HamiltonsCubic/Results/FoxBridge.lean#L77) | **CONFIRMED, AND IT IS THE RIGHT CLAUSE.** `hW.2.1` is [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)'s self-adjointness clause. The declaration duplicates [isWeyl2_restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L874)'s own `selfAdjoint` field, term for term |
| 4 | **THE REACH OF (A): is the debt discharged** | **STILL NOT DISCHARGED, AND THE REACH SENTENCE OVER-CLAIMS.** The image of `extend` is a PROPER subset of the operators factoring through [skewProj](../lean/HamiltonsCubic/Results/TensorBridge.lean#L192), which I screened in the kernel. The debt's consumers, [RayleighLE](../lean/HamiltonsCubic/Base/FoxProduct.lean#L370) and [RayleighGE](../lean/HamiltonsCubic/Base/FoxProduct.lean#L376), quantify over BARE `IsWeylOp` operators, and no declaration carries `foxTri` from such an operator to its re-extension |
| 5 | **IS (B) THE RIGHT REPAIR, AND THE DIRECTION** | **RIGHT REPAIR, RIGHT DIRECTION, ONE UNSUPPORTED CLAUSE.** The Weyl sphere is what the record's item means, the kernel fixes the direction, and the prose describes [I36Shape_imp_fullSphere](../lean/HamiltonsCubic/Results/TensorBridge.lean#L331) correctly. *"and does not imply it"* has no argument on file, at three sites |
| 6 | **DID (B) BREAK ANYTHING** | **NOTHING IN THE KERNEL, ONE PAIRING IN PROSE.** `I36Shape` had no consumer, confirmed. [I36Budget](../lean/HamiltonsCubic/Results/TensorBridge.lean#L336) was left on the full sphere and so now carries the very defect (B) struck, and the equivalence [r1009](REVIEW_r1009.md) proved between the two survives in one direction only |
| 7 | the `_hX` drop on [foxTri2_symm_right](../lean/HamiltonsCubic/Results/FirstVariation.lean#L113) | **CONFIRMED.** Still true, kernel-clean, and its one consumer in the tree supplies exactly the two remaining binders |
| 8 | vacuity of the new `I36Shape` at `n ≥ 4` | **UNCHANGED, AND THE DOCSTRING READS STRONGER THAN WHAT IS ESTABLISHED.** The new clause makes the hypotheses EASIER to meet, so r1009's witness carries over a fortiori. That witness met two of the four hypotheses and still does |
| 9 | `#print axioms` | **CLEAN.** All twelve declarations on `[propext, Classical.choice, Quot.sound]`, under the project toolchain |
| 10 | prose outrunning its evidence | **THREE CLAIMS THE KERNEL CONTRADICTS, ONE OVER-CLAIMED REACH, ONE UNSUPPORTED NON-IMPLICATION.** [lean/INDEX.md](../lean/INDEX.md)'s row 141 still carries two claims the fold under audit struck from row 140, plus a `sorryAx` attribution that `#print axioms` refutes |

**Actionable in one line: strike row 141's three stale claims in [lean/INDEX.md](../lean/INDEX.md), move [I36Budget](../lean/HamiltonsCubic/Results/TensorBridge.lean#L336) onto the Weyl sphere, and either prove `foxTri_eq_foxTri2_restrict` at record-Weyl arguments or stop saying the reach costs nothing.**

## 0. Conventions, fixed once

`ι = Fin n` throughout. The **bare layer** is [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) and [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean): operators are functions `Matrix ι ι ℝ → Matrix ι ι ℝ`, the sharp is [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L153), the class is [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) with four clauses. The **bundled layer** is [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean): operators are `CurvOp2 ι = skewSub ι →L[ℝ] skewSub ι`, the sharp is [sharpMap](../lean/HamiltonsCubic/Base/Bivectors2.lean#L694), the class is [IsWeyl2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L352) with three clauses, the fourth being the type.

Λ² means the skew matrices, `skewSub ι`. [skewProj](../lean/HamiltonsCubic/Results/TensorBridge.lean#L192) is `X ↦ ½(X − Xᵀ)`, idempotent and the identity on Λ². [extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L210) precomposes a `CurvOp2` operator with it, [restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L863) cuts a record-Weyl bare operator down to Λ².

"Discharged" means a declaration in the tree has the statement the debt names, at the types the debt's own consumers use. A statement true at a subclass is recorded here as true at that subclass.

## Hypothesis inventory

| declaration | hypothesis | what it buys | verdict |
|---|---|---|---|
| [foxTri_symm_right_extend](../lean/HamiltonsCubic/Results/FoxBridge.lean#L67) | `IsSelfAdjoint2 B`, `IsSelfAdjoint2 C` | the two binders [foxTri2_symm_right](../lean/HamiltonsCubic/Results/FirstVariation.lean#L113) needs, the Jordan half's trace reading and the `Φ` half's rotation | **ESSENTIAL, AND EXACTLY TWO**, section 3 |
| [foxTri_symm_right_extend](../lean/HamiltonsCubic/Results/FoxBridge.lean#L67) | all three arguments are `extend` of something | the whole of the statement's reach | **THIS IS THE COST**, section 4: the consumers of the debt are bare `IsWeylOp` operators |
| [isSelfAdjoint2_restrict](../lean/HamiltonsCubic/Results/FoxBridge.lean#L77) | `IsWeyl R` | clause two, `hW.2.1`, and clause one through `restrict`'s own definition | **ESSENTIAL AND CORRECTLY PROJECTED**, section 3 |
| [I36Shape](../lean/HamiltonsCubic/Results/TensorBridge.lean#L311) | `IsLocalMaxOn` over `{S \| IsWeyl2 S ∧ normSq2 S = 1}` | the record's own Weyl sphere | **ESSENTIAL AND NOW CORRECT**, section 5 |
| [I36Budget](../lean/HamiltonsCubic/Results/TensorBridge.lean#L336) | `IsLocalMaxOn` over `{S \| normSq2 S = 1}` | a strictly stronger hypothesis than `I36Shape`'s, so a strictly weaker claim | **THE DEFECT (B) STRUCK, LEFT IN PLACE**, section 6 |

## 1. The four crossing lemmas

[extend_add](../lean/HamiltonsCubic/Results/CubicBridge.lean#L273) reads `extend (A + B) X = extend A X + extend B X` and is `rfl`. The two `+` signs are different operations: on the left it is addition of continuous linear maps on `skewSub`, on the right pointwise addition of bare matrix functions. The `rfl` holds because `(A + B) x` unfolds to `A x + B x` and the coercion of a `skewSub` sum is the sum of the coercions, both by definitional unfolding of the subtype. **The statement is quantified over ALL `X`, not over bivectors**, which is right: `skewProj` sits inside `extend`, so additivity holds off Λ² as well. [extend_smul](../lean/HamiltonsCubic/Results/CubicBridge.lean#L277) is the same argument with the scalar action.

[extend_add'](../lean/HamiltonsCubic/Results/FoxBridge.lean#L31) is `funext (extend_add A B)`. `extend_add A B` is `∀ X, extend (A + B) X = extend A X + extend B X`, and `funext` turns it into `extend (A + B) = fun X => extend A X + extend B X`, which is the stated `extend A + extend B` by `Pi.add`'s own definition. **The `funext` is sound**, and it is what [foxProd_extend](../lean/HamiltonsCubic/Results/FoxBridge.lean#L35) needs: the `← extend_add'` rewrite folds `extend A + extend B` back into `extend (A + B)` so that [Qop_extend](../lean/HamiltonsCubic/Results/CubicBridge.lean#L109) applies to all three `Qop` terms.

[innerOp_extend](../lean/HamiltonsCubic/Results/CubicBridge.lean#L282) is the pairing crossing. [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135) is `½ ∑ᵢⱼ ⟨R φᵢⱼ, S φᵢⱼ⟩` and [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279) is `½ ∑ᵢⱼ ⟨applyPhi R i j, applyPhi S i j⟩`, the same constant and the same index range, so the proof is `congr 1` followed by two applications of [extend_apply](../lean/HamiltonsCubic/Results/TensorBridge.lean#L214). Correct, and it is the off-diagonal of the already-proved [normSq_extend](../lean/HamiltonsCubic/Results/TensorBridge.lean#L256), as its docstring says.

**Two of the four have no consumer in the tree.** `extend_smul` and `innerOp_extend` are named nowhere outside their own file and the index row. `extend_add` is used through `extend_add'`. That is a remark and not a defect.

## 2. `foxTri_extend` and the constants

The claim is `T(extend A, extend B, extend C) = T₂(A, B, C)`. Four constants have to line up, and they do, pairwise:

| quantity | bare layer | bundled layer |
|---|---|---|
| the pairing | [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135), `½ ∑∑` | [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279), `½ ∑∑` |
| the sharp quadratic form | [sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean#L102), `−¼ ∑∑` | [sharpQF2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L498), `−¼ ∑∑` |
| the sharp operator | [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L153), `½ ∑∑` | [sharpMap](../lean/HamiltonsCubic/Base/Bivectors2.lean#L694), `½ ∑∑` |
| the Fox product | [foxProd](../lean/HamiltonsCubic/Base/FoxProduct.lean#L208), `½(Q(X+Y) − QX − QY)` | [foxProd2](../lean/HamiltonsCubic/Results/FirstVariation.lean#L57), `½(Q₂(X+Y) − Q₂X − Q₂Y)` |

**The proof gives a second, independent confirmation that they agree.** It unfolds `foxTri`, `foxTri2`, `innerOp` and `innerOp2`, rewrites the summand by a pointwise `Finset.sum_congr`, and stops. A `rw` closes its goal by `rfl`, so the two surviving prefactors must be the same term. A mismatch of any constant would have left a residual goal. The chain under it is `sharpQF_extend`, `sharpBil_extend`, [sharpOp_extend](../lean/HamiltonsCubic/Results/CubicBridge.lean#L56) and then [Qop_extend](../lean/HamiltonsCubic/Results/CubicBridge.lean#L109), each already audited and each on the standard three axioms.

**[foxTri](../lean/HamiltonsCubic/Base/FoxProduct.lean#L284) takes no hypothesis on its arguments and neither does `foxTri_extend`.** That is the right shape: the identity is between two definitions and holds at every `CurvOp2` triple, Weyl or not.

## 3. The symmetry transfer and the `IsWeyl` clause

[foxTri_symm_right_extend](../lean/HamiltonsCubic/Results/FoxBridge.lean#L67) is two rewrites by `foxTri_extend` and then [foxTri2_symm_right](../lean/HamiltonsCubic/Results/FirstVariation.lean#L113). Correct, and its two hypotheses are that theorem's two, unchanged.

[isSelfAdjoint2_restrict](../lean/HamiltonsCubic/Results/FoxBridge.lean#L77) is `fun X Y => hW.2.1 ↑X ↑Y X.2 Y.2`. **This is the right clause.** [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) is a right-nested conjunction of four clauses, so `hW.2.1` is clause two, `∀ X Y, IsSkew X → IsSkew Y → ⟨R X, Y⟩ = ⟨X, R Y⟩`, which is exactly [IsSelfAdjoint2](../lean/HamiltonsCubic/Results/TraceOp.lean#L178) read through [restrict_apply](../lean/HamiltonsCubic/Base/Bivectors2.lean#L870), itself `rfl`. Clause one is used too, silently, inside `restrict`'s own construction, which is where the codomain comes from.

**One redundancy, recorded and not a defect.** [isWeyl2_restrict](../lean/HamiltonsCubic/Base/Bivectors2.lean#L874) already has the field `selfAdjoint X Y := hW.2.1 _ _ X.2 Y.2`, the identical term, and [IsWeyl2.isSelfAdjoint2](../lean/HamiltonsCubic/Results/TraceOp.lean#L183) projects it out. So `isSelfAdjoint2_restrict` is `(isWeyl2_restrict hW).isSelfAdjoint2` written again. It is correct either way.

## 4. THE REACH, AND WHETHER THE DEBT IS DISCHARGED

### 4.1 What the debt says

[FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s *"What is owed, and deliberately absent rather than `sorry`-ed"* section, first bullet, verbatim from lines 61 to 64:

> - **Full symmetry of `T`**, hence self-adjointness of `L_e`. Only `foxTri_comm`, symmetry in the
>   first two slots, which is `∘`'s commutativity, is proved. The record derives the third slot from
>   the symmetrisation of `tr(XYZ)` and from the two antisymmetric `c`'s of `#`; that derivation
>   needs `sharpOp` to *be* `R#`, which is WeylReal's own standing obligation.

### 4.2 The reach characterisation is right in its name and wrong in its sentence

**"AT EXTENSIONS" is the correct name for the reach.** The statement quantifies over `A B C : CurvOp2 (Fin n)` and every argument slot of the bare `foxTri` is filled by `extend` of one of them, so the operators it speaks about are exactly the image of `extend`. That is what the docstring and the index row both say, and it is right.

**The sentence that explains it is not.** [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean) lines 16 to 18 read:

> *What it does NOT give is the symmetry at an arbitrary bare operator*, since `extend` is not surjective: its image is the operators that factor through `skewProj`, which [r1010] recorded when it found `extend (restrict hW) = R ∘ skewProj` rather than `R`.

The image of `extend` is a PROPER subset of the operators factoring through `skewProj`, and the inclusion is strict for two independent reasons: every value of `extend A` lies in Λ² by construction, and `extend A` is linear on Λ². An operator factoring through `skewProj` need satisfy neither.

**Located, exhibited, and the opposite argued.** Located: the noun phrase *"its image is the operators that factor through `skewProj`"*. Exhibited, and I screened it in the kernel rather than asserting it: at `n = 2` the constant map `X ↦ 1` is `(fun _ => 1) ∘ skewProj` by `rfl`, so it factors through `skewProj`, and it is not `extend A` for any `A`, because every value of `extend A` is skew while the identity matrix has `1 ≠ −1` at entry `(0,0)`. The three declarations compile and `const_one_not_extend` is on `[propext, Classical.choice, Quot.sound]`. *A screen on objects I constructed, reported as a screen.* The strongest opposite reading is that "the operators" is meant inside the class already under discussion, the operators on Λ² carried to bare form. The sentence's own subject is *"an arbitrary bare operator"*, so the ambient class is the bare functions, and under that reading the identification is a strict inclusion. **The direction matters**: the sentence makes the image look LARGER than it is, which makes the theorem look stronger.

### 4.3 The debt is still not discharged, and here is exactly what is missing

**The consumers of the debt are BARE operators.** [RayleighLE](../lean/HamiltonsCubic/Base/FoxProduct.lean#L370) and [RayleighGE](../lean/HamiltonsCubic/Base/FoxProduct.lean#L376) quantify over `X : CurvOp ι` with `IsWeylOp X`, and evaluate `foxTri (idemOf W θ) X X` at [idemOf](../lean/HamiltonsCubic/Base/FoxProduct.lean#L307) `W θ = θ⁻¹ • W` for a bare `W`. None of these is `extend` of anything, so `foxTri_symm_right_extend` does not apply to any of them, and `isSelfAdjoint2_restrict` does not close the distance: it supplies a hypothesis, not an argument slot. Given `hW : IsWeyl B`, the best the file reaches is the symmetry at `extend (restrict hW)`, which [r1010](REVIEW_r1010.md) recorded is `B ∘ skewProj` and not `B`.

**What would discharge it is one declaration**, and it is one the file can state:

```lean
theorem foxTri_eq_foxTri2_restrict {X Y Z : CurvOp (Fin n)}
    (hX : IsWeyl X) (hY : IsWeyl Y) (hZ : IsWeyl Z) :
    foxTri X Y Z = foxTri2 (restrict hX) (restrict hY) (restrict hZ)
```

from which `foxTri X Y Z = foxTri X Z Y` at record-Weyl arguments follows in two rewrites and `foxTri2_symm_right`. **That is the statement the debt's own consumers need, and it is absent.**

### 4.4 The "reads its arguments only on bivectors" claim, checked

The record offers this as the reason the non-surjectivity is harmless. **It is true given [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)'s first clause and false without it.** Unfolding: `foxTri X Y Z = ½ ∑ᵢⱼ ⟨foxProd X Y φᵢⱼ, Z φᵢⱼ⟩`, so `Z` is read only at the `φ` family, which are bivectors. `foxProd X Y φᵢⱼ` calls `Qop` at `X`, `Y` and `X + Y`, and `Qop V W = V (V W) + sharpOp V W`. The inner `V W` is a bivector when `W` is only if `V` carries clause one, and clause one is closed under sums, so `X + Y` carries it when `X` and `Y` do. In `sharpOp`, the arguments of `V` are `V φᵢⱼ` and `br η (V φᵢⱼ)` at `η` ranging over sums of bivectors, and the bracket of two skew matrices is skew, so every one of them is a bivector under the same clause. **Without clause one the claim fails**: at a bare `X` sending bivectors to symmetric matrices, `X (X φᵢⱼ)` reads `X` off Λ², and changing `X` there changes `foxTri X X Z`.

**The file scopes it and the commit message does not.** [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean#L77)'s version sits inside a docstring whose hypothesis is `hW : IsWeyl R`, which is defensible. `lean/INDEX.md`'s row 135 states it unqualified, as does the commit message of `e2e93d0f`. **And no declaration anywhere carries it**, in either form. So the claim that the reach *"costs nothing here"* rests on an unformalised lemma about a class the sentence does not name.

**Verdict on 4: the reach is correctly named, its explanatory sentence over-claims, and the debt is NOT discharged.**

## 5. IS (B) THE RIGHT REPAIR, AND IS THE DIRECTION RIGHT

### 5.1 The direction, which the kernel settles

[I36Shape_imp_fullSphere](../lean/HamiltonsCubic/Results/TensorBridge.lean#L331) is `h R hW hN (hmax.on_subset (fun S hS => hS.2)) ht`. Reading it: `hmax` is full-sphere maximality, `IsLocalMaxOn.on_subset` takes a maximum on `s` to a maximum on any `t ⊆ s`, and `fun S hS => hS.2` proves `{S | IsWeyl2 S ∧ normSq2 S = 1} ⊆ {S | normSq2 S = 1}`. So the Weyl-sphere hypothesis is DERIVED from the full-sphere one, which makes it the weaker hypothesis and `I36Shape` the stronger statement. **The kernel accepts the term, so the direction is fixed by something better than an argument about competitors.**

### 5.2 Is the argument sound

**Yes, on the half that is stated as reasoning.** A local maximum over a smaller set is a weaker condition, because fewer points have to be beaten, so the hypothesis is easier to satisfy, so the implication with that hypothesis is harder to prove and therefore stronger. The docstring's *"since there are fewer competitors to beat"* is the right reason, and the theorem beside it is the right check on the reason.

**The prose describes the kernel-proved theorem correctly.** The docstring says *"AND `I36Shape` IMPLIES IT"*, and the signature is `I36Shape n t → I36ShapeFullSphere n t`. The commit message, `plan.md` and `ATTEMPTS.md` say the same thing in the same direction. I found no site where the implication is stated backwards.

### 5.3 The one clause with no argument on file

The docstring, `plan.md` line 148, `ATTEMPTS.md` line 8382 and the commit message all carry the same second half: **the old form *"was implied by the record's item and does not imply it"***. The first conjunct is the theorem. **The second conjunct has no argument on file, at any of the four sites.**

It is not a small gap. To establish that `I36ShapeFullSphere n t` fails to entail `I36Shape n t`, one needs an `n` and a `t` at which the full-sphere form holds and the Weyl-sphere form fails. The second half requires exhibiting a unit Weyl operator, a local maximiser of `Pcubic2` on the Weyl sphere, above `t`, that is coordinate-diagonal in no frame. **At the record's own `t = √(3/2)` that is a refutation of I36 itself**, the item this layer exists to state. At other `t` it may be cheaper, through vacuity of the full-sphere hypothesis, but nothing on file establishes that vacuity either: it would need `Ric(Q(W)) = 0` at Weyl `W`, which [plan.md](../plan.md) lists in I36's own OWED list as the fact *"without which criticality on the Weyl sphere is only `proj_𝒲 Q(W) = θW`"*.

**This is [Proposal 150](../.claude/skill-proposals.md)'s shape exactly**: a sufficiency claim is right, and an exclusivity clause is welded onto the sentence that states it, unchecked, because that sentence is the one that got the mathematics right. *The fix is one word: "the full-sphere form follows from the item" is a complete sentence.*

### 5.4 Does the new constraint set match the record's I36

**Yes.** [plan.md](../plan.md)'s item reads *"I36, every local maximiser above √(3/2) is coordinate-diagonal"*, and the object being maximised is Problem P's, `P` on the unit sphere of `𝒲ₙ`. [findings/diagonal-half.md](../findings/diagonal-half.md)'s I36 section is about the same object throughout, its `L174` reframing turning *"diagonal in some frame"* into `κ² = 2` **at a maximiser of the same problem**. `{S | IsWeyl2 S ∧ normSq2 S = 1}` is the unit sphere of `𝒲ₙ` read at this domain, `IsWeyl2` being neither wider nor narrower than the record's class ([r1009](REVIEW_r1009.md) section 2). **The old set was the unit sphere of all of `End(Λ²)`, which the record names nowhere.** So (B) is the right repair.

One point the repair leaves standing and did not introduce: `t < Pcubic2 R` is the item's `θ > t` only through `θ = P` at unit norm, an identity [r1009](REVIEW_r1009.md) found the layer does not carry. Still absent.

**Verdict on 5: RIGHT REPAIR, RIGHT DIRECTION, one clause with no argument on file.**

## 6. DID (B) BREAK ANYTHING

### 6.1 `I36Shape` had no consumer, confirmed

Grepping the whole tree outside `reviews/`, `I36Shape` appears in [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) as its own definition and inside two neighbouring docstrings, in [CubicBridge.lean](../lean/HamiltonsCubic/Results/CubicBridge.lean) inside two docstrings, in one screening script's docstring, and in prose in `plan.md`, `ATTEMPTS.md` and `scripts/INDEX.md`. **No theorem in the tree consumes it.** The equivalence `I36Shape ↔ I36Budget` that [r1009](REVIEW_r1009.md) row 6 proved was proved in that reviewer's own scratch and was never committed, which is why the kernel noticed nothing. So the commit's *"nothing consumed `I36Shape`"* is correct.

### 6.2 `I36Budget` was left carrying the struck defect

[I36Budget](../lean/HamiltonsCubic/Results/TensorBridge.lean#L336) still reads `IsLocalMaxOn Pcubic2 {S : CurvOp2 (Fin n) | normSq2 S = 1} R`. **That is the full sphere, the exact clause (B) removed from `I36Shape` six lines above, and the same reasoning applies to it unchanged**: the full-sphere form is the weaker of the two budget statements, it is implied by the record's item, and proving it would not prove the item. The file gives no reason for the asymmetry, and the commit message does not mention `I36Budget` at all.

Whether the two are *"inconsistent"*: they are not contradictory, both can be true, and neither is now derivable from the other in one step. **What they are is no longer a matched pair.**

### 6.3 The `shape_iff_budget` pairing, which the docstring claims

`I36Budget`'s docstring reads *"The budget form, which [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s `shape_iff_budget` pairs with the shape."*

[shape_iff_budget](../lean/HamiltonsCubic/Results/L174.lean#L58) is ABSTRACT: it is parametrised by `IsUnit`, `IsLocalMax`, `theta`, `kappaSq` and `IsCoordDiagonal`, and it pairs `I36_shape` with `I36_budget` **at the same `IsLocalMax`**. Nothing in the tree instantiates it at the two `TensorBridge` definitions, so nothing broke in the kernel. But the claim itself is now false for the concrete pair: to instantiate `shape_iff_budget` at `I36Shape` and `I36Budget` one must supply a single `IsLocalMax`, and after (B) the two definitions use different ones. **Before (B) the pairing claim was true and uninstantiated. After (B) it is false and uninstantiated.**

The same applies to [r1009](REVIEW_r1009.md)'s row 6, which proved `I36Shape n t ↔ I36Budget n t` from [kappaSq_eq_iff](../lean/HamiltonsCubic/Results/L94Statement.lean). That proof is pointwise in `R` and preserves whatever hypotheses sit in front, so what it establishes now is `I36ShapeFullSphere n t ↔ I36Budget n t`. **Composed with `I36Shape_imp_fullSphere` it gives `I36Shape n t → I36Budget n t` and nothing back.** The biconditional r1009 recorded is now one-directional, and no file says so.

**Verdict on 6: nothing broke in the kernel, and the repair was applied to one of a matched pair.**

## 7. The `_hX` drop

[foxTri2_symm_right](../lean/HamiltonsCubic/Results/FirstVariation.lean#L113) now reads `(X Y Z : CurvOp2 ι) (hY : IsSelfAdjoint2 Y) (hZ : IsSelfAdjoint2 Z)`.

**Still true**, and the kernel says so: it builds and `#print axioms` returns the standard three. Reading the proof, `hY` is used in `htr1` and in `hphi2`, `hZ` in `htr2` and `hphi2`, and `X` appears in no hypothesis position. **Dropping an unused binder strictly strengthens a theorem**, since the conclusion is unchanged and one premise is gone, so nothing that held before can fail now.

**Still what consumers want.** The only consumer in the tree is [foxTri_symm_right_extend](../lean/HamiltonsCubic/Results/FoxBridge.lean#L67), which calls `foxTri2_symm_right A B C hB hC` and supplies exactly the two remaining binders. The earlier fold's own defence of the third binder, *"that is the form the consumers want"* ([ATTEMPTS.md](../ATTEMPTS.md) line 8366's neighbourhood), was wrong on the facts even then: the only consumer built since supplies two.

**Verdict on 7: CONFIRMED.**

## 8. VACUITY AT `n ≥ 4`

**The restriction makes the hypotheses EASIER to meet, not harder, so nothing r1009 established can have been lost.** This is the same `IsLocalMaxOn.on_subset` fact as section 5.1, read at a point instead of at a statement: any `R` satisfying the old local-maximality clause satisfies the new one, because full-sphere maximality implies Weyl-sphere maximality. **So every witness for the old hypothesis set is a witness for the new one, a fortiori.** The new clause cannot make the hypotheses harder to meet in any way that matters, or in any way at all.

**What r1009 actually established is narrower than the docstring implies, and that is unchanged by (B).** [r1009](REVIEW_r1009.md) section 5 exhibits the restriction of `diagOp ((√12)⁻¹ • sphereWeight {0,1})` at `n = 4` and proves `IsWeyl2 R ∧ normSq2 R = 1`, **two of the four hypotheses**. Its own text says so: *"The witness meets two of the four hypotheses. Whether a unit Weyl operator can ALSO be a local maximiser with θ above √(3/2) is the record's own question ... Deciding it in general would be a census of maximisers and I did not open one."*

**The docstring reads stronger than that, and reads stronger still against the record's own findings.** [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) lines 308 to 310 juxtapose *"the hypotheses are empty at `n ≤ 3` ... At `n ≥ 4` r1009 exhibited a witness"*, which invites the reading that the hypotheses are non-empty from `n = 4`. They are not known to be. And at `n = 4` specifically, [findings/diagonal-half.md](../findings/diagonal-half.md) line 1200 records that `θ` is capped at `θ₀(4) = √3/2 < √(3/2)` on the coordinate-diagonal locus and concludes *"I36's hypothesis θ > √(3/2) is vacuous there"*. **So at the item's own threshold the full hypothesis set is EMPTY at `n = 4`**, by the record's own finding, and the sentence that pairs the emptiness at `n ≤ 3` against a witness at `n ≥ 4` is drawing a line in the wrong place. That paragraph predates commit (B), which moved the definition under it without re-reading it.

**Verdict on 8: NON-VACUITY UNCHANGED, in the two-hypothesis sense r1009 established and in no stronger sense.**

## 9. `#print axioms`

Run under `lake env lean`, on the project toolchain, Lean 4.33.1 commit `819816b2`, after a full `lake build` at exit 0. All twelve on `[propext, Classical.choice, Quot.sound]`, no `sorryAx`:

`extend_add`, `extend_smul`, `innerOp_extend`, `extend_add'`, `foxProd_extend`, `foxTri_extend`, `foxTri_symm_right_extend`, `isSelfAdjoint2_restrict`, `I36Shape`, `I36ShapeFullSphere`, `I36Shape_imp_fullSphere`, `I36Budget`.

Four more, run because section 10 turns on them: `hasDerivAt_Pcubic2_line`, `foxTri2_symm_right`, `phiTri_rotate` and `phiTri_starred`, all four on the same standard three.

**Verdict on 9: CLEAN.**

## 10. PROSE CLAIMING MORE THAN IS ESTABLISHED

### 10.1 Three claims in `lean/INDEX.md`'s row 141 that the kernel contradicts

The fold under audit struck four stale claims and corrected row 140. **Row 141, the [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) row, still carries three claims that row 140 five lines above it now contradicts.**

| quoted from row 141 | why it is false |
|---|---|
| *"the proofs are the next Opus task"* | both are proved, in the commit that row 140 describes |
| *"it carries `sorryAx` by INHERITANCE alone, through `phiTri_first_variation` to `phiTri_rotate`"* | `#print axioms hasDerivAt_Pcubic2_line` returns the standard three, section 9 |
| *"So the whole first variation of `P` rests on that one unproved rotation"* | `phiTri_rotate` is on the standard three, section 9, and row 140's own text says *"NOTHING IN THE FIRST VARIATION OF `P` RESTS ON A `sorry`"* |

**And a fourth, which is the claim [r1019](REVIEW_r1019.md) was convened to refute.** Row 141 still reads that `foxTri2_symm_right` *"with `foxTri2_comm` (proved, no hypothesis) is the full symmetry [FoxProduct.lean] records as owed"*. Row 140 carries the correction, *"a first version of this row said it discharges FoxProduct.lean's recorded debt ... that file's `foxTri` is over BARE operators"*. **Two adjacent rows of one file now say opposite things about one theorem.** The fold's own commit message says it struck *"an index row reading partial over a file with no sorry"*, so index rows were in scope and this one was not read.

### 10.2 The reach over-claim, section 4.2

*"its image is the operators that factor through `skewProj`"*, in [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean) lines 16 to 18. A strict inclusion, screened in the kernel, and it flatters the theorem.

### 10.3 The non-implication, section 5.3

*"which is implied by the record's item and does not imply it"*, at four sites: the [I36Shape_imp_fullSphere](../lean/HamiltonsCubic/Results/TensorBridge.lean#L331) docstring, [plan.md](../plan.md) line 148, [ATTEMPTS.md](../ATTEMPTS.md) line 8382 and the commit message of `b98e3803`. **This claim has no argument on file**, and establishing it at the record's own threshold would refute I36.

### 10.4 The `shape_iff_budget` pairing, section 6.3

*"The budget form, which L174.lean's `shape_iff_budget` pairs with the shape"*, in [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean#L335). True before (B), false after it, and untouched by the commit that falsified it.

### 10.5 The bivector-reading claim, section 4.4

*"which costs nothing here because `foxTri` reads its arguments only on bivectors"*, in `lean/INDEX.md` row 135 and in `e2e93d0f`'s commit message. True given `IsWeyl`'s first clause, false without it, stated unqualified at both sites, and carried by no declaration.

### 10.6 Outside the named scope, recorded because it bears on section 9

The working tree's uncommitted [plan-lean.md](../plan-lean.md) is a regeneration by another session that ADDS rows listing `foxTri2_symm_right` and `phiTri_starred` as owing their proofs, and raises the sorry count from 58 to 60. **`#print axioms` puts both on the standard three**, section 9. This is another thread's uncommitted work and outside the three commits under audit, so it is flagged rather than filed against them.

**Verdict on 10: FIVE CLAIMS FOUND, one of them a direct kernel contradiction repeated three ways.**

## Overall verdict

**GAP.**

The eight new declarations of (A) are correct, their constants are matched across the two layers, and all twelve audited declarations are kernel-clean on the standard three axioms. The restatement (B) is the right repair in the right direction, and the kernel fixes that direction rather than the prose. The `_hX` drop (C) is a strict strengthening and its one consumer wants the weaker form.

**What is owed, in the order the report reaches it:**

1. `foxTri_eq_foxTri2_restrict` at record-Weyl bare arguments, section 4.3, without which [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s debt stands and its consumers are untouched.
2. `I36Budget` on the Weyl sphere, section 6.2, and a line saying which direction of r1009's biconditional survives.
3. Row 141 of [lean/INDEX.md](../lean/INDEX.md), section 10.1, three claims the kernel refutes and one the last review refuted.
4. The two over-claims of sections 4.2 and 4.4, each of which makes the reach look larger than it is.
5. The non-implication of section 5.3, which is either dropped or stated as an open question.
