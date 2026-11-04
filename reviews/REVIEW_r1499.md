# Review r1499: L178 steps 4 and 5 in Lean, θ = 9 det B and θ² ≤ 3/2 on Λ^± at n = 4

Gate 2 review of commit bdafbab0: the new [Results/L178Theta.lean](../lean/HamiltonsCubic/Results/L178Theta.lean) (`tr3`, `det3`, `cofB`, `sharpMat_Rp`, `Pcubic_Rp`, `normSq_Rp`, `sharpMat_Rm`, `Pcubic_Rm`, `normSq_Rm`, `Bm`, `disc_nonneg`, `L178_theta_sd`, `L178_theta_asd`) on top of [Results/L178Sharp.lean](../lean/HamiltonsCubic/Results/L178Sharp.lean) and [Base/Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean), and the record edits ([lean/INDEX.md](../lean/INDEX.md) line 70, [diagonal-half.md](../findings/diagonal-half.md) lines 607 and 613). One reviewer. Analysis-only rule inherited: the only compute was the module build (8709 jobs, "Build completed successfully", no warning from L178Theta.lean) and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | `Pcubic` at unit norm is the record's θ, `(Rᵀ R).trace` is its $\lVert W\rVert^2$, $P^2\le\tfrac32\lVert R\rVert^6$ is the homogeneous form of $\lvert\theta\rvert\le\sqrt{3/2}$, and `det3` at $f=-a-d$ is the trace-free block's determinant | CONFIRMED |
| B | `sharpMat_Rp`/`Rm`, `Pcubic_Rp`/`Rm`, `normSq_Rp`/`Rm`, `disc_nonneg` and the ℝ→ℚ cast are sound, with no hypothesis unused or missing | CONFIRMED |
| C | no edited sentence overstates | CONFIRMED WITH GAP |
| D | all declarations rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: with the layer's own `Pcubic` and `sharpMat`, an operator with trace-free symmetric block $B$ on $\Lambda^\pm$ has $P(R)=9\det B$ and $P(R)^2\le\tfrac32\lVert R\rVert^6$, which at unit norm is diagonal-half.md's $\theta=9e_3$ and $\lvert\theta\rvert\le\sqrt{3/2}$. The discriminant is proved as a Gram determinant whose closed form checks by hand. 9/9 declarations on the standard three axioms. r1498's C-1 is repaired in the INDEX row. Gap C-1: diagonal-half.md line 613 says "Steps 4 and 5 are kernel-checked" with no scope, while the Lean covers rational blocks in `Fin 6` coordinates and not step 5's equality clause, both of which the INDEX row lists as owed. CONFIRMED WITH GAP.**

## A. Fidelity

