# Review r1087, the L74 witness, the weight identity, the status gate and the two verdicts r1086 never reached

*COLD Gate 2 review, sole reviewer, of `61a12a9e`, `6dd3a495` and `15b1ff3e`. Log: [r1087-rounds.log](../agent_logs/r1087-rounds.log). Rows were written the moment each claim settled, because [r1086](REVIEW_r1086.md) was stopped mid-round and its settled verdicts survived only as log lines. The Lean verdicts are `#print axioms` and `#check` against the prebuilt oleans, run from a scratch file outside `lean/`; the hook verdict is the hook RUN in a detached worktree, against a copy of [STATUS.md](../STATUS.md); the record verdicts are greps over every `.md` outside [reviews/](.).*

| # | claim | verdict |
|---|---|---|
| C1 | `srg_theta_closed_form_at` / `_at_uncond` state L74's four facts at the explicit witness, proof MOVED not duplicated | **CONFIRMED**, on all three clauses |
| C2 | `graphWeight_eq_srgWeight` holds with no hypothesis, the two weights are one matrix | **CONFIRMED**, and it holds at the degenerate `v - 1 - k = 0` too |
| C3 | what `L74Bridge` still needs is the scale alone | **CONFIRMED as content**, with four bookkeeping steps the commit does not list, all on file |
| C4 | the pre-commit hook now reports the position-gate messages and triggers on `STATUS.md` | **CONFIRMED on the grep, REFUTED on the trigger**: the hook exits before reaching it, and three evasions survive |
| C5 | F74's verdict is recorded where a reader meets it, and no site reports the $\mathcal D_n$ family as live | **REFUTED**, [findings/INDEX.md](../findings/INDEX.md) carries the version three reviewers refuted |
| C6 | the `sharpBil_symm` void is justified | **CONFIRMED**, with two corrections to the reason recorded for it |
| C7 | the corrected `weylModule` claim in [lean/INDEX.md](../lean/INDEX.md) is now right | **REFUTED on the reason, CONFIRMED on the absence**, and it repeats the session's own pattern in a milder form |

## C1, the witness form: CONFIRMED on all three clauses

**The hypotheses are identical and the conclusion is the four facts at the witness.** `#check` returns `srg_theta_closed_form_at` taking `DiagCriticalityIsCritical`, `IsSRG A v k lam mu`, `0 < v`, `0 < k`, `0 < v - 1 - k`, `0 < v - 1`, exactly the list the existential form took, and concluding `IsWeyl`, `normSq = 1`, `IsCritical … (thetaSRG v k lam)` and `theta … = thetaSRG v k lam` at `diagOp (√(2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k))`. *Nothing was added, dropped or weakened.*

**The proof MOVED.** The body occurs once: the two hits each for `srg_unit_scale_sq hA hwne hvne hkne hune hs2` and for `nlinarith [hcrit]` are both inside `srg_theta_closed_form_at`, discharging its two `?_` goals at lines 450/460 and 459/469. [srg_theta_closed_form](../lean/HamiltonsCubic/Results/L74Statement.lean) is now `⟨_, srg_theta_closed_form_at hbridge hA hv hk hw hu⟩`, one line.

**Axioms, on the five declarations the two commits touch**: `propext`, `Classical.choice`, `Quot.sound`, and nothing else. *No `sorryAx`, so the witness form is not resting on the file's history of gaps.*

**One precision.** The four-fact CONCLUSION is now written out twice in the file, at `srg_theta_closed_form_at` and again at `srg_theta_closed_form_at_uncond`, each time spelling the square root in full. *That is statement duplication rather than proof duplication, so the commit's claim stands as made, and it is two things to keep in step if the scale is ever restated.*

## C2, one matrix: CONFIRMED, and hypothesis-free in the strong sense

**`#check` returns no hypothesis at all** beyond the instance binders: `graphWeight A k = srgWeight A (tOf ↑(Fintype.card ι) k)` at every `A` and every `k`. *No hollowness, no regularity, no `IsSRG`, no positivity.*

**It is right from the definitions, on the diagonal as well as off it.** Both carry the same `if a = b then 0`, so the diagonal closes by `rfl`. Off it, `A - (1 - A)t` and `(1 + t)A - t` are the same polynomial, which is the `ring` step. **And the degenerate case is covered rather than excluded**: at `v - 1 - k = 0` Lean's division gives `tOf = 0` and both sides collapse to `A`, so the equality survives where the surrounding theorems need `0 < v - 1 - k`.

