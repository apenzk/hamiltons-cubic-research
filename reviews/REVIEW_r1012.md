# r1012: `Qop2`, `P = ⟨R, Q(R)⟩` on `Λ²`, the criticality bridge, and the non-Weyl witness

**Cold brief.** The audit works from the definitions in the dispatch and from [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [CubicBridge.lean](../lean/HamiltonsCubic/Results/CubicBridge.lean) and [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) on disk, not from the record's prose. No numerical work was done. Every value below is exact rational or symbolic arithmetic. Every Lean check ran through `lake env lean` on the project toolchain, Lean 4.33.1 (`lake env lean --version` reports `4.33.1, commit 819816b2e0a3`), and `lake build` completes with 9215 jobs and no error. Log: [agent_logs/r1012.log](../agent_logs/r1012.log).

| # | claim | verdict |
|---|---|---|
| 1 | `Pcubic2_eq_innerOp2` is the correct `P(R) = ⟨R, Q(R)⟩` | PROVEN (and it is a tautology, not a check) |
| 2 | `Qop2` is the record's `Qop` restricted to `Λ²` | PROVEN |
| 3 | `isCritical_extend` is the useful direction, and whether the converse holds | PROVEN, AND THE CONVERSE HOLDS |
| 4 | `sharpQF2_id` by `rfl` across the coercion | PROVEN |
| 5 | `isCritical2_id`, `IsSkew` from `X.2`, and `1 + (n-2) = n-1` | PROVEN |
| 6 | `not_isWeyl2_id`'s `2 ≤ n` is correct and sharp | PROVEN, SHARP |
| 7 | REACH: what inhabitation buys, and whether the owed list is complete | GAP, two items missing |
| 8 | prose claiming more than the theorems establish | GAP, four found |

**Summary, one line.** All ten audited theorems are correct and kernel-clean on the standard three axioms, `isCritical_extend`'s converse holds and is three lines from `eq_zero_of_phi` that the layer has not written, and the reach fails twice: inhabitation of `IsCritical2` is free at the zero operator at every multiplier so what `isCritical2_id` buys is a NONZERO witness, and the plan's owed list names Euler's identity where Fermat needs the full first variation `DP(R)[S] = 3⟨S, Q(R)⟩` and omits the `HasFDerivWithinAt` form of Fermat, the `fderivWithin` form on file being unusable on `{normSq2 = 1}` where `UniqueDiffWithinAt` fails.

## 0. Conventions, fixed once

`ι = Fin n` throughout. `inner2 X Y = ½ tr(Xᵀ Y) = ½ ∑_{p,q} X_{pq} Y_{pq}`. `phi i j = E_ji - E_ij`, so `inner2 (phi i j) (phi k l) = [i=k ∧ j=l] - [j=k ∧ i=l]`, the family `{phi i j : i < j}` is `inner2`-orthonormal, `phi i i = 0` and `phi j i = -phi i j`. `br X Y = XY - YX`. `skewSub ι` is the submodule of skew matrices, carrier `{X | IsSkew X}`, and `mem_skewSub` is `Iff.rfl`, so a term `X.2` of type `↑X ∈ skewSub ι` IS a term of type `IsSkew ↑X`. `CurvOp2 ι = skewSub ι →L[ℝ] skewSub ι`, a **continuous linear** map, so every `R` below is additive and homogeneous on `Λ²` by its type. `applyPhi R i j = ↑(R ⟨phi i j, _⟩)`.

Write `E = skewSub ι` and `B(A, C) = innerOp2 A C = ½ ∑_{i,j} inner2 (applyPhi A i j) (applyPhi C i j)`. **The `½` and the ordered double sum are one device.** The `i = j` terms vanish because `phi i i = 0` and `A` is linear, and the `(i,j)` and `(j,i)` terms are equal because `applyPhi A j i = -applyPhi A i j` on both slots and the two signs cancel, so

> `B(A, C) = ∑_{i < j} inner2 (A e_{ij}) (C e_{ij})` over the orthonormal family `e_{ij} = phi i j`, `i < j`,

which is `tr(A* C)` for the adjoint `*` taken against `inner2`. In particular `normSq2 id = ½(n² - n) = dim Λ²`, which is the identity's trace and the value the file's prose records.

## Hypothesis inventory

| used | where from | status |
|---|---|---|
| `sharpOp_id X hX : sharpOp (fun Z => Z) X = (card ι - 2) • X` | [StructureConstants.lean:217](../lean/HamiltonsCubic/Base/StructureConstants.lean) | granted by the brief |
| `extend_apply R X : extend R ↑X = ↑(R X)` | [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) | granted by the brief |
| `br_mem_skewSub` | [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) | granted by the brief |
| `IsWeyl2` has three clauses, `selfAdjoint`, `bianchi`, `ric` | read on disk, [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) | verified on disk |
| `eq_zero_of_phi`, a linear map out of `Λ²` killing every `phi i j` is zero | read on disk, same file | verified on disk |
| `inner2_phi_phi`, `inner2_self_phi` | [Families.lean:84](../lean/HamiltonsCubic/Base/Families.lean) | verified on disk |
| `I36Shape` quantifies over `IsWeyl2 R ∧ normSq2 R = 1 ∧ IsLocalMaxOn Pcubic2 … ∧ t < Pcubic2 R` | [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) | verified on disk |
| `IsLocalMaxOn.hasFDerivWithinAt_nonpos` exists in this Mathlib | `#check` under `lake env lean` | verified |
| nothing from the record's prose | cold brief | by construction |

All ten audited declarations were run through `#print axioms` on the project toolchain. Every one reports `[propext, Classical.choice, Quot.sound]`: `Pcubic2_eq_innerOp2`, `applyPhi_Qop2`, `Qop_extend`, `isCritical_extend`, `sharpQF2_id`, `sharpMap_id`, `isCritical2_id`, `not_isWeyl2_id`, `Pcubic_extend`, `theta_extend`. No `sorryAx` anywhere.

## 1. `Pcubic2_eq_innerOp2` is correct, and it is a tautology rather than a check

**The identity holds.** Unfolding, `Qop2 R = compOp2 R + sharpMapCL R`, and `applyPhi_Qop2` is `rfl` because `(f + g) X = f X + g X` is definitional for a `ContinuousLinearMap` and `sharpMapCL R X` reduces to `sharpMap R X`. So

```
innerOp2 R (Qop2 R) = ½ ∑_{i,j} inner2 (applyPhi R i j) (applyPhi (compOp2 R) i j + ↑(sharpMap R ⟨φ_ij⟩))
                    = innerOp2 R (compOp2 R) + sharpPair2 R
```

by `inner2_add_right` termwise, which is exactly the file's inner `have`. The first summand is `trCube2 R` by `innerOp2_comm`, whose proof is `inner2_comm` termwise and is genuine. So `Pcubic2 R = trCube2 R + sharpPair2 R = innerOp2 R (Qop2 R)`. Correct.

**The factor of ½ is right and it is the SAME factor in both summands.** `innerOp2` and `sharpPair2` each carry `(1/2) * ∑_i ∑_j`, over the same ordered index set, so the addition above is termwise with no constant to reconcile. `sharpPair2 R` is literally `innerOp2 R (sharpMapCL R)` after `sharpMapCL_apply`, which is `rfl`, so the inlining the [Pcubic2_eq](../lean/HamiltonsCubic/Base/Bivectors2.lean) docstring complained of is now an `innerOp2`.

**The ordered-pair double count is correct**, by section 0: `½ ∑_{i,j}` over ordered pairs is `∑_{i<j}` over the orthonormal family, and this uses only linearity of the operators, which the type supplies.

**`innerOp2 R (compOp2 R)` IS `trCube2 R`, exactly.** `trCube2 R := innerOp2 (compOp2 R) R` by definition and `innerOp2_comm` closes the gap. There is no transpose in disguise **in the theorem**.

**There IS a transpose in disguise in the NAME.** By section 0, `B(A,C) = tr(A* C)`, so `trCube2 R = tr((R∘R)* R) = tr(R* R* R)`. In a matrix reading with `M` the matrix of `R` in the orthonormal `φ` family, `trCube2 R = ∑_{α,β} (M²)_{αβ} M_{αβ} = tr(Mᵀ Mᵀ M)`. That equals `tr(M³)` **iff `M` is symmetric**, which is `IsWeyl2`'s `selfAdjoint` clause. The docstring calls `trCube2` "`tr R³` on `Λ²`" with no hypothesis. Recorded under item 8.

**What the identity does NOT do.** `sharpPair2` is the inlined `innerOp2 R (sharpMapCL R)` and `Qop2` is `compOp2 R + sharpMapCL R`, so `Pcubic2_eq_innerOp2` is `innerOp2`'s additivity and symmetry and cannot fail for ANY `R`, a wrong constant inside `sharpMap` included. [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) says exactly this of its own `Pcubic_eq_inner_Qop`, in the note headed "**`P = ⟨R, Q(R)⟩` holds with no hypothesis on `R`, and it is a TAUTOLOGY rather than a check**". The `Λ²` twin carries no such note. The normalisation is instead pinned by `sharpMap_id` against `sharpOp_id`, which is a real check and is section 5's subject.

**Verdict: PROVEN.** The identity is correct, the ½ and the double count are consistent, and `innerOp2 R (compOp2 R)` is `trCube2 R` on the nose. It carries no independent content about `#`'s normalisation.

## 2. `Qop2` IS the record's `Qop` restricted to `Λ²`

`Qop_extend` is stated **for every `X : skewSub (Fin n)`**, not on the `φ` family, so the question of "two maps agreeing on a spanning set" does not arise. Reading its proof, `Qop (extend R) ↑X = extend R (extend R ↑X) + sharpOp (extend R) ↑X`, and two applications of `extend_apply` turn the first summand into `↑(R (R X)) = ↑(compOp2 R X)`, and `sharpOp_extend`, itself proved for every `X`, turns the second into `↑(sharpMap R X)`. The coercion is additive, so the sum is `↑(Qop2 R X)`. Sound.

**The chain beneath it is all-points too.** `sharpQF_extend` is stated for every `η : skewSub`, `sharpBil_extend` and `sharpOp_extend` for every `X, Y : skewSub`. The step that makes them work is the one the file's header names: `sharpQF`'s double bracket `br η (R (br η (R φ_ij)))` never leaves `Λ²`, because `phi i j` is skew, `extend R` lands in `Λ²` by construction, and `br_mem_skewSub` keeps each bracket skew. So `extend R` is only ever read at skew arguments, where `extend_apply` says it is `R`. No `IsWeyl2` is used anywhere, as claimed.

**The direction that is absent.** Nothing on file says that a RECORD operator's `Qop` is the `Qop2` of its restriction, that is, `Qop S ↑X = ↑(Qop2 (restrict hW) X)` for `hW : IsWeyl S`. It is true, and it needs `IsWeyl`'s FIRST clause and not only linearity: for a bare `S` that does not preserve skewness, `br η (S φ_ij)` need not be skew, so `sharpQF S η` reads `S` at non-skew arguments that `restrict hW` cannot see. This is a lemma not written rather than a defect.

**Verdict: PROVEN.**

## 3. `isCritical_extend`, and its converse, WHICH HOLDS

**The stated direction is sound.** `IsCritical2 R th` is `Qop2 R = th • R`. Applying it at `⟨phi i j, _⟩` and pushing through `Qop_extend` and `extend_apply` gives `Qop (extend R) (phi i j) = th • extend R (phi i j)`, which is `IsCritical (extend R) th`. The rewrite `↑((th • R) X) = th • ↑(R X)` is `rfl` followed by `Submodule.coe_smul`, both correct.

**The converse holds.** `IsCritical` quantifies over the `φ` family and `IsCritical2` is an equation of operators, but `eq_zero_of_phi`, already in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), says a LINEAR map out of `Λ²` killing every `phi i j` is zero, and both `Qop2 R` and `th • R` are linear by their type. Apply it to `(Qop2 R : →ₗ) - (th • R : →ₗ)`. Machine-checked, compiling clean under `lake env lean` on the project toolchain:

