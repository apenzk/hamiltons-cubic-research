# REVIEW r1622: L26_main's nonzero conjunct and L127Dim's dimension counts

Reviewer r1622, one-reviewer Gate 2 round, analysis only. Read: commit 8af66c92 ([L26Main.lean](../lean/HamiltonsCubic/Results/L26Main.lean), the two L26 rows of [lean/INDEX.md](../lean/INDEX.md), the L26 row of [findings/INDEX-results.md](../findings/INDEX-results.md)) and commit 0e403d1f ([L127Dim.lean](../lean/HamiltonsCubic/Results/L127Dim.lean) and the L127 row), against Lemma L127 in [second-order.md](../findings/second-order.md) (line 1717) and the upstream characterisations in [L127Mult.lean](../lean/HamiltonsCubic/Results/L127Mult.lean), [L127WMult.lean](../lean/HamiltonsCubic/Results/L127WMult.lean) and [L122Pair.lean](../lean/HamiltonsCubic/Results/L122Pair.lean). Axiom audit run on both modules. No numerical screen was needed.

| claim | verdict |
|---|---|
| C1 L26_main's v ≠ 0 conjunct and docstrings | CONFIRMED WITH GAPS (cosmetic) |
| C2 L26 index rows | CONFIRMED WITH GAPS (understatement) |
| C3 pairCoeff_inj licenses the counts | CONFIRMED WITH GAPS |
| C4 finrank_ker_blockSums1/2 | CONFIRMED |
| C5 the four counts against the record | CONFIRMED |
| C6 the four _mem theorems | CONFIRMED |
| C7 axiom audit | CONFIRMED (16/16, 2/2) |
| C8 lean/INDEX.md L127 row's new sentence | CONFIRMED WITH GAPS (one wording) |

## C1. L26_main

