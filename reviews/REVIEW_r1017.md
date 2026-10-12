# Review r1017: the general-increment expansion, the bounded functional, and the reach of "no cheap route"

**Cold brief, sole reviewer.** No sweep, census, optimisation or falsifier hunt was run. Two screens are reported below and labelled as screens, seconds each, exact rational arithmetic throughout. No positive claim in this report rests on either. Every Lean check ran through `lake env lean` under the project toolchain, Lean 4.33.1, commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`, confirmed against a bare `lean` reporting the same release here. Log: [agent_logs/r1017.log](../agent_logs/r1017.log).

| # | claim | verdict |
|---|---|---|
| 1 | `trCube2_expand`, `phiTri_expand`, `sharpPair2_expand` at a general increment, all four parts | **CORRECT**, all four parts of all three, matched term for term against step 4 |
| 2 | `Pcubic2_expand`; `Pcubic2Lin` linear, `Pcubic2Quad` quadratic | **SPLIT CORRECT; BOTH HOMOGENEITIES TRUE AND UNSTATED**, and nothing downstream reads either |
| 3 | `Pcubic2Lin_selfAdjoint`, the linear part is `3⟨H, Q(R)⟩` | **CORRECT**, constant verified three independent ways; carries `sorryAx` |
| 4 | `PcubicDiff` a `StrongDual`, `PcubicDiff_apply`, `PcubicDiff_eq_lin` | **CORRECT AND NOT CIRCULAR**, two reach findings |
| 5 | The `OperatorNorm` plumbing claim | **FIRST HALF REPRODUCED EXACTLY; SECOND HALF INACCURATE**, and the tension it names does not obstruct |
| 6 | Does "no cheap route" follow from the screen? | **OVERSTATED**, and the record's own neighbouring row names a route the screen cannot see |
| 7 | The screen's soundness, negative and positive halves | **NEGATIVE HALF SOUND; POSITIVE HALF IS SAMPLING**, wording saved by its attribution |
| 8 | The two `sorry`s true and faithful; the second hypothesis placement | **BOTH TRUE AND FAITHFUL; THE SECOND PLACEMENT IS A COROLLARY OF THE FIRST**, machine-checked, and the stated form is not the weakest useful one |
| 9 | `#print axioms` on every declaration | **DONE**, 66 declarations, 7 carrying `sorryAx` from 2 independent sources |
| 10 | Prose outrunning evidence | **THREE INSTANCES**, one of them false as written; proposal 150's shape occurs a fourth time |

**Summary, one line and actionable.** The mathematics under audit is right and the four-part expansions check exactly. **Replace plan.md line 152's "HAS NO CHEAP ROUTE, ESTABLISHED RATHER THAN ASSUMED" with what the screen actually establishes, and correct PcubicDiff.lean's "that scope exists to make Fermat's `IsLocalMaxOn` elaborate", which is false and which [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) already contradicts eighteen lines of its own prose.**

## 0. Conventions, fixed once

`CurvOp2 ι := skewSub ι →L[ℝ] skewSub ι`. `inner2 A B = ½ tr(AᵀB)`, under which `{φ_ij}_{i<j}` is orthonormal and `∑_e f(e) = ½ ∑_{i,j} f(φ_ij)`. `innerOp2 A B = ∑_e ⟨Ae, Be⟩`, symmetric, and equal to `Tr(A*B)` with `Tr = trOp` the trace on `End(Λ²)` and `A*` the adjoint against `inner2`. `compOp2 R = R ∘ R`, `trCube2 R = ⟨R², R⟩`, `sharpPair2 R = ⟨R, R#⟩`, `Pcubic2 = trCube2 + sharpPair2`, `Qop2 R = R² + R#`. In Lean `H.comp R` is `H ∘ R`, so `innerOp2 (H.comp R) R` is `⟨H∘R, R⟩`. `Φ(A;B,C) = ∑_e Tr(ad_e B ad_{Ae} C)`, whose identification with `phiTri` [r1015](REVIEW_r1015.md) settled, sign and constant exact.

The derivation compared against is [second-order.md](../findings/second-order.md), the block headed *"The first variation of $P$ at an arbitrary direction"*, in particular its step 4 multilinear form `U(A,B,C) = Tr(A*B*C) − ½Φ(A;B,C)` with `P(R) = U(R,R,R)`.

## Hypothesis inventory

