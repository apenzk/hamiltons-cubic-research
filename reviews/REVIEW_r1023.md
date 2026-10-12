# Review r1023: the fourth claim of discharge, the trilinear collapse, and the unproved bound

Reviewer: r1023, one of two independent reviewers on this brief. Under review: `95a317aa`, `4701e4f9`, `e8479dbd`.

Log: [agent_logs/r1023.log](../agent_logs/r1023.log)

| # | Item | Verdict |
|---|------|---------|
| 1 | Does `lidem_isSelfAdjoint` discharge FoxProduct.lean's debt, at the fourth attempt? | **CONFIRMED** |
| 2 | Is `isWeyl_smul_op` distinct from `isWeyl_smul`, and correct at `θ = 0`? | **CONFIRMED** |
| 3 | Do the three `cubicTri` identities account for the whole of `Pcubic2_expand`? | **CONFIRMED** |
| 4 | UNPROVED: the operator norm reaches the bound | **REFUTED** |
| 5 | UNPROVED: the constant | **CONFIRMED** |
| 6 | UNPROVED: Mathlib carries no finite-dimensional continuity for multilinear maps | **CONFIRMED** |
| 7 | Is declining to re-promote `IsVonNBounded` right? | **CONFIRMED** on the decision, **REFUTED** on the three kernel claims beside it |
| 8 | Overreach sweep | **nine sentences**, listed below |

**The round's finding is item 7's, and it is not about `IsVonNBounded`.** *[CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) says the iterated-bundling route is CLOSED, "checked in the kernel rather than guessed".* **Two of the three checks it names do not say what it reports, and the instance the third fails to find is produced by naming it**: `NormedAddCommGroup (CurvOp2 (Fin 3) →L[ℝ] ℝ) := ContinuousLinearMap.toNormedAddCommGroup` elaborates inside the `OperatorNorm` scope. *A failed instance search is not a closed route, and this layer has recorded that exact distinction twice already.*

## 1. The debt is discharged, at the domain the consumers use. CONFIRMED

**The reach test that failed for [r1021](REVIEW_r1021.md) now elaborates.** At a general index type, at `IsWeylOp` hypotheses, and at `idemOf W θ`:

```lean
example {ι : Type*} [Fintype ι] [DecidableEq ι] {W X Y : CurvOp ι}
    (hW : IsWeylOp W) (hX : IsWeylOp X) (hY : IsWeylOp Y) (θ : ℝ) :
    innerOp (Lidem W θ X) Y = innerOp X (Lidem W θ Y) :=
  lidem_isSelfAdjoint hW.2 hX.2 hY.2 θ
```

All three gaps r1021 named are closed, each checked separately.

| Gap | Previous state | Now |
|---|---|---|
| Index type | `foxTri_symm_right` at `Fin n` | general `ι`, the whole chain generalised in `95a317aa` |
| Operator | symmetry at a bare `W` | `isWeyl_idemOf` carries it to `idemOf W θ` |
| Hypothesis | `IsWeyl` against the consumers' `IsWeylOp` | favourable direction, `hX.2` supplies it |

**And the discharge reaches the live call sites, not only the general statement.** [RayleighLE](../lean/HamiltonsCubic/Base/FoxProduct.lean) and [RayleighGE](../lean/HamiltonsCubic/Base/FoxProduct.lean) are instantiated at `W = diagOp w` in [L98Statement.lean](../lean/HamiltonsCubic/Results/L98Statement.lean) and [L99Statement.lean](../lean/HamiltonsCubic/Results/L99Statement.lean), and [diagOp_isWeyl](../lean/HamiltonsCubic/Base/Families.lean) supplies the `IsWeyl W` those sites need. *That is the first of the four rounds where nothing further stands between the theorem and its users.*

**The full symmetry of `T`, the other half of the owed bullet, composes as r1021 confirmed.** `foxTri_comm` carries no hypothesis, `foxTri_symm_right` carries three `IsWeyl`s, and the composite at the idempotent elaborates:

