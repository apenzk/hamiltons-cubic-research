# r1011: the crossed-term route to `sharpMap`'s linearity, and the bundling `sharpMapL`

**Cold brief.** The audit works from the definitions in the dispatch and from [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) on disk, not from the record's prose. No numerical work was done beyond one screen, reported as a screen and never as evidence for a positive claim. Every value in it is exact rational arithmetic. Every Lean check ran through `lake env lean` on the project toolchain, Lean 4.33.1. Log: [agent_logs/r1011.log](../agent_logs/r1011.log).

| # | claim | verdict |
|---|---|---|
| 1 | `sharpQF2_eq_crossPair2` holds by `rfl`, so `crossPair2` genuinely separates the slots | PROVEN |
| 2 | `sharpBil2_eq` is the correct polarisation | PROVEN |
| 3 | `sharpBil2_add_left`, `_smul_left` and `_comm` are bilinearity | PROVEN |
| 4 | `sharpMapL` bundles the same function `sharpMap` | PROVEN |
| 5 | VACUITY: `sharpMapL R` is not zero on the class `I36Shape` ranges over | HYPOTHESIS-DEBT |
| 6 | REACH: the plan's remaining list is complete for `Q(R) = θ R` | GAP |
| 7 | prose claiming more than the theorems establish | GAP, three found |

**Summary, one line.** The four mathematical claims are proven and kernel-clean. The identity operator used in the vacuity screen fails `IsWeyl2`'s `ric` clause by `n-1` so the screen is void for the class, the plan's remaining list omits the derivative of `Pcubic2` **in `R`** and a `Qop` without which `Q(R) = θ R` cannot be stated, and `sharpMapL R` is a bare `LinearMap` that does not inhabit `CurvOp2 ι`, which is the type both sides of that equation live in.

## 0. Conventions, fixed once

`ι = Fin n`. `phi i j` carries `-1` at `(i,j)` and `+1` at `(j,i)` per [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) line 44, and everything below is invariant under the overall sign because each expression is even in it. `inner2 X Y = ½ tr(Xᵀ Y) = ½ ∑_{p,q} X_{pq} Y_{pq}`, so `inner2 (phi i j) (phi i j) = 1` for `i ≠ j` and `0` for `i = j`, and the family `{phi i j : i < j}` is `inner2`-orthonormal. `br X Y = XY - YX`. `CurvOp2 ι := skewSub ι →L[ℝ] skewSub ι`, a **continuous** linear map, at line 244. `applyPhi R i j` is `R ⟨phi i j, _⟩` read as a matrix. `normSq2 R = innerOp2 R R = ½ ∑_{i,j} inner2 (applyPhi R i j) (applyPhi R i j)`.

## Hypothesis inventory

| used | where from | status |
|---|---|---|
| `brS` bilinear, four lemmas | given in the brief, lines 449-484 | granted |
| `br_mem_skewSub` | given in the brief | granted |
| `R : CurvOp2 ι` is additive and homogeneous | the type, `→L[ℝ]` | granted |
| `IsWeyl2` has three clauses, `selfAdjoint`, `bianchi`, `ric` | line 341 of the file, read directly | verified on disk |
| `I36Shape` quantifies over `IsWeyl2 R ∧ normSq2 R = 1` | [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) line 311, read directly | verified on disk |
| nothing from the record's prose | cold brief | by construction |

## 1. `sharpQF2_eq_crossPair2` is `rfl`, and the separation is real

`crossTerm2 R X Y i j = brS X (R (brS Y (R φ_ij)))`, so the **outer** bracket takes the first slot and the **inner** bracket takes the second. Substituting `Y := X` gives `brS X (R (brS X (R φ_ij)))`, which is `sharpTerm R X i j` syntactically, and `crossPair2 R X X` then carries the same `-(1/4)` and the same double sum as `sharpQF2 R X`. The two sides are one term after delta reduction, so `rfl` is the honest proof and the normalisation is identical by construction rather than by a coincidence of constants.

Machine-checked independently of the file's own statement:

```
example (R : CurvOp2 (Fin 4)) (X : skewSub (Fin 4)) : sharpQF2 R X = crossPair2 R X X := rfl
```

elaborates. `#print axioms HamiltonsCubic.RealLayer.sharpQF2_eq_crossPair2` returns `[propext, Classical.choice, Quot.sound]`, so no `sorryAx`.