**One caveat for a consumer.** The right-hand side is `tOf (Fintype.card ι) k`, while [L74Statement.lean](../lean/HamiltonsCubic/Results/L74Statement.lean)'s theorems are stated at `tOf v k`. *The two agree through `IsSRG.card`, so the rewrite is available, and it is a step rather than nothing.*

## C3, the scale alone: CONFIRMED as content, and here is the rest of the list

**Traced from `L74Bridge`'s statement to `srg_theta_closed_form_at_uncond`, every step named.** The bridge takes `Γ : SRG`, `A`, `t > 0`, `Realises Γ A` and `normSq (diagOp (t • graphWeight A Γ.k)) = 1`, and owes `∃ th, IsCritical … th ∧ th ^ 2 = Γ.thetaSq`. What it consumes:

| step | supplied by | state |
|---|---|---|
| L144's `IsSRG` to L74's | `IsSRG.toL74`, with `hcard` from `Realises.1` and `hid` from `SRG.hident` cast to $\mathbb R$ | **on file**, the cast needing `v - k - 1` read as `v - 1 - k`, a `ring` step |
| `0 < v`, `0 < k`, `0 < v - 1 - k`, `0 < v - 1` | `SRG.hk` and `SRG.hklt`, the second through `realises_w_pos` | **on file** |
| `graphWeight A k = srgWeight A (tOf v k)` | `graphWeight_eq_srgWeight` plus the `card` rewrite | **on file as of `6dd3a495`** |
| `t` equals the theorem's named square root | uniqueness of a positive normalising scale | **the gap the commit names** |
| `thetaSRG v k lam ^ 2 = Γ.thetaSq` | `thetaSRG_sq_eq_L144_form`, which returns `SRG.thetaSq`'s formula verbatim | **on file** |

**So the claim is right about CONTENT and understates the bookkeeping.** *Four of the five rows are steps rather than nothing: a cast, a `ring` on `v - k - 1`, a `card` rewrite and a second use of `hid`.* **None of them is a gap, and no sixth row exists.** In particular the two side conditions the brief asks after are both discharged: `card` comes from `Realises.1` and `hident` is a field of `SRG`; and `tOf`'s division is safe because `realises_w_pos` derives `0 < Fintype.card ι - 1 - Γ.k` from `SRG.hklt`, so the denominator is positive at every point the bridge is applied.

**The scale step itself needs symmetry and hollowness of the weight**, which is what `diagOp_normSq_smul` asks for. *Hollowness is definitional in `graphWeight` and symmetry comes from `Realises`, so the last row is the arithmetic and nothing more.*

**And the absence claim was tested by object rather than by name.** *At `6dd3a495` no declaration in the tree normalises a positive scale, under that name or any other: `diagOp_normSq_smul` in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) gives the degree-two homogeneity and stops there.* **So C3 does NOT repeat the session's invented-name failure.** The parent has since begun `I73ScaleUnique.lean`, which was untracked while this round ran and is not reviewed here.

## C4, the status gate: CONFIRMED on the grep, REFUTED on the trigger

**The grep fix is real and it was reproduced.** *Collapsing [STATUS.md](../STATUS.md)'s chain into one prose line AND moving the section's stamp, so the stale-stamp message does not fire, makes [status_report.py](../scripts/misc/status_report.py) exit 1 with two POSITION lines and nothing else.* Under the pre-`15b1ff3e` grep that run prints NOTHING and the commit blocks with no reason shown. Under the new grep both lines print. **The defect the commit claims as its own is exactly as described, and the repair works.**

**THE `STATUS.md` TRIGGER IS UNREACHABLE, so the second half of the commit is inert.** [.githooks/pre-commit](../.githooks/pre-commit) line 27 reads `[ -n "$STAGED" ] || exit 0`, where `STAGED` is the staged files matching `^lean/.*\.lean$`. *The whole hook therefore exits 0 before the status block whenever no Lean file is staged.* **Run in a detached worktree with only a fully collapsed STATUS.md staged, the hook printed nothing and exited 0.** So a `STATUS.md`-only commit still skips the gate, for a reason the commit message does not name, and the same holds for the `plan.md` trigger that has been in the regex since the gate was written. *The hook's own comment, "a commit that touches plan.md or lean/ has moved something the file describes, so the file is checked HERE", has never been true of a commit that touches neither `lean/*.lean`.* **The repair is to move the status block above the `STAGED` early exit**, or to gate the early exit on the union of the two triggers.

**Three evasions, run rather than reasoned, each exiting 0 with a position that is collapsed or unbounded.**