```lean
example {W X Y : CurvOp ι} (hW : IsWeylOp W) (hX : IsWeylOp X) (hY : IsWeylOp Y) (θ : ℝ) :
    foxTri (idemOf W θ) X Y = foxTri Y X (idemOf W θ) := by
  rw [foxTri_comm (idemOf W θ) X Y, foxTri_symm_right hX.2 (isWeyl_idemOf hW.2 θ) hY.2,
    foxTri_comm X Y (idemOf W θ)]
```

**One sentence in the discharged bullet claims more than the theorem gives**, and it is listed under item 8: *"`lidem_isSelfAdjoint` is what the consumers of this file need"*. The consumers are quadratic forms at `X = Y`, where `innerOp_comm` alone gives the identity. What needs self-adjointness is the equivalence of the Rayleigh reading with a spectral maximum, and that needs two further things the same file still lists as owed: `L_e` linear, and `L_e` preserving the admissible subspace. Self-adjointness is one ingredient of three.

**And two sentences elsewhere in the same file still say the debt stands**, which is an internal contradiction rather than an over-claim. See item 8, (a) and (b).

## 2. `isWeyl_smul_op` is a different statement, and it is right at `θ = 0`. CONFIRMED

**The two signatures share no shape.** Printed from the kernel:

```
@isWeyl_smul    : IsWeyl R → ∀ (c : ℝ) {X}, IsSkew X → R (c • X) = c • R X
@isWeyl_smul_op : IsWeyl R → ∀ (c : ℝ), IsWeyl (c • R)
```

*One is homogeneity of a fixed `R` along its argument and is an equation between matrices. The other is a closure property of the predicate under scaling the operator and is a `Prop` about `c • R`.* **Neither implies the other**, and the resemblance r1021 flagged is in the name alone.

**`θ = 0` is covered and the docstring describes it accurately.** `isWeyl_idemOf` takes `(θ : ℝ)` with no positivity hypothesis, and both halves of its docstring's claim check:

```lean
example {W : CurvOp ι} (hW : IsWeyl W) : IsWeyl (idemOf W 0) := isWeyl_idemOf hW 0
example (W : CurvOp ι) : idemOf W 0 = (0 : CurvOp ι) := by
  funext Z; show (0:ℝ)⁻¹ • W Z = 0; simp
```