- **`Pcubic` is the record's θ.** Sharp.lean line 97 defines $P(R)=\mathop{\mathrm{tr}}(R^{\mathsf T}Q(R))$ with $Q=R^2+R^\#$, and its docstring places the $\tfrac12$ at the $\Lambda^2$ level (in `sharpQF`, whose normalisation is fixed by `sharpQF_one_basis`, $\mathrm{Id}^\#=2\,\mathrm{Id}$ at $n=4$, the record's anchor). r1498 A established that `basis4` is orthonormal for `inner2`, so the $6\times6$ coordinate Frobenius pairing is the operator-level pairing. For symmetric $R$, $\mathop{\mathrm{tr}}(R^{\mathsf T}Q)=\mathop{\mathrm{tr}}R^3+\langle R,R^\#\rangle$, the record's $\theta=\mathop{\mathrm{tr}}(W^3)+\langle W,W^\#\rangle$ at $\lVert W\rVert=1$. **Faithful.**
- **`(Rᵀ R).trace` is $\lVert W\rVert^2$.** `Rp` $=\sum B_{ij}u_iu_j^{\mathsf T}$ with $u_i=w_i/\sqrt2$ orthonormal (r1498 A), so $\mathop{\mathrm{tr}}(R^{\mathsf T}R)=\mathop{\mathrm{tr}}B^2=a^2+d^2+f^2+2(b^2+c^2+e^2)$, the right side of `normSq_Rp`. Same normalisation as the record's $p_2$. **Faithful.**
- **The homogeneous form.** $P$ is cubic and $\lVert R\rVert^2$ quadratic, so $P^2\le\tfrac32\lVert R\rVert^6$ is scale-invariant and at $\lVert R\rVert=1$ reads $\theta^2\le\tfrac32$, that is $\lvert\theta\rvert\le\sqrt{3/2}$. This is the sign-closed statement, stronger than the one-sided $\theta\le\sqrt{3/2}$ the docstrings and the record state, which it implies. The arithmetic matches the record: $81(\det B)^2\le\tfrac{81}{54}p_2^3=\tfrac32p_2^3$, and $9\cdot\tfrac1{3\sqrt6}=\sqrt{3/2}$. **Faithful.**
- **`tr3`, `det3`, `cofB`.** `det3` is the cofactor expansion of symmetric $[[a,b,c],[b,d,e],[c,e,f]]$. `tr3` is $\sum_{ijk}B_{ij}B_{jk}B_{ki}$: three cyclic placements for each off-diagonal square ($3b^2(a+d)$ and so on) and six permutations for $bce$. `cofB` has $C_{00}=df-e^2$, $C_{01}=ce-bf$, $C_{02}=be-cd$, $C_{12}=bc-ae$, the same entries as L178Sharp.lean's `cofQF`, and is the adjugate since $B$ is symmetric. At $f=-a-d$ the block is trace-free and `det3` is its determinant. **Correct.**
- **Step 4's chain.** With $R^\#=2U\mathop{\mathrm{cof}}(B)U^{\mathsf T}$, $\mathop{\mathrm{tr}}(R\,R^\#)=2\mathop{\mathrm{tr}}(B\mathop{\mathrm{adj}}B)=6\det B$, and Newton at $e_1=0$ gives $\mathop{\mathrm{tr}}B^3=3\det B$, so $P=9\det B$, the record's $3e_3+6e_3$. **Faithful. CONFIRMED.**

## B. Soundness

- **`sharpMat_Rp`.** `sharp_sd` gives the form $4x^{\mathsf T}Cx$ with $x=W\eta/2$, $W$ the $3\times6$ matrix of rows `wp i`, which is $\eta^{\mathsf T}W^{\mathsf T}CW\eta$. `sharpMat` is the polarisation of `sharpQF` (diagonal the form at $e_a$, off-diagonal $\tfrac12(Q(e_a+e_b)-Q(e_a)-Q(e_b))$), and for a quadratic form with symmetric matrix $M$ this recovers $M$ exactly, so the 36 entries equal $\sum_{ij}C_{ij}w_{ip}w_{jq}$. The statement is elaborated before the tactic block, so the `fin_cases`/`norm_num`/`ring` script can only close it or fail. The Rm version is identical with `wm` and `sharp_asd`.
- **`Pcubic_Rp`, `normSq_Rp`.** Symbolic trace expansions over `Fin.sum_univ_six`, closed by `norm_num` and `ring`, each checked by hand in A. Rm versions likewise.
- **`disc_nonneg`.** The Gram vectors are $I$, $B$, $B^2$ flattened into `EuclideanSpace ℝ (Fin 3 × Fin 3)`, so the Gram entries are Frobenius pairings. With $p=\mathop{\mathrm{tr}}B^2$, $t=\mathop{\mathrm{tr}}B^3=3\det B$ and $s=\mathop{\mathrm{tr}}B^4=p^2/2$ (Cayley–Hamilton at $e_1=0$), the Gram matrix is $[[3,0,p],[0,p,t],[p,t,s]]$ with determinant $3(ps-t^2)-p^3=\tfrac12p^3-27(\det B)^2=\tfrac12(p^3-54\det^2)$, which is what the closing `linarith` needs. The identity $s=p^2/2$ holds only on the trace-free block, which `Bm` builds in by $f=-a-d$, so no hypothesis is missing. `posSemidef_gram` and `PosSemidef.det_nonneg` are Mathlib's, and `det_fin_three` expands the determinant.
- **The cast.** `disc_nonneg` is stated over ℝ at `(a : ℝ) …`, and `exact_mod_cast` moves the polynomial inequality to ℚ, which is sound since the cast ℚ→ℝ is an order embedding and a ring homomorphism. The closing `nlinarith [hd]` needs only $81\det^2=\tfrac32\cdot54\det^2$, a linear step in the product terms.
- **Hypotheses.** None are unused: the theorems are universally quantified over the block entries with symmetry and trace-freeness built into the parametrisation. **CONFIRMED.**

