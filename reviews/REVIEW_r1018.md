# r1018, `PhiIndex.lean`: `Φ` in indices, the structure constant, the `-1/64`, and the step-7 plan move

**The brief was cold.** No sweep, census, optimisation or falsifier hunt was run. One **screen** was run, reported as a screen and never as evidence for a positive claim: three operator triples at `n = 4` built for the purpose, all arithmetic exact over `Fraction`, seconds of compute. Every value below is exact, rational or symbolic. Log: [agent_logs/r1018.log](../agent_logs/r1018.log).

| # | claim | verdict |
|---|---|---|
| 1 | `ccS` IS `c_{efm}`, the three symmetry theorems correct, and do they give TOTAL antisymmetry | **CORRECT** (prose caveat: "alternating group" misnames the action) |
| 2 | `sum_phi_inner_pair`, `brLeftFun`/`brRightFun` linear, `brS_expand_left`/`_right` with their `½`s | **CORRECT** |
| 3 | `phiTri_pairs` is `phiTri`, not a reindexing | **CORRECT** |
| 4 | `expand_outer`, `expand_arg`, `coordS_brS_expand`, each one application of `sum_phi_inner_pair` | **CORRECT** |
| 5 | `phiTri_summand`'s `1/16` and every index placement | **CORRECT** |
| 6 | `phiTri_index`'s `-1/64` and its slot-for-slot index placement | **CORRECT** |
| 7 | Does `phiTri_index` suffice for the relabelling, and "both ingredients on file" | **OVERSTATED**, a third ingredient is on file nowhere |
| 8 | Both `sorry`s still true and faithful, and `IsAdjoint2 A A'` the right hypothesis | **CORRECT** |
| 9 | The step-7 move: was the finding genuinely absent, and does `plan.md` outrun the record | **PART CORRECT, PART OVERSTATED**, the move was right, its account of where the finding still lived is wrong, a second loss from the same replacement is unrecovered, and `plan.md` carries a false clause |
| 10 | `#print axioms` on every declaration in `PhiIndex.lean` | **CLEAN**, 22/22 declarations, standard three axioms, no `sorryAx` |
| 11 | Prose outrunning the evidence, and proposal 150's shape | **FOUND**, four quotes, one of them proposal 150's exact recurrence |

**Actionable summary.** The headline `phiTri_index` is right in constant and in every slot, machine-checked and axiom-clean, and confirmed by an independent exact screen with live falsifiers. What needs fixing is four prose claims outside it: `plan.md`'s *"every one routes through the single `sorry`"*, [lean/INDEX.md](../lean/INDEX.md)'s *"the layer's one `sorry`"*, [PhiIndex.lean](../lean/HamiltonsCubic/Results/PhiIndex.lean)'s *"so this route is the one left"*, and the record's *"both already on file"*, which undercounts the relabelling's ingredients by one.

## 0. Conventions, fixed once

`Λ² = skewSub ι` is the skew matrices, `inner2 X Y = ½ tr(Xᵀ Y)` is symmetric, with `{φ_ij}_{i<j}` orthonormal. `phi i j = E_ji − E_ij`, `br X Y = XY − YX`, `brS` its restriction to `Λ²`. Ordered-pair index `p ∈ ι × ι`, `phiS p = φ_{p₁p₂}`. The doubling is `∑_{i<j} f(φ_ij) = ½ ∑_{i,j} f(φ_ij)` for `f` even in each slot, which `sum_phi_inner_sub` carries.

Entries: `matS A g e = inner2 (A φ_e) (φ_g) = ⟨A φ_e, φ_g⟩`, and the derivation writes `A_{ge} = ⟨g, A e⟩`. These agree, `inner2` being symmetric. The structure constant: `ccS p q r = ⟨[φ_p, φ_q], φ_r⟩`, the derivation's `c_{efm} = ⟨[e,f],m⟩`. **First matS index is the OUTPUT slot, second the INPUT**, in both.

## Hypothesis inventory

| object | hypothesis it carries | where it comes from |
|---|---|---|
| `ccS_cyclic` | none | `inner2_brS_cyc`, which is `ad_skewAdjoint` |
| `ccS_swap12`, `ccS_swap23` | none | `brS_neg`, plus `ccS_cyclic` for the second |
| every expansion lemma | none | `sum_phi_inner_sub` against a bundled `→ₗ[ℝ]` |
| `phiTri_index` | none | trilinear identity at every `A, B, C` |
| `phiTri_starred` | `IsAdjoint2 A A'` | the derivation's step 3, where the adjoint is load-bearing |
| `foxTri2_symm_right` | `IsSelfAdjoint2` on all three arguments | the derivation's step 5 |