The separation is genuine in the sense the item asks about: `crossPair2` is additive and homogeneous in **each** slot separately, by `crossPair2_add_left`, `crossPair2_add_right`, `crossPair2_smul_left` and `crossPair2_smul_right`, each of which reduces to the matching `crossTerm2` lemma under the sum and `inner2_add_left` / `inner2_smul_left`. The right-slot versions are the ones that carry content: `crossTerm2_add_right` needs `brS_add_left`, then `map_add` to push the sum through `R`, then `brS_add_right`, three steps where the left-slot version needs one. That is exactly the work `sharpTerm_add` could not do on its own.

**Verdict: PROVEN.**

## 2. The polarisation is correct, and carries no factor slip

Write `c(X,Y)` for `crossPair2 R X Y`. By section 1, `sharpQF2 R Z = c(Z,Z)`, and `c` is additive in each slot. Then

`c(X+Y, X+Y) = c(X, X+Y) + c(Y, X+Y) = c(X,X) + c(X,Y) + c(Y,X) + c(Y,Y)`.

So

`sharpBil2 R X Y = ½ ( c(X+Y,X+Y) - c(X,X) - c(Y,Y) ) = ½ ( c(X,Y) + c(Y,X) )`,

which is `sharpBil2_eq` exactly. The two pure terms cancel against the two subtractions, as the docstring says. The Lean proof does the three `sharpQF2_eq_crossPair2` rewrites, one `crossPair2_add_left`, two `crossPair2_add_right` and `ring`, which is that derivation step for step.

The normalisation check the item invites, and which a polarisation gets wrong when it is wrong: the form must restore the quadratic form on the diagonal. `sharpBil2 R X X = ½(c(X,X) + c(X,X)) = c(X,X) = sharpQF2 R X`. Machine-checked:

```
example (R : CurvOp2 (Fin 4)) (X : skewSub (Fin 4)) : sharpBil2 R X X = sharpQF2 R X := by
  rw [sharpBil2_eq, sharpQF2_eq_crossPair2]; ring
```

elaborates. There is therefore no factor of two hiding between `sharpQF2` and `sharpBil2`, which is the failure mode a polarisation identity usually carries. `#print axioms` on `sharpBil2_eq` is clean.

**Verdict: PROVEN.**

## 3. The three lemmas are bilinearity, in full

`sharpBil2_comm` is immediate from `sharpBil2_eq` by `ring`, the right-hand side being symmetric in `X` and `Y` on its face. Given it, left additivity and left homogeneity transport to the right slot. The question the item raises is whether that assembles into a bilinear form rather than into four lemmas that look like one, so I built the form from the file's three lemmas and nothing else:

```
noncomputable example (R : CurvOp2 (Fin 4)) :
    skewSub (Fin 4) →ₗ[ℝ] skewSub (Fin 4) →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ (sharpBil2 R)
    (fun X X' Y => sharpBil2_add_left R X X' Y)
    (fun c X Y => by rw [sharpBil2_smul_left]; rfl)
    (fun X Y Y' => by
      rw [sharpBil2_comm, sharpBil2_add_left, sharpBil2_comm R Y X, sharpBil2_comm R Y' X])
    (fun c X Y => by rw [sharpBil2_comm, sharpBil2_smul_left, sharpBil2_comm R Y X]; rfl)
```

It elaborates. So the three named lemmas are `LinearMap.mk₂`'s four fields up to `smul_eq_mul`, which is full bilinearity over `ℝ` on `skewSub ι × skewSub ι` with no restriction on the arguments. Nothing is dressed up: `sharpBil2_smul_left`'s proof goes through `crossPair2_smul_left` **and** `crossPair2_smul_right`, both of which rest on `brS_smul_left` and `brS_smul_right`, which is the bracket's scalar half that [r1010](REVIEW_r1010.md) found `sharpTerm_add` lacking. The homogeneity is therefore earned rather than inherited.

One consequence worth recording, because it is what makes `sharpMap` well posed at all: `skew_expand` writes a bivector `Y` as `½ ∑∑ inner2(Y, φ_ij) • φ_ij`, so `sharpMap R X = ½ ∑∑ sharpBil2 R X φ_ij • φ_ij` is the `inner2`-Riesz representative of the functional `Z ↦ sharpBil2 R X Z`. That reading requires the functional to be linear in `Z`, which is precisely the right-slot half now available. Before this round the definition of `sharpMap` was a formula, not a representative.

**Verdict: PROVEN.**

## 4. The bundling is the same function, definitionally

