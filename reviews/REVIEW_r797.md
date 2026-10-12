# REVIEW_r797, the Lean base layer against the record

**Brief.** Break the definitions in [lean/HamiltonsCubic/Base/](../lean/HamiltonsCubic/Base/), find where a definition is not the object the record means. Cold brief, analysis only; the screening allowance was used once and is labelled where it was used.

**Headline.** The definitions are the record's. The exposure is elsewhere: **no theorem in the real layer is sensitive to the constant in `#`.** Replace [sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean)'s `-(1/4)` by `-c` for any real `c` and every declaration in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean), [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) and [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) still holds. Against that, two of the layer's three standing obligations are discharged below by hand, in a few lines each, from the record's own tabled normalisations.

## Verdicts

| claim | verdict |
| --- | --- |
| 1. [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean) is 𝒲ₙ | CONFIRMED, there is no next missing clause, and the clause reported missing today is a theorem of two clauses already there |
| 2. [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean) is `R#`, [Qop](../lean/HamiltonsCubic/Base/WeylReal.lean) is `Q = R² + R#` | CONFIRMED, derivation supplied below; the layer records it as owed |
| 3. [Pcubic](../lean/HamiltonsCubic/Base/WeylReal.lean) is `P`, [theta](../lean/HamiltonsCubic/Base/WeylReal.lean) is `P/‖W‖³` | CONFIRMED |
| 4. [ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean) and [ProblemPNamed](../lean/HamiltonsCubic/Base/Families.lean) state Problem P | PLAUSIBLE, ProblemPNamed is strictly stronger than [README.md](../README.md)'s wording, and is exactly the record's own Θₙ target |
| 5a. [IsSphereProduct](../lean/HamiltonsCubic/Base/Families.lean) is the record's family | REFUTED as written, `t ≠ 0` admits the sign-reversed family; correction below |
| 5b. [WCP2](../lean/HamiltonsCubic/Base/Families.lean) is `W_{ℂP²}` | CONFIRMED |
| 5c. [theta0Sq](../lean/HamiltonsCubic/Base/Families.lean) and [ThetaSq](../lean/HamiltonsCubic/Base/Families.lean) | CONFIRMED |
| 6. [Alt](../lean/HamiltonsCubic/Base/AltPart.lean) carries the ⅓, [defectSq](../lean/HamiltonsCubic/Base/AltPart.lean) is `δ²` | CONFIRMED |
| 7. [br_phi_phi](../lean/HamiltonsCubic/Base/StructureConstants.lean) is the 𝔰𝔬(n) bracket | CONFIRMED |

## 1. `IsWeyl`: the next clause, and there is none

**The clause reported missing today is derivable from two clauses that are already there.** [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) introduces [IsLinOp](../lean/HamiltonsCubic/Base/FoxProduct.lean) as *"the clause `IsWeyl` omits"*, and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s closing note and [plan.md](../plan.md)'s B1 carry it as owed. On the arguments every quantity in the layer evaluates, it is a theorem.

