# Review r1598: L126 assembled at the sphere product (L126Assembly), commit 35a3cc2e, and orbit_in_pairBlock, commit 04c1dd04

**Standfirst.** The new file proves at a (2,2)-split i, j ∈ T, k, l ∉ T of M = `diagOp (t • sphereWeight T)` that the cross sums agree, B = C = −2t, that the Bianchi vector v = 2a − b − c in L121Block's signed basis satisfies M ∘ v = ½(A − B) v on every bivector, and that ((A − B)/(2θ))² = μ_{p,q}² at unit norm. Checked by hand against G = [[A,C,B],[C,B,A],[B,A,C]] at B = C, v is the right eigenvector, and b − c is the second Bianchi eigenvector at −½(A − B), as the row says. The build succeeds, the audits read 3/3 and 6/6 on the standard three, and `orbit_in_pairBlock` is the record's pair-block containment with the convention-dependent sign. Gaps are downstream and one of scope: the Lean fixes only the modulus, while A − B > 0 at t > 0 pins v to +μ_{p,q}, the sign the ½-threshold reads, and the row does not list that as owed. The L126 (statement) row, the L126Statement docstring and the record's sphere-product clause were not updated for the assembly.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `split_B_eq_C`: at a (2,2)-split of `t • sphereWeight T`, B = C = −2t | **CONFIRMED** |
| A-2 | `split_eigen`: v = 2a − b − c is the right Bianchi vector and M ∘ v = ½(A − B) v on every bivector | **CONFIRMED** |
| A-3 | `split_value`: ((A − B)/(2θ))² = μ_{p,q}², so v is an L_e-eigenvector (L_e = θ⁻¹ M ∘ ·) with eigenvalue of modulus μ_{p,q} | **CONFIRMED** |
| A-4 | the hypotheses (unit sphere product, 0 < t, \|T\|, \|Tᶜ\| ≥ 2, i, j ∈ T, k, l ∉ T, i ≠ j, k ≠ l) are the record's | **CONFIRMED** |
| A-5 | the row's Owed list: the (4,0) and (3,1) blocks, b − c at −½(A − B), the bridge to `LeLin` on `CurvOp2` | **CONFIRMED WITH GAPS** (all three correctly owed, b − c's sign checked by hand, and the sign of the eigenvalue on v is owed but unlisted) |
| A-6 | `orbit_in_pairBlock`: T_jk = Σ_i (w_ji − w_ki) φ_ji ⊙ φ_ki at j ≠ k is the record's pair-block containment | **CONFIRMED** |
| A-7 | second-order.md's machine-checked note on the orbit clause | **CONFIRMED** |
| B | builds succeed, audits 3/3 and 6/6 on propext, Classical.choice, Quot.sound, no `sorry`, no `native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAPS** (lean/INDEX.md:483, L126Statement.lean:50-57, second-order.md:1701) |
| D | style | **CONFIRMED WITH GAPS** (one pre-existing clause splice in the rewritten row 482) |

**Summary:** L126Assembly proves faithfully, on the standard three, that each (2,2)-split carries a Bianchi L_e-eigenvector of modulus μ_{p,q}, and orbit_in_pairBlock is the record's pair-block form. The sign of the eigenvalue and three downstream pointers are left open.

## 1. Files and rows carrying the id

- [L126Assembly.lean](../lean/HamiltonsCubic/Results/L126Assembly.lean) is new, from commit 35a3cc2e, which also imports it in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), rewrites the L126 row at [lean/INDEX.md:482](../lean/INDEX.md#L482) and bumps file counts in STATUS.md and plan-lean.md.
- The L126 family also holds [L126.lean](../lean/HamiltonsCubic/Results/L126.lean), [L126Kernel.lean](../lean/HamiltonsCubic/Results/L126Kernel.lean), [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean), [L126Sphere.lean](../lean/HamiltonsCubic/Results/L126Sphere.lean) and [L126Statement.lean](../lean/HamiltonsCubic/Results/L126Statement.lean). The L121 family ([L121.lean](../lean/HamiltonsCubic/Results/L121.lean), [L121Block.lean](../lean/HamiltonsCubic/Results/L121Block.lean), [L121Bianchi.lean](../lean/HamiltonsCubic/Results/L121Bianchi.lean), [L121Statement.lean](../lean/HamiltonsCubic/Results/L121Statement.lean)) supplies `fourSet_span` and `fourSet_bianchi_iff`.
- Commit 04c1dd04 adds `orbit_in_pairBlock` to L126Orbit.lean, a machine-checked note to [second-order.md:1699](../findings/second-order.md#L1699), and rewrites the L126 (statement) row at [lean/INDEX.md:483](../lean/INDEX.md#L483).

## 2. Fidelity against Lemma L126

**B = C (A-1).** `sphereWeight T` is q/(p−1) within T, p/(q−1) within Tᶜ and −1 across ([Families.lean:308](../lean/HamiltonsCubic/Base/Families.lean#L308)). At i, j ∈ T and k, l ∉ T the four cross entries w_ik, w_jl, w_il, w_jk are all −t, so B = C = −2t. The proof is exactly this.

**The eigenvector (A-2), by hand.** `fourSet_span` gives M ∘ (x a + y b + z c) = ½ G (x, y, z) with G = [[A,C,B],[C,B,A],[B,A,C]] in the basis a = φ_ij ⊙ φ_kl, b = φ_ki ⊙ φ_jl, c = φ_il ⊙ φ_jk. At B = C, G (2, −1, −1) = (2A − 2B, 2B − B − A, 2B − A − B) = (A − B)(2, −1, −1), so M ∘ v = ½(A − B) v. The Lean `v` is `2 • rk2 (phi i j) (phi k l) + (−1) • rk2 (phi k i) (phi j l) + (−1) • rk2 (phi i l) (phi j k)`, which is 2a − b − c in that basis. `fourSet_bianchi_iff` at (2, −1, −1) gives first Bianchi at every tuple since 2 − 1 − 1 = 0. L121's Bianchi part is 𝟏^⊥, two-dimensional, and at B = C it is spanned by v and b − c, so v is a genuine Bianchi eigenvector and not merely a vector in the span.

**The second eigenvector, sign checked (A-5).** G (0, 1, −1) = (C − B, B − A, A − C) = (0, −(A − B), A − B) at B = C, which is −(A − B)(0, 1, −1). So b − c sits at −½(A − B), as the row states. On 𝟏^⊥, Σ = A² + B² + C² − AB − BC − CA reduces at B = C to (A − B)², so the pair ±½(A − B) is L121's ±½√Σ, consistent with `fourSet_sigma`.

**The value (A-3).** With L_e = θ⁻¹ M ∘ ·, v's L_e-eigenvalue is λ = (A − B)/(2θ), and λ² = Σ/(4θ²) = ((n−2)/((p−1)(q−1)))²/4 = μ_{p,q}² by `fourSet_sigma`, which is what `split_value` states, with θ > 0 derived from `theta_sphereProduct_value`. The step Σ = (A − B)² is done inside the proof by rewriting B and C to −2t.

**The sign, owed and unlisted (A-5).** The record's "common value μ_{p,q}" is positive, and the use the lemma is put to reads that sign: [Lemma L24](../findings/second-order.md) needs an L_e-eigenvalue ≥ ½, and a −μ_{p,q} would say nothing. From the weights, A − B = t(q/(p−1) + p/(q−1) + 2) > 0 at t > 0, and θ > 0 is already in the proof, so λ = +μ_{p,q} on v and −μ_{p,q} on b − c. This is a few lines on objects already in hand (a `div_pos` plus `sq_eq_sq'` or `pow_left_injective` on non-negatives), but the file stops at the square and the row's Owed list does not name the sign. The file's title reads "eigenvalue ±μ_{p,q}", which is honest about what is proved.

