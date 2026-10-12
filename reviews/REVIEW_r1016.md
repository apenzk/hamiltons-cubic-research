# r1016: the first-variation Lean layer, from `innerOp2` bilinearity to `hasDerivAt_Pcubic2_line`

Cold brief, sole reviewer, so every finding below is a claim whose reach is stated with it rather than a verdict. No numerical work was done beyond one screen, declared in section 1 and reported as a screen. Every value in this report is exact rational arithmetic. The three files were read in full off disk, the project built clean under `lake build`, and every axiom check ran through `lake env lean` on the project toolchain (Lean 4.33.1, commit `819816b2`). Log: [agent_logs/r1016.log](../agent_logs/r1016.log).

| # | claim | verdict |
|---|---|---|
| 1 | `innerOp2`'s four bilinearity lemmas correct and complete, and `innerOp2_eq_trOp_right`'s hypothesis on the second argument | **CORRECT AND COMPLETE** |
| 2 | `compOp2_add` and `compOp2_line` are the right expansions | **CORRECT, AND NEITHER OWES A HYPOTHESIS** |
| 3 | `trCube2_line`'s four coefficients | **ALL FOUR CORRECT** |
| 4 | `hasDerivAt_cubic` states what it should | **CORRECT, AND STATED AT `0`** |
| 5 | `phiTri`'s six trilinearity lemmas | **ALL SIX CORRECT, AND SIX IS THE RIGHT NUMBER** |
| 6 | `innerOp2_sharpMap_eq_phiTri` at every `S`, off-diagonal constant | **CORRECT, CONSTANT VERIFIED INDEPENDENTLY, NO HYPOTHESIS OWED** |
| 7 | `phiTri_line` and `sharpPair2_line` coefficients | **ALL EIGHT CORRECT** |
| 8 | `hasDerivAt_Pcubic2_line`'s value, and `S` arbitrary | **CORRECT, AND `S` IS GENUINELY ARBITRARY** |
| 9 | Is the line form usable for Fermat? | **GAP, IN THREE NAMED PIECES, AND THE RECORD DISCLOSES TWO** |
| 10 | `phiTri_rotate` and `foxTri2_symm_right` still true and correctly stated | **BOTH TRUE, AND THE INHERITANCE ROUTE IS THE ONLY ONE** |
| 11 | `#print axioms` over the three files | **58 CHECKED, 5 CARRY `sorryAx`** |
| 12 | Prose claiming more than is established | **ONE STALE ABSENCE CLAIM, TWO REACH FINDINGS, TWO WITHDRAWN** |

**Summary, one line.** Every proved declaration in the three files is correct and its constants check independently, `hasDerivAt_Pcubic2_line` rests on `phiTri_rotate` alone and on nothing else, and the two things to fix are [lean/INDEX.md](../lean/INDEX.md)'s `PhiTri.lean` row, which still says the expansion in `t` of `sharpPair2` is owed when `sharpPair2_line` is on file two lines below the lemma it describes, and the reach of `innerOp2_eq_trOp`'s *"the hypothesis still cannot be dropped"*, which is false at every `ι` with at most two elements.

## 0. Conventions, fixed once

`ι` is a `Fintype` with `DecidableEq` throughout, and the three files quantify over it generically, so every claim made in their prose is a claim at every such `ι`, `Fin 0`, `Fin 1` and `Fin 2` included. `inner2 X Y = ½ tr(Xᵀ Y)`. `phi i j = E_ji − E_ij`, so `phi i i = 0`, `phi j i = −phi i j`, and `{phi i j : i < j}` is `inner2`-orthonormal with `dim Λ² = |ι|(|ι|−1)/2`. `applyPhi R i j = ↑(R ⟨phi i j, _⟩)`. The ordered-pair doubling is `∑_e f(e) = ½ ∑_{i,j} f(φ_ij)`, so a double basis sum carries `¼ ∑_{i,j,k,l}`.

Writing `⟨A,B⟩_op` for `innerOp2 A B` and `Tr` for `trOp`, the layer's objects read: `⟨A,B⟩_op = Tr(A*B)`, `Tr M = ∑_e ⟨Me,e⟩`, `phiTri A B C = −∑_{e,f} ⟨B[Ae, Cf], [e,f]⟩ = Φ(A;B,C)` in [findings/second-order.md](../findings/second-order.md)'s notation, `Qop2 R = R² + R#`, `Pcubic2 R = ⟨R²,R⟩_op + ⟨R,R#⟩_op`. `IsSelfAdjoint2 A` is `A* = A` against `inner2` on `Λ²`.

## Hypothesis inventory

