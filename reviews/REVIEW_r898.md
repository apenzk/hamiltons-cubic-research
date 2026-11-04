# REVIEW r898 on I82: the submodule is the record's $\mathcal W_n$ in the sense the record's own predicate fixes, and "needed no basis" is a claim about convenience

**Cold brief.** This round compared a machine-checked Lean file against the claims made of it in commit `104ed201`, so it is one reviewer rather than the usual panel. I read [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean) in full, [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) in full including the falsifier warning on `IsWeyl`, the `IsLinOp` and `IsWeylOp` block of [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), the consuming file [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean), rows 29, 100 and 101 of [lean/INDEX.md](../lean/INDEX.md), item I82 at [plan.md:177](../plan.md#L177), the $\mathcal W_n$ rows of [findings/conventions.md](../findings/conventions.md), and the Mathlib sources behind the three imported facts. I ran `lake build HamiltonsCubic.Base.WeylModule` (clean, 8709 jobs, style-linter warnings only) and five probe files in the session scratchpad, each elaborated against this toolchain with the project's own `maxSynthPendingDepth=3`. **No numerical work of any kind was done**: every probe is an exact Lean elaboration on objects already in the layer, and the two claims I could not reach in Lean are argued by hand and labelled as such. Log: [agent_logs/review-r898-weylmodule.log](../agent_logs/review-r898-weylmodule.log). **Provenance of this file in the history**: a concurrent session's commit `1ff0ba23` picked it up from the index one second before r898's own commit, so the content landed under r896's message and this line is the commit that records the verdict.

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 2 | `weylModule` is the record's $\mathcal W_n$ | **SOUND IN THE DIRECTION THAT MATTERS, AND NARROWER THAN THE LAYER'S OWN `IsWeyl` SET.** Membership gives the record's `IsWeylOp` and every `IsWeylOp` bundles back into the module, both machine-checked. Against bare `IsWeyl` the inclusion is strict: `Rbad X = if X = single 0 0 1 then single 0 0 1 else 0` is `IsWeyl` and is not additive, machine-checked at $n=5$. **The gap is inert, and provably so: clauses 1 and 2 force additivity and homogeneity ON BIVECTORS**, machine-checked, so the lost freedom is only the values off the skew subspace, where no quantity of the layer evaluates $R$ |
| 3 | All four of `IsWeyl`'s clauses are linear in $R$ | **CONFIRMED, each clause an intersection of kernels of linear functionals of $R$**, the `add_mem'` and `smul_mem'` proofs discharge exactly those goals, and the four cited pairing lemmas say what the proofs use them for |
| 4 | A trace needs finite-dimensionality and freeness, both from Mathlib, and not one basis element is written down | **TRUE AS WRITTEN AND TOO STRONG AS READ.** No basis element is constructed and both instances are Mathlib's. Freeness over $\mathbb R$ IS the existence of a basis (`Module.Free.of_divisionRing` is `Module.Free.of_basis (ofVectorSpace ℝ V)`), and `LinearMap.trace` is defined by choosing a `Finset`-indexed basis, so the content dispensed with is an EXPLICIT basis, not a basis. **Separate finding: at the project's own build options neither `haveI` in `weylTrace_id` is needed**, so the comment at lines 40 to 42 does not hold for this file as built |
| 5 | `CurvOp` is infinite-dimensional over $\mathbb R$, so no trace can exist on it however much is proved about $\mathcal W_n$ | **CONFIRMED for nonempty $\iota$, with one correction and one overstatement.** The reason needs the codomain nonzero as well as the domain infinite, and at empty $\iota$ the type is a single point and is $0$-dimensional. `LinearMap.trace ℝ (CurvOp ι)` type-checks and is Mathlib's `else 0` branch, so the obstruction is that the only available trace is the zero functional, which forces $\kappa\langle e,f\rangle=0$. **"Bundling into the arrow is the whole step" overstates uniqueness**: a trace exists on $\mathcal W_n$ as a submodule of the BARE function space, machine-checked as `Submodule.map coeL (weylModule ι)` with `trace_id` holding on it. What is load-bearing is imposing linearity at all |
| 6 | The file leaves out the two trace identities and the dimension formula | **INCOMPLETE, five further module claims of the record go untouched**, chief among them that no nonzero element of `weylModule` exists anywhere in the layer, so `weylTrace_id` is compatible with $\dim\mathcal W_n=0$ and the row's "so nothing is vacuous" is not carried by it |

**One-line summary the cycle can act on.** The file is correct, gap-free and does support the commit's substance, and three cheap additions would close the distance between the file and the prose: the two-line bridge `R ∈ weylModule ι ↔ IsWeylOp ⇑R` to the record's own predicate, a nonzero witness (or a `finrank > 0` statement) so that non-vacuity is a theorem rather than a reading of `weylTrace_id`, and a rewording of "needed no basis" to "needed no EXPLICIT basis".

## Axiom report

Every declaration of the file, including the anonymous `FiniteDimensional` instance and the three auxiliary proofs `weylModule._proof_1` to `_proof_3` that the structure instance generates, depends on exactly `[propext, Classical.choice, Quot.sound]`. **No `sorryAx`, and `grep -c sorry` over the file returns $0$.** The twelve named declarations are `inner2_smul_right'`, `inner2_zero_left'`, `inner2_zero_right'`, `CurvLin`, `IsWeylL`, `isWeylL_zero`, `weylModule`, `weylTrace`, `weylTrace_add`, `weylTrace_smul`, `weylTrace_zero` and `weylTrace_id`, and the instance is `instFiniteDimensionalRealSubtypeCurvLinMemSubmoduleWeylModule`. `Classical.choice` is not incidental here: it is where the basis comes from, through `Module.Free.of_divisionRing` and through `LinearMap.trace`'s own `dif` on the existence of a finite basis, which is why `weylTrace` is `noncomputable`.

## 1. The build

`lake build HamiltonsCubic.Base.WeylModule` completes successfully, 8709 jobs. The warnings are all style linters and none touches a proof: `unusedSectionVars` and `unusedDecidableInType` on the three `inner2` helpers, which do not use `[DecidableEq ι]`, and `linter.style.show` on lines 76 and 78, where `show` changes the goal and Mathlib's linter asks for `change`. The file suppresses two linters of its own, `longLine` and `haveILetI`, and section 4 below finds the second suppression unnecessary.

## 2. Is `weylModule` the record's $\mathcal W_n$?

The answer has three parts, and the first two are machine-checked.

**Forward, and exactly.** `IsWeylL R` is `IsWeyl (fun X => R X)`, so membership hands you the record's predicate on the underlying bare function with nothing to prove: `example (R : CurvLin ι) (hR : R ∈ weylModule ι) : IsWeyl (fun X => R X) := hR` elaborates. Adding the linearity that the arrow carries gives the record's own predicate for $\mathcal W_n$, which [FoxProduct.lean:101](../lean/HamiltonsCubic/Base/FoxProduct.lean#L101) defines as `IsWeylOp := IsLinOp ∧ IsWeyl` and documents in exactly those words, *"the record's $\mathcal W_n$: a linear operator meeting WeylReal's three curvature conditions"*. I proved both directions of that bridge:

```lean
theorem mem_weylModule_isWeylOp (R : CurvLin ι) (hR : R ∈ weylModule ι) :
    IsWeylOp (fun X => R X) := ⟨⟨fun X Y => by simp, fun c X => by simp⟩, hR⟩

theorem isWeylOp_bundles (R : CurvOp ι) (hR : IsWeylOp R) :
    ∃ L : CurvLin ι, L ∈ weylModule ι ∧ (fun X => L X) = R := by
  refine ⟨{ toFun := R, map_add' := hR.1.1, map_smul' := fun c X => hR.1.2 c X }, ?_, rfl⟩
  exact hR.2
```

Both carry the three standard axioms. **So against the record's own Lean predicate for $\mathcal W_n$ the identification is exact, in both directions, and it is three lines the file does not contain.** [conventions.md:13](../findings/conventions.md) reads $\mathcal W_n$ as "the space of algebraic Weyl curvature OPERATORS", which is the same reading.

**Backward against bare `IsWeyl`, the inclusion is strict.** A non-linear Weyl tensor in the layer's sense exists, and I built one at $n=5$ rather than arguing about it. With `Ssym = Matrix.single 0 0 1`, which no skew matrix equals because a skew matrix has zero diagonal, and `Rbad X = if X = Ssym then Ssym else 0`, every clause of `IsWeyl` evaluates $R$ only at skew arguments (`bianchi` and `Ric` only at `phi`, which `phi_isSkew` gives), so `Rbad` vanishes wherever the clauses look and `IsWeyl Rbad` is proved. And `Rbad (Ssym + Ssym) = 0` while `Rbad Ssym + Rbad Ssym = 2 • Ssym`, so `¬ ∀ X Y, Rbad (X + Y) = Rbad X + Rbad Y` is proved, hence `¬ ∃ R : CurvLin J, R ∈ weylModule J ∧ (fun X => R X) = Rbad`, also proved. **Linearity is therefore NOT forced on the whole matrix space, and the second direction of the brief's question fails as stated.**

**The gap is inert, and that is a theorem rather than a hope.** Clauses 1 and 2 force linearity on the skew subspace, which is where $\Lambda^2$ actually lives. I proved both halves:

```lean
theorem isWeyl_add_on_skew (R : CurvOp ι)
    (h1 : ∀ X, IsSkew X → IsSkew (R X))
    (h2 : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) : R (X + Y) = R X + R Y
```

with the homogeneous twin `isWeyl_smul_on_skew`, both gap-free. The argument is the layer's own `inner2_phi`: for skew $Y$, $\langle Y,\varphi_{ij}\rangle=-Y_{ij}$, so two skew matrices pairing alike against every $\varphi_{ij}$ are equal, and clause 2 turns $\langle R(X+Y),\varphi\rangle$ into $\langle X+Y,R\varphi\rangle$, which is additive because $\langle\cdot,\cdot\rangle$ is. Clause 1 supplies the skewness both sides need. **So every record-sense Weyl tensor restricts to a linear operator on bivectors, and the whole of the freedom `weylModule` discards sits off the skew subspace.** Nothing in the layer looks there: `normSq`, `innerOp`, `trCube`, `sharpQF`, `sharpBil`, `sharpOp`, `Pcubic` and `theta` evaluate $R$ at `phi` and at `br η Z` for skew $\eta$ and $Z$, and the bracket of two skew matrices is skew. As a check on that reading, `Rbad` has `normSq Rbad = 0`, so it never enters `ProblemP`'s range in the first place.

This is the opposite failure mode from the one [WeylReal.lean:116](../lean/HamiltonsCubic/Base/WeylReal.lean#L116) warns about. That warning is about a quantifier that was too WIDE, a symmetric-valued operator invisible to three clauses while `normSq` and `Pcubic` saw it in full, and the repair was adding clause 1. Here the move is a NARROWING, and clause 1 is what makes the narrowing harmless: it is the clause that forces $R$'s image back into the skew subspace, so restricting attention to bivectors loses no information the quantities use. **The one thing the record still owes across this join is a bridge theorem, because `ProblemP` quantifies over bare functions and no theorem relates its range to `weylModule`.** Downstream, [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) crosses the same join by hand each time, writing `fun A => X A` at every call of `foxProd`.

## 3. Are all four clauses really linear in $R$?

**Confirmed, clause by clause, and the proofs discharge exactly those goals.** The right frame is that each clause is an intersection over its quantified variables of kernels of linear functionals of $R$, and an intersection of kernels is a submodule.

| Clause | Why it is a linear condition in $R$ | What the file's proofs do |
|---|---|---|
| `∀ X, IsSkew X → IsSkew (R X)` | at fixed $X$, $R\mapsto(RX)^{\mathsf T}+RX$ is linear and the clause is its vanishing | `LinearMap.add_apply` then `Matrix.transpose_add` then the two hypotheses then `neg_add`. The `smul` half is `LinearMap.smul_apply`, `Matrix.transpose_smul`, `smul_neg` |
| `∀ X Y skew, inner2 (R X) Y = inner2 X (R Y)` | both sides are linear in $R$, so the clause is the vanishing of their difference, a kernel again | splits the first slot with `inner2_add_left` and the second with `inner2_add_right`, then rewrites by the two hypotheses and closes by reflexivity. The `smul` half pulls $c$ out of both slots with `inner2_smul_left` and `inner2_smul_right'` |
| `∀ i j k l, bianchi R i j k l = 0` | three terms $\langle R\varphi,\varphi\rangle$ at fixed indices, each linear in $R$ | `simp only [bianchi, LinearMap.add_apply, inner2_add_left]` then `linarith` on $(a_1+b_1)+(a_2+b_2)+(a_3+b_3)=0$ from $\sum a=0$ and $\sum b=0$. The `smul` half is `linear_combination c * hr` |
| `∀ a b, Ric R a b = 0` | a finite sum of terms linear in $R$, so a linear functional | `Finset.sum_add_distrib` then `linarith`. The `smul` half pulls $c$ out of the sum with `← Finset.mul_sum` and closes with `rw [hr, mul_zero]` |

The symmetry clause is the one the brief asks me to check rather than accept, and the file's phrasing is right for the reason above: an equation between two linear expressions cuts out a subspace. Note the quantifiers are part of it, and the docstring's "skew-to-skew is a linear condition" is a linear condition *at each skew $X$*, the clause being their intersection.

**The four cited pairing lemmas say what the proofs need.** `inner2_add_left` is [StructureConstants.lean:152](../lean/HamiltonsCubic/Base/StructureConstants.lean#L152), `inner2_smul_left` is [FoxProduct.lean:133](../lean/HamiltonsCubic/Base/FoxProduct.lean#L133), `inner2_add_right` is [WeylReal.lean:223](../lean/HamiltonsCubic/Base/WeylReal.lean#L223), and the right-slot scalar rule is the file's own `inner2_smul_right'` at line 52, primed because only the left version existed upstream. All are over $\mathbb R$ at the same `inner2`, so no scalar or convention is silently switched, and the `AltPart.lean` namesakes in `AltLayer` are not in scope here.

**No coercion weakens anything.** The only coercion in play is `⇑R`, and every step that touches it goes through `LinearMap.add_apply` or `LinearMap.smul_apply`, which are the coercion's defining simp lemmas rather than a `change` across a gap. `IsWeylL` is `IsWeyl ⇑R` by definition, so `refine ⟨?_, ?_, ?_, ?_⟩` against `IsWeylL (R + S)` unfolds a `def` and a `Set.mem_setOf`, with no re-statement of the predicate. The one numeric cast is `(Module.finrank ℝ (weylModule ι) : ℝ)` in `weylTrace_id`, which is the cast `LinearMap.trace_id` itself carries.

## 4. The "no basis needed" claim

**No basis element is constructed.** Confirmed by reading: the file names `phi` nowhere, builds no `Basis`, and `Finset` enters only through `Ric`'s sum. Both instances are Mathlib's, not the file's assertions: `FiniteDimensional.finiteDimensional_submodule` is [Defs.lean:132](../lean/.lake/packages/mathlib/Mathlib/LinearAlgebra/FiniteDimensional/Defs.lean#L132), applied to `FiniteDimensional ℝ (CurvLin ι)`, which Mathlib supplies for linear maps between finite-dimensional spaces, and `Module.Free.of_divisionRing` is [Basis/VectorSpace.lean:156](../lean/.lake/packages/mathlib/Mathlib/LinearAlgebra/Basis/VectorSpace.lean#L156). There is no `axiom` command and no `sorry`.

**And the claim is too strong as a claim about content.** Two facts settle it:

- `Module.Free.of_divisionRing` is literally `Module.Free.of_basis (ofVectorSpace K V)`, and `ofVectorSpace` is `Basis.extend (linearIndependent_empty K V)`. **Freeness over a field IS the existence of a basis**, obtained by choice.
- `LinearMap.trace` at [Trace.lean:75](../lean/.lake/packages/mathlib/Mathlib/LinearAlgebra/Trace.lean#L75) is `if H : ∃ s : Finset M, Nonempty (Basis s R M) then traceAux R H.choose_spec.some else 0`, and `traceAux R b` is `Matrix.trace (LinearMap.toMatrix b b f)`. **So `weylTrace` unfolds through a chosen finite basis of $\mathcal W_n$ and the matrix of the operator in it.** That is why it is `noncomputable` and why `Classical.choice` appears in its axiom list.

The honest statement is the record's blocker read with one word changed: what the trace needs is a basis to EXIST, not a basis to be WRITTEN DOWN, and existence is free over a field while writing one down is the work $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ still needs. **So "needed no basis" is about convenience, and the file's own hook sentence at line 160, "once a basis is built for the counting", already knows it.** The record would be exactly right with "needed no explicit basis".

**A separate finding on the same lines, and it goes the other way from what the commit suggests.** The file's comment at lines 40 to 42 says the `haveI`s are what supply the instances `LinearMap.trace_id` needs and that the `Submodule` coercion path does not resolve without them. At the project's own build options, which include `maxSynthPendingDepth = 3` from [lakefile.toml](../lean/lakefile.toml), the theorem needs neither:

```lean
example : weylTrace (LinearMap.id : weylModule ι →ₗ[ℝ] weylModule ι)
    = (Module.finrank ℝ (weylModule ι) : ℝ) := LinearMap.trace_id ℝ (weylModule ι)
```

elaborates under `-DmaxSynthPendingDepth=3` and fails at the default depth of $1$ with `failed to synthesize Module.Free ℝ ↥(weylModule ι)`. So both `haveI`s and the `haveILetI` linter suppression are removable in this file, and the naming of `Module.Free.of_divisionRing` is a synthesis-depth artefact rather than a mathematical input. **The mathematical input is unchanged either way: the instance that fires is the one whose proof is a chosen basis.**

## 5. The infinite-dimensionality claim

**Confirmed for nonempty $\iota$, by hand.** Fix $i_0\in\iota$ and put $E=$ `single i₀ i₀ 1`, which is nonzero. The domain $M=$ `Matrix ι ι ℝ` is infinite, since $t\mapsto t\cdot E$ is injective. For any $k$ pick distinct $X_1,\dots,X_k\in M$ and set $f_m(X)=E$ if $X=X_m$ and $0$ otherwise. These $k$ elements of `CurvOp ι` are $\mathbb R$-independent: evaluation at $X_p$ is $\mathbb R$-linear on the pointwise module structure and sends $\sum_m c_mf_m$ to $c_pE$, so $\sum_mc_mf_m=0$ forces every $c_p=0$. Hence `CurvOp ι` contains $k$ independent vectors for every $k$ and is not finite-dimensional. **Two corrections to how the file states it.** The docstring's reason, "since its domain is infinite", needs the codomain to be nonzero as well, which is the same hypothesis: at empty $\iota$ the matrix type is a single point, `CurvOp ι` is a single point, and it is $0$-dimensional, so the blanket claim is false at $n=0$. Since the claim lives in a docstring rather than in a theorem, this weakens the prose and not the file.

**"No trace can exist on it" is right in substance and needs restating in Lean's terms.** `LinearMap.trace ℝ (CurvOp ι)` type-checks, as I confirmed by elaborating it. By the definition in section 4 it takes the `else 0` branch whenever no `Finset`-indexed basis exists, which is exactly the case here, so the only trace Mathlib offers on `CurvOp ι` is the zero functional. That is the real obstruction, and it is vacuity rather than a type error: `weylTrace_id`'s analogue survives numerically, since `finrank` of an infinite-dimensional space is $0$ by `finrank_of_infinite_dimensional`, while the record's second identity $\mathop{\mathrm{tr}}(L_eL_f)=\kappa\langle e,f\rangle$ would force $\kappa\langle e,f\rangle=0$ and kill the very thing [L207](../findings/nondegeneracy.md) needs from it. **So "no trace can exist on it however much is proved about $\mathcal W_n$" holds, and the sharper reason is available**: the bare-function set the record's `IsWeyl` cuts out is ITSELF infinite-dimensional, by the same indicator family with the $X_m$ taken non-skew, since such functions satisfy all four clauses. The obstruction is therefore not merely that the ambient function space is big.

**"Bundling the linearity into the arrow is the step" overstates uniqueness.** A trace exists on $\mathcal W_n$ as a submodule of the bare function space, with no arrow in the carrier type. Machine-checked:

```lean
def coeL : CurvLin ι →ₗ[ℝ] CurvOp ι where
  toFun L := fun X => L X
  map_add' _ _ := by funext X; simp
  map_smul' _ _ := by funext X; simp

noncomputable def weylBare (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (CurvOp ι) :=
  Submodule.map coeL (weylModule ι)

noncomputable instance : FiniteDimensional ℝ (weylBare ι) :=
  Module.Finite.of_surjective (coeL.submoduleMap (weylModule ι))
    (coeL.submoduleMap_surjective (weylModule ι))

example : LinearMap.trace ℝ (weylBare ι) LinearMap.id
    = (Module.finrank ℝ (weylBare ι) : ℝ) := by
  haveI : Module.Free ℝ ↑↑(weylBare ι) := Module.Free.of_divisionRing ℝ ↑↑(weylBare ι)
  haveI : Module.Finite ℝ (weylBare ι) := inferInstance
  exact LinearMap.trace_id ℝ (weylBare ι)
```

`weylBare` is a submodule of `CurvOp ι`, every member satisfies `IsWeylOp`, and `trace_id` holds on it. The same is reachable without `weylModule` at all, by cutting `CurvOp ι` with `IsLinOp ∧ IsWeyl`, which is a submodule because `IsLinOp` is two more linear conditions on $R$. **What is load-bearing is that linearity is imposed as a defining condition of the module rather than carried as a side predicate on a $\forall$. Bundling into the arrow is the idiomatic way to do that, and it is not the only one.**

## 6. What the file does not state, against what its row says it does not state

The row names two omissions, the two trace identities and $\dim\mathcal W_n$, and both are correctly named. **The list is incomplete.** Five further claims the record makes about $\mathcal W_n$ as a module go untouched, in descending order of how much they matter to what the row asserts:

1. **That $\mathcal W_n$ is nonzero, and so that the trace is not vacuous.** The only member the layer ever exhibits is $0$, through `isWeylL_zero` here and `isWeylOp_zero` in FoxProduct. The nearest thing to a nonzero witness is `indDir_isWeylOp` at [L99Statement.lean:473](../lean/HamiltonsCubic/Results/L99Statement.lean#L473), which is conditional on `IsWeight` and `SplitsAlong` and is not shown nonzero. **So `weylTrace_id` is consistent with `weylModule ι = ⊥`, where it reads $0=0$**, and the row's "`weylTrace_id` the dimension so nothing is vacuous" claims more than the theorem carries. The file's own line 159 says it outright, "the trace is not the zero functional", and that needs $\mathop{\mathrm{finrank}}>0$, which nothing supplies.
2. **That $Q$ sends $\mathcal W_n$ to itself**, [conventions.md:15](../findings/conventions.md). The file states no closure property, and row I82b records the same debt from the other side as `FoxClosed`, carried as a hypothesis.
3. **That the record's pairing, norm, $P$ and $\theta$ restrict to this module.** `innerOp`, `normSq`, `Pcubic` and `theta` are never transported onto `weylModule`, so the unit sphere of $\mathcal W_n$, which is what $M(n)$ and `ProblemP` are about, is not typed here, and `ProblemP` still quantifies over bare functions with no bridge to the module.
4. **That $\mathcal W_n$ carries the $O(n)$ action and is irreducible for $n\ge5$**, with Casimir $4(n-1)$, which [ATTEMPTS.md](../ATTEMPTS.md) uses. No group action on `weylModule` appears.
5. **That $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric on $\mathcal W_n$, hence $L_e$ self-adjoint**, [conventions.md:24](../findings/conventions.md), which is what makes [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined. The trace built here is the other half of that apparatus and the self-adjointness half is not stated.

## 7. What would break it

**The single line that carries the identification is line 72**, `def IsWeylL (R : CurvLin ι) : Prop := IsWeyl (fun X => R X)`. Were it a locally restated predicate, or `IsWeyl` with a clause dropped, or a condition quantified over all matrices where the record quantifies over bivectors, the file would build unchanged and would not be about $\mathcal W_n$. It is the line on which the whole of section 2 turns, and it names the upstream predicate rather than copying it, which is the right construction.

**The line that carries the trace is the abbreviation at lines 68 and 69**, `CurvLin ι := Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ`. With `→` in place of `→ₗ[ℝ]` the `FiniteDimensional` instance at line 139 fails, `inferInstance` has nothing to find, and by section 5 it is not merely unproved but false. Everything else in the file is downstream of those two lines.

**The line where a claim exceeds the theorem is 159 to 161**, the docstring of `weylTrace_id`. The theorem says $\mathop{\mathrm{tr}}(\mathrm{id})=\mathop{\mathrm{finrank}}$, which is a tautology of Mathlib's trace on any free finite module and is true when the module is $\bot$. The prose says the trace is not the zero functional, which needs a nonzero member.

**How I looked.** I read every line of the file and checked each cited lemma at its source rather than by name, including the three `inner2` helpers proved in the file and the four imported pairing lemmas, confirming none is an `AltLayer` namesake and none is over $\mathbb Q$. I read the two Mathlib instances and the definition of `LinearMap.trace` in Mathlib's own source. I printed the axioms of all twelve declarations plus the instance and the three generated proofs. I grepped the whole Lean tree for every consumer of `weylModule`, `weylTrace`, `CurvLin` and `IsWeylL`, which is [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) alone, and for any nonzero witness for `IsWeylOp` or `IsWeyl`, of which there is none unconditional. I then attacked the two directions of the identification in Lean rather than in prose, which is what produced the `Rbad` falsifier, the `IsWeylOp` bridge and the forced-linearity-on-bivectors pair, and I attacked the "only bundling works" reading by building the trace on a submodule of the bare function space.

## Verdict

**The file is sound, gap-free on the three standard axioms, and does support the substance of all three claims under audit. Three of them are overstated in the prose and each overstatement is a one-line fix.**

- `weylModule` **IS** the record's $\mathcal W_n$, in the sense the record's own `IsWeylOp` fixes, and the bridge is three unstated lines. Against the layer's bare `IsWeyl` predicate it is strictly narrower, the narrowing is invisible to every quantity of the layer, and that invisibility is now a machine-checked fact rather than a plausible reading.
- All four clauses **ARE** linear in $R$, and the `add_mem'` and `smul_mem'` proofs discharge exactly the goals their statements name.
- "Needed no basis" should read "needed no EXPLICIT basis". Freeness over $\mathbb R$ is basis existence, and Mathlib's trace is the matrix trace in a chosen basis.
- "No trace on `CurvOp`" holds for nonempty $\iota$, with the sharper reason being that the bare `IsWeyl` set is itself infinite-dimensional. "Bundling is the whole step" should read that imposing linearity is the step.
- The row's omission list should gain the five items of section 6, and its "so nothing is vacuous" should go until a nonzero member of `weylModule` exists.
