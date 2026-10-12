# Review r1044: three Lean commits, I67's `det J = 1`, L199's reduction and withdrawal, and the `DiagCriticalityIsCritical` dedup

Scope: [33b3179b](../lean/HamiltonsCubic/Results/I67PfSquared.lean) on [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean), [087c83d6](../lean/HamiltonsCubic/Results/L199Statement.lean) on [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), [d5073a0a](../lean/HamiltonsCubic/Base/Families.lean) on [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), [L68Statement.lean](../lean/HamiltonsCubic/Results/L68Statement.lean) and [L74Statement.lean](../lean/HamiltonsCubic/Results/L74Statement.lean).

Log: [agent_logs/r-lean-rounds.log](../agent_logs/r-lean-rounds.log).

| # | claim | verdict |
|---|---|---|
| 1 | `det_complex_structure` proved, no `sorry` beneath it, proof correct | **CONFIRMED** |
| 2 | the rotation-family argument is sound | **CONFIRMED** |
| 3 | `det_complex_structure` uses only the `J * J = -1` clause | **CONFIRMED** |
| 4 | `pf_sq_eq_det` is blocked by the library, not the mathematics | **CONFIRMED**, with the blocker named more narrowly below |
| 5 | `trace_comm_sq` is correct at every size | **CONFIRMED** |
| 6 | `trace_Gmat` really was false, and the three counterexamples are right | **CONFIRMED**, all three reproduced exactly |
| 7 | the withdrawal is correctly scoped | **CONFIRMED as a statement about the mathematics**, and the file's stated REASON for deleting rather than repairing is **REFUTED** |
| 8 | `DiagCriticalityIsCritical` was two identical constants and is now one | **CONFIRMED** |

## The one finding that costs something: the repair the file says is unavailable is in its own import

[L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) withdraws `trace_Gmat` and writes, twice, that repair is impossible here: *"What it needs is the Weyl conditions on `R`, which this file does not carry"*, and the commit message's *"The Weyl conditions are not in this file, so the refutation and its table stand where the statement was"*. **That is false.** `IsWeyl` is defined at [Sharp.lean:115](../lean/HamiltonsCubic/Base/Sharp.lean) as `R.IsSymm ∧ IsBianchi R ∧ IsRicciFlat R`, and [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) is [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean)'s **only** import. The file's own header docstring says so in as many words: *"Stated here at `n = 4`, where the base layer carries `#`, its normalisation anchor `Id# = (n-2) Id`, **and the Weyl conditions**."* The header and the withdrawal note contradict each other inside one file, and the header is the one that is right.

**The repaired statement is true, and it was checked here in the file's own definitions.** A rational Weyl tensor built by hand,

```
W = !![6,2,1,3,2,-4; 2,-1,1,1,-5,-2; 1,1,-5,-1,-1,3; 3,1,-1,-5,-1,1; 2,-5,-1,-1,-1,-2; -4,-2,3,1,-2,6]
```

satisfies every clause of `IsWeyl` as the layer defines it (`Wᵀ = W` by `decide`, `W 0 5 - W 1 4 + W 2 3 = 0`, and all sixteen `Ric W a b` zero), and at it

`(Gmat W).trace = 3456 = 12 * (Wᵀ * W).trace`.

So `theorem trace_Gmat_weyl (R) (hR : IsWeyl R) : (Gmat R).trace = 12 * (Rᵀ * R).trace` is statable today, in this file, against an inhabited hypothesis, and the record's first moment `Σ_k g_k = 4(n-1)‖W‖²` survives at `n = 4` in exactly that form. **Deleting the general statement was right and leaving nothing in its place was not.**

## The exact general first moment, which explains all three counterexamples at once

Write a symmetric `R` on `Λ²ℝ⁴` in an orthonormal basis adapted to `Λ²₊ ⊕ Λ²₋` as blocks `A`, `C` and a mixed block `B`. Then, verified on forty random symmetric `R` over `ℚ` against the `ad` matrices [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean)'s own `adMat` prints,

`tr(Gmat R) = 12‖R‖² - 2(tr R)² - 8(R₀₅ - R₁₄ + R₂₃)² - 8‖B‖²`,