## 1. `ccS` is the derivation's `c`, and what the three theorems generate

`ccS p q r = inner2 ↑(brS (phiS p) (phiS q)) (phi r.1 r.2)`, which unfolds to `⟨[φ_p, φ_q], φ_r⟩`, the derivation's `c_{efm}` with the slots in the same order. **Identification correct.**

`inner2_brS_cyc X Y Z : ⟨[X,Y],Z⟩ = ⟨[Z,X],Y⟩` is `ad_skewAdjoint` read once: `⟨[X,Y],Z⟩ = −⟨Y,[X,Z]⟩ = ⟨Y,[Z,X]⟩ = ⟨[Z,X],Y⟩`. So `ccS_cyclic : c(p,q,r) = c(r,p,q)` is the 3-cycle, `ccS_swap12 : c(p,q,r) = −c(q,p,r)` the transposition from `brS_neg`, and `ccS_swap23 : c(p,q,r) = −c(p,r,q)` follows in two rewrites. **All three correct.**

**Do they give TOTAL antisymmetry?** The 3-cycle and one transposition generate `S₃`, and `ccS_cyclic` carries sign `+1` while `ccS_swap12` carries `−1`, so every element of `S₃` acquires its sign. Total antisymmetry therefore follows from the three. **What is not on file is the statement.** The sixth relation, `c(p,q,r) = −c(r,q,p)`, appears as no declaration. It is two rewrites away and nothing in the file needs it.

**What step 3 uses.** The rotation uses cyclicity alone: *"rotate both `c`'s cyclically by (iii)"*, `c_{ghe'} c_{efg'} = c_{e'gh} c_{g'ef}`. The outer swap uses the transposition, twice, at `(−1)²`. **Both are covered by what is proved**, and `ccS_cyclic`'s own docstring says so exactly: *"which is the whole of what the relabelling turns on"*.

**The caveat.** `ccS_swap23`'s docstring says *"the two generating the alternating group action"*, and [lean/INDEX.md](../lean/INDEX.md)'s row repeats *"the two generate the full alternating action the relabelling turns on"*. The group generated is `S₃`, not `A₃`, and what is meant is the sign-twisted action of `S₃`. **The mathematics is right and the name is wrong.** The stronger reading is available and I have argued it: "alternating" may be read as an adjective on the action rather than as the group's name, and under that reading the sentence is true. It is still a term that means something else two lines from a group-theoretic claim. **And `lean/INDEX.md` adds an error the file does not have**: it says the full action is what "the relabelling turns on", where the file's own `ccS_cyclic` docstring says cyclicity alone is. The file is right.

## 2. The expansion machinery

`sum_phi_inner_sub Y f : ½ ∑_i ∑_j ⟨Y, φ_ij⟩ · f(φ_ij) = f Y`. `sum_phi_inner_pair` states the same over `ι × ι`, and `Fintype.sum_prod_type` is `∑_{p : α×β} g p = ∑_a ∑_b g (a,b)`, an equality of the same finite sum, not a reindexing. **The `½` is carried unchanged and the restatement is exact.**

`brLeftFun q r : X ↦ ⟨[X, φ_q], φ_r⟩` is linear because `brS` is additive and `ℝ`-homogeneous in its left slot (`brS_add_left`, `brS_smul_left`) and `inner2` in its left slot. `brRightFun X r : Y ↦ ⟨[X,Y], φ_r⟩` likewise through `brS_add_right`, `brS_smul_right`. **Both genuinely linear, and the bundling is what licenses `sum_phi_inner_pair`'s application.**

`brS_expand_left X q r` is `sum_phi_inner_pair X (brLeftFun q r)` read backwards: `brLeftFun q r (phiS g) = ⟨[φ_g, φ_q], φ_r⟩ = ccS g q r`, so the right side is `½ ∑_g coordS X g · ccS g q r`. **Correct, `½` included, and the `ccS` slot order matches the bracket's.** `brS_expand_right X Y r` is `sum_phi_inner_pair Y (brRightFun X r)` the same way. **Correct.**

## 3. `phiTri_pairs`

