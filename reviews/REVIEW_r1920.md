# REVIEW r1920: B12 step 4, the pair sectors of tr(L_e^2)

*Gate 2 review of [B12Pair.lean](../lean/HamiltonsCubic/Results/B12Pair.lean) (92d10aec), [B12PairTrace.lean](../lean/HamiltonsCubic/Results/B12PairTrace.lean) (dee4e397) and [B12PairSector.lean](../lean/HamiltonsCubic/Results/B12PairSector.lean) (51e65f75). Every main theorem was re-derived by hand from the definitions, and the sphere-product value was computed by hand for both pair types and matched against Lemma L127's table. Analysis only: the one run was the prefix-matched axiom audit.*

| # | Claim | Verdict |
|---|---|---|
| 1 | Bmap is L122's pair block, and Lop_pairMap follows from foxProd_pairVec with the row convention Lb m i | CONFIRMED |
| 2 | colSum_Lb: each column of Lb over S sums to -w_jk/2 at a weight | CONFIRMED |
| 3 | trace_B2_Pcut: tr(B^2 on the Ricci cut) = sum Lb^2 - w_jk^2/4 | CONFIRMED WITH OBSERVATIONS |
| 4 | trace_pair_sector, with mem_range_projS_pair, pairEquiv and the basis transport | CONFIRMED |
| 5 | Sphere-product values agree with L127's cross and within rows | CONFIRMED |
| 6 | Axiom audit, all three files | CONFIRMED (28/28 clean) |

**Summary: step 4 is correct as stated, the hand values at the sphere product reproduce L127's full cross-factor and within-factor spectra with multiplicities, and the one observation is that the nonemptiness hypothesis on S is stronger than needed.**

## 1. Bmap against the record, and Lop_pairMap

- The record's block is (1/2)[diag(M_ji + M_ki) - M_jk Id + M^(jk)] on the indices outside {j, k}. [L122Statement.lean](../lean/HamiltonsCubic/Results/L122Statement.lean) defines Lb i m as (1/2)(M j i + M k i - M j k) on the diagonal and (1/2) M i m off it. The two agree entry by entry, and M^(jk) being the hollow restriction matches because w is hollow (Lb_split uses hw.hollow to absorb the diagonal of (1/2)w).
- Bmap w j k c m is the sum over i in S of Lb m i c_i for m in S, and 0 off S. That is Lb acting on coefficient columns, row index m, which is the convention of [foxProd_pairVec](../lean/HamiltonsCubic/Results/L122Cap.lean): M o (sum c_i f_i) = sum_m (sum_i Lb m i c_i) f_m.
- Lop_pairMap: Lop_spec reduces L_{diagW w} to the Fox product on skew arguments, foxProd_congr_on_skew swaps diagW and pairMap for diagOp and pairVec on skew inputs, foxProd_pairVec evaluates, and pairVec_congr replaces the coefficient function by Bmap c, since pairVec reads coefficients only on S. The chain is complete and hw.symm, hw.hollow are the hypotheses foxProd_pairVec asks for.
- The convention question is moot at a weight in any case: Lb_symm proves Lb m i = Lb i m from w symmetric.

## 2. colSum_Lb by hand

For i in S, sum_{m in S} Lb_{mi} = (1/2) sum_{m in S} w_mi + (1/2)(w_ji + w_ki - w_jk). Symmetry and the zero row sum at i give sum_{m in S} w_mi = sum_m w_im - w_ij - w_ik = -w_ji - w_ki (the m = i term is w_ii = 0 and sits inside the full sum). The total is (1/2)(-w_ji - w_ki + w_ji + w_ki - w_jk) = -w_jk/2. The Lean proof spends exactly these three facts (hollow via Lb_split, symm, deleted_row_sum from rowSum).

## 3. trace_B2_Pcut by hand