## C. Record accuracy

- **lean/INDEX.md line 70.** "Steps 4 and 5 are PROVED" with `sharpMat_Rp`, `Pcubic_Rp`, `disc_nonneg`, `L178_theta_sd`/`asd` matches the file. The owed clause now names the bridge between `Biv 4` over ℝ and `Matrix (Fin 6) (Fin 6) ℚ` (the `Pairs 4` ↔ `Fin 6` identification and ℚ→ℝ), the padding (step 3), and the equality clause. **r1498's C-1 is repaired.** The row stays **partial**. No overstatement.
- **diagonal-half.md line 607.** "supplied by r771 at audit, and its conclusion at $n=4$ is kernel-checked with the layer's own $\#$ as `sharp_sd`" is accurate: `sharp_sd` at $B=I$ gives $(P^+)^\#=2P^+$, the sentence's conclusion. Note, not a gap: the $P^-$ half is `sharp_asd`, unnamed, and the sentence's additivity argument is still not itself audited, which the new wording no longer mentions and also does not deny.
- **Gap C-1: diagonal-half.md line 613, "Steps 4 and 5 are kernel-checked", has no scope.** The Lean proves the inequality for blocks with rational entries on `Fin 6` coordinates built from `wp`/`wm`. The record's $W$ is real and arrives from step 1's `Biv 4` carrier, and step 5 includes the equality clause (repeated root, $\mathbb{CP}^2$'s spectrum), which the file does not check. The INDEX row lists both as owed, and the findings sentence says neither. Suggested repair: "The inequality of steps 4 and 5 is kernel-checked … for rational blocks in `basis4` coordinates. The bridge to step 1's carrier and the equality clause are owed (lean/INDEX.md's L178 row)." **CONFIRMED WITH GAP.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L178Theta`: "auditing 9 declarations across 1 files, 9/9 clean -- resting on the standard three alone".
- The build reports no warning from L178Theta.lean. **CONFIRMED.**

## E. Style

- The commit's added lines carry no em dash (grep count 0) and no backticks inside link text (grep for ``[` `` count 0).
- The semicolons in the L178 row separate items of comma-bearing lists, the permitted use.
- lean/INDEX.md line 70 and diagonal-half.md lines 607 and 613 are single lines. The Lean header wraps inside a `.lean` comment block, outside the markdown rule. **CONFIRMED.**

## Overall

**CONFIRMED WITH GAP.** `L178_theta_sd` and `L178_theta_asd` prove diagonal-half.md's Lemma L178 steps 4 and 5 at $n=4$ with the layer's own $P$ and $\#$: for a trace-free symmetric block $B$ on $\Lambda^\pm$, $P(R)=9\det B$ and $P(R)^2\le\tfrac32\lVert R\rVert^6$, the sign-closed form of $\theta\le\sqrt{3/2}$ at unit norm. The Gram-determinant discriminant is correct. 9/9 declarations on the standard three axioms, and r1498's C-1 is repaired. Gap C-1 (diagonal-half.md line 613): "Steps 4 and 5 are kernel-checked" omits that the check is over rational blocks in `Fin 6` coordinates and excludes the equality clause, both owed per the INDEX row. Notes, not gaps: the Lean proves $\lvert\theta\rvert$ bounded, stronger than the stated one-sided bound, and line 607 names `sharp_sd` without `sharp_asd`.