*Proof.* Fix `Y` skew. `IsWeyl`'s second clause gives `inner2 (R X) Y = inner2 X (R Y)` for every skew `X`, and the right-hand side is linear in `X` over the whole matrix space. So for skew `X`, `X'` the element `D := R (X + X') - R X - R X'` satisfies `inner2 D Y = 0` at every skew `Y`. `IsWeyl`'s first clause makes `D` skew, and `inner2` is positive definite (`inner2 X X = ½ ∑ X_{ab}²`), so `D = 0`. The same for scalars. Hence `R` restricted to the skew subspace is linear. ∎

**And nothing in the layer reads `R` off the skew subspace.** `compOp` applies `R` to `R (phi i j)`, skew by clause one; `sharpQF R η` applies `R` to `br η (R (phi i j))`, and the bracket of two skew matrices is skew, so every argument is skew whenever `η` is; `sharpOp` is consumed only at `phi i j` (inside [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean) and inside [IsCritical](../lean/HamiltonsCubic/Base/WeylReal.lean)), where the polarisation's `η = X + phi i j` is skew. So `normSq`, `trCube`, `sharpPair`, `Pcubic`, `theta`, `Qop` and `IsCritical` all factor through the restriction of `R` to bivectors, and on that restriction `IsWeyl` says: linear, skew-valued, self-adjoint, first Bianchi, Ricci-flat. That is 𝒲ₙ exactly, and trace-freeness on Λ² follows (`∑_a Ric_{aa} = 2 tr W`).

**The attack that broke the earlier definition does not run again.** Without clause one, `inner2 (R X) Y = 0` at every skew `Y` left the symmetric part of `R X` free, which is what let a symmetric-valued map pass every clause while `normSq` and `trCube` saw it in full. With clause one that kernel is trivial, so the construction the audit built at `n = 5` has no analogue. I looked for a second escape of the same shape (a quantity in the layer that reads `R` where `IsWeyl` does not constrain it) and found none; the enumeration above is exhaustive over the definitions in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean).

**Consequence for `IsWeylOp`.** `IsLinOp ∧ IsWeyl` is strictly stronger than `IsWeyl` (it constrains `R` on symmetric matrices, where `IsWeyl` says nothing) but the two cut out the same set of restrictions-to-bivectors, so every statement in the layer taking `IsWeylOp` is equivalent to the same statement taking `IsWeyl`. The extra hypothesis is sound and inert. The docstrings calling linearity an omission of 𝒲ₙ overstate: what is omitted is linearity on the symmetric block, which is not part of 𝒲ₙ either.

## 2. `sharpOp` is `R#`, the layer's standing obligation, discharged

[WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) records two things as owed: that `sharpOp R X` is `R# X`, and the record's mandated anchor `id# = (n-2)·id`. Both follow from the record's own tabled index formula.

**Step one: `sharpQF` is minus half a trace.** The map `T : X ↦ br η (R (br η (R X)))` is `ad_η R ad_η R` on Λ². The family `{phi i j}_{i<j}` is orthonormal for `inner2` (the record's `‖φ_{ab}‖² = 1` under the half-trace pairing, [conventions.md](../findings/conventions.md)), so `∑_{i,j} inner2 (T φ_{ij}) φ_{ij} = 2 tr T`, and `sharpQF R η = -(1/4)·2·tr T = -½ tr(ad_η R ad_η R)`. **This is where the `-¼` over ordered pairs is earned:** one `½` is the ordered double count, the other is the `½` the record's `#` index formula carries.

**Step two: the polarisation is `⟨R# X, Y⟩`.** With `c_{αβγ} = ⟨[v_α,v_β],v_γ⟩` totally antisymmetric and `(R#)_{αβ} = ½ ∑ c_{αγδ} c_{βεζ} R_{γε} R_{δζ}`, the record's formula, with the `½` [conventions.md](../findings/conventions.md) insists on, write `∑_α X_α c_{αγδ} = (ad_X)_{δγ}`. Then

`⟨R# X, Y⟩ = ½ ∑ (ad_X)_{δγ}(ad_Y)_{ζε} R_{γε} R_{δζ} = -½ tr(ad_X R ad_Y R)`,

using the antisymmetry of `ad_Y` once and the symmetry of `R` once. At `X = Y` that is step one, so `sharpQF R η = ⟨R# η, η⟩`; and `½(q(X+Y) - q(X) - q(Y)) = -½ tr(ad_X R ad_Y R)` by cyclicity, which is [sharpBil](../lean/HamiltonsCubic/Base/WeylReal.lean). The bilinearity this uses needs `R` linear on bivectors, which claim 1 supplies from `IsWeyl` itself.

**Step three: `sharpOp` reassembles.** `sharpOp R X = ½ ∑_{i,j} ⟨R# X, φ_{ij}⟩ φ_{ij}`, which is [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean) applied to the skew matrix `R# X`. So `sharpOp R = R#` on bivectors, and [Qop](../lean/HamiltonsCubic/Base/WeylReal.lean) is `R² + R#`.

**Step four: the anchor, which the real layer can carry.** Take `R = id`. Then `sharpQF id η = -½ tr(ad_η²) = -½ B(η,η)` where `B` is the Killing form of 𝔰𝔬(n), which the record fixes at `B(X,Y) = (n-2) tr(XY)` with `tr(v²) = -2` at a unit bivector. So `tr(η²) = -2 inner2 η η` and `sharpQF id η = (n-2)‖η‖²`. Polarising, `sharpBil id X Y = (n-2)⟨X,Y⟩`; reassembling by `skew_expand`, `sharpOp id X = (n-2) X` for skew `X`. **`id# = (n-2)·id` holds in the real layer at every `n`, and the proof is the four lines above.**

**So the answer the brief asks for.** The `-¼` over ordered pairs *is* the record's normalisation, and the way I know it is the anchor, not the shape coincidence [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s closing note settles for. That note's shape argument is separately correct, [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean)'s `-½` runs over the six unordered basis bivectors and `coord4 A a = A(j,i) = inner2 A (phi i j)`, so the two sums are the same number, but it is an argument about two spellings, where the anchor is an argument about the object.

**Screen.** I transcribed the Lean definitions of `phi`, `inner2`, `br`, `innerOp`, `sharpQF`, `sharpBil`, `sharpOp`, `normSq` and `Pcubic` into a throwaway script and evaluated them on objects built for the purpose. `sharpQF id η = (n-2)‖η‖²` at `n = 4, 5, 6` on a random skew `η`; `sharpOp id X = (n-2)X` to `3·10⁻¹⁵`; at the layer's own `WCP2`, `normSq = 6`, `Pcubic = 18`, `theta = 1.2247448714 = √(3/2)`, `Ric = 0`; `normSq star4 = 6` and `star4² = id` on `φ₀₁`. Reported as a screen of claims argued above, and as evidence for nothing.

## 3. The theorems that cannot fail

**`Pcubic_eq_inner_Qop` is one and the file says so. Here are the others.**

- **[foxTri_self](../lean/HamiltonsCubic/Base/FoxProduct.lean)**, `T(R,R,R) = P(R)`. Its docstring says *"if the `½` in `∘` were anywhere else this would fail by a factor"*, which is true and is the whole of its content: it is [Qop_smul](../lean/HamiltonsCubic/Base/FoxProduct.lean) (degree-2 homogeneity) composed with the acknowledged tautology. **It is insensitive to the constant in `#`**, since rescaling `sharpOp` leaves `Qop` quadratic and leaves `Pcubic = innerOp R (Qop R)` a definitional identity. The brief asks whether an alternative convention passes it: every `#`-rescaling does.
- **[foxProd_idemOf_self](../lean/HamiltonsCubic/Base/FoxProduct.lean) and [Lidem_idemOf](../lean/HamiltonsCubic/Base/FoxProduct.lean)**, `e ∘ e = e`. Homogeneity plus `IsCritical`; no `#` constant enters. Same insensitivity.
- **[WCP2_theta](../lean/HamiltonsCubic/Base/Families.lean)**, `θ(W_{ℂP²}) = √(3/2)` **given `Pcubic WCP2 = 18` as a hypothesis**. The arithmetic is `18 / 6^{3/2}`. If the layer's `#` were mis-normalised the hypothesis would be unsatisfiable and the theorem would still be true, vacuously. It is not a check on the layer; the check would be discharging the hypothesis. (The record's numbers are internally consistent: on Λ⁺ the structure constants are `c = √2 ε` (forced by the row marginal `2(n-2) = 4`) so `W# = 2 adj(W) = diag(2,-4,-4)`, `⟨W,W#⟩ = 12`, `tr W³ = 6`, `P = 18`, and `Q(W) = 3W`.)
- **[altNormSq_of_isWeyl](../lean/HamiltonsCubic/Base/AltPart.lean) and [altNormSq_eq_zero_iff](../lean/HamiltonsCubic/Base/AltPart.lean)**, *"`Alt` annihilates every Weyl tensor"*. `altCoeff` is `⅓ · bianchi` by `rfl` and `IsWeyl`'s third clause is `bianchi = 0`, so this restates a hypothesis. The record's clause is a fact about a projection; here it is definitional.
- **[Pcubic_eq](../lean/HamiltonsCubic/Base/WeylReal.lean)** is `rfl`, and `Pcubic_zero`, `normSq_zero`, `Qop_zero`, `isWeyl_zero`, `isWeylOp_zero`, `defectSq_zero_spectrum` are non-vacuity checks at the zero operator, which certify nothing beyond inhabitation, [isWeylOp_zero](../lean/HamiltonsCubic/Base/FoxProduct.lean) says so of itself.

**Which of the layer's claimed checks do have bite.** [inner2_complexStructure](../lean/HamiltonsCubic/Base/SelfDual.lean) giving `3` is a genuine anchor on the `½` in `inner2`: under plain Frobenius it reads `6`. [WCP2_normSq](../lean/HamiltonsCubic/Base/Families.lean) giving `6` is genuine and independent: `WCP2` is built through [proj](../lean/HamiltonsCubic/Base/Families.lean), which reads `inner2`, so moving the `½` doubles the operator and quadruples the norm to `24`. **[normSq_star4](../lean/HamiltonsCubic/Base/SelfDual.lean) giving `6` is the one that an alternative convention passes**: `star4` is defined by the Levi-Civita contraction and never touches `inner2`, so it is an isometric involution and `normSq star4 = normSq id = dim Λ²ℝ⁴ = 6` under both the record's placement of the `½` and the operator-level placement [conventions.md](../findings/conventions.md) warns against. It confirms the internal consistency of the `¼` against the `½`, which is anyway the theorem [normSq_eq_fourNormSq_comp](../lean/HamiltonsCubic/Base/AltPart.lean), and pins nothing on its own.

## 4. `IsSphereProduct` admits the sign-reversed family, REFUTED as written

**Located.** [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), `IsSphereProduct`, at the line reading `∃ (S : Finset ι) (t : ℝ), 2 ≤ S.card ∧ 2 ≤ Sᶜ.card ∧ t ≠ 0 ∧ R = diagOp (t • sphereWeight S)`.

**Exhibited.** Take any `S` with a `2 + 2` split and `t = -1`. Then `-W_{p,q}` satisfies `IsSphereProduct`. It is a Weyl operator, but it is not the Weyl tensor of a product of spheres: `P` is cubic, so `P(-W) = -P(W)` and `θ(-W) = -θ_{p,q} < 0`. The docstring's stated reason, *"closed under nonzero scaling, because `ProblemP` asks for a competitor at unit norm and `θ` is scale-invariant"*, is the error in one line: `θ` is invariant under **positive** scaling and odd under negation.

**The file disagrees with itself.** [SphereProductValue](../lean/HamiltonsCubic/Base/Families.lean) requires `0 < t`, and [exists_unit_sphereProduct](../lean/HamiltonsCubic/Base/Families.lean) instantiates at `t = 1/√(normSq) > 0`. So the family's own value statement excludes exactly the members `IsSphereProduct` admits.

**Argued the opposite.** In [ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean) the predicate sits inside an existential, so enlarging it weakens the statement: `ProblemPNamed` is implied by the version with `0 < t` and cannot be made false by the extra members. On that reading the definition is harmless where it is currently used. It stops being harmless the moment a consumer reads `IsSphereProduct S → θ(S) = Θₙ` or `IsSphereProduct S → P(S) > 0`, both of which are false as the predicate stands, and both of which are the natural things to write next.

**Correction.** Replace `t ≠ 0` by `0 < t`, and replace the docstring's *"θ is scale-invariant"* by *"θ is invariant under positive scaling"*. Nothing in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) breaks: `exists_unit_sphereProduct` already supplies a positive `t` and discharges its side condition by `positivity`.

## 5. `StructureConstants.lean` claims an anchor it does not state

**Located.** [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean), module docstring: *"[Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) anchors the `ℚ` layer at `n = 4` by `native_decide`; this file anchors the `ℝ` layer at every `n`, by computing"*, and again at the `## The `#` anchor` heading: *"What [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) discharges at `n = 4` by `native_decide`, here at every `n` by computing, and it is the only check the `ℝ` layer has on `#`"*.

**Exhibited.** The file declares four theorems: `br_phi_phi`, `br_phi_share`, `br_phi_disjoint`, `br_br_phi`. The identifiers `sharpQF`, `sharpBil`, `sharpOp` and `Pcubic` do not occur in it. `br_br_phi` says `ad_{φab}²` acts by `-1` on `φ_{ad}`; that is one ingredient of the Killing-form computation and is not the anchor, and no declaration connects it to `#`. So the real layer has **no** check on `#`, where the file says it has one, which is the more dangerous direction than having none and saying so, because [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s own note *"the record's own anchor on any `#` formula is absent from this layer"* is now contradicted by a later file and a reader will take the later word.

**Argued the opposite.** `br_br_phi`'s docstring says the `2(n-2)` moved directions are *"the whole content of the anchor"*, and mathematically they are: summing them is the Killing constant, which is step four of §2 above. The charitable reading is that the file supplies the ingredient and the docstring describes the intent. It survives only as intent: an anchor that no proposition states is not discharged, and the ingredient is three lines short of the statement.

**Correction.** State it. `theorem sharpOp_id (X : Matrix ι ι ℝ) (hX : IsSkew X) : sharpOp (fun Y => Y) X = ((Fintype.card ι : ℝ) - 2) • X`, proved through `sharpQF (fun Y => Y) η = (n-2) * inner2 η η` and `skew_expand`. Until then the two files should say the same thing about what the layer has.

## 6. `IsCritical` names the unit-norm multiplier and does not require unit norm

**Located.** [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), `IsCritical`, whose docstring reads *"`R` is a critical point of `P` on the unit sphere with multiplier `θ`"* while the definition is `∀ i j, Qop R (phi i j) = th • R (phi i j)` with no norm hypothesis.

**Exhibited.** This is precisely the trap [conventions.md](../findings/conventions.md) books: *"`Q(W_{p,q}) = ((n-1)/(pq)) W_{p,q}` is a statement about the RAW representative, not about the unit sphere… at `(3,3)` the raw factor is `5/9` against `θ₀(6) = √10/3`."* The raw `S³ × S³` operator satisfies `IsCritical W (5/9)` while `θ(W) = √10/3`, so `th` is not `theta R`.

**Argued the opposite, and this one is withdrawn as a defect.** The eigen-equation on the raw representative is a real relation the record uses, and the consumers guard it: [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean)'s `L74Bridge` carries `normSq (…) = 1` as its own hypothesis before extracting `th`, and `foxProd_idemOf_self` needs only homogeneity, so `e = W/th` is an idempotent at the raw multiplier too. **Withdrawn**, the definition is right and the docstring is the thing to fix, by saying that `th` is `θ` when `‖R‖ = 1` and the raw multiplier otherwise. Recording it so the next reader does not spend a round proving the definition wrong.

## 7. `phi` is the record's basis bivector negated, withdrawn

**Located.** [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), `phi i j := Matrix.single j i 1 - Matrix.single i j 1`, i.e. `E_{ji} - E_{ij}`, against [conventions.md](../findings/conventions.md)'s `φ_{ab} = E_{ab} - E_{ba}`.

**Exhibited.** `inner2 Y (phi i j) = -Y_{ij}` where the record's basis gives `+Y_{ij}`; the structure constants `c_{αβγ}` flip sign, being cubic in the basis.

**Argued the opposite, and it holds.** Every quantity the layer computes is even in `φ`: `inner2 (R φ) φ`, `bianchi`, `Ric`, `innerOp`, `sharpQF` and `sharpOp` each carry `φ` twice, and `T_{αβγ} = c_{αβγ}²`. `inner2_phi` and `skew_expand` are internally consistent with the layer's own sign, so the coordinates round-trip. [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean) states the divergence explicitly and gives this reason. **Withdrawn**, and worth leaving on the record so the sign is not re-litigated.

## 8. `ProblemP` and `ProblemPNamed` against Problem P

`ProblemP` is `12 ≤ card ι → ∀ R, IsWeyl R → normSq R = 1 → ∃ S, IsWeyl S ∧ normSq S = 1 ∧ IsSphereProduct S ∧ Pcubic R ≤ Pcubic S`. That is [README.md](../README.md)'s *"the cubic form `P(W) = ⟨W, Q(W)⟩`, restricted to `W` of norm 1, is maximized on the Weyl tensor of products of spheres when `n ≥ 12`"*, with `Pcubic` the record's `P` by §2 and the quantifier over the right set by §1. The `∃` shape rather than an `argmax` shape is the right reading of "is maximised on": it asserts the family attains at least the value of every competitor and says nothing about uniqueness, which the record does not claim either.

**One divergence, in the safe direction.** [README.md](../README.md) says *products* of spheres, which reads as any number of factors; `IsSphereProduct` is two blocks. The record's own target is two: [problem.md](../findings/problem.md) works throughout with `θ_max^sp(n) = max_{p+q=n} θ(S^p × S^q)`, and [conventions.md](../findings/conventions.md)'s `Θₙ` is that maximum. So `ProblemPNamed` is the record's statement, and is a strengthening of the README sentence read loosely, provable-implies-README, never the reverse. Worth a word in [README.md](../README.md) rather than a change in Lean.

## The object that would falsify the layer, and how I looked for it

**The falsifier is an `R : Matrix ι ι ℝ → Matrix ι ι ℝ` satisfying all four clauses of `IsWeyl` whose restriction to bivectors is not an algebraic Weyl operator**, equivalently, a point at which `Pcubic` is unbounded on `{IsWeyl R, normSq R = 1}`, which is what made `ProblemP` a false proposition before the skew-preservation clause went in.

**I looked for it in two places and it is not there.** First, among maps nonlinear on bivectors: the natural candidates are `R X = g(‖X‖) X` and its relatives, and all of them die at the same step, self-adjointness on skew arguments makes `X ↦ inner2 (R X) Y` a linear functional for each skew `Y`, so the failure of additivity is a skew matrix orthogonal to every skew matrix. That argument is §1 and it closes the whole class, not just the candidates. Second, among maps escaping through the arguments `IsWeyl` does not constrain: I enumerated every application of `R` in the layer's definitions and each one is at a skew matrix, so a wild extension off the skew subspace changes no computed quantity. **Establishing there is none is the outcome, and it is the stronger of the two answers the brief allowed.**

**The falsifier that does exist is not an operator but a constant.** For every real `c`, the layer obtained by replacing `sharpQF`'s `-(1/4)` with `-c` proves exactly the same theorems, because every `#`-touching declaration is a degree count (`sharpQF_neg`, `sharpQF_smul`, `sharpBil_smul`, `sharpOp_smul`, `Qop_smul`), a vanishing at zero (`Pcubic_zero`, `Qop_zero`), a definitional identity (`Pcubic_eq_inner_Qop`, `Pcubic_eq`), or a consequence of those (`foxProd_self`, `foxTri_self`, `foxProd_split`, `foxProd_idemOf_self`), and every statement whose truth would move with `c` is carried as an unproved hypothesis (`Pcubic WCP2 = 18`, `DiagCubicFormula`, `SphereProductValue`, `L74Bridge`, `DiagCriticalityIsCritical`). **That family of impostor layers is what `id# = (n-2)·id` exists to kill, it is the record's reason for mandating the check on any `#` formula, and §2 shows the real layer can carry it.** The layer is right at `c = 1/4`; what it lacks is the sentence that says so.

## Method and standing rule

Analysis only, and no computation was opened. The single screen is the one described in §2, the Lean definitions transcribed and evaluated on objects built for that purpose, seconds of compute, used to guard the derivations against a slip and cited as evidence for nothing. Running Lean itself was available (the build tree is present) and was not used: the two propositions worth checking there (`sharpOp_id` and `Pcubic WCP2 = 18`), are corrections to propose rather than claims to record, and stating them is a cycle's work rather than a reviewer's.