`sharpMapL R` is declared with `toFun := sharpMap R`, so the underlying function is not a new one and the question of agreement on the `φ` family does not arise. Machine-checked without using the file's own `sharpMapL_apply`:

```
example (R : CurvOp2 (Fin 4)) (X : skewSub (Fin 4)) : (sharpMapL R) X = sharpMap R X := rfl
```

elaborates, and `#print axioms HamiltonsCubic.RealLayer.sharpMapL_apply` is clean.

The two structure fields are sound. `map_add'` pushes the sum and the `½ •` through, then reduces to `sharpBil2_add_left` and `add_smul` on each summand. `map_smul'` scales each coefficient by `sharpBil2_smul_left`, absorbs it with `smul_smul`, and the final `smul_comm` moves `c` past the outer `½`, with `rfl` discharging `RingHom.id ℝ`. Both are the right arguments for the right fields.

**Verdict: PROVEN.**

## 5. VACUITY. The identity is not `IsWeyl2`, and the screen is void for the class

### 5.1 The identity fails `ric`, by hand

`IsWeyl2`'s third clause, at line 351, is `ric : ∀ a b, ∑ c, inner2 (applyPhi R a c) (phi b c) = 0`. At `R = id` on `Λ²`, `applyPhi id a c = phi a c`, so the clause reads `∑_c inner2 (phi a c) (phi b c) = 0`.

Compute it in closed form. `phi a c` has `∓1` at `(a,c)` and `(c,a)` and zero elsewhere, and is the zero matrix when `a = c`. For `a ≠ b`: the term at `c = a` vanishes because `phi a a = 0`, the term at `c = b` vanishes because `phi b b = 0`, and for `c ∉ {a,b}` the supports `{(a,c),(c,a)}` and `{(b,c),(c,b)}` are disjoint, so the entrywise product is zero. The off-diagonal clause holds. For `a = b`: the sum is `∑_{c ≠ a} inner2 (phi a c) (phi a c) = n - 1`.

So `ric a a = n - 1`, which is nonzero for every `n ≥ 2`. **The identity operator on `Λ²` is not `IsWeyl2`.** This is the expected answer geometrically: the identity is the constant-curvature operator, which is pure scalar part and carries the largest possible Ricci trace, and the Weyl class is by definition its complement.

The identity also fails the second hypothesis of [I36Shape](../lean/HamiltonsCubic/Results/TensorBridge.lean): `normSq2 id = ½ ∑_{i,j} inner2 (phi i j) (phi i j) = ½ n(n-1)`, which is `6` at `n = 4` and not `1`.

### 5.2 Screen, reported as a screen

Exact rational arithmetic, `Fraction`, no floating point, at `n = 4`, on objects built for this check. At `R = id`: `selfAdjoint` deviation `0`, `bianchi` deviation `0`, `ric(0,0) = 3`, `ric(0,1) = 0`, `normSq2 = 6`. This reproduces 5.1 at `n = 4` and reproduces the author's `‖sharpMap(φ₀₁)‖_F² = 8`, that is `2√2`, so my mirror of the definitions agrees with theirs and the disagreement is about the class and not about the arithmetic.

The same screen at a genuine Weyl operator, built as the traceless symmetric endomorphism `λ = (2,-1,-1)` of `Λ⁺` extended by zero on `Λ⁻`, with `Λ⁺` spanned by `φ₀₁+φ₂₃`, `φ₀₂-φ₁₃`, `φ₀₃+φ₁₂`: all three `IsWeyl2` clauses come out **exactly** zero, and `‖sharpMap(R, φ₀₁)‖_F² = 4`, `‖sharpMap(R, ω₁)‖_F² = 16`, `‖sharpMap(R, ω₂)‖_F² = 64`. Its `normSq2` is `6`, and all three `IsWeyl2` clauses are `ℝ`-linear in `R`, so `R/√6` is `IsWeyl2` at unit norm, where `sharpMap` is quadratic in `R` and the values above divide by `36` without vanishing.

### 5.3 What this settles and what it leaves

The screen bears on the class and suggests strongly that non-vacuity holds there. Under this brief's standing rule a screen is never evidence for a positive claim, so it does not establish it, and the file carries no argument that does. Note also that `isWeyl2_zero` puts `0` in the class, at which `sharpMap` is identically zero, so any non-vacuity statement has to quote `normSq2 R = 1` and not merely `IsWeyl2 R`.

**The claim "`sharpMapL R` is not the zero map for the operators `I36Shape` quantifies over" has no argument on file.** The author's screen is at an operator outside the class on both of its hypotheses, so it does not bear on it.