equivalently `12(‖A‖² + ‖C‖²) - 4((tr A)² + (tr C)²) + 16‖B‖²` against `12(‖A‖² + ‖C‖²) + 24‖B‖²` for `12‖R‖²`. Three consequences, each of which the file could have recorded in place of a bare refutation.

- **The deficit is a sum of negative squares, so `tr(Gmat R) ≤ 12 tr(RᵀR)` at EVERY symmetric `R`**, with no hypothesis at all. The inequality is the true general statement, and it points the same way the bound consumes.
- **Equality holds exactly when `tr R = 0`, `R₀₅ - R₁₄ + R₂₃ = 0` and `B = 0`**, which is Ricci-flat plus first Bianchi plus symmetric, that is `IsWeyl`. The Weyl conditions are not merely sufficient here, they are the equality locus.
- **The three table entries fall straight out**: at `diagonal ![1,0,0,0,0,0]`, `12·1 - 2·1 - 0 - 8·(1/4) = 8`; at `diagonal ![1,1,0,0,0,0]`, `24 - 8 - 0 - 4 = 12`; at `diagonal ![1,2,3,0,0,0]`, `168 - 72 - 0 - 28 = 68`. The file calls the mismatch *"not a lost normalisation"* and stops there. It is a lost scalar-curvature term and a lost Ricci term, and both are visible.

## Claim by claim

### 1, 2, 3: I67's `det J = 1`

**`#print axioms` on the source, appended and then reverted rather than imported.** `det_complex_structure`, `det_pos_of_sq_eq_neg_one`, `det_sq_eq_one`, `rot_mul_rot`, `det_rot_ne_zero` and `det_rot_continuous` each depend on `[propext, Classical.choice, Quot.sound]` and nothing else. `pf_sq_eq_det` and `pf6_complex_structure` carry `sorryAx`, as the file says they do.

**The analysis step holds where it is used.** [intermediate_value_Icc'](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/Order/IntermediateValue.html#intermediate_value_Icc') is the decreasing-direction form, `Icc (f b) (f a) ⊆ f '' Icc a b`, and the membership obligation is discharged in that order: `f (π/2) = J.det ≤ 0` from the trichotomy branch and `0 ≤ f 0 = 1` by `norm_num`. `Continuous.matrix_det` composes with the two `smul`s of constant matrices as written. `det_rot_ne_zero` is used in both branches that need it, the negative one to contradict the produced root and the zero one to contradict `f (π/2) = 0`, and `lt_trichotomy` leaves the positive branch as the goal. The algebra behind it is right: `(cos t · I + sin t · J)(cos t · I - sin t · J) = (cos²t + sin²t) · I` precisely because `J² = -Id`.

**Claim 3 is true and was tested rather than read.** `IsComplexStructure` is `IsSkew J ∧ J * J = -1` at [SelfDual.lean:644](../lean/HamiltonsCubic/Base/SelfDual.lean), the proof calls `hJ.2` twice and never `hJ.1`, and a variant taking `J * J = -1` alone elaborates and is kernel-clean on the same three axioms.

### 4: `pf_sq_eq_det`

**The mathematics is true at the file's own normalisation, so the `sorry` does not sit under a false statement.** `pf6 X = (1/48) Σ levi6 · X · X · X` with `levi6` built from `sgnR`, which is the standard `(2^m m!)⁻¹` at `m = 3`. Computed with that exact convention on four random skew rational `6 × 6` matrices, `Pf(X)² = det X` on the nose (`144`, `1444`, `4761`, `225`).