```lean
example {n : ℕ} {R : CurvOp2 (Fin n)} {th : ℝ}
    (h : IsCritical (extend R) th) : IsCritical2 R th := by
  have key : ((Qop2 R : CurvOp2 (Fin n)) : skewSub (Fin n) →ₗ[ℝ] skewSub (Fin n))
      - (th • R : CurvOp2 (Fin n)) = 0 := by
    refine eq_zero_of_phi _ fun i j => ?_
    have h1 := h i j
    rw [Qop_extend R ⟨phi i j, phi_mem_skewSub i j⟩,
      show extend R (phi i j)
        = ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) from
        extend_apply R ⟨phi i j, phi_mem_skewSub i j⟩] at h1
    …
```

So `isCritical_extend` is in truth an `iff` and the layer states one half. Nothing fails in the converse. The reason nothing fails is the reason the `Λ²` domain was built: the `φ` family SPANS it, `skew_expand`, where on the bare function type a map is unconstrained off `Λ²` and the converse would be false.

**What this changes.** The `IsCritical2` docstring's implied gain over the record's pointwise `IsCritical` ("an equation between operators rather than the family of equations on the `φ` that the record's `IsCritical` has to use") is notational, not logical. The two predicates are equivalent along `extend`.

**Verdict: PROVEN, AND THE CONVERSE HOLDS.** The missing half is three lines from a lemma already in the file.

