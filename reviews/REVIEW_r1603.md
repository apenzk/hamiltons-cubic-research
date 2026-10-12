# Review r1603: L126's direction is Weyl, and r1602's repairs (commits 68810fb9 and c1d0620c)

**Standfirst.** [L126Weyl.lean](../lean/HamiltonsCubic/Results/L126Weyl.lean) proves that the (2,2) Bianchi vector v = 2a − b − c satisfies all four clauses of the layer's `IsWeyl` (bivector-preserving, symmetric on bivectors, first Bianchi at every tuple, Ricci-flat), and that its restriction to `CurvOp2` is `IsWeyl2`. The Ricci lemma was checked by hand and both modules build and audit 4/4 on the standard three. Commit c1d0620c's docstrings in [L126General.lean](../lean/HamiltonsCubic/Results/L126General.lean) now say accurately that θ is free and that the condition reads L_e v = ½ v only at θ = P(M), and the L126 row names the general-M bridge r1602 asked for. Three small gaps remain: the orthogonality ⟨M, v⟩ = 0 that completes tangency is a local `have` inside `split_DF` and appears in no exported statement, the L126 statement row lists every L126 file but the new one, and the owed list calls "Weyl" a hypothesis of `critMap_hasDerivAt`, which takes none.

| Claim | Verdict |
|---|---|
| A-1. `phi_pair_disjoint` and `ric_rk2_disjoint`: U ⊙ V on disjoint basis pairs has zero Ricci contraction | **CONFIRMED** |
| A-2. `splitVec_isWeyl`: v is Weyl in Base/WeylReal.lean's sense, all four clauses | **CONFIRMED** |
| A-3. `splitVec_isWeyl2`: the restriction used by `split_DF` is `IsWeyl2` | **CONFIRMED** |
| A-4. "so `split_DF`'s direction lies in the record's tangent space" | **CONFIRMED WITH GAPS** |
| A-5. c1d0620c's docstrings: θ free, L_e only at θ = P(M) | **CONFIRMED** |
| A-6. The L126 rows say what is proved and what is owed, including r1602's general-M bridge | **CONFIRMED WITH GAPS** |
| B. Build and axiom audit | **CONFIRMED** |
| C. Downstream text | **CONFIRMED** |
| D. Style | **CONFIRMED** |

**Summary:** v is Weyl and the proofs are sound and faithful, r1602's gaps are closed, and the remaining gaps are that tangency is a conjunction of one exported theorem and one local `have`, that the statement row omits L126Weyl.lean, and that the owed list mislabels Weyl as a `critMap_hasDerivAt` hypothesis.

## 1. Files and commits

