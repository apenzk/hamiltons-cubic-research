# r1019: `phiTri_starred`, the `sixPerm` relabelling, `foxTri2_symm_right`, and whether the `T`-symmetry debt of `FoxProduct.lean` is discharged

**Cold brief.** Every Lean check ran through `lake env lean` on the project toolchain, Lean 4.33.1 (`lean --version` on `PATH` reports the same release here, and the check was made rather than assumed), after a clean `lake build` over 9220 jobs at exit 0. No open-ended computation: the numerical work is three screens on operator triples constructed for the purpose at `n = 4`, every value an exact rational, reported as screens and never as evidence for a positive claim. Log: [agent_logs/r1019.log](../agent_logs/r1019.log).

| # | claim | verdict |
|---|---|---|
| 1 | `sixPerm` is a bijection, and `phiTri_index_sum_eq` is step 3's relabelling | **CORRECT**, and it is step 3 read from the other end |
| 2 | `matS_adjoint` and `ccS_cyc2` correct, and what the relabelling needs | **CORRECT**, both, and both load-bearing |
| 3 | `phiTri_starred` IS step 3, `IsAdjoint2 A A'` the right hypothesis, adjoint in the right slot | **CORRECT**, slot confirmed by screen against three alternative placements |
| 4 | `phiTri_rotate` follows and is not circular | **CORRECT**, one definitional coercion, no cycle |
| 5 | `Qop2_add`, `innerOp2_sub_left`, `foxTri2_split` against step 5 | **CORRECT**, both halves and both constants |
| 6 | `foxTri2_symm_right` correct, `_hX` really unused | **CORRECT, AND THE BINDER IS REDUNDANT**: the `X`-free form compiles kernel-clean |
| 7 | **Does this discharge `FoxProduct.lean`'s recorded debt?** | **OVER-REACHES, ON TWO COUNTS**: different type, and L99 and L127 name a different absence |
| 8 | Vacuity of `foxTri2` and `phiTri_starred` | **NON-VACUOUS**, both, by exact witness |
| 9 | The `PhiIndex.lean` merge: was anything lost? | **NOTHING LOST**, line for line, with one over-reach dropped and one new mis-naming introduced |
| 10 | `#print axioms` on every declaration in both files | **CONFIRMED**, 71/71 on the standard three axioms, and the claim's scope is wider than `sorry`-freedom of two files |
| 11 | Prose outrunning evidence | **SIX**, one of them a whole index row describing a state that no longer exists |

**Actionable summary.** The mathematics is right and machine-checked end to end. What is owed is prose, headed by [lean/INDEX.md](../lean/INDEX.md)'s `FirstVariation.lean` row, which still reads *"**partial**, one named `sorry`"* over a file with none, and by the three-place claim that `FoxProduct.lean`'s debt is discharged, which is a claim about `foxTri` over bare operators that `foxTri2_symm_right` does not reach.

## 0. Conventions, fixed once

`Λ²` is the skew matrices, `inner2 X Y = ½ tr(XᵀY)`, and `{φ_ij : i<j}` is orthonormal under it (checked: `inner2 (φ_g) (φ_h) = δ_gh`, exactly, at `n = 4`). `CurvOp2 ι := skewSub ι →L[ℝ] skewSub ι` and `CurvOp ι := Matrix ι ι ℝ → Matrix ι ι ℝ`. An operator is represented below by its matrix in that orthonormal basis, so `IsSelfAdjoint2` is symmetry of the matrix and the adjoint is the transpose. The derivation is `findings/second-order.md` under *"The first variation of P at an arbitrary direction"*, and its index form is

  Φ(A;B,C) = −∑_{e,f,g,h,k,m} c_{ghk} c_{efm} A_{ge} B_{mk} C_{hf},   A_{ge} = ⟨g, Ae⟩.

The Lean form `phiTri_index` is the same sum with each index over ORDERED pairs and the constant `−1/64`, the six doublings being `2⁶`.

## Hypothesis inventory