| hypothesis | where it sits | genuinely used |
|---|---|---|
| `IsSelfAdjoint2 R` | `innerOp2_eq_trOp`, `trCube2_first_variation`, `hasDerivAt_trCube2_line_selfAdjoint`, `phiTri_rotate`, `phiTri_first_variation`, `hasDerivAt_sharpPair2_line_selfAdjoint`, `hasDerivAt_Pcubic2_line` | yes in all seven |
| `IsSelfAdjoint2 B`, second argument | `innerOp2_eq_trOp_right` | yes, routed through `innerOp2_comm` then `trOp_comp_comm` |
| `IsSelfAdjoint2 X`, `Y`, `Z` | `foxTri2_symm_right` | unverifiable, the declaration is a `sorry` |
| none | the four `innerOp2` bilinearities, `compOp2_add`, `compOp2_line`, `trCube2_line`, `hasDerivAt_cubic`, `hasDerivAt_trCube2_line`, the six `phiTri` trilinearities, `phiTri_swap_outer`, `innerOp2_sharpMap_eq_phiTri`, `phiTri_line`, `sharpPair2_line`, `hasDerivAt_sharpPair2_line`, `foxTri2_comm` | correct, each checked below |

**The direction `S` carries no hypothesis anywhere in the chain**, which section 8 verifies declaration by declaration rather than by reading the statement of the last one.

## 1. `innerOp2`'s bilinearity, and where the right-hand hypothesis sits

`innerOp2 A B = ½ ∑_{i,j} inner2 (applyPhi A i j) (applyPhi B i j)`. Additivity and homogeneity in the left slot are `inner2`'s own, passed through `(A + A') X = A X + A' X` and `(c • A) X = c • A X`, which hold by `rfl` on `ContinuousLinearMap`. The right-slot pair is derived from the left by `innerOp2_comm`, already on file. **Four is exactly the right count** for a bilinear form, additivity and homogeneity in each of two slots, and it is exactly what the consumers need: [trCube2_line](../lean/HamiltonsCubic/Results/TraceOp.lean) discharges its `simp only` with all four and `hasDerivAt_Pcubic2_line` uses `innerOp2_add_right` to fold `Qop2`. Nothing in the chain needs a bundled bilinear form, and nothing asks for one.

**`innerOp2_eq_trOp_right`'s hypothesis does sit on the second argument**, `(A : CurvOp2 ι) {B : CurvOp2 ι} (hB : IsSelfAdjoint2 B)`, with `A` explicit and unconstrained. It is correct, by the residual `⟨A,B⟩_op − Tr(AB) = Tr(A*B) − Tr(AB) = Tr((A* − A)B)`, which self-adjointness of either argument kills. The proof takes the second route honestly: `innerOp2_comm` moves `B` to the front, `innerOp2_eq_trOp hB` applies, and `trOp_comp_comm` reverses the composite. **It has no consumer anywhere in the layer**, which is a fact about its use and not a defect.

**One reach finding, and it is narrow.** [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean)'s header and the docstring on `innerOp2_eq_trOp` both say *"the hypothesis still cannot be dropped"*, supported by *"at a skew-adjoint `A`, `trOp (A ∘ A) = -innerOp2 A A`, and `adS X` inhabits that"*. Located: [TraceOp.lean:16](../lean/HamiltonsCubic/Results/TraceOp.lean) and [TraceOp.lean:190-192](../lean/HamiltonsCubic/Results/TraceOp.lean), repeated verbatim into [lean/INDEX.md](../lean/INDEX.md)'s `TraceOp.lean` row. The failure, exhibited in closed form: at `|ι| ≤ 2` the space `Λ²` has dimension at most one, every linear map on it is a scalar, and a scalar is self-adjoint against any pairing, so `IsSelfAdjoint2 A` holds for every `A` and the identity holds unconditionally there. The named witness does not reach it either, since `adS X = 0` at `|ι| ≤ 2` and `trOp (0 ∘ 0) = 0 = −innerOp2 0 0`. **Screen**, exact rationals, on objects constructed for the purpose and reported as a screen: at `|ι| = 2` every elementary operator `φ_a ↦ φ_b` is self-adjoint. At `|ι| = 3` and `|ι| = 4` the witness works, `adS φ_01` is nonzero and skew-adjoint with `innerOp2 A A = 2` against `trOp (A ∘ A) = −2` at `n = 3`, and `4` against `−4` at `n = 4`. By hand and exactly, `[φ_01, φ_02] = φ_12 ≠ 0` confirms the nonvanishing at `n = 3` without the screen.

**The opposite reading, argued.** The sentence could be meant at the `n` the programme cares about, where it is true and the witness is exactly right. Against that: the file's binder is `{ι : Type*} [Fintype ι]` and every other reach correction recorded in these same docstrings is quantified over that binder, so a reader inherits this one the same way. *Fix: write "at every `ι` with `3 ≤ |ι|`", which is one clause and keeps the witness.* Separately, neither the residual identity `Tr((A* − A)B)` nor `trOp (A ∘ A) = −innerOp2 A A` has a declaration in the layer. Both are true, [r1015](REVIEW_r1015.md) proved the second in its own report with `adS X` inhabiting it, and it is three rewrites from `innerOp2_eq_trOp`'s own proof, reading `⟨Aφ, Bφ⟩ = −⟨φ, A(Bφ)⟩` where that proof reads `= ⟨A(Bφ), φ⟩`. **The proof exists and the declaration does not**, which is a lemma not carried across rather than a defect.