## 4. `sharpQF2_id` by `rfl`: the coercion does not change the object

`sharpQF2 R η = -(1/4) ∑_{i,j} inner2 ↑(brS η (R (brS η (R ⟨φ_ij, _⟩)))) (phi i j)`.

At `R = ContinuousLinearMap.id ℝ (skewSub (Fin n))` the reductions are, in order, all definitional:

1. `ContinuousLinearMap.id` applied is `LinearMap.id` applied is `_root_.id x`, which is `x` by delta.
2. `↑(⟨phi i j, h⟩ : skewSub)` is `Subtype.val ⟨phi i j, h⟩`, which is `phi i j` by iota. The coercion on `skewSub` is `Subtype.val` and nothing else, `skewSub` being a `Submodule` whose elements are subtypes of the carrier.
3. `↑(brS X Y) = br ↑X ↑Y` by the same projection reduction, `brS X Y` being `⟨br ↑X ↑Y, _⟩`.

So the left side reduces to `-(1/4) ∑_{i,j} inner2 (br ↑η (br ↑η (phi i j))) (phi i j)`. The right side, `sharpQF (fun Z => Z) ↑η`, reduces to the same after beta. The two are ONE term, and the `rfl` is honest. The second slot of every pairing is the bare `phi i j` on both sides, so the coercion changes nothing about what is paired.

