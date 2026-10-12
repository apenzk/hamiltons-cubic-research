# Review r862: integrality as commutativity, the I75 row bound, and isotropy of Θ on one eigenspace

**Cold brief.** The reviewer read the brief and [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) and nothing else of the record. No numerical work beyond screening was done: three exact screens, on objects constructed here for the purpose (the Lean file's own instance pair, an isoclinic pair, the rotated witness's fifteen plane pairs, and the balanced sphere product's spectrum), each reported as a screen and each reproducing a value derived by hand first. Every value in this report is exact, and every decimal is a rounding of an exact closed form named beside it. Log: [agent_logs/review-r862-commutator.log](../agent_logs/review-r862-commutator.log).

## The claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | Integrality of the pairwise plane traces is commutativity of the projections, L201 follows in two lines, and Ξ ≤ n²(n−1) is positivity of the same sum of squares | **HOLDS, EVERY LINK** |
| 2 | On the decomposable locus the pair cap is 1, so θλ_k ≤ (1+λ_k²)/2 at every index, and its contrapositive is a test that padded W_CP² fails | **HOLDS, BUT TWO PUBLISHED FIGURES ARE WRONG IN THE FOURTH DIGIT** |
| 3 | Two eigenvalues make Ricci-flatness isotropy of Θ(E), with A-regularity as its contraction, balancedness and the pencil exclusion in one line, and the diagonal dictionary | **HOLDS EXCEPT ONE SUB-CLAIM, WHICH IS REFUTED: A-REGULARITY AND ISOTROPY ARE EQUIVALENT, NOT STRICTLY WEAKER** |

| # | Defect | Severity | Where |
|---|---|---|---|
| D1 | "This is strictly stronger than the A-regularity above" is false. For a complete orthonormal decomposable configuration the two conditions are equivalent, in one line, and given 14 of the brief already says as much | **REFUTED SUB-CLAIM.** The isotropy statement itself survives, and so does everything the record draws from it | claim 3, §8 and §10 below |
| D2 | "the two failures S = cos²t and S = sin²t" undercounts. The rotated witness has **four** non-integral pairs, taking those two values | **MISCOUNT**, the claim it supports survives intact | claim 3, §11 |
| D3 | λ_max = 0.1349 and the bound 3.774 at the balanced product. Exactly λ_max = 1/√55 = 0.1348400 and the bound is 28√55/55 = 3.775519. The published bound is what the rounded λ_max returns | **ARITHMETIC**, conclusion unaffected | claim 2, §7 |
| D4 | "Θ(f ∧ U′) is isotropic only at r = 1" is false. At r = 1 and n ≥ 3 it is not isotropic either, its rank being 2 | **STATEMENT**, and the error runs in the safe direction: no pencil of any dimension can be a two-eigenvalue eigenspace | claim 3, §9 |
| D5 | "tr(Π_α Π_β) ∈ {0,1} at every pair" is false at α = β, where the trace is 2. Read as every distinct pair, which is what [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) types | **WORDING** | claim 1, §2 |
| D6 | "L198 is sharp only OFF the decomposable locus" needs λ_max² < 1, which is trace-freeness and is not stated | **ELISION**, one line, supplied in §6 | claim 2, §6 |
| D7 | The dictionary's converse, regularity implies isotropy, needs Θ(E) to be diagonal on the coordinate configuration. Testing at x = e_i alone gives only the forward direction | **ELISION**, one line, supplied in §10 | claim 3, §10 |
| D8 | At two eigenvalues first Bianchi is the separate condition Alt(Π_E) = 0. It is free when E carries a decomposable basis, so the record's use is safe, and the classification question in [I76](../plan.md) should carry it | **HYPOTHESIS INVENTORY** | claim 3, §8 |
| D9 | The factor 2 needs the plain Frobenius norm, tr(CᵀC). Under the record's own Λ² normalisation, ⟨X,Y⟩ = ½tr(XᵀY), the constant is 1 | **CONVENTION**, pinned correctly by the Lean instance | claim 1, §1 |

**One line.** All three chains hold as mathematics, the commutator route to L201 and the bound is exactly right and is the best link in the record, and the one thing that must be withdrawn is the word "strictly" in claim 3's comparison of isotropy with A-regularity, because the two conditions are the same condition.

## The conventions, quoted from the brief

- Λ²ℝⁿ is realised as skew matrices, φ_ab = E_ba − E_ab is a UNIT bivector, and ⟨X,Y⟩ = ½tr(XᵀY).
- u ∧ v = vuᵀ − uvᵀ. At orthonormal u, v this is a unit bivector and (u∧v)(u∧v)ᵀ = uuᵀ + vvᵀ = Π_P, the orthogonal projection onto P = span{u,v}. This holds for exactly this normalisation, and the 1/√2 convention returns ½Π_P.
- ω is decomposable when ω = u ∧ v, equivalently ω ∧ ω = 0, and the record's wedge is twice the Pfaffian.
- 𝒲_n is the algebraic Weyl tensors, P(W) = ⟨W, W² + W#⟩, θ = P(W)/‖W‖³, and criticality on the unit sphere is Q(W) = W² + W# = θW.
- √(3/2) = 1.224745 and θ₀(n) = √(2(n−1)(n−2))/n.
- The inner product on the Π_α is the plain tr(AB) with no factor ½, and ‖W‖² = Σ λ_α² over the eigenvalues.

Two normalisations therefore live side by side in claim 1, and §1 separates them.

## Hypothesis inventory

**Claim 1** uses: n ≥ 3 (inert, see §3), each ω_α decomposable of unit norm, pairwise Λ²-orthogonality, integrality at every distinct pair, and, for the word "exactly" in the conclusion, completeness N = C(n,2). It uses no Weyl tensor, no criticality and no eigenvalues, so the kernel of W cannot enter it. For the bound it additionally uses Σ_α Π_α = (n−1)Id, which is given 1 read through (u∧v)(u∧v)ᵀ = Π_P.

**Claim 2** uses: [L199](../findings/bounds.md) (critical, unit norm, the row inequality θλ_k ≤ λ_k² + ½R_k), the bridge for every pair (k,β) with λ_β ≠ 0, hollowness at β = k, and Σ_β λ_β² = 1. It does **not** need the kernel's eigenvectors decomposable, so the test it yields is stronger than the record advertises (§13).

**Claim 3** uses: exactly two distinct eigenvalues μ ≠ ν, trace-freeness, additivity and the trace of Θ, completeness N = C(n,2), and, for the contraction to A-regularity and for the dictionary, decomposability of the eigenbasis. Its Ricci-flatness is the matrix condition Σ_α λ_α Θ(E_α) = 0. First Bianchi is a further condition, Alt(Π_E) = 0, which the record does not name (D8).

---

## 1. The commutator identity, derived from scratch

Fix the two planes in principal position. Let ϑ₁, ϑ₂ be the principal angles, with orthonormal bases u, v of P_α and u′, v′ of P_β chosen so that u·u′ = cos ϑ₁, v·v′ = cos ϑ₂ and u·v′ = v·u′ = 0. Write c₁ = cos ϑ₁, c₂ = cos ϑ₂.

**Λ²-orthogonality collapses the two angles to one.** From u ∧ v = vuᵀ − uvᵀ and ⟨X,Y⟩ = ½tr(XᵀY),

  ⟨u ∧ v, u′ ∧ v′⟩ = (u·u′)(v·v′) − (u·v′)(v·u′),

which I get by expanding tr((u∧v)ᵀ(u′∧v′)) = −tr((u∧v)(u′∧v′)) into its four terms, each a product of two inner products, the two mixed terms appearing twice. At α = β this returns 1, confirming the unit normalisation. In principal position the value is c₁c₂, so Λ²-orthogonality is exactly c₁c₂ = 0. One principal angle is right, and after relabelling ϑ₂ = π/2. Then v′ ⊥ u and v′ ⊥ v, so v′ = y ⊥ P_α, and u′ = c₁u + s₁x with x ⊥ P_α a unit vector and, since y ⊥ u′ and y ⊥ u, also y ⊥ x. This is the brief's principal position, and S_αβ = tr(Π_α Π_β) = c₁² + c₂² = c₁².

**The product has one surviving term.** With Π_α = uuᵀ + vvᵀ and Π_β = u′u′ᵀ + yyᵀ the four terms are

- uuᵀ·u′u′ᵀ = (u·u′) uu′ᵀ = c₁ uu′ᵀ,
- uuᵀ·yyᵀ = (u·y) uyᵀ = 0 because y ⊥ P_α,
- vvᵀ·u′u′ᵀ = (v·u′) vu′ᵀ = 0 because v·u′ = c₁(v·u) + s₁(v·x) = 0,
- vvᵀ·yyᵀ = (v·y) vyᵀ = 0.

So Π_α Π_β = c₁ uu′ᵀ, as written, and its trace is c₁(u′·u) = c₁² = S_αβ. **The brief's claim that the other three terms vanish is correct**, and the two vanishings that matter are both consequences of ϑ₂ = π/2, hence of Λ²-orthogonality.

**The commutator.** Both projections are symmetric, so (Π_α Π_β)ᵀ = Π_β Π_α and C := [Π_α, Π_β] = c₁(uu′ᵀ − u′uᵀ) is antisymmetric. Then

  CᵀC = c₁²(u′u′ᵀ − c₁ u′uᵀ − c₁ uu′ᵀ + uuᵀ),  tr(CᵀC) = c₁²(1 − c₁² − c₁² + 1) = 2c₁²(1 − c₁²),

that is ‖[Π_α, Π_β]‖_F² = 2S_αβ(1 − S_αβ). **The identity is correct.** The displayed form [Π_α,Π_β] = √S_αβ (uu′ᵀ − u′uᵀ) is consistent with it, since ‖uu′ᵀ − u′uᵀ‖_F² = 2(1 − (u·u′)²) = 2(1 − S), and it assumes the principal-position sign convention c₁ = +√S, which is a free choice of orientation for u.

**Which normalisation the factor 2 needs (D9).** It needs ‖C‖_F² = Σ_ij C_ij² = tr(CᵀC), the plain Frobenius norm. Under the record's own Λ² inner product, ½tr(XᵀY), the same commutator has squared norm S(1 − S) and the constant is 1. The record writes ‖·‖_F and the Lean instance checks Σ_i Σ_j C_ij², so the intended reading is the plain one and it is the right one. **Screen**: at the file's instance, u = e₀, v = e₁, u′ = (3/5)e₀ + (4/5)e₂, y = e₃, I get Λ² inner product 0, S = 9/25 and Σ_ij C_ij² = 288/625 = 2·(9/25)·(16/25), reproducing [trace_instA_instB](../lean/HamiltonsCubic/Results/L201Statement.lean) and [frobSq_commutator_inst](../lean/HamiltonsCubic/Results/L201Statement.lean) exactly. Under the ½ convention the same instance gives 144/625, so the two conventions are distinguished by this instance and the file pins the right one.

**Is the identity true without Λ²-orthogonality? No.** In general position the same computation with Π_α Π_β = c₁ uu′ᵀ + c₂ vv′ᵀ gives (Π_α Π_β)² = c₁³ uu′ᵀ + c₂³ vv′ᵀ, hence

  ‖[Π_α, Π_β]‖_F² = 2‖Π_α Π_β‖_F² − 2tr((Π_α Π_β)²) = 2(c₁² + c₂²) − 2(c₁⁴ + c₂⁴) = 2 Σ_i c_i²(1 − c_i²) = ½ Σ_i sin²(2ϑ_i),

using ‖Π_α Π_β‖_F² = tr(Π_β Π_α Π_α Π_β) = tr(Π_α Π_β) = S. This is the general truth, and it equals 2S(1 − S) exactly when (c₁² + c₂²)² = c₁⁴ + c₂⁴, that is exactly when c₁c₂ = 0. **So the identity holds precisely on the Λ²-orthogonal locus, and the record's account of why is right.** It is also visibly the classical statement: with T = Π_α Π_β Π_α, whose eigenvalues on P_α are c₁², c₂², the general identity reads ‖[Π_α,Π_β]‖_F² = 2tr(T − T²) = 2tr(T(I − T)), so the record's remark about two-projection theory is accurate and is the general case rather than an analogy. The citation the record owes remains owed, and I add nothing to it: the derivation above is self-contained and needs no source.

## 2. Integrality equals commutativity, and the hypothesis is load-bearing

**Forward.** S ∈ {0,1} gives 2S(1 − S) = 0, so C = 0. **Backward.** C = 0 gives 2S(1 − S) = 0, so S ∈ {0,1}, S being real. Both directions are immediate from §1 and both need only the identity. That S ∈ [0,1] at all is itself a consequence of orthogonality, since S = c₁² there, whereas in general S = c₁² + c₂² ∈ [0,2].

**The equivalence fails without a right principal angle.** Take P_α = span{e₁,e₂} and P_β = span{(e₁+e₃)/√2, (e₂+e₄)/√2} in ℝ⁴. The cross Gram is c₁ = c₂ = 1/√2 with the mixed products zero, so the two planes are isoclinic at 45°, S = 1 is **integral**, and yet by the general identity ‖[Π_α,Π_β]‖_F² = 2·1 − 2·(1/4 + 1/4) = 1 ≠ 0: **the projections do not commute.** The Λ² inner product of the two bivectors is c₁c₂ = 1/2 ≠ 0, so the pair is outside the hypothesis, as it must be. **Screen**: exact arithmetic returns S = 1, Σ_ij C_ij² = 1, tr T = 1, tr T² = 1/2 and 2tr(T − T²) = 1, confirming the closed form. So Λ²-orthogonality is load-bearing and the failure mode is one-sided: S = 0 forces c₁ = c₂ = 0 and hence commuting, so only the value S = 1 can fail.

**D5.** The record's hypothesis "tr(Π_α Π_β) ∈ {0,1} at every pair" is false at α = β, where the trace is 2. It must be read at every distinct pair. [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) types it correctly, with `hint` quantified over `a ≠ b`.

## 3. The two-line proof of L201

The steps are: pairwise integrality gives pairwise commuting (§2); a commuting family of real symmetric matrices is simultaneously orthogonally diagonalisable; a diagonal symmetric idempotent has diagonal entries d_i with d_i² = d_i, hence d_i ∈ {0,1}, and trace 2 makes exactly two of them 1; so each P_α is span{f_i, f_j} for one frame f and one pair i ≠ j. **Each link holds.** The one hypothesis silently used is that each Π_α really is a rank-two orthogonal projection, which is (u∧v)(u∧v)ᵀ = Π_P at orthonormal u, v, that is the brief's normalisation.

**What needs the family to be a basis.** Nothing in the above does. The argument proves the stronger statement that *any* pairwise Λ²-orthogonal, pairwise integral family of decomposable unit forms has all its planes among the coordinate planes of one frame, with no completeness hypothesis, so [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean)'s `hcomplete` is not needed for that conclusion. The word **exactly** in "has the P_α as exactly its coordinate 2-planes" is where completeness earns its place, and it needs two further remarks the record does not make: the map α ↦ {i,j} is injective, because P_α = P_β would give S_αβ = 2 and contradict Λ²-orthogonality, and it is surjective, because a basis has N = C(n,2) members and there are C(n,2) coordinate planes. A proper subfamily satisfies every other hypothesis and is not all of a frame's coordinate planes, for instance {Π_{12}, Π_{34}} in ℝ⁴, so the counting is not decoration.

n ≥ 3 is inert for this argument. At n = 2 the space Λ²ℝ² is one-dimensional and the single plane is ℝ² itself, still a coordinate plane. Worth noting that at n = 3 the hypothesis is vacuous: two distinct planes in ℝ³ always meet in a line, so c₁ = 1 and Λ²-orthogonality forces c₂ = 0 and S = 1 at every pair.

**What the deleted four-step induction had that this does not.** I cannot inspect it. The brief says [r856](REVIEW_r856.md) and [r857](REVIEW_r857.md) confirmed it step by step, and I did not read them, so I record only what the replacement does and does not deliver. It delivers the frame non-constructively, from simultaneous diagonalisation, and it therefore produces no intermediate combinatorics: not the per-index degree count 2(n−2) that [sum_trace_off](../lean/HamiltonsCubic/Results/L201Statement.lean) types, not the Johnson-graph structure of given 11, and no statement about how the frame is assembled out of the shared lines. It also does not itself certify the word "exactly", which needs the counting above rather than an induction. Against that, it drops completeness from the main conclusion and it drops the base case and the pressure point. **The trade is real and, in my judgement, correct: the by-products it loses are all recorded elsewhere as independent identities.**

## 4. The bound as positivity

Sum the identity over ordered distinct pairs:

  Σ_{α≠β} ‖[Π_α,Π_β]‖_F² = 2 Σ_{α≠β} S_αβ − 2 Σ_{α≠β} S_αβ².

The first total is n(n−1)(n−2). I re-derive it rather than quote it: Σ_{α,β} S_αβ = tr((Σ_α Π_α)²) = tr((n−1)²Id) = n(n−1)², and the diagonal contributes Σ_α S_αα = 4N = 2n(n−1), leaving n(n−1)² − n(n−1) = n(n−1)(n−2). The second is Ξ − 2n(n−1), since Ξ is defined over all pairs and each diagonal term is S_αα² = 4, giving 4N = 2n(n−1), which is the value the brief's given 10 states. Hence

  Σ_{α≠β} ‖[Π_α,Π_β]‖_F² = 2[n(n−1)(n−2) − Ξ + 2n(n−1)] = 2[n(n−1)(n−2+2) − Ξ] = 2[n²(n−1) − Ξ].

**Correct, diagonal accounting included.** Positivity gives Ξ ≤ n²(n−1), with equality iff every off-diagonal commutator vanishes, iff off-diagonal integrality, which is L201's hypothesis. The equality case is about off-diagonal entries only, and the diagonal value 2 is never integral in the sense of {0,1}: this is D5 again, and it is only wording. **Screen of the equality case, on the coordinate configuration**: Σ_{α≠β} S² counts ordered adjacent pairs of J(n,2), each contributing 1, giving N·2(n−2) = n(n−1)(n−2), plus the diagonal 2n(n−1), total n²(n−1) exactly. So the two statements of given 10 and the commutator identity agree, and the record's remark that the bound and L201 "were never independent" is right.

## 5. The I75 row bound

On the decomposable locus the eigenbasis members are pairwise Λ²-orthogonal decomposable unit forms, so the bridge gives ‖[v_k, v_β]‖² = S_kβ ≤ 1 at β ≠ k. At β = k the commutator is zero, which is where **hollowness** enters: the diagonal term is absent, not merely bounded. Hence

  R_k = Σ_{β≠k} λ_β² S_kβ ≤ Σ_{β≠k} λ_β² = 1 − λ_k²,

where the last step is **unit norm**, Σ_β λ_β² = 1 over the whole spectrum. Substituting into [L199](../findings/bounds.md),

  θλ_k ≤ λ_k² + ½(1 − λ_k²) = (1 + λ_k²)/2 at every index k.

**Both steps are right and the conclusion holds at every index**, kernel indices included, where it reads 0 ≤ 1/2. Two remarks. First, the pair caps are consistent: given 17's cap of 2 needs both arguments of rank four, and decomposable forms have rank two, so 1 is the right value on this locus and there is no clash. Second, the strictness claim is correct and has a one-line reason the record does not give: λ_k² = 1 would force a single nonzero eigenvalue, impossible for a nonzero trace-free operator, so λ_k² < 1 at every index and (1 + λ_k²)/2 < 1 strictly.

It is worth recording what shape the inequality has. Rearranged it is λ_k² − 2θλ_k + 1 ≥ 0, so for θ > 1 every eigenvalue must avoid the open band (θ − √(θ²−1), θ + √(θ²−1)). Since λ_k ≤ 1 < θ + √(θ²−1), the operative content is λ_k ≤ θ − √(θ²−1) = 1/(θ + √(θ²−1)) at every index, which is the record's inverted form and is a cap on the positive part of the spectrum.

## 6. The corollary as a test

**The figures.** Self-duality and unit norm give 6c² = 1, so the spectrum is (2,−1,−1)/√6 on one chirality and 0 on the other, λ_max = 2/√6 = √6/3 = 0.8164966, λ_max² = 2/3, and θλ_max = √(3/2)·2/√6 = 2√3/√12 = **1** exactly, against (1 + 2/3)/2 = **5/6**. The excess 1/6 is a fifth of 5/6, so "fails it by a fifth" is a fair reading. **Screen** reproduces 1 and 5/6 exactly. Padding to n > 4 changes nothing: the Ricci contraction of the padded operator vanishes on the old and the new directions alike, and the norm and P are unchanged, so θ = √(3/2) survives.

**Does the test exclude anything the record does not already exclude? Not at this instance.** Padded W_CP² has spectrum {2c, −c, 0} with 2c simple, so its λ = 2c eigenvector is determined up to sign, and at n = 4 it is a self-dual form, for which ω ∧ ω ≠ 0. A single eigenvector settles it: no decomposable eigenbasis exists, in one line and without any inequality. The record concedes exactly this by saying the obstruction is "recovered quantitatively rather than by exhibiting the obstruction". **So the corollary's value is that it is a test applicable where no eigenvector is pinned, and nothing in the record shows it has yet excluded anything new.** I did not go looking for a critical point with θλ_max in (5/6, 1], because that is a search and the footing blocks it. What such a run would decide: whether the test has any exclusion power beyond the eigenvector argument. An empty answer would mean the corollary is presentational, and a hit would be the first object the test alone kills.

**"L198 is sharp only OFF the decomposable locus" does follow**, given the missing line of §5: on the locus θλ_max ≤ (1 + λ_max²)/2 < 1 strictly, so equality in [L198](../findings/bounds.md) is unattainable there, while padded W_CP² attains it off the locus. That is D6, an elision rather than an error.

## 7. Non-composition with the global bound, and the balanced product's figures

**The spectrum.** For S⁶ × S⁶ the sectional curvatures are 1 on the 2·C(6,2) = 30 within-factor planes and 0 on the 6·6 = 36 cross planes, so the scalar curvature is 2·30 = 60 and the Weyl shift is 60/(12·11) = 5/11 = 0.4545454…. The eigenvalues are 1 − 5/11 = **6/11 = 0.5454545…** on 30 planes and **−5/11 = −0.4545454…** on 36, which is trace-free: 30·6 − 36·5 = 0. The norm is ‖W‖² = (30·36 + 36·25)/121 = **1980/121 = 180/11 = 16.363636…**, so ‖W‖ = 4.045199. **All of the record's figures here are right, and √16.36 is a rounding of √(180/11).**

**The two that are not (D3).** At unit norm λ_max² = (36/121)/(180/11) = **1/55** exactly, so λ_max = **1/√55 = √55/55 = 0.1348400**, not 0.1349. The bound is (1 + 1/55)·√55/2 = **28√55/55 = 3.775519**, not 3.774. Feeding the rounded 0.1349 into the bound returns 3.7739, which is where the published figure comes from, so one rounding produced both. **Screen** returns 1/55, √55/55 and 28√55/55, and θ₀(12) = √220/12 = **1.2360331**, which the record states correctly.

For context, from the graph side the balanced product S^p × S^p has λ_max = 1/√((p−1)(2p−1)), which at p = 6 is 1/√55, an independent route to the same exact value. Its θ, obtained from relation (C) on the edges and again on the non-edges of K_p ⊔ K_p, is √((2p−1))·(p−1)/(p√((p−1)(2p−1))), which at p = 6 is √55/6 = **1.2360331 = θ₀(12) exactly**. So the row bound offers 3.7755 where the truth is 1.2360, and θλ_max = 1/p = 1/6 there against the row bound's 28/55 = 0.5091. **The scoreboard is indeed unmoved, and by a factor of three rather than a hair.**

**The reason given for non-composition is correct.** [L107](../findings/bounds.md) routes through |λ_min|, and the row inequality is vacuous at a negative index: θ ≥ 0 may be assumed, since W ↦ −W flips the sign of P, so θλ_k ≤ 0 < (1 + λ_k²)/2 automatically. I add the sharper reason. The row bound caps the positive part of the spectrum, and trace-freeness Σ_{λ>0} λ = Σ_{λ<0} |λ| with Σλ² = 1 then pushes |λ_min| **up**, which is the direction that weakens L107's θ ≤ (n−1)|λ_min|. So the row bound cannot improve that composition even indirectly, and the record's "sharpens the λ_max row and not the composition" is right for a reason stronger than the one given.

## 8. The isotropy form

At exactly two eigenvalues, W = ν Id + (μ − ν) Π_E with E = E_μ and a = dim E. Ricci-flatness in the form of given 2 is μΘ(E) + νΘ(E^⊥) = 0, and Θ(E) + Θ(E^⊥) = (n−1)Id by additivity and Θ(Λ²ℝⁿ) = (n−1)Id. Eliminating Θ(E^⊥),

  (μ − ν) Θ(E) = −ν(n−1) Id,  so Θ(E) = [−ν(n−1)/(μ − ν)] Id,

which needs μ ≠ ν and nothing else. Taking traces with tr Θ(E) = 2a and tr Id = n pins the constant at **2a/n**, so Θ(E) = (2a/n) Id. **The derivation and the constant are right.** Consistency of the two expressions for the constant, −ν(n−1)n = 2a(μ − ν), is exactly aμ + (N − a)ν = 0 at N = n(n−1)/2, that is trace-freeness, which is why the Lean proof pins the coefficient through `htf` and why `hNn` is the extra hypothesis the matrix form needs. Trace-freeness is not an extra assumption here: taking the trace of Σ_α λ_α Θ(E_α) = 0 gives 2 Σ_α λ_α = 0, so Ricci-flat implies trace-free.

**Is it equivalent to Ricci-flatness or only implied by it? Equivalent, given trace-freeness.** Running the algebra backwards, if Θ(E) = (2a/n)Id then μΘ(E) + νΘ(E^⊥) = [(2a/n)(μ − ν) + ν(n−1)] Id, and that bracket vanishes precisely when aμ + (N − a)ν = 0. So within 𝒲_n the two are the same condition, and the record's "additivity of Θ turns Ricci-flatness into Θ(E) = (2a/n)Id" is exact rather than one-directional. The Lean theorem [two_eigenvalue_isotropic](../lean/HamiltonsCubic/Results/L201Statement.lean) types the forward half only, which is the half that is used.

**Decomposability is not needed for this step.** Θ(E) is defined for any subspace and given 2 needs no decomposability, so the isotropy form holds for every two-eigenvalue Weyl tensor, on or off the locus. Decomposability enters one step later, at the contraction (§10).

**D8, the missing condition.** 𝒲_n also imposes first Bianchi, Alt(W) = 0. By given 6, Alt is linear in W and Alt(Id) = 0, since the coordinate basis is decomposable and each ω ∧ ω vanishes there. Hence at two eigenvalues Bianchi reads (μ − ν) Alt(Π_E) = 0, that is Σ_{ω ∈ ONB of E} ω ∧ ω = 0, a condition on E that the record's isotropy statement does not mention. It is automatic when E carries an orthonormal **decomposable** basis, each ω ∧ ω being zero, so every use the record makes of the isotropy form is safe. It matters for the classification in [I76](../plan.md): an isotropic E without a decomposable basis must still be tested for Bianchi.

## 9. Balancedness and the pencil exclusion

**Balancedness.** With U₁ ⊥ U₂, dim U₁ = p, dim U₂ = q, p + q = n, the two summands Λ²U₁ and Λ²U₂ are Λ²-orthogonal, so additivity and Θ(Λ²U) = (dim U − 1)Π_U give Θ(E) = (p−1)Π_{U₁} + (q−1)Π_{U₂}. Since Π_{U₁} + Π_{U₂} = Id_n, this is (p−1)Id + (q−p)Π_{U₂}, isotropic iff q = p or one factor is trivial. At p = q the value is (p−1)Id, and the constant checks: a = 2C(p,2) = p(p−1) and n = 2p give 2a/n = p−1. **Both halves verified in closed form**, and the record's arithmetic 2·2C(p,2)/(2p) = p−1 is right. The same test excludes a single Λ²U with dim U = m < n, since Θ = (m−1)Π_U has rank m.

**The pencil (D4).** Θ(f ∧ U′) = r ffᵀ + Π_{U′} assumes f is a unit vector, U′ has orthonormal basis u₁,…,u_r, and **f ⊥ U′**, which is what makes {f ∧ u_i} orthonormal and hence what makes the Θ formula applicable: ⟨f∧u_i, f∧u_j⟩ = (f·f)(u_i·u_j) − (f·u_j)(u_i·f) is δ_ij only when f ⊥ U′. Its eigenvalues are then r on span{f}, 1 on U′, and 0 on the remaining n − 1 − r directions. **Isotropy therefore needs r = 1 and n − 1 − r = 0, that is n = 2.** The record's "isotropic only at r = 1" is wrong: at r = 1 and n ≥ 3 the operator is Π_{span{f,u₁}}, of rank 2 < n, and 2a/n = 2/n ≠ 1. The conclusion the record draws is nevertheless true and in fact stronger than it claims: **for n ≥ 3 no pencil eigenspace of any dimension, one included, can carry a two-eigenvalue Ricci-flat point.** The error runs in the safe direction. I add that the exclusion's reach is narrow: given 7 classifies subspaces all of whose elements are decomposable, whereas the objects [I76](../plan.md) hunts need only a decomposable basis, and Λ²U₁ ⊕ Λ²U₂ is itself not totally decomposable.

## 10. The diagonal dictionary, and the refuted comparison

**Isotropy is regularity, exactly.** On the coordinate configuration Θ(E) = Σ_{α ∈ A} Π_α is **diagonal**, with i-th entry #{α ∈ A : i ∈ α} = deg_A(i). Isotropy Θ(E) = (2a/n)Id therefore says deg_A(i) = 2a/n at every vertex, and conversely regularity of degree d makes Θ(E) = d·Id with d = 2|A|/n by the handshake identity Σ_i deg_A(i) = 2|A|. **The equivalence holds and the degree is 2|A|/n as stated.** The record argues only the forward half, by testing the quadratic form at x = e_i, and the converse needs the diagonality remark, since a quadratic form pinned on n vectors does not in general pin the operator. That is D7. The sphere product is K_p ⊔ K_q, of degrees p−1 and q−1, regular iff p = q, which is balancedness a third time, and the degree p−1 matches 2a/n. **Verified.**

**Ricci-flatness gives regular, criticality gives strong.** I checked this against the per-index relations of given 12 on the coordinate configuration, where T_αβγ = 1 exactly on the 2(n−2) ordered pairs (β,γ) = ({j,l},{i,l}) and ({i,l},{j,l}) at α = {i,j}. Relation (B) becomes Σ_{l ≠ i,j} (λ_{il} + λ_{jl}) = −2λ_{ij}, that is d_i + d_j = 0 with d_i = Σ_{l≠i} λ_{il}, hence all d_i = 0 for n ≥ 3, which is also (Sλ)_{ij} = d_i + d_j for S = A(J(n,2)) + 2Id. **So given 12(B) and given 14 agree, and at two eigenvalues d_i = deg_A(i)μ + (n−1−deg_A(i))ν = 0 with μ ≠ ν forces deg_A(i) constant. Ricci-flatness alone is regularity.** Relation (C) becomes Σ_{l ≠ i,j} λ_{il}λ_{jl} = λ_{ij}(θ − λ_{ij}), and at two eigenvalues, with regularity in hand, the edge equation is tμ² + 2(d−1−t)μν + (n−2d+t)ν² = μ(θ−μ) and the non-edge equation is t′μ² + 2(d−t′)μν + (n−2−2d+t′)ν² = ν(θ−ν). The coefficient of t and of t′ is (μ−ν)² ≠ 0 in both, so each pins its intersection number to a constant: **strong regularity, with criticality supplying exactly the strength.** The split the record claims is therefore correct. The honest qualification is that (C) does not separate cleanly: without regularity the edge equation constrains t_{ij} together with d_i + d_j, so criticality's diagonal alone does not deliver regularity, but neither is it independent of the degrees. **Screen**, on K₃ ⊔ K₃ at n = 6: the edge and non-edge equations both return θ = √10/3, which equals θ₀(6) and equals (n−1)|λ_min|, so [L107](../findings/bounds.md) is tight there, as given 17 says. The same holds at p = 4 and p = 6. This is an independent confirmation of the dictionary and of the [DGK 2023](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) correspondence as the record uses it.

**D1, the refuted sub-claim.** The record says the isotropy form "is strictly stronger than the A-regularity above, which is its contraction against Π_α". The contraction is right: tr(Π_α Θ(E)) = (2a/n)tr(Π_α) = 4a/n, and 4a/n = 2(n−1)a/N at N = C(n,2), so the constants agree, exactly as [two_eigenvalue_A_regular](../lean/HamiltonsCubic/Results/L201Statement.lean) concludes. **The word "strictly" is false.** Let 𝒮 = span{Π_α : α = 1,…,N} ⊆ Sym²ℝⁿ, with the inner product tr(AB). Then:

- Id = (n−1)^{-1} Σ_α Π_α ∈ 𝒮, by completeness,
- Θ(E) = Σ_{β ∈ A} Π_β ∈ 𝒮, by decomposability of the eigenbasis,
- so D := Θ(E) − (2a/n)Id ∈ 𝒮.

A-regularity says Σ_{β∈A} S_αβ = 4a/n at every α, that is tr(Π_α D) = 0 at every α, that is **D ⊥ 𝒮**. A vector both in 𝒮 and orthogonal to 𝒮 is zero: tr(D²) = ‖D‖_F² = 0 and D is real symmetric, so D = 0, which is isotropy. **A-regularity implies isotropy, so the two are equivalent and there is no "rest" for the matrix statement to carry.** The same argument in general form shows why: with M := Σ_α λ_α Π_α ∈ 𝒮, the scalar Ricci condition Sλ = 0 says M ⊥ 𝒮, hence M = 0, hence the matrix condition. That is precisely given 14's "Ricci-flatness … is exactly Sλ = 0", so **the record's comparison contradicts a given it lists as established and audited.** Nothing downstream breaks: the isotropy statement, the balancedness check, the pencil exclusion and the dictionary all stand, and what must be withdrawn is a sentence about relative strength. The rank remark of given 14 is consistent with this: 𝒮 has dimension rank S ≥ n, at most C(n,2) < C(n+1,2), so the Π_α never span Sym², and yet the two conditions coincide because both D and M already lie in 𝒮.

## 11. The sharp question and the witness's pair table

**Coordinate-diagonality is equivalent to coordinate-spannedness of E, given μ ≠ ν.** W = ν Id + (μ−ν)Π_E is diagonal in the basis {f_i ∧ f_j} of a frame f iff Π_E is, iff every f_i ∧ f_j is an eigenvector of Π_E, iff every f_i ∧ f_j lies in E or in E^⊥, iff E is the span of a subset of the C(n,2) forms f_i ∧ f_j. The last step uses that those forms are a basis, so the two subsets span E and E^⊥ respectively. **The equivalence holds**, and μ ≠ ν is needed only to recover E from W.

**The pair table (D2).** I computed all fifteen pairs of the rotated witness in closed form, with c = cos t, s = sin t, weights (½,½,−1,−1,½,½), so A = {ω₁,ω₂,ω₅,ω₆} is the positive eigenspace and E^⊥ = span{e₁∧e₄, e₂∧e₃}.

| pair | class | S |
|---|---|---|
| (1,2) | in E | 1 |
| (1,3), (1,4), (2,3), (2,4), (3,5), (3,6), (4,5), (4,6) | cross | 1 each |
| (3,4) | in E^⊥ | 0 |
| (5,6) | in E | 1 |
| (1,5), (2,6) | in E | cos²t |
| (1,6), (2,5) | in E | sin²t |

**All eight cross pairs are integral, each sharing a line, and every failure is inside the positive eigenspace: both of the record's load-bearing assertions hold.** But there are **four** failing pairs, not two, taking the two values cos²t and sin²t. The record's "the two failures S = cos²t and S = sin²t" is defensible as a count of values and wrong as a count of pairs, and since it is marked "checked pair by pair here", the count should be corrected to four. **Screens** confirm, in exact trigonometric form: the Λ² Gram matrix of the six forms is the identity, Sλ = 0 at every index, S1 = 6·1, Θ(E) = 2·Id = (2a/n)Id with a = 4 and n = 4, all cross commutators [Π_α,Π_β] vanish, and span{e₁∧g₂, e₁∧g₃} = e₁ ∧ span{e₂,e₃}, so E = span{e₁₂, e₁₃, e₂₄, e₃₄} in the standard frame. **The witness passes the isotropy test, is coordinate-spanned, and its two generated algebras do commute elementwise, as the record says.**

**A partial result on the sharp question**, offered as an observation and not as a claim of the record. Suppose every cross pair commutes, n ≥ 3. The algebra 𝒜 generated by {Π_β : β ∈ A^c} is a real *-algebra, being generated by symmetric elements, and every Π_α with α ∈ A lies in its commutant. If 𝒜 acted irreducibly on ℝⁿ, its commutant would be ℝ, ℂ or ℍ by Schur, and in each case the **symmetric** elements of the commutant are ℝ·Id, since the imaginary units are antisymmetric (a symmetric real J with J² = −Id is impossible). Then Π_α = cId with c² = c and trace 2, forcing n = 2. **So cross-commuting forces the algebra generated by either side's projections to be reducible**, that is ℝⁿ splits orthogonally into subspaces invariant under all of them. That is a first structural step toward the record's question and not an answer to it. I also tried to build a counterexample directly in the case E^⊥ = {span{e₁,e₂}, span{e₃,e₄}}: cross-commuting forces each E-plane to be spanned by one line in each factor, isotropy forces Σ a_i a_iᵀ = 2Π and Σ b_i b_iᵀ = 2Π on the two factors, and the only solutions I could write down are rotations inside a pencil, which span the same E as a coordinate set, exactly the witness's phenomenon. **The attempt collapsed back to coordinate-spanned, which is evidence for the record's expectation rather than against it.** I did not run a search, per the footing.

## 12. The isoclinic exclusion

**Two complex lines in ℂ² are isoclinic.** With J the complex structure, a complex line is a J-invariant 2-plane, so Π_1 and Π_2 commute with J and hence so does T = Π_1 Π_2 Π_1. If x ∈ L₁ is an eigenvector of T restricted to L₁ with eigenvalue cos²ϑ, then Jx is too, and {x, Jx} spans L₁, so T|_{L₁} = cos²ϑ · Id: the two principal angles are equal. **Correct.**

**⟨ω_1, ω_2⟩ = ±cos²ϑ.** In principal position the Λ² inner product is c₁c₂ = cos²ϑ, and the sign depends on the orientation of the second basis. So it vanishes iff cos ϑ = 0 iff L₁ ⊥ L₂. **Correct.**

**Does that exclude the family?** With the right qualification. An eigenspace E of dimension a spanned by an orthonormal decomposable basis whose planes are complex lines needs a pairwise Λ²-orthogonal set of a complex lines, hence a pairwise orthogonal set, and ℂ² has at most 2 such by dimension count. **So a ≥ 3 is excluded, which is the interesting range and the one the tight-frame idea needs.** At a = 2 the configuration exists, is L and L^⊥, and gives Θ(E) = Π_L + Π_{L^⊥} = Id = (2a/n)Id at a = 2, n = 4, a genuine isotropic decomposable subspace. It is span{e₁∧e₂, e₃∧e₄} in a suitable frame, hence coordinate-spanned, hence harmless: the graph is a perfect matching, 1-regular, and 2K₂ is strongly regular. **So the exclusion is correct for what it is for, and the precise statement is that Λ²-orthonormality caps the complex-line family at two members, where it degenerates to a coordinate configuration.** The record's conclusion, that Λ²-orthonormality is the binding constraint rather than isotropy, is well supported by this.

## 13. The kernel, and the ranges

**Claim 1** has no W in it and no eigenvalues, so ker W cannot bite. Its dimension needs are n ≥ 3, which is inert, and N = C(n,2) for the word "exactly" (§3). It does state them, through "orthonormal basis of Λ²ℝⁿ".

**Claim 2** tolerates ker W ≠ 0 and states what it needs, with one thing to spare. Kernel indices β contribute λ_β² = 0 to R_k, and at a kernel index k the conclusion reads 0 ≤ 1/2. The proof needs the bridge only for pairs (k,β) with λ_β ≠ 0, so **the hypothesis can be weakened from "carries an orthonormal decomposable eigenbasis" to "ω_k is decomposable and so is every eigenvector with nonzero eigenvalue"**, since the unit-norm step Σ_{β≠k} λ_β² = 1 − λ_k² is insensitive to the kernel's basis. The test's contrapositive is therefore stronger than advertised: it excludes even the weaker property. Padded W_CP² is the case in point, its kernel being three-dimensional at n = 4 and larger after padding, and the test still applies because λ_max belongs to a nonzero eigenvalue.

**Claim 3 silently excludes the kernel.** With exactly two eigenvalues and trace-freeness aμ + (N−a)ν = 0, if ν = 0 then aμ = 0 and W = 0. So **a nonzero two-eigenvalue Weyl tensor has ker W = 0**, and the isotropy machinery never applies to an operator with a kernel. This is worth stating because it separates the record's claims: padded W_CP² has three eigenvalues, {2c, −c, 0}, so §8 to §12 do not touch it and §6's test is the only tool the record has there. The other ranges claim 3 needs are μ ≠ ν, stated; 0 < a < N, unstated but implied by "two eigenvalues"; and N = C(n,2), stated, and flagged in [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) as "the one extra hypothesis the matrix form needs". The dictionary's step from A-regularity to constant degree additionally needs n ≥ 3, since d_i + d_j constant for all i ≠ j forces all d_i equal only then.

## 14. What would break each claim, and what I did

**Claim 1** would break on a Λ²-orthogonal pair of decomposable unit forms with S ∈ {0,1} and [Π_α,Π_β] ≠ 0, or on an integral orthonormal decomposable basis lying in no common frame. No such pair exists: §1 computes the commutator in closed form, all four terms of the product accounted for, and the identity is exact, so the equivalence of §2 is exact and §3 closes it. I looked instead for the boundary of the hypothesis and found it: the isoclinic 45° pair of §2 has S = 1 with ‖C‖_F² = 1, so the hypothesis is not decoration, and the general identity ½Σ_i sin²(2ϑ_i) shows the 2S(1−S) form holds exactly on the orthogonal locus. I also tested the word "exactly" against a proper subfamily, {Π_{12}, Π_{34}} in ℝ⁴, which satisfies everything but is not all of a frame's planes, which locates the one place completeness is needed.

**Claim 2** would break on a critical unit-norm Weyl tensor with an orthonormal decomposable eigenbasis and θλ_k > (1 + λ_k²)/2 at some index. That would require S_kβ > 1 at some pair, impossible under Λ²-orthogonality, or a failure of [L199](../findings/bounds.md) or of the bridge, both given. I tested the bound positively instead, at the balanced products, the only decomposable critical family in the givens: at S³ × S³, θλ_max = 1/3 against 11/20; at S⁴ × S⁴, 1/4 against 11/21; at S⁶ × S⁶, 1/6 against 28/55. **It holds everywhere with a factor of about three to spare, so nothing in the givens is near it.** The object that would make the corollary earn its name is a critical point with θλ_max ∈ (5/6, 1] and no pinned eigenvector, and finding one is a search: **blocked by the footing, and I stopped.** What a run would decide, and what each outcome would mean, is in §6.

**Claim 3** would break on an E with Θ(E) isotropic, carrying an orthonormal decomposable basis whose complement carries one too, whose span meets no frame. I attacked it from the cross-commuting side, which the record names as the sharpest form, and got two things: the Schur reduction of §11, which says one side's projections generate a reducible algebra, and a closed-form attempt at n = 4 that collapsed to a rotation inside a pencil and hence to a coordinate span, the witness's own phenomenon. **Neither breaks the claim and neither settles the question.** The sub-claim I did break, D1, I broke by writing out what A-regularity says as an orthogonality relation and noticing that D lies in the very space it is orthogonal to. I did not search for anything.

## Verdict

**Claim 1: HOLDS, every link.** The commutator identity is exact, its derivation in principal position is correct term by term, Λ²-orthogonality is exactly the condition under which the 2S(1−S) form is true, integrality is exactly commutativity, the two-line proof of L201 is valid and is strictly more economical in hypotheses than the conclusion needs, and the bound is exactly the positivity of that sum of squares with the diagonal accounted correctly. Two repairs, both wording: read integrality at distinct pairs (D5), and record that ‖·‖_F is the plain Frobenius norm, under which the constant is 2, the record's Λ² normalisation giving 1 (D9). Recommend adding the two counting lines that make "exactly" true, and recording the general identity ½Σ_i sin²(2ϑ_i) alongside, since it is what identifies the result as the classical two-projection statement and it is one line.

**Claim 2: HOLDS, with two figures to correct.** R_k ≤ 1 − λ_k² is right, hollowness kills the diagonal term and unit norm supplies the rest, and θλ_k ≤ (1 + λ_k²)/2 follows at every index. Padded W_CP²'s figures are exact as published: λ_max = 2/√6, θλ_max = 1, bound 5/6. **Correct λ_max = 0.1349 to 1/√55 = 0.1348400 and the bound 3.774 to 28√55/55 = 3.775519** (D3). Add the line λ_max² < 1, from trace-freeness, that the strictness and the "sharp only off the locus" claim both rest on (D6). The test's exclusion power beyond the one-eigenvector Plücker argument is not demonstrated by anything in the claim, and the record should say so where it says the test is what the result is for.

**Claim 3: HOLDS EXCEPT D1, WHICH IS REFUTED.** Θ(E) = (2a/n)Id is right, and it is equivalent to Ricci-flatness given trace-freeness rather than merely implied by it. Balancedness and the constant p−1 check exactly. The pencil exclusion's conclusion is right and its stated reason is not: no pencil is isotropic at n ≥ 3, r = 1 included (D4). The diagonal dictionary is exact in both directions once diagonality is noted (D7), and the split of the DGK correspondence into regularity from Ricci-flatness and strength from criticality is correct, which I confirmed by rederiving both srg conditions from relations (B) and (C) and by checking that the resulting θ at K_p ⊔ K_q equals θ₀(2p) with L107 tight. The sharp question's equivalence, coordinate-diagonal iff coordinate-spanned, holds. The witness's cross pairs are all integral and all its failures are within the positive eigenspace, but there are four of them, not two (D2). **The sentence "This is strictly stronger than the A-regularity above" must be withdrawn: for a complete orthonormal decomposable configuration the two are equivalent, because Θ(E) − (2a/n)Id lies in the span of the Π_α and A-regularity says it is orthogonal to that span. Given 14 of the brief already asserts as much.** Nothing built on the isotropy form falls with it. Two additions for the record: at exactly two eigenvalues ker W = 0 automatically, so claims 2 and 3 address disjoint spectral types (§13), and first Bianchi at two eigenvalues is the separate condition Alt(Π_E) = 0, free on the decomposable locus and not free off it (D8).