**Verdict: CORRECT AND COMPLETE.** The reach finding is against the prose, not the theorem.

## 2. `compOp2_add` and `compOp2_line`

`compOp2 A = A.comp A`, so `compOp2 (A + B) X = (A+B)((A+B)X) = A(AX) + A(BX) + B(AX) + B(BX)`, which is the stated `compOp2 A + (A.comp B + B.comp A) + compOp2 B`. Composition is additive in each argument because `A` is additive, which the type supplies, and for no other reason, **so neither lemma owes anything about `R` or `S`**, self-adjointness included.

`compOp2 (R + t • S) X = R(RX) + t • R(SX) + t • S(RX) + t² • S(SX)`, the `t²` arising as `t • (t • ·)` and rewritten by `smul_smul` and `sq`. The stated `compOp2 R + t • (R.comp S + S.comp R) + (t^2) • compOp2 S` is exactly that. **Correct, and the sum `R∘S + S∘R` is genuinely the full cross term**, not a symmetrisation of one of them.

**`compOp2_add` has no consumer.** `trCube2_line` runs through `compOp2_line`, and nothing in any of the three files, or in the layer, cites `compOp2_add`. It is correct and it is the polarisation its docstring calls it. I record the disuse because the file presents the two as a pair.

**Verdict: CORRECT, AND NEITHER OWES A HYPOTHESIS.**

## 3. `trCube2_line`, all four coefficients, verified independently

Write `C₀ = R²`, `C₁ = R∘S + S∘R`, `C₂ = S²`, so `compOp2 (R + tS) = C₀ + t C₁ + t² C₂` by section 2. Then `trCube2 (R + tS) = ⟨C₀ + tC₁ + t²C₂, R + tS⟩_op`, and expanding by the four bilinearities of section 1 gives six products, which I collect by degree rather than by reading the file:

| degree | products | value | file |
|---|---|---|---|
| `t⁰` | `⟨C₀,R⟩` | `⟨R²,R⟩ = trCube2 R` | `trCube2 R` |
| `t¹` | `⟨C₁,R⟩ + ⟨C₀,S⟩` | `⟨R∘S,R⟩ + ⟨S∘R,R⟩ + ⟨R²,S⟩` | `innerOp2 (S.comp R) R + innerOp2 (R.comp S) R + innerOp2 (compOp2 R) S` |
| `t²` | `⟨C₁,S⟩ + ⟨C₂,R⟩` | `⟨R∘S,S⟩ + ⟨S∘R,S⟩ + ⟨S²,R⟩` | `innerOp2 (compOp2 S) R + innerOp2 (S.comp R) S + innerOp2 (R.comp S) S` |
| `t³` | `⟨C₂,S⟩` | `⟨S²,S⟩ = trCube2 S` | `trCube2 S` |

All four agree, the `t¹` and `t²` rows as sets of three summands and in a different written order, which is immaterial to a sum. **The `t²` and `t³` coefficients are the ones nothing downstream could catch**, since `hasDerivAt_cubic` reads only `b`, and both are right. The `t³` coefficient in particular is `trCube2 S` rather than, say, `⟨S∘S, S⟩` written out, and those are the same term by definition of `trCube2` and `compOp2`.

**Verdict: ALL FOUR CORRECT.**

## 4. `hasDerivAt_cubic`

`HasDerivAt (fun t : ℝ => a + t * b + t^2 * c + t^3 * d) b 0`. The derivative of the four summands at a general `t` is `0 + b + 2tc + 3t²d`, which at `t = 0` is `b`. **The statement is at `0` and only at `0`**, the point being the third argument, so the theorem cannot be misapplied at a general `t` where it would be false. The coefficients are abstract reals bound before the lambda, so no normalisation can reach inside them, which is what the docstring claims and what makes the two uses go through by pure unification.

**It is not accidentally true.** `HasDerivAt` pins the derivative uniquely, and the proof exhibits the four summands' derivatives separately, `hasDerivAt_const` giving `0`, `(hasDerivAt_id 0).mul_const b` giving `b`, and `hasDerivAt_pow 2` and `hasDerivAt_pow 3` at `0` giving `0` each because their factors are `2 * 0^1` and `3 * 0^2`. The quadratic and cubic terms vanish at `0` for the right reason, that their derivatives vanish there, not because the statement was weakened.

**Both uses unify syntactically and exactly.** `hasDerivAt_trCube2_line` and `hasDerivAt_sharpPair2_line` each `rw [funext (…_line R S)]` first, and the right sides of `trCube2_line` and `sharpPair2_line` are written in the literal shape `a + t * b + t^2 * c + t^3 * d`, which `hasDerivAt_cubic`'s own `hfun` step needs, that step being `rfl`.

**Verdict: CORRECT, AND STATED AT `0`.**

## 5. `phiTri`'s six trilinearity lemmas

