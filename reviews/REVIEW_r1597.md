# Review r1597: L126's four-set blocks are orbit-free (L126Orbit), commit bd7157c9, and the L126 row

**Standfirst.** The new file defines the orbit tangent `orbitTan M j k`, Y ↦ [φ_jk, M Y] − M [φ_jk, Y], and proves at a diagonal M = `diagOp w` (w symmetric only) that it is orthogonal, in WeylReal's `innerOp`, to φ_ab ⊙ φ_cd for every two disjoint pairs, so to each of the three operators spanning a four-set block. That is the conjugation derivative of the adjoint action with the right sign, and orthogonality of every generator's tangent to the four-set block is exactly what L126 spends: a ½-eigenvector lying in a four-set block has no component along the orbit. `innerOp_rk2` is correct under the ½-over-ordered-pairs normalisation. The build succeeds and the audit reads 5/5 on the standard three. The row is honest that the record's stronger pair-block containment is owed. Two minor downstream gaps: the record's L126 block carries no machine-checked pointer for the orbit clause, and the L126 (statement) row still lists orbit-freeness as a need without saying it is now proved.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `orbitTan (diagOp w) j k` is the orbit tangent of M under Ad of so(n) on Λ², with ρ(X) = [X, ·] and the operator action ρ(X)∘M − M∘ρ(X) | **CONFIRMED** |
| A-2 | `innerOp_rk2`: ⟨F, U ⊙ V⟩ = ⟨F V, U⟩ + ⟨F U, V⟩ with `innerOp` = ½ Σ over ordered pairs | **CONFIRMED** |
| A-3 | `orbit_perp_pair` and `orbit_perp_fourSet` establish what L126 spends, that a four-set ½-eigenvector is not an orbit direction | **CONFIRMED** |
| A-4 | no hypothesis of hollowness, zero row sums, criticality or Weyl is used (w symmetric only) | **CONFIRMED** |
| A-5 | the L126 row is honest that the pair-block containment is owed | **CONFIRMED** |
| B | `lake build HamiltonsCubic.Results.L126Orbit` succeeds with no warning from the file, audit 5/5 on propext, Classical.choice, Quot.sound, no `sorry`, no `native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAPS** (second-order.md:1699 has no pointer, lean/INDEX.md:483 reads as if orbit-freeness were unproved) |
| D | style | **CONFIRMED** |

**Summary:** L126Orbit proves the orthogonality half of L126's orbit-freeness faithfully on the standard three, with the stronger pair-block form honestly owed and two small pointer gaps downstream.

## 1. Files and rows carrying the id

- `lean/HamiltonsCubic/Results/L126*.lean`: [L126.lean](../lean/HamiltonsCubic/Results/L126.lean), [L126Kernel.lean](../lean/HamiltonsCubic/Results/L126Kernel.lean), [L126Sphere.lean](../lean/HamiltonsCubic/Results/L126Sphere.lean), [L126Statement.lean](../lean/HamiltonsCubic/Results/L126Statement.lean), and the new [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean). The L121 family ([L121.lean](../lean/HamiltonsCubic/Results/L121.lean), [L121Block.lean](../lean/HamiltonsCubic/Results/L121Block.lean), [L121Bianchi.lean](../lean/HamiltonsCubic/Results/L121Bianchi.lean), [L121Statement.lean](../lean/HamiltonsCubic/Results/L121Statement.lean)) supplies `rk2`, `fourSet_G` and the namespace the new file extends.
- The feat commit bd7157c9 has landed and was reviewed. It adds the file, imports it in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), rewrites the L126 row at [lean/INDEX.md:482](../lean/INDEX.md#L482), and bumps counts in STATUS.md and plan-lean.md.

## 2. Fidelity against Lemma L126

**The orbit tangent (A-1).** SO(n) acts on Λ² by g·Y = gYgᵀ, whose derivative at the identity along X ∈ so(n) is ρ(X)Y = XY − YX = `br X Y`. On operators the action is g·M = ρ(g) M ρ(g)⁻¹, whose derivative is ρ(X)∘M − M∘ρ(X). Applied to Y this is [X, MY] − M[X, Y], which is `orbitTan M j k` at X = φ_jk ([L126Orbit.lean:29-30](../lean/HamiltonsCubic/Results/L126Orbit.lean#L29)). This is the record's own commutator [ρ(E_jk), W] at [second-order.md:1798](../findings/second-order.md#L1798), with the same order. The sign of φ_jk (WeylReal's `single j i − single i j` convention) only rescales the generator and is idle for a span or orthogonality statement.

**The pairing (A-2).** WeylReal's `innerOp R S = ½ Σ_{i,j} ⟨R φ_ij, S φ_ij⟩` over ordered pairs ([WeylReal.lean:135](../lean/HamiltonsCubic/Base/WeylReal.lean#L135)), with ⟨φ_ij, φ_ij⟩ = 1 under `inner2 = ½ tr(XᵀY)`. `rk2 U V φ = ⟨V,φ⟩U + ⟨U,φ⟩V` ([L121Block.lean:102](../lean/HamiltonsCubic/Results/L121Block.lean#L102)). Hand check: Σ over ordered (i,j) of ⟨P,φ_ij⟩φ_ij is 2P for skew P, which is `skew_expand`, so ½ Σ ⟨V,φ_ij⟩⟨Fφ_ij, U⟩ = ⟨FV, U⟩ by linearity of F, and likewise the other term. The statement is ⟨FV,U⟩ + ⟨FU,V⟩, as proved. Linearity is carried by `IsLinOp`, and `lin_sum` extends it to finite sums correctly.

**Orthogonality (A-3).** At M = `diagOp w` with w symmetric, M φ_cd = w_cd φ_cd and M is self-adjoint, so ⟨T φ_cd, φ_ab⟩ = (w_cd − w_ab)⟨[φ_jk, φ_cd], φ_ab⟩. The bracket lies in the span of φ_kd, φ_jc, φ_kc, φ_jd, each carrying c or d, and ⟨φ_xy, φ_ab⟩ ≠ 0 needs {x,y} = {a,b}, so disjointness of {a,b} and {c,d} kills it. That is `orbit_perp_pair` exactly. Degenerate cases a = b or c = d are admitted and trivially true, since φ_aa = 0. `orbit_perp_fourSet` then combines the two orderings through `innerOp_rk2`. The three operators of `fourSet_G`, rk2(φ_ij, φ_kl), rk2(φ_ki, φ_jl), rk2(φ_il, φ_jk), are all of the form φ_ab ⊙ φ_cd with disjoint pairs at four distinct indices, so each four-set block is orthogonal to every T_jk, hence to their span, which is the orbit's tangent space (the tangent along Σ a_jk E_jk is Σ a_jk T_jk, linearity in the generator being immediate from bilinearity of `br`). A nonzero ½-eigenvector inside a four-set block is therefore not an orbit direction, which is the use L126 makes of orbit-freeness when it reads ker DF(M) modulo the orbit. The pairing is the same `innerOp` that [L126Kernel.lean](../lean/HamiltonsCubic/Results/L126Kernel.lean) reads the kernel against, so the two halves compose without a change of inner product.

**Hypotheses (A-4).** Only `hw : ∀ p q, w p q = w q p` enters, through `diagOp_phi`. `diagOp_selfAdjoint` needs nothing. Hollowness, row sums, criticality, θ and the Weyl conditions are absent, as they should be: orthogonality is a property of any pair-diagonal M.

**Honesty of the row (A-5).** [lean/INDEX.md:482](../lean/INDEX.md#L482) claims "the orbit-freeness the lemma spends", describes it as orthogonality, and lists as owed "the record's stronger form, the orbit tangent for the (j,k) generator lies in the {j,k} pair block". The commit also deleted the earlier "which is proved nowhere", which was inaccurate on paper: the containment has a written proof at [second-order.md:1798](../findings/second-order.md#L1798) (L128 (i)), and "owed" now refers to Lean alone. The docstring at [L126Orbit.lean:19](../lean/HamiltonsCubic/Results/L126Orbit.lean#L19) says the same.

## 3. Soundness

- `cd lean && ~/.elan/bin/lake build HamiltonsCubic.Results.L126Orbit`: "Build completed successfully (8714 jobs)". The only info lines come from L121Block.lean:216 (a flexible-`simp` linter note, pre-existing), none from the new file.
- `python3 scripts/misc/axiom_audit.py --only L126Orbit.lean`: "5/5 clean -- resting on the standard three alone".
- No `sorry` and no `native_decide` in the file.

## 4. Downstream

1. **[second-order.md:1699](../findings/second-order.md#L1699)**: the L126 block's statement carries a machine-checked note for the kernel clause (`critMap_hasDerivAt`, `critMap_kernel_iff`) but none for "The four-set blocks are orbit-free". A parenthetical pointing at `orbit_perp_fourSet` in [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean), scoped to the orthogonality form, would match the kernel clause's treatment.
2. **[lean/INDEX.md:483](../lean/INDEX.md#L483)**: the L126 (statement) row says the μ_{p,q}-eigenvalue claim is "not typed, needing DF(M) = θ(2L_e − Id) and orbit-freeness". Both inputs are now proved (L126Kernel.lean and L126Orbit.lean), and the row reads as if they were not. What remains is the assembly the L126 row names.
3. [findings/INDEX-results.md:142](../findings/INDEX-results.md#L142), plan-lean.md and STATUS.md carry no orbit-specific text that the commit leaves stale.

## 5. Style

- No em dash in the new file, the new row text, or the commit message. No backticks inside markdown link text. The row is one line.
- The one semicolon in the new row text ("Lemma L126); and the assembly") separates two owed items that themselves carry commas, the list use the convention permits.

## 6. Verdict

**CONFIRMED WITH GAPS.** The formalisation is faithful and sound. Gaps are the two pointer repairs in section 4, items 1 and 2.