`phiTri` is `−¼ ∑_i ∑_j ∑_k ∑_l F(i,j,k,l)`. `phiTri_pairs` is `−¼ ∑_p ∑_q F(p₁,p₂,q₁,q₂)`. Applying `Fintype.sum_prod_type` to the outer sum gives `∑_i ∑_j ∑_q`, and to the inner gives `∑_k ∑_l`. **Every ordered quadruple `(i,j,k,l)` appears exactly once on both sides and no summand is altered.** The summation range is untouched: the diagonal terms `i = j` and `k = l` are present on both sides and vanish, `φ_ii = 0`. **This is `phiTri`.**

## 4. The three expansions, verified independently of their proofs

**`expand_outer`.** Take `Y = brS (phiS p) (phiS q)` and `f = innerRight ↑(B u)`, whose `toFun X` is `inner2 X ↑(B u)`. Then `sum_phi_inner_pair` gives

    ½ ∑_m ⟨[φ_p,φ_q], φ_m⟩ · ⟨φ_m, B u⟩ = ⟨[φ_p,φ_q], B u⟩.

The first factor is `ccS p q m` by definition. The two `inner2_comm` uses turn `⟨φ_m, Bu⟩` into `⟨Bu, φ_m⟩` and `⟨[φ_p,φ_q], Bu⟩` into `⟨Bu, [φ_p,φ_q]⟩`. **`inner2` is symmetric** (`½ tr(XᵀY) = ½ tr((XᵀY)ᵀ) = ½ tr(YᵀX)`), so each is a swap at sign `+1`. **No sign inverts and no slot moves**: `ccS p q m` keeps `p` before `q`, in the order the outer bracket has them. **Correct.**

**`expand_arg`.** `applyRight B m = innerRight (φ_m) ∘ B`, so `applyRight B m (phiS k) = ⟨B φ_k, φ_m⟩ = matS B m k`, output index `m` first. `sum_phi_inner_pair u (applyRight B m)` is the statement. **Correct, with the `½`.**

**`coordS_brS_expand`.** Right slot first, `brS_expand_right (A φ_p) (C φ_q) k`:

    ⟨[Aφ_p, Cφ_q], φ_k⟩ = ½ ∑_h coordS (C φ_q) h · ⟨[Aφ_p, φ_h], φ_k⟩,   coordS (C φ_q) h = matS C h q.

Then `brS_expand_left (A φ_p) h k` on the residue gives `½ ∑_g matS A g p · ccS g h k`. **Product of the two `½`s is `¼`**, and the summand is `matS C h q · matS A g p · ccS g h k`. This is the statement. **Correct**, and the placement matches the derivation's `Ae = ∑_g A_{ge} g`, `Cf = ∑_h C_{hf} h`, `[g,h] = ∑_k c_{ghk} k`.

## 5. `phiTri_summand`'s `1/16`

Composing sections 4's three, independently of the Lean proof:

    ⟨B[Aφ_p,Cφ_q], [φ_p,φ_q]⟩
      = ½ ∑_m ccS p q m · ⟨B u, φ_m⟩                                   (expand_outer)
      = ½ · ½ ∑_m ∑_k ccS p q m · coordS u k · matS B m k               (expand_arg)
      = ½ · ½ · ¼ ∑_m ∑_k ∑_h ∑_g ccS p q m · matS B m k · matS C h q · matS A g p · ccS g h k.

`½ · ½ · ¼ = 1/16`. **The constant is right, and it is four expansions at `½` each, the last two bundled inside `coordS_brS_expand`.** Index placement, slot by slot: `m` is the coordinate the outer bracket is expanded in and is `B`'s OUTPUT (`matS B m k`), `k` is `B`'s INPUT and the coordinate of the inner bracket (`ccS g h k`), `g` is `A`'s output and the inner bracket's first slot, `h` is `C`'s output and its second, `p` is `A`'s input and the outer bracket's first slot, and `q` is `C`'s input and its second. **Every one is where the statement puts it.**

## 6. `phiTri_index`'s `-1/64` and its slots

`phiTri = −¼ ∑_p ∑_q [summand] = −¼ · (1/16) ∑_{p,q,m,k,h,g} …`, and `−¼ · 1/16 = −1/64`. Renaming `p → e`, `q → f` gives the statement verbatim. **The constant is right.**

**The docstring gives two accounts and they are the same account.** `¼ · (½)⁴ = 1/64`, and separately `2⁶ = 64` converts six ordered-pair sums to six `i<j` sums. These agree necessarily: the definition's `¼` is itself two of the six doublings. **No double counting.**