| object | hypothesis it carries | is it load-bearing |
|---|---|---|
| `phiTri_swap_outer` | none | n/a |
| `phiTri_starred` | `IsAdjoint2 A A'` | **yes**, screened: the unstarred form fails at 3/3 non-self-adjoint seeds |
| `phiTri_rotate` | `IsSelfAdjoint2 A` | yes, it is the specialisation `A' = A` |
| `foxTri2_symm_right` | `_hX`, `hY`, `hZ` | **`_hX` is NOT**, proved. `hY` and `hZ` are needed by the ROUTE, and their necessity is not exhibited anywhere |
| `innerOp2_eq_trOp_right` | `IsSelfAdjoint2 B` | yes, per [r1015](REVIEW_r1015.md), [r1016](REVIEW_r1016.md) |

## 1. `sixPerm` is a bijection, and it is the derivation's step 3

`Six ι` is right-nested, so `x = (e,f,m,k,h,g)` reads `x.1 = e`, `x.2.1 = f`, `x.2.2.1 = m`, `x.2.2.2.1 = k`, `x.2.2.2.2.1 = h`, `x.2.2.2.2.2 = g`. Then

- `toFun x = (x.2.2.2.1, x.2.2.2.2.2, x.2.2.2.2.1, x.2.1, x.1, x.2.2.1) = (k, g, h, f, e, m)`, which is the docstring's map, read off the projections rather than trusted,
- `invFun y = (y₅, y₄, y₆, y₁, y₃, y₂)`.

Writing `σ(x)ᵢ` out: `y₁=x₄, y₂=x₆, y₃=x₅, y₄=x₂, y₅=x₁, y₆=x₃`. Then `invFun(σ x) = (y₅,y₄,y₆,y₁,y₃,y₂) = (x₁,…,x₆)` and `σ(invFun y) = (z₄,z₆,z₅,z₂,z₁,z₃) = (y₁,…,y₆)`. **Both `rfl`s are honest**: the concern the brief raises, two mutually inverse maps neither of which is the intended one, is closed by checking `toFun` against the intended map directly, which is done above.

**The substitution is step 3, checked independently of the Lean proof.** The right-hand summand of `phiTri_index_sum_eq` at `σ x` is, with `(e',f',m',k',h',g') = (k,g,h,f,e,m)`,

  `c_{g'h'k'} c_{e'f'm'} B_{g'e'} C_{m'k'} A'_{h'f'} = c_{mef} c_{kgh} B_{mk} C_{hf} A'_{eg}`,

and `c_{mef} = c_{efm}`, `c_{kgh} = c_{ghk}` by cyclicity, `A'_{eg} = A_{ge}` by the adjoint, giving the left-hand summand `c_{ghk} c_{efm} A_{ge} B_{mk} C_{hf}`. **That is exactly the derivation's own identification** `g'=m, e'=k, h'=e, k'=f, f'=g, m'=h`, which step 3 writes as *"Matching this against the definition of Φ(B;C,Aᵀ) … at h'=e, k'=f, f'=g, m'=h"*. The Lean map is that matching read from the other end. **CORRECT.**

The `show` the proof lands on is `ccS g h k * ccS e f m * matS A g e * matS B m k * matS C h f = ccS m e f * ccS k g h * matS B m k * matS C h f * matS A' e g`, character for character what the derivation gives, and `ring` closes it after the two cyclic rewrites and one adjoint rewrite.

## 2. `matS_adjoint` and `ccS_cyc2`

`matS_adjoint (h : IsAdjoint2 A A') (f g) : matS A' g f = matS A f g`. `IsAdjoint2 A A'` is `⟨A X, Y⟩ = ⟨X, A' Y⟩`, and `matS A g e = ⟨A φ_e, φ_g⟩`, so the statement is `(A')_{gf} = A_{fg}`: **the adjoint's matrix is the transpose**, which is the derivation's `(A*)_{ge} = A_{eg}`. Applied as `matS_adjoint hadj g e` it rewrites `matS A' e g` to `matS A g e`, which is the occurrence the goal carries. **CORRECT, and it is the ingredient [r1018](REVIEW_r1018.md) found absent**, now on file in the same namespace as both `matS` and `IsAdjoint2`.

