# Reviewer 1004: four claims about the two-layer bridge and the layer's own `𝒲ₙ`

*Cold brief: [BRIEF-g2-bridge-round2.md](BRIEF-g2-bridge-round2.md), no prior report read, no author's conclusion supplied. **No numerical work was done.** Every value below is exact and derived by hand. The machine steps are `lake env lean` on three scratch files written for this round and then deleted, carrying `#print axioms` on the ten declarations under review, two instance-synthesis probes and three small theorems: each reports what the kernel holds or what the elaborator can find rather than computing a value, and the three files cost under two minutes in total. Log: [agent_logs/r1004.log](../agent_logs/r1004.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | [Rphi_swap](../lean/HamiltonsCubic/Results/TensorBridge.lean#L47), that `IsWeyl` alone gives `R φ_ba = -R φ_ab` | **CONFIRMED**, every step, and **it needs clauses ONE AND TWO**, never the second alone |
| 2 | [normM2_toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L136), the bridge is an isometry with no factor | **CONFIRMED** independently of the file's route, and **it does NOT survive rescaling the pairing**: both sides move, the tensor side as the square |
| 3 | the bundled restatement says something the bare versions do not | **REFUTED**: five declarations, all five the same theorems retyped, and as `∀`-statements strictly weaker |
| 4 | [symOp](../lean/HamiltonsCubic/Results/WeylRadical.lean#L35), the radical claim and its two consequences | **CONFIRMED** clause by clause, both consequences correct, and `symOp` is in the RADICAL rather than merely null |
| 5 | the scope of item 4 across the record | **A DEFECT, at one place and not more**: every statement reading `R` on bivectors alone is untouched, and **every statement reading the TRACE or the DIMENSION of `weylModule` is about the wrong space** |
| 6 | what the four together do and do not give [I36](../plan.md) | **CONFIRMED that the conclusion side is ready**, and [plan.md:171](../plan.md#L171)'s *transport of local-maximality alone* **CORRECTED**: what is owed is an ambient space with a topology, and `weylModule` has none |

**Actionable summary.** No defect in any of the four theorems, and one defect in the record's account of what `weylModule` is. [WeylModule.lean:91](../lean/HamiltonsCubic/Base/WeylModule.lean#L91) is not `𝒲ₙ` but its pullback along restriction to `Λ²`, of dimension `dim 𝒲ₙ + n²·n(n+1)/2`, which is **170 against 10 at `n = 4`**, so [weylTrace_id](../lean/HamiltonsCubic/Base/WeylModule.lean#L170)'s docstring claim to be the hook by which `dim 𝒲ₙ` becomes a statement about `weylTrace` fails, and the three statements of [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) take the trace over that space and are therefore not L206's identities. Repair the two docstrings and restate the trace over the quotient by the radical, or over the endomorphisms of the skew subspace. Separately, correct [lean/INDEX.md:146](../lean/INDEX.md#L146)'s *the gap proved inert, nothing in the layer evaluates `R` off the skew subspace*, which [FoxClosed](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean#L42)'s `∀ Z : Matrix ι ι ℝ` contradicts, and [lean/INDEX.md:134](../lean/INDEX.md#L134)'s *`finiteDimensional_weylModule` confirms `𝒲ₙ` is finite-dimensional there*, which names the wrong module.

## 0. Conventions, fixed once

- `φ_ab = E_ba - E_ab`, which is [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) verbatim, so `(φ_ab)_cd = [c=b][d=a] - [c=a][d=b]`.
- `⟨X, Y⟩ = λ ∑_{a,b} X_ab Y_ab` with `λ = ½` in the record, which is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) verbatim. I keep `λ` a symbol in section 2 and nowhere else.
- `⟨R, S⟩_op = μ ∑_i ∑_j ⟨R φ_ij, S φ_ij⟩` with `μ = ½` in the record, which is [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135) verbatim. **The two halves are independent constants** and section 2 turns on that.
- `Λ²` is the skew subspace of `Matrix ι ι ℝ`, of dimension `n(n-1)/2`, and `Sym` its complement, of dimension `n(n+1)/2`. `{φ_ab}` spans `Λ²`.
- `𝒲ₙ` is the record's Weyl space, the endomorphisms of `Λ²` satisfying the four clauses, of dimension `n(n+1)(n+2)(n-3)/12`, which is `10` at `n = 4`.
- Indices are `0`-based, matching Lean. Sums over pairs are over ORDERED pairs unless a range says otherwise.

## Hypothesis inventory, as the declarations bind it

| declaration | binders | conclusion |
| --- | --- | --- |
| [Rphi_swap](../lean/HamiltonsCubic/Results/TensorBridge.lean#L47) | `IsWeyl R`, `R` a bare function on `Fin n` | `R (phi b a) = -R (phi a b)` at every `a`, `b` |
| [normM2_toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L136) | `IsWeyl R` | `normM2 (toTensor R) = normSq R` |
| [finiteDimensional_weylModule](../lean/HamiltonsCubic/Results/TensorBridge.lean#L179) | none | `FiniteDimensional ℝ (weylModule (Fin n))` |
| [isWeyl_toTensorL](../lean/HamiltonsCubic/Results/TensorBridge.lean#L186) | `IsWeylL R`, `R : CurvLin (Fin n)` | `L94Statement.IsWeyl (toTensorL R)` |
| [normM2_toTensorL](../lean/HamiltonsCubic/Results/TensorBridge.lean#L191) | `IsWeylL R` | `normM2 (toTensorL R) = normSq ↑R` |
| [isWeyl_toTensorL_mem](../lean/HamiltonsCubic/Results/TensorBridge.lean#L197) | `R ∈ weylModule (Fin n)` | `L94Statement.IsWeyl (toTensorL R)` |
| [symOp_mem](../lean/HamiltonsCubic/Results/WeylRadical.lean#L48) | `[Fintype ι]`, `[DecidableEq ι]` | `symOp ι ∈ weylModule ι` |
| [symOp_normSq](../lean/HamiltonsCubic/Results/WeylRadical.lean#L69) | the same | `normSq ↑(symOp ι) = 0` |
| [symOp_ne_zero](../lean/HamiltonsCubic/Results/WeylRadical.lean#L79) | the same plus `[Nonempty ι]` | `symOp ι ≠ 0` |

**Kernel status, read rather than assumed.** `#print axioms` returns `[propext, Classical.choice, Quot.sound]` on all ten declarations above and on the three theorems I wrote for this round. No `sorry` and no `native_decide` on the chain, so the round is about the objects and not the manipulations, as the brief directs.

## 1. `Rphi_swap`: every step holds, and it needs both of the first two clauses

**Step by step, against [WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)'s four clauses.**

1. `Z := R φ_ba + R φ_ab` is skew. Clause 1 applied twice at the skew arguments `φ_ba` and `φ_ab` gives `(R φ_ba)ᵀ = -R φ_ba` and `(R φ_ab)ᵀ = -R φ_ab`, and transposition is additive, so `Zᵀ = -Z`. **This step is clause 1 and nothing else.**
2. `⟨Z, Z⟩ = ⟨R φ_ba, Z⟩ + ⟨R φ_ab, Z⟩`, by additivity of the pairing in one slot and its symmetry. Both are proved in the layer and both are unconditional.
3. Each term is turned round by clause 2, which is quantified over a SKEW first argument and a SKEW second argument. `φ_ba` and `φ_ab` supply the first, and **step 1 is what supplies the second**. So the sum becomes `⟨φ_ba, R Z⟩ + ⟨φ_ab, R Z⟩ = ⟨φ_ba + φ_ab, R Z⟩ = ⟨0, R Z⟩ = 0`, the last equality by `phi_swap`.
4. `⟨Z, Z⟩ = ½ ∑_p ∑_q (Z_pq)²` over `ℝ`, so `⟨Z, Z⟩ = 0` forces every entry to vanish. **This step needs nothing about `Z` at all**, since the pairing of any real matrix with itself is a sum of squares, and in particular it does not need `Z` skew.
5. `R φ_ba + R φ_ab = 0` rearranges to the conclusion.

**The answer the brief asks for.** The conclusion needs **clause 1 and clause 2 together**, and clause 2 alone will not do it: clause 2 says nothing whatever unless both of its arguments are known skew, and the only route to `Z` skew is clause 1. The sum-of-squares step is where one might expect skewness to be used and is exactly where it is not.

**The file's own prose is right and the file header's is right in a way that invites misreading.** [TensorBridge.lean:44](../lean/HamiltonsCubic/Results/TensorBridge.lean#L44) says *`Z` is skew by the first clause*, which is the correct attribution. [TensorBridge.lean:23](../lean/HamiltonsCubic/Results/TensorBridge.lean#L23)'s *`RealLayer.IsWeyl` supplies the whole of it on its own* is a claim about `IsWeyl` as a conjunction and is correct as such. Clauses 3 and 4 are consumed nowhere in this proof.

**Argued the opposite.** Could the conclusion follow from clause 2 alone, by a route the file does not take? No, and the reason is a counting one rather than a search: clause 2 constrains `R` only through the numbers `⟨R X, Y⟩` at skew `X` and skew `Y`, which is the matrix of the composite `π ∘ R|_{Λ²}` for `π` the orthogonal projection onto `Λ²`. Any `R` whose values on `Λ²` are altered by an arbitrary `Sym`-valued map leaves all of those numbers fixed, and `R φ_ba = -R φ_ab` is a statement about the values themselves. Clause 1 is what rules that freedom out. **This is the same defect [WeylReal.lean:116](../lean/HamiltonsCubic/Base/WeylReal.lean#L116) records clause 1 as having been added to repair**, and the present theorem is a second place where clause 1 is load-bearing.

**Scope note, offered rather than found.** The theorem is stated at `Fin n` while [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) is general in `ι`. Nothing in the proof uses `Fin`, so the restriction is the bridge's ambient type rather than a hypothesis, and it costs nothing here.

**Verdict: CONFIRMED, with the attribution corrected to clauses one and two.**

## 2. `normM2_toTensor`: the isometry holds, and it pins a coincidence of two constants rather than the value `½`

**The independent route, not the file's.** Write `T_abcd = ⟨R φ_ab, φ_cd⟩` and `S = ∑_{a,b} ∑_{c,d} ((R φ_ab)_cd)²`, a quantity carrying no normalisation at all.

- `⟨Y, φ_ij⟩ = λ (Y_ji - Y_ij) = -2λ Y_ij` at skew `Y`, which at `λ = ½` is [inner2_phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L67). Clause 1 of `IsWeyl` is what makes `R φ_ab` skew, so `T_abcd = -2λ (R φ_ab)_cd` and `full4 T = 4λ² S`.
- [normM2_quarter](../lean/HamiltonsCubic/Results/L94Statement.lean#L241) gives `4 normM2 T = full4 T` from the two antisymmetries, which hold: the first is [toTensor_antisym12](../lean/HamiltonsCubic/Results/TensorBridge.lean#L81) through section 1, the second is `phi_swap` alone. So `normM2 T = λ² S`.
- `normSq R = μ ∑_i ∑_j ⟨R φ_ij, R φ_ij⟩ = μ λ S`.

So the two sides are `λ² S` and `μ λ S`, and **the identity holds exactly when `λ = μ`**, which the record satisfies with `λ = μ = ½`. At `λ = μ = ½` both sides are `S/4` and the factor is `1`, which is the claim. The file's route through [sum_inner2_phi](../lean/HamiltonsCubic/Base/Families.lean#L127) and `normM2_quarter` reaches `full4 (toTensor R) = 4 normSq R` and then cancels the four, and it agrees with this one term for term.

**Would it survive rescaling `inner2`? No, and BOTH sides move.** Sending `λ ↦ cλ` with `μ` fixed multiplies the left side by `c²` and the right side by `c`, so the equality fails at every `c ≠ 1` unless `S = 0`. The tensor side moves as the square because the pairing enters `toTensor` once per component and the components are squared, and the operator side moves linearly because the pairing enters `normSq` once. **Which side moves is therefore the wrong question and I answer the one behind it**: the left side moves faster, and the ratio of the two is `λ/μ`.

**What this corrects.** [TensorBridge.lean:130](../lean/HamiltonsCubic/Results/TensorBridge.lean#L130) and [lean/INDEX.md:134](../lean/INDEX.md#L134) both call this *the only place the pairing's `½` decides truth rather than scale*. The consequence drawn is right, that without the identity L94's unit sphere and the record's are unrelated. The attribution is one step off: what the identity pins is that `inner2`'s constant EQUALS `innerOp`'s, and the common value `½` is free. Under plain Frobenius at both levels, `λ = μ = 1`, the isometry holds verbatim. **So the theorem tests the layer's consistency between its two pairings and does not test the record's `½` against a competitor.** Nothing downstream changes, since both constants are `½` on file and have been since [conventions.md](../findings/conventions.md) fixed them.

**Argued the opposite.** Could a reading be found on which `½` alone is what is tested? Only by treating `innerOp`'s `½` as the ordered-pair double count and therefore as not a normalisation choice. That reading is available and [WeylReal.lean:134](../lean/HamiltonsCubic/Base/WeylReal.lean#L134) invites it. It does not survive the arithmetic above, where the two constants enter with different powers and only their equality is read.

**Verdict: CONFIRMED, with the dependence on the normalisation stated exactly.**

## 3. The bundled restatement: five declarations, no new content

| declaration | what it is |
| --- | --- |
| [toTensorL](../lean/HamiltonsCubic/Results/TensorBridge.lean#L182) | `toTensor` at the coercion of a bundled map, a definition |
| [isWeyl_toTensorL](../lean/HamiltonsCubic/Results/TensorBridge.lean#L186) | the bare theorem applied at the coercion, the proof term being the bare name alone |
| [normM2_toTensorL](../lean/HamiltonsCubic/Results/TensorBridge.lean#L191) | the same, for the isometry |
| [isWeyl_toTensorL_mem](../lean/HamiltonsCubic/Results/TensorBridge.lean#L197) | the same again, with membership in place of the predicate |
| [finiteDimensional_weylModule](../lean/HamiltonsCubic/Results/TensorBridge.lean#L179) | `inferInstance`, which finds the instance already declared at [WeylModule.lean:141](../lean/HamiltonsCubic/Base/WeylModule.lean#L141) |

**Plainly: they are the same theorems retyped.** Three of the proofs are the bare theorem's name with no argument massaged, which is only accepted because `IsWeylL R` unfolds to `IsWeyl (fun X => R X)` by definition ([WeylModule.lean:75](../lean/HamiltonsCubic/Base/WeylModule.lean#L75)) and `R ∈ weylModule ι` unfolds to `IsWeylL R` by definition ([WeylModule.lean:92](../lean/HamiltonsCubic/Base/WeylModule.lean#L92)). The elaborator accepting them is itself the evidence, and it is the one thing the bare statements do not record: **the two spellings agree on the nose, with no coercion and no bridging step.** That is a fact about definitional unfolding and it is convenience.

**And as `∀`-statements the bundled forms are strictly weaker.** `CurvLin (Fin n)` embeds in the bare function type and does not exhaust it, so each bundled statement quantifies over fewer objects than the bare one it is proved from. [plan.md:171](../plan.md#L171) records the restatement as an advance, which it is for a consumer needing the bundled type, and it is a restriction of the quantifier rather than a strengthening of the claim. The fifth is weaker still: the instance at [WeylModule.lean:141](../lean/HamiltonsCubic/Base/WeylModule.lean#L141) is general in `ι` and this specialises it to `Fin n`.

**Argued the opposite.** Is there a consumer that could not use the bare theorems? A consumer holding `R : CurvLin (Fin n)` and `hR : R ∈ weylModule (Fin n)` can write `isWeyl_toTensor hR` directly, as the bundled proofs demonstrate by doing exactly that. So the answer is no.

**Verdict: REFUTED as a claim of content, CONFIRMED as five correct and convenient retypings.**

## 4. `symOp`: the radical claim, clause by clause

**The map.** [symOp](../lean/HamiltonsCubic/Results/WeylRadical.lean#L35) is `X ↦ X + Xᵀ`, bundled as a `CurvLin`. Additivity and homogeneity are entrywise and the file proves both. **Linear: yes.**

**Membership, clause by clause against [WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126).** The whole of it rests on `symOp X = 0` at skew `X`, since `Xᵀ = -X` there, and on `{φ_ij}` being skew.

1. *Bivectors to bivectors.* At skew `X` the value is `0`, and `0ᵀ = -0`. **Holds.**
2. *Self-adjointness.* The clause is quantified over skew `X` and skew `Y`, so both `symOp X` and `symOp Y` are `0`, and both sides are `⟨0, ·⟩ = 0`. **Holds.** Note that this clause is the one that would bite at a non-skew argument, and it is never asked at one.
3. *Bianchi.* All three terms read `symOp` at a `φ`, hence at `0`. **Holds.**
4. *Ricci.* Every summand reads `symOp` at a `φ`. **Holds.**

**Nonzero.** At any nonempty index type, `symOp (E_aa) = 2 E_aa`, whose `(a,a)` entry is `2`. **Holds**, and the `Nonempty` binder is necessary rather than decorative, `CurvLin` on an empty index type being the zero module.

**Norm zero.** `normSq` reads `symOp` at the `φ` only, so every summand is `0`. **Holds.** I screened a strictly stronger statement in the kernel and it goes through unchanged: `innerOp (symOp ι) S = 0` for EVERY `S`, so **`symOp` lies in the radical of the form and is not merely a null vector of it.**

**The first consequence is correct.** `innerOp` is symmetric and bilinear on `weylModule` and is positive semidefinite there, since clause 1 makes each `R φ_ij` skew and `⟨Y, Y⟩` is a sum of squares. It has a nonzero radical, so it is a semi-inner product and no inner-product-space or normed-space instance comes from it. **Its kernel is exactly the operators vanishing on `Λ²`**: if `⟨R, R⟩_op = 0` then every `⟨R φ_ij, R φ_ij⟩` vanishes, so every `R φ_ij` does, so `R` vanishes on the span of the `φ`, which is `Λ²`. That identification is what turns the observation into the dimension count of section 5 and it is not on file.

**The second consequence is correct.** [theta](../lean/HamiltonsCubic/Base/WeylReal.lean#L180) is `Pcubic R / norm R ^ 3`, and `norm (symOp ι) = √0 = 0`, so the denominator vanishes on the whole line `ℝ·symOp`. Lean returns `0` rather than erroring, and `Pcubic (symOp ι) = 0` as well, every evaluation in `trCube` and `sharpPair` reading the operator at a `φ` or at a bracket of skew matrices. So `theta` is `0/0` there, a junk value, and *divides by zero* is the right description.

**The third consequence is right and its wording overshoots.** `symOp` restricted to `Λ²` IS a curvature operator, namely the zero one. What is true, and sharper, is that **`symOp` is not in the image of the canonical section** `𝒲ₙ → weylModule` that extends an operator on `Λ²` by zero, so `weylModule` is not `𝒲ₙ` and carries no map back to it other than restriction. The bridge measures exactly this: I screened `toTensorL (symOp (Fin n)) = 0` in the kernel, so the radical is precisely the kernel of `toTensorL` on `weylModule`, and [normM2_toTensorL](../lean/HamiltonsCubic/Results/TensorBridge.lean#L191) is the statement that the induced map on the quotient is an isometry onto its image.

**Verdict: CONFIRMED, all four properties and both named consequences, with the third bullet's wording sharpened.**

## 5. The scope: a defect, at one place, and nowhere else

**The structure first, since it decides every row below.** Restriction to `Λ²` is a linear surjection `ρ : weylModule ι → 𝒲ₙ`. It is surjective because extension by zero on `Sym` satisfies all four clauses, and its kernel is the radical of section 4, which is `Hom(Sym, Matrix ι ι ℝ)` with no constraint whatever, every clause reading `R` at skew arguments alone. Hence

> `dim weylModule = dim 𝒲ₙ + n² · n(n+1)/2`.

**At `n = 4` that is `10 + 16·10 = 170`**, against `dim 𝒲₄ = 4·5·6·1/12 = 10`. At `n = 6` it is `84 + 36·21 = 840` against `84`. The two numbers are not close and do not become close.

**Where the radical is INERT, and this is most of the record.** Any statement reading `R` on bivectors alone cannot see it, `R` and `R + symOp` agreeing on every skew matrix. I screened `normSq (fun X => R X + (X + Xᵀ)) = normSq R` in the kernel at every `R`, and the same argument covers `Pcubic` and `theta`, since every evaluation inside [sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean#L102) is at a `φ` or at a bracket of skew matrices, and the bracket of two skew matrices is skew. So:

- [ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean#L201) quantifies over bare functions satisfying `IsWeyl`, a far larger class than `𝒲ₙ`, and **is unharmed**: `ρ` is onto, `Pcubic` and `normSq` factor through it, so the proposition over the large class is equivalent to the proposition over `𝒲ₙ`.
- [isWeyl_toTensorL_mem](../lean/HamiltonsCubic/Results/TensorBridge.lean#L197) quantifies over `weylModule` and **is unharmed**, the radical mapping to the zero tensor, for which the conclusion holds.
- Every numbered result in [findings/](../findings/) is prose about the record's `𝒲ₙ` and **is untouched**, the module being a Lean artefact and not their subject.

**Where it BITES, and it is the trace.** [weylTrace](../lean/HamiltonsCubic/Base/WeylModule.lean#L147) is `LinearMap.trace` over `weylModule`, which the count above shows is the wrong space by a factor of `17` at `n = 4`.

1. **[weylTrace_id](../lean/HamiltonsCubic/Base/WeylModule.lean#L170) is TRUE and its docstring's use of it fails.** The theorem reads `weylTrace id = finrank ℝ (weylModule ι)`, which is correct. Its docstring calls it *the hook by which `dim 𝒲ₙ` becomes a statement about `weylTrace`*, and the number on the right is `170` at `n = 4` where `dim 𝒲₄ = 10`. **The record's dimension formula `n(n+1)(n+2)(n-3)/12` can never be reached through this theorem**, and [WeylModule.lean:37](../lean/HamiltonsCubic/Base/WeylModule.lean#L37)'s account of that formula as needing only an explicit basis is therefore incomplete: it needs the quotient as well.
2. **The three statements of [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) are not L206's identities.** The radical is invariant under `L e`, the Fox product of `e` with an operator vanishing on `Λ²` vanishing on `Λ²` again, so `weylTrace L = tr(L on the radical) + tr(L on the quotient)`, and only the second summand is the record's `tr(L e)`. The first is not zero for any reason on file and is not even a function of `e|_{Λ²}`, since `e`'s own action on `Sym` is unconstrained by `e ∈ weylModule` and enters it. The sharpest instance is `e := symOp`, a kernel-checked member of `weylModule` for which the record's identity is the empty `0 = 0` while the Lean statement asserts the vanishing of a trace over a `170`-dimensional space. **All three carry a `sorry`, so this is a defect in the statement and not in a proof**, which is what the brief asks about.
3. **[lean/INDEX.md:146](../lean/INDEX.md#L146) states the opposite of the fact**, that *the gap is proved inert, the discarded freedom living only off the skew subspace, where nothing in the layer evaluates `R`*. [FoxClosed](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean#L42) evaluates it there, its `∀ Z : Matrix ι ι ℝ` reading `Qop` and hence `R (R Z)` at arbitrary `Z`, and so do the two trace statements through their `hL` binders. The first half of that sentence, that clauses 1 and 2 force additivity and homogeneity on bivectors, is right and is not what fails.
4. **[lean/INDEX.md:134](../lean/INDEX.md#L134) and [plan.md:171](../plan.md#L171) name the wrong module**, saying `finiteDimensional_weylModule` *confirms `𝒲ₙ` is finite-dimensional there*. It confirms `weylModule` is, and `weylModule` is `170`-dimensional at `n = 4`.
5. **A trap worth naming.** [weylTrace_id](../lean/HamiltonsCubic/Base/WeylModule.lean#L170)'s docstring records that a nonzero witness for the module is owed, the only member exhibited in the layer being `0`. [symOp_ne_zero](../lean/HamiltonsCubic/Results/WeylRadical.lean#L79) is now such a witness and **discharges nothing**: it is in the radical, so it is consistent with `dim 𝒲ₙ = 0`, which is the vacuity the docstring is about. The witness the record needs is a nonzero element of the IMAGE of `ρ`, and [r1002](REVIEW_r1002.md)'s kernel-checked `W_abcd = λ_ab(δ_ac δ_bd - δ_ad δ_bc)` at `n = 4` is one.

**Argued the opposite, and one discrepancy WITHDRAWN.** I first read [FoxClosed](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean#L42) as strictly stronger than the citation it stands in for, on the ground that it demands a witness agreeing with the Fox product at non-skew `Z` where Fox's Lemma 5.7 says nothing. That is wrong and I withdraw it. For bundled `X` and `Y`, the Fox product is linear in `Z`, both halves being polarisations of expressions quadratic in their arguments, so it bundles as a `CurvLin`. Whether that bundle lies in `weylModule` is decided on `Λ²` alone, where it is the genuine Fox product of the restrictions and where the citation applies. **So `FoxClosed` follows from Fox's lemma, and the file's account of it as a hypothesis standing in for a citation survives.** The damage is confined to the trace.

**Verdict: the finding is a DEFECT, and a narrow one.** It is inert on every statement that reads a curvature operator as a curvature operator, and it invalidates the intended reading of every statement that reads the trace or the dimension of the module. The repair is to quotient by the radical, or to state the module as the endomorphisms of the skew subspace, which also supplies section 6's missing instance.

## 6. What the four give [I36](../plan.md), and what remains

**What is delivered, and it is the conclusion side in full.** [I36](../plan.md#L142)'s shape claim concludes that a maximiser is coordinate-diagonal. `CoordinateDiagonal (toTensorL R)` is writable today: section 2 makes `normM2 (toTensorL R) = normSq R`, so the record's unit sphere and L94's are ONE sphere and not two, and [isWeyl_toTensorL](../lean/HamiltonsCubic/Results/TensorBridge.lean#L186) puts the tensor in the class L94's `kappaSq_eq_two_iff` is stated over. **Nothing further is owed on the conclusion side.**

**What remains, and it is the hypothesis side.** `IsLocalMaxOn` needs a topology on the ambient type. Two facts, both read from the elaborator rather than assumed:

- **`TopologicalSpace (CurvLin (Fin 4))` fails to synthesize, and so does `TopologicalSpace ↥(weylModule (Fin 4))`.** Mathlib puts no topology on `M →ₗ[ℝ] N`. **So `IsLocalMaxOn` does not elaborate over the bundled type at all today**, and [finiteDimensional_weylModule](../lean/HamiltonsCubic/Results/TensorBridge.lean#L179) does not supply one: finite-dimensionality is not a topology, and the usual route from it, a norm, is exactly what section 4 shows `innerOp` cannot give.
- **The bare function type does carry one**, the product topology, under which `IsLocalMaxOn` elaborates and is a strictly stronger hypothesis than the record's, so a theorem carrying it is weaker than it reads. That is [TensorBridge.lean:159](../lean/HamiltonsCubic/Results/TensorBridge.lean#L159)'s own diagnosis and it is right.

**So the statement can be written today only in the weaker form**, over bare functions, and the four claims move it no closer to the record's form. **What stands between I36's shape claim and a faithful Lean statement is therefore three things, in this order.**

1. **An ambient space with a `NormedAddCommGroup` or `InnerProductSpace` instance on which `𝒲ₙ` sits.** The endomorphisms of the skew subspace, `{X // IsSkew X} →ₗ[ℝ] {X // IsSkew X}`, are the natural one: `innerOp` is definite there by section 4's kernel identification, the space is finite-dimensional, and the unit sphere is compact, which the sphere in `weylModule` is not, being a cylinder along the radical. [TensorBridge.lean:171](../lean/HamiltonsCubic/Results/TensorBridge.lean#L171) calls this *a larger change and not owed here*, and it is what is owed next.
2. **`theta` certified as the record's `θ`.** [WeylReal.lean:263](../lean/HamiltonsCubic/Base/WeylReal.lean#L263) records the debt in its own words: that `sharpOp R X` is `R# X` needs `sharpBil R X` linear in its second slot, hence `R` linear, and **the record's only anchor on any `#` formula, `id# = (n-2) id`, is absent from this layer**, discharged at `n = 4` by `native_decide` in another file and at general `n` nowhere. Bundling into `CurvLin` supplies the linearity half and leaves the anchor. A shape claim about the maximisers of an uncertified `θ` is a different theorem.
3. **The threshold and the quantifier**, which are cheap once 1 and 2 are in place: `√(3/2)` as a `Real.sqrt` and the sphere as a `Set`.

**The plan's own account is one step off and I correct it.** [plan.md:171](../plan.md#L171) records *STILL OWED: the transport of local-maximality alone*. A transport is not needed, because the hypothesis can live on the operator side and the conclusion on the tensor side, which is what item 1 above and section 4 of this report together make possible. **What is owed is an ambient space**, and the reason it is owed is the radical, which is why this round's fourth claim is on the critical path and not beside it.

**Verdict: CONFIRMED on what the four deliver, and [plan.md:171](../plan.md#L171)'s statement of what remains CORRECTED.**

## Overall verdict

**PROVEN (hypotheses corrected).** All ten declarations under review hold on the standard three axioms, and I reproduced the two substantive ones by routes the files do not take. Three corrections to the surrounding account, none of which touches a proof: the antisymmetry theorem needs clauses one and two rather than the second alone, the isometry pins the equality of two constants rather than the value `½`, and the bundled restatement is five retypings. **One defect**, in the record's identification of [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean#L91) with `𝒲ₙ`, which is wrong by `n²·n(n+1)/2` dimensions and which invalidates the intended reading of [weylTrace_id](../lean/HamiltonsCubic/Base/WeylModule.lean#L170) and the three statements of [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean). Every statement that reads a curvature operator on bivectors alone, [ProblemP](../lean/HamiltonsCubic/Base/WeylReal.lean#L201) included, is untouched.
