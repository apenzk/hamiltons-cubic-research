# REVIEW r1774: L263Blocks.lean (7a1e89c3)

Gate 2 reader for the Lean layer. Commit under review: 7a1e89c3, adding [L263Blocks.lean](../lean/HamiltonsCubic/Results/L263Blocks.lean) on top of [I117G2.lean](../lean/HamiltonsCubic/Results/I117G2.lean). Every theorem was read at source. Analysis-only footing: the only computation is a seconds-long screen over the gf6 table, reported as a screen, plus one `#print axioms` run.

| Claim | Verdict | Reason |
|---|---|---|
| `L263_blocks`, first clause: P_k#P_k = 3 P_k | CONFIRMED | `sharp_gv` with `coefK_real`, and `coefK` is a kernel `decide` over the proved bracket table |
| `L263_blocks`, second clause: P_p#P_p = P_k + (4/3) P_p | CONFIRMED | `sharp_gv` with `coefPP_real`, the target weights rewritten through `gop_add` and `gop_smul` |
| `L263_blocks`, third clause: sharpB P_k P_p = (4/3) P_p | CONFIRMED | polarisation of P_h#P_h = 4P_h (`L263_witness.1`) with the ½ that `sharpB` carries |
| `projK_gv`, `projP_gv` | CONFIRMED | lamK·gn and lamPp·gn are the indicator of su3idx and of its complement, gn being 2 on even and 6 on odd indices |
| `projK_add_projP` | CONFIRMED | gk + gp = gu at all 14 indices, so lamK + lamPp = lamP and `gop_add` closes it |
| `coefK`, `coefPP` | CONFIRMED | `decide`, standard three axioms, recomputed independently in the screen |
| su3idx is a subalgebra, the stabiliser of e₆ | CONFIRMED (docstring) | closed under gf6, eight independent vectors with no φ(·,6) term, dimension matches dim su(3) = 8 |
| p irreducible under k | CONFIRMED (screen), UNTYPED | the commutant of ad(k) on p is span{I, J} with J² = −I, a field, and no clause states it |
| c₁ + x = c, 2α + y = c, x d_k = α d_p | CONFIRMED | 3 + 1 = 4, 8/3 + 4/3 = 4, 1·8 = (4/3)·6 = 8 |
| lean/INDEX.md L263 row | CONFIRMED WITH OBSERVATIONS | new sentence accurate, but the trailing "Not stated" sentence now contradicts it and irreducibility is missing from "Left to the record" |

**Summary.** The three block relations at SU(3) ⊂ G₂ are proved from the bracket with only the standard axioms and match the record's constants exactly. Two INDEX wording defects and one unrefreshed provenance paragraph in the record are observations.

## 1. Are gop lamK and gop lamPp the orthogonal projections?

- `gop lam = Σ_i lam i • rk1 (gv i)` with `rk1 u X = ⟨X, u⟩ u` and `inner2 X Y = ½ tr(XᵀY)` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)). By `gv_inner` the gv are pairwise orthogonal with squared norms gn = 2 on even indices (two φ terms) and 6 on odd ones (1 + 1 + 4).
- `gop_gv` gives `gop lam (gv k) = (lam k · gn k) • gv k`. For lamK = gk/6: even k ≤ 12 gives (3/6)·2 = 1, k = 13 gives (1/6)·6 = 1, odd k ≤ 11 gives 0. For lamPp = gp/6: odd k ≤ 11 gives (1/6)·6 = 1, all others 0. So `projK_gv` and `projP_gv` are exactly the indicator statements.
- On the orthogonal complement of g₂ in so(7), `gop_expand` shows every gop vanishes because each coefficient carries ⟨X, gv i⟩ = 0. With `gop_sa`, gop lamK is therefore the orthogonal projection of so(7) onto span{gv k : k ∈ su3idx} and gop lamPp the orthogonal projection onto the complement of that span inside g₂.
- Observation: the file characterises both operators on the gv basis only. The action on g₂⊥ and idempotence are one-line consequences of `gop_expand` and `gv_inner` that no clause in this file states. Nothing depends on them, since `L263_blocks` works at the level of weights.

## 2. Is su3idx a subalgebra isomorphic to su(3), the stabiliser of e₆?

- The eight vectors gv 0, 2, 4, 6, 8, 10, 12, 13 are read off the `gv` definition: none contains a φ(·, 6) term, so each kills e₆. Every odd gv carries a 2·φ(·, 6) term.
- Screen (seconds, gf6 parsed from source, exact rationals): gf6 i j m = 0 for every i, j ∈ su3idx and m ∉ su3idx. The span is closed under the bracket, and `gv_br` makes the table the actual bracket.
- The stabiliser of a unit vector under G₂ is SU(3), of dimension 8. The eight vectors are orthogonal and nonzero (`gv_ne`), so their span has dimension 8 and lies in the stabiliser algebra, hence equals it. This identification is prose. Nothing typed depends on it: the Lean uses su3idx only as the index set on which lamK·gn = 1.
- Screen also found the commutant of ad(k) on k has dimension 1, consistent with k being simple.

## 3. Is p irreducible under k, and is it used?

