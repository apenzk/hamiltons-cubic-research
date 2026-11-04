# REVIEW r1682: the L237 row after r1681 (321a97ca, 679932ae), and the header and docstring edits beside it

**Verdict: CONFIRMED WITH GAPS.** Every declaration the L237 row calls proved exists, says what the row says, is imported in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) and rests on the standard three (the audit ran clean on all eleven files the row cites). The owed list now covers every clause of [second-order.md:228-240](../findings/second-order.md#L228) that r1681 named, and the duplicated passage is gone. Three small gaps remain: the comparison of the ray ceiling with $\sqrt{3/2}$ is on neither list, `diagonal_locus_proper`'s docstring and the L52 row infer "has interior" and a locus dimension that no declaration carries and no owed list names, and the record's $\kappa_1,\kappa_2=2,4$ still carries no $n$ while both fail at $n=3$.

| # | Claim | Verdict |
|---|---|---|
| 1 | 321a97ca: the slot-count and cap passage appears once | **CONFIRMED** |
| 2 | Nineteen three-slot bounds, each `slot sum ≤ 4 Σ s²` | **CONFIRMED** |
| 3 | `l237_ray_certificate`, `l237_ray_ceiling`, `l237_ray_bare` | **CONFIRMED** |
| 4 | Ky Fan (`kyFan_sum_le`, `kyFan_eigen`, `bessel_bilin`) | **CONFIRMED** |
| 5 | Root slots (`slot_plus`, `slot_plus2`, `slot_minus`, `slot_minus2`, `slot_kernel`, `slot_null1`, `slot_null2`) | **CONFIRMED** |
| 6 | Reduction (`exists_c_topSum`, `rowSum_le_of_slotSets`) | **CONFIRMED** |
| 7 | `graph_load`, `counts_bound` and their helpers | **CONFIRMED** |
| 8 | `slot_set_bound`, `kappa_cap`, `inner2_X_X`, `kappa_cap_norm` | **CONFIRMED** |
| 9 | Packaging (`inner2Form`, `negAdSq`, `inner2_negAdSq`) | **CONFIRMED** |
| 10 | `L31_cap_unit` gives $\kappa_1\le2$, sharper than 3 | **CONFIRMED** |
| 11 | Owed list complete against the record | **CONFIRMED WITH GAPS** (G1) |
| 12 | Eight files exist, imported, standard three | **CONFIRMED** |
| 13 | KyFanBracketCap header edit | **CONFIRMED**, one cosmetic note (G4) |
| 14 | L52.lean `diagonal_locus_proper` docstring edit | **CONFIRMED WITH GAPS** (G2) |
| 15 | L52 row "the block's remarks" | **CONFIRMED** |
| 16 | No sentence of the row false against the record or the Lean | **CONFIRMED**, with the record-side note G3 |

One line: the row is faithful and every file is clean, and the three gaps are one unowed numeric comparison, one uncarried inference in the L52 docstring and row, and one record statement still missing $n\ge4$.

## Attack line 1: statement fidelity

The record's statement, quoted verbatim from [second-order.md:232](../findings/second-order.md#L232) as it stands at HEAD (after 2ebfa28b): "For a unit $X_0$ and orthonormal $X_1,\dots,X_r$ in $\mathfrak{so}(n)$, $\sum_{j}\lVert[X_0,X_j]\rVert^2\le\kappa_r$, the largest sum of $r$ top eigenvalues of $-\mathrm{ad}_X^2$ over unit $X$, and $\kappa_1,\kappa_2=2,4$, with $\kappa_4,\kappa_6=6,8$ for $n\ge6$ ($\kappa_4=4$ at $n=4$ and $3+\sqrt5$ at $n=5$). **Corollary.** In class variables, $\sum_br_bP_{ab}\le\kappa_{\sum r_b}$; [L173](bounds-relaxations.md)'s witness violates it, and along L173's spectral ray the rows with one such cap give $\theta\le\tfrac{83\sqrt{21}}{294}\approx1.29372$ exactly, independent of $n$."

- **Pairing.** `inner2 X Y = (1/2) tr(Xᵀ Y)` ([WeylReal.lean:39](../lean/HamiltonsCubic/Base/WeylReal.lean#L39), the `RealLayer` definition the L237 files open), which is $-\tfrac12\mathop{\mathrm{tr}}XY$ on skew matrices, the record's convention. `br X Y = X Y − Y X`.
- **Nineteen bounds** ([KyFanBracketCap.lean:25](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean#L25) onward). I counted nineteen `slot3_*` theorems and checked the class count by hand: six with no loop and no $\pm$ pair, two with a $\pm$ pair, seven with one loop (a $P_3$ with the loop at centre, end or off, $2K_2$ with it on or off, a $\pm$ pair with it on or off), three with two loops, one with three. Each conclusion is the polynomial `slot sum ≤ 4 Σ s²` over the angles touched. The row claims the bounds and says the enumeration is in the file, which is what the Lean holds.
- **Ray certificate** ([L237RayCertificate.lean:28](../lean/HamiltonsCubic/Results/L237RayCertificate.lean#L28)). Hypotheses (B₀), (C₀), the cap and nonnegativity of $K$ and the $t$'s, conclusion $u\le-\tfrac{15}7+\tfrac{16}{21}\kappa$. The row's "from rows (B₀), (C₀) at L173's ray and one six-partner cap" names hypotheses, and the derivation of those rows from L104 is owed. `l237_ray_ceiling` is $83/21$ and `l237_ray_bare` is $7$, as the row says. The argument `t0KK` is unused, which is harmless.
- **`kappa_cap_norm`** ([L237SlotCounts.lean:212](../lean/HamiltonsCubic/Results/L237SlotCounts.lean#L212)). Real skew $X$, $r\ge1$, skew $y_j$ with `inner2` Gram the identity, conclusion $\sum_j\lVert[X,y_j]\rVert^2\le(r+2)\langle X,X\rangle$. No normal form and no orthogonality to $X$ assumed, so it is at least as general as the record's first clause with $\kappa_r$ replaced by $r+2$. With `L31_cap_unit` ([L31Statement.lean:452](../lean/HamiltonsCubic/Results/L31Statement.lean#L452)), unit $X,Y$ give $\lVert[X,Y]\rVert^2\le2$, the four upper bounds $2,4,6,8$ follow.
- **`kappa_cap`** (:185). Its hypotheses are `X = O N.X Oᵀ` with `O` orthogonal, conclusion in $\sum_cs_c^2$. The row says exactly this.
- **Ky Fan.** `kyFan_sum_le` ([KyFanPrinciple.lean:46](../lean/HamiltonsCubic/Results/KyFanPrinciple.lean#L46)) is the dual form $\sum_jx_j^{\mathsf T}Mx_j\le rc+\sum_k\max(\lambda_k-c,0)$ and calls `bessel` (:76). `kyFan_eigen` (:122) takes a symmetric positive bilinear form, an orthonormal eigenbasis and a span hypothesis per $y_j$, which is what "against any explicit orthonormal eigenbasis" means.
- **Root slots** ([RootSlots.lean:44](../lean/HamiltonsCubic/Results/RootSlots.lean#L44) to :143). The four $(s\pm t)^2$ eigenvectors, `slot_kernel` with $w$ off both blocks at $s^2$, and the two null slots, each with the six distinctness hypotheses. Matches the row sentence for sentence.
- **Reduction and graph lemma.** `exists_c_topSum` ([L237Cap.lean:26](../lean/HamiltonsCubic/Results/L237Cap.lean#L26)) uses `Finset.exists_max_image`, the maximal $r$-set. `rowSum_le_of_slotSets` (:81) is the row's statement. `graph_load` ([L237GraphLoad.lean:117](../lean/HamiltonsCubic/Results/L237GraphLoad.lean#L117)) assumes `f i ≠ g i` (loopless) and `(par f g i).card ≤ 2`, sums over touched vertices. `counts_bound` (:251) has $P,M\le2$ and total at most $r$. The helpers `amgm`, `deg_other_le`, `load_le`, `pair_split`, `pair_regroup`, `sum_edges`, `edges_par`, `slotCls`, `slotμ_eq_val`, `cls_card_le_two` all exist.
- **Packaging** ([KyFanPackaging.lean:22](../lean/HamiltonsCubic/Results/KyFanPackaging.lean#L22) to :46). `inner2Form_symm`, `inner2Form_pos` and `inner2_negAdSq` as the row says.

## Attack line 2: owed-list completeness

Clause by clause through [second-order.md:228-240](../findings/second-order.md#L228):

- $\kappa_r$ as a supremum: owed. Upper bounds: proved. Attainment at $r=1,2,4,6,2k$ with their $n$: owed, and the row's ranges ($n\ge4$ for $r=1,2$, $n\ge6$ for $r=4,6$, $n\ge2k+2$) agree with the corrected record. The doubled triangle at $r=6$ is the $n\ge6$ witness for $\kappa_6\ge8$, so it is inside that owed item.
- Corollary in class variables, the cap $3P_{00}+3P_{02}\le\kappa_6$: owed. Witness violation at L173's $T$: owed, and the row says `l173_row_exceeds` is $8<12$ alone. Rows (B₀), (C₀) from L104: owed. Closed form and exactness: owed. Independence of $n$: carried by `l237_ray_certificate` with $K\ge0$ free.
- Proof paragraph: Ky Fan, root slots and multiplicity two (L240's slot basis), the three-slot bound: proved. The dual certificate: proved. The cap feeding it: owed as above.
- Uniform proof: the spectrum list, opposite-sign pairs, the load bound and the $(r+2)$ sum: proved (`pair_split`, `load_le`, `counts_bound`, `slot_set_bound`). Strictness at odd $r$ and the values below $n=r+2$: owed.
- What it does: the $7.724$ threshold: owed.
- **G1, unowed.** "still above $\sqrt{3/2}$" ([INDEX-results.md:236](../findings/INDEX-results.md#L236)) and "The caps remove L173's witness point but not its spectrum" ([second-order.md:238](../findings/second-order.md#L238)) rest on $\tfrac{83\sqrt{21}}{294}>\sqrt{3/2}$, which is neither declared nor on the owed list. The owed "closed form $83\sqrt{21}/294$ and its exactness" does not name the comparison. It is one `nlinarith` line once the closed form is declared: $(83\sqrt{21}/294)^2=144669/86436\approx1.6737>1.5$ (hand arithmetic, a screen). Fix: append "and its excess over $\sqrt{3/2}$" to that owed item.

## Attack line 3: files, imports, axioms

- All eight row files exist, plus L240SlotBasis, L240NormalForm and L31Statement named in the row text. All eleven are imported ([HamiltonsCubic.lean:430](../lean/HamiltonsCubic.lean#L430), :679-680, :697-699, :737-742).
- `python3 scripts/misc/axiom_audit.py --only <File>` run in the background on each (a seconds-scale check on objects in hand): KyFanBracketCap 23/23, L237RayCertificate 3/3, L237SlotCounts 11/11, L237Cap 3/3, L237GraphLoad 14/14, KyFanPrinciple 4/4, RootSlots 13/13, KyFanPackaging 4/4, L31Statement 26/26, and the L52 files 103/103, all on propext, Classical.choice, Quot.sound. No `sorry` in any of the eight row files (grepped).

## Attack line 4: the header and docstring edits

- **KyFanBracketCap header** ([KyFanBracketCap.lean:19-20](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean#L19)). "Ky Fan's maximum principle is KyFanPrinciple.lean's `kyFan_sum_le` and the root slots are RootSlots.lean and L240's slot basis; the list of configurations is by hand." True: the principle is proved there, the slots are proved there, and the completeness of the nineteen-class enumeration is a hand argument in the section heading. **G4 (cosmetic).** The bullet sits under "What is typed here" while naming declarations of other files, and the cap's actual route is `kyFan_eigen` through `slot_kyFan` and `kyFan_conj`, with `kyFan_sum_le` a sibling. Pre-existing and outside the edit, the docstrings of `slot3_pm_edge` and `slot3_path_loop` name the maxima $2+\sqrt2$ and $2+\sqrt3$, while the theorems prove only $\le4$.
- **L52.lean `diagonal_locus_proper`** ([L52.lean:104-108](../lean/HamiltonsCubic/Results/L52.lean#L104)). The theorem is the rational inequality $12n(n-2)<n(n+1)(n+2)(n-3)$ for $n\ge5$. **G2.** The docstring says the diagonal family is a proper subvariety of dimension at most $n(n-2)$, "so the region away from the family ... has interior". The dimension of the coordinate-diagonal locus, its being a subvariety, and the interior are none of them declared, and the L52 row repeats "so the region away from the diagonal family has interior" beside "Kernel-checked" with no owed item for them (I read the L52 row's owed list at [lean/INDEX.md:385](../lean/INDEX.md#L385) in full). The record ([bispectral.md:86](../findings/bispectral.md#L86)) uses "away from the family" for where the bound can be weak and never asserts an interior. Fix: phrase the docstring and row as "the dimension count behind ...", and owe the locus dimension and the openness, or drop the inference.
- **L52 row "the block's remarks".** Eight declarations follow, and the header count r1681 flagged is no longer asserted. Correct.

## Attack line 5: false sentences

None in the row against the Lean or the record at HEAD. **G3 (record, routed to the research loop, armed in this session).** 2ebfa28b repaired r1681's GB6 for $\kappa_4,\kappa_6$ but left "$\kappa_1,\kappa_2=2,4$" with no $n$. At $n=3$ with $X=\varphi_{12}$ unit, $-\mathrm{ad}_X^2$ has eigenvalues $1,1,0$ on $\mathfrak{so}(3)$, so $\kappa_1=1$ and $\kappa_2=2$ (hand derivation). The row's owed attainment already says $n\ge4$, so the row is right and the record is the one to fix: "$\kappa_1,\kappa_2=2,4$ for $n\ge4$". The INDEX-results Lean cell for L237 ("all nineteen configuration bounds") also trails the row, since the cap is proved.

## What would break the row, and what was done

- **A skew $X$ and orthonormal $y_j$ with $\sum\lVert[X,y_j]\rVert^2>(r+2)\langle X,X\rangle$.** Excluded by `kappa_cap_norm` unless the pairing or bracket differ from the record's, so I read `inner2` and `br` and checked the hypotheses carry no hidden normal form, dimension or orthogonality condition.
- **A mismatch between the certificate's (B₀), (C₀) and L173's actual rows.** Cannot be checked in Lean because the derivation is owed, and the row says so.
- **A configuration class missed by the nineteen.** Recounted by hand, and it no longer carries the cap, which goes through `slot_set_bound`.
- **An import or axiom hole.** Grepped the import list and ran the axiom audit on every cited file.
- **$n=3$** breaks the record's $\kappa_1,\kappa_2$, not the row (G3).

## Gaps

- **G1.** $\tfrac{83\sqrt{21}}{294}>\sqrt{3/2}$ is neither declared nor owed in the L237 row.
- **G2.** `diagonal_locus_proper`'s docstring and the L52 row infer a locus dimension and an interior that no declaration proves and no owed item carries.
- **G3.** The record's $\kappa_1,\kappa_2=2,4$ needs $n\ge4$, and INDEX-results' L237 Lean cell is stale.
- **G4 (cosmetic).** KyFanBracketCap's header bullet names other files under "What is typed here", and two pre-existing docstrings name maxima the theorems do not prove.