- The conjunct `v ≠ 0` at [L26Main.lean:46](../lean/HamiltonsCubic/Results/L26Main.lean#L46) is discharged by `splitVec_ne_zero` ([L126Final.lean:34](../lean/HamiltonsCubic/Results/L126Final.lean#L34)), whose statement is `restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X) ≠ 0`, syntactically the `let v` of L26_main. Its proof evaluates at `φ_ij` and reads the `(l,k)` entry, so it is a genuine nonzero statement about the operator on the skew subspace.
- The distinctness hypotheses it needs (`hik`, `hil`, `hjk`, `hjl`) are derived from membership in `T` and `Tᶜ`, so no hypothesis was added.
- With `v ≠ 0`, the conjunct `LeLin (restrict hW) v = μ • v` is now an eigenvector statement, which is what the record's `e ∘ X = μX` means.
- **Gap (cosmetic)**: [L26Main.lean:40](../lean/HamiltonsCubic/Results/L26Main.lean#L40) reads "is an nonzero `L_e`-eigenvector", and [L26Main.lean:15-17](../lean/HamiltonsCubic/Results/L26Main.lean#L15) breaks the bullet mid-sentence ("L26's comparison / with the within-factor top"). The content is accurate.

## C2. L26 rows

- lean/INDEX.md's L26 (statement) row now says L26_main states `X ∈ W_n`, `X ≠ 0` and `e ∘ X = μX` for `v = 2a − b − c = 3X`, and that the norm clause is absent. This matches the file. The `v = 3X` identification is prose, and r1620 verified it by hand.
- findings/INDEX-results.md's L26 row points to L26Main.lean for the Weyl and eigenvector clauses and stays **partial**, correct since `‖X‖² = 4/3` is not stated.
- **Gap (understatement)**: the main L26 row in lean/INDEX.md still describes L26_main as "the Bianchi vector v=3X is Weyl, L_ev=μ_{p,q}v, and mu_ge_half_iff" without the new nonzero conjunct. Nothing is overclaimed.

## C3. pairCoeff_inj

- The statement ([L127Dim.lean:124-133](../lean/HamiltonsCubic/Results/L127Dim.lean#L124)) is that two coefficient vectors vanishing off `s = {i : j ≠ i, k ≠ i}` whose operators `Σ_{q∈s} c_q rk2(φ_jq, φ_kq)` agree on every skew `X` are equal. The proof is `pairSpan_eq_iff` at `λ = 1`, which reads the `q`-coefficient off the `(q,k)` entry of the value at `φ_jq`. Correct.
- Why vanishing off `s` is needed: a coefficient at `j` or `k` contributes nothing to the operator (the sum runs over `s`), so without the vanishing condition every coefficient space would carry two spurious dimensions. The `_mem` theorems include the vanishing condition as their first conjunct, and the `blockSums` kernels impose it. So the coefficient spaces counted are exactly the preimages of the operator eigenspaces.
- The Ricci cut is correctly the zero-sum condition on `s`: [L122Pair.lean:48-62](../lean/HamiltonsCubic/Results/L122Pair.lean#L48)'s `pair_ricci` and `pair_ricciFlat_iff` give the Ricci contraction of `Σ c_i f_i` as `Σ c_i` at `(j,k)` and `(k,j)` and zero elsewhere.
- The eigen-equations in the `_mem` theorems are the full `M ∘ F = λ F` on every skew `X`, so they are eigenspaces of the operator restricted to the pair span, not of a compression.
- **Gap**: the passage from coefficient-space dimension to operator-space dimension is prose only ([L127Dim.lean:11-13](../lean/HamiltonsCubic/Results/L127Dim.lean#L11), docstring at line 122). No declaration forms the operator-side subspace (for instance `Submodule.map` of the coefficient map, or the eigenspace as a `Submodule ℝ (CurvOp ι)`) and states its `finrank`. The inference is sound (an injective linear map preserves `finrank`, via `LinearMap.finrank_map_eq` or `Submodule.equivMapOfInjective`), but the theorem stating "the eigenspace has dimension n − 4" is not in the file. Closing it is a few lines per count.

## C4. finrank_ker_blockSums1 and finrank_ker_blockSums2

- `mem_ker_blockSums1/2` identify the kernels with "vanishing off the blocks, zero sum on each block". The finrank follows from rank-nullity on a surjective map, the preimage built by placing the targets at one chosen point per block.
- Hypotheses. Disjointness is necessary: at `A = B` the two sum constraints coincide and the kernel has dimension `|A| − 1`, against a stated `2|A| − 2`. Nonemptiness is necessary: at `A = ∅` the sum over `A` is the zero functional, the map is not surjective and the kernel has dimension `|B| − 1`, against a stated `|B| − 2`. Together they are sufficient (surjectivity is proved).
- Truncated subtraction: nonemptiness gives `|A| + |B| ≥ 2` and `|A| ≥ 1`, so neither subtraction truncates. The `omega` closes on exactly these bounds.

## C5. The counts against the record

With `p = |T|`, `q = |Tᶜ|`, `n = card ι`, `|s| = n − 2` (`pairIdx_card`):

| theorem | typed value | record | check |
|---|---|---|---|
| cross_kernel_finrank | `card ι − 4` | `0^{n−4}` | A = T∖{j}, B = Tᶜ∖{k}, (p−1)+(q−1)−2 = n−4, both blocks nonempty from p, q ≥ 2 |
| cross_top_finrank | `1` | `½ simple` | crossTopVec nonzero at any q ∈ T∖{j}, value q−1 ≥ 1 |
| within_kernel_finrank | `T.card − 3`, p ≥ 3 | `0^{p−3}` | A = T∖{j,k}, (p−2)−1, and within_B_eq makes B = Tᶜ |
| within_neg_finrank | `Tᶜ.card − 1` | `(−μ)^{q−1}` | Tᶜ nonempty from q ≥ 2 |

- Consistency: `(n−4) + 1 = n−3` and `(p−3) + (q−1) + 1 = n−3`, each the Ricci-cut dimension `|s| − 1`, so both tables close.
- At `p = 2` the within kernel is excluded by `hp : 3 ≤ T.card`. The true dimension there is `0` and `T.card − 3` truncates to `0`, so the restriction is conservative, and the `{0}` at `p = 2` in the L127 row is L127WMult's reading, not a claim of this file.
- The within top's multiplicity `1` is not claimed by any declaration here. The row lists it as owed, with occurrence from `within_top_exists`. Correct. It is forced by the count above together with `within_spectrum`, which is an easy future closure.
- `cross_top_finrank` omits `hj : j ∈ T`. This weakens no conclusion: crossTopVec is nonzero from any `q ∈ T`, `q ≠ j`, which `p ≥ 2` supplies whether or not `j ∈ T`.

## C6. The _mem theorems

- `cross_kernel_mem`: forward, `cross_kernel_iff.mp` gives the in-factor sum zero and the total gives the other. Backward, the two block sums give the total and `cross_kernel_iff.mpr` gives the equation. `filter_union_filter_not_eq` identifies `A ∪ B = s`. Eigenvalue `0`, matching L127Mult.
- `cross_top_mem`: forward, `cross_top_iff` makes `c` factor-constant with block sums `C_T` and `−C_T`, and `c = (C_T / ((p−1)(q−1))) • crossTopVec`. Backward, `a • crossTopVec` has block sums `±a(p−1)(q−1)`, total zero, and satisfies the factor-constant equations. Eigenvalue `t(p+q−1)/2 = t(n−1)/2`, matching `cross_top_iff`.
- `within_kernel_mem`: both directions route through `within_kernel_iff` with eigenvalue `(0 : ℝ) •`, matching L127WMult's statement verbatim.
- `within_neg_mem`: eigenvalue `½(−2t − tq/(p−1) − tp/(q−1))`, verbatim `within_neg_iff`'s. By hand, dividing by `θ = t(n−1)`: `2(p−1)(q−1) + q(q−1) + p(p−1) = (p+q)² − 3(p+q) + 2 = (n−1)(n−2)`, so the value is `−(n−2)/(2(p−1)(q−1)) = −μ_{p,q}` in `L_e` units, the record's `−μ`.
- The file stays in `M ∘` units throughout. The `L_e` reading of the multiplicities is by L127Le's `LeLin_pairVec_iff` (a positive scalar `P(M) = θ`), which is not composed with these counts in any declaration. The docstrings say `t(n − 1)/2`, not `½`, so nothing is overclaimed.

## C7. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L127Dim`: 16/16 clean on the standard three.
- `python3 scripts/misc/axiom_audit.py --only L26Main`: 2/2 clean on the standard three.

## C8. The L127 row's new sentence

- The sentence names the eight theorems and the two blockSums lemmas accurately, and keeps the within top's multiplicity, the `D_n` row and the agreement as owed.
- **Gap (wording)**: "each eigenspace on the Ricci cut is the kernel of a surjective restriction-and-block-sums map ... or a line" reads as a statement about the operator eigenspace. What is proved is that its coefficient preimage is that kernel. With pairCoeff_inj the two have equal dimension, but, as in C3, the equality is not a declaration. Suggested: "each eigenspace's coefficient space on the Ricci cut is ...", or add the `Submodule.map` theorems of C3.

## What would break each count, and what was done to look for it

- **Coefficients at j or k.** Would add two dimensions to every count. Checked that every `_mem` theorem and every `blockSums` kernel imposes vanishing off `s`.
- **A block empty.** At `p = 1` (cross) or `p = 2` (within kernel) the block sum constraint vanishes and `|A| − 1` becomes `−1`. Checked the nonemptiness derivations from `hp`, `hq`, and that `within_kernel_finrank` requires `p ≥ 3`.
- **Overlapping blocks.** Would merge two constraints. Checked `disjoint_filter_filter_not`.
- **A compression rather than an eigen-equation.** Would count eigenvectors of the projected block. Checked that the `_mem` equations are the full `M ∘ F = λ F` on every skew `X`.
- **A Ricci cut other than the zero sum.** Checked `pair_ricciFlat_iff` in L122Pair.lean.
- **A non-injective coefficient map.** Would make coefficient dimensions exceed operator dimensions. Checked `pairCoeff_inj`'s proof route through `pairSpan_eq_iff`.
- **An eigenvalue mismatch.** Checked each `_mem` eigenvalue against the upstream iff verbatim and `−½(2t+α+β)/θ = −μ` by hand.
- **The totals.** Both blocks sum to `n − 3`, so no eigenspace is missing or doubled.

## Summary

Both commits do what they say: `L26_main` now carries a nonzero eigenvector, and L127Dim's four counts `n − 4`, `1`, `p − 3`, `q − 1` are correct against the record, with the within top's multiplicity rightly left owed. The gaps are a coefficient-to-operator dimension transfer stated only in prose ([L127Dim.lean:11-13](../lean/HamiltonsCubic/Results/L127Dim.lean#L11), echoed in the L127 row), a typo at [L26Main.lean:40](../lean/HamiltonsCubic/Results/L26Main.lean#L40), and the main L26 row not mentioning `v ≠ 0`.