*So "at every `θ`, `θ = 0` included, where it is the zero operator" is exactly what the declaration proves*, and it matches [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s standing convention for `idemOf` at `θ = 0`, already carried by `foxProd_idemOf_self`.

## 3. The eight arrangements partition exactly into the four groups. CONFIRMED

**Verified in the kernel both ways.** The expansion itself:

```lean
example (R H : CurvOp2 ι) :
    cubicTri (R + H) (R + H) (R + H)
      = cubicTri R R R
        + (cubicTri H R R + cubicTri R H R + cubicTri R R H)
        + (cubicTri H H R + cubicTri H R H + cubicTri R H H)
        + cubicTri H H H := by
  simp only [cubicTri_add_left, cubicTri_add_mid, cubicTri_add_right]
  ring
```

and then `Pcubic2_expand` reproved from `cubicTri` alone, which is the test the brief asked for:

```lean
example (R H : CurvOp2 ι) :
    Pcubic2 (R + H) = Pcubic2 R + Pcubic2Lin R H + Pcubic2Quad R H + Pcubic2 H := by
  rw [Pcubic2_eq_cubicTri (R + H), Pcubic2_eq_cubicTri R, Pcubic2_eq_cubicTri H,
    Pcubic2Lin_eq_cubicTri, Pcubic2Quad_eq_cubicTri]
  simp only [cubicTri_add_left, cubicTri_add_mid, cubicTri_add_right]
  ring
```

**Nothing is double-counted and nothing is missing**: `1 + 3 + 3 + 1 = 8`, and the grouping is by the number of `H` slots, which is what the docstring claims. *So "`Pcubic2_expand` is the trilinear expansion of `C(R+H,R+H,R+H)` and nothing else" is a true sentence and the strongest of the three commits' claims.*

## 4. The estimate owes THREE things, and the docstring names two. REFUTED

**What the docstring asserts**: *"The operator norm reaches the bound, `‖A ∘ B‖ ≤ ‖A‖‖B‖` being `ContinuousLinearMap.opNorm_comp_le` and `‖A X‖ ≤ ‖A‖‖X‖` being `le_opNorm`, so what the estimate actually owes is two things the layer lacks for its OWN pairing."*

**Both named lemmas do apply at the layer's own types**, which I checked rather than assumed, inside the `OperatorNorm` scope:

```lean
example (X Y : CurvOp2 (Fin 3)) : ‖X.comp Y‖ ≤ ‖X‖ * ‖Y‖ := X.opNorm_comp_le Y
example (X : CurvOp2 (Fin 3)) (v : skewSub (Fin 3)) : ‖X v‖ ≤ ‖X‖ * ‖v‖ := X.le_opNorm v
```

**The failure is the word "two".** `cubicTri X Y Z = innerOp2 (X.comp Y) Z - ½ Φ(X;Y,Z)`, and the two named lemmas reach the first summand only. [phiTri](../lean/HamiltonsCubic/Results/PhiTri.lean) is

```
Φ(A;B,C) = -(1/4) ∑_{ijkl} ⟨B (brS (A φ_ij) (C φ_kl)), brS φ_ij φ_kl⟩
```

and `brS` is the commutator of two MATRIX values, [brS](../lean/HamiltonsCubic/Base/Bivectors2.lean), not a composition of the operators `A` and `C`. **`opNorm_comp_le` says nothing about it.** *Bounding `Φ` needs submultiplicativity of the Frobenius norm on matrices, which is a fact about matrix multiplication and is the third owed ingredient.*

**It is available and it is four lines**, which I proved rather than located:

```lean
example (X Y : Matrix (Fin 3) (Fin 3) ℝ) : ‖br X Y‖ ≤ 2 * ‖X‖ * ‖Y‖ := by
  have h1 : ‖X * Y‖ ≤ ‖X‖ * ‖Y‖ := Matrix.frobenius_norm_mul X Y
  have h2 : ‖Y * X‖ ≤ ‖Y‖ * ‖X‖ := Matrix.frobenius_norm_mul Y X
  have h3 : ‖X * Y - Y * X‖ ≤ ‖X * Y‖ + ‖Y * X‖ := norm_sub_le _ _
  show ‖X * Y - Y * X‖ ≤ 2 * ‖X‖ * ‖Y‖
  nlinarith
```

**The correction.** The owed list is three items: a Cauchy-Schwarz for `inner2` (now proved), the bound `|innerOp2 A B| ≤ c‖A‖‖B‖`, and a bracket bound `‖brS X Y‖ ≤ 2‖X‖‖Y‖` from [Matrix.frobenius_norm_mul](../lean/.lake/packages/mathlib/Mathlib/Analysis/Matrix/Normed.lean). *The omission matters because the `Φ` half is the half the record's own second-order apparatus is about, and a list of what is owed is the thing the next cycle works from.* **One further step is free and worth recording beside it**: `‖(v : skewSub ι)‖ = ‖(v : Matrix ι ι ℝ)‖` is `rfl`, so the matrix-level bound reaches the operator-level one with no bridge lemma.

## 5. The two halves compose to exactly `normSq2 id`. CONFIRMED

**The parent's chain is arithmetically right**, and the two `½`s do not collide. Writing `‖·‖` for the Frobenius norm on matrices and for the scoped sup operator norm on `CurvOp2`:

| Step | Fact | Where |
|---|---|---|
| 1 | `innerOp2 A B = ½ ∑_{ij} ⟨A φ_ij, B φ_ij⟩` | [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean) |
| 2 | `\|⟨X,Y⟩\| ≤ √⟨X,X⟩ √⟨Y,Y⟩` | `abs_inner2_le` |
| 3 | `⟨X,X⟩ = ‖X‖²/2`, so step 2 reads `\|⟨X,Y⟩\| ≤ ‖X‖‖Y‖/2` | `inner2_self_eq_frobenius` |
| 4 | `‖A φ_ij‖ ≤ ‖A‖‖φ_ij‖` | `ContinuousLinearMap.le_opNorm` |
| 5 | `∑_{ij} ‖φ_ij‖² = 4 · normSq2 id` | `inner2_self_phi`, `⟨φ_ij, φ_ij⟩ = 1` at `i ≠ j` |

Composing: `|innerOp2 A B| ≤ ½ ∑ ‖Aφ‖‖Bφ‖/2 ≤ ¼ ‖A‖‖B‖ ∑ ‖φ_ij‖² = ‖A‖‖B‖ · normSq2 id`.

**So `c = normSq2 id` exactly, with no factor left over.** *The `½` of `inner2` enters as the `½` of step 3, the `½` of `innerOp2`'s ordered-pair doubling as the outer `½` of step 1, and their product `¼` is precisely the `¼` that turns `∑ ‖φ_ij‖²` into `normSq2 id`.* **Two independent corroborations**: `normSq2 id = ½n(n-1)` as [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) records it, and `normSq2 id = 3` at `Fin 3` as [r1021](REVIEW_r1021.md) checked it, against `n(n-1)/2 = 3`.

**The one step I machine-checked**, since it is where the halves meet:

```lean
theorem inner2_sq_le_norm (X Y : Matrix ι ι ℝ) : inner2 X Y ^ 2 ≤ (‖X‖ * ‖Y‖ / 2) ^ 2 := by
  have h := inner2_sq_le X Y
  rw [inner2_self_eq_frobenius, inner2_self_eq_frobenius] at h
  calc inner2 X Y ^ 2 ≤ ‖X‖ ^ 2 / 2 * (‖Y‖ ^ 2 / 2) := h
    _ = (‖X‖ * ‖Y‖ / 2) ^ 2 := by ring
```

**A remark the route should carry.** The constant `normSq2 id` is the price of mixing two norms: `‖A‖` here is the scoped SUP operator norm, while `innerOp2` is the record's own pairing. *Read entirely in the record's pairing, Cauchy-Schwarz for `innerOp2` gives `|innerOp2 A B| ≤ √(normSq2 A) √(normSq2 B)` with NO constant at all*, since `innerOp2` is an inner product and [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean) already carries its core. **The constant is an artefact of the norm the estimate is stated in, not of the pairing.**

## 6. Mathlib carries no such lemma for multilinear maps. CONFIRMED

**Searched three ways, all negative.**

- Every occurrence of `continuous_of_finiteDimensional` in Mathlib: `LinearMap`, `AffineMap` and `AffineEquiv` only, in [Topology/Algebra/Module/FiniteDimension.lean](../lean/.lake/packages/mathlib/Mathlib/Topology/Algebra/Module/FiniteDimension.lean) and [Analysis/Normed/Module/FiniteDimension.lean](../lean/.lake/packages/mathlib/Mathlib/Analysis/Normed/Module/FiniteDimension.lean). No multilinear variant.
- Every Mathlib file mentioning both *multilinear* and `FiniteDimensional`: eight files, all applications (Laplacian, Fourier, Schwartz, Weierstrass, q-expansions, determinants). None states automatic continuity.
- [LinearAlgebra/Multilinear/FiniteDimensional.lean](../lean/.lake/packages/mathlib/Mathlib/LinearAlgebra/Multilinear/FiniteDimensional.lean), the file whose name would carry it, proves `Module.Finite` and `Module.Free` for `MultilinearMap` and nothing topological. The normed multilinear file offers `mkContinuous` and `mkContinuousOfExistsBound`, both of which TAKE a bound.

**So the claim stands, and the conclusion drawn from it is where to be careful.** *The docstring continues "so the constant has to be supplied by hand through `LinearMap.mkContinuous₂` whichever scope the work happens in".* **That is one route and not the only one**: the estimate the file needs is an inequality between real numbers, and nothing in it requires `cubicTri` to be bundled as a `ContinuousMultilinearMap` at all. The four-line bracket bound in item 4 is the shape the whole estimate has.

## 7. Declining to re-promote `IsVonNBounded` is right, and the three checks beside it are not what the file reports. CONFIRMED on the decision, REFUTED on the checks

**The decision stands, on grounds the layer already holds.** The scoped `OperatorNorm` supplies the `NormedAddCommGroup` and `NormedSpace` that `IsLocalMaxOn.hasFDerivWithinAt_nonpos` wants, the constraint set `{S | normSq2 S = 1}` is a set rather than a norm-sphere, and [r1017](REVIEW_r1017.md) compiled `PcubicDiff` across the scope boundary. *Calling a failed synthesis a reason to register the inner product would repeat the over-correction [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean) records, and the commit is right to refuse it.*

**The three kernel claims are another matter. I ran each in its own file.**

| Claim as the file states it | What `#synth` returns |
|---|---|
| `IsTopologicalAddGroup (CurvOp2 (Fin 3))` fails inside the scope | **SUCCEEDS**, `ContinuousLinearMap.topologicalAddGroup`, inside the scope AND outside it |
| `ContinuousAdd (CurvOp2 (Fin 3))` fails outside the scope | fails outside, and **fails inside too**, so the scope attribution carries no information |
| `NormedAddCommGroup (CurvOp2 (Fin 3) →L[ℝ] ℝ)` fails inside the scope | fails, and **the instance is produced by naming it** |

**The third is the finding.** The search failure is real and survives a budget of `synthInstance.maxHeartbeats 1000000`, and the instance exists anyway:

```lean
open scoped HamiltonsCubic.RealLayer.OperatorNorm
noncomputable example : NormedAddCommGroup (CurvOp2 (Fin 3) →L[ℝ] ℝ) :=
  ContinuousLinearMap.toNormedAddCommGroup   -- elaborates, no error
```

*With that one instance named, the next bundling level follows: `NormedAddCommGroup (CurvOp2 (Fin 3) →L[ℝ] (CurvOp2 (Fin 3) →L[ℝ] ℝ))` then elaborates the same way.* **The mechanism is the diamond the layer has already recorded**: inside the scope `#synth TopologicalSpace (CurvOp2 (Fin 3))` returns `ContinuousLinearMap.topologicalSpace`, the native one, while the scoped norm carries the metric topology beside it. The two are equal at default transparency and not reducibly, so elaboration against a fixed goal succeeds where search fails. *The `ContinuousAdd` failure has the same shape at the `Add` field: the goal wants `ContinuousLinearMap.add` and the group route offers `AddGroup.toSubNegMonoid.toAdd`.*

**The correction.** *"THE ITERATED-BUNDLING ROUTE IS CLOSED, CHECKED IN THE KERNEL RATHER THAN GUESSED"* is refuted by the kernel it appeals to. The accurate sentence is that instance SEARCH does not reach the bundling instances at `CurvOp2`, that naming `ContinuousLinearMap.toNormedAddCommGroup` at each level supplies them, and that the route is therefore open and tedious rather than closed. **This is the third time this layer has recorded the same distinction**: [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) already says *"The instances exist and instance SEARCH does not reach them ... Naming them is the whole repair."* **A check that cannot distinguish "unreachable by search" from "does not exist" is being read as if it could**, which is the shape [r1006](REVIEW_r1006.md) recorded under the blind `rfl`.

*The route's remaining friction is real and should be recorded as friction*: registering `NormedSpace ℝ` at the first dual level wants `SMulCommClass ℝ ℝ`, and the second level timed out at the default `synthInstance` budget in my scratch. **That is a cost, not a closure.**

## 8. Overreach sweep: nine sentences

**(a) and (b) are contradictions inside one file rather than over-claims**, and they are the most likely to mislead a reader.

**(a)** [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), the `λ_max` reading: *"The equivalence with a spectral maximum needs `L_e` self-adjoint, which is owed here (see below)"*. The bullet it points at now says DISCHARGED. **Correction**: self-adjointness is proved in [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean); what the equivalence still waits on is `L_e` linear and `𝒲ₙ`-invariant.

**(b)** Same file, the Rayleigh section: *"`L_e` is self-adjoint on the record and not here"*. **Correction**: it is self-adjoint here too, at record-Weyl arguments, by `lidem_isSelfAdjoint`. *Both sentences were left untouched by `95a317aa`, which edited the owed bullet twenty lines above them.*

**(c)** [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), the discharged bullet: *"`lidem_isSelfAdjoint` is what the consumers of this file need"*. **A sufficient ingredient asserted as the whole need.** The consumers evaluate a quadratic form at `X = Y` and use no symmetry at all. The spectral reading needs three things and this is one.

**(d)** [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean): *"so what the estimate actually owes is two things the layer lacks for its OWN pairing"*. **It owes three**, item 4.

**(e)** [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean): *"THE ITERATED-BUNDLING ROUTE IS CLOSED, CHECKED IN THE KERNEL RATHER THAN GUESSED"*. **Refuted by the kernel**, item 7.

**(f)** [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean): *"`IsTopologicalAddGroup (CurvOp2 (Fin 3))` failing there too"*. **False.** It synthesizes, in both scopes.

**(g)** [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean): *"outside the scope `ContinuousAdd (CurvOp2 (Fin 3))` fails"*. **True and empty as stated**: it fails inside the scope as well, so the sentence's contrast between the scopes is not a fact about the scopes.

**(h)** [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean), the headline: *"a trilinear form on a finite-dimensional space is bounded, so `|Pcubic2Quad R H| ≤ 3‖C‖‖R‖‖H‖²`"*. **The estimate is written in a norm the same docstring denies itself.** `‖C‖` is the norm of a bundled continuous multilinear map, and the paragraph twenty lines below says no such bundling is available. *The arithmetic of the `3` is right once `‖C‖` exists.*

**(i)** [CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean), the bridge section: *"This is what lets a bound proved about `inner2` be read as a bound in the norm `HasFDerivAt` will be stated in"*. **`inner2_self_eq_frobenius` bridges to the Frobenius norm on MATRICES**, one level below the operators. `HasFDerivAt` over `CurvOp2` is stated in the scoped SUP operator norm, and [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean) records that the two give different unit spheres from `n = 3`. *The step between them is `le_opNorm`, and it is not this lemma.*

**Two record gaps, neither an over-claim.**

- **[CubicTri.lean](../lean/HamiltonsCubic/Results/CubicTri.lean) is in no index.** `grep -c CubicTri lean/INDEX.md` returns `0`, against `2` for its sibling [PcubicDiff.lean](../lean/HamiltonsCubic/Results/PcubicDiff.lean) and `1` for [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean). Two of the three commits under review put their whole deliverable in that file.
- **[ATTEMPTS.md](../ATTEMPTS.md)'s *"neither turned out to be mathematics"* is fair on the index type and generous on the second gap.** `isWeyl_smul_op` is about twenty lines with four clauses to discharge. *The claim it makes about attention is right, the claim it makes about the work is not.*

**What the sweep did NOT find.** The [lean/INDEX.md](../lean/INDEX.md) I36 row, the [plan.md](../plan.md) I36 entry and the [reviews/INDEX.md](../reviews/INDEX.md) r1021 row all state the discharge with its hypotheses attached, at a general index type and at `idemOf W θ`, and every one of those is checkable and checks. *The discharge claim itself is the best-stated of the four attempts.*