`phiTri A B C = −¼ ∑_{i,j,k,l} ⟨ B [A φ_ij, C φ_kl], [φ_ij, φ_kl] ⟩`. Each of the three operators occurs exactly once in the summand, so each slot is genuinely a slot and the right count is **additivity plus homogeneity in each of three, which is six**. There is no seventh obligation, because `phiTri` is a function of three operators and nothing else, the `φ` family being fixed.

Slot by slot, naming the on-file step each needs:

- **`A`**, inside the bracket's left place: `brS_add_left` then `B`'s `map_add` then `inner2_add_left`, and `brS_smul_left` then `map_smul` then `inner2_smul_left`.
- **`B`**, outermost: `map_add` and `Submodule.coe_add` alone, then `Submodule.coe_smul`. `B` sees nothing of the bracket structure.
- **`C`**, inside the bracket's right place: `brS_add_right` then `map_add` then `inner2_add_left`, and `brS_smul_right` then `map_smul` then `inner2_smul_left`.

Each is what the corresponding proof does. **The three slots are genuinely different**, which the three distinct routes above show, so none of the six is a restatement of another, and in particular `phiTri_add_left` is not `phiTri_add_right` read through `phiTri_swap_outer`, that swap exchanging `A` and `C` at fixed `B`.

**[r1015] found these absent and they are now present and correct.** Six is enough for `phiTri_line`: the `simp only` there uses all six and nothing else.

**Verdict: ALL SIX CORRECT, AND SIX IS THE RIGHT NUMBER.**

## 6. `innerOp2_sharpMap_eq_phiTri`, and the off-diagonal constant

The claim is `⟨S, R#⟩_op = −½ Φ(S;R,R)` at every `S` and every `R`, with no hypothesis. I derive the constant from the definitions without reading the file's proof, and only then compare.

**Left side.** `innerOp2 S (sharpMapCL R) = ½ ∑_{i,j} ⟨ S φ_ij, R# φ_ij ⟩`, since `applyPhi (sharpMapCL R) i j = sharpMap R φ_ij` by definition. By `inner2_sharpMap`, `⟨R# X, Y⟩ = sharpBil2 R X Y`, and `inner2` is symmetric, so each summand is `sharpBil2 R φ_ij (S φ_ij)`. By `sharpBil2_eq_crossPair2`, that is `crossPair2 R φ_ij (S φ_ij)`, and by `crossPair2_bracket` it is `¼ ∑_{p,q} ⟨ R [S φ_ij, R φ_pq], [φ_ij, φ_pq] ⟩`. Hence

`⟨S, R#⟩_op = ½ · ¼ ∑_{i,j,p,q} ⟨ R [S φ_ij, R φ_pq], [φ_ij, φ_pq] ⟩ = ⅛ ∑_{i,j,p,q} (…)`.

**Right side.** `phiTri S R R = −¼ ∑_{i,j,k,l} ⟨ R [S φ_ij, R φ_kl], [φ_ij, φ_kl] ⟩`, so `−½ · phiTri S R R = ⅛ ∑_{i,j,k,l} (…)`, the same sum under the same summand.

**The two agree exactly, `⅛` against `⅛`.** The `½` of `innerOp2` and the `¼` of `crossPair2_bracket` multiply to the `⅛` that `−½` against `phiTri`'s `−¼` also produces, so the ordered-pair doubling is consistent across the two definitions and nothing is double counted. I checked `crossPair2_bracket` itself rather than take it: `crossPair2 R X Y = −¼ ∑ ⟨[X, R[Y,Rφ]], φ⟩`, and one `ad_skewAdjoint` with `X` in the `ad` slot turns `⟨[X,U],φ⟩` into `−⟨U,[X,φ]⟩`, the two minus signs giving the stated `+¼`.

**It owes no hypothesis**, and I say why rather than observing that the statement carries none. Every step above is linearity of `inner2`, symmetry of `inner2`, the definition of `sharpMap` as the reassembly of `sharpBil2`'s coordinates, and skew-adjointness of `ad_X` for skew `X`, which is a property of the bracket on `Λ²` and not of `R` or `S`. The one place a hypothesis could enter is `sharpBil2_eq_crossPair2`, and that rests on `crossPair2_comm`, which is cyclicity of `trOp` and holds at every `R`. **In particular self-adjointness of `R` is not needed here**, and the derivation agrees: [findings/second-order.md](../findings/second-order.md)'s step 1 states `⟨S,R#⟩ = −½Φ(S;R,R)` for every `S` with only linearity of `R` assumed, which the type supplies.

**Verdict: CORRECT, CONSTANT VERIFIED INDEPENDENTLY, NO HYPOTHESIS OWED.**

## 7. `phiTri_line` and `sharpPair2_line`, all eight coefficients

**`phiTri_line`.** Expanding `Φ(R+tS; R+tS; R+tS)` by the six lemmas of section 5 gives eight terms, one per choice of `R` or `tS` in each slot, and `t` factors out of each by homogeneity:

| degree | the eight terms collected | file |
|---|---|---|
| `t⁰` | `Φ(R;R,R)` | `phiTri R R R` |
| `t¹` | `Φ(S;R,R) + Φ(R;S,R) + Φ(R;R,S)` | `phiTri S R R + phiTri R S R + phiTri R R S` |
| `t²` | `Φ(S;S,R) + Φ(S;R,S) + Φ(R;S,S)` | `phiTri R S S + phiTri S R S + phiTri S S R` |
| `t³` | `Φ(S;S,S)` | `phiTri S S S` |

The `t²` row is written in a different order in the file, and it is the same three-element set: `{(R,S,S), (S,R,S), (S,S,R)}` against my `{(S,S,R), (S,R,S), (R,S,S)}`. **No term is omitted and none is duplicated**, which matters because `Φ` is not symmetric in general, so a `t²` coefficient written as `3 Φ(S;S,R)` would have been wrong and would never have been caught at `t = 0`.

**`sharpPair2_line`.** `sharpPair2_eq_phiTri` gives `⟨X,X#⟩ = −½ Φ(X;X,X)` at every `X`, and applying it at `X = R + tS`, at `X = R` and at `X = S` turns the four coefficients of `phiTri_line` into the four stated: `sharpPair2 R` for `t⁰`, `−½` times each of the two middle rows, and for `t³` the value `−½ Φ(S;S,S)`, which **is** `sharpPair2 S` by the same lemma rather than by a separate fact. All four correct, and again both middle coefficients, not only the linear one.

**Verdict: ALL EIGHT CORRECT.**

## 8. `hasDerivAt_Pcubic2_line`

`Pcubic2 = trCube2 + sharpPair2` definitionally, so the two halves add as functions of `t` and their derivatives at `0` add. The composition half contributes `3⟨S, R²⟩_op` through `trCube2_first_variation`, the sharp half `3⟨S, R#⟩_op` through `phiTri_first_variation` composed with section 6's identity, and `innerOp2_add_right` folds `R² + R#` into `Qop2 R` inside the second slot. **The value `3 * innerOp2 S (Qop2 R)` is right**, and it is right at the constants: the composition half never leaves `innerOp2`, so no constant can drift there, and the sharp half's constant is the `⅛` against `⅛` of section 6, checked independently of the file. This is [findings/second-order.md](../findings/second-order.md)'s boxed conclusion, `d/dt|₀ P(R+tS) = 3⟨S, Q(R)⟩_op`, with `innerOp2` being the derivation's `⟨,⟩_op` including its `½`.

**The theorem needs `S` self-adjoint nowhere, and it in fact avoids that.** I verified this by walking the chain rather than by reading the binder list:

- `hasDerivAt_trCube2_line` takes `R S` with no hypothesis at all.
- `trCube2_first_variation (R S) (hR : IsSelfAdjoint2 R)` uses `hR` in `h1` and `h2`, and in `h3` through `hR.compOp2`, which is self-adjointness of `R²` derived from `R`'s. `S` appears only as the free second argument of `innerOp2` and of `comp`.
- `hasDerivAt_sharpPair2_line` takes `R S` with no hypothesis.
- `phiTri_first_variation (hR) (S)` rewrites `phiTri R R S` by `phiTri_swap_outer R R S`, which has no hypothesis, and `phiTri R S R` by `phiTri_rotate hR S R`. **The rotation's hypothesis lands on its first slot, which is `R`**, the instantiation being `A := R`, `B := S`, `C := R`. Had it landed on `S` the theorem would be unusable for Fermat, and it does not.
- `innerOp2_sharpMap_eq_phiTri R S` has no hypothesis, by section 6.

So the only binder in `hasDerivAt_Pcubic2_line` is `hR`, and each use of it is at `R`. **Euler's identity is the case `S = R`** and is strictly weaker, as [REVIEW_r1012.md](REVIEW_r1012.md) established and the file repeats correctly.

**Verdict: CORRECT, AND `S` IS GENUINELY ARBITRARY.**

## 9. The line form against Fermat: a gap, in three named pieces

**`HasDerivAt` along a line does not feed `IsLocalMaxOn.hasFDerivWithinAt_nonpos`.** Checked, not recalled: under the project toolchain the Mathlib signature is

```
IsLocalMaxOn.hasFDerivWithinAt_nonpos :
  IsLocalMaxOn f s a → HasFDerivWithinAt f f' s a → y ∈ posTangentConeAt s a → f' y ≤ 0
```

