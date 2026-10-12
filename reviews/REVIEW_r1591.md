# Review r1591: L121's four-set block is ½G (L121Block), commit e78762c8

**Standfirst.** The new file is faithful to Lemma L121 and sound. `foxProd` is the record's X ∘ Y = ½(Q(X+Y) − Q(X) − Q(Y)) from conventions.md, `rk2 U V` is the symmetric product φ ⊙ ψ as the self-adjoint operator X ↦ ⟨V,X⟩U + ⟨U,X⟩V, `diagOp w` at symmetric w is the record's pair-diagonal M with M_ab = w_ab, and the three columns of `fourSet_G` in the signed basis (φ_ij ⊙ φ_kl, φ_ki ⊙ φ_jl, φ_il ⊙ φ_jk) are exactly ½(A,C,B), ½(C,B,A), ½(B,A,C), the columns of ½G. `fourSet_bianchi` uses the layer's `bianchi` and gives x + y + z, the record's y₁ + y₂ + y₃ = 0. `sharpCross_rk2` states its hypotheses honestly. The build is clean apart from one `show` linter warning, the audit reads 22/22 on the standard three, and a screen at n = 6 with the record library's R# agrees with ½G to 7e-16 at a non-hollow w. Four minor gaps remain: the invariance of the span and "the block is ½G" as a linear map rest on second-slot linearity of ∘, which the layer proves in FoxBilinear.lean but the file never invokes; `fourSet_bianchi` checks one Bianchi tuple while the docstring says it cuts out the subspace; the L121 statement row and L121Statement.lean still give "needs ∘" as the reason the identification is absent; and the L126 row's owed list omits the record's orbit-freeness clause. Three semicolon splices are style.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `foxProd` is the record's ∘ and L_M = M ∘ · | **CONFIRMED** |
| A-2 | `rk2 U V` is φ ⊙ ψ as a self-adjoint operator on Λ², the element of the four-set space | **CONFIRMED** |
| A-3 | `diagOp w` at symmetric w is the pair-diagonal M, and hollowness, Ricci-flatness and criticality are not needed | **CONFIRMED** |
| A-4 | `sharpCross_rk2`: R # (U ⊙ V) X = ½([U,R[X,V]] + [V,R[X,U]]) at linear, self-adjoint, bivector-preserving R and bivectors U, V, X | **CONFIRMED** (self-adjointness is quantified over all matrices, stated honestly) |
| A-5 | `fourSet_block`: M ∘ H_A = ½(A H_A − C H_B + B H_C) on every bivector | **CONFIRMED** |
| A-6 | `fourSet_G`: signed basis columns are those of ½G, the record's diag(1,−1,1) flip | **CONFIRMED** |
| A-7 | "so the four-set space is invariant under L_M and the block is ½G" | **CONFIRMED WITH GAP** (needs linearity of M ∘ · on the span, proved in the layer but not invoked) |
| A-8 | `fourSet_bianchi`: the Bianchi subspace of the four-set space is 1^⊥ | **CONFIRMED WITH GAP** (one tuple (i,j,k,l) typed, the rest of the Bianchi conditions argued nowhere) |
| A-9 | the L121 row: both imported facts proved, only the sphere normalisation owed | **CONFIRMED WITH GAP** (inherits A-7 and A-8) |
| A-10 | the L126 row: owed is only the assembly into one statement | **CONFIRMED WITH GAP** (orbit-freeness, a clause of the lemma, is typed nowhere and not listed) |
| B | `lake build HamiltonsCubic.Results.L121Block`, axiom audit 22/22 on propext, Classical.choice, Quot.sound, no `sorry` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAP** (L121 statement row and L121Statement.lean give a stale reason) |
| D | style | **CONFIRMED WITH GAP** (three semicolon splices, one `show` linter warning) |

**Summary:** L121Block proves the record's ½G block and its Bianchi cut faithfully on the standard three, and the gaps are an uninvoked linearity step, a one-tuple Bianchi check read as the whole subspace, a stale reason in the L121 statement row, and an owed item missing from the L126 row.

## 1. Files and rows carrying the id