| hypothesis | where it is needed | where it is not |
|---|---|---|
| `IsSelfAdjoint2 R` | `trCube2_first_variation` (two of its three terms), `phiTri_first_variation`, `Pcubic2Lin_selfAdjoint`, `PcubicDiff_eq_lin` | `trCube2_expand`, `phiTri_expand`, `sharpPair2_expand`, `Pcubic2_expand`, `PcubicDiff`, `PcubicDiff_apply` |
| `IsSelfAdjoint2 A` in `phiTri_rotate` | load-bearing, screened by [screen_phitri_constants.py](../scripts/misc/screen_phitri_constants.py) at 12/12 | the starred form `Φ(A;B,C) = Φ(B;C,A*)` needs none |
| `[Fintype ι] [DecidableEq ι]` | everywhere | none |
| `ι = Fin n` | nowhere, see §4 | `PcubicDiff` elaborates at general `ι`, screened |
| the `OperatorNorm` scope | `isLocalMaxOn_fderivWithin_nonpos`, `isLocalMaxOn_hasFDerivWithinAt_nonpos` and their two-sided forms, all in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) | `IsLocalMaxOn` itself; [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) and [CubicBridge.lean](../lean/HamiltonsCubic/Results/CubicBridge.lean), where the `open` is inert, verified by removing it and rebuilding |

## 1. The three expansions at a general increment, all four parts

**`trCube2_expand`.** `compOp2_add` gives `(R+H)∘(R+H) = R² + (R∘H + H∘R) + H²`, which I checked against its own proof term (`A (A X) + (A (B X) + B (A X)) + B (B X)`). Bilinearity of `innerOp2` then opens `⟨R² + R∘H + H∘R + H², R + H⟩` into exactly eight terms, and the theorem's four groups account for each once:

| part | Lean | the eight terms |
|---|---|---|
| constant | `trCube2 R` | `⟨R²,R⟩` |
| linear | `innerOp2 (H.comp R) R + innerOp2 (R.comp H) R + innerOp2 (compOp2 R) H` | `⟨H∘R,R⟩`, `⟨R∘H,R⟩`, `⟨R²,H⟩` |
| quadratic | `innerOp2 (compOp2 H) R + innerOp2 (H.comp R) H + innerOp2 (R.comp H) H` | `⟨H²,R⟩`, `⟨H∘R,H⟩`, `⟨R∘H,H⟩` |
| cubic | `trCube2 H` | `⟨H²,H⟩` |

No term is duplicated and none is missing. **And every one matches step 4's trace half term for term**, which is the check the brief's "a wrong quadratic part never surfaces at `t = 0`" asks for. Writing `⟨A,B⟩ = Tr(A*B)`: the linear group is `Tr(R*H*R)`, `Tr(H*R*R)`, `Tr(R*R*H)`, which is step 4's `Tr(S*R²) + Tr(RS*R) + Tr(R²S)` at `S = H`; the quadratic group is `Tr(H*H*R)`, `Tr(R*H*H)`, `Tr(H*R*H)`, which is step 4's `U(S,S,R) + U(S,R,S) + U(R,S,S)` trace halves at `S = H`. **Both groups are unconditional**, and the theorem correctly carries no hypothesis.

**`phiTri_expand`.** Trilinearity gives eight terms `RRR, RRH, RHR, RHH, HRR, HRH, HHR, HHH`, and the theorem's four groups list `RRR | HRR, RHR, RRH | RHH, HRH, HHR | HHH`, which is all eight, each once. The quadratic group is step 4's `−½[Φ` parts of `U(S,S,R)+U(S,R,S)+U(R,S,S)]` up to ordering. Correct, and unconditional.

**`sharpPair2_expand`.** It is `sharpPair2_eq_phiTri` applied three times to `phiTri_expand`, so it inherits that correctness, and the `−½` distributes over the linear and quadratic groups and is absorbed into `sharpPair2 R` and `sharpPair2 H` at the two ends. Checked: correct.

**Verdict, item 1: CORRECT**, all four parts of each of the three.

## 2. The split, and two homogeneities nobody states

`Pcubic2 = trCube2 + sharpPair2` makes `Pcubic2_expand` the sum of the two expansions above, with `Pcubic2Lin` collecting the two linear groups and `Pcubic2Quad` the two quadratic groups. The split is constant + linear + quadratic + cubic exactly.

**Both homogeneities are true and neither is stated anywhere.** For `Pcubic2Lin R (c•H)`: `(c•H).comp R = c • (H.comp R)` and `R.comp (c•H) = c • (R.comp H)`, so `innerOp2_smul_left` and `innerOp2_smul_right` give `c` from each of the three trace terms, and `phiTri_smul_left`, `phiTri_smul_mid`, `phiTri_smul_right` give `c` from each of the three `Φ` terms. Additivity in `H` comes the same way from the `_add_` family. So `Pcubic2Lin R ·` is genuinely linear.

