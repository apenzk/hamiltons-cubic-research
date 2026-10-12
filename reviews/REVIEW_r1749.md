# REVIEW r1749: L227's attainment clause in Lean (L227Attain.lean, commit 20949453)

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every new statement is true as typed and the conclusion of `L227_attained` renders the record's attainment clause. The observations concern scope wording, none is a defect.

Footing: analysis only. One screen of seconds on constructed objects (a random symmetric hollow integer weight on `Fin 3 ⊕ Fin 2`, checking the `J` block of `wOf_blocks` and the `J` row identity behind `ricci_blocks`, and the rational value of `thetaSplitSq 2 3`), reported as a screen. No `lake build` was run. The olean of `L227Attain` is dated after the source (01:48 against 01:47), and the file holds no `sorry` or `native_decide`.

## (1) `Sw`, `Mw`, `Kw` and `wOf_blocks`

- `Sw w = diagonal (x ↦ w (inl (x+1)) (inl (x+2)))` in `Fin 3` arithmetic: x = 0 reads w(1,2), x = 1 reads w(2,0), x = 2 reads w(0,1). Each is the `J`-pair complementary to x. Correct.
- `wOf` at (inl p, inl q) is `∑ x, eps p q x ^ 2 * S x x`. For p ≠ q exactly one x survives, the complement of {p, q}, and `Sw` there returns w(x+1, x+2), which is w(p, q) when (p, q) is the cyclic order and w(q, p) otherwise. The latter case (for instance p = 1, q = 0, giving w(0,1)) needs `hs`, which the proof supplies through `exact hs _ _`. For p = q, `eps p p x` is a determinant with two equal rows, so the entry is 0, and `hh` gives w(p,p) = 0. Correct at all nine patterns.
- Mixed entries read `M a p p = w (inl p) (inr a)` and the reversed pattern needs `hs (inr a) (inl q)`, which is supplied. Outer entries are `K` by definition.
- Screen: the `J` block identity held on a random symmetric hollow weight.
- Falsifier: a symmetric hollow w and an index pair with `wOf (Sw w) (Mw w) (Kw w) i j ≠ w i j`, e.g. `Sw` reading w(x, x+1) would fail at (0,1).

## (2) `ricci_blocks`

- `ricciFlat_iff` (L226Mixed) needs `(tr S) I - S + ∑ M_a = 0` and `tr M_a + ∑_b K_ab = 0`. Diagonal entry p of the first: `tr S - S_pp` sums the two pairs containing p, i.e. `∑_{q ≠ p} w(p,q)` over `J`, and `∑_a M_a pp = ∑_a w(p,a)`, so the entry is the full row sum of `inl p`, zero by `IsWeight.rowSum`. Off-diagonal entries vanish as every term is diagonal. Outer condition: `tr M_a = ∑_p w(p,a) = ∑_p w(a,p)` by symmetry plus `∑_b w(a,b)` is the row sum of `inr a`. Sound.
- Falsifier: a weight whose `J` or outer row sum is nonzero, which `IsWeight` excludes, or a sign convention in `ricciFlat_iff` other than `(tr S) I - S`, which is L226Mixed's and taken as given.

## (3) `Pcubic_norm_blocks`

- `blockOp_diag_eq` gives `blockOp S M K X = diagOp (wOf S M K) X` on skew X, with hypotheses `Sw_diag`, `Mw_diag`, K symmetric and hollow, all supplied. Rewriting `wOf_blocks` turns the right side into `diagOp w X`.
- So the two restrictions to the skew subspace agree (`hEq`, by extensionality on the subtype), and `Pcubic_eq_restrictLin` and `normSq_eq_restrictLin` (L57Block) transfer both P and the norm. The skew-preservation witnesses are `opOf_isSkew` (valid since `blockOp_eq_opOf` is `rfl`) and `diagOp_skew`. Sound.
- Falsifier: a skew X on which `blockOp (Sw w) (Mw w) (Kw w) X ≠ diagOp w X`, or a `Pcubic` that sees the action off the skew subspace, which the restriction lemmas rule out.

