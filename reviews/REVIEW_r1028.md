# Review r1028: four prose-correcting commits, checked against the declarations they name

Reviewer r1028, sole reviewer. Commits under review: `de542e3d`, `017b2561`, `5e040ea1`, `207f20d2`. Log: [agent_logs/r1028.log](../agent_logs/r1028.log).

Every kernel claim below was run with `lake env lean` from [lean/](../lean/) under the project's 4.33.1, on a tree whose `lake build` completes over **9225 jobs** with no error, which is the count `207f20d2` reports.

| # | Claim under review | Verdict |
| --- | --- | --- |
| 1 | `diagCubicFormula` is proved, and all repaired sites now say something true | **PROVED, and THREE of the thirteen repaired sentences are wrong** |
| 2 | The sweep for stale absence claims was complete | **REFUTED**, three further sites, one of them the definition itself |
| 3 | `L74Bridge` waits on `DiagCriticalityIsCritical` rather than `DiagCubicFormula` | **CONFIRMED**, and the kernel settles it. The sentence carrying it is malformed |
| 4 | `ProblemPNamed` is the goal, and the table's new warning is accurate | **CONFIRMED** |
| 5 | `de542e3d` folded r1026 and r1027 correctly | **REFUTED**, four verdicts reported and not carried |
| 6 | `017b2561` fixed its two absence claims, and no others remain | **CONFIRMED on the two, REFUTED as complete** |
| 7 | Overreach sweep over the four commits' own new sentences | Two, both small |

**The headline.** *The mathematics in these four commits is right, including the one re-attribution that looked most likely to be a second wrong guess.* **What fails is the same thing that failed in the round they are correcting: a substitution applied to the sentences a grep matched, leaving the sentences that carry the same claim in other words.** [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean) now says three different things about what `L74Bridge` waits on, in one file, from one commit.

## 1. `diagCubicFormula` is proved, and three of the thirteen new sentences are not true