For `Pcubic2Quad R (c•H)`: `compOp2 (c•H) = c² • compOp2 H`, and each of `innerOp2 ((c•H).comp R) (c•H)`, `innerOp2 (R.comp (c•H)) (c•H)` and the three `Φ` terms carries `c` twice. So `Pcubic2Quad R ·` is degree-two homogeneous, and its polarisation is bilinear because every constituent is. So it is a genuine quadratic form.

**Nothing downstream reads either fact.** `Pcubic2Lin` and `Pcubic2Quad` occur in [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean), [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) and one line of [plan.md](../plan.md), nowhere else in the tree. So the unstated homogeneity is a future debt rather than a present hole: the estimate `|Pcubic2Quad R H| ≤ C‖H‖²` that Fréchet differentiability needs will consume the second homogeneity, and that estimate is correctly recorded as owed in both the docstring and the `lean/INDEX.md` row.

**Verdict, item 2: SPLIT CORRECT, BOTH HOMOGENEITIES TRUE AND UNSTATED, NOTHING DOWNSTREAM ASSUMES EITHER.**

## 3. The constant in `Pcubic2Lin_selfAdjoint`, verified independently of the proof

Three routes, all giving `3`.

*Operator-theoretic.* With `⟨A,B⟩ = Tr(A*B)` and `R* = R`: `⟨H∘R,R⟩ = Tr(R*H*R) = Tr(H*R²)`; `⟨R∘H,R⟩ = Tr(H*R*R) = Tr(H*R²)`; `⟨R²,H⟩ = ⟨H,R²⟩ = Tr(H*R²)` by symmetry of the pairing, needing no hypothesis. Sum `3⟨H,R²⟩`. Self-adjointness is used in the first two and not the third, which is what [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean)'s docstring says ("exactly one of the three needs cyclicity"), and that docstring's accounting is about which terms need `trOp_comp_comm`, a finer statement than mine and consistent with it.

*Against the derivation.* Step 4 gives `Tr(S*R²) + Tr(RS*R) + Tr(R²S) = 3Tr(S*R²)`, and `Φ(S;R,R)+Φ(R;S,R)+Φ(R;R,S) = 3Φ(S;R,R)`, so `DP(R)[S] = 3Tr(S*R²) − (3/2)Φ(S;R,R) = 3⟨S, R²+R#⟩`. Identical.

*Against the layer's own values.* `innerOp2_sharpMap_eq_phiTri R H : innerOp2 H (sharpMapCL R) = −½ Φ(H;R,R)`, so `−½ · 3Φ(H;R,R) = 3 innerOp2 H (sharpMapCL R)`, and `innerOp2_add_right` assembles `3⟨H,R²⟩ + 3⟨H,R#⟩ = 3⟨H, Qop2 R⟩`. The `3` is not an artefact of the proof's `ring` call.

**Verdict, item 3: CORRECT.** It carries `sorryAx` through `phiTri_first_variation`, which §9 records and which the file states.

## 4. `PcubicDiff`, and whether `PcubicDiff_eq_lin` is circular

`PcubicDiff R` is `LinearMap.toContinuousLinearMap` applied to `S ↦ 3 innerOp2 S (Qop2 R)`, with `map_add'` from `innerOp2_add_left` and `map_smul'` from `innerOp2_smul_left`. Boundedness is finite dimensionality, which is what `toContinuousLinearMap` supplies. The result inhabits `CurvOp2 (Fin n) →L[ℝ] ℝ`, which is `StrongDual ℝ (CurvOp2 (Fin n))`, and §5 records that it is accepted as such by `isLocalMaxOn_hasFDerivWithinAt_nonpos` inside the norm scope, which I compiled.

`PcubicDiff_apply` is a restatement of the definition and carries no content beyond confirming that `toContinuousLinearMap` did not change the function. `PcubicDiff_eq_lin` rewrites by it and by `Pcubic2Lin_selfAdjoint`, closing on `3 innerOp2 H (Qop2 R) = 3 innerOp2 H (Qop2 R)`. **It is not circular**: `Pcubic2Lin` is a standalone definition in terms of `innerOp2` and `phiTri`, `Pcubic2_expand` independently certifies that it is the linear part of the increment of `Pcubic2`, and `Pcubic2Lin_selfAdjoint` reaches its closed form through `trCube2_first_variation`, `phiTri_first_variation` and `innerOp2_sharpMap_eq_phiTri`, none of which mentions `PcubicDiff`. The dependency graph is a tree.