with `f' : StrongDual ℝ E`, and the layer's own restatement at [Bivectors2.lean:905-908](../lean/HamiltonsCubic/Base/Bivectors2.lean) takes the same three. What `hasDerivAt_Pcubic2_line` supplies is the Gateaux derivative of `Pcubic2` at `R`, one real number per direction `S`. **Three things stand between that and `f' y ≤ 0`**, and I name each with what would discharge it:

1. **The functional is not bundled.** `f'` must be a `StrongDual ℝ (CurvOp2 ι)`, a *continuous* linear functional. Linearity of `S ↦ 3 · innerOp2 S (Qop2 R)` is now available and was not before this round, being exactly `innerOp2_add_left` and `innerOp2_smul_left`. **Boundedness is not on file**: no lemma relates `innerOp2 S T` to the scoped operator norm `CurvOp2` carries, and [plan.md](../plan.md)'s I36 list names the underlying want, *"an inner product over `innerOp2` to replace the scoped sup norm"*, as its last owed item.
2. **Fréchet differentiability itself.** `HasFDerivAt Pcubic2 f' R` needs `Pcubic2 (R + H) − Pcubic2 R − f' H = o(‖H‖)` **uniformly in `H`**, and the four `_line` lemmas are stated only at `H = t • S` for a fixed `S`, which gives the estimate along each line separately with no control across directions. The algebraic route exists, a general-increment expansion `Pcubic2 (R + H) = Pcubic2 R + 3⟨H, Qop2 R⟩_op + (quadratic in H) + Pcubic2 H` whose last two terms are `O(‖H‖²)`, and **that expansion is not on file in any form**: `trCube2_line` and `phiTri_line` both scalarise `t` out before they begin.
3. **The positive tangent cone is uncomputed.** The lemma's third argument is `y ∈ posTangentConeAt s a` at `s = {S | normSq2 S = 1}`. Nothing in the layer computes that cone or exhibits a single member of it. [REVIEW_r1012.md](REVIEW_r1012.md) established that the cone spans a hyperplane rather than the space, which is why `UniqueDiffWithinAt` fails there, and that observation is about the cone's *deficiency*, not a membership result one can feed the lemma.

**Does the record anywhere claim otherwise? Twice it explicitly does not, and once the wording is loose.** [lean/INDEX.md](../lean/INDEX.md)'s `FirstVariation.lean` row lists under **NOT stated** *"the Fréchet form `HasFDerivAt`, which a cubic on a finite-dimensional space always has and is owed beyond the line form"*, and [plan.md](../plan.md)'s I36 **OWED, in order** list places *"then the Fréchet form `HasFDerivAt`"* after `foxTri2_symm_right`. Both are accurate, and piece 2 above is what they name. **Neither names piece 3**, and piece 1 is named only obliquely through the inner-product item. *So the record understates the distance by one step, the tangent cone, which is a separate obligation from the derivative and is not on any owed list I found.*

The loose wording is [FirstVariation.lean:13-15](../lean/HamiltonsCubic/Results/FirstVariation.lean): *"`hasDerivAt_Pcubic2_line` is the first variation along a LINE, `t ↦ P(R + tS)`, at a self-adjoint `R` and an ARBITRARY direction `S`, which is what Fermat over the full unit sphere consumes"*. **Withdrawn as a discrepancy, with the reason.** The relative pronoun admits two antecedents. On the reading that it points at the line form, the sentence contradicts the next one, which says the Fréchet form is a further step and is owed. On the reading that it points at the arbitrariness of `S`, the sentence is true and is precisely [REVIEW_r1012.md](REVIEW_r1012.md)'s point that Fermat consumes the whole functional `S ↦ DP(R)[S]` rather than its value at `S = R`, which the trailing clause about Euler confirms is the contrast being drawn. The second reading is the coherent one and I take it. *Suggested tightening, since a later reader will not have both readings in hand: "at an ARBITRARY direction `S`, which is the generality Fermat over the full unit sphere consumes, though not yet the FORM it consumes."*

**Verdict: GAP, IN THREE NAMED PIECES, AND THE RECORD DISCLOSES TWO.** What would have to be proved: a general-increment expansion of `Pcubic2`, a boundedness estimate making `S ↦ innerOp2 S (Qop2 R)` a `StrongDual`, and a membership result for `posTangentConeAt {normSq2 = 1} R`.

## 10. The two remaining `sorry`s

**`phiTri_rotate {A} (_hA : IsSelfAdjoint2 A) (B C) : phiTri A B C = phiTri B C A`.** Still true, and it still states what the derivation proves. [findings/second-order.md](../findings/second-order.md)'s step 3 derives `Φ(A;B,C) = Φ(B;C,A*)` with no hypothesis by rotating both structure constants cyclically, and self-adjointness enters only to replace `A*` by `A`. The Lean statement is that specialisation, with the hypothesis on the first slot, which is where `A*` appears. `IsSelfAdjoint2 A` on `Λ²` is `A* = A` against `inner2`, which is the derivation's "symmetric". **The docstring is right that the starred form is wider and that stating it needs an adjoint on `CurvOp2` the layer does not carry.** The underscore on `_hA` records only that a `sorry` uses nothing, and carries no claim that the hypothesis is idle.

**`foxTri2_symm_right (X Y Z) (hX hY hZ) : foxTri2 X Y Z = foxTri2 X Z Y`.** Still true, and it still states what the derivation proves. `foxProd2 X Y = ½(Q(X+Y) − Q(X) − Q(Y))` matches the derivation's `X ∘ Y`, and `foxTri2 X Y Z = innerOp2 (foxProd2 X Y) Z` matches `T(X,Y,Z) = ⟨X∘Y, Z⟩_op`. Step 5 gives full symmetry of `T` at self-adjoint arguments, the trace half by cyclicity together with `Tr M = Tr M*` and the `Φ` half by step 3, and symmetry in the last two slots is one of the transpositions that generates. **All three hypotheses are used by the derivation's route**, the trace half needing `Z* = Z` to move `Z` under the cyclic permutation and `X`, `Y` to drop their own stars.