**The declaration checks out.** `#print axioms HamiltonsCubic.RealLayer.diagCubicFormula` returns `[propext, Classical.choice, Quot.sound]`, and its type is [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s `DiagCubicFormula`, `∀ w, IsWeight w → Pcubic (diagOp w) = diagP w`. *The neighbouring `sharpQF_diagOp`, `sphereProductValue`, `br_phi_phi`, `hasFDerivAt_Pcubic2` and `PcubicDiff_eq_lin` are on the same three axioms, each checked here.*

**Ten of the thirteen repaired sentences are right.** Those in [L68Statement.lean](../lean/HamiltonsCubic/Results/L68Statement.lean), [L74Statement.lean](../lean/HamiltonsCubic/Results/L74Statement.lean), [L97Statement.lean](../lean/HamiltonsCubic/Results/L97Statement.lean), [L98Statement.lean](../lean/HamiltonsCubic/Results/L98Statement.lean) and [L99Statement.lean](../lean/HamiltonsCubic/Results/L99Statement.lean) each say that the file's own gap is a different object from `DiagCubicFormula`, which is now proved, and each is accurate. **The most careful of them is [L97Statement.lean:287](../lean/HamiltonsCubic/Results/L97Statement.lean#L287)**, which adds *as an OPERATOR* to distinguish what is owed, `sharpOp (diagOp w) (φ_ab)`, from what `sharpQF_diagOp` proves, the quadratic form `⟨(diagOp w)# φ_ab, φ_ab⟩`. *That distinction is exactly right and it is what makes the rest of the repair coherent.*

**THE THREE THAT ARE WRONG ARE ALL IN [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean), AND THEY CONTRADICT EACH OTHER.**

- **[L144Statement.lean:94](../lean/HamiltonsCubic/Results/L144Statement.lean#L94)**, on `L74Bridge`: *"It needs `Pcubic` on the diagonal locus, which is `DiagCubicFormula` and is PROVED in SharpDiag.lean, so it is a hypothesis in the same way `SphereProductValue` is there."* **The substitution broke the inference the sentence was carrying.** *The original read "owed by the base layer, so it is a hypothesis". "PROVED, so it is a hypothesis" is a non-sequitur, and the attribution it keeps is the one the same commit calls a misattribution at line 397.*
- **[L144Statement.lean:111](../lean/HamiltonsCubic/Results/L144Statement.lean#L111)**, under `## What is NOT typed here`: *"It reduces to `Pcubic` on the diagonal locus, which Families.lean states as `DiagCubicFormula` and SharpDiag.lean PROVES."* **As now written this says the file's remaining gap reduces to a proved theorem**, which would make `L74Bridge` dischargeable today. *It is not: [plan-lean.md](../plan-lean.md) records `L74Bridge` as concluded by nothing, and section 3 below shows what it actually needs.*
- **[L144Statement.lean:397](../lean/HamiltonsCubic/Results/L144Statement.lean#L397)**, the `L74Bridge` docstring, is the one the commit rewrote, and it is malformed in three ways. *The edit replaced only the tail of the sentence, so it now reads "it needs `Pcubic` evaluated on the diagonal locus, [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s the CRITICALITY equation `DiagCriticalityIsCritical`", with a dangling possessive and a live link to the wrong file.* **`DiagCriticalityIsCritical` is not in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)**: it is defined twice, at [L68Statement.lean:445](../lean/HamiltonsCubic/Results/L68Statement.lean#L445) and [L74Statement.lean:422](../lean/HamiltonsCubic/Results/L74Statement.lean#L422), which is what [plan-lean.md](../plan-lean.md)'s own row for it says. **And the clause it keeps, *"it needs `Pcubic` evaluated on the diagonal locus"*, is `DiagCubicFormula`'s content rather than `DiagCriticalityIsCritical`'s**, so the repaired sentence attaches the new name to the old description.

**The count in the commit message is thirteen, not ten.** *Three sentences in [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean) and two in each of the other five files.* Section 7.

**One softer point, recorded without a defect finding.** Lines 95 and 398 both compare `L74Bridge` to `SphereProductValue` as a hypothesis *"carried there"*. That is literally still true, `theta_sphereProduct` in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) taking it as a binder, but `sphereProductValue` is **proved** in [SphereValue.lean](../lean/HamiltonsCubic/Base/SphereValue.lean) on the standard three axioms, so the analogy now points at a discharged obligation.

## 2. The sweep was incomplete, and one of the misses is the definition itself

**The commit's grep ran over [lean/HamiltonsCubic/Results/](../lean/HamiltonsCubic/Results/) and stopped there.** Running the rule's reverse direction over the whole tree gives three further sites that assert the absence a declaration falsifies.

| Where | What it says | Why it is false |
| --- | --- | --- |
| [Families.lean:650](../lean/HamiltonsCubic/Base/Families.lean#L650), the `DiagCubicFormula` docstring | *"**THE ONE THING OWED ABOUT THE DIAGONAL LOCUS, NAMED RATHER THAN ASSUMED.** … It needs `sharpOp` evaluated on the `φ` basis, which this file does not do; [L96](../lean/HamiltonsCubic/Results/L96Statement.lean) records the same gap"* | `diagCubicFormula` proves it, and [L96Statement.lean:503](../lean/HamiltonsCubic/Results/L96Statement.lean#L503) says *"THE `DiagCubicFormula` HYPOTHESIS IS GONE"*. **A reader arriving at the definition meets "THE ONE THING OWED"** |
| [L96Statement.lean:72](../lean/HamiltonsCubic/Results/L96Statement.lean#L72) | *"`Pcubic` on the locus is not part of that gap: it is [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s `DiagCubicFormula`, carried as the hypothesis that file states it to be"* | It is proved, not carried. **This is in the file the commit message names as the one that "already knew"** |
| [lean/INDEX.md:642](../lean/INDEX.md#L642), the L57 note | *"**The whole of it is `sharpOp (diagOp w)` evaluated on the $\varphi$ basis, which no file does.**"*, and *"**AND THE SECOND IS `DiagCubicFormula` UNDER ANOTHER NAME**"* | `sharpQF_diagOp` evaluates it on the basis, and the *"under another name"* wording is the one [r1001](REVIEW_r1001.md) refuted and [ATTEMPTS.md](../ATTEMPTS.md) records as corrected at five sites |

**And the neighbouring claims the brief names.** [SharpDiag.lean:22](../lean/HamiltonsCubic/Base/SharpDiag.lean#L22) opens *"The whole gap is `sharpOp (diagOp w)` on the `φ` basis, **which no file evaluates**"* and line 33 of the same header says *"**`sharpQF_diagOp` is PROVED here**, … and it was the whole of the missing evaluation"*. *The first is meant historically and reads as present tense, eleven lines above its own refutation.* **`DiagCriticalityIsCritical` carries no stale absence prose**: every site describing it as owed is accurate, since nothing concludes it.

## 3. The `L74Bridge` re-attribution is right, and the kernel settles it

**`IsCritical R th` is `Qop R (φ_ij) = th • R (φ_ij)` at every pair**, [WeylReal.lean:194](../lean/HamiltonsCubic/Base/WeylReal.lean#L194), so it needs `sharpOp (diagOp w)` as a vector at each basis direction. *`sharpOp` is built from `sharpBil`, which reads `sharpQF` at `X + Y`, so it needs the quadratic form at a SUM of basis bivectors where [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean) proves it at a single one.* **The commit's reason for the gap is therefore exact, and so is its claim that the gap is still open.**

**The value half does not need `DiagCubicFormula` either, which is the part that could have gone wrong and did not.** `L74Bridge` concludes `∃ th, IsCritical (diagOp …) th ∧ th^2 = Γ.thetaSq`, so a value fact is in play. **But [srg_theta_closed_form](../lean/HamiltonsCubic/Results/L74Statement.lean#L438) proves the near-identical statement from `DiagCriticalityIsCritical` as its ONLY binder**, the multiplier coming from `theta_of_critical_unit` through `Pcubic_eq_inner_Qop` and the closed form from `srg_isDiagCritical`, both proved outright. *At unit norm `P(R) = ⟨R, Q(R)⟩ = th`, so criticality delivers the multiplier and no evaluation of `Pcubic` on the locus is needed.* **So `DiagCubicFormula` is not what `L74Bridge` waits on, in either conjunct**, and the re-attribution replaces a wrong claim with a right one.

**What is wrong is only the sentence**, section 1, together with lines 94 and 111 left carrying the attribution this line abandons.

## 4. `ProblemPNamed` is the goal. CONFIRMED

**It unfolds as the commit says.** `#print` gives `ProblemPNamed = RealLayer.ProblemP IsSphereProduct`, and [ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean#L201) is `12 ≤ Fintype.card ι → ∀ R, IsWeyl R → normSq R = 1 → ∃ S, IsWeyl S ∧ normSq S = 1 ∧ IsSphereProduct S ∧ Pcubic R ≤ Pcubic S`. **[README.md:16](../README.md#L16) asks for `P` on the unit sphere to be maximised on the Weyl tensor of products of spheres when `n ≥ 12`**, and the two agree on the bound, the constraint and the competitor. *The existential over sphere products is the supremum over splits, which is the conjecture's conclusion.*

**It is genuinely consumerless**: the only occurrences in the tree are its definition and [plan-lean.md](../plan-lean.md)'s row. **So the shape the commit describes is real, and the inference from it is sound**: nothing distinguishes a goal from an abandoned hypothesis in that table, and the row's own columns say *defined once, taken by nothing, concluded by nothing* of both. **The generated warning is accurate as written**, and putting the fact beside the definition rather than in the generated file is the right placement, since [plan-lean.md](../plan-lean.md)'s header says a hand edit is the one way it can lie.

**One qualification on reach.** *"A reader working that table as a debt list would delete the statement of the problem"* is right about the NAMED statement. [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s parametrised `ProblemP` would survive such a deletion, so what would be lost is the one place the goal is asserted about a constructed family, which is still the thing worth keeping.

## 5. r1026 and r1027 were read and four of their verdicts did not reach the record

**What did land, correctly.** *The "two moves" paragraph in [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean), the `PcubicDiffS` docstring's false topology claim, the `‖c n‖ → ∞` sentence in [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean) with `d n → 0` added and `sphereCurve_mem` credited with the middle obligation, the fifth ordinal and the `sorryAx` attribution in [lean/INDEX.md](../lean/INDEX.md)'s `PcubicDiff.lean` row, the new [SphereCurve.lean](../lean/HamiltonsCubic/Results/SphereCurve.lean) index row, and the regenerated [plan-lean.md](../plan-lean.md).* **Each is accurate**, and the `SphereCurve.lean` claim is checked here against the parent commit's index: it was the only file under `Results/` with no row.

**WHAT DID NOT LAND.** *Each was named by at least one reviewer and each still stands after all four commits.*

| Site | What it still says | Who refuted it |
| --- | --- | --- |
| [lean/INDEX.md:143](../lean/INDEX.md#L143), same row the commit edited | *"**NOT stated**: Fréchet differentiability itself, which needs an estimate on `Pcubic2Quad` that nothing supplies"* | [r1026](REVIEW_r1026.md) §5 and [r1027](REVIEW_r1027.md) §5: `abs_Pcubic2Quad_le` supplies it and `hasFDerivAt_Pcubic2` states it |
| [lean/INDEX.md:145](../lean/INDEX.md#L145), the `FirstVariation.lean` row | *"**NOT stated**: the Fréchet form `HasFDerivAt`, … owed beyond the line form"* | [r1027](REVIEW_r1027.md) §5, *"stale as an owed-claim"* |
| [plan.md:146](../plan.md#L146) | *"what is proved is a GATEAUX derivative where it wants a FRÉCHET one"* | [r1027](REVIEW_r1027.md) §5. **`017b2561` edited the I36 block six lines below and left this** |
| [PcubicDiff.lean:38](../lean/HamiltonsCubic/Results/PcubicDiff.lean#L38) | *"while the `HasFDerivAt` statement itself is not"* | [r1026](REVIEW_r1026.md) §7.4 |
| [Frechet.lean:40](../lean/HamiltonsCubic/Results/Frechet.lean#L40), [SphereCurve.lean:9](../lean/HamiltonsCubic/Results/SphereCurve.lean#L9), [PcubicDiff.lean:39](../lean/HamiltonsCubic/Results/PcubicDiff.lean#L39) | *"which no owed list outside [plan.md](../plan.md) names"* and *"on no one's list but the plan's"* | [r1026](REVIEW_r1026.md) §7.5 and [r1027](REVIEW_r1027.md) §7: [lean/INDEX.md:143](../lean/INDEX.md#L143)'s own **NOT stated** field names it, *"and the tangent cone at the constraint set"* |

**AND THE COMMIT LEFT [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean) SAYING BOTH THINGS.** Lines 13 to 17 still read *"So a `CurvOp2 ι →L[ℝ] ℝ` built OUTSIDE the scope carries `ContinuousLinearMap.topologicalSpace` and a `HasFDerivAt` about it elaborates with a MIXED instance set"*, which is the sentence [r1026](REVIEW_r1026.md) §7.1 and [r1027](REVIEW_r1027.md) §7.1 both refuted with a printed instance set, *and the paragraph the commit wrote eight lines below says the mixing lives in `HasFDerivAt`'s own instance arguments rather than in where the functional was built.* **The rewrite went in above the sentence that needed it and the two now contradict each other.** [r1027](REVIEW_r1027.md)'s recommendation 4 asked for that paragraph specifically.

**One markup defect introduced.** [lean/INDEX.md:143](../lean/INDEX.md#L143) now opens an emphasis inside an emphasis, `*…recorded as carrying `sorryAx`…, *which `#print axioms` REFUTES*: …*`, which renders as the inverse of what is meant.

## 6. The two absence claims are fixed, and others in the same files are not

**Both named sites are now correct.** [CubicTri.lean:346](../lean/HamiltonsCubic/Results/CubicTri.lean#L346) names `hasFDerivAt_Pcubic2` as the carrier and scopes its remaining absence to the file, and [plan.md](../plan.md)'s I36 OWED line strikes the estimate and credits `abs_Pcubic2Quad_le`. *Neither overshoots.*

**THE ONE THE SWEEP SHOULD HAVE CAUGHT AND DID NOT IS TWELVE LINES FROM A LINE THE NEXT COMMIT EDITED.** [L68Statement.lean:80](../lean/HamiltonsCubic/Results/L68Statement.lean#L80) says the file's `sorry` needs *"the bracket `[φ_ab, φ_cd]` on the whole `φ` basis (the structure constants of `𝔰𝔬(n)` in the pair basis) **which no file of the base layer carries**"*. **[br_phi_phi](../lean/HamiltonsCubic/Base/StructureConstants.lean#L44) is exactly that object**, all four indices, in closed form, proved on the standard three axioms, and [SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean) is built on it. *What may still be missing is the case analysis the same sentence goes on to name, which is a claim about the derivation rather than about the base layer's declarations.* **`207f20d2` edited line 92 of this file and line 80 was not matched, because the grep was for a NAME and this absence is written about an object.**

**The rest of the tree-wide absence prose under [Results/](../lean/HamiltonsCubic/Results/) holds.** *Checked: the `no layer below` pair in [L98Statement.lean](../lean/HamiltonsCubic/Results/L98Statement.lean) about the symmetry defect, [L99Statement.lean:96](../lean/HamiltonsCubic/Results/L99Statement.lean#L96) on `Qop` restricted to a block, and [L97Statement.lean:287](../lean/HamiltonsCubic/Results/L97Statement.lean#L287) on the operator form. Each names an object no declaration supplies.*

## 7. Overreach sweep. Two, both small

**7.1 "ten claims across six files" is thirteen.** *The diff changes three prose sites in [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean) and two in each of the other five, thirteen insertions against thirteen deletions.* **The undercount matters only because the count is the commit's evidence that the grep was thorough.**

**7.2 "L96Statement.lean already knew" is true of one site in that file and false of another.** [L96Statement.lean:503](../lean/HamiltonsCubic/Results/L96Statement.lean#L503) does say the hypothesis is gone, and [L96Statement.lean:72](../lean/HamiltonsCubic/Results/L96Statement.lean#L72) says it is *"carried as the hypothesis that file states it to be"*. *The file is the commit's example of the failure mode being absent and carries an instance of it.*

**What the sweep did not find.** *No false theorem, no wrong axiom claim, and no bound asserted beyond what is proved.* **The build is clean at 9225 jobs, `diagCubicFormula` and every declaration cited beside it are on `[propext, Classical.choice, Quot.sound]`, and the one substantive mathematical judgement in the four commits, that `L74Bridge` waits on the criticality equation, is right.**

## Recommendations, in the order they cost least

1. **Rewrite [L144Statement.lean:397](../lean/HamiltonsCubic/Results/L144Statement.lean#L397) as one sentence**: `L74Bridge` needs `IsCritical` at the diagonal locus, which is `DiagCriticalityIsCritical`, stated in [L68Statement.lean](../lean/HamiltonsCubic/Results/L68Statement.lean) and [L74Statement.lean](../lean/HamiltonsCubic/Results/L74Statement.lean) and owed, *and say that `srg_theta_closed_form` proves the near-identical statement from it alone.*
2. **Carry that attribution to [L144Statement.lean:94](../lean/HamiltonsCubic/Results/L144Statement.lean#L94) and [L144Statement.lean:111](../lean/HamiltonsCubic/Results/L144Statement.lean#L111)**, which are the sites a reader meets first.
3. **Repair the three absence claims of section 2**, the [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) docstring first, since it is the definition every consumer reads.
4. **Strike the four stale owed-claims of section 5 and replace [Frechet.lean](../lean/HamiltonsCubic/Results/Frechet.lean)'s diamond paragraph**, which is [r1027](REVIEW_r1027.md)'s recommendation 4 unactioned.
5. **Fix [L68Statement.lean:80](../lean/HamiltonsCubic/Results/L68Statement.lean#L80)** to name `br_phi_phi` and scope what remains to the case analysis.
