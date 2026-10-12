# Reviewer 1005: six claims about the ambient space for I36

*Cold brief: [BRIEF-g2-ambient.md](BRIEF-g2-ambient.md), no prior report read, no author's conclusion supplied. **No numerical work was done.** Every value below is exact and derived by hand. The machine steps are `lake build` on the two files under review and `lake env lean` on ten scratch probes written for this round and then deleted, carrying `#print axioms` on nine declarations, thirteen instance-synthesis probes and five small elaborations: each reports what the kernel holds or what the elaborator can find rather than computing a value, and the probes cost under three minutes in total. Log: [agent_logs/r1005.log](../agent_logs/r1005.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | [skewSub](../lean/HamiltonsCubic/Base/Bivectors2.lean#L35) is the record's `Λ²` | **CONFIRMED**, all three clauses, and membership is `IsSkew` definitionally, which item 2 needs |
| 2 | [eq_zero_of_phi](../lean/HamiltonsCubic/Base/Bivectors2.lean#L60) is [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean#L79) read as spanning | **CONFIRMED**, and the two instances split: **[Fintype](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Fintype/Defs.html#Fintype) is load-bearing and the theorem is FALSE without it**, [DecidableEq](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Basic.html#DecidableEq) is the `φ` indexing alone |
| 3 | [eq_zero_of_innerOp_self](../lean/HamiltonsCubic/Base/Bivectors2.lean#L99), the payoff, and the contrast with [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean#L91) | **CONFIRMED as definiteness**, its hypothesis satisfiable only at `T = 0` **by design and not by vacuity**, with two corrections: it is not stated about [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135), and it has content only at `2 ≤ card ι`. The contrast is **CONFIRMED**, genuinely degenerate on the old domain |
| 4 | [CurvOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L149) and the three topology claims | **REFUTED in its mechanism, CONFIRMED in its conclusion**: no norm is in the elaborated type, the Frobenius `open scoped` is **inert**, and **the topology is bought by the continuous ARROW rather than by the change of domain**, the old domain with a `→L` carrying one too |
| 5 | continuity costs nothing | **CONFIRMED** and machine-checked at the instances in play, with the second half **CORRECTED**: the radical is dropped by the change of domain, never by continuity, and the restriction that would drop it is not in the file |
| 6 | what remains before [I36](../plan.md)'s shape claim is a Lean statement over `CurvOp2` | **NO ARGUMENT ON FILE**: nothing derives the list, so I name eight pieces, and correct [plan.md:173](../plan.md#L173), which owes an anchor that [sharpOp_id](../lean/HamiltonsCubic/Base/StructureConstants.lean#L217) already proves at every `n` |

**Actionable summary.** Every declaration in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) is correct and the definiteness payoff is real, and **the file's account of where its topology comes from is wrong in a way that costs the next link**: [CurvOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L149) elaborates to the subtype of the product topology on matrices with no norm anywhere in the term, `Norm (CurvOp2 (Fin 4))` does not synthesize even inside the Frobenius scope, and the same `IsLocalMaxOn` elaborates over `Matrix (Fin 4) (Fin 4) ℝ →L[ℝ] Matrix (Fin 4) (Fin 4) ℝ`, the OLD domain. Repair the two docstrings to say that the arrow buys the topology and the domain buys definiteness, and note in the file that the unit sphere still has no norm to be measured in.

## 0. Conventions, fixed once

- `φ_ab = E_ba - E_ab`, which is [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) verbatim, so `(φ_ab)_cd = [c=b][d=a] - [c=a][d=b]` and `φ_aa = 0`.
- `⟨X, Y⟩ = ½ ∑_{a,b} X_ab Y_ab`, which is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) through [inner2_eq_sum](../lean/HamiltonsCubic/Base/WeylReal.lean#L58). So `⟨φ_ab, φ_ab⟩ = 1` at `a ≠ b`, matching [conventions.md:88](../findings/conventions.md#L88), and `0` at `a = b`.
- `⟨R, S⟩_op = ½ ∑_i ∑_j ⟨R φ_ij, S φ_ij⟩`, which is [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135), the outer `½` paying for the ordered-pair double count.
- `Λ²` is the skew subspace of `Matrix ι ι ℝ`, of dimension `N = n(n-1)/2`, and `Sym` its complement, of dimension `n(n+1)/2`.
- `n = card ι` throughout. Indices are `0`-based. Sums over pairs are over ORDERED pairs unless a range says otherwise.

## Hypothesis inventory

| where | hypothesis | used for | verdict |
| --- | --- | --- | --- |
| [skewSub](../lean/HamiltonsCubic/Base/Bivectors2.lean#L35) | `[Fintype ι]`, `[DecidableEq ι]` | nothing in the three clauses | **UNUSED**, carried so the signature matches the downstream declarations |
| [eq_zero_of_phi](../lean/HamiltonsCubic/Base/Bivectors2.lean#L60) | `[Fintype ι]` | the finite sum in [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean#L79) | **ESSENTIAL**, the statement is false at infinite `ι` (section 2) |
| [eq_zero_of_phi](../lean/HamiltonsCubic/Base/Bivectors2.lean#L60) | `[DecidableEq ι]` | `Matrix.single` inside [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) | **INDEXING ONLY**, removable by `classical` |
| [eq_zero_of_phi](../lean/HamiltonsCubic/Base/Bivectors2.lean#L60) | `M` any `ℝ`-module | the codomain | **GENERAL**, and stronger than the payoff needs |
| [inner2_self_eq_zero](../lean/HamiltonsCubic/Base/Bivectors2.lean#L81) | `[DecidableEq ι]` | nothing | **UNUSED**, and the repository's own linter says so on this build |
| [eq_zero_of_innerOp_self](../lean/HamiltonsCubic/Base/Bivectors2.lean#L99) | `T` linear on `skewSub` | the appeal to `eq_zero_of_phi` | **ESSENTIAL** |
| [symOp_ne_zero](../lean/HamiltonsCubic/Results/WeylRadical.lean#L115) | `[Nonempty ι]` | the witness `single a a 1` | **ESSENTIAL**, and the contrast in item 3 inherits it |

## 1. Is [skewSub](../lean/HamiltonsCubic/Base/Bivectors2.lean#L35) the record's `Λ²`?

**The three clauses, checked by hand.** The carrier is `{X | IsSkew X}` and [IsSkew](../lean/HamiltonsCubic/Base/WeylReal.lean#L34) is `Xᵀ = -X`. Zero: `0ᵀ = 0 = -0`. Addition: `(X+Y)ᵀ = Xᵀ + Yᵀ = (-X) + (-Y) = -(X+Y)`, which is the file's `transpose_add` then `abel`. Scalars: `(cX)ᵀ = c(Xᵀ) = c(-X) = -(cX)`, which is `transpose_smul` then `smul_neg`. All three are the defining identity transported through an additive operation, and nothing else is needed.

**Membership is `IsSkew` on the nose.** [mem_skewSub](../lean/HamiltonsCubic/Base/Bivectors2.lean#L52) is `Iff.rfl`, so `Y.2` in the next theorem is literally a proof of `IsSkew ↑Y` and no coercion lemma stands between them. That is what makes the payoff's proof as short as it is.

**Is it the record's `Λ²`?** Over `ℝ` the characteristic is not `2`, so `Xᵀ = -X` forces `X_aa = 0` and the skew matrices are exactly the alternating ones, of dimension `n(n-1)/2`, which is [conventions.md:46](../findings/conventions.md#L46)'s `N = dim Λ²ℝⁿ`. The identification with `𝔰𝔬(n)` is the record's throughout, [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) restricted to it makes `{φ_ab}_{a<b}` orthonormal, and that is the pairing every result uses.

**What the record means by a bivector, and it carries a second and narrower sense.** `Λ²` is the space, and elsewhere the record says *bivector* for a DECOMPOSABLE element, [conventions.md:27](../findings/conventions.md#L27)'s *simple bivector in `𝔰𝔬(12)`* and [plan.md:140](../plan.md#L140)'s *orthonormal decomposable eigenbasis*. Those are the rank-two elements, a cone rather than a subspace, and the span of that cone is the whole of `skewSub`. An ambient space must be the span, so `skewSub` is the right object and the narrower sense is a predicate on its elements that a later file will need to define.

**Verdict: CONFIRMED.** One correction, inert: the `[Fintype ι]` and `[DecidableEq ι]` on `skewSub` itself do no work, the three clauses being transpose algebra over an arbitrary index type.

## 2. [eq_zero_of_phi](../lean/HamiltonsCubic/Base/Bivectors2.lean#L60), and what its instances are for

**The derivation, step by step.** `ext Y` reduces `T = 0` to `T Y = 0` at every `Y : skewSub ι`. [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean#L79) at `↑Y`, which is skew by `Y.2`, gives `½ ∑_i ∑_j ⟨Y, φ_ij⟩ φ_ij = ↑Y` in `Matrix ι ι ℝ`. The file lifts that to the submodule by `Subtype.ext`, which is legitimate because the coercion of a scalar multiple of a finite sum of submodule elements is the same expression in the ambient space. Then `map_smul` and `map_sum` push `T` through, `h` kills each summand, and the sum of zeros is zero. **The step is exactly spanning**: `T` vanishes on a spanning set and is linear, so it vanishes.

**It proves slightly more than the payoff uses.** The codomain `M` is an arbitrary `ℝ`-module, so the statement covers functionals and not only endomorphisms. The payoff instantiates `M := skewSub ι`.

**`Fintype` is load-bearing, and the theorem is false without it.** Take `ι = ℕ`. The `ℝ`-span of `{φ_ij}` is the set of skew matrices with finitely many nonzero entries, which is a PROPER subspace of `skewSub ℕ`: the matrix `Y` with `Y_{k,k+1} = 1`, `Y_{k+1,k} = -1` and zero elsewhere is skew and lies outside it. Choose a complement and let `T` be the projection onto a line through `Y`, a nonzero linear map killing every `φ_ij`. So the conclusion fails, and `Fintype` is what rules this out rather than a convenience of notation. The mechanism is visible in the proof: `skew_expand` is a finite sum, and there is no infinite-sum statement to replace it with.

**`DecidableEq` is the `φ` indexing alone.** It enters through `Matrix.single` inside [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45), which needs the equality test to define its indicator, and `classical` would discharge it. The repository's own linter makes the same report about the neighbouring [inner2_self_eq_zero](../lean/HamiltonsCubic/Base/Bivectors2.lean#L81) on this build, naming `[DecidableEq ι] (#3)` as a hypothesis the type does not use.

**Verdict: CONFIRMED**, with the two instances answered separately: one is the mathematics, the other is the encoding.

## 3. [eq_zero_of_innerOp_self](../lean/HamiltonsCubic/Base/Bivectors2.lean#L99), the payoff

**The brief asks for an operator satisfying the hypothesis non-trivially, and there is none, which is what the theorem says.** The hypothesis is `∑_i ∑_j ⟨T φ_ij, T φ_ij⟩ = 0`, and by [inner2_eq_sum](../lean/HamiltonsCubic/Base/WeylReal.lean#L58) each term is `½ ∑_{a,b} (T φ_ij)_ab²`, a sum of squares over `ℝ`. A vanishing sum of nonnegative terms has every term zero, so the hypothesis is EQUIVALENT to `T φ_ij = 0` for all `i, j`, and item 2 turns that into `T = 0`. **A definiteness theorem is exactly a theorem whose hypothesis only the zero vector satisfies**, so the absence of a non-trivial witness is its content rather than a sign it says nothing. The proof in the file is that argument twice, once to split the outer sum and once the inner, with the nonnegativity of each row supplied as `hnn`.

**Where the emptiness would be a defect, and it is not here.** The theorem would say nothing if no operator had a NONZERO value of that sum, since then the implication would hold for want of any operator to test. It does not: at `T = id`, `⟨φ_ij, φ_ij⟩` is `1` at `i ≠ j` and `0` at `i = j`, so the sum is `n(n-1)`, strictly positive at `n ≥ 2`. Equivalently `‖id‖²_op = ½ n(n-1) = N = dim Λ²`, which is the trace of the identity on `Λ²` and the value the record's pairing must give. So the pairing separates `id` from `0` and the theorem cuts.

**Two corrections, both recorded because a consumer will trip on them.**

*It is not stated about [innerOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L135), despite its name and its docstring's "the same `innerOp`".* That definition takes two bare functions `Matrix ι ι ℝ → Matrix ι ι ℝ`, and `T : skewSub ι →ₗ[ℝ] skewSub ι` is not one, so no declaration in the layer connects the hypothesis to [normSq](../lean/HamiltonsCubic/Base/WeylReal.lean#L173) or to [theta](../lean/HamiltonsCubic/Base/WeylReal.lean#L180). Under the evident identification the hypothesis is `2 ⋅ normSq = 0`, the factor being `innerOp`'s outer `½`, and the identification is a definition plus a lemma that nobody has written. **This is a missing bridge and not an error**, and it is the same shape as the gap item 6 records.

*The statement has content only at `2 ≤ n`.* At `n ≤ 1` there are no `φ_ij ≠ 0`, `skewSub ι` is the zero module, and the theorem reads `0 = 0`. Nothing assumes `Nonempty ι`, which is harmless for a definiteness statement and matters for any later claim that the space is nonzero.

**The contrast against [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean#L91), checked rather than taken.** [symOp](../lean/HamiltonsCubic/Results/WeylRadical.lean#L43) is `X ↦ X + Xᵀ`, and on a skew `X` that is `X + (-X) = 0`, so it kills `Λ²` pointwise. Every clause of [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) reads its operator on skew arguments or on the `φ` family alone, so [mem_weylModule_of_kills_skew](../lean/HamiltonsCubic/Results/WeylRadical.lean#L55) puts every such map in the module. [symOp_normSq](../lean/HamiltonsCubic/Results/WeylRadical.lean#L105) is then immediate and [symOp_ne_zero](../lean/HamiltonsCubic/Results/WeylRadical.lean#L115) tests it at `single a a 1`, whose image has `(a,a)` entry `2`. **So the same sum genuinely vanishes on nonzero elements there**, and on the whole space of maps killing `Λ²`, of dimension `n² ⋅ n(n+1)/2`. I confirmed all four declarations on `[propext, Classical.choice, Quot.sound]`.

**Verdict: CONFIRMED**, the definiteness being real and the degeneracy on the old domain being real, with the two corrections above.

## 4. [CurvOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L149) and the topology

I probed each of the three claims at `ι = Fin 4`.

**(i) `IsLocalMaxOn` elaborates over `CurvOp2`: CONFIRMED.** [IsLocalMaxOver](../lean/HamiltonsCubic/Base/Bivectors2.lean#L154) is in the file and the build accepts it, and an equivalent example elaborates OUTSIDE the Frobenius scope as well.

**(ii) It elaborates over neither [CurvLin](../lean/HamiltonsCubic/Base/WeylModule.lean#L71) nor `Module.End`: CONFIRMED.** `TopologicalSpace (CurvLin (Fin 4))` and `TopologicalSpace (Module.End ℝ (skewSub (Fin 4)))` both fail to synthesize, as does the unabbreviated `Matrix (Fin 4) (Fin 4) ℝ →ₗ[ℝ] Matrix (Fin 4) (Fin 4) ℝ`. **The cause is the ARROW**: Mathlib carries the strong topology on [ContinuousLinearMap](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/Algebra/Module/StrongTopology.html) and none on [LinearMap](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Module/LinearMap/Defs.html#LinearMap), which is why both failures look alike whatever the domain is.

**(iii) The choice of norm is immaterial: TRUE AS MATHEMATICS AND NOT WHAT HAPPENS HERE.** `set_option pp.explicit true in #print CurvOp2` shows the elaborated type to be `ContinuousLinearMap` over `instTopologicalSpaceSubtype` applied to `instTopologicalSpaceMatrix`. **There is no norm anywhere in the term.** The topology is the subtype topology of the entrywise product topology on matrices, which is a global instance and needs no scope. Three consequences, and the third is the one that costs something.

- **The `open scoped Matrix.Norms.Frobenius` at [line 145](../lean/HamiltonsCubic/Base/Bivectors2.lean#L145) is inert.** An abbreviation with the same body declared outside the scope is `rfl`-equal to `CurvOp2`, and `IsLocalMaxOn` elaborates over it. Inside the scope, `TopologicalSpace (skewSub (Fin 4))` still resolves to `instTopologicalSpaceSubtype`, so the normed structure never reaches the topology path. The scope does supply `Norm (skewSub (Fin 4))`, which nothing in the file reads.
- **`Norm (CurvOp2 (Fin 4))` fails to synthesize, inside the scope.** So [CurvOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L149)'s docstring, *"Continuous-linear, so the type carries a norm and therefore the topology local maximality needs"*, is false in its first half and true in its second by another route. The topology arrived free and the norm is still owed, which matters because a unit sphere is what I36 quantifies over.
- **The change of domain is not what buys the topology.** `Matrix (Fin 4) (Fin 4) ℝ →L[ℝ] Matrix (Fin 4) (Fin 4) ℝ`, the OLD domain with a continuous arrow, synthesizes `ContinuousLinearMap.topologicalSpace` and `IsLocalMaxOn` elaborates over it. So [IsLocalMaxOver](../lean/HamiltonsCubic/Base/Bivectors2.lean#L154)'s docstring, *"which is the whole purpose of the change of domain"*, attributes to the domain what the arrow does. **What the change of domain buys is definiteness**, which section 3 shows the old domain cannot have at any arrow, and that is a better reason for the file to exist than the one it gives.

**Is `skewSub` finite-dimensional, and does the file prove it?** It is, and the file neither proves nor invokes it: `FiniteDimensional ℝ (skewSub (Fin 4))` synthesizes as `FiniteDimensional.finiteDimensional_submodule (skewSub (Fin 4))` from the ambient matrix space with no work. **It is needed for the claim the file is really making**, which is that the topology on `CurvOp2` is the record's one: on a finite-dimensional real vector space there is exactly one Hausdorff linear topology, so the product topology, every norm topology and the strong operator topology agree, and local maximality reads the same in all of them. That argument is available and unstated, and the argument the file gives instead, about norms inducing one topology, does not apply to a type no norm enters.

**Verdict: REFUTED in its mechanism, CONFIRMED in its conclusion.** All three of the file's claims about what elaborates are true. The account of why is wrong at two of the three points, and the repair is two docstrings rather than any theorem.

## 5. Does continuity cost anything?

**The first half is CONFIRMED and machine-checked.** `example (T : skewSub (Fin 4) →ₗ[ℝ] skewSub (Fin 4)) : Continuous T := T.continuous_of_finiteDimensional` elaborates at the instances actually in play, so [LinearMap.continuous_of_finiteDimensional](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Normed/Module/FiniteDimension.html#LinearMap.continuous_of_finiteDimensional) applies and every linear endomorphism of `Λ²` is continuous. `CurvOp2 ι` and `Module.End ℝ (skewSub ι)` therefore have the same underlying set, and the continuity in the arrow is free. The hypothesis it consumes is again the finite-dimensionality the file does not name.

**The second half is CORRECTED.** *"The continuous-linear type holds every operator the bare one did, without the radical"* puts two changes under one cause. Continuity loses nothing, by the paragraph above. The radical is lost to the CHANGE OF DOMAIN: an element of the radical is a map on all matrices that kills `Λ²`, and on `Λ²` alone there is nothing for it to be. Bundling continuity into the arrow over the old domain would have kept every one of them, since a map killing `Λ²` and extended linearly is continuous too.

**And the passage from one to the other is not in the file.** To say `CurvOp2` holds every operator the bare type did, one needs the restriction `R ↦ R|_{Λ²}`, which is defined only on operators mapping `Λ²` into `Λ²`, so on [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)'s members by its first clause and not on [CurvLin](../lean/HamiltonsCubic/Base/WeylModule.lean#L71) at large. No such map is declared, so the comparison is prose. Item 6 carries it as the second missing piece.

**Verdict: CONFIRMED on continuity, CORRECTED on what the new type holds.**

## 6. What remains before [I36](../plan.md)'s shape claim is a Lean statement over `CurvOp2`

The target is *every local maximiser of `θ` above `√(3/2)` is coordinate-diagonal*, [plan.md:142](../plan.md#L142). Nothing on the record derives what that costs, so this section is a list and not a check of one, and the verdict for the item is that the claim has no argument on file.

1. **The Weyl predicate over the new domain.** [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean#L126) is stated for bare functions on all matrices. Restated for `T : CurvOp2 ι` its first clause becomes type-level and the other three survive verbatim, and the restatement needs its own submodule proof, the analogue of [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean#L91).
2. **The restriction map and its two properties.** `weylModule ι → 𝒲ₙ` by `R ↦ R|_{Λ²}`, surjective, with kernel the radical. That is what licenses calling the new space `𝒲ₙ` and what carries every existing result across.
3. **The pairing over the new domain, and the bridge to section 3.** `innerOp` and `normSq` for operators on `Λ²`, plus the lemma that the sum in [eq_zero_of_innerOp_self](../lean/HamiltonsCubic/Base/Bivectors2.lean#L99) is `2 ⋅ normSq`, without which the definiteness proved here attaches to no quantity the record names.
4. **A norm instance, and it is the link the file says is owed.** `Norm (CurvOp2 (Fin 4))` does not synthesize, so `‖T‖ = 1` cannot be written. **Two traps sit on this step**: the ambient Frobenius norm on `skewSub` gives `‖φ_ab‖ = √2` against the record's `1`, [conventions.md:88](../findings/conventions.md#L88), and Mathlib's norm on a `→L` space is the OPERATOR norm, where the record's `‖T‖` is the Hilbert-Schmidt norm `⟨T, T⟩_op`. Either default silently states a different unit sphere, and the topology is insensitive to the difference, so nothing would catch it.
5. **`P`, `Q`, `#` and `θ` transported.** [Pcubic](../lean/HamiltonsCubic/Base/WeylReal.lean#L170), [Qop](../lean/HamiltonsCubic/Base/WeylReal.lean#L189) and [theta](../lean/HamiltonsCubic/Base/WeylReal.lean#L180) all take bare functions, and `sharpOp` is built from sums over the `φ` family that carry across unchanged.
6. **The anchor restated where the new `#` lives.** [plan.md:173](../plan.md#L173) lists *the `id# = (n-2)·id` anchor that would certify `θ`* as owed. **It is proved**, [sharpOp_id](../lean/HamiltonsCubic/Base/StructureConstants.lean#L217) gives it at every skew argument and every `n`, as [conventions.md:75](../findings/conventions.md#L75) also records. What is owed is its restatement for whatever `#` is written on `CurvOp2`, and the plan row should say so.
7. **A bridge from `CurvOp2` to `Tensor4`.** `CoordinateDiagonal`, `IsFrame` and `κ²` live on [Tensor4](../lean/HamiltonsCubic/Results/L94Statement.lean#L94), and [toTensor](../lean/HamiltonsCubic/Results/TensorBridge.lean#L37) takes a bare function, so the shape half of the statement needs either a second `toTensor` on the new domain or an extension `CurvOp2 ι → CurvLin ι` by zero on `Sym`, with `isWeyl_toTensor` carried along.
8. **Non-vacuity at the new type.** The only exhibited member of the layer's Weyl space is `0`, which [weylTrace_id](../lean/HamiltonsCubic/Base/WeylModule.lean#L178)'s docstring already records as owed. A nonzero witness is what makes the local-maximality statement about something, and on the tensor side [r1002](REVIEW_r1002.md) reports one kernel-checked already.

With 1 to 8 in place the statement is `IsLocalMaxOn θ {T | IsWeyl T ∧ ‖T‖ = 1} T → √(3/2) ≤ θ T → CoordinateDiagonal (toTensor T)`, and the type-checking of that is what the file under review was built to make possible. **Nothing in 1 to 8 is deep**, and 4 is the only one where a wrong default would produce a statement that looks right and is not.

**Verdict: NO ARGUMENT ON FILE**, with the eight pieces named and [plan.md:173](../plan.md#L173) corrected at one row.

## Overall verdict

**PROVEN (hypotheses corrected)** on [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), whose five substantive declarations I confirmed one by one on `[propext, Classical.choice, Quot.sound]`, with `Fintype` promoted from an indexing convenience to a load-bearing hypothesis and `DecidableEq` demoted to the encoding. **The file's account of its own topology is REFUTED**: the arrow buys it, not the domain, and no norm is involved. **Item 6 stands as HYPOTHESIS-DEBT**, and the piece to do first is the norm, since it is the one whose wrong default states a different theorem.