**Slot for slot against the derivation.** Derivation: `Φ(A;B,C) = −∑_{e,f,g,h,k,m} c_{ghk} c_{efm} A_{ge} B_{mk} C_{hf}`. Lean: `ccS g h k * ccS e f m * matS A g e * matS B m k * matS C h f`. **Identical in all eleven index positions**, with `matS`'s output-first convention matching `A_{ge} = ⟨g, Ae⟩`.

**The screen, reported as a screen.** I built three operator triples at `n = 4` myself, entries uniform on `{−3,…,3}` in the `{φ_ij}_{i<j}` basis, seeds 7, 11 and 23, and computed three quantities in exact rationals: `phiTri` from the Lean definition, `Φ = ∑_e Tr(ad_e B ad_{Ae} C)` from the derivation, and `−1/64 ∑` from the index form. All three agree at every seed: `−102` (six-fold sum `6528`), `−11` (`704`), `−173` (`11072`). **A live falsifier fires**: transposing the two indices of `A`, of `B`, or of `C` alone breaks the identity at both non-trivial seeds, nine failures out of nine, so the screen does discriminate against the defect the brief names. *Seed 7 happening to reproduce the record's own `−102`/`6528` is a coincidence of my seed; seeds 11 and 23 are independent of it.* **This corroborates the derivation of sections 4 to 6, and the derivation, not the screen, is the evidence.**

## 7. Does `phiTri_index` suffice for the relabelling