1. **The whole chain on ONE arrow bullet, padded with two decoys.** `check()` counts lines beginning `- ←` and wants three or more, then looks for run-together arrows only on lines that do NOT begin `- ←`. *So `- ← P ← R25 ← I104 ← I110 ← I73` plus two filler bullets passes both tests.* **This is precisely the collapse the gate exists to catch**, and it is the shape a writer under brevity pressure reaches for first. The repair is one line: count arrows WITHIN each bullet as well as bullets.
2. **Rename the heading.** The shape check runs only over sections whose name starts with "The position, from the goal". *With the heading changed to anything else, the loop has no iterations and a fully collapsed chain exits 0.* An absent section is silent for the same reason, and [status_report.py](../scripts/misc/status_report.py)'s own `paste()` already prints "the paste is INCOMPLETE" in that case, so the check it needs is written elsewhere in the same file.
3. **Drop the `[budget: N words]` marker from a heading.** `check()` skips every section with `cap is None`. *Deleting the marker from "Share of the work towards P" and adding four hundred words exits 0, where the same padding with the marker in place reports OVER BUDGET at 903 words against 110 and STALE STAMP beside it.* **So the budget and the stamp are both opt-in from the file being checked.**

*Evasions 2 and 3 are the same hole in two places: the gate identifies what to check by matching text the checked file controls.*

## C5, F74's reach: REFUTED, and the record asserts both versions

**The verdict reached two sites and missed the one a reader consults first.** [fence-posts.md](../findings/fence-posts.md) carries it at line 653, above "What a successor must clear" as the commit says, and [INDEX-traps.md](../findings/INDEX-traps.md) row 74 carries it. [DECISIONS-TO-MAKE.md](../DECISIONS-TO-MAKE.md) is clean, [plan.md](../plan.md) has no $\mathcal D_n$-ceiling item, and no other file in the record reports the family as live.

**[findings/INDEX.md](../findings/INDEX.md) line 36 still carries the version of 2026-09-22, which three reviews refuted and post F74 itself corrects.** Blamed to `408f6763`, it reads:

> **[Post F74](fence-posts.md), 2026-09-22**: the $\mathcal D_n$ ceiling on $P(D)$ closes part of [I104](../plan.md)'s window at $n\le8$ and NOTHING at $n\ge9$ … at the Gram floor. *Reading the maximum inflates the reach to $n\le10$.*

| clause at [findings/INDEX.md](../findings/INDEX.md):36 | post F74's own text |
|---|---|
| closes at $n\le8$, NOTHING at $n\ge9$ | reach is $n\le10$, shares $65.6/56.5/41.4/30.8/13.7$ at $n=6\ldots10$ |
| the floor is Gram | the floor is $\max(f_{\mathrm{Gram}},f_d)$, and Gram alone hides $n=9$ and $n=10$ |
| reading the maximum INFLATES the reach to $n\le10$ | the near-miss is REAL, and the maximum coincides with the minimum at the window's left endpoint |
| no verdict | the family is SPENT, user's decision of 2026-09-23 |

**So the record asserts the corrected reach in one index and the refuted reach in the other**, and the refuted one is the file a reader opens for what a post settled. *This is the same shape [r1074](REVIEW_r1074.md) found inside F74 itself: a sentence surviving its own refutation because the fold repaired the post and not its index row.* **The repair is to rewrite that line to the corrected shares, the $\max$ floor, and the spent verdict.**

**One more, smaller.** Post F74's heading still reads "MISSES $n=11$ by $0.13\%$, the only case left open" with no marker that the family is spent, so the verdict sits nineteen lines below the heading that introduces it. *That is where the commit says it put it, and a reader who reads the heading and the first paragraph meets the route as live.*

## C6, the `sharpBil_symm` void: CONFIRMED, with two corrections to its reason

**All three declarations are real, at general $\iota$ over $\mathbb R$**, and the trailer's claim that no declaration holds the trilinear form's symmetry is false. So the `Lean: void` is justified.

- `foxTri_comm`, [FoxProduct.lean:300](../lean/HamiltonsCubic/Base/FoxProduct.lean), slots one and two of `foxTri` on `CurvOp ι`, no hypothesis.
- `foxTri2_symm_right`, [FirstVariation.lean:113](../lean/HamiltonsCubic/Results/FirstVariation.lean), slots two and three of `foxTri2` on `CurvOp2 ι`, needing `IsSelfAdjoint2` on the two slots being swapped and nothing on the first.
- `foxTri_symm_right_extend`, [FoxBridge.lean:82](../lean/HamiltonsCubic/Results/FoxBridge.lean), slots two and three of `foxTri`, **at extensions only**.