**Two reach findings.**

*The `Fin n` narrowing is gratuitous.* Every declaration in [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean) and [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) is stated at a general `{ι : Type*} [Fintype ι] [DecidableEq ι]`, and [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) alone drops to `Fin n`. **Screened**: the same definition, verbatim, elaborates at general `ι` under `lake env lean` with no error, so nothing about the bundling needs `Fin n`.

*The `lean/INDEX.md` row's axiom claim does not reach the file.* Row 138 reads "**`PcubicDiff R : CurvOp2 (Fin n) \to_L[\mathbb R]\mathbb R`**, $S\mapsto3\langle S,Q(R)\rangle$, standard three axioms." That is true of `PcubicDiff` and of `PcubicDiff_apply`, and false of the file's third declaration `PcubicDiff_eq_lin`, which carries `sorryAx`. The row is a file row and its status column says **proved**, so a reader takes the axiom claim as the file's. It should say what the row for [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) says, which names its `sorry` in the status column.

**Verdict, item 4: CORRECT AND NOT CIRCULAR**, with two reach findings.

## 5. The plumbing claim, reproduced rather than granted

**First half, reproduced exactly.** I rebuilt the bundling verbatim in a scratch file under `open scoped Matrix.Norms.Frobenius HamiltonsCubic.RealLayer.OperatorNorm` and `lake env lean` reports, at the `LinearMap.toContinuousLinearMap` line and nowhere else:

```
error(lean.synthInstanceFailed): failed to synthesize instance of type class
  IsTopologicalAddGroup (CurvOp2 (Fin n))
```

Removing that one scope from the `open scoped` line and changing nothing else, the same file elaborates with no output. **Both directions of the first half hold, and the named instance is the named instance.**

**Second half, inaccurate.** The docstring says *"That scope exists to make Fermat's `IsLocalMaxOn` elaborate"*, and [lean/INDEX.md](../lean/INDEX.md) row 138 and [plan.md](../plan.md) line 152 repeat it. `IsLocalMaxOn` over `CurvOp2` elaborates with no norm at all. Two things on file say so:

- [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) line 218, in the note r1007 forced: *"`IsLocalMaxOn` over `CurvOp2` elaborates with no `Norm`"*, going on to locate the real need precisely, *"The INFERENCE fails, on Fermat's theorem. `IsLocalMaxOn.fderivWithin_nonpos` and its siblings sit under `[NormedAddCommGroup E] [NormedSpace ℝ E]`"*, and closing *"The gap is Fermat alone."*
- [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) writes `IsLocalMaxOn Pcubic2 {S : CurvOp2 (Fin n) | normSq2 S = 1} R` in both `I36Shape` and `I36Budget` and opens no norm scope of any kind.

So the accurate statement is that the scope exists to make **Fermat's theorem**, `isLocalMaxOn_hasFDerivWithinAt_nonpos` and the three lemmas beside it, elaborate. Those four sit in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) after its own `open scoped OperatorNorm`, and that `open` is load-bearing. **This is the same conflation r1007 corrected once already**, asking whether `IsLocalMaxOn` could be *stated* where the question is whether it can be *used*.

**What in the layer actually consumes the scope, and what breaks without it.** Only [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean). The two `Results` files that open it, [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) line 27 and [CubicBridge.lean](../lean/HamiltonsCubic/Results/CubicBridge.lean) line 25, contain no `IsLocalMaxOn`, no `‖·‖`, no `NormedAddCommGroup` and no `NormedSpace`. **Checked rather than inferred**: I deleted `HamiltonsCubic.RealLayer.OperatorNorm` from both `open scoped` lines and ran a full `lake build`, which completed successfully over 9220 jobs, exit 0. The two `open`s are dead. I restored both files and the working tree is clean.

**And the tension the docstring names does not obstruct.** *"The two needs pull opposite ways"* reads as an unresolved conflict. It is not one. I compiled, inside the `OperatorNorm` scope, the exact composition the layer is heading for:

```lean
example (R : CurvOp2 (Fin n)) (s : Set (CurvOp2 (Fin n))) (a y : CurvOp2 (Fin n))
    (h : IsLocalMaxOn Pcubic2 s a)
    (hf : HasFDerivWithinAt Pcubic2 (PcubicDiff R) s a)
    (hy : y ∈ posTangentConeAt s a) : PcubicDiff R y ≤ 0 :=
  isLocalMaxOn_hasFDerivWithinAt_nonpos h hf hy
```