`ccS_cyc2 p q r : ccS p q r = ccS q r p` is `ccS_cyclic` run backwards, and `ccS_cyclic p q r : ccS p q r = ccS r p q` is `inner2_brS_cyc (φ_p) (φ_q) (φ_r)`, which is `ad_skewAdjoint` read once. The relabelling needs the constants moved `c_{mef} → c_{efm}` and `c_{kgh} → c_{ghk}`, i.e. the rotation carrying the FIRST slot to the LAST, which `ccS_cyc2` is and `ccS_cyclic` alone is not in the direction `rw` wants. **Both correct, and both are what the relabelling needs.** Neither `ccS_swap12` nor `ccS_swap23` is used by the relabelling, as the derivation says: *"the two structure constants match by cyclicity alone"*.

## 3. `phiTri_starred` IS step 3, and the adjoint is in the right slot

The statement `phiTri A B C = phiTri B C A'` under `IsAdjoint2 A A'` is `Φ(A;B,C) = Φ(B;C,A*)`, the adjoint occupying the THIRD slot of the right-hand side, which is where step 3 puts it. The hypothesis is the relation rather than a constructed operator, which is what makes it statable without an adjoint instance on `CurvOp2`.

**Screen, exact, at `n = 4`**, operators built here as `6×6` integer matrices in the orthonormal `φ` basis, `Φ` computed three independent ways (the Lean `phiTri` ordered-pair definition, the derivation's `∑_e Tr(ad_e B ad_{Ae} C)`, and `foxTri2`'s own route where relevant). At seed 1019, `phiTri A B C = Φ_deriv(A;B,C) = phiTri B C Aᵀ = −42`, while the unstarred `phiTri B C A = −133`. At the three seeds [r1018](REVIEW_r1018.md) used, 7, 11 and 23, `Φ` reproduces its recorded values `−102`, `−11`, `−173` from an implementation written here, and:

| seed | Φ(A;B,C) | Φ(B;C,A*) | Φ(B*;C,A) | Φ(B;C*,A) | Φ(C;A*,B) |
|---|---|---|---|---|---|
| 7 | −102 | **−102** | −192 | −183 | −183 |
| 11 | −11 | **−11** | −203 | −55 | −55 |
| 23 | −173 | **−173** | −55 | −101 | −101 |

**The slot is right and the three nearby placements are live falsifiers**, 3/3 each. **CORRECT.**

## 4. `phiTri_rotate`

`IsSelfAdjoint2.isAdjoint2 (h : IsSelfAdjoint2 A) : IsAdjoint2 A A := h` is a definitional coercion: `IsSelfAdjoint2 A` unfolds to `∀ X Y, ⟨A X, Y⟩ = ⟨X, A Y⟩` and `IsAdjoint2 A A` to the same proposition, so the term is the hypothesis itself. `phiTri_rotate` is then `phiTri_starred hA.isAdjoint2 B C`. **Not circular**: the dependency chain of `phiTri_starred` is `phiTri_index` → `phiTri_summand` → the four expansions → `sum_phi_inner_pair`, plus `phiTri_index_sum_eq` → `sum6_collapse`, `sixPerm`, `ccS_cyc2`, `matS_adjoint`, and no member of it mentions `phiTri_rotate` or `phiTri_first_variation`. **CORRECT.**

## 5. `Qop2_add`, `innerOp2_sub_left`, `foxTri2_split`

`compOp2_add A B : compOp2 (A+B) = compOp2 A + (A.comp B + B.comp A) + compOp2 B`, so with `Qop2 R = compOp2 R + sharpMapCL R` the two pure composition terms cancel and

  `Qop2(X+Y) − Qop2 X − Qop2 Y = (X∘Y + Y∘X) + (sharpMapCL(X+Y) − sharpMapCL X − sharpMapCL Y)`,

which is `Qop2_add` exactly. `innerOp2_sub_left` is `innerOp2_add_left` at `(A − A') + A' = A`, correct.