## (4) `sphere_unit_block` and `L227_attained`

- `T = {inl 0, inl 1}` has card 2 and complement `{inl 2, inr 0, inr 1}` of card 3, so the weight is `S² × S³` on five indices. `thetaSplitSq 2 3 = 2·4·1·2/(3·6) = 8/9 = ThetaSqOdd 5`, and `√(8/9) = 2√2/3 = Θ₅`. The proof goes through `thetaSplitSq_odd` at m = 2 (m ≠ 0, m + 1 ≠ 0, 2m - 1 ≠ 0 all hold). Screen agreed on 8/9.
- `sphere_unit_block` is `sphere_unit` from L2Operators verbatim with `Fin n` replaced by any `[Fintype ι] [DecidableEq ι]`. The lemmas it calls (`diagOp_normSq`, `diagOp_normSq_smul`, `sphereWeight_sumSq` in L130Statement) are stated over a general ι, so the generalisation is correct.
- `theta_sphereProduct_value` gives `theta = thetaSplit 2 3` at unit norm, and `theta = Pcubic / norm³` with norm 1 gives `Pcubic (diagOp w) = 2√2/3`. `Pcubic_norm_blocks` transfers it and the unit norm to the block operator.
- The conclusion carries symmetric S and M_a (diagonal), K symmetric and hollow, Ricci-flat, `S * M a = M a * S`, `M a * M b = M b * M a`, unit norm and `P = 2√2/3`. The commutations follow from `diagonal_mul_diagonal` and `mul_comm`. This is the record's "attained at a unit W whose blocks M_a and S commute". The coordinate-diagonal tensor is `diagOp w` in the identity frame, which is the frame rotation by the identity of R^J, an admissible instance of "a frame of R^5 rotated inside R^J".
- Falsifier: a split other than {2,3} at n = 5 (the {2,2} split does not exist there, and {1,4} is excluded by `hp`), or `thetaSplit 2 3 ≠ 2√2/3`. Neither obtains.

## (5) The INDEX row

- The L227 row says "both halves of L227 are typed at the operator, the identification of S_J with `blockOp` being L226's". That is exactly what is typed: `L227_full` bounds every Ricci-flat `blockOp` with symmetric blocks and two outer indices, and `L227_attained` exhibits one reaching the bound. The row claims nothing about `S_J` membership beyond L226.
- Falsifier: a row claiming membership of the witness in `W_5` or `S_J` as a Lean fact. The row makes no such claim.

## Observations

1. **`W_5` is carried as Ricci-flatness.** The witness's class in the conclusion is "Ricci-flat `blockOp` with symmetric blocks", the same class `L227_full` bounds, so the two halves match each other. The algebraic Bianchi identity and trace-freeness that the record's `W_5` carries are not in the conclusion. They hold for this witness (it is the sphere-product Weyl tensor on Λ²) and for the family through L226, which the row already names as the owner. A sentence in the row saying "`W_5` read as Ricci-flat in the block family, as in `L227_full`" would make that explicit.
2. **`sphere_unit_block` duplicates `sphere_unit`.** L2Operators' lemma is now the `ι = Fin n` instance of the new one. Replacing the old body with a call to the new lemma removes a second copy of the same proof.
3. **The split straddles J.** `T = {inl 0, inl 1}` puts one `J` index with the outer pair. That is legitimate, since `Sw`, `Mw`, `Kw` read any weight into blocks, and it is worth one clause in the docstring because the record's frame is phrased as rotated inside R^J, and a reader may expect `T ⊆ J` or `T ⊇ J` to be required.
4. **The `first | rfl | exact hs _ _ | skip` combinator** in `wOf_blocks` would leave a goal open if one survived. The built olean shows none did, so this is cosmetic.

Searched: lean/HamiltonsCubic/Results/{L227Attain,L57Block,L226Statement,L226Mixed,L2Operators,L130Statement}.lean, lean/HamiltonsCubic/Base/{Families,SphereValue,WeylReal}.lean, lean/INDEX.md L227 row, findings/second-order.md Lemma L227.