**One thing the statement's shape is worth naming.** The right-hand side is the GLOBAL identity function `fun Z => Z`, which is NOT the canonical extension of the bundled identity. `extend (id) = skewProj`, and the two differ off `Λ²`: checked in Lean, `extend (ContinuousLinearMap.id ℝ (skewSub (Fin 2))) ≠ (fun Z => Z)`, since `skewProj 1 = 0` while `(fun Z => Z) 1 = 1`. There is no conflict, because `sharpQF` at a skew `η` reads its operator only at skew arguments (section 2) and `skewProj` and `fun Z => Z` agree there. It means `sharpQF2_id` picks a second legitimate bare representative rather than the one `sharpQF_extend` uses.

**Verdict: PROVEN.**

## 5. `isCritical2_id`: the `IsSkew` hypothesis and the arithmetic

**`sharpOp_id`'s hypothesis is genuinely discharged.** It needs `IsSkew X` at a bare matrix. In `sharpMap_id` it is applied as `sharpOp_id (X : Matrix …) X.2` where `X : skewSub (Fin n)`, so `X.2 : ↑X ∈ skewSub (Fin n)`. Since `skewSub`'s carrier is the set `{X | IsSkew X}` and membership in a `Submodule` built that way unfolds to membership in the carrier set, which unfolds to `IsSkew ↑X`, the two types are definitionally equal. `mem_skewSub` is `Iff.rfl`, which is the file's own record of this. The hypothesis is met, not bypassed, and the build accepts the application.