- [L126Weyl.lean](../lean/HamiltonsCubic/Results/L126Weyl.lean): `phi_pair_disjoint` (line 24), `ric_rk2_disjoint` (line 35), `splitVec_isWeyl` (line 45), `splitVec_isWeyl2` (line 58), new in 68810fb9.
- [L126General.lean:10-12](../lean/HamiltonsCubic/Results/L126General.lean#L10) and [L126General.lean:101-103](../lean/HamiltonsCubic/Results/L126General.lean#L101), docstrings changed in c1d0620c.
- [lean/INDEX.md:482-483](../lean/INDEX.md#L482), the L126 rows, changed in both commits.
- Definitions read: `Ric`, `bianchi`, `IsWeyl` at [WeylReal.lean:106-130](../lean/HamiltonsCubic/Base/WeylReal.lean#L106), `rk2` at [L121Block.lean:102](../lean/HamiltonsCubic/Results/L121Block.lean#L102), `splitVec` at [L126Bridge.lean:26](../lean/HamiltonsCubic/Results/L126Bridge.lean#L26), `fourSet_bianchi_iff` at [L121Bianchi.lean:78](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L78), `critMap_hasDerivAt` at [L126Kernel.lean:51](../lean/HamiltonsCubic/Results/L126Kernel.lean#L51), `split_DF` at [L126DF.lean:160](../lean/HamiltonsCubic/Results/L126DF.lean#L160).

## 2. The Ricci contraction by hand (A-1)

- `rk2 U V X = ⟨V, X⟩ U + ⟨U, X⟩ V`, so Ric(U ⊙ V)(a, b) = Σ_c [⟨V, φ_ac⟩⟨U, φ_bc⟩ + ⟨U, φ_ac⟩⟨V, φ_bc⟩].
- With U = φ_pq, the factor ⟨φ_pq, φ_xc⟩ is nonzero only when {x, c} = {p, q}, so c ∈ {p, q}. With V = φ_rs, the other factor forces c ∈ {r, s}. Disjointness empties the intersection, so every summand vanishes, at c = a and c = b included.
- `phi_pair_disjoint` is exactly the vanishing of one such product, and `ric_rk2_disjoint` applies it at (b, a, c) and (a, b, c) for the two terms. The four inequalities are the four cross-disjointness conditions, and p ≠ q is not needed for the vanishing.

## 3. The four clauses of IsWeyl (A-2, A-3)

- **Bivector-preserving**: `splitVec_skew`, from `rk2_skew` on three skew pairs.
- **Symmetric on bivectors**: ⟨rk2 U V X, Y⟩ = ⟨V, X⟩⟨U, Y⟩ + ⟨U, X⟩⟨V, Y⟩ is symmetric in X, Y, and the three terms are combined linearly. The `simp` with `rk2_symm` closes it.
- **First Bianchi at every tuple**: `fourSet_bianchi_iff` at coefficients (2, −1, −1), whose sum is 0. Its left side is literally `splitVec` unfolded, so the instance is the right one.
- **Ricci-flat**: the three summands are φ_ij ⊙ φ_kl, φ_ki ⊙ φ_jl and φ_il ⊙ φ_jk, and each pair is disjoint under the six distinctness hypotheses. The hypothesis tuples supplied at lines 52-54 match (checked term by term).
- **IsWeyl2**: `isWeyl2_restrict` on the IsWeyl witness, with an extensionality step identifying `restrictLin (splitVec_lin …)` with `restrict`. The restricted operator is syntactically the `v` of `split_DF`, and `split_DF`'s hypotheses (i, j ∈ T, k, l ∉ T, i ≠ j, k ≠ l) yield all six distinctness facts `splitVec_isWeyl2` needs.

## 4. Tangency (A-4)

- The record's "on the tangent space" at a unit M in the Weyl space is {v Weyl : ⟨M, v⟩ = 0}. `splitVec_isWeyl2` gives the first condition.
- **Gap 1.** The second condition is `hperp : innerOp2 M v = 0` at [L126DF.lean:191](../lean/HamiltonsCubic/Results/L126DF.lean#L191), a local `have` inside `split_DF`. `split_DF`'s conclusion (lines 166-169) exports the derivative and the kernel iff, and no exported theorem states ⟨M, v⟩ = 0 or IsWeyl2 v ∧ ⟨M, v⟩ = 0. The mathematics is checked by the kernel, but the tangency the row asserts is a reader's conjunction of an exported theorem and a proof-internal fact. Fix: lift `hperp` to a named lemma, or add a conjunct to `splitVec_isWeyl2` or `split_DF`.
- An observation outside this round's scope: `critMap` uses the unprojected Q on `CurvOp2`. At this v the image 2M∘v − P(M)v is a multiple of v, hence Weyl, so the distinction between DF and its Weyl projection does not arise here.

## 5. c1d0620c's docstrings (A-5)

- The header at [L126General.lean:10-12](../lean/HamiltonsCubic/Results/L126General.lean#L10) says the theorem takes θ as a free positive real and that at θ = P(M) the condition M ∘ v = (θ/2) v is L_e v = ½ v. The docstring at lines 101-103 says the same. Both match the signature, where θ and 0 < θ are bare parameters. r1602 gap 1 is closed.

## 6. The L126 rows (A-6)

- The L126 row's new clause "And v is Weyl" names the three right declarations and 4/4, accurate apart from Gap 1's point about tangency.
- The owed list now names an analogue of `split_LeLin` at a general diagonal critical M, the identification θ = P(M) there, and `critMap_hasDerivAt`'s hypotheses at the block's Bianchi vectors, plus one composing statement. r1602 gap 2 is closed. Listing Weyl as owed at general M is correct, since `splitVec_isWeyl` covers only (x, y, z) = (2, −1, −1).
- **Gap 2.** The owed list reads "`critMap_hasDerivAt`'s hypotheses at the block's Bianchi vectors ($v$ self-adjoint, Weyl, $\langle M,v\rangle=0$)" at [lean/INDEX.md:482](../lean/INDEX.md#L482). `critMap_hasDerivAt` ([L126Kernel.lean:51-52](../lean/HamiltonsCubic/Results/L126Kernel.lean#L51)) takes M self-adjoint, H self-adjoint, criticality and ⟨M, H⟩ = 0, and no Weyl hypothesis. Weyl is owed for tangency, and M's self-adjointness and criticality on `CurvOp2` are omitted from the parenthesis. Fix: "(M critical on `CurvOp2`, v self-adjoint and ⟨M, v⟩ = 0), and v Weyl for tangency".
- **Gap 3.** The L126 statement row at [lean/INDEX.md:483](../lean/INDEX.md#L483) enumerates every L126 file (Kernel, Orbit, Assembly, Splits, Bridge, Final, DF, General) and omits [L126Weyl.lean](../lean/HamiltonsCubic/Results/L126Weyl.lean).

## 7. Build and axiom audit (B)

- `lake build HamiltonsCubic.Results.L126Weyl HamiltonsCubic.Results.L126General`: build completed successfully (8794 jobs), linter notes only.
- `axiom_audit.py --only L126Weyl.lean`: 4/4 clean on the standard three. `--only L126General.lean`: 4/4 clean.

## 8. Downstream (C)

- [L126DF.lean](../lean/HamiltonsCubic/Results/L126DF.lean)'s header and [L126Statement.lean](../lean/HamiltonsCubic/Results/L126Statement.lean) carry no text calling v's Weyl property owed. [findings/second-order.md](../findings/second-order.md) Lemma L126 (line 1699) is unaffected. The INDEX row no longer lists Weyl as owed at the sphere product.

## 9. Style (D)

- No em dash, no backtick inside link text and no hard wrap in the lines these commits added. The semicolons in the L126 row are list separators between comma-bearing items or predate these commits.

## Verdict

**CONFIRMED WITH GAPS.**