**The substitution checks out.** Writing `phiTri_index` at `(B, C, A')` and matching against `phiTri_index` at `(A, B, C)` after the rotation, the correspondence is `e' = k`, `f' = g`, `g' = m`, `h' = e`, `k' = f`, `m' = h`, which is exactly the inverse of the brief's `(e,f,g,h,k,m) → (h,k,f,m,e,g)`. **Same relabelling, stated from the other end.** Under it `c_{ghk} → c_{e'gh}` and `c_{efm} → c_{g'ef}`, both single cyclic rotations, so `ccS_cyclic` is the only symmetry consumed. **`ccS_cyclic` is on file.**

**The reindexing lemma is not a blocker.** All six sums run over the same `univ : Finset (ι × ι)` and the relabelling permutes only which bound variable plays which role, so it is a chain of `Finset.sum_comm` on the binders followed by `Finset.sum_congr rfl` and `ring` on the summand. `Finset.sum_comm` is Mathlib's and needs nothing new. **`PhiIndex.lean` contains no `sum_comm`, `sum_nbij`, `Fintype.sum_equiv` or `Equiv` and does not need to.** *It is real work, not missing machinery.*

**`matS` can express `A*`, and that is the ingredient with no argument on file.** The brief's arithmetic is right: from `IsAdjoint2 A A'`, instantiated at `X = φ_h`, `Y = φ_f`,

    matS A' h f = ⟨A' φ_f, φ_h⟩ = ⟨φ_h, A' φ_f⟩ = ⟨A φ_h, φ_f⟩ = matS A f h.

**This is one line and it is stated nowhere.** `matS` occurs only in [PhiIndex.lean](../lean/HamiltonsCubic/Results/PhiIndex.lean), `IsAdjoint2` only in [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean), and no declaration mentions both. **So the record's claim, in the commit body and echoed by the index row, that *"what remains for `phiTri_starred` is the substitution and the structure constant's cyclicity, both already on file"*, undercounts the ingredients by one and names as on-file a set that is missing the one thing linking `IsAdjoint2` to the index form.** *The substitution is itself not "on file" in any sense a Lean proof can consume: it is a description of the relabelling, carried in prose.* **Verdict: `phiTri_index` does suffice mathematically, and "the relabelling alone" understates what is unwritten.**

## 8. The two `sorry`s

**`phiTri_starred {A A'} (_h : IsAdjoint2 A A') (B C) : phiTri A B C = phiTri B C A'.`** This is the derivation's step 3 conclusion `Φ(A;B,C) = Φ(B;C,A*)` with the adjoint taken as a relation. **Faithful**, and true on the derivation that [r1013](REVIEW_r1013.md) and [r1014](REVIEW_r1014.md) verified independently, one of them twice. **`IsAdjoint2 A A'` is the right hypothesis**: it says exactly `⟨A X, Y⟩ = ⟨X, A' Y⟩` on `Λ²`, which is what step 3 consumes at the last matching step and nothing more, and `inner2` being nondegenerate on `Λ²` it pins `A'` uniquely, so the relation is as strong as "is the adjoint". *It is not a sufficient hypothesis asserted necessary: the docstring says what it buys and stops.*

**`foxTri2_symm_right (X Y Z) (hX hY hZ : IsSelfAdjoint2 _) : foxTri2 X Y Z = foxTri2 X Z Y.`** This is step 5's `Φ` half plus its trace half, both at self-adjoint arguments. **Faithful**, and true on the derivation. *Its docstring is careful about reach: "neither is claimed at a non-self-adjoint argument, and the derivation shows the `Φ` half needs the rotated slot symmetric".*

## 9. The step-7 move

**The core claim is right.** Commit `c10da32f` replaced `phiTri_rotate`'s docstring wholesale when the `sorry` was promoted to `phiTri_starred`, and the diff shows the paragraph *"AND THERE IS NO CHEAPER ROUTE THROUGH A SECOND TRANSPOSITION"* deleted with it. After that commit **no Lean file held the symmetry finding**, which I confirmed by grepping the tree at that revision. **So "held NOWHERE in the layer" is correct, and the move into `phiTri_starred`'s docstring was the right call rather than a delete-and-link.**

**Its account of where the finding still lived is wrong.** [ATTEMPTS.md](../ATTEMPTS.md) carried it at line 8310, in the corrected form, and `git blame` puts that line in `c10da32f` itself, the very commit that dropped the docstring. [reviews/REVIEW_r1017.md](REVIEW_r1017.md) and [reviews/INDEX.md](INDEX.md) carried it too. **So *"Only [scripts/INDEX.md](../scripts/INDEX.md) still carried it"* is false**, and the entry that records the lesson is three lines below the entry that refutes it, in the same file.

**A second loss from the same replacement is still unrecovered.** The deleted docstring also held *"THE HYPOTHESIS IS LOAD-BEARING, AND A FIRST CONTROL SAID OTHERWISE"*, with its lesson *"One witness is not a control"*. That finding is today in [scripts/INDEX.md](../scripts/INDEX.md) and in three review reports, **and in no Lean file**. `phiTri_rotate` still carries `IsSelfAdjoint2` and nothing beside it says why. *The strongest reading against this: `phiTri_starred` is now unconditional in `A`, so the plain rotation's hypothesis matters less than it did. It still guards the lemma the first variation consumes.*

**`plan.md`'s I36 item says something the record does not support.** It reads: *"[lean/INDEX.md](../lean/INDEX.md)'s eleven `I36` rows carry the layer, audited by [r1015](REVIEW_r1015.md) to [r1017](REVIEW_r1017.md), and every one routes through the single `sorry` `phiTri_starred`"*. **Two errors.** The rows tagged `I36` number thirteen, not eleven. And *"every one routes through"* is refuted by `lean/INDEX.md`'s own rows: `DecomposablePlane.lean`, `PencilProjections.lean`, `I36Budget.lean`, `CubicBridge.lean`, `SharpReduced.lean`, `TraceOp.lean`, `WeylRadical.lean`, `Bivectors2.lean` and now `PhiIndex.lean` are each marked **proved**, standard three axioms, no `sorry`, and none consumes the rotation. **Nine of thirteen rows are counterexamples**, and section 10 confirms the ninth by running the axiom check. *The claim is true of the rows downstream of the rotation, `PcubicDiff_eq_lin`, `PhiTri.lean`'s `phiTri_rotate` and `phiTri_first_variation`, and `FirstVariation.lean`'s `hasDerivAt_Pcubic2_line`, which is four.*

## 10. `#print axioms`

Run under `lake env lean` against the project toolchain, after a clean `lake build` (9221 jobs, exit 0), on all 22 declarations of [PhiIndex.lean](../lean/HamiltonsCubic/Results/PhiIndex.lean):

    phiS, phiS_coe, ccS, matS, ccS_cyclic, ccS_swap12, ccS_swap23, coordS, coordS_apply,
    sum_phi_inner_pair, brLeftFun, brRightFun, brS_expand_left, brS_expand_right,
    phiTri_pairs, applyRight, applyRight_apply, expand_outer, expand_arg,
    coordS_brS_expand, phiTri_summand, phiTri_index

**Every one prints `[propext, Classical.choice, Quot.sound]`. None carries `sorryAx`.** For contrast, in the same run `phiTri_starred`, `phiTri_rotate` and `foxTri2_symm_right` each print `[propext, sorryAx, Classical.choice, Quot.sound]`. **The file's index row's "standard three axioms" is correct**, and the commit body's *"all six declarations"* undercounts the file at 22 without claiming more than is true.

## 11. Prose outrunning the evidence

**Occurrence, proposal 150's neighbouring shape, in the new file.** [PhiIndex.lean](../lean/HamiltonsCubic/Results/PhiIndex.lean)'s module docstring:

> *The outer swap needed none of that and was proved directly; a screen over the six slot permutations then established that the outer swap generates nothing further, so this route is the one left.*

The screen establishes a fact about **slot permutations**. *"so this route is the one left"* quantifies over **routes**, which is the exact reach [r1017](REVIEW_r1017.md) corrected in the sentence *"No cheap route"* one commit earlier. **`PhiTri.lean` gets it right in the same breath**, *"That is a fact about slot permutations and not about proofs, which is the reach [r1017] corrected"*, so the corrected form and the uncorrected one now sit in two files of the same layer. *This is proposal 150's family, a claim that reads as precision and is inherited as a fact about the mathematics.*

**Occurrence, [lean/INDEX.md](../lean/INDEX.md)'s `PhiIndex` row.**

> **What remains is the relabelling alone**, which is `phiTri_starred`, **the layer's one `sorry`**

**The Lean layer holds 61 `sorry`s.** Restricted to the `CurvOp2` second-order sub-layer, which is the most charitable reading, it holds two: `phiTri_starred` at [PhiTri.lean:395](../lean/HamiltonsCubic/Results/PhiTri.lean#L395) and `foxTri2_symm_right` at [FirstVariation.lean:79](../lean/HamiltonsCubic/Results/FirstVariation.lean#L79). **The row is contradicted three rows below by `FirstVariation.lean`'s own row, which is marked "partial, one named `sorry`".** *`PhiTri.lean`'s docstring says "the file's only `sorry`", scoped to the file, and that one is true.*

**Occurrence, `plan.md`'s I36 item**, section 9's *"every one routes through the single `sorry`"* and *"eleven"*. **Refuted by nine of the thirteen rows it describes.**

**Occurrence, the relabelling's ingredients.** The commit body's *"both already on file"* and the index row's *"the relabelling alone"*, against section 7's finding that `matS A' h f = matS A f h` is on file nowhere. **A claim about what remains, made without checking that the link between the hypothesis and the index form exists.**

**Where I looked and found nothing.** `ccS_cyclic`'s docstring, `phiTri_index`'s own docstring on the constant, `phiTri_starred`'s hypothesis paragraph, and `foxTri2_symm_right`'s reach paragraph are each accurate and each says what its object buys without asserting necessity. **No instance of proposal 150's literal shape, a sufficient hypothesis asserted necessary, appears in `PhiIndex.lean` at all**, the file stating no hypothesis of its own.

## Overall verdict

**PROVEN**, for the mathematics under audit. `ccS` is the derivation's structure constant, its three symmetry theorems are correct and cover everything the derivation's step 3 uses, each of the four expansions is one faithful application of `sum_phi_inner_pair`, the `1/16` and the `-1/64` are right, and `phiTri_index` matches `Φ(A;B,C) = -∑ c_{ghk} c_{efm} A_{ge} B_{mk} C_{hf}` in every index position. All 22 declarations are axiom-clean. Both remaining `sorry`s are true and faithfully stated, on the right hypotheses.

**Four corrections are owed, none of them to a theorem statement:**

1. `plan.md`'s *"eleven `I36` rows … every one routes through the single `sorry` `phiTri_starred`"*: thirteen rows, four of which route through it.
2. `lean/INDEX.md`'s `PhiIndex` row: *"the layer's one `sorry`"* should be two, or should name the file it means.
3. `PhiIndex.lean`'s module docstring: *"so this route is the one left"* is the reach [r1017](REVIEW_r1017.md) corrected, recurring.
4. The relabelling's ingredient list: add `matS A' h f = matS A f h`, one line from `IsAdjoint2`, on file nowhere.

**And one recovery is outstanding**: the *"one witness is not a control"* finding, dropped by the same wholesale docstring replacement the step-7 pass diagnosed, is still held in no Lean file.