The bridge from `sharpMap` to `sharpOp` is `hco`, which needs `sharpBil2 id X ⟨φ_ij⟩ = sharpBil (fun Z => Z) ↑X (phi i j)`. Both are `(1/2)(Q(X + φ) - Q(X) - Q(φ))` in their respective `sharpQF`s, `↑(X + ⟨φ_ij, _⟩) = ↑X + phi i j` is `rfl` for subtype addition, and `sharpQF2_id` is `rfl` by section 4, so the whole of `hco` is `rfl` after the `simp only` moves the coercion past the scalar and the finite sum. Sound. `Fintype.card_fin` then turns `card (Fin n) - 2` into `(n : ℝ) - 2`.

**The arithmetic at the identity.** `compOp2 R = R.comp R`, so `compOp2 id` applied at `X` is `id (id X)`, which is `X`. The `show` in the proof asserts exactly `id (id X) + sharpMap id X = ((n:ℝ) - 1) • X` in the ambient matrices, which the elaborator accepts, so `(f + g) X = f X + g X` and `(compOp2 id) X = X` are both definitional here. Substituting `sharpMap_id`,

> `X + ((n:ℝ) - 2) • X = (1 + ((n:ℝ) - 2)) • X = ((n:ℝ) - 1) • X`,

by `add_smul` and `one_smul`, with `(n:ℝ) - 1 = 1 + ((n:ℝ) - 2)` closed by `ring`. Exact over `ℝ` and valid for every `n : ℕ` including `n = 0, 1`, where both sides are `0` because `skewSub (Fin n)` is then the trivial module and the real identity `1 + (-2) = -1` is still true.

So `Q(id) = id + (n-2)·id = (n-1)·id`. Correct, and it is read off the record's own anchor.

**Verdict: PROVEN.**

## 6. `not_isWeyl2_id`: the bound is correct and SHARP

**The Ricci sum.** `applyPhi id a c = phi a c`, so the clause at `b = a` is `∑_c inner2 (phi a c) (phi a c)`. By `inner2_phi_phi` with `(i,j,k,l) = (a,c,a,c)`,

> `inner2 (phi a c) (phi a c) = [a = a ∧ c = c] - [c = a ∧ a = c] = 1 - [c = a]`,

which is the file's `hterm`. Summing over `c : Fin n` gives `n - 1`. **Yes, `∑_c inner2 (phi a c) (phi a c) = n - 1`.** `IsWeyl2.ric` demands `0`, so the clause forces `(n : ℝ) = 1`, contradicting `2 ≤ n`. The proof needs an index `a` to instantiate at, which is where `0 < n` from `2 ≤ n` is spent. Sound.

**The bound is sharp.** At `n = 0` and `n = 1` the identity IS `IsWeyl2`, so `2 ≤ n` cannot be weakened. Machine-checked, all four compiling clean under `lake env lean` on the project toolchain:

```lean
theorem id_triv1 : (ContinuousLinearMap.id ℝ (skewSub (Fin 1))) = 0 := …
theorem id_triv0 : (ContinuousLinearMap.id ℝ (skewSub (Fin 0))) = 0 := …
example : IsWeyl2 (ContinuousLinearMap.id ℝ (skewSub (Fin 1))) := by rw [id_triv1]; exact isWeyl2_zero
example : IsWeyl2 (ContinuousLinearMap.id ℝ (skewSub (Fin 0))) := by rw [id_triv0]; exact isWeyl2_zero
```

The reason is that `skewSub (Fin 1)` is trivial, a `1×1` matrix with `Xᵀ = -X` having `X₀₀ = -X₀₀`, and `skewSub (Fin 0)` is trivial for want of indices, so in both cases the identity IS the zero operator and `isWeyl2_zero` applies. This agrees with the formula: `ric a a = n - 1 = 0` at `n = 1`, and at `n = 0` the clause is vacuous.

