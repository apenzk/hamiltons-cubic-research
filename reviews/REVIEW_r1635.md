# REVIEW r1635: L120Direct.lean and the L120 row reading proved (commit e8b3efe1)

**Verdict: CONFIRMED WITH GAPS.** `weyl_direct` is a faithful, sound statement of directness and every helper is correct, so the decomposition itself (identification, dimension, spanning, directness) is complete on `Fin n`. The row's **proved** is not earned for the whole section: the block size `max(2,n−3)` is a definition in L120.lean rather than a consequence of the proved dimensions, and the `⟨M⟩` cut is "recorded" by two tautologies carrying a rationale that contradicts the record.

Scope: commit e8b3efe1, [L120Direct.lean](../lean/HamiltonsCubic/Results/L120Direct.lean), the L120 row of [lean/INDEX.md](../lean/INDEX.md) (line 475), [L120.lean](../lean/HamiltonsCubic/Results/L120.lean), against [second-order.md](../findings/second-order.md) Lemma L120 (line 1181). Analysis-only footing: the only run was the axiom audit, which compiles the module.

## Checks run

- `python3 scripts/misc/axiom_audit.py --only L120Direct`: 6/6 declarations on the standard three. No `sorry`, no `native_decide` in the file.
- Read by hand: `PairForm` (L120Pair.lean:45), `FourForm` (L120Four.lean:36), `D4`, `pairForm_shape`, `fourForm_shape`, `pairForm_iff_one`, `fourForm_iff_perm` (L120Span.lean:156–236), `cd_ext` (WeylTraceSchur.lean:72), `coord_reduce_flip` (WeylTraceSchur.lean:166), `flip` and `sgn` (WeylInvariantZero.lean:32, 62).
- Grepped the tree for `blockSize`, `agrees_from_five`, `only_exception`, `unquotiented_unsatisfiable`: no use outside L120.lean.

## Claim table