**What would have to be proved**: `∃ R : CurvOp2 (Fin n), IsWeyl2 R ∧ normSq2 R = 1 ∧ sharpMapL R ≠ 0` at some `n ≥ 4`, or, cheaper and enough for the file's purpose, `sharpMapL R ≠ 0` at the witness [r1009](REVIEW_r1009.md) already exhibited.

**Verdict: HYPOTHESIS-DEBT.**

## 6. REACH. The list is incomplete, and the gap is the dependence on `R`

The plan's owed list is: the tangent cone at the constraint set, differentiability of `Pcubic2`, an inner product over `innerOp2` to replace the scoped sup norm, and `Pcubic (extend R) = Pcubic2 R`. Four items are missing from it.

**(a) `sharpMapL` being linear in `X` is orthogonal to what Fermat's output needs.** Fermat's theorem as the file states it, `isLocalMaxOn_fderivWithin_nonpos`, produces `fderivWithin ℝ Pcubic2 s R : CurvOp2 ι → ℝ`, a functional on operator directions. Its linearity is `fderiv`'s, free. What turning that into `Q(R) = θ R` needs is the derivative of `Pcubic2` **in `R`**, and the file carries no statement about how `Pcubic2` depends on `R` beyond `Pcubic2_eq`, which the file itself marks as `rfl` and contentless. Counting occurrences: `sharpQF2` has `R` twice, so `sharpBil2` and `sharpMap` have it twice, and `sharpPair2 R = ½ ∑∑ inner2 (applyPhi R i j) (sharpMap R φ_ij)` has it three times. `trCube2` likewise has it three times. `Pcubic2` is a cubic form in `R`, and linearity of `sharpMapL` in the bivector slot says nothing about that.

**(b) The value of the derivative, not just its existence.** Differentiability, the plan's second calculus lemma, gives that `fderiv` exists. The eigenvalue equation needs its identification: that the trilinear form under `Pcubic2` is symmetric, so that `D Pcubic2 (R) [H] = 3 · T(R,R,H)` for the associated symmetric trilinear `T`, and Euler's identity `D Pcubic2 (R) [R] = 3 Pcubic2 R`, which is what fixes `θ` as `3 Pcubic2 R` at unit norm. Neither is on the list.

**(c) `Qop` does not exist, so `Q(R) = θ R` is not yet statable.** The file says this about itself, at `Pcubic2_eq`: `sharpPair2` inlines the pairing rather than calling `innerOp2`, so the record's `P = ⟨R, Q(R)⟩` has no analogue here until a `Qop` is transported. An inner product over `innerOp2` is necessary for the Riesz step and is on the list, but the definition of `Qop` and the theorem `Pcubic2 R = innerOp2 R (Qop R)` are not.

**(d) `sharpMapL R` does not inhabit `CurvOp2 ι`, which is the type the equation lives in.** `CurvOp2 ι := skewSub ι →L[ℝ] skewSub ι` at line 244, and `sharpMapL R : skewSub ι →ₗ[ℝ] skewSub ι`. Checked:

```
example (R : CurvOp2 (Fin 4)) : CurvOp2 (Fin 4) := sharpMapL R
```

fails with `Type mismatch ... has type ↥(skewSub (Fin 4)) →ₗ[ℝ] ↥(skewSub (Fin 4)) but is expected to have type CurvOp2 (Fin 4)`. Both sides of `Q(R) = θ R` must be `CurvOp2`, `R` being one, so the bundling stops one constructor short. The repair is one line and available today:

```
noncomputable example (R : CurvOp2 (Fin 4)) : CurvOp2 (Fin 4) :=
  LinearMap.toContinuousLinearMap (sharpMapL R)
```

elaborates, `restrict` already using the same constructor at line 782. **This is cheap and should be done in the same round as the bundling**, since without it `sharpMapL` cannot be the left-hand side of anything.

A fifth observation, on whether the bundling is load-bearing at all today: `sharpMapL` appears nowhere in the repository outside its own definition and `sharpMapL_apply`, and `sharpPair2` calls `sharpMap` rather than `sharpMapL`. The bundling is inert until (d) is taken and a `Qop` is built on it.

**Verdict: GAP**, four items missing, of which (b) and (c) are mathematics and (d) is one line.

## 7. Prose that claims more than the theorems establish. Three