**The library claim checks out as far as it goes.** Mathlib carries no Pfaffian and its determinant expansions stop at [Matrix.det_fin_three](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Determinant/Basic.html#Matrix.det_fin_three), with no `det_fin_four`. **One narrowing.** "Blocked" names an absent API rather than an attempted and failed route: `Matrix.det_apply` reaches `Fin 6` in principle, and the classical congruence-normal-form proof avoids expansion entirely. The docstring is careful about this and says *"named as owed rather than attempted-and-failed"*. [lean/INDEX.md](../lean/INDEX.md) is not, and hardens *"does not obviously apply here"* into *"does not transfer"*.

### 5: `trace_comm_sq`

**Correct, and the subtle step is handled the way the commit says.** `h2` proves `tr(AR·RA) = tr(AA·RR)` by associativity, then [Matrix.trace_mul_comm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html#Matrix.trace_mul_comm) to reach `tr(RRAA)`, then associativity again, then a **second** `trace_mul_comm` to reach `tr(AARR)`. That is a cyclic shift by two, and no `noncomm_ring` call is asked to prove `R*R*A*A = A*A*R*R`. Every `noncomm_ring` in the proof is doing associativity or the expansion of the square, each of which is a true ring identity. `h1` and `h3` are single cyclic shifts and are right. The final `trace_add`/`trace_sub` chain lands on `2 tr(ARAR) - 2 tr(AARR)`.

**`comm_isSymm_gen`'s hypotheses are the ones consumed.** `hA : Aᵀ = -A` and `hR : Rᵀ = R` are used only to turn `((A*R - R*A)ᵀ * (A*R - R*A))` into `((A*R - R*A) * (A*R - R*A))`. Everything after that is cyclicity, which is why the statement holds at every `m`.

### 6: the counterexamples

**All three reproduced, twice.** Appending `#eval`s to [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) itself and running `lake env lean` on it returns `(8, 12)`, `(12, 24)` and `(68, 168)`, exactly the table. An independent evaluation in `ℚ` against the `adMat` matrices that the same run printed agrees. Two further points: `tr(Gmat 1) = 0` against `72`, and `tr(Gmat diagTest) = 140` against `1092`. **The withdrawn statement was false, and nothing true was lost by deleting it in that form.**

### 7: the scope of the withdrawal

**All three sub-claims hold.** `G_eq_sharp` is textually untouched and still carries its `sorry`. [bounds.md](../findings/bounds.md)'s L199 block does state `G_W = 4(W²#I) - 4(W#W)` *"with no hypothesis of any kind"*. And the block does call the two moments *"checks at a Weyl tensor rather than at the statement's full generality"* and say they consume relation (B), so the file's gloss of the record is accurate.

**The moment genuinely needs the Weyl conditions, and needs exactly them.** Settled from the definitions rather than from the file's gloss: the closed form above makes the deficit `-2(tr R)² - 8(R₀₅ - R₁₄ + R₂₃)² - 8‖B‖²`, zero precisely on `IsWeyl`. The counterexamples are computing the right thing, and a Weyl tensor restores the identity on the nose.

**What is refuted is the withdrawal's reason, not its arithmetic.** See the first section.

### 8: the dedup

- **The two deleted definitions were character-identical**, and both sat under the same `variable {ι : Type*} [Fintype ι] [DecidableEq ι]` with the same `open ... HamiltonsCubic.FamilyLayer`, so `IsWeight`, `diagOp` and `IsCritical` resolved to the same constants in both. The new definition in [Families.lean:169](../lean/HamiltonsCubic/Base/Families.lean) has the same body under the same context.
- **No third definition ever existed.** `git log -S "def DiagCriticalityIsCritical" --all` returns exactly two commits, [a37a1880](../lean/HamiltonsCubic/Base/Families.lean), which introduced both copies in one go, and [d5073a0a](../lean/HamiltonsCubic/Base/Families.lean).
- **Both consumers still elaborate.** `lake env lean` on [L68Statement.lean](../lean/HamiltonsCubic/Results/L68Statement.lean) and on [L74Statement.lean](../lean/HamiltonsCubic/Results/L74Statement.lean) each exits `0`, L68 with its one pre-existing `sorry` warning at line 157 and L74 clean.
- **`isCritical_srg_form` and `srg_theta_closed_form` mean what they meant.** Each takes `DiagCriticalityIsCritical (ι := ι)` as before, and the constant it now names unfolds to the same proposition. The change is that there is one of it.
- **The commit's supporting observations check out**: [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean) names it unqualified in prose at lines 94, 113 and 399, and [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) had already named the gap in prose before owning it.

## Overreach sweep

| where | sentence | what the declarations support |
|---|---|---|
| [lean/INDEX.md](../lean/INDEX.md), L199 row | *"the Weyl conditions being absent from this file"* | `IsWeyl` is at [Sharp.lean:115](../lean/HamiltonsCubic/Base/Sharp.lean), which the file imports. Repeated from the file's own note and inherited into the index. |
| [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), withdrawal note | *"What it needs is the Weyl conditions on `R`, which this file does not carry"* | Same. It contradicts the file's header, which says the base layer carries them. |
| [lean/INDEX.md](../lean/INDEX.md), I67 row | *"Four declarations, all on the standard three axioms."* | **Six** are: `det_sq_eq_one`, `rot_mul_rot`, `det_rot_ne_zero`, `det_rot_continuous`, `det_pos_of_sq_eq_neg_one`, `det_complex_structure`. The file has eight declarations in all. |
| [lean/INDEX.md](../lean/INDEX.md), I67 row | *"`pf6_complex_structure` is PROVED"* | It depends on `sorryAx`. The row's own later sentence about the `sorryAx` trap says so, so the two halves of one row disagree. |
| [lean/INDEX.md](../lean/INDEX.md), I67 row | *"the reindexing that got past the `6⁶` wall does not transfer"* | The docstring says *"does not obviously apply here"* and declines to claim an attempt. The index states it as settled. |
| [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean), section heading | *"`det J = 1`, in four steps"* | Five declarations sit under that heading. Cosmetic, listed for the count. |
| [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean), `adComm_isSymm` docstring | *"on the order of thirty thousand terms for `ring`"* | An estimate with nothing behind it in the file. Pre-existing, unchanged by this commit, flagged because the withdrawal note leans on it. |

**A rendering defect, not a mathematical one.** [lean/INDEX.md:289](../lean/INDEX.md), the L74 statement row, now has **five** cells in a **four**-column table: the dedup note was appended after the row's closing `|` and the row has no trailing pipe. GFM drops cells past the header width, so the whole *"AND IT WAS DEFINED TWICE, 2026-09-21"* paragraph renders as nothing. The fix is to fold it into the fourth cell and restore the trailing `|`.

## Corrections to apply

1. **Restore the moment under its real hypothesis.** Add `trace_Gmat_weyl` to [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) with `IsWeyl R` as the hypothesis, with the witness above recorded as its non-vacuity check. Keep the refutation table, which is correct and useful.
2. **Delete the two sentences saying the Weyl conditions are not in the layer**, in the file and in [lean/INDEX.md](../lean/INDEX.md), and say instead that the general statement is false and the Weyl-hypothesised one is owed.
3. **Record the closed form** `tr(Gmat R) = 12‖R‖² - 2(tr R)² - 8(R₀₅ - R₁₄ + R₂₃)² - 8‖B‖²` and its corollary `tr(Gmat R) ≤ 12 tr(RᵀR)` at every symmetric `R`, which is hypothesis-free and true.
4. **Fix the count** in the I67 row, four to six, and soften *"is PROVED"* on `pf6_complex_structure` to name the `sorryAx` at first mention.
5. **Repair the L74 row's cell structure** in [lean/INDEX.md](../lean/INDEX.md).

## How the analysis-only rule was honoured

Every run was on objects already in hand or constructed for a screen, and every one had a cost stated before it started. Four `lake env lean` invocations on single files, each between fifteen seconds and ninety seconds: `#print axioms` on [I67PfSquared.lean](../lean/HamiltonsCubic/Results/I67PfSquared.lean), the three `#eval`s reproducing the table, the Weyl witness, and one compile each of [L68Statement.lean](../lean/HamiltonsCubic/Results/L68Statement.lean) and [L74Statement.lean](../lean/HamiltonsCubic/Results/L74Statement.lean). Seconds of rational arithmetic outside Lean to cross-check the same numbers and to test the closed form on forty matrices I constructed. **One run was stopped rather than finished**: a `decide` screen of `G_eq_sharp` itself through `sharpBil` had no cost I could state in advance, and at twenty minutes with no output it was killed rather than allowed to run on. `G_eq_sharp` is therefore **NOT screened** by this review and remains exactly as the commit left it. Every appended block was reverted, and the only file this review writes is itself.