It elaborates with no error, so `PcubicDiff R`, built outside the scope on the native `ContinuousLinearMap` topology, IS the `f' : StrongDual ℝ (CurvOp2 (Fin n))` that Fermat's usable form consumes inside it. The reason is that the norm's topology on `CurvOp2` is definitionally the native one, which `with_unfolding_all rfl` closes. **The opposition is an elaboration-order inconvenience about where a definition may be written, not a conflict about what can be composed**, and nothing on file says so.

**Verdict, item 5: FIRST HALF REPRODUCED, SECOND HALF INACCURATE, AND THE TENSION DOES NOT OBSTRUCT.**

## 6. Does "no cheap route" follow from the screen?

The record's claim, [plan.md](../plan.md) line 152, quoted whole:

> **`phiTri_rotate` HAS NO CHEAP ROUTE, ESTABLISHED RATHER THAN ASSUMED** ([screen](../scripts/misc/screen_phitri_symmetry_group.py)): *of $\Phi$'s six slot permutations exactly TWO agree at arbitrary triples, the identity and the outer swap already proved, and the other four fail every trial*, **so `phiTri_swap_outer` generates nothing further and the rotation must be earned by the $\varphi$ expansion against two copies of the totally antisymmetric structure constants.**

**What the screen establishes.** Of the six slot permutations of `Φ`, four are refuted as unconditional identities by exact counterexamples at `n = 4`. Therefore the subgroup of `S₃` generated by the one proved unconditional non-identity, the outer swap, is exactly `{id, (A C)}` of order two, which contains no 3-cycle. **So `phiTri_swap_outer` cannot yield `phiTri_rotate` by composition with itself or with any other unconditional slot permutation.** That is sound, it is exactly the question the script's own docstring asks, and it is worth having.

**What the screen does not establish.** A route need not be a slot permutation, and the phrase "no cheap route" quantifies over all proofs. Taking the brief's four candidates in turn:

*A signed symmetry, `Φ(A;B,C) = −Φ(σ(A,B,C))`.* Untouched by the screen, which tests equality only. **Screened by me** (reported as a screen, not as evidence for a positive claim), six random triples at `n = 4`, exact rationals: all six signed permutations fail 6/6, including the trivial `Φ = −Φ`. Each failure is an exact counterexample, so this family is closed. Independently, a signed identity at the outer swap is already refuted by the unsigned one being proved, unless `Φ ≡ 0`.

*An identity mixing permutations, `Φ(A;B,C) + Φ(B;C,A) + Φ(C;A,B) = 0`.* Untouched by the screen. **Refuted from a value the record already holds**, with no new computation: at a self-adjoint `R` all three summands are `Φ(R;R,R)`, and [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)'s own docstring records `sharpPair2 = 12` against `phiTri = −24` at a genuine Weyl operator at `n = 4`, so the cyclic sum is `−72` there. My screen agrees, 6/6 nonzero at arbitrary triples. Closed. Mixing identities with other coefficients remain untouched by anything.

*A route through the adjoint.* **This is the live one and the screen is blind to it.** The derivation's own step 3 proves `Φ(A;B,C) = Φ(B;C,A*)` with no hypothesis, verified by [r1013](REVIEW_r1013.md) and [r1014](REVIEW_r1014.md), and my screen reproduces it 0/6 failures with an independently coded adjoint. [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)'s own docstring and [lean/INDEX.md](../lean/INDEX.md) row 139 both name it and both give the same blocker: *"stating it needs an adjoint on `CurvOp2` the layer does not carry"*. **That blocker is soft, and I screened the repair in Lean.** `IsSelfAdjoint2` is already a hand-written `Prop` on `CurvOp2` needing no instance; the same two lines give an adjoint relation, and the following elaborates under `lake env lean` with the single expected `sorry` warning:

```lean
def IsAdjoint2 (A A' : CurvOp2 ι) : Prop :=
  ∀ X Y : skewSub ι, inner2 ↑(A X) ↑Y = inner2 ↑X ↑(A' Y)

theorem isSelfAdjoint2_isAdjoint2 {A : CurvOp2 ι} (h : IsSelfAdjoint2 A) : IsAdjoint2 A A := h

theorem phiTri_starred {A A' : CurvOp2 ι} (_h : IsAdjoint2 A A') (B C : CurvOp2 ι) :
    phiTri A B C = phiTri B C A' := by sorry

theorem phiTri_rotate' {A : CurvOp2 ι} (hA : IsSelfAdjoint2 A) (B C : CurvOp2 ι) :
    phiTri A B C = phiTri B C A :=
  phiTri_starred (isSelfAdjoint2_isAdjoint2 hA) B C
```