- [L121.lean](../lean/HamiltonsCubic/Results/L121.lean) (G's spectrum), [L121Statement.lean](../lean/HamiltonsCubic/Results/L121Statement.lean) (typed statement), and the new [L121Block.lean](../lean/HamiltonsCubic/Results/L121Block.lean), identical in the working tree and at e78762c8.
- [L122.lean](../lean/HamiltonsCubic/Results/L122.lean) and [L122Statement.lean](../lean/HamiltonsCubic/Results/L122Statement.lean), untouched by this commit and about the pair block.
- [L126.lean](../lean/HamiltonsCubic/Results/L126.lean), [L126Kernel.lean](../lean/HamiltonsCubic/Results/L126Kernel.lean), [L126Sphere.lean](../lean/HamiltonsCubic/Results/L126Sphere.lean), [L126Statement.lean](../lean/HamiltonsCubic/Results/L126Statement.lean).
- Rows: L121 at [lean/INDEX.md:353](../lean/INDEX.md#L353), L121 (statement) at [:354](../lean/INDEX.md#L354), L122 at [:356](../lean/INDEX.md#L356), L126 at [:481](../lean/INDEX.md#L481), L126 (statement) at [:482](../lean/INDEX.md#L482). The commit edits the rows at 353 and 481.

## 2. Fidelity against Lemma L121

- **The product.** [second-order.md:1187](../findings/second-order.md#L1187) writes L_M and conventions.md defines X ∘ Y = ½(Q(X+Y) − Q(X) − Q(Y)). [FoxProduct.lean:217](../lean/HamiltonsCubic/Base/FoxProduct.lean#L217) is that with `Qop R = R² + sharpOp R`, and `foxProd_split` reduces it to the Jordan half plus `sharpCross`. The normalisation of `sharpOp` as R# is the layer's (`sharpQF`, the ¼ being ½ times the ordered-pair ½) and matches scripts/lib/curvature_operator.py's −½ Σ over unordered pairs.
- **The four-set space.** Its elements are the symmetric products φ_ij ⊙ φ_kl in Sym²(Λ²), read as self-adjoint operators. `rk2 U V` ([L121Block.lean:104](../lean/HamiltonsCubic/Results/L121Block.lean#L104)) is X ↦ ⟨V,X⟩U + ⟨U,X⟩V with the layer's `inner2`, under which φ_ab is a unit vector, so rk2 at basis bivectors is the matrix e_a e_bᵀ + e_b e_aᵀ in the orthonormal pair basis. Same object.
- **Pair-diagonal M.** `diagOp w` is the Hadamard product with w, so at symmetric w it sends φ_ab to w_ab φ_ab (`diagOp_phi`), which is diag(M_ab) on the pair basis. The diagonal of w never meets a bivector, so hollowness is idle, and no row sum enters any proof. This matches the record's "diagonality alone, with no criticality and no row sum". The screen used a w with nonzero diagonal and nonzero row sums.
- **The columns.** In the signed basis a = φ_ij ⊙ φ_kl, b = φ_ki ⊙ φ_jl, c = φ_il ⊙ φ_jk, `fourSet_G` ([:252](../lean/HamiltonsCubic/Results/L121Block.lean#L252)) gives M ∘ a = ½(A a + C b + B c), M ∘ b = ½(C a + B b + A c), M ∘ c = ½(B a + A b + C c). Reading coefficients as columns gives [[A,C,B],[C,B,A],[B,A,C]], which is G, symmetric, so rows and columns agree. With b' = φ_ik ⊙ φ_jl = −b, `fourSet_block`'s −C H_B is +C b, the record's diag(1,−1,1) conjugation. A, B, C are the opposite-pair sums w_ij + w_kl, w_ik + w_jl, w_il + w_jk. The second and third columns come from `fourSet_block` at (k,i,j,l) and (i,l,j,k), with the distinctness hypotheses permuted correctly (the kernel accepts them).
- **Bianchi.** `fourSet_bianchi` ([:273](../lean/HamiltonsCubic/Results/L121Block.lean#L273)) unfolds the layer's `bianchi` ([WeylReal.lean:110](../lean/HamiltonsCubic/Base/WeylReal.lean#L110)). By hand: a(φ_ij) = φ_kl pairs to 1 with φ_kl, b(φ_ik) = −φ_jl pairs to +1 with φ_lj, c(φ_il) = φ_jk pairs to 1 with φ_jk, giving x + y + z, and the raw b' would give x − y + z as the record says.
- **Gap A-7.** The docstring ([:25](../lean/HamiltonsCubic/Results/L121Block.lean#L25)) and the L121 row conclude that the span is invariant and the block is ½G. `fourSet_G` gives the images of the three basis vectors. Passing to M ∘ (x a + y b + z c) needs M ∘ · additive and homogeneous in its second slot. That is proved at linear arguments as `foxProd_add_right` and `foxProd_smul_right` in [FoxBilinear.lean:122](../lean/HamiltonsCubic/Base/FoxBilinear.lean#L122), which L121Block neither imports nor cites, and [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s header still calls bilinearity owed. The step is one application, so the gap is presentational, but the invariance sentence is stronger than any theorem in the file.
- **Gap A-8.** The record's "the Bianchi subspace is 1^⊥" means the joint zero set of all first-Bianchi conditions. The file types the condition at the single tuple (i,j,k,l) and its docstring ([:271](../lean/HamiltonsCubic/Results/L121Block.lean#L271)) reads it as the subspace. The remaining tuples are harmless (a tuple meeting an index outside the set, or repeating one, gives 0 because the operators' ranges and supports lie in the six in-set bivectors, and a permutation of (i,j,k,l) gives ±(x + y + z) by the antisymmetry of the Bianchi sum for a pair-symmetric operator), but that argument is written nowhere.
- **A-4, the hypotheses of `sharpCross_rk2`** ([:164](../lean/HamiltonsCubic/Results/L121Block.lean#L164)): `IsLinOp R`, `hsa : ∀ A B, ⟨R A, B⟩ = ⟨A, R B⟩`, `hsk` bivector preservation, and U, V, X skew. All three R-hypotheses are used (`hsk` for `resolve` at [R[Y,U]], `hsa` in `T_rk2_R` and `mixed_rk2`). `hsa` is quantified over all matrices, stronger than IsWeyl's bivector-restricted symmetry, so the theorem applies to a Weyl operator only after restriction. The statement says exactly what it assumes, and `diagOp w` meets it on all matrices (`diagOp_selfAdjoint`), so this is an observation about reach and no gap for L121.

## 3. Soundness

- `cd lean && ~/.elan/bin/lake build HamiltonsCubic.Results.L121Block`: success, 8712 jobs, one warning, the `show` linter at [:227](../lean/HamiltonsCubic/Results/L121Block.lean#L227) asking for `change`.
- `python3 scripts/misc/axiom_audit.py --only L121Block.lean`: 22/22 clean, resting on propext, Classical.choice, Quot.sound. No `sorry`, `admit` or `native_decide` in the file.
- **Screen, not evidence.** At n = 6 and a random symmetric w with nonzero diagonal, with R# from scripts/lib/curvature_operator.py and M ∘ H = ½(Q(M+H) − Q(M) − Q(H)), the residual of M ∘ (a, b, c) against the columns of ½G is 6.7e-16 at three index tuples. This rules out a sign or factor slip between the Lean `sharpOp` and the record's R# at this object only.

## 4. Downstream

- **Stale reason.** [lean/INDEX.md:354](../lean/INDEX.md#L354), the L121 (statement) row, says the identification "is not typed, needing ∘", and [L121Statement.lean:55](../lean/HamiltonsCubic/Results/L121Statement.lean#L55) says it "needs the Fox product ∘ and the operator L_M, which WeylReal does not carry", and lists the Bianchi cut and the diag(1,−1,1) conjugacy as absent. The statement file still omits them, but ∘ now exists and all three are proved in L121Block, so the row and the file should point there.
- **L126 row.** [lean/INDEX.md:481](../lean/INDEX.md#L481) now reads "Owed: the assembly of `fourSet_sigma`, L121's spectrum on 1^⊥, `fourSet_G` and `L126_threshold` into one statement". The lemma ([second-order.md:1687](../findings/second-order.md#L1687)) also asserts that the four-set blocks are orbit-free, which no L126 file types ([L126Statement.lean:54](../lean/HamiltonsCubic/Results/L126Statement.lean#L54) lists it as needing more than the layer), and the assembly passes from L_M units to L_e = L_{M/θ}, which needs first-slot homogeneity of ∘. The row's "owed" should name orbit-freeness. The same omission stood in the row before this commit, and the commit message's "L126 owes only the assembly" repeats it.
- **Checked and consistent.** The L122 row (:356) concerns the pair block and is unaffected. The L127 row (:495) names L_e spectra generally and makes no claim about the four-set identification. [second-order.md:130](../findings/second-order.md#L130) cites `L125_fourSet` "given L121's block value", which still describes that theorem's hypothesis correctly. [INDEX-results.md:137](../findings/INDEX-results.md#L137) makes no Lean claim about the identification. L126Sphere.lean's header cites L121 for the threshold and claims nothing untyped.

## 5. Style

- No em dashes in the file or the two edited rows, and no backticks inside link text.
- Semicolon clause splices: [L121Block.lean:11](../lean/HamiltonsCubic/Results/L121Block.lean#L11) ("proves G's spectrum; this file proves"), [:28](../lean/HamiltonsCubic/Results/L121Block.lean#L28) ("of a symmetric weight w; neither hollowness"), and [lean/INDEX.md:353](../lean/INDEX.md#L353) ("which is 1^⊥; 22/22 on the standard three"). The other semicolons in the row separate list items that carry commas.
- Markdown rows are single lines.

## 6. Verdict

**CONFIRMED WITH GAPS.**

1. [L121Block.lean:25](../lean/HamiltonsCubic/Results/L121Block.lean#L25) and [lean/INDEX.md:353](../lean/INDEX.md#L353): invariance and "the block is ½G" need `foxProd_add_right`/`foxProd_smul_right` ([FoxBilinear.lean:122](../lean/HamiltonsCubic/Base/FoxBilinear.lean#L122)), not invoked.
2. [L121Block.lean:271](../lean/HamiltonsCubic/Results/L121Block.lean#L271): one Bianchi tuple is typed and read as the whole Bianchi subspace.
3. [lean/INDEX.md:354](../lean/INDEX.md#L354) and [L121Statement.lean:55](../lean/HamiltonsCubic/Results/L121Statement.lean#L55): stale "needs ∘" reason, with no pointer to L121Block.
4. [lean/INDEX.md:481](../lean/INDEX.md#L481): the L126 row's owed list omits orbit-freeness.
5. Style: semicolon splices at [L121Block.lean:11](../lean/HamiltonsCubic/Results/L121Block.lean#L11), [:28](../lean/HamiltonsCubic/Results/L121Block.lean#L28) and [lean/INDEX.md:353](../lean/INDEX.md#L353), and the `show` linter warning at [L121Block.lean:227](../lean/HamiltonsCubic/Results/L121Block.lean#L227).