**The `sorryAx` inheritance is confirmed and it is the only route.** `hasDerivAt_Pcubic2_line` reaches it through `hasDerivAt_sharpPair2_line_selfAdjoint`, then `phiTri_first_variation`, then `phiTri_rotate`. Every other input is clean on the standard three axioms: `hasDerivAt_trCube2_line_selfAdjoint`, `innerOp2_add_right`, `hasDerivAt_sharpPair2_line`, `innerOp2_sharpMap_eq_phiTri` and `phiTri_swap_outer` all check clean in section 11, so no second `sorry` can be reaching the theorem through the sharp half or the composition half. **The composition half is fully proved**, `sorry`-free end to end. [FirstVariation.lean:39-41](../lean/HamiltonsCubic/Results/FirstVariation.lean)'s route description omits the intervening `hasDerivAt_sharpPair2_line_selfAdjoint`, which is an abbreviation of a correct chain and not an error.

**Verdict: BOTH TRUE, AND THE INHERITANCE ROUTE IS THE ONLY ONE.**

## 11. `#print axioms`, every declaration in the three files

Run through `lake env lean` on the project toolchain, Lean 4.33.1, after a clean `lake build`, over all **58** declarations: 25 in [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean), 28 in [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean), 5 in [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean), definitions included.

**53 carry exactly `[propext, Classical.choice, Quot.sound]`.** The five that carry `sorryAx`:

| declaration | file | route |
|---|---|---|
| `phiTri_rotate` | PhiTri.lean | **source**, its own `sorry` |
| `phiTri_first_variation` | PhiTri.lean | `phiTri_rotate` |
| `hasDerivAt_sharpPair2_line_selfAdjoint` | PhiTri.lean | `phiTri_first_variation` → `phiTri_rotate` |
| `hasDerivAt_Pcubic2_line` | FirstVariation.lean | `hasDerivAt_sharpPair2_line_selfAdjoint` → `phiTri_first_variation` → `phiTri_rotate` |
| `foxTri2_symm_right` | FirstVariation.lean | **source**, its own `sorry` |

**Two sources, four dependents counting the sources, and nothing else in the three files is affected.** In particular `hasDerivAt_trCube2_line_selfAdjoint`, `trCube2_line`, `phiTri_line`, `sharpPair2_line`, `hasDerivAt_sharpPair2_line`, `innerOp2_sharpMap_eq_phiTri`, `sharpPair2_eq_phiTri` and all ten bilinearity and trilinearity lemmas are clean.

**Verdict: 58 CHECKED, 5 CARRY `sorryAx`.**

## 12. Prose that claims more than is established

**One stale absence claim, and it is the actionable finding of this report.** [lean/INDEX.md](../lean/INDEX.md)'s `PhiTri.lean` row, in the clause about `phiTri_rotate`, says:

> **though nothing on file yet calls that sum the $t$-coefficient of `sharpPair2 (R + t•S)`**, which is the expansion still owed

**It is on file, in the same file the row describes.** `sharpPair2_line` states `sharpPair2 (R + t • S) = sharpPair2 R + t * (−½ (phiTri S R R + phiTri R S R + phiTri R R S)) + …`, which calls that sum, up to the `−½`, exactly the `t`-coefficient, and `hasDerivAt_sharpPair2_line` calls it the derivative at `0`. Both sit about twenty lines below `phiTri_first_variation` in [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean). The clause is a survival from the state [r1015] audited, and the row was extended for the new lemmas without it being removed. *Fix: strike the clause and say that `phiTri_line` and `sharpPair2_line` supply the expansion, leaving `phiTri_rotate` as the one debt, which the rest of the row already says.* **This is the shape [r1015]'s own round turned on, a claim that the record LACKS something, made without checking the file it names.**

**Two reach findings.**

*First*, section 1's, `innerOp2_eq_trOp`'s *"the hypothesis still cannot be dropped"*, false at `|ι| ≤ 2` where every operator is self-adjoint, carried in [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean) twice and in [lean/INDEX.md](../lean/INDEX.md)'s `TraceOp.lean` row once. **This is proposal 150's shape one degree finer than the two occurrences it records.** Proposal 150 asks that where a hypothesis is stated as necessary the failure be exhibited, and here it *is* exhibited, at a skew-adjoint `A` with `adS X` named as inhabiting that. The gap is that the witness is not certified nonzero, and it is zero exactly where the claim is false. *Fix: `3 ≤ |ι|`.*