**CORRECTION ONE: the three are not three holds of ONE form.** *`foxTri` is over `CurvOp ι` with `sharpOp`, and `foxTri2` is over `CurvOp2 ι` with `sharpMapCL`.* So `foxTri_comm` and `foxTri2_symm_right` are about different forms on different types, and pairing them as "slots one and two" plus "slots two and three" of a single object is wrong as written. **The form whose full symmetry IS held is `foxTri2`**, by `foxTri2_comm` (no hypothesis) together with `foxTri2_symm_right`, and `foxTri2_comm` sits four lines above the theorem the row cites. *On the bare layer the symmetry holds only through `foxTri_symm_right_extend`, whose own docstring puts its reach at the image of `extend`, "a PROPER subset even of the operators factoring through `skewProj`" ([r1020](REVIEW_r1020.md)).* **The row should cite `foxTri2_comm` where it cites `foxTri_comm`.**

**CORRECTION TWO: the "applicable door" is right about $Y_0$ and silent about its TYPE.** [pairDir](../lean/HamiltonsCubic/Results/I73PairDirection.lean) is `(1/2) • (vecMulVec u v + vecMulVec v u)`, a symmetric `Matrix N N ℝ`, so $Y_0$ is self-adjoint and is not Weyl, exactly as the row says. *`foxTri2_symm_right` asks for `CurvOp2 ι`, a continuous linear map on `skewSub ι`, and nothing in the tree carries a matrix over the bivector index into that type.* **So "L233's assembly has no blocker left that anyone has named" is true of the mathematics and understates the writing**: re-typing $Y_0$ as a `CurvOp2` is the first step of the assembly and it is not a rewrite.

## C7, the corrected `weylModule` row: REFUTED on the reason

**The positive half is right.** [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean) is a `Submodule ℝ (CurvLin ι)` with carrier `{R | IsWeylL R}` and all three membership proofs written out, so [r1086](REVIEW_r1086.md)'s B3 stands and the old reason, "`IsWeyl` being a predicate with nothing constructing the projection", was indeed wrong. **The absence is real too**: no `weylProj`, no `orthogonalProjection`, no decomposition and no idempotent onto the Weyl space exists anywhere in [lean/HamiltonsCubic/](../lean/HamiltonsCubic/), under that name or any other.

**But the replacement reason points at the wrong space, and the file that says so is in the same tree.** [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean) is titled *"`weylModule` has a NONZERO RADICAL, so it is not the record's $\mathcal W_n$"* and proves it: `mem_weylModule_of_kills_skew` puts every linear map killing every bivector inside `weylModule`, so $\dim$ `weylModule` $=\dim\mathcal W_n+n^2\cdot n(n+1)/2$, **170 against 10 at $n=4$**. Two consequences for the row:

- **An orthogonal projection onto `weylModule` is ill-posed rather than unbuilt.** `innerOp` is a SEMI-inner product there, `symOp` being a nonzero member of norm zero, which is that file's own headline. *So the missing object is not waiting on an inner product: in the record's pairing it does not exist on that space.*
- **The row the correction repairs wants the projector onto $\mathcal W_n$**, for the $\Lambda^4$ component of the sharing case at [I73PairObstruction.lean](../lean/HamiltonsCubic/Results/I73PairObstruction.lean). *Projecting onto `weylModule` would project onto a space seventeen times too large at $n=4$, and the radical term is not even a function of the operator restricted to $\Lambda^2$.*

**And "needs the inner-product structure rather than the module structure" is false of the type where the record's $\mathcal W_n$ actually lives.** [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean) builds `curvOpCore : InnerProductSpace.Core ℝ (CurvOp2 ι)` over the record's own pairing, definiteness included through `normSq2_eq_zero`. *What is missing on `CurvOp2` is a Weyl SUBMODULE, only the predicate `IsWeyl2` existing, in [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean); and the instance registration, whose one remaining side condition that file names as `Bornology.IsVonNBounded ℝ {v | innerOp2 v v < 1}`.*

**THIS IS THE SESSION'S OWN PATTERN, IN ITS MILDER DIRECTION.** *The failure the session diagnosed twice is inventing a name, grepping it, and reading the absence as the concept's absence. Here a name was grepped, found PRESENT, and its presence read as the object's presence, without asking whether the object the row needs lives in that space.* **The correction verified `weylModule` and never asked whether `weylModule` is $\mathcal W_n$, which the tree answers in a file's title.** *The repair is to state the absence against $\mathcal W_n$ on `CurvOp2`, name the inner product as built and the submodule and the instance as missing, and cite [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean) so a later round does not build a projector onto the wrong space.*