`isSelfAdjoint2_isAdjoint2` closes by `h` alone, the two `Prop`s being definitionally the same at `A' = A`. **This does not prove the rotation**, and it does not avoid the six-index relabelling, which is what step 3 uses to prove the starred form. **It changes what the single remaining `sorry` is a debt for**, from a specialisation to the unconditional statement two reviewers verified, at no cost and with the consumer unchanged. The record's framing, that the rotation "must be earned", is what discourages taking it.

*A route through `trOp` cyclicity.* Untouched by the screen, and the file two sections above demonstrates the technique: `crossPair2_eq_trOp` rewrites `crossPair2` as `−½ trOp(ad_X R ∘ ad_Y R)` and `crossPair2_comm` then falls out of `trOp_comp_comm` with no index in sight. Read the same way, `Φ(A;B,C) = ∑_e trOp(adS e ∘ B ∘ adS (A e) ∘ C)`, and `trOp_comp_comm` moves `C` to the front freely. **What cyclicity does not do is exchange `e` and `Ae`**, which are pinned to the two `adS` factors, and that exchange is exactly where `A`'s self-adjointness enters. So this route reaches the same wall, which is an argument the record could make and does not.

**Verdict, item 6: OVERSTATED.** The claim as worded has no argument on file. What is established is the narrower statement, which should replace it: *of `Φ`'s six slot permutations only the identity and the proved outer swap are unconditional, so `phiTri_swap_outer` generates no 3-cycle and cannot yield the rotation on its own.* Adding my screen, the twelve signed and unsigned slot permutations and the cyclic sum are all closed too. **"No cheap route" is a claim about all proofs and no screen over slot permutations can reach it**; what would have to be shown is that every proof of the rotation passes through the two-structure-constant contraction, and that is not a statement a numerical screen can decide. **And the record itself already once found a cheap route where the derivation used indices**: [lean/INDEX.md](../lean/INDEX.md) row 139 says of the outer swap, *"That is cheaper than second-order.md's own route, which relabels six indices against two copies of the totally antisymmetric constants"*, which is the same expansion now asserted to be unavoidable for the rotation.

## 7. The screen's own soundness

**The negative half is sound.** A single exact counterexample refutes an identity claimed for all `ι`, because `Fin 4` is an instance of `{ι : Type*} [Fintype ι] [DecidableEq ι]` and a `∀ ι` statement is false as soon as one instance is. Two conditions have to hold for it to bite and both do. First, the script's `phiTri` is the Lean `phiTri`: same `−1/4`, same `inner2 = ½∑`, same sum over all ordered pairs `(i,j)` and `(k,l)` including `i = j`, same bracket. I read the two side by side. Second, the operators are genuine `CurvOp2` elements: `from_entries` reads `X` against the orthonormal `{φ_ij}_{i<j}` and returns a combination of the same, and `random_op(self_adjoint=True)` symmetrises the entry matrix in that orthonormal basis, which is exactly self-adjointness against `inner2`. Both hold. Each of the four permutations fails 8/8, so each has eight witnesses and one would do.

**The positive half is sampling, and the record's wording survives on its attribution.** Eight triples with entries drawn from `{−3,…,3}` at `n = 4`, under `random.seed(21)`, cannot establish "at self-adjoint triples all six agree". A negative from sampling is a proof and a positive is not, which is the asymmetry the brief names. The record's sentence, identical in [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean), [plan.md](../plan.md) and [scripts/INDEX.md](../scripts/INDEX.md), is *"At self-adjoint triples all six agree, which is the full symmetry of `T` that second-order.md's step 5 concludes."* **The attribution is what saves it**: the fact is asserted with step 5 named as its source, and step 5 does conclude it, from the rotation plus the outer swap generating `S₃`. So the screen is corroborating a derived consequence rather than sourcing an undemonstrated one, and I record the discrepancy as **withdrawn on the wording**, with one caveat kept.

**The caveat.** The relation is tighter than the record says, and saying it would make the screen more useful. At self-adjoint triples, all six agreeing is *equivalent* to `phiTri_rotate` restricted to those triples, given the outer swap. **So the positive half is a screen of the sorry'd lemma itself on a subdomain**, which is the strongest thing it does, and neither the script's docstring nor any of the three rows says so. The scripts row instead sells it as the symmetry of `T`.

**Verdict, item 7: NEGATIVE HALF SOUND, POSITIVE HALF IS SAMPLING BUT CORRECTLY ATTRIBUTED, AND UNDERSOLD.**

## 8. The two `sorry`s, and the second hypothesis placement

