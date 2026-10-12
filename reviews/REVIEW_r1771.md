# REVIEW r1771: L120Support.lean (ad0f8c93) and L120Ident.lean (30c059ae)

| Claim | Verdict | Reason |
|---|---|---|
| `coord_char` | CONFIRMED | the sign conjugation preserves `inner2`, `char_phi` scales the left side by c(ε)ε_aε_b and `signConj_phi` the right by ε_pε_q, and the nonzero pairing cancels |
| `eq_zero_of_coords` | CONFIRMED | every entry of every `applyPhi V a b` is read by `inner2_phi`, so `normSq2 V = 0` |
| `block_card` | CONFIRMED | the global flip gives (−1)^{\|t\|} = 1 and a flip at m ∈ t outside {a,b,p,q} gives −1 = 1, and it holds for every operator on Λ² with no Weyl hypothesis |
| `comp_zero` | CONFIRMED | `block_card` applied to `comp_char` |
| `signChar_iff_act` | CONFIRMED | forward is `act_extendL` (the skewProj transfer), backward is evaluation at a skew Z |
| `trivial_block_iff` | CONFIRMED | `IsWeyl2 V` feeds `extendL_mem`, which `diagSummand_iff` needs, and `IsWeight` is symmetric, hollow and zero row sums |
| `pair_block_iff` | CONFIRMED | the right side is `pairSummand_mem_signMat`'s image of the Ricci cut under `pairMap`, the record's V_jk |
| `four_block_iff` | CONFIRMED | the right side is the range of `fourMap`, the three pairings on the Bianchi cut x + y + z = 0, the record's V_ijkl |
| L120Decomp header edit | CONFIRMED | documentation only, and it now names the files that do the carry |
| lean/INDEX.md L120 row | CONFIRMED WITH OBSERVATIONS | the new sentences match the code, and the row still closes with the tag "statement: not typed" |

**Summary**: both commits prove what they say on the three standard axioms, and the record's decomposition of W_n is now available on `CurvOp2` as a composition of named results, with no single theorem that states it.

## 1. `block_card` (question 1)