**(i) The `sharpMapL` docstring, line 667.** "**`R#` AS A LINEAR MAP**, which is what Fermat's output has to be read against: the first-order condition delivers a linear functional, and turning that into an eigenvalue equation needs `sharpMap` bundled rather than merely defined."

Two claims past the reach. The linearity bundled is in the **bivector** argument, while Fermat's output at `a : CurvOp2 ι` is a functional on **operator** directions, so the bundling is not the object the first-order condition is read against. And the bundled object is a bare `LinearMap`, so it cannot be a side of `Q(R) = θ R` as typed, by the type mismatch in 6(d). The true statement the theorem supports is narrower and worth having: the bundling makes `sharpMap R` a `LinearMap` in the bivector slot, which is the prerequisite for upgrading it to a `CurvOp2` and hence for defining a `Qop` at all.

**(ii) [plan.md](../plan.md), the `sharpMap` IS BUNDLED paragraph.** "`sharpMapL : skewSub ι →ₗ[ℝ] skewSub ι`, *the piece Fermat's output has to be read against.*" Same overreach, repeated where it is likeliest to be cited. The same paragraph continues "*Screened for vacuity at `n = 4`, `‖sharpMap(φ₀₁)‖_F = 2√2`*", which by section 5 is a screen at an operator satisfying neither hypothesis of `I36Shape`, so "screened for vacuity" overstates what the screen covers. The arithmetic reproduces and the class does not.

**(iii) The `sharpBil2_eq` docstring, line 628.** "*This is what turns `sharpTerm_add`'s additivity into bilinearity: the pure terms cancel against the two subtractions and what is left is the two crossed ones.*"

The second half is right and is section 2. The attribution is wrong: `sharpTerm_add` is used nowhere in the crossed-term route, the four `crossPair2` lemmas resting on `crossTerm2` and `brS` directly, and it appears in the repository only in its own statement and in three prose sentences. The same file says so two sections earlier, at line 533, "the route to a `LinearMap` runs through the crossed term rather than through that expansion", so the two sentences disagree with each other. The accurate statement is that the polarisation turns `crossPair2`'s slotwise linearity into bilinearity.

**Nothing found against** the following, each checked: `n(n-1)` at the identity in the `eq_zero_of_phi_sq_sum` docstring is right, `∑_{i,j} inner2 (phi i j) (phi i j) = n(n-1)`; the `¼` in `sharpQF2`'s docstring is accounted for as `½ · ½`; the note that `sharpMap` landing in `Λ²` is no contrast with the record's `sharpOp`; the scoped-instance warning that `‖id‖ = 1` against `normSq2 id = ½n(n-1)` are different spheres, which my screen confirms at `n = 4` with `normSq2 id = 6`.

One smaller thing, below the threshold for a numbered finding. The Fermat section proposes an `InnerProductSpace ℝ (CurvOp2 ι)` over `innerOp2` "*whose definiteness is `normSq2_eq_zero` above*". Definiteness is necessary and not sufficient: the instance also needs `0 ≤ innerOp2 R R`, and the file carries no `normSq2_nonneg`. It is a sum of squares and so is a line of work rather than a question, but the sentence reads as if the only missing ingredient were already present.

**Verdict: GAP**, three overreaching statements, all three quotable and all three cheap to fix.

## Overall verdict

**PROVEN**, for the claim actually under audit: `sharpMap R` is linear in its bivector argument, `sharpMapL R` bundles that function and no other, the polarisation behind it is correct and carries no factor slip, and the whole chain is kernel-clean with axioms `[propext, Classical.choice, Quot.sound]` under the project toolchain. The file builds, exit 0, warnings only.

Two debts sit beside it and neither is closed by these theorems. **Non-vacuity on the class `I36Shape` quantifies over has no argument on file**, the screen offered for it being at the identity, which fails `ric` by `n-1` and has `normSq2 = ½n(n-1)`. **And the reach claimed for the bundling is not the reach it has**: `Q(R) = θ R` turns on the dependence of `Pcubic2` on `R`, which is cubic and about which the layer states nothing, and `sharpMapL R` is not yet of the type either side of that equation lives in.

Actionable, in cost order: upgrade `sharpMapL` to `CurvOp2` with `LinearMap.toContinuousLinearMap`, one line; correct the three prose statements in section 7; re-run the vacuity screen at a witness satisfying `IsWeyl2` and `normSq2 R = 1`, or prove non-vacuity there; add Euler's identity and the symmetry of the cubic form to the owed list, ahead of the two calculus lemmas.
