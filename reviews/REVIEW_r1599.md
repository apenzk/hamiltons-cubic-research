# Review r1599: L126's other splits and second eigenvector (L126Splits), commit 00bf93ae, and r1598's repair, commit 51f08ca2

**Standfirst.** The new file proves that equal opposite-pair sums A = B = C make M ∘ vanish on the Bianchi part x + y + z = 0 of a four-set span, that at `t • sphereWeight T` the sums agree at the (4,0), (3,1), (1,3) and (0,4) splits with l the odd index out, and that at a (2,2)-split b − c carries −½(A − B). Each was checked by hand against L121's G = [[A,C,B],[C,B,A],[B,A,C]]. The relabelling step is sound: a transposition of the four labels sends the signed basis (a, b, c) to minus a permutation of itself, so the span and its Bianchi part 𝟏^⊥ are unchanged and the three sums are permuted. The repair commit's `split_value_eq` is right, A − B = t(q/(p−1) + p/(q−1) + 2) > 0 at t > 0. Both modules build and audit clean on the standard three. Gaps are downstream: the three pointers r1598 had asked to name L126Assembly now omit L126Splits, which carries the "nonzero blocks are exactly the (2,2)-splits" clause. A further minor gap is that the composition of `equal_sums_kill` with the four `split_*_sums` and the relabelling live only in prose.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `equal_sums_kill`: A = B = C and x + y + z = 0 give M ∘ (x a + y b + z c) = 0 on every bivector | **CONFIRMED** |
| A-2 | `split_40_sums`, `split_31_sums`, `split_13_sums`, `split_04_sums`: the three sums agree at every split but (2,2) | **CONFIRMED** |
| A-3 | "l the odd index out, every other placement is a relabelling of the four-set", so every (3,1) and (1,3) placement is covered | **CONFIRMED** (sound by hand, carried in the docstring and not as a Lean corollary) |
| A-4 | "nonzero block" read on the Bianchi part 𝟏^⊥ | **CONFIRMED** (L121 defines the block as the restriction to 𝟏^⊥, and 𝟏 carries ½(A + B + C) ≠ 0 at (4,0)) |
| A-5 | `split_eigen_second`: M ∘ (b − c) = −½(A − B)(b − c) at a (2,2)-split | **CONFIRMED** |
| A-6 | `split_value_eq`: (A − B)/(2θ) = +μ_{p,q}, from A − B = t(q/(p−1) + p/(q−1) + 2) > 0 and θ > 0 | **CONFIRMED** |
| A-7 | the L126 row owes only the bridge from `foxProd` to L126Kernel's `LeLin` on `CurvOp2` | **CONFIRMED** |
| B | builds succeed, audits 6/6 (L126Splits) and 4/4 (L126Assembly) on propext, Classical.choice, Quot.sound, no `sorry`, no `native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAPS** (L126Statement.lean:52-57, lean/INDEX.md:483, second-order.md:1704 omit L126Splits) |
| D | style | **CONFIRMED WITH GAPS** (one pre-existing clause splice on a line 51f08ca2 edited) |

**Summary:** L126Splits proves faithfully, on the standard three, that at a sphere product only the (2,2)-split four-set blocks are nonzero on their Bianchi part, with eigenvalues ±½(A − B) = ±θμ_{p,q}, and r1598's five gaps are closed. Three downstream pointers do not yet name the new file.

## 1. Files and rows carrying the id

- [L126Splits.lean](../lean/HamiltonsCubic/Results/L126Splits.lean) is new in commit 00bf93ae, imported in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), with the L126 row at [lean/INDEX.md:482](../lean/INDEX.md#L482) rewritten and file counts bumped in STATUS.md and plan-lean.md.
- The L126 family also holds [L126.lean](../lean/HamiltonsCubic/Results/L126.lean), [L126Kernel.lean](../lean/HamiltonsCubic/Results/L126Kernel.lean), [L126Orbit.lean](../lean/HamiltonsCubic/Results/L126Orbit.lean), [L126Sphere.lean](../lean/HamiltonsCubic/Results/L126Sphere.lean), [L126Assembly.lean](../lean/HamiltonsCubic/Results/L126Assembly.lean) and [L126Statement.lean](../lean/HamiltonsCubic/Results/L126Statement.lean).
- Commit 51f08ca2 adds `split_value_eq` to L126Assembly.lean, rewrites the untyped note in L126Statement.lean, adds a machine-checked note at [second-order.md:1704](../findings/second-order.md#L1704), and edits both L126 rows of lean/INDEX.md.

## 2. Fidelity against Lemma L126

**The block (A-4).** [second-order.md:1197](../findings/second-order.md#L1197), Lemma L121, gives L_M on the four-set span as ½G in signed coordinates a = φ_ij ⊙ φ_kl, b = φ_ki ⊙ φ_jl, c = φ_il ⊙ φ_jk, with A = w_ij + w_kl, B = w_ik + w_jl, C = w_il + w_jk, and says first Bianchi is exactly 𝟏^⊥ there, the root A + B + C on 𝟏 being removed. So L126's "nonzero four-set block" is the restriction to 𝟏^⊥. At (4,0) the 𝟏 direction carries ½·3·2tq/(p−1) ≠ 0, so the Bianchi reading is the only one under which the lemma is true, and it is the record's own. [L121Bianchi.lean](../lean/HamiltonsCubic/Results/L121Bianchi.lean)'s `fourSet_bianchi_iff` carries the cut in Lean.

**`equal_sums_kill` (A-1).** `fourSet_span` ([L121Block.lean:289](../lean/HamiltonsCubic/Results/L121Block.lean#L289)) gives the three coordinates of M ∘ (x a + y b + z c) as ½(Ax + Cy + Bz), ½(Cx + By + Az), ½(Bx + Ay + Cz). With B and C rewritten to A, each is ½A(x + y + z) = 0. The proof does exactly this.

**The sums (A-2), by hand.** Write α = q/(p−1), β = p/(q−1), weights tα within T, tβ within Tᶜ, −t across.

- (4,0): every weight tα, so A = B = C = 2tα.
- (3,1), i, j, k ∈ T, l ∉ T: A = tα − t, B = tα − t, C = −t + tα.
- (1,3), i, j, k ∉ T, l ∈ T: the same with β.
- (0,4): A = B = C = 2tβ.
- (2,2), i, j ∈ T, k, l ∉ T: A = t(α + β), B = C = −2t, so A ≠ B at t ≠ 0.

The Lean statements match these, and the (2,2) inequality is what `split_value_eq`'s positivity supplies.

**The relabelling (A-3).** `equal_sums_kill` is stated for arbitrary distinct labels, and each `split_*_sums` fixes where the odd index sits. A (3,1) four-set with its out-of-T element anywhere can be labelled with that element as l. The block itself is labelling-free: under the transposition i ↔ j, a' = φ_ji ⊙ φ_kl = −a, b' = φ_kj ⊙ φ_il = −c, c' = φ_jl ⊙ φ_ik = −b, and k ↔ l gives (−a, −c, −b) likewise, so every relabelling sends the signed basis to minus a permutation of itself (transpositions generate S_4). The span is unchanged, x + y + z = 0 is preserved, and {A, B, C} is permuted, so the hypothesis A = B = C is invariant. This step is sound. It lives in the docstring at [L126Splits.lean:12-14](../lean/HamiltonsCubic/Results/L126Splits.lean#L12) and no Lean theorem states "every four-set block other than a (2,2)-split vanishes on its Bianchi part" with the placement quantified. That is gap 2 and is minor.

**`split_eigen_second` (A-5), by hand.** At (0, 1, −1) with B = C the coordinates are ½(C − B, B − A, A − C) = ½(0, −(A − B), A − B) = −½(A − B)(0, 1, −1). The Lean `u` is 0·a + 1·b + (−1)·c = b − c, which is Bianchi (0 + 1 − 1 = 0), and together with `split_eigen`'s 2a − b − c it spans the two-dimensional 𝟏^⊥. So the (2,2) block on its Bianchi part is ±½(A − B), matching L121's "second eigenvalue −μ".

**`split_value_eq` (A-6), by hand.** A − B = t(α + β) + 2t = t(q/(p−1) + p/(q−1) + 2), positive at t > 0 and p, q ≥ 2. θ = `thetaSplit` is a square root of a quotient of positive factors at p, q ≥ 2, hence positive. So (A − B)/(2θ) > 0, μ_{p,q} = (n − 2)/(2(p−1)(q−1)) > 0, and `pow_left_inj₀` turns `split_value`'s equality of squares into equality. The hypothesis 0 < t is the record's orientation of the sphere product.

**The row (A-7).** With L126Kernel (DF(M) and its kernel), L126Orbit (orbit-freeness), L126Sphere (Σ = θ² iff the threshold), L126Assembly and L126Splits (the four-set spectrum at every split), every clause of the lemma has a matrix-map proof. What stands between those and the lemma is that `foxProd (diagOp w)` restricted to the four-set span is θ·`LeLin` on `CurvOp2` at the same θ, which the row names as owed with "statement: not typed". Honest.

## 3. Soundness

- `lake build HamiltonsCubic.Results.L126Splits HamiltonsCubic.Results.L126Assembly`: build completed successfully (8738 jobs), warnings only from the `show` linter in L126Sphere.lean.
- `axiom_audit.py --only L126Splits.lean`: 6/6 clean on the standard three.
- `axiom_audit.py --only L126Assembly.lean`: 4/4 clean on the standard three.
- No `sorry`, no `native_decide` in either file.

## 4. Downstream

1. [L126Statement.lean:52-57](../lean/HamiltonsCubic/Results/L126Statement.lean#L52). The note written by 51f08ca2 lists where the eigenvalue identification lives (L126Kernel, L126Orbit, L126Assembly). The note it replaced listed "the nonzero four-set blocks at Sᵖ × S^q are exactly the (2,2)-splits" among the absent items, and that clause is now in L126Splits, which the note does not name.
2. [lean/INDEX.md:483](../lean/INDEX.md#L483), the L126 (statement) row, cites L126Assembly for the assembly and omits L126Splits.
3. [second-order.md:1704](../findings/second-order.md#L1704): the machine-checked note covers the eigenvalue +μ_{p,q} (`split_eigen`, `split_value_eq`) and leaves the lemma's first clause, "the nonzero four-set blocks are the (2,2)-splits", without a pointer to `equal_sums_kill` and the `split_*_sums`.
4. [findings/INDEX-results.md:142](../findings/INDEX-results.md#L142) reads "Lean: partial" and defers to lean/INDEX.md, which stays true.

r1598's gaps: gap 1 (sign) closed by `split_value_eq`. Gaps 2, 3, 4 (statement row, L126Statement note, second-order note) closed for L126Assembly. Gap 5 (row 482's splice) closed: the remaining semicolons in row 482 separate list items that carry commas, or append "standard three axioms".

## 5. Style

- No em dashes in the added lines, no backticks inside link text, INDEX rows and markdown paragraphs one line each.
- [second-order.md:1704](../findings/second-order.md#L1704): "The derivation is valid at p,q ≥ 2; p = 1 is excluded structurally" is a clause splice. It predates both commits but sits on the line 51f08ca2 edited.

## 6. Verdict

**CONFIRMED WITH GAPS.**

1. [L126Statement.lean:52-57](../lean/HamiltonsCubic/Results/L126Statement.lean#L52), [lean/INDEX.md:483](../lean/INDEX.md#L483), [second-order.md:1704](../findings/second-order.md#L1704): name L126Splits for the "only the (2,2)-splits are nonzero" clause and the second eigenvector.
2. [L126Splits.lean:12-14](../lean/HamiltonsCubic/Results/L126Splits.lean#L12): the relabelling and the composition with `equal_sums_kill` are prose only. A corollary quantified over the placement, or a sentence in the row saying the reader composes them, would close it. Minor, the step being sound.
3. [second-order.md:1704](../findings/second-order.md#L1704): pre-existing clause splice "valid at p,q ≥ 2; p = 1 is excluded structurally".