**And `2 ≤ n` is exactly the range where the witness is nonzero**, which matters for section 7. Checked in Lean, `(ContinuousLinearMap.id ℝ (skewSub (Fin 2))) ≠ 0`, via `inner2 (phi 0 1) (phi 0 1) = 1`.

**Verdict: PROVEN, SHARP.**

## 7. REACH

### 7(a). Inhabitation at a non-Weyl operator says nothing about `I36Shape`

**`IsCritical2` and `Qop2` do not occur in `I36Shape`.** Grepped across `lean/`: both names appear in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) and [CubicBridge.lean](../lean/HamiltonsCubic/Results/CubicBridge.lean) and nowhere else. `I36Shape n t` quantifies over `IsWeyl2 R`, `normSq2 R = 1`, `IsLocalMaxOn Pcubic2 {normSq2 = 1} R` and `t < Pcubic2 R`, and concludes coordinate-diagonality. Criticality is not among its hypotheses, its conclusion, or anything it is defined from. **So `isCritical2_id` tells us nothing whatever about `I36Shape`.** It is a statement that `fun R th => Qop2 R = th • R` is not the empty predicate, and the file's own section header says so, which is the honest form.

**And bare non-emptiness was never at risk.** The ZERO operator inhabits `IsCritical2` at EVERY multiplier and every `n`. Machine-checked:

```lean
example {n : ℕ} (th : ℝ) : IsCritical2 (0 : CurvOp2 (Fin n)) th := …
```

because `sharpQF2 0 η = 0` for every `η` (the inner bracket is `br η 0 = 0`), hence `sharpMap 0 = 0`, hence `Qop2 0 = 0 = th • 0`. So the risk the section header names, "a criticality predicate nobody can satisfy", did not exist. **What `isCritical2_id` actually buys is a NONZERO witness at a DETERMINED multiplier**, and by section 6 the witness is nonzero exactly when `2 ≤ n`, the same range `not_isWeyl2_id` needs. That is a real gain and it is a different one from the one claimed.

**Net.** The pair `isCritical2_id` + `not_isWeyl2_id` establishes: the eigen-equation has a nonzero solution at `n ≥ 2`, with `θ = n - 1`, and that solution is outside the class `I36Shape` ranges over. Whether a `IsWeyl2` operator solves it is untouched. The file says this. The plan and [lean/INDEX.md](../lean/INDEX.md) say "the predicate has content", which overstates by the zero operator.

### 7(b). The owed list is INCOMPLETE, by two items

The plan's list is: Euler's identity `DP(R)[R] = 3P(R)` with the symmetry of the cubic form, the tangent cone at `{normSq2 S = 1}`, differentiability of `Pcubic2`, and an inner product over `innerOp2`. Set out what the target `IsLocalMaxOn Pcubic2 {normSq2 = 1} R ∧ normSq2 R = 1 → ∃ θ, IsCritical2 R θ` needs:

| step | on the list | status |
|---|---|---|
| `Pcubic2` differentiable at `R` | yes | listed |
| **first variation `DP(R)[S] = 3 · innerOp2 S (Qop2 R)` for EVERY `S`** | **no** | **MISSING** |
| `posTangentConeAt {normSq2 = 1} R ⊇ {S : innerOp2 S R = 0}`, two-sided | yes | listed |
| **Fermat in the `HasFDerivWithinAt` form** | **no** | **MISSING** |
| `innerOp2` an inner product, definiteness from `normSq2_eq_zero` | yes | listed |
| `(R^⊥)^⊥ = ℝ·R`, the Riesz step | implicit in the previous | listed, weakly |
| `θ = Pcubic2 R = theta2 R` at unit norm | yes, "which is what fixes `θ`" | listed |

**The first omission.** Euler's identity is the RESTRICTION of the first variation to `S = R`. It gives one number, `DP(R)[R] = 3P(R)`, and it is what fixes the multiplier ONCE the eigen-equation is in hand. It does not give the eigen-equation. What Fermat consumes is the functional `S ↦ DP(R)[S]` on the whole tangent hyperplane, and identifying that functional with `3 innerOp2 S (Qop2 R)` is the substantive step: it is the polarised form `T(R,R,S) = innerOp2 S (Qop2 R)` of the trilinear form whose diagonal is `Pcubic2_eq_innerOp2`. Section 1 showed the diagonal identity is a tautology, so it does not deliver the polarised one. **This is the step on which `Qop2` earns the name "the gradient", and nothing on file states it.**