| # | Claim | Verdict | Basis |
|---|---|---|---|
| 1 | `pairForm_unique` (L120Direct.lean:29) | CONFIRMED | Destructures `PairForm j k` into its two orientations and applies `pairForm_iff_one` with `(u,v)=(j,k)` or `(k,j)`, the shared index `y` distinct from both. The swap in the second branch is matched by the `Or` swap at lines 35–36. Breaking object sought: a position `(a,b,c,d)` in `PairForm` of two distinct unordered pairs. `pairForm_iff_one` rules it out, since the one-shared shape fixes `{u,v}` as the two unshared indices. |
| 2 | `sorted4_unique` (L120Direct.lean:39) | CONFIRMED | Two strictly increasing 4-tuples whose entries lie in each other's set: `omega` over `Fin.val`. The hypotheses give only `{i',j',k',l'} ⊆ {i,j,k,l}`, which with strict increase and cardinality 4 forces equality. |
| 3 | `fourForm_sorted_unique` (L120Direct.lean:49) | CONFIRMED | `fourForm_shape` makes `(a,b,c,d)` four-distinct, `fourForm_iff_perm` puts both tuples inside `{a,b,c,d}`, and `hcover` (a 256-case split closed by `contradiction` or `simp`) transfers membership to `{i,j,k,l}`. Compiles, so every case closed. |
| 4 | `sum2_single`, `sum4_single` (L120Direct.lean:75, 80) | CONFIRMED | Iterated `Finset.sum_eq_single`. The hypothesis is the vanishing off the single tuple, as required. |
| 5 | `weyl_direct` (L120Direct.lean:92) faithful to directness | CONFIRMED | Hypotheses: `D` Weyl and flip-fixed (the trivial character, `diagSummand_iff`), `P j k` Weyl with character `ε_jε_k` under flips for `j<k`, `F i j k l` Weyl with character `ε_iε_jε_kε_l` for `i<j<k<l`. Flips generate the full sign group `Γ`, so flip isotypy equals `Γ` isotypy (and is the hypothesis `pair_isotypic`, `four_isotypic` use). The `if` guards index exactly unordered pairs and four-sets. Conclusion: every component zero. With `weyl_span` this is internal directness. It is stated as a vanishing-sum condition rather than `iSupIndep`/`DirectSum.IsInternal`, equivalent by reading. |
| 6 | `weyl_direct` case analyses sound | CONFIRMED | Three components, each read at its own positions: diagonal positions meet no `PairForm` (`pairForm_shape.1`) and no `FourForm` (`fourForm_shape` makes `c≠a`, `c≠b`); one-shared positions meet `D` zero (`coord_reduce_flip`), no `FourForm` (`pairForm_shape.2`) and one sorted pair (`pairForm_unique`, the swapped branch killed by `k0<j0<k0`); four-distinct positions meet `D` zero, no `PairForm`, one sorted four-set. Off its own positions each component is zero by `iso_coord_form`/`four_coord_form`. `cd_ext` then closes each, needing Weyl membership, which is hypothesised. Breaking object sought: a position shared by two kinds, or two sorted indices of one kind. None exists by the shape lemmas. |
| 7 | Row: identification and dimension of each summand | CONFIRMED | Pair: `pair_isotypic`, `pairSummand_mem`, `pairSummand_finrank` = `n−3` (L120PairDim.lean:62). Four: `four_isotypic`, `fourSummand_finrank` = 2 (L120Four.lean:288). Diagonal: `diagSummand_iff`, `diagSummand_finrank_closed` = `n(n−3)` doubled (L120DiagDim.lean:185). All as the row says. |
| 8 | Row: spanning and directness | CONFIRMED | `weyl_span` and `weyl_direct`. |
| 9 | Row: `Fin n` scope | CONFIRMED | The row states "on `Fin n`" for the pair, four-set, span and direct files. `Γ` and `𝒲_n` are defined on `ℝ^n` in the record, so `Fin n` is the record's own index set and the restriction costs nothing. |
| 10 | Row: block-diagonality | CONFIRMED WITH GAPS | `L120_block_diag` (L120Block.lean), already reviewed in r1441 with its declared gap (character hypothesis on all matrices, record on `Λ²`). The section's "Hence the Hessian of `P` on the sphere is block-diagonal in the same way" (second-order.md:1185) has no declaration and is not listed as owed (G3). |
| 11 | Row: block size `max(2,n−3)` and the `n=4` exception | CONFIRMED WITH GAPS | `blockSize` is **defined** as `max 2 (n−3)` (L120.lean:30), and `agrees_from_five`, `differs_at_four`, `only_exception` are arithmetic about that definition. Nothing ties it to `pairSummand_finrank` and `fourSummand_finrank`, the grep finds no consumer. The claim is true (the two dimensions are proved and the diagonal block is the only other one), so the gap is an unassembled step, declared nowhere (G1). |
| 12 | Row: the `D_n` cut by `⟨M⟩` "recorded in `L120.lean`" | REFUTED as recorded | L120.lean:15–19 and 47–54, repeated in the row, say that along the orbit direction `P` is constant, so the second-order form vanishes and strict decrease asks `0<0`. The record's mechanism (second-order.md:1187) is `e=M/θ ∈ D_n` with `L_e e = e`, so `λ_max(L_e|_{D_n}) ≥ 1 > ½`. At `e` the form `6θ(L_e−½)` gives `3θ > 0`, a strict violation, and it does not vanish. `P` is homogeneous cubic, so it is not constant along `⟨M⟩`. The orbit tangent where the Hessian vanishes (second-order.md:43) is the `O(n)` orbit, a different subspace from `⟨M⟩`. The two theorems, `unquotiented_unsatisfiable : ¬((0:ℚ)<0)` and `quotient_restores : ∃ x : ℚ, x < 0`, hold for every input and certify nothing about the Hessian. The conclusion (the literal reading excludes every diagonal critical point) survives. The stated reason is wrong, and nothing is typed (G2). |
| 13 | Row: "`W^⊥` cuts `D_n` and nothing else" | CONFIRMED WITH GAPS | True by isotypic orthogonality (M is `Γ`-fixed), used by the section, undeclared in Lean and absent from Owed (G3). |
| 14 | Row: dimension identity | CONFIRMED | `L120_dim_sum` (L120Dim.lean), polynomial identity, correctly described as transcription insurance. |
| 15 | Row reads **proved** | CONFIRMED WITH GAPS | "Owed: nothing of L120's decomposition" is accurate for the decomposition. The row's status covers the whole section, and items 11–13 are either stated by definition, by tautology, or not at all. |
| 16 | Axioms | CONFIRMED | 6/6 on the standard three. |

## Gaps

- **G1** (L120.lean:30, INDEX.md:475): `blockSize` is a definition. Add a theorem computing the largest non-diagonal isotypic dimension from `pairSummand_finrank` and `fourSummand_finrank` at `n ≥ 4`, or list the connection as owed.
- **G2** (L120.lean:15–19, 47–54, INDEX.md:475): the quotient rationale contradicts second-order.md:1187. Replace "P is constant along the orbit direction, the form vanishes, `0<0`" with the record's `e ∈ D_n`, `L_e e = e`, `1 > ½`, and either type it (L131/L24 machinery has `L_e`) or list it as owed. The two tautologies should not be cited as recording the cut.
- **G3** (INDEX.md:475): the Hessian block-diagonality and "`W^⊥` cuts `D_n` and nothing else" are section claims with no declaration and no Owed entry.

## Breaking objects sought

- Directness: a four-index position lying in two kinds' supports, or in two sorted pairs or four-sets. The shape lemmas exclude each case, and the build confirms every branch closes.
- Block size: a consumer linking `blockSize` to a `finrank`. None found by grep.
- Quotient: a direction in `⟨M⟩` where `6θ(L_e−½)` vanishes. At `e` it equals `3θ`, nonzero whenever `θ≠0`, so no such direction exists and the file's argument fails.

**One line**: `weyl_direct` is faithful and sound and closes the decomposition, but the L120 row's **proved** rests on a defined block size and a tautological `⟨M⟩` remark whose stated mechanism contradicts the record.