- Source: [L120Support.lean:63](../lean/HamiltonsCubic/Results/L120Support.lean#L63).
- A nonzero V yields a nonzero coordinate ⟨Vφ_ab, φ_pq⟩ through `eq_zero_of_coords` (contrapositive). Degenerate indices are harmless, since φ_aa = 0 makes the coordinate zero, so the chosen (a, b, p, q) have a ≠ b and p ≠ q.
- Evenness: at ε = −1, `coord_char` gives setChar t (−1) = (−1)^4 = 1, and `Finset.prod_const` gives (−1)^{|t|}. `neg_one_pow_eq_one_iff_even` then gives `Even t.card`. Correct.
- Containment: for m ∈ t with m ∉ {a, b, p, q}, the single flip at m makes setChar t ε = −1 by `prod_ite_eq'` and the right side ε_aε_bε_pε_q = 1, since none of the four indices is m. `norm_num` closes −1 = 1. Correct.
- The bound |t| ≤ |{a,b,p,q}| ≤ 4 with evenness leaves {0, 2, 4}.
- **It needs no `IsWeyl2`.** The statement carries none, and I compiled a check file stating `block_card` at an arbitrary `CurvOp2` with only `SignChar (setChar t) V` and `V ≠ 0` (a screen). The support fact is a property of the sign action on Sym²(Λ²) and holds for every operator on Λ², which matches the record's proof, where the characters are read on Sym²(Λ²) before any Weyl condition is imposed.

## 2. `signChar_iff_act` (question 2)

- Source: [L120Ident.lean:35](../lean/HamiltonsCubic/Results/L120Ident.lean#L35).
- Forward: `act_extendL`, which goes through `hasChar_all`, rewriting both inputs through `extend_skewProj` and `skewProj_conj` (skewProj(SᵀZS) = Sᵀ skewProj(Z) S). This is the transfer [r1441](REVIEW_r1441.md) asked for, and it is exactly what makes the extension's character hold at non-skew Z.
- Backward: evaluate the `CurvLin` equation at the given skew Z, which is `HasChar`'s definition verbatim.
- Both directions hold. The right side quantifies over all matrices and the left over skew ones, and the skewProj transfer is what closes the gap in the forward direction.

## 3. `trivial_block_iff` (question 3)

- Source: [L120Ident.lean:49](../lean/HamiltonsCubic/Results/L120Ident.lean#L49).
- `IsWeyl2 V` is used in the forward direction, through `extendL_mem hV`, the membership hypothesis of `diagSummand_iff`. It is where it should be: without it the identity on Λ² is sign-fixed and is `diagOp` of the all-ones hollow matrix, which has nonzero row sums, so the forward direction would fail. The backward direction does not use it (`signChar_diag` needs only `IsWeyl (diagOp w)`), which is harmless.
- The weight is [IsWeight](../lean/HamiltonsCubic/Base/Families.lean#L153): `symm`, `hollow`, `rowSum`. This is the record's D_n parameter, "Ricci-flatness cuts the trivial block by its n row sums to D_n" (findings/second-order.md, Lemma L120, proof of the decomposition).
- The glue `restrict_diag_eq` and `extend_apply` identifies `restrict (diagOp_isWeyl hw)` with the `diagS w` that `diagSummand_iff` returns. I checked it at source in [L120Cut.lean:93](../lean/HamiltonsCubic/Results/L120Cut.lean#L93).
- The theorem is the trivial block of W_n, D_n, and not the trivial block of W⊥, D_n ∩ M⊥. The header says D_n, which is accurate. The W⊥ form follows by adding ⟨M, ·⟩ = 0 to both sides, and its dimension is the item the INDEX row lists as owed.

## 4. `pair_block_iff` and `four_block_iff` (question 4)

- `pairMap j k c` is `pairLin j k c ∘ₗ skewProj`, with `pairLin j k c Y = Σ_{i ∉ {j,k}} c_i · rk2 (φ_ji) (φ_ki) Y` and `rk2 U V X = ⟨V, X⟩U + ⟨U, X⟩V`, the symmetric product φ_ji ⊙ φ_ki. These are the record's "n − 2 elements e_ij ⊙ e_ik" with character ε_jε_k.
- `blockSums1 A` is (restriction to Aᶜ, sum over A). Its kernel at A = {i : i ≠ j, i ≠ k} is the coefficients vanishing off A with Σ c_i = 0 (`mem_ker_blockSums1`), the record's "one Ricci relation cuts each pair block from n − 2 to n − 3".
- `fourMap i j k l (x, y)` is `fourS` with z = −x − y, the span of φ_ij ⊙ φ_kl, φ_ki ⊙ φ_jl, φ_il ⊙ φ_jk (`spanVec`) on x + y + z = 0, the record's "first Bianchi cuts each 4-set block from 3 to 2 by the single relation among the three pairings".
- Both proofs rewrite with `signChar_iff_act`, then with the characterisation (`pairSummand_mem_signMat`, `fourSummand_mem`), then with `setChar_pair` or `setChar_four`, and discharge the `weylModuleS` conjunct with `extendL_mem hV`. The order of rewriting is sound: the `setChar` rewrite happens under the binder after the characterisation is in place.
- The summands on the right are the record's V_jk and V_ijkl.

## 5. Is the decomposition typed in full on `CurvOp2`? (question 5)

- Available pieces: `sum_comp` (R = Σ_t comp t R), `comp_isWeyl2`, `comp_char`, `comp_zero` (only |t| ∈ {0,2,4} survives), and the three identifications. Directness is `char_orth` with `setChar_sep` (distinct index sets give orthogonal components). Dimensions are `diagSummand_finrank`, `pairSummand_finrank` and `fourSummand_finrank` on `CurvLin`, and the bivector-level span and directness are `weyl_span` and `weyl_direct`.
- So every piece of the record's W_n = D_n ⊕ ⊕V_ijkl ⊕ ⊕V_jk is proved on `CurvOp2`, and the equation itself follows by one composition.
- **Observation O1.** No theorem states the assembled equation on `CurvOp2`: every Weyl R is restrict(diagOp w) plus a sum of operators whose extensions lie in the pair summands plus a sum lying in the four-set summands. The composition is mechanical and I see no obstacle in it, but the row's "The blocks are the record's summands, PROVED" reads as if that sentence were one declaration. Either state it (a short theorem combining `sum_comp`, `comp_zero` and the three `_iff` lemmas) or phrase the row as "each block is identified".
- Beyond O1, the owed list is complete as the row states it: dim(D_n ∩ M⊥) = n(n−3)/2 − 1 on `CurvOp2` and the per-block eigenvalue form of L24. The size clause max(2, n − 3) and the count of four-set blocks are already in L120Cut and L120Count.

## 6. Axioms (question 6)

- `lake env lean` on a check file in the scratchpad, at HEAD 30c059ae:
- `block_card`, `comp_zero`, `signChar_iff_act`, `trivial_block_iff`, `pair_block_iff`, `four_block_iff`: each depends on [propext, Classical.choice, Quot.sound].
- `grep` finds no `sorry`, `native_decide` or `axiom` in either file. Both are imported by the root (lean/HamiltonsCubic.lean lines 991 and 992).

## 7. The lean/INDEX.md L120 row (question 7)

- The sentences added by ad0f8c93 and 30c059ae ("Only |t| ∈ {0,2,4} carries a block, PROVED" and "The blocks are the record's summands, PROVED") match the declarations and their hypotheses, and the axiom claim matches section 6.
- **Observation O2.** The row still ends with the tag "statement: not typed" while its body now says the decomposition is proved in the coordinate frame. The tag should be brought into line with the body, or the row should say what "statement" refers to if it means a separate statement file.
- O1 applies to the row's wording as well.

## 8. Falsifiers and what I did (question 8)

- `coord_char`: an operator with character c and a nonzero coordinate at which c(ε) ≠ ε_aε_bε_pε_q. I derived the identity by hand from the conjugation invariance of `inner2` and found none possible.
- `block_card`: a nonzero operator on Λ² with character ∏_{i∈t} ε_i at |t| odd or |t| ≥ 5. I traced both flip computations at source. The global flip excludes odd |t|, and |t| ≥ 5 would need a coordinate with five distinct indices among four slots.
- `signChar_iff_act`: an operator whose extension fails the character at a non-skew Z. The skewProj transfer rules it out, and I checked that `extend` factors through `skewProj` (`extend_skewProj`).
- `trivial_block_iff`: a sign-fixed Weyl operator that is not diagonal, or a weight whose `diagOp` is not sign-fixed. I read `diagSummand_iff` and `diagS_signMat` and checked that the non-Weyl identity operator is excluded by the hypothesis, which is the reason the hypothesis is needed.
- `pair_block_iff` and `four_block_iff`: an operator with the right character outside the image, or an image element with another character. These reduce to `pairSummand_mem_signMat` and `fourSummand_mem`, both reviewed earlier ([r1694](REVIEW_r1694.md), [r1695](REVIEW_r1695.md)). I re-read their statements and the definitions of `pairMap`, `blockSums1` and `fourMap` against the record.
- Screen: the compiled check file states `block_card` with no Weyl hypothesis, which settles question 1's last part at the level of the type. No numerics were run.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1: the assembled equation on `CurvOp2` is a composition of proved pieces and is stated nowhere as one theorem. O2: the INDEX row's closing tag "statement: not typed" disagrees with its body.