**`foxTri2_split` against step 5.** Step 5 reads `T(X,Y,Z) = ½Tr(Z*XY) + ½Tr(Z*YX) − ¼[Φ(Z;X,Y) + Φ(Z;Y,X)]`.

- *Jordan half.* `innerOp2 (X.comp Y) Z = ⟨XY, Z⟩_op = Tr((XY)*Z)`, and `Tr(Z*XY) = Tr((Z*XY)*) = Tr(Y*X*Z) = Tr((XY)*Z)`, so the Lean `½(innerOp2 (X.comp Y) Z + innerOp2 (Y.comp X) Z)` IS step 5's first two terms, with the `½` from `foxProd2`'s own `½` and nothing else. **Constant matches.**
- *`#` half.* `innerOp2_sharpMap_eq_phiTri W Z : innerOp2 Z (sharpMapCL W) = −½ Φ(Z;W,W)`. Applied at `W = X+Y`, `X`, `Y` and carried through `foxProd2`'s `½`, the half is `½·(−½)[Φ(Z;X+Y,X+Y) − Φ(Z;X,X) − Φ(Z;Y,Y)] = −¼[Φ(Z;X,Y) + Φ(Z;Y,X)]` by `phiTri_add_mid` and `phiTri_add_right`. **Constant matches.**

**Screened from the definitions rather than from the proof**: `foxTri2 X Y Z` computed through `sharpQF2 → sharpBil2 → sharpMap → Qop2 → foxProd2 → innerOp2` agrees with the right-hand side of `foxTri2_split` exactly, `−315` at a self-adjoint triple at `n = 4`. **CORRECT.**

## 6. `foxTri2_symm_right`, and the `_hX` binder

The proof is four rewrites and `ring`. `hphi1` is `phiTri_swap_outer Z X Y` with no hypothesis. `hphi2`, `Φ(Z;Y,X) = Φ(Y;Z,X)`, is the rotation at `Z`, then the outer swap, then the rotation at `Y` backwards, and each step is licensed. `htr1` and `htr2` are `innerOp2_eq_trOp_right` at `Y` and at `Z` followed by `trOp_comp_comm` and one associativity. After the four the two sides are identical. **CORRECT.**

**`_hX` is not merely unused in the script: the theorem without it is a theorem.** The same script with the `X` binder deleted compiles and `#print axioms` gives `[propext, Classical.choice, Quot.sound]`, and the original follows from it in one application. **So the recorded theorem is strictly weaker than what the proof establishes, and the binder should be dropped**, which is the recommendation: a hypothesis a caller must supply and the proof never reads is a cost with no return, and the file's own docstring already says so in prose.

**What the docstring says about `Y` and `Z` is a statement about the ROUTE, not an exhibited necessity.** *"The Jordan half needs `Y` and `Z` self-adjoint to read `innerOp2` as a trace, and the `Φ` half needs `Y` and `Z` to rotate"* is true of these four rewrites. Whether the IDENTITY needs them is a different question and no witness for it is on file. A screen here found the identity still holding at one non-self-adjoint `Y` and at one non-self-adjoint `Z`, and failing when all three are free. **One witness is not a control**, which is this layer's own recorded lesson, so nothing is concluded from it beyond the observation that the necessity claim has no argument on file. See §11, occurrence 3.

## 7. THE DISCHARGE CLAIM OVER-REACHES, ON TWO INDEPENDENT COUNTS