**Hypotheses (A-4).** Unit norm (`hn`), 0 < t, p, q ≥ 2, i, j ∈ T, k, l ∉ T, i ≠ j, k ≠ l are the record's "unit norm", "p, q ≥ 2" and a (2,2)-split four-subset, and distinctness of the four indices is derived. `split_eigen` holds at every t and needs neither norm nor sign, which is more general than the record and harmless. The sphere-product weight is critical by the programme's earlier files, which is where θ and `fourSet_sigma` come from, and the row inherits that.

**What remains owed (A-5).** The (4,0) and (3,1) blocks vanishing at the operator level is the "nonzero blocks are the (2,2)-splits" half of the clause and is untouched here. The bridge from FoxProduct's `foxProd` on matrix maps to L126Kernel's `LeLin` on `CurvOp2` is what turns "M ∘ v = λθ v" into "v ∈ ker DF(M) when λ = ½". Both are correctly listed as owed.

**orbit_in_pairBlock (A-6).** `orbitTan M j k` is Y ↦ [φ_jk, M Y] − M[φ_jk, Y], the conjugation derivative confirmed at r1597. At M = `diagOp w`, T_jk φ_ab = (w_ab − w_{ρ(ab)}) times the bracket, and [φ_jk, ·] moves φ_ji to ±φ_ki and back, and annihilates φ_jk and every φ_ab with {a,b} disjoint from {j,k}. So T_jk is supported on φ_ji ⊙ φ_ki, i ∉ {j,k}, with coefficient ±(w_ji − w_ki). The record ([second-order.md:1798](../findings/second-order.md#L1798)) gives M_ki − M_ji "with the sign convention that makes" it so, and the Lean's w_ji − w_ki is the other convention for φ, idle for a containment statement. The i = j and i = k terms vanish since φ_jj = φ_kk = 0, as the docstring says. The hypothesis `hh` (hollow w) is the pair-operator normalisation the record's M already has, so it narrows nothing.

**The record's note (A-7).** [second-order.md:1699](../findings/second-order.md#L1699) now reads *"(Machine-checked: `orbit_in_pairBlock`, the pair-block form, and `orbit_perp_fourSet`, orthogonality to every four-set operator, in L126Orbit.lean.)"*, which matches the two theorems, closing r1597's gap 1.

## 3. Soundness

- `cd lean && ~/.elan/bin/lake build HamiltonsCubic.Results.L126Assembly HamiltonsCubic.Results.L126Orbit`: "Build completed successfully (8737 jobs)", exit 0. The warnings printed belong to L68.lean, WeylReal.lean and an info at L121Block.lean:216, none from the two reviewed files.
- `python3 scripts/misc/axiom_audit.py --only L126Assembly.lean`: "3/3 clean -- resting on the standard three alone".
- `python3 scripts/misc/axiom_audit.py --only L126Orbit.lean`: "6/6 clean -- resting on the standard three alone".
- No `sorry`, no `native_decide` in either file.

## 4. Downstream

1. [lean/INDEX.md:483](../lean/INDEX.md#L483), the L126 (statement) row, still says *"what is owed is their assembly into the statement that μ_{p,q} is an L_e eigenvalue"*. After 35a3cc2e the assembly exists at the matrix-map level, and the row should point to L126Assembly.lean and name what stays owed (the sign, the (4,0) and (3,1) blocks, the `LeLin` bridge), matching row 482.
2. [L126Statement.lean:50-57](../lean/HamiltonsCubic/Results/L126Statement.lean#L50) gives as the reason `mu` is not an eigenvalue *"the Fox product ∘ and the operator L_e, which the RealLayer does not carry"*. FoxProduct.lean and L126Kernel.lean now carry both, so the reason is stale, though the file's own content is unchanged and correct.
3. [second-order.md:1701](../findings/second-order.md#L1701), the sphere-product clause, carries no machine-checked pointer, while its two neighbouring clauses now do. A note naming `split_eigen` and `split_value` (and `L126_threshold`, already cited below it) would close the pattern r1597 set.
4. [findings/INDEX-results.md](../findings/INDEX-results.md) row 142 links the Lean status generically and is not stale.

## 5. Style

- No em dash in either Lean file or in the added lines of lean/INDEX.md and second-order.md. No backticks inside link text. No hard-wrapped markdown prose (each row is one line).
- The rewritten row at [lean/INDEX.md:482](../lean/INDEX.md#L482) carries *"The audit reports "only at S³ × S³"; here it is the only solution rather than the only one found"*, a semicolon clause splice. It predates both commits and appears in the diff only because the row is one line. The new assembly sentence uses semicolons between list items that carry commas, which is the permitted use.

## 6. Verdict

**CONFIRMED WITH GAPS.** The mathematics of L126Assembly and `orbit_in_pairBlock` is faithful and kernel-checked on the standard three. Gaps:

1. The sign of v's eigenvalue, +μ_{p,q}, is proved nowhere and is unlisted in the Owed list at [lean/INDEX.md:482](../lean/INDEX.md#L482), though it follows in a few lines from A − B = t(q/(p−1) + p/(q−1) + 2) > 0 ([L126Assembly.lean:63](../lean/HamiltonsCubic/Results/L126Assembly.lean#L63)).
2. [lean/INDEX.md:483](../lean/INDEX.md#L483) still lists the assembly as owed.
3. [L126Statement.lean:55](../lean/HamiltonsCubic/Results/L126Statement.lean#L55) gives a stale reason (RealLayer lacks ∘ and L_e).
4. [second-order.md:1701](../findings/second-order.md#L1701) has no machine-checked pointer to L126Assembly.
5. Pre-existing clause splice at [lean/INDEX.md:482](../lean/INDEX.md#L482) ("...; here it is the only solution...").