*Second*, [FirstVariation.lean:20-21](../lean/HamiltonsCubic/Results/FirstVariation.lean): *"neither is claimed at a non-self-adjoint argument, and the derivation shows the `Φ` half needs the rotated slot symmetric."* **What the derivation shows is sufficiency.** Step 3 proves `Φ(A;B,C) = Φ(B;C,A*)` with no hypothesis and reads the unstarred rotation off it at `A* = A`. The derivation's own necessity sentence, *"the adjoint is load-bearing and the rotation fails without it"*, rests on the numerical screen [scripts/misc/screen_phitri_constants.py](../scripts/misc/screen_phitri_constants.py), which [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)'s own `phiTri_rotate` docstring labels honestly as a screen and even records a false start in. So *"the derivation shows … needs"* attributes to the derivation a necessity the derivation obtains from a screen. **The opposite reading, argued**: *"needs"* may mean *"the derivation's route needs"*, that is, the step uses the symmetry, which is true and is the natural reading given the clause before it is about the scope of the claim. On that reading nothing is wrong, and I record this as a wording risk rather than a defect. *Fix, if it is taken: "and the derivation's route to the `Φ` half uses the rotated slot's symmetry, with the necessity screened rather than proved."*

**Two withdrawn, with reasons.**

*Withdrawn 1*, [FirstVariation.lean:13-15](../lean/HamiltonsCubic/Results/FirstVariation.lean)'s *"which is what Fermat over the full unit sphere consumes"*, argued in full in section 9. The coherent antecedent is the arbitrariness of `S`, on which the sentence is true.

*Withdrawn 2*, [TraceOp.lean:209-214](../lean/HamiltonsCubic/Results/TraceOp.lean)'s *"only `h1` below calls `trOp_comp_comm`, `h2` being associativity and `h3` a bare application, and both of those reach their value without a trace at all."* **The load-bearing half is exact**: I read the three proofs and only `h1` cites `trOp_comp_comm`, twice, `h2` using `innerOp2_comm`, `innerOp2_eq_trOp` and `comp_assoc`, and `h3` being the single application `innerOp2_eq_trOp hRR S`. The trailing *"without a trace at all"* is literally false, since the shared value of all three is `trOp ((compOp2 R).comp S)` and `h2` rewrites by `innerOp2_eq_trOp`, which is a trace identity. **Withdrawn** because the sentence's subject is cyclicity throughout and *"without a trace"* plainly abbreviates *"without the trace's cyclicity"*, which is true and is the whole point being made against the earlier miscount. *If the sentence is touched for any other reason, "without cyclicity" is the word.*

**Checked and clear.** [lean/INDEX.md](../lean/INDEX.md)'s `FirstVariation.lean` row is accurate throughout, including its **NOT stated** list and its `sorryAx` inheritance claim, both verified in section 11. Its *"needing no topology on `CurvOp2`"* is correct: `hasDerivAt_Pcubic2_line` is a statement about a function `ℝ → ℝ`, and the scoped `OperatorNorm` opened at the top of the file is not used by it. [plan.md](../plan.md)'s I36 item is accurate on the `sorryAx` inheritance, on the two traps, and on `S` needing nothing, and its owed list is in the right order. [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean)'s *"EXACTLY ONE OF THE THREE NEEDS CYCLICITY"* is exact. [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)'s claim that the outer swap needs no structure constants is exact, `phiTri_swap_outer` running on `sum4_swap` and `brS_neg` alone. The `TraceOp.lean` row's closing screen sentence attaches to `trCube2_first_variation`'s hypothesis, which is what [scripts/misc/screen_traceop_hypothesis.py](../scripts/misc/screen_traceop_hypothesis.py) actually screens, at a witness non-self-adjoint in both slots, so the screen supports the claim it is cited for. *The row's words "the identity" would be clearer as "the first-variation identity", three identities having been named before it.*

**Verdict: ONE STALE ABSENCE CLAIM, TWO REACH FINDINGS, TWO WITHDRAWN.**

## Overall verdict

**HYPOTHESIS-DEBT.**

Every proved declaration in the three files is correct, every constant checks independently, and the hypotheses are where they belong, with `S` free throughout. The debt is in three layers and each is nameable:

- **`phiTri_rotate`**, `Φ(A;B,C) = Φ(B;C,A)` at self-adjoint `A`, on which the entire first variation of `P` rests and which nothing else in the three files touches. True, stated as the derivation proves it, and unproved.
- **`foxTri2_symm_right`**, symmetry of `T` in its last two slots at self-adjoint arguments. True, stated as the derivation proves it, and unproved.
- **The bridge to Fermat**, three pieces in section 9: a general-increment expansion of `Pcubic2`, a boundedness estimate making `S ↦ innerOp2 S (Qop2 R)` a `StrongDual ℝ (CurvOp2 ι)`, and a membership result for `posTangentConeAt {normSq2 = 1} R`. The first two are on the record's owed lists in some form. **The third is on none of them.**

One item is a correction to make rather than a debt to pay: [lean/INDEX.md](../lean/INDEX.md)'s `PhiTri.lean` row still says the expansion in `t` of `sharpPair2` is owed, and `sharpPair2_line` is on file.