- Screen: the commutant of the eight 6×6 matrices ad(gv k)|_p (k ∈ su3idx) has dimension 2, spanned by I and a J with J² = −I. That algebra is C, a field, with no idempotent other than 0 and I. Since k acts skew-adjointly, every invariant subspace has an invariant complement, whose projection would be such an idempotent. So p is irreducible over R, of complex type, which matches p = C³.
- No typed clause states or uses irreducibility. `L263_blocks` computes the three relations directly from the bracket, and irreducibility is the record's route to the scalar block form in the general Statement, which the instance does not need.
- Observation: the INDEX "Left to the record" clause should name irreducibility of p alongside the g₂ and su(3) identifications, because the record's Statement assumes it and the Lean at the instance neither proves nor needs it.

## 4. Do the three relations hold with these numbers?

- d_k = 8 (|su3idx|), d_p = 6.
- c₁ + x = 3 + 1 = 4 = c. 2α + y = 8/3 + 4/3 = 4 = c. x·d_k = 8 and α·d_p = (4/3)·6 = 8.
- The record's Proof gets the constants in g₂'s form with Cas_g(g) = 8, so c = ½·8 = 4, c₁ = ½·6 = 3, α = ½·(8/3) = 4/3, and the trace check 8·6 + 6·(8/3) = 64 = 2·4·8. The Lean's so(7)-restricted normalisation gives c = 4 through `L263_witness`, so the two normalisations agree and the numbers match without rescaling.
- The three relations are arithmetic on the proved constants. No clause in L263Blocks.lean states them, which the INDEX row does not claim.

## 5. Is sharpB the record's polarised P_k#P_p?

- `sharpB A B = (1/2) • (sharpMapCL (A + B) − sharpMapCL A − sharpMapCL B)` ([I117Statements.lean:1348](../lean/HamiltonsCubic/Results/I117Statements.lean#L1348)).
- The record's Proof reads I#I = cI blockwise as P_k#P_k + 2·P_k#P_p + P_p#P_p, which is the same polarisation with the ½.
- Check of the third clause by hand: #(P_k + P_p) = 4P_k + 4P_p, minus 3P_k, minus (P_k + (4/3)P_p), leaves (8/3)P_p, and half of it is (4/3)P_p. The Lean proof is exactly this, closed by `module` after rewriting with `projK_add_projP`, `hH`, `hK`, `hP`.

## 6. Axioms

`lake env lean` on a scratch file, oleans newer than both sources:

```
L263_blocks, coefK, coefPP, projK_gv, projP_gv, projK_add_projP
  depend on axioms: [propext, Classical.choice, Quot.sound]
```

No `Lean.ofReduceBool`, so no `native_decide` anywhere in the dependency cone. The file contains no `sorry`. `coefK` and `coefPP` are plain `decide` under `maxRecDepth 100000`.

## 7. The lean/INDEX.md L263 row

- The new sentence is accurate: the three relations, the normalisation, the lemma names, the standard three axioms.
- "Left to the record: that h is g₂ and the 9/28 directions are su(3) (names, not used by any typed clause)" is correct as far as it goes. su3idx enters typed statements only as an index set, and the identification is prose (question 2).
- Observation A: the row still ends with "*Not stated: the block relations from the bracket and the Casimir values at SU(3) ⊂ G₂, which need a Casimir operator of a subalgebra acting on a module.*" That sentence sits under "Earlier:" and describes the pre-7a1e89c3 state, but its first half now contradicts the new PROVED sentence. It should keep only the general-case Casimir statement as left to the record.
- Observation B: irreducibility of p under k is missing from "Left to the record" (question 3).
- Observation C, outside the INDEX: the L263 provenance paragraph in [second-order.md](../findings/second-order.md) still says "the block relations and the Casimir values at SU(3) ⊂ G₂ enter as data" and lists "the Casimir values" under what stays with the record, without citing L263Blocks.lean. The commit updated the INDEX but left the record's paragraph as it was.

## 8. Falsifiers and what was done to look for them

| Statement | Falsifying object | Search |
|---|---|---|
| `coefK`, `coefPP` | a pair (m, n) whose weighted sum differs from the stated right side | kernel `decide` covers all 196 pairs, and the screen recomputed all 196 for each from source and found none |
| `L263_blocks` clauses 1 and 2 | a gap between `sharp_gv`'s hypothesis and the `_real` lemmas | read both: the `_real` lemmas cast the integer identity and divide by 2592 = 2·36·36, matching ½·(1/6)²·(1/6)² times 1296 or 432, 576 |
| `L263_blocks` clause 3 | a missing ½ in `sharpB` or a wrong P_h weight | read `sharpB` and `lamP`, then checked lamK + lamPp = lamP at all 14 indices |
| `projK_gv`, `projP_gv` | an index where lam·gn is not the indicator | computed all 14 by hand against gk, gp, gn |
| su3idx a subalgebra, the e₆ stabiliser | a bracket of two su3idx vectors with a p component, or a su3idx vector moving e₆ | screen over all 64 brackets, and read the eight `gv` definitions |
| p irreducible | a proper k-invariant subspace of p | screen: commutant is C, which has no nontrivial idempotent |
| the three relations | a mismatch in c₁ + x, 2α + y or x d_k − α d_p | exact arithmetic |
| no `native_decide` | `Lean.ofReduceBool` in the axiom list | `#print axioms` on all six names |

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** The three block relations at SU(3) ⊂ G₂ are proved from the bracket table, the operators are the stated orthogonal projections, the constants match the record's c = 4, c₁ = 3, α = 4/3, x = 1, y = 4/3, and the relations c₁ + x = c, 2α + y = c, x d_k = α d_p hold. Observations: the INDEX row's trailing "Not stated" sentence now contradicts the new result, irreducibility of p is untyped and absent from "Left to the record", and the record's L263 provenance paragraph still describes the block relations as data.