**Count one, the type.** [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s `foxProd`, `foxTri`, `Lmul` and `Lidem` are over `CurvOp ι := Matrix ι ι ℝ → Matrix ι ι ℝ`, bare functions on ALL matrices, and its `#` is `sharpOp`. `foxTri2` is over `CurvOp2 ι := skewSub ι →L[ℝ] skewSub ι` and its `#` is `sharpMapCL`. **They are not the same object, and no declaration on file relates them**: `foxTri2` and `foxProd2` occur in [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) and nowhere else in the tree, `foxTri` occurs in [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), [L99Statement.lean](../lean/HamiltonsCubic/Results/L99Statement.lean) and [SharpReduced.lean](../lean/HamiltonsCubic/Results/SharpReduced.lean), and **no file names both**. `FirstVariation.lean` does not even import `FoxProduct.lean`: its chain is `PhiTri → TraceOp → Bivectors2 → WeylReal` with `L33Statement` and `L76Statement` beside it, so `foxTri` is not in scope where `foxTri2_symm_right` is stated.

*The bridge is nearer than that makes it sound, and it is still absent.* [CubicBridge.lean](../lean/HamiltonsCubic/Results/CubicBridge.lean) carries `sharpOp_extend`, `Qop_extend` and `Pcubic_extend`, so `Q` does cross at every continuous operator on `Λ²`. What `foxProd` is the polarisation of is `Qop` AT A SUM, so transporting it needs `extend (X + Y) = extend X + extend Y`, and **there is no `extend_add` in the tree**. `extend` is also stated only at `Fin n`, where `foxTri2` is at a general `ι`. **What IS discharged is the `CurvOp2` analogue of the debt, at self-adjoint arguments, and that is worth having**, and what is not discharged is the debt as `FoxProduct.lean` records it, whose own sentence names the blocker: *"that derivation needs `sharpOp` to **be** `R#`, which is WeylReal's own standing obligation."*

**Count two, the three consumers.** The record says in three places that the proof settles *"the absence L98, L99 and L127 each name as keeping their subject unstatable"*. Read verbatim:

- **[L98Statement.lean](../lean/HamiltonsCubic/Results/L98Statement.lean)**, `## What is NOT typed here`: *"**That `IsLamMax` is a spectral maximum.** It is the quadratic-form reading [FoxProduct.lean] fixes; the equivalence with a largest eigenvalue needs `L_e` self-adjoint, which that file records as owed."* **This one does name it**, at one remove: self-adjointness of `L_e = Lidem`, an operator over `CurvOp`, which needs symmetry of `foxTri`, not of `foxTri2`.
- **[L99Statement.lean](../lean/HamiltonsCubic/Results/L99Statement.lean)**, `## What is NOT typed here`, in full: *"**`dim ker M` = the number of connected components.** …"* and *"**The harmonic-square normalisation of the coefficients.** …"*. **NEITHER is the symmetry of `T`, and `L_e` and the Fox product are not named in that section at all.** L99's own `sorry` is elsewhere and is a different debt: *"**One `sorry`, in `indicator_eigen`**: `L_e N = N` … It needs `∘` evaluated at two diagonal operators, the polarisation of `Qop` on the locus, which is [Families.lean]'s owed `DiagCubicFormula` one derivative down, together with the **bilinearity** of `∘` that [FoxProduct.lean]'s `foxProd_split` records as owed."* **Bilinearity of `∘` is a separate item of `FoxProduct.lean`'s own owed list and `foxTri2_symm_right` does not touch it.**
- **[L127Statement.lean](../lean/HamiltonsCubic/Results/L127Statement.lean)**, `## What is NOT typed here`: *"**No eigenvalue of anything is named.** `L_e`, the Fox product, `L120`'s sign-character blocks, `L122`'s pair Laplacian and the `𝒟ₙ` summand list are outside the `RealLayer`, so the claims that these numbers *are* the `L_e`-spectra of those blocks are absent"*. **The absence named is the objects themselves being outside the layer, not the symmetry of a form over them.** A symmetry theorem supplies none of the four bullets it lists.

**So of the three, L98 names a debt one step from this one over a different type, L99 names two different debts, and L127 names the absence of the objects.** The three-place sentence should be cut to L98, and to the `CurvOp2` form of the statement.

## 8. Vacuity

Both non-vacuous, by exact witness at `n = 4`, operators constructed here.

- `foxTri2 X Y Z = −315` at a self-adjoint triple (seed 1019), and `foxTri2 X Z Y = −315` with it. At seeds 7, 11 and 23 the value at a self-adjoint triple is `248`, `−55` and `−117/2`, all four orderings agreeing in each case. **A form taking four distinct nonzero values on four constructed triples is not identically zero**, so the symmetry has content.
- `phiTri X Y Z = 454 = phiTri Y Z X` at a self-adjoint triple, and `phiTri A B C = −42 = phiTri B C Aᵀ` with `A` non-self-adjoint, so `phiTri_starred` is non-vacuous in its own general form and not only at the self-adjoint specialisation.

## 9. The merge

`PhiIndex.lean` was deleted in `ff86ef9a` and its content moved into `PhiTri.lean`. **Checked mechanically**: every non-blank line of the deleted file's BODY, lines 33 to 219, appears verbatim in the current `PhiTri.lean` (`comm -23` over the sorted line sets returns empty). All 22 declarations are present, `phiS` through `matS_adjoint`, with their docstrings.

**The module docstring was not carried, and that is a gain rather than a loss.** Its one piece of content not preserved elsewhere is *"a screen over the six slot permutations then established that the outer swap generates nothing further, **so this route is the one left**"*, **which is the exact over-reach [r1017](REVIEW_r1017.md) corrected and [r1018](REVIEW_r1018.md) found recurring**. Its other claims survive: the `−1/64` account and its screen, `Φ = −102` against `6528`, are in `phiTri_index`'s own docstring word for word, and `inner2_brS_cyc` is now in the same file.

**One new error was introduced by the merge.** The replacement section header says *"its `phiTri_starred_proof` sat downstream of the `sorry` it discharges"*. **No declaration of that name has ever existed**: `git log --all -S"phiTri_starred_proof"` returns the single commit `ff86ef9a`, which is the commit that wrote the phrase, and the deleted file's last declaration was `matS_adjoint`. The sentence is right about the import direction and wrong about the name.

## 10. Axioms, and the scope of the `sorry`-free claim

`#print axioms` under `lake env lean` on Lean 4.33.1, on **all 71 declarations** of the two files, 64 in `PhiTri.lean` and 7 in `FirstVariation.lean`:

- 69 report `[propext, Classical.choice, Quot.sound]`,
- `Six` and `sixPerm` report *does not depend on any axioms*,
- **none reports `sorryAx`.**

That covers `phiTri_starred`, `phiTri_rotate`, `phiTri_first_variation`, `hasDerivAt_sharpPair2_line_selfAdjoint`, `Pcubic2Lin_selfAdjoint`, `hasDerivAt_Pcubic2_line`, `foxTri2_split` and `foxTri2_symm_right`. **The seven declarations [r1017](REVIEW_r1017.md) found carrying `sorryAx` are now clean.**

**What the claim's scope actually is.** Because `#print axioms` reads the whole transitive dependency chain, the result says more than *"these two files contain no `sorry`"*: it says **nothing either file depends on carries one either**, which covers `TraceOp.lean`, `Bivectors2.lean`, `WeylReal.lean`, `L33Statement.lean` and `L76Statement.lean`. Independently, **no file in the tree that mentions `CurvOp2` contains a genuine `sorry`** at all, and every `sorry` token in `PhiTri.lean` and `FirstVariation.lean` sits inside backticks in prose. **What the claim does NOT say** is anything about the layer at large: 58 genuine `sorry`s remain across 46 files, and `FoxProduct.lean`'s own debts are carried as deliberate absences rather than `sorry`s, so they are invisible to this count. *"The whole `CurvOp2` second-order sub-layer is `sorry`-free"* is therefore exactly right as written and is a statement about roughly one seventieth of the files.

## 11. Prose outrunning its evidence

**Occurrence 1, and it is the one to fix first.** [lean/INDEX.md](../lean/INDEX.md)'s `FirstVariation.lean` row is marked **"partial", one named `sorry`**, and reads *"typed as signatures so the claims elaborate before they are proved; the proofs are the next Opus task"*, *"it carries `sorryAx` by INHERITANCE alone, through `phiTri_first_variation` to `phiTri_rotate`"* and *"**So the whole first variation of `P` rests on that one unproved rotation.**"* **Every clause describes a state that ended at commit `ff86ef9a`**, and the row three above it, the `PhiTri.lean` row, says so.

**Occurrence 2.** [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean)'s own module docstring, unchanged: *"**Derived in prose on 2026-09-19 and typed here as signatures with named `sorry`s**, so that the claims elaborate before anyone proves them and the gap is visible where a reader meets it. … **The proofs are owed and are the next Opus task.**"* The file has no `sorry` and both theorems are proved.

**Occurrence 3, the proposal-150 shape.** Same docstring: *"`foxTri2_symm_right` is the symmetry in the LAST two slots at self-adjoint arguments … **neither is claimed at a non-self-adjoint argument**, and the derivation shows the `Φ` half **needs** the rotated slot symmetric."* **The first half is false of the theorem as proved**: `_hX` is unread, the `X`-free statement compiles kernel-clean, and a screen finds the identity holding at a non-self-adjoint `X`. The second half is a necessity claim carried by the sentence that got the sufficient hypothesis right, and **no witness outside the hypothesis is exhibited anywhere for `Y` or `Z`**, which is proposal 150 in its pure form. *Fix: say what the hypothesis buys.* `holds at self-adjoint Y and Z` is a complete sentence.

**Occurrence 4, the discharge sentence, in three places.** [plan.md](../plan.md)'s I36 item, [lean/INDEX.md](../lean/INDEX.md)'s `PhiTri.lean` row and `foxTri2_symm_right`'s own docstring all carry *"the FULL SYMMETRY OF `T` is proved, which is [FoxProduct.lean]'s own recorded debt and the absence [L98], [L99] and [L127] each name as keeping their subject unstatable"*. §7 above. **And the record contradicts itself on it**: [lean/INDEX.md](../lean/INDEX.md)'s `SharpReduced.lean` row still reads *"**THIS IS THE FIRST STEP OF A DEBT AND NOT THE DEBT**: [FoxProduct.lean] records FULL SYMMETRY OF `T` as owed … and `T`'s third slot needs the `φ`-expansion of `sharpOp` as well"*, which is the correct reading and sits two rows away from the row that says the debt is settled.

**Occurrence 5.** [plan.md](../plan.md)'s I36 item still says *"thirteen `I36` rows … **FOUR route through the `sorry` `phiTri_starred`**"* six lines above its own paragraph announcing that the `sorry` is gone. The sentence is a report of [r1018](REVIEW_r1018.md)'s audit and reads as current state.

**Occurrence 6.** [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)'s module docstring closes *"**The rotation at a symmetric first slot is the harder half and is not here**; that one does appear to need the expansion."* The rotation is in this file, three hundred lines below that sentence, as `phiTri_starred` and `phiTri_rotate`.

*Checked and NOT an instance:* `phiTri_starred`'s own docstring, whose *"THE HYPOTHESIS IS LOAD-BEARING AND A FIRST CONTROL SAID OTHERWISE"* and *"One witness is not a control"* are both sustained by the screen in §3, and whose account of the slot-permutation screen is stated as a fact about slot permutations rather than about proofs, which is [r1017](REVIEW_r1017.md)'s correction correctly carried.

## Overall verdict

**PROVEN (hypotheses corrected).** Every one of the 71 declarations in the two files is machine-checked on the standard three axioms with no `sorryAx`, and `sixPerm`, `phiTri_index_sum_eq`, `phiTri_starred`, `phiTri_rotate`, `foxTri2_split` and `foxTri2_symm_right` each match the derivation step for step and constant for constant, re-derived here independently of their proofs and screened exactly at `n = 4`. **The hypothesis correction is `_hX`**, which the proof does not read and whose removal is itself proved. **The finding is one of reach**: `foxTri2_symm_right` settles the `CurvOp2` form of the `T` symmetry, and the record's three-place claim that it discharges [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s debt is a claim about `foxTri` over bare operators, which no declaration in the tree connects to `foxTri2`. *What would have to be proved for the recorded claim to hold as written is `extend_add`, an `innerOp` transport, and `sharpOp` being `R#` at the operators in question, which is `WeylReal.lean`'s standing obligation and the blocker `FoxProduct.lean`'s own sentence names.*