**`phiTri_rotate` is true and faithful.** True: it is step 3's second bullet, specialised from `Φ(A;B,C) = Φ(B;C,A*)` at `A* = A`, verified by [r1013](REVIEW_r1013.md) and [r1014](REVIEW_r1014.md) and reproduced by my own screen at 0/6 failures for the starred form. Faithful: the binder `{A} (_hA : IsSelfAdjoint2 A) (B C)` places self-adjointness on the first slot and leaves `B`, `C` free, which is what step 3 gives and what `phiTri_first_variation` consumes at `A := R`, `B := S`, `C := R`. The underscore on `_hA` is correct, an unused binder in a `sorry`'d statement being a statement of the hypothesis, not an admission that it is idle; the screen at [screen_phitri_constants.py](../scripts/misc/screen_phitri_constants.py), 12/12 failures without it, is on file for its necessity.

**`foxTri2_symm_right` is true and faithful.** It is step 5's conclusion at self-adjoint `X`, `Y`, `Z`, where the trace half is symmetric by cyclicity and `Tr M = Tr M*` and the `Φ` half by step 3. Its binders carry all three self-adjointness hypotheses, matching step 5's "at self-adjoint `X,Y,Z`".

**The second placement is real, and it is a corollary rather than an alternative.** The record says the hypothesis *"may sit on the FIRST slot or on the other TWO, both screened clean, the second being unexplained by the derivation as written and recorded as a screen rather than a claim."* It is not unexplained. It is two applications of the first placement:

> Let `B`, `C` be self-adjoint and `A` arbitrary. `phiTri_rotate` at `A := B` gives `Φ(B;C,A) = Φ(C;A,B)`. `phiTri_rotate` at `A := C` gives `Φ(C;A,B) = Φ(A;B,C)`. Hence `Φ(A;B,C) = Φ(B;C,A)`. ∎

**Machine-checked**, two rewrites and no `sorry` of its own:

```lean
theorem phiTri_rotate_twoslot {B C : CurvOp2 ι} (hB : IsSelfAdjoint2 B)
    (hC : IsSelfAdjoint2 C) (A : CurvOp2 ι) : phiTri A B C = phiTri B C A := by
  rw [phiTri_rotate hB C A, phiTri_rotate hC A B]
```

Three consequences the record should carry. **The second placement is strictly downstream of the first**, so it is not a second debt, and it opens no second route to a proof. **Neither placement is weaker than the other**: the converse fails, since `Φ` is trilinear while the self-adjoint operators form a subspace, and a trilinear identity holding with two slots restricted to a subspace does not extend to the third. **And weakening it further fails**: with only one of `B`, `C` self-adjoint the argument needs `Φ(C;A,B) = Φ(A;C,B)`, which is one of the four permutations the record's own screen refutes.

**Is the stated form the weakest useful one? No.** `phiTri_starred`, §6's one-line-definition version, has a strictly weaker hypothesis and a strictly stronger conclusion, and yields the stated form by `isSelfAdjoint2_isAdjoint2`. [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)'s docstring knows this and says so, while [plan.md](../plan.md)'s owed list does not.

**Verdict, item 8: BOTH `sorry`s TRUE AND FAITHFUL; THE SECOND PLACEMENT IS REAL AND IS A COROLLARY OF THE FIRST, MACHINE-CHECKED; THE STATED FORM IS NOT THE WEAKEST USEFUL ONE.**

## 9. `#print axioms`

Sixty-six declarations across the four files, run through `lake env lean` under Lean 4.33.1, after a `lake build` completing over 9220 jobs at exit 0, so no stale `.olean` is in play. **Fifty-nine carry the standard three**, `propext`, `Classical.choice`, `Quot.sound`. **Seven carry `sorryAx`**, from two independent sources:

| declaration | file | route to `sorryAx` |
|---|---|---|
| `phiTri_rotate` | [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) | **source**, its own `sorry` |
| `phiTri_first_variation` | [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) | `phiTri_rotate` |
| `hasDerivAt_sharpPair2_line_selfAdjoint` | [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) | `phiTri_first_variation` |
| `Pcubic2Lin_selfAdjoint` | [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean) | `phiTri_first_variation` |
| `PcubicDiff_eq_lin` | [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) | `Pcubic2Lin_selfAdjoint` |
| `hasDerivAt_Pcubic2_line` | [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) | `hasDerivAt_sharpPair2_line_selfAdjoint` |
| `foxTri2_symm_right` | [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) | **source**, its own `sorry` |