**The second omission, and it is concrete.** [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean)'s two Fermat restatements, `isLocalMaxOn_fderivWithin_nonpos` and `isLocalMaxOn_fderivWithin_eq_zero`, are in the `fderivWithin` form. To use them one must know that `fderivWithin ℝ Pcubic2 s R` IS the derivative one computed, which is `DifferentiableAt.fderivWithin` and needs `UniqueDiffWithinAt ℝ s R`. **That hypothesis is FALSE on `s = {S : normSq2 S = 1}`.** Exhibited in closed form: write `B` for `innerOp2` and let `x ∈ s`. Then

> `B(x - R, x - R) = B(x,x) - 2B(x,R) + B(R,R) = 2 - 2B(x,R)`, so `B(x - R, R) = B(x,R) - 1 = -½ B(x - R, x - R)`.

So `B(· - R, R)` is `O(‖x - R‖²)` along `s`, which is `o(‖x - R‖)`. Hence if `f'` is a within-derivative of `Pcubic2` at `R` along `s`, so is `f' + c·B(·, R)` for every real `c`, and these are distinct linear functionals whenever `R ≠ 0`, which `normSq2 R = 1` gives. The within-derivative is determined only modulo `ℝ·B(·,R)`, `UniqueDiffWithinAt` fails, and `fderivWithin` is a `Classical.choice` among them.

**The repair is available and is not named.** This Mathlib carries

```
IsLocalMaxOn.hasFDerivWithinAt_nonpos :
  IsLocalMaxOn f s a → HasFDerivWithinAt f f' s a → y ∈ posTangentConeAt s a → f' y ≤ 0
```

verified by `#check` on the project toolchain. Feeding it `HasFDerivAt.hasFDerivWithinAt` of the computed derivative sidesteps uniqueness entirely. So the omission costs one lemma name, but the list as written does not contain it, and the file's chosen restatements are the two that cannot be used.

*An aside that does NOT rescue the `fderivWithin` form: the ambiguity is exactly the Lagrange multiplier direction, so the conclusion `fderivWithin(y) = 0` for `y` in the two-sided cone would still be the right one IF one knew the ambiguity were confined to `ℝ·B(·,R)`. Knowing that is itself a characterisation of the set of within-derivatives, which is more work than switching to the `HasFDerivWithinAt` form, and neither is on file.*

**Verdict: GAP.** The list omits the first variation formula and the usable form of Fermat.

## 8. Prose that claims more than the theorems establish

Four, quoted.

**8.1 `trCube2`'s name, [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean).**

> "**`tr R³` on `Λ²`**, the record's `trCube` with the domain changed."

`trCube2 R = innerOp2 (compOp2 R) R = tr(R* R* R)` by section 0, which is `tr(R³)` precisely when `R` is self-adjoint against `inner2`. That is `IsWeyl2`'s first clause, and `trCube2` carries no hypothesis and is consumed by `Pcubic2` at arbitrary `R`. The record's own [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) writes the same thing of `trCube`, so the defect is inherited rather than introduced, and the `Λ²` file is where it can now be stated, `selfAdjoint` being available as a clause.

**8.2 `IsCritical2`'s docstring, same file.**

> "**`R` IS A CRITICAL POINT OF `P` ON THE UNIT SPHERE WITH MULTIPLIER `th`**, as an equation in `CurvOp2`."

`IsCritical2 R th` is the DEFINITION `Qop2 R = th • R`. Nothing on file connects it to `IsLocalMaxOn`, to `fderivWithin`, or to any derivative of `Pcubic2`, and by section 7(b) two of the steps that would are missing. **This claim has no argument on file.** The honest statement is the one the `Qop2` docstring uses, "the eigen-equation". The same over-reach is in `isCritical_extend`'s docstring, "*a critical point of the cubic form on `Λ²` is a critical point in the record's own sense*", where what is proved is that the EIGEN-EQUATION crosses, and in [lean/INDEX.md:135](../lean/INDEX.md) which repeats that sentence verbatim.