- B := Lb on R^S is symmetric (Lb_symm), so its row sums equal its column sums, and B 1_S = -(w_jk/2) 1_S (Bmap_oneS). The Ricci cut is 1_S's orthogonal complement in R^S, B-invariant by symmetry. So tr(B^2 on cut) = tr(B^2 on R^S) - (w_jk/2)^2 = sum_{m,i in S} Lb_{mi}^2 - w_jk^2/4, the Frobenius identity tr(B^2) = sum B_{mi}^2 holding by symmetry.
- The Lean route computes the standard-basis diagonal of B^2 Pcut directly: for m in S, (B^2 e_m)_m - (1/|S|)(B^2 1_S)_m = sum_i Lb_{mi}^2 - (1/|S|) w_jk^2/4, summed over |S| indices. This agrees with the hand value. Pcut is the orthogonal projection onto the cut extended by 0 off S, and mem_range_Pcut identifies its range with ker blockSums1, which is the cut as L120PairDim defines it.
- **Observation, the hypothesis.** (Sset j k).Nonempty is used only through card_ne, to divide by |S|. It holds automatically once n >= 3 and j != k. At n = 3, S is one index i, the cut is 0, and a weight on three indices is forced to vanish (rows give w_ji = -w_jk, w_ki = -w_jk, w_ij + w_ik = 0, hence w_jk = 0), so both sides are 0. At n = 2 the set is empty, a weight is again 0, and the formula would also read 0 = 0 with Lean's x/0 = 0 convention. So the hypothesis is harmless and slightly stronger than necessary. It could be discharged from n >= 3 once, rather than carried by every caller.

## 4. trace_pair_sector

- **Statement.** The trace over weylModuleS of (L_e o L_e) o projS {j, k}, at e = diagW w for any weight w, equals sum Lb^2 - w_jk^2/4. This is the pair-sector term that B12's sector-by-sector sum needs, in L_M units (Lop is the bare Fox product, no division by theta).
- **mem_range_projS_pair.** pairSummand_mem_signMat characterises pairMap of the cut as the elements of weylModuleS on which every sign matrix acts by eps_j eps_k. setChar_pair makes that the character of {j, k}. Forward, proj_signMat gives the character on range projS. Backward, proj_of_char gives projS Y = Y for Y of that character. Sound.
- **pairEquiv.** Injectivity reads c_y off coord j y k y through coord_pairS_diag for y in S, and both vectors vanish off S by membership of the cut. Surjectivity is the backward direction above. Both are complete.
- **Basis transport.** trace_sector_restrict rewrites the left side as the trace of the restriction to range projS, trace_B2_cut rewrites the right as the trace of the restriction to range Pcut. hkey is the conjugation identity restrict(L^2)(psi v) = psi(restrict(B^2) v), from Lop_pairMap applied twice with Bmap_mem keeping the second argument in the cut. Computing the left trace in the basis psi(b) and the right one in b gives identical matrices. The argument is the standard similarity invariance of trace, and it is sound.

## 5. The unit sphere product, by hand

Take w = t sphereWeight T with |T| = p, n - p = q, p, q >= 2, t > 0, so alpha = tq/(p-1) inside T, beta = tp/(q-1) outside, gamma = -t across, and theta = t(n-1).

**Cross pair, j in T, k outside T.** S = A u B with A = T \ j (size p-1) and B = T^c \ k (size q-1). Diagonal entries: on A, (1/2)(alpha + gamma - gamma) = alpha/2, on B, beta/2. So Lb = (1/2)[alpha J_AA, gamma J_AB; gamma J_BA, beta J_BB], rank 2.
- Sum-zero vectors within A and within B: eigenvalue 0, multiplicity (p-2) + (q-2) = n-4.
- On span{1_A, 1_B}: 1_S has eigenvalue -gamma/2 = t/2 (the excluded direction), and the trace of the 2x2 action is (1/2)(alpha(p-1) + beta(q-1)) = tn/2, so the other eigenvalue is t(n-1)/2 = theta/2.
- Cut spectrum {theta/2 once, 0^(n-4)}, total n-3. This is L127's cross row times theta (L_M units). The trace value is theta^2/4. Direct check: sum Lb^2 - w_jk^2/4 = (t^2/4)[q^2 + p^2 + 2(p-1)(q-1) - 1] = (t^2/4)(p+q-1)^2 = theta^2/4.