**Everything new this cycle that does not touch the rotation is kernel-clean**: `trCube2_expand`, `phiTri_expand`, `sharpPair2_expand`, `Pcubic2Lin`, `Pcubic2Quad`, `Pcubic2_expand`, `PcubicDiff` and `PcubicDiff_apply` all return the standard three. **This confirms plan.md's "carries `sorryAx` by INHERITANCE alone"** for `hasDerivAt_Pcubic2_line`, and extends the same finding to the four declarations the plan does not list.

## 10. Prose claiming more than is established

**(a) The plumbing claim, false as written.** [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean): *"**That scope exists to make Fermat's `IsLocalMaxOn` elaborate** ([r1008](REVIEW_r1008.md)), so the two needs pull opposite ways: the sup norm gives `IsLocalMaxOn` its normed space and takes the topological group structure `toContinuousLinearMap` wants."* Repeated verbatim in [lean/INDEX.md](../lean/INDEX.md) row 138 and, compressed, in [plan.md](../plan.md) line 152: *"that scope exists to make `IsLocalMaxOn` elaborate, so the two needs pull opposite ways"*. §5 above: `IsLocalMaxOn` needs no norm, Fermat's theorem does, and [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) line 218 says precisely that eighteen lines of its own prose. The second clause, "pull opposite ways", also overstates: the two compose, and I compiled the composition.

**(b) "No cheap route", the headline overstatement.** §6. [plan.md](../plan.md) line 152's *"HAS NO CHEAP ROUTE, ESTABLISHED RATHER THAN ASSUMED"* and *"the rotation must be earned by the $\varphi$ expansion against two copies of the totally antisymmetric structure constants"*. **This is proposal 150's shape, transposed from hypotheses to proof routes**: the screen shows one route is sufficient and available, and the prose asserts it necessary. That makes four occurrences of the shape on file. The [scripts/INDEX.md](../scripts/INDEX.md) row 428 for the same script is markedly more honest, confining itself to *"asks whether a SECOND easy transposition exists… It does not"*, which is what was tested. **The scripts row is the wording plan.md should adopt.**

**(c) An axiom claim that does not reach its file.** §4: [lean/INDEX.md](../lean/INDEX.md) row 138's "standard three axioms" against `PcubicDiff_eq_lin`'s `sorryAx`.

**Checked and found clean.** *"THE HYPOTHESIS IS LOAD-BEARING"* on `phiTri_rotate` is a necessity claim with a screen behind it and the screen is cited. *"THE HYPOTHESIS CANNOT BE DROPPED ONCE `3 ≤ |ι|`"* on `innerOp2_eq_trOp` is a necessity claim with an exhibited witness and a stated bound, repaired once by [r1016](REVIEW_r1016.md) and correct now. *"`crossPair2` IS ITSELF A TRACE, so it is SYMMETRIC by cyclicity with no hypothesis"* is exactly what `crossPair2_eq_trOp` and `crossPair2_comm` prove. *"The remainder is still only NAMED here, not estimated"* on `Pcubic2Lin` is accurate and is the kind of negative the record should keep. **And `sharpPair2_eq_phiTri`'s docstring claim that its constant was screened before the `sorry` was typed** checks out against [screen_phitri_constants.py](../scripts/misc/screen_phitri_constants.py), `12` against `−24`, and against [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)'s own proof, which needs no `sorry` at all.

## Overall verdict

**HYPOTHESIS-DEBT**, on item 6 alone. The Lean under items 1 to 4 and 9 is **PROVEN**: the three expansions are correct in all four parts and match step 4 term for term, the split is exact, both unstated homogeneities are true, the constant `3` verifies three independent ways, `PcubicDiff` is a genuine `StrongDual` computing what it should, `PcubicDiff_eq_lin` is not circular, and the `sorryAx` inheritance is exactly the two named sources. **The debt is the record's, not the mathematics'.**

**What would have to be proved for [plan.md](../plan.md) line 152 to stand as written**: that every proof of `phiTri_rotate` passes through the contraction of three matrices against two copies of the totally antisymmetric structure constants. That is a statement about the space of proofs, and no screen over slot permutations can decide it. **This claim has no argument on file.** What the screen does establish, and what the line should say, is in §6.

**Three repairs, in order of cost.** Replace [plan.md](../plan.md) line 152's headline with the screen's actual finding. Correct the `IsLocalMaxOn` attribution in [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean), [lean/INDEX.md](../lean/INDEX.md) row 138 and [plan.md](../plan.md) line 152 to name Fermat's theorem, and record that the two needs compose. Promote the `sorry` to `phiTri_starred` over an `IsAdjoint2` relation, which costs one definition, is the statement two reviewers verified, and leaves every consumer unchanged.