**8.3 The vacuity framing, [CubicBridge.lean](../lean/HamiltonsCubic/Results/CubicBridge.lean)'s section header.**

> "**A criticality predicate nobody can satisfy is a predicate about nothing**, and no kernel check sees that."

By section 7(a), `IsCritical2 0 th` holds for every `th` and every `n`, machine-checked. Nobody-can-satisfy was never the risk. The plan repeats the framing, "*So the predicate has content and the Weyl case is untouched*", and [lean/INDEX.md:135](../lean/INDEX.md) repeats it again, "*So the predicate has content*". The claim the theorems support is stronger and different: a NONZERO witness at a determined multiplier, existing exactly for `n ≥ 2`.

**8.4 Fermat's reach, [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean)'s `isLocalMaxOn_fderivWithin_nonpos` docstring.**

> "**FERMAT'S THEOREM AT A CURVATURE OPERATOR ON `Λ²`.** *… This is the step [I75] and hence [I36] wait on, and it was unavailable at every operator type the layer carried.*"

What became available is the typeclass fit. The two restatements are both in the `fderivWithin` form, which by section 7(b) cannot be joined to a computed derivative on `{normSq2 = 1}`, `UniqueDiffWithinAt` failing there. So "this is the step I36 waits on" names a step the file has not put in a usable form. The same sentence is in the section header above it, "**It takes three registrations and no new mathematics**", which is true of the typeclasses and false of the step.

**What is NOT an over-reach, checked and cleared.** The `CubicBridge` header's "*the two forms agree at EVERY continuous operator on `Λ²`*, not only at the Weyl ones" is exactly what `Pcubic_extend` states, with no `IsWeyl2` in its statement or proof, verified by reading the chain in section 2. The section header's "*this settles that the predicate has content and says NOTHING about whether a Weyl operator satisfies it, which is [I36]'s question and a different one*" is careful and correct, and is the [r1011] correction landing. And `sharpMap` deserves its name on this domain: `sharpBil2` is linear in its second slot, by `sharpBil2_comm` with `sharpBil2_add_left` and `sharpBil2_smul_left`, so `sharpMap R X` is the unique bivector with `⟨sharpMap R X, φ_kl⟩ = sharpBil2 R X φ_kl`, the `½` and the double sum reproducing the coordinate exactly. That is the debt [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) records as "not visible here" for the bare layer, and on `Λ²` it is discharged, though no file says so.

**Verdict: GAP, four found.**

## Overall verdict

**GAP.**

All ten audited theorems are correct, their hypotheses are genuinely used, and every one is kernel-clean on `[propext, Classical.choice, Quot.sound]` under the project toolchain. `not_isWeyl2_id`'s `2 ≤ n` is sharp, proved by exhibiting `IsWeyl2` at the identity for `n = 0` and `n = 1`. `isCritical_extend`'s converse holds and is three lines from `eq_zero_of_phi`.

The gap is reach, in two places. `isCritical2_id` is presented as settling that the criticality predicate is not empty, where the zero operator settles that for free at every multiplier, so what it establishes is a nonzero witness for `n ≥ 2`. And the plan's owed list omits the first variation formula `DP(R)[S] = 3 ⟨S, Q(R)⟩`, of which Euler's identity is only the diagonal, and omits the `HasFDerivWithinAt` form of Fermat, the `fderivWithin` form on file being unusable on a constraint set where `UniqueDiffWithinAt` provably fails.

**What would have to be proved** to turn this into `PROVEN` on item 7: the polarised identity `T(R,R,S) = innerOp2 S (Qop2 R)` for the trilinear form `T` with `T(R,R,R) = Pcubic2 R`, together with `HasFDerivAt Pcubic2 (3 • innerOp2 · (Qop2 R)) R`. Then the two calculus steps run through `IsLocalMaxOn.hasFDerivWithinAt_nonpos` rather than through `fderivWithin`.