**Within pair, j, k in T.** S = A u B with A = T \ {j, k} (size p-2) and B = T^c (size q). Diagonal: on A, (1/2)(alpha + alpha - alpha) = alpha/2, on B, (1/2)(2 gamma - alpha) = gamma - alpha/2. So Lb = (alpha/2) J on A, (beta/2) J_B + c I on B with c = gamma - alpha/2 - beta/2, and (gamma/2) J across.
- Sum-zero within A: eigenvalue 0, multiplicity p-3.
- Sum-zero within B: eigenvalue c. Clearing denominators, -2(p-1)(q-1)c/t = 2(p-1)(q-1) + q(q-1) + p(p-1) = (n-1)(n-2), so c = -mu theta with mu = (n-2)/(2(p-1)(q-1)). Multiplicity q-1.
- On span{1_A, 1_B}: 1_S at -alpha/2 excluded, and the other eigenvalue is (alpha/2)(p-2) + (beta/2)(q-1) + gamma = t(p-2)(n-1)/(2(p-1)) = lambda_p theta with lambda_p = (p-2)/(2(p-1)). Multiplicity 1, present when A is nonempty (p >= 3).
- Cut spectrum {lambda_p theta, (-mu theta)^(q-1), 0^(p-3)}, total n-3, and the trace value is theta^2 [lambda_p^2 + (q-1) mu^2]. This is the record's box "the whole within-factor spectrum is {lambda_p, (-mu)^(q-1), 0^(p-3)}" in L_e units. At p = 2 the lambda_p direction is absent and the block is (-mu theta)^(q-1) alone, which is the record's own p = 2 warning, and the trace formula still holds since lambda_2 = 0. The within-complement family follows by swapping p and q.

The Lean theorem computes the trace only, so this comparison confirms consistency of the value with L127's multiplicities. The spectra above are the hand derivation that supports it.

## 6. Axiom audit

`python3 scripts/misc/axiom_audit.py --only B12Pair`, run in the background: "auditing 28 declarations across 3 files, 28/28 clean, resting on the standard three alone" (propext, Classical.choice, Quot.sound). No sorry, no project axiom.

## 7. Falsifiers, and what I did to look

- **colSum_Lb** would fail at a weight with a column of Lb over S summing to anything other than -w_jk/2, which is excluded by the three-line derivation in section 2. I checked that the diagonal term w_ii is inside the row sum and vanishes by hollowness.
- **Lop_pairMap** would fail if foxProd_pairVec carried the transpose convention at a non-symmetric w or if pairVec read coefficients off S. I read both definitions: pairVec sums over the filter set equal to Sset, and Lb is symmetric at a weight.
- **trace_B2_Pcut** would fail if 1_S were not a B-eigenvector or the cut were not B-invariant. Both follow from symmetry plus the row sum. I tested the degenerate ends n = 3 and n = 2 by hand, and both sides are 0.
- **trace_pair_sector** would fail if range projS {j, k} were larger than pairMap of the cut, for instance by capturing four-set or diagonal vectors of the same character. The character eps_j eps_k is carried by no four-set block (character a product over four indices) and by no diagonal vector (trivial character), and pairSummand_mem_signMat proves the equality outright. I checked the injectivity coordinate j y k y for y in S.
- **The sphere value** would contradict L127 if the cross block gave anything other than theta^2/4 or the within block anything other than theta^2[lambda_p^2 + (q-1) mu^2]. Both came out equal by exact algebra in section 5, and the dimension count n-3 closes in both cases.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** All seven checks pass. The single observation is that (Sset j k).Nonempty is implied by n >= 3 and could be discharged once, and the theorem remains true without it at n = 2 because a weight vanishes there. Nothing needs repair.
